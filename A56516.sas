 /*-------------------------------------------------------------------*/
 /*              SAS(r) Macro Programming Made Easy                   */
 /*                         by Michele Burlew                         */
 /*       Copyright(c) 1998 by SAS Institute Inc., Cary, NC, USA      */
 /*                   SAS Publications order # 56516                  */
 /*                        ISBN 1-58025-343-1                         */
 /*-------------------------------------------------------------------*/
 /*                                                                   */
 /* This material is provided "as is" by SAS Institute Inc.  There    */
 /* are no warranties, expressed or implied, as to merchantability or */
 /* fitness for a particular purpose regarding the materials or code  */
 /* contained herein. The Institute is not responsible for errors     */
 /* in this material as it now exists or will exist, nor does the     */
 /* Institute provide technical support for it.                       */
 /*                                                                   */
 /*-------------------------------------------------------------------*/
 /* Questions or problem reports concerning this material may be      */
 /* addressed to the author:                                          */
 /*                                                                   */
 /* SAS Institute Inc.                                                */
 /* Books by Users                                                    */
 /* Attn: Michele Burlew                                              */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  sasbbu@sas.com             */
 /* Use this for subject field: Comments for Michele Burlew           */
 /*                                                                   */
 /*-------------------------------------------------------------------*/
/**********************************************************************/
/*  Following are programs from SAS Macro Programming Made Easy       */
/**********************************************************************/


/**********************************************************************/
/*  Create the data set used throughout the book.                     */
/**********************************************************************/
data books.ytdsales;

  keep section--salepric;
  attrib section  length=$26 label='Section'
         saleid   length=8 label='Sale ID'
                  format=8.
         saleinit length=$3 label='Sales Person Initials'
         datesold length=4 label='Date Book Sold'
                  format=mmddyy8. informat=mmddyy8.
         title    length=$50 label='Title of Book'
         author   length=$50 label='First Author'
         publishr length=$50 label='Publisher'
         cost     length=8 label='Wholesale Cost'
                  format=dollar9.2
         listpric length=8 label='List Price'
                  format=dollar9.2
         salepric length=8 label='Sale Price'
                  format=dollar9.2;

  array jan{5} jan1-jan5 (105,40,110,60,85);
  array feb{5} feb1-feb5 (120,40,130,45,150);
  array mar{5} mar1-mar5 (115,60,175,75,145);
  array apr{5} apr1-apr5 (145,55,132,60,131);
  array may{5} may1-may5 (190,60,165,90,135);
  array jun{5} jun1-jun5 (160,56,168,84,143);
  array jul{5} jul1-jul5 (138,50,149,72,140);
  array aug{5} aug1-aug5 (139,40,153,68,142);
  array sep{5} sep1-sep5 (150,58,159,80,150);
  array oct{5} oct1-oct5 (157,52,163,83,155);
  array nov{5} nov1-nov5 (168,63,173,88,170);
  array dec{5} dec1-dec5 (190,75,200,95,210);

  array mos{60} jan1--dec5;

  array momax{12} momax1-momax12
                  (30,27,30,29,30,29,30,30,29,30,29,30);

  array sname{5} $ 26 ('Internet' 'Networks and Communication'
                       'Operating Systems'
                       'Programming Languages' 'Web Design');

  array prices{13} p1-p13
                 (15,18,19,22,24,28,29,32,35,39,42,41,76);

  do m=1 to 12;
    do i=1 to 5;
      section=sname{i};
      do j=1 to mos{(m-1)*5+i};
        day=round(momax{m}*uniform(3),1)+1;
        datesold=mdy(m,day,1998);
        title=trim(sname{i}) || ' Title ' || put(j,3.);
        pval=round(2*normal(3),1) + 7;
        if pval > 13 then pval=13;
        else if pval < 1 then pval=1;
        listpric=prices{pval} + .95;
        salepric=listpric;
        if mod(j,8)=0 then salepric=listpric*.9;
        if mod(j,17)=0 and mod(j,8) ne 0
          then salepric=listpric*.8;
        cost=.7*listpric;
        if mod(j,12)=0 then cost=.8*listpric;
        person=mod(day,3);
        if mod(day,12)=0 then person=1;
        if mod(day,20)=0 then person=2;
        if mod(day,15)=0 then person=0;
        if person=0 then saleinit='MJM';
        else if person=1 then saleinit='BLT';
        else if person=2 then saleinit='JMB';
        output;
      end;
    end;
  end;
run;



/**********************************************************************/
/*  CHAPTER 1 EXAMPLES                                                */
/**********************************************************************/

/**********************************************************************/
/*  Page 5:  Example for output in Figure 1.2                         */
/**********************************************************************/
%let repmonth=4;
%let repyear=1998;
%let repmword=%sysfunc(mdy(&repmonth,1,&repyear),monname9.);

data month&repmonth;
  set books.ytdsales;
  mosale=month(datesold);
  label mosale='Month of Sale';
run;
proc tabulate data=month&repmonth;
  title "Sales During &repmword &repyear";
  where mosale=&repmonth and year(datesold)=&repyear;
  class section;
  var salepric listpric cost;
  tables section all='**TOTAL**',
         (salepric listpric cost)*(n*f=4. sum*f=dollar9.2);
run;
proc gchart data=month&repmonth
           (where=(mosale < %eval(&repmonth+1) and
                  year(datesold)=&repyear));
  title "Sales Through &repmword &repyear";
  pie section / coutline=black percent=arrow
                sumvar=salepric noheading ;
run;
quit;

