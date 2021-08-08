drop table if exists Test_Drives;
drop table if exists Monthly_Payments;
drop table if exists Customers_Salesreps;
drop table if exists Sales_Records;
drop table if exists Vehicle_Inventories;
drop table if exists Vehicle_Types;
drop table if exists Sales_Reps;
drop table if exists Financial_Options;
drop table if exists Customers_Info;
drop table if exists Projection_Months;



create table Customers_Info(
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

insert into Customers_Info (first_name, last_name,customer_dob,address_1,address_2,zip_code,state,city,tel_number,ssn) VALUES('Korey','Hitzke','1995-10-20','87054 Vernon Point','','97388','OR','Beaverton','5032493326','304816636');
insert into Customers_Info (first_name, last_name,customer_dob,address_1,address_2,zip_code,state,city,tel_number,ssn) VALUES('Broderic','Cable','1992-5-3','53585 Springview Court','','97287','OR','Gresham','9716474119','195499235');
insert into Customers_Info (first_name, last_name,customer_dob,address_1,address_2,zip_code,state,city,tel_number,ssn) VALUES('Sasha','Giuroni','1970-6-20','0 David Alley','','97278','OR','Hillsboro','9714710073','258507615');
insert into Customers_Info (first_name, last_name,customer_dob,address_1,address_2,zip_code,state,city,tel_number,ssn) VALUES('Arri','Thewlis','1995-8-13','2894 Lien Circle','','97703','OR','Hillsboro','5039206636','380693576');
insert into Customers_Info (first_name, last_name,customer_dob,address_1,address_2,zip_code,state,city,tel_number,ssn) VALUES('Gardie','Rushsorth','1970-8-21','5248 Chinook Park','','97336','OR','Portland','5036401398','752711287');
insert into Customers_Info (first_name, last_name,customer_dob,address_1,address_2,zip_code,state,city,tel_number,ssn) VALUES('Redford','Halvosen','1974-10-4','3 Haas Place','','97290','OR','Salem','9713155159','146769569');
insert into Customers_Info (first_name, last_name,customer_dob,address_1,address_2,zip_code,state,city,tel_number,ssn) VALUES('Drud','Scutchings','2000-7-24','4 Washington Place','','97416','OR','Salem','5033652880','706732188');
insert into Customers_Info (first_name, last_name,customer_dob,address_1,address_2,zip_code,state,city,tel_number,ssn) VALUES('Averil','Emer','1990-5-7','51588 Northport Drive','','97622','OR','Albany','5039066853','590449753');




create table Financial_Options(
   dw_fincl_option_id INT NOT NULL AUTO_INCREMENT,
   int_rate float NOT NULL,
   num_of_payment int NOT NULL,
   PRIMARY KEY ( dw_fincl_option_id )
);

insert into Financial_Options(int_rate, num_of_payment) VALUES('0.025','12');
insert into Financial_Options(int_rate, num_of_payment) VALUES('0.03','18');
insert into Financial_Options(int_rate, num_of_payment) VALUES('0.035','24');
insert into Financial_Options(int_rate, num_of_payment) VALUES('0.04','30');
insert into Financial_Options(int_rate, num_of_payment) VALUES('0.045','36');
insert into Financial_Options(int_rate, num_of_payment) VALUES('0.05','42');
insert into Financial_Options(int_rate, num_of_payment) VALUES('0.055','48');
insert into Financial_Options(int_rate, num_of_payment) VALUES('0.06','54');
insert into Financial_Options(int_rate, num_of_payment) VALUES('0.065','60');
insert into Financial_Options(int_rate, num_of_payment) VALUES('0.07','66');
insert into Financial_Options(int_rate, num_of_payment) VALUES('0.075','72');




create table Sales_Reps(
   dw_sales_rep_id INT NOT NULL AUTO_INCREMENT,
   first_name VARCHAR(50) NOT NULL,
   last_name VARCHAR(100) NOT NULL,
   primary_location VARCHAR(50) NOT NULL,
   PRIMARY KEY ( dw_sales_rep_id )
);

insert into Sales_Reps(first_name, last_name, primary_location) VALUES('Sebastian','Forsyth','Lake Oswego');
insert into Sales_Reps(first_name, last_name, primary_location) VALUES('William','Hart','Lake Oswego');
insert into Sales_Reps(first_name, last_name, primary_location) VALUES('Stewart','Welch','Bend');
insert into Sales_Reps(first_name, last_name, primary_location) VALUES('Frank','Walker','Beaverton');
insert into Sales_Reps(first_name, last_name, primary_location) VALUES('Eric','Rutherford','Tigard');
insert into Sales_Reps(first_name, last_name, primary_location) VALUES('Benjamin','Rutherford','Aloha');
insert into Sales_Reps(first_name, last_name, primary_location) VALUES('Victor','Watson','Portland');
insert into Sales_Reps(first_name, last_name, primary_location) VALUES('Sue','Wright','Lake Oswego');
insert into Sales_Reps(first_name, last_name, primary_location) VALUES('Dan','Metcalfe','Keizer');
insert into Sales_Reps(first_name, last_name, primary_location) VALUES('Jonathan','Grant','Bend');
insert into Sales_Reps(first_name, last_name, primary_location) VALUES('James','Buckland','Corvallis');



create table Vehicle_Types(
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

insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2016BLULX','SUV','HONDA','HR-V','2016','Blue','LX','21220');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2016BLUEX','SUV','HONDA','HR-V','2016','Blue','EX','24420');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2016BLUSP','SUV','HONDA','HR-V','2016','Blue','Sport','23170');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2016SILLX','SUV','HONDA','HR-V','2016','Silver','LX','21220');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2016SILEX','SUV','HONDA','HR-V','2016','Silver','EX','24420');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2016SILSP','SUV','HONDA','HR-V','2016','Silver','Sport','23170');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2016BLALX','SUV','HONDA','HR-V','2016','Black','LX','21220');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2016BLAEX','SUV','HONDA','HR-V','2016','Black','EX','24420');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2016BLASP','SUV','HONDA','HR-V','2016','Black','Sport','23170');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2017BLULX','SUV','HONDA','HR-V','2017','Blue','LX','21857');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2017BLUEX','SUV','HONDA','HR-V','2017','Blue','EX','25153');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2017BLUSP','SUV','HONDA','HR-V','2017','Blue','Sport','23865');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2017SILLX','SUV','HONDA','HR-V','2017','Silver','LX','21857');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2017SILEX','SUV','HONDA','HR-V','2017','Silver','EX','25153');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2017SILSP','SUV','HONDA','HR-V','2017','Silver','Sport','23865');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2017BLALX','SUV','HONDA','HR-V','2017','Black','LX','21857');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2017BLAEX','SUV','HONDA','HR-V','2017','Black','EX','25153');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2017BLASP','SUV','HONDA','HR-V','2017','Black','Sport','23865');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2018BLULX','SUV','HONDA','HR-V','2018','Blue','LX','22513');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2018BLUEX','SUV','HONDA','HR-V','2018','Blue','EX','25908');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2018BLUSP','SUV','HONDA','HR-V','2018','Blue','Sport','24581');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2018SILLX','SUV','HONDA','HR-V','2018','Silver','LX','22513');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2018SILEX','SUV','HONDA','HR-V','2018','Silver','EX','25908');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2018SILSP','SUV','HONDA','HR-V','2018','Silver','Sport','24581');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2018BLALX','SUV','HONDA','HR-V','2018','Black','LX','22513');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2018BLAEX','SUV','HONDA','HR-V','2018','Black','EX','25908');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2018BLASP','SUV','HONDA','HR-V','2018','Black','Sport','24581');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2019BLULX','SUV','HONDA','HR-V','2019','Blue','LX','23188');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2019BLUEX','SUV','HONDA','HR-V','2019','Blue','EX','26685');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2019BLUSP','SUV','HONDA','HR-V','2019','Blue','Sport','25318');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2019SILLX','SUV','HONDA','HR-V','2019','Silver','LX','23188');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2019SILEX','SUV','HONDA','HR-V','2019','Silver','EX','26685');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2019SILSP','SUV','HONDA','HR-V','2019','Silver','Sport','25318');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2019BLALX','SUV','HONDA','HR-V','2019','Black','LX','23188');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2019BLAEX','SUV','HONDA','HR-V','2019','Black','EX','26685');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2019BLASP','SUV','HONDA','HR-V','2019','Black','Sport','25318');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2020BLULX','SUV','HONDA','HR-V','2020','Blue','LX','23884');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2020BLUEX','SUV','HONDA','HR-V','2020','Blue','EX','27486');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2020BLUSP','SUV','HONDA','HR-V','2020','Blue','Sport','26078');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2020SILLX','SUV','HONDA','HR-V','2020','Silver','LX','23884');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2020SILEX','SUV','HONDA','HR-V','2020','Silver','EX','27486');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2020SILSP','SUV','HONDA','HR-V','2020','Silver','Sport','26078');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2020BLALX','SUV','HONDA','HR-V','2020','Black','LX','23884');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2020BLAEX','SUV','HONDA','HR-V','2020','Black','EX','27486');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOHR-V2020BLASP','SUV','HONDA','HR-V','2020','Black','Sport','26078');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2016BLULX','SUV','HONDA','CR-V','2016','Blue','LX','25350');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2016BLUEX','SUV','HONDA','CR-V','2016','Blue','EX','27860');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2016BLUSP','SUV','HONDA','CR-V','2016','Blue','Sport','26550');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2016SILLX','SUV','HONDA','CR-V','2016','Silver','LX','25350');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2016SILEX','SUV','HONDA','CR-V','2016','Silver','EX','27860');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2016SILSP','SUV','HONDA','CR-V','2016','Silver','Sport','26550');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2016BLALX','SUV','HONDA','CR-V','2016','Black','LX','25350');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2016BLAEX','SUV','HONDA','CR-V','2016','Black','EX','27860');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2016BLASP','SUV','HONDA','CR-V','2016','Black','Sport','26550');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2017BLULX','SUV','HONDA','CR-V','2017','Blue','LX','26111');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2017BLUEX','SUV','HONDA','CR-V','2017','Blue','EX','28696');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2017BLUSP','SUV','HONDA','CR-V','2017','Blue','Sport','27347');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2017SILLX','SUV','HONDA','CR-V','2017','Silver','LX','26111');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2017SILEX','SUV','HONDA','CR-V','2017','Silver','EX','28696');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2017SILSP','SUV','HONDA','CR-V','2017','Silver','Sport','27347');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2017BLALX','SUV','HONDA','CR-V','2017','Black','LX','26111');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2017BLAEX','SUV','HONDA','CR-V','2017','Black','EX','28696');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2017BLASP','SUV','HONDA','CR-V','2017','Black','Sport','27347');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2018BLULX','SUV','HONDA','CR-V','2018','Blue','LX','26894');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2018BLUEX','SUV','HONDA','CR-V','2018','Blue','EX','29557');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2018BLUSP','SUV','HONDA','CR-V','2018','Blue','Sport','28167');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2018SILLX','SUV','HONDA','CR-V','2018','Silver','LX','26894');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2018SILEX','SUV','HONDA','CR-V','2018','Silver','EX','29557');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2018SILSP','SUV','HONDA','CR-V','2018','Silver','Sport','28167');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2018BLALX','SUV','HONDA','CR-V','2018','Black','LX','26894');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2018BLAEX','SUV','HONDA','CR-V','2018','Black','EX','29557');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2018BLASP','SUV','HONDA','CR-V','2018','Black','Sport','28167');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2019BLULX','SUV','HONDA','CR-V','2019','Blue','LX','27701');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2019BLUEX','SUV','HONDA','CR-V','2019','Blue','EX','30444');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2019BLUSP','SUV','HONDA','CR-V','2019','Blue','Sport','29012');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2019SILLX','SUV','HONDA','CR-V','2019','Silver','LX','27701');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2019SILEX','SUV','HONDA','CR-V','2019','Silver','EX','30444');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2019SILSP','SUV','HONDA','CR-V','2019','Silver','Sport','29012');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2019BLALX','SUV','HONDA','CR-V','2019','Black','LX','27701');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2019BLAEX','SUV','HONDA','CR-V','2019','Black','EX','30444');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2019BLASP','SUV','HONDA','CR-V','2019','Black','Sport','29012');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2020BLULX','SUV','HONDA','CR-V','2020','Blue','LX','28532');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2020BLUEX','SUV','HONDA','CR-V','2020','Blue','EX','31357');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2020BLUSP','SUV','HONDA','CR-V','2020','Blue','Sport','29882');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2020SILLX','SUV','HONDA','CR-V','2020','Silver','LX','28532');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2020SILEX','SUV','HONDA','CR-V','2020','Silver','EX','31357');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2020SILSP','SUV','HONDA','CR-V','2020','Silver','Sport','29882');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2020BLALX','SUV','HONDA','CR-V','2020','Black','LX','28532');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2020BLAEX','SUV','HONDA','CR-V','2020','Black','EX','31357');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCR-V2020BLASP','SUV','HONDA','CR-V','2020','Black','Sport','29882');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2016BLULX','SEDAN','HONDA','Civic','2016','Blue','LX','21700');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2016BLUEX','SEDAN','HONDA','Civic','2016','Blue','EX','24700');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2016BLUSP','SEDAN','HONDA','Civic','2016','Blue','Sport','23100');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2016SILLX','SEDAN','HONDA','Civic','2016','Silver','LX','21700');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2016SILEX','SEDAN','HONDA','Civic','2016','Silver','EX','24700');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2016SILSP','SEDAN','HONDA','Civic','2016','Silver','Sport','23100');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2016BLALX','SEDAN','HONDA','Civic','2016','Black','LX','21700');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2016BLAEX','SEDAN','HONDA','Civic','2016','Black','EX','24700');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2016BLASP','SEDAN','HONDA','Civic','2016','Black','Sport','23100');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2017BLULX','SEDAN','HONDA','Civic','2017','Blue','LX','22351');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2017BLUEX','SEDAN','HONDA','Civic','2017','Blue','EX','25441');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2017BLUSP','SEDAN','HONDA','Civic','2017','Blue','Sport','23793');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2017SILLX','SEDAN','HONDA','Civic','2017','Silver','LX','22351');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2017SILEX','SEDAN','HONDA','Civic','2017','Silver','EX','25441');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2017SILSP','SEDAN','HONDA','Civic','2017','Silver','Sport','23793');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2017BLALX','SEDAN','HONDA','Civic','2017','Black','LX','22351');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2017BLAEX','SEDAN','HONDA','Civic','2017','Black','EX','25441');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2017BLASP','SEDAN','HONDA','Civic','2017','Black','Sport','23793');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2018BLULX','SEDAN','HONDA','Civic','2018','Blue','LX','23022');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2018BLUEX','SEDAN','HONDA','Civic','2018','Blue','EX','26204');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2018BLUSP','SEDAN','HONDA','Civic','2018','Blue','Sport','24507');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2018SILLX','SEDAN','HONDA','Civic','2018','Silver','LX','23022');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2018SILEX','SEDAN','HONDA','Civic','2018','Silver','EX','26204');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2018SILSP','SEDAN','HONDA','Civic','2018','Silver','Sport','24507');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2018BLALX','SEDAN','HONDA','Civic','2018','Black','LX','23022');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2018BLAEX','SEDAN','HONDA','Civic','2018','Black','EX','26204');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2018BLASP','SEDAN','HONDA','Civic','2018','Black','Sport','24507');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2019BLULX','SEDAN','HONDA','Civic','2019','Blue','LX','23713');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2019BLUEX','SEDAN','HONDA','Civic','2019','Blue','EX','26990');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2019BLUSP','SEDAN','HONDA','Civic','2019','Blue','Sport','25242');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2019SILLX','SEDAN','HONDA','Civic','2019','Silver','LX','23713');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2019SILEX','SEDAN','HONDA','Civic','2019','Silver','EX','26990');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2019SILSP','SEDAN','HONDA','Civic','2019','Silver','Sport','25242');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2019BLALX','SEDAN','HONDA','Civic','2019','Black','LX','23713');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2019BLAEX','SEDAN','HONDA','Civic','2019','Black','EX','26990');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2019BLASP','SEDAN','HONDA','Civic','2019','Black','Sport','25242');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2020BLULX','SEDAN','HONDA','Civic','2020','Blue','LX','24424');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2020BLUEX','SEDAN','HONDA','Civic','2020','Blue','EX','27800');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2020BLUSP','SEDAN','HONDA','Civic','2020','Blue','Sport','25999');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2020SILLX','SEDAN','HONDA','Civic','2020','Silver','LX','24424');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2020SILEX','SEDAN','HONDA','Civic','2020','Silver','EX','27800');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2020SILSP','SEDAN','HONDA','Civic','2020','Silver','Sport','25999');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2020BLALX','SEDAN','HONDA','Civic','2020','Black','LX','24424');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2020BLAEX','SEDAN','HONDA','Civic','2020','Black','EX','27800');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOCIVI2020BLASP','SEDAN','HONDA','Civic','2020','Black','Sport','25999');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2016BLULX','SEDAN','HONDA','Accord','2016','Blue','LX','24970');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2016BLUEX','SEDAN','HONDA','Accord','2016','Blue','EX','31290');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2016BLUSP','SEDAN','HONDA','Accord','2016','Blue','Sport','27430');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2016SILLX','SEDAN','HONDA','Accord','2016','Silver','LX','24970');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2016SILEX','SEDAN','HONDA','Accord','2016','Silver','EX','31290');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2016SILSP','SEDAN','HONDA','Accord','2016','Silver','Sport','27430');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2016BLALX','SEDAN','HONDA','Accord','2016','Black','LX','24970');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2016BLAEX','SEDAN','HONDA','Accord','2016','Black','EX','31290');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2016BLASP','SEDAN','HONDA','Accord','2016','Black','Sport','27430');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2017BLULX','SEDAN','HONDA','Accord','2017','Blue','LX','25719');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2017BLUEX','SEDAN','HONDA','Accord','2017','Blue','EX','32229');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2017BLUSP','SEDAN','HONDA','Accord','2017','Blue','Sport','28253');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2017SILLX','SEDAN','HONDA','Accord','2017','Silver','LX','25719');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2017SILEX','SEDAN','HONDA','Accord','2017','Silver','EX','32229');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2017SILSP','SEDAN','HONDA','Accord','2017','Silver','Sport','28253');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2017BLALX','SEDAN','HONDA','Accord','2017','Black','LX','25719');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2017BLAEX','SEDAN','HONDA','Accord','2017','Black','EX','32229');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2017BLASP','SEDAN','HONDA','Accord','2017','Black','Sport','28253');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2018BLULX','SEDAN','HONDA','Accord','2018','Blue','LX','26491');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2018BLUEX','SEDAN','HONDA','Accord','2018','Blue','EX','33196');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2018BLUSP','SEDAN','HONDA','Accord','2018','Blue','Sport','29101');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2018SILLX','SEDAN','HONDA','Accord','2018','Silver','LX','26491');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2018SILEX','SEDAN','HONDA','Accord','2018','Silver','EX','33196');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2018SILSP','SEDAN','HONDA','Accord','2018','Silver','Sport','29101');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2018BLALX','SEDAN','HONDA','Accord','2018','Black','LX','26491');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2018BLAEX','SEDAN','HONDA','Accord','2018','Black','EX','33196');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2018BLASP','SEDAN','HONDA','Accord','2018','Black','Sport','29101');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2019BLULX','SEDAN','HONDA','Accord','2019','Blue','LX','27286');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2019BLUEX','SEDAN','HONDA','Accord','2019','Blue','EX','34192');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2019BLUSP','SEDAN','HONDA','Accord','2019','Blue','Sport','29974');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2019SILLX','SEDAN','HONDA','Accord','2019','Silver','LX','27286');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2019SILEX','SEDAN','HONDA','Accord','2019','Silver','EX','34192');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2019SILSP','SEDAN','HONDA','Accord','2019','Silver','Sport','29974');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2019BLALX','SEDAN','HONDA','Accord','2019','Black','LX','27286');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2019BLAEX','SEDAN','HONDA','Accord','2019','Black','EX','34192');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2019BLASP','SEDAN','HONDA','Accord','2019','Black','Sport','29974');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2020BLULX','SEDAN','HONDA','Accord','2020','Blue','LX','28105');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2020BLUEX','SEDAN','HONDA','Accord','2020','Blue','EX','35218');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2020BLUSP','SEDAN','HONDA','Accord','2020','Blue','Sport','30873');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2020SILLX','SEDAN','HONDA','Accord','2020','Silver','LX','28105');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2020SILEX','SEDAN','HONDA','Accord','2020','Silver','EX','35218');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2020SILSP','SEDAN','HONDA','Accord','2020','Silver','Sport','30873');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2020BLALX','SEDAN','HONDA','Accord','2020','Black','LX','28105');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2020BLAEX','SEDAN','HONDA','Accord','2020','Black','EX','35218');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('HOACCO2020BLASP','SEDAN','HONDA','Accord','2020','Black','Sport','30873');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2016BLUL','SEDAN','Toyota','Avalon','2016','Blue','L','36125');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2016BLULE','SEDAN','Toyota','Avalon','2016','Blue','LE','39360');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2016BLUSE','SEDAN','Toyota','Avalon','2016','Blue','SE','42425');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2016SILL','SEDAN','Toyota','Avalon','2016','Silver','L','36125');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2016SILLE','SEDAN','Toyota','Avalon','2016','Silver','LE','39360');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2016SILSE','SEDAN','Toyota','Avalon','2016','Silver','SE','42425');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2016BLAL','SEDAN','Toyota','Avalon','2016','Black','L','36125');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2016BLALE','SEDAN','Toyota','Avalon','2016','Black','LE','39360');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2016BLASE','SEDAN','Toyota','Avalon','2016','Black','SE','42425');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2016BLUL','SUV','Toyota','C-HR','2016','Blue','L','21595');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2016BLULE','SUV','Toyota','C-HR','2016','Blue','LE','23630');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2016BLUSE','SUV','Toyota','C-HR','2016','Blue','SE','26650');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2016SILL','SUV','Toyota','C-HR','2016','Silver','L','21595');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2016SILLE','SUV','Toyota','C-HR','2016','Silver','LE','23630');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2016SILSE','SUV','Toyota','C-HR','2016','Silver','SE','26650');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2016BLAL','SUV','Toyota','C-HR','2016','Black','L','21595');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2016BLALE','SUV','Toyota','C-HR','2016','Black','LE','23630');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2016BLASE','SUV','Toyota','C-HR','2016','Black','SE','26650');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2016BLUL','SEDAN','Toyota','Camry','2016','Blue','L','25045');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2016BLULE','SEDAN','Toyota','Camry','2016','Blue','LE','26560');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2016BLUSE','SEDAN','Toyota','Camry','2016','Blue','SE','28785');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2016SILL','SEDAN','Toyota','Camry','2016','Silver','L','25045');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2016SILLE','SEDAN','Toyota','Camry','2016','Silver','LE','26560');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2016SILSE','SEDAN','Toyota','Camry','2016','Silver','SE','28785');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2016BLAL','SEDAN','Toyota','Camry','2016','Black','L','25045');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2016BLALE','SEDAN','Toyota','Camry','2016','Black','LE','26560');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2016BLASE','SEDAN','Toyota','Camry','2016','Black','SE','28785');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2016BLUL','SEDAN','Toyota','Corolla','2016','Blue','L','20075');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2016BLULE','SEDAN','Toyota','Corolla','2016','Blue','LE','20525');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2016BLUSE','SEDAN','Toyota','Corolla','2016','Blue','SE','22525');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2016SILL','SEDAN','Toyota','Corolla','2016','Silver','L','20075');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2016SILLE','SEDAN','Toyota','Corolla','2016','Silver','LE','20525');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2016SILSE','SEDAN','Toyota','Corolla','2016','Silver','SE','22525');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2016BLAL','SEDAN','Toyota','Corolla','2016','Black','L','20075');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2016BLALE','SEDAN','Toyota','Corolla','2016','Black','LE','20525');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2016BLASE','SEDAN','Toyota','Corolla','2016','Black','SE','22525');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2016BLUL','SEDAN','Toyota','Prius','2016','Blue','L','24525');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2016BLULE','SEDAN','Toyota','Prius','2016','Blue','LE','27565');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2016BLUSE','SEDAN','Toyota','Prius','2016','Blue','SE','32650');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2016SILL','SEDAN','Toyota','Prius','2016','Silver','L','24525');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2016SILLE','SEDAN','Toyota','Prius','2016','Silver','LE','27565');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2016SILSE','SEDAN','Toyota','Prius','2016','Silver','SE','32650');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2016BLAL','SEDAN','Toyota','Prius','2016','Black','L','24525');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2016BLALE','SEDAN','Toyota','Prius','2016','Black','LE','27565');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2016BLASE','SEDAN','Toyota','Prius','2016','Black','SE','32650');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42016BLUL','SUV','Toyota','RAV4','2016','Blue','L','26250');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42016BLULE','SUV','Toyota','RAV4','2016','Blue','LE','27545');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42016BLUSE','SUV','Toyota','RAV4','2016','Blue','SE','30250');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42016SILL','SUV','Toyota','RAV4','2016','Silver','L','26250');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42016SILLE','SUV','Toyota','RAV4','2016','Silver','LE','27545');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42016SILSE','SUV','Toyota','RAV4','2016','Silver','SE','30250');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42016BLAL','SUV','Toyota','RAV4','2016','Black','L','26250');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42016BLALE','SUV','Toyota','RAV4','2016','Black','LE','27545');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42016BLASE','SUV','Toyota','RAV4','2016','Black','SE','30250');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2016BLUL','Truck','Toyota','Tacoma','2016','Blue','L','26400');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2016BLULE','Truck','Toyota','Tacoma','2016','Blue','LE','32980');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2016BLUSE','Truck','Toyota','Tacoma','2016','Blue','SE','34565');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2016SILL','Truck','Toyota','Tacoma','2016','Silver','L','26400');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2016SILLE','Truck','Toyota','Tacoma','2016','Silver','LE','32980');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2016SILSE','Truck','Toyota','Tacoma','2016','Silver','SE','34565');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2016BLAL','Truck','Toyota','Tacoma','2016','Black','L','26400');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2016BLALE','Truck','Toyota','Tacoma','2016','Black','LE','32980');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2016BLASE','Truck','Toyota','Tacoma','2016','Black','SE','34565');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2017BLUL','SEDAN','Toyota','Avalon','2017','Blue','L','37209');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2017BLULE','SEDAN','Toyota','Avalon','2017','Blue','LE','40541');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2017BLUSE','SEDAN','Toyota','Avalon','2017','Blue','SE','43698');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2017SILL','SEDAN','Toyota','Avalon','2017','Silver','L','37209');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2017SILLE','SEDAN','Toyota','Avalon','2017','Silver','LE','40541');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2017SILSE','SEDAN','Toyota','Avalon','2017','Silver','SE','43698');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2017BLAL','SEDAN','Toyota','Avalon','2017','Black','L','37209');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2017BLALE','SEDAN','Toyota','Avalon','2017','Black','LE','40541');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2017BLASE','SEDAN','Toyota','Avalon','2017','Black','SE','43698');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2017BLUL','SUV','Toyota','C-HR','2017','Blue','L','22243');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2017BLULE','SUV','Toyota','C-HR','2017','Blue','LE','24339');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2017BLUSE','SUV','Toyota','C-HR','2017','Blue','SE','27450');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2017SILL','SUV','Toyota','C-HR','2017','Silver','L','22243');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2017SILLE','SUV','Toyota','C-HR','2017','Silver','LE','24339');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2017SILSE','SUV','Toyota','C-HR','2017','Silver','SE','27450');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2017BLAL','SUV','Toyota','C-HR','2017','Black','L','22243');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2017BLALE','SUV','Toyota','C-HR','2017','Black','LE','24339');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2017BLASE','SUV','Toyota','C-HR','2017','Black','SE','27450');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2017BLUL','SEDAN','Toyota','Camry','2017','Blue','L','25796');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2017BLULE','SEDAN','Toyota','Camry','2017','Blue','LE','27357');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2017BLUSE','SEDAN','Toyota','Camry','2017','Blue','SE','29649');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2017SILL','SEDAN','Toyota','Camry','2017','Silver','L','25796');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2017SILLE','SEDAN','Toyota','Camry','2017','Silver','LE','27357');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2017SILSE','SEDAN','Toyota','Camry','2017','Silver','SE','29649');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2017BLAL','SEDAN','Toyota','Camry','2017','Black','L','25796');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2017BLALE','SEDAN','Toyota','Camry','2017','Black','LE','27357');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2017BLASE','SEDAN','Toyota','Camry','2017','Black','SE','29649');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2017BLUL','SEDAN','Toyota','Corolla','2017','Blue','L','20677');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2017BLULE','SEDAN','Toyota','Corolla','2017','Blue','LE','21141');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2017BLUSE','SEDAN','Toyota','Corolla','2017','Blue','SE','23201');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2017SILL','SEDAN','Toyota','Corolla','2017','Silver','L','20677');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2017SILLE','SEDAN','Toyota','Corolla','2017','Silver','LE','21141');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2017SILSE','SEDAN','Toyota','Corolla','2017','Silver','SE','23201');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2017BLAL','SEDAN','Toyota','Corolla','2017','Black','L','20677');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2017BLALE','SEDAN','Toyota','Corolla','2017','Black','LE','21141');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2017BLASE','SEDAN','Toyota','Corolla','2017','Black','SE','23201');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2017BLUL','SEDAN','Toyota','Prius','2017','Blue','L','25261');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2017BLULE','SEDAN','Toyota','Prius','2017','Blue','LE','28392');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2017BLUSE','SEDAN','Toyota','Prius','2017','Blue','SE','33630');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2017SILL','SEDAN','Toyota','Prius','2017','Silver','L','25261');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2017SILLE','SEDAN','Toyota','Prius','2017','Silver','LE','28392');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2017SILSE','SEDAN','Toyota','Prius','2017','Silver','SE','33630');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2017BLAL','SEDAN','Toyota','Prius','2017','Black','L','25261');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2017BLALE','SEDAN','Toyota','Prius','2017','Black','LE','28392');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2017BLASE','SEDAN','Toyota','Prius','2017','Black','SE','33630');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42017BLUL','SUV','Toyota','RAV4','2017','Blue','L','27038');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42017BLULE','SUV','Toyota','RAV4','2017','Blue','LE','28371');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42017BLUSE','SUV','Toyota','RAV4','2017','Blue','SE','31158');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42017SILL','SUV','Toyota','RAV4','2017','Silver','L','27038');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42017SILLE','SUV','Toyota','RAV4','2017','Silver','LE','28371');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42017SILSE','SUV','Toyota','RAV4','2017','Silver','SE','31158');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42017BLAL','SUV','Toyota','RAV4','2017','Black','L','27038');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42017BLALE','SUV','Toyota','RAV4','2017','Black','LE','28371');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42017BLASE','SUV','Toyota','RAV4','2017','Black','SE','31158');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2017BLUL','Truck','Toyota','Tacoma','2017','Blue','L','27192');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2017BLULE','Truck','Toyota','Tacoma','2017','Blue','LE','33969');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2017BLUSE','Truck','Toyota','Tacoma','2017','Blue','SE','35602');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2017SILL','Truck','Toyota','Tacoma','2017','Silver','L','27192');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2017SILLE','Truck','Toyota','Tacoma','2017','Silver','LE','33969');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2017SILSE','Truck','Toyota','Tacoma','2017','Silver','SE','35602');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2017BLAL','Truck','Toyota','Tacoma','2017','Black','L','27192');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2017BLALE','Truck','Toyota','Tacoma','2017','Black','LE','33969');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2017BLASE','Truck','Toyota','Tacoma','2017','Black','SE','35602');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2018BLUL','SEDAN','Toyota','Avalon','2018','Blue','L','38325');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2018BLULE','SEDAN','Toyota','Avalon','2018','Blue','LE','41757');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2018BLUSE','SEDAN','Toyota','Avalon','2018','Blue','SE','45009');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2018SILL','SEDAN','Toyota','Avalon','2018','Silver','L','38325');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2018SILLE','SEDAN','Toyota','Avalon','2018','Silver','LE','41757');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2018SILSE','SEDAN','Toyota','Avalon','2018','Silver','SE','45009');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2018BLAL','SEDAN','Toyota','Avalon','2018','Black','L','38325');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2018BLALE','SEDAN','Toyota','Avalon','2018','Black','LE','41757');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2018BLASE','SEDAN','Toyota','Avalon','2018','Black','SE','45009');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2018BLUL','SUV','Toyota','C-HR','2018','Blue','L','22910');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2018BLULE','SUV','Toyota','C-HR','2018','Blue','LE','25069');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2018BLUSE','SUV','Toyota','C-HR','2018','Blue','SE','28274');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2018SILL','SUV','Toyota','C-HR','2018','Silver','L','22910');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2018SILLE','SUV','Toyota','C-HR','2018','Silver','LE','25069');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2018SILSE','SUV','Toyota','C-HR','2018','Silver','SE','28274');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2018BLAL','SUV','Toyota','C-HR','2018','Black','L','22910');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2018BLALE','SUV','Toyota','C-HR','2018','Black','LE','25069');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2018BLASE','SUV','Toyota','C-HR','2018','Black','SE','28274');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2018BLUL','SEDAN','Toyota','Camry','2018','Blue','L','26570');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2018BLULE','SEDAN','Toyota','Camry','2018','Blue','LE','28178');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2018BLUSE','SEDAN','Toyota','Camry','2018','Blue','SE','30538');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2018SILL','SEDAN','Toyota','Camry','2018','Silver','L','26570');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2018SILLE','SEDAN','Toyota','Camry','2018','Silver','LE','28178');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2018SILSE','SEDAN','Toyota','Camry','2018','Silver','SE','30538');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2018BLAL','SEDAN','Toyota','Camry','2018','Black','L','26570');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2018BLALE','SEDAN','Toyota','Camry','2018','Black','LE','28178');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2018BLASE','SEDAN','Toyota','Camry','2018','Black','SE','30538');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2018BLUL','SEDAN','Toyota','Corolla','2018','Blue','L','21297');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2018BLULE','SEDAN','Toyota','Corolla','2018','Blue','LE','21775');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2018BLUSE','SEDAN','Toyota','Corolla','2018','Blue','SE','23897');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2018SILL','SEDAN','Toyota','Corolla','2018','Silver','L','21297');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2018SILLE','SEDAN','Toyota','Corolla','2018','Silver','LE','21775');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2018SILSE','SEDAN','Toyota','Corolla','2018','Silver','SE','23897');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2018BLAL','SEDAN','Toyota','Corolla','2018','Black','L','21297');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2018BLALE','SEDAN','Toyota','Corolla','2018','Black','LE','21775');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2018BLASE','SEDAN','Toyota','Corolla','2018','Black','SE','23897');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2018BLUL','SEDAN','Toyota','Prius','2018','Blue','L','26019');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2018BLULE','SEDAN','Toyota','Prius','2018','Blue','LE','29244');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2018BLUSE','SEDAN','Toyota','Prius','2018','Blue','SE','34639');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2018SILL','SEDAN','Toyota','Prius','2018','Silver','L','26019');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2018SILLE','SEDAN','Toyota','Prius','2018','Silver','LE','29244');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2018SILSE','SEDAN','Toyota','Prius','2018','Silver','SE','34639');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2018BLAL','SEDAN','Toyota','Prius','2018','Black','L','26019');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2018BLALE','SEDAN','Toyota','Prius','2018','Black','LE','29244');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2018BLASE','SEDAN','Toyota','Prius','2018','Black','SE','34639');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42018BLUL','SUV','Toyota','RAV4','2018','Blue','L','27849');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42018BLULE','SUV','Toyota','RAV4','2018','Blue','LE','29222');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42018BLUSE','SUV','Toyota','RAV4','2018','Blue','SE','32093');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42018SILL','SUV','Toyota','RAV4','2018','Silver','L','27849');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42018SILLE','SUV','Toyota','RAV4','2018','Silver','LE','29222');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42018SILSE','SUV','Toyota','RAV4','2018','Silver','SE','32093');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42018BLAL','SUV','Toyota','RAV4','2018','Black','L','27849');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42018BLALE','SUV','Toyota','RAV4','2018','Black','LE','29222');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42018BLASE','SUV','Toyota','RAV4','2018','Black','SE','32093');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2018BLUL','Truck','Toyota','Tacoma','2018','Blue','L','28008');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2018BLULE','Truck','Toyota','Tacoma','2018','Blue','LE','34988');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2018BLUSE','Truck','Toyota','Tacoma','2018','Blue','SE','36670');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2018SILL','Truck','Toyota','Tacoma','2018','Silver','L','28008');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2018SILLE','Truck','Toyota','Tacoma','2018','Silver','LE','34988');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2018SILSE','Truck','Toyota','Tacoma','2018','Silver','SE','36670');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2018BLAL','Truck','Toyota','Tacoma','2018','Black','L','28008');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2018BLALE','Truck','Toyota','Tacoma','2018','Black','LE','34988');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2018BLASE','Truck','Toyota','Tacoma','2018','Black','SE','36670');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2019BLUL','SEDAN','Toyota','Avalon','2019','Blue','L','39475');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2019BLULE','SEDAN','Toyota','Avalon','2019','Blue','LE','43010');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2019BLUSE','SEDAN','Toyota','Avalon','2019','Blue','SE','46359');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2019SILL','SEDAN','Toyota','Avalon','2019','Silver','L','39475');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2019SILLE','SEDAN','Toyota','Avalon','2019','Silver','LE','43010');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2019SILSE','SEDAN','Toyota','Avalon','2019','Silver','SE','46359');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2019BLAL','SEDAN','Toyota','Avalon','2019','Black','L','39475');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2019BLALE','SEDAN','Toyota','Avalon','2019','Black','LE','43010');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2019BLASE','SEDAN','Toyota','Avalon','2019','Black','SE','46359');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2019BLUL','SUV','Toyota','C-HR','2019','Blue','L','23597');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2019BLULE','SUV','Toyota','C-HR','2019','Blue','LE','25821');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2019BLUSE','SUV','Toyota','C-HR','2019','Blue','SE','29122');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2019SILL','SUV','Toyota','C-HR','2019','Silver','L','23597');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2019SILLE','SUV','Toyota','C-HR','2019','Silver','LE','25821');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2019SILSE','SUV','Toyota','C-HR','2019','Silver','SE','29122');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2019BLAL','SUV','Toyota','C-HR','2019','Black','L','23597');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2019BLALE','SUV','Toyota','C-HR','2019','Black','LE','25821');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2019BLASE','SUV','Toyota','C-HR','2019','Black','SE','29122');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2019BLUL','SEDAN','Toyota','Camry','2019','Blue','L','27367');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2019BLULE','SEDAN','Toyota','Camry','2019','Blue','LE','29023');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2019BLUSE','SEDAN','Toyota','Camry','2019','Blue','SE','31454');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2019SILL','SEDAN','Toyota','Camry','2019','Silver','L','27367');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2019SILLE','SEDAN','Toyota','Camry','2019','Silver','LE','29023');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2019SILSE','SEDAN','Toyota','Camry','2019','Silver','SE','31454');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2019BLAL','SEDAN','Toyota','Camry','2019','Black','L','27367');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2019BLALE','SEDAN','Toyota','Camry','2019','Black','LE','29023');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2019BLASE','SEDAN','Toyota','Camry','2019','Black','SE','31454');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2019BLUL','SEDAN','Toyota','Corolla','2019','Blue','L','21936');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2019BLULE','SEDAN','Toyota','Corolla','2019','Blue','LE','22428');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2019BLUSE','SEDAN','Toyota','Corolla','2019','Blue','SE','24614');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2019SILL','SEDAN','Toyota','Corolla','2019','Silver','L','21936');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2019SILLE','SEDAN','Toyota','Corolla','2019','Silver','LE','22428');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2019SILSE','SEDAN','Toyota','Corolla','2019','Silver','SE','24614');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2019BLAL','SEDAN','Toyota','Corolla','2019','Black','L','21936');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2019BLALE','SEDAN','Toyota','Corolla','2019','Black','LE','22428');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2019BLASE','SEDAN','Toyota','Corolla','2019','Black','SE','24614');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2019BLUL','SEDAN','Toyota','Prius','2019','Blue','L','26800');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2019BLULE','SEDAN','Toyota','Prius','2019','Blue','LE','30121');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2019BLUSE','SEDAN','Toyota','Prius','2019','Blue','SE','35678');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2019SILL','SEDAN','Toyota','Prius','2019','Silver','L','26800');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2019SILLE','SEDAN','Toyota','Prius','2019','Silver','LE','30121');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2019SILSE','SEDAN','Toyota','Prius','2019','Silver','SE','35678');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2019BLAL','SEDAN','Toyota','Prius','2019','Black','L','26800');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2019BLALE','SEDAN','Toyota','Prius','2019','Black','LE','30121');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2019BLASE','SEDAN','Toyota','Prius','2019','Black','SE','35678');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42019BLUL','SUV','Toyota','RAV4','2019','Blue','L','28684');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42019BLULE','SUV','Toyota','RAV4','2019','Blue','LE','30099');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42019BLUSE','SUV','Toyota','RAV4','2019','Blue','SE','33056');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42019SILL','SUV','Toyota','RAV4','2019','Silver','L','28684');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42019SILLE','SUV','Toyota','RAV4','2019','Silver','LE','30099');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42019SILSE','SUV','Toyota','RAV4','2019','Silver','SE','33056');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42019BLAL','SUV','Toyota','RAV4','2019','Black','L','28684');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42019BLALE','SUV','Toyota','RAV4','2019','Black','LE','30099');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42019BLASE','SUV','Toyota','RAV4','2019','Black','SE','33056');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2019BLUL','Truck','Toyota','Tacoma','2019','Blue','L','28848');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2019BLULE','Truck','Toyota','Tacoma','2019','Blue','LE','36038');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2019BLUSE','Truck','Toyota','Tacoma','2019','Blue','SE','37770');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2019SILL','Truck','Toyota','Tacoma','2019','Silver','L','28848');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2019SILLE','Truck','Toyota','Tacoma','2019','Silver','LE','36038');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2019SILSE','Truck','Toyota','Tacoma','2019','Silver','SE','37770');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2019BLAL','Truck','Toyota','Tacoma','2019','Black','L','28848');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2019BLALE','Truck','Toyota','Tacoma','2019','Black','LE','36038');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2019BLASE','Truck','Toyota','Tacoma','2019','Black','SE','37770');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2020BLUL','SEDAN','Toyota','Avalon','2020','Blue','L','40659');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2020BLULE','SEDAN','Toyota','Avalon','2020','Blue','LE','44300');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2020BLUSE','SEDAN','Toyota','Avalon','2020','Blue','SE','47750');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2020SILL','SEDAN','Toyota','Avalon','2020','Silver','L','40659');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2020SILLE','SEDAN','Toyota','Avalon','2020','Silver','LE','44300');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2020SILSE','SEDAN','Toyota','Avalon','2020','Silver','SE','47750');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2020BLAL','SEDAN','Toyota','Avalon','2020','Black','L','40659');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2020BLALE','SEDAN','Toyota','Avalon','2020','Black','LE','44300');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOAVAL2020BLASE','SEDAN','Toyota','Avalon','2020','Black','SE','47750');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2020BLUL','SUV','Toyota','C-HR','2020','Blue','L','24305');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2020BLULE','SUV','Toyota','C-HR','2020','Blue','LE','26596');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2020BLUSE','SUV','Toyota','C-HR','2020','Blue','SE','29996');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2020SILL','SUV','Toyota','C-HR','2020','Silver','L','24305');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2020SILLE','SUV','Toyota','C-HR','2020','Silver','LE','26596');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2020SILSE','SUV','Toyota','C-HR','2020','Silver','SE','29996');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2020BLAL','SUV','Toyota','C-HR','2020','Black','L','24305');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2020BLALE','SUV','Toyota','C-HR','2020','Black','LE','26596');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOC-HR2020BLASE','SUV','Toyota','C-HR','2020','Black','SE','29996');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2020BLUL','SEDAN','Toyota','Camry','2020','Blue','L','28188');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2020BLULE','SEDAN','Toyota','Camry','2020','Blue','LE','29894');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2020BLUSE','SEDAN','Toyota','Camry','2020','Blue','SE','32398');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2020SILL','SEDAN','Toyota','Camry','2020','Silver','L','28188');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2020SILLE','SEDAN','Toyota','Camry','2020','Silver','LE','29894');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2020SILSE','SEDAN','Toyota','Camry','2020','Silver','SE','32398');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2020BLAL','SEDAN','Toyota','Camry','2020','Black','L','28188');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2020BLALE','SEDAN','Toyota','Camry','2020','Black','LE','29894');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCAMR2020BLASE','SEDAN','Toyota','Camry','2020','Black','SE','32398');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2020BLUL','SEDAN','Toyota','Corolla','2020','Blue','L','22594');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2020BLULE','SEDAN','Toyota','Corolla','2020','Blue','LE','23101');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2020BLUSE','SEDAN','Toyota','Corolla','2020','Blue','SE','25352');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2020SILL','SEDAN','Toyota','Corolla','2020','Silver','L','22594');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2020SILLE','SEDAN','Toyota','Corolla','2020','Silver','LE','23101');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2020SILSE','SEDAN','Toyota','Corolla','2020','Silver','SE','25352');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2020BLAL','SEDAN','Toyota','Corolla','2020','Black','L','22594');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2020BLALE','SEDAN','Toyota','Corolla','2020','Black','LE','23101');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOCORO2020BLASE','SEDAN','Toyota','Corolla','2020','Black','SE','25352');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2020BLUL','SEDAN','Toyota','Prius','2020','Blue','L','27604');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2020BLULE','SEDAN','Toyota','Prius','2020','Blue','LE','31025');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2020BLUSE','SEDAN','Toyota','Prius','2020','Blue','SE','36748');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2020SILL','SEDAN','Toyota','Prius','2020','Silver','L','27604');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2020SILLE','SEDAN','Toyota','Prius','2020','Silver','LE','31025');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2020SILSE','SEDAN','Toyota','Prius','2020','Silver','SE','36748');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2020BLAL','SEDAN','Toyota','Prius','2020','Black','L','27604');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2020BLALE','SEDAN','Toyota','Prius','2020','Black','LE','31025');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOPRIU2020BLASE','SEDAN','Toyota','Prius','2020','Black','SE','36748');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42020BLUL','SUV','Toyota','RAV4','2020','Blue','L','29545');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42020BLULE','SUV','Toyota','RAV4','2020','Blue','LE','31002');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42020BLUSE','SUV','Toyota','RAV4','2020','Blue','SE','34048');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42020SILL','SUV','Toyota','RAV4','2020','Silver','L','29545');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42020SILLE','SUV','Toyota','RAV4','2020','Silver','LE','31002');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42020SILSE','SUV','Toyota','RAV4','2020','Silver','SE','34048');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42020BLAL','SUV','Toyota','RAV4','2020','Black','L','29545');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42020BLALE','SUV','Toyota','RAV4','2020','Black','LE','31002');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TORAV42020BLASE','SUV','Toyota','RAV4','2020','Black','SE','34048');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2020BLUL','Truck','Toyota','Tacoma','2020','Blue','L','29713');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2020BLULE','Truck','Toyota','Tacoma','2020','Blue','LE','37119');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2020BLUSE','Truck','Toyota','Tacoma','2020','Blue','SE','38903');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2020SILL','Truck','Toyota','Tacoma','2020','Silver','L','29713');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2020SILLE','Truck','Toyota','Tacoma','2020','Silver','LE','37119');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2020SILSE','Truck','Toyota','Tacoma','2020','Silver','SE','38903');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2020BLAL','Truck','Toyota','Tacoma','2020','Black','L','29713');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2020BLALE','Truck','Toyota','Tacoma','2020','Black','LE','37119');
insert into Vehicle_Types(dw_vehicle_type_id,vehicle_type,vehicle_make,vehicle_model, vehicle_year,vehicle_color,vehicle_trim,vehicle_price) VALUES('TOTACO2020BLASE','Truck','Toyota','Tacoma','2020','Black','SE','38903');




