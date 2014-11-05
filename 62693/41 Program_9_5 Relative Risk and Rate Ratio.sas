


	/*
		Relative Risk and Rate Ratio
		Hypothetical Data from a Clinical Trial with Rate Ratio = 4
		Morel and Neerchal (2008)
	*/

	data adverse_events; 
		input treat y time;
		offs = log(time);
		id   = _n_;
		datalines;
		1	0	 4.6
		1	0	10.0
		1	0	14.5
		1	0	52.0
		1	1	 7.2
		1	1	16.3
		1	1	17.6
		1	1	23.8
		1	1	24.5
		1	1	29.5
		2	0	 6.1
		2	0	32.5
		2	0	52.0
		2	0	52.0
		2	0	52.0
		2	0	52.0
		2	0	52.0
		2	1	31.0
		2	1	32.0
		2	1	38.4
	;
	
	ods html;
	title "Relative Risk Results";
	proc genmod data=adverse_events;
		class id treat;
		model y = treat / dist=poisson link=log;
		repeated subject=id / type=ind;
		lsmeans treat;
		estimate 'Active Vs Placebo' treat 1  -1;
	run;

	title "Rate Ratio Results";
	proc genmod data=adverse_events;
		class id treat;
		model y = treat / dist=poisson link=log offset=offs;
		repeated subject=id / type=ind;
		lsmeans treat;
		estimate 'Active Vs Placebo' treat 1  -1;
	run;
	ods html close;
 




	title "Relative Risk Results";
	proc genmod data=adverse_events descending;
		class id treat;
		model y = treat / dist=binomial link=log;
		repeated subject=id / type=ind;
		lsmeans treat;
		estimate 'Active Vs Placebo' treat 1  -1;
	run;

