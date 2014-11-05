



	/*
		Williams (1982) analysis using seed germination data in Crowder (1978)

		type_seed    = 0 corresponds to O. aegyptiaca 75    
		type_seed    = 1 corresponds to O. aegyptiaca 73    
		root_extract = 0 corresponds to Beans
		root_extract = 1 corresponds to Cucumbers
	*/

	data seeds;
		input type_seed root_extract t m;
		datalines;
		0	0	10	39
		0	0	23	62
		0	0	23	81
		0	0	26	51
		0	0	17	39
		0	1	5	6
		0	1	53	74
		0	1	55	72
		0	1	32	51
		0	1	46	79
		0	1	10	13
		1	0	8	16
		1	0	10	30
		1	0	8	28
		1	0	23	45
		1	0	0	4
		1	1	3	12
		1	1	22	41
		1	1	15	30
		1	1	32	51
		1	1	3	7
	;

	ods html;
	proc logistic data=seeds;
		model t/m = type_seed root_extract type_seed*root_extract / scale=none;
		output out=out1 predicted=pi_hat; 
		title "Full Model With SCALE=NONE";
	run;
	 
	proc logistic data=seeds;
		model t/m = type_seed root_extract type_seed*root_extract / scale=williams;
		output out=out1 predicted=pi_hat; 
		title "Full Model With SCALE=WILLIAMS";
	run;
	   
	proc means mean data=out1;
		class type_seed root_extract;
		var pi_hat;
	run;
	ods html close;

