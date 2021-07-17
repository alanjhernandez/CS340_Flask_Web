
drop table cs340_cheungke.Test_Drives_Backup;
drop table cs340_cheungke.Monthly_Payments_Backup;
drop table cs340_cheungke.Customers_Salesreps_Backup;
drop table cs340_cheungke.Sales_Records_Backup;
drop table cs340_cheungke.Vehicle_Inventories_Backup;
drop table cs340_cheungke.Vehicle_Types_Backup;
drop table cs340_cheungke.Sales_Reps_Backup;
drop table cs340_cheungke.Financial_Options_Backup;
drop table cs340_cheungke.Customers_Info_Backup;




create table cs340_cheungke.Customers_Info_Backup(
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



create table cs340_cheungke.Financial_Options_Backup(
   dw_fincl_option_id INT NOT NULL AUTO_INCREMENT,
   int_rate float NOT NULL,
   num_of_payment int NOT NULL,
   PRIMARY KEY ( dw_fincl_option_id )
);





create table cs340_cheungke.Sales_Reps_Backup(
   dw_sales_rep_id INT NOT NULL AUTO_INCREMENT,
   first_name VARCHAR(50) NOT NULL,
   last_name VARCHAR(100) NOT NULL,
   primary_location VARCHAR(50) NOT NULL,
   PRIMARY KEY ( dw_sales_rep_id )
);



create table cs340_cheungke.Vehicle_Types_Backup(
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



create table cs340_cheungke.Vehicle_Inventories_Backup(
   dw_vehicle_type_id VARCHAR(15) NOT NULL,
   vin VARCHAR(17) NOT NULL,
   store_location VARCHAR(50) NOT NULL,
   parking_location VARCHAR(5) NOT NULL,
   used_ind boolean NOT NULL,
   sold_ind boolean NOT NULL,
   PRIMARY KEY ( vin ),
   FOREIGN KEY (dw_vehicle_type_id)
        REFERENCES Vehicle_Types_Backup(dw_vehicle_type_id)
        ON DELETE CASCADE
);





create table cs340_cheungke.Sales_Records_Backup(
   dw_invoice_id INT NOT NULL AUTO_INCREMENT,
   purchase_date date NOT NULL,
   dw_vehicle_type_id VARCHAR(15) NOT NULL,
   vin VARCHAR(17) NOT NULL,
   vehicle_price float NOT NULL,
   dw_fincl_option_id integer NOT NULL,
   monthly_payment_amount float NOT NULL,
   down_payment_amount float NOT NULL,
   PRIMARY KEY ( dw_invoice_id ),
    FOREIGN KEY (dw_vehicle_type_id)
        REFERENCES Vehicle_Types_Backup(dw_vehicle_type_id)
        ON DELETE CASCADE,
    FOREIGN KEY (vin)
        REFERENCES Vehicle_Inventories_Backup(vin)
        ON DELETE CASCADE,
    FOREIGN KEY (dw_fincl_option_id)
        REFERENCES Financial_Options_Backup(dw_fincl_option_id)
        ON DELETE CASCADE
);





create table cs340_cheungke.Customers_Salesreps_Backup(
   dw_customer_id INT NOT NULL ,
   dw_invoice_id INT NOT NULL ,
   dw_sales_rep_id INT NOT NULL ,
   PRIMARY KEY ( dw_invoice_id ),
    FOREIGN KEY (dw_customer_id)
        REFERENCES Customers_Info_Backup(dw_customer_id)
        ON DELETE CASCADE,
    FOREIGN KEY (dw_invoice_id)
        REFERENCES Sales_Records_Backup(dw_invoice_id)
        ON DELETE CASCADE,
    FOREIGN KEY (dw_sales_rep_id)
        REFERENCES Sales_Reps_Backup(dw_sales_rep_id)
        ON DELETE CASCADE
);






create table cs340_cheungke.Monthly_Payments_Backup(
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
        REFERENCES Customers_Info_Backup(dw_customer_id)
        ON DELETE CASCADE,
    FOREIGN KEY (dw_invoice_id)
        REFERENCES Sales_Records_Backup(dw_invoice_id)
        ON DELETE CASCADE
);



create table cs340_cheungke.Test_Drives_Backup(
   dw_test_drive_id INT NOT NULL AUTO_INCREMENT,
   dw_customer_id INT NOT NULL,
   test_drive_date date NOT NULL,
   check_out_time datetime NOT NULL,
   return_time datetime NOT NULL,
   vin varchar(17) NOT NULL,
   PRIMARY KEY ( dw_test_drive_id ),
    FOREIGN KEY (dw_customer_id)
        REFERENCES Customers_Info_Backup(dw_customer_id)
        ON DELETE CASCADE,
    FOREIGN KEY (vin)
        REFERENCES Vehicle_Inventories_Backup(vin)
        ON DELETE CASCADE
);








insert into Customers_Info_Backup select * from Customers_Info;
insert into Financial_Options_Backup select * from Financial_Options;
insert into Sales_Reps_Backup select * from Sales_Reps;
insert into Vehicle_Types_Backup select * from Vehicle_Types;
insert into Vehicle_Inventories_Backup select * from Vehicle_Inventories;
insert into Sales_Records_Backup select * from Sales_Records;
insert into Customers_Salesreps_Backup select * from Customers_Salesreps;
insert into Monthly_Payments_Backup select * from Monthly_Payments;
insert into Test_Drives_Backup select * from Test_Drives;



















