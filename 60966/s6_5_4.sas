* S6_5_4.sas
*
* Use the MISSING option on the PROC statement;

* Artificially generate some missing values for clinic name
* and REGION;
data regmiss(keep=region clinname ht);
   set rptdata.clinics;

   * Create some missing values for REGION;
   if mod(_n_,10)=0 then region=' ';

   * Create some missing values for clinname;
   if mod(_n_,12)=0 then clinname=' ';
   run;

title1 'Refining REPORT Appearance';
title2 'Artificial Missing Values';
proc print data=regmiss;
run;

* Using MISSING on the PROC statement;
title1 'Refining REPORT Appearance';
title2 'Artificial Missing Values';
title3 'Without the MISSING Option';
proc report data=regmiss(where=(region<'4')) 
            nowd;
  column region clinname ('Height' ht ht=htmean);
  define region   / group format=$6.; 
  define clinname / group;
  define ht       / analysis N    format=6.1 'N';
  define htmean   / analysis Mean format=6.1 'Mean';
  run;

* Using MISSING on the PROC statement;
title1 'Refining REPORT Appearance';
title2 'Artificial Missing Values';
title3 'With the MISSING Option';
proc report data=regmiss(where=(region<'4')) 
            nowd missing;
  column region clinname ('Height' ht ht=htmean);
  define region   / group format=$6.; 
  define clinname / group;
  define ht       / analysis N    format=6.1 'N';
  define htmean   / analysis Mean format=6.1 'Mean';
  run;
