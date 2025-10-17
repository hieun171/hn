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

