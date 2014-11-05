* E3_4_2.sas
* 
* Shift Operators;

title1 '3.4.2 Shift Operators';

data ExamSchedule;
   do visdt = '01jun2009'd to '15jun2009'd;
      day  = intnx('week',visdt,1);
      day1 = intnx('week.1',visdt,1);
      day2 = intnx('week.2',visdt,1);
      day3 = intnx('week.3',visdt,1);
      day4 = intnx('week.4',visdt,1);
      day5 = intnx('week.5',visdt,1);
      day6 = intnx('week.6',visdt,1);
      day7 = intnx('week.7',visdt,1);
      output;
   end;
   format visdt day: date7.;
   run;

proc print data=examschedule noobs;
   run;

