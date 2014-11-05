



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





	
