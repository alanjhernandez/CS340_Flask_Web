--Customer Tab



--READ
--New Search from User based on user input in the serach form
--:dob is either a where clause (e.g. where customer_dob = '1994-05-01') or a empty variable depends on if the user enters a input for dob or not

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
where dw_customer_id like "%:dw_customer_id%"
and first_name like "%:customer_first_name%"
and last_name like "%:customer_last_name%"
and (address_1 like "%:address%" or  address_2 like "%:address%")
and zip_code like "%:zip_code%"
and state like "%:state%"
and city like "%:city%"
and tel_number like "%:phone%"
and ssn like "%:ssn%"
:dob
order by 1
limit :row_per_page;





-- Count the number of result returned from search, it will be stored in session for pagination purpose
SELECT count(distinct dw_customer_id) as count
from Customers_Info
where dw_customer_id like "%:dw_customer_id%"
and first_name like "%:customer_first_name%"
and last_name like "%:customer_last_name%"
and (address_1 like "%:address%" or  address_2 like "%:address%")
and zip_code like "%:zip_code%"
and state like "%:state%"
and city like "%:city%"
and tel_number like "%:phone%"
and ssn like "%:ssn%"
:dob;




--if user press next or previous page after a search, the following query will be used for pagination. nth_record refers to the starting record for each page
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
where dw_customer_id like "%:dw_customer_id%"
and first_name like "%:customer_first_name%"
and last_name like "%:customer_last_name%"
and (address_1 like "%:address%" or  address_2 like "%:address%")
and zip_code like "%:zip_code%"
and state like "%:state%"
and city like "%:city%"
and tel_number like "%:phone%"
and ssn like "%:ssn%"
:dob
order by 1
limit :nth_record, :row_per_page;




--Update for Customers_info based on users' input
UPDATE Customers_Info
SET customer_dob = ':dob', first_name= ':first_name', last_name= ':last_name', address_1= ':address_1', address_2= ':address_2', zip_code= ':zip_code', state= ':state', city= ':city',tel_number= ':tel_number',ssn= ':ssn'
where dw_customer_id = ':dw_customer_id';



--Add a new Customer
INSERT INTO Customers_Info (first_name, last_name, customer_dob, address_1, address_2, zip_code, state, city, tel_number, ssn) VALUES (':first_name',':last_name',':dob',':address_1',':address_2',':zip_code',':state',':city',':phone',':ssn');


--Delete a customer
DELETE from Customers_Info where dw_customer_id = ':dw_customer_id';









--Sales Tab


--New Search from User based on user input in the serach form
SELECT 
dw_sales_rep_id
,first_name
,last_name
,primary_location
from Sales_Reps
where dw_sales_rep_id like "%:dw_sales_rep_id%"
and first_name like "%:sales_first_name%"
and last_name like "%:sales_last_name%"
and primary_location like "%:sales_location%"
limit :row_per_page;




-- Count the number of result returned from search, it will be stored in session for pagination purpose
SELECT count(distinct dw_sales_rep_id) as count
from Sales_Reps
where dw_sales_rep_id like "%:dw_sales_rep_id%"
and first_name like "%:sales_first_name%"
and last_name like "%:sales_last_name%"
and primary_location like "%:sales_location%";



--if user press next or previous page after a search, the following query will be used for pagination. nth_record refers to the starting record for each page
SELECT 
dw_sales_rep_id
,first_name
,last_name
,primary_location
from Sales_Reps
where dw_sales_rep_id like "%:dw_sales_rep_id%"
and first_name like "%:sales_first_name%"
and last_name like "%:sales_last_name%"
and primary_location like "%:sales_location%"

limit :nth_record, :row_per_page;



--Update for Sales_Reps based on users' input
UPDATE Sales_Reps
SET first_name = ':first_name', last_name = ':last_name', primary_location = ':primary_location'
where dw_sales_rep_id = ':dw_sales_rep_id';


--Add a new Sales Rep
INSERT INTO Sales_Reps (first_name, last_name, primary_location) VALUES ( ':first_name', ':last_name', ':primary_location');

--Delete a Sales Rep
DELETE from Sales_Reps
where dw_sales_rep_id = ':dw_sales_rep_id';



--Get the store list for the form input
SELECT 
store_location
from Vehicle_Inventories
group by 1;

















--Inventory Tab


--New Search from User based on user input in the serach form

--find the dw_vehicle_type_id based on description
SELECT dw_vehicle_type_id
from Vehicle_Types 
where vehicle_make like "%:make%"
and vehicle_model like "%:model%"
and vehicle_year like "%:year%"
and vehicle_color like "%:color%"
and vehicle_trim like "%:trim%";



