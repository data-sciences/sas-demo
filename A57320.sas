 /*-------------------------------------------------------------------*/
 /*                   Annotate: Simply the Basics                     */
 /*                       by  Art Carpenter                           */
 /*       Copyright(c) 1999 by SAS Institute Inc., Cary, NC, USA      */
 /*                   SAS Publications order # 57320                  */
 /*                        ISBN 1-58025-578-7                         */
 /*-------------------------------------------------------------------*/
 /*                                                                   */
 /* This material is provided "as is" by SAS Institute Inc.  There    */
 /* are no warranties, expressed or implied, as to merchantability or */
 /* fitness for a particular purpose regarding the materials or code  */
 /* contained herein. The Institute is not responsible for errors     */
 /* in this material as it now exists or will exist, nor does the     */
 /* Institute provide technical support for it.                       */
 /*                                                                   */
 /*-------------------------------------------------------------------*/
 /* Questions or problem reports concerning this material may be      */
 /* addressed to the author:                                          */
 /*                                                                   */
 /* SAS Institute Inc.                                                */
 /* Books by Users                                                    */
 /* Attn:  Art Carpenter                                              */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  sasbbu@sas.com             */
 /* Use this for subject field:                                       */
 /*     Comments for Art Carpenter                                    */
 /*                                                                   */
 /*-------------------------------------------------------------------*/


*************************************************;
* imports.sas
*
* Create the Warbucks import data set for 1945;
*************************************************;

data annodat.imports;
input @1  diamonds
      @6  gold
      @11 silver
      @34 DATE
      @40 co_code $3.
      @44 MONTH
 ;
* Adjust the year value;
* Change from 1988 to 1945;
date = mdy(month(date), day(date), 1945);
format date date7.;
cards;
1.58 1.35 10.96 3.18 54.9  59.5  10241 AZU 1
2.77 1.25 12.73 2.96 60.2  58.5  10272 AZU 2
3.59 1.26 15.5  6.11 62.8  58    10301 AZU 3
3.48 1.05 15.01 4.69 63.4  72.75 10332 AZU 4
4.53 0.95 19.69 6.06 67.6  70    10362 AZU 5
3.8  0.93 17.48 7.68 69    74.75 10393 AZU 6
4.84 0.97 19.32 9.41 76.5  79.5  10423 AZU 7
4.33 1.3  18.06 8.84 74.5  78.75 10454 AZU 8
3.95 1.46 17.36 7.95 72.9  75.75 10485 AZU 9
3.18 1.76 22.81 8.93 70.1  76.25 10515 AZU 10
2.18 1.71 14.22 5.59 60    70.75 10546 AZU 11
1.9  0.99 8.7   2.58 54.6  56.5  10576 AZU 12
0.78 1.36 5     2.78 51.9  .     10241 LIV 1
0.89 1.28 8.13  3.7  56.5  .     10272 LIV 2
1.64 0.98 3.58  3.63 59.1  .     10301 LIV 3
2.89 0.94 3.28  3.28 59    .     10332 LIV 4
2.75 0.89 2.6   2.6  59.9  .     10362 LIV 5
2.56 0.84 2.95  2.71 62.7  .     10393 LIV 6
2.66 0.88 3.74  3.72 65.1  .     10423 LIV 7
2.34 0.88 4.63  3.59 65.41 .     10454 LIV 8
2.7  1.06 4.18  3.9  62.1  .     10485 LIV 9
1.88 1.14 6.03  3.99 59.6  .     10515 LIV 10
1.31 1.08 1.94  2.38 54.5  .     10546 LIV 11
1.28 1.45 4.85  2.38 49.8  .     10576 LIV 12
1.28 2.44 4.34  4.25 50.6  77.75 10241 SFO 1
1.38 2.58 4.6   5.98 54.5  70.75 10272 SFO 2
1.6  2.05 1.56  4.83 56.5  68    10301 SFO 3
2.39 1.76 1.93  4.84 58.1  68    10332 SFO 4
2.35 1.58 1.82  3.5  59.5  69.5  10362 SFO 5
1.79 1.6  1.2   4.11 62.5  70    10393 SFO 6
1.65 1.85 4.25  4.31 65.3  72.75 10423 SFO 7
1.58 1.64 1.84  4.63 65    72.75 10454 SFO 8
1.83 2.01 3.08  5.03 63.1  75.25 10485 SFO 9
1.62 2.14 1.81  4.58 61.4  80.25 10515 SFO 10
1.43 2.02 1.33  4.11 56.5  78    10546 SFO 11
0.9  2.21 8.23  6.33 50.4  74.75 10576 SFO 12
 run;

