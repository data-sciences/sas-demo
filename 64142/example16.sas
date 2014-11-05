%let name=example16;
filename odsout '.';

/*
This floorplan was the Demo Room layout at SUGI 30
*/

/* 
This is the floorplan image you're going to overlay the data on.
Note that once you pick a coordinate system for your image, 
and estimate x/y positions of the things on that floorplan,
then if you ever need to usdate the image, the new image
*must* have the same proportions, and cover the exact
same total area, or your estimated x/y coordinates are going 
to be off/mis-aligned.
*/
%let background_image=sugi30_floorplan.jpg;

/* 
Make the x/y size match the proportions of your background image.
In this particular example, the original image 579x908 pixels.
[Once you pick this xsize & ysize, you'll need to stick with it,
because that is the coordinate system you'll be using to position
the tables by X/Y positions.]
*/
%let xsize=579;
%let ysize=908;

/* The paper size needs to be a little bigger, to make room for the titles */
%let xpaper=750;
%let ypaper=940;
goptions xpixels=&xpaper ypixels=&ypaper;


/*
This is the blank rectangular outline of the casino floorplan map
(make sure it's the same proportions as the original map).
You will later 'annotate' the floorplan image into this area.
*/
data floorplan_blank;
 idnum=1;
 x=0; y=0; output;
 x=&xsize; y=0; output;
 x=&xsize; y=&ysize; output;
 x=0; y=&ysize; output;
run;


/*
This is the hard part!!!  
Estimating the x/y coordinates of each table in the demo room.
Give each table an id number, and then determine the x/y location of
each table by mousing over the location in an image editor, and recording
the pixel-based x/y location.
*/
data table_loc;
input table_num x y;
/* flip the y-value, since SAS/GRAPH's coordinate system starts at bottom/left */
y=&ysize-y;
datalines;
1 266 238
2 246 237
3 226 239
4 205 242
5 189 242
6 176 244
7 163 251
8 151 261
9 139 272
10 129 283
11 120 297
12 113 310
13 113 322
14 115 336
15 111 355
16 108 376
17 110 394
18 106 413
19 106 425
20 110 440
21 113 454
22 115 470
23 116 486
24 116 503
25 115 518
26 113 533
27 110 548
28 106 562
29 107 575
30 113 590
31 111 609
32 116 630
33 122 649
34 126 665
35 129 677
36 140 687
37 153 698
38 166 706
39 177 708
40 190 707
41 204 713
42 220 719
43 235 721
44 250 723
45 260 730
;
run;

/* How many visitors at each table */
data attendance;
input table_num visitors;
datalines;
1 725      
2 600
3  75
4 300
5 800
6 150
7 600
8 200
9 300
10 500
11 700
12 300
13 200
14 300
15 400
16 400
17 500
18 600
19 525
20 800
21 750
22 100
23 100
24 400
25 400
26 400
27 400
28 200
29 350
30 500
31 500
32 500
33 500
34 350
35 275
36 600
37 600
38 300
39 600
40 600
41 700
42 700
43 825
44 750
45 800
;
run;

proc sql;
create table anno_dots as
select attendance.*, table_loc.x, table_loc.y
from attendance left join table_loc
on attendance.table_num = table_loc.table_num;
quit; run;


/*
Create an annotated dot for each table 
*/
data anno_dots; set anno_dots;
length function color $8;
xsys='2'; ysys='2'; hsys='3'; when='a';   
function='pie'; rotate=360; style='psolid'; size=.55;
     if visitors<=100 then color='grayee';
else if visitors<=200 then color='cornsilk';
else if visitors<=300 then color='yellow';
else if visitors<=400 then color='orange';
else color='red';
output;
style='pempty'; color='gray33'; output;
run;

data anno_dots; set anno_dots;
length html $100;
if style='psolid' then 
html='title='||quote('Table '||trim(left(table_num))||' had '||trim(left(visitors))||' visitors'); 
run;


/*
This is the floorplan image you'll annotate onto the blank rectangular gmap.
*/
data anno_floorplan;
length  function $8;
xsys='2'; ysys='2'; hsys='3'; when='b'; 
function='move'; x=0; y=0; output;
function='image'; x=&xsize; y=&ysize; style='fit';
 imgpath="&background_image"; output;
run;


/* And now for a dot-density map variation... */

proc sql;
create table anno_density as
select attendance.*, table_loc.x, table_loc.y
from attendance left join table_loc
on attendance.table_num = table_loc.table_num;
quit; run;

data anno_density; set anno_density;
length function color $8;
xsys='2'; ysys='2'; hsys='3'; when='b';

function='pie'; color='white'; rotate=360; style='pempty'; size=.75;
length html $100;
html='title='||quote('Table '||trim(left(table_num))||' had '||trim(left(visitors))||' visitors');
output;

html='';
function='point'; color='red';
x_center=x; y_center=y;
do num_dots=1 to visitors;
 x=x_center+rannor(123)*4;
 y=y_center+rannor(456)*4;
 output;
end;

run;


 
GOPTIONS DEVICE=png;
ODS LISTING CLOSE;
ODS HTML path=odsout body="&name..htm" style=minimal;

goptions gunit=pct ftitle="albany amt/bold" ftext="albany amt" htitle=3 htext=2;

pattern1 v=empty;

title1 ls=1.5 "SUGI 30 Demo Room";
proc gmap data=floorplan_blank map=floorplan_blank anno=anno_floorplan; 
 id idnum; 
 choro idnum / nolegend coutline=black
 anno=anno_dots
 des="" name="&name"; 
run;

proc gmap data=floorplan_blank map=floorplan_blank anno=anno_floorplan;
 id idnum;
 choro idnum / nolegend coutline=black
 anno=anno_density
 des="" name="&name";
run;
 
quit;
ODS HTML CLOSE;
ODS LISTING;
 
