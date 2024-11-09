DROP DATABASE IF EXISTS JoeAndTheJoes;
CREATE DATABASE JoeAndTheJoes;
USE JoeAndTheJoes;

DROP TABLE IF EXISTS BRANCH;
CREATE TABLE BRANCH(
  Branch_Code INT PRIMARY KEY,
  City VARCHAR(30),
  Neighborhood VARCHAR(30),
  Street VARCHAR(30),
  Capacity INT
);

DROP TABLE IF EXISTS EMPLOYEE;
CREATE TABLE EMPLOYEE(
  Employee_ID INT PRIMARY KEY,
  Employee_Name VARCHAR(30),
  Age INT,
  Gender VARCHAR(1),
  Phone_Number INT,
  Email VARCHAR(30),
  Employee_position VARCHAR(30),
  National_Address INT,
  Salary FLOAT,
  Branch_Code INT,
  FOREIGN KEY (Branch_Code) REFERENCES BRANCH(Branch_Code)
);



DROP TABLE IF EXISTS BRANCH_TIME;
CREATE TABLE BRANCH_TIME(
  Branch_Code INT PRIMARY KEY,
  Open_time VARCHAR(5),
  Close_time VARCHAR(5),
  FOREIGN KEY (Branch_Code) REFERENCES BRANCH(Branch_Code)
);

DROP TABLE IF EXISTS MENU;
CREATE TABLE MENU(
  Menu_ID INT PRIMARY KEY,
  Menu_Name VARCHAR(30)
);

DROP TABLE IF EXISTS DISH;
CREATE TABLE DISH(
  Dish_code INT PRIMARY KEY,
  Category VARCHAR(30),
  Dish_Name VARCHAR(30),
  Dish_description VARCHAR(150),
  Price FLOAT,
  Calories FLOAT,
  Menu_ID INT,
  FOREIGN KEY (Menu_ID) REFERENCES MENU(Menu_ID)
);

DROP TABLE IF EXISTS ORDERS;
CREATE TABLE ORDERS(
  Order_Number INT PRIMARY KEY,
  Place VARCHAR(30)
);

DROP TABLE IF EXISTS ORDER_DISH;
CREATE TABLE ORDER_DISH(
  Order_Number INT,
  Dishes_Name VARCHAR(30),
  Dishes_Price FLOAT,
  Quantity INT,
  PRIMARY KEY (Order_Number, Dishes_Name),
  FOREIGN KEY (Order_Number) REFERENCES ORDERS(Order_Number)
);

DROP TABLE IF EXISTS DISH_TO_PICK_ORDER;
CREATE TABLE DISH_TO_PICK_ORDER(
  Dish_code INT,
  Order_Number INT,
  PRIMARY KEY (Dish_code, Order_Number),
  FOREIGN KEY (Dish_code) REFERENCES DISH(Dish_code),
  FOREIGN KEY (Order_Number) REFERENCES ORDERS(Order_Number)
);

DROP TABLE IF EXISTS CUSTOMER;
CREATE TABLE CUSTOMER(
  Phone_Number INT PRIMARY KEY,
  Customer_Name VARCHAR(30)
);

DROP TABLE IF EXISTS BILL;
CREATE TABLE BILL(
  Bill_Number INT PRIMARY KEY,
  Total_price FLOAT,
  Payment_method VARCHAR(30),
  State VARCHAR(10),
  Bill_Date VARCHAR(10),
  Bill_Hour INT,
  Bill_Minute INT,
  Offer INT,
  Order_Number INT,
  FOREIGN KEY (Order_Number) REFERENCES ORDERS(Order_Number)
);

DROP TABLE IF EXISTS CUSTOMER_REQUEST_ORDER;
CREATE TABLE CUSTOMER_REQUEST_ORDER(
  Phone_Number INT,
  Order_Number INT,
  PRIMARY KEY (Phone_Number, Order_Number),
  FOREIGN KEY (Phone_Number) REFERENCES CUSTOMER(Phone_Number),
  FOREIGN KEY (Order_Number) REFERENCES ORDERS(Order_Number)
);

insert into ORDERS (Order_Number, Place)
values
(100,"take away"),
(101,"tdine in"),
(102,"tdine in"),
(103,"tdine in"),
(103,"take away");
