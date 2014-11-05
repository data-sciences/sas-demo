*************************************************************;
* Chapter 1 : Introduction and Quickstart Guide 
*************************************************************;
footnote;
 /* to avoid having to redefine your library every time,
   use the 'New Library' icon in the SAS
   fing environment, and select 'enable at startup' */

/* LIBNAME MYLIB 'c:\users\michael.tuchman\documents\my sas files\saslibs\mylib';*/


* other preliminaries.  DELETE ALL ITEM STORES FROM LIBRARY!
* so we can start fresh ;

* this macro was needed to give you a fresh start in the MYLIB library

********* Program 1.1  *************************;
/*data set for chapter is subset of SAS-supplied SASHELP.CARS */
proc sort data=sashelp.cars out=WORK.cars;
where upcase(type) ne 'HYBRID';
by origin type;
run;

/* from chapter 3, but helpful to have here as well */

proc sort data=sashelp.class out=class;
by sex;
run;

********* Program 1.2 *************************;
/* adding ODS Output to a Document */
/* IN the book, we assume there is no mylib.quickstart */
/* on your system, but if you want to be sure of this, use */
/* write access mode */

ods document name=mylib.quickstart(update);
  proc contents data=cars;
  run;

  proc univariate data=cars;
  by origin type;
  run;

  proc means nmiss mean max min data=cars;
  class origin type;
  run;

ods document close;

********* Program 1.3 *************************;
ods document name=mylib.quickstart;
* book has: proc freq data=sasuser.cars;
proc freq data=cars;
table origin * type / list;
run;
ods document close;

********* Program 1.4 *************************;
ods html file="program1_4.html"; /* optional */
proc document name=mylib.quickstart;
replay;
run;
quit;
ods html close;
********* Program 1.5 *************************;
/* replaying document to PDF */
/* the full replay of the PDF is 286 pages */
/* one of the strengths of PROC DOCUMENT is being
   able to narrow this down to just the tables you 
   need to make your point */
ods pdf file="program1_5.pdf";
proc document name=mylib.quickstart;
replay;
run;
quit;
ods pdf close;
*********   Program  1.6  ********************;
/* example of replaying in a different style */
ods html file="fancy.html" style=rsvp;
proc document name=mylib.quickstart;
replay;
run;
quit;
ods html close;

*********   Program  1.7 ******************;
/* replays the first univariate procedure output stored */
/* if you have more than one, see examples in Chapter 5 for
/* ways to select the specific output you want */
ods html file="program1_7.html" style=statdoc;
proc document name=mylib.quickstart;
replay univariate#1;
run;
quit;
ods html close;
*********   Program 1.8 ********************;
/* Another way to specify which output to replay- using existing labels */
ods html file="program1_8.html" style=statdoc;
proc document name=mylib.quickstart;
replay univariate(where=(_labelpath_ not contains "Extreme Observations"));
run;
quit;
ods html close;

*********   Program  1.9  ********************;
/* replaying using BY-group selection */
ods html file="program1_9.html" style=statdoc;
proc document name=mylib.quickstart;
replay univariate(where=(origin='Asia'));
run;
quit;
ods html close;

*********   Program   1.10   ********************;
/* Subsetting with Multiple Conditions          */
ods html file="program1_10.html" style=htmlblue;
proc document name=mylib.quickstart;
   replay univariate(where=(_labelpath_ ? 'MPG' and _name_ = 'Moments' and
      type='SUV'));
   run;
quit;
ods html close;

/* Program 1.11: Creating a Summary Table of Contents */
ods html file="program1_11.html";
proc document name=mylib.quickstart;
list; /* one line for each proc */
run;
quit;
ods html close;


/* Program 1.12: Creating a More Detailed Listing   */
proc document name=mylib.quickstart;
list / levels=all details;/* every subdirectory */
run;
quit;

/* Program 1.13: Changing a Title and Replaying It */
/* the ODS HTML line did not make it into the book, but
   the program will still run so long as you keep one
   ODS destination open */
ods html file="program1_13.html" ;
proc document name=mylib.quickstart;
obtitle \Univariate#1\ByGroup1#1\MSRP#1\Moments#1
   'Manufacturer''s Suggested Retail Price';
replay \Univariate#1\ByGroup1#1\MSRP#1\Moments#1;
run;
quit;
ods html close;

/* Program 1.14: Saving Output to a User-created Directory */
proc document name=mylib.quickstart;
  make summaries; /* create a folder */
  run;
quit;

/* send next output directly to this folder */
ods document name=mylib.quickstart dir=(path=\summaries);
  proc report nowd data=cars;
     column origin type msrp;
     define origin / group order=data;
     define type / 'Veh. Type' group order=data;
     define msrp / analysis mean;
  run;
ods document close;

/* now open the document for viewing */
ods html file='program1_14.html';
proc document name=mylib.quickstart;
  list summaries; /* omitting sequence number defaults to highest */
  run;
quit;
ods html close;

/* Program 1.15 : Replaying the Report */
/* purpose is to demonstrate equivalent ways to 
   write a REPLAY statement that produces the report in Program 1.14 */
ods html file="program1_15.html";
proc document name=mylib.quickstart;
  replay summaries#1;
    run;
	replay Summaries#1\Report; /* Report becomes Report#1 */
	run;
	replay Summaries#1\Report#1\Report#1;
	run;
quit;
ods html close;

/* ONLY RUN program 1.16 IF YOU WANT TO CLEAR THE ENTIRE DOCUMENT
   AND START OVER. FOR THIS REASON, IT IS COMMENTED OUT
   SO THAT IT IS NOT RUN SHGOULD YOU SUBMIT THE ENTIRE FILE!  */

/* Program 1.16: Starting Over */
%macro skipme1;
ods document name=mylib.quickstart(write);
<different, newer sas code >
ods document close;
%mend; 
/* Program 1.17 is commented out for the same reason */
/* Program 1.17: Deleting a Document */
%macro skipme2;
proc document name=dontdoit;
delete dontdoit;
run;
quit;
%mend;

*************************************************************;
* Chapter 2 : The ODS Document Destination
*************************************************************;
* The code in this chapter does not affect the ODS Documents
* developed elsewhere in this book.  
*************************************************************;
/* Program 2.1: Sending SAS Output to an ODS Destination */
ods html file="curious.html"; 
ods pdf file="curious.pdf";
title "MPG";
/* may wish to run program 1.1 and change sashelp.cars to work.cars */
/* however, not an error to run it as written */
proc means data=sashelp.cars; 
var mpg_highway;
run; 
ods pdf close;
ods html close; 
title;

/* Program 2.2: Demonstrating the ODS TRACE Statement */
/* look in the LOG for ODS trace output */
/* the book uses work.class, which is defined in Chapter 3. */
ods trace on / label;
ods html file="program2_2.html" style=minimal;
proc univariate data=sashelp.class;  /* different from book */
var height age weight; /* should have included weight in listing. Book omits */
histogram height age;
qqplot age;
run;
ods html close;
ods trace off;

/* Program 2.3: Selecting Output to Be Saved to the Document */
ods document name=sample; 
ods document select moments extremeobs; 
ods document show;
ods document close;
ods document name=mylib.firstdoc; 
ods document show;
ods document close;

*************************************************************;
* Chapter 3 : The ODS Document Statement
*************************************************************;
* If you are running Chapter 3 code as the very first programs in your
* session, you will see output to the ODS HTML destination by
* default (in SAS 9.3)  If all ODS destinations are closed, then you will
* not see any output. but output was still added to the document.
* In this section , you will not find ODS HTML file= before every code block.
* In SAS 9.3, despite this omission, you will still see your output. 
* If you are not seeing output, then  you should put them in explicitly.
*************************************************************;
/* Program 3.1: Adding Output to a Document */
/*ods trace on; */
libname mylib "C:\Users\Michael\Dropbox\book";
ods html; /* optional */
ods document name=mylib.firstdoc(write);
proc sort data=sashelp.class out=class;
by sex;
run;
proc univariate data=class;
by sex;
var height age;
run;
proc freq data=class;
table sex / plots=all;
run;
ods document close;
ods html close;


/*Program 3.2: Viewing the Contents of the Document*/
proc document name=mylib.firstdoc;
/*delete univariate\bygroup2#1;*/
/*run;*/
/**/
/*make univariate\bygroup2#1;*/
/*run;*/
list / levels=all;
run ;
quit;

/*Program 3.3: Making Sure the Output Is Still Present*/
proc document name=mylib.firstdoc;
	replay;
	run;
quit;

/*Program 3.4: Saving Output to a Custom Folder*/
ods document name=mylib.seconddoc dir=(path=\march2012);
	proc univariate data=class;
		by sex;
		var height age;
	run;

	proc freq data=class;
		table sex;
	run;
ods document close;

proc document name=mylib.seconddoc;
	list / levels=all details;
	run;
quit;

/*Program 3.5: Creating Multiple Directories Using the ODS DOCUMENT Statement*/
ods document name=sample_doc dir=(path=\snapshot_tables label="Get Counts by categories");
/* if WORK.CARS is not defined, please re-run program 1.1 */
	proc freq data=work.cars;
	run;

/* same document remains open (so no need to restate  NAME= option) */

ods document dir=(path=\graphs);
	proc sgplot data=work.cars;
		by origin type;
		scatter x=horsepower y=msrp;
	run;

ods document dir=(path=\analysis label="Exploratory Analysis - Initial");
	proc univariate data=work.cars;
	run;
	ods document close;

proc document name=sample_doc;
	list / levels=1; 
	/* use list / levels=1 details; to see the labels */
	run;
quit;

/*Program 3.6: Determining Storage Locations When DIR= Is Specified*/
/* Because of an oversight, the author did not realize that SASHELP.AIR
    is only shipped with SAS/INSIGHT and SAS/ETS. However, an alternate
    version of the AIR dataset is available on the same website where you
    obtained this code.
*/
ods document name=mylib.firstdoc
	dir=(path=\special 
		label='All analysis pertaining to SASHELP.AIR');
		title 'Air Pollution Summary Report';

	proc means data=sashelp.air;
	run;

	/* not in book, but makes the document more interesting, in my opinion */
	proc sgplot data=sashelp.air;
	series x=timeid y=co2;
	run;

ods document close;


/* Program 3.7 does not produce any output */

/*Program 3.8: Create a Document with a Custom Label*/

/* NEW: different sort order but I did not correct the
   sorting on the dataset */
