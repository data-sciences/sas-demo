
/*=== JES\sample_code\ch_7\vendors_3.sas ===*/
TITLE1 HEIGHT=5 "Mean Resistance by Vendor and Month";
SYMBOL1 VALUE=dot    HEIGHT=2 COLOR=green  WIDTH=2 INTERPOL=JOIN;
SYMBOL2 VALUE=square HEIGHT=2 COLOR=red    WIDTH=2 INTERPOL=JOIN;
SYMBOL3 VALUE=plus   HEIGHT=2 COLOR=blue   WIDTH=2 INTERPOL=JOIN; 
AXIS1 LABEL=(JUSTIFY=Center HEIGHT=4  FONT='Arial' COLOR=Black "Month of Manufacture") 
	  VALUE = (ANGLE=45 ROTATE=0 HEIGHT=3 FONT='Arial')
	  OFFSET= (5, 5); 
AXIS2 LABEL =(H=4  A=90  FONT='Arial' 'Average Resistance')
	  VALUE = (H=3 FONT='Arial')
	  ORDER = (10 TO 25 BY 5) 
	  MINOR = (N=4);
PROC GPLOT DATA =JES.Results_Tab;	
	PLOT M_Res*Mon=Vendor / NAME="Vend_3"
	HAXIS=AXIS1 VAXIS=AXIS2 VREF=12.5 22.5;
	Format M_Res 3.0;
RUN; QUIT;






