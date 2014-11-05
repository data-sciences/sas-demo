* E8_4b.sas
*
* Chapter 8 Exercise 4b
*
* Total profit for each year within Product line.
* Automate the program for E8_4a;

options center;
ods listing close;

%macro linked;

* Create a list of the unique years;
proc sql noprint;
   select distinct year
      into :year1 - :year99
         from sashelp.orsales;
   %let yearcnt = &sqlobs;
   quit;

ods html style=default
         path="&path\results"
         body='E8_4b.html';

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
   rbreak after / summarize ;

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

%* Loop through each year to create the detailed report;
%do yr = 1 %to &yearcnt;
   * Sports Detail Report for &&year&yr;
   ods html style=default
            path="&path\results"
            body="Sports&&year&yr...html";

   title2 "Sports Detail for &&year&yr";
   title3 "<a href='E8_4b.html'>Return to Full Report<a>";

   proc report data=sashelp.orsales(where=(product_line='Sports' & year=&&year&yr))
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


%mend linked;

%linked    * Create the linked tables;
