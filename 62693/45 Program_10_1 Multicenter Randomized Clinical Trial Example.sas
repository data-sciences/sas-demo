


	/*
		Beitler and Landis (1985) 
		Multicenter Randomized Clinical Trial Example
	*/

	 data multi_center;
		 input clinic trt $ t m;
		 datalines;
		1	Drug	11	36
		1	Control	10	37
		2	Drug	16	20
		2	Control	22	32
		3	Drug	14	19
		3	Control	7	19
		4	Drug	2	16
		4	Control	1	17
		5	Drug	6	17
		5	Control	0	12
		6	Drug	1	11
		6	Control	0	10
		7	Drug	1	5
		7	Control	1	9
		8	Drug	4	6
		8	Control	6	7
		;

	ods html;
	title "*** Multicenter Randomized Clinical Trial -- Beitler and Landis (1985) ***"; 
	proc glimmix data=multi_center method=quad order=data;
		class clinic trt;
		model t/m = trt / link=logit dist=binomial s;
		random int / subject=clinic;
		lsmeans trt / ilink;
		estimate "Drug Vs Control" trt 1 -1 / or cl;
	run;
	ods html close;



