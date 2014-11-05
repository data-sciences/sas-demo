


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
	





