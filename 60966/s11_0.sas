* S11_0.sas
*
* The data used in this chapter;


title1 'Student Weight and Height';
proc print data=sashelp.class
         (where=(age in(12,13))
          keep=age sex weight height);
   var age sex weight height;
   run;
