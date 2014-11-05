



	/* 
		Plots of Probability Functions of 
		the Beta-binomial and Random-clumped Binomial Distributions 
	*/

	%macro plots_bb_rcb(pi,rho,m); 

	data bb_rcb;
		format Distribution $14.;
		label Prob = "Probability";
		label t    = "Number of Successes (t)";
		pi  = &pi;
		rho = &rho;
		m   = &m;
		c   = 1 / rho / rho - 1;
		pic = 1 - pi;
		p1  = (1 - rho)*pi + rho;
		p1c = 1 - p1;
		p2  = p1 - rho;
		p2c = 1 - p2;

		do t=0 to m;
		z       = lgamma(m+1) - lgamma(t+1) - lgamma(m-t+1);
		Prob = exp(z + lgamma(c) + lgamma(t+c*pi) + lgamma(m-t+c*pic)
			    - lgamma(m+c) - lgamma(c*pi) - lgamma(c*pic));
		Distribution = 'Beta-binomial';
		output;
		Prob = exp(z) * (pi*p1**t*p1c**(m-t) + pic*p2**t*p2c**(m-t));
		Distribution = 'Random-clumped Binomial';
		output;
		end;
		keep t Prob Distribution;
	run;

	ods html;
	ods graphics on;
	title1 "Probability Functions Beta-binomial and Random-clumped Binomial Distributions";
	title2 "with parameters  Pi=&pi  Rho=&rho  and  m=&m";
	proc sgpanel data=bb_rcb;
		panelby Distribution / spacing=8;
		vbar t / response=Prob group=Distribution;
	run;
	ods graphics off;
	ods html close;

	%mend plots_bb_rcb;

	%plots_bb_rcb(0.3, 0.7, 20);
	%plots_bb_rcb(0.5, 0.5, 20);
	%plots_bb_rcb(0.5, 0.8, 20);







	






	%macro moments_bb_rcb(pi,rho,m); 

	data moments_bb_rcb_02;
		pi    = &pi;
		rho   = &rho;
		m     = &m;
		c     = 1 / rho / rho - 1;
		pic   = 1 - pi;
		p1    = (1 - rho)*pi + rho;
		p1c   = 1 - p1;
		p2    = p1 - rho;
		p2c   = 1 - p2;
		mu1   = m * pi; *--- We compute mean and variance using algebraic formulas;
		mu2   = mu1 * pic * ( 1 + (m-1)*rho*rho ); 

		do t=0 to m;
			z       = lgamma(m+1) - lgamma(t+1) - lgamma(m-t+1);
			Prob_BB = exp(z + lgamma(c) + lgamma(t+c*pi) + lgamma(m-t+c*pic)
				    - lgamma(m+c) - lgamma(c*pi) - lgamma(c*pic));
			Prob_RCB = exp(z) * (pi*p1**t*p1c**(m-t) + pic*p2**t*p2c**(m-t));
			tmu1     = t - mu1;
			aux      = tmu1 * tmu1 * tmu1;
			mu3_BB   = Prob_BB * aux;
			mu3_RCB  = Prob_RCB * aux;
			aux      = aux * tmu1;
			mu4_BB   = Prob_BB * aux;
			mu4_RCB  = Prob_RCB * aux;
			output;
		end;

	keep mu1 mu2 mu3_BB mu3_RCB mu4_BB mu4_RCB;
	run;

	proc means data=moments_bb_rcb_02 sum noprint;
		var mu1 mu2 mu3_BB mu3_RCB mu4_BB mu4_RCB;
		output out=moments sum=mu1 mu2 mu3_BB mu3_RCB mu4_BB mu4_RCB;
	run;

	data moments;
		set moments;
		format Mean_BB Mean_RCB Var_BB Var_RCB Skewness_BB Skewness_RCB Kurtosis_BB Kurtosis_RCB 8.4;
		Mean_BB      = mu1 / (&m + 1);
		Mean_RCB     = Mean_BB;
		Var_BB       = mu2 / (&m + 1);
		Var_RCB      = Var_BB;
		Skewness_BB  = mu3_BB / (Var_BB**1.5);
		Skewness_RCB = mu3_RCB / (Var_RCB**1.5);
		if &pi = 0.5 then do;
			Skewness_BB  = 0;
			Skewness_RCB = 0;
			Kurtosis_BB  = mu4_BB / Var_BB / Var_BB; 
			Kurtosis_RCB = mu4_RCB / Var_RCB / Var_RCB;
		end;
		drop _type_ _freq_ mu1 mu2 mu3_BB mu3_RCB mu4_BB mu4_RCB;
	run;

	proc transpose data=moments out=final;
	run;

	data final;
		set final;
		if col1 = . then delete;
		rename _Name_=Moment Col1=Value;
	run;

	title1 "First Four Moments of the Beta-binomial and Random-clumped Binomial Distributions";
	title2 "with parameters  Pi=&pi  Rho=&rho  and  m=&m";
	proc print data=final noobs; 
	run;

	%mend moments_bb_rcb;



	%moments_bb_rcb(0.3, 0.2, 4);
	%moments_bb_rcb(0.3, 0.2, 20);
	%moments_bb_rcb(0.3, 0.7, 4);
	%moments_bb_rcb(0.3, 0.7, 20);


	%moments_bb_rcb(0.5, 0.2, 4);
	%moments_bb_rcb(0.5, 0.2, 20);
	%moments_bb_rcb(0.5, 0.7, 4);
	%moments_bb_rcb(0.5, 0.7, 20);




