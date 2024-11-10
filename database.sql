
DROP DATABASE IF EXISTS JoeAndTheJoes;
CREATE DATABASE JoeAndTheJoes;
USE JoeAndTheJoes;

DROP TABLE IF EXISTS BRANCH;
DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS MENU;
DROP TABLE IF EXISTS ORDERS;
DROP TABLE IF EXISTS BRANCH_TIME;
DROP TABLE IF EXISTS CUSTOMER;
DROP TABLE IF EXISTS BILL;
DROP TABLE IF EXISTS CUSTOMER_REQUEST_ORDER;
DROP TABLE IF EXISTS DISH_TO_PICK_ORDER;



CREATE TABLE BRANCH(
  Branch_Code INT PRIMARY KEY,
  City VARCHAR(30),
  Neighborhood VARCHAR(30),
  Street VARCHAR(30),
  Capacity INT CHECK (Capacity BETWEEN 30 AND 70)
);


 CREATE TABLE EMPLOYEE(
  Employee_ID INT PRIMARY KEY,
  Employee_Name VARCHAR(30) NOT NULL,
  Age INT(2),
  Gender VARCHAR(1)  CHECK (Gender= "M" OR Gender= "F" ),
  Phone_Number INT(10),
  Email VARCHAR(30),
  Employee_position VARCHAR(30),
  National_Address INT(10),
  Salary FLOAT CHECK (Salary BETWEEN 4000 AND 16000),
  Branch_Code INT,
  FOREIGN KEY (Branch_Code) REFERENCES BRANCH(Branch_Code)
);


ALTER TABLE BRANCH
ADD Manager_ID INT;

ALTER TABLE BRANCH
ADD CONSTRAINT fk_branch_manager FOREIGN KEY (Manager_ID) REFERENCES EMPLOYEE(Employee_ID);

DELIMITER //
CREATE TRIGGER check_min_employees_before_delete
BEFORE DELETE ON EMPLOYEE
FOR EACH ROW
BEGIN
  IF (SELECT COUNT(*) FROM EMPLOYEE WHERE Branch_Code = OLD.Branch_Code) <= 4 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Cannot delete employee. The branch must have at least 4 employees.';
  END IF;
END; //

DELIMITER ;

CREATE TABLE MENU(
  Menu_ID INT PRIMARY KEY,
  Menu_Name VARCHAR(30)
);


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


CREATE TABLE ORDERS(
  Order_Number INT PRIMARY KEY,
  Place VARCHAR(30) 
);


CREATE TABLE DISH_TO_PICK_ORDER(
  Dish_code INT,
  Order_Number INT,
  PRIMARY KEY (Dish_code, Order_Number),
  FOREIGN KEY (Dish_code) REFERENCES DISH(Dish_code),
  FOREIGN KEY (Order_Number) REFERENCES ORDERS(Order_Number)
);
  

CREATE TABLE CUSTOMER(
  Phone_Number INT PRIMARY KEY,
  Customer_Name VARCHAR(30)
);


CREATE TABLE BILL(
  Bill_Number INT PRIMARY KEY,
  Total_price FLOAT,
  Payment_method VARCHAR(30),
  State VARCHAR(10),
  Bill_Date VARCHAR(10),
  Bill_Time time,
  Offer INT,
  Order_Number INT,
  FOREIGN KEY (Order_Number) REFERENCES ORDERS(Order_Number)
);


CREATE TABLE CUSTOMER_REQUEST_ORDER(
  Phone_Number INT,
  Order_Number INT,
  PRIMARY KEY (Phone_Number, Order_Number),
  FOREIGN KEY (Phone_Number) REFERENCES CUSTOMER(Phone_Number),
  FOREIGN KEY (Order_Number) REFERENCES ORDERS(Order_Number)
);

INSERT INTO BRANCH (Branch_Code , City , Neighborhood , Street , Capacity, Manager_ID)
values
    (1, 'Riyadh', 'Al-Sulaimaniya', 'King Saud Road', 40,NULL),
    (2, 'Riyadh', 'Alaqiq', 'Kafd ring roud', 60,NULL),
    (3, 'Riyadh', 'alsafarat', 'Alkhawaba', 60, NULL);
    
