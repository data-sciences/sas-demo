/* ====================================================================*/
*ProcessBody;
%stpbegin;

/* Add the GOPTIONS VSIZE and HSIZE */
goptions vsize=3 in hsize= 3 in;

SYMBOL1	INTERPOL=JOIN	HEIGHT=8pt 	VALUE=DOT	LINE=1	WIDTH=1;
Axis1	STYLE=1 	WIDTH=1 	MAJOR=NONE 	MINOR=NONE;
Axis2	STYLE=1	WIDTH=1	MAJOR=NONE	MINOR=NONE;

TITLE "Average Sales by Month";
proc gplot data=plotme;
  plot sale_amount*sale_month=region /
   vaxis=axis1   haxis=axis2;
run;
quit;
%stpend;
/* ====================================================================*/
