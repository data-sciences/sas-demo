* E2_3_1.sas
* 
* Using Formats for date validation;

title1 '2.3.1 Date Validation Using Formats';
title2 'Date Errors';

data visitdates;
   visit=1; v_date_ = '05/25/2004'; output;
   visit=2; v_date_ = '06/XX/2004'; output;
   run;
proc print data=visitdates;
   where input(v_date_,mmddyy10.) = .; 
   run;

******************************;
title2 'Using the ?? to suppress Error Messages';
data dateerrors;
   set visitdates;
   * ?? does not work in a WHERE;
   *where input(v_date_,?? mmddyy10.) eq .; 
   if input(v_date_,?? mmddyy10.) eq .;
   run; 
proc print data=dateerrors;
   run;

*********************************************
* Completing missing date elements;
title1 '2.3.1 Date Validation Using Formats';
title2 'Autocompletion of Missing Date Elements';

data quit_dates;
   subject=201; q_date_ = '05/25/1975'; output;
   subject=205; q_date_ = '10/XX/2001'; output;
   subject=208; q_date_ = 'XX/XX/1966'; output;
   run;
data Qdates(keep=subject q_date_ q_date);
   set quit_dates;
   format q_date date9.;
   q_date = input(q_date_,??mmddyy10.);
   if missing(q_date) then do;
      * Substitute missing day of month with 15;
      if substr(q_date_,4,2)='XX' then substr(q_date_,4,2)='15';
      q_date = input(q_date_,??mmddyy10.);
   end;
   if missing(q_date) then do;
      * Substitute missing month with 07;
      if substr(q_date_,1,2)='XX' then do;
         substr(q_date_,1,2)='07';
         * reset day of month also;
         substr(q_date_,4,2)='01';
      end;
      q_date = input(q_date_,??mmddyy10.);
   end;
   run;
proc print data=qdates;
   run;
*********************************************
* Display non-missing dates;
title1 '2.3.1 Selecting Non-Missing Dates';
proc print data=advrpt.demog;
   var lname fname dob death;
   *where death>0;
   *where death;
   *where death ne .;
   where death>.;
   *where ^missing(death);
   run;
*********************************;
data missdate;
   do death = .,.a,._,.z,.f;
      if death>. then put 'miss '  death=;
      if missing(death) then put 'using missing ' death=;
      output;
   end;
   run;
proc sort data=missdate;
   by death;
   run;
proc print data=missdate;
   run;
