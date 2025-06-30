use master
go
-- -----------------------------------------------------
-- Data base bdCinema
-- -----------------------------------------------------
create database bdCinema
go
-- -----------------------------------------------------
-- droop Tables 
-- -----------------------------------------------------
use bdCinema
go
drop table tDIMDate -- a huge bug was found and fixed
drop table temployeeHistory
drop table tactorMovieList
drop table tattendanceDetail
drop table tscreens
drop table tactors
drop table tcustomerLoyalty
drop table temployees
drop table tfoodOrderDetail
drop table tticketPrices
drop table tfood
drop table tloyaltyPromotions
drop table tmovies
drop table tfoodOrders
drop table ttheaters
drop table tcustomers
drop table about-us



-- -----------------------------------------------------
-- 1.- Table `bdCinema`.`ttheaters`
-- -----------------------------------------------------
use bdCinema
go
create table ttheaters(
idtheater int identity (1,1) not null,
name varchar (100)
)
alter table ttheaters add city varchar (100) null default null
alter table ttheaters add state char (2) null default null
alter table tTheaters add 
constraint pk_idtheater primary key clustered (idtheater asc )

-- -----------------------------------------------------
-- 2.- Table `bdCinema`.`tscreens `
-- -----------------------------------------------------
use bdCinema
go
create table tscreens(
idscreen int identity (1,1) not null,
name varchar(100) null
)
alter table tscreens add size smallint null default null
alter table tscreens add idtheater int null
alter table tscreens add 
constraint pk_idscreen primary key clustered (idscreen asc) 
alter table tscreens add
constraint fk_tscreens_ttheaters foreign key (idtheater)
references ttheaters (idtheater)

-- -----------------------------------------------------
-- 3.- Table `bdCinema`.`tactors `
-- -----------------------------------------------------
use bdCinema
go
-- That is needed for the loyalty program
-- if a cusdtomer sees three movies with action 
-- star chunk make muscle, they get free asmissin 
-- to a fourth movie starring chunk make muscle
create table tactors(
idactor int identity(1,1) not null,
name varchar(100) null default null
)
alter table tactors add  
constraint pk_idactor primary key clustered (idactor asc)

-- -----------------------------------------------------
-- 4.- Table `bdCinema`.`tloyaltyPromotions`
-- -----------------------------------------------------
use bdCinema
go
create table tloyaltyPromotions(
idloyaltyPromotion int identity (1,1) not null,
name varchar (100) null default null
)
alter table tloyaltyPromotions add 
constraint pk_idloyaltyPromotion primary key clustered (idloyaltyPromotion asc)

-- -----------------------------------------------------
-- 5.- Table `bdCinema`.`tmovies`
-- -----------------------------------------------------
use bdCinema
go
create table tmovies(
-- idmovie allow us to unique identfy our movie
idmovie int identity(1,1) not null
)
alter table tmovies add name varchar(100) null default null
-- releaseDate show the realese date, we do not need the time
alter table tmovies add releaseDate date null default null
-- smallint 2bytes -32768 to 32767
alter table tmovies add movieMinutes smallint null default null
-- ------------------- PRIMARY KEY
alter table tmovies add constraint  
pk_idmovie primary key clustered (idmovie asc)
-- -----------------------------------------------------
-- 6.- Table `bdCinema`.`tcustomers`
-- -----------------------------------------------------
use bdCinema
go
create table tcustomers(
idcustomer int identity (1,1) not null,
name varchar(100) null default null
)
alter table tcustomers add city varchar(100) null default null
alter table tcustomers add state char(2) null default null
alter table tcustomers add email varchar(100) null default null
alter table tcustomers add joinDate date null default null
-- ------------------- PRIMARY KEY
alter table tcustomers add
constraint pk_idcustomer primary key clustered (idcustomer asc)

-- -----------------------------------------------------
-- 7.- Table `bdCinema`.`tDIMDate`
-- -----------------------------------------------------
use bdCinema
go
create table tDIMDate(
theDate date not null
)
alter table tDIMDate add yearNumber smallint null default null
alter table tDIMDate add monthNumber tinyint null default null
alter table tDIMDate add dayNumber tinyint null default null
alter table tDIMDate add monthName varchar(20) null default null
alter table tDIMDate add dayName varchar (20) null default null
alter table tDIMDate add yearandMonth varchar(20) null default null
alter table tDIMDate add shortMonthName char(3) null default null
alter table tDIMDate add shortDayName char(3) null default null
alter table tDIMDate add shortYearName char(3) null default null
alter table tDIMDate add shortYearandMonth char(10) null default null
alter table tDIMDate add firstOfMonth date null default null
alter table tDIMDate add lastofMOnth date null default null
alter table tDIMDate add isWeekend bit null default null
-- ------------------- PRIMARY KEY
alter table tDIMDate add
constraint pk_theDate primary key clustered (theDate asc)

