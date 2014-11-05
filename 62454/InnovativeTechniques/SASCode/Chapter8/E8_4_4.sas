* E8_4_4.sas
* 
* Using an Dummy Column with an ACROSS Var;

ods pdf file="&path\results\E8_4_4.pdf"
        style=journal;
title1 '8.4.4 Consolidating Compute Blocks';
title2 'Using a DUMMY Column';
proc report data=advrpt.demog nowd;
   column edu wt=allwtmean sex,wt dummy;
   define edu / group 'Years/Ed.';
   define allwtmean / mean 'Overall Mean' format=7.1;
   define sex / across order=formatted;
   define wt  / mean 'Mean' format=5.1;
   define dummy / computed noprint;

   compute dummy;
      _c4_ = _c4_/2.2;
      _c3_ = _c3_/2.2;
      allwtmean = allwtmean/2.2;
   endcomp;
run;
ods pdf close;
