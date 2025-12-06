
### Day 3 – SQL Learning

### *Foreign Keys, Referential Actions, Transactions & Autocommit*

Welcome to **Day 3** of my SQL learning journey!
Today was all about understanding **table relationships**, **data integrity**, and **safe database operations** using **transactions**.
This day made SQL feel *more powerful and more real* 

---

##  1. FOREIGN KEY & REFERENTIAL ACTIONS

Learned how to link tables so the database automatically maintains relationships (like *users → addresses*).

### Key Concepts

* **FOREIGN KEY** – Creates relationships between tables
* **Referential Actions**

  * `ON DELETE CASCADE`
  * `ON DELETE SET NULL`
  * `ON UPDATE CASCADE`
  * `RESTRICT`
  * `NO ACTION`

###  My Practice

* Created parent (`users_detail`) & child (`address`) tables
* Applied foreign key constraints
* Tested how deletions/updates behave with different actions
* Understood why `ON DELETE SET NULL` fails if the child column is **NOT NULL**
* Used a ready-made file to **insert address data quickly**

---

##  2. TRANSACTIONS

Learned how to group SQL operations so they are **all-or-nothing**.

### Commands I Practised:

* `START TRANSACTION;`
* `COMMIT;`
* `ROLLBACK;`

###  Key Learnings

* Transactions protect data from mistakes
* Useful for banking, payments, updates, and multi-step inserts
* `ROLLBACK` is a life-saver when an error happens

---

##  3. AUTOCOMMIT

###  What I learned:

* MySQL auto-commits every query when **autocommit = 1**
* Turn it off for safe batch operations:


SET autocommit = 0;
```

* Helpful when inserting multiple rows or running complex updates

---

## 📂 Files Included

| File Name                     | Description                                                             |
| ----------------------------- | ----------------------------------------------------------------------- |
| **day3_foreign_key.sql**      | Foreign key practice + table creation + referential actions             |
| **day3_trans&autocommit.sql** | Transaction, commit, rollback & autocommit practice                     |
| **03_foreignkey.sql**         | Ready-made insert queries for the **address** table to speed up testing |

---

##  Summary

Day 3 boosted my confidence a lot!
I now understand how real databases maintain relationships and ensure safe updates using transactions.
Excited for Day 4 

---


