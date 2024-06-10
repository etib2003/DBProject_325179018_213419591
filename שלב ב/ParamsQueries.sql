--Selecting all events that are among the dates entered by the user 
--and whose price is greater than the price requested by the user:
SELECT * 
FROM Event
WHERE Event_Date 
BETWEEN TO_DATE('&<name="From Date" required=true hint="Date in format: DD/MM/YYYY">', 'DD/MM/YYYY') 
       AND TO_DATE('&<name="To Date" required=true hint="Date in format: DD/MM/YYYY">', 'DD/MM/YYYY')
       AND Total_Price_ >= &<name="Starting From Price" list="5000, 7000, 10000, 15000" ifempty=0>;
       
--Selection of all events in which a producer and a singer participated together
--entered as parameters by the user:
SELECT e.Event_Id, e.Event_Date, e.Location, s.Sname AS Singer_Name, p.Producer_Name, e.Total_Price_
FROM Event e
JOIN Singer s ON e.Singer_Id = s.Singer_Id
JOIN Producer p ON e.Producer_Id = p.Producer_Id
WHERE s.Singer_Id = &Singer_Id
  AND p.Producer_Id = &Producer_Id
ORDER BY e.Event_Date;

--A certain producer stopped working, so we will have to replace the producer in all the events
--in which he was supposed to take part:
UPDATE Event
SET Producer_Id = (
    SELECT Producer_Id
    FROM (
        SELECT Producer_Id
        FROM Producer
        WHERE Producer_Id != &producer_id
        ORDER BY DBMS_RANDOM.RANDOM
    )
    WHERE ROWNUM = 1
)

--A customer wants to change his payment method, so we need to update this in the event table:
UPDATE Event
SET Payment_Id = (
   SELECT Payment_Id
FROM Payment_type
WHERE ptype = &<name="Payment Type" type="string" list="select PTYPE from Payment_type">
)
WHERE Customer_Id = &<name="Customer Id">;
