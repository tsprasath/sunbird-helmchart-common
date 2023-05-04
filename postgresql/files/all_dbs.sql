--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE analytics;
ALTER ROLE analytics WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5299fdc5f4e355abae7d7673076fb9ee6';
CREATE ROLE druid;
ALTER ROLE druid WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5f6a360e540e74b40b337f8d6bc125c02';


--
-- Database creation
--

CREATE DATABASE analytics WITH TEMPLATE = template0 OWNER = analytics;
CREATE DATABASE api_manager_dev WITH TEMPLATE = template0 OWNER = postgres;
CREATE DATABASE "dev-keys" WITH TEMPLATE = template0 OWNER = postgres;
CREATE DATABASE druid WITH TEMPLATE = template0 OWNER = postgres;
GRANT ALL ON DATABASE druid TO druid;
CREATE DATABASE keycloak WITH TEMPLATE = template0 OWNER = postgres;
CREATE DATABASE quartz WITH TEMPLATE = template0 OWNER = postgres;
CREATE DATABASE superset WITH TEMPLATE = template0 OWNER = postgres;
GRANT ALL ON DATABASE superset TO analytics;
REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;
CREATE DATABASE "uci-botdb" WITH TEMPLATE = template0 OWNER = postgres;
CREATE DATABASE "uci-formsdb" WITH TEMPLATE = template0 OWNER = postgres;
CREATE DATABASE "uci-fusionauth" WITH TEMPLATE = template0 OWNER = postgres;
CREATE DATABASE "uci-odk-aggregate" WITH TEMPLATE = template0 OWNER = postgres;
CREATE DATABASE userorg WITH TEMPLATE = template0 OWNER = postgres;


