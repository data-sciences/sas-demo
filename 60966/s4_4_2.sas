* S4_4_2.sas
*
* PROC statement options;

* This option statement sets the CENTER/NOCENTER
* option to its default value;
options center;

title1 'Only in LISTING';
title2 'Using the CENTER Option';

proc report data=rptdata.clinics 
            nocenter  
            nowd split='*';
   column region sex ('Patient Weight'wt,(n mean));
   define region / group;
   define sex    / across   'Sex';
   define wt     / analysis '(lb)*__';
   run;
