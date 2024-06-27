--Procedure:
CREATE OR REPLACE PROCEDURE UpdateProducerPrices AS
    -- Declare record type for producer details
    TYPE producer_rec_type IS RECORD (
        Producer_Id Producer.Producer_Id%TYPE,
        Price Producer.Price%TYPE
    );

    -- Declare cursor for producers
    CURSOR producer_cur IS
        SELECT Producer_Id, Price FROM Producer;

    -- Declare variable to hold producer record
    producer_rec producer_rec_type;

    -- Declare variables for event count and price increase
    v_event_count NUMBER;
    v_price_increase NUMBER;
    v_producers_count NUMBER :=0;
BEGIN
    -- Open explicit cursor
    OPEN producer_cur;

    -- Loop through each producer
    LOOP
        FETCH producer_cur INTO producer_rec;
        EXIT WHEN producer_cur%NOTFOUND;

        -- Count the number of events for each producer
        SELECT COUNT(*) INTO v_event_count
        FROM Event
        WHERE Producer_Id = producer_rec.Producer_Id;

        -- Calculate the price increase percentage(capped at 10%)
        v_price_increase := LEAST(v_event_count, 10);

        -- Update the producer's price
        UPDATE Producer
        SET Price = Price * (1 + (v_price_increase / 100))
        WHERE Producer_Id = producer_rec.Producer_Id;

        -- Print update information
        DBMS_OUTPUT.PUT_LINE('Producer ID: ' || producer_rec.Producer_Id || 
                             ', Events: ' || v_event_count || 
                             ', Price increase: ' || v_price_increase || '%');
        v_producers_count:=v_producers_count+1;
	 END LOOP;

    -- Close explicit cursor
    CLOSE producer_cur;

    -- Print confirmation message
    DBMS_OUTPUT.PUT_LINE(v_producers_count || ' producers prices updated successfully.');
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating producer prices: ' || SQLERRM);
END UpdateProducerPrices;


--Function:
CREATE OR REPLACE FUNCTION UpdateTotalEventCosts
RETURN NUMBER 
IS
  CURSOR event_cursor IS
    SELECT Event_Id FROM Event;
    
  event_id_ NUMBER;
  instrument_cost NUMBER;
  total_cost NUMBER;
  overall_total_cost NUMBER := 0;
BEGIN
  OPEN event_cursor;
  
  LOOP
    FETCH event_cursor INTO event_id_;
    EXIT WHEN event_cursor%NOTFOUND;
    
    -- Calculate the cost of instruments for the event
    BEGIN
      SELECT COALESCE(SUM(i.Price), 0)
      INTO instrument_cost
      FROM Instrument_Event ie
      JOIN Instrument i ON ie.Instrument_Id = i.Instrument_Id
      WHERE ie.Event_Id = event_id_;
    EXCEPTION
      WHEN OTHERS THEN
        instrument_cost := 0;
    END;
    
    -- Calculate the total cost of the event
    BEGIN
      SELECT s.Price + p.Price + instrument_cost
      INTO total_cost
      FROM Event e
      JOIN Singer s ON e.Singer_Id = s.Singer_Id
      JOIN Producer p ON e.Producer_Id = p.Producer_Id
      WHERE e.Event_Id = event_id_;
    EXCEPTION
      WHEN OTHERS THEN
        total_cost := 0;
    END;
     -- Update the total cost in the Event table
    UPDATE Event
    SET Total_price_ = total_cost
    WHERE Event_Id = event_id_;

    -- Add to overall total cost
    overall_total_cost := overall_total_cost + total_cost;
    
  END LOOP;
  
  CLOSE event_cursor;
  
  RETURN overall_total_cost;
END UpdateTotalEventCosts;


--Test:
DECLARE
  total_cost NUMBER;
BEGIN
  UpdateProducerPrices;
  total_cost := UpdateTotalEventCosts;
  DBMS_OUTPUT.PUT_LINE('Total cost of all events: ' || total_cost);
END;


    

