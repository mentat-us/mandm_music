import mysql.connector


class DBModel:
    def __init__(self, password, user_name="root"):
        self.__db = mysql.connector.connect(host="127.0.0.1", user=user_name, password=password, database="mandm_music")
        if not self.__db.is_connected():
            raise mysql.connector.DatabaseError("Can not connecto to the database")
        self.__cursor = self.__db.cursor()

    def get_songs(self):
        self.__cursor.execute("SELECT sg.song_id, sg.song_name, us.name, us.last_name, sg.duration, sg.price,\
								CASE \
									WHEN sg.is_sold = 1 THEN 'SOLD'\
									ELSE 'AVAILABLE' \
								END AS is_solded\
								FROM song AS sg \
                              JOIN perform AS pf ON  sg.song_id = pf.song_id \
                              JOIN user AS us ON us.user_id = pf.composer_id;")
        return self.__cursor.fetchall()

    def get_user_list(self):
        self.__cursor.execute("SELECT user_id, user_name, name, last_name, e_mail FROM user ORDER BY user_name")
        return self.__cursor.fetchall()


    def update_like_song(self, song_id, user_id):
        self.__cursor.execute("INSERT INTO like_song (user_id, song_id) VALUES(%s, %s)", (user_id, song_id))
        self.__db.commit()

    def get_liked_songs(self):
        self.__cursor.execute("SELECT distinct ls.song_id, sg.song_name, sg.price,\
                                CASE\
									WHEN sg.is_sold = 1 THEN 'SOLD'\
									ELSE 'AVAILABLE' \
								END  AS is_solded FROM like_song AS ls \
				                LEFT JOIN song AS sg ON ls.song_id = sg.song_id")
        return self.__cursor.fetchall()

    def is_registered_user(self, uname, passw):
        self.__cursor.execute("SELECT user_id FROM user WHERE user_name=%s and password=%s", (uname, passw))
        res = self.__cursor.fetchall()

        if len(res) > 0:
            return res[0]
        return None

    def update_song_vote(self, vote_val, song_id, user_id):
        self.__cursor.execute("INSERT INTO vote (user_id, song_id, vote_value) VALUES(%s, %s, %s)",
                              (user_id, song_id, vote_val))
        self.__db.commit()

    def display_voted_songs(self):
        self.__cursor.execute("SELECT song_name, price, duration, AVG(V.vote_value) AS v_val,\
                              COUNT(V.vote_value) AS count from vote AS V \
                                LEFT JOIN user AS U ON V.user_id = U.user_id \
                                LEFT JOIN song AS S ON V.song_id = S.song_id \
                                GROUP BY song_name \
                                ORDER BY v_val DESC")
        return self.__cursor.fetchall()

