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

=======================*/


/*=====
SOURCE CODE FOR MACRO %MAKELIST
You might need to adjust the formatting for the date, time, and
datetime SAS variable types for DBMS systems other than DB2.
=====*/



%macro MakeList(globname, dsn, varinfo, vartype);
%local i j;
%global &globname;
%let &globname=; /* return null if macro fails*/
%let numvars=1; %* find number of variables specified;
%do %while (%scan(&vartype,%eval(&numvars+1))
ne);
%let numvars=%eval(&numvars+1);
%end;
/**********************************************
Single variable entered
**********************************************/
%if &numvars=1 %then %do;
/**************** Character ********/
%if %upcase(&vartype)=C %then %do;
proc sql noprint;
Select
Distinct translate(quote(&varinfo),"'",'"')
into :&globname separated by ','
from &dsn;
quit;
%end;
/**************** Numeric ********/
%else %if %upcase(&vartype)=N %then %do;
proc sql noprint;
select distinct &varinfo
into :&globname separated by ','
from &dsn;
quit;
%end;
/**************** Date ********/
%else %if %upcase(&vartype)=D %then %do;
proc sql noprint;
select distinct "'"||
put(&varinfo, yymmdd10.)||"'"
into :&globname separated by ','
from &dsn;
quit;
%end;
/**************** Time ********/
%else %if %upcase(&vartype)=T %then %do;
proc sql noprint;
select distinct "'"||
translate(put(&varinfo, time.),
'.',':','0',' ')||"'"
into :&globname separated by ','
from &dsn;
quit;
%end;
/**************** Datetime ********/
%else %if %upcase(&vartype)=DT %then %do;
proc sql noprint;
select distinct "'"||put(datepart(&varinfo),
yymmdd10.)||"-"||
translate(put(timepart(&varinfo),
time15.6),'.',':','0',' ')||"'"
into :&globname separated by ','
from &dsn;
quit;
%end;
%else %put ******* Invalid variable type:
&vartype *************;
%end; /* %if &numvars=1 */
/**********************************************
Multiple variables entered
**********************************************/
%else %do;
/***** Parse SQL template ********************/
%let j=1;
%do %while (%index(%quote(&varinfo), &dlm)>0);
%let markloc=%index(%quote(&varinfo), &dlm);
%let text&j=%substr(%quote(&varinfo), 1,
%eval(&markloc-1));
%let varinfo=%substr(%quote(&varinfo),
%eval(&markloc+1),
%eval(%length(&varinfo)-&markloc) );
%let markloc=%index(%quote(&varinfo), &dlm);
%let var&j=%substr(%quote(&varinfo), 1,
%eval(&markloc-1));
%if %length(&varinfo)>&markloc %then
%let varinfo=%substr(%quote(&varinfo),
%eval(&markloc+1),
%eval(%length(&varinfo)-&markloc) );
%else %let varinfo=;
%let j=%eval(&j+1);
%end;
/*** Build macro variable with Proc SQL ******/
proc sql noprint;
select distinct '(' ||
%do i=1 %to &j-1;
/***** Character variable ********************/
%if %upcase(%scan(&vartype, &i))=C %then
" &&text&i " ||
translate(quote(&&var&i),"'",'"') ||;
/***** Numeric variable *********************/
%else %if %upcase(%scan(&vartype, &i))=N %then
" &&text&i " || compress(put(&&var&i,
best20.)) ||;
/***** Date variable ************************/
%else %if %upcase(%scan(&vartype, &i))=D %then
" &&text&i '" || put(&&var&i,
yymmdd10.)||"'" ||;
/***** Time variable ************************/
%else %if %upcase(%scan(&vartype, &i))=T %then
" &&text&i '" ||
translate(put(&&var&i, time.),'.',':','0',
' ')||"'"||;
/***** Datetime variable ********************/
%else %if %upcase(%scan(&vartype, &i))=DT %then
" &&text&i '" || put(datepart(&&var&i),
yymmdd10.)||
"-" ||translate(put(timepart(&&var&i),
time15.6), '.',':','0',' ')||"'"||;
%else %put ********** Invalid variable type:
%scan(&vartype,&i) *************;
%end; /* %do i=1 %to &j-1 */
" &varinfo)" into :&globname separated by
' or ' from &dsn;
quit;
%end; /* %else for %if &numvars=1 */
%mend MakeList;
