* E12_1_3.sas
*
* Using preloaded formats with MEANS/SUMMARY;

ods pdf style=journal
        file="&path\results\E12_1_3.pdf";
title1 '12.1.3 Using Preloaded Formats With MEANS/SUMMARY';


proc format;
   * Create a subset of symptoms, ('00' does not exist in the data);
   value $symp
      '00'= 'Unspecified'
      '01'= 'Sleepiness'
      '02'= 'Coughing'
      '03'= 'Limping';
   * The value of sex='U' is not in the data set;
   value $genderu
      'M'='Male'
      'F'='Female'
      'U'='Unknown'; 
   run;

title2 'Using the EXCLUSIVE Option';
proc summary data=advrpt.demog;
   class symp / preloadfmt 
                exclusive;
   var ht;
   output out=withexclusive mean= meanHT;
   format symp $symp.;
   run;
proc print data=withexclusive;
   run;

title2 'With EXCLUSIVE and COMPLETETYPES';
proc summary data=advrpt.demog completetypes;
   class symp / preloadfmt exclusive;
   var ht;
   output out=excl_comp mean= meanHT;
   format symp $symp.;
   run;
proc print data=excl_comp;
   run;

title2 'Two Classification Variables';
title3 'COMPLETETYPES Without EXCLUSIVE';
proc summary data=advrpt.demog completetypes;
   class symp sex / preloadfmt ;
   var ht;
   output out=twoclass mean= meanHT;
   format symp $symp.
          sex  $genderu.;
   run;
proc print data=twoclass;
   run;


ods pdf close;
