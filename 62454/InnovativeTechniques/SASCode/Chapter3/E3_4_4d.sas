* E3_4_4d.sas
* 
* Using INTNX with the macro language;

title1 '3.4.4d Working with Month Names';
%let mo=Mar;
%* Create a date for this month (01mar2010);
%let dtval  = %sysfunc(inputn(&mo.2010,monyy7.));

%* Previous month;
%let last = %sysfunc(intnx(month,&dtval,-1));

%* Determine the abbreviation of the previous month;
%let molast = %sysfunc(putn(&last,monname3.));
%put mo=&mo dtval=&dtval molast=&molast;


%* Without intermediate macro variables;
%let molast2 = %sysfunc(putn(%sysfunc(intnx(month,%sysfunc(inputn(&mo.2010,monyy7.)),-1)),monname3.));
%put mo=&mo molast=&molast2;
