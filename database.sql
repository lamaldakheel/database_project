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
INSERT INTO EMPLOYEE  (Employee_ID, Employee_Name, Age, Gender, Phone_Number, Email, Employee_position, National_Address, salary)
VALUES
    (12534, 'Lama', 26, 'F', '0599777888', 'lama@gmail.com', 'Manager', 23456, 12000),  

    (12536, 'Fay', 20, 'F', '0599899399', 'fay_123@gmail.com', 'Chef', 12345, 10000),  

    (12535, 'Ahmed', 28, 'M', '0598888777', 'ahmed_123@gmail.com', 'Assistant Manager', 67890, 11000),  

    (12537, 'Nouf', 30, 'F', '0599666777', 'nouf_barista@gmail.com', 'Barista', 34567, 9000),  

    (12538, 'Yara', 24, 'F', '0599555666', 'yara_cashier@gmail.com', 'Cashier', 45678, 8500),  

    (12539, 'Omar', 35, 'M', '0599444555', 'omar_chef@gmail.com', 'Chef', 56789, 12000);
    
INSERT INTO BRANCH (Branch_Code , City , Neighborhood , Street , Capacity)
values
 (1, 'Riyadh', 'Al-Sulaimaniya', 'King Saud Road', 100),
 (2, 'Riyadh', 'Alaqiq', 'Kafd ring roud', 150),
 (3, 'Riyadh', 'alsafarat', 'Alkhawaba', 100);

INSERT INTO MENU  (Menu_ID , Menu_Name)
value
(1, 'Main Menu');  

INSERT INTO DISH  (Dish_code ,Category, Dish_Name, Dish_description, Price, Calories)
values
 (1, 'Sandwich', 'Spicy Tuna', 'Tuna, spices, and veggies', 29, 300),
 (2, 'Sandwich', 'Avocado', 'Avocado, modzarella, tomatos, pesto ', 29, 485),
 (3, 'Sandwich', 'joes club', 'chicken, avocado,tomatos, pesto', 29, 430),
 (4, 'Salad bowl', 'Green tuna ', 'Lemon, Spinach, Cranberry, Pumpkin Seeds, Pickled Red Onion, Edamame, Tuna, Cucumber, Kale, Pesto ', 36, 560), 
 (5, 'protein shakes', 'Beets & Berries', 'Strawberries, Beetroot Powder, Banana, Date Puree, Ice, Whey Protein', 33, 370),
 (6, 'shakes', 'Power Shake', 'Vanilla Milk, Strawberries, Banana, Ice', 24,290 ), 
 (7, 'Shakes', 'Acia', 'Coconut Drink, Avocado, Banana, Peanut Butter, Ice, Acai', '29', 360);


SELECT *   
FROM EMPLOYEE 
