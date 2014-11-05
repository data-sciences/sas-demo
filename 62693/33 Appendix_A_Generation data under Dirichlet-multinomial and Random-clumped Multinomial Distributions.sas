
	
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
			call randgen(nn,'BINOM',rho,m); *<--- Order of some arguments might depend on SAS Version;
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








