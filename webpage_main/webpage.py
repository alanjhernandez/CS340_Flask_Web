from flask import Flask, redirect, url_for, render_template, request, session, jsonify
import MySQLdb as mariadb
from db_credentials import host, user, passwd, db
from flask_paginate import Pagination
from json import dumps
from datetime import datetime
#import numpy as np

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


            page = int(request.form["page"])
            print(page)
            nth_record = (page-1) * row_per_page + 1

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





@app.route("/modsales", methods = ["POST","GET"])
def modify_sales():

    row_per_page = 15
    if request.is_json:
        if request.method  == "POST" and request.json["request_type"] == "customer_check":
            
            db = connect_to_database()
            dw_customer_id = request.json["dw_customer_id"] 
            
            query = f"""
                    SELECT 
                    dw_customer_id
                    ,first_name
                    ,last_name
                    ,customer_dob
                    ,address_1
                    ,address_2
                    ,zip_code
                    ,state
                    ,city
                    ,tel_number
                    ,ssn
                    from Customers_Info
                    where dw_customer_id = "{dw_customer_id}"
                    """
            results = execute_query(db, query)
            customer_info_list = [list(r) for r in results.fetchall()]

            if len(customer_info_list) > 0:
                customer_info_list[0][3] = customer_info_list[0][3].strftime("%Y-%m-%d")

            print(customer_info_list)
            if len(customer_info_list) > 0:
                return jsonify(customer_info_list[0])
            else:
                return jsonify("-1")

        elif request.method  == "POST" and request.json["request_type"] == "sales_check":
            
            db = connect_to_database()
            dw_sales_rep_id = request.json["dw_sales_rep_id"] 
            
            query = f"""
                    SELECT 
                    dw_sales_rep_id
                    ,first_name
                    ,last_name
                    ,primary_location
                    from Sales_Reps
                    where dw_sales_rep_id = "{dw_sales_rep_id}"
                    """
            results = execute_query(db, query)
            sales_info_list = [list(r) for r in results.fetchall()]


            print(sales_info_list)
            if len(sales_info_list) > 0:
                return jsonify(sales_info_list[0])
            else:
                return jsonify("-1")

        elif request.method  == "POST" and request.json["request_type"] == "vehicle_check":
            
            db = connect_to_database()
            vin = request.json["vin"] 
            
            query = f"""
                    select 
                    dw_vehicle_type_id
                    ,vehicle_type
                    ,vehicle_make
                    ,vehicle_model
                    ,vehicle_year
                    ,vehicle_color
                    ,vehicle_trim
                    ,vehicle_price
                    from Vehicle_Types 
                    where dw_vehicle_type_id in(SELECT dw_vehicle_type_id FROM Vehicle_Inventories where vin = '{vin}' and sold_ind = '0')
                    
                    """
            results = execute_query(db, query)
            vin_list = [list(r) for r in results.fetchall()]


            print(vin_list)
            if len(vin_list) > 0:
                return jsonify(vin_list[0])
            else:
                return jsonify("-1")

        elif request.method  == "POST" and request.json["request_type"] == "financial_pull":
            
            db = connect_to_database()
            
            query = f"""
                    select 
                    dw_fincl_option_id
                    ,int_rate
                    ,num_of_payment
                    from Financial_Options
                    """
            results = execute_query(db, query)
            financial_list = [list(r) for r in results.fetchall()]


            print(financial_list)
            return jsonify(financial_list)

        elif request.method  == "POST" and request.json["request_type"] == "financial_check":
            
            db = connect_to_database()
            dw_fincl_option_id = request.json["dw_fincl_option_id"] 
            
            query = f"""
                    select 
                    dw_fincl_option_id
                    ,int_rate
                    ,num_of_payment
                    from Financial_Options
                    where dw_fincl_option_id = '{dw_fincl_option_id}';
                    """
            results = execute_query(db, query)
            financial_list = [list(r) for r in results.fetchall()]


            print(financial_list[0])
            return jsonify(financial_list[0])



        elif request.method  == "POST" and request.json["request_type"] == "payment_check":
            
            db = connect_to_database()
            dw_invoice_id = request.json["dw_invoice_id"] 
            
            query = f"""
                    SELECT 
                    dw_payment_id
                    ,dw_invoice_id
                    ,cast(payment_date as varchar(10)) as payment_date
                    ,nth_payment
                    ,payment_amount
                    ,current_balance
                    from Monthly_Payments
                    where dw_invoice_id = "{dw_invoice_id}"
                    order by 3
                    """
            results = execute_query(db, query)
            payment_data = [list(r) for r in results.fetchall()]


            print(payment_data)
            payment_json = {}
            if payment_data[(len(payment_data)-1)][5] <= 0:
                payment_json["Full"] = "Y"
            else:
                payment_json["Full"] = "N"
            
            payment_json["Data"] = payment_data

            return jsonify(payment_json)

        elif request.method  == "POST" and request.json["request_type"] == "sales_delete":
            db = connect_to_database()
            dw_invoice_id = request.json["dw_invoice_id"] 
            page = int(request.json["page"])


            query = f"""
            UPDATE  Vehicle_Inventories
            SET sold_ind = '0'
            where vin in (select vin from Sales_Record where vin = '{vin}')
            """
            results = execute_query(db, query)
            
            query = f"""
                    delete from Sales_Records
                    where dw_invoice_id = '{dw_invoice_id}'
                    """
            results = execute_query(db, query)


            make = session["sales_search"]["key"]["make"] 
            model = session["sales_search"]["key"]["model"]
            year = session["sales_search"]["key"]["year"]
            color = session["sales_search"]["key"]["color"] 
            trim = session["sales_search"]["key"]["trim"]
            vin = session["sales_search"]["key"]["vin"]
            clname = session["sales_search"]["key"]["customer_lname"] 
            cfname = session["sales_search"]["key"]["customer_fname"] 
            slname = session["sales_search"]["key"]["sales_lname"] 
            sfname = session["sales_search"]["key"]["sales_fname"] 

            page = int(request.json["page"])
            print(page)
            nth_record = (page-1) * row_per_page + 1

            query = f"""
                    select 
                    a.dw_invoice_id
                    ,a.vin
                    ,b.customer_first_name
                    ,b.customer_last_name
                    ,b.sales_first_name
                    ,b.sales_last_name
                    ,c.vehicle_type
                    ,c.vehicle_make
                    ,c.vehicle_model
                    ,c.vehicle_year
                    ,c.vehicle_color
                    ,c.vehicle_trim
                    ,c.vehicle_price
                    ,down_payment_amount
                    ,Monthly_Payment_amount
                    ,concat(int_rate, '/', num_of_payment) as payment_arrangement
                    ,dw_customer_id
                    ,dw_sales_rep_id
                    from Sales_Records as a


                    inner join (
                    SELECT 
                    a.dw_invoice_id
                    ,a.dw_customer_id
                    ,a.dw_sales_rep_id
                    ,b.first_name as Customer_First_Name
                    ,b.last_name as Customer_Last_Name
                    ,c.first_name as Sales_First_Name
                    ,c.last_name as Sales_Last_Name


                    FROM Customers_Salesreps as a

                    inner join Customers_Info as b
                    on a.dw_customer_id = b.dw_customer_id

                    inner join Sales_Reps as c
                    on a.dw_sales_rep_id = c.dw_sales_rep_id


                    where c.first_name like "%%{sfname}%%"
                    and c.last_name like "%%{slname}%%"
                    and b.first_name like "%%{cfname}%%"
                    and b.last_name like "%%{clname}%%"
    

                    ) as b
                    on a.dw_invoice_id = b.dw_invoice_id


                    inner join (
                    SELECT 
                    dw_vehicle_type_id
                    ,vehicle_type
                    ,vehicle_make
                    ,vehicle_model
                    ,vehicle_year
                    ,vehicle_color
                    ,vehicle_trim
                    ,vehicle_price
                    from Vehicle_Types 
                    where vehicle_make like "%%{make}%%"
                    and vehicle_model like "%%{model}%%"
                    and vehicle_year like "%%{year}%%"
                    and vehicle_color like "%%{color}%%"
                    and vehicle_trim like "%%{trim}%%"

                    ) as c
                    on a.dw_vehicle_type_id = c.dw_vehicle_type_id

                    left join Financial_Options as d
                    on a.dw_fincl_option_id = d.dw_fincl_option_id

                    where a.vin like "%%{vin}%%"


                    order by dw_invoice_id
                    limit {nth_record}, {row_per_page}
                    """

            results = execute_query(db, query)
            sales_list = [list(r) for r in results.fetchall()]
            print(sales_list)


            if session["sales_search"]["count"] > (nth_record + row_per_page):
                next_page = page + 1
            else:
                next_page = page

            if (nth_record - row_per_page) > 0:
                prev_page = page - 1
            else:
                prev_page = 1
            
            return render_template("modify_sales.html", content = sales_list, prev_page = prev_page, current_page = page, next_page = next_page) 


    else:

        if request.method  == "GET" and request.args.get('page') is None:
            return render_template("modify_sales.html")

        elif request.method  == "POST"  and request.form["request_type"] == "sales_new_search":

            print("POST")
            db = connect_to_database()

            make = request.form["make"] 
            model = request.form["model"] 
            year = request.form["year"] 
            color = request.form["color"] 
            trim = request.form["trim"] 
            vin = request.form["vin"] 
            clname = request.form["customer_lname"] 
            cfname = request.form["customer_fname"] 
            slname = request.form["sales_lname"] 
            sfname = request.form["sales_fname"] 

            print(request.form)
 
            query = f"""
                    select 
                    a.dw_invoice_id
                    ,a.vin
                    ,b.customer_first_name
                    ,b.customer_last_name
                    ,b.sales_first_name
                    ,b.sales_last_name
                    ,c.vehicle_type
                    ,c.vehicle_make
                    ,c.vehicle_model
                    ,c.vehicle_year
                    ,c.vehicle_color
                    ,c.vehicle_trim
                    ,c.vehicle_price
                    ,down_payment_amount
                    ,Monthly_Payment_amount
                    ,concat(int_rate, '/', num_of_payment) as payment_arrangement
                    ,dw_customer_id
                    ,dw_sales_rep_id
                    from Sales_Records as a


                    inner join (
                    SELECT 
                    a.dw_invoice_id
                    ,a.dw_customer_id
                    ,a.dw_sales_rep_id
                    ,b.first_name as Customer_First_Name
                    ,b.last_name as Customer_Last_Name
                    ,c.first_name as Sales_First_Name
                    ,c.last_name as Sales_Last_Name


                    FROM Customers_Salesreps as a

                    inner join Customers_Info as b
                    on a.dw_customer_id = b.dw_customer_id

                    inner join Sales_Reps as c
                    on a.dw_sales_rep_id = c.dw_sales_rep_id

                    where c.first_name like "%%{sfname}%%"
                    and c.last_name like "%%{slname}%%"
                    and b.first_name like "%%{cfname}%%"
                    and b.last_name like "%%{clname}%%"
    

                    ) as b
                    on a.dw_invoice_id = b.dw_invoice_id


                    inner join (
                    SELECT 
                    dw_vehicle_type_id
                    ,vehicle_type
                    ,vehicle_make
                    ,vehicle_model
                    ,vehicle_year
                    ,vehicle_color
                    ,vehicle_trim
                    ,vehicle_price
                    from Vehicle_Types 
                    where vehicle_make like "%%{make}%%"
                    and vehicle_model like "%%{model}%%"
                    and vehicle_year like "%%{year}%%"
                    and vehicle_color like "%%{color}%%"
                    and vehicle_trim like "%%{trim}%%"

                    ) as c
                    on a.dw_vehicle_type_id = c.dw_vehicle_type_id


                    left join Financial_Options as d
                    on a.dw_fincl_option_id = d.dw_fincl_option_id

                    where a.vin like "%%{vin}%%"


                    order by dw_invoice_id
                    limit 15
                    """

            results = execute_query(db, query)
            sales_list = [list(r) for r in results.fetchall()]
            print(sales_list)




            query = f"""
                    select 
                    count(distinct vin) as sales_count
                    from Sales_Records as a


                    inner join (
                    SELECT 
                    a.dw_invoice_id
                    ,a.dw_customer_id
                    ,a.dw_sales_rep_id
                    ,b.first_name as Customer_First_Name
                    ,b.last_name as Customer_Last_Name
                    ,c.first_name as Sales_First_Name
                    ,c.last_name as Sales_Last_Name


                    FROM Customers_Salesreps as a

                    inner join Customers_Info as b
                    on a.dw_customer_id = b.dw_customer_id

                    inner join Sales_Reps as c
                    on a.dw_sales_rep_id = c.dw_sales_rep_id

                    where c.first_name like "%%{sfname}%%"
                    and c.last_name like "%%{slname}%%"
                    and b.first_name like "%%{cfname}%%"
                    and b.last_name like "%%{clname}%%"
    

                    ) as b
                    on a.dw_invoice_id = b.dw_invoice_id


                    inner join (
                    SELECT 
                    dw_vehicle_type_id
                    ,vehicle_type
                    ,vehicle_make
                    ,vehicle_model
                    ,vehicle_year
                    ,vehicle_color
                    ,vehicle_trim
                    ,vehicle_price
                    from Vehicle_Types 
                    where vehicle_make like "%%{make}%%"
                    and vehicle_model like "%%{model}%%"
                    and vehicle_year like "%%{year}%%"
                    and vehicle_color like "%%{color}%%"
                    and vehicle_trim like "%%{trim}%%"

                    ) as c
                    on a.dw_vehicle_type_id = c.dw_vehicle_type_id

                    where a.vin like "%%{vin}%%"    
                    """

            results = execute_query(db, query)
            sales_count = [list(r) for r in results.fetchall()]
            print(sales_count)

            session["sales_search"] = {}
            session["sales_search"]["count"] = sales_count[0][0]
            session["sales_search"]["key"] = {}
            session["sales_search"]["key"]["make"] = make
            session["sales_search"]["key"]["model"] = model
            session["sales_search"]["key"]["year"] = year
            session["sales_search"]["key"]["color"] = color
            session["sales_search"]["key"]["trim"] = trim
            session["sales_search"]["key"]["vin"] = vin
            session["sales_search"]["key"]["customer_lname"] = clname
            session["sales_search"]["key"]["customer_fname"] = cfname
            session["sales_search"]["key"]["sales_lname"] = slname
            session["sales_search"]["key"]["sales_fname"] = sfname


 

            if sales_count[0][0] > row_per_page:
                #next_url = url_for('vehicle_inventory', page=2)
                next_page = 2
            else:
                #next_url = url_for('vehicle_inventory', page=1)
                next_page = 1 

            print(next_page)
            #prev_url = url_for('vehicle_inventory', page=1)
            prev_page = 1


            return render_template("modify_sales.html", content = sales_list, prev_page = prev_page, current_page = 1, next_page = next_page)


        elif request.method  == "POST"  and request.form["request_type"] == "sales_continue_search":

            db = connect_to_database()

            row_per_page = 15

            make = session["sales_search"]["key"]["make"] 
            model = session["sales_search"]["key"]["model"]
            year = session["sales_search"]["key"]["year"]
            color = session["sales_search"]["key"]["color"] 
            trim = session["sales_search"]["key"]["trim"]
            vin = session["sales_search"]["key"]["vin"]
            clname = session["sales_search"]["key"]["customer_lname"] 
            cfname = session["sales_search"]["key"]["customer_fname"] 
            slname = session["sales_search"]["key"]["sales_lname"] 
            sfname = session["sales_search"]["key"]["sales_fname"] 

            page = int(request.form["page"])
            print(page)
            nth_record = (page-1) * row_per_page + 1

            query = f"""
                    select 
                    a.dw_invoice_id
                    ,a.vin
                    ,b.customer_first_name
                    ,b.customer_last_name
                    ,b.sales_first_name
                    ,b.sales_last_name
                    ,c.vehicle_type
                    ,c.vehicle_make
                    ,c.vehicle_model
                    ,c.vehicle_year
                    ,c.vehicle_color
                    ,c.vehicle_trim
                    ,c.vehicle_price
                    ,down_payment_amount
                    ,Monthly_Payment_amount
                    ,concat(int_rate, '/', num_of_payment) as payment_arrangement
                    ,dw_customer_id
                    ,dw_sales_rep_id
                    from Sales_Records as a


                    inner join (
                    SELECT 
                    a.dw_invoice_id
                    ,a.dw_customer_id
                    ,a.dw_sales_rep_id
                    ,b.first_name as Customer_First_Name
                    ,b.last_name as Customer_Last_Name
                    ,c.first_name as Sales_First_Name
                    ,c.last_name as Sales_Last_Name


                    FROM Customers_Salesreps as a

                    inner join Customers_Info as b
                    on a.dw_customer_id = b.dw_customer_id

                    inner join Sales_Reps as c
                    on a.dw_sales_rep_id = c.dw_sales_rep_id


                    where c.first_name like "%%{sfname}%%"
                    and c.last_name like "%%{slname}%%"
                    and b.first_name like "%%{cfname}%%"
                    and b.last_name like "%%{clname}%%"
    

                    ) as b
                    on a.dw_invoice_id = b.dw_invoice_id


                    inner join (
                    SELECT 
                    dw_vehicle_type_id
                    ,vehicle_type
                    ,vehicle_make
                    ,vehicle_model
                    ,vehicle_year
                    ,vehicle_color
                    ,vehicle_trim
                    ,vehicle_price
                    from Vehicle_Types 
                    where vehicle_make like "%%{make}%%"
                    and vehicle_model like "%%{model}%%"
                    and vehicle_year like "%%{year}%%"
                    and vehicle_color like "%%{color}%%"
                    and vehicle_trim like "%%{trim}%%"

                    ) as c
                    on a.dw_vehicle_type_id = c.dw_vehicle_type_id

                    left join Financial_Options as d
                    on a.dw_fincl_option_id = d.dw_fincl_option_id

                    where a.vin like "%%{vin}%%"


                    order by dw_invoice_id
                    limit {nth_record}, {row_per_page}
                    """

            results = execute_query(db, query)
            sales_list = [list(r) for r in results.fetchall()]
            print(sales_list)


            if session["sales_search"]["count"] > (nth_record + row_per_page):
                next_page = page + 1
            else:
                next_page = page

            if (nth_record - row_per_page) > 0:
                prev_page = page - 1
            else:
                prev_page = 1
            
            return render_template("modify_sales.html", content = sales_list, prev_page = prev_page, current_page = page, next_page = next_page, status_msg = "" ) 

        elif request.method == "POST" and request.form["request_type"] == "sales_add":
            db = connect_to_database()


            dw_customer_id = request.form["customerid"] 
            dw_sales_rep_id = request.form["salesid"] 
            vin = request.form["vin"]
            price = request.form["price"] 
            dw_fincl_option_id = request.form["financial_option"] 
            down_payment = request.form["down_payment"] 
            monthly_payment = request.form["monthly_payment"] 
            dw_vehicle_type_id = request.form["type"] 
            purchase_date = request.form["date"] 


            query = f"""
                    INSERT INTO Sales_Records (purchase_date, dw_vehicle_type_id, vin, vehicle_price, dw_fincl_option_id, monthly_payment_amount, down_payment_amount) VALUES ("{purchase_date}","{dw_vehicle_type_id}","{vin}","{price}","{dw_fincl_option_id}","{monthly_payment}","{down_payment}");
                    """
            print(query)

            results = execute_query(db, query)    


            query = f"""
                    UPDATE Vehicle_Inventories 
                    SET sold_ind = '1'
                    where vin = '{vin}'
                    """
            print(query)

            results = execute_query(db, query)     

            query = f"""
                    INSERT INTO Customers_Salesreps (dw_customer_id, dw_invoice_id, dw_sales_rep_id) VALUES ("{dw_customer_id}",(select dw_invoice_id from Sales_Records where vin = '{vin}'),"{dw_sales_rep_id}");
                    """
            print(query)

            results = execute_query(db, query)     


            if "sales_search" in session:
                make = session["sales_search"]["key"]["make"] 
                model = session["sales_search"]["key"]["model"]
                year = session["sales_search"]["key"]["year"]
                color = session["sales_search"]["key"]["color"] 
                trim = session["sales_search"]["key"]["trim"]
                vin = session["sales_search"]["key"]["vin"]
                clname = session["sales_search"]["key"]["customer_lname"] 
                cfname = session["sales_search"]["key"]["customer_fname"] 
                slname = session["sales_search"]["key"]["sales_lname"] 
                sfname = session["sales_search"]["key"]["sales_fname"] 

                page = int(request.form["page"])
                print(page)
                nth_record = (page-1) * row_per_page + 1

                query = f"""
                        select 
                        a.dw_invoice_id
                        ,a.vin
                        ,b.customer_first_name
                        ,b.customer_last_name
                        ,b.sales_first_name
                        ,b.sales_last_name
                        ,c.vehicle_type
                        ,c.vehicle_make
                        ,c.vehicle_model
                        ,c.vehicle_year
                        ,c.vehicle_color
                        ,c.vehicle_trim
                        ,c.vehicle_price
                        ,down_payment_amount
                        ,Monthly_Payment_amount
                        ,concat(int_rate, '/', num_of_payment) as payment_arrangement
                        ,dw_customer_id
                        ,dw_sales_rep_id
                        from Sales_Records as a


                        inner join (
                        SELECT 
                        a.dw_invoice_id
                        ,a.dw_customer_id
                        ,a.dw_sales_rep_id
                        ,b.first_name as Customer_First_Name
                        ,b.last_name as Customer_Last_Name
                        ,c.first_name as Sales_First_Name
                        ,c.last_name as Sales_Last_Name


                        FROM Customers_Salesreps as a

                        inner join Customers_Info as b
                        on a.dw_customer_id = b.dw_customer_id

                        inner join Sales_Reps as c
                        on a.dw_sales_rep_id = c.dw_sales_rep_id


                        where c.first_name like "%%{sfname}%%"
                        and c.last_name like "%%{slname}%%"
                        and b.first_name like "%%{cfname}%%"
                        and b.last_name like "%%{clname}%%"
        

                        ) as b
                        on a.dw_invoice_id = b.dw_invoice_id


                        inner join (
                        SELECT 
                        dw_vehicle_type_id
                        ,vehicle_type
                        ,vehicle_make
                        ,vehicle_model
                        ,vehicle_year
                        ,vehicle_color
                        ,vehicle_trim
                        ,vehicle_price
                        from Vehicle_Types 
                        where vehicle_make like "%%{make}%%"
                        and vehicle_model like "%%{model}%%"
                        and vehicle_year like "%%{year}%%"
                        and vehicle_color like "%%{color}%%"
                        and vehicle_trim like "%%{trim}%%"

                        ) as c
                        on a.dw_vehicle_type_id = c.dw_vehicle_type_id

                        left join Financial_Options as d
                        on a.dw_fincl_option_id = d.dw_fincl_option_id

                        where a.vin like "%%{vin}%%"


                        order by dw_invoice_id
                        limit {nth_record}, {row_per_page}
                        """

                results = execute_query(db, query)
                sales_list = [list(r) for r in results.fetchall()]
                print(sales_list)


                if session["sales_search"]["count"] > (nth_record + row_per_page):
                    next_page = page + 1
                else:
                    next_page = page

                if (nth_record - row_per_page) > 0:
                    prev_page = page - 1
                else:
                    prev_page = 1
                
                return render_template("modify_sales.html", content = sales_list, prev_page = prev_page, current_page = page, next_page = next_page, status_msg = "" ) 
            else:
                return render_template("modify_sales.html") 

        elif request.method  == "POST" and request.form["request_type"] == "sales_edit":
            db = connect_to_database()
            dw_invoice_id = request.form["dw_invoice_id"] 
            dw_customer_id = request.form["dw_customer_id"] 
            dw_sales_rep_id = request.form["dw_sales_rep_id"] 
            page = int(request.form["page"])

            print(dw_invoice_id, dw_customer_id, dw_sales_rep_id)


            query = f"""
            select dw_customer_id
            from Customers_Info
            where dw_customer_id = '{dw_customer_id}'
            """
            results = execute_query(db, query)

            customer_list = [list(r) for r in results.fetchall()]


            query = f"""
            select dw_sales_rep_id
            from Sales_Reps
            where dw_sales_rep_id = '{dw_sales_rep_id}'
            """
            results = execute_query(db, query)

            sales_list = [list(r) for r in results.fetchall()]

            if len(customer_list) > 0 and len(sales_list) > 0:
                query = f"""
                UPDATE  Customers_Salesreps
                SET dw_customer_id = '{dw_customer_id}', dw_sales_rep_id = '{dw_sales_rep_id}'
                where dw_invoice_id = '{dw_invoice_id}'
                """
                results = execute_query(db, query)
                status_msg = 'Update Successful'
            else:
                status_msg = 'Invalid Information'

            


            make = session["sales_search"]["key"]["make"] 
            model = session["sales_search"]["key"]["model"]
            year = session["sales_search"]["key"]["year"]
            color = session["sales_search"]["key"]["color"] 
            trim = session["sales_search"]["key"]["trim"]
            vin = session["sales_search"]["key"]["vin"]
            clname = session["sales_search"]["key"]["customer_lname"] 
            cfname = session["sales_search"]["key"]["customer_fname"] 
            slname = session["sales_search"]["key"]["sales_lname"] 
            sfname = session["sales_search"]["key"]["sales_fname"] 

            nth_record = (page-1) * row_per_page + 1

            query = f"""
                    select 
                    a.dw_invoice_id
                    ,a.vin
                    ,b.customer_first_name
                    ,b.customer_last_name
                    ,b.sales_first_name
                    ,b.sales_last_name
                    ,c.vehicle_type
                    ,c.vehicle_make
                    ,c.vehicle_model
                    ,c.vehicle_year
                    ,c.vehicle_color
                    ,c.vehicle_trim
                    ,c.vehicle_price
                    ,down_payment_amount
                    ,Monthly_Payment_amount
                    ,concat(int_rate, '/', num_of_payment) as payment_arrangement
                    ,dw_customer_id
                    ,dw_sales_rep_id
                    from Sales_Records as a


                    inner join (
                    SELECT 
                    a.dw_invoice_id
                    ,a.dw_customer_id
                    ,a.dw_sales_rep_id
                    ,b.first_name as Customer_First_Name
                    ,b.last_name as Customer_Last_Name
                    ,c.first_name as Sales_First_Name
                    ,c.last_name as Sales_Last_Name


                    FROM Customers_Salesreps as a

                    inner join Customers_Info as b
                    on a.dw_customer_id = b.dw_customer_id

                    inner join Sales_Reps as c
                    on a.dw_sales_rep_id = c.dw_sales_rep_id


                    where c.first_name like "%%{sfname}%%"
                    and c.last_name like "%%{slname}%%"
                    and b.first_name like "%%{cfname}%%"
                    and b.last_name like "%%{clname}%%"
    

                    ) as b
                    on a.dw_invoice_id = b.dw_invoice_id


                    inner join (
                    SELECT 
                    dw_vehicle_type_id
                    ,vehicle_type
                    ,vehicle_make
                    ,vehicle_model
                    ,vehicle_year
                    ,vehicle_color
                    ,vehicle_trim
                    ,vehicle_price
                    from Vehicle_Types 
                    where vehicle_make like "%%{make}%%"
                    and vehicle_model like "%%{model}%%"
                    and vehicle_year like "%%{year}%%"
                    and vehicle_color like "%%{color}%%"
                    and vehicle_trim like "%%{trim}%%"

                    ) as c
                    on a.dw_vehicle_type_id = c.dw_vehicle_type_id

                    left join Financial_Options as d
                    on a.dw_fincl_option_id = d.dw_fincl_option_id

                    where a.vin like "%%{vin}%%"


                    order by dw_invoice_id
                    limit {nth_record}, {row_per_page}
                    """

            results = execute_query(db, query)
            sales_list = [list(r) for r in results.fetchall()]
            print(sales_list)


            if session["sales_search"]["count"] > (nth_record + row_per_page):
                next_page = page + 1
            else:
                next_page = page

            if (nth_record - row_per_page) > 0:
                prev_page = page - 1
            else:
                prev_page = 1
            
            return render_template("modify_sales.html", content = sales_list, prev_page = prev_page, current_page = page, next_page = next_page, status_msg = status_msg) 

