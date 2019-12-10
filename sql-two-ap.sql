//Practice joins

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

SELECT t.name FROM track t
JOIN playlist_track pt ON pt.track_id = t.track_id
WHERE pt.playlist_id = 5;

SELECT t.name, p.name FROM track t
JOIN playlist_track pt ON pt.track_id = t.track_id
JOIN playlist p ON p.playlist_id = pt.playlist_id;

SELECT t.name, a.title FROM track t
JOIN album a ON a.album_id = t.album_id
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk';

//Black Diamond
SELECT t.name, g.name, al.title, ar.name
FROM playlist p
JOIN playlist_track pt ON pt.playlist_id = p.playlist_id
JOIN track t ON t.track_id = pt.track_id
JOIN genre g ON g.genre_id = t.genre_id
JOIN album al ON al.album_id = t.album_id
JOIN artist ar ON ar.artist_id = al.artist_id
WHERE p.name = 'Music';

//Practice nested queries

SELECT * FROM invoice
WHERE invoice_id IN 
	( SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99);

SELECT * FROM playlist_track
WHERE playlist_id IN
 	( SELECT playlist_id FROM playlist WHERE name = 'Music');

SELECT name FROM track
 WHERE track_id IN
 	( SELECT track_id FROM playlist_track WHERE playlist_id = 5);
 
 SELECT * FROM track
 WHERE genre_id IN
 	( SELECT genre_id FROM genre WHERE name = 'Comedy');

 SELECT * FROM track
 WHERE album_id IN
 	( SELECT album_id FROM album WHERE title = 'Fireball');

SELECT * FROM track
 WHERE album_id IN
 	( SELECT album_id FROM album WHERE artist_id IN (
   		SELECT artist_id FROM artist WHERE name = 'Queen'));

//Practice updating Rows

UPDATE customer
SET fax = null
WHERE fax IS NOT null;

UPDATE customer
SET company = 'Self'
WHERE company IS null;
 
UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';

UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = 
    ( SELECT genre_id FROM genre WHERE name = 'Metal')
AND composer IS null;

//Group by

SELECT COUNT (*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;

SELECT COUNT (*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name;

SELECT a.name, COUNT (*)
FROM album al
JOIN artist a ON a.artist_id = al.artist_id
GROUP BY a.name;

//Use Distinct

SELECT DISTINCT composer
FROM track;

SELECT DISTINCT billing_postal_code
From invoice;

SELECT DISTINCT company
FROM customer;

//Delete Rows

DELETE FROM practice_delete 
WHERE type = 'bronze';

DELETE FROM practice_delete 
WHERE type = 'silver';

DELETE FROM practice_delete 
WHERE value = 150;

//eCommerce Simulation

CREATE TABLE store_customers (
  customer_id SERIAL PRIMARY KEY,
  username VARCHAR(50) NOT NULL, 
  email VARCHAR(100) NOT NULL
   );
  
CREATE TABLE products (
  product_id SERIAL PRIMARY KEY,
  product_name VARCHAR(100),
  product_price INTEGER  
 );

CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  order_total INTEGER,
  product_id INTEGER REFERENCES products(product_id),
  customer_id INTEGER REFERENCES store_customers(customer_id)
);


INSERT INTO store_customers ( 
    username, email
    ) VALUES ('Zero Kiryu', 'zero@zmail.com');
INSERT INTO store_customers ( 
    username, email
    ) VALUES ('Kaname Kuran', 'kaname@zmail.com');
INSERT INTO store_customers ( 
    username, email
    ) VALUES ('Yuki Cross', 'yuki@zmail.com');

INSERT INTO products (
    product_name, product_price
    ) VALUES ('Artemis Rod', 999);

INSERT INTO products (
    product_name, product_price
    ) VALUES ('Resin Rose', 9999);

INSERT INTO products (
    product_name, product_price
    ) VALUES ('Hunter Bracelet', 99);

INSERT INTO orders (
    order_total, customer_id
) VALUES ('1098', 1);

INSERT INTO orders (
    order_total, customer_id
) VALUES ('10098', 2);

INSERT INTO orders (
    order_total, customer_id
) VALUES ('10998', 3);

INSERT INTO orders (
    order_total, customer_id
) VALUES ('99', 1);

ALTER TABLE orders
ADD username VARCHAR(50);

SELECT * FROM orders
WHERE customer_id = 1;

SELECT COUNT(*) 
FROM orders
WHERE customer_id = 1;

//Black Diamond

SELECT SUM(order_total), customer_id
FROM orders
GROUP BY customer_id;