* E8_2_1.sas
* 
* UNIVARIATE Plotting;

* For SAS9.3 uncomment the following ODS statement;
* ods graphics off;

filename out821a "&path\results\g821a.emf";
goptions device=emf
         gsfname=out821a
         noprompt;
title1 '8.2.1a Plots by PROC UNIVARIATE';
proc univariate data=advrpt.demog;
   class race sex;
   var ht;
   histogram /nrows=5 ncols=2
              intertile=1 cfill=cyan vscale=count
              vaxislabel='Count';

   inset mean='Mean Height: ' (5.2) / noframe position=ne
                                      height=2 font=swissxb;
   run;
   quit;

filename out821a "&path\results\g821a_arial.emf";
goptions device=emf  ftext=arial
         gsfname=out821a 
         noprompt;
title1 '8.2.1a_ARIAL Plots by PROC UNIVARIATE';
proc univariate data=advrpt.demog;
   class race sex;
   var ht;
   histogram /nrows=5 ncols=2
              intertile=1 cfill=cyan vscale=count
              vaxislabel='Count';

   inset mean='Mean Height: ' (5.2) / noframe position=ne
                                      height=2 font=swissxb;
   run;
   quit;


filename out821b "&path\results\g821b.emf";
goptions reset=all
         device=emf
         gsfname=out821b
         noprompt;

title1 f=arial '8.2.1b Normal Plots by PROC UNIVARIATE';
proc univariate data=advrpt.demog;
   var wt;
   histogram /midpoints=100 to 250 by 15
              cfill=cyan vscale=count
              vaxislabel='Count' 
              normal (l=2 color=red)
              outhistogram=predpct;

   inset mean='Mean: ' (6.2) / position=nw
                               height=4 font=arial;
   run;
   quit;
