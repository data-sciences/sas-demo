* E8_4_5.sas
* 
* Consolidating Columns;

title1 '8.4.5 Colsolidating Columns within an ACROSS Variable';
title2 'Weight Within Gender';
proc report data=advrpt.demog nowd;
   column edu sex,(wt wt=wtse meanse);
   define edu    / group 'Years/Ed.';
   define sex    / across order=formatted;
   define wt     / mean noprint;
   define wtse   / stderr noprint;
   define meanse / computed 'Mean (SE)' format=$15.;

   compute meanse/char length=15;
      _c4_ = cat(put(_c2_,5.2),' (',put(_c3_,5.2),')');
      _c7_ = cat(put(_c5_,5.2),' (',put(_c6_,5.2),')');
   endcomp;
   run;
