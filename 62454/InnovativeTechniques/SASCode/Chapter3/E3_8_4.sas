* E3_8_4.sas
* Demonstrate what happens when there are two
* SET statements in the same DATA step.;

title1 '3.8.4 Double SET Statement Introduction';

data a;
do x = 1to 3;
output;
end;
run;
data b;
do y = 1 to 2;
output;
end;
run;

data new;
   set a;
   put 'after A ' x= y=;
   set b; 
   put 'after B ' x= y=;
   run;
proc print data =new;
run;