*************************************************;
* setup.sas;
*
* Setup the libnames etc. for ANNOTATE examples
*************************************************;

***********
* define the libname for path to the graphics drivers;
libname gdevice0 'e:\caltasks\allproj\catalogs';

***********
* define the libname for path to the data sets;
libname annodat 'e:\author\short\carpent1\data';

***********
* define global options;
options nodate nonumber;
GOPTIONS BORDER;

***********
* define the path to the CGM files;
%let pathcgm =e:\author\short\carpent1\figures;


********************************************
* wex3_2_2.sas
*
* Display a text string on a scatterplot.
*
********************************************;

filename fileref "&pathcgm\wex3_2_2.cgm";

goptions reset=all;
goptions border ftext=simplex;
goptions device=cgmof97l gsfmode=replace
         gsfname=fileref;
*goptions device=win;

* Place a label on the value at month 4;
DATA ANNPLT;
     LENGTH FUNCTION STYLE $8 TEXT $5;
     RETAIN XSYS YSYS '2' STYLE 'SIMPLEX'
         FUNCTION 'LABEL' ;
     SIZE=2;
     X=4;     Y=2.5;
     TEXT='HIGH';

PROC GPLOT DATA=annodat.imports ANNO=ANNPLT;
     where co_code='SFO';
     PLOT diamonds * MONTH / vaxis=.5 to 2.5 by .5;
     SYMBOL1 L=1 V=NONE I=JOIN;
     TITLE1 H=2 F=SIMPLEX '1945 Diamond Imports in Millions';
     *footnote h=2 f=simplex j=l 'Figure 3.2.2';
     run;
     quit;
********************************************
* wex3_2_1.sas
*
* Display a text string using PROC GANNO.
*
********************************************;

filename filerefa "&pathcgm\wex3_2_1a.cgm";
filename filerefb "&pathcgm\wex3_2_1b.cgm";

goptions reset=all;
goptions device=cgmof97l gsfmode=replace;
*goptions device=win;

DATA SANDY ;
     LENGTH FUNCTION $8;
     RETAIN FUNCTION 'LABEL' XSYS YSYS '5' X Y 50;
     STYLE='brush';
     SIZE=8;
     TEXT='A Dog Called Sandy';
run;

goptions border;

goptions gsfname=filerefa;
PROC GANNO ANNO=SANDY ;
title 'Placing Text Using GANNO';
footnote j=l h=2 f=simplex 'Figure 3.2.1a';
RUN;

goptions gsfname=filerefb;
PROC gslide ANNO=SANDY ;
title 'Placing Text Using GSLIDE';
footnote j=l h=2 f=simplex 'Figure 3.2.1b';
run;
quit;
********************************************
* wex4_2.sas
*
* Use assignment statements to create the ANNOTATE
* data set.
*
********************************************;

filename fileref "&pathcgm\wex4_2.cgm";

goptions reset=all;
goptions border;
 goptions device=cgmof97l gsfmode=replace
         gsfname=fileref;
*goptions device=win;

* USE PROC GSLIDE AND ANNOTATE TO CREATE A CLASSIFIED AD FOR ANNIE.;
DATA ANNIE;
LENGTH FUNCTION COLOR STYLE $8;
RETAIN FUNCTION 'LABEL' XSYS YSYS '5' X 50;
     COLOR='BLUE';
     STYLE='SCRIPT';
     SIZE=4;
     TEXT='Home Wanted             ';
     Y=75;
     OUTPUT;

     STYLE='DUPLEX';
     SIZE=2;
     TEXT='GIRL - WITHOUT EYES';
     Y=50;
     OUTPUT;

     COLOR='GREEN';
     STYLE='TRIPLEX';
     TEXT='Has Dog / Will Travel';
     Y=30;
     OUTPUT;
