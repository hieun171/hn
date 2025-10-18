//
//
//
//
//
//// server.js (DEV version — keep your original logic, add logout + rate limit + helpful comments)
// ============================================================
// server.js - Full app with local + Railway Postgres
// ============================================================

/// server.js (DEV version — keep your original logic, add logout + rate limit + helpful comments)
// ------------------------------------------------------------------
// Purpose: Development-friendly version of your app. Not hardened for production.
// When ready to go-live, follow the "GO-LIVE CHECKLIST" comments at the bottom.
// ------------------------------------------------------------------

// ============================
// Production-ready Express server
// ============================

// ============================
// server.js
// Full working setup for local dev & Railway
// ============================
// index.js - Unified Local/Production Postgres setup with full app
import express from "express";
import bodyParser from "body-parser";
import pg from "pg";
import bcrypt from "bcrypt";
import session from "express-session";
import passport from "passport";
import { Strategy } from "passport-local";
import dotenv from "dotenv";
import path from "path";
import { dirname } from "path";
import { fileURLToPath } from "url";
import rateLimit from "express-rate-limit";
import flash from "connect-flash";
import cron from "node-cron";

// Load environment variables
dotenv.config();
const __dirname = dirname(fileURLToPath(import.meta.url));
const port = process.env.PORT || 8080;
//const port = process.env.PORT || 3000;
const saltRounds = 12;
const isProduction = process.env.NODE_ENV === "production";

const app = express();

// ---------- Middleware ----------
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static("public"));
app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));

app.use(
  session({
    secret: process.env.SESSION_SECRET || "dev-secret-change-me",
    resave: false,
    saveUninitialized: true,
    cookie: { maxAge: 1000 * 60 * 60 }, // 1 hour
  })
);

app.use(passport.initialize());
app.use(passport.session());
app.use(flash());
app.use((req, res, next) => {
  res.locals.message = req.flash("error");
  next();
});

const limiter = rateLimit({
  windowMs: 30 * 60 * 1000,
  max: 200,
  standardHeaders: true,
  legacyHeaders: false,
  message: "Too many requests — slow down a bit.",
});
app.use(limiter);

// ---------- Database ----------
const db = new pg.Client(
  isProduction
    ? {
        connectionString: process.env.DATABASE_URL,
        ssl: { rejectUnauthorized: false },
      }
    : {
        user: process.env.PG_USER,
        host: process.env.PG_HOST,
        database: process.env.PG_DATABASE,
        password: process.env.PG_PASSWORD,
        port: process.env.PG_PORT,
      }
);

// ---------- Helper ----------
function isValidPassword(password) {
  const minLength = 8;
  const hasNumber = /\d/;
  const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/;
  const hasUppercase = /[A-Z]/;
  if (!password || typeof password !== "string") return false;
  return (
    password.length >= minLength &&
    hasNumber.test(password) &&
    hasSpecialChar.test(password) &&
    hasUppercase.test(password)
  );
}

const adminEmails = process.env.ADMIN_EMAILS
  ? process.env.ADMIN_EMAILS.split(",").map((e) => e.trim())
  : [];

// ---------- Auth middleware ----------
function ensureAuthenticated(req, res, next) {
  if (req.isAuthenticated()) return next();
  res.redirect("/login");
}

function ensureAdmin(req, res, next) {
  if (req.isAuthenticated() && adminEmails.includes(req.user.email))
    return next();
  res.status(403).render("HN.ejs", {
    message: "Thank you for visiting Hieu Nguyen Page.",
    defaultDate: new Date().toISOString().split("T")[0],
  });
}

// ---------- Passport Strategy ----------
passport.use(
  new Strategy(async (username, password, cb) => {
    try {
      const result = await db.query("SELECT * FROM my_user WHERE email=$1", [
        username,
      ]);
      if (result.rows.length === 0) return cb(null, false);
      const user = result.rows[0];
      bcrypt.compare(password, user.pw, (err, match) => {
        if (err) return cb(err);
        return cb(null, match ? user : false);
      });
    } catch (err) {
      return cb(err);
    }
  })
);

passport.serializeUser((user, cb) => cb(null, user));
passport.deserializeUser((user, cb) => cb(null, user));

// ---------- Connect to DB & start cron ----------
db.connect()
  .then(() => {
    console.log(`${isProduction ? "Railway" : "Local"} Postgres connected ✅`);

    cron.schedule("0 0 * * *", async () => {
      try {
        const result = await db.query(
          `DELETE FROM cliinfo WHERE time < NOW() - INTERVAL '5 days'`
        );
        console.log(`Deleted ${result.rowCount} old record(s).`);
      } catch (err) {
        console.error("Error deleting old records:", err.message);
      }
    });
  })
  .catch((err) => console.error("Postgres connection error:", err));

// ---------- Routes ----------

// Home/About/Contact
app.get("/", (req, res) =>
  res.render("index.ejs", {
    defaultDate: new Date().toISOString().split("T")[0],
  })
);
app.get("/about", (req, res) =>
  res.render("about.ejs", {
    defaultDate: new Date().toISOString().split("T")[0],
  })
);
app.get("/contact", (req, res) =>
  res.render("contact.ejs", {
    defaultDate: new Date().toISOString().split("T")[0],
    thanks: null,
  })
);
app.post("/contact", async (req, res) => {
  const { name, phone, email, communication, text } = req.body;
  try {
    await db.query(
      "INSERT INTO cliinfo (name, phone, email, commu, comment) VALUES ($1,$2,$3,$4,$5)",
      [name, phone, email, communication, text]
    );
    res.render("contact.ejs", {
      defaultDate: new Date().toISOString().split("T")[0],
      thanks: "Thank you for your message",
    });
  } catch (err) {
    console.error(err);
    res.status(500).send("Error saving contact message");
  }
});

