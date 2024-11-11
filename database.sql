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

CREATE TABLE MENU(
  Menu_ID INT PRIMARY KEY,
  Menu_Name VARCHAR(30)
);


CREATE TABLE BRANCH(
  Branch_Code INT PRIMARY KEY,
  City VARCHAR(30),
  Neighborhood VARCHAR(30),
  Street VARCHAR(30),
  Capacity INT CHECK (Capacity BETWEEN 30 AND 200),
  Menu_ID int,
  FOREIGN KEY (Menu_ID) REFERENCES MENU(Menu_ID)
);


 CREATE TABLE EMPLOYEE(
  Employee_ID INT PRIMARY KEY,
  Employee_Name VARCHAR(30) NOT NULL,
  Age INT(2),
  Gender VARCHAR(1)  CHECK (Gender= "M" OR Gender= "F" ),
  Phone_Number VARCHAR(15),
  Email VARCHAR(30),
  Employee_position VARCHAR(30),
  National_Address INT(10),
  Salary FLOAT CHECK (Salary BETWEEN 4000 AND 16000),
  Branch_Code int ,
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
  Quantiti int,
  PRIMARY KEY (Dish_code, Order_Number),
  FOREIGN KEY (Dish_code) REFERENCES DISH(Dish_code),
  FOREIGN KEY (Order_Number) REFERENCES ORDERS(Order_Number)
);


CREATE TABLE CUSTOMER(
  Phone_Number INT PRIMARY KEY,
  Customer_Name VARCHAR(30),
   CONSTRAINT phone_number_check CHECK (Phone_Number REGEXP '^966[0-9]{9}$')
);


CREATE TABLE BILL(
  Bill_Number INT PRIMARY KEY,
  Total_price FLOAT DEFAULT 0.0,
  Payment_method VARCHAR(30),
  State BOOLEAN NOT NULL,
  CONSTRAINT state_check CHECK (State=true),
  Bill_Time TIME DEFAULT '07:00:00',
  Bill_Date DATE ,
  Offer DECIMAL(5,2) DEFAULT 0.00 ,
  Order_Number INT, 
  FOREIGN KEY (Order_Number) REFERENCES ORDERS(Order_Number)
);
DELIMITER //
CREATE TRIGGER Set_Bill_Date
BEFORE INSERT ON BILL
FOR EACH ROW
BEGIN
   IF NEW.Bill_Date IS NULL THEN
      SET NEW.Bill_Date = CURRENT_DATE();  -- Set current date if Bill_Date is not provided
   END IF;
END $$


CREATE TRIGGER Calculate_Total_Price
BEFORE INSERT ON BILL
FOR EACH ROW
BEGIN
    DECLARE Base_Total_Price FLOAT;

    -- Calculate the total price of all dishes in the order
    SELECT SUM(D.Price)
    INTO base_total_price
    FROM DISH_TO_PICK_ORDER DPO
    JOIN DISH D ON D.Dish_code = DPO.Dish_code
    WHERE DPO.Order_Number = NEW.Order_Number;

    -- Apply the offer/discount (if any)
    IF NEW.Offer > 0 THEN
        SET NEW.Total_price = base_total_price * (1 - NEW.Offer / 100);
    ELSE
        SET NEW.Total_price = base_total_price;
    END IF;
    
    -- If no offer is applied, the total remains the same
END $$

DELIMITER ;

CREATE TABLE CUSTOMER_REQUEST_ORDER(
  Phone_Number INT CHECK (Phone_Number REGEXP '^966[0-9]{9}$'),
  Order_Number INT,
  PRIMARY KEY (Phone_Number, Order_Number),
  FOREIGN KEY (Phone_Number) REFERENCES CUSTOMER(Phone_Number),
  FOREIGN KEY (Order_Number) REFERENCES ORDERS(Order_Number)
);

INSERT INTO BRANCH (Branch_Code , City , Neighborhood , Street , Capacity, Manager_ID, Menu_ID)
values
    (1, 'Riyadh', 'Al-Sulaimaniya', 'King Saud Road', 100,null,1),
    (2, 'Riyadh', 'Alaqiq', 'Kafd ring roud', 150,null,1),
    (3, 'Riyadh', 'alsafarat', 'Alkhawaba', 100, null,1);
    
INSERT INTO EMPLOYEE  (Employee_ID, Employee_Name, Age, Gender, Phone_Number, Email, Employee_position, National_Address, salary, Branch_code)
VALUES
    (12534, 'Lama', 26, 'F', '966599777888', 'lama123@gmail.com', 'Manager', 23456, 12000,1),  
    (12536, 'Hanin', 20, 'F', '966599899399', 'hanin123@gmail.com', 'Chef', 12345, 10000,1),  
	(12537, 'Nouf', 30, 'F', '966599666777', 'nouf_barista@gmail.com', 'Barista', 34567, 9000,1),
	(12540, 'khaled', 25, 'M', '966599555666', 'khaled123@gmail.com', 'Cashier', 45678, 8500,1),  
    (12535, 'Fay', 26, 'F', '966599777253', 'fay_123@gmail.com', 'Manager', 45363, 12000,2),  
    (12539, 'Yasser', 20, 'M', '966599899334', 'yasser123@gmail.com', 'Chef', 97865, 10000,2),  
	(12538, 'Yara', 30, 'F', '966599666745', 'yara353@gmail.com', 'Barista', 12323, 9000,2),
	(12541, 'Nawaf', 25, 'M', '966599555667', 'Nawaf45@gmail.com', 'Cashier', 98675, 8500,2),
    (12522, 'Ahmed', 28, 'M', '966598888345', 'ahmed_123@gmail.com', 'Manager', 34521, 12000,3),  
	(12523, 'Omar', 35, 'M', '966599444963', 'omar_chef@gmail.com', 'Chef', 76859, 10000,3),
	(12524, 'Demma', 30, 'F', '966599666711', 'domo@gmail.com', 'Barista', 49374, 9000,3),
    (12525, 'noura', 24, 'F', '966599555634', 'noura123@gmail.com', 'Cashier', 98743, 8500,3); 
    

UPDATE BRANCH
SET Manager_ID = 12535  
WHERE Branch_Code = 2;

UPDATE BRANCH
SET Manager_ID = 12522  
WHERE Branch_Code = 3;


UPDATE BRANCH
SET Manager_ID = 12534  
WHERE Branch_Code = 1;

INSERT INTO MENU  (Menu_ID , Menu_Name)
values
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
   (12, 'Shakes', 'Acia', 'Coconut Drink, Avocado, Banana, Peanut Butter, Ice, Acai', 29, 360,1),
   (13, 'Juices', 'GO Away DOC', 'Carrot, Ginger,Apple,Olive Oil, Ice', 29, 177,1),
   (14, 'Juices', 'Green Tonic', 'Kale, Celert, Cucumber, Olive', 29, 70,1),
   (15, 'Hot Coffe', 'Pink late', 'Regular Mile, Espresso, ', 18, 243,1),
   (16, 'Cold Coffe', 'Iced Vanilla Matcha', 'Vanilla Syrup, Matcha Regular Milk, Ice', 24, 204,1),
   (17, 'Snacks & Treats', 'Blueberry Muffin', 'Blueberry Muffin', 16, 306,1),
   (18, 'Shots', 'Ginger Shot', 'Apple, Ice, Ginger', 10, 25,1);


SELECT *   
FROM BRANCH
