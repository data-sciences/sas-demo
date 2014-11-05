* E4_1.sas
*
* Chapter 4 Exercise 1
*
* Adding HEADLINE and HEADSKIP;

title1 'Total profit per year';
title2 'Separated by Product Line';
proc report data=sashelp.orsales 
            headline headskip nowd;
   column year product_line,profit;
   define year / group;
   define product_line / across 
                         '- Products -';
   define profit / analysis sum format=dollar15.2;
   run;
