
	

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

