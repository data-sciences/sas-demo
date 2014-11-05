*E1_2_4d.sas
*
* Reading a CSV file using a DATA step;

data WORK.CLASSWO                                ;
    infile "&path\Data\classwo.csv" delimiter = ',' 
           MISSOVER DSD lrecl=32767 firstobs=4 ;
       informat VAR1 $8. ;
       informat VAR2 $1. ;
       informat VAR3 best32. ;
       informat VAR4 best32. ;
       informat VAR5 best32. ;
       format VAR1 $8. ;
       format VAR2 $1. ;
       format VAR3 best12. ;
       format VAR4 best12. ;
       format VAR5 best12. ;
    input
                VAR1 $
                VAR2 $
                VAR3
                VAR4
                VAR5
    ;
    run;
