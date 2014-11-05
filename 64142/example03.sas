/* example03 */
%let year=2011;
%let name=gas&year;
filename odsout '.';
*goptions border;

/*
Went to
http://www.fueleconomy.gov/feg/download.shtml
Clicked the 11data.zip, and saved it, then extracted the xls file to 2011FEguide-public.xlsx
Import the xls spreadsheet into SAS - you will need a license for SAS/Access to PC files for this to work ...
*/
proc import datafile= "2011FEguide-public.xlsx" dbms=EXCEL out=mpgdata replace;
 getnames=YES; mixed=YES; scantext=NO;
run;

data mpgdata; set mpgdata;
label Hwy_FE__Guide____Conventional_Fu='Highway';
label City_FE__Guide____Conventional_F='City mpg';
if Carline_Class_Desc^='' then output;
run;

proc sort data=mpgdata out=mpgdata;
*by mfr_name;
by Carline_Class_Desc;
run;


/* Annotate some stuff on the graphs */
data my_anno; 
length function color $8;

 xsys='1'; ysys='1';
 color='gray99'; 
 position='5'; hsys='3'; when='a'; style=''; size=.;
 function='label'; x=93; y=93; text='good'; output;
 function='label'; x=7; y=7; text='bad'; output;

 color='graycc';
 when='b';
 function='move'; x=0; y=0; output;
 function='draw'; x=100; y=100; size=.1; output;

 xsys='2'; ysys='2';
 color='cx00ff00'; 
 function='move'; x=30; y=0; output;
 function='draw'; x=30; y=30; size=1; output;
 function='draw'; x=0; y=30; size=1; output;

run;



/* for the tables */
proc sort data=mpgdata out=mpgdata;
by Carline_Class_Desc;
run;


ODS LISTING CLOSE;

%let panelcolumns=3;
ods tagsets.htmlpanel path="." (url=none) file="&name..htm" (title="&year Gas Mileage Plots") style=minimal;

goptions device=png;
goptions ftitle="albany amt/bold" ftext="albany amt" htitle=11pt htext=10pt;

goptions xpixels=830 ypixels=80;
title1 h=15pt "Gas Mileage Plots";
title2 h=12pt ls=1.5 font="albany amt/bold" "year &year";
proc gslide name="&name";
run;

ods tagsets.htmlpanel event = panel(start);
goptions xpixels=284 ypixels=360;
options nobyline;

axis1 length=2.3in offset=(0,0) order=(0 to 60 by 10) minor=none;
axis2 length=2.3in offset=(0,0) order=(0 to 60 by 10) minor=none;

symbol1 color=blue value=circle h=1.4 interpol=none;

title1 ls=1.5 "#byval(Carline_Class_Desc)";
footnote h=3pct " ";

proc gplot data=mpgdata anno=my_anno;
by Carline_Class_Desc;
plot Hwy_FE__Guide____Conventional_Fu*City_FE__Guide____Conventional_F=1 / 
 autohref autovref chref=graycc cvref=graycc
 vaxis=axis1 haxis=axis2
 des="" name="gas_mpg_&year._#byval(Carline_Class_Desc)";
run;

ods tagsets.htmlpanel event = panel(finish);

quit;
ods html close;

