* E3_4_4b.sas
* 
* Using INTNX with intervals;

title1 '3.4.4b Expanding Dates from Jan 1, 2007';

data monthly;
   do i = 0 to 11;
      date = intnx('month','01jan2007'd,i);
      midmon = intnx('month','01jan2007'd,i,'m');
      mon15 = intnx('month','01jan2007'd,i) + 14;
      output monthly;
   end;
   format date midmon mon15 date9.;
   run;

proc print data=monthly;
   run;
