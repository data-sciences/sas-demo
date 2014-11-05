* E12_1_1.sas
* 
* Preloading Formats;

title1 '12.1.1 Preloading Formats in PROC REPORT';
proc format;
   value $regx 
      '1'=' 1' '2'=' 2' 'X'=' X' ;
   value $genderu
      'M'='Male' 'F'='Female' 'U'='Unknown';
   run;
proc sort data=advrpt.demog
           out=clinnum;
   by clinnum;
   run;
proc sort data=advrpt.clinicnames
           out=clinicnames;
   by clinnum;
   run;


data demog;
   merge clinnum clinicnames;
   by clinnum;
   run;

title2 'Using PRELOADFMT with EXCLUSIVE';
proc report data=demog nowd;
   column region sex,(wt=n wt);
   define region / group
                   format=$regx6.
                   preloadfmt exclusive;
   define sex    / across        format=$Genderu. 'Gender';
   define n      / analysis n    format=2.0 'N';
   define wt     / analysis mean format=6.2 'Weight';
   run;

title2 'Using COMPLETEROWS with PRELOADFMT and without EXCLUSIVE';
proc report data=demog nowd completerows;
   column region sex,(wt=n wt);
   define region / group format=$regx6.
                   preloadfmt
/*                   order=data*/
;
   define sex    / across        format=$Genderu. 'Gender';
   define n      / analysis n    format=2.0 'N';
   define wt     / analysis mean format=6.2 'Weight';
   run;


title2 'Using COMPLETEROWS with PRELOADFMT and EXCLUSIVE';
proc report data=demog nowd completerows;
   column region sex,(wt=n wt);
   define region / group format=$regx6.
                   preloadfmt exclusive;
   define sex    / across        format=$Genderu. 'Gender';
   define n      / analysis n    format=2.0 'N';
   define wt     / analysis mean format=6.2 'Weight';
   run;


title2 'Using COMPLETEROWS and COMPLETECOLS with EXCLUSIVE';
proc report data=demog nowd completerows completecols;
   column region sex,(wt=n wt);
   define region / group format=$regx6.
                   preloadfmt exclusive;
   define sex    / across        format=$Genderu. 'Gender'
                   preloadfmt exclusive;
   define n      / analysis n    format=2.0 'N';
   define wt     / analysis mean format=6.2 'Weight';
   run;
