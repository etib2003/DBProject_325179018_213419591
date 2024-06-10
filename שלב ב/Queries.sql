--Showing the number of events that were in each hall until 2024 (inclusive) in descending order:
SELECT Location, COUNT(Event_Id) AS Total_Events
FROM Event
WHERE EXTRACT(YEAR FROM Event_Date) <= 2024
GROUP BY Location
ORDER BY Total_Events DESC;

--Presentation of pairs of singers and producers who participated in the event together:
SELECT s.Singer_Id AS Singer_Id, s.Sname AS Singer_Name,p.producer_id AS producer_id, p.Producer_Name AS Producer_Name, COUNT(*) AS Event_Count
FROM Event e
JOIN Singer s ON e.Singer_Id = s.Singer_Id
JOIN Producer p ON e.Producer_Id = p.Producer_Id
GROUP BY s.Sname, p.Producer_Name, s.Singer_Id, p.producer_id
HAVING COUNT(*) > 1;

--Presentation the most popular singers according to the number of events in which they appeared:WITH MaxEvents AS (
    SELECT s.Singer_Id, s.Sname AS Singer_Name, COUNT(*) AS Event_Count
    FROM Event e
    JOIN Singer s ON e.Singer_Id = s.Singer_Id
    GROUP BY s.Singer_Id, s.Sname
)

SELECT *
FROM MaxEvents
WHERE Event_Count = (SELECT MAX(Event_Count) FROM MaxEvents);


--Showing the average cost of events in summer, winter and other seasons:
WITH Seasons AS (
    SELECT 
        CASE 
            WHEN TO_CHAR(Event_Date, 'MM') IN ('5','06', '07', '08','9') THEN 'Summer'
            WHEN TO_CHAR(Event_Date, 'MM') IN ('11','12', '01', '02') THEN 'Winter'
            ELSE 'Other'
        END AS Season,
        Total_Price_
    FROM 
        Event
)
SELECT 
    Season,
    AVG(Total_Price_) AS Average_Price
FROM 
    Seasons
GROUP BY 
    Season
ORDER BY 
    Average_Price DESC;
    
--Updating the total price field of an event (scheme of prices for producer, singer and musical instrument in the event):
UPDATE Event e
SET e.Total_price_ = (
    SELECT p.Price + s.Price + (
                                SELECT COALESCE(SUM(i.Price), 0)
                                FROM Instrument_Event ie, Instrument i
                                WHERE ie.Event_Id = e.Event_Id AND ie.Instrument_Id = i.Instrument_Id)
    FROM Producer p, Singer s
    WHERE e.Producer_Id = p.Producer_Id AND e.Singer_Id = s.Singer_Id
);

--Doubling 1.1 times the prices of the singers (price increase) who appeared more than twice in the last 4 years:
UPDATE singer
SET price=price*1.1
WHERE singer_id IN(
      SELECT singer_id FROM event
      WHERE (EXTRACT(YEAR FROM Event_Date) BETWEEN 2020 AND 2024)
      GROUP BY singer_id
      HAVING COUNT(*) > 2);

--Deletion of all singers who did not appear at events starting in 2021 (due to irrelevance):
DELETE FROM Singer
WHERE Singer_Id NOT IN (
    SELECT DISTINCT e.Singer_Id
    FROM Event e
    WHERE e.Event_Date >= DATE '2021-01-01'
);

--Deletion of all events scheduled to take place in the Whispering Gard hall between the 4th and 7th months of 2025
--due to the temporary closure of the hall for renovations:
DELETE FROM event
WHERE location = 'Whispering Gard' AND (EXTRACT(YEAR FROM Event_Date) = 2025 AND EXTRACT(MONTH FROM Event_Date) BETWEEN 4 AND 7);

select * from event
WHERE location = 'Whispering Gard';







