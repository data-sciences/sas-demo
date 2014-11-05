* E7_2.sas
*
* Chapter 7 Exercise 2
*
* Total profit and percentage for each Product line within year;
* Adding text to summary lines;

proc format;
   value $sequip
      'Sports' = 'Sports Equipment';
   run;

title1 'Total profit per year';
title2 'Separated by Product Line';
proc report data=sashelp.orsales nowd 
            out=rptdat split='*';
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
   rbreak after / summarize;

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
      percent = .;
      line ' ';
      line @25 'Profits in US dollars';
   endcomp;
   run;

proc print data=rptdat;
   run;
