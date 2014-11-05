* S2_6_4.sas
*
* Using SAS Language Elements in the compute block;

title1 'Using Proc REPORT';
title2 'Converting Weight to Kg';
proc report data=rptdata.clinics
                   (where=(region in('4'))) 
            nowd;
  column lname fname sex wt;
  define lname  / display;
  define fname  / display;
  define sex    / display format=$6. 'Gender';
  define wt     / display 'Weight in Kg'
                  format=6.2;
  
  compute wt;
     wt = wt/2.2;
  endcomp;
  run;
