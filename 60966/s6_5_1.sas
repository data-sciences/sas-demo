* S6_5_1.sas
*
* Using the NOHEADER option;

* Removing headers;
title1 'Refining REPORT Appearance';
title2 'Using NOHEADER';
proc report data=rptdata.clinics(where=(region in('1','2'))) 
            noheader nowd;
   columns region n ('Mean' ht wt);
   define region / group    width=6;
   define n      /          'N' 
                            format=3.;
   define ht     / analysis mean 
                            format=6.2 'Height';
   define wt     / analysis mean 
                            format=6.2 'Weight';
   run;
