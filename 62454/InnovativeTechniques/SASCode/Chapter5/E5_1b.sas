* E5_1b.sas
* 
* Automated COMPARE;

%macro autocompare(base=,
                   compare=,
                   bylist=,
                   varlist=
                    );
* Sort the incoming data 
* The &BYLIST must form a unique key;
proc sort data=&base
          out=base
          nodupkey;
   by &bylist;
   run;
proc sort data=&compare
          out=compare
          nodupkey;
   by &bylist;
   run;

* Perform the comparisons;
proc compare
         data=base
         compare=compare
         out=cmpr
         outbase outcomp
         noprint outnoequal;
   id &bylist;
   %if &varlist ne %then %do; var &varlist; %end;
   run;

* Sort the obs with differences;
proc sort data=cmpr;
   by &bylist _obs_;
   run;

proc transpose data=cmpr
               out=tdiff(drop=_label_ rename=(_name_=VarName));
   by &bylist _obs_;
   id _type_;
   var 
   %if &varlist ne %then &varlist;
   %else _all_;;
   run;

data Differences;
   set tdiff(where=(varname ne '_TYPE_' & base ne compare));
   * The following two statements generally make the output
   * easier to read, however they can cause a conversion 
   * note when all the incoming VARS are numeric;
   base = left(base);
   compare = left(compare);
   run;
%mend autocompare;

options nomprint nomlogic nosymbolgen;
* Build an example data set with some differences;
data class2;
   set sashelp.class;
   if _n_=3 then sex = 'G';
   if _n_=3 then height=12;
   if _n_=5 then age = 45;
   run;

* compare the two data sets;
%autocompare(base=sashelp.class,
              compare=class2,
              bylist=name,
              varlist=age height sex)

* The data table work.differences will 
* contain any data differences;
title '5.1b Variables with differences';

proc print data=differences;
   run;
