DROP DATABASE IF EXISTS vk;

CREATE DATABASE vk;

-- используем БД vk
USE vk;


CREATE TABLE users (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(145) NOT NULL, -- COMMENT "Имя",
  last_name VARCHAR(145) NOT NULL,
  email VARCHAR(145) NOT NULL,
  phone CHAR(11) NOT NULL,
  password_hash CHAR(65) DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- NOW()
  UNIQUE INDEX email_unique_idx (email),
  UNIQUE INDEX phone_unique_idx (phone)
) ENGINE=InnoDB;


-- 1:1 связь
CREATE TABLE profiles (
  user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
  gender ENUM('f', 'm', 'x') NOT NULL, -- CHAR(1)
  birthday DATE NOT NULL,
  photo_id INT UNSIGNED,
  user_status VARCHAR(30),
  city VARCHAR(130),
  country VARCHAR(130),
  CONSTRAINT fk_profiles_users FOREIGN KEY (user_id) REFERENCES users (id) -- ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE messages (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  from_user_id BIGINT UNSIGNED NOT NULL,
  to_user_id BIGINT UNSIGNED NOT NULL,
  txt TEXT NOT NULL, -- txt = ПРИВЕТ
  is_delivered BOOLEAN DEFAULT False,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- NOW()
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",
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


CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name varchar(45) NOT NULL UNIQUE -- изображение, музыка, документ
) ENGINE=InnoDB;


CREATE TABLE media (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, -- Картинка 1
  user_id BIGINT UNSIGNED NOT NULL,
  media_types_id INT UNSIGNED NOT NULL, -- фото
  file_name VARCHAR(245) DEFAULT NULL COMMENT '/files/folder/img.png',
  file_size BIGINT UNSIGNED,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX media_media_types_idx (media_types_id),
  INDEX media_users_idx (user_id),
  CONSTRAINT fk_media_media_types FOREIGN KEY (media_types_id) REFERENCES media_types (id),
  CONSTRAINT fk_media_users FOREIGN KEY (user_id) REFERENCES users (id)
);

