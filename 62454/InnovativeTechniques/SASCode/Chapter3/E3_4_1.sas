* E3_4_1.sas
* 
* Interval multipliers;

title1 '3.4.1 Interval Multipliers';

data ExamSchedule;
   do visdt = '25may2009'd to '14jun2009'd;
      examdt_2 = intnx('week2',visdt,1);
      examdtx2 = intnx('week',visdt,2);
      output;
   end;
   format visdt examdt_2 examdtx2 date9.;
   run;

proc print data=examschedule;
   run;

