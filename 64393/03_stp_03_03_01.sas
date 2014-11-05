/*======================================================*/
/*Macro variables used to query the dataset             */

  %let sale = 5000;
  %let region = East;
  %time_period=01JUL2011;
  
libname mylib meta liburi="SASLibrary?@name='Candy'";

title "Customer Sales by Region";
proc report data=mylib.sales_candy_history nowd;

   WHERE     sale_amount gt &sale.          	 /*Numeric variable*/
		and salemonth = "&time_period."d  /*Date variable*/
		and region in ( "&REGION." )	 /*character variable*/
;
column region company salemonth sale_amount;
	define region/group;
	define company/group ;
	define salemonth/group format=monyy.;
	define sale_amount/format=dollar12.2;
run;
/*======================================================*/
