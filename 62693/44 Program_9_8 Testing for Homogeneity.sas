


	/*
		Testing for Homogeneity with clustered Trinomial outcomes.

		Underlying probability vectors are 

			Product	    1		  2		  3
			-------	  ------	------	------
				1	  0.880		0.110	0.010
				2	  0.900		0.075	0.025
		
		Categories 1, 2 and 3 represent respectively "Low," "Medium" 
		and "High". The Random-clumped Multinomial distribution is used 
		to generate the correlated Trinomial outcomes.
	*/

	data test_of_homogeneity;
	n     = 175;	*--- Number of Panelists (Clusters) per Test Product;
	m     = 8;		*--- Number of Repeated Measurements per Panelist;
	rho2  = 0.15;	*--- Intra Cluster Correlation;
	pi11  = 0.880;	*--- Probability Category 1, Product 1;
	pi21  = 0.900;	*--- Probability Category 1, Product 2;
	pi12  = 0.110;	*--- Probability Category 2, Product 1;
	pi22  = 0.075;	*--- Probability Category 2, Product 2;
	seed  = 1974;	*--- Initial Seed;
	rho   = sqrt(rho2);
	cpi12 = pi11 + pi12;
	cpi22 = pi21 + pi22;
		do j = 1 to n;
		*--- Product 1;
		Product =  1;
		Subjid  = j;
		yy      = 3;
		u       = uniform( seed );
		if u < cpi12 then yy = 2;
		if u < pi11  then yy = 1;
			do i=1 to m;
			Y = 3;
			u = uniform( seed );
				if u < rho then y = yy;
				else do;
					uu = uniform( seed );
					if uu < cpi12 then y = 2;
					if uu < pi11  then y = 1;
				end;
			output;
			end;
		*--- Product 2;
		Product =  2;
		Subjid  = j + n;
		yy      = 3;
		u       = uniform( seed );
		if u < cpi22 then yy = 2;
		if u < pi21  then yy = 1;
			do i=1 to m;
			Y = 3;
			u = uniform( seed );
				if u < rho then y = yy;
				else do;
					uu = uniform( seed );
					if uu < cpi22 then y = 2;
					if uu < pi21  then y = 1;
				end;
			output;
			end;
		end;
	keep subjid product y;
	run;


	ods html;
	proc surveylogistic data=test_of_homogeneity;
		class product subjid / param=glm;
		model y (ref=First) = product / link=glogit varadj=morel;
		cluster subjid;
		lsmeans product / ilink;
		estimate 'P12' int 1 product 1 0 / category='1' ilink;
		estimate 'P22' int 1 product 0 1 / category='1' ilink;
		estimate 'P13' int 1 product 1 0 / category='2' ilink;
		estimate 'P23' int 1 product 0 1 / category='2' ilink;
		estimate 'P12 Vs P22' product 1 -1 / category='1' exp;
		estimate 'P13 Vs P23' product 1 -1 / category='2' exp;
	run;
	ods html close;




	ods html;
	proc surveyfreq data=test_of_homogeneity;
		cluster subjid;
		tables product * y / chisq;
	run;
	ods html close;



