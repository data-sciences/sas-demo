

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


