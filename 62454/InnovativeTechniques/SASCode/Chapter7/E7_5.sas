* E7_5.sas
* 
* Understanding _TYPE_;

title1 '7.5 Understanding _TYPE_';
proc summary 
      data=advrpt.demog
         (where=(race in('1','4')
                & 12 le edu le 15
                & symp in('01','02','03')))
      ;
   class race edu symp;
   var ht;
   output out=stats
          mean= meanHT
          ;
   run;
proc print data=stats;
   run; 

