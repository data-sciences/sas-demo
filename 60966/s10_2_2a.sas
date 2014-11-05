* S10_2_2a.sas
*
* Resolution of macro variables;

ods listing close;
ods html style=default
         path="&path\results"
         body="ch10_2_2a.html";

%let bcolor = blue;

title1 'Automation of Report Processes';
title2 'Resolution of Macro Variables';
title3 'Using double quotes';
proc report data=sashelp.class nowd;
   columns age sex,weight;

   define age    / group 'Age';
   define sex    / across 'Clinic Number';
   define weight / analysis mean 'Mean';

   rbreak after   / summarize suppress;

   compute weight;
      attrib = "style={background=&bcolor}";
      call define(_row_,'style',attrib);
   endcomp;
   compute after;
      * Show that &bcolor is resolved;
      line attrib $62.;
   endcomp;
   run;
ods _all_ close;
