


	*--- Chapter 1: Programs 1.1 and 1.2 Correlated Bernoulli Outcomes;

	/* 	
		Generation of correlated Bernoulli outcomes 
		For Y(1),Y(2),...,Y(m)
		E(Y(i))          = Pi
		Var(Y(i))        = Pi*(1-Pi)
		Corr(Y(i),Y(i')) = Rho*Rho
	*/

	data correlated_bernoullis;
		n    = 20000; *--- Number of clusters;
		m    = 5;     *--- Number of elemental units within the cluster;
		pi   = 0.6;   *--- Probability of success of each elemental unit;
		rho2 = 0.3;   *--- Intra-cluster correlation;
		seed = 16670;
		rho  = sqrt( rho2 );
		do subjid = 1 to n;
			yy = 0;	*--- Variable yy plays the role of y of eq. (1.7);
			u  = uniform( seed );
			if u < pi then yy = 1;
			do i=1 to m;
				y = 0;
				u = uniform( seed );
				if u < rho then y = yy;
				else do;
				uu = uniform( seed );
				if uu < pi then y = 1;
				end;
				output;
			end;
		end;
		keep subjid i y;
	run;

	proc transpose data=correlated_bernoullis out=new;
		by subjid;
		id i;
		var y;
	run;

	ods html;
	proc corr data=new;
		var _1 - _5;
	run;
	ods html close;

	*--- Program 1.1 Continued;
	proc means data=correlated_bernoullis sum noprint;
		class subjid;
		var y;
		output out=out1 sum=t;
	run; 

	data out1;
		set out1;
		if _type_ = 1;
		drop _type _freq_;
	run;

	ods html;
	proc means data=out1 mean var maxdec=2;
		var t;
	run;
	ods html close;

	*--- Estimating actual Type I Error rate for overdispersed data;
	data correlated_bernoullis; *--- This data set was created in Program 1.1;
		set correlated_bernoullis;
		reps = ceil( subjid / 20 ); *--- Creates 1000 reps of n=20 clusters of size m=5 each;
	run;

	proc means data=correlated_bernoullis mean noprint;
		class reps;
		var y;
		output out=test mean=Pi_hat;
	run;

	data test;
	set test;
		if _type_ = 1;
		z     = (Pi_hat - 0.6) / sqrt( Pi_hat*(1-Pi_hat) / 100 );
		P_val = 0;
		if z > 1.6449 then P_val = 1;
	run;

	title "Monte Carlo Estimate of Type I Error Rate";
	proc means data=test n mean maxdec=3;
		var P_val;
	run;







	*--- Chapter 2: Program 2.1 Gains in Weight;

	/* 
		Snedecor and Cochran 1980, 7th Ed. Pages 156-157
		Gains in Weight Example
	*/ 

	data gains_in_weight;
		do Rat=1 to 15;
			input x @@;
			output;
		end;
	datalines;
	50  64  76	64  74  60	69 68	 56  48  57	 59  46 45	65
	128 159 158	119 133 112	96 126 132 118 107 106 82 103 104
	;

	proc sort data=gains_in_weight;
	by rat;
	run;

	proc transpose data=gains_in_weight out=gains_in_weight 
			(rename=(COL1=Initial_Weight COL2=Gains));
		by rat;
		var x;
	run;

	ods html;
	ods graphics on;
	title "*** OLS Results -- Gains in Weight Data ***";
	proc glimmix data=gains_in_weight plots=residualpanel;
		model Gains = Initial_Weight / solution;
	run;

	title "*** MLE Results -- Gains in Weight Data ***";
	proc glimmix data=gains_in_weight noreml;
		model Gains = Initial_Weight / solution;
	run;
	ods graphics off;
	ods html close;







	*--- Chapter 2: Programs 2.2, 2.3 and 2.4 Pyrethrins on Male Flies;

	/* 
		Dosage-Mortality of Pyrethrins on Male Flies, Murray (1938)
	*/

	data pyrethrins;
		input dose m t;
		label dose = "Concentration Pyrethrins mg/100 cc"
		         m = "Number of Male Flies"
		         t = "Number of Male Flies Killed"
		         x = "Log of Dose";
		x = log(dose);
		datalines;
		40	 462  109
		60	 500  199
		80	 467  298
		100	 515  370
		120	 561  459
		140	 469  400
		160	 550  495
		180	 542  499
		200	 479  450
		250	 497  476
		300	 453  442
		;

	ods html;
	ods graphics on;
	title1 "Dosage-Mortality of Pyrethrins on Male Flies, Murray (1938)";
	title2 "GLM with Binomial Distribution and Logit Link";
	proc glimmix data=pyrethrins plots=residualpanel;
		model t/m = x / dist=binomial link=logit solution;
	run;
	ods graphics off;
	ods html close;

	ods html;
	ods graphics on;
	title1 "Dosage-Mortality of Pyrethrins on Male Flies, Murray (1938)";
	title2 "GLM with Binomial Distribution and Probit Link";
	proc glimmix data=pyrethrins plots=residualpanel;
		model t/m = x / dist=binomial link=probit solution;
	run;
	ods graphics off;
	ods html close;

	ods html;
	title1 "Dosage-Mortality of Pyrethrins on Male Flies, Murray (1938)";
	title2 "GLM with Binomial Distribution and Logit Link using PROC PROBIT";
	proc probit data=pyrethrins log;
		model t/m = dose / d=logistic inversecl;
	run;

	title1 "Dosage-Mortality of Pyrethrins on Male Flies, Murray (1938)";
	title2 "GLM with Binomial Distribution and Probit Link using PROC PROBIT";
	proc probit data=pyrethrins log;
		model t/m = dose / inversecl;
	run;
	ods html close;

 	*--- Plotting 
		1)Estimated Logistic Curve and Observed Proportions
		2)Estimated Probit Curve and Observed Proportions;
	data temp;
		do dose=38 to 301 by 0.1; *--- Dose range in increments of 0.1;
			x = log(dose);
			output;
		end;
	drop dose;
	run;

	data new;
		set pyrethrins temp;
	run; 

	proc glimmix data=new; 
		model t/m = x / link=probit;
		output out=pred_out1 pred(ilink)=pi_hat;
	run;

	proc glimmix data=new;
		model t/m = x;
		output out=pred_out2 pred(ilink)=pi_hat;
	run;

	data pred_out1;
		set pred_out1;
		label pi_hat = 'Predicted Probability'
		      obs_pi = 'Observed Probability';
		obs_pi = .;
		if t >= 0 then do;
			obs_pi = t/m;
			pi_hat = .;
		end;
	drop t m;
	run;

	data pred_out2;
		set pred_out2;
		label pi_hat = 'Predicted Probability'
		     obs_pi  = 'Observed Probability';
		obs_pi = .;
		if t >= 0 then do;
			obs_pi = t/m;
			pi_hat = .;
		end;
	drop t m;
	run;

	ods html;
	ods graphics on;
	proc sgplot data=pred_out1;
		title1 "Estimated Probit Curve"; 
		title2 "Dosage-Mortality of Pyrethrins on Male Flies, Murray (1938)"; 
		scatter x=x y=obs_pi;
		series  x=x y=pi_hat / y2axis;
	run; 
	proc sgplot data=pred_out2;
		title1 "Estimated Logistic Curve"; 
		title2 "Dosage-Mortality of Pyrethrins on Male Flies, Murray (1938)"; 
		scatter x=x y=obs_pi;
		series  x=x y=pi_hat / y2axis;
	run; 
	ods graphics off;
	ods html close;

	*--- Plots can be also obtained using PROC LOGISTIC;
	ods html;
	ods graphics on;
	title1 "Dosage-Mortality of Pyrethrins on Male Flies, Murray (1938)";
	title2 "GLM with Binomial Distribution and Logit Link";
	proc logistic data=pyrethrins;
		model t/m = x / scale=none;
		effectplot fit / YRANGE=(0.2, 1.0);
	run;
	title2 "GLM with Binomial Distribution and Probit Link";
	proc logistic data=pyrethrins;
		model t/m = x / scale=none link=probit;
		effectplot fit / YRANGE=(0.2, 1.0);
	run;
	ods graphics off;
	ods html close;






 
	*--- Chapter 2: Program 2.5 Breslow and Day;

	/*
		Ille-et-Vilaine Study of oesophageal cancer, Tuyns et al. (1977)
	*/

	data one;
		input age_stratum $ cancer $ x1 x2;
		format alcohol $ $5.;
		alcohol = 'High'; count = x1; output;
		alcohol = 'Low';  count = x2; output;
		drop x1 x2;
		datalines;
		25-34  Case      1    0
		25-34  Control   9  106
		35-44  Case      4    5
		35-44  Control 	26  164
		45-54  Case     25   21
		45-54  Control  29  138
		55-64  Case     42   34
		55-64  Control  27  139
		65-74  Case	    19   36
		65-74  Control  18   88
		75+    Case	     5    8
		75+    Control   0   31
	;

	proc sort data=one;
		by age_stratum alcohol;
	run;

	proc transpose data=one out=oesophageal_cancer;
		by age_stratum alcohol;
		var count;
		id cancer;
	run;

	data oesophageal_cancer;
	set oesophageal_cancer;
		m = Case + Control;
	drop _name_;
	run;

	ods html;
	proc genmod data=oesophageal_cancer;
		class age_stratum alcohol;
		model case/m = age_stratum alcohol  / dist=binomial link=logit type3;
		estimate 'Ln(OR) High Vs Low' alcohol 1 -1 / exp;
	run;
	ods html close;

	proc freq data=one;
		tables age_stratum*alcohol*cancer / cmh;
		weight count;
	run;

	title '*** Saturated Model ***';
	proc genmod data=oesophageal_cancer;
		class age_stratum alcohol;
		model case/m = age_stratum alcohol age_stratum*alcohol/ dist=binomial 
		                                      link=logit type3;
	run;







	*--- Chapter 2: Program 2.6 Electronic Failures;

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







	*--- Chapter 3: Program 3.1 Oral Care Example;

	/*
		pH Oral Care Example from Schulte et al., 1998
	*/

	data pH;
		input t f;
		m = 4;
		do i=1 to f;
			output;
		end;
		drop f i;
		datalines;
		0 4
		1 4
		2 6
		3 2
		4 1
	;

	ods html;
	proc genmod data=pH;
		model t/m = / dist=binomial link=identity scale=deviance;
	run;
	ods html close;

	data pH;
		input t f;
		m = 4;
		datalines;
		0 4
		1 4
		2 6
		3 2
		4 1
	;

	proc genmod data=pH;
		model t/m = / dist=binomial link=identity scale=deviance;
		freq f;
	run;







	*--- Chapter 3: Programs 3.2 and 3.3 Toxoplasmosis in El Salvador;

	/*
		Toxoplasmosis in 34 cities of El Salvador
		Example from Efron (1978, 1986)
	*/

	data toxoplasmosis;
		input t m rain;
		z = rain;
		datalines;
		2	4	1735
		3	10	1936
		1	5	2000
		3	10	1973
		2	2	1750
		3	5	1800
		2	8	1750
		7	19	2077
		3	6	1920
		8	10	1800
		7	24	2050
		0	1	1830
		15	30	1650
		4	22	2200
		0	1	2000
		6	11	1770
		0	1	1920
		33	54	1770
		4	9	2240
		5	18	1620
		2	12	1756
		0	1	1650
		8	11	2250
		41	77	1796
		24	51	1890
		7	16	1871
		46	82	2063
		9	13	2100
		23	43	1918
		53	75	1834
		8	13	1780
		3	10	1900
		1	6	1976
		23	37	2292
		;

	proc stdize data=toxoplasmosis out=toxoplasmosis;
		var z;
	run;

	ods html;
	proc glimmix data=toxoplasmosis;
		model t/m = z z*z z*z*z / s; *--- z|z|z will also work;
		random _residual_ ;
	run;
	ods html close;

	data toxoplasmosis;
		set toxoplasmosis;
		city = _n_;
	run;

	ods html;
	proc glimmix data=toxoplasmosis;
		class city;
		model t/m = z z*z z*z*z / s;
		random _residual_ / subject=city;
	run;
	ods html close;

	*--- Replicating Generalized Analysis of Variance in Efron (1978);
	data temp;
		set toxoplasmosis;
		do i=1 to t;
			y=1;
			output;
		end;
		do i=1 to m-t;
			y=0;
			output;
		end;
	run;

	proc genmod data=temp;
		model y = z z*z z*z*z / link=logit dist=bin type1;
	run;







	*--- Chapter 3: Program 3.4 Number of Tumors;

	/*
		Number of Tumors in Rats
		Example from Lawless (1987) and Gail et al. (1980)
	*/

	data number_of_tumors;
		input group$ n @@;
			do ratid=1 to n;
			input y @@;
			output;
			end;
		drop n;
		datalines;
		Retinoid 23 1 0 2 1 4 3 6 1 1 5 2 1 5 2 3 4 5 5 1 2
		6 0 1 Control 25 7 11 9 2 9 4 6 7 6 1 13 2 1 10 4 5 11 11
		9 12 1 3 1 3 3
	;

	ods html;
	proc genmod data=number_of_tumors;
		class ratid group;
		model y = group / dist=poisson link=log scale=pearson;
		lsmeans group;
		estimate "Logarithm Ratio Control Vs Retinoid" group 1 -1;
	run;
	ods html close;






	*--- Chapter 3: Program 3.5 Vertebral Fracture Example;

	/*
		Vertebral fracture example from Morel and Neerchal (2010)
		treat = treatment
		    y = number of incident vertebral fractures (new and worsening)
		    z = person years of observation
	*/

	data fractures;
	input treat $ n @@;
		do subjid=1 to n;
		input y z @@;
		logz = log(z);
		output;
		end;
	drop n;
	datalines;
	Active 	28  1 2.9897 2 2.9843 0 2.9897 1 2.9843 2 2.9459 0 3.0445 1 3.0582
		0 2.9897 1 1.2567 0 2.9678 3 2.9596 1 2.9843 0 2.9925 1 1.4346
		1 3.0116 0 2.9733 2 3.0637 1 2.9706 0 1.1882 0 2.9733 1 1.2676
		2 2.9541 0 2.3874 0 1.2868 0 1.2813 2 2.7625 2 2.4504 4 2.8747
	Placebo	25	0 1.3771 11 3.0418 0 2.4312 3 3.1650 1 3.0034 2 2.9843 0 2.9651
		2 1.3087 5 3.0363 8 3.0691 2 2.9706 2 3.2553 4 2.9624 0 3.2060
		1 2.9596 7 3.0144 0 2.9569 2 2.9843 0 1.1937 3 3.0062 1 2.9870
		4 3.0089 1 1.2621 1 2.9788 5 2.8556
	;

	ods html;
	proc genmod data=fractures;
		class treat;
		model y = treat / dist=poisson link=log offset=logz pscale;
		estimate 'Placebo   ' int 1 treat 0  1; 
		estimate 'Active    ' int 1 treat 1  0;
		estimate 'Rate Ratio'       treat 1 -1;
		title '*** Vertebral Fracture Data, Poisson Quasi-likelihood Model ***';
	run;
	ods html close;








	*--- Chapter 3: Program 3.6 Williams 1992 Example using PROC LOGISTIC;

	/*
		Williams (1982) analysis using seed germination data in Crowder (1978)

		type_seed    = 0 corresponds to O. aegyptiaca 75    
		type_seed    = 1 corresponds to O. aegyptiaca 73    
		root_extract = 0 corresponds to Beans
		root_extract = 1 corresponds to Cucumbers
	*/

	data seeds;
		input type_seed root_extract t m;
		datalines;
		0	0	10	39
		0	0	23	62
		0	0	23	81
		0	0	26	51
		0	0	17	39
		0	1	5	6
		0	1	53	74
		0	1	55	72
		0	1	32	51
		0	1	46	79
		0	1	10	13
		1	0	8	16
		1	0	10	30
		1	0	8	28
		1	0	23	45
		1	0	0	4
		1	1	3	12
		1	1	22	41
		1	1	15	30
		1	1	32	51
		1	1	3	7
	;

	ods html;
	proc logistic data=seeds;
		model t/m = type_seed root_extract type_seed*root_extract / scale=none;
		output out=out1 predicted=pi_hat; 
		title "Full Model With SCALE=NONE";
	run;
	 
	proc logistic data=seeds;
		model t/m = type_seed root_extract type_seed*root_extract / scale=williams;
		output out=out1 predicted=pi_hat; 
		title "Full Model With SCALE=WILLIAMS";
	run;
	   
	proc means mean data=out1;
		class type_seed root_extract;
		var pi_hat;
	run;
	ods html close;






	*--- Chapter 4: Program 4.1 MLE Skellam;

	/*
		Maximum Likelihood Estimation Skellam's (1948) Chromosome Data Example
		under the following distributions:
		Binomial, Beta-binomial, Random-clumped Binomial, Zero-inflated Binomial 
		and a Generalized-Binomial Distribution with Additive Interaction
	*/	

	data chromosome;
		m = 3;
		input t freq;
		n + freq;
		if _n_ = 4 then 
			call symput('n',trim(left(n)));	*--- "n" is total number of clusters;
		drop n;
	datalines;
	0  32
	1 103
	2 122
	3  80
	;

	ods html;
	title 'Binomial Distribution';
	proc nlmixed data=chromosome;
		parms Pi=0.4 0.5 0.6;
		z   = lgamma(m+1) - lgamma(t+1) - lgamma(m-t+1);
		pic = 1 - pi;
		ll  = freq * (z + t*log(pi) + (m-t)*log(pic));
		model t ~ general(ll);
		predict &n * exp(z + t*log(pi) + (m-t)*log(pic)) out=pred1;
	run;

	title 'Beta-Binomial Distribution';
	proc nlmixed data=chromosome;
		parms Pi=0.4 0.5 0.6, Rho=0.2 0.3 0.4;
		bounds 0 < rho < 1;
		c   = 1 / rho / rho - 1;
		z   = lgamma(m+1) - lgamma(t+1) - lgamma(m-t+1);
		pic = 1 - pi;
		ll  = freq * (z + lgamma(c) + lgamma(t+c*pi) + lgamma(m-t+c*pic)
		 	- lgamma(m+c) - lgamma(c*pi) - lgamma(c*pic));
		model t ~ general(ll);
		predict &n * exp(z + lgamma(c) + lgamma(t+c*pi) + lgamma(m-t+c*pic)
			- lgamma(m+c) - lgamma(c*pi) - lgamma(c*pic)) out=pred2;
	run;

	title 'Random-clumped Binomial Distribution';
	proc nlmixed data=chromosome;
		parms Pi=0.4 0.5 0.6, Rho=0.2 0.3 0.4;
		bounds 0 < rho < 1;
		z   = lgamma(m+1) - lgamma(t+1) - lgamma(m-t+1);
		pic = 1 - pi;
		p1  = (1 - rho)*pi + rho;
		p1c = 1 - p1;
		p2  = p1 - rho;
		p2c = 1 - p2;
		ll  = freq * (z + log( pi*p1**t*p1c**(m-t) + pic*p2**t*p2c**(m-t) ));
		model t ~ general(ll);
		predict &n * exp(z + log( pi*p1**t*p1c**(m-t) + pic*p2**t*p2c**(m-t) ))
                out=pred3;
	run;

	title 'Zero-Inflated Binomial Distribution';
	proc nlmixed data=chromosome;
		parms Pi=0.4 0.5 0.6, Rho=0.2 0.3 0.4;
		bounds 0 < rho < 1;
		theta = rho * rho;
		z     = lgamma(m+1) - lgamma(t+1) - lgamma(m-t+1);
		p     = pi + theta * (1-pi);
		pc    = 1 - p;
		w     = pi / p;
		wc    = 1 - w;
		ll    = freq * log(exp(z + log(w) + t*log(p) + (m-t)*log(pc)) + wc*(t=0));
		model t ~ general(ll);
		predict &n * (exp(z + log(w) + t*log(p) + (m-t)*log(pc)) + wc*(t=0))
                out=pred4;
	run;

	title 'Generalized-Binomial Distribution -- Additive Interaction';
	proc nlmixed data=chromosome;
		parms Pi=0.4 0.5 0.6, Rho=0.2 0.3 0.4;
		alpha = rho * rho;
		z     = lgamma(m+1) - lgamma(t+1) - lgamma(m-t+1);
		pic   = 1 - pi;
		ll    = freq * (z + t*log(pi) + (m-t)*log(pic) + log( alpha/2*( t*(t-1)/pi 
			+ (m-t)*(m-t-1)/pic) - alpha*m*(m-1)/2 + 1));
		model t ~ general(ll);
		predict &n * exp(z + t*log(pi) + (m-t)*log(pic) + log( alpha/2*( t*(t-1)/pi 
			+ (m-t)*(m-t-1)/pic) - alpha*m*(m-1)/2 + 1) ) out=pred5;
	run;
	ods html close;








	*--- Chapter 4: Program 4.2 GOF Chromosome Example;
		
		*--------------------------------------------------------*
		| This Macro performs a Pearson's GOF Test               |
		| Skellam's (1948) Chromosome Data Example               |
		|  data = data set containing the variables Obs and Pred |
		|    df = degrees of freedom                             |
		| title = Distribution being fit                         |
		*--------------------------------------------------------*;

		%macro gof(data,df,title); 
		proc iml;
			use &data;
			read all var{freq} into Observed;
			read all var{Pred} into Predicted;

			gof    = sum( Observed # Observed / Predicted ) - &n;
			pvalue = 1 - probchi( gof,&df,0 );

			Summary      = j(3,1,0);
			Summary[1,1] = gof;
			Summary[2,1] = &df;
			Summary[3,1] = pvalue;

			label = { 'Pearson''s GOF Test', 
			          'Degrees of Freedom', 
			           'P-value'};
			print &title;
			print Observed Predicted[format=10.4];
			print Summary[rowname=label format=10.4];
		quit;
		%mend gof;

		ods html;
		%gof(pred1,2,'Binomial Distribution');
		%gof(pred2,1,'Beta-binomial Distribution');
		%gof(pred3,1,'Random-clumped Binomial Distribution');
		%gof(pred4,1,'Zero-Inflated Binomial Distribution');
		%gof(pred5,1,'Generalized-Binomial Distribution -- Additive Interaction');
		ods html close;







	*--- Chapter 4: Program 4.3 Plots and Moments BB and RCB Distributions;

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







	*--- Chapter 4: Programs 4.4 and 4.5 MLE Beta binomial Random clumped Ossification Example;

	/* 
		Ossification Example from Morel and Neerchal (1997), 
		Statistics in Medicine, 16, 2843-2853
	*/

	data ossification;
	   length tx $8;
	   input tx$ n @@;
	   do i=1 to n;
	      input t m @@;
		  m_t = m - t;
	      output;
	   end;
	   drop n i;
	   datalines;
	Control  18 8 8 9  9  7  9 0  5 3  3 5 8 9 10 5 8 5 8 1 6 0 5
	            8 8 9 10  5  5 4  7 9 10 6 6 3  5 
	Control  17 8 9 7 10 10 10 1  6 6  6 1 9 8  9 6 7 5 5 7 9
	            2 5 5  6  2  8 1  8 0  2 7 8 5  7
	PHT      19 1 9 4  9  3  7 4  7 0  7 0 4 1  8 1 7 2 7 2 8 1 7
	            0 2 3 10  3  7 2  7 0  8 0 8 1 10 1 1
	TCPO     16 0 5 7 10  4  4 8 11 6 10 6 9 3  4 2 8 0 6 0 9
	            3 6 2  9  7  9 1 10 8  8 6 9
	PHT+TCPO 11 2 2 0  7  1  8 7  8 0 10 0 4 0  6 0 7 6 6 1 6 1 7
	;

	ods html;
	title "Binomial Distribution, Full Model on the Betas";
	proc nlmixed data=ossification;
	   parms b0=0, b1=0, b2=0, b3=0;
	   if (tx='Control')       then linp = b0;
	   else if (tx='TCPO')     then linp = b0+b1;
	   else if (tx='PHT')      then linp = b0+b2; 
	   else if (tx='PHT+TCPO') then linp = b0+b1+b2+b3;
	   pi = 1/(1+exp(-linp));
	   model t ~ binomial( m,pi );
	   estimate 'Pi  Control'  1/(1+exp(-b0));
	   estimate 'Pi  TCPO'     1/(1+exp(-b0-b1));
	   estimate 'Pi  PHT'      1/(1+exp(-b0-b2));
	   estimate 'Pi  PHT+TCPO' 1/(1+exp(-b0-b1-b2-b3));
	   estimate 'Logarithm Odds-Ratio PHT Vs Control when TCPO Absent ' b2; 
	   estimate 'Logarithm Odds-Ratio PHT Vs Control when TCPO Present' b2+b3; 
	run;

	title "Beta-binomial Distribution, Full Model on the Betas, Common Rho";
	proc nlmixed data=ossification;
	   parms b0=0, b1=0, b2=0, b3=0, a0=0;
	   linr = a0;
	   rho = 1/(1+exp(-linr));
	   c   = 1 / rho / rho - 1;
	   if (tx='Control')       then linp = b0;
	   else if (tx='TCPO')     then linp = b0+b1;
	   else if (tx='PHT')      then linp = b0+b2; 
	   else if (tx='PHT+TCPO') then linp = b0+b1+b2+b3;
	   pi  = 1/(1+exp(-linp));
	   pic = 1 - pi;
	   z   = lgamma(m+1) - lgamma(t+1) - lgamma(m_t+1);
	   ll  = z + lgamma(c) + lgamma(t+c*pi) + lgamma(m_t+c*pic)
	         - lgamma(m+c) - lgamma(c*pi) - lgamma(c*pic);
	   model t ~ general(ll);
	   estimate 'Pi  Control'    1/(1+exp(-b0));
	   estimate 'Pi  TCPO'       1/(1+exp(-b0-b1));
	   estimate 'Pi  PHT'        1/(1+exp(-b0-b2));
	   estimate 'Pi  PHT+TCPO'   1/(1+exp(-b0-b1-b2-b3));
	   estimate 'Logarithm Odds-Ratio PHT Vs Control when TCPO Absent ' b2; 
	   estimate 'Logarithm Odds-Ratio PHT Vs Control when TCPO Present' b2+b3; 
	   estimate 'Common Rho*Rho' 1/(1+exp(-a0))/(1+exp(-a0));
	run;

	title "Random-clumped Binomial Distribution, Full Model on the Betas, Common Rho";
	proc nlmixed data=ossification;
	   parms b0=0, b1=0, b2=0, b3=0, a0=0;
	   linr = a0;
	   rho  = 1/(1+exp(-linr));
	   if (tx='Control')       then linp = b0;
	   else if (tx='TCPO')     then linp = b0+b1;
	   else if (tx='PHT')      then linp = b0+b2; 
	   else if (tx='PHT+TCPO') then linp = b0+b1+b2+b3;
	   pi  = 1/(1+exp(-linp));
	   pic = 1 - pi;
	   p1  = ( 1 - rho )*pi + rho;
	   p1c = 1 - p1;
	   p2  = p1 - rho;
	   p2c = 1 - p2;
	   z   = lgamma(m+1) - lgamma(t+1) - lgamma(m_t+1);
	   ll  = z + log( pi*p1**t*p1c**m_t  +  pic*p2**t*p2c**m_t );
	   model t ~ general( ll );
	   estimate 'Pi  Control'    1/(1+exp(-b0));
	   estimate 'Pi  TCPO'       1/(1+exp(-b0-b1));
	   estimate 'Pi  PHT'        1/(1+exp(-b0-b2));
	   estimate 'Pi  PHT+TCPO'   1/(1+exp(-b0-b1-b2-b3));
	   estimate 'Logarithm Odds-Ratio PHT Vs Control when TCPO Absent ' b2; 
	   estimate 'Logarithm Odds-Ratio PHT Vs Control when TCPO Present' b2+b3; 
	   estimate 'Common Rho*Rho' 1/(1+exp(-a0))/(1+exp(-a0));
	run;
	ods html close;


	ods html;
	title "Beta-binomial, Full Model on the Betas, Full Model on the Alphas";
	proc nlmixed data=ossification cov;
	   parms b0=0, b1=0, b2=0, b3=0, a0=0, a1=0, a2=0, a3=0;
	   if (tx='Control')       then linr = a0;
	   else if (tx='TCPO')     then linr = a0+a1;
	   else if (tx='PHT')      then linr = a0+a2;
	   else if (tx='PHT+TCPO') then linr = a0+a1+a2+a3;
	   rho = 1/(1+exp(-linr));
	   c   = 1 / rho / rho - 1;
	   if (tx='Control')       then linp = b0;
	   else if (tx='TCPO')     then linp = b0+b1;
	   else if (tx='PHT')      then linp = b0+b2; 
	   else if (tx='PHT+TCPO') then linp = b0+b1+b2+b3;
	   pi  = 1/(1+exp(-linp));
	   pic = 1 - pi;
	   z   = lgamma(m+1) - lgamma(t+1) - lgamma(m-t+1);
	   ll  = z + lgamma(c)   + lgamma(t+c*pi) + lgamma(m-t+c*pic)
	         -  lgamma(m+c) - lgamma(c*pi)   - lgamma(c*pic);
	   model t ~ general(ll);
	   estimate 'Pi  Control'      1/(1+exp(-b0));
	   estimate 'Pi  TCPO'         1/(1+exp(-b0-b1));
	   estimate 'Pi  PHT'          1/(1+exp(-b0-b2));
	   estimate 'Pi  PHT+TCPO'     1/(1+exp(-b0-b1-b2-b3));
	   estimate 'Logarithm Odds-Ratio PHT Vs Control when TCPO Absent ' b2; 
	   estimate 'Logarithm Odds-Ratio PHT Vs Control when TCPO Present' b2+b3; 
	   estimate 'Rho*Rho Control'  1/(1+exp(-a0))/(1+exp(-a0));
	   estimate 'Rho*Rho TCPO'     1/(1+exp(-a0-a1))/(1+exp(-a0-a1));
	   estimate 'Rho*Rho PHT'      1/(1+exp(-a0-a2));
	   estimate 'Rho*Rho PHT+TCPO' 1/(1+exp(-a0-a1-a2-a3))/(1+exp(-a0-a1-a2-a3));
	run;

	title "Random-clumped Binomial, Full Model on the Betas, Full Model on the Alphas";
	proc nlmixed data=ossification cov;
	   parms b0=0, b1=0, b2=0, b3=0, a0=0, a1=0, a2=0, a3=0;
	   if (tx='Control')       then linr = a0;
	   else if (tx='TCPO')     then linr = a0+a1;
	   else if (tx='PHT')      then linr = a0+a2;
	   else if (tx='PHT+TCPO') then linr = a0+a1+a2+a3;
	   rho = 1/(1+exp(-linr));
	   if (tx='Control')       then linp = b0;
	   else if (tx='TCPO')     then linp = b0+b1;
	   else if (tx='PHT')      then linp = b0+b2; 
	   else if (tx='PHT+TCPO') then linp = b0+b1+b2+b3;
	   pi  = 1/(1+exp(-linp));
	   pic = 1 - pi;
	   p1  = ( 1 - rho )*pi + rho;
	   p1c = 1 - p1;
	   p2  = p1 - rho;
	   p2c = 1 - p2;
	   z   = lgamma(m+1) - lgamma(t+1) - lgamma(m_t+1);
	   ll  = z + log( pi*p1**t*p1c**m_t  +  pic*p2**t*p2c**m_t );
	   model t ~ general( ll );
	   estimate 'Pi  Control'      1/(1+exp(-b0));
	   estimate 'Pi  TCPO'         1/(1+exp(-b0-b1));
	   estimate 'Pi  PHT'          1/(1+exp(-b0-b2));
	   estimate 'Pi  PHT+TCPO'     1/(1+exp(-b0-b1-b2-b3));
	   estimate 'Logarithm Odds-Ratio PHT Vs Control when TCPO Absent ' b2; 
	   estimate 'Logarithm Odds-Ratio PHT Vs Control when TCPO Present' b2+b3; 
	   estimate 'Rho*Rho Control'  1/(1+exp(-a0))/(1+exp(-a0));
	   estimate 'Rho*Rho TCPO'     1/(1+exp(-a0-a1))/(1+exp(-a0-a1));
	   estimate 'Rho*Rho PHT'      1/(1+exp(-a0-a2));
	   estimate 'Rho*Rho PHT+TCPO' 1/(1+exp(-a0-a1-a2-a3))/(1+exp(-a0-a1-a2-a3));
	run;
	ods html close;







	*--- Chapter 4: Program 4.6 Generation data under Beta-binomial and Random-clumped Binomial Distributions;

	/*
		Generation of data under the Beta-binomial and Random-clumped Binomial distributions
		with parameters Pi, Rho and m
	*/

	%macro bb_rcb_data(pi,rho,m,n,seed);

	*--- Generation data under the Beta-binomial distribution;
	data bb;
		format Dist $3.;
		Dist = "BB";
		seed = &seed;
		c = 1/&rho/&rho - 1;
		a = c * &pi;
		b = c - a;
		do cluster=1 to &n;
			y1 = rangam(seed, a);
			y2 = rangam(seed, b);
			p  = y1/(y1+y2); 
			t  = ranbin(seed,&m,p); 
			output ;
		end ;
	keep Dist t;
	run;

	*--- Generation data under the Random-clumped Binomial distribution;
	data rcb;
		Dist = "RCB";
		seed = &seed;
		do cluster=1 to &n;
			y  = ranbin(seed, 1,&pi) ;
			nn = ranbin(seed,&m,&rho) ;
			t  = y * nn ; *--- Random clumpling of the data;
			if nn < &m then t = t + ranbin(seed,&m - nn,&pi) ;
			output ;
		end ;
	keep Dist t;
	run;

	data bb_rcb;
		set bb rcb;
	run;

	ods html;
	title1 "Estimated Mean and Variance";
	title2 "Data generated from the Beta-binomial and Random-clumped Binomial distributions";
	title3 "with parameters Pi=&pi, Rho=&rho and m=&m";
	proc means data=bb_rcb mean var maxdec=4;
		class Dist;
		var t;
	run;
	ods html close;

	%mend bb_rcb_data;

	%bb_rcb_data(0.4, 0.7, 12, 20000, 1920);







	*--- Chapter 5: Program 5.1 Tarone 1979 Two-sided GOF Test;

	/* 
		Tarone (1979) Two-sided GOF test
		H0:Binomial Distribution Versus
		H1:Generalized Binomial Distribution with Additive Interaction (Altham, 1978) 
		Altham's model was simultaneously proposed by Kupper and Haseman (1978) 
		and termed “Correlated Binomial Model”
		Data below were taken from Kupper and Haseman (1978, page 75) 

	*/

	data kupper_haseman;
		input t m;
		datalines;
		0 5
		2 5
		1 7
		0 8
		2 8
		3 8
		0 9
		4 9
		1 10
		6 10
		;

	ods select none;
	ods output Ratio=Ratio;
	proc surveymeans data=kupper_haseman;
		ratio t/m;
	run;
	ods select all;

	data Ratio;
		set Ratio;
		call symput('Pi',trim(left(Ratio)));
	run;

	data out1;
	set kupper_haseman;
		pi      = &Pi;
		pic     = 1 - pi;
		pipic   = pi * pic;
		mpi     = m * pi;
		t_mpi   = t - mpi;
		pit_mpi = pi * t_mpi;
		tpic    = t * pic;
		mm_1    = m * (m-1);
		aux     = ( t_mpi*t_mpi + pit_mpi - tpic ) / pipic;
	keep aux mm_1; 
	run;

	proc means data=out1 sum noprint;
		var aux mm_1;
		output out=out2 sum=aux mm_1;
	run; 

	data out2;
	set out2;
		label X2   = "GOF Test";
		label PVal = "P-Value";
		format X2 8.2 Pval pvalue6.;
		x2  = aux / sqrt( 2*mm_1 );
		x2  = x2 * x2;
		pval = 1 - probchi(x2,1,0);
	run;

	ods html;
	title "Tarone (1979) GOF Test";
	proc print data=out2 noobs label;
		var x2 pval;
	run;
	ods html close;







	*--- Chapter 5: Program 5.2 Dean 1992 Test of Overdispersion Toxoplasmosis Example;

	/* 
		Score Test Statistic, Dean (1992)
		H0:Binomial Distribution Versus
		H1:Beta-binomial or similar distribution such as 
	    the Random-clumped Binomial
		as far as Bernoulli outcomes are positively correlated 

		Toxoplasmosis in 34 cities of El Salvador
		Example from Efron (1978, 1986)
	*/

	data toxoplasmosis;
		input t m rain;
		z = rain;
		datalines;
		2	4	1735
		3	10	1936
		1	5	2000
		3	10	1973
		2	2	1750
		3	5	1800
		2	8	1750
		7	19	2077
		3	6	1920
		8	10	1800
		7	24	2050
		0	1	1830
		15	30	1650
		4	22	2200
		0	1	2000
		6	11	1770
		0	1	1920
		33	54	1770
		4	9	2240
		5	18	1620
		2	12	1756
		0	1	1650
		8	11	2250
		41	77	1796
		24	51	1890
		7	16	1871
		46	82	2063
		9	13	2100
		23	43	1918
		53	75	1834
		8	13	1780
		3	10	1900
		1	6	1976
		23	37	2292
		;

	proc stdize data=toxoplasmosis out=toxoplasmosis;
		var z;
	run;

	ods select none;
	proc glimmix data=toxoplasmosis;
		model t/m = z z*z z*z*z / link=logit dist=bin s;
		output out=pdata pred(noblup ilink) = pi;
	run;
	ods select all;

	data pdata;
	set pdata;
		pic     = 1 - pi;
		pipic   = pi * pic;
		mpi     = m * pi;
		t_mpi   = t - mpi;
		pit_mpi = pi * t_mpi;
		tpic    = t * pic;
		mm_1    = m * (m-1);
		aux     = ( t_mpi*t_mpi + pit_mpi - tpic ) / pipic;
	keep aux mm_1; 
	run;

	proc means data=pdata sum noprint;
		var aux mm_1;
		output out=new sum=aux mm_1;
	run; 

	data new;
	set new;
		label Z    = "GOF Test";
		label PVal = "P-Value";
		format Z 8.2 Pval pvalue6.;
		z    = aux / sqrt( 2*mm_1 );
		pval = 1 - probnorm( z );
	run;

	ods html;
	title "Score Test Statistic, Dean (1992)";
	proc print data=new noobs label;
		var z pval;
	run;
	ods html close;







	*--- Chapter 5: Module "GOF_BB";

	**************************************************************************************
	  Author:			Santosh C Sutradhar
						Associate Director
						Pfizer Inc.
						235 East 42nd St
						New York, NY 10017
						Phone: (212) 733-0496
						Email: Santosh.Sutradhar@pfizer.com

	  Last Modified:	Sep 24, 2009

	  Purpose: 		To write a SAS MACRO in order to compute MLE
					and perform an GOF-test under Beta Binomial distribution.
					This GOF_BB() SAS Macro computes the MLE iteratively 
                    using the Fisher-Scoring method based on Direct Likelihood 

	  Required:		To call other module in file fisherbb.sas

	  List of MACRO variables: 
	  		inds = input SAS data (MUST contains two variables t, m) 
			t    = cluster count 
			m    = cluster size 

	  Usage:	%GOF_BB(inds=HS,t=t,m=m, title2=HS data set)

	  Comment: 	Varying cluster sizes (m) were assumed 
				Initial number of classes to form GOF = MAX(m's) + 1
	****************************************************************************************;

	%macro GOF_BB(inds = , t=, m=, title2 = "Data: ");

	title1 "Goodness-of-fit test under Beta Binomial distribution";
	title2 "&title2";

	****************************************;
	*       Starting IML procedure;
	****************************************;

	proc iml;

	*	Print input information;
	file print;

	**********************************************************************;
	*   Module: FISHERBB: This module can be called to 
	*           Compute Fisher information under BB distribution;
	**********************************************************************;
	start FISHERBB;
	do ijk = 1 to size_mj;
		AH = j(2,2,0);

		do i = 1 to mj[ijk]+1;
			u     = i-1;
			mct   = exp(lgamma(mj[ijk]+1)-lgamma(u+1)-lgamma(mj[ijk]-u+1));
			part1 = exp(lgamma(c)-lgamma(mj[ijk]+c));
			part2 = exp(lgamma(u+c*pi)-lgamma(c*pi));
			part3 = exp(lgamma(mj[ijk]-u+c*(1-pi))-lgamma(c*(1-pi)));

           	pt   = (mct*part1*part2*part3);

            aux3 = 0;
            aux2 = 0;
            aux1 = 0;

            aux3 = sum(1/(c:(c + mj[ijk] - 1)));
            if (u > 0) then aux1 = sum( 1/(cpi:(cpi + u -1)));
            if (u < mj[ijk]) then aux2 = sum(1/(cpic:(cpic + mj[ijk] - u -1)));

            derbb1 = c*(aux1 - aux2);
            derbb2 = (pi*aux1 + pic*aux2 - aux3)*b;
			
		*	Compute Fisher information for each different mj;

			AH[1,1] = AH[1,1] + derbb1*derbb1*pt; 
			AH[1,2] = AH[1,2] + derbb1*derbb2*pt;
			AH[2,2] = AH[2,2] + derbb2*derbb2*pt;  
		end;	*	end of t = 1 to m do loop;

		AH[2,1]=AH[1,2];
		FIMBB = FIMBB + fj[ijk]*AH;
	end;	*	End of ijk=1 to R do loop;
	finish FISHERBB;
	*	End of Module:		FISHERBB;

	*	Read the input data set with variables: t and; 
	use &inds var {&t &m};
		read all into y;
	close &inds;

	n       = nrow(y);
	t       = y[,1];
	m       = y[,2];
	mj      = unique(m)`;
	size_mj = nrow(mj);
	fj = repeat(0,size_mj,1);

	do j = 1 to size_mj;
	   fj[j] = sum(m=mj[j]);
	end;

	*   Distribution of mj;
	print 'Distribution of Cluster Size (m)';
	print mj[label='Cluster Size(m)'] fj[label='Frequency'];

    ***************************************************************************;
    *   ML estimation of parameters using ungrouped likelihood. ;
    *   Sum of the Logarithm of the likelihood (-ve) for Beta Binomial;
    ***************************************************************************;

    pi = sum(t[*])/sum(m[*]);

	if (pi = 0 | pi = 1) then pi = (sum(t[*]) + 1)/(sum(m[*]) + 2);

    num   = n*(t-m*pi)[##];
    denum = ((n-1)*pi*(1-pi));
    mm    = m#(m-j(n,1,1));
    if  ((num/denum - sum(m[*]))/(sum(mm[*])) > 0) then 
        rho = sqrt((num/denum - sum(m[*]))/(sum(mm[*]))); else rho = 0.01;

	*	Initialization of parameters;
	rho2    = rho*rho;
	stop1   = 0;
	beta    = j(2,1,0);
	beta[1] = pi;
	beta[2] = rho;
	eps1    = 10**(-6);
	eps2    = 10**(-8);
	iterate = 1;

	*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;
	do while (stop1 <1); /* Continue until prespecified precision is achieved*/
	*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;

    pi  = beta[1];
    rho  = beta[2];
    pic  = 1-pi;
    rhoc = 1-rho;
    c    = 1/rho/rho -1;
    cpi  = pi*c;
    cpic = c*pic;
    b    = -2/(rho**3);

    logbb = 0;
    grad  = j(2,1,0);

	*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO;
	do j = 1 to n;  *   Looping for all observations 1-n ;
	*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO;

 		m1 = m[j];
		k1 = t[j];

		mct = exp(lgamma(m1+1)-lgamma(k1+1)-lgamma(m1-k1+1));

		part1 = exp(lgamma(c)-lgamma(m1+c));
		part2 = exp(lgamma(k1+c*pi)-lgamma(c*pi));
		part3 = exp(lgamma(m1-k1+c*(1-pi))-lgamma(c*(1-pi)));

		logbb = logbb + log(mct*part1*part2*part3);
        logl  = -2*logbb;

    ***************************************************************;
    *   Compute gradient under Beta Binomial distribution;
    ***************************************************************;
        sum3 = 0;
        sum2 = 0;
        sum1 = 0;
 
		sum3 = sum(1/(c:(c+ m[j] - 1)));
        if (k1 > 0) then sum1 = sum(1/(cpi:(cpi + k1 -1)));
        if (k1 < m1) then sum2 = sum(1/(cpic:(cpic + m1 - k1 -1)));
    
        grad[1] = grad[1] + c*(sum1 - sum2);
        grad[2] = grad[2] + (pi*sum1 + pic*sum2 - sum3)*b;

	*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO;
    end;    *    Of looping for observations;
	*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO;

    *******************************************************************;
    *   Compute Fisher information under Beta Binomial distribution;
    *******************************************************************;

	FIMBB = j(2,2,0);
	RUN FISHERBB;
    INVBB    = inv(FIMBB);
    logl_old = logbb;
    add      = INVBB*grad;

    stop2 = 0;
    split = 1;

	*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;
	*To check if the loglikelihood is improved with the new estimates
	Otherwise modify the estimates by adding only part (by splitting) for improved estimate;
	do while (stop2 <1);
	*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;
    div = 2**(split-1);
    betan = beta + add/div;

    *   Checking for whether the estimates are in the range of parater space;

         if betan[1] < 0.0001 then betan[1] = 0.01;
    else if betan[1] > 0.9999 then betan[1] = 0.99;

         if betan[2] < 0.0001 then betan[2] = 0.01;
    else if betan[2] > 0.9999 then betan[2] = 0.99;

    *********************************************************************************;
    *   Compute logbb under new beta estimate and see whether there an improvement;
    *********************************************************************************;

	pi  = betan[1];
	rho  = betan[2];
	pic  = 1-pi;
	rhoc = 1-rho;
	c    = 1/rho/rho -1;
	cpi  = pi*c;
	cpic = c*pic;
	b    = -2/(rho**3);

	logbb = 0;

	do j = 1 to n;
		mct   = exp(lgamma(m[j]+1)-lgamma(t[j]+1)-lgamma(m[j]-t[j]+1));
		part1 = exp(lgamma(c) - lgamma(m[j]+c));
		part2 = exp(lgamma(t[j]+c*pi) - lgamma(c*pi));
		part3 = exp(lgamma(m[j]-t[j]+c*(1-pi)) - lgamma(c*(1-pi)));
        logbb = logbb + log(mct*part1*part2*part3);
	end;

    *******************************************************************;
    *   End of computation of new logbb under new beta estimate;
    *******************************************************************;

    if (logbb > logl_old | split >5) then stop2=1;
    split = split+1;

	*###################################;
	end;        *end of stop2 while loop;
	*###################################;

	if split>6 then stop1=1; else beta = betan;

    criteria = abs(logbb - logl_old)/abs(logl_old + eps1);
    if ( criteria < eps2 | iterate > 20) then stop1=1;
    iterate = iterate + 1;

	*###################################;
	end;        *end of stop1 while loop;
	*###################################;

	pi   = beta[1];
	rho  = beta[2];
	pic  = 1-pi;
	rhoc = 1-rho;
	c    = 1/rho/rho -1;
    cpi  = pi*c;
    cpic = c*pic;
    b    = -2/(rho**3);

	*******************************************************************;
	*	Final computation of  Fisher information under BB distribution; 
	*******************************************************************;

	FIMBB = j(2,2,0);
	RUN FISHERBB;
    INVBB  = inv(FIMBB);
    se_pi  = sqrt(INVBB[1,1]);
    se_rho = sqrt(INVBB[2,2]);

	est        = j(2,5,0);
	est[1,1:2] = (round(pi, 0.00001)||round(se_pi, 0.00001));
	est[2,1:2] = (round(rho, 0.00001)||round(se_rho, 0.00001));
	est[,3]    = round(est[,1]/est[,2], 0.0001);
	est[1,4]   = n-2;
	est[2,4]   = n-2;
	est[,5]    = 2*(1- PROBT(est[,3], est[,4]));
	if est[,5] < 0.0001 then est[,5] = 0.0001;
	vvv          = 2;
	fitStat      = j(4,1,0);
    fitStat[1,1] = -2*logbb;
    fitStat[2,1] = fitStat[1,1] + 2*vvv;                *--- AIC;
    fitStat[3,1] = fitStat[1,1] + 2*vvv*n / (n-vvv-1);  *--- AICC;
    fitStat[4,1] = fitStat[1,1] + vvv*log(n);           *--- BIC;

	************************************************************************;
	*   Compute expected frequency from BB and check for cell frequency >=5;
	*   and hence determine k;
	*************************************************************************;
	k    = max(mj) + 1;
    pic  = 1-pi;
    rhoc = 1-rho;
	c    = 1/rho/rho -1;

    *   Initialization;
    lowerb = j(k,1, -0.0000001);
    upperb = j(k,1,  1.0000001);

    expect = j(k, 1, 0);

    *   Define lower and upper bound for the intervals;
    do s = 2 to k;
        lowerb[s]   = (s-1)/k;
        upperb[s-1] = (s-1)/k;
    end;

    *   Compute Expected Counts under Beta Binomial Distribution;
	do s = 1 to k-1;
	expect[s] = 0;
		do j=1 to size_mj;
			probbb = 0;
			do it  = 0 to mj[j];
			ratio  = it/mj[j];
				if ((ratio > lowerb[s]) & (ratio <= upperb[s])) then do;
					aux    = lgamma(mj[j]+1)+lgamma(c)+lgamma(it+c*pi)+lgamma(mj[j]-it+c*(1-pi))
					       - lgamma(it+1)-lgamma(mj[j]-it+1)-lgamma(mj[j]+c)-lgamma(c*pi)-lgamma(c*(1-pi));
					probbb = probbb + exp(aux);
				end;
			end;
		expect[s] = expect[s] + fj[j]*probbb;
		probbb=0;
		end;
	end;
	expect[k] = n-sum(expect[1:k-1]);

	**************************************************************;
	*   CATEGORIES WITH EXPECTED FREQUENCIES SMALLER THAN 5 ARE ;
	*	COLLASPED WITH PRIOR CATEGORY;
	**************************************************************;
	do false = 1 to 1;	*	necessary for GOTO statement;

    class = k;
    index = 1;
	s     = 1;
    aux2  = j(k,1,0);
    aux4  = j(k,1,0);

	begin2:

    aux2[index] = expect[s];
    aux4[index] = upperb[s];

    do while(s < k);
        if (aux2[index] < 5) then do;
            s           = s+1;
            class       = class-1;
            aux2[index] = aux2[index] + expect[s];
            aux4[index] = upperb[s];
        end;
        else do;
            index = index + 1;
            s     = s+1;
           goto begin2;
        end;
    end;

    if (aux2[index] < 5) then do;
        class         = class-1;
        aux2[index-1] = aux2[index] + aux2[index-1];
    end;

	Lower          = j(class,1,0);
	Upper          = j(class,1,0);
	upper          = aux4[1:class];
	lower[2:class] = aux4[1:class-1];
	lower[1]       = -0.00001;
	upper[class]   =  1.00001;
	r              = class;
	expected       = aux2[1:class];

    **********************************************************************;
    *   Goodness of fit test under Beta Binomial distribution;
    **********************************************************************;

	*	Compute observed count;
    obs      = j(r, 1, 0);

	ratio = t/m;
    do s = 1 to r-1;
        obs[s] = sum( (ratio > lower[s]) & (ratio <= upper[s]) );
    end;

	obs[r]   = n - sum(obs[1:r-1]);
    lower[1] = 0;
    upper[r] = 1.0000;
	obs_sum  = sum(obs);
    exp_sum  = sum(expected);

	*   Compute the corresponding chi-square under Beta-binomial distribution;

	chisq  = 0;
    df     = r-3;
	chisq  = sum((obs-expected)##2/expected);
	chisq  = round( chisq, 0.0001);
    pvalue  = round((1- PROBCHI(chisq, df)), 0.0001);
	GOFStat = chisq ||df||pvalue;

	mattrib lower format=8.4;
	mattrib upper format=8.4;
	mattrib obs      label='Observed Frequency' format=8.0;
	mattrib expected label='Expected Frequency' format=8.4;

	mattrib n       label='No. of Clusters'      format=8.0;
	mattrib obs_sum label='Observed Frequencies' format=8.0;
	mattrib exp_sum label='Expected Frequencies' format=12.4;

	mattrib chisq  label='Chi-square' format=8.4;
	mattrib df     label='DF'         format=8.0;
	mattrib pvalue label='P-value'    format=8.4;

	mattrib est colname={'Estimate' 'Std-Error' 't-Value' 'DF' 'p-Value'} 
            label='Maximum Likelihood Estimates';
	mattrib fitStat rowname={'-2 Log Likelihood', 'AIC (smaller is better)', 
            'AICC (smaller is better)', 'BIC (smaller is better)'} 
            label='Fit Statistics' format=20.2;
	mattrib GOFStat colname={'GOF-Stat' 'DF' 'p-Value'}
            label='GOF Test Statistic';

	Label = { 'Parameter Pi' , 'Parameter Rho' };
	print fitStat;
	print est[rowname=label];
	print "Goodness-of-fit Test under Beta-binomial Distribution" ;
	print lower upper obs expected;
	print "Total Counts";
	print n obs_sum exp_sum;
	print "Null Hypothesis: Data are distributed according to a Beta-binomial Distribution";
	print GOFStat;

	*******************************************************;
	end;        *   End of group do loop;
	*******************************************************;

	*   Output Residuals (Observed - Expected) into data set Resid_BB needed later for QQ-Plots;

	Distribution = j(nrow(obs),1,'Beta-binomial ');
	Resid        = obs - expected;
	create Resid_BB var{ Distribution Resid };
	append;

	quit;
	title;
	title2;
	%mend GOF_BB;
	*	End of Macro GOF_fBB;

	*	Usage:;
	*%GOF_BB(inds=group2,t=t,m=m, title2=Group III Haseman and Soares (1976));







	*--- Chapter 5: Module "GOF_RCB";

	**************************************************************************************
	  Author:			Santosh C Sutradhar
						Associate Director
						Pfizer Inc.
						235 East 42nd St
						New York, NY 10017
						Phone: (212) 733-0496
						Email: Santosh.Sutradhar@pfizer.com

	  Last Modified:	Sep 16, 2009

	  Purpose: 		To write a SAS MACRO in order to compute MLE
					and perform GOF-test under Random-clumped Binomial distribution.
					This GOF_RCB() SAS Macro computes the MLE iteratively 
                    using the Fisher-Scoring method based on Direct Likelihood 

	  Required:		To call other module in file fisherfm.sas

	  List of MACRO variables: 
	  		inds = input SAS data (MUST contains three variables t, m, group - name may be different) 
			t = cluster count 
			m = cluster size 
			group = group variable

	  Usage:	%GOF_RCB(inds=HS,t=t,m=m, title2=HS data set)

	  Comment: 		Varying cluster sizes (m) were assumed 
					Initial number of classes to form GOF = MAX(m's) + 1
	***************************************************************************************;

	%macro GOF_RCB(inds= , t=, m=, title2 = "Data: ");

	title1 "Goodness-of-fit test under Random-clumped Binomial distribution";
	title2 "&title2";

	****************************************;
	*       Starting IML procedure;
	****************************************;

	proc iml;

	*	Print input information;
	file print;

	**********************************************************************;
	*   Module: FISHERRCB: This module can be called to 
	*           Compute Fisher information under RCB distribution;
	**********************************************************************;
	start FISHERRCB;
    do j = 1 to size_mj;
        mp1     = mj[j]*p1;
        mp2     = mj[j]*p2;
        derrcb1 = j(mj[j]+1, 1, 0);
        derrcb2 = j(mj[j]+1, 1, 0);
        AH      = j(2,2,0);

		x1        = (0:mj[j])`;
		m2        = mj[j] +1;
		pr1       = PROBBNML(p1,mj[j],x1);
		pr2       = PROBBNML(p2,mj[j],x1);
		pr1[2:m2] = pr1[2:m2] - pr1[1:(m2-1)];
		pr2[2:m2] = pr2[2:m2] - pr2[1:(m2-1)];

        do i = 1 to mj[j]+1;
            u  = i-1;
			pt = pi*pr1[i] + pic*pr2[i];
			if pt < 1e-10 then pt = 1e-10;
            b1 = u - mp1;
            b2 = u - mp2;
            a1 = c1*b1 + p1;
            a2 = c2*b2 - p2c;

            derrcb1[i] = (pr1[i] * a1/p1 + pr2[i]*a2/p2c);
            derrcb2[i] = (pr1[i] * b1*c3 - pr2[i]*b2*c4)/rhoc;

        *   Compute Fisher information for each different mj;
            AH[1,1] = AH[1,1] + derrcb1[i]*derrcb1[i]/pt;
            AH[1,2] = AH[1,2] + derrcb1[i]*derrcb2[i]/pt;
            AH[2,2] = AH[2,2] + derrcb2[i]*derrcb2[i]/pt;
        end;    *   end of t = 1 to m do loop;
        AH[2,1]=AH[1,2];
        FIMRCB  = FIMRCB + fj[j]*AH;
    end;    *   End of j=1 to size_mj do loop;
	finish FISHERRCB;
	*	End of Module:		FISHERRCB;

	*	Read the input data set with variables: t, m, and group; 
	use &inds var {&t &m};
		read all into y;
	close &inds;

	n       = nrow(y);
	t       = y[,1];
	m       = y[,2];
	mj      = unique(m)`;
	size_mj = nrow(mj);
	fj      = repeat(0,size_mj,1);

	do j = 1 to size_mj;
	   fj[j] = sum(m=mj[j]);
	end;

	*   Distribution of mj;
	print 'Distribution of Cluster Size (m)';
	print mj[label='Cluster Size (m)'] fj[label='Frequency'];

    ****************************************************************************;
    *   ML estimation of parameters using ungrouped likelihood. ;
    *   Sum of the Logarithm of the likelihood (-ve) for Random-clumped Binomial;
    ****************************************************************************;

	*	Moment estimate of the pi and rho to be used as an initial estimates;
    pi = sum(t[*])/sum(m[*]);

	if (pi = 0 | pi = 1) then pi = (sum(t[*]) + 1)/(sum(m[*]) + 2);

    num   = n*(t-m*pi)[##];
    denum = ((n-1)*pi*(1-pi));
    mm    = m#(m-j(n,1,1));
    if  ((num/denum - sum(m[*]))/(sum(mm[*])) > 0) then 
        rho = sqrt((num/denum - sum(m[*]))/(sum(mm[*]))); else rho = 0.01;

	*	Initilation of parameters;
	rho2    = rho*rho;
	stop1   = 0;
	beta    = j(2,1,0);
	beta[1] = pi;
	beta[2] = rho;
	eps1    = 10**(-6);
	eps2    = 10**(-8);
	iterate = 1;

	*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;
	do while (stop1 <1); /* Continue until prespecified precision is achieved*/
	*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;
	    pi    = beta[1];
	    rho   = beta[2];
	    pic   = 1-pi;
	    rhoc  = 1-rho;
	    pipic = pi*pic;
	    p2    = rhoc*pi;
	    p1    = p2 + rho;
		if p1 >= 1 then p1 = 0.99;
	    p1c = 1-p1;
	    p2c = 1-p2;
	    c1  = pi/pic;
	    c2  = pic/pi;
	    c3  = pi/p1;
	    c4  = pic/p2c;
	
	    logrcb = 0;
	    grad   = j(2,1,0);
	
		*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO;
		    do j = 1 to n;  *   Looping for all observations 1-n ;
		*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO;
		 	if (t[j] = 0) then do;
			    pr1 = PROBBNML(p1,m[j],t[j]);
	    	    pr2 = PROBBNML(p2,m[j],t[j]);
	    	    pt  = pi*pr1 + pic*pr2;
    	    end;
    	    else  do;
    	        pr1 = PROBBNML(p1,m[j],t[j]) - PROBBNML(p1,m[j],t[j]-1);
    	        pr2 = PROBBNML(p2,m[j],t[j]) - PROBBNML(p2,m[j],t[j]-1);
    	        pt  = pi*pr1 + pic*pr2;
    	    end;
	
	       if pt < 1e-10 then pt = 1e-10;
	       logrcb = logrcb + log(pt);
	       logl   = -2*logrcb;

	    ***************************************************************;
	    *   Compute gradient under Random-clumped Binomial distribution;
	    ***************************************************************;
        b1 = t[j] - m[j]*p1;
        b2 = t[j] - m[j]*p2;
        a1 = c1*b1 + p1;
        a2 = c2*b2 - p2c;
        grad[1]= grad[1] + (pr1 * a1/p1 + pr2*a2/p2c)/pt;
        grad[2]= grad[2] + (pr1 * b1*c3 - pr2*b2*c4)/rhoc/pt;

		*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO;
	    end;    *    Of looping for observations;
		*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO;

    *************************************************************************;
    *   Compute Fisher information under Random-clumped Binomial distribution;
    *************************************************************************;

    FIMRCB = j(2,2,0);
	run FISHERRCB;
    INVRCB    = inv(FIMRCB);
    logl_old = logrcb;
    add      = INVRCB*grad;

    stop2 = 0;
    split = 1;

	*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;
	*To check if the loglikelihood is improved with the new estimates
	Otherwise modify the estimates by adding only part (by splitting) for improved estimate;
	do while (stop2 <1);
	*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;
	    div = 2**(split-1);
	    betan = beta + add/div;
	
    *   Checking for whether the estimates are in the range of parater space;

	         if betan[1] < 0.0001 then betan[1] = 0.01;
	    else if betan[1] > 0.9999 then betan[1] = 0.99;
	
	         if betan[2] < 0.0001 then betan[2] = 0.01;
	    else if betan[2] > 0.9999 then betan[2] = 0.99;
	
	    *********************************************************************************;
	    *   Compute logrcb under new beta estimate and see whether there an improvement;
	    *********************************************************************************;
	    pi    = betan[1];
	    rho   = betan[2];
	    pic   = 1-pi;
	    rhoc  = 1-rho;
	    pipic = pi*pic;
	    p2    = (1-rho)*pi;
	    p1    = p2 + rho;
		if p1 >= 1 then p1 = 0.99;
	    p1c = 1-p1;
	    p2c = 1-p2;
	    c1  = pi/pic;
	    c2  = pic/pi;
	    c3  = pi/p1;
	    c4  = pic/p2c;
	
	    logrcb = 0;
	
	    do j = 1 to n;
	        pr1=PROBBNML(p1,m[j],t[j]);
	        pr2=PROBBNML(p2,m[j],t[j]);
	
	        if (t[j] = 0) then do;
	            pt = (pi*pr1+pic*pr2);
	        end;
	        else  do;
	            pr1_1 = PROBBNML(p1,m[j],t[j]-1);
	            pr2_1 = PROBBNML(p2,m[j],t[j]-1);
	            pt    = (pi*(pr1 - pr1_1)+pic*(pr2 - pr2_1));
	        end;
    	   if pt < 1e-10 then pt = 1e-10;
    	    logrcb = logrcb + log(pt);
    	end;

    	*******************************************************************;
    	*   End of computation of new logrcb under new beta estimate;
    	*******************************************************************;
	
	    if (logrcb > logl_old | split >5) then stop2=1;
	    split = split+1;
	
		*###################################;
	    end;        *end of stop2 while loop;
		*###################################;

		if split>6 then stop1=1; else beta = betan;
	    criteria = abs(logrcb - logl_old)/abs(logl_old + eps1);
	    if ( criteria < eps2 | iterate > 20) then stop1=1;
	    iterate = iterate + 1;

	*###################################;
	end;        *end of stop1 while loop;
	*###################################;

    pi   = beta[1];
    rho  = beta[2];
    pic  = 1-pi;
    rhoc = 1-rho;
    p2   = rhoc*pi;
    p1   = p2 + rho;
	if p1 >= 1 then p1 = 0.99;
	p1c = 1-p1;
	p2c = 1-p2;
    c1  = pi/pic;
    c2  = pic/pi;
    c3  = pi/p1;
    c4  = pic/p2c;

    *******************************************************************;
    *   Final computation of  Fisher information under RCB distribution;
    *******************************************************************;

    FIMRCB = j(2,2,0);
	run FISHERRCB;
    INVRCB  = inv(FIMRCB);
    se_pi  = sqrt(INVRCB[1,1]);
    se_rho = sqrt(INVRCB[2,2]);

	est        = j(2,5,0);
	est[1,1:2] = (round(pi, 0.00001)||round(se_pi, 0.00001));
	est[2,1:2] = (round(rho, 0.00001)||round(se_rho, 0.00001));
	est[,3]    = round(est[,1]/est[,2], 0.0001);
	est[1,4]   = n-2;
	est[2,4]   = n-2;
	est[,5]    = 2*(1- PROBT(est[,3], est[,4]));
	if est[,5] < 0.0001 then est[,5] = 0.0001;
	vvv          = 2;
	fitStat      = j(4,1,0);
    fitStat[1,1] = -2*logrcb;
    fitStat[2,1] = fitStat[1,1] + 2*vvv;                *--- AIC;
    fitStat[3,1] = fitStat[1,1] + 2*vvv*n / (n-vvv-1);  *--- AICC;
    fitStat[4,1] = fitStat[1,1] + vvv*log(n);           *--- BIC;

	*************************************************************************;
	*   Compute expected frequency from RCB and check for cell frequency >=5;
	*   and hence determine r;
	*************************************************************************;
	k    = max(mj) + 1;
    pic  = 1-pi;
    rhoc = 1-rho;
    p2   = rhoc*pi;
    p1   = p2 + rho;
	if p1 >= 1 then p1 = 0.99;

    *   Initialization;
    lowerb = j(k,1, -0.0000001);
    upperb = j(k,1,  1.0000001);

    P = j(k, 1, 0);


    *   Define lower and upper bound for the intervals;
    do s = 2 to k;
        lowerb[s]   = (s-1)/k;
        upperb[s-1] = (s-1)/k;
    end;

    *   Compute Expected Counts under FRandom-clumped Binomial Distribution;
    do s = 1 to k-1;
		P[s] = 0;
		do j=1 to size_mj;
			probfm = 0;
			x1        = (0:mj[j])`;
			m2        = mj[j] +1;
			pr1       = PROBBNML(p1,mj[j],x1);
			pr2       = PROBBNML(p2,mj[j],x1);
			pr1[2:m2] = pr1[2:m2] - pr1[1:(m2-1)];
			pr2[2:m2] = pr2[2:m2] - pr2[1:(m2-1)];
			do it = 0 to mj[j];
				i = it + 1;
				ratio = it/mj[j];
				if ((ratio > lowerb[s]) & (ratio <= upperb[s])) then
					probfm = probfm + pi*pr1[i] + (1-pi)*pr2[i];
			end;
			P[s]   = P[s] + fj[j]*probfm;
			probfm = 0;
		end;
	end;
    P[k] = n-sum(P[1:k-1]);

	exp  = P;

	**************************************************************;
	*   CATEGORIES WITH EXPECTED FREQUENCIES SMALLER THAN 5 ARE ;
	*	COLLASPED WITH PRIOR CATEGORY;
	**************************************************************;
	do false = 1 to 1;	*	necessary for GOTO statement;
    class = k;
    index = 1;
     s    = 1;
    aux2  = j(k,1,0);
    aux4  = j(k,1,0);
	begin2:
    aux2[index] = exp[s];
	aux4[index] = upperb[s];
	    do while(s < k);
	        if (aux2[index] < 5) then do;
	            s = s+1;
	            class = class-1;
	            aux2[index] = aux2[index] + exp[s];
	            aux4[index] = upperb[s];
	        end;
	        else do;
	            index = index + 1;
	            s     = s+1;
	            goto begin2;
	        end;
	    end;
    if (aux2[index] < 5) then do;
        class         = class-1;
        aux2[index-1] = aux2[index] + aux2[index-1];
    end;

	Lower          = j(class,1,0);
	Upper          = j(class,1,0);
	upper          = aux4[1:class];
	lower[2:class] = aux4[1:class-1];
	lower[1]       = -0.00001;
	upper[class]   =  1.00001;
	r              = class;
	expected       = aux2[1:class];

	**********************************************************************;
    *   Goodness of fit test under Random-clumped Binomial distribution;
    **********************************************************************;

	*	Compute observed count;
	obs = j(r,1,0);

	ratio = t/m;
    do s = 1 to r-1;
        obs[s] = sum( (ratio > lower[s]) & (ratio <= upper[s]) );
    end;

	obs[r]   = n - sum(obs[1:r-1]);
    lower[1] = 0;
    upper[r] = 1.0000;
	obs_sum  = sum(obs);
	exp_sum  = sum(expected);

	*   Compute the corresponding chi-square under Random-clumped Binomial distribution;

	chisq   = 0;
    df      = r-3;
	chisq   = sum((obs-expected)##2/expected);
	chisq   = round( chisq, 0.0001);
    pvalue  = round((1- PROBCHI(chisq, df)), 0.0001);
	GOFStat = chisq ||df||pvalue;

	mattrib lower format=8.4;
	mattrib upper format=8.4;
	mattrib obs      label='Observed Frequency' format=8.0;
	mattrib expected label='Expected Frequency' format=8.4;

	mattrib n       label='No. of Clusters'      format=8.0;
	mattrib obs_sum label='Observed Frequencies' format=8.0;
	mattrib exp_sum label='Expected Frequencies' format=12.4;

	mattrib chisq  label='Chi-square' format=8.4;
	mattrib df     label='DF'         format=8.0;
	mattrib pvalue label='P-value'    format=8.4;

	mattrib est colname={'Estimate' 'Std-Error' 't-Value' 'DF' 'p-Value'} 
            label='Maximum Likelihood Estimates';
	mattrib fitStat rowname={'-2 Log Likelihood', 'AIC (smaller is better)', 
            'AICC (smaller is better)', 'BIC (smaller is better)'} 
            label='Fit Statistics' format=20.2;
	mattrib GOFStat colname={'GOF-Stat' 'DF' 'p-Value'}
            label='GOF Test Statistic';

	Label = { 'Parameter Pi' , 'Parameter Rho' };
	print fitStat;
	print est[rowname=label];
	print "Goodness-of-fit Test under Random-clumped Binomial Distribution";
	print lower upper obs expected;
	print "Total Counts";
	print n obs_sum exp_sum;
	print "Null Hypothesis: Data are distributed according to a Random-clumped Binomial Distribution";
	print GOFStat;

	*******************************************************;
	end;        *   End of group do loop;
	*******************************************************;
	
	*   Output Residuals (Observed - Expected) into data set Resid_RCB needed later for QQ-Plots;

	Distribution = j(nrow(obs),1,'Random-clumped');
	Resid        = obs - expected;
	create Resid_RCB var{ Distribution Resid };
	append;

	quit;
	title;
	title2;
	%mend GOF_RCB;  
	*	End of Macro;

	*	Usage:;
	*%GOF_RCB(inds=group2,t=t,m=m, title2=Group III Haseman and Soares (1976));






	*--- Chapter 5: Program 5.3 GOF Haseman and Soares 1976 Group III (n=554);

	/* 
		GOF Test for DataSet III on Neerchal and Morel (1998)
	    Source: Haseman and Soares (1976)
		This program uses "GOF_BB" and "GOF_RCB" Macros
	*/

	data haseman_soares;
		input m t1-t10;
		array tt t1-t10;
		do over tt;
		t    = _i_ - 1;
		freq = tt;
		output;
		end;
		keep m t freq;
		datalines;
		1	7	.	.	.	.	.	.	.	.	.
		2	7	.	.	.	.	.	.	.	.	.
		3	6	.	.	.	.	.	.	.	.	.
		4	5	2	1	.	.	.	.	.	.	.
		5	8	2	1	.	1	1	.	.	.	.
		6	8	.	.	.	.	.	.	.	.	.
		7	4	4	2	1	.	.	.	.	.	.
		8	7	7	1	.	.	.	.	.	.	.
		9	8	9	7	1	1	.	.	.	.	.
		10	22	17	2	.	1	.	.	1	1	.
		11	30	18	9	1	2	.	1	.	1	.
		12	54	27	12	2	1	.	2	.	.	.
		13	46	30	8	4	1	1	.	1	.	.
		14	43	21	13	3	1	.	.	1	.	1
		15	22	22	5	2	1	.	.	.	.	.
		16	6	6	3	.	1	1	.	.	.	.
		18	3	.	2	1	.	.	.	.	.	.
	;

	data haseman_soares;
		set haseman_soares;
		if freq = . then delete;
		do i=1 to freq;
			output;
		end;
		drop i freq;
	run;

	ods html;
	ods graphics on;

	%GOF_BB (inds=haseman_soares,t=t,m=m,title2=DataSet III -- Haseman and Soares (1976));
	%GOF_RCB(inds=haseman_soares,t=t,m=m,title2=Dataset III -- Haseman and Soares (1976));


	*--- Construct QQ Plots;
	data Resid_BB_RCB;
		set Resid_BB Resid_RCB;
	run;

	proc sort data=Resid_BB_RCB;
		by Distribution;
	run;

	proc rank data=Resid_BB_RCB out=new_qqplots normal=blom ties=mean;
		by Distribution;
		var Resid;
		ranks NQuant;
	run;

	proc sgpanel data=new_qqplots noautolegend;
		panelby Distribution;
		title1 "DataSet III -- Haseman and Soares (1976)";
		title2 "QQ-Plots of Residuals based on Observed and Expected Frequencies";
		label Resid="Residuals" NQuant="Normal Quantiles";
		reg x=Resid y=NQuant;
	run;

	ods graphics off;
	ods html close;






	*--- Chapter 5: Macro "GOF_BB_RCB";

/*
		Macro GOF_BB_RCB_Distributions

		Arguments:
		mydata	-- name of the data set containing the variables "t" and "m"
		title   -- description of the data being analyzed

		User needs to provide the estimated Pi's and Rho's for both 
		the Beta-binomial and Random-clumped Binomial models
		These files are denoted in this macro as "pi_bb" "rho_bb" "pi_rcb" and  "rho_rcb"
		and were obtained in the Hiroshima Chromosome Aberration Example using PROC NLMIXED
	*/

	*------------------------------------------- ;
	%macro GOF_BB_RCB_Distributions(mydata,title);
	*------------------------------------------- ;

	title &title;
	proc iml;

	*	Read input data set with variables: t and m; 
	use &mydata var {t m};
	read all into y;

	n       = nrow(y);
	t       = y[,1];
	m       = y[,2];
	mj      = unique(m)`;
	size_mj = nrow(mj);
	fj      = repeat(0,size_mj,1);

	do j = 1 to size_mj;
	   fj[j] = sum(m=mj[j]);
	end;

	*	Print distribution of mj;
	print 'Distribution of Cluster Size (m)';
	print mj[label='Cluster Size(m)'] fj[label='Frequency'];

	*-----------------------------------------------;
	*   Matrix attributes for matrices to be printed;
	*-----------------------------------------------;

	mattrib Lower format=8.4;
	mattrib Upper format=8.4;
	mattrib obs      label='Observed Frequency' format=8.0;
	mattrib expected label='Expected Frequency' format=8.2;

	mattrib n       label='No. of Clusters'      format=8.0;
	mattrib obs_sum label='Observed Frequencies' format=8.0;
	mattrib exp_sum label='Expected Frequencies' format=12.4;

	mattrib chisq   label='Chi-square' format=8.4;
	mattrib df      label='DF'         format=8.0;
	mattrib pvalue  label='P-value'    format=8.4;
	mattrib GOFStat colname={'GOF-Stat' 'DF' 'p-Value'}  
	                rowname={'Lower Bound DFs Results' 'Upper Bound DFs Results'}
            label='GOF Test Statistic';
	mattrib BoundsDF colname={'Results based on'};  

	*------------------------------------------;
	*   Define subroutines "collapse" and "gof";
	*------------------------------------------;

	*-----------------------------------------------------;
	start collapse(k,expect,upperb,r,lower,upper,expected);
	*-----------------------------------------------------;

	*   Categories with expected frequencies smaller than 5 are collapsed with prior category;

	do false = 1 to 1;	*   Necessary for GOTO statement;

	    class = k;
	    index = 1;
		s     = 1;
	    aux2  = j(k,1,0);
	    aux4  = j(k,1,0);

		begin2:

	    aux2[index] = expect[s];
	    aux4[index] = upperb[s];

	    do while(s < k);
		    if (aux2[index] < 5) then do;
			    s           = s+1;
			    class       = class-1;
			    aux2[index] = aux2[index] + expect[s];
			    aux4[index] = upperb[s];
		    end;
		    else do;
			    index = index + 1;
			    s     = s+1;
			    goto begin2;
		    end;
	    end;

	    if (aux2[index] < 5) then do;
		    class         = class-1;
		    aux2[index-1] = aux2[index] + aux2[index-1];
	    end;

		Lower          = j(class,1,0);
		Upper          = j(class,1,0);
		upper          = aux4[1:class];
		lower[2:class] = aux4[1:class-1];
		lower[1]       = -0.00001;
		upper[class]   =  1.00001;
		r              = class;
		expected       = aux2[1:class];

	end;        *   End of group do loop;

	*--------------;
	finish collapse;
	*--------------;

	*-------------------------------------------------------------------------;
	start gof(r,t,n,m,lower,upper,expected,nparms,obs,obs_sum,exp_sum,GOFStat);
	*-------------------------------------------------------------------------;
	
	*   Compute GOF test;
	
    obs   = j(r, 1, 0);   *   Observed counts;
	ratio = t/m;
    do s = 1 to r-1;
        obs[s] = sum( (ratio > lower[s]) & (ratio <= upper[s]) );
    end;
    obs[r]   = n - sum(obs[1:r-1]);
    lower[1] = 0;
    upper[r] = 1.0000;
    obs_sum  = sum(obs);
    exp_sum  = sum(expected);
	
	*   Compute the Chi-square statistics;
	
	chisq    = 0;
        df1      = r-1-nparms;     *--- Lower bound DFs;
        df2      = r-1;            *--- Upper bound DFs;
	chisq    = sum((obs-expected)##2/expected);
	chisq    = round( chisq, 0.0001);
        pvalue   = round((1- PROBCHI(chisq, df1)), 0.0001);
	if pvalue < 0.0001 then pvalue = 0.0001;
	GOFStat1 = chisq ||df1||pvalue;
        pvalue   = round((1- PROBCHI(chisq, df2)), 0.0001);
	if pvalue < 0.0001 then pvalue = 0.0001;
	GOFStat2 = chisq ||df2||pvalue;
	GOFStat  = GOFStat1 // GOFStat2;
	
	*---------;
	finish gof;
	*---------;
	
	*******************************************************;
	*	1) Begins GOF Test under Beta-binomial distribution;
	*******************************************************;
	
	use pi_bb var {Pred};
	read all into pii;
	use rho_bb var {Pred};
	read all into rhoo;
	
	*   Compute expected frequency for Beta-binomial distribution;
	k    = max(mj) + 1;

    *   Initialization;
    lowerb = j(k,1, -0.0000001);
    upperb = j(k,1,  1.0000001);
	
    expect = j(k, 1, 0);

    *   Define lower and upper bound for the intervals;
    do s = 2 to k;
        lowerb[s]   = (s-1)/k;
        upperb[s-1] = (s-1)/k;
    end;
	
	do s = 1 to k-1;
	expect[s] = 0;
	do j=1 to n;
	pi   = pii[j];
	rho  = rhoo[j];
	pic  = 1-pi;
    rhoc = 1-rho;
	c    = 1/rho/rho -1;

		probbb = 0;
		do it  = 0 to m[j];
		ratio  = it/m[j];
 
		if ((ratio > lowerb[s]) & (ratio <= upperb[s])) then do;
			aux    = lgamma(m[j]+1) + lgamma(c) + lgamma(it+c*pi) + lgamma(m[j]-it+c*(1-pi))
			       - lgamma(it+1) - lgamma(m[j]-it+1) - lgamma(m[j]+c) 
                              - lgamma(c*pi) - lgamma(c*(1-pi));
			probbb = probbb + exp(aux);
		end;
		end;
		expect[s] = expect[s] + probbb;
		probbb=0;
	end;
	end;
	expect[k] = n-sum(expect[1:k-1]);

	call collapse(k,expect,upperb,r,lower,upper,expected);

	nparms = &nparms_bb;
	call gof(r,t,n,m,lower,upper,expected,nparms,obs,obs_sum,exp_sum,GOFStat);

	*   Print results under Beta-binomial distribution;

	print "Goodness-of-fit Test under Beta-binomial Distribution" ;
	print lower upper obs expected;
	print "Total Counts";
	print n obs_sum exp_sum;
	print "Null Hypothesis: Data are distributed according to a Beta-binomial Distribution";
	print GOFStat;

	*   Output Residuals (Observed - Expected) into data set Resid_BB needed later for QQ-Plots;

	Distribution = j(nrow(obs),1,'Beta-Binomial ');
	Resid        = obs - expected;
	create Resid_BB var{ Distribution Resid };
	append;

	*****************************************************************;
	*	2) Begins GOF Test under Random-clumped Binomial distribution;
	*****************************************************************;

	use pi_rcb var {Pred};
	read all into pii;
	use rho_rcb var {Pred};
	read all into rhoo;

	*   Compute expected frequency for Random-clumped Binomial distribution;
	k    = max(mj) + 1;

    *   Initialization;
    lowerb = j(k,1, -0.0000001);
    upperb = j(k,1,  1.0000001);

    expect = j(k, 1, 0);

    *   Define lower and upper bound for the intervals;
    do s = 2 to k;
        lowerb[s]   = (s-1)/k;
        upperb[s-1] = (s-1)/k;
    end;

	do s = 1 to k-1;
		expect[s] = 0;
		do j=1 to n;
			pi   = pii[j];
			rho  = rhoo[j];
			pic  = 1-pi;
		        rhoc = 1-rho;
			p2   = rhoc*pi;
		        p1   = p2 + rho;

			probrcb = 0;
			x1      = (0:m[j])`;
			m2      = m[j] +1;
			pr1     = PROBBNML(p1,m[j],x1);
			pr2     = PROBBNML(p2,m[j],x1);
			pr1[2:m2] = pr1[2:m2] - pr1[1:(m2-1)];
			pr2[2:m2] = pr2[2:m2] - pr2[1:(m2-1)];

			do it = 0 to m[j];
				i = it + 1;
				ratio = it/m[j];
				if ((ratio > lowerb[s]) & (ratio <= upperb[s])) then
				probrcb = probrcb + pi*pr1[i] + pic*pr2[i];
			end;
			expect[s] = expect[s] + probrcb;
			prorcb=0;
		end;
	end;
	expect[k] = n-sum(expect[1:k-1]);

	call collapse(k,expect,upperb,r,lower,upper,expected);

	nparms = &nparms_rcb;
	call gof(r,t,n,m,lower,upper,expected,nparms,obs,obs_sum,exp_sum,GOFStat);

	*   Print results under Random-clumped Binomial distribution;

	print "Goodness-of-fit Test under Random-clumped Binomial Distribution" ;
	print lower upper obs expected;
	print "Total Counts";
	print n obs_sum exp_sum;
	print "Null Hypothesis: Data are distributed according to a Random-clumped Binomial Distribution";
	print GOFStat;

	*   Output Residuals (Observed - Expected) into data set Resid_RCB needed later for QQ-Plots;

	Distribution = j(nrow(obs),1,'Random-clumped');
	Resid        = obs - expected;
	create Resid_RCB var{ Distribution Resid };
	append;

	quit;  *   End of IML;


	data Resid_BB_RCB;
		set Resid_BB Resid_RCB;
	run;

	proc sort data=Resid_BB_RCB;
		by Distribution;
	run;

	proc rank data=Resid_BB_RCB out=new_qqplots normal=blom ties=mean;
		by Distribution;
		var Resid;
		ranks NQuant;
	run;

	proc sgpanel data=new_qqplots noautolegend;
		panelby Distribution;
		title1 &title;
		title2 "QQ-Plots of Residuals based on Observed and Expected Frequencies";
		label Resid="Residuals" NQuant="Normal Quantiles";
		reg x=Resid y=NQuant;
	run;

	*-----------------------------;
	%mend GOF_BB_RCB_Distributions;
	*-----------------------------;






	*--- Chapter 5: Program 5.4 MLE Analysis and GOF Test of Hiroshima Chromosome Aberration;

	/*
		Hiroshima Chromosome Aberration Example
	    Data kindly provided by Prof. Dirk F. Moore 
	*/
 
	data hiroshima;
		input m t t65d_gamma t65d_neutron;
		label m = "Number of cells examined"
		      t = "Total aberrations"
			  t65d_gamma   = "T-65-D  gamma"
			  t65d_neutron = "T-65-D  neutron";
		z = t65d_gamma + t65d_neutron;
	datalines;
	  100    0    0    0
	  100    0    0    0
	   30    0    0    0
	   69   12  324   84
	  100    8  221   82
	  100    1    0    0
	   36    0    0    0
	  100    0   96   18
	  100    0    0    0
	   79    8  267  161
	  100    1    0    0
	   39    0    0    0
	  100    2    0    0
	  100    2    0    0
	  100    7  173   46
	  100    2    0    0
	  100    0    1    0
	  100    0    0    0
	  100    7  135   29
	  100    0    0    0
	  100    1    0    0
	  100    1    0    0
	  100    3    0    0
	  100    5  144   31
	   82    9  153  103
	   30    0  131   27
	  100    5   31   13
	  100    0    0    0
	  100    0   66   38
	  100    3    0    0
	  100    6  158   38
	  100   12  245   51
	   30    2  125   30
	  100   16  439  100
	  100    9  161   38
	  100    3   61   13
	  100   11  439  154
	  100   14  281  161
	  100    7  203   48
	  100    1   87   17
	  100    0   84   18
	   80    1   42    8
	  100    2  122   28
	  100    0    0    0
	   30    0    0    0
	  100    0    0    0
	  100   17  203  146
	  100    3  284   66
	   70    0  439  161
	  100    3    0    0
	   53    1    0    0
	  100    3    0    0
	  100    5  159   31
	  100    0    0    0
	  100    2    0    0
	  100    1    0    0
	  100    9  212   54
	  100   12  157   50
	  100    0    0    0
	  100    3   87   53
	  100    2    0    0
	  100    2  181  116
	   82    1   75   37
	   32    0   67   33
	  100    2    0    0
	  100    0    0    0
	  100    1    0    0
	  100    3  108   22
	  100    6  118   43
	  100    3  185   44
	  100    0    0    0
	  100    1    0    0
	  100    0    0    0
	  100    4  180   39
	  100    0    0    0
	  100    0    0    0
	   30    0    0    0
	  100   15  174   40
	  100    2    0    0
	  100    1    5    2
	  100   20  218   47
	   80    0   16    3
	  100   15  142   65
	  100    0   94   16
	  100    1    0    0
	  100    2    0    0
	  100    0  126   66
	  100    0    0    0
	  100    1   12    5
	  100    3    0    0
	   90    4  197  132
	  100   39  243  161
	  100    0    0    0
	  100    1    0    0
	  100    2    0    0
	   66    7  152   34
	  100    3    0    0
	  100    1    0    0
	  100    5    0    0
	  100    2    0    0
	  100    4  439  161
	  100    0    0    0
	  100    7  317   65
	  100    1    0    0
	  100   19  439  161
	   92    1   12    5
	  100    3   66   15
	  100    1   27   10
	  100   15  149  101
	  100    5   59   10
	  100    2    0    0
	   50    3  308   77
	  100    1    0    0
	  100    6  131   33
	  100    5   71   14
	  100    2   34    8
	  100    3  165   34
	  100    7  101   22
	  100    5   74   44
	   54    7  316   75
	  100    6  160   38
	  100    6   63   13
	  100    0   30    5
	  100   24  384   81
	  100    6   32   15
	  100    3   43    9
	   50    0   46    8
	  100    3  119   24
	  100    0  113   23
	  100    5   96   21
	   37    1  187  115
	  100    5  109   25
	  100    3  117   27
	  100    3  335   70
	  100   28  131   82
	  100   11  395   97
	  100    5  137   63
	  100   21  439  161
	  100    2   10    3
	  100   15  296   92
	   63    0   89   16
	  100    4   30   14
	   47    1  439  161
	  100    7  206   46
	  100    2    0    0
	  100    0  439  159
	  100    7  211   44
	  100    1  377  136
	  100    5  221   47
	  100   17  324  161
	  100    0   55    9
	  100   40  403  102
	  100    3    0    0
	  100    8  172   37
	   56    3  100   55
	  100   13  245   70
	  100   11  128   33
	   78    5  214   52
	  100    7   65   10
	  100    0  112   29
	  100   10  249  112
	   87    5  186   40
	  100    1    2    1
	  100    7  265   60
	  100    3  376   83
	  100    2  149   25
	  100    5   37   19
	  100   16  372   97
	  100    6  144   36
	  100    2    0    0
	  100    3  120   54
	  100    0  155  106
	  100    5  179   38
	  100    2    0    0
	  100    1    0    0
	  100   24  224   80
	  100    7   93   54
	   66    0    2    1
	   50    4  112   21
	  100    2   90   42
	  100    6   85   18
	  100    0    0    0
	   79    4  103   23
	  100    7  148   35
	  100   18  279   72
	  100    5  208   51
	  100   13  262   57
	   32    1  176   41
	  100    8  173   38
	   30    1  155   38
	  100   18  202   50
	  100    7   58   25
	   67    1  133   28
	  100   19  257   67
	   76    0    3    1
	  100   25  434  120
	  100   44  306  161
	  100    7  152   43
	  100    6  177   37
	  100    9   65   38
	  100   10  100   27
	   42    2  115   31
	   70    1   28    6
	  100   16   73   17
	  100    2   58   14
	   35    0   89   51
	  100    5  339   85
	  100    5  171   87
	  100    4  128   38
	  100    4  136   24
	  100    7   67   11
	  100    5  291   81
	  100    4  162   33
	  100    7   47    7
	  100   18  296   71
	  100    0   92   19
	  100    0    0    0
	  100    2  106   19
	  100    8   98   35
	  100    1    9    4
	  100   10  305   60
	  100    4  302   69
	  100    2    0    0
	  100    1   39   10
	  100    1   93   18
	  100   14  379  103
	  100    0    0    0
	  100    1  108   23
	  100    0    2    1
	  100    0    0    0
	  100   22  392  161
	  100   16  379   95
	  100    0   66   38
	  100    1   54   17
	  100   10   96   28
	  100    0    0    0
	   32    0    0    0
	  100    7  243   57
	  100    0    0    0
	  100    1    0    0
	  100    1    0    0
	  100    1    0    0
	  100    9  100   22
	   50    0    0    0
	   80    5  257  144
	   30    0    0    0
	  100    0    0    0
	  100    1    0    0
	  100    5  186   58
	  100    0    0    0
	  100    1    0    0
	  100   12  100   22
	  100    0    0    0
	  100    9   61   16
	  100    6   99   62
	  100    2   18    2
	  100    2  134   26
	  100    4  377  161
	  100    1    0    0
	  100    2    0    0
	   31    8  203  133
	  100    0    0    0
	  100    2    0    0
	  100    0    0    0
	  100    1    0    0
	  100    3    0    0
	  100    1  136   23
	  100    8  117   28
	  100    1    9    3
	  100    1    0    0
	  100    2    0    0
	  100    4  328  100
	  100    7   89   19
	  100    3    0    0
	  100   19  439  161
	  100    2   86   48
	  100    1    0    0
	  100    1    0    0
	  100    2   32    5
	  100    7  345   96
	   50    0   54   10
	  100    7  126   83
	  100    0    0    0
	   51    3   91   40
	  100    2    0    0
	   74    1  238   54
	  100   13  221   53
	  100    0    0    0
	   46    6  150   88
	  100    1    0    0
	  100    2   13    1
	  100    4  384  140
	  100    0   91   21
	   30    0   95   55
	  100    0    0    0
	  100    1    0    0
	   33    3  439  161
	   31    1    0    0
	  100    3    0    0
	  100   12  250  103
	  100    3    0    0
	  100    1    7    3
	  100    1    0    0
	  100    0    0    0
	  100    0    0    0
	  100    0    0    0
	   94    3   99   23
	   46   12  235   56
	  100    7  247   60
	  100    2   86   18
	   80    5  331   80
	  100    1    0    0
	  100    1    0    0
	   30    0    0    0
	   42    0   86   36
	   35    0    0    0
	  100    0    0    0
	  100    1    0    0
	  100    0    0    0
	  100    3    0    0
	  100    0    0    0
	  100    1    0    0
	   90    8  139   27
	  100    3  101   25
	  100    0    0    0
	   60    4  314   78
	  100    1    0    0
	  100    1    0    0
	  100    3    0    0
	  100    6  324   78
	  100   20  301   82
	  100    0    0    0
	  100    1    0    0
	  100   15  165   48
	   90    1    7    3
	  100    0    0    0
	  100   35  384  100
	   56    0    0    0
	  100   12  243  161
	   34    2  191   45
	  100    7  145   29
	  100   13  182   45
	   32    0    0    0
	  100    1    0    0
	   91    2   14    3
	  100    1   49   27
	  100    1    0    0
	  100    0    0    0
	  100    0    0    0
	  100    0    0    0
	   84    2    0    0
	  100    2    0    0
	   80    1    0    0
	  100    2    0    0
	  100    1    0    0
	  100    0    0    0
	  100    0    0    0
	  100    2    4    1
	  100   14  254   59
	  100    0    0    0
	  100    1    0    0
	  100    0    0    0
	  100    2    0    0
	  100    2    0    0
	  100    2    0    0
	  100    0    0    0
	  100    7   47    8
	  100    2    0    0
	  100    0    0    0
	  100    1    0    0
	  100    2    0    0
	   88    2    0    0
	   53    1   40    6
	  100    4   15    2
	  100    0    0    0
	  100    1    0    0
	   30    3  212   60
	  100    1    0    0
	  100    3  155  106
	  100    3   72   39
	  100    9  149   41
	  100    0    0    0
	   70    2    2    0
	  100    6  287   60
	  100    6    0    0
	  100    3    0    0
	  100   11  211   52
	  100    4  108   23
	  100    2    0    0
	  100    0    0    0
	  100   17   93   15
	   68    0    0    0
	  100   40  428  161
	  100    9  131   30
	  100   12  248  161
	  100    7  112   28
	  100    5  307   92
	  100    7   95   17
	  100    0   10    1
	  100    7   88   19
	  100    0    0    0
	  100   16  167  116
	   45    2  210   57
	  100   14  203   55
	  100    2    0    0
	  100    1    0    0
	  100    4   85   20
	   92   18  439  161
	  100    1    0    0
	   80    8  117   28
	  100    6  104   27
	  100    2    0    0
	  100    2  439  161
	  100    0    0    0
	  100    2    0    0
	  100    0    0    0
	  100   13  190   39
	   65    1    0    0
	  100    2    0    0
	  100   16  171   91
	  100    3    0    0
	  100    0    0    0
	  100    3   25    9
	  100    3    0    0
	  100   18  139   93
	  100    0    0    0
	  100    2    0    0
	  100    1    0    0
	   50    2    0    0
	  100    1   12    2
	  100    1    4    1
	  100    4    0    0
	  100    5  101   30
	  100    4  439  161
	  100    9  353   95
	  100    1    0    0
	   30    0   82   47
	  100   10  216   64
	  100    8  439  161
	  100    1    0    0
	  100   10  220   50
	  100    6  357   83
	  100    0    0    0
	  100    0  117   76
	   93    3   35    7
	  100   23  245   73
	   48    2  324  108
	  100    1    0    0
	   50    0    0    0
	   95    2    0    0
	  100    2    0    0
	  100    7  140   32
	  100    1    0    0
	  100    4    0    0
	   42    4   99   27
	   60    3    0    0
	  100    6  120   35
	  100   14  373  133
	  100   15  330  108
	   93   11  327   98
	  100    9  170   42
	   80   19  439  115
	  100   14  439  161
	  100    0    0    0
	  100    2  148   30
	  100    0    0    0
	  100   14  138   68
	  100   18  123   28
	  100   17   87   46
	  100    1    0    0
	  100   21  384  161
	  100    1    0    0
	  100    1  257   59
	  100    2  100   30
	  100    3    0    0
	  100   10  115   29
	  100    1    0    0
	  100    5   94   16
	  100    1   30    6
	  100    1   32    8
	  100    2    0    0
	   63    7  277   60
	  100    2    0    0
	  100    2  159   34
	   53    6  251   78
	  100    1    0    0
	  100    3    0    0
	  100   18  230  161
	  100    1    0    0
	  100    2   65   38
	  100    1    0    0
	   81    2    0    0
	  100    8  149   33
	  100   26  222   60
	   32    3   40   18
	  100    1    0    0
	  100    0    0    0
	  100    1    0    0
	  100    4  142   34
	  100    2  125   49
	  100    1   92   16
	  100    3  174   39
	  100    0    0    0
	   38    1    0    0
	   82    1    0    0
	  100    3    0    0
	   35    0    0    0
	  100   15  157   38
	  100    1    0    0
	  100    1    0    0
	  100    0    0    0
	  100    1   97   60
	  100    5   96   60
	  100    2    0    0
	   34    0    0    0
	  100    1  112   22
	  100    3  106   27
	  100   12  214   53
	  100    2  439  161
	  100    1    0    0
	   30    0   33    6
	  100   19  103   20
	  100    4  141   39
	   50    0    0    0
	  100    0    0    0
	  100    2    0    0
	  100    0    0    0
	  100   47  244  100
	  100   16  439  161
	  100   22  439  161
	  100   28  318  118
	  100   16  404  124
	  100    0   91   20
	  100   15  269   72
	  100    6  160   38
	   30    0  216   61
	  100   14   84   50
	  100   11  372   90
	  100    7  237  137
	   60    4  186   52
	  100    7   44   12
	  100    3    0    0
	  100   31  439  144
	  100    1    0    0
	  100    6  163   39
	  100    2    0    0
	  100    0   15    3
	  100    7  155   27
	  100    0   15    6
	  100    2  124   29
	   50    0   58   11
	  100    1    0    0
	   70   18  234   51
	  100    2  197   48
	  100    1    0    0
	  100    2    0    0
	  100    0    0    0
	  100    2  196   99
	  100    2    0    0
	  100    5  106   23
	  100   27  439  161
	   78   22  301   76
	  100    2    0    0
	  100    4   68   38
	  100    3  136   35
	   33    1  102   21
	  100    4  136   28
	  100    6  102   23
	  100    1   98   19
	   86    1    7    2
	  100    5  197   43
	  100    8  284   60
	  100    0    0    0
	  100   27  328  161
	  100    4  119   33
	  100   19  196   43
	  100    2    0    0
	  100    2    0    0
	  100    2    0    0
	  100    8  115   31
	  100    8  152   39
	  100   11  165   42
	  100    2  184   32
	  100    1   91   18
	  100    7  152   28
	  100    5    0    0
	  100    2  265   50
	  100    2    2    1
	  100   31  358   88
	  100   14  178  125
	  100    7  177   50
	  100    0    0    0
	  100    2    0    0
	  100    0    0    0
	  100   17  362   91
	  100   22  360   84
	  100    2   10    4
	  100    3    0    0
	  100    2    0    0
	  100    4    0    0
	  100   11  301   75
	  100    9  321   82
	  100   21  210  152
	  100    0    0    0
	  100    1    0    0
	  100    8   85   17
	  100    0   96   15
	   40    2  227   56
	  100    3  175   38
	  100    4  205   54
	   45    0    0    0
	   37    0    0    0
	   50    1    0    0
	  100    4    0    0
	  100    0    0    0
	   30    0    0    0
	   65    4    0    0
	  100    1    0    0
	  100    7   69   14
	  100    3    0    0
	  100    3    0    0
	  100    7  138   31
	  100    2   92   38
	  100    3    0    0
	  100    0    0    0
	  100    4  133   30
	  100    1    0    0
	   33    0    0    0
	  100    0    0    0
	  100    1    0    0
	  100    0    0    0
	  100    1    0    0
	   85    0    0    0
	  100    8  176   38
	  100    1    0    0
	  100    1   11    4
	  100    0   16    2
	  100    0    0    0
	   30    4  126   30
	   90    0    0    0
	  100    2  117   23
	  100    3    0    0
	  100    0    0    0
	  100    2    0    0
	  100    1    0    0
	   80    2   79   41
	   65    0    0    0
	   40    1    0    0
	 ;

 	proc stdize data=hiroshima out=hiroshima;
		var z;
	run;

	data hiroshima;
		set hiroshima;
		zz   = z * z;
	run;

	ods html;
	ods graphics on;

	title "*** Beta-binomial fit ***";;	
	ods output Dimensions=Dimensions;
	proc nlmixed data=hiroshima;
		parms b0=0 b1=0 b2=0 a0=0 a1=0 a2=0;
		rho   = 1 / (1 + exp(-a0-a1*z-a2*zz));
		xbeta = b0 + b1*z + b2*zz;
		pi    = 1 / ( 1 + exp( - xbeta ) );
		theta = 1 / rho / rho - 1;
		c     = lgamma(m+1) - lgamma(t+1) - lgamma(m-t+1);
		ll    = c + lgamma(theta)   + lgamma(t+theta*pi) + lgamma(m-t+theta*(1-pi))
		          - lgamma(m+theta) - lgamma(theta*pi)   - lgamma(theta*(1-pi));
		model t ~ general( ll );
			predict pi    out=pi_bb;
			predict rho   out=rho_bb;
	run;

	data Dimensions;
		set Dimensions;
		if Descr = "Parameters" then call symput('nparms_bb',trim(left(Value)));	
		*--- "nparms" is number of parameters;
	run;

	data pi_bb;
		set pi_bb;
		keep Pred;
	run;

	data rho_bb;
		set rho_bb;
		keep Pred;
	run;

	title "*** Random-clumped Binomial fit ***";	
	ods output Dimensions=Dimensions;
	proc nlmixed data=hiroshima;
		parms b0=0 b1=0 b2=0 a0=0 a1=0 a2=0;
		rho   = 1 / (1 + exp(-a0-a1*z-a2*zz));
		xbeta = b0 + b1*z + b2*zz;
		pi    = 1 / ( 1 + exp( - xbeta ) );
		pic   = 1 - pi;
		p1    = ( 1 - rho )*pi + rho;
		p1c   = 1 - p1;
		p2    = p1 - rho;
		p2c   = 1 - p2;
		c     = lgamma(m+1) - lgamma(t+1) - lgamma(m-t+1);
		ll    = c + log( pi*p1**t*p1c**(m-t)  +  pic*p2**t*p2c**(m-t) );
		model t ~ general( ll );
			predict pi    out=pi_rcb;
			predict rho   out=rho_rcb;
	run;

	data Dimensions;
		set Dimensions;
		if Descr = "Parameters" then call symput('nparms_rcb',trim(left(Value)));	
		*--- "nparms" is number of parameters;
	run;

	data pi_rcb;
		set pi_rcb;
		keep Pred;
	run;

	data rho_rcb;
		set rho_rcb;
		keep Pred;
	run;

	title;
	%GOF_BB_RCB_Distributions(hiroshima,"Hiroshima Chromosome Aberration Example");

	ods graphics off;
	ods html close;







	*--- Chapter 6: Program 6.1 Plots Poisson and Negative-binomial Distributions;

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






	*--- Chapter 6: Program 6.2 GOF Example from Cohen 1966;

	/*
		Trematode Schistosoma Mansoni Example, Cohen (1966) 
		GOF tests under the Negative-binomial and Zero-inflated Negative-binomial
	*/

	data eggs;
	input y freq;
	sum + freq;
	call symput('n',cats(sum));
	datalines;
	0	603
	1	112
	2	93
	3	53
	4	19
	5	21
	6	7
	7	6
	8	5
	9	2
	10	1
	11	2
	14	2
	;

	ods html;

	title "Negative-binomial Model using COUNTREG";
	ods output ParameterEstimates=Parms_NB;
	proc countreg data=eggs;
		model y = / dist=negbin;
		output out=exp_nb prob=prob_nb;
		freq freq;
	run;

	title "Zero-inflated Negative-binomial Model using COUNTREG";
	ods output ParameterEstimates=Parms_ZINB;
	proc countreg data=eggs method=qn;
		model y = / dist=zinb;
		zeromodel y ~  / link=logistic;
		output out=exp_zinb prob=prob_zinb;
		freq freq;
	run;

	title;
	data exp_nb;
		set exp_nb;
		exp_nb = &n * prob_nb;
	run;

	proc print data=exp_nb noobs;
	run;

	data exp_zinb;
		set exp_zinb;
		exp_zinb = &n * prob_zinb;
	run;

	proc print data=exp_zinb noobs;
	run;

	*-------;
	proc iml;
	*-------;
		*--- Get parameter estimates and their s.e.'s ;
		use Parms_NB var {estimate};
		read all into parms_nb;
		use Parms_NB var {StdErr};
		read all into se_nb;
		use Parms_ZINB var {estimate};
		read all into parms_zinb;
		use Parms_ZINB var {StdErr};
		read all into se_zinb;

		*--- Compute Mu and its StdErr under NB distribution;
		mu_nb    = exp(parms_nb[1,1]);
		se_mu_nb = mu_nb * se_nb[1,1];
		*--- Get Kappa and its StdErr under NB distribution;
		kappa_nb    = parms_nb[2,1];
		se_kappa_nb = se_nb[2,1];
		*--- Compute Mu and its StdErr under ZINB distribution;
		mu_zinb    = exp(parms_zinb[1,1]);
		se_mu_zinb = mu_zinb * se_zinb[1,1];
		*--- Compute W and its StdErr under ZINB distribution;
		aux       = exp(parms_zinb[2,1]);
		w_zinb    = aux / (1 + aux);
		se_w_zinb = se_zinb[2,1] * w_zinb / (1 + aux);
		*--- Get Kappa and its StdErr under ZINB distribution;
		kappa_zinb    = parms_zinb[3,1];
		se_kappa_zinb = se_zinb[3,1];

		*--- Get observed and expected frequencies under NB distribution;
		use Exp_nb var {freq};
		read all into obs;
		use Exp_nb var {exp_nb};
		read all into exp_nb;
		*--- Get expected frequencies under ZINB distribution;
		use Exp_zinb var {exp_zinb};
		read all into exp_zinb;

		sum_nb   = exp_nb[+,1];
		sum_zinb = exp_zinb[+,1];

		*--- Combine some categories as in Cohen (1966) example;
		obs[9]       = obs[9]       + obs[10];
		exp_nb[9]    = exp_nb[9]    + exp_nb[10];
		exp_zinb[9]  = exp_zinb[9]  + exp_zinb[10];
		obs[10]      = obs[11]      + obs[12]      + obs[13];
		exp_nb[10]   = exp_nb[11]   + exp_nb[12]   + exp_nb[13]   + &n - sum_nb;
		exp_zinb[10] = exp_zinb[11] + exp_zinb[12] + exp_zinb[13] + &n - sum_zinb;

		*--- Compute Chi-square GOF statistics and P-values;
		chi_1 = 0;
		chi_2 = 0;

		do j=1 to 10; 
			chi_1 = chi_1 + obs[j] * obs[j] / exp_nb[j];
			chi_2 = chi_2 + obs[j] * obs[j] / exp_zinb[j];
		end;

		chi_1  = round(chi_1 - &n, 0.01);
		chi_2  = round(chi_2 - &n, 0.01);
		df_1   = 10-1-2;
		df_2   = 10-1-3;
		pval_1 = 1 - probchi(chi_1,df_1,0); 
		pval_2 = 1 - probchi(chi_2,df_2,0); 
		chi    = chi_1  // chi_2;
		df     = df_1   // df_2;
		pval   = pval_1 // pval_2;

		*--- Print results;
		mle_1    = mu_nb//kappa_nb;
		se_1     = se_mu_nb//se_kappa_nb;
		mle_2    = mu_zinb//kappa_zinb//w_zinb;
		se_2     = se_mu_zinb//se_kappa_zinb//se_w_zinb;
		parms_1  = {'Mu', 'Kappa'};
		parms_2  = Parms_1 // {'W'};
		x0       = { '   0', '   1', '   2', '   3', '   4', '   5', 
		             '   6', '   7', '8 or 9', ' >= 10', 'TOTALS' };
		Distribution = {'Negative Binomial', 
		                'Zero-inflated Negative Binomial'};
		x1 = shape(obs, 10,1);
		x2 = shape(exp_nb, 10,1);
		x3 = shape(exp_zinb, 10,1);
		x1 = x1 // sum(x1);
		x2 = x2 // sum(x2);
		x3 = x3 // sum(x3);

		mattrib parms_1 label='Parameter'                 format=8.4;
		mattrib parms_2 label='Parameter'                 format=8.4;
		mattrib mle_1   label='Estimate'                  format=8.4;
		mattrib mle_2   label='Estimate'                  format=8.4;
		mattrib se_1    label='StdErr'                    format=8.4;
		mattrib se_2    label='StdErr'                    format=8.4;
		mattrib x0      label='No. Eggs per Slide';
		mattrib x1      label='Observed Frequencies'      format=8.0;
		mattrib x2      label='Expected Frequencies NB'   format=10.4;
		mattrib x3      label='Expected Frequencies ZINB' format=10.4;
		mattrib chi     label='Chi-square'                format=8.2;
		mattrib df      label='DF'                        format=8.0;
		mattrib pval    label='P-Value'                   format=pvalue6.;

		print "Number of Eggs of 'Schistosoma Mansoni' -- Cohen (1966)";
	    print "Maximum Likelihood Estimates -- Negative Binomial Distribution";
		print parms_1 mle_1 se_1;
	    print "Maximum Likelihood Estimates -- Zero-inflated Negative Binomial Distribution";
		print parms_2 mle_2 se_2;
		print "Goodness-of-fit Tests Results";
		print x0 x1 x2 x3 ; 
		print Distribution chi df pval;
	quit;

	ods html close;


	ods html;
	title "Zero-inflated Negative-binomial Model using NLMIXED";
	proc nlmixed data=eggs df=&n;
		parms Intercept=0 Inf_Intercept=0 _Alpha=0.5 ;
		w  = 1 / (1 + exp(-Inf_Intercept));
		mu = exp(Intercept);
		a  = 1/_Alpha;
		p  = 1 / (1 + _Alpha*mu);
		z  = lgamma(y+a) - lgamma(a) - lgamma(y+1);
		if y=0 then
			 ll = log( w + (1-w)*p**a );
		else ll = z + log(1-w) + a * log(p) + y * log(1-p);
		model y ~ general(freq*ll);
		estimate "Mu"    exp(Intercept);
		estimate "Kappa" _Alpha;
		estimate "W"     1/(1+exp(-Inf_Intercept));
	run; 
	ods html close;






	*--- Chapter 6: Programs 6.3 and 6.4 Jan van den Broek;

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






	*--- Chapter 6: Program 6.5 Plots Poisson Distribution and a Poisson Hurdle Model;

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






	*--- Chapter 6: Program 6.6 Mullahy 1986;

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







	*--- Chapter 6: Appendix A Generating Negative Binomial Data;

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







	*--- Chapter 6: Appendix B Generating Poisson-Hurdle and Negative-binomial Hurdle data;

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







	*--- Chapter 7: Program 7.1 School Program Example;

	/*	
		School Program Example
		from Stokes, Davis, and Koch (2000)
		Fitting of a Generalized Logits Model
	*/

	data school;
		length Program $ 9;
		input School Program $ Style $ Count @@; 
		datalines; 
		1 regular   self 10  1 regular   team 17  1 regular   class 26
		1 afternoon self  5  1 afternoon team 12  1 afternoon class 50 
		2 regular   self 21  2 regular   team 17  2 regular   class 26
		2 afternoon self 16  2 afternoon team 12  2 afternoon class 36 
		3 regular   self 15  3 regular   team 15  3 regular   class 16
		3 afternoon self 12  3 afternoon team 12  3 afternoon class 20 
		; 

	ods html;
	ods graphics on;
	proc logistic data=school;
		freq Count; 
		class School Program(ref=first);
		model Style(order=data)=School Program School*Program / link=glogit;
		oddsratio program;
	run;
	ods graphics off;
	ods html close;






	*--- Chapter 7: Program 7.2 Birth Defects Example;
	/*
		Birth Defects Example, Morel and Koehler (1995)
	*/

	data birth_defects;
	   input group$ @@;
	   do j=1 to 10;
	      input t1-t3 zn2 cd2 cd3 zn2_cd2 zn2_cd3;
	      output;
	   end;
	   drop j;
	   datalines;
	2ZN
	  2  0 11   1 0 0 0 0
	  0  0 15   1 0 0 0 0
	  1  0 13   1 0 0 0 0
	  1  1 13   1 0 0 0 0
	  1  0 12   1 0 0 0 0
	  1  0 12   1 0 0 0 0
	  0  0 13   1 0 0 0 0
	  1  0 10   1 0 0 0 0
	  0  0 16   1 0 0 0 0
	  0  1 11   1 0 0 0 0
	2CD
	  2  5  5   0 1 0 0 0
	 12  0  0   0 1 0 0 0
	  4  5  3   0 1 0 0 0
	  3  8  0   0 1 0 0 0
	  3  8  0   0 1 0 0 0
	  9  4  0   0 1 0 0 0
	  1 12  3   0 1 0 0 0
	  1  9  2   0 1 0 0 0
	  2  4 10   0 1 0 0 0
	  3  0 12   0 1 0 0 0
	3CD
	  6  5  1   0 0 1 0 0
	 11  0  0   0 0 1 0 0
	  8  5  0   0 0 1 0 0
	  8  0  0   0 0 1 0 0
	 14  0  0   0 0 1 0 0
	 11  1  0   0 0 1 0 0
	 12  0  0   0 0 1 0 0
	 13  5  0   0 0 1 0 0
	 12  0  0   0 0 1 0 0
	 12  0  0   0 0 1 0 0
	2ZN2CD
	  1  1  9   1 1 0 1 0
	  0  0 13   1 1 0 1 0
	  1  1 13   1 1 0 1 0
	  4  4  3   1 1 0 1 0
	  0  1 12   1 1 0 1 0
	  0  0 11   1 1 0 1 0
	  0  3  9   1 1 0 1 0
	  2  2  9   1 1 0 1 0
	  0  4 11   1 1 0 1 0
	  1  5  6   1 1 0 1 0
	2ZN3CD
	  4  1  5   1 0 1 0 1
	  4  7  3   1 0 1 0 1
	 13  5  0   1 0 1 0 1
	  2  4  6   1 0 1 0 1
	  6  5  1   1 0 1 0 1
	 11  0  0   1 0 1 0 1
	  5  6  2   1 0 1 0 1
	  4  2  6   1 0 1 0 1
	  6  3  6   1 0 1 0 1
	  5  3  3   1 0 1 0 1
	SC
	  0  0 13   0 0 0 0 0
	  8  0  1   0 0 0 0 0
	  0  0 13   0 0 0 0 0
	  1  0 11   0 0 0 0 0
	  1  0 17   0 0 0 0 0
	  0  0 13   0 0 0 0 0
	  0  0 15   0 0 0 0 0
	  0  0 14   0 0 0 0 0
	  0  0 11   0 0 0 0 0
	  0  0 14   0 0 0 0 0
	UC
	  0  0 13   0 0 0 0 0
	  5  1  7   0 0 0 0 0
	  0  0 13   0 0 0 0 0
	  1  0 11   0 0 0 0 0
	  0  0 13   0 0 0 0 0
	  0  0 11   0 0 0 0 0
	  0  0 11   0 0 0 0 0
	  1  2 10   0 0 0 0 0
	  0  1 12   0 0 0 0 0
	  0  0 12   0 0 0 0 0
	;

	data new_birth_defects;
		set birth_defects;
		litter_id = _n_;
		y = 1; count = t1; output;
		y = 2; count = t2; output;
		y = 3; count = t3; output;
		keep litter_id y zn2 cd2 cd3 zn2_cd3 zn2_cd2 count;
	run;

	*--- Fits Cumulative Logits -- Full Model;
	ods output ParameterEstimates=beta;
	proc logistic data=new_birth_defects;
		model y = zn2 cd2 cd3 zn2_cd3 zn2_cd2 / link=clogit scale=pearson 
					aggregate=(litter_id);
		output out=out1 predprobs=individual;
		freq count;
	run;

	data out1;
		set out1;
		if y = 1;
		keep litter_id IP_1 IP_2;
	run;

	ods html;

	title1 "Birth Defects Example";
	title2 "Cumulative Logits Model -- Full Model";

	proc iml;
		use birth_defects;
		read all var{t1, t2, t3} into obs_ts;
		use out1;
		read all var{IP_1 IP_2} into pred_probs;
		use birth_defects;
		read all var{zn2 cd2 cd3 zn2_cd3 zn2_cd2} into x_matrix;
		use beta;
		read all var{estimate} into beta;

		m   = obs_ts[,+];
		n   = nrow(obs_ts);
		d   = ncol(obs_ts) - 1;
		k   = ncol(x_matrix);
		df  = n - (d + k);  *--- Recall model being fit is Cumulative Logits;
		a   = j(d,d,0);

		/*
			Given a vector of probabilities p, p=(p(1),p(2),...p(d))'
			this module computes the inverse of the matrix C(p), say A(p), such that
			C(p)*C(p)' = Diag(p) - p*p', 
			where C(p) is obtained using Cholesky decomposition.

			The matrix A(p) is given by

			A(i,j) =  { q(i-1) / ( p(i)   * q(i) ) } ** 0.5   if i=j       
			       =  { p(i)   / ( q(i-1) * q(i) ) } ** 0.5   if i>j
			       =   0                                      if i<j

			See: Tanabe and Sagae (1992)
		*/
		start inv_cp(p,a,d);
		q = {1} // (1 - cusum(p));
		do i=1 to d;
			i1 = i + 1;
			a[i,i] = sqrt( q[i,1] / p[i,1] / q[i1,1] );
			if d > 1 then do;
				do j=1 to i-1;
				a[i,j] = sqrt( p[i,1] / q[i,1] / q[i1,1] );
				end;
			end;
		end;
		finish inv_cp;

		*--- Part 1) Compute Phi;

		Scale   = 0;
		Phi     = j(d,1,0);
		z1 = j(1,1,0);
		z2 = z1;
		do j=1 to n;
			p  = t(pred_probs[j,]);
			t  = t(obs_ts[j,1:d]);
			call inv_cp(p,a,d);
			z       = a * (t - m[j,1] * p) / sqrt(m[j,1]);
			scale   = scale + z` * z;
			phi     = phi + z # z;
			z1      = z1 || z[1,1];
			z2      = z2 || z[2,1];
		end;

		scale   = scale / d / (n-k);
		phi     = phi / df;

		print n d k ,, scale[format=8.4] ,, phi[format=8.4] ,,,;

		*--- Part 2) Compute Generalized Scale Multinomial Variance;

		u            = j(d+k,1,0);
		h            = j(d+k,d+k,0);
		inv_diag_phi = inv( diag( phi ) );

		do j=1 to n;
			p     = t(pred_probs[j,]);
			t     = t(obs_ts[j,1:d]);
			f1f   = cusum(p);
			f1f   = f1f # (1 - f1f);
			f2f   = f1f;

			temp  = diag( f1f );
			if d > 1 then do;
				do i=1 to d-1;
				i1         = i+1;
				temp[i1,i] = -f1f[i,1];
				f2f[i1,1]  = f2f[i1,1] - f1f[i,1];
				end;
			end;

			der   = temp || f2f @ x_matrix[j,];
			call inv_cp(p,a,d);
			aux   = der` * a` * inv_diag_phi * a;
			u     = u + aux * (t - m[j,1] * p); 
			h     = h + m[j,1] * aux * der;
		end;

		covb = inv(h);

		StdErr = diag(covb) ## 0.5 * j(d+k,1,1);
		create StdErr2 var {StdErr}; 
		append;
	 
		create Residuals var {z1 z2}; 
		append;

	quit;

	data beta1;
		format Variance $29.;
		Variance = "Scale Multinomial";
		set beta;
	run;

	data beta2;
		format Variance $29.;
		Variance = "Generalized Scale Multinomial";
		merge beta stderr2;
		WaldChiSq = Estimate * Estimate / StdErr / StdErr;
		ProbChiSq = 1 - probchi(WaldChiSq,DF);
	run;

	data beta12;
		set beta1 beta2;
		format ProbChiSq pvalue6.4; 
	run;

	proc print data=beta12 noobs;
	run;

	ods html close;


	*--- Box Plots Residuals Z1 and Z2;
	data Residuals;
		set Residuals;
		if _n_ > 1;
		Z = Z1; Component = 1; Output;
		Z = Z2; Component = 2; Output;
	run;

	ods html;
	ods graphics on;
	proc sgplot data=Residuals;
	  	title "Standardized Components";
	  	vbox z / category=Component extreme;
	run;
	ods graphics off;
	ods html close;






	*--- Chapter 7: Module "DirMult_RCMult";

	/* 
	   This Module is a courtesy of 
       Dr. Justin Newcomer from Sandia National Laboratories
	*/ 

	Proc IML;

	/************************************************************************/
	/*  MLE Functions                                                       */
	/************************************************************************/

	/************************************************************/
	/*  Module: MLEDM(m,T)                                      */
	/*                                                          */
	/*  This Module computes the MLE from a Dirichlet           */
	/*  Multinomial	Distribution using the Fisher               */
	/*  Information	Matrix and the Fisher Scoring Algorithm     */
	/*                                                          */
	/*  m - cluster size                                        */
	/*  T - nxk matrix of counts (t1,t2,...,tk)	where ti is a   */
	/*      nx1 vector of observed counts in category i         */
	/************************************************************/
	Start MLEDM(m, T);

		print "*** Fisher Scoring Method -- Dirichlet-Multinomial Distribution ***";

		pi0   = QLEpi(m,T);
		rho0  = QLErho(m,T,pi0);
		k     = ncol(T);
		n     = nrow(T);
		theta           = j(k,1,0);
		theta[1:(k-1),] = pi0;
		theta[k,]       = rho0;
	
		eps  = 1E-8;
		conv = 1;
		iter = 0;
		Do Until(conv<eps);
		
			iter   = iter + 1;
			pi     = theta[1:(k-1),];
			rho    = theta[k,];
			INVFIM = Inv(n*FIMDM(m, pi, rho));
			Lold   = 0;
			Scores = j(k,1,0);
			Do j = 1 to n;
				tj     = T[j,1:(k-1)]`;
				Scores = Scores + gradDM(m, pi, rho, tj);
				Lold   = Lold + log(ProbDM(m, pi, rho, tj));
			End;

			si   = 0;
			Lnew = Lold - 1;
			Do Until(Lnew > Lold);

				thetaNew = theta + (0.5**si)*INVFIM*Scores;
				pi       = thetaNew[1:(k-1),];
				rho      = thetaNew[k,];
				Lnew     = 0;
				Do j = 1 to n;
					tj   = T[j,1:(k-1)]`;
					Lnew = Lnew + log(ProbDM(m, pi, rho, tj));
				End;

				si = si + 1;
				if si > 20 then do;
					print "NOTE: Step size halved 20 times, convergence assumed";
					Lnew   = Lold + 0.000001;
				end;

			End;

			theta  = thetaNew;
			conv   = abs(Lnew-Lold)/(abs(Lnew)+1E-6);
			conv_0 = conv;

			if si > 20 then conv = eps - 0.000001;
			if iter > 100 then do;
				print "NOTE: After 100 iterations, convergence not met yet";
				conv = eps - 0.000001;
			end;

		End;
 		
		if conv_0 < eps then do;
			print "NOTE: Convergence criterion (EPSILON=1E-8) satisfied";
		end;

		Return(theta);

	Finish;
	Store Module=MLEDM;


	/********************************************************************/
	/*	Module: MLERCM(m,T)												*/
	/*																	*/
	/* 	This Module computes the MLE from a Random-clumped Multinomial	*/
	/* 	Distribution using the Fisher Information 						*/
	/*	Matrix and the Fisher Scoring Algorithm							*/
	/*																	*/
	/*	m - cluster size												*/
	/*	T - nxk matrix of counts (t1,t2,...,tk)	where ti is a			*/
	/*      nx1 vectod of observed counts in category i					*/
	/********************************************************************/
	Start MLERCM(m, T);

		print "*** Fisher Scoring Method -- Random-clumped Multinomial Distribution ***";

		pi0   = QLEpi(m,T);
		rho0  = QLErho(m,T,pi0);
		k     = ncol(T);
		n     = nrow(T);
		theta           = j(k,1,0);
		theta[1:(k-1),] = pi0;
		theta[k,]       = rho0;
	
		eps  = 1E-8;
		conv = 1;
		iter = 0;
		Do Until(conv<eps);
		
			iter   = iter + 1;
			pi     = theta[1:(k-1),];
			rho    = theta[k,];
			INVFIM = Inv(n*FIMRCM(m, pi, rho));
			Lold   = 0;
			Scores = j(k,1,0);
			Do j = 1 to n;
				tj     = T[j,1:(k-1)]`;
				Scores = Scores + gradRCM(m, pi, rho, tj);
				Lold   = Lold + log(ProbRCM(m, pi, rho, tj));
			End;

			si   = 0;
			Lnew = Lold - 1;
			Do Until(Lnew > Lold);

				thetaNew = theta + (0.5**si)*INVFIM*Scores;
				pi       = thetaNew[1:(k-1),];
				rho      = thetaNew[k,];
				Lnew     = 0;
				Do j = 1 to n;
					tj   = T[j,1:(k-1)]`;
					Lnew = Lnew + log(ProbRCM(m, pi, rho, tj));
				End;

				si = si + 1;
				if si > 20 then do;
					print "NOTE: Step size halved 20 times, convergence assumed";
					Lnew   = Lold + 0.000001;
				end;

			End;

			theta  = thetaNew;
			conv   = abs(Lnew-Lold)/(abs(Lnew)+1E-6);
			conv_0 = conv;

			if si > 20 then conv = eps - 0.000001;
			if iter > 100 then do;
				print "NOTE: After 100 iterations, convergence not met yet";
				conv = eps - 0.000001;
			end;

		End;
 		
		if conv_0 < eps then do;
			print "NOTE: Convergence criterion (EPSILON=1E-8) satisfied";
		end;

		Return(theta);

	Finish;
	Store Module=MLERCM;

	/************************************************************************/
	/* 	Fisher Information Matrix Functions									*/
	/************************************************************************/	

	/****************************************************************/
	/*	Module: FIMDM(m,pi,rho)										*/
	/*																*/
	/* 	This Module returns the Fisher Information Matrix for		*/
	/*	a Dirichlet-Multinomial Distribution						*/
	/*																*/
	/*	m - cluster size											*/
	/*	pi - vector of probabilities [pi1, pi2, ... , pi(k-1)]`		*/
	/*	rho - correlation											*/
	/****************************************************************/
	Start FIMDM(m, pi, rho);

		k = nrow(pi)+1;
		c = (1-rho**2)/rho**2;

		FIM = j(k,k,0);
		PrK = 0;
		PrC = 0;
		piK = 1-sum(pi);
		Do s = 1 to m;
			PrK = PrK + ProbGTRBB(m, piK, rho, s)/(c*piK+s-1)**2;
			PrC = PrC + (c+s-1)**-2;
		End;

		Do i = 1 to (k-1);

			PrI = 0;
			Do s = 1 to m;
				PrI = PrI + ProbGTRBB(m, pi[i,], rho, s)/(c*pi[i,]+s-1)**2;
			End;

			FIM[i,i] = (c**2)*(PrI + PrK);
			Do j = (i+1) to (k-1);
				FIM[i,j] = (c**2)*PrK;
				FIM[j,i] = (c**2)*PrK;
			End;
			FIM[i,k] = c*(piK*PrK - pi[i,]*PrI)*(2/rho**3);
			FIM[k,i] = c*(piK*PrK - pi[i,]*PrI)*(2/rho**3);
			FIM[k,k] = FIM[k,k] + (pi[i,]**2)*PrI;

		End;

		FIM[k,k] = (FIM[k,k] + (piK**2)*PrK - PrC)*(4/rho**6);
		Return(FIM);

	Finish;
	Store Module=FIMDM;

	/****************************************************************/
	/*	Module: FIMRCM(m,pi,rho)									*/
	/*																*/
	/* 	This Module returns the Fisher Information Matrix for		*/
	/*	a Random-clumped Multinomial Distribution					*/
	/*																*/
	/*	m - cluster size											*/
	/*	pi - vector of probabilities [pi1, pi2, ... , pi(k-1)]`		*/
	/*	rho - correlation											*/
	/****************************************************************/
	Start FIMRCM(m, pi, rho);
		
		k   = nrow(pi)+1;
		FIM = j(k,k,0);
		t   = j(k,1,0);

		Do l = m to (m+1)**k-1 by m;
			temp = l;
			Do j = k to 1 by -1;
				t[j,] = int(temp/(m+1)**(j-1));
				temp  = temp - (m+1)**(j-1)*t[j,];	
			End;
		
			If sum(t) = m Then Do;
				pdl   = gradRCM(m, pi, rho, t[1:(k-1),]);
				ProbT = ProbRCM(m, pi, rho, t[1:(k-1),]);
				FIM   = FIM + pdl*pdl`*ProbT;
			End;

		End;

		Return(FIM);
		
	Finish;
	Store Module=FIMRCM;


	/************************************************************************/
	/* 	Utility Functions													*/
	/************************************************************************/	

	/************************************************************/
	/* 	This Module returns P(T=t) from a Beta-Binomial			*/
	/*	Distribution											*/
	/*															*/
	/*	m - cluster size										*/
	/*	pi - probability of success								*/
	/*	rho - correlation										*/
	/*  t - number of success									*/
	/************************************************************/
	Start ProbBB(m, pi, rho, t);

		c  = (1-rho**2)/rho**2;
		N1 = 0;
		N2 = 0;
		D  = 0;

		Do k = 1 to t;
			N1 = N1+log(c*pi + k - 1);
		End;
		Do k = 1 to (m-t);
			N2 = N2+log(c*(1-pi) + k - 1);
		End;
		Do k = 1 to m;
			D = D+log(c + k - 1);
		End;
		 
		Prob = comb(m,t)*exp(N1+N2-D);
		Return(Prob);

	Finish;
	Store Module=ProbBB;

	/************************************************************/
	/* 	This Module returns P(T>=t)from a Beta-Binomial 		*/
	/*	Distribution											*/
	/*															*/
	/*	m - cluster size										*/
	/*	pi - probability of success								*/
	/*	rho - correlation										*/
	/*  t - number of success									*/
	/************************************************************/
	Start ProbGTRBB(m, pi, rho, t);

		Prob = 0;
		If t/m >= 0.5 Then Do;
			Do i = t to m;
				Prob = Prob + ProbBB(m, pi, rho, i);
			End;
		End;
		Else Do;
			Do i = 0 to (t-1);
				Prob = Prob + ProbBB(m, pi, rho, i);
			End;
			Prob = 1 - Prob;
		End;
		 
		Return(Prob);

	Finish;
	Store Module=ProbGTRBB;

	/************************************************************/
	/* 	This Module returns P(T1=t1, T2=t2, ... ,Tk=tk) from a 	*/
	/*	Multinomial Distribution.  There are several ways to	*/
	/*  implement this function.  Three versions are provided.  */
	/*															*/
	/*	m - cluster size										*/
	/*	p - vector of probabilities [p1,p2,...,p(k-1)]`			*/
	/*  t - vector of counts {t1,t2,...,t(k-1)]`				*/
	/************************************************************/
	Start ProbMultinomial1(m, p, t);

		k    = nrow(p)+1;
		mtemp = m;
		q     = 1;
		If (t[1,]= 0) Then Prob = PROBBNML(p[1,], mtemp, t[1,]);
		Else Prob = (PROBBNML(p[1,], mtemp, t[1,])-PROBBNML(p[1,], mtemp, t[1,]-1)); 

		Do i = 2 to (k-1) While (mtemp > 0);
			mtemp = mtemp - t[(i-1),];
			If (mtemp^=0) Then Do;
				ti  = t[(i-1),];
				q   = q - p[(i-1),];
				newp = p[i,]/q;
				If (t[i,]=0) Then Prob = Prob*PROBBNML(newp, mtemp, t[i,]); 
				Else Prob = Prob*(PROBBNML(newp, mtemp, t[i,])-PROBBNML(newp, mtemp, t[i,]-1)); 
			End;
		End;

		If Prob < 1e-50 Then Prob = 1e-50;
		Return(Prob);

	Finish;
	Store Module=ProbMultinomial1;

	Start ProbMultinomial2(m, p, t);

		k    = nrow(p)+1;
		Prob = 1;

		Do i = 1 to (k-1);
			Prob = Prob*((p[i,]**t[i,])/gamma(t[i,]+1));
		End;

		pk = 1-sum(p);
		tk = m-sum(t);

		Prob = Prob*gamma(m+1)*((pk**tk)/gamma(tk+1));
		Return(Prob);

	Finish;
	Store Module=ProbMultinomial2;
	
	Start ProbMultinomial(m, p, t);

		k    = nrow(p)+1;
		Prob = 0;

		Do i = 1 to (k-1);
			Prob = Prob + t[i,]*log(p[i,]) - lgamma(t[i,]+1);
		End;

		pk = 1-sum(p);
		tk = m-sum(t);

		Prob = Prob + lgamma(m+1) + tk*log(pk) - lgamma(tk+1);
		Prob = exp(Prob);
		Return(Prob);

	Finish;
	Store Module=ProbMultinomial;

	/************************************************************/
	/* 	This Module returns P(T1=t1, T2=t2, ... ,Tk=tk) from a 	*/
	/*	Random-clumped Multinomial Distribution					*/
	/*															*/
	/*	m - cluster size										*/
	/*	p - vector of probabilities [p1,p2,...,p(k-1)]`			*/
	/*  rho - correlation										*/
	/*  t - vector of counts [t1,t2,...,t(k-1)]`				*/
	/************************************************************/
	Start ProbRCM(m, pi, rho, t);

		k    = nrow(pi)+1;
		e    = diag(j((k-1),1,rho));
		Prob = 0;

		Do i = 1 to (k-1);
			piI  = (1-rho)*pi + e[,i];
			Prob = Prob + pi[i,]*ProbMultinomial(m, piI, t);
		End;

		piK  = (1-rho)*pi;
		pk   = 1-sum(pi);
		Prob = Prob + pk*ProbMultinomial(m, piK, t);
		Return(Prob);

	Finish;
	Store Module=ProbRCM;

	/************************************************************/
	/* 	This Module returns P(T1=t1, T2=t2, ... ,Tk=tk) from a 	*/
	/*	Dirichlet Multinomial Distribution						*/
	/*															*/
	/*	m - cluster size										*/
	/*	p - vector of probabilities [p1,p2,...,p(k-1)]`			*/
	/*  rho - correlation										*/
	/*  t - vector of counts [t1,t2,...,t(k-1)]`				*/
	/************************************************************/
	Start ProbDM(m, pi, rho, t);

		k    = nrow(pi)+1;
		c    = (1-rho**2)/rho**2;
		Prob = lgamma(m+1)+lgamma(c)-lgamma(m+c);

		Do i = 1 to (k-1);
			Prob = Prob+lgamma(t[i,]+c*pi[i,])-lgamma(t[i,]+1)-lgamma(c*pi[i,]);
		End;

		piK  = 1-sum(pi);
		tK   = m-sum(t);
		Prob = exp(Prob+lgamma(tK+c*piK)-lgamma(tK+1)-lgamma(c*piK));
		Return(Prob);

	Finish;
	Store Module=ProbDM;

	/************************************************************************/
	/* 	This Module returns the vector of partial derivitives				*/
	/*	of the log-likelihood for a Random-clumped Multinomial distribution	*/
	/*																		*/
	/*	m - cluster size													*/
	/*	pi - vector of probabilities [p1,p2,...,p(k-1)]`					*/
	/*	rho - correlation													*/
	/*	t - vector of counts {t1,t2,...,t(k-1)]`							*/
	/************************************************************************/
	Start gradRCM(m, pi, rho, t);

		k    = nrow(pi)+1;
		PrT  = ProbRCM(m, pi, rho, t);
		e    = diag(j((k-1),1,rho));
		piK  = (1-rho)*pi;
		prXk = ProbMultinomial(m, piK, t);
		pk   = 1-sum(pi);
		tk   = m-sum(t);
		aK   = (tk/pk) + (prXk/PrT)*(1-(rho*tk)/((1-rho)*pk+rho));
		grad = j(k,1,0);
			
		Do i = 1 to (k-1);

			piI      = (1-rho)*pi + e[,i];
			prXi     = ProbMultinomial(m, piI, t);
			aI       = (t[i,]/pi[i,]) + (PrXi/PrT)*(1-((rho*t[i,])/piI[i,]));
			grad[i,] = aI - aK;
			grad[k,] = grad[k,] + pi[i,]*prXi*((t[i,]-m*piI[i,])/piI[i,]);
	
		End;

		grad[k,] = (1/((1-rho)*prT))*(grad[k,]+pk*prXk*((tk-m*((1-rho)*pk+rho))/((1-rho)*pk+rho)));
		Return(grad);

	Finish;
	Store Module=gradRCM;

	/************************************************************/
	/* 	This Module returns the vector of partial derivitives	*/
	/*	of the log-likelihood for a dirichlet-multinomial 		*/
	/*	distribution											*/
	/*															*/
	/*	m - cluster size										*/
	/*	pi - vector of probabilities [p1,p2,...,p(k-1)]`		*/
	/*	rho - correlation										*/
	/*	t - vector of counts {t1,t2,...,t(k-1)]`				*/
	/************************************************************/
	Start gradDM(m, pi, rho, t);

		k    = nrow(pi)+1;
		piK  = 1-sum(pi);
		tK   = m-sum(t);
		c    = (1-rho**2)/rho**2;
		grad = j(k,1,0);
		fM   = 0;
		fTk  = 0;
		
		fM     = sum(1/(c:(c+m-1)));
		If (tK > 0) Then fTk = sum(1/(c*piK:(c*piK+tK-1)));
		sumfTi = piK*fTk;
	
		Do i = 1 to (k-1);

			fTi = 0;
			If (t[i,] > 0) Then fTi = sum(1/(c*pi[i,]:(c*pi[i,]+t[i,]-1)));
			grad[i,] = c*(fTi - fTk);
			sumfTi   = sumfTi + pi[i,]*fTi;
	
		End;

		grad[k,] = (2/rho**3)*(fM - sumfTi);
		Return(grad);

	Finish;
	Store Module=gradDM;

	/************************************************************/
	/* 	This Module returns Quasi-likelihood estimators for pi	*/
	/*															*/
	/*	m - cluster size										*/
	/*	T - nxk matrix of counts (t1,t2,...,tk)	where ti is a	*/
	/*      nx1 vectod of observed counts in category i			*/
	/************************************************************/
	Start QLEpi(m, T);
		
		n = nrow(T);
		k = ncol(T);
		
		pi = j((k-1),1,0);		
		Do i = 1 to (k-1);
			pi[i,] = sum(T[,i]);
		End;
		
		pi = (1/(n*m))*pi;	
		return(pi);

	Finish;
	Store Module=QLEpi;	

	/************************************************************/
	/* 	This Module returns Quasi-likelihood estimator for rho	*/
	/*															*/
	/*	m -  cluster size										*/
	/*	T -  nxk matrix of counts (t1,t2,...,tk)` where ti is 	*/
	/*       a nx1 vectod of observed counts in category i		*/
	/*	pihat - vector of quasi-likelihood estimates for pi		*/
	/************************************************************/
	Start QLErho(m, T, pihat);
		
		n = nrow(T);
		k = ncol(T);
		
		SS = j((k-1),(k-1),0);
		Do j = 1 to n;
			tj = T[j,1:(k-1)]`;
			SS = SS + (tj-m*pihat)*(tj-m*pihat)`;
		End;
		
		LH1 = Diag(SS);
		LH2 = Inv(Diag(Diag(pihat)-pihat*pihat`));
		LHS = Trace(LH1*LH2)/(m*(n-1)*(k-1));

		rho = sqrt(max((LHS-1)/(m-1), 0.01));

		return(rho);

	Finish;
	Store Module=QLErho;	

	Quit;
	Run;


	%Macro DirMult_RCMult(data, label);

	title &label;

	Proc IML;
	
	use &data;
	read all into T;

	n = nrow(T);
	k = ncol(T);
	m = sum(T[1,]);

	Parameter = shape({'Pi(1)' 'Pi(2)' 'Pi(3)' 'Pi(4)' 'Pi(5)' 
        'Pi(6)' 'Pi(7)' 'Pi(8)' 'Pi(9)'},k-1,1) // {'Rho'} // {'Log Likelihood'};
	PValue = j(k,1,0);

	mattrib Estimate format=12.5;
	mattrib StdErr   format=12.5;
	mattrib ZStat    format=8.2;
	mattrib PValue   format=pvalue6.4;

	/************************************************/
	/*	MLE from DM Distribution					*/
	/************************************************/
	Load Module=MLEDM;
	piMLE1 = j((k-1),1,0);

	thetaMLE = MLEDM(m, T);
	piMLE1   = thetaMLE[1:(k-1),];
	rhoMLE1  = thetaMLE[k,];

	INVFIM = Inv(n*FIMDM(m, piMLE1, rhoMLE1));
	SE1    = j(k,1,0);
	Do i = 1 to k;
		SE1[i,] = sqrt(INVFIM[i,i]);
	End;

	ll = 0;
	Do j = 1 to n;
		tj = T[j,1:(k-1)]`;
		ll = ll + log(ProbDM(m, piMLE1, rhoMLE1, tj));
	End;

	Estimate = piMLE1 // rhoMLE1;
	StdErr   = SE1;
	ZStat    = Estimate / SE1;
	Estimate = Estimate // ll;
	PValue   = 1 - probnorm(ZStat);

	print "Maximum Likelihood Estimates -- Dirichlet-Multinomial Distribution";
	print Parameter Estimate StdErr ZStat PValue;

	/************************************************/
	/*	MLE from RC Distribution					*/
	/************************************************/
	Load Module=MLERCM;
	piMLE1 = j((k-1),1,0);

	thetaMLE = MLERCM(m, T);
	piMLE1   = thetaMLE[1:(k-1),];
	rhoMLE1  = thetaMLE[k,];

	INVFIM = Inv(n*FIMRCM(m, piMLE1, rhoMLE1));
	SE1 = j(k,1,0);
	Do i = 1 to k;
		SE1[i,] = sqrt(INVFIM[i,i]);
	End;

	ll = 0;
	Do j = 1 to n;
		tj = T[j,1:(k-1)]`;
		ll = ll + log(ProbRCM(m, piMLE1, rhoMLE1, tj));
	End;

	Estimate = piMLE1 // rhoMLE1;
	StdErr   = SE1;
	ZStat    = Estimate / SE1;
	Estimate = Estimate // ll;
	PValue   = 1 - probnorm(ZStat);

	print "Maximum Likelihood Estimates -- Random-clumped Multinomial Distribution";
	print Parameter Estimate StdErr ZStat PValue;

	Quit;

	%mend DirMult_RCMult;






	*--- Chapter 7: Program 7.3 Housing Satisfaction Example using "DirMult_RCMult" Module;

	/*
		Housing Satisfaction, Brier(1980), Non-Metropolitan area (Rural)
	*/

	data housing;
	input t1 t2 t3;
	datalines;
	    3    2    0
	    3    2    0
	    0    5    0
	    3    2    0
	    0    5    0
	    4    1    0
	    3    2    0
	    2    3    0
	    4    0    1
	    0    4    1
	    2    3    0
	    4    1    0
	    4    1    0
	    1    2    2
	    4    1    0
	    1    3    1
	    4    1    0
	    5    0    0
	;

	ods html;
	%DirMult_RCMult(housing, "Housing Satisfaction, Brier(1980), Rural Area" );
	ods html close;







	*--- Chapter 7: Program 7.4 Mosimann Example using "DirMult_RCMult" Module;

	/*
		Forest Pollen Count Example, Mosimann (1962)
    
        Note: Program takes awhile to run.  Please be patient.
	*/

	data pollen_count;
		input t1 t2 t3 @@;
		t4 = 100 - t1 - t2 - t3;
	datalines;
	94	0	5	85	1	12	84	1	12	88	0	9
	75	2	14	91	1	4	97	0	3	94	0	4
	81	2	13	99	1	0	83	0	13	69	7	18
	95	2	3	90	2	8	81	1	15	90	0	8
	89	3	1	91	0	8	81	1	16	86	1	8
	84	5	7	79	1	19	76	2	18	90	0	7
	81	3	10	89	0	7	87	3	7	74	5	16
	97	0	2	95	2	1	91	1	5	82	2	11
	86	1	8	90	3	5	94	0	5	87	3	9
	86	2	11	93	1	6	88	1	11	68	3	26
	82	2	10	90	2	7	93	4	2	77	3	11
	72	1	16	89	2	9	84	0	8	86	2	7
	89	0	9	88	1	9	87	1	12	79	1	11
	93	4	2	99	0	1	89	1	6	87	0	11
	87	1	11	86	1	10	73	0	13	79	1	17
	85	0	12	88	0	7	87	3	8	74	0	19
	91	0	7	91	0	7	94	1	3	80	0	14
	95	1	3	84	0	14	81	2	9	85	3	9
	94	3	3
	;

	ods html;
	%DirMult_RCMult(pollen_count, "Forest Pollen Count Example, Mosimann (1962)");
	ods html close;







	*--- Chapter 7: Program_7.5 Birth Defects Example under DM and RCM Models;

	/*
		Birth Defect Example using DM and RCM Models
		Morel and Koehler (1995)
	*/

	data birth_defects;
	   input group$ @@;
	   do j=1 to 10;
	      input t1-t3 zn2 cd2 cd3 zn2_cd2 zn2_cd3;
	      output;
	   end;
	   drop j;
	   datalines;
	2ZN
	  2  0 11   1 0 0 0 0
	  0  0 15   1 0 0 0 0
	  1  0 13   1 0 0 0 0
	  1  1 13   1 0 0 0 0
	  1  0 12   1 0 0 0 0
	  1  0 12   1 0 0 0 0
	  0  0 13   1 0 0 0 0
	  1  0 10   1 0 0 0 0
	  0  0 16   1 0 0 0 0
	  0  1 11   1 0 0 0 0
	2CD
	  2  5  5   0 1 0 0 0
	 12  0  0   0 1 0 0 0
	  4  5  3   0 1 0 0 0
	  3  8  0   0 1 0 0 0
	  3  8  0   0 1 0 0 0
	  9  4  0   0 1 0 0 0
	  1 12  3   0 1 0 0 0
	  1  9  2   0 1 0 0 0
	  2  4 10   0 1 0 0 0
	  3  0 12   0 1 0 0 0
	3CD
	  6  5  1   0 0 1 0 0
	 11  0  0   0 0 1 0 0
	  8  5  0   0 0 1 0 0
	  8  0  0   0 0 1 0 0
	 14  0  0   0 0 1 0 0
	 11  1  0   0 0 1 0 0
	 12  0  0   0 0 1 0 0
	 13  5  0   0 0 1 0 0
	 12  0  0   0 0 1 0 0
	 12  0  0   0 0 1 0 0
	2ZN2CD
	  1  1  9   1 1 0 1 0
	  0  0 13   1 1 0 1 0
	  1  1 13   1 1 0 1 0
	  4  4  3   1 1 0 1 0
	  0  1 12   1 1 0 1 0
	  0  0 11   1 1 0 1 0
	  0  3  9   1 1 0 1 0
	  2  2  9   1 1 0 1 0
	  0  4 11   1 1 0 1 0
	  1  5  6   1 1 0 1 0
	2ZN3CD
	  4  1  5   1 0 1 0 1
	  4  7  3   1 0 1 0 1
	 13  5  0   1 0 1 0 1
	  2  4  6   1 0 1 0 1
	  6  5  1   1 0 1 0 1
	 11  0  0   1 0 1 0 1
	  5  6  2   1 0 1 0 1
	  4  2  6   1 0 1 0 1
	  6  3  6   1 0 1 0 1
	  5  3  3   1 0 1 0 1
	SC
	  0  0 13   0 0 0 0 0
	  8  0  1   0 0 0 0 0
	  0  0 13   0 0 0 0 0
	  1  0 11   0 0 0 0 0
	  1  0 17   0 0 0 0 0
	  0  0 13   0 0 0 0 0
	  0  0 15   0 0 0 0 0
	  0  0 14   0 0 0 0 0
	  0  0 11   0 0 0 0 0
	  0  0 14   0 0 0 0 0
	UC
	  0  0 13   0 0 0 0 0
	  5  1  7   0 0 0 0 0
	  0  0 13   0 0 0 0 0
	  1  0 11   0 0 0 0 0
	  0  0 13   0 0 0 0 0
	  0  0 11   0 0 0 0 0
	  0  0 11   0 0 0 0 0
	  1  2 10   0 0 0 0 0
	  0  1 12   0 0 0 0 0
	  0  0 12   0 0 0 0 0
	;

	data new_birth_defects;
		set birth_defects;
		litter_id = _n_;
		y = 1; count = t1; output;
		y = 2; count = t2; output;
		y = 3; count = t3; output;
		keep litter_id y zn2 cd2 cd3 zn2_cd3 zn2_cd2 count;
	run;

	data temp;
		set birth_defects;
		m=t1+t2+t3;
	run;
	proc freq data=temp;
		tables m;
	run;

	proc means data=temp mean;
		var m;
	run;

	*--- Fits Cumulative Logits to get initial beta estimates;
	proc logistic data=new_birth_defects;
		model y = zn2 cd2 cd3 zn2_cd3 zn2_cd2 / link=clogit;
		weight count;
	run;


	/*
		Birth Defect Example from Morel and Koehler (1995)
		fitting the Generalized Overdispersed Models
		Dirichlet-multinomial and Random-clumped Multinomial
	    using PROC NLMIXED.
		Testing the Proportionality Assumption using the 
		CONTRAST statement in the NLMIXED procedure.
	*/

	ods html;

	Title "Testing Assumption Proportionality -- Dirichlet-multinomial Distribution";
	ods output Contrasts=Prop_Assump_DM FitStatistics=Fit_DM_full
				ParameterEstimates=Betas_DM CovMatParmEst=Cov_DM;
	Proc nlmixed data=birth_defects cov;
		parms a1=-3.7, a2=-2.4, b11=-0.2, b21=-0.2, b12=3.1,  b22=3.1,
              b13=5.5, b23=5.5, b14=-1.8, b24=-1.8, b15=-1.7, b25=-1.7, 
              rho=0.5;
		bounds 1>rho>0;
		eta1 = a1+b11*zn2+b12*cd2+b13*cd3+b14*zn2_cd2+b15*zn2_cd3;
		eta2 = a2+b21*zn2+b22*cd2+b23*cd3+b24*zn2_cd2+b25*zn2_cd3;
		gamma1 = 1/(1+exp(-eta1));
		gamma2 = 1/(1+exp(-eta2));
		p1 = gamma1;
		p2 = gamma2-gamma1;
		p3 = 1 - p1 - p2;
		m  = t1+t2+t3;
		c  = (1-rho**2)/(rho**2);
		const  = lgamma(m+1)-lgamma(t1+1)-lgamma(t2+1)-lgamma(t3+1);
		loglik = lgamma(c)-lgamma(m+c)+lgamma(t1+c*p1)+lgamma(t2+c*p2)
			   + lgamma(t3+c*p3)-lgamma(c*p1)-lgamma(c*p2)-lgamma(c*p3)
			   + const;
		model t1 ~ general(loglik);
		contrast "Proportionality Assumption Test -- DM  Distribution" 
				b11-b21, b12-b22, b13-b23, b14-b24, b15-b25; 
	Run;


	Title "Testing Assumption Proportionality -- Random-clumped Multinomial Distribution";
	ods output Contrasts=Prop_Assump_RCM FitStatistics=Fit_RCM_full Dimensions=Dimensions_1
				ParameterEstimates=Betas_RCM CovMatParmEst=Cov_RCM;
		Proc nlmixed data=birth_defects cov;
		parms a1=-3.7, a2=-2.4, b11=-0.2, b21=-0.2, b12=3.1,  b22=3.1,
              b13=5.5, b23=5.5, b14=-1.8, b24=-1.8, b15=-1.7, b25=-1.7, 
              rho=0.5;
		bounds 1>rho>0;
		eta1 = a1+b11*zn2+b12*cd2+b13*cd3+b14*zn2_cd2+b15*zn2_cd3;
		eta2 = a2+b21*zn2+b22*cd2+b23*cd3+b24*zn2_cd2+b25*zn2_cd3;
		gamma1 = 1/(1+exp(-eta1));
		gamma2 = 1/(1+exp(-eta2));
		p1 = gamma1;
		p2 = gamma2-gamma1;
		p3 = 1 - p1 - p2;
		m  = t1+t2+t3;
		rhoc   = 1-rho;
		const  = lgamma(m+1)-lgamma(t1+1)-lgamma(t2+1)-lgamma(t3+1);
		loglik = log( (p1*((rhoc*p1+rho)**t1)*((rhoc*p2)**t2)*((rhoc*p3)**t3))
				+ (p2*((rhoc*p1)**t1)*((rhoc*p2+rho)**t2)*((rhoc*p3)**t3))
				+ (p3*((rhoc*p1)**t1)*((rhoc*p2)**t2)*((rhoc*p3+rho)**t3)) )
				+ const;
		model t1 ~ general(loglik);
		contrast "Proportionality Assumption Test -- RCM Distribution" 
				b11-b21, b12-b22, b13-b23, b14-b24, b15-b25; 
	Run;

	ods html close;


	ods html;
	title "Testing Parallelism Assumption using a Wald Statistic";
	data Betas_DM;
		set Betas_DM;
		keep estimate;
	run;

	data Cov_DM;
		set Cov_DM;
		drop row parameter;
	run;

	data Betas_RCM;
		set Betas_RCM;
		keep estimate;
	run;

	data Cov_RCM;
		set Cov_RCM;
		drop row parameter;
	run;

	proc iml;
	use Betas_DM;
	read all into beta;
	use Cov_DM;
	read all into cov;

	c ={0 0 1 -1 0  0  0  0  0  0  0  0  0,
		0 0 0  0 1 -1  0  0  0  0  0  0  0,
		0 0 0  0 0  0  1 -1  0  0  0  0  0,
		0 0 0  0 0  0  0  0  1 -1  0  0  0,
		0 0 0  0 0  0  0  0  0  0  1 -1  0};
	Degrees_of_Freedom = nrow(c);

	Wald_Statistic = beta` * c` * inv(c * cov * c`) * c * beta;
	P_Value        = 1 - probchi(Wald_Statistic,Degrees_of_Freedom,0); 
	print "Dirichlet-multinomial Distribution";
	print Degrees_of_Freedom Wald_Statistic[format=6.2] P_Value[format=pvalue6.4];

	use Betas_RCM;
	read all into beta;
	use Cov_RCM;
	read all into cov;

	Wald_Statistic = beta` * c` * inv(c * cov * c`) * c * beta;
	P_Value        = 1 - probchi(Wald_Statistic,Degrees_of_Freedom,0); 
	print "Random-clumped Multinomial Distribution";
	print Degrees_of_Freedom Wald_Statistic[format=6.2] P_Value[format=pvalue6.4];
	quit;
	ods html close;


	*--- Likelihood Ratio tests for Testing the Parallelism Assumption;
	ods html;
	Title "Proportional-Odds Model -- Dirichlet-multinomial Distribution";
	ods output FitStatistics=Fit_DM_reduced;
	Proc nlmixed data=birth_defects;
		parms a1=-3.7, a2=-2.4, b1=-0.2, b2=3.1, b3=5.5, b4=-1.8, b5=-1.7, rho=0.5;
		bounds 1>rho>0;
		eta1 = a1+b1*zn2+b2*cd2+b3*cd3+b4*zn2_cd2+b5*zn2_cd3;
		eta2 = a2+b1*zn2+b2*cd2+b3*cd3+b4*zn2_cd2+b5*zn2_cd3;
		gamma1 = 1/(1+exp(-eta1));
		gamma2 = 1/(1+exp(-eta2));
		p1 = gamma1;
		p2 = gamma2-gamma1;
		p3 = 1 - p1 - p2;
		m  = t1+t2+t3;
		c  = (1-rho**2)/(rho**2);
		const  = lgamma(m+1)-lgamma(t1+1)-lgamma(t2+1)-lgamma(t3+1);
			loglik = lgamma(c)-lgamma(m+c)+lgamma(t1+c*p1)+lgamma(t2+c*p2)+
					lgamma(t3+c*p3)-lgamma(c*p1)-lgamma(c*p2)-lgamma(c*p3)
					+const;
		model t1 ~ general(loglik);
	Run;

	Title "Proportional-Odds Model -- Random-clumpled Multinomial Distribution";
	ods output FitStatistics=Fit_RCM_reduced Dimensions=Dimensions_0;
	Proc nlmixed data=birth_defects;
		parms a1=-3.7, a2=-2.4, b1=-0.2, b2=3.1, b3=5.5, b4=-1.8, b5=-1.7, rho=0.5;
		bounds 1>rho>0;
		eta1 = a1+b1*zn2+b2*cd2+b3*cd3+b4*zn2_cd2+b5*zn2_cd3;
		eta2 = a2+b1*zn2+b2*cd2+b3*cd3+b4*zn2_cd2+b5*zn2_cd3;
		gamma1 = 1/(1+exp(-eta1));
		gamma2 = 1/(1+exp(-eta2));
		p1 = gamma1;
		p2 = gamma2-gamma1;
		p3 = 1 - p1 - p2;
		m  = t1+t2+t3;
		rhoc = 1-rho;
		const= lgamma(m+1)-lgamma(t1+1)-lgamma(t2+1)-lgamma(t3+1);
		loglik=log( (p1*((rhoc*p1+rho)**t1)*((rhoc*p2)**t2)*((rhoc*p3)**t3))
				+ (p2*((rhoc*p1)**t1)*((rhoc*p2+rho)**t2)*((rhoc*p3)**t3))
				+ (p3*((rhoc*p1)**t1)*((rhoc*p2)**t2)*((rhoc*p3+rho)**t3)) )
				+ const;
		model t1 ~ general(loglik);
	Run;

	data Fit_DM_reduced;
		set Fit_DM_reduced;
		if _n_ = 1;
		rename Value=Value_0;
		Descr = "LR Test -- DM Distribution";
	run;

	data Fit_DM_full;
		set Fit_DM_full;
		if _n_ = 1;
		rename Value=Value_1;
		keep Value;
	run;

	data Fit_DM;
		merge Fit_DM_reduced Fit_DM_full;
	run;

	data Fit_RCM_reduced;
		set Fit_RCM_reduced;
		if _n_ = 1;
		rename Value=Value_0;
		Descr = "LR Test -- RCM Distribution";
	run;

	data Fit_RCM_full;
		set Fit_RCM_full;
		if _n_ = 1;
		rename Value=Value_1;
		keep Value;
	run;

	data Fit_RCM;
		merge Fit_RCM_reduced Fit_RCM_full;
	run;

	data dimensions_1;
		set dimensions_1;
		if _n_ = 4 then call symput('nparms_1',trim(left(Value)));	
	run;	

	data dimensions_0;
		set dimensions_0;
		if _n_ = 4 then call symput('nparms_0',trim(left(Value)));	
	run;

	data LR_Tests;
		set Fit_DM Fit_RCM;
		format Chi_square_Stat 8.2 Degrees_of_Freedom 4.0 Pvalue Pvalue6.4
               Value_0 8.2 Value_1 8.2;
		Chi_square_Stat    = Value_0 - Value_1;
		Degrees_of_Freedom = &nparms_1 - &nparms_0;
		Pvalue             = 1 - probchi(Chi_square_Stat,Degrees_of_Freedom,0); 
	run;

	title "Likelihood Ratio tests for Testing the Parallelism Assumption";
	proc print data=LR_Tests noobs;
	run;	
	ods html close;






	*--- Chapter 7: Program 7.6 Siskel and Ebert Ratings;

	/* 
		Siskel and Ebert Ratings on 160 Movies 
		Agresti and Winner (1997)
	*/

	data movie_ratings;
		input x1-x3;
		Siskel = _n_;
		Ebert = 1; w=x1; output;
		Ebert = 2; w=x2; output;
		Ebert = 3; w=x3; output;
		keep Siskel Ebert w;
		datalines;
		24	8	13
		8	13	11
		10	9	64
	;

	proc format;
		value abc 1 = 'Con'
		          2 = 'Mixed'
				  3 = 'Pro';
	run;

	ods html;
	title1 "Siskel's and Ebert's Movie Ratings -- Agresti and Winner (1997)";
	title2 "Kappa Results using PROC FREQ";
	proc freq data=movie_ratings;
		tables Siskel * Ebert / agree;
		weight w;
		format Siskel Ebert abc.;
	run;
	ods graphics off;
	ods html close;

	ods html;
	ods graphics on;
	proc iml;
		use movie_ratings;
		read all into x;

		n0   = nrow(x);
		n1   = sum(x[,3]);
		t1   = j(n1,3,0);
		t2   = j(n1,3,0);

		row = 0;
		do j=1 to n0;
			do t=1 to x[j,3];
				row            = row + 1; 
				t1[row,x[j,1]] = 1;
				t2[row,x[j,2]] = 1;
			end;
		end;

		t = t1 + t2;
		create new var{t1 t2 t3}; 
	    append from t;
	quit;

	ods output ParameterEstimates=Parms_Estimates
				AdditionalEstimates=Estimates;
	proc nlmixed data=new;
		parms a0=0, b01=0, b02=0;
		rho    = 1 / (1 + exp(-a0));
		eta1   = exp(b01);
		eta2   = exp(b02);
		p1     = eta1/(1+eta1+eta2);
		p2     = eta2/(1+eta1+eta2);
		p3     = 1-p1-p2;
		m      = t1+t2+t3;
		c      = (1-rho**2)/(rho**2);
		const  = lgamma(m+1)-lgamma(t1+1)-lgamma(t2+1)-lgamma(t3+1);
		loglik = lgamma(c)-lgamma(m+c)+lgamma(t1+c*p1)+lgamma(t2+c*p2)
			+lgamma(t3+c*p3)-lgamma(c*p1)-lgamma(c*p2)-lgamma(c*p3)
			+const;
		model t1 ~ general(loglik);
		estimate 'Kappa' 1 / (1 + exp(-a0)) / (1 + exp(-a0));
	run;

	data Estimates;
		set Estimates;
		rename Estimate = Kappa;
		keep Estimate Lower Upper;
	run;

	data Parms_Estimates;
		set Parms_Estimates;
		if Parameter = 'a0';
		Estimate = 1 / (1 + exp(-Estimate)) / (1 + exp(-Estimate));
		Lower    = 1 / (1 + exp(-Lower)) / (1 + exp(-Lower));
		Upper    = 1 / (1 + exp(-Upper)) / (1 + exp(-Upper));
		rename Estimate = Kappa;
		keep Estimate Lower Upper;
	run;

	title2 "Kappa Results using the Estimate Statement in NLMIXED";
	proc print data=Estimates noobs;
	run;

	title2 "Kappa Results using the Inverse Method in NLMIXED";
	proc print data=Parms_Estimates noobs;
	run;
	ods html close;






	*--- Chapter 7: Appendix A Generation data under Dirichlet-multinomial and Random-clumped Multinomial Distributions;
	/*
		Generation of data under the Dirichlet-multinomial and 
		Random-clumped Multinomial distributions
		with parameters Pi(1), Pi(2),...,Pi(d), Rho and m
	*/

	ods html;
	proc iml;

		d     = 3;
		pi_1  = 0.4;
		pi_2  = 0.3;
		pi_3  = 0.2;
		rho   = 0.5;
		m     = 10;
		n     = 20000; 

		pi        = pi_1||pi_2||pi_3;
		True_Mean = m*Pi;
		True_Cov  = m*(diag(pi) - pi`*pi)*(1+(m-1)*rho*rho);
		print 'True Mean and Covariance under Dirichlet-multinomial and Random-clumped Multinomial Models';
		print True_Mean[format=8.4],, True_Cov[format=8.4],,,;

		t_dm  = j(n,d,0);
		t_rcm = j(n,d,0);
		pi_4  = 1-pi_1-pi_2-pi_3;
		pi    = pi || pi_4;
		call randseed(1914); 

		*--- Generation data under the Dirichlet-multinomial distribution;
		c     = 1/rho/rho - 1;
		shape = c*pi;
		do j=1 to n;
			p        = RANDDIRICHLET(1,shape);
			p        = p || (1-sum(p));
			t        = RANDMULTINOMIAL(1,m,p); 
			t_dm[j,] = t[1,1:d];
		end;

		*--- Generation data under the Random-clumped multinomial distribution;
		do j=1 to n;
			y  = RANDMULTINOMIAL(1,1,pi);
			call randgen(nn,'BINOM',rho,m);
			t  = y*nn; *--- Random clumping of the data;
			if nn < m then t = t + RANDMULTINOMIAL(1,m-nn,pi);
			t_rcm[j,] = t[1,1:d];
		end;

		start mean_var(t,n,d);
			SampleMean = t[:,];
			SampleCov = (t`*t - n*SampleMean`*SampleMean ) / (n-d);
			print SampleMean[format=8.4],, SampleCov[format=8.4],,,;
		finish mean_var;
	
		print 'Sample Mean and Covariance -- Dirichlet-multinomial Model';
		call mean_var(t_dm,n,d);
		print 'Sample Mean and Covariance -- Random-clumped Multinomial Model';
		call mean_var(t_rcm,n,d);

	quit;
	ods html close;







	*--- Chapter 8: Module DM_RCM_Exact_and_Approximate;

	/*
	    This Macro is a courtesy of 
        Dr. Justin Newcomer from Sandia National Laboratories

		In order to use the macro "DM_RCM_Exact_Approximate"
		the user should first load all the IML modules associate to
		the macro "DirMult_RCMult" (See Appendix Appendix B, Chapter 7)
	*/


	Proc IML;

	/************************************************************************/
	/* 	Modules for using approximations Fisher Information Matrices        */
	/************************************************************************/	

	/************************************************************/
	/*	Module: AMLEDM(m,T)										*/
	/*															*/
	/* 	This Module computes the MLE from a Dirichlet 			*/
	/*	Multinomial	Distribution using the approximate Fisher 	*/
	/*	Information Matrix and the Fisher Scoring Algorithm		*/
	/*															*/
	/*	m - cluster size										*/
	/*	T - nxk matrix of counts (t1,t2,...,tk)	where ti is a	*/
	/*      nx1 vector of observed counts in category i			*/
	/************************************************************/
	Start AMLEDM(m, T);

		print "*** Fisher Scoring Method using approximate FIM -- Dirichlet-Multinomial Distribution ***";

		pi0   = QLEpi(m,T);
		rho0  = QLErho(m,T,pi0);
		k     = ncol(T);
		n     = nrow(T);
		theta           = j(k,1,0);
		theta[1:(k-1),] = pi0;
		theta[k,]       = rho0;
	
		eps  = 1E-8;
		conv = 1;
		iter = 0;
		Do Until(conv<eps);
		
			iter   = iter + 1;
			pi     = theta[1:(k-1),];
			rho    = theta[k,];
			INVFIM = Inv(n*AFIMDM(m, pi, rho));
			Lold   = 0;
			Scores = j(k,1,0);
			Do j = 1 to n;
				tj     = T[j,1:(k-1)]`;
				Scores = Scores + gradDM(m, pi, rho, tj);
				Lold   = Lold + log(ProbDM(m, pi, rho, tj));
			End;

			si   = 0;
			Lnew = Lold - 1;
			Do Until(Lnew > Lold);

				thetaNew = theta + (0.5**si)*INVFIM*Scores;
				pi       = thetaNew[1:(k-1),];
				rho      = thetaNew[k,];
				Lnew     = 0;
				Do j = 1 to n;
					tj   = T[j,1:(k-1)]`;
					Lnew = Lnew + log(ProbDM(m, pi, rho, tj));
				End;

				si = si + 1;
				if si > 20 then do;
					print "NOTE: Step size halved 20 times, convergence assumed";
					Lnew   = Lold + 0.000001;
				end;

			End;

			theta  = thetaNew;
			conv   = abs(Lnew-Lold)/(abs(Lnew)+1E-6);
			conv_0 = conv;

			if si > 20 then conv = eps - 0.000001;
			if iter > 100 then do;
				print "NOTE: After 100 iterations, convergence not met yet";
				conv = eps - 0.000001;
			end;

		End;
 		
		if conv_0 < eps then do;
			print "NOTE: Convergence criterion (EPSILON=1E-8) satisfied";
		end;

		Return(theta);
		
	Finish;
	Store Module=AMLEDM;	

	/************************************************************************/
	/*	Module: AMLERCM(m,T)												*/
	/*																		*/
	/* 	This Module computes the MLE from a Random-clumped Multinomial		*/
	/* 	Distribution using the approximate Fisher Information 				*/
	/*	Matrix and the Fisher Scoring Algorithm								*/
	/*																		*/
	/*	m - cluster size													*/
	/*	T - nxk matrix of counts (t1,t2,...,tk)	where ti is a				*/
	/*      nx1 vector of observed counts in category i						*/
	/************************************************************************/
	Start AMLERCM(m, T);

		print "*** Fisher Scoring Method using approximate RCM -- Random-clumped Multinomial Distribution ***";

		pi0   = QLEpi(m,T);
		rho0  = QLErho(m,T,pi0);
		k     = ncol(T);
		n     = nrow(T);
		theta           = j(k,1,0);
		theta[1:(k-1),] = pi0;
		theta[k,]       = rho0;
	
		eps  = 1E-8;
		conv = 1;
		iter = 0;
		Do Until(conv<eps);
		
			iter   = iter + 1;
			pi     = theta[1:(k-1),];
			rho    = theta[k,];
			INVFIM = Inv(n*AFIMRCM(m, pi, rho));
			Lold   = 0;
			Scores = j(k,1,0);
			Do j = 1 to n;
				tj     = T[j,1:(k-1)]`;
				Scores = Scores + gradRCM(m, pi, rho, tj);
				Lold   = Lold + log(ProbRCM(m, pi, rho, tj));
			End;

			si   = 0;
			Lnew = Lold - 1;
			Do Until(Lnew > Lold);

				thetaNew = theta + (0.5**si)*INVFIM*Scores;
				pi       = thetaNew[1:(k-1),];
				rho      = thetaNew[k,];
				Lnew     = 0;
				Do j = 1 to n;
					tj   = T[j,1:(k-1)]`;
					Lnew = Lnew + log(ProbRCM(m, pi, rho, tj));
				End;

				si = si + 1;
				if si > 20 then do;
					print "NOTE: Step size halved 20 times, convergence assumed";
					Lnew   = Lold + 0.000001;
				end;

			End;

			theta  = thetaNew;
			conv   = abs(Lnew-Lold)/(abs(Lnew)+1E-6);
			conv_0 = conv;

			if si > 20 then conv = eps - 0.000001;
			if iter > 100 then do;
				print "NOTE: After 100 iterations, convergence not met yet";
				conv = eps - 0.000001;
			end;

		End;
 		
		if conv_0 < eps then do;
			print "NOTE: Convergence criterion (EPSILON=1E-8) satisfied";
		end;

		Return(theta);

	Finish;
	Store Module=AMLERCM;

	/****************************************************************/
	/*	Module: AFIMDM(m,pi,rho)									*/
	/*																*/
	/* 	This Module returns the Approximate Fisher Information 		*/
	/*	Matrix for a Dirichlet-Multinomial Distribution				*/
	/*																*/
	/*	References: Neerchal and Morel, CSDA (2004) - Result 1		*/
	/*			  	Neerchal and Morel, JASA (1998) - Theorem 1		*/
	/*																*/
	/*	m - cluster size											*/
	/*	pi - vector of probabilities [pi1, pi2, ... , pi(k-1)]`		*/
	/*	rho - correlation											*/
	/****************************************************************/
	Start AFIMDM(m, pi, rho);

		k = nrow(pi)+1;
		c = (1-rho**2)/rho**2;

		FIM = j(k,k,0);

		piK = 1-sum(pi);
		PrK = TriGamma(c*piK);
		PrC = TriGamma(c);
		Do i = 1 to (k-1);

			piI      = pi[i,];
			PrI      = TriGamma(c*piI);
			FIM[i,i] = (c**2)*(PrI + PrK);
			Do j = (i+1) to (k-1);
				FIM[i,j] = (c**2)*PrK;
				FIM[j,i] = (c**2)*PrK;
			End;
			FIM[i,k] = c*(piK*PrK - piI*PrI)*(2/rho**3);
			FIM[k,i] = c*(piK*PrK - piI*PrI)*(2/rho**3);
			FIM[k,k] = FIM[k,k] + (piI**2)*PrI;

		End;

		FIM[k,k] = (FIM[k,k] + (piK**2)*PrK - PrC)*(4/rho**6);
		Return(FIM);

	Finish;
	Store Module=AFIMDM;

	/*****************************************************************/
	/*	Module: AFIMRCM(m,pi,rho)									 */
	/*																 */
	/* 	This Module returns the Approximate Fisher Information 		 */
	/*	Matrix for a Random-clumped Multinomial Distribution		 */
	/*																 */
	/*	References: Neerchal and Morel, CSDA (2004) - Result 2		 */
	/*				Neerchal and Morel, JASA (1998) - Theorem 2		 */
	/*				Morel and Nagaraj, Biometrika (1993) - Theorem 1 */
	/*																 */
	/*	m - cluster size											 */
	/*	pi - vector of probabilities [pi1, pi2, ... , pi(k-1)]`		 */
	/*	rho - correlation											 */
	/*****************************************************************/
	Start AFIMRCM(m, pi, rho);
		
		k   = nrow(pi)+1;
		FIM = j(k,k,0);
		
		piK    = 1-sum(pi);
		betaK  = piK/((1-rho)*piK+rho) + (1-piK)/((1-rho)*piK);
		gammaK = (piK*(1-piK))/((1-rho)*piK+rho) + piK/(1-rho);
		Do i = 1 to (k-1);
			
			piI      = pi[i,];
			betaI    = piI/((1-rho)*piI+rho) + (1-piI)/((1-rho)*piI);
			gammaI   = (piI*(1-piI))/((1-rho)*piI+rho) + piI/(1-rho);
			FIM[i,i] = m*((1-rho)**2)*(betaI+betaK) + (1/piI + 1/piK);
			Do j = (i+1) to (k-1);
				FIM[i,j] = m*((1-rho)**2)*betaK + 1/piK;
				FIM[j,i] = m*((1-rho)**2)*betaK + 1/piK;
			End;
			FIM[i,k] = m*(1-rho)*(gammaI-gammaK);
			FIM[k,i] = m*(1-rho)*(gammaI-gammaK);
			FIM[k,k] = FIM[k,k] + (piI*(1-piI))/((1-rho)*piI+rho);

		End;

		FIM[k,k] = (FIM[k,k] + (piK*(1-piK))/((1-rho)*piK+rho))*(m/(1-rho));
		Return(FIM);
		
	Finish;
	Store Module=AFIMRCM;
	
	/************************************************************/
	/*	Module: Stage2DM(m,T)									*/
	/*															*/
	/* 	This Module performs the the Two-Stage Procedure        */
	/*	under the Dirichlet-Multinomial	Distribution 			*/
	/*															*/
	/*	m - cluster size										*/
	/*	T - nxk matrix of counts (t1,t2,...,tk)	where ti is a	*/
	/*      nx1 vector of observed counts in category i			*/
	/************************************************************/
	Start Stage2DM(m, T);

		/* Stage 1 */
		k     = ncol(T);
		n     = nrow(T);
		theta = j(k,1,0);
		theta = AMLEDM(m, T);
	
		/* Stage 2 */
		pi     = theta[1:(k-1),];
		rho    = theta[k,];
		INVFIM = Inv(n*FIMDM(m, pi, rho));
		Lold   = 0;
		Scores = j(k,1,0);
		Do j = 1 to n;
			tj     = T[j,1:(k-1)]`;
			Scores = Scores + gradDM(m, pi, rho, tj);
			Lold   = Lold + log(ProbDM(m, pi, rho, tj));
		End;

		*--- Updates Theta, Step size will be halved up to 20 times;

		si   = 0;
		Lnew = Lold - 1;
		Do Until(Lnew > Lold);

			thetaNew = theta + (0.5**si)*INVFIM*Scores;
			pi       = thetaNew[1:(k-1),];
			rho      = thetaNew[k,];
			Lnew     = 0;
			Do j = 1 to n;
				tj   = T[j,1:(k-1)]`;
				Lnew = Lnew + log(ProbDM(m, pi, rho, tj));
			End;

			si = si + 1;
			if si > 20 then do;
				print "NOTE: At Stage 2, Step size halved 20 times without further improvement";
				Lnew   = Lold + 0.000001;
			end;

		End;

		if si <= 20 then theta = thetaNew;

		Return(theta);

	Finish;
	Store Module=Stage2DM;

	
	/************************************************************/
	/*	Module: Stage2RCM(m,T)									*/
	/*															*/
	/* 	This Module performs the the Two-Stage Procedure        */
	/*	under the Random-clumped Multinomial Distribution 		*/
	/*															*/
	/*	m - cluster size										*/
	/*	T - nxk matrix of counts (t1,t2,...,tk)	where ti is a	*/
	/*      nx1 vector of observed counts in category i			*/
	/************************************************************/
	Start Stage2RCM(m, T);

		/* Stage 1 */
		k     = ncol(T);
		n     = nrow(T);
		theta = j(k,1,0);
		theta = AMLERCM(m, T);
	
		/* Stage 2 */
		pi     = theta[1:(k-1),];
		rho    = theta[k,];
		INVFIM = Inv(n*FIMRCM(m, pi, rho));
		Lold   = 0;
		Scores = j(k,1,0);
		Do j = 1 to n;
			tj     = T[j,1:(k-1)]`;
			Scores = Scores + gradRCM(m, pi, rho, tj);
			Lold   = Lold + log(ProbRCM(m, pi, rho, tj));
		End;

		*--- Updates Theta, Step size will be halved up to 20 times;

		si   = 0;
		Lnew = Lold - 1;
		Do Until(Lnew > Lold);

			thetaNew = theta + (0.5**si)*INVFIM*Scores;
			pi       = thetaNew[1:(k-1),];
			rho      = thetaNew[k,];
			Lnew     = 0;
			Do j = 1 to n;
				tj   = T[j,1:(k-1)]`;
				Lnew = Lnew + log(ProbRCM(m, pi, rho, tj));
			End;

			si = si + 1;
			if si > 20 then do;
				print "NOTE: At Stage 2, Step size halved 20 times without further improvement";
				Lnew   = Lold + 0.000001;
			end;

		End;

		if si <= 20 then theta = thetaNew;

		Return(theta);

	Finish;
	Store Module=Stage2RCM;


	Quit;
	Run;


	%Macro DM_RCM_Exact_Approximate(data, label);

	title &label;

	Proc IML;
	
	use &data;
	read all into T;

	n = nrow(T);
	k = ncol(T);
	m = sum(T[1,]);

	Parameter = shape({'Pi(1)' 'Pi(2)' 'Pi(3)' 'Pi(4)' 'Pi(5)' 
        'Pi(6)' 'Pi(7)' 'Pi(8)' 'Pi(9)'},k-1,1) // {'Rho'} // {'Log Likelihood'};
	PValue = j(k,1,0);

	mattrib Estimate      format=12.5;
	mattrib StdErr        format=12.6;
	mattrib AppStdErr     format=12.6;
	mattrib Pct_Rel_Error format=12.5;

	/************************************************/
	/*	MLE from DM Distribution					*/
	/************************************************/
	Load Module=MLEDM;

	thetaMLE = MLEDM(m, T);
	piMLE1   = thetaMLE[1:(k-1),];
	rhoMLE1  = thetaMLE[k,];

	INVFIM = Inv(n*FIMDM(m, piMLE1, rhoMLE1));
	SE1    = j(k,1,0);
	Do i = 1 to k;
		SE1[i,] = sqrt(INVFIM[i,i]);
	End;

	ll = 0;
	Do j = 1 to n;
		tj = T[j,1:(k-1)]`;
		ll = ll + log(ProbDM(m, piMLE1, rhoMLE1, tj));
	End;

	Estimate      = piMLE1 // rhoMLE1 // ll;
	StdErr        = SE1;
	Pct_Rel_Error = StdErr;

	/****************************************************/
	/*	MLE from DM Distribution using approximate FIM 	*/
	/****************************************************/

	Load Module=Stage2DM;

	thetaMLEA = Stage2DM(m, T);
	piMLE1    = thetaMLEA[1:(k-1),];
	rhoMLE1   = thetaMLEA[k,];

	INVFIM = Inv(n*FIMDM(m, piMLE1, rhoMLE1));  *--- Updates FIM;
	SE1    = j(k,1,0);
	Do i = 1 to k;
		SE1[i,] = sqrt(INVFIM[i,i]);
	End;

	ll = 0;                                    *--- Updates log-likelihood;
	Do j = 1 to n;
		tj = T[j,1:(k-1)]`;
		ll = ll + log(ProbDM(m, piMLE1, rhoMLE1, tj));
	End;

	AppStdErr     = SE1;
	Pct_Rel_Error = 100*abs((Pct_Rel_Error - AppStdErr)/Pct_Rel_Error);

	print "Maximum Likelihood Estimates using FIM and Approximate FIM -- Dirichlet-Multinomial Distribution";
	print Parameter Estimate StdErr AppStdErr Pct_Rel_Error;

	/************************************************/
	/*	MLE from RCM Distribution					*/
	/************************************************/
	Load Module=MLERCM;

	thetaMLE = MLERCM(m, T);
	piMLE1   = thetaMLE[1:(k-1),];
	rhoMLE1  = thetaMLE[k,];

	INVFIM = Inv(n*FIMRCM(m, piMLE1, rhoMLE1));
	SE1 = j(k,1,0);
	Do i = 1 to k;
		SE1[i,] = sqrt(INVFIM[i,i]);
	End;

	ll = 0;
	Do j = 1 to n;
		tj = T[j,1:(k-1)]`;
		ll = ll + log(ProbRCM(m, piMLE1, rhoMLE1, tj));
	End;

	Estimate      = piMLE1 // rhoMLE1 // ll;
	StdErr        = SE1;
	Pct_Rel_Error = StdErr;

	/****************************************************/
	/*	MLE from RCM Distribution using approximate FIM */
	/****************************************************/

	Load Module=Stage2RCM;

	thetaMLEA = Stage2RCM(m, T);
	piMLE1    = thetaMLEA[1:(k-1),];
	rhoMLE1   = thetaMLEA[k,];

	INVFIM = Inv(n*FIMRCM(m, piMLE1, rhoMLE1)); *--- Updates FIM;
	SE1    = j(k,1,0);
	Do i = 1 to k;
		SE1[i,] = sqrt(INVFIM[i,i]);
	End;

	ll = 0;                                     *--- Updates log-likelihood;
	Do j = 1 to n;
		tj = T[j,1:(k-1)]`;
		ll = ll + log(ProbRCM(m, piMLE1, rhoMLE1, tj));
	End;

	AppStdErr     = SE1;
	Pct_Rel_Error = 100*abs((Pct_Rel_Error - AppStdErr)/Pct_Rel_Error);

	print "Maximum Likelihood Estimates using FIM and Approximate FIM -- Random-clumped Multinomial Distribution";
	print Parameter Estimate StdErr AppStdErr Pct_Rel_Error;

	Quit;

	title;

	%mend DM_RCM_Exact_Approximate;






	*--- Chapter 8: Example 8.1 Mosimann Example Using Exact and Approximate FIM;

	/*
		Forest Pollen Count Example, Mosimann (1962)

	    Note: Program takes awhile to run.  Please be patient.
	*/

	data pollen_count;
	input t1 t2 t3 @@;
	t4 = 100 - t1 - t2 - t3;
	if t1 = . then delete;
	datalines;
	94	0	5	85	1	12	84	1	12	88	0	9
	75	2	14	91	1	4	97	0	3	94	0	4
	81	2	13	99	1	0	83	0	13	69	7	18
	95	2	3	90	2	8	81	1	15	90	0	8
	89	3	1	91	0	8	81	1	16	86	1	8
	84	5	7	79	1	19	76	2	18	90	0	7
	81	3	10	89	0	7	87	3	7	74	5	16
	97	0	2	95	2	1	91	1	5	82	2	11
	86	1	8	90	3	5	94	0	5	87	3	9
	86	2	11	93	1	6	88	1	11	68	3	26
	82	2	10	90	2	7	93	4	2	77	3	11
	72	1	16	89	2	9	84	0	8	86	2	7
	89	0	9	88	1	9	87	1	12	79	1	11
	93	4	2	99	0	1	89	1	6	87	0	11
	87	1	11	86	1	10	73	0	13	79	1	17
	85	0	12	88	0	7	87	3	8	74	0	19
	91	0	7	91	0	7	94	1	3	80	0	14
	95	1	3	84	0	14	81	2	9	85	3	9
	94	3	3
	;

	ods html;
	%DM_RCM_Exact_Approximate(pollen_count,"Forest Pollen Count Example, Mosimann (1962)");
	ods html close;





	*--- Chapter 8: Example 8.2 Housing Satisfaction Example using Exact and Approximate FIM;

	/*
		Housing Satisfaction, Brier(1980), Non-Metropolitan area (Rural)
	*/

	data housing;
	input t1 t2 t3;
	datalines;
	    3    2    0
	    3    2    0
	    0    5    0
	    3    2    0
	    0    5    0
	    4    1    0
	    3    2    0
	    2    3    0
	    4    0    1
	    0    4    1
	    2    3    0
	    4    1    0
	    4    1    0
	    1    2    2
	    4    1    0
	    1    3    1
	    4    1    0
	    5    0    0
	;

	ods html;
	%DM_RCM_Exact_Approximate(housing,"Housing Satisfaction, Brier(1980), Rural Area");
	ods html close;








	*--- Chapter 9: Program 9.1 G Side and R Side Simulated Data;

	data hair;
		seed = 1999;
		beta = 1.386294;  *--- P is approximately 0.8;
		do Subj_id=1 to 1000;
		s1 = 2*normal(seed);
		s2 = sqrt(1.5)*normal(seed);
			do week=1 to 8;
				score = round(s1 + normal(seed), 0.01);
				p     = 1/(1+exp(-beta - s2));
				y     = 0;
				u     = uniform(seed);
				if u < p then y = 1;
				output;
			end;
		end;
	keep subj_id score y;
	run;

	ods html;
	title "*** Linear Mixed Model with G-side Random Effects ***";
	 proc glimmix data=hair;
		class subj_id;
		model score =  / s;
		random int / subject=subj_id;
	run;

	title "*** Linear Mixed Model with R-side Random Effects ***";
	proc glimmix data=hair;
		class subj_id;
		model score =  / s;
		random _residual_ / subject=subj_id type=cs;
	run;

	title "*** Logistic Model with G-side Random Effects ***";
	 proc glimmix data=hair;
		class subj_id;
		model y (ref='0') =  / dist=binary link=logit s;
		random int / subject=subj_id; 
		estimate 'P' int 1 / ilink;
	run;

	title "*** Logistic Model with R-side Random Effects ***";
	proc glimmix data=hair;
		class subj_id;
		model y (ref='0')=  / dist=binary link=logit s;
		random _residual_ / subject=subj_id type=cs;
		estimate 'P' int 1 / ilink;
	run;
	ods html close;







	*--- Chapter 9: Program 9.2 GEE with Binomial or Binary Outcomes;

	/* 
		Ossification Example from Morel and Neerchal (1997), 
		Statistics in Medicine, 16, 2843-2853
	*/

	data ossification;
	  	length tx $8;
	   	input tx$ n @@;
	   	PHT  = 1;
	   	TCPO = 1;
	   	do i=1 to n;
	   	  	Litters + 1;
	      	input t m @@;
				if tx = 'PHT' then PHT = 0;
			  	if tx = 'TCPO' then TCPO = 0;
			  	if tx = 'PHT+TCPO' then do;
					PHT  = 0;
					TCPO = 0;
			  	end;
	      output;
	   end;
	   drop n i;
	   datalines;
	Control  18 8 8 9  9  7  9 0  5 3  3 5 8 9 10 5 8 5 8 1 6 0 5
	            8 8 9 10  5  5 4  7 9 10 6 6 3  5 
	Control  17 8 9 7 10 10 10 1  6 6  6 1 9 8  9 6 7 5 5 7 9
	            2 5 5  6  2  8 1  8 0  2 7 8 5  7
	PHT      19 1 9 4  9  3  7 4  7 0  7 0 4 1  8 1 7 2 7 2 8 1 7
	            0 2 3 10  3  7 2  7 0  8 0 8 1 10 1 1
	TCPO     16 0 5 7 10  4  4 8 11 6 10 6 9 3  4 2 8 0 6 0 9
	            3 6 2  9  7  9 1 10 8  8 6 9
	PHT+TCPO 11 2 2 0  7  1  8 7  8 0 10 0 4 0  6 0 7 6 6 1 6 1 7
	;

	ods html;
	title "*** Ossification Data -- GEE using GENMOD with Independent Working Correlation Matrix***";
	proc genmod data=ossification;
		class litters tcpo pht / param=ref;
	   	model t/m = tcpo pht tcpo*pht / dist=binomial link=logit;
	   	repeated subject=litters / type=ind;
   	run;
	ods html close;


   	data ossification_b;
   	set ossification;
		do i=1 to t;
			y = 1;
			output;
		end;
		do i=1 to m-t;
			y = 0;
			output;
		end;
	run;

	ods html;
 	title "*** Ossification Data -- GEE using GENMOD with Exchangeable Working Correlation Matrix***";
  	proc genmod data=ossification_b descending;
		class litters tcpo pht / param=ref;
		model y = tcpo pht tcpo*pht / dist=binomial link=logit;
	   	repeated subject=litters / type=exch;
   	run;
	ods html close;






	*--- Chapter 9: Program 9.3 Seizure Counts on Epileptics;

	/*
		Analysis Thall and Vail (1990) Example
		using a Marginal GEE Model with R-side
		random effects.
		Program can be found in the GLIMMIX documentation.
	*/

   data seizures;
      array c{5};
      input id trt c1-c5;
      do i=1 to 5;
         x1    = (i > 1);
         ltime = (i=1)*log(8) + (i ne 1)*log(2);
         cnt   = c{i};
         output;
      end;
      keep id cnt x1 trt ltime;
      datalines;
   101 1  76 11 14  9  8
   102 1  38  8  7  9  4
   103 1  19  0  4  3  0
   104 0  11  5  3  3  3
   106 0  11  3  5  3  3
   107 0   6  2  4  0  5
   108 1  10  3  6  1  3
   110 1  19  2  6  7  4
   111 1  24  4  3  1  3
   112 1  31 22 17 19 16
   113 1  14  5  4  7  4
   114 0   8  4  4  1  4
   116 0  66  7 18  9 21
   117 1  11  2  4  0  4
   118 0  27  5  2  8  7
   121 1  67  3  7  7  7
   122 1  41  4 18  2  5
   123 0  12  6  4  0  2
   124 1   7  2  1  1  0
   126 0  52 40 20 23 12
   128 1  22  0  2  4  0
   129 1  13  5  4  0  3
   130 0  23  5  6  6  5
   135 0  10 14 13  6  0
   137 1  46 11 14 25 15
   139 1  36 10  5  3  8
   141 0  52 26 12  6 22
   143 1  38 19  7  6  7
   145 0  33 12  6  8  4
   147 1   7  1  1  2  3
   201 0  18  4  4  6  2
   202 0  42  7  9 12 14
   203 1  36  6 10  8  8
   204 1  11  2  1  0  0
   205 0  87 16 24 10  9
   206 0  50 11  0  0  5
   208 1  22  4  3  2  4
   209 1  41  8  6  5  7
   210 0  18  0  0  3  3
   211 1  32  1  3  1  5
   213 0 111 37 29 28 29
   214 1  56 18 11 28 13
   215 0  18  3  5  2  5
   217 0  20  3  0  6  7
   218 1  24  6  3  4  0
   219 0  12  3  4  3  4
   220 0   9  3  4  3  4
   221 1  16  3  5  4  3
   222 0  17  2  3  3  5
   225 1  22  1 23 19  8
   226 0  28  8 12  2  8
   227 0  55 18 24 76 25
   228 1  25  2  3  0  1
   230 0   9  2  1  2  1
   232 1  13  0  0  0  0
   234 0  10  3  1  4  2
   236 1  12  1  4  3  2
   238 0  47 13 15 13 12
   ;

	ods html;
	title "*** Poisson Generalized Linear Model ***"; 
   	proc glimmix data=seizures;
    	model cnt = x1 trt x1*trt / dist=poisson offset=ltime
                                  ddfm=none s;
   	run;

 	title "*** Marginal GEE Poisson Model with Compound Symmetry ***"; 
  	proc glimmix data=seizures empirical;
	   class id;
	   model cnt = x1 trt x1*trt / dist=poisson offset=ltime
                                  ddfm=none s;
	   random _residual_ / subject=id type=cs vcorr;
   	run;
	ods html close;


	ods html;
 	title "*** Rates Progabide Trial ***"; 
  	proc glimmix data=seizures empirical;
	   class id;
	   model cnt = x1 trt x1*trt / dist=poisson offset=ltime
                                  ddfm=none s;
	   random _residual_ / subject=id type=vc vcorr;
	   estimate 'Rate Placebo Baseline' int 1 / ilink;
	   estimate 'Rate Placebo TRT Phase' int 1 x1 1 / ilink;
	   estimate 'Rate Progabide Baseline' int 1 trt 1 / ilink;
	   estimate 'Rate Progabide TRT Phase' int 1 x1 1 trt 1 x1*trt 1 / ilink;
	   estimate 'Placebo Baseline / Progabide Baseline' trt -1 / ilink;
	   estimate 'Placebo TRT Phase / Progabide TRT Phase' trt -1 x1*trt -1 / ilink;
	   estimate '(R1) Placebo TRT Phase / Placebo Baseline' x1 1 / ilink;
	   estimate '(R2) Progabide TRT Phase / Progabide Baseline' x1 1 x1*trt 1 / ilink;
	   estimate '(R3) = (R1) / (R2)' x1*trt -1 / ilink;
   	run;
	ods html close;






	*--- Chapter 9: Program 9.4 Ratio Estimation -- Large Cities in the USA in 1920 and 1930;

	/*
		Ratio Estimation
		Sizes of 49 Large United States Cities (in 1000’s) in 1920 and 1930
		Cochran (1977, page 152)
	*/	

	data cities;
		input z y @@;
		id  = _n_;
		datalines;
		76	80	2	50	243	291
		138	143	507	634	87	105
		67	67	179	260	30	11
		29	50	121	113	71	79
		381	464	50	64	256	288
		23	48	44	58	43	61
		37	63	77	89	25	57
		120	115	64	63	94	95
		61	69	64	77	43	50
		387	459	56	142	298	317
		93	104	40	60	36	46
		172	183	40	64	161	232
		78	106	38	52	74	93
		66	86	136	139	45	53
		60	57	116	130	36	54
		46	65	46	53	50	58
						48	75
		;

	ods html;
	title1 "Ratio of Two Correlated Means";
    title2 "Sizes of 49 Large United States Cities in 1920 and 1930";
	proc glimmix data=cities empirical;
		lnz = log(z);
		class id;
		model y = / dist=poisson offset=lnz ddfm=none;
		random _residual_ / subject=id;
		estimate 'LogRatio' intercept 1 / ilink cl;
	run;
	ods html close;

	data cities;
		set cities;
		lnz = log(z);
	run;


	ods html;
	title1 "Ratio of Two Correlated Means";
    title2 "Sizes of 49 Large United States Cities in 1920 and 1930";
	proc genmod data=cities ;
	class id;
		model y = / dist=poisson offset=lnz;
		repeated subject=id;
		estimate 'LogRatio' intercept 1 ;
		run;
	ods html close;






	*--- Chapter 9: Program 9.5 Relative Risk and Rate Ratio;

	/*
		Relative Risk and Rate Ratio
		Hypothetical Data from a Clinical Trial with Rate Ratio = 4
		Morel and Neerchal (2008)
	*/

	data adverse_events; 
		input treat y time;
		offs = log(time);
		id   = _n_;
		datalines;
		1	0	 4.6
		1	0	10.0
		1	0	14.5
		1	0	52.0
		1	1	 7.2
		1	1	16.3
		1	1	17.6
		1	1	23.8
		1	1	24.5
		1	1	29.5
		2	0	 6.1
		2	0	32.5
		2	0	52.0
		2	0	52.0
		2	0	52.0
		2	0	52.0
		2	0	52.0
		2	1	31.0
		2	1	32.0
		2	1	38.4
	;
	
	ods html;
	title "Relative Risk Results";
	proc genmod data=adverse_events;
		class id treat;
		model y = treat / dist=poisson link=log;
		repeated subject=id / type=ind;
		lsmeans treat;
		estimate 'Active Vs Placebo' treat 1  -1;
	run;

	title "Rate Ratio Results";
	proc genmod data=adverse_events;
		class id treat;
		model y = treat / dist=poisson link=log offset=offs;
		repeated subject=id / type=ind;
		lsmeans treat;
		estimate 'Active Vs Placebo' treat 1  -1;
	run;
	ods html close;
 

	title "Relative Risk Results";
	proc genmod data=adverse_events descending;
		class id treat;
		model y = treat / dist=binomial link=log;
		repeated subject=id / type=ind;
		lsmeans treat;
		estimate 'Active Vs Placebo' treat 1  -1;
	run;







	*--- Chapter 9: Program 9.6 Shoulder Pain Example -- GEE;

   	/* 
		Reference: Lumley, T. (1996) "Generalized Estimating Equations for Ordinal
		Data: A Note on Working Correlation Structures."  Biometrics 52, 354-363 
	*/

    data Shoulder_tip_pain;
	    input trt $ gender $ age t1-t6;
	    subject_id = _n_;
		array tt t1-t6;
       	do over tt;
          	y    = tt;
		  	time = _i_;
          	output;
       	end;
	    datalines;
	    y  f  64  1  1  1  1  1  1
	    y  m  41  3  2  1  1  1  1
	    y  f  77  3  2  2  2  1  1
	    y  f  54  1  1  1  1  1  1
	    y  f  66  1  1  1  1  1  1
	    y  m  56  1  2  1  1  1  1
	    y  m  81  1  3  2  1  1  1
	    y  f  24  2  2  1  1  1  1
	    y  f  56  1  1  1  1  1  1
	    y  f  29  3  1  1  1  1  1
	    y  m  65  1  1  1  1  1  1
	    y  f  68  2  1  1  1  1  2
	    y  m  77  1  2  2  2  2  2
	    y  m  35  3  1  1  1  3  3
	    y  m  66  2  1  1  1  1  1
	    y  f  70  1  1  1  1  1  1
	    y  m  79  1  1  1  1  1  1
	    y  f  65  2  1  1  1  1  1
	    y  f  61  4  4  2  4  2  2
	    y  f  67  4  4  4  2  1  1
	    y  f  32  1  1  1  2  1  1
	    y  f  33  1  1  1  2  1  2
	    n  f  20  5  2  3  5  5  4
	    n  f  50  1  5  3  4  5  3
	    n  f  40  4  4  4  4  1  1
	    n  m  54  4  4  4  4  4  3
	    n  m  34  2  3  4  3  3  2
	    n  f  34  3  4  3  3  3  2
	    n  m  56  3  3  4  4  4  3
	    n  f  82  1  1  1  1  1  1
	    n  m  56  1  1  1  1  1  1
	    n  m  52  1  5  5  5  4  3
	    n  f  65  1  3  2  2  1  1
	    n  f  53  2  2  3  4  2  2
	    n  f  40  2  2  1  3  3  2
	    n  f  58  1  1  1  1  1  1
	    n  m  63  1  1  1  1  1  1
	    n  f  41  5  5  5  4  3  3
	    n  m  72  3  3  3  3  1  1
	    n  f  60  5  4  4  4  2  2
	    n  m  61  1  3  3  3  2  1
    ;

	proc format;
		value $abc 'y' = 'Active'
		           'n' = 'Placebo';
		value $xyz 'f' = 'Female'
		           'm' = 'Male';
	run;

	ods html;
	proc surveylogistic data=Shoulder_tip_pain;
		class trt gender;
		model y = trt gender age time / link=clogit ;
		cluster subject_id;
		format trt $abc. gender $xyz. ;
		title1 '*** Results from fitting a GEE Cumulative Logit Model ***';
		title2 '*** to the Shoulder Tip Pain Data in Lumley (1996)    ***';
	run;
	ods html close;


	proc genmod data=Shoulder_tip_pain;
		class subject_id trt gender;
		model y  = trt gender age time / dist=mult link=clogit type3;
		repeated subject=subject_id / type=ind;
		format trt $abc. gender $xyz. ;
		title3 '*** Results using PROC GENMOD ***';
	run;






	*--- Chapter 9: Program 9.7  Small Sample Bias Corrections;

	/* 
		Ossification Example from Morel and Neerchal (1997), 
		Statistics in Medicine, 16, 2843-2853
	*/

	data ossification;
	  	length tx $8;
	   	input tx$ n @@;
	   	PHT  = 1;
	   	TCPO = 1;
	   	do i=1 to n;
	   	  	Litters + 1;
	      	input t m @@;
				if tx = 'PHT' then PHT = 0;
			  	if tx = 'TCPO' then TCPO = 0;
			  	if tx = 'PHT+TCPO' then do;
					PHT  = 0;
					TCPO = 0;
			  	end;
	      output;
	   end;
	   drop n i;
	   datalines;
	Control  18 8 8 9  9  7  9 0  5 3  3 5 8 9 10 5 8 5 8 1 6 0 5
	            8 8 9 10  5  5 4  7 9 10 6 6 3  5 
	Control  17 8 9 7 10 10 10 1  6 6  6 1 9 8  9 6 7 5 5 7 9
	            2 5 5  6  2  8 1  8 0  2 7 8 5  7
	PHT      19 1 9 4  9  3  7 4  7 0  7 0 4 1  8 1 7 2 7 2 8 1 7
	            0 2 3 10  3  7 2  7 0  8 0 8 1 10 1 1
	TCPO     16 0 5 7 10  4  4 8 11 6 10 6 9 3  4 2 8 0 6 0 9
	            3 6 2  9  7  9 1 10 8  8 6 9
	PHT+TCPO 11 2 2 0  7  1  8 7  8 0 10 0 4 0  6 0 7 6 6 1 6 1 7
	;

   	data ossification_b;
   	set ossification;
		do i=1 to t;
			y = 1;
			output;
		end;
		do i=1 to m-t;
			y = 0;
			output;
		end;
	run;

	ods html;
 	title "*** Ossification Data -- GEE using GLIMMIX with EMPIRICAL=CLASSIC ***";
  	proc glimmix data=ossification_b empirical;
		class litters tcpo pht ;
		model y (ref='0') = tcpo pht tcpo*pht / dist=binary link=logit s;
	   	random _residual_ / subject=litters type=vc;
   	run;

 	title "*** Ossification Data -- GEE using GLIMMIX with EMPIRICAL=FIRORES ***";
  	proc glimmix data=ossification_b empirical=firores;
		class litters tcpo pht ;
		model y (ref='0') = tcpo pht tcpo*pht / dist=binary link=logit s;
	   	random _residual_ / subject=litters type=vc;
   	run;

 	title "*** Ossification Data -- GEE using GLIMMIX with EMPIRICAL=FIROEEQ ***";
  	proc glimmix data=ossification_b empirical=firoeeq;
		class litters tcpo pht ;
		model y (ref='0') = tcpo pht tcpo*pht / dist=binary link=logit s;
	   	random _residual_ / subject=litters type=vc;
   	run;

 	title "*** Ossification Data -- GEE using GLIMMIX with EMPIRICAL=MBN ***";
  	proc glimmix data=ossification_b empirical=mbn;
		class litters tcpo pht ;
		model y (ref='0') = tcpo pht tcpo*pht / dist=binary link=logit s;
	   	random _residual_ / subject=litters type=vc;
   	run;
	ods html close;






	*--- Chapter 9: Program 9.8 Testing for Homogeneity;

	/*
		Testing for Homogeneity with clustered Trinomial outcomes.

		Underlying probability vectors are 

			Product	    1		  2		  3
			-------	  ------	------	------
				1	  0.880		0.110	0.010
				2	  0.900		0.075	0.025
		
		Categories 1, 2 and 3 represent respectively "Low," "Medium" 
		and "High". The Random-clumped Multinomial distribution is used 
		to generate the correlated Trinomial outcomes.
	*/

	data test_of_homogeneity;
	n     = 175;	*--- Number of Panelists (Clusters) per Test Product;
	m     = 8;		*--- Number of Repeated Measurements per Panelist;
	rho2  = 0.15;	*--- Intra Cluster Correlation;
	pi11  = 0.880;	*--- Probability Category 1, Product 1;
	pi21  = 0.900;	*--- Probability Category 1, Product 2;
	pi12  = 0.110;	*--- Probability Category 2, Product 1;
	pi22  = 0.075;	*--- Probability Category 2, Product 2;
	seed  = 1974;	*--- Initial Seed;
	rho   = sqrt(rho2);
	cpi12 = pi11 + pi12;
	cpi22 = pi21 + pi22;
		do j = 1 to n;
		*--- Product 1;
		Product =  1;
		Subjid  = j;
		yy      = 3;
		u       = uniform( seed );
		if u < cpi12 then yy = 2;
		if u < pi11  then yy = 1;
			do i=1 to m;
			Y = 3;
			u = uniform( seed );
				if u < rho then y = yy;
				else do;
					uu = uniform( seed );
					if uu < cpi12 then y = 2;
					if uu < pi11  then y = 1;
				end;
			output;
			end;
		*--- Product 2;
		Product =  2;
		Subjid  = j + n;
		yy      = 3;
		u       = uniform( seed );
		if u < cpi22 then yy = 2;
		if u < pi21  then yy = 1;
			do i=1 to m;
			Y = 3;
			u = uniform( seed );
				if u < rho then y = yy;
				else do;
					uu = uniform( seed );
					if uu < cpi22 then y = 2;
					if uu < pi21  then y = 1;
				end;
			output;
			end;
		end;
	keep subjid product y;
	run;

	ods html;
	proc surveylogistic data=test_of_homogeneity;
		class product subjid / param=glm;
		model y (ref=First) = product / link=glogit varadj=morel;
		cluster subjid;
		lsmeans product / ilink;
		estimate 'P12' int 1 product 1 0 / category='1' ilink;
		estimate 'P22' int 1 product 0 1 / category='1' ilink;
		estimate 'P13' int 1 product 1 0 / category='2' ilink;
		estimate 'P23' int 1 product 0 1 / category='2' ilink;
		estimate 'P12 Vs P22' product 1 -1 / category='1' exp;
		estimate 'P13 Vs P23' product 1 -1 / category='2' exp;
	run;
	ods html close;


	ods html;
	proc surveyfreq data=test_of_homogeneity;
		cluster subjid;
		tables product * y / chisq;
	run;
	ods html close;






	*--- Chapter 10: Program 10.1 Multicenter Randomized Clinical Trial Example;

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







	*--- Chapter 10: Program 10.2 Pump Reliability at a Reactor Nuclear Power Plant;

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







	*--- Chapter 10: Program 10.3 Fitting a GLMM on Shoulder Pain Data;

   	/* 
		Reference: Lumley, T. (1996) "Generalized Estimating Equations for Ordinal
		Data: A Note on Working Correlation Structures."  Biometrics 52, 354-363 
	*/

    data Shoulder_tip_pain;
	    input trt $ gender $ age t1-t6;
	    subject_id = _n_;
		array tt t1-t6;
       	do over tt;
          	y    = tt;
		  	time = _i_;
          	output;
       	end;
	    datalines;
	    y  f  64  1  1  1  1  1  1
	    y  m  41  3  2  1  1  1  1
	    y  f  77  3  2  2  2  1  1
	    y  f  54  1  1  1  1  1  1
	    y  f  66  1  1  1  1  1  1
	    y  m  56  1  2  1  1  1  1
	    y  m  81  1  3  2  1  1  1
	    y  f  24  2  2  1  1  1  1
	    y  f  56  1  1  1  1  1  1
	    y  f  29  3  1  1  1  1  1
	    y  m  65  1  1  1  1  1  1
	    y  f  68  2  1  1  1  1  2
	    y  m  77  1  2  2  2  2  2
	    y  m  35  3  1  1  1  3  3
	    y  m  66  2  1  1  1  1  1
	    y  f  70  1  1  1  1  1  1
	    y  m  79  1  1  1  1  1  1
	    y  f  65  2  1  1  1  1  1
	    y  f  61  4  4  2  4  2  2
	    y  f  67  4  4  4  2  1  1
	    y  f  32  1  1  1  2  1  1
	    y  f  33  1  1  1  2  1  2
	    n  f  20  5  2  3  5  5  4
	    n  f  50  1  5  3  4  5  3
	    n  f  40  4  4  4  4  1  1
	    n  m  54  4  4  4  4  4  3
	    n  m  34  2  3  4  3  3  2
	    n  f  34  3  4  3  3  3  2
	    n  m  56  3  3  4  4  4  3
	    n  f  82  1  1  1  1  1  1
	    n  m  56  1  1  1  1  1  1
	    n  m  52  1  5  5  5  4  3
	    n  f  65  1  3  2  2  1  1
	    n  f  53  2  2  3  4  2  2
	    n  f  40  2  2  1  3  3  2
	    n  f  58  1  1  1  1  1  1
	    n  m  63  1  1  1  1  1  1
	    n  f  41  5  5  5  4  3  3
	    n  m  72  3  3  3  3  1  1
	    n  f  60  5  4  4  4  2  2
	    n  m  61  1  3  3  3  2  1
    ;

	proc format;
		value $abc 'y' = 'Active'
		           'n' = 'Placebo';
		value $xyz 'f' = 'Female'
		           'm' = 'Male';
	run;


	ods html;
	proc glimmix data=Shoulder_tip_pain method=quad;
		class subject_id trt gender;
		model y  = trt gender age time / dist=mult link=clogit solution;
		random int / subject=subject_id;
		format trt $abc. gender $xyz. ;
		estimate  'Active Vs Placebo' trt 1 -1 / or;
		title '*** Fitting a Cumulative Logit GLMM to the Shoulder Tip Pain Data ***';
	run;

	proc glimmix data=Shoulder_tip_pain empirical=classical method=quad;
		class subject_id trt gender;
		model y  = trt gender age time / dist=mult link=clogit solution;
		random int / subject=subject_id;
		format trt $abc. gender $xyz. ;
		estimate  'Active Vs Placebo' trt 1 -1 / or;
		title1 '*** Fitting a Cumulative Logit GLMM to the Shoulder Tip Pain Data ***';
		title2 '*** with an Empirical Variance for Estimates of Fixed Effects     ***';
	run;

	proc glimmix data=Shoulder_tip_pain empirical=mbn method=quad;
		class subject_id trt gender;
		model y  = trt gender age time / dist=mult link=clogit solution;
		random int / subject=subject_id;
		format trt $abc. gender $xyz. ;
		estimate  'Active Vs Placebo' trt 1 -1 / or;
		title1 '*** Fitting a Cumulative Logit GLMM to the Shoulder Tip Pain Data ***';
		title2 '*** with an Empirical Variance for Estimates of Fixed Effects     ***';
		title3 '*** and the MBN small sample variance correction                  ***';
	run;
	ods html close;







	*--- Chapter 10: Program 10.4 Generation Data under Beta-binomial GLOMM and Model Estimation;

	/*
		Beta-binomial GLOMM

		Beta-Binomial Model with Logit Link and Random Effects
		Random effects due to Cross-over Design

		t given u  ~  Beta-Binomial(pi,rho,n)
		logit( pi ) = beta0 + beta1 * X + u
		u  ~  Normal(0,sigma*sigma)
	*/

	data Glomm_BB;
	n     = 200;
	pi_1  = 0.12;
	pi_2  = 0.08;
	m     = 20;
    rho_2 = 0.15;       *--- Overdispersion Parameter;
    sigma = 1.2;        *--- u ~ Normal(0, sigma*sigma);
    seed  = 1983;       *--- Seed;
    beta0 = log(pi_1/(1-Pi_1));
	beta1 = log(pi_2/(1-Pi_2)) - beta0; 
	c     = 1 / rho_2 / rho_2 - 1;

		*--- Sequence AB;
		*----------------;
		do Subj_id=1 to n;
		*----------------;
		Sequence = 'AB';
		u        = sigma * normal(seed);
		*--- Period 1;
		Period  = 1;
		Product = 1;
		X       = 1;
		pi      = 1 / ( 1 + exp( - beta0 - u ) );
		a       = c * pi;
		b       = c - a;
		y1      = rangam(seed, a);
        y2      = rangam(seed, b);
        p       = y1 / ( y1 + y2 );
		t       = ranbin(seed,m,p);
		output;
		*--- Period 2;
		Period  = 2;
		Product = 2;
		X       = 0;
		pi      = 1 / ( 1 + exp( - beta0 - beta1 - u ) );
		a       = c * pi;
		b       = c - a;
		y1      = rangam(seed, a);
        y2      = rangam(seed, b);
        p       = y1 / ( y1 + y2 );
		t       = ranbin(seed,m,p);
		output;
		*--;
		end;
		*--;
		*--- Sequence BA;
		*--------------------;
		do Subj_id=n+1 to n+n;
		*--------------------;
		Sequence = 'BA';
		u        = sigma * normal(seed);

		*--- Period 1;
		Period  = 1;
		Product = 2;
		X       = 0;
		pi      = 1 / ( 1 + exp( - beta0 - beta1 - u ) );
		a       = c * pi;
		b       = c - a;
		y1      = rangam(seed, a);
        y2      = rangam(seed, b);
        p       = y1 / ( y1 + y2 );
		t       = ranbin(seed,m,p);
		output;
		*--- Period 2;
		Period  = 2;
		Product = 1;
		X       = 1;
		pi      = 1 / ( 1 + exp( - beta0 - u ) );
		a       = c * pi;
		b       = c - a;
		y1      = rangam(seed, a);
        y2      = rangam(seed, b);
        p       = y1 / ( y1 + y2 );
		t       = ranbin(seed,m,p);
		output;
		*--;
		end;
		*--;

	keep Subj_id Sequence Period Product X t m;
	run;

	ods html;
	proc glimmix data=Glomm_BB method=quad;
		class Subj_id Period Sequence Product;
		model t/m = Product / link=logit dist=binomial s;
		random int / subject=Subj_id;
	run;

	proc nlmixed data=Glomm_BB;
	   parms beta0=-2.7, -2.6 -2.5, beta1=0.4, 0.5, 0.3 a0=-0.5 0, sigma=1;
	   linr  = a0;
	   rho_2 = 1/(1+exp(-linr));
	   c     = 1 / rho_2 / rho_2 - 1;
	   linp  = beta0 + beta1*x + u;
	   pi  = 1/(1+exp(-linp));
	   pic = 1 - pi;
	   z   = lgamma(m+1) - lgamma(t+1) - lgamma(m-t+1);
	   ll  = z + lgamma(c) + lgamma(t+c*pi) + lgamma(m-t+c*pic)
	         - lgamma(m+c) - lgamma(c*pi) - lgamma(c*pic);
	   model t ~ general(ll);
	   random u ~ normal(0, sigma*sigma)  subject=Subj_id;
	   estimate 'Pi_1'        1/(1+exp(-beta0-beta1));
	   estimate 'Pi_2'        1/(1+exp(-beta0));
	   estimate 'OR'          exp(beta1);
	   estimate 'Rho*Rho'     1/(1+exp(-a0));
	   estimate 'Sigma*Sigma' Sigma*Sigma;
	run;
	ods html close;






	*--- Chapter 10: Program 10.5 Generation Data under Random-clumpled Binomial GLOMM and Model Estimation;

	/*
		Random-clumped Binomial GLOMM

		Random-clumped Binomial Model with Logit Link and Random Effects
		Random effects due to Cross-over Design

		t given u  ~  Random-clumped Binomial(pi,rho,n)
		logit( pi ) = beta0 + beta1 * X + u
		u  ~  Normal(0,sigma*sigma)
	*/

	data Glomm_RCB;
	n     = 200;
	pi_1  = 0.12;
	pi_2  = 0.08;
	m     = 20;
    rho_2 = 0.15;       *--- Overdispersion Parameter;
    sigma = 1.2;        *--- u ~ Normal(0, sigma*sigma);
    seed  = 1983;       *--- Seed;
    beta0 = log(pi_1/(1-Pi_1));
	beta1 = log(pi_2/(1-Pi_2)) - beta0; 
	rho   = sqrt(rho_2);

		*--- Sequence AB;
		*----------------;
		do Subj_id=1 to n;
		*----------------;
		Sequence = 'AB';
		u        = sigma * normal(seed);
		*--- Period 1;
		Period  = 1;
		Product = 1;
		X       = 1;
		pi      = 1 / ( 1 + exp( - beta0 - u ) );
		yy      = ranbin(seed,1,pi);
		mm      = ranbin(seed,m,rho);
		t       = yy * mm;
		if m > mm then t = t + ranbin(seed,m-mm,pi);
		output;
		*--- Period 2;
		Period  = 2;
		Product = 2;
		X       = 0;
		pi      = 1 / ( 1 + exp( - beta0 - beta1 - u ) );
		yy      = ranbin(seed,1,pi);
		mm      = ranbin(seed,m,rho);
		t       = yy * mm;
		if m > mm then t = t + ranbin(seed,m-mm,pi);
		output;
		*--;
		end;
		*--;
		*--- Sequence BA;
		*--------------------;
		do Subj_id=n+1 to n+n;
		*--------------------;
		Sequence = 'BA';
		u        = sigma * normal(seed);
		*--- Period 1;
		Period  = 1;
		Product = 2;
		X       = 0;
		pi      = 1 / ( 1 + exp( - beta0 - beta1 - u ) );
		yy      = ranbin(seed,1,pi);
		mm      = ranbin(seed,m,rho);
		t       = yy * mm;
		if m > mm then t = t + ranbin(seed,m-mm,pi);
		output;
		*--- Period 2;
		Period  = 2;
		Product = 1;
		X       = 1;
		pi      = 1 / ( 1 + exp( - beta0 - u ) );
		yy      = ranbin(seed,1,pi);
		mm      = ranbin(seed,m,rho);
		t       = yy * mm;
		if m > mm then t = t + ranbin(seed,m-mm,pi);
		output;
		*--;
		end;
		*--;

	keep Subj_id Sequence Period Product X t m;
	run;

	ods html;
	proc glimmix data=Glomm_RCB method=quad;
		class Subj_id Period Sequence Product;
		model t/m = Product / link=logit dist=binomial s;
		random int / subject=Subj_id;
	run;
	
	proc nlmixed data=Glomm_RCB;
	   parms beta0=-2.9, -2.8, -2.7, beta1=0.2,0.3,0.4 , a0=-0.5 0, sigma=1;
	   linr = a0;
	   rho  = 1/(1+exp(-linr));
	   linp  = beta0 + beta1*x + u;
	   pi  = 1/(1+exp(-linp));
	   pic = 1 - pi;
	   p1  = ( 1 - rho )*pi + rho;
	   p1c = 1 - p1;
	   p2  = p1 - rho;
	   p2c = 1 - p2;
	   z   = lgamma(m+1) - lgamma(t+1) - lgamma(m-t+1);
	   ll  = z + log( pi*p1**t*p1c**(m-t)  +  pic*p2**t*p2c**(m-t) );
	   model t ~ general( ll );
	   random u ~ normal(0, sigma*sigma)  subject=Subj_id;
	   estimate 'Pi_1'        1/(1+exp(-beta0-beta1));
	   estimate 'Pi_2'        1/(1+exp(-beta0));
	   estimate 'OR'          exp(beta1);
	   estimate 'Rho*Rho'     1/(1+exp(-a0))/(1+exp(-a0));
	   estimate 'Sigma*Sigma' Sigma*Sigma;
	run;
	ods html close;






	*--- Chapter 10: Program 10.6 Generation Data under ZIP GLOMM and Model Estimation;

	/*
		Generation of data under a Zero-inflated Poisson GLOMM
   		with parameters Beta0, Beta1, W, and Sigma**2
	*/
 
	data zip_glomm;   
		beta0    = 0.70;
		beta1    = 0.40;
		w        = 0.20;
		sigma2   = 1.2;
		m        = 12;
		n        = 200;
		seed     = 1917;
		n1       = n+1;
		n2       = n+n;
		sigma    = sqrt(sigma2);
		do id=1 to n;
			z = Sigma*normal(seed);
			do t=1 to m;
				u = uniform(seed);
				if u > w then do;
					Group = 1;
					mu    = exp(Beta0+Beta1+z);
					Y     = ranpoi(seed,mu);
					output;
				end;
				else do;
					Group = 1;
					Y     = 0;
					output;
				end;
			end;
		end;
		do id=n1 to n2;
			z = Sigma*normal(seed);
			do t=1 to m;
				u = uniform(seed);
				if u > w then do;
					Group = 0;
					mu    = exp(Beta0      +z);
					Y     = ranpoi(seed,mu);
					output;
				end;
				else do;
					Group = 0;
					Y     = 0;
					output;
				end;
			end;
		end;
	keep id t group y;
	run;

	ods html;
	title "Initial estimates of Beta0, Beta1 and Sigma**2 using PROC GLIMMIX";
	proc glimmix data=zip_glomm method=quad order=data; 
		class id group;
		model y = group / link=log dist=poisson solution;
		random int / subject=id;
	run;

	title "Zero-Inflated Poisson GLOMM using PROC NLMIXED";
	proc nlmixed data=zip_glomm;
		parms b0=0.57 b1=0.38 w=0.1 0.2 0.3 sigma=1.07;
		bounds 0 < w < 1;
		mu = exp(b0+b1*group+u);
		if y=0 then
			 ll = log( w + (1-w)*exp(-mu) );
		else ll = log((1-w)) + y * log(mu)
		         - lgamma(y+1) - mu;
		model y ~ general(ll);
		random u~normal(0,sigma*sigma) subject=id;
		estimate "Expected Counts Group 1" (1-w)*exp(b0+b1);
		estimate "Expected Counts Group 0" (1-w)*exp(b0);
		estimate "Ratio Expected Counts Group 1 Vs 0" exp(b1);
		estimate "Sigma**2" sigma*sigma;
	run;
	ods html close;






	*--- Chapter 10: Program 10.7 Generation Data under ZINB GLOMM and Model Estimation;

	/*
		Generation of data under a Zero-inflated Negative-binomial GLOMM
   		with parameters Beta0, Beta1, Kappa, W, and Sigma**2
	*/
 
	data zinb_glomm;   
		beta0    = 0.70;
		beta1    = 0.40;
		kappa    = 0.15;
		w        = 0.20;
		sigma2   = 1.2;
		m        = 12;
		n        = 200;
		seed     = 1917;
		n1       = n+1;
		n2       = n+n;
		alpha    = 1 / kappa;
		sigma    = sqrt(sigma2);
		do id=1 to n;
			z = sigma*normal(seed);
			do t=1 to m;
				u = uniform(seed);
				if u > w then do;
					Group = 1;
					mu    = exp(Beta0+Beta1+z);
					beta  = kappa * mu;
					uu    = beta * rangam(seed,alpha);
					Y     = ranpoi(seed,uu);
					output;
				end;
				else do;
					Group = 1;
					Y     = 0;
					output;
				end;
			end;
		end;
		do id=n1 to n2;
			z = Sigma*normal(seed);
			do t=1 to m;
				u = uniform(seed);
				if u > w then do;
					Group = 0;
					mu    = exp(Beta0      +z);
					beta  = kappa * mu;
					uu    = beta * rangam(seed,alpha);
					Y     = ranpoi(seed,uu);
					output;
				end;
				else do;
					Group = 0;
					Y     = 0;
					output;
				end;
			end;
		end;
		keep id t group y;
	run;

	ods html;
	title "Initial estimates of Beta0, Beta1, Kappa and Sigma**2 using PROC GLIMMIX";
	proc glimmix data=zinb_glomm method=quad order=data; 
		class id group;
		model y = group / link=log dist=negbin solution;
		random int / subject=id;
	run;

	title "Zero-Inflated Negative-binomial GLOMM using PROC NLMIXED";
	proc nlmixed data=zinb_glomm;
		parms b0=0.49 b1=0.35 kappa=0.8 w=0.1 0.2 0.3 sigma=1.13;
		bounds kappa > 0, 0 < w < 1;
		mu = exp(b0+b1*group+u);
		a  = 1/kappa;
		p  = 1 / (1 + kappa*mu);
		z  = lgamma(y+a) - lgamma(a) - lgamma(y+1);
		if y=0 then
			 ll = log( w + (1-w)*p**a );
		else ll = z + log(1-w) + a * log(p) + y * log(1-p);
		model y ~ general(ll);
		random u~normal(0,sigma*sigma) subject=id;
		estimate "Expected Counts Group 1" (1-w)*exp(b0+b1);
		estimate "Expected Counts Group 0" (1-w)*exp(b0);
		estimate "Ratio Expected Counts Group 1 Vs 0" exp(b1);
		estimate "Sigma**2" sigma*sigma;
	run;
	ods html close;