/**********************************************************************/
/* Page 11:  Example for output in Figure 1.4                         */
/**********************************************************************/
title "Sales Report";
title2 "As of &systime &sysday &sysdate";
title3 "Using SAS Version: &sysver";
proc means data=books.ytdsales n sum;
  var salepric;
run;

/**********************************************************************/
/* Page 12:  Example for output in Figure 1.5                         */
/**********************************************************************/
%macro daily;
  proc means data=books.ytdsales(where=(datesold=today()))
                  maxdec=2 sum;
    title "Daily Sales Report for &sysdate";
    class section;
    var salepric;
  run;
  %if &sysday=Friday %then %do;
     proc means data=books.ytdsales
          (where=(today()-6 le datesold le today()))
          sum maxdec=2;
       title "Weekly Sales Report Week Ending &sysdate";
       class section;
       var salepric;
     run;
  %end;
%mend daily;

%daily

/**********************************************************************/
/* Page 14:  Example of iterative processing                          */
/**********************************************************************/
%macro makesets;
  data
    %do i=1 %to 12;
      month&i
    %end;
    ;
    set books.ytdsales;
    mosale=month(datesold);
    if mosale=1 then output month1;
    %do i=2 %to 12;
      else if mosale=&i then output month&i;
    %end;
  run;
%mend makesets;

%makesets

/**********************************************************************/
/* Page 15:  Example for output in Figure 1.6                         */
/**********************************************************************/
data temp;
  set books.ytdsales end=lastobs;
  retain sumintwb 0;
  if section in ('Internet','Web Design') then
    sumintwb=sumintwb + salepric;
  if lastobs then
    call symput('INTWEBSL',put(sumintwb,dollar10.2));
run;
proc gchart data=temp;
  title "Internet and Web Design Sales: &intwebsl";
  title2 "As of &enddate";
  hbar section / sumvar=salepric;
  format salepric dollar10.2;
run;
quit;

/**********************************************************************/
/* Page 16:  Example for output in Figure 1.7                         */
/**********************************************************************/
%macro dsreport(dsname);
  title "Report on Data Set &dsname";

  %let dsid=%sysfunc(open(&dsname));

  %*----How many obs are in the data set?;
  %let nobs=%sysfunc(attrn(&dsid,nobs));

  %*----When was the data set created?;
  %let when = %sysfunc(putn(
                 %sysfunc(attrn(&dsid,crdte)),datetime9.));

  title2 "Num Obs: &nobs   Date Created: &when";

  proc means data=&dsname sum maxdec=2;
    class section;
    var salepric;
  run;
%mend dsreport;

%dsreport(books.ytdsales)

/**********************************************************************/
/*  CHAPTER 3 EXAMPLES                                                */
/**********************************************************************/

/**********************************************************************/
/* Page 52:  Example for output in Figure 3.2                         */
/**********************************************************************/
data web;
  set books.ytdsales;
  if section='Web Design' and datesold > "&sysdate"d-6;
run;
proc print data=web;
title "Web Design Titles Sold in the Past Week";
title2 "Report Date: &sysday &sysdate &systime";
footnote1 "Data Set Used: &syslast  SAS Version: &sysver";
  var title datesold salepric;
run;


/**********************************************************************/
/* Page 53:  Example of using the %LET statement                      */
/**********************************************************************/
%let nocalc=53*21 + 100.1;
%let value1=982;
%let value2=813;
%let result=&value1 + &value2;
%let reptext=This report is for ***  Department XYZ  ***;
%let region=Region 3;
%let text=Sales Report;
%let moretext="Sales Report";
%let reptitle=&text &region;
%let reptitl2=&moretext &region;
%let sentence=      This one started with leading blanks.;
%let chars=Symbols: !@#$%^&*;
%let novalue=;
%let holdvars=varnames;
%let &holdvars=title author datesold;


/**********************************************************************/
/* Page 56:  Example of placing text before a macro variable reference*/
/**********************************************************************/
%let mosold=4;
%let level=25;

data book&mosold&level;
  set books.ytdsales(where=(month(datesold)=&mosold));

  attrib over&level length=$3 label="Cost > $&level";

  if cost > &level then over&level='YES';
  else over&level='NO';
run;
proc freq data=book&mosold&level;
title "Frequency Count of Books Sold During Month &mosold";
title2 "Grouped by Cost Over $&level";
  tables over&level;
run;


/**********************************************************************/
/* Page 61:  Example of resolving two ampersands                      */
/**********************************************************************/
%let section1=Internet;
%let section2=Networking and Communication;
%let section3=Operating Systems;
%let section4=Programming Languages;
%let section5=Web Design;

*----Look for section number defined by macro var n;
%let n=3;
proc means data=books.ytdsales;
  title "Sales for Section: &&section&n";
  where section="&&section&n";
  var salepric;
run;

/**********************************************************************/
/* Page 64:  Example of resolving multiple ampersands                 */
/**********************************************************************/
options symbolgen;
%let section1=Internet;
%let section2=Networking and Communication;
%let section3=Operating Systems;
%let section4=Programming Languages;
%let section5=Web Design;
%let dept1=Computer;
%let dept2=Reference;
%let dept3=Science;

%let n=3;
%let wherevar=section;

proc means data=books.ytdsales;
  title "Sales for &wherevar: &&&wherevar&n";
  where &wherevar="&&&wherevar&n";
  var salepric;
run;


/**********************************************************************/
/*  CHAPTER 4 EXAMPLES                                                */
/**********************************************************************/

/**********************************************************************/
/* Page 72:  Example for output in Figure 4.3                         */
/**********************************************************************/
%macro sales;
  title "Sales Report for Week Ending &sysdate";
  proc gchart data=temp;
    where today()-6 <= datesold <= today();
    hbar section / sumvar=profit type=sum;
  run;
