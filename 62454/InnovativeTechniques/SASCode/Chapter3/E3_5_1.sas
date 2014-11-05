* E3_5_1.sas
* 
* PUT and INPUT;

title1 '3.5.1 PUT and INPUT Functions';
title2 'Numeric / Character Conversions';

data ae(drop=subjc);
   set advrpt.ae(rename=(subject=subjc));
   length subject 8;
   subject=subjc;
   run;

data ae(drop=subjc);
   set advrpt.ae(rename=(subject=subjc));
   subject = input(subjc,3.);
   run;

data conmed;
   set advrpt.conmed;
   startdt = input(medstdt_,mmddyy10.);
   run;
***********************************************************;
* Numeric to Character;
data conmed;
   set advrpt.conmed;
   worddt1 = put(medstdt,worddate18.);
   worddt2 = left(put(medstdt,worddate18.));
   worddt3 = put(medstdt,worddate18.-l);
   run;
proc print data=conmed;
   var subject medstdt worddt:;
   run;


***********************************************************;
* Using user defined formats;
title3 'User Defined Formats';
proc format;
value $ctonum
'yellow' = 1
'blue'   = 2
'red'    = 3;
run;
data colors;
color='yellow'; output colors;
color='blue'; output colors;
color='red';  output colors;
run; 
data codes;
set colors;
x = put(color,$ctonum.);
z = input(x,3.);
run;
proc contents data=codes;
run;
proc print data=codes;
run;
************************;
title3 'User Defined Formats';
proc format;
invalue ctonum
'yellow' = 1
'blue'   = 2
'red'    = 3;
run;
data colors;
color='yellow'; output colors;
color='blue'; output colors;
color='red';  output colors;
run; 
data codes;
set colors;
x = input(color,ctonum.);
run;
proc contents data=codes;
run;
proc print data=codes;
run;





***********************************************************;
title2 'Run time Formats';
* Using execution time versions;
data a;
   date = '07Oct2009'd;
   do i = 1 to 5;
      if mod(i,2)=0 then x = put(date,mmddyy10.);
      else x = put(date,date9.);
      output;
   end;
   run;
data b;
   date = '07Oct2009'd;
   do i = 1 to 5;
      if mod(i,2)=0 then fmt='mmddyy10.';
      else fmt = 'date9.';
      x = putn(date,fmt);
      output;
   end;
   run;

proc print data=b;
run;

title2 'Using INPUTN';
* converting dates using various formats;
data dates;
   input @4 cdate $10. @15 fmt $9.;
   ndate = inputn(cdate,fmt);
   format ndate date9.;
   datalines;
   01/13/2003 mmddyy10.
   13/01/2003 ddmmyy10.
   13jan2003  date9.
   13jan03    date7.
   13/01/03   ddmmyy8.
   01/02/03   mmddyy8.
   03/02/01   yymmdd8.
   run;
proc print data=dates;
   run;

%* Use PUTN to convert a date form;
%put &sysdate9;
%put "&sysdate9"d;
%put %sysfunc(putn("&sysdate9"d,6.));
%put %sysfunc(putn("&sysdate9"d,worddate18.));

%*******************************************;
%* Return the name and year of the previous month;
%macro lastmy;
%local prevdt tmon tyr;
%let prevdt = %sysfunc(intnx(month,%sysfunc(today()),-1));
%let tmon = %sysfunc(putn(&prevdt,monname9.));
%let tyr  = %sysfunc(year(&prevdt));
&tmon/&tyr
%mend lastmy;
                                                                        
* Write last month's month and year into a title;                      
TITLE2 "Counts for the Previous Month/Year (%lastmy)";
proc print data=sashelp.class;
run; 