run;

PROC GSLIDE ANNO=ANNIE;
     TITLE1 F=SWISS H=3 'Classified Ad';
     *footnote h=2 f=simplex j=l 'Figure 4.2';
     run;
     quit;
********************************************
* wex5_4_2.sas
*
* Connect the maximum value to a label with a line.
*
********************************************;

filename fileref "&pathcgm\wex5_4_2.cgm";

goptions reset=all;
goptions border htext=2 ftext=simplex;
 goptions device=cgmof97l gsfmode=replace
         gsfname=fileref;
*goptions device=win targetdevice=cgmof97l;

* Create the label using ANNOATATE;
data spring (keep=xsys ysys style function size line
                  x y text position);
   length function $8 text $6;
   retain xsys '2' ysys '5' line 1
          position 'E';

   * Draw the arrows;
   * Locate the left side;
   function = 'symbol';
   x=3; y= 6;
   size=2;
   style = 'marker';
   text='G';
   output;
   * Locate the right side;
   x = 6;
   output;

   * Prep to do the line;
   function = 'move';
   x=3; y=3.6;
   output;

   * Draw the line;
   function = 'draw';
   x=6;  size=3;
   output;

   * Insert a label;
   function = 'label';
   x=4.5; y= 5;
   size=2;
   style = 'brush';
   text='Spring';
   output;
run;

* ANNOTATE and GPLOT use separate data sets;
proc gplot data=annodat.imports(where=(co_code='SFO'))
           anno=spring;
   plot diamonds * month;
   symbol1 l=1 v=dot i=join;
   title1 h=2 'Diamond Imports From SFO in 1945';
   *footnote h=2 f=simplex j=l 'Figure 5.4.2';
   footnote1 ' ';
   label month = '    Month';
run;
quit;
footnote1;
********************************************
* wex3_3.sas
*
* Draw a picture using MOVE and DRAW.
*
********************************************;

filename fileref "&pathcgm\wex3_3.cgm";

goptions reset=all;
goptions border;
goptions device=cgmof97l gsfmode=replace
         gsfname=fileref;

* Create the annotate data set DIAMOND;
DATA DIAMOND;
     LENGTH FUNCTION $8;
     * Use the percentages of the display area for coordinates;
     RETAIN XSYS YSYS '5' LINE 1;
     * Move the pen to the far left point;
     function='MOVE'; x=20; y=60; output;
     * Trace the outline of the diamond;
     function='DRAW'; x=50; y=30; output;
     function='DRAW'; x=80; y=60; output;
     function='DRAW'; x=70; y=70; output;
     function='DRAW'; x=30; y=70; output;
     function='DRAW'; x=20; y=60; output;
     function='DRAW'; x=80; y=60; output;
     * Move the pen to start drawing the facets;
     function='MOVE'; x=30; y=70; output;
     * Draw upper facets;
     function='DRAW'; x=40; y=60; output;
     function='DRAW'; x=50; y=70; output;
     function='DRAW'; x=60; y=60; output;
     function='DRAW'; x=70; y=70; output;
     * Draw lower facets;
     function='MOVE'; x=40; y=60; output;
     function='DRAW'; x=50; y=30; output;
     function='DRAW'; x=60; y=60; output;
run;

PROC GSLIDE ANNO=DIAMOND;
     TITLE1 H=2 F=SIMPLEX "Warbuck's Diamond";
     title2 H=1.5 f=simplex 'Using MOVE and DRAW';
     *footnote h=2 f=simplex j=l 'Figure 3.3';
     run;
     quit;
********************************************
* wex2_4.sas
*
* Show the areas controlled by XSYS and YSYS.
*
********************************************;

filename filerefa "&pathcgm\wex2_4a.cgm";
filename filerefb "&pathcgm\wex2_4b.cgm";
filename filerefc "&pathcgm\wex2_4c.cgm";

goptions reset=all border;
goptions device=cgmof97l gsfmode=replace;
*goptions device=win;

