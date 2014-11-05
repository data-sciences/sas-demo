
/**********************************************************************************************************************/
/* The Essential PROC SQL Handbook - Example Code
/* Katherine Prairie
/********************************************************************************************************************
/* Created:	 October 31, 2005 - page numbers from published copy of book 
/* Notes: 
/* 1.  Each SQL statement includes PROC SQL, QUIT and LIBNAME statements to allow the SQL statement to be run in 
/* isolation.  The PROC SQL and LIBNAME statements are required only once for any number of SQL statements.  It is only
/* necessary to add these statements again if a SAS DATA Step or procedure has been run or the LIBNAME assignment changes
/* The QUIT statement is required only when you wish to stop the SQL procedure.
/*
/* 2.  Selective capitalization, indentation and other spaces have been added for readability; 
/********************************************************************************************************************/

OPTIONS linesize=256 nocenter nonumber stimer nodate;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

/*******************************************************************************
/*Create the tables in the book
/******************************************************************************/

PROC SQL;
/* Drop the tables if they already exist*/

DROP table bluesky.reprint;
DROP table bluesky.client;
DROP table bluesky.currency;
DROP table bluesky.shipping;
DROP table bluesky.orders;
DROP table bluesky.address;
DROP table bluesky.stock;

/* Create the tables*/

CREATE table bluesky.reprint (
 	reprint 	char(1),
 	cutOff 		num );

CREATE table bluesky.client (
 	clientNo	num,
 	company 	char(40),
 	cont_fst	char(10),
	cont_lst 	char(15),
 	dept 		char(25),
 	phone 		char(25),
 	fax 		char(25) );

CREATE table bluesky.currency (
 	currency 	char(3),
  	cur_date 	date,
 	exchRate 	num );

CREATE table bluesky.shipping(
	delCode 	char(3),
	delType 	char(25),
	charge 		num );

CREATE table bluesky.orders (
  	prodCode 	char(6),
  	ord_date 	date,
  	quantity 	num,
  	totsale 	num,
 	currency 	char(3),
 	delCode 	char(3),
 	clientNo 	num, 
	invoice 	char(10));

CREATE table bluesky.order_2001_2002 (
  	prodCode 	char(6),
  	ord_date 	date,
  	quantity 	num,
  	totsale 	num,
 	currency 	char(3),
 	delCode 	char(3),
 	clientNo 	num, 
	invoice 	char(10));

CREATE table bluesky.stock (
 	ISBN 		char(13),
 	title 		char(50),
 	auth_fst	char(10),
	auth_lst	char(15),
 	category 	char(20),
 	reprint 	char(1),
 	stock 		num,
 	yrPubl 		num,
 	prodCode 	char(6),
 	price 		num);


CREATE table bluesky.address (
	clientNo 	num,
 	address 	char(50),
 	city 		char(30),
 	state 		char(2),
 	ZIP_post 	char(15),
 	country 	char(25),
 	email 		char(30) );


/* Describe the table structures to confirm they were CREATEd correctly*/

DESCRIBE table bluesky.client;
DESCRIBE table bluesky.address;
DESCRIBE table bluesky.shipping;
DESCRIBE table bluesky.orders;
DESCRIBE table bluesky.stock;
DESCRIBE table bluesky.reprint;
DESCRIBE table bluesky.currency;

/* Load the tables with data*/

/* STOCK TABLE*/

INSERT into bluesky.stock values('1-7890-1072-1','Decorative Arts','Greg', 'Evans','arts','E',1500,1999,'300678',16.95);
INSERT into bluesky.stock values('1-7890-2878-7','The Ultimate Philosophy','Cory', 'Johnson','arts','C',100,1999,'300456',9.5);
INSERT into bluesky.stock values('1-7890-1256-2','Democracy in America','Jeff', 'Thompson','arts','C',55,2003,'300289',36);
INSERT into bluesky.stock values('1-7890-5477-x','The Underground Economy','Arlene', 'Tee','arts','E',1000,2000,'300680',14.5);
INSERT into bluesky.stock values('1-7890-1209-0','The Art of Computer Programming','Corinna', 'Keenmon','computer','F',1600,1999,'500120',34.5);
INSERT into bluesky.stock values('1-7890-1378-x',"New User's Guide to Computers",'Jennifer', 'Mathson','computer','D',350,2003,'500127',26.25);
INSERT into bluesky.stock values('1-7890-7648-x','Visual Basic for Beginners','Denise', 'Kizer','computer','E',600,2003,'500168',34);
INSERT into bluesky.stock values('1-7890-5634-9','Start a Business Using a Computer','Roy', 'Wilson','computer','F',1000,2002,'500238',22.25);
INSERT into bluesky.stock values('1-7890-3473-6','Introduction to Computer_Science','April', 'Jensen','computer','D',1000,2002,'500890',32.5);
INSERT into bluesky.stock values('1-7890-2829-9','Computer: Beginners Guide','Rosanna', 'Marossy','computer','D',100,2000,'500500',23.5);
INSERT into bluesky.stock values('1-7890-3245-8','Engineering Infrastructure Modeling','Merrill', 'Frank','engineering','E',2400,1999,'200345',54.98);
INSERT into bluesky.stock values('1-7890-1290-2','Space Sciences','Ian', 'Bishop','engineering','F',1500,2001,'200145',56.25);
INSERT into bluesky.stock values('1-7890-5698-5','Managing Water Resources','Brian','Kerwin','engineering','F',6000,2001,'200678',45);
INSERT into bluesky.stock values('1-7890-1267-8','Materials Science','Andrew', 'Bole','engineering','C',50,2000,'200507',74.5);
INSERT into bluesky.stock values('1-7890-4578-9','Risks in Life - % Gain or Loss?','Paul', 'Smith','general','F',1000,2000,'600123',14.3);
INSERT into bluesky.stock values('1-7890-3468-x','Women Writers','Alex', 'Paul','general','E',1000,2000,'600780',8.6);
INSERT into bluesky.stock values('1-7890-2390-4','Greece and Beyond','Clark', 'Foutz','general','D',398,2000,'600451',12.5);
INSERT into bluesky.stock values('1-7890-3278-4','Mountaineering Skills','Chris', 'Lillard','general','B',200,2000,'600489',5.5);
INSERT into bluesky.stock values('1-7890-3007-2','The Maestro','Alexander', 'Dixon','general','B',100,2000,'600125',6.95);
INSERT into bluesky.stock values('1-7890-4578-9','The 10% Solution','Gabe', 'Haney','medicine','C',400,1999,'400457',74.65);
INSERT into bluesky.stock values('1-7890-5475-3','Tibetan Medicine','Wendy', 'Perry','medicine','F',2000,2000,'400128',34);
INSERT into bluesky.stock values('1-7890-3467-1','Medications and Maintenance','David', 'Barry','medicine','B',30,2000,'400345',86);
INSERT into bluesky.stock values('1-7890-7893-8','Unconventional treatments','Debbie', 'Hedge','medicine','C',1000,2003,'400102',55);
INSERT into bluesky.stock values('1-7890-3479-5','National Library of Medicine','Robert', 'Saravit','medicine','A',35,2001,'400178',65.75);
INSERT into bluesky.stock values('1-7890-3891-x','Medical Education in School','Beth', 'Miler','medicine','B',300,2000,'400100',43.75);
INSERT into bluesky.stock values('1-7890-4567-3','Book of Science and Nature','Allison', 'Clark','science','F',1000,2003,'100890',69);
INSERT into bluesky.stock values('1-7890-3478-7','Free Thinking in Mathematics','Ken', 'McMurry','science','E',900,2001,'100601',26.25);
INSERT into bluesky.stock values('1-7890-1280-5','Science and Technology','Kay', 'Davis','science','D',200,2002,'100406',15);
INSERT into bluesky.stock values('1-7890-5678-0','Science of Biology','Lisa', 'Sharr','science','D',500,2000,'100345',65);
INSERT into bluesky.stock values('1-7890-2876-0','Geology: Volcanos','Jena','Richardson','science','D',400,2001,'100340',18);
/* SHIPPING TABLE*/

INSERT into bluesky.shipping values('EXE','2 day Express shipping',15);
INSERT into bluesky.shipping values('UPS','US postal service',10);
INSERT into bluesky.shipping values('EXP','express mail',10);
INSERT into bluesky.shipping values('EXA','express air delivery',15);
INSERT into bluesky.shipping values('GRN','ground delivery',10);

/* REPRINT TABLE*/

INSERT into bluesky.reprint values('A',0);
INSERT into bluesky.reprint values('B',10);
INSERT into bluesky.reprint values('C',50);
INSERT into bluesky.reprint values('D',100);
INSERT into bluesky.reprint values('E',500);
INSERT into bluesky.reprint values('F',1000);

/* ORDER TABLE*/

INSERT into bluesky.orders 
	values('300456','07Feb2003'D,300,2850,'USD','UPS',1001,'030207-01')
	values('300680','06May2003'D,150,2175,'USD','EXE',1001,'030506-01')
	values('400178','06May2003'D,500,32875,'USD','UPS',1001,'030506-01')
	values('500120','06May2003'D,600,20700,'USD','UPS',1001,'030506-01')
	values('200345','10Nov2003'D,1400,76972,'SGD','EXE',4008,'031110-01')
	values('300680','20Oct2003'D,2900,3390,'USD','UPS',2010,'031020-01')
	values('400100','15Mar2003'D,125,5468.75,'SGD','EXE',4008,'030315-01')
	values('400128','11Apr2003'D,200,6800,'EUR','UPS',7008,'030411-01')
	values('400100','11Apr2003'D,200,8750,'AUD','UPS',5005,'030411-01')
	values('600125','24Jun2003'D,350,2432.5,'EUR','EXE',3007,'030624-01')
	values('300456','07Feb2003'D,50,475,'EUR','UPS',3007,'030207-02')
	values('300678','09Jan2003'D,275,4661.25,'CAD','GRN',8003,'030109-01')
	values('100340','09Jan2003'D,800,14400,'CAD','UPS',8003,'030109-01')
	values('500120','06Sep2003'D,1000,34500,'USD','UPS',1001,'030906-01')
	values('200345','27Sep2003'D,500,27490,'EUR','EXE',6090,'030927-01')
	values('600125','01Feb2004'D,12,83.4,'CAD','GRN',8003,'040101-01')
	values('600780','01Feb2004'D,103,885.8,'SGD','EXP',4008,'040101-02')
	values('100406','07Mar2004'D,45,675,'EUR','EXP',3007,'040307-01')
	values('100345','10Mar2004'D,180,11700,'EUR','EXP',7008,'040310-01')
	values('400100','10Mar2004'D,350,15312.5,'CAD','EXA',8003,'040310-02')
	values('500500','10Mar2004'D,70,1645,'USD','EXA',8003,'040310-02')
	values('600125','10Mar2004'D,100,1250,'SGD','EXP',4008,'040310-04')
	values('200507','08Apr2004'D,20,1490,'SGD','EXP',4008,'040408-01')
	values('300456','10Apr2004'D,55,797.5,'EUR','EXP',6090,'040410-01')
	values('200145','12Apr2004'D,700,39375,'USD','EXE',2010,'040412-01')
	values('400128','12Apr2004'D,1230,41820,'USD','EXE',2010,'040412-01')
	values('500238','12Apr2004'D,200,4450,'AUD','EXP',5005,'040412-02')
	values('600489','12Apr2004'D,25,137.5,'EUR','EX',7008,'040412-03')
	values('600125','05May2004'D,600,8580,'USD','EXE',2010,'040505-01')
	values('500127','07Jun2004'D,324,8505,'USD','EXE',2010,'040607-01')
	values('500168','20Jul2004'D,335,11390,'AUD','EXP',5005,'040720-01')
	values('400345','11May2004'D,25,2150,'SGD','EXP',4008,'041011-01') 
	values('100890','12May2004'D,260,17940,'EUR','EXP',3007,'041012-01')
	values('100340','12Jun2004'D,20,360,'CAD','GRN',8003,'041212-01')
	values('200678','12Jun2004'D,5000,225000,'EUR','EXP',3007,'041212-02')
	values('300289','12Jun2004'D,30,1080,'EUR','EXP',6090,'041212-03')
	values('100601','23Jul2004'D,590,15487.5,'EUR','EXP',3007,'041223-01')
	values('400102','23Jul2004'D,1500,82500,'AUD','EXP',5005,'041223-02')
	values('400178','23Jul2004'D,10,657.5,'EUR','EXP',6090,'041223-03')
	values('500116','23Jul2004'D,400,13600,'EUR','EXP',7008,'041223-04');

/* ORDER_2000_2001 TABLE*/

INSERT into bluesky.order_2001_2002 values('500120','28Feb2001'D,120,4140,'GBP','UPS',3007,'010228-01');
INSERT into bluesky.order_2001_2002 values('600451','16Jan2001'D,520,6500,'FRF','EXE',7008,'010116-01');
INSERT into bluesky.order_2001_2002 values('400457','05Jan2001'D,650,48522.5,'USD','UPS',1001,'010105-01');
INSERT into bluesky.order_2001_2002 values('400100','05Jan2001'D,90,3937.5,'USD','UPS',1001,'010105-01');
INSERT into bluesky.order_2001_2002 values('100345','09Mar2001'D,1250,81250,'CAD','EXE',8003,'010309-01');
INSERT into bluesky.order_2001_2002 values('600780','30Mar2001'D,80,688,'FRF','UPS',7008,'010330-01');
INSERT into bluesky.order_2001_2002 values('400100','20Apr2001'D,125,5468.75,'DEM','EXE',6090,'010420-01');
INSERT into bluesky.order_2001_2002 values('400128','20Apr2001'D,200,6800,'GBP','UPS',3007,'010420-02');
INSERT into bluesky.order_2001_2002 values('500500','06Apr2001'D,200,4700,'CAD','UPS',8003,'010406-01');
INSERT into bluesky.order_2001_2002 values('500500','06Jun2001'D,475,11162.50,'GBP','EXE',3007,'010606-01');
INSERT into bluesky.order_2001_2002 values('200345','26May2001'D,500,27490,'GBP','UPS',3007,'010526-01');
INSERT into bluesky.order_2001_2002 values('600780','09Jun2001'D,475,4085,'CAD','GRN',8003,'010609-01');
INSERT into bluesky.order_2001_2002 values('100345','21Aug2001'D,1500,97500,'CAD','UPS',8003,'010821-01');
INSERT into bluesky.order_2001_2002 values('500120','06Oct2001'D,1000,34500,'USD','UPS',1001,'011006-01');
INSERT into bluesky.order_2001_2002 values('200345','05Dec2001'D,125,6872.50,'DEM','EXE',6090,'011205-01');
INSERT into bluesky.order_2001_2002 values('600125','17Nov2001'D,300,2085,'CAD','GRN',8003,'011117-01');

INSERT into bluesky.order_2001_2002 values('600780','31Jan2002'D,100,860,'USD','EXP',1001,'020131-01');
INSERT into bluesky.order_2001_2002 values('300680','07Feb2002'D,125,1812.5,'GBP','EXP',3007,'020207-01');
INSERT into bluesky.order_2001_2002 values('300678','27Feb2002'D,950,16102.50,'FRF','EXP',7008,'020227-01');
INSERT into bluesky.order_2001_2002 values('200345','29Mar2002'D,300,16494,'CAD','EXA',8003,'020329-01');
INSERT into bluesky.order_2001_2002 values('200678','29Mar2002'D,70,3150,'CAD','EXA',8003,'020329-01');
INSERT into bluesky.order_2001_2002 values('600125','29Mar2002'D,100,695,'CAD','EXP',8003,'020329-01');
INSERT into bluesky.order_2001_2002 values('400178','09Apr2002'D,1000,65750,'USD','EXP',1001,'020409-01');
INSERT into bluesky.order_2001_2002 values('200145','23Apr2002'D,25,1406.25,'DEM','EXP',6090,'020423-01');
INSERT into bluesky.order_2001_2002 values('200145','17May2002'D,700,39375,'CAD','EXE',8003,'020517-01');
INSERT into bluesky.order_2001_2002 values('100340','29Jun2002'D,1500,27000,'USD','EXE',1001,'020629-01');
INSERT into bluesky.order_2001_2002 values('100601','13Jul2002'D,200,5250,'AUD','EXP',5005,'020713-01');
INSERT into bluesky.order_2001_2002 values('600489','31Aug2002'D,25,137.5,'FRF','EX',7008,'020831-01');
INSERT into bluesky.order_2001_2002 values('600125','05Sep2002'D,675,4691.25,'USD','EXE',1001,'020905-01');
INSERT into bluesky.order_2001_2002 values('200345','17Oct2002'D,985,54155.30,'USD','EXE',1001,'021017-01');
INSERT into bluesky.order_2001_2002 values('300680','18Oct2002'D,235,3407.5,'DEM','EXP',6090,'021018-01');
INSERT into bluesky.order_2001_2002 values('100340','05Nov2002'D,65,1170,'AUD','EXP',5005,'021105-01'); 
INSERT into bluesky.order_2001_2002 values('100340','06Dec2002'D,890,16020,'GBP','EXP',3007,'021206-01');
INSERT into bluesky.order_2001_2002 values('500500','07Dec2002'D,135,3172.50,'CAD','GRN',8003,'021207-01');
INSERT into bluesky.order_2001_2002 values('200678','28Dec2002'D,1200,54000,'GBP','EXP',3007,'021228-01');


/* CURRENCY TABLE*/

INSERT into bluesky.currency values('USD','01JAN03'D,1);
INSERT into bluesky.currency values('EUR','01JAN03'D,0.94160);
INSERT into bluesky.currency values('SGD','01JAN03'D,1.73628);
INSERT into bluesky.currency values('AUD','01JAN03'D,1.71592);
INSERT into bluesky.currency values('CAD','01JAN03'D,1.54145); 

INSERT into bluesky.currency values('USD','01FEB03'D,1);
INSERT into bluesky.currency values('EUR','01FEB03'D,0.92726);
INSERT into bluesky.currency values('SGD','01FEB03'D,1.74514);
INSERT into bluesky.currency values('AUD','01FEB03'D,1.67930);
INSERT into bluesky.currency values('CAD','01FEB03'D,1.51215); 

INSERT into bluesky.currency values('USD','01MAR03'D,1);
INSERT into bluesky.currency values('GBP','01MAR03'D,0.92637);
INSERT into bluesky.currency values('SGD','01MAR03'D,1.75511);
INSERT into bluesky.currency values('AUD','01MAR03'D,1.66290);
INSERT into bluesky.currency values('CAD','01MAR03'D,1.47608);

INSERT into bluesky.currency values('USD','01APR03'D,1);
INSERT into bluesky.currency values('EUR','01APR03'D,0.92075);
INSERT into bluesky.currency values('SGD','01APR03'D,1.77712);
INSERT into bluesky.currency values('AUD','01APR03'D,1.63977);
INSERT into bluesky.currency values('CAD','01APR03'D,1.45820); 

INSERT into bluesky.currency values('USD','01MAY03'D,1);
INSERT into bluesky.currency values('EUR','01MAY03'D,0.86563);
INSERT into bluesky.currency values('SGD','01MAY03'D,1.73571);
INSERT into bluesky.currency values('AUD','01MAY03'D,1.54638);
INSERT into bluesky.currency values('CAD','01MAY03'D,1.38396); 

INSERT into bluesky.currency values('USD','01JUN03'D,1);
INSERT into bluesky.currency values('EUR','01JUN03'D,0.85341);
INSERT into bluesky.currency values('SGD','01JUN03'D,1.73090);
INSERT into bluesky.currency values('AUD','01JUN03'D,1.50509);
INSERT into bluesky.currency values('CAD','01JUN03'D,1.35297); 

INSERT into bluesky.currency values('USD','01JUL03'D,1);
INSERT into bluesky.currency values('EUR','01JUL03'D,0.87561);
INSERT into bluesky.currency values('SGD','01JUL03'D,1.76712);
INSERT into bluesky.currency values('AUD','01JUL03'D,1.53064);
INSERT into bluesky.currency values('CAD','01JUL03'D,1.38795); 

INSERT into bluesky.currency values('USD','01AUG03'D,1);
INSERT into bluesky.currency values('EUR','01AUG03'D,0.89678);
INSERT into bluesky.currency values('SGD','01AUG03'D,1.75323);
INSERT into bluesky.currency values('AUD','01AUG03'D,1.53413);
INSERT into bluesky.currency values('CAD','01AUG03'D,1.39553); 

INSERT into bluesky.currency values('USD','01SEP03'D,1);
INSERT into bluesky.currency values('EUR','01SEP03'D,0.88925);
INSERT into bluesky.currency values('SGD','01SEP03'D,1.74698);
INSERT into bluesky.currency values('AUD','01SEP03'D,1.51142);
INSERT into bluesky.currency values('CAD','01SEP03'D,1.36443); 

INSERT into bluesky.currency values('USD','01OCT03'D,1);
INSERT into bluesky.currency values('GBP','01OCT03'D,0.85461);
INSERT into bluesky.currency values('SGD','01OCT03'D,1.73361);
INSERT into bluesky.currency values('AUD','01OCT03'D,1.44498);
INSERT into bluesky.currency values('CAD','01OCT03'D,1.32373);

INSERT into bluesky.currency values('USD','01NOV03'D,1);
INSERT into bluesky.currency values('EUR','01NOV03'D,0.85405);
INSERT into bluesky.currency values('SGD','01NOV03'D,1.72961);
INSERT into bluesky.currency values('AUD','01NOV03'D,1.39728);
INSERT into bluesky.currency values('CAD','01NOV03'D,1.31250); 

INSERT into bluesky.currency values('USD','01DEC03'D,1);
INSERT into bluesky.currency values('EUR','01DEC03'D,0.81372);
INSERT into bluesky.currency values('SGD','01DEC03'D,1.71168);
INSERT into bluesky.currency values('AUD','01DEC03'D,1.35421);
INSERT into bluesky.currency values('CAD','01DEC03'D,1.31361); 

INSERT into bluesky.currency values('USD','01JAN04'D,1);
INSERT into bluesky.currency values('EUR','01JAN04'D,0.79411);
INSERT into bluesky.currency values('SGD','01JAN04'D,1.69837);
INSERT into bluesky.currency values('AUD','01JAN04'D,1.30219);
INSERT into bluesky.currency values('CAD','01JAN04'D,1.29660); 

INSERT into bluesky.currency values('USD','01FEB04'D,1);
INSERT into bluesky.currency values('EUR','01FEB04'D,0.79293);
INSERT into bluesky.currency values('SGD','01FEB04'D,1.68812);
INSERT into bluesky.currency values('AUD','01FEB04'D,1.28946);
INSERT into bluesky.currency values('CAD','01FEB04'D,1.32906); 

INSERT into bluesky.currency values('USD','01MAR04'D,1);
INSERT into bluesky.currency values('GBP','01MAR04'D,0.81540);
INSERT into bluesky.currency values('SGD','01MAR04'D,1.70165);
INSERT into bluesky.currency values('AUD','01MAR04'D,1.33446);
INSERT into bluesky.currency values('CAD','01MAR04'D,1.32894);

INSERT into bluesky.currency values('USD','01APR04'D,1);
INSERT into bluesky.currency values('EUR','01APR04'D,0.83267);
INSERT into bluesky.currency values('SGD','01APR04'D,1.68325);
INSERT into bluesky.currency values('AUD','01APR04'D,1.33851);
INSERT into bluesky.currency values('CAD','01APR04'D,1.33898); 

