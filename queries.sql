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


-- QUERIES USING JOIN 

-- What animals belong to Melody Pond?
SELECT full_name, name FROM animals A JOIN owners O ON A.owner_id = O.id WHERE O.full_name = 'Melody Pond';

-- List of all animals that are Pokemon
SELECT * FROM animals A JOIN species S ON A.species_id = S.id WHERE S.name = 'Pokemon';

-- List all owners and their animals, including those who don't own any animal.
SELECT full_name, name FROM owners O FULL JOIN animals A ON O.id = A.owner_id;

-- How many animals are there per species?
SELECT S.name, COUNT(A.name) FROM species S JOIN animals A ON S.id = A.species_id GROUP BY S.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT O.full_name as owner, A.name as animal_type_digimon 
    FROM owners O JOIN animals A ON O.id = A.owner_id 
    JOIN species S ON S.id = A.species_id
    WHERE O.full_name = 'Jennifer Orwell' AND S.name = 'Digimon';


-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT O.full_name, A.name, A.date_of_birth, A.escape_attempts 
    FROM animals A JOIN owners O ON A.owner_id = O.id 
    WHERE O.full_name = 'Dean Winchester' AND A.escape_attempts = 0;
    

-- Who owns the most animals
SELECT O.full_name, COUNT(A.name) AS nb_animals
    FROM owners O JOIN animals A ON O.id = A.owner_id
    GROUP BY O.full_name ORDER BY COUNT(A.name) DESC;



-- Last animal seen by vet 'William Tatcher'
SELECT Vi.id as visit_id, A.name as animal_name, V.name as vet_name, Vi.date_of_visit
    FROM animals A JOIN visits Vi ON A.id = Vi.animal_id 
    JOIN vets V ON Vi.vet_id = V.id
    WHERE V.name = 'William Tatcher' ORDER BY Vi.date_of_visit DESC LIMIT 1;


-- How many different animals did Stephanie Mendez see?
SELECT V.name as vet_name, COUNT(DISTINCT A.name) as nb_diff_animals
    FROM animals A JOIN visits Vi ON A.id = Vi.animal_id 
    JOIN vets V ON Vi.vet_id = V.id
    GROUP BY V.name HAVING V.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT V.name as vet_name, Sp.name as vet_specializations 
    FROM vets V FULL JOIN specializations S ON V.id = S.vet_id
    FULL JOIN species Sp ON Sp.id = S.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT A.name as animal_name, Vi.date_of_visit, V.name as vet_name
    FROM animals A JOIN visits Vi ON A.id = Vi.animal_id 
    JOIN vets V ON Vi.vet_id = V.id
    WHERE V.name = 'Stephanie Mendez' AND Vi.date_of_visit >= '2020-04-01' AND Vi.date_of_visit <= '2020-08-30';

-- What animal has the most visits to vets?
SELECT A.name as animal_name, COUNT(Vi.id) as nb_visits
    FROM animals A JOIN visits Vi ON A.id = Vi.animal_id 
    GROUP BY A.name ORDER BY COUNT(Vi.id) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT A.name as animal_name, V.name as vet_name, Vi.date_of_visit
    FROM animals A JOIN visits Vi ON A.id = Vi.animal_id 
    JOIN vets V ON Vi.vet_id = V.id
    WHERE V.name = 'Maisy Smith' ORDER BY Vi.date_of_visit ASC LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT A.name AS animal_name, A.date_of_birth, A.escape_attempts, A.neutered, A.weight_kg, 
       V.name AS vet_name, V.age, v.date_of_graduation,
       Vi.date_of_visit 
       FROM animals A JOIN visits Vi ON A.id = Vi.animal_id 
       JOIN vets V ON V.id = Vi.vet_id ORDER BY Vi.date_of_visit DESC LIMIT 1;