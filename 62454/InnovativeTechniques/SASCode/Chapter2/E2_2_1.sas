* E2_2_1.sas
*
* Operator heirarchy;

title1 '2.2.1';
data Season;
   set advrpt.demog (keep=lname fname dob);
   season = 1*(1 le month(dob) le 3)
          + 2*(4 le month(dob) le 6)
          + 3*(7 le month(dob) le 9)
          + 4*(10 le month(dob) le 12);
   season2= ceil(month(dob)/3);
   run;

proc print data=season; 
   run;
