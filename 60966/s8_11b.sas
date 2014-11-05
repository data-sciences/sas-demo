* S8_11b.sas
*
* Using CELLWIDTH and RIGHTMARGIN to control number alignment;

options nocenter nodate nonumber;
title;

ods escapechar='~';

ods listing close;
ods pdf style=printer
        file="&path\results\ch8_11b.pdf"  
        notoc 
        startpage=never;

ods pdf text='~nUsing CELLWIDTH, Numbers are too far to the right';

proc report data=sashelp.shoes nowd;
  column region stores sales inventory returns;
  define region    / 'Region' 
                      group 
                      style(column)={cellwidth=25mm};
  define stores    / 'Number of Stores' 
                      style(column)={cellwidth=20mm};
  define sales     / 'Total Sales' 
                      style(column)={cellwidth=35mm};
  define inventory / 'Total Inventory' 
                      style(column)={cellwidth=35mm};
  define returns   / 'Total Returns' 
                      style(column)={cellwidth=35mm};
run;

ods pdf close;
ods listing;