%mend sales;
data temp;
  set books.ytdsales;
  attrib profit label='Sale Price-Cost' format=dollar8.2;
  profit=salepric-cost;
run;

%sales

/**********************************************************************/
/* Page 76: Example of defining a macro program with positional       */
/* parameters                                                         */
/**********************************************************************/
options mprint mlogic;

%macro listparm(start,stop,opts);
  title "Books Sold by Section Between &start and &stop";
  proc means data=books.ytdsales &opts;
    where "&start"d le datesold le "&stop"d;
    class section;
    var salepric;
  run;
%mend listparm;

*----First call to LISTPARM, all 3 parameters specified;
%listparm(01JUN1998,15JUN1998,n sum)

*----Second call to LISTPARM, first 2 parameters specifed and;
*----third parameter is null;
%listparm(01SEP1998,15SEP1998,)

/**********************************************************************/
/*Page 79: Example of defining a macro program with keyword parameters*/
/**********************************************************************/
options mprint mlogic;

%macro keyparm(start=01JAN1998,stop=31DEC1998,
               opts=N SUM MIN MAX);
  title "Books Sold by Section Between &start and &stop";
  proc means data=books.ytdsales &opts;
    where "&start"d le datesold le "&stop"d;
    class section;
    var salepric;
  run;
%mend keyparm;

*----First call to KEYPARM: specify all keyword parameters;
%keyparm(start=01JUN1998,stop=15JUN1998,opts=n sum)

*----Second call to KEYPARM: specify start and stop,;
*----opts is null: should see default stats for PROC MEANS;
%keyparm(start=01SEP1998,stop=15SEP1998,opts=)

*----Third call to KEYPARM: use defaults for start and stop,;
*----specify opts;
%keyparm(opts=n sum)

/**********************************************************************/
/*  Page 82: Example of defining a macro program with positional      */
/* parameters and keyword parameters.                                 */
/**********************************************************************/
options mprint mlogic;

%macro mixdparm(stats,othropts,start=01JAN1998,stop=31DEC1998);
  title "Books Sold by Section Between &start and &stop";
  proc means data=books.ytdsales &stats &othropts;
    where "&start"d le datesold le "&stop"d;
    class section;
    var salepric;
  run;
%mend mixdparm;

%mixdparm(,missing,start=01DEC1998)


/**********************************************************************/
/*  CHAPTER 5 EXAMPLES                                                */
/**********************************************************************/

/**********************************************************************/
/*  Page 87:  Example for output in Figure 5.2                        */
/**********************************************************************/
options symbolgen mprint;

%let subset=Internet;

%macro makeds;
  data temp;
    set books.ytdsales(where=(section="&subset"));
    attrib mosold label='Month of Sale';
    mosold=month(datesold);
  run;
%mend makeds;

%makeds

proc tabulate data=temp;
title "Book Sales as of &sysdate";
  class mosold;
  var salepric listpric;
  tables mosold all,
         (salepric listpric)*(n*f=6. sum*f=dollar12.2) /
         box="Section: &subset";
  keylabel all='** Total **';
run;


/**********************************************************************/
/* Page 90:  Example for output in Figure 5.4                         */
/**********************************************************************/
options symbolgen mprint;

%macro makeds(subset);
  data temp;
    set books.ytdsales(where=(section="&subset"));
    attrib mosold label='Month of Sale';
    mosold=month(datesold);
  run;
%mend makeds;

%makeds(Internet)

proc tabulate data=temp;
title "Book Sales as of &sysdate";
  class mosold;
  var salepric listpric;
  tables mosold all,
         (salepric listpric)*(n*f=6. sum*f=dollar12.2) /
         box="Section: &subset";
  keylabel all='** Total **';
run;


/**********************************************************************/
/* Page 94:  Example corresponding to Figure 5.6                      */
/**********************************************************************/
options symbolgen mprint;

%macro makeds(subset);
  %global glsubset;
  %let glsubset=&subset;

  data temp;
    set books.ytdsales(where=(section="&subset"));
    attrib mosold label='Month of Sale';
    mosold=month(datesold);
  run;
%mend makeds;

%makeds(Internet)

proc tabulate data=temp;
title "Book Sales as of &sysdate";
  class mosold;
  var salepric listpric;
  tables mosold all,
         (salepric listpric)*(n*f=6. sum*f=dollar12.2) /
         box="Section: &glsubset";
  keylabel all='** Total **';
run;

/**********************************************************************/
/* Page 100:  Example for output in Figure 5.9                        */
/**********************************************************************/
options symbolgen mprint;

%global subset;
%let subset=Internet;

%macro loclmvar;
  %local subset;
  %let subset=Web Design;

  proc means data=books.ytdsales n sum maxdec=2;
  title "Book Sales as of &sysdate";
  title2 "Uses LOCAL SUBSET macro variable: &subset";
    where section="&subset";
    var salepric;
  run;
%mend loclmvar;

%loclmvar

proc means data=books.ytdsales n sum maxdec=2;
title "Book Sales as of &sysdate";
title2 "Uses GLOBAL SUBSET macro variable: &subset";
  where section="&subset";
  var salepric;
run;


/**********************************************************************/
/*  CHAPTER 6 EXAMPLES                                                */
/**********************************************************************/

/**********************************************************************/
/* Page 122  Example of %SUBSTR function                              */
/**********************************************************************/
proc means data=book.ytdsales;
  title "Sales for %substr(&sysdate,3,3) through &sysdate";
  where "01%substr(&sysdate,3)"d le datesold le "&sysdate"d;
  class section;
  var salepric;
run;

