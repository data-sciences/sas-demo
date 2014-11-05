* E1_2_1a.sas
* 
*EXPORT a data table to EXCEL;

PROC EXPORT DATA= WORK.A 
            OUTFILE= "C:\temp\junk.xls" 
            DBMS=EXCEL REPLACE;
     SHEET="junk"; 
RUN;
