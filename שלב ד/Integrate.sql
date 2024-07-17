----- PAYMENTS------

-- Add/modify columns 
alter table PAYMENTS add paymenttype VARCHAR2(15);

alter table PAYMENTS add eventid number(5);
-- Create/Recreate primary, unique and foreign key constraints 
alter table PAYMENTS
  add constraint SYS_FKE foreign key (EVENTID)
  references events_ (EVENTID) on delete cascade;

  
--update eventid in payments
BEGIN
    FOR rec IN (SELECT ROWID rid FROM payments WHERE eventid IS NULL) LOOP
        UPDATE payments p
        SET p.eventid = (
            SELECT e.eventid
            FROM (
            SELECT e.eventid 
            FROM events_ e 
            WHERE e.eventid IS NOT NULL 
            ORDER BY DBMS_RANDOM.VALUE) e
            WHERE ROWNUM = 1
        )
        WHERE ROWID = rec.rid;
    END LOOP;
    COMMIT;
END;


--update paymentType in payments
BEGIN
    FOR rec IN (SELECT ROWID rid FROM payments) LOOP
        UPDATE payments p
        SET p.paymenttype = (
            SELECT pt.ptype
            FROM (
            SELECT pt.ptype
            FROM payment_type pt 
            WHERE pt.ptype IS NOT NULL 
            ORDER BY DBMS_RANDOM.VALUE) pt
            WHERE ROWNUM = 1
        )
        WHERE ROWID = rec.rid;
    END LOOP;
    COMMIT;
END;
  


----- EVENTS------

-- Add/modify columns 
alter table EVENTS_ add producerid number(5);
alter table EVENTS_ add singerid number(5);
alter table EVENTS_ modify venueid null;

INSERT INTO EVENTS_ (EVENTID, SINGERID, PRODUCERID, CUSTOMERID, EVENTDATE)
SELECT 
    e.EVENTID, 
    e.SINGERID, 
    e.PRODUCERID, 
    e.CUSTOMERID, 
    e.EVENT_DATE
FROM EVENT e



-- Add/modify columns 
alter table EVENT rename column event_id to EVENTID;
alter table EVENT rename column producer_id to PRODUCERID;
alter table EVENT rename column singer_id to SINGERID;
alter table EVENT rename column customer_id to CUSTOMERID;
alter table EVENT rename column payment_id to PAYMENTID;
-- Create/Recreate primary, unique and foreign key constraints 
alter table EVENT
  drop constraint SYS_C007104 cascade;
