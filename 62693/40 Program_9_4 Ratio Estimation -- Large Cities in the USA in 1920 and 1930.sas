


	/*
		Ratio Estimation
		Sizes of 49 Large United States Cities (in 1000’s) in 1920 and 1930
		Cochran (1977, page 152)
	*/	

	data cities;
		input z y @@;
		id  = _n_;
		datalines;
		76	80	2	50	243	291
		138	143	507	634	87	105
		67	67	179	260	30	11
		29	50	121	113	71	79
		381	464	50	64	256	288
		23	48	44	58	43	61
		37	63	77	89	25	57
		120	115	64	63	94	95
		61	69	64	77	43	50
		387	459	56	142	298	317
		93	104	40	60	36	46
		172	183	40	64	161	232
		78	106	38	52	74	93
		66	86	136	139	45	53
		60	57	116	130	36	54
		46	65	46	53	50	58
						48	75
		;

	ods html;
	title1 "Ratio of Two Correlated Means";
    title2 "Sizes of 49 Large United States Cities in 1920 and 1930";
	proc glimmix data=cities empirical;
		lnz = log(z);
		class id;
		model y = / dist=poisson offset=lnz ddfm=none;
		random _residual_ / subject=id;
		estimate 'LogRatio' intercept 1 / ilink cl;
	run;
	ods html close;

	data cities;
		set cities;
		lnz = log(z);
	run;



	ods html;
	title1 "Ratio of Two Correlated Means";
    title2 "Sizes of 49 Large United States Cities in 1920 and 1930";
	proc genmod data=cities ;
	class id;
		model y = / dist=poisson offset=lnz;
		repeated subject=id;
		estimate 'LogRatio' intercept 1 ;
		run;
	ods html close;

