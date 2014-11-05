* E2_5_5.sas
* 
* Using Preloaded Formats to Sparse a Table;

title1 '2.5.5 Using Preloaded Formats';
title2 'PROC REPORT with COMPLETEROWS';

proc format;
value visits
 1='1'
 2='2'
 3='3'
 4='4'
 5='5'
 6='6'
 7='7'
 8='8'
 9='9'
 10='10';
 run;
ods pdf file="&path\results\E2_5_5.pdf";
proc report data=advrpt.lab_chemistry nowd 
            completerows;
   column visit sodium potassium chloride;
   define visit / group 
                  f=visits. preloadfmt
                  'Vist' order=data;
   define sodium /analysis mean f=5.2;
   define potassium /analysis mean f=5.3;
   define chloride/analysis mean f=5.1;
   run;
ods pdf close;
