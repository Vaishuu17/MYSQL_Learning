CREATE DATABASE day1;
USE day1;
CREATE TABLE users(
id INT auto_increment primary key,
name varchar(100) not null,
email varchar(100) unique not null,
gender enum("male","female","other"),
date_of_birth date,
created_at timestamp default current_timestamp
);
select name, gender from users;

-- RENAMING A TABLE---
rename table users to customers;

# ALTERING A TABLE ----
alter table customers add column is_active boolean default true;
select * from customers;
alter table customers drop column is_active;
alter table customers modify column name varchar(150);
alter table customers modify column email varchar(150) after id;
alter table customers modify column date_of_birth date first;
select * from customers;

# INSERTING DATA INTO TABLES---
-- INSERT WITHOUT SPECIFING COLUMNS:
insert into customers values 
("2015-11-23",1,"alice1@gmail.com","alice","Male",default);
select * from customers;

-- INSERT BY SPECIFYING COLUMNS NAMES:
insert into customers (name,email,gender) values
("lily","lily4@gmail.com","Female");
select * from customers;

-- MULTIPLE ROWS AT A TIME 
insert into customers (date_of_birth,email,name,gender)values
("2005-09-24","yc6924@gmail.com","yc","Male"),
("2006-08-17","vivi@gmail.com","vivi","Female"),
("1990-11-23","harry1@gmail.com","harry","male"),
("2005-09-24","lily5@gmail.com","lily","female"),

("1909-8-12","bob6@gmail.com","bob","male"),
("1987-03-7","carry@gmail.com","carry","female"),
("2020-06-9","nick@gmail.com","nick","male"),
("2032-09-12","john3@gmail.com","john","male"),
("2013-01-27","preety@gmail.com","preety","female"),
("1990-02-6","smith56@gmail.com","smith","male"),
("2010-05-20","barbie4@gmail.com","barbie","female"),
("1978-12-1","annabela@gmail.com","annabela","female"),
("1980-7-4","disuza2@gmail.com","dosuza","male"),
("2020-09-10","nobita5@gmail.com","nobita","male"),
("2010-04-11","sizuka2@gmail.com","sizuka","female"),
("2019-12-05","nody3@gmail.com","nody","male"),
("1978-11-6","himawari@gmail.com","himawari","female"),
("1967-10-14","pig3@gmail.com","pig","male"),
("2020-09-3","mimi0@gmail.com","mini","female"),
("1978-09-4","aish3@gmail.com","aish","female"),
("1957-05-3","krish3@gmail.com","krish","male");
select * from customers;

alter table customers add column salary int;
update customers 
set salary = case id
when 1 then 45000
when 2 then 30000
when 3 then 20000
when 4 then 12000
when 5 then 35000
when 47 then 56000
when 48 then 60000
when 49 then 45000
when 50 then 50000
when 51 then 80000
when 52 then 60000
when 53 then 16000
when 54 then 30000
when 55 then 40000
when 56 then 39000
when 57 then 45000
when 58 then 23000
when 59 then 90000
when 60 then 12000
when 61 then 1000
when 62 then 33000
when 63 then 55000
end
where id in (1,2,3,4,5,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63);

-- WHERE FILTERS ----
select * from customers where gender = "male";
select * from customers where gender <> "male";      -- can also use != instead of <> 
select * from customers where salary > 50000
select * from customers where date_of_birth < "2025-12-01" ;
select * from customers where id >= 50;
select * from customers where date_of_birth is null;
select * from customers where date_of_birth between "2000-12-01" and "2020-12-01"; 
select * from customers where gender in ("other");
select * from customers where salary in (1000,40000);
select * from customers where name like "A%";                 -- STATRTS WITH A/a  -->> MYSQL IS NOT CASE SENSITIVE 
select * from customers where name like "%i";                 -- ENDS WITH I/i
select * from customers where name like "%li%";               -- CONTAINS LI
select * from customers where gender = "female" and salary > 50000;
select * from customers where gender = "male" or salary <50000;
select * from customers order by date_of_birth asc;                   -- oder by date_of birth in ascending order 
select * from customers order by date_of_birth desc;                  -- decending order
select * from customers where gender ="female" and salary > 60000 order by date_of_birth asc;
select * from customers where gender = "male" limit 5;                   -- SHOWS TOP 5 ROWS 
select * from customers where salary < 90000 limit 10 offset 5;          -- SKIP FIRST 5 ROWS ,THEN GET NEXT 10
select * from customers where salary < 90000 limit 5,10;                 -- WORKS SAME AS THE ABOVE