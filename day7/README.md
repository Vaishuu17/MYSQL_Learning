SQL Learning – Day 7: RIGHT JOIN 


## Topics Covered

RIGHT JOIN in SQL

Handling unmatched records

Difference between LEFT JOIN vs RIGHT JOIN

Interview-level SQL queries based on joins

Real-world business scenarios


## What I Learned

How RIGHT JOIN returns all records from the right table

How unmatched rows from the left table produce NULL values

Converting RIGHT JOIN logic into LEFT JOIN (interview trick)

Writing case-based interview questions using RIGHT JOIN

Understanding when RIGHT JOIN is required in real datasets


##  Key Concept

RIGHT JOIN returns all rows from the right table and only matching rows from the left table.
If no match exists, NULL values are returned from the left table.

🧾 SQL Syntax

SELECT columns

FROM table1

RIGHT JOIN table2

ON table1.common_column = table2.common_column;


## LEFT JOIN vs RIGHT JOIN (Interview Insight)

RIGHT JOIN can always be rewritten as a LEFT JOIN by swapping tables

LEFT JOIN is more commonly used in production

RIGHT JOIN questions often test conceptual clarity


##Practical Implementation

Created relational tables

Inserted sample business data

Executed RIGHT JOIN queries

Solved interview-level questions

Analyzed output with NULL handling

All queries are available in: RightJoin.sql
