-- Create the Admin table
CREATE TABLE Admin (
    Admin_id NUMBER(8) PRIMARY KEY,
    Admin_name VARCHAR2(15) NOT NULL,
    Admin_password VARCHAR2(16) NOT NULL
);

-- Create the Customer table
CREATE TABLE Customer (
    customer_id NUMBER(8) PRIMARY KEY,
    customer_firstname VARCHAR2(30) NOT NULL,
    customer_lastname VARCHAR2(30) NOT NULL,
    customer_password VARCHAR2(16) NOT NULL,
    customer_phoneno VARCHAR2(10) NOT NULL,
    customer_address VARCHAR2(50) NOT NULL,
    customer_email VARCHAR2(20) NOT NULL,
    Admin_id NUMBER(8),
    CONSTRAINT fk_Admin_id FOREIGN KEY (Admin_id) REFERENCES Admin(Admin_id)
);

-- Create the Restaurant table
CREATE TABLE Restaurant (
    Admin_id NUMBER(8),
    restaurant_id NUMBER(8) PRIMARY KEY,
    restaurant_name VARCHAR2(20) NOT NULL,
    restaurant_address VARCHAR2(50) NOT NULL,
    restaurant_password VARCHAR2(16) NOT NULL,
    restaurant_phoneno VARCHAR2(10) NOT NULL,
    CONSTRAINT fk_Restaurant_Admin_id FOREIGN KEY (Admin_id) REFERENCES Admin(Admin_id)
);

-- Create the Category table
CREATE TABLE Category (
    category_id NUMBER(8) PRIMARY KEY,
    category_name VARCHAR2(15) NOT NULL,
    restaurant_id NUMBER(8),
    CONSTRAINT fk_Category_Restaurant FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id)
);

-- Create the Menu_items table
CREATE TABLE Menu_items (
    item_code NUMBER(8) PRIMARY KEY,
    item_name VARCHAR2(20) NOT NULL,
    Price NUMBER(10,2) NOT NULL,
    category_id NUMBER(8),
    CONSTRAINT fk_MenuItems_Category FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

-- Create the Payment_details table
CREATE TABLE Payment_details (
    payment_id NUMBER(8) PRIMARY KEY,
    payment_mode VARCHAR2(15) NOT NULL,
    payment_timestamp TIMESTAMP NOT NULL
);

-- Create the Delivery_details table
CREATE TABLE Delivery_details (
    delivery_id NUMBER(8) PRIMARY KEY,
    delivery_address VARCHAR2(50) NOT NULL,
    delivery_status VARCHAR2(30) NOT NULL
);

-- Create the Order_details table
CREATE TABLE Order_details (
    Order_id NUMBER(8) PRIMARY KEY,
    Order_time TIMESTAMP NOT NULL,
    Order_amount NUMBER(10,2) NOT NULL,
    Order_status VARCHAR2(20) NOT NULL,
    customer_id NUMBER(8),
    delivery_id NUMBER(8),
    payment_id NUMBER(8),
    restaurant_id NUMBER(8),
    CONSTRAINT fk_OrderDetails_Customer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    CONSTRAINT fk_OrderDetails_Delivery FOREIGN KEY (delivery_id) REFERENCES Delivery_details(delivery_id),
    CONSTRAINT fk_OrderDetails_Payment FOREIGN KEY (payment_id) REFERENCES Payment_details(payment_id),
    CONSTRAINT fk_OrderDetails_Restaurant FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id)
);

-- Create the Orders table
CREATE TABLE Orders (
    quantity NUMBER(8) NOT NULL,
    Order_id NUMBER(8),
    item_code NUMBER(8),
    CONSTRAINT fk_Orders_OrderDetails FOREIGN KEY (Order_id) REFERENCES Order_details(Order_id),
    CONSTRAINT fk_Orders_MenuItems FOREIGN KEY (item_code) REFERENCES Menu_items(item_code)
);

-- Create the Rating table
CREATE TABLE Rating (
    ratings NUMBER(8) NOT NULL,
    customer_id NUMBER(8),
    restaurant_id NUMBER(8),
    CONSTRAINT fk_Rating_Customer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    CONSTRAINT fk_Rating_Restaurant FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id)
);

