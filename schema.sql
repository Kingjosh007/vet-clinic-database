-- Table: animals

DROP TABLE IF EXISTS animals;

CREATE TABLE IF NOT EXISTS animals
(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT,
    date_of_birth DATE,
    escape_attempts INTEGER DEFAULT 0,
    neutered boolean DEFAULT false,
    weight_kg NUMERIC
)

-- Add a column species of type string to your animals table
ALTER TABLE animals ADD species TEXT;


-- Create a table named owners
DROP TABLE IF EXISTS owners;
CREATE TABLE IF NOT EXISTS owners(
 id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 full_name TEXT,
 age INT
);

-- Create a table named species
DROP TABLE IF EXISTS species;
CREATE TABLE IF NOT EXISTS species(
 id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 name TEXT
);

