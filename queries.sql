-- Queries requested in the project specifications;

-- Animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';

-- Names of animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';

-- Names of animals that are neutered and tried to escape less than 3 times.
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

-- Date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- Name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- All animals that are neutered
SELECT * FROM animals WHERE neutered = true;

-- All animals not named 'Gabumon'
SELECT * FROM animals WHERE name != 'Gabumon';

-- All animal with weight >= 10.4kg and weight <= 17.3kg
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;



-- TRANSACTIONS

-- Transaction to set the species columns to 'unspecified' for all animals. Then roll back and verify that the species column went back to previous values.
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Transaction to update the animals table by setting the species column for all animals
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
-- Commit the transaction and verify the changes are made and persisted.
COMMIT;
SELECT * FROM animals;


-- Delete all records in the animals table
BEGIN;
DELETE FROM animals;
-- Roll back
ROLLBACK;
SELECT * FROM animals;


-- Transaction with a bunch of queries

--Delete all animals born after Jan 1st, 2022.
BEGIN;
DELETE FROM animals WHERE date_of_birth >= '2022-01-01';

-- Create a savepoint for the transaction
SAVEPOINT animals_deleted;

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1;

-- Roll back to the savepoint
ROLLBACK TO animals_deleted;

-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

-- Commit the transaction
COMMIT;


-- QUERIES

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered ORDER BY SUM(escape_attempts) DESC;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;

