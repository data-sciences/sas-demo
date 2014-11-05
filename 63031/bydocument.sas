****************************************************************;
* Book : PROC DOCUMENT By Example using SAS
****************************************************************;
* This file is organized by document rather than by chapter.  It builds all the documents
* in the book as they exist after all SAS Procedure Output has been added.

* Because ODS Output from the entire book is included, when  you run
* the examples against these documents, they will have more output than
* is shown in the book's illustrations.

* temporary .documents as well as those  meant to illustrate a single point are not included.
****************************************************************;
data class_tmp;
   label sex_f = 'Flag=1 if Sex=''F'', 0 if Sex=''M'' ';
   set sashelp.class;
   sex_f = (sex='F');
run;
****************************************************************;
* mylib.quickstart
****************************************************************;

ods document name=mylib.quickstart(update);
  proc contents data=cars;
  run;

  proc univariate data=cars;
  by origin type;
  run;

  proc means nmiss mean max min data=cars;
  class origin type;
  run;

    proc report nowd data=cars;
     column origin type msrp;
     define origin / group order=data;
     define type / 'Veh. Type' group order=data;
     define msrp / analysis mean;
  run;

  proc freq data=cars;
table origin * type / list;
run;
ods document close;
****************************************************************;

ods document name=mylib.lastone(write)
	dir=(label='Analysis for 2004 Model Cars');
/* need to re-sort */

	proc univariate data=cars2;
		by type;
		var weight msrp;
	run;

	proc freq data=cars;
		table origin * type / list;
	run;
ods document close;
****************************************************************;
proc document data=mylib.quickstart;
obtitle \Univariate#1\ByGroup1#1\MSRP#1\Moments#1
   'Manufacturer''s Suggested Retail Price';
   make graphs_only;

  make us_only / first;
  make europe_only / after= us_only;
  make asia_only / after= europe_only;
run;

	dir univariate;
	DIR BYGROUP10#1\MPG_HIGHWAY;/* USA SUV*/
	obtitle moments "SUV Analysis";
	obtitle2 moments "Table 2 : Fuel Economy";
	obstitle1 moments '#BYVAL2 from #BYVAL1' / just =l; 
	obstitle2 moments "For this table, BYVAR1=#BYVAR1 and BYVAR2=#BYVAR2"
	/ just=L;
	quit;

****************************************************************;
* mylib.firstdoc  document is developed over several chapters.  This and mylib.quickstart
* form the main examples in the code
****************************************************************;

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

	proc reg data=class plots=fit;
	by sex;
	model weight=height;
	run;

	proc reg data=class_tmp;
	by sex;
	model weight = age height;
	run;


proc reg data=class_tmp plots=fit;
	model weight = age height sex_f;
	run;

		  proc reg data=sashelp.class;
              model weight=height;
         run;

quit;

ods document close;

proc document name=mylib.firstdoc label="SASHELP.CLASS analysis, part I.";
doc lib=mylib;
	setlabel reg#1 'Model is weight = height + error, by sex. ';
	setlabel reg#2 'Same Model as Reg#1 no grouping by sex';
	setlabel freq 'First Attempt';

	make graphs_only;
	copy univariate#1(where=(_type_='Graph')) to graphs_only#1;

	copy univariate#1 to ^ / last;
	setlabel univariate#2 'Copy of Univariate Folder';
	list / details;
	run;

     copy univariate#1(where=(_type_ = 'Table')) to ^ / levels=all;
	setlabel univariate#3 'Output Objects from Univariate Only.
	No Subfolders (seqno=#3)';

run;
quit;

****************************************************************;
* This was once first document the user creates.
* after adding mylib.quickstart, this is no longer the case
* but the naming was kept.
****************************************************************;

ods document name=mylib.seconddoc dir=(path=\march2012);
	proc univariate data=class;
		by sex;
		var height age;
	run;

	proc freq data=class;
		table sex;
	run;

	ods document dir=(path=\graphs);
	proc sgplot data=work.cars;
		by origin type;
		scatter x=horsepower y=msrp;
	run;

ods document dir=(path=\analysis label="Exploratory Analysis - Initial");
	proc univariate data=work.cars;
	run;
	ods document close;

	****************************************************************;
	* tabulate and the document  example from chapter 3 
	****************************************************************;
	ods document name=mylib.onlytab(write);
	proc tabulate data=sashelp.cars;
		class origin;
		table origin,n*f=5.; /* width=5, no dec. places */
	run;
ods document close;

****************************************************************;
* mylib.morecars - a document devoted to answering a specific  question
****************************************************************;
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

	/* need some ODS Statistical Graphics! */
    proc univariate data=cars normaltest;
		by origin type;
		var msrp weight horsepower;
		cdfplot msrp;
	run;

ods document close;

****************************************************************;
proc document name=show(write);
	make folder;
	make folder\subfolder;
	make folder\subfolder; /* will make subfolder#2 */
	/* move into folder */
	dir folder;
	setlabel subfolder#1 "Will you remember what 'subfolder#1' contains?";
	dir ^^;
	title "Before";
	list / details levels=2;
run;
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
quit;

****************************************************************;
* backing up a document folder into another folder
****************************************************************;
proc document name=sasuser.archive(write);
	list \mylib.firstdoc\ / details;
	run;
	make january;
	make february;
	make march;
	copy \mylib.firstdoc\(where=(_cdate_>'01Mar2012'd)) to march#1;
	run;
quit;


************************************************
* flat document organization examples
****************************************************************;
proc document name=mylib.lev2copy(write);
	copy \mylib.firstdoc\freq(where=(_type_='Graph') ) to ^;
	copy \mylib.firstdoc\reg(where=(_type_='Graph') ) to ^ / levels=all;

    setlabel freq#1 'Frequency Distributions';
	setlabel reg#1 'Linear Model of Height vs. Weight';
quit;

proc document name=mylib.chap7(write); 
make example;
	copy \mylib.firstdoc\reg(where=
	(_name_ in ('ParameterEstimates','FitPlot'))) 
	to example#1 / levels=all;
	run;

		title 'Replay #1 - Paging';
	       dir example\reg;
	      obpage parameterestimates;
	    run;
    obtitle1 parameterEstimates#1 "Parameter Estimates"; 
	obtitle2 parameterEstimates#1 "Basic Model, no interactions";
	obtitle3 parameterEstimates#1 "Normal Error Assumed";

    setlabel ^ "Height Weight study for SASHELP.CLASS Data"; 
	setlabel parameterestimates#1 'Table 1: Weight vs. Height for Females';
	setlabel fitplot#1 'Graph 1: Line of Best Fit (Females)';
	setlabel parameterestimates#2 "Table 2: Weight vs. Height for Males";
	setlabel fitplot#2 'Graph 2: Line of Best Fit (Males)'; 
	run;
quit;

	****************************************************************;
	/*Program 7.5: Removing Page Breaks*/
ods document name=mylib.tabulate_test(write);
	proc tabulate data=sashelp.class;
	var weight height age;
	table height*mean;
	table age*mean;
	table weight * mean;
	run;
ods document close;
proc document name=mylib.tabulate_test;
	dir tabulate\report;
	obpage table#2 / delete; 
	obpage table#3 / delete;
	setlabel table#1 'Height Mean'; 
	setlabel table#2 'Age Mean';
	setlabel table#3 'Weight Mean';
quit;
****************************************************************;


