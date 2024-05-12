--
-- PostgreSQL database dump
--

-- Dumped from database version 14.11 (Homebrew)
-- Dumped by pg_dump version 14.11 (Homebrew)

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
-- Name: heroku_ext; Type: SCHEMA; Schema: -; Owner: samcartwright
--

CREATE SCHEMA heroku_ext;


ALTER SCHEMA heroku_ext OWNER TO samcartwright;

--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA heroku_ext;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: samcartwright
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.active_storage_attachments OWNER TO samcartwright;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: samcartwright
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_attachments_id_seq OWNER TO samcartwright;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: samcartwright
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: samcartwright
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    byte_size bigint NOT NULL,
    checksum character varying,
    created_at timestamp without time zone NOT NULL,
    service_name character varying NOT NULL
);


ALTER TABLE public.active_storage_blobs OWNER TO samcartwright;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: samcartwright
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_blobs_id_seq OWNER TO samcartwright;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: samcartwright
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: samcartwright
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


ALTER TABLE public.active_storage_variant_records OWNER TO samcartwright;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: samcartwright
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_variant_records_id_seq OWNER TO samcartwright;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: samcartwright
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: samcartwright
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO samcartwright;

--
-- Name: areas; Type: TABLE; Schema: public; Owner: samcartwright
--

CREATE TABLE public.areas (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    published boolean DEFAULT false NOT NULL,
    slug character varying,
    tags character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    short_name character varying,
    priority smallint DEFAULT 3 NOT NULL,
    description_fr text,
    description_en text,
    warning_fr text,
    warning_en text,
    bleau_area_id integer
);


ALTER TABLE public.areas OWNER TO samcartwright;

--
-- Name: areas_id_seq; Type: SEQUENCE; Schema: public; Owner: samcartwright
--

CREATE SEQUENCE public.areas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.areas_id_seq OWNER TO samcartwright;

--
-- Name: areas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: samcartwright
--

ALTER SEQUENCE public.areas_id_seq OWNED BY public.areas.id;


--
-- Name: audits; Type: TABLE; Schema: public; Owner: samcartwright
--

CREATE TABLE public.audits (
    id bigint NOT NULL,
    auditable_id integer,
    auditable_type character varying,
    associated_id integer,
    associated_type character varying,
    user_id integer,
    user_type character varying,
    username character varying,
    action character varying,
    audited_changes jsonb,
    version integer DEFAULT 0,
    comment character varying,
    remote_address character varying,
    request_uuid character varying,
    created_at timestamp(6) without time zone
);


ALTER TABLE public.audits OWNER TO samcartwright;

--
-- Name: audits_id_seq; Type: SEQUENCE; Schema: public; Owner: samcartwright
--

CREATE SEQUENCE public.audits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.audits_id_seq OWNER TO samcartwright;

--
-- Name: audits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: samcartwright
--

ALTER SEQUENCE public.audits_id_seq OWNED BY public.audits.id;


--
-- Name: bleau_areas; Type: TABLE; Schema: public; Owner: samcartwright
--

CREATE TABLE public.bleau_areas (
    id bigint NOT NULL,
    slug character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    name character varying,
    category character varying
);


ALTER TABLE public.bleau_areas OWNER TO samcartwright;

--
-- Name: bleau_areas_id_seq; Type: SEQUENCE; Schema: public; Owner: samcartwright
--

CREATE SEQUENCE public.bleau_areas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bleau_areas_id_seq OWNER TO samcartwright;

--
-- Name: bleau_areas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: samcartwright
--

ALTER SEQUENCE public.bleau_areas_id_seq OWNED BY public.bleau_areas.id;


--
-- Name: bleau_problems; Type: TABLE; Schema: public; Owner: samcartwright
--