* Calculate the average imports for each date;
proc sort data=annodat.imports out=dia1;
by date;
where date le '15jun45'd;
run;

proc means data=dia1 noprint;
by date;
var diamonds;
output out=dia2 mean=mean;
run;

***************************************************;
* Create DATA AREA figure;
data figa;
retain xsys ysys '2';
function='move'; x='15jan45'd; y=0;
                 output;
function='bar '; x='15jun45'd; y=3;
                 style='solid';
                 color='graydd';
                 output;
run;

goptions gsfname=filerefa;
proc gplot data=dia2 anno=figa;
plot mean*date / haxis = '15jan45'd to '15jun45'd by month
                 vaxis = 0 to 3;
title1 h=2 f=swiss 'Data Area';
title2 h=1.8 f=simplex "XSYS and YSYS Both Equal '2'";
title3 h=1.8 f=simplex a=90 'Mean Diamond Imports';
title4 h=1.8 f=simplex a=-90 'Title on Right side';
*footnote1 j=l h=2 f=simplex 'Figure 2.4a';
label mean = 'Millions of Dollars'
      date = 'Import Date';
run;
***************************************************;
* Create GRAPHICS OUTPUT AREA figure;
goptions gsfname=filerefb;

data figb;
retain xsys ysys '3';
function='move'; x=0; y=0;
                 output;
function='bar '; x=100; y=100;
                 style='solid';
                 color='graydd';
                 output;
run;

proc gplot data=dia2 anno=figb;
plot mean*date / haxis = '15jan45'd to '15jun45'd by month
                 vaxis = 0 to 3;
title1 h=2 f=swiss 'Graphics Output Area';
title2 h=1.8 f=simplex "XSYS and YSYS Both Equal '3'";
title3 h=1.8 f=simplex a=90 'Mean Diamond Imports';
title4 h=1.8 f=simplex a=-90 'Title on Right side';
*footnote1 j=l h=2 f=simplex 'Figure 2.4b';
label mean = 'Millions of Dollars'
      date = 'Import Date';
run;

***************************************************;
* Create PROCEDURE OUTPUT AREA figure;
goptions gsfname=filerefc;

data figc;
retain xsys ysys '5';
function='move'; x=0; y=0;
                 output;
function='bar '; x=100; y=100;
                 style='solid';
                 color='graydd';
                 output;
run;

proc gplot data=dia2 anno=figc;
plot mean*date / haxis = '15jan45'd to '15jun45'd by month
                 vaxis = 0 to 3;
title1 h=2 f=swiss 'Procedure Output Area';
title2 h=1.8 f=simplex "XSYS and YSYS Both Equal '5'";
title3 h=1.8 f=simplex a=90 'Mean Diamond Imports';
title4 h=1.8 f=simplex a=-90 'Title on Right side';
*footnote1 j=l h=2 f=simplex 'Figure 2.4c';
label mean = 'Millions of Dollars'
      date = 'Import Date';
run;
quit;
********************************************
* wex6_2.sas
*
* Using ANNOTATE macros to replace assignment
* statements.
*
********************************************;

filename fileref "&pathcgm\wex6_2.cgm";

options mprint symbolgen;
goptions reset=all;
goptions border;
 goptions device=cgmof97l gsfmode=replace
         gsfname=fileref;
*goptions device=win;

%annomac

* USE PROC GSLIDE AND ANNOTATE TO CREATE A CLASSIFIED AD FOR ANNIE.;
DATA ANNIE;
     LENGTH FUNCTION COLOR STYLE $8;

     *RETAIN XSYS YSYS '5';
     %system(5,5)

     *COLOR='BLUE';
     *STYLE='SCRIPT';
     *SIZE=4;
     *TEXT='Home Wanted             ';
     *Y=75;
     *OUTPUT;
     %label(50,75,'Home Wanted             ',blue,0,0,4,script);

     *SIZE=2;
     *Y=50;
     *STYLE='DUPLEX';
     *TEXT='GIRL - WITHOUT EYES';
     *OUTPUT;
     %label(50,50,'GIRL - WITHOUT EYES',*,0,0,2,duplex);

     *Y=30;
     *STYLE='TRIPLEX';
     *COLOR='GREEN';
     *TEXT='Has Dog / Will Travel';
     *OUTPUT;
     %label(50,30,'Has Dog / Will Travel',green,0,0,2,triplex);
