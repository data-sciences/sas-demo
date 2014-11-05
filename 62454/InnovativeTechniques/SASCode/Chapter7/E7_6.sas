* E7_6.sas
* 
* Using the CHARTYPE option;

title1 '7.6 Using the CHARTYPE Option';
proc summary 
      data=advrpt.demog
         (where=(race in('1','4')
                & 12 le edu le 15
                & symp in('01','02','03')))
      chartype;
   class race edu symp;
   var ht;
   output out=stats
          mean= meanHT
          ;
   run;
proc print data=stats;
   run; 

