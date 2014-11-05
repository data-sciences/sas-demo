%let name=example18;
filename odsout '.';

/*
Imitation of a graph from 
http://biomed.brown.edu/Courses/BI108/BI108_2005_Groups/02/mortality.htm
*/

goptions reset=global;

data my_data;
format date year2.;
input date date9. male_deaths female_deaths;
datalines;
01jan1979 500 470
01jan1980 510 490
01jan1981 500 483
01jan1982 496 483
01jan1983 498 492
01jan1984 490 492
01jan1985 490 498
01jan1986 480 499
01jan1987 475 500
01jan1988 478 504
01jan1989 456 482
01jan1990 448 478
01jan1991 447 479
01jan1992 444 479
01jan1993 457 500
01jan1994 452 498
01jan1995 454 503
01jan1996 451 505
01jan1997 450 503
01jan1998 446 504
01jan1999 446 513
01jan2000 440 505
01jan2001 435 502
01jan2002 438 500
;
run;

data my_data; set my_data;
length myhtml $500;
 myhtml='title='|| quote(
  put(date,year4.)||'0D'x||
  trim(left(put(male_deaths*1000,comma9.0)))||' Male Deaths'||'0D'x||
  trim(left(put(female_deaths*1000,comma9.0)))||' Female Deaths'||' '
  )
||' '||
 'href="http://biomed.brown.edu/Courses/BI108/BI108_2005_Groups/02/mortality.htm"';
run;

data anno_gap;
xsys='1';
ysys='1';
hsys='3';
position='5';
function='label';
size=7;
angle=-33;
x=1; y=10; text='/'; output;
x=1; y= 7; text='/'; output;
run;


GOPTIONS DEVICE=png;
goptions border;

ODS LISTING CLOSE;
ODS HTML path=odsout body="&name..htm" (title="SAS/Graph chart of Mortality Trends") style=d3d;

goptions ftitle="albany amt/bold" ftext="albany amt" gunit=pct htitle=4 htext=3;
goptions cback=cxD1D1D1;

axis1 order=(400 to 520 by 20) minor=none label=(a=90 'Deaths in Thousands') offset=(10,0);

axis2 order=('01jan1979'd to '01jan2002'd by year) major=(height=.1) 
 minor=none offset=(3,3) label=(justify=left 'Year')
 value=(t=2 '' t=4 '' t=6 '' t=8 '' t=10 '' t=12 '' t=14 '' t=16 '' t=18 '' t=20 '' t=22 '' t=24 '');

/*
axis2 order=('01jan1979'd to '01jan2002'd by year) major=(height=.1) minor=none offset=(3,3) label=(justify=left 'Year')
     value=('1979' '' '81' '' '83' '' '85' '' '87' '' '89' '' '91' '' '93' '' '95' '' '97' '' '99' '' '01' '');
*/

 symbol1 i=join c=black v=none w=7;
 symbol2 i=join c=white v=none w=3;
 symbol3 i=none c=black f=markere v='W' h=.6;

 symbol4 i=join c=black v=none w=7;
 symbol5 i=join c=red v=none w=3;
 symbol6 i=none c=black f=markere v='W' h=.6;

 title  ls=0.5 justify=left "  Cardiovascular Disease Mortality Trends";
 title2 ls=0.5 justify=left font="albany amt/bold" height=4 "  for Males and Females";
 title3 ls=0.5 justify=left "   United States: 1979-2002";
 title4 a=90 h=2 " ";
 title5 a=-90 h=6 " ";
 footnote f=marker h=3pct c=red   'U'  f=markere move=(-2.25,-0) c=black 'U'
          f="albany amt" h=3.5pct c=black " Males    "
          f=marker h=3pct c=white 'U'  f=markere move=(-2.25,-0) c=black 'U'
          f="albany amt" h=3.5pct c=black " Females";

 proc gplot data=my_data anno=anno_gap;
 plot 
  female_deaths*date=1 female_deaths*date=2 female_deaths*date=3 
  male_deaths*date=4 male_deaths*date=5 male_deaths*date=6 
  / overlay noframe
 vaxis=axis1
 haxis=axis2
 autovref cvref=gray99
 html=myhtml
 nolegend
 des="" name="&name"; 
 run;

quit;
ODS HTML CLOSE;
ODS LISTING;
