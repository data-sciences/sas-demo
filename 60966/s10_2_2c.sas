* S10_2_2c.sas
*
* Resolving macro variables;

ods listing close;
ods html style=default
         path="&path\results"
         body="ch10_2_2c.html";

title1 'Automation of Report Processes';
title2 'Resolution of Macro Variables';
title3 'Single quotes in a Compute Block';
proc report data=rptdata.clinics nowd;
   columns clinname clinnum ht ht=htmean wt;

   define clinname/ group noprint;
   define clinnum / group 'Clinic Number';
   define ht      / analysis n 'N';
   define htmean  / analysis mean 'Height';
   define wt      / analysis mean 'Weight';

   rbreak after   / summarize suppress;

   compute clinnum;
      call symput('clin',clinname);
      attrib = 'style={flyover="&clin"}';
      call define(_col_,'style',attrib);
   endcomp;
   run;
ods _all_ close;

