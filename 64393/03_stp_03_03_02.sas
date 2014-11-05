
/*=== Start the Stored Process ============*/
*ProcessBody;

%global sale region time_period;
   
libname mylib meta liburi="SASLibrary?@name='Candy'";

%STPBEGIN; 
title "Customer Sales by Region";
proc report data=mylib.sales_candy_history nowd;
WHERE sale_amount gt &sale.
		and salemonth = "&time_period."d 
		and region in ( "&REGION." )
;
column region company salemonth sale_amount;
	define region/group;
	define company/group ;
	define salemonth/group format=monyy.;
	define sale_amount/format=dollar12.2;
run;
%STPEND;

/*=== End the Stored Process ============*/
