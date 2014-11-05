%let name=example02;
filename odsout '.';

goptions device=png;

/* this is to keep the bar width & space the same in v9.3 as it was in v9.2 */
goptions hpos=160 vpos=50;

/* Special user-defined format, to print $1000,000 as $100k */
proc format;
picture kdollar low-high='0009k ' (prefix='$' mult=.001);
run;

/*
You don't want the individual graphs to display (ie, be written to the output), 
while you're creating them.  You will turn on the displaying again just before
you do the 'proc greplay'.
*/
goptions nodisplay;


/* Read in data for various metrics */
data metrics;
input quarter $ 1-2 a_revenue t_revenue a_profit t_profit a_order_size t_order_size a_market_share t_market_share 
 a_satisfaction t_satisfaction a_on_time t_on_time a_new_cust t_new_cust;
datalines;
Q1 154057.33 150000 31999.35 37500 404.83 400 .2267 .24 3.1833 3.26 .8300 .92 346 300 
Q2 165157.71 167000 36748.61 41750 420.73 410 .2008 .25 2.9500 3.27 .7267 .93 430 350
Q3 199738.08 184000 42430.53 46000 434.75 420 .1867 .26 2.8167 3.28 .6500 .94 447 400
Q4 206263.97 215000 46685.17 53750 449.33 430 .1708 .27 2.6667 3.29 .6800 .95 468 450
;
run;

data metrics; set metrics;
format a_revenue a_profit kdollar.;
format a_market_share a_on_time percent6.0;
length ev_revenue ev_profit ev_order_size ev_market_share ev_satisfaction ev_on_time ev_new_cust $12;

 /* Evaluation of actual, as a percentage of target (using criteria specified in the contest) */

 pct_revenue=a_revenue/t_revenue;
 if pct_revenue < .6 then ev_revenue='Poor';
 else if pct_revenue < .9 then ev_revenue='Satisfactory';
 else if pct_revenue >=.9 then ev_revenue='Good';

 pct_profit=a_profit/t_profit;
 if pct_profit < .6 then ev_profit='Poor';
 else if pct_profit < .8 then ev_profit='Satisfactory';
 else if pct_profit >=.8 then ev_profit='Good';

 pct_order_size=a_order_size/t_order_size;
 if pct_order_size < .5 then ev_order_size='Poor';
 else if pct_order_size < .75 then ev_order_size='Satisfactory';
 else if pct_order_size >=.75 then ev_order_size='Good';

 pct_market_share=a_market_share/t_market_share;
 if pct_market_share < .65 then ev_market_share='Poor';
 else if pct_market_share < .9 then ev_market_share='Satisfactory';
 else if pct_market_share >=.9 then ev_market_share='Good';

 pct_satisfaction=a_satisfaction/t_satisfaction;
 if pct_satisfaction < .6 then ev_satisfaction='Poor';
 else if pct_satisfaction < .9 then ev_satisfaction='Satisfactory';
 else if pct_satisfaction >=.9 then ev_satisfaction='Good';

 pct_on_time=a_on_time/t_on_time;
 if pct_on_time < .6 then ev_on_time='Poor';
 else if pct_on_time < .9 then ev_on_time='Satisfactory';
 else if pct_on_time >=.9 then ev_on_time='Good';

 pct_new_cust=a_new_cust/t_new_cust;
 if pct_new_cust < .5 then ev_new_cust='Poor';
 else if pct_new_cust < .85 then ev_new_cust='Satisfactory';
 else if pct_new_cust >=.85 then ev_new_cust='Good';

run;

/* This is a missing-value placeholder, to guarantee that 
   all the bar charts use the 2 colors in the same way.  */
data foometrics;
length ev_revenue ev_profit ev_order_size ev_market_share ev_satisfaction ev_on_time ev_new_cust $12;

a_revenue=.;
a_profit=.;
a_order_size=.;
a_market_share=.;
a_satisfaction=.;
a_on_time=.;
a_new_cust=.;
quarter='Q1';

ev_revenue='Poor'; ev_profit='Poor'; ev_order_size='Poor'; ev_market_share='Poor'; 
 ev_satisfaction='Poor'; ev_on_time='Poor'; ev_new_cust='Poor'; output;

ev_revenue='Satisfactory'; ev_profit='Satisfactory'; ev_order_size='Satisfactory'; ev_market_share='Satisfactory'; 
 ev_satisfaction='Satisfactory'; ev_on_time='Satisfactory'; ev_new_cust='Satisfactory'; output;

ev_revenue='Good'; ev_profit='Good'; ev_order_size='Good'; ev_market_share='Good'; 
 ev_Good='Good'; ev_on_time='Good'; ev_new_cust='Good'; output;

run;

/* Add this missing-value placeholder to the actual data set */
data metrics; set metrics foometrics; run;


/* Add html charttips (title=) and drilldowns (href=) */
data metrics; set metrics;
length htm_revenue htm_profit htm_order_size htm_market_share htm_satisfaction htm_on_time htm_new_cust $200;

htm_revenue='title='||quote(
 'Quarter: '|| trim(left(quarter)) ||'0D'x||
 'Target: '|| trim(left(put(t_revenue,dollar12.0))) ||'0D'x||
 'Actual: '|| trim(left(put(a_revenue,dollar12.0))) ||'0D'x||
 'Actual as Percent of Target: '|| trim(left(put(pct_revenue,percent6.0)))
) ||' '|| 'href="scen3_info.htm"';

htm_profit='title='||quote(
 'Quarter: '|| trim(left(quarter)) ||'0D'x||
 'Target: '|| trim(left(put(t_profit,dollar12.0))) ||'0D'x||
 'Actual: '|| trim(left(put(a_profit,dollar12.0))) ||'0D'x||
 'Actual as Percent of Target: '|| trim(left(put(pct_profit,percent6.0)))
) ||' '|| 'href="scen3_info.htm"';

htm_order_size='title='||quote(
 'Quarter: '|| trim(left(quarter)) ||'0D'x||
 'Target: '|| trim(left(put(t_order_size,comma8.0))) ||'0D'x||
 'Actual: '|| trim(left(put(a_order_size,comma8.0))) ||'0D'x||
 'Actual as Percent of Target: '|| trim(left(put(pct_order_size,percent6.0)))
) ||' '|| 'href="scen3_info.htm"';

