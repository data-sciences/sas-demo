*E12_9_3.sas
*
* Concatenating catalogs;

libname oldfmt 'c:\temp1';
libname newfmt 'c:\temp2';
libname allfmt (newfmt oldfmt);

proc format library=oldfmt;
  value yesno 1 = 'Yes'
              0 = 'No';
  value generation
   low - <1950 = 'Greatest'
   1950 - high = 'Boomer';
  run;
proc format library=newfmt;
  value gender 1 = 'Female'
               0 = 'Male';
  value yesno 1 = 'No'
              0 = 'Yes';
  run;
ods pdf file="&path\results\E12_9_3.pdf"
        style=journal;
title1 12.9.3 Display Format names;
proc catalog cat=allfmt.formats;
  contents;
  quit;
ods pdf close;

options fmtsearch=(allfmt work);
data silly;
x=0;
put x= yesno.;
run;
