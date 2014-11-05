%let name=example06;
filename odsout '.';


data raw_data;                                       
input X Y Z;                                   
datalines;     
-1.0 -1.0   15.5
 -.5 -1.0   18.6
  .0 -1.0   19.6
  .5 -1.0   18.5
 1.0 -1.0   15.8
-1.0  -.5   10.9
 -.5  -.5   14.8
  .0  -.5   16.5
  .5  -.5   14.9
 1.0  -.5   10.9
-1.0   .0    9.6
 -.5   .0   14.0
  .0   .0   15.7
  .5   .0   13.9
 1.0   .0    9.5
-1.0   .5   11.2
 -.5   .5   14.8
  .0   .5   16.5
  .5   .5   14.9
 1.0   .5   11.1
-1.0  1.0   15.8
 -.5  1.0   18.6
  .0  1.0   19.5
  .5  1.0   18.5
 1.0  1.0   15.8
;
run;


proc g3grid data=raw_data out=smoothed;
grid y*x=z / spline smooth=.05
   axis1=-1 to 1 by .1
   axis2=-1 to 1 by .1;
run;

/* 
To create some fake data for 2 surfaces, duplicate the real data a little higher,
and a little lower (+/-8 in the z zdirection).
*/
data smoothed; set smoothed;
label z1='Z' z2='Z';
z1=z-8;
z2=z+8;
run;


goptions device=png;
goptions xpixels=600 ypixels=600;
goptions noborder;
 
ODS LISTING CLOSE;
ODS HTML path=odsout body="&name..htm" (title="SAS/Graph g3d plots") style=minimal;

goptions gunit=pct htitle=4.0 htext=2.5  ftitle="albany amt/bo" ftext="albany amt";

/* 
Generate the 2 plots, and save the grseg in name=, rather than 
displaying it.
Make sure you plan things out so that the axes, labels, titles, etc
are *exactly* the same in the 2 graphs, so they will overlay cleanly!
*/
goptions nodisplay;


/*
If you overlay black anti-aliased text on top of black anti-aliased text,
you can get a 'fuzzy' halo effect.  Therefore make the first graph have
white text, and then make the 2nd plot have black text.
*/
goptions ctext=white;

title ls=1.5 "Overlay Multiple G3D Surfaces, using Greplay";
proc g3d data=smoothed;
 plot y*x=z1 /
 grid zmin=0 zmax=30 xticknum=4 tilt=80 
 ctop=purple cbottom=cx00ff00 des='' name="plot1";
run;

goptions ctext=black;

proc g3d data=smoothed;
 plot y*x=z2 /
 grid  zmin=0 zmax=30 xticknum=4 tilt=80 
 ctop=blue cbottom=red des='' name="plot2";
run;


/* Now, greplay the 2 graphs together in the exact same position. */
goptions display;

proc greplay tc=tempcat nofs igout=work.gseg;
tdef WHOLE des="my template"
        1/llx=0   lly=0
          ulx=0   uly=100
          urx=100 ury=100
          lrx=100  lry=0
          ;
template = whole;
treplay 1:plot1 1:plot2 des='' name="&name";
run;

quit;
ODS HTML CLOSE;
ODS LISTING;
