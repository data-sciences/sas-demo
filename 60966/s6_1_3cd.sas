* S6_1_3cd.sas
*
* Allowing the Use of MISSING Classification Items;

* Create a dummy region with some missing values;
data reg11(keep=region clinname lname wt ht);
   set rptdata.clinics(where=(region='1'));
   region='11';
   if clinname=:'V' then clinname=' ';
   else do;
      wt=.;
      ht=0;
   end;
   run;

title1 'Refining REPORT Appearance';
title2 'Artificial Region 11 Data';
proc print data=reg11;
run;

* Using MISSING on the DEFINE statement;
title1 'Refining REPORT Appearance';
title2 'Without MISSING Option';
proc report data=reg11 nowd;
  column region clinname ht wt;
  define region   / group         format=$6.; 
  define clinname / group;
  define ht       / analysis mean format=6.1;
  define wt       / analysis mean format=6.1;
  run;

* Using MISSING on the DEFINE statement;
title1 'Refining REPORT Appearance';
title2 'MISSING Option on DEFINE Statement';
proc report data=reg11 nowd;
  column region clinname ht wt;
  define region   / group         format=$6.; 
  define clinname / group missing;
  define ht       / analysis mean format=6.1;
  define wt       / analysis mean format=6.1;
  run;
