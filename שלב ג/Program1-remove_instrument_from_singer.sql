--Function:
CREATE OR REPLACE FUNCTION get_future_singer_events(p_singer_id IN Singer.Singer_Id%TYPE) 
RETURN SYS_REFCURSOR
AS
    v_events SYS_REFCURSOR;
BEGIN
    OPEN v_events FOR
        SELECT Event_Id
        FROM Event
        WHERE Singer_Id = p_singer_id
        AND Event_Date >= TRUNC(SYSDATE)
        ORDER BY Event_Date;
    
    RETURN v_events;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No future events found for this singer.');
        RETURN NULL;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
        RAISE;
END get_future_singer_events;


--Procedure:
CREATE OR REPLACE PROCEDURE 
remove_instrument_from_events (p_event_cursor IN SYS_REFCURSOR, p_instrument_id IN Instrument.Instrument_Id%TYPE)
AS
    v_event_id Event.Event_Id%TYPE;
    v_count NUMBER := 0;
    v_instrument_name Instrument.Instrument_Name%TYPE;
    
    -- Custom exception
    instrument_not_found EXCEPTION;
    PRAGMA EXCEPTION_INIT(instrument_not_found, -20001);

BEGIN
    -- Check if the instrument exists
    BEGIN
        SELECT Instrument_Name INTO v_instrument_name
        FROM Instrument
        WHERE Instrument_Id = p_instrument_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE instrument_not_found;
    END;

    LOOP
        FETCH p_event_cursor INTO v_event_id;
        EXIT WHEN p_event_cursor%NOTFOUND;
        
        BEGIN
            DELETE FROM Instrument_Event
            WHERE Event_Id = v_event_id
            AND Instrument_Id = p_instrument_id;

            v_count := v_count + SQL%ROWCOUNT;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                CONTINUE;
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error deleting instrument from event: ' || SQLERRM);
                CONTINUE;
        END;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(v_count || ' instances of instrument ' || v_instrument_name || ' were removed from events.');

    COMMIT;
EXCEPTION
    WHEN instrument_not_found THEN
        DBMS_OUTPUT.PUT_LINE('Instrument not found');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error removing instrument: ' || SQLERRM);
        RAISE;
END remove_instrument_from_events;


--Main Procedure:
CREATE OR REPLACE PROCEDURE manage_singer_instrument(p_singer_id IN Singer.Singer_Id%TYPE, p_instrument_id IN Instrument.Instrument_Id%TYPE)
AS
    v_events SYS_REFCURSOR;
    
    -- Record type for storing singer details
    TYPE r_singer_info IS RECORD (
        name Singer.Sname%TYPE,
        price Singer.Price%TYPE
    );
    v_singer_info r_singer_info;
BEGIN
    -- Get singer details
    BEGIN
        SELECT Sname, Price
        INTO v_singer_info.name, v_singer_info.price
        FROM Singer
        WHERE Singer_Id = p_singer_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20002, 'Singer not found');
    END;

    DBMS_OUTPUT.PUT_LINE('Managing events for singer ' || v_singer_info.name || 
                         ' (Price: ' || v_singer_info.price || ')');

    -- Get list of future events for the singer
    v_events := get_future_singer_events(p_singer_id);

    IF v_events IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('No future events found for this singer.');
        RETURN;
    END IF;
    -- Remove instrument from events
    remove_instrument_from_events(v_events, p_instrument_id);

    DBMS_OUTPUT.PUT_LINE('Operation completed successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
        RAISE;
END manage_singer_instrument;


--Test:
begin
  -- Call the procedure
  manage_singer_instrument(p_singer_id => :p_singer_id,
                           p_instrument_id => :p_instrument_id);
end;

