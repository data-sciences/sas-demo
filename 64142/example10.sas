%let name=example10;
filename odsout '.';

data repdata;
input Name $ 1-20 lower_whisker lower_box Median upper_box upper_whisker;
datalines;
Allison, R           0.5 6.1  8.2 11.0 17.5
Jeffreys, E          1.0 5.8  9.5 13.0 20.2
Peterson, B          3.0 8.8 11.0 13.1 17.2
Proctor, L           2.0 6.1  9.0 11.5 16.0
Taylor, C            1.5 5.5  9.0 12.6 18.7
Davis, J             2.5 6.0  9.3 11.8 14.8
;
run;

%let boxwidth=1.5;
%let linewidth=.5;
%let linecolor=black;
%let boxcolor=cxCAE1FF;


data repanno; set repdata;
xsys='2'; ysys='2'; hsys='3'; when='a';
length function color $8 style $15;

length html $ 250;
html='title='||quote(
 trim(left(Name))||'0D'x||
 'Median: '||trim(left(Median))||'0D'x||
 'Box: '||trim(left(lower_box))||' / '||trim(left(upper_box))||'0D'x||
 'Whiskers: '||trim(left(lower_whisker))||' / '||trim(left(upper_whisker)) 
 )||' href="anno_boxplot_info.htm"';

size=&linewidth;

/* draw the whiskers */
color="&linecolor";
ysys='2'; yc=Name;
function='move'; x=lower_whisker; output;
function='draw'; x=upper_whisker; output;

/* draw the ends on the whiskers */
color="&linecolor";
ysys='2'; yc=Name;
function='move'; x=lower_whisker; output;
function='move'; ysys='7'; y=-1*&boxwidth; output;
function='draw'; line=1; y=+2*&boxwidth; output;
ysys='2'; yc=Name;
function='move'; x=upper_whisker; output;
function='move'; ysys='7'; y=-1*&boxwidth; output;
function='draw'; line=1; y=+2*&boxwidth; output;

/* draw the box, using annotate 'bar' function */
color="&boxcolor";
ysys='2'; yc=Name;
function='move'; x=lower_box; output;
function='move'; ysys='7'; y=-1*&boxwidth; output;
function='bar'; line=0; style='solid'; x=upper_box; y=+2*&boxwidth; output;
color="&linecolor";
ysys='2'; yc=Name;
function='move'; x=lower_box; output;
function='move'; ysys='7'; y=-1*&boxwidth; output;
function='bar'; line=0; style='empty'; x=upper_box; y=+2*&boxwidth; output;

/* Median Line */
color="&linecolor";
ysys='2'; yc=Name;
function='move'; x=Median; output;
function='move'; ysys='7'; y=-1*&boxwidth; output;
function='draw'; line=1; y=+2*&boxwidth; output;

run;


goptions device=png;
goptions noborder;

ODS LISTING CLOSE;
ODS HTML path=odsout body="&name..htm" (title="Annotated Horizontal Boxplot") style=sasweb;

goptions gunit=pct htitle=5 ftitle="albany amt/bold" htext=3.0 ftext="albany amt" ctext=gray33;

axis1 label=none value=(justify=right) offset=(8,8);

axis2 order=(0 to 25 by 5) minor=none label=none offset=(0,0);

title1 ls=1.5 "Annotated Horizontal Boxplot";
title2 "SAS/GRAPH Gplot";

symbol1 value=none interpol=none height=.001 color=white;
proc gplot data=repdata anno=repanno;
 plot name*Median /
 vaxis=axis1 
 haxis=axis2
 autohref chref=graydd
 des='' name="&name";
run;

quit;
ODS HTML CLOSE;
ODS LISTING;
