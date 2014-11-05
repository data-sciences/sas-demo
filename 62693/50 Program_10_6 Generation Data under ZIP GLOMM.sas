
	

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

