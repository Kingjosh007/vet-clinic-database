-- Table: public.animals

-- DROP TABLE IF EXISTS public.animals;

CREATE TABLE IF NOT EXISTS public.animals
(
    id integer NOT NULL,
    name text COLLATE pg_catalog."default",
    date_of_birth date,
    escape_attempts integer DEFAULT 0,
    neutered boolean DEFAULT false,
    weight_kg numeric,
    CONSTRAINT animals_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.animals
    OWNER to postgres;