* E2_1.sas
*
* Chapter 2 Exercise 1
*
* Total profit for each year;

title1 'Total profit per year';
proc report data=sashelp.orsales nowd;
   column year profit;
   define year   / group;
   define profit / analysis sum format=dollar15.2;
   run;
