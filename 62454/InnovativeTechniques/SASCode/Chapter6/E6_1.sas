*E6_1.sas
*
* Table lookups;

title '6.1 A Series of IF statements';
data demognames;
   set advrpt.demog(keep=clinnum lname fname);
   length clinname $35;
   if clinnum='011234' then clinname = 'Boston National Medical';
   if clinnum='014321' then clinname = 'Vermont Treatment Center';
   if clinnum='107211' then clinname = 'Portland General';
   if clinnum='108531' then clinname = 'Seattle Medical Complex';
   if clinnum='023910' then clinname = 'New York Metro Medical Ctr';
   if clinnum='024477' then clinname = 'New York General Hospital';
   run;

