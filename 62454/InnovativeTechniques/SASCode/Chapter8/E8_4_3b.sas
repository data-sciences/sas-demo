* E8_4_3b.sas
* 
* Combining compute blocks;

title1 '8.4.3b Showing ACROSS With Compute Blocks';
title2 'Convert LB to KG';
proc report data=advrpt.demog nowd;
   column edu sex,wt wt=allwtmean;
   define edu / group 'Years/Ed.';
   define sex / across order=formatted;
   define wt  / mean 'Mean' format=5.1;
   define allwtmean / mean 'Mean' format=5.1;

   compute allwtmean;
      _c2_ = _c2_/2.2;
      _c3_ = _c3_/2.2;
      allwtmean = allwtmean/2.2;
   endcomp;
run;
