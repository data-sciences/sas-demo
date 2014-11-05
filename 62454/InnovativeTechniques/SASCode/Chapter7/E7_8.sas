* E7_8.sas
* 
* Using the TYPE statement;

title1 '7.8 Using the TYPE Statement';
proc summary data=advrpt.demog
         (where=(race in('1','4')
                & 12 le edu le 15
                & symp in('01','02','03')));
class race edu symp;
var ht;
* Multiple TYPES statements can be specified;
types ();
types edu race*symp;
output out=stats
       mean= meanHT
       ;
run;
proc print data=stats;
run; 

