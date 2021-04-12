
/*1. Пусть задан некоторый пользователь.
Найдите человека, который больше всех общался с нашим пользователем, иначе, кто написал пользователю наибольшее число сообщений. (можете взять пользователя с любым id).*/

SELECT * FROM users WHERE id = (SELECT f_u_id FROM (SELECT count(from_user_id) count,from_user_id f_u_id  FROM messages WHERE to_user_id = 1 GROUP BY from_user_id LIMIT 1) AS mast_mess) ;

/*(по желанию: можете найти друга, с которым пользователь больше всего общался) */

SELECT * FROM users WHERE id = (
SELECT f_u_id FROM
(SELECT count(from_user_id) count,from_user_id f_u_id  
FROM messages 
WHERE to_user_id = 1 
AND from_user_id 
IN (SELECT to_user_id FROM friend_requests WHERE request_type = 1 AND from_user_id = 1
	UNION
	SELECT from_user_id FROM friend_requests WHERE request_type = 1 AND  to_user_id = 1)  
GROUP BY from_user_id
LIMIT 1) AS mast_mess_fr);


/*2. Подсчитать общее количество лайков на посты, которые получили пользователи младше 18 лет.*/

SELECT count(*) FROM posts_likes WHERE like_type = 1 AND post_id IN (SELECT id FROM posts WHERE user_id IN (SELECT user_id FROM profiles WHERE (TO_DAYS(NOW()) - TO_DAYS(birthday)) / 365.25 < 18)) ;

/*3. Определить, кто больше поставил лайков (всего) - мужчины или женщины?*/
SELECT IF(
	(SELECT COUNT(post_id) FROM posts_likes WHERE user_id IN (
		SELECT user_id FROM profiles WHERE gender="m")
	) 
	> 
	(SELECT COUNT(post_id) FROM posts_likes WHERE user_id IN (
		SELECT user_id FROM profiles WHERE gender="f")
	), 
   'male', 'female');
  
 /* 4. (по желанию) Найти пользователя, который проявляет наименьшую активность в использовании социальной сети 
  (тот, кто написал меньше всего сообщений, отправил меньше всего заявок в друзья, ...).*/
  
SELECT 
  CONCAT(first_name, ' ', last_name) AS user, 
	(SELECT COUNT(*) FROM posts_likes WHERE posts_likes.user_id = users.id) + 
	(SELECT COUNT(*) FROM media WHERE media.user_id = users.id) + 
	(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) +
	 (SELECT COUNT(*) FROM friend_requests WHERE friend_requests.from_user_id = users.id) AS overall_activity 
	  FROM users
	  ORDER BY overall_activity
	  LIMIT 1
;
	 
  
  
  