INSERT into bluesky.currency values('USD','01MAY04'D,1);
INSERT into bluesky.currency values('EUR','01MAY04'D,0.83349);
INSERT into bluesky.currency values('SGD','01MAY04'D,1.71124);
INSERT into bluesky.currency values('AUD','01MAY04'D,1.41819);
INSERT into bluesky.currency values('CAD','01MAY04'D,1.37745); 

INSERT into bluesky.currency values('USD','01JUN04'D,1);
INSERT into bluesky.currency values('EUR','01JUN04'D,0.82327);
INSERT into bluesky.currency values('SGD','01JUN04'D,1.71305);
INSERT into bluesky.currency values('AUD','01JUN04'D,1.43931);
INSERT into bluesky.currency values('CAD','01JUN04'D,1.36025); 

INSERT into bluesky.currency values('USD','01JUL04'D,1);
INSERT into bluesky.currency values('EUR','01JUL04'D,0.81557);
INSERT into bluesky.currency values('SGD','01JUL04'D,1.71462);
INSERT into bluesky.currency values('AUD','01JUL04'D,1.40982);
INSERT into bluesky.currency values('CAD','01JUL04'D,1.32778); 


/* CLIENT TABLE*/

INSERT into bluesky.client values(1001,'University of Texas','Alice', 'Eagleton','Administrative','512-495-4370','512-495-4374');
INSERT into bluesky.client values(2010,'Chicago State University','Holee', 'Davis','marketing','312-756-7890','');
INSERT into bluesky.client values(3007,'Heffers Booksellers ','Marge', 'Wallace','Sales','01223-568568','01223-354936');
INSERT into bluesky.client values(4008,'National University of Singapore','John', 'Clements','Administrative','874-2339','');
INSERT into bluesky.client values(5005,'University of Adelaide','Emily', 'Baird','Information technology','61-8-8303-4402','61-8-8830-4405');
INSERT into bluesky.client values(6090,"Heymann's ",'Gary', 'Smith','marketing','49-30-8252573','49-30-8242690');
INSERT into bluesky.client values(7008,'Cosmos 2000  ','Curtis', 'Jennings','Information technology','33-14-362-1899','33-14-352-1929');
INSERT into bluesky.client values(8003,'Lawrence Books ','Alan', 'Caston','Information technology','604-261-3612','604-261-3756');

/* ADDRESS TABLE*/

INSERT into bluesky.address values(1001,'6015 Pine Street','Austin','TX','77703-1232','USA','eagleton@usa.com');
INSERT into bluesky.address values(2010,'951 South King Drive','Chicago','IL','60628','USA','Hdavis@cat.org');
INSERT into bluesky.address values(3007,'200 Trinity St.','Cambridge','','CB23NG','UK','allace@unimedya.net');
INSERT into bluesky.address values(4008,'6D Lor Ampas'  ,'Singapore','','328781','Singapore','clements@biz.comp');
INSERT into bluesky.address values(5005,'102S North Terrace','Adelaide','','5005','Australia','ebaird@eod.people');
INSERT into bluesky.address values(6090,'Flemmingstr. 270','Berlin','','12163','Germany','g_smith@home.com');
INSERT into bluesky.address values(7008,"190 rue de l'Arc de Triomphe",'Paris','','75017','France','cjennings@medien.print');
INSERT into bluesky.address values(8003,'359 T 41st at Dunbar','Vancouver','BC','V5K2C3','Canada','acaston@usa.com');

/* Generate reports of all data within the newly CREATEd tables*/

TITLE "Reprint";
SELECT 	* 
FROM  	bluesky.reprint;

TITLE "Clients";
SELECT 	* 
FROM	bluesky.client;

TITLE "Address";
SELECT	* 
FROM	bluesky.address;

TITLE "Shipping";
SELECT 	* 
FROM	bluesky.shipping;

TITLE "Orders";
SELECT	*
FROM	bluesky.orders;

TITLE "Stock";
SELECT	*
FROM	bluesky.stock;

TITLE "Currency";
SELECT	*
FROM	bluesky.currency;

/** Add a contacts table for the example in Chapter 5*/

DROP table bluesky.contacts;

CREATE table bluesky.contacts (
 	clientno	num,
 	name 		char(25),
 	department	char(25),
	company		num);

INSERT into bluesky.contacts
	values(100,'John Stuart','Book Store',204)
	values(101,'Randy Hycal','Law Library',203)
	values(102,'Marissa Stone','Medical Library',203)
	values(203,'University of Adelaide','Purchasing',203)
	values(103,'Michael Masters','Law Library',204)
	values(204,'University of Texas','Purchasing',204)
	;

CREATE table bluesky.orderPend (
  	prodCode 	char(6),
  	ord_date 	date,
  	quantity 	num,
  	totsale 	num format comma10.2,
 	currency 	char(3),
 	delCode 	char(3) label='Delivery Code',
 	clientNo 	num, 
	invoice 	char(10));

	create index ord_date on bluesky.orderpend(ord_date);
	create unique index prodinv_pk on bluesky.orderpend(prodCode,invoice);

QUIT;

/************************************************************************************************************/
/* Chapter 2 
/************************************************************************************************************/

/* Page 17*/
PROC SQL; 

CREATE table stock (
 	ISBN 		char(13),
 	title 		char(50),
 	auth_fst	char(10),
	auth_lst	char(15),
 	category 	char(20),
 	reprint 	char(1),
 	stock 		num,
 	yrPubl 		num,
 	prodCode 	char(6),
 	price 		num,
   constraint stock_pk primary key(prodcode)
);
CREATE table orders (
  	prodCode 	char(6),
  	ord_date 	date,
  	quantity 	num,
  	totsale 	num,
 	currency 	char(3),
 	delCode 	char(3),
 	clientNo 	num, 
	invoice 	char(10),
constraint prod_fk foreign key(prodcode)references stock
on delete set null on update cascade
);

/* Page 20*/ 
TITLE1   "Sales Information by Product Code and Author";
TITLE2  "January 1, 2004 to May 31, 2004";

PROC SQL;

LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	stock.prodcode "Product Code" format=$15. ,
		stock.auth_lst "Author" format=$15.,
       	avg(order.quantity) as mnqty "Average Quantity" format=6.0,
       	avg(stock.price) as mnprice "Average Price" format=comma10.2,
       	sum(order.quantity*stock.price) as smprice "Quantity * Price" format=comma10.2
FROM   	bluesky.order, bluesky.stock
WHERE  	order.ord_date between '01JAN2004'd and '31MAY2004'd
       	and stock.prodcode = order.prodcode
GROUP BY stock.prodcode, stock.auth_lst
ORDER BY stock.auth_lst;

QUIT;

/* Page 22*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

PROC sort data=bluesky.stock;
	by prodcode;

PROC sort data=bluesky.orders;
	by prodcode;

DATA mrgdata;
	merge bluesky.stock bluesky.orders;
	by prodcode;
	keep prodcode auth_lst quantity price totprice;
	if ord_date >= '01JAN2004'd and ord_date <= '31MAY2004'd;
	Totprice = price*quantity;

PROC SUMMARY data=mrgdata nway;
	class prodcode auth_lst;
    var quantity price totprice;
    output out=newstuff mean= mnqty mnprice mntprice
    sum=sqty sqprice sqtprice;

PROC sort data=newstuff;
	by auth_lst;

PROC print data=newstuff noobs label;
	var prodcode auth_lst mnqty mnprice sqtprice ;
	label prodcode = 'Product Code'
	auth_lst = 'Author'
	mnqty = 'Average Quantity'
	mnprice = 'Average Price'
	sqtprice = 'Quantity * Price';
	format prodcode auth_lst $15. mnqty 6. mnprice comma10.2 sqtprice comma10.2;
	TITLE1  "Sales Information by Product Code and Author";
	TITLE2  "January 1, 2004 to May 31, 2004";

RUN;
/* Page 27 */

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	*
FROM 	bluesky.orders
/*Here is a comment within a SELECT statement on its own line*/
WHERE 	/*This is also a comment*/ prodcode = '500500';

/* Page 27 */
SELECT 	*
FROM 	bluesky.orders
WHERE 	prodcode = '500500' /*or prodcode = '400128' or prodcode = '400345'*/;

SELECT 	prodcode
FROM 	bluesky.stock;

/* Page 27 */
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	prodcode
FROM 	bluesky.stock;
*This is an alternate form of comment;

/* Page 29 */

CREATE table bluesky.neworder
	(prodcode char(6),
	ord_date date,
    quantity num);

/* Page 29 */
/* This example purposely does not include a LIBNAME statement*/

SELECT 	prodcode, ord_date, quantity
FROM 	bluesky.orders
WHERE 	quantity > 500;

/* Page 30 */
DESCRIBE TABLE bluesky.orderPend;

/* Page 32 */
LIBNAME bluesky ORACLE	
	user = scott password = tiger path = master schema = bluesky;

/* Page 33 */
LIBNAME bluesky ORACLE
	user = scott password = tiger path = master schema = bluesky;

CREATE table bluesky.neworder
		(prodcode char(6),
		 ord_date date,
		 quantity num);

/* Page 34 - dates should have been Jan 1,2004 to May 31, 2004*/

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

CONNECT to oracle (user=scott password=tiger path=master);

TITLE1  "Sales Information by Product Code and Author"; 
TITLE2  "January 1, 2004 to May 31, 2004";

SELECT	prodcode "Product Code" format=$15., 
		auth_lst "Author" format=$15.,
       	mnqty "Average Quantity" format=comma8.,
       	mnprice "Average Price" format= comma10.2,
       	smprice "Quantity * Price" format= comma10.2
FROM 	connection to oracle /* determines records returned to the SAS session*/
		(SELECT	stock.prodcode  , 
				stock.auth_lst ,
       			avg(orders.quantity) as mnqty ,
       			avg(stock.price) as mnprice,
       			sum(orders.quantity*stock.price) as smprice 
		FROM  	bluesky.orders, bluesky.stock
		WHERE  	orders.ord_date between '01-JAN-2003' and '31-MAY-2003'
       			and stock.prodcode = orders.prodcode
		GROUP BY stock.prodcode, stock.auth_lst
		ORDER BY stock.auth_lst);

DISCONNECT from oracle;
QUIT;

/* Page 37 */

PROC SQL PROMPT OUTOBS=10; 
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT * 
FROM bluesky.orders; 

RESET outobs=; 

SELECT * 
FROM bluesky.orders;

QUIT;

/* Page 38 */

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT * 
FROM bluesky.orders(obs=3 DROP=delcode);

QUIT;

/* Page 39*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

CREATE table orders
  AS  SELECT	* 
   	 	FROM 	bluesky.orders(DROP=currency delcode obs=10);

SELECT 	* 
FROM 	orders;

QUIT;

/* Page 40*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

CREATE VIEW ordview 
AS SELECT * 
   FROM bluesky.orders(read=dog);

SELECT * 
FROM ordview(pw=dog);

QUIT;

/* Page 43*/ 

ODS html file='order.html' style=BarrettsBlue nogtitle;
TITLE1 "Orders placed by Chicago State University";

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	s.title label="Book Title", sum(o.quantity) "Quantity" 
FROM 	bluesky.orders o, bluesky.stock s, bluesky.client c
WHERE 	o.clientno=c.clientno and c.company='Chicago State University'
		and o.prodcode = s.prodcode
GROUP BY s.title;

ODS html close;
QUIT;

/* Page 43*/ 

ODS html file='order.html' style=BarrettsBlue nogtitle;
TITLE1 font=italic bold color=black "Orders placed by Chicago State University";

/************************************************************************************************************/
/* Chapter 3 
/************************************************************************************************************/

/* Page 48 */
PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	* 
ORDER BY 	prodcode
FROM 	bluesky.orders;

QUIT;

/* Page 48 */
/*pre-requisite CREATE code is not included in the example in the book"*/

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
/* this section is not part of the example, but is required for the example to work*/
CREATE reprint
as select * from bluesky.reprint;

SELECT 	* 
FROM	reprint;
QUIT;


/* Page 49*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT    currency "Currency", mean(exchrate) "Average",
          max(exchrate) "Maximum", min(exchrate) "Minimum"
FROM      bluesky.currency
WHERE     currency IN ('CAD','EUR','SGD')
GROUP BY  currency;

QUIT;

/* Page 51*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

CONNECT TO ORACLE
(user=scott password=tiger path=master);

SELECT 	* 
FROM	CONNECTION TO ORACLE

(SELECT   currency "Currency", avg(exchrate) "Average",
          max(exchrate) "Maximum", min(exchrate) "Minimum"
FROM      bluesky.currency
WHERE     currency IN ('CAD','GBP','DEM')
GROUP BY  currency
);

DISCONNECT FROM ORACLE;

QUIT;

/* Page 53*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	prodcode, ord_date, quantity, totsale 
FROM	bluesky.orders
WHERE	ord_date > '01JUL2004'd;

QUIT;

/* Page 53*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	* 
FROM	bluesky.orders
WHERE	ord_date > '01JUL2004'd;

QUIT;

/* Page 55*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	DISTINCT ord_date
FROM	bluesky.orders
WHERE	ord_date > '01JUL2004'd;

QUIT;

/* Page 55*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	DISTINCT ord_date, clientno
FROM	bluesky.orders
WHERE	ord_date > '01JUL2004'd;

QUIT;

/* Page 56*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	count(distinct ord_date)  'Distinct order dates', 
		count(ord_date) 'Total number of order dates',
		count(distinct prodcode)'Distinct products',
		count(prodcode)'Total number of products'
FROM 	bluesky.orders;

QUIT;

/* Page 57*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	DISTINCT address.country, stock.category 
FROM 	bluesky.client, bluesky.orders,
		bluesky.address, bluesky.stock
WHERE 	client.clientno = address.clientno 
	and client.clientno = orders.clientno
	and orders.prodcode=stock.prodcode
	and country ne 'USA';

QUIT;

/* Page 58*/ 

LIBNAME bluesky "C:\mydata\bluesky bookstore\";

PROC SORT data=bluesky.currency out=new_table(keep=currency) NODUPKEY;
by currency;
RUN;
/* not part of the example, used to confirm the operation worked*/
PROC PRINT;
RUN;

* The following PROC SQL statement performs the same task;

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

CREATE TABLE new_table  
	AS 	SELECT DISTINCT currency
		FROM bluesky.currency;

QUIT;
/* not part of the example, used to make sure the example is correct*/
PROC SQL;
SELECT * FROM new_table;
QUIT;

/* Page 59*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

TITLE1	'Report of value of Art Books in Stock';
TITLE2	'Bluesky Publishing Company';

SELECT	title FORMAT = $40., 
		stock,
       	price FORMAT= dollar10.2,
        stock*price as totprice FORMAT= dollar12.2
FROM    	bluesky.stock
WHERE	category = 'arts'
ORDER 	by totprice;

QUIT;

/* Page 60*/ 

LIBNAME bluesky "C:\mydata\bluesky bookstore\";

PROC FORMAT;
value $category
'science'='General Science'
'engineering'='Engineering'
'arts' ='General Arts'
'medicine' = 'Medicine'
'computer' = 'Information Technology'
'general' = 'General Interest' 
;

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	distinct category "Category" format= $category. 
FROM 	bluesky.stock;

QUIT;

/* Page 61*/ 

TITLE1	'Report on value of Art Books in Stock';
TITLE2 'Bluesky Publishing Company';

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	title LABEL 'Book Titles' FORMAT= $40., 
		stock 'Qty of Books',
        price LABEL='Book Price' FORMAT= comma10.2,
        stock*price LABEL= 'Stock Value' FORMAT= comma10.2
FROM    bluesky.stock
WHERE	category = 'arts';

QUIT;

/* Page 64*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	title, stock, price, 
 	stock*price as totprice 'Total Stock Value'
FROM	bluesky.stock
WHERE	stock > 500
ORDER	by totprice;

QUIT;

/* Page 65*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	title, stock,
        price,
        stock*price as totprice 
FROM    bluesky.stock
WHERE 	CALCULATED totprice < 3000;

QUIT;

/* Page 67*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	CASE category
		when 'general' then 'General Subjects'
		when  'arts' then 'Arts and Philosophy'
		when  'science' then 'General Science'
		when  'medicine' then 'Medicine and Pharmacology'
		when  'engineering' then 'Engineering'
	end "Book Category" , 
	category, count(prodcode)"Number of Books" 
FROM bluesky.stock
GROUP BY category;

QUIT;

/* Page 68*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	CASE category
		when 'general' then 'General Subjects'
		when  'arts' then 'Arts and Philosophy'
		when  'science' then 'General Science'
		when  'medicine' then 'Medicine and Pharmacology'
		when  'engineering' then 'Engineering'
		else 'Not Categorized'
	end "Product Category" , 
	category, count(prodcode)"Number of Books" 
FROM bluesky.stock
GROUP BY category;

QUIT;

/* Page 70*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  orders.prodcode, orders.ord_date, 
		orders.quantity, orders.totsale, 
		client.cont_fst, client.cont_lst
FROM    bluesky.orders,
        bluesky.client
WHERE   orders.clientno = client.clientno
		and ord_date > '01JUL2004'd;

QUIT;
/* Page 70*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  o.prodcode, o.ord_date, 
		o.quantity, o.totsale, 
		c.cont_fst, c.cont_lst
FROM   	bluesky.orders AS o,
       	bluesky.client c
WHERE  	o.clientno = c.clientno;

QUIT;

/* Page 72*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	prodcode, ord_date
FROM    bluesky.orders
WHERE  	quantity >=500;

QUIT;
/* Page 73*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  title, stock*price as totprice 
FROM    bluesky.stock
WHERE 	CALCULATED totprice < 3000;

QUIT;

/* Page 75*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  prodcode 'Product Code' , ord_date 'Date Ordered' format=date9., 
		quantity 'Quantity' format=comma8.0, totsale 'Order Total' format= comma10.2
FROM    bluesky.orders
WHERE 	ord_date = '10MAR2004'd;

QUIT;

/* Page 76*/ 

LIBNAME bluesky "C:\mydata\bluesky bookstore\";

* The names data set would contain only those clients whose first name begins with A;

DATA names;
SET bluesky.client;
IF cont_fst =: 'A';
RUN;

* The following substring function would give the same results;
PROC SQL;

SELECT 	*
FROM 	bluesky.client
WHERE	SUBSTRN(cont_fst,1,1) = 'A';
/* Page 77*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	prodcode 'Product Code', ord_date 'Date Ordered' format=date9.,
		quantity 'Quantity' format=comma8.0, totsale 'Order Total' format= comma10.2
FROM   	bluesky.orders
WHERE   quantity > 200 and ord_date = '10MAR2004'd;

QUIT;

/* Page 77*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  prodcode 'Product Code' , ord_date 'Date Ordered' format=date9.,
		quantity 'Quantity' format=comma8.0, totsale 'Order Total' format= comma10.2
FROM   	bluesky.orders
WHERE   quantity >1000 or ord_date = '10MAR2004'd;

QUIT;

/* Page 78*/ 

PROC SQL;

LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  prodcode 'Product Code' , ord_date 'Date Ordered' format=date9.,
		quantity 'Quantity' format=comma8.0, totsale 'Order Total' format= comma10.2
FROM   	bluesky.orders
WHERE  	quantity > 1000 and ord_date = '10MAR2004'd or ord_date = '23JUL2004'd;

QUIT;
/* Page 79*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  prodcode 'Product Code' , ord_date 'Date Ordered' format=date9.,
		quantity 'Quantity' format=comma8.0, totsale 'Order Total' format= comma10.2
FROM   	bluesky.orders
WHERE 	quantity > 1000 and (ord_date = '10MAR2004'd or ord_date = '23JUL2004'd);

QUIT;
/* Page 79*/ 

PROC SQL;
OPTIONS obs=10;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  prodcode 'Product Code' , ord_date 'Date Ordered' format=date9.,
		quantity 'Quantity' format=comma8.0, totsale 'Order Total' format=comma10.2
FROM    bluesky.orders
WHERE  	quantity > 1000 and 
		ord_date = '10MAR2004'd or '23JUL2004'd;

QUIT;

OPTIONS obs=max;
/* Page 81*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	prodcode 'Product Code' , ord_date 'Date Ordered' format=date9.,
		quantity 'Quantity' format=comma8.0, totsale 'Order Total' format= comma10.2
FROM	bluesky.orders
WHERE	quantity > 1000 AND 
		(ord_date='10MAR2004'd OR '12JUN2004'd);

QUIT;
/* Page 81*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  prodcode 'Product Code' , ord_date 'Date Ordered' format=date9.,
		quantity 'Quantity' format=comma8.0, totsale 'Order Total' format= comma10.2
FROM   	bluesky.orders
WHERE  	quantity >= 1000 and
		(ord_date='10MAR2004'd or ord_date= '23JUL2004'd 
		or ord_date= '12JUN2004'd or ord_date= '12APR2004'd
		or ord_date='12MAY2004'd);

QUIT;
/* Page 81*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	prodcode 'Product Code' , ord_date 'Date Ordered' format=date9.,
		quantity 'Quantity' format=comma8.0, totsale 'Order Total' format= comma10.2
FROM   	bluesky.orders
WHERE  	quantity >= 1000  and
		ord_date IN ('10MAR2004'D,'23JUL2004'd,'12JUN2004'd,'12APR2004'd,'12MAY2004'd);

QUIT;

/* Page 82*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  prodcode 'Product Code' , ord_date 'Date Ordered' format=date9.,
		quantity 'Quantity' format=comma8.0, totsale 'Order Total' format= comma10.2
FROM   	bluesky.orders
WHERE  	quantity >= 1000  and
		(ord_date NOT IN('10MAR2004'D,'23JUL2004'd,'12JUN2004'd,'12APR2004'd,'12MAY2004'd));

QUIT;
/* Page 83*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	title, category, stock
FROM 	bluesky.stock
WHERE 	scan(isbn,3) = '1209';

QUIT;
/* Page 84*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	prodcode, ord_date,clientno
FROM 	bluesky.orders
WHERE 	ord_date between '01FEB2003'd and '30APR2003'd;

QUIT;
/* Page 84*/ 

PROC SQL;
OPTIONS OBS=10;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	prodcode, ord_date,clientno
FROM 	bluesky.orders
WHERE 	ord_date NOT between '01FEB2003'd and '30APR2004'd;

QUIT;
/* Page 85*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	*
FROM 	bluesky.currency
WHERE 	exchrate is null;

QUIT;
/* Page 86*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	company, cont_fst||cont_lst "Contact Name", phone
FROM 	bluesky.client
WHERE 	fax is missing;

QUIT;
/* Page 87*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	isbn, title, prodcode
FROM 	bluesky.stock
WHERE 	title like '%Computer%';

QUIT;
/* Page 88*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	isbn, title, prodcode
FROM 	bluesky.stock
WHERE 	title like '%Computer';

QUIT;
/* Page 89*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	*
FROM 	bluesky.shipping
WHERE 	delcode like 'EX_';

QUIT;
/* Page 89*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	isbn, title, prodcode
FROM	bluesky.stock 
WHERE 	title like '%Computer_';

QUIT;

/* Page 90*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	isbn, title, prodcode
FROM 	bluesky.stock
WHERE 	trim(title) like '%Computer_';

QUIT;
/* Page 90*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	isbn, title, prodcode
FROM	bluesky.stock
WHERE 	prodcode like '___1__';  

QUIT;
/* Page 91*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	title
FROM 	bluesky.stock
WHERE 	title like '%Computer*_%' escape '*'
		or title like '%#%%' escape '#';

QUIT;
/* Page 92*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	title
FROM 	bluesky.stock
WHERE 	title EQT 'Medi';

QUIT;
/* Page 93*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	isbn, title, prodcode
FROM 	bluesky.stock
WHERE 	title contains 'Medi';

QUIT;

/* Page 94*/ 
 
PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	clientno, email
FROM	bluesky.address 
WHERE	email contains '_';

QUIT;
/* Page 94*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	title
FROM	bluesky.stock
WHERE	title contains '%';

QUIT;
/* Page 95*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	title, auth_lst, auth_fst
FROM	bluesky.stock 
WHERE	auth_lst =* 'Johnson';

QUIT;

/* Page 96*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	s.title "Title" format=$25., 
		c.company "Customer" format=$35., 
		a.city "Location" format=$12.,
		o.totsale "Total Sale" format=dollar10.2
FROM   	bluesky.orders o,
        bluesky.address a,
		bluesky.client c,
		bluesky.stock s
WHERE   o.clientno = a.clientno
		and a.clientno = c.clientno
		and o.prodcode=s.prodcode
        and s.category in ('arts', 'general')
		and o.quantity >=100;

QUIT;

/* Page 98*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  company "Company", phone "Phone",
        cont_fst "First Name", cont_lst "Last Name"
FROM    bluesky.client
ORDER BY company;

QUIT;
/* Page 98*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  company "Company", phone "Phone",
        cont_fst||cont_lst as name "Contact Name"
FROM    bluesky.client
ORDER BY name;

QUIT;
/* Page 99*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  company "Company", phone "Phone",
        cont_fst||cont_lst as name "Contact Name"
FROM    bluesky.client
ORDER BY 3;

QUIT;
/* Page 101*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  ord_date, clientno, prodcode, quantity
FROM    bluesky.orders
WHERE	ord_date > '01APR2004'd
ORDER BY ord_date desc, clientno asc, quantity desc;

QUIT;
/* Page 103*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  ord_date "Date", 
        count(prodcode) "Count", 
		mean(quantity) "Avg Quantity" format=6.1
FROM   	bluesky.orders
WHERE	ord_date > '01JAN2004'd
GROUP BY ord_date;

QUIT;
/* Page 103*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	ord_date, clientno, prodcode, quantity
FROM    bluesky.orders
GROUP BY ord_date, clientno;

QUIT;
/* Page 104*/ 

/* only the output is included in the figure*/

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	ord_date, clientno, prodcode, quantity
FROM    bluesky.orders
WHERE	ord_date >='01JAN04'd and ord_date<='31MAY04'd;
QUIT;
/* Page 105*/ 

TITLE1	'Average Monthly quantity sold and total sales';
TITLE2 	'Between Jan 1, 2004 and May 31, 2004';

PROC FORMAT;
value monthChar
1='January'
2='February'
3='March'
4 ='April'
5 = 'May'
;
PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	month(ord_date) as month "Month" format monthchar. ,
         sum(totsale) format= comma10.2 "Total Sale" as total,
         mean(quantity) format= comma10.2 "Avg Quantity" as avgqty
FROM 	bluesky.orders
WHERE  	ord_date between '01JAN2004'd and '31MAY2004'd
GROUP BY month;

QUIT;

/* Page 106*/ 

TITLE1 'Average Monthly quantity sold and total sales';
TITLE2 'Between Jan 1, 2004 and May 31, 2004';

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	month(ord_date) as month "Month" format monthchar. ,
        sum(totsale) format= comma10.2 "Total Sale" as total,
        mean(quantity) format= comma10.2 "Avg Quantity" as avgqty
FROM    bluesky.orders
WHERE   ord_date between '01JAN2004'd and '31MAY2004'd
GROUP BY month(ord_date); 

QUIT;

/* Page 108*/ 

TITLE1 'Average Monthly quantity sold and total sales';
TITLE2 'Between Jan 1, 2004 and May 31, 2004';

PROC SQL;

LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	month(ord_date) as months "Month" format monthchar. ,
        sum(totsale) format= comma10.2 "Total Sale" as total,
        mean(quantity) format= comma10.2 "Avg Quantity" as avgqty
FROM    bluesky.orders
WHERE   ord_date between '01JAN2004'd and '31MAY2004'd
GROUP BY ord_date;

QUIT;
/* Page 109*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  ord_date "Date",
        count(prodcode) "Count", 
		mean(quantity) format= comma8.2 "Avg Quantity"
FROM   	bluesky.orders
WHERE	ord_date between '01JAN2004'd and '31MAY2004'd
GROUP BY ord_date, clientno;

QUIT;
/* Page 109*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  ord_date "Date", clientno "Client",
        count(prodcode) "Count", mean(quantity) format= comma8.2 "Avg Quantity"
FROM    bluesky.orders
WHERE	ord_date between '01JAN2004'd and '31MAY2004'd
GROUP BY ord_date, clientno;

QUIT;

/* Page 110*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  ord_date "Date" ,clientno "Client",
        currency "Currency",
       	sum(totsale) format= comma10.2 "Total Sale" as total,
        mean(quantity) format= comma10.2 "Avg Quantity" as avgqty
FROM    bluesky.orders
WHERE	ord_date between '01JAN2004'd and '31MAY2004'd
GROUP BY ord_date;

QUIT;

/* Page 111*/ 

PROC SQL;

LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  ord_date "Date", clientno "Client",
        currency "Currency",
        sum(totsale) format= comma10.2 "Total Sale" as total,
        mean(quantity) format= comma10.2 "Avg Quantity" as avgqty
FROM    bluesky.orders
WHERE	ord_date between '01JAN2004'd and '31MAY2004'd
GROUP BY ord_date, clientno, currency;

QUIT;

/* Page 113*/ 

PROC SQL;

LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  ord_date "Date" ,clientno "Client",
        currency "Currency",
        sum(totsale) format= comma10.2 "Total Sale" as total,
        mean(quantity) format= comma10.2 "Avg Quantity" as avgqty
FROM    bluesky.orders
WHERE   clientno NE 4008 and ord_date between '01JAN2004'D and '31MAY2004'D
GROUP BY ord_date, clientno, currency
HAVING  avgqty > 200 and total > 10000;

QUIT;

/* Page 114*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  ord_date "Date" ,
        count(prodcode) "Number of Products",
        mean(quantity) format= comma8.2 "Avg Quantity" as avgqty
FROM    bluesky.orders
WHERE	ord_date between '01JAN2004'd and '31MAY2004'd
GROUP BY ord_date;

QUIT;

/* Page 114*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  ord_date "Date" ,
        count(prodcode) "Number of Products",
        mean(quantity) format= comma8.2 "Avg Quantity" as avgqty
FROM    bluesky.orders
WHERE	ord_date between '01JAN2004'd and '31MAY2004'd
GROUP BY ord_date
ORDER BY avgqty desc;

QUIT;

/* Page 117*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  ord_date "Date",
        sum(totsale) format= comma10.2 "Total Sale" as total,
        mean(quantity) format= comma10.1 "Avg Quantity" as avgqty
FROM    bluesky.orders
GROUP BY ord_date;

QUIT;

/* Page 118*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  ord_date "Date",
        sum(totsale) format= comma10.2 "Total Sale" as total,
        mean(quantity) format= comma10.1 "Avg Quantity" as avgqty
FROM    bluesky.orders
GROUP BY ord_date
HAVING  avgqty > 600 and total > 10000;

QUIT;

/* Page 119*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  ord_date "Date",
        sum(totsale) format =comma10.2 "Total Sale" as total,
        mean(quantity) format= comma10.1 "Avg Quantity" as avgqty
FROM    bluesky.orders
WHERE   clientno ne 3007
GROUP BY ord_date
HAVING  avgqty > 600 and total > 10000;

QUIT;

/* Page 120*/ 

TITLE1	'Details on most recent sales date';
PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	ord_date "Date",
       	clientno "Client No.",
       	totsale format= comma10.2 "Total Sale" ,
       	quantity format= comma10.2 "Quantity Ordered",
      	prodcode "Product code"
FROM  	bluesky.orders
HAVING 	ord_date = max(ord_date);

QUIT;

/* Page 122*/ 

TITLE1 	'Orders as percentage of total sales and quantity';
PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	Ord_date "Date", clientno "Client No.",
		totsale "Total sale", quantity "Quantity",
        totsale/sum(totsale) format= percent10. "Sale as % of total sales ",
        quantity/sum(quantity) format= percent10. "Quantity as % of total quantity"

FROM     bluesky.orders
WHERE    ord_date between '01JAN2004'd and '31MAY2004'd ;

QUIT;

/* Page 124*/ 

TITLE1 'Books in inventory that were sold between January 1 and May 31, 2004';

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  DISTINCT isbn, title, category
FROM 	bluesky.stock
      	JOIN 	bluesky.orders
		ON 	stock.prodcode = orders.prodcode
        and orders.ord_date between '01JAN2004'd and '31MAY2004'd
ORDER BY 	stock.title;

QUIT;

/* Page 125*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  	count(isbn) as orders "No. of Orders",
        	category "Category"
FROM    	bluesky.stock JOIN bluesky.orders
			ON	stock.prodcode = orders.prodcode
        	and orders.ord_date between '01JAN2004'd and '31MAY2004'd
GROUP BY 	category
HAVING 		orders > 1
ORDER BY 	category desc;

QUIT;

/* Page 126*/ 

PROC SQL;

CREATE view address AS
	SELECT 	* 
	FROM 	oralib.address
	USING 	LIBNAME oralib oracle
  	  		user = scott password = tiger path= master schema=bluesky;
/* not part of the example used to confirm results only*/
/*select * from address;*/
QUIT;

/* Page 128*/ 


PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

TITLE1	"Arts, Engineering and Medical book orders";
TITLE2	"Quantity > 100 and Total Sale > $1000";
TITLE3	"January 1, 2004 to June 30, 2004";

SELECT  s.title "Title" format=$30., 
		c.company "Customer" format=$35., 
		sum(o.totsale) as total "Total Sale" format=dollar15.2,
		sum(o.quantity) as qty "Total Qty" format=comma8.
FROM   	bluesky.orders o,
       	bluesky.client c,
		bluesky.stock s
WHERE  	o.clientno = c.clientno
		and o.prodcode=s.prodcode
		and s.category in ('arts', 'engineering','medicine')
		and o.ord_date between '01JAN2004'd and '30JUN2004'd
GROUP BY s.title, c.company  
HAVING	qty > 100 and total > 1000
ORDER BY total desc;

QUIT;

/************************************************************************************************************/
/* Chapter 4 
/************************************************************************************************************/

/* Page 135*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT title, round(stock*price)
FROM   bluesky.stock
WHERE  round(stock*price) < 3000;

/* Page 136*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT title , round(stock*price) as totprice 
FROM   bluesky.stock
WHERE  CALCULATED totprice < 3000;
QUIT;
 
/* Page 137*/ 

PROC SQL; 
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  title,round(stock*price) as totprice
FROM    bluesky.stock
WHERE   CALCULATED totprice < 3000
ORDER BY totprice;
QUIT; 

/* Page 138*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  SUBSTR(auth_lst,1,1) as lastinit format= $10.,
        count(prodcode) "Count"
FROM    bluesky.stock
WHERE   CALCULATED lastinit IN ('B','C','D','E','F')
GROUP BY lastinit;
QUIT;


/* Page 138*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  SUBSTR(auth_lst,1,1) as lastinit format= $10.,
        count(prodcode) "Count"
FROM    bluesky.stock
WHERE   CALCULATED lastinit IN ('B','C','D','E','F')
GROUP BY SUBSTR(auth_lst,1,1);
QUIT;


/* Page 139*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  DISTINCT SUBSTR(auth_lst,1,1) as lastinit format= $10.,
        count(prodcode) "Count"
FROM    bluesky.stock
WHERE   CALCULATED lastinit IN ('B','C','D','E','F');
QUIT;

/* Page 140*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	state, length(state) as length
FROM	bluesky.address;
QUIT;

/* Page 141*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	title, ROUND(price * 1.33) "CDN price" format= comma10.2
FROM	bluesky.stock
WHERE	category = 'science';
QUIT;

/* Page 141*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  title, price format=comma10.2, currency.exchrate,
        ROUND(price * currency.exchrate) "CDN price" format= comma10.2
FROM    bluesky.stock, bluesky.currency
WHERE   currency.cur_date = '01FEB04'd and currency.currency = 'CAD'
        and stock.category = 'science';
QUIT;

/* Page 142*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  title format= $30., ISBN format= $15.,
        scan (isbn, 3, '-') "Title Identifier" format =$10.
FROM    bluesky.stock
WHERE   category = 'general';
QUIT;

/* Page 135*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	"Stock to Cutoff Range for Arts Books";

SELECT	title 'Title', RANGE(stock,r.cutoff ) 'Range' 
FROM	bluesky.stock s, bluesky.reprint r
WHERE	category = 'arts' 
		and s.reprint=r.reprint;
QUIT;

/* Page 144*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	verify(reprint, 'ABCDEF')as check
FROM	bluesky.stock
WHERE	calculated check > 0;
QUIT;

/* Page 145*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  stock "Numeric Stock value", left(put(stock,10.)) "Text Stock value" format $7.,
        length(put(stock,10.)) "Length of Stock value w/o compression",
        length(compress(put(stock,10.),' ')) "Length of Stock value",
        scan(isbn,3,'-') "Part of Text ISBN" format=$10. ,
        input(scan(isbn,3,'-'),4.2) "Numeric ISBN",
        int(input(scan(isbn,3,'-'),4.2)) "Integer portion of ISBN"
FROM    bluesky.stock
WHERE   category = 'general';
QUIT;

/* Page 146*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  stock "Numeric STOCK value", 
		left(put(stock,10.)) "Text Stock value" format=$7.,
        length(put(stock,10.)) "Length of Stock value w/o compression",
        length(compress(put(stock,10.),' ')) "Length of Stock value",
        scan(isbn,3,'-') "Part of Text ISBN" format=$10.,
        input(scan(isbn,3,'-'),4.2) "Numeric ISBN",
        int(input(scan(isbn,3,'-'),4.2)) "Integer portion of ISBN"
FROM    bluesky.stock
WHERE   category = 'general';
QUIT;

/* Page 147*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	state, length(state) as length
FROM	bluesky.address;
QUIT;

/* Page 148*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  city "City", state "State", country "Country",
        coalesce(city, state, country) "Coalesce result"
FROM    bluesky.address;
QUIT;

/* Page 149*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	coalesce(order_2001_2002.clientno, orders.clientno) as combine "Clients",
		coalesce(min(order_2001_2002.ord_date), 
		min(orders.ord_date)) format=date9."Earliest order date"
FROM   	bluesky.order_2001_2002 FULL JOIN bluesky.orders
		ON 	orders.clientno = order_2001_2002.clientno
GROUP BY combine;
QUIT;

/* Page 150*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  count (distinct category) "Count of unique categories",
        count(distinct auth_lst) "Count of unique author names",
        count(prodcode) "Count of number of products"
FROM    bluesky.stock;
QUIT;

/* Page 151*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  category "Category",
        min(price) "Minimum Price" format= comma10.2,
        max(price) "Maximum Price" format= comma10.2
FROM    bluesky.stock
GROUP BY category;
QUIT;

/* Page 151*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  category "Category",
        min(price) "Minimum Price" format =comma10.2,
        max(price) "Maximum Price" format= comma10.2
FROM    bluesky.stock
WHERE   price > 15
GROUP BY category;
QUIT;

/* Page 152*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  category "Category",
        min(price) "Minimum Price" format= comma10.2,
        max(price) "Maximum Price" format= comma10.2
FROM    bluesky.stock
WHERE   price > (SELECT mean(price)
                 FROM bluesky.stock)
GROUP BY category;
QUIT;

/* Page 153*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  category "Category",
        min(price) as minpr "Minimum Price" format= comma10.2,
        max(price) "Maximum Price" format= comma10.2
FROM    bluesky.stock
GROUP BY category
HAVING  minpr > 15;
QUIT;

/* Page 153*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  category "Category",
        min(price) as minpr "Minimum Price" format= comma10.2,
        max(price) "Maximum Price" format= comma10.2
FROM    bluesky.STOCK
GROUP BY category
ORDER BY minpr;
QUIT;

/* Page 154*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT mean(totsale) "Average sale" format= comma10.2,
       min(totsale) "Minimum sale" format= comma10.2,
       max(totsale) "Maximum sale" format= comma10.2
FROM   bluesky.orders;
QUIT;

/* Page 155*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  mean(totsale/quantity) "Average book price per order" format=10.2
FROM    bluesky.orders; 
QUIT;

/* Page 155*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	sum(stock*(category='engineering'))/sum(stock*(category='computer')) 
		format=percent10. 'Engineering to Computer'
FROM	bluesky.stock;
QUIT;

/* Page 156*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  category, range(round(price)) "PRICE"
FROM    bluesky.stock
GROUP BY category;
QUIT;

/* Page 157*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

CREATE table average
AS 	SELECT avg(price) as avgprice
	FROM bluesky.stock
	WHERE category in ('arts','science');

SELECT 	* 
FROM 	average;
QUIT;

/* Page 157*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  title "Title" , category "Category" ,
        price/avgprice "Price/Avg. Price" format= 6.2
FROM    bluesky.stock, average
WHERE   category IN ('arts','science');
QUIT;

/* Page 158*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  title "Title" , category "Category" ,
        price/(avg(price)) "Price/Avg. Price" format= 6.2
FROM    bluesky.stock
WHERE   category IN ('arts','science');
QUIT;

/************************************************************************************************************/
/* Chapter 5 
/************************************************************************************************************/

/* Page 165*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT 	company, address
FROM 	bluesky.client, bluesky.address
WHERE 	country = 'USA';
QUIT;

/* Page 167*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	company, address
FROM	bluesky.client INNER JOIN bluesky.address
WHERE	country = 'USA';
QUIT;

/* Page 169*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	"Product orders by company";

SELECT	o.prodcode "Product Code", o.ord_date "Date Ordered",
		c.company "Company"
FROM 	bluesky.client c, bluesky.orders o
WHERE	c.clientno = o.clientno
		and month(o.ord_date) = 4;
QUIT;

/* Page 173*/ 
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

PROC SORT data=bluesky.client;
	by clientno;

PROC SORT data=bluesky.orders;
	by clientno;

DATA MERGEALL;
   MERGE bluesky.client
         bluesky.orders;
        BY clientno;

if month(ord_date) =4;

LABEL	prodcode= 'Product Code'
	company = 'Company'
	ord_date='Date Ordered';


PROC PRINT noobs label;
	var prodcode ord_date company;
run;

/* Page 174*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  c.company, a.address
FROM    bluesky.client c, bluesky.address a
WHERE   c.clientno = a.clientno and country='USA' or country = 'UK'
;
QUIT;


/* Page 176*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  	c.company, a.address
FROM    	bluesky.client c, bluesky.address a
WHERE   	c.clientno = a.clientno and country ='USA' 
	or c.clientno=a.clientno and country ='UK';

/* Query is offered as 2 choices, but results are shown only once */

SELECT  	c.company, a.address
FROM    	bluesky.client c, bluesky.address a
WHERE   	c.clientno = a.clientno and (country ='USA' or country ='UK');
QUIT;

/* Page 176*/ 

LIBNAME bluesky "C:\mydata\bluesky bookstore\";

PROC sort data=bluesky.address;
by clientno;

DATA MERGEALL;
   MERGE bluesky.client (in=in1)
         bluesky.address (in=in2);
        BY clientno;
if (country='USA' or country='UK')and (in1 and in2);

PROC print noobs ;
var company address;
RUN;

/* Page 177*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	"All general and arts books for which there are orders";

SELECT	orders.prodcode "Product Code" format= $15., 
		stock.category "Category" format= $10.,
		stock.title "Title" format= $40.
FROM	bluesky.stock, bluesky.orders
WHERE	stock.prodcode = orders.prodcode
		AND stock.category IN ('arts', 'general')
ORDER BY	stock.category, stock.title;
QUIT;

/* Page 178*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

TITLE1	'All general and arts books for which there are orders';

SELECT	DISTINCT o.prodcode "Product Code" format= $15., 
		s.category "Category" format= $10.,
		s.title "Title" format= $40.
FROM	bluesky.stock s, bluesky.orders o
WHERE	s.prodcode = o.prodcode
AND 	(s.category ='arts' OR s.category= 'general')
ORDER BY 2,3;
QUIT;

/* Page 179*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

TITLE1	'Book Orders - First Quarter 2004';

SELECT	client.company "Company" format= $30.,
		address.city "City" format= $15.,
		orders.ord_date "Order Date", 
		stock.title "Title" format= $30.

FROM	bluesky.client, bluesky.address, 
		bluesky.orders, bluesky.stock

WHERE	stock.prodcode=orders.prodcode
		AND client.clientno=address.clientno
		AND orders.clientno=client.clientno
		AND ord_date between '01JAN2004'd and '30MAR2004'd

ORDER BY client.company, orders.ord_date;
QUIT;

/* Page 180*/ 
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

PROC sort data=bluesky.client;
  by clientno;

PROC sort data=bluesky.address;
  by clientno;

DATA clntadd (keep=clientno company city);
   MERGE bluesky.client (in=in1)
         bluesky.address (in=in2);
         BY clientno;
   if in1 and in2;

PROC SORT data=bluesky.stock;
  by prodcode;

PROC SORT data=bluesky.orders;
  by prodcode;

DATA stkorder(keep=ord_date clientno title);
  MERGE bluesky.stock (in=in1)
		bluesky.orders (in=in2);
		BY prodcode;
  if in1 and in2;
  if ord_date >= '01JAN2004'd and ord_date <='30MAR2004'd;

PROC SORT data=stkorder;
  by clientno;

PROC SORT data=clntadd;
  by clientno;

DATA final;
  MERGE  stkorder (in=in1)
	clntadd (in=in2);
	BY clientno;
  if in1 and in2;

PROC SORT data=final;
  by company ord_date;
	
PROC print noobs ;
  var company city ord_date title;
RUN;

/* Page 183*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	"All general and arts books for which there are orders";

SELECT	distinct orders.prodcode "Product Code" format= $15., 
		stock.category "Category" format= $10.,
		stock.title "Title" format= $40.

FROM	bluesky.stock INNER JOIN bluesky.orders
		ON stock.prodcode=orders.prodcode

WHERE	stock.category = 'arts' OR stock.category = 'general'
ORDER BY 2,3;
QUIT;

/* Page 184*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1 'All general and arts books';

SELECT	distinct o.prodcode "Product Code" format= $15.,
		s.category "Category" format= $10.,
		s.title "Title" format= $40.

FROM	bluesky.stock s JOIN bluesky.orders o
		ON s.prodcode = o.prodcode

WHERE	s.category IN ('arts','general')
ORDER BY 2;
QUIT;

/* Page 185*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1 'Product orders by company';

SELECT	orders.prodcode label="Product Code" format= $8.,
		orders.ord_date "Date Ordered" format= date9.,
		client.company "Company" format= $40.

FROM	bluesky.orders JOIN bluesky.client
		ON orders.clientno = client.clientno
WWHERE	month(ord_date)=4
ORDER BY 1;	
QUIT;

/* Page 186*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'All General Book Orders - Order, Stock and Client tables';

SELECT	client.company "Company" format= $20.,
		order2.clientno "Client #" format= 10.,
		order1.prodcode "Product Code" format= $15.,
		stock.title "Title" format= $20.
	
FROM 	bluesky.stock JOIN bluesky.orders order1
		ON stock.prodcode=order1.prodcode,

		bluesky.client JOIN bluesky.orders order2
		ON order2.clientno = client.clientno
		AND order1.prodcode = order2.prodcode
		AND order1.clientno = order2.clientno

WHERE	stock.category = 'general';
QUIT;

/* Page 187*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	client.company "Company" format= $20.,
		orders.clientno "Client #" format= 10.,
		orders.prodcode "Product Code" format= $15.,
		stock.title "Title" format= $20.

FROM	bluesky.stock, bluesky.orders ,
		bluesky.client 
	
WHERE	orders.clientno = client.clientno
		and stock.prodcode=orders.prodcode
       	and stock.category = 'general';
QUIT;

/* Page 188*/ 