run;

PROC GSLIDE ANNO=ANNIE;
     TITLE1 F=SWISS H=3 'Classified Ad';
     *footnote h=2 f=simplex j=l 'Figure 6.2';
run;
quit;
********************************************
* wex5_6.sas
*
* Add labels to a map.
*
********************************************;

filename fileref "&pathcgm\wex5_6.cgm";

goptions reset=all;
goptions border htext=2 ftext=simplex;
 goptions device=cgmof97l gsfmode=replace
         gsfname=fileref;
*goptions device=win targetdevice=cgmof97l;

* Create a list of states of interest;
data region;
input stcode $2. state 3. outlets 3.;

label stcode = 'State code'
      state  = 'state number';
datalines;
AZ 4   6  ARIZONA
CA 6  12  CALIFORNIA
CO 8   7  COLORADO
NV 32  5  NEVADA
UT 49  3  UTAH
run;

* Select specific states boundaries;
data usmap(keep=state segment x y);
   merge maps.us region(keep=state in=inreg);
   by state;
   if inreg;
   run;

* Select specific state center points;
data center(keep=state x y stcode outlets);
   merge maps.uscenter
         region(keep=state stcode outlets
                in=inreg);
   by state;
   if inreg;
   run;

* Select coordinates of the capital cities for each state;
data capital(keep=state city x y);
   merge maps.uscity (where=(capital='Y'))
         region(keep=state in=inreg);
   by state;
   if inreg;
   run;

* Create the ANNOTATE data set;
data anno (keep=xsys ysys function size text when
                style position x y);
   set center(in=incenter)
       capital(in=incapitl);
   length function style $8 text $15;
   retain xsys ysys '2' when 'a' size 2;

   position = '5';
   function = 'label';

   * Label for state center;
   if incenter then do;
      style = 'simplex';
      text = stcode;
      output;
      text = left(put(outlets, 3.));
      position = '8';
      style = 'centb';
      output;
    end;

   * Label for the state capital;
   if incapitl then do;
      * Place the city name;
      if state in(8,32) then position='2';
      else position = '8';
      style = 'simplex';
      text = city;
      output;

      * Place the city symbol;
      position = '5';
      text = 'M';
      style = 'special';
      output;
   end;
   run;

proc gmap map=usmap
          data=region;
   id state;
   choro outlets / coutline=black
                  anno=anno
                  nolegend
                  discrete;
   pattern1 v=empty  c=black r=6;

   title1 'US Southwest';
   title2 'Warbucks Industries';
   title3 'Number of Diamond Resell Locations by State';
   *footnote h=2 f=simplex j=l 'Figure 5.6';
   run;
   quit;
********************************************
* wex5_5_3b.sas
*
* Add labels over the bars of a histogram.
*
********************************************;

filename fileref "&pathcgm\wex5_5_3b.cgm";

goptions reset=all;
goptions border htext=2 ftext=simplex;
 goptions device=cgmof97l gsfmode=replace
         gsfname=fileref;
*goptions device=win targetdevice=cgmof97l;

proc sort data=annodat.imports
          out=imports;
   by co_code month;
   where month in(6 7 8);
   run;

* Determine the average imports for each month;
proc summary data=imports;
   by co_code month;
   var diamonds;
   output out=mean mean=mean;
   run;

* Create the axis  using ANNOTATE;
data anno (keep=xsys ysys function size text angle
                style position
                midpoint group y);
   set mean;
   length function $8;
   retain xsys ysys '2'  position '3' angle 55
          function 'label'
          size 2 style 'simplex';

   rename co_code=midpoint month=group;
   y = mean;
   text = left(put(mean,5.2));
run;

axis1 order = (0 to 5 by 1)
      label = (a=90 '$ in Millions');
axis2 label = ('Export Country');
axis3 label = ('Month');

pattern1 v=empty c=red;
pattern2 v=x3    c=red;
pattern3 v=solid c=red;

