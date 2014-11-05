* E8_4a.sas
*
* Chapter 8 Exercise 4a
*
* Total profit for each year within Product line.;

options center;
ods listing close;

ods html style=default
         path="&path\results"
         body='E8_4a.html';

title1 'Total profit per year';
title2 'Separated by Product Line';
title3 'Links to Sports Detail';

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

   compute before year;
      yr = year;
   endcomp;
   compute product_line;
      * For SPORTS create a link;
      if product_line = 'Sports' then do;
         link = 'Sports'||trim(left(put(yr,4.)))||'.html';
         call define(_col_, 'url', link);
      end;
   endcomp;
   run;

ods _all_ close;

* Sports Detail Report for 1999;
ods html style=default
         path="&path\results"
         body='Sports1999.html';

title2 'Sports Detail for 1999';
title3 "<a href='E8_4a.html'>Return to Full Report<a>";

proc report data=sashelp.orsales(where=(product_line='Sports' & year=1999))
             nowd split='*';
   column product_category profit;
   define product_category 
                 / group 
                   'Product*Category';
   define profit / analysis 
                   sum format=dollar15.2
                   'Annual*Profit';
   rbreak after / summarize;
   run;

ods _all_ close;


* Sports Detail Report for 2000;
ods html style=default
         path="&path\results"
         body='Sports2000.html';

title2 'Sports Detail for 2000';
title3 "<a href='E8_4a.html'>Return to Full Report<a>";

proc report data=sashelp.orsales(where=(product_line='Sports' & year=2000))
             nowd split='*';
   column product_category profit;
   define product_category 
                 / group 
                   'Product*Category';
   define profit / analysis 
                   sum format=dollar15.2
                   'Annual*Profit';
   rbreak after / summarize ;
   run;

ods _all_ close;


* Sports Detail Report for 2001;
ods html style=default
         path="&path\results"
         body='Sports2001.html';

title2 'Sports Detail for 2001';
title3 "<a href='E8_4a.html'>Return to Full Report<a>";

proc report data=sashelp.orsales(where=(product_line='Sports' & year=2001))
             nowd split='*';
   column product_category profit;
   define product_category 
                 / group 
                   'Product*Category';
   define profit / analysis 
                   sum format=dollar15.2
                   'Annual*Profit';
   rbreak after / summarize ;
   run;

ods _all_ close;


* Sports Detail Report for 2002;
ods html style=default
         path="&path\results"
         body='Sports2002.html';

title2 'Sports Detail for 2002';
title3 "<a href='E8_4a.html'>Return to Full Report<a>";

proc report data=sashelp.orsales(where=(product_line='Sports' & year=2002))
             nowd split='*';
   column product_category profit;
   define product_category 
                 / group 
                   'Product*Category';
   define profit / analysis 
                   sum format=dollar15.2
                   'Annual*Profit';
   rbreak after / summarize ;
   run;

ods _all_ close;

