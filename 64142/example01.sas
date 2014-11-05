%let name=example01;
filename odsout '.';

/* This is your data.  */
data metrics;
input Quarter $ 1-2 Actual Target;
datalines;
Q1 3.1833 3.25
Q2 2.9500 3.50
Q3 2.8167 3.75
Q4 1.8126 4.00
;
run;

/* Define colors as macro variables - they are consumed by annotate, and pattern stmts */
%let green=cxc2e699;
%let pink=cxfa9fb5;
%let red=cxff0000;

/* Evaluation of actual, as a percentage of target */
data metrics; set metrics;
format Percent_of_Target percent6.0;
length Evaluation $12;
 percent_of_target=actual/target;
      if (percent_of_target < .60) then evaluation='Poor';
 else if (percent_of_target < .90) then evaluation='Satisfactory';
 else if (percent_of_target >=.90) then evaluation='Good';
run;

/* Add html charttips */
data metrics; set metrics;
length my_html $ 200;
my_html='title='||quote(
 'Quarter: '|| trim(left(quarter)) ||'0D'x||
 'Target: '|| trim(left(put(target,comma6.2))) ||'0D'x||
 'Actual: '|| trim(left(put(actual,comma6.4))) ||'0D'x||
 'Actual as Percent of Target: '|| trim(left(put(percent_of_target,percent7.1)))
) ||' '|| 'href="scen3_simple_info.htm"';
run;



/* Create annotate data set for the color-coded target marker */

data targets; set metrics;
length style color $20 function $8;
hsys='3'; position='5'; when='a';

/* Draw the horizontal line */
function='move'; 
xsys='2'; ysys='2'; midpoint=quarter; y=target; output;
function='move'; xsys='7'; x=-8.5; output;    
function='draw'; xsys='7'; x=17; color="gray"; size=.1; output;  

/* Draw colored/filled triangle */
function='move'; 
xsys='2'; ysys='2'; midpoint=quarter; y=target; output;
function='move'; xsys='7'; x=8.5; output;    
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='marker'; 
if (evaluation eq 'Good') then color="&green"; 
else if (evaluation eq 'Poor') then color="&red";
else if (evaluation eq 'Satisfactory') then color="&pink";
output;

/* Draw gray outline triangle */
function='move'; 
xsys='2'; ysys='2'; midpoint=quarter; y=target; output;
function='move'; xsys='7'; x=8.5; output;    
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='markere'; 
color="gray";
output;

run;


/* This is a missing-value placeholder, to guarantee that 
   all the bar charts use the 2 colors in the same way.  */
data foometrics;
length evaluation $12;
quarter='Q1'; actual=.;
evaluation='Poor'; output;
evaluation='Satisfactory'; output;
evaluation='Good'; output;
run;
data metrics; set metrics foometrics; 
run;


goptions xpixels=200 ypixels=200;
goptions device=png;
goptions cback=white;
goptions border;

/* this is to keep the bar spacing the same in v9.3 as it was in v9.2 */
goptions hpos=160 vpos=50;

ODS LISTING CLOSE;
ODS HTML path=odsout body="&name..htm" (title="Bar with Annotated Target")  options(pagebreak='no') style=minimal;

goptions gunit=pct htitle=10 ftitle="albany amt/bold" htext=6.5 ftext="albany amt";

pattern1 v=s c=&green; 
pattern2 v=s c=&red; 
pattern3 v=s c=&pink; 

title "Satisfaction";

axis1 label=none order=(0 to 5 by 1) minor=none major=(h=2) offset=(0,0);
axis2 label=none offset=(8,10);

proc gchart data=metrics anno=targets;
 vbar quarter / type=sum sumvar=actual  subgroup=evaluation  nolegend
 raxis=axis1 maxis=axis2
 autoref cref=graycc clipref
 coutline=gray
 width=14 space=14
 html=my_html
 des="" name="&name" ;  
run;

title;
proc print data=metrics (where=(percent_of_target^=.) drop=my_html) noobs; 
run;

quit;
ODS HTML CLOSE;
ODS LISTING;
