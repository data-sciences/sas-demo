%let name=example09;
filename odsout '.';


%let dotcolor=pink;
%let inside_color=red;
%let landcolor=burlywood;


/* 
Create some fake customer data ...
To make it very easy to run this example, I'm just using some data that's
easily available in sashelp.  In your case, you'd have real customer data.
Just make sure you have city, state, zip variables (and you can also have
other variables such as customer_name, etc!)
*/
proc sql;
create table customers as
select unique city, statecode as state, zip
from sashelp.zipcode
where statecode='NC';
quit; run;

proc geocode ZIP /* method=ZIP in future releases */ NOCITY data=customers out=customers;
run;

/* convert lat/long degrees to radians */
data customers; set customers;
x=(atan(1)/45 * x)*-1;
y=(atan(1)/45 * y);
run;

/*
Create annotated 'dots' to represent each customer 
*/
data customers; 
  set customers; 
   length text function $8 style color $20;
   retain xsys ysys '2' hsys '3' when 'a';
  anno_flag=1;
  function='label';
  style='"albany amt"';
  position='5'; 
  size=2.0;
  color='gray55';
  text='X';
  output;
run;

/* Create a circular sales_region */

/*
This is where you change the center & radius of the circle
used to select the customers-of-interest.
*/
%let centerzip=27513;
%let radius_miles=40;

/*
Find the long/lat of the desired zipcode, and draw an annotated circle 
of the desired radius
*/
/* first, lookup the long/lat in sashelp.zipcode */
proc sql;
create table sales_region as
select zip, city, x*-1 as long, y as lat
from sashelp.zipcode
where (zip eq &centerzip);
quit; run;

data sales_region; set sales_region;
  retain xsys ysys '2' anno_flag 2 when 'a';
  length text function $8 style color $20 text $25;
  region_id=999999;

  /* Convert degrees to radians */
  x=atan(1)/45 * long; 
  y=atan(1)/45 * lat;

  /* degrees-to-radians conversion factor */
  d2r=3.1415926/180;

  /* Radius of the earth in miles */
  r=3958.739565;
  
  /* Point for the circle to be drawn around */
  xcen=long;
  ycen=lat;
  
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
        /* Outline the circle with desired color */
        function='polycont';
        color="&inside_color";
        end;

     /* Calculate a point along the circle */
     y=arsin(cos(degree*d2r)*sin(&radius_miles/R)*cos(ycen*d2r)+cos(&radius_miles/R)*sin(ycen*d2r))/d2r;
     x=xcen+arsin(sin(degree*d2r)*sin(&radius_miles/R)/cos(y*d2r))/d2r;

     /* Convert degrees to radians */
     x=atan(1)/45*x; 
     y=atan(1)/45*y;
     output;
  end;

run;


/* 
Determine which customers are inside that geographical sales region.
proc ginside is a new v9.2 proc 
*/
proc ginside data=customers map=sales_region out=customers;
id region_id;
run;

/* Now, for markers that are 'inside' the sales_region, set their color & marker to something special */
data customers; set customers;
if (region_id ne .) then do;
 color="&inside_color";
 style='"albany amt/unicode"';
 size=2.9;
 text='25cb'x;   /* unicode for albany amt circle character */
 end;
run;


/* Get the NC map */
data mymap; set maps.counties (rename=(state=num_state) where=(num_state=stfips('NC')));
state=fipstate(num_state);
run;

/* project the map and the dots */
data combined; set mymap customers sales_region; run;
proc gproject data=combined out=combined dupok /* project=hammer */;
  id state county;
run;
data mymap customers sales_region; set combined;
  if anno_flag=1 then output customers;
  else if anno_flag=2 then output sales_region;
  else output mymap;
run;

goptions device=png;
goptions xpixels=750 ypixels=410;

ODS LISTING CLOSE;
ODS HTML path=odsout body="&name..htm"
(title="Geocode Locations, and determine whether within arbitrary area")
style=minimal;

goptions gunit=pct ftitle="albany amt" ftext="albany amt" htitle=5 htext=4;

title1 "Customers Within 40 Mile Radius of &centerzip";
/*
title2 "using Proc " c=red "GEOCODE" c=black " and Proc " c=red "GINSIDE";
*/
pattern1 v=msolid c=&landcolor;
proc gmap map=mymap data=mymap anno=customers;
id state county; 
choro state / levels=1
 anno=sales_region
 coutline=grayaa  
 nolegend 
 des="" name="&name";
run;

/*
proc print data=mymap; run;
*/

quit;
ODS HTML CLOSE;
ODS LISTING;
