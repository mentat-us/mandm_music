CREATE DATABASE IF NOT EXISTS mandm_music;

USE mandm_music;

CREATE TABLE user(
	user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(300),
    name VARCHAR(300),
	last_name VARCHAR(300),
    e_mail VARCHAR(300),
    password VARCHAR(300)
);

CREATE TABLE customer (
	user_id INT,
    national_id_number BIGINT PRIMARY KEY AUTO_INCREMENT,
    FOREIGN KEY(user_id) REFERENCES user(user_id)
);

CREATE TABLE composer (
	user_id INT,
    national_id_number BIGINT PRIMARY KEY AUTO_INCREMENT,
    FOREIGN KEY(user_id) REFERENCES user(user_id)
);


CREATE TABLE recommendation (
	recommendation_id INT PRIMARY KEY AUTO_INCREMENT,
	video_file VARCHAR(256),
    offer_price DECIMAL,
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customer(user_id)
    

);
CREATE TABLE song (
	song_id INT PRIMARY KEY AUTO_INCREMENT,
    song_name VARCHAR(300),
    duration TIME,
    price DECIMAL,
    is_sold INT,
    recommendation_id INT,
    FOREIGN KEY(recommendation_id) REFERENCES recommendation(recommendation_id)
);






CREATE TABLE instrument_category (
	instrument_id INT PRIMARY KEY AUTO_INCREMENT,
    instrument_category VARCHAR(150) NOT NULL

);


CREATE TABLE genre_film (
	genre_id INT PRIMARY KEY AUTO_INCREMENT,
    genre_type VARCHAR(150) NOT NULL

);
CREATE TABLE comment (
	comment_id INT PRIMARY KEY AUTO_INCREMENT,
	comment_type VARCHAR(150),
    comment_date DATETIME,
    comment TEXT,
    user_id INT,
    song_id INT,
    FOREIGN KEY(user_id) REFERENCES user(user_id),
    FOREIGN KEY(song_id) REFERENCES song(song_id)
    
);
CREATE TABLE like_song (
	like_song_id INT PRIMARY KEY AUTO_INCREMENT,
	user_id INT,
    song_id INT,
    FOREIGN KEY(user_id) REFERENCES user(user_id),
    FOREIGN KEY(song_id) REFERENCES song(song_id)
    
);
CREATE TABLE vote (
	vote_id INT PRIMARY KEY AUTO_INCREMENT,
	user_id INT,
    song_id INT,
    vote_value INT,
    FOREIGN KEY(user_id) REFERENCES user(user_id),
    FOREIGN KEY(song_id) REFERENCES song(song_id)
    
);

CREATE TABLE song_genre (
	song_genre_id INT PRIMARY KEY AUTO_INCREMENT,
	genre_id INT,
    song_id INT,
    FOREIGN KEY(genre_id) REFERENCES genre_film(genre_id),
    FOREIGN KEY(song_id) REFERENCES song(song_id)
    

);

CREATE TABLE follow (
	follow_id INT PRIMARY KEY AUTO_INCREMENT,
	customer_id INT,
    composer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customer(user_id),
    FOREIGN KEY(composer_id) REFERENCES composer(user_id)
    
);
CREATE TABLE subscribe (
	subscribe_id INT PRIMARY KEY AUTO_INCREMENT,
	recommendation_id INT,
    composer_id INT,
    FOREIGN KEY(composer_id) REFERENCES composer(user_id),
    FOREIGN KEY(recommendation_id) REFERENCES recommendation(recommendation_id)

);

CREATE TABLE perform (
	perform_id INT PRIMARY KEY AUTO_INCREMENT,
	song_id INT,
    composer_id INT,
    FOREIGN KEY(composer_id) REFERENCES composer(user_id),
    FOREIGN KEY(song_id) REFERENCES song(song_id)

);
CREATE TABLE song_inst_cat (
	song_inst_cat_id INT PRIMARY KEY AUTO_INCREMENT,
	song_id INT,
    instrument_id INT,
    FOREIGN KEY(instrument_id) REFERENCES instrument_category(instrument_id),
    FOREIGN KEY(song_id) REFERENCES song(song_id)

);

CREATE TABLE transaction (
	trans_id INT PRIMARY KEY AUTO_INCREMENT,
    trans_date DATETIME,
	song_id INT,
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customer(user_id),
    FOREIGN KEY(song_id) REFERENCES song(song_id)

);











    