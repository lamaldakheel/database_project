CREATE TABLE CUSTOMER_REQUEST_ORDER(
  Phone_Number INT,
  Order_Number INT,
  PRIMARY KEY (Phone_Number, Order_Number),
  FOREIGN KEY (Phone_Number) REFERENCES CUSTOMER(Phone_Number),
  FOREIGN KEY (Order_Number) REFERENCES ORDERS(Order_Number)
);

INSERT INTO BRANCH (Branch_Code , City , Neighborhood , Street , Capacity, Manager_ID)
values
    (1, 'Riyadh', 'Al-Sulaimaniya', 'King Saud Road', 100,NULL),
    (2, 'Riyadh', 'Alaqiq', 'Kafd ring roud', 150,NULL),
    (3, 'Riyadh', 'alsafarat', 'Alkhawaba', 100, NULL);
    
INSERT INTO EMPLOYEE  (Employee_ID, Employee_Name, Age, Gender, Phone_Number, Email, Employee_position, National_Address, salary, Branch_code)
VALUES
    (12534, 'Lama', 26, 'F', '0599777888', 'lama@gmail.com', 'Manager', 23456, 12000,1),  
    (12536, 'Fay', 20, 'F', '0599899399', 'fay_123@gmail.com', 'Chef', 12345, 10000,2),  
    (12535, 'Ahmed', 28, 'M', '0598888777', 'ahmed_123@gmail.com', 'Assistant Manager', 67890, 11000,2),  
    (12537, 'Nouf', 30, 'F', '0599666777', 'nouf_barista@gmail.com', 'Barista', 34567, 9000,1),  
    (12538, 'Yara', 24, 'F', '0599555666', 'yara_cashier@gmail.com', 'Cashier', 45678, 8500,3),  
    (12539, 'Omar', 35, 'M', '0599444555', 'omar_chef@gmail.com', 'Chef', 56789, 12000,3);
    
UPDATE BRANCH
SET Manager_ID = 12536  
WHERE Branch_Code = 2;

UPDATE BRANCH
SET Manager_ID = 12534  
WHERE Branch_Code = 3;


UPDATE BRANCH
SET Manager_ID = 12534  
WHERE Branch_Code = 3;

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
   (7, 'Shakes', 'Acia', 'Coconut Drink, Avocado, Banana, Peanut Butter, Ice, Acai', '29', 360),
   (8, 'Juices', 'GO Away DOC', 'Carrot, Ginger,Apple,Olive Oil, Ice', '29', 177),
   (9, 'Juices', 'Green Tonic', 'Kale, Celert, Cucumber, Olive', '29', 70),
   (10, 'Hot Coffe', 'Pink late', 'Regular Mile, Espresso, ', '18', 243),
   (11, 'Cold Coffe', 'Iced Vanilla Matcha', 'Vanilla Syrup, Matcha Regular Milk, Ice', '24', 204),
   (12, 'Snacks & Treats', 'Blueberry Muffin', 'Blueberry Muffin', '16', 306),
   (13, 'Shots', 'Ginger Shot', 'Apple, Ice, Ginger', '10', 25);


SELECT *   
FROM BRANCH

