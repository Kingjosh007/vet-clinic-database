-- Table: animals

DROP TABLE IF EXISTS animals;

CREATE TABLE IF NOT EXISTS animals
(
    id BIGSERIAL PRIMARY KEY,
    name TEXT,
    date_of_birth DATE,
    escape_attempts INTEGER DEFAULT 0,
    neutered boolean DEFAULT false,
    weight_kg NUMERIC,
);