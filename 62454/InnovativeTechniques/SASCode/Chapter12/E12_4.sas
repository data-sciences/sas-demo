* E12_4.sas
* 
* Using NOTSORTED;

title1 '12.4 Formats Defined with NOTSORTED';


proc format;
   value edlevel (notsorted)
      9-12 = 'High School'
      13-high='College';
   run;

ods pdf file="&path\results\E12_4.pdf" 
        style=printer;
proc tabulate data=advrpt.demog;
   class edu sex;
   var wt;
   table edu all,sex*wt*(n*f=2. mean*f=5.1 stderr*f=6.2);
   format edu edlevel.;
   run;
ods pdf close;


