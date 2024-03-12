-- 1 List the name of all the products in the product table.
SELECT nombre FROM producto; 

-- 2 List the names and prices of all the products in the product table.
SELECT nombre, precio FROM producto;

-- 3 List all columns of the product table.
SELECT * FROM producto;

-- 4 List the name of the products, the price in euros and the price in US dollars (USD).
SELECT nombre, CONCAT(ROUND(precio, 2),' €'), CONCAT(ROUND(precio * 1.08, 2),' $') FROM producto;

-- 5  List the name of the products, the price in euros and the price in US dollars (USD). 
-- Use the following aliases for the columns: product name, euros, dollars.
SELECT nombre AS nombre_producto, ROUND(precio, 2) AS euros, ROUND(precio * 1.08, 2) AS dolares FROM producto;

-- 6  List the names and prices of all products in the product table, converting the names to uppercase.
SELECT UPPER(nombre), precio FROM producto;

-- 7 List the names and prices of all products in the product table, converting the names to lowercase.
SELECT LOWER(nombre), precio FROM producto;

-- 8 List the name of all manufacturers in one column, and in another column capitalize 
-- the first two characters of the manufacturer's name.
SELECT nombre, UPPER(LEFT(nombre, 2)) FROM fabricante; 

-- 9 List the names and prices of all products in the product table, rounding the price value.
SELECT nombre, ROUND(precio) FROM producto;

-- 10 Lists the names and prices of all products in the product table, truncating the price value 
-- to display it without any decimal places.
SELECT nombre, CAST(precio AS SIGNED) FROM producto;

-- 11 List the code of the manufacturers that have products in the product table.
SELECT codigo_fabricante FROM producto;

-- 12 List the code of the manufacturers that have products in the product table, 
-- eliminating the codes that appear repeatedly.
SELECT DISTINCT codigo_fabricante FROM producto;

-- 13 List manufacturer names in ascending order.
SELECT nombre FROM fabricante ORDER BY nombre ASC;

-- 14 List manufacturer names in descending order.
SELECT nombre FROM fabricante ORDER BY nombre DESC;

-- 15 Lists product names sorted first by name in ascending order and second by price in descending order.
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;

-- 16 Returns a list with the first 5 rows of the manufacturer table.
SELECT * FROM fabricante LIMIT 5;

-- 17  Returns a list with 2 rows starting from the fourth row of the manufacturer table. 
-- The fourth row must also be included in the answer.
SELECT * FROM fabricante LIMIT 2 OFFSET 3;

-- 18 List the cheapest product name and price. (Use only the ORDER BY and LIMIT clauses). 
-- NOTE: I could not use MIN(price) here, I would need GROUP BY.
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;

-- 19 List the name and price of the most expensive product. (Use only the ORDER BY and LIMIT clauses). 
-- NOTE: I could not use MAX(price) here, I would need GROUP BY.
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

-- 20 List the name of all products from the manufacturer whose manufacturer code is equal to 2.
SELECT nombre FROM producto WHERE codigo_fabricante = 2;

-- 21 Returns a list with the product name, price, and manufacturer name of all products in the database.
SELECT producto.nombre AS nombre_producto, producto.precio, fabricante.nombre AS nombre_fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

-- 22 Returns a list with the product name, price, and manufacturer name of all products in the database. 
-- Sort the result by manufacturer name, in alphabetical order.
SELECT producto.nombre AS nombre_producto, producto.precio, fabricante.nombre AS nombre_fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY fabricante.nombre;

-- 23 Returns a list with the product code, product name, manufacturer code, and manufacturer name 
-- of all products in the database.
SELECT producto.codigo AS codigo_producto, producto.nombre AS nombre_producto, fabricante.codigo AS codigo_fabricante, fabricante.nombre AS nombre_fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo; 

-- 24 Returns the name of the product, its price and the name of its manufacturer, of the cheapest product.
SELECT producto.nombre AS nombre_producto, producto.precio, fabricante.nombre AS nombre_fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY precio ASC LIMIT 1; 

-- 25 Returns the name of the product, its price and the name of its manufacturer, of the most expensive product.
SELECT producto.nombre AS nombre_producto, producto.precio, fabricante.nombre AS nombre_fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY precio DESC LIMIT 1;

-- 26 Returns a list of all products from manufacturer Lenovo.
SELECT producto.nombre AS nombre_producto, producto.precio, fabricante.nombre AS nombre_fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Lenovo';

-- 27 Returns a list of all products from manufacturer Crucial that have a price greater than €200.
SELECT producto.nombre AS nombre_producto, precio, fabricante.nombre AS nombre_fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Crucial' AND producto.precio > 200;

