
/*********************************************/
-- General Infomration Check for all tabs
/*********************************************/


--Pull the store location for pull down list
SELECT 
store_location
from Vehicle_Inventories as a
group by 1

--Pull the vehicle make for pull down list
SELECT 
vehicle_make
from Vehicle_Types as a
group by 1;

--Pull the vehicle model for pull down list
SELECT 
vehicle_model
from Vehicle_Types as a
where  vehicle_make like '%:make%'
group by 1


--Pull the vehicle year for pull down list
SELECT 
vehicle_year
from Vehicle_Types as a
where  vehicle_make like '%:make%'
group by 1


--Pull the vehicle color for pull down list
SELECT 
vehicle_color
from Vehicle_Types as a
where  vehicle_make like '%:make%'
group by 1


--Pull the vehicle type for pull down list
SELECT 
vehicle_type
from Vehicle_Types as a
where  vehicle_make like '%:make%'
group by 1

--Pull the vehicle trim for pull down list
SELECT 
vehicle_trim
from Vehicle_Types as a
where  vehicle_make like '%:make%'
and vehicle_model like '%:model%'
group by 1


--Pull the customer information for customer modal
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


--Pull the sales rep information for sales rep modal
SELECT 
dw_sales_rep_id
,first_name
,last_name
,primary_location
from Sales_Reps
where dw_sales_rep_id = ":dw_sales_rep_id"



--Pull the vehole information for vehicle modal
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



--Pull the financial options for pull down list
select 
dw_fincl_option_id
,int_rate
,num_of_payment
from Financial_Options



-- pull the financial arrangement for a particular financial option
select 
dw_fincl_option_id
,int_rate
,num_of_payment
from Financial_Options
where dw_fincl_option_id = ':dw_fincl_option_id';



-- pull the payment history
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



-- pull the projection months
SELECT 
cast(eom_dt as varchar(10)) as eom_dt
from Projection_Months as a
group by 1
order by 1




/*********************************************/
-- Customer Tab
/*********************************************/

--pull the customer information
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
order by dw_customer_id



--count the customer for pagination
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
:dob


--insert a new customer record
INSERT INTO Customers_Info (first_name, last_name, customer_dob, address_1, address_2, zip_code, state, city, tel_number, ssn) VALUES (':first_name',':last_name',':dob',':address_1',':address_2',':zip_code',':state',':city',':phone',':ssn');


-- Update customer info
UPDATE Customers_Info
SET customer_dob = ':dob', first_name= ':first_name', last_name= ':last_name', address_1= ':address_1', address_2= ':address_2', zip_code= ':zip_code', state= ':state', city= ':city',tel_number= ':tel_number',ssn= ':ssn'
where dw_customer_id = ':dw_customer_id'


--when deleting a customer, update the vehicle inventory to '0' for the car the customer purchased, delete the sales record and customer record
UPDATE Vehicle_Inventories
SET sold_ind = '0'
where vin in(
select vin
from Sales_Records
where dw_invoice_id in (
select dw_invoice_id
from Customers_Salesreps
where dw_customer_id = ':dw_customer_id'))


DELETE FROM Sales_Records
where dw_invoice_id in (
select dw_invoice_id
from Customers_Salesreps
where dw_customer_id = ':dw_customer_id')


DELETE from Customers_Info
where dw_customer_id = ':dw_customer_id'










/*********************************************/
-- Sales Rep Tab
/*********************************************/

--pull the sales rep information
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

order by dw_sales_rep_id


--count the sales_rep for pagination
SELECT count(distinct dw_sales_rep_id) as count
from Sales_Reps
where dw_sales_rep_id like "%:dw_sales_rep_id%"
and first_name like "%:sales_first_name%"
and last_name like "%:sales_last_name%"
and primary_location like "%:sales_location%"


--insert a new sales rep record
INSERT INTO Sales_Reps (first_name, last_name, primary_location) VALUES ( ':first_name', ':last_name', ':primary_location')

--Update a sales rep info
UPDATE Sales_Reps
SET first_name = ':first_name', last_name = ':last_name', primary_location = ':primary_location'
where dw_sales_rep_id = ':dw_sales_rep_id'


--when deleting a sales rep, update the vehicle inventory to '0' for the car the customer purchased, delete the sales record and sales rep record
UPDATE Vehicle_Inventories
SET sold_ind = '0'
where vin in(
select vin
from Sales_Records
where dw_invoice_id in (
select dw_invoice_id
from Customers_Salesreps
where dw_sales_rep_id = ':dw_sales_rep_id'))


