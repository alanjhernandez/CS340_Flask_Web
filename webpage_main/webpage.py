from flask import Flask, redirect, url_for, render_template, request, session, jsonify
import MySQLdb as mariadb
from db_credentials import host, user, passwd, db
from flask_paginate import Pagination
from json import dumps
from datetime import datetime

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
    row_per_page = 10



    if request.is_json:
        if request.method  == "POST" and request.json["request_type"] == "testdrive_check":
            db = connect_to_database()
            vin = request.json["vin"] 
            print(vin)

            query = f"""
                    SELECT 
                    dw_test_drive_id
                    ,test_drive_date
                    ,check_out_time
                    ,return_time
                    from Test_Drives
                    where vin = "{vin}"
                    order by 2 ,3 ,4 ;
                    """
            results = execute_query(db, query)
            test_drive_result_list = [list(r) for r in results.fetchall()]

            test_drive_result = {}

            if len(test_drive_result_list) == 0:
                test_drive_result["result"] = "N"
            else:
                test_drive_result["result"] = "Y"
            
            test_drive_result["Data"] = {}

            for i in test_drive_result_list:
                test_drive_id = str(i[0])
                test_drive_result["Data"][test_drive_id] = {}
                test_drive_result["Data"][test_drive_id]["test_drive_date"] = i[1].strftime("%Y-%m-%d")
                test_drive_result["Data"][test_drive_id]["check_out_time"] = i[2].strftime("%H:%M:%S")
                test_drive_result["Data"][test_drive_id]["return_time"] = i[3].strftime("%H:%M:%S")

            print(test_drive_result)
            return jsonify(test_drive_result)

        elif request.method  == "POST" and request.json["request_type"] == "delete":
            db = connect_to_database()
            vin = request.json["vin"] 
            page = int(request.json["page"])

            query = f"""
                    delete from Vehicle_Inventories
                    where vin = "{vin}";
                    """
            results = execute_query(db, query)
            


            make = session["search"]["key"]["make"]
            model = session["search"]["key"]["model"]
            year = session["search"]["key"]["year"]
            color = session["search"]["key"]["color"]
            trim = session["search"]["key"]["trim"]
            session["search"]["count"] -= 1



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
                next_page = page + 1
            else:
                next_page = page

            if (nth_record - row_per_page) > 0:
                prev_page = page - 1
            else:
                prev_page = 1

            status_msg = "Record Deleted."
            
            return render_template("vehicle_inventory.html", content = inventory_result, prev_page = prev_page, current_page = page, next_page = next_page ) 



        elif request.method  == "POST" and request.json["request_type"] == "update_read":
            db = connect_to_database()
            vin = request.json["vin"] 
            page = int(request.json["page"])
            print(vin)

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


                    where a.vin = "{vin}";
                    """

            results = execute_query(db, query)
            inventory_result = [ list(r) for r in results.fetchall()][0]

            update_record = {}

            update_record["vin"] = inventory_result[0]
            update_record["type"]  = inventory_result[1]
            update_record["make"] = inventory_result[2]
            update_record["model"] = inventory_result[3]
            update_record["year"] = inventory_result[4]
            update_record["color"] = inventory_result[5]
            update_record["trim"] = inventory_result[6]
            update_record["used"] = inventory_result[8]
            update_record["store_location"] = inventory_result[9]
            update_record["parking_location"] = inventory_result[10]
             

            print(update_record)
            return jsonify(update_record)

    else:
        if request.method  == "GET":
            print("GET")
            if "search" in session:
                session.pop("search")
            return render_template("vehicle_inventory.html")

        
        elif request.method  == "POST" and request.form["request_type"] == "new_search":

            print("POST")

            if "search" in session:
                session.pop("search")

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
                    limit 15
                    ;
                    """

            results = execute_query(db, query, vehicle_type_id_list)
            inventory_result = [ list(r) for r in results.fetchall()]

            query = f"""
                    SELECT count(*) as vehicle_count
                    from Vehicle_Inventories as a
                    where a.sold_ind = '0'
                
                    ;
                    """
                    
            results = execute_query(db, query)
            inventory_count = [ r for r in results.fetchall()]
  
            session["search"] = {}
            session["search"]["count"] = inventory_count[0][0]
            session["search"]["key"] = {}
            session["search"]["key"]["make"] = make
            session["search"]["key"]["model"] = model
            session["search"]["key"]["year"] = year
            session["search"]["key"]["color"] = color
            session["search"]["key"]["trim"] = trim

            if inventory_count[0][0] > row_per_page:
                #next_url = url_for('vehicle_inventory', page=2)
                next_page = 2
            else:
                #next_url = url_for('vehicle_inventory', page=1)
                next_page = 1 

            print(next_page)
            #prev_url = url_for('vehicle_inventory', page=1)
            prev_page = 1


            return render_template("vehicle_inventory.html", content = inventory_result[0:row_per_page], prev_page = prev_page, current_page = 1, next_page = next_page, status_msg = "") 

        elif request.method  == "POST"  and request.form["request_type"] == "continue_search":

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


            page = int(request.form["page_num"])
            print(page)
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
                next_page = page + 1
            else:
                next_page = page

            if (nth_record - row_per_page) > 0:
                prev_page = page - 1
            else:
                prev_page = 1
            
            return render_template("vehicle_inventory.html", content = inventory_result, prev_page = prev_page, current_page = page, next_page = next_page, status_msg = "" ) 

        elif request.method  == "POST"  and request.form["request_type"] == "update-submit":

            print(request.form)


            db = connect_to_database()


            vtype = request.form["type"] 
            make = request.form["make"] 
            model = request.form["model"] 
            year = request.form["year"] 
            color = request.form["color"] 
            trim = request.form["trim"] 
            used = request.form["used"] 
            store_location = request.form["store"] 
            parking_location = request.form["parking"] 
            vin = request.form["vin"] 
            orig_vin = request.form["orig_vin"] 

            query = f"""
                    SELECT dw_vehicle_type_id
                    from Vehicle_Types 
                    where vehicle_make = "{make}"
                    and vehicle_type = "{vtype}"
                    and vehicle_model = "{model}"
                    and vehicle_year = "{year}"
                    and vehicle_color = "{color}"
                    and vehicle_trim = "{trim}";
                    """

            results = execute_query(db, query)
            vehicle_type_id_list = [r[0] for r in results.fetchall()]

            if len(vehicle_type_id_list) > 0:
                vehicle_type_id = vehicle_type_id_list[0]

                query = f"""
                        UPDATE Vehicle_Inventories
                        SET dw_vehicle_type_id = "{vehicle_type_id}",
                        vin = "{vin}",
                        store_location = "{store_location}",
                        parking_location = "{parking_location}",
                        used_ind = "{used}"
                        WHERE vin = "{orig_vin}";
                        """

                results = execute_query(db, query)                

                status_msg = "Update Successful."
            else:
                status_msg = "Invalid vehicle information"


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


            page = int(request.form["page"])
            print(page)
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
                next_page = page + 1
            else:
                next_page = page

            if (nth_record - row_per_page) > 0:
                prev_page = page - 1
            else:
                prev_page = 1
            
            return render_template("vehicle_inventory.html", content = inventory_result, prev_page = prev_page, current_page = page, next_page = next_page, status_msg = status_msg ) 


        elif request.method  == "POST"  and request.form["request_type"] == "add-submit":

            print(request.form)


            db = connect_to_database()


            vtype = request.form["type"] 
            make = request.form["make"] 
            model = request.form["model"] 
            year = request.form["year"] 
            color = request.form["color"] 
            trim = request.form["trim"] 
            used = request.form["used"] 
            store_location = request.form["store"] 
            vin = request.form["vin"] 


            query = f"""
                    SELECT dw_vehicle_type_id
                    from Vehicle_Types 
                    where vehicle_make = "{make}"
                    and vehicle_type = "{vtype}"
                    and vehicle_model = "{model}"
                    and vehicle_year = "{year}"
                    and vehicle_color = "{color}"
                    and vehicle_trim = "{trim}";
                    """

            results = execute_query(db, query)
            vehicle_type_id_list = [r[0] for r in results.fetchall()]


            query = f"""
                    SELECT vin
                    from Vehicle_Inventories
                    where vin = "{vin}";
                    """

            results = execute_query(db, query)
            vin_list = [r[0] for r in results.fetchall()]

            query = f"""
                    
                    select 
                    min(parking_lot) as destination
                    from (
                    SELECT substring(parking_location,1,1) as parking_lot 
                    ,count(distinct vin) as count 
                    FROM Vehicle_Inventories
                    WHERE store_location = "{store_location}"
                    group by 1
                    having count <> 1000
                    ) as a
                    
                                       

                    """

            results = execute_query(db, query)
            parking_lot_not_full = [r[0] for r in results.fetchall()]
            #print(parking_lot_not_full)
 

            query = f"""
                    

                    SELECT max(substring(parking_location,1,1)) as destination 

                    FROM Vehicle_Inventories
                    WHERE store_location = "{store_location}"
  
                    """

            results = execute_query(db, query)
            parking_lot_list = [r[0] for r in results.fetchall()]
            #print(parking_lot_list)


            if len(parking_lot_not_full) > 0:
                parking_destination = parking_lot_not_full[0]
            else:
                parking_destination = chr(ord(parking_lot_list[0]) + 1)
            #print(chr(ord(parking_lot_list[0]) + 1))

            query = f"""
                    select 
                    substring(a.parking_location,2) as parked_spot
                    from Vehicle_Inventories as a

                    inner join (
                    select 
                    min(parking_lot) as destination
                    from (
                    SELECT substring(parking_location,1,1) as parking_lot 
                    ,count(distinct vin) as count 
                    FROM Vehicle_Inventories
                    WHERE store_location = "{store_location}"
                    group by 1
                    having count <> 1000
                    ) as a
                    ) as b
                    on substring(a.parking_location,1,1) = b.destination
                    
                    WHERE a.store_location = "{store_location}";

                    """

            results = execute_query(db, query)
            parking_list = set([int(r[0]) for r in results.fetchall()])
            parking_num = min(set(range(1,1001)) - parking_list)

            final_parking_location = parking_destination + str(parking_num)


            if len(vehicle_type_id_list) > 0 and len(vin_list) == 0:
                vehicle_type_id = vehicle_type_id_list[0]

                query = f"""
                        INSERT INTO Vehicle_Inventories (dw_vehicle_type_id, vin, store_location, parking_location, used_ind) VALUES ("{vehicle_type_id}","{vin}","{store_location}","{final_parking_location}","{used}");
                        """
                print(query)

                results = execute_query(db, query)                

                status_msg = "Insert Successful. Please park at " + final_parking_location
            else:
                status_msg = "Invalid vehicle information."


            if "search" in session:

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


                page = int(request.form["page"])
                print(page)
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
                    next_page = page + 1
                else:
                    next_page = page

                if (nth_record - row_per_page) > 0:
                    prev_page = page - 1
                else:
                    prev_page = 1
                
                return render_template("vehicle_inventory.html", content = inventory_result, prev_page = prev_page, current_page = page, next_page = next_page, status_msg = status_msg ) 
            else:
                return render_template("vehicle_inventory.html", status_msg = status_msg ) 







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



'''


if __name__ == "__main__":
    app.run(debug = True)



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

