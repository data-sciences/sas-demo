
	/* 
	   This Macro is a courtesy of 
       Dr. Justin Newcomer from Sandia National Laboratories
	*/ 

	Proc IML;

	/************************************************************************/
	/*  MLE Functions                                                       */
	/************************************************************************/

	/************************************************************/
	/*  Module: MLEDM(m,T)                                      */
	/*                                                          */
	/*  This Module computes the MLE from a Dirichlet           */
	/*  Multinomial	Distribution using the Fisher               */
	/*  Information	Matrix and the Fisher Scoring Algorithm     */
	/*                                                          */
	/*  m - cluster size                                        */
	/*  T - nxk matrix of counts (t1,t2,...,tk)	where ti is a   */
	/*      nx1 vector of observed counts in category i         */
	/************************************************************/
	Start MLEDM(m, T);

		print "*** Fisher Scoring Method -- Dirichlet-Multinomial Distribution ***";

		pi0   = QLEpi(m,T);
		rho0  = QLErho(m,T,pi0);
		k     = ncol(T);
		n     = nrow(T);
		theta           = j(k,1,0);
		theta[1:(k-1),] = pi0;
		theta[k,]       = rho0;
	
		eps  = 1E-8;
		conv = 1;
		iter = 0;
		Do Until(conv<eps);
		
			iter   = iter + 1;
			pi     = theta[1:(k-1),];
			rho    = theta[k,];
			INVFIM = Inv(n*FIMDM(m, pi, rho));
			Lold   = 0;
			Scores = j(k,1,0);
			Do j = 1 to n;
				tj     = T[j,1:(k-1)]`;
				Scores = Scores + gradDM(m, pi, rho, tj);
				Lold   = Lold + log(ProbDM(m, pi, rho, tj));
			End;

			si   = 0;
			Lnew = Lold - 1;
			Do Until(Lnew > Lold);

				thetaNew = theta + (0.5**si)*INVFIM*Scores;
				pi       = thetaNew[1:(k-1),];
				rho      = thetaNew[k,];
				Lnew     = 0;
				Do j = 1 to n;
					tj   = T[j,1:(k-1)]`;
					Lnew = Lnew + log(ProbDM(m, pi, rho, tj));
				End;

				si = si + 1;
				if si > 20 then do;
					print "NOTE: Step size halved 20 times, convergence assumed";
					Lnew   = Lold + 0.000001;
				end;

			End;

			theta  = thetaNew;
			conv   = abs(Lnew-Lold)/(abs(Lnew)+1E-6);
			conv_0 = conv;

			if si > 20 then conv = eps - 0.000001;
			if iter > 100 then do;
				print "NOTE: After 100 iterations, convergence not met yet";
				conv = eps - 0.000001;
			end;

		End;
 		
		if conv_0 < eps then do;
			print "NOTE: Convergence criterion (EPSILON=1E-8) satisfied";
		end;

		Return(theta);

	Finish;
	Store Module=MLEDM;


	/********************************************************************/
	/*	Module: MLERCM(m,T)												*/
	/*																	*/
	/* 	This Module computes the MLE from a Random-clumped Multinomial	*/
	/* 	Distribution using the Fisher Information 						*/
	/*	Matrix and the Fisher Scoring Algorithm							*/
	/*																	*/
	/*	m - cluster size												*/
	/*	T - nxk matrix of counts (t1,t2,...,tk)	where ti is a			*/
	/*      nx1 vectod of observed counts in category i					*/
	/********************************************************************/
	Start MLERCM(m, T);

		print "*** Fisher Scoring Method -- Random-clumped Multinomial Distribution ***";

		pi0   = QLEpi(m,T);
		rho0  = QLErho(m,T,pi0);
		k     = ncol(T);
		n     = nrow(T);
		theta           = j(k,1,0);
		theta[1:(k-1),] = pi0;
		theta[k,]       = rho0;
	
		eps  = 1E-8;
		conv = 1;
		iter = 0;
		Do Until(conv<eps);
		
			iter   = iter + 1;
			pi     = theta[1:(k-1),];
			rho    = theta[k,];
			INVFIM = Inv(n*FIMRCM(m, pi, rho));
			Lold   = 0;
			Scores = j(k,1,0);
			Do j = 1 to n;
				tj     = T[j,1:(k-1)]`;
				Scores = Scores + gradRCM(m, pi, rho, tj);
				Lold   = Lold + log(ProbRCM(m, pi, rho, tj));
			End;

			si   = 0;
			Lnew = Lold - 1;
			Do Until(Lnew > Lold);

				thetaNew = theta + (0.5**si)*INVFIM*Scores;
				pi       = thetaNew[1:(k-1),];
				rho      = thetaNew[k,];
				Lnew     = 0;
				Do j = 1 to n;
					tj   = T[j,1:(k-1)]`;
					Lnew = Lnew + log(ProbRCM(m, pi, rho, tj));
				End;

				si = si + 1;
				if si > 20 then do;
					print "NOTE: Step size halved 20 times, convergence assumed";
					Lnew   = Lold + 0.000001;
				end;

			End;

			theta  = thetaNew;
			conv   = abs(Lnew-Lold)/(abs(Lnew)+1E-6);
			conv_0 = conv;

			if si > 20 then conv = eps - 0.000001;
			if iter > 100 then do;
				print "NOTE: After 100 iterations, convergence not met yet";
				conv = eps - 0.000001;
			end;

		End;
 		
		if conv_0 < eps then do;
			print "NOTE: Convergence criterion (EPSILON=1E-8) satisfied";
		end;

		Return(theta);

	Finish;
	Store Module=MLERCM;

	/************************************************************************/
	/* 	Fisher Information Matrix Functions									*/
	/************************************************************************/	

	/****************************************************************/
	/*	Module: FIMDM(m,pi,rho)										*/
	/*																*/
	/* 	This Module returns the Fisher Information Matrix for		*/
	/*	a Dirichlet-Multinomial Distribution						*/
	/*																*/
	/*	m - cluster size											*/
	/*	pi - vector of probabilities [pi1, pi2, ... , pi(k-1)]`		*/
	/*	rho - correlation											*/
	/****************************************************************/
	Start FIMDM(m, pi, rho);

		k = nrow(pi)+1;
		c = (1-rho**2)/rho**2;

		FIM = j(k,k,0);
		PrK = 0;
		PrC = 0;
		piK = 1-sum(pi);
		Do s = 1 to m;
			PrK = PrK + ProbGTRBB(m, piK, rho, s)/(c*piK+s-1)**2;
			PrC = PrC + (c+s-1)**-2;
		End;

		Do i = 1 to (k-1);

			PrI = 0;
			Do s = 1 to m;
				PrI = PrI + ProbGTRBB(m, pi[i,], rho, s)/(c*pi[i,]+s-1)**2;
			End;

			FIM[i,i] = (c**2)*(PrI + PrK);
			Do j = (i+1) to (k-1);
				FIM[i,j] = (c**2)*PrK;
				FIM[j,i] = (c**2)*PrK;
			End;
			FIM[i,k] = c*(piK*PrK - pi[i,]*PrI)*(2/rho**3);
			FIM[k,i] = c*(piK*PrK - pi[i,]*PrI)*(2/rho**3);
			FIM[k,k] = FIM[k,k] + (pi[i,]**2)*PrI;

		End;

		FIM[k,k] = (FIM[k,k] + (piK**2)*PrK - PrC)*(4/rho**6);
		Return(FIM);

	Finish;
	Store Module=FIMDM;

	/****************************************************************/
	/*	Module: FIMRCM(m,pi,rho)									*/
	/*																*/
	/* 	This Module returns the Fisher Information Matrix for		*/
	/*	a Random-clumped Multinomial Distribution					*/
	/*																*/
	/*	m - cluster size											*/
	/*	pi - vector of probabilities [pi1, pi2, ... , pi(k-1)]`		*/
	/*	rho - correlation											*/
	/****************************************************************/
	Start FIMRCM(m, pi, rho);
		
		k   = nrow(pi)+1;
		FIM = j(k,k,0);
		t   = j(k,1,0);

		Do l = m to (m+1)**k-1 by m;
			temp = l;
			Do j = k to 1 by -1;
				t[j,] = int(temp/(m+1)**(j-1));
				temp  = temp - (m+1)**(j-1)*t[j,];	
			End;
		
			If sum(t) = m Then Do;
				pdl   = gradRCM(m, pi, rho, t[1:(k-1),]);
				ProbT = ProbRCM(m, pi, rho, t[1:(k-1),]);
				FIM   = FIM + pdl*pdl`*ProbT;
			End;

		End;

		Return(FIM);
		
	Finish;
	Store Module=FIMRCM;


	/************************************************************************/
	/* 	Utility Functions													*/
	/************************************************************************/	

	/************************************************************/
	/* 	This Module returns P(T=t) from a Beta-Binomial			*/
	/*	Distribution											*/
	/*															*/
	/*	m - cluster size										*/
	/*	pi - probability of success								*/
	/*	rho - correlation										*/
	/*  t - number of success									*/
	/************************************************************/
	Start ProbBB(m, pi, rho, t);

		c  = (1-rho**2)/rho**2;
		N1 = 0;
		N2 = 0;
		D  = 0;

		Do k = 1 to t;
			N1 = N1+log(c*pi + k - 1);
		End;
		Do k = 1 to (m-t);
			N2 = N2+log(c*(1-pi) + k - 1);
		End;
		Do k = 1 to m;
			D = D+log(c + k - 1);
		End;
		 
		Prob = comb(m,t)*exp(N1+N2-D);
		Return(Prob);

	Finish;
	Store Module=ProbBB;

	/************************************************************/
	/* 	This Module returns P(T>=t)from a Beta-Binomial 		*/
	/*	Distribution											*/
	/*															*/
	/*	m - cluster size										*/
	/*	pi - probability of success								*/
	/*	rho - correlation										*/
	/*  t - number of success									*/
	/************************************************************/
	Start ProbGTRBB(m, pi, rho, t);

		Prob = 0;
		If t/m >= 0.5 Then Do;
			Do i = t to m;
				Prob = Prob + ProbBB(m, pi, rho, i);
			End;
		End;
		Else Do;
			Do i = 0 to (t-1);
				Prob = Prob + ProbBB(m, pi, rho, i);
			End;
			Prob = 1 - Prob;
		End;
		 
		Return(Prob);

	Finish;
	Store Module=ProbGTRBB;

	/************************************************************/
	/* 	This Module returns P(T1=t1, T2=t2, ... ,Tk=tk) from a 	*/
	/*	Multinomial Distribution.  There are several ways to	*/
	/*  implement this function.  Three versions are provided.  */
	/*															*/
	/*	m - cluster size										*/
	/*	p - vector of probabilities [p1,p2,...,p(k-1)]`			*/
	/*  t - vector of counts {t1,t2,...,t(k-1)]`				*/
	/************************************************************/
	Start ProbMultinomial1(m, p, t);

		k    = nrow(p)+1;
		mtemp = m;
		q     = 1;
		If (t[1,]= 0) Then Prob = PROBBNML(p[1,], mtemp, t[1,]);
		Else Prob = (PROBBNML(p[1,], mtemp, t[1,])-PROBBNML(p[1,], mtemp, t[1,]-1)); 

		Do i = 2 to (k-1) While (mtemp > 0);
			mtemp = mtemp - t[(i-1),];
			If (mtemp^=0) Then Do;
				ti  = t[(i-1),];
				q   = q - p[(i-1),];
				newp = p[i,]/q;
				If (t[i,]=0) Then Prob = Prob*PROBBNML(newp, mtemp, t[i,]); 
				Else Prob = Prob*(PROBBNML(newp, mtemp, t[i,])-PROBBNML(newp, mtemp, t[i,]-1)); 
			End;
		End;

		If Prob < 1e-50 Then Prob = 1e-50;
		Return(Prob);

	Finish;
	Store Module=ProbMultinomial1;

	Start ProbMultinomial2(m, p, t);

		k    = nrow(p)+1;
		Prob = 1;

		Do i = 1 to (k-1);
			Prob = Prob*((p[i,]**t[i,])/gamma(t[i,]+1));
		End;

		pk = 1-sum(p);
		tk = m-sum(t);

		Prob = Prob*gamma(m+1)*((pk**tk)/gamma(tk+1));
		Return(Prob);

	Finish;
	Store Module=ProbMultinomial2;
	
	Start ProbMultinomial(m, p, t);

		k    = nrow(p)+1;
		Prob = 0;

		Do i = 1 to (k-1);
			Prob = Prob + t[i,]*log(p[i,]) - lgamma(t[i,]+1);
		End;

		pk = 1-sum(p);
		tk = m-sum(t);

		Prob = Prob + lgamma(m+1) + tk*log(pk) - lgamma(tk+1);
		Prob = exp(Prob);
		Return(Prob);

	Finish;
	Store Module=ProbMultinomial;

	/************************************************************/
	/* 	This Module returns P(T1=t1, T2=t2, ... ,Tk=tk) from a 	*/
	/*	Random-clumped Multinomial Distribution					*/
	/*															*/
	/*	m - cluster size										*/
	/*	p - vector of probabilities [p1,p2,...,p(k-1)]`			*/
	/*  rho - correlation										*/
	/*  t - vector of counts [t1,t2,...,t(k-1)]`				*/
	/************************************************************/
	Start ProbRCM(m, pi, rho, t);

		k    = nrow(pi)+1;
		e    = diag(j((k-1),1,rho));
		Prob = 0;

		Do i = 1 to (k-1);
			piI  = (1-rho)*pi + e[,i];
			Prob = Prob + pi[i,]*ProbMultinomial(m, piI, t);
		End;

		piK  = (1-rho)*pi;
		pk   = 1-sum(pi);
		Prob = Prob + pk*ProbMultinomial(m, piK, t);
		Return(Prob);

	Finish;
	Store Module=ProbRCM;

	/************************************************************/
	/* 	This Module returns P(T1=t1, T2=t2, ... ,Tk=tk) from a 	*/
	/*	Dirichlet Multinomial Distribution						*/
	/*															*/
	/*	m - cluster size										*/
	/*	p - vector of probabilities [p1,p2,...,p(k-1)]`			*/
	/*  rho - correlation										*/
	/*  t - vector of counts [t1,t2,...,t(k-1)]`				*/
	/************************************************************/
	Start ProbDM(m, pi, rho, t);

		k    = nrow(pi)+1;
		c    = (1-rho**2)/rho**2;
		Prob = lgamma(m+1)+lgamma(c)-lgamma(m+c);

		Do i = 1 to (k-1);
			Prob = Prob+lgamma(t[i,]+c*pi[i,])-lgamma(t[i,]+1)-lgamma(c*pi[i,]);
		End;

		piK  = 1-sum(pi);
		tK   = m-sum(t);
		Prob = exp(Prob+lgamma(tK+c*piK)-lgamma(tK+1)-lgamma(c*piK));
		Return(Prob);

	Finish;
	Store Module=ProbDM;

	/************************************************************************/
	/* 	This Module returns the vector of partial derivitives				*/
	/*	of the log-likelihood for a Random-clumped Multinomial distribution	*/
	/*																		*/
	/*	m - cluster size													*/
	/*	pi - vector of probabilities [p1,p2,...,p(k-1)]`					*/
	/*	rho - correlation													*/
	/*	t - vector of counts {t1,t2,...,t(k-1)]`							*/
	/************************************************************************/
	Start gradRCM(m, pi, rho, t);

		k    = nrow(pi)+1;
		PrT  = ProbRCM(m, pi, rho, t);
		e    = diag(j((k-1),1,rho));
		piK  = (1-rho)*pi;
		prXk = ProbMultinomial(m, piK, t);
		pk   = 1-sum(pi);
		tk   = m-sum(t);
		aK   = (tk/pk) + (prXk/PrT)*(1-(rho*tk)/((1-rho)*pk+rho));
		grad = j(k,1,0);
			
		Do i = 1 to (k-1);

			piI      = (1-rho)*pi + e[,i];
			prXi     = ProbMultinomial(m, piI, t);
			aI       = (t[i,]/pi[i,]) + (PrXi/PrT)*(1-((rho*t[i,])/piI[i,]));
			grad[i,] = aI - aK;
			grad[k,] = grad[k,] + pi[i,]*prXi*((t[i,]-m*piI[i,])/piI[i,]);
	
		End;

		grad[k,] = (1/((1-rho)*prT))*(grad[k,]+pk*prXk*((tk-m*((1-rho)*pk+rho))/((1-rho)*pk+rho)));
		Return(grad);

	Finish;
	Store Module=gradRCM;

	/************************************************************/
	/* 	This Module returns the vector of partial derivitives	*/
	/*	of the log-likelihood for a dirichlet-multinomial 		*/
	/*	distribution											*/
	/*															*/
	/*	m - cluster size										*/
	/*	pi - vector of probabilities [p1,p2,...,p(k-1)]`		*/
	/*	rho - correlation										*/
	/*	t - vector of counts {t1,t2,...,t(k-1)]`				*/
	/************************************************************/
	Start gradDM(m, pi, rho, t);

		k    = nrow(pi)+1;
		piK  = 1-sum(pi);
		tK   = m-sum(t);
		c    = (1-rho**2)/rho**2;
		grad = j(k,1,0);
		fM   = 0;
		fTk  = 0;
		
		fM     = sum(1/(c:(c+m-1)));
		If (tK > 0) Then fTk = sum(1/(c*piK:(c*piK+tK-1)));
		sumfTi = piK*fTk;
	
		Do i = 1 to (k-1);

			fTi = 0;
			If (t[i,] > 0) Then fTi = sum(1/(c*pi[i,]:(c*pi[i,]+t[i,]-1)));
			grad[i,] = c*(fTi - fTk);
			sumfTi   = sumfTi + pi[i,]*fTi;
	
		End;

		grad[k,] = (2/rho**3)*(fM - sumfTi);
		Return(grad);

	Finish;
	Store Module=gradDM;

	/************************************************************/
	/* 	This Module returns Quasi-likelihood estimators for pi	*/
	/*															*/
	/*	m - cluster size										*/
	/*	T - nxk matrix of counts (t1,t2,...,tk)	where ti is a	*/
	/*      nx1 vectod of observed counts in category i			*/
	/************************************************************/
	Start QLEpi(m, T);
		
		n = nrow(T);
		k = ncol(T);
		
		pi = j((k-1),1,0);		
		Do i = 1 to (k-1);
			pi[i,] = sum(T[,i]);
		End;
		
		pi = (1/(n*m))*pi;	
		return(pi);

	Finish;
	Store Module=QLEpi;	

	/************************************************************/
	/* 	This Module returns Quasi-likelihood estimator for rho	*/
	/*															*/
	/*	m -  cluster size										*/
	/*	T -  nxk matrix of counts (t1,t2,...,tk)` where ti is 	*/
	/*       a nx1 vectod of observed counts in category i		*/
	/*	pihat - vector of quasi-likelihood estimates for pi		*/
	/************************************************************/
	Start QLErho(m, T, pihat);
		
		n = nrow(T);
		k = ncol(T);
		
		SS = j((k-1),(k-1),0);
		Do j = 1 to n;
			tj = T[j,1:(k-1)]`;
			SS = SS + (tj-m*pihat)*(tj-m*pihat)`;
		End;
		
		LH1 = Diag(SS);
		LH2 = Inv(Diag(Diag(pihat)-pihat*pihat`));
		LHS = Trace(LH1*LH2)/(m*(n-1)*(k-1));

		rho = sqrt(max((LHS-1)/(m-1), 0.01));

		return(rho);

	Finish;
	Store Module=QLErho;	

	Quit;
	Run;


	%Macro DirMult_RCMult(data, label);

	title &label;

	Proc IML;
	
	use &data;
	read all into T;

	n = nrow(T);
	k = ncol(T);
	m = sum(T[1,]);

	Parameter = shape({'Pi(1)' 'Pi(2)' 'Pi(3)' 'Pi(4)' 'Pi(5)' 
        'Pi(6)' 'Pi(7)' 'Pi(8)' 'Pi(9)'},k-1,1) // {'Rho'} // {'Log Likelihood'};
	PValue = j(k,1,0);

	mattrib Estimate format=12.5;
	mattrib StdErr   format=12.5;
	mattrib ZStat    format=8.2;
	mattrib PValue   format=pvalue6.4;

	/************************************************/
	/*	MLE from DM Distribution					*/
	/************************************************/
	Load Module=MLEDM;
	piMLE1 = j((k-1),1,0);

	thetaMLE = MLEDM(m, T);
	piMLE1   = thetaMLE[1:(k-1),];
	rhoMLE1  = thetaMLE[k,];

	INVFIM = Inv(n*FIMDM(m, piMLE1, rhoMLE1));
	SE1    = j(k,1,0);
	Do i = 1 to k;
		SE1[i,] = sqrt(INVFIM[i,i]);
	End;

	ll = 0;
	Do j = 1 to n;
		tj = T[j,1:(k-1)]`;
		ll = ll + log(ProbDM(m, piMLE1, rhoMLE1, tj));
	End;

	Estimate = piMLE1 // rhoMLE1;
	StdErr   = SE1;
	ZStat    = Estimate / SE1;
	Estimate = Estimate // ll;
	PValue   = 1 - probnorm(ZStat);

	print "Maximum Likelihood Estimates -- Dirichlet-Multinomial Distribution";
	print Parameter Estimate StdErr ZStat PValue;

	/************************************************/
	/*	MLE from RC Distribution					*/
	/************************************************/
	Load Module=MLERCM;
	piMLE1 = j((k-1),1,0);

	thetaMLE = MLERCM(m, T);
	piMLE1   = thetaMLE[1:(k-1),];
	rhoMLE1  = thetaMLE[k,];

	INVFIM = Inv(n*FIMRCM(m, piMLE1, rhoMLE1));
	SE1 = j(k,1,0);
	Do i = 1 to k;
		SE1[i,] = sqrt(INVFIM[i,i]);
	End;

	ll = 0;
	Do j = 1 to n;
		tj = T[j,1:(k-1)]`;
		ll = ll + log(ProbRCM(m, piMLE1, rhoMLE1, tj));
	End;

	Estimate = piMLE1 // rhoMLE1;
	StdErr   = SE1;
	ZStat    = Estimate / SE1;
	Estimate = Estimate // ll;
	PValue   = 1 - probnorm(ZStat);

	print "Maximum Likelihood Estimates -- Random-clumped Multinomial Distribution";
	print Parameter Estimate StdErr ZStat PValue;

	Quit;

	%mend DirMult_RCMult;


	