htm_market_share='title='||quote(
 'Quarter: '|| trim(left(quarter)) ||'0D'x||
 'Target: '|| trim(left(put(t_market_share,percent6.0))) ||'0D'x||
 'Actual: '|| trim(left(put(a_market_share,percent6.0))) ||'0D'x||
 'Actual as Percent of Target: '|| trim(left(put(pct_market_share,percent6.0)))
) ||' '|| 'href="scen3_info.htm"';

htm_satisfaction='title='||quote(
 'Quarter: '|| trim(left(quarter)) ||'0D'x||
 'Target: '|| trim(left(put(t_satisfaction,comma5.1))) ||'0D'x||
 'Actual: '|| trim(left(put(a_satisfaction,comma5.1))) ||'0D'x||
 'Actual as Percent of Target: '|| trim(left(put(pct_satisfaction,percent6.0)))
) ||' '|| 'href="scen3_info.htm"';

htm_on_time='title='||quote(
 'Quarter: '|| trim(left(quarter)) ||'0D'x||
 'Target: '|| trim(left(put(t_on_time,percent6.0))) ||'0D'x||
 'Actual: '|| trim(left(put(a_on_time,percent6.0))) ||'0D'x||
 'Actual as Percent of Target: '|| trim(left(put(pct_on_time,percent6.0)))
) ||' '|| 'href="scen3_info.htm"';

htm_new_cust='title='||quote(
 'Quarter: '|| trim(left(quarter)) ||'0D'x||
 'Target: '|| trim(left(put(t_new_cust,comma5.0))) ||'0D'x||
 'Actual: '|| trim(left(put(a_new_cust,comma5.0))) ||'0D'x||
 'Actual as Percent of Target: '|| trim(left(put(pct_new_cust,percent6.0)))
) ||' '|| 'href="scen3_info.htm"';

run;


/* Create the graphs for the various metrics */

%let titlesize=10;
%let textsize=6.5;
%let legendtitlesize=7;
%let fnt='albany amt';
%let fntb='albany amt/bold';

goptions gunit=pct htitle=&titlesize ftitle=&fntb htext=&textsize ftext=&fnt;

/* plot16 & plot17 ... xpixels=20%*900  ypixels=20%*800  */
goptions xpixels=180 ypixels=160;

/* define colors as macro variables, to use them consistently in several places */
%let green=cxc2e699;
%let pink=cxfa9fb5;
%let red=cxff0000;

%let gray=gray;
%let ltgray=graybb;
%let crefgray=graycc;

pattern1 v=s c=&green; 
pattern2 v=s c=&red; 
pattern3 v=s c=&pink; 

title "Revenue";
axis1 label=none minor=none major=(h=2) offset=(0,0);
axis2 label=none offset=(8,10);
data targets; set metrics (where=(t_revenue^=.));
length style color $20 function $8;
hsys='3'; position='5'; when='a';
/* Draw the horizontal line */
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_revenue; output;
function='move'; xsys='7'; x=-8.5; output;
function='draw'; xsys='7'; x=17; color="&gray"; size=.1; output;
/* Draw colored/filled triangle */
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_revenue; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='marker';
if (ev_revenue eq 'Good') then color="&green";
else if (ev_revenue eq 'Poor') then color="&red";
else if (ev_revenue eq 'Satisfactory') then color="&pink";
output;
/* Draw gray outline triangle */
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_revenue; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='markere';
color="&gray";
output;
run;
proc gchart data=metrics anno=targets;
 vbar quarter / discrete type=sum sumvar=a_revenue   subgroup=ev_revenue  nolegend     
 raxis=axis1 maxis=axis2
 autoref cref=&crefgray clipref
 coutline=&gray
 width=14 space=14
 html=htm_revenue
 des="" name="plot16" ;  
run;


title "Profit";
axis1 label=none minor=none major=(h=2) offset=(0,8);
axis2 label=none offset=(8,10);
data targets; set metrics (where=(t_profit^=.));
length style color $20 function $8;
hsys='3'; position='5'; when='a';
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_profit; output;
function='move'; xsys='7'; x=-8.5; output;
function='draw'; xsys='7'; x=17; color="&gray"; output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_profit; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='marker';
if (ev_profit eq 'Good') then color="&green";
else if (ev_profit eq 'Poor') then color="&red";
else if (ev_profit eq 'Satisfactory') then color="&pink";
output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_profit; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='markere';
color="&gray";
output;
run;
proc gchart data=metrics anno=targets;
 vbar quarter / discrete type=sum sumvar=a_profit   subgroup=ev_profit  nolegend
 raxis=axis1 maxis=axis2
 autoref cref=&crefgray clipref
 coutline=&gray
 width=14 space=14
 html=htm_profit
 des="" name="plot17" ;  
run;



/* plot1 - plot15 ... xpixels=20%*900  ypixels=19%*800  */
goptions xpixels=180 ypixels=152;


title "Order Size";
axis1 label=none minor=none major=(h=2) offset=(0,0);
axis2 label=none offset=(8,10);
data targets; set metrics (where=(t_order_size^=.));
length style color $20 function $8;
hsys='3'; position='5'; when='a';
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_order_size; output;
function='move'; xsys='7'; x=-8.5; output;
function='draw'; xsys='7'; x=17; color="&gray"; output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_order_size; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='marker';
if (ev_order_size eq 'Good') then color="&green";
else if (ev_order_size eq 'Poor') then color="&red";
else if (ev_order_size eq 'Satisfactory') then color="&pink";
output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_order_size; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='markere';
color="&gray";
output;
run;
proc gchart data=metrics anno=targets;
 vbar quarter / discrete type=sum sumvar=a_order_size  subgroup=ev_order_size  nolegend
 raxis=axis1 maxis=axis2
 autoref cref=&crefgray clipref
 coutline=&gray
 width=14 space=14
 html=htm_order_size
 des="" name="plot2" ;  
run;


title "Market Share";
axis1 label=none minor=none major=(h=2) offset=(0,10);
axis2 label=none offset=(8,10);
data targets; set metrics (where=(t_market_share^=.));
length style color $20 function $8;
hsys='3'; position='5'; when='a';
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_market_share; output;
function='move'; xsys='7'; x=-8.5; output;
function='draw'; xsys='7'; x=17; color="&gray"; output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_market_share; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='marker';
if (ev_market_share eq 'Good') then color="&green";
else if (ev_market_share eq 'Poor') then color="&red";
else if (ev_market_share eq 'Satisfactory') then color="&pink";
output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_market_share; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='markere';
color="&gray";
output;
run;
proc gchart data=metrics anno=targets;
 vbar quarter / discrete type=sum sumvar=a_market_share  subgroup=ev_market_share  nolegend
 raxis=axis1 maxis=axis2
 autoref cref=&crefgray clipref
 coutline=&gray
 width=14 space=14
 html=htm_market_share
 des="" name="plot1" ;  
