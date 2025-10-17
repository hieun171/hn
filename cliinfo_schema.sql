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
-- Name: cliinfo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliinfo ALTER COLUMN id SET DEFAULT nextval('public.cliinfo_id_seq'::regclass);


--
-- Name: cliinfo cliinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliinfo
    ADD CONSTRAINT cliinfo_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

