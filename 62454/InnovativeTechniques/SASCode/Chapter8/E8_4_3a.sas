* E8.4.3a.sas
* 
* Using an Compute Block with an ACROSS Var;

title1 '8.4.3a Showing ACROSS With Compute Blocks';
title2 'Convert LB to KG';
proc report data=advrpt.demog nowd;
   column edu sex,wt wt=allwtmean;
   define edu / group 'Years/Ed.';
   define sex / across order=formatted;
   define wt  / mean 'Mean' format=5.1;
   define allwtmean / mean 'Mean' format=5.1;

   compute wt;
      _c2_ = _c2_/2.2;
      _c3_ = _c3_/2.2;
   endcomp;

   compute allwtmean;
      allwtmean = allwtmean/2.2;
   endcomp;
run;
