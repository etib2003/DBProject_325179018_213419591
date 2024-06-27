prompt PL/SQL Developer import file
prompt Created on יום חמישי 27 יוני 2024 by אתוש
set feedback off
set define off
prompt Creating CUSTOMER...
create table CUSTOMER
(
  customer_id NUMBER(5) not null,
  name        VARCHAR2(15) not null,
  email       VARCHAR2(15) not null,
  address     VARCHAR2(15) not null
)
;
alter table CUSTOMER
  add primary key (CUSTOMER_ID);
alter table CUSTOMER
  add constraint EMAIL_FORMET
  check (email LIKE '%@%');

prompt Creating PAYMENT_TYPE...
create table PAYMENT_TYPE
(
  payment_id NUMBER(5) not null,
  ptype      VARCHAR2(15) not null
)
;
alter table PAYMENT_TYPE
  add primary key (PAYMENT_ID);

prompt Creating PRODUCER...
create table PRODUCER
(
  producer_id   NUMBER(5) not null,
  producer_name VARCHAR2(15) not null,
  price         NUMBER(5) default 5000 not null
)
;
alter table PRODUCER
  add primary key (PRODUCER_ID);

prompt Creating SINGER...
create table SINGER
(
  sname     VARCHAR2(15) not null,
  singer_id NUMBER(5) not null,
  price     NUMBER(5) not null
)
;
alter table SINGER
  add primary key (SINGER_ID);
alter table SINGER
  add constraint MINIMUM_COST
  check (price>1000 and price<12000);

prompt Creating EVENT...
create table EVENT
(
  event_date   DATE not null,
  location     VARCHAR2(15) not null,
  total_price_ NUMBER(5) not null,
  event_id     NUMBER(5) not null,
  producer_id  NUMBER(5) not null,
  singer_id    NUMBER(5) not null,
  customer_id  NUMBER(5) not null,
  payment_id   NUMBER(5) not null
)
;
alter table EVENT
  add primary key (EVENT_ID);
alter table EVENT
  add constraint UNIQUE_SINGER_DATE unique (SINGER_ID, EVENT_DATE);
alter table EVENT
  add foreign key (PRODUCER_ID)
  references PRODUCER (PRODUCER_ID) on delete cascade;
alter table EVENT
  add foreign key (CUSTOMER_ID)
  references CUSTOMER (CUSTOMER_ID) on delete cascade;
alter table EVENT
  add foreign key (PAYMENT_ID)
  references PAYMENT_TYPE (PAYMENT_ID) on delete cascade;
alter table EVENT
  add foreign key (SINGER_ID)
  references SINGER (SINGER_ID) on delete cascade;

prompt Creating INSTRUMENT...
create table INSTRUMENT
(
  instrument_name VARCHAR2(15) not null,
  price           NUMBER(5) not null,
  instrument_id   NUMBER(5) not null
)
;
alter table INSTRUMENT
  add primary key (INSTRUMENT_ID);

prompt Creating INSTRUMENT_EVENT...
create table INSTRUMENT_EVENT
(
  instrument_id NUMBER(5) not null,
  event_id      NUMBER(5) not null
)
;
alter table INSTRUMENT_EVENT
  add primary key (INSTRUMENT_ID, EVENT_ID);
alter table INSTRUMENT_EVENT
  add foreign key (INSTRUMENT_ID)
  references INSTRUMENT (INSTRUMENT_ID);
alter table INSTRUMENT_EVENT
  add foreign key (EVENT_ID)
  references EVENT (EVENT_ID) on delete cascade;

