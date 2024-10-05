-- Insert another video for the track "Voodoo", assuming that you don't know 
-- the TrackId, so your insert query should specify the TrackId directly.
INSERT INTO music_video (TrackId, Director)
	SELECT TrackId, "Voodoo Director"
	FROM tracks 
	WHERE Name = "Voodoo";
