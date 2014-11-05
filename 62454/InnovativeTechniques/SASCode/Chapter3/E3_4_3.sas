* E3_4_3.sas
* 
* Interval Alignment;

title1 '3.4.3 Alignment Options';

data ExamSchedule;
   do visdt = '01jun2007'd to '10jun2007'd;
      next_d  = intnx('month',visdt,1);
      next_b  = intnx('month',visdt,1,'beginning');
      next_m  = intnx('month',visdt,1,'middle');
      next_e  = intnx('month',visdt,1,'end');
      next_s  = intnx('month',visdt,1,'same');
      output;
   end;
   format visdt next: date7.;
   run;

proc print data=examschedule;
   run;

* Using the MIDDLE option;
data _null_;
   mfeb= intnx('month','01jan2009'd, 1, 'm');
   leap= intnx('month','01jan2008'd, 1, 'm');
   mapr= intnx('month','01jan2008'd, 3, 'm');
   mmay= intnx('month','01jan2008'd, 4, 'm');
   put mfeb= leap= mapr= mmay=;
   format mfeb leap mapr mmay date9.;
   run;

*Advancing to illegal dates;
data _null_;
   leap = intnx('year', '29feb2008'd, 1, 's');
   short= intnx('month','31may2008'd, 1, 's');
   put leap= short=;
   format leap short date9.;
   run;
****************************
* Alignment for INTCK;
data check;
   start = '14sep2011'd; * the 14th was a Wednesday;
   do end = start to intnx('month',start,1,'s');
      weeks = intck('weeks',start,end);
      weeksc= intck('weeks',start,end,'c');
      weeksd= intck('weeks',start,end,'d');
      output check;
   end;
format start end date9.;
run;
proc print data=check;
run;
