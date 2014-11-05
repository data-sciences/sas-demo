* E11_3_4.sas
*
* Using code sequences with the escape character;


ods listing close;
ods pdf style=printer
    file="&path\results\E11_3_4.pdf";

ods escapechar = '~';

proc format;
   value $genttl
      'f','F'='Fe~mmale~-2nSubjects'
      'm','M'='Ma~mle~-2nSubjects';
   run;

title1 "Controlling Line Breaks";
proc report data=advrpt.demog nowd;
   columns sex ht wt;
   define sex   / group format=$genttl.
                  'Subject~w Gender';
   define ht    / analysis mean
                  format=5.2
                  'Height~{dagger}';
   define wt    / analysis mean
                  format=6.2
                  'Weight~{dagger}';
   rbreak after / summarize;

   compute after;
      line @1 '~{dagger} Eng~mlish Measures'
              '~-2nHeight(in.)~-2nWeight(lbs.)';
      line @1 'All su~mbjects were screened during '
              '~-2nthe intake session at visit one.';
   endcomp;
   run;
ods _all_ close;