// Static/Calculator/Mortgage/Hana/Links
const staticRoutes = [
  { path: "/calculate", view: "calculator.ejs" },
  { path: "/mortgage", view: "mortgage.ejs" },
  { path: "/hana", view: "hana.ejs" },
  { path: "/link", view: "link.ejs" },
  { path: "/anotherlink", view: "anotherlink.ejs" },
  { path: "/otherlink", view: "otherlink.ejs" },
];
staticRoutes.forEach((r) =>
  app.get(r.path, (req, res) =>
    res.render(r.view, { defaultDate: new Date().toISOString().split("T")[0] })
  )
);

// ---------- Signup/Login ----------
app.get("/login", (req, res) =>
  res.render("login.ejs", {
    defaultDate: new Date().toISOString().split("T")[0],
  })
);
app.get("/signup", (req, res) =>
  res.render("register.ejs", {
    errors: {},
    defaultDate: new Date().toISOString().split("T")[0],
    formData: {},
  })
);
app.post("/signup", async (req, res) => {
  const { username: email, password } = req.body;
  const errors = {};
  const formData = { email };
  try {
    const exists = await db.query("SELECT * FROM my_user WHERE email=$1", [
      email,
    ]);
    if (exists.rows.length > 0)
      return res.render("register.ejs", {
        errors: { email: "Email exists" },
        defaultDate: new Date().toISOString().split("T")[0],
        formData,
      });
    if (!isValidPassword(password))
      return res.render("register.ejs", {
        errors: { password: "Password invalid" },
        defaultDate: new Date().toISOString().split("T")[0],
        formData,
      });
    const hash = await bcrypt.hash(password, saltRounds);
    const result = await db.query(
      "INSERT INTO my_user (email,pw) VALUES ($1,$2) RETURNING *",
      [email, hash]
    );
    req.login(result.rows[0], (err) => {
      if (err) return res.redirect("/login");
      res.redirect("/tax");
    });
  } catch (err) {
    console.error(err);
    res.status(500).send("Error signing up");
  }
});

app.post("/login", (req, res, next) => {
  passport.authenticate("local", (err, user) => {
    if (err) return next(err);
    if (!user) {
      req.flash("error", "Invalid username or password.");
      return res.redirect("/login");
    }
    req.login(user, (err) => {
      if (err) return next(err);
      req.session.isAdmin = adminEmails.includes(user.email);
      res.redirect(req.session.isAdmin ? "/mes" : "/tax");
    });
  })(req, res, next);
});

// ---------- Tax/Admin ----------
app.get("/tax", ensureAuthenticated, async (req, res) => {
  try {
    const result = await db.query("SELECT * FROM taxrate_2025 ORDER BY id");
    res.render("tax.ejs", {
      taxData: result.rows,
      defaultDate: new Date().toISOString().split("T")[0],
    });
  } catch (err) {
    console.error(err);
    res.status(500).send("Error loading tax data");
  }
});

app.get("/mes", ensureAuthenticated, async (req, res) => {
  if (!adminEmails.includes(req.user.email))
    return res.status(403).render("denied.ejs", {
      defaultDate: new Date().toISOString().split("T")[0],
      message: "Access denied",
    });
  try {
    const result = await db.query("SELECT * FROM cliinfo ORDER BY id");
    res.render("mes.ejs", {
      mes: result.rows,
      defaultDate: new Date().toISOString().split("T")[0],
    });
  } catch (err) {
    console.error(err);
    res.status(500).send("Error loading data");
  }
});

// ---------- Visitor tracking ----------
app.get("/track-visitor", async (req, res) => {
  try {
    const ip =
      req.headers["x-forwarded-for"] || req.connection.remoteAddress || req.ip;
    const existing = await db.query(
      "SELECT * FROM visitors WHERE ip_address=$1",
      [ip]
    );
    if (existing.rows.length === 0) {
      await db.query(
        "INSERT INTO visitors (ip_address, visited_at) VALUES ($1, NOW())",
        [ip]
      );
      await db.query(
        "UPDATE visits SET total_count=total_count+1, last_updated=NOW() WHERE id=1"
      );
    } else {
      await db.query(
        "UPDATE visitors SET visited_at=NOW() WHERE ip_address=$1",
        [ip]
      );
    }
    res.send("Visitor tracked");
  } catch (err) {
    console.error(err);
    res.status(500).send("Internal server error");
  }
});

// ---------- Logout ----------
app.get("/logout", (req, res, next) => {
  req.logout((err) => {
    if (err) return next(err);
    req.session.destroy(() => {
      res.clearCookie("connect.sid");
      res.redirect("/");
    });
  });
});

// ---------- Global error handler ----------
app.use((err, req, res, next) => {
  console.error("Unhandled error:", err);
  res.status(500).send("Server error");
});

// ---------- Start server ----------
app.listen(port, () => {
  console.log(
    `Server running on port ${port} (${
      isProduction ? "Railway/Prod" : "Local Dev"
    })`
  );
});
