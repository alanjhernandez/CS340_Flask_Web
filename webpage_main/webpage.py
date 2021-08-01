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


@app.route("/monthly_payment", methods = ["POST","GET"])
def monthly_payment():

    row_per_page = 15
    
    if request.is_json:
        if request.method == "POST" and request.json["request_type"] == "monthly_payment_invoice_check":

            db = connect_to_database()
            dw_invoice_id = request.json["dw_invoice_id"] 

            query = f"""
                    SELECT 
                    a.vin
                    ,d.first_name
                    ,d.last_name
                    ,b.vehicle_make
                    ,b.vehicle_model
                    ,b.vehicle_year
                    ,a.monthly_payment_amount
                    ,e.current_balance
                    ,nth_payment
                    ,cast(DATE(payment_date) as varchar(10)) as payment_date
                    ,a.vin
                    ,int_rate
                    ,cast(DATE_ADD(DATE(payment_date), INTERVAL 1 MONTH) as varchar(10)) as next_payment_date
                    from Sales_Records as a 
                    left join Vehicle_Types as b 
                    on a.dw_vehicle_type_id = b.dw_vehicle_type_id 
                    left join Customers_Salesreps as c 
                    on a.dw_invoice_id = c.dw_invoice_id 
                    left join Customers_Info as d 
                    on c.dw_customer_id = d.dw_customer_id 
                    left join (
                    select dw_invoice_id
                    , min(current_balance) as current_balance
                    , max(nth_payment) as nth_payment
                    , max(payment_date) as payment_date
                    from Monthly_Payments
                    where dw_invoice_id = '{dw_invoice_id}'
                    group by 1
                    ) as e 
                    on a.dw_invoice_id = e.dw_invoice_id
                    left join Financial_Options as f
                    on a.dw_fincl_option_id = f.dw_fincl_option_id
                    where a.dw_invoice_id = '{dw_invoice_id}';
                    """
            results = execute_query(db, query)
            invoice_info = [list(r) for r in results.fetchall()]

            print(invoice_info)

         
            if len(invoice_info) > 0:
                return jsonify(invoice_info[0])
            else:
                return jsonify("-1")


        elif request.method  == "POST"  and request.json["request_type"] == "monthly_payment_delete":

            db = connect_to_database()

            row_per_page = 15

            dw_payment_id = request.json["dw_payment_id"]

            print(dw_payment_id)

            query = f"""
                    DELETE FROM Monthly_Payments where dw_payment_id = '{dw_payment_id}'

                    """

            results = execute_query(db, query)
            status_msg = 'Delete Successful.'

            dw_customer_id = session["payment_search"]["key"]["dw_customer_id"]
            dw_invoice_id = session["payment_search"]["key"]["dw_invoice_id"]
            first_name = session["payment_search"]["key"]["first_name"]
            last_name = session["payment_search"]["key"]["last_name"] 
            vin = session["payment_search"]["key"]["vin"]
            page = int(request.json["page"])
            print(page)
            nth_record = (page-1) * row_per_page 


            query = f"""
                    select 
                    a.dw_customer_id
                    ,dw_invoice_id
                    ,a.vin
                    ,dw_payment_id
                    ,payment_date
                    ,payment_amount
                    ,current_balance
                    ,first_name
                    ,last_name
                    ,customer_dob
                    ,address_1
                    ,address_2
                    ,zip_code
                    ,city
                    ,state
                    ,ssn
                    ,tel_number
                    ,d.dw_vehicle_type_id
                    ,vehicle_type
                    ,vehicle_make
                    ,vehicle_model
                    ,vehicle_year
                    ,vehicle_color
                    ,vehicle_trim
                    ,vehicle_price

                    from Monthly_Payments as a
                    
                    left JOIN Customers_Info as b
                    on a.dw_customer_id = b.dw_customer_id

                    left JOIN Vehicle_Inventories as c
                    on a.vin = c.vin

                    left join Vehicle_Types as d
                    on c.dw_vehicle_type_id = d.dw_vehicle_type_id

                    where a.dw_customer_id like "%%{dw_customer_id}%%"
                    and dw_invoice_id like "%%{dw_invoice_id}%%"
                    and first_name like "%%{first_name}%%"
                    and last_name like "%%{last_name}%%"
                    and a.vin like "%%{vin}%%"

                    limit {nth_record}, {row_per_page}
                    """

            results = execute_query(db, query)
            payment_info_list = [list(r) for r in results.fetchall()]

 
            if session["payment_search"]["count"]  > (nth_record + row_per_page):
                next_page = page + 1
            else:
                next_page = page

            if (nth_record - row_per_page) > 0:
                prev_page = page - 1
            else:
                prev_page = 1
            
            return render_template("monthly_payment.html", content = payment_info_list, prev_page = prev_page, current_page = page, next_page = next_page, status_msg = "" ) 


    else:
        if request.method == "GET":
            if "payment_search" in session:
                session.pop("payment_search")
            return render_template("monthly_payment.html" ) 

        elif request.method == "POST" and request.form["request_type"] == "monthly_payment_new_search":

            db = connect_to_database()

            dw_customer_id = request.form["dw_customer_id"] 
            dw_invoice_id = request.form["dw_invoice_id"] 
            first_name = request.form["first_name"] 
            last_name = request.form["last_name"] 
            vin = request.form["vin"] 



            
            query = f"""
                    select 
                    a.dw_customer_id
                    ,dw_invoice_id
                    ,a.vin
                    ,dw_payment_id
                    ,payment_date
                    ,payment_amount
                    ,current_balance
                    ,first_name
                    ,last_name
                    ,customer_dob
                    ,address_1
                    ,address_2
                    ,zip_code
                    ,city
                    ,state
                    ,ssn
                    ,tel_number
                    ,d.dw_vehicle_type_id
                    ,vehicle_type
                    ,vehicle_make
                    ,vehicle_model
                    ,vehicle_year
                    ,vehicle_color
                    ,vehicle_trim
                    ,vehicle_price

                    from Monthly_Payments as a
                    
                    left JOIN Customers_Info as b
                    on a.dw_customer_id = b.dw_customer_id

                    left JOIN Vehicle_Inventories as c
                    on a.vin = c.vin

                    left join Vehicle_Types as d
                    on c.dw_vehicle_type_id = d.dw_vehicle_type_id

                    where a.dw_customer_id like "%%{dw_customer_id}%%"
                    and dw_invoice_id like "%%{dw_invoice_id}%%"
                    and first_name like "%%{first_name}%%"
                    and last_name like "%%{last_name}%%"
                    and a.vin like "%%{vin}%%"
                    limit {row_per_page}
                    """

            results = execute_query(db, query)
            payment_info_list = [list(r) for r in results.fetchall()]


            query = f"""
                    SELECT count(*) as count
                    from Monthly_Payments as a
                    left JOIN Customers_Info as b
                    on a.dw_customer_id = b.dw_customer_id

                    where a.dw_customer_id like "%%{dw_customer_id}%%"
                    and dw_invoice_id like "%%{dw_invoice_id}%%"
                    and first_name like "%%{first_name}%%"
                    and last_name like "%%{last_name}%%"
                    and vin like "%%{vin}%%"
                    """

    
            results = execute_query(db, query)
            payment_count = [list(r) for r in results.fetchall()]
           

            session["payment_search"] = {}
            session["payment_search"]["count"] = payment_count[0][0]
            session["payment_search"]["key"] = {}
            session["payment_search"]["key"]["dw_customer_id"] = dw_customer_id
            session["payment_search"]["key"]["dw_invoice_id"] = dw_invoice_id
            session["payment_search"]["key"]["first_name"] = first_name
            session["payment_search"]["key"]["last_name"] = last_name
            session["payment_search"]["key"]["vin"] = vin
  

            if payment_count[0][0] > row_per_page:
                #next_url = url_for('vehicle_inventory', page=2)
                next_page = 2
            else:
                #next_url = url_for('vehicle_inventory', page=1)
                next_page = 1 

            print(next_page)
            #prev_url = url_for('vehicle_inventory', page=1)
            prev_page = 1

            print(prev_page, next_page)


            return render_template("monthly_payment.html", content = payment_info_list, prev_page = prev_page, current_page = 1, next_page = next_page)

        elif request.method  == "POST"  and request.form["request_type"] == "monthly_payment_continue_search":

            db = connect_to_database()

            row_per_page = 15


            dw_customer_id = session["payment_search"]["key"]["dw_customer_id"]
            dw_invoice_id = session["payment_search"]["key"]["dw_invoice_id"]
            first_name = session["payment_search"]["key"]["first_name"]
            last_name = session["payment_search"]["key"]["last_name"] 
            vin = session["payment_search"]["key"]["vin"]
            page = int(request.form["page"])
            print(page)
            nth_record = (page-1) * row_per_page 


            query = f"""
                    select 
                    a.dw_customer_id
                    ,dw_invoice_id
                    ,a.vin
                    ,dw_payment_id
                    ,payment_date
                    ,payment_amount
                    ,current_balance
                    ,first_name
                    ,last_name
                    ,customer_dob
                    ,address_1
                    ,address_2
                    ,zip_code
                    ,city
                    ,state
                    ,ssn
                    ,tel_number
                    ,d.dw_vehicle_type_id
                    ,vehicle_type
                    ,vehicle_make
                    ,vehicle_model
                    ,vehicle_year
                    ,vehicle_color
                    ,vehicle_trim
                    ,vehicle_price

                    from Monthly_Payments as a
                    
                    left JOIN Customers_Info as b
                    on a.dw_customer_id = b.dw_customer_id

                    left JOIN Vehicle_Inventories as c
                    on a.vin = c.vin

                    left join Vehicle_Types as d
                    on c.dw_vehicle_type_id = d.dw_vehicle_type_id

                    where a.dw_customer_id like "%%{dw_customer_id}%%"
                    and dw_invoice_id like "%%{dw_invoice_id}%%"
                    and first_name like "%%{first_name}%%"
                    and last_name like "%%{last_name}%%"
                    and a.vin like "%%{vin}%%"

                    limit {nth_record}, {row_per_page}
                    """

            results = execute_query(db, query)
            payment_info_list = [list(r) for r in results.fetchall()]

 
            if session["payment_search"]["count"]  > (nth_record + row_per_page):
                next_page = page + 1
            else:
                next_page = page

            if (nth_record - row_per_page) > 0:
                prev_page = page - 1
            else:
                prev_page = 1
            
            return render_template("monthly_payment.html", content = payment_info_list, prev_page = prev_page, current_page = page, next_page = next_page, status_msg = "" ) 


        elif request.method  == "POST"  and request.form["request_type"] == "monthly_payment_add":

            db = connect_to_database()

            row_per_page = 15

            print(request.form)
            dw_invoice_id = request.form["dw_invoice_id"]
            payment_date = request.form["payment_date"]
            payment_amount = float(request.form["monthly_payment_amount"])
            nth_payment = request.form["nth_payment"]
            
            current_balance = float(request.form["current_balance"])
            print(current_balance)
            vin = request.form["vin"]

            if current_balance < 0:
                payment_amount = payment_amount + current_balance
                current_balance = 0

            query = f"""
                    INSERT INTO Monthly_Payments (dw_invoice_id, payment_date, nth_payment, current_balance, vin, payment_amount, dw_customer_id) VALUES ('{dw_invoice_id}','{payment_date}','{nth_payment}','{current_balance}','{vin}','{payment_amount}',(select dw_customer_id from Customers_Salesreps where dw_invoice_id = '{dw_invoice_id}'))
                    """
            results = execute_query(db, query)
            status_msg = "Insert Successful. The payment is " + str(payment_amount)






            if "payment_search" in session:

                dw_customer_id = session["payment_search"]["key"]["dw_customer_id"]
                dw_invoice_id = session["payment_search"]["key"]["dw_invoice_id"]
                first_name = session["payment_search"]["key"]["first_name"]
                last_name = session["payment_search"]["key"]["last_name"] 
                vin = session["payment_search"]["key"]["vin"]
                page = int(request.form["page"])
                print(page)
                nth_record = (page-1) * row_per_page 


                query = f"""
                        select 
                        a.dw_customer_id
                        ,dw_invoice_id
                        ,a.vin
                        ,dw_payment_id
                        ,payment_date
                        ,payment_amount
                        ,current_balance
                        ,first_name
                        ,last_name
                        ,customer_dob
                        ,address_1
                        ,address_2
                        ,zip_code
                        ,city
                        ,state
                        ,ssn
                        ,tel_number
                        ,d.dw_vehicle_type_id
                        ,vehicle_type
                        ,vehicle_make
                        ,vehicle_model
                        ,vehicle_year
                        ,vehicle_color
                        ,vehicle_trim
                        ,vehicle_price

                        from Monthly_Payments as a
                        
                        left JOIN Customers_Info as b
                        on a.dw_customer_id = b.dw_customer_id

                        left JOIN Vehicle_Inventories as c
                        on a.vin = c.vin

                        left join Vehicle_Types as d
                        on c.dw_vehicle_type_id = d.dw_vehicle_type_id

                        where a.dw_customer_id like "%%{dw_customer_id}%%"
                        and dw_invoice_id like "%%{dw_invoice_id}%%"
                        and first_name like "%%{first_name}%%"
                        and last_name like "%%{last_name}%%"
                        and a.vin like "%%{vin}%%"

                        limit {nth_record}, {row_per_page}
                        """

                results = execute_query(db, query)
                payment_info_list = [list(r) for r in results.fetchall()]

        

                query = f"""
                        select count(*) as count

                        from Monthly_Payments as a
                        
                        left JOIN Customers_Info as b
                        on a.dw_customer_id = b.dw_customer_id

                        left JOIN Vehicle_Inventories as c
                        on a.vin = c.vin

                        left join Vehicle_Types as d
                        on c.dw_vehicle_type_id = d.dw_vehicle_type_id

                        where a.dw_customer_id like "%%{dw_customer_id}%%"
                        and dw_invoice_id like "%%{dw_invoice_id}%%"
                        and first_name like "%%{first_name}%%"
                        and last_name like "%%{last_name}%%"
                        and a.vin like "%%{vin}%%"

                        """

                results = execute_query(db, query)
                payment_count = [list(r) for r in results.fetchall()]

    
                if payment_count[0][0]  > (nth_record + row_per_page):
                    next_page = page + 1
                else:
                    next_page = page

                if (nth_record - row_per_page) > 0:
                    prev_page = page - 1
                else:
                    prev_page = 1
                
                return render_template("monthly_payment.html", content = payment_info_list, prev_page = prev_page, current_page = page, next_page = next_page, status_msg = status_msg ) 
            else:
                return render_template("monthly_payment.html", status_msg = status_msg)


        elif request.method  == "POST"  and request.form["request_type"] == "monthly_payment_update":

            db = connect_to_database()

            row_per_page = 15

            dw_invoice_id = request.form["dw_invoice_id"]
            vin = request.form["vin"]
            dw_payment_id = request.form["dw_payment_id"]
            payment_date = request.form["payment_date"]
            payment_amount = request.form["payment_amount"] 
            current_balance = request.form["current_balance"]
            


            query = f"""
                    Update Monthly_Payments
                    SET payment_date = '{payment_date}', payment_amount = '{payment_amount}', current_balance = '{current_balance}'
                    WHERE dw_payment_id = '{dw_payment_id}'
                     """
            results = execute_query(db, query)



            status_msg = "Update Successful."






            if "payment_search" in session:

                dw_customer_id = session["payment_search"]["key"]["dw_customer_id"]
                dw_invoice_id = session["payment_search"]["key"]["dw_invoice_id"]
                first_name = session["payment_search"]["key"]["first_name"]
                last_name = session["payment_search"]["key"]["last_name"] 
                vin = session["payment_search"]["key"]["vin"]
                page = int(request.form["page"])
                print(page)
                nth_record = (page-1) * row_per_page 


                query = f"""
                        select 
                        a.dw_customer_id
                        ,dw_invoice_id
                        ,a.vin
                        ,dw_payment_id
                        ,payment_date
                        ,payment_amount
                        ,current_balance
                        ,first_name
                        ,last_name
                        ,customer_dob
                        ,address_1
                        ,address_2
                        ,zip_code
                        ,city
                        ,state
                        ,ssn
                        ,tel_number
                        ,d.dw_vehicle_type_id
                        ,vehicle_type
                        ,vehicle_make
                        ,vehicle_model
                        ,vehicle_year
                        ,vehicle_color
                        ,vehicle_trim
                        ,vehicle_price

                        from Monthly_Payments as a
                        
                        left JOIN Customers_Info as b
                        on a.dw_customer_id = b.dw_customer_id

                        left JOIN Vehicle_Inventories as c
                        on a.vin = c.vin

                        left join Vehicle_Types as d
                        on c.dw_vehicle_type_id = d.dw_vehicle_type_id

                        where a.dw_customer_id like "%%{dw_customer_id}%%"
                        and dw_invoice_id like "%%{dw_invoice_id}%%"
                        and first_name like "%%{first_name}%%"
                        and last_name like "%%{last_name}%%"
                        and a.vin like "%%{vin}%%"

                        limit {nth_record}, {row_per_page}
                        """

                results = execute_query(db, query)
                payment_info_list = [list(r) for r in results.fetchall()]

    
                if session["payment_search"]["count"]  > (nth_record + row_per_page):
                    next_page = page + 1
                else:
                    next_page = page

                if (nth_record - row_per_page) > 0:
                    prev_page = page - 1
                else:
                    prev_page = 1
                
                return render_template("monthly_payment.html", content = payment_info_list, prev_page = prev_page, current_page = page, next_page = next_page, status_msg = status_msg ) 
            else:
                return render_template("monthly_payment.html", status_msg = status_msg)


