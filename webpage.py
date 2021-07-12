from flask import Flask, redirect, url_for, render_template, request, session

app = Flask(__name__)
app.secret_key = "3546*&^*dsflk1234"

@app.route("/")
def home():
    return render_template("index.html")


@app.route("/vehinventory")
def vehicle_inventory():
    return render_template("vehicle_inventory.html")


@app.route("/modinventory")
def modify_inventory():
    return render_template("modify_inventory.html")

@app.route("/modsales")
def modify_sales():
    return render_template("modify_sales.html")

@app.route("/searchsales")
def search_sales():
    return render_template("search_sales.html")


@app.route("/testdrive")
def test_drive():
    return render_template("test_drive.html")

@app.route("/cfproject")
def cf_projection():
    return render_template("cf_projection.html")



'''
@app.route("/login", methods = ["POST","GET"])
def login():
    if request.method == "POST":
        user = request.form['nm']
        session["user"] = user
        return redirect(url_for("user"))
    else:
        return render_template("login.html")

@app.route("/user")
def user():
    if "user" in session:
        user = session["user"]
        return f"<h1> {user} </h1>"
    else:
        return redirect(url_for("login"))

@app.route("/logout")
def logout():
    session.pop("user",None)


if __name__ == "__main__":
    app.run(debug = True)
'''
