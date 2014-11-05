%let name=example15;
filename odsout '.';


data bardata;
input lablvar $ 1-50 barval;
datalines;
Beginning Value                                     10
First Quarter                                       -20
Second Quarter                                      30  
Third Quarter                                       25
Fourth Quarter                                      37 
End-of-Year Taxes                                   -40
End-of-Year Kickbacks                               11
;
run;


/* Sum up all the data values, for the final bar, and add an obsn onto the end of the data set */
proc sql;
 create table sumdata as
 select 'Final Value' as lablvar, sum(barval) as barval
 from bardata;
quit; run;
data moddata; 
 set bardata sumdata;
run;

/* Assign a sequential number (barnum) for each bar, in the data-order */
data moddata; set moddata;
barnum=_n_;
fakeval=0;
run;
/* Create a user-defined format, to use with the numeric bar numbers/midpoints */
data control; set moddata (rename = ( barnum=start lablvar=label));
fmtname = 'bar_fmt';
type = 'N';
end = START;
run;
proc format lib=work cntlin=control;
run;


/* Assign bar colors - the 'by fakeval' lets me determine the "first." and "last." */
data moddata; set moddata;
length color barcolor $20;
by fakeval;
     if first.fakeval then barcolor="cx499DF5";   /* blue */
else if last.fakeval  then barcolor="cx499DF5";   /* blue */
else if barval>=0     then barcolor="cx49E20E";   /* green */
else if barval<0      then barcolor="cxFF3030";   /* red */
else                       barcolor="pink";       /* if you see a pink bar, something's wrong! */
run;


/* Count how many bars there are, so you can figure out the % width of each bar */
/* (the .8 is an arbitrary thing, so there will be some spacing between the bars) */
proc sql noprint;
select (.8*(100/count(*))) into :barwid from moddata;
select (.8*(100/count(*)))/2 into :halfwid from moddata;
quit; run;


data bar_anno; set moddata;
by fakeval;
length function color $8 style $20;
when='a';
length html $500;
 html=
 'title='||quote( translate(trim(left(lablvar)),' ','\')||' = '||trim(left(barval)))||
 ' href='||quote('waterfall_anno_info.htm');

/* If it's the first/left-most bar, start by moving to the zero line */
if first.fakeval then do;
 function='move'; 
 xsys='2'; x=barnum;
 ysys='2'; y=0;
 output;
 end;

/* draw a horizontal line to the midpoint of this bar segment */
function='draw'; color='black';
xsys='2'; x=barnum;
ysys='7'; y=0;  /* 0% up/down, from my previous y (ie, horizontal) */
output;

/* Move to the left 1/2 bar width (ie, to the bottom/left of that bar segment) */
function='move'; 
xsys='7'; x=-1*&halfwid; output;

/* then draw out a colored bar, from this point to the opposite corner */
function='bar'; color=barcolor; style='solid'; line=0;
xsys='7'; x=&barwid;  /* use relative-percent coordinate system */
ysys='8'; y=barval;  /* use relative-value coordinate system */
/* in the special case that it's the last bar, always connect to the zero line instead */
if last.fakeval then do;
 ysys='2'; y=0;  
 end;
output;

run;



/* 
When you use 'noframe' to get rid of the border around the frame, 
it also gets rid of the cframe background color within the frame area.
Therefore, you have to use an annotated bar/box to get that color back.
*/
data anno_frame;
xsys='1'; ysys='1'; when='b';
function='move'; x=0; y=0; output;
function='bar'; x=100; y=100; color='white'; style='solid'; line=0; output;
run;


goptions device=png;
goptions xpixels=700 ypixels=600;
goptions cback=white;
goptions border;
 
ODS LISTING CLOSE;
ODS HTML path=odsout body="&name..htm" (title="SAS/GRAPH Annotated Waterfall Chart") style=minimal;

goptions gunit=pct htitle=4.0 htext=2.25  ftitle="albany amt/bo" ftext="albany amt";

axis1 label=none minor=none order=(-25 to 100 by 25) offset=(0,0);

axis2 label=none value=(angle=90) offset=(5,5);

title1 ls=1.5 "SAS/GRAPH Annotated Waterfall Chart";

proc gchart data=moddata anno=bar_anno;
format barnum bar_fmt.;
vbar barnum / discrete 
 type=sum sumvar=fakeval
 raxis=axis1 maxis=axis2 width=9
 autoref cref=gray55 lref=33 clipref
 nolegend noframe anno=anno_frame /* cframe=white */
 des='' name="&name";
run;

quit;
ODS HTML CLOSE;
ODS LISTING;