run;


title "Satisfaction";
axis1 label=none minor=none major=(h=2) offset=(0,0) order=(0 to 5 by 1);
axis2 label=none offset=(8,10);
data targets; set metrics (where=(t_satisfaction^=.));
length style color $20 function $8;
hsys='3'; position='5'; when='a';
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_satisfaction; output;
function='move'; xsys='7'; x=-8.5; output;
function='draw'; xsys='7'; x=17; color="&gray"; output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_satisfaction; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='marker';
if (ev_satisfaction eq 'Good') then color="&green";
else if (ev_satisfaction eq 'Poor') then color="&red";
else if (ev_satisfaction eq 'Satisfactory') then color="&pink";
output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_satisfaction; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='markere';
color="&gray";
output;
run;
proc gchart data=metrics anno=targets;
 vbar quarter / discrete type=sum sumvar=a_satisfaction  subgroup=ev_satisfaction  nolegend
 raxis=axis1 maxis=axis2
 autoref cref=&crefgray clipref
 coutline=&gray
 width=14 space=14
 html=htm_satisfaction
 des="" name="plot5" ;  
run;


title "On Time Delivery";
axis1 label=none minor=none major=(h=2) offset=(0,0) order=(0 to 1 by .25);
axis2 label=none offset=(8,10);
data targets; set metrics (where=(t_on_time^=.));
length style color $20 function $8;
hsys='3'; position='5'; when='a';
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_on_time; output;
function='move'; xsys='7'; x=-8.5; output;
function='draw'; xsys='7'; x=17; color="&gray"; output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_on_time; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='marker';
if (ev_on_time eq 'Good') then color="&green";
else if (ev_on_time eq 'Poor') then color="&red";
else if (ev_on_time eq 'Satisfactory') then color="&pink";
output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_on_time; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='markere';
color="&gray";
output;
run;
proc gchart data=metrics anno=targets;
 vbar quarter / discrete type=sum sumvar=a_on_time  subgroup=ev_on_time  nolegend
 raxis=axis1 maxis=axis2
 autoref cref=&crefgray clipref
 coutline=&gray
 width=14 space=14
 html=htm_on_time
 des="" name="plot4" ;  
run;


title "New Customers";
axis1 label=none minor=none major=(h=2) offset=(0,0);
axis2 label=none offset=(8,10);
data targets; set metrics (where=(t_new_cust^=.));
length style color $20 function $8;
hsys='3'; position='5'; when='a';
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_new_cust; output;
function='move'; xsys='7'; x=-8.5; output;
function='draw'; xsys='7'; x=17; color="&gray"; output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_new_cust; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='marker';
if (ev_new_cust eq 'Good') then color="&green";
else if (ev_new_cust eq 'Poor') then color="&red";
else if (ev_new_cust eq 'Satisfactory') then color="&pink";
output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_new_cust; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='markere';
color="&gray";
output;
run;
proc gchart data=metrics anno=targets;
 vbar quarter / discrete type=sum sumvar=a_new_cust  subgroup=ev_new_cust  nolegend
 raxis=axis1 maxis=axis2
 autoref cref=&crefgray clipref
 coutline=&gray
 width=14 space=14
 html=htm_new_cust
 des="" name="plot3" ;  
run;


/*--------------------------------------------------------------------------------*/

/* Revenue by product (rvp) */

data products;
input quarter $ 1-2 a_cabernet t_cabernet a_zinfandel t_zinfandel a_merlot t_merlot 
 a_chardonnay t_chardonnay a_sauvignan_blanc t_sauvignan_blanc;
datalines;
Q1 28430.32 27000 13876.16 13500 25439.75 25500  68633.67 69000 17677.43 15000
Q2 30228.39 30060 10164.19 15030 24976.81 28390  64025.27 76820 35763.05 16700
Q3 35052.85 33120 17876.43 16560 28955.47 31280 104062.83 84640 13790.49 18400
Q4 38727.51 38700 18663.76 19350 28864.87 36550 107610.10 98900 12397.72 21500
;
run;

data products; set products;
format a_cabernet a_zinfandel a_merlot a_chardonnay a_sauvignan_blanc kdollar.;
length ev_cabernet ev_zinfandel ev_merlot ev_chardonnay ev_sauvignan_blanc $12;

 /* Evaluation of actual, as a percentage of target */

 pct_cabernet=a_cabernet/t_cabernet;
 if pct_cabernet < .6 then ev_cabernet='Poor';
 else if pct_cabernet < .9 then ev_cabernet='Satisfactory';
 else if pct_cabernet >=.9 then ev_cabernet='Good';

 pct_zinfandel=a_zinfandel/t_zinfandel;
 if pct_zinfandel < .6 then ev_zinfandel='Poor';
 else if pct_zinfandel < .9 then ev_zinfandel='Satisfactory';
 else if pct_zinfandel >=.9 then ev_zinfandel='Good';

 pct_merlot=a_merlot/t_merlot;
 if pct_merlot < .6 then ev_merlot='Poor';
 else if pct_merlot < .9 then ev_merlot='Satisfactory';
 else if pct_merlot >=.9 then ev_merlot='Good';

 pct_chardonnay=a_chardonnay/t_chardonnay;
 if pct_chardonnay < .6 then ev_chardonnay='Poor';
 else if pct_chardonnay < .9 then ev_chardonnay='Satisfactory';
 else if pct_chardonnay >=.9 then ev_chardonnay='Good';

 pct_sauvignan_blanc =a_sauvignan_blanc /t_sauvignan_blanc ;
 if pct_sauvignan_blanc  < .6 then ev_sauvignan_blanc ='Poor';
 else if pct_sauvignan_blanc  < .9 then ev_sauvignan_blanc ='Satisfactory';
 else if pct_sauvignan_blanc  >=.9 then ev_sauvignan_blanc ='Good';

run;

/* This is a missing-value placeholder, to guarantee that 
   all the bar charts use the 2 colors in the same way.  */
data fooproducts;

length ev_cabernet ev_zinfandel ev_merlot ev_chardonnay ev_sauvignan_blanc $12;

a_cabernet=.;
a_zinfandel=.;
a_merlot=.;
a_chardonnay=.;
a_sauvignan_blanc =.;
quarter='Q1';

ev_cabernet='Poor'; ev_zinfandel='Poor'; ev_merlot='Poor'; ev_chardonnay='Poor'; 
 ev_sauvignan_blanc ='Poor'; output;

