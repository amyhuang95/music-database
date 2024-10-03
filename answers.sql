-- Questions: 
-- query 7 - excluding tracks > 15 mins when calculating the avg not when listing the final result?
-- query 8 - top 5 genres with longer duration in terms of total or avg duration?

-- Query 1: 
-- Create a new Table Music Video, that is a class of type Track (generalization)
-- but adds the attribute Video director. A music video is a track. 
-- There cannot be a video without a track, and each track can have either no video or just one. 
CREATE TABLE "music_video" (
	"MusicVideoId"	INTEGER NOT NULL UNIQUE,
	"TrackId"	INTEGER NOT NULL,
	"Director"	TEXT NOT NULL,
	PRIMARY KEY("MusicVideoId" AUTOINCREMENT),
	FOREIGN KEY("TrackId") REFERENCES "tracks"("TrackId")
);

-- Query 2
-- Write the queries that insert at least 10 videos, respecting the problem rules.
INSERT INTO music_video (TrackId, Director)
VALUES 	(22, "Hayao Miyazaki"),
		(10, "Yimou Zhang"),
		(9, "Ang Lee"),
		(13, "Bong Joon-ho"),
		(23, "Hsiao-Hsien Hou"),
		(40, "Xiaogang Feng"),
		(52, "Takeshi Kitano"),
		(28, "Apichatpong Weerasethakul"),
		(19, "Atiq Rahimi"),
		(45, "Samuel Maoz");

-- Query 3
-- Insert another video for the track "Voodoo", assuming that you don't know 
-- the TrackId, so your insert query should specify the TrackId directly.
INSERT INTO music_video (TrackId, Director)
	SELECT TrackId, "Voodoo Director"
	FROM tracks 
	WHERE Name == "Voodoo";


-- Query 4
-- Write a query that lists all the tracks that have a ' in the name (e.g. 
-- Jorge Da Capadócia, o Samba De Uma Nota Só (One Note Samba))
SELECT *
FROM tracks
WHERE Name LIKE '%á%' 
	OR Name LIKE '%é%' 
	OR Name LIKE '%í%' 
	OR Name LIKE '%ó%' 
	OR Name LIKE '%ú%'
	OR Name LIKE '%Á%' 
	OR Name LIKE '%É%' 
	OR Name LIKE '%Í%' 
	OR Name LIKE '%Ó%' 
	OR Name LIKE '%Ú%';

-- Query 5: Creative addition
-- Make an interesting query that uses a JOIN of at least two tables.
-- Show the the genre and artist of each track
SELECT tracks.Name, genres.Name, artists.Name
FROM tracks
LEFT JOIN genres 
ON tracks.GenreId = genres.GenreId
LEFT JOIN albums
ON tracks.AlbumId = albums.AlbumId
LEFT JOIN artists
ON albums.ArtistId = artists.ArtistId;

-- Query 6: Creative addition. 
-- Make an interesting query that uses a GROUP statement and at least two tables.
-- Show number of tracks in each playlist
SELECT playlists.Name, COUNT(tracks.TrackId) AS "Number of Tracks"
FROM playlists
LEFT JOIN playlist_track
ON playlists.PlaylistId = playlist_track.PlaylistId
LEFT JOIN tracks
ON playlist_track.TrackId = tracks.TrackId
GROUP BY playlists.Name
ORDER BY COUNT(tracks.TrackId) DESC;

-- Query 7
-- Write a query that lists all the customers that listen to longer-than-average 
-- tracks, excluding the tracks that are longer than 15 minutes.
WITH avg_track_length AS (
	-- Get the average track length excluding the tracks that are longer than 15 minutes
	SELECT AVG(tracks.Milliseconds) 
	FROM tracks 
	WHERE tracks.Milliseconds < 15 * 60 * 1000
),
longer_tracks AS (
	-- Get the tracks that are longer than the average track length
	SELECT tracks.TrackId
	FROM tracks
	WHERE tracks.Milliseconds > (SELECT * FROM avg_track_length)
),
longer_tracks_invoices AS (
	-- Get the invoices with longer-than-average tracks and associated customers
	SELECT invoices.InvoiceId, invoices.CustomerId
	FROM invoices
	INNER JOIN invoice_items
	ON invoices.InvoiceId = invoice_items.InvoiceId
	INNER JOIN longer_tracks
	ON invoice_items.TrackId = longer_tracks.TrackId
)
SELECT DISTINCT customers.FirstName, customers.LastName
FROM customers
JOIN longer_tracks_invoices
ON customers.CustomerId = longer_tracks_invoices.CustomerId;

-- SELECT DISTINCT customers.FirstName, customers.LastName
-- FROM customers
-- LEFT JOIN (
-- 	-- invoices with longer-than-average tracks and associated customers
-- 	SELECT invoices.InvoiceId, invoices.CustomerId
-- 	FROM invoices
-- 	LEFT JOIN invoice_items
-- 	ON invoices.InvoiceId = invoice_items.InvoiceId
-- 	LEFT JOIN 
-- 		( -- longer-than-average tracks excluding the tracks that are longer than 15 minutes
-- 		SELECT tracks.TrackId
-- 		FROM tracks
-- 		WHERE 
-- 			tracks.Milliseconds > (
-- 				SELECT AVG(tracks.Milliseconds) 
-- 				FROM tracks 
-- 				WHERE tracks.Milliseconds < 15 * 60 * 1000)
-- 		) AS longer_tracks
-- 	ON invoice_items.TrackId = longer_tracks.TrackId) AS longer_tracks_invoices
-- ON customers.CustomerId = longer_tracks_invoices.CustomerId;


-- Query 8
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