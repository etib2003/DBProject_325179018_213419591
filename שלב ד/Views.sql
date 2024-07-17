--Our view

CREATE OR REPLACE VIEW event_details AS
SELECT 
    e.EVENTID,
    e.EVENTDATE,
    p.PRODUCERNAME AS PRODUCER_NAME,
    s.SINGERNAME AS SINGER_NAME,
    c.NAME AS CUSTOMER_NAME
FROM 
    EVENTS e
    JOIN PRODUCER p ON e.PRODUCERID = p.PRODUCERID
    JOIN SINGER s ON e.SINGERID = s.SINGERID
    JOIN CUSTOMER c ON e.CUSTOMERID = c.CUSTOMERID
ORDER BY e.EVENTDATE;

SELECT SINGER_NAME, COUNT(*) AS EVENT_COUNT
FROM event_details
GROUP BY SINGER_NAME
ORDER BY EVENT_COUNT DESC;

SELECT *
FROM event_details
WHERE EXTRACT(YEAR FROM EVENTDATE) = 2024;


--Their view

CREATE OR REPLACE VIEW catering_event_details AS
SELECT 
    e.EVENTID,
    e.EVENTDATE,
    v.NAME AS VENUE_NAME,
    v.LOCATION AS VENUE_LOCATION,
    c.NAME AS CUSTOMER_NAME,
    g.FIRSTNAME || ' ' || g.LASTNAME AS GUEST_NAME,
    g.RELATIONSHIPLEVEL,
    cat.NAME AS CATERING_NAME,
    cat.MENUDESCRIPTION,
    p.TOTALPRICE AS PAYMENT_PRICE,
    p.PAYMENTDATE
FROM 
    EVENTS e
    JOIN VENUES v ON e.VENUEID = v.VENUEID
    JOIN CUSTOMER c ON e.CUSTOMERID = c.CUSTOMERID
    JOIN GUESTS g ON e.EVENTID = g.EVENTID
    LEFT JOIN HAS_CATERING hc ON e.EVENTID = hc.EVENTID
    LEFT JOIN CATERING cat ON hc.CATERINGID = cat.CATERINGID
    LEFT JOIN PAYMENTS p ON e.EVENTID = p.EVENTID
ORDER BY 
    e.EVENTDATE;
    
select * from catering_event_details;

select eventid, count(*) as amountOfGuests
from catering_event_details
group by eventid
order by amountOfGuests desc;

select relationshiplevel as kind, count(*) as amount
from catering_event_details
group by relationshiplevel
order by amount desc;


WITH guest_counts AS (
    SELECT relationshiplevel, COUNT(*) as amount
    FROM catering_event_details
    GROUP BY relationshiplevel
),
total_guests AS (
    SELECT SUM(amount) as total
    FROM guest_counts
)
SELECT 
    gc.relationshiplevel as kind,
    gc.amount,
    ROUND((gc.amount * 100.0 / tg.total), 2) || ' %'  as statistic
FROM 
    guest_counts gc,
    total_guests tg
ORDER BY 
    statistic DESC;
