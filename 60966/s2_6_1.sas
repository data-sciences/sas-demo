* S2_6_1.sas
*
* Blank Line using COMPUTE;
title1 'Using Proc REPORT';
title2 'Blank Line After Region';
proc report data=rptdata.clinics
                   (where=(region in('1' '2' '3' '4'))) 
            nowd;
  column region sex wt,(n mean);
  define region / group format=$6.;
  define sex    / group format=$6. 'Gender';
  define wt     / analysis;
  compute after region;
    line ' ';
  endcomp;
  run;
