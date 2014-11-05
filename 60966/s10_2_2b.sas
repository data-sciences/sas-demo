* S10_2_2b.sas
*
* Resolution of macro variables;

ods listing close;
ods html style=default
         path="&path\results"
         body="ch10_2_2b.html";

%let bcolor = red;

title1 'Automation of Report Processes';
title2 'Resolution of Macro Variables';
title3 'Using single quotes';
proc report data=sashelp.class nowd;
   columns age sex,weight;

   define age    / group 'Age';
   define sex    / across 'Clinic Number';
   define weight / analysis mean 'Mean';

   rbreak after   / summarize suppress;

   compute weight;
      attrib = 'style={background=&bcolor}';
      call define(_row_,'style',attrib);
   endcomp;
   compute after;
      * Show that &bcolor is unresolved in ATTRIB;
      line attrib $62.;
   endcomp;
   run;
ods _all_ close;
