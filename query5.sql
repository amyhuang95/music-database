-- Creative addition
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