



	/* 
		Plots of Probability Functions of 
		the Poisson and Negative-binomial Distributions 
	*/

	%macro plots_p_nb(mu,kappa); 

	data p_nb;
		format Distribution $17.;
		label Prob = "Probability";
		mu    = &mu;
		kappa = &kappa;
		alpha = 1/kappa;
		p     = 1/(1+mu*kappa);
		pc    = 1-p;

		do Y=0 to 30;
		Prob = PDF('POISSON',y,mu);
		Distribution = 'Poisson';
		output;
		Prob = PDF('NEGB',y,p,alpha);
		Distribution = 'Negative-binomial';
		output;
		end;

		keep y Prob Distribution;
	run;

	title1 "Probability Functions Poisson and Negative-binomial Distributions";
	title2 "Mu=&mu, Kappa=&kappa";
	proc sgscatter data=p_nb;
	compare y=Prob  x=y / group=Distribution
			markerattrs=(size=10);
	run;

	%mend plots_p_nb;

	ods html;
	ods graphics on;
		%plots_p_nb(10, 0.2);
	ods graphics off;
	ods html close;






