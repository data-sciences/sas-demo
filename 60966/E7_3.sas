* E7_3.sas
*
* Chapter 7 Exercise 3
*
* Total profit and percentage for each Product line within year;
* Report total without the RBREAK;

proc format;
   value $sequip
      'Sports' = 'Sports Equipment';
   run;

title1 'Total profit per year';
title2 'Grand Total without RBREAK';
proc report data=sashelp.orsales nowd 
            split='*';
   column year yeartxt product_line profit percent;
   define year   / group noprint;
   define yeartxt/ f=$5. 'Year';
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
   compute yeartxt / char length=7;
      if _break_ = ' ' and year ne . then yeartxt = put(year,4.);
      else if _break_ = ' ' and year = . then yeartxt = ' ';
      else if _break_='_RBREAK_' then yeartxt = 'Overall';
      else yeartxt = 'Total';
   endcomp;
   compute after;
      line ' ';
      line @5 'Total Profits in US dollars was ' profit.sum dollar14.2;
   endcomp;
   run;
