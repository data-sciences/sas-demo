* S8_11c.sas
*
* Using CELLWIDTH and RIGHTMARGIN to control number alignment;

options nocenter nodate nonumber;
title;

ods escapechar='~';

ods listing close;
ods pdf style=printer
    file="&path\results\ch8_11c.pdf" notoc startpage=never;

ods pdf text='~nUsing CELLWIDTH and RIGHTMARGIN, Looks Much Better';

proc report data=sashelp.shoes nowd;
  column region stores sales inventory returns;
  define region    / 'Region' group
                     style(column)={cellwidth=25mm};
  define stores    / 'Number of Stores'
                     style(column)={cellwidth=20mm
                                    rightmargin=7mm};
  define sales     / 'Total Sales'
                     style(column)={cellwidth=35mm
                                    rightmargin=7mm};
  define inventory / 'Total Inventory'
                     style(column)={cellwidth=35mm
                                    rightmargin=7mm};
  define returns   / 'Total Returns'
                     style(column)={cellwidth=35mm
                                    rightmargin=7mm};
  run;

ods pdf close;
ods listing;