create table Vehicle_Inventories(
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

insert into Vehicle_Inventories(dw_vehicle_type_id,vin,store_location,parking_location, used_ind,sold_ind) VALUES('TOPRIU2018SILLE','9633WE51000A5221O','Albany','A0','0','0');
insert into Vehicle_Inventories(dw_vehicle_type_id,vin,store_location,parking_location, used_ind,sold_ind) VALUES('HOCIVI2019BLALX','7651OI63100J7411X','Eugene','A0','0','1');
insert into Vehicle_Inventories(dw_vehicle_type_id,vin,store_location,parking_location, used_ind,sold_ind) VALUES('TOCAMR2017SILL','1851HR88349V9212J','Aloha','A0','0','0');
insert into Vehicle_Inventories(dw_vehicle_type_id,vin,store_location,parking_location, used_ind,sold_ind) VALUES('TORAV42016BLUSE','4460MI52854L5943H','Gresham','A0','1','1');
insert into Vehicle_Inventories(dw_vehicle_type_id,vin,store_location,parking_location, used_ind,sold_ind) VALUES('TOPRIU2018BLUSE','9561IQ52982H6483N','Portland','A0','0','1');
insert into Vehicle_Inventories(dw_vehicle_type_id,vin,store_location,parking_location, used_ind,sold_ind) VALUES('HOCIVI2020BLALX','5993EW69518D9743K','Gresham','A1','0','0');
insert into Vehicle_Inventories(dw_vehicle_type_id,vin,store_location,parking_location, used_ind,sold_ind) VALUES('TOTACO2018BLUSE','4885GJ44400M3281H','Medford','A0','0','1');
insert into Vehicle_Inventories(dw_vehicle_type_id,vin,store_location,parking_location, used_ind,sold_ind) VALUES('HOCIVI2018SILEX','8844SV66070R8856T','Medford','A1','0','0');
insert into Vehicle_Inventories(dw_vehicle_type_id,vin,store_location,parking_location, used_ind,sold_ind) VALUES('HOHR-V2018BLULX','7315IB81468U3778M','Aloha','A1','0','1');
insert into Vehicle_Inventories(dw_vehicle_type_id,vin,store_location,parking_location, used_ind,sold_ind) VALUES('HOCIVI2018SILEX','1338JW86745H6764H','Lake Oswego','A0','0','1');
insert into Vehicle_Inventories(dw_vehicle_type_id,vin,store_location,parking_location, used_ind,sold_ind) VALUES('TOC-HR2017BLAL','6079CA72392O1522A','Tigard','A0','0','1');
insert into Vehicle_Inventories(dw_vehicle_type_id,vin,store_location,parking_location, used_ind,sold_ind) VALUES('TOCORO2016BLALE','1982XQ68267P6675U','Gresham','A2','0','1');
insert into Vehicle_Inventories(dw_vehicle_type_id,vin,store_location,parking_location, used_ind,sold_ind) VALUES('HOCR-V2017BLUSP','8672PH43096K7547M','Keizer','A0','0','0');
insert into Vehicle_Inventories(dw_vehicle_type_id,vin,store_location,parking_location, used_ind,sold_ind) VALUES('HOCR-V2018BLASP','2552AA97190W7693C','Salem','A0','0','0');






create table Sales_Records(
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
        REFERENCES Vehicle_Types(dw_vehicle_type_id)
        ON DELETE CASCADE ON UPDATE CASCADE ,
    FOREIGN KEY (vin)
        REFERENCES Vehicle_Inventories(vin)
        ON DELETE CASCADE ON UPDATE CASCADE ,
    FOREIGN KEY (dw_fincl_option_id)
        REFERENCES Financial_Options(dw_fincl_option_id)
        ON DELETE CASCADE ON UPDATE CASCADE 
);


insert into Sales_Records(purchase_date, dw_vehicle_type_id, vin, vehicle_price, dw_fincl_option_id, monthly_payment_amount, down_payment_amount) VALUES('2018-1-1','HOCIVI2019BLALX','7651OI63100J7411X','23713','1','1882.7496178444','1423');
insert into Sales_Records(purchase_date, dw_vehicle_type_id, vin, vehicle_price, dw_fincl_option_id, monthly_payment_amount, down_payment_amount) VALUES('2016-8-29','TORAV42016BLUSE','4460MI52854L5943H','30250','1','2044.07989016754','6050');
insert into Sales_Records(purchase_date, dw_vehicle_type_id, vin, vehicle_price, dw_fincl_option_id, monthly_payment_amount, down_payment_amount) VALUES('2019-8-2','TOPRIU2018BLUSE','9561IQ52982H6483N','34639','5','535.801603704501','16627');
insert into Sales_Records(purchase_date, dw_vehicle_type_id, vin, vehicle_price, dw_fincl_option_id, monthly_payment_amount, down_payment_amount) VALUES('2018-11-12','TOTACO2018BLUSE','4885GJ44400M3281H','36670','7','776.068578333106','3300');
insert into Sales_Records(purchase_date, dw_vehicle_type_id, vin, vehicle_price, dw_fincl_option_id, monthly_payment_amount, down_payment_amount) VALUES('2019-6-24','HOHR-V2018BLULX','7315IB81468U3778M','22513','4','718.750578014628','2026');
insert into Sales_Records(purchase_date, dw_vehicle_type_id, vin, vehicle_price, dw_fincl_option_id, monthly_payment_amount, down_payment_amount) VALUES('2018-3-27','HOCIVI2018SILEX','1338JW86745H6764H','26204','9','261.482004795088','12840');
insert into Sales_Records(purchase_date, dw_vehicle_type_id, vin, vehicle_price, dw_fincl_option_id, monthly_payment_amount, down_payment_amount) VALUES('2018-1-23','TOC-HR2017BLAL','6079CA72392O1522A','22243','7','362.103319288177','6673');
insert into Sales_Records(purchase_date, dw_vehicle_type_id, vin, vehicle_price, dw_fincl_option_id, monthly_payment_amount, down_payment_amount) VALUES('2017-7-5','TOCORO2016BLALE','1982XQ68267P6675U','20525','7','267.309926261933','9031');






create table Customers_Salesreps(
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


insert into Customers_Salesreps(dw_customer_id, dw_sales_rep_id, dw_invoice_id) VALUES('3','2','1');
insert into Customers_Salesreps(dw_customer_id, dw_sales_rep_id, dw_invoice_id) VALUES('2','4','2');
insert into Customers_Salesreps(dw_customer_id, dw_sales_rep_id, dw_invoice_id) VALUES('4','1','3');
insert into Customers_Salesreps(dw_customer_id, dw_sales_rep_id, dw_invoice_id) VALUES('5','4','4');
insert into Customers_Salesreps(dw_customer_id, dw_sales_rep_id, dw_invoice_id) VALUES('4','3','5');
insert into Customers_Salesreps(dw_customer_id, dw_sales_rep_id, dw_invoice_id) VALUES('2','8','6');
insert into Customers_Salesreps(dw_customer_id, dw_sales_rep_id, dw_invoice_id) VALUES('1','4','7');
insert into Customers_Salesreps(dw_customer_id, dw_sales_rep_id, dw_invoice_id) VALUES('8','2','8');



create table Monthly_Payments(
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
        REFERENCES Sales_Records(dw_invoice_id)
        ON DELETE CASCADE ON UPDATE CASCADE 
);

insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('1','2018-2-1','1','20453.6878821568','7651OI63100J7411X','1882.7496178444','3');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('1','2018-3-1','2','18613.5501140668','7651OI63100J7411X','1882.7496178444','3');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('1','2018-4-1','3','16769.5787256266','7651OI63100J7411X','1882.7496178444','3');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('1','2018-5-1','4','14921.7657301272','7651OI63100J7411X','1882.7496178444','3');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('1','2018-6-1','5','13070.1031242203','7651OI63100J7411X','1882.7496178444','3');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('1','2018-7-1','6','11214.5828878846','7651OI63100J7411X','1882.7496178444','3');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('1','2018-8-1','7','9355.19698438987','7651OI63100J7411X','1882.7496178444','3');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('1','2018-9-1','8','7491.9373602629','7651OI63100J7411X','1882.7496178444','3');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('1','2018-10-1','9','5624.7959452522','7651OI63100J7411X','1882.7496178444','3');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('1','2018-11-1','10','3753.7646522937','7651OI63100J7411X','1882.7496178444','3');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('1','2018-12-1','11','1878.83537747475','7651OI63100J7411X','1882.7496178444','3');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('1','2019-1-1','12','0','7651OI63100J7411X','1882.7496178444','3');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('2','2016-9-29','1','22206.3367765005','4460MI52854L5943H','2044.07989016754','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('2','2016-10-29','2','20208.5200879505','4460MI52854L5943H','2044.07989016754','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('2','2016-11-29','3','18206.5412812994','4460MI52854L5943H','2044.07989016754','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('2','2016-12-29','4','16200.3916854678','4460MI52854L5943H','2044.07989016754','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('2','2017-1-29','5','14190.0626113114','4460MI52854L5943H','2044.07989016754','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('2','2017-2-28','6','12175.545351584','4460MI52854L5943H','2044.07989016754','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('2','2017-3-29','7','10156.8311808988','4460MI52854L5943H','2044.07989016754','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('2','2017-4-29','8','8133.91135569144','4460MI52854L5943H','2044.07989016754','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('2','2017-5-29','9','6106.77711418139','4460MI52854L5943H','2044.07989016754','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('2','2017-6-29','10','4075.41967633502','4460MI52854L5943H','2044.07989016754','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('2','2017-7-29','11','2039.83024382634','4460MI52854L5943H','2044.07989016754','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('2','2017-8-29','12','0','4460MI52854L5943H','2044.07989016754','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2019-9-2','1','17543.7433962952','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2019-10-2','2','17073.7308303268','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2019-11-2','3','16601.955717236','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2019-12-2','4','16128.4114474712','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2020-1-2','5','15653.0913866946','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2020-2-2','6','15175.9888756903','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2020-3-2','7','14697.0972302697','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2020-4-2','8','14216.4097411787','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2020-5-2','9','13733.9196740036','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2020-6-2','10','13249.6202690766','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2020-7-2','11','12763.5047413812','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2020-8-2','12','12275.5662804568','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2020-9-2','13','11785.7980503041','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2020-10-2','14','11294.1931892882','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2020-11-2','15','10800.7448100436','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2020-12-2','16','10305.4459993767','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2021-1-2','17','9808.28981816989','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2021-2-2','18','9309.26930128355','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2021-3-2','19','8808.37745745886','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2021-4-2','20','8305.60726921985','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2021-5-2','21','7800.95169277492','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2021-6-2','22','7294.40365791835','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2021-7-2','23','6785.95606793107','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2021-8-2','24','6275.60179948131','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2021-9-2','25','5763.33370252487','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2021-10-2','26','5249.14460020485','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2021-11-2','27','4733.02728875114','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('3','2021-12-2','28','4214.97453737945','9561IQ52982H6483N','535.801603704501','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2018-12-12','1','32746.8772550003','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2019-1-12','2','32120.8985307526','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2019-2-12','3','31492.0507373521','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2019-3-12','4','30860.3207248985','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2019-4-12','5','30225.6952832212','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2019-5-12','6','29588.1611416029','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2019-6-12','7','28947.7049685021','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2019-7-12','8','28304.3133712746','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2019-8-12','9','27657.9728958932','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2019-9-12','10','27008.6700266663','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2019-10-12','11','26356.3911859554','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2019-11-12','12','25701.1227338913','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2019-12-12','13','25042.8509680885','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2020-1-12','14','24381.5621233591','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2020-2-12','15','23717.2423714247','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2020-3-12','16','23049.8778206273','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2020-4-12','17','22379.4545156387','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2020-5-12','18','21705.958437169','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2020-6-12','19','21029.3755016729','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2020-7-12','20','20349.6915610558','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2020-8-12','21','19666.8924023775','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2020-9-12','22','18980.9637475553','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2020-10-12','23','18291.8912530652','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2020-11-12','24','17599.660509642','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2020-12-12','25','16904.257041978','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2021-1-12','26','16205.6663084207','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2021-2-12','27','15503.8737006678','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2021-3-12','28','14798.8645434628','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2021-4-12','29','14090.6240942872','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2021-5-12','30','13379.1375430529','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2021-6-12','31','12664.3900117921','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2021-7-12','32','11946.3665543464','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2021-8-12','33','11225.052156054','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2021-9-12','34','10500.4317334362','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2021-10-12','35','9772.49013388133','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2021-11-12','36','9041.2121353285','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('4','2021-12-12','37','8306.582445949','4885GJ44400M3281H','776.068578333106','5');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2019-7-24','1','19836.5394219858','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2019-8-24','2','19183.9106420445','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2019-9-24','3','18529.1064328367','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2019-10-24','4','17872.1195429315','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2019-11-24','5','17212.9426967266','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2019-12-24','6','16551.5685943677','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2020-1-24','7','15887.9899116677','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2020-2-24','8','15222.1993000252','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2020-3-24','9','14554.189386344','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2020-4-24','10','13883.9527729505','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2020-5-24','11','13211.4820375124','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2020-6-24','12','12536.7697329561','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2020-7-24','13','11859.8083873846','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2020-8-24','14','11180.5905039946','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2020-9-24','15','10499.1085609933','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2020-10-24','16','9815.35501151524','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2020-11-24','17','9129.32228353896','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2020-12-24','18','8441.00277980282','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2021-1-24','19','7750.38887772087','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2021-2-24','20','7057.4729292986','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2021-3-24','21','6362.24726104826','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2021-4-24','22','5664.70417390378','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2021-5-24','23','4964.83594313552','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2021-6-24','24','4262.63481826463','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2021-7-24','25','3558.09302297752','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2021-8-24','26','2851.20275503947','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2021-9-24','27','2141.95618620832','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2021-10-24','28','1430.34546214768','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2021-11-24','29','716.362702340178','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('5','2021-12-24','30','0','7315IB81468U3778M','718.750578014628','4');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2018-4-27','1','13174.9063285381','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2018-5-27','2','12984.7883996893','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2018-6-27','3','12793.6406653925','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2018-7-27','4','12601.457547535','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2018-8-27','5','12408.233437789','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2018-9-27','6','12213.9626974486','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2018-10-27','7','12018.6396572647','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2018-11-27','8','11822.2586172798','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2018-12-27','9','11624.8138466617','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2019-1-27','10','11426.299583536','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2019-2-27','11','11226.7100348184','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2019-3-27','12','11026.0393760453','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2019-4-27','13','10824.2817512037','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2019-5-27','14','10621.431272561','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2019-6-27','15','10417.4820204923','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2019-7-27','16','10212.4280433082','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2019-8-27','17','10006.2633570811','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2019-9-27','18','9798.98194547015','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2019-10-27','19','9590.57775954636','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2019-11-27','20','9381.04471761549','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2019-12-27','21','9170.37670504082','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2020-1-27','22','8958.5675740647','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2020-2-27','23','8745.61114362913','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2020-3-27','24','8531.50119919538','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2020-4-27','25','8316.2314925626','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2020-5-27','26','8099.79574168556','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2020-6-27','27','7882.18763049126','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2020-7-27','28','7663.40080869467','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2020-8-27','29','7443.42889161336','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2020-9-27','30','7222.26545998117','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2020-10-27','31','6999.90405976098','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2020-11-27','32','6776.33820195627','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2020-12-27','33','6551.56136242179','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2021-1-27','34','6325.56698167315','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2021-2-27','35','6098.34846469546','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2021-3-27','36','5869.89918075081','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2021-4-27','37','5640.21246318479','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2021-5-27','38','5409.28160923195','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2021-6-27','39','5177.09987982021','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2021-7-27','40','4943.66049937414','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2021-8-27','41','4708.95665561734','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2021-9-27','42','4472.98149937351','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2021-10-27','43','4235.7281443667','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2021-11-27','44','3997.18966702027','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('6','2021-12-27','45','3757.35910625488','1338JW86745H6764H','261.482004795088','2');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2018-2-23','1','15279.2591807118','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2018-3-23','2','14987.1857993353','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2018-4-23','3','14693.773748294','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2018-5-23','4','14399.0168920189','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2018-6-23','5','14102.9090668191','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2018-7-23','6','13805.4440807539','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2018-8-23','7','13506.6157135025','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2018-9-23','8','13206.4177162345','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2018-10-23','9','12904.8438114791','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2018-11-23','10','12601.8876929935','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2018-12-23','11','12297.5430256316','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2019-1-23','12','11991.8034452109','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2019-2-23','13','11684.6625583799','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2019-3-23','14','11376.1139424843','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2019-4-23','15','11066.1511454325','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2019-5-23','16','10754.7676855609','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2019-6-23','17','10441.9570514982','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2019-7-23','18','10127.7127020294','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2019-8-23','19','9812.02806595886','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2019-9-23','20','9494.89654197298','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2019-10-23','21','9176.31149850219','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2019-11-23','22','8856.26627358215','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2019-12-23','23','8534.75417471455','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2020-1-23','24','8211.76847872716','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2020-2-23','25','7887.30243163314','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2020-3-23','26','7561.34924848996','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2020-4-23','27','7233.90211325736','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2020-5-23','28','6904.95417865494','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2020-6-23','29','6574.49856601893','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2020-7-23','30','6242.52836515835','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2020-8-23','31','5909.03663421048','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2020-9-23','32','5574.01639949576','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2020-10-23','33','5237.46065537193','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2020-11-23','34','4899.36236408755','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2020-12-23','35','4559.71445563477','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2021-1-23','36','4218.50982760158','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2021-2-23','37','3875.74134502325','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2021-3-23','38','3531.4018402331','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2021-4-23','39','3185.48411271265','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2021-5-23','40','2837.98092894108','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2021-6-23','41','2488.88502224388','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2021-7-23','42','2138.189092641','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2021-8-23','43','1785.88580669409','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2021-9-23','44','1431.96779735325','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2021-10-23','45','1076.42766380295','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2021-11-23','46','719.257971307201','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('7','2021-12-23','47','360.451251054182','6079CA72392O1522A','362.103319288177','1');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2017-8-5','1','11279.3709070714','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2017-9-5','2','11063.7580974669','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2017-10-5','3','10847.157062485','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2017-11-5','4','10629.5632727595','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2017-12-5','5','10410.9721781644','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2018-1-5','6','10191.379207719','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2018-2-5','7','9970.77976949245','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2018-3-5','8','9749.16925050736','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2018-4-5','9','9526.54301664359','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2018-5-5','10','9302.89641254128','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2018-6-5','11','9078.22476150349','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2018-7-5','12','8852.52336539844','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2018-8-5','13','8625.78750456125','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2018-9-5','14','8398.01243769523','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2018-10-5','15','8169.19340177273','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2018-11-5','16','7939.32561193558','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2018-12-5','17','7708.40426139501','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2019-1-5','18','7476.42452133114','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2019-2-5','19','7243.38154079198','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2019-3-5','20','7009.270446592','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2019-4-5','21','6774.08634321028','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2019-5-5','22','6537.82431268807','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2019-6-5','23','6300.47941452595','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2019-7-5','24','6062.0466855806','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2019-8-5','25','5822.52113996091','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2019-9-5','26','5581.89776892381','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2019-10-5','27','5340.17154076943','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2019-11-5','28','5097.33740073602','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2019-12-5','29','4853.39027089413','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2020-1-5','30','4608.32505004046','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2020-2-5','31','4362.13661359122','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2020-3-5','32','4114.8198134749','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2020-4-5','33','3866.36947802473','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2020-5-5','34','3616.78041187041','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2020-6-5','35','3366.04739582955','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2020-7-5','36','3114.1651867985','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2020-8-5','37','2861.12851764273','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2020-9-5','38','2606.93209708666','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2020-10-5','39','2351.57060960303','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2020-11-5','40','2095.03871530178','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2020-12-5','41','1837.33104981831','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2021-1-5','42','1578.44222420139','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2021-2-5','43','1318.36682480038','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2021-3-5','44','1057.0994131521','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2021-4-5','45','794.634525867121','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2021-5-5','46','530.966674515412','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2021-6-5','47','266.090345511674','1982XQ68267P6675U','267.309926261933','8');
insert into Monthly_Payments (dw_invoice_id, payment_date,nth_payment,current_balance, vin, payment_amount, dw_customer_id) VALUES('8','2021-7-5','48','0','1982XQ68267P6675U','267.309926261933','8');





create table Test_Drives(
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



insert into Test_Drives(dw_customer_id, test_drive_date,check_out_time, return_time, vin) VALUES('1','2016-7-5','2016-7-5 10:18:00','2016-7-5 11:21:00','4460MI52854L5943H');
insert into Test_Drives(dw_customer_id, test_drive_date,check_out_time, return_time, vin) VALUES('2','2018-11-3','2018-11-3 14:52:00','2018-11-3 15:42:00','4885GJ44400M3281H');
insert into Test_Drives(dw_customer_id, test_drive_date,check_out_time, return_time, vin) VALUES('3','2020-8-28','2020-8-28 15:24:00','2020-8-28 16:58:00','5993EW69518D9743K');
insert into Test_Drives(dw_customer_id, test_drive_date,check_out_time, return_time, vin) VALUES('2','2018-1-1','2018-1-1 15:23:00','2018-1-1 16:44:00','7651OI63100J7411X');
insert into Test_Drives(dw_customer_id, test_drive_date,check_out_time, return_time, vin) VALUES('1','2018-3-16','2018-3-16 11:38:00','2018-3-16 12:48:00','1338JW86745H6764H');






create table Projection_Months(
   eom_dt date NOT NULL,
   PRIMARY KEY ( eom_dt )
);


insert into Projection_Months(eom_dt) VALUES('2016-1-31');
insert into Projection_Months(eom_dt) VALUES('2016-2-29');
insert into Projection_Months(eom_dt) VALUES('2016-3-31');
insert into Projection_Months(eom_dt) VALUES('2016-4-30');
insert into Projection_Months(eom_dt) VALUES('2016-5-31');
insert into Projection_Months(eom_dt) VALUES('2016-6-30');
insert into Projection_Months(eom_dt) VALUES('2016-7-31');
insert into Projection_Months(eom_dt) VALUES('2016-8-31');
insert into Projection_Months(eom_dt) VALUES('2016-9-30');
insert into Projection_Months(eom_dt) VALUES('2016-10-31');
insert into Projection_Months(eom_dt) VALUES('2016-11-30');
insert into Projection_Months(eom_dt) VALUES('2016-12-31');
insert into Projection_Months(eom_dt) VALUES('2017-1-31');
insert into Projection_Months(eom_dt) VALUES('2017-2-28');
insert into Projection_Months(eom_dt) VALUES('2017-3-31');
insert into Projection_Months(eom_dt) VALUES('2017-4-30');
insert into Projection_Months(eom_dt) VALUES('2017-5-31');
insert into Projection_Months(eom_dt) VALUES('2017-6-30');
insert into Projection_Months(eom_dt) VALUES('2017-7-31');
insert into Projection_Months(eom_dt) VALUES('2017-8-31');
insert into Projection_Months(eom_dt) VALUES('2017-9-30');
insert into Projection_Months(eom_dt) VALUES('2017-10-31');
insert into Projection_Months(eom_dt) VALUES('2017-11-30');
insert into Projection_Months(eom_dt) VALUES('2017-12-31');
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
insert into Projection_Months(eom_dt) VALUES('2023-1-31');
insert into Projection_Months(eom_dt) VALUES('2023-2-28');
insert into Projection_Months(eom_dt) VALUES('2023-3-31');
insert into Projection_Months(eom_dt) VALUES('2023-4-30');
insert into Projection_Months(eom_dt) VALUES('2023-5-31');
insert into Projection_Months(eom_dt) VALUES('2023-6-30');
insert into Projection_Months(eom_dt) VALUES('2023-7-31');
insert into Projection_Months(eom_dt) VALUES('2023-8-31');
insert into Projection_Months(eom_dt) VALUES('2023-9-30');
insert into Projection_Months(eom_dt) VALUES('2023-10-31');
insert into Projection_Months(eom_dt) VALUES('2023-11-30');
insert into Projection_Months(eom_dt) VALUES('2023-12-31');
insert into Projection_Months(eom_dt) VALUES('2024-1-31');
insert into Projection_Months(eom_dt) VALUES('2024-2-29');
insert into Projection_Months(eom_dt) VALUES('2024-3-31');
insert into Projection_Months(eom_dt) VALUES('2024-4-30');
insert into Projection_Months(eom_dt) VALUES('2024-5-31');
insert into Projection_Months(eom_dt) VALUES('2024-6-30');
insert into Projection_Months(eom_dt) VALUES('2024-7-31');
insert into Projection_Months(eom_dt) VALUES('2024-8-31');
insert into Projection_Months(eom_dt) VALUES('2024-9-30');
insert into Projection_Months(eom_dt) VALUES('2024-10-31');
insert into Projection_Months(eom_dt) VALUES('2024-11-30');
insert into Projection_Months(eom_dt) VALUES('2024-12-31');
insert into Projection_Months(eom_dt) VALUES('2025-1-31');
insert into Projection_Months(eom_dt) VALUES('2025-2-28');
insert into Projection_Months(eom_dt) VALUES('2025-3-31');
insert into Projection_Months(eom_dt) VALUES('2025-4-30');
insert into Projection_Months(eom_dt) VALUES('2025-5-31');
insert into Projection_Months(eom_dt) VALUES('2025-6-30');
insert into Projection_Months(eom_dt) VALUES('2025-7-31');
insert into Projection_Months(eom_dt) VALUES('2025-8-31');
insert into Projection_Months(eom_dt) VALUES('2025-9-30');
insert into Projection_Months(eom_dt) VALUES('2025-10-31');
insert into Projection_Months(eom_dt) VALUES('2025-11-30');
insert into Projection_Months(eom_dt) VALUES('2025-12-31');
insert into Projection_Months(eom_dt) VALUES('2026-1-31');
insert into Projection_Months(eom_dt) VALUES('2026-2-28');
insert into Projection_Months(eom_dt) VALUES('2026-3-31');
insert into Projection_Months(eom_dt) VALUES('2026-4-30');
insert into Projection_Months(eom_dt) VALUES('2026-5-31');
insert into Projection_Months(eom_dt) VALUES('2026-6-30');
insert into Projection_Months(eom_dt) VALUES('2026-7-31');
insert into Projection_Months(eom_dt) VALUES('2026-8-31');
insert into Projection_Months(eom_dt) VALUES('2026-9-30');
insert into Projection_Months(eom_dt) VALUES('2026-10-31');
insert into Projection_Months(eom_dt) VALUES('2026-11-30');
insert into Projection_Months(eom_dt) VALUES('2026-12-31');
insert into Projection_Months(eom_dt) VALUES('2027-1-31');
insert into Projection_Months(eom_dt) VALUES('2027-2-28');
insert into Projection_Months(eom_dt) VALUES('2027-3-31');
insert into Projection_Months(eom_dt) VALUES('2027-4-30');
insert into Projection_Months(eom_dt) VALUES('2027-5-31');
insert into Projection_Months(eom_dt) VALUES('2027-6-30');
insert into Projection_Months(eom_dt) VALUES('2027-7-31');
insert into Projection_Months(eom_dt) VALUES('2027-8-31');
insert into Projection_Months(eom_dt) VALUES('2027-9-30');
insert into Projection_Months(eom_dt) VALUES('2027-10-31');
insert into Projection_Months(eom_dt) VALUES('2027-11-30');
insert into Projection_Months(eom_dt) VALUES('2027-12-31');
insert into Projection_Months(eom_dt) VALUES('2028-1-31');
insert into Projection_Months(eom_dt) VALUES('2028-2-29');
insert into Projection_Months(eom_dt) VALUES('2028-3-31');
insert into Projection_Months(eom_dt) VALUES('2028-4-30');
insert into Projection_Months(eom_dt) VALUES('2028-5-31');
insert into Projection_Months(eom_dt) VALUES('2028-6-30');
insert into Projection_Months(eom_dt) VALUES('2028-7-31');
insert into Projection_Months(eom_dt) VALUES('2028-8-31');
insert into Projection_Months(eom_dt) VALUES('2028-9-30');
insert into Projection_Months(eom_dt) VALUES('2028-10-31');
insert into Projection_Months(eom_dt) VALUES('2028-11-30');
insert into Projection_Months(eom_dt) VALUES('2028-12-31');
insert into Projection_Months(eom_dt) VALUES('2029-1-31');
insert into Projection_Months(eom_dt) VALUES('2029-2-28');
insert into Projection_Months(eom_dt) VALUES('2029-3-31');
insert into Projection_Months(eom_dt) VALUES('2029-4-30');
insert into Projection_Months(eom_dt) VALUES('2029-5-31');
insert into Projection_Months(eom_dt) VALUES('2029-6-30');
insert into Projection_Months(eom_dt) VALUES('2029-7-31');
insert into Projection_Months(eom_dt) VALUES('2029-8-31');
insert into Projection_Months(eom_dt) VALUES('2029-9-30');
insert into Projection_Months(eom_dt) VALUES('2029-10-31');
insert into Projection_Months(eom_dt) VALUES('2029-11-30');
insert into Projection_Months(eom_dt) VALUES('2029-12-31');
insert into Projection_Months(eom_dt) VALUES('2030-1-31');
insert into Projection_Months(eom_dt) VALUES('2030-2-28');
insert into Projection_Months(eom_dt) VALUES('2030-3-31');
insert into Projection_Months(eom_dt) VALUES('2030-4-30');
insert into Projection_Months(eom_dt) VALUES('2030-5-31');
insert into Projection_Months(eom_dt) VALUES('2030-6-30');
insert into Projection_Months(eom_dt) VALUES('2030-7-31');
insert into Projection_Months(eom_dt) VALUES('2030-8-31');
insert into Projection_Months(eom_dt) VALUES('2030-9-30');
insert into Projection_Months(eom_dt) VALUES('2030-10-31');
insert into Projection_Months(eom_dt) VALUES('2030-11-30');
insert into Projection_Months(eom_dt) VALUES('2030-12-31');





