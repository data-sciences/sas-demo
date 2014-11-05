


/*
		Macro GOF_BB_RCB_Distributions

		Arguments:
		mydata	-- name of the data set containing the variables "t" and "m"
		title   -- description of the data being analyzed

		User needs to provide the estimated Pi's and Rho's for both 
		the Beta-binomial and Random-clumped Binomial models
		These files are denoted in this macro as "pi_bb" "rho_bb" "pi_rcb" and  "rho_rcb"
		and were obtained in the Hiroshima Chromosome Aberration Example using PROC NLMIXED
	*/

	*------------------------------------------- ;
	%macro GOF_BB_RCB_Distributions(mydata,title);
	*------------------------------------------- ;

	title &title;
	proc iml;

	*	Read input data set with variables: t and m; 
	use &mydata var {t m};
	read all into y;

	n       = nrow(y);
	t       = y[,1];
	m       = y[,2];
	mj      = unique(m)`;
	size_mj = nrow(mj);
	fj      = repeat(0,size_mj,1);

	do j = 1 to size_mj;
	   fj[j] = sum(m=mj[j]);
	end;

	*	Print distribution of mj;
	print 'Distribution of Cluster Size (m)';
	print mj[label='Cluster Size(m)'] fj[label='Frequency'];

	*-----------------------------------------------;
	*   Matrix attributes for matrices to be printed;
	*-----------------------------------------------;

	mattrib Lower format=8.4;
	mattrib Upper format=8.4;
	mattrib obs      label='Observed Frequency' format=8.0;
	mattrib expected label='Expected Frequency' format=8.2;

	mattrib n       label='No. of Clusters'      format=8.0;
	mattrib obs_sum label='Observed Frequencies' format=8.0;
	mattrib exp_sum label='Expected Frequencies' format=12.4;

	mattrib chisq   label='Chi-square' format=8.4;
	mattrib df      label='DF'         format=8.0;
	mattrib pvalue  label='P-value'    format=8.4;
	mattrib GOFStat colname={'GOF-Stat' 'DF' 'p-Value'}  
	                rowname={'Lower Bound DFs Results' 'Upper Bound DFs Results'}
            label='GOF Test Statistic';
	mattrib BoundsDF colname={'Results based on'};  

	*------------------------------------------;
	*   Define subroutines "collapse" and "gof";
	*------------------------------------------;

	*-----------------------------------------------------;
	start collapse(k,expect,upperb,r,lower,upper,expected);
	*-----------------------------------------------------;

	*   Categories with expected frequencies smaller than 5 are collapsed with prior category;

	do false = 1 to 1;	*   Necessary for GOTO statement;

	    class = k;
	    index = 1;
		s     = 1;
	    aux2  = j(k,1,0);
	    aux4  = j(k,1,0);

		begin2:

	    aux2[index] = expect[s];
	    aux4[index] = upperb[s];

	    do while(s < k);
		    if (aux2[index] < 5) then do;
			    s           = s+1;
			    class       = class-1;
			    aux2[index] = aux2[index] + expect[s];
			    aux4[index] = upperb[s];
		    end;
		    else do;
			    index = index + 1;
			    s     = s+1;
			    goto begin2;
		    end;
	    end;

	    if (aux2[index] < 5) then do;
		    class         = class-1;
		    aux2[index-1] = aux2[index] + aux2[index-1];
	    end;

		Lower          = j(class,1,0);
		Upper          = j(class,1,0);
		upper          = aux4[1:class];
		lower[2:class] = aux4[1:class-1];
		lower[1]       = -0.00001;
		upper[class]   =  1.00001;
		r              = class;
		expected       = aux2[1:class];

	end;        *   End of group do loop;

	*--------------;
	finish collapse;
	*--------------;

	*-------------------------------------------------------------------------;
	start gof(r,t,n,m,lower,upper,expected,nparms,obs,obs_sum,exp_sum,GOFStat);
	*-------------------------------------------------------------------------;
	
	*   Compute GOF test;
	
    obs   = j(r, 1, 0);   *   Observed counts;
	ratio = t/m;
    do s = 1 to r-1;
        obs[s] = sum( (ratio > lower[s]) & (ratio <= upper[s]) );
    end;
    obs[r]   = n - sum(obs[1:r-1]);
    lower[1] = 0;
    upper[r] = 1.0000;
    obs_sum  = sum(obs);
    exp_sum  = sum(expected);
	
	*   Compute the Chi-square statistics;
	
	chisq    = 0;
        df1      = r-1-nparms;     *--- Lower bound DFs;
        df2      = r-1;            *--- Upper bound DFs;
	chisq    = sum((obs-expected)##2/expected);
	chisq    = round( chisq, 0.0001);
        pvalue   = round((1- PROBCHI(chisq, df1)), 0.0001);
	if pvalue < 0.0001 then pvalue = 0.0001;
	GOFStat1 = chisq ||df1||pvalue;
        pvalue   = round((1- PROBCHI(chisq, df2)), 0.0001);
	if pvalue < 0.0001 then pvalue = 0.0001;
	GOFStat2 = chisq ||df2||pvalue;
	GOFStat  = GOFStat1 // GOFStat2;
	
	*---------;
	finish gof;
	*---------;
	
	*******************************************************;
	*	1) Begins GOF Test under Beta-binomial distribution;
	*******************************************************;
	
	use pi_bb var {Pred};
	read all into pii;
	use rho_bb var {Pred};
	read all into rhoo;
	
	*   Compute expected frequency for Beta-binomial distribution;
	k    = max(mj) + 1;

    *   Initialization;
    lowerb = j(k,1, -0.0000001);
    upperb = j(k,1,  1.0000001);
	
    expect = j(k, 1, 0);

    *   Define lower and upper bound for the intervals;
    do s = 2 to k;
        lowerb[s]   = (s-1)/k;
        upperb[s-1] = (s-1)/k;
    end;
	
	do s = 1 to k-1;
	expect[s] = 0;
	do j=1 to n;
	pi   = pii[j];
	rho  = rhoo[j];
	pic  = 1-pi;
    rhoc = 1-rho;
	c    = 1/rho/rho -1;

		probbb = 0;
		do it  = 0 to m[j];
		ratio  = it/m[j];
 
		if ((ratio > lowerb[s]) & (ratio <= upperb[s])) then do;
			aux    = lgamma(m[j]+1) + lgamma(c) + lgamma(it+c*pi) + lgamma(m[j]-it+c*(1-pi))
			       - lgamma(it+1) - lgamma(m[j]-it+1) - lgamma(m[j]+c) 
                              - lgamma(c*pi) - lgamma(c*(1-pi));
			probbb = probbb + exp(aux);
		end;
		end;
		expect[s] = expect[s] + probbb;
		probbb=0;
	end;
	end;
	expect[k] = n-sum(expect[1:k-1]);

	call collapse(k,expect,upperb,r,lower,upper,expected);

	nparms = &nparms_bb;
	call gof(r,t,n,m,lower,upper,expected,nparms,obs,obs_sum,exp_sum,GOFStat);

	*   Print results under Beta-binomial distribution;

	print "Goodness-of-fit Test under Beta-binomial Distribution" ;
	print lower upper obs expected;
	print "Total Counts";
	print n obs_sum exp_sum;
	print "Null Hypothesis: Data are distributed according to a Beta-binomial Distribution";
	print GOFStat;

	*   Output Residuals (Observed - Expected) into data set Resid_BB needed later for QQ-Plots;

	Distribution = j(nrow(obs),1,'Beta-Binomial ');
	Resid        = obs - expected;
	create Resid_BB var{ Distribution Resid };
	append;

	*****************************************************************;
	*	2) Begins GOF Test under Random-clumped Binomial distribution;
	*****************************************************************;

	use pi_rcb var {Pred};
	read all into pii;
	use rho_rcb var {Pred};
	read all into rhoo;

	*   Compute expected frequency for Random-clumped Binomial distribution;
	k    = max(mj) + 1;

    *   Initialization;
    lowerb = j(k,1, -0.0000001);
    upperb = j(k,1,  1.0000001);

    expect = j(k, 1, 0);

    *   Define lower and upper bound for the intervals;
    do s = 2 to k;
        lowerb[s]   = (s-1)/k;
        upperb[s-1] = (s-1)/k;
    end;

	do s = 1 to k-1;
		expect[s] = 0;
		do j=1 to n;
			pi   = pii[j];
			rho  = rhoo[j];
			pic  = 1-pi;
		        rhoc = 1-rho;
			p2   = rhoc*pi;
		        p1   = p2 + rho;

			probrcb = 0;
			x1      = (0:m[j])`;
			m2      = m[j] +1;
			pr1     = PROBBNML(p1,m[j],x1);
			pr2     = PROBBNML(p2,m[j],x1);
			pr1[2:m2] = pr1[2:m2] - pr1[1:(m2-1)];
			pr2[2:m2] = pr2[2:m2] - pr2[1:(m2-1)];

			do it = 0 to m[j];
				i = it + 1;
				ratio = it/m[j];
				if ((ratio > lowerb[s]) & (ratio <= upperb[s])) then
				probrcb = probrcb + pi*pr1[i] + pic*pr2[i];
			end;
			expect[s] = expect[s] + probrcb;
			prorcb=0;
		end;
	end;
	expect[k] = n-sum(expect[1:k-1]);

	call collapse(k,expect,upperb,r,lower,upper,expected);

	nparms = &nparms_rcb;
	call gof(r,t,n,m,lower,upper,expected,nparms,obs,obs_sum,exp_sum,GOFStat);

	*   Print results under Random-clumped Binomial distribution;

	print "Goodness-of-fit Test under Random-clumped Binomial Distribution" ;
	print lower upper obs expected;
	print "Total Counts";
	print n obs_sum exp_sum;
	print "Null Hypothesis: Data are distributed according to a Random-clumped Binomial Distribution";
	print GOFStat;

	*   Output Residuals (Observed - Expected) into data set Resid_RCB needed later for QQ-Plots;

	Distribution = j(nrow(obs),1,'Random-clumped');
	Resid        = obs - expected;
	create Resid_RCB var{ Distribution Resid };
	append;

	quit;  *   End of IML;


	data Resid_BB_RCB;
		set Resid_BB Resid_RCB;
	run;

	proc sort data=Resid_BB_RCB;
		by Distribution;
	run;

	proc rank data=Resid_BB_RCB out=new_qqplots normal=blom ties=mean;
		by Distribution;
		var Resid;
		ranks NQuant;
	run;

	proc sgpanel data=new_qqplots noautolegend;
		panelby Distribution;
		title1 &title;
		title2 "QQ-Plots of Residuals based on Observed and Expected Frequencies";
		label Resid="Residuals" NQuant="Normal Quantiles";
		reg x=Resid y=NQuant;
	run;

	*-----------------------------;
	%mend GOF_BB_RCB_Distributions;
	*-----------------------------;




