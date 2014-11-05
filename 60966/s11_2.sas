* S11_2.sas
*
* A simple table with summary lines;

title1 'Simple Table with Summary Lines';
proc report data=sashelp.class(where=(age in(12,13))) 
            out=out11_2 nowd;
   column age sex n weight height;
   define age    / group;
   define sex    / group 'Gender' format=$6.;
   define n      / 'N' format=2.;
   define weight / analysis mean 'Mean Weight' format=6.1;
   define height / analysis mean 'Mean Height' format=6.2;

   break after age / summarize suppress skip;
   rbreak after    / summarize;
   run;

title2 'Output Data Set';
proc print data=out11_2;
run;