ev_cabernet='Satisfactory'; ev_zinfandel='Satisfactory'; ev_merlot='Satisfactory'; ev_chardonnay='Satisfactory'; 
 ev_sauvignan_blanc ='Satisfactory'; output;

ev_cabernet='Good'; ev_zinfandel='Good'; ev_merlot='Good'; ev_chardonnay='Good'; 
 ev_sauvignan_blanc ='Good';  output;

run;
data products; set products fooproducts; run;


/* Add html charttips */
data products; set products;
length htm_cabernet htm_zinfandel htm_merlot htm_chardonnay htm_sauvignan_blanc $200;

htm_cabernet='title='||quote(
 'Quarter: '|| trim(left(quarter)) ||'0D'x||
 'Target: '|| trim(left(put(t_cabernet,dollar12.0))) ||'0D'x||
 'Actual: '|| trim(left(put(a_cabernet,dollar12.0))) ||'0D'x||
 'Actual as Percent of Target: '|| trim(left(put(pct_cabernet,percent6.0)))
) ||' '|| 'href="scen3_info.htm"';

htm_zinfandel='title='||quote(
 'Quarter: '|| trim(left(quarter)) ||'0D'x||
 'Target: '|| trim(left(put(t_zinfandel,dollar12.0))) ||'0D'x||
 'Actual: '|| trim(left(put(a_zinfandel,dollar12.0))) ||'0D'x||
 'Actual as Percent of Target: '|| trim(left(put(pct_zinfandel,percent6.0)))
) ||' '|| 'href="scen3_info.htm"';

htm_merlot='title='||quote(
 'Quarter: '|| trim(left(quarter)) ||'0D'x||
 'Target: '|| trim(left(put(t_merlot,dollar12.0))) ||'0D'x||
 'Actual: '|| trim(left(put(a_merlot,dollar12.0))) ||'0D'x||
 'Actual as Percent of Target: '|| trim(left(put(pct_merlot,percent6.0)))
) ||' '|| 'href="scen3_info.htm"';

htm_chardonnay='title='||quote(
 'Quarter: '|| trim(left(quarter)) ||'0D'x||
 'Target: '|| trim(left(put(t_chardonnay,dollar12.0))) ||'0D'x||
 'Actual: '|| trim(left(put(a_chardonnay,dollar12.0))) ||'0D'x||
 'Actual as Percent of Target: '|| trim(left(put(pct_chardonnay,percent6.0)))
) ||' '|| 'href="scen3_info.htm"';

htm_sauvignan_blanc ='title='||quote(
 'Quarter: '|| trim(left(quarter)) ||'0D'x||
 'Target: '|| trim(left(put(t_sauvignan_blanc,dollar12.0))) ||'0D'x||
 'Actual: '|| trim(left(put(a_sauvignan_blanc,dollar12.0))) ||'0D'x||
 'Actual as Percent of Target: '|| trim(left(put(pct_sauvignan_blanc ,percent6.0)))
) ||' '|| 'href="scen3_info.htm"';

run;


pattern1 v=s c=&green; 
pattern2 v=s c=&red; 
pattern3 v=s c=&pink; 

/* Use this axis for all the wine product charts */
axis1 label=none minor=none major=(h=2) offset=(0,0) order=(0 to 125000 by 25000);

title "Cabernet";
* axis1 label=none minor=none major=(h=2) offset=(0,0) ;
axis2 label=none offset=(8,10);
data targets; set products (where=(t_cabernet^=.));
length style color $20 function $8;
hsys='3'; position='5'; when='a';
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_cabernet; output;
function='move'; xsys='7'; x=-8.5; output;
function='draw'; xsys='7'; x=17; color="&gray"; output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_cabernet; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='marker';
if (ev_cabernet eq 'Good') then color="&green";
else if (ev_cabernet eq 'Poor') then color="&red";
else if (ev_cabernet eq 'Satisfactory') then color="&pink";
output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_cabernet; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='markere';
color="&gray";
output;
run;
proc gchart data=products anno=targets;
 vbar quarter / discrete type=sum sumvar=a_cabernet   subgroup=ev_cabernet  nolegend     
 raxis=axis1 maxis=axis2
 autoref cref=&crefgray clipref
 coutline=&gray
 width=14 space=14
 html=htm_cabernet
 des="" name="plot7" ;  
run;


title "Zinfandel";
* axis1 label=none minor=none major=(h=2) offset=(0,0) ;
axis2 label=none offset=(8,10);
data targets; set products (where=(t_zinfandel^=.));
length style color $20 function $8;
hsys='3'; position='5'; when='a';
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_zinfandel; output;
function='move'; xsys='7'; x=-8.5; output;
function='draw'; xsys='7'; x=17; color="&gray"; output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_zinfandel; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='marker';
if (ev_zinfandel eq 'Good') then color="&green";
else if (ev_zinfandel eq 'Poor') then color="&red";
else if (ev_zinfandel eq 'Satisfactory') then color="&pink";
output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_zinfandel; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='markere';
color="&gray";
output;
run;
proc gchart data=products anno=targets;
 vbar quarter / discrete type=sum sumvar=a_zinfandel   subgroup=ev_zinfandel  nolegend
 raxis=axis1 maxis=axis2
 autoref cref=&crefgray clipref
 coutline=&gray
 width=14 space=14
 html=htm_zinfandel
 des="" name="plot10" ;  
run;


title "Merlot";
* axis1 label=none minor=none major=(h=2) offset=(0,0) order=(0 to 40000 by 10000);
axis2 label=none offset=(8,10);
data targets; set products (where=(t_merlot^=.));
length style color $20 function $8;
hsys='3'; position='5'; when='a';
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_merlot; output;
function='move'; xsys='7'; x=-8.5; output;
function='draw'; xsys='7'; x=17; color="&gray"; output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_merlot; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='marker';
if (ev_merlot eq 'Good') then color="&green";
else if (ev_merlot eq 'Poor') then color="&red";
else if (ev_merlot eq 'Satisfactory') then color="&pink";
output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_merlot; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='markere';
color="&gray";
output;
run;
proc gchart data=products anno=targets;
 vbar quarter / discrete type=sum sumvar=a_merlot  subgroup=ev_merlot  nolegend
 raxis=axis1 maxis=axis2
 autoref cref=&crefgray clipref
 coutline=&gray
 width=14 space=14
 html=htm_merlot
 des="" name="plot8" ;  
run;


