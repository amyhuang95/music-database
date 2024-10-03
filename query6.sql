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