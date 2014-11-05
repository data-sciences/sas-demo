*E13_7.sas
*
* Writing macro functions.;

title1 13.7 Writing Macro Functions;

%* *******************************************;
%macro obscnt(dsn);
%local nobs dsnid rc;
%let nobs=.;

%* Open the data set of interest;
%let dsnid = %sysfunc(open(&dsn));

%* If the open was successful get the;
%* number of observations and CLOSE &dsn;
%if &dsnid %then %do;
     %let nobs=%sysfunc(attrn(&dsnid,nlobs));
     %let rc  =%sysfunc(close(&dsnid));
%end;
%else %do;
     %put Unable to open &dsn - %sysfunc(sysmsg());
%end;

%* Return the number of observations;
&nobs
%mend obscnt;

%* ******************************************************;
%macro wordcount(list);
   %sysfunc(countw(&list,%str( )))
%mend wordcount;

%let list = a b c d;
%put %wordcount(&list);

%let list = a    Bb c d;
%put %wordcount(&list);


%* **************************************************;
%* The macro %AGE was written by Ian Whitlock and is
%* based on an age formula developted by Wm. Kreuter and 
%* and published in a paper by Chang Chung and Ian Whitlock
%* "%IFN - A Macro Function", published in the proceedings of the 
%* 31st SAS User Group International Conference, SUGI, 2006, 
%* Cary, NC: SAS Institute Inc., Paper 042-31.;
%macro age(begdate,enddate); 
 (floor((intck('month',&begdate,&enddate)-(day(&enddate)<day(&begdate)))/12)) 
%mend age;

proc print data=advrpt.demog;
   * select subjects over 21 as of Feb 18, 1998;
   where %age(dob,'18feb1998'd) gt 45;
   var fname lname dob;
   run;

%* ********************************************;
%let dog=scott;
%let dog1=bill;
%let dog2=george;
%let dog3=notsue; 
%macro nextdog;
%local cnt;
%let cnt=;
%do %while(%symexist(dog&cnt));  
  %let cnt=%eval(&cnt+1);  
%end;
&cnt 
%mend nextdog;
%put nextdog is %nextdog;
%let dog%nextdog=Johnny; 
%put nextdog is %nextdog;
%put _user_;
