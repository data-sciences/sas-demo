* E12_1_2.sas
*
* Using preloaded formats with TABULATE;

ods html style=journal
         path="&path\results"
         body='E12_1_2.html';
title1 '12.1.2 Using Preloaded Formats With TABULATE';


* Create a subset of symptoms ('00' does not exist in the data);
proc format;
   value $symp
      '00'= 'Unspecified'
      '01'= 'Sleepiness'
      '02'= 'Coughing'
      '03'= 'Limping';
   run;

title2 'Using the EXCLUSIVE option';
proc tabulate data=advrpt.demog;
   class symp /preloadfmt exclusive;
   var ht wt;
   table symp,
         (ht wt)*(n*f=2. min*f=4. median*f=7.1 max*f=4.);
   format symp $symp.;
   run;

title2 'Using PRINTMISS With the EXCLUSIVE option';
proc tabulate data=advrpt.demog;
   class symp /preloadfmt exclusive;
   var ht wt;
   table symp,
         (ht wt)*(n*f=2. min*f=4. median*f=7.1 max*f=4.)
         / printmiss;
   format symp $symp.;
   run;

title2 'Without the EXCLUSIVE option';
proc tabulate data=advrpt.demog;
   class symp /preloadfmt;
   var ht wt;
   table symp,
         (ht wt)*(n*f=2. min*f=4. median*f=7.1 max*f=4.)
         /printmiss;
   format symp $symp.;
   run;
ods html close;
