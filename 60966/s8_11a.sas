* S8_11a.sas
*
* Using CELLWIDTH and RIGHTMARGIN to control number alignment;

options nocenter nodate nonumber;
title;

ods escapechar='~';

ods listing close;
ods pdf style=printer
        file="&path\results\ch8_11a.pdf" 
        notoc 
        startpage=never;

ods pdf text='~nDefault';

proc report data=sashelp.shoes nowd;
  column region stores sales inventory returns;
  define region    / 'Region' group;
  define stores    / 'Number of Stores';
  define sales     / 'Total Sales';
  define inventory / 'Total Inventory';
  define returns   / 'Total Returns';
run;

ods pdf close;
ods listing;
