from flask import Flask, redirect, url_for, render_template, request, session
import MySQLdb as mariadb
from db_credentials import host, user, passwd, db
from flask_paginate import Pagination

app = Flask(__name__)
app.secret_key = "3546*&^*dsflk1234"
SESSION_TYPE = "filesystem"


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
    row_per_page = 15

    if request.method  == "GET" and request.args.get('page') is None:
        print("GET")
        if "search" in session:
            session.pop("search")
        return render_template("vehicle_inventory.html")
    
    elif request.method  == "POST":

        print("POST")
        db = connect_to_database()
        make = request.form["make"] 
        model = request.form["model"]
        year = request.form["year"]
        color = request.form["color"]
        trim = request.form["trim"]


        query = f"""
                SELECT dw_vehicle_type_id
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
                and a.sold_ind = '0'
                order by 1
                ;
                """
        results = execute_query(db, query, vehicle_type_id_list)
        inventory_result = [ list(r) for r in results.fetchall()]

        session["search"] = {}
        session["search"]["count"] = len(inventory_result)
        session["search"]["key"] = {}
        session["search"]["key"]["make"] = make
        session["search"]["key"]["model"] = model
        session["search"]["key"]["year"] = year
        session["search"]["key"]["color"] = color
        session["search"]["key"]["trim"] = trim

        if len(inventory_result) > row_per_page:
            next_url = url_for('vehicle_inventory', page=2)
        else:
            next_url = url_for('vehicle_inventory', page=1)
        prev_url = url_for('vehicle_inventory', page=1)


        return render_template("vehicle_inventory.html", content = inventory_result[0:row_per_page], prev_url=prev_url, next_url=next_url ) 

    elif "search" in session:

        db = connect_to_database()
        make = session["search"]["key"]["make"]
        model = session["search"]["key"]["model"]
        year = session["search"]["key"]["year"]
        color = session["search"]["key"]["color"]
        trim = session["search"]["key"]["trim"]


        query = f"""
                SELECT dw_vehicle_type_id
                from Vehicle_Types 
                where vehicle_make like "%%{make}%%"
                and vehicle_model like "%%{model}%%"
                and vehicle_year like "%%{year}%%"
                and vehicle_color like "%%{color}%%"
                and vehicle_trim like "%%{trim}%%"

                """
        results = execute_query(db, query)
        vehicle_type_id_list = [r[0] for r in results.fetchall()]       
        fstring_sub = ','.join(['%s'] * len(vehicle_type_id_list))

        page = request.args.get('page', 1, type=int)
        nth_record = (page-1) * row_per_page

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
                and a.sold_ind = '0'
                order by 1
                limit {nth_record},{row_per_page};
                """
        results = execute_query(db, query, vehicle_type_id_list)
        inventory_result = [ list(r) for r in results.fetchall()]


        if session["search"]["count"]  > (nth_record + row_per_page):
            next_url = url_for('vehicle_inventory', page= (page + 1))
        else:
            next_url = url_for('vehicle_inventory', page= page)

        if (nth_record - row_per_page) > 0:
            prev_url = url_for('vehicle_inventory', page=(page-1))
        else:
            prev_url = url_for('vehicle_inventory', page=1)
        


        return render_template("vehicle_inventory.html", content = inventory_result, prev_url=prev_url, next_url=next_url ) 







@app.route("/modsales", methods = ["POST","GET"])
def modify_sales():
    if request.method  == "GET" and request.args.get('page') is None:
        print("GET")
        if "search" in session:
            session.pop("search")
        return render_template("modify_sales.html")

    elif request.method  == "POST":

        print("POST")
        db = connect_to_database()


        vehicleid = request.form["vehicleid"]
        vin = request.form["vin"]
        finoption = request.form["finoption"]


        query = f"""
                SELECT dw_invoice_id
                from Sales_Records
                where  dw_vehicle_type_id like "%%{vehicleid}%%"
                and vin like "%%{vin}%%"
                and dw_fincl_option_id like "%%{finoption}%%";
                
                """
        results = execute_query(db, query)
        invoice_id_list = [r[0] for r in results.fetchall()]
        #fstring_sub = ','.join(['%s'] * len(invoice_id_list))

        results = execute_query(db, query, invoice_id_list)
        sales_result = [ list(r) for r in results.fetchall()]

        session["search"] = {}
        session["search"]["count"] = len(sales_result)
        session["search"]["key"] = {}
        session["search"]["key"]["vehicleid"] = vehicleid
        session["search"]["key"]["vin"] = vin
        session["search"]["key"]["finoption"] = finoption


        print(sales_result)

        return render_template("modify_sales.html", content = sales_result)

    elif "search" in session:

        db = connect_to_database()
        vehicleid = session["search"]["key"]["vehicleid"]
        vin = session["search"]["key"]["vin"]
        finoption = session["search"]["key"]["finoption"]


        query = f"""
                SELECT dw_invoice_id
                from Sales_Records
                where  dw_vehicle_type_id like "%%{vehicleid}%%"
                and vin like "%%{vin}%%"
                and dw_fincl_option_id like "%%{finoption}%%";

                """
        results = execute_query(db, query)
        sales_result = [r[0] for r in results.fetchall()]       
        #fstring_sub = ','.join(['%s'] * len(vehicle_type_id_list))

        print(sales_result)

        return render_template("modify_sales.html", content = sales_result ) 


@app.route("/testdrive", methods = ["POST","GET"])
def test_drive():
    if request.method  == "GET" and request.args.get('page') is None:
        print("GET")
        if "search" in session:
            session.pop("search")
        return render_template("test_drive.html")

    elif request.method  == "POST":

        print("POST")
        db = connect_to_database()
        test_drive_id = request.form["tdriveid"] 
        customer_id = request.form["cid"]
        t_drive_date = request.form["tdate"]
        check_out_time = request.form["cotime"]
        return_time = request.form["rtime"]
        vin = request.form["vin"]
    
    #return render_template("test_drive.html")

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

