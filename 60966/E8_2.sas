* E8_2.sas
*
* Chapter 8 Exercise 2
*
* Total profit for each year within Product line.;

options center;
ods listing close;

ods html style=default
         path="&path\results"
         body='E8_2.html';

title1 'Total profit per year';
title2 'Separated by Product Line';
title3 'Profit Summaries';
proc report data=sashelp.orsales nowd split='*';
      *  Call define does not offer control of the header spaces
      * style(header)={background=white}
      * style(column)={background=pink};
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

   compute year; 
      call define(_col_,'style','style={background=cyan}');
   endcomp;

   compute product_line; 
      call define(_col_,'style','style={background=pink}');
   endcomp;

   compute after year;
      call define(_row_,'style','style={background=green}');
   endcomp;

   compute after;
      call define(_row_,'style','style={background=red}');
   endcomp;
   run;
ods _all_ close;
