%let name=example08;
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

/* Create a sales region made up of counties */

/* Select which counties are in your sales region */
data sales_region; set maps.counties (rename=(state=num_state) 
 where=(num_state=stfips('NC') and county in (183 101 85 105 37 63 135 77 69 127 195)));
state=fipstate(num_state);
region_id=999999;
run;

/* Create annotate outline of sales region */
/* remove the internal county boundaries, for one contiguous sales region outline */
proc gremove data=sales_region out=sales_region;
by region_id;
id state county;
run;
/* Create the annotate dataset */
data sales_region;
   length COLOR FUNCTION $ 8;
   retain XSYS YSYS '2' COLOR 'red' SIZE 1.75 WHEN 'A' FX FY FUNCTION;
   set sales_region; by region_id Segment;
   anno_flag=2;
   if first.Segment then do;
      FUNCTION = 'Move'; FX = X; FY = Y; end;
   else if FUNCTION ^= ' ' then do;
      if X = .  then do;
         X = FX; Y = FY; output; FUNCTION = ' '; end;
      else FUNCTION = 'Draw';
   end;
   if FUNCTION ^= ' ' then do;
      output;
      if last.Segment then do;
         X = FX; Y = FY; output; end;
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

title1 "Customers Within Multi-County Sales Region";
/*
title2 "using Proc " c=red "GEOCODE" c=black ", Proc " c=red "GREMOVE" c=black " and Proc " c=red "GINSIDE";
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
