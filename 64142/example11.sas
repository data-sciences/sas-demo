%let name=example11;
filename odsout '.';

%let targetdate=15sep2003;

data my_data;
format kwh comma5.0;
format date mmyy5.;
input date date9. kwh;
if date eq "&targetdate"d then billmonth=1;
else billmonth=0;
datalines;
15sep2002   800
15oct2002   550
15nov2002   200
15dec2002   190
15jan2003   250
15feb2003   200
15mar2003   225
15apr2003   190
15may2003   325
15jun2003   350
15jul2003   675
15aug2003   775
15sep2003   875
;
run;

proc sort data=my_data out=my_data;
by date;
run;

/* build the string for custom axis tickmark values */
data my_data; set my_data;
length axis_text $200;
retain axis_text;
if mod(_n_,2)=1 then 
 axis_text=trim(left(axis_text))||' t='||trim(left(_n_))||' '||quote(put(date,monname3.));
else 
 axis_text=trim(left(axis_text))||' t='||trim(left(_n_))||' '||quote(' ');
run;

proc sql;
select axis_text into :axis_text from my_data having date=max(date);
quit; run;

data logo_anno;
   length function $8;
   xsys='3'; ysys='3'; when='a';
   function='move'; x=0; y=92; output;
   function='image'; x=x+36.4; y=y+7; imgpath='power_logo.png'; style='fit'; output;
run;


GOPTIONS DEVICE=png;
goptions xpixels=480 ypixels=384;
goptions border;
 
ODS LISTING CLOSE;
ODS HTML path=odsout body="&name..htm" (title="Power Bill") style=minimal;
 
goptions gunit=pct htitle=6 ftitle="albany amt/bold" htext=4.5 ftext="albany amt/bold";

title1 h=8 " ";
title2 j=l h=4 f="albany amt" " JOHNNY LIGHTNING";
title3 j=l h=4 f="albany amt" " 123 TREADMILL WAY";
title4 j=l h=4 f="albany amt" " CARY NC 27513";
title5 h=6 " ";
title6 j=c h=6 "kWh Usage History";

axis1 label=none offset=(5,5) value=( &axis_text );
axis2 label=none minor=none major=(number=5);

pattern1 v=x1 c=graybb;
pattern2 v=x2 c=black;

proc gchart data=my_data anno=logo_anno; 
vbar date / discrete type=sum sumvar=kwh  
 subgroup=billmonth nolegend
 maxis=axis1 raxis=axis2 noframe
 width=5 space=2.25 coutline=black
 autoref cref=graydd clipref
 des="" name="&name"; 
run;

quit;
ODS HTML CLOSE;
ODS LISTING;
