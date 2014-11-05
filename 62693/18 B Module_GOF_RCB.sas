


	**************************************************************************************
	  Author:			Santosh C Sutradhar
						Associate Director
						Pfizer Inc.
						235 East 42nd St
						New York, NY 10017
						Phone: (212) 733-0496
						Email: Santosh.Sutradhar@pfizer.com

	  Last Modified:	Sep 16, 2009

	  Purpose: 		To write a SAS MACRO in order to compute MLE
					and perform GOF-test under Random-clumped Binomial distribution.
					This GOF_RCB() SAS Macro computes the MLE iteratively 
                    using the Fisher-Scoring method based on Direct Likelihood 

	  Required:		To call other module in file fisherfm.sas

	  List of MACRO variables: 
	  		inds = input SAS data (MUST contains three variables t, m, group - name may be different) 
			t = cluster count 
			m = cluster size 
			group = group variable

	  Usage:	%GOF_RCB(inds=HS,t=t,m=m, title2=HS data set)

	  Comment: 		Varying cluster sizes (m) were assumed 
					Initial number of classes to form GOF = MAX(m's) + 1
	***************************************************************************************;

	%macro GOF_RCB(inds= , t=, m=, title2 = "Data: ");

	title1 "Goodness-of-fit test under Random-clumped Binomial distribution";
	title2 "&title2";

	****************************************;
	*       Starting IML procedure;
	****************************************;

	proc iml;

	*	Print input information;
	file print;

	**********************************************************************;
	*   Module: FISHERRCB: This module can be called to 
	*           Compute Fisher information under RCB distribution;
	**********************************************************************;
	start FISHERRCB;
    do j = 1 to size_mj;
        mp1     = mj[j]*p1;
        mp2     = mj[j]*p2;
        derrcb1 = j(mj[j]+1, 1, 0);
        derrcb2 = j(mj[j]+1, 1, 0);
        AH      = j(2,2,0);

		x1        = (0:mj[j])`;
		m2        = mj[j] +1;
		pr1       = PROBBNML(p1,mj[j],x1);
		pr2       = PROBBNML(p2,mj[j],x1);
		pr1[2:m2] = pr1[2:m2] - pr1[1:(m2-1)];
		pr2[2:m2] = pr2[2:m2] - pr2[1:(m2-1)];

        do i = 1 to mj[j]+1;
            u  = i-1;
			pt = pi*pr1[i] + pic*pr2[i];
			if pt < 1e-10 then pt = 1e-10;
            b1 = u - mp1;
            b2 = u - mp2;
            a1 = c1*b1 + p1;
            a2 = c2*b2 - p2c;

            derrcb1[i] = (pr1[i] * a1/p1 + pr2[i]*a2/p2c);
            derrcb2[i] = (pr1[i] * b1*c3 - pr2[i]*b2*c4)/rhoc;

        *   Compute Fisher information for each different mj;
            AH[1,1] = AH[1,1] + derrcb1[i]*derrcb1[i]/pt;
            AH[1,2] = AH[1,2] + derrcb1[i]*derrcb2[i]/pt;
            AH[2,2] = AH[2,2] + derrcb2[i]*derrcb2[i]/pt;
        end;    *   end of t = 1 to m do loop;
        AH[2,1]=AH[1,2];
        FIMRCB  = FIMRCB + fj[j]*AH;
    end;    *   End of j=1 to size_mj do loop;
	finish FISHERRCB;
	*	End of Module:		FISHERRCB;

	*	Read the input data set with variables: t, m, and group; 
	use &inds var {&t &m};
		read all into y;
	close &inds;

	n       = nrow(y);
	t       = y[,1];
	m       = y[,2];
	mj      = unique(m)`;
	size_mj = nrow(mj);
	fj      = repeat(0,size_mj,1);

	do j = 1 to size_mj;
	   fj[j] = sum(m=mj[j]);
	end;

	*   Distribution of mj;
	print 'Distribution of Cluster Size (m)';
	print mj[label='Cluster Size (m)'] fj[label='Frequency'];

    ****************************************************************************;
    *   ML estimation of parameters using ungrouped likelihood. ;
    *   Sum of the Logarithm of the likelihood (-ve) for Random-clumped Binomial;
    ****************************************************************************;

	*	Moment estimate of the pi and rho to be used as an initial estimates;
    pi = sum(t[*])/sum(m[*]);

	if (pi = 0 | pi = 1) then pi = (sum(t[*]) + 1)/(sum(m[*]) + 2);

    num   = n*(t-m*pi)[##];
    denum = ((n-1)*pi*(1-pi));
    mm    = m#(m-j(n,1,1));
    if  ((num/denum - sum(m[*]))/(sum(mm[*])) > 0) then 
        rho = sqrt((num/denum - sum(m[*]))/(sum(mm[*]))); else rho = 0.01;

	*	Initilation of parameters;
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
	    pi    = beta[1];
	    rho   = beta[2];
	    pic   = 1-pi;
	    rhoc  = 1-rho;
	    pipic = pi*pic;
	    p2    = rhoc*pi;
	    p1    = p2 + rho;
		if p1 >= 1 then p1 = 0.99;
	    p1c = 1-p1;
	    p2c = 1-p2;
	    c1  = pi/pic;
	    c2  = pic/pi;
	    c3  = pi/p1;
	    c4  = pic/p2c;
	
	    logrcb = 0;
	    grad   = j(2,1,0);
	
		*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO;
		    do j = 1 to n;  *   Looping for all observations 1-n ;
		*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO;
		 	if (t[j] = 0) then do;
			    pr1 = PROBBNML(p1,m[j],t[j]);
	    	    pr2 = PROBBNML(p2,m[j],t[j]);
	    	    pt  = pi*pr1 + pic*pr2;
    	    end;
    	    else  do;
    	        pr1 = PROBBNML(p1,m[j],t[j]) - PROBBNML(p1,m[j],t[j]-1);
    	        pr2 = PROBBNML(p2,m[j],t[j]) - PROBBNML(p2,m[j],t[j]-1);
    	        pt  = pi*pr1 + pic*pr2;
    	    end;
	
	       if pt < 1e-10 then pt = 1e-10;
	       logrcb = logrcb + log(pt);
	       logl   = -2*logrcb;

	    ***************************************************************;
	    *   Compute gradient under Random-clumped Binomial distribution;
	    ***************************************************************;
        b1 = t[j] - m[j]*p1;
        b2 = t[j] - m[j]*p2;
        a1 = c1*b1 + p1;
        a2 = c2*b2 - p2c;
        grad[1]= grad[1] + (pr1 * a1/p1 + pr2*a2/p2c)/pt;
        grad[2]= grad[2] + (pr1 * b1*c3 - pr2*b2*c4)/rhoc/pt;

		*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO;
	    end;    *    Of looping for observations;
		*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO;

    *************************************************************************;
    *   Compute Fisher information under Random-clumped Binomial distribution;
    *************************************************************************;

    FIMRCB = j(2,2,0);
	run FISHERRCB;
    INVRCB    = inv(FIMRCB);
    logl_old = logrcb;
    add      = INVRCB*grad;

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
	    *   Compute logrcb under new beta estimate and see whether there an improvement;
	    *********************************************************************************;
	    pi    = betan[1];
	    rho   = betan[2];
	    pic   = 1-pi;
	    rhoc  = 1-rho;
	    pipic = pi*pic;
	    p2    = (1-rho)*pi;
	    p1    = p2 + rho;
		if p1 >= 1 then p1 = 0.99;
	    p1c = 1-p1;
	    p2c = 1-p2;
	    c1  = pi/pic;
	    c2  = pic/pi;
	    c3  = pi/p1;
	    c4  = pic/p2c;
	
	    logrcb = 0;
	
	    do j = 1 to n;
	        pr1=PROBBNML(p1,m[j],t[j]);
	        pr2=PROBBNML(p2,m[j],t[j]);
	
	        if (t[j] = 0) then do;
	            pt = (pi*pr1+pic*pr2);
	        end;
	        else  do;
	            pr1_1 = PROBBNML(p1,m[j],t[j]-1);
	            pr2_1 = PROBBNML(p2,m[j],t[j]-1);
	            pt    = (pi*(pr1 - pr1_1)+pic*(pr2 - pr2_1));
	        end;
    	   if pt < 1e-10 then pt = 1e-10;
    	    logrcb = logrcb + log(pt);
    	end;

    	*******************************************************************;
    	*   End of computation of new logrcb under new beta estimate;
    	*******************************************************************;
	
	    if (logrcb > logl_old | split >5) then stop2=1;
	    split = split+1;
	
		*###################################;
	    end;        *end of stop2 while loop;
		*###################################;

		if split>6 then stop1=1; else beta = betan;
	    criteria = abs(logrcb - logl_old)/abs(logl_old + eps1);
	    if ( criteria < eps2 | iterate > 20) then stop1=1;
	    iterate = iterate + 1;

	*###################################;
	end;        *end of stop1 while loop;
	*###################################;

    pi   = beta[1];
    rho  = beta[2];
    pic  = 1-pi;
    rhoc = 1-rho;
    p2   = rhoc*pi;
    p1   = p2 + rho;
	if p1 >= 1 then p1 = 0.99;
	p1c = 1-p1;
	p2c = 1-p2;
    c1  = pi/pic;
    c2  = pic/pi;
    c3  = pi/p1;
    c4  = pic/p2c;

    *******************************************************************;
    *   Final computation of  Fisher information under RCB distribution;
    *******************************************************************;

    FIMRCB = j(2,2,0);
	run FISHERRCB;
    INVRCB  = inv(FIMRCB);
    se_pi  = sqrt(INVRCB[1,1]);
    se_rho = sqrt(INVRCB[2,2]);

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
    fitStat[1,1] = -2*logrcb;
    fitStat[2,1] = fitStat[1,1] + 2*vvv;                *--- AIC;
    fitStat[3,1] = fitStat[1,1] + 2*vvv*n / (n-vvv-1);  *--- AICC;
    fitStat[4,1] = fitStat[1,1] + vvv*log(n);           *--- BIC;

	*************************************************************************;
	*   Compute expected frequency from RCB and check for cell frequency >=5;
	*   and hence determine r;
	*************************************************************************;
	k    = max(mj) + 1;
    pic  = 1-pi;
    rhoc = 1-rho;
    p2   = rhoc*pi;
    p1   = p2 + rho;
	if p1 >= 1 then p1 = 0.99;

    *   Initialization;
    lowerb = j(k,1, -0.0000001);
    upperb = j(k,1,  1.0000001);

    P = j(k, 1, 0);


    *   Define lower and upper bound for the intervals;
    do s = 2 to k;
        lowerb[s]   = (s-1)/k;
        upperb[s-1] = (s-1)/k;
    end;

    *   Compute Expected Counts under FRandom-clumped Binomial Distribution;
    do s = 1 to k-1;
		P[s] = 0;
		do j=1 to size_mj;
			probfm = 0;
			x1        = (0:mj[j])`;
			m2        = mj[j] +1;
			pr1       = PROBBNML(p1,mj[j],x1);
			pr2       = PROBBNML(p2,mj[j],x1);
			pr1[2:m2] = pr1[2:m2] - pr1[1:(m2-1)];
			pr2[2:m2] = pr2[2:m2] - pr2[1:(m2-1)];
			do it = 0 to mj[j];
				i = it + 1;
				ratio = it/mj[j];
				if ((ratio > lowerb[s]) & (ratio <= upperb[s])) then
					probfm = probfm + pi*pr1[i] + (1-pi)*pr2[i];
			end;
			P[s]   = P[s] + fj[j]*probfm;
			probfm = 0;
		end;
	end;
    P[k] = n-sum(P[1:k-1]);

	exp  = P;

	**************************************************************;
	*   CATEGORIES WITH EXPECTED FREQUENCIES SMALLER THAN 5 ARE ;
	*	COLLASPED WITH PRIOR CATEGORY;
	**************************************************************;
	do false = 1 to 1;	*	necessary for GOTO statement;
    class = k;
    index = 1;
     s    = 1;
    aux2  = j(k,1,0);
    aux4  = j(k,1,0);
	begin2:
    aux2[index] = exp[s];
	aux4[index] = upperb[s];
	    do while(s < k);
	        if (aux2[index] < 5) then do;
	            s = s+1;
	            class = class-1;
	            aux2[index] = aux2[index] + exp[s];
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
    *   Goodness of fit test under Random-clumped Binomial distribution;
    **********************************************************************;

	*	Compute observed count;
	obs = j(r,1,0);

	ratio = t/m;
    do s = 1 to r-1;
        obs[s] = sum( (ratio > lower[s]) & (ratio <= upper[s]) );
    end;

	obs[r]   = n - sum(obs[1:r-1]);
    lower[1] = 0;
    upper[r] = 1.0000;
	obs_sum  = sum(obs);
	exp_sum  = sum(expected);

	*   Compute the corresponding chi-square under Random-clumped Binomial distribution;

	chisq   = 0;
    df      = r-3;
	chisq   = sum((obs-expected)##2/expected);
	chisq   = round( chisq, 0.0001);
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
	print "Goodness-of-fit Test under Random-clumped Binomial Distribution";
	print lower upper obs expected;
	print "Total Counts";
	print n obs_sum exp_sum;
	print "Null Hypothesis: Data are distributed according to a Random-clumped Binomial Distribution";
	print GOFStat;

	*******************************************************;
	end;        *   End of group do loop;
	*******************************************************;
	
	*   Output Residuals (Observed - Expected) into data set Resid_RCB needed later for QQ-Plots;

	Distribution = j(nrow(obs),1,'Random-clumped');
	Resid        = obs - expected;
	create Resid_RCB var{ Distribution Resid };
	append;

	quit;
	title;
	title2;
	%mend GOF_RCB;  
	*	End of Macro;

	*	Usage:;
	*%GOF_RCB(inds=group2,t=t,m=m, title2=Group III Haseman and Soares (1976));

