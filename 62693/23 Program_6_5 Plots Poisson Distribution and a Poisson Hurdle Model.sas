



	/* 
		Plots of Probability Functions of Poisson and 
		Poisson Hurdle Distributions
	*/

	%macro plots(mu,pi_1); 

	data one;
		format Distribution $24.;
		label Prob = "Probability" Y = "Count";
		mu    = &mu;
		pi_1  = &pi_1 ;
		pi_2  = exp(-mu);
		Phi   = (1-pi_1)/(1-pi_2);
		
		Y    = 0;
		Prob = pi_2;
		Distribution = "Poisson (&mu)";
		output;
		Prob = pi_1;
		Distribution = "Poisson Hurdle(&mu, &pi_1)";
		output;

		do Y=1 to 12;
			Prob = PDF('POISSON',y,mu);
			Distribution = "Poisson (&mu)";
			output;
			Prob = phi*PDF('POISSON',y,mu);
			Distribution = "Poisson Hurdle(&mu, &pi_1)";
			output;
		end;

		keep y Prob Distribution;
	run;

	title "Probability Functions Poisson and Poisson Hurdle Distributions";
	proc sgpanel data=one;
		panelby Distribution;
		vbar y / response=Prob;
	run;

	%mend plots;

	ods html;
	ods graphics on;
		%plots(3, 0.1);
		%plots(3, 0.025);
	ods graphics off;
	ods html close;






	