@app.route("/testdrive", methods = ["POST","GET"])
def test_drive():
    row_per_page = 15
    if request.is_json:
        return render_template("test_drive.html")

    else:

        if request.method  == "GET" and request.args.get('page') is None:
            return render_template("test_drive.html")

        elif request.method  == "POST"  and request.form["request_type"] == "test_drive_new_search":

            print("POST")
            db = connect_to_database()

            make = request.form["make"] 
            model = request.form["model"] 
            year = request.form["year"] 
            color = request.form["color"] 
            trim = request.form["trim"] 
            vin = request.form["vin"] 
            cfname = request.form["customer_fname"] 
            clname = request.form["customer_lname"] 


            print(request.form)

            query = f"""
                    SELECT 
                    Test_Drives.dw_test_drive_id, 
                    Test_Drives.vin, test_drive_date, 
                    check_out_time, return_time, 
                    Test_Drives.dw_customer_id, 
                    first_name, last_name, vehicle_type, vehicle_make, 
                    vehicle_model, vehicle_year, vehicle_color, vehicle_trim, 
                    vehicle_price
                    FROM Vehicle_Types JOIN Customers_Info JOIN Test_Drives JOIN Vehicle_Inventories
                    WHERE Test_Drives.dw_customer_id = Customers_Info.dw_customer_id 
                    AND Test_Drives.vin = Vehicle_Inventories.vin 
                    AND Vehicle_Inventories.dw_vehicle_type_id = Vehicle_Types.dw_vehicle_type_id 
                    AND vehicle_make like "%%{make}%%"
                    AND vehicle_model like "%%{model}%%"
                    AND vehicle_year like "%%{year}%%"
                    AND vehicle_color like "%%{color}%%"
                    AND vehicle_trim like "%%{trim}%%"
                    AND first_name like "%%{cfname}%%"
                    AND last_name like "%%{clname}%%"
                    AND Test_Drives.vin like "%%{vin}%%"
                    order by Test_Drives.vin
                    limit 15
                    """

            results = execute_query(db, query)
            test_drive_list = [list(r) for r in results.fetchall()]
            print(test_drive_list)




            query = f"""
                    SELECT
                    count(distinct Test_Drives.vin) as test_drive_count

                    FROM Vehicle_Types JOIN Customers_Info JOIN Test_Drives JOIN Vehicle_Inventories
                    WHERE Test_Drives.dw_customer_id = Customers_Info.dw_customer_id 
                    AND Test_Drives.vin = Vehicle_Inventories.vin 
                    AND Vehicle_Inventories.dw_vehicle_type_id = Vehicle_Types.dw_vehicle_type_id 
                    AND vehicle_make like "%%{make}%%"
                    AND vehicle_model like "%%{model}%%"
                    AND vehicle_year like "%%{year}%%"
                    AND vehicle_color like "%%{color}%%"
                    AND vehicle_trim like "%%{trim}%%"
                    AND first_name like "%%{cfname}%%"
                    AND last_name like "%%{clname}%%"
                    AND Test_Drives.vin like "%%{vin}%%"
                    order by Test_Drives.vin
                    limit 15
                    """

            results = execute_query(db, query)
            test_drive_count = [list(r) for r in results.fetchall()]
            print(test_drive_count)

            session["test_drive_search"] = {}
            session["test_drive_search"]["count"] = test_drive_count[0][0]
            session["test_drive_search"]["key"] = {}
            session["test_drive_search"]["key"]["make"] = make
            session["test_drive_search"]["key"]["model"] = model
            session["test_drive_search"]["key"]["year"] = year
            session["test_drive_search"]["key"]["color"] = color
            session["test_drive_search"]["key"]["trim"] = trim
            session["test_drive_search"]["key"]["vin"] = vin
            session["test_drive_search"]["key"]["customer_fname"] = cfname
            session["test_drive_search"]["key"]["customer_lname"] = clname


            if test_drive_count[0][0] > row_per_page:
                #next_url = url_for('vehicle_inventory', page=2)
                next_page = 2
            else:
                #next_url = url_for('vehicle_inventory', page=1)
                next_page = 1 

            print(next_page)
            #prev_url = url_for('vehicle_inventory', page=1)
            prev_page = 1


            return render_template("test_drive.html", content = test_drive_list, prev_page = prev_page, current_page = 1, next_page = next_page)