title "Chardonnay";
* axis1 label=none minor=none major=(h=2) offset=(0,0) order=(0 to 125000 by 25000);
axis2 label=none offset=(8,10);
data targets; set products (where=(t_chardonnay^=.));
length style color $20 function $8;
hsys='3'; position='5'; when='a';
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_chardonnay; output;
function='move'; xsys='7'; x=-8.5; output;
function='draw'; xsys='7'; x=17; color="&gray"; output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_chardonnay; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='marker';
if (ev_chardonnay eq 'Good') then color="&green";
else if (ev_chardonnay eq 'Poor') then color="&red";
else if (ev_chardonnay eq 'Satisfactory') then color="&pink";
output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_chardonnay; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='markere';
color="&gray";
output;
run;
proc gchart data=products anno=targets;
 vbar quarter / discrete type=sum sumvar=a_chardonnay  subgroup=ev_chardonnay  nolegend
 raxis=axis1 maxis=axis2
 autoref cref=&crefgray clipref
 coutline=&gray
 width=14 space=14
 html=htm_chardonnay
 des="" name="plot6" ;  
run;


title "Sauvignan Blanc ";
* axis1 label=none minor=none major=(h=2) offset=(0,0);
axis2 label=none offset=(8,10);
data targets; set products (where=(t_sauvignan_blanc ^=.));
length style color $20 function $8;
hsys='3'; position='5'; when='a';
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_sauvignan_blanc; output;
function='move'; xsys='7'; x=-8.5; output;
function='draw'; xsys='7'; x=17; color="&gray"; output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_sauvignan_blanc; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='marker';
if (ev_sauvignan_blanc eq 'Good') then color="&green";
else if (ev_sauvignan_blanc eq 'Poor') then color="&red";
else if (ev_sauvignan_blanc eq 'Satisfactory') then color="&pink";
output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_sauvignan_blanc; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='markere';
color="&gray";
output;
run;
proc gchart data=products anno=targets;
 vbar quarter / discrete type=sum sumvar=a_sauvignan_blanc   subgroup=ev_sauvignan_blanc   nolegend
 raxis=axis1 maxis=axis2
 autoref cref=&crefgray clipref
 coutline=&gray
 width=14 space=14
 html=htm_sauvignan_blanc 
 des="" name="plot9" ;  
run;


/* Revenue by region (rvr) */

data countries;
input quarter $ 1-2 a_namerica t_namerica a_europe t_europe a_asia t_asia 
 a_samerica t_samerica a_mideast t_mideast;
datalines;
Q1 78962.69  79500 30811.47 30000 28877.44 25500 3041.08 1500 12364.65 13500 
Q2 78137.97  86840 33031.54 33400 37472.43 29225 3435.02 2505 13080.76 15030 
Q3 91175.57  93840 39947.62 36800 48641.09 33120 4206.34 3680 15767.47 16560 
Q4 91441.01 107500 41252.79 43000 52943.77 39775 5034.58 5375 15591.82 19350 
;
run;

data countries; set countries;
format a_namerica a_europe a_asia a_samerica a_mideast kdollar.;
length ev_namerica ev_europe ev_asia ev_samerica ev_mideast $12;

 /* Evaluation of actual, as a percentage of target */

 pct_namerica=a_namerica/t_namerica;
 if pct_namerica < .6 then ev_namerica='Poor';
 else if pct_namerica < .9 then ev_namerica='Satisfactory';
 else if pct_namerica >=.9 then ev_namerica='Good';

 pct_europe=a_europe/t_europe;
 if pct_europe < .6 then ev_europe='Poor';
 else if pct_europe < .9 then ev_europe='Satisfactory';
 else if pct_europe >=.9 then ev_europe='Good';

 pct_asia=a_asia/t_asia;
 if pct_asia < .6 then ev_asia='Poor';
 else if pct_asia < .9 then ev_asia='Satisfactory';
 else if pct_asia >=.9 then ev_asia='Good';

 pct_samerica=a_samerica/t_samerica;
 if pct_samerica < .6 then ev_samerica='Poor';
 else if pct_samerica < .9 then ev_samerica='Satisfactory';
 else if pct_samerica >=.9 then ev_samerica='Good';

 pct_mideast =a_mideast /t_mideast ;
 if pct_mideast  < .6 then ev_mideast ='Poor';
 else if pct_mideast  < .9 then ev_mideast ='Satisfactory';
 else if pct_mideast  >=.9 then ev_mideast ='Good';

run;

/* This is a missing-value placeholder, to guarantee that 
   all the bar charts use the 2 colors in the same way.  */
data foocountries;
length ev_namerica ev_europe ev_asia ev_samerica length ev_mideast $12;

a_namerica=.;
a_europe=.;
a_asia=.;
a_samerica=.;
a_mideast =.;
quarter='Q1';

ev_namerica='Poor'; ev_europe='Poor'; ev_asia='Poor'; ev_samerica='Poor'; 
 ev_mideast ='Poor'; output;

ev_namerica='Satisfactory'; ev_europe='Satisfactory'; ev_asia='Satisfactory'; ev_samerica='Satisfactory'; 
 ev_mideast ='Satisfactory'; output;

ev_namerica='Good'; ev_europe='Good'; ev_asia='Good'; ev_samerica='Good'; 
 ev_mideast ='Good';  output;

run;
data countries; set countries foocountries; run;


/* Add html charttips */
data countries; set countries;
length htm_namerica htm_europe htm_asia htm_samerica htm_mideast $200;

htm_namerica='title='||quote(
 'Quarter: '|| trim(left(quarter)) ||'0D'x||
 'Target: '|| trim(left(put(t_namerica,dollar12.0))) ||'0D'x||
 'Actual: '|| trim(left(put(a_namerica,dollar12.0))) ||'0D'x||
 'Actual as Percent of Target: '|| trim(left(put(pct_namerica,percent6.0)))
) ||' '|| 'href="scen3_info.htm"';

htm_europe='title='||quote(
 'Quarter: '|| trim(left(quarter)) ||'0D'x||
 'Target: '|| trim(left(put(t_europe,dollar12.0))) ||'0D'x||
 'Actual: '|| trim(left(put(a_europe,dollar12.0))) ||'0D'x||
 'Actual as Percent of Target: '|| trim(left(put(pct_europe,percent6.0)))
) ||' '|| 'href="scen3_info.htm"';

htm_asia='title='||quote(
 'Quarter: '|| trim(left(quarter)) ||'0D'x||
 'Target: '|| trim(left(put(t_asia,dollar12.0))) ||'0D'x||
 'Actual: '|| trim(left(put(a_asia,dollar12.0))) ||'0D'x||
 'Actual as Percent of Target: '|| trim(left(put(pct_asia,percent6.0)))
) ||' '|| 'href="scen3_info.htm"';

