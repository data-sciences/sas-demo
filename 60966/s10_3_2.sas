* S10_3_2.sas
*
* combining REPORT tables and graphics;

ods listing;
goptions reset=all;

filename textrpt "&path/results/ch10_3_2.txt";

proc printto print=textrpt new;
   run;

title1;
proc report data=sashelp.class nowd;
   column sex age height weight;
   define sex    / group 'Gender' format=$6.;
   define age    / group "Age" width=3;
   define height / mean 'Height' format=6.1;
   define weight / mean 'Weight' format=6.2;
   break after sex / skip summarize suppress;
   run;

proc printto;
   run;


* Clear the GSEG catalog from the work library;
proc datasets library=work mt=cat nolist;
   delete gseg;
   quit;

goptions ftext=simplexu htext=1.8;

* Import the table into SAS/GRAPH;
proc gprint fileref=textrpt name='classrpt';
   run;


goptions ftext=swiss htext=2;

* create the TITLE;
proc gslide name='Slide';  
   title1 'Interfacing with REPORT';
   title2 h=1.5 'Rendering a Report with SAS/GRAPH';
   run;

symbol1 c=red  value=dot    i=stdm2j l=33;
symbol2 c=blue value=square i=stdm2j l=1;

data class;
   set sashelp.class;
   * Separate gender in the plots;
   age = age + (sex='F')*.05 + (sex='M')*-.05;
   run;

* Create a scatter plot;
proc gplot data=class;
   plot height*age=sex/name='height';
   title1 'Height';
   run;
   plot weight*age=sex/name='weight';
   title1 'Weight';
   run;
   symbol1 c=red  value=dot    i=none;
   symbol2 c=blue value=square i=none;
   plot weight*height=sex/name='w_h';
   title1 'Weight vs Height';
   run;
   quit;

filename combined "&path\results\ch10_3_2.gif";
* Define the graphics device;
goptions dev=gif
         gsfname=combined;

* Build a template and replay the graphs and table;
proc greplay igout=gseg nofs tc=gtempl8;
   tdef three_t
      1/ ulx=0  uly=100 urx=100 ury=100
         llx=0  lly=  0 lrx=100 lry= 0
      2/ ulx=0  uly=90  urx=50  ury=90
         llx=0  lly=45  lrx=50  lry=45
      3/ ulx=50 uly=90  urx=100 ury=90
         llx=50 lly=45  lrx=100 lry=45
      4/ ulx=0  uly=40  urx=50  ury=40
         llx=0  lly= 0  lrx=50  lry= 0
      5/ ulx=50 uly=40  urx=100 ury=40
         llx=50 lly= 0  lrx=100 lry= 0;
   template three_t;
   treplay 1:Slide 
           2:height 
           3:w_h 
           4:weight 
           5:classrpt;
   run;
   quit;
