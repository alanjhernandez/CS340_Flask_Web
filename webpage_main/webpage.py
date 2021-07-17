from flask import Flask, redirect, url_for, render_template, request, session
import MySQLdb as mariadb
from db_credentials import host, user, passwd, db

app = Flask(__name__)
app.secret_key = "3546*&^*dsflk1234"


def connect_to_database(host = host, user = user, passwd = passwd, db = db):
    '''
    connects to a database and returns a database objects
    '''
    db_connection = mariadb.connect(host,user,passwd,db)
    return db_connection





app = Flask(__name__)
app.secret_key = "3546*&^*dsflk1234"

@app.route("/")
def home():
    return render_template("index.html")



@app.route("/vehinventory", methods = ["POST","GET"])
def vehicle_inventory():


    if request.method  == "POST":
        db = connect_to_database()
        make = request.form["make"] 
        model = request.form["model"]
        year = request.form["year"]
        color = request.form["color"]
        trim = request.form["trim"]
        query = f"""
                SELECT *
                from Vehicle_Types 
                where vehicle_make like "%%{make}%%"
                and vehicle_model like "%%{model}%%"
                and vehicle_year like "%%{year}%%"
                and vehicle_color like "%%{color}%%"
                and vehicle_trim like "%%{trim}%%";
                """
        results = execute_query(db, query)
        vehicle_type_id_list = [r[0] for r in results.fetchall()]
        
        fstring_sub = ','.join(['%s'] * len(vehicle_type_id_list))

        query = f"""
                SELECT 
                a.vin
                ,b.vehicle_type
                ,b.vehicle_make
                ,b.vehicle_model
                ,b.vehicle_year
                ,b.vehicle_color
                ,b.vehicle_trim
                ,b.vehicle_price
                ,Case when a.used_ind = '1' then 'Used' else 'New' end as used_ind
                ,a.store_location
                ,a.parking_location
                 from Vehicle_Inventories as a

                inner join Vehicle_Types as b
                on a.dw_vehicle_type_id = b.dw_vehicle_type_id


                where b.dw_vehicle_type_id IN ({fstring_sub})
                order by store_location, parking_location
                """
        results = execute_query(db, query, vehicle_type_id_list)

        inventory_result = [ list(r) for r in results.fetchall()]
        #print(inventory_result)

        return render_template("vehicle_inventory.html", content = inventory_result) 
    else:
        return render_template("vehicle_inventory.html")




@app.route("/modsales")
def modify_sales():
    '''
    if request.method == 'POST':
        task_content = request.form[''] <-Add
    '''
    return render_template("modify_sales.html")

    #add update route for sales
@app.route("/testdrive")
def test_drive():
    return render_template("test_drive.html")

@app.route("/cfproject")
def cf_projection():
    return render_template("cf_projection.html")


def execute_query(db_connection = None, query = None, query_params = ()):
    '''
    executes a given SQL query on the given db connection and returns a Cursor object
    db_connection: a MySQLdb connection object created by connect_to_database()
    query: string containing SQL query
    returns: A Cursor object as specified at https://www.python.org/dev/peps/pep-0249/#cursor-objects.
    You need to run .fetchall() or .fetchone() on that object to actually acccess the results.
    '''

    if db_connection is None:
        print("No connection to the database found! Have you called connect_to_database() first?")
        return None

    if query is None or len(query.strip()) == 0:
        print("query is empty! Please pass a SQL query in query")
        return None

    print("Executing %s with %s" % (query, query_params))
    # Create a cursor to execute query. Why? Because apparently they optimize execution by retaining a reference according to PEP0249
    cursor = db_connection.cursor()

    '''
    params = tuple()
    #create a tuple of paramters to send with the query
    for q in query_params:
        params = params + (q)
    '''
    #TODO: Sanitize the query before executing it!!!
    cursor.execute(query, query_params)
    # this will actually commit any changes to the database. without this no
    # changes will be committed!
    db_connection.commit()
    return cursor






if __name__ == "__main__":
    app.run(debug = True)


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

'''