proc gchart data=mean;
    vbar co_code  / type=mean sumvar=mean
                    anno=anno discrete
                    group=month
                    patternid=midpoint
                    raxis=axis1 maxis=axis2 gaxis=axis3;
    TITLE1 'Summer Diamond Imports for 1945';
   *footnote h=2 f=simplex j=l 'Figure 5.5.3b';
    run;
    quit;
********************************************
* wex5_5_3a.sas
*
* Add labels over the bars of a histogram.
*
********************************************;

filename fileref "&pathcgm\wex5_5_3a.cgm";

goptions reset=all;
goptions border htext=2 ftext=simplex;
 goptions device=cgmof97l gsfmode=replace
         gsfname=fileref;
*goptions device=win targetdevice=cgmof97l;

proc sort data=annodat.imports
          out=imports;
   by month;
   run;

* Determine the average imports for each month;
proc summary data=imports;
   by month;
   var diamonds;
   output out=mean mean=mean;
   run;

* Create the axis  using ANNOTATE;
data anno (keep=xsys ysys function size text angle
                style position
                midpoint y);
   set mean;
   length function $8;
   retain xsys ysys '2'  position '3' angle 55
          function 'label'
          size 2 style 'simplex';

   rename month=midpoint;
   y = mean;
   text = left(put(mean,5.2));
run;

axis1 order = (0 to 4 by 1)
      label = (a=90 '$ in Millions');
axis2 label = ('Month');

pattern1 color=red value=empty;

proc gchart data=mean;
    vbar month  / type=mean sumvar=mean
                    anno=anno discrete
                    raxis=axis1 maxis=axis2;
    TITLE1 'Average Diamond Imports for 1945';
    *footnote h=2 f=simplex j=l 'Figure 5.5.3a';
    run;
    quit;
********************************************
* wex5_5_2.sas
*
* Add error bars to a histogram.
*
********************************************;

filename fileref "&pathcgm\wex5_5_2.cgm";

goptions reset=all;
goptions border htext=2 ftext=simplex;
goptions device=cgmof97l gsfmode=replace
         gsfname=fileref;
*goptions device=win targetdevice=cgmof97l;

* Determine the average imports for each country;
proc summary data=annodat.imports;
   by co_code;
   var diamonds;
   output out=mean mean=average std=std n=n;
   run;

* Create the axis  using ANNOTATE;
data bars (keep=xsys ysys function size line
                midpoint y when);
   set mean;
   length function $8;
   retain xsys ysys '2' when 'a' line 1 size 3;

   * Prep to do the line;
   function = 'move';
   midpoint=co_code; y=average;
   output;

   * Draw the line below the bar;
   function = 'draw';
   y=average - 2*std;
   output;

   * Draw the line above the bar;
   function = 'draw';
   y=average + 2*std;
   output;
run;

axis1 order = (0 to 6 by 1)
      label = (a=90 '$ in Millions');

* ANNOTATE and GPLOT use separate data sets;
proc gchart data=mean
           anno=bars;
   vbar co_code / sumvar=average type=mean
                  raxis = axis1;
   title1 h=2 'Average Diamond Imports in 1945';
   *footnote h=2 f=simplex j=l 'Figure 5.5.2';
run;
quit;
********************************************
* wex5_4_3.sas
*
* Add a second horizontal AXIS.
*
********************************************;

filename fileref "&pathcgm\wex5_4_3.cgm";

goptions reset=all;
goptions border htext=2 ftext=simplex;
 goptions device=cgmof97l gsfmode=replace
         gsfname=fileref;
*goptions device=win targetdevice=cgmof97l;

* Create the axis  using ANNOTATE;
data spring (keep=xsys ysys style function size line
                  x y text position);
   length function $8 text $6;
   retain ysys '5' line 1 size 2
          position 'E';

   * Prep to do the line;
   function = 'move';
   xsys = '1'; ysys= '1';
   x=0; y=100;
   output;

   * Draw the line;
   function = 'draw';
   x=100;
   output;

   * Add tickmarks
   xsys='2';
   style = 'simplex';
   do x = 1 to 12;
      xsys = '2'; ysys='1';
      y=100;
      function='symbol';
      text = '|';
      output;
      ysys = '7';
      y = 4;
      text = left(put(x,2.));
      output;
   end;

