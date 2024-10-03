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