proc sort data=cars;
by type;
run;

/*ods trace on;*/
ods html file="program3_8.html";
ods document name=mylib.lastone(write)
	dir=(label='Analysis for 2004 Model Cars');
/* need to re-sort */

	proc univariate data=cars;
		by type;
		var weight msrp;
	run;

	proc freq data=cars;
		table origin * type / list;
	run;
ods document close;

/* normally resorting is definitely poor technique, but
   these data sets are small enough to get away with it */
/* NEW - resort*/
proc sort data=cars;
by origin type;
run;


/* instead of running the proc document statement,
   below, you could use the odsdocuments command
   in the SAS Windowing environment to see the contents of the
   document.  This is what is done in the book */

proc document name=mylib.lastone;
	list / levels=all details;
	run;
quit;
ods html close;  


/*Program 3.10: Deleting and Starting Over with a Clean Document*/
ods document name=mylib.onlytab(write);
	proc tabulate data=sashelp.cars;
		class origin;
		table origin,n*f=5.; /* width=5, no dec. places */
	run;
ods document close;

/* although not stated from this point onward,  use either the odsdocuments commmand
   or a proc document statement as in PRogram 3.9 to see
   the contains of your document */

/* Program 3.11 and 3.12 produce no output */

/*Program 3.13 Checking on the Document*/
ods listing; /* opens the once proud listing destination */
	proc document name=mylib.firstdoc;
		replay;
		run;
	quit;
ods listing close;

*************************************************************;
* Chapter 4: Listing Documents Using the
DOCUMENT Procedure
*************************************************************;
/*Program 4.1: Starting the DOCUMENT Procedure Using the NAME= Option*/
ods html file='program4_1.html';
proc document name=mylib.firstdoc;
/* update is the default access mode */
	list / details; /* details option needed to see labels */;
	run;
	replay;
	run;
quit;
ods html close;

/*Program 4.2: Relabeling an Existing Document*/
ods html file='program4_2.html';
proc document name=mylib.firstdoc label="Let's call this the
SASHELP.CLASS analysis, part I.";
doc lib=mylib;
run;
quit;
ods html close;

/*Program 4.3: Top-Level List of a Document*/
title ‘Simple Listing of MYLIB.FIRSTDOC’;
ods html file='program4_3.html';
proc document name=mylib.firstdoc;
list;
run;
quit;
ods html close;
title;

/*Program 4.4: Illustrating Sequence Numbers*/
ods document name=mylib.firstdoc;
/* this class_tmp segment not in book */
data class_tmp;
   label sex_f = 'Flag=1 if Sex=''F'', 0 if Sex=''M'' ';
   set class;
   sex_f = (sex='F');
run;

proc reg data=class plots=fit;
	by sex;
	model weight=height;
	run;
quit;
/* need to check all reg replays and name SURE */
proc reg data=class plots=fit;
	model weight=height;
	run;
quit;



proc reg data=class_tmp;
	by sex;
	model weight = age height;
	run;
quit;

proc reg data=class_tmp ;
	model weight = age height sex_f;
	run;
quit;
ods document close;
	
/*Program 4.5: Several Folders Might Have the Same Name*/
ods document name=mylib.morecars (WRITE);
ods html file="program4_5.html";
	proc sort data=sashelp.cars out=WORK.cars;
	/* nothing against Hybrids, I promise! */
		where upcase(type) ne 'HYBRID';
		by origin type;
	run;
	title1 "Explore inverse relationship between weight and mileage";
	data cars;
		set cars;
		invw = 1/weight;
	run;

	proc reg data=cars ;
		model mpg_highway = invw;
		run;
	quit;

	title "Are people paying more for high mileage?";
	proc reg data=cars;
		model msrp = mpg_highway;
		run;
	quit;

	title "Maybe it's something else";
	proc reg data=cars;
		model msrp = mpg_highway weight horsepower cylinders;
		run;
	quit;

	title "Same model as #3 with more diagnostic plots";
	proc reg data=cars;
		model msrp = mpg_highway weight horsepower cylinders / all;
		run;
	quit;
ods document close;

	proc document name=mylib.morecars;
		list;
		run;
	quit;
ods html close;

/*Program 4.6: Replaying without Sequence Number*/
ods html file="program4_6.html";
	proc document name=mylib.morecars;
		list reg;
		run;
		replay reg;
		run;
	quit;
ods html close;

/*Program 4.7: Replaying without Sequence Number*/
ods html file='Program4_7.html';
	proc document name=mylib.firstdoc;
		list reg#1 ;
		run;
	quit;
ods html close;

/*Program 4.8: Levels=1 Starting with a Folder Name*/
ods html file="program4_8.html";
	/* data=cars was defined in program 1.1 */
	ods document name=mylib.morecars(update) ;  /* docname in book is wrong */
		proc univariate data=cars normaltest;
		by origin type;
		var msrp weight horsepower;
		cdfplot msrp;
		run;
	ods document close;

	proc document name=mylib.morecars;
		list univariate / levels=1;
		run;
	quit;
ods html close;

/*Program 4.9: All Levels of the Entire Document*/
ods html file="program4_9.html";
	proc document name=mylib.morecars(read);
		list univariate#1 / levels=all;
		run;
	quit;
ods html close;

/*Program 4.10: Listing More Than One Folder*/
ods html file="program4_10.html";
	proc document name=mylib.firstdoc;
		title "When you list pathnames separated by a comma, separate tables";
		title2 "Are generated";
		list freq,reg#1 / levels=3;
		run;
	quit;
ods html close;

/*Program 4.11: A Detail Listing of the Univariate Tree, at the Highest Folder Level*/
ods html file="program4_11.html";
title "Simple Detailed More Listing";
proc document name=mylib.morecars(update);
list univariate#1 / levels=1 details;
run;
quit;
ods html close;
title;
	/*Program 4.12: Possibilities for the ORDER= Option*/
	ods html file="program 4_12.html";
	proc document name=mylib.firstdoc;
	title "Alpha Order";
	list / levels=1 details order=alpha;
	run;
	title "Insert Order";
	list / levels=1 details order=insert;
	run;
	title "Date Order";
	list / levels=1 details order=date;
	run;
	quit;
	ods html close;

/*	Program 4.13: Entire Document Listing Including BY-Group Variables*/
ods html file="program4_13.html";
	proc document name=mylib.morecars(read); 
		title "Univariate Output";
		list univariate / levels=all bygroups; 
		run;
	quit;
ods html close;

/*Program 4.14: Without the BYGROUPS Option*/
proc document name=mylib.firstdoc;
ods html file="example4_14.html";
title "No By Groups in listing";
list univariate / levels=all;
run;
title;

/*Program 4.15: No Output*/
/* write access mode ensures that you start with an empty document */
ods document name=explore(write);
proc univariate data=sashelp.retail;
run;
ods document close;
proc document name=explore;
list / levels=all details bygroups;
run;
quit;

/*Program 4.16: Only Output with BY-Groups is shown*/
ods html file="program4_16.html";
proc document name=mylib.firstdoc;
list / bygroups levels=all;
run;
quit;
ods html close;

/*Program 4.17: Examples of Selecting Output Using the WHERE= Option*/
ods html file="program4_17.html";
proc document name=mylib.quickstart(read);
    /* searching for a path name */
	title "LIST 1: Output Objects Pertaining to Vehicle Weight";
	list ^(where=(_path_ ? "Weight")) / levels=all;
	run;
	title "LIST 2: Listing of Tables";
	list ^(where=(_type_ = "Table")) / levels=all;
	run;
	title "LIST 3: All Tables and Graphs";
	list ^ (where=(_type_ in ('Table','Graph'))) / levels=all bygroups;
	run;
	title "LIST 4: Using BY-Group variable as a search parameter";
	list ^ (where=(_type_ = "Table" and Origin="Asia"))/ levels=all
	bygroups;
	run;
quit;
ods html close;

/*Program 4.18: Using a Specific Path*/
ods html file="program4_18.html";
title "Using WHERE statements To Find Cumulative Distribution Plots";
proc document name=mylib.morecars;  /* was temp2 in book, which is incorrect */
list univariate#1(where=(_name_='CDFPlot')) / levels=all bygroups;
run;
quit;
ods html close;
title;

/*Program 4.19: When WHERE= Statements Fail*/
ODS HTML file='program4_19.html';
proc document name=mylib.quickstart;
	/* type here refers to a data set variable, NOT the
	/* document variable object type. */
	/* the lack of underscore means data set variabless */
	list univariate(where=(type='Weight ?'));
	run;
quit;
ods html close;

/*Program 4.20: Debug Program 4.19 by Removing the WHERE= Clause*/
ods html file='program4_20.html';
proc document name=mylib.quickstart;
list univariate / levels=1;
run;
quit;
ods html close;

/*Program 4.21: Corrected Version*/
ods html file='program4_21.html';
proc document name=mylib.quickstart;
list univariate(where=(upcase(_path_) ? 'WEIGHT')) / levels=all;
run;
quit;
ods html close;

/*Program 4.22: Two Equivalent Ways of Searching for an Output Object*/
proc document name=mylib.firstdoc;
/* tomato */
list reg#2(where=(_NAME_ in ('FitStatistics','ParameterEstimates')));
run;
/* tomahtoe */
list reg#2(where=((_path_ ? 'FitStatistics') or ( _path_ ? 'ParameterEstimates')));
run;

quit;

title;

/*Program 4.23: Searching on _LABELPATH_*/
ods html file='program4_23.html';
ods document name=explore(write);

	/* write mode used because the aim is to start
	From scratch with an empty document */
	proc univariate data=sashelp.retail;
	run;
ods document close;
proc document name=explore;
	list ^ (where=(_labelpath_ ? "The Univariate Procedure"));
	run;
quit;
ods html close;

/*Program 4.24: Assigning Labels*/
ods html file="program4_24.html";
proc document name=mylib.firstdoc;
	setlabel reg#1 'Model is weight = height + error, by sex. ';
	setlabel reg#2 'Same Model as Reg#1 no grouping by sex';
	list / details levels=1;
	run;
quit;
ods html close;

/*Program 4.25: SETLABEL Can also Label a Document as a Whole*/
/* if the DOC statement gives an error saying LIBRARY XXXX Does not exist
    then submit the statement LIBNAME XXXX CLEAR; prior to running PROC DOCUMENT
   and resubmit */
