

CREATE TYPE centre_type AS ENUM ('Centre', 'Sub-Centre', 'Point');
CREATE TYPE sat_day AS ENUM ('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat');
CREATE TYPE preacher_type AS ENUM ('Pathi', 'Karta', 'Reader');

DROP TABLE  IF EXISTS  satsang_ghar;

CREATE TABLE satsang_ghar (
id SERIAL PRIMARY KEY,
name VARCHAR UNIQUE NOT NULL,
ctype centre_type default 'Centre' ,
parent_center_id numeric,
address1 VARCHAR,
address2 VARCHAR,
city VARCHAR,
state VARCHAR,
pincode numeric(6),
map_link VARCHAR,
landline1 VARCHAR,
landline2 VARCHAR,
mobile1 VARCHAR,
mobile2 VARCHAR,
secretary_name VARCHAR,
secretary_contact numeric,
number_of_pathis numeric(2) default 1 not null,
is_Stage_Pathi_Also_Ground Boolean default 'true'
);

DROP TABLE  IF EXISTS  satsang_schedule;

CREATE TABLE satsang_schedule
( sat_ghar_id numeric,
sat_day sat_day,
sat_time time,
lang  VARCHAR ARRAY

);



DROP TABLE  IF EXISTS  preacher;
CREATE TABLE preacher (
Short_Name  VARCHAR PRIMARY KEY ,
name VARCHAR,
dob DATE,
initiation_Date DATE ,
sex VARCHAR (1) default 'M',
sat_ghar_id numeric,
ptype preacher_type,
mobile1 VARCHAR,
mobile2 VARCHAR,
address VARCHAR,
city VARCHAR,
avail_days  VARCHAR ARRAY,
lang  VARCHAR ARRAY,
transport_profile varchar
);



DROP TABLE  IF EXISTS allocation;
CREATE TABLE allocation (
sat_ghar_id numeric,
sat_date DATE  ,
sat_time time,
pathi_short_code VARCHAR,
pathi2_short_code VARCHAR,
pathi3_short_code VARCHAR,
pathi4_short_code VARCHAR,
pathi5_short_code VARCHAR,
preacher_short_code VARCHAR,
is_cd Boolean,
cd_id varchar,
created_date DATE default CURRENT_DATE
);


DROP TABLE  IF EXISTS allocation;
CREATE TABLE allocation (
sat_ghar_id numeric,
sat_date DATE  ,
sat_time time,
pathi_short_code VARCHAR ARRAY,
preacher_short_code VARCHAR,
is_cd Boolean,
cd_id varchar,
created_date DATE default CURRENT_DATE
);

DROP TABLE  IF EXISTS discourse;
CREATE TABLE discourse (
id serial,
ident varchar,
display_Name varchar
);


INSERT INTO discourse( ident, display_name)  VALUES ( 'id1', 'Dil ka huzra');
INSERT INTO discourse( ident, display_name)  VALUES ( 'id2', 'Dil ka huzra part 2');
INSERT INTO discourse( ident, display_name)  VALUES ( 'id3', 'Dil ka huzra part 3');


DROP TABLE  IF EXISTS USERS;

CREATE TABLE USERS (
user_name VARCHAR PRIMARY KEY,
name VARCHAR,
email_Id VARCHAR,
password VARCHAR);

DROP TABLE  IF EXISTS unavailability;


CREATE TABLE unavailability (
id SERIAL PRIMARY KEY,
short_name VARCHAR,
start_date DATE,
end_date DATE
);





INSERT INTO USERS VALUES ('arun','Arun Arora', NULL ,'arun');
INSERT INTO USERS VALUES ('devi','Devi Dayal', NULL ,'devi');
INSERT INTO USERS VALUES ('ritesh','Ritesh Sahu', NULL ,'ritesh');
INSERT INTO USERS VALUES ('gulshan','Gulshan Paaji', NULL ,'gulshan');
INSERT INTO USERS VALUES ('Vaibhav','Vaibhav Sapra', NULL ,'Vaibhav');



DROP TABLE  IF EXISTS lang;

CREATE TABLE lang  (
 lang VARCHAR PRIMARY KEY,
 LOCAL VARCHAR
);


INSERT INTO lang VALUES ('Hindi','हिंदी');
INSERT INTO lang VALUES ('Punjabi',' ਪੰਜਾਬੀ ');
INSERT INTO lang VALUES ('English','English');
INSERT INTO lang VALUES ('Kannada','ಕನ್ನಡ');
INSERT INTO lang VALUES ('Tamil','தமிழ்');
INSERT INTO lang VALUES ('Telugu','తెలుగు');


DROP TABLE  IF EXISTS state cascade;

create table state (
code varchar(10) primary key,
name varchar(40) unique);

DROP TABLE  IF EXISTS city;
create table city (
code varchar(10) primary key,
name varchar(40) unique,
state_code varchar(10) references state
);


INSERT INTO state  VALUES ('KA', 'Karnataka');
INSERT INTO state  VALUES ('KL', 'Kerala');
INSERT INTO state  VALUES ('MP', 'Madhya Pradesh');
INSERT INTO state  VALUES ('AP', 'Andhra Pradesh');
INSERT INTO state  VALUES ('TG', 'Telangana');
INSERT INTO state  VALUES ('TN', 'Tamil Nadu');



DROP TABLE  IF EXISTS CD cascade;

create table CD (
id varchar primary key,
desc1 varchar ,
desc2 varchar
);





--INSERT INTO city  VALUES ( 'BLR', 'Bangalore', 'KA');
--INSERT INTO city  VALUES ( 'MYS', 'MYSURU', 'KA');
--INSERT INTO city  VALUES ( 'TUM', 'TUMKUR', 'KA');
