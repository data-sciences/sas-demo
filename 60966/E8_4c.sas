* E8_4c.sas
*
* Chapter 8 Exercise 4c
*
* Total profit for each year within each product.
* Automate the selection of both years and product lines.;

options center;
ods listing close;

%macro linked;

%local yearcnt prodcnt 
       y p;


* Create a list of the unique years;
proc sql noprint;
   select distinct year
      into :year1 - :year99
         from sashelp.orsales;
   %let yearcnt = &sqlobs;
   quit;

* Create a list of the unique products;
* Save both the 
* full product name - &&prod&p
* short name for file names - &&pname&p
*  we notice that the first 6 characters in the name 
*  can be used for file naming - these are stored separately;
proc sql noprint;
   select distinct product_line, substr(product_line,1,6)
      into :prod1  - :prod99,
           :pname1 - :pname99
         from sashelp.orsales;
   %let prodcnt = &sqlobs;
   quit;

ods html style=default
         path="&path\results"
         body='E8_4c.html';

title1 'Total profit per year';
title2 'Separated by Product Line';

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
   rbreak after / summarize ;

   compute before year;
      yr = year;
   endcomp;
   compute product_line;
      * Create a link for this product line X year combination;
      link = "E8_4c_"||substr(product_line,1,6)||trim(left(put(yr,4.)))||'.html';
      call define(_col_, 'url', link);
   endcomp;
   run;

ods _all_ close;

%* Loop through each year to create the detailed report;
%do y = 1 %to &yearcnt;
   %* Loop through each product to create the detailed report;
   %do p = 1 %to &prodcnt;
      * &&prod&p Detail Report for &&year&y;
      ods html style=default
               path="&path\results"
               body="E8_4c_&&pname&p..&&year&y...html";

      title2 "&&prod&p Detail for &&year&y";
      title3 "<a href='E8_4c.html'>Return to Full Report<a>";

      proc report data=sashelp.orsales(where=(product_line="&&prod&p" & year=&&year&y))
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
   %end;
%end;
*/ *;

%mend linked;

%linked    * Create the linked tables;