PROC SQL;

CONNECT to oracle (user=scott password=tiger path=master);

TITLE1  "Sales Information by Product Code and Author"; 
TITLE2  "January 1, 2004 to May 31, 2004";

SELECT	prodcode "Product Code" format=$15., 
		auth_lst "Author" format=$15.,
       	mnqty "Average Quantity" format=comma8.,
       	mnprice "Average Price" format= comma10.2,
       	smprice "Quantity * Price" format= comma10.2
FROM connection to oracle /* determines records returned to the SAS session*/

(SELECT	stock.prodcode  , 
		stock.auth_lst ,
       	avg(orders.quantity) as mnqty ,
       	avg(stock.price) as mnprice,
       	sum(orders.quantity*stock.price) as smprice 
FROM  	bluesky.orders, bluesky.stock
WHERE  	orders.ord_date between '01-JAN-2004' and '31-MAY-2004'
       	and stock.prodcode = orders.prodcode
GROUP BY stock.prodcode, stock.auth_lst
ORDER BY stock.auth_lst);

DISCONNECT from oracle;
QUIT;

/* Page 189*/ 

PROC SQL;

LIBNAME bluesky ORACLE
	user=scott password=tiger path=master schema=bluesky;

TITLE1  "Sales Information by Product Code and Author";
TITLE2  "January 1, 2004 to May 31, 2004";
	
SELECT 	stock.prodcode "Product Code" format=$15., 
		stock.auth_lst "Author" format=$15.,
       	avg(orders.quantity) as mnqty "Average Quantity" format=comma8.,

       	avg(stock.price) as mnprice "Average Price" format= comma10.2,
       	sum(orders.quantity*stock.price) as smprice "Quantity * Price" format= comma10.2
FROM  	bluesky.orders, bluesky.stock
WHERE  	orders.ord_date between '01JAN2004'd and '31MAY2004'd
       	and stock.prodcode = orders.prodcode
GROUP BY stock.prodcode, stock.auth_lst
ORDER BY stock.auth_lst;

QUIT;
/* Page 190*/ 

PROC SQL;

LIBNAME orablue ORACLE
user=scott password=tiger path=bluesky;

LIBNAME bluesky "C:\mydata\bluesky bookstore\";

LIBNAME sqlsrvr ODBC
dsn='bluesky';

TITLE1  "Sales Information by Product Code and Author";
TITLE2  "January 1, 2003 to May 31, 2003";
TITLE3  "Compared to same period in 2001";
	
SELECT 	stock.prodcode "Product Code" format=$15., 
		stock.auth_lst "Author" format=$15.,
       	avg(orders.quantity) as mnqty2003 "Average Quantity (2003)" format=comma8.,
		avg(orders_2000_2001.quantity) as mnqty2001 "Average Quantity (2001)
		" format=comma8.,
       	avg(stock.price) as mnprice "Average Price" format= comma10.2,
       	sum(orders.quantity*stock.price) as smprice2003 "Quantity * Price (2003)" format= comma10.2,
       	sum(orders_2000_2001.quantity*stock.price) as smprice2001 "Quantity * Price (2001)" format= comma10.2

FROM  	orablue.orders, orablue.stock, sqlsrvr.orders_2000_2001
WHERE  	orders.ord_date between '01JAN2003'd and '31MAY2003'd
		and orders_2000_2001.ord_date between '01JAN2001'd and '31MAY2001'd
       	and stock.prodcode = orders.prodcode
		and stock.prodcode=orders_2000_2001.prodcode
		
GROUP BY stock.prodcode, stock.auth_lst
ORDER BY stock.auth_lst;
QUIT; 

/* Page 192*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'Book Titles to be Reprinted';

SELECT  stock.title "Title" format= $40.
FROM    bluesky.stock, bluesky.reprint
WHERE   stock.reprint = reprint.reprint
        AND stock.stock LE reprint.cutoff;
QUIT;

/* Page 193*/ 

LIBNAME bluesky "C:\mydata\bluesky bookstore\";

PROC FREQ data=bluesky.stock order=formatted;
TABLES prodcode ;
FORMAT prodcode $product.;
RUN;

/* Page 194*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

CREATE table bluesky.prodlabel
	(prodcode_low 	num,
	prodcode_high 	num,
	description 		char (25)
	);

INSERT into bluesky.prodlabel
  values (100000,200000,'General Science')
  values (200000,300000,'Engineering')
  values (300000,400000,'General Arts')
  values (400000,500000,'Medicine')
  values (500000,600000,'Information Technology')
  values (600000,700000,'General Interest');

SELECT 	description, count(prodcode) as Frequency,
		count(prodcode)/(select count(prodcode) from bluesky.stock)as Percent
		format=percent8.2
FROM 	bluesky.stock, bluesky.prodlabel 
WHERE 	input(prodcode,6.) >= prodcode_low and
		input(prodcode,6.) < prodcode_high
GROUP BY description;

QUIT;

/* Page 196*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1 'Book Titles to be Reprinted';

SELECT	stock.title "Title" format= $40.
FROM	bluesky.stock JOIN bluesky.reprint
		ON stock.stock LE reprint.cutoff
		AND stock.reprint = reprint.reprint ;
QUIT;

/* Page 197*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

TITLE1	'Book Titles to be Reprinted';
SELECT	stock.title "Title" format= $40.,
		stock.stock "Stock On-hand" format= 6.,
		round(stock.stock*.9) "Stock On-hand less 10%" format= 6.,
		reprint.cutoff "Reprint Cutoff" format= 6.

FROM 	bluesky.stock JOIN bluesky.reprint
		ON (stock.stock LE reprint.cutoff 
		OR round(stock.stock*.9) le reprint.cutoff)
		AND stock.reprint = reprint.reprint
order by stock.title;
QUIT;


/* Page 198*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	b.name 'Client' , a.name 'Contact', a.department 'Department'
FROM	bluesky.contacts a, bluesky.contacts b
WHERE	a.company = b.company
		AND b.clientno = b.company
		AND a.clientno <> b.company
ORDER BY b.name;
QUIT;

/* Page 199*/ 
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

PROC SORT data=bluesky.orders;
  by prodcode clientno;

* Use By variable processing of prodcode and clientno in the orders table;
DATA temp ;
  SET bluesky.orders;
  BY prodcode clientno;

  * Delete those records for which there is a single entry ie only one client order;

  if first.prodcode and last.prodcode 
    then delete;

  * If the same client ordered the book delete the record;

  if first.clientno and not last.clientno 
    then delete;

  if last.clientno and not first.clientno
    then delete;

  * Count the number of clients per prodcode;

  if first.prodcode then count=0;
  count+1;

  * Output the last product code record to obtain the highest count;

  if last.prodcode then output;

* Eliminate duplicate product codes;

PROC sort nodupkey data=temp;
  by prodcode;

* Print the results;

PROC print data=temp;
  var prodcode count;
run;

/* Page 201*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'Books ordered by multiple clients';
TITLE2	'With Group by clause';

SELECT	prodcode,  
        count(distinct clientno) as clients "Number of clients"
FROM	bluesky.orders
GROUP BY prodcode
HAVING	clients > 1;
QUIT;

/* Page 201*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'Books ordered by multiple clients';

SELECT	order1.prodcode "Product Code",
		count(distinct order1.clientno)  "Clients"
FROM	bluesky.orders order1,
		bluesky.orders order2
WHERE	order1.prodcode = order2.prodcode
		AND order1.clientno NE order2.clientno
GROUP BY order1.prodcode;
QUIT;

/* Page 203*/ 


PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1  'Books ordered by multiple clients - ON clause';

SELECT	order1.prodcode "Product Code",
		count(distinct order1.clientno)  "Clients"
FROM	bluesky.orders order1 JOIN bluesky.orders order2
		ON order1.prodcode=order2.prodcode
		AND order1.clientno NE order2.clientno
GROUP BY order1.prodcode;

QUIT;

/* Page 205*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1 	'Sales of General Category Books';

SELECT	stock.title "Title" format $40., sum(orders.quantity) "# Sold" format 8.0,
		sum(orders.totsale) "Total Sale" format Dollar10.2

FROM	bluesky.stock INNER join bluesky.orders
		ON stock.prodcode = orders.prodcode

WHERE	stock.category='general'

GROUP BY stock.title;
QUIT;

/* Page 207*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'Sales of General Category Books';

SELECT	stock.title "Title" format= $40., 
		sum(orders.quantity) "# Sold" format= 8.0,
		sum(orders.totsale) "Total Sale" format= Dollar10.2

FROM	bluesky.stock LEFT JOIN bluesky.orders
		ON stock.prodcode = orders.prodcode

WHERE	stock.category='general'
GROUP BY stock.title;
QUIT;

/* Page 208*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'All general and missing book category orders and stock';

SELECT	stock.title "Title" format= $40., 
		sum(orders.quantity) "# Sold" format= 8.0,
		sum(orders.totsale) "Total Sale" format= Dollar10.2

FROM	bluesky.stock RIGHT JOIN bluesky.orders
		ON stock.prodcode = orders.prodcode

WHERE 	stock.category IN ('', 'general')
GROUP BY stock.title;
QUIT;

/* Page 209*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'All general and missing book category orders and stock';

SELECT	stock.title "Title" format= $40., 
		sum(orders.quantity) "# Sold" format= 8.0,
		sum(orders.totsale) "Total Sale" format= Dollar10.2

FROM	bluesky.stock FULL JOIN bluesky.orders
		ON stock.prodcode = orders.prodcode

WHERE 	stock.category IN ('', 'general')
GROUP BY stock.title;
QUIT;

/* Page 212*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1 	'Clients for which there are orders in both order tables';

	SELECT  clientno
	FROM    bluesky.orders
INTERSECT
	SELECT  clientno
	FROM    bluesky.order_2001_2002
UNION
	SELECT	distinct clientno, company
	FROM	bluesky.client;
QUIT;

/* Page 213*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1 	'General category books ordered in 2001-2002 and 2003-2004';

	SELECT	*
	FROM		bluesky.stock
	WHERE		category = 'general'
INTERSECT corr
	SELECT	*
	FROM		bluesky.order_2001_2002
INTERSECT corr
	SELECT	*
	FROM		bluesky.orders;
QUIT;

/* Page 215*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'Client orders in US dollars or Clients located in the USA';
TITLE2	'Between January 1, 2004 and August 30, 2004';

	SELECT	orders.clientno "Client", country "Country",
			CASE(SUBSTR(put(orders.clientno,4.),4,1))
				when '0' then 'Discount = 7%'
				when '1' then 'No discount'
				else 'Discount = 5%'
				end 
	FROM	bluesky.orders, bluesky.address
	WHERE	orders.clientno = address.clientno
			AND currency = 'USD'
			AND ord_date between '01JAN2004'd and '30AUG2004'd
UNION
	SELECT	client.clientno 'Client Number', country 'Cntry',
			CASE(SUBSTR(put(client.clientno,4.),4,1))
				when '0' then 'Discount = 7%'
				when '1' then 'No discount'
				else 'Discount = 5%'
				end LABEL='Client Category'
   FROM		bluesky.client, bluesky.address
   WHERE	client.clientno = address.clientno
        	and country ='USA' ;
QUIT;

/* Page 216*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'Client orders in US dollars or Clients located in the USA';
TITLE2	'Between January 1, 2004 and August 30, 2004';

SELECT	DISTINCT orders.clientno, country, 
	CASE(SUBSTR(put(orders.clientno,4.),4,1))
		when '0' then 'Discount = 7%'
		when '1' then 'No discount'
		else 'Discount = 5%'
		end LABEL='Client Category'
FROM	bluesky.address, bluesky.client, bluesky.orders
WHERE	address.clientno = client.clientno
		and orders.clientno = client.clientno
		AND ((currency = 'USD'
		AND (orders.ord_date between '01JAN2004'd and '30AUG2004'd))
		OR country = 'USA');
QUIT;

/* Page 217*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'Client orders in US dollars or Clients located in the USA';
TITLE2	'Between January 1, 2004 and August 30, 2004';

	SELECT	orders.clientno "Client", country "Country",
			CASE(SUBSTR(put(orders.clientno,4.),4,1))
				when '0' then 'Discount = 7%'
				when '1' then 'No discount'
				else 'Discount = 5%'
				end 
	FROM		bluesky.orders, bluesky.address
	WHERE		orders.clientno = address.clientno
			AND currency = 'USD'
			AND ord_date between '01JAN2004'd and '30AUG2004'd
UNION ALL
	SELECT	client.clientno 'Client Number', country 'Cntry',
			CASE(SUBSTR(put(client.clientno,4.),4,1))
				when '0' then 'Discount = 7%'
				when '1' then 'No discount'
				else 'Discount = 5%'
				end LABEL='Client Category'
   FROM		bluesky.client, bluesky.address
   WHERE	client.clientno = address.clientno
        	and country ='USA' ;
QUIT;

/* Page 219*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'Client orders in US dollars or Clients located in the USA';

	SELECT	orders.clientno "Client", country "Country"
	FROM	bluesky.orders, bluesky.address
	WHERE	orders.clientno=address.clientno
        	and currency = 'USD' 
			and ord_date between '01JAN2004'd and '30AUG2004'd
OUTER UNION
	SELECT	client.clientno "Client Number", country "Cntry"
	FROM	bluesky.client, bluesky.address
	WHERE	client.clientno = address.clientno
        	AND country ='USA' ; 
QUIT;

/* Page 220*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1 'Client orders in US dollars or Clients located in the USA';

        SELECT 	o.clientno as client1 , country as country "Country1"
        FROM 	bluesky.orders o, bluesky.address a
        WHERE 	o.clientno=a.clientno
        		AND currency = 'USD' 
				AND ord_date between '01JAN2004'd and '30AUG2004'd
OUTER UNION CORR
        SELECT 	c.clientno as client "Client2", a.country as country "Country2"
        FROM 	bluesky.client c, bluesky.address a
        WHERE 	c.clientno = a.clientno
        		AND a.country ='USA' ;
QUIT;

/* Page 221*/ 


PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'Client orders in US dollars or Clients located in the USA';

        SELECT	o.clientno as client1 "Client", address.country "Country"
        FROM 	bluesky.orders o, bluesky.address 
        WHERE 	o.clientno=address.clientno
        		and currency = 'USD' 
				and ord_date between '01JAN2004'd and '30AUG2004'd
OUTER UNION CORR
        SELECT 	c.clientno as client2 "Client", address.country "Country"
        FROM 	bluesky.client c, bluesky.address 
        WHERE 	c.clientno = address.clientno
        		and address.country ='USA' ;

QUIT;

/* Page 223*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'Client orders in US dollars';
TITLE2	'For clients located outside of the USA';

	SELECT	orders.clientno as client, country
	FROM	bluesky.orders, bluesky.address
	WHERE	orders.clientno=address.clientno
        	and currency = 'USD' 
			and ord_date between '01JAN2004'd and '30AUG2004'd
EXCEPT
	SELECT	client.clientno as client, country
	FROM	bluesky.client, bluesky.address
	WHERE	client.clientno = address.clientno
			and country ='USA' ;

QUIT;

/* Page 223*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'Client orders in US dollars';

SELECT	orders.clientno as client, country, ord_date, prodcode
FROM	bluesky.orders, bluesky.address
WHERE	orders.clientno=address.clientno
		and currency = 'USD' 
		and ord_date between '01JAN2004'd and '30AUG2004'd;
QUIT;

/* Page 224*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'Clients located in the United States';

SELECT	client.clientno as client, country
FROM	bluesky.client, bluesky.address
WHERE	client.clientno = address.clientno
		and country ='USA' ;
QUIT;

/* Page 225*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

TITLE1	'Clients located in the United States';
TITLE2 	'Who did not use USD or place order between Jan 1 - Aug 30, 2004';


        SELECT	client.clientno as client, country
        FROM	bluesky.client, bluesky.address
        WHERE	client.clientno = address.clientno
        		and country ='USA'
 EXCEPT
        SELECT	orders.clientno as client, country
        FROM	bluesky.orders, bluesky.address
        WHERE	orders.clientno=address.clientno
        		and currency = 'USD' 
			and ord_date between '01JAN2004'd and '30AUG2004'd ;
QUIT;

/* Page 226*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1 	'Client orders in US dollars';
TITLE2 	'For clients located outside of the USA';

	SELECT	orders.clientno as client, country
	FROM	bluesky.orders, bluesky.address
	WHERE	orders.clientno=address.clientno
			and currency = 'USD' 
			and ord_date between '01JAN2004'd and '30AUG2004'd
EXCEPT all
	SELECT	client.clientno as client, country
	FROM	bluesky.client, bluesky.address
	WHERE	client.clientno = address.clientno
			and country ='USA' ;
QUIT;

/* Page 228*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1 	'Client orders in US dollars';
TITLE2 	'From US-based clients';

	SELECT	orders.clientno as client, country
	FROM	bluesky.orders, bluesky.address
	WHERE	orders.clientno=address.clientno
			and currency = 'USD' 
			and ord_date between '01JAN2004'd and '30AUG2004'd
INTERSECT
	SELECT	client.clientno as client, country
	FROM	bluesky.client, bluesky.address
	WHERE	client.clientno = address.clientno
			and country ='USA' ;
QUIT;

/* Page 229*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'Clients in the address and orders tables';

INSERT into bluesky.address
	values (2010, '121 East 61 Street','New York','NY','10022','USA',' ');

	SELECT 	*
	FROM	bluesky.address
INTERSECT CORR
	SELECT 	*
	FROM	bluesky.orders;
QUIT;

/* Page 230*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'Clients in both the address and orders tables';

	SELECT 	*
	FROM	bluesky.address
INTERSECT CORR ALL
	SELECT 	*
	FROM	bluesky.orders;
QUIT;

/* Page 233*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	* 
FROM	(SELECT 'bluesky'||'.'||memname
		FROM 	dictionary.members
		WHERE 	memname like "ORDERS " and memtype = "DATA"
				and libname = 'BLUESKY') ;
QUIT;

/* Page 234*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  invoice,prodcode,ord_date
FROM    bluesky.orders

WHERE   clientno = (SELECT clientno
                    FROM   bluesky.address
                    WHERE  city= 'Paris');
QUIT;

/* Page 234*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT  invoice,prodcode,ord_date
FROM    bluesky.orders
WHERE   clientno = 7008;
QUIT;

/* Page 235*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

/*Step 1:  Calculate the average quantity and total sale values from the existing orders.*/
SELECT	round(avg(quantity)) "Average Order", 
	round (avg(totsale)) "Average Total Sale"
FROM	bluesky.orders;
/*Step 2: Compare all orders against the average values */
SELECT	clientno "Client", invoice "Invoice", ord_date "Order Date" format=date10., 
		quantity "Quantity" format=comma5., totsale "Total Sale" format=dollar12.2
FROM	bluesky.orders
WHERE	quantity GE 538 OR totsale GE 18770;

QUIT;

/* Page 237*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'Order details for above-average sales and quantity';

SELECT	clientno "Client", invoice "Invoice", ord_date "Order Date" format=date10., 
		quantity "Quantity" format=comma5., totsale "Total Sale" format=dollar12.2
FROM	bluesky.orders
WHERE	quantity GE		(SELECT	round(avg(quantity))
						FROM 	bluesky.orders)
		OR totsale GE	(SELECT	round(avg(totsale))
        				FROM 	bluesky.orders);

QUIT;

/* Page 238*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	order1.clientno, order1.invoice,
		order1.ord_date format=date9.,
		order1.quantity format=5.,
		order1.totsale format=dollar10.2
FROM	bluesky.orders order1,
		bluesky.orders order2
WHERE	order1.invoice = order2.invoice
		and order1.prodcode = order2.prodcode
HAVING	order1.quantity >= round(avg(order2.quantity))
		OR order1.quantity >= round(avg(order2.totsale)); 
QUIT;

/* Page 240*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1 'All orders for customers in the USA';

SELECT clientno, ord_date, invoice
FROM   bluesky.orders

WHERE  clientno IN (SELECT clientno
                    FROM bluesky.address
                    WHERE country = 'USA');
QUIT;

/* Page 242*/ 


PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'All orders for customers in the USA';

SELECT	client.company, orders.ord_date, orders.invoice
FROM	bluesky.orders, bluesky.client
WHERE	orders.clientno IN (SELECT clientno
							FROM   bluesky.address
                           	WHERE  country = 'USA')
		AND orders.clientno = client.clientno;
QUIT;

/* Page 243*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'Above-average orders for US Customers';
TITLE2	'Based on average for all customer orders';

SELECT	clientno "Client", invoice "Invoice#",
		ord_date "Date", quantity "Quantity", totsale "Sale Total"
FROM	bluesky.orders ord1
WHERE	quantity GE (SELECT	round(avg(quantity))
					FROM	bluesky.orders ord2)
		AND clientno IN (SELECT	clientno
						FROM	bluesky.address
						WHERE	country = 'USA');
QUIT;

/* Page 245*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'Order details for above-average order size or sale amount' ;
TITLE2	'by Customer';

SELECT	clientno "Client", invoice "Invoice#",
		ord_date "Date" format=date9., quantity "Qty" format=comma8., 
		totsale "Sale Total" format= dollar12.2
FROM	bluesky.orders ord1
WHERE	quantity GE	(SELECT	round(avg(quantity))
         				FROM   bluesky.orders 
         				WHERE  orders.clientno = ord1.clientno )
        OR totsale GE	(SELECT	round(avg(totsale))
         				FROM   bluesky.orders
         				WHERE  orders.clientno = ord1.clientno )
ORDER BY clientno ;
QUIT;

/* Page 248*/ 


PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'Above-average orders for US Customers';
TITLE2	'Based on average for all US customers';

SELECT	clientno "Client", invoice "Invoice#",
		ord_date "Date", quantity "Quantity" format=comma6., 
		totsale "Sale Total" format=dollar10.2
FROM	bluesky.orders ord1
WHERE	quantity GE
		(SELECT round(avg(quantity))
		FROM   bluesky.orders ord2
		WHERE  ord2.clientno IN (SELECT clientno
							  	FROM    bluesky.address
							  	WHERE   country = 'USA'))
		AND clientno IN (SELECT clientno
						FROM bluesky.address
						WHERE country ='USA');
QUIT;

