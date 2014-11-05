


	**************************************************************************************
	  Author:			Santosh C Sutradhar
						Associate Director
						Pfizer Inc.
						235 East 42nd St
						New York, NY 10017
						Phone: (212) 733-0496
						Email: Santosh.Sutradhar@pfizer.com

	  Last Modified:	Sep 24, 2009

	  Purpose: 		To write a SAS MACRO in order to compute MLE
					and perform an GOF-test under Beta Binomial distribution.
					This GOF_BB() SAS Macro computes the MLE iteratively 
                    using the Fisher-Scoring method based on Direct Likelihood 

	  Required:		To call other module in file fisherbb.sas

	  List of MACRO variables: 
	  		inds = input SAS data (MUST contains two variables t, m) 
			t    = cluster count 
			m    = cluster size 

	  Usage:	%GOF_BB(inds=HS,t=t,m=m, title2=HS data set)

	  Comment: 	Varying cluster sizes (m) were assumed 
				Initial number of classes to form GOF = MAX(m's) + 1
	****************************************************************************************;

	%macro GOF_BB(inds = , t=, m=, title2 = "Data: ");

	title1 "Goodness-of-fit test under Beta Binomial distribution";
	title2 "&title2";

	****************************************;
	*       Starting IML procedure;
	****************************************;

	proc iml;

	*	Print input information;
	file print;

	**********************************************************************;
	*   Module: FISHERBB: This module can be called to 
	*           Compute Fisher information under BB distribution;
	**********************************************************************;
	start FISHERBB;
	do ijk = 1 to size_mj;
		AH = j(2,2,0);

		do i = 1 to mj[ijk]+1;
			u     = i-1;
			mct   = exp(lgamma(mj[ijk]+1)-lgamma(u+1)-lgamma(mj[ijk]-u+1));
			part1 = exp(lgamma(c)-lgamma(mj[ijk]+c));
			part2 = exp(lgamma(u+c*pi)-lgamma(c*pi));
			part3 = exp(lgamma(mj[ijk]-u+c*(1-pi))-lgamma(c*(1-pi)));

           	pt   = (mct*part1*part2*part3);

            aux3 = 0;
            aux2 = 0;
            aux1 = 0;

            aux3 = sum(1/(c:(c + mj[ijk] - 1)));
            if (u > 0) then aux1 = sum( 1/(cpi:(cpi + u -1)));
            if (u < mj[ijk]) then aux2 = sum(1/(cpic:(cpic + mj[ijk] - u -1)));

            derbb1 = c*(aux1 - aux2);
            derbb2 = (pi*aux1 + pic*aux2 - aux3)*b;
			
		*	Compute Fisher information for each different mj;

			AH[1,1] = AH[1,1] + derbb1*derbb1*pt; 
			AH[1,2] = AH[1,2] + derbb1*derbb2*pt;
			AH[2,2] = AH[2,2] + derbb2*derbb2*pt;  
		end;	*	end of t = 1 to m do loop;

		AH[2,1]=AH[1,2];
		FIMBB = FIMBB + fj[ijk]*AH;
	end;	*	End of ijk=1 to R do loop;
	finish FISHERBB;
	*	End of Module:		FISHERBB;

	*	Read the input data set with variables: t and; 
	use &inds var {&t &m};
		read all into y;
	close &inds;

	n       = nrow(y);
	t       = y[,1];
	m       = y[,2];
	mj      = unique(m)`;
	size_mj = nrow(mj);
	fj = repeat(0,size_mj,1);

	do j = 1 to size_mj;
	   fj[j] = sum(m=mj[j]);
	end;

	*   Distribution of mj;
	print 'Distribution of Cluster Size (m)';
	print mj[label='Cluster Size(m)'] fj[label='Frequency'];

    ***************************************************************************;
    *   ML estimation of parameters using ungrouped likelihood. ;
    *   Sum of the Logarithm of the likelihood (-ve) for Beta Binomial;
    ***************************************************************************;

    pi = sum(t[*])/sum(m[*]);

	if (pi = 0 | pi = 1) then pi = (sum(t[*]) + 1)/(sum(m[*]) + 2);

    num   = n*(t-m*pi)[##];
    denum = ((n-1)*pi*(1-pi));
    mm    = m#(m-j(n,1,1));
    if  ((num/denum - sum(m[*]))/(sum(mm[*])) > 0) then 
        rho = sqrt((num/denum - sum(m[*]))/(sum(mm[*]))); else rho = 0.01;

	*	Initialization of parameters;
	rho2    = rho*rho;
	stop1   = 0;
	beta    = j(2,1,0);
	beta[1] = pi;
	beta[2] = rho;
	eps1    = 10**(-6);
	eps2    = 10**(-8);
	iterate = 1;

	*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;
	do while (stop1 <1); /* Continue until prespecified precision is achieved*/
	*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;

    pi  = beta[1];
    rho  = beta[2];
    pic  = 1-pi;
    rhoc = 1-rho;
    c    = 1/rho/rho -1;
    cpi  = pi*c;
    cpic = c*pic;
    b    = -2/(rho**3);

    logbb = 0;
    grad  = j(2,1,0);

	*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO;
	do j = 1 to n;  *   Looping for all observations 1-n ;
	*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO;

 		m1 = m[j];
		k1 = t[j];

		mct = exp(lgamma(m1+1)-lgamma(k1+1)-lgamma(m1-k1+1));

		part1 = exp(lgamma(c)-lgamma(m1+c));
		part2 = exp(lgamma(k1+c*pi)-lgamma(c*pi));
		part3 = exp(lgamma(m1-k1+c*(1-pi))-lgamma(c*(1-pi)));

		logbb = logbb + log(mct*part1*part2*part3);
        logl  = -2*logbb;

    ***************************************************************;
    *   Compute gradient under Beta Binomial distribution;
    ***************************************************************;
        sum3 = 0;
        sum2 = 0;
        sum1 = 0;
 
		sum3 = sum(1/(c:(c+ m[j] - 1)));
        if (k1 > 0) then sum1 = sum(1/(cpi:(cpi + k1 -1)));
        if (k1 < m1) then sum2 = sum(1/(cpic:(cpic + m1 - k1 -1)));
    
        grad[1] = grad[1] + c*(sum1 - sum2);
        grad[2] = grad[2] + (pi*sum1 + pic*sum2 - sum3)*b;

	*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO;
    end;    *    Of looping for observations;
	*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO;

    *******************************************************************;
    *   Compute Fisher information under Beta Binomial distribution;
    *******************************************************************;

	FIMBB = j(2,2,0);
	RUN FISHERBB;
    INVBB    = inv(FIMBB);
    logl_old = logbb;
    add      = INVBB*grad;

    stop2 = 0;
    split = 1;

	*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;
	*To check if the loglikelihood is improved with the new estimates
	Otherwise modify the estimates by adding only part (by splitting) for improved estimate;
	do while (stop2 <1);
	*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;
    div = 2**(split-1);
    betan = beta + add/div;

    *   Checking for whether the estimates are in the range of parater space;

         if betan[1] < 0.0001 then betan[1] = 0.01;
    else if betan[1] > 0.9999 then betan[1] = 0.99;

         if betan[2] < 0.0001 then betan[2] = 0.01;
    else if betan[2] > 0.9999 then betan[2] = 0.99;

    *********************************************************************************;
    *   Compute logbb under new beta estimate and see whether there an improvement;
    *********************************************************************************;

	pi  = betan[1];
	rho  = betan[2];
	pic  = 1-pi;
	rhoc = 1-rho;
	c    = 1/rho/rho -1;
	cpi  = pi*c;
	cpic = c*pic;
	b    = -2/(rho**3);

	logbb = 0;

	do j = 1 to n;
		mct   = exp(lgamma(m[j]+1)-lgamma(t[j]+1)-lgamma(m[j]-t[j]+1));
		part1 = exp(lgamma(c) - lgamma(m[j]+c));
		part2 = exp(lgamma(t[j]+c*pi) - lgamma(c*pi));
		part3 = exp(lgamma(m[j]-t[j]+c*(1-pi)) - lgamma(c*(1-pi)));
        logbb = logbb + log(mct*part1*part2*part3);
	end;

    *******************************************************************;
    *   End of computation of new logbb under new beta estimate;
    *******************************************************************;

    if (logbb > logl_old | split >5) then stop2=1;
    split = split+1;

	*###################################;
	end;        *end of stop2 while loop;
	*###################################;

	if split>6 then stop1=1; else beta = betan;

    criteria = abs(logbb - logl_old)/abs(logl_old + eps1);
    if ( criteria < eps2 | iterate > 20) then stop1=1;
    iterate = iterate + 1;

	*###################################;
	end;        *end of stop1 while loop;
	*###################################;

	pi   = beta[1];
	rho  = beta[2];
	pic  = 1-pi;
	rhoc = 1-rho;
	c    = 1/rho/rho -1;
    cpi  = pi*c;
    cpic = c*pic;
    b    = -2/(rho**3);

	*******************************************************************;
	*	Final computation of  Fisher information under BB distribution; 
	*******************************************************************;

	FIMBB = j(2,2,0);
	RUN FISHERBB;
    INVBB  = inv(FIMBB);
    se_pi  = sqrt(INVBB[1,1]);
    se_rho = sqrt(INVBB[2,2]);

	est        = j(2,5,0);
	est[1,1:2] = (round(pi, 0.00001)||round(se_pi, 0.00001));
	est[2,1:2] = (round(rho, 0.00001)||round(se_rho, 0.00001));
	est[,3]    = round(est[,1]/est[,2], 0.0001);
	est[1,4]   = n-2;
	est[2,4]   = n-2;
	est[,5]    = 2*(1- PROBT(est[,3], est[,4]));
	if est[,5] < 0.0001 then est[,5] = 0.0001;
	vvv          = 2;
	fitStat      = j(4,1,0);
    fitStat[1,1] = -2*logbb;
    fitStat[2,1] = fitStat[1,1] + 2*vvv;                *--- AIC;
    fitStat[3,1] = fitStat[1,1] + 2*vvv*n / (n-vvv-1);  *--- AICC;
    fitStat[4,1] = fitStat[1,1] + vvv*log(n);           *--- BIC;

	************************************************************************;
	*   Compute expected frequency from BB and check for cell frequency >=5;
	*   and hence determine k;
	*************************************************************************;
	k    = max(mj) + 1;
    pic  = 1-pi;
    rhoc = 1-rho;
	c    = 1/rho/rho -1;

    *   Initialization;
    lowerb = j(k,1, -0.0000001);
    upperb = j(k,1,  1.0000001);

    expect = j(k, 1, 0);

    *   Define lower and upper bound for the intervals;
    do s = 2 to k;
        lowerb[s]   = (s-1)/k;
        upperb[s-1] = (s-1)/k;
    end;

    *   Compute Expected Counts under Beta Binomial Distribution;
	do s = 1 to k-1;
	expect[s] = 0;
		do j=1 to size_mj;
			probbb = 0;
			do it  = 0 to mj[j];
			ratio  = it/mj[j];
				if ((ratio > lowerb[s]) & (ratio <= upperb[s])) then do;
					aux    = lgamma(mj[j]+1)+lgamma(c)+lgamma(it+c*pi)+lgamma(mj[j]-it+c*(1-pi))
					       - lgamma(it+1)-lgamma(mj[j]-it+1)-lgamma(mj[j]+c)-lgamma(c*pi)-lgamma(c*(1-pi));
					probbb = probbb + exp(aux);
				end;
			end;
		expect[s] = expect[s] + fj[j]*probbb;
		probbb=0;
		end;
	end;
	expect[k] = n-sum(expect[1:k-1]);

	**************************************************************;
	*   CATEGORIES WITH EXPECTED FREQUENCIES SMALLER THAN 5 ARE ;
	*	COLLASPED WITH PRIOR CATEGORY;
	**************************************************************;
	do false = 1 to 1;	*	necessary for GOTO statement;

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

    **********************************************************************;
    *   Goodness of fit test under Beta Binomial distribution;
    **********************************************************************;

	*	Compute observed count;
    obs      = j(r, 1, 0);

	ratio = t/m;
    do s = 1 to r-1;
        obs[s] = sum( (ratio > lower[s]) & (ratio <= upper[s]) );
    end;

	obs[r]   = n - sum(obs[1:r-1]);
    lower[1] = 0;
    upper[r] = 1.0000;
	obs_sum  = sum(obs);
    exp_sum  = sum(expected);

	*   Compute the corresponding chi-square under Beta-binomial distribution;

	chisq  = 0;
    df     = r-3;
	chisq  = sum((obs-expected)##2/expected);
	chisq  = round( chisq, 0.0001);
    pvalue  = round((1- PROBCHI(chisq, df)), 0.0001);
	GOFStat = chisq ||df||pvalue;

	mattrib lower format=8.4;
	mattrib upper format=8.4;
	mattrib obs      label='Observed Frequency' format=8.0;
	mattrib expected label='Expected Frequency' format=8.4;

	mattrib n       label='No. of Clusters'      format=8.0;
	mattrib obs_sum label='Observed Frequencies' format=8.0;
	mattrib exp_sum label='Expected Frequencies' format=12.4;

	mattrib chisq  label='Chi-square' format=8.4;
	mattrib df     label='DF'         format=8.0;
	mattrib pvalue label='P-value'    format=8.4;

	mattrib est colname={'Estimate' 'Std-Error' 't-Value' 'DF' 'p-Value'} 
            label='Maximum Likelihood Estimates';
	mattrib fitStat rowname={'-2 Log Likelihood', 'AIC (smaller is better)', 
            'AICC (smaller is better)', 'BIC (smaller is better)'} 
            label='Fit Statistics' format=20.2;
	mattrib GOFStat colname={'GOF-Stat' 'DF' 'p-Value'}
            label='GOF Test Statistic';

	Label = { 'Parameter Pi' , 'Parameter Rho' };
	print fitStat;
	print est[rowname=label];
	print "Goodness-of-fit Test under Beta-binomial Distribution" ;
	print lower upper obs expected;
	print "Total Counts";
	print n obs_sum exp_sum;
	print "Null Hypothesis: Data are distributed according to a Beta-binomial Distribution";
	print GOFStat;

	*******************************************************;
	end;        *   End of group do loop;
	*******************************************************;

	*   Output Residuals (Observed - Expected) into data set Resid_BB needed later for QQ-Plots;

	Distribution = j(nrow(obs),1,'Beta-binomial ');
	Resid        = obs - expected;
	create Resid_BB var{ Distribution Resid };
	append;

	quit;
	title;
	title2;
	%mend GOF_BB;
	*	End of Macro GOF_fBB;

	*	Usage:;
	*%GOF_BB(inds=group2,t=t,m=m, title2=Group III Haseman and Soares (1976));