--store the resulting dw_vehicle_type_id in fstring_sub and pull the inventory record
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

where b.dw_vehicle_type_id IN (:fstring_sub)
and a.sold_ind = '0'
order by 1
limit :row_per_page



-- Count the number of result returned from search, it will be stored in session for pagination purpose
SELECT count(distinct vin) as count
from Vehicle_Inventories as a

inner join Vehicle_Types as b
on a.dw_vehicle_type_id = b.dw_vehicle_type_id

where b.dw_vehicle_type_id IN (:fstring_sub)
and a.sold_ind = '0';



--if user press next or previous page after a search, the following query will be used for pagination. nth_record refers to the starting record for each page
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


where b.dw_vehicle_type_id IN (:fstring_sub)
and a.sold_ind = '0'
order by 1
limit :nth_record,:row_per_page;




--Update for vehicle inventory based on users' input

-- Pull the vehicle record for updating purpose (we can just use a function on client's side instead of sending a request)
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

where a.vin = ":vin";




-- to update the vehicle inventory, first identify the updated dw_vehicle_typ_id 
SELECT dw_vehicle_type_id
from Vehicle_Types 
where vehicle_make = ":make"
and vehicle_type = ":vtype"
and vehicle_model = ":model"
and vehicle_year = ":year"
and vehicle_color = ":color"
and vehicle_trim = ":trim";


UPDATE Vehicle_Inventories
SET dw_vehicle_type_id = ":vehicle_type_id",
vin = ":vin",
store_location = ":store_location",
parking_location = ":parking_location",
used_ind = ":used"
WHERE vin = ":orig_vin";



--Add a new vehicle inventory



-- using the two queries (with some python code) to find available parking spot for the new vehicle
select 
min(parking_lot) as destination
from (
SELECT substring(parking_location,1,1) as parking_lot 
,count(distinct vin) as count 
FROM Vehicle_Inventories
WHERE store_location = ":store_location"
group by 1
having count <> 1000
) as a;


SELECT max(substring(parking_location,1,1)) as destination 
FROM Vehicle_Inventories
WHERE store_location = ":store_location"

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
WHERE store_location = ":store_location"
group by 1
having count <> 1000
) as a
) as b
on substring(a.parking_location,1,1) = b.destination

WHERE a.store_location = ":store_location";



-- insert the vehicle info along with parking spot location 
INSERT INTO Vehicle_Inventories (dw_vehicle_type_id, vin, store_location, parking_location, used_ind) VALUES (":vehicle_type_id",":vin",":store_location",":final_parking_location",":used");


--Delete a vehicle inventory
delete from Vehicle_Inventories
where vin = ":vin";













-- Sales Record Tab

--READ
--New Search from User based on user input in the serach form

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

where c.first_name like "%:sfname%"
and c.last_name like "%:slname%"
and b.first_name like "%:cfname%"
and b.last_name like "%:clname%"


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
where vehicle_make like "%:make%"
and vehicle_model like "%:model%"
and vehicle_year like "%:year%"
and vehicle_color like "%:color%"
and vehicle_trim like "%:trim%"

) as c
on a.dw_vehicle_type_id = c.dw_vehicle_type_id


left join Financial_Options as d
on a.dw_fincl_option_id = d.dw_fincl_option_id

where a.vin like "%:vin%"


order by dw_invoice_id
limit :row_per_page




--Pull in the monthly payment scheule in the result table
SELECT 
dw_payment_id
,dw_invoice_id
,cast(payment_date as varchar(10)) as payment_date
,nth_payment
,payment_amount
,current_balance
from Monthly_Payments
where dw_invoice_id = ":dw_invoice_id"
order by 3




-- Count the number of result returned from search, it will be stored in session for pagination purpose
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

where c.first_name like "%:sfname%"
and c.last_name like "%:slname%"
and b.first_name like "%:cfname%"
and b.last_name like "%:clname%"


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
where vehicle_make like "%:make%"
and vehicle_model like "%:model%"
and vehicle_year like "%:year%"
and vehicle_color like "%:color%"
and vehicle_trim like "%:trim%"

) as c
on a.dw_vehicle_type_id = c.dw_vehicle_type_id

where a.vin like "%:vin%"    




--if user press next or previous page after a search, the following query will be used for pagination. nth_record refers to the starting record for each page
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


where c.first_name like "%:sfname%"
and c.last_name like "%:slname%"
and b.first_name like "%:cfname%"
and b.last_name like "%:clname%"


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
where vehicle_make like "%:make%"
and vehicle_model like "%:model%"
and vehicle_year like "%:year%"
and vehicle_color like "%:color%"
and vehicle_trim like "%:trim%"

) as c
on a.dw_vehicle_type_id = c.dw_vehicle_type_id

