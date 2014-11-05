


	/* 	
	   Pump Reliability at a Pressurized Water Reactor Nuclear Power Plant
	   Gaver and O?Muircheartaigh (1987)
	   Draper (1996) 
    */
		
	data pump;
		pump = _n_;
		input y t group;
		logtstd = log(t) - 2.4564900;
		datalines;
		 5  94.320 1
		 1  15.720 2
		 5  62.880 1
		14 125.760 1
		 3   5.240 2
		19  31.440 1
		 1   1.048 2
		 1   1.048 2
		 4   2.096 2
		22  10.480 2
		;

	ods html;
	title "Pump Reliability at a Pressurized Water Reactor Nuclear Power Plant";
	proc glimmix data=pump method=quad;
		class group;
		model y = group logtstd*group / noint dist=poisson link=log 
										solution ddfm=residual;
		random int / subject=pump;
		estimate "Difference Y-intercepts" group 1 -1;
		estimate "Difference Slopes" logtstd*group 1 -1;
	run;
	ods html close;




	proc nlmixed data=pump;
		parms logsig 0 beta1 1 beta2 1 alpha1 1 alpha2 1;
		if (group = 1) then eta = alpha1 + beta1*logtstd + e;
		else eta = alpha2 + beta2*logtstd + e;
		lambda = exp(eta);
		model y ~ poisson(lambda);
		random e ~ normal(0,exp(2*logsig)) subject=pump;
		estimate 'alpha1-alpha2' alpha1-alpha2;
		estimate 'beta1-beta2' beta1-beta2;
		estimate 'Sigma**2' exp(2*logsig);
	run;


