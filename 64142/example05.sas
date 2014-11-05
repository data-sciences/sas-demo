%let name=example05;
filename odsout '.';

/*
By default, the SAS maps.germany has the borders for the ~400 regions of germany.
This example uses info from the maps.germany2 feature table to convert that 
map into a map of the 16 state regionss.
*/

/* 
First, get the original order of the obsns, so you can get the 
proper order of obsns later.
*/
data germany; set maps.germany;
original_order=_n_;
run;

/* 
Merge in the region numbers.
*/
proc sql;
create table germany as
select unique germany.*, germany2.state2 
from germany left join maps.germany2
on germany.id=germany2.id
order by state2, original_order;
quit; run;

/*
Remove the internal region boundaries, within the 16 states.
*/
proc gremove data=germany out=germany;
by state2;
id id;
run;

%annomac;
%centroid(germany, anno_names, state2);

data anno_names; set anno_names;
length function $8;
hsys='3'; when='a'; size=2;
xsys='2'; ysys='2'; function='move'; output;
/* Give a few of the labels an x/y offset, to move to a better location (x/y values in relative %) */
x=0; y=0; 
text=trim(left(state2));
if text='Brandenburg' then y=-1.5;
if text='Niedersachsen' then y=y+1.5;
if text='Sachsen' then x=-1;
xsys='b'; ysys='b'; function='move'; output;
function='cntl2txt'; output;
function='label'; output;
run;


GOPTIONS DEVICE=png;
goptions cback=white border;
goptions gunit=pct ftitle='albany amt/bold' ftext='albany amt' htitle=4 htext=2.75;
 
ODS LISTING CLOSE;
ODS HTML path=odsout body="&name..htm" style=sasweb;

legend1 position=(right middle) label=none across=1 shape=bar(.15in,.15in);

title1 ls=1.5 "16 States of Germany";

proc gmap map=germany data=germany anno=anno_names;
id state2; 
choro state2 / discrete coutline=gray legend=legend1
 des="" name="&name";
run;

quit;
ODS HTML CLOSE;
ODS LISTING;