@app.route("/customer", methods = ["POST","GET"])
def customer():
    row_per_page = 15
    
    if request.is_json:

        if request.method  == "POST"  and request.json["request_type"] == "customer_delete":

            db = connect_to_database()

            row_per_page = 15

            dw_customer_id = request.json["dw_customer_id"]

            query = f"""
                    DELETE from Customers_Info
                    where dw_customer_id = '{dw_customer_id}'
                    """

            results = execute_query(db, query)


            dw_customer_id = session["customer_search"]["key"]["dw_customer_id"]
            dob = session["customer_search"]["key"]["dob"] 
            customer_first_name = session["customer_search"]["key"]["customer_first_name"] 
            customer_last_name = session["customer_search"]["key"]["customer_last_name"] 
            address = session["customer_search"]["key"]["address"] 
            zip_code = session["customer_search"]["key"]["zip_code"] 
            city = session["customer_search"]["key"]["city"] 
            state = session["customer_search"]["key"]["state"] 
            phone = session["customer_search"]["key"]["phone"] 
            ssn = session["customer_search"]["key"]["ssn"] 
            session["customer_search"]["count"] -= 1

            page = int(request.json["page"])
            print(page)
            nth_record = (page-1) * row_per_page 


            query = f"""
                    SELECT 
                    dw_customer_id
                    ,first_name
                    ,last_name
                    ,customer_dob
                    ,address_1
                    ,address_2
                    ,zip_code
                    ,city
                    ,state
                    ,tel_number
                    ,ssn
                    from Customers_Info
                    where dw_customer_id like "%%{dw_customer_id}%%"
                    and first_name like "%%{customer_first_name}%%"
                    and last_name like "%%{customer_last_name}%%"
              
                    and (address_1 like "%%{address}%%" or  address_2 like "%%{address}%%")
                    and zip_code like "%%{zip_code}%%"
                    and state like "%%{state}%%"
                    and city like "%%{city}%%"
                    and tel_number like "%%{phone}%%"
                    and ssn like "%%{ssn}%%"
                    {dob}

                    limit {nth_record}, {row_per_page}
                    """

            results = execute_query(db, query)
            customer_info_list = [list(r) for r in results.fetchall()]

 
            if session["customer_search"]["count"]  > (nth_record + row_per_page):
                next_page = page + 1
            else:
                next_page = page

            if (nth_record - row_per_page) > 0:
                prev_page = page - 1
            else:
                prev_page = 1
            
            return render_template("customer.html", content = customer_info_list, prev_page = prev_page, current_page = page, next_page = next_page, status_msg = "Delete Successful." ) 


    else:
        if request.method == "GET":
            return render_template("customer.html")

        elif request.method == "POST" and request.form["request_type"] == "customer_new_search":

            db = connect_to_database()
            dw_customer_id = request.form["dw_customer_id"] 
            dob = request.form["dob"] 
            customer_first_name = request.form["customer_first_name"] 
            customer_last_name = request.form["customer_last_name"] 
            address = request.form["customer_address"] 
            zip_code = request.form["customer_zip"] 
            city = request.form["customer_city"] 
            state = request.form["customer_state"] 
            phone = request.form["customer_phone"] 
            ssn = request.form["customer_ssn"] 

            if dob != "":
                dob = f"and customer_dob = '{dob}'"
            


            
            query = f"""
                    SELECT 
                    dw_customer_id
                    ,first_name
                    ,last_name
                    ,customer_dob
                    ,address_1
                    ,address_2
                    ,zip_code
                    ,city
                    ,state
                    ,tel_number
                    ,ssn
                    from Customers_Info
                    where dw_customer_id like "%%{dw_customer_id}%%"
                    and first_name like "%%{customer_first_name}%%"
                    and last_name like "%%{customer_last_name}%%"
              
                    and (address_1 like "%%{address}%%" or  address_2 like "%%{address}%%")
                    and zip_code like "%%{zip_code}%%"
                    and state like "%%{state}%%"
                    and city like "%%{city}%%"
                    and tel_number like "%%{phone}%%"
                    and ssn like "%%{ssn}%%"
                    {dob}

                    limit {row_per_page}
                    """

            results = execute_query(db, query)
            customer_info_list = [list(r) for r in results.fetchall()]


            query = f"""
                    SELECT count(distinct dw_customer_id) as count
                    from Customers_Info
                    where dw_customer_id like "%%{dw_customer_id}%%"
                    and first_name like "%%{customer_first_name}%%"
                    and last_name like "%%{customer_last_name}%%"
           
                    and (address_1 like "%%{address}%%" or  address_2 like "%%{address}%%")
                    and zip_code like "%%{zip_code}%%"
                    and state like "%%{state}%%"
                    and city like "%%{city}%%"
                    and tel_number like "%%{phone}%%"
                    and ssn like "%%{ssn}%%"
                     {dob}
                    """

    
            results = execute_query(db, query)
            customer_count = [list(r) for r in results.fetchall()]
           

            session["customer_search"] = {}
            session["customer_search"]["count"] = customer_count[0][0]
            session["customer_search"]["key"] = {}
            session["customer_search"]["key"]["dw_customer_id"] = dw_customer_id
            session["customer_search"]["key"]["dob"] = dob
            session["customer_search"]["key"]["customer_first_name"] = customer_first_name
            session["customer_search"]["key"]["customer_last_name"] = customer_last_name
            session["customer_search"]["key"]["address"] = address
            session["customer_search"]["key"]["zip_code"] = zip_code
            session["customer_search"]["key"]["city"] = city
            session["customer_search"]["key"]["state"] = state
            session["customer_search"]["key"]["phone"] = phone
            session["customer_search"]["key"]["ssn"] = ssn

 

            if customer_count[0][0] > row_per_page:
                #next_url = url_for('vehicle_inventory', page=2)
                next_page = 2
            else:
                #next_url = url_for('vehicle_inventory', page=1)
                next_page = 1 

            print(next_page)
            #prev_url = url_for('vehicle_inventory', page=1)
            prev_page = 1

            print(prev_page, next_page)


            return render_template("customer.html", content = customer_info_list, prev_page = prev_page, current_page = 1, next_page = next_page)

        elif request.method  == "POST"  and request.form["request_type"] == "customer_continue_search":

            db = connect_to_database()

            row_per_page = 15


            dw_customer_id = session["customer_search"]["key"]["dw_customer_id"]
            dob = session["customer_search"]["key"]["dob"] 
            customer_first_name = session["customer_search"]["key"]["customer_first_name"] 
            customer_last_name = session["customer_search"]["key"]["customer_last_name"] 
            address = session["customer_search"]["key"]["address"] 
            zip_code = session["customer_search"]["key"]["zip_code"] 
            city = session["customer_search"]["key"]["city"] 
            state = session["customer_search"]["key"]["state"] 
            phone = session["customer_search"]["key"]["phone"] 
            ssn = session["customer_search"]["key"]["ssn"] 

            page = int(request.form["page"])
            print(page)
            nth_record = (page-1) * row_per_page 


            query = f"""
                    SELECT 
                    dw_customer_id
                    ,first_name
                    ,last_name
                    ,customer_dob
                    ,address_1
                    ,address_2
                    ,zip_code
                    ,city
                    ,state
                    ,tel_number
                    ,ssn
                    from Customers_Info
                    where dw_customer_id like "%%{dw_customer_id}%%"
                    and first_name like "%%{customer_first_name}%%"
                    and last_name like "%%{customer_last_name}%%"
              
                    and (address_1 like "%%{address}%%" or  address_2 like "%%{address}%%")
                    and zip_code like "%%{zip_code}%%"
                    and state like "%%{state}%%"
                    and city like "%%{city}%%"
                    and tel_number like "%%{phone}%%"
                    and ssn like "%%{ssn}%%"
                    {dob}

                    limit {nth_record}, {row_per_page}
                    """

            results = execute_query(db, query)
            customer_info_list = [list(r) for r in results.fetchall()]

 
            if session["customer_search"]["count"]  > (nth_record + row_per_page):
                next_page = page + 1
            else:
                next_page = page

            if (nth_record - row_per_page) > 0:
                prev_page = page - 1
            else:
                prev_page = 1
            
            return render_template("customer.html", content = customer_info_list, prev_page = prev_page, current_page = page, next_page = next_page, status_msg = "" ) 

        elif request.method  == "POST"  and request.form["request_type"] == "customer_update":

            db = connect_to_database()

            row_per_page = 15

            dw_customer_id = request.form["dw_customer_id"]
            dob = request.form["dob"] 
            first_name = request.form["customer_first_name"] 
            last_name = request.form["customer_last_name"] 
            address_1 = request.form["customer_address1"] 
            address_2 = request.form["customer_address2"] 
            zip_code = request.form["customer_zip"] 
            city = request.form["customer_city"] 
            state = request.form["customer_state"] 
            tel_number = request.form["customer_phone"] 
            ssn = request.form["customer_ssn"] 



            query = f"""
                    UPDATE Customers_Info
                    SET customer_dob = '{dob}', first_name= '{first_name}', last_name= '{last_name}', address_1= '{address_1}', address_2= '{address_2}', zip_code= '{zip_code}', state= '{state}', city= '{city}',tel_number= '{tel_number}',ssn= '{ssn}'
                    where dw_customer_id = '{dw_customer_id}'
                    """

            results = execute_query(db, query)


            dw_customer_id = session["customer_search"]["key"]["dw_customer_id"]
            dob = session["customer_search"]["key"]["dob"] 
            customer_first_name = session["customer_search"]["key"]["customer_first_name"] 
            customer_last_name = session["customer_search"]["key"]["customer_last_name"] 
            address = session["customer_search"]["key"]["address"] 
            zip_code = session["customer_search"]["key"]["zip_code"] 
            city = session["customer_search"]["key"]["city"] 
            state = session["customer_search"]["key"]["state"] 
            phone = session["customer_search"]["key"]["phone"] 
            ssn = session["customer_search"]["key"]["ssn"] 
            session["customer_search"]["count"] -= 1

            page = int(request.form["page"])
            print(page)
            nth_record = (page-1) * row_per_page 


            query = f"""
                    SELECT 
                    dw_customer_id
                    ,first_name
                    ,last_name
                    ,customer_dob
                    ,address_1
                    ,address_2
                    ,zip_code
                    ,city
                    ,state
                    ,tel_number
                    ,ssn
                    from Customers_Info
                    where dw_customer_id like "%%{dw_customer_id}%%"
                    and first_name like "%%{customer_first_name}%%"
                    and last_name like "%%{customer_last_name}%%"
              
                    and (address_1 like "%%{address}%%" or  address_2 like "%%{address}%%")
                    and zip_code like "%%{zip_code}%%"
                    and state like "%%{state}%%"
                    and city like "%%{city}%%"
                    and tel_number like "%%{phone}%%"
                    and ssn like "%%{ssn}%%"
                    {dob}

                    limit {nth_record}, {row_per_page}
                    """

            results = execute_query(db, query)
            customer_info_list = [list(r) for r in results.fetchall()]

 
            if session["customer_search"]["count"]  > (nth_record + row_per_page):
                next_page = page + 1
            else:
                next_page = page

            if (nth_record - row_per_page) > 0:
                prev_page = page - 1
            else:
                prev_page = 1
            
            return render_template("customer.html", content = customer_info_list, prev_page = prev_page, current_page = page, next_page = next_page, status_msg = "Update Successful." ) 
  
        elif request.method  == "POST"  and request.form["request_type"] == "customer_add":

            print(request.form)


            db = connect_to_database()


            dob = request.form["dob"] 
            first_name = request.form["customer_first_name"] 
            last_name = request.form["customer_last_name"] 
            address_1 = request.form["customer_address1"] 
            address_2 = request.form["customer_address2"] 
            zip_code = request.form["customer_zip"] 
            city = request.form["customer_city"] 
            state = request.form["customer_state"] 
            phone = request.form["customer_phone"] 
            ssn = request.form["customer_ssn"] 

            query = f"""
                    INSERT INTO Customers_Info (first_name, last_name, customer_dob, address_1, address_2, zip_code, state, city, tel_number, ssn) VALUES ('{first_name}','{last_name}','{dob}','{address_1}','{address_2}','{zip_code}','{state}','{city}','{phone}','{ssn}');
                    """

            results = execute_query(db, query)


            query = f"""
                    SELECT max(dw_customer_id)
                    from Customers_Info;
                    """

            results = execute_query(db, query)
            dw_customer_id = [r[0] for r in results.fetchall()]

            status_msg = "Insert Successful. Customer ID : " + str(dw_customer_id[0])
           


            if "customer_search" in session:

                dw_customer_id = session["customer_search"]["key"]["dw_customer_id"]
                dob = session["customer_search"]["key"]["dob"] 
                customer_first_name = session["customer_search"]["key"]["customer_first_name"] 
                customer_last_name = session["customer_search"]["key"]["customer_last_name"] 
                address = session["customer_search"]["key"]["address"] 
                zip_code = session["customer_search"]["key"]["zip_code"] 
                city = session["customer_search"]["key"]["city"] 
                state = session["customer_search"]["key"]["state"] 
                phone = session["customer_search"]["key"]["phone"] 
                ssn = session["customer_search"]["key"]["ssn"] 
                session["customer_search"]["count"] -= 1

                page = int(request.form["page"])
                print(page)
                nth_record = (page-1) * row_per_page 


                query = f"""
                        SELECT 
                        dw_customer_id
                        ,first_name
                        ,last_name
                        ,customer_dob
                        ,address_1
                        ,address_2
                        ,zip_code
                        ,city
                        ,state
                        ,tel_number
                        ,ssn
                        from Customers_Info
                        where dw_customer_id like "%%{dw_customer_id}%%"
                        and first_name like "%%{customer_first_name}%%"
                        and last_name like "%%{customer_last_name}%%"
                
                        and (address_1 like "%%{address}%%" or  address_2 like "%%{address}%%")
                        and zip_code like "%%{zip_code}%%"
                        and state like "%%{state}%%"
                        and city like "%%{city}%%"
                        and tel_number like "%%{phone}%%"
                        and ssn like "%%{ssn}%%"
                        {dob}

                        limit {nth_record}, {row_per_page}
                        """

                results = execute_query(db, query)
                customer_info_list = [list(r) for r in results.fetchall()]

    
                if session["customer_search"]["count"]  > (nth_record + row_per_page):
                    next_page = page + 1
                else:
                    next_page = page

                if (nth_record - row_per_page) > 0:
                    prev_page = page - 1
                else:
                    prev_page = 1
            
                return render_template("customer.html", content = customer_info_list, prev_page = prev_page, current_page = page, next_page = next_page, status_msg = status_msg ) 
            else:
                return render_template("customer.html", status_msg = status_msg )                


