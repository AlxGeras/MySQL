  
-- ========Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”========

-- 1) Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
UPDATE users SET created_at = NOW() , updated_at = NOW() ;

-- 2) Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое 
-- время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения

ALTER TABLE users MODIFY COLUMN created_at varchar(150); # преобразуем колонку в VARCHAR
ALTER TABLE users MODIFY COLUMN updated_at varchar(150); # преобразуем колонку в VARCHAR

UPDATE users SET created_at = "20.10.2017 8:10" , updated_at = "20.10.2017 8:10" ;

UPDATE users SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'), updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i')

ALTER TABLE users MODIFY COLUMN created_at DATETIME, MODIFY COLUMN updated_at DATETIME ;

-- 3) В таблице складских запасов storehouses_products в поле value могут встречаться
-- самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы.
-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value.
-- Однако, нулевые запасы должны выводиться в конце, после всех записей.


INSERT INTO
    storehouses_products (storehouse_id, product_id, value)
VALUES
    (1, 1, 15),
    (1, 3, 0),
    (1, 5, 10),
    (1, 7, 5),
    (1, 8, 0);

SELECT * FROM storehouses_products ORDER BY CASE WHEN value = 0 then 1 else 0 end, value;


-- 4) (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае.
-- Месяцы заданы в виде списка английских названий ('may', 'august')


ALTER TABLE users MODIFY COLUMN birthday_at varchar(150);  

UPDATE users set birthday_at = 
	CASE 
		WHEN DATE_FORMAT(birthday_at, '%m') = 05 THEN 'may' 
		WHEN DATE_FORMAT(birthday_at, '%m') = 08 THEN 'august'
		ELSE birthday_at
	END;
	

SELECT * FROM users WHERE birthday_at = 'may' OR birthday_at = 'august';
   
--   5) (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса:
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.

SELECT 
    *
FROM
    catalogs WHERE id IN (5, 1, 2) 
ORDER BY CASE
    WHEN id = 5 THEN 0
    WHEN id = 1 THEN 1
    WHEN id = 2 THEN 2
END;

-- ========Практическое задание теме “Агрегация данных”========

-- 1) Подсчитайте средний возраст пользователей в таблице users

SELECT ROUND(AVG((TO_DAYS(NOW()) - TO_DAYS(birthday_at)) / 365.25), 0) AS AVG_Age FROM users;

--  2) Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.***
--  Следует учесть, что необходимы дни недели текущего года, а не года рождения. ***********

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');
 
 SELECT
    DAYNAME(CONCAT(YEAR(NOW()), '-', SUBSTRING(birthday_at, 6, 10))) AS week_day,
    COUNT(*) AS amount_of_birthday
FROM
    users
GROUP BY 
    week_day;

--  3)(по желанию) Подсчитайте произведение чисел в столбце таблицы. (1,2,3,4,5)

CREATE TABLE task(
id SERIAL PRIMARY KEY
);

INSERT INTO task (id) VALUES (1),(2),(3),(4),(5);

SELECT EXP(SUM(LN(id))) AS result FROM task;

    