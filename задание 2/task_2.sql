/* стркутрура постов
 * id - id поста
 * user_id - id пользователя создавшего пост
 * community_id - id сообщества в ктором выложен пост
 * head - заголовок
 * body - текст поста
 * media_id - id прикрепленного медиафайла
 * is_archived - является ли запись архивной
 * views_counter - количество просмотров 
 * created_at - дата создания поста
 * updated_at - дата обновления поста
 * */
DROP TABLE IF EXISTS posts;

CREATE TABLE posts (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  community_id BIGINT UNSIGNED,
  head VARCHAR(255),
  body TEXT NOT NULL,
  media_id BIGINT UNSIGNED,
  is_archived BOOLEAN DEFAULT FALSE,
  views_counter INT UNSIGNED DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX posts_users_idx (user_id),
  INDEX posts_comm_idx (community_id),
  CONSTRAINT fk_posts_user_id FOREIGN KEY (user_id) REFERENCES users(id),
  CONSTRAINT fk_posts_community_id FOREIGN KEY (community_id) REFERENCES communities(id),
  CONSTRAINT fk_posts_media_id FOREIGN KEY (media_id) REFERENCES media(id)
);



/* стркутрура таблицы типов лайков(для таблицы лайков)
 * id  - id типа
 * name - тип сущности которой мы хотим поставить лайк (сообщение, пользователь, медиафайл, пост)
 * */
DROP TABLE IF EXISTS target_types;

CREATE TABLE target_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
);

INSERT INTO target_types (name) VALUES 
  ('messages'),
  ('users'),
  ('media'),
  ('posts');
 
 /* стркутрура лайков
 * id - id лайка
 * user_id - id пользователя поставившего лайк
 * target_id - id сущности которой ставится лайк
 * target_type_id - id типа сущности которой ставится лайк 
 * created_at - дата лайка
 * */

DROP TABLE IF EXISTS likes;

CREATE TABLE likes (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  target_id BIGINT UNSIGNED NOT NULL,
  target_type_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  INDEX likes_user_idx (user_id),
  CONSTRAINT fk_likes_target_id_1 FOREIGN KEY (target_id) REFERENCES messages(id),
  CONSTRAINT fk_likes_target_id_2 FOREIGN KEY (target_id) REFERENCES users(id),
  CONSTRAINT fk_likes_target_id_3 FOREIGN KEY (target_id) REFERENCES media(id),
  CONSTRAINT fk_likes_target_id_4 FOREIGN KEY (target_id) REFERENCES posts(id),
  CONSTRAINT fk_likes_target_type_id FOREIGN KEY (target_type_id) REFERENCES target_types(id)
);






