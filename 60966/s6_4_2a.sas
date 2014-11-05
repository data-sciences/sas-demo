* S6_4_2a.sas
*
* Preloading formats;

* Using PRELOADFMT with user defined formats;
proc format;
   value $regx 
     '1'=' 1' '2'=' 2' 'X'=' X' ;
   value $genderu
     'M'='Male' 'F'='Female' 'U'='Unknown';
   run;

* User Defined Formats;
title1 'Refining REPORT Appearance';
title2 'Using PRELOADFMT with EXCLUSIVE';
proc report data=rptdata.clinics nowd;
   column region sex,(wt=n wt);
   define region / group
                     format=$regx6.
                     preloadfmt exclusive;
   define sex    / across        format=$Genderu. 'Gender';
   define n      / analysis n    format=2.0 'N';
   define wt     / analysis mean format=6.2 'Weight';
   run;