/* Page 250*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	title, isbn, prodcode
FROM	bluesky.stock
WHERE	exists	(SELECT	*
FROM	bluesky.orders
WHERE	totsale le 15000 and quantity > 300);
QUIT;

/* Page 251*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'Books less than $50 that sold more than 100 copies';

SELECT	title, isbn, prodcode
FROM	bluesky.stock
WHERE 	exists	(SELECT	*
         		FROM	bluesky.orders
         		WHERE	totsale le 5000 and quantity > 100
               			and orders.prodcode = stock.prodcode);
QUIT;

/* Page 251*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	title, isbn, prodcode
FROM	bluesky.stock
WHERE	not exists	(SELECT	*
         			FROM	bluesky.orders
        			WHERE	totsale le 15000 and quantity > 100);
QUIT;

/* Page 252*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	title, isbn, prodcode
FROM	bluesky.stock
WHERE	not exists	(SELECT	*
         			FROM	bluesky.orders
         			WHERE	totsale le 15000 and quantity > 100
               				and	stock.prodcode = orders.prodcode);
QUIT;

/* Page 253*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

TITLE1 'Clients who did not order books';
TITLE2 'Between January 1, 2004 and April 30, 2004';

SELECT	client.clientno, address.email
FROM	bluesky.address, bluesky.client
WHERE	not exists	(SELECT *
         			FROM	bluesky.orders
         			WHERE	ord_date between '01JAN2004'D and '30APR2004'D
               				and orders.clientno = client.clientno)
         and address.clientno = client.clientno;
QUIT;

/* Page 255*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

TITLE1	'Currency information';
TITLE2	'for orders of $250,000 or more';
TITLE3	'April 1, 2003 to March 31, 2004';

SELECT	currency "Currency", min(exchrate)  "Min" format=12.2,
		max(exchrate) "Max" format=12.2,avg(exchrate) "Avg" format=12.2
FROM	bluesky.currency c1
GROUP BY currency
HAVING	exists   (SELECT  *
        		  FROM    bluesky.orders
        		  WHERE   orders.currency=c1.currency
						  and ord_date between '01APR2003'd and '31MAR004'd
        		  GROUP BY currency
        		  HAVING   sum(totsale) ge 25000);
QUIT;

/* Page 255*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'Order totals for each currency';

SELECT   currency, sum(totsale) as total format=comma10.2 
FROM     bluesky.orders
WHERE    ord_date between '01APR2003'd and '31MAR004'd
GROUP BY currency;
QUIT;

/* Page 257*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	client.clientno, address.email
FROM	bluesky.address,bluesky.client
WHERE	client.clientno = ANY	(SELECT	clientno
								FROM	bluesky.orders
								WHERE	ord_date between '01JAN2004'D and '30APR2004'D)
		and address.clientno = client.clientno;
QUIT;

/* Page 258*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	client.clientno, address.email
FROM	bluesky.address,	bluesky.client

WHERE	client.clientno NE ANY	(SELECT	clientno
								FROM  	bluesky.orders
								WHERE 	ord_date between '01JAN2004'D and '30APR2004'D)

		AND address.clientno = client.clientno;
QUIT;

/* Page 260*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	clientno, totsale,quantity
FROM	bluesky.orders
WHERE	orders.totsale >= ALL	(SELECT	totsale
								FROM	bluesky.orders);
QUIT;

/* Page 261*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

SELECT	client.clientno, address.email
FROM	bluesky.address,bluesky.client
WHERE	client.clientno ne ALL	(SELECT	clientno
								FROM	bluesky.orders
								WHERE	ord_date between '01JAN2004'D and '30APR2004'D)
         and address.clientno = client.clientno;
QUIT;

/* Page 262*/ 

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1	'Above-average orders by Universities in the United States'; 

SELECT	c.company as university "University" format=$25., 
		count(invoice) "Number of invoices",
		count(prodcode) "Book titles ordered",
		max(quantity) "Maximum Quantity" format=comma8., 
		min(quantity) "Minimum Quantity" format=comma8.,
		max(totsale) as maxsale "Maximum Sale Total" format= dollar10.2,
		min(totsale) "Minimum Sale Total" format=dollar10.2

FROM	bluesky.orders ord1 JOIN bluesky.client c
		ON	ord1.clientno=c.clientno

WHERE	quantity GE
		(SELECT	avg(round(quantity))
		FROM	bluesky.orders ord2
		WHERE	ord2.clientno =ANY (SELECT	clientno
									FROM	bluesky.address
									WHERE   country = 'USA'
                                 INTERSECT
									SELECT	clientno
									FROM	bluesky.client
									WHERE	company like '%University%'
                                 	)
	AND ord2.clientno = ord1.clientno
	)

    AND ord1.clientno IN (SELECT	address.clientno
						FROM		bluesky.address, bluesky.client
						WHERE		country ='USA' 
									and address.clientno=client.clientno 
									and company like '%University%'
	)
GROUP BY university
ORDER BY maxsale;
QUIT;

/************************************************************************************************************/
/* Chapter 6 
/************************************************************************************************************/

/* Page 266*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SUMMARY data=bluesky.orders nway;
  class prodcode;
  var quantity;
  id quantity;;
  output out=bluesky.ord_stat n=qtycnt mean=qtymean sum=qtysum;

PROC sort data=bluesky.stock;
  by prodcode;

DATA BLUESKY.STKORD;
  MERGE bluesky.ord_stat bluesky.stock (in=in1);
  by prodcode;

* include only orders with matching records in the stock table;
if in1;

   if qtycnt > 1 then
       ord_qty=qtysum;
   else
       ord_qty = quantity;

       qtymean = round(qtymean);

        if qtymean ge stock*.75 then
         do;
          if ord_qty ge (stock*.9) then check=90;
            else
          if ord_qty ge (stock*.75) then check = 75;
            else
          if ord_qty ge (stock*.5) then check=50;
            else
          check = 0;
          output;
         end;

PROC PRINT noobs label;
  TITLE1 'Product Stock Check Report';
  var title prodcode stock qtycnt ord_qty qtymean check;
  LABEL title = 'Title'
        prodcode = 'Prodcode'
        stock = 'Stock'
        qtycnt = '# of Orders'
        ord_qty = 'Order size'
        qtymean = 'Avg. Order'
        check = '% of Stock';
run;

/* Page 269*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

CREATE VIEW bluesky.stats AS
   (SELECT 	title 'Title' format=$30., 
			stock.prodcode 'Prodcode', stock 'Stock',
        	round(mean(quantity)) as qtymean 'No. of Orders',
        	sum(quantity) as ord_qty 'Order size',
        	count(quantity) as qtycnt 'Avg. Order',
			CASE when (CALCULATED qtymean ge stock*.75) then
				CASE when (CALCULATED ord_qty GE stock*.9) then 90
					 when (CALCULATED ord_qty GE stock*.75) then 75
               		 when (CALCULATED ord_qty GE stock*.5) then 50
				END
               		ELSE 0 
			END as check '% of Stock'
    FROM 	bluesky.stock, bluesky.orders
    WHERE 	stock.prodcode = orders.prodcode
    GROUP BY stock.prodcode, title, stock
    HAVING   qtymean >= (stock*.75)
    );

SELECT * 
FROM bluesky.stats;
QUIT;

/* Page 271*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

CREATE VIEW bluesky.arts AS
   (SELECT 	title 'Title' format=$25., stock.prodcode 'Prodcode', stock 'Stock',
			quantity 'Order Qty', ord_date 'Order Date'
    FROM 	bluesky.stock, bluesky.orders
    WHERE 	stock.prodcode = orders.prodcode
			and category = 'arts');

SELECT * 
FROM bluesky.arts
ORDER BY title;
QUIT;

/* Page 274*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

CREATE TABLE bluesky.orders (bufsize=8192) (
  	prodCode 	char(6),
  	ord_date 	date,
  	quantity 	num,
  	totsale 	num,
 	currency 	char(3),
 	delCode 	char(3),
 	clientNo 	num, 
	invoice 	char(10));
QUIT;

/* Page 275*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;
TITLE1	'Order information for client 1001';

SELECT	prodCode 'Product Code',
		ord_date 'Order Date' format=DATE10.,
		quantity 'Quantity',
		totsale 'Total Sale' format=dollar10.2,
		currency 'Currency',
		delCode 'Delivery Code',
		clientNo 'Client Number',
		invoice	'Invoice'
FROM 	bluesky.orders
WHERE 	clientno = 1001;

QUIT;

/* Page 276*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

CREATE TABLE bluesky.new_order (
	prodCode	char(6)	label = 'Product Code',
	ord_date	date	label = 'Order Date' format=DATE10.,
	quantity	num		label = 'Quantity',
	totsale		num		label = 'Total Sale' format=dollar10.2,
	currency	char(3)	label = 'Currency',
	delCode		char(3)	label = 'Delivery Code',
	clientNo	num		label = 'Client Number',
	invoice		char(10) label = 'Invoice'
	);

INSERT into bluesky.new_order
  SELECT * from bluesky.orders;

TITLE1	'Order Information for Client 8003'; 
SELECT 	* 
FROM 	bluesky.new_order
WHERE	clientno=8003;
QUIT;

/* Page 278*/

PROC SQL;

CREATE table newreprint                                                                                                              
	(reprint 	char(1) primary key,                                                                                                           
	 cutoff 	 num                                                                                                                             
	);                                                                                                                                      
                                                                                                                                        
CREATE table newstock                                                                                                                
	(isbn		char(13) primary key,                                                                                                            
	title		char(50),                                                                                                                         
	auth_fst	char(10),                                                                                                                      
	auth_lst	char(15),                                                                                                                      
	category	char(20),                                                                                                                      
	reprint		char(1) references work.newreprint                                                                                                
		 		on update cascade on delete set null                                                                                                   
				message="Violates Foreign Key - check reprint value. " msgtype=user,                                                                                    
	stock		num check ((yrpubl > 1990 and stock >=25) 
 						or (yrpubl <= 1990 and  stock >=10)),
	yrpubl		num check(yrpubl > 1900),                                                                                                        
	prodcode	char(6) unique,                                                                                                                
	price		num not null                                                                                                                      
	);
QUIT;

/* Page 282*/

PROC SQL;
describe table newreprint;
describe table newstock;
QUIT;

/* Page 284*/

PROC SQL;

CREATE table ORDERS                                                                                                                     
  (
   PRODCODE char(6),                                                                                                                    
   ORD_DATE num format=DATE. informat=DATE.,                                                                                            
   QUANTITY num,                                                                                                                        
   TOTSALE  num,                                                                                                                         
   CURRENCY char(3),                                                                                                                    
   DELCODE  char(3),                                                                                                                     
   CLIENTNO num,                                                                                                                        
   INVOICE  char(10),                                                                                                                    
                                                                                                                                        
   CONSTRAINT pk_prod_invoice PRIMARY KEY(prodcode,invoice),                                                                            
   CONSTRAINT date_chk CHECK(ord_date> '01JAN2004'D),                                                                                   
   CONSTRAINT qty_null NOT NULL(quantity),                                                                                              
   CONSTRAINT totsale_null NOT NULL(totsale),                                                                                           
   CONSTRAINT clientno_null NOT NULL(clientno)                                                                                          
  );                                                                                                                                      
DESCRIBE table orders;
QUIT;

/* Page 285*/

PROC SQL;

INSERT INTO orders
	VALUES ('500890','21JAN1990'D, 10, 100.00, 'USD', 'UPS', 1001, '000121-01');

QUIT;

/* Page 286*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

CREATE TABLE bluesky.newcomp
  LIKE bluesky.client(DROP=dept phone fax);

QUIT;

/* Page 287*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

CREATE TABLE bluesky.company
AS  (SELECT	c.company, a.address, a.city,
 			a.state, a.zip_post, a.country
	FROM	bluesky.client c, bluesky.address a
	WHERE	c.clientno = a.clientno);

SELECT 	* 
FROM	bluesky.company;
QUIT;

/* Page 288*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

CREATE TABLE bluesky.prodchk
AS (SELECT   s.title, s.prodcode, s.stock,
             mean(o.quantity) as qtymean, count(o.invoice) as salecnt
    FROM     bluesky.orders o,
             bluesky.stock s
    WHERE    o.prodcode = s.prodcode
             and o.quantity >(SELECT   mean(o1.quantity)
                             FROM     bluesky.orders o1
                             WHERE    o1.prodcode=o.prodcode
                             GROUP BY o1.prodcode )
   GROUP BY s.title, s.prodcode, s.stock);
QUIT;

/* Page 290*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;
DESCRIBE table bluesky.prodchk;
 QUIT;
 
/* Page 291*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;
SELECT 	title format=$40., prodcode, stock, qtymean, salecnt 
FROM 	bluesky.prodchk
;
QUIT;

/* Page 291*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

CREATE TABLE bluesky.prodsmry
AS (SELECT   s.title, input(s.prodcode,4.) as code, s.stock,
             mean(o.quantity) as qtymean, count(o.quantity) as qtycnt
    FROM     bluesky.orders o,
             bluesky.stock s
    WHERE    o.prodcode = s.prodcode
   GROUP BY s.title, code, s.stock);

QUIT;

/* Page 294*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

CREATE VIEW bluesky.ordrpt AS
        (SELECT stock.prodcode 'Product Code', stock.title 'Title',
                orders.invoice 'Invoice', orders.ord_date 'Order Date'
         FROM   bluesky.stock, bluesky.orders
         WHERE  ord_date between DATE() and DATE()-30
                AND stock.prodcode=orders.prodcode
        ) 
ORDER BY orders.ord_date;

QUIT;

/* Page 294*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

DESCRIBE view bluesky.ordrpt;
QUIT;

/* Page 295*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;
TITLE1	'Orders placed in the last 30 days';
TITLE2	"Report Date:  &SYSDATE";

SELECT	* 
FROM	bluesky.ordrpt;
QUIT;

/* Page 296*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

CREATE VIEW univrpt as
	(SELECT	clientno "Client", invoice "Invoice#",
			ord_date "Date", quantity "Quantity", 
			totsale "Sale Total" format dollar10.2
	FROM	bluesky.orders ord1

	WHERE	quantity GE
				(SELECT	round(avg(quantity))
				FROM	bluesky.orders ord2
				WHERE	ord2.clientno =ANY
						(SELECT	clientno
						FROM		bluesky.address
						WHERE 	country = 'USA'
					INTERSECT
						SELECT	clientno
						FROM		bluesky.client
						WHERE	company like '%University%'
             			)

						AND ord2.clientno = ord1.clientno
				)

      AND clientno IN 	(SELECT	address.clientno
						FROM	bluesky.address JOIN bluesky.client
						ON		address.clientno = client.clientno
						WHERE	country ='USA'
								AND company like '%University%'
						)
	);

QUIT;

/* Page 297*/

LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

CREATE	view newaddress as
SELECT	* 
FROM 	bluesky.address
USING LIBNAME bluesky "C:\mydata\bluesky bookstore\";
QUIT;

/* Page 298*/

LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

CREATE  view bluesky.allorders as
SELECT  *
FROM  	oralib.orders, bluesky.orders
USING 	libname oralib oracle
  	user = scott password = tiger path= master,
	libname bluesky "C:\mydata\bluesky bookstore\";

QUIT;

/* Page 299*/

LIBNAME bluesky "C:\mydata\bluesky bookstore\";

PROC SQL;
SELECT	* 
FROM	bluesky.emp;
QUIT;

/* Page 300*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

TITLE1	'Comparison of:';
TITLE2	'1.  Total Client to Company sales and quantity ';
TITLE3	"2.  Comparison of Total Client sales and quantity to Client's last 30 days"; 

SELECT 	a.clientno 'Client', 
		sum(b.totsale) as csales 'Client Total Sales' format=comma10.,
		sum(b.totsale)/sum(c.sales) as cosales
		'Percent Company Total sales' format=percent.,
		sum(a.sales30) as csales30 'Client Sales in last 30 days' format=comma10.,
		sum(b.quantity) as cqnty 'Client Total quantity' format=comma10., 
		sum(b.quantity)/sum(c.quantity) as coqnty 'Percent Company Total quantity' format=percent.,
		sum(a.quantity30) as cqnty 'Client Quantity in last 30 days' format=comma10.

FROM	(SELECT	orders.clientno, 
           		sum(orders.totsale) as sales30, sum(orders.quantity)as quantity30
       	FROM   	bluesky.stock, bluesky.orders
       	WHERE  	ord_date between DATE() and DATE()-30
              	AND stock.prodcode=orders.prodcode
	group by orders.clientno
        ) a,

	bluesky.orders b,

	(select	sum(totsale)as sales, sum(quantity) as quantity
	from	bluesky.orders
	) c
		
WHERE	a.clientno = b.clientno
GROUP BY a.clientno;
QUIT;

/* Page 303*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

CREATE	INDEX clientno ON bluesky.client(clientno);
DESCRIBE table bluesky.client;
QUIT;

/* Page 304*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

CREATE	INDEX orderx ON bluesky.orders(ord_date, invoice, clientno);
CREATE 	INDEX clientx ON bluesky.orders(clientno, ord_date,invoice); 
DESCRIBE table bluesky.orders;
QUIT;


/* Page 307*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

CREATE index reprint on bluesky.stock(reprint);
CREATE index category on bluesky.stock(category); 
OPTIONS msglevel=I;
SELECT 	* 
FROM 	bluesky.stock
WHERE 	category in ('arts', 'science') and reprint='A';
QUIT;

/* Page 308*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL _method;

SELECT	clientno "Client", invoice "Invoice#",
		ord_date "Date", quantity "Quantity", 
		totsale "Sale Total" format dollar10.2
FROM	bluesky.orders ord1
WHERE	quantity GE
				(SELECT	(avg(quantity))
				FROM	bluesky.orders ord2
				WHERE	ord2.clientno =ANY
						(SELECT	clientno
						FROM		bluesky.address
						WHERE 	country = 'USA'
					INTERSECT
						SELECT	clientno
						FROM		bluesky.client
						WHERE	company like '%University%'
              						)

						AND ord2.clientno = ord1.clientno
				)
AND clientno IN (SELECT	address.clientno
				FROM	bluesky.address JOIN bluesky.client
				ON		address.clientno = client.clientno
				WHERE	country ='USA'
						AND company like '%University%'
				)
;
QUIT;

/* Page 310*/

LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL _METHOD;

OPTIONS msglevel=I;
CREATE	INDEX ord_date ON bluesky.orders(ord_date);
CREATE 	INDEX clientno ON bluesky.orders(clientno);

SELECT	* 
FROM	bluesky.orders
WHERE  	(ord_date between '01MAY04'D and '30DEC04'D)
		OR clientno in (1001, 2010);
QUIT;

/* Page 311*/

LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL _METHOD;

OPTIONS msglevel=I;
CREATE INDEX ord_date ON bluesky.orders(ord_date);
CREATE INDEX currency ON bluesky.orders(currency);
CREATE INDEX totsale ON bluesky.orders(totsale);

SELECT   ord_date "Order Date", clientno "Client",
         totsale "Total Sale" Format=comma8.2
FROM     bluesky.orders
WHERE    (ord_date between '01MAY04'D and '30DEC04'D)
         AND totsale > 300 and currency = 'USD';

QUIT;

/* Page 312*/

LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;
OPTIONS msglevel=I;

CREATE index category on bluesky.stock(category);

SELECT 	* 
FROM 	bluesky.stock (idxwhere=yes)
WHERE 	category = 'arts';
QUIT;

/* Page 313*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;
OPTIONS msglevel=I;

CREATE 	index category on bluesky.stock(category);
CREATE	index prodcat on bluesky.stock(category, prodcode);

SELECT * 
FROM 	bluesky.stock 
WHERE 	category = 'arts';

SELECT	* 
FROM	bluesky.stock (idxname=catprod)
WHERE	category = 'arts';
QUIT;

/* Page 314*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

SELECT	* 
FROM 	bluesky.orders
WHERE  	ord_date = '06MAY03'D;
QUIT;

/* Page 315*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
OPTIONS msglevel=I;
PROC sql;

CREATE	INDEX ord_date ON bluesky.orders(ord_date);

SELECT 	* 
FROM 	bluesky.orders
WHERE  	ord_date = '06MAY03'D;
QUIT;

/* Page 315*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

CREATE INDEX prodcode ON bluesky.orders(prodcode);

TITLE1 'Orders of product 300456 and 400345';

SELECT  prodcode, ord_date, quantity
FROM    bluesky.orders
WHERE   prodcode in ('300456','400345');
QUIT;

/* Page 317*/

LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;
OPTIONS msglevel=I;

CREATE INDEX prodcode ON bluesky.stock(prodcode);
CREATE INDEX clientno ON bluesky.orders(clientno);

TITLE1 'Above-average Orders by Client';

SELECT  o.prodcode, o.invoice, s.title, s.yrpubl
FROM    bluesky.stock s, bluesky.orders o
WHERE   s.prodcode = o.prodcode
        and o.totsale > (SELECT 	mean(o1.totsale)
                         FROM   	bluesky.orders o1
                         WHERE	o1.clientno=o.clientno
                         GROUP BY 	o1.clientno);
QUIT;

/* Page 318*/

LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;
OPTIONS msglevel=I;

CREATE INDEX prodcode ON bluesky.orders(prodcode);
CREATE INDEX clientno ON bluesky.orders(clientno);

TITLE1	'Above-average Orders by Client';

SELECT	c.company, o.prodcode, o.invoice, s.title, s.yrpubl
FROM	 bluesky.stock s, bluesky.orders o, bluesky.client c
WHERE	o.clientno = c.clientno and s.prodcode = o.prodcode
		AND o.totsale > (SELECT 	mean(o1.totsale)
                         FROM   	bluesky.orders o1
                         WHERE  	o1.clientno=o.clientno
                         GROUP BY o1.clientno);
QUIT;

/* Page 320*/

LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL _method;
OPTIONS msglevel = I;

CREATE INDEX prodcode ON bluesky.stock(prodcode);
CREATE INDEX clientno ON bluesky.client(clientno);

TITLE1 'Orders by Client';

SELECT	c.company, o.prodcode, o.invoice, s.title, s.yrpubl
FROM	bluesky.stock s, bluesky.orders o, bluesky.client c
WHERE	o.clientno = c.clientno 
		AND s.prodcode = o.prodcode;

QUIT;

 /* Page 321*/

LIBNAME bluesky "C:\mydata\bluesky bookstore\";
OPTIONS msglevel=I;
PROC SQL;

CREATE INDEX prodcode ON bluesky.orders(prodcode);
CREATE INDEX category ON bluesky.stock(category);
CREATE INDEX stock ON bluesky.stock(stock);

TITLE1 'Medicine and Science book orders';
TITLE2 'Stock on-hand between 1000 and 2000';

SELECT	prodcode, ord_date, quantity
FROM	bluesky.orders
WHERE	prodcode in (SELECT prodcode
        	     	FROM   	bluesky.stock
        	     	WHERE  	category in ('medicine','science') 
							AND stock between 1000 and 2000);
QUIT;

/* Page 322*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
OPTIONS msglevel=I;
PROC sql;

CREATE INDEX prodcode ON bluesky.orders(prodcode);
CREATE INDEX stock ON bluesky.stock(stock);

TITLE1 'Book stocks below average order quantities';

SELECT  prodcode, title, stock, yrpubl
FROM    bluesky.stock s
WHERE   s.stock < (SELECT mean(o.quantity)
                   FROM   bluesky.orders o
                   WHERE  s.prodcode = o.prodcode ); 

QUIT;

/* Page 323*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

DROP INDEX prodcode ON bluesky.orders;
CREATE INDEX prodcode ON bluesky.stock(prodcode);

TITLE1 'Book stocks below average order quantities';

SELECT  prodcode, title, stock, yrpubl
FROM    bluesky.stock s
WHERE   s.stock < (SELECT mean(o.quantity)
                   FROM   bluesky.orders o
                   WHERE  s.prodcode = o.prodcode );

QUIT;

/* Page 327*/

LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

DESCRIBE table dictionary.indexes;
SELECT 	memname format=$10., memtype, name, idxusage, indxname 
FROM 	dictionary.indexes
WHERE 	libname='BLUESKY';

QUIT;

/* Page 328*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

PROC CONTENTS data=bluesky.orders;
run;

/* Page 330*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

PROC DATASETS library=bluesky;
RUN; 

/* Page 333*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

ALTER TABLE bluesky.orders
  ADD constraint prod_unique UNIQUE(prodcode);
QUIT;

/* Page 333*/
PROC SQL;

CREATE table newstock
	(isbn		char(13) primary key,
	title		char(50),
	auth_fst	char(10),
	auth_lst  	char(15),
	category  	char(20),
	reprint		char(1)	references work.newreprint
				on update cascade on delete set null
				message="Violates Foreign Key - check reprint value. " 
				msgtype=user,
	stock 		num check ((yrpubl > 1990 and stock >=25)
				or (yrpubl <= 1990 and  stock >=10)),
	yrpubl 		num check(yrpubl > 1900),
	prodcode    char(6) unique,
	price       num not null
	);

SELECT 	memname format=$10., memtype, name, idxusage, indxname 
FROM 	dictionary.indexes
WHERE 	memname='NEWSTOCK' and libname='WORK' ;

ALTER table newstock
 DROP constraint _UN0001_;

SELECT 	memname format=$10., memtype, name, idxusage, indxname 
FROM 	dictionary.indexes
WHERE 	memname='NEWSTOCK' and libname='WORK' ;
QUIT;

/* Page 335*/

PROC SQL;

DESCRIBE table currency;

ALTER TABLE currency
  DROP exchrate;

ALTER TABLE currency
  DROP exch_ck;

ALTER TABLE currency
  DROP exchrate;
QUIT;

/* Page 336*/

PROC SQL;

ALTER table newreprint
  DROP constraint _PK0001_;

QUIT;

/* Page 337*/

PROC SQL;

ALTER table newstock
  DROP constraint _FK0001_;

ALTER table newreprint
  DROP constraint _PK0001_;

QUIT;

/* Page 339*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

ALTER table bluesky.reprint
  ADD maximum numeric LABEL = 'MAX';

describe table bluesky.reprint; 
QUIT;

/* Page 339*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

SELECT 	* 
FROM 	bluesky.reprint;

QUIT;

/* Page 341*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

DESCRIBE table bluesky.client;
SELECT clientno, phone
FROM   bluesky.client;
QUIT;

/* Page 342*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

ALTER table bluesky.client
  MODIFY phone char(10);

ALTER table bluesky.client
  MODIFY clientno num(3);

DESCRIBE table bluesky.client;

SELECT clientno, phone
FROM   bluesky.client;

QUIT;

/* Page 344*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

ALTER table bluesky.client
  MODIFY phone char(25);

DESCRIBE table	bluesky.client;
SELECT	clientno, phone 
FROM	bluesky.client;

QUIT;

/* Page 345*/

LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;
OPTIONS msglevel=I;

CREATE 	table bluesky.ord2004 AS
	SELECT 	* 
	FROM	bluesky.orders
	WHERE  	year(ord_date) = 2004;

ALTER table bluesky.ord2004
  DROP	delcode;
QUIT;

/* Page 345*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

CREATE	table bluesky.ord2004 AS
	SELECT 	prodcode, ord_date, quantity, totsale,
       		currency, clientno, invoice
	FROM   	bluesky.orders
	WHERE  	year(ord_date) = 2004;
QUIT;

/* Page 346*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

CREATE INDEX invprod ON bluesky.ord2004(invoice,prodcode);

ALTER table bluesky.ord2004
  DROP 	invoice;

DESCRIBE table bluesky.ord2004;
QUIT;

/* Page 347*/

LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;
CREATE view view2004 AS
	SELECT 	prodcode, ord_date, clientno, totsale, currency
	FROM   	bluesky.orders
	WHERE	year(ord_date)=2004;

ALTER table bluesky.orders
  DROP currency;

describe view view2004;

SELECT 	* 
FROM 	view2004;
QUIT;

/* Page 350*/

PROC SQL; 

CREATE table customer
 	(name 	char(25),
	address char(20),
	city 	char(10),
	phone 	num);

INSERT into customer
	VALUES ('John Smith', '123 West Link Road','Seattle',2068701453)
	VALUES('Jane Doe','999 Garden Boulevard','Miami',8134209143);
QUIT; 

DATA customer;
  Infile cards DLM = ',' DSD;
		Input name : $25.
		Address : $20.
		City : $10.
		phone 
		;
cards;
John Smith, 123 West Link Road, Seattle, 2068701453
Jane Doe, 999 Garden Boulevard, Miami, 8134209143
;
RUN;

/* Page 350*/

PROC SQL;
CREATE table customer
	(name 	char(25),
	address char(20),
	city 	char(10),
	phone 	num);

INSERT into customer
	VALUES ('John Smith','','Seattle',2068701453)
	VALUES('Jane Doe','999 Garden Boulevard','Miami',.);

/* Page 351*/

PROC SQL; 
CREATE table customer
 	(name 	char(25),
	address char(20),
	city 	char(10),
	phone 	num);

INSERT into customer
	SET name='John Smith', city='Seattle', phone=2068701453
	SET name='Jane Doe', address='999 Garden Boulevard', city='Miami';

/* Page 351*/

DATA customer;
	Infile cards DSD DLM =',' MISSOVER;
	Input name : $25.
	Address : $20.
	City : $10.
	phone 
	;
cards;
John Smith, , Seattle, 2068701453
Jane Doe, 999 Garden Boulevard, Miami,
;
RUN;

/* Page 352*/

LIBNAME bluesky "C:\mydata\bluesky bookstore\";

DATA customer;
	Input name= $25.
	Address= $20.
	City= $10.
	phone =
	;
cards;
name=John Smith, city=Seattle phone=2068701453
name=Jane Doe address=999 Garden Boulevard city=Miami
;
RUN;

/* Page 352*/

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

CREATE 	UNIQUE INDEX ordprod on bluesky.orders(ord_date,prodcode,invoice);
CREATE 	INDEX clientno on bluesky.orders(clientno);
CREATE	INDEX ord_date on bluesky.orders(ord_date);

DESCRIBE table bluesky.orders;

INSERT into bluesky.orders 
	VALUES('500890','23Nov2004'D,.,13000,'EUR','',7008,'041123-01');

INSERT into bluesky.orders 
	VALUES('300678','23Nov2004'D,300,7000,'EUR','UPS',7008,'041123-02');

INSERT into bluesky.orders (prodcode, ord_date, invoice)
	VALUES('300678','23Nov2004'D,'041123-02');
QUIT;

/* Page 353*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

SELECT	* 
FROM 	bluesky.orders
WHERE	clientno = 7008;

QUIT;
 
/* Page 354*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL; 

INSERT into bluesky.orders 
	VALUES('500890','23Nov2004'D,.,13000,'EUR','',7008,'041123-01')
	VALUES('300678','23Nov2004'D,300,7000,'EUR','UPS',7008,'041123-02')
	VALUES('300678','23Nov2004'D,'041123-02');

SELECT	*
FROM	bluesky.orders
WHERE	clientno=7008;

/* Page 356*/

PROC SQL;
INSERT INTO newstock
  VALUES ('1-7890-1267-8','Alternative therapies','Brown','Thomas','medicine','H',
	5,1980,'123444',10.0);

QUIT;

/* Page 356*/

PROC SQL;
INSERT INTO stock
  VALUES ('1-7890-7888-1','Alternative therapies','Brown','Thomas','medicine','H',
	10,1980,'123444',10.0);
QUIT;

/* Page 358*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

CREATE	table bluesky.ordsmry
 	(company	char(25) label='Company',
 	ord_date 	date format=DATE9. label='Order Date',
 	contact 	varchar(20) label = 'Contact',
 	totsale	 	num format=dollar10.2 label='Total Sale',
	currency 	char(3) label = 'Currency',
 	exchrate 	num format=10.4 label='Exchange Rate');

INSERT into bluesky.ordsmry
	SELECT 	c.company, o.ord_date,
        	compress(c.cont_fst)||' '||compress(c.cont_lst),
        	o.totsale, o.currency, cn.exchrate
	FROM   	bluesky.client c, bluesky.orders o, bluesky.currency cn
	WHERE  	c.clientno = o.clientno
        	and o.currency = cn.currency
        	and month(cn.cur_date) = month(o.ord_date);

SELECT	*
FROM	bluesky.ordsmry;
QUIT;

/* Page 359*/

PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

CREATE table newreprint                                                                                                              
	(reprint char(1) primary key,                                                                                                           
	 cutoff  num                                                                                                                             
	);                                                                                                                                      
                                                                                                                                        
CREATE table newstock                                                                                                                
	(isbn		char(13) primary key,                                                                                                            
	title		char(50),                                                                                                                         
	auth_fst	char(10),                                                                                                                      
	auth_lst	char(15),                                                                                                                      
	category	char(20),                                                                                                                      
	reprint		char(1) references work.newreprint                                                                                                
		 		on update cascade on delete set null                                                                                                   
				message="Violates Foreign Key - check reprint value. " msgtype=user,                                                                                    
	stock		num check ((yrpubl > 1990 and stock >=25) 
 						or (yrpubl <= 1990 and  stock >=10)),
	yrpubl		num check(yrpubl > 1900),                                                                                                        
	prodcode	char(6) unique,                                                                                                                
	price		num not null                                                                                                                      
	);

/* Insert new rows into the newreprint table*/

INSERT into work.newreprint
	SELECT 	* 
	FROM 	bluesky.reprint;
QUIT; 

/* Page 361*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;
/* The first INSERT statement violates the primary key constraint*/

INSERT into work.newstock
	SELECT 	* 
	FROM 	bluesky.newstock;

/* All of the successful INSERTs are deleted or rolled-back when the error is encountered*/

SELECT	*
FROM	work.newstock;

/* If the offending record is eliminated from the incoming rows, the INSERT is successful*/

INSERT into work.newstock
	SELECT 	* 
	FROM 	bluesky.stock
	WHERE 	isbn ne '1-7890-4578-9';
QUIT;

/* Page 363*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

UPDATE	bluesky.reprint
 	SET maximum = cutoff*1.50;

SELECT	* 
FROM	bluesky.reprint;
QUIT;

/* Page 364*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

UPDATE 	bluesky.client
	SET 	fax='312-861-9871'
	WHERE  	clientno = 2010;

SELECT	clientno, company, phone, fax
FROM	bluesky.client;
QUIT;

/* Page 365*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

ALTER table bluesky.stock
  add reorder num;

ALTER table bluesky.stock
  add reorder num;

UPDATE 	bluesky.stock
	SET reorder = abs(stock-	
					(SELECT	sum(quantity) 
					FROM 	bluesky.orders
                    WHERE	orders.prodcode = stock.prodcode
                    ))
				+ 	(SELECT cutoff 
					FROM bluesky.reprint
				   	WHERE reprint.reprint = stock.reprint
					);

SELECT	title 'Title', prodcode 'Prod Code', stock 'Original Stock', 
		reorder 'To be reordered'
FROM	bluesky.stock
WHERE 	category = 'medicine';
QUIT;

/* Page 366*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

SELECT	s.prodcode, s.stock, sum(o.quantity) 'Orders'
FROM 	bluesky.stock s LEFT JOIN bluesky.orders o
ON 		stock.prodcode = orders.prodcode
WHERE	s.category = 'medicine'
GROUP BY s.prodcode, s.stock;
QUIT;

/* Page 367*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

CREATE table bluesky.reorder AS
	SELECT	* 
	FROM	bluesky.stock;

ALTER table bluesky.reorder
	ADD orders num;

UPDATE bluesky.reorder
 SET orders = 
	CASE
		WHEN 	(SELECT	sum(quantity) 
				FROM	bluesky.orders
				WHERE	orders.prodcode = reorder.prodcode ) ne .
		THEN	(SELECT	sum(quantity) 
				FROM	bluesky.orders
				WHERE	orders.prodcode = reorder.prodcode )
		ELSE 0
	END;
QUIT;

/* Page 367*/
PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
TITLE1 'Books to be reprinted';

SELECT	title 'Title' format=$40., 
		prodcode 'Product Code', stock 'Original Stock',
		orders 'Orders', reprint.cutoff 'Cutoff',
		abs(stock-reprint.cutoff-orders) as rpt_amt 'Reprint Amt'
FROM 	bluesky.reorder, bluesky.reprint
WHERE	reorder.reprint = reprint.reprint
		AND category='medicine'
ORDER BY title;
QUIT;

/* Page 368*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

DELETE FROM bluesky.ord2004;
DESCRIBE table bluesky.ord2004;

SELECT	* 
FROM 	bluesky.ord2004;
QUIT;

/* Page 369*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

CREATE VIEW myview AS
	(SELECT category 
	FROM bluesky.stock);

DELETE 
FROM 	myview;

SELECT 	* 
FROM 	bluesky.stock;

SELECT 	* 
FROM 	myview;

/* Page 372*/

PROC SQL; 
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

CREATE VIEW bluesky.ordrpt as 
	(SELECT	s.prodcode, s.title, o.invoice, o.ord_date
	 FROM	bluesky.orders o JOIN bluesky.stock s
	 ON 	s.procode=o.prodcode
	 WHERE 	ord_date between DATE() and DATE()-356); 

DROP TABLE bluesky.stock;

SELECT 	* 
FROM 	bluesky.ordrpt;

/* Page 373*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

DESCRIBE table bluesky.orders;
QUIT;

/* Page 374*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

DROP INDEX ordprod ON bluesky.orders;
CREATE INDEX prodord ON bluesky.orders(prodcode,ord_date,invoice);

DESCRIBE table bluesky.orders;
QUIT;

/* Page 375*/
PROC SQL; 

CREATE table newreprint                                                                                                              
	(reprint char(1) primary key,                                                                                                           
	 cutoff  num                                                                                                                             
	);                                                                                                                                      
                                                                                                                                        
CREATE table newstock                                                                                                                
	(isbn		char(13) primary key,                                                                                                            
	title		char(50),                                                                                                                         
	auth_fst	char(10),                                                                                                                      
	auth_lst	char(15),                                                                                                                      
	category	char(20),                                                                                                                      
	reprint		char(1) references work.newreprint                                                                                                
		 		on update cascade on delete set null                                                                                                   
				message="Violates Foreign Key - check reprint value. " msgtype=user,                                                                                    
	stock		num check ((yrpubl > 1990 and stock >=25) 
 						or (yrpubl <= 1990 and  stock >=10)),
	yrpubl		num check(yrpubl > 1900),                                                                                                        
	prodcode	char(6) unique,                                                                                                                
	price		num not null                                                                                                                      
	);

/* Page 375*/
PROC SQL;

ALTER table newstock
  DROP constraint _FK0001_;

DROP table newreprint;
DROP table newstock;
QUIT;

/* Page 378*/

LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

* Create a new stock table using the structure and data of an existing table;

CREATE table bluesky.stock_new 
  as (SELECT * from bluesky.stock);

* Add a label and formatting to the title column;

ALTER table  bluesky.stock_new
  modify 	title 'Title' format=$30.;

* Add a primary key to the new table;

ALTER table bluesky.stock_new
  add constraint prodcode_pk primary key (prodcode); 

* Create a new currency table using only the structure of an existing table;

CREATE table bluesky.currency_new
  like bluesky.currency;

* Add a primary key to the new table;

ALTER table bluesky.currency_new 
  add constraint curr_pk primary key(currency);

* Add a labels and formats to columns in the currency table;

ALTER table bluesky.currency_new
  modify exchrate 'Exchange Rate' format=6.4;

ALTER table bluesky.currency_new
  modify cur_date 'Date';

ALTER table bluesky.currency_new
  modify currency 'Currency';

* Add rows to the new table;

INSERT into bluesky.currency_new 
  values('USD','01JUL04'D,1)
  values('EUR','01JUL04'D,0.87561)
  values('SGD','01JUL04'D,1.76712)
  values('AUD','01JUL04'D,1.53064)
  values('CAD','01JUL04'D,1.38795); 

* Create the orders table, adding several constraints;

CREATE table bluesky.orders_new (
  	prodCode 	char(6) 'Product Code',
  	ord_date 	date 'Order Date',
  	quantity 	num 'Order Qty' format=comma8.,
  	totsale 	num 'Total Sale' format=dollar12.2,
 	currency 	char(3) 'Currency',
 	delCode 	char(3) 'Delivery Code',
 	clientNo 	num 'Client No.', 
	invoice 	char(10) 'Invoice No.',
	constraint orders_pk primary key(invoice)
  		message='Violated primary key' msgtype=user,
	constraint sale_nn not null (totsale)
  	  	message='Total sale cannot be null' msgtype=user,
  	constraint qty_nn not null (quantity)
  	  	message='Quantity cannot be null' msgtype=user,
  	constraint date_ck check (ord_date > '01JAN2004'd)
  	  	message='Date must be after January 1, 2004' msgtype=user,
	constraint prodcode_fk foreign key (prodcode) references bluesky.stock_new
	  	on update cascade on delete set null
	  	message='Book product code not in stock table' msgtype=user);

* Add orders to the table;

INSERT into bluesky.orders_new 
  values('100601','23Jul2004'D,590,15487.5,'EUR','EXP',3007,'041223-01')
  values('400102','23Jul2004'D,1500,82500,'AUD','GRN',5005,'041223-02')
  values('400178','23Jul2004'D,10,657.5,'CAD','EXA',6090,'041223-03')
  values('600125','23Jul2004'D,400,13600,'SGD','UPS',7008,'041223-04')
  values('200145','23Jul2004'D,700,39375,'USD','EXE',2010,'041223-05');

* Create a new shipping table with a single column populated with unique values from the 
  orders delivery code column;

CREATE table bluesky.shipping_new
as 	SELECT distinct delCode 
	FROM bluesky.orders_new;

* Alter the shipping table, adding the remaining columns;
 
ALTER table bluesky.shipping_new
	ADD delType 	char(25) 'Delivery';

ALTER table bluesky.shipping_new
	ADD charge 		num  'Cost' format=dollar8.2;

* Add a column modifier to the delCode column;
ALTER table bluesky.shipping_new
	MODIFY delCode 'Delivery Code';
	

* Add additional details to the shipping table;
UPDATE bluesky.shipping_new
set delType = 
	CASE delcode
		WHEN 'EXE' then '2 day Express shipping'
		WHEN 'UPS' then 'US postal service'
		WHEN 'EXP' then 'express mail'
		WHEN 'EXA' then 'express air delivery' 
		WHEN 'GRN' then 'ground delivery'
	END;

UPDATE bluesky.shipping_new
set charge = 10 
where delcode in ('UPS','GRN','EXP');

UPDATE bluesky.shipping_new
set charge = 15
where delcode in ('EXE','EXA');
	
* Add a primary key to the shipping table;

ALTER table bluesky.shipping_new
  add constraint delcode_pk primary key (delcode); 

* Alter the orders table to add another foreign key constraint, linking the 
orders and shipping tables;

ALTER table bluesky.orders_new
  add constraint del_fk foreign key (delcode) references bluesky.shipping_new 
  on update cascade on delete set null
  message='Delivery code not in shipping table' msgtype=user;

* Add indexes to the order date column, often used in WHERE clauses;

CREATE index ord_date on bluesky.orders_new(ord_date);

* Create a view joining the tables 
- description of delivery code is reported rather than code
- exchange rate is obtained from the currency table;

CREATE view NewOrders as
(SELECT	n.title, o.ord_date, o.quantity, 
		o.totsale, o.currency, c.exchRate,
		s.delType
FROM 	bluesky.orders_new o, bluesky.stock_new n,
		bluesky.shipping_new s, bluesky.currency_new c
WHERE	o.prodcode = n.prodcode 
		and o.delcode = s.delcode
		and month(o.ord_date) = month(c.cur_date)
		and o.currency = c.currency
); 

TITLE1 'Current Orders';

SELECT 	* 
FROM 	neworders
ORDER BY title;

* Modify the shipping table, deleting the ground shipping option;

DELETE from bluesky.shipping_new
  where delCode= 'GRN';

* Modify the shipping table, updating one of the codes; 

UPDATE bluesky.shipping_new
  set delCode='EX2' 
  where delCode='EXE';

* Modify the currency table, updating an exchange rate;

UPDATE bluesky.currency_new
  set exchrate= 1.35178
  where currency = 'CAD' and cur_date='01JUL04'D;
  
* Change the title of the Space Science book';
 
 UPDATE bluesky.stock_new
  set title= 'The Science of Outer Space'
  where title ='Space Sciences';

* Foreign key relationship between the shipping_new and orders_new tables causes the INSERT statement fails because delivery code is not in shipping table;

INSERT into bluesky.orders_new
  values('500890','25Jul2004'D,250,8125.00,'EUR','GRN',3007,'040725-01');

* INSERT statement shipping value of GRN changed to EXE.  Order is successfully entered into the orders_new table;

INSERT into bluesky.orders_new
  values('500890','25Jul2004'D,250,8125.00,'EUR','EX2',3007,'040725-01');

TITLE1 'New Orders Table';

SELECT	* 
FROM	bluesky.orders_new;

* View reflects all changes.  It does not need to be reCREATEd;

TITLE1 'Current Orders - updated';

SELECT	* 
FROM neworders
ORDER BY title;

* Drop the foreign key constraints so the tables can be DROPped;

ALTER table bluesky.orders_new 
  DROP constraint del_fk;

ALTER table bluesky.orders_new 
  DROP constraint prodcode_fk;

* Drop the tables ;

DROP table bluesky.stock_new;
DROP table bluesky.shipping_new;
DROP table bluesky.orders_new;
DROP table bluesky.currency_new;
QUIT;

/************************************************************************************************************/
/* Chapter 7 
/************************************************************************************************************/

/* Page 386 */
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

VALIDATE
SELECT 	*
FROM	bluesky.orders
WHERE	totsale between 50 and 1000;
QUIT;

/* Page 387 */
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

SELECT  sum(totsale), sum(quantity) ,
        mean(totsale/quantity) format= 6.2
INTO    :bksum, :bkamt, :bkprice
FROM   	bluesky.orders
WHERE   ord_date between '01MAR2004'd and '30APR2004'd;

%put Total sales =  &bksum; 
%put Total quantity =  &bkamt;
%put Price per book =  &bkprice;
QUIT;

/* Page 388 */
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

SELECT  totsale, quantity ,
        totsale/quantity as priceper format= 6.2
INTO    :bksum, :bkamt, :bkprice
FROM    bluesky.orders
WHERE   ord_date between '01MAR2004'd and '30APR2004'd;

%put Total sales =  %trim(&bksum) ;
%put Total quantity =  %trim(&bkamt);
%put Price per book =  %trim(&bkprice);
QUIT;

/* Page 390 */
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

SELECT  clientno, totsale "Total sales" , quantity "Total quantity",
        totsale/quantity "Price per book" format= 6.2
INTO    :client1- :client6, :bksum1 - :bksum6,
        :bkamt1 through :bkamt6, :bkpr1 thru :bkpr6
FROM    bluesky.orders
WHERE   ord_date between '01MAR2004'd and '30APR2004'd;

