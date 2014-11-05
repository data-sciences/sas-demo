
/*=== JES\sample_code\ch_7\chitronix_1.sas ===*/
TITLE1 "Delay vs Resistance - ChiTronix - Q4 2008";
AXIS1 ORDER=(5 TO 25 BY 5);
AXIS2 ORDER=(100 TO 350 BY 50);
SYMBOL1 VALUE=dot    HEIGHT=2 COLOR=green  WIDTH=2 INTERPOL=NONE;
SYMBOL2 VALUE=square HEIGHT=2 COLOR=red    WIDTH=2 INTERPOL=NONE;
SYMBOL3 VALUE=plus   HEIGHT=2 COLOR=blue   WIDTH=2 INTERPOL=NONE; 
PROC GPLOT DATA=JES.Results_Q4(WHERE=(Vendor="ChiTronix"));
	PLOT Delay*Resistance=Mon / NAME="Chi_1"
	HAXIS=AXIS1 VAXIS=AXIS2
	LHREF=2 LVREF=2 HREF=12.5 22.5 VREF=150 250;
	FORMAT Resistance 8.0;
RUN; QUIT;

