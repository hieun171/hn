--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cliinfo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliinfo (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    phone character varying(15) NOT NULL,
    email character varying(25) NOT NULL,
    commu character varying(100) NOT NULL,
    comment text,
    eventdate date DEFAULT CURRENT_DATE,
    "time" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.cliinfo OWNER TO postgres;

--
-- Name: cliinfo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cliinfo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cliinfo_id_seq OWNER TO postgres;

--
-- Name: cliinfo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cliinfo_id_seq OWNED BY public.cliinfo.id;


--
-- Name: my_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.my_user (
    id integer NOT NULL,
    email character varying(100) NOT NULL,
    pw character varying(100) NOT NULL,
    created_date date DEFAULT CURRENT_DATE,
    created_at_alt timestamp with time zone DEFAULT now()
);


ALTER TABLE public.my_user OWNER TO postgres;

--
-- Name: my_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.my_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.my_user_id_seq OWNER TO postgres;

--
-- Name: my_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.my_user_id_seq OWNED BY public.my_user.id;


--
-- Name: taxrate_2025; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.taxrate_2025 (
    id integer NOT NULL,
    year character varying(4) DEFAULT '2025'::character varying,
    fs character varying(20),
    lr money,
    hr money,
    tr numeric
);


ALTER TABLE public.taxrate_2025 OWNER TO postgres;

--
-- Name: taxrate_2025_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.taxrate_2025_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taxrate_2025_id_seq OWNER TO postgres;

--
-- Name: taxrate_2025_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.taxrate_2025_id_seq OWNED BY public.taxrate_2025.id;


--
-- Name: visitors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.visitors (
    id integer NOT NULL,
    ip_address character varying(100) NOT NULL,
    visited_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.visitors OWNER TO postgres;

--
-- Name: visitors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.visitors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.visitors_id_seq OWNER TO postgres;

--
-- Name: visitors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.visitors_id_seq OWNED BY public.visitors.id;


--
-- Name: visits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.visits (
    id integer NOT NULL,
    total_count integer DEFAULT 0,
    last_updated time without time zone DEFAULT now()
);


ALTER TABLE public.visits OWNER TO postgres;

--
-- Name: visits_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.visits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.visits_id_seq OWNER TO postgres;

--
-- Name: visits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.visits_id_seq OWNED BY public.visits.id;


--
-- Name: cliinfo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliinfo ALTER COLUMN id SET DEFAULT nextval('public.cliinfo_id_seq'::regclass);


--
-- Name: my_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.my_user ALTER COLUMN id SET DEFAULT nextval('public.my_user_id_seq'::regclass);


--
-- Name: taxrate_2025 id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxrate_2025 ALTER COLUMN id SET DEFAULT nextval('public.taxrate_2025_id_seq'::regclass);


--
-- Name: visitors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitors ALTER COLUMN id SET DEFAULT nextval('public.visitors_id_seq'::regclass);


--
-- Name: visits id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visits ALTER COLUMN id SET DEFAULT nextval('public.visits_id_seq'::regclass);


--
-- Data for Name: cliinfo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliinfo (id, name, phone, email, commu, comment, eventdate, "time") FROM stdin;
4	Hieu	123456789	hieu@mail.com	Any	Hi, Thank you	2025-10-07	2025-10-07 00:16:56.450654-05
5	Nhu	1123456789	nhu@mail.com	Any	Hi,\r\n\r\nThank you	2025-10-07	2025-10-07 00:36:11.477437-05
6	Hieu	123456789	hieu@mail.com	Any	Hi,\r\n\r\nThank you	2025-10-07	2025-10-07 00:38:25.525566-05
87	Hieu	234567890	abc@mail.com	Any	Hi	2025-10-14	2025-10-14 14:01:52.173322-05
88	Hieu Nguyen	1234567899	abc@mail.com	Any	Hi,\r\n\r\nThank you.	2025-10-14	2025-10-14 17:50:54.395923-05
89	Nguyen Thanh Hieu	987654321	abc@mail.com	Any	Hi,\r\n\r\nThank you	2025-10-14	2025-10-14 17:52:28.008704-05
90	Hieu Nguyen	123456456789	abc@mail.com	Any	Hi \n\nThank you for reaching out to me. \nWe are thrilled to have you as your advisor.\nPlease let us know if you need anything.\nStay in touch.\n\nKind regards,\n	2025-10-14	2025-10-14 21:53:23.57196-05
91	Hieu Nguyen	12345678963	abc@mail.com	Any	Hi,\n\nThank you for reaching out to me. \nWe are thrilled to have you as your advisor.\nPlease let us know if you need anything.\nStay in touch.\n\nKind regards,\n	2025-10-14	2025-10-14 22:29:58.001754-05
92	Thu Nguyen	1234567899	thu@mail.com	any	Hi  ,\r\n\r\nThank you very much for taking of my return.\r\nWe will see you for another task.\r\nPlease let us know if you need any thing.\r\nAlso, we have a few things to ask you.\r\n\r\nRegards,\r\nThu Nguyen	2025-10-15	2025-10-15 10:03:23.301334-05
93	2FA	123456879	2fa@	any	Hi	2025-10-16	2025-10-16 00:55:44.477118-05
\.


--
-- Data for Name: my_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.my_user (id, email, pw, created_date, created_at_alt) FROM stdin;
1	hieu@mail.com	$2b$12$sMjzkrpIOGK59mjQLV.sN.N4sFfntfdwtGzrk7t5D.SQTt9niBtW.	2025-10-12	2025-10-12 09:57:46.225444-05
4	123@mail.com	$2b$12$tc2tXvqQGW1J7pmO9NJ9cOhbiTuMCOtlinXH8O1S/CNQuPZZrrTOu	2025-10-13	2025-10-13 19:24:17.284117-05
5	456@mail.com	$2b$12$gLybZj983IYjUxd3HoLDWutplTn202rWp75KQ8fmFaL0CRt9.YP2G	2025-10-13	2025-10-13 19:26:56.531102-05
2	abc@mail.com	$2b$12$mkf3vYQjBsrErj/YYkTM0eX74ozKuR8mrhzGeyb/eSu16DXr1mXbu	2025-10-12	2025-10-12 10:00:42.719143-05
3	def@mail.com	$2b$12$IWTwkNKMO/f431x2TOpwsOD/Lwz/lB6Aur.f2tAGrMODpNS3uRczi	2025-10-12	2025-10-12 11:10:43.081508-05
10	hi@mail.com	$2b$12$hVtwnAPQY/pcCmWtUXVrXOF/qJri4x/fw7nabrTJDR1zOoJ2gTvFq	2025-10-14	2025-10-14 16:49:11.321583-05
\.


--
-- Data for Name: taxrate_2025; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.taxrate_2025 (id, year, fs, lr, hr, tr) FROM stdin;
1	2025	S	$0.00	$11,925.00	10
2	2025	S	$11,926.00	$48,475.00	12
3	2025	S	$48,476.00	$103,350.00	22
4	2025	S	$103,351.00	$197,300.00	24
5	2025	S	$197,301.00	$250,525.00	32
6	2025	S	$250,526.00	$626,350.00	35
7	2025	S	$626,351.00	\N	37
8	2025	M	$0.00	$23,850.00	10
9	2025	HH	$0.00	$17,000.00	10
\.


--
-- Data for Name: visitors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.visitors (id, ip_address, visited_at) FROM stdin;
2	::1	2025-10-13 22:03:01.206127
\.


--
-- Data for Name: visits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.visits (id, total_count, last_updated) FROM stdin;
1	1	16:15:30.857381
\.


--
-- Name: cliinfo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cliinfo_id_seq', 93, true);


--
-- Name: my_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.my_user_id_seq', 14, true);


--
-- Name: taxrate_2025_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.taxrate_2025_id_seq', 9, true);


--
-- Name: visitors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.visitors_id_seq', 2, true);


--
-- Name: visits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.visits_id_seq', 1, true);


--
-- Name: cliinfo cliinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliinfo
    ADD CONSTRAINT cliinfo_pkey PRIMARY KEY (id);


--
-- Name: my_user my_user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.my_user
    ADD CONSTRAINT my_user_email_key UNIQUE (email);


--
-- Name: my_user my_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.my_user
    ADD CONSTRAINT my_user_pkey PRIMARY KEY (id);


--
-- Name: taxrate_2025 taxrate_2025_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxrate_2025
    ADD CONSTRAINT taxrate_2025_pkey PRIMARY KEY (id);


--
-- Name: visitors visitors_ip_address_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitors
    ADD CONSTRAINT visitors_ip_address_key UNIQUE (ip_address);


--
-- Name: visitors visitors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitors
    ADD CONSTRAINT visitors_pkey PRIMARY KEY (id);


--
-- Name: visits visits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visits
    ADD CONSTRAINT visits_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

