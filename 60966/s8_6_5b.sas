* S8_6_5b.sas
*
* Inserting non-breaking spaces;

ods listing close;
ods html style=default
    file="&path\results\ch8_6_5b.html";
ods pdf style=printer
    file="&path\results\ch8_6_5b.pdf";
ods rtf style=rtf
    file="&path\results\ch8_6_5b.rtf"
    bodytitle;

proc format;
  value $NewReg
    'Asia' = '~_~_~_~_~_~_~_~_~_~_~_~_Asia'
    'United States' = 'United~_~_~_~_~_States';
  run;

ods escapechar='~';

title 'Total Sales';
proc report data=sashelp.shoes nowd;
  column region sales;
  define region / group 'Region~_~_~_~_Name' 
                  format=$NewReg.;
  define sales  / sum 'Sales';
  run;

ods _all_ close;
ods listing;
