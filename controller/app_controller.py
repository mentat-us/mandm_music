from model.db_model import DBModel
from flask import Flask, request, redirect, render_template, url_for, session

app = Flask(__name__, template_folder='../view/templates')
app.secret_key = "hedehudu12345678"

db_model = DBModel("")

##Home page --> Display main menu
@app.route("/")
def index_page():
    return render_template("index.html")

@app.route("/song_list")
def song_list():
    if session.get("user_id"):
        res = db_model.get_songs()
        return render_template("list_songs.html", song_list=res)
    else:
        return render_template("login.html", mess="You must login to reach song list ")


@app.route("/user_list")
def display_user_list():
    res = db_model.get_user_list()
    return render_template("user_list.html", my_user_list=res, info_message="All User are listing")

#
@app.route("/like_song/<int:song_id>")
def like_song(song_id):
    #session dan user id alınacak
    user_id = session["user_id"][0]
    db_model.update_like_song(song_id, user_id)
    message = "{} song liked by user {}".format(song_id, user_id)
    res = db_model.get_songs()
    return render_template("list_songs.html", info_message=message, song_list=res)



@app.route("/display_liked_songs")
def display_liked_songs():
    res = db_model.get_liked_songs()
    return render_template("display_liked_songs.html", song_list=res)


@app.route("/login", methods=["POST"])
def login():
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]

        user_id = db_model.is_registered_user(username, password)
        if user_id is not None:
            session["user_name"] = username
            session["user_id"] = user_id
            return redirect(url_for("song_list"))
        else:
            return render_template("login.html", mess="Invalid user name or password")
    else:
        return render_template("login.html", mess="Invalid Method")


@app.route("/disp_vote_form/<int:song_id>")
def disp_vote_form(song_id):
    return render_template("vote.html", song_id=song_id)


@app.route("/save_vote/<int:song_id>", methods=["POST"])
def save_vote(song_id):
    if request.method == "POST":
        vote_val = request.form["song_vote"]
        user_id = session["user_id"][0]
        if vote_val:
            db_model.update_song_vote(vote_val, song_id, user_id)
            return redirect(url_for("song_list"))
        else:
            return redirect(url_for('save_vote'), mess="Invalid vote")

@app.route("/display_voted_songs")
def display_voted_songs():
    res = db_model.display_voted_songs()
    return render_template("display_voted_songs.html", song_list=res)


if __name__ == '__main__':
    app.run(debug=True)
