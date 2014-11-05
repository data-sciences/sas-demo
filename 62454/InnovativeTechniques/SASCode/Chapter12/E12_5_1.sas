* E12_5_1.sas
* 
* Using Nested Formats;

title1 '12.5.1 Nested Formats';

***********************************************
* 12.5.1
* Nesting a Date9 format;
proc format;
   value missdate
      . = 'Unknown'
      other=[date9.];
   run;

proc print data=advrpt.demog;
   var lname fname dob;
   format dob missdate.;
   run;
*************************************************;
* Map missing to 0.00;
proc format;
   value pctzero
      .='0.00'
      other=[6.2];
   run;