%put Clients = &client1, &client2, &client3, &client4, &client5, &client6;
*/ not included in the example*/
*%put Book sales = &bksum1, &bksum2, &bksum3, &bksum4,&bksum5,&bksum6;
*%put Book quantities = &bkamt1, &bkamt2, &bkamt3, &bkamt4,&bkamt5,&bkamt6;
*%put Price per book = &bkpr1, &bkpr2, &bkpr3, &bkpr4,&bkpr5,&bkpr6;


QUIT;

/* Page 392 */
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

TITLE1 	"Sales information for March 1 to April 30, 2004";
SELECT  clientno, totsale "Total sales"
INTO    :client separated by ',',
        :bksum separated by ','
FROM    bluesky.orders
WHERE   ord_date between '01MAR2004'd and '30APR2004'd;

 %put Client =  &client;
 %put Sales = &bksum;
QUIT;

/* Page 394 */
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL noprint;

SELECT  sum(totsale), sum(quantity) ,
        mean(totsale/quantity) 
INTO    :bksum, :bkamt, :bkprice
FROM    bluesky.orders
WHERE   ord_date between '01APR2004'd and '30MAY2004'd;

%macro orderck;
        %if &bkprice > 25.00 %then %do;
		PROC SQL;
		TITLE1 	"Average price per book > $25 for the period";
               SELECT 	ord_date, clientno, prodcode,
						totsale format=comma10.,
						quantity format=comma6.
                FROM 	bluesky.orders
                WHERE 	ord_date between '01APR2004'd and '30MAY2004'd;
               %end;
        %if &bksum < 10000 %then %do;
		PROC SQL;
               TITLE1	"Total sales < $10,000 for the period";
               SELECT	clientno, prodcode, 
						totsale format=comma10.
               FROM		bluesky.orders
               WHERE 	ord_date between '01APR2004'd and '30MAY2004'd;
               %end;
        %if &bkamt > 3000 %then %do;
		PROC SQL;
		TITLE1 "Total quantity sold > 3000 for the period";
               SELECT	clientno, prodcode,
						quantity format=comma6.
               FROM 	bluesky.orders
               WHERE ord_date between '01APR2004'd and '30MAY2004'd;
               %end;
%mend orderck;
%orderck;
%put _LOCAL_;
%put _GLOBAL_;
QUIT;

/* Page 397 */

LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

SELECT  clientno, totsale "Total sales" , quantity "Total quantity",
        totsale/quantity "Price per book" format= 6.2
INTO    :client1- :client10, :bksum1 - :bksum10,
        :bkamt1 through :bkamt10, :bkpr1 thru :bkpr10
FROM    bluesky.orders
WHERE   ord_date between '01APR2004'd and '30MAY2004'd;

%macro printck;
   %do i=1 %to 10;
         %if &&bksum&i > 10000 %then %do;
                TITLE1 "Client report: Sales < $10,000 for the period";
                %put Client =   &&client&i  Sales = &&bksum&i;
           %end;
   %end;
%mend printck;
%printck;
QUIT;

/* Page 398 */
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

SELECT  clientno, totsale "Total sales" , quantity "Total quantity",
        totsale/quantity "Price per book" 
 INTO   :client1- :client20, :bksum1 - :bksum20,
        :bkamt1 through :bkamt20, :bkpr1 thru :bkpr20
 FROM   bluesky.orders
 WHERE  ord_date between '01MAR2004'd and '30MAY2004'd;
%macro printck;
    %do i=1 %to 20;
       %put Client =   &&client&i;
    %end;
 %mend printck;
 %printck;

QUIT;

/* Page 400 */
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

SELECT	clientno, totsale "Total sales" , quantity "Total quantity",
        totsale/quantity "Price per book"  
INTO	:client1- :client50, :bksum1 - :bksum50,
         :bkamt1 through :bkamt50, :bkpr1 thru :bkpr50
FROM	bluesky.orders
WHERE	ord_date between '01MAR2004'd and '30MAY2004'd;

  %macro printck;
     %do i=1 %to 50;
         %if &&bksum&i > 10000 %then %do;
            title1 "Client report -  < $10,000 for the period";
            %put Client =   &&client&i  Sales = &&bksum&i;
          %end;
     %end;
  %mend printck;
  %printck;
QUIT;

/* Page 401 */
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

SELECT  count(clientno)
INTO    :numrow
FROM    bluesky.orders
WHERE   ord_date between '01MAR2004'd and '30MAY2004'd;


SELECT  clientno, totsale "Total sales" , quantity "Total quantity",
        totsale/quantity "Price per book" 
INTO    :client1- :client50, :bksum1 - :bksum50,
        :bkamt1 through :bkamt50, :bkpr1 thru :bkpr50
FROM    bluesky.orders
WHERE   ord_date between '01MAR2004'd and '30MAY2004'd;

 %macro printck;
   %do i=1 %to &&numrow;
         %if &&bksum&i > 10000 %then %do;
                title1 "Client report -  < $10,000 for the period";
                %put Client =   &&client&i  Sales = &&bksum&i;
           %end;

   %end;
%mend printck;
%printck;
QUIT;

/* Page 402 */
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

SELECT	count(prodcode)
INTO 	:numrow
FROM 	bluesky.stock;
%put The number of rows in the Stock table =&numrow;
QUIT;

/* Page 402 */
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

SELECT	 title
INTO 	:title1 - :title&numrow; 
QUIT;

/* Page 403 */
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

SELECT 	count(prodcode)
INTO 	:numrow
FROM 	bluesky.stock;

%put The number of rows in the Stock table =&numrow;

SELECT 	title
INTO 	:title1 - :title%SYSEVALF(&numrow,integer)
FROM	bluesky.stock;
QUIT;

/* Page 404 */
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

%LET numrow=%left(&&numrow); 
SELECT 	title
INTO 	:title1 - :title&numrow
FROM	bluesky.stock;
QUIT;

/* Page 405 */
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

SELECT 	category, count(s.category), sum(s.stock),
 		sum(o.totsale), sum(o.quantity)
INTO 	:cat1 - :cat&sqlobs, :cnt1 - :cnt&sqlobs, :stk1 - :stk&sqlobs,
     	:sale1 - :sale&sqlobs, :qnty1 - :qnty&sqlobs
FROM 	bluesky.stock s, bluesky.orders o
WHERE 	s.prodcode = o.prodcode
GROUP BY category;

%macro bookcat;
%let space= *****;
%do i=1 %to &sqlobs;
 %put Category &i=  &&cat&i,
 Number of books = &&cnt&i ,
 Total stock = &&stk&i;
 %put  &space Total sales = $ &&sale&i
  &space Total quantity sold = &&qnty&i;
 %put;
%end;
%mend;

%bookcat
QUIT;

/* Page 406 */
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

SELECT 	count(category)
FROM 	bluesky.stock s, bluesky.orders o
WHERE 	s.prodcode = o.prodcode
GROUP BY category;

SELECT 	category, count(s.category), sum(s.stock),
 		sum(o.totsale), sum(o.quantity)
INTO 	:cat1 - :cat&sqlobs, :cnt1 - :cnt&sqlobs, :stk1 - :stk&sqlobs,
     	:sale1 - :sale&sqlobs, :qnty1 - :qnty&sqlobs
FROM 	bluesky.stock s, bluesky.orders o
WHERE 	s.prodcode = o.prodcode
GROUP BY category;

%macro bookcat;
%let space= *****;
%do i=1 %to &sqlobs;
 %put Category &i=  &&cat&i,
 Number of books = &&cnt&i ,
 Total stock = &&stk&i;
 %put  &space Total sales = $ &&sale&i
  &space Total quantity sold = &&qnty&i;
 %put;
%end;
%mend;

%bookcat
QUIT;

/* Page 408 */
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

VALIDATE
SELECT 	*
FROM 	bluesky.orders
WHERE 	prodcode = (SELECT 	prodcode
					FROM 	bluesky.stock
					WHERE 	yrpubl = 2002);

SELECT 	*
FROM 	bluesky.orders
WHERE 	prodcode = (SELECT prodcode
					FROM 	bluesky.stock
					WHERE yrpubl = 2002);
QUIT;

/* Page 409 */
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

SELECT	count(invoice) 
FROM	bluesky.orders;

%put Number of loops = &sqloops;
QUIT;

/* Page 409*/
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

SELECT	nobs
INTO 	:rownum
FROM 	dictionary.tables
WHERE	memname = 'STOCK' and libname = 'BLUESKY';

PROC SQL loops = &rownum;
SELECT	*
FROM 	bluesky.stock,
		bluesky.orders;
QUIT;

/* Page 410 */
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL loops = %EVAL(&rownum*10);

SELECT	*
FROM 	bluesky.stock,
		bluesky.orders;
QUIT;

/* Page 410 */
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL loops = 500;

SELECT 	category, count(s.category)
FROM	bluesky.stock s, bluesky.orders o
WHERE 	s.prodcode = o.prodcode
GROUP BY category;

SELECT 	category, count(s.category), sum(s.stock),
 		sum(o.totsale), sum(o.quantity)
INTO 	:cat1 - :cat&sqlobs, :cnt1 - :cnt&sqlobs, :stk1 - :stk&sqlobs,
     	:sale1 - :sale&sqlobs, :qnty1 - :qnty&sqlobs
FROM 	bluesky.stock s, bluesky.orders o
WHERE 	s.prodcode = o.prodcode
GROUP BY category;

%macro bookcat;
%let space= *****;
%do i = 1 %to &sqlobs;
  %if &sqlobs < loops %then
    %do;
       %put Category &i=  &&cat&i,
       Number of books = &&cnt&i ,
       Total stock = &&stk&i;
       %put  &space Total sales = $ &&sale&i
        &space Total quantity sold = &&qnty&i;
       %put;
    %end;
 %end;
%mend;
QUIT;

/*************************************************************************************************/
/* SCL programs in Chapter 7                                                                     */
/* SAS FRAME must be invoked to run these programs with suitable control objects.                */
/* PROC SQL statement is not required.                                                           */
/*************************************************************************************************/

/* Page 412 */
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

dcl Char(20) newname;                                                                                                                   
                                                                                                                                        
init:                                                                                                                                   
norec = 10;                                                                                                                             
model="BLUESKY.ORDERS";                                                                                                                 
return;                                                                                                                                 
                                                                                                                                        
MAIN:                                                                                                                                   
newname=dsn.text ;                                                                                                                      
if (exist('bluesky.'||newname)) then                                                                                                    
     message.text = 'Table  ' ||newname||'  already exists.';                                                                           
else                                                                                                                                    
do;                                                                                                                                     
     call new('bluesky.'||newname,model,norec,'N');                                                                                     
    message.text='Table  '||newname||'  has been CREATEd.';                                                                             
end;                                                                                                                                    
return;                                                                                                                                 
TERM:                                                                                                                                   
return;           

/* Page 415 */ 

init:                                                                                                                                   
                                                                                                                                        
submit continue sql;                                                                                                                    
                                                                                                                                        
DROP TABLE bluesky.TABLIST;                                                                                                             
                                                                                                                                        
CREATE TABLE bluesky.TABLIST                                                                                                            
as                                                                                                                                      
select title                                                                                                                            
  from BLUESKY.STOCK;                                                                                                                   
                                                                                                                                        
endsubmit;                                                                                                                              
                                                                                                                                        
MAIN:                                                                                                                                   
titles = open('bluesky.TABLIST','I');                                                                                                   
 if titles >0 then                                                                                                                      
do;                                                                                                                                     
                                                                                                                                        
 nv = attrn(titles,'nobs');                                                                                                             
 namenum=varnum(titles,'title');                                                                                                        
                                                                                                                                        
 tablist=makelist();                                                                                                                    
                                                                                                                                        
 do i = 1 to nv;                                                                                                                        
                                                                                                                                        
   var = fetchobs(titles,i);                                                                                                            
   tabname = getvarc(titles,namenum);                                                                                                   
   rc = INSERTc(tablist,tabname,i);                                                                                                     
                                                                                                                                        
  end;                                                                                                                                  
                                                                                                                                        
  TABLES.items=tablist;                                                                                                                 
  rc = close(titles);                                                                                                                   
end;                                                                                                                                    
                                                                                                                                        
else                                                                                                                                    
 _msg_ = sysmsg();                                                                                                                      
return;                                                                                                                                 
                                                                                                                                        
term:                                                                                                                                   
return;                                                                                                                                 

/* Page 417 */ 

dcl Char(20) colname;                                                                                                                   
                                                                                                                                        
COL:                                                                                                                                    
colname = col.text;                                                                                                                     
submit continue sql;                                                                                                                    
                                                                                                                                        
DROP TABLE bluesky.colvalue;                                                                                                            
                                                                                                                                        
CREATE table bluesky.colvalue                                                                                                           
as                                                                                                                                      
select &colname                                                                                                                         
  from BLUESKY.STOCK;                                                                                                                   
                                                                                                                                        
endsubmit;                                                                                                                              
RETURN;                                                                                                                                 
                                                                                                                                        
MAIN:                                                                                                                                   
                                                                                                                                        
datasets = open('bluesky.COLVALUE','I');                                                                                                
 if datasets >0 then                                                                                                                    
do;                                                                                                                                     
                                                                                                                                        
 nv = attrn(datasets,'NOBS');                                                                                                           
                                                                                                                                        
 colvalue=makelist();                                                                                                                   
                                                                                                                                        
 do i = 1 to nv;                                                                                                                        
                                                                                                                                        
   var = fetchobs(datasets,i);                                                                                                          
   tabname = getvarc(datasets,1);                                                                                                       
   rc = INSERTc(colvalue,tabname,i);                                                                                                    
                                                                                                                                        
  end;                                                                                                                                  
                                                                                                                                        
  tables.items=colvalue;                                                                                                                
  rc = close(datasets);                                                                                                                 
end;                                                                                                                                    
                                                                                                                                        
else                                                                                                                                    
 _msg_ = sysmsg();                                                                                                                      
return;                                                                                                                                 
TERM:                                                                                                                                   
return;                                                                                                                                 
             

/*******************************************************************************************************/
/* htmSQL programs in Chapter 7.                                                                       */
/* Require a PROC SERVER statement to set up the environment. An example is provided, however this may */
/* differ at your site.                                                                                */
/*******************************************************************************************************/

/* Page 417*/
/*****************************************************************************************/
/* Sample statements to set up environment to run the htmSQL programs shown here.        */ 
/* These statements may be issued in a separate SAS session window from the one running  */
/* the htmSQL programs if the intent is to use a single computer rather than a true      */
/* client/server configuration. The server id is referenced in the htmSQL program below. */
/*****************************************************************************************/

OPTIONS comamid=tcp;
LIBNAME bluesky "c:\sasweb\IntrNet8\htmsql\bluesky";

PROC SERVER id=shr1 authenticate=optional;
RUN;

/* To run a htmSQL program from the command line, use the following statement in a DOS window 
     htmsql <filename.hsql> "<input parameters>" 
/* The statement assumes that you are in the directory in which the hsql program is stored */ 

/* Here's an example using the add.hsql program on page 429: 
htmsql add.hsql "title=The Age of Reason&auth_fst=Bill&auth_lst=Newman&isbn=1-7890-1162-2&yrpubl=2003&prodcode=300982&stock=100&price=10.50&category=arts&reprint=A" >add.html
*/


/* Page 421 */ 

{*----------------------------------------------------------------------------*}
{* File name:    LISTS.HSQL                                                   *}
{* Description : This htmSQL input file lists the book titles                 *}
{*----------------------------------------------------------------------------*}

<html>

<head>
  <title>Bluesky Publishing Titles</title>
</head>

<body bgcolor="white">
<center>

<h1>Bluesky Book Titles
</h1>

{*----------------------------------------------------------------------------*}
{* start the query section                                                    *}
{* connect to the server and use a query to select the entries in the stock   *}
{* table                                                                      *}
{*----------------------------------------------------------------------------*}

/******************************************************************************************/
/* The server id shown in the next statementis assigned in a PROC SERVER statement.       */
/* The "susieq" prefix is the name of the computer acting as the server. There is no need */
/* for this computer to be different from the one running the htmSQL statements; however a*/
/* separate SAS session should be started.                                                */
/******************************************************************************************/
{query server="susieq.shr1"}

  {sql} 
    SELECT isbn, title, auth_fst, auth_lst, 
           category, stock, yrpubl, prodcode, price format=6.2 
    FROM   bluesky.stock
  {/sql}
 
{*----------------------------------------------------------------------------*}
{* Set up a norows section which executes if the query does not retrieve any  *}
{* rows                                                                       *}
{*----------------------------------------------------------------------------*}

  {norows}
    There are no entries in the Bluesky Publishing Stock table. 
	<p>Click the <b>New Entry</b> button to enter a book. 
    <p>
    <table>
      <tr>
        <td><form action="enter.html" method="post">
            <input type="submit" value="New Entry"></form></td>
      </tr>
    </table>
  {/norows}

{*----------------------------------------------------------------------------*}
{* Create a table and add column headings                                     *}
{*----------------------------------------------------------------------------*}
  <table border="5">
    <tr>
      <th> ISBN</th>
      <th> Title</th>
      <th> Author </th>
      <th> Category </th>
      <th> Stocked </th>
      <th> Publ. </th>
      <th> Product Code </th>
      <th> Price </th>
    </tr>

{*----------------------------------------------------------------------------*}
{* Set up an eachrows section.                                                *}  
{* Get the query results one row at a time and place into table               *}
{*----------------------------------------------------------------------------*}

    {eachrow}
      <tr>
        <td>{&isbn} </td>
        <td>{&title}</td>
        <td>{&auth_fst} {&auth_lst}</td>
        <td>{&category}</td>
        <td align=right>{&stock}</td>
        <td>{&yrpubl}</td>
        <td>{&prodcode}</td>
        <td align=right>{&price}</td>
        
      </tr>
    {/eachrow}
  </table>
  <p>
 
{*----------------------------------------------------------------------------*}
{* End the query section                                                      *}
{*----------------------------------------------------------------------------*}

{/query}

</center>
</body>
</html>
 

/* Page 426 */ 

{*----------------------------------------------------------------------------*}
{* File name:    ADD.HSQL                                                     *}
{* Description:  This htmSQL input file adds a new book in the stock table    *}
{*               from information entered into the webpage generated from     *}
{*               enter.hsql                                                   *}
{*----------------------------------------------------------------------------*}

<html>

<head>
  <title>Bluesky Publishing Company</title>
</head>

<body bgcolor="white">

<h1>Add Stock</h1>

<p>
{*---------------------------------------------------------------------------*}
{* start the update section                                                  *}
{* connect to the server and use an INSERT statement to add a new book to    *}
{* the stock table                                                           *}
{*---------------------------------------------------------------------------*}

/*******************************************************************************************/
/* The server id shown in the next statement is assigned in a PROC SERVER statement.       */
/* The "susieq" prefix is the name of the computer acting as the server. The number that   */
/* follows is the port through which communication is established. Refer to the shrcgi.cfg */
/* file in the sasweb directory for details. There is no need for this computer to be      */
/* different from the one running the htmSQL statements; however a separate SAS session    */
/* should be started.                                                                      */
/*******************************************************************************************/

{update server="susieq:5010"}

    {sql} INSERT into bluesky.stock
           set 	isbn="{&isbn}",
                title="{&title}",
                auth_fst="{&auth_fst}",
				auth_lst="{&auth_lst}",
                category="{&category}",
				reprint="{&reprint}",
                stock={&stock},
                yrpubl={&yrPubl},
				prodcode="{&prodcode}",
				price={&price}
                  
    {/sql}

{*---------------------------------------------------------------------------*}
{* set up an error section which executes if the INSERT statement fails      *}
{*---------------------------------------------------------------------------*}

    {error}
        <b>Add failed. 
		</b>
    {/error}

{*---------------------------------------------------------------------------*}
{* set up a success section which executes if the INSERT statement succeeds  *}
{*---------------------------------------------------------------------------*}

    {success}
        <b>Entry added for "{&title}"
		</b>.
    {/success}

{/update}
{*---------------------------------------------------------------------------*}
{* end the update section                                                    *}
{*---------------------------------------------------------------------------*}

</body>
</html>

/* Page 429 */ 

{*----------------------------------------------------------------------------*}
{* File name:   ENTER.HSQL                                                    *}
{* Description: this htmSQL input file collects the information required to   *} 
{*              add a new book to the stock table.  The information here is   *}
{*              passed to the add.hsql file for processing.                   *}
{*----------------------------------------------------------------------------*}

<html>

<head>
  <title>Bluesky Publishing Company</title>
  <script language="JavaScript" type="text/javascript" src="/lib/global.js"></script>
</head>

<body bgcolor="white">

{*----------------------------------------------------------------------------*}
{* If the ADD button is pressed, the add.hsql file will be processed using    *}
{* the values entered in the form.                                             *}
{*----------------------------------------------------------------------------*}

<h1>Add new stock</h1>
<p>
<p>

<form action="add.hsql" method="post">

{*----------------------------------------------------------------------------*}
{* Start a query section                                                      *}
{*----------------------------------------------------------------------------*}

/*******************************************************************************************/
/* The server id shown in the next statement is assigned in a PROC SERVER statement.       */
/* The "susieq" prefix is the name of the computer acting as the server. The number that   */
/* follows is the port through which communication is established. Refer to the shrcgi.cfg */
/* file in the sasweb directory for details. There is no need for this computer to be      */
/* different from the one running the htmSQL statements; however a separate SAS session    */
/* should be started.                                                                      */
/*******************************************************************************************/
{query server="susieq:5010"}

<p>
<left>

<table border="5">

<tr align="left">
	<th> Enter New Title</th>
</tr>

<td align "left">

<input name="title" size="80" value="">
</td>  
 
{*----------------------------------------------------------------------------*}
{* use a query to select all current titles in the stock table and add them   *}
{* to the DROP down list for viewing                                          *}
{*----------------------------------------------------------------------------*}

<td align "left">

{sql} 
		   
   SELECT	distinct title  as sel
   FROM 	bluesky.stock
{/sql}
      
<select name="titles" size="1">
	<option value="" size="100" selected>-       Current Titles       -
	{eachrow}
      <option>{&sel}
	  {/eachrow}                
</select> <br><p>
</td> 
</table>

<p>
<p>
<p>

{*----------------------------------------------------------------------------*}
{* Create a table for the author names and apply headings                     *}
{*----------------------------------------------------------------------------*}
<table border="5">

<!-- column headings -->

<tr align="left">
    <th>Author First Name</th>
	<th>Author Last Name</th>
     </tr>


<td align "left">
	<input name="auth_fst" size="40" value="">
</td>

<td align "left">
	<input name="auth_lst" size="40" value="">
</td>
        
{*----------------------------------------------------------------------------*}
{* use a query to select all current authors in the stock table and add them  *}
{* to the DROP down list for viewing                                          *}
{*----------------------------------------------------------------------------*}

<td align "left">

{sql} 
  SELECT 	distinct (auth_lst||', '||auth_fst) as sel
  FROM 		bluesky.stock
  ORDER BY 	auth_lst, auth_fst
{/sql}
     
    <select name="authors" size="1">
 	  <option value="" size="40" selected>- Current Authors -
      {eachrow}
        <option >{&sel}
	  {/eachrow}
	</select> <br><p>

</td>
</table>

{*----------------------------------------------------------------------------*}
{* Create a table for the ISBN & Publication year.  Apply a heading to each.  *}
{*----------------------------------------------------------------------------*}
<p>
<p>
<p>
<p>