alter table EVENT
  add primary key (EVENTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EVENT
  drop constraint UNIQUE_SINGER_DATE cascade;
alter table EVENT
  add constraint UNIQUE_SINGER_DATE unique (SINGERID, EVENT_DATE)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EVENT
  drop constraint SYS_C007147;
alter table EVENT
  add foreign key (PAYMENTID)
  references PAYMENT_TYPE (PAYMENT_ID) on delete cascade;



-- Create/Recreate primary, unique and foreign key constraints 
alter table EVENT
  drop constraint SYS_C007332;
alter table EVENT
  add foreign key (PAYMENTID)
  references payments (PAYMENTID) on delete cascade;
alter table EVENT
  add constraint SYS_FKS foreign key (SINGERID)
  references singer (SINGERID);
alter table EVENT
  add constraint SYS_FKP foreign key (PRODUCERID)
  references producer (PRODUCERID);



----- PRODUCER - SINGER------


-- Add/modify columns 
alter table PRODUCER rename column producer_id to PRODUCERID;
alter table PRODUCER rename column producer_name to producername;

-- Create/Recreate primary, unique and foreign key constraints 
alter table PRODUCER
  drop constraint SYS_C007095 cascade;
alter table PRODUCER
  add primary key (PRODUCERID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

-- Add/modify columns 
alter table SINGER rename column sname to singerName;
alter table SINGER rename column singer_id to SINGERID;
-- Create/Recreate primary, unique and foreign key constraints 
alter table SINGER
  drop constraint SYS_C007117 cascade;
alter table SINGER
  add primary key (SINGERID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
 
 
 
 
 ----- CUSTOMER ------

 
-- Add/modify columns 
alter table CUSTOMER modify name VARCHAR2(120);
alter table CUSTOMER modify email null;
alter table CUSTOMER modify address null;
alter table CUSTOMER add phonenumber VARCHAR2(15);
alter table CUSTOMER add lastpurchasedate date;
-- Add/modify columns 
alter table CUSTOMER rename column customer_id to CUSTOMERID;
-- Create/Recreate primary, unique and foreign key constraints 
alter table CUSTOMER
  drop constraint SYS_C007084 cascade;
alter table CUSTOMER
  add primary key (CUSTOMERID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );


INSERT INTO CUSTOMER (CUSTOMERID, NAME, EMAIL, ADDRESS, PHONENUMBER, LASTPURCHASEDATE)
    SELECT
        c.CUSTOMERID, 
        c.FIRSTNAME || ' ' || c.LASTNAME AS NAME,
        NULL AS EMAIL,
        NULL AS ADDRESS,
        c.PHONENUMBER,
c.LASTPURCHASEDATE
    FROM
        CUSTOMERS C
WHERE
        NOT EXISTS (
            SELECT 1
            FROM CUSTOMER cu
            WHERE cu.CUSTOMERID = C.CUSTOMERID
);




----- DROP UNNECESERY TABLES------

drop table CUSTOMERS;
drop table EVENT;
drop table PAYMENT_TYPE;




----- UPDATE FK------


-- Add/modify columns 
alter table INSTRUMENT_EVENT rename column event_id to EVENTID;
-- Create/Recreate primary, unique and foreign key constraints 
alter table INSTRUMENT_EVENT
  drop constraint SYS_C007111 cascade;
alter table INSTRUMENT_EVENT
  add primary key (INSTRUMENT_ID, EVENTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table INSTRUMENT_EVENT
  add constraint SYS_FKE1 foreign key (EVENTID)
  references events_ (EVENTID) on delete cascade;



-- Add/modify columns 
alter table INSTRUMENT rename column instrument_name to INSTRUMENTNAME;
alter table INSTRUMENT rename column instrument_id to INSTRUMENTID;
-- Create/Recreate primary, unique and foreign key constraints 
alter table INSTRUMENT
  drop constraint SYS_C007088 cascade;
alter table INSTRUMENT
  add primary key (INSTRUMENTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );


-- Add/modify columns 
alter table INSTRUMENT_EVENT rename column instrument_id to INSTRUMENTID;
-- Create/Recreate primary, unique and foreign key constraints 
alter table INSTRUMENT_EVENT
  drop constraint SYS_C007337 cascade;
alter table INSTRUMENT_EVENT
  add primary key (INSTRUMENTID, EVENTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table INSTRUMENT_EVENT
  add constraint SYS_FKI foreign key (INSTRUMENTID)
  references instrument (INSTRUMENTID) on delete cascade;
  
  
-- Create/Recreate primary, unique and foreign key constraints 
alter table PAYMENTS
  add constraint SYS_FKC1 foreign key (CUSTOMERID)
  references customer (CUSTOMERID) on delete cascade;

-- Create/Recreate primary, unique and foreign key constraints 
alter table GUESTS
  drop constraint SYS_C007308;
alter table GUESTS
  add foreign key (EVENTID)
  references EVENTS (EVENTID) on delete cascade;


-- Create/Recreate primary, unique and foreign key constraints 
alter table EVENTS
  add constraint SYS_FKC2 foreign key (CUSTOMERID)
  references customer (CUSTOMERID) on delete cascade;



-- Create/Recreate primary, unique and foreign key constraints 
alter table EVENTS
  add constraint SYS_FKP2 foreign key (PRODUCERID)
  references producer (PRODUCERID) on delete cascade;
alter table EVENTS
  add constraint SYS_FKS2 foreign key (SINGERID)
  references singer (SINGERID) on delete cascade;
  
  
 -- Drop columns 
alter table GUESTS drop column customerid;
