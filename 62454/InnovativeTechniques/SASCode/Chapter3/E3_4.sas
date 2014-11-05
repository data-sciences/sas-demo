* E3_4.sas
* 
* Using INTCK to count years;

title1 '3.4 Year counts';

data _null_;
   twoday = intck('year','31dec2008'd,'01jan2009'd);
   twoyr  = intck('year','01jan2008'd,'31dec2009'd);
   put twoday= twoyr=;
   run;