/**********************************************************************/
/* Page 122  Example of %SCAN function                                */
/**********************************************************************/
%let months=January February March April May June;
%let repmonth=3;

proc print data=books.ytdsales;
  title "Sales Report for %scan(&months,&repmonth)";
  where month(datesold)=&repmonth;
  var title author salepric;
run;

/**********************************************************************/
/* Page 123  Example of %UPCASE function                              */
/**********************************************************************/
%macro listtext(keytext);
  %let keytext=%upcase(&keytext);
  proc print data=books.ytdsales;
  title "Book Titles Sold Containing Text String &keytext";
    where index(upcase(title),"&keytext") > 0;
    var title author salepric;
  run;
%mend;

%listtext(web)

/**********************************************************************/
/* Page 127  Example of %SYSFUNC function                             */
/**********************************************************************/
title
  "Sales for %sysfunc(date(),monname.) %sysfunc(date(),year.)";

/**********************************************************************/
/* Page 127  Example of %SYSFUNC function                             */
/**********************************************************************/
%macro getopt(whatopt);
  %let optvalue=%sysfunc(getoption(&whatopt));
  %put Option &whatopt = &optvalue;
%mend getopt;

%getopt(ps)
%getopt(ls)
%getopt(date)
%getopt(symbolgen)
%getopt(compress)

/**********************************************************************/
/* Page 128  Example for output in Figure 6.1                         */
/**********************************************************************/
%let dsid=%sysfunc(open(books.ytdsales));
%let nobs=%sysfunc(attrn(&dsid,nobs));
%let rc=%sysfunc(close(&dsid));

proc means data=books.ytdsales sum maxdec=2;
  title "Year-to-Date Sales Report: &sysdate";
  title2 "Number of Books Sold: &nobs";
  class section;
  var salepric;
run;

/**********************************************************************/
/* Page 135  Example of using logical expressions                     */
/**********************************************************************/
%macro compares(value1,value2);
  %put COMPARISON 1:;
  %if &value1 ne &value2 %then
    %put &value1 is not equal to &value2..;
  %else %put &value1 equals &value2..;

  %put COMPARISON 2:;
  %if &value1 > &value2 %then
    %put &value1 is greater than &value2..;
  %else %if &value1 < &value2 %then
    %put &value1 is less than &value2..;
  %else %put &value1 equals &value2..;

  %put COMPARISON 3:;
  %let result=%eval(&value1 > &value2);
  %if &result=1 %then
    %put EVAL result of &value1 > &value2 is TRUE.;
  %else %put EVAL result of &value1 > &value2 is FALSE.;

  %put COMPARISON 4:;
  %let result=%sysevalf(&value1 > &value2);
  %if &result=1 %then
    %put SYSEVALF result of &value1 > &value2 is TRUE.;
  %else %put SYSEVALF result of &value1 > &value2 is FALSE.;

%mend compares;

*----First call to COMPARES;
%compares(3,4)

*----Second call to COMPARES;
%compares(3.0,3)

*----Third call to COMPARES;
%compares(X,x)

/**********************************************************************/
/* Page 127  Example of selecting SAS steps with macro              */  
/* language statements                                                */
/**********************************************************************/
%macro reports(reptype,repmonth);
  %let lblmonth=
    %sysfunc(mdy(&repmonth,1,%substr(&sysdate,6,2)),monname.);

  %*----Begin summary report section;
  %if %upcase(&reptype)=SUMMARY %then %do;
    %*----Do summary report for report month;
    proc tabulate data=books.ytdsales;
      title "Sales for &lblmonth";
      where month(datesold)=&repmonth;
      class section;
      var listpric salepric;
      tables section,
        (listpric salepric)*(n*f=6. sum*f=dollar12.2);
    run;
    %*----If end of quarter, also do summary report for qtr;
    %if &repmonth=3 or &repmonth=6 or &repmonth=9
        or &repmonth=12 %then %do;
      %let qtrstart=%eval(&repmonth-2);

      %let strtmo=
     %sysfunc(mdy(&qtrstart,1,%substr(&sysdate,6,2)),monname.);

      proc tabulate data=books.ytdsales;
        title "Sales for Quarter from &strtmo to &lblmonth";
        where &strtmo le datesold le &repmonth;
        class section;
        var listpric salepric;
        tables section,
          (listpric salepric)*(n*f=6. sum*f=dollar12.2);
      run;
     %end;
  %end;
  %*----End summary report section;
  %*----Begin detail report section;
  %else %if %upcase(&reptype)=DETAIL %then %do;
    %*----Do detail report for month;
    proc print data=books.ytdsales;
      where month(datesold)=&repmonth;
      var title cost listpric salepric;
      sum cost listpric salepric;
    run;
  %end;
  %*----End detail report section;
%mend reports;

*----First call to REPORTS does a Summary report for September;
%reports(Summary,9)

*----Second call to REPORTS does a Detail report for October;
%reports(Detail,10)

/**********************************************************************/
/* Page 138  Example of selecting SAS statements with                 */
/* %IF-%THEN/%ELSE statements                                         */
/**********************************************************************/
%macro sales(classvar);
  title "Sales Year-to-Date";
  proc tabulate data=books.ytdsales;

    %*----When there is a classification variable, issue a;
    %*----CLASS statement;
    %if &classvar ne %then %do;
      class &classvar;
    %end;

    var listpric salepric;

    tables

    %*----When there is a classification variable, add the;
    %*----classification variable to the TABLES statement;
    %if &classvar ne %then %do;
       &classvar all,
    %end;

    (listpric salepric)*(n*f=5. sum*f=dollar12.2);
  run;

  %*----When there is a classification variable, call;
  %*----PROC SORT;
  %if &classvar ne %then %do;
    proc sort data=books.ytdsales;
      by &classvar;
    run;
  %end;

  %*----When there is a classification variable, issue a;
  %*----BY statement;
  proc univariate data=books.ytdsales;
    %if &classvar ne %then %do;
      by &classvar;
    %end;
    var listpric salepric;
  run;
