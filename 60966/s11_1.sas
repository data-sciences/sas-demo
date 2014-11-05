* S11_1.sas
*
* A simple table;

proc report data=sashelp.class(where=(age in(12,13))) 
            out=out11_1 nowd;
   column age sex n weight height;
   define age    / group;
   define sex    / group 'Gender' format=$6.;
   define n      / 'N' format=2.;
   define weight / analysis mean 'Mean Weight' format=6.1;
   define height / analysis mean 'Mean Height' format=6.2;
   run;

proc print data=out11_1;
run;