prompt Disabling triggers for CUSTOMER...
alter table CUSTOMER disable all triggers;
prompt Disabling triggers for PAYMENT_TYPE...
alter table PAYMENT_TYPE disable all triggers;
prompt Disabling triggers for PRODUCER...
alter table PRODUCER disable all triggers;
prompt Disabling triggers for SINGER...
alter table SINGER disable all triggers;
prompt Disabling triggers for EVENT...
alter table EVENT disable all triggers;
prompt Disabling triggers for INSTRUMENT...
alter table INSTRUMENT disable all triggers;
prompt Disabling triggers for INSTRUMENT_EVENT...
alter table INSTRUMENT_EVENT disable all triggers;
prompt Disabling foreign key constraints for EVENT...
alter table EVENT disable constraint SYS_C007145;
alter table EVENT disable constraint SYS_C007146;
alter table EVENT disable constraint SYS_C007147;
alter table EVENT disable constraint SYS_C007148;
prompt Disabling foreign key constraints for INSTRUMENT_EVENT...
alter table INSTRUMENT_EVENT disable constraint SYS_C007112;
alter table INSTRUMENT_EVENT disable constraint SYS_C007149;
prompt Deleting INSTRUMENT_EVENT...
delete from INSTRUMENT_EVENT;
commit;
prompt Deleting INSTRUMENT...
delete from INSTRUMENT;
commit;
prompt Deleting EVENT...
delete from EVENT;
commit;
prompt Deleting SINGER...
delete from SINGER;
commit;
prompt Deleting PRODUCER...
delete from PRODUCER;
commit;
prompt Deleting PAYMENT_TYPE...
delete from PAYMENT_TYPE;
commit;
prompt Deleting CUSTOMER...
delete from CUSTOMER;
commit;
prompt Loading CUSTOMER...
insert into CUSTOMER (customer_id, name, email, address)
values (101, ' Alice Brown', ' alice@ex.com', ' 123 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (102, ' Bob Smith', ' bob@ex.com', ' 456 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (103, ' Carol Johnson', ' carol@ex.com', ' 789 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (104, ' David Wilson', ' david@ex.com', ' 321 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (105, ' Eve Davis', ' eve@ex.com', ' 654 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (106, ' Frank Miller', ' frank@ex.com', ' 987 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (107, ' Grace Lee', ' grace@ex.com', ' 111 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (108, ' Henry Clark', ' henry@ex.com', ' 222 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (109, ' Irene Lewis', ' irene@ex.com', ' 333 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (110, ' Jack Walker', ' jack@ex.com', ' 444 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (111, 'Dan Smith', 'dan.s@email.com', '85 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (112, 'Jane Wilson', 'jane.@mail.com', '44 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (113, 'Carol Brown', 'carol@ex.com', '64 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (114, 'Jane Johnson', 'jane.@ex.com', '779 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (115, 'Eve Jones', 'eve.j@site.com', '922 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (116, 'Alice Davis', 'alice@email.com', '325 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (117, 'Alice Smith', 'alice@site.com', '341 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (118, 'Alice Williams', 'alice@email.com', '889 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (119, 'Carol Garcia', 'carol@ex.com', '385 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (120, 'Alice Williams', 'alice@web.com', '946 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (121, 'Bob Johnson', 'bob.j@email.com', '862 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (122, 'Carol Smith', 'carol@mail.com', '233 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (123, 'Frank Jones', 'frank@ex.com', '509 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (124, 'Alice Miller', 'alice@site.com', '126 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (125, 'Dan Smith', 'dan.s@ex.com', '986 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (126, 'Jane Jones', 'jane.@email.com', '926 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (127, 'John Wilson', 'john.@email.com', '483 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (128, 'Eve Garcia', 'eve.g@ex.com', '482 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (129, 'Dan Johnson', 'dan.j@ex.com', '893 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (130, 'Eve Davis', 'eve.d@site.com', '722 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (131, 'Frank Williams', 'frank@web.com', '914 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (132, 'Alice Brown', 'alice@ex.com', '893 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (133, 'Jane Brown', 'jane.@email.com', '78 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (134, 'John Smith', 'john.@mail.com', '382 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (135, 'Jane Davis', 'jane.@ex.com', '268 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (136, 'John Wilson', 'john.@mail.com', '945 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (137, 'Alice Doe', 'alice@mail.com', '218 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (138, 'Grace Johnson', 'grace@email.com', '646 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (139, 'Henry Davis', 'henry@mail.com', '289 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (140, 'Dan Brown', 'dan.b@email.com', '214 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (141, 'Carol Davis', 'carol@email.com', '286 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (142, 'Frank Davis', 'frank@email.com', '603 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (143, 'Jane Williams', 'jane.@web.com', '135 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (144, 'Henry Garcia', 'henry@site.com', '290 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (145, 'Frank Brown', 'frank@site.com', '735 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (146, 'Carol Davis', 'carol@ex.com', '3 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (147, 'Henry Williams', 'henry@ex.com', '134 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (148, 'Carol Brown', 'carol@web.com', '49 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (149, 'Dan Davis', 'dan.d@ex.com', '91 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (150, 'Henry Williams', 'henry@mail.com', '54 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (151, 'Alice Wilson', 'alice@site.com', '580 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (152, 'Frank Jones', 'frank@email.com', '704 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (153, 'Frank Garcia', 'frank@web.com', '998 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (154, 'Dan Garcia', 'dan.g@email.com', '81 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (155, 'Frank Garcia', 'frank@ex.com', '408 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (156, 'John Williams', 'john.@mail.com', '92 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (157, 'Grace Garcia', 'grace@ex.com', '937 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (158, 'John Brown', 'john.@ex.com', '814 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (159, 'Alice Davis', 'alice@ex.com', '683 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (160, 'Eve Wilson', 'eve.w@web.com', '769 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (161, 'John Johnson', 'john.@email.com', '795 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (162, 'Frank Smith', 'frank@web.com', '756 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (163, 'Carol Garcia', 'carol@mail.com', '231 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (164, 'Dan Miller', 'dan.m@web.com', '799 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (165, 'Grace Garcia', 'grace@email.com', '22 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (166, 'Jane Doe', 'jane.@ex.com', '868 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (167, 'Alice Williams', 'alice@mail.com', '408 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (168, 'Henry Smith', 'henry@web.com', '156 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (169, 'Eve Miller', 'eve.m@mail.com', '860 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (170, 'Bob Davis', 'bob.d@mail.com', '199 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (171, 'Alice Garcia', 'alice@email.com', '370 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (172, 'Henry Miller', 'henry@mail.com', '849 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (173, 'Henry Smith', 'henry@web.com', '190 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (174, 'Carol Jones', 'carol@ex.com', '377 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (175, 'Grace Smith', 'grace@mail.com', '609 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (176, 'Henry Jones', 'henry@web.com', '530 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (177, 'Frank Johnson', 'frank@mail.com', '244 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (178, 'Eve Miller', 'eve.m@site.com', '188 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (179, 'Jane Brown', 'jane.@email.com', '8 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (180, 'Bob Smith', 'bob.s@site.com', '908 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (181, 'Alice Smith', 'alice@email.com', '570 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (182, 'Eve Davis', 'eve.d@web.com', '573 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (183, 'Henry Williams', 'henry@mail.com', '61 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (184, 'Jane Brown', 'jane.@web.com', '859 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (185, 'Alice Doe', 'alice@ex.com', '461 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (186, 'Bob Miller', 'bob.m@ex.com', '168 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (187, 'John Miller', 'john.@web.com', '591 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (188, 'Carol Johnson', 'carol@ex.com', '514 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (189, 'Frank Smith', 'frank@web.com', '75 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (190, 'Frank Garcia', 'frank@web.com', '832 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (191, 'Grace Wilson', 'grace@web.com', '404 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (192, 'Frank Wilson', 'frank@site.com', '625 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (193, 'Bob Williams', 'bob.w@mail.com', '469 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (194, 'Carol Williams', 'carol@ex.com', '428 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (195, 'Eve Williams', 'eve.w@web.com', '718 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (196, 'John Jones', 'john.@web.com', '525 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (197, 'Carol Smith', 'carol@ex.com', '418 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (198, 'Carol Garcia', 'carol@email.com', '323 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (199, 'Carol Williams', 'carol@ex.com', '726 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (200, 'Jane Johnson', 'jane.@web.com', '4 Oak St');
commit;
prompt 100 records committed...
insert into CUSTOMER (customer_id, name, email, address)
values (201, 'John Brown', 'john.@web.com', '761 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (202, 'John Williams', 'john.@ex.com', '635 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (203, 'Jane Davis', 'jane.@email.com', '997 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (204, 'Grace Smith', 'grace@email.com', '181 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (205, 'Frank Jones', 'frank@site.com', '899 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (206, 'Bob Jones', 'bob.j@web.com', '427 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (207, 'Grace Smith', 'grace@email.com', '200 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (208, 'John Johnson', 'john.@ex.com', '791 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (209, 'Frank Garcia', 'frank@email.com', '841 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (210, 'Carol Williams', 'carol@ex.com', '586 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (211, 'Carol Brown', 'carol@site.com', '630 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (212, 'Frank Brown', 'frank@email.com', '771 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (213, 'Grace Davis', 'grace@web.com', '757 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (214, 'Bob Wilson', 'bob.w@mail.com', '59 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (215, 'Eve Brown', 'eve.b@email.com', '260 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (216, 'Alice Davis', 'alice@web.com', '400 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (217, 'John Garcia', 'john.@web.com', '354 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (218, 'Bob Smith', 'bob.s@web.com', '341 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (219, 'Carol Jones', 'carol@mail.com', '114 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (220, 'John Miller', 'john.@ex.com', '863 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (221, 'Alice Smith', 'alice@mail.com', '777 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (222, 'Henry Brown', 'henry@ex.com', '383 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (223, 'Alice Brown', 'alice@site.com', '951 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (224, 'Dan Davis', 'dan.d@email.com', '258 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (225, 'John Miller', 'john.@ex.com', '895 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (226, 'John Brown', 'john.@mail.com', '662 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (227, 'Grace Garcia', 'grace@web.com', '142 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (228, 'Carol Garcia', 'carol@site.com', '873 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (229, 'Jane Miller', 'jane.@site.com', '150 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (230, 'Eve Garcia', 'eve.g@ex.com', '473 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (231, 'Eve Williams', 'eve.w@mail.com', '171 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (232, 'Carol Johnson', 'carol@web.com', '700 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (233, 'Carol Davis', 'carol@mail.com', '192 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (234, 'Jane Jones', 'jane.@web.com', '694 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (235, 'Bob Miller', 'bob.m@ex.com', '258 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (236, 'Eve Doe', 'eve.d@mail.com', '989 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (237, 'Alice Brown', 'alice@web.com', '704 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (238, 'Jane Garcia', 'jane.@ex.com', '917 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (239, 'Jane Davis', 'jane.@web.com', '252 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (240, 'Grace Jones', 'grace@web.com', '186 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (241, 'Eve Miller', 'eve.m@mail.com', '215 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (242, 'Dan Davis', 'dan.d@mail.com', '678 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (243, 'Frank Smith', 'frank@email.com', '279 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (244, 'Eve Johnson', 'eve.j@site.com', '160 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (245, 'Grace Jones', 'grace@web.com', '41 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (246, 'Grace Jones', 'grace@mail.com', '331 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (247, 'Dan Johnson', 'dan.j@site.com', '415 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (248, 'Henry Miller', 'henry@ex.com', '149 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (249, 'Bob Davis', 'bob.d@mail.com', '944 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (250, 'John Miller', 'john.@site.com', '516 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (251, 'Carol Jones', 'carol@mail.com', '26 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (252, 'Henry Davis', 'henry@site.com', '509 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (253, 'Grace Miller', 'grace@mail.com', '156 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (254, 'Eve Miller', 'eve.m@email.com', '642 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (255, 'Grace Brown', 'grace@web.com', '146 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (256, 'Alice Brown', 'alice@web.com', '681 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (257, 'Alice Doe', 'alice@mail.com', '664 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (258, 'Dan Wilson', 'dan.w@site.com', '89 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (259, 'Bob Williams', 'bob.w@mail.com', '247 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (260, 'Henry Miller', 'henry@ex.com', '583 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (261, 'Frank Smith', 'frank@ex.com', '387 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (262, 'Grace Williams', 'grace@ex.com', '787 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (263, 'Bob Miller', 'bob.m@web.com', '400 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (264, 'Henry Smith', 'henry@mail.com', '28 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (265, 'Henry Miller', 'henry@mail.com', '821 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (266, 'John Garcia', 'john.@ex.com', '362 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (267, 'Eve Doe', 'eve.d@mail.com', '484 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (268, 'John Doe', 'john.@mail.com', '202 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (269, 'Eve Johnson', 'eve.j@mail.com', '70 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (270, 'Jane Smith', 'jane.@web.com', '373 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (271, 'Eve Jones', 'eve.j@mail.com', '193 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (272, 'Eve Brown', 'eve.b@mail.com', '652 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (273, 'Grace Brown', 'grace@web.com', '402 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (274, 'Dan Doe', 'dan.d@site.com', '506 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (275, 'Henry Wilson', 'henry@web.com', '451 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (276, 'Eve Doe', 'eve.d@mail.com', '434 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (277, 'Grace Johnson', 'grace@site.com', '208 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (278, 'Frank Miller', 'frank@email.com', '554 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (279, 'Carol Davis', 'carol@ex.com', '781 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (280, 'Eve Garcia', 'eve.g@email.com', '688 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (281, 'Carol Johnson', 'carol@email.com', '283 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (282, 'Dan Wilson', 'dan.w@email.com', '478 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (283, 'Bob Doe', 'bob.d@site.com', '434 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (284, 'Bob Williams', 'bob.w@email.com', '311 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (285, 'Henry Miller', 'henry@web.com', '539 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (286, 'Frank Jones', 'frank@web.com', '499 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (287, 'Henry Johnson', 'henry@ex.com', '305 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (288, 'Eve Brown', 'eve.b@ex.com', '13 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (289, 'Jane Williams', 'jane.@ex.com', '627 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (290, 'Alice Johnson', 'alice@email.com', '665 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (291, 'Bob Davis', 'bob.d@mail.com', '921 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (292, 'John Smith', 'john.@mail.com', '444 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (293, 'Dan Brown', 'dan.b@site.com', '719 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (294, 'Henry Garcia', 'henry@mail.com', '605 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (295, 'Grace Doe', 'grace@site.com', '415 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (296, 'Jane Williams', 'jane.@web.com', '791 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (297, 'Carol Miller', 'carol@email.com', '649 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (298, 'John Wilson', 'john.@site.com', '432 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (299, 'John Miller', 'john.@web.com', '257 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (300, 'Dan Brown', 'dan.b@email.com', '525 Pine St');
commit;
prompt 200 records committed...
insert into CUSTOMER (customer_id, name, email, address)
values (301, 'Henry Wilson', 'henry@email.com', '947 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (302, 'Grace Wilson', 'grace@ex.com', '361 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (303, 'Carol Smith', 'carol@site.com', '689 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (304, 'Henry Johnson', 'henry@web.com', '514 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (305, 'John Brown', 'john.@ex.com', '931 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (306, 'Carol Garcia', 'carol@ex.com', '885 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (307, 'John Wilson', 'john.@web.com', '711 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (308, 'Jane Doe', 'jane.@site.com', '363 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (309, 'Grace Brown', 'grace@web.com', '536 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (310, 'Alice Doe', 'alice@email.com', '589 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (311, 'Jane Wilson', 'jane.@mail.com', '813 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (312, 'Carol Doe', 'carol@site.com', '383 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (313, 'Dan Doe', 'dan.d@site.com', '459 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (314, 'Frank Davis', 'frank@ex.com', '463 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (315, 'Frank Doe', 'frank@email.com', '856 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (316, 'Bob Smith', 'bob.s@mail.com', '15 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (317, 'Eve Smith', 'eve.s@email.com', '34 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (318, 'Bob Jones', 'bob.j@web.com', '333 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (319, 'Grace Williams', 'grace@email.com', '378 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (320, 'John Davis', 'john.@mail.com', '800 Pine st');
insert into CUSTOMER (customer_id, name, email, address)
values (321, 'Henry Garcia', 'henry@site.com', '299 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (322, 'Henry Smith', 'henry@web.com', '911 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (323, 'Eve Johnson', 'eve.j@mail.com', '638 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (324, 'Carol Williams', 'carol@web.com', '710 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (325, 'Dan Smith', 'dan.s@email.com', '168 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (326, 'John Wilson', 'john.@mail.com', '88 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (327, 'Eve Jones', 'eve.j@web.com', '560 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (328, 'Frank Smith', 'frank@email.com', '645 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (329, 'Carol Miller', 'carol@site.com', '576 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (330, 'John Jones', 'john.@web.com', '208 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (331, 'Dan Johnson', 'dan.j@site.com', '571 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (332, 'Frank Brown', 'frank@web.com', '300 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (333, 'Henry Garcia', 'henry@mail.com', '613 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (334, 'Carol Williams', 'carol@ex.com', '636 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (335, 'Henry Williams', 'henry@site.com', '249 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (336, 'Alice Doe', 'alice@web.com', '924 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (337, 'Dan Miller', 'dan.m@mail.com', '723 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (338, 'Dan Johnson', 'dan.j@mail.com', '638 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (339, 'Dan Brown', 'dan.b@site.com', '635 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (340, 'Dan Johnson', 'dan.j@ex.com', '618 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (341, 'Alice Smith', 'alice@mail.com', '30 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (342, 'John Davis', 'john.@site.com', '875 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (343, 'Eve Williams', 'eve.w@web.com', '456 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (344, 'Dan Smith', 'dan.s@mail.com', '216 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (345, 'Jane Smith', 'jane.@email.com', '932 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (346, 'Frank Wilson', 'frank@email.com', '252 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (347, 'Dan Davis', 'dan.d@site.com', '486 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (348, 'Carol Brown', 'carol@mail.com', '683 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (349, 'Grace Miller', 'grace@ex.com', '25 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (350, 'Henry Williams', 'henry@mail.com', '785 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (351, 'John Garcia', 'john.@ex.com', '22 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (352, 'Grace Doe', 'grace@mail.com', '524 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (353, 'John Williams', 'john.@ex.com', '574 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (354, 'Grace Miller', 'grace@web.com', '93 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (355, 'Carol Johnson', 'carol@ex.com', '359 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (356, 'Alice Wilson', 'alice@ex.com', '509 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (357, 'Grace Smith', 'grace@email.com', '200 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (358, 'Frank Doe', 'frank@email.com', '431 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (359, 'Bob Miller', 'bob.m@email.com', '757 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (360, 'Eve Wilson', 'eve.w@email.com', '649 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (361, 'Alice Jones', 'alice@web.com', '850 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (362, 'John Miller', 'john.@mail.com', '654 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (363, 'Alice Williams', 'alice@site.com', '656 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (364, 'Carol Johnson', 'carol@email.com', '633 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (365, 'Jane Wilson', 'jane.@web.com', '118 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (366, 'Jane Doe', 'jane.@mail.com', '96 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (367, 'John Jones', 'john.@email.com', '247 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (368, 'Carol Jones', 'carol@site.com', '2 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (369, 'Carol Davis', 'carol@email.com', '995 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (370, 'Jane Jones', 'jane.@site.com', '752 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (371, 'John Brown', 'john.@site.com', '785 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (372, 'Grace Brown', 'grace@site.com', '861 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (373, 'Grace Doe', 'grace@ex.com', '94 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (374, 'Grace Jones', 'grace@mail.com', '682 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (375, 'Dan Davis', 'dan.d@site.com', '145 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (376, 'Carol Brown', 'carol@web.com', '259 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (377, 'Carol Williams', 'carol@mail.com', '461 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (378, 'Frank Davis', 'frank@ex.com', '788 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (379, 'John Smith', 'john.@ex.com', '405 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (380, 'Alice Smith', 'alice@mail.com', '50 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (381, 'Grace Garcia', 'grace@ex.com', '288 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (382, 'Dan Miller', 'dan.m@ex.com', '501 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (383, 'Henry Williams', 'henry@ex.com', '887 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (384, 'Alice Williams', 'alice@site.com', '3 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (385, 'Alice Johnson', 'alice@mail.com', '491 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (386, 'Frank Smith', 'frank@site.com', '90 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (387, 'Carol Miller', 'carol@site.com', '429 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (388, 'Dan Garcia', 'dan.g@email.com', '933 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (389, 'Dan Davis', 'dan.d@site.com', '915 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (390, 'Carol Wilson', 'carol@email.com', '281 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (391, 'Eve Williams', 'eve.w@site.com', '513 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (392, 'Eve Jones', 'eve.j@web.com', '905 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (393, 'Alice Wilson', 'alice@site.com', '826 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (394, 'Bob Johnson', 'bob.j@web.com', '337 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (395, 'Jane Brown', 'jane.@email.com', '259 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (396, 'John Johnson', 'john.@site.com', '553 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (397, 'Carol Doe', 'carol@ex.com', '629 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (398, 'Henry Smith', 'henry@email.com', '444 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (399, 'Dan Brown', 'dan.b@site.com', '714 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (400, 'Carol Smith', 'carol@ex.com', '39 Aspen St');
commit;
prompt 300 records committed...
insert into CUSTOMER (customer_id, name, email, address)
values (401, 'Bob Johnson', 'bob.j@site.com', '215 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (402, 'John Davis', 'john.@ex.com', '139 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (403, 'Alice Davis', 'alice@web.com', '982 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (404, 'John Brown', 'john.@ex.com', '294 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (405, 'Henry Miller', 'henry@site.com', '567 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (406, 'Carol Brown', 'carol@mail.com', '55 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (407, 'Dan Brown', 'dan.b@ex.com', '161 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (408, 'Frank Garcia', 'frank@ex.com', '258 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (409, 'Carol Wilson', 'carol@web.com', '763 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (410, 'Alice Jones', 'alice@web.com', '54 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (411, 'John Smith', 'john.@ex.com', '729 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (412, 'Frank Davis', 'frank@email.com', '107 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (413, 'Jane Smith', 'jane.@ex.com', '940 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (414, 'Alice Brown', 'alice@site.com', '331 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (415, 'Frank Wilson', 'frank@ex.com', '763 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (416, 'Henry Johnson', 'henry@ex.com', '329 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (417, 'John Davis', 'john.@mail.com', '418 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (418, 'Alice Jones', 'alice@email.com', '337 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (419, 'Grace Brown', 'grace@mail.com', '438 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (420, 'Alice Doe', 'alice@web.com', '745 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (421, 'Alice Smith', 'alice@email.com', '270 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (422, 'Jane Davis', 'jane.@email.com', '13 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (423, 'Frank Smith', 'frank@ex.com', '147 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (424, 'Carol Garcia', 'carol@web.com', '814 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (425, 'Bob Williams', 'bob.w@site.com', '88 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (426, 'Grace Davis', 'grace@email.com', '455 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (427, 'Dan Davis', 'dan.d@ex.com', '173 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (428, 'Alice Garcia', 'alice@site.com', '323 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (429, 'Henry Jones', 'henry@site.com', '26 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (430, 'Dan Garcia', 'dan.g@web.com', '388 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (431, 'Carol Brown', 'carol@site.com', '699 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (432, 'Bob Miller', 'bob.m@web.com', '45 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (433, 'Frank Davis', 'frank@ex.com', '57 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (434, 'Alice Miller', 'alice@site.com', '392 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (435, 'Carol Wilson', 'carol@email.com', '865 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (436, 'John Miller', 'john.@web.com', '308 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (437, 'Henry Brown', 'henry@ex.com', '61 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (438, 'Carol Davis', 'carol@mail.com', '917 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (439, 'Jane Davis', 'jane.@site.com', '635 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (440, 'Dan Smith', 'dan.s@mail.com', '741 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (441, 'Grace Williams', 'grace@email.com', '655 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (442, 'Frank Smith', 'frank@ex.com', '930 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (443, 'Carol Miller', 'carol@email.com', '116 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (444, 'Eve Johnson', 'eve.j@email.com', '463 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (445, 'Frank Johnson', 'frank@mail.com', '649 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (446, 'Dan Davis', 'dan.d@site.com', '766 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (447, 'Carol Jones', 'carol@mail.com', '890 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (448, 'Grace Brown', 'grace@web.com', '616 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (449, 'Eve Wilson', 'eve.w@site.com', '22 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (450, 'Frank Davis', 'frank@email.com', '607 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (451, 'Alice Brown', 'alice@email.com', '437 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (452, 'Henry Garcia', 'henry@ex.com', '279 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (453, 'Dan Johnson', 'dan.j@ex.com', '872 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (454, 'Carol Doe', 'carol@ex.com', '172 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (455, 'Eve Wilson', 'eve.w@email.com', '336 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (456, 'Jane Johnson', 'jane.@mail.com', '785 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (457, 'Henry Wilson', 'henry@web.com', '261 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (458, 'Frank Wilson', 'frank@email.com', '254 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (459, 'Alice Jones', 'alice@email.com', '13 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (460, 'Bob Johnson', 'bob.j@web.com', '721 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (461, 'Eve Johnson', 'eve.j@site.com', '374 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (462, 'Dan Davis', 'dan.d@web.com', '234 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (463, 'Frank Doe', 'frank@ex.com', '360 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (464, 'Jane Johnson', 'jane.@mail.com', '787 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (465, 'Frank Brown', 'frank@web.com', '196 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (466, 'Dan Brown', 'dan.b@mail.com', '391 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (467, 'Eve Johnson', 'eve.j@site.com', '270 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (468, 'Dan Miller', 'dan.m@site.com', '567 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (469, 'Grace Brown', 'grace@mail.com', '431 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (470, 'Alice Doe', 'alice@web.com', '18 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (471, 'Frank Johnson', 'frank@web.com', '570 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (472, 'Eve Doe', 'eve.d@ex.com', '265 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (473, 'Carol Doe', 'carol@site.com', '845 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (474, 'Dan Garcia', 'dan.g@web.com', '544 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (475, 'Eve Garcia', 'eve.g@email.com', '571 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (476, 'Eve Doe', 'eve.d@email.com', '54 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (477, 'Dan Johnson', 'dan.j@mail.com', '873 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (478, 'Bob Garcia', 'bob.g@site.com', '707 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (479, 'Bob Doe', 'bob.d@web.com', '595 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (480, 'Jane Smith', 'jane.@email.com', '362 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (481, 'Frank Williams', 'frank@email.com', '219 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (482, 'Bob Smith', 'bob.s@email.com', '238 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (483, 'Dan Williams', 'dan.w@ex.com', '748 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (484, 'Alice Wilson', 'alice@mail.com', '871 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (485, 'Bob Doe', 'bob.d@mail.com', '30 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (486, 'Bob Wilson', 'bob.w@mail.com', '906 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (487, 'Carol Williams', 'carol@ex.com', '822 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (488, 'Carol Johnson', 'carol@ex.com', '327 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (489, 'Henry Brown', 'henry@web.com', '947 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (490, 'Jane Williams', 'jane.@email.com', '978 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (491, 'Eve Wilson', 'eve.w@web.com', '641 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (492, 'Dan Smith', 'dan.s@site.com', '122 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (493, 'Eve Brown', 'eve.b@site.com', '158 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (494, 'Dan Johnson', 'dan.j@site.com', '251 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (495, 'John Brown', 'john.@email.com', '643 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (496, 'Frank Williams', 'frank@mail.com', '799 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (497, 'John Miller', 'john.@web.com', '86 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (498, 'John Jones', 'john.@ex.com', '866 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (499, 'Frank Brown', 'frank@ex.com', '68 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (500, 'Carol Garcia', 'carol@ex.com', '246 Cedar St');
commit;
prompt 400 records committed...
insert into CUSTOMER (customer_id, name, email, address)
values (501, 'Dan Smith', 'dan.s@web.com', '662 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (502, 'Eve Brown', 'eve.b@site.com', '283 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (503, 'Alice Doe', 'alice@email.com', '58 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (504, 'Bob Miller', 'bob.m@email.com', '685 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (505, 'Grace Brown', 'grace@email.com', '821 Pine St');
insert into CUSTOMER (customer_id, name, email, address)
values (506, 'Jane Wilson', 'jane.@mail.com', '727 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (507, 'Dan Garcia', 'dan.g@email.com', '318 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (508, 'Dan Jones', 'dan.j@mail.com', '230 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (509, 'Frank Doe', 'frank@web.com', '648 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (510, 'Jane Williams', 'jane.@ex.com', '415 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (511, 'Henry Davis', 'henry@email.com', '577 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (512, 'John Smith', 'john.@email.com', '800 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (513, 'Dan Doe', 'dan.d@mail.com', '944 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (514, 'Jane Brown', 'jane.@mail.com', '447 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (515, 'Eve Miller', 'eve.m@mail.com', '234 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (516, 'Frank Smith', 'frank@email.com', '214 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (517, 'Carol Brown', 'carol@ex.com', '456 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (518, 'Alice Johnson', 'alice@web.com', '177 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (519, 'Jane Williams', 'jane.@ex.com', '562 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (520, 'Grace Johnson', 'grace@email.com', '809 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (521, 'Jane Davis', 'jane.@site.com', '661 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (522, 'Bob Miller', 'bob.m@web.com', '621 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (523, 'Bob Miller', 'bob.m@site.com', '902 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (524, 'Eve Wilson', 'eve.w@web.com', '796 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (525, 'Grace Davis', 'grace@site.com', '878 Aspen St');
insert into CUSTOMER (customer_id, name, email, address)
values (526, 'Grace Brown', 'grace@web.com', '675 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (527, 'Eve Jones', 'eve.j@email.com', '205 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (528, 'Frank Brown', 'frank@ex.com', '992 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (529, 'Alice Garcia', 'alice@site.com', '412 Maple St');
insert into CUSTOMER (customer_id, name, email, address)
values (530, 'Bob Garcia', 'bob.g@ex.com', '663 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (531, 'Carol Williams', 'carol@email.com', '949 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (532, 'Jane Williams', 'jane.@web.com', '14 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (533, 'Frank Doe', 'frank@mail.com', '871 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (534, 'Carol Doe', 'carol@email.com', '305 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (535, 'Eve Garcia', 'eve.g@ex.com', '890 Oak St');
insert into CUSTOMER (customer_id, name, email, address)
values (536, 'Frank Doe', 'frank@email.com', '412 Willow St');
insert into CUSTOMER (customer_id, name, email, address)
values (537, 'Bob Smith', 'bob.s@web.com', '992 Birch St');
insert into CUSTOMER (customer_id, name, email, address)
values (538, 'Jane Davis', 'jane.@ex.com', '380 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (539, 'Eve Brown', 'eve.b@email.com', '620 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (540, 'Henry Garcia', 'henry@mail.com', '107 Cedar St');
insert into CUSTOMER (customer_id, name, email, address)
values (541, 'Bob Doe', 'bob.d@web.com', '124 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (542, 'John Williams', 'john.@mail.com', '402 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (543, 'Bob Williams', 'bob.w@web.com', '364 Elm St');
insert into CUSTOMER (customer_id, name, email, address)
values (544, 'Alice Wilson', 'alice@ex.com', '736 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (545, 'Eve Davis', 'eve.d@email.com', '1 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (546, 'Carol Wilson', 'carol@email.com', '195 Poplar St');
insert into CUSTOMER (customer_id, name, email, address)
values (547, 'Eve Davis', 'eve.d@email.com', '716 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (548, 'Dan Davis', 'dan.d@web.com', '841 Cherry St');
insert into CUSTOMER (customer_id, name, email, address)
values (549, 'Carol Williams', 'carol@web.com', '61 Maple St');
commit;
prompt 449 records loaded
prompt Loading PAYMENT_TYPE...
insert into PAYMENT_TYPE (payment_id, ptype)
values (1, ' Cash');
insert into PAYMENT_TYPE (payment_id, ptype)
values (2, ' Credit Card');
insert into PAYMENT_TYPE (payment_id, ptype)
values (3, ' Check');
insert into PAYMENT_TYPE (payment_id, ptype)
values (4, ' PayPal');
insert into PAYMENT_TYPE (payment_id, ptype)
values (5, ' Bank Transfer');
insert into PAYMENT_TYPE (payment_id, ptype)
values (6, ' Bit');
commit;
prompt 6 records loaded
prompt Loading PRODUCER...
insert into PRODUCER (producer_id, producer_name, price)
values (201, ' Jon Doe', 3347);
insert into PRODUCER (producer_id, producer_name, price)
values (202, ' Jane Roe', 3570);
insert into PRODUCER (producer_id, producer_name, price)
values (203, ' Alice Li', 3793);
insert into PRODUCER (producer_id, producer_name, price)
values (204, ' Bob Lin', 4292);
insert into PRODUCER (producer_id, producer_name, price)
values (205, ' Carol Yu', 3681);
insert into PRODUCER (producer_id, producer_name, price)
values (206, ' Dan Kim', 3905);
insert into PRODUCER (producer_id, producer_name, price)
values (207, ' Eve Wu', 3600);
insert into PRODUCER (producer_id, producer_name, price)
values (208, ' Frank Ho', 4600);
insert into PRODUCER (producer_id, producer_name, price)
values (209, ' Grace Ma', 4240);
insert into PRODUCER (producer_id, producer_name, price)
values (210, ' Henry Xu', 4351);
insert into PRODUCER (producer_id, producer_name, price)
values (211, 'Bob Brown', 9094);
insert into PRODUCER (producer_id, producer_name, price)
values (212, 'John Davis', 8695);
insert into PRODUCER (producer_id, producer_name, price)
values (213, 'Dan Garcia', 9069);
insert into PRODUCER (producer_id, producer_name, price)
values (214, 'Alice Wilson', 6092);
insert into PRODUCER (producer_id, producer_name, price)
values (215, 'Carol Jones', 1590);
insert into PRODUCER (producer_id, producer_name, price)
values (216, 'John Garcia', 4461);
insert into PRODUCER (producer_id, producer_name, price)
values (217, 'John Williams', 8160);
insert into PRODUCER (producer_id, producer_name, price)
values (218, 'Jane Davis', 5922);
insert into PRODUCER (producer_id, producer_name, price)
values (219, 'Jane Brown', 10795);
insert into PRODUCER (producer_id, producer_name, price)
values (220, 'Carol Smith', 4849);
insert into PRODUCER (producer_id, producer_name, price)
values (221, 'Henry Williams', 12206);
insert into PRODUCER (producer_id, producer_name, price)
values (222, 'Jane Wilson', 5523);
insert into PRODUCER (producer_id, producer_name, price)
values (223, 'John Brown', 3830);
insert into PRODUCER (producer_id, producer_name, price)
values (224, 'Alice Miller', 8357);
insert into PRODUCER (producer_id, producer_name, price)
values (225, 'Eve Williams', 4617);
insert into PRODUCER (producer_id, producer_name, price)
values (226, 'Bob Jones', 7566);
insert into PRODUCER (producer_id, producer_name, price)
values (227, 'Grace Williams', 2408);
insert into PRODUCER (producer_id, producer_name, price)
values (228, 'Jane Davis', 1506);
insert into PRODUCER (producer_id, producer_name, price)
values (229, 'Bob Johnson', 4116);
insert into PRODUCER (producer_id, producer_name, price)
values (230, 'Jane Miller', 1497);
insert into PRODUCER (producer_id, producer_name, price)
values (231, 'Frank Johnson', 6201);
insert into PRODUCER (producer_id, producer_name, price)
values (232, 'Carol Brown', 2787);
insert into PRODUCER (producer_id, producer_name, price)
values (233, 'Bob Brown', 8919);
insert into PRODUCER (producer_id, producer_name, price)
values (234, 'Dan Smith', 8764);
insert into PRODUCER (producer_id, producer_name, price)
values (235, 'Jane Brown', 2903);
insert into PRODUCER (producer_id, producer_name, price)
values (236, 'Grace Brown', 1453);
insert into PRODUCER (producer_id, producer_name, price)
values (237, 'Dan Miller', 6106);
insert into PRODUCER (producer_id, producer_name, price)
values (238, 'Dan Smith', 7149);
insert into PRODUCER (producer_id, producer_name, price)
values (239, 'Carol Johnson', 1439);
insert into PRODUCER (producer_id, producer_name, price)
values (240, 'John Jones', 3956);
insert into PRODUCER (producer_id, producer_name, price)
values (241, 'Dan Wilson', 10932);
insert into PRODUCER (producer_id, producer_name, price)
values (242, 'Alice Brown', 2994);
insert into PRODUCER (producer_id, producer_name, price)
values (243, 'Henry Wilson', 8965);
insert into PRODUCER (producer_id, producer_name, price)
values (244, 'Eve Garcia', 1541);
insert into PRODUCER (producer_id, producer_name, price)
values (245, 'Bob Smith', 3876);
insert into PRODUCER (producer_id, producer_name, price)
values (246, 'Frank Garcia', 2899);
insert into PRODUCER (producer_id, producer_name, price)
values (247, 'Dan Smith', 9328);
insert into PRODUCER (producer_id, producer_name, price)
values (248, 'Frank Garcia', 3236);
insert into PRODUCER (producer_id, producer_name, price)
values (249, 'Frank Wilson', 7283);
insert into PRODUCER (producer_id, producer_name, price)
values (250, 'Dan Wilson', 6940);
insert into PRODUCER (producer_id, producer_name, price)
values (251, 'Jane Wilson', 2715);
insert into PRODUCER (producer_id, producer_name, price)
values (252, 'John Johnson', 4596);
insert into PRODUCER (producer_id, producer_name, price)
values (253, 'Frank Williams', 1939);
insert into PRODUCER (producer_id, producer_name, price)
values (254, 'Grace Wilson', 5140);
insert into PRODUCER (producer_id, producer_name, price)
values (255, 'Henry Doe', 7468);
insert into PRODUCER (producer_id, producer_name, price)
values (256, 'Henry Doe', 9651);
insert into PRODUCER (producer_id, producer_name, price)
values (257, 'Eve Doe', 11715);
insert into PRODUCER (producer_id, producer_name, price)
values (258, 'Jane Davis', 2978);
insert into PRODUCER (producer_id, producer_name, price)
values (259, 'Frank Jones', 11561);
insert into PRODUCER (producer_id, producer_name, price)
values (260, 'Jane Wilson', 10651);
insert into PRODUCER (producer_id, producer_name, price)
values (261, 'Bob Doe', 7813);
insert into PRODUCER (producer_id, producer_name, price)
values (262, 'Dan Miller', 6966);
insert into PRODUCER (producer_id, producer_name, price)
values (263, 'John Jones', 2739);
insert into PRODUCER (producer_id, producer_name, price)
values (264, 'Alice Jones', 6272);
insert into PRODUCER (producer_id, producer_name, price)
values (265, 'John Brown', 2473);
insert into PRODUCER (producer_id, producer_name, price)
values (266, 'Alice Miller', 6870);
insert into PRODUCER (producer_id, producer_name, price)
values (267, 'Dan Wilson', 2710);
insert into PRODUCER (producer_id, producer_name, price)
values (268, 'Carol Smith', 7057);
insert into PRODUCER (producer_id, producer_name, price)
values (269, 'Grace Brown', 7572);
insert into PRODUCER (producer_id, producer_name, price)
values (270, 'Eve Johnson', 5262);
insert into PRODUCER (producer_id, producer_name, price)
values (271, 'Alice Johnson', 4626);
insert into PRODUCER (producer_id, producer_name, price)
values (272, 'John Davis', 15275);
insert into PRODUCER (producer_id, producer_name, price)
values (273, 'Grace Jones', 1326);
insert into PRODUCER (producer_id, producer_name, price)
values (274, 'Frank Garcia', 3389);
insert into PRODUCER (producer_id, producer_name, price)
values (275, 'Eve Wilson', 9089);
insert into PRODUCER (producer_id, producer_name, price)
values (276, 'Frank Miller', 7440);
insert into PRODUCER (producer_id, producer_name, price)
values (277, 'Dan Johnson', 10672);
insert into PRODUCER (producer_id, producer_name, price)
values (278, 'Eve Wilson', 3533);
insert into PRODUCER (producer_id, producer_name, price)
values (279, 'Bob Miller', 5766);
insert into PRODUCER (producer_id, producer_name, price)
values (280, 'Eve Smith', 8243);
insert into PRODUCER (producer_id, producer_name, price)
values (281, 'John Brown', 6943);
insert into PRODUCER (producer_id, producer_name, price)
values (282, 'Grace Williams', 2480);
insert into PRODUCER (producer_id, producer_name, price)
values (283, 'Henry Doe', 6497);
insert into PRODUCER (producer_id, producer_name, price)
values (284, 'Frank Davis', 8289);
insert into PRODUCER (producer_id, producer_name, price)
values (285, 'Carol Williams', 10109);
insert into PRODUCER (producer_id, producer_name, price)
values (286, 'Eve Garcia', 7840);
insert into PRODUCER (producer_id, producer_name, price)
values (287, 'Eve Davis', 5821);
insert into PRODUCER (producer_id, producer_name, price)
values (288, 'Henry Doe', 3394);
insert into PRODUCER (producer_id, producer_name, price)
values (289, 'Alice Williams', 13317);
insert into PRODUCER (producer_id, producer_name, price)
values (290, 'Eve Garcia', 2652);
insert into PRODUCER (producer_id, producer_name, price)
values (291, 'John Williams', 4265);
insert into PRODUCER (producer_id, producer_name, price)
values (292, 'Carol Williams', 13707);
insert into PRODUCER (producer_id, producer_name, price)
values (293, 'Dan Williams', 8956);
insert into PRODUCER (producer_id, producer_name, price)
values (294, 'Carol Williams', 3073);
insert into PRODUCER (producer_id, producer_name, price)
values (295, 'Henry Doe', 4023);
insert into PRODUCER (producer_id, producer_name, price)
values (296, 'Alice Davis', 7730);
insert into PRODUCER (producer_id, producer_name, price)
values (297, 'John Garcia', 11140);
insert into PRODUCER (producer_id, producer_name, price)
values (298, 'Eve Jones', 3590);
insert into PRODUCER (producer_id, producer_name, price)
values (299, 'John Brown', 6188);
insert into PRODUCER (producer_id, producer_name, price)
values (300, 'Grace Jones', 5862);
commit;
prompt 100 records committed...
insert into PRODUCER (producer_id, producer_name, price)
values (301, 'Jane Jones', 2583);
insert into PRODUCER (producer_id, producer_name, price)
values (302, 'Grace Brown', 9838);
insert into PRODUCER (producer_id, producer_name, price)
values (303, 'Eve Smith', 5260);
insert into PRODUCER (producer_id, producer_name, price)
values (304, 'Alice Williams', 6029);
insert into PRODUCER (producer_id, producer_name, price)
values (305, 'Eve Davis', 4204);
insert into PRODUCER (producer_id, producer_name, price)
values (306, 'Frank Garcia', 3022);
insert into PRODUCER (producer_id, producer_name, price)
values (307, 'Alice Smith', 1880);
insert into PRODUCER (producer_id, producer_name, price)
values (308, 'Frank Wilson', 13229);
insert into PRODUCER (producer_id, producer_name, price)
values (309, 'Eve Brown', 6083);
insert into PRODUCER (producer_id, producer_name, price)
values (310, 'Henry Miller', 6447);
insert into PRODUCER (producer_id, producer_name, price)
values (311, 'Carol Garcia', 6079);
insert into PRODUCER (producer_id, producer_name, price)
values (312, 'Frank Brown', 1725);
insert into PRODUCER (producer_id, producer_name, price)
values (313, 'Grace Jones', 8605);
insert into PRODUCER (producer_id, producer_name, price)
values (314, 'Henry Williams', 7909);
insert into PRODUCER (producer_id, producer_name, price)
values (315, 'Grace Johnson', 9924);
insert into PRODUCER (producer_id, producer_name, price)
values (316, 'John Miller', 4450);
insert into PRODUCER (producer_id, producer_name, price)
values (317, 'Bob Brown', 3158);
insert into PRODUCER (producer_id, producer_name, price)
values (318, 'Dan Davis', 2126);
insert into PRODUCER (producer_id, producer_name, price)
values (319, 'Henry Davis', 4297);
insert into PRODUCER (producer_id, producer_name, price)
values (320, 'Eve Miller', 7206);
insert into PRODUCER (producer_id, producer_name, price)
values (321, 'John Miller', 8987);
insert into PRODUCER (producer_id, producer_name, price)
values (322, 'Frank Wilson', 6896);
insert into PRODUCER (producer_id, producer_name, price)
values (323, 'Frank Garcia', 2536);
insert into PRODUCER (producer_id, producer_name, price)
values (324, 'Eve Williams', 5819);
insert into PRODUCER (producer_id, producer_name, price)
values (325, 'John Brown', 11673);
insert into PRODUCER (producer_id, producer_name, price)
values (326, 'Eve Williams', 3379);
insert into PRODUCER (producer_id, producer_name, price)
values (327, 'Grace Jones', 1869);
insert into PRODUCER (producer_id, producer_name, price)
values (328, 'Eve Doe', 7206);
insert into PRODUCER (producer_id, producer_name, price)
values (329, 'Henry Smith', 7949);
insert into PRODUCER (producer_id, producer_name, price)
values (330, 'Alice Johnson', 3854);
insert into PRODUCER (producer_id, producer_name, price)
values (331, 'Dan Garcia', 8063);
insert into PRODUCER (producer_id, producer_name, price)
values (332, 'Eve Williams', 2338);
insert into PRODUCER (producer_id, producer_name, price)
values (333, 'Jane Johnson', 9430);
insert into PRODUCER (producer_id, producer_name, price)
values (334, 'Frank Jones', 6214);
insert into PRODUCER (producer_id, producer_name, price)
values (335, 'Eve Smith', 10947);
insert into PRODUCER (producer_id, producer_name, price)
values (336, 'Alice Johnson', 8851);
insert into PRODUCER (producer_id, producer_name, price)
values (337, 'Carol Brown', 1791);
insert into PRODUCER (producer_id, producer_name, price)
values (338, 'Bob Johnson', 7898);
insert into PRODUCER (producer_id, producer_name, price)
values (339, 'Grace Doe', 3136);
insert into PRODUCER (producer_id, producer_name, price)
values (340, 'Bob Brown', 6773);
insert into PRODUCER (producer_id, producer_name, price)
values (341, 'Henry Garcia', 3761);
insert into PRODUCER (producer_id, producer_name, price)
values (342, 'Alice Davis', 8657);
insert into PRODUCER (producer_id, producer_name, price)
values (343, 'Jane Johnson', 5940);
insert into PRODUCER (producer_id, producer_name, price)
values (344, 'Alice Miller', 6770);
insert into PRODUCER (producer_id, producer_name, price)
values (345, 'Grace Johnson', 1657);
insert into PRODUCER (producer_id, producer_name, price)
values (346, 'Eve Davis', 3869);
insert into PRODUCER (producer_id, producer_name, price)
values (347, 'Henry Wilson', 4034);
insert into PRODUCER (producer_id, producer_name, price)
values (348, 'Grace Garcia', 3321);
insert into PRODUCER (producer_id, producer_name, price)
values (349, 'Jane Doe', 1323);
insert into PRODUCER (producer_id, producer_name, price)
values (350, 'Henry Davis', 2976);
insert into PRODUCER (producer_id, producer_name, price)
values (351, 'Eve Brown', 8802);
insert into PRODUCER (producer_id, producer_name, price)
values (352, 'Carol Miller', 6568);
insert into PRODUCER (producer_id, producer_name, price)
values (353, 'Frank Smith', 3604);
insert into PRODUCER (producer_id, producer_name, price)
values (354, 'Jane Davis', 1663);
insert into PRODUCER (producer_id, producer_name, price)
values (355, 'Dan Miller', 4737);
insert into PRODUCER (producer_id, producer_name, price)
values (356, 'Alice Jones', 6109);
insert into PRODUCER (producer_id, producer_name, price)
values (357, 'Grace Davis', 3570);
insert into PRODUCER (producer_id, producer_name, price)
values (358, 'Carol Miller', 3366);
insert into PRODUCER (producer_id, producer_name, price)
values (359, 'John Doe', 11465);
insert into PRODUCER (producer_id, producer_name, price)
values (360, 'Jane Brown', 12084);
insert into PRODUCER (producer_id, producer_name, price)
values (361, 'Frank Smith', 1985);
insert into PRODUCER (producer_id, producer_name, price)
values (362, 'Jane Doe', 2975);
insert into PRODUCER (producer_id, producer_name, price)
values (363, 'Alice Johnson', 10691);
insert into PRODUCER (producer_id, producer_name, price)
values (364, 'Alice Doe', 6580);
insert into PRODUCER (producer_id, producer_name, price)
values (365, 'John Johnson', 11979);
insert into PRODUCER (producer_id, producer_name, price)
values (366, 'Dan Smith', 2954);
insert into PRODUCER (producer_id, producer_name, price)
values (367, 'Carol Smith', 1587);
insert into PRODUCER (producer_id, producer_name, price)
values (368, 'Jane Jones', 1306);
insert into PRODUCER (producer_id, producer_name, price)
values (369, 'Henry Brown', 2991);
insert into PRODUCER (producer_id, producer_name, price)
values (370, 'John Miller', 11141);
insert into PRODUCER (producer_id, producer_name, price)
values (371, 'Henry Doe', 3203);
insert into PRODUCER (producer_id, producer_name, price)
values (372, 'Eve Smith', 2984);
insert into PRODUCER (producer_id, producer_name, price)
values (373, 'Jane Jones', 2442);
insert into PRODUCER (producer_id, producer_name, price)
values (374, 'Bob Smith', 7664);
insert into PRODUCER (producer_id, producer_name, price)
values (375, 'Dan Garcia', 5372);
insert into PRODUCER (producer_id, producer_name, price)
values (376, 'Dan Smith', 5086);
insert into PRODUCER (producer_id, producer_name, price)
values (377, 'Eve Doe', 2930);
insert into PRODUCER (producer_id, producer_name, price)
values (378, 'Bob Smith', 7318);
insert into PRODUCER (producer_id, producer_name, price)
values (379, 'Grace Garcia', 1388);
insert into PRODUCER (producer_id, producer_name, price)
values (380, 'Frank Doe', 3907);
insert into PRODUCER (producer_id, producer_name, price)
values (381, 'Alice Jones', 11114);
insert into PRODUCER (producer_id, producer_name, price)
values (382, 'Henry Williams', 10495);
insert into PRODUCER (producer_id, producer_name, price)
values (383, 'Frank Wilson', 3242);
insert into PRODUCER (producer_id, producer_name, price)
values (384, 'Eve Smith', 9749);
insert into PRODUCER (producer_id, producer_name, price)
values (385, 'Bob Williams', 9390);
insert into PRODUCER (producer_id, producer_name, price)
values (386, 'Grace Garcia', 7228);
insert into PRODUCER (producer_id, producer_name, price)
values (387, 'Dan Williams', 2781);
insert into PRODUCER (producer_id, producer_name, price)
values (388, 'Carol Doe', 3561);
insert into PRODUCER (producer_id, producer_name, price)
values (389, 'Bob Miller', 3036);
insert into PRODUCER (producer_id, producer_name, price)
values (390, 'Grace Wilson', 8633);
insert into PRODUCER (producer_id, producer_name, price)
values (391, 'Eve Brown', 5058);
insert into PRODUCER (producer_id, producer_name, price)
values (392, 'Dan Brown', 8193);
insert into PRODUCER (producer_id, producer_name, price)
values (393, 'Eve Wilson', 6174);
insert into PRODUCER (producer_id, producer_name, price)
values (394, 'Carol Doe', 5329);
insert into PRODUCER (producer_id, producer_name, price)
values (395, 'Eve Davis', 5384);
insert into PRODUCER (producer_id, producer_name, price)
values (396, 'Bob Wilson', 4760);
insert into PRODUCER (producer_id, producer_name, price)
values (397, 'Dan Johnson', 7722);
insert into PRODUCER (producer_id, producer_name, price)
values (398, 'Jane Brown', 1638);
insert into PRODUCER (producer_id, producer_name, price)
values (399, 'Carol Williams', 9349);
insert into PRODUCER (producer_id, producer_name, price)
values (400, 'Dan Davis', 7172);
commit;
prompt 200 records committed...
insert into PRODUCER (producer_id, producer_name, price)
values (401, 'Eve Miller', 10153);
insert into PRODUCER (producer_id, producer_name, price)
values (402, 'Dan Johnson', 1452);
insert into PRODUCER (producer_id, producer_name, price)
values (403, 'Alice Jones', 6918);
insert into PRODUCER (producer_id, producer_name, price)
values (404, 'Eve Williams', 6007);
insert into PRODUCER (producer_id, producer_name, price)
values (405, 'Jane Brown', 3372);
insert into PRODUCER (producer_id, producer_name, price)
values (406, 'Jane Wilson', 10012);
insert into PRODUCER (producer_id, producer_name, price)
values (407, 'Alice Smith', 5606);
insert into PRODUCER (producer_id, producer_name, price)
values (408, 'Jane Davis', 9473);
insert into PRODUCER (producer_id, producer_name, price)
values (409, 'Henry Smith', 8652);
insert into PRODUCER (producer_id, producer_name, price)
values (410, 'John Doe', 7139);
insert into PRODUCER (producer_id, producer_name, price)
values (411, 'Eve Johnson', 2181);
insert into PRODUCER (producer_id, producer_name, price)
values (412, 'Eve Williams', 6434);
insert into PRODUCER (producer_id, producer_name, price)
values (413, 'Bob Miller', 3319);
insert into PRODUCER (producer_id, producer_name, price)
values (414, 'Frank Jones', 1362);
insert into PRODUCER (producer_id, producer_name, price)
values (415, 'Frank Wilson', 6173);
insert into PRODUCER (producer_id, producer_name, price)
values (416, 'Bob Wilson', 4777);
insert into PRODUCER (producer_id, producer_name, price)
values (417, 'Carol Miller', 2071);
insert into PRODUCER (producer_id, producer_name, price)
values (418, 'Grace Smith', 9465);
insert into PRODUCER (producer_id, producer_name, price)
values (419, 'Bob Williams', 1432);
insert into PRODUCER (producer_id, producer_name, price)
values (420, 'Dan Williams', 2870);
insert into PRODUCER (producer_id, producer_name, price)
values (421, 'Frank Johnson', 2032);
insert into PRODUCER (producer_id, producer_name, price)
values (422, 'Alice Garcia', 6437);
insert into PRODUCER (producer_id, producer_name, price)
values (423, 'Grace Jones', 10434);
insert into PRODUCER (producer_id, producer_name, price)
values (424, 'Eve Jones', 5618);
insert into PRODUCER (producer_id, producer_name, price)
values (425, 'John Garcia', 6999);
insert into PRODUCER (producer_id, producer_name, price)
values (426, 'Henry Davis', 1971);
insert into PRODUCER (producer_id, producer_name, price)
values (427, 'John Brown', 1310);
insert into PRODUCER (producer_id, producer_name, price)
values (428, 'Bob Brown', 11072);
insert into PRODUCER (producer_id, producer_name, price)
values (429, 'Alice Williams', 9205);
insert into PRODUCER (producer_id, producer_name, price)
values (430, 'Carol Doe', 8024);
insert into PRODUCER (producer_id, producer_name, price)
values (431, 'Jane Garcia', 10960);
insert into PRODUCER (producer_id, producer_name, price)
values (432, 'Jane Jones', 9283);
insert into PRODUCER (producer_id, producer_name, price)
values (433, 'Grace Brown', 6619);
insert into PRODUCER (producer_id, producer_name, price)
values (434, 'Dan Garcia', 3647);
insert into PRODUCER (producer_id, producer_name, price)
values (435, 'Carol Garcia', 4542);
insert into PRODUCER (producer_id, producer_name, price)
values (436, 'Eve Garcia', 7099);
insert into PRODUCER (producer_id, producer_name, price)
values (437, 'John Johnson', 7470);
insert into PRODUCER (producer_id, producer_name, price)
values (438, 'Bob Wilson', 2340);
insert into PRODUCER (producer_id, producer_name, price)
values (439, 'Bob Doe', 6995);
insert into PRODUCER (producer_id, producer_name, price)
values (440, 'Jane Williams', 3320);
insert into PRODUCER (producer_id, producer_name, price)
values (441, 'Grace Wilson', 3091);
insert into PRODUCER (producer_id, producer_name, price)
values (442, 'Carol Davis', 2616);
insert into PRODUCER (producer_id, producer_name, price)
values (443, 'John Johnson', 4622);
insert into PRODUCER (producer_id, producer_name, price)
values (444, 'Grace Doe', 8529);
insert into PRODUCER (producer_id, producer_name, price)
values (445, 'Dan Doe', 8854);
insert into PRODUCER (producer_id, producer_name, price)
values (446, 'Henry Jones', 2179);
insert into PRODUCER (producer_id, producer_name, price)
values (447, 'Eve Wilson', 6187);
insert into PRODUCER (producer_id, producer_name, price)
values (448, 'Henry Wilson', 6140);
insert into PRODUCER (producer_id, producer_name, price)
values (449, 'Carol Wilson', 9835);
insert into PRODUCER (producer_id, producer_name, price)
values (450, 'Jane Doe', 7825);
insert into PRODUCER (producer_id, producer_name, price)
values (451, 'Carol Wilson', 3108);
insert into PRODUCER (producer_id, producer_name, price)
values (452, 'Alice Williams', 10666);
insert into PRODUCER (producer_id, producer_name, price)
values (453, 'John Wilson', 1292);
insert into PRODUCER (producer_id, producer_name, price)
values (454, 'Eve Miller', 1468);
insert into PRODUCER (producer_id, producer_name, price)
values (455, 'Carol Williams', 9752);
insert into PRODUCER (producer_id, producer_name, price)
values (456, 'Carol Davis', 4678);
insert into PRODUCER (producer_id, producer_name, price)
values (457, 'Grace Miller', 7029);
insert into PRODUCER (producer_id, producer_name, price)
values (458, 'Frank Williams', 9767);
insert into PRODUCER (producer_id, producer_name, price)
values (459, 'Grace Garcia', 2721);
insert into PRODUCER (producer_id, producer_name, price)
values (460, 'Grace Doe', 11744);
insert into PRODUCER (producer_id, producer_name, price)
values (461, 'Grace Jones', 6787);
insert into PRODUCER (producer_id, producer_name, price)
values (462, 'Carol Miller', 9710);
insert into PRODUCER (producer_id, producer_name, price)
values (463, 'Dan Jones', 4894);
insert into PRODUCER (producer_id, producer_name, price)
values (464, 'Alice Brown', 4304);
insert into PRODUCER (producer_id, producer_name, price)
values (465, 'Carol Johnson', 6642);
insert into PRODUCER (producer_id, producer_name, price)
values (466, 'Eve Brown', 5125);
insert into PRODUCER (producer_id, producer_name, price)
values (467, 'Dan Brown', 2788);
insert into PRODUCER (producer_id, producer_name, price)
values (468, 'Alice Davis', 8991);
insert into PRODUCER (producer_id, producer_name, price)
values (469, 'Dan Smith', 1382);
insert into PRODUCER (producer_id, producer_name, price)
values (470, 'Grace Williams', 6666);
insert into PRODUCER (producer_id, producer_name, price)
values (471, 'Henry Johnson', 9007);
insert into PRODUCER (producer_id, producer_name, price)
values (472, 'Bob Miller', 5359);
insert into PRODUCER (producer_id, producer_name, price)
values (473, 'John Brown', 2352);
insert into PRODUCER (producer_id, producer_name, price)
values (474, 'Dan Williams', 3887);
insert into PRODUCER (producer_id, producer_name, price)
values (475, 'Grace Doe', 8302);
insert into PRODUCER (producer_id, producer_name, price)
values (476, 'Alice Jones', 6329);
insert into PRODUCER (producer_id, producer_name, price)
values (477, 'Carol Garcia', 10483);
insert into PRODUCER (producer_id, producer_name, price)
values (478, 'Alice Davis', 4835);
insert into PRODUCER (producer_id, producer_name, price)
values (479, 'Frank Doe', 5851);
insert into PRODUCER (producer_id, producer_name, price)
values (480, 'Eve Davis', 11096);
insert into PRODUCER (producer_id, producer_name, price)
values (481, 'Grace Smith', 8593);
insert into PRODUCER (producer_id, producer_name, price)
values (482, 'Bob Johnson', 6978);
insert into PRODUCER (producer_id, producer_name, price)
values (483, 'Eve Garcia', 7009);
insert into PRODUCER (producer_id, producer_name, price)
values (484, 'Dan Doe', 3979);
insert into PRODUCER (producer_id, producer_name, price)
values (485, 'Carol Jones', 4819);
insert into PRODUCER (producer_id, producer_name, price)
values (486, 'Bob Jones', 7381);
insert into PRODUCER (producer_id, producer_name, price)
values (487, 'Dan Garcia', 4272);
insert into PRODUCER (producer_id, producer_name, price)
values (488, 'Jane Brown', 8458);
insert into PRODUCER (producer_id, producer_name, price)
values (489, 'Eve Miller', 2547);
insert into PRODUCER (producer_id, producer_name, price)
values (490, 'John Smith', 6612);
insert into PRODUCER (producer_id, producer_name, price)
values (491, 'Jane Jones', 4837);
insert into PRODUCER (producer_id, producer_name, price)
values (492, 'Carol Brown', 10813);
insert into PRODUCER (producer_id, producer_name, price)
values (493, 'Dan Johnson', 8598);
insert into PRODUCER (producer_id, producer_name, price)
values (494, 'Henry Wilson', 1580);
insert into PRODUCER (producer_id, producer_name, price)
values (495, 'Henry Williams', 5278);
insert into PRODUCER (producer_id, producer_name, price)
values (496, 'Eve Davis', 4658);
insert into PRODUCER (producer_id, producer_name, price)
values (497, 'Bob Jones', 7978);
insert into PRODUCER (producer_id, producer_name, price)
values (498, 'Alice Johnson', 3396);
insert into PRODUCER (producer_id, producer_name, price)
values (499, 'Eve Garcia', 4436);
insert into PRODUCER (producer_id, producer_name, price)
values (500, 'John Miller', 1372);
commit;
prompt 300 records committed...
insert into PRODUCER (producer_id, producer_name, price)
values (501, 'Carol Miller', 1189);
insert into PRODUCER (producer_id, producer_name, price)
values (502, 'Henry Garcia', 1538);
insert into PRODUCER (producer_id, producer_name, price)
values (503, 'Frank Jones', 6167);
insert into PRODUCER (producer_id, producer_name, price)
values (504, 'Dan Miller', 6859);
insert into PRODUCER (producer_id, producer_name, price)
values (505, 'Jane Williams', 3905);
insert into PRODUCER (producer_id, producer_name, price)
values (506, 'John Johnson', 5627);
insert into PRODUCER (producer_id, producer_name, price)
values (507, 'Grace Davis', 6470);
insert into PRODUCER (producer_id, producer_name, price)
values (508, 'Carol Davis', 7743);
insert into PRODUCER (producer_id, producer_name, price)
values (509, 'Frank Johnson', 3765);
insert into PRODUCER (producer_id, producer_name, price)
values (510, 'Carol Wilson', 8555);
insert into PRODUCER (producer_id, producer_name, price)
values (511, 'Henry Wilson', 8490);
insert into PRODUCER (producer_id, producer_name, price)
values (512, 'Dan Miller', 5874);
insert into PRODUCER (producer_id, producer_name, price)
values (513, 'Jane Johnson', 6645);
insert into PRODUCER (producer_id, producer_name, price)
values (514, 'Bob Davis', 6695);
insert into PRODUCER (producer_id, producer_name, price)
values (515, 'Jane Wilson', 5201);
insert into PRODUCER (producer_id, producer_name, price)
values (516, 'Eve Miller', 5224);
insert into PRODUCER (producer_id, producer_name, price)
values (517, 'Carol Davis', 3305);
insert into PRODUCER (producer_id, producer_name, price)
values (518, 'Henry Johnson', 4580);
insert into PRODUCER (producer_id, producer_name, price)
values (519, 'Jane Davis', 2794);
insert into PRODUCER (producer_id, producer_name, price)
values (520, 'Carol Miller', 4261);
insert into PRODUCER (producer_id, producer_name, price)
values (521, 'Carol Davis', 11577);
insert into PRODUCER (producer_id, producer_name, price)
values (522, 'Frank Brown', 2221);
insert into PRODUCER (producer_id, producer_name, price)
values (523, 'Dan Brown', 2236);
insert into PRODUCER (producer_id, producer_name, price)
values (524, 'Bob Smith', 2372);
insert into PRODUCER (producer_id, producer_name, price)
values (525, 'Frank Williams', 2801);
insert into PRODUCER (producer_id, producer_name, price)
values (526, 'Dan Williams', 5681);
insert into PRODUCER (producer_id, producer_name, price)
values (527, 'Bob Jones', 6858);
insert into PRODUCER (producer_id, producer_name, price)
values (528, 'Frank Brown', 3545);
insert into PRODUCER (producer_id, producer_name, price)
values (529, 'Jane Davis', 11228);
insert into PRODUCER (producer_id, producer_name, price)
values (530, 'Frank Johnson', 8349);
insert into PRODUCER (producer_id, producer_name, price)
values (531, 'Alice Johnson', 8555);
insert into PRODUCER (producer_id, producer_name, price)
values (532, 'Alice Garcia', 5704);
insert into PRODUCER (producer_id, producer_name, price)
values (533, 'Carol Jones', 3464);
insert into PRODUCER (producer_id, producer_name, price)
values (534, 'Henry Smith', 7311);
insert into PRODUCER (producer_id, producer_name, price)
values (535, 'Dan Doe', 5310);
insert into PRODUCER (producer_id, producer_name, price)
values (536, 'Jane Miller', 6658);
insert into PRODUCER (producer_id, producer_name, price)
values (537, 'Frank Johnson', 12161);
insert into PRODUCER (producer_id, producer_name, price)
values (538, 'John Miller', 6294);
insert into PRODUCER (producer_id, producer_name, price)
values (539, 'Dan Doe', 3444);
insert into PRODUCER (producer_id, producer_name, price)
values (540, 'John Williams', 2649);
insert into PRODUCER (producer_id, producer_name, price)
values (541, 'Eve Williams', 1523);
insert into PRODUCER (producer_id, producer_name, price)
values (542, 'Frank Doe', 2943);
insert into PRODUCER (producer_id, producer_name, price)
values (543, 'Eve Garcia', 10604);
insert into PRODUCER (producer_id, producer_name, price)
values (544, 'Henry Wilson', 3575);
insert into PRODUCER (producer_id, producer_name, price)
values (545, 'Henry Jones', 4834);
insert into PRODUCER (producer_id, producer_name, price)
values (546, 'John Miller', 6855);
insert into PRODUCER (producer_id, producer_name, price)
values (547, 'Eve Brown', 4677);
insert into PRODUCER (producer_id, producer_name, price)
values (548, 'Grace Smith', 9601);
insert into PRODUCER (producer_id, producer_name, price)
values (549, 'Eve Johnson', 3231);
insert into PRODUCER (producer_id, producer_name, price)
values (550, 'Bob Jones', 7836);
insert into PRODUCER (producer_id, producer_name, price)
values (551, 'Alice Garcia', 5100);
insert into PRODUCER (producer_id, producer_name, price)
values (552, 'Alice Garcia', 5068);
insert into PRODUCER (producer_id, producer_name, price)
values (553, 'Alice Brown', 7691);
insert into PRODUCER (producer_id, producer_name, price)
values (554, 'Eve Davis', 5835);
insert into PRODUCER (producer_id, producer_name, price)
values (555, 'Henry Jones', 7063);
insert into PRODUCER (producer_id, producer_name, price)
values (556, 'Eve Johnson', 9649);
insert into PRODUCER (producer_id, producer_name, price)
values (557, 'Alice Davis', 7094);
insert into PRODUCER (producer_id, producer_name, price)
values (558, 'Carol Brown', 9139);
insert into PRODUCER (producer_id, producer_name, price)
values (559, 'Henry Doe', 6115);
insert into PRODUCER (producer_id, producer_name, price)
values (560, 'Alice Johnson', 3248);
insert into PRODUCER (producer_id, producer_name, price)
values (561, 'Henry Miller', 1907);
insert into PRODUCER (producer_id, producer_name, price)
values (562, 'John Garcia', 8497);
insert into PRODUCER (producer_id, producer_name, price)
values (563, 'Alice Smith', 8701);
insert into PRODUCER (producer_id, producer_name, price)
values (564, 'Dan Johnson', 4592);
insert into PRODUCER (producer_id, producer_name, price)
values (565, 'Henry Garcia', 8824);
insert into PRODUCER (producer_id, producer_name, price)
values (566, 'Carol Wilson', 4759);
insert into PRODUCER (producer_id, producer_name, price)
values (567, 'Frank Smith', 3351);
insert into PRODUCER (producer_id, producer_name, price)
values (568, 'Frank Miller', 5425);
insert into PRODUCER (producer_id, producer_name, price)
values (569, 'Dan Williams', 1654);
insert into PRODUCER (producer_id, producer_name, price)
values (570, 'Jane Williams', 3934);
insert into PRODUCER (producer_id, producer_name, price)
values (571, 'Grace Doe', 7478);
insert into PRODUCER (producer_id, producer_name, price)
values (572, 'John Wilson', 4282);
insert into PRODUCER (producer_id, producer_name, price)
values (573, 'Henry Garcia', 11121);
insert into PRODUCER (producer_id, producer_name, price)
values (574, 'Grace Davis', 1450);
insert into PRODUCER (producer_id, producer_name, price)
values (575, 'Dan Williams', 3163);
insert into PRODUCER (producer_id, producer_name, price)
values (576, 'John Johnson', 3601);
insert into PRODUCER (producer_id, producer_name, price)
values (577, 'Eve Williams', 6224);
insert into PRODUCER (producer_id, producer_name, price)
values (578, 'Grace Garcia', 6563);
insert into PRODUCER (producer_id, producer_name, price)
values (579, 'Alice Johnson', 6973);
insert into PRODUCER (producer_id, producer_name, price)
values (580, 'John Wilson', 10947);
insert into PRODUCER (producer_id, producer_name, price)
values (581, 'Jane Williams', 5562);
insert into PRODUCER (producer_id, producer_name, price)
values (582, 'Grace Smith', 3134);
insert into PRODUCER (producer_id, producer_name, price)
values (583, 'Dan Doe', 3172);
insert into PRODUCER (producer_id, producer_name, price)
values (584, 'John Doe', 6436);
insert into PRODUCER (producer_id, producer_name, price)
values (585, 'Bob Garcia', 9456);
insert into PRODUCER (producer_id, producer_name, price)
values (586, 'Jane Johnson', 2353);
insert into PRODUCER (producer_id, producer_name, price)
values (587, 'Eve Miller', 7767);
insert into PRODUCER (producer_id, producer_name, price)
values (588, 'Frank Garcia', 5375);
insert into PRODUCER (producer_id, producer_name, price)
values (589, 'Bob Miller', 10479);
insert into PRODUCER (producer_id, producer_name, price)
values (590, 'Alice Miller', 10753);
insert into PRODUCER (producer_id, producer_name, price)
values (591, 'Henry Smith', 7738);
insert into PRODUCER (producer_id, producer_name, price)
values (592, 'Grace Williams', 6328);
insert into PRODUCER (producer_id, producer_name, price)
values (593, 'Bob Wilson', 12329);
insert into PRODUCER (producer_id, producer_name, price)
values (594, 'Frank Jones', 10964);
insert into PRODUCER (producer_id, producer_name, price)
values (595, 'Carol Williams', 2084);
insert into PRODUCER (producer_id, producer_name, price)
values (596, 'Grace Williams', 2403);
insert into PRODUCER (producer_id, producer_name, price)
values (597, 'Eve Johnson', 4166);
insert into PRODUCER (producer_id, producer_name, price)
values (598, 'Alice Johnson', 7395);
insert into PRODUCER (producer_id, producer_name, price)
values (599, 'Grace Williams', 6121);
insert into PRODUCER (producer_id, producer_name, price)
values (600, 'Carol Jones', 1713);
commit;
prompt 400 records committed...
insert into PRODUCER (producer_id, producer_name, price)
values (601, 'Grace Will', 5000);
commit;
prompt 401 records loaded
prompt Loading SINGER...
insert into SINGER (sname, singer_id, price)
values (' Alice Johnson', 3, 4800);
insert into SINGER (sname, singer_id, price)
values (' Michael Wilson', 6, 4900);
insert into SINGER (sname, singer_id, price)
values (' David White', 8, 4600);
insert into SINGER (sname, singer_id, price)
values (' Laura Harris', 9, 5100);
insert into SINGER (sname, singer_id, price)
values (' James Clark', 10, 5400);
insert into SINGER (sname, singer_id, price)
values ('Frank Garcia', 11, 4911);
insert into SINGER (sname, singer_id, price)
values ('Dan Smith', 13, 6473);
insert into SINGER (sname, singer_id, price)
values ('Dan Smith', 21, 9381);
insert into SINGER (sname, singer_id, price)
values ('Jane Williams', 23, 5408);
insert into SINGER (sname, singer_id, price)
values ('Carol Williams', 25, 4508);
insert into SINGER (sname, singer_id, price)
values ('Frank Miller', 26, 1487);
insert into SINGER (sname, singer_id, price)
values ('Henry Garcia', 27, 1747);
insert into SINGER (sname, singer_id, price)
values ('Carol Garcia', 29, 4544);
insert into SINGER (sname, singer_id, price)
values ('Jane Smith', 30, 1894);
insert into SINGER (sname, singer_id, price)
values ('Alice Miller', 32, 1996);
insert into SINGER (sname, singer_id, price)
values ('Jane Garcia', 33, 8475);
insert into SINGER (sname, singer_id, price)
values ('Jane Miller', 34, 1051);
insert into SINGER (sname, singer_id, price)
values ('Jane Miller', 36, 5556);
insert into SINGER (sname, singer_id, price)
values ('Frank Jones', 37, 3422);
insert into SINGER (sname, singer_id, price)
values ('Eve Johnson', 38, 6343);
insert into SINGER (sname, singer_id, price)
values ('Carol Johnson', 40, 1961);
insert into SINGER (sname, singer_id, price)
values ('Alice Garcia', 41, 2756);
insert into SINGER (sname, singer_id, price)
values ('Grace Doe', 42, 6231);
insert into SINGER (sname, singer_id, price)
values ('Frank Smith', 43, 8439);
insert into SINGER (sname, singer_id, price)
values ('Frank Davis', 44, 3239);
insert into SINGER (sname, singer_id, price)
values ('Bob Miller', 46, 8936);
insert into SINGER (sname, singer_id, price)
values ('Frank Johnson', 50, 9606);
insert into SINGER (sname, singer_id, price)
values ('Alice Brown', 52, 6884);
insert into SINGER (sname, singer_id, price)
values ('Eve Miller', 54, 8006);
insert into SINGER (sname, singer_id, price)
values ('Grace Miller', 58, 3766);
insert into SINGER (sname, singer_id, price)
values ('Henry Doe', 60, 2894);
insert into SINGER (sname, singer_id, price)
values ('Jane Davis', 62, 7855);
insert into SINGER (sname, singer_id, price)
values ('Alice Davis', 63, 1979);
insert into SINGER (sname, singer_id, price)
values ('Dan Johnson', 65, 9696);
insert into SINGER (sname, singer_id, price)
values ('Dan Wilson', 68, 6812);
insert into SINGER (sname, singer_id, price)
values ('Bob Jones', 69, 9008);
insert into SINGER (sname, singer_id, price)
values ('Dan Garcia', 70, 8952);
insert into SINGER (sname, singer_id, price)
values ('John Miller', 72, 1709);
insert into SINGER (sname, singer_id, price)
values ('Frank Doe', 73, 5552);
insert into SINGER (sname, singer_id, price)
values ('John Doe', 74, 9101);
insert into SINGER (sname, singer_id, price)
values ('Eve Smith', 76, 1374);
insert into SINGER (sname, singer_id, price)
values ('Frank Johnson', 77, 8904);
insert into SINGER (sname, singer_id, price)
values ('Frank Brown', 81, 2765);
insert into SINGER (sname, singer_id, price)
values ('Alice Garcia', 86, 6870);
insert into SINGER (sname, singer_id, price)
values ('Henry Johnson', 87, 2101);
insert into SINGER (sname, singer_id, price)
values ('Frank Davis', 88, 8177);
insert into SINGER (sname, singer_id, price)
values ('Henry Smith', 89, 8483);
insert into SINGER (sname, singer_id, price)
values ('Jane Smith', 92, 4337);
insert into SINGER (sname, singer_id, price)
values ('Eve Brown', 93, 5219);
insert into SINGER (sname, singer_id, price)
values ('Eve Williams', 94, 6317);
insert into SINGER (sname, singer_id, price)
values ('Eve Johnson', 95, 5195);
insert into SINGER (sname, singer_id, price)
values ('Henry Jones', 96, 8406);
insert into SINGER (sname, singer_id, price)
values ('Carol Smith', 97, 3389);
insert into SINGER (sname, singer_id, price)
values ('Jane Davis', 99, 8329);
insert into SINGER (sname, singer_id, price)
values ('Bob Johnson', 101, 4788);
insert into SINGER (sname, singer_id, price)
values ('Grace Jones', 103, 6921);
insert into SINGER (sname, singer_id, price)
values ('Eve Johnson', 107, 1642);
insert into SINGER (sname, singer_id, price)
values ('John Smith', 108, 5671);
insert into SINGER (sname, singer_id, price)
values ('Jane Jones', 109, 9317);
insert into SINGER (sname, singer_id, price)
values ('Bob Miller', 111, 5510);
insert into SINGER (sname, singer_id, price)
values ('Jane Doe', 112, 7325);
insert into SINGER (sname, singer_id, price)
values ('Eve Williams', 119, 8967);
insert into SINGER (sname, singer_id, price)
values ('Frank Garcia', 124, 8758);
insert into SINGER (sname, singer_id, price)
values ('Henry Doe', 128, 9130);
insert into SINGER (sname, singer_id, price)
values ('Dan Davis', 130, 5813);
insert into SINGER (sname, singer_id, price)
values ('Frank Johnson', 131, 9328);
insert into SINGER (sname, singer_id, price)
values ('Alice Brown', 135, 7191);
insert into SINGER (sname, singer_id, price)
values ('Frank Doe', 136, 9247);
insert into SINGER (sname, singer_id, price)
values ('Alice Doe', 137, 7481);
insert into SINGER (sname, singer_id, price)
values ('Henry Smith', 138, 8995);
insert into SINGER (sname, singer_id, price)
values ('Carol Doe', 139, 7859);
insert into SINGER (sname, singer_id, price)
values ('Jane Williams', 140, 9882);
insert into SINGER (sname, singer_id, price)
values ('Jane Brown', 141, 3015);
insert into SINGER (sname, singer_id, price)
values ('Bob Smith', 142, 6290);
insert into SINGER (sname, singer_id, price)
values ('Jane Smith', 143, 6775);
insert into SINGER (sname, singer_id, price)
values ('Jane Doe', 148, 5772);
insert into SINGER (sname, singer_id, price)
values ('Bob Jones', 149, 6595);
insert into SINGER (sname, singer_id, price)
values ('Jane Miller', 150, 5120);
insert into SINGER (sname, singer_id, price)
values ('Dan Davis', 151, 2840);
insert into SINGER (sname, singer_id, price)
values ('Jane Doe', 152, 1971);
insert into SINGER (sname, singer_id, price)
values ('Carol Smith', 153, 6071);
insert into SINGER (sname, singer_id, price)
values ('Dan Brown', 156, 4315);
insert into SINGER (sname, singer_id, price)
values ('Dan Wilson', 159, 6653);
insert into SINGER (sname, singer_id, price)
values ('Grace Johnson', 160, 2750);
insert into SINGER (sname, singer_id, price)
values ('Grace Doe', 162, 5267);
insert into SINGER (sname, singer_id, price)
values ('Carol Williams', 165, 5003);
insert into SINGER (sname, singer_id, price)
values ('Frank Williams', 166, 4022);
insert into SINGER (sname, singer_id, price)
values ('Dan Garcia', 168, 5921);
insert into SINGER (sname, singer_id, price)
values ('Bob Davis', 170, 4651);
insert into SINGER (sname, singer_id, price)
values ('Eve Garcia', 171, 7444);
insert into SINGER (sname, singer_id, price)
values ('Grace Wilson', 174, 7080);
insert into SINGER (sname, singer_id, price)
values ('Grace Doe', 175, 10617);
insert into SINGER (sname, singer_id, price)
values ('Bob Davis', 176, 2685);
insert into SINGER (sname, singer_id, price)
values ('Eve Doe', 178, 2860);
insert into SINGER (sname, singer_id, price)
values ('Henry Garcia', 179, 8801);
insert into SINGER (sname, singer_id, price)
values ('Alice Smith', 180, 4993);
insert into SINGER (sname, singer_id, price)
values ('Dan Johnson', 181, 7258);
insert into SINGER (sname, singer_id, price)
values ('Dan Garcia', 182, 8518);
insert into SINGER (sname, singer_id, price)
values ('Bob Garcia', 183, 7961);
insert into SINGER (sname, singer_id, price)
values ('Henry Wilson', 185, 3811);
commit;
prompt 100 records committed...
insert into SINGER (sname, singer_id, price)
values ('Eve Wilson', 186, 6683);
insert into SINGER (sname, singer_id, price)
values ('Eve Brown', 187, 5344);
insert into SINGER (sname, singer_id, price)
values ('Eve Smith', 188, 2533);
insert into SINGER (sname, singer_id, price)
values ('John Brown', 189, 9274);
insert into SINGER (sname, singer_id, price)
values ('Carol Miller', 191, 8541);
insert into SINGER (sname, singer_id, price)
values ('Carol Brown', 192, 6786);
insert into SINGER (sname, singer_id, price)
values ('Jane Miller', 193, 2285);
insert into SINGER (sname, singer_id, price)
values ('John Johnson', 195, 2657);
insert into SINGER (sname, singer_id, price)
values ('Carol Johnson', 196, 6316);
insert into SINGER (sname, singer_id, price)
values ('Alice Johnson', 197, 5346);
insert into SINGER (sname, singer_id, price)
values ('Alice Johnson', 200, 9521);
insert into SINGER (sname, singer_id, price)
values ('Carol Williams', 201, 1514);
insert into SINGER (sname, singer_id, price)
values ('Grace Williams', 202, 9853);
insert into SINGER (sname, singer_id, price)
values ('Alice Davis', 205, 4682);
insert into SINGER (sname, singer_id, price)
values ('Dan Jones', 206, 1841);
insert into SINGER (sname, singer_id, price)
values ('John Garcia', 207, 8454);
insert into SINGER (sname, singer_id, price)
values ('Eve Jones', 208, 8508);
insert into SINGER (sname, singer_id, price)
values ('Dan Johnson', 209, 5624);
insert into SINGER (sname, singer_id, price)
values ('Bob Miller', 211, 7543);
insert into SINGER (sname, singer_id, price)
values ('Bob Garcia', 212, 9114);
insert into SINGER (sname, singer_id, price)
values ('Bob Doe', 213, 1060);
insert into SINGER (sname, singer_id, price)
values ('Dan Brown', 214, 1089);
insert into SINGER (sname, singer_id, price)
values ('Frank Wilson', 215, 3133);
insert into SINGER (sname, singer_id, price)
values ('Grace Johnson', 216, 4285);
insert into SINGER (sname, singer_id, price)
values ('Eve Smith', 218, 3546);
insert into SINGER (sname, singer_id, price)
values ('Jane Doe', 219, 8569);
insert into SINGER (sname, singer_id, price)
values ('Dan Davis', 223, 4905);
insert into SINGER (sname, singer_id, price)
values ('Jane Garcia', 224, 8437);
insert into SINGER (sname, singer_id, price)
values ('Jane Smith', 226, 9306);
insert into SINGER (sname, singer_id, price)
values ('Frank Brown', 227, 5417);
insert into SINGER (sname, singer_id, price)
values ('John Williams', 230, 9358);
insert into SINGER (sname, singer_id, price)
values ('Eve Doe', 235, 7117);
insert into SINGER (sname, singer_id, price)
values ('Carol Wilson', 236, 4989);
insert into SINGER (sname, singer_id, price)
values ('Jane Garcia', 237, 1931);
insert into SINGER (sname, singer_id, price)
values ('Alice Smith', 238, 2273);
insert into SINGER (sname, singer_id, price)
values ('Henry Doe', 239, 5838);
insert into SINGER (sname, singer_id, price)
values ('Henry Doe', 240, 1344);
insert into SINGER (sname, singer_id, price)
values ('Alice Smith', 241, 3260);
insert into SINGER (sname, singer_id, price)
values ('Grace Wilson', 242, 9747);
insert into SINGER (sname, singer_id, price)
values ('Henry Miller', 243, 9973);
insert into SINGER (sname, singer_id, price)
values ('Grace Brown', 246, 6930);
insert into SINGER (sname, singer_id, price)
values ('John Miller', 247, 3423);
insert into SINGER (sname, singer_id, price)
values ('Grace Davis', 248, 1006);
insert into SINGER (sname, singer_id, price)
values ('Frank Garcia', 249, 1231);
insert into SINGER (sname, singer_id, price)
values ('Grace Miller', 250, 4259);
insert into SINGER (sname, singer_id, price)
values ('Jane Smith', 252, 5535);
insert into SINGER (sname, singer_id, price)
values ('Jane Wilson', 253, 7360);
insert into SINGER (sname, singer_id, price)
values ('Bob Miller', 255, 2300);
insert into SINGER (sname, singer_id, price)
values ('Henry Smith', 256, 6797);
insert into SINGER (sname, singer_id, price)
values ('Bob Miller', 257, 7852);
insert into SINGER (sname, singer_id, price)
values ('Grace Doe', 259, 9827);
insert into SINGER (sname, singer_id, price)
values ('Carol Doe', 261, 2674);
insert into SINGER (sname, singer_id, price)
values ('Carol Miller', 264, 4056);
insert into SINGER (sname, singer_id, price)
values ('Frank Garcia', 266, 2288);
insert into SINGER (sname, singer_id, price)
values ('Frank Jones', 267, 9448);
insert into SINGER (sname, singer_id, price)
values ('Alice Garcia', 268, 5910);
insert into SINGER (sname, singer_id, price)
values ('Bob Wilson', 269, 2032);
insert into SINGER (sname, singer_id, price)
values ('John Doe', 272, 2936);
insert into SINGER (sname, singer_id, price)
values ('Frank Miller', 278, 6756);
insert into SINGER (sname, singer_id, price)
values ('John Davis', 279, 5176);
insert into SINGER (sname, singer_id, price)
values ('Frank Garcia', 280, 4762);
insert into SINGER (sname, singer_id, price)
values ('Grace Johnson', 282, 7763);
insert into SINGER (sname, singer_id, price)
values ('John Johnson', 286, 9032);
insert into SINGER (sname, singer_id, price)
values ('Eve Johnson', 287, 1420);
insert into SINGER (sname, singer_id, price)
values ('Dan Miller', 288, 4275);
insert into SINGER (sname, singer_id, price)
values ('Bob Davis', 290, 6350);
insert into SINGER (sname, singer_id, price)
values ('Dan Wilson', 292, 1171);
insert into SINGER (sname, singer_id, price)
values ('Dan Jones', 293, 5010);
insert into SINGER (sname, singer_id, price)
values ('Henry Williams', 297, 8226);
insert into SINGER (sname, singer_id, price)
values ('Dan Garcia', 299, 5313);
insert into SINGER (sname, singer_id, price)
values ('Eve Miller', 302, 7175);
insert into SINGER (sname, singer_id, price)
values ('Grace Miller', 303, 5713);
insert into SINGER (sname, singer_id, price)
values ('Carol Jones', 305, 6722);
insert into SINGER (sname, singer_id, price)
values ('John Jones', 306, 2679);
insert into SINGER (sname, singer_id, price)
values ('Dan Johnson', 307, 8218);
insert into SINGER (sname, singer_id, price)
values ('John Smith', 309, 9391);
insert into SINGER (sname, singer_id, price)
values ('Bob Johnson', 310, 7078);
insert into SINGER (sname, singer_id, price)
values ('Henry Williams', 311, 9599);
insert into SINGER (sname, singer_id, price)
values ('Jane Smith', 313, 4142);
insert into SINGER (sname, singer_id, price)
values ('Jane Wilson', 315, 2052);
insert into SINGER (sname, singer_id, price)
values ('Grace Brown', 318, 7149);
insert into SINGER (sname, singer_id, price)
values ('Eve Johnson', 320, 2601);
insert into SINGER (sname, singer_id, price)
values ('Eve Johnson', 321, 9848);
insert into SINGER (sname, singer_id, price)
values ('John Miller', 322, 7475);
insert into SINGER (sname, singer_id, price)
values ('Eve Johnson', 324, 1112);
insert into SINGER (sname, singer_id, price)
values ('Henry Johnson', 325, 7968);
insert into SINGER (sname, singer_id, price)
values ('Eve Johnson', 326, 4723);
insert into SINGER (sname, singer_id, price)
values ('Carol Doe', 327, 6292);
insert into SINGER (sname, singer_id, price)
values ('Bob Davis', 332, 4615);
insert into SINGER (sname, singer_id, price)
values ('Bob Garcia', 333, 7044);
insert into SINGER (sname, singer_id, price)
values ('Bob Miller', 335, 1479);
insert into SINGER (sname, singer_id, price)
values ('Eve Doe', 336, 6932);
insert into SINGER (sname, singer_id, price)
values ('Frank Johnson', 339, 9913);
insert into SINGER (sname, singer_id, price)
values ('Dan Doe', 340, 1521);
insert into SINGER (sname, singer_id, price)
values ('Dan Brown', 343, 3623);
insert into SINGER (sname, singer_id, price)
values ('Dan Doe', 344, 1152);
insert into SINGER (sname, singer_id, price)
values ('Grace Davis', 345, 1577);
insert into SINGER (sname, singer_id, price)
values ('Jane Miller', 346, 5071);
insert into SINGER (sname, singer_id, price)
values ('Frank Brown', 350, 6772);
insert into SINGER (sname, singer_id, price)
values ('Dan Williams', 351, 9403);
commit;
prompt 200 records committed...
insert into SINGER (sname, singer_id, price)
values ('Bob Wilson', 352, 2552);
insert into SINGER (sname, singer_id, price)
values ('Jane Garcia', 353, 1256);
insert into SINGER (sname, singer_id, price)
values ('Jane Davis', 354, 1139);
insert into SINGER (sname, singer_id, price)
values ('John Doe', 358, 7654);
insert into SINGER (sname, singer_id, price)
values ('Frank Davis', 359, 6232);
insert into SINGER (sname, singer_id, price)
values ('Bob Williams', 360, 6824);
insert into SINGER (sname, singer_id, price)
values ('Carol Wilson', 362, 7785);
insert into SINGER (sname, singer_id, price)
values ('Jane Doe', 363, 7762);
insert into SINGER (sname, singer_id, price)
values ('John Garcia', 364, 5405);
insert into SINGER (sname, singer_id, price)
values ('John Garcia', 365, 5028);
insert into SINGER (sname, singer_id, price)
values ('Henry Davis', 367, 9531);
insert into SINGER (sname, singer_id, price)
values ('Alice Williams', 368, 1648);
insert into SINGER (sname, singer_id, price)
values ('Dan Doe', 371, 6228);
insert into SINGER (sname, singer_id, price)
values ('Grace Brown', 375, 6711);
insert into SINGER (sname, singer_id, price)
values ('Henry Brown', 379, 10369);
insert into SINGER (sname, singer_id, price)
values ('Dan Williams', 380, 9221);
insert into SINGER (sname, singer_id, price)
values ('John Johnson', 381, 8902);
insert into SINGER (sname, singer_id, price)
values ('Grace Brown', 383, 8719);
insert into SINGER (sname, singer_id, price)
values ('Grace Smith', 385, 2092);
insert into SINGER (sname, singer_id, price)
values ('Bob Brown', 388, 4198);
insert into SINGER (sname, singer_id, price)
values ('John Smith', 392, 7403);
insert into SINGER (sname, singer_id, price)
values ('Eve Doe', 393, 7976);
insert into SINGER (sname, singer_id, price)
values ('Carol Johnson', 395, 7841);
insert into SINGER (sname, singer_id, price)
values ('Eve Doe', 396, 1095);
insert into SINGER (sname, singer_id, price)
values ('Alice Johnson', 397, 2216);
insert into SINGER (sname, singer_id, price)
values ('Jane Smith', 398, 5935);
insert into SINGER (sname, singer_id, price)
values ('Henry Williams', 399, 7749);
insert into SINGER (sname, singer_id, price)
values ('Grace Wilson', 401, 3074);
insert into SINGER (sname, singer_id, price)
values ('Grace Garcia', 403, 8497);
insert into SINGER (sname, singer_id, price)
values ('Jane Johnson', 406, 6179);
insert into SINGER (sname, singer_id, price)
values ('Bob Brown', 411, 5791);
insert into SINGER (sname, singer_id, price)
values ('Eve Garcia', 412, 7730);
insert into SINGER (sname, singer_id, price)
values ('Grace Williams', 413, 9251);
insert into SINGER (sname, singer_id, price)
values ('Alice Miller', 414, 3593);
insert into SINGER (sname, singer_id, price)
values ('Dan Jones', 415, 7873);
insert into SINGER (sname, singer_id, price)
values ('Bob Miller', 417, 8345);
insert into SINGER (sname, singer_id, price)
values ('Alice Wilson', 418, 2743);
insert into SINGER (sname, singer_id, price)
values ('Dan Davis', 420, 2593);
insert into SINGER (sname, singer_id, price)
values ('John Miller', 421, 4932);
insert into SINGER (sname, singer_id, price)
values ('Dan Brown', 425, 2018);
insert into SINGER (sname, singer_id, price)
values ('Alice Brown', 427, 5503);
insert into SINGER (sname, singer_id, price)
values ('Carol Jones', 428, 6808);
insert into SINGER (sname, singer_id, price)
values ('Dan Garcia', 429, 6472);
insert into SINGER (sname, singer_id, price)
values ('Jane Wilson', 430, 7223);
insert into SINGER (sname, singer_id, price)
values ('Jane Johnson', 431, 3719);
insert into SINGER (sname, singer_id, price)
values ('Jane Wilson', 432, 1909);
insert into SINGER (sname, singer_id, price)
values ('Jane Williams', 433, 9548);
insert into SINGER (sname, singer_id, price)
values ('Frank Johnson', 434, 8140);
insert into SINGER (sname, singer_id, price)
values ('John Doe', 435, 6832);
insert into SINGER (sname, singer_id, price)
values ('John Wilson', 437, 6013);
insert into SINGER (sname, singer_id, price)
values ('Grace Williams', 438, 9293);
insert into SINGER (sname, singer_id, price)
values ('Alice Garcia', 443, 2060);
insert into SINGER (sname, singer_id, price)
values ('Bob Miller', 444, 2546);
insert into SINGER (sname, singer_id, price)
values ('Frank Davis', 445, 4712);
insert into SINGER (sname, singer_id, price)
values ('Carol Smith', 446, 1868);
insert into SINGER (sname, singer_id, price)
values ('Henry Davis', 447, 6088);
insert into SINGER (sname, singer_id, price)
values ('John Doe', 448, 7215);
insert into SINGER (sname, singer_id, price)
values ('Bob Brown', 449, 1548);
commit;
prompt 258 records loaded
prompt Loading EVENT...
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('28-11-2022', 'dd-mm-yyyy'), 'Ruby Gardens', 12278, 1, 482, 151, 525, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('31-12-2020', 'dd-mm-yyyy'), 'Ethereal Ballro', 10225, 2, 265, 246, 337, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-02-2028', 'dd-mm-yyyy'), 'Whispering Gard', 10766, 3, 456, 447, 221, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('03-03-2028', 'dd-mm-yyyy'), 'Grandeur Hall', 15848, 4, 238, 430, 257, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('29-01-2021', 'dd-mm-yyyy'), 'Pearl Pavilion', 12014, 5, 278, 62, 541, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('23-11-2020', 'dd-mm-yyyy'), 'Pearl Pavilion', 17304, 6, 431, 411, 138, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('24-11-2027', 'dd-mm-yyyy'), 'Gilded Palace', 16787, 7, 406, 143, 184, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('27-08-2022', 'dd-mm-yyyy'), 'Topaz Terrace', 17550, 8, 480, 166, 134, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('26-05-2025', 'dd-mm-yyyy'), 'Moonbeam Hall', 18631, 9, 529, 392, 376, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('13-02-2024', 'dd-mm-yyyy'), 'Tranquil Garden', 17605, 10, 504, 208, 455, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('27-09-2021', 'dd-mm-yyyy'), 'Whispering Gard', 8885, 11, 515, 32, 388, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('11-08-2022', 'dd-mm-yyyy'), 'Mystic Terrace', 12092, 12, 446, 339, 508, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-05-2020', 'dd-mm-yyyy'), 'Noble Hall', 21092, 13, 259, 367, 204, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('13-07-2022', 'dd-mm-yyyy'), 'Grand Oasis Hal', 21948, 14, 308, 383, 299, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('16-10-2022', 'dd-mm-yyyy'), 'Luxury Pavilion', 14144, 16, 291, 33, 138, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('19-04-2027', 'dd-mm-yyyy'), 'Silver Springs ', 9824, 17, 326, 303, 408, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('03-11-2025', 'dd-mm-yyyy'), 'Noble Hall', 13546, 18, 209, 226, 411, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('16-03-2027', 'dd-mm-yyyy'), 'Harmony Hall', 11499, 19, 348, 375, 457, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('19-02-2026', 'dd-mm-yyyy'), 'Victory Pavilio', 15684, 20, 386, 415, 347, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('07-03-2027', 'dd-mm-yyyy'), 'Regal Ballroom', 5693, 21, 350, 432, 395, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('11-12-2023', 'dd-mm-yyyy'), 'Silver Springs ', 4855, 22, 377, 213, 400, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('14-06-2024', 'dd-mm-yyyy'), 'Whispering Gard', 15314, 23, 328, 302, 214, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('12-02-2024', 'dd-mm-yyyy'), 'Noble Hall', 12342, 24, 409, 315, 383, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('10-01-2024', 'dd-mm-yyyy'), 'Grand Oasis Hal', 19357, 25, 289, 326, 497, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-05-2023', 'dd-mm-yyyy'), 'Noble Hall', 15146, 26, 416, 379, 229, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('09-02-2021', 'dd-mm-yyyy'), 'Harmony Hall', 14246, 27, 539, 321, 346, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('06-01-2022', 'dd-mm-yyyy'), 'Dreamy Manor', 18820, 28, 289, 427, 338, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('14-03-2028', 'dd-mm-yyyy'), 'Dreamy Manor', 13260, 29, 203, 68, 397, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('02-12-2025', 'dd-mm-yyyy'), 'Sapphire Hall', 14107, 30, 555, 333, 390, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('04-12-2027', 'dd-mm-yyyy'), 'Pearl Pavilion', 14383, 31, 241, 193, 487, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('19-04-2023', 'dd-mm-yyyy'), 'Royal Garden Ha', 7283, 32, 453, 23, 407, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('21-05-2026', 'dd-mm-yyyy'), 'Radiant Hall', 5985, 33, 441, 60, 239, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('28-06-2026', 'dd-mm-yyyy'), 'Dreamy Manor', 12120, 34, 526, 130, 147, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('19-03-2021', 'dd-mm-yyyy'), 'Harmony Hall', 7585, 35, 407, 63, 464, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('04-05-2024', 'dd-mm-yyyy'), 'Grand Oasis Hal', 4714, 36, 544, 354, 218, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('28-10-2024', 'dd-mm-yyyy'), 'Glamorous Ballr', 13329, 37, 271, 108, 350, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('12-10-2028', 'dd-mm-yyyy'), 'Glamorous Ballr', 12678, 38, 310, 42, 544, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('21-03-2024', 'dd-mm-yyyy'), 'Glamorous Ballr', 12913, 39, 300, 6, 271, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('16-02-2028', 'dd-mm-yyyy'), 'Ruby Gardens', 13588, 40, 268, 168, 227, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('29-05-2025', 'dd-mm-yyyy'), 'Luxury Pavilion', 9327, 42, 286, 26, 113, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('16-10-2022', 'dd-mm-yyyy'), 'Tranquil Garden', 13867, 43, 598, 429, 346, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('20-09-2024', 'dd-mm-yyyy'), 'Heavenly Terrac', 14180, 44, 503, 13, 170, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('15-11-2021', 'dd-mm-yyyy'), 'Diamond Palace', 14404, 45, 598, 142, 290, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('02-06-2026', 'dd-mm-yyyy'), 'Pearl Pavilion', 16459, 46, 359, 288, 520, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('26-01-2028', 'dd-mm-yyyy'), 'Platinum Plaza', 11199, 47, 558, 443, 183, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('09-08-2023', 'dd-mm-yyyy'), 'Grandeur Hall', 13736, 48, 559, 86, 389, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('27-04-2022', 'dd-mm-yyyy'), 'Aurora Ballroom', 15388, 49, 521, 185, 406, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('28-06-2024', 'dd-mm-yyyy'), 'Elegant Terrace', 8353, 50, 201, 388, 434, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('02-07-2025', 'dd-mm-yyyy'), 'Glamorous Ballr', 17612, 51, 401, 375, 125, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('20-03-2027', 'dd-mm-yyyy'), 'Moonbeam Hall', 13862, 52, 320, 398, 326, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('08-06-2021', 'dd-mm-yyyy'), 'Silver Springs ', 13994, 53, 547, 109, 446, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('21-02-2021', 'dd-mm-yyyy'), 'Diamond Palace', 10419, 54, 387, 290, 471, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('22-05-2028', 'dd-mm-yyyy'), 'Enchanted Garde', 15870, 55, 588, 339, 542, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('08-04-2026', 'dd-mm-yyyy'), 'Tranquil Garden', 16092, 56, 537, 420, 252, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('10-10-2021', 'dd-mm-yyyy'), 'Platinum Plaza', 10879, 57, 373, 224, 375, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('03-10-2024', 'dd-mm-yyyy'), 'Whispering Gard', 19324, 58, 359, 139, 424, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('31-10-2024', 'dd-mm-yyyy'), 'Topaz Terrace', 21746, 59, 589, 379, 345, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('19-08-2027', 'dd-mm-yyyy'), 'Eclipse Ballroo', 16718, 60, 221, 432, 292, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('11-10-2021', 'dd-mm-yyyy'), 'Pearl Pavilion', 4653, 61, 244, 340, 109, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('06-05-2023', 'dd-mm-yyyy'), 'Jade Hall', 11656, 62, 391, 148, 161, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('19-09-2022', 'dd-mm-yyyy'), 'Jade Hall', 21581, 63, 594, 175, 466, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('01-12-2028', 'dd-mm-yyyy'), 'Eclipse Ballroo', 13201, 64, 599, 174, 335, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('30-11-2022', 'dd-mm-yyyy'), 'Tranquil Garden', 12496, 65, 250, 36, 189, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('14-03-2027', 'dd-mm-yyyy'), 'Ruby Gardens', 7353, 66, 494, 279, 460, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('05-02-2022', 'dd-mm-yyyy'), 'Eclipse Ballroo', 11067, 67, 588, 445, 123, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('01-02-2027', 'dd-mm-yyyy'), 'Luxury Pavilion', 18697, 68, 385, 395, 510, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('11-04-2021', 'dd-mm-yyyy'), 'Noble Hall', 16340, 69, 553, 52, 458, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('28-12-2026', 'dd-mm-yyyy'), 'Dreamy Manor', 11881, 70, 448, 3, 129, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('29-03-2025', 'dd-mm-yyyy'), 'Whispering Gard', 14162, 71, 433, 211, 259, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('01-08-2024', 'dd-mm-yyyy'), 'Elegant Terrace', 18083, 72, 423, 429, 210, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('31-08-2027', 'dd-mm-yyyy'), 'Sapphire Hall', 4949, 73, 258, 152, 415, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('31-12-2025', 'dd-mm-yyyy'), 'Sapphire Hall', 20481, 75, 365, 393, 387, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('08-12-2025', 'dd-mm-yyyy'), 'Topaz Terrace', 19684, 76, 260, 307, 495, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('11-06-2027', 'dd-mm-yyyy'), 'Aurora Ballroom', 7562, 77, 373, 150, 115, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('02-12-2023', 'dd-mm-yyyy'), 'Glamorous Ballr', 12938, 78, 514, 227, 415, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('08-06-2021', 'dd-mm-yyyy'), 'Eclipse Ballroo', 15721, 79, 573, 8, 336, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('28-10-2028', 'dd-mm-yyyy'), 'Victory Pavilio', 6727, 80, 499, 324, 460, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('16-08-2027', 'dd-mm-yyyy'), 'Gilded Palace', 20151, 81, 382, 124, 120, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('02-02-2028', 'dd-mm-yyyy'), 'Serene Pavilion', 6140, 82, 368, 97, 438, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('08-10-2027', 'dd-mm-yyyy'), 'Serene Pavilion', 10157, 83, 246, 181, 516, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-12-2024', 'dd-mm-yyyy'), 'Silver Springs ', 3917, 84, 501, 32, 246, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('07-01-2026', 'dd-mm-yyyy'), 'Dazzle Pavilion', 20815, 85, 460, 428, 494, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('25-11-2020', 'dd-mm-yyyy'), 'Radiant Hall', 8334, 86, 239, 406, 435, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('03-03-2022', 'dd-mm-yyyy'), 'Royal Garden Ha', 11237, 87, 571, 215, 302, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-05-2028', 'dd-mm-yyyy'), 'Ruby Gardens', 15967, 88, 277, 156, 171, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('01-06-2027', 'dd-mm-yyyy'), 'Aurora Ballroom', 17433, 89, 431, 13, 271, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('08-09-2025', 'dd-mm-yyyy'), 'Sapphire Hall', 11901, 90, 387, 350, 124, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('02-11-2021', 'dd-mm-yyyy'), 'Diamond Palace', 22493, 91, 259, 243, 518, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('03-12-2024', 'dd-mm-yyyy'), 'Starlight Pavil', 13604, 92, 335, 195, 338, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('02-02-2027', 'dd-mm-yyyy'), 'Glamorous Ballr', 7961, 93, 576, 176, 294, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('10-08-2023', 'dd-mm-yyyy'), 'Gilded Palace', 6513, 94, 414, 272, 453, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-06-2028', 'dd-mm-yyyy'), 'Blissful Palace', 8270, 95, 279, 344, 401, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('25-01-2027', 'dd-mm-yyyy'), 'Dreamy Manor', 12181, 96, 543, 345, 300, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('13-02-2028', 'dd-mm-yyyy'), 'Grand Oasis Hal', 19613, 97, 360, 336, 318, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('31-01-2023', 'dd-mm-yyyy'), 'Heavenly Terrac', 18540, 98, 308, 166, 278, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('03-02-2027', 'dd-mm-yyyy'), 'Jade Hall', 12370, 99, 596, 69, 195, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('13-05-2024', 'dd-mm-yyyy'), 'Grandeur Hall', 7007, 100, 348, 320, 245, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('25-04-2026', 'dd-mm-yyyy'), 'Blissful Palace', 4077, 101, 361, 385, 230, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('23-04-2023', 'dd-mm-yyyy'), 'Amethyst Ballro', 6482, 102, 438, 313, 166, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('09-10-2023', 'dd-mm-yyyy'), 'Radiant Hall', 13119, 103, 568, 174, 425, 6);
commit;
prompt 100 records committed...
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('20-01-2027', 'dd-mm-yyyy'), 'Whispering Gard', 19825, 104, 423, 309, 324, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('02-10-2024', 'dd-mm-yyyy'), 'Moonbeam Hall', 15654, 105, 280, 13, 528, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('04-06-2025', 'dd-mm-yyyy'), 'Radiant Hall', 12349, 106, 208, 399, 357, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('17-09-2027', 'dd-mm-yyyy'), 'Topaz Terrace', 19380, 107, 409, 403, 252, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('15-10-2024', 'dd-mm-yyyy'), 'Topaz Terrace', 11449, 108, 295, 25, 288, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('07-03-2025', 'dd-mm-yyyy'), 'Aurora Ballroom', 17751, 109, 329, 363, 497, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('02-06-2022', 'dd-mm-yyyy'), 'Sunset Ballroom', 15923, 110, 217, 282, 235, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('23-05-2026', 'dd-mm-yyyy'), 'Onyx Mansion', 12821, 112, 202, 413, 312, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('28-10-2026', 'dd-mm-yyyy'), 'Sapphire Hall', 17905, 113, 243, 417, 190, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('30-10-2026', 'dd-mm-yyyy'), 'Opal Palace', 13318, 114, 551, 307, 521, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('06-07-2022', 'dd-mm-yyyy'), 'Harmony Hall', 13123, 115, 525, 74, 399, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('12-02-2025', 'dd-mm-yyyy'), 'Cherished Garde', 9785, 116, 344, 141, 459, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('04-05-2020', 'dd-mm-yyyy'), 'Jade Hall', 13877, 117, 593, 449, 399, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('08-11-2026', 'dd-mm-yyyy'), 'Sunset Ballroom', 16315, 118, 480, 93, 474, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('26-11-2027', 'dd-mm-yyyy'), 'Royal Garden Ha', 13024, 119, 534, 303, 518, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('25-11-2023', 'dd-mm-yyyy'), 'Opal Palace', 16742, 120, 382, 227, 332, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('11-12-2020', 'dd-mm-yyyy'), 'Blissful Palace', 15278, 121, 515, 230, 231, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('28-05-2024', 'dd-mm-yyyy'), 'Pearl Pavilion', 17315, 122, 272, 201, 511, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('16-06-2023', 'dd-mm-yyyy'), 'Dazzle Pavilion', 22043, 124, 537, 140, 182, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('28-12-2024', 'dd-mm-yyyy'), 'Enchanted Garde', 9839, 125, 512, 30, 132, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-03-2023', 'dd-mm-yyyy'), 'Platinum Plaza', 12550, 126, 322, 414, 540, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('25-02-2025', 'dd-mm-yyyy'), 'Amethyst Ballro', 11648, 127, 574, 65, 313, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('03-05-2022', 'dd-mm-yyyy'), 'Noble Hall', 14219, 128, 554, 305, 327, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('28-06-2028', 'dd-mm-yyyy'), 'Tranquil Garden', 7447, 129, 229, 446, 358, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('21-01-2026', 'dd-mm-yyyy'), 'Majestic Manor', 14861, 130, 509, 200, 121, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('24-05-2021', 'dd-mm-yyyy'), 'Jade Hall', 13676, 131, 313, 346, 137, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('10-03-2026', 'dd-mm-yyyy'), 'Crystal Ballroo', 18623, 132, 477, 434, 337, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('11-05-2023', 'dd-mm-yyyy'), 'Platinum Plaza', 16656, 133, 464, 311, 242, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('16-09-2021', 'dd-mm-yyyy'), 'Harmony Hall', 9745, 134, 380, 239, 423, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('01-10-2021', 'dd-mm-yyyy'), 'Serene Pavilion', 10542, 135, 454, 103, 520, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('15-05-2024', 'dd-mm-yyyy'), 'Opal Palace', 11759, 137, 319, 187, 159, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('16-02-2025', 'dd-mm-yyyy'), 'Ruby Gardens', 16496, 138, 480, 10, 384, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('23-08-2026', 'dd-mm-yyyy'), 'Celestial Terra', 7356, 139, 208, 41, 167, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-05-2028', 'dd-mm-yyyy'), 'Jade Hall', 4717, 140, 442, 87, 379, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('07-03-2020', 'dd-mm-yyyy'), 'Breathtaking Te', 9233, 141, 542, 142, 101, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('08-01-2021', 'dd-mm-yyyy'), 'Exquisite Pavil', 8986, 142, 420, 10, 296, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('05-03-2024', 'dd-mm-yyyy'), 'Victory Pavilio', 11346, 143, 464, 94, 133, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('21-01-2024', 'dd-mm-yyyy'), 'Eclipse Ballroo', 17139, 144, 315, 448, 254, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('12-10-2022', 'dd-mm-yyyy'), 'Starlight Pavil', 20793, 145, 580, 413, 113, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('08-11-2022', 'dd-mm-yyyy'), 'Sapphire Hall', 12805, 146, 594, 206, 510, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('09-02-2023', 'dd-mm-yyyy'), 'Gilded Palace', 15969, 147, 559, 119, 147, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('26-06-2028', 'dd-mm-yyyy'), 'Royal Garden Ha', 9827, 148, 323, 290, 422, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('21-04-2023', 'dd-mm-yyyy'), 'Opal Palace', 13611, 149, 578, 196, 336, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('06-11-2020', 'dd-mm-yyyy'), 'Serene Pavilion', 18866, 150, 562, 379, 162, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('12-11-2022', 'dd-mm-yyyy'), 'Ethereal Ballro', 14280, 151, 313, 421, 341, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('07-08-2021', 'dd-mm-yyyy'), 'Sapphire Hall', 17323, 152, 365, 187, 143, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('03-02-2024', 'dd-mm-yyyy'), 'Amethyst Ballro', 6951, 153, 456, 238, 280, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('09-08-2026', 'dd-mm-yyyy'), 'Cherished Garde', 20179, 154, 381, 43, 470, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('14-03-2024', 'dd-mm-yyyy'), 'Harmony Hall', 16913, 155, 284, 415, 454, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-05-2023', 'dd-mm-yyyy'), 'Tranquil Garden', 8707, 156, 389, 108, 211, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('02-05-2022', 'dd-mm-yyyy'), 'Whispering Gard', 18668, 157, 292, 195, 243, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('08-05-2028', 'dd-mm-yyyy'), 'Mystic Terrace', 17067, 158, 521, 205, 206, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('21-05-2024', 'dd-mm-yyyy'), 'Luxury Pavilion', 11836, 159, 536, 170, 373, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('20-02-2021', 'dd-mm-yyyy'), 'Elite Mansion', 17250, 160, 257, 252, 332, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('13-10-2020', 'dd-mm-yyyy'), 'Glamorous Ballr', 10186, 161, 348, 252, 245, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('28-12-2023', 'dd-mm-yyyy'), 'Majestic Manor', 8890, 162, 446, 375, 241, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('28-01-2024', 'dd-mm-yyyy'), 'Aurora Ballroom', 13637, 163, 301, 219, 117, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('01-09-2028', 'dd-mm-yyyy'), 'Topaz Terrace', 5320, 164, 274, 237, 361, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('27-04-2026', 'dd-mm-yyyy'), 'Regal Ballroom', 9893, 165, 361, 448, 493, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('24-05-2022', 'dd-mm-yyyy'), 'Radiant Hall', 15087, 166, 479, 96, 503, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('05-04-2021', 'dd-mm-yyyy'), 'Ruby Gardens', 17776, 167, 219, 101, 218, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('28-10-2024', 'dd-mm-yyyy'), 'Glamorous Ballr', 13015, 168, 442, 99, 264, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('25-05-2026', 'dd-mm-yyyy'), 'Heavenly Terrac', 9995, 169, 246, 239, 332, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('14-09-2022', 'dd-mm-yyyy'), 'Mystic Terrace', 18080, 170, 458, 392, 195, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('02-12-2023', 'dd-mm-yyyy'), 'Moonbeam Hall', 6159, 171, 519, 249, 391, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('27-05-2025', 'dd-mm-yyyy'), 'Imperial Mansio', 19974, 172, 590, 380, 486, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('19-07-2025', 'dd-mm-yyyy'), 'Regal Ballroom', 7755, 173, 326, 37, 376, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('10-07-2028', 'dd-mm-yyyy'), 'Elite Mansion', 11135, 174, 379, 242, 526, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('13-04-2025', 'dd-mm-yyyy'), 'Noble Hall', 5081, 175, 387, 255, 341, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('28-05-2022', 'dd-mm-yyyy'), 'Eclipse Ballroo', 13195, 176, 440, 54, 485, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('13-08-2028', 'dd-mm-yyyy'), 'Celestial Terra', 12995, 177, 498, 311, 488, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('31-03-2021', 'dd-mm-yyyy'), 'Platinum Plaza', 10450, 178, 351, 368, 403, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('03-11-2022', 'dd-mm-yyyy'), 'Glamorous Ballr', 8243, 179, 350, 162, 395, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('20-12-2021', 'dd-mm-yyyy'), 'Victory Pavilio', 21977, 180, 365, 136, 500, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('07-05-2021', 'dd-mm-yyyy'), 'Sapphire Hall', 8643, 181, 383, 205, 346, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('29-11-2025', 'dd-mm-yyyy'), 'Royal Garden Ha', 18741, 182, 444, 189, 257, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('01-08-2027', 'dd-mm-yyyy'), 'Pearl Pavilion', 18296, 184, 492, 246, 481, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('16-05-2028', 'dd-mm-yyyy'), 'Celestial Terra', 14239, 185, 284, 29, 421, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('06-06-2027', 'dd-mm-yyyy'), 'Victory Pavilio', 18427, 186, 360, 38, 186, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-04-2027', 'dd-mm-yyyy'), 'Moonbeam Hall', 13900, 187, 353, 131, 514, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('28-05-2024', 'dd-mm-yyyy'), 'Heavenly Terrac', 20026, 188, 308, 256, 144, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('26-12-2024', 'dd-mm-yyyy'), 'Grandeur Hall', 8910, 189, 291, 352, 437, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('11-12-2027', 'dd-mm-yyyy'), 'Grandeur Hall', 12667, 190, 520, 96, 199, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('01-06-2024', 'dd-mm-yyyy'), 'Pearl Pavilion', 8532, 191, 204, 261, 449, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('24-09-2022', 'dd-mm-yyyy'), 'Elegant Terrace', 15743, 192, 233, 360, 127, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('13-09-2025', 'dd-mm-yyyy'), 'Amethyst Ballro', 6759, 194, 274, 269, 162, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('11-02-2025', 'dd-mm-yyyy'), 'Topaz Terrace', 14123, 195, 204, 211, 113, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('27-12-2022', 'dd-mm-yyyy'), 'Dreamy Manor', 13909, 196, 296, 218, 346, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('25-08-2025', 'dd-mm-yyyy'), 'Cherished Garde', 20664, 197, 285, 128, 394, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('30-09-2021', 'dd-mm-yyyy'), 'Cherished Garde', 4813, 198, 248, 345, 299, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('12-07-2024', 'dd-mm-yyyy'), 'Onyx Mansion', 7006, 199, 372, 166, 463, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('31-10-2027', 'dd-mm-yyyy'), 'Dazzle Pavilion', 17575, 200, 397, 202, 271, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('22-06-2027', 'dd-mm-yyyy'), 'Pearl Pavilion', 9241, 201, 367, 358, 256, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('07-04-2028', 'dd-mm-yyyy'), 'Whispering Gard', 13124, 202, 322, 371, 509, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('16-01-2023', 'dd-mm-yyyy'), 'Ruby Gardens', 21564, 203, 580, 175, 323, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('11-02-2022', 'dd-mm-yyyy'), 'Eclipse Ballroo', 17135, 204, 286, 207, 107, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('04-06-2026', 'dd-mm-yyyy'), 'Blissful Palace', 13868, 205, 303, 435, 170, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('12-06-2027', 'dd-mm-yyyy'), 'Tranquil Garden', 11942, 206, 459, 380, 470, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('07-06-2022', 'dd-mm-yyyy'), 'Silver Springs ', 20005, 207, 593, 305, 330, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('07-11-2023', 'dd-mm-yyyy'), 'Jade Hall', 15859, 208, 338, 183, 205, 1);
commit;
prompt 200 records committed...
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('01-10-2022', 'dd-mm-yyyy'), 'Aurora Ballroom', 13291, 209, 533, 259, 320, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('23-01-2021', 'dd-mm-yyyy'), 'Harmony Hall', 14176, 210, 479, 52, 376, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('15-11-2021', 'dd-mm-yyyy'), 'Breathtaking Te', 8615, 211, 582, 280, 241, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('13-07-2023', 'dd-mm-yyyy'), 'Royal Garden Ha', 19546, 212, 257, 327, 164, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('01-06-2022', 'dd-mm-yyyy'), 'Grandeur Hall', 8120, 213, 303, 178, 338, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('20-04-2025', 'dd-mm-yyyy'), 'Royal Garden Ha', 8544, 214, 592, 397, 458, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-03-2025', 'dd-mm-yyyy'), 'Breathtaking Te', 14722, 215, 579, 399, 415, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('17-04-2027', 'dd-mm-yyyy'), 'Cherished Garde', 17298, 216, 587, 367, 547, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('26-01-2022', 'dd-mm-yyyy'), 'Platinum Plaza', 15831, 217, 219, 216, 189, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('20-02-2028', 'dd-mm-yyyy'), 'Sunset Ballroom', 19085, 219, 272, 266, 443, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('06-11-2025', 'dd-mm-yyyy'), 'Mystic Terrace', 13891, 220, 370, 160, 382, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('02-11-2028', 'dd-mm-yyyy'), 'Enchanted Garde', 18792, 221, 212, 21, 169, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('19-02-2028', 'dd-mm-yyyy'), 'Tranquil Garden', 11007, 223, 599, 60, 107, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('07-03-2028', 'dd-mm-yyyy'), 'Imperial Mansio', 7218, 224, 326, 335, 316, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('02-06-2028', 'dd-mm-yyyy'), 'Amethyst Ballro', 18396, 225, 447, 46, 314, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-12-2024', 'dd-mm-yyyy'), 'Noble Hall', 8973, 226, 555, 396, 485, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-05-2021', 'dd-mm-yyyy'), 'Emerald Manor', 11763, 227, 344, 180, 362, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('27-05-2022', 'dd-mm-yyyy'), 'Blissful Palace', 13415, 228, 556, 58, 330, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('16-04-2024', 'dd-mm-yyyy'), 'Jade Hall', 9955, 229, 396, 95, 124, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('17-05-2021', 'dd-mm-yyyy'), 'Moonbeam Hall', 11665, 230, 505, 246, 440, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('02-12-2024', 'dd-mm-yyyy'), 'Majestic Manor', 12833, 231, 204, 191, 324, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('11-04-2025', 'dd-mm-yyyy'), 'Crystal Ballroo', 9056, 232, 464, 313, 323, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('07-01-2021', 'dd-mm-yyyy'), 'Blissful Palace', 11399, 233, 216, 10, 462, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('28-05-2023', 'dd-mm-yyyy'), 'Dreamy Manor', 14723, 234, 462, 388, 203, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('10-05-2024', 'dd-mm-yyyy'), 'Breathtaking Te', 17913, 236, 333, 89, 320, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('14-12-2024', 'dd-mm-yyyy'), 'Elite Mansion', 21613, 237, 259, 212, 217, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('28-12-2027', 'dd-mm-yyyy'), 'Harmony Hall', 15242, 238, 530, 197, 181, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('30-07-2027', 'dd-mm-yyyy'), 'Gilded Palace', 13445, 239, 485, 362, 302, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('21-08-2023', 'dd-mm-yyyy'), 'Enchanted Garde', 15231, 240, 325, 418, 302, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('30-10-2020', 'dd-mm-yyyy'), 'Ruby Gardens', 9593, 241, 253, 358, 166, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('19-04-2024', 'dd-mm-yyyy'), 'Radiant Hall', 5889, 242, 442, 352, 331, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('07-04-2027', 'dd-mm-yyyy'), 'Blissful Palace', 10101, 243, 220, 332, 387, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('20-03-2028', 'dd-mm-yyyy'), 'Silver Springs ', 9452, 244, 440, 252, 241, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-12-2028', 'dd-mm-yyyy'), 'Ruby Gardens', 9643, 245, 567, 327, 534, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('16-06-2025', 'dd-mm-yyyy'), 'Crystal Ballroo', 8794, 246, 377, 223, 304, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('31-10-2023', 'dd-mm-yyyy'), 'Elegant Terrace', 12684, 247, 248, 267, 377, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('27-06-2021', 'dd-mm-yyyy'), 'Imperial Mansio', 15847, 248, 429, 268, 108, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('21-03-2026', 'dd-mm-yyyy'), 'Elite Mansion', 12783, 249, 510, 241, 443, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('19-10-2024', 'dd-mm-yyyy'), 'Starlight Pavil', 16946, 250, 476, 175, 277, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('28-01-2027', 'dd-mm-yyyy'), 'Tranquil Garden', 7038, 251, 502, 92, 250, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('03-08-2026', 'dd-mm-yyyy'), 'Opal Palace', 12682, 252, 304, 159, 210, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-10-2028', 'dd-mm-yyyy'), 'Cherished Garde', 22065, 253, 292, 358, 330, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('10-08-2023', 'dd-mm-yyyy'), 'Exquisite Pavil', 16381, 254, 292, 261, 422, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('30-01-2025', 'dd-mm-yyyy'), 'Heavenly Terrac', 12352, 255, 523, 309, 409, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('31-05-2022', 'dd-mm-yyyy'), 'Regal Ballroom', 18089, 256, 511, 311, 502, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('08-08-2025', 'dd-mm-yyyy'), 'Victory Pavilio', 11416, 257, 564, 11, 488, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('05-07-2027', 'dd-mm-yyyy'), 'Emerald Manor', 9780, 258, 387, 406, 190, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('10-08-2025', 'dd-mm-yyyy'), 'Platinum Plaza', 14209, 259, 529, 214, 464, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('30-03-2026', 'dd-mm-yyyy'), 'Dazzle Pavilion', 6091, 260, 524, 431, 358, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-09-2028', 'dd-mm-yyyy'), 'Ruby Gardens', 10888, 261, 389, 257, 178, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('24-01-2028', 'dd-mm-yyyy'), 'Elegant Terrace', 4805, 262, 575, 107, 495, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('10-12-2024', 'dd-mm-yyyy'), 'Sunset Ballroom', 14626, 263, 588, 413, 141, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('31-10-2027', 'dd-mm-yyyy'), 'Silver Springs ', 10665, 264, 303, 364, 361, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('11-03-2024', 'dd-mm-yyyy'), 'Dreamy Manor', 15822, 265, 558, 186, 117, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('19-02-2024', 'dd-mm-yyyy'), 'Opal Palace', 17340, 266, 272, 240, 348, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('25-10-2025', 'dd-mm-yyyy'), 'Grandeur Hall', 11901, 267, 511, 306, 216, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-07-2028', 'dd-mm-yyyy'), 'Onyx Mansion', 9936, 268, 388, 411, 189, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-04-2022', 'dd-mm-yyyy'), 'Silver Springs ', 17857, 269, 492, 333, 445, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('26-01-2023', 'dd-mm-yyyy'), 'Tranquil Garden', 6597, 270, 367, 293, 227, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('02-05-2021', 'dd-mm-yyyy'), 'Crystal Ballroo', 16912, 271, 325, 216, 156, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('30-10-2027', 'dd-mm-yyyy'), 'Opal Palace', 18711, 272, 471, 318, 212, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('14-10-2021', 'dd-mm-yyyy'), 'Gilded Palace', 9467, 273, 258, 209, 336, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('30-11-2026', 'dd-mm-yyyy'), 'Luxury Pavilion', 12973, 274, 512, 148, 346, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('20-12-2025', 'dd-mm-yyyy'), 'Cherished Garde', 16285, 275, 510, 412, 451, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('02-03-2026', 'dd-mm-yyyy'), 'Diamond Palace', 8425, 276, 412, 292, 218, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('24-12-2028', 'dd-mm-yyyy'), 'Onyx Mansion', 6223, 277, 533, 30, 129, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('15-01-2020', 'dd-mm-yyyy'), 'Jade Hall', 10527, 278, 476, 388, 518, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('19-02-2021', 'dd-mm-yyyy'), 'Grandeur Hall', 7207, 279, 498, 185, 270, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('01-04-2026', 'dd-mm-yyyy'), 'Breathtaking Te', 10217, 280, 555, 320, 399, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-08-2022', 'dd-mm-yyyy'), 'Celestial Terra', 18959, 281, 241, 171, 226, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('26-11-2021', 'dd-mm-yyyy'), 'Eclipse Ballroo', 14111, 282, 401, 141, 326, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('03-11-2026', 'dd-mm-yyyy'), 'Moonbeam Hall', 10887, 283, 383, 235, 432, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('30-01-2025', 'dd-mm-yyyy'), 'Luxury Pavilion', 16240, 284, 297, 9, 491, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('13-10-2027', 'dd-mm-yyyy'), 'Whispering Gard', 9433, 285, 498, 111, 109, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('30-12-2027', 'dd-mm-yyyy'), 'Mystic Terrace', 18451, 286, 219, 153, 217, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('04-06-2027', 'dd-mm-yyyy'), 'Glamorous Ballr', 10060, 287, 560, 68, 318, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('21-02-2028', 'dd-mm-yyyy'), 'Amethyst Ballro', 9183, 288, 356, 401, 180, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('09-05-2023', 'dd-mm-yyyy'), 'Amethyst Ballro', 8667, 289, 402, 73, 488, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('07-01-2024', 'dd-mm-yyyy'), 'Regal Ballroom', 16116, 290, 352, 433, 226, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('19-06-2021', 'dd-mm-yyyy'), 'Exquisite Pavil', 17372, 291, 445, 182, 278, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('07-12-2028', 'dd-mm-yyyy'), 'Radiant Hall', 18648, 292, 325, 299, 480, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('02-12-2021', 'dd-mm-yyyy'), 'Pearl Pavilion', 20508, 293, 289, 135, 467, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('31-10-2026', 'dd-mm-yyyy'), 'Jade Hall', 22036, 294, 289, 383, 321, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('28-03-2027', 'dd-mm-yyyy'), 'Aurora Ballroom', 12447, 295, 377, 62, 178, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('02-07-2025', 'dd-mm-yyyy'), 'Crystal Ballroo', 4784, 296, 327, 40, 444, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('12-12-2023', 'dd-mm-yyyy'), 'Exquisite Pavil', 13688, 297, 592, 253, 161, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('09-12-2026', 'dd-mm-yyyy'), 'Victory Pavilio', 11834, 298, 551, 437, 172, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('10-06-2021', 'dd-mm-yyyy'), 'Blissful Palace', 16169, 299, 466, 192, 495, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('10-09-2021', 'dd-mm-yyyy'), 'Diamond Palace', 4725, 300, 567, 76, 355, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('15-08-2027', 'dd-mm-yyyy'), 'Glamorous Ballr', 7463, 301, 532, 249, 422, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('19-04-2024', 'dd-mm-yyyy'), 'Sunset Ballroom', 11053, 302, 454, 286, 342, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('08-12-2024', 'dd-mm-yyyy'), 'Whispering Gard', 17099, 303, 286, 224, 388, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('01-05-2026', 'dd-mm-yyyy'), 'Grand Oasis Hal', 13200, 304, 205, 325, 166, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('23-10-2025', 'dd-mm-yyyy'), 'Amethyst Ballro', 10280, 305, 577, 264, 446, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('24-10-2027', 'dd-mm-yyyy'), 'Regal Ballroom', 11772, 306, 566, 153, 223, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('29-10-2020', 'dd-mm-yyyy'), 'Exquisite Pavil', 13538, 307, 581, 393, 310, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('17-12-2022', 'dd-mm-yyyy'), 'Jade Hall', 19546, 309, 293, 77, 425, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('19-11-2025', 'dd-mm-yyyy'), 'Eclipse Ballroo', 14481, 310, 475, 406, 315, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('04-02-2022', 'dd-mm-yyyy'), 'Gilded Palace', 16852, 311, 272, 345, 203, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('01-01-2028', 'dd-mm-yyyy'), 'Majestic Manor', 17061, 312, 257, 197, 528, 1);
commit;
prompt 300 records committed...
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('14-11-2025', 'dd-mm-yyyy'), 'Dreamy Manor', 5590, 313, 523, 248, 355, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('27-09-2027', 'dd-mm-yyyy'), 'Elite Mansion', 12377, 314, 573, 353, 377, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('24-07-2023', 'dd-mm-yyyy'), 'Emerald Manor', 6161, 315, 539, 432, 172, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('11-05-2028', 'dd-mm-yyyy'), 'Celestial Terra', 14161, 316, 592, 235, 523, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('21-09-2027', 'dd-mm-yyyy'), 'Regal Ballroom', 14934, 317, 527, 112, 130, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('27-06-2025', 'dd-mm-yyyy'), 'Whispering Gard', 10543, 318, 250, 287, 362, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('24-12-2024', 'dd-mm-yyyy'), 'Cherished Garde', 23504, 319, 272, 318, 290, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('09-12-2024', 'dd-mm-yyyy'), 'Whispering Gard', 15418, 320, 363, 247, 538, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('29-09-2024', 'dd-mm-yyyy'), 'Heavenly Terrac', 12613, 321, 406, 320, 369, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('11-02-2026', 'dd-mm-yyyy'), 'Ruby Gardens', 19050, 322, 221, 196, 374, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('21-06-2026', 'dd-mm-yyyy'), 'Moonbeam Hall', 14872, 323, 460, 188, 369, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('20-12-2028', 'dd-mm-yyyy'), 'Royal Garden Ha', 12713, 324, 341, 70, 306, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('22-05-2026', 'dd-mm-yyyy'), 'Victory Pavilio', 22153, 325, 452, 212, 320, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('16-11-2025', 'dd-mm-yyyy'), 'Ethereal Ballro', 10148, 326, 383, 327, 511, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('07-08-2025', 'dd-mm-yyyy'), 'Aurora Ballroom', 13651, 327, 405, 65, 171, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('15-08-2023', 'dd-mm-yyyy'), 'Gilded Palace', 15798, 328, 507, 131, 300, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('26-12-2021', 'dd-mm-yyyy'), 'Regal Ballroom', 6930, 329, 347, 206, 167, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('03-10-2026', 'dd-mm-yyyy'), 'Radiant Hall', 3570, 330, 307, 396, 197, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('07-11-2020', 'dd-mm-yyyy'), 'Tranquil Garden', 5557, 331, 337, 58, 217, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('11-05-2026', 'dd-mm-yyyy'), 'Sunset Ballroom', 17853, 332, 241, 103, 347, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-02-2022', 'dd-mm-yyyy'), 'Moonbeam Hall', 12129, 333, 445, 152, 260, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('30-12-2025', 'dd-mm-yyyy'), 'Tranquil Garden', 6039, 334, 379, 170, 320, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('10-04-2028', 'dd-mm-yyyy'), 'Luxury Pavilion', 9750, 335, 323, 414, 295, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('12-11-2028', 'dd-mm-yyyy'), 'Enchanted Garde', 14101, 336, 311, 406, 286, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('16-05-2025', 'dd-mm-yyyy'), 'Enchanted Garde', 12447, 337, 431, 26, 316, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('07-11-2028', 'dd-mm-yyyy'), 'Harmony Hall', 10927, 338, 486, 218, 391, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('25-07-2021', 'dd-mm-yyyy'), 'Heavenly Terrac', 19834, 339, 241, 381, 546, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('21-09-2027', 'dd-mm-yyyy'), 'Ruby Gardens', 9634, 340, 592, 449, 546, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('25-11-2023', 'dd-mm-yyyy'), 'Grand Oasis Hal', 13356, 341, 268, 421, 350, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('27-01-2020', 'dd-mm-yyyy'), 'Emerald Manor', 13487, 342, 464, 393, 545, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('23-10-2022', 'dd-mm-yyyy'), 'Exquisite Pavil', 13377, 343, 496, 383, 213, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('28-06-2028', 'dd-mm-yyyy'), 'Tranquil Garden', 20999, 344, 384, 230, 173, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('28-09-2024', 'dd-mm-yyyy'), 'Ruby Gardens', 5905, 347, 474, 425, 485, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-01-2025', 'dd-mm-yyyy'), 'Golden Plaza', 19735, 348, 289, 326, 287, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('29-07-2020', 'dd-mm-yyyy'), 'Sapphire Hall', 11542, 349, 210, 135, 213, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('30-06-2026', 'dd-mm-yyyy'), 'Aurora Ballroom', 10245, 350, 229, 280, 124, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('16-03-2021', 'dd-mm-yyyy'), 'Sapphire Hall', 10137, 351, 206, 359, 484, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('14-03-2021', 'dd-mm-yyyy'), 'Diamond Palace', 15355, 352, 292, 368, 412, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('15-02-2025', 'dd-mm-yyyy'), 'Exquisite Pavil', 3495, 353, 453, 345, 388, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('25-05-2021', 'dd-mm-yyyy'), 'Serene Pavilion', 21010, 354, 452, 351, 138, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('02-12-2028', 'dd-mm-yyyy'), 'Topaz Terrace', 8707, 356, 412, 238, 351, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('25-02-2023', 'dd-mm-yyyy'), 'Platinum Plaza', 16405, 357, 364, 138, 281, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('10-08-2020', 'dd-mm-yyyy'), 'Regal Ballroom', 7903, 358, 502, 239, 152, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('15-12-2022', 'dd-mm-yyyy'), 'Emerald Manor', 7017, 359, 288, 343, 229, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('04-11-2024', 'dd-mm-yyyy'), 'Aurora Ballroom', 7753, 360, 369, 280, 229, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('10-10-2025', 'dd-mm-yyyy'), 'Eclipse Ballroo', 14486, 361, 281, 211, 135, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('21-12-2025', 'dd-mm-yyyy'), 'Breathtaking Te', 8877, 362, 352, 248, 452, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('05-07-2021', 'dd-mm-yyyy'), 'Tranquil Garden', 12646, 363, 569, 438, 302, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('13-09-2028', 'dd-mm-yyyy'), 'Silver Springs ', 11457, 364, 437, 27, 371, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('12-01-2022', 'dd-mm-yyyy'), 'Radiant Hall', 12479, 365, 426, 70, 158, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('11-03-2023', 'dd-mm-yyyy'), 'Ethereal Ballro', 15075, 366, 436, 310, 470, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('16-11-2025', 'dd-mm-yyyy'), 'Ethereal Ballro', 3027, 367, 574, 34, 219, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('28-12-2028', 'dd-mm-yyyy'), 'Crystal Ballroo', 11449, 368, 531, 60, 144, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('12-03-2023', 'dd-mm-yyyy'), 'Dreamy Manor', 14332, 369, 237, 297, 418, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('07-11-2025', 'dd-mm-yyyy'), 'Whispering Gard', 17803, 370, 562, 226, 106, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('19-10-2026', 'dd-mm-yyyy'), 'Blissful Palace', 8828, 371, 380, 264, 210, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('25-12-2022', 'dd-mm-yyyy'), 'Sapphire Hall', 18812, 372, 277, 434, 355, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('02-05-2021', 'dd-mm-yyyy'), 'Onyx Mansion', 17820, 373, 410, 179, 492, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('04-11-2020', 'dd-mm-yyyy'), 'Sunset Ballroom', 14495, 374, 238, 159, 549, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('12-07-2028', 'dd-mm-yyyy'), 'Harmony Hall', 17768, 375, 475, 278, 257, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('15-10-2026', 'dd-mm-yyyy'), 'Royal Garden Ha', 13050, 376, 539, 50, 476, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('26-12-2022', 'dd-mm-yyyy'), 'Mystic Terrace', 11179, 377, 553, 444, 326, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('22-09-2022', 'dd-mm-yyyy'), 'Noble Hall', 8674, 378, 306, 421, 193, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('22-04-2022', 'dd-mm-yyyy'), 'Gilded Palace', 17663, 379, 573, 411, 175, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('02-05-2021', 'dd-mm-yyyy'), 'Cherished Garde', 18781, 380, 543, 88, 443, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-04-2024', 'dd-mm-yyyy'), 'Glamorous Ballr', 8628, 381, 307, 239, 268, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('23-02-2024', 'dd-mm-yyyy'), 'Crystal Ballroo', 16029, 382, 303, 119, 179, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('11-03-2024', 'dd-mm-yyyy'), 'Royal Garden Ha', 17927, 383, 289, 60, 303, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('16-02-2027', 'dd-mm-yyyy'), 'Mystic Terrace', 9942, 384, 464, 365, 330, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('07-02-2021', 'dd-mm-yyyy'), 'Majestic Manor', 9420, 385, 253, 137, 111, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('24-05-2027', 'dd-mm-yyyy'), 'Serene Pavilion', 10224, 386, 435, 236, 546, 3);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('18-07-2024', 'dd-mm-yyyy'), 'Dazzle Pavilion', 4147, 387, 469, 81, 464, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('08-06-2026', 'dd-mm-yyyy'), 'Glamorous Ballr', 10350, 388, 231, 44, 238, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('25-09-2023', 'dd-mm-yyyy'), 'Harmony Hall', 5222, 389, 246, 72, 311, 5);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('14-05-2022', 'dd-mm-yyyy'), 'Onyx Mansion', 10803, 391, 424, 261, 383, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('25-07-2021', 'dd-mm-yyyy'), 'Elite Mansion', 13461, 393, 488, 165, 492, 1);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('04-06-2025', 'dd-mm-yyyy'), 'Royal Garden Ha', 15973, 394, 506, 381, 463, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('07-04-2023', 'dd-mm-yyyy'), 'Breathtaking Te', 12094, 395, 489, 70, 358, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('19-06-2023', 'dd-mm-yyyy'), 'Silver Springs ', 8977, 396, 239, 149, 418, 6);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('17-07-2024', 'dd-mm-yyyy'), 'Ethereal Ballro', 17093, 397, 400, 322, 411, 4);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('07-08-2020', 'dd-mm-yyyy'), 'Emerald Manor', 17132, 398, 428, 95, 265, 2);
insert into EVENT (event_date, location, total_price_, event_id, producer_id, singer_id, customer_id, payment_id)
values (to_date('25-11-2025', 'dd-mm-yyyy'), 'Radiant Hall', 11062, 399, 554, 250, 200, 2);
commit;
prompt 382 records loaded
prompt Loading INSTRUMENT...
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Pan Flute', 822, 1);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Djembe', 808, 2);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Didgeridoo', 597, 3);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Banjo', 720, 4);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Tuba', 679, 5);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Flute', 865, 6);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Piano', 845, 7);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Ukulele', 614, 8);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Banjo', 942, 9);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Balalaika', 820, 10);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Zither', 826, 11);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Clarinet', 610, 12);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Bandoneon', 933, 13);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Recorder', 721, 14);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Marimba', 830, 15);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Triangle', 553, 16);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Electric Guitar', 751, 17);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Kazoo', 748, 18);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Trombone', 732, 19);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Double Bass', 719, 20);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Balalaika', 584, 21);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Drum', 693, 22);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Cello', 576, 23);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Vuvuzela', 938, 24);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Organ', 815, 25);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Sitar', 980, 26);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Accordion', 943, 27);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Guitar', 751, 28);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Piano', 898, 29);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Pan Flute', 704, 30);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Organ', 595, 31);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Organ', 595, 32);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Vuvuzela', 528, 33);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Synthesizer', 716, 34);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Triangle', 910, 35);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Piano', 526, 36);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Oboe', 582, 37);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Tambourine', 725, 38);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Tuba', 583, 39);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Lyre', 959, 40);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Harmonica', 841, 41);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Lute', 941, 42);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Clarinet', 626, 43);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Djembe', 954, 44);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Tuba', 502, 45);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Violin', 743, 46);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Cello', 637, 47);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Bassoon', 527, 48);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Piccolo', 968, 49);
insert into INSTRUMENT (instrument_name, price, instrument_id)
values ('Drum', 887, 50);
commit;
prompt 50 records loaded
prompt Loading INSTRUMENT_EVENT...
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (1, 1);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (1, 2);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (1, 16);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (1, 69);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (1, 90);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (1, 163);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (1, 185);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (1, 238);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (1, 289);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (1, 303);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (1, 382);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (2, 1);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (2, 21);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (2, 24);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (2, 50);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (2, 109);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (2, 158);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (2, 195);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (2, 205);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (2, 224);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (2, 313);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (2, 315);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (2, 335);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (2, 348);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (2, 375);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (3, 66);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (3, 80);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (3, 97);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (3, 108);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (3, 233);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (3, 244);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (3, 313);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (3, 342);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (4, 11);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (4, 44);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (4, 60);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (4, 82);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (4, 94);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (4, 125);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (4, 325);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (4, 362);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (4, 378);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (5, 39);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (5, 98);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (5, 189);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (5, 225);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (5, 272);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (5, 397);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (6, 22);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (6, 135);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (6, 137);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (6, 168);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (6, 196);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (6, 273);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (6, 277);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (6, 350);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (6, 371);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (6, 391);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (6, 398);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (7, 93);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (7, 108);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (7, 157);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (7, 191);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (8, 85);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (8, 103);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (8, 326);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (8, 335);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (8, 389);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (9, 10);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (9, 29);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (9, 37);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (9, 60);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (9, 90);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (9, 94);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (9, 224);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (9, 306);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (9, 373);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (9, 377);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (10, 44);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (10, 212);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (10, 258);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (10, 276);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (10, 391);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (11, 29);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (11, 62);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (11, 78);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (11, 95);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (11, 167);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (11, 299);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (11, 391);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (11, 397);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (12, 40);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (12, 98);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (12, 168);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (12, 224);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (12, 232);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (12, 342);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (12, 384);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (13, 23);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (13, 85);
commit;
prompt 100 records committed...
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (13, 225);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (13, 259);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (13, 272);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (13, 336);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (14, 39);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (14, 52);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (14, 189);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (14, 191);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (14, 223);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (14, 242);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (14, 266);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (14, 298);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (14, 304);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (14, 320);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (14, 364);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (15, 1);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (15, 24);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (15, 93);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (15, 120);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (15, 133);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (15, 166);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (15, 196);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (15, 197);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (15, 230);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (15, 304);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (15, 357);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (16, 6);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (16, 8);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (16, 10);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (16, 94);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (16, 184);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (16, 280);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (16, 302);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (16, 318);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (16, 319);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (16, 329);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (16, 333);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (17, 8);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (17, 48);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (17, 108);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (17, 155);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (17, 180);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (17, 317);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (17, 333);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (17, 394);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (18, 51);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (18, 195);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (18, 257);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (18, 383);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (19, 17);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (19, 84);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (19, 149);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (19, 169);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (19, 195);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (19, 248);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (19, 267);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (19, 274);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (20, 45);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (20, 46);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (20, 121);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (20, 126);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (20, 128);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (20, 181);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (20, 211);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (20, 212);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (20, 292);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (20, 295);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (20, 363);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (21, 31);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (21, 37);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (21, 90);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (21, 107);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (21, 185);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (21, 219);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (21, 268);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (22, 54);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (22, 115);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (22, 135);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (22, 161);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (22, 165);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (22, 189);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (22, 374);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (22, 386);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (22, 394);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (23, 129);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (23, 171);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (23, 364);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (23, 365);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (24, 68);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (24, 105);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (24, 163);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (24, 182);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (24, 196);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (24, 219);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (24, 237);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (24, 344);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (24, 373);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (25, 25);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (25, 76);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (25, 126);
commit;
prompt 200 records committed...
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (25, 171);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (25, 210);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (25, 226);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (25, 234);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (25, 240);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (25, 340);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (26, 37);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (26, 67);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (26, 88);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (26, 130);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (26, 133);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (26, 335);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (26, 363);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (26, 365);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (26, 382);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (27, 69);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (27, 107);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (27, 128);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (27, 133);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (27, 272);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (27, 282);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (27, 292);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (27, 295);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (27, 299);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (27, 309);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (27, 313);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (27, 340);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (27, 364);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (27, 375);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (27, 396);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (28, 4);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (28, 39);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (28, 217);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (28, 225);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (28, 379);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (29, 59);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (29, 81);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (29, 299);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (29, 366);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (30, 61);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (30, 107);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (30, 253);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (31, 109);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (31, 113);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (31, 135);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (31, 168);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (31, 395);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (32, 54);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (32, 56);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (32, 72);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (32, 130);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (32, 145);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (32, 194);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (32, 197);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (32, 274);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (32, 323);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (32, 330);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (33, 68);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (33, 115);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (33, 137);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (33, 223);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (33, 283);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (33, 301);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (33, 322);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (34, 85);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (34, 86);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (34, 142);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (34, 157);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (34, 221);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (34, 316);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (35, 170);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (35, 176);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (35, 225);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (35, 325);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (35, 336);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (35, 381);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (35, 388);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (36, 37);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (36, 75);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (36, 95);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (36, 122);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (36, 167);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (36, 169);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (36, 251);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (36, 341);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (36, 367);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (37, 16);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (37, 31);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (37, 55);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (37, 72);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (37, 80);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (37, 257);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (37, 335);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (38, 4);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (38, 82);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (38, 108);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (38, 125);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (38, 137);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (38, 143);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (38, 163);
commit;
prompt 300 records committed...
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (38, 238);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (38, 255);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (39, 20);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (39, 32);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (39, 100);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (39, 257);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (39, 281);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (39, 320);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (39, 327);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (39, 362);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (40, 91);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (40, 99);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (40, 176);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (40, 246);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (40, 259);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (40, 286);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (40, 375);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (41, 19);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (41, 167);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (41, 204);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (41, 239);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (41, 289);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (41, 341);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (42, 60);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (42, 70);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (42, 148);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (42, 233);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (42, 354);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (42, 397);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (43, 5);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (43, 8);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (43, 19);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (43, 34);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (43, 87);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (43, 125);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (43, 154);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (43, 210);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (43, 286);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (43, 353);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (44, 27);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (44, 173);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (44, 207);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (44, 271);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (44, 296);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (44, 299);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (44, 344);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (45, 8);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (45, 25);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (45, 100);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (45, 127);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (45, 329);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (45, 350);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (46, 10);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (46, 56);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (46, 151);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (46, 157);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (46, 171);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (46, 194);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (46, 223);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (46, 309);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (46, 318);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (46, 325);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (47, 109);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (47, 161);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (47, 243);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (47, 251);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (47, 299);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (47, 335);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (48, 126);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (48, 159);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (48, 285);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (48, 319);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (48, 358);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (49, 11);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (49, 187);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (49, 205);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (49, 249);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (49, 383);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (49, 399);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (50, 29);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (50, 61);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (50, 129);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (50, 147);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (50, 318);
insert into INSTRUMENT_EVENT (instrument_id, event_id)
values (50, 348);
commit;
prompt 385 records loaded
prompt Enabling foreign key constraints for EVENT...
alter table EVENT enable constraint SYS_C007145;
alter table EVENT enable constraint SYS_C007146;
alter table EVENT enable constraint SYS_C007147;
alter table EVENT enable constraint SYS_C007148;
prompt Enabling foreign key constraints for INSTRUMENT_EVENT...
alter table INSTRUMENT_EVENT enable constraint SYS_C007112;
alter table INSTRUMENT_EVENT enable constraint SYS_C007149;
prompt Enabling triggers for CUSTOMER...
alter table CUSTOMER enable all triggers;
prompt Enabling triggers for PAYMENT_TYPE...
alter table PAYMENT_TYPE enable all triggers;
prompt Enabling triggers for PRODUCER...
alter table PRODUCER enable all triggers;
prompt Enabling triggers for SINGER...
alter table SINGER enable all triggers;
prompt Enabling triggers for EVENT...
alter table EVENT enable all triggers;
prompt Enabling triggers for INSTRUMENT...
alter table INSTRUMENT enable all triggers;
prompt Enabling triggers for INSTRUMENT_EVENT...
alter table INSTRUMENT_EVENT enable all triggers;
set feedback on
set define on
prompt Done.