-- 28 Returns a list with all products from manufacturers Asus, Hewlett-Packard and Seagate. 
-- Without using the IN operator.
SELECT producto.nombre AS nombre_producto, producto.precio, fabricante.nombre AS nombre_fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Asus' OR fabricante.nombre = 'Hewlett-Packard' OR fabricante.nombre = 'Seagate';

-- 29 Returns a list with all products from manufacturers Asus, Hewlett-Packard and Seagate. Using the IN operator.
SELECT producto.nombre AS nombre_producto, producto.precio, fabricante.nombre AS nombre_fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre IN('Asus', 'Hewlett-Packard', 'Seagate');

-- 30 Returns a list with the name and price of all products from manufacturers whose name ends with the vowel e.
SELECT producto.nombre AS nombre_producto, producto.precio, fabricante.nombre AS nombre_fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE '%e';

-- 31 Returns a list with the name and price of all products whose manufacturer name contains 
-- the character w in their name.
SELECT producto.nombre AS nombre_producto, producto.precio, fabricante.nombre AS nombre_fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE '%w%';

-- 32 Returns a list with the product name, price and manufacturer name, of all products that 
-- have a price greater than or equal to €180. Sort the result first by price (in descending order) and 
-- second by name (in ascending order).
SELECT producto.nombre AS nombre_producto, producto.precio, fabricante.nombre AS nombre_fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio >= 180 ORDER BY producto.precio DESC, producto.nombre ASC;

-- 33 Returns a list with the manufacturer's code and name, only of those manufacturers that 
-- have associated products in the database.
SELECT fabricante.codigo, fabricante.nombre FROM fabricante INNER JOIN producto ON fabricante.codigo = producto.codigo_fabricante GROUP BY fabricante.codigo, fabricante.nombre;

-- 34 Returns a list of all the manufacturers that exist in the database, along with the products 
-- that each of them has. The list must also show those manufacturers that do not have associated products.
SELECT fabricante.codigo, fabricante.nombre AS nombre_fabricante, producto.nombre AS nombre_producto FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante ORDER BY fabricante.nombre, producto.nombre ASC;

-- 35 Returns a list showing only those manufacturers that do not have any associated products.
SELECT fabricante.nombre FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante WHERE producto.codigo_fabricante IS NULL GROUP BY fabricante.nombre;

-- 36 Returns all products from the manufacturer Lenovo. (Without using INNER JOIN).
SELECT nombre AS nombre_producto, precio FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo');

-- 37 Returns all data for products that have the same price as the most expensive product 
-- from the manufacturer Lenovo. (Without using INNER JOIN).
SELECT * FROM producto WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));

-- 38 List the name of the most expensive product from the manufacturer Lenovo.
SELECT producto.nombre FROM producto WHERE producto.codigo_fabricante = (SELECT fabricante.codigo FROM fabricante WHERE nombre = 'Lenovo') AND producto.precio = (SELECT MAX(precio) FROM producto WHERE producto.codigo_fabricante = (SELECT fabricante.codigo FROM fabricante WHERE fabricante.nombre = 'Lenovo'));

-- 39 List the cheapest product name from the manufacturer Hewlett-Packard.
SELECT producto.nombre FROM producto WHERE producto.codigo_fabricante = (SELECT fabricante.codigo FROM fabricante WHERE fabricante.nombre = 'Hewlett-Packard') AND producto.precio = (SELECT MIN(precio) FROM producto WHERE producto.codigo_fabricante = (SELECT fabricante.codigo FROM fabricante WHERE fabricante.nombre = 'Hewlett-Packard')); 

-- 40 Returns all products in the database that have a price greater than or equal to 
-- the most expensive product from manufacturer Lenovo.
SELECT producto.nombre, precio FROM producto WHERE producto.precio >= (SELECT MAX(precio) FROM producto WHERE producto.codigo_fabricante = (SELECT fabricante.codigo FROM fabricante WHERE fabricante.nombre = 'Lenovo'));

-- 41 List all products from the manufacturer Asus that have a price higher than 
-- the average price of all their products.
SELECT producto.nombre, precio FROM producto WHERE producto.codigo_fabricante = (SELECT fabricante.codigo FROM fabricante WHERE fabricante.nombre = 'Asus') AND producto.precio > (SELECT AVG(precio) FROM producto WHERE producto.codigo_fabricante = (SELECT fabricante.codigo FROM fabricante WHERE fabricante.nombre = 'Asus'));
