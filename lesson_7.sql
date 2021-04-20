
-- 1) ��������� ������ ������������� users, ������� ����������� ���� �� ���� ����� orders � �������� ��������

 INSERT INTO orders (user_id ) VALUES
 	(2),
 	(4),
 	(5);

SELECT name FROM users WHERE id IN (SELECT user_id FROM orders);

-- 2) �������� ������ ������� products � �������� catalogs, ������� ������������� ������

SELECT products.name AS product_name, catalogs.name AS product_type 
  FROM products 
  LEFT JOIN catalogs 
    ON products.catalog_id = catalogs.id;
    
   -- 3)  ����� ������� ������� ������ flights (id, from, to) � ������� ������� cities (label, name). 
   -- ���� from, to � label �������� ���������� �������� �������, ���� name � �������. 
   -- �������� ������ ������ flights � �������� ���������� �������
   
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
 	('Moscow', '������'),
 	('Saint Petersburg', '�����-���������'),
 	('Omsk', '����'),
 	('Tomsk', '�����'),
 	('Ufa', '���');

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