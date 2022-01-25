![](https://img.shields.io/badge/Microverse-blueviolet)  &nbsp; &nbsp;  ![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)

# Vet Clinic Database

> In this project I created a relational database for a fictional vet clinic.

I got to create, update, populate and query several tables

- **animals**: data about the animals in the clinic
- **owners**: data about the people that own the animals
- **species**: data about the species of the animals
- **vets**: data about the vets that are in charge of the animals
- **specializations**: specializations of the vets
- **visits**: data about the visits that the animals have had and the vets that did them

Then I wrote simple and complex queries to answer the a bunch of questions.
Some of those questions are simple and some are more complex. 
The simple ones include:

- Find all the animals whose name ends in 'mon'.
- What is the date of birth of all animals named either 'Agumon' or 'Pikachu'.

For the complex ones, I made used of more advanced commands, like `JOIN` and `GROUP BY` or aggregation function like `COUNT` or `AVG`

- Find the last animal seen by vet 'William Tatcher'
- How many animals are there per species?
- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
- How many visits were with a vet that did not specialize in that animal's species?


## Getting Started

This repository includes files with plain SQL that can be used to recreate a database:

- Use [schema.sql](./schema.sql) to create all tables.
- Use [data.sql](./data.sql) to populate tables with sample data.
- Check [queries.sql](./queries.sql) for examples of queries that can be run on a newly created database. **Important note: this file might include queries that make changes in the database (e.g., remove records). Use them responsibly!**



## Author

👤 **King Josaphat Chewa (KJC)**

- GitHub: [@Kingjosh007](https://github.com/Kingjosh007)
- Twitter: [@KingJoChewa](https://twitter.com/KingJoChewa)
- LinkedIn: [LinkedIn](https://www.linkedin.com/in/king-josaphat-chewa/)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Heartfelt thanks to Microverse

## 📝 License

This project is **MIT** licensed.
