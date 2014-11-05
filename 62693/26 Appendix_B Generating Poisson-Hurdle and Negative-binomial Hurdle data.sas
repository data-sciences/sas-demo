


	/*
		Generation of data under a Poisson Hurdle Model
		with parameters Pi_1 and Mu,
		and under a Negative-binomial Hurdle Model
		with parameters Pi_1, Mu and Kappa
	*/
 
	ods html;

	title1 "Poisson Hurdle Model with Pi_1=0.4 and Mu=10";
	data Poisson_Hurdle_Data;
	n    = 8000;
	p1   = 0.4;
	mu   = 10;
	seed = 1979;

	*--- Underlying True Mean and Variance;
	p2   = exp(-mu);
	p1c  = 1 - p1;
	p2c  = 1 - p2;
	Phi  = p1c / p2c;
	Mean = Phi*mu;
	Var  = Phi*mu*(mu+1)- Mean*Mean;

	do j=1 to n;
		u    = uniform(seed);
		if u <= p1 then do;
			Y    = 0;
			output;
		end;
		else do; *--- Crossing the hurdle;
			*--- Get Truncated Poisson using Rejection Method;
			do until (y>0);
				y = ranpoi(seed,mu);
			end;
			output;
		end;
	end;
	run;

	title2 "Underlying True Mean and Variance";
	proc print data=Poisson_Hurdle_Data noobs;
		where j=1;
		var Mean Var;
		format _all_ 8.4;
	run;

	title2 "Estimated Mean and Variance";
	proc means data=Poisson_Hurdle_Data n mean var maxdec=4;
		var y;
	run;


	title1 "Negative-binomial Hurdle Model with Pi_1=0.4, Mu=10 and Kappa=0.1";
	data NB_Hurdle_Data;
	n     = 8000;
	p1    = 0.4;
	mu    = 10;
	Kappa = 0.1;
	alpha = 1 / kappa;
	beta  = kappa * mu;
	seed  = 1983;

	*--- Underlying True Mean and Variance;
	p2   = (1/(1+kappa*mu))**(alpha);
	p1c  = 1 - p1;
	p2c  = 1 - p2;
	Phi  = p1c / p2c;
	Mean = Phi*mu;
	Var  = Phi*mu*(1+mu+kappa*mu)- Mean*Mean;

	do j=1 to n;
		u    = uniform(seed);
		if u <= p1 then do;
			Y    = 0;
			output;
		end;
		else do; *--- Crossing the hurdle;
			*--- Get Truncated Neg-bin using Rejection Method;
			do until (y>0);
				uu = beta * rangam( seed, alpha );
				y = ranpoi( seed, uu );
			end;
			output;
		end;
	end;
	drop alpha beta kappa;
	run;

	title2 "Underlying True Mean and Variance";
	proc print data=NB_Hurdle_Data noobs;
		where j = 1;
		var Mean Var;
		format _all_ 8.4;
	run;

	title2 "Estimated Mean and Variance";
	proc means data=NB_Hurdle_Data n mean var maxdec=4;
		var y;
	run;

	ods html close;

