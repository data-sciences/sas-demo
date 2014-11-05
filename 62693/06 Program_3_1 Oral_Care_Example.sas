

	/*
		pH Oral Care Example from Schulte et al., 1998
	*/

	data pH;
		input t f;
		m = 4;
		do i=1 to f;
			output;
		end;
		drop f i;
		datalines;
		0 4
		1 4
		2 6
		3 2
		4 1
	;

	ods html;
	proc genmod data=pH;
		model t/m = / dist=binomial link=identity scale=deviance;
	run;
	ods html close;







	/*
		pH Oral Care Example from Schulte et al., 1998
	*/

	data pH;
		input t f;
		m = 4;
		datalines;
		0 4
		1 4
		2 6
		3 2
		4 1
	;

	proc genmod data=pH;
		model t/m = / dist=binomial link=identity scale=deviance;
		freq f;
	run;