htm_samerica='title='||quote(
 'Quarter: '|| trim(left(quarter)) ||'0D'x||
 'Target: '|| trim(left(put(t_samerica,dollar12.0))) ||'0D'x||
 'Actual: '|| trim(left(put(a_samerica,dollar12.0))) ||'0D'x||
 'Actual as Percent of Target: '|| trim(left(put(pct_samerica,percent6.0)))
) ||' '|| 'href="scen3_info.htm"';

htm_mideast ='title='||quote(
 'Quarter: '|| trim(left(quarter)) ||'0D'x||
 'Target: '|| trim(left(put(t_mideast,dollar12.0))) ||'0D'x||
 'Actual: '|| trim(left(put(a_mideast,dollar12.0))) ||'0D'x||
 'Actual as Percent of Target: '|| trim(left(put(pct_mideast ,percent6.0)))
) ||' '|| 'href="scen3_info.htm"';

run;


pattern1 v=s c=&green; 
pattern2 v=s c=&red; 
pattern3 v=s c=&pink; 

/* Use the same axis for all regions */
axis1 label=none minor=none major=(h=2) offset=(0,0) order=(0 to 125000 by 25000);

title "North America";
* axis1 label=none minor=none major=(h=2) offset=(0,0) order=(0 to 125000 by 25000);
axis2 label=none offset=(8,10);
data targets; set countries (where=(t_namerica^=.));
length style color $20 function $8;
hsys='3'; position='5'; when='a';
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_namerica; output;
function='move'; xsys='7'; x=-8.5; output;
function='draw'; xsys='7'; x=17; color="&gray"; output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_namerica; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='marker';
if (ev_namerica eq 'Good') then color="&green";
else if (ev_namerica eq 'Poor') then color="&red";
else if (ev_namerica eq 'Satisfactory') then color="&pink";
output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_namerica; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='markere';
color="&gray";
output;
run;
proc gchart data=countries anno=targets;
 vbar quarter / discrete type=sum sumvar=a_namerica   subgroup=ev_namerica  nolegend     
 raxis=axis1 maxis=axis2
 autoref cref=&crefgray clipref
 coutline=&gray
 width=14 space=14
 html=htm_namerica
 des="" name="plot11" ;  
run;


title "Europe";
* axis1 label=none minor=none major=(h=2) offset=(0,0) ;
axis2 label=none offset=(8,10);
data targets; set countries (where=(t_europe^=.));
length style color $20 function $8;
hsys='3'; position='5'; when='a';
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_europe; output;
function='move'; xsys='7'; x=-8.5; output;
function='draw'; xsys='7'; x=17; color="&gray"; output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_europe; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='marker';
if (ev_europe eq 'Good') then color="&green";
else if (ev_europe eq 'Poor') then color="&red";
else if (ev_europe eq 'Satisfactory') then color="&pink";
output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_europe; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='markere';
color="&gray";
output;
run;
proc gchart data=countries anno=targets;
 vbar quarter / discrete type=sum sumvar=a_europe   subgroup=ev_europe  nolegend
 raxis=axis1 maxis=axis2
 autoref cref=&crefgray clipref
 coutline=&gray
 width=14 space=14
 html=htm_europe
 des="" name="plot13" ;  
run;


title "Asia";
* axis1 label=none minor=none major=(h=2) offset=(0,0);
axis2 label=none offset=(8,10);
data targets; set countries (where=(t_asia^=.));
length style color $20 function $8;
hsys='3'; position='5'; when='a';
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_asia; output;
function='move'; xsys='7'; x=-8.5; output;
function='draw'; xsys='7'; x=17; color="&gray"; output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_asia; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='marker';
if (ev_asia eq 'Good') then color="&green";
else if (ev_asia eq 'Poor') then color="&red";
else if (ev_asia eq 'Satisfactory') then color="&pink";
output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_asia; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='markere';
color="&gray";
output;
run;
proc gchart data=countries anno=targets;
 vbar quarter / discrete type=sum sumvar=a_asia  subgroup=ev_asia  nolegend
 raxis=axis1 maxis=axis2
 autoref cref=&crefgray clipref
 coutline=&gray
 width=14 space=14
 html=htm_asia
 des="" name="plot12" ;  
run;


title "South America";
* axis1 label=none minor=none major=(h=2) offset=(0,0);
axis2 label=none offset=(8,10);
data targets; set countries (where=(t_samerica^=.));
length style color $20 function $8;
hsys='3'; position='5'; when='a';
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_samerica; output;
function='move'; xsys='7'; x=-8.5; output;
function='draw'; xsys='7'; x=17; color="&gray"; output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_samerica; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='marker';
if (ev_samerica eq 'Good') then color="&green";
else if (ev_samerica eq 'Poor') then color="&red";
else if (ev_samerica eq 'Satisfactory') then color="&pink";
output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_samerica; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='markere';
color="&gray";
output;
run;
proc gchart data=countries anno=targets;
 vbar quarter / discrete type=sum sumvar=a_samerica  subgroup=ev_samerica  nolegend
 raxis=axis1 maxis=axis2
 autoref cref=&crefgray clipref
 coutline=&gray
 width=14 space=14
 html=htm_samerica
 des="" name="plot15" ;  
run;


title "Middle East";
* axis1 label=none minor=none major=(h=2) offset=(0,0) order=(0 to 20000 by 5000);
axis2 label=none offset=(8,10);
data targets; set countries (where=(t_mideast ^=.));
length style color $20 function $8;
hsys='3'; position='5'; when='a';
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_mideast; output;
function='move'; xsys='7'; x=-8.5; output;
function='draw'; xsys='7'; x=17; color="&gray"; output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_mideast; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='marker';
if (ev_mideast eq 'Good') then color="&green";
else if (ev_mideast eq 'Poor') then color="&red";
else if (ev_mideast eq 'Satisfactory') then color="&pink";
output;
function='move';
xsys='2'; ysys='2'; midpoint=quarter; y=t_mideast; output;
function='move'; xsys='7'; x=8.5; output;
function='cntl2txt'; output;
function='label'; text='A'; size=4; xsys='7'; x=0;
style='markere';
color="&gray";
output;
run;
proc gchart data=countries anno=targets;
 vbar quarter / discrete type=sum sumvar=a_mideast   subgroup=ev_mideast   nolegend
 raxis=axis1 maxis=axis2
 autoref cref=&crefgray clipref
 coutline=&gray
 width=14 space=14
 html=htm_mideast 
 des="" name="plot14" ;  
