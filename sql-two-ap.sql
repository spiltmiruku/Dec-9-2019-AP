SELECT * FROM invoice_line
WHERE unit_price > 0.99;

SELECT * FROM invoice;

SELECT c.last_name, c.first_name, i.total FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id;

SELECT c.last_name, c.first_name, e.last_name, e.first_name 
FROM customer c
JOIN employee e ON c.support_rep_id = e.employee_id;

SELECT album.title, artist.name FROM album
JOIN artist ON artist.artist_id = album.artist_id;

SELECT pt.track_id FROM playlist_track pt 
JOIN playlist  p ON p.playlist_id = pt.playlist_id
WHERE p.name = 'Music';

