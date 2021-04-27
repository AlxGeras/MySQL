-- 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие,
-- в зависимости от текущего времени суток.
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".



DELIMITER //

DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello() RETURNS TEXT DETERMINISTIC
BEGIN
  RETURN CASE
      WHEN "06:00" <= CURTIME() AND CURTIME() < "12:00" THEN "Доброе утро"
      WHEN "12:00" <= CURTIME() AND CURTIME() < "18:00" THEN "Добрый День"
      WHEN "18:00" <= CURTIME() AND CURTIME() < "24:00" THEN "Добрый вечер"
      ELSE "Доброй ночи"
    END;
END //

DELIMITER ;

-- 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное
-- значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля
-- были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.

DROP TRIGGER IF EXISTS nullTrigger_bef_ins;
delimiter //
CREATE TRIGGER nullTrigger_bef_ins BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.name)) THEN
		SET NEW.name = 'NoName';
	END IF;
	IF(ISNULL(NEW.description)) THEN
		SET NEW.description = 'No Desc';
	END IF;
END //
delimiter ;

DROP TRIGGER IF EXISTS nullTrigger_insert;
delimiter //
CREATE TRIGGER nullTrigger_insert BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.name) AND ISNULL(NEW.description)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Trigger Warning! NULL in both fields!';
	END IF;
END //
delimiter ;

DROP TRIGGER IF EXISTS nullTrigger_update;
delimiter //
CREATE TRIGGER nullTrigger_update BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.name) AND ISNULL(NEW.description)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Trigger Warning! NULL in both fields!';
	END IF;
END //
delimiter ;

-- 3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи.
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел.
-- Вызов функции FIBONACCI(10) должен возвращать число 55.

DELIMITER //
DROP FUNCTION IF EXISTS rec_fib//

CREATE FUNCTION rec_fib(num INT) RETURNS INT DETERMINISTIC
BEGIN
  DECLARE num_1 INT;
  DECLARE num_2 INT;
  DECLARE buff INT;
 DECLARE i INT DEFAULT 0;
   IF (num=0) THEN
    RETURN 0;
  ELSEIF (num=1) then
   RETURN 1;
   ELSE
       SET num_1 = 0;
       SET num_2 = 1;
       WHILE i < num-2 DO
       SET buff = num_2;
       SET num_2 = num_2 + num_1;
       SET num_1 = buff;
       SET i = i +1; 
       END WHILE;
      RETURN (num_2 + num_1);
 END IF;
END //


