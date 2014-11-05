* S2_5.sas
*
* Using GROUP and ACROSS;

ods html file="&path\results\ch2_5.html";
ods listing;

  * Using GROUP and ACROSS;
  title1 'Using Proc REPORT';
  title2 'Define Types GROUP and ACROSS';
  proc report data=rptdata.clinics nowd;
    column region sex wt,(n mean);
    define region / group;
    define sex    / across;
    define wt     / analysis;
    run;

ods html close;
ods listing close; 
