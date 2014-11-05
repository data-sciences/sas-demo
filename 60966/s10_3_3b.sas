* S10_3_3b.sas
*
* Adding lines using Annotate;

ods listing close;

ods pdf  style=journal
         file="&path\results\ch10_3_3b.pdf"
         startpage=never;

title1 ;
proc report data=sashelp.prdsale(where=(prodtype='OFFICE')) 
      nowd;
   column region country product,actual dummy totalsales;
   define region     / group;
   define country    / group;
   define product    / across;
   define actual     / analysis sum 
                       format=dollar8. 
                       'Sales';
   define dummy      / computed ' '
                       style(column) = {cellwidth=2pt};
   define totalsales / computed format=dollar10.
                       'Total Sales'; 
   break after region / summarize suppress; 
   rbreak after / summarize;

   compute totalsales;
      totalsales = sum(_c3_, _c4_, _c5_);
   endcomp;
   compute dummy /char length=2;
      dummy=' ';
   endcomp;
   compute after region/style(lines) = {font_size=2pt};
      line ' ' ;
   endcomp;
   run;

* Add the annotate macros to the autocall library;
%annomac

* Build the annotate data set;
data Annolines;
   length function color $8;
   retain xsys ysys '5';

   * Syntax for the LINE macro; 
   %*LINE (x1, y1, x2, y2, color, line_type, size);  
   %line(15,71.6,48.0,71.6,blue,1,10)
   %line(15,82.1,48.0,82.1,red,1,10)
   %line(39.6,69.2,39.6,95.0,green,1,10)
   run;

* Use the annotate data set;
proc gslide anno=annolines;
   run;
   quit;

ods _all_ close;