\connect analytics

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.22 (Ubuntu 10.22-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.22 (Ubuntu 10.22-0ubuntu0.18.04.1)

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

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: dev_consumer_channel_mapping; Type: TABLE; Schema: public; Owner: analytics
--

CREATE TABLE public.dev_consumer_channel_mapping (
    consumer_id text NOT NULL,
    channel text NOT NULL,
    status smallint,
    created_by text,
    created_on timestamp with time zone,
    updated_on timestamp with time zone
);


ALTER TABLE public.dev_consumer_channel_mapping OWNER TO analytics;

--
-- Name: dev_dataset_metadata; Type: TABLE; Schema: public; Owner: analytics
--

CREATE TABLE public.dev_dataset_metadata (
    dataset_id character varying(50) NOT NULL,
    dataset_sub_id character varying(150) NOT NULL,
    dataset_config json,
    visibility character varying(50),
    dataset_type character varying(50),
    version character varying(10),
    authorized_roles text[],
    available_from timestamp without time zone,
    sample_request text,
    sample_response text,
    validation_json json,
    druid_query json,
    limits json,
    supported_formats text[],
    exhaust_type character varying(50)
);


ALTER TABLE public.dev_dataset_metadata OWNER TO analytics;

--
-- Name: dev_device_profile; Type: TABLE; Schema: public; Owner: analytics
--

CREATE TABLE public.dev_device_profile (
    device_id text NOT NULL,
    api_last_updated_on timestamp with time zone,
    avg_ts double precision,
    city text,
    country text,
    country_code text,
    device_spec json,
    district_custom text,
    fcm_token text,
    first_access timestamp with time zone,
    last_access timestamp with time zone,
    producer_id text,
    state text,
    state_code text,
    state_code_custom text,
    state_custom text,
    total_launches bigint,
    total_ts double precision,
    uaspec json,
    updated_date timestamp with time zone,
    user_declared_district text,
    user_declared_state text,
    user_declared_on timestamp with time zone
);


ALTER TABLE public.dev_device_profile OWNER TO analytics;

--
-- Name: dev_experiment_definition; Type: TABLE; Schema: public; Owner: analytics
--

CREATE TABLE public.dev_experiment_definition (
    exp_id character varying(50) NOT NULL,
    created_by character varying(50),
    created_on timestamp without time zone,
    criteria character varying(100),
    exp_data character varying(300),
    exp_description character varying(200),
    exp_name character varying(50),
    stats character varying(300),
    status character varying(50),
    status_message character varying(50),
    updated_by character varying(50),
    updated_on timestamp without time zone
);


ALTER TABLE public.dev_experiment_definition OWNER TO analytics;

--
-- Name: dev_geo_location_city; Type: TABLE; Schema: public; Owner: analytics
--

CREATE TABLE public.dev_geo_location_city (
    geoname_id integer,
    locale_code character varying(3),
    continent_code character varying(3),
    continent_name character varying(100),
    country_iso_code character varying(5),
    country_name character varying(100),
    subdivision_1_iso_code character varying(50),
    subdivision_1_name character varying(100),
    subdivision_2_iso_code character varying(50),
    subdivision_2_name character varying(100),
    city_name character varying(100),
    metro_code character varying(10),
    time_zone character varying(50),
    is_in_european_union smallint,
    subdivision_1_custom_code character varying(50),
    subdivision_1_custom_name character varying(100),
    subdivision_2_custom_code character varying(50),
    subdivision_2_custom_name character varying(100)
);


ALTER TABLE public.dev_geo_location_city OWNER TO analytics;

--
-- Name: dev_geo_location_city_ipv4; Type: TABLE; Schema: public; Owner: analytics
--

CREATE TABLE public.dev_geo_location_city_ipv4 (
    network_start_integer bigint,
    network_last_integer bigint,
    geoname_id integer,
    registered_country_geoname_id integer,
    represented_country_geoname_id integer,
    is_anonymous_proxy smallint,
    is_satellite_provider smallint,
    postal_code character varying(50),
    latitude numeric(9,6),
    longitude numeric(9,6),
    accuracy_radius smallint
);


ALTER TABLE public.dev_geo_location_city_ipv4 OWNER TO analytics;

--
-- Name: dev_job_request; Type: TABLE; Schema: public; Owner: analytics
--

CREATE TABLE public.dev_job_request (
    tag character varying(100) NOT NULL,
    request_id character varying(50) NOT NULL,
    job_id character varying(50),
    status character varying(50),
    request_data json,
    requested_by character varying(50),
    requested_channel character varying(50),
    dt_job_submitted timestamp without time zone,
    download_urls text[],
    dt_file_created timestamp without time zone,
    dt_job_completed timestamp without time zone,
    execution_time integer,
    err_message character varying(300),
    iteration integer,
    encryption_key character varying(50),
    batch_number integer,
    processed_batches text
);


ALTER TABLE public.dev_job_request OWNER TO analytics;

--
-- Name: dev_report_config; Type: TABLE; Schema: public; Owner: analytics
--

CREATE TABLE public.dev_report_config (
    report_id text NOT NULL,
    updated_on timestamp with time zone,
    report_description text,
    requested_by text,
    report_schedule text,
    config json,
    created_on timestamp with time zone,
    submitted_on timestamp with time zone,
    status text,
    status_msg text,
    batch_number integer
);


ALTER TABLE public.dev_report_config OWNER TO analytics;

--
-- Name: report; Type: TABLE; Schema: public; Owner: analytics
--

CREATE TABLE public.report (
    reportid character varying(40) NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    authorizedroles jsonb NOT NULL,
    status character varying(8) DEFAULT 'draft'::character varying NOT NULL,
    type character varying(10) DEFAULT 'private'::character varying NOT NULL,
    reportaccessurl text NOT NULL,
    createdon timestamp with time zone DEFAULT now() NOT NULL,
    updatedon timestamp with time zone DEFAULT now() NOT NULL,
    createdby character varying(50) NOT NULL,
    reportconfig jsonb NOT NULL,
    templateurl text,
    slug character varying(10) NOT NULL,
    reportgenerateddate timestamp with time zone DEFAULT now() NOT NULL,
    reportduration jsonb DEFAULT jsonb_build_object('startDate', now(), 'endDate', now()) NOT NULL,
    tags jsonb NOT NULL,
    updatefrequency text NOT NULL,
    parameters jsonb,
    report_type character varying(8) DEFAULT 'report'::character varying NOT NULL,
    visibilityflags jsonb,
    accesspath jsonb,
    CONSTRAINT report_status_check CHECK (((status)::text = ANY ((ARRAY['live'::character varying, 'draft'::character varying, 'retired'::character varying])::text[]))),
    CONSTRAINT report_type_check CHECK (((type)::text = ANY (ARRAY[('public'::character varying)::text, ('private'::character varying)::text, ('protected'::character varying)::text])))
);


ALTER TABLE public.report OWNER TO analytics;

--
-- Name: report_status; Type: TABLE; Schema: public; Owner: analytics
--

CREATE TABLE public.report_status (
    reportid character varying(40) NOT NULL,
    hashed_val text NOT NULL,
    status character varying(8) DEFAULT 'draft'::character varying NOT NULL,
    CONSTRAINT report_status_status_check CHECK (((status)::text = ANY ((ARRAY['live'::character varying, 'draft'::character varying, 'retired'::character varying])::text[])))
);


ALTER TABLE public.report_status OWNER TO analytics;

--
-- Name: report_summary; Type: TABLE; Schema: public; Owner: analytics
--

CREATE TABLE public.report_summary (
    id character varying(40) NOT NULL,
    reportid character varying(40) NOT NULL,
    chartid text,
    createdon timestamp with time zone DEFAULT now() NOT NULL,
    createdby character varying(50) NOT NULL,
    summary text NOT NULL,
    param_hash text
);


ALTER TABLE public.report_summary OWNER TO analytics;

--
-- Name: dev_consumer_channel_mapping dev_consumer_channel_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: analytics
--

ALTER TABLE ONLY public.dev_consumer_channel_mapping
    ADD CONSTRAINT dev_consumer_channel_mapping_pkey PRIMARY KEY (consumer_id, channel);


--
-- Name: dev_dataset_metadata dev_dataset_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: analytics
--

ALTER TABLE ONLY public.dev_dataset_metadata
    ADD CONSTRAINT dev_dataset_metadata_pkey PRIMARY KEY (dataset_id, dataset_sub_id);


--
-- Name: dev_device_profile dev_device_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: analytics
--

ALTER TABLE ONLY public.dev_device_profile
    ADD CONSTRAINT dev_device_profile_pkey PRIMARY KEY (device_id);


--
-- Name: dev_experiment_definition dev_experiment_definition_pkey; Type: CONSTRAINT; Schema: public; Owner: analytics
--

ALTER TABLE ONLY public.dev_experiment_definition
    ADD CONSTRAINT dev_experiment_definition_pkey PRIMARY KEY (exp_id);


--
-- Name: dev_geo_location_city dev_geo_location_city_geoname_id_key; Type: CONSTRAINT; Schema: public; Owner: analytics
--

ALTER TABLE ONLY public.dev_geo_location_city
    ADD CONSTRAINT dev_geo_location_city_geoname_id_key UNIQUE (geoname_id);


--
-- Name: dev_job_request dev_job_request_pkey; Type: CONSTRAINT; Schema: public; Owner: analytics
--

ALTER TABLE ONLY public.dev_job_request
    ADD CONSTRAINT dev_job_request_pkey PRIMARY KEY (tag, request_id);


--
-- Name: dev_report_config dev_report_config_pkey; Type: CONSTRAINT; Schema: public; Owner: analytics
--

ALTER TABLE ONLY public.dev_report_config
    ADD CONSTRAINT dev_report_config_pkey PRIMARY KEY (report_id);


--
-- Name: report report_pkey; Type: CONSTRAINT; Schema: public; Owner: analytics
--

ALTER TABLE ONLY public.report
    ADD CONSTRAINT report_pkey PRIMARY KEY (reportid);


--
-- Name: report report_reportaccessurl_key; Type: CONSTRAINT; Schema: public; Owner: analytics
--

ALTER TABLE ONLY public.report
    ADD CONSTRAINT report_reportaccessurl_key UNIQUE (reportaccessurl);


--
-- Name: report_status report_status_pkey; Type: CONSTRAINT; Schema: public; Owner: analytics
--

ALTER TABLE ONLY public.report_status
    ADD CONSTRAINT report_status_pkey PRIMARY KEY (reportid, hashed_val);


--
-- Name: report_summary report_summary_pkey; Type: CONSTRAINT; Schema: public; Owner: analytics
--

ALTER TABLE ONLY public.report_summary
    ADD CONSTRAINT report_summary_pkey PRIMARY KEY (id);


--
-- Name: ind_country_iso_code; Type: INDEX; Schema: public; Owner: analytics
--

CREATE INDEX ind_country_iso_code ON public.dev_geo_location_city USING btree (country_iso_code);


--
-- Name: ind_geoname_id; Type: INDEX; Schema: public; Owner: analytics
--

CREATE INDEX ind_geoname_id ON public.dev_geo_location_city_ipv4 USING btree (geoname_id);


--
-- Name: ind_network_last_integer; Type: INDEX; Schema: public; Owner: analytics
--

CREATE INDEX ind_network_last_integer ON public.dev_geo_location_city_ipv4 USING btree (network_last_integer);


--
-- Name: ind_network_start_integer; Type: INDEX; Schema: public; Owner: analytics
--

CREATE INDEX ind_network_start_integer ON public.dev_geo_location_city_ipv4 USING btree (network_start_integer);


--
-- Name: report_status report_status_reportid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: analytics
--

ALTER TABLE ONLY public.report_status
    ADD CONSTRAINT report_status_reportid_fkey FOREIGN KEY (reportid) REFERENCES public.report(reportid) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\connect -reuse-previous=on "dbname='dev-keys'"

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.22 (Ubuntu 10.22-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.22 (Ubuntu 10.22-0ubuntu0.18.04.1)

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

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: enum_Keys_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_Keys_type" AS ENUM (
    'MASTER',
    'OTHER'
);


ALTER TYPE public."enum_Keys_type" OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Keys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Keys" (
    id integer NOT NULL,
    public text NOT NULL,
    private text NOT NULL,
    type public."enum_Keys_type" NOT NULL,
    active boolean DEFAULT true NOT NULL,
    reserved boolean DEFAULT false NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."Keys" OWNER TO postgres;

--
-- Name: Keys_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Keys_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Keys_id_seq" OWNER TO postgres;

--
-- Name: Keys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Keys_id_seq" OWNED BY public."Keys".id;


--
-- Name: Keys id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Keys" ALTER COLUMN id SET DEFAULT nextval('public."Keys_id_seq"'::regclass);


--
-- Name: Keys Keys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Keys"
    ADD CONSTRAINT "Keys_pkey" PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

\connect druid

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.22 (Ubuntu 10.22-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.22 (Ubuntu 10.22-0ubuntu0.18.04.1)

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

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: druid_audit; Type: TABLE; Schema: public; Owner: druid
--

CREATE TABLE public.druid_audit (
    id bigint NOT NULL,
    audit_key character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    comment character varying(2048) NOT NULL,
    created_date character varying(255) NOT NULL,
    payload bytea NOT NULL
);


ALTER TABLE public.druid_audit OWNER TO druid;

--
-- Name: druid_audit_id_seq; Type: SEQUENCE; Schema: public; Owner: druid
--

CREATE SEQUENCE public.druid_audit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.druid_audit_id_seq OWNER TO druid;

--
-- Name: druid_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: druid
--

ALTER SEQUENCE public.druid_audit_id_seq OWNED BY public.druid_audit.id;


--
-- Name: druid_config; Type: TABLE; Schema: public; Owner: druid
--

CREATE TABLE public.druid_config (
    name character varying(255) NOT NULL,
    payload bytea NOT NULL
);


ALTER TABLE public.druid_config OWNER TO druid;

--
-- Name: druid_datasource; Type: TABLE; Schema: public; Owner: druid
--

CREATE TABLE public.druid_datasource (
    datasource character varying(255) NOT NULL,
    created_date character varying(255) NOT NULL,
    commit_metadata_payload bytea NOT NULL,
    commit_metadata_sha1 character varying(255) NOT NULL
);


ALTER TABLE public.druid_datasource OWNER TO druid;

--
-- Name: druid_pendingsegments; Type: TABLE; Schema: public; Owner: druid
--

CREATE TABLE public.druid_pendingsegments (
    id character varying(255) NOT NULL,
    datasource character varying(255) NOT NULL,
    created_date character varying(255) NOT NULL,
    start character varying(255) NOT NULL,
    "end" character varying(255) NOT NULL,
    sequence_name character varying(255) NOT NULL,
    sequence_prev_id character varying(255) NOT NULL,
    sequence_name_prev_id_sha1 character varying(255) NOT NULL,
    payload bytea NOT NULL
);


ALTER TABLE public.druid_pendingsegments OWNER TO druid;

--
-- Name: druid_rules; Type: TABLE; Schema: public; Owner: druid
--

CREATE TABLE public.druid_rules (
    id character varying(255) NOT NULL,
    datasource character varying(255) NOT NULL,
    version character varying(255) NOT NULL,
    payload bytea NOT NULL
);


ALTER TABLE public.druid_rules OWNER TO druid;

--
-- Name: druid_segments; Type: TABLE; Schema: public; Owner: druid
--

CREATE TABLE public.druid_segments (
    id character varying(255) NOT NULL,
    datasource character varying(255) NOT NULL,
    created_date character varying(255) NOT NULL,
    start character varying(255) NOT NULL,
    "end" character varying(255) NOT NULL,
    partitioned boolean NOT NULL,
    version character varying(255) NOT NULL,
    used boolean NOT NULL,
    payload bytea NOT NULL
);


ALTER TABLE public.druid_segments OWNER TO druid;

--
-- Name: druid_supervisors; Type: TABLE; Schema: public; Owner: druid
--

CREATE TABLE public.druid_supervisors (
    id bigint NOT NULL,
    spec_id character varying(255) NOT NULL,
    created_date character varying(255) NOT NULL,
    payload bytea NOT NULL
);


ALTER TABLE public.druid_supervisors OWNER TO druid;

--
-- Name: druid_supervisors_id_seq; Type: SEQUENCE; Schema: public; Owner: druid
--

CREATE SEQUENCE public.druid_supervisors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.druid_supervisors_id_seq OWNER TO druid;

--
-- Name: druid_supervisors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: druid
--

ALTER SEQUENCE public.druid_supervisors_id_seq OWNED BY public.druid_supervisors.id;


--
-- Name: druid_tasklocks; Type: TABLE; Schema: public; Owner: druid
--

CREATE TABLE public.druid_tasklocks (
    id bigint NOT NULL,
    task_id character varying(255) DEFAULT NULL::character varying,
    lock_payload bytea
);


ALTER TABLE public.druid_tasklocks OWNER TO druid;

--
-- Name: druid_tasklocks_id_seq; Type: SEQUENCE; Schema: public; Owner: druid
--

CREATE SEQUENCE public.druid_tasklocks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.druid_tasklocks_id_seq OWNER TO druid;

--
-- Name: druid_tasklocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: druid
--

ALTER SEQUENCE public.druid_tasklocks_id_seq OWNED BY public.druid_tasklocks.id;


--
-- Name: druid_tasklogs; Type: TABLE; Schema: public; Owner: druid
--

CREATE TABLE public.druid_tasklogs (
    id bigint NOT NULL,
    task_id character varying(255) DEFAULT NULL::character varying,
    log_payload bytea
);


ALTER TABLE public.druid_tasklogs OWNER TO druid;

--
-- Name: druid_tasklogs_id_seq; Type: SEQUENCE; Schema: public; Owner: druid
--

CREATE SEQUENCE public.druid_tasklogs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.druid_tasklogs_id_seq OWNER TO druid;

--
-- Name: druid_tasklogs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: druid
--

ALTER SEQUENCE public.druid_tasklogs_id_seq OWNED BY public.druid_tasklogs.id;


--
-- Name: druid_tasks; Type: TABLE; Schema: public; Owner: druid
--

CREATE TABLE public.druid_tasks (
    id character varying(255) NOT NULL,
    created_date character varying(255) NOT NULL,
    datasource character varying(255) NOT NULL,
    payload bytea NOT NULL,
    status_payload bytea NOT NULL,
    active boolean DEFAULT false NOT NULL
);


ALTER TABLE public.druid_tasks OWNER TO druid;

--
-- Name: druid_audit id; Type: DEFAULT; Schema: public; Owner: druid
--

ALTER TABLE ONLY public.druid_audit ALTER COLUMN id SET DEFAULT nextval('public.druid_audit_id_seq'::regclass);


--
-- Name: druid_supervisors id; Type: DEFAULT; Schema: public; Owner: druid
--

ALTER TABLE ONLY public.druid_supervisors ALTER COLUMN id SET DEFAULT nextval('public.druid_supervisors_id_seq'::regclass);


--
-- Name: druid_tasklocks id; Type: DEFAULT; Schema: public; Owner: druid
--

ALTER TABLE ONLY public.druid_tasklocks ALTER COLUMN id SET DEFAULT nextval('public.druid_tasklocks_id_seq'::regclass);


--
-- Name: druid_tasklogs id; Type: DEFAULT; Schema: public; Owner: druid
--

ALTER TABLE ONLY public.druid_tasklogs ALTER COLUMN id SET DEFAULT nextval('public.druid_tasklogs_id_seq'::regclass);


--
-- Name: druid_audit druid_audit_pkey; Type: CONSTRAINT; Schema: public; Owner: druid
--

ALTER TABLE ONLY public.druid_audit
    ADD CONSTRAINT druid_audit_pkey PRIMARY KEY (id);


--
-- Name: druid_config druid_config_pkey; Type: CONSTRAINT; Schema: public; Owner: druid
--

ALTER TABLE ONLY public.druid_config
    ADD CONSTRAINT druid_config_pkey PRIMARY KEY (name);


--
-- Name: druid_datasource druid_datasource_pkey; Type: CONSTRAINT; Schema: public; Owner: druid
--

ALTER TABLE ONLY public.druid_datasource
    ADD CONSTRAINT druid_datasource_pkey PRIMARY KEY (datasource);


--
-- Name: druid_pendingsegments druid_pendingsegments_pkey; Type: CONSTRAINT; Schema: public; Owner: druid
--

ALTER TABLE ONLY public.druid_pendingsegments
    ADD CONSTRAINT druid_pendingsegments_pkey PRIMARY KEY (id);


--
-- Name: druid_pendingsegments druid_pendingsegments_sequence_name_prev_id_sha1_key; Type: CONSTRAINT; Schema: public; Owner: druid
--

ALTER TABLE ONLY public.druid_pendingsegments
    ADD CONSTRAINT druid_pendingsegments_sequence_name_prev_id_sha1_key UNIQUE (sequence_name_prev_id_sha1);


--
-- Name: druid_rules druid_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: druid
--

ALTER TABLE ONLY public.druid_rules
    ADD CONSTRAINT druid_rules_pkey PRIMARY KEY (id);


--
-- Name: druid_segments druid_segments_pkey; Type: CONSTRAINT; Schema: public; Owner: druid
--

ALTER TABLE ONLY public.druid_segments
    ADD CONSTRAINT druid_segments_pkey PRIMARY KEY (id);


--
-- Name: druid_supervisors druid_supervisors_pkey; Type: CONSTRAINT; Schema: public; Owner: druid
--

ALTER TABLE ONLY public.druid_supervisors
    ADD CONSTRAINT druid_supervisors_pkey PRIMARY KEY (id);


--
-- Name: druid_tasklocks druid_tasklocks_pkey; Type: CONSTRAINT; Schema: public; Owner: druid
--

ALTER TABLE ONLY public.druid_tasklocks
    ADD CONSTRAINT druid_tasklocks_pkey PRIMARY KEY (id);


--
-- Name: druid_tasklogs druid_tasklogs_pkey; Type: CONSTRAINT; Schema: public; Owner: druid
--

ALTER TABLE ONLY public.druid_tasklogs
    ADD CONSTRAINT druid_tasklogs_pkey PRIMARY KEY (id);


--
-- Name: druid_tasks druid_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: druid
--

ALTER TABLE ONLY public.druid_tasks
    ADD CONSTRAINT druid_tasks_pkey PRIMARY KEY (id);


--
-- Name: idx_druid_audit_audit_time; Type: INDEX; Schema: public; Owner: druid
--

CREATE INDEX idx_druid_audit_audit_time ON public.druid_audit USING btree (created_date);


--
-- Name: idx_druid_audit_key_time; Type: INDEX; Schema: public; Owner: druid
--

CREATE INDEX idx_druid_audit_key_time ON public.druid_audit USING btree (audit_key, created_date);


--
-- Name: idx_druid_audit_type_time; Type: INDEX; Schema: public; Owner: druid
--

CREATE INDEX idx_druid_audit_type_time ON public.druid_audit USING btree (type, created_date);


--
-- Name: idx_druid_pendingsegments_datasource_end; Type: INDEX; Schema: public; Owner: druid
--

CREATE INDEX idx_druid_pendingsegments_datasource_end ON public.druid_pendingsegments USING btree (datasource, "end");


--
-- Name: idx_druid_pendingsegments_datasource_sequence; Type: INDEX; Schema: public; Owner: druid
--

CREATE INDEX idx_druid_pendingsegments_datasource_sequence ON public.druid_pendingsegments USING btree (datasource, sequence_name);


--
-- Name: idx_druid_rules_datasource; Type: INDEX; Schema: public; Owner: druid
--

CREATE INDEX idx_druid_rules_datasource ON public.druid_rules USING btree (datasource);


--
-- Name: idx_druid_segments_datasource_used_end; Type: INDEX; Schema: public; Owner: druid
--

CREATE INDEX idx_druid_segments_datasource_used_end ON public.druid_segments USING btree (datasource, used, "end");


--
-- Name: idx_druid_segments_used; Type: INDEX; Schema: public; Owner: druid
--

CREATE INDEX idx_druid_segments_used ON public.druid_segments USING btree (used);


--
-- Name: idx_druid_supervisors_spec_id; Type: INDEX; Schema: public; Owner: druid
--

CREATE INDEX idx_druid_supervisors_spec_id ON public.druid_supervisors USING btree (spec_id);


--
-- Name: idx_druid_tasklocks_task_id; Type: INDEX; Schema: public; Owner: druid
--

CREATE INDEX idx_druid_tasklocks_task_id ON public.druid_tasklocks USING btree (task_id);


--
-- Name: idx_druid_tasklogs_task_id; Type: INDEX; Schema: public; Owner: druid
--

CREATE INDEX idx_druid_tasklogs_task_id ON public.druid_tasklogs USING btree (task_id);


--
-- Name: idx_druid_tasks_active_created_date; Type: INDEX; Schema: public; Owner: druid
--

CREATE INDEX idx_druid_tasks_active_created_date ON public.druid_tasks USING btree (active, created_date);


--
-- PostgreSQL database dump complete
--

\connect postgres

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.22 (Ubuntu 10.22-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.22 (Ubuntu 10.22-0ubuntu0.18.04.1)

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

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- PostgreSQL database dump complete
--

\connect quartz

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.22 (Ubuntu 10.22-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.22 (Ubuntu 10.22-0ubuntu0.18.04.1)

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

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: qrtz_blob_triggers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_blob_triggers (
    sched_name character varying(120) NOT NULL,
    trigger_name character varying(200) NOT NULL,
    trigger_group character varying(200) NOT NULL,
    blob_data bytea
);


ALTER TABLE public.qrtz_blob_triggers OWNER TO postgres;

--
-- Name: qrtz_calendars; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_calendars (
    sched_name character varying(120) NOT NULL,
    calendar_name character varying(200) NOT NULL,
    calendar bytea NOT NULL
);


ALTER TABLE public.qrtz_calendars OWNER TO postgres;

--
-- Name: qrtz_cron_triggers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_cron_triggers (
    sched_name character varying(120) NOT NULL,
    trigger_name character varying(200) NOT NULL,
    trigger_group character varying(200) NOT NULL,
    cron_expression character varying(120) NOT NULL,
    time_zone_id character varying(80)
);


ALTER TABLE public.qrtz_cron_triggers OWNER TO postgres;

--
-- Name: qrtz_fired_triggers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_fired_triggers (
    sched_name character varying(120) NOT NULL,
    entry_id character varying(95) NOT NULL,
    trigger_name character varying(200) NOT NULL,
    trigger_group character varying(200) NOT NULL,
    instance_name character varying(200) NOT NULL,
    fired_time bigint NOT NULL,
    sched_time bigint NOT NULL,
    priority integer NOT NULL,
    state character varying(16) NOT NULL,
    job_name character varying(200),
    job_group character varying(200),
    is_nonconcurrent boolean,
    requests_recovery boolean
);


ALTER TABLE public.qrtz_fired_triggers OWNER TO postgres;

--
-- Name: qrtz_job_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_job_details (
    sched_name character varying(120) NOT NULL,
    job_name character varying(200) NOT NULL,
    job_group character varying(200) NOT NULL,
    description character varying(250),
    job_class_name character varying(250) NOT NULL,
    is_durable boolean NOT NULL,
    is_nonconcurrent boolean NOT NULL,
    is_update_data boolean NOT NULL,
    requests_recovery boolean NOT NULL,
    job_data bytea
);


ALTER TABLE public.qrtz_job_details OWNER TO postgres;

--
-- Name: qrtz_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_locks (
    sched_name character varying(120) NOT NULL,
    lock_name character varying(40) NOT NULL
);


ALTER TABLE public.qrtz_locks OWNER TO postgres;

--
-- Name: qrtz_paused_trigger_grps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_paused_trigger_grps (
    sched_name character varying(120) NOT NULL,
    trigger_group character varying(200) NOT NULL
);


ALTER TABLE public.qrtz_paused_trigger_grps OWNER TO postgres;

--
-- Name: qrtz_scheduler_state; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_scheduler_state (
    sched_name character varying(120) NOT NULL,
    instance_name character varying(200) NOT NULL,
    last_checkin_time bigint NOT NULL,
    checkin_interval bigint NOT NULL
);


ALTER TABLE public.qrtz_scheduler_state OWNER TO postgres;

--
-- Name: qrtz_simple_triggers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_simple_triggers (
    sched_name character varying(120) NOT NULL,
    trigger_name character varying(200) NOT NULL,
    trigger_group character varying(200) NOT NULL,
    repeat_count bigint NOT NULL,
    repeat_interval bigint NOT NULL,
    times_triggered bigint NOT NULL
);


ALTER TABLE public.qrtz_simple_triggers OWNER TO postgres;

--
-- Name: qrtz_simprop_triggers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_simprop_triggers (
    sched_name character varying(120) NOT NULL,
    trigger_name character varying(200) NOT NULL,
    trigger_group character varying(200) NOT NULL,
    str_prop_1 character varying(512),
    str_prop_2 character varying(512),
    str_prop_3 character varying(512),
    int_prop_1 integer,
    int_prop_2 integer,
    long_prop_1 bigint,
    long_prop_2 bigint,
    dec_prop_1 numeric(13,4),
    dec_prop_2 numeric(13,4),
    bool_prop_1 boolean,
    bool_prop_2 boolean
);


ALTER TABLE public.qrtz_simprop_triggers OWNER TO postgres;

--
-- Name: qrtz_triggers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_triggers (
    sched_name character varying(120) NOT NULL,
    trigger_name character varying(200) NOT NULL,
    trigger_group character varying(200) NOT NULL,
    job_name character varying(200) NOT NULL,
    job_group character varying(200) NOT NULL,
    description character varying(250),
    next_fire_time bigint,
    prev_fire_time bigint,
    priority integer,
    trigger_state character varying(16) NOT NULL,
    trigger_type character varying(8) NOT NULL,
    start_time bigint NOT NULL,
    end_time bigint,
    calendar_name character varying(200),
    misfire_instr smallint,
    job_data bytea
);


ALTER TABLE public.qrtz_triggers OWNER TO postgres;

--
-- Name: qrtz_blob_triggers qrtz_blob_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_blob_triggers
    ADD CONSTRAINT qrtz_blob_triggers_pkey PRIMARY KEY (sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_calendars qrtz_calendars_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_calendars
    ADD CONSTRAINT qrtz_calendars_pkey PRIMARY KEY (sched_name, calendar_name);


--
-- Name: qrtz_cron_triggers qrtz_cron_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_cron_triggers
    ADD CONSTRAINT qrtz_cron_triggers_pkey PRIMARY KEY (sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_fired_triggers qrtz_fired_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_fired_triggers
    ADD CONSTRAINT qrtz_fired_triggers_pkey PRIMARY KEY (sched_name, entry_id);


--
-- Name: qrtz_job_details qrtz_job_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_job_details
    ADD CONSTRAINT qrtz_job_details_pkey PRIMARY KEY (sched_name, job_name, job_group);


--
-- Name: qrtz_locks qrtz_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_locks
    ADD CONSTRAINT qrtz_locks_pkey PRIMARY KEY (sched_name, lock_name);


--
-- Name: qrtz_paused_trigger_grps qrtz_paused_trigger_grps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_paused_trigger_grps
    ADD CONSTRAINT qrtz_paused_trigger_grps_pkey PRIMARY KEY (sched_name, trigger_group);


--
-- Name: qrtz_scheduler_state qrtz_scheduler_state_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_scheduler_state
    ADD CONSTRAINT qrtz_scheduler_state_pkey PRIMARY KEY (sched_name, instance_name);


--
-- Name: qrtz_simple_triggers qrtz_simple_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_simple_triggers
    ADD CONSTRAINT qrtz_simple_triggers_pkey PRIMARY KEY (sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_simprop_triggers qrtz_simprop_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_simprop_triggers
    ADD CONSTRAINT qrtz_simprop_triggers_pkey PRIMARY KEY (sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_triggers qrtz_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_triggers
    ADD CONSTRAINT qrtz_triggers_pkey PRIMARY KEY (sched_name, trigger_name, trigger_group);


--
-- Name: idx_qrtz_ft_inst_job_req_rcvry; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qrtz_ft_inst_job_req_rcvry ON public.qrtz_fired_triggers USING btree (sched_name, instance_name, requests_recovery);


--
-- Name: idx_qrtz_ft_j_g; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qrtz_ft_j_g ON public.qrtz_fired_triggers USING btree (sched_name, job_name, job_group);


--
-- Name: idx_qrtz_ft_jg; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qrtz_ft_jg ON public.qrtz_fired_triggers USING btree (sched_name, job_group);


--
-- Name: idx_qrtz_ft_t_g; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qrtz_ft_t_g ON public.qrtz_fired_triggers USING btree (sched_name, trigger_name, trigger_group);


--
-- Name: idx_qrtz_ft_tg; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qrtz_ft_tg ON public.qrtz_fired_triggers USING btree (sched_name, trigger_group);


--
-- Name: idx_qrtz_ft_trig_inst_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qrtz_ft_trig_inst_name ON public.qrtz_fired_triggers USING btree (sched_name, instance_name);


--
-- Name: idx_qrtz_j_grp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qrtz_j_grp ON public.qrtz_job_details USING btree (sched_name, job_group);


--
-- Name: idx_qrtz_j_req_recovery; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qrtz_j_req_recovery ON public.qrtz_job_details USING btree (sched_name, requests_recovery);


--
-- Name: idx_qrtz_t_c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qrtz_t_c ON public.qrtz_triggers USING btree (sched_name, calendar_name);


--
-- Name: idx_qrtz_t_g; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qrtz_t_g ON public.qrtz_triggers USING btree (sched_name, trigger_group);


--
-- Name: idx_qrtz_t_j; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qrtz_t_j ON public.qrtz_triggers USING btree (sched_name, job_name, job_group);


--
-- Name: idx_qrtz_t_jg; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qrtz_t_jg ON public.qrtz_triggers USING btree (sched_name, job_group);


--
-- Name: idx_qrtz_t_n_g_state; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qrtz_t_n_g_state ON public.qrtz_triggers USING btree (sched_name, trigger_group, trigger_state);


--
-- Name: idx_qrtz_t_n_state; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qrtz_t_n_state ON public.qrtz_triggers USING btree (sched_name, trigger_name, trigger_group, trigger_state);


--
-- Name: idx_qrtz_t_next_fire_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qrtz_t_next_fire_time ON public.qrtz_triggers USING btree (sched_name, next_fire_time);


--
-- Name: idx_qrtz_t_nft_misfire; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qrtz_t_nft_misfire ON public.qrtz_triggers USING btree (sched_name, misfire_instr, next_fire_time);


--
-- Name: idx_qrtz_t_nft_st; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qrtz_t_nft_st ON public.qrtz_triggers USING btree (sched_name, trigger_state, next_fire_time);


--
-- Name: idx_qrtz_t_nft_st_misfire; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qrtz_t_nft_st_misfire ON public.qrtz_triggers USING btree (sched_name, misfire_instr, next_fire_time, trigger_state);


--
-- Name: idx_qrtz_t_nft_st_misfire_grp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qrtz_t_nft_st_misfire_grp ON public.qrtz_triggers USING btree (sched_name, misfire_instr, next_fire_time, trigger_group, trigger_state);


--
-- Name: idx_qrtz_t_state; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qrtz_t_state ON public.qrtz_triggers USING btree (sched_name, trigger_state);


--
-- Name: qrtz_blob_triggers qrtz_blob_triggers_sched_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_blob_triggers
    ADD CONSTRAINT qrtz_blob_triggers_sched_name_fkey FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES public.qrtz_triggers(sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_cron_triggers qrtz_cron_triggers_sched_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_cron_triggers
    ADD CONSTRAINT qrtz_cron_triggers_sched_name_fkey FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES public.qrtz_triggers(sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_simple_triggers qrtz_simple_triggers_sched_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_simple_triggers
    ADD CONSTRAINT qrtz_simple_triggers_sched_name_fkey FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES public.qrtz_triggers(sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_simprop_triggers qrtz_simprop_triggers_sched_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_simprop_triggers
    ADD CONSTRAINT qrtz_simprop_triggers_sched_name_fkey FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES public.qrtz_triggers(sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_triggers qrtz_triggers_sched_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_triggers
    ADD CONSTRAINT qrtz_triggers_sched_name_fkey FOREIGN KEY (sched_name, job_name, job_group) REFERENCES public.qrtz_job_details(sched_name, job_name, job_group);


--
-- PostgreSQL database dump complete
--

\connect superset

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.22 (Ubuntu 10.22-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.22 (Ubuntu 10.22-0ubuntu0.18.04.1)

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

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.22 (Ubuntu 10.22-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.22 (Ubuntu 10.22-0ubuntu0.18.04.1)

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

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- PostgreSQL database dump complete
--

\connect -reuse-previous=on "dbname='uci-botdb'"

SET default_transaction_read_only = off;

