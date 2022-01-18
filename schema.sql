-- Table: animals

DROP TABLE IF EXISTS animals;

CREATE TABLE IF NOT EXISTS animals
(
    id integer NOT NULL AUTO_INCREMENT,
    name text,
    date_of_birth date,
    escape_attempts integer DEFAULT 0,
    neutered boolean DEFAULT false,
    weight_kg numeric,
    CONSTRAINT animals_pkey PRIMARY KEY (id)
);