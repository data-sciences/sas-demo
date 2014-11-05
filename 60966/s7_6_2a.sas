* S7_6_2a.sas
*
* Defining character columns;

title1 'Extending Compute Blocks';
title2 'Defining Character Columns';

proc report data=rptdata.clinics(where=(region='2'))
            nowd split='*';
   column lname fname name wt ht edu;
   define lname / order noprint;
   define fname / order noprint;
   define name  / computed 'Patient Name';
   define wt    / display  'Weight';
   define ht    / display  'Height';
   define edu   / display  'Years*Ed.';

   compute name / character length=17;  
      name = trim(fname) || ' ' ||lname;
   endcomp;
   run;