run;

* ANNOTATE and GPLOT use separate data sets;
proc gplot data=annodat.imports(where=(co_code='SFO'))
           anno=spring;
   plot diamonds * month;
   symbol1 l=1 v=dot i=join;
   title1 h=2 'Diamond Imports From SFO in 1945';
   *footnote h=2 f=simplex j=l 'Figure 5.4.3';
   label month = 'Month';
run;
quit;
********************************************
* wex5_4_1b.sas
*
* Connect the maximum value to a label with a line.
*
********************************************;

filename fileref "&pathcgm\wex5_4_1b.cgm";

goptions reset=all;
goptions border htext=2 ftext=simplex;
 goptions device=cgmof97l gsfmode=replace
         gsfname=fileref;
*goptions device=win;

* Determine the month with the maximum # of imports;
proc summary data=annodat.imports(where=( co_code='SFO'));
   var diamonds;
   output out=stats max=y
                    maxid(diamonds(month))=x;
   run;

* Create the label using ANNOTATE;
data dianno (keep=xsys ysys style function size line
                  x y text position);
   set stats;
   length function $8 text $5;
   retain xsys ysys '2' line 33
          style 'simplex' position 'c';
   * Specify the start point for the line;
   function = 'move'; output;
   * Draw to edge of plot;
   function = 'draw';
      size=2; x=11;   output;
   * Add the label;
   function='label';
   text=put(y,5.2);
   output;
run;

* ANNOTATE and GPLOT use separate data sets;
proc gplot data=annodat.imports(where=(co_code='SFO'))
           anno=dianno;
   plot diamonds * month;
   symbol1 l=1 v=dot i=join;
   title1 h=2 'Diamond Imports From SFO in 1945';
   *footnote h=2 f=simplex j=l 'Figure 5.4.1b';
run;
quit;
********************************************
* wex5_4_1a.sas
*
* Create the ANNOTATE data set based on the data
* that is to be plotted.
*
********************************************;

filename fileref "&pathcgm\wex5_4_1a.cgm";

goptions reset=all;
goptions border htext=2 ftext=simplex;
 goptions device=cgmof97l gsfmode=replace
         gsfname=fileref;
*goptions device=win;

* label all months with imports exceeding $2 million;
data imports(keep=diamonds month)
     dianno (keep=xsys ysys style function position size
                  angle rotate x y text);
   set annodat.imports(keep=co_code diamonds month);
   length function $8 text $5;
   retain xsys ysys '2'
          style 'simplex' size 2
          angle 20 rotate -20
          function 'label' position '3';
   where co_code='SFO';
   output imports;
   if diamonds ge 2 then do;
      * Conditional observation for ANNOTATE;
      x=month;
      y=diamonds;
      text=put(diamonds,5.2);
      output dianno;
   end;
run;

* ANNOTATE and GPLOT use separate data sets;
proc gplot data=imports anno=dianno;
   plot diamonds * month;
   symbol1 l=1 v=dot i=join;
   title1 h=2 'Diamond Imports From SFO in 1945';
   *footnote h=2 f=simplex j=l 'Figure 5.4.1a';
run;
quit;
********************************************
* wex5_3_1.sas
*
* Use the POSITION variable to display labels.
*
********************************************;

filename fileref "&pathcgm\wex5_3_1.cgm";

goptions reset=all;
goptions border;
goptions device=cgmof97l gsfmode=replace
         gsfname=fileref;


* DEMONSTRATE THE POSITION VARIABLE WITH
* FUNCTION=LABEL;
DATA PLTDAT;
     LENGTH POS $1;
     INPUT POS $ X Y;
     CARDS;
     1  1  1
     2  2  2
     3  3  3
     4  4  4
     5  5  5
     6  6  6
     7  7  7
     8  8  8
     9  9  9
     A  10 10
     B  11 11
     C  12 12
     D  13 13
     E  14 14
     F  15 15
     RUN;