ods html file='program4_25.html';
proc document ;
/* no current document needed for this example */
setlabel \mylib.firstdoc\ 'First Document: Analysis of SASHELP.CLASS';
setlabel \mylib.quickstart\ 'Quick Start : Analysis of SASHELP.CARS';
doc;
run;
quit;
ods html close;

/*Program 4.26: Searching by Label*/
ods html file="program4_26.html";
proc document name=mylib.firstdoc;
	setlabel freq 'First Attempt';
	list ^(where=(_label_ ='First Attempt'));
run;
quit;
ods html close;

/*Program 4.27: Labels of Folders and Subfolders are Independent of One Another*/
ods html file="program4_26.html";
title "Labels do not cascade";
proc document name=mylib.firstdoc;
	setlabel freq 'First Attempt';
	list ^(where=(_path_ ? 'Freq')) / levels=all details;
	run;
quit;
ods html close;
title;

*************************************************************;
* Chapter 5: The REPLAY Statement
*************************************************************;
/*Program 5.1: Default Behavior of the REPLAY Statement Is to Replay to all Open Destinations*/
ods pdf file="program5_1.pdf";
ods html(id=bluish) file="program5_1.html" newfile=none style=htmlblue ;
ods html(id=serious) file="chap5_simple.html" style=statistical;
ods tagsets.excelxp file="chap5.xml";
ods listing close;
proc document name=mylib.firstdoc(read); 
	replay univariate#1\bygroup1#1\height\moments; 
	run; 
quit;
ods _all_ close; 

/*Program 5. 2: Illustrating Different Output Formats*/
/* same ODS destinations as program 5.1 */
ods pdf file="program5_1.pdf";
ods html(id=bluish) file="program5_1.html" newfile=none style=htmlblue ;
ods html(id=serious) file="chap5_simple.html" style=statistical;
ods tagsets.excelxp file="chap5.xml";

proc document name=mylib.firstdoc;
	replay reg / dest=(tagsets.excelxp html(id=bluish));
	run;
quit;
ods _all_ close;

/*Program 5.3: Changing the Order of Replay*/
ods pdf file='program5_3.pdf';
proc document name=mylib.quickstart;
	replay  means , contents\dataset\variables / dest=pdf; /* book has sgpanel, which is wrong  */
	run;
quit;
ods pdf close;
/*Program 5.4: Replaying Using the WHERE Option*/
ods html(id=serious) file='program5_4.html' style=analysis;
ods pdf file='program5_4a.pdf';
proc document name=mylib.firstdoc(read);

replay univariate(where=(_name_='Moments'))
/ dest=html(serious);
run;
replay univariate(where=(_path_ ? 'Height'))
/ dest=html(serious);
run;
replay reg#1(where=(sex='F')) /  dest=pdf;
run;
quit;
ods _all_ close;


/*Program 5.5: Replaying the First Row of an Output Object*/
ods html file='program5_5.html';
proc document name=mylib.firstdoc;
	title "Replaying Part of an ODS Table";
	replay univariate#1\bygroup1#1\Height#1\quantiles
	(where=(_obs_ = 1)) / activetitle;
	replay univariate#1\bygroup2#1\Height#1\quantiles
	(where=(_obs_ = 1));
	run;
quit;
ods html close;

/*Program 5.6: Which Path to Replay?*/
ods html file='program5_6.html';
proc document name=mylib.firstdoc;
title;
list univariate#1(where=(upcase(_path_) ? 'HEIGHT' and upcase( _name_) =
'QUANTILES' and upcase(_type_) ='TABLE')) / levels=all bygroups;
run;
quit;
ods html close;

/* Program 5.7: Replaying the Last Five Rows of a SAS Table */
ods html file='program5_7.html';
proc document name=mylib.firstdoc;
title;
replay univariate#1\bygroup1#1\
	height#1\quantiles#1(where=(_obs_ >= _max_ - 5));
	run;
quit;
ods html close;

ods pdf file='program5_8.pdf';
proc document name=mylib.quickstart;
replay means\summary(where=(type='SUV'));
run;
quit;
ods pdf close;

/* Program 5.9 Program 5.9: Procedure Code Might Be Stored Differently Than It Appears */
ods document name=mylib.firstdoc;
proc means data=sashelp.class;
class sex;
run;
ods document close;

ods html file='program5_9.html';
proc document name=mylib.firstdoc;
	setlabel means#1 'Demonstration of Subsetting from Chapter 5';
	run;
	ods output summary=example;
	replay means\summary(where=(_obs_ = 1));
	run;
	ods output close;
quit;

proc print data=example;
run;

ods html close;

/*Program 5.10: Reordering Output across BY Groups*/
ods html file="program5_10.html";
proc document name=mylib.firstdoc;
replay ^(where=(sex='F')) ;
replay ^(where=(sex='M')) ;
run;
quit;
ods html close;

/*Program 5.11: Saving a Document with a Temporary Format work.dummy*/
proc format;
value $dummy 'F'='1'
'M'='0';
run;
ods document name=mylib.smaller(write);
ods html style=rsvp file='program5_11.html';
proc sql;
select sex format=$dummy.,name,age,height
from sashelp.class
order by name;
quit;
ods document close;
ods html close;

/*Program 5.12: Replaying a Document with a Temporary Format*/
ods html file='program5_12.html';
proc document name=mylib.smaller;
replay;
run;
quit;
ods html close;


/*Program 5.13: Using Permanent Formats*/
/* Let SAS know that you want to search for formats in MYLIB
before WORK. This gives the permanent format precedence */
options fmtsearch=(mylib library work);
ods html style=highcontrast;
proc format lib=mylib; /* specify LIB= to make format permanent */
value $dummy 'F'='1'
'M'='0';
run;
ods document name=mylib.smaller(write);
	proc sql;
	select sex format=$dummy3.,name,age,height
	from sashelp.class
	order by name;
	quit;
ods document close;
/* first replay */
%rtfdest(05,10);
title 'With original value of MYLIB.DUMMY format';
proc document name=mylib.smaller;
	replay sql#1\sql_results(where=(_obs_ < 3)) / activetitle;
	run;
quit;
/* reformat */
/* you need this to override definition in work library */
options fmtsearch=(mylib library work);

proc format lib=mylib;
	value $dummy 'F'='1:F' 'M'='0:M';
	run;
/* second replay */
title 'With new format. Note this part does not change!';
title2 'But the output format does!';

proc document name=mylib.smaller;
	replay sql#1\sql_results(where=(_obs_ < 3))/ activetitle;
	run;
quit;
ods rtf close;

*************************************************************;
* Chapter 6: Managing Folders
*************************************************************;
/*Program 6.1: Making a Subfolder at the End of the Current Path*/
proc document name=mylib.quickstart;
make graphs_only;
/* You could also have written the MAKE statement */
/* using the equivalent forms */
* make \graphs_only;
* make \mylib.firstdoc\graphs_only;
title 'New Folders at End';
list;
run;
quit;

/*Program 6.2: Making Subfolders at the Beginning of the Current Path*/
proc document name=mylib.quickstart;
  make us_only / first;
  make europe_only / after= us_only;
  make asia_only / after= europe_only;
  title 'New Folders at Front';
list;
run;
quit;

/*Program 6.3: Making a Subfolder in the Path Below*/
	proc document name=new(write);
		make dataquality;
		setlabel dataquality 'Basic reports to assess a new data set \
		such as Freqs, Missing Values, Means';
		make dataquality\histograms;
		make dataquality\character_vars;
		list / details levels=3;
		run;
	quit;

/*Program 6.4: Setting Up a Document Before Starting Work*/
proc document name=mylib.drugs;
	make new_cardiac_drug;
	make new_cardiac_drug\marketing_surveys;
	make new_cardiac_drug\clinical_trials;
	make new_cardiac_drug\clinical_trials\pt_recruitment;
	make new_cholesterol_drug;
	/* etc */
	run;
quit;

/* program 6.5: A useful template for storing your own work */
ods document name=mylib.drugs dir=(path=\path\to\your\work);
/* sas code */
ods document close;

/*Program 6.6: Navigating Folders*/
/* this version differs from the book only in that the titles
   are more carefully managed */
ods html style=htmlblue;
ods noproctitle;
title;
options nobyline;
/* Need to use the activetitle option to use
   the titles in this program.  */
proc document name=mylib.quickstart;
	dir univariate;
	dir bygroup1#1; /* Origin=Asia, type=Hybrid */
	dir;
	title "Asian Car Wheelbase Data (in inches)";
	title2 "Start with SUV...";
	replay wheelbase\basicmeasures / activetitle;
	run;
	title;
	dir ^^; /* navigate up to parent folder */
	dir; /* show current folder */
	run;
	title "For Sedans, now...";
	dir bygroup2#1; /* Origin=Asia, type=SUV */
	dir; /* show folder again */
	replay wheelbase\basicmeasures / activetitle;
	run;
	/* in one statement, navigate to bygroup3#1; */
	dir ^^\bygroup3;
	run;
quit;
ods html close;

/*Program 6.7: Renaming a Document*/
/* just an example of renaming - not meant to be run */
%macro skip3; 
proc document name=mylib.Bigger;
rename Mylib.bigger TO Mylib.atomic;
run;
quit;
%mend;

/*Program 6.8: Renaming a Folder*/
ods html file="program6_8.html" newfile=none;
proc document name=show(write);
    make folder; /* folder #1 */
	make folder; /* folder #2 */
	make folder#1\subfolder;
	make folder#1\subfolder; /* will make subfolder#2 */
	/* move into folder */

	make folder#2\subfolder;
	make folder#2\subfolder;

dir folder#1;
	setlabel subfolder#1 "Will you remember what 'subfolder#1' contains?";
	dir ^^;
	title "Before";
	list / details levels=2;
run;
quit;

/* although you can combine these two statements into one,
   the idea was that you would run one today, and the other
   some time later... */

proc document name=show(update);
	title "After Rename";
	rename folder#1 to retail_report ;
	setlabel retail_report 'Logistics Reports by Region, 2010-2013';
	dir retail_report;
	rename subfolder#1 to east_region;
	setlabel east_region 'East Region Reports';
	rename subfolder#2 to west_region;
	setlabel west_region 'West Region Reports';
	dir ^^; /* go to parent directory */
	list / details levels=2;
	run;
   
	
    rename folder#2 to Cardiac_Drugs;
	dir Cardiac_Drugs;
	rename subfolder#1 to sales_2010;
	rename subfolder#2 to sales_2011;
	setlabel sales_2010 'Ah, Much better';
	run;
	quit;
