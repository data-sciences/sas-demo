* S6_3.sas
*
* Nestin Variables;

* Nesting Analysis Variables;
title1 'Refining REPORT Appearance';
title2 'Nesting Mean Weight and Height within Sex';
* Nesting variables;
proc report data=rptdata.clinics nowd;
   column region sex,(wt=n wt ht);  
   define region / group         width=6;
   define sex    / across        format=$2. 'Gender';
   define n      / analysis n    format=2.0 'N';  
   define wt     / analysis mean format=6.2 'Weight';
   define ht     / analysis mean format=6.1 'Height';
   run;
