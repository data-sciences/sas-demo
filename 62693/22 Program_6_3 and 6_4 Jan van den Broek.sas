



	/*
		Urinary Tract Infections (UTI) in Men Infected with HIV Example
		Data kindly provided by Prof Jan van den Broek, Utrecht University
		Reference: Broek (1995), Biometrics
	*/

	data urinary_tract_infection;
		input episode follow_up cd4 @@;
		label episode   = "Number of UTI"
		      follow_up = "Time to Follow Up (Months)"
				cd4     = "CD4+ Cell Count"
		      offs      = "Logarithm of Time to Follow Up (Offset)";
		offs = log(follow_up);
	datalines;
	0	24	125	0	5	10	0	11	290
	0	12	50	0	10	5	0	9	380
	1	6	30	0	6	50	0	9	420
	0	6	80	0	11	15	0	9	240
	0	3	170	0	11	55	0	9	470
	0	6	95	0	11	80	0	3	310
	0	4	35	0	9	140	0	3	460
	0	3	50	0	9	60	2	3	245
	2	6	25	2	4	5	0	5	670
	1	13	15	0	22	45	0	8	1280
	0	10	80	0	5	30	0	6	780
	0	24	130	0	5	110	0	19	1585
	0	5	70	0	5	40	0	6	615
	0	3	40	1	3	104	0	15	880
	2	12	70	0	6	410	0	6	645
	0	16	30	0	10	280	0	13	560
	1	13	65	0	5	480	0	6	710
	0	24	40	0	7	300	0	13	640
	1	3	55	0	8	230	0	12	1150
	1	16	25	0	3	210	0	11	530
	0	18	70	2	23	380	0	10	620
	0	15	5	0	18	310	0	12	980
	3	23	20	0	5	275	0	6	600
	2	11	105	0	5	390	0	7	1240
	0	12	60	0	18	440	0	7	530
	1	6	85	0	18	360	0	5	590
	0	17	5	0	12	300	0	7	735
	0	17	50	0	5	290	0	3	1075
	1	9	15	0	5	370	0	5	840
	2	16	50	0	12	460	0	4	520
	0	8	10	0	11	275	0	3	540
	0	4	175	0	11	290	0	4	860
	0	12	20	1	11	270			
	;

	*--- Computation Jan van den Broek (1995) Score Test;
	ods html;

	title "Poisson Model -- UTI in Men Infected with HIV";
	ods output ParameterEstimates=betas;
	proc genmod data=urinary_tract_infection;
		model episode = cd4 / dist=poisson;
		output out=out1 predicted=mu; 
	run;

	data betas;
		set betas;
		if Parameter = "Intercept" then call symput('DF',trim(left(DF)));
		if DF ne 0;
		keep Estimate;
	run;

	title;
	*-------;
	proc iml;
	*-------;
		*--- Read parameter estimates and data;
		use betas;
		read all into betas;
		use out1;
		read all var{mu} into lambdas;
		use out1;
		read all var{cd4} into x;
		use out1;
		read all var{episode} into y;

		*--- Compute Jan van den Broek (1995) Score Test;
		n = nrow(x);
		if &df = 1 then x = j(n,1,1) || x;
		aux1  = ^y;
		aux2  = exp(-lambdas);
		aux3  = lambdas`*x*inv(x`*diag(lambdas)*x)*x`*lambdas;
		chisq = (sum(aux1/aux2) - n)**2 / ((sum(1/aux2) - n) - aux3);
		df    = 1;
		pval  = 1 - probchi(chisq,df,0);  

		*--- Print results;
		mattrib chisq label="Chi-square Statistic" format=8.2;
		mattrib df label="Degrees of Freedom";
		mattrib pval label="P-Value" format=pvalue6.;
		print "Jan van den Broek (1995) Score Test for Zero Inflation in a Poisson Distribution" ,
	          "Urinary Tract Infections on HIV Infected Men Example";
		print chisq df pval;
	quit;

	ods html close;








	*--- Other ZIP Models of interest;

	title "ZIP Model -- UTI in Men Infected with HIV";
	proc genmod data=urinary_tract_infection;
		model episode = cd4 / dist=zip;
		zeromodel  / link=logit;
	run;

	title "ZIP Model -- UTI in Men Infected with HIV";
	proc genmod data=urinary_tract_infection;
		model episode = cd4 / dist=zip;
		zeromodel cd4 / link=logit;
	run;

	title "ZIP Model -- UTI in Men Infected with HIV";
	proc genmod data=urinary_tract_infection;
		model episode =  / dist=zip;
		zeromodel  cd4 / link=logit;
	run;









	ods html;

 	proc univariate data=urinary_tract_infection noprint;
	    var cd4;
	    output out=out2 q1=q1 median=q2 q3=q3;
  	run;

	data _null_;
		set out2;
		call symput('q1',trim(left(q1)));
		call symput('q2',trim(left(q2)));
		call symput('q3',trim(left(q3)));
	run;

	title "Zero-Inflated Poisson Model using PROC GENMOD";
	ods output Estimates=Est;
	proc genmod data=urinary_tract_infection;
		model episode =  / dist=zip;
		zeromodel cd4 / link=logit;
		estimate "Prob at risk UTI when CD4=&q1" @zero intercept -1 cd4 -&q1;
		estimate "Prob at risk UTI when CD4=&q2" @zero intercept -1 cd4 -&q2;
		estimate "Prob at risk UTI when CD4=&q3" @zero intercept -1 cd4 -&q3;
		estimate "Log(OR)" @zero cd4 100 / exp;
	run;

	title "Estimate Probabilities of Risk of UTI at Different Values of CD4";
	proc print data=est noobs;
		where label contains "Prob" and label contains "Zero Inflation";
		var label mean:;
	run;


	title "Estimated Odds-Ratio for CD4 decrease of 100 units";
	proc print data=est noobs;
		where label contains "Exp";
		var label LBeta:;
	run;

	ods html close;




