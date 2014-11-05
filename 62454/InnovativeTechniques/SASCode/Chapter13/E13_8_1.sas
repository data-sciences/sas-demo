* E13_8_1.sas
*
* Using DICTIONARY tables;

title '13.8.1 Using DICTIONARY Tables'; 
proc sql;
describe table dictionary.tables;
describe table dictionary.members;
select * from dictionary.members;
quit;

title2 'Build a list of data sets';
proc sql noprint;
select memname 
   into :tablelist separated by ','
      from dictionary.members
         where libname='ADVRPT';
%put &tablelist;
quit;
