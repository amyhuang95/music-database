-- Write a query that lists all the tracks that have a ' in the name (e.g. 
-- Jorge Da Capadócia, o Samba De Uma Nota Só (One Note Samba))
SELECT *
FROM tracks
WHERE Name LIKE '%á%' 
	OR Name LIKE '%é%' 
	OR Name LIKE '%í%' 
	OR Name LIKE '%ó%' 
	OR Name LIKE '%ú%';