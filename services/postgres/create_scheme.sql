-- Table: public.customers

-- DROP TABLE IF EXISTS public.customers;

CREATE TABLE IF NOT EXISTS public.customers
(
    id SERIAL NOT NULL,
    name character varying(80) COLLATE pg_catalog."default" NOT NULL,
    surname character varying(80) COLLATE pg_catalog."default" NOT NULL,
    birthday date NOT NULL,
    email character varying(256) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT customers_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.customers
    OWNER to bingo;
-- Index: customers_birthday

-- DROP INDEX IF EXISTS public.customers_birthday;

CREATE INDEX IF NOT EXISTS customers_birthday
    ON public.customers USING btree
    (birthday ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: customers_email_index

-- DROP INDEX IF EXISTS public.customers_email_index;

CREATE INDEX IF NOT EXISTS customers_email
    ON public.customers USING btree
    (email COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: customers_id

-- DROP INDEX IF EXISTS public.customers_id;

CREATE UNIQUE INDEX IF NOT EXISTS customers_id
    ON public.customers USING btree
    (id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: customers_name

-- DROP INDEX IF EXISTS public.customers_name;

CREATE INDEX IF NOT EXISTS customers_name
    ON public.customers USING btree
    (name COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: customers_surname

-- DROP INDEX IF EXISTS public.customers_surname;

CREATE INDEX IF NOT EXISTS customers_surname
    ON public.customers USING btree
    (surname COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.movies

-- DROP TABLE IF EXISTS public.movies;

CREATE TABLE IF NOT EXISTS public.movies
(
    id SERIAL NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    year integer NOT NULL,
    duration bigint NOT NULL,
    CONSTRAINT movies_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.movies
    OWNER to bingo;
-- Index: movies_duration

-- DROP INDEX IF EXISTS public.movies_duration;

CREATE INDEX IF NOT EXISTS movies_duration
    ON public.movies USING btree
    (duration ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: movies_id

-- DROP INDEX IF EXISTS public.movies_id;

CREATE UNIQUE INDEX IF NOT EXISTS movies_id
    ON public.movies USING btree
    (id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: movies_name

-- DROP INDEX IF EXISTS public.movies_name;

CREATE INDEX IF NOT EXISTS movies_name
    ON public.movies USING btree
    (name COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: movies_year

-- DROP INDEX IF EXISTS public.movies_year;

CREATE INDEX IF NOT EXISTS movies_year
    ON public.movies USING btree
    (year ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.sessions

-- DROP TABLE IF EXISTS public.sessions;

CREATE TABLE IF NOT EXISTS public.sessions
(
    id BIGSERIAL NOT NULL,
    start_time timestamp without time zone NOT NULL,
    customer_id integer NOT NULL,
    movie_id integer NOT NULL,
    CONSTRAINT sessions_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.sessions
    OWNER to bingo;
-- Index: sessions_customer_id

-- DROP INDEX IF EXISTS public.sessions_customer_id;

CREATE INDEX IF NOT EXISTS sessions_customer_id
    ON public.sessions USING btree
    (customer_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: sessions_id

-- DROP INDEX IF EXISTS public.sessions_id;

CREATE UNIQUE INDEX IF NOT EXISTS sessions_id
    ON public.sessions USING btree
    (id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: sessions_movie_id

-- DROP INDEX IF EXISTS public.sessions_movie_id;

CREATE INDEX IF NOT EXISTS sessions_movie_id
    ON public.sessions USING btree
    (movie_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: sessions_start_time

-- DROP INDEX IF EXISTS public.sessions_start_time;

CREATE INDEX IF NOT EXISTS sessions_start_time
    ON public.sessions USING btree
    (start_time ASC NULLS LAST)
    TABLESPACE pg_default;
