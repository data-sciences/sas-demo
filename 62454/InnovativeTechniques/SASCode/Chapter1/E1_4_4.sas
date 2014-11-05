* E1_4_4.sas
*
* Using the DSV destination;
title '1.4.4 Using the CSV Destination';
ods csv file="&path\data\E1_4_4demog.csv)"  
        options(doc='Help' 
                delimiter=";"); 
proc print data=advrpt.demog
           noobs;
   var fname lname dob;  
   run;
ods csv close;  