%mend sales;

*----First call to SALES processes the data by section;
%sales(section)

*----Second call to SALES summarizes the data overall;
%sales()

/**********************************************************************/
/* Page 141  Example of iterative %DO                                 */
/**********************************************************************/
%macro multrep(strtyear,stopyear);
  %do yrvalue=&strtyear %to &stopyear;
    title "Sales Report for &yrvalue";
    proc means data=sales.year&yrvalue;
      class section;
      var cost listpric salepric;
    run;
    proc gchart data=sales.year&yrvalue;
      hbar section / sumvar=salepric type=sum;
    run;
    quit;
  %end;
%mend multrep;

*----Produce 3 sets of reports: one for 1997, one for 1998,
*----and one for 1999;
%multrep(1997,1999)


/**********************************************************************/
/* Page 142  Example of iterative %DO                                 */
/**********************************************************************/
%macro multchrt(strtyear,stopyear);
  data allyears;
    set
    %do yrvalue=&strtyear %to &stopyear;
      sales.year&yrvalue
    %end;
    ;
  run;

  %let yrstrng=;
  %do yrvalue=&strtyear %to &stopyear;
    %let yrstrng=&yrstrng &i;
  %end;
  proc gchart data=allyears;
    title "Charts Analyze Data for: &yrstrng";
    hbar section / sumvar=salepric type=sum;
  run;
%mend multchrt;

*----Concatenate three data sets: one from 1997, one from 1998,
*----and one from 1999;
%multchrt(1997,1999)



/**********************************************************************/
/* Page 143  Example of %DO %UNTIL                                    */
/**********************************************************************/
%macro mosales(months);
  %let i=1;
  %do %until (%scan(&months,&i) eq );
    %let repmonth=%scan(&months,&i);
    proc means data=books.ytdsales n sum;
      %if &repmonth ne %then %do;
        title "Sales during month &repmonth";
        where month(datesold)=&repmonth;
      %end;
      %else %do;
        title "Overall Sales";
      %end;
      class section;
      var salepric;
    run;
    %let i=%eval(&i+1);
  %end;
%mend;

*----First call to MOSALES: produce stats for March, May, and
*----October;
%mosales(3 5 10)

*----Second call to MOSALES: produce overall stats;
%mosales()

/**********************************************************************/
/* Page 145  Example of %DO %                                         */
/**********************************************************************/
%macro staff(reps,repmonth);
  %let i=1;
  %do %while (%scan(&reps,&i) ne );
    %let inits=%scan(&reps,&i);
    proc means data=books.ytdsales n sum;
      title "Sales for &inits during month &repmonth";
      where saleinit="&inits" and month(datesold)=&repmonth;
      class section;
      var salepric;
    run;
    %let i=%eval(&i+1);
  %end;
%mend;

%staff(MJM BLT JMB,5)

/**********************************************************************/
/* Page 146  Example of %GOTO                                         */
/**********************************************************************/
%macro detail(dsname,listvars);
  %let foundit=%sysfunc(exist(&dsname));
  %if &foundit le 0 %then %goto nodata;

  title "PROC PRINT of &dsname";
  proc print data=&dsname;
    var &listvars;
  run;
  %goto finished;

  %nodata:
    %put **** Data set &dsname not found. ****;
    proc datasets library=books details;
    run;
    quit;

  %finished:
%mend;

*----First call to DETAIL, data set exists;
%detail(books.ytdsales,saledate title salepric)

*----Second call to DETAIL, data set does not exist;
%detail(books.ydtsales,saledate title salepric)

/**********************************************************************/
/*  CHAPTER 7 EXAMPLES                                                */
/**********************************************************************/

/**********************************************************************/
/* Page 161  Example for output in Figure 7.1                         */
/**********************************************************************/
%let webfctr=1.20;
%let intfctr=1.35;

