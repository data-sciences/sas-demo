* S3_2_1.sas
*
* Skipping a Line Between Groups;

ods pdf file="&path\results\ch3_2_1.pdf" style=printer;
ods rtf file="&path\results\ch3_2_1.rtf" style=rtf bodytitle;
* Creating Breaks;
title1 'Creating Breaks in the Report';
title2 'Using BREAK to SKIP a Space';
proc report data=rptdata.clinics
               (where=(region in('1' '2' '3' '4'))) 
            nowd;
  column region sex wt,(n mean);
  define region / group format=$6.;
  define sex    / group format=$6. 'Gender';
  define wt     / analysis;
  break after region/skip;
  run;
ods rtf close;
ods pdf close;
