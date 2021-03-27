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

 
 /* стркутрура лайков постов
 * id - id лайка
 * user_id - id пользователя поставившего лайк
 * post_id - id поста которму ставится лайк
 * created_at - дата лайка
 * */

DROP TABLE IF EXISTS likes;

CREATE TABLE likes (
  user_id BIGINT UNSIGNED NOT NULL,
  post_id BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY(user_id, post_id),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  INDEX likes_user_idx (user_id),
  INDEX likes_post_idx (post_id),
  CONSTRAINT fk_likes_post_id FOREIGN KEY (post_id) REFERENCES posts(id),
  CONSTRAINT fk_likes_user_id FOREIGN KEY (user_id) REFERENCES users(id)
);






