* S6_2.sas
*
* Using Aliases;
title1 'Refining REPORT Appearance';
title2 'Using a Column Alias';
proc report data=rptdata.clinics
                     (where=(region in('1','2','3'))) 
            nowd;
   columns region ht ht=htmin ht=htmax ht=htmean ht=htmedian;
   define region   / group width=6;
   define ht       / analysis n      format=2.  'N';
   define htmin    / analysis min    format=4.1 'Min';
   define htmax    / analysis max    format=4.1 'Max';
   define htmean   / analysis mean   format=4.1 'Mean';
   define htmedian / analysis median format=6.1 'Median';
   run;