@app.route("/salesrep", methods = ["POST","GET"])
def sales():

    row_per_page = 15

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


        elif request.method  == "POST"  and request.json["request_type"] == "sales_delete":

            db = connect_to_database()

            row_per_page = 15

            dw_sales_rep_id = request.json["dw_sales_rep_id"]

            query = f"""
                    DELETE from Sales_Reps
                    where dw_sales_rep_id = '{dw_sales_rep_id}'
                    """

            results = execute_query(db, query)

            


            dw_sales_rep_id = session["sales_search"]["key"]["dw_sales_rep_id"] 
            sales_location = session["sales_search"]["key"]["sales_location"] 
            sales_first_name = session["sales_search"]["key"]["sales_first_name"] 
            sales_last_name = session["sales_search"]["key"]["sales_last_name"] 
            session["sales_search"]["count"] -= 1

            page = int(request.json["page"])
            print(page)
            nth_record = (page-1) * row_per_page 


            query = f"""
                    SELECT 
                    dw_sales_rep_id
                    ,first_name
                    ,last_name
                    ,primary_location
                    from Sales_Reps
                    where dw_sales_rep_id like "%%{dw_sales_rep_id}%%"
                    and first_name like "%%{sales_first_name}%%"
                    and last_name like "%%{sales_last_name}%%"
                    and primary_location like "%%{sales_location}%%"

                    limit {nth_record}, {row_per_page}
                    """

            results = execute_query(db, query)
            sales_info_list = [list(r) for r in results.fetchall()]

 
            if session["sales_search"]["count"]  > (nth_record + row_per_page):
                next_page = page + 1
            else:
                next_page = page

            if (nth_record - row_per_page) > 0:
                prev_page = page - 1
            else:
                prev_page = 1
            
            return render_template("salesrep.html", content = sales_info_list, prev_page = prev_page, current_page = page, next_page = next_page, status_msg =  "Delete Successful." ) 
            


    
    else:
        if request.method == "GET":
            return render_template("salesrep.html")

        elif request.method  == "POST" and request.form["request_type"] == "sales_new_search":

            db = connect_to_database()
            dw_sales_rep_id = request.form["dw_sales_rep_id"] 
            sales_location = request.form["store_location"] 
            sales_first_name = request.form["sales_first_name"] 
            sales_last_name = request.form["sales_last_name"] 
        


            
            query = f"""
                    SELECT 
                    dw_sales_rep_id
                    ,first_name
                    ,last_name
                    ,primary_location
                    from Sales_Reps
                    where dw_sales_rep_id like "%%{dw_sales_rep_id}%%"
                    and first_name like "%%{sales_first_name}%%"
                    and last_name like "%%{sales_last_name}%%"
                    and primary_location like "%%{sales_location}%%"
              
    
                    limit {row_per_page}
                    """

            results = execute_query(db, query)
            sales_info_list = [list(r) for r in results.fetchall()]


            query = f"""
                    SELECT count(distinct dw_sales_rep_id) as count
                    from Sales_Reps
                    where dw_sales_rep_id like "%%{dw_sales_rep_id}%%"
                    and first_name like "%%{sales_first_name}%%"
                    and last_name like "%%{sales_last_name}%%"
                    and primary_location like "%%{sales_location}%%"
                    """

    
            results = execute_query(db, query)
            sales_count = [list(r) for r in results.fetchall()]
           

            session["sales_search"] = {}
            session["sales_search"]["count"] = sales_count[0][0]
            session["sales_search"]["key"] = {}
            session["sales_search"]["key"]["dw_sales_rep_id"] = dw_sales_rep_id
            session["sales_search"]["key"]["sales_location"] = sales_location
            session["sales_search"]["key"]["sales_first_name"] = sales_first_name
            session["sales_search"]["key"]["sales_last_name"] = sales_last_name


 

            if sales_count[0][0] > row_per_page:
                #next_url = url_for('vehicle_inventory', page=2)
                next_page = 2
            else:
                #next_url = url_for('vehicle_inventory', page=1)
                next_page = 1 

            print(next_page)
            #prev_url = url_for('vehicle_inventory', page=1)
            prev_page = 1

            print(prev_page, next_page)


            return render_template("salesrep.html", content = sales_info_list, prev_page = prev_page, current_page = 1, next_page = next_page)

        elif request.method  == "POST"  and request.form["request_type"] == "sales_continue_search":

            db = connect_to_database()

            row_per_page = 15


            dw_sales_rep_id = session["sales_search"]["key"]["dw_sales_rep_id"] 
            sales_location = session["sales_search"]["key"]["sales_location"] 
            sales_first_name = session["sales_search"]["key"]["sales_first_name"] 
            sales_last_name = session["sales_search"]["key"]["sales_last_name"] 

            page = int(request.form["page"])
            print(page)
            nth_record = (page-1) * row_per_page 


            query = f"""
                    SELECT 
                    dw_sales_rep_id
                    ,first_name
                    ,last_name
                    ,primary_location
                    from Sales_Reps
                    where dw_sales_rep_id like "%%{dw_sales_rep_id}%%"
                    and first_name like "%%{sales_first_name}%%"
                    and last_name like "%%{sales_last_name}%%"
                    and primary_location like "%%{sales_location}%%"

                    limit {nth_record}, {row_per_page}
                    """

            results = execute_query(db, query)
            sales_info_list = [list(r) for r in results.fetchall()]

 
            if session["sales_search"]["count"]  > (nth_record + row_per_page):
                next_page = page + 1
            else:
                next_page = page

            if (nth_record - row_per_page) > 0:
                prev_page = page - 1
            else:
                prev_page = 1
            
            return render_template("salesrep.html", content = sales_info_list, prev_page = prev_page, current_page = page, next_page = next_page, status_msg = "" ) 

        elif request.method  == "POST"  and request.form["request_type"] == "sales_update":

            db = connect_to_database()

            row_per_page = 15

            dw_sales_rep_id = request.form["dw_sales_rep_id"]
            first_name = request.form["sales_first_name"]
            last_name = request.form["sales_last_name"]
            primary_location = request.form["store_location"]

            query = f"""
                    UPDATE Sales_Reps
                    SET first_name = '{first_name}', last_name = '{last_name}', primary_location = '{primary_location}'
                    where dw_sales_rep_id = '{dw_sales_rep_id}'
                    """

            results = execute_query(db, query)


            dw_sales_rep_id = session["sales_search"]["key"]["dw_sales_rep_id"] 
            sales_location = session["sales_search"]["key"]["sales_location"] 
            sales_first_name = session["sales_search"]["key"]["sales_first_name"] 
            sales_last_name = session["sales_search"]["key"]["sales_last_name"] 

            page = int(request.form["page"])
            print(page)
            nth_record = (page-1) * row_per_page 


            query = f"""
                    SELECT 
                    dw_sales_rep_id
                    ,first_name
                    ,last_name
                    ,primary_location
                    from Sales_Reps
                    where dw_sales_rep_id like "%%{dw_sales_rep_id}%%"
                    and first_name like "%%{sales_first_name}%%"
                    and last_name like "%%{sales_last_name}%%"
                    and primary_location like "%%{sales_location}%%"

                    limit {nth_record}, {row_per_page}
                    """

            results = execute_query(db, query)
            sales_info_list = [list(r) for r in results.fetchall()]

 
            if session["sales_search"]["count"]  > (nth_record + row_per_page):
                next_page = page + 1
            else:
                next_page = page

            if (nth_record - row_per_page) > 0:
                prev_page = page - 1
            else:
                prev_page = 1
            
            return render_template("salesrep.html", content = sales_info_list, prev_page = prev_page, current_page = page, next_page = next_page, status_msg =  "Update Successful." ) 
            
        elif request.method  == "POST"  and request.form["request_type"] == "sales_add":

            db = connect_to_database()

            row_per_page = 15

            first_name = request.form["sales_first_name"]
            last_name = request.form["sales_last_name"]
            primary_location = request.form["store_location"]

            query = f"""
                    INSERT INTO Sales_Reps (first_name, last_name, primary_location) VALUES ( '{first_name}', '{last_name}', '{primary_location}')
            
                    """

            results = execute_query(db, query)

            query = f"""
                    select max(dw_sales_rep_id) as dw_sales_rep_id
                    from Sales_Reps
                    """

            results = execute_query(db, query)

            dw_sales_rep_id = [r[0] for r in results.fetchall()]

            status_msg = 'Insert Successful. The Sales ID is ' + str(dw_sales_rep_id[0])
            
            if "sales_search" in session:

                dw_sales_rep_id = session["sales_search"]["key"]["dw_sales_rep_id"] 
                sales_location = session["sales_search"]["key"]["sales_location"] 
                sales_first_name = session["sales_search"]["key"]["sales_first_name"] 
                sales_last_name = session["sales_search"]["key"]["sales_last_name"] 

                ###########################################################################
                ##############################ADD +1 after INSERT##########################
                ###########################################################################

                page = int(request.form["page"])
                print(page)
                nth_record = (page-1) * row_per_page 


                query = f"""
                        SELECT 
                        dw_sales_rep_id
                        ,first_name
                        ,last_name
                        ,primary_location
                        from Sales_Reps
                        where dw_sales_rep_id like "%%{dw_sales_rep_id}%%"
                        and first_name like "%%{sales_first_name}%%"
                        and last_name like "%%{sales_last_name}%%"
                        and primary_location like "%%{sales_location}%%"

                        limit {nth_record}, {row_per_page}
                        """

                results = execute_query(db, query)
                sales_info_list = [list(r) for r in results.fetchall()]

    

    
                if session["sales_search"]["count"]  > (nth_record + row_per_page):
                    next_page = page + 1
                else:
                    next_page = page

                if (nth_record - row_per_page) > 0:
                    prev_page = page - 1
                else:
                    prev_page = 1
                
                return render_template("salesrep.html", content = sales_info_list, prev_page = prev_page, current_page = page, next_page = next_page, status_msg =  status_msg ) 
            else:
                return render_template("salesrep.html", status_msg =  status_msg ) 