DATA ANNDAT;
     SET PLTDAT;
     LENGTH FUNCTION $8 TEXT $15;
     RETAIN STYLE 'SIMPLEX' XSYS YSYS '2'
         FUNCTION 'LABEL' SIZE 1.5;
     TEXT = 'POS=' || POS;
     POSITION = POS;
     RUN;

PROC GPLOT DATA=PLTDAT ANNO=ANNDAT;
     PLOT Y * X;
     SYMBOL1 v=dot c=black h=2;
     TITLE1 H=2 F=SIMPLEX 'LABEL POSITIONS';
     *footnote h=2 f=simplex j=l 'Figure 5.3.1';
     run;
     quit;
********************************************
* wex4_4_2.sas
*
* Create the ANNOTATE data set based on the data
* that is to be plotted.
*
********************************************;

filename fileref "&pathcgm\wex4_4_2.cgm";

goptions reset=all;
goptions border htext=2 ftext=simplex;
 goptions device=cgmof97l gsfmode=replace
         gsfname=fileref;
*goptions device=win;

* label all months with imports exceeding $2 million;
data imports(keep=diamonds month)
     dianno (keep=xsys ysys style function position size
                  x y text);
   set annodat.imports(keep=co_code diamonds month);
   length function $8 text $5;
   retain xsys ysys '2' style 'simplex'
          function 'label' position '3' size 1.5;
   where co_code='SFO';
   output imports;
   if diamonds ge 2 then do;
      * Conditional observation for ANNOTATE;
      x=month;
      y=diamonds;
      text=put(diamonds,5.2);
      output dianno;
   end;
run;

* ANNOTATE and GPLOT use separate data sets;
proc gplot data=imports anno=dianno;
   plot diamonds * month;
   symbol1 l=1 v=dot i=join;
   title1 h=2 'Diamond Imports From SFO in 1945';
   *footnote h=2 f=simplex j=l 'Figure 4.4.2';
run;
quit;
********************************************
* wex4_4_1.sas
*
* Create the ANNOTATE data set based on the data
* that is to be plotted.
*
********************************************;

filename fileref "&pathcgm\wex4_4_1.cgm";

goptions reset=all;
goptions border htext=2 ftext=simplex;
 goptions device=cgmof97l gsfmode=replace
         gsfname=fileref;
*goptions device=win;

* label all months with imports exceeding $2 million;
data imports;
   set annodat.imports;
   length function $8 text $5;
   retain xsys ysys '2' style 'simplex'
          function 'label' position '3' size 1.5;
   where co_code='SFO';
   if diamonds ge 2 then do;
      x=month;
      y=diamonds;
      text=put(diamonds,5.2);
   end;
run;

* ANNOTATE and GPLOT use the same data set;
proc gplot data=imports anno=imports;
   plot diamonds * month;
   symbol1 l=1 v=dot i=join;
   title1 h=2 'Diamond Imports From SFO in 1945';
   *footnote h=2 f=simplex j=l 'Figure 4.4.1';
run;
quit;
********************************************
* wex4_3.sas
*
* Create the ANNOTATE data set from a flat
* control file.
*
********************************************;

filename fileref "&pathcgm\wex4_3.cgm";

goptions reset=all;
goptions border;
 goptions device=cgmof97l gsfmode=replace
         gsfname=fileref;
*goptions device=win;

* USE THE CARDS STATEMENT TO PRESENT THE DATA;
DATA DIAMOND;
     LENGTH FUNCTION $8;
     RETAIN XSYS YSYS '5' LINE 1;
     INPUT FUNCTION X Y;
     X = X*10 + 20;
     Y = Y*10 + 30;
     CARDS;
     MOVE 0 3
     DRAW 3 0
     DRAW 6 3
     DRAW 5 4
     DRAW 1 4
     DRAW 0 3
     DRAW 6 3
     MOVE 1 4
     DRAW 2 3
     DRAW 3 4
     DRAW 4 3
     DRAW 5 4
     MOVE 2 3
     DRAW 3 0
     DRAW 4 3
     ;
     run;

PROC GSLIDE ANNO=DIAMOND;
     TITLE1 H=2 "Daddy Warbuck's Diamond";
     *footnote h=2 f=simplex j=l 'Figure 4.3';
     run;
     quit;
