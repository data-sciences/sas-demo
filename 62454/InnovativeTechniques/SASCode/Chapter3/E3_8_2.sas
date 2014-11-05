* E3_8_2.sas
* 
* Using INDSNAME;

title1 '3.8.2 Using INDSNAME=';

* For demo purposes split the DEMOG data;
data boomer(keep=lname fname dob)
     others(keep=lname fname dob);
   set advrpt.demog(keep=lname fname dob);
   if 1945 le year(dob) le 1955 then output boomer;
   else output others;
   run;

data grouped1;
   set boomer(in=inboom)
       others(in=inoth);
   if inboom then group='BOOMER';
   else if inoth then group='OTHERS';
   run;

data grouped2;
   set boomer
       others indsname=dsn;
   length group $6;
   group=scan(dsn,2,'.');
   run;
