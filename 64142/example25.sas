%let name=example25;
filename odsout '.';

/*
SAS/Graph imitation/enhancement of ...
http://www.dadisp.com/grafx/XYZ-lg.gif
*/



data foo;
 do time = 0 to 1 by .0015;
    Angle=4*360*time;
    radians=Angle*(atan(1)/45);
    X = sin(radians); 
    Y = cos(radians);
    Z = time;
    output;
 end;
run;

data foo; set foo;
length colorvar $8;
     if Z<=0.1 then colorvar='cx0bf5ff';
else if Z<=0.2 then colorvar='cx1de0ff';
else if Z<=0.3 then colorvar='cx3ec0ff';
else if Z<=0.4 then colorvar='cx5f9eff';
else if Z<=0.5 then colorvar='cx738aff';
else if Z<=0.6 then colorvar='cx8974ff';
else if Z<=0.7 then colorvar='cx9f5eff';
else if Z<=0.8 then colorvar='cxc33dff';
else if Z<=0.9 then colorvar='cxe21bff';
else if Z<=1.0 then colorvar='cxf607ff';
run;


goptions device=png;
goptions xpixels=275 ypixels=200;
goptions cback=white;
goptions noborder;
 
ODS LISTING CLOSE;
ODS HTML path=odsout body="&name..htm" (title="Custom SAS/Graph spiral chart") /* style=minimal */;

goptions htitle=11pt htext=7pt ftitle="albany amt/bo" ftext="albany amt";

goptions nodisplay;

axis1 label=none order=(-1.5 to 1.5 by .5) minor=none offset=(0,0);
axis2 label=none order=(0 to 1 by .1) minor=none value=(t=1 '0' t=11 ' ') offset=(0,0);
axis3 label=none order=(-.2 to 1.2 by .2) minor=none offset=(0,0);

symbol1 i=join width=1 v=none c=red;
symbol2 i=join width=1 v=none c=blue;
symbol3 i=join width=1 v=none c=blue;

title1 ls=2.5 "X Data";
title2 a=90 h=10pct " ";
footnote1 h=10pct " ";
proc gplot data=foo;
plot x*time=1 / 
 autohref chref=graydd autovref cvref=graydd 
 vaxis=axis1 haxis=axis2 des='' name="plot1";
run;

title1 ls=2.5 "Y Data";
title2 a=90 h=10pct " ";
footnote1 h=10pct " ";
proc gplot data=foo;
plot y*time=2 / 
 autohref chref=graydd autovref cvref=graydd 
 vaxis=axis1 haxis=axis2 des='' name="plot2";
run;


title1 ls=2.5 "Z Data";
title2 a=90 h=10pct " ";
footnote1 h=10pct " ";
proc gplot data=foo;
plot z*time=3 / 
 autohref chref=graydd autovref cvref=graydd 
 vaxis=axis3 haxis=axis2 des='' name="plot3";
run;



goptions xpixels=600 ypixels=600;

title1 ls=.75 "XYZ Plot";
title2;
footnote;
proc g3d data=foo;
label X="X Data";
label Y="Y Data";
label Z="Z Data";
 scatter y*x=z / grid tilt=80
  noneedle shape="balloon" size=.4 color=colorvar
  des='' name="plot4";
run;


goptions display;
goptions border;
goptions xpixels=875 ypixels=700;


proc greplay tc=tempcat nofs igout=work.gseg;
  tdef layout des='layout'

   1/llx = 0   lly = 66
     ulx = 0   uly = 100
     urx =31   ury = 100
     lrx =31   lry = 66 

   2/llx = 0   lly = 33
     ulx = 0   uly = 66 
     urx =31   ury = 66 
     lrx =31   lry = 33 

   3/llx = 0   lly = 0 
     ulx = 0   uly = 33 
     urx =31   ury = 33 
     lrx =31   lry = 0  

   4/llx =31   lly = 0 
     ulx =31   uly = 100
     urx =100  ury = 100
     lrx =100  lry = 0  
;

template = layout;
treplay 
 1:plot1  
 2:plot2  4:plot4
 3:plot3  
 des='' name="&name";
run;

quit;
ODS HTML CLOSE;
ODS LISTING;
