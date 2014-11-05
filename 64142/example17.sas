%let name=example17;
filename odsout ".";

/* Generate some fake ozone data, which is plauisbly real */
data my_data;
 format day date9.;
 format ozone comma5.2;
 do day="01jan1982"d to "31dec1991"d by 1;
  monname=trim(left(put(day,monname.)));
  year=put(day,year.);
  /* Simulate an ozone value for this day, using a random number */
  ozone=ranuni(1)*.5;
  /* Simulate the ozone being better in winter months */
  if monname in ("December" "January") then ozone=ozone/9;
  else if monname in ("November" "February") then ozone=ozone/3.5;
  else if monname in ("September" "October" "March" "April") then ozone=ozone/1.5;
  else if ozone < .15 then ozone=.15;
  /* Simulate ozone getting better in recent years */
  if year=1991 then ozone=.9*ozone;
  if year=1990 then ozone=.92*ozone;
  if year=1989 then ozone=.94*ozone;
  if year=1988 then ozone=.95*ozone;
  if year=1987 then ozone=.96*ozone;
  if year=1986 then ozone=.97*ozone;
  output;
 end;
run;

/* First, make sure the data is sorted, so you can use "by year" later */
proc sort data=my_data out=my_data; 
by year day;
run;

proc sql; 
/* Macro variables containing minimum & maximum years */
select min(year) into :min_year from my_data; 
select max(year) into :max_year from my_data; 
/* Start your annotate label data set for each year */
create table anno_year_and_weekday as select unique year from my_data;
quit; run;

/* My algorithm assumes you have an obs for each day, so create a grid of all days */
data grid_days;
 format day date9.;
 do day="01jan.&min_year"d to "31dec.&max_year"d by 1;
  weekday=put(day,weekday.);
  downame=trim(left(put(day,downame.)));
  monname=trim(left(put(day,monname.)));
  year=put(day,year.);
  output;
 end;
run;
/* Join your data with the grid-of-days */
proc sql;
create table my_data as select * 
from grid_days left join my_data 
on grid_days.day eq my_data.day;
quit; run;

/* Add some html title= flyover data tip text (could also add href= drilldown here) */
/* The "0d"x is a carriage-return, which is honored by most web browsers */
data my_data; set my_data;
 length  myhtmlvar $200;
 myhtmlvar='title='||
   quote(
   trim(left(put(day,downame.)))||'0D'x
   ||put(day,date9.)||'0D'x
   ||'Ozone: '||put(ozone,comma5.4)||' ppm'
   );
run;

/* Create a "map" of the calendar days, suitable for use in gmap (ie, 4 X/Y obsns per each day) */

/* When using "by year", you can then use "first.year" */
/* You're starting with minimum date at top/left, max at bottom/right */
data datemap; set my_data;
 keep day x y;
 by year;
 if first.year then x_corner=1;
 else if trim(left(downame)) eq "Sunday" then x_corner+1;
 y_corner=((&min_year-year)*8.5)-weekday;
 /* output 4 X/Y coordinates per each day, forming a rectangle that GMAP can draw */
 x=x_corner; y=y_corner; output;
 x=x+1; output;
 y=y-1; output;
 x=x-1; output; 
run;


/* Create darker outline to annotate around each month */
/* (this is similar to annotating a state outline onto a county map) */
data anno_month_outline; set datemap;
/* combination of year & month makes a unique id for these outlines */
length yr_mon $ 15;
yr_mon=trim(left(put(day,year.)))||"_"||trim(left(put(day,month.)));
order+1;
run;
/* Sort it, so you can use "by" in next step */
proc sort data=anno_month_outline out=anno_month_outline;
by yr_mon order;
run;
/* Remove the internal borders, within each month */
proc gremove data=anno_month_outline out=anno_month_outline;
 by yr_mon; 
 id day;
run;
/* Now, convert the gmap data set into annotate move/draw commands */
data anno_month_outline;
 length color function $8;
 retain first_x first_y;
 xsys="2"; ysys="2"; size=1.75; when="A"; color="black";
 set anno_month_outline; 
 by yr_mon;
 if first.yr_mon then do;
  first_x=x; first_y=y;  /* Save these to use at the end, also */
  function="move"; output;
 end;
 else do;
  function="draw"; output;
 end;
 /* At the end, connect the last point to the first point to close the polygon */
 if last.yr_mon then do;
  x=first_x; y=first_y; output;
  end;
run;

/* Annotate some text labels for year and day-of-week, along the left */
data anno_year_and_weekday; set anno_year_and_weekday;
length text $10;
function="label";
position="4";
xsys="2"; ysys="2"; hsys="3"; when="A";
x=-8;
y=((&min_year-year)*8.5)-1.25;
style="";
size=2;
text=trim(left(year)); output;
x=-.1;
size=1;
text="Sunday"; output;
y=y-1; text="Monday"; output;
y=y-1; text="Tuesday"; output;
y=y-1; text="Wednesday"; output;
y=y-1; text="Thursday"; output;
y=y-1; text="Friday"; output;
y=y-1; text="Saturday"; output;
run;

/* Annotate some labels for the 3-character month name, along the top */
data anno_month;
length text $10;
function="label";
position="5";
xsys="2"; ysys="2"; hsys="3"; when="A";
size=1.5;
y=1;
spacing=4.5;
x=(spacing/3)*-1;
x=x+spacing; text="JAN"; output;
x=x+spacing; text="FEB"; output;
x=x+spacing; text="MAR"; output;
x=x+spacing; text="APR"; output;
x=x+spacing; text="MAY"; output;
x=x+spacing; text="JUN"; output;
x=x+spacing; text="JUL"; output;
x=x+spacing; text="AUG"; output;
x=x+spacing; text="SEP"; output;
x=x+spacing; text="OCT"; output;
x=x+spacing; text="NOV"; output;
x=x+spacing; text="DEC"; output;
run;

/* Combine the weekday & month annotated text into 1 data set. */
data text_anno; set anno_year_and_weekday anno_month; 
run;

/* Put a fake map area to the top/left of the map, to guarantee room for the annotated labels on the left & top */
/* You might need to adjust the "-10" value to add more space, depending on your text size, map proportions, etc. */
data fake;
 day=1;
 x=-10; y=1; output;
 x=x-.001; y=y+.001; output;
 x=x+.002; output;
run;
data datemap; set datemap fake;
run;


goptions xpixels=700 ypixels=900;
goptions device=png;
goptions cback=white;
goptions border; 

ODS LISTING CLOSE;
ODS HTML path=odsout body="&name..htm" (title="SAS/GRAPH Custom Calendar Chart Example")
 nogfootnote style=d3d;
 
goptions gunit=pct ftitle="albany amt/bo" ftext="albany amt" htitle=4 htext=2;

pattern1 v=s c=cx00ff00;
pattern2 v=s c=yellow;;
pattern3 v=s c=orange;
pattern4 v=s c=red;

legend1 shape=bar(.15in,.15in) frame cshadow=gray label=none;

title1 "LOS ANGELES OZONE";
title2 "(using fake data)";

footnote1 link="http://www.math.yorku.ca/SCS/Gallery/images/LAoz.gif"   "Based on this plot";
footnote2 link="http://www.math.yorku.ca/SCS/Gallery/bright-ideas.html" "Explained on this page";

proc gmap data=my_data map=datemap all anno=text_anno; 
 id day; 
 choro ozone / levels=4 
 legend=legend1 
 cempty=graycc 
 coutline=graycc 
 anno=anno_month_outline 
 html=myhtmlvar 
 des="" name="&name"; 
run;

quit;
ODS HTML CLOSE;
ODS LISTING;