data temp;
  set books.ytdsales(where=(
     section in ('Web Design', 'Internet'));
  if section='Web Design' then costfctr=symget('webfctr');
  else if section='Internet' then costfctr=symget('intfctr');
  newprice=costfctr*cost;
run;
proc print data=temp;
  title "Prices based on COSTFCTR";
  var section cost costfctr newpric;
  format newpric dollar8.2;
run;

/**********************************************************************/
/* Page 162  Example for output in Figure 7.2                         */
/**********************************************************************/
%let internet=1.25;
%let networks=1.20;
%let operatin=1.30;
%let programm=1.28;
%let webdesig=1.33;

data temp;
  set books.ytdsales;
  costsect=substr(compress(section),1,8);
  costfctr=symget(costsect);
  newprice=cost*costfctr;
run;
proc print data=temp;
  title "Prices based on COSTFCTR";
  var section costsect cost costfctr newprice;
  format newprice dollar8.2;
run;

/**********************************************************************/
/* Page 164  Example for output in Figure 7.3                         */
/**********************************************************************/
%let adj1997=1.10;
%let adj1998=1.15;
%let adj1999=1.18;
%let adj2000=1.05;

proc means data=books.ytdsales sum noprint nway;
  class section;
  var salepric;
  output out=sumsales sum=salepric;
run;
data temp;
  set sumsales;

  array adj{4} adj1997-adj2000;
  array sale{4} sale1997-sale2000;
  do year=1997 to 2000;
    idx=year-1996;
    adj{idx}=symget('adj' || put(year,4.));
    sale{idx}=salepric*adj{idx};
  end;
run;
proc print data=temp;
  title 'Adjusted Sales';
  var section salepric adj1997 sale1997 adj1998 sale1998
                       adj1999 sale1999 adj2000 sale2000;
  format sale1997-sale2000 dollar10.2;
run;

/**********************************************************************/
/* Page 166  Example of executing CALL SYMPUT multiple times          */
/**********************************************************************/
data books;
  input title $ 1-40;
  call symput('booktitl',trim(title));
cards;
Wonderful Web Pages
Easy Networks
Jiffy Java
Web Sites of the Rich and Famous
;
%put The value of macro variable BOOKTITL is &booktitl..;

/**********************************************************************/
/* Page 167  Example of creating several macro variables              */
/* with CALL SYMPUT                                                   */
/**********************************************************************/
proc freq data=books.ytdsales noprint;
   tables section / out=sectname;
run;
data _null_;
  set sectname;
  call symput('name' || put(_n_,1.),section);
  call symput('n' || put(_n_,1.),count);
run;

%put _user_;

/**********************************************************************/
/* Page 171  Example of using CALL EXECUTE to conditionally           */
/* call macro program                                                 */
/**********************************************************************/
%macro rephigh(section);
  proc report data=books.ytdsales headline center nowindows;
    where section="&section";
    column  ( title n salepric );

    define  title / group spacing=2   left "Title of Book" ;
    define  n / width=6   spacing=2   right "n" ;
    define  salepric / sum format= dollar9.2 width=9 spacing=2
    right "Sale Price" ;
  run;
%mend;

proc means data=books.ytdsales;
  class section;
  var salepric;
  output out=sectsale sum=totlsale;
run;

data _null_;
  set sectsale;

  if totlsale > 10000 then
    call execute('%rephigh(' || section || ')');
run;

/**********************************************************************/
/* Page 172  Example of using CALL EXECUTE to select the macro        */
/* program to call                                                    */
/**********************************************************************/
%macro highrept(Section);
   title "Section &section with sales > $10000";
   proc means data=books.ytdsales n sum;
     class saleinit;
     where section="&section";
     var salepric;
   run;
%mend;
%macro lowrept(section);
   title "Section &section with sales < $5000";
   proc print data=books.ytdsales;
     where section="&section";
     var title salepric;
   run;
%mend;
proc means data=books.ytdsales noprint sum nway;
  class section;
  var salepric;
  output out=sectsale sum=totlsect;
run;

data _null_;
  set sectsale;
  if totlsect < 5000 then
    call execute('%lowrept(' || section || ')');
  else if totlsect > 10000 then
    call execute('%highrept(' || section || ')');
run;

/**********************************************************************/
/* Page 174  Example for output in Figure 7.6                         */
/**********************************************************************/
data temp;
  length section $ 40;
  call symput('sectmvar','Web Design');
  section=resolve('&sectmvar');
  put section=;
run;
proc print data=temp;
  title 'Data Set TEMP';
  title2 'Macro variable SECTMVAR can be referenced in';
  title3 'the same DATA step it was created with RESOLVE';
run;

/**********************************************************************/
/* Page 176  Example of the INTO clause in PROC SQL                   */
/**********************************************************************/
proc sql;
  select sum(salepric),count(salepric)
    into :totsales,:nsold
    from books.ytdsales;
quit;
%put &totsales &nsold;

/**********************************************************************/
/* Page 176  Example of the INTO clause in PROC SQL                   */
/**********************************************************************/
proc sql;
  select section,sum(salepric)
  into :sect1 - :sect5, :sale1 - :sale5
  from books.ytdsales
  group by section;
quit;
%put &sect1 &sale1;
%put &sect2 &sale2;
%put &sect3 &sale3;
%put &sect4 &sale4;
%put &sect5 &sale5;

/**********************************************************************/
/* Page 176  Example of the INTO clause in PROC SQL                   */
/**********************************************************************/
proc sql;
  select unique(section)
  into :allsect separated by ','
  from books.ytdsales
  order by section;
quit;
%put &allsect;

/**********************************************************************/
/* Page 178  Example of the SQLOBS macro variable                     */
/**********************************************************************/
proc sql;
  select unique(section)
  from books.ytdsales
  order by section;
  select unique(section)
  into :sect1 - :sect&sqlobs
  from books.ytdsales
  order by section;
quit;

%macro listsect;
  %put Total number of sections: &sqlobs..;
  %do i=1 %to &sqlobs;
    %put Section &i: &&sect&i;
  %end;
%mend;

%listsect


/**********************************************************************/
/*  CHAPTER 9 EXAMPLES                                                */
/**********************************************************************/

/**********************************************************************/
/* Page 199  Example for output in Figure 9.1                         */
/**********************************************************************/
*----REPORT A;
options pageno=1;
title "Sales Report";
title2 "01JAN1998 through 13NOV1998";
data temp;
  set books.ytdsales(where=
                   ('01jan1998'd le datesold le '13nov1998'd));
  mosale=month(datesold);
  profit=salepric-cost;
  label profit='Profit'
        mosale='Month of Sale';
run;
proc tabulate data=temp;
  var cost listpric salepric profit;
  tables n*f=6.
         (cost listpric salepric profit)*sum*f=dollar10.2;
  keylabel all='Total Sales'
           n='Titles Sold';
run;

/**********************************************************************/
/* Page 200  Example for output in Figure 9.2                         */
/**********************************************************************/
*----REPORT B;
options pageno=1;
title "Sales Report";
title2 "01JAN1998 through 31MAR1998";
data temp;
  set books.ytdsales(where=
                   ('01jan1998'd le datesold le '31mar1998'd));
  mosale=month(datesold);
  profit=salepric-cost;
  label profit='Profit'
        mosale='Month of Sale';
run;
proc tabulate data=temp;
  title3 "Sales for Quarter";
  class section;
  var salepric profit;
  tables section all,
    n*f=6. (salepric profit)*sum*f=dollar10.2;
  keylabel all='Total Sales'
           n='Titles Sold';
run;
proc gchart data=temp;
  title3 "Sales for Quarter";
  pie section / type=sum sumvar=salepric
                coutline=black percent=arrow;
  run;
  pie section / type=sum sumvar=profit
                coutline=black percent=arrow;
  run;
quit;

/**********************************************************************/
/* Page 203  Example for output in Figure 9.3                         */
/**********************************************************************/
*----REPORT C;
options pageno=1;
title "Sales Report";
title2 "01JAN1998 through 24NOV1998";
data temp;
  set books.ytdsales(where=
                   ('01jan1998'd le datesold le '24nov1998'd));
  mosale=month(datesold);
  profit=salepric-cost;
  label profit='Profit'
        mosale='Month of Sale'          saleinit='Inits';
run;
proc tabulate data=temp;
  class section saleinit;
  var cost listpric salepric profit;
  tables section*(saleinit all) all,
    n*f=6. (cost listpric salepric profit)*sum*f=dollar10.2;
  keylabel all='Total Sales'
           n='Titles Sold';
run;


/**********************************************************************/
/* Page 206  Example for Report A with step 2 modifications           */
/**********************************************************************/
*----REPORT A;
%let repyear=1998;
%let start=01Jan&repyear;
%let stop=13Nov&repyear;
%let vars=cost listpric salepric profit;

options pageno=1 symbolgen;

title "Sales Report";
title2 "&start through &stop";
data temp;
  set books.ytdsales(where=
      ("&start"d le datesold le "&stop"d));
  mosale=month(datesold);
  profit=salepric-cost;
  label profit='Profit'
        mosale='Month of Sale';
run;
proc tabulate data=temp;
  var &vars;
  tables n*f=6.
         (&vars)*sum*f=dollar10.2;
  keylabel all='Total Sales'
           n='Titles Sold';
run;

/**********************************************************************/
/* Page 209  Example for Report B with step 2 modifications           */
/**********************************************************************/
*----Report B;
%let repyear=1998;
%let start=01Jan&repyear;
%let stop=31Mar&repyear;

%let classvar=section;
%let vars=salepric profit;

options pageno=1 symbolgen;

title "Sales Report";
title2 "&start through &stop";
data temp;
  set books.ytdsales(where=
      ("&start"d le datesold le "&stop"d));
  mosale=month(datesold);
  profit=salepric-cost;
  label profit='Profit'
        mosale='Month of Sale';
run;
proc tabulate data=temp;
  title3 "Sales for Quarter";
  class &classvar;
  var &vars;
  tables &classvar all,
    n*f=6. (&vars)*sum*f=dollar10.2;
  keylabel all='Total Sales'
           n='Titles Sold';
run;
proc gchart data=temp;
  title3 "Sales for Quarter";
  pie &classvar / type=sum sumvar=%scan(&vars,1)
                  coutline=black percent=arrow;
  run;
  pie &classvar / type=sum sumvar=%scan(&vars,2)
                  coutline=black percent=arrow;
  run;
quit;

/**********************************************************************/
/* Page 211  Example for Report C with step 2 modifications           */
/**********************************************************************/
*----REPORT C;
%let repyear=1998;
%let start=01Jan&repyear;
%let stop=24Nov&repyear;

%let classvar=section saleinit;
%let vars=cost listpric salepric profit;

options pageno=1 symbolgen;

title "Sales Report";
title2 "&start through &stop";
data temp;
  set books.ytdsales(where=
     ("&start"d le datesold le "&stop"d));
  mosale=month(datesold);
  profit=salepric-cost;
  label profit='Profit'
        mosale='Month of Sale';
run;
proc tabulate data=temp;
  class &classvar;
  var &vars;
  tables %scan(&classvar,1)*
    (%substr(%index(&vars,%scan(&classvar,2))) all) all,
     n*f=6. (&vars)*sum*f=dollar10.2;
  keylabel all='Total Sales'
           n='Titles Sold';
run;

/**********************************************************************/
/* Page 212  Example for Report A with step 3 modifications           */
/**********************************************************************/
options symbolgen mprint;

%macro reporta(repyear=,start=01JAN,stop=31DEC,
               vars=cost listpric salepric profit);
  options pageno=1;

  %let start=&start&repyear;
  %let stop=&stop&repyear;

  title "Sales Report";
  title2 "&start through &stop";
  data temp;
    set books.ytdsales(where=
       ("&start"d le datesold le "&stop"d));
    mosale=month(datesold);
    profit=salepric-cost;
    label profit='Profit'
          mosale='Month of Sale';
  run;
  proc tabulate data=temp;
    var &vars;
    tables n*f=6.
           (&vars)*sum*f=dollar10.2;
    keylabel all='Total Sales'
             n='Titles Sold';
  run;
%mend reporta;

%reporta(repyear=1998,stop=13NOV)

/**********************************************************************/
/* Page 212  Example for Report B with step 3 modifications           */
/**********************************************************************/
options symbolgen mprint;

%macro reportb(repyear=,start=01JAN,stop=31DEC,
               classvar=,vars=);
  options pageno=1;

  %let start=&start&repyear;
  %let stop=&stop&repyear;

  title "Sales Report";
  title2 "&start through &stop";
  data temp;
    set books.ytdsales(where=
       ("&start"d le datesold le &stop"d));
    mosale=month(datesold);
    profit=salepric-cost;
    label profit='Profit'
          mosale='Month of Sale';
  run;
  proc tabulate data=temp;
    title3 "Sales for Quarter";
    class &classvar;
    var &vars;
    tables &classvar all,
      n*f=6. (&vars)*sum*f=dollar10.2;
    keylabel all='Total Sales'
             n='Titles Sold';
  run;
  proc gchart data=temp;
     title3 "Sales for Quarter";
     pie &classvar / type=sum sumvar=%scan(&vars,1)
                     coutline=black percent=arrow;
     run;
     pie &classvar / type=sum sumvar=%scan(&vars,2)
                     coutline=black percent=arrow;
     run;
  quit;
%mend reportb;

%reportb(repyear=1998,stop=31Mar,classvar=section,
         vars=salepric profit)

/**********************************************************************/
/* Page 212  Example for Report C with step 3 modifications           */
/**********************************************************************/
options symbolgen mprint;

%macro reportc(repyear=,start=01JAN,stop=31DEC,
               classvar=,vars=cost listpric salepric profit);
  options pageno=1;

  %let start=&start&repyear;
  %let stop=&stop&repyear;

  title "Sales Report";
  title2 "&start through &stop";
  data temp;
    set books.ytdsales(where=
       ("&start"d le datesold le "&stop"d));
    mosale=month(datesold);
    profit=salepric-cost;
    label profit='Profit'
          mosale='Month of Sale'
          saleinit='Inits';
  run;
  proc tabulate data=temp;
    class &classvar;
    var &vars;
    tables %scan(&classvar,1)*
           (%scan(&classvar,2) all) all,
           n*f=6. (&vars)*sum*f=dollar10.2;
    keylabel all='Total Sales'
             n='Titles Sold';
  run;
%mend reportc;

%reportc(repyear=1998,stop=24NOV,classvar=section saleinit)

/**********************************************************************/
/* Page 212  Macro program for output in Figures 9.4, 9.5, and 9.6    */
/**********************************************************************/
options symbolgen mprint logic;

%macro report(repyear=,start=01JAN,stop=31DEC,
              classvar=,vars=cost listpric salepric profit);

  options pageno=1;

  %*----Check if a value was specified for report year.
        If no value specified,use current year;
  %if &repyear= %then %let repyear=
                %sysfunc(year(%sysfunc(today())));
  %*----Check if stop date specified.  If null, use
        current date as stop date;
  %if &stop= %then %let stop=%substr(&sysdate,1,5);

  %let start=&start&repyear;
  %let stop=&stop&repyear;

  title "Sales Report";
  title2 "&start through &stop";
  data temp;
    set books.ytdsales(where=
       ("&start"d le datesold le "&stop"d));
    mosale=month(datesold);
    profit=salepric-cost;
    label profit='Profit'
          mosale='Month of Sale'
          saleinit='Inits';
  run;
  proc tabulate data=temp;
    %*----Only submit a CLASS statement if there is a
         classification variable;
    %if &classvar ne %then %do;
       class &classvar;
    %end;
    var &vars;
    tables
      %if &classvar ne %then %do;
        %*---Determine leftmost row dimension variable;
        %let mainclas=%scan(&classvar,1);
        &mainclas
        %if %length(&mainclas) < %length(&classvar) %then %do;
          %*----If more than one classification variable, nest
                remaining classification variables under the
                first;
          %*----Use the substring function to extract
                classification variables after the first;
          %let pos2=%index(&classvar,%scan(&classvar,2));

          %*----Add the rest of the classification vars;
          * ( %substr(&classvar,&pos2) all)

        %end;
        all,
      %end;
      n*f=6. (&vars)*sum*f=dollar10.2;
      keylabel all='Total Sales'
               n='Titles Sold';
  run;

  %*----Check if date range is for a quarter or year;
  %let strtmody=%upcase(%substr(&start,1,5));
  %let stopmody=%upcase(%substr(&stop,1,5));
  %if (&strtmody=01JAN and &stopmody=31MAR) or
      (&strtmody=01APR and &stopmody=30JUN) or
      (&strtmody=01JUL and &stopmody=30SEP) or
      (&strtmody=01OCT and &stopmody=31DEC) or
      (&strtmody=01JAN and &stopmody=31DEC) %then %do;

    %*----Special titles for Quarter and for Year;
    %if not (&strtmody eq 01JAN and &stopmody eq 31DEC)
           %then %do;
       title3 "Sales for Quarter";
    %end;
    %else %do;
      title3 "&repyear Annual Sales";
    %end;

    proc gchart data=temp;
      %*----For each analysis variable, do a pie chart;
      %let setchrt=1;
      %let chrtvar=%scan(&vars,1);
      %do %while (&chrtvar ne );
        pie &classvar / type=sum sumvar=&chrtvar
                        coutline=black percent=arrow;
        run;

        %let setchrt=%eval(&setchrt+1);
        %let chrtvar=%scan(&vars,&setchrt);
      %end;
    quit;
  %end;
%mend report;

/**********************************************************************/
/* Page 214  Call to macro program for output in Figure 9.4           */
/**********************************************************************/
%report(repyear=1998,stop=13NOV)

/**********************************************************************/
/* Page 215  Call to macro program for output in Figure 9.5           */
/**********************************************************************/
%report(repyear=1998,stop=31Mar,classvar=section,
         vars=salepric profit)

/**********************************************************************/
/* Page 215  Call to macro program for output in Figure 9.6           */
/**********************************************************************/
%report(stop=,classvar=section saleinit)















































































































































































































