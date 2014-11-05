proc format;
   value $SYM 
      '01' = ':Sleepiness'
      '02' = ':Coughing'
      '03' = ':Limping '
      '04' = ':Bleeding'
      '05' = ':Weak'
      '06' = ':Nausea' 
      '07' = ':Headache'
      '08' = ':Cramps'
      '09' = ':Spasms '
      '10' = ':Shortness of Breath';
   run;

* Define Statement spacing option;
title1 'Using Proc REPORT';
title2 'Define Statement SPACING Option';
title3 'Removing Spaces';
proc report data=rptdata.clinics nowd;
  column ('Name' lname fname) symp symp=sympname;
  define lname    / order               'Last';
  define fname    / order               'First';
  define symp     / display format=$2.  'Sy';
  define sympname / display format=$sym. 
                    spacing=0           'mptom';
  run;
