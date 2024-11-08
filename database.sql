create database  JoeAndTheJoes;

create table EMPLOYEE(
Employee_ID int primary key ,
Employee_Name varchar(30) ,
Age int ,
Gneder varchar(1),
Phone_Number int,
Email varchar(30),
Employee_position varchar(30),
National_Address int,
salary float ,
foreign key(Branch_Code) references BRANCH(Branch_Code)
);

create table BRANCH(
Branch_Code int primary key ,
City varchar(30) ,
Neighborhood varchar(30),
Street varchar(30),
capacity int ,
foreign key(Employee_ID) references EMPLOYEE(Employee_ID),
foreign key(Menu_ID) references MENU(Menu_ID)
);

create table BRANCH_TIME(
Open_time varchar(5),
close_time varchar(5),
foreign key(Branch_Code) references BRANCH (Branch_Code)
);

create table MENU(
Menu_ID int  primary key ,
Menu_Name varchar(30)
);

create table DISH(
Dish_code int primary key ,
Category varchar(30),
Dish_Name varchar(30),
Dish_description varchar(150),
price float ,
calories float ,
foreign key(Menu_ID) references MENU(Menu_ID)
);

create table ORDERS(
Order_Number int primary key,
Place varchar(30)
);

create table ORDER_DISH(
Dishs_Name varchar(30),
Dishs_Price float,
quantity int,
foreign key (Order_Number) references ORDERS(Order_Number)
);



