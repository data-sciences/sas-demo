*E12_3_1.sas
*
* Using Multi-label formats.;

proc format;
   value edlevel (multilabel)
      9-12 = 'High School'
      13-high='College'
      17-high='Graduate Studies';
   run;

ods pdf file="&path\results\E12_3_1.pdf" 
        style=minimal;

title1 '12.3.1 Multi-label Formats';
proc tabulate data=advrpt.demog;
   class edu / mlf;
   class sex;
   var wt;
   table edu=' ' all,
         sex*wt*(n*f=2. mean*f=5.1 stderr*f=6.2)
         /box=edu;
   format edu edlevel.;
   run;
ods pdf close;

* Show use of MLF in PROC MEANS;
proc means data=advrpt.demog noprint;
   class edu / mlf;
   var wt;
   output out=stats Mean= n= /autoname;
   format edu edlevel.;
run;
proc print data=stats;
run;