DELETE FROM Sales_Records
where dw_invoice_id in (
select dw_invoice_id
from Customers_Salesreps
where dw_sales_rep_id = ':dw_sales_rep_id')


DELETE from Sales_Reps
where dw_sales_rep_id = ':dw_sales_rep_id'




/*********************************************/
-- CashFlow Projection
/*********************************************/

--Add a new month to the lower bound or upper bound of the projection months
INSERT INTO Projection_Months (  (select last_day(date_add(min(eom_dt), interval -1 month)) as eom_dt from Projection_Months));
INSERT INTO Projection_Months (  (select last_day(date_add(max(eom_dt), interval +1 month)) as eom_dt from Projection_Months));


--Calculate the monthly revenue for a particular store within a given month range
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



-- Calculate the inventory value of a given store
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









/*********************************************/
-- Vehicle Type Tab
/*********************************************/

--pull the Vehicle Type information
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

order by dw_sales_rep_id


--count the Vehicle Type for pagination
select count(*) as cnt

from Vehicle_Types

where dw_vehicle_type_id like "%:dw_vehicle_type_id%"
and vehicle_type like "%:vehicle_type%"
and vehicle_make like "%:vehicle_make%"
and vehicle_model like "%:vehicle_model%"
and vehicle_year like "%:vehicle_year%"
and vehicle_trim like "%:vehicle_trim%"
and vehicle_color like "%:vehicle_color%"



--insert a new Vehicle Type record
INSERT INTO Vehicle_Types (dw_vehicle_type_id, vehicle_type, vehicle_make, vehicle_model, vehicle_year, vehicle_color, vehicle_trim, vehicle_price) VALUES(':dw_vehicle_type_id',':vehicle_type',':vehicle_make',':vehicle_model',':vehicle_year',':vehicle_color',':vehicle_trim',':vehicle_price')



-- Update the Vehicle Type record
UPDATE Vehicle_Types
SET dw_vehicle_type_id = ':dw_vehicle_type_id', vehicle_make  = ':vehicle_make', vehicle_model  = ':vehicle_model', vehicle_year  = ':vehicle_year', vehicle_color  = ':vehicle_color', vehicle_trim  = ':vehicle_trim', vehicle_type  = ':vehicle_type', vehicle_price  = ':vehicle_price'
where dw_vehicle_type_id = ':dw_vehicle_type_id_old'


-- delete the vehicle type record
DELETE FROM Vehicle_Types WHERE dw_vehicle_type_id = ':dw_vehicle_type_id'








/*********************************************/
-- Sales Record Tab
/*********************************************/

--pull the Sales Info
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
,a.purchase_date
,a.dw_fincl_option_id
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
and vehicle_type like "%:type%"

) as c
on a.dw_vehicle_type_id = c.dw_vehicle_type_id


left join Financial_Options as d
on a.dw_fincl_option_id = d.dw_fincl_option_id

where a.vin like "%:vin%"
and a.dw_invoice_id like "%:dw_invoice_id%"


order by dw_invoice_id


--count the sales for pagination
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
and vehicle_type like "%:type%"

) as c
on a.dw_vehicle_type_id = c.dw_vehicle_type_id

where a.vin like "%:vin%"    
and a.dw_invoice_id like "%:dw_invoice_id%"


--To insert a sales, check if customer id, sales rep id, vin and financial record exist. If all exist, insert.
-- After inserting a new sales, update the inventory table to indicate the vehicle is sold
-- Pull the dw_invoice_id for the sale for status msg 

select dw_customer_id
from Customers_Info
where dw_customer_id = ':dw_customer_id'

select dw_sales_rep_id
from Sales_Reps
where dw_sales_rep_id = ':dw_sales_rep_id'

select vin
from Vehicle_Inventories
where vin = ':vin'

select dw_fincl_option_id
from Financial_Options
where dw_fincl_option_id = ':dw_fincl_option_id'

INSERT INTO Sales_Records (purchase_date, dw_vehicle_type_id, vin, vehicle_price, dw_fincl_option_id, monthly_payment_amount, down_payment_amount) VALUES (":purchase_date",":dw_vehicle_type_id",":vin",":price",:dw_fincl_option_id,:monthly_payment,":down_payment");
INSERT INTO Monthly_Payments (dw_invoice_id, payment_date, nth_payment, current_balance, vin, payment_amount, dw_customer_id) VALUES ((select dw_invoice_id from Sales_Records where vin = ':vin' limit 1),":purchase_date","0",":current_balance",":vin",":down_payment",":dw_customer_id");

UPDATE Vehicle_Inventories 
SET sold_ind = '1'
where vin = ':vin'

