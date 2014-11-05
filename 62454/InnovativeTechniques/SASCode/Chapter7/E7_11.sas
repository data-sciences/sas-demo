* E7_11.sas
* 
* Using the LEVELS and WAYS options;

title1 '7.11 Using LEVELS and WAYS Options';
proc summary data=advrpt.demog;
   class race edu;
   var ht;
   output out=stats 
       mean= meanHT /levels ways;
   run;

proc print data=stats;
   run;
