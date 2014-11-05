* S5_3.sas
*
* Using the compute block;

* Calculating percentages within groups;
title1 'Using the COMPUTE Block';
title2 'Percentages Within Groups';

proc report data=rptdata.clinics nowd split='*';
  where clinnum in('031234', '036321');
  column clinnum lname wt prctwt ;
  define clinnum  / group width=10;
  define lname    / order 'Last Name';
  define wt       / analysis format=6. 'Weight';
  define prctwt   / computed format=percent8.1 'Percent*of Total';

  compute before clinnum;
     totwt = wt.sum;
  endcomp;

  compute prctwt;
    prctwt = wt.sum / totwt;
  endcomp;

  break after clinnum  / dol skip summarize suppress;
  run;
