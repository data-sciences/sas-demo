*E2_10_4.sas
*
*  Using the CALL MISSING routine;

title1 '2.10.4 Using CALL MISSING';
data annual(keep=year q: totsales);
   set sashelp.retail(keep=sales date year);
   by year;
   retain q1-q4 .;
   array annual {4} q1-q4;
   if first.year then call missing(of annual{*});
   annual{qtr(date)}=sales;
   if last.year then do;
      totsales=sum(of q:);
      output annual;
   end;
   run;

proc print data=annual;
run;
