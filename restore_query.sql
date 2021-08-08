
drop table if exists cs340_cheungke.Test_Drives ;
drop table if exists cs340_cheungke.Monthly_Payments;
drop table if exists cs340_cheungke.Customers_Salesreps;
drop table if exists cs340_cheungke.Sales_Records;
drop table if exists cs340_cheungke.Vehicle_Inventories;
drop table if exists cs340_cheungke.Vehicle_Types;
drop table if exists cs340_cheungke.Sales_Reps;
drop table if exists cs340_cheungke.Financial_Options;
drop table if exists cs340_cheungke.Customers_Info;




create table cs340_cheungke.Customers_Info(
   dw_customer_id INT NOT NULL AUTO_INCREMENT,
   first_name VARCHAR(50) NOT NULL,
   last_name VARCHAR(100) NOT NULL,
   customer_dob DATE,
   address_1 varchar(100) NOT NULL,
   address_2 varchar(100),
   zip_code varchar(5) not null,
   state varchar(25) not null,
   city varchar(50) not null,
   tel_number varchar(10) not null,
   ssn varchar(9) not null,
   PRIMARY KEY ( dw_customer_id )
);

insert into Customers_Info
select * from Customers_Info_Backup;



create table cs340_cheungke.Financial_Options(
   dw_fincl_option_id INT NOT NULL AUTO_INCREMENT,
   int_rate float NOT NULL,
   num_of_payment int NOT NULL,
   PRIMARY KEY ( dw_fincl_option_id )
);

insert into Financial_Options
select * from Financial_Options_Backup;




create table cs340_cheungke.Sales_Reps(
   dw_sales_rep_id INT NOT NULL AUTO_INCREMENT,
   first_name VARCHAR(50) NOT NULL,
   last_name VARCHAR(100) NOT NULL,
   primary_location VARCHAR(50) NOT NULL,
   PRIMARY KEY ( dw_sales_rep_id )
);

insert into Sales_Reps
select * from Sales_Reps_Backup;



create table cs340_cheungke.Vehicle_Types(
   dw_vehicle_type_id VARCHAR(15)  NOT NULL,
   vehicle_type VARCHAR(30) NOT NULL,
   vehicle_make VARCHAR(30) NOT NULL,
   vehicle_model VARCHAR(30) NOT NULL,
   vehicle_year VARCHAR(4) NOT NULL,
   vehicle_color VARCHAR(30) NOT NULL,
   vehicle_trim VARCHAR(30) NOT NULL,
   vehicle_price float NOT NULL,
   PRIMARY KEY ( dw_vehicle_type_id )
);

insert into Vehicle_Types
select * from Vehicle_Types_Backup;



create table cs340_cheungke.Vehicle_Inventories(
   dw_vehicle_type_id VARCHAR(15) NOT NULL,
   vin VARCHAR(17) NOT NULL,
   store_location VARCHAR(50) NOT NULL,
   parking_location VARCHAR(5) NOT NULL,
   used_ind boolean NOT NULL,
   sold_ind boolean NOT NULL,
   PRIMARY KEY ( vin ),
   FOREIGN KEY (dw_vehicle_type_id)
        REFERENCES Vehicle_Types(dw_vehicle_type_id)
        ON DELETE CASCADE ON UPDATE CASCADE 
);

insert into Vehicle_Inventories
select * from Vehicle_Inventories_Backup;






create table cs340_cheungke.Sales_Records(
   dw_invoice_id INT NOT NULL AUTO_INCREMENT,
   purchase_date date NOT NULL,
   dw_vehicle_type_id VARCHAR(15) NOT NULL,
   vin VARCHAR(17) NOT NULL,
   vehicle_price float NOT NULL,
   dw_fincl_option_id integer NULL,
   monthly_payment_amount float NULL,
   down_payment_amount float NULL,
   PRIMARY KEY ( dw_invoice_id ),
    FOREIGN KEY (dw_vehicle_type_id)
        REFERENCES Vehicle_Types(dw_vehicle_type_id)
        ON DELETE CASCADE ON UPDATE CASCADE ,
    FOREIGN KEY (vin)
        REFERENCES Vehicle_Inventories(vin)
        ON DELETE CASCADE ON UPDATE CASCADE ,
    FOREIGN KEY (dw_fincl_option_id)
        REFERENCES Financial_Options(dw_fincl_option_id)
         ON DELETE CASCADE ON UPDATE CASCADE 
);

insert into Sales_Records
select * from Sales_Records_Backup;




