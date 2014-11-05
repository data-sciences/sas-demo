* E7_10.sas
* 
* Using the COMPLETETYPES Option;

title1 '7.10 Using the COMPLETETYPES Option';
proc summary data=advrpt.demog(where=(race in('1','4')
                         & 12 le edu le 15
                         & symp in('01','02','03')))
                completetypes;
   class race edu symp;
   var ht;
   output out=stats mean= meanHT;
   run;

proc print data=stats;
   run;