<table border="5">
  
<!-- column headings -->

<tr align="left">
	<th>ISBN</th>
	<th> YrPubl</th>
</tr>

<tr>
	<td align "left">
		<input name="isbn" size="60" value=""><br>
	</td>   

	<td align "right">
		<input name="yrpubl" size="10" value="">
    </td>  
</table>
<p>
<p>
<p>

{*----------------------------------------------------------------------------*}
{* Create a table for the Product Code, Stock Printed, Price, Category        *}
{* and reprint cutoff.  Apply headings to each text box and DROP down box     *}
{*----------------------------------------------------------------------------*}
<table border "5">

<tr align="left">
   <th>Product Code</th>
   <th>Initial Stock Printed</th>
   <th>Price </th>
   <th>Category</th>
   <th>Reprint Cutoff</th>
</tr>

<td align="left">
	<input name="prodcode" size="20" ><br>
</td>    

<td align "left">
	<input name="stock" size="20" ><br>
</td>
        
<td align "right">
	<input name="price" size="20" ><br>
</td>

{*----------------------------------------------------------------------------*}
{* use a query to populate the DROP down category list                        *}
{*----------------------------------------------------------------------------*}

 <td align "left">
   {sql} 
     SELECT 	distinct category as sel
     FROM 		bluesky.stock
     ORDER BY 	category
   {/sql}
   <select name="category" size="1">
     <option value="" selected>- Choose One -

     {eachrow}
       <option >{&sel}
     {/eachrow}
        
   </select> <br><p>
 </td>

{*----------------------------------------------------------------------------*}
{* use a query to populate the DROP down reprint list                         *}
{*----------------------------------------------------------------------------*} 
 <td align "left">
   {sql} 
      SELECT 	reprint as sel
      FROM 		bluesky.reprint
      ORDER BY 	reprint
   {/sql}
      
    <select name="reprint"  size="1">
     <option value="" selected>- Choose One -

     {eachrow}
       <option >{&sel}
     {/eachrow}
        
    </select> <br><p>

 </td>
</tr>
</table>
</center>
<p>

{*----------------------------------------------------------------------------*}
{* CREATE an ADD button which will invoke add.hsql and pass the values        *}
{* entered and selected on this form                                          *}
{*----------------------------------------------------------------------------*} 

 <input type="submit" value="Add"></td>
 <input type="reset"   value="Reset Form">
  
{/query}

</center>
</body>
</html>
QUIT;

/* Page 435 */ 
PROC SQL outobs=10; 

TITLE1 	'Dictionary.Members Sample Listing ';
SELECT 	memname, memtype 
FROM	dictionary.members;
QUIT;

/* Page 438 */ 
PROC SQL;

DESCRIBE table dictionary.members;
QUIT;

/* Page 438 */ 

LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

TITLE1 	'Bluesky library member information - ORDER tables';
SELECT 	memname, memtype, 
		index format=$10.,path format=$30.
FROM 	dictionary.members
WHERE 	libname = 'BLUESKY'
	and memname like '%ORDER%';
QUIT;

/* Page 439 */ 
PROC SQL;

DESCRIBE table dictionary.columns;
QUIT;

/* Page 440 */ 
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

TITLE1 	'Report on Pending Order table columns';
SELECT 	name, type, length, idxusage
FROM 	dictionary.columns
WHERE 	libname = 'BLUESKY' and memname = 'ORDERPEND';
QUIT;

/* Page 441 */ 
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

TITLE1 	'Report on Pending Order table columns';
TITLE2 	'Formats and Labels';
SELECT 	name format=$10., type, format format=$10., informat format=$10., 
		label format=$20.
FROM 	dictionary.columns
WHERE 	libname = 'BLUESKY' and memname = 'ORDERPEND';
QUIT;

/* Page 442 */ 
PROC SQL;

SELECT 	name
INTO 	:collist separated by ','
FROM 	dictionary.columns
WHERE 	libname = 'BLUESKY' and memname = 'ORDERS'
	and type = 'num';
QUIT;

%put List of numberic columns in orders table -  &collist;

/* Page 442 */ 
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

SELECT 	&collist
FROM 	bluesky.orders
WHERE 	ord_date > '01JUL2004'D;
quit;

/* Page 42 */ 
PROC SQL;

DESCRIBE table dictionary.tables;
QUIT;

/* Page 444 */ 
PROC SQL;

SELECT 	memname, nobs, obslen, nvar, delobs
FROM 	dictionary.tables where libname = 'BLUESKY'
		
QUIT;

/* Page 446 */ 
PROC SQL;

DESCRIBE table dictionary.indexes;
QUIT;

/* Page 447 */ 
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

CREATE index ord_date on bluesky.orders(ord_date);
CREATE index clientno on bluesky.orders(clientno);
CREATE unique index ordprod on bluesky.orders(ord_date,prodcode,invoice);

TITLE1 	'Report on Orders Table Indexes';
SELECT 	name format=$15., idxusage, 
		indxname format=$15., indxpos, unique
FROM 	dictionary.indexes
WHERE 	libname = 'BLUESKY' and memname = 'ORDERS';
QUIT;

/* Page 448 */ 

/* CREATE table statements added for convenience. The example in the book does not include
these statements */ 

PROC SQL;
CREATE table newreprint                                                                                                              
	(reprint char(1) primary key,                                                                                                           
	 cutoff 	 num                                                                                                                             
	);   
CREATE table newstock                                                                                                                
	(isbn		char(13) primary key,                                                                                                            
	title		char(50),                                                                                                                         
	auth_fst	char(10),                                                                                                                      
	auth_lst	char(15),                                                                                                                      
	category	char(20),                                                                                                                      
	reprint		char(1) references work.newreprint                                                                                                
		 		on update cascade on delete set null                                                                                                   
				message="Violates Foreign Key - check reprint value. " msgtype=user,                                                                                    
	stock		num check ((yrpubl > 1990 and stock >=25) 
 						or (yrpubl <= 1990 and  stock >=10)),
	yrpubl		num check(yrpubl > 1900),                                                                                                        
	prodcode	char(6) unique,                                                                                                                
	price		num not null                                                                                                                      
	);

SELECT	table_name, column_name, constraint_name
FROM	dictionary.constraint_column_usage
WHERE	table_catalog = 'WORK' and table_name = 'NEWSTOCK';
QUIT;


/* Page 449 */ 

/* Declare the library name variable assigned from the FRAME object*/                                                                   
                                                                                                                                        
DCL Char(20) lib_name;                                                                                                                  
                                                                                                                                        
                                                                                                                                        
/* Initialize the program by creating a table with the necessary                                                                        
data for the list*/                                                                                                                     
                                                                                                                                        
/* Execute labelled section each time the value in the text entry                                                                       
box changes*/                                                                                                                           
                                                                                                                                        
LIBNEW:                                                                                                                                 
                                                                                                                                        
/* Assign the current value of the LIBNEW text box to the lib_name variable*/                                                           
                                                                                                                                        
lib_name = libnew.text;                                                                                                                 
                                                                                                                                        
/* Submit block with SQL statements sent directly                                                                                       
 to SQL processor*/                                                                                                                     
                                                                                                                                        
submit continue SQL STATUS;                                                                                                             
                                                                                                                                        
/* Drop the table if it exists and reCREATE it with the library                                                                         
name from the text entry box.  Use the UPPER function to allow                                                                          
for user entry of upper, lower or mixed case*/                                                                                          
                                                                                                                                        
DROP table bluesky.DATLIST;                                                                                                             
                                                                                                                                        
CREATE table bluesky.DATLIST                                                                                                            
as                                                                                                                                      
	SELECT 	memname                                                                                                                          
  	FROM 	dictionary.members                                                                                                               
  	WHERE	memtype = 'DATA'                                                                                                                
  			and libname = UPPER("&LIB_NAME");                                                                                                     
                                                                                                                                        
endsubmit;                                                                                                                              
                                                                                                                                        
/* Check for a return code which would indicate that the statement                                                                      
is in error*/                                                                                                                           
                                                                                                                                        
if symget ('SQLRC')>4 then                                                                                                              
message.text = 'The SQL statement is not valid';                                                                                        
                                                                                                                                        
 /* Check the number of observations read in the SELECT statement*/                                                                     
                                                                                                                                        
if symget ('SQLOBS') = 0 then                                                                                                           
message.text = 'There are no DATA members in the library';                                                                              
ELSE                                                                                                                                    
message.text = 'There are '||symget('SQLOBS')||                                                                                         
      ' DATA members in the library';                                                                                                   
RETURN;                                                                                                                                 
                                                                                                                                        
/* Execute the MAIN section of the program*/                                                                                            
                                                                                                                                        
MAIN:                                                                                                                                   
                                                                                                                                        
/* Open the table in read-only mode and check that it opens                                                                             
(return code > 0) */                                                                                                                    
                                                                                                                                        
datasets = open('bluesky.DATLIST','I');                                                                                                 
 if datasets >0 then                                                                                                                    
                                                                                                                                        
do;                                                                                                                                     
                                                                                                                                        
/* Obtain attribute information from the table including the                                                                            
number of observations and the variable number for the Member                                                                           
Name column*/                                                                                                                           
                                                                                                                                        
 nv = attrn(datasets,'NOBS');                                                                                                           
 namenum=varnum(datasets,'MEMNAME');                                                                                                    
                                                                                                                                        
/* Create an empty list*/                                                                                                               
                                                                                                                                        
 tablist=makelist();                                                                                                                    
                                                                                                                                        
/* Loop through the observations in the table.  Fetch the current                                                                       
observation, obtain the value of the Member Name column and INSERT                                                                      
it into the list*/                                                                                                                      
                                                                                                                                        
 do i = 1 to nv;                                                                                                                        
                                                                                                                                        
   var = fetchobs(datasets,i);                                                                                                          
   tabname = getvarc(datasets,namenum);                                                                                                 
   rc = INSERTc(tablist,tabname,i);                                                                                                     
                                                                                                                                        
  end;                                                                                                                                  
                                                                                                                                        
/* Associate the displayed list with the items from the table*/                                                                         
                                                                                                                                        
  tables.items=tablist;                                                                                                                 
                                                                                                                                        
/* Close the table and delete the CREATEd list*/                                                                                        
                                                                                                                                        
  rc = close(datasets);                                                                                                                 
  rc = dellist(tablist);                                                                                                                
end;                                                                                                                                    
                                                                                                                                        
else                                                                                                                                    
 message.text = sysmsg();                                                                                                               
RETURN;                                                                                                                                 
                                                                                                                                        
/* Terminate the program*/                                                                                                              
                                                                                                                                        
TERM:                                                                                                                                   
return;                  

/************************************************************************************************************/
/* Chapter 8 
/************************************************************************************************************/

/* Page 454 */ 
PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

CREATE table bluesky.client (bufsize=8704)
	(clientNo	num,
 	company 	char(40),
 	cont_fst	char(10),
	cont_lst 	char(15),
 	dept 		char(25),
 	phone 		char(25),
 	fax 		char(25) 
	);

DESCRIBE table bluesky.client;
QUIT;

/* Page 456 */
PROC SQL;
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

ODS document;
ODS html;
TITLE1 'Orders table ';

SELECT	* 
FROM 	bluesky.orders
ORDER BY ord_date;
ODS html close;

ODS pdf;
TITLE1 'Historical Orders';
SELECT	* 
FROM 	bluesky.order_2001_2002
ORDER BY ord_date;
ODS pdf close;
ODS document close;
QUIT;

/* Page 458 */ 
PROC SQL outobs=10;
SELECT 	style 
FROM 	dictionary.styles;
QUIT;

/* Page 458 */ 

PROC TEMPLATE;
  list styles /
  stats=all;
RUN;

/* Page 459 */ 

PROC TEMPLATE;  
define style bluesky.greenYellow;  

style body /   
         font_face=arial 
         font_size=8 
         background=dark green
         foreground=white;

style SystemTitle /   
	font_face=arial
	font_size=10 
	foreground=yellow 
	font_style=italic;
end;
run;

ODS html style=bluesky.greenYellow;

PROC SQL;
TITLE1 	'Current Client List';
SELECT 	company 'Client Name' format=$30.,
       	cat(cont_fst, cont_lst)'Contact' format=$30.,
        dept 'Department' 
FROM	bluesky.client;

ODS html close;
QUIT;

/* Page 461 */ 

PROC SQL;
SELECT	*
FROM	"C:\mydata\bluesky bookstore\orders.sas7bdat";

LIBNAME bluesky "C:\mydata\bluesky bookstore\";
SELECT	*
FROM	bluesky.orders;
QUIT;

/* Page 463 */
LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL;

SELECT  clientno, totsale "Total sales" , quantity "Total quantity",
        totsale/quantity "Price per book" 
INTO    :client01- :client50, :bksum01 - :bksum50,
        :bkamt01 through :bkamt50, :bkpr01 thru :bkpr50
FROM    bluesky.orders
WHERE   ord_date between '01MAR2004'd and '30MAY2004'd;
QUIT;

/* Page 463 */ 

LIBNAME bluesky "C:\mydata\bluesky bookstore\";
PROC SQL noprint;

SELECT  	sum(totsale), sum(quantity) ,
        	mean(totsale/quantity) 
INTO    	:bksum, :bkamt, :bkprice
FROM    	bluesky.orders
WHERE   	ord_date between '01APR2004'd and '30MAY2004'd;

%macro orderck;
        %if &bkprice > 25.00 %then %do;
		PROC SQL;
		TITLE1 	"Average price per book > $25 for the period";
               SELECT 	ord_date, clientno, prodcode,
						totsale format=comma10.,
						quantity format=comma6.
                FROM 	bluesky.orders
                WHERE 	ord_date between '01APR2004'd and '30MAY2004'd;
               %end;
        %if &bksum < 10000 %then %do;
		PROC SQL;
               TITLE1	"Total sales < $10,000 for the period";
               SELECT	clientno, prodcode, 
						totsale format=comma10.
               FROM		bluesky.orders
               WHERE 	ord_date between '01APR2004'd and '30MAY2004'd;
               %end;
        %if &bkamt > 3000 %then %do;
		PROC SQL;
		TITLE1 "Total quantity sold > 3000 for the period";
               SELECT	clientno, prodcode,
						quantity format=comma6.
               FROM 	bluesky.orders
               WHERE 	ord_date between '01APR2004'd and '30MAY2004'd;
               %end;
%if 	%SYMGLOBL(bksum)%then %put The macro variable bksum is global in scope
%else %put The macro variable bksum is local in scope;

%mend orderck;
%orderck;

%put %SYMEXIST(bksum) is the value of the function;

QUIT;

/* Page 466 */ 
PROC SQL;
LIBNAME orablue ORACLE
  	user=scott password=tiger path=master schema=bluesky multi_datasrc_opt=in_clause;
LIBNAME sqlsrvr ODBC 
	datasrc='bluesky' user=wayne password=john multi_datasrc_opt=in_clause;

SELECT	o.ord_date, o.totsale, o.clientno, a.city
FROM	orablue.orders (dbmaster=yes) o,
		sqlsrvr.address a
WHERE	o.clientno = a.clientno;
QUIT;

/* Page 467 */
/* There is an error in the code in the book - please note that the query should include orders for 2003 only*/

PROC SQL; 
LIBNAME bluesky "C:\mydata\bluesky bookstore\";

LIBNAME orablue ORACLE
  	user=scott password=tiger path=master schema=bluesky;

SELECT 	stock.prodcode "Product Code" format=$15., 
		stock.auth_lst "Author" format=$15.,
       	avg(orders.quantity) as mnqty 
	  	"Average Quantity" format=comma8.,
       	avg(stock.price) as mnprice "Average Price" format= comma10.2,
       	sum(orders.quantity*stock.price) as smprice 
	  	"Quantity * Price" format= comma10.2
FROM  	orablue.orders (DBSLICE=("ord_date <'01-JAN-04'" "ord_date >= '01-JAN-03'")),
		orablue.stock
WHERE	orders.prodcode = stock.prodcode
GROUP BY stock.prodcode, stock.auth_lst
ORDER BY stock.auth_lst;
QUIT;

/************************************************************************************************************/
/* Appendix C
/************************************************************************************************************/

/* Page 494 */ 

PROC SQL;
CONNECT TO ORACLE as orablue
(user=scott password=tiger path=master schema=bluesky);

SELECT 	*
FROM 	CONNECTION TO orablue
	(SELECT	*
	FROM	scott.stock
	);
QUIT;

/* Page 496 */ 
LIBNAME orablue ORACLE
	(user=scott password=tiger path=master schema=bluesky);

PROC SQL;
SELECT 	*
FROM 	orablue.stock;
QUIT;

/* Page 500 */ 
PROC SQL ;
CONNECT to oracle as orablue
	(user=scott password=tiger path=master schema=bluesky
 	preserve_comments buffsize=500);

SELECT 	* 
FROM 	connection to orablue

(SELECT /* +indx(prodcode) */
		prodcode, title, stock 
FROM 	scott.stock
WHERE 	prodcode = '300456' or prodcode= '300680')
;

DISCONNECT from orablue;
QUIT;

/* Page 502 */ 
PROC SQL;

LIBNAME bluesky ODBC PROMPT;

CONNECT TO ODBC(prompt);
QUIT;

/* Page 502 */
/* There is an error in the book; path should be master and not bluesky for orablue connection*/ 

PROC SQL;
OPTIONS OBS=15;

CONNECT to oracle as orablue
	(user=system password=manager path=master);

SELECT 	* 
FROM 	connection to orablue
		(SELECT username 
		FROM 	dba_users
		WHERE 	username not like ('%$%')
		ORDER BY username
		);

QUIT;

/* Page 504 */
/* There is an error in the book; path should be master and not bluesky for ora_scott connection*/ 
PROC SQL;

CONNECT to oracle as orablue
		(user=system password=manager path=master);
/* Not part of the example - used to DROP the user if it exists already*/
/*EXECUTE(DROP user taylor cascade) by orablue;*/

EXECUTE	(CREATE user taylor identified by tim) by orablue;
EXECUTE	(grant connect, resource to taylor) by orablue;

CONNECT to oracle as ora_scott
		(user=scott password=tiger path=master);
EXECUTE	(grant select on emp to taylor) by ora_scott;

CONNECT to oracle as ora_taylor
	(user=taylor password=tim path=master);
SELECT 	* 
FROM 	connection to ora_taylor
		(SELECT * 
		FROM scott.emp);

DISCONNECT from orablue;
QUIT;

/* Page 504 */ 
PROC SQL;
EXECUTE	(grant select on scott.emp to taylor) by orablue;
QUIT;

/* Page 505 */ 

PROC SQL;
CONNECT to ODBC as sqlsrvr
		(datasrc='bluesky' user=kathy password=kathy) ;
EXECUTE	(exec sp_addlogin 'wayne', 'john', 'Northwind' ) by sqlsrvr;
EXECUTE	(exec sp_grantdbaccess 'wayne')by sqlsrvr;
SELECT 	* 
FROM 	connection to sqlsrvr
		(SELECT name 
		FROM sysusers);
DISCONNECT from sqlsrvr;
QUIT;

/* Page 511 */ 
PROC SQL;
LIBNAME orablue ORACLE user=scott password=tiger path=master schema=bluesky;

CREATE table orablue.orders (
  	prodCode 	char(10) format $6. label="Product",
  	ord_date 	date,
  	quantity 	num,
  	totsale 	num,
 	currency 	char(3),
 	delCode 	char(3),
 	clientNo 	num, 
	invoice 	char(10));

DESCRIBE table orablue.orders;
QUIT;

LIBNAME sqlsrvr ODBC datasrc='bluesky' user=wayne password=john;
PROC SQL;
/*DROP the table if needed; not part of the example in the book*/
/*DROP table sqlsrvr.orders;*/

CREATE table sqlsrvr.orders (
  	prodCode 	char(10) format $6. label="Product",
  	ord_date 	date,
  	quantity 	num,
  	totsale 	num,
 	currency 	char(3),
 	delCode 	char(3),
 	clientNo 	num, 
	invoice 	char(10));

DESCRIBE table sqlsrvr.orders;
QUIT;

/* Page 513 */ 

PROC SQL;
LIBNAME sqlsrvr ODBC datasrc='bluesky' user=wayne password=john;

INSERT into sqlsrvr.orders 
values('600125','10mar2004'd,100,1250,'SGD','EXP',4008,'040310-04');

INSERT into sqlsrvr.orders 
values('200507','08apr2004'd,20,1490,'SGD','EXP',4008,'040408-01');

INSERT into sqlsrvr.orders 
values('300456','10apr2004'd,55,797.5,'EUR','EXP',6090,'040410-01');

INSERT into sqlsrvr.orders 
values('200145','12apr2004'd,700,39375,'USD','EXE',2010,'040412-01');

SELECT 	* 
FROM 	sqlsrvr.orders;
QUIT;

/* Page 514 */ 
PROC SQL;
LIBNAME sqlsrvr ODBC datasrc='bluesky' user=wayne password=john;

INSERT into sqlsrvr.orders (sasdatefmt=(ord_date='date9.')) 
values('600125','10mar2004'd,100,1250,'SGD','EXP',4008,'040310-04');

INSERT into sqlsrvr.orders (sasdatefmt=(ord_date='date9.'))
values('200507','08apr2004'd,20,1490,'SGD','EXP',4008,'040408-01');

INSERT into sqlsrvr.orders (sasdatefmt=(ord_date='date9.'))
values('300456','10apr2004'd,55,797.5,'EUR','EXP',6090,'040410-01');

INSERT into sqlsrvr.orders (sasdatefmt=(ord_date='date9.'))
values('200145','12apr2004'd,700,39375,'USD','EXE',2010,'040412-01');

SELECT 	* 
FROM 	sqlsrvr.orders (sasdatefmt=(ord_date='date9.'));
QUIT;

/* Page 515 */ 
PROC SQL;
CONNECT to oracle as orablue(user=scott password=tiger path=master);

EXECUTE	(DROP table neworder) by orablue;
EXECUTE	(CREATE table neworder (
  		prodCode 	varchar2(10) ,
  		ord_date 	date,
  		quantity 	numeric,
  		totsale 	numeric,
 		currency 	varchar2(3),
 		delCode 	varchar2(3),
 		clientNo 	numeric, 
		invoice 	varchar2(10))
		) by orablue;
 
EXECUTE	(INSERT into neworder 
		values('200145','12apr2004',700,39375,'USD','EXE',2010,'040412-01')
		) by orablue;

EXECUTE	(COMMIT) by orablue; 

EXECUTE	(INSERT into neworder
		values('200507','08apr2004',20,1490,'SGD','EXP',4008,'040408-01')
		) by orablue;

EXECUTE	(ROLLBACK) by orablue;

SELECT * 
FROM 	CONNECTION TO orablue
		(SELECT * 
		FROM neworder);

DISCONNECT from orablue;
QUIT;

/* Page 523 */ 

PROC SQL;

CREATE VIEW recent_orders as
	SELECT 	prodcode "Product Code" , ord_date "Order Date" , 
			quantity "Quantity", totsale "Total Sale", currency "Currency", 
			delcode "Delivery Code" ,clientno "Client Number"
	FROM 	sqlsrvr.orders_new
			(DBCONDITION= "WHERE ord_date > '01JAN2004'"
			sasdatefmt=(ord_date='date9.'))
	USING LIBNAME sqlsrvr ODBC datasrc='bluesky' user=wayne password=john;

SELECT *
FROM recent_orders;
QUIT;