-- -----------------------------------------------------
-- 8.- Table `bdCinema`.`temployeeHistory`
-- -----------------------------------------------------
use bdCinema
go
-- I like having two separete tables.
-- The employe table (temployees) will only ever have 
-- the current information for all employees if we want to know.
-- -----------------------------------------------------
-- With the temployeeHistory we might go through several 
-- employees or several employees get promotions 
-- and move around and change things. 
-- We can have a gigantic history table and maybe 
-- that can be huge and slow but as long as we do not need 
-- to look up history very often that is fine.
-- -----------------------------------------------------
-- This way our current data is very fast and our 
-- historic data is a little bit slower, but it is completed.
create table temployeeHistory(
idemployeeHistory int identity (1,1) not null,
)
alter table temployeeHistory add idemployee int null default null
alter table temployeeHistory add idtheater int null default null
alter table temployeeHistory add name varchar(100) null default null
alter table temployeeHistory add jobTitle varchar(100) null default null
alter table temployeeHistory add salary money null default null
alter table temployeeHistory add startDay date null default null
-- The history insert date will be the date 
-- that row was inserted into this table.
-- Then we casn go back in time and find out
-- when exactly everything happen.
alter table temployeeHistory add historyInsertDate datetime2 (0) null default null
-- ------------------- PRIMARY KEY
alter table temployeeHistory add 
constraint pk_idemployeeHistory primary key clustered (idemployeeHistory asc)

-- -----------------------------------------------------
-- 9.- Table `bdCinema`.`tactorMovieList`
-- -----------------------------------------------------
use bdCinema
go
create table tactorMovieList(
idactor int not null,
idmovie int not null
)
-- ------------------- PRIMARY KEY
alter table tactorMovieList add
constraint pk_idactor_idmovie
-- composite key
primary key clustered (idactor asc, idmovie asc)
-- ------------------- FOREIGN KEY
alter table tactorMovieList add
constraint fk_tactorMovieList_idactor foreign key (idactor)
references tactors (idactor)
alter table tactorMovieList add
constraint fk_tactorMovieList_idmovie foreign key (idmovie)
references tmovies (idmovie)

-- -----------------------------------------------------
-- 10.- Table `bdCinema`.`tattendanceDetail`
-- -----------------------------------------------------
use bdCinema
go
create table tattendanceDetail(
idattendanceDetail int identity (1,1) not null
)
alter table tattendanceDetail add attendanceDate datetime2 (0) null default null
alter table tattendanceDetail add ticketPrice smallmoney null default null
alter table tattendanceDetail add idscreen int null default null
alter table tattendanceDetail add idmovie int null default null
alter table tattendanceDetail add idcustomer int null default null
-- ------------------- PRIMARY KEY
alter table tattendanceDetail add constraint 
pk_idattendanceDetail primary key clustered (idattendanceDetail asc)
-- ------------------- FOREIGN KEY
alter table tattendanceDetail add
constraint fk_tattendenceDetail_idscreen foreign key(idscreen) references tscreens (idscreen)
alter table tattendanceDetail add
constraint fk_tattendenceDetail_idmovie foreign key(idmovie)references tmovies(idmovie)
alter table tattendanceDetail add
constraint fk_tattendenceDetail_idcustomer foreign key (idcustomer) references tcustomers(idcustomer)

-- -----------------------------------------------------
-- 11.- Table `bdCinema`.`tcustomerLoyalty`
-- -----------------------------------------------------
use bdCinema
go
create table tcustomerLoyalty(
idcustomerLoyalty int identity (1,1) not null
)
alter table tcustomerLoyalty add achievedDate datetime2 (0) null default null
alter table tcustomerLoyalty add idloyaltyPromotion int null default null
alter table tcustomerLoyalty add idcustomer int null default null
-- ------------------- PRIMARY KEY
ALTER TABLE tcustomerLoyalty ADD constraint 
pk_tcustomerLoyalty_idcustomerLoyalty primary key clustered (idcustomerLoyalty asc)
-- ------------------- FOREIGN KEY
alter table tcustomerLoyalty add constraint 
fk_tcustomerloyalty_idloyaltyPromotion foreign key (idloyaltyPromotion)
references tloyaltyPromotions (idloyaltyPromotion)
alter table tcustomerLoyalty add constraint
fk_tcustomerloyalty_idcustomer foreign key (idcustomer)
references tcustomers (idcustomer)

