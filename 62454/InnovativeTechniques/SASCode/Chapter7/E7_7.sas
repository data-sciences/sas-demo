* E7_7.sas
* 
* Using the WAYS statement;

title1 '7.7 Using the WAYS Statement';
proc summary data=advrpt.demog
         (where=(race in('1','4')
                & 12 le edu le 15
                & symp in('01','02','03')));
   class race edu symp;
   var ht;
   ways 0,2;
   output out=stats
          mean= meanHT
          ;
   run;
proc print data=stats;
   run; 

