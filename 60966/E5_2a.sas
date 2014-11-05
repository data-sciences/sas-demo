* E5_2a.sas
*
* Chapter 5 Exercise 2
*
* Total profit and percentage for each Product line within year;
* With annual summary;

proc format;
   value $sequip
      'Sports' = 'Sports Equipment';
   run;

title1 'Total profit per year';
title2 'Separated by Product Line';
proc report data=sashelp.orsales nowd split='*';
   column year product_line profit percent;
   define year   / group;
   define product_line 
                 / group 
                   f=$sequip.
                   'Product*Groups';
   define profit / analysis 
                   sum format=dollar15.2
                   'Annual*Profit';
   define percent/ computed 'Product*Percentage'
                   format=percent10.2;

   break after year/ summarize suppress skip;

   compute before year;
      total = profit.sum;
   endcomp;
   compute percent;
      percent = profit.sum/total;
   endcomp;
   compute after;
      line ' ';
      line @25 'Profits in US dollars';
   endcomp;
   run;
