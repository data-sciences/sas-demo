


	/*
		Number of Tumors in Rats
		Example from Lawless (1987) and Gail et al. (1980)
	*/

	data number_of_tumors;
		input group$ n @@;
			do ratid=1 to n;
			input y @@;
			output;
			end;
		drop n;
		datalines;
		Retinoid 23 1 0 2 1 4 3 6 1 1 5 2 1 5 2 3 4 5 5 1 2
		6 0 1 Control 25 7 11 9 2 9 4 6 7 6 1 13 2 1 10 4 5 11 11
		9 12 1 3 1 3 3
	;

	ods html;
	proc genmod data=number_of_tumors;
		class ratid group;
		model y = group / dist=poisson link=log scale=pearson;
		lsmeans group;
		estimate "Logarithm Ratio Control Vs Retinoid" group 1 -1;
	run;
	ods html close;



