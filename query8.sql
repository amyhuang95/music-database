-- Write a query that lists all the tracks that are not in one of the top 5 
-- genres with longer duration in the database.
WITH top_5_genres AS (
	-- Get GenreId of the top 5 genres with longer duration
	SELECT GenreId
	FROM tracks
	GROUP BY GenreId
	ORDER BY SUM(Milliseconds) DESC
	LIMIT 5
)
SELECT Name
FROM tracks
LEFT JOIN top_5_genres
	ON tracks.GenreId = top_5_genres.GenreId
WHERE top_5_genres.GenreId IS NULL;