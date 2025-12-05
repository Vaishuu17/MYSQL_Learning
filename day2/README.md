SQL Learning – Day 2
Mastering Core SQL Operations Like a Pro


Welcome to Day 2 of my SQL Learning series!
Today’s session dives into some of the most powerful and commonly used SQL operations that every developer, analyst, and database engineer must know.

This day was all about modifying data, ensuring data integrity, and using SQL functions smartly to write clean and efficient queries.

* Topics Covered Today
🔹 1. UPDATE Statement
Modify existing rows with precision.
UPDATE table_name
SET column_name = value
WHERE condition;

2. DELETE Statement
Remove unwanted or incorrect data safely.
DELETE FROM table_name
WHERE condition;

3. SQL Constraints

Ensuring data stays valid, accurate, and reliable.

PRIMARY KEY

FOREIGN KEY

UNIQUE

NOT NULL

DEFAULT

CHECK

These constraints make databases smarter and more secure.

4. SQL Functions
I) Mathematical Functions

ABS()

ROUND()

POWER()

CEIL()

FLOOR()

MOD()

II) String Functions (bonus practice)

UPPER()

LOWER()

LENGTH()

CONCAT()

III) Conditional Function
1. IF

2.CASE (SQL’s if-else)

SELECT
    CASE
        WHEN condition THEN value1
        ELSE value2
    END;

 IV) Aggregate Functions

Used for summarizing large amounts of data.

COUNT() – counts rows

SUM() – adds values

AVG() – average

MIN() – smallest

MAX() – largest

SELECT COUNT(*), AVG(salary) FROM users;


V) Date & Time Functions

Working with timestamps like a pro:

NOW() – current date & time

CURDATE() – today’s date

CURTIME() – current time

DATEDIFF(date1, date2) – days difference

DATE_ADD(date, INTERVAL x DAY) – add days

YEAR(), MONTH(), DAY() – extract parts


* What I Practised Today

✔ Updated records in bulk
✔ Deleted data safely
✔ Applied constraints while creating tables
✔ Used mathematical functions in real-time queries
✔ Practiced CASE statements for smart conditional outputs

📂 Files in This Folder

day2/
│── README.md                →  You’re reading it now
│── 01_createusertable.sql   → All CREATE TABLE queries
│── 02_insertdata.sql        → Sample data insertion
└── day2_sql_operations.sql  → Full SQL practice file with queries
