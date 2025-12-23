CREATE DATABASE Dominos;
USE Dominos;

CREATE TABLE customers(
customer_id INT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE,
city VARCHAR(50)
);

INSERT INTO customers(customer_id,name,email,city) VALUES
("1", 'Rahul', 'rahul@gmail.com', 'Mumbai'),
("2", 'Ananya', 'ananya@gmail.com', 'Delhi'),
("3", 'Aman', 'aman@gmail.com', 'Pune'),
("4", 'Sneha', 'sneha@gmail.com', 'Chennai'),
("5", 'Karan', 'karan@gmail.com', 'Ahmedabad'),
("6", 'Priya', 'priya@gmail.com', 'Bhopal'),
("7", 'Rohan', 'rohan@gmail.com', 'Kolkata'),
("8", 'Neha', 'neha@gmail.com', 'Jaipur'),
("9", 'Arjun', 'arjun@gmail.com', 'Surat'),
("10", "Pooja","pooja@gmail,com","Nashik");


CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT,
food_item VARCHAR(50) NOT NULL,
amount INT 
);

INSERT INTO Orders (order_id, customer_id, food_item, amount) VALUES
(101, 1, 'Pizza', 400),
(102, 1, 'Burger', 180),
(103, 2, 'Momos', 200),
(104, 3, 'Pasta', 300),
(105, 4, 'Dosa', 120),
(106, 5, 'Biryani', 350),
(107, 6, 'Sandwich', 150),
(108, 6, 'Ice Cream', 160),
(109, 11, 'Fried Rice', 280),
(110, 12, 'Noodles', 220);
