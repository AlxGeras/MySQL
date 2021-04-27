-- 1. Создайте двух пользователей которые имеют доступ к базе данных shop.
-- Первому пользователю shop_read должны быть доступны только запросы на чтение данных,
-- второму пользователю shop — любые операции в пределах базы данных shop.

-- shop_read доступны только запросы на чтение данных
DROP USER IF EXISTS 'shop_reader'@'localhost';
CREATE USER 'shop_reader'@'localhost' IDENTIFIED WITH sha256_password BY '123';
GRANT SELECT ON shop_online.* TO 'shop_reader'@'localhost';


-- shop - доступны любые операции в пределах базы данных shop
DROP USER IF EXISTS 'shop'@'localhost';
CREATE USER 'shop'@'localhost' IDENTIFIED WITH sha256_password BY '123';
GRANT ALL ON shop_online.* TO 'shop'@'localhost';
GRANT GRANT OPTION ON shop_online.* TO 'shop'@'localhost';

-- 2. (по желанию) Есть таблица (accounts), включающая в себя три столбца: id, name, password,
-- которые содержат первичный ключ, имя пользователя и его пароль. Создайте представление username таблицы accounts,
-- предоставляющее доступ к столбцам id и name. Создайте пользователя user_read,
-- который бы не имел доступа к таблице accounts, однако мог извлекать записи из представления username.


DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
	id SERIAL PRIMARY KEY,
	name VARCHAR(45),
	password VARCHAR(45)
);

INSERT INTO accounts VALUES
	(NULL, 'bob', '123'),
	(NULL, 'jack', '123'),
	(NULL, 'ron', '123');


CREATE OR REPLACE VIEW username(user_id, user_name) AS 
	SELECT id, name FROM accounts;


-- Создаем пользователя 'user_read'@'localhost' с доступом только к одному,
-- ограниченному по столбцам, представлению username;
CREATE USER 'user_read'@'localhost' IDENTIFIED WITH sha256_password BY '123';
GRANT SELECT ON shop.username TO 'user_read'@'localhost';
