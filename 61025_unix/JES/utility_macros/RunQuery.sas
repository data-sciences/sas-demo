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


/*========================================
SOURCE CODE FOR MACRO %RUNQUERY
Change the value for macro variable &DBMStype to the correct
value for your DBMS - DB2, Oracle, Teradata, etc.
=========================================*/
%macro RunQuery(dbinfo, dsname, query);
%let DBMStype=DB2;
proc sql;
connect to &DBMStype (&dbinfo);
create table &dsname as select * from
connection to &DBMStype (
%unquote(&query) for fetch only);
%put &sqlxmsg;
disconnect from &DBMStype;
quit;
%mend RunQuery;