@app.route("/cfproject", methods = ["POST","GET"])
def cf_projection():


    if request.is_json:
        if request.method  == "POST" and request.json["request_type"] == "store_pull":
            
            db = connect_to_database()
            
            query = f"""
                    SELECT 
                    store_location
                    from Vehicle_Inventories
                    group by 1
                    """
            results = execute_query(db, query)
            store_list = [r[0] for r in results.fetchall()]

            print(store_list)

            return jsonify(store_list)

    else:
        if request.method == "GET":
            return render_template("cf_projection.html")
        elif request.method == "POST" and request.form["request_type"] == "report_pull":
             
            db = connect_to_database()

            report_start_date = request.form["report_start_date"] 
            report_end_date = request.form["report_end_date"] 
            store_location = request.form["store_location"] 


            query = f"""
                    select 
                    store_location
                    ,eom_dt
                    ,cast(sum(monthly_payment_amount) as decimal(15,2)) as monthly_revenue

                    from (
                    SELECT 
                    a.vin
                    ,store_location
                    ,num_of_payment
                    ,date_add(a.purchase_date , interval 1 month) as first_payment_month
                    ,date_add(a.purchase_date, interval (b.num_of_payment + 1) month) as final_payment_month
                    ,a.monthly_payment_amount
                    FROM Sales_Records as a

                    left join Financial_Options as b
                    on a.dw_fincl_option_id = b.dw_fincl_option_id
                        
                    inner join Vehicle_Inventories as c 
                    on a.vin = c.vin
                    and c.store_location = '{store_location}'

                    ) as a


                    inner join eom_dt as b 
                    on b.eom_dt between a.first_payment_month and a.final_payment_month
                    and b.eom_dt between '{report_start_date}' and '{report_end_date}'

                    group by 1,2
                        
                    """

            results = execute_query(db, query)
            report = [list(r) for r in results.fetchall()]
            print(report)   

            query = f"""
                    select 
                    store_location
                    ,vehicle_make
                    ,vehicle_model
                    , count(distinct vin) as num_of_vehicle
                    , sum(vehicle_price) as inventory_cost
                    from Vehicle_Inventories as a 

                    inner join Vehicle_Types as b 
                    on a.dw_vehicle_type_id = b.dw_vehicle_type_id


                    where a.store_location = '{store_location}'
                    and a.sold_ind = '0'

                    group by 1,2,3
                        
                    """

            results = execute_query(db, query)
            inventory = [list(r) for r in results.fetchall()]
            print(inventory)      

            return render_template("cf_projection.html", report = report, inventory = inventory)



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

