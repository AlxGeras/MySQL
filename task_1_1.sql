DROP DATABASE IF EXISTS vk;

CREATE DATABASE vk;

USE vk;


CREATE TABLE users (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(145) NOT NULL,
  last_name VARCHAR(145) NOT NULL,
  email VARCHAR(145) NOT NULL,
  phone CHAR(11) NOT NULL,
  password_hash CHAR(65) DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- NOW()
  UNIQUE INDEX email_unique_idx (email),
  UNIQUE INDEX phone_unique_idx (phone)
) ENGINE=InnoDB;

CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name varchar(45) NOT NULL UNIQUE 
) ENGINE=InnoDB;


CREATE TABLE media (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  media_types_id INT UNSIGNED NOT NULL,
  file_name VARCHAR(245) DEFAULT NULL COMMENT '/files/folder/img.png',
  file_size BIGINT UNSIGNED,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX media_media_types_idx (media_types_id),
  INDEX media_users_idx (user_id),
  CONSTRAINT fk_media_media_types FOREIGN KEY (media_types_id) REFERENCES media_types (id),
  CONSTRAINT fk_media_users FOREIGN KEY (user_id) REFERENCES users (id)
);



CREATE TABLE profiles (
  user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
  gender ENUM('f', 'm', 'x') NOT NULL, -- CHAR(1)
  birthday DATE NOT NULL,
  photo_id BIGINT UNSIGNED,
  user_status VARCHAR(30),
  city VARCHAR(130),
  country VARCHAR(130),
  CONSTRAINT fk_profiles_users FOREIGN KEY (user_id) REFERENCES users (id), -- ON DELETE CASCADE ON UPDATE CASCADE
  CONSTRAINT fk_profiles_media FOREIGN KEY (photo_id) REFERENCES media (id) -- ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE messages (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  from_user_id BIGINT UNSIGNED NOT NULL,
  to_user_id BIGINT UNSIGNED NOT NULL,
  txt TEXT NOT NULL, 
  is_delivered BOOLEAN DEFAULT False,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- NOW()
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX fk_messages_from_user_idx (from_user_id),
  INDEX fk_messages_to_user_idx (to_user_id),
  CONSTRAINT fk_messages_users_1 FOREIGN KEY (from_user_id) REFERENCES users (id),
  CONSTRAINT fk_messages_users_2 FOREIGN KEY (to_user_id) REFERENCES users (id)
);


CREATE TABLE friend_requests (
  from_user_id BIGINT UNSIGNED NOT NULL,
  to_user_id BIGINT UNSIGNED NOT NULL,
  accepted BOOLEAN DEFAULT False,
  PRIMARY KEY(from_user_id, to_user_id),
  INDEX fk_friend_requests_from_user_idx (from_user_id),
  INDEX fk_friend_requests_to_user_idx (to_user_id),
  CONSTRAINT fk_friend_requests_users_1 FOREIGN KEY (from_user_id) REFERENCES users (id),
  CONSTRAINT fk_friend_requests_users_2 FOREIGN KEY (to_user_id) REFERENCES users (id)
);


CREATE TABLE communities (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(145) NOT NULL,
  description VARCHAR(245) DEFAULT NULL,
  admin_id BIGINT UNSIGNED NOT NULL,
  INDEX communities_users_admin_idx (admin_id),
  CONSTRAINT fk_communities_users FOREIGN KEY (admin_id) REFERENCES users (id)
) ENGINE=InnoDB;


CREATE TABLE communities_users (
  community_id BIGINT UNSIGNED NOT NULL,
  user_id BIGINT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY (community_id, user_id),
  INDEX communities_users_comm_idx (community_id),
  INDEX communities_users_users_idx (user_id),
  CONSTRAINT fk_communities_users_comm FOREIGN KEY (community_id) REFERENCES communities (id),
  CONSTRAINT fk_communities_users_users FOREIGN KEY (user_id) REFERENCES users (id)
) ENGINE=InnoDB;


CREATE TABLE posts (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- id поста
	user_id BIGINT UNSIGNED NOT NULL, -- id автора поста
	txt TEXT NOT NULL, -- текст поста, не может быть пустым
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- когда пост создали
	updated_at DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP, -- когда пост обновили
	INDEX user_idx (user_id), -- индекс для быстрого поиска по пользователю, чтобы найти все его посты
	CONSTRAINT user_posts_fk FOREIGN KEY (user_id) REFERENCES users (id) -- связь с таблицей users
);



CREATE TABLE posts_likes (
	post_id BIGINT UNSIGNED NOT NULL, -- id поста
	user_id BIGINT UNSIGNED NOT NULL, -- id автора лайка
	like_type BOOLEAN DEFAULT TRUE, -- если автор лайка убрал лайк ставим False, необязательная колонка
	PRIMARY KEY (post_id, user_id), -- PK по посту и лайку, чтобы гарантировать, что пользователь может поставить только один лайк на пост
	INDEX post_idx (post_id), -- индекс для быстрого поиска по посту, чтобы найти всех, кто лайкнул пост
	INDEX user_idx (user_id), -- индекс для быстрого поиска по пользователю, чтобы найти все его лайкнутые посты
	CONSTRAINT posts_likes_fk FOREIGN KEY (post_id) REFERENCES posts (id), -- связь с таблицей posts
	CONSTRAINT users_likes_fk FOREIGN KEY (user_id) REFERENCES users (id) -- связь с таблицей users
);



CREATE TABLE black_list (
	author_id BIGINT UNSIGNED NOT NULL, -- id того, кто добавил в ЧС
	banned_id BIGINT UNSIGNED NOT NULL, -- id того, кого добавил author_id в ЧС
	banned BOOLEAN DEFAULT False, -- если author_id убрал из ЧС пользователя, ставим идентификатор в False, необязательная колонка
	PRIMARY KEY (author_id, banned_id), -- PK по тому, кто забанил кого забанил, чтобы гарантировать, что пользователь Вася может добавить Петю в чс только один раз
	INDEX author_idx (author_id), -- индекс для быстрого поиска по тому, кто забанил, чтобы быстро найти всех, кого он забанил
	INDEX banned_idx (banned_id), -- индекс для быстрого поиска по тому, кого забанили, чтобы быстро найти всех, кто его забанил
	CONSTRAINT users_author_fk FOREIGN KEY (author_id) REFERENCES users (id), -- связь с таблицей users
	CONSTRAINT users_banned_fk FOREIGN KEY (banned_id) REFERENCES users (id) -- связь с таблицей users
);


CREATE TABLE chats(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- id чата
	name VARCHAR(255) NOT NULL, -- название чата
	author_id BIGINT UNSIGNED NOT NULL, -- id основателя чата
	INDEX author_idx (author_id), -- индекс для быстрого поиска по основателю, чтобы найти все чаты, которые он создал
	CONSTRAINT users_chats_fk FOREIGN KEY (author_id) REFERENCES users (id) -- ссылка на users
);



CREATE TABLE chat_users(
	chat_id BIGINT UNSIGNED NOT NULL, -- id чата
	user_id BIGINT UNSIGNED NOT NULL, -- id участника чата
	added_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- время добавления участника в чат
	PRIMARY KEY (chat_id, user_id), -- PK по чату и участника чата, чтобы гарантировать запрет на добавление пользователя в чат несколько раз, когда он уже там есть
	INDEX chat_id (chat_id), -- индекс для быстрого поиска по чату, чтобы искать участников чата
	INDEX user_id (user_id), -- индекс для быстрого поиска по участнику чата, чтобы искать все чаты, в которых он состоит
	CONSTRAINT chats_fk FOREIGN KEY (chat_id) REFERENCES chats (id), -- связь с таблицей chats
	CONSTRAINT users_chats_users_fk FOREIGN KEY (user_id) REFERENCES users (id) -- связь с таблицей users
);


CREATE TABLE chat_messages(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- id сообщения в чате
	chat_id BIGINT UNSIGNED NOT NULL, -- id чата
	user_id BIGINT UNSIGNED NOT NULL, -- id автора сообщения в чате
	txt TEXT NOT NULL, -- текст сообщения
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- когда автор отправил сообщение
	updated_at DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP, -- когда автор обновил сообщение
	INDEX chat_id (chat_id), -- индекс для быстрого поиска по чату, чтобы выводить все сообщения в чате
	CONSTRAINT chats_messages_fk FOREIGN KEY (chat_id) REFERENCES chats (id), -- связь с таблицей chats
	CONSTRAINT chats_messages_users_fk FOREIGN KEY (user_id) REFERENCES users (id) -- связь с таблицей users
);


CREATE TABLE school (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	city VARCHAR(128) NOT NULL,
	country VARCHAR(128) NOT NULL,
	address VARCHAR(255)
);


CREATE TABLE school_users(
	school_id BIGINT UNSIGNED NOT NULL, -- id школы
	user_id BIGINT UNSIGNED NOT NULL, -- id пользователя
	start_year YEAR NOT NULL, -- год начала обучения
	finish_year YEAR, -- год окончания обучения, может быть неизвестно
	PRIMARY KEY (school_id, user_id), -- PK по школе и пользователю, чтобы гарантировать запрет на добавление одной и той же школы для пользователя несколько раз (хотя такая ситуация может быть)
	INDEX school_idx (school_id), -- индекс для быстрого поиска по школе, чтобы быстро искать учеников школы
	INDEX user_id (user_id), -- индекс для быстрого поиска по ученику школы, чтобы искать все школы, где он учился
	CONSTRAINT school_users_fk FOREIGN KEY (school_id) REFERENCES school (id), -- связь с таблицей schools
	CONSTRAINT school_users_users_fk FOREIGN KEY (user_id) REFERENCES users (id) -- связь с таблицей users
);








