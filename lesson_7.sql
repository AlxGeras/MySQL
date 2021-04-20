
-- 1) Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине

 INSERT INTO orders (user_id ) VALUES
 	(2),
 	(4),
 	(5);

SELECT name FROM users WHERE id IN (SELECT user_id FROM orders);

-- 2) Выведите список товаров products и разделов catalogs, который соответствует товару

SELECT products.name AS product_name, catalogs.name AS product_type 
  FROM products 
  LEFT JOIN catalogs 
    ON products.catalog_id = catalogs.id;
    
   -- 3)  Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
   -- Поля from, to и label содержат английские названия городов, поле name — русское. 
   -- Выведите список рейсов flights с русскими названиями городов
   
   CREATE TABLE IF NOT EXISTS flights(
 	id SERIAL PRIMARY KEY,
 	`from` VARCHAR(50) NOT NULL COMMENT 'en', 
 	`to` VARCHAR(50) NOT NULL COMMENT 'en'
 );

 CREATE TABLE  IF NOT EXISTS cities(
	label VARCHAR(50) PRIMARY KEY COMMENT 'en', 
	name VARCHAR(50) COMMENT 'ru'
);


 INSERT INTO cities VALUES
 	('Moscow', 'Москва'),
 	('Saint Petersburg', 'Санкт-Петербург'),
 	('Omsk', 'Омск'),
 	('Tomsk', 'Томск'),
 	('Ufa', 'Уфа');

 INSERT INTO flights VALUES
 	(NULL, 'Moscow', 'Saint Petersburg'),
	(NULL, 'Saint Petersburg', 'Omsk'),
	(NULL, 'Omsk', 'Tomsk'),
 	(NULL, 'Tomsk', 'Ufa'),
 	(NULL, 'Ufa', 'Moscow');
   
   
SELECT flights.id, cities.name AS "FROM" , c.name AS "TO"
  FROM flights
    JOIN cities
    ON cities.label = flights.from
   JOIN cities as c
    ON c.label = flights.to;