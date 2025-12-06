-- TRANSACTIONS AND AUTOCOMMIT ---- 
SELECT * FROM users;
SET autocommit = 0;                         -- AUTOCOMMIT IS OFF
DELETE FROM users WHERE id = 4;             -- opps i made an mistake 
ROLLBACK;                                   -- REVERTS CHANGES TO THE LAST SAFE POINT
SELECT * FROM users;
DELETE FROM users WHERE id = 3;
COMMIT;                                     -- PERMENTLY SAVES CHANGES TO THE DATABASE 
SET autocommit = 1;                         -- AUTOCOMMIT IS ON

