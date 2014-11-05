Example 6.1  PROC ACCESS Example

proc access dbms=oracle;
create work.test.access;      
user="scott";
orapw="tiger";
table="scott.emp";
path="sample";
assign=yes;
list all;
create work.test.view;
select EMPNO ENAME JOB;  
subset where DEPTNO = 20;

proc print data=test;
id EMPNO;
title “Oracle Sample Employee Table”;

Example 6.2  SAS/ACCESS to Oracle LIBNAME Engine

libname oralib oracle user="scott" password="tiger" path="sample";

proc print data=oralib.emp;
id empno;
var ename job;  
where deptno = 20;
	run;

Example 6.3  SAS/ACCESS to Oracle LIBNAME Engine 

libname mydblib oracle dbprompt=yes;

proc print data=mydblib.emp;
id empno;
var ename job;  
where deptno = 20;
run;

Example 6.4  PROC DBLOAD  

data emp2;
retain empno 1234 ename="PRATTER" job="SAS GURU"
mgr=7839 hiredate="01JAN08"d sal=5000 deptno=99;
output;
run;

proc dbload dbms=oracle data=emp2;
orapw="tiger"; user="scott"; path="sample";
table="EMP2";
load;
run;
 
Example 6.5  SQL Pass-Through 

proc sql;
connect to oracle (user=scott orapw=tiger path=sample);
create table EMP as 
select * from connection to oracle
(select * from EMP);
disconnect from oracle;
quit;

Example 6.6  Using ODBC to Connect to Oracle

proc sql;
connect to odbc (dsn=sample uid=scott pwd=tiger);
create table EMP as 
select * from connection to odbc 
(select * from emp);
disconnect from odbc;
quit;

Example 6.7  Using PROC DBLOAD with ODBC

proc dbload dbms=odbc data=mylib.dept; 
dsn="oracle";
uid="scott";
pwd="tiger";
table="emp2";
limit=0;
load;
run;

Example 6.8  Using the OLE DB LIBNAME

libname oradb OLEDB 
init_string="Provider=MSDAORA.1;Password=tiger;User ID=scott;
Data Source=sample;Persist Security Info=True";
proc print data=oradb.emp; 
id empno;
run;

Example 6.9  Using the OLE DB LIBNAME Engine with SQL Pass-Through

proc sql;
connect to oledb
(init_string="Provider=MSDAORA.1;Password=tiger;User ID=scott;
Data Source=sample;Persist Security Info=True");
create table EMP as
select * from connection to oledb
(select * from EMP);
quit;
 
Example 6.10  Using PROC IMPORT

PROC IMPORT OUT=WORK.emp 
DATATABLE="Employees" 
DBMS=ACCESS REPLACE;
DATABASE="C:\Program Files\Microsoft Office\OFFICE11\SAMPLES\
Northwind.mdb"; 
SCANMEMO=YES;
USEDATE=NO;
SCANTIME=YES;
RUN;



