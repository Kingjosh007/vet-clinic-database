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