left join Financial_Options as d
on a.dw_fincl_option_id = d.dw_fincl_option_id

where a.vin like "%:vin%"


order by dw_invoice_id
limit :nth_record, :row_per_page




--Update for Sales_Record based on users' input ( check if the customer id, sales id exist in the tables)
select dw_customer_id
from Customers_Info
where dw_customer_id = ':dw_customer_id'

select dw_sales_rep_id
from Sales_Reps
where dw_sales_rep_id = ':dw_sales_rep_id'



UPDATE  Customers_Salesreps
SET dw_customer_id = ':dw_customer_id', dw_sales_rep_id = ':dw_sales_rep_id'
where dw_invoice_id = ':dw_invoice_id'



--Add a new sales record
INSERT INTO Sales_Records (purchase_date, dw_vehicle_type_id, vin, vehicle_price, dw_fincl_option_id, monthly_payment_amount, down_payment_amount) VALUES (":purchase_date",":dw_vehicle_type_id",":vin",":price",":dw_fincl_option_id",":monthly_payment",":down_payment");
INSERT INTO Customers_Salesreps (dw_customer_id, dw_invoice_id, dw_sales_rep_id) VALUES (":dw_customer_id",(select dw_invoice_id from Sales_Records where vin = ':vin'),":dw_sales_rep_id");


--Delete a customer (Also update the inventory)
UPDATE  Vehicle_Inventories
SET sold_ind = '0'
where vin in (select vin from Sales_Record where vin = ':vin')


delete from Sales_Records
where dw_invoice_id = ':dw_invoice_id'





-- Pull in the financial option for the pull down list in this tab

select 
dw_fincl_option_id
,int_rate
,num_of_payment
from Financial_Options



-- Pull in the vehicle information for updating and adding new sales purpose
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
where dw_vehicle_type_id in(SELECT dw_vehicle_type_id FROM Vehicle_Inventories where vin = ':vin' and sold_ind = '0')





-- Pull in the vehicle information for updating and adding new sales purpose
SELECT 
dw_sales_rep_id
,first_name
,last_name
,primary_location
from Sales_Reps
where dw_sales_rep_id = ":dw_sales_rep_id"



-- Pull in the customer information for updating and adding new sales purpose
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
where dw_customer_id = ":dw_customer_id"






-- test drive tab


-- search the test drive table based on result
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
AND vehicle_make like "%:make%"
AND vehicle_model like "%:model%"
AND vehicle_year like "%:year%"
AND vehicle_color like "%:color%"
AND vehicle_trim like "%:trim%"
AND first_name like "%:cfname%"
AND last_name like "%:clname%"
AND Test_Drives.vin like "%:vin%"
order by Test_Drives.vin
limit :row_per_page


-- Count the number of result returned from search, it will be stored in session for pagination purpose
SELECT
count(distinct Test_Drives.vin) as test_drive_count

FROM Vehicle_Types JOIN Customers_Info JOIN Test_Drives JOIN Vehicle_Inventories
WHERE Test_Drives.dw_customer_id = Customers_Info.dw_customer_id 
AND Test_Drives.vin = Vehicle_Inventories.vin 
AND Vehicle_Inventories.dw_vehicle_type_id = Vehicle_Types.dw_vehicle_type_id 
AND vehicle_make like "%:make%"
AND vehicle_model like "%:model%"
AND vehicle_year like "%:year%"
AND vehicle_color like "%:color%"
AND vehicle_trim like "%:trim%"
AND first_name like "%:cfname%"
AND last_name like "%:clname%"
AND Test_Drives.vin like "%:vin%"
order by Test_Drives.vin






--cf projection tab

-- pull the store list for input
SELECT 
store_location
from Vehicle_Inventories
group by 1


-- Calculate the revenue for future months using the Projection_Months  table
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
and c.store_location = ':store_location'

) as a


inner join Projection_Months as b 
on b.eom_dt between a.first_payment_month and a.final_payment_month
and b.eom_dt between ':report_start_date' and ':report_end_date'

group by 1,2


-- calculate the current vehicle inventory
select 
store_location
,vehicle_make
,vehicle_model
, count(distinct vin) as num_of_vehicle
, sum(vehicle_price) as inventory_cost
from Vehicle_Inventories as a 

inner join Vehicle_Types as b 
on a.dw_vehicle_type_id = b.dw_vehicle_type_id


where a.store_location = ':store_location'
and a.sold_ind = '0'

group by 1,2,3