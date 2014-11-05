* E8_3b.sas
*
* Chapter 8 Exercise 3b
* 
*
* Traffic lighting using call define;

proc format;
   value lowval
      low - <1000000 = 'yellow';
   run;

options center;
ods listing close;

ods html style=default
         path="&path\results"
         body='E8_3b.html';

title1 'Total profit per year';
title2 'Separated by Product Line';
title3 'Profit Summaries';
proc report data=sashelp.orsales nowd split='*';
   column year product_line profit;
   define year   / group;
   define product_line 
                 / group 
                   'Product*Groups';
   define profit / analysis 
                   sum format=dollar15.2
                   'Annual*Profit';
   break after year / summarize suppress skip;
   rbreak after / summarize;

   compute profit;
      call define(_col_,'style','style={background=lowval.}');
   endcomp;
   run;

ods _all_ close;
