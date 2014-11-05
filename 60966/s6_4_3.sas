* S6_4_3.sas
*
* Reordering based on format definitions;

* The NOTSORTED option is applied to the 
* format definition;
proc format;
   value $SYM (notsorted)
      '01' = 'Sleepiness'
      '02' = 'Coughing'
      '10' = 'Shortness of Breath'
      '05' = 'Weak'
      '03' = 'Limping '
      '07' = 'Headache'
      '06' = 'Nausea' 
      '08' = 'Cramps'
      '09' = 'Spasms '
      '04' = 'Bleeding';
   run;

* Controlling order with Format Definitions;
title1 'Using Proc REPORT';
title2 'Using the Format Definition Order';
proc report data=rptdata.clinics 
            nowd completerows;
  column symp n;
  define symp  / group 
                   preloadfmt order=data
                   format=$sym. 'Symptom';
  define n     / 'N' ;
  run;
