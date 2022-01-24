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

-- Modify animals table
-- Remove column species
ALTER TABLE animals DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_animals_species FOREIGN KEY(species_id) REFERENCES species(id);

-- Add a column named owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_animals_owners FOREIGN KEY(owner_id) REFERENCES owners(id);


-- Create a table named vets
DROP TABLE IF EXISTS vets;
CREATE TABLE IF NOT EXISTS vets(
 id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 name TEXT,
 age INT,
 date_of_graduation DATE
);

-- Create a join table named specializations
DROP TABLE IF EXISTS specializations;
CREATE TABLE IF NOT EXISTS specializations(
 id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 vet_id INT NOT NULL,
 species_id INT NOT NULL,
 CONSTRAINT fk_specializations_vets FOREIGN KEY(vet_id) REFERENCES vets(id) 
            ON DELETE CASCADE
            ON UPDATE CASCADE,
 CONSTRAINT fk_specializations_species FOREIGN KEY(species_id) REFERENCES species(id) 
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

-- Create a join table named visits to handle the many-to-many relationship between animals and vets
DROP TABLE IF EXISTS visits;
CREATE TABLE IF NOT EXISTS visits(
 id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 animal_id INT NOT NULL,
 vet_id INT NOT NULL,
 date_of_visit DATE,
 CONSTRAINT fk_visits_animals FOREIGN KEY(animal_id) REFERENCES animals(id) 
            ON DELETE CASCADE
            ON UPDATE CASCADE,
 CONSTRAINT fk_visits_vets FOREIGN KEY(vet_id) REFERENCES vets(id)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);
-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Create index on animal_id in visits table 
CREATE INDEX animal_id_visits_index ON visits(animal_id ASC);

-- Create index on vet_id in visits table 
CREATE INDEX vet_id_visits_index ON visits(vet_id ASC);