-- -----------------------------------------------------
-- 12.- Table `bdCinema`.`temployees`
-- -----------------------------------------------------
use bdCinema
go
create table temployees(
idemployee int identity(1,1) not null
)
alter table temployees add idtheater int null default null
alter table temployees add name varchar(100) null default null
alter table temployees add jobTitle varchar(100) null default null
alter table temployees add salary money null default null
alter table temployees add startDate date null default null
-- ------------------- PRIMARY KEY
alter table temployees add constraint
pk_temployees_idemployee primary key(idemployee)
-- ------------------- FOREIGN KEY
alter table temployees add constraint 
fk_temployees_idtheater foreign key (idtheater) references ttheaters(idtheater)

-- -----------------------------------------------------
-- 13.- Table `bdCinema`.`tfood`
-- -----------------------------------------------------
use bdCinema
go
create table tfood(
idfood int identity(1,1) not null
)
alter table tfood add name varchar(100) null default null
alter table tfood add price smallmoney null default null
-- ------------------- PRIMARY KEY
alter table tfood add constraint
pk_tfood_idfood primary key (idfood)
-- In order to track the snack sales
-- we will need to create tables that have a parent 
-- child relationship.
-- 14.- Parent:Table `bdCinema`.`tfoodOrders`
-- 15.- Child Table `bdCinema`.`tfoodOrderDetail`

-- -----------------------------------------------------
-- 14.- Parent:Table `bdCinema`.`tfoodOrders`
-- -----------------------------------------------------
use bdCinema
go
create table tfoodOrders(
idfoodOrder int identity(1,1) not null
)
-- Date and time of the sale
alter table tfoodOrders add foodOrdersDate datetime2(0) null default null
-- Total amount of the sale
alter table tfoodOrders add total smallmoney null default null
-- Wich tehater of the sale
alter table tfoodOrders add idtheater int null default null
-- ------------------- PRIMARY KEY
alter table tfoodOrders add constraint
pk_tfoodOrders_idfoodOrder primary key clustered(idfoodOrder asc)
-- ------------------- FOREIGN KEY
alter table tfoodOrders add constraint
fk_tfoodOrders_idtheater foreign key (idtheater) references ttheaters(idtheater) 

-- -----------------------------------------------------
-- 15.- Child Table `bdCinema`.`tfoodOrderDetail`
-- -----------------------------------------------------
use bdCinema
go
create table tfoodOrderDetail(
-- idfoodOrder linking back to the food ordersd parent table.
idfoodOrder int not null,
-- idfoodOrderDetail key will keep track of individual items or that ordere.
idfoodOrderDetail int not null
)
-- idfood for in key linking to our foods lookup table and 
-- the price of the individual items
alter table tfoodOrderDetail add idfood int null default null
alter table tfoodOrderdetail add price money null default null
-- ------------------- PRIMARY KEY
-- We use a composite key for our primary key of 
-- idfoodOrder and idfoodOrderDetail.
alter table tfoodOrderDetail add constraint
pk_tfoodOrderDetail_idfoodOrderDetail_idfoodOrder
primary key clustered(idfoodOrderDetail asc, idfoodOrder asc) 
-- ------------------- FOREIGN KEY
alter table tfoodOrderDetail add constraint
fk_tfoodOrdersDetail_idfood foreign key (idfood) references tfood(idfood)

-- -----------------------------------------------------
-- 16.- Table `bdCinema`.`tticketPrices`
-- -----------------------------------------------------
use bdCinema
go
create table tticketPrices(
idticketPrice int identity (1,1) not null
)

alter table tticketPrices add name varchar(100) null default null
-- time(0) is a time of day
alter table tticketPrices add startTime time(0) null default null
alter table tticketPrices add endTime time(0) null default null
/*
declare @MyValue decimal(6,3)
set @MyValue = 100.537

Precision    Storage bytes
 1 - 9       5   
10 - 19      9
20 - 28     13
29 - 38     17
samallmoney -214,748.3648 to 214,748.3647
*/
-- Do not use float in your database where fine accuracy matters 
-- because it does not store exact number.
-- Use decimal with the correct precision and scale 
-- to store exact numbers.
-- Use smallmoney and money when storing monetary values.
alter table tticketPrices add ticketPrice smallmoney null default null
alter table tticketPrices add idmovie int null default null
-- ------------------- PRIMARY KEY
alter table tticketPrices add constraint 
pk_idticketPrice primary key clustered (idticketPrice asc)
-- ------------------- FOREIGN KEY
alter table tticketPrices add constraint 
fk_tticketPrice_idmovie foreign key (idmovie)
references tmovies (idmovie)
