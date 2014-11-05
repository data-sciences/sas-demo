* E15_2_4.sas
* 
* Viewing Function Libraries;

title1 '15.2.4 Viewing Function Libraries';
********************************************;
options cmplib=(advrpt.functions);
proc fcmp inlib=advrpt.functions listall;
run;
