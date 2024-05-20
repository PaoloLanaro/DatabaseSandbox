
DROP DATABASE IF EXISTS HuskyGram;
CREATE DATABASE IF NOT EXISTS HuskyGram;

USE HuskyGram;

DROP TABLE IF EXISTS users;

CREATE TABLE IF NOT EXISTS users
(
	id INT PRIMARY KEY,
	created_at DATETIME,
	username VARCHAR(255) UNIQUE NOT NULL
);

INSERT INTO users (id, created_at, username)
VALUES (123, NOW(), 'justywusty'),
       (234, NOW(), 'Aahil the KFC demolisher');

DROP TABLE IF EXISTS follows;

CREATE TABLE IF NOT EXISTS follows
(
    follower_id INT,
    followee_id INT,
    created_at  DATETIME,
    PRIMARY KEY (follower_id, followee_id),
    FOREIGN KEY (follower_id) REFERENCES users (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (followee_id) REFERENCES users (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

INSERT INTO follows (follower_id, followee_id, created_at)
VALUES (123, 234, NOW()),
       (234, 123, NOW());

DROP TABLE IF EXISTS photos;

CREATE TABLE IF NOT EXISTS photos
(
	id INT PRIMARY KEY,
	created_at DATETIME,
	user_id INT NOT NULL,
	image_url VARCHAR(255) NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

INSERT INTO photos (id, created_at, user_id, image_url)
VALUES (1, NOW(), 123, 'hello.png'),
       (2, NOW(), 123, 'goodbye.png');

DROP TABLE IF EXISTS tags;

CREATE TABLE IF NOT EXISTS tags
(
	id INT PRIMARY KEY,
	created_at DATETIME,
	tag_name varchar(255) UNIQUE
);

INSERT INTO tags (id, created_at, tag_name)
VALUES (1, NOW(), '#NEU'),
       (2, NOW(), '#BU');

DROP TABLE IF EXISTS photo_tags;

CREATE TABLE IF NOT EXISTS photo_tags
(
	tag_id INT UNIQUE NOT NULL,
	photo_id INT UNIQUE NOT NULL,
	PRIMARY KEY (tag_id, photo_id),
	FOREIGN KEY (photo_id) REFERENCES photos (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
	FOREIGN KEY (tag_id) REFERENCES tags (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

INSERT INTO photo_tags (tag_id, photo_id)
VALUES (1, 1),
       (2, 2);

DROP TABLE IF EXISTS comments;

CREATE TABLE IF NOT EXISTS comments
(
	id INT PRIMARY KEY,
	created_at DATETIME,
	photo_id INT NOT NULL,
	user_id INT NOT NULL,
	comment_text VARCHAR(255),
	FOREIGN KEY (photo_id) REFERENCES photos (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
	FOREIGN KEY (user_id) REFERENCES users (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

INSERT INTO comments (id, created_at, photo_id, user_id, comment_text)
VALUES (1, NOW(), 1, 234, 'this is trash'),
       (2, NOW(), 2, 123, 'checkout ');

DROP TABLE IF EXISTS likes;

CREATE TABLE IF NOT EXISTS likes
(
	user_id INT,
	photo_id INT,
	created_at DATETIME,
	PRIMARY KEY (user_id, photo_id),
	FOREIGN KEY (user_id) REFERENCES users (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
	FOREIGN KEY (photo_id) REFERENCES photos (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

INSERT INTO likes (user_id, photo_id, created_at)
VALUES (1, 1, NOW()),
       (1, 2, NOW());