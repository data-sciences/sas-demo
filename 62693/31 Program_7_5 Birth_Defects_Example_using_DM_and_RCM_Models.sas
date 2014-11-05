



	/*
		Birth Defect Example using DM and RCM Models
		Morel and Koehler (1995)
	*/

	data birth_defects;
	   input group$ @@;
	   do j=1 to 10;
	      input t1-t3 zn2 cd2 cd3 zn2_cd2 zn2_cd3;
	      output;
	   end;
	   drop j;
	   datalines;
	2ZN
	  2  0 11   1 0 0 0 0
	  0  0 15   1 0 0 0 0
	  1  0 13   1 0 0 0 0
	  1  1 13   1 0 0 0 0
	  1  0 12   1 0 0 0 0
	  1  0 12   1 0 0 0 0
	  0  0 13   1 0 0 0 0
	  1  0 10   1 0 0 0 0
	  0  0 16   1 0 0 0 0
	  0  1 11   1 0 0 0 0
	2CD
	  2  5  5   0 1 0 0 0
	 12  0  0   0 1 0 0 0
	  4  5  3   0 1 0 0 0
	  3  8  0   0 1 0 0 0
	  3  8  0   0 1 0 0 0
	  9  4  0   0 1 0 0 0
	  1 12  3   0 1 0 0 0
	  1  9  2   0 1 0 0 0
	  2  4 10   0 1 0 0 0
	  3  0 12   0 1 0 0 0
	3CD
	  6  5  1   0 0 1 0 0
	 11  0  0   0 0 1 0 0
	  8  5  0   0 0 1 0 0
	  8  0  0   0 0 1 0 0
	 14  0  0   0 0 1 0 0
	 11  1  0   0 0 1 0 0
	 12  0  0   0 0 1 0 0
	 13  5  0   0 0 1 0 0
	 12  0  0   0 0 1 0 0
	 12  0  0   0 0 1 0 0
	2ZN2CD
	  1  1  9   1 1 0 1 0
	  0  0 13   1 1 0 1 0
	  1  1 13   1 1 0 1 0
	  4  4  3   1 1 0 1 0
	  0  1 12   1 1 0 1 0
	  0  0 11   1 1 0 1 0
	  0  3  9   1 1 0 1 0
	  2  2  9   1 1 0 1 0
	  0  4 11   1 1 0 1 0
	  1  5  6   1 1 0 1 0
	2ZN3CD
	  4  1  5   1 0 1 0 1
	  4  7  3   1 0 1 0 1
	 13  5  0   1 0 1 0 1
	  2  4  6   1 0 1 0 1
	  6  5  1   1 0 1 0 1
	 11  0  0   1 0 1 0 1
	  5  6  2   1 0 1 0 1
	  4  2  6   1 0 1 0 1
	  6  3  6   1 0 1 0 1
	  5  3  3   1 0 1 0 1
	SC
	  0  0 13   0 0 0 0 0
	  8  0  1   0 0 0 0 0
	  0  0 13   0 0 0 0 0
	  1  0 11   0 0 0 0 0
	  1  0 17   0 0 0 0 0
	  0  0 13   0 0 0 0 0
	  0  0 15   0 0 0 0 0
	  0  0 14   0 0 0 0 0
	  0  0 11   0 0 0 0 0
	  0  0 14   0 0 0 0 0
	UC
	  0  0 13   0 0 0 0 0
	  5  1  7   0 0 0 0 0
	  0  0 13   0 0 0 0 0
	  1  0 11   0 0 0 0 0
	  0  0 13   0 0 0 0 0
	  0  0 11   0 0 0 0 0
	  0  0 11   0 0 0 0 0
	  1  2 10   0 0 0 0 0
	  0  1 12   0 0 0 0 0
	  0  0 12   0 0 0 0 0
	;


	data new_birth_defects;
		set birth_defects;
		litter_id = _n_;
		y = 1; count = t1; output;
		y = 2; count = t2; output;
		y = 3; count = t3; output;
		keep litter_id y zn2 cd2 cd3 zn2_cd3 zn2_cd2 count;
	run;

	data temp;
		set birth_defects;
		m=t1+t2+t3;
	run;
	proc freq data=temp;
		tables m;
	run;

	proc means data=temp mean;
		var m;
	run;

	*--- Fits Cumulative Logits to get initial beta estimates;
	proc logistic data=new_birth_defects;
		model y = zn2 cd2 cd3 zn2_cd3 zn2_cd2 / link=clogit;
		weight count;
	run;






	/*
	Birth Defect Example from Morel and Koehler (1995)
	fitting the Generalized Overdispersed Models
	Dirichlet-multinomial and Random-clumped Multinomial.
	Testing the Proportionality Assumption using the 
	CONTRAST statement in the NLMIXED procedure.
	*/

	ods html;

	Title "Testing Assumption Proportionality -- Dirichlet-multinomial Distribution";
	ods output Contrasts=Prop_Assump_DM FitStatistics=Fit_DM_full
				ParameterEstimates=Betas_DM CovMatParmEst=Cov_DM;
	Proc nlmixed data=birth_defects cov;
		parms a1=-3.7, a2=-2.4, b11=-0.2, b21=-0.2, b12=3.1,  b22=3.1,
              b13=5.5, b23=5.5, b14=-1.8, b24=-1.8, b15=-1.7, b25=-1.7, 
              rho=0.5;
		bounds 1>rho>0;
		eta1 = a1+b11*zn2+b12*cd2+b13*cd3+b14*zn2_cd2+b15*zn2_cd3;
		eta2 = a2+b21*zn2+b22*cd2+b23*cd3+b24*zn2_cd2+b25*zn2_cd3;
		gamma1 = 1/(1+exp(-eta1));
		gamma2 = 1/(1+exp(-eta2));
		p1 = gamma1;
		p2 = gamma2-gamma1;
		p3 = 1 - p1 - p2;
		m  = t1+t2+t3;
		c  = (1-rho**2)/(rho**2);
		const  = lgamma(m+1)-lgamma(t1+1)-lgamma(t2+1)-lgamma(t3+1);
		loglik = lgamma(c)-lgamma(m+c)+lgamma(t1+c*p1)+lgamma(t2+c*p2)
			   + lgamma(t3+c*p3)-lgamma(c*p1)-lgamma(c*p2)-lgamma(c*p3)
			   + const;
		model t1 ~ general(loglik);
		contrast "Proportionality Assumption Test -- DM  Distribution" 
				b11-b21, b12-b22, b13-b23, b14-b24, b15-b25; 
	Run;


	Title "Testing Assumption Proportionality -- Random-clumped Multinomial Distribution";
	ods output Contrasts=Prop_Assump_RCM FitStatistics=Fit_RCM_full Dimensions=Dimensions_1
				ParameterEstimates=Betas_RCM CovMatParmEst=Cov_RCM;
		Proc nlmixed data=birth_defects cov;
		parms a1=-3.7, a2=-2.4, b11=-0.2, b21=-0.2, b12=3.1,  b22=3.1,
              b13=5.5, b23=5.5, b14=-1.8, b24=-1.8, b15=-1.7, b25=-1.7, 
              rho=0.5;
		bounds 1>rho>0;
		eta1 = a1+b11*zn2+b12*cd2+b13*cd3+b14*zn2_cd2+b15*zn2_cd3;
		eta2 = a2+b21*zn2+b22*cd2+b23*cd3+b24*zn2_cd2+b25*zn2_cd3;
		gamma1 = 1/(1+exp(-eta1));
		gamma2 = 1/(1+exp(-eta2));
		p1 = gamma1;
		p2 = gamma2-gamma1;
		p3 = 1 - p1 - p2;
		m  = t1+t2+t3;
		rhoc   = 1-rho;
		const  = lgamma(m+1)-lgamma(t1+1)-lgamma(t2+1)-lgamma(t3+1);
		loglik = log( (p1*((rhoc*p1+rho)**t1)*((rhoc*p2)**t2)*((rhoc*p3)**t3))
				+ (p2*((rhoc*p1)**t1)*((rhoc*p2+rho)**t2)*((rhoc*p3)**t3))
				+ (p3*((rhoc*p1)**t1)*((rhoc*p2)**t2)*((rhoc*p3+rho)**t3)) )
				+ const;
		model t1 ~ general(loglik);
		contrast "Proportionality Assumption Test -- RCM Distribution" 
				b11-b21, b12-b22, b13-b23, b14-b24, b15-b25; 
	Run;

	ods html close;





	ods html;
	title "Testing Parallelism Assumption using a Wald Statistic";
	data Betas_DM;
		set Betas_DM;
		keep estimate;
	run;

	data Cov_DM;
		set Cov_DM;
		drop row parameter;
	run;

	data Betas_RCM;
		set Betas_RCM;
		keep estimate;
	run;

	data Cov_RCM;
		set Cov_RCM;
		drop row parameter;
	run;

	proc iml;
	use Betas_DM;
	read all into beta;
	use Cov_DM;
	read all into cov;

	c ={0 0 1 -1 0  0  0  0  0  0  0  0  0,
		0 0 0  0 1 -1  0  0  0  0  0  0  0,
		0 0 0  0 0  0  1 -1  0  0  0  0  0,
		0 0 0  0 0  0  0  0  1 -1  0  0  0,
		0 0 0  0 0  0  0  0  0  0  1 -1  0};
	Degrees_of_Freedom = nrow(c);

	Wald_Statistic = beta` * c` * inv(c * cov * c`) * c * beta;
	P_Value        = 1 - probchi(Wald_Statistic,Degrees_of_Freedom,0); 
	print "Dirichlet-multinomial Distribution";
	print Degrees_of_Freedom Wald_Statistic[format=6.2] P_Value[format=pvalue6.4];

	use Betas_RCM;
	read all into beta;
	use Cov_RCM;
	read all into cov;

	Wald_Statistic = beta` * c` * inv(c * cov * c`) * c * beta;
	P_Value        = 1 - probchi(Wald_Statistic,Degrees_of_Freedom,0); 
	print "Random-clumped Multinomial Distribution";
	print Degrees_of_Freedom Wald_Statistic[format=6.2] P_Value[format=pvalue6.4];
	quit;
	ods html close;





	ods html;
	Title "Proportional-Odds Model -- Dirichlet-multinomial Distribution";
	ods output FitStatistics=Fit_DM_reduced;
	Proc nlmixed data=birth_defects;
		parms a1=-3.7, a2=-2.4, b1=-0.2, b2=3.1, b3=5.5, b4=-1.8, b5=-1.7, rho=0.5;
		bounds 1>rho>0;
		eta1 = a1+b1*zn2+b2*cd2+b3*cd3+b4*zn2_cd2+b5*zn2_cd3;
		eta2 = a2+b1*zn2+b2*cd2+b3*cd3+b4*zn2_cd2+b5*zn2_cd3;
		gamma1 = 1/(1+exp(-eta1));
		gamma2 = 1/(1+exp(-eta2));
		p1 = gamma1;
		p2 = gamma2-gamma1;
		p3 = 1 - p1 - p2;
		m  = t1+t2+t3;
		c  = (1-rho**2)/(rho**2);
		const  = lgamma(m+1)-lgamma(t1+1)-lgamma(t2+1)-lgamma(t3+1);
			loglik = lgamma(c)-lgamma(m+c)+lgamma(t1+c*p1)+lgamma(t2+c*p2)+
					lgamma(t3+c*p3)-lgamma(c*p1)-lgamma(c*p2)-lgamma(c*p3)
					+const;
		model t1 ~ general(loglik);
	Run;

	Title "Proportional-Odds Model -- Random-clumpled Multinomial Distribution";
	ods output FitStatistics=Fit_RCM_reduced Dimensions=Dimensions_0;
	Proc nlmixed data=birth_defects;
		parms a1=-3.7, a2=-2.4, b1=-0.2, b2=3.1, b3=5.5, b4=-1.8, b5=-1.7, rho=0.5;
		bounds 1>rho>0;
		eta1 = a1+b1*zn2+b2*cd2+b3*cd3+b4*zn2_cd2+b5*zn2_cd3;
		eta2 = a2+b1*zn2+b2*cd2+b3*cd3+b4*zn2_cd2+b5*zn2_cd3;
		gamma1 = 1/(1+exp(-eta1));
		gamma2 = 1/(1+exp(-eta2));
		p1 = gamma1;
		p2 = gamma2-gamma1;
		p3 = 1 - p1 - p2;
		m  = t1+t2+t3;
		rhoc = 1-rho;
		const= lgamma(m+1)-lgamma(t1+1)-lgamma(t2+1)-lgamma(t3+1);
		loglik=log( (p1*((rhoc*p1+rho)**t1)*((rhoc*p2)**t2)*((rhoc*p3)**t3))
				+ (p2*((rhoc*p1)**t1)*((rhoc*p2+rho)**t2)*((rhoc*p3)**t3))
				+ (p3*((rhoc*p1)**t1)*((rhoc*p2)**t2)*((rhoc*p3+rho)**t3)) )
				+ const;
		model t1 ~ general(loglik);
	Run;

	data Fit_DM_reduced;
		set Fit_DM_reduced;
		if _n_ = 1;
		rename Value=Value_0;
		Descr = "LR Test -- DM Distribution";
	run;

	data Fit_DM_full;
		set Fit_DM_full;
		if _n_ = 1;
		rename Value=Value_1;
		keep Value;
	run;

	data Fit_DM;
		merge Fit_DM_reduced Fit_DM_full;
	run;

	data Fit_RCM_reduced;
		set Fit_RCM_reduced;
		if _n_ = 1;
		rename Value=Value_0;
		Descr = "LR Test -- RCM Distribution";
	run;

	data Fit_RCM_full;
		set Fit_RCM_full;
		if _n_ = 1;
		rename Value=Value_1;
		keep Value;
	run;

	data Fit_RCM;
		merge Fit_RCM_reduced Fit_RCM_full;
	run;

	data dimensions_1;
		set dimensions_1;
		if _n_ = 4 then call symput('nparms_1',trim(left(Value)));	
	run;	

	data dimensions_0;
		set dimensions_0;
		if _n_ = 4 then call symput('nparms_0',trim(left(Value)));	
	run;

	data LR_Tests;
		set Fit_DM Fit_RCM;
		format Chi_square_Stat 8.2 Degrees_of_Freedom 4.0 Pvalue Pvalue6.4
               Value_0 8.2 Value_1 8.2;
		Chi_square_Stat    = Value_0 - Value_1;
		Degrees_of_Freedom = &nparms_1 - &nparms_0;
		Pvalue             = 1 - probchi(Chi_square_Stat,Degrees_of_Freedom,0); 
	run;

	title "Likelihood Ratio tests for Testing the Parallelism Assumption";
	proc print data=LR_Tests noobs;
	run;	
	ods html close;