run;



/* Pipeline Revenue by region (rvr) */

data pip_rgn; 
input Region $ 1-13 P1 P2 P3 P4;
datalines;
Asia           937 1439 3648 2760.10 
Europe        1165 1702 2955 1272.85 
Middle East    367  256  539  527.25 
North America 3384 3384 4592 3505.40 
South America  199  295  356  501.40 
;
run;

proc transpose data=pip_rgn out=pip_rgn; by Region; run;
data pip_rgn; set pip_rgn; run;
proc datasets;
 modify pip_rgn;
 rename _name_ = Probability;
 rename col1 = amount;
run;

data pip_rgn; set pip_rgn;
format amount kdollar.;

if probability eq 'P1' then psale=.9;
if probability eq 'P2' then psale=.75;
if probability eq 'P3' then psale=.5;
if probability eq 'P4' then psale=.25;

length htm_pip $200;
htm_pip='title='||quote(
 'Region: '|| trim(left(region)) ||'0D'x||
 'Amount in Pipeline: '|| trim(left(put(amount,dollar12.0))) ||'0D'x||
 'Probability of Closing Sale: '|| trim(left(put(psale,percent6.0)))
) ||' '|| 'href="scen3_info.htm"';

run;

 
/* define colors as macro variables, to use them consistently in several places */
%let c1=cx2171b5;
%let c2=cx6baed6;
%let c3=cxbdd7e7;
%let c4=cxeff3ff;


pattern1 v=s c=&c1; 
pattern2 v=s c=&c2; 
pattern3 v=s c=&c3; 
pattern4 v=s c=&c4; 

/* Fake a legend using annotate */

data legnanno;
length function $8 color style $12 text $50;
retain xsys ysys '3' hsys '3' when 'a';
function='label';
style="marker"; text='U'; size=10; position='5';
x=83; y=60; color="&c4"; output;
y=y-12; color="&c3"; output;
y=y-12; color="&c2"; output;
y=y-12; color="&c1"; output;
style="markere"; text='U'; size=10; position='5'; color="&ltgray";
x=83; y=60; output;
y=y-12; output;
y=y-12; output;
y=y-12; output;
style=''; size=&textsize; position='6'; color='black';
x=87; y=61; text="25%"; output;
y=y-12; text="50%"; output;
y=y-12; text="75%"; output;
y=y-12; text="90%"; output;

function='label'; position='5'; style=''; size=&legendtitlesize;
x=87; y=85; text='Probability'; output;
x=87; y=76; text='of Sale'; output;
run;

/* plot18 ... xpixels=35%*900  ypixels=19%*800  */
goptions xpixels=315 ypixels=152;

axis1 label=none minor=none major=(h=2) offset=(0,0);
axis2 label=none offset=(8,8) value=(j=right);
title "Sales Pipeline";
title2 a=-90 h=35pct " ";
proc gchart data=pip_rgn anno=legnanno;
 hbar region / discrete type=sum sumvar=amount   subgroup=probability  nolegend     
 autoref cref=&crefgray clipref
 raxis=axis1 maxis=axis2
 coutline=&ltgray
 width=14 space=14
 nostats
 descending
 html=htm_pip
 des="" name="plot18" ;  
run;



/* Pipeline Revenue by region (rvr) */
data custsale;
input Customer $ 1-23 cPipe bQTD YTD;
datalines;
American Vintner's Best 2389 3535 75396 
Barrel and Keg          2178  932 40536 
Cheers                  1738 1457 58008 
Fruit of the Vine       3972 3068 73332 
Happy Hour              1388    0  9396 
Sips and Bites          2895 3085 63456 
Spirits of the Age      3903 3680 77604 
The Beverage Company    3799 2956 62796 
The Big Wine Store      5083 3685 88368 
Wines 'R Us             4263 3865 82044 
run;

data custsale (drop=ytd); set custsale;
 aYTDmQTD=YTD-bQTD;
run;
proc transpose data=custsale out=custsale; by Customer; run;
data custsale; set custsale; run;
proc datasets;
 modify custsale;
 rename _name_ = chunk;
 rename col1 = amount;
run;

data custsale; set custsale;
format amount kdollar.;

length description $100;
if chunk eq 'cPipe' then description='In the pipeline.';
else if chunk eq 'bQTD' then description='Quarter-to-date.';
else if chunk eq 'aYTDmQTD' then description='Year-to-date minus Quarter-to-date.';

length htm_cust $200;
htm_cust='title='||quote(
 'Customer: '|| trim(left(customer)) ||'0D'x||
 'Amount: '|| trim(left(put(amount,dollar12.0))) ||'0D'x||
 'Description: '|| trim(left(description))
) ||' '|| 'href="scen3_info.htm"';

run;

/* define colors as macro variables, to use them consistently in several places */
%let d1=cx2171b5;
%let d2=cx2171b5;
%let d3=cxeff3ff;

/* bar segment legend */
data legend3;

 length function $8 color style $12 text $30;
 xsys='3'; ysys='3'; hsys='3'; when='A';

 color="&c1"; style='msolid';
 function='poly';
 x=85; y=20; output;
 function='polycont';
 x=x+4; output;
 y=y+30; output;
 x=x-4; output;
 y=y-30; output;

 color="&d2";
 function='poly';
 x=85; y=50; output;
 function='polycont';
 x=x+4; output;
 y=y+10; output;
 x=x-4; output;
 y=y-10; output;

 color="&d3";
 function='poly';
 x=85; y=60; output;
 function='polycont';
 x=x+4; output;
 y=y+10; output;
 x=x-4; output;
 y=y-10; output;

 color="&ltgray";
 size=.1;
 function='move';
 x=85; y=20; output;
 function='draw';
 x=x+4; output;
 y=y+30; output;
 x=x-4; output;
 y=y-30; output;

 function='move';
 x=85; y=50; output;
 function='draw';
 x=x+4; output;
 y=y+10; output;
 x=x-4; output;
 y=y-10; output;

 function='move';
 x=85; y=60; output;
 function='draw';
 x=x+4; output;
 y=y+10; output;
 x=x-4; output;
 y=y-10; output;

 color='gray99';
 function='move'; x=90.6; y=61; output; function='draw'; y=y+8; output;
 function='move'; x=90.6; y=51; output; function='draw'; y=y+8; output;
 function='move'; x=83.4; y=20; output; function='draw'; y=y+39; output;

 function='label'; position='6';
 style='centx'; color='gray99';
 style=''; size=&textsize; color='black';
 x=92; y=66.5; text='Pipe'; output;
 x=92; y=57; text='QTD'; output;
 x=77; y=41; text='YTD'; output;

 /* Then add some legend labels */
 function='label'; position='5'; style=''; size=&legendtitlesize;
 x=86; y=87; text='Bar'; output;
 x=86; y=78; text='Segments'; output;