ods html close;

* ------------------ the COPY TO Statement -------------------;
/*Program 6.10: Backing Up a Document*/
proc document name=mylib.backup(write);
	copy mylib.firstdoc to ^;
	run;
quit;

/*Program 6.11: Backing Up a Document to a Subfolder*/
ods html file="program6_11.html";
proc document name=try(write) label='WORK.TRY: Backup of MYLIB.FIRSTDOC';
	make old_stuff;
	setlabel old_stuff 'Original Document used to write book';
	dir old_stuff;
	copy mylib.firstdoc to ^;
	run;
	list / levels=2 details;
	quit;
ods html close;

/*Program 6.12: Sending a Folder from One Document to Another*/
proc document name=mylib.again(write) label='Copy Examples';
quit;
proc document name=mylib.firstdoc;
copy univariate to \mylib.again\;
run;
quit;

/* Program 6.13: Source and Ancestor path */
/* this program is intended to produce an ERROR messsage */
proc document name=mylib.firstdoc;
	make graphs_only;
	/* problem */
	copy ^(where=(_type_ = 'Graph')) to graphs_only;
	/* OK - source path (univariate) is not an ancestor to
	destination(graphs_only)*/
	copy univariate#1(where=(_type_='Graph')) to graphs_only#1;
quit;

/* program 6.14: This is essentially an example of Program 6.5. 
   see a theme here? */

ods document name=mylib.betterdoc dir=(path=\chapter3 label='Redone');
/* code from program 3.1 */
ods document close;

/*Program 6.15: Creating the Target Folder In Another Document*/
proc document name=mylib.allgraphs(write)
	label='Graphics Objects from Mylib.firstdoc';
	make graphics_dir;
	run;
	copy \mylib.firstdoc\^(where=(_type_='Graph')) to graphics_dir#1;
	run;
quit;

/*Program 6.16: Copying to the Root Level Directory*/
proc document name=mylib.allgraphs(read);
	copy graphics_dir to \mylib.firstdoc\ / levels=all;
	run;
quit;

/*Program 6.17: Using the WHERE= Option to Selectively Copy Based on Conditions*/
ods html file='program6_17.html';
title 'Backup using a WHERE statement';
proc document name=sasuser.archive(write);
	list \mylib.firstdoc\ / details;
	run;
	make january;
	make february;
	make march;
	copy \mylib.firstdoc\(where=(_cdate_>'01Mar2012'd)) to march#1;
	run;
	list / levels=2;
run;
quit;
ods html close;

/*Program 6.18: Destination of COPY Is External to Current Document*/
title 'Outbound Style';
title2 'Not Gangnam Style';
proc document name=mylib.firstdoc;
copy ^(where=(_cdate_>'01Mar2012'd)) to \sasuser.archive\march#1;
run;
quit;

/*Program 6.19: Copy Folder to Current Path*/
ods html file='program6_19.html';
proc document name=mylib.firstdoc;
	copy univariate#1 to ^ / last;
	setlabel univariate#2 'Copy of Univariate Folder';
	list / details;
	run;
quit;
ods html close;