INSERT INTO EMPLOYEE  (Employee_ID, Employee_Name, Age, Gender, Phone_Number, Email, Employee_position, National_Address, salary, Branch_code)
VALUES
    (12534, 'Lama', 26, 'F', '0599777888', 'lama@gmail.com', 'Manager', 23456, 15000,1),  
    (12536, 'Fay', 20, 'F', '0599899399', 'fay_123@gmail.com', 'Manager', 12345, 15000,2),  
    (12535, 'Ahmed', 28, 'M', '0598888777', 'ahmed_123@gmail.com', 'Manager', 9890, 11000,2),  
    (12537, 'Nouf', 30, 'F', '0599666777', 'nouf_barista@gmail.com', 'Barista', 34567, 6000,1),  
    (12538, 'Yara', 24, 'F', '0599555666', 'yara_cashier@gmail.com', 'Cashier', 45678, 5000,3),  
    (12539, 'Omar', 35, 'M', '0599444555', 'omar_chef@gmail.com', 'Chef', 56789, 10000,3);
    
UPDATE BRANCH
SET Manager_ID = 12534  
WHERE Branch_Code = 2;

UPDATE BRANCH
SET Manager_ID = 12536  
WHERE Branch_Code = 3;


UPDATE BRANCH
SET Manager_ID = 12535  
WHERE Branch_Code = 1;

INSERT INTO MENU  (Menu_ID , Menu_Name)
value
   (1, 'Summer Menu'),
      (2, 'Winter Menu');  
		

INSERT INTO DISH  (Dish_code ,Category, Dish_Name, Dish_description, Price, Calories,Menu_ID)
values
   (1, 'Sandwich', 'Spicy Tuna', 'Tuna, Tomato, Jalapenos, Tabasco, Pesto', 29, 525,1),
   (2, 'Sandwich', 'Avocado', 'Avocado, Modzarella, Tomatos, Pesto ', 29, 485,1),
   (3, 'Sandwich', 'Joes Club', 'Chicken, Avocado, Tomatos, Pesto', 29, 448,1),
   (4, 'Sandwich', 'Tunacado', 'Tuna, Avocado, Tomato, Pesto', 29, 571,2),
   (5, 'Sandwich', 'Turkey', 'Turky, Mozzarella, Tomato, Pesto', 29,497,2),
   (6,'Sandwich', 'Spaicy Club', 'chicken, avocado,tomatos, pesto', 29, 451,2),
   (7, 'Sandwich', 'Halloumi', 'chicken, avocado,tomatos, pesto', 29, 642,2),
   (8, 'Sandwich', 'Bresaola', 'chicken, avocado,tomatos, pesto', 29, 411,1),
   (9, 'Salad bowl', 'Green tuna ', 'Lemon, Spinach, Cranberry, Pumpkin Seeds, Pickled Red Onion, Edamame, Tuna, Cucumber, Kale, Pesto ', 36, 560,1), 
   (10, 'protein shakes', 'Beets & Berries', 'Strawberries, Beetroot Powder, Banana, Date Puree, Ice, Whey Protein', 33, 370,1),
   (11, 'shakes', 'Power Shake', 'Vanilla Milk, Strawberries, Banana, Ice', 24,290,1 ), 
   (12, 'Shakes', 'Acia', 'Coconut Drink, Avocado, Banana, Peanut Butter, Ice, Acai', '29', 360,1),
   (13, 'Juices', 'GO Away DOC', 'Carrot, Ginger,Apple,Olive Oil, Ice', '29', 177,1),
   (14, 'Juices', 'Green Tonic', 'Kale, Celert, Cucumber, Olive', '29', 70,1),
   (15, 'Hot Coffe', 'Pink late', 'Regular Mile, Espresso, ', '18', 243,1),
   (16, 'Cold Coffe', 'Iced Vanilla Matcha', 'Vanilla Syrup, Matcha Regular Milk, Ice', '24', 204,1),
   (17, 'Snacks & Treats', 'Blueberry Muffin', 'Blueberry Muffin', '16', 306,1),
   (18, 'Shots', 'Ginger Shot', 'Apple, Ice, Ginger', '10', 25,1);


SELECT *   
FROM DISH
