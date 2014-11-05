%let name=example24;
filename odsout '.';

/*
http://www.radio-locator.com/cgi-bin/finder?sr=Y&s=&state=NC&format=pub&band=
*/

%let circle_color=red;
%let landcolor=cx96c8a2;


/* Get the North Carolina County Map map */
proc sql;
create table mymap as
select state, county, segment, x, y
from maps.counties
where (density<=3) and (state=stfips('NC')); 
quit; run;


data stations;
input lat long other $ 19-100;
radius_miles=scan(other,4,':');
length station $20;
station=scan(other,1,':');
station=substr(station,1,index(station,'MHz')-1);
datalines;
34.75944 76.85444 WBJD-FM 91.5 MHz:C1:85000 Watts:55:Craven Community College, Atlantic Beach, NC
35.26722 75.53528 WBUX-FM 90.5 MHz:C2:34000 Watts:40:University of North Carolina - Chapel Hill, Buxton, NC
35.58972 82.67389 WCQS-FM 88.1 MHz:C3:1600 Watts:35:Asheville, NC
35.28722 80.69583 WFAE-FM 90.7 MHz:C0:100000 Watts:75:Charlotte, NC
35.91722 80.29361 WFDD-FM 88.5 MHz:C1:60000 Watts:75:Wake Forest University, Winston-Salem, NC
35.84972 81.44444 WFHE-FM 90.3 MHz:C3:4000 Watts:37:Hickory, NC
35.17333 83.58111 WFQS-FM 91.3 MHz:C3:265 Watts:35:Franklin, NC
35.07278 78.89083 WFSS-FM 91.9 MHz:C1:100000 Watts:50:Fayetteville State University,Fayetteville, NC
34.13139 78.18806 WHQR-FM 91.3 MHz:C:100000 Watts:77:Wilmington, NC
35.41694 77.81583 WKNS-FM 90.3 MHz:C2:35000 Watts:52:Craven Community College,Kinston, NC
35.73500 82.28639 WNCW-FM 88.7 MHz:C:17000 Watts:75:Isothermal Community College,Spindale, NC
35.81111 77.74250 WRQM-FM 90.9 MHz:C2:7500 Watts:52:University of North Carolina - Chapel Hill, Rocky Mount, NC
36.28194 76.21222 WRVS-FM 89.9 MHz:C2:41000 Watts:50:Elizabeth City State University,Elizabeth City, NC
35.86639 79.16667 WUNC-FM 91.5 MHz:C:100000 Watts:85:University of North Carolina,Chapel Hill, NC
35.90000 76.34583 WUND-FM 88.9 MHz:C0:50000 Watts:65:Manteo, NC
35.88667 82.55639 WYQS-FM 90.5 MHz:A:250 Watts:35:Mars Hill, NC
35.10889 77.10278 WZNB-FM 88.5 MHz:A:300 Watts:16:Craven Community College,New Bern, NC
36.49389 78.18972 WZRN-FM 90.5 MHz:A:2300 Watts:25:Norlina, NC
run;

proc sort data=stations out=stations;
by descending radius_miles;
run;


/*
http://maps.google.com/maps?f=q&hl=en&q=35.26722,+-75.53528+(WBUX-FM)
*/



data stations; set stations;
  length text $25 color $12 function style $8;

  xsys='2'; ysys='2'; when='a'; 
  anno_flag=2;

  /* Convert degrees to radians */
  x=atan(1)/45 * long; 
  y=atan(1)/45 * lat;

  function='label';
  text=trim(left(scan(station,1,'-')))||' '||scan(station,2,' ');
  position='2';
  hsys='3'; size=2;
  color='black';
  output;

  function='pie';
  color="&circle_color";
  rotate=360;
  style='psolid';
  size=.4;
  output;

  /* degrees-to-radians conversion factor */
  d2r=3.1415926/180;

  /* Radius of the earth in miles */
  r=3958.739565;
  
  /* Calculate the points to draw a circle */
  do degree=0 to 360 by 5;  

     /* Begin a new circle */
     if degree=0 then do;
        function='poly';
        style='empty';
        line=1;
        end;
     /* Continue drawing the circle */
     else do;
        function='polycont';
        color="&circle_color";
        end;

     /* Calculate a point along the circle */
     y=arsin(cos(degree*d2r)*sin(radius_miles/R)*cos(lat*d2r)+cos(radius_miles/R)*sin(lat*d2r))/d2r;
     x=long+arsin(sin(degree*d2r)*sin(radius_miles/R)/cos(y*d2r))/d2r;

     /* Convert degrees to radians */
     x=d2r*x; 
     y=d2r*y;
     output;
  end;

run;





/* project the map and the dots */
data combined; set mymap stations; run;
proc gproject data=combined out=combined dupok /* project=hammer */;
  id state county;
run;
data mymap stations; set combined;
  if anno_flag=2 then output stations;
  else output mymap;
run;


data stations; set stations;
 length html $500;
 
 if function='pie' or function='label' then 
 html=
  'title='|| quote( trim(left(other)) )
  ||' '||
  'href='|| quote( 'http://maps.google.com/maps?f=q&hl=en&q='||trim(left(lat))||',+-'||trim(left(long))||
     '+('||trim(left(station))||')' );
run;


goptions device=png;
goptions xpixels=1000 ypixels=550;
goptions cback=cxcae1ff;
goptions border;


ODS LISTING CLOSE;
ODS HTML path=odsout body="&name..htm" (title="Public Radio Stations in NC (SAS/Graph gmap)") style=minimal;

goptions gunit=pct ftitle="albany amt/bold" ftext="albany amt" htitle=5 htext=3.5;

title link='http://www.radio-locator.com/cgi-bin/finder?sr=Y&s=&state=NC&format=pub&band=' "Public Radio Stations in NC";
title2 a=-90 h=4pct " ";  /* extra space on east side */
title3 a=90 h=1pct " ";
pattern1 v=msolid c=&landcolor;
proc gmap map=mymap data=mymap anno=stations;
id state county; 
choro state / levels=1
 coutline=grayaa  
 nolegend 
 des="" name="&name";
run;


/* alpha-transparent circle areas (requires SAS 9.3 or higher!) */
data stations; set stations;
if index(function,'poly')^=0 then do;
 style='solid';
 color='aF8A10266';
 end;
run;

/* gray outlines */
data outlines; set stations (where=(function='poly' or function='polycont'));
 style='empty';
 color='gray77';
run;

proc gmap map=mymap data=mymap anno=stations;
 id state county;
 choro state / levels=1 coutline=gray77 nolegend anno=outlines
 des="" name="&name";
run;



quit;
ODS HTML CLOSE;
ODS LISTING;