/*Program 6.20: Copy Output Objects in a Folder to Current Path*/
ods html file='program6_20.html';
proc document name=mylib.firstdoc;
	copy univariate#1(where=(_type_ = 'Table')) to ^ / levels=all;
	setlabel univariate#3 'Output Objects from Univariate Only.
	No Subfolders (seqno=#3)';
	run;
	list;
	run;
quit;
ods html close;

/*Program 6.21: Copying with the LEVELS= Option*/
proc document name=mylib.trial(write);
	make phaseI;
	make phaseI\DosageRangeTests;
	make phaseII;
	make PhaseII\efficacy;
	make PhaseII\sideEffects;
	make phaseII\sideEffects\scratchpad;
	make PhaseII\Adverse;
	make phaseIII;
	make phaseIII\efficacy;
	make phaseIII\sideEffects;
	make phaseIII\additionalInfo;
	make phaseIV;
	make phaseI\Physicians;
	make phaseI\Recruitment;
	make phaseII\Recruitment;
	make informedConsent;
	make phaseII\sitecostData;
	make ClosedSites;
	run;
quit;
proc document name=newtrial;
copy mylib.trial to ^ / levels=2;
run;

/*Program 6.22: Managing the Order of Files Using the MOVE TO Statement*/
ods html file='Program6_22.html';
proc document name=mylib.drugs;
	make cardiac_drug;
	dir cardiac_drug;
	make sales_2011,sales_2010,sales_2009,sales_2008;
	move sales_2011 to ^ / first;
	list;
	run;
quit;
ods html close;

/*Program 6.23: Moving Output to a Subfolder*/
proc document name=mylib.doccopy(write);
	copy mylib.firstdoc to ^; 
	make new_stuff ;
	setlabel new_stuff 'Material for Second Edition';
	make old_stuff;
	setlabel old_stuff 'Material from First Edition';
	move univariate#1,freq#1,reg#2 to old_stuff; 
	run;
quit;

/*Program 6.24: Shows a Listing of All the Documents Available in a Session*/
ods html file='Program6_24.html';
proc document; /* name not necessary since doc statatement doesn't need a current directory */
	doc;
	run;
quit;
ods html close;

ods html file='program6_25.html';
title 'Temporary';
proc document;
doc lib=work;
run;
quit;
ods html close;

/*Program 6.25: Listing Temporary Documents*/
ods html file='program6_25.html';
title 'Temporary';
proc document;
	doc lib=work;
	run;
	quit;
ods html close;

/*Program 6.26: DOC NAME= Opens a Document*/
ods html file='program6_26.html';
proc document;
	title "Quick Start Document from Chapter 1";
	doc name=mylib.quickstart label="Analysis of SASUSER.CARS";
	list;
run;
doc close;
title "Firstdoc Document from Chapter 3";
doc name=mylib.firstdoc;
	list;
run;
doc close;
title "All Documents in all libraries, Showing Labels";
doc ;
run;
quit;
ods html close;

/*Program 6.27: Deleting Entire Documents Before and After SAS 9.3*/
%macro delete_document(libname,memname);
Proc document;
	/* 9.3 and later */
	DELETE &libname. &memname.;
	doc;
	run;
	quit;

	/*prior to 9.3 you have to do this */
	proc datasets lib=&libname. memtype=itemstor;
	delete &memname.
quit;
%mend delete_document;

/*Program 6.28: Attempt to Delete the Current Directory*/
proc document name=work.firstdoc(write)
	label='Temporary Copy of MYLIB.FIRSTDOC to demonstrate destructive
	operations';
	copy mylib.firstdoc to ^; 
	run;

	dir univariate#1;
	delete ^(where=(_path_ ? '\Age#1')) / levels=all; 
	run;
quit;

/*Program 6.29: Corrected Version*/
proc document name=work.firstdoc(write) label='Temporary Copy of
	MYLIB.FIRSTDOC to demonstrate destructive operations';
	/* current directory is root */
	list ^(where=(_path_ ? '\Age#1')) / levels=all;
	run;
	delete univariate(where=(_path_ ? '\Age#1\')) / levels=all;
	run;
	list / levels=all;
	run;
quit;


/*Program 6.30: Hiding and Its Effect on the LIST Statement*/
ods pdf file='program6_30.pdf';
proc document name=mylib.firstdoc;
hide reg#2;
list / levels=2;
run;
quit;
ods pdf close;

/*Program 6.31: Hiding a Subfolder*/
ods pdf file='program6_31.pdf';
proc document name=mylib.firstdoc;
	hide univariate#1\bygroup1#1\age#1;
	list;
	run;

	list / levels=all;
	run;
quit;
ods pdf close;

/*Program 6.32: Unhiding a Folder*/
ods pdf file='program6_32.pdf';
proc document name=mylib.firstdoc;
	unhide univariate#1\bygroup1#1\age#1;
	unhide reg#2;
	list reg#2,univariate#1/ levels=3;
	run;
quit;
ods pdf close;

/*Program 6.33: A Copy of a Hidden Folder Stays Hidden*/
ods html file='program6_33.html';

proc document name=mylib.chap6;
quit;

proc document name=mylib.firstdoc;
	hide reg#2;
	copy reg#2 to \mylib.chap6\a; /* needs a fix */
	run;
quit;
ods listing;
proc document name=mylib.chap6; /* needs a fix */
	list / levels=2;
	run;
	quit;
ods listing close;


* ----------- EXTENDED EXAMPLES ---------------;
/*Program 6.34: Displaying All Plots in a Project*/
title 'All Graphics';
ods pdf file="allplots.pdf";
proc document name=mylib.firstdoc;
replay ^(where=(_type_='Graph'));
run;
quit;
ods pdf close;

/*Program 6.35: Setup of a Document Where REPLAY with LEVELS= Is Useful*/
ods pdf file='program6_35.pdf';
proc document name=mylib.firstcopy(write); 
	copy \mylib.firstdoc\(where=(_type_='Graph')) to ^; 
	run;
	list / levels=1;
	run;
quit;
ods pdf close;

/*Program 6.36: LEVELS=1 Output*/
ods pdf file="flatterplots.pdf";
proc document name=mylib.firstcopy;
	setlabel freqplot#1 'Bar Plot of Distribution of Variable SEX';
	setlabel cumfreqplot#1 'Cumulative Plot of Variable Sex';
	setlabel diagnosticspanel#1 'Regression Diagnostics for Weight vs.
	Height, no BY grouping';
	setlabel residualplot#1 'Residuals for Weight vs. Height';
	setlabel fitplot#1 'Fit Plots for Weight vs. Height';
	replay / levels=1;
	run;
quit;
ods pdf close;

/*Program 6.37: Setting Up a Two-level Hierarchy of Output*/
/* Needs this version of REG output in order for image to match books's */
ods document name=mylib.firstdoc;
  proc reg data=sashelp.class;
  model weight=height;
  run;
  quit;
ods document close;


ods pdf file='program6_37.pdf';
proc document name=mylib.lev2copy(write);
	copy \mylib.firstdoc\freq(where=(_type_='Graph') ) to ^;
	copy \mylib.firstdoc\reg(where=(_type_='Graph') ) to ^ / levels=all;

	list / levels=all details;
	run;

	setlabel freq#1 'Frequency Distributions';
	setlabel reg#1 'Linear Model of Height vs. Weight';

	replay / levels=2;
	run;
quit;
ods pdf close;
/*Program 6.38: %alldocs Macro*/
%macro alldocs(levels=1,lib=);
%* prints a level 1 listing of all documents in the system;
%********************************************************;
%* invoke proc document to get table of all the documents
%* which will be stored in the table DOCLIST
%********************************************************;
proc document;
	title "All Documents";
	ods output documents=doclist;
/*		ods trace on;*/
			doc %if (&lib ne) %then lib=&lib.; ;
			doc close;
		run;
	ods output close;
quit;
%**********************************************************;
%* build a new document procedure call consisting of a
%* LIST statement for each line in the data set DOCLIST
%**********************************************************;
data _null_;
	length command $512;
	set doclist end=nomore;
/* call proc document before beginning work */
	if _n_ =1 then do;
		call execute('proc document;');
	end;
/* each line of the data set generates a RUN group of */
/* statements to build a listing with a simple title */
	command= cats('list \',name,'\ / levels=',"&levels.;");
	call execute ("Title 'Listing of " || name || "';");
	call execute(command);
	call execute('run;');
/* finish up by closing the document */
	if nomore then call execute('run; quit;');
	run;
%* once the run is executed, the newly built PROC DOCUMENT
%* code will spring to life;
%mend;

options mprint ;
ods html file='all_listings.html' options(pagebreak='no');
%alldocs()
ods html close;

*************************************************************;
* Chapter 7
*************************************************************;

/*Program 7.1: Data for an Example Report*/
proc document name=mylib.chap7(write); 
make example;
	copy \mylib.firstdoc\reg#1(where=
	(_name_ in ('ParameterEstimates','FitPlot'))) 
	to example#1 / levels=all;
	run;
	list / levels=all details bygroups;
	run;
quit;

/*Program 7.2: Restricting Attention to Output Objects*/
proc document name=mylib.firstdoc;
	list reg#1(where=(_type_ not in ('Dir','Link','Note'))) / levels=all;
	run;
quit;

/*Program 7.3: The Object Context*/
ods html file='program7_3.html';
proc document name=example; /* of objectcontext */
	/* copy some output to the current directory */
	copy \mylib.firstdoc\univariate\bygroup1\height to ^;
	dir height;
	/* main work starts here */
	obtitle moments 'Main Title (OBTITLE1 or OBTITLE)';
	obtitle2 moments 'Second Main Title (OBTITLE2)';
	obstitle moments 'Subtitle (OBSTITLE1 or OBSTITLE) A non-null value Blanks out PROCTITLE name –e.g. '' The UNIVARIATE Procedure'')';
	obstitle2 moments 'A second subtitle (OBSTITLE2)';
	obstitle3 moments 'Next comes the BYLINE' / just=l;
	obbnote moments 'First Before Note (OBBNOTE1)';
	obbnote2 moments 'Second Before Note (OBBNOTE2)';
	obanote moments 'First After note (OBANOTE) ';
	obanote2 moments 'Second After Note (OBANOTE2)';
	obanote3 moments '.';
	obanote4 moments '.';
	obanote10 moments 'Tenth After Note (OBANOTE10) (can have up to ten of
	each kind of note, just like SAS Titles and Footnotes)';
	obfootn moments 'First Footnote (OBFOOTN)';
	obfootn2 moments 'Second Footnote (OBFOOTN2)';
	replay moments;
	run;
quit;
ods html close;

/*Program 7.4: REPLAY Statement for the Extended Example Folder*/
ods pdf file="program7_4.pdf";
proc document name=mylib.chap7;
	replay example;
	run;
quit;
ods pdf close;

/*Program 7.5: Removing Page Breaks*/
ods document name=mylib.tabulate_test(write);
	proc tabulate data=sashelp.class;
	var weight height age;
	table height*mean;
	table age*mean;
	table weight * mean;
	run;
ods document close;
ods pdf file="program7_5.pdf";
proc document name=mylib.tabulate_test;
	dir tabulate\report;
	list / details; 
	obpage table#2 / delete; 
	obpage table#3 / delete;
	setlabel table#1 'Height Mean'; 
	setlabel table#2 'Age Mean';
	setlabel table#3 'Weight Mean';
	replay;
	run;
quit;
ods pdf close;

/*Program 7.6: Listing the Page Breaks*/
ods html file= 'pbtest.html';
title 'Page Breaks';
proc document name=example(write);
	copy \mylib.firstdoc\univariate#1\bygroup1\height to ^;
	copy \mylib.firstdoc\univariate#1\bygroup2\height to ^;
	run;
	dir height#1;
	obpage moments / after; 
	obpage basicmeasures; 
	dir ^^;
	dir;
	list / levels=all details;
	run;
	replay;
	run;
	quit;
ods html close;

/*Program 7.7: Adjusting the Pagination*/
ods pdf file="program7_7.pdf";
	proc document name=mylib.chap7;
	title 'Replay #1 - Paging';
	dir example\reg;
	obpage parameterestimates;
	run;
	replay / activetitle;
	run;
	quit;
ods pdf close;

/*Program 7.8: Setting the Titles in the Example Report*/
ods pdf file="program7_8.pdf";
proc document name=mylib.chap7;
	title 'Replay #2';
	list example\reg / bygroups; 
	run;
	dir example\reg;
	obpage parameterestimates;
	obtitle1 parameterEstimates#1 "Parameter Estimates"; 
	obtitle2 parameterEstimates#1 "Basic Model, no interactions";
	obtitle3 parameterEstimates#1 "Normal Error Assumed";
	replay;
	run;
	quit;
ods pdf close;

/*Program 7.9: Deleting Titles*/
ods pdf file="program7_9.pdf";
options nodate;
proc document name=mylib.chap7;
	dir example\reg;
	obtitle2 parameterestimates#1;
	run;
	replay;
	run;
	quit;
ods pdf close;

/*Program 7.10: Blank Titles*/
ods pdf file="program7_10.pdf";
options nodate;
proc document name=mylib.chap7;
	title 'Replay #2';
	dir example\reg;
	obtitle1 parameterEstimates#1 "Parameter Estimates";
	setlabel parameterestimates#1 'Parameters: Sex=F';
	obtitle2 parameterEstimates#1;
	obtitle3 parameterEstimates#1 "Normal Error Assumed";
	replay;
	run;
quit;
ods pdf close;

/*Program 7.11: The ACTIVETITLE Option Uses Global SAS TITLE Values for Replay*/
ods pdf file="program7_11.pdf";
options nodate;
proc document name=mylib.chap7;
	title1 'Replay #3: Demonstrating the Active Title';
	title2 'Fit Plot for Sex=M only';
		dir example\reg;
		replay fitplot#2 / activetitle;
		run;
	quit;
ods pdf close;
/*Program 7.12: The SHOW Option to OBTITLE*/
footnote "Created &sysdate. by &sysuserid.";
title 'The OBTITLE list as a TABLE using the SHOW option';
ods html file='program7_12.html' style=listing;
proc document name=example;
dir height;
obtitle moments show;
run;
ods html close;

/*Program 7.13: Customizing Titles and Subtitles*/
ods pdf file='program7_13.pdf';
proc document name=mylib.chap7;
	dir example\reg;
		obtitle parameterestimates#1 "SASHELP.CLASS Analysis";
		setlabel parameterestimates#1 "Table 1: Parameter Estimates";
		obtitle2 parameterestimates#1 "Table 1: Parameter Estimates";
		obstitle1 parameterestimates#1 ""; /* could put it back */
		obstitle2 parameterestimates#1 "Model: MODEL1";
		obstitle3 parameterestimates#1 "Dependent Variable: Weight";
		obstitle parameterestimates#1 show;
		replay parameterestimates#1;
	run;
quit;
ods pdf close;

/*Program 7.14: Using #BYVAL and #BYVAR Variable Values in Text*/
options nobyline; 
ods html file='program7_14.html'
contents='program7_14_c.html'
frame='program7_14_f.html';
proc document name=mylib.quickstart;
	dir univariate;
	DIR BYGROUP10#1\MPG_HIGHWAY;/* USA SUV*/
	obtitle moments "SUV Analysis";
	obtitle2 moments "Table 2 : Fuel Economy";
	obstitle1 moments '#BYVAL2 from #BYVAL1' / just =l; 
	obstitle2 moments "For this table, BYVAR1=#BYVAR1 and BYVAR2=#BYVAR2"
	/ just=L;
	replay moments;
	list / levels=1 details; 
	run;
quit;

ods html close;



/*Program 7.15: Using #BYLINE in a Title*/

/* this ODS output was omitted from the book
   and needs to be entered into the document */



ods html file='program7_15.html';
options byline;
proc document name=mylib.chap7;
dir example;
  

  list / levels=all;
  run;

  replay;
  run;


quit;
ods html close;

/*Program 7.16: Enhancement to MYLIB.CHAP7 Document Output*/
ods pdf file="program7_16.pdf";
proc document name=mylib.chap7;
dir example\reg;
	title "Slope Comparison";
	footnote "Exhibit printed on &SYSDATE.";

	obpage parameterestimates#1 / after delete;
	obpage parameterestimates#2 / delete;

	obbnote parameterestimates#1 "Females";
	obbnote parameterestimates#2 "Males";
	obanote parameterestimates#2 "Notice the in this class, males gain 3.9 lbs
per additional inch of ";
	obanote2 parameterestimates#2 "height as compared with 3.4 lb/in. for
females";
	obanote4 parameterestimates#2 "Comments here , meant to illustrate the
OBANOTE statement, are not " / just=l;
	obanote5 parameterestimates#2 "intended to illustrate or recommend
proper statistical procedure" / just=l;
replay parameterestimates#1,parameterestimates#2 / activetitle;
run;
ods pdf close;

/*Program 7.17: Adding Notes to a Document*/
ods document name=mylib.new(write);
ods html file='program7_17.html';
title "Reporting on Progress of Computation";
proc sql;
	create table economy as
	select * from sashelp.cars
	where mpg_highway > 35;
quit;
%let rowCnt=&sqlobs.;
/* create a text string conditional on # of observations */
%macro noteit(n);
	%if &n < 30 %then "Result returned fewer than 30 entries (N=&n.). You
	may
	have too small a sample to make useful inferences";
	%else "Population is (N=&n.)";
%mend;
ods text = %noteit(&rowCnt.);
/* create note whose text depends on the SQL procedure output */

proc univariate data=economy;
	var mpg_highway msrp;
run;
ods document close;
proc document name=mylib.new;
	replay;
	run;
quit;
ods html close;

/*Program 7.18: Appearance of the Document Note in the Listing*/
ods html file="program7_18.html";
proc document name=mylib.new;
	list / levels=all;
	run;
	quit;
ods html close;

/*Program 7.19: Inserting and Positioning a Note*/
ods pdf file='program7_19.pdf';
proc document name=mylib.chap7;
dir example;
note mynote "Please consider the environment when printing this document"
/
first just=l;
replay;
run;
quit;
ods pdf close;

/*ods trace off;*/
/*Program 7.20: Excluding Notes from Replay with the HIDE Statement*/
ods html file="program7_20.html";
proc document name=mylib.new;
	hide text#1;
	dir univariate\mpg_highway;
	run;
	replay;
	run;
quit;
ods html close;

ods html file="program7_21.html";
proc document name=mylib.new;
	dir univariate\mpg_highway#1;
	note iwantthiscar "Apparently there is a car that
	gets 66 miles to the gallon" / before=extremeobs;
	note iwantthis "Need to come back to investigate further. Outlier, or
	money saver?" / after=iwantthiscar#1;
	replay;
	run;
quit;
ods html close;

/*Program 7.22: Final Report*/
ods pdf file='Final Changes.pdf';
ods html file='final changes.html';

proc document name=mylib.chap7;
	dir example\reg;
	setlabel ^ "Height Weight study for SASHELP.CLASS Data"; 
	obtitle parameterestimates#2; 
	obpage parameterestimates#2;
	obstitle parameterestimates#2;
	obanote4 parameterestimates#2 "Comments here , meant SOLELY to
	illustrate the OBANOTE statement,are not";
	obanote5 parameterestimates#2 "intended to illustrate or recommend
	generally accepted statistical procedure"; 
	/* get the bookmarks right */
	setlabel parameterestimates#1 'Table 1: Weight vs. Height for Females';
	setlabel fitplot#1 'Graph 1: Line of Best Fit (Females)';
	setlabel parameterestimates#2 "Table 2: Weight vs. Height for Males";
	setlabel fitplot#2 'Graph 2: Line of Best Fit (Males)'; 
	run;
	replay;
	run;
quit;
ods pdf close;
ods html close;

*************************************************************;
* Chapter 8: Exporting to Data Sets
*************************************************************;

/*Program 8.1: Saving Objects to Data Sets Using the OUTPUT Destination*/
ods output quantiles=distrs
	basicMeasures=summaries; 
proc univariate data=sashelp.cars;
	where type='SUV';
	var mpg_highway;
run;
ods output close;

proc sort data=sashelp.cars out=WORK.cars;
where upcase(type) ne 'HYBRID';
by origin type;
run;
ods output basicmeasures=b quantiles=q;
proc univariate data=cars;
by origin type;
var mpg_highway mpg_city;
run;

/*Program 8.3: ODS OUTPUT and ODS DOCUMENT Together*/
ods output quantiles=q
basicMeasures=b; 
proc document name=mylib.quickstart;
replay / dest=output; 
run;
quit;
ods output close; 

/*Program 8.4: Combining Reports Using the OUTPUT Destination*/
ods output basicmeasures=b quantiles=q moments=m;
title "Combining Data Sets using the OUTPUT Destination";
proc document name=mylib.quickstart;
	replay univariate (where=(_path_ ? 'MPG')) / dest=output ;
	run;
	quit;
ods output close;

/*Program 8.5: Reshaping the Data*/
data medians;
	length mileage_type $8; /* to avoid truncation */
	set q;
	where quantile='50% Median';
	mileage_Type=substr(varname,5); /* remove MPG_ */
	drop varname;
	rename type=vehicle_type; /* to clarify variable names */
run;
proc sort data=medians;
	by mileage_type vehicle_type origin;
run;

/*Program 8.6: Building a Graph from Reshaped Data*/
ods document name=mylib.quickstart dir=(path=\new_exhibits label='ODS Output Demonstrations');
ods html file="program8_6.html";
	goptions device=png;
	proc sgpanel data=medians;
		panelby vehicle_type mileage_type / layout=lattice columns=2;
		vbar origin / response=estimate datalabel=estimate;
	run;
ods html close;
ods document close;

/*Program 8.7: Output Stored and Annotated*/
ods html file="program8_7.html";
	ods graphics / width=3.5in height=3in;
proc document name=mylib.quickstart;
	dir new_exhibits;
	dir sgpanel;
	setlabel sgpanel#1 'SUV and Sedan';
	setlabel sgpanel#2 'Sports and Truck';
	setlabel sgpanel#3 'Wagons';
	list / details;
	obbnote sgpanel#1 'Analyses of City MPG by Origin and Type';
	obanote sgpanel#2 'Notice that USA has lowest MPG in City Mileage for
	Sports Cars' ;
	obanote sgpanel#3 'Notice that USA has highest MPG in City Mileage for
	Wagons' ;
	run;
	replay;
	run;
quit;
ods html close;

/*Program 8.8: Outputting LIST Data to a Data Set*/
ods listing close;
proc document name=mylib.firstdoc;
ods output properties=simple; 
	list / details;
	run; 
ods output close;
quit;

/* Program 8.9 & Program 8.10: A Complete Listing of the Document as a Data Set */
title 'A Complete List';
ods html file='Program8_9.html';
%let docname=mylib.firstdoc;
%let outds=detail;
proc document name=&docname.;
	ods output properties=&outds.;
	list / levels=all bygroups details;
	run;
	ods output close;
quit;
proc contents data=&outds. Varnum;
run;

proc print data=detail(obs=3);
id path;
;/* full output would be very wide*/
run;
ods html close;

/*Program 8.11: Building Custom Labels for All Qualifying Output Objects*/
%macro doclist(docname=,outds=);
	proc document name=&docname.;
	ods output properties=&outds.;
	list / levels=all bygroups details;
	run;
	ods output close;
	quit;
%mend;
/* get the listing */
%doclist(docname=mylib.firstdoc,outds=docdata) 

/* this macro is called by the DATA step to
   execute PROC DOCUMENT once for each file */
%macro setlb(doc=,obj=,lbl=); 
	proc document name=&doc. ;
	setlabel &obj. &lbl. ;
	quit;
%mend setlbl;
options mprint mlogic;
data _null_;
	length command $500 ;
	set docdata;
	if index(path,'Quant') then do; 
	/* build the command */
	/* variable is in third position on the path */
	var=scan(path,3,'\');
	/* strip out sequence number */
	pdpos=index(var,'#');
	var=substr(var,1,pdpos-1);
	/* build the label out of the listing components */
	mylbl=catx(' ','Quantiles for ',
	var,': sex =',sex,
	'Report year',put(today(),year4.));
	/* here is the command that creates a label for each 
	   object.*/
	command=cats('%setlb','(doc=mylib.firstdoc,obj=',
	path,' ,lbl="',mylbl,'")'); 
	put 'executing ' command;
	call execute(command); 
	end;
	run;
ods html file='newlabs.html';
proc document name=mylib.firstdoc;
list ^(where=(_name_='Quantiles')) / details levels=all;
run;
quit;
ods html close;

/* program 8.12 is just an excerpt from 8.11 and is for discussion purposes only. */

* ------------------------- THE SASEDOC ENGINE section --------------;
/*Program 8.13: Accessing a Directory of Output*/
libname univ SASEDOC
'\mylib.firstdoc\Univariate#1\ByGroup1#1\Height#1';
/*Program 8.14: Viewing the UNIV Library*/
ods html file='program8_14.html';
proc datasets lib=univ;
quit;
ods html close;

/*Program 8.15: Accessing ODS Output via the SASEDOC LIBNAME Engine*/
ods html file='program8_15.html';
title 'Using the SASEDOC Engine';
proc print data=univ.moments;
run;
ods html close;

/*Program 8.16: Saving and Recalling a Graphics Object as a Table*/
footnote1 "data: sashelp.shoes";
title1 "Compare Sales By Region";
goptions device=actximg;
ods document name=oldgraphtest(write);
proc gchart data=sashelp.shoes;
	pie region / sumvar=sales;
	run;
quit;
ods document close;
footnote1;

/*Program 8.17: Viewing the Document as a SAS Library*/
libname oldgraph sasedoc '\work.oldgraphtest\gchart';
ods html file="program8_17.html";
proc datasets lib=oldgraph;
quit;
ods html close;

/*Program 8.18: Printing the Chart in Tabular Form*/
ods html file="program8_18.html";
proc print data=oldgraph.gchart;
format __Freq__ 5.; /* these are double underscores */
var region sales __freq__ / style={font_size=5};
run;
ods html close;
/* Program 8.19 */
ods html file="program8_19.html";
	proc gchart data=oldgraph.gchart;
		vbar region / sumvar=sales;
		run;
	quit;
ods html close;


/*Program 8.20: An Empty Library Because There Are No Output Objects*/
libname nothing sasedoc '\mylib.quickstart\univariate';
proc datasets lib=nothing;
quit;


/*Program 8.21: Viewing a Directory with Only One ODS Name*/
ods html file='program8_21.html';
libname graphme sasedoc '\mylib.quickstart\new_exhibits\sgpanel';
proc datasets lib=graphme;
quit;
ods html close;
/*Program 8.22: Accessing Other Versions of the SGPANEL Table*/
ods html file="program8_22.html";
proc print data=graphme.sgpanel(doc_seqno=2);
run;
ods html close;

/*Program 8.23: A Document Where DOC_SEQNO Is Necessary*/
ods document name=mylib.queries(write);
proc sql;
	title 'Result 1: USA';
	select *
	from sashelp.cars
	where origin='USA';
title 'Result 2: MPG by Origin';
	select origin,mean(mpg_highway) as mean_mpg /* needed col name fix */
	from sashelp.cars
	group by origin;
title 'Result 3: High Mileage Cars';
	select *
	from sashelp.cars
	where mpg_highway > 25;
quit;
ods document close;

ods listing;
proc document name=mylib.queries;
	list sql;
	run;
quit;
ods listing close;

ods html file='program8_24.html';
libname s sasedoc '\mylib.queries\sql';
title 'Second Table';
proc print data=s.sql_results(doc_seqno=2);
run;
ods html close;

/*Program 8.25: Returning to the OUTPUT Destination*/
ods output parameterestimates=pe;
proc document name=mylib.firstdoc;
	replay / dest=output;
	run;
quit;

proc print data=pe;
run;
ods output close;

*************************************************************;
* Chapter 9 Importing Data to the Document
*************************************************************;

/*Program 9.1: A Reference Table for Importing into a Document*/
data setsused;
label dsname = 'Data Set Name' comment = 'Description';
length dsname $31 comment $60;
infile datalines truncover;
input dsname &$30. comment &$60.;
/* make sure TWO spaces between data set name and comment! */
datalines;
sashelp.fitness  Fitness Data
sashelp.snacks   Promotion Effectiveness Data for Snacks
sashelp.classfit  Fitness Data for the SASHELP.CLASS folks!
;
run;

ods html file='program9_2.html';
proc document name=mylib.quickstart;
	make reference_tables;
	setlabel reference_tables "Useful lookup table";
	/* you could use the same pathname as data set name
	   but for sake of having a distinction, I made them different */
	import DATA=setsused to \reference_tables\tblsused; 
	run;
	/* book has incorrect setlabel statement */
	setlabel reference_tables "Exhibit 1: Tables used in Analysis";
	title;
	list / details;
	run;
quit;
ods html close;

/*Program 9.3: Viewing the Table*/
ods html file='program9_3.html';
proc document name=mylib.quickstart;
	replay reference_tables\tblsused; 
	run;
quit;
ods html close;

/*Program 9.4: Creating a Log and a Document*/
filename mylog 'program9_4.log'; /* point to log file */
proc printto log=mylog;/* reroute log to file */
run;

ods document name=mylib.sat(write) dir=(path=\summaries label='Routine
Summaries');
/* some summary data/checking code */

proc means data=sat_scores mean nmiss max min;
class gender year test;
var satScore;
run;

proc freq data=sat_scores;
table gender year test;
run;
ods document close;

proc printto;
run;


/*Program 9.5: Capturing the Log*/
ods html file='program9_5.html' newfile=none;
proc document name=mylib.sat;
	make logs;
	import textfile=mylog to logs\example;
	run;
	list / levels=all;
	run;
	replay logs;
	run;
	quit;
ods html close;
filename mylog clear; /* deassign file to make sure its unlocked */

/*Program 9.6: Adding Some Documentation to a Log*/
ods html file='program9_6.html';
proc document name=mylib.sat;
	dir logs;
	obtitle example 'This is the log for the SAT Scores analysis, run on
	April 30, 2012';
	replay;
	run;
quit;
ods html close;

*************************************************************;
* Chapter 10 Working with Links
*************************************************************;
* some examples in the text reference defaultbigger style
* this is only necessary to make the book exhibits easier to see.
* to ensure that code runs, submit the following first.
*************************************************************;
proc template;                                                                
   define style Defaultbigger / store = SASUSER.TEMPLAT;                      
      parent = styles.htmlblue;                                               
   end;                                                                       
run;


/*Program 10.1: Creating a Symbolic Link*/
ods html file='program10_1.html' style=defaultbigger;
proc document name=mylib.firstdoc;
	make link_folder;
	dir link_folder;
	run;

	/* book has path incorrect */
	/* this is the right path */
	link \reg#1\bygroup1\model1\obswisestats\weight to firstlink;
	list / details;
	run;
quit;
ods html close;

/*Program 10.2: Replaying Links*/
ods html file='program10_2.html' style=default;
proc document name=mylib.firstdoc; /* should be softly */
	title "Replaying the Link";
	dir link_folder;
	list / details follow;
	run;

	replay firstlink#1 / dest=html levels=all activetitle;
	run;
	quit;
ods html close;


/*Program 10.3: Following a Link*/
ods html file="program10_3.html";
proc document name=mylib.softly(write);
	make linkdir;dir linkdir;
	/* this link is needed for document to run */
	/* the book text omits it */
	link \mylib.firstdoc\reg#1\bygroup1\model1\obswisestats\weight to firstlink;
	dir ^^; /* go up one level so we can see the linkdir in the listing too  */
	list / levels=all follow;
	run;
	quit;
ods document close;
ods html close;

/*Program 10.4: It Is Possible to Create a Soft Link to Nowhere*/
ods listing;
proc document name=badlink(write);
	make linkdir; /* not necessary but helpful. If problems exist, they are
	isolated to one folder */
	dir linkdir;
	link \mylib.firstdob\univariate#1 to badlink;
	list / details;
	run;
     dir \;
	 replay;

quit;

/*Program 10.5: Document of Links*/
ods html file="program10_5.html";
title "A Directory of Links as a Starting Point for a Report on Trucks";
proc document name=softly(write);
	list \mylib.quickstart\univariate#1 / levels=1 details;
	/* to get a list of what the BY-groups mean */ 
	*--------------------------------------------------------;
	make linkdir;
	setlabel linkdir "Truck Comparison"; 
	*--------------------------------------------------------;
	dir linkdir;
	link \mylib.quickstart\Univariate#1\ByGroup4#1 to asia_truck/ first
	label; 
	*--------------------------------------------------------;
	link \mylib.quickstart\Univariate#1\ByGroup13#1 to usa_truck; 
	*--------------------------------------------------------;
	run;
	dir ^^; 
	run;
	list / details levels=2;
	run;
quit;

/*Program 10.6: Reproducing the Output from the Source Document*/
ods html file="program10_6.html" style=defaultbigger;
proc document name=softly;
replay linkdir; /* or just replay if there is only this one folder */
run;
quit;

/*Program 10.7: Modifying Bookmarks of PDF Files Using Links*/
proc document name=mylib.linkonly(write);
	make linkworks;dir linkworks;
	*-------------------------------------------------------------;
	link \mylib.firstdoc\Reg#1\ByGroup1#1\MODEL1#1\ObswiseStats#1\Weight#1\
	DiagnosticPlots#1\DiagnosticsPanel#1 to graph_Fit_F ;
	setlabel graph_Fit_F ' Fit Diagnostics for Sex= F ';
	*---------------------------------------------------------;
	link \mylib.firstdoc\Reg#1\ByGroup1#1\MODEL1#1\ObswiseStats#1\Weight#1\
	FitPlot#1 to graph_Fit_F ;
	setlabel graph_Fit_F ' Fit Plot for Sex= F ';
	*---------------------------------------------------------;
	link \mylib.firstdoc\Reg#1\ByGroup2#1\MODEL1#1\ObswiseStats#1\Weight#1\
	DiagnosticPlots#1\DiagnosticsPanel#1 to graph_Fit_M ;
	setlabel graph_Fit_M ' Fit Diagnostics for Sex= M ';
	*--------------------------------------------------------;
	link \mylib.firstdoc\Reg#1\ByGroup2#1\MODEL1#1\ObswiseStats#1\Weight#1\
	FitPlot#1 to graph_Fit_M ;
	setlabel graph_Fit_M ' Fit Plot for Sex= M ';
	*---------------------------------------------------------;
	replay; run;
quit;

/*Program 10.8: Using a Hard Link to Change an Object’s Context*/
ods html file='Program10_8.html';
options nobyline;
proc document name=mylib.quickstart;
	link \univariate#1\bygroup14#1\wheelbase#1\basicmeasures#1 to minirpt / hard;
	setlabel minirpt "usa trucks";
	obtitle minirpt#1 "Table 1";
	obstitle minirpt#1;
	obanote minirpt#1 "This is the Univariate Output for #byval1 #byval2";
	replay minirpt#1;
	run;
quit;
ods html close;

/*Program 10.9: Hard Links Are the Underlying Object*/
/* the document makes NO distinction between hardlinked tables and 'real' tables */
ods html file='Program10_9.html' style=defaultbigger;
proc document name=mylib.quickstart;
	list; /* default is levels=1 */
	run;
quit;
ods html close;

/*Program 10.10: Deleting the Source Does Not Affect the Target of a Hard Link*/
title 'Deleting the source object might not delete a HARD link';
ods listing;

proc document name=hard_link_test(write);

copy \mylib.firstdoc\univariate\bygroup1\height\moments to orig_object;
run;

link orig_object to newer_obj / hard;
run;

obtitle newer_obj 'The Table is still present';
list;

run;

delete orig_object;
run;

list;
run;

replay;
run;
quit;
ods html close;
ods listing close;
*************************************************************;
* Chapter 11 Working with Templates
*************************************************************;

/*Program 11.1: ODS Output for SQL Examples*/
ods document name=mylib.firstdoc(update);
proc sql;
select *
from sashelp.class
order by name;
select *
from sashelp.cars;
quit;
ods document close;

/*Program 11.2: Defining a New Program Store*/
ods path reset;
ods path(prepend) mylib.tempstr(update);
ods path show;

/*Program 11.3: Restoring Template Arguments*/
Ods path reset;
Ods path show;

/*Program 11.4: Adding (once again)  a Template to the Search Path*/
ods path(prepend) mylib.tempstr;
ods path show;

/*Program 11.5: Determining the Name of a Template Using ODS TRACE*/
ods html file="program11_5.html";
/*ods trace on;*/
proc document name=mylib.firstdoc;
replay sql\sql_results;
run;
quit;
/*ods trace off;*/
ods html close;

/*Program 11.6: Obtaining Template Source*/
filename example 'sql_template_0106.sas';
proc template;
	source Base.SQL / file=example;
	run;
filename example clear;

/*Program 11.7: SQL Automatically Breaks Pages before Printing Tables*/
ods listing;
ods html file="program11_7.html";
proc document name=mylib.firstdoc;
dir sql;
list / details;
run;
replay sql_results#1(where=(_obs_>15)), /* last few lines */
sql_results#2(where=(_obs_<5)); /* first few lines */
run;
quit;
ods listing close;
ods html close;

/* Program 11.8 is just the file sql_template.sas with the newpage statement
   chagned to read 'newpage=off'. 
*/

/*Program 11.9: Changing an Object’s Template via the EDIT Statement*/
ods listing;
proc template;
edit Base.SQL;
  newpage=OFF;
end;
source Base.SQL;
run;
ods listing close;

/*Program 11.10: Deleting a Template from a Template Store*/
ods path reset; 
ods path (prepend) mylib.tempstr(update);
ods path show;
proc template; 
delete base.sql;
run;

/*Program 11.11: Removing a Template from a Template Search Path*/
ods path (remove) mylib.tempstr;
ods path show;

/*Program 11.12: Some Output Objects and their Templates*/
ods html file="program11_12.html";
proc document name=mylib.firstdoc;
list univariate#1\bygroup1#1\height#1 / details; /* misprint in book */
quit;

ods html close;
/*Program 11.13: Extracting the Template for SQL Procedure Output*/
title "The SQL Template";
ods html file='sql_templ.html';
proc document name=mylib.firstdoc;
	obtempl sql\sql_results;
	run;
	quit;
ods html close;

/*Program 11.14: Modifying PROC UNIVARIATE Output*/
ods html file='program11_14.html';
proc template;
	edit base.univariate.quantiles;
	define Estimate;
	header = "Estimate";
	space = 4;
	format=8.4;
	style={background=darkgrey foreground=white};
	end;
	end;
run;
proc document name=mylib.firstdoc(read);
	obtempl univariate\bygroup1\height\quantiles;
	replay univariate\bygroup1\height\quantiles;
run;
quit;
ods html close;

/*Program 11.15: Making and Undoing Template Changes*/
ods html file='program11_15.html';
proc template; 
	edit base.summary; 
	cellstyle mod(_row_,2)=0 as {background=purple foreground=white},
	mod(_row_,2)=1 as data; /* default */
	end; 
run;

* ----------------------------------------------;
%macro replayit; 
	proc document name=mylib.quickstart;
	replay means;
	run;
	quit;
%mend;
* ----------------------------------------------;
%replayit
proc template; 
	delete base.summary;
run;
/* or use :
ods path(remove) mylib.tempstr; */
%replayit
ods html close;

/*Program 11.16: Template Source for DOCUMENT Procedure Listings*/
ods html file='doctempl.html';
proc template;
source base.document.props;
run;
ods html close;

/* after each of the next programs, go ahead and list 
   your favorite document.  Preliminaries such as remembering to run
   proc document...;list;run;quit; may be taken as said */

/*Program 11.17: Inhibit Display of the OBS Column*/
Proc template;
	edit base.document.props;
	define obs;
	print=off;
	end;
end;
RUN;

/*Program 11.18: Highlighting a Column in Document Listing*/
Proc template;
	edit base.document.props;
	define created;
	print=off; ; /* repeat for all other columns to be turned off */
	end
	define template;
	style = data {
	color = black
	background=lightgrey
	font_weight=bold
	end;
	end; /* of edit */
run;

/*Program 11.19: Same Output in Two Different Styles*/
ods html(id=html1) file="program11_19a.html" style=ocean;
ods html(id=html2) file="program11_19b.html" style=statistical;
proc document name=mylib.firstdoc;
	replay univariate\bygroup2\height\quantiles
	/ dest=(html(id=html1) html(id=html2));
	run;
quit;
ods html(id=html1) close;
ods html(id=html2) close;

/*Program 11.20: The Custom Template*/
proc template;
	define table user.tables.tricolor;
		columns blue white red;
		define blue;
			style={background=blue color=white};
			generic;
		end;
		define white;
			style={background=white color=black};
			generic;
		end;
		define red;
			style={background=red color=white};
			generic;
		end;
	end; /* of table definition */
run;

/* ------------ yogurt data set ---------------------------- */
data yogurt;
attrib dt format=mmddyys10. informat=mmddyy.;
infile datalines;
input dt open close ;
datalines;
04/29/2012 18.447 18.07
04/22/2012 18.187 18.46
04/15/2012 17.472 17.615
04/08/2012 17.329 17.199
04/01/2012 18.083 17.42
03/25/2012 17.992 18.044
03/18/2012 17.888 17.654
03/11/2012 18.005 18.148
03/04/2012 17.758 17.836
02/26/2012 17.589 17.498
02/19/2012 17.342 17.797
02/12/2012 16.666 17.108
02/05/2012 16.458 16.666
01/29/2012 16.029 16.744
01/22/2012 16.003 16.25
01/15/2012 15.678 16.12
;
run;


/*Program 11.21: Using ODS in the Data Set with a Custom Template*/
ods document name=import_test(write);
ods html file="PROGRAM11_21.html";
data _null_;
	set yogurt;
	file print ods=(template='user.tables.tricolor'
				columns=(blue=dt (generic=on)
				white=open (generic=on)
				red=close (generic=on)));
	put _ods_;
run;

ods document close;
proc document name=import_test;
dir datastep;
	rename fileprint1#1 to weekly_prices;
	setlabel weekly_prices 'For first half of 2012 through May 4';
	list / details;
	run;
	replay;
	run;
quit;
ods html close;

/*Program 11.22: Outputs the weekly_prices Object to a Data Set*/
ods output weekly_prices=tmp_prices; 
proc document name=import_test;
	dir datastep;
	replay / dest=output;
	run;
quit;
ods output close;

*************************************************************;
* Appendicial Matter
*************************************************************;
/*Program 1A.1: Listing All Styles Available*/
ods html file="a1.html" style=gears;
title "Styles";
proc template;
list styles;
run;
ods html close;

/*Program 3A.1: Adding SAS/GRAPH Output to a Document*/
title;
options device=png300;
ods document name=sasuser.graphdoc(write) cat=sasuser.grstuff;
proc gchart data=sashelp.class;
	vbar age / discrete;
	run;
quit;
ods document close;
ods listing;
proc document name=sasuser.graphdoc;
	list / levels=all;
	run;
quit;
ods listing close;

/*Program 3A.2: Replaying a Graph Stored in a Graphics Catalog*/
proc document name=sasuser.graphdoc;
replay gchart;
run;
ods output close;
quit;

/*Program 3A.3: Adding Titles and Notes to a Graph*/
ods html file='replay_cat.html' nogtitle;

/* if this is the first gchart producedin this session, 
    this will be gchart1, but it might be higher.

   gcharts have their own set of sequence numbers 
   that are independent of the ODS Document's*/

%let objname=gchart1;
	proc document name=sasuser.graphdoc;
	list / levels=all;
	run;

	dir gchart#1;
	obtitle &objname. "catalog graphics";
	obstitle &objname. "appendix 3";
	obstitle2 &objname. "another subtitle";
/* obanote also possible*/
	run;
	replay &objname.;
	run;
quit;
ods html close;

/* Program 3A.4: Changing destination Catalog */
ods html file='null_ctalog.html';
options device=png;
ods document name=sasuser.nullcat(write) cat=sasuser.grstuff;
proc gchart data=sashelp.class;
	vbar age / discrete;
	run;
ods document cat=_null_; 
proc gplot data=sashelp.cars;
	plot mpg_highway * mpg_city;
	run;
quit;
ods document close;

proc document name=sasuser.nullcat;
list / levels=all;
run;
quit;
ods html close;

/*Program 3A.5: Importing a Graph from a Graphics Catalog to the Document*/
proc document name=mylib.graphics_example;
	make report_folder; 
	dir report_folder;
	import grseg=sasuser.grstuff.gchart1  to agegraph; 
	run;
	list \ / levels=all; 
	run;
quit;

/* for these statements - just highlight and then submit one RUN-group at a time */
/*Program 4A.1: Starting the DOCUMENT Procedure Interactively*/
proc document name=mylib.quickstart;

/* now submit just these four statements group */
	ods html style=minimal file='program4A_2_listing.html';
	list / details;
	run;
	ods html close;

	/* now submit these four */
	ods html file='program4A_3.html';
	replay summaries; /* summaries is defined in program 4.14 */
	run;
ods html close;	

/*Program 4A.4: Ending the Document Procedure Interactively*/
quit;

/* the defaultbigger template can be found in the section for that
   chapter. */

/* same for the yogurt data set */

data sat_scores;
	infile datalines;
	input Test $ Gender $ Year SATscore @@;
datalines;
Verbal m 1972 531 Verbal f 1972 529
Verbal m 1973 523 Verbal f 1973 521
Verbal m 1974 524 Verbal f 1974 520
Verbal m 1975 515 Verbal f 1975 509
Verbal m 1976 511 Verbal f 1976 508
Verbal m 1977 509 Verbal f 1977 505
Verbal m 1978 511 Verbal f 1978 503
Verbal m 1979 509 Verbal f 1979 501
Verbal m 1980 506 Verbal f 1980 498
Verbal m 1981 508 Verbal f 1981 496
Verbal m 1982 509 Verbal f 1982 499
Verbal m 1983 508 Verbal f 1983 498
Verbal m 1984 511 Verbal f 1984 498
Verbal m 1985 514 Verbal f 1985 503
Verbal m 1986 515 Verbal f 1986 504
Verbal m 1987 512 Verbal f 1987 502
Verbal m 1988 512 Verbal f 1988 499
Verbal m 1989 510 Verbal f 1989 498
Verbal m 1990 505 Verbal f 1990 496
Verbal m 1991 503 Verbal f 1991 495
Verbal m 1992 504 Verbal f 1992 496
Verbal m 1993 504 Verbal f 1993 497
Verbal m 1994 501 Verbal f 1994 497
Verbal m 1995 505 Verbal f 1995 502
Verbal m 1996 507 Verbal f 1996 503
Verbal m 1997 507 Verbal f 1997 503
Verbal m 1998 509 Verbal f 1998 502
Math m 1972 527 Math f 1972 489
Math m 1973 525 Math f 1973 489
Math m 1974 524 Math f 1974 488
Math m 1975 518 Math f 1975 479
Math m 1976 520 Math f 1976 475
Math m 1977 520 Math f 1977 474
Math m 1978 517 Math f 1978 474
Math m 1979 516 Math f 1979 473
Math m 1980 515 Math f 1980 473
Math m 1981 516 Math f 1981 473
Math m 1982 516 Math f 1982 473
Math m 1983 516 Math f 1983 474
Math m 1984 518 Math f 1984 478
Math m 1985 522 Math f 1985 480
Math m 1986 523 Math f 1986 479
Math m 1987 523 Math f 1987 481
Math m 1988 521 Math f 1988 483
Math m 1989 523 Math f 1989 482
Math m 1990 521 Math f 1990 483
Math m 1991 520 Math f 1991 482
Math m 1992 521 Math f 1992 484
Math m 1993 524 Math f 1993 484
Math m 1994 523 Math f 1994 487
Math m 1995 525 Math f 1995 490
Math m 1996 527 Math f 1996 492
Math m 1997 530 Math f 1997 494
Math m 1998 531 Math f 1998 496
;
run;

