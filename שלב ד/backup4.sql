prompt PL/SQL Developer import file
prompt Created on יום רביעי 17 יולי 2024 by אתוש
set feedback off
set define off
prompt Creating CATERING...
create table CATERING
(
  cateringid        INTEGER not null,
  name              VARCHAR2(100) not null,
  menudescription   VARCHAR2(500) not null,
  contractstartdate DATE not null,
  contractenddate   DATE not null
)
;
alter table CATERING
  add primary key (CATERINGID);

prompt Creating CUSTOMER...
create table CUSTOMER
(
  customerid       NUMBER(5) not null,
  name             VARCHAR2(120) not null,
  email            VARCHAR2(15),
  address          VARCHAR2(15),
  phonenumber      VARCHAR2(15),
  lastpurchasedate DATE
)
;
alter table CUSTOMER
  add primary key (CUSTOMERID);
alter table CUSTOMER
  add constraint EMAIL_FORMET
  check (email LIKE '%@%');

prompt Creating PRODUCER...
create table PRODUCER
(
  producerid   NUMBER(5) not null,
  producername VARCHAR2(15) not null,
  price        NUMBER(5) default 5000 not null
)
;
alter table PRODUCER
  add primary key (PRODUCERID);

prompt Creating SINGER...
create table SINGER
(
  singername VARCHAR2(15) not null,
  singerid   NUMBER(5) not null,
  price      NUMBER(5) not null
)
;
alter table SINGER
  add primary key (SINGERID);
alter table SINGER
  add constraint MINIMUM_COST
  check (price>1000 and price<12000);

prompt Creating VENUES...
create table VENUES
(
  venueid        INTEGER not null,
  name           VARCHAR2(100) not null,
  location       VARCHAR2(255) not null,
  capacity       INTEGER not null,
  opendate       DATE not null,
  renovationdate DATE not null
)
;
alter table VENUES
  add primary key (VENUEID);

prompt Creating EVENTS...
create table EVENTS
(
  eventid               INTEGER not null,
  eventdate             DATE not null,
  eventconfirmationdate DATE,
  customerid            INTEGER not null,
  venueid               INTEGER,
  producerid            NUMBER(5),
  singerid              NUMBER(5)
)
;
alter table EVENTS
  add primary key (EVENTID);
alter table EVENTS
  add foreign key (VENUEID)
  references VENUES (VENUEID);
alter table EVENTS
  add constraint SYS_FKC2 foreign key (CUSTOMERID)
  references CUSTOMER (CUSTOMERID) on delete cascade;
alter table EVENTS
  add constraint SYS_FKP2 foreign key (PRODUCERID)
  references PRODUCER (PRODUCERID) on delete cascade;
alter table EVENTS
  add constraint SYS_FKS2 foreign key (SINGERID)
  references SINGER (SINGERID) on delete cascade;

prompt Creating GUESTS...
create table GUESTS
(
  gustid            INTEGER not null,
  relationshiplevel VARCHAR2(50) not null,
  firstname         VARCHAR2(50) not null,
  lastname          VARCHAR2(50) not null,
  invitationdate    DATE not null,
  confirmationdate  DATE,
  rsvpstatus        VARCHAR2(50),
  eventid           INTEGER not null
)
;
alter table GUESTS
  add primary key (GUSTID);
alter table GUESTS
  add foreign key (EVENTID)
  references EVENTS (EVENTID) on delete cascade;

prompt Creating HAS_CATERING...
create table HAS_CATERING
(
  cateringid INTEGER not null,
  eventid    INTEGER not null
)
;
alter table HAS_CATERING
  add primary key (CATERINGID, EVENTID);
alter table HAS_CATERING
  add foreign key (CATERINGID)
  references CATERING (CATERINGID);
alter table HAS_CATERING
  add foreign key (EVENTID)
  references EVENTS (EVENTID);

prompt Creating INSTRUMENT...
create table INSTRUMENT
(
  instrumentname VARCHAR2(15) not null,
  price          NUMBER(5) not null,
  instrumentid   NUMBER(5) not null
)
;
alter table INSTRUMENT
  add primary key (INSTRUMENTID);

prompt Creating INSTRUMENT_EVENT...
create table INSTRUMENT_EVENT
(
  instrumentid NUMBER(5) not null,
  eventid      NUMBER(5) not null
)
;
alter table INSTRUMENT_EVENT
  add primary key (INSTRUMENTID, EVENTID);
alter table INSTRUMENT_EVENT
  add constraint SYS_FKE1 foreign key (EVENTID)
  references EVENTS (EVENTID) on delete cascade;
alter table INSTRUMENT_EVENT
  add constraint SYS_FKI foreign key (INSTRUMENTID)
  references INSTRUMENT (INSTRUMENTID) on delete cascade;

prompt Creating PAYMENTS...
create table PAYMENTS
(
  paymentid           INTEGER not null,
  totalprice          NUMBER(10,2) not null,
  paymentdate         DATE not null,
  paymentdeadlinedate DATE,
  customerid          INTEGER not null,
  paymenttype         VARCHAR2(15),
  eventid             NUMBER(5)
)
;
alter table PAYMENTS
  add primary key (PAYMENTID);
alter table PAYMENTS
  add constraint SYS_FKC1 foreign key (CUSTOMERID)
  references CUSTOMER (CUSTOMERID) on delete cascade;
alter table PAYMENTS
  add constraint SYS_FKE foreign key (EVENTID)
  references EVENTS (EVENTID) on delete cascade;

prompt Disabling triggers for CATERING...
alter table CATERING disable all triggers;
prompt Disabling triggers for CUSTOMER...
alter table CUSTOMER disable all triggers;
prompt Disabling triggers for PRODUCER...
alter table PRODUCER disable all triggers;
prompt Disabling triggers for SINGER...
alter table SINGER disable all triggers;
prompt Disabling triggers for VENUES...
alter table VENUES disable all triggers;
prompt Disabling triggers for EVENTS...
alter table EVENTS disable all triggers;
prompt Disabling triggers for GUESTS...
alter table GUESTS disable all triggers;
prompt Disabling triggers for HAS_CATERING...
alter table HAS_CATERING disable all triggers;
prompt Disabling triggers for INSTRUMENT...
alter table INSTRUMENT disable all triggers;
prompt Disabling triggers for INSTRUMENT_EVENT...
alter table INSTRUMENT_EVENT disable all triggers;
prompt Disabling triggers for PAYMENTS...
alter table PAYMENTS disable all triggers;
prompt Disabling foreign key constraints for EVENTS...
alter table EVENTS disable constraint SYS_C007299;
alter table EVENTS disable constraint SYS_FKC2;
alter table EVENTS disable constraint SYS_FKP2;
alter table EVENTS disable constraint SYS_FKS2;
prompt Disabling foreign key constraints for GUESTS...
alter table GUESTS disable constraint SYS_C007345;
prompt Disabling foreign key constraints for HAS_CATERING...
alter table HAS_CATERING disable constraint SYS_C007312;
alter table HAS_CATERING disable constraint SYS_C007313;
prompt Disabling foreign key constraints for INSTRUMENT_EVENT...
alter table INSTRUMENT_EVENT disable constraint SYS_FKE1;
alter table INSTRUMENT_EVENT disable constraint SYS_FKI;
prompt Disabling foreign key constraints for PAYMENTS...
alter table PAYMENTS disable constraint SYS_FKC1;
alter table PAYMENTS disable constraint SYS_FKE;
prompt Deleting PAYMENTS...
delete from PAYMENTS;
commit;
prompt Deleting INSTRUMENT_EVENT...
delete from INSTRUMENT_EVENT;
commit;
prompt Deleting INSTRUMENT...
delete from INSTRUMENT;
commit;
prompt Deleting HAS_CATERING...
delete from HAS_CATERING;
commit;
prompt Deleting GUESTS...
delete from GUESTS;
commit;
prompt Deleting EVENTS...
delete from EVENTS;
commit;
prompt Deleting VENUES...
delete from VENUES;
commit;
prompt Deleting SINGER...
delete from SINGER;
commit;
prompt Deleting PRODUCER...
delete from PRODUCER;
commit;
prompt Deleting CUSTOMER...
delete from CUSTOMER;
commit;
prompt Deleting CATERING...
delete from CATERING;
commit;
prompt Loading CATERING...
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (1, 'Gourmet Delight', 'Fine dining experience with a touch of elegance', to_date('15-01-2020', 'dd-mm-yyyy'), to_date('15-01-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (2, 'Home Comforts', 'Homestyle meals with a cozy feel', to_date('20-02-2020', 'dd-mm-yyyy'), to_date('20-02-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (3, 'Healthy Choices', 'Nutrition-packed meals for health-conscious individuals', to_date('25-03-2020', 'dd-mm-yyyy'), to_date('25-03-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (4, 'Exotic Flavors', 'A journey through exotic and vibrant cuisines', to_date('30-04-2020', 'dd-mm-yyyy'), to_date('30-04-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (5, 'BBQ Heaven', 'Smoky and savory barbecue delights', to_date('05-05-2020', 'dd-mm-yyyy'), to_date('05-05-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (6, 'Seafood Paradise', 'Fresh and succulent seafood dishes', to_date('10-06-2020', 'dd-mm-yyyy'), to_date('10-06-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (7, 'Vegan Feast', 'Plant-based gourmet meals', to_date('15-07-2020', 'dd-mm-yyyy'), to_date('15-07-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (8, 'Sweet Endings', 'Decadent desserts and sweet treats', to_date('20-08-2020', 'dd-mm-yyyy'), to_date('20-08-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (9, 'Comfort Cravings', 'Soul-soothing comfort food', to_date('25-09-2020', 'dd-mm-yyyy'), to_date('25-09-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (10, 'Italian Classics', 'Traditional Italian cuisine with a modern twist', to_date('30-10-2020', 'dd-mm-yyyy'), to_date('30-10-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (11, 'Asian Fusion', 'Innovative fusion of Asian flavors', to_date('04-11-2020', 'dd-mm-yyyy'), to_date('04-11-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (12, 'Fiesta Mexicana', 'Vibrant and flavorful Mexican dishes', to_date('09-12-2020', 'dd-mm-yyyy'), to_date('09-12-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (13, 'French Elegance', 'Sophisticated and classic French cuisine', to_date('14-01-2021', 'dd-mm-yyyy'), to_date('14-01-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (14, 'Mediterranean Magic', 'Heart-healthy Mediterranean dishes', to_date('18-02-2021', 'dd-mm-yyyy'), to_date('18-02-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (15, 'Street Food Extravaganza', 'Authentic street food from around the world', to_date('25-03-2021', 'dd-mm-yyyy'), to_date('25-03-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (16, 'Rustic Retreat', 'Hearty and rustic farm-to-table meals', to_date('30-04-2021', 'dd-mm-yyyy'), to_date('30-04-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (17, 'Sushi Sensations', 'Exquisite sushi and Japanese delicacies', to_date('05-05-2021', 'dd-mm-yyyy'), to_date('05-05-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (18, 'Tropical Taste', 'Fresh and vibrant tropical flavors', to_date('10-06-2021', 'dd-mm-yyyy'), to_date('10-06-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (19, 'Burger Bonanza', 'Gourmet burgers with a variety of toppings', to_date('15-07-2021', 'dd-mm-yyyy'), to_date('15-07-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (20, 'Brunch Bliss', 'Delightful and indulgent brunch options', to_date('20-08-2021', 'dd-mm-yyyy'), to_date('20-08-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (21, 'Tapas Treats', 'Spanish tapas and small plates', to_date('25-09-2021', 'dd-mm-yyyy'), to_date('25-09-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (22, 'Middle Eastern Delights', 'Rich and aromatic Middle Eastern cuisine', to_date('30-10-2021', 'dd-mm-yyyy'), to_date('30-10-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (23, 'American Diner', 'Classic American diner fare', to_date('04-11-2021', 'dd-mm-yyyy'), to_date('04-11-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (24, 'Caribbean Flavors', 'Spicy and bold Caribbean dishes', to_date('09-12-2021', 'dd-mm-yyyy'), to_date('09-12-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (25, 'Indian Spice', 'Aromatic and flavorful Indian cuisine', to_date('14-01-2022', 'dd-mm-yyyy'), to_date('14-01-2023', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (26, 'Greek Feast', 'Fresh and vibrant Greek dishes', to_date('18-02-2022', 'dd-mm-yyyy'), to_date('18-02-2023', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (27, 'Modern Bistro', 'Contemporary and chic bistro fare', to_date('25-03-2022', 'dd-mm-yyyy'), to_date('25-03-2023', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (28, 'Soul Food', 'Heartwarming and soulful Southern cuisine', to_date('30-04-2022', 'dd-mm-yyyy'), to_date('30-04-2023', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (29, 'Fusion Frenzy', 'A creative mix of global flavors', to_date('05-05-2022', 'dd-mm-yyyy'), to_date('05-05-2023', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (30, 'Dessert Dream', 'Heavenly and indulgent desserts', to_date('10-06-2022', 'dd-mm-yyyy'), to_date('10-06-2023', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (1000, 'Gourmet Catering', 'Full service catering with a wide variety of menu options', to_date('01-01-2020', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (2000, 'Event Catering', 'Specializing in corporate and private events', to_date('01-06-2019', 'dd-mm-yyyy'), to_date('01-06-2024', 'dd-mm-yyyy'));
commit;
prompt 32 records loaded
prompt Loading CUSTOMER...
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (101, ' Alice Brown', ' alice@ex.com', ' 123 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (102, ' Bob Smith', ' bob@ex.com', ' 456 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (103, ' Carol Johnson', ' carol@ex.com', ' 789 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (104, ' David Wilson', ' david@ex.com', ' 321 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (105, ' Eve Davis', ' eve@ex.com', ' 654 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (106, ' Frank Miller', ' frank@ex.com', ' 987 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (107, ' Grace Lee', ' grace@ex.com', ' 111 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (108, ' Henry Clark', ' henry@ex.com', ' 222 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (109, ' Irene Lewis', ' irene@ex.com', ' 333 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (110, ' Jack Walker', ' jack@ex.com', ' 444 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (111, 'Dan Smith', 'dan.s@email.com', '85 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (112, 'Jane Wilson', 'jane.@mail.com', '44 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (113, 'Carol Brown', 'carol@ex.com', '64 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (114, 'Jane Johnson', 'jane.@ex.com', '779 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (115, 'Eve Jones', 'eve.j@site.com', '922 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (116, 'Alice Davis', 'alice@email.com', '325 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (117, 'Alice Smith', 'alice@site.com', '341 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (118, 'Alice Williams', 'alice@email.com', '889 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (119, 'Carol Garcia', 'carol@ex.com', '385 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (120, 'Alice Williams', 'alice@web.com', '946 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (121, 'Bob Johnson', 'bob.j@email.com', '862 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (122, 'Carol Smith', 'carol@mail.com', '233 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (123, 'Frank Jones', 'frank@ex.com', '509 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (124, 'Alice Miller', 'alice@site.com', '126 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (125, 'Dan Smith', 'dan.s@ex.com', '986 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (126, 'Jane Jones', 'jane.@email.com', '926 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (127, 'John Wilson', 'john.@email.com', '483 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (128, 'Eve Garcia', 'eve.g@ex.com', '482 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (129, 'Dan Johnson', 'dan.j@ex.com', '893 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (130, 'Eve Davis', 'eve.d@site.com', '722 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (131, 'Frank Williams', 'frank@web.com', '914 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (132, 'Alice Brown', 'alice@ex.com', '893 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (133, 'Jane Brown', 'jane.@email.com', '78 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (134, 'John Smith', 'john.@mail.com', '382 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (135, 'Jane Davis', 'jane.@ex.com', '268 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (136, 'John Wilson', 'john.@mail.com', '945 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (137, 'Alice Doe', 'alice@mail.com', '218 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (138, 'Grace Johnson', 'grace@email.com', '646 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (139, 'Henry Davis', 'henry@mail.com', '289 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (140, 'Dan Brown', 'dan.b@email.com', '214 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (141, 'Carol Davis', 'carol@email.com', '286 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (142, 'Frank Davis', 'frank@email.com', '603 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (143, 'Jane Williams', 'jane.@web.com', '135 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (144, 'Henry Garcia', 'henry@site.com', '290 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (145, 'Frank Brown', 'frank@site.com', '735 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (146, 'Carol Davis', 'carol@ex.com', '3 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (147, 'Henry Williams', 'henry@ex.com', '134 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (148, 'Carol Brown', 'carol@web.com', '49 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (149, 'Dan Davis', 'dan.d@ex.com', '91 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (150, 'Henry Williams', 'henry@mail.com', '54 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (151, 'Alice Wilson', 'alice@site.com', '580 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (152, 'Frank Jones', 'frank@email.com', '704 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (153, 'Frank Garcia', 'frank@web.com', '998 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (154, 'Dan Garcia', 'dan.g@email.com', '81 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (155, 'Frank Garcia', 'frank@ex.com', '408 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (156, 'John Williams', 'john.@mail.com', '92 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (157, 'Grace Garcia', 'grace@ex.com', '937 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (158, 'John Brown', 'john.@ex.com', '814 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (159, 'Alice Davis', 'alice@ex.com', '683 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (160, 'Eve Wilson', 'eve.w@web.com', '769 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (161, 'John Johnson', 'john.@email.com', '795 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (162, 'Frank Smith', 'frank@web.com', '756 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (163, 'Carol Garcia', 'carol@mail.com', '231 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (164, 'Dan Miller', 'dan.m@web.com', '799 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (165, 'Grace Garcia', 'grace@email.com', '22 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (166, 'Jane Doe', 'jane.@ex.com', '868 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (167, 'Alice Williams', 'alice@mail.com', '408 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (168, 'Henry Smith', 'henry@web.com', '156 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (169, 'Eve Miller', 'eve.m@mail.com', '860 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (170, 'Bob Davis', 'bob.d@mail.com', '199 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (171, 'Alice Garcia', 'alice@email.com', '370 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (172, 'Henry Miller', 'henry@mail.com', '849 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (173, 'Henry Smith', 'henry@web.com', '190 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (174, 'Carol Jones', 'carol@ex.com', '377 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (175, 'Grace Smith', 'grace@mail.com', '609 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (176, 'Henry Jones', 'henry@web.com', '530 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (177, 'Frank Johnson', 'frank@mail.com', '244 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (178, 'Eve Miller', 'eve.m@site.com', '188 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (179, 'Jane Brown', 'jane.@email.com', '8 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (180, 'Bob Smith', 'bob.s@site.com', '908 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (181, 'Alice Smith', 'alice@email.com', '570 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (182, 'Eve Davis', 'eve.d@web.com', '573 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (183, 'Henry Williams', 'henry@mail.com', '61 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (184, 'Jane Brown', 'jane.@web.com', '859 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (185, 'Alice Doe', 'alice@ex.com', '461 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (186, 'Bob Miller', 'bob.m@ex.com', '168 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (187, 'John Miller', 'john.@web.com', '591 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (188, 'Carol Johnson', 'carol@ex.com', '514 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (189, 'Frank Smith', 'frank@web.com', '75 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (190, 'Frank Garcia', 'frank@web.com', '832 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (191, 'Grace Wilson', 'grace@web.com', '404 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (192, 'Frank Wilson', 'frank@site.com', '625 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (193, 'Bob Williams', 'bob.w@mail.com', '469 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (194, 'Carol Williams', 'carol@ex.com', '428 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (195, 'Eve Williams', 'eve.w@web.com', '718 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (196, 'John Jones', 'john.@web.com', '525 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (197, 'Carol Smith', 'carol@ex.com', '418 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (198, 'Carol Garcia', 'carol@email.com', '323 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (199, 'Carol Williams', 'carol@ex.com', '726 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (200, 'Jane Johnson', 'jane.@web.com', '4 Oak St', null, null);
commit;
prompt 100 records committed...
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (201, 'John Brown', 'john.@web.com', '761 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (202, 'John Williams', 'john.@ex.com', '635 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (203, 'Jane Davis', 'jane.@email.com', '997 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (204, 'Grace Smith', 'grace@email.com', '181 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (205, 'Frank Jones', 'frank@site.com', '899 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (206, 'Bob Jones', 'bob.j@web.com', '427 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (207, 'Grace Smith', 'grace@email.com', '200 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (208, 'John Johnson', 'john.@ex.com', '791 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (209, 'Frank Garcia', 'frank@email.com', '841 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (210, 'Carol Williams', 'carol@ex.com', '586 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (211, 'Carol Brown', 'carol@site.com', '630 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (212, 'Frank Brown', 'frank@email.com', '771 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (213, 'Grace Davis', 'grace@web.com', '757 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (214, 'Bob Wilson', 'bob.w@mail.com', '59 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (215, 'Eve Brown', 'eve.b@email.com', '260 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (216, 'Alice Davis', 'alice@web.com', '400 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (217, 'John Garcia', 'john.@web.com', '354 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (218, 'Bob Smith', 'bob.s@web.com', '341 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (219, 'Carol Jones', 'carol@mail.com', '114 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (220, 'John Miller', 'john.@ex.com', '863 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (221, 'Alice Smith', 'alice@mail.com', '777 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (222, 'Henry Brown', 'henry@ex.com', '383 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (223, 'Alice Brown', 'alice@site.com', '951 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (224, 'Dan Davis', 'dan.d@email.com', '258 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (225, 'John Miller', 'john.@ex.com', '895 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (226, 'John Brown', 'john.@mail.com', '662 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (227, 'Grace Garcia', 'grace@web.com', '142 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (228, 'Carol Garcia', 'carol@site.com', '873 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (229, 'Jane Miller', 'jane.@site.com', '150 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (230, 'Eve Garcia', 'eve.g@ex.com', '473 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (231, 'Eve Williams', 'eve.w@mail.com', '171 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (232, 'Carol Johnson', 'carol@web.com', '700 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (233, 'Carol Davis', 'carol@mail.com', '192 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (234, 'Jane Jones', 'jane.@web.com', '694 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (235, 'Bob Miller', 'bob.m@ex.com', '258 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (236, 'Eve Doe', 'eve.d@mail.com', '989 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (237, 'Alice Brown', 'alice@web.com', '704 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (238, 'Jane Garcia', 'jane.@ex.com', '917 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (239, 'Jane Davis', 'jane.@web.com', '252 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (240, 'Grace Jones', 'grace@web.com', '186 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (241, 'Eve Miller', 'eve.m@mail.com', '215 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (242, 'Dan Davis', 'dan.d@mail.com', '678 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (243, 'Frank Smith', 'frank@email.com', '279 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (244, 'Eve Johnson', 'eve.j@site.com', '160 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (245, 'Grace Jones', 'grace@web.com', '41 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (246, 'Grace Jones', 'grace@mail.com', '331 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (247, 'Dan Johnson', 'dan.j@site.com', '415 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (248, 'Henry Miller', 'henry@ex.com', '149 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (249, 'Bob Davis', 'bob.d@mail.com', '944 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (250, 'John Miller', 'john.@site.com', '516 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (251, 'Carol Jones', 'carol@mail.com', '26 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (252, 'Henry Davis', 'henry@site.com', '509 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (253, 'Grace Miller', 'grace@mail.com', '156 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (254, 'Eve Miller', 'eve.m@email.com', '642 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (255, 'Grace Brown', 'grace@web.com', '146 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (256, 'Alice Brown', 'alice@web.com', '681 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (257, 'Alice Doe', 'alice@mail.com', '664 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (258, 'Dan Wilson', 'dan.w@site.com', '89 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (259, 'Bob Williams', 'bob.w@mail.com', '247 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (260, 'Henry Miller', 'henry@ex.com', '583 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (261, 'Frank Smith', 'frank@ex.com', '387 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (262, 'Grace Williams', 'grace@ex.com', '787 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (263, 'Bob Miller', 'bob.m@web.com', '400 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (264, 'Henry Smith', 'henry@mail.com', '28 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (265, 'Henry Miller', 'henry@mail.com', '821 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (266, 'John Garcia', 'john.@ex.com', '362 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (267, 'Eve Doe', 'eve.d@mail.com', '484 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (268, 'John Doe', 'john.@mail.com', '202 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (269, 'Eve Johnson', 'eve.j@mail.com', '70 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (270, 'Jane Smith', 'jane.@web.com', '373 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (271, 'Eve Jones', 'eve.j@mail.com', '193 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (272, 'Eve Brown', 'eve.b@mail.com', '652 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (273, 'Grace Brown', 'grace@web.com', '402 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (274, 'Dan Doe', 'dan.d@site.com', '506 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (275, 'Henry Wilson', 'henry@web.com', '451 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (276, 'Eve Doe', 'eve.d@mail.com', '434 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (277, 'Grace Johnson', 'grace@site.com', '208 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (278, 'Frank Miller', 'frank@email.com', '554 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (279, 'Carol Davis', 'carol@ex.com', '781 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (280, 'Eve Garcia', 'eve.g@email.com', '688 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (281, 'Carol Johnson', 'carol@email.com', '283 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (282, 'Dan Wilson', 'dan.w@email.com', '478 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (283, 'Bob Doe', 'bob.d@site.com', '434 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (284, 'Bob Williams', 'bob.w@email.com', '311 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (285, 'Henry Miller', 'henry@web.com', '539 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (286, 'Frank Jones', 'frank@web.com', '499 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (287, 'Henry Johnson', 'henry@ex.com', '305 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (288, 'Eve Brown', 'eve.b@ex.com', '13 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (289, 'Jane Williams', 'jane.@ex.com', '627 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (290, 'Alice Johnson', 'alice@email.com', '665 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (291, 'Bob Davis', 'bob.d@mail.com', '921 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (292, 'John Smith', 'john.@mail.com', '444 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (293, 'Dan Brown', 'dan.b@site.com', '719 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (294, 'Henry Garcia', 'henry@mail.com', '605 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (295, 'Grace Doe', 'grace@site.com', '415 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (296, 'Jane Williams', 'jane.@web.com', '791 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (297, 'Carol Miller', 'carol@email.com', '649 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (298, 'John Wilson', 'john.@site.com', '432 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (299, 'John Miller', 'john.@web.com', '257 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (300, 'Dan Brown', 'dan.b@email.com', '525 Pine St', null, null);
commit;
prompt 200 records committed...
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (301, 'Henry Wilson', 'henry@email.com', '947 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (302, 'Grace Wilson', 'grace@ex.com', '361 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (303, 'Carol Smith', 'carol@site.com', '689 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (304, 'Henry Johnson', 'henry@web.com', '514 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (305, 'John Brown', 'john.@ex.com', '931 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (306, 'Carol Garcia', 'carol@ex.com', '885 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (307, 'John Wilson', 'john.@web.com', '711 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (308, 'Jane Doe', 'jane.@site.com', '363 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (309, 'Grace Brown', 'grace@web.com', '536 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (310, 'Alice Doe', 'alice@email.com', '589 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (311, 'Jane Wilson', 'jane.@mail.com', '813 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (312, 'Carol Doe', 'carol@site.com', '383 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (313, 'Dan Doe', 'dan.d@site.com', '459 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (314, 'Frank Davis', 'frank@ex.com', '463 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (315, 'Frank Doe', 'frank@email.com', '856 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (316, 'Bob Smith', 'bob.s@mail.com', '15 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (317, 'Eve Smith', 'eve.s@email.com', '34 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (318, 'Bob Jones', 'bob.j@web.com', '333 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (319, 'Grace Williams', 'grace@email.com', '378 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (320, 'John Davis', 'john.@mail.com', '800 Pine st', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (321, 'Henry Garcia', 'henry@site.com', '299 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (322, 'Henry Smith', 'henry@web.com', '911 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (323, 'Eve Johnson', 'eve.j@mail.com', '638 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (324, 'Carol Williams', 'carol@web.com', '710 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (325, 'Dan Smith', 'dan.s@email.com', '168 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (326, 'John Wilson', 'john.@mail.com', '88 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (327, 'Eve Jones', 'eve.j@web.com', '560 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (328, 'Frank Smith', 'frank@email.com', '645 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (329, 'Carol Miller', 'carol@site.com', '576 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (330, 'John Jones', 'john.@web.com', '208 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (331, 'Dan Johnson', 'dan.j@site.com', '571 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (332, 'Frank Brown', 'frank@web.com', '300 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (333, 'Henry Garcia', 'henry@mail.com', '613 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (334, 'Carol Williams', 'carol@ex.com', '636 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (335, 'Henry Williams', 'henry@site.com', '249 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (336, 'Alice Doe', 'alice@web.com', '924 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (337, 'Dan Miller', 'dan.m@mail.com', '723 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (338, 'Dan Johnson', 'dan.j@mail.com', '638 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (339, 'Dan Brown', 'dan.b@site.com', '635 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (340, 'Dan Johnson', 'dan.j@ex.com', '618 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (341, 'Alice Smith', 'alice@mail.com', '30 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (342, 'John Davis', 'john.@site.com', '875 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (343, 'Eve Williams', 'eve.w@web.com', '456 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (344, 'Dan Smith', 'dan.s@mail.com', '216 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (345, 'Jane Smith', 'jane.@email.com', '932 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (346, 'Frank Wilson', 'frank@email.com', '252 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (347, 'Dan Davis', 'dan.d@site.com', '486 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (348, 'Carol Brown', 'carol@mail.com', '683 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (349, 'Grace Miller', 'grace@ex.com', '25 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (350, 'Henry Williams', 'henry@mail.com', '785 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (351, 'John Garcia', 'john.@ex.com', '22 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (352, 'Grace Doe', 'grace@mail.com', '524 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (353, 'John Williams', 'john.@ex.com', '574 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (354, 'Grace Miller', 'grace@web.com', '93 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (355, 'Carol Johnson', 'carol@ex.com', '359 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (356, 'Alice Wilson', 'alice@ex.com', '509 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (357, 'Grace Smith', 'grace@email.com', '200 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (358, 'Frank Doe', 'frank@email.com', '431 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (359, 'Bob Miller', 'bob.m@email.com', '757 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (360, 'Eve Wilson', 'eve.w@email.com', '649 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (361, 'Alice Jones', 'alice@web.com', '850 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (362, 'John Miller', 'john.@mail.com', '654 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (363, 'Alice Williams', 'alice@site.com', '656 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (364, 'Carol Johnson', 'carol@email.com', '633 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (365, 'Jane Wilson', 'jane.@web.com', '118 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (366, 'Jane Doe', 'jane.@mail.com', '96 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (367, 'John Jones', 'john.@email.com', '247 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (368, 'Carol Jones', 'carol@site.com', '2 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (369, 'Carol Davis', 'carol@email.com', '995 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (370, 'Jane Jones', 'jane.@site.com', '752 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (371, 'John Brown', 'john.@site.com', '785 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (372, 'Grace Brown', 'grace@site.com', '861 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (373, 'Grace Doe', 'grace@ex.com', '94 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (374, 'Grace Jones', 'grace@mail.com', '682 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (375, 'Dan Davis', 'dan.d@site.com', '145 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (376, 'Carol Brown', 'carol@web.com', '259 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (377, 'Carol Williams', 'carol@mail.com', '461 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (378, 'Frank Davis', 'frank@ex.com', '788 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (379, 'John Smith', 'john.@ex.com', '405 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (380, 'Alice Smith', 'alice@mail.com', '50 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (381, 'Grace Garcia', 'grace@ex.com', '288 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (382, 'Dan Miller', 'dan.m@ex.com', '501 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (383, 'Henry Williams', 'henry@ex.com', '887 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (384, 'Alice Williams', 'alice@site.com', '3 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (385, 'Alice Johnson', 'alice@mail.com', '491 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (386, 'Frank Smith', 'frank@site.com', '90 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (387, 'Carol Miller', 'carol@site.com', '429 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (388, 'Dan Garcia', 'dan.g@email.com', '933 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (389, 'Dan Davis', 'dan.d@site.com', '915 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (390, 'Carol Wilson', 'carol@email.com', '281 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (391, 'Eve Williams', 'eve.w@site.com', '513 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (392, 'Eve Jones', 'eve.j@web.com', '905 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (393, 'Alice Wilson', 'alice@site.com', '826 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (394, 'Bob Johnson', 'bob.j@web.com', '337 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (395, 'Jane Brown', 'jane.@email.com', '259 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (396, 'John Johnson', 'john.@site.com', '553 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (397, 'Carol Doe', 'carol@ex.com', '629 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (398, 'Henry Smith', 'henry@email.com', '444 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (399, 'Dan Brown', 'dan.b@site.com', '714 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (400, 'Carol Smith', 'carol@ex.com', '39 Aspen St', null, null);
commit;
prompt 300 records committed...
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (401, 'Bob Johnson', 'bob.j@site.com', '215 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (402, 'John Davis', 'john.@ex.com', '139 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (403, 'Alice Davis', 'alice@web.com', '982 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (404, 'John Brown', 'john.@ex.com', '294 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (405, 'Henry Miller', 'henry@site.com', '567 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (406, 'Carol Brown', 'carol@mail.com', '55 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (407, 'Dan Brown', 'dan.b@ex.com', '161 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (408, 'Frank Garcia', 'frank@ex.com', '258 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (409, 'Carol Wilson', 'carol@web.com', '763 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (410, 'Alice Jones', 'alice@web.com', '54 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (411, 'John Smith', 'john.@ex.com', '729 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (412, 'Frank Davis', 'frank@email.com', '107 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (413, 'Jane Smith', 'jane.@ex.com', '940 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (414, 'Alice Brown', 'alice@site.com', '331 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (415, 'Frank Wilson', 'frank@ex.com', '763 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (416, 'Henry Johnson', 'henry@ex.com', '329 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (417, 'John Davis', 'john.@mail.com', '418 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (418, 'Alice Jones', 'alice@email.com', '337 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (419, 'Grace Brown', 'grace@mail.com', '438 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (420, 'Alice Doe', 'alice@web.com', '745 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (421, 'Alice Smith', 'alice@email.com', '270 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (422, 'Jane Davis', 'jane.@email.com', '13 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (423, 'Frank Smith', 'frank@ex.com', '147 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (424, 'Carol Garcia', 'carol@web.com', '814 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (425, 'Bob Williams', 'bob.w@site.com', '88 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (426, 'Grace Davis', 'grace@email.com', '455 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (427, 'Dan Davis', 'dan.d@ex.com', '173 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (428, 'Alice Garcia', 'alice@site.com', '323 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (429, 'Henry Jones', 'henry@site.com', '26 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (430, 'Dan Garcia', 'dan.g@web.com', '388 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (431, 'Carol Brown', 'carol@site.com', '699 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (432, 'Bob Miller', 'bob.m@web.com', '45 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (433, 'Frank Davis', 'frank@ex.com', '57 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (434, 'Alice Miller', 'alice@site.com', '392 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (435, 'Carol Wilson', 'carol@email.com', '865 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (436, 'John Miller', 'john.@web.com', '308 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (437, 'Henry Brown', 'henry@ex.com', '61 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (438, 'Carol Davis', 'carol@mail.com', '917 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (439, 'Jane Davis', 'jane.@site.com', '635 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (440, 'Dan Smith', 'dan.s@mail.com', '741 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (441, 'Grace Williams', 'grace@email.com', '655 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (442, 'Frank Smith', 'frank@ex.com', '930 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (443, 'Carol Miller', 'carol@email.com', '116 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (444, 'Eve Johnson', 'eve.j@email.com', '463 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (445, 'Frank Johnson', 'frank@mail.com', '649 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (446, 'Dan Davis', 'dan.d@site.com', '766 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (447, 'Carol Jones', 'carol@mail.com', '890 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (448, 'Grace Brown', 'grace@web.com', '616 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (449, 'Eve Wilson', 'eve.w@site.com', '22 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (450, 'Frank Davis', 'frank@email.com', '607 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (451, 'Alice Brown', 'alice@email.com', '437 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (452, 'Henry Garcia', 'henry@ex.com', '279 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (453, 'Dan Johnson', 'dan.j@ex.com', '872 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (454, 'Carol Doe', 'carol@ex.com', '172 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (455, 'Eve Wilson', 'eve.w@email.com', '336 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (456, 'Jane Johnson', 'jane.@mail.com', '785 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (457, 'Henry Wilson', 'henry@web.com', '261 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (458, 'Frank Wilson', 'frank@email.com', '254 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (459, 'Alice Jones', 'alice@email.com', '13 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (460, 'Bob Johnson', 'bob.j@web.com', '721 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (461, 'Eve Johnson', 'eve.j@site.com', '374 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (462, 'Dan Davis', 'dan.d@web.com', '234 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (463, 'Frank Doe', 'frank@ex.com', '360 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (464, 'Jane Johnson', 'jane.@mail.com', '787 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (465, 'Frank Brown', 'frank@web.com', '196 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (466, 'Dan Brown', 'dan.b@mail.com', '391 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (467, 'Eve Johnson', 'eve.j@site.com', '270 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (468, 'Dan Miller', 'dan.m@site.com', '567 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (469, 'Grace Brown', 'grace@mail.com', '431 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (470, 'Alice Doe', 'alice@web.com', '18 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (471, 'Frank Johnson', 'frank@web.com', '570 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (472, 'Eve Doe', 'eve.d@ex.com', '265 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (473, 'Carol Doe', 'carol@site.com', '845 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (474, 'Dan Garcia', 'dan.g@web.com', '544 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (475, 'Eve Garcia', 'eve.g@email.com', '571 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (476, 'Eve Doe', 'eve.d@email.com', '54 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (477, 'Dan Johnson', 'dan.j@mail.com', '873 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (478, 'Bob Garcia', 'bob.g@site.com', '707 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (479, 'Bob Doe', 'bob.d@web.com', '595 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (480, 'Jane Smith', 'jane.@email.com', '362 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (481, 'Frank Williams', 'frank@email.com', '219 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (482, 'Bob Smith', 'bob.s@email.com', '238 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (483, 'Dan Williams', 'dan.w@ex.com', '748 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (484, 'Alice Wilson', 'alice@mail.com', '871 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (485, 'Bob Doe', 'bob.d@mail.com', '30 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (486, 'Bob Wilson', 'bob.w@mail.com', '906 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (487, 'Carol Williams', 'carol@ex.com', '822 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (488, 'Carol Johnson', 'carol@ex.com', '327 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (489, 'Henry Brown', 'henry@web.com', '947 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (490, 'Jane Williams', 'jane.@email.com', '978 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (491, 'Eve Wilson', 'eve.w@web.com', '641 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (492, 'Dan Smith', 'dan.s@site.com', '122 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (493, 'Eve Brown', 'eve.b@site.com', '158 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (494, 'Dan Johnson', 'dan.j@site.com', '251 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (495, 'John Brown', 'john.@email.com', '643 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (496, 'Frank Williams', 'frank@mail.com', '799 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (497, 'John Miller', 'john.@web.com', '86 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (498, 'John Jones', 'john.@ex.com', '866 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (499, 'Frank Brown', 'frank@ex.com', '68 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (500, 'Carol Garcia', 'carol@ex.com', '246 Cedar St', null, null);
commit;
prompt 400 records committed...
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (501, 'Dan Smith', 'dan.s@web.com', '662 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (502, 'Eve Brown', 'eve.b@site.com', '283 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (503, 'Alice Doe', 'alice@email.com', '58 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (504, 'Bob Miller', 'bob.m@email.com', '685 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (505, 'Grace Brown', 'grace@email.com', '821 Pine St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (506, 'Jane Wilson', 'jane.@mail.com', '727 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (507, 'Dan Garcia', 'dan.g@email.com', '318 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (508, 'Dan Jones', 'dan.j@mail.com', '230 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (509, 'Frank Doe', 'frank@web.com', '648 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (510, 'Jane Williams', 'jane.@ex.com', '415 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (511, 'Henry Davis', 'henry@email.com', '577 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (512, 'John Smith', 'john.@email.com', '800 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (513, 'Dan Doe', 'dan.d@mail.com', '944 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (514, 'Jane Brown', 'jane.@mail.com', '447 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (515, 'Eve Miller', 'eve.m@mail.com', '234 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (516, 'Frank Smith', 'frank@email.com', '214 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (517, 'Carol Brown', 'carol@ex.com', '456 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (518, 'Alice Johnson', 'alice@web.com', '177 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (519, 'Jane Williams', 'jane.@ex.com', '562 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (520, 'Grace Johnson', 'grace@email.com', '809 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (521, 'Jane Davis', 'jane.@site.com', '661 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (522, 'Bob Miller', 'bob.m@web.com', '621 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (523, 'Bob Miller', 'bob.m@site.com', '902 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (524, 'Eve Wilson', 'eve.w@web.com', '796 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (525, 'Grace Davis', 'grace@site.com', '878 Aspen St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (526, 'Grace Brown', 'grace@web.com', '675 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (527, 'Eve Jones', 'eve.j@email.com', '205 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (528, 'Frank Brown', 'frank@ex.com', '992 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (529, 'Alice Garcia', 'alice@site.com', '412 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (530, 'Bob Garcia', 'bob.g@ex.com', '663 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (531, 'Carol Williams', 'carol@email.com', '949 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (532, 'Jane Williams', 'jane.@web.com', '14 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (533, 'Frank Doe', 'frank@mail.com', '871 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (534, 'Carol Doe', 'carol@email.com', '305 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (535, 'Eve Garcia', 'eve.g@ex.com', '890 Oak St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (536, 'Frank Doe', 'frank@email.com', '412 Willow St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (537, 'Bob Smith', 'bob.s@web.com', '992 Birch St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (538, 'Jane Davis', 'jane.@ex.com', '380 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (539, 'Eve Brown', 'eve.b@email.com', '620 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (540, 'Henry Garcia', 'henry@mail.com', '107 Cedar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (541, 'Bob Doe', 'bob.d@web.com', '124 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (542, 'John Williams', 'john.@mail.com', '402 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (543, 'Bob Williams', 'bob.w@web.com', '364 Elm St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (544, 'Alice Wilson', 'alice@ex.com', '736 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (545, 'Eve Davis', 'eve.d@email.com', '1 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (546, 'Carol Wilson', 'carol@email.com', '195 Poplar St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (547, 'Eve Davis', 'eve.d@email.com', '716 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (548, 'Dan Davis', 'dan.d@web.com', '841 Cherry St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (549, 'Carol Williams', 'carol@web.com', '61 Maple St', null, null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1000, 'Rene Ali', null, null, '0565733703', to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1001, 'Keith Van Shelton', null, null, '0581872701', to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1002, 'Tim Statham', null, null, '0591857884', to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1003, 'Cyndi McGinley', null, null, '0576984268', to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1004, 'Carla Turner', null, null, '0519397861', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1005, 'Paul Checker', null, null, '0532219973', to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1006, 'Corey Schiavelli', null, null, '0581051159', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1007, 'Clive Lindley', null, null, '0544309957', to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1008, 'Jean-Claude Giannini', null, null, '0555180193', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1009, 'Emmylou Zeta-Jones', null, null, '0521854909', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1010, 'Rolando Nash', null, null, '0577973379', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1011, 'Miko Mitra', null, null, '0592603228', to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1012, 'Annette Chinlund', null, null, '0543846450', to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1013, 'Juan Williams', null, null, '0510461723', to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1014, 'Cevin Rea', null, null, '0526355761', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1015, 'Andre Gore', null, null, '0559737184', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1016, 'Bridget Sample', null, null, '0566768419', to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1017, 'Clarence Gyllenhaal', null, null, '0542683512', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1018, 'Meg Elwes', null, null, '0519344710', to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1019, 'Loreena Thornton', null, null, '0567120309', to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1020, 'Barry Foster', null, null, '0533732091', to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1021, 'Ike Zeta-Jones', null, null, '0567466427', to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1022, 'Merrill Reubens', null, null, '0559527583', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1023, 'Vin Woods', null, null, '0530898582', to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1024, 'Fairuza Boone', null, null, '0590766698', to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1025, 'Christine Niven', null, null, '0544087746', to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1026, 'Milla Fonda', null, null, '0537982927', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1027, 'Melanie Driver', null, null, '0546098838', to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1028, 'Hikaru Scott', null, null, '0547418462', to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1029, 'Kiefer Schock', null, null, '0592427329', to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1030, 'Sonny Ramirez', null, null, '0568625948', to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1031, 'Gladys Cattrall', null, null, '0568242997', to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1032, 'Jon Cube', null, null, '0522663851', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1033, 'Emily Davies', null, null, '0534505021', to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1034, 'Bridgette Cockburn', null, null, '0539092227', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1035, 'Rik McElhone', null, null, '0598963883', to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1036, 'Geoffrey Keen', null, null, '0556881247', to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1037, 'Denise Myles', null, null, '0579683905', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1038, 'Kurtwood Bacon', null, null, '0553391659', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1039, 'Eileen Merchant', null, null, '0529774570', to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1040, 'Norm Gere', null, null, '0568103955', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1041, 'Jake Shearer', null, null, '0576557290', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1042, 'Deborah Sutherland', null, null, '0521548664', to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1043, 'Aimee Darren', null, null, '0565171574', to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1044, 'Cliff Spears', null, null, '0587225976', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1045, 'Carrie Kudrow', null, null, '0514729203', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1046, 'Kiefer Wheel', null, null, '0593944474', to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1047, 'Nicolas Witherspoon', null, null, '0525527360', to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1048, 'Tia Gallagher', null, null, '0549027266', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1049, 'Meg Lauper', null, null, '0512719201', to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1050, 'Night Green', null, null, '0591193332', to_date('02-01-2019', 'dd-mm-yyyy'));
commit;
prompt 500 records committed...
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1051, 'Willie Saxon', null, null, '0566996940', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1052, 'Todd Faithfull', null, null, '0530861294', to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1053, 'Crispin Salonga', null, null, '0519632212', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1054, 'Rita Ellis', null, null, '0510884515', to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1055, 'Gordon Downey', null, null, '0525329996', to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1056, 'Lena Vicious', null, null, '0564268536', to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1057, 'Hank Levert', null, null, '0599702178', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1058, 'Emerson Secada', null, null, '0556885483', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1059, 'Boz Irving', null, null, '0519646541', to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1060, 'Mika Craven', null, null, '0555645771', to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1061, 'Cheech Vannelli', null, null, '0535310258', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1062, 'Wesley Snipes', null, null, '0599582038', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1063, 'Davis Irving', null, null, '0545091503', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1064, 'Viggo Womack', null, null, '0559831221', to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1065, 'Maceo Ammons', null, null, '0580623426', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1066, 'Austin McGowan', null, null, '0587440483', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1067, 'Fionnula Redford', null, null, '0574967558', to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1068, 'Maceo Statham', null, null, '0573745504', to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1069, 'Temuera Abraham', null, null, '0537733468', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1070, 'Rachid Wahlberg', null, null, '0570380675', to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1071, 'Larenz Quinlan', null, null, '0584619024', to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1072, 'Nick MacIsaac', null, null, '0549831160', to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1073, 'Denny Shatner', null, null, '0510542021', to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1074, 'Jean-Luc Pryce', null, null, '0581528034', to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1075, 'Rich Wine', null, null, '0519464793', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1076, 'Josh Downey', null, null, '0554305115', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1077, 'Nile Shocked', null, null, '0541211079', to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1078, 'Derek Danes', null, null, '0588417123', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1079, 'Keanu Freeman', null, null, '0541341087', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1080, 'Ernest Schneider', null, null, '0536012569', to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1081, 'Jaime Frost', null, null, '0539051141', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1082, 'Judi Hurley', null, null, '0544527080', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1083, 'Charles Pryce', null, null, '0589302831', to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1084, 'Cevin McKennitt', null, null, '0527916539', null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1085, 'Aida Haggard', null, null, '0599109785', to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1086, 'Vendetta Emmerich', null, null, '0595013401', to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1087, 'Nathan Caldwell', null, null, '0551486214', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1088, 'Will Monk', null, null, '0596640576', to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1089, 'Praga Sweeney', null, null, '0522451178', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1090, 'Ethan Dreyfuss', null, null, '0523263148', to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1091, 'Harold Liu', null, null, '0514652566', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1092, 'Chazz Barkin', null, null, '0552566689', to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1093, 'Luis Heron', null, null, '0567067280', to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1094, 'Gailard Rodriguez', null, null, '0511267454', null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1095, 'Christmas Chung', null, null, '0563440218', to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1096, 'Celia Humphrey', null, null, '0536019077', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1097, 'Nikki Quinones', null, null, '0583078963', to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1098, 'Sophie Serbedzija', null, null, '0582475606', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1099, 'Mike McGriff', null, null, '0512772042', to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1100, 'First Dupree', null, null, '0583187976', to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1101, 'Trey Venora', null, null, '0552833838', to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1102, 'Night Pepper', null, null, '0599990239', to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1103, 'Reese Benson', null, null, '0584638324', to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1104, 'Suzanne Red', null, null, '0568420504', null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1105, 'Taye Finney', null, null, '0578760700', to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1106, 'Rhea Rodgers', null, null, '0538782695', to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1107, 'Boz Uggams', null, null, '0568534945', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1108, 'Alicia Keitel', null, null, '0528558961', to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1109, 'Timothy Choice', null, null, '0580471653', to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1110, 'Marina Whitaker', null, null, '0526363542', to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1111, 'Selma Kudrow', null, null, '0563212109', to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1112, 'Sandra Trejo', null, null, '0590135666', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1113, 'Woody Hanley', null, null, '0512354695', to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1114, 'Mekhi Liotta', null, null, '0537481867', to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1115, 'Teena McDonald', null, null, '0518450331', to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1116, 'Rickie Hirsch', null, null, '0548068605', to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1117, 'Cheech McCoy', null, null, '0595423057', to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1118, 'Harry Chao', null, null, '0523929762', null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1119, 'Allison Raye', null, null, '0592833740', to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1120, 'Minnie Cobbs', null, null, '0532744880', to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1121, 'Rupert Durning', null, null, '0543391609', to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1122, 'Frederic Coward', null, null, '0532988545', null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1123, 'Kevn Jonze', null, null, '0530596299', to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1124, 'Nils Frakes', null, null, '0599284779', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1125, 'Jonathan Blackwell', null, null, '0533813459', to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1126, 'Mira Rebhorn', null, null, '0541278448', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1127, 'Alex Lopez', null, null, '0511761089', to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1128, 'Cate Cale', null, null, '0546458688', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1129, 'Lila Applegate', null, null, '0547836470', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1130, 'Alessandro Quatro', null, null, '0556254578', to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1131, 'Terrence Albright', null, null, '0543218683', to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1132, 'Tom Spiner', null, null, '0510672932', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1133, 'Lance Hatfield', null, null, '0554871419', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1134, 'Thora Gryner', null, null, '0543929634', to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1135, 'Derek Payne', null, null, '0510494420', to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1136, 'Ving Moriarty', null, null, '0567833502', to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1137, 'Denny Ojeda', null, null, '0543450391', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1138, 'Lou Gilliam', null, null, '0582315135', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1139, 'Rachel Mollard', null, null, '0568405045', to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1140, 'Gil Brooks', null, null, '0588929836', to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1141, 'Grace Perrineau', null, null, '0519245204', to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1142, 'Rebeka Birch', null, null, '0519786090', to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1143, 'Marianne Cervine', null, null, '0544028587', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1144, 'Nils Whitaker', null, null, '0573755725', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1145, 'Benicio Gibbons', null, null, '0560918726', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1146, 'Julio Leigh', null, null, '0577624577', to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1147, 'Kate Hamilton', null, null, '0528998734', to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1148, 'Loretta Feuerstein', null, null, '0523993823', to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1149, 'Wesley Short', null, null, '0571759431', to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1150, 'Natalie Mollard', null, null, '0582697039', to_date('07-01-2015', 'dd-mm-yyyy'));
commit;
prompt 600 records committed...
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1151, 'Gary Berkley', null, null, '0526024223', to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1152, 'Ashley McKennitt', null, null, '0578069781', to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1153, 'Hank Derringer', null, null, '0513963171', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1154, 'Brian Palminteri', null, null, '0563430447', to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1155, 'Ali Malkovich', null, null, '0515548838', to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1156, 'Malcolm James', null, null, '0518925823', to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1157, 'Bernie Watson', null, null, '0524865041', to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1158, 'Domingo Shaye', null, null, '0584210727', to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1159, 'Naomi Prowse', null, null, '0581748093', to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1160, 'Thelma Harry', null, null, '0565809973', to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1161, 'Isaiah Eat World', null, null, '0519288616', to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1162, 'Lesley Stevenson', null, null, '0533327264', to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1163, 'Wang Lange', null, null, '0599698772', to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1164, 'Andrea Peet', null, null, '0528955567', to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1165, 'Elvis Dysart', null, null, '0554147667', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1166, 'Suzi Burns', null, null, '0576311379', to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1167, 'Carl Kweller', null, null, '0538505823', to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1168, 'Kevin Kenoly', null, null, '0535378090', to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1169, 'Jessica Forrest', null, null, '0557076786', to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1170, 'Andre Hingle', null, null, '0550688986', to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1171, 'Delbert Cohn', null, null, '0556411413', to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1172, 'Gran Boorem', null, null, '0583947700', to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1173, 'Albertina Savage', null, null, '0571398100', to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1174, 'Kirk Cozier', null, null, '0552047089', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1175, 'Chloe Leachman', null, null, '0537163184', to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1176, 'Vern McKellen', null, null, '0585524932', to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1177, 'Kitty Leachman', null, null, '0583736328', to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1178, 'Sinead Quinn', null, null, '0568843885', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1179, 'Tommy Penders', null, null, '0550465119', to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1180, 'Harrison Elizabeth', null, null, '0535263800', to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1181, 'Larnelle Mollard', null, null, '0529290063', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1182, 'Linda Brolin', null, null, '0566242806', to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1183, 'Sophie Bright', null, null, '0525958220', null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1184, 'Sheena DiCaprio', null, null, '0537631076', to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1185, 'Chuck Wells', null, null, '0582964417', to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1186, 'Jodie Flanagan', null, null, '0551693373', to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1187, 'Hazel Whitford', null, null, '0559737614', null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1188, 'Joely Crow', null, null, '0555496559', to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1189, 'Harvey Jane', null, null, '0591037831', null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1190, 'Rachael Emmerich', null, null, '0575040709', to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1191, 'Davey Sampson', null, null, '0561306442', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1192, 'Dorry Preston', null, null, '0589787271', to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1193, 'Jay Tippe', null, null, '0526393266', to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1194, 'Etta Cronin', null, null, '0539828934', to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1195, 'Maria Idol', null, null, '0536646612', to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1196, 'Michelle Black', null, null, '0529896683', null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1197, 'Daryl Sweet', null, null, '0540767315', to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1198, 'Alex Janney', null, null, '0567591373', to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1199, 'Maury Rippy', null, null, '0591904793', null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1200, 'Benjamin Crystal', null, null, '0539961845', to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1201, 'Shannyn Diddley', null, null, '0534325903', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1202, 'Goran Fogerty', null, null, '0539530945', to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1203, 'Tamala Portman', null, null, '0510229352', to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1204, 'Sara Leto', null, null, '0533444191', to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1205, 'Edgar Hannah', null, null, '0587714491', to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1206, 'Pelvic Hopper', null, null, '0572166868', to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1207, 'Denny Newton', null, null, '0583007521', to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1208, 'Matt Berkeley', null, null, '0557775664', to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1209, 'Samuel Vassar', null, null, '0572568917', to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1210, 'Tori Balaban', null, null, '0584963652', to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1211, 'Lindsey Marsden', null, null, '0535616885', to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1212, 'Charles Harrison', null, null, '0596739534', to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1213, 'Rosie Kane', null, null, '0530831068', to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1214, 'Patti Laurie', null, null, '0510273996', to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1215, 'Sander O''Hara', null, null, '0585206875', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1216, 'Dwight Colman', null, null, '0568964652', to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1217, 'Scarlett Lemmon', null, null, '0599091284', to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1218, 'Anthony Speaks', null, null, '0510532663', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1219, 'Dianne Beckham', null, null, '0541529430', to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1220, 'Mandy McIntosh', null, null, '0595266715', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1221, 'Delroy Culkin', null, null, '0568651844', to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1222, 'Miriam Dorn', null, null, '0584325016', to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1223, 'Marc McGoohan', null, null, '0516737892', to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1224, 'Chazz Benet', null, null, '0556739205', to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1225, 'Willie Jay', null, null, '0511729133', to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1226, 'Courtney Bates', null, null, '0536268920', to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1227, 'Patrick Polley', null, null, '0526639201', to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1228, 'Terence Portman', null, null, '0526647100', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1229, 'Charles DeGraw', null, null, '0553379265', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1230, 'Art Bachman', null, null, '0599671055', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1231, 'Nik Tyson', null, null, '0537119313', to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1232, 'Sean Matthau', null, null, '0578696555', to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1233, 'Milla Bryson', null, null, '0521933979', to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1234, 'Andie Hiatt', null, null, '0512984845', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1235, 'Isaiah Mortensen', null, null, '0536434251', null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1236, 'Nile Robbins', null, null, '0592635463', to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1237, 'Jonathan Trevino', null, null, '0546791407', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1238, 'Merillee Lonsdale', null, null, '0516254129', to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1239, 'Rosco Watson', null, null, '0554904178', to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1240, 'Ming-Na Herndon', null, null, '0544016533', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1241, 'Don Mifune', null, null, '0571847731', to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1242, 'Linda Cassel', null, null, '0594140969', to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1243, 'Steve Osborne', null, null, '0549121029', to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1244, 'Rhea Yorn', null, null, '0524201425', to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1245, 'Stevie Morse', null, null, '0585874309', to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1246, 'Leon Nicholas', null, null, '0598626007', to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1247, 'Seth Peterson', null, null, '0557329252', to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1248, 'Rutger Numan', null, null, '0528119072', to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1249, 'Balthazar Moorer', null, null, '0552207678', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1250, 'Kitty Underwood', null, null, '0592772548', to_date('30-06-2021', 'dd-mm-yyyy'));
commit;
prompt 700 records committed...
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1251, 'Belinda Favreau', null, null, '0552711391', to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1252, 'Campbell Gates', null, null, '0574858354', to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1253, 'Victor Affleck', null, null, '0557613615', to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1254, 'Wayne Torn', null, null, '0518275721', to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1255, 'Jonny Lee Arden', null, null, '0589310922', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1256, 'Dianne Cantrell', null, null, '0584327105', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1257, 'Meg Teng', null, null, '0575439293', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1258, 'Judy Browne', null, null, '0532879593', to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1259, 'Gwyneth Avalon', null, null, '0581326426', to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1260, 'Thelma Burstyn', null, null, '0582654519', to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1261, 'Sylvester Warden', null, null, '0593069034', to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1262, 'Oro Webb', null, null, '0597422698', to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1263, 'Rod Borden', null, null, '0539658638', to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1264, 'Debra Randal', null, null, '0525224549', to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1265, 'Thora Lunch', null, null, '0529018856', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1266, 'Cherry Moffat', null, null, '0526537628', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1267, 'Renee O''Donnell', null, null, '0593193048', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1268, 'Crispin Mitra', null, null, '0522175184', null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1269, 'Harry Swinton', null, null, '0525786754', to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1270, 'Ricky Marshall', null, null, '0583714853', to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1271, 'Lena Lloyd', null, null, '0587694066', to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1272, 'Cameron Durning', null, null, '0527882325', null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1273, 'Cuba Broza', null, null, '0531457744', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1274, 'Wally Hart', null, null, '0599472495', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1275, 'Jean-Claude Richards', null, null, '0520581249', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1276, 'Phoebe Shannon', null, null, '0514139511', to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1277, 'Jake Heatherly', null, null, '0544063238', null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1278, 'Edwin Wiest', null, null, '0572519969', to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1279, 'Aaron DeGraw', null, null, '0516072698', to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1280, 'Leelee Ripley', null, null, '0515605021', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1281, 'Isaiah Warwick', null, null, '0514068964', null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1282, 'Paul Duke', null, null, '0561386709', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1283, 'Buffy Browne', null, null, '0593069598', to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1284, 'Javon Wakeling', null, null, '0531644909', to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1285, 'Udo McKellen', null, null, '0537578447', to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1286, 'Alice Faithfull', null, null, '0565680282', to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1287, 'Jonny Lee Taylor', null, null, '0530725470', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1288, 'Lari McIntosh', null, null, '0541459453', to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1289, 'Bonnie Union', null, null, '0592297028', to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1290, 'Dan Nicks', null, null, '0533447345', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1291, 'Johnnie Stanton', null, null, '0590852174', to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1292, 'Kieran Wiest', null, null, '0545739496', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1293, 'Julia Coe', null, null, '0535393372', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1294, 'Murray Close', null, null, '0570623682', to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1295, 'Clive Winslet', null, null, '0513243234', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1296, 'Ving Cruise', null, null, '0549008817', to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1297, 'Denny Olin', null, null, '0513884260', to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1298, 'Selma Haggard', null, null, '0562059138', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1299, 'Ty Guzman', null, null, '0547145151', to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1300, 'Mos Gugino', null, null, '0516351459', to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1301, 'Mary-Louise Cage', null, null, '0591149584', to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1302, 'Larry Costello', null, null, '0592477944', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1303, 'Annette McCabe', null, null, '0558567409', to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1304, 'Juliet Lee', null, null, '0578652534', to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1305, 'Alannah Mollard', null, null, '0592376432', to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1306, 'Edward Nivola', null, null, '0577527631', to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1307, 'Mia Carradine', null, null, '0559896587', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1308, 'Tom Cotton', null, null, '0517657796', to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1309, 'Ted Harry', null, null, '0559348072', to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1310, 'Lee Noseworthy', null, null, '0592718626', to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1311, 'Humberto Paul', null, null, '0541269413', to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1312, 'Jeff Harrelson', null, null, '0570267808', to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1313, 'Lonnie Magnuson', null, null, '0523822653', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1314, 'Micky Moore', null, null, '0565309928', to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1315, 'Donal Pony', null, null, '0545582648', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1316, 'Rickie Ribisi', null, null, '0573413463', to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1317, 'Kenneth Galecki', null, null, '0526216933', to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1318, 'Lizzy Brandt', null, null, '0541451446', null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1319, 'Curtis Quinones', null, null, '0519959868', to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1320, 'Suzanne Dean', null, null, '0572124495', to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1321, 'Alana Spall', null, null, '0554037548', to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1322, 'Kevin Curtis-Hall', null, null, '0553011652', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1323, 'Merle Sawa', null, null, '0525114471', to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1324, 'Pete McAnally', null, null, '0523905570', to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1325, 'Gin Bruce', null, null, '0537257136', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1326, 'Pelvic Solido', null, null, '0535309254', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1327, 'Lindsay Hoskins', null, null, '0550943184', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1328, 'Meredith Avital', null, null, '0543288725', to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1329, 'Claude Torres', null, null, '0592837944', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1330, 'Teena Dawson', null, null, '0536156643', to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1331, 'Angela Iglesias', null, null, '0551897542', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1332, 'Wayman Hamilton', null, null, '0582985125', to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1333, 'Maxine Merchant', null, null, '0599392109', to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1334, 'Art Janney', null, null, '0528471712', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1335, 'Janice Satriani', null, null, '0517105032', to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1336, 'Charles Skerritt', null, null, '0543539059', to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1337, 'Gordie Humphrey', null, null, '0524516802', to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1338, 'Kyle Diaz', null, null, '0547288483', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1339, 'Katie Perry', null, null, '0583632917', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1340, 'Boz Estevez', null, null, '0558301436', null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1341, 'Robby Cornell', null, null, '0560209992', to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1342, 'Desmond Fraser', null, null, '0571885386', to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1343, 'Halle Bergen', null, null, '0515615950', to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1344, 'Salma Mann', null, null, '0537124040', to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1345, 'Anita Buffalo', null, null, '0573506799', to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1346, 'Dylan English', null, null, '0514470444', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1347, 'Vanessa Wainwright', null, null, '0516046315', to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1348, 'Jonny Cozier', null, null, '0565682764', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1349, 'Alan Sampson', null, null, '0528921228', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1350, 'Nikka Seagal', null, null, '0584496965', to_date('30-06-2021', 'dd-mm-yyyy'));
commit;
prompt 800 records committed...
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1351, 'Marley Lithgow', null, null, '0557355636', to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1352, 'Tzi Hanks', null, null, '0594539448', to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1353, 'Joely Galecki', null, null, '0556168759', to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1354, 'Raul Thornton', null, null, '0518399520', to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1355, 'Lara Borgnine', null, null, '0568976925', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1356, 'Wade Conlee', null, null, '0594228416', to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1357, 'Nicole Woodard', null, null, '0556086684', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1358, 'Stellan Craven', null, null, '0591445604', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1359, 'Helen Strathairn', null, null, '0530035715', to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1360, 'Ming-Na Caan', null, null, '0530958097', to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1361, 'Bonnie Morton', null, null, '0560742631', to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1362, 'Paul Wayans', null, null, '0524392397', to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1363, 'Elizabeth Evans', null, null, '0552477111', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1364, 'Teena Schwimmer', null, null, '0551721972', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1365, 'Richie Dorn', null, null, '0510976145', to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1366, 'Chubby Cassidy', null, null, '0579153042', to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1367, 'Gilbert Rispoli', null, null, '0524574528', to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1368, 'Rosie Clooney', null, null, '0574033424', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1369, 'Jay Epps', null, null, '0530758210', to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1370, 'Diane Dushku', null, null, '0560295260', to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1371, 'Samuel Newman', null, null, '0561136729', null);
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1372, 'Tobey Austin', null, null, '0530422658', to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1373, 'Raul Westerberg', null, null, '0599774497', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1374, 'Boz Elizondo', null, null, '0572003895', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1375, 'Charlton Torino', null, null, '0547486450', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1376, 'Omar Hornsby', null, null, '0519044002', to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1377, 'Mika Puckett', null, null, '0566111933', to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1378, 'Geggy Reid', null, null, '0513447054', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1379, 'Adam Bening', null, null, '0571542624', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1380, 'Larnelle Cage', null, null, '0519751440', to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1381, 'Saul Sharp', null, null, '0559787621', to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1382, 'David Osment', null, null, '0520985880', to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1383, 'Tanya Schiff', null, null, '0590744736', to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1384, 'Debi Furtado', null, null, '0597482978', to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1385, 'Daryl Underwood', null, null, '0537653163', to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1386, 'Brittany Thomson', null, null, '0525050320', to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1387, 'Jaime Spacey', null, null, '0539814873', to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1388, 'Maceo Connery', null, null, '0593409355', to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1389, 'Juliana Venora', null, null, '0581535204', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1390, 'Embeth Blackmore', null, null, '0569247054', to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1391, 'Benjamin Hatosy', null, null, '0573392676', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1392, 'Woody Midler', null, null, '0550553615', to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1393, 'Paul Pryce', null, null, '0547563999', to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1394, 'Marianne Marley', null, null, '0531434731', to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1395, 'Cledus Tanon', null, null, '0525161810', to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1396, 'Charlie Pleasence', null, null, '0572021853', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1397, 'Elle Ward', null, null, '0544909112', to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1398, 'Willem Hutch', null, null, '0558485017', to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMER (customerid, name, email, address, phonenumber, lastpurchasedate)
values (1399, 'Nigel Dayne', null, null, '0541628535', to_date('30-12-2020', 'dd-mm-yyyy'));
commit;
prompt 849 records loaded
prompt Loading PRODUCER...
insert into PRODUCER (producerid, producername, price)
values (201, ' Jon Doe', 3347);
insert into PRODUCER (producerid, producername, price)
values (202, ' Jane Roe', 3570);
insert into PRODUCER (producerid, producername, price)
values (203, ' Alice Li', 3793);
insert into PRODUCER (producerid, producername, price)
values (204, ' Bob Lin', 4292);
insert into PRODUCER (producerid, producername, price)
values (205, ' Carol Yu', 3681);
insert into PRODUCER (producerid, producername, price)
values (206, ' Dan Kim', 3905);
insert into PRODUCER (producerid, producername, price)
values (207, ' Eve Wu', 3600);
insert into PRODUCER (producerid, producername, price)
values (208, ' Frank Ho', 4600);
insert into PRODUCER (producerid, producername, price)
values (209, ' Grace Ma', 4240);
insert into PRODUCER (producerid, producername, price)
values (210, ' Henry Xu', 4351);
insert into PRODUCER (producerid, producername, price)
values (211, 'Bob Brown', 9094);
insert into PRODUCER (producerid, producername, price)
values (212, 'John Davis', 8695);
insert into PRODUCER (producerid, producername, price)
values (213, 'Dan Garcia', 9069);
insert into PRODUCER (producerid, producername, price)
values (214, 'Alice Wilson', 6092);
insert into PRODUCER (producerid, producername, price)
values (215, 'Carol Jones', 1590);
insert into PRODUCER (producerid, producername, price)
values (216, 'John Garcia', 4461);
insert into PRODUCER (producerid, producername, price)
values (217, 'John Williams', 8160);
insert into PRODUCER (producerid, producername, price)
values (218, 'Jane Davis', 5922);
insert into PRODUCER (producerid, producername, price)
values (219, 'Jane Brown', 10795);
insert into PRODUCER (producerid, producername, price)
values (220, 'Carol Smith', 4849);
insert into PRODUCER (producerid, producername, price)
values (221, 'Henry Williams', 12206);
insert into PRODUCER (producerid, producername, price)
values (222, 'Jane Wilson', 5523);
insert into PRODUCER (producerid, producername, price)
values (223, 'John Brown', 3830);
insert into PRODUCER (producerid, producername, price)
values (224, 'Alice Miller', 8357);
insert into PRODUCER (producerid, producername, price)
values (225, 'Eve Williams', 4617);
insert into PRODUCER (producerid, producername, price)
values (226, 'Bob Jones', 7566);
insert into PRODUCER (producerid, producername, price)
values (227, 'Grace Williams', 2408);
insert into PRODUCER (producerid, producername, price)
values (228, 'Jane Davis', 1506);
insert into PRODUCER (producerid, producername, price)
values (229, 'Bob Johnson', 4116);
insert into PRODUCER (producerid, producername, price)
values (230, 'Jane Miller', 1497);
insert into PRODUCER (producerid, producername, price)
values (231, 'Frank Johnson', 6201);
insert into PRODUCER (producerid, producername, price)
values (232, 'Carol Brown', 2787);
insert into PRODUCER (producerid, producername, price)
values (233, 'Bob Brown', 8919);
insert into PRODUCER (producerid, producername, price)
values (234, 'Dan Smith', 8764);
insert into PRODUCER (producerid, producername, price)
values (235, 'Jane Brown', 2903);
insert into PRODUCER (producerid, producername, price)
values (236, 'Grace Brown', 1453);
insert into PRODUCER (producerid, producername, price)
values (237, 'Dan Miller', 6106);
insert into PRODUCER (producerid, producername, price)
values (238, 'Dan Smith', 7149);
insert into PRODUCER (producerid, producername, price)
values (239, 'Carol Johnson', 1439);
insert into PRODUCER (producerid, producername, price)
values (240, 'John Jones', 3956);
insert into PRODUCER (producerid, producername, price)
values (241, 'Dan Wilson', 10932);
insert into PRODUCER (producerid, producername, price)
values (242, 'Alice Brown', 2994);
insert into PRODUCER (producerid, producername, price)
values (243, 'Henry Wilson', 8965);
insert into PRODUCER (producerid, producername, price)
values (244, 'Eve Garcia', 1541);
insert into PRODUCER (producerid, producername, price)
values (245, 'Bob Smith', 3876);
insert into PRODUCER (producerid, producername, price)
values (246, 'Frank Garcia', 2899);
insert into PRODUCER (producerid, producername, price)
values (247, 'Dan Smith', 9328);
insert into PRODUCER (producerid, producername, price)
values (248, 'Frank Garcia', 3236);
insert into PRODUCER (producerid, producername, price)
values (249, 'Frank Wilson', 7283);
insert into PRODUCER (producerid, producername, price)
values (250, 'Dan Wilson', 6940);
insert into PRODUCER (producerid, producername, price)
values (251, 'Jane Wilson', 2715);
insert into PRODUCER (producerid, producername, price)
values (252, 'John Johnson', 4596);
insert into PRODUCER (producerid, producername, price)
values (253, 'Frank Williams', 1939);
insert into PRODUCER (producerid, producername, price)
values (254, 'Grace Wilson', 5140);
insert into PRODUCER (producerid, producername, price)
values (255, 'Henry Doe', 7468);
insert into PRODUCER (producerid, producername, price)
values (256, 'Henry Doe', 9651);
insert into PRODUCER (producerid, producername, price)
values (257, 'Eve Doe', 11715);
insert into PRODUCER (producerid, producername, price)
values (258, 'Jane Davis', 2978);
insert into PRODUCER (producerid, producername, price)
values (259, 'Frank Jones', 11561);
insert into PRODUCER (producerid, producername, price)
values (260, 'Jane Wilson', 10651);
insert into PRODUCER (producerid, producername, price)
values (261, 'Bob Doe', 7813);
insert into PRODUCER (producerid, producername, price)
values (262, 'Dan Miller', 6966);
insert into PRODUCER (producerid, producername, price)
values (263, 'John Jones', 2739);
insert into PRODUCER (producerid, producername, price)
values (264, 'Alice Jones', 6272);
insert into PRODUCER (producerid, producername, price)
values (265, 'John Brown', 2473);
insert into PRODUCER (producerid, producername, price)
values (266, 'Alice Miller', 6870);
insert into PRODUCER (producerid, producername, price)
values (267, 'Dan Wilson', 2710);
insert into PRODUCER (producerid, producername, price)
values (268, 'Carol Smith', 7057);
insert into PRODUCER (producerid, producername, price)
values (269, 'Grace Brown', 7572);
insert into PRODUCER (producerid, producername, price)
values (270, 'Eve Johnson', 5262);
insert into PRODUCER (producerid, producername, price)
values (271, 'Alice Johnson', 4626);
insert into PRODUCER (producerid, producername, price)
values (272, 'John Davis', 15275);
insert into PRODUCER (producerid, producername, price)
values (273, 'Grace Jones', 1326);
insert into PRODUCER (producerid, producername, price)
values (274, 'Frank Garcia', 3389);
insert into PRODUCER (producerid, producername, price)
values (275, 'Eve Wilson', 9089);
insert into PRODUCER (producerid, producername, price)
values (276, 'Frank Miller', 7440);
insert into PRODUCER (producerid, producername, price)
values (277, 'Dan Johnson', 10672);
insert into PRODUCER (producerid, producername, price)
values (278, 'Eve Wilson', 3533);
insert into PRODUCER (producerid, producername, price)
values (279, 'Bob Miller', 5766);
insert into PRODUCER (producerid, producername, price)
values (280, 'Eve Smith', 8243);
insert into PRODUCER (producerid, producername, price)
values (281, 'John Brown', 6943);
insert into PRODUCER (producerid, producername, price)
values (282, 'Grace Williams', 2480);
insert into PRODUCER (producerid, producername, price)
values (283, 'Henry Doe', 6497);
insert into PRODUCER (producerid, producername, price)
values (284, 'Frank Davis', 8289);
insert into PRODUCER (producerid, producername, price)
values (285, 'Carol Williams', 10109);
insert into PRODUCER (producerid, producername, price)
values (286, 'Eve Garcia', 7840);
insert into PRODUCER (producerid, producername, price)
values (287, 'Eve Davis', 5821);
insert into PRODUCER (producerid, producername, price)
values (288, 'Henry Doe', 3394);
insert into PRODUCER (producerid, producername, price)
values (289, 'Alice Williams', 13317);
insert into PRODUCER (producerid, producername, price)
values (290, 'Eve Garcia', 2652);
insert into PRODUCER (producerid, producername, price)
values (291, 'John Williams', 4265);
insert into PRODUCER (producerid, producername, price)
values (292, 'Carol Williams', 13707);
insert into PRODUCER (producerid, producername, price)
values (293, 'Dan Williams', 8956);
insert into PRODUCER (producerid, producername, price)
values (294, 'Carol Williams', 3073);
insert into PRODUCER (producerid, producername, price)
values (295, 'Henry Doe', 4023);
insert into PRODUCER (producerid, producername, price)
values (296, 'Alice Davis', 7730);
insert into PRODUCER (producerid, producername, price)
values (297, 'John Garcia', 11140);
insert into PRODUCER (producerid, producername, price)
values (298, 'Eve Jones', 3590);
insert into PRODUCER (producerid, producername, price)
values (299, 'John Brown', 6188);
insert into PRODUCER (producerid, producername, price)
values (300, 'Grace Jones', 5862);
commit;
prompt 100 records committed...
insert into PRODUCER (producerid, producername, price)
values (301, 'Jane Jones', 2583);
insert into PRODUCER (producerid, producername, price)
values (302, 'Grace Brown', 9838);
insert into PRODUCER (producerid, producername, price)
values (303, 'Eve Smith', 5260);
insert into PRODUCER (producerid, producername, price)
values (304, 'Alice Williams', 6029);
insert into PRODUCER (producerid, producername, price)
values (305, 'Eve Davis', 4204);
insert into PRODUCER (producerid, producername, price)
values (306, 'Frank Garcia', 3022);
insert into PRODUCER (producerid, producername, price)
values (307, 'Alice Smith', 1880);
insert into PRODUCER (producerid, producername, price)
values (308, 'Frank Wilson', 13229);
insert into PRODUCER (producerid, producername, price)
values (309, 'Eve Brown', 6083);
insert into PRODUCER (producerid, producername, price)
values (310, 'Henry Miller', 6447);
insert into PRODUCER (producerid, producername, price)
values (311, 'Carol Garcia', 6079);
insert into PRODUCER (producerid, producername, price)
values (312, 'Frank Brown', 1725);
insert into PRODUCER (producerid, producername, price)
values (313, 'Grace Jones', 8605);
insert into PRODUCER (producerid, producername, price)
values (314, 'Henry Williams', 7909);
insert into PRODUCER (producerid, producername, price)
values (315, 'Grace Johnson', 9924);
insert into PRODUCER (producerid, producername, price)
values (316, 'John Miller', 4450);
insert into PRODUCER (producerid, producername, price)
values (317, 'Bob Brown', 3158);
insert into PRODUCER (producerid, producername, price)
values (318, 'Dan Davis', 2126);
insert into PRODUCER (producerid, producername, price)
values (319, 'Henry Davis', 4297);
insert into PRODUCER (producerid, producername, price)
values (320, 'Eve Miller', 7206);
insert into PRODUCER (producerid, producername, price)
values (321, 'John Miller', 8987);
insert into PRODUCER (producerid, producername, price)
values (322, 'Frank Wilson', 6896);
insert into PRODUCER (producerid, producername, price)
values (323, 'Frank Garcia', 2536);
insert into PRODUCER (producerid, producername, price)
values (324, 'Eve Williams', 5819);
insert into PRODUCER (producerid, producername, price)
values (325, 'John Brown', 11673);
insert into PRODUCER (producerid, producername, price)
values (326, 'Eve Williams', 3379);
insert into PRODUCER (producerid, producername, price)
values (327, 'Grace Jones', 1869);
insert into PRODUCER (producerid, producername, price)
values (328, 'Eve Doe', 7206);
insert into PRODUCER (producerid, producername, price)
values (329, 'Henry Smith', 7949);
insert into PRODUCER (producerid, producername, price)
values (330, 'Alice Johnson', 3854);
insert into PRODUCER (producerid, producername, price)
values (331, 'Dan Garcia', 8063);
insert into PRODUCER (producerid, producername, price)
values (332, 'Eve Williams', 2338);
insert into PRODUCER (producerid, producername, price)
values (333, 'Jane Johnson', 9430);
insert into PRODUCER (producerid, producername, price)
values (334, 'Frank Jones', 6214);
insert into PRODUCER (producerid, producername, price)
values (335, 'Eve Smith', 10947);
insert into PRODUCER (producerid, producername, price)
values (336, 'Alice Johnson', 8851);
insert into PRODUCER (producerid, producername, price)
values (337, 'Carol Brown', 1791);
insert into PRODUCER (producerid, producername, price)
values (338, 'Bob Johnson', 7898);
insert into PRODUCER (producerid, producername, price)
values (339, 'Grace Doe', 3136);
insert into PRODUCER (producerid, producername, price)
values (340, 'Bob Brown', 6773);
insert into PRODUCER (producerid, producername, price)
values (341, 'Henry Garcia', 3761);
insert into PRODUCER (producerid, producername, price)
values (342, 'Alice Davis', 8657);
insert into PRODUCER (producerid, producername, price)
values (343, 'Jane Johnson', 5940);
insert into PRODUCER (producerid, producername, price)
values (344, 'Alice Miller', 6770);
insert into PRODUCER (producerid, producername, price)
values (345, 'Grace Johnson', 1657);
insert into PRODUCER (producerid, producername, price)
values (346, 'Eve Davis', 3869);
insert into PRODUCER (producerid, producername, price)
values (347, 'Henry Wilson', 4034);
insert into PRODUCER (producerid, producername, price)
values (348, 'Grace Garcia', 3321);
insert into PRODUCER (producerid, producername, price)
values (349, 'Jane Doe', 1323);
insert into PRODUCER (producerid, producername, price)
values (350, 'Henry Davis', 2976);
insert into PRODUCER (producerid, producername, price)
values (351, 'Eve Brown', 8802);
insert into PRODUCER (producerid, producername, price)
values (352, 'Carol Miller', 6568);
insert into PRODUCER (producerid, producername, price)
values (353, 'Frank Smith', 3604);
insert into PRODUCER (producerid, producername, price)
values (354, 'Jane Davis', 1663);
insert into PRODUCER (producerid, producername, price)
values (355, 'Dan Miller', 4737);
insert into PRODUCER (producerid, producername, price)
values (356, 'Alice Jones', 6109);
insert into PRODUCER (producerid, producername, price)
values (357, 'Grace Davis', 3570);
insert into PRODUCER (producerid, producername, price)
values (358, 'Carol Miller', 3366);
insert into PRODUCER (producerid, producername, price)
values (359, 'John Doe', 11465);
insert into PRODUCER (producerid, producername, price)
values (360, 'Jane Brown', 12084);
insert into PRODUCER (producerid, producername, price)
values (361, 'Frank Smith', 1985);
insert into PRODUCER (producerid, producername, price)
values (362, 'Jane Doe', 2975);
insert into PRODUCER (producerid, producername, price)
values (363, 'Alice Johnson', 10691);
insert into PRODUCER (producerid, producername, price)
values (364, 'Alice Doe', 6580);
insert into PRODUCER (producerid, producername, price)
values (365, 'John Johnson', 11979);
insert into PRODUCER (producerid, producername, price)
values (366, 'Dan Smith', 2954);
insert into PRODUCER (producerid, producername, price)
values (367, 'Carol Smith', 1587);
insert into PRODUCER (producerid, producername, price)
values (368, 'Jane Jones', 1306);
insert into PRODUCER (producerid, producername, price)
values (369, 'Henry Brown', 2991);
insert into PRODUCER (producerid, producername, price)
values (370, 'John Miller', 11141);
insert into PRODUCER (producerid, producername, price)
values (371, 'Henry Doe', 3203);
insert into PRODUCER (producerid, producername, price)
values (372, 'Eve Smith', 2984);
insert into PRODUCER (producerid, producername, price)
values (373, 'Jane Jones', 2442);
insert into PRODUCER (producerid, producername, price)
values (374, 'Bob Smith', 7664);
insert into PRODUCER (producerid, producername, price)
values (375, 'Dan Garcia', 5372);
insert into PRODUCER (producerid, producername, price)
values (376, 'Dan Smith', 5086);
insert into PRODUCER (producerid, producername, price)
values (377, 'Eve Doe', 2930);
insert into PRODUCER (producerid, producername, price)
values (378, 'Bob Smith', 7318);
insert into PRODUCER (producerid, producername, price)
values (379, 'Grace Garcia', 1388);
insert into PRODUCER (producerid, producername, price)
values (380, 'Frank Doe', 3907);
insert into PRODUCER (producerid, producername, price)
values (381, 'Alice Jones', 11114);
insert into PRODUCER (producerid, producername, price)
values (382, 'Henry Williams', 10495);
insert into PRODUCER (producerid, producername, price)
values (383, 'Frank Wilson', 3242);
insert into PRODUCER (producerid, producername, price)
values (384, 'Eve Smith', 9749);
insert into PRODUCER (producerid, producername, price)
values (385, 'Bob Williams', 9390);
insert into PRODUCER (producerid, producername, price)
values (386, 'Grace Garcia', 7228);
insert into PRODUCER (producerid, producername, price)
values (387, 'Dan Williams', 2781);
insert into PRODUCER (producerid, producername, price)
values (388, 'Carol Doe', 3561);
insert into PRODUCER (producerid, producername, price)
values (389, 'Bob Miller', 3036);
insert into PRODUCER (producerid, producername, price)
values (390, 'Grace Wilson', 8633);
insert into PRODUCER (producerid, producername, price)
values (391, 'Eve Brown', 5058);
insert into PRODUCER (producerid, producername, price)
values (392, 'Dan Brown', 8193);
insert into PRODUCER (producerid, producername, price)
values (393, 'Eve Wilson', 6174);
insert into PRODUCER (producerid, producername, price)
values (394, 'Carol Doe', 5329);
insert into PRODUCER (producerid, producername, price)
values (395, 'Eve Davis', 5384);
insert into PRODUCER (producerid, producername, price)
values (396, 'Bob Wilson', 4760);
insert into PRODUCER (producerid, producername, price)
values (397, 'Dan Johnson', 7722);
insert into PRODUCER (producerid, producername, price)
values (398, 'Jane Brown', 1638);
insert into PRODUCER (producerid, producername, price)
values (399, 'Carol Williams', 9349);
insert into PRODUCER (producerid, producername, price)
values (400, 'Dan Davis', 7172);
commit;
prompt 200 records committed...
insert into PRODUCER (producerid, producername, price)
values (401, 'Eve Miller', 10153);
insert into PRODUCER (producerid, producername, price)
values (402, 'Dan Johnson', 1452);
insert into PRODUCER (producerid, producername, price)
values (403, 'Alice Jones', 6918);
insert into PRODUCER (producerid, producername, price)
values (404, 'Eve Williams', 6007);
insert into PRODUCER (producerid, producername, price)
values (405, 'Jane Brown', 3372);
insert into PRODUCER (producerid, producername, price)
values (406, 'Jane Wilson', 10012);
insert into PRODUCER (producerid, producername, price)
values (407, 'Alice Smith', 5606);
insert into PRODUCER (producerid, producername, price)
values (408, 'Jane Davis', 9473);
insert into PRODUCER (producerid, producername, price)
values (409, 'Henry Smith', 8652);
insert into PRODUCER (producerid, producername, price)
values (410, 'John Doe', 7139);
insert into PRODUCER (producerid, producername, price)
values (411, 'Eve Johnson', 2181);
insert into PRODUCER (producerid, producername, price)
values (412, 'Eve Williams', 6434);
insert into PRODUCER (producerid, producername, price)
values (413, 'Bob Miller', 3319);
insert into PRODUCER (producerid, producername, price)
values (414, 'Frank Jones', 1362);
insert into PRODUCER (producerid, producername, price)
values (415, 'Frank Wilson', 6173);
insert into PRODUCER (producerid, producername, price)
values (416, 'Bob Wilson', 4777);
insert into PRODUCER (producerid, producername, price)
values (417, 'Carol Miller', 2071);
insert into PRODUCER (producerid, producername, price)
values (418, 'Grace Smith', 9465);
insert into PRODUCER (producerid, producername, price)
values (419, 'Bob Williams', 1432);
insert into PRODUCER (producerid, producername, price)
values (420, 'Dan Williams', 2870);
insert into PRODUCER (producerid, producername, price)
values (421, 'Frank Johnson', 2032);
insert into PRODUCER (producerid, producername, price)
values (422, 'Alice Garcia', 6437);
insert into PRODUCER (producerid, producername, price)
values (423, 'Grace Jones', 10434);
insert into PRODUCER (producerid, producername, price)
values (424, 'Eve Jones', 5618);
insert into PRODUCER (producerid, producername, price)
values (425, 'John Garcia', 6999);
insert into PRODUCER (producerid, producername, price)
values (426, 'Henry Davis', 1971);
insert into PRODUCER (producerid, producername, price)
values (427, 'John Brown', 1310);
insert into PRODUCER (producerid, producername, price)
values (428, 'Bob Brown', 11072);
insert into PRODUCER (producerid, producername, price)
values (429, 'Alice Williams', 9205);
insert into PRODUCER (producerid, producername, price)
values (430, 'Carol Doe', 8024);
insert into PRODUCER (producerid, producername, price)
values (431, 'Jane Garcia', 10960);
insert into PRODUCER (producerid, producername, price)
values (432, 'Jane Jones', 9283);
insert into PRODUCER (producerid, producername, price)
values (433, 'Grace Brown', 6619);
insert into PRODUCER (producerid, producername, price)
values (434, 'Dan Garcia', 3647);
insert into PRODUCER (producerid, producername, price)
values (435, 'Carol Garcia', 4542);
insert into PRODUCER (producerid, producername, price)
values (436, 'Eve Garcia', 7099);
insert into PRODUCER (producerid, producername, price)
values (437, 'John Johnson', 7470);
insert into PRODUCER (producerid, producername, price)
values (438, 'Bob Wilson', 2340);
insert into PRODUCER (producerid, producername, price)
values (439, 'Bob Doe', 6995);
insert into PRODUCER (producerid, producername, price)
values (440, 'Jane Williams', 3320);
insert into PRODUCER (producerid, producername, price)
values (441, 'Grace Wilson', 3091);
insert into PRODUCER (producerid, producername, price)
values (442, 'Carol Davis', 2616);
insert into PRODUCER (producerid, producername, price)
values (443, 'John Johnson', 4622);
insert into PRODUCER (producerid, producername, price)
values (444, 'Grace Doe', 8529);
insert into PRODUCER (producerid, producername, price)
values (445, 'Dan Doe', 8854);
insert into PRODUCER (producerid, producername, price)
values (446, 'Henry Jones', 2179);
insert into PRODUCER (producerid, producername, price)
values (447, 'Eve Wilson', 6187);
insert into PRODUCER (producerid, producername, price)
values (448, 'Henry Wilson', 6140);
insert into PRODUCER (producerid, producername, price)
values (449, 'Carol Wilson', 9835);
insert into PRODUCER (producerid, producername, price)
values (450, 'Jane Doe', 7825);
insert into PRODUCER (producerid, producername, price)
values (451, 'Carol Wilson', 3108);
insert into PRODUCER (producerid, producername, price)
values (452, 'Alice Williams', 10666);
insert into PRODUCER (producerid, producername, price)
values (453, 'John Wilson', 1292);
insert into PRODUCER (producerid, producername, price)
values (454, 'Eve Miller', 1468);
insert into PRODUCER (producerid, producername, price)
values (455, 'Carol Williams', 9752);
insert into PRODUCER (producerid, producername, price)
values (456, 'Carol Davis', 4678);
insert into PRODUCER (producerid, producername, price)
values (457, 'Grace Miller', 7029);
insert into PRODUCER (producerid, producername, price)
values (458, 'Frank Williams', 9767);
insert into PRODUCER (producerid, producername, price)
values (459, 'Grace Garcia', 2721);
insert into PRODUCER (producerid, producername, price)
values (460, 'Grace Doe', 11744);
insert into PRODUCER (producerid, producername, price)
values (461, 'Grace Jones', 6787);
insert into PRODUCER (producerid, producername, price)
values (462, 'Carol Miller', 9710);
insert into PRODUCER (producerid, producername, price)
values (463, 'Dan Jones', 4894);
insert into PRODUCER (producerid, producername, price)
values (464, 'Alice Brown', 4304);
insert into PRODUCER (producerid, producername, price)
values (465, 'Carol Johnson', 6642);
insert into PRODUCER (producerid, producername, price)
values (466, 'Eve Brown', 5125);
insert into PRODUCER (producerid, producername, price)
values (467, 'Dan Brown', 2788);
insert into PRODUCER (producerid, producername, price)
values (468, 'Alice Davis', 8991);
insert into PRODUCER (producerid, producername, price)
values (469, 'Dan Smith', 1382);
insert into PRODUCER (producerid, producername, price)
values (470, 'Grace Williams', 6666);
insert into PRODUCER (producerid, producername, price)
values (471, 'Henry Johnson', 9007);
insert into PRODUCER (producerid, producername, price)
values (472, 'Bob Miller', 5359);
insert into PRODUCER (producerid, producername, price)
values (473, 'John Brown', 2352);
insert into PRODUCER (producerid, producername, price)
values (474, 'Dan Williams', 3887);
insert into PRODUCER (producerid, producername, price)
values (475, 'Grace Doe', 8302);
insert into PRODUCER (producerid, producername, price)
values (476, 'Alice Jones', 6329);
insert into PRODUCER (producerid, producername, price)
values (477, 'Carol Garcia', 10483);
insert into PRODUCER (producerid, producername, price)
values (478, 'Alice Davis', 4835);
insert into PRODUCER (producerid, producername, price)
values (479, 'Frank Doe', 5851);
insert into PRODUCER (producerid, producername, price)
values (480, 'Eve Davis', 11096);
insert into PRODUCER (producerid, producername, price)
values (481, 'Grace Smith', 8593);
insert into PRODUCER (producerid, producername, price)
values (482, 'Bob Johnson', 6978);
insert into PRODUCER (producerid, producername, price)
values (483, 'Eve Garcia', 7009);
insert into PRODUCER (producerid, producername, price)
values (484, 'Dan Doe', 3979);
insert into PRODUCER (producerid, producername, price)
values (485, 'Carol Jones', 4819);
insert into PRODUCER (producerid, producername, price)
values (486, 'Bob Jones', 7381);
insert into PRODUCER (producerid, producername, price)
values (487, 'Dan Garcia', 4272);
insert into PRODUCER (producerid, producername, price)
values (488, 'Jane Brown', 8458);
insert into PRODUCER (producerid, producername, price)
values (489, 'Eve Miller', 2547);
insert into PRODUCER (producerid, producername, price)
values (490, 'John Smith', 6612);
insert into PRODUCER (producerid, producername, price)
values (491, 'Jane Jones', 4837);
insert into PRODUCER (producerid, producername, price)
values (492, 'Carol Brown', 10813);
insert into PRODUCER (producerid, producername, price)
values (493, 'Dan Johnson', 8598);
insert into PRODUCER (producerid, producername, price)
values (494, 'Henry Wilson', 1580);
insert into PRODUCER (producerid, producername, price)
values (495, 'Henry Williams', 5278);
insert into PRODUCER (producerid, producername, price)
values (496, 'Eve Davis', 4658);
insert into PRODUCER (producerid, producername, price)
values (497, 'Bob Jones', 7978);
insert into PRODUCER (producerid, producername, price)
values (498, 'Alice Johnson', 3396);
insert into PRODUCER (producerid, producername, price)
values (499, 'Eve Garcia', 4436);
insert into PRODUCER (producerid, producername, price)
values (500, 'John Miller', 1372);
commit;
prompt 300 records committed...
insert into PRODUCER (producerid, producername, price)
values (501, 'Carol Miller', 1189);
insert into PRODUCER (producerid, producername, price)
values (502, 'Henry Garcia', 1538);
insert into PRODUCER (producerid, producername, price)
values (503, 'Frank Jones', 6167);
insert into PRODUCER (producerid, producername, price)
values (504, 'Dan Miller', 6859);
insert into PRODUCER (producerid, producername, price)
values (505, 'Jane Williams', 3905);
insert into PRODUCER (producerid, producername, price)
values (506, 'John Johnson', 5627);
insert into PRODUCER (producerid, producername, price)
values (507, 'Grace Davis', 6470);
insert into PRODUCER (producerid, producername, price)
values (508, 'Carol Davis', 7743);
insert into PRODUCER (producerid, producername, price)
values (509, 'Frank Johnson', 3765);
insert into PRODUCER (producerid, producername, price)
values (510, 'Carol Wilson', 8555);
insert into PRODUCER (producerid, producername, price)
values (511, 'Henry Wilson', 8490);
insert into PRODUCER (producerid, producername, price)
values (512, 'Dan Miller', 5874);
insert into PRODUCER (producerid, producername, price)
values (513, 'Jane Johnson', 6645);
insert into PRODUCER (producerid, producername, price)
values (514, 'Bob Davis', 6695);
insert into PRODUCER (producerid, producername, price)
values (515, 'Jane Wilson', 5201);
insert into PRODUCER (producerid, producername, price)
values (516, 'Eve Miller', 5224);
insert into PRODUCER (producerid, producername, price)
values (517, 'Carol Davis', 3305);
insert into PRODUCER (producerid, producername, price)
values (518, 'Henry Johnson', 4580);
insert into PRODUCER (producerid, producername, price)
values (519, 'Jane Davis', 2794);
insert into PRODUCER (producerid, producername, price)
values (520, 'Carol Miller', 4261);
insert into PRODUCER (producerid, producername, price)
values (521, 'Carol Davis', 11577);
insert into PRODUCER (producerid, producername, price)
values (522, 'Frank Brown', 2221);
insert into PRODUCER (producerid, producername, price)
values (523, 'Dan Brown', 2236);
insert into PRODUCER (producerid, producername, price)
values (524, 'Bob Smith', 2372);
insert into PRODUCER (producerid, producername, price)
values (525, 'Frank Williams', 2801);
insert into PRODUCER (producerid, producername, price)
values (526, 'Dan Williams', 5681);
insert into PRODUCER (producerid, producername, price)
values (527, 'Bob Jones', 6858);
insert into PRODUCER (producerid, producername, price)
values (528, 'Frank Brown', 3545);
insert into PRODUCER (producerid, producername, price)
values (529, 'Jane Davis', 11228);
insert into PRODUCER (producerid, producername, price)
values (530, 'Frank Johnson', 8349);
insert into PRODUCER (producerid, producername, price)
values (531, 'Alice Johnson', 8555);
insert into PRODUCER (producerid, producername, price)
values (532, 'Alice Garcia', 5704);
insert into PRODUCER (producerid, producername, price)
values (533, 'Carol Jones', 3464);
insert into PRODUCER (producerid, producername, price)
values (534, 'Henry Smith', 7311);
insert into PRODUCER (producerid, producername, price)
values (535, 'Dan Doe', 5310);
insert into PRODUCER (producerid, producername, price)
values (536, 'Jane Miller', 6658);
insert into PRODUCER (producerid, producername, price)
values (537, 'Frank Johnson', 12161);
insert into PRODUCER (producerid, producername, price)
values (538, 'John Miller', 6294);
insert into PRODUCER (producerid, producername, price)
values (539, 'Dan Doe', 3444);
insert into PRODUCER (producerid, producername, price)
values (540, 'John Williams', 2649);
insert into PRODUCER (producerid, producername, price)
values (541, 'Eve Williams', 1523);
insert into PRODUCER (producerid, producername, price)
values (542, 'Frank Doe', 2943);
insert into PRODUCER (producerid, producername, price)
values (543, 'Eve Garcia', 10604);
insert into PRODUCER (producerid, producername, price)
values (544, 'Henry Wilson', 3575);
insert into PRODUCER (producerid, producername, price)
values (545, 'Henry Jones', 4834);
insert into PRODUCER (producerid, producername, price)
values (546, 'John Miller', 6855);
insert into PRODUCER (producerid, producername, price)
values (547, 'Eve Brown', 4677);
insert into PRODUCER (producerid, producername, price)
values (548, 'Grace Smith', 9601);
insert into PRODUCER (producerid, producername, price)
values (549, 'Eve Johnson', 3231);
insert into PRODUCER (producerid, producername, price)
values (550, 'Bob Jones', 7836);
insert into PRODUCER (producerid, producername, price)
values (551, 'Alice Garcia', 5100);
insert into PRODUCER (producerid, producername, price)
values (552, 'Alice Garcia', 5068);
insert into PRODUCER (producerid, producername, price)
values (553, 'Alice Brown', 7691);
insert into PRODUCER (producerid, producername, price)
values (554, 'Eve Davis', 5835);
insert into PRODUCER (producerid, producername, price)
values (555, 'Henry Jones', 7063);
insert into PRODUCER (producerid, producername, price)
values (556, 'Eve Johnson', 9649);
insert into PRODUCER (producerid, producername, price)
values (557, 'Alice Davis', 7094);
insert into PRODUCER (producerid, producername, price)
values (558, 'Carol Brown', 9139);
insert into PRODUCER (producerid, producername, price)
values (559, 'Henry Doe', 6115);
insert into PRODUCER (producerid, producername, price)
values (560, 'Alice Johnson', 3248);
insert into PRODUCER (producerid, producername, price)
values (561, 'Henry Miller', 1907);
insert into PRODUCER (producerid, producername, price)
values (562, 'John Garcia', 8497);
insert into PRODUCER (producerid, producername, price)
values (563, 'Alice Smith', 8701);
insert into PRODUCER (producerid, producername, price)
values (564, 'Dan Johnson', 4592);
insert into PRODUCER (producerid, producername, price)
values (565, 'Henry Garcia', 8824);
insert into PRODUCER (producerid, producername, price)
values (566, 'Carol Wilson', 4759);
insert into PRODUCER (producerid, producername, price)
values (567, 'Frank Smith', 3351);
insert into PRODUCER (producerid, producername, price)
values (568, 'Frank Miller', 5425);
insert into PRODUCER (producerid, producername, price)
values (569, 'Dan Williams', 1654);
insert into PRODUCER (producerid, producername, price)
values (570, 'Jane Williams', 3934);
insert into PRODUCER (producerid, producername, price)
values (571, 'Grace Doe', 7478);
insert into PRODUCER (producerid, producername, price)
values (572, 'John Wilson', 4282);
insert into PRODUCER (producerid, producername, price)
values (573, 'Henry Garcia', 11121);
insert into PRODUCER (producerid, producername, price)
values (574, 'Grace Davis', 1450);
insert into PRODUCER (producerid, producername, price)
values (575, 'Dan Williams', 3163);
insert into PRODUCER (producerid, producername, price)
values (576, 'John Johnson', 3601);
insert into PRODUCER (producerid, producername, price)
values (577, 'Eve Williams', 6224);
insert into PRODUCER (producerid, producername, price)
values (578, 'Grace Garcia', 6563);
insert into PRODUCER (producerid, producername, price)
values (579, 'Alice Johnson', 6973);
insert into PRODUCER (producerid, producername, price)
values (580, 'John Wilson', 10947);
insert into PRODUCER (producerid, producername, price)
values (581, 'Jane Williams', 5562);
insert into PRODUCER (producerid, producername, price)
values (582, 'Grace Smith', 3134);
insert into PRODUCER (producerid, producername, price)
values (583, 'Dan Doe', 3172);
insert into PRODUCER (producerid, producername, price)
values (584, 'John Doe', 6436);
insert into PRODUCER (producerid, producername, price)
values (585, 'Bob Garcia', 9456);
insert into PRODUCER (producerid, producername, price)
values (586, 'Jane Johnson', 2353);
insert into PRODUCER (producerid, producername, price)
values (587, 'Eve Miller', 7767);
insert into PRODUCER (producerid, producername, price)
values (588, 'Frank Garcia', 5375);
insert into PRODUCER (producerid, producername, price)
values (589, 'Bob Miller', 10479);
insert into PRODUCER (producerid, producername, price)
values (590, 'Alice Miller', 10753);
insert into PRODUCER (producerid, producername, price)
values (591, 'Henry Smith', 7738);
insert into PRODUCER (producerid, producername, price)
values (592, 'Grace Williams', 6328);
insert into PRODUCER (producerid, producername, price)
values (593, 'Bob Wilson', 12329);
insert into PRODUCER (producerid, producername, price)
values (594, 'Frank Jones', 10964);
insert into PRODUCER (producerid, producername, price)
values (595, 'Carol Williams', 2084);
insert into PRODUCER (producerid, producername, price)
values (596, 'Grace Williams', 2403);
insert into PRODUCER (producerid, producername, price)
values (597, 'Eve Johnson', 4166);
insert into PRODUCER (producerid, producername, price)
values (598, 'Alice Johnson', 7395);
insert into PRODUCER (producerid, producername, price)
values (599, 'Grace Williams', 6121);
insert into PRODUCER (producerid, producername, price)
values (600, 'Carol Jones', 1713);
commit;
prompt 400 records committed...
insert into PRODUCER (producerid, producername, price)
values (601, 'Grace Will', 5000);
commit;
prompt 401 records loaded
prompt Loading SINGER...
insert into SINGER (singername, singerid, price)
values (' Alice Johnson', 3, 4800);
insert into SINGER (singername, singerid, price)
values (' Michael Wilson', 6, 4900);
insert into SINGER (singername, singerid, price)
values (' David White', 8, 4600);
insert into SINGER (singername, singerid, price)
values (' Laura Harris', 9, 5100);
insert into SINGER (singername, singerid, price)
values (' James Clark', 10, 5400);
insert into SINGER (singername, singerid, price)
values ('Frank Garcia', 11, 4911);
insert into SINGER (singername, singerid, price)
values ('Dan Smith', 13, 6473);
insert into SINGER (singername, singerid, price)
values ('Dan Smith', 21, 9381);
insert into SINGER (singername, singerid, price)
values ('Jane Williams', 23, 5408);
insert into SINGER (singername, singerid, price)
values ('Carol Williams', 25, 4508);
insert into SINGER (singername, singerid, price)
values ('Frank Miller', 26, 1487);
insert into SINGER (singername, singerid, price)
values ('Henry Garcia', 27, 1747);
insert into SINGER (singername, singerid, price)
values ('Carol Garcia', 29, 4544);
insert into SINGER (singername, singerid, price)
values ('Jane Smith', 30, 1894);
insert into SINGER (singername, singerid, price)
values ('Alice Miller', 32, 1996);
insert into SINGER (singername, singerid, price)
values ('Jane Garcia', 33, 8475);
insert into SINGER (singername, singerid, price)
values ('Jane Miller', 34, 1051);
insert into SINGER (singername, singerid, price)
values ('Jane Miller', 36, 5556);
insert into SINGER (singername, singerid, price)
values ('Frank Jones', 37, 3422);
insert into SINGER (singername, singerid, price)
values ('Eve Johnson', 38, 6343);
insert into SINGER (singername, singerid, price)
values ('Carol Johnson', 40, 1961);
insert into SINGER (singername, singerid, price)
values ('Alice Garcia', 41, 2756);
insert into SINGER (singername, singerid, price)
values ('Grace Doe', 42, 6231);
insert into SINGER (singername, singerid, price)
values ('Frank Smith', 43, 8439);
insert into SINGER (singername, singerid, price)
values ('Frank Davis', 44, 3239);
insert into SINGER (singername, singerid, price)
values ('Bob Miller', 46, 8936);
insert into SINGER (singername, singerid, price)
values ('Frank Johnson', 50, 9606);
insert into SINGER (singername, singerid, price)
values ('Alice Brown', 52, 6884);
insert into SINGER (singername, singerid, price)
values ('Eve Miller', 54, 8006);
insert into SINGER (singername, singerid, price)
values ('Grace Miller', 58, 3766);
insert into SINGER (singername, singerid, price)
values ('Henry Doe', 60, 2894);
insert into SINGER (singername, singerid, price)
values ('Jane Davis', 62, 7855);
insert into SINGER (singername, singerid, price)
values ('Alice Davis', 63, 1979);
insert into SINGER (singername, singerid, price)
values ('Dan Johnson', 65, 9696);
insert into SINGER (singername, singerid, price)
values ('Dan Wilson', 68, 6812);
insert into SINGER (singername, singerid, price)
values ('Bob Jones', 69, 9008);
insert into SINGER (singername, singerid, price)
values ('Dan Garcia', 70, 8952);
insert into SINGER (singername, singerid, price)
values ('John Miller', 72, 1709);
insert into SINGER (singername, singerid, price)
values ('Frank Doe', 73, 5552);
insert into SINGER (singername, singerid, price)
values ('John Doe', 74, 9101);
insert into SINGER (singername, singerid, price)
values ('Eve Smith', 76, 1374);
insert into SINGER (singername, singerid, price)
values ('Frank Johnson', 77, 8904);
insert into SINGER (singername, singerid, price)
values ('Frank Brown', 81, 2765);
insert into SINGER (singername, singerid, price)
values ('Alice Garcia', 86, 6870);
insert into SINGER (singername, singerid, price)
values ('Henry Johnson', 87, 2101);
insert into SINGER (singername, singerid, price)
values ('Frank Davis', 88, 8177);
insert into SINGER (singername, singerid, price)
values ('Henry Smith', 89, 8483);
insert into SINGER (singername, singerid, price)
values ('Jane Smith', 92, 4337);
insert into SINGER (singername, singerid, price)
values ('Eve Brown', 93, 5219);
insert into SINGER (singername, singerid, price)
values ('Eve Williams', 94, 6317);
insert into SINGER (singername, singerid, price)
values ('Eve Johnson', 95, 5195);
insert into SINGER (singername, singerid, price)
values ('Henry Jones', 96, 8406);
insert into SINGER (singername, singerid, price)
values ('Carol Smith', 97, 3389);
insert into SINGER (singername, singerid, price)
values ('Jane Davis', 99, 8329);
insert into SINGER (singername, singerid, price)
values ('Bob Johnson', 101, 4788);
insert into SINGER (singername, singerid, price)
values ('Grace Jones', 103, 6921);
insert into SINGER (singername, singerid, price)
values ('Eve Johnson', 107, 1642);
insert into SINGER (singername, singerid, price)
values ('John Smith', 108, 5671);
insert into SINGER (singername, singerid, price)
values ('Jane Jones', 109, 9317);
insert into SINGER (singername, singerid, price)
values ('Bob Miller', 111, 5510);
insert into SINGER (singername, singerid, price)
values ('Jane Doe', 112, 7325);
insert into SINGER (singername, singerid, price)
values ('Eve Williams', 119, 8967);
insert into SINGER (singername, singerid, price)
values ('Frank Garcia', 124, 8758);
insert into SINGER (singername, singerid, price)
values ('Henry Doe', 128, 9130);
insert into SINGER (singername, singerid, price)
values ('Dan Davis', 130, 5813);
insert into SINGER (singername, singerid, price)
values ('Frank Johnson', 131, 9328);
insert into SINGER (singername, singerid, price)
values ('Alice Brown', 135, 7191);
insert into SINGER (singername, singerid, price)
values ('Frank Doe', 136, 9247);
insert into SINGER (singername, singerid, price)
values ('Alice Doe', 137, 7481);
insert into SINGER (singername, singerid, price)
values ('Henry Smith', 138, 8995);
insert into SINGER (singername, singerid, price)
values ('Carol Doe', 139, 7859);
insert into SINGER (singername, singerid, price)
values ('Jane Williams', 140, 9882);
insert into SINGER (singername, singerid, price)
values ('Jane Brown', 141, 3015);
insert into SINGER (singername, singerid, price)
values ('Bob Smith', 142, 6290);
insert into SINGER (singername, singerid, price)
values ('Jane Smith', 143, 6775);
insert into SINGER (singername, singerid, price)
values ('Jane Doe', 148, 5772);
insert into SINGER (singername, singerid, price)
values ('Bob Jones', 149, 6595);
insert into SINGER (singername, singerid, price)
values ('Jane Miller', 150, 5120);
insert into SINGER (singername, singerid, price)
values ('Dan Davis', 151, 2840);
insert into SINGER (singername, singerid, price)
values ('Jane Doe', 152, 1971);
insert into SINGER (singername, singerid, price)
values ('Carol Smith', 153, 6071);
insert into SINGER (singername, singerid, price)
values ('Dan Brown', 156, 4315);
insert into SINGER (singername, singerid, price)
values ('Dan Wilson', 159, 6653);
insert into SINGER (singername, singerid, price)
values ('Grace Johnson', 160, 2750);
insert into SINGER (singername, singerid, price)
values ('Grace Doe', 162, 5267);
insert into SINGER (singername, singerid, price)
values ('Carol Williams', 165, 5003);
insert into SINGER (singername, singerid, price)
values ('Frank Williams', 166, 4022);
insert into SINGER (singername, singerid, price)
values ('Dan Garcia', 168, 5921);
insert into SINGER (singername, singerid, price)
values ('Bob Davis', 170, 4651);
insert into SINGER (singername, singerid, price)
values ('Eve Garcia', 171, 7444);
insert into SINGER (singername, singerid, price)
values ('Grace Wilson', 174, 7080);
insert into SINGER (singername, singerid, price)
values ('Grace Doe', 175, 10617);
insert into SINGER (singername, singerid, price)
values ('Bob Davis', 176, 2685);
insert into SINGER (singername, singerid, price)
values ('Eve Doe', 178, 2860);
insert into SINGER (singername, singerid, price)
values ('Henry Garcia', 179, 8801);
insert into SINGER (singername, singerid, price)
values ('Alice Smith', 180, 4993);
insert into SINGER (singername, singerid, price)
values ('Dan Johnson', 181, 7258);
insert into SINGER (singername, singerid, price)
values ('Dan Garcia', 182, 8518);
insert into SINGER (singername, singerid, price)
values ('Bob Garcia', 183, 7961);
insert into SINGER (singername, singerid, price)
values ('Henry Wilson', 185, 3811);
commit;
prompt 100 records committed...
insert into SINGER (singername, singerid, price)
values ('Eve Wilson', 186, 6683);
insert into SINGER (singername, singerid, price)
values ('Eve Brown', 187, 5344);
insert into SINGER (singername, singerid, price)
values ('Eve Smith', 188, 2533);
insert into SINGER (singername, singerid, price)
values ('John Brown', 189, 9274);
insert into SINGER (singername, singerid, price)
values ('Carol Miller', 191, 8541);
insert into SINGER (singername, singerid, price)
values ('Carol Brown', 192, 6786);
insert into SINGER (singername, singerid, price)
values ('Jane Miller', 193, 2285);
insert into SINGER (singername, singerid, price)
values ('John Johnson', 195, 2657);
insert into SINGER (singername, singerid, price)
values ('Carol Johnson', 196, 6316);
insert into SINGER (singername, singerid, price)
values ('Alice Johnson', 197, 5346);
insert into SINGER (singername, singerid, price)
values ('Alice Johnson', 200, 9521);
insert into SINGER (singername, singerid, price)
values ('Carol Williams', 201, 1514);
insert into SINGER (singername, singerid, price)
values ('Grace Williams', 202, 9853);
insert into SINGER (singername, singerid, price)
values ('Alice Davis', 205, 4682);
insert into SINGER (singername, singerid, price)
values ('Dan Jones', 206, 1841);
insert into SINGER (singername, singerid, price)
values ('John Garcia', 207, 8454);
insert into SINGER (singername, singerid, price)
values ('Eve Jones', 208, 8508);
insert into SINGER (singername, singerid, price)
values ('Dan Johnson', 209, 5624);
insert into SINGER (singername, singerid, price)
values ('Bob Miller', 211, 7543);
insert into SINGER (singername, singerid, price)
values ('Bob Garcia', 212, 9114);
insert into SINGER (singername, singerid, price)
values ('Bob Doe', 213, 1060);
insert into SINGER (singername, singerid, price)
values ('Dan Brown', 214, 1089);
insert into SINGER (singername, singerid, price)
values ('Frank Wilson', 215, 3133);
insert into SINGER (singername, singerid, price)
values ('Grace Johnson', 216, 4285);
insert into SINGER (singername, singerid, price)
values ('Eve Smith', 218, 3546);
insert into SINGER (singername, singerid, price)
values ('Jane Doe', 219, 8569);
insert into SINGER (singername, singerid, price)
values ('Dan Davis', 223, 4905);
insert into SINGER (singername, singerid, price)
values ('Jane Garcia', 224, 8437);
insert into SINGER (singername, singerid, price)
values ('Jane Smith', 226, 9306);
insert into SINGER (singername, singerid, price)
values ('Frank Brown', 227, 5417);
insert into SINGER (singername, singerid, price)
values ('John Williams', 230, 9358);
insert into SINGER (singername, singerid, price)
values ('Eve Doe', 235, 7117);
insert into SINGER (singername, singerid, price)
values ('Carol Wilson', 236, 4989);
insert into SINGER (singername, singerid, price)
values ('Jane Garcia', 237, 1931);
insert into SINGER (singername, singerid, price)
values ('Alice Smith', 238, 2273);
insert into SINGER (singername, singerid, price)
values ('Henry Doe', 239, 5838);
insert into SINGER (singername, singerid, price)
values ('Henry Doe', 240, 1344);
insert into SINGER (singername, singerid, price)
values ('Alice Smith', 241, 3260);
insert into SINGER (singername, singerid, price)
values ('Grace Wilson', 242, 9747);
insert into SINGER (singername, singerid, price)
values ('Henry Miller', 243, 9973);
insert into SINGER (singername, singerid, price)
values ('Grace Brown', 246, 6930);
insert into SINGER (singername, singerid, price)
values ('John Miller', 247, 3423);
insert into SINGER (singername, singerid, price)
values ('Grace Davis', 248, 1006);
insert into SINGER (singername, singerid, price)
values ('Frank Garcia', 249, 1231);
insert into SINGER (singername, singerid, price)
values ('Grace Miller', 250, 4259);
insert into SINGER (singername, singerid, price)
values ('Jane Smith', 252, 5535);
insert into SINGER (singername, singerid, price)
values ('Jane Wilson', 253, 7360);
insert into SINGER (singername, singerid, price)
values ('Bob Miller', 255, 2300);
insert into SINGER (singername, singerid, price)
values ('Henry Smith', 256, 6797);
insert into SINGER (singername, singerid, price)
values ('Bob Miller', 257, 7852);
insert into SINGER (singername, singerid, price)
values ('Grace Doe', 259, 9827);
insert into SINGER (singername, singerid, price)
values ('Carol Doe', 261, 2674);
insert into SINGER (singername, singerid, price)
values ('Carol Miller', 264, 4056);
insert into SINGER (singername, singerid, price)
values ('Frank Garcia', 266, 2288);
insert into SINGER (singername, singerid, price)
values ('Frank Jones', 267, 9448);
insert into SINGER (singername, singerid, price)
values ('Alice Garcia', 268, 5910);
insert into SINGER (singername, singerid, price)
values ('Bob Wilson', 269, 2032);
insert into SINGER (singername, singerid, price)
values ('John Doe', 272, 2936);
insert into SINGER (singername, singerid, price)
values ('Frank Miller', 278, 6756);
insert into SINGER (singername, singerid, price)
values ('John Davis', 279, 5176);
insert into SINGER (singername, singerid, price)
values ('Frank Garcia', 280, 4762);
insert into SINGER (singername, singerid, price)
values ('Grace Johnson', 282, 7763);
insert into SINGER (singername, singerid, price)
values ('John Johnson', 286, 9032);
insert into SINGER (singername, singerid, price)
values ('Eve Johnson', 287, 1420);
insert into SINGER (singername, singerid, price)
values ('Dan Miller', 288, 4275);
insert into SINGER (singername, singerid, price)
values ('Bob Davis', 290, 6350);
insert into SINGER (singername, singerid, price)
values ('Dan Wilson', 292, 1171);
insert into SINGER (singername, singerid, price)
values ('Dan Jones', 293, 5010);
insert into SINGER (singername, singerid, price)
values ('Henry Williams', 297, 8226);
insert into SINGER (singername, singerid, price)
values ('Dan Garcia', 299, 5313);
insert into SINGER (singername, singerid, price)
values ('Eve Miller', 302, 7175);
insert into SINGER (singername, singerid, price)
values ('Grace Miller', 303, 5713);
insert into SINGER (singername, singerid, price)
values ('Carol Jones', 305, 6722);
insert into SINGER (singername, singerid, price)
values ('John Jones', 306, 2679);
insert into SINGER (singername, singerid, price)
values ('Dan Johnson', 307, 8218);
insert into SINGER (singername, singerid, price)
values ('John Smith', 309, 9391);
insert into SINGER (singername, singerid, price)
values ('Bob Johnson', 310, 7078);
insert into SINGER (singername, singerid, price)
values ('Henry Williams', 311, 9599);
insert into SINGER (singername, singerid, price)
values ('Jane Smith', 313, 4142);
insert into SINGER (singername, singerid, price)
values ('Jane Wilson', 315, 2052);
insert into SINGER (singername, singerid, price)
values ('Grace Brown', 318, 7149);
insert into SINGER (singername, singerid, price)
values ('Eve Johnson', 320, 2601);
insert into SINGER (singername, singerid, price)
values ('Eve Johnson', 321, 9848);
insert into SINGER (singername, singerid, price)
values ('John Miller', 322, 7475);
insert into SINGER (singername, singerid, price)
values ('Eve Johnson', 324, 1112);
insert into SINGER (singername, singerid, price)
values ('Henry Johnson', 325, 7968);
insert into SINGER (singername, singerid, price)
values ('Eve Johnson', 326, 4723);
insert into SINGER (singername, singerid, price)
values ('Carol Doe', 327, 6292);
insert into SINGER (singername, singerid, price)
values ('Bob Davis', 332, 4615);
insert into SINGER (singername, singerid, price)
values ('Bob Garcia', 333, 7044);
insert into SINGER (singername, singerid, price)
values ('Bob Miller', 335, 1479);
insert into SINGER (singername, singerid, price)
values ('Eve Doe', 336, 6932);
insert into SINGER (singername, singerid, price)
values ('Frank Johnson', 339, 9913);
insert into SINGER (singername, singerid, price)
values ('Dan Doe', 340, 1521);
insert into SINGER (singername, singerid, price)
values ('Dan Brown', 343, 3623);
insert into SINGER (singername, singerid, price)
values ('Dan Doe', 344, 1152);
insert into SINGER (singername, singerid, price)
values ('Grace Davis', 345, 1577);
insert into SINGER (singername, singerid, price)
values ('Jane Miller', 346, 5071);
insert into SINGER (singername, singerid, price)
values ('Frank Brown', 350, 6772);
insert into SINGER (singername, singerid, price)
values ('Dan Williams', 351, 9403);
commit;
prompt 200 records committed...
insert into SINGER (singername, singerid, price)
values ('Bob Wilson', 352, 2552);
insert into SINGER (singername, singerid, price)
values ('Jane Garcia', 353, 1256);
insert into SINGER (singername, singerid, price)
values ('Jane Davis', 354, 1139);
insert into SINGER (singername, singerid, price)
values ('John Doe', 358, 7654);
insert into SINGER (singername, singerid, price)
values ('Frank Davis', 359, 6232);
insert into SINGER (singername, singerid, price)
values ('Bob Williams', 360, 6824);
insert into SINGER (singername, singerid, price)
values ('Carol Wilson', 362, 7785);
insert into SINGER (singername, singerid, price)
values ('Jane Doe', 363, 7762);
insert into SINGER (singername, singerid, price)
values ('John Garcia', 364, 5405);
insert into SINGER (singername, singerid, price)
values ('John Garcia', 365, 5028);
insert into SINGER (singername, singerid, price)
values ('Henry Davis', 367, 9531);
insert into SINGER (singername, singerid, price)
values ('Alice Williams', 368, 1648);
insert into SINGER (singername, singerid, price)
values ('Dan Doe', 371, 6228);
insert into SINGER (singername, singerid, price)
values ('Grace Brown', 375, 6711);
insert into SINGER (singername, singerid, price)
values ('Henry Brown', 379, 10369);
insert into SINGER (singername, singerid, price)
values ('Dan Williams', 380, 9221);
insert into SINGER (singername, singerid, price)
values ('John Johnson', 381, 8902);
insert into SINGER (singername, singerid, price)
values ('Grace Brown', 383, 8719);
insert into SINGER (singername, singerid, price)
values ('Grace Smith', 385, 2092);
insert into SINGER (singername, singerid, price)
values ('Bob Brown', 388, 4198);
insert into SINGER (singername, singerid, price)
values ('John Smith', 392, 7403);
insert into SINGER (singername, singerid, price)
values ('Eve Doe', 393, 7976);
insert into SINGER (singername, singerid, price)
values ('Carol Johnson', 395, 7841);
insert into SINGER (singername, singerid, price)
values ('Eve Doe', 396, 1095);
insert into SINGER (singername, singerid, price)
values ('Alice Johnson', 397, 2216);
insert into SINGER (singername, singerid, price)
values ('Jane Smith', 398, 5935);
insert into SINGER (singername, singerid, price)
values ('Henry Williams', 399, 7749);
insert into SINGER (singername, singerid, price)
values ('Grace Wilson', 401, 3074);
insert into SINGER (singername, singerid, price)
values ('Grace Garcia', 403, 8497);
insert into SINGER (singername, singerid, price)
values ('Jane Johnson', 406, 6179);
insert into SINGER (singername, singerid, price)
values ('Bob Brown', 411, 5791);
insert into SINGER (singername, singerid, price)
values ('Eve Garcia', 412, 7730);
insert into SINGER (singername, singerid, price)
values ('Grace Williams', 413, 9251);
insert into SINGER (singername, singerid, price)
values ('Alice Miller', 414, 3593);
insert into SINGER (singername, singerid, price)
values ('Dan Jones', 415, 7873);
insert into SINGER (singername, singerid, price)
values ('Bob Miller', 417, 8345);
insert into SINGER (singername, singerid, price)
values ('Alice Wilson', 418, 2743);
insert into SINGER (singername, singerid, price)
values ('Dan Davis', 420, 2593);
insert into SINGER (singername, singerid, price)
values ('John Miller', 421, 4932);
insert into SINGER (singername, singerid, price)
values ('Dan Brown', 425, 2018);
insert into SINGER (singername, singerid, price)
values ('Alice Brown', 427, 5503);
insert into SINGER (singername, singerid, price)
values ('Carol Jones', 428, 6808);
insert into SINGER (singername, singerid, price)
values ('Dan Garcia', 429, 6472);
insert into SINGER (singername, singerid, price)
values ('Jane Wilson', 430, 7223);
insert into SINGER (singername, singerid, price)
values ('Jane Johnson', 431, 3719);
insert into SINGER (singername, singerid, price)
values ('Jane Wilson', 432, 1909);
insert into SINGER (singername, singerid, price)
values ('Jane Williams', 433, 9548);
insert into SINGER (singername, singerid, price)
values ('Frank Johnson', 434, 8140);
insert into SINGER (singername, singerid, price)
values ('John Doe', 435, 6832);
insert into SINGER (singername, singerid, price)
values ('John Wilson', 437, 6013);
insert into SINGER (singername, singerid, price)
values ('Grace Williams', 438, 9293);
insert into SINGER (singername, singerid, price)
values ('Alice Garcia', 443, 2060);
insert into SINGER (singername, singerid, price)
values ('Bob Miller', 444, 2546);
insert into SINGER (singername, singerid, price)
values ('Frank Davis', 445, 4712);
insert into SINGER (singername, singerid, price)
values ('Carol Smith', 446, 1868);
insert into SINGER (singername, singerid, price)
values ('Henry Davis', 447, 6088);
insert into SINGER (singername, singerid, price)
values ('John Doe', 448, 7215);
insert into SINGER (singername, singerid, price)
values ('Bob Brown', 449, 1548);
commit;
prompt 258 records loaded
prompt Loading VENUES...
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (1, 'Grand Hall', '123 Main St', 500, to_date('01-01-2000', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (2, 'Conference Center', '456 Elm St', 200, to_date('05-05-2005', 'dd-mm-yyyy'), to_date('05-05-2015', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (3, 'Banquet Hall', '789 Oak St', 300, to_date('15-03-2010', 'dd-mm-yyyy'), to_date('15-03-2020', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (4, 'Wedding Venue', '101 Pine St', 400, to_date('20-07-2008', 'dd-mm-yyyy'), to_date('20-07-2018', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (5, 'Convention Center', '202 Cedar St', 800, to_date('10-11-2012', 'dd-mm-yyyy'), to_date('10-11-2022', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (6, 'Exhibition Hall', '303 Birch St', 250, to_date('25-02-2016', 'dd-mm-yyyy'), to_date('25-02-2026', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (7, 'Garden Venue', '404 Maple St', 350, to_date('18-06-2001', 'dd-mm-yyyy'), to_date('18-06-2021', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (8, 'Rooftop Venue', '505 Walnut St', 150, to_date('22-09-2003', 'dd-mm-yyyy'), to_date('22-09-2023', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (9, 'Beach Venue', '606 Palm St', 600, to_date('12-12-2014', 'dd-mm-yyyy'), to_date('12-12-2024', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (10, 'Country Club', '707 Spruce St', 450, to_date('08-04-2006', 'dd-mm-yyyy'), to_date('08-04-2016', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (11, 'City Hall', '808 Fir St', 700, to_date('14-08-2011', 'dd-mm-yyyy'), to_date('14-08-2021', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (12, 'Historic Mansion', '909 Cherry St', 320, to_date('28-10-2009', 'dd-mm-yyyy'), to_date('28-10-2019', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (13, 'Art Gallery', '1010 Ash St', 180, to_date('06-01-2017', 'dd-mm-yyyy'), to_date('06-01-2027', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (14, 'Hotel Ballroom', '1111 Willow St', 500, to_date('19-05-2002', 'dd-mm-yyyy'), to_date('19-05-2022', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (15, 'Museum Venue', '1212 Poplar St', 600, to_date('23-07-2015', 'dd-mm-yyyy'), to_date('23-07-2025', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (16, 'Resort Venue', '1313 Beech St', 350, to_date('30-03-2004', 'dd-mm-yyyy'), to_date('30-03-2024', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (17, 'Event Pavilion', '1414 Hemlock St', 250, to_date('11-09-2007', 'dd-mm-yyyy'), to_date('11-09-2027', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (18, 'Auditorium', '1515 Magnolia St', 450, to_date('05-11-2013', 'dd-mm-yyyy'), to_date('05-11-2023', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (19, 'Lakeside Venue', '1616 Olive St', 550, to_date('17-06-2018', 'dd-mm-yyyy'), to_date('17-06-2028', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (20, 'Park Venue', '1717 Cypress St', 220, to_date('01-10-2019', 'dd-mm-yyyy'), to_date('01-10-2029', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (21, 'Community Center', '1818 Pine St', 400, to_date('12-01-2020', 'dd-mm-yyyy'), to_date('12-01-2030', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (22, 'Mountain Lodge', '1919 Palm St', 300, to_date('14-02-2000', 'dd-mm-yyyy'), to_date('14-02-2020', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (23, 'Desert Venue', '2020 Maple St', 200, to_date('16-03-2005', 'dd-mm-yyyy'), to_date('16-03-2025', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (24, 'Vineyard Venue', '2121 Oak St', 350, to_date('18-04-2010', 'dd-mm-yyyy'), to_date('18-04-2030', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (25, 'Island Venue', '2323 Elm St', 500, to_date('20-05-2015', 'dd-mm-yyyy'), to_date('20-05-2035', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (26, 'River Venue', '2424 Spruce St', 250, to_date('22-06-2020', 'dd-mm-yyyy'), to_date('22-06-2040', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (27, 'Forest Venue', '2525 Fir St', 450, to_date('24-07-2003', 'dd-mm-yyyy'), to_date('24-07-2023', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (28, 'Castle Venue', '2626 Cedar St', 600, to_date('26-08-2008', 'dd-mm-yyyy'), to_date('26-08-2028', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (29, 'Heritage Hall', '2727 Birch St', 320, to_date('28-09-2013', 'dd-mm-yyyy'), to_date('28-09-2033', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (30, 'Library Venue', '2828 Cherry St', 180, to_date('30-10-2018', 'dd-mm-yyyy'), to_date('30-10-2038', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (31, 'Ranch Venue', '2929 Ash St', 500, to_date('01-11-2001', 'dd-mm-yyyy'), to_date('01-11-2021', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (32, 'Palace Venue', '3030 Willow St', 700, to_date('03-12-2006', 'dd-mm-yyyy'), to_date('03-12-2026', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (33, 'Studio Venue', '3131 Poplar St', 150, to_date('25-03-2008', 'dd-mm-yyyy'), to_date('25-03-2028', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (34, 'Sports Arena', '3232 Maple St', 1000, to_date('30-05-2010', 'dd-mm-yyyy'), to_date('30-05-2030', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (35, 'Theater Venue', '3333 Elm St', 750, to_date('15-07-2012', 'dd-mm-yyyy'), to_date('15-07-2032', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (36, 'Boat House', '3434 Pine St', 300, to_date('20-08-2014', 'dd-mm-yyyy'), to_date('20-08-2034', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (37, 'Aquarium Venue', '3535 Palm St', 400, to_date('10-09-2016', 'dd-mm-yyyy'), to_date('10-09-2036', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (38, 'Zoo Pavilion', '3636 Spruce St', 600, to_date('05-10-2018', 'dd-mm-yyyy'), to_date('05-10-2038', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (39, 'Amphitheater', '3737 Maple St', 1200, to_date('25-11-2020', 'dd-mm-yyyy'), to_date('25-11-2040', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (40, 'Convention Hall', '3838 Elm St', 900, to_date('15-12-2022', 'dd-mm-yyyy'), to_date('15-12-2042', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (1000, 'Grand Hall', '123 Main St', 500, to_date('01-01-2000', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (2000, 'Conference Center', '456 Elm St', 200, to_date('05-05-2005', 'dd-mm-yyyy'), to_date('05-05-2015', 'dd-mm-yyyy'));
commit;
prompt 42 records loaded
prompt Loading EVENTS...
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2000, to_date('23-04-2022', 'dd-mm-yyyy'), to_date('29-12-2021', 'dd-mm-yyyy'), 1172, 27, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2001, to_date('05-08-2022', 'dd-mm-yyyy'), to_date('13-08-2021', 'dd-mm-yyyy'), 1104, 2, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2002, to_date('30-10-2022', 'dd-mm-yyyy'), to_date('17-09-2021', 'dd-mm-yyyy'), 1358, 30, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2003, to_date('18-04-2022', 'dd-mm-yyyy'), to_date('25-11-2021', 'dd-mm-yyyy'), 1138, 17, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2004, to_date('06-08-2022', 'dd-mm-yyyy'), to_date('19-01-2021', 'dd-mm-yyyy'), 1351, 35, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2005, to_date('03-02-2022', 'dd-mm-yyyy'), to_date('02-04-2021', 'dd-mm-yyyy'), 1087, 37, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2006, to_date('25-10-2022', 'dd-mm-yyyy'), to_date('24-05-2021', 'dd-mm-yyyy'), 1079, 5, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2007, to_date('10-11-2022', 'dd-mm-yyyy'), to_date('05-01-2021', 'dd-mm-yyyy'), 1218, 14, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2008, to_date('06-09-2022', 'dd-mm-yyyy'), to_date('29-09-2021', 'dd-mm-yyyy'), 1378, 11, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2009, to_date('27-01-2022', 'dd-mm-yyyy'), to_date('17-02-2021', 'dd-mm-yyyy'), 1296, 20, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2010, to_date('17-10-2022', 'dd-mm-yyyy'), to_date('02-09-2021', 'dd-mm-yyyy'), 1338, 17, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2011, to_date('20-01-2022', 'dd-mm-yyyy'), to_date('15-04-2021', 'dd-mm-yyyy'), 1311, 37, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2012, to_date('01-06-2022', 'dd-mm-yyyy'), to_date('17-08-2021', 'dd-mm-yyyy'), 1349, 33, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2013, to_date('30-09-2022', 'dd-mm-yyyy'), to_date('22-11-2021', 'dd-mm-yyyy'), 1029, 14, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2014, to_date('20-04-2022', 'dd-mm-yyyy'), to_date('01-02-2021', 'dd-mm-yyyy'), 1356, 14, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2015, to_date('03-02-2022', 'dd-mm-yyyy'), to_date('17-11-2021', 'dd-mm-yyyy'), 1161, 24, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2016, to_date('01-02-2022', 'dd-mm-yyyy'), to_date('26-06-2021', 'dd-mm-yyyy'), 1151, 2000, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2017, to_date('08-12-2022', 'dd-mm-yyyy'), to_date('10-04-2021', 'dd-mm-yyyy'), 1367, 9, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2018, to_date('26-03-2022', 'dd-mm-yyyy'), to_date('18-12-2021', 'dd-mm-yyyy'), 1080, 32, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2019, to_date('09-07-2022', 'dd-mm-yyyy'), to_date('21-08-2021', 'dd-mm-yyyy'), 1079, 2, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2020, to_date('20-07-2022', 'dd-mm-yyyy'), to_date('16-12-2021', 'dd-mm-yyyy'), 1185, 36, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2021, to_date('09-07-2022', 'dd-mm-yyyy'), to_date('11-04-2021', 'dd-mm-yyyy'), 1148, 33, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2022, to_date('08-04-2022', 'dd-mm-yyyy'), to_date('24-07-2021', 'dd-mm-yyyy'), 1159, 10, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2023, to_date('29-08-2022', 'dd-mm-yyyy'), to_date('13-04-2021', 'dd-mm-yyyy'), 1122, 32, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2024, to_date('03-09-2022', 'dd-mm-yyyy'), to_date('24-09-2021', 'dd-mm-yyyy'), 1139, 19, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2025, to_date('15-11-2022', 'dd-mm-yyyy'), to_date('19-05-2021', 'dd-mm-yyyy'), 1341, 16, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2026, to_date('25-04-2022', 'dd-mm-yyyy'), to_date('13-04-2021', 'dd-mm-yyyy'), 1314, 33, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2027, to_date('17-01-2022', 'dd-mm-yyyy'), to_date('05-08-2021', 'dd-mm-yyyy'), 1065, 25, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2028, to_date('06-10-2022', 'dd-mm-yyyy'), to_date('20-09-2021', 'dd-mm-yyyy'), 1164, 29, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2029, to_date('20-04-2022', 'dd-mm-yyyy'), to_date('17-09-2021', 'dd-mm-yyyy'), 1021, 31, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2030, to_date('12-12-2022', 'dd-mm-yyyy'), to_date('08-11-2021', 'dd-mm-yyyy'), 1120, 25, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2031, to_date('10-11-2022', 'dd-mm-yyyy'), to_date('04-08-2021', 'dd-mm-yyyy'), 1178, 30, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2032, to_date('08-01-2022', 'dd-mm-yyyy'), to_date('05-04-2021', 'dd-mm-yyyy'), 1051, 39, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2033, to_date('21-06-2022', 'dd-mm-yyyy'), to_date('29-03-2021', 'dd-mm-yyyy'), 1346, 22, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2034, to_date('03-11-2022', 'dd-mm-yyyy'), to_date('08-07-2021', 'dd-mm-yyyy'), 1176, 25, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2035, to_date('17-05-2022', 'dd-mm-yyyy'), to_date('28-09-2021', 'dd-mm-yyyy'), 1000, 1, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2036, to_date('16-12-2022', 'dd-mm-yyyy'), to_date('17-04-2021', 'dd-mm-yyyy'), 1001, 27, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2037, to_date('11-11-2022', 'dd-mm-yyyy'), to_date('19-12-2021', 'dd-mm-yyyy'), 1130, 6, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2038, to_date('18-03-2022', 'dd-mm-yyyy'), to_date('19-03-2021', 'dd-mm-yyyy'), 1080, 11, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2039, to_date('19-05-2022', 'dd-mm-yyyy'), to_date('14-02-2021', 'dd-mm-yyyy'), 1314, 4, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2040, to_date('07-11-2022', 'dd-mm-yyyy'), to_date('22-07-2021', 'dd-mm-yyyy'), 1203, 8, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2041, to_date('14-03-2022', 'dd-mm-yyyy'), to_date('06-02-2021', 'dd-mm-yyyy'), 1218, 17, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2042, to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-10-2021', 'dd-mm-yyyy'), 1007, 12, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2043, to_date('21-08-2022', 'dd-mm-yyyy'), to_date('17-08-2021', 'dd-mm-yyyy'), 1321, 28, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2044, to_date('04-03-2022', 'dd-mm-yyyy'), to_date('07-10-2021', 'dd-mm-yyyy'), 1012, 21, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2045, to_date('17-11-2022', 'dd-mm-yyyy'), to_date('04-04-2021', 'dd-mm-yyyy'), 1263, 8, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2046, to_date('30-07-2022', 'dd-mm-yyyy'), to_date('31-01-2021', 'dd-mm-yyyy'), 1283, 9, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2047, to_date('20-04-2022', 'dd-mm-yyyy'), to_date('22-02-2021', 'dd-mm-yyyy'), 1018, 18, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2048, to_date('10-01-2022', 'dd-mm-yyyy'), to_date('22-10-2021', 'dd-mm-yyyy'), 1317, 29, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2049, to_date('03-06-2022', 'dd-mm-yyyy'), to_date('25-08-2021', 'dd-mm-yyyy'), 1298, 7, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2050, to_date('22-08-2022', 'dd-mm-yyyy'), to_date('30-04-2021', 'dd-mm-yyyy'), 1157, 5, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2051, to_date('13-05-2022', 'dd-mm-yyyy'), to_date('30-09-2021', 'dd-mm-yyyy'), 1171, 29, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2052, to_date('04-08-2022', 'dd-mm-yyyy'), to_date('03-12-2021', 'dd-mm-yyyy'), 1323, 32, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2053, to_date('27-11-2022', 'dd-mm-yyyy'), to_date('05-04-2021', 'dd-mm-yyyy'), 1314, 19, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2054, to_date('13-03-2022', 'dd-mm-yyyy'), to_date('13-02-2021', 'dd-mm-yyyy'), 1180, 18, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2055, to_date('03-02-2022', 'dd-mm-yyyy'), to_date('18-11-2021', 'dd-mm-yyyy'), 1288, 2, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2056, to_date('21-07-2022', 'dd-mm-yyyy'), to_date('25-11-2021', 'dd-mm-yyyy'), 1321, 15, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2057, to_date('25-05-2022', 'dd-mm-yyyy'), to_date('15-01-2021', 'dd-mm-yyyy'), 1233, 13, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2058, to_date('22-09-2022', 'dd-mm-yyyy'), to_date('15-09-2021', 'dd-mm-yyyy'), 1179, 17, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2059, to_date('19-06-2022', 'dd-mm-yyyy'), to_date('20-07-2021', 'dd-mm-yyyy'), 1198, 3, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2060, to_date('16-07-2022', 'dd-mm-yyyy'), to_date('04-04-2021', 'dd-mm-yyyy'), 1066, 17, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2061, to_date('25-05-2022', 'dd-mm-yyyy'), to_date('04-02-2021', 'dd-mm-yyyy'), 1284, 35, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2062, to_date('14-11-2022', 'dd-mm-yyyy'), to_date('04-03-2021', 'dd-mm-yyyy'), 1031, 2000, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2063, to_date('11-08-2022', 'dd-mm-yyyy'), to_date('05-07-2021', 'dd-mm-yyyy'), 1024, 2, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2064, to_date('26-07-2022', 'dd-mm-yyyy'), to_date('05-06-2021', 'dd-mm-yyyy'), 1349, 32, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2065, to_date('08-04-2022', 'dd-mm-yyyy'), to_date('15-11-2021', 'dd-mm-yyyy'), 1178, 26, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2066, to_date('16-11-2022', 'dd-mm-yyyy'), to_date('09-08-2021', 'dd-mm-yyyy'), 1036, 21, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2067, to_date('31-03-2022', 'dd-mm-yyyy'), to_date('10-06-2021', 'dd-mm-yyyy'), 1158, 26, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2068, to_date('23-06-2022', 'dd-mm-yyyy'), to_date('16-12-2021', 'dd-mm-yyyy'), 1177, 1, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2069, to_date('08-09-2022', 'dd-mm-yyyy'), to_date('06-05-2021', 'dd-mm-yyyy'), 1281, 21, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2070, to_date('12-01-2022', 'dd-mm-yyyy'), to_date('19-04-2021', 'dd-mm-yyyy'), 1097, 6, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2071, to_date('10-02-2022', 'dd-mm-yyyy'), to_date('26-02-2021', 'dd-mm-yyyy'), 1037, 20, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2072, to_date('11-05-2022', 'dd-mm-yyyy'), to_date('07-09-2021', 'dd-mm-yyyy'), 1342, 2, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2073, to_date('26-01-2022', 'dd-mm-yyyy'), to_date('16-03-2021', 'dd-mm-yyyy'), 1392, 9, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2074, to_date('06-02-2022', 'dd-mm-yyyy'), to_date('06-12-2021', 'dd-mm-yyyy'), 1093, 38, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2075, to_date('28-05-2022', 'dd-mm-yyyy'), to_date('09-10-2021', 'dd-mm-yyyy'), 1114, 1, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2076, to_date('03-01-2022', 'dd-mm-yyyy'), to_date('04-12-2021', 'dd-mm-yyyy'), 1201, 34, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2077, to_date('06-01-2022', 'dd-mm-yyyy'), to_date('15-01-2021', 'dd-mm-yyyy'), 1117, 2, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2078, to_date('04-10-2022', 'dd-mm-yyyy'), to_date('05-10-2021', 'dd-mm-yyyy'), 1251, 4, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2079, to_date('26-03-2022', 'dd-mm-yyyy'), to_date('26-11-2021', 'dd-mm-yyyy'), 1239, 4, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2080, to_date('07-05-2022', 'dd-mm-yyyy'), to_date('02-09-2021', 'dd-mm-yyyy'), 1047, 39, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2081, to_date('25-09-2022', 'dd-mm-yyyy'), to_date('17-07-2021', 'dd-mm-yyyy'), 1042, 24, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2082, to_date('15-01-2022', 'dd-mm-yyyy'), to_date('19-10-2021', 'dd-mm-yyyy'), 1324, 6, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2083, to_date('11-01-2022', 'dd-mm-yyyy'), to_date('07-11-2021', 'dd-mm-yyyy'), 1032, 30, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2084, to_date('17-11-2022', 'dd-mm-yyyy'), to_date('05-10-2021', 'dd-mm-yyyy'), 1287, 21, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2085, to_date('01-07-2022', 'dd-mm-yyyy'), to_date('01-09-2021', 'dd-mm-yyyy'), 1112, 13, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2086, to_date('07-10-2022', 'dd-mm-yyyy'), to_date('07-01-2021', 'dd-mm-yyyy'), 1367, 8, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2087, to_date('03-01-2022', 'dd-mm-yyyy'), to_date('15-10-2021', 'dd-mm-yyyy'), 1054, 25, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2088, to_date('08-02-2022', 'dd-mm-yyyy'), to_date('01-02-2021', 'dd-mm-yyyy'), 1216, 28, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2089, to_date('26-01-2022', 'dd-mm-yyyy'), to_date('05-11-2021', 'dd-mm-yyyy'), 1001, 18, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2090, to_date('27-12-2022', 'dd-mm-yyyy'), to_date('10-07-2021', 'dd-mm-yyyy'), 1310, 35, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2091, to_date('05-08-2022', 'dd-mm-yyyy'), to_date('12-12-2021', 'dd-mm-yyyy'), 1187, 2000, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2092, to_date('23-12-2022', 'dd-mm-yyyy'), to_date('06-10-2021', 'dd-mm-yyyy'), 1391, 17, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2093, to_date('24-02-2022', 'dd-mm-yyyy'), to_date('28-02-2021', 'dd-mm-yyyy'), 1291, 20, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2094, to_date('02-06-2022', 'dd-mm-yyyy'), to_date('28-09-2021', 'dd-mm-yyyy'), 1330, 34, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2095, to_date('10-11-2022', 'dd-mm-yyyy'), to_date('20-10-2021', 'dd-mm-yyyy'), 1007, 16, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2096, to_date('02-05-2022', 'dd-mm-yyyy'), to_date('03-05-2021', 'dd-mm-yyyy'), 1209, 6, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2097, to_date('17-10-2022', 'dd-mm-yyyy'), to_date('13-07-2021', 'dd-mm-yyyy'), 1046, 40, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2098, to_date('15-11-2022', 'dd-mm-yyyy'), to_date('15-08-2021', 'dd-mm-yyyy'), 1035, 28, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2099, to_date('19-12-2022', 'dd-mm-yyyy'), to_date('08-04-2021', 'dd-mm-yyyy'), 1360, 1, null, null);
commit;
prompt 100 records committed...
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2100, to_date('30-04-2022', 'dd-mm-yyyy'), to_date('11-12-2021', 'dd-mm-yyyy'), 1277, 20, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2101, to_date('15-11-2022', 'dd-mm-yyyy'), to_date('29-11-2021', 'dd-mm-yyyy'), 1387, 4, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2102, to_date('16-09-2022', 'dd-mm-yyyy'), to_date('19-10-2021', 'dd-mm-yyyy'), 1028, 20, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2103, to_date('08-08-2022', 'dd-mm-yyyy'), to_date('18-11-2021', 'dd-mm-yyyy'), 1133, 33, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2104, to_date('17-11-2022', 'dd-mm-yyyy'), to_date('12-07-2021', 'dd-mm-yyyy'), 1392, 34, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2105, to_date('01-07-2022', 'dd-mm-yyyy'), to_date('20-06-2021', 'dd-mm-yyyy'), 1065, 23, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2106, to_date('05-04-2022', 'dd-mm-yyyy'), to_date('24-10-2021', 'dd-mm-yyyy'), 1292, 19, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2107, to_date('29-05-2022', 'dd-mm-yyyy'), to_date('27-12-2021', 'dd-mm-yyyy'), 1236, 31, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2108, to_date('05-02-2022', 'dd-mm-yyyy'), to_date('03-01-2021', 'dd-mm-yyyy'), 1312, 6, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2109, to_date('18-06-2022', 'dd-mm-yyyy'), to_date('07-10-2021', 'dd-mm-yyyy'), 1238, 2000, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2110, to_date('12-04-2022', 'dd-mm-yyyy'), to_date('07-04-2021', 'dd-mm-yyyy'), 1156, 31, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2111, to_date('09-06-2022', 'dd-mm-yyyy'), to_date('04-12-2021', 'dd-mm-yyyy'), 1371, 39, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2112, to_date('24-09-2022', 'dd-mm-yyyy'), to_date('22-06-2021', 'dd-mm-yyyy'), 1136, 29, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2113, to_date('03-09-2022', 'dd-mm-yyyy'), to_date('21-12-2021', 'dd-mm-yyyy'), 1047, 1000, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2114, to_date('13-05-2022', 'dd-mm-yyyy'), to_date('09-01-2021', 'dd-mm-yyyy'), 1279, 1, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2115, to_date('27-07-2022', 'dd-mm-yyyy'), to_date('23-03-2021', 'dd-mm-yyyy'), 1210, 39, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2116, to_date('05-08-2022', 'dd-mm-yyyy'), to_date('15-05-2021', 'dd-mm-yyyy'), 1272, 22, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2117, to_date('08-08-2022', 'dd-mm-yyyy'), to_date('09-01-2021', 'dd-mm-yyyy'), 1188, 17, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2118, to_date('29-05-2022', 'dd-mm-yyyy'), to_date('30-05-2021', 'dd-mm-yyyy'), 1217, 10, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2119, to_date('17-12-2022', 'dd-mm-yyyy'), to_date('12-10-2021', 'dd-mm-yyyy'), 1167, 31, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2120, to_date('05-01-2022', 'dd-mm-yyyy'), to_date('07-09-2021', 'dd-mm-yyyy'), 1219, 15, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2121, to_date('14-09-2022', 'dd-mm-yyyy'), to_date('27-10-2021', 'dd-mm-yyyy'), 1090, 15, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2122, to_date('12-01-2022', 'dd-mm-yyyy'), to_date('19-05-2021', 'dd-mm-yyyy'), 1001, 12, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2123, to_date('26-06-2022', 'dd-mm-yyyy'), to_date('20-01-2021', 'dd-mm-yyyy'), 1179, 10, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2124, to_date('06-04-2022', 'dd-mm-yyyy'), to_date('22-02-2021', 'dd-mm-yyyy'), 1138, 8, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2125, to_date('12-11-2022', 'dd-mm-yyyy'), to_date('06-06-2021', 'dd-mm-yyyy'), 1288, 32, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2126, to_date('07-01-2022', 'dd-mm-yyyy'), to_date('19-09-2021', 'dd-mm-yyyy'), 1116, 30, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2127, to_date('27-02-2022', 'dd-mm-yyyy'), to_date('31-03-2021', 'dd-mm-yyyy'), 1074, 1, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2128, to_date('31-12-2022', 'dd-mm-yyyy'), to_date('20-05-2021', 'dd-mm-yyyy'), 1026, 1, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2129, to_date('07-11-2022', 'dd-mm-yyyy'), to_date('30-03-2021', 'dd-mm-yyyy'), 1399, 4, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2130, to_date('03-10-2022', 'dd-mm-yyyy'), to_date('19-03-2021', 'dd-mm-yyyy'), 1270, 13, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2131, to_date('03-08-2022', 'dd-mm-yyyy'), to_date('03-07-2021', 'dd-mm-yyyy'), 1350, 2, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2132, to_date('12-09-2022', 'dd-mm-yyyy'), to_date('24-02-2021', 'dd-mm-yyyy'), 1097, 18, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2133, to_date('21-09-2022', 'dd-mm-yyyy'), to_date('10-03-2021', 'dd-mm-yyyy'), 1295, 1000, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2134, to_date('02-09-2022', 'dd-mm-yyyy'), to_date('13-11-2021', 'dd-mm-yyyy'), 1170, 39, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2135, to_date('29-05-2022', 'dd-mm-yyyy'), to_date('29-01-2021', 'dd-mm-yyyy'), 1150, 15, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2136, to_date('04-02-2022', 'dd-mm-yyyy'), to_date('26-06-2021', 'dd-mm-yyyy'), 1348, 18, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2137, to_date('14-04-2022', 'dd-mm-yyyy'), to_date('30-11-2021', 'dd-mm-yyyy'), 1083, 40, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2138, to_date('01-09-2022', 'dd-mm-yyyy'), to_date('21-01-2021', 'dd-mm-yyyy'), 1301, 6, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2139, to_date('14-09-2022', 'dd-mm-yyyy'), to_date('21-07-2021', 'dd-mm-yyyy'), 1035, 29, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2140, to_date('16-08-2022', 'dd-mm-yyyy'), to_date('28-11-2021', 'dd-mm-yyyy'), 1143, 2000, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2141, to_date('11-07-2022', 'dd-mm-yyyy'), to_date('17-12-2021', 'dd-mm-yyyy'), 1073, 7, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2142, to_date('26-07-2022', 'dd-mm-yyyy'), to_date('29-09-2021', 'dd-mm-yyyy'), 1297, 34, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2143, to_date('21-06-2022', 'dd-mm-yyyy'), to_date('26-12-2021', 'dd-mm-yyyy'), 1360, 9, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2144, to_date('06-11-2022', 'dd-mm-yyyy'), to_date('12-08-2021', 'dd-mm-yyyy'), 1181, 38, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2145, to_date('19-01-2022', 'dd-mm-yyyy'), to_date('20-12-2021', 'dd-mm-yyyy'), 1358, 2000, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2146, to_date('16-07-2022', 'dd-mm-yyyy'), to_date('25-08-2021', 'dd-mm-yyyy'), 1118, 40, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2147, to_date('14-01-2022', 'dd-mm-yyyy'), to_date('19-02-2021', 'dd-mm-yyyy'), 1050, 10, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2148, to_date('29-11-2022', 'dd-mm-yyyy'), to_date('24-08-2021', 'dd-mm-yyyy'), 1076, 12, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2149, to_date('10-07-2022', 'dd-mm-yyyy'), to_date('07-11-2021', 'dd-mm-yyyy'), 1390, 35, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2150, to_date('19-07-2022', 'dd-mm-yyyy'), to_date('10-06-2021', 'dd-mm-yyyy'), 1025, 12, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2151, to_date('05-07-2022', 'dd-mm-yyyy'), to_date('17-08-2021', 'dd-mm-yyyy'), 1175, 35, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2152, to_date('15-12-2022', 'dd-mm-yyyy'), to_date('05-02-2021', 'dd-mm-yyyy'), 1328, 16, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2153, to_date('03-02-2022', 'dd-mm-yyyy'), to_date('29-12-2021', 'dd-mm-yyyy'), 1148, 27, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2154, to_date('13-10-2022', 'dd-mm-yyyy'), to_date('04-12-2021', 'dd-mm-yyyy'), 1152, 2000, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2155, to_date('13-03-2022', 'dd-mm-yyyy'), to_date('22-02-2021', 'dd-mm-yyyy'), 1321, 25, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2156, to_date('29-07-2022', 'dd-mm-yyyy'), to_date('16-04-2021', 'dd-mm-yyyy'), 1302, 10, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2157, to_date('07-11-2022', 'dd-mm-yyyy'), to_date('05-06-2021', 'dd-mm-yyyy'), 1122, 34, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2158, to_date('06-02-2022', 'dd-mm-yyyy'), to_date('30-03-2021', 'dd-mm-yyyy'), 1086, 17, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2159, to_date('24-01-2022', 'dd-mm-yyyy'), to_date('13-08-2021', 'dd-mm-yyyy'), 1172, 13, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2160, to_date('30-03-2022', 'dd-mm-yyyy'), to_date('19-12-2021', 'dd-mm-yyyy'), 1199, 14, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2161, to_date('31-03-2022', 'dd-mm-yyyy'), to_date('10-01-2021', 'dd-mm-yyyy'), 1082, 27, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2162, to_date('15-06-2022', 'dd-mm-yyyy'), to_date('12-01-2021', 'dd-mm-yyyy'), 1037, 26, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2163, to_date('03-03-2022', 'dd-mm-yyyy'), to_date('31-05-2021', 'dd-mm-yyyy'), 1278, 24, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2164, to_date('05-10-2022', 'dd-mm-yyyy'), to_date('22-06-2021', 'dd-mm-yyyy'), 1234, 16, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2165, to_date('16-07-2022', 'dd-mm-yyyy'), to_date('13-09-2021', 'dd-mm-yyyy'), 1252, 9, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2166, to_date('06-05-2022', 'dd-mm-yyyy'), to_date('24-08-2021', 'dd-mm-yyyy'), 1019, 11, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2167, to_date('31-01-2022', 'dd-mm-yyyy'), to_date('09-07-2021', 'dd-mm-yyyy'), 1035, 23, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2168, to_date('07-09-2022', 'dd-mm-yyyy'), to_date('13-12-2021', 'dd-mm-yyyy'), 1209, 36, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2169, to_date('26-03-2022', 'dd-mm-yyyy'), to_date('25-07-2021', 'dd-mm-yyyy'), 1093, 1, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2170, to_date('31-03-2022', 'dd-mm-yyyy'), to_date('26-04-2021', 'dd-mm-yyyy'), 1217, 8, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2171, to_date('06-05-2022', 'dd-mm-yyyy'), to_date('27-09-2021', 'dd-mm-yyyy'), 1057, 29, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2172, to_date('06-10-2022', 'dd-mm-yyyy'), to_date('11-07-2021', 'dd-mm-yyyy'), 1290, 34, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2173, to_date('04-07-2022', 'dd-mm-yyyy'), to_date('21-02-2021', 'dd-mm-yyyy'), 1268, 24, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2174, to_date('18-01-2022', 'dd-mm-yyyy'), to_date('08-05-2021', 'dd-mm-yyyy'), 1169, 3, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2175, to_date('21-11-2022', 'dd-mm-yyyy'), to_date('10-11-2021', 'dd-mm-yyyy'), 1153, 14, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2176, to_date('22-05-2022', 'dd-mm-yyyy'), to_date('28-06-2021', 'dd-mm-yyyy'), 1180, 24, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2177, to_date('31-08-2022', 'dd-mm-yyyy'), to_date('20-07-2021', 'dd-mm-yyyy'), 1224, 9, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2178, to_date('30-06-2022', 'dd-mm-yyyy'), to_date('28-04-2021', 'dd-mm-yyyy'), 1339, 8, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2179, to_date('29-06-2022', 'dd-mm-yyyy'), to_date('12-11-2021', 'dd-mm-yyyy'), 1101, 17, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2180, to_date('06-01-2022', 'dd-mm-yyyy'), to_date('28-06-2021', 'dd-mm-yyyy'), 1295, 11, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2181, to_date('25-07-2022', 'dd-mm-yyyy'), to_date('04-09-2021', 'dd-mm-yyyy'), 1164, 28, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2182, to_date('13-08-2022', 'dd-mm-yyyy'), to_date('04-04-2021', 'dd-mm-yyyy'), 1089, 3, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2183, to_date('15-03-2022', 'dd-mm-yyyy'), to_date('08-02-2021', 'dd-mm-yyyy'), 1023, 8, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2184, to_date('12-08-2022', 'dd-mm-yyyy'), to_date('20-09-2021', 'dd-mm-yyyy'), 1140, 29, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2185, to_date('18-01-2022', 'dd-mm-yyyy'), to_date('19-05-2021', 'dd-mm-yyyy'), 1222, 38, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2186, to_date('05-03-2022', 'dd-mm-yyyy'), to_date('22-10-2021', 'dd-mm-yyyy'), 1058, 8, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2187, to_date('12-10-2022', 'dd-mm-yyyy'), to_date('29-06-2021', 'dd-mm-yyyy'), 1360, 40, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2188, to_date('02-02-2022', 'dd-mm-yyyy'), to_date('07-02-2021', 'dd-mm-yyyy'), 1281, 40, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2189, to_date('29-05-2022', 'dd-mm-yyyy'), to_date('03-09-2021', 'dd-mm-yyyy'), 1041, 27, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2190, to_date('03-02-2022', 'dd-mm-yyyy'), to_date('19-06-2021', 'dd-mm-yyyy'), 1135, 26, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2191, to_date('18-02-2022', 'dd-mm-yyyy'), to_date('07-09-2021', 'dd-mm-yyyy'), 1247, 24, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2192, to_date('30-09-2022', 'dd-mm-yyyy'), to_date('26-06-2021', 'dd-mm-yyyy'), 1323, 3, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2193, to_date('13-10-2022', 'dd-mm-yyyy'), to_date('29-11-2021', 'dd-mm-yyyy'), 1342, 7, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2194, to_date('25-11-2022', 'dd-mm-yyyy'), to_date('22-09-2021', 'dd-mm-yyyy'), 1235, 34, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2195, to_date('06-10-2022', 'dd-mm-yyyy'), to_date('11-04-2021', 'dd-mm-yyyy'), 1289, 16, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2196, to_date('13-09-2022', 'dd-mm-yyyy'), to_date('23-10-2021', 'dd-mm-yyyy'), 1084, 32, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2197, to_date('18-08-2022', 'dd-mm-yyyy'), to_date('20-12-2021', 'dd-mm-yyyy'), 1105, 40, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2198, to_date('02-03-2022', 'dd-mm-yyyy'), to_date('15-04-2021', 'dd-mm-yyyy'), 1272, 7, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2199, to_date('09-03-2022', 'dd-mm-yyyy'), to_date('23-12-2021', 'dd-mm-yyyy'), 1134, 29, null, null);
commit;
prompt 200 records committed...
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2200, to_date('30-04-2022', 'dd-mm-yyyy'), to_date('30-04-2021', 'dd-mm-yyyy'), 1370, 2, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2201, to_date('23-02-2022', 'dd-mm-yyyy'), to_date('11-06-2021', 'dd-mm-yyyy'), 1142, 15, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2202, to_date('06-12-2022', 'dd-mm-yyyy'), to_date('27-03-2021', 'dd-mm-yyyy'), 1137, 33, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2203, to_date('21-05-2022', 'dd-mm-yyyy'), to_date('26-10-2021', 'dd-mm-yyyy'), 1049, 25, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2204, to_date('13-09-2022', 'dd-mm-yyyy'), to_date('05-10-2021', 'dd-mm-yyyy'), 1150, 3, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2205, to_date('18-09-2022', 'dd-mm-yyyy'), to_date('02-11-2021', 'dd-mm-yyyy'), 1271, 15, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2206, to_date('28-02-2022', 'dd-mm-yyyy'), to_date('25-03-2021', 'dd-mm-yyyy'), 1070, 8, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2207, to_date('31-03-2022', 'dd-mm-yyyy'), to_date('26-04-2021', 'dd-mm-yyyy'), 1097, 25, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2208, to_date('10-01-2022', 'dd-mm-yyyy'), to_date('02-07-2021', 'dd-mm-yyyy'), 1129, 26, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2209, to_date('28-04-2022', 'dd-mm-yyyy'), to_date('27-09-2021', 'dd-mm-yyyy'), 1091, 8, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2210, to_date('01-03-2022', 'dd-mm-yyyy'), to_date('12-09-2021', 'dd-mm-yyyy'), 1237, 38, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2211, to_date('26-12-2022', 'dd-mm-yyyy'), to_date('05-09-2021', 'dd-mm-yyyy'), 1109, 13, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2212, to_date('01-02-2022', 'dd-mm-yyyy'), to_date('19-10-2021', 'dd-mm-yyyy'), 1326, 38, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2213, to_date('11-01-2022', 'dd-mm-yyyy'), to_date('07-01-2021', 'dd-mm-yyyy'), 1157, 1, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2214, to_date('17-01-2022', 'dd-mm-yyyy'), to_date('03-01-2021', 'dd-mm-yyyy'), 1305, 11, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2215, to_date('07-08-2022', 'dd-mm-yyyy'), to_date('26-12-2021', 'dd-mm-yyyy'), 1060, 8, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2216, to_date('30-08-2022', 'dd-mm-yyyy'), to_date('13-12-2021', 'dd-mm-yyyy'), 1051, 12, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2217, to_date('17-05-2022', 'dd-mm-yyyy'), to_date('03-01-2021', 'dd-mm-yyyy'), 1359, 30, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2218, to_date('18-02-2022', 'dd-mm-yyyy'), to_date('04-09-2021', 'dd-mm-yyyy'), 1216, 1, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2219, to_date('17-04-2022', 'dd-mm-yyyy'), to_date('16-05-2021', 'dd-mm-yyyy'), 1043, 5, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2220, to_date('28-12-2022', 'dd-mm-yyyy'), to_date('25-06-2021', 'dd-mm-yyyy'), 1271, 35, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2221, to_date('03-11-2022', 'dd-mm-yyyy'), to_date('12-09-2021', 'dd-mm-yyyy'), 1290, 16, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2222, to_date('06-06-2022', 'dd-mm-yyyy'), to_date('16-07-2021', 'dd-mm-yyyy'), 1161, 3, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2223, to_date('02-12-2022', 'dd-mm-yyyy'), to_date('23-03-2021', 'dd-mm-yyyy'), 1247, 7, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2224, to_date('10-03-2022', 'dd-mm-yyyy'), to_date('03-05-2021', 'dd-mm-yyyy'), 1396, 7, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2225, to_date('07-04-2022', 'dd-mm-yyyy'), to_date('30-11-2021', 'dd-mm-yyyy'), 1026, 11, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2226, to_date('09-01-2022', 'dd-mm-yyyy'), to_date('10-12-2021', 'dd-mm-yyyy'), 1159, 4, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2227, to_date('03-06-2022', 'dd-mm-yyyy'), to_date('12-05-2021', 'dd-mm-yyyy'), 1130, 14, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2228, to_date('11-09-2022', 'dd-mm-yyyy'), to_date('24-01-2021', 'dd-mm-yyyy'), 1246, 1, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2229, to_date('19-04-2022', 'dd-mm-yyyy'), to_date('08-07-2021', 'dd-mm-yyyy'), 1101, 9, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2230, to_date('23-07-2022', 'dd-mm-yyyy'), to_date('09-12-2021', 'dd-mm-yyyy'), 1026, 14, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2231, to_date('08-04-2022', 'dd-mm-yyyy'), to_date('24-03-2021', 'dd-mm-yyyy'), 1394, 5, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2232, to_date('14-09-2022', 'dd-mm-yyyy'), to_date('05-01-2021', 'dd-mm-yyyy'), 1030, 2000, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2233, to_date('01-11-2022', 'dd-mm-yyyy'), to_date('30-07-2021', 'dd-mm-yyyy'), 1278, 22, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2234, to_date('25-08-2022', 'dd-mm-yyyy'), to_date('19-06-2021', 'dd-mm-yyyy'), 1158, 7, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2235, to_date('18-11-2022', 'dd-mm-yyyy'), to_date('24-01-2021', 'dd-mm-yyyy'), 1159, 9, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2236, to_date('11-08-2022', 'dd-mm-yyyy'), to_date('05-07-2021', 'dd-mm-yyyy'), 1320, 9, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2237, to_date('13-06-2022', 'dd-mm-yyyy'), to_date('27-07-2021', 'dd-mm-yyyy'), 1328, 25, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2238, to_date('29-04-2022', 'dd-mm-yyyy'), to_date('14-07-2021', 'dd-mm-yyyy'), 1296, 37, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2239, to_date('05-02-2022', 'dd-mm-yyyy'), to_date('17-02-2021', 'dd-mm-yyyy'), 1140, 15, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2240, to_date('11-06-2022', 'dd-mm-yyyy'), to_date('16-01-2021', 'dd-mm-yyyy'), 1024, 1, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2241, to_date('30-10-2022', 'dd-mm-yyyy'), to_date('25-07-2021', 'dd-mm-yyyy'), 1005, 23, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2242, to_date('22-06-2022', 'dd-mm-yyyy'), to_date('02-06-2021', 'dd-mm-yyyy'), 1311, 14, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2243, to_date('29-07-2022', 'dd-mm-yyyy'), to_date('09-11-2021', 'dd-mm-yyyy'), 1221, 33, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2244, to_date('20-04-2022', 'dd-mm-yyyy'), to_date('22-06-2021', 'dd-mm-yyyy'), 1367, 29, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2245, to_date('24-03-2022', 'dd-mm-yyyy'), to_date('28-05-2021', 'dd-mm-yyyy'), 1217, 1000, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2246, to_date('06-04-2022', 'dd-mm-yyyy'), to_date('05-11-2021', 'dd-mm-yyyy'), 1172, 25, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2247, to_date('03-04-2022', 'dd-mm-yyyy'), to_date('16-01-2021', 'dd-mm-yyyy'), 1230, 5, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2248, to_date('14-10-2022', 'dd-mm-yyyy'), to_date('11-03-2021', 'dd-mm-yyyy'), 1058, 3, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2249, to_date('16-11-2022', 'dd-mm-yyyy'), to_date('25-11-2021', 'dd-mm-yyyy'), 1205, 27, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2250, to_date('05-08-2022', 'dd-mm-yyyy'), to_date('07-03-2021', 'dd-mm-yyyy'), 1324, 32, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2251, to_date('15-10-2022', 'dd-mm-yyyy'), to_date('21-01-2021', 'dd-mm-yyyy'), 1316, 38, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2252, to_date('16-06-2022', 'dd-mm-yyyy'), to_date('29-04-2021', 'dd-mm-yyyy'), 1070, 15, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2253, to_date('15-06-2022', 'dd-mm-yyyy'), to_date('07-01-2021', 'dd-mm-yyyy'), 1317, 5, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2254, to_date('14-07-2022', 'dd-mm-yyyy'), to_date('10-08-2021', 'dd-mm-yyyy'), 1061, 19, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2255, to_date('22-12-2022', 'dd-mm-yyyy'), to_date('04-01-2021', 'dd-mm-yyyy'), 1118, 18, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2256, to_date('02-04-2022', 'dd-mm-yyyy'), to_date('02-12-2021', 'dd-mm-yyyy'), 1014, 26, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2257, to_date('01-07-2022', 'dd-mm-yyyy'), to_date('24-01-2021', 'dd-mm-yyyy'), 1382, 21, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2258, to_date('02-10-2022', 'dd-mm-yyyy'), to_date('01-05-2021', 'dd-mm-yyyy'), 1306, 30, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2259, to_date('15-03-2022', 'dd-mm-yyyy'), to_date('12-12-2021', 'dd-mm-yyyy'), 1349, 12, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2260, to_date('03-12-2022', 'dd-mm-yyyy'), to_date('18-02-2021', 'dd-mm-yyyy'), 1115, 28, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2261, to_date('06-11-2022', 'dd-mm-yyyy'), to_date('14-11-2021', 'dd-mm-yyyy'), 1086, 4, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2262, to_date('15-12-2022', 'dd-mm-yyyy'), to_date('30-09-2021', 'dd-mm-yyyy'), 1379, 21, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2263, to_date('19-11-2022', 'dd-mm-yyyy'), to_date('13-01-2021', 'dd-mm-yyyy'), 1362, 6, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2264, to_date('30-06-2022', 'dd-mm-yyyy'), to_date('28-05-2021', 'dd-mm-yyyy'), 1384, 27, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2265, to_date('06-02-2022', 'dd-mm-yyyy'), to_date('26-12-2021', 'dd-mm-yyyy'), 1146, 5, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2266, to_date('01-05-2022', 'dd-mm-yyyy'), to_date('26-08-2021', 'dd-mm-yyyy'), 1376, 23, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2267, to_date('21-11-2022', 'dd-mm-yyyy'), to_date('03-10-2021', 'dd-mm-yyyy'), 1132, 17, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2268, to_date('04-09-2022', 'dd-mm-yyyy'), to_date('01-09-2021', 'dd-mm-yyyy'), 1196, 29, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2269, to_date('07-01-2022', 'dd-mm-yyyy'), to_date('11-11-2021', 'dd-mm-yyyy'), 1287, 15, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2270, to_date('24-12-2022', 'dd-mm-yyyy'), to_date('28-05-2021', 'dd-mm-yyyy'), 1344, 37, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2271, to_date('30-12-2022', 'dd-mm-yyyy'), to_date('29-01-2021', 'dd-mm-yyyy'), 1227, 40, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2272, to_date('27-04-2022', 'dd-mm-yyyy'), to_date('08-07-2021', 'dd-mm-yyyy'), 1264, 31, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2273, to_date('28-12-2022', 'dd-mm-yyyy'), to_date('17-01-2021', 'dd-mm-yyyy'), 1014, 35, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2274, to_date('09-05-2022', 'dd-mm-yyyy'), to_date('18-02-2021', 'dd-mm-yyyy'), 1256, 28, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2275, to_date('24-04-2022', 'dd-mm-yyyy'), to_date('01-09-2021', 'dd-mm-yyyy'), 1183, 28, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2276, to_date('02-11-2022', 'dd-mm-yyyy'), to_date('29-05-2021', 'dd-mm-yyyy'), 1214, 2, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2277, to_date('16-06-2022', 'dd-mm-yyyy'), to_date('10-05-2021', 'dd-mm-yyyy'), 1189, 25, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2278, to_date('12-09-2022', 'dd-mm-yyyy'), to_date('30-11-2021', 'dd-mm-yyyy'), 1385, 33, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2279, to_date('20-09-2022', 'dd-mm-yyyy'), to_date('19-01-2021', 'dd-mm-yyyy'), 1083, 14, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2280, to_date('30-08-2022', 'dd-mm-yyyy'), to_date('01-11-2021', 'dd-mm-yyyy'), 1158, 2, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2281, to_date('11-05-2022', 'dd-mm-yyyy'), to_date('30-01-2021', 'dd-mm-yyyy'), 1208, 13, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2282, to_date('25-06-2022', 'dd-mm-yyyy'), to_date('18-12-2021', 'dd-mm-yyyy'), 1077, 24, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2283, to_date('27-04-2022', 'dd-mm-yyyy'), to_date('27-10-2021', 'dd-mm-yyyy'), 1126, 9, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2284, to_date('01-09-2022', 'dd-mm-yyyy'), to_date('12-07-2021', 'dd-mm-yyyy'), 1274, 39, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2285, to_date('22-07-2022', 'dd-mm-yyyy'), to_date('01-03-2021', 'dd-mm-yyyy'), 1369, 39, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2286, to_date('03-11-2022', 'dd-mm-yyyy'), to_date('27-10-2021', 'dd-mm-yyyy'), 1132, 21, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2287, to_date('09-11-2022', 'dd-mm-yyyy'), to_date('24-10-2021', 'dd-mm-yyyy'), 1208, 29, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2288, to_date('10-08-2022', 'dd-mm-yyyy'), to_date('20-08-2021', 'dd-mm-yyyy'), 1375, 15, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2289, to_date('14-04-2022', 'dd-mm-yyyy'), to_date('20-05-2021', 'dd-mm-yyyy'), 1256, 21, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2290, to_date('06-01-2022', 'dd-mm-yyyy'), to_date('15-07-2021', 'dd-mm-yyyy'), 1374, 35, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2291, to_date('27-02-2022', 'dd-mm-yyyy'), to_date('21-04-2021', 'dd-mm-yyyy'), 1292, 2, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2292, to_date('26-07-2022', 'dd-mm-yyyy'), to_date('29-11-2021', 'dd-mm-yyyy'), 1289, 6, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2293, to_date('03-08-2022', 'dd-mm-yyyy'), to_date('20-07-2021', 'dd-mm-yyyy'), 1308, 31, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2294, to_date('14-10-2022', 'dd-mm-yyyy'), to_date('12-11-2021', 'dd-mm-yyyy'), 1026, 16, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2295, to_date('03-08-2022', 'dd-mm-yyyy'), to_date('08-03-2021', 'dd-mm-yyyy'), 1386, 5, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2296, to_date('18-05-2022', 'dd-mm-yyyy'), to_date('26-11-2021', 'dd-mm-yyyy'), 1230, 40, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2297, to_date('30-09-2022', 'dd-mm-yyyy'), to_date('10-09-2021', 'dd-mm-yyyy'), 1195, 31, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2298, to_date('27-11-2022', 'dd-mm-yyyy'), to_date('12-06-2021', 'dd-mm-yyyy'), 1089, 4, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2299, to_date('18-06-2022', 'dd-mm-yyyy'), to_date('28-02-2021', 'dd-mm-yyyy'), 1116, 2000, null, null);
commit;
prompt 300 records committed...
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2300, to_date('28-01-2022', 'dd-mm-yyyy'), to_date('21-02-2021', 'dd-mm-yyyy'), 1377, 2000, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2301, to_date('23-09-2022', 'dd-mm-yyyy'), to_date('28-03-2021', 'dd-mm-yyyy'), 1394, 31, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2302, to_date('19-07-2022', 'dd-mm-yyyy'), to_date('30-12-2021', 'dd-mm-yyyy'), 1112, 37, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2303, to_date('01-07-2022', 'dd-mm-yyyy'), to_date('06-12-2021', 'dd-mm-yyyy'), 1306, 29, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2304, to_date('01-05-2022', 'dd-mm-yyyy'), to_date('28-04-2021', 'dd-mm-yyyy'), 1045, 30, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2305, to_date('10-08-2022', 'dd-mm-yyyy'), to_date('16-03-2021', 'dd-mm-yyyy'), 1164, 28, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2306, to_date('25-09-2022', 'dd-mm-yyyy'), to_date('29-06-2021', 'dd-mm-yyyy'), 1171, 5, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2307, to_date('02-04-2022', 'dd-mm-yyyy'), to_date('21-05-2021', 'dd-mm-yyyy'), 1143, 32, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2308, to_date('18-11-2022', 'dd-mm-yyyy'), to_date('03-07-2021', 'dd-mm-yyyy'), 1064, 20, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2309, to_date('11-01-2022', 'dd-mm-yyyy'), to_date('25-05-2021', 'dd-mm-yyyy'), 1322, 2000, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2310, to_date('12-10-2022', 'dd-mm-yyyy'), to_date('14-05-2021', 'dd-mm-yyyy'), 1041, 22, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2311, to_date('22-07-2022', 'dd-mm-yyyy'), to_date('13-10-2021', 'dd-mm-yyyy'), 1364, 8, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2312, to_date('21-12-2022', 'dd-mm-yyyy'), to_date('14-04-2021', 'dd-mm-yyyy'), 1349, 7, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2313, to_date('15-08-2022', 'dd-mm-yyyy'), to_date('28-07-2021', 'dd-mm-yyyy'), 1013, 11, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2314, to_date('22-09-2022', 'dd-mm-yyyy'), to_date('05-09-2021', 'dd-mm-yyyy'), 1374, 29, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2315, to_date('11-12-2022', 'dd-mm-yyyy'), to_date('07-12-2021', 'dd-mm-yyyy'), 1021, 34, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2316, to_date('20-10-2022', 'dd-mm-yyyy'), to_date('29-12-2021', 'dd-mm-yyyy'), 1280, 3, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2317, to_date('12-06-2022', 'dd-mm-yyyy'), to_date('26-08-2021', 'dd-mm-yyyy'), 1293, 38, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2318, to_date('11-10-2022', 'dd-mm-yyyy'), to_date('29-04-2021', 'dd-mm-yyyy'), 1271, 37, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2319, to_date('12-02-2022', 'dd-mm-yyyy'), to_date('29-05-2021', 'dd-mm-yyyy'), 1063, 11, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2320, to_date('11-12-2022', 'dd-mm-yyyy'), to_date('17-11-2021', 'dd-mm-yyyy'), 1275, 15, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2321, to_date('08-06-2022', 'dd-mm-yyyy'), to_date('22-11-2021', 'dd-mm-yyyy'), 1095, 34, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2322, to_date('30-09-2022', 'dd-mm-yyyy'), to_date('18-03-2021', 'dd-mm-yyyy'), 1059, 29, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2323, to_date('07-05-2022', 'dd-mm-yyyy'), to_date('14-09-2021', 'dd-mm-yyyy'), 1106, 19, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2324, to_date('20-10-2022', 'dd-mm-yyyy'), to_date('20-04-2021', 'dd-mm-yyyy'), 1164, 37, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2325, to_date('26-10-2022', 'dd-mm-yyyy'), to_date('30-01-2021', 'dd-mm-yyyy'), 1213, 7, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2326, to_date('25-06-2022', 'dd-mm-yyyy'), to_date('08-06-2021', 'dd-mm-yyyy'), 1066, 28, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2327, to_date('09-12-2022', 'dd-mm-yyyy'), to_date('10-06-2021', 'dd-mm-yyyy'), 1011, 17, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2328, to_date('12-01-2022', 'dd-mm-yyyy'), to_date('26-11-2021', 'dd-mm-yyyy'), 1364, 37, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2329, to_date('31-07-2022', 'dd-mm-yyyy'), to_date('21-09-2021', 'dd-mm-yyyy'), 1070, 40, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2330, to_date('21-04-2022', 'dd-mm-yyyy'), to_date('30-06-2021', 'dd-mm-yyyy'), 1193, 3, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2331, to_date('27-08-2022', 'dd-mm-yyyy'), to_date('21-07-2021', 'dd-mm-yyyy'), 1258, 35, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2332, to_date('28-12-2022', 'dd-mm-yyyy'), to_date('28-10-2021', 'dd-mm-yyyy'), 1258, 24, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2333, to_date('17-11-2022', 'dd-mm-yyyy'), to_date('21-03-2021', 'dd-mm-yyyy'), 1096, 34, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2334, to_date('18-06-2022', 'dd-mm-yyyy'), to_date('15-06-2021', 'dd-mm-yyyy'), 1296, 25, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2335, to_date('27-02-2022', 'dd-mm-yyyy'), to_date('18-06-2021', 'dd-mm-yyyy'), 1323, 39, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2336, to_date('28-02-2022', 'dd-mm-yyyy'), to_date('09-11-2021', 'dd-mm-yyyy'), 1164, 40, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2337, to_date('28-06-2022', 'dd-mm-yyyy'), to_date('26-01-2021', 'dd-mm-yyyy'), 1103, 26, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2338, to_date('19-07-2022', 'dd-mm-yyyy'), to_date('22-02-2021', 'dd-mm-yyyy'), 1151, 39, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2339, to_date('14-06-2022', 'dd-mm-yyyy'), to_date('15-04-2021', 'dd-mm-yyyy'), 1247, 40, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2340, to_date('10-08-2022', 'dd-mm-yyyy'), to_date('29-08-2021', 'dd-mm-yyyy'), 1113, 17, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2341, to_date('31-03-2022', 'dd-mm-yyyy'), to_date('18-01-2021', 'dd-mm-yyyy'), 1061, 10, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2342, to_date('10-12-2022', 'dd-mm-yyyy'), to_date('06-05-2021', 'dd-mm-yyyy'), 1237, 22, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2343, to_date('23-04-2022', 'dd-mm-yyyy'), to_date('04-01-2021', 'dd-mm-yyyy'), 1220, 1000, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2344, to_date('24-05-2022', 'dd-mm-yyyy'), to_date('08-12-2021', 'dd-mm-yyyy'), 1226, 17, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2345, to_date('23-06-2022', 'dd-mm-yyyy'), to_date('25-05-2021', 'dd-mm-yyyy'), 1069, 5, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2346, to_date('05-04-2022', 'dd-mm-yyyy'), to_date('22-12-2021', 'dd-mm-yyyy'), 1110, 13, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2347, to_date('19-09-2022', 'dd-mm-yyyy'), to_date('03-09-2021', 'dd-mm-yyyy'), 1147, 24, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2348, to_date('15-01-2022', 'dd-mm-yyyy'), to_date('13-08-2021', 'dd-mm-yyyy'), 1285, 8, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2349, to_date('08-06-2022', 'dd-mm-yyyy'), to_date('03-01-2021', 'dd-mm-yyyy'), 1334, 5, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2350, to_date('11-10-2022', 'dd-mm-yyyy'), to_date('10-04-2021', 'dd-mm-yyyy'), 1374, 15, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2351, to_date('25-04-2022', 'dd-mm-yyyy'), to_date('27-07-2021', 'dd-mm-yyyy'), 1029, 21, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2352, to_date('09-12-2022', 'dd-mm-yyyy'), to_date('19-01-2021', 'dd-mm-yyyy'), 1111, 23, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2353, to_date('30-09-2022', 'dd-mm-yyyy'), to_date('14-08-2021', 'dd-mm-yyyy'), 1346, 2, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2354, to_date('15-11-2022', 'dd-mm-yyyy'), to_date('01-01-2021', 'dd-mm-yyyy'), 1258, 20, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2355, to_date('27-10-2022', 'dd-mm-yyyy'), to_date('04-06-2021', 'dd-mm-yyyy'), 1337, 15, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2356, to_date('24-10-2022', 'dd-mm-yyyy'), to_date('13-03-2021', 'dd-mm-yyyy'), 1337, 15, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2357, to_date('05-11-2022', 'dd-mm-yyyy'), to_date('27-12-2021', 'dd-mm-yyyy'), 1048, 20, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2358, to_date('19-06-2022', 'dd-mm-yyyy'), to_date('11-08-2021', 'dd-mm-yyyy'), 1393, 3, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2359, to_date('27-06-2022', 'dd-mm-yyyy'), to_date('01-08-2021', 'dd-mm-yyyy'), 1385, 13, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2360, to_date('21-02-2022', 'dd-mm-yyyy'), to_date('22-10-2021', 'dd-mm-yyyy'), 1384, 16, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2361, to_date('28-05-2022', 'dd-mm-yyyy'), to_date('05-02-2021', 'dd-mm-yyyy'), 1218, 15, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2362, to_date('15-06-2022', 'dd-mm-yyyy'), to_date('13-06-2021', 'dd-mm-yyyy'), 1386, 28, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2363, to_date('09-07-2022', 'dd-mm-yyyy'), to_date('17-03-2021', 'dd-mm-yyyy'), 1305, 31, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2364, to_date('06-08-2022', 'dd-mm-yyyy'), to_date('12-08-2021', 'dd-mm-yyyy'), 1036, 37, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2365, to_date('11-10-2022', 'dd-mm-yyyy'), to_date('02-05-2021', 'dd-mm-yyyy'), 1039, 29, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2366, to_date('24-02-2022', 'dd-mm-yyyy'), to_date('05-12-2021', 'dd-mm-yyyy'), 1392, 31, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2367, to_date('12-07-2022', 'dd-mm-yyyy'), to_date('12-06-2021', 'dd-mm-yyyy'), 1226, 2000, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2368, to_date('28-06-2022', 'dd-mm-yyyy'), to_date('07-07-2021', 'dd-mm-yyyy'), 1217, 16, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2369, to_date('09-06-2022', 'dd-mm-yyyy'), to_date('30-08-2021', 'dd-mm-yyyy'), 1278, 12, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2370, to_date('19-09-2022', 'dd-mm-yyyy'), to_date('26-09-2021', 'dd-mm-yyyy'), 1293, 11, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2371, to_date('18-12-2022', 'dd-mm-yyyy'), to_date('23-08-2021', 'dd-mm-yyyy'), 1243, 1, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2372, to_date('13-03-2022', 'dd-mm-yyyy'), to_date('10-10-2021', 'dd-mm-yyyy'), 1159, 13, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2373, to_date('30-05-2022', 'dd-mm-yyyy'), to_date('02-11-2021', 'dd-mm-yyyy'), 1054, 17, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2374, to_date('11-08-2022', 'dd-mm-yyyy'), to_date('01-01-2021', 'dd-mm-yyyy'), 1071, 21, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2375, to_date('16-07-2022', 'dd-mm-yyyy'), to_date('05-07-2021', 'dd-mm-yyyy'), 1398, 3, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2376, to_date('10-08-2022', 'dd-mm-yyyy'), to_date('11-03-2021', 'dd-mm-yyyy'), 1187, 29, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2377, to_date('21-09-2022', 'dd-mm-yyyy'), to_date('31-07-2021', 'dd-mm-yyyy'), 1022, 19, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2378, to_date('04-01-2022', 'dd-mm-yyyy'), to_date('01-07-2021', 'dd-mm-yyyy'), 1183, 28, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2379, to_date('09-09-2022', 'dd-mm-yyyy'), to_date('24-04-2021', 'dd-mm-yyyy'), 1251, 14, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2380, to_date('24-07-2022', 'dd-mm-yyyy'), to_date('19-04-2021', 'dd-mm-yyyy'), 1086, 34, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2381, to_date('27-10-2022', 'dd-mm-yyyy'), to_date('04-10-2021', 'dd-mm-yyyy'), 1342, 28, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2382, to_date('07-04-2022', 'dd-mm-yyyy'), to_date('24-10-2021', 'dd-mm-yyyy'), 1338, 25, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2383, to_date('31-12-2022', 'dd-mm-yyyy'), to_date('25-01-2021', 'dd-mm-yyyy'), 1055, 31, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2384, to_date('09-04-2022', 'dd-mm-yyyy'), to_date('20-07-2021', 'dd-mm-yyyy'), 1280, 40, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2385, to_date('12-01-2022', 'dd-mm-yyyy'), to_date('31-07-2021', 'dd-mm-yyyy'), 1255, 33, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2386, to_date('28-04-2022', 'dd-mm-yyyy'), to_date('23-07-2021', 'dd-mm-yyyy'), 1268, 18, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2387, to_date('20-08-2022', 'dd-mm-yyyy'), to_date('25-09-2021', 'dd-mm-yyyy'), 1334, 25, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2388, to_date('11-10-2022', 'dd-mm-yyyy'), to_date('03-07-2021', 'dd-mm-yyyy'), 1205, 2, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2389, to_date('23-12-2022', 'dd-mm-yyyy'), to_date('16-10-2021', 'dd-mm-yyyy'), 1060, 33, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2390, to_date('05-03-2022', 'dd-mm-yyyy'), to_date('16-07-2021', 'dd-mm-yyyy'), 1107, 13, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2391, to_date('15-10-2022', 'dd-mm-yyyy'), to_date('20-05-2021', 'dd-mm-yyyy'), 1254, 7, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2392, to_date('19-05-2022', 'dd-mm-yyyy'), to_date('04-01-2021', 'dd-mm-yyyy'), 1286, 18, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2393, to_date('10-01-2022', 'dd-mm-yyyy'), to_date('05-11-2021', 'dd-mm-yyyy'), 1287, 22, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2394, to_date('15-04-2022', 'dd-mm-yyyy'), to_date('14-12-2021', 'dd-mm-yyyy'), 1364, 4, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2395, to_date('11-02-2022', 'dd-mm-yyyy'), to_date('25-05-2021', 'dd-mm-yyyy'), 1003, 24, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2396, to_date('28-01-2022', 'dd-mm-yyyy'), to_date('30-05-2021', 'dd-mm-yyyy'), 1309, 16, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2397, to_date('24-09-2022', 'dd-mm-yyyy'), to_date('05-02-2021', 'dd-mm-yyyy'), 1072, 18, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2398, to_date('16-01-2022', 'dd-mm-yyyy'), to_date('27-07-2021', 'dd-mm-yyyy'), 1298, 1, null, null);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2399, to_date('03-03-2022', 'dd-mm-yyyy'), to_date('28-08-2021', 'dd-mm-yyyy'), 1361, 11, null, null);
commit;
prompt 400 records committed...
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (1, to_date('28-11-2022', 'dd-mm-yyyy'), null, 525, null, 482, 151);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (2, to_date('31-12-2020', 'dd-mm-yyyy'), null, 337, null, 265, 246);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (3, to_date('18-02-2028', 'dd-mm-yyyy'), null, 221, null, 456, 447);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (4, to_date('03-03-2028', 'dd-mm-yyyy'), null, 257, null, 238, 430);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (5, to_date('29-01-2021', 'dd-mm-yyyy'), null, 541, null, 278, 62);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (6, to_date('23-11-2020', 'dd-mm-yyyy'), null, 138, null, 431, 411);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (7, to_date('24-11-2027', 'dd-mm-yyyy'), null, 184, null, 406, 143);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (8, to_date('27-08-2022', 'dd-mm-yyyy'), null, 134, null, 480, 166);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (9, to_date('26-05-2025', 'dd-mm-yyyy'), null, 376, null, 529, 392);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (10, to_date('13-02-2024', 'dd-mm-yyyy'), null, 455, null, 504, 208);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (11, to_date('27-09-2021', 'dd-mm-yyyy'), null, 388, null, 515, 32);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (12, to_date('11-08-2022', 'dd-mm-yyyy'), null, 508, null, 446, 339);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (13, to_date('18-05-2020', 'dd-mm-yyyy'), null, 204, null, 259, 367);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (14, to_date('13-07-2022', 'dd-mm-yyyy'), null, 299, null, 308, 383);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (16, to_date('16-10-2022', 'dd-mm-yyyy'), null, 138, null, 291, 33);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (17, to_date('19-04-2027', 'dd-mm-yyyy'), null, 408, null, 326, 303);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (18, to_date('03-11-2025', 'dd-mm-yyyy'), null, 411, null, 209, 226);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (19, to_date('16-03-2027', 'dd-mm-yyyy'), null, 457, null, 348, 375);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (20, to_date('19-02-2026', 'dd-mm-yyyy'), null, 347, null, 386, 415);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (21, to_date('07-03-2027', 'dd-mm-yyyy'), null, 395, null, 350, 432);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (22, to_date('11-12-2023', 'dd-mm-yyyy'), null, 400, null, 377, 213);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (23, to_date('14-06-2024', 'dd-mm-yyyy'), null, 214, null, 328, 302);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (24, to_date('12-02-2024', 'dd-mm-yyyy'), null, 383, null, 409, 315);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (25, to_date('10-01-2024', 'dd-mm-yyyy'), null, 497, null, 289, 326);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (26, to_date('18-05-2023', 'dd-mm-yyyy'), null, 229, null, 416, 379);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (27, to_date('09-02-2021', 'dd-mm-yyyy'), null, 346, null, 539, 321);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (28, to_date('06-01-2022', 'dd-mm-yyyy'), null, 338, null, 289, 427);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (29, to_date('14-03-2028', 'dd-mm-yyyy'), null, 397, null, 203, 68);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (30, to_date('02-12-2025', 'dd-mm-yyyy'), null, 390, null, 555, 333);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (31, to_date('04-12-2027', 'dd-mm-yyyy'), null, 487, null, 241, 193);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (32, to_date('19-04-2023', 'dd-mm-yyyy'), null, 407, null, 453, 23);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (33, to_date('21-05-2026', 'dd-mm-yyyy'), null, 239, null, 441, 60);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (34, to_date('28-06-2026', 'dd-mm-yyyy'), null, 147, null, 526, 130);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (35, to_date('19-03-2021', 'dd-mm-yyyy'), null, 464, null, 407, 63);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (36, to_date('04-05-2024', 'dd-mm-yyyy'), null, 218, null, 544, 354);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (37, to_date('28-10-2024', 'dd-mm-yyyy'), null, 350, null, 271, 108);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (38, to_date('12-10-2028', 'dd-mm-yyyy'), null, 544, null, 310, 42);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (39, to_date('21-03-2024', 'dd-mm-yyyy'), null, 271, null, 300, 6);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (40, to_date('16-02-2028', 'dd-mm-yyyy'), null, 227, null, 268, 168);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (42, to_date('29-05-2025', 'dd-mm-yyyy'), null, 113, null, 286, 26);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (43, to_date('16-10-2022', 'dd-mm-yyyy'), null, 346, null, 598, 429);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (44, to_date('20-09-2024', 'dd-mm-yyyy'), null, 170, null, 503, 13);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (45, to_date('15-11-2021', 'dd-mm-yyyy'), null, 290, null, 598, 142);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (46, to_date('02-06-2026', 'dd-mm-yyyy'), null, 520, null, 359, 288);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (47, to_date('26-01-2028', 'dd-mm-yyyy'), null, 183, null, 558, 443);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (48, to_date('09-08-2023', 'dd-mm-yyyy'), null, 389, null, 559, 86);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (49, to_date('27-04-2022', 'dd-mm-yyyy'), null, 406, null, 521, 185);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (50, to_date('28-06-2024', 'dd-mm-yyyy'), null, 434, null, 201, 388);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (51, to_date('02-07-2025', 'dd-mm-yyyy'), null, 125, null, 401, 375);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (52, to_date('20-03-2027', 'dd-mm-yyyy'), null, 326, null, 320, 398);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (53, to_date('08-06-2021', 'dd-mm-yyyy'), null, 446, null, 547, 109);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (54, to_date('21-02-2021', 'dd-mm-yyyy'), null, 471, null, 387, 290);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (55, to_date('22-05-2028', 'dd-mm-yyyy'), null, 542, null, 588, 339);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (56, to_date('08-04-2026', 'dd-mm-yyyy'), null, 252, null, 537, 420);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (57, to_date('10-10-2021', 'dd-mm-yyyy'), null, 375, null, 373, 224);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (58, to_date('03-10-2024', 'dd-mm-yyyy'), null, 424, null, 359, 139);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (59, to_date('31-10-2024', 'dd-mm-yyyy'), null, 345, null, 589, 379);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (60, to_date('19-08-2027', 'dd-mm-yyyy'), null, 292, null, 221, 432);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (61, to_date('11-10-2021', 'dd-mm-yyyy'), null, 109, null, 244, 340);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (62, to_date('06-05-2023', 'dd-mm-yyyy'), null, 161, null, 391, 148);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (63, to_date('19-09-2022', 'dd-mm-yyyy'), null, 466, null, 594, 175);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (64, to_date('01-12-2028', 'dd-mm-yyyy'), null, 335, null, 599, 174);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (65, to_date('30-11-2022', 'dd-mm-yyyy'), null, 189, null, 250, 36);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (66, to_date('14-03-2027', 'dd-mm-yyyy'), null, 460, null, 494, 279);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (67, to_date('05-02-2022', 'dd-mm-yyyy'), null, 123, null, 588, 445);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (68, to_date('01-02-2027', 'dd-mm-yyyy'), null, 510, null, 385, 395);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (69, to_date('11-04-2021', 'dd-mm-yyyy'), null, 458, null, 553, 52);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (70, to_date('28-12-2026', 'dd-mm-yyyy'), null, 129, null, 448, 3);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (71, to_date('29-03-2025', 'dd-mm-yyyy'), null, 259, null, 433, 211);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (72, to_date('01-08-2024', 'dd-mm-yyyy'), null, 210, null, 423, 429);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (73, to_date('31-08-2027', 'dd-mm-yyyy'), null, 415, null, 258, 152);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (75, to_date('31-12-2025', 'dd-mm-yyyy'), null, 387, null, 365, 393);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (76, to_date('08-12-2025', 'dd-mm-yyyy'), null, 495, null, 260, 307);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (77, to_date('11-06-2027', 'dd-mm-yyyy'), null, 115, null, 373, 150);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (78, to_date('02-12-2023', 'dd-mm-yyyy'), null, 415, null, 514, 227);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (79, to_date('08-06-2021', 'dd-mm-yyyy'), null, 336, null, 573, 8);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (80, to_date('28-10-2028', 'dd-mm-yyyy'), null, 460, null, 499, 324);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (81, to_date('16-08-2027', 'dd-mm-yyyy'), null, 120, null, 382, 124);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (82, to_date('02-02-2028', 'dd-mm-yyyy'), null, 438, null, 368, 97);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (83, to_date('08-10-2027', 'dd-mm-yyyy'), null, 516, null, 246, 181);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (84, to_date('18-12-2024', 'dd-mm-yyyy'), null, 246, null, 501, 32);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (85, to_date('07-01-2026', 'dd-mm-yyyy'), null, 494, null, 460, 428);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (86, to_date('25-11-2020', 'dd-mm-yyyy'), null, 435, null, 239, 406);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (87, to_date('03-03-2022', 'dd-mm-yyyy'), null, 302, null, 571, 215);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (88, to_date('18-05-2028', 'dd-mm-yyyy'), null, 171, null, 277, 156);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (89, to_date('01-06-2027', 'dd-mm-yyyy'), null, 271, null, 431, 13);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (90, to_date('08-09-2025', 'dd-mm-yyyy'), null, 124, null, 387, 350);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (91, to_date('02-11-2021', 'dd-mm-yyyy'), null, 518, null, 259, 243);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (92, to_date('03-12-2024', 'dd-mm-yyyy'), null, 338, null, 335, 195);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (93, to_date('02-02-2027', 'dd-mm-yyyy'), null, 294, null, 576, 176);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (94, to_date('10-08-2023', 'dd-mm-yyyy'), null, 453, null, 414, 272);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (95, to_date('18-06-2028', 'dd-mm-yyyy'), null, 401, null, 279, 344);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (96, to_date('25-01-2027', 'dd-mm-yyyy'), null, 300, null, 543, 345);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (97, to_date('13-02-2028', 'dd-mm-yyyy'), null, 318, null, 360, 336);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (98, to_date('31-01-2023', 'dd-mm-yyyy'), null, 278, null, 308, 166);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (99, to_date('03-02-2027', 'dd-mm-yyyy'), null, 195, null, 596, 69);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (100, to_date('13-05-2024', 'dd-mm-yyyy'), null, 245, null, 348, 320);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (101, to_date('25-04-2026', 'dd-mm-yyyy'), null, 230, null, 361, 385);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (102, to_date('23-04-2023', 'dd-mm-yyyy'), null, 166, null, 438, 313);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (103, to_date('09-10-2023', 'dd-mm-yyyy'), null, 425, null, 568, 174);
commit;
prompt 500 records committed...
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (104, to_date('20-01-2027', 'dd-mm-yyyy'), null, 324, null, 423, 309);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (105, to_date('02-10-2024', 'dd-mm-yyyy'), null, 528, null, 280, 13);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (106, to_date('04-06-2025', 'dd-mm-yyyy'), null, 357, null, 208, 399);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (107, to_date('17-09-2027', 'dd-mm-yyyy'), null, 252, null, 409, 403);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (108, to_date('15-10-2024', 'dd-mm-yyyy'), null, 288, null, 295, 25);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (109, to_date('07-03-2025', 'dd-mm-yyyy'), null, 497, null, 329, 363);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (110, to_date('02-06-2022', 'dd-mm-yyyy'), null, 235, null, 217, 282);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (112, to_date('23-05-2026', 'dd-mm-yyyy'), null, 312, null, 202, 413);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (113, to_date('28-10-2026', 'dd-mm-yyyy'), null, 190, null, 243, 417);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (114, to_date('30-10-2026', 'dd-mm-yyyy'), null, 521, null, 551, 307);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (115, to_date('06-07-2022', 'dd-mm-yyyy'), null, 399, null, 525, 74);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (116, to_date('12-02-2025', 'dd-mm-yyyy'), null, 459, null, 344, 141);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (117, to_date('04-05-2020', 'dd-mm-yyyy'), null, 399, null, 593, 449);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (118, to_date('08-11-2026', 'dd-mm-yyyy'), null, 474, null, 480, 93);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (119, to_date('26-11-2027', 'dd-mm-yyyy'), null, 518, null, 534, 303);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (120, to_date('25-11-2023', 'dd-mm-yyyy'), null, 332, null, 382, 227);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (121, to_date('11-12-2020', 'dd-mm-yyyy'), null, 231, null, 515, 230);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (122, to_date('28-05-2024', 'dd-mm-yyyy'), null, 511, null, 272, 201);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (124, to_date('16-06-2023', 'dd-mm-yyyy'), null, 182, null, 537, 140);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (125, to_date('28-12-2024', 'dd-mm-yyyy'), null, 132, null, 512, 30);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (126, to_date('18-03-2023', 'dd-mm-yyyy'), null, 540, null, 322, 414);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (127, to_date('25-02-2025', 'dd-mm-yyyy'), null, 313, null, 574, 65);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (128, to_date('03-05-2022', 'dd-mm-yyyy'), null, 327, null, 554, 305);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (129, to_date('28-06-2028', 'dd-mm-yyyy'), null, 358, null, 229, 446);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (130, to_date('21-01-2026', 'dd-mm-yyyy'), null, 121, null, 509, 200);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (131, to_date('24-05-2021', 'dd-mm-yyyy'), null, 137, null, 313, 346);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (132, to_date('10-03-2026', 'dd-mm-yyyy'), null, 337, null, 477, 434);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (133, to_date('11-05-2023', 'dd-mm-yyyy'), null, 242, null, 464, 311);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (134, to_date('16-09-2021', 'dd-mm-yyyy'), null, 423, null, 380, 239);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (135, to_date('01-10-2021', 'dd-mm-yyyy'), null, 520, null, 454, 103);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (137, to_date('15-05-2024', 'dd-mm-yyyy'), null, 159, null, 319, 187);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (138, to_date('16-02-2025', 'dd-mm-yyyy'), null, 384, null, 480, 10);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (139, to_date('23-08-2026', 'dd-mm-yyyy'), null, 167, null, 208, 41);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (140, to_date('18-05-2028', 'dd-mm-yyyy'), null, 379, null, 442, 87);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (141, to_date('07-03-2020', 'dd-mm-yyyy'), null, 101, null, 542, 142);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (142, to_date('08-01-2021', 'dd-mm-yyyy'), null, 296, null, 420, 10);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (143, to_date('05-03-2024', 'dd-mm-yyyy'), null, 133, null, 464, 94);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (144, to_date('21-01-2024', 'dd-mm-yyyy'), null, 254, null, 315, 448);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (145, to_date('12-10-2022', 'dd-mm-yyyy'), null, 113, null, 580, 413);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (146, to_date('08-11-2022', 'dd-mm-yyyy'), null, 510, null, 594, 206);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (147, to_date('09-02-2023', 'dd-mm-yyyy'), null, 147, null, 559, 119);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (148, to_date('26-06-2028', 'dd-mm-yyyy'), null, 422, null, 323, 290);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (149, to_date('21-04-2023', 'dd-mm-yyyy'), null, 336, null, 578, 196);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (150, to_date('06-11-2020', 'dd-mm-yyyy'), null, 162, null, 562, 379);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (151, to_date('12-11-2022', 'dd-mm-yyyy'), null, 341, null, 313, 421);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (152, to_date('07-08-2021', 'dd-mm-yyyy'), null, 143, null, 365, 187);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (153, to_date('03-02-2024', 'dd-mm-yyyy'), null, 280, null, 456, 238);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (154, to_date('09-08-2026', 'dd-mm-yyyy'), null, 470, null, 381, 43);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (155, to_date('14-03-2024', 'dd-mm-yyyy'), null, 454, null, 284, 415);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (156, to_date('18-05-2023', 'dd-mm-yyyy'), null, 211, null, 389, 108);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (157, to_date('02-05-2022', 'dd-mm-yyyy'), null, 243, null, 292, 195);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (158, to_date('08-05-2028', 'dd-mm-yyyy'), null, 206, null, 521, 205);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (159, to_date('21-05-2024', 'dd-mm-yyyy'), null, 373, null, 536, 170);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (160, to_date('20-02-2021', 'dd-mm-yyyy'), null, 332, null, 257, 252);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (161, to_date('13-10-2020', 'dd-mm-yyyy'), null, 245, null, 348, 252);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (162, to_date('28-12-2023', 'dd-mm-yyyy'), null, 241, null, 446, 375);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (163, to_date('28-01-2024', 'dd-mm-yyyy'), null, 117, null, 301, 219);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (164, to_date('01-09-2028', 'dd-mm-yyyy'), null, 361, null, 274, 237);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (165, to_date('27-04-2026', 'dd-mm-yyyy'), null, 493, null, 361, 448);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (166, to_date('24-05-2022', 'dd-mm-yyyy'), null, 503, null, 479, 96);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (167, to_date('05-04-2021', 'dd-mm-yyyy'), null, 218, null, 219, 101);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (168, to_date('28-10-2024', 'dd-mm-yyyy'), null, 264, null, 442, 99);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (169, to_date('25-05-2026', 'dd-mm-yyyy'), null, 332, null, 246, 239);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (170, to_date('14-09-2022', 'dd-mm-yyyy'), null, 195, null, 458, 392);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (171, to_date('02-12-2023', 'dd-mm-yyyy'), null, 391, null, 519, 249);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (172, to_date('27-05-2025', 'dd-mm-yyyy'), null, 486, null, 590, 380);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (173, to_date('19-07-2025', 'dd-mm-yyyy'), null, 376, null, 326, 37);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (174, to_date('10-07-2028', 'dd-mm-yyyy'), null, 526, null, 379, 242);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (175, to_date('13-04-2025', 'dd-mm-yyyy'), null, 341, null, 387, 255);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (176, to_date('28-05-2022', 'dd-mm-yyyy'), null, 485, null, 440, 54);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (177, to_date('13-08-2028', 'dd-mm-yyyy'), null, 488, null, 498, 311);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (178, to_date('31-03-2021', 'dd-mm-yyyy'), null, 403, null, 351, 368);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (179, to_date('03-11-2022', 'dd-mm-yyyy'), null, 395, null, 350, 162);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (180, to_date('20-12-2021', 'dd-mm-yyyy'), null, 500, null, 365, 136);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (181, to_date('07-05-2021', 'dd-mm-yyyy'), null, 346, null, 383, 205);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (182, to_date('29-11-2025', 'dd-mm-yyyy'), null, 257, null, 444, 189);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (184, to_date('01-08-2027', 'dd-mm-yyyy'), null, 481, null, 492, 246);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (185, to_date('16-05-2028', 'dd-mm-yyyy'), null, 421, null, 284, 29);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (186, to_date('06-06-2027', 'dd-mm-yyyy'), null, 186, null, 360, 38);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (187, to_date('18-04-2027', 'dd-mm-yyyy'), null, 514, null, 353, 131);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (188, to_date('28-05-2024', 'dd-mm-yyyy'), null, 144, null, 308, 256);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (189, to_date('26-12-2024', 'dd-mm-yyyy'), null, 437, null, 291, 352);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (190, to_date('11-12-2027', 'dd-mm-yyyy'), null, 199, null, 520, 96);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (191, to_date('01-06-2024', 'dd-mm-yyyy'), null, 449, null, 204, 261);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (192, to_date('24-09-2022', 'dd-mm-yyyy'), null, 127, null, 233, 360);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (194, to_date('13-09-2025', 'dd-mm-yyyy'), null, 162, null, 274, 269);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (195, to_date('11-02-2025', 'dd-mm-yyyy'), null, 113, null, 204, 211);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (196, to_date('27-12-2022', 'dd-mm-yyyy'), null, 346, null, 296, 218);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (197, to_date('25-08-2025', 'dd-mm-yyyy'), null, 394, null, 285, 128);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (198, to_date('30-09-2021', 'dd-mm-yyyy'), null, 299, null, 248, 345);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (199, to_date('12-07-2024', 'dd-mm-yyyy'), null, 463, null, 372, 166);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (200, to_date('31-10-2027', 'dd-mm-yyyy'), null, 271, null, 397, 202);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (201, to_date('22-06-2027', 'dd-mm-yyyy'), null, 256, null, 367, 358);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (202, to_date('07-04-2028', 'dd-mm-yyyy'), null, 509, null, 322, 371);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (203, to_date('16-01-2023', 'dd-mm-yyyy'), null, 323, null, 580, 175);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (204, to_date('11-02-2022', 'dd-mm-yyyy'), null, 107, null, 286, 207);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (205, to_date('04-06-2026', 'dd-mm-yyyy'), null, 170, null, 303, 435);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (206, to_date('12-06-2027', 'dd-mm-yyyy'), null, 470, null, 459, 380);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (207, to_date('07-06-2022', 'dd-mm-yyyy'), null, 330, null, 593, 305);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (208, to_date('07-11-2023', 'dd-mm-yyyy'), null, 205, null, 338, 183);
commit;
prompt 600 records committed...
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (209, to_date('01-10-2022', 'dd-mm-yyyy'), null, 320, null, 533, 259);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (210, to_date('23-01-2021', 'dd-mm-yyyy'), null, 376, null, 479, 52);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (211, to_date('15-11-2021', 'dd-mm-yyyy'), null, 241, null, 582, 280);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (212, to_date('13-07-2023', 'dd-mm-yyyy'), null, 164, null, 257, 327);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (213, to_date('01-06-2022', 'dd-mm-yyyy'), null, 338, null, 303, 178);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (214, to_date('20-04-2025', 'dd-mm-yyyy'), null, 458, null, 592, 397);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (215, to_date('18-03-2025', 'dd-mm-yyyy'), null, 415, null, 579, 399);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (216, to_date('17-04-2027', 'dd-mm-yyyy'), null, 547, null, 587, 367);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (217, to_date('26-01-2022', 'dd-mm-yyyy'), null, 189, null, 219, 216);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (219, to_date('20-02-2028', 'dd-mm-yyyy'), null, 443, null, 272, 266);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (220, to_date('06-11-2025', 'dd-mm-yyyy'), null, 382, null, 370, 160);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (221, to_date('02-11-2028', 'dd-mm-yyyy'), null, 169, null, 212, 21);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (223, to_date('19-02-2028', 'dd-mm-yyyy'), null, 107, null, 599, 60);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (224, to_date('07-03-2028', 'dd-mm-yyyy'), null, 316, null, 326, 335);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (225, to_date('02-06-2028', 'dd-mm-yyyy'), null, 314, null, 447, 46);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (226, to_date('18-12-2024', 'dd-mm-yyyy'), null, 485, null, 555, 396);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (227, to_date('18-05-2021', 'dd-mm-yyyy'), null, 362, null, 344, 180);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (228, to_date('27-05-2022', 'dd-mm-yyyy'), null, 330, null, 556, 58);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (229, to_date('16-04-2024', 'dd-mm-yyyy'), null, 124, null, 396, 95);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (230, to_date('17-05-2021', 'dd-mm-yyyy'), null, 440, null, 505, 246);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (231, to_date('02-12-2024', 'dd-mm-yyyy'), null, 324, null, 204, 191);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (232, to_date('11-04-2025', 'dd-mm-yyyy'), null, 323, null, 464, 313);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (233, to_date('07-01-2021', 'dd-mm-yyyy'), null, 462, null, 216, 10);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (234, to_date('28-05-2023', 'dd-mm-yyyy'), null, 203, null, 462, 388);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (236, to_date('10-05-2024', 'dd-mm-yyyy'), null, 320, null, 333, 89);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (237, to_date('14-12-2024', 'dd-mm-yyyy'), null, 217, null, 259, 212);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (238, to_date('28-12-2027', 'dd-mm-yyyy'), null, 181, null, 530, 197);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (239, to_date('30-07-2027', 'dd-mm-yyyy'), null, 302, null, 485, 362);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (240, to_date('21-08-2023', 'dd-mm-yyyy'), null, 302, null, 325, 418);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (241, to_date('30-10-2020', 'dd-mm-yyyy'), null, 166, null, 253, 358);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (242, to_date('19-04-2024', 'dd-mm-yyyy'), null, 331, null, 442, 352);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (243, to_date('07-04-2027', 'dd-mm-yyyy'), null, 387, null, 220, 332);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (244, to_date('20-03-2028', 'dd-mm-yyyy'), null, 241, null, 440, 252);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (245, to_date('18-12-2028', 'dd-mm-yyyy'), null, 534, null, 567, 327);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (246, to_date('16-06-2025', 'dd-mm-yyyy'), null, 304, null, 377, 223);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (247, to_date('31-10-2023', 'dd-mm-yyyy'), null, 377, null, 248, 267);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (248, to_date('27-06-2021', 'dd-mm-yyyy'), null, 108, null, 429, 268);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (249, to_date('21-03-2026', 'dd-mm-yyyy'), null, 443, null, 510, 241);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (250, to_date('19-10-2024', 'dd-mm-yyyy'), null, 277, null, 476, 175);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (251, to_date('28-01-2027', 'dd-mm-yyyy'), null, 250, null, 502, 92);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (252, to_date('03-08-2026', 'dd-mm-yyyy'), null, 210, null, 304, 159);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (253, to_date('18-10-2028', 'dd-mm-yyyy'), null, 330, null, 292, 358);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (254, to_date('10-08-2023', 'dd-mm-yyyy'), null, 422, null, 292, 261);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (255, to_date('30-01-2025', 'dd-mm-yyyy'), null, 409, null, 523, 309);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (256, to_date('31-05-2022', 'dd-mm-yyyy'), null, 502, null, 511, 311);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (257, to_date('08-08-2025', 'dd-mm-yyyy'), null, 488, null, 564, 11);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (258, to_date('05-07-2027', 'dd-mm-yyyy'), null, 190, null, 387, 406);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (259, to_date('10-08-2025', 'dd-mm-yyyy'), null, 464, null, 529, 214);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (260, to_date('30-03-2026', 'dd-mm-yyyy'), null, 358, null, 524, 431);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (261, to_date('18-09-2028', 'dd-mm-yyyy'), null, 178, null, 389, 257);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (262, to_date('24-01-2028', 'dd-mm-yyyy'), null, 495, null, 575, 107);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (263, to_date('10-12-2024', 'dd-mm-yyyy'), null, 141, null, 588, 413);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (264, to_date('31-10-2027', 'dd-mm-yyyy'), null, 361, null, 303, 364);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (265, to_date('11-03-2024', 'dd-mm-yyyy'), null, 117, null, 558, 186);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (266, to_date('19-02-2024', 'dd-mm-yyyy'), null, 348, null, 272, 240);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (267, to_date('25-10-2025', 'dd-mm-yyyy'), null, 216, null, 511, 306);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (268, to_date('18-07-2028', 'dd-mm-yyyy'), null, 189, null, 388, 411);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (269, to_date('18-04-2022', 'dd-mm-yyyy'), null, 445, null, 492, 333);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (270, to_date('26-01-2023', 'dd-mm-yyyy'), null, 227, null, 367, 293);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (271, to_date('02-05-2021', 'dd-mm-yyyy'), null, 156, null, 325, 216);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (272, to_date('30-10-2027', 'dd-mm-yyyy'), null, 212, null, 471, 318);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (273, to_date('14-10-2021', 'dd-mm-yyyy'), null, 336, null, 258, 209);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (274, to_date('30-11-2026', 'dd-mm-yyyy'), null, 346, null, 512, 148);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (275, to_date('20-12-2025', 'dd-mm-yyyy'), null, 451, null, 510, 412);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (276, to_date('02-03-2026', 'dd-mm-yyyy'), null, 218, null, 412, 292);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (277, to_date('24-12-2028', 'dd-mm-yyyy'), null, 129, null, 533, 30);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (278, to_date('15-01-2020', 'dd-mm-yyyy'), null, 518, null, 476, 388);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (279, to_date('19-02-2021', 'dd-mm-yyyy'), null, 270, null, 498, 185);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (280, to_date('01-04-2026', 'dd-mm-yyyy'), null, 399, null, 555, 320);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (281, to_date('18-08-2022', 'dd-mm-yyyy'), null, 226, null, 241, 171);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (282, to_date('26-11-2021', 'dd-mm-yyyy'), null, 326, null, 401, 141);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (283, to_date('03-11-2026', 'dd-mm-yyyy'), null, 432, null, 383, 235);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (284, to_date('30-01-2025', 'dd-mm-yyyy'), null, 491, null, 297, 9);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (285, to_date('13-10-2027', 'dd-mm-yyyy'), null, 109, null, 498, 111);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (286, to_date('30-12-2027', 'dd-mm-yyyy'), null, 217, null, 219, 153);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (287, to_date('04-06-2027', 'dd-mm-yyyy'), null, 318, null, 560, 68);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (288, to_date('21-02-2028', 'dd-mm-yyyy'), null, 180, null, 356, 401);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (289, to_date('09-05-2023', 'dd-mm-yyyy'), null, 488, null, 402, 73);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (290, to_date('07-01-2024', 'dd-mm-yyyy'), null, 226, null, 352, 433);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (291, to_date('19-06-2021', 'dd-mm-yyyy'), null, 278, null, 445, 182);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (292, to_date('07-12-2028', 'dd-mm-yyyy'), null, 480, null, 325, 299);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (293, to_date('02-12-2021', 'dd-mm-yyyy'), null, 467, null, 289, 135);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (294, to_date('31-10-2026', 'dd-mm-yyyy'), null, 321, null, 289, 383);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (295, to_date('28-03-2027', 'dd-mm-yyyy'), null, 178, null, 377, 62);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (296, to_date('02-07-2025', 'dd-mm-yyyy'), null, 444, null, 327, 40);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (297, to_date('12-12-2023', 'dd-mm-yyyy'), null, 161, null, 592, 253);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (298, to_date('09-12-2026', 'dd-mm-yyyy'), null, 172, null, 551, 437);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (299, to_date('10-06-2021', 'dd-mm-yyyy'), null, 495, null, 466, 192);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (300, to_date('10-09-2021', 'dd-mm-yyyy'), null, 355, null, 567, 76);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (301, to_date('15-08-2027', 'dd-mm-yyyy'), null, 422, null, 532, 249);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (302, to_date('19-04-2024', 'dd-mm-yyyy'), null, 342, null, 454, 286);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (303, to_date('08-12-2024', 'dd-mm-yyyy'), null, 388, null, 286, 224);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (304, to_date('01-05-2026', 'dd-mm-yyyy'), null, 166, null, 205, 325);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (305, to_date('23-10-2025', 'dd-mm-yyyy'), null, 446, null, 577, 264);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (306, to_date('24-10-2027', 'dd-mm-yyyy'), null, 223, null, 566, 153);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (307, to_date('29-10-2020', 'dd-mm-yyyy'), null, 310, null, 581, 393);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (309, to_date('17-12-2022', 'dd-mm-yyyy'), null, 425, null, 293, 77);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (310, to_date('19-11-2025', 'dd-mm-yyyy'), null, 315, null, 475, 406);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (311, to_date('04-02-2022', 'dd-mm-yyyy'), null, 203, null, 272, 345);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (312, to_date('01-01-2028', 'dd-mm-yyyy'), null, 528, null, 257, 197);
commit;
prompt 700 records committed...
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (313, to_date('14-11-2025', 'dd-mm-yyyy'), null, 355, null, 523, 248);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (314, to_date('27-09-2027', 'dd-mm-yyyy'), null, 377, null, 573, 353);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (315, to_date('24-07-2023', 'dd-mm-yyyy'), null, 172, null, 539, 432);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (316, to_date('11-05-2028', 'dd-mm-yyyy'), null, 523, null, 592, 235);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (317, to_date('21-09-2027', 'dd-mm-yyyy'), null, 130, null, 527, 112);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (318, to_date('27-06-2025', 'dd-mm-yyyy'), null, 362, null, 250, 287);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (319, to_date('24-12-2024', 'dd-mm-yyyy'), null, 290, null, 272, 318);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (320, to_date('09-12-2024', 'dd-mm-yyyy'), null, 538, null, 363, 247);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (321, to_date('29-09-2024', 'dd-mm-yyyy'), null, 369, null, 406, 320);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (322, to_date('11-02-2026', 'dd-mm-yyyy'), null, 374, null, 221, 196);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (323, to_date('21-06-2026', 'dd-mm-yyyy'), null, 369, null, 460, 188);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (324, to_date('20-12-2028', 'dd-mm-yyyy'), null, 306, null, 341, 70);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (325, to_date('22-05-2026', 'dd-mm-yyyy'), null, 320, null, 452, 212);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (326, to_date('16-11-2025', 'dd-mm-yyyy'), null, 511, null, 383, 327);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (327, to_date('07-08-2025', 'dd-mm-yyyy'), null, 171, null, 405, 65);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (328, to_date('15-08-2023', 'dd-mm-yyyy'), null, 300, null, 507, 131);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (329, to_date('26-12-2021', 'dd-mm-yyyy'), null, 167, null, 347, 206);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (330, to_date('03-10-2026', 'dd-mm-yyyy'), null, 197, null, 307, 396);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (331, to_date('07-11-2020', 'dd-mm-yyyy'), null, 217, null, 337, 58);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (332, to_date('11-05-2026', 'dd-mm-yyyy'), null, 347, null, 241, 103);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (333, to_date('18-02-2022', 'dd-mm-yyyy'), null, 260, null, 445, 152);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (334, to_date('30-12-2025', 'dd-mm-yyyy'), null, 320, null, 379, 170);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (335, to_date('10-04-2028', 'dd-mm-yyyy'), null, 295, null, 323, 414);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (336, to_date('12-11-2028', 'dd-mm-yyyy'), null, 286, null, 311, 406);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (337, to_date('16-05-2025', 'dd-mm-yyyy'), null, 316, null, 431, 26);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (338, to_date('07-11-2028', 'dd-mm-yyyy'), null, 391, null, 486, 218);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (339, to_date('25-07-2021', 'dd-mm-yyyy'), null, 546, null, 241, 381);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (340, to_date('21-09-2027', 'dd-mm-yyyy'), null, 546, null, 592, 449);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (341, to_date('25-11-2023', 'dd-mm-yyyy'), null, 350, null, 268, 421);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (342, to_date('27-01-2020', 'dd-mm-yyyy'), null, 545, null, 464, 393);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (343, to_date('23-10-2022', 'dd-mm-yyyy'), null, 213, null, 496, 383);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (344, to_date('28-06-2028', 'dd-mm-yyyy'), null, 173, null, 384, 230);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (347, to_date('28-09-2024', 'dd-mm-yyyy'), null, 485, null, 474, 425);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (348, to_date('18-01-2025', 'dd-mm-yyyy'), null, 287, null, 289, 326);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (349, to_date('29-07-2020', 'dd-mm-yyyy'), null, 213, null, 210, 135);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (350, to_date('30-06-2026', 'dd-mm-yyyy'), null, 124, null, 229, 280);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (351, to_date('16-03-2021', 'dd-mm-yyyy'), null, 484, null, 206, 359);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (352, to_date('14-03-2021', 'dd-mm-yyyy'), null, 412, null, 292, 368);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (353, to_date('15-02-2025', 'dd-mm-yyyy'), null, 388, null, 453, 345);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (354, to_date('25-05-2021', 'dd-mm-yyyy'), null, 138, null, 452, 351);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (356, to_date('02-12-2028', 'dd-mm-yyyy'), null, 351, null, 412, 238);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (357, to_date('25-02-2023', 'dd-mm-yyyy'), null, 281, null, 364, 138);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (358, to_date('10-08-2020', 'dd-mm-yyyy'), null, 152, null, 502, 239);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (359, to_date('15-12-2022', 'dd-mm-yyyy'), null, 229, null, 288, 343);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (360, to_date('04-11-2024', 'dd-mm-yyyy'), null, 229, null, 369, 280);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (361, to_date('10-10-2025', 'dd-mm-yyyy'), null, 135, null, 281, 211);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (362, to_date('21-12-2025', 'dd-mm-yyyy'), null, 452, null, 352, 248);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (363, to_date('05-07-2021', 'dd-mm-yyyy'), null, 302, null, 569, 438);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (364, to_date('13-09-2028', 'dd-mm-yyyy'), null, 371, null, 437, 27);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (365, to_date('12-01-2022', 'dd-mm-yyyy'), null, 158, null, 426, 70);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (366, to_date('11-03-2023', 'dd-mm-yyyy'), null, 470, null, 436, 310);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (367, to_date('16-11-2025', 'dd-mm-yyyy'), null, 219, null, 574, 34);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (368, to_date('28-12-2028', 'dd-mm-yyyy'), null, 144, null, 531, 60);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (369, to_date('12-03-2023', 'dd-mm-yyyy'), null, 418, null, 237, 297);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (370, to_date('07-11-2025', 'dd-mm-yyyy'), null, 106, null, 562, 226);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (371, to_date('19-10-2026', 'dd-mm-yyyy'), null, 210, null, 380, 264);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (372, to_date('25-12-2022', 'dd-mm-yyyy'), null, 355, null, 277, 434);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (373, to_date('02-05-2021', 'dd-mm-yyyy'), null, 492, null, 410, 179);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (374, to_date('04-11-2020', 'dd-mm-yyyy'), null, 549, null, 238, 159);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (375, to_date('12-07-2028', 'dd-mm-yyyy'), null, 257, null, 475, 278);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (376, to_date('15-10-2026', 'dd-mm-yyyy'), null, 476, null, 539, 50);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (377, to_date('26-12-2022', 'dd-mm-yyyy'), null, 326, null, 553, 444);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (378, to_date('22-09-2022', 'dd-mm-yyyy'), null, 193, null, 306, 421);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (379, to_date('22-04-2022', 'dd-mm-yyyy'), null, 175, null, 573, 411);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (380, to_date('02-05-2021', 'dd-mm-yyyy'), null, 443, null, 543, 88);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (381, to_date('18-04-2024', 'dd-mm-yyyy'), null, 268, null, 307, 239);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (382, to_date('23-02-2024', 'dd-mm-yyyy'), null, 179, null, 303, 119);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (383, to_date('11-03-2024', 'dd-mm-yyyy'), null, 303, null, 289, 60);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (384, to_date('16-02-2027', 'dd-mm-yyyy'), null, 330, null, 464, 365);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (385, to_date('07-02-2021', 'dd-mm-yyyy'), null, 111, null, 253, 137);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (386, to_date('24-05-2027', 'dd-mm-yyyy'), null, 546, null, 435, 236);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (387, to_date('18-07-2024', 'dd-mm-yyyy'), null, 464, null, 469, 81);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (388, to_date('08-06-2026', 'dd-mm-yyyy'), null, 238, null, 231, 44);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (389, to_date('25-09-2023', 'dd-mm-yyyy'), null, 311, null, 246, 72);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (391, to_date('14-05-2022', 'dd-mm-yyyy'), null, 383, null, 424, 261);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (393, to_date('25-07-2021', 'dd-mm-yyyy'), null, 492, null, 488, 165);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (394, to_date('04-06-2025', 'dd-mm-yyyy'), null, 463, null, 506, 381);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (395, to_date('07-04-2023', 'dd-mm-yyyy'), null, 358, null, 489, 70);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (396, to_date('19-06-2023', 'dd-mm-yyyy'), null, 418, null, 239, 149);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (397, to_date('17-07-2024', 'dd-mm-yyyy'), null, 411, null, 400, 322);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (398, to_date('07-08-2020', 'dd-mm-yyyy'), null, 265, null, 428, 95);
insert into EVENTS (eventid, eventdate, eventconfirmationdate, customerid, venueid, producerid, singerid)
values (399, to_date('25-11-2025', 'dd-mm-yyyy'), null, 200, null, 554, 250);
commit;
prompt 782 records loaded
prompt Loading GUESTS...
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3000, 'Acquaintances', 'Goran', 'Giraldo', to_date('03-07-2021', 'dd-mm-yyyy'), to_date('30-07-2021', 'dd-mm-yyyy'), 'Cancelled', 2265);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3001, 'Friends', 'Chet', 'Tah', to_date('20-05-2021', 'dd-mm-yyyy'), to_date('25-06-2021', 'dd-mm-yyyy'), 'Declined', 2104);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3002, 'Close Friends', 'Gene', 'Ramirez', to_date('24-09-2021', 'dd-mm-yyyy'), to_date('31-01-2021', 'dd-mm-yyyy'), 'Waitlisted', 2160);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3003, 'Acquaintances', 'Murray', 'Shawn', to_date('15-08-2021', 'dd-mm-yyyy'), to_date('21-08-2021', 'dd-mm-yyyy'), 'Declined', 2322);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3004, 'Work Colleagues', 'Oro', 'Polley', to_date('09-01-2021', 'dd-mm-yyyy'), to_date('03-06-2021', 'dd-mm-yyyy'), 'Waitlisted', 2089);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3005, 'Acquaintances', 'Roberta', 'Geldof', to_date('17-04-2021', 'dd-mm-yyyy'), to_date('17-11-2021', 'dd-mm-yyyy'), 'Waitlisted', 2012);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3006, 'Work Colleagues', 'Dwight', 'Tilly', to_date('10-11-2021', 'dd-mm-yyyy'), to_date('31-10-2021', 'dd-mm-yyyy'), 'Waitlisted', 2264);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3007, 'External Invitees', 'Stevie', 'Getty', to_date('27-10-2021', 'dd-mm-yyyy'), to_date('04-10-2021', 'dd-mm-yyyy'), 'Declined', 2230);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3008, 'Neighbors', 'Rick', 'Forster', to_date('11-08-2021', 'dd-mm-yyyy'), to_date('17-02-2021', 'dd-mm-yyyy'), '''Plus One''.', 2325);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3009, 'Work Colleagues', 'Joshua', 'Sandler', to_date('26-12-2021', 'dd-mm-yyyy'), to_date('30-10-2021', 'dd-mm-yyyy'), 'Waitlisted', 2039);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3010, 'Close Friends', 'Dwight', 'Dafoe', to_date('25-08-2021', 'dd-mm-yyyy'), to_date('06-08-2021', 'dd-mm-yyyy'), '''Plus One''.', 2205);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3011, 'Neighbors', 'Andie', 'Cassidy', to_date('28-10-2021', 'dd-mm-yyyy'), to_date('31-07-2021', 'dd-mm-yyyy'), 'Cancelled', 2290);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3012, 'Acquaintances', 'Fisher', 'Mann', to_date('17-02-2021', 'dd-mm-yyyy'), to_date('01-12-2021', 'dd-mm-yyyy'), 'Confirmed', 2314);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3013, 'Close Friends', 'Liv', 'Ponce', to_date('29-05-2021', 'dd-mm-yyyy'), to_date('20-05-2021', 'dd-mm-yyyy'), 'Declined', 2192);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3014, 'Acquaintances', 'Alessandro', 'Kadison', to_date('24-10-2021', 'dd-mm-yyyy'), to_date('14-02-2021', 'dd-mm-yyyy'), 'Declined', 2104);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3015, 'Acquaintances', 'Jean-Claude', 'Depp', to_date('30-01-2021', 'dd-mm-yyyy'), to_date('01-06-2021', 'dd-mm-yyyy'), 'Declined', 2288);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3016, 'Neighbors', 'Lydia', 'Matthau', to_date('04-04-2021', 'dd-mm-yyyy'), to_date('12-07-2021', 'dd-mm-yyyy'), 'Declined', 2255);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3017, 'External Invitees', 'Scarlett', 'Cotton', to_date('07-11-2021', 'dd-mm-yyyy'), to_date('10-08-2021', 'dd-mm-yyyy'), '''Plus One''.', 2233);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3018, 'Close Friends', 'Annette', 'McDiarmid', to_date('20-09-2021', 'dd-mm-yyyy'), to_date('31-08-2021', 'dd-mm-yyyy'), 'No Response', 2039);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3019, 'Close Friends', 'Pierce', 'Ferrell', to_date('20-07-2021', 'dd-mm-yyyy'), to_date('01-08-2021', 'dd-mm-yyyy'), 'Cancelled', 2165);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3020, 'Friends', 'Scarlett', 'Mirren', to_date('04-04-2021', 'dd-mm-yyyy'), to_date('24-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2303);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3021, 'Acquaintances', 'Harvey', 'Walken', to_date('22-02-2021', 'dd-mm-yyyy'), to_date('03-08-2021', 'dd-mm-yyyy'), 'No Response', 2082);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3022, 'Immediate Family', 'Natalie', 'Owen', to_date('18-12-2021', 'dd-mm-yyyy'), to_date('31-12-2021', 'dd-mm-yyyy'), 'Declined', 2041);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3023, 'External Invitees', 'Wes', 'Morrison', to_date('07-10-2021', 'dd-mm-yyyy'), to_date('05-06-2021', 'dd-mm-yyyy'), 'Cancelled', 2017);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3024, 'Close Friends', 'Billy', 'Bragg', to_date('26-11-2021', 'dd-mm-yyyy'), to_date('19-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2169);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3025, 'Friends', 'Lauren', 'Griggs', to_date('15-04-2021', 'dd-mm-yyyy'), to_date('01-06-2021', 'dd-mm-yyyy'), 'Declined', 2214);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3026, 'External Invitees', 'Busta', 'Wainwright', to_date('25-07-2021', 'dd-mm-yyyy'), to_date('01-06-2021', 'dd-mm-yyyy'), 'No Response', 2100);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3027, 'Acquaintances', 'Jean-Claude', 'Colin Young', to_date('13-09-2021', 'dd-mm-yyyy'), to_date('20-04-2021', 'dd-mm-yyyy'), 'Waitlisted', 2099);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3028, 'Neighbors', 'Buffy', 'Liu', to_date('28-10-2021', 'dd-mm-yyyy'), to_date('16-07-2021', 'dd-mm-yyyy'), 'No Response', 2321);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3029, 'Close Friends', 'Boz', 'Kahn', to_date('03-07-2021', 'dd-mm-yyyy'), to_date('17-03-2021', 'dd-mm-yyyy'), 'No Response', 2060);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3030, 'Close Friends', 'Gaby', 'Rhymes', to_date('28-06-2021', 'dd-mm-yyyy'), to_date('18-09-2021', 'dd-mm-yyyy'), 'Cancelled', 2163);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3031, 'Work Colleagues', 'Paula', 'Leguizamo', to_date('20-07-2021', 'dd-mm-yyyy'), to_date('29-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2019);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3032, 'Extended Family', 'Madeline', 'Moody', to_date('03-07-2021', 'dd-mm-yyyy'), to_date('05-04-2021', 'dd-mm-yyyy'), 'No Response', 2382);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3033, 'External Invitees', 'Barbara', 'Swank', to_date('12-12-2021', 'dd-mm-yyyy'), to_date('03-02-2021', 'dd-mm-yyyy'), 'No Response', 2009);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3034, 'Extended Family', 'Cary', 'Mohr', to_date('10-08-2021', 'dd-mm-yyyy'), to_date('21-03-2021', 'dd-mm-yyyy'), 'No Response', 2130);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3035, 'Immediate Family', 'Stephanie', 'Stone', to_date('20-05-2021', 'dd-mm-yyyy'), to_date('21-08-2021', 'dd-mm-yyyy'), 'Waitlisted', 2345);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3036, 'Extended Family', 'Armand', 'Craddock', to_date('29-04-2021', 'dd-mm-yyyy'), to_date('16-04-2021', 'dd-mm-yyyy'), '''Plus One''.', 2333);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3037, 'Close Friends', 'Scott', 'Venora', to_date('08-07-2021', 'dd-mm-yyyy'), to_date('20-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2204);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3038, 'Friends', 'Curtis', 'Collie', to_date('29-11-2021', 'dd-mm-yyyy'), to_date('07-10-2021', 'dd-mm-yyyy'), 'No Response', 2261);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3039, 'Close Friends', 'Chet', 'Carlton', to_date('13-02-2021', 'dd-mm-yyyy'), to_date('21-11-2021', 'dd-mm-yyyy'), '''Plus One''.', 2197);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3040, 'Close Friends', 'Randy', 'Crudup', to_date('17-08-2021', 'dd-mm-yyyy'), to_date('22-06-2021', 'dd-mm-yyyy'), 'Declined', 2110);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3041, 'Extended Family', 'Claude', 'MacDowell', to_date('20-12-2021', 'dd-mm-yyyy'), to_date('25-09-2021', 'dd-mm-yyyy'), 'Confirmed', 2146);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3042, 'External Invitees', 'Alana', 'Cronin', to_date('19-03-2021', 'dd-mm-yyyy'), to_date('14-09-2021', 'dd-mm-yyyy'), '''Plus One''.', 2370);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3043, 'Neighbors', 'Colin', 'Romijn-Stamos', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('01-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2055);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3044, 'Work Colleagues', 'Taryn', 'Rhys-Davies', to_date('14-07-2021', 'dd-mm-yyyy'), to_date('01-03-2021', 'dd-mm-yyyy'), 'Cancelled', 2005);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3045, 'Immediate Family', 'Arturo', 'Field', to_date('12-08-2021', 'dd-mm-yyyy'), to_date('28-10-2021', 'dd-mm-yyyy'), 'No Response', 2291);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3046, 'Close Friends', 'Simon', 'Moorer', to_date('28-05-2021', 'dd-mm-yyyy'), to_date('25-11-2021', 'dd-mm-yyyy'), 'No Response', 2226);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3047, 'Close Friends', 'Thora', 'White', to_date('12-09-2021', 'dd-mm-yyyy'), to_date('26-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2154);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3048, 'Acquaintances', 'Jean-Luc', 'Broza', to_date('26-11-2021', 'dd-mm-yyyy'), to_date('30-03-2021', 'dd-mm-yyyy'), 'Waitlisted', 2267);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3049, 'Work Colleagues', 'Sonny', 'Hidalgo', to_date('12-09-2021', 'dd-mm-yyyy'), to_date('05-09-2021', 'dd-mm-yyyy'), 'No Response', 2053);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3050, 'External Invitees', 'Thelma', 'Leoni', to_date('04-02-2021', 'dd-mm-yyyy'), to_date('28-09-2021', 'dd-mm-yyyy'), 'Waitlisted', 2358);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3051, 'Immediate Family', 'Miguel', 'Kristofferson', to_date('05-09-2021', 'dd-mm-yyyy'), to_date('16-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2083);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3052, 'Friends', 'Chely', 'Moody', to_date('01-03-2021', 'dd-mm-yyyy'), to_date('06-02-2021', 'dd-mm-yyyy'), 'Waitlisted', 2302);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3053, 'Friends', 'Geggy', 'Rain', to_date('02-09-2021', 'dd-mm-yyyy'), to_date('03-07-2021', 'dd-mm-yyyy'), 'Declined', 2200);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3054, 'Neighbors', 'Carolyn', 'Blige', to_date('07-09-2021', 'dd-mm-yyyy'), to_date('14-02-2021', 'dd-mm-yyyy'), 'Declined', 2048);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3055, 'Friends', 'Winona', 'Rockwell', to_date('02-09-2021', 'dd-mm-yyyy'), to_date('22-05-2021', 'dd-mm-yyyy'), 'Declined', 2391);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3056, 'Extended Family', 'Neneh', 'Skerritt', to_date('14-11-2021', 'dd-mm-yyyy'), to_date('22-08-2021', 'dd-mm-yyyy'), '''Plus One''.', 2269);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3057, 'Immediate Family', 'Jeremy', 'Rodgers', to_date('28-02-2021', 'dd-mm-yyyy'), to_date('10-07-2021', 'dd-mm-yyyy'), '''Plus One''.', 2057);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3058, 'Work Colleagues', 'Emilio', 'Northam', to_date('20-10-2021', 'dd-mm-yyyy'), to_date('16-06-2021', 'dd-mm-yyyy'), 'Cancelled', 2136);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3059, 'External Invitees', 'Sinead', 'Sutherland', to_date('03-05-2021', 'dd-mm-yyyy'), to_date('03-03-2021', 'dd-mm-yyyy'), '''Plus One''.', 2181);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3060, 'Friends', 'Kimberly', 'Hurt', to_date('01-02-2021', 'dd-mm-yyyy'), to_date('14-04-2021', 'dd-mm-yyyy'), 'Waitlisted', 2288);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3061, 'Extended Family', 'LeVar', 'O''Neill', to_date('27-10-2021', 'dd-mm-yyyy'), to_date('21-12-2021', 'dd-mm-yyyy'), '''Plus One''.', 2307);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3062, 'Friends', 'Aimee', 'Ramirez', to_date('21-02-2021', 'dd-mm-yyyy'), to_date('04-09-2021', 'dd-mm-yyyy'), 'No Response', 2217);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3063, 'Work Colleagues', 'Leslie', 'Logue', to_date('27-07-2021', 'dd-mm-yyyy'), to_date('18-11-2021', 'dd-mm-yyyy'), 'Declined', 2313);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3064, 'Immediate Family', 'Terry', 'Cromwell', to_date('10-03-2021', 'dd-mm-yyyy'), to_date('20-12-2021', 'dd-mm-yyyy'), '''Plus One''.', 2032);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3065, 'Neighbors', 'Harry', 'Cozier', to_date('29-11-2021', 'dd-mm-yyyy'), to_date('08-02-2021', 'dd-mm-yyyy'), 'Waitlisted', 2187);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3066, 'Friends', 'Pierce', 'Warren', to_date('17-02-2021', 'dd-mm-yyyy'), to_date('23-03-2021', 'dd-mm-yyyy'), 'Cancelled', 2243);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3067, 'Neighbors', 'Miguel', 'Blades', to_date('01-03-2021', 'dd-mm-yyyy'), to_date('14-01-2021', 'dd-mm-yyyy'), '''Plus One''.', 2203);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3068, 'Extended Family', 'Yolanda', 'Bracco', to_date('02-06-2021', 'dd-mm-yyyy'), to_date('24-02-2021', 'dd-mm-yyyy'), 'Cancelled', 2330);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3069, 'Acquaintances', 'Stevie', 'Rodgers', to_date('26-11-2021', 'dd-mm-yyyy'), to_date('13-03-2021', 'dd-mm-yyyy'), '''Plus One''.', 2292);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3070, 'Extended Family', 'Robbie', 'Berry', to_date('13-10-2021', 'dd-mm-yyyy'), to_date('23-01-2021', 'dd-mm-yyyy'), 'No Response', 2122);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3071, 'Immediate Family', 'Betty', 'Kutcher', to_date('21-02-2021', 'dd-mm-yyyy'), to_date('01-03-2021', 'dd-mm-yyyy'), 'Cancelled', 2222);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3072, 'Close Friends', 'Nick', 'Costello', to_date('17-12-2021', 'dd-mm-yyyy'), to_date('18-10-2021', 'dd-mm-yyyy'), 'Waitlisted', 2370);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3073, 'Immediate Family', 'Jena', 'Kenoly', to_date('25-07-2021', 'dd-mm-yyyy'), to_date('11-07-2021', 'dd-mm-yyyy'), 'Declined', 2170);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3074, 'External Invitees', 'Ed', 'Worrell', to_date('21-02-2021', 'dd-mm-yyyy'), to_date('31-08-2021', 'dd-mm-yyyy'), 'Declined', 2120);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3075, 'Work Colleagues', 'Bill', 'Hornsby', to_date('28-07-2021', 'dd-mm-yyyy'), to_date('20-10-2021', 'dd-mm-yyyy'), 'Declined', 2099);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3076, 'Immediate Family', 'Rita', 'Pullman', to_date('16-01-2021', 'dd-mm-yyyy'), to_date('22-05-2021', 'dd-mm-yyyy'), 'Waitlisted', 2093);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3077, 'Extended Family', 'Nathan', 'Witt', to_date('14-12-2021', 'dd-mm-yyyy'), to_date('24-05-2021', 'dd-mm-yyyy'), '''Plus One''.', 2330);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3078, 'External Invitees', 'Avril', 'Ronstadt', to_date('04-04-2021', 'dd-mm-yyyy'), to_date('10-01-2021', 'dd-mm-yyyy'), '''Plus One''.', 2056);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3079, 'Immediate Family', 'Diane', 'Ceasar', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('06-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2120);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3080, 'Immediate Family', 'Sydney', 'Botti', to_date('08-11-2021', 'dd-mm-yyyy'), to_date('05-12-2021', 'dd-mm-yyyy'), 'Waitlisted', 2198);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3081, 'External Invitees', 'Merillee', 'Ojeda', to_date('16-07-2021', 'dd-mm-yyyy'), to_date('13-02-2021', 'dd-mm-yyyy'), 'Waitlisted', 2234);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3082, 'Close Friends', 'Vincent', 'Michael', to_date('24-01-2021', 'dd-mm-yyyy'), to_date('28-08-2021', 'dd-mm-yyyy'), 'No Response', 2107);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3083, 'External Invitees', 'Jon', 'Macy', to_date('12-09-2021', 'dd-mm-yyyy'), to_date('13-11-2021', 'dd-mm-yyyy'), 'Waitlisted', 2324);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3084, 'External Invitees', 'James', 'Richardson', to_date('02-09-2021', 'dd-mm-yyyy'), to_date('07-12-2021', 'dd-mm-yyyy'), '''Plus One''.', 2141);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3085, 'Close Friends', 'Marianne', 'Kline', to_date('06-02-2021', 'dd-mm-yyyy'), to_date('13-01-2021', 'dd-mm-yyyy'), 'No Response', 2301);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3086, 'Neighbors', 'Linda', 'Shatner', to_date('12-09-2021', 'dd-mm-yyyy'), to_date('29-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2007);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3087, 'Work Colleagues', 'Aaron', 'Daniels', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('17-06-2021', 'dd-mm-yyyy'), 'No Response', 2110);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3088, 'Friends', 'Marie', 'Hobson', to_date('07-10-2021', 'dd-mm-yyyy'), to_date('07-06-2021', 'dd-mm-yyyy'), 'Waitlisted', 2132);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3089, 'Acquaintances', 'Donna', 'Birch', to_date('07-03-2021', 'dd-mm-yyyy'), to_date('26-06-2021', 'dd-mm-yyyy'), '''Plus One''.', 2306);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3090, 'Extended Family', 'Ethan', 'Tanon', to_date('08-11-2021', 'dd-mm-yyyy'), to_date('28-04-2021', 'dd-mm-yyyy'), 'Cancelled', 2244);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3091, 'Friends', 'Horace', 'Gallagher', to_date('07-04-2021', 'dd-mm-yyyy'), to_date('21-11-2021', 'dd-mm-yyyy'), 'Cancelled', 2230);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3092, 'Neighbors', 'Lionel', 'Sheen', to_date('04-01-2021', 'dd-mm-yyyy'), to_date('21-12-2021', 'dd-mm-yyyy'), 'Declined', 2340);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3093, 'Friends', 'Kylie', 'Payne', to_date('31-03-2021', 'dd-mm-yyyy'), to_date('31-10-2021', 'dd-mm-yyyy'), 'Waitlisted', 2182);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3094, 'External Invitees', 'Harris', 'Horizon', to_date('20-07-2021', 'dd-mm-yyyy'), to_date('13-12-2021', 'dd-mm-yyyy'), 'No Response', 2065);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3095, 'Extended Family', 'Laurie', 'Polley', to_date('05-06-2021', 'dd-mm-yyyy'), to_date('13-10-2021', 'dd-mm-yyyy'), 'Cancelled', 2395);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3096, 'Close Friends', 'Danny', 'Wainwright', to_date('20-05-2021', 'dd-mm-yyyy'), to_date('12-08-2021', 'dd-mm-yyyy'), '''Plus One''.', 2088);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3097, 'Work Colleagues', 'Rascal', 'Dillon', to_date('30-07-2021', 'dd-mm-yyyy'), to_date('17-06-2021', 'dd-mm-yyyy'), '''Plus One''.', 2015);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3098, 'Immediate Family', 'Suzy', 'Collie', to_date('22-06-2021', 'dd-mm-yyyy'), to_date('13-01-2021', 'dd-mm-yyyy'), '''Plus One''.', 2272);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3099, 'Neighbors', 'Mykelti', 'Squier', to_date('22-06-2021', 'dd-mm-yyyy'), to_date('10-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2070);
commit;
prompt 100 records committed...
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3100, 'Neighbors', 'Donald', 'Shepard', to_date('19-12-2021', 'dd-mm-yyyy'), to_date('09-12-2021', 'dd-mm-yyyy'), 'Waitlisted', 2255);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3101, 'External Invitees', 'Luke', 'Faithfull', to_date('17-02-2021', 'dd-mm-yyyy'), to_date('04-10-2021', 'dd-mm-yyyy'), 'Waitlisted', 2050);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3102, 'External Invitees', 'Quentin', 'Atlas', to_date('02-09-2021', 'dd-mm-yyyy'), to_date('27-08-2021', 'dd-mm-yyyy'), 'Declined', 2022);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3103, 'Acquaintances', 'Gil', 'Strathairn', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('07-07-2021', 'dd-mm-yyyy'), 'Cancelled', 2078);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3104, 'Close Friends', 'Elle', 'Phifer', to_date('26-11-2021', 'dd-mm-yyyy'), to_date('15-01-2021', 'dd-mm-yyyy'), 'Cancelled', 2079);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3105, 'Close Friends', 'Viggo', 'Aaron', to_date('12-11-2021', 'dd-mm-yyyy'), to_date('21-02-2021', 'dd-mm-yyyy'), 'Cancelled', 2288);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3106, 'Acquaintances', 'Nicholas', 'Azaria', to_date('12-05-2021', 'dd-mm-yyyy'), to_date('02-06-2021', 'dd-mm-yyyy'), 'No Response', 2031);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3107, 'Acquaintances', 'Ice', 'Lewis', to_date('25-08-2021', 'dd-mm-yyyy'), to_date('04-09-2021', 'dd-mm-yyyy'), 'Waitlisted', 2197);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3108, 'Neighbors', 'Molly', 'Torino', to_date('12-12-2021', 'dd-mm-yyyy'), to_date('10-07-2021', 'dd-mm-yyyy'), 'Waitlisted', 2352);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3109, 'External Invitees', 'Clea', 'Cummings', to_date('25-05-2021', 'dd-mm-yyyy'), to_date('12-01-2021', 'dd-mm-yyyy'), 'Waitlisted', 2084);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3110, 'External Invitees', 'Elle', 'Gordon', to_date('18-11-2021', 'dd-mm-yyyy'), to_date('09-06-2021', 'dd-mm-yyyy'), 'Waitlisted', 2168);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3111, 'Immediate Family', 'Benicio', 'Coward', to_date('25-07-2021', 'dd-mm-yyyy'), to_date('08-12-2021', 'dd-mm-yyyy'), '''Plus One''.', 2361);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3112, 'Immediate Family', 'Morris', 'Weaving', to_date('03-07-2021', 'dd-mm-yyyy'), to_date('08-07-2021', 'dd-mm-yyyy'), 'Declined', 2223);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3113, 'Neighbors', 'Salma', 'Harmon', to_date('22-09-2021', 'dd-mm-yyyy'), to_date('14-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2152);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3114, 'Immediate Family', 'Sinead', 'Fonda', to_date('20-05-2021', 'dd-mm-yyyy'), to_date('07-05-2021', 'dd-mm-yyyy'), '''Plus One''.', 2260);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3115, 'Extended Family', 'Spike', 'Underwood', to_date('11-03-2021', 'dd-mm-yyyy'), to_date('31-12-2021', 'dd-mm-yyyy'), 'No Response', 2263);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3116, 'Extended Family', 'Gene', 'Kenoly', to_date('06-02-2021', 'dd-mm-yyyy'), to_date('30-08-2021', 'dd-mm-yyyy'), 'No Response', 2396);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3117, 'Work Colleagues', 'Temuera', 'Moreno', to_date('21-04-2021', 'dd-mm-yyyy'), to_date('11-02-2021', 'dd-mm-yyyy'), 'Confirmed', 2161);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3118, 'Extended Family', 'Nik', 'Gray', to_date('22-10-2021', 'dd-mm-yyyy'), to_date('18-04-2021', 'dd-mm-yyyy'), 'Cancelled', 2092);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3119, 'External Invitees', 'Natascha', 'Heche', to_date('05-11-2021', 'dd-mm-yyyy'), to_date('29-07-2021', 'dd-mm-yyyy'), 'Waitlisted', 2148);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3120, 'Immediate Family', 'Kid', 'Delta', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('10-02-2021', 'dd-mm-yyyy'), 'No Response', 2333);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3121, 'External Invitees', 'Millie', 'Peet', to_date('07-01-2021', 'dd-mm-yyyy'), to_date('28-03-2021', 'dd-mm-yyyy'), '''Plus One''.', 2336);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3122, 'Friends', 'Roy', 'Broadbent', to_date('27-10-2021', 'dd-mm-yyyy'), to_date('11-12-2021', 'dd-mm-yyyy'), 'Confirmed', 2201);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3123, 'Acquaintances', 'Natalie', 'Venora', to_date('18-12-2021', 'dd-mm-yyyy'), to_date('26-05-2021', 'dd-mm-yyyy'), '''Plus One''.', 2021);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3124, 'External Invitees', 'Ty', 'Christie', to_date('27-12-2021', 'dd-mm-yyyy'), to_date('16-07-2021', 'dd-mm-yyyy'), 'Declined', 2251);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3125, 'Work Colleagues', 'Neneh', 'Whitwam', to_date('29-06-2021', 'dd-mm-yyyy'), to_date('24-09-2021', 'dd-mm-yyyy'), 'Waitlisted', 2258);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3126, 'External Invitees', 'Brooke', 'Doucette', to_date('15-06-2021', 'dd-mm-yyyy'), to_date('24-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2284);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3127, 'External Invitees', 'Horace', 'Kweller', to_date('08-03-2021', 'dd-mm-yyyy'), to_date('20-03-2021', 'dd-mm-yyyy'), 'Cancelled', 2040);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3128, 'Friends', 'Cheech', 'Field', to_date('07-07-2021', 'dd-mm-yyyy'), to_date('17-02-2021', 'dd-mm-yyyy'), 'Declined', 2325);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3129, 'Close Friends', 'Treat', 'Kristofferson', to_date('31-05-2021', 'dd-mm-yyyy'), to_date('02-02-2021', 'dd-mm-yyyy'), '''Plus One''.', 2067);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3130, 'Immediate Family', 'Derrick', 'Polley', to_date('05-11-2021', 'dd-mm-yyyy'), to_date('03-08-2021', 'dd-mm-yyyy'), 'Cancelled', 2393);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3131, 'Friends', 'Michael', 'Oszajca', to_date('02-09-2021', 'dd-mm-yyyy'), to_date('13-10-2021', 'dd-mm-yyyy'), 'Waitlisted', 2123);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3132, 'Immediate Family', 'Karon', 'Starr', to_date('07-11-2021', 'dd-mm-yyyy'), to_date('05-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2284);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3133, 'Work Colleagues', 'Miko', 'Tyler', to_date('19-02-2021', 'dd-mm-yyyy'), to_date('04-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2055);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3134, 'Immediate Family', 'Phoebe', 'Lane', to_date('27-10-2021', 'dd-mm-yyyy'), to_date('27-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2136);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3135, 'Friends', 'Maury', 'Polley', to_date('06-05-2021', 'dd-mm-yyyy'), to_date('18-11-2021', 'dd-mm-yyyy'), 'Cancelled', 2341);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3136, 'Work Colleagues', 'Cole', 'Cornell', to_date('30-11-2021', 'dd-mm-yyyy'), to_date('20-02-2021', 'dd-mm-yyyy'), 'No Response', 2214);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3137, 'External Invitees', 'Jeffrey', 'Maxwell', to_date('05-04-2021', 'dd-mm-yyyy'), to_date('09-07-2021', 'dd-mm-yyyy'), 'Waitlisted', 2273);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3138, 'External Invitees', 'Albert', 'Rhymes', to_date('17-01-2021', 'dd-mm-yyyy'), to_date('24-11-2021', 'dd-mm-yyyy'), 'No Response', 2277);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3139, 'Immediate Family', 'Sal', 'LaSalle', to_date('05-07-2021', 'dd-mm-yyyy'), to_date('22-04-2021', 'dd-mm-yyyy'), 'No Response', 2123);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3140, 'Extended Family', 'Debbie', 'Rawls', to_date('28-05-2021', 'dd-mm-yyyy'), to_date('05-07-2021', 'dd-mm-yyyy'), 'No Response', 2159);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3141, 'Neighbors', 'Colm', 'Heslov', to_date('26-02-2021', 'dd-mm-yyyy'), to_date('02-09-2021', 'dd-mm-yyyy'), 'Cancelled', 2127);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3142, 'Work Colleagues', 'Curtis', 'Santa Rosa', to_date('21-12-2021', 'dd-mm-yyyy'), to_date('25-01-2021', 'dd-mm-yyyy'), 'Cancelled', 2337);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3143, 'Extended Family', 'Bridgette', 'Magnuson', to_date('14-12-2021', 'dd-mm-yyyy'), to_date('10-11-2021', 'dd-mm-yyyy'), 'Declined', 2254);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3144, 'Acquaintances', 'Joey', 'Church', to_date('17-09-2021', 'dd-mm-yyyy'), to_date('12-12-2021', 'dd-mm-yyyy'), 'Declined', 2116);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3145, 'External Invitees', 'Chloe', 'Affleck', to_date('30-04-2021', 'dd-mm-yyyy'), to_date('12-11-2021', 'dd-mm-yyyy'), '''Plus One''.', 2381);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3146, 'Acquaintances', 'Garth', 'Bello', to_date('30-07-2021', 'dd-mm-yyyy'), to_date('01-10-2021', 'dd-mm-yyyy'), 'Waitlisted', 2193);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3147, 'Neighbors', 'Lizzy', 'Balaban', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('16-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2074);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3148, 'Close Friends', 'Lorraine', 'Coverdale', to_date('22-06-2021', 'dd-mm-yyyy'), to_date('23-03-2021', 'dd-mm-yyyy'), '''Plus One''.', 2041);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3149, 'Immediate Family', 'Terri', 'McPherson', to_date('28-09-2021', 'dd-mm-yyyy'), to_date('07-09-2021', 'dd-mm-yyyy'), '''Plus One''.', 2354);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3150, 'Extended Family', 'Denise', 'Caine', to_date('25-08-2021', 'dd-mm-yyyy'), to_date('22-03-2021', 'dd-mm-yyyy'), 'Waitlisted', 2078);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3151, 'Work Colleagues', 'Phoebe', 'Reubens', to_date('19-01-2021', 'dd-mm-yyyy'), to_date('05-09-2021', 'dd-mm-yyyy'), 'Cancelled', 2280);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3152, 'Friends', 'Bret', 'Rankin', to_date('28-05-2021', 'dd-mm-yyyy'), to_date('14-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2245);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3153, 'Acquaintances', 'Halle', 'Boone', to_date('09-10-2021', 'dd-mm-yyyy'), to_date('22-09-2021', 'dd-mm-yyyy'), 'Waitlisted', 2320);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3154, 'Close Friends', 'Lorraine', 'Phifer', to_date('17-08-2021', 'dd-mm-yyyy'), to_date('08-04-2021', 'dd-mm-yyyy'), 'Cancelled', 2181);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3155, 'Extended Family', 'Jeremy', 'Chaykin', to_date('24-10-2021', 'dd-mm-yyyy'), to_date('20-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2127);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3156, 'Close Friends', 'Gena', 'Sorvino', to_date('07-09-2021', 'dd-mm-yyyy'), to_date('04-12-2021', 'dd-mm-yyyy'), 'Waitlisted', 2196);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3157, 'External Invitees', 'Pat', 'Waits', to_date('15-08-2021', 'dd-mm-yyyy'), to_date('07-08-2021', 'dd-mm-yyyy'), 'Waitlisted', 2312);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3158, 'Acquaintances', 'Susan', 'Orlando', to_date('28-08-2021', 'dd-mm-yyyy'), to_date('13-03-2021', 'dd-mm-yyyy'), 'Cancelled', 2249);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3159, 'Friends', 'Rene', 'Fishburne', to_date('30-01-2021', 'dd-mm-yyyy'), to_date('11-02-2021', 'dd-mm-yyyy'), 'No Response', 2224);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3160, 'External Invitees', 'Jessica', 'Pigott-Smith', to_date('20-05-2021', 'dd-mm-yyyy'), to_date('17-06-2021', 'dd-mm-yyyy'), 'No Response', 2118);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3161, 'Immediate Family', 'Lisa', 'Goodman', to_date('02-05-2021', 'dd-mm-yyyy'), to_date('08-12-2021', 'dd-mm-yyyy'), '''Plus One''.', 2118);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3162, 'Neighbors', 'Jonatha', 'Arkin', to_date('23-08-2021', 'dd-mm-yyyy'), to_date('28-10-2021', 'dd-mm-yyyy'), 'Declined', 2382);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3163, 'Neighbors', 'Donal', 'Ward', to_date('01-09-2021', 'dd-mm-yyyy'), to_date('02-01-2021', 'dd-mm-yyyy'), 'Declined', 2136);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3164, 'Neighbors', 'Jean-Claude', 'Moraz', to_date('01-09-2021', 'dd-mm-yyyy'), to_date('18-01-2021', 'dd-mm-yyyy'), 'No Response', 2190);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3165, 'Extended Family', 'Ray', 'Buffalo', to_date('26-06-2021', 'dd-mm-yyyy'), to_date('20-05-2021', 'dd-mm-yyyy'), 'No Response', 2080);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3166, 'Work Colleagues', 'Jose', 'Tippe', to_date('11-04-2021', 'dd-mm-yyyy'), to_date('28-06-2021', 'dd-mm-yyyy'), '''Plus One''.', 2239);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3167, 'Neighbors', 'Melanie', 'Jane', to_date('05-02-2021', 'dd-mm-yyyy'), to_date('15-03-2021', 'dd-mm-yyyy'), 'Cancelled', 2386);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3168, 'Neighbors', 'Brothers', 'Blige', to_date('16-12-2021', 'dd-mm-yyyy'), to_date('14-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2149);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3169, 'Immediate Family', 'Larry', 'Murphy', to_date('29-05-2021', 'dd-mm-yyyy'), to_date('06-08-2021', 'dd-mm-yyyy'), 'Declined', 2301);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3170, 'External Invitees', 'Steven', 'McPherson', to_date('03-07-2021', 'dd-mm-yyyy'), to_date('17-01-2021', 'dd-mm-yyyy'), 'Declined', 2235);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3171, 'External Invitees', 'Beverley', 'Scaggs', to_date('01-09-2021', 'dd-mm-yyyy'), to_date('19-08-2021', 'dd-mm-yyyy'), 'Cancelled', 2053);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3172, 'Work Colleagues', 'Candice', 'O''Donnell', to_date('28-09-2021', 'dd-mm-yyyy'), to_date('13-04-2021', 'dd-mm-yyyy'), 'Confirmed', 2087);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3173, 'Neighbors', 'Jann', 'Aniston', to_date('22-02-2021', 'dd-mm-yyyy'), to_date('03-04-2021', 'dd-mm-yyyy'), '''Plus One''.', 2235);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3174, 'Acquaintances', 'Kiefer', 'LuPone', to_date('05-02-2021', 'dd-mm-yyyy'), to_date('08-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2340);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3175, 'External Invitees', 'Alice', 'Oszajca', to_date('13-08-2021', 'dd-mm-yyyy'), to_date('22-03-2021', 'dd-mm-yyyy'), '''Plus One''.', 2372);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3176, 'Work Colleagues', 'Tori', 'Candy', to_date('12-05-2021', 'dd-mm-yyyy'), to_date('27-02-2021', 'dd-mm-yyyy'), 'Declined', 2053);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3177, 'Extended Family', 'Emilio', 'Wiedlin', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('17-01-2021', 'dd-mm-yyyy'), 'Waitlisted', 2297);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3178, 'Friends', 'Alan', 'Esposito', to_date('13-09-2021', 'dd-mm-yyyy'), to_date('21-10-2021', 'dd-mm-yyyy'), 'Waitlisted', 2081);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3179, 'Friends', 'Donald', 'Gates', to_date('06-05-2021', 'dd-mm-yyyy'), to_date('03-12-2021', 'dd-mm-yyyy'), 'Cancelled', 2332);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3180, 'Extended Family', 'Sheryl', 'Goldwyn', to_date('12-08-2021', 'dd-mm-yyyy'), to_date('23-07-2021', 'dd-mm-yyyy'), '''Plus One''.', 2052);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3181, 'Extended Family', 'Freddy', 'Speaks', to_date('07-11-2021', 'dd-mm-yyyy'), to_date('05-09-2021', 'dd-mm-yyyy'), 'Confirmed', 2255);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3182, 'External Invitees', 'Rosanne', 'Loveless', to_date('19-06-2021', 'dd-mm-yyyy'), to_date('16-04-2021', 'dd-mm-yyyy'), 'No Response', 2141);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3183, 'Work Colleagues', 'Sonny', 'Potter', to_date('05-07-2021', 'dd-mm-yyyy'), to_date('13-09-2021', 'dd-mm-yyyy'), 'No Response', 2282);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3184, 'Acquaintances', 'Anita', 'Hackman', to_date('30-04-2021', 'dd-mm-yyyy'), to_date('20-11-2021', 'dd-mm-yyyy'), 'Declined', 2045);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3185, 'Friends', 'Antonio', 'Osborne', to_date('20-07-2021', 'dd-mm-yyyy'), to_date('17-11-2021', 'dd-mm-yyyy'), 'No Response', 2035);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3186, 'Neighbors', 'Donald', 'Charles', to_date('28-05-2021', 'dd-mm-yyyy'), to_date('23-03-2021', 'dd-mm-yyyy'), '''Plus One''.', 2360);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3187, 'Work Colleagues', 'Giancarlo', 'Herrmann', to_date('30-04-2021', 'dd-mm-yyyy'), to_date('15-07-2021', 'dd-mm-yyyy'), 'No Response', 2325);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3188, 'Extended Family', 'Jackie', 'Gold', to_date('07-07-2021', 'dd-mm-yyyy'), to_date('25-01-2021', 'dd-mm-yyyy'), 'Waitlisted', 2351);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3189, 'External Invitees', 'Gerald', 'Beals', to_date('01-07-2021', 'dd-mm-yyyy'), to_date('18-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2118);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3190, 'Close Friends', 'Jane', 'Brown', to_date('30-06-2021', 'dd-mm-yyyy'), to_date('15-01-2021', 'dd-mm-yyyy'), 'Declined', 2133);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3191, 'External Invitees', 'Ike', 'McDonnell', to_date('14-09-2021', 'dd-mm-yyyy'), to_date('03-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2320);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3192, 'External Invitees', 'Rawlins', 'McGinley', to_date('27-10-2021', 'dd-mm-yyyy'), to_date('15-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2042);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3193, 'External Invitees', 'Grace', 'English', to_date('09-01-2021', 'dd-mm-yyyy'), to_date('07-12-2021', 'dd-mm-yyyy'), 'No Response', 2342);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3194, 'Neighbors', 'Embeth', 'Liu', to_date('08-05-2021', 'dd-mm-yyyy'), to_date('05-09-2021', 'dd-mm-yyyy'), 'Cancelled', 2012);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3195, 'Work Colleagues', 'Christopher', 'Carlisle', to_date('19-10-2021', 'dd-mm-yyyy'), to_date('16-05-2021', 'dd-mm-yyyy'), 'No Response', 2284);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3196, 'Close Friends', 'Pamela', 'MacNeil', to_date('25-07-2021', 'dd-mm-yyyy'), to_date('31-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2149);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3197, 'Friends', 'Mary', 'English', to_date('06-10-2021', 'dd-mm-yyyy'), to_date('26-04-2021', 'dd-mm-yyyy'), 'Waitlisted', 2302);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3198, 'External Invitees', 'Malcolm', 'Penn', to_date('15-07-2021', 'dd-mm-yyyy'), to_date('10-08-2021', 'dd-mm-yyyy'), 'Declined', 2106);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3199, 'Extended Family', 'Armand', 'Lee', to_date('02-09-2021', 'dd-mm-yyyy'), to_date('31-05-2021', 'dd-mm-yyyy'), 'No Response', 2388);
commit;
prompt 200 records committed...
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3200, 'Neighbors', 'Patrick', 'Schwarzenegger', to_date('26-04-2021', 'dd-mm-yyyy'), to_date('31-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2058);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3201, 'External Invitees', 'Vonda', 'Miles', to_date('22-10-2021', 'dd-mm-yyyy'), to_date('24-04-2021', 'dd-mm-yyyy'), 'Declined', 2146);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3202, 'Acquaintances', 'Alannah', 'Allan', to_date('16-01-2021', 'dd-mm-yyyy'), to_date('18-10-2021', 'dd-mm-yyyy'), 'No Response', 2078);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3203, 'Friends', 'Roberta', 'Stigers', to_date('22-11-2021', 'dd-mm-yyyy'), to_date('04-08-2021', 'dd-mm-yyyy'), 'Cancelled', 2162);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3204, 'External Invitees', 'Arturo', 'Brown', to_date('19-01-2021', 'dd-mm-yyyy'), to_date('11-10-2021', 'dd-mm-yyyy'), '''Plus One''.', 2311);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3205, 'External Invitees', 'Liev', 'Kinney', to_date('03-01-2021', 'dd-mm-yyyy'), to_date('18-09-2021', 'dd-mm-yyyy'), 'No Response', 2183);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3206, 'Immediate Family', 'Tilda', 'Askew', to_date('20-07-2021', 'dd-mm-yyyy'), to_date('27-09-2021', 'dd-mm-yyyy'), 'Declined', 2350);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3207, 'Extended Family', 'Kevin', 'Winger', to_date('03-01-2021', 'dd-mm-yyyy'), to_date('16-12-2021', 'dd-mm-yyyy'), 'Cancelled', 2090);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3208, 'External Invitees', 'Rhys', 'Feliciano', to_date('24-01-2021', 'dd-mm-yyyy'), to_date('01-02-2021', 'dd-mm-yyyy'), 'No Response', 2208);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3209, 'Immediate Family', 'Sydney', 'Pony', to_date('03-01-2021', 'dd-mm-yyyy'), to_date('07-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2075);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3210, 'External Invitees', 'Marina', 'Hunt', to_date('30-03-2021', 'dd-mm-yyyy'), to_date('12-06-2021', 'dd-mm-yyyy'), 'Waitlisted', 2098);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3211, 'External Invitees', 'Loren', 'Dooley', to_date('24-08-2021', 'dd-mm-yyyy'), to_date('05-08-2021', 'dd-mm-yyyy'), 'Cancelled', 2013);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3212, 'Work Colleagues', 'Sharon', 'Hedaya', to_date('04-12-2021', 'dd-mm-yyyy'), to_date('08-08-2021', 'dd-mm-yyyy'), 'Waitlisted', 2203);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3213, 'External Invitees', 'Ricardo', 'Sedgwick', to_date('29-06-2021', 'dd-mm-yyyy'), to_date('14-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2040);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3214, 'Work Colleagues', 'Chuck', 'Begley', to_date('02-12-2021', 'dd-mm-yyyy'), to_date('09-06-2021', 'dd-mm-yyyy'), 'Declined', 2055);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3215, 'Acquaintances', 'Pete', 'Rapaport', to_date('15-08-2021', 'dd-mm-yyyy'), to_date('02-08-2021', 'dd-mm-yyyy'), 'Waitlisted', 2328);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3216, 'Neighbors', 'Andrew', 'Martin', to_date('03-07-2021', 'dd-mm-yyyy'), to_date('10-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2308);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3217, 'Extended Family', 'Howard', 'Theron', to_date('01-02-2021', 'dd-mm-yyyy'), to_date('21-08-2021', 'dd-mm-yyyy'), '''Plus One''.', 2055);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3218, 'Neighbors', 'Kay', 'Stills', to_date('05-10-2021', 'dd-mm-yyyy'), to_date('02-10-2021', 'dd-mm-yyyy'), 'Cancelled', 2111);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3219, 'External Invitees', 'Benicio', 'Cassidy', to_date('13-07-2021', 'dd-mm-yyyy'), to_date('14-01-2021', 'dd-mm-yyyy'), 'Cancelled', 2388);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3220, 'Close Friends', 'Stellan', 'Bridges', to_date('31-03-2021', 'dd-mm-yyyy'), to_date('26-11-2021', 'dd-mm-yyyy'), 'Declined', 2090);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3221, 'Close Friends', 'Corey', 'Pride', to_date('16-12-2021', 'dd-mm-yyyy'), to_date('02-01-2021', 'dd-mm-yyyy'), 'No Response', 2251);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3222, 'Friends', 'Harvey', 'Yankovic', to_date('30-04-2021', 'dd-mm-yyyy'), to_date('12-12-2021', 'dd-mm-yyyy'), 'No Response', 2112);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3223, 'Immediate Family', 'Trick', 'Roth', to_date('17-03-2021', 'dd-mm-yyyy'), to_date('27-01-2021', 'dd-mm-yyyy'), 'Declined', 2104);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3224, 'Friends', 'Rosario', 'Heslov', to_date('03-01-2021', 'dd-mm-yyyy'), to_date('19-04-2021', 'dd-mm-yyyy'), 'No Response', 2272);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3225, 'Acquaintances', 'Wayman', 'Piven', to_date('01-03-2021', 'dd-mm-yyyy'), to_date('09-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2116);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3226, 'Immediate Family', 'Goldie', 'O''Sullivan', to_date('10-05-2021', 'dd-mm-yyyy'), to_date('03-02-2021', 'dd-mm-yyyy'), 'Declined', 2259);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3227, 'Neighbors', 'Boyd', 'Neill', to_date('28-08-2021', 'dd-mm-yyyy'), to_date('29-10-2021', 'dd-mm-yyyy'), 'No Response', 2341);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3228, 'Acquaintances', 'Bradley', 'Bonneville', to_date('12-05-2021', 'dd-mm-yyyy'), to_date('13-02-2021', 'dd-mm-yyyy'), '''Plus One''.', 2336);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3229, 'Work Colleagues', 'Sylvester', 'Sweeney', to_date('25-08-2021', 'dd-mm-yyyy'), to_date('01-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2094);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3230, 'Friends', 'Sally', 'Field', to_date('28-05-2021', 'dd-mm-yyyy'), to_date('09-10-2021', 'dd-mm-yyyy'), '''Plus One''.', 2311);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3231, 'External Invitees', 'Lena', 'Gertner', to_date('22-10-2021', 'dd-mm-yyyy'), to_date('15-06-2021', 'dd-mm-yyyy'), 'Cancelled', 2122);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3232, 'Work Colleagues', 'Rachid', 'Shaye', to_date('30-09-2021', 'dd-mm-yyyy'), to_date('18-12-2021', 'dd-mm-yyyy'), 'Waitlisted', 2117);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3233, 'Extended Family', 'Isabella', 'Warden', to_date('27-07-2021', 'dd-mm-yyyy'), to_date('07-08-2021', 'dd-mm-yyyy'), 'Declined', 2385);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3234, 'Close Friends', 'Benjamin', 'Hoffman', to_date('20-04-2021', 'dd-mm-yyyy'), to_date('01-02-2021', 'dd-mm-yyyy'), 'Confirmed', 2382);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3235, 'Close Friends', 'Nils', 'Carrey', to_date('29-06-2021', 'dd-mm-yyyy'), to_date('13-02-2021', 'dd-mm-yyyy'), 'Declined', 2225);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3236, 'Neighbors', 'Oro', 'Lavigne', to_date('29-01-2021', 'dd-mm-yyyy'), to_date('08-12-2021', 'dd-mm-yyyy'), 'Declined', 2208);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3237, 'Immediate Family', 'First', 'De Almeida', to_date('21-01-2021', 'dd-mm-yyyy'), to_date('28-12-2021', 'dd-mm-yyyy'), '''Plus One''.', 2145);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3238, 'Neighbors', 'Brothers', 'Patillo', to_date('05-09-2021', 'dd-mm-yyyy'), to_date('28-08-2021', 'dd-mm-yyyy'), 'No Response', 2142);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3239, 'External Invitees', 'Elizabeth', 'Tripplehorn', to_date('24-08-2021', 'dd-mm-yyyy'), to_date('03-01-2021', 'dd-mm-yyyy'), 'No Response', 2384);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3240, 'Work Colleagues', 'Night', 'Bugnon', to_date('11-04-2021', 'dd-mm-yyyy'), to_date('01-09-2021', 'dd-mm-yyyy'), 'Waitlisted', 2357);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3241, 'Immediate Family', 'Ned', 'Pantoliano', to_date('31-07-2021', 'dd-mm-yyyy'), to_date('15-09-2021', 'dd-mm-yyyy'), 'No Response', 2289);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3242, 'Neighbors', 'Roy', 'Vanian', to_date('20-05-2021', 'dd-mm-yyyy'), to_date('12-08-2021', 'dd-mm-yyyy'), 'Declined', 2019);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3243, 'Extended Family', 'Edwin', 'de Lancie', to_date('12-11-2021', 'dd-mm-yyyy'), to_date('26-04-2021', 'dd-mm-yyyy'), 'No Response', 2091);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3244, 'Extended Family', 'Earl', 'Rizzo', to_date('10-08-2021', 'dd-mm-yyyy'), to_date('17-04-2021', 'dd-mm-yyyy'), 'Waitlisted', 2270);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3245, 'Neighbors', 'Andrew', 'Underwood', to_date('04-04-2021', 'dd-mm-yyyy'), to_date('12-09-2021', 'dd-mm-yyyy'), 'Waitlisted', 2284);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3246, 'Neighbors', 'Victoria', 'Burke', to_date('18-12-2021', 'dd-mm-yyyy'), to_date('08-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2396);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3247, 'Neighbors', 'Arnold', 'Diesel', to_date('24-02-2021', 'dd-mm-yyyy'), to_date('07-04-2021', 'dd-mm-yyyy'), 'Waitlisted', 2193);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3248, 'Work Colleagues', 'Rachid', 'Ripley', to_date('17-08-2021', 'dd-mm-yyyy'), to_date('21-06-2021', 'dd-mm-yyyy'), 'Declined', 2007);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3249, 'Immediate Family', 'Brenda', 'Crowe', to_date('21-12-2021', 'dd-mm-yyyy'), to_date('09-12-2021', 'dd-mm-yyyy'), '''Plus One''.', 2156);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3250, 'Immediate Family', 'Anna', 'Fonda', to_date('06-05-2021', 'dd-mm-yyyy'), to_date('16-10-2021', 'dd-mm-yyyy'), 'Waitlisted', 2011);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3251, 'Friends', 'Garry', 'Rush', to_date('30-09-2021', 'dd-mm-yyyy'), to_date('29-01-2021', 'dd-mm-yyyy'), '''Plus One''.', 2093);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3252, 'External Invitees', 'Jared', 'Levert', to_date('29-01-2021', 'dd-mm-yyyy'), to_date('16-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2387);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3253, 'Neighbors', 'Wendy', 'Heston', to_date('21-02-2021', 'dd-mm-yyyy'), to_date('02-06-2021', 'dd-mm-yyyy'), 'Waitlisted', 2087);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3254, 'Close Friends', 'Jim', 'Roundtree', to_date('07-01-2021', 'dd-mm-yyyy'), to_date('09-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2362);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3255, 'Immediate Family', 'Boz', 'Frampton', to_date('27-10-2021', 'dd-mm-yyyy'), to_date('02-01-2021', 'dd-mm-yyyy'), '''Plus One''.', 2152);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3256, 'Immediate Family', 'Emily', 'Mazar', to_date('15-01-2021', 'dd-mm-yyyy'), to_date('07-09-2021', 'dd-mm-yyyy'), 'No Response', 2184);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3257, 'Acquaintances', 'Caroline', 'Biel', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('20-02-2021', 'dd-mm-yyyy'), 'No Response', 2014);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3258, 'Acquaintances', 'Hector', 'Taha', to_date('01-01-2021', 'dd-mm-yyyy'), to_date('31-12-2021', 'dd-mm-yyyy'), 'No Response', 2099);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3259, 'Friends', 'Nicolas', 'Vaughn', to_date('06-10-2021', 'dd-mm-yyyy'), to_date('22-04-2021', 'dd-mm-yyyy'), '''Plus One''.', 2084);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3260, 'Neighbors', 'Curtis', 'Newton', to_date('15-05-2021', 'dd-mm-yyyy'), to_date('11-08-2021', 'dd-mm-yyyy'), '''Plus One''.', 2126);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3261, 'Friends', 'Emm', 'Gore', to_date('17-03-2021', 'dd-mm-yyyy'), to_date('13-02-2021', 'dd-mm-yyyy'), 'Confirmed', 2032);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3262, 'Neighbors', 'Shawn', 'Cleary', to_date('13-11-2021', 'dd-mm-yyyy'), to_date('03-12-2021', 'dd-mm-yyyy'), 'Waitlisted', 2231);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3263, 'Friends', 'Russell', 'Hanks', to_date('20-12-2021', 'dd-mm-yyyy'), to_date('05-04-2021', 'dd-mm-yyyy'), '''Plus One''.', 2163);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3264, 'Immediate Family', 'Shirley', 'Margolyes', to_date('26-06-2021', 'dd-mm-yyyy'), to_date('14-11-2021', 'dd-mm-yyyy'), 'Declined', 2101);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3265, 'Neighbors', 'Larry', 'Borgnine', to_date('12-07-2021', 'dd-mm-yyyy'), to_date('26-05-2021', 'dd-mm-yyyy'), 'No Response', 2391);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3266, 'Friends', 'Praga', 'Donelly', to_date('20-07-2021', 'dd-mm-yyyy'), to_date('09-11-2021', 'dd-mm-yyyy'), '''Plus One''.', 2122);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3267, 'Extended Family', 'Judi', 'Avalon', to_date('03-01-2021', 'dd-mm-yyyy'), to_date('26-02-2021', 'dd-mm-yyyy'), 'Waitlisted', 2016);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3268, 'Immediate Family', 'Roger', 'Flanagan', to_date('07-01-2021', 'dd-mm-yyyy'), to_date('11-09-2021', 'dd-mm-yyyy'), 'Waitlisted', 2351);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3269, 'Work Colleagues', 'Gaby', 'Peterson', to_date('24-01-2021', 'dd-mm-yyyy'), to_date('09-01-2021', 'dd-mm-yyyy'), 'No Response', 2297);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3270, 'External Invitees', 'Penelope', 'Weiland', to_date('24-10-2021', 'dd-mm-yyyy'), to_date('18-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2293);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3271, 'Extended Family', 'Wendy', 'Tripplehorn', to_date('29-09-2021', 'dd-mm-yyyy'), to_date('22-04-2021', 'dd-mm-yyyy'), 'Declined', 2229);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3272, 'Friends', 'Heather', 'Zappacosta', to_date('23-03-2021', 'dd-mm-yyyy'), to_date('03-11-2021', 'dd-mm-yyyy'), 'Waitlisted', 2274);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3273, 'Close Friends', 'Grace', 'Feuerstein', to_date('07-09-2021', 'dd-mm-yyyy'), to_date('23-01-2021', 'dd-mm-yyyy'), 'Waitlisted', 2314);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3274, 'Extended Family', 'Gilbert', 'de Lancie', to_date('24-03-2021', 'dd-mm-yyyy'), to_date('30-03-2021', 'dd-mm-yyyy'), 'Cancelled', 2020);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3275, 'Close Friends', 'Whoopi', 'Pepper', to_date('05-04-2021', 'dd-mm-yyyy'), to_date('13-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2342);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3276, 'Work Colleagues', 'Penelope', 'Tempest', to_date('08-05-2021', 'dd-mm-yyyy'), to_date('26-07-2021', 'dd-mm-yyyy'), 'Waitlisted', 2027);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3277, 'External Invitees', 'Pablo', 'Milsap', to_date('29-04-2021', 'dd-mm-yyyy'), to_date('05-08-2021', 'dd-mm-yyyy'), 'Declined', 2361);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3278, 'Friends', 'Steve', 'Cartlidge', to_date('19-01-2021', 'dd-mm-yyyy'), to_date('21-09-2021', 'dd-mm-yyyy'), 'Waitlisted', 2138);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3279, 'Neighbors', 'Jude', 'Oszajca', to_date('16-01-2021', 'dd-mm-yyyy'), to_date('05-09-2021', 'dd-mm-yyyy'), 'Confirmed', 2053);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3280, 'External Invitees', 'Terri', 'Hedaya', to_date('13-12-2021', 'dd-mm-yyyy'), to_date('28-08-2021', 'dd-mm-yyyy'), 'Declined', 2119);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3281, 'Close Friends', 'Rutger', 'Arkin', to_date('26-08-2021', 'dd-mm-yyyy'), to_date('20-09-2021', 'dd-mm-yyyy'), 'Declined', 2112);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3282, 'Close Friends', 'Laurie', 'Tinsley', to_date('26-01-2021', 'dd-mm-yyyy'), to_date('11-04-2021', 'dd-mm-yyyy'), '''Plus One''.', 2235);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3283, 'External Invitees', 'Rene', 'Salonga', to_date('21-07-2021', 'dd-mm-yyyy'), to_date('06-08-2021', 'dd-mm-yyyy'), 'No Response', 2015);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3284, 'Extended Family', 'Owen', 'Belle', to_date('09-10-2021', 'dd-mm-yyyy'), to_date('29-05-2021', 'dd-mm-yyyy'), '''Plus One''.', 2219);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3285, 'Extended Family', 'Humberto', 'Loggia', to_date('28-02-2021', 'dd-mm-yyyy'), to_date('21-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2199);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3286, 'External Invitees', 'Gavin', 'Thomson', to_date('04-02-2021', 'dd-mm-yyyy'), to_date('16-09-2021', 'dd-mm-yyyy'), 'Cancelled', 2257);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3287, 'Work Colleagues', 'Kurtwood', 'Navarro', to_date('26-02-2021', 'dd-mm-yyyy'), to_date('26-02-2021', 'dd-mm-yyyy'), 'No Response', 2237);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3288, 'Close Friends', 'Ryan', 'Lyonne', to_date('26-08-2021', 'dd-mm-yyyy'), to_date('18-08-2021', 'dd-mm-yyyy'), 'Waitlisted', 2351);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3289, 'Neighbors', 'Jude', 'Savage', to_date('22-09-2021', 'dd-mm-yyyy'), to_date('21-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2211);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3290, 'Immediate Family', 'Anthony', 'Mollard', to_date('02-09-2021', 'dd-mm-yyyy'), to_date('03-05-2021', 'dd-mm-yyyy'), 'Cancelled', 2105);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3291, 'Immediate Family', 'Nicholas', 'Imbruglia', to_date('19-12-2021', 'dd-mm-yyyy'), to_date('29-09-2021', 'dd-mm-yyyy'), '''Plus One''.', 2087);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3292, 'Immediate Family', 'Patrick', 'Peebles', to_date('31-07-2021', 'dd-mm-yyyy'), to_date('27-08-2021', 'dd-mm-yyyy'), 'No Response', 2094);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3293, 'Acquaintances', 'Johnette', 'Carnes', to_date('25-05-2021', 'dd-mm-yyyy'), to_date('12-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2291);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3294, 'Immediate Family', 'Grant', 'Plummer', to_date('04-08-2021', 'dd-mm-yyyy'), to_date('30-12-2021', 'dd-mm-yyyy'), '''Plus One''.', 2039);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3295, 'External Invitees', 'Lonnie', 'Belles', to_date('12-10-2021', 'dd-mm-yyyy'), to_date('07-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2285);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3296, 'Neighbors', 'Pelvic', 'Jones', to_date('14-05-2021', 'dd-mm-yyyy'), to_date('27-04-2021', 'dd-mm-yyyy'), 'Waitlisted', 2185);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3297, 'Acquaintances', 'Avenged', 'Janney', to_date('14-11-2021', 'dd-mm-yyyy'), to_date('25-08-2021', 'dd-mm-yyyy'), 'Cancelled', 2340);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3298, 'Work Colleagues', 'Pierce', 'Weber', to_date('05-01-2021', 'dd-mm-yyyy'), to_date('16-01-2021', 'dd-mm-yyyy'), 'No Response', 2272);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3299, 'Work Colleagues', 'Robert', 'Adams', to_date('17-07-2021', 'dd-mm-yyyy'), to_date('21-08-2021', 'dd-mm-yyyy'), 'Cancelled', 2111);
commit;
prompt 300 records committed...
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3300, 'Close Friends', 'Aida', 'Wakeling', to_date('23-12-2021', 'dd-mm-yyyy'), to_date('29-12-2021', 'dd-mm-yyyy'), 'Waitlisted', 2116);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3301, 'External Invitees', 'Frankie', 'Gates', to_date('13-03-2021', 'dd-mm-yyyy'), to_date('30-09-2021', 'dd-mm-yyyy'), 'Declined', 2014);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3302, 'Extended Family', 'Kurtwood', 'Englund', to_date('17-07-2021', 'dd-mm-yyyy'), to_date('05-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2175);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3303, 'External Invitees', 'Gavin', 'Holm', to_date('09-07-2021', 'dd-mm-yyyy'), to_date('17-10-2021', 'dd-mm-yyyy'), 'No Response', 2199);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3304, 'External Invitees', 'Julie', 'Herrmann', to_date('06-10-2021', 'dd-mm-yyyy'), to_date('17-07-2021', 'dd-mm-yyyy'), 'Declined', 2135);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3305, 'Neighbors', 'Lois', 'Ali', to_date('20-07-2021', 'dd-mm-yyyy'), to_date('08-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2326);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3306, 'Neighbors', 'Ruth', 'Reinhold', to_date('04-02-2021', 'dd-mm-yyyy'), to_date('10-04-2021', 'dd-mm-yyyy'), 'Waitlisted', 2276);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3307, 'Immediate Family', 'Jay', 'Brock', to_date('06-12-2021', 'dd-mm-yyyy'), to_date('06-09-2021', 'dd-mm-yyyy'), 'Declined', 2140);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3308, 'Acquaintances', 'Alan', 'Daniels', to_date('13-10-2021', 'dd-mm-yyyy'), to_date('12-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2049);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3309, 'Immediate Family', 'Linda', 'Gandolfini', to_date('26-06-2021', 'dd-mm-yyyy'), to_date('01-09-2021', 'dd-mm-yyyy'), 'Confirmed', 2046);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3310, 'Close Friends', 'Maura', 'Masur', to_date('24-02-2021', 'dd-mm-yyyy'), to_date('26-09-2021', 'dd-mm-yyyy'), 'Waitlisted', 2256);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3311, 'Neighbors', 'Olga', 'Karyo', to_date('03-05-2021', 'dd-mm-yyyy'), to_date('07-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2082);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3312, 'Immediate Family', 'Collective', 'Torino', to_date('24-01-2021', 'dd-mm-yyyy'), to_date('10-05-2021', 'dd-mm-yyyy'), 'No Response', 2019);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3313, 'Acquaintances', 'Forest', 'Sainte-Marie', to_date('24-08-2021', 'dd-mm-yyyy'), to_date('03-12-2021', 'dd-mm-yyyy'), '''Plus One''.', 2098);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3314, 'Acquaintances', 'Nikka', 'Branch', to_date('30-11-2021', 'dd-mm-yyyy'), to_date('23-02-2021', 'dd-mm-yyyy'), 'Declined', 2156);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3315, 'Work Colleagues', 'Cevin', 'McDonnell', to_date('28-09-2021', 'dd-mm-yyyy'), to_date('12-07-2021', 'dd-mm-yyyy'), 'No Response', 2327);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3316, 'External Invitees', 'Juan', 'Child', to_date('17-11-2021', 'dd-mm-yyyy'), to_date('12-12-2021', 'dd-mm-yyyy'), 'Declined', 2161);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3317, 'Work Colleagues', 'Cate', 'Lovitz', to_date('18-02-2021', 'dd-mm-yyyy'), to_date('07-05-2021', 'dd-mm-yyyy'), '''Plus One''.', 2364);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3318, 'Immediate Family', 'Neneh', 'Russo', to_date('27-03-2021', 'dd-mm-yyyy'), to_date('08-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2371);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3319, 'Extended Family', 'Vendetta', 'Coolidge', to_date('20-05-2021', 'dd-mm-yyyy'), to_date('18-06-2021', 'dd-mm-yyyy'), 'Cancelled', 2136);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3320, 'Work Colleagues', 'Clint', 'Reid', to_date('27-07-2021', 'dd-mm-yyyy'), to_date('27-01-2021', 'dd-mm-yyyy'), '''Plus One''.', 2149);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3321, 'Friends', 'Patty', 'Glenn', to_date('17-07-2021', 'dd-mm-yyyy'), to_date('15-03-2021', 'dd-mm-yyyy'), 'Declined', 2082);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3322, 'Work Colleagues', 'Ann', 'Fiennes', to_date('28-10-2021', 'dd-mm-yyyy'), to_date('16-01-2021', 'dd-mm-yyyy'), '''Plus One''.', 2054);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3323, 'Work Colleagues', 'Rachel', 'McGovern', to_date('25-05-2021', 'dd-mm-yyyy'), to_date('31-01-2021', 'dd-mm-yyyy'), 'Cancelled', 2125);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3324, 'Work Colleagues', 'Howie', 'Nightingale', to_date('25-05-2021', 'dd-mm-yyyy'), to_date('09-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2015);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3325, 'External Invitees', 'Cate', 'Nelson', to_date('05-02-2021', 'dd-mm-yyyy'), to_date('02-10-2021', 'dd-mm-yyyy'), '''Plus One''.', 2246);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3326, 'Extended Family', 'Allison', 'Hawthorne', to_date('22-11-2021', 'dd-mm-yyyy'), to_date('07-12-2021', 'dd-mm-yyyy'), 'Waitlisted', 2311);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3327, 'Extended Family', 'Jude', 'Sepulveda', to_date('20-09-2021', 'dd-mm-yyyy'), to_date('01-12-2021', 'dd-mm-yyyy'), 'Cancelled', 2265);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3328, 'External Invitees', 'Beth', 'Wainwright', to_date('10-04-2021', 'dd-mm-yyyy'), to_date('03-04-2021', 'dd-mm-yyyy'), 'Cancelled', 2143);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3329, 'Immediate Family', 'Mia', 'Koteas', to_date('31-07-2021', 'dd-mm-yyyy'), to_date('14-04-2021', 'dd-mm-yyyy'), 'Declined', 2007);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3330, 'Acquaintances', 'Phil', 'Williamson', to_date('07-01-2021', 'dd-mm-yyyy'), to_date('01-08-2021', 'dd-mm-yyyy'), 'Cancelled', 2208);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3331, 'Acquaintances', 'Hank', 'Klugh', to_date('12-12-2021', 'dd-mm-yyyy'), to_date('03-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2285);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3332, 'Acquaintances', 'Willem', 'Spiner', to_date('01-03-2021', 'dd-mm-yyyy'), to_date('06-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2077);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3333, 'Acquaintances', 'Vern', 'Masur', to_date('25-05-2021', 'dd-mm-yyyy'), to_date('05-02-2021', 'dd-mm-yyyy'), '''Plus One''.', 2271);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3334, 'Immediate Family', 'Cheryl', 'Brock', to_date('08-02-2021', 'dd-mm-yyyy'), to_date('25-12-2021', 'dd-mm-yyyy'), 'Declined', 2366);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3335, 'Acquaintances', 'Adam', 'Stamp', to_date('10-09-2021', 'dd-mm-yyyy'), to_date('28-05-2021', 'dd-mm-yyyy'), '''Plus One''.', 2070);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3336, 'Acquaintances', 'Pamela', 'Rifkin', to_date('27-03-2021', 'dd-mm-yyyy'), to_date('17-09-2021', 'dd-mm-yyyy'), 'Declined', 2115);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3337, 'Acquaintances', 'Anne', 'Donelly', to_date('05-12-2021', 'dd-mm-yyyy'), to_date('06-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2100);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3338, 'External Invitees', 'Adrien', 'Walken', to_date('29-04-2021', 'dd-mm-yyyy'), to_date('22-08-2021', 'dd-mm-yyyy'), 'Cancelled', 2161);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3339, 'Extended Family', 'Emm', 'Steenburgen', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('12-03-2021', 'dd-mm-yyyy'), 'No Response', 2061);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3340, 'Friends', 'Patricia', 'Colman', to_date('15-04-2021', 'dd-mm-yyyy'), to_date('13-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2112);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3341, 'Neighbors', 'Devon', 'Latifah', to_date('09-10-2021', 'dd-mm-yyyy'), to_date('09-11-2021', 'dd-mm-yyyy'), 'Cancelled', 2315);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3342, 'Friends', 'Stanley', 'Spector', to_date('30-07-2021', 'dd-mm-yyyy'), to_date('31-07-2021', 'dd-mm-yyyy'), '''Plus One''.', 2126);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3343, 'External Invitees', 'Joaquim', 'Beck', to_date('28-06-2021', 'dd-mm-yyyy'), to_date('18-06-2021', 'dd-mm-yyyy'), 'Declined', 2055);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3344, 'External Invitees', 'Dorry', 'Rain', to_date('03-01-2021', 'dd-mm-yyyy'), to_date('05-07-2021', 'dd-mm-yyyy'), 'No Response', 2280);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3345, 'Friends', 'Colleen', 'Warwick', to_date('30-07-2021', 'dd-mm-yyyy'), to_date('24-06-2021', 'dd-mm-yyyy'), 'Cancelled', 2289);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3346, 'Extended Family', 'Davey', 'Fichtner', to_date('16-05-2021', 'dd-mm-yyyy'), to_date('05-05-2021', 'dd-mm-yyyy'), 'Declined', 2351);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3347, 'Friends', 'Beverley', 'Miller', to_date('03-01-2021', 'dd-mm-yyyy'), to_date('23-10-2021', 'dd-mm-yyyy'), 'Waitlisted', 2006);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3348, 'Close Friends', 'Hal', 'DiCaprio', to_date('24-08-2021', 'dd-mm-yyyy'), to_date('06-12-2021', 'dd-mm-yyyy'), '''Plus One''.', 2386);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3349, 'Acquaintances', 'Shelby', 'Starr', to_date('30-05-2021', 'dd-mm-yyyy'), to_date('28-09-2021', 'dd-mm-yyyy'), 'No Response', 2356);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3350, 'Extended Family', 'Dionne', 'Swayze', to_date('08-02-2021', 'dd-mm-yyyy'), to_date('23-12-2021', 'dd-mm-yyyy'), 'No Response', 2081);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3351, 'Extended Family', 'Annie', 'Harrison', to_date('25-08-2021', 'dd-mm-yyyy'), to_date('11-11-2021', 'dd-mm-yyyy'), 'Waitlisted', 2023);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3352, 'Work Colleagues', 'Willie', 'Moriarty', to_date('02-04-2021', 'dd-mm-yyyy'), to_date('14-12-2021', 'dd-mm-yyyy'), 'Waitlisted', 2154);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3353, 'Work Colleagues', 'Loreena', 'Chandler', to_date('21-04-2021', 'dd-mm-yyyy'), to_date('09-01-2021', 'dd-mm-yyyy'), 'Cancelled', 2202);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3354, 'Immediate Family', 'Armand', 'Gugino', to_date('24-10-2021', 'dd-mm-yyyy'), to_date('21-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2119);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3355, 'Neighbors', 'Lloyd', 'Sisto', to_date('08-02-2021', 'dd-mm-yyyy'), to_date('04-04-2021', 'dd-mm-yyyy'), 'Declined', 2372);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3356, 'Work Colleagues', 'Sharon', 'Weller', to_date('05-02-2021', 'dd-mm-yyyy'), to_date('23-02-2021', 'dd-mm-yyyy'), 'Waitlisted', 2064);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3357, 'Immediate Family', 'Wade', 'Gates', to_date('22-09-2021', 'dd-mm-yyyy'), to_date('21-09-2021', 'dd-mm-yyyy'), 'Confirmed', 2072);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3358, 'Acquaintances', 'Lance', 'Neill', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('02-09-2021', 'dd-mm-yyyy'), 'Cancelled', 2022);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3359, 'Extended Family', 'Debra', 'Broderick', to_date('27-07-2021', 'dd-mm-yyyy'), to_date('23-08-2021', 'dd-mm-yyyy'), 'No Response', 2276);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3360, 'Work Colleagues', 'Lee', 'Karyo', to_date('22-11-2021', 'dd-mm-yyyy'), to_date('10-08-2021', 'dd-mm-yyyy'), 'Cancelled', 2152);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3361, 'Acquaintances', 'Aaron', 'Morrison', to_date('10-06-2021', 'dd-mm-yyyy'), to_date('30-03-2021', 'dd-mm-yyyy'), 'No Response', 2367);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3362, 'Work Colleagues', 'Jeanne', 'Rankin', to_date('28-07-2021', 'dd-mm-yyyy'), to_date('31-05-2021', 'dd-mm-yyyy'), 'No Response', 2106);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3363, 'Work Colleagues', 'Selma', 'Torino', to_date('30-03-2021', 'dd-mm-yyyy'), to_date('09-09-2021', 'dd-mm-yyyy'), 'Cancelled', 2313);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3364, 'Extended Family', 'Jimmy', 'Klugh', to_date('21-08-2021', 'dd-mm-yyyy'), to_date('12-12-2021', 'dd-mm-yyyy'), 'No Response', 2010);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3365, 'Immediate Family', 'Tyrone', 'Smurfit', to_date('12-01-2021', 'dd-mm-yyyy'), to_date('06-01-2021', 'dd-mm-yyyy'), 'Cancelled', 2042);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3366, 'Extended Family', 'First', 'Simpson', to_date('13-06-2021', 'dd-mm-yyyy'), to_date('29-05-2021', 'dd-mm-yyyy'), 'Waitlisted', 2239);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3367, 'Immediate Family', 'Nancy', 'Paquin', to_date('25-03-2021', 'dd-mm-yyyy'), to_date('29-01-2021', 'dd-mm-yyyy'), 'Cancelled', 2017);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3368, 'Work Colleagues', 'Rhys', 'Leto', to_date('12-10-2021', 'dd-mm-yyyy'), to_date('15-04-2021', 'dd-mm-yyyy'), 'Declined', 2388);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3369, 'Extended Family', 'Jeremy', 'Jovovich', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('25-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2210);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3370, 'Work Colleagues', 'Kirsten', 'Dillane', to_date('17-07-2021', 'dd-mm-yyyy'), to_date('14-04-2021', 'dd-mm-yyyy'), 'No Response', 2250);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3371, 'Friends', 'Derrick', 'Jackman', to_date('25-07-2021', 'dd-mm-yyyy'), to_date('06-07-2021', 'dd-mm-yyyy'), 'Declined', 2280);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3372, 'Friends', 'Marie', 'Crouch', to_date('15-06-2021', 'dd-mm-yyyy'), to_date('08-04-2021', 'dd-mm-yyyy'), 'Confirmed', 2391);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3373, 'Immediate Family', 'Jared', 'Matarazzo', to_date('01-07-2021', 'dd-mm-yyyy'), to_date('03-02-2021', 'dd-mm-yyyy'), '''Plus One''.', 2142);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3374, 'Close Friends', 'Gavin', 'Hudson', to_date('21-07-2021', 'dd-mm-yyyy'), to_date('11-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2322);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3375, 'Acquaintances', 'Harvey', 'Stuart', to_date('22-02-2021', 'dd-mm-yyyy'), to_date('14-09-2021', 'dd-mm-yyyy'), 'Declined', 2148);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3376, 'Close Friends', 'Roberta', 'Flatts', to_date('09-07-2021', 'dd-mm-yyyy'), to_date('18-01-2021', 'dd-mm-yyyy'), 'No Response', 2279);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3377, 'Acquaintances', 'Claude', 'Visnjic', to_date('23-10-2021', 'dd-mm-yyyy'), to_date('29-04-2021', 'dd-mm-yyyy'), 'Cancelled', 2061);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3378, 'External Invitees', 'Pete', 'Williamson', to_date('02-12-2021', 'dd-mm-yyyy'), to_date('17-10-2021', 'dd-mm-yyyy'), 'No Response', 2194);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3379, 'Acquaintances', 'Ethan', 'Fishburne', to_date('27-07-2021', 'dd-mm-yyyy'), to_date('20-05-2021', 'dd-mm-yyyy'), '''Plus One''.', 2026);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3380, 'Friends', 'Beverley', 'Richards', to_date('27-03-2021', 'dd-mm-yyyy'), to_date('19-04-2021', 'dd-mm-yyyy'), 'Cancelled', 2271);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3381, 'Friends', 'Ernest', 'Walken', to_date('08-04-2021', 'dd-mm-yyyy'), to_date('01-09-2021', 'dd-mm-yyyy'), 'Cancelled', 2350);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3382, 'Immediate Family', 'Miki', 'Morrison', to_date('26-11-2021', 'dd-mm-yyyy'), to_date('09-04-2021', 'dd-mm-yyyy'), 'Cancelled', 2361);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3383, 'Neighbors', 'Junior', 'Parish', to_date('12-05-2021', 'dd-mm-yyyy'), to_date('18-04-2021', 'dd-mm-yyyy'), '''Plus One''.', 2073);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3384, 'Close Friends', 'Vienna', 'Miles', to_date('18-11-2021', 'dd-mm-yyyy'), to_date('16-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2140);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3385, 'External Invitees', 'Nicky', 'Moorer', to_date('15-08-2021', 'dd-mm-yyyy'), to_date('16-08-2021', 'dd-mm-yyyy'), 'No Response', 2346);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3386, 'Friends', 'Rade', 'Duke', to_date('03-07-2021', 'dd-mm-yyyy'), to_date('25-04-2021', 'dd-mm-yyyy'), 'Cancelled', 2077);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3387, 'External Invitees', 'Sal', 'Michael', to_date('13-11-2021', 'dd-mm-yyyy'), to_date('16-03-2021', 'dd-mm-yyyy'), '''Plus One''.', 2205);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3388, 'Extended Family', 'Roscoe', 'Berenger', to_date('04-09-2021', 'dd-mm-yyyy'), to_date('22-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2016);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3389, 'Immediate Family', 'Moe', 'Nelson', to_date('01-03-2021', 'dd-mm-yyyy'), to_date('17-09-2021', 'dd-mm-yyyy'), 'Waitlisted', 2344);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3390, 'Immediate Family', 'Louise', 'Tempest', to_date('31-03-2021', 'dd-mm-yyyy'), to_date('21-02-2021', 'dd-mm-yyyy'), '''Plus One''.', 2147);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3391, 'Friends', 'Juliette', 'Garcia', to_date('20-06-2021', 'dd-mm-yyyy'), to_date('20-11-2021', 'dd-mm-yyyy'), 'No Response', 2094);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3392, 'External Invitees', 'Selma', 'Jessee', to_date('10-10-2021', 'dd-mm-yyyy'), to_date('27-04-2021', 'dd-mm-yyyy'), 'Declined', 2385);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3393, 'Work Colleagues', 'Richie', 'Foxx', to_date('08-11-2021', 'dd-mm-yyyy'), to_date('20-06-2021', 'dd-mm-yyyy'), 'No Response', 2394);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3394, 'Friends', 'Julianne', 'Paul', to_date('25-03-2021', 'dd-mm-yyyy'), to_date('22-06-2021', 'dd-mm-yyyy'), 'Declined', 2138);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3395, 'Extended Family', 'Victoria', 'Price', to_date('29-04-2021', 'dd-mm-yyyy'), to_date('18-02-2021', 'dd-mm-yyyy'), 'Declined', 2369);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3396, 'Friends', 'Bo', 'Dourif', to_date('29-05-2021', 'dd-mm-yyyy'), to_date('24-06-2021', 'dd-mm-yyyy'), 'Declined', 2090);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3397, 'Acquaintances', 'Vondie', 'McGoohan', to_date('16-07-2021', 'dd-mm-yyyy'), to_date('10-06-2021', 'dd-mm-yyyy'), 'Waitlisted', 2302);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3398, 'Neighbors', 'Mika', 'Visnjic', to_date('12-11-2021', 'dd-mm-yyyy'), to_date('22-07-2021', 'dd-mm-yyyy'), 'Cancelled', 2370);
insert into GUESTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid)
values (3399, 'Friends', 'Ben', 'Foxx', to_date('23-08-2021', 'dd-mm-yyyy'), to_date('02-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2214);
commit;
prompt 400 records loaded
prompt Loading HAS_CATERING...
insert into HAS_CATERING (cateringid, eventid)
values (1, 2158);
insert into HAS_CATERING (cateringid, eventid)
values (1, 2186);
insert into HAS_CATERING (cateringid, eventid)
values (1, 2228);
insert into HAS_CATERING (cateringid, eventid)
values (1, 2249);
insert into HAS_CATERING (cateringid, eventid)
values (1, 2296);
insert into HAS_CATERING (cateringid, eventid)
values (1, 2310);
insert into HAS_CATERING (cateringid, eventid)
values (1, 2355);
insert into HAS_CATERING (cateringid, eventid)
values (1, 2386);
insert into HAS_CATERING (cateringid, eventid)
values (2, 2013);
insert into HAS_CATERING (cateringid, eventid)
values (2, 2333);
insert into HAS_CATERING (cateringid, eventid)
values (2, 2397);
insert into HAS_CATERING (cateringid, eventid)
values (3, 2062);
insert into HAS_CATERING (cateringid, eventid)
values (3, 2158);
insert into HAS_CATERING (cateringid, eventid)
values (3, 2177);
insert into HAS_CATERING (cateringid, eventid)
values (3, 2195);
insert into HAS_CATERING (cateringid, eventid)
values (3, 2305);
insert into HAS_CATERING (cateringid, eventid)
values (3, 2342);
insert into HAS_CATERING (cateringid, eventid)
values (4, 2073);
insert into HAS_CATERING (cateringid, eventid)
values (4, 2115);
insert into HAS_CATERING (cateringid, eventid)
values (4, 2256);
insert into HAS_CATERING (cateringid, eventid)
values (4, 2330);
insert into HAS_CATERING (cateringid, eventid)
values (5, 2214);
insert into HAS_CATERING (cateringid, eventid)
values (5, 2336);
insert into HAS_CATERING (cateringid, eventid)
values (5, 2347);
insert into HAS_CATERING (cateringid, eventid)
values (6, 2129);
insert into HAS_CATERING (cateringid, eventid)
values (6, 2152);
insert into HAS_CATERING (cateringid, eventid)
values (6, 2214);
insert into HAS_CATERING (cateringid, eventid)
values (7, 2021);
insert into HAS_CATERING (cateringid, eventid)
values (7, 2298);
insert into HAS_CATERING (cateringid, eventid)
values (7, 2302);
insert into HAS_CATERING (cateringid, eventid)
values (7, 2321);
insert into HAS_CATERING (cateringid, eventid)
values (8, 2195);
insert into HAS_CATERING (cateringid, eventid)
values (8, 2218);
insert into HAS_CATERING (cateringid, eventid)
values (8, 2317);
insert into HAS_CATERING (cateringid, eventid)
values (9, 2087);
insert into HAS_CATERING (cateringid, eventid)
values (9, 2140);
insert into HAS_CATERING (cateringid, eventid)
values (9, 2240);
insert into HAS_CATERING (cateringid, eventid)
values (10, 2216);
insert into HAS_CATERING (cateringid, eventid)
values (11, 2159);
insert into HAS_CATERING (cateringid, eventid)
values (11, 2234);
insert into HAS_CATERING (cateringid, eventid)
values (11, 2331);
insert into HAS_CATERING (cateringid, eventid)
values (11, 2382);
insert into HAS_CATERING (cateringid, eventid)
values (12, 2095);
insert into HAS_CATERING (cateringid, eventid)
values (12, 2135);
insert into HAS_CATERING (cateringid, eventid)
values (12, 2396);
insert into HAS_CATERING (cateringid, eventid)
values (13, 2113);
insert into HAS_CATERING (cateringid, eventid)
values (13, 2257);
insert into HAS_CATERING (cateringid, eventid)
values (13, 2389);
insert into HAS_CATERING (cateringid, eventid)
values (14, 2065);
insert into HAS_CATERING (cateringid, eventid)
values (14, 2280);
insert into HAS_CATERING (cateringid, eventid)
values (15, 2021);
insert into HAS_CATERING (cateringid, eventid)
values (16, 2003);
insert into HAS_CATERING (cateringid, eventid)
values (16, 2008);
insert into HAS_CATERING (cateringid, eventid)
values (16, 2344);
insert into HAS_CATERING (cateringid, eventid)
values (17, 2071);
insert into HAS_CATERING (cateringid, eventid)
values (17, 2148);
insert into HAS_CATERING (cateringid, eventid)
values (18, 2185);
insert into HAS_CATERING (cateringid, eventid)
values (18, 2208);
insert into HAS_CATERING (cateringid, eventid)
values (18, 2365);
insert into HAS_CATERING (cateringid, eventid)
values (19, 2058);
insert into HAS_CATERING (cateringid, eventid)
values (20, 2024);
insert into HAS_CATERING (cateringid, eventid)
values (20, 2060);
insert into HAS_CATERING (cateringid, eventid)
values (20, 2104);
insert into HAS_CATERING (cateringid, eventid)
values (20, 2179);
insert into HAS_CATERING (cateringid, eventid)
values (21, 2215);
insert into HAS_CATERING (cateringid, eventid)
values (21, 2291);
insert into HAS_CATERING (cateringid, eventid)
values (21, 2333);
insert into HAS_CATERING (cateringid, eventid)
values (21, 2357);
insert into HAS_CATERING (cateringid, eventid)
values (21, 2358);
insert into HAS_CATERING (cateringid, eventid)
values (22, 2057);
insert into HAS_CATERING (cateringid, eventid)
values (22, 2137);
insert into HAS_CATERING (cateringid, eventid)
values (22, 2265);
insert into HAS_CATERING (cateringid, eventid)
values (23, 2208);
insert into HAS_CATERING (cateringid, eventid)
values (23, 2307);
insert into HAS_CATERING (cateringid, eventid)
values (24, 2049);
insert into HAS_CATERING (cateringid, eventid)
values (24, 2054);
insert into HAS_CATERING (cateringid, eventid)
values (24, 2064);
insert into HAS_CATERING (cateringid, eventid)
values (24, 2087);
insert into HAS_CATERING (cateringid, eventid)
values (24, 2169);
insert into HAS_CATERING (cateringid, eventid)
values (24, 2189);
insert into HAS_CATERING (cateringid, eventid)
values (24, 2274);
insert into HAS_CATERING (cateringid, eventid)
values (25, 2107);
insert into HAS_CATERING (cateringid, eventid)
values (25, 2122);
insert into HAS_CATERING (cateringid, eventid)
values (25, 2299);
insert into HAS_CATERING (cateringid, eventid)
values (26, 2168);
insert into HAS_CATERING (cateringid, eventid)
values (26, 2208);
insert into HAS_CATERING (cateringid, eventid)
values (26, 2313);
insert into HAS_CATERING (cateringid, eventid)
values (27, 2139);
insert into HAS_CATERING (cateringid, eventid)
values (27, 2234);
insert into HAS_CATERING (cateringid, eventid)
values (28, 2112);
insert into HAS_CATERING (cateringid, eventid)
values (28, 2125);
insert into HAS_CATERING (cateringid, eventid)
values (28, 2295);
insert into HAS_CATERING (cateringid, eventid)
values (29, 2358);
insert into HAS_CATERING (cateringid, eventid)
values (30, 2251);
insert into HAS_CATERING (cateringid, eventid)
values (30, 2294);
insert into HAS_CATERING (cateringid, eventid)
values (1000, 2022);
insert into HAS_CATERING (cateringid, eventid)
values (1000, 2070);
insert into HAS_CATERING (cateringid, eventid)
values (2000, 2108);
insert into HAS_CATERING (cateringid, eventid)
values (2000, 2286);
insert into HAS_CATERING (cateringid, eventid)
values (2000, 2319);
commit;
prompt 100 records loaded
prompt Loading INSTRUMENT...
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Pan Flute', 822, 1);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Djembe', 808, 2);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Didgeridoo', 597, 3);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Banjo', 720, 4);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Tuba', 679, 5);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Flute', 865, 6);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Piano', 845, 7);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Ukulele', 614, 8);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Banjo', 942, 9);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Balalaika', 820, 10);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Zither', 826, 11);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Clarinet', 610, 12);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Bandoneon', 933, 13);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Recorder', 721, 14);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Marimba', 830, 15);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Triangle', 553, 16);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Electric Guitar', 751, 17);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Kazoo', 748, 18);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Trombone', 732, 19);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Double Bass', 719, 20);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Balalaika', 584, 21);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Drum', 693, 22);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Cello', 576, 23);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Vuvuzela', 938, 24);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Organ', 815, 25);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Sitar', 980, 26);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Accordion', 943, 27);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Guitar', 751, 28);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Piano', 898, 29);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Pan Flute', 704, 30);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Organ', 595, 31);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Organ', 595, 32);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Vuvuzela', 528, 33);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Synthesizer', 716, 34);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Triangle', 910, 35);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Piano', 526, 36);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Oboe', 582, 37);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Tambourine', 725, 38);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Tuba', 583, 39);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Lyre', 959, 40);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Harmonica', 841, 41);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Lute', 941, 42);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Clarinet', 626, 43);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Djembe', 954, 44);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Tuba', 502, 45);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Violin', 743, 46);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Cello', 637, 47);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Bassoon', 527, 48);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Piccolo', 968, 49);
insert into INSTRUMENT (instrumentname, price, instrumentid)
values ('Drum', 887, 50);
commit;
prompt 50 records loaded
prompt Loading INSTRUMENT_EVENT...
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (1, 1);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (1, 2);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (1, 16);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (1, 69);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (1, 90);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (1, 163);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (1, 185);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (1, 238);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (1, 289);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (1, 303);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (1, 382);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (2, 1);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (2, 21);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (2, 24);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (2, 50);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (2, 109);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (2, 158);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (2, 195);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (2, 205);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (2, 224);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (2, 313);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (2, 315);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (2, 335);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (2, 348);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (2, 375);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (3, 66);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (3, 80);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (3, 97);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (3, 108);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (3, 233);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (3, 244);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (3, 313);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (3, 342);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (4, 11);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (4, 44);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (4, 60);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (4, 82);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (4, 94);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (4, 125);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (4, 325);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (4, 362);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (4, 378);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (5, 39);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (5, 98);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (5, 189);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (5, 225);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (5, 272);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (5, 397);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (6, 22);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (6, 135);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (6, 137);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (6, 168);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (6, 196);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (6, 273);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (6, 277);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (6, 350);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (6, 371);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (6, 391);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (6, 398);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (7, 93);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (7, 108);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (7, 157);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (7, 191);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (8, 85);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (8, 103);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (8, 326);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (8, 335);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (8, 389);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (9, 10);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (9, 29);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (9, 37);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (9, 60);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (9, 90);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (9, 94);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (9, 224);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (9, 306);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (9, 373);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (9, 377);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (10, 44);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (10, 212);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (10, 258);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (10, 276);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (10, 391);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (11, 29);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (11, 62);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (11, 78);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (11, 95);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (11, 167);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (11, 299);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (11, 391);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (11, 397);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (12, 40);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (12, 98);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (12, 168);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (12, 224);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (12, 232);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (12, 342);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (12, 384);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (13, 23);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (13, 85);
commit;
prompt 100 records committed...
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (13, 225);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (13, 259);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (13, 272);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (13, 336);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (14, 39);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (14, 52);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (14, 189);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (14, 191);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (14, 223);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (14, 242);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (14, 266);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (14, 298);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (14, 304);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (14, 320);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (14, 364);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (15, 1);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (15, 24);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (15, 93);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (15, 120);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (15, 133);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (15, 166);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (15, 196);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (15, 197);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (15, 230);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (15, 304);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (15, 357);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (16, 6);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (16, 8);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (16, 10);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (16, 94);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (16, 184);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (16, 280);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (16, 302);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (16, 318);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (16, 319);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (16, 329);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (16, 333);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (17, 8);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (17, 48);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (17, 108);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (17, 155);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (17, 180);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (17, 317);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (17, 333);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (17, 394);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (18, 51);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (18, 195);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (18, 257);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (18, 383);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (19, 17);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (19, 84);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (19, 149);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (19, 169);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (19, 195);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (19, 248);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (19, 267);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (19, 274);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (20, 45);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (20, 46);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (20, 121);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (20, 126);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (20, 128);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (20, 181);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (20, 211);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (20, 212);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (20, 292);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (20, 295);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (20, 363);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (21, 31);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (21, 37);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (21, 90);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (21, 107);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (21, 185);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (21, 219);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (21, 268);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (22, 54);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (22, 115);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (22, 135);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (22, 161);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (22, 165);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (22, 189);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (22, 374);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (22, 386);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (22, 394);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (23, 129);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (23, 171);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (23, 364);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (23, 365);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (24, 68);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (24, 105);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (24, 163);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (24, 182);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (24, 196);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (24, 219);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (24, 237);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (24, 344);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (24, 373);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (25, 25);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (25, 76);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (25, 126);
commit;
prompt 200 records committed...
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (25, 171);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (25, 210);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (25, 226);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (25, 234);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (25, 240);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (25, 340);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (26, 37);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (26, 67);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (26, 88);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (26, 130);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (26, 133);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (26, 335);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (26, 363);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (26, 365);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (26, 382);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (27, 69);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (27, 107);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (27, 128);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (27, 133);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (27, 272);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (27, 282);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (27, 292);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (27, 295);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (27, 299);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (27, 309);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (27, 313);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (27, 340);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (27, 364);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (27, 375);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (27, 396);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (28, 4);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (28, 39);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (28, 217);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (28, 225);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (28, 379);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (29, 59);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (29, 81);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (29, 299);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (29, 366);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (30, 61);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (30, 107);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (30, 253);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (31, 109);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (31, 113);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (31, 135);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (31, 168);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (31, 395);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (32, 54);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (32, 56);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (32, 72);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (32, 130);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (32, 145);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (32, 194);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (32, 197);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (32, 274);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (32, 323);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (32, 330);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (33, 68);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (33, 115);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (33, 137);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (33, 223);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (33, 283);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (33, 301);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (33, 322);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (34, 85);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (34, 86);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (34, 142);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (34, 157);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (34, 221);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (34, 316);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (35, 170);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (35, 176);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (35, 225);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (35, 325);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (35, 336);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (35, 381);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (35, 388);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (36, 37);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (36, 75);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (36, 95);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (36, 122);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (36, 167);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (36, 169);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (36, 251);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (36, 341);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (36, 367);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (37, 16);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (37, 31);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (37, 55);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (37, 72);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (37, 80);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (37, 257);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (37, 335);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (38, 4);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (38, 82);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (38, 108);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (38, 125);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (38, 137);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (38, 143);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (38, 163);
commit;
prompt 300 records committed...
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (38, 238);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (38, 255);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (39, 20);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (39, 32);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (39, 100);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (39, 257);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (39, 281);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (39, 320);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (39, 327);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (39, 362);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (40, 91);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (40, 99);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (40, 176);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (40, 246);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (40, 259);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (40, 286);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (40, 375);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (41, 19);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (41, 167);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (41, 204);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (41, 239);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (41, 289);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (41, 341);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (42, 60);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (42, 70);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (42, 148);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (42, 233);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (42, 354);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (42, 397);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (43, 5);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (43, 8);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (43, 19);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (43, 34);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (43, 87);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (43, 125);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (43, 154);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (43, 210);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (43, 286);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (43, 353);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (44, 27);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (44, 173);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (44, 207);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (44, 271);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (44, 296);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (44, 299);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (44, 344);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (45, 8);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (45, 25);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (45, 100);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (45, 127);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (45, 329);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (45, 350);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (46, 10);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (46, 56);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (46, 151);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (46, 157);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (46, 171);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (46, 194);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (46, 223);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (46, 309);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (46, 318);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (46, 325);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (47, 109);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (47, 161);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (47, 243);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (47, 251);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (47, 299);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (47, 335);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (48, 126);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (48, 159);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (48, 285);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (48, 319);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (48, 358);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (49, 11);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (49, 187);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (49, 205);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (49, 249);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (49, 383);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (49, 399);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (50, 29);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (50, 61);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (50, 129);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (50, 147);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (50, 318);
insert into INSTRUMENT_EVENT (instrumentid, eventid)
values (50, 348);
commit;
prompt 385 records loaded
prompt Loading PAYMENTS...
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4000, 9123.24, to_date('07-12-1914', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1373, ' Bank Transfer', 187);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4001, 32552.32, to_date('12-06-2002', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1061, ' PayPal', 238);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4002, 5585.25, to_date('16-01-1964', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1332, ' Credit Card', 2334);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4003, 19456.69, to_date('30-01-1905', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1302, ' Cash', 2025);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4004, 28126.09, to_date('20-04-1932', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1316, ' PayPal', 2035);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4005, 22085.99, to_date('16-06-1904', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1269, ' Bank Transfer', 2219);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4006, 33248.29, to_date('01-09-2023', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1235, ' Bank Transfer', 2079);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4007, 27550.07, to_date('14-03-1992', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1158, ' Bit', 2256);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4008, 47388.65, to_date('31-03-2014', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1250, ' Bit', 2329);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4009, 32245, to_date('16-12-1952', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1280, ' Credit Card', 2301);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4010, 17105.12, to_date('14-10-1984', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1020, ' Credit Card', 2004);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4011, 24538.56, to_date('18-12-1998', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1011, ' Bit', 2293);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4012, 12543.6, to_date('08-08-2021', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1321, ' PayPal', 2151);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4013, 26518.35, to_date('27-10-1974', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1270, ' Check', 334);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4014, 39967.24, to_date('19-10-1987', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1179, ' Bank Transfer', 238);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4016, 48348.25, to_date('05-11-1989', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1340, ' PayPal', 223);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4017, 35411.63, to_date('22-09-1977', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1103, ' Credit Card', 272);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4018, 40022.15, to_date('06-06-1914', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1261, ' Check', 2032);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4019, 17706.66, to_date('02-11-1933', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1080, ' Credit Card', 2178);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4020, 15404.62, to_date('19-08-1910', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1218, ' Check', 274);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4021, 7384.55, to_date('24-10-1954', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1216, ' Bank Transfer', 2006);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4022, 21770.79, to_date('06-06-1942', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1155, ' Bit', 132);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4023, 8540.04, to_date('02-09-1955', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1082, ' Bank Transfer', 126);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4024, 36097, to_date('25-06-1911', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1039, ' PayPal', 2084);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4025, 19788.42, to_date('25-05-1939', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1083, ' Credit Card', 330);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4027, 39451.09, to_date('15-12-1943', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1206, ' PayPal', 2161);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4028, 30529.35, to_date('15-06-1935', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1136, ' Credit Card', 2348);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4029, 39803.63, to_date('18-08-1934', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1300, ' Check', 2373);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4030, 15545.53, to_date('02-10-1946', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1261, ' Cash', 2205);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4031, 45386.32, to_date('29-08-2016', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1280, ' Cash', 2302);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4032, 17462.91, to_date('09-11-1920', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1365, ' Bit', 275);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4033, 45377.2, to_date('16-03-1968', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1253, ' Check', 2319);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4034, 16578.43, to_date('11-11-2000', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1205, ' Bank Transfer', 344);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4035, 10027.61, to_date('16-08-1968', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1168, ' PayPal', 185);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4036, 10253.6, to_date('05-12-1980', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1181, ' PayPal', 296);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4037, 11160.23, to_date('17-01-2022', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1197, ' Bit', 2391);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4038, 39193.69, to_date('13-04-1921', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1375, ' Check', 274);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4039, 41729.66, to_date('07-04-1951', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1235, ' PayPal', 2316);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4040, 47789.6, to_date('07-07-1958', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1315, ' PayPal', 38);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4041, 29445.43, to_date('20-12-1961', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1128, ' PayPal', 283);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4042, 28522.14, to_date('07-03-1936', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1266, ' Check', 2060);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4043, 44457.56, to_date('29-03-1902', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1227, ' Check', 2171);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4044, 45428.81, to_date('05-10-1980', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1044, ' Bank Transfer', 248);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4045, 26104.61, to_date('30-05-1967', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1262, ' Bank Transfer', 311);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4046, 46633.1, to_date('13-11-2022', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1157, ' Check', 242);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4048, 5936.33, to_date('23-10-2013', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1069, ' PayPal', 2052);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4049, 16526.19, to_date('27-01-1961', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1305, ' Bit', 2090);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4050, 33471.89, to_date('22-06-1962', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1391, ' Credit Card', 115);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4051, 47527.94, to_date('13-04-1969', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1324, ' PayPal', 353);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4052, 5422.04, to_date('22-06-1917', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1193, ' Bit', 43);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4053, 46552.67, to_date('25-08-1913', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1332, ' Cash', 2207);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4054, 17797.25, to_date('03-09-2019', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1247, ' Bit', 2280);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4055, 12289.83, to_date('19-02-2009', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1297, ' PayPal', 2176);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4056, 44277.99, to_date('11-12-1999', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1190, ' Credit Card', 2039);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4057, 43418.18, to_date('28-06-2023', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1060, ' Cash', 12);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4058, 13118.96, to_date('29-04-1997', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1014, ' Check', 2332);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4059, 28791.37, to_date('16-04-1974', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1083, ' Bank Transfer', 2264);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4060, 33115.98, to_date('08-06-1947', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1282, ' Check', 2251);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4061, 26685.93, to_date('13-04-2021', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1125, ' Bank Transfer', 2021);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4062, 48635.23, to_date('14-03-1916', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1268, ' Cash', 49);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4063, 28111.88, to_date('30-12-1928', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1251, ' Bit', 2395);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4064, 48705.06, to_date('06-12-2003', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1018, ' Bank Transfer', 139);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4065, 49185.74, to_date('04-10-1974', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1154, ' Credit Card', 2198);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4067, 12566.06, to_date('23-11-1926', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1006, ' Cash', 117);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4068, 49908.96, to_date('25-10-1900', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1343, ' PayPal', 227);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4069, 47951.53, to_date('18-05-1968', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1041, ' Check', 20);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4070, 36111.76, to_date('15-04-1953', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1022, ' Cash', 151);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4071, 41641.44, to_date('05-09-1940', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1053, ' Credit Card', 389);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4072, 43623.67, to_date('14-08-1911', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1078, ' Bit', 2192);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4073, 10158.82, to_date('03-01-1908', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1025, ' Credit Card', 2329);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4074, 43348.35, to_date('10-09-1944', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1381, ' Bit', 338);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4075, 37935.9, to_date('22-10-1916', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1280, ' Bit', 64);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4076, 25714.91, to_date('23-08-1906', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1390, ' Check', 2150);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4077, 49062.23, to_date('12-08-1950', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1360, ' Cash', 202);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4078, 38207.19, to_date('02-02-1983', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1294, ' Credit Card', 95);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4079, 43095.18, to_date('06-03-1955', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1228, ' PayPal', 246);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4080, 11955.59, to_date('10-09-1907', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1074, ' Bank Transfer', 2341);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4081, 29933, to_date('10-12-1933', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1195, ' Bit', 2239);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4082, 7391.37, to_date('11-01-1999', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1094, ' Bank Transfer', 343);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4083, 23750.37, to_date('23-10-1988', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1371, ' Bank Transfer', 310);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4084, 23963.39, to_date('02-10-2017', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1019, ' Check', 379);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4085, 5996.44, to_date('22-03-1931', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1044, ' Cash', 279);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4086, 48917.48, to_date('01-02-1969', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1050, ' Bank Transfer', 116);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4087, 37455.4, to_date('23-07-1963', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1184, ' Check', 2258);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4088, 30138.19, to_date('28-08-1975', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1092, ' Cash', 45);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4089, 24369.49, to_date('02-11-1930', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1266, ' Cash', 57);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4090, 43053.09, to_date('21-07-1970', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1043, ' Cash', 2242);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4091, 38624.57, to_date('07-10-2017', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1226, ' Bit', 53);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4092, 21599.6, to_date('21-10-1960', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1007, ' PayPal', 380);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4094, 43254.24, to_date('06-02-1986', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1038, ' PayPal', 2311);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4095, 44470.03, to_date('22-12-1911', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1209, ' Check', 2183);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4096, 43124.47, to_date('03-11-2022', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1201, ' Check', 332);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4097, 36595.12, to_date('23-07-1919', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1123, ' Credit Card', 233);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4098, 37102.94, to_date('30-06-1958', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1163, ' Bit', 24);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4099, 30939.25, to_date('11-08-1958', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1275, ' Bit', 186);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4100, 44084.35, to_date('24-04-2011', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1311, ' Bank Transfer', 20);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4101, 12577.07, to_date('05-06-1953', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1361, ' Bank Transfer', 2169);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4102, 22244.69, to_date('08-04-1970', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1384, ' Credit Card', 2132);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4103, 8652.6, to_date('30-08-1951', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1273, ' PayPal', 91);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4104, 44383.05, to_date('27-05-2005', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1047, ' Check', 2101);
commit;
prompt 100 records committed...
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4105, 12002.35, to_date('15-07-1938', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1330, ' PayPal', 2350);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4106, 37325.95, to_date('29-05-1923', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1175, ' Credit Card', 359);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4107, 8840.77, to_date('16-05-1971', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1229, ' Credit Card', 2217);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4108, 30394.09, to_date('03-08-1993', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1070, ' Cash', 2003);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4109, 20508.4, to_date('25-05-2009', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1324, ' Cash', 178);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4110, 12931.67, to_date('21-01-1969', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1199, ' Cash', 2244);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4111, 24282.31, to_date('03-12-1938', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1026, ' Check', 2100);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4112, 30898.2, to_date('02-05-1928', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1062, ' PayPal', 2079);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4113, 23249.25, to_date('16-10-1918', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1133, ' Bit', 227);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4114, 27522.78, to_date('07-03-1937', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1379, ' Bit', 2386);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4116, 13020.87, to_date('15-10-1905', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1006, ' Cash', 2254);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4117, 35833.05, to_date('28-06-1967', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1312, ' PayPal', 114);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4118, 23373.66, to_date('10-04-2016', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1374, ' Bit', 26);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4119, 20403.95, to_date('23-02-1935', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1002, ' Bank Transfer', 342);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4121, 45259.54, to_date('29-11-1933', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1260, ' Cash', 212);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4122, 17509.7, to_date('09-01-1933', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1055, ' Check', 2273);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4124, 27972.39, to_date('26-11-1919', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1019, ' Bit', 258);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4126, 42644.75, to_date('14-01-2007', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1380, ' Check', 2321);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4127, 30827.94, to_date('18-10-1956', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1012, ' Check', 2117);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4128, 10213.33, to_date('02-06-1984', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1222, ' Bit', 78);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4129, 45222.54, to_date('26-01-1950', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1119, ' Credit Card', 307);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4131, 24014.36, to_date('24-06-1992', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1236, ' Cash', 178);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4132, 24771.97, to_date('26-09-2006', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1393, ' Credit Card', 356);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4133, 10154.04, to_date('23-02-1937', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1116, ' Cash', 150);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4134, 40834.67, to_date('20-10-1947', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1272, ' Check', 2020);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4136, 14559.93, to_date('09-09-1996', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1333, ' Check', 85);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4137, 27593.21, to_date('07-01-1951', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1202, ' Credit Card', 360);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4138, 31197.12, to_date('30-05-1910', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1259, ' Bank Transfer', 312);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4139, 6039.36, to_date('21-08-1994', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1133, ' Bit', 210);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4141, 45560.29, to_date('20-09-1978', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1313, ' Bank Transfer', 2188);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4142, 14048.75, to_date('09-05-1956', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1282, ' Bit', 2111);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4143, 33652.81, to_date('15-08-1917', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1200, ' PayPal', 363);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4144, 27256.36, to_date('27-07-1957', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1144, ' Check', 2294);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4146, 24608.3, to_date('07-01-1940', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1255, ' Bank Transfer', 124);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4148, 49586.67, to_date('06-12-1900', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1062, ' Bit', 2091);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4149, 16179.68, to_date('30-05-1982', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1094, ' Check', 2217);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4151, 32502.66, to_date('11-02-1915', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1010, ' Bit', 2115);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4152, 17864.99, to_date('12-03-1991', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1392, ' PayPal', 367);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4153, 8705.51, to_date('01-03-1930', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1000, ' Bit', 56);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4154, 47230.97, to_date('29-10-1922', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1262, ' Credit Card', 2290);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4156, 39226.55, to_date('24-01-2019', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1229, ' PayPal', 268);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4157, 8381.25, to_date('30-08-1944', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1154, ' Check', 2132);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4158, 45048.95, to_date('04-08-1954', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1105, ' Credit Card', 158);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4159, 13552.81, to_date('03-09-1929', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1321, ' Credit Card', 163);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4161, 22685.17, to_date('03-10-1963', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1103, ' Check', 2376);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4162, 13959.54, to_date('09-09-1973', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1068, ' PayPal', 282);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4163, 40658.58, to_date('18-03-1957', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1346, ' Cash', 2144);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4164, 23963.99, to_date('06-06-1956', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1101, ' Check', 374);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4166, 45123.88, to_date('25-06-1986', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1094, ' Credit Card', 167);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4167, 39441.82, to_date('26-02-2003', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1153, ' Credit Card', 49);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4168, 8646.49, to_date('28-04-2017', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1245, ' Bank Transfer', 78);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4171, 33398.85, to_date('27-04-1915', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1053, ' PayPal', 304);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4172, 15900.45, to_date('27-12-1927', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1267, ' Bit', 2202);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4173, 49335.09, to_date('17-07-1943', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1086, ' Bit', 2196);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4174, 39800.61, to_date('26-07-1920', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1152, ' Cash', 281);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4176, 10522.24, to_date('26-03-2002', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1030, ' Cash', 2048);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4177, 10078.82, to_date('11-04-2014', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1390, ' Credit Card', 2165);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4178, 19390.13, to_date('16-08-1920', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1331, ' Bit', 341);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4179, 29496.35, to_date('11-01-1989', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1313, ' Cash', 351);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4181, 7153.53, to_date('11-12-1935', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1351, ' Credit Card', 89);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4182, 20262.63, to_date('11-04-1931', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1221, ' Check', 2103);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4183, 10118.72, to_date('05-09-2019', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1067, ' Credit Card', 2374);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4184, 38715.96, to_date('07-09-1919', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1207, ' Cash', 141);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4186, 17959.1, to_date('17-01-1978', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1071, ' PayPal', 2083);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4187, 49753.68, to_date('20-02-2014', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1049, ' Bit', 4);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4188, 42354.26, to_date('14-08-1952', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1145, ' Bank Transfer', 2295);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4189, 29686.46, to_date('22-06-1923', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1079, ' Credit Card', 2147);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4190, 48709.02, to_date('10-05-1929', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1022, ' Check', 2137);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4191, 19011.83, to_date('27-10-1946', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1194, ' Cash', 2152);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4192, 35368.14, to_date('14-12-2012', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1220, ' PayPal', 2063);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4193, 6600.22, to_date('26-01-1983', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1033, ' Credit Card', 2146);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4194, 15367.85, to_date('19-03-1926', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1173, ' Cash', 141);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4195, 39739.09, to_date('08-07-1906', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1265, ' Credit Card', 2004);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4196, 28652.62, to_date('25-09-1929', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1142, ' Credit Card', 2293);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4197, 29631.03, to_date('19-06-1990', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1169, ' Check', 2363);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4198, 33354.51, to_date('21-11-1936', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1260, ' PayPal', 2096);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4199, 20954.25, to_date('31-01-1901', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1333, ' Cash', 2004);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4200, 36134.92, to_date('18-02-1949', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1292, ' PayPal', 2067);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4201, 25485.66, to_date('04-09-2011', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1086, ' Check', 114);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4202, 11588.91, to_date('14-08-1936', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1130, ' Cash', 320);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4203, 49786.43, to_date('18-02-1912', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1047, ' Check', 108);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4204, 15712, to_date('13-02-1914', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1202, ' Bank Transfer', 50);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4205, 46950, to_date('29-10-1988', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1202, ' Bit', 2074);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4206, 43429.44, to_date('13-04-1962', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1218, ' Bank Transfer', 2382);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4207, 17412.64, to_date('18-09-1949', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1311, ' Cash', 140);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4208, 35188.04, to_date('27-02-1944', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1228, ' Check', 2035);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4210, 32610.45, to_date('01-02-1917', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1018, ' Credit Card', 121);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4211, 9995.2, to_date('07-01-1982', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1160, ' PayPal', 2067);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4212, 33211.96, to_date('16-11-1989', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1022, ' Credit Card', 342);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4213, 23871.77, to_date('20-01-1913', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1041, ' Check', 87);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4214, 39179.79, to_date('09-04-2000', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1162, ' Bank Transfer', 2249);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4215, 24619.31, to_date('14-01-1990', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1034, ' Credit Card', 2054);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4216, 30214.89, to_date('11-10-2012', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1213, ' Bit', 2176);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4217, 48733.96, to_date('23-01-1992', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1161, ' Bit', 18);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4218, 40436.26, to_date('09-10-2011', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1093, ' Bit', 228);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4219, 45230.51, to_date('13-04-2022', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1253, ' Cash', 2105);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4220, 24347.7, to_date('29-11-1914', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1077, ' Bit', 2165);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4221, 29890.36, to_date('22-03-1900', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1227, ' Credit Card', 69);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4222, 6867.15, to_date('30-11-1906', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1140, ' Cash', 328);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4223, 28572.18, to_date('13-06-1999', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1291, ' PayPal', 370);
commit;
prompt 200 records committed...
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4224, 22418.47, to_date('29-07-1968', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1016, ' Credit Card', 166);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4225, 34584.85, to_date('23-06-1905', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1269, ' Bank Transfer', 2193);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4226, 23085.73, to_date('20-02-1976', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1393, ' Check', 39);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4228, 25830.03, to_date('26-12-1995', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1027, ' Cash', 2298);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4229, 36765.42, to_date('22-12-1979', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1385, ' Cash', 333);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4230, 48768.75, to_date('13-08-2024', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1379, ' Bit', 2362);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4231, 30034.8, to_date('04-06-1910', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1352, ' Bit', 2302);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4232, 16517.41, to_date('18-12-1923', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1184, ' Cash', 2336);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4233, 38021.64, to_date('10-10-1979', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1017, ' Cash', 2325);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4234, 39593.91, to_date('31-12-1926', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1336, ' Cash', 2342);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4235, 14069.3, to_date('13-10-1913', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1174, ' Bit', 2272);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4236, 32885.38, to_date('29-08-1963', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1309, ' Check', 2060);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4237, 8522.2, to_date('14-07-1949', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1022, ' Credit Card', 2336);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4238, 23177.43, to_date('31-01-1932', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1089, ' Bank Transfer', 8);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4239, 44536.35, to_date('14-07-1985', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1367, ' Check', 174);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4240, 20745.95, to_date('08-03-1915', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1047, ' Credit Card', 190);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4241, 7952.39, to_date('16-03-1927', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1351, ' Bit', 2377);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4242, 40011.46, to_date('30-06-1967', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1324, ' Bit', 2027);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4243, 46231.13, to_date('24-08-1977', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1105, ' Bank Transfer', 2132);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4244, 44255.83, to_date('06-05-1972', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1144, ' PayPal', 1);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4245, 36451.61, to_date('16-09-1998', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1123, ' Bit', 2123);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4246, 39401.66, to_date('16-05-1944', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1262, ' Cash', 2145);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4247, 12371.63, to_date('29-05-1942', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1169, ' Check', 362);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4248, 46853.98, to_date('20-04-1902', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1118, ' Check', 2072);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4249, 20550.83, to_date('15-08-1977', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1099, ' Cash', 2234);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4250, 45404.65, to_date('28-01-1937', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1136, ' Bit', 2115);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4251, 35536.2, to_date('11-02-1937', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1219, ' Check', 159);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4252, 17199.07, to_date('11-04-1975', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1335, ' Check', 2327);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4253, 24110.15, to_date('17-11-1959', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1358, ' Credit Card', 332);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4254, 7765.54, to_date('10-11-1987', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1068, ' Credit Card', 7);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4255, 23601.05, to_date('04-10-1953', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1071, ' Check', 2077);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4256, 20107, to_date('21-03-2019', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1087, ' Bank Transfer', 130);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4257, 9256.28, to_date('11-06-2003', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1370, ' Credit Card', 12);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4258, 12855.4, to_date('17-07-1911', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1137, ' Check', 149);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4259, 45677.74, to_date('14-09-1973', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1171, ' Bit', 2123);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4261, 47319.99, to_date('01-01-1933', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1274, ' Cash', 321);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4262, 44608.79, to_date('30-03-1975', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1061, ' Bit', 190);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4263, 48050.68, to_date('21-05-2022', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1068, ' Bit', 276);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4264, 49286.14, to_date('24-08-1948', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1029, ' Cash', 2245);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4265, 34773.69, to_date('01-09-2019', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1153, ' Credit Card', 22);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4266, 15461.24, to_date('04-01-1953', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1069, ' Cash', 2268);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4267, 20114.62, to_date('26-12-1973', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1095, ' Cash', 321);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4268, 9412.79, to_date('07-12-2020', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1095, ' Bit', 377);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4269, 39168.88, to_date('16-08-1910', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1104, ' Cash', 2306);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4270, 22286.75, to_date('23-07-1930', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1176, ' Bit', 342);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4271, 25312.18, to_date('23-02-1981', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1236, ' Bit', 219);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4272, 21688.15, to_date('23-02-1922', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1398, ' Bank Transfer', 261);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4273, 15073.65, to_date('13-11-1933', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1320, ' Bank Transfer', 2386);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4274, 17335.33, to_date('04-12-1984', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1258, ' PayPal', 236);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4275, 7071.32, to_date('16-08-1904', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1208, ' PayPal', 284);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4276, 5776.77, to_date('05-04-1964', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1374, ' PayPal', 324);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4277, 15010.21, to_date('08-11-1902', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1358, ' Credit Card', 246);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4278, 19170.41, to_date('03-03-1989', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1128, ' PayPal', 172);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4279, 44742.86, to_date('01-01-1993', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1332, ' Bit', 140);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4280, 8125.41, to_date('06-02-1970', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1031, ' Check', 321);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4281, 40392.37, to_date('17-03-1921', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1022, ' Check', 288);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4282, 8606.45, to_date('22-01-1917', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1011, ' Cash', 271);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4283, 24537.96, to_date('11-05-1937', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1008, ' Bank Transfer', 287);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4284, 7900.55, to_date('16-01-1953', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1028, ' Credit Card', 342);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4285, 27463.02, to_date('24-05-1937', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1231, ' Bank Transfer', 108);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4286, 49646.36, to_date('07-10-2022', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1215, ' PayPal', 128);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4287, 30465.64, to_date('21-12-1925', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1194, ' Check', 178);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4288, 37925.92, to_date('16-09-1921', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1145, ' Check', 2319);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4289, 13231.67, to_date('02-06-1924', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1295, ' Check', 176);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4291, 15270.26, to_date('01-01-1949', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1275, ' PayPal', 102);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4292, 35619.95, to_date('25-08-1934', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1163, ' Bit', 83);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4293, 31411.93, to_date('06-07-1934', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1395, ' Credit Card', 174);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4294, 19116.81, to_date('11-05-2014', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1115, ' Bank Transfer', 2011);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4295, 11369.06, to_date('03-03-1978', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1142, ' Cash', 2289);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4296, 8933.31, to_date('06-01-1905', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1338, ' Check', 125);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4297, 8359.01, to_date('24-10-1903', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1053, ' Credit Card', 2398);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4298, 49933.06, to_date('27-09-1927', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1337, ' Bit', 369);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4299, 26789.6, to_date('14-06-2021', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1268, ' Check', 2088);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4300, 22286.39, to_date('11-04-1905', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1271, ' Credit Card', 2080);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4301, 19007.22, to_date('22-01-1957', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1208, ' Cash', 2395);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4302, 38999.61, to_date('17-04-1933', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1087, ' Bit', 2035);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4304, 47506.83, to_date('20-11-1971', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1190, ' Bank Transfer', 2217);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4305, 47807.47, to_date('12-04-1962', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1092, ' Bit', 2386);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4306, 30324.25, to_date('22-06-2007', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1031, ' Bit', 2174);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4307, 31382.97, to_date('02-09-1941', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1128, ' Bit', 2271);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4309, 19664.78, to_date('19-06-1960', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1105, ' Credit Card', 2137);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4310, 21728.25, to_date('01-04-1985', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1172, ' Bank Transfer', 2291);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4311, 13100.19, to_date('12-01-2008', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1382, ' Check', 2221);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4314, 40783.85, to_date('21-10-1989', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1325, ' Cash', 2174);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4315, 16102.96, to_date('20-09-1951', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1080, ' Check', 2165);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4316, 28444.34, to_date('21-07-1917', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1264, ' PayPal', 2184);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4317, 10066.14, to_date('26-09-1917', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1005, ' Cash', 2227);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4319, 30533.11, to_date('19-04-1907', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1119, ' PayPal', 211);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4320, 40367.41, to_date('23-11-1932', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1298, ' PayPal', 47);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4321, 39128.22, to_date('15-11-1940', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1004, ' PayPal', 2386);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4322, 21518.79, to_date('27-02-1966', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1234, ' Bank Transfer', 2214);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4324, 22216.83, to_date('28-09-1945', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1234, ' Cash', 213);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4325, 49158.43, to_date('17-06-1944', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1108, ' Check', 104);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4326, 15535, to_date('18-07-1992', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1150, ' Check', 2157);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4327, 36357.14, to_date('29-12-2018', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1033, ' Credit Card', 182);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4329, 41394.78, to_date('03-09-1904', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1077, ' Bank Transfer', 237);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4330, 28751.59, to_date('10-04-2014', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1151, ' Bit', 2143);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4331, 37961.43, to_date('18-11-1984', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1352, ' Cash', 310);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4332, 13498.4, to_date('14-01-1936', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1346, ' Bit', 142);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4334, 26558.19, to_date('14-11-1915', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1232, ' Check', 19);
commit;
prompt 300 records committed...
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4335, 43288.93, to_date('07-08-1941', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1051, ' PayPal', 2252);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4336, 17694.18, to_date('24-03-1946', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1331, ' Cash', 2398);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4337, 8771.05, to_date('22-11-1909', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1028, ' Bank Transfer', 158);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4339, 33033.25, to_date('28-06-2017', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1325, ' PayPal', 43);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4340, 43218.59, to_date('13-10-2003', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1393, ' Bank Transfer', 261);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4342, 45317.34, to_date('10-03-1908', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1002, ' PayPal', 101);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4344, 27534.03, to_date('06-11-1917', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1321, ' Bank Transfer', 2094);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4345, 14618.21, to_date('22-04-2022', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1060, ' Bank Transfer', 152);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4346, 27679.05, to_date('24-05-1943', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1090, ' Credit Card', 2389);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4347, 14098.4, to_date('25-11-1908', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1093, ' Bit', 2006);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4349, 32036.71, to_date('13-11-1985', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1240, ' Bank Transfer', 2096);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4350, 24324.06, to_date('26-10-1981', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1007, ' Credit Card', 2250);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4351, 5170.68, to_date('13-12-2013', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1105, ' Check', 2214);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4354, 36896.9, to_date('14-07-1911', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1206, ' Bank Transfer', 2121);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4355, 42037.62, to_date('26-07-1926', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1284, ' Check', 2252);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4356, 39271.26, to_date('14-02-1952', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1186, ' Credit Card', 316);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4357, 25676.67, to_date('23-10-1922', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1370, ' Check', 2025);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4359, 14382.09, to_date('25-01-2011', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1001, ' Cash', 2210);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4360, 16831.69, to_date('03-03-2015', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1382, ' PayPal', 17);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4361, 36498.2, to_date('19-09-1919', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1184, ' PayPal', 115);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4362, 17659, to_date('09-09-2000', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1119, ' Check', 3);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4364, 15040.98, to_date('15-07-1932', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1228, ' Credit Card', 2280);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4365, 21727.65, to_date('22-10-2020', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1318, ' PayPal', 191);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4366, 28204.67, to_date('18-11-1978', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1220, ' Bank Transfer', 256);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4369, 25581.56, to_date('05-03-1924', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1087, ' PayPal', 2243);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4370, 21266.01, to_date('01-04-1970', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1327, ' Bit', 83);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4371, 15889.35, to_date('17-10-1935', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1058, ' Bit', 2128);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4373, 32730.56, to_date('27-11-2000', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1371, ' Bank Transfer', 2071);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4374, 43179.9, to_date('04-08-1983', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1027, ' PayPal', 2342);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4375, 43241.9, to_date('26-03-2021', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1381, ' PayPal', 239);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4376, 14655.6, to_date('21-06-1936', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1116, ' Bit', 294);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4377, 44236.9, to_date('25-09-1974', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1093, ' Bank Transfer', 2106);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4378, 35034.21, to_date('30-11-1940', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1314, ' Bit', 2149);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4379, 22391.46, to_date('18-08-1987', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1107, ' Cash', 207);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4380, 17027.55, to_date('22-02-1959', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1007, ' Bank Transfer', 2040);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4381, 18491.91, to_date('28-09-1976', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1296, ' Check', 2186);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4382, 43605.31, to_date('20-02-1982', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1070, ' Credit Card', 2355);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4383, 25745.51, to_date('17-02-1987', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1012, ' Check', 2208);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4384, 37086.86, to_date('06-09-1933', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1127, ' Credit Card', 184);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4385, 37153.54, to_date('21-01-1975', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1212, ' Bank Transfer', 70);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4386, 27295.52, to_date('29-09-2019', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1140, ' Bank Transfer', 2067);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4387, 16946.84, to_date('03-04-1911', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1307, ' Credit Card', 173);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4388, 28775.4, to_date('15-02-2023', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1328, ' Cash', 109);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4389, 21083.84, to_date('10-07-1954', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1143, ' Check', 2183);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4390, 22070.65, to_date('25-06-1918', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1203, ' Bit', 2366);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4391, 16811.12, to_date('07-08-1945', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1303, ' Cash', 2190);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4392, 39067.28, to_date('13-08-1932', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1337, ' PayPal', 2103);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4393, 31286.45, to_date('26-05-1971', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1333, ' Credit Card', 2173);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4394, 37397.47, to_date('31-01-1925', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1051, ' Cash', 2118);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4395, 44264.35, to_date('06-07-1999', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1095, ' Bit', 147);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4396, 13906.34, to_date('15-02-1964', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1229, ' Check', 2193);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4397, 29844.12, to_date('15-01-1958', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1243, ' PayPal', 49);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4398, 42181.25, to_date('28-11-1972', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1060, ' PayPal', 2237);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4399, 12280.4, to_date('08-10-2010', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1230, ' Credit Card', 2327);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4115, 40241.12, to_date('19-02-1921', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1278, ' Bit', 2210);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4120, 48169.79, to_date('17-06-1970', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1256, ' PayPal', 2162);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4125, 40857.55, to_date('02-11-2003', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1293, ' Credit Card', 236);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4130, 43118.64, to_date('24-06-1955', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1267, ' PayPal', 2387);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4135, 14130.33, to_date('01-06-1975', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1353, ' Check', 2050);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4140, 46458.54, to_date('03-12-1935', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1192, ' PayPal', 2027);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4145, 34092.13, to_date('29-01-1938', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1078, ' PayPal', 2306);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4150, 29407.98, to_date('22-10-2011', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1028, ' Bit', 2169);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4155, 45238.54, to_date('24-12-1983', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1350, ' Check', 288);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4160, 49463.82, to_date('07-07-2020', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1192, ' Credit Card', 2292);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4165, 10799.63, to_date('05-07-2004', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1266, ' Bit', 2370);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4170, 45704.04, to_date('14-10-1943', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1041, ' Bit', 197);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4175, 7573.85, to_date('26-06-2007', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1208, ' Credit Card', 379);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4180, 30652.97, to_date('08-07-1947', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1098, ' Bank Transfer', 319);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4185, 42324.59, to_date('22-01-1942', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1248, ' Credit Card', 231);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4303, 31107.31, to_date('07-10-1927', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1178, ' Cash', 339);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4308, 39766.96, to_date('17-12-1909', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1221, ' Bank Transfer', 2272);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4313, 10875.77, to_date('14-04-1970', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1289, ' Credit Card', 2158);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4318, 40751.8, to_date('23-03-1987', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1192, ' Bank Transfer', 295);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4323, 27767.83, to_date('21-09-1998', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1026, ' Cash', 379);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4328, 39951.1, to_date('29-11-1924', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1019, ' Cash', 113);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4333, 8154.42, to_date('19-10-1923', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1093, ' Cash', 2154);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4338, 9720.41, to_date('19-03-1948', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1251, ' Cash', 2396);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4343, 33810.81, to_date('14-09-1978', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1179, ' Cash', 62);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4348, 20822.61, to_date('21-02-1938', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1154, ' PayPal', 2010);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4353, 34563.11, to_date('07-04-1950', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1257, ' PayPal', 228);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4358, 32105.55, to_date('24-05-2010', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1177, ' Bank Transfer', 2347);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4363, 12497.28, to_date('30-12-1917', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1008, ' Bit', 311);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4367, 43224.23, to_date('13-11-2013', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1115, ' Check', 2384);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4372, 48123.85, to_date('20-01-1940', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1001, ' Credit Card', 20);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4015, 14802.27, to_date('11-09-2007', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1321, ' Credit Card', 16);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4026, 41965.12, to_date('04-04-1975', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1160, ' PayPal', 2081);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4047, 18724.23, to_date('04-03-1975', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1146, ' Bank Transfer', 219);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4066, 20170.27, to_date('25-08-1944', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1346, ' Bank Transfer', 205);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4093, 21998.17, to_date('12-01-2016', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1336, ' Credit Card', 339);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4123, 27817.9, to_date('03-02-2003', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1295, ' Bank Transfer', 2206);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4147, 10867.38, to_date('21-12-1944', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1106, ' Credit Card', 139);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4169, 49548.58, to_date('29-11-1967', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1001, ' Bank Transfer', 2318);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4209, 33826.51, to_date('29-10-1919', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1228, ' Credit Card', 79);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4227, 25123.08, to_date('11-02-2019', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1054, ' Bank Transfer', 2137);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4260, 47488.41, to_date('05-07-1974', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1064, ' Bank Transfer', 2090);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4290, 5419.02, to_date('10-07-2020', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1014, ' Bank Transfer', 2328);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4312, 13521.36, to_date('01-01-1973', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1062, ' PayPal', 2047);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4341, 20532.5, to_date('01-07-2006', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1323, ' Credit Card', 2091);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4352, 36923.66, to_date('10-08-1934', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1255, ' Credit Card', 2227);
insert into PAYMENTS (paymentid, totalprice, paymentdate, paymentdeadlinedate, customerid, paymenttype, eventid)
values (4368, 31742.38, to_date('06-01-1977', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1132, ' Bank Transfer', 2300);
commit;
prompt 400 records loaded
prompt Enabling foreign key constraints for EVENTS...
alter table EVENTS enable constraint SYS_C007299;
alter table EVENTS enable constraint SYS_FKC2;
alter table EVENTS enable constraint SYS_FKP2;
alter table EVENTS enable constraint SYS_FKS2;
prompt Enabling foreign key constraints for GUESTS...
alter table GUESTS enable constraint SYS_C007345;
prompt Enabling foreign key constraints for HAS_CATERING...
alter table HAS_CATERING enable constraint SYS_C007312;
alter table HAS_CATERING enable constraint SYS_C007313;
prompt Enabling foreign key constraints for INSTRUMENT_EVENT...
alter table INSTRUMENT_EVENT enable constraint SYS_FKE1;
alter table INSTRUMENT_EVENT enable constraint SYS_FKI;
prompt Enabling foreign key constraints for PAYMENTS...
alter table PAYMENTS enable constraint SYS_FKC1;
alter table PAYMENTS enable constraint SYS_FKE;
prompt Enabling triggers for CATERING...
alter table CATERING enable all triggers;
prompt Enabling triggers for CUSTOMER...
alter table CUSTOMER enable all triggers;
prompt Enabling triggers for PRODUCER...
alter table PRODUCER enable all triggers;
prompt Enabling triggers for SINGER...
alter table SINGER enable all triggers;
prompt Enabling triggers for VENUES...
alter table VENUES enable all triggers;
prompt Enabling triggers for EVENTS...
alter table EVENTS enable all triggers;
prompt Enabling triggers for GUESTS...
alter table GUESTS enable all triggers;
prompt Enabling triggers for HAS_CATERING...
alter table HAS_CATERING enable all triggers;
prompt Enabling triggers for INSTRUMENT...
alter table INSTRUMENT enable all triggers;
prompt Enabling triggers for INSTRUMENT_EVENT...
alter table INSTRUMENT_EVENT enable all triggers;
prompt Enabling triggers for PAYMENTS...
alter table PAYMENTS enable all triggers;
set feedback on
set define on
prompt Done.
