--A singer can only perform at one place a day:
ALTER TABLE Event 
ADD CONSTRAINT unique_singer_date 
UNIQUE (Singer_Id, Event_Date);

--A customer's email must contain @:
ALTER TABLE customer
ADD CONSTRAINT email_formet
CHECK(email LIKE '%@%');

--By default, when adding a new producer, the price will be 5000:
ALTER TABLE  producer  
MODIFY price DEFAULT 5000;
