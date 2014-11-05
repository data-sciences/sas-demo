* E1_2_3.sas
*
* Using PROC IMPORT;
data makescale(keep=subject scale);
   set advrpt.demog(keep=subject);
   do i = 1 to 10;
      if subject le 270 then scale = left(put(i,2.));
      else scale = substr('abcdefghijk',i,1);
      output makescale;
   end;
   run;
PROC EXPORT DATA= makescale 
            OUTFILE= "c:\temp\makescale.xls" 
            DBMS=excel 
            REPLACE;
   RUN;

* Import the EXCEL data;
* SCALE is numeric, but should be character;
PROC IMPORT OUT= WORK.scaledata 
            DATAFILE= "C:\Temp\makescale.xls" 
            DBMS=EXCEL REPLACE;
     RANGE="MAKESCALE"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
   RUN;

* Import the DBMS=EXCEL data using mixed=YES;
* This does not work - SCALE is numeric;
PROC IMPORT OUT= WORK.scaledata 
            DATAFILE= "C:\Temp\makescale.xls" 
            DBMS=EXCEL REPLACE;
     RANGE="MAKESCALE"; 
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
   RUN;

* USE MIXED=YES with DBMS=excel;
* SCALE is numeric;
PROC IMPORT OUT= WORK.scaledata 
            DATAFILE= "C:\Temp\makescale.xls" 
            DBMS=excel REPLACE;
     GETNAMES=YES;
     MIXED=YES;
   RUN;

* Change the value of DBMS;
* USE MIXED=YES with DBMS=XLS;
* SCALE is character;
PROC IMPORT OUT= WORK.scaledata 
            DATAFILE= "C:\Temp\makescale.xls" 
            DBMS=xls REPLACE;
     GETNAMES=YES;
     MIXED=YES;
   RUN;

* Use GUESSINGROWS instead of MIXED;
PROC IMPORT OUT= WORK.scaledata 
            DATAFILE= "C:\Temp\makescale.xls" 
            DBMS=xls REPLACE;
     GETNAMES=YES;
     GUESSINGROWS=800;
   RUN;
