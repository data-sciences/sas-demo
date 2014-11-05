* S5_5.sas
*
* Calculating percentages within groups;
title1 'Using the COMPUTE Block';
title2 'Examining the Output Data Set';

proc report data=rptdata.clinics 
            out=r5_5out
            nowd split='*';
  where clinnum in('031234', '036321');
  column clinnum lname wt prctwt ;
  define clinnum  / group width=10;
  define lname    / order 
            'Last Name';
  define wt       / analysis format=6. 
            'Weight';
  define prctwt   / computed format=percent8.1 
            'Percent*of Total';

  compute before clinnum;  
    totwt = wt.sum;  
  endcomp;

  compute prctwt;  
    prctwt = wt.sum / totwt;  
  endcomp;

  break after clinnum  / dol skip summarize suppress;
  run; 

proc print data=r5_5out;
   title3 OUT= Data Set;
   run;
