/*=============================================================================================
Macro: %DBMSlist
Source: Garth W. Helf, 2001 "Can't Relate? A Primer on Using SAS With Your Relational Database"
		Proceedings of the Twenty-Seventh Annual SAS Users Group International Conference
		Paper 155-27
==============================================================================================*/
/*=====================
SOURCE CODE FOR MACROS
The source code for the three macros %DBMSlist, %MakeList,
and %RunQuery are included below. Copy and paste each one
to a file by the same name in your autocall macro library to make
them visible to your SAS programs. The macro you use is
%DBMSlist, the other two are called by this macro. You can copy
this code from the CD copy of the Proceedings you receive at the
conference, or from the SUGI web site after the conference:
http://www.sas.com/usergroups/sugi/proceedings/index.html.


SOURCE CODE FOR MACRO %DBMSLIST

=======================*/

%Macro DBMSlist(dsn, column, vtype, newdsn,
dbname, query, bitesize=200, test=no,
dlm=%str(#) );
proc sql noprint;
select count(*) into :gwhxxxx1
from &dsn;
quit;
%if &gwhxxxx1=0 %then %do;
%put ====== WARNING: Input data set &dsn is
empty, macro ends =======;
%goto exit;
%end;
%let totpass=%sysevalf(&gwhxxxx1/&bitesize,
ceil);
%if &test=no %then %do j=1 %to &gwhxxxx1 %by
&bitesize;
%let p=%sysevalf(&j/&bitesize, ceil);
%put ================= Starting pass &p of
&totpass ==================;
data gwhxxxx2;
set &dsn (firstobs=&j
obs=%eval(&j+&bitesize-1));
run;
%MakeList(mylist, gwhxxxx2, &column, &vtype);
%RunQuery(&dbname, gwhxxxx3, &query);
%if &j=1 %then %do;
data &newdsn;
set gwhxxxx3;
run;
%end;
%else %do;
Proc append base=&newdsn data=gwhxxxx3;
run;
%end;
%end;
%else %do; %* Test=yes: do one query for timing;
data gwhxxxx2;
set &dsn (firstobs=1 obs=&bitesize);
Run;
%MakeList(mylist, gwhxxxx2, &column, &vtype);
%RunQuery(&dbname, gwhxxxx3, &query);
%end;
%exit: %mend DBMSlist;

