




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