-- Insert values into Admin table
INSERT INTO Admin (Admin_id, Admin_name, Admin_password) 
VALUES (1, 'AdminOne', 'adminpass123');
INSERT INTO Admin (Admin_id, Admin_name, Admin_password) 
VALUES (2, 'AdminTwo', 'adminpass234');

-- Insert values into Customer table
INSERT INTO Customer (customer_id, customer_firstname, customer_lastname, customer_password, customer_phoneno, customer_address, customer_email, Admin_id) 
VALUES (101, 'John', 'Doe', 'custpass1234567', '9876543210', '123 Elm Street, City A', 'john.doe@mail.com', 1);
INSERT INTO Customer (customer_id, customer_firstname, customer_lastname, customer_password, customer_phoneno, customer_address, customer_email, Admin_id) 
VALUES (102, 'Jane', 'Smith', 'custpass2345678', '8765432190', '456 Oak Avenue, City B', 'jane.smith@mail.com', 2);

-- Insert values into Restaurant table
INSERT INTO Restaurant (Admin_id, restaurant_id, restaurant_name, restaurant_address, restaurant_password, restaurant_phoneno) 
VALUES (1, 201, 'DineSpot', '789 Cedar Road, City A', 'restpass1234567', '9988776655');
INSERT INTO Restaurant (Admin_id, restaurant_id, restaurant_name, restaurant_address, restaurant_password, restaurant_phoneno) 
VALUES (2, 202, 'FoodHub', '321 Maple Street, City B', 'restpass7654321', '8877665544');

-- Insert values into Category table
INSERT INTO Category (category_id, category_name, restaurant_id) 
VALUES (301, 'Starters', 201);
INSERT INTO Category (category_id, category_name, restaurant_id) 
VALUES (302, 'Entrees', 201);
INSERT INTO Category (category_id, category_name, restaurant_id) 
VALUES (303, 'Desserts', 202);

-- Insert values into Menu_items table
INSERT INTO Menu_items (item_code, item_name, Price, category_id) 
VALUES (401, 'Spring Rolls', 4.99, 301);
INSERT INTO Menu_items (item_code, item_name, Price, category_id) 
VALUES (402, 'Grilled Chicken', 12.49, 302);
INSERT INTO Menu_items (item_code, item_name, Price, category_id) 
VALUES (403, 'Cheesecake', 5.99, 303);

-- Insert values into Payment_details table
INSERT INTO Payment_details (payment_id, payment_mode, payment_timestamp) 
VALUES (501, 'Credit Card', SYSTIMESTAMP);
INSERT INTO Payment_details (payment_id, payment_mode, payment_timestamp) 
VALUES (502, 'Cash', SYSTIMESTAMP);

-- Insert values into Delivery_details table
INSERT INTO Delivery_details (delivery_id, delivery_address, delivery_status) 
VALUES (601, '123 Elm Street, City A', 'Delivered');
INSERT INTO Delivery_details (delivery_id, delivery_address, delivery_status) 
VALUES (602, '456 Oak Avenue, City B', 'Out for Delivery');

-- Insert values into Order_details table
INSERT INTO Order_details (Order_id, Order_time, Order_amount, Order_status, customer_id, delivery_id, payment_id, restaurant_id) 
VALUES (701, SYSTIMESTAMP, 20.98, 'Completed', 101, 601, 501, 201);
INSERT INTO Order_details (Order_id, Order_time, Order_amount, Order_status, customer_id, delivery_id, payment_id, restaurant_id) 
VALUES (702, SYSTIMESTAMP, 15.99, 'In Progress', 102, 602, 502, 202);

-- Insert values into Orders table
INSERT INTO Orders (quantity, Order_id, item_code) 
VALUES (2, 701, 401);
INSERT INTO Orders (quantity, Order_id, item_code) 
VALUES (1, 702, 402);

-- Insert values into Rating table
INSERT INTO Rating (ratings, customer_id, restaurant_id) 
VALUES (5, 101, 201);
INSERT INTO Rating (ratings, customer_id, restaurant_id) 
VALUES (4, 102, 202);

-- Display all table data
SELECT * FROM Admin;
SELECT * FROM Customer;
SELECT * FROM Restaurant;
SELECT * FROM Category;
SELECT * FROM Menu_items;
SELECT * FROM Payment_details;
SELECT * FROM Delivery_details;
SELECT * FROM Order_details;
SELECT * FROM Orders;
SELECT * FROM Rating;