INSERT INTO Customers_Salesreps (dw_customer_id, dw_invoice_id, dw_sales_rep_id) VALUES (":dw_customer_id",(select dw_invoice_id from Sales_Records where vin = ':vin'),":dw_sales_rep_id");

SELECT max(dw_invoice_id)
from Sales_Records




-- Update the Sales Record 
UPDATE  Customers_Salesreps
SET dw_customer_id = ':dw_customer_id', dw_sales_rep_id = ':dw_sales_rep_id'
where dw_invoice_id = ':dw_invoice_id'


UPDATE  Sales_Records
SET purchase_date = ':purchase_date', dw_fincl_option_id = :dw_fincl_option_id, monthly_payment_amount = :monthly_payment, down_payment_amount = :down_payment
where dw_invoice_id = ':dw_invoice_id'




-- delete the vehicle type record also change the Vehicle_Inventories for the vehicle to '0'
UPDATE  Vehicle_Inventories
SET sold_ind = '0'
where vin = ':vin'


delete from Sales_Records
where dw_invoice_id = ':dw_invoice_id'








/*********************************************/
-- Financial Options Tab
/*********************************************/

--pull the Financial Options information
SELECT 
dw_fincl_option_id
,int_rate
,num_of_payment
from Financial_Options
order by dw_fincl_option_id


--count the Financial Options for pagination
SELECT count(*) as count
from Financial_Options


--insert a new Financial Options record
INSERT INTO Financial_Options (int_rate, num_of_payment) VALUES (':int_rate',':num_of_payment');


-- Update the Financial Options record
UPDATE Financial_Options
SET int_rate = ':int_rate', num_of_payment = ':num_of_payment'
where dw_fincl_option_id = ':dw_fincl_option_id'


-- Delete the sales record (update vehicle inventory to '0' for vin with the specific financial arrangement)
--delete the Financial Options record
UPDATE Vehicle_Inventories
SET sold_ind = '0'
where vin in(
select vin
from Sales_Records
where dw_fincl_option_id = ':dw_fincl_option_id'
)


DELETE from Financial_Options where dw_fincl_option_id = ':dw_fincl_option_id';




/*********************************************/
-- Monthly Payment Tab
/*********************************************/

--Pull the default payment parameters
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
where dw_invoice_id = ':dw_invoice_id'
group by 1
) as e 
on a.dw_invoice_id = e.dw_invoice_id
left join Financial_Options as f
on a.dw_fincl_option_id = f.dw_fincl_option_id
where a.dw_invoice_id = ':dw_invoice_id';



--pull the monthly payment information
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

where a.dw_customer_id like "%:dw_customer_id%"
and dw_invoice_id like "%:dw_invoice_id%"
and first_name like "%:first_name%"
and last_name like "%:last_name%"
and a.vin like "%:vin%"
and a.dw_payment_id like "%:dw_payment_id%"


order by dw_payment_id


--count the monthly payment for pagination
SELECT count(*) as count
from Monthly_Payments as a
left JOIN Customers_Info as b
on a.dw_customer_id = b.dw_customer_id

where a.dw_customer_id like "%:dw_customer_id%"
and dw_invoice_id like "%:dw_invoice_id%"
and first_name like "%:first_name%"
and last_name like "%:last_name%"
and vin like "%:vin%"


--check if the customer and invoice id exist, then insert a new monthly payment record
select dw_customer_id 
from Customers_Salesreps 
where dw_invoice_id = ':dw_invoice_id'

select dw_invoice_id
from Sales_Records
where dw_invoice_id = ':dw_invoice_id'

INSERT INTO Monthly_Payments (dw_invoice_id, payment_date, nth_payment, current_balance, vin, payment_amount, dw_customer_id) VALUES (':dw_invoice_id',':payment_date',':nth_payment',':current_balance',':vin',':payment_amount',(select dw_customer_id from Customers_Salesreps where dw_invoice_id = ':dw_invoice_id'))



-- Update the monthly payment record
Update Monthly_Payments
SET payment_date = ':payment_date', payment_amount = ':payment_amount', current_balance = ':current_balance'
WHERE dw_payment_id = ':dw_payment_id'


--delete the monthly payment record
DELETE FROM Monthly_Payments where dw_payment_id = ':dw_payment_id'







/*********************************************/
-- Vehicle Inventory Tab
/*********************************************/


--Pull the test drive history 

SELECT 
dw_test_drive_id
,test_drive_date
,check_out_time
,return_time
from Test_Drives
where vin = ":vin"
order by 2 ,3 ,4 ;



--pull the inventory record

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