create table cs340_cheungke.Customers_Salesreps(
   dw_customer_id INT NOT NULL ,
   dw_invoice_id INT NOT NULL ,
   dw_sales_rep_id INT NOT NULL ,
   PRIMARY KEY ( dw_invoice_id ),
    FOREIGN KEY (dw_customer_id)
        REFERENCES Customers_Info(dw_customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE ,
    FOREIGN KEY (dw_invoice_id)
        REFERENCES Sales_Records(dw_invoice_id)
        ON DELETE CASCADE ON UPDATE CASCADE ,
    FOREIGN KEY (dw_sales_rep_id)
        REFERENCES Sales_Reps(dw_sales_rep_id)
        ON DELETE CASCADE ON UPDATE CASCADE 
);


insert into Customers_Salesreps
select * from Customers_Salesreps_Backup;



create table cs340_cheungke.Monthly_Payments(
   dw_payment_id INT NOT NULL AUTO_INCREMENT,
   dw_invoice_id INT NOT NULL,
   payment_date date NOT NULL,
   nth_payment int NOT NULL,
   current_balance float NOT NULL,
   vin varchar(17) NOT NULL,
   payment_amount float NOT NULL,
   dw_customer_id int NOT NULL,
   PRIMARY KEY ( dw_payment_id ),
    FOREIGN KEY (dw_customer_id)
        REFERENCES Customers_Info(dw_customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE ,
    FOREIGN KEY (dw_invoice_id)
        REFERENCES Customers_Salesreps(dw_invoice_id)
        ON DELETE CASCADE ON UPDATE CASCADE 
);

insert into Monthly_Payments
select * from Monthly_Payments_Backup;




create table cs340_cheungke.Test_Drives(
   dw_test_drive_id INT NOT NULL AUTO_INCREMENT,
   dw_customer_id INT NOT NULL,
   test_drive_date date NOT NULL,
   check_out_time datetime NOT NULL,
   return_time datetime NOT NULL,
   vin varchar(17) NOT NULL,
   PRIMARY KEY ( dw_test_drive_id ),
    FOREIGN KEY (dw_customer_id)
        REFERENCES Customers_Info(dw_customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE ,
    FOREIGN KEY (vin)
        REFERENCES Vehicle_Inventories(vin)
        ON DELETE CASCADE ON UPDATE CASCADE 
);

insert into Test_Drives
select * from Test_Drives_Backup;













drop table Projection_Months;
create table Projection_Months(
   eom_dt date NOT NULL,
   PRIMARY KEY ( eom_dt )
);


insert into Projection_Months(eom_dt) VALUES('2018-1-31');
insert into Projection_Months(eom_dt) VALUES('2018-2-28');
insert into Projection_Months(eom_dt) VALUES('2018-3-31');
insert into Projection_Months(eom_dt) VALUES('2018-4-30');
insert into Projection_Months(eom_dt) VALUES('2018-5-31');
insert into Projection_Months(eom_dt) VALUES('2018-6-30');
insert into Projection_Months(eom_dt) VALUES('2018-7-31');
insert into Projection_Months(eom_dt) VALUES('2018-8-31');
insert into Projection_Months(eom_dt) VALUES('2018-9-30');
insert into Projection_Months(eom_dt) VALUES('2018-10-31');
insert into Projection_Months(eom_dt) VALUES('2018-11-30');
insert into Projection_Months(eom_dt) VALUES('2018-12-31');
insert into Projection_Months(eom_dt) VALUES('2019-1-31');
insert into Projection_Months(eom_dt) VALUES('2019-2-28');
insert into Projection_Months(eom_dt) VALUES('2019-3-31');
insert into Projection_Months(eom_dt) VALUES('2019-4-30');
insert into Projection_Months(eom_dt) VALUES('2019-5-31');
insert into Projection_Months(eom_dt) VALUES('2019-6-30');
insert into Projection_Months(eom_dt) VALUES('2019-7-31');
insert into Projection_Months(eom_dt) VALUES('2019-8-31');
insert into Projection_Months(eom_dt) VALUES('2019-9-30');
insert into Projection_Months(eom_dt) VALUES('2019-10-31');
insert into Projection_Months(eom_dt) VALUES('2019-11-30');
insert into Projection_Months(eom_dt) VALUES('2019-12-31');
insert into Projection_Months(eom_dt) VALUES('2020-1-31');
insert into Projection_Months(eom_dt) VALUES('2020-2-29');
insert into Projection_Months(eom_dt) VALUES('2020-3-31');
insert into Projection_Months(eom_dt) VALUES('2020-4-30');
insert into Projection_Months(eom_dt) VALUES('2020-5-31');
insert into Projection_Months(eom_dt) VALUES('2020-6-30');
insert into Projection_Months(eom_dt) VALUES('2020-7-31');
insert into Projection_Months(eom_dt) VALUES('2020-8-31');
insert into Projection_Months(eom_dt) VALUES('2020-9-30');
insert into Projection_Months(eom_dt) VALUES('2020-10-31');
insert into Projection_Months(eom_dt) VALUES('2020-11-30');
insert into Projection_Months(eom_dt) VALUES('2020-12-31');
insert into Projection_Months(eom_dt) VALUES('2021-1-31');
insert into Projection_Months(eom_dt) VALUES('2021-2-28');
insert into Projection_Months(eom_dt) VALUES('2021-3-31');
insert into Projection_Months(eom_dt) VALUES('2021-4-30');
insert into Projection_Months(eom_dt) VALUES('2021-5-31');
insert into Projection_Months(eom_dt) VALUES('2021-6-30');
insert into Projection_Months(eom_dt) VALUES('2021-7-31');
insert into Projection_Months(eom_dt) VALUES('2021-8-31');
insert into Projection_Months(eom_dt) VALUES('2021-9-30');
insert into Projection_Months(eom_dt) VALUES('2021-10-31');
insert into Projection_Months(eom_dt) VALUES('2021-11-30');
insert into Projection_Months(eom_dt) VALUES('2021-12-31');
insert into Projection_Months(eom_dt) VALUES('2022-1-31');
insert into Projection_Months(eom_dt) VALUES('2022-2-28');
insert into Projection_Months(eom_dt) VALUES('2022-3-31');
insert into Projection_Months(eom_dt) VALUES('2022-4-30');
insert into Projection_Months(eom_dt) VALUES('2022-5-31');
insert into Projection_Months(eom_dt) VALUES('2022-6-30');
insert into Projection_Months(eom_dt) VALUES('2022-7-31');
insert into Projection_Months(eom_dt) VALUES('2022-8-31');
insert into Projection_Months(eom_dt) VALUES('2022-9-30');
insert into Projection_Months(eom_dt) VALUES('2022-10-31');
insert into Projection_Months(eom_dt) VALUES('2022-11-30');
insert into Projection_Months(eom_dt) VALUES('2022-12-31');










