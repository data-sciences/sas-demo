%let name=example14;
filename odsout '.';

%let days=60;

data rawdata; set sashelp.stocks (keep = stock date close);
if stock='Microsoft' then sticker='MSFT';
if stock='Intel' then sticker='INTC';
if stock='IBM' then sticker='IBM';
run;

data plotdata; set rawdata;
format date date7.;
run;

/* 
count how many, to figure out how many ypixels (vertical size) you need 
(about 30 pixels per each stock/sparkline, and ~33 for titles & footnotes)
*/
proc sql;
select 33+35*count(*) into :ypix separated by ' ' from (select unique sticker from rawdata);
quit; run;
goptions device=png xpixels=600 ypixels=&ypix;

/* Create macro variables containing the min & max date in the data */
proc sql;
select lowcase(put(min(date),date9.)) into :mindate separated by ' ' from plotdata;
select lowcase(put(max(date),date9.)) into :maxdate separated by ' ' from plotdata;
select max(date)-min(date) into :days_by separated by ' ' from plotdata;
select count(unique(sticker)) into :y_max separated by ' ' from plotdata;
quit; run;

/*-------------------------------------------------------------------------*/

data plotdata; set plotdata;
by sticker notsorted;
if first.sticker then order+1;
run;


/* calculate the 'normalized' (0-1) representation of the close price */
proc sql;
create table plotdata as
select plotdata.*, min(close) as min_close, max(close) as max_close
from plotdata
group by sticker
order by sticker, date;
quit; run;
data plotdata; set plotdata;
/* the .80 puts a little bit of gap at the top of each line, for visual spacing */
norm_close=.80*(close-min_close)/(max_close-min_close)+.10;
run;


/* Create the extra points for the 'dots' at the high & low close values */
proc sql;

create table high_close as
select unique sticker, stock, date, norm_close as high_close 
from plotdata
group by sticker
having norm_close=max(norm_close);

create table low_close as
select unique sticker, stock, date, norm_close as low_close 
from plotdata
group by sticker
having norm_close=min(norm_close);

create table plotdata as select plotdata.*, high_close.high_close 
from plotdata left join high_close
on plotdata.date=high_close.date and plotdata.sticker=high_close.sticker;

create table plotdata as select plotdata.*, low_close.low_close 
from plotdata left join low_close
on plotdata.date=low_close.date and plotdata.sticker=low_close.sticker;

quit; run;


/* this works in conjunction with 'skipmiss' */
proc sort data=plotdata out=plotdata;
by sticker date;
run;
data plotdata; set plotdata;
by sticker;
/* apply an offset to each stock's line */
norm_close=norm_close+(order-1);
high_close=high_close+(order-1);
low_close=low_close+(order-1);
output;
if last.sticker then do;
 close=.;
 norm_close=.;
 low_close=.;
 high_close=.;
 output;
 end;
run;


/* Annotate the text in the blank/offset space, to make the plot look like a table */
proc sql;

create table anno_table as select * from plotdata having low_close^=.;

/* figure out the stock value at the beginning date */
create table begin_close as
 select unique sticker, close as begin_close
 from rawdata
 group by sticker
 having date=min(date);
create table anno_table as select anno_table.*, begin_close.begin_close 
 from anno_table left join begin_close
 on anno_table.sticker=begin_close.sticker;

/* figure out the stock value at the ending date */
create table end_close as
 select unique sticker, close as end_close
 from rawdata
 group by sticker
 having date=max(date);
create table anno_table as select anno_table.*, end_close.end_close 
 from anno_table left join end_close
 on anno_table.sticker=end_close.sticker;

/* Now, just get 1 unique value for each stock ticker */
create table anno_table as
select unique order, sticker, stock, min_close, max_close, begin_close, end_close
from anno_table;

quit; run;


data anno_table; set anno_table;
length text $65;
function='label'; position='3'; when='a';
ysys='2'; y=order-1;
xsys='1'; 
x=1; text=trim(left(stock)); output;
x=24; text=trim(left(sticker)); output;
position='1';
x=38; text=trim(left(put(begin_close,comma10.2))); output;

x=72; text=trim(left(put(end_close,comma10.2))); output;
x=81; text=trim(left(put((end_close-begin_close)/begin_close,percentn7.1))); output;
x=90; text=trim(left(put(min_close,comma10.2))); color="cxf755b5"; output;
x=99; text=trim(left(put(max_close,comma10.2))); color="cx42c3ff"; output;
color="";
run;


data anno_lines;
length function color $8;
xsys='1'; ysys='1'; color="graydd";
when='a';
function='move';  x=0; y=0; output;
 function='draw'; y=100; output;
function='move';  x=30; y=0; output;
 function='draw'; y=100; output;

function='move';  x=82; y=0; output;
 function='draw'; y=100; output;
function='move';  x=91; y=0; output;
 function='draw'; y=100; output;
function='move';  x=100; y=0; output;
 function='draw'; y=100; output;

function='label'; color=''; position='2'; y=100;
x=35; text="&mindate"; output;
x=69; text="&maxdate"; output;
x=87; text="low"; output;
x=96; text="high"; output;

when='b'; 
function='move';  x=23; y=0; output;
 function='bar'; color='grayee'; style='solid'; x=30; y=100; output;
run;


goptions ftitle="albany amt" ftext="albany amt" ctext=gray22 htitle=14pt htext=8pt;


ODS LISTING CLOSE;
ODS HTML path=odsout body="&name..htm"
 (title="SAS/Graph Stock Market Table") options(pagebreak='no') style=minimal;

symbol1 value=none interpol=join color=cx00cc00; /* green line */
symbol2 value=dot h=5pt interpol=none color=cx42c3ff; /* bright blue - high value */
symbol3 value=dot h=5pt interpol=none color=cxf755b5; /* red/pink - low value */

axis1 style=0 label=none major=none minor=none order=(0 to &y_max)
 value=none offset=(0,0);

axis2 style=0 label=none major=none minor=none order=("&mindate"d to "&maxdate"d by &days_by) 
 value=none offset=(45,40);

title1 "Stock Prices (sparkline table)";
title2 height=20pt " ";

footnote1 j=r c=gray "Note: Each sparkline is independently auto-scaled.";
proc gplot data=plotdata anno=anno_table;
 plot norm_close*date=1 high_close*date=2 low_close*date=3 / overlay skipmiss
 autovref cvref=graydd
 vaxis=axis1
 haxis=axis2
 noframe
 anno=anno_lines
 des='' name="&name";
run;

quit;
ods html close ;
ods listing ;