@app.route("/vehicle_type", methods = ["POST","GET"])
def vehicle_type():
    row_per_page = 15

    

    if request.is_json:
        if request.method == "POST" and request.json["request_type"] == "vehicle_type_delete":

            db = connect_to_database()


            dw_vehicle_type_id = request.json["dw_vehicle_type_id"]
            page = int(request.json["page"])

            query = f"""
                    DELETE FROM Vehicle_Types
                    WHERE dw_vehicle_type_id = '{dw_vehicle_type_id}'
                    """ 

            results = execute_query(db, query)      
            status_msg = "Delete Successful."



            print(page)

            nth_record = (page-1) * row_per_page 


            session["vehicle_type_search"]["count"] -= 1
            vehicle_make = session["vehicle_type_search"]["key"]["vehicle_make"] 
            vehicle_model = session["vehicle_type_search"]["key"]["vehicle_model"] 
            vehicle_year = session["vehicle_type_search"]["key"]["vehicle_year"] 
            vehicle_color = session["vehicle_type_search"]["key"]["vehicle_color"] 
            vehicle_trim = session["vehicle_type_search"]["key"]["vehicle_trim"] 
            vehicle_type = session["vehicle_type_search"]["key"]["vehicle_type"] 
            dw_vehicle_type_id = session["vehicle_type_search"]["key"]["dw_vehicle_type_id"] 



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

                    where dw_vehicle_type_id like "%%{dw_vehicle_type_id}%%"
                    or vehicle_type like "%%{vehicle_type}%%"
                    or vehicle_make like "%%{vehicle_make}%%"
                    or vehicle_model like "%%{vehicle_model}%%"
                    or vehicle_year like "%%{vehicle_year}%%"
                    or vehicle_trim like "%%{vehicle_trim}%%"
                    or vehicle_color like "%%{vehicle_color}%%"

                    order by dw_vehicle_type_id
                    limit {nth_record}, {row_per_page}
                    """

            results = execute_query(db, query)
            vehicle_type_list = [list(r) for r in results.fetchall()]
            print(vehicle_type_list)


            if session["vehicle_type_search"]["count"] > (nth_record + row_per_page):
                next_page = page + 1
            else:
                next_page = page

            if (nth_record - row_per_page) > 0:
                prev_page = page - 1
            else:
                prev_page = 1

            
            return render_template("vehicle_type.html", content = vehicle_type_list, prev_page = prev_page, current_page = page, next_page = next_page, status_msg = status_msg )




    else:

        if request.method == "GET":
            return render_template("vehicle_type.html")

        
        elif request.method == "POST" and request.form['request_type'] == "vehicle_type_new_search":

            db = connect_to_database()

            vehicle_make = request.form["vehicle_make"] 
            vehicle_model = request.form["vehicle_model"] 
            vehicle_year = request.form["vehicle_year"] 
            vehicle_color = request.form["vehicle_color"] 
            vehicle_trim = request.form["vehicle_trim"] 
            vehicle_type = request.form["vehicle_type"] 
            dw_vehicle_type_id = request.form["dw_vehicle_type_id"] 
           

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

                    where dw_vehicle_type_id like "%%{dw_vehicle_type_id}%%"
                    or vehicle_type like "%%{vehicle_type}%%"
                    or vehicle_make like "%%{vehicle_make}%%"
                    or vehicle_model like "%%{vehicle_model}%%"
                    or vehicle_year like "%%{vehicle_year}%%"
                    or vehicle_trim like "%%{vehicle_trim}%%"
                    or vehicle_color like "%%{vehicle_color}%%"

                    order by dw_vehicle_type_id
                    limit {row_per_page}
                    """

            results = execute_query(db, query)
            vehicle_type_list = [list(r) for r in results.fetchall()]


            query = f"""
                    select count(*) as cnt

                    from Vehicle_Types

                    where dw_vehicle_type_id like "%%{dw_vehicle_type_id}%%"
                    or vehicle_type like "%%{vehicle_type}%%"
                    or vehicle_make like "%%{vehicle_make}%%"
                    or vehicle_model like "%%{vehicle_model}%%"
                    or vehicle_year like "%%{vehicle_year}%%"
                    or vehicle_trim like "%%{vehicle_trim}%%"
                    or vehicle_color like "%%{vehicle_color}%%"


                    """

            results = execute_query(db, query)
            vehicle_type_count = [list(r) for r in results.fetchall()]
            

            session["vehicle_type_search"] = {}
            session["vehicle_type_search"]["count"] = vehicle_type_count[0][0]
            session["vehicle_type_search"]["key"] = {}
            session["vehicle_type_search"]["key"]["vehicle_make"] = vehicle_make
            session["vehicle_type_search"]["key"]["vehicle_model"] = vehicle_model
            session["vehicle_type_search"]["key"]["vehicle_year"] = vehicle_year
            session["vehicle_type_search"]["key"]["vehicle_color"] = vehicle_color
            session["vehicle_type_search"]["key"]["vehicle_trim"] = vehicle_trim
            session["vehicle_type_search"]["key"]["vehicle_type"] = vehicle_type
            session["vehicle_type_search"]["key"]["dw_vehicle_type_id"] = dw_vehicle_type_id



 
            if vehicle_type_count[0][0] > row_per_page:
                next_page = 2
            else:
                next_page = 1 

            print(next_page)
            prev_page = 1


            return render_template("vehicle_type.html", content = vehicle_type_list, prev_page = prev_page, current_page = 1, next_page = next_page)

        elif request.method == "POST" and request.form['request_type'] == "vehicle_type_continue_search":

            db = connect_to_database()

            row_per_page = 15

            vehicle_make = session["vehicle_type_search"]["key"]["vehicle_make"] 
            vehicle_model = session["vehicle_type_search"]["key"]["vehicle_model"] 
            vehicle_year = session["vehicle_type_search"]["key"]["vehicle_year"] 
            vehicle_color = session["vehicle_type_search"]["key"]["vehicle_color"] 
            vehicle_trim = session["vehicle_type_search"]["key"]["vehicle_trim"] 
            vehicle_type = session["vehicle_type_search"]["key"]["vehicle_type"] 
            dw_vehicle_type_id = session["vehicle_type_search"]["key"]["dw_vehicle_type_id"] 

            page = int(request.form["page"])
            print(page)

            nth_record = (page-1) * row_per_page 

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

                    where dw_vehicle_type_id like "%%{dw_vehicle_type_id}%%"
                    or vehicle_type like "%%{vehicle_type}%%"
                    or vehicle_make like "%%{vehicle_make}%%"
                    or vehicle_model like "%%{vehicle_model}%%"
                    or vehicle_year like "%%{vehicle_year}%%"
                    or vehicle_trim like "%%{vehicle_trim}%%"
                    or vehicle_color like "%%{vehicle_color}%%"

                    order by dw_vehicle_type_id
                    limit {nth_record}, {row_per_page}
                    """

            results = execute_query(db, query)
            vehicle_type_list = [list(r) for r in results.fetchall()]
            print(vehicle_type_list)


            if session["vehicle_type_search"]["count"] > (nth_record + row_per_page):
                next_page = page + 1
            else:
                next_page = page

            if (nth_record - row_per_page) > 0:
                prev_page = page - 1
            else:
                prev_page = 1
            
            return render_template("vehicle_type.html", content = vehicle_type_list, prev_page = prev_page, current_page = page, next_page = next_page, status_msg = "" ) 



        elif request.method == "POST" and request.form['request_type'] == "vehicle_type_add":

            db = connect_to_database()

            row_per_page = 15

            vehicle_make = request.form["vehicle_make"].upper()
            vehicle_model = request.form["vehicle_model"].upper()
            vehicle_year = request.form["vehicle_year"] 
            vehicle_color = request.form["vehicle_color"].upper() 
            vehicle_trim = request.form["vehicle_trim"].upper() 
            vehicle_type = request.form["vehicle_type"].upper() 
            vehicle_price = request.form["vehicle_price"] 
            dw_vehicle_type_id = request.form["dw_vehicle_type_id"].upper()

            page = int(request.form["page"])
            print(page)

            query = f"""
                    select *
                    from Vehicle_Types
                    where dw_vehicle_type_id = "{dw_vehicle_type_id}"
                    """

            results = execute_query(db, query)
            vehicle_type_id_exist_list = [list(r) for r in results.fetchall()]

            if len(vehicle_type_id_exist_list) > 0:
                status_msg = 'Insert Failed. Vehicle Type ID exists.'
            else:

                query = f"""
                        INSERT INTO Vehicle_Types (dw_vehicle_type_id, vehicle_type, vehicle_make, vehicle_model, vehicle_year, vehicle_color, vehicle_trim, vehicle_price) VALUES('{dw_vehicle_type_id}','{vehicle_type}','{vehicle_make}','{vehicle_model}','{vehicle_year}','{vehicle_color}','{vehicle_trim}','{vehicle_price}')
                        """

                results = execute_query(db, query)
                status_msg = 'Insert Successful'

            if "vehicle_type_search" in session:
                page = int(request.form["page"])
                print(page)

                nth_record = (page-1) * row_per_page 


                session["vehicle_type_search"]["count"] += 1
                vehicle_make = session["vehicle_type_search"]["key"]["vehicle_make"] 
                vehicle_model = session["vehicle_type_search"]["key"]["vehicle_model"] 
                vehicle_year = session["vehicle_type_search"]["key"]["vehicle_year"] 
                vehicle_color = session["vehicle_type_search"]["key"]["vehicle_color"] 
                vehicle_trim = session["vehicle_type_search"]["key"]["vehicle_trim"] 
                vehicle_type = session["vehicle_type_search"]["key"]["vehicle_type"] 
                dw_vehicle_type_id = session["vehicle_type_search"]["key"]["dw_vehicle_type_id"] 


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

                        where dw_vehicle_type_id like "%%{dw_vehicle_type_id}%%"
                        or vehicle_type like "%%{vehicle_type}%%"
                        or vehicle_make like "%%{vehicle_make}%%"
                        or vehicle_model like "%%{vehicle_model}%%"
                        or vehicle_year like "%%{vehicle_year}%%"
                        or vehicle_trim like "%%{vehicle_trim}%%"
                        or vehicle_color like "%%{vehicle_color}%%"

                        order by dw_vehicle_type_id
                        limit {nth_record}, {row_per_page}
                        """

                results = execute_query(db, query)
                vehicle_type_list = [list(r) for r in results.fetchall()]
                print(vehicle_type_list)


                if session["vehicle_type_search"]["count"] > (nth_record + row_per_page):
                    next_page = page + 1
                else:
                    next_page = page

                if (nth_record - row_per_page) > 0:
                    prev_page = page - 1
                else:
                    prev_page = 1

                
                
                return render_template("vehicle_type.html", content = vehicle_type_list, prev_page = prev_page, current_page = page, next_page = next_page, status_msg = status_msg )

            else:
                return render_template("vehicle_type.html", status_msg = status_msg )


        elif request.method == "POST" and request.form['request_type'] == "vehicle_type_update":

            db = connect_to_database()

            row_per_page = 15

            vehicle_make = request.form["vehicle_make"].upper()
            vehicle_model = request.form["vehicle_model"].upper()
            vehicle_year = request.form["vehicle_year"] 
            vehicle_color = request.form["vehicle_color"].upper() 
            vehicle_trim = request.form["vehicle_trim"].upper() 
            vehicle_type = request.form["vehicle_type"].upper() 
            vehicle_price = request.form["vehicle_price"] 
            dw_vehicle_type_id = request.form["dw_vehicle_type_id"].upper()
            dw_vehicle_type_id_old = request.form["old_vehicle_type_id"].upper()

            if dw_vehicle_type_id_old == dw_vehicle_type_id:
                query = f"""
                        UPDATE Vehicle_Types
                        SET dw_vehicle_type_id = '{dw_vehicle_type_id}', vehicle_make  = '{vehicle_make}', vehicle_model  = '{vehicle_model}', vehicle_year  = '{vehicle_year}', vehicle_color  = '{vehicle_color}', vehicle_trim  = '{vehicle_trim}', vehicle_type  = '{vehicle_type}', vehicle_price  = '{vehicle_price}'
                        where dw_vehicle_type_id = '{dw_vehicle_type_id_old}'
                        """
                results = execute_query(db, query)

                status_msg = 'Update Successful.'
            
            else:
                query = f"""
                        select count(*) as count from Vehicle_Types where dw_vehicle_type_id = '{dw_vehicle_type_id}'
                        """
                results = execute_query(db, query)
                vehicle_type_id_exist_list = [list(r) for r in results.fetchall()]

                if vehicle_type_id_exist_list[0][0]> 0:
                    status_msg = 'Update Failed. Vehicle Type ID Exists.'

                else:
                    query = f"""
                            UPDATE Vehicle_Types
                            SET dw_vehicle_type_id = '{dw_vehicle_type_id}', vehicle_make  = '{vehicle_make}', vehicle_model  = '{vehicle_model}', vehicle_year  = '{vehicle_year}', vehicle_color  = '{vehicle_color}', vehicle_trim  = '{vehicle_trim}', vehicle_type  = '{vehicle_type}', vehicle_price  = '{vehicle_price}'
                            where dw_vehicle_type_id = '{dw_vehicle_type_id_old}'
                            """
                    results = execute_query(db, query)
                    status_msg = 'Update Successful.'


            page = int(request.form["page"])
            print(page)

            nth_record = (page-1) * row_per_page 


            session["vehicle_type_search"]["count"] += 1
            vehicle_make = session["vehicle_type_search"]["key"]["vehicle_make"] 
            vehicle_model = session["vehicle_type_search"]["key"]["vehicle_model"] 
            vehicle_year = session["vehicle_type_search"]["key"]["vehicle_year"] 
            vehicle_color = session["vehicle_type_search"]["key"]["vehicle_color"] 
            vehicle_trim = session["vehicle_type_search"]["key"]["vehicle_trim"] 
            vehicle_type = session["vehicle_type_search"]["key"]["vehicle_type"] 
            dw_vehicle_type_id = session["vehicle_type_search"]["key"]["dw_vehicle_type_id"] 

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

                    where dw_vehicle_type_id like "%%{dw_vehicle_type_id}%%"
                    or vehicle_type like "%%{vehicle_type}%%"
                    or vehicle_make like "%%{vehicle_make}%%"
                    or vehicle_model like "%%{vehicle_model}%%"
                    or vehicle_year like "%%{vehicle_year}%%"
                    or vehicle_trim like "%%{vehicle_trim}%%"
                    or vehicle_color like "%%{vehicle_color}%%"

                    order by dw_vehicle_type_id
                    limit {nth_record}, {row_per_page}
                    """

            results = execute_query(db, query)
            vehicle_type_list = [list(r) for r in results.fetchall()]
            print(vehicle_type_list)


            if session["vehicle_type_search"]["count"] > (nth_record + row_per_page):
                next_page = page + 1
            else:
                next_page = page

            if (nth_record - row_per_page) > 0:
                prev_page = page - 1
            else:
                prev_page = 1

            
            
            return render_template("vehicle_type.html", content = vehicle_type_list, prev_page = prev_page, current_page = page, next_page = next_page, status_msg = status_msg )













@app.route("/financial_arrangement", methods = ["POST","GET"])
def financial_arrangement():
    row_per_page = 15

    if request.is_json:
        if request.method == "POST" and request.json["request_type"] == "fincl_option_delete":
            db = connect_to_database()

            dw_fincl_option_id = request.json["dw_fincl_option_id"]

            query = f"""
                    DELETE from Financial_Options where dw_fincl_option_id = '{dw_fincl_option_id}';
                    """
            results = execute_query(db, query)

            query = f"""
                    SELECT 
                    dw_fincl_option_id
                    ,int_rate
                    ,num_of_payment
                    from Financial_Options
                    
                    limit {row_per_page}
                    """

            results = execute_query(db, query)
            fincl_arrangement_list = [list(r) for r in results.fetchall()]


            query = f"""
                    SELECT count(*) as count
                    from Financial_Options
                    """

            results = execute_query(db, query)
            fincl_arrangement_count = [list(r) for r in results.fetchall()]

            session["fincl_option_read"] = {}
            session["fincl_option_read"]["count"] = fincl_arrangement_count[0][0]          

            if session["fincl_option_read"]["count"] > row_per_page:
                next_page = 2
            else:
                next_page = 1 

            prev_page = 1

            return render_template("financial_arrangement.html", content = fincl_arrangement_list, prev_page = prev_page, current_page = 1, next_page = next_page, status_msg = "Delete Successful.") 


        
    else:
        if request.method == "GET":

            db = connect_to_database()

            query = f"""
                    SELECT 
                    dw_fincl_option_id
                    ,int_rate
                    ,num_of_payment
                    from Financial_Options
                    
                    limit {row_per_page}
                    """

            results = execute_query(db, query)
            fincl_arrangement_list = [list(r) for r in results.fetchall()]


            query = f"""
                    SELECT count(*) as count
                    from Financial_Options
                    """

            results = execute_query(db, query)
            fincl_arrangement_count = [list(r) for r in results.fetchall()]

            session["fincl_option_read"] = {}
            session["fincl_option_read"]["count"] = fincl_arrangement_count[0][0]          

            if session["fincl_option_read"]["count"] > row_per_page:
                next_page = 2
            else:
                next_page = 1 

            prev_page = 1

            return render_template("financial_arrangement.html", content = fincl_arrangement_list, prev_page = prev_page, current_page = 1, next_page = next_page) 

        elif request.method == "POST" and request.form["request_type"] == "fincl_continue_read":

            db = connect_to_database()

            page = int(request.form["page"])
            print(page)
            nth_record = (page-1) * row_per_page 

            query = f"""
                    SELECT 
                    dw_fincl_option_id
                    ,int_rate
                    ,num_of_payment
                    from Financial_Options
                    
                    limit {nth_record}, {row_per_page}
                    """

            results = execute_query(db, query)
            fincl_arrangement_list = [list(r) for r in results.fetchall()]

            if session["fincl_option_read"]["count"]  > (nth_record + row_per_page):
                next_page = page + 1
            else:
                next_page = page

            if (nth_record - row_per_page) > 0:
                prev_page = page - 1
            else:
                prev_page = 1

            return render_template("financial_arrangement.html", content = fincl_arrangement_list, prev_page = prev_page, current_page = 1, next_page = next_page) 


        elif request.method == "POST" and request.form["request_type"] == "fincl_add":

            db = connect_to_database()

            int_rate = request.form["fincl_int_rate"]
            num_of_payment = request.form["fincl_num_of_payment"]

            query = f"""
                    INSERT INTO Financial_Options (int_rate, num_of_payment) VALUES ('{int_rate}','{num_of_payment}');
                    """

            results = execute_query(db, query)

            query = f"""
                    SELECT 
                    dw_fincl_option_id
                    ,int_rate
                    ,num_of_payment
                    from Financial_Options
                    
                    limit {row_per_page}
                    """

            results = execute_query(db, query)
            fincl_arrangement_list = [list(r) for r in results.fetchall()]


            query = f"""
                    SELECT count(*) as count
                    from Financial_Options
                    """

            results = execute_query(db, query)
            fincl_arrangement_count = [list(r) for r in results.fetchall()]

            session["fincl_option_read"] = {}
            session["fincl_option_read"]["count"] = fincl_arrangement_count[0][0]          

            if session["fincl_option_read"]["count"] > row_per_page:
                next_page = 2
            else:
                next_page = 1 

            prev_page = 1

            return render_template("financial_arrangement.html", content = fincl_arrangement_list, prev_page = prev_page, current_page = 1, next_page = next_page, status_msg = "Insert Successful.") 

        elif request.method == "POST" and request.form["request_type"] == "fincl_edit":

            db = connect_to_database()

            int_rate = request.form["int_rate"]
            num_of_payment = request.form["num_of_payment"]
            dw_fincl_option_id = request.form["dw_fincl_option_id"]

            query = f"""
                    UPDATE Financial_Options
                    SET int_rate = '{int_rate}', num_of_payment = '{num_of_payment}'
                    where dw_fincl_option_id = '{dw_fincl_option_id}'
                    """

            results = execute_query(db, query)

            query = f"""
                    SELECT 
                    dw_fincl_option_id
                    ,int_rate
                    ,num_of_payment
                    from Financial_Options
                    
                    limit {row_per_page}
                    """

            results = execute_query(db, query)
            fincl_arrangement_list = [list(r) for r in results.fetchall()]


            query = f"""
                    SELECT count(*) as count
                    from Financial_Options
                    """

            results = execute_query(db, query)
            fincl_arrangement_count = [list(r) for r in results.fetchall()]

            session["fincl_option_read"] = {}
            session["fincl_option_read"]["count"] = fincl_arrangement_count[0][0]          

            if session["fincl_option_read"]["count"] > row_per_page:
                next_page = 2
            else:
                next_page = 1 

            prev_page = 1

            return render_template("financial_arrangement.html", content = fincl_arrangement_list, prev_page = prev_page, current_page = 1, next_page = next_page, status_msg = "Update Successful.") 




@app.route("/vehinventory", methods = ["POST","GET"])
def vehicle_inventory():
    row_per_page = 15



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
                    limit {row_per_page}
                    ;
                    """

            results = execute_query(db, query, vehicle_type_id_list)
            inventory_result = [ list(r) for r in results.fetchall()]

            query = f"""
                    SELECT count(distinct vin) as count
                    from Vehicle_Inventories as a

                    inner join Vehicle_Types as b
                    on a.dw_vehicle_type_id = b.dw_vehicle_type_id


                    where b.dw_vehicle_type_id IN ({fstring_sub})
                    and a.sold_ind = '0';
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
            nth_record = (page-1) * row_per_page 

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
                    limit {row_per_page}
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
            nth_record = (page-1) * row_per_page 

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
                nth_record = (page-1) * row_per_page 

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

            nth_record = (page-1) * row_per_page 

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

            if "test_drive_search" in session:
                session.pop("test_drive_search")

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
                    limit {row_per_page}
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

        elif request.method  == "POST"  and request.form["request_type"] == "test_drive_continue_search":

            db = connect_to_database()

            row_per_page = 15


            make = session["test_drive_search"]["key"]["make"]
            model = session["test_drive_search"]["key"]["model"] 
            year = session["test_drive_search"]["key"]["year"] 
            color = session["test_drive_search"]["key"]["color"] 
            trim = session["test_drive_search"]["key"]["trim"] 
            vin = session["test_drive_search"]["key"]["vin"] 
            cfname = session["test_drive_search"]["key"]["customer_fname"] 
            clname = session["test_drive_search"]["key"]["customer_lname"] 
            page = int(request.form["page"])
            print(page)
            nth_record = (page-1) * row_per_page 


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
                    limit {nth_record}, {row_per_page}
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
                    
                    """

            results = execute_query(db, query)
            test_drive_count = [list(r) for r in results.fetchall()]
            print(test_drive_count)

            session["test_drive_search"]["count"] = test_drive_count[0][0]


            if session["test_drive_search"]["count"]  > (nth_record + row_per_page):
                next_page = page + 1
            else:
                next_page = page

            if (nth_record - row_per_page) > 0:
                prev_page = page - 1
            else:
                prev_page = 1
            
            return render_template("test_drive.html", content = test_drive_list, prev_page = prev_page, current_page = page, next_page = next_page, status_msg = "" ) 


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


                    inner join Projection_Months as b 
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