CREATE TABLE public.bleau_problems (
    id bigint NOT NULL,
    name character varying,
    grade character varying,
    steepness character varying,
    sit_start boolean,
    tags character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    bleau_circuit_id bigint,
    circuit_number character varying,
    circuit_letter character varying,
    ascents integer,
    ratings integer,
    ratings_average numeric,
    bleau_area_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.bleau_problems OWNER TO samcartwright;

--
-- Name: bleau_problems_id_seq; Type: SEQUENCE; Schema: public; Owner: samcartwright
--

CREATE SEQUENCE public.bleau_problems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bleau_problems_id_seq OWNER TO samcartwright;

--
-- Name: bleau_problems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: samcartwright
--

ALTER SEQUENCE public.bleau_problems_id_seq OWNED BY public.bleau_problems.id;


--
-- Name: boulders; Type: TABLE; Schema: public; Owner: samcartwright
--

CREATE TABLE public.boulders (
    id bigint NOT NULL,
    polygon public.geography(Polygon,4326),
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    area_id bigint,
    ignore_for_area_hull boolean DEFAULT false NOT NULL
);


ALTER TABLE public.boulders OWNER TO samcartwright;

--
-- Name: boulders_id_seq; Type: SEQUENCE; Schema: public; Owner: samcartwright
--

CREATE SEQUENCE public.boulders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.boulders_id_seq OWNER TO samcartwright;

--
-- Name: boulders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: samcartwright
--

ALTER SEQUENCE public.boulders_id_seq OWNED BY public.boulders.id;


--
-- Name: circuits; Type: TABLE; Schema: public; Owner: samcartwright
--

CREATE TABLE public.circuits (
    id bigint NOT NULL,
    color character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    risk smallint
);


ALTER TABLE public.circuits OWNER TO samcartwright;

--
-- Name: circuits_id_seq; Type: SEQUENCE; Schema: public; Owner: samcartwright
--

CREATE SEQUENCE public.circuits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.circuits_id_seq OWNER TO samcartwright;

--
-- Name: circuits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: samcartwright
--

ALTER SEQUENCE public.circuits_id_seq OWNED BY public.circuits.id;


--
-- Name: contribution_requests; Type: TABLE; Schema: public; Owner: samcartwright
--

CREATE TABLE public.contribution_requests (
    id bigint NOT NULL,
    what character varying NOT NULL,
    state character varying NOT NULL,
    location_estimated public.geography(Point,4326),
    problem_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    comment text
);


ALTER TABLE public.contribution_requests OWNER TO samcartwright;

--
-- Name: contribution_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: samcartwright
--

CREATE SEQUENCE public.contribution_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contribution_requests_id_seq OWNER TO samcartwright;

--
-- Name: contribution_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: samcartwright
--

ALTER SEQUENCE public.contribution_requests_id_seq OWNED BY public.contribution_requests.id;


--
-- Name: contributions; Type: TABLE; Schema: public; Owner: samcartwright
--

CREATE TABLE public.contributions (
    id bigint NOT NULL,
    problem_id bigint,
    comment text,
    location public.geography(Point,4326),
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    contributor_name character varying,
    contributor_email character varying,
    state character varying DEFAULT 'pending'::character varying NOT NULL,
    problem_name character varying,
    problem_url character varying
);


ALTER TABLE public.contributions OWNER TO samcartwright;

--
-- Name: contributions_id_seq; Type: SEQUENCE; Schema: public; Owner: samcartwright
--

CREATE SEQUENCE public.contributions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contributions_id_seq OWNER TO samcartwright;

--
-- Name: contributions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: samcartwright
--

ALTER SEQUENCE public.contributions_id_seq OWNED BY public.contributions.id;


--
-- Name: imports; Type: TABLE; Schema: public; Owner: samcartwright
--

CREATE TABLE public.imports (
    id bigint NOT NULL,
    applied_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.imports OWNER TO samcartwright;

--
-- Name: imports_id_seq; Type: SEQUENCE; Schema: public; Owner: samcartwright
--

CREATE SEQUENCE public.imports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.imports_id_seq OWNER TO samcartwright;

--
-- Name: imports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: samcartwright
--

ALTER SEQUENCE public.imports_id_seq OWNED BY public.imports.id;


--
-- Name: lines; Type: TABLE; Schema: public; Owner: samcartwright
--

CREATE TABLE public.lines (
    id bigint NOT NULL,
    coordinates json,
    problem_id bigint,
    topo_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.lines OWNER TO samcartwright;

--
-- Name: lines_id_seq; Type: SEQUENCE; Schema: public; Owner: samcartwright
--

CREATE SEQUENCE public.lines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lines_id_seq OWNER TO samcartwright;

--
-- Name: lines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: samcartwright
--

ALTER SEQUENCE public.lines_id_seq OWNED BY public.lines.id;


--
-- Name: poi_routes; Type: TABLE; Schema: public; Owner: samcartwright
--

CREATE TABLE public.poi_routes (
    id bigint NOT NULL,
    distance integer NOT NULL,
    transport character varying NOT NULL,
    area_id bigint,
    poi_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.poi_routes OWNER TO samcartwright;

--
-- Name: poi_routes_id_seq; Type: SEQUENCE; Schema: public; Owner: samcartwright
--

CREATE SEQUENCE public.poi_routes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.poi_routes_id_seq OWNER TO samcartwright;

--
-- Name: poi_routes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: samcartwright
--

ALTER SEQUENCE public.poi_routes_id_seq OWNED BY public.poi_routes.id;


--
-- Name: pois; Type: TABLE; Schema: public; Owner: samcartwright
--

CREATE TABLE public.pois (
    id bigint NOT NULL,
    name character varying,
    short_name character varying,
    google_url character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    poi_type character varying DEFAULT 'parking'::character varying NOT NULL
);


ALTER TABLE public.pois OWNER TO samcartwright;

--
-- Name: pois_id_seq; Type: SEQUENCE; Schema: public; Owner: samcartwright
--

CREATE SEQUENCE public.pois_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pois_id_seq OWNER TO samcartwright;

--
-- Name: pois_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: samcartwright
--

ALTER SEQUENCE public.pois_id_seq OWNED BY public.pois.id;


--
-- Name: problems; Type: TABLE; Schema: public; Owner: samcartwright
--

CREATE TABLE public.problems (
    id bigint NOT NULL,
    name character varying,
    grade character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    location public.geography(Point,4326),
    circuit_id bigint,
    circuit_number character varying,
    steepness character varying NOT NULL,
    height integer,
    area_id bigint,
    bleau_info_id integer,
    landing character varying,
    featured boolean DEFAULT false NOT NULL,
    parent_id bigint,
    ratings_average numeric,
    ratings integer,
    ascents integer,
    popularity integer,
    circuit_letter character varying,
    sit_start boolean DEFAULT false NOT NULL,
    has_line boolean DEFAULT false NOT NULL
);


ALTER TABLE public.problems OWNER TO samcartwright;

--
-- Name: problems_id_seq; Type: SEQUENCE; Schema: public; Owner: samcartwright
--

CREATE SEQUENCE public.problems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.problems_id_seq OWNER TO samcartwright;

--
-- Name: problems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: samcartwright
--

ALTER SEQUENCE public.problems_id_seq OWNED BY public.problems.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: samcartwright
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO samcartwright;

--
-- Name: topos; Type: TABLE; Schema: public; Owner: samcartwright
--

CREATE TABLE public.topos (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    published boolean DEFAULT true NOT NULL,
    metadata json
);


ALTER TABLE public.topos OWNER TO samcartwright;

--
-- Name: topos_id_seq; Type: SEQUENCE; Schema: public; Owner: samcartwright
--

CREATE SEQUENCE public.topos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.topos_id_seq OWNER TO samcartwright;

--
-- Name: topos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: samcartwright
--

ALTER SEQUENCE public.topos_id_seq OWNED BY public.topos.id;


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: areas id; Type: DEFAULT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.areas ALTER COLUMN id SET DEFAULT nextval('public.areas_id_seq'::regclass);


--
-- Name: audits id; Type: DEFAULT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.audits ALTER COLUMN id SET DEFAULT nextval('public.audits_id_seq'::regclass);


--
-- Name: bleau_areas id; Type: DEFAULT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.bleau_areas ALTER COLUMN id SET DEFAULT nextval('public.bleau_areas_id_seq'::regclass);


--
-- Name: bleau_problems id; Type: DEFAULT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.bleau_problems ALTER COLUMN id SET DEFAULT nextval('public.bleau_problems_id_seq'::regclass);


--
-- Name: boulders id; Type: DEFAULT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.boulders ALTER COLUMN id SET DEFAULT nextval('public.boulders_id_seq'::regclass);


--
-- Name: circuits id; Type: DEFAULT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.circuits ALTER COLUMN id SET DEFAULT nextval('public.circuits_id_seq'::regclass);


--
-- Name: contribution_requests id; Type: DEFAULT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.contribution_requests ALTER COLUMN id SET DEFAULT nextval('public.contribution_requests_id_seq'::regclass);


--
-- Name: contributions id; Type: DEFAULT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.contributions ALTER COLUMN id SET DEFAULT nextval('public.contributions_id_seq'::regclass);


--
-- Name: imports id; Type: DEFAULT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.imports ALTER COLUMN id SET DEFAULT nextval('public.imports_id_seq'::regclass);


--
-- Name: lines id; Type: DEFAULT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.lines ALTER COLUMN id SET DEFAULT nextval('public.lines_id_seq'::regclass);


--
-- Name: poi_routes id; Type: DEFAULT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.poi_routes ALTER COLUMN id SET DEFAULT nextval('public.poi_routes_id_seq'::regclass);


--
-- Name: pois id; Type: DEFAULT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.pois ALTER COLUMN id SET DEFAULT nextval('public.pois_id_seq'::regclass);


--
-- Name: problems id; Type: DEFAULT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.problems ALTER COLUMN id SET DEFAULT nextval('public.problems_id_seq'::regclass);


--
-- Name: topos id; Type: DEFAULT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.topos ALTER COLUMN id SET DEFAULT nextval('public.topos_id_seq'::regclass);


--
-- Data for Name: active_storage_attachments; Type: TABLE DATA; Schema: public; Owner: samcartwright
--

COPY public.active_storage_attachments (id, name, record_type, record_id, blob_id, created_at) FROM stdin;
\.


--
-- Data for Name: active_storage_blobs; Type: TABLE DATA; Schema: public; Owner: samcartwright
--

COPY public.active_storage_blobs (id, key, filename, content_type, metadata, byte_size, checksum, created_at, service_name) FROM stdin;
\.


--
-- Data for Name: active_storage_variant_records; Type: TABLE DATA; Schema: public; Owner: samcartwright
--

COPY public.active_storage_variant_records (id, blob_id, variation_digest) FROM stdin;
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: samcartwright
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2024-05-06 13:26:38.177159	2024-05-06 13:26:38.177159
schema_sha1	6aaeb578904347b66e2eea4e7bab7923c3a3a73c	2024-05-11 09:57:08.100781	2024-05-11 09:57:08.100783
\.


--
-- Data for Name: areas; Type: TABLE DATA; Schema: public; Owner: samcartwright
--

COPY public.areas (id, name, created_at, updated_at, published, slug, tags, short_name, priority, description_fr, description_en, warning_fr, warning_en, bleau_area_id) FROM stdin;
1	Shaftoe	2024-05-11 21:36:28.528787	2024-05-11 21:36:28.528787	t	shaftoe	{}	\N	1	\N	\N	\N	\N	\N
2	Rothley	2024-05-11 21:40:46.950028	2024-05-11 21:40:46.950028	t	rothley	{}	\N	1	\N	\N	\N	\N	\N
3	Jesmond Dene	2024-05-11 21:48:39.729683	2024-05-11 21:48:39.729683	t	jesmond-dene	{}	\N	1	\N	\N	\N	\N	\N
4	Queens Crag	2024-05-11 21:51:06.92671	2024-05-11 21:51:06.92671	t	queens-crag	{}	\N	1	\N	\N	\N	\N	\N
5	Howlerhirst Crag	2024-05-11 21:56:24.799871	2024-05-11 21:56:24.799871	t	howlerhirst	{}	\N	1	\N	\N	\N	\N	\N
7	Berryhill	2024-05-11 21:57:30.415129	2024-05-11 21:57:30.415129	t	berryhill	{}	\N	1	\N	\N	\N	\N	\N
6	Back Bowden Doors	2024-05-11 21:56:49.820597	2024-05-11 21:56:49.820597	t	back-bowden	{}	\N	1	\N	\N	\N	\N	\N
9	Bowden Doors	2024-05-11 21:58:39.850688	2024-05-11 21:58:39.850688	t	bowden-doors	{}	\N	1	\N	\N	\N	\N	\N
10	Caller Crag	2024-05-11 21:59:06.700383	2024-05-11 21:59:06.700383	t	caller	{}	\N	1	\N	\N	\N	\N	\N
11	Callerhues Crag	2024-05-11 22:02:16.522205	2024-05-11 22:02:16.522205	t	callerhues	{}	\N	1	\N	\N	\N	\N	\N
12	Dovehole	2024-05-11 22:03:01.466598	2024-05-11 22:03:01.466598	t	dovehole	{}	\N	1	\N	\N	\N	\N	\N
13	Edlingham	2024-05-11 22:04:37.28352	2024-05-11 22:04:37.28352	t	edlingham	{}	\N	1	\N	\N	\N	\N	\N
14	Garleigh	2024-05-11 22:04:59.878669	2024-05-11 22:04:59.878669	t	garleigh	{}	\N	1	\N	\N	\N	\N	\N
15	Gimmerknowe	2024-05-11 22:05:19.422852	2024-05-11 22:05:19.422852	t	gimmerknowe	{}	\N	1	\N	\N	\N	\N	\N
16	Goats Crag	2024-05-11 22:05:52.996217	2024-05-11 22:05:52.996217	t	goats-crag	{}	\N	1	\N	\N	\N	\N	\N
17	Heckley	2024-05-11 22:06:34.529456	2024-05-11 22:06:34.529456	t	heckley	{}	\N	1	\N	\N	\N	\N	\N
18	Hepburn	2024-05-11 22:06:51.775226	2024-05-11 22:06:51.775226	t	hepburn	{}	\N	1	\N	\N	\N	\N	\N
19	Kyloe Crag (Kyloe out)	2024-05-11 22:08:12.857746	2024-05-11 22:08:12.857746	t	kyloe-out	{}	\N	1	\N	\N	\N	\N	\N
20	Kyloe In The Woods	2024-05-11 22:08:34.467787	2024-05-11 22:08:34.467787	t	kyloe-in	{}	\N	1	\N	\N	\N	\N	\N
21	Oxen Wood	2024-05-11 22:08:58.26262	2024-05-11 22:08:58.26262	t	oxen-wood	{}	\N	1	\N	\N	\N	\N	\N
22	Redheugh	2024-05-11 22:10:39.037938	2024-05-11 22:10:39.037938	t	redheugh	{}	\N	1	\N	\N	\N	\N	\N
23	Simonside Hills	2024-05-11 22:11:26.695975	2024-05-11 22:11:26.695975	t	simonside	{}	\N	1	\N	\N	\N	\N	\N
24	Widehope	2024-05-11 22:11:52.035166	2024-05-11 22:11:52.035166	t	widehope	{}	\N	1	\N	\N	\N	\N	\N
\.


--
-- Data for Name: audits; Type: TABLE DATA; Schema: public; Owner: samcartwright
--

COPY public.audits (id, auditable_id, auditable_type, associated_id, associated_type, user_id, user_type, username, action, audited_changes, version, comment, remote_address, request_uuid, created_at) FROM stdin;
\.


--
-- Data for Name: bleau_areas; Type: TABLE DATA; Schema: public; Owner: samcartwright
--

COPY public.bleau_areas (id, slug, created_at, updated_at, name, category) FROM stdin;
\.


--
-- Data for Name: bleau_problems; Type: TABLE DATA; Schema: public; Owner: samcartwright
--

COPY public.bleau_problems (id, name, grade, steepness, sit_start, tags, bleau_circuit_id, circuit_number, circuit_letter, ascents, ratings, ratings_average, bleau_area_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: boulders; Type: TABLE DATA; Schema: public; Owner: samcartwright
--

COPY public.boulders (id, polygon, created_at, updated_at, area_id, ignore_for_area_hull) FROM stdin;
\.


--
-- Data for Name: circuits; Type: TABLE DATA; Schema: public; Owner: samcartwright
--

COPY public.circuits (id, color, created_at, updated_at, risk) FROM stdin;
\.


--
-- Data for Name: contribution_requests; Type: TABLE DATA; Schema: public; Owner: samcartwright
--

COPY public.contribution_requests (id, what, state, location_estimated, problem_id, created_at, updated_at, comment) FROM stdin;
\.


--
-- Data for Name: contributions; Type: TABLE DATA; Schema: public; Owner: samcartwright
--

COPY public.contributions (id, problem_id, comment, location, created_at, updated_at, contributor_name, contributor_email, state, problem_name, problem_url) FROM stdin;
\.


--
-- Data for Name: imports; Type: TABLE DATA; Schema: public; Owner: samcartwright
--

COPY public.imports (id, applied_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: lines; Type: TABLE DATA; Schema: public; Owner: samcartwright
--

COPY public.lines (id, coordinates, problem_id, topo_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: poi_routes; Type: TABLE DATA; Schema: public; Owner: samcartwright
--

COPY public.poi_routes (id, distance, transport, area_id, poi_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: pois; Type: TABLE DATA; Schema: public; Owner: samcartwright
--

COPY public.pois (id, name, short_name, google_url, created_at, updated_at, poi_type) FROM stdin;
\.


--
-- Data for Name: problems; Type: TABLE DATA; Schema: public; Owner: samcartwright
--

COPY public.problems (id, name, grade, created_at, updated_at, location, circuit_id, circuit_number, steepness, height, area_id, bleau_info_id, landing, featured, parent_id, ratings_average, ratings, ascents, popularity, circuit_letter, sit_start, has_line) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: samcartwright
--

COPY public.schema_migrations (version) FROM stdin;
20200416080911
20200416122424
20200416193749
20200416195009
20200416195506
20200416200511
20200416201305
20200418095046
20200418194159
20200418210357
20200419083233
20200419083551
20200419083712
20200428120744
20200428150852
20200507130052
20200509193959
20200704211106
20200705193814
20201019194907
20201101094419
20201101100712
20201101160643
20210126155249
20210126155250
20210130194726
20200415175547
20210224092634
20210310211006
20210405160635
20210507110726
20210513163723
20210529140523
20210609100827
20210618163152
20221019184904
20221024154350
20221026082130
20221129095701
20221207164950
20221214073647
20221214163656
20221216073817
20221231123132
20221231123215
20221231132049
20221231191918
20230105082925
20230108095221
20230108101400
20230112123704
20230112124430
20230112124744
20230428202917
20230627091503
20230704072308
20230704092226
20230704151659
20230710092750
20231005145400
20231010112108
20231027150035
20231103111453
20231103111627
20231109163340
20231207155225
20231211140316
20231211171435
20231211183004
20240105155516
20240112081452
20240115105248
20240115113733
20240115143426
20240118093938
20240202132547
20240425074350
20240506183020
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: samcartwright
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: topos; Type: TABLE DATA; Schema: public; Owner: samcartwright
--

COPY public.topos (id, created_at, updated_at, published, metadata) FROM stdin;
\.


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: samcartwright
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 1, false);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: samcartwright
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 1, false);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: samcartwright
--

SELECT pg_catalog.setval('public.active_storage_variant_records_id_seq', 1, false);


--
-- Name: areas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: samcartwright
--

SELECT pg_catalog.setval('public.areas_id_seq', 24, true);


--
-- Name: audits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: samcartwright
--

SELECT pg_catalog.setval('public.audits_id_seq', 1, false);


--
-- Name: bleau_areas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: samcartwright
--

SELECT pg_catalog.setval('public.bleau_areas_id_seq', 1, false);


--
-- Name: bleau_problems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: samcartwright
--

SELECT pg_catalog.setval('public.bleau_problems_id_seq', 1, false);


--
-- Name: boulders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: samcartwright
--

SELECT pg_catalog.setval('public.boulders_id_seq', 1, false);


--
-- Name: circuits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: samcartwright
--

SELECT pg_catalog.setval('public.circuits_id_seq', 1, false);


--
-- Name: contribution_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: samcartwright
--

SELECT pg_catalog.setval('public.contribution_requests_id_seq', 1, false);


--
-- Name: contributions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: samcartwright
--

SELECT pg_catalog.setval('public.contributions_id_seq', 1, false);


--
-- Name: imports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: samcartwright
--

SELECT pg_catalog.setval('public.imports_id_seq', 1, false);


--
-- Name: lines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: samcartwright
--

SELECT pg_catalog.setval('public.lines_id_seq', 1, false);


--
-- Name: poi_routes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: samcartwright
--

SELECT pg_catalog.setval('public.poi_routes_id_seq', 1, false);


--
-- Name: pois_id_seq; Type: SEQUENCE SET; Schema: public; Owner: samcartwright
--

SELECT pg_catalog.setval('public.pois_id_seq', 1, false);


--
-- Name: problems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: samcartwright
--

SELECT pg_catalog.setval('public.problems_id_seq', 1, false);


--
-- Name: topos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: samcartwright
--

SELECT pg_catalog.setval('public.topos_id_seq', 1, false);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: areas areas_pkey; Type: CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_pkey PRIMARY KEY (id);


--
-- Name: audits audits_pkey; Type: CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.audits
    ADD CONSTRAINT audits_pkey PRIMARY KEY (id);


--
-- Name: bleau_areas bleau_areas_pkey; Type: CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.bleau_areas
    ADD CONSTRAINT bleau_areas_pkey PRIMARY KEY (id);


--
-- Name: bleau_problems bleau_problems_pkey; Type: CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.bleau_problems
    ADD CONSTRAINT bleau_problems_pkey PRIMARY KEY (id);


--
-- Name: boulders boulders_pkey; Type: CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.boulders
    ADD CONSTRAINT boulders_pkey PRIMARY KEY (id);


--
-- Name: circuits circuits_pkey; Type: CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.circuits
    ADD CONSTRAINT circuits_pkey PRIMARY KEY (id);


--
-- Name: contribution_requests contribution_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.contribution_requests
    ADD CONSTRAINT contribution_requests_pkey PRIMARY KEY (id);


--
-- Name: contributions contributions_pkey; Type: CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.contributions
    ADD CONSTRAINT contributions_pkey PRIMARY KEY (id);


--
-- Name: imports imports_pkey; Type: CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.imports
    ADD CONSTRAINT imports_pkey PRIMARY KEY (id);


--
-- Name: lines lines_pkey; Type: CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.lines
    ADD CONSTRAINT lines_pkey PRIMARY KEY (id);


--
-- Name: poi_routes poi_routes_pkey; Type: CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.poi_routes
    ADD CONSTRAINT poi_routes_pkey PRIMARY KEY (id);


--
-- Name: pois pois_pkey; Type: CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.pois
    ADD CONSTRAINT pois_pkey PRIMARY KEY (id);


--
-- Name: problems problems_pkey; Type: CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.problems
    ADD CONSTRAINT problems_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: topos topos_pkey; Type: CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.topos
    ADD CONSTRAINT topos_pkey PRIMARY KEY (id);


--
-- Name: associated_index; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX associated_index ON public.audits USING btree (associated_type, associated_id);


--
-- Name: auditable_index; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX auditable_index ON public.audits USING btree (auditable_type, auditable_id, version);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_areas_on_slug; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE UNIQUE INDEX index_areas_on_slug ON public.areas USING btree (slug);


--
-- Name: index_areas_on_tags; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX index_areas_on_tags ON public.areas USING gin (tags);


--
-- Name: index_audits_on_created_at; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX index_audits_on_created_at ON public.audits USING btree (created_at);


--
-- Name: index_audits_on_request_uuid; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX index_audits_on_request_uuid ON public.audits USING btree (request_uuid);


--
-- Name: index_bleau_areas_on_slug; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE UNIQUE INDEX index_bleau_areas_on_slug ON public.bleau_areas USING btree (slug);


--
-- Name: index_bleau_problems_on_bleau_area_id; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX index_bleau_problems_on_bleau_area_id ON public.bleau_problems USING btree (bleau_area_id);


--
-- Name: index_bleau_problems_on_bleau_circuit_id; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX index_bleau_problems_on_bleau_circuit_id ON public.bleau_problems USING btree (bleau_circuit_id);


--
-- Name: index_boulders_on_area_id; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX index_boulders_on_area_id ON public.boulders USING btree (area_id);


--
-- Name: index_contribution_requests_on_problem_id; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX index_contribution_requests_on_problem_id ON public.contribution_requests USING btree (problem_id);


--
-- Name: index_contribution_requests_on_state; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX index_contribution_requests_on_state ON public.contribution_requests USING btree (state);


--
-- Name: index_contribution_requests_on_what; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX index_contribution_requests_on_what ON public.contribution_requests USING btree (what);


--
-- Name: index_contributions_on_problem_id; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX index_contributions_on_problem_id ON public.contributions USING btree (problem_id);


--
-- Name: index_lines_on_problem_id; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX index_lines_on_problem_id ON public.lines USING btree (problem_id);


--
-- Name: index_lines_on_topo_id; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX index_lines_on_topo_id ON public.lines USING btree (topo_id);


--
-- Name: index_poi_routes_on_area_id; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX index_poi_routes_on_area_id ON public.poi_routes USING btree (area_id);


--
-- Name: index_poi_routes_on_poi_id; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX index_poi_routes_on_poi_id ON public.poi_routes USING btree (poi_id);


--
-- Name: index_problems_on_area_id; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX index_problems_on_area_id ON public.problems USING btree (area_id);


--
-- Name: index_problems_on_circuit_id; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX index_problems_on_circuit_id ON public.problems USING btree (circuit_id);


--
-- Name: index_problems_on_grade; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX index_problems_on_grade ON public.problems USING btree (grade);


--
-- Name: index_problems_on_has_line; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX index_problems_on_has_line ON public.problems USING btree (has_line);


--
-- Name: index_problems_on_location; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX index_problems_on_location ON public.problems USING gist (location);


--
-- Name: user_index; Type: INDEX; Schema: public; Owner: samcartwright
--

CREATE INDEX user_index ON public.audits USING btree (user_id, user_type);


--
-- Name: boulders fk_rails_2e5c243105; Type: FK CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.boulders
    ADD CONSTRAINT fk_rails_2e5c243105 FOREIGN KEY (area_id) REFERENCES public.areas(id);


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: problems fk_rails_d3a7f4c434; Type: FK CONSTRAINT; Schema: public; Owner: samcartwright
--

ALTER TABLE ONLY public.problems
    ADD CONSTRAINT fk_rails_d3a7f4c434 FOREIGN KEY (area_id) REFERENCES public.areas(id);


--
-- PostgreSQL database dump complete
--

