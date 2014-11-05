


	/*
		Housing Satisfaction, Brier(1980), Non-Metropolitan area (Rural)
	*/

	data housing;
	input t1 t2 t3;
	datalines;
	    3    2    0
	    3    2    0
	    0    5    0
	    3    2    0
	    0    5    0
	    4    1    0
	    3    2    0
	    2    3    0
	    4    0    1
	    0    4    1
	    2    3    0
	    4    1    0
	    4    1    0
	    1    2    2
	    4    1    0
	    1    3    1
	    4    1    0
	    5    0    0
	;

	ods html;
	%DirMult_RCMult(housing, "Housing Satisfaction, Brier(1980), Rural Area" );
	ods html close;


