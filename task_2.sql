CREATE DATABASE example;
USE example;
DROP TABLE IF EXISTS users;
CREATE TABLE users (
 id INT,
 name VARCHAR(255)
);
INSERT INTO users VALUES (1, '������');
INSERT INTO users VALUES (2, '������');
SELECT * FROM users;