where a.dw_vehicle_type_id IN (
SELECT dw_vehicle_type_id
from Vehicle_Types 
where vehicle_make like "%:make%"
and vehicle_model like "%:model%"
and vehicle_year like "%:year%"
and vehicle_color like "%:color%"
and vehicle_trim like "%:trim%"
and vehicle_type like "%:type%"
)
and a.used_ind = ':used'
and a.store_location like '%:store%'
and a.vin like '%:vin%'
and a.sold_ind = '0'
order by 1



--count the inventory record for pagination 
SELECT count(distinct vin) as count
from Vehicle_Inventories as a
where a.dw_vehicle_type_id IN (
SELECT dw_vehicle_type_id
from Vehicle_Types 
where vehicle_make like "%:make%"
and vehicle_model like "%:model%"
and vehicle_year like "%:year%"
and vehicle_color like "%:color%"
and vehicle_trim like "%:trim%"
and vehicle_type like "%:type%"
)
and a.used_ind = ':used'
and a.store_location like '%:store%'
and a.vin like '%:vin%'
and a.sold_ind = '0'




-- Update: check if the udpated vehicle type info exists in database. if so, update te record

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


-- Insert: check if the proposed vehicle type info exists in database
-- if so, find the next available parking spot
-- insert the record

SELECT dw_vehicle_type_id
from Vehicle_Types 
where vehicle_make = ":make"
and vehicle_type = ":vtype"
and vehicle_model = ":model"
and vehicle_year = ":year"
and vehicle_color = ":color"
and vehicle_trim = ":trim";

SELECT vin
from Vehicle_Inventories
where vin = ":vin";

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


INSERT INTO Vehicle_Inventories (dw_vehicle_type_id, vin, store_location, parking_location, used_ind) VALUES (":vehicle_type_id",":vin",":store_location",":final_parking_location",":used");



-- Delete a vehicle from inventories
delete from Vehicle_Inventories
where vin = ":vin";  






/*********************************************/
-- Test Drive
/*********************************************/


--pull the test drive record
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
AND vehicle_type like "%:type%"
AND vehicle_color like "%:color%"
AND vehicle_trim like "%:trim%"
AND first_name like "%:cfname%"
AND last_name like "%:clname%"
AND Test_Drives.vin like "%:vin%"
AND test_drive_date between ':test_drive_date_lower' and ':test_drive_date_upper'
AND dw_test_drive_id like "%:dw_test_drive_id%"

order by Test_Drives.vin


-- count the test drive record for pagination purpose
SELECT
count(distinct Test_Drives.vin) as test_drive_count

FROM Vehicle_Types JOIN Customers_Info JOIN Test_Drives JOIN Vehicle_Inventories
WHERE Test_Drives.dw_customer_id = Customers_Info.dw_customer_id 
AND Test_Drives.vin = Vehicle_Inventories.vin 
AND Vehicle_Inventories.dw_vehicle_type_id = Vehicle_Types.dw_vehicle_type_id 
AND vehicle_make like "%:make%"
AND vehicle_model like "%:model%"
AND vehicle_year like "%:year%"
AND vehicle_type like "%:type%"
AND vehicle_color like "%:color%"
AND vehicle_trim like "%:trim%"
AND first_name like "%:cfname%"
AND last_name like "%:clname%"
AND Test_Drives.vin like "%:vin%"
AND test_drive_date between ':test_drive_date_lower' and ':test_drive_date_upper'
AND dw_test_drive_id like "%:dw_test_drive_id%"
order by Test_Drives.vin



-- Insert: check if the vehicle is still avilable and the customer id exists. If so, add the record
-- All return the dw_test_drive_id for status msg
select vin
from Vehicle_Inventories
where vin = ":vin"
and sold_ind = '0'

select dw_customer_id
from Customers_Info
where dw_customer_id = ":dw_customer_id"

INSERT INTO Test_Drives (dw_customer_id, test_drive_date, check_out_time, return_time, vin) VALUES (":dw_customer_id",":test_drive_date",":check_out_time",":return_time",":vin");

SELECT max(dw_test_drive_id)
from Test_Drives;


-- UPDATE: check if the customer and vehicle info exist. If so, update the record

select dw_customer_id
from Customers_Info
where dw_customer_id = ':dw_customer_id'

select vin
from Vehicle_Inventories
where vin = ':vin'

UPDATE Test_Drives
SET dw_customer_id  = ':dw_customer_id', test_drive_date  = ':test_drive_date', check_out_time  = ':check_out_time', return_time  = ':return_time', vin  = ':vin'
where dw_test_drive_id = ':dw_test_drive_id'




-- delete the test drive record
delete from Test_Drives where dw_test_drive_id = ':dw_test_drive_id'