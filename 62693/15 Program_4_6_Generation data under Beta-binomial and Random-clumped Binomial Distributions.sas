

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

