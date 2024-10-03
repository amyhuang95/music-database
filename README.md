# music-database

This project demonstrates the use of SQL to modify and query a music database using SQLite. The database used is the Chinook database provided by [SQLite Tutorial](https://www.sqlitetutorial.net/sqlite-sample-database/).

This project was developed as part of the course _CS 5200 Database Management Systems_ taught by Professor John Alexis Guerra Gomez at the Northeastern University (Oakland).

## How to run the queries:

1. Download the Chinook database from the link: https://www.sqlitetutorial.net/sqlite-sample-database/. Unzip the file and you will get the `chinook.db` file.
2. Download the `.sql` files from this repository, and place them in the same directory as the `chinook.db` file.
3. Run the following commands for each `.sql` file in the terminal. Change the query number to the number of the query you want to run.

```bash
sqlite3 chinook.db < query1.sql
sqlite3 chinook.db
```

## Queries

Query 1: Create a new Table Music Video, that is a class of type Track (generalization) but adds the attribute Video director. A music video is a track. There cannot be a video without a track, and each track can have either no video or just one.

Query 2: Write the queries that insert at least 10 videos, respecting the problem rules.

Query 3: Insert another video for the track "Voodoo", assuming that you don't know the TrackId, so your insert query should specify the TrackId directly.

Query 4: Write a query that lists all the tracks that have a ' in the name (e.g. Jorge Da Capadócia, o Samba De Uma Nota Só (One Note Samba)) (this is á,é,í,ó,ú)

Query 5: Creative addition. Make an interesting query that uses a JOIN of at least two tables.

Query 6: Creative addition. Make an interesting query that uses a GROUP statement and at least two tables.

Query 7: Write a query that lists all the customers that listen to longer-than-average tracks, excluding the tracks that are longer than 15 minutes.

Query 8: Write a query that lists all the tracks that are not in one of the top 5 genres with longer duration in the database.
