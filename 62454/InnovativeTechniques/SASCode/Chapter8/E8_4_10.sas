* E8_4_10.sas
*
* Conditional Execution of the LINE statement;


title1 '8.4.10 LINE Statements';
ods listing close;


ods pdf file="&path\results\E8_4_10a.pdf" 
        style=journal;
title2 'Attempted Conditional Execution';
proc report data=advrpt.demog nowd;
column sex race wt wt=meanwt;
define sex  / group;
define race / group;
define wt    / analysis n 'Patient Count';
define meanwt/ analysis mean 'Mean Weight' f=5.1;
compute after sex;
   if wt.n ge 35 then do;
      line 'Overall mean weight is: ' meanwt 5.1;
   end;
   else line 'Patient Count Below 35';
endcomp;
run;
ods pdf close;

*****************************************************;
ods pdf file="&path\results\E8_4_10b.pdf" 
        style=journal;
title2 'Conditional Preparation';
proc report data=advrpt.demog nowd;
column sex race wt wt=meanwt;
define sex  / group;
define race / group;
define wt    / analysis n 'Patient Count';
define meanwt/ analysis mean 'Mean Weight' f=5.1;
compute after sex;
   if wt.n ge 35 then do;
      text= 'Overall mean weight is: '||put(meanwt,5.1);
   end;
   else text = 'Patient Count Below 35';
   line text $31.;
endcomp;
run;
ods pdf close;

