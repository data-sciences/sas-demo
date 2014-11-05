*E6_2.sas
*
* Table lookups - hardcoded sequential lookups.;

title '6.2 A Series of IF-THEN/ELSE  or WHEN statements';

* Using IF-THEN/ELSE;
data demognames;
   set advrpt.demog(keep=clinnum lname fname);
   length clinname $35;
   if clinnum='011234' then      clinname = 'Boston National Medical';
   else if clinnum='014321' then clinname = 'Vermont Treatment Center';
   else if clinnum='107211' then clinname = 'Portland General';
   else if clinnum='108531' then clinname = 'Seattle Medical Complex';
   else if clinnum='023910' then clinname = 'New York Metro Medical Ctr';
   else if clinnum='024477' then clinname = 'New York General Hospital';
   run;

* Using the SELECT statement;
* Use SELECT(varname) processing to assign clinnames;
data demognames;
   set advrpt.demog(keep=clinnum lname fname);
   select(clinnum);
    when( '011234') clinname='Boston National Medical';
    when( '014321') clinname='Vermont Treatment Center';
    when( '107211') clinname='Portland General';
    when( '108531') clinname='Seattle Medical Complex';
    when( '023910') clinname='New York Metro Medical Ctr';
    when( '024477') clinname='New York General Hospital';
    otherwise;
   end;
   run;


* Use SELECT processing to assign clinnames;
data demognames;
   set advrpt.demog(keep=clinnum lname fname);
   select;
    when(clinnum='011234') clinname='Boston National Medical';
    when(clinnum='014321') clinname='Vermont Treatment Center';
    when(clinnum='107211') clinname='Portland General';
    when(clinnum='108531') clinname='Seattle Medical Complex';
    when(clinnum='023910') clinname='New York Metro Medical Ctr';
    when(clinnum='024477') clinname='New York General Hospital';
    otherwise;
   end;
   run;
