%let name=example23;
filename odsout '.';

%let colora=cx52b1ff;  /* lowest */
%let colorb=cx00f8f1;
%let color1=cxffffc6;
%let color2=cxffe369;
%let color3=cxffb935;
%let color4=cxff8318;
%let color5=cxff290a;  /* highest */

/*
SAS/Graph imitation of maps like...
http://www.globalwarmingart.com/wiki/Image:Tropical_Storm_Map_png
http://en.wikipedia.org/wiki/File:Global_tropical_cyclone_tracks-edit2.jpg
*/


/* ---------------- Manipulate World Map ------------------ */

/* I want a world map with dateline in the middle, rather than prime meridian in the middle... */

/* Reduce density, so it's easier to work with */
data whole_map;
 set maps.world (where=(density<=1 and cont^=97) drop=x y);
 x=long;
 y=lat;
run;

/* Use gproject to clip-and-close polygons for left & right side */
proc gproject data=whole_map out=right_map dupok project=none
  longmin=0 longmax=4;
  id id;
run;
proc gproject data=whole_map out=left_map dupok project=none
  longmin=-4 longmax=0;
  id id;
run;



/*
Move the right half of the map to the left, and make the segment
variables unique, since some segments got split into two.
*/
data right_map; set right_map;
segment=segment+5000;
x=x-(3.14159*2);
run;
data left_map; set left_map;
run;

/* Put map back together. */
data world_map; set right_map left_map;
run;



/* ------------------ Storm Data ------------------ */


libname here '.';

data stormdata; set here.stormdata
 ;
 /* 
 (where=(year=2000)) 
 (where=(year=2000 and month=1 and stormnum=4)) 
 (where=(year>1990 and year<1994 and (region='e_pacific' or region='atlantic') ))
 atlantic
 e_pacific
 w_pacific
 s_indian
 n_indian
 */

 x=atan(1)/45 * long;
 y=atan(1)/45 * lat;

 /* Have to play this little trick here, like I did for the left & right sides of the map */
 if x>0 then x=x-(3.14159*2);

 /* 
 For these Atlantic hurricanes, only keep data that's east of Alaska on the map,
 otherwise the line would run across the map.
 For example: (stormnum=15 and year=2005) or (stormnum=11 and year=2004)
 Also long=0 for Maria 2005
 */
 if region eq 'atlantic' then do;
  if long<180 and long^=0 then output;
 end;
 else if region eq 's_indian' then do;
  if long>45 then output;
 end;
 else do;
  output;
 end;
 
run;


/* 
Do some data cleaning...
For some unknown reason, they repeat the exact same data multiple times for
some of the hurricanes (such as KATE in 2003) - this causes the first obsn to
look like it's joined to the last obsn, in my annotated line.
Let's hope this simple sql keeps things in the original order...
*/
proc sql;
create table stormdata as
select unique *
from stormdata
order by region, year, stormnum, snbr, month, day, time;
quit; run;

data stormdata; set stormdata;
 anno_flag=1;
 orig_order+1;
run;

/*
Note that I have to use 'norangecheck', because I've subtracted 2*3.14159 
from the x (unprojected longitude, in radians) values for 1/2 of my map, 
so that Eur-Asia is on the left, and the Americas is on the right.
*/
data combined; set world_map stormdata; run;
proc gproject data=combined out=combined dupok norangecheck project=cylindri;
  id id;
run;
data world_map stormdata;
  set combined;
  if anno_flag=1 then output stormdata;
  else output world_map;
run;



/* 
Find the maximum wind for each storm, so you can sort the lines so the 
more powerful storms are on top, and more visible.
*/
proc sql;
create table stormdata as
select unique *, max(wind) as maxwind
from stormdata
group by region, snbr;
quit; run;

proc sort data=stormdata out=stormdata;
 by maxwind region snbr orig_order;
run;

/*
The combination of region, and snbr (cumulative storm number, over all the years)
should uniquely identify each hurricane.
*/
data stormdata; set stormdata;
length byvar $20;
byvar=trim(left(region))||'_'||trim(left(snbr));
run;

data path_anno; 
   length function color $8 position $1;
   retain xsys ysys '2' hsys '3' when 'a';

  set stormdata (keep = byvar month region snbr lat long x y wind); 
  /* I use the 'notsorted' because of the maxwind overall sorting */
  by byvar notsorted;


  position='5';
  size=.1;

  if first.byvar then do;
  function='move'; output;
  end;



  else do;
  function='draw';
  if  wind<34 then color="&colora";
  else if wind<=63  then color="&colorb";
  else if wind<=82  then color="&color1";
  else if wind<=95  then color="&color2";
  else if wind<=112  then color="&color3";
  else if wind<=135  then color="&color4";
  else if wind>135  then color="&color5";
  else color="pink";
  output;
  end;

run;


/* Also, create country outline annotate dataset, to draw on top of the colored storm lines. */
data outline;
   length COLOR FUNCTION $ 8;
   retain XSYS YSYS '2' COLOR 'BLACK' SIZE 1.75 WHEN 'A' FX FY FUNCTION;
   set world_map; by id Segment notsorted;
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


goptions device=png;
goptions cback=cx12125a;
goptions border;
 
ODS LISTING CLOSE;
ODS HTML path=odsout body="&name..htm" (title="Tracks and Intensities of Tropical Storms (SAS/Graph 'proc gmap')") 
 style=minimal;

goptions gunit=pct htitle=6 htext=4 ftitle="albany amt/bold" ftext="albany amt/bold";

pattern v=s c=cx5a5a5a;

title1 h=.25in c=white "Tracks and Intensities of Tropical Storms";
title2 h=.18in c=white "All Available Data (1851-present)";

footnote1 
 f=marker h=.13in c=&colora 'U' h=.18in c=white f="albany amt/bold" " TD     "
 f=marker h=.13in c=&colorb 'U' h=.18in c=white f="albany amt/bold" " TS     "
 f=marker h=.13in c=&color1 'U' h=.18in c=white f="albany amt/bold" " 1     "
 f=marker h=.13in c=&color2 'U' h=.18in c=white f="albany amt/bold" " 2     "
 f=marker h=.13in c=&color3 'U' h=.18in c=white f="albany amt/bold" " 3     "
 f=marker h=.13in c=&color4 'U' h=.18in c=white f="albany amt/bold" " 4     "
 f=marker h=.13in c=&color5 'U' h=.18in c=white f="albany amt/bold" " 5"
 ;
footnote2 h=.18in c=white f="albany amt/bold" "Saffir-Simpson Hurricane Intensity Scale";
footnote3 h=.08 " ";

goptions xpixels=1200 ypixels=600;
proc gmap map=world_map data=world_map anno=path_anno;
id id; 
choro id / levels=1
 coutline=same  
 nolegend 
 anno=outline
 des="" name="&name";
run;

quit;
ODS HTML CLOSE;
ODS LISTING;
