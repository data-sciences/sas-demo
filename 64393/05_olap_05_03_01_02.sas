/*=============================================================*/
/*Create an NWAY summary for all levels in the data set        */
proc summary data=SASHELP.PRDSAL3 nway;
class country state prodtype product date;
var actual_sales;
output out=mylib.class_sum sum(actual_sales)=actual_sales;
run;
/*===========================================================================*/
