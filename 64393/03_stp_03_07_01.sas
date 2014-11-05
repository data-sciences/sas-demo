/* ==========================================================================*/
%LET SP_NAME=Order_Detail_Report;
   libname mylib meta liburi="SASLibrary?@name='Candy'";

proc sql outobs=10;
create table top10ords as 
select saleyear
  , company
  , region
  , ‘"<a href=http://
&_srvname.:&_srvport./SASStoredProcess/do?_program="
||tranwrd(strip("&_METAFOLDER"), ' ',)||’+')||"&SP_NAME.”
				||'&orderid='||strip(put(orderid,8.))
				||" target=_blank>"
				||strip(put(orderid,8.))||"</a>"
					as order_url
		length=500 format=$500. label='Order Number'
	, sale_amount format=dollar12. label='Order Amount'
 from mylib.sales_candy_history 
 	where saleyear=&year.
 order by sale_amount desc;
quit;

Title "Summary - Top 10 Orders for &Year."; 
proc print data=top10ords noobs label;
run;
/* ==========================================================================*/
