* E1_2_1b.sas
* 
*EXPORT a data table to a CSV file;

PROC EXPORT DATA= sashelp.class 
            OUTFILE= "&path\data\class.csv" 
            DBMS=csv 
            REPLACE;
   RUN;
