



	/*
		Generation of data under a Negative-binomial distribution
   		with mean Mu and dispersion parameter Kappa
		Mean     of Y's is Mu
		Variance of Y's is Mu + Kappa*Mu*Mu = Mu*(1 + Kappa*Mu)
		Recall Alpha = 1/Kappa and Mu = Alpha*Beta
		 
   		In the procedures GENMOD, GLIMMIX and COUNTREG the dispersion parameter is Kappa 
	*/
 
	data one;   
		Mu       = 30;
		Kappa    = 0.1;
		alpha    = 1 / kappa;
		beta     = kappa * mu;
		n        = 2000;
		seed     = 1917;
		Variance = mu * ( 1 + mu*kappa);
		do id=1 to n;
			u = beta * rangam( seed, alpha );
			Y = ranpoi( seed, u );
			output;
		end;
		keep Mu Kappa Variance id y;
	run;

	*--- Get estimates of Mu and Kappa using PROC GLIMMIX;
	ods select none;
	ods output ParameterEstimates=parms;		
	proc glimmix data=one;
		model y = / dist=negbin link=identity s;
	run;
	ods select all;

	ods html;
	title "True Mu and Kappa of Y's iid Negative-binomial(Mu, Kappa)";
	proc print data=one noobs;
		where id = 1;
		var Mu Kappa;
	run;

	title "Estimated Mu and Kappa using PROC GLIMMIX";
	proc print data=parms noobs;
		var Effect Estimate;
	run;

	data one;
		set one;
		rename Mu = Mean;
	run;

	title "True Mean and Variance of Y's iid Negative-binomial(Mu, Kappa)";
	proc print data=one noobs;
		where id = 1;
		var Mean Variance;
	run;

	title "Estimated Mean and Variance";
	proc means data=one n mean var maxdec=2;
		var y;
	run;
	ods html close;

