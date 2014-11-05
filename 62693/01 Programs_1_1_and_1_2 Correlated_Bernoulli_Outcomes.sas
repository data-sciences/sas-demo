

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


