* E1_3_4.sas
*
* Variable Length Records;

filename patlist "&path\data\patientlist.txt";
title '1.3.4a Varying Length Records';
data patients;
   infile patlist;
   input @2  sex $1. 
         @8  fname $10. 
         @18 lname $15.;
   run;
proc print data=patients;
   run;

title '1.3.4b Varying Length Records';
title2 'Using TRUNCOVER';
data patients(keep=sex fname lname);
   infile patlist truncover;
   input @2  sex $1. 
         @8  fname $10. 
         @18 lname $15.;
   run;
proc print data=patients;
   run;

* this example excluded from the book;
title '1.3.4c Varying Length Records';
title2 'Using the $VARYING Informat';
data patients(keep=sex fname lname);
   infile patlist length=len;
   input @;
   namewidth = len-17;
   input @2  sex $1. 
         @8  fname $10. 
         @18 lname $varying15. namewidth;
   run;
proc print data=patients;
   run;

* this example excluded from the book;
title '1.3.4d Varying Length Records';
title2 'Conditional Use of the $VARYING Informat';
data patients(keep=sex fname lname namewidth);
   length sex $1 fname $10 lname $15;
   infile patlist length=len;
   input @;
   if len lt 8 then do;
      input @2  sex $;
   end;
   else if len le 17 then do; 
      namewidth = len-7;
      input @2  sex $ 
            @8  fname $varying. namewidth;
   end;
   else do; 
      namewidth = len-17;
      input @2  sex $ 
            @8  fname $ 
            @18 lname $varying. namewidth;
   end;
   run;
proc print data=patients;
   run;


* this example excluded from the book;
title '1.3.4e Varying Width Fields';
title2 'Controlling Field Width with $VARYING';
data datacodes;
   length dataname $15;
   input @1 width 2. dataname $varying. width datacode :2.;
   datalines;
5 Demog43
2 AE65
13lab_chemistry32
   run;
proc print data=datacodes;
   run;