run;


pattern1 v=s c=&d1; 
pattern2 v=s c=&d2; 
pattern3 v=s c=&d3; 

/* plot19 ... xpixels=50%*900  ypixels=19%*800  */
goptions xpixels=450 ypixels=152;

axis1 label=none minor=none major=(number=4 h=2) offset=(0,0);
axis2 label=none offset=(5,5) value=(j=right);
title "Top 10 Customers";
title2 a=-90 h=60pct " ";
footnote;
proc gchart data=custsale anno=legend3;
 hbar customer / discrete type=sum sumvar=amount   
 subgroup=chunk  
 autoref cref=&crefgray clipref
 raxis=axis1 maxis=axis2
 coutline=&ltgray
 width=14 space=14
 nostats
 nolegend     
 descending
 html=htm_cust
 des="" name="plot19" ;  
run;


/* Annotate a title and legend at the top/right of the page */

data titlanno;
length function $8 color style $20 text $50;
retain xsys ysys '3' hsys '3' when 'a'; 
function='label'; 
position='5'; 

x=75; y=97; color='black'; size=4; style="&fntb";
text='Sales Dashboard'; output;

x=75; y=93; color='black'; size=2.5; style='';
text='(All currency in US $)'; output;

x=75; y=89; color='black'; size=2.5; style='';
text='19dec2004'; output;

style="marker"; text='U'; size=2;
x=44; y=84; color="&red"; output;
y=y+3; color="&pink"; output;
y=y+3; color="&green"; output;
y=y+3; color="gray"; size=1.5; text='A'; output;

style="markere"; text='U'; size=2;
x=44; y=84; color="&ltgray"; output;
y=y+3; color="&ltgray"; output;
y=y+3; color="&ltgray"; output;

style=''; size=1.5; color="black"; position='6';
x=45.5; y=84.3; text="Poor"; output;
y=y+3; text="Satisfactory"; output;
y=y+3; text="Good"; output;
y=y+3; text="Target"; output;

run;

goptions xpixels=900 ypixels=800;
title;
footnote;
proc gslide anno=titlanno des="" name="titles";
run;



/* Turn displaying back on, so the final greplay of all the graphs will show up in the output */
goptions display;

goptions xpixels=900 ypixels=800;
goptions cback=grayee;
goptions border;
 
ODS LISTING CLOSE;
ODS HTML path=odsout body="&name..htm" (title="DM Review Magazine's winning dashboard (by SAS/Graph)") style=minimal;

/* Now, put it all together onto one page, using proc greplay */
proc greplay tc=tempcat nofs igout=work.gseg;
  tdef dashbrd des='Dashboard'

/* overall titles (whole page) */
   0/llx = 0   lly =  0
     ulx = 0   uly =100
     urx =100  ury =100
     lrx =100  lry =  0

/* 2 graphs in top/left */
  16/llx = 0   lly = 80
     ulx = 0   uly =100
     urx =20   ury =100
     lrx =20   lry = 80
  17/llx =20   lly = 80
     ulx =20   uly =100
     urx =40   ury =100
     lrx =40   lry = 80

/* 1st row of 5 graphs */
   1/llx = 0   lly = 60
     ulx = 0   uly = 79
     urx =20   ury = 79
     lrx =20   lry = 60
   2/llx =20   lly = 60
     ulx =20   uly = 79
     urx =40   ury = 79
     lrx =40   lry = 60
   3/llx =40   lly = 60
     ulx =40   uly = 79
     urx =60   ury = 79
     lrx =60   lry = 60
   4/llx =60   lly = 60
     ulx =60   uly = 79
     urx =80   ury = 79
     lrx =80   lry = 60
   5/llx =80   lly = 60
     ulx =80   uly = 79
     urx =100  ury = 79
     lrx =100  lry = 60

/* 2nd row of 5 graphs (products/wines) */
   6/llx = 0   lly = 40
     ulx = 0   uly = 59
     urx =20   ury = 59
     lrx =20   lry = 40
   7/llx =20   lly = 40
     ulx =20   uly = 59
     urx =40   ury = 59
     lrx =40   lry = 40
   8/llx =40   lly = 40
     ulx =40   uly = 59
     urx =60   ury = 59
     lrx =60   lry = 40
   9/llx =60   lly = 40
     ulx =60   uly = 59
     urx =80   ury = 59
     lrx =80   lry = 40
  10/llx =80   lly = 40
     ulx =80   uly = 59
     urx =100  ury = 59
     lrx =100  lry = 40

/* 3rd row of 5 graphs (countries) */
  11/llx = 0   lly = 20
     ulx = 0   uly = 39
     urx =20   ury = 39
     lrx =20   lry = 20
  12/llx =20   lly = 20
     ulx =20   uly = 39
     urx =40   ury = 39
     lrx =40   lry = 20
  13/llx =40   lly = 20
     ulx =40   uly = 39
     urx =60   ury = 39
     lrx =60   lry = 20
  14/llx =60   lly = 20
     ulx =60   uly = 39
     urx =80   ury = 39
     lrx =80   lry = 20
  15/llx =80   lly = 20
     ulx =80   uly = 39
     urx =100  ury = 39
     lrx =100  lry = 20

/* 2 graphs at bottom of page */
  18/llx = 7   lly =  0
     ulx = 7   uly = 19
     urx =42   ury = 19
     lrx =42   lry =  0
  19/llx =45   lly =  0
     ulx =45   uly = 19
     urx =95   ury = 19
     lrx =95   lry =  0
;
template = dashbrd;
/* 
nn:abc
nn = matches numbers in the greplay template
abc = matches the names of the graph grsegs (ie, the name='abc' on the proc gchart, etc)
*/
treplay 
 16:plot16 17:plot17  0:titles
 1:plot1 2:plot2 3:plot3 4:plot4 5:plot5 
 6:plot6 7:plot7 8:plot8 9:plot9 10:plot10
 11:plot11 12:plot12 13:plot13 14:plot14 15:plot15
 18:plot18 19:plot19
 des='' name="&name";
run;

quit;
ODS HTML CLOSE;
ODS LISTING;
