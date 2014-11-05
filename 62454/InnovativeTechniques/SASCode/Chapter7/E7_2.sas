* E7_2.sas
* 
* Using AUTONAME and AUTOLABEL;

title1 '7.2 No Statistics Specified';
proc summary data=advrpt.demog;
   class race;
   var ht;
   output out=stats;
   run;
proc print data=stats;
run; 

title1 '7.2 Without Using AUTONAME';
proc summary data=advrpt.demog;
   class race;
   var ht;
   output out=stats
          n=
          mean= 
          stderr=
          ;
   run;
proc print data=stats;
run; 

title1 '7.2 Using AUTONAME';
proc summary data=advrpt.demog;
   class race;
   var ht;
   output out=stats
          n=
          mean= 
          stderr=/autoname
          ;
   run;
proc print data=stats;
run; 
