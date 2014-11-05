PROC IMPORT OUT= WORK.CLASSwo 
            DATAFILE= "&path\Data\classwo.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=no;
     DATAROW=4; 
RUN;
