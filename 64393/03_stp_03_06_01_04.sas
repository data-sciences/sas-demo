/*==================================================================*/
*ProcessBody;
%global region time_period sale;
   libname mylib meta liburi="SASLibrary?@name='Candy'";

%MACRO MakeReport;  /*== START MARCO ==*/
/*=== Use PROC SQL to query the dataset and create a TEMP dataset  */
proc sql;
	create table TEMP as
		select region, name, date, sale_amount
	from mylib.candy_sales_summary
	where date ge "&time_period."d
		and sale_amount gt &sale.
		and region in ("&REGION");
	quit;

     /*=== The number of rows in the TEMP dataset is assigned to &SQLOBS. */
	%IF &SQLOBS. le 0 %THEN %DO;  /*Send error message to user  */
		data msg; MESSAGE="Values not found. Try again.";run;
		proc print data=msg noobs; run;
	%END;
	%ELSE %DO;    /*Rows were returned; output the report */
		proc report data=temp nowd;
		column region name Date sale_amount;
		define region/group;
		define Name/group;
		define date/group format=monyy.;
		run;
%END;
%MEND makereport;  /*=== END MACRO ===*/

/*=== Start the stored process output and call the macro       ===*/
%stpbegin;
		title "Customer Sales by Region";
	       title2 "Order over $&sale.";
		%MakeReport;  /* Call the macro */
%stpend;
/*=============================================================================*/
