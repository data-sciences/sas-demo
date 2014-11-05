* S6_4_1a.sas
*
* Using user defined formats;
proc format;
   value $reg '1'=' 1' '2'=' 2' '3'=' 3' '4'=' 4'
              '5'=' 5' '6'=' 6' '7'=' 7' '8'=' 8'
              '9'=' 9' '10'='10';
   value $gender
              'M'='Male' 'F'='Female';
   run;

* User Defined Formats;
title1 'Refining REPORT Appearance';
title2 'Using User Defined Formats';
proc report data=rptdata.clinics nowd;
   column region sex,(wt=n wt ht);
   define region / group         format=$reg6.;
   define sex    / across        format=$Gender. 'Gender';
   define n      / analysis n    format=2.0      'N';
   define wt     / analysis mean format=6.2      'Weight';
   define ht     / analysis mean format=6.1      'Height';
   run;
