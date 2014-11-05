* E7_1.sas
* 
* Multiple CLASS statements and CLASS statement options;

title1 '7.1a Single Class Statement';
proc summary data=advrpt.demog;
   class race edu;
   var ht wt;
   output out=stats
          mean= htmean wtmean
          stderr=htse wtse
          ;
   run;
proc print data=stats;
   run; 

title1 '7.1b Multiple Class Statements';
proc summary data=advrpt.demog;
   class race;
   class edu;
   var ht wt;
   output out=stats
          mean= htmean wtmean
          stderr=htse wtse
          ;
   run;
proc print data=stats;
   run;

********************************************;
title1 '7.1.1 Multiple Class Statements';
title2 'MISSING and DESCENDING Options';
proc summary data=advrpt.demog;
   class race/descending;
   class edu/missing;
   var ht wt;
   output out=stats
          mean= htmean wtmean
          stderr=htse wtse
          ;
   run;
proc print data=stats;
run;

********************************************;
title1 '7.1.2 CLASS Statement Options';
proc format;
   value edulevel
      0-12 = 'High School'
      13-16= 'College'
      17-high='Post Graduate';
   run;

title2 'GROUPINTERNAL not used';
proc summary data=advrpt.demog;
   class edu;
   var ht wt;
   output out=stats
          mean= MeanHT MeanWT
          ;   
   format edu edulevel.; 
   run;
proc print data=stats;
   run;

title2 'Using GROUPINTERNAL';
proc summary data=advrpt.demog;
   class edu/groupinternal;
   var ht wt;
   output out=stats
          mean= MeanHT MeanWT
          ;   
   format edu edulevel.; 
   run;
proc print data=stats;
   run;

title1 '7.1.3 CLASS Statement Options';
title2 'Using ORDER=FREQ';
proc summary data=advrpt.demog;
   class edu/order=freq;
   var ht wt;
   output out=stats
          mean= MeanHT MeanWT
          ;   
   run;
proc print data=stats;
   run;
