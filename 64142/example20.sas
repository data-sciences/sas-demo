%let name=example20;
filename odsout '.';

filename lakefile "jormsr.txt";

/*
filename lakefile url "http://epec.saw.usace.army.mil/jormsr.txt"
 proxy='http://inetgw.fyi.sas.com:80';
*/

data lakedata;
infile lakefile firstobs=26 pad;
input wholeline $ 1-100;
if substr(wholeline,1,1) in ('1' '2') then output;
run;

data lakedata; set lakedata;
year=.; year=scan(wholeline,1,' ');
month=.; month=scan(wholeline,2,' ');
year_var=year+((month-1) * 1/12);
lake_level=.; lake_level=scan(wholeline,3,' ');
run;

data lakedata; set lakedata;
length myhtml $300;
myhtml= 'title='||quote( 'Level at beginning of month='||trim(left(lake_level))||'0d'x||
 'Year:'||trim(left(year))||'   month:'||trim(left(month))|| ' ');
run;


GOPTIONS DEVICE=png;
goptions cback=white;
goptions noborder;
 
ODS LISTING CLOSE;
ODS HTML path=odsout body="&name..htm" style=minimal;

goptions ftitle="albany amt/bold" ftext="albany amt" htitle=12pt htext=10pt;

/* If you need a nice dot that will work on non-Windows, use this SAS-supplied one */
/*
symbol1 font="cumberland amt/unicode" v='25cf'x h=1.4 i=join c=blue mode=include;
*/

/* But on Windows, the 'webdints' dot centers just a little better... */
symbol1 font="webdings" v='3d'x h=1.0 i=join c=blue mode=include;

axis1 label=(f="albany amt/bold" 'Elevation') order=(206 to 226 by 5) minor=none offset=(0,0);
axis2 label=(j=l f="albany amt/bold" 'Year') order=(1983 to 2011 by 1) minor=none offset=(0,0);

title j=left ls=1.5 " Monthly Water Level at Jordan Lake (1983-2010) - Time Series";

footnote j=right c=gray "Plot generated &sysdate";

goptions xpixels=2500 ypixels=300;
proc gplot data=lakedata;
plot lake_level*year_var / 
  vaxis=axis1 haxis=axis2
  vref=216 cvref=graydd
  autohref chref=graydd
  html=myhtml
  des="" name="&name"; 
run;

quit;
ODS HTML CLOSE;
ODS LISTING;
