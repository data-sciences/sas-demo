


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







