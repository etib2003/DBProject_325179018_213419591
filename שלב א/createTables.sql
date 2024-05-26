CREATE TABLE Singer
(
  Sname VARCHAR(15) NOT NULL,
  Singer_Id NUMERIC(5) NOT NULL,
  Price NUMERIC(5) NOT NULL,
  PRIMARY KEY (Id)
);

CREATE TABLE Customer
(
  Customer_Id NUMERIC(5) NOT NULL,
  Name VARCHAR(15) NOT NULL,
  Email VARCHAR(15) NOT NULL,
  Address VARCHAR(15) NOT NULL,
  PRIMARY KEY (Customer_Id)
);

CREATE TABLE Instrument
(
  Instrument_Name VARCHAR(15) NOT NULL,
  Price NUMERIC(5) NOT NULL,
  Instrument_Id NUMERIC(5) NOT NULL,
  PRIMARY KEY (Instrument_Id)
);

CREATE TABLE Payment_type
(
  Payment_Id NUMERIC(5) NOT NULL,
  Ptype VARCHAR(15) NOT NULL,
  PRIMARY KEY (Payment_Id)
);

CREATE TABLE Producer
(
  Producer_Id NUMERIC(5) NOT NULL,
  Producer_Name VARCHAR(15) NOT NULL,
  Price NUMERIC(5) NOT NULL,
  PRIMARY KEY (Producer_Id)
);

CREATE TABLE Event
(
  Event_Date DATE NOT NULL,
  Location VARCHAR(15) NOT NULL,
  Total_price_ NUMERIC(5) NOT NULL,
  Event_Id NUMERIC(5) NOT NULL,
  Producer_Id NUMERIC(5) NOT NULL,
  Singer_Id NUMERIC(5) NOT NULL,
  Customer_Id NUMERIC(5) NOT NULL,
  Payment_Id NUMERIC(5) NOT NULL,
  PRIMARY KEY (Event_Id),
  FOREIGN KEY (Producer_Id) REFERENCES Producer(Producer_Id),
  FOREIGN KEY (Id) REFERENCES Singer(Id),
  FOREIGN KEY (Customer_Id) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Payment_Id) REFERENCES Payment_type(Payment_Id)
);

CREATE TABLE Instrument_Event
(
  Instrument_Id NUMERIC(5) NOT NULL,
  Event_Id NUMERIC(5) NOT NULL,
  PRIMARY KEY (Instrument_Id, Event_Id),
  FOREIGN KEY (Instrument_Id) REFERENCES Instrument(Instrument_Id),
  FOREIGN KEY (Event_Id) REFERENCES Event(Event_Id)
);
