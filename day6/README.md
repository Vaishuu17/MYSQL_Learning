## SQL Learning – Day 6: LEFT JOIN

 
 ## Topic Covered

LEFT JOIN in SQL – retrieving all records from the left table and matching records from the right table, including unmatched rows.


 ## What I Learned

Concept of LEFT JOIN

Difference between INNER JOIN vs LEFT JOIN

How LEFT JOIN handles NULL values

Real-world use cases where LEFT JOIN is preferred

Writing optimized LEFT JOIN queries for interview scenarios

## Key Concept

LEFT JOIN returns all rows from the left table and only matching rows from the right table. If no match exists, NULL values are returned for the right table columns.

🧾 SQL Syntax
SELECT columns
FROM table1
LEFT JOIN table2
ON table1.common_column = table2.common_column;


##  Practical Implementation

Created sample tables

Inserted test data

Executed LEFT JOIN queries

Observed how unmatched rows return NULL

Practiced interview-oriented queries

All queries are available in: LeftJoin.sql



🎯 Interview Takeaways

LEFT JOIN is used when missing data is important

Always place the mandatory table on the LEFT

Combine LEFT JOIN with WHERE, GROUP BY, and COALESCE for advanced queries
