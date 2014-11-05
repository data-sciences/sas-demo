


	/*
		Milk Consumption Example -- Mullahy (1986)
	*/

	data Milk_Consumption;
		input Y freq;
		label y = ' (Number of Glasses of Milk)';
		sum + freq;
		call symput('n',cats(sum));
		drop sum;
		datalines;
		0	767
		1	557
		2	333
		3	142
		4	62
		5	23
		6	16
		;

	ods html;

	title2 "Poisson Hurdle Model";
	proc nlmixed data=Milk_Consumption;
		parms alpha=0 beta=0;
		p1 = 1/(1+exp(-alpha));
		mu = exp(beta);
		p2 = exp(-mu);
		if y=0 then
			 ll = log(p1);
		else ll = log((1-p1)/(1-p2)) + y * log(mu)
		        - lgamma(y+1) - mu;
		ll = freq*ll;
		model y ~ general(ll);
		predict &n*exp(ll/freq) out=Pred_Milk_1;
		estimate "P1"  1/(1+exp(-alpha));
		estimate "Mu"  exp(beta);
		estimate "Mean"      1/(1+exp(alpha))/(1-exp(-exp(beta)))*exp(beta);
		estimate "Variance"  1/(1+exp(alpha))/(1-exp(-exp(beta)))*exp(beta)*(exp(beta)+1)
                           - 1/(1+exp(alpha))/(1-exp(-exp(beta)))*exp(beta)*
                             1/(1+exp(alpha))/(1-exp(-exp(beta)))*exp(beta);
	run;

	title2 "Negative-binomial Hurdle Model";
	proc nlmixed data=Milk_Consumption;
		parms alpha=0 beta=0 kappa=0.5;
		bounds kappa > 0;
		p1   = 1/(1+exp(-alpha));
		mu   = exp(beta);
		a    = 1/kappa;
		p    = 1 / (1 + kappa*mu);
		p2   = p**a;
		if y=0 then
			 ll = log(p1);
		else ll = log((1-p1)/(1-p2)) + a * log(p) + y * log(1-p)
		          + lgamma(y+a) - lgamma(a) - lgamma(y+1);;
		ll = freq*ll;
		model y ~ general(ll);
		predict &n*exp(ll/freq) out=Pred_Milk_2;
		estimate 'P1'    1/(1+exp(-alpha));
		estimate 'Mu'    exp(beta);
		estimate 'Kappa' kappa;
		estimate 'Mean'     1/(1+exp(alpha))/(1-(1/(1+kappa*exp(beta)))**(1/kappa))*exp(beta);
		estimate 'Variance' 1/(1+exp(alpha))/(1-(1/(1+kappa*exp(beta)))**(1/kappa))*exp(beta)*(1+exp(beta)+kappa*exp(beta))
                          - 1/(1+exp(alpha))/(1-(1/(1+kappa*exp(beta)))**(1/kappa))*exp(beta)*
                            1/(1+exp(alpha))/(1-(1/(1+kappa*exp(beta)))**(1/kappa))*exp(beta);
	run;

	title1 "Milk Consumption Example -- Mullahy (1986)";
	proc means data=Milk_Consumption n mean var maxdec=4;
		var y;
		freq freq;
	run;

	ods html close;







	/*
		Milk Consumption Example -- Mullahy (1986)
	*/

	%macro gof_test(File,Distribution,DF);

	proc iml;

	/* Input:	File         = File containing Observed and Expected Frequencies
				Distribution = Distribution being fitted
				DF           = Degrees of Freedom for GOF Test
	   Output:	Pearson's GOF and Associated P-value */

	*--- Get observed and expected frequencies;
	use &File var {freq};
	read all into obs;
	use &File var {pred};
	read all into exp_f;

	sum1       = obs[+,1];
	sum2       = exp_f[+,1];
	exp_f[7,1] = exp_f[7,1] + sum1 - sum2;
	sum2       = exp_f[+,1];

	*--- Compute Chi-square GOF statistics and P-values;
	chi = 0;
	do j=1 to 7; 
		chi = chi + obs[j] * obs[j] / exp_f[j];
	end;
	chi  = round(chi - &n, 0.01);
	df   = &DF;
	pval = 1 - probchi(chi,df,0); 

	*--- Print results;
	x0 = { '   0', '   1', '   2', '   3', '   4', '   5', 
	       ' >=6', 'TOTALS' };
	Distribution = {&Distribution};
	x1 = obs // sum1;
	x2 = exp_f // sum2;

	mattrib x0      label='Value of Y';
	mattrib x1      label='Observed Frequencies'   format=8.0;
	mattrib x2      label='Expected Frequencies'   format=10.4;
	mattrib chi     label='Chi-square'             format=8.2;
	mattrib df      label='DF'                     format=8.0;
	mattrib pval    label='P-Value'                format=pvalue6.;

	print "Goodness-of-fit Tests Results";
	print x0 x1 x2; 
	print Distribution chi df pval;

	quit;

	%mend gof_test;

	ods html;
	title1 "Milk Consumption Example -- Mullahy (1986)";
	title2 "Poisson Hurdle Model";
	%gof_test(Pred_Milk_1,'Poisson Hurdle',7-1-2);

	title2 "Negative-binomial Hurdle Model";
	%gof_test(Pred_Milk_2,'Negative-binomial Hurdle',7-1-3);
	ods html close;









	title "ZIP Model -- Milk Consumption Example -- Mullahy (1986)";
	proc genmod data=Milk_Consumption;
		model y = / dist=zip;
		zeromodel / link=logit;
		freq freq;
	run;

	title "ZINB Model -- Milk Consumption Example -- Mullahy (1986)";
	proc genmod data=Milk_Consumption;
		model y = / dist=zinb;
		zeromodel / link=logit;
		freq freq;
	run;
