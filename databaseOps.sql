##getting songs
                             
SELECT sg.song_id, sg.song_name, us.name, us.last_name, sg.duration, sg.price, 
								(CASE
									WHEN sg.is_sold = 1 THEN "SOLD"
									ELSE "AVAILABLE" 
								END) AS is_solded
								FROM song AS sg 
                              JOIN perform AS pf ON  sg.song_id = pf.song_id 
                              JOIN user AS us ON us.user_id = pf.composer_id;
 
 
 ##insert like_song table 
INSERT INTO like_song (user_id, song_id) VALUES(1, 1);

##checks user has already in users table
SELECT user_id FROM user WHERE user_name="admin" and password="pass123";



##insert vote table to vote value
INSERT INTO vote (user_id, song_id, vote_value) VALUES(1, 1, 1);

##gets all user tuples from users table
SELECT user_id, user_name, name, last_name, e_mail FROM user ORDER BY user_name;

##gets all liked songs
##left join done since we only need the liked songs from all list
SELECT distinct ls.song_id, sg.song_name, sg.price, CASE
									WHEN sg.is_sold = 1 THEN "SOLD"
									ELSE "AVAILABLE" 
								END AS is_solded FROM like_song AS ls
				 LEFT JOIN song AS sg ON ls.song_id = sg.song_id;


#display votedd songs
SELECT song_name, price, duration, AVG(V.vote_value) AS v_val, COUNT(V.vote_value) AS count from vote AS V 
		LEFT JOIN user AS U ON V.user_id = U.user_id
        LEFT JOIN song AS S ON V.song_id = S.song_id
        GROUP BY song_name
        ORDER BY v_val DESC
        

        
        