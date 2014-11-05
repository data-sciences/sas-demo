


	/*
		Number of Failures Electronic Equipment under Two Operating Regimes
		Jorgenson (1961), and Frome et al. (1971) 
	*/

	data failures;
		input x1 x2 y;
		datalines;
		33.3	25.3	15
		52.2	14.4	9
		64.7	32.5	14
		137.0	20.5	24
		125.9	97.6	27
		116.3	53.6	27
		131.7	56.6	23
		85.0	87.3	18
		91.9	47.8	22
	;

	ods html;
	ods graphics on;
	title1 '*** Fisher Scoring optimization technique up to iteration 10  ***';
	title2 '*** Identity Link ***';
	proc glimmix data=failures scoring=10 plots=residualpanel;
		model y = x1 x2 / noint dist=poisson link=identity covb s;
	run;

	title1 '*** Fisher Scoring optimization technique up to iteration 10  ***';
	title2 '*** Logarithm Link ***';
	proc glimmix data=failures scoring=10 plots=residualpanel;
		model y = x1 x2 / noint dist=poisson link=log covb s;
	run;
	ods graphics off;
	ods html close;




	title '*** Newton-Raphson optimization technique. Hessian is used ***';
	proc glimmix data=failures;
		model y = x1 x2 / noint dist=poisson link=identity covb s;
	run;




