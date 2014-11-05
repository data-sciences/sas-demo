* S2_6_2.sas
*
* Text Line using COMPUTE;
title1 'Using Proc REPORT';
title2 'Footnote Using LINE';

ods rtf file="&path\results\ch2_6_2.rtf" style=rtf bodytitle;
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
  compute after;
    line @20 'Weight taken during';
    line @20 'the entrance exam.';
  endcomp;
  run;
ods rtf close;
