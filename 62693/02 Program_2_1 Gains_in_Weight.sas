


	/* 
		Snedecor and Cochran 1980, 7th Ed. Pages 156-157
		Gains in Weight Example
	*/ 

	data gains_in_weight;
		do Rat=1 to 15;
			input x @@;
			output;
		end;
	datalines;
	50  64  76	64  74  60	69 68	 56  48  57	 59  46 45	65
	128 159 158	119 133 112	96 126 132 118 107 106 82 103 104
	;

	proc sort data=gains_in_weight;
	by rat;
	run;

	proc transpose data=gains_in_weight out=gains_in_weight 
			(rename=(COL1=Initial_Weight COL2=Gains));
		by rat;
		var x;
	run;

	ods html;
	ods graphics on;
	title "*** OLS Results -- Gains in Weight Data ***";
	proc glimmix data=gains_in_weight plots=residualpanel;
		model Gains = Initial_Weight / solution;
	run;

	title "*** MLE Results -- Gains in Weight Data ***";
	proc glimmix data=gains_in_weight noreml;
		model Gains = Initial_Weight / solution;
	run;
	ods graphics off;
	ods html close;
