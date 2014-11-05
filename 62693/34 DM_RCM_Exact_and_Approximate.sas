

	/*
	    This Macro is a courtesy of 
        Dr. Justin Newcomer from Sandia National Laboratories

		In order to use the macro "DM_RCM_Exact_Approximate"
		the user should first load all the IML modules associate to
		the macro "DirMult_RCMult" (See Appendix Appendix B, Chapter 7)
	*/


	Proc IML;

	/************************************************************************/
	/* 	Modules for using approximations Fisher Information Matrices        */
	/************************************************************************/	

	/************************************************************/
	/*	Module: AMLEDM(m,T)										*/
	/*															*/
	/* 	This Module computes the MLE from a Dirichlet 			*/
	/*	Multinomial	Distribution using the approximate Fisher 	*/
	/*	Information Matrix and the Fisher Scoring Algorithm		*/
	/*															*/
	/*	m - cluster size										*/
	/*	T - nxk matrix of counts (t1,t2,...,tk)	where ti is a	*/
	/*      nx1 vector of observed counts in category i			*/
	/************************************************************/
	Start AMLEDM(m, T);

		print "*** Fisher Scoring Method using approximate FIM -- Dirichlet-Multinomial Distribution ***";

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
			INVFIM = Inv(n*AFIMDM(m, pi, rho));
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
	Store Module=AMLEDM;	

	/************************************************************************/
	/*	Module: AMLERCM(m,T)												*/
	/*																		*/
	/* 	This Module computes the MLE from a Random-clumped Multinomial		*/
	/* 	Distribution using the approximate Fisher Information 				*/
	/*	Matrix and the Fisher Scoring Algorithm								*/
	/*																		*/
	/*	m - cluster size													*/
	/*	T - nxk matrix of counts (t1,t2,...,tk)	where ti is a				*/
	/*      nx1 vector of observed counts in category i						*/
	/************************************************************************/
	Start AMLERCM(m, T);

		print "*** Fisher Scoring Method using approximate RCM -- Random-clumped Multinomial Distribution ***";

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
			INVFIM = Inv(n*AFIMRCM(m, pi, rho));
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
	Store Module=AMLERCM;

	/****************************************************************/
	/*	Module: AFIMDM(m,pi,rho)									*/
	/*																*/
	/* 	This Module returns the Approximate Fisher Information 		*/
	/*	Matrix for a Dirichlet-Multinomial Distribution				*/
	/*																*/
	/*	References: Neerchal and Morel, CSDA (2004) - Result 1		*/
	/*			  	Neerchal and Morel, JASA (1998) - Theorem 1		*/
	/*																*/
	/*	m - cluster size											*/
	/*	pi - vector of probabilities [pi1, pi2, ... , pi(k-1)]`		*/
	/*	rho - correlation											*/
	/****************************************************************/
	Start AFIMDM(m, pi, rho);

		k = nrow(pi)+1;
		c = (1-rho**2)/rho**2;

		FIM = j(k,k,0);

		piK = 1-sum(pi);
		PrK = TriGamma(c*piK);
		PrC = TriGamma(c);
		Do i = 1 to (k-1);

			piI      = pi[i,];
			PrI      = TriGamma(c*piI);
			FIM[i,i] = (c**2)*(PrI + PrK);
			Do j = (i+1) to (k-1);
				FIM[i,j] = (c**2)*PrK;
				FIM[j,i] = (c**2)*PrK;
			End;
			FIM[i,k] = c*(piK*PrK - piI*PrI)*(2/rho**3);
			FIM[k,i] = c*(piK*PrK - piI*PrI)*(2/rho**3);
			FIM[k,k] = FIM[k,k] + (piI**2)*PrI;

		End;

		FIM[k,k] = (FIM[k,k] + (piK**2)*PrK - PrC)*(4/rho**6);
		Return(FIM);

	Finish;
	Store Module=AFIMDM;

	/*****************************************************************/
	/*	Module: AFIMRCM(m,pi,rho)									 */
	/*																 */
	/* 	This Module returns the Approximate Fisher Information 		 */
	/*	Matrix for a Random-clumped Multinomial Distribution		 */
	/*																 */
	/*	References: Neerchal and Morel, CSDA (2004) - Result 2		 */
	/*				Neerchal and Morel, JASA (1998) - Theorem 2		 */
	/*				Morel and Nagaraj, Biometrika (1993) - Theorem 1 */
	/*																 */
	/*	m - cluster size											 */
	/*	pi - vector of probabilities [pi1, pi2, ... , pi(k-1)]`		 */
	/*	rho - correlation											 */
	/*****************************************************************/
	Start AFIMRCM(m, pi, rho);
		
		k   = nrow(pi)+1;
		FIM = j(k,k,0);
		
		piK    = 1-sum(pi);
		betaK  = piK/((1-rho)*piK+rho) + (1-piK)/((1-rho)*piK);
		gammaK = (piK*(1-piK))/((1-rho)*piK+rho) + piK/(1-rho);
		Do i = 1 to (k-1);
			
			piI      = pi[i,];
			betaI    = piI/((1-rho)*piI+rho) + (1-piI)/((1-rho)*piI);
			gammaI   = (piI*(1-piI))/((1-rho)*piI+rho) + piI/(1-rho);
			FIM[i,i] = m*((1-rho)**2)*(betaI+betaK) + (1/piI + 1/piK);
			Do j = (i+1) to (k-1);
				FIM[i,j] = m*((1-rho)**2)*betaK + 1/piK;
				FIM[j,i] = m*((1-rho)**2)*betaK + 1/piK;
			End;
			FIM[i,k] = m*(1-rho)*(gammaI-gammaK);
			FIM[k,i] = m*(1-rho)*(gammaI-gammaK);
			FIM[k,k] = FIM[k,k] + (piI*(1-piI))/((1-rho)*piI+rho);

		End;

		FIM[k,k] = (FIM[k,k] + (piK*(1-piK))/((1-rho)*piK+rho))*(m/(1-rho));
		Return(FIM);
		
	Finish;
	Store Module=AFIMRCM;
	
	/************************************************************/
	/*	Module: Stage2DM(m,T)									*/
	/*															*/
	/* 	This Module performs the the Two-Stage Procedure        */
	/*	under the Dirichlet-Multinomial	Distribution 			*/
	/*															*/
	/*	m - cluster size										*/
	/*	T - nxk matrix of counts (t1,t2,...,tk)	where ti is a	*/
	/*      nx1 vector of observed counts in category i			*/
	/************************************************************/
	Start Stage2DM(m, T);

		/* Stage 1 */
		k     = ncol(T);
		n     = nrow(T);
		theta = j(k,1,0);
		theta = AMLEDM(m, T);
	
		/* Stage 2 */
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

		*--- Updates Theta, Step size will be halved up to 20 times;

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
				print "NOTE: At Stage 2, Step size halved 20 times without further improvement";
				Lnew   = Lold + 0.000001;
			end;

		End;

		if si <= 20 then theta = thetaNew;

		Return(theta);

	Finish;
	Store Module=Stage2DM;

	
	/************************************************************/
	/*	Module: Stage2RCM(m,T)									*/
	/*															*/
	/* 	This Module performs the the Two-Stage Procedure        */
	/*	under the Random-clumped Multinomial Distribution 		*/
	/*															*/
	/*	m - cluster size										*/
	/*	T - nxk matrix of counts (t1,t2,...,tk)	where ti is a	*/
	/*      nx1 vector of observed counts in category i			*/
	/************************************************************/
	Start Stage2RCM(m, T);

		/* Stage 1 */
		k     = ncol(T);
		n     = nrow(T);
		theta = j(k,1,0);
		theta = AMLERCM(m, T);
	
		/* Stage 2 */
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

		*--- Updates Theta, Step size will be halved up to 20 times;

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
				print "NOTE: At Stage 2, Step size halved 20 times without further improvement";
				Lnew   = Lold + 0.000001;
			end;

		End;

		if si <= 20 then theta = thetaNew;

		Return(theta);

	Finish;
	Store Module=Stage2RCM;


	Quit;
	Run;


	%Macro DM_RCM_Exact_Approximate(data, label);

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

	mattrib Estimate      format=12.5;
	mattrib StdErr        format=12.6;
	mattrib AppStdErr     format=12.6;
	mattrib Pct_Rel_Error format=12.5;

	/************************************************/
	/*	MLE from DM Distribution					*/
	/************************************************/
	Load Module=MLEDM;

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

	Estimate      = piMLE1 // rhoMLE1 // ll;
	StdErr        = SE1;
	Pct_Rel_Error = StdErr;

	/****************************************************/
	/*	MLE from DM Distribution using approximate FIM 	*/
	/****************************************************/

	Load Module=Stage2DM;

	thetaMLEA = Stage2DM(m, T);
	piMLE1    = thetaMLEA[1:(k-1),];
	rhoMLE1   = thetaMLEA[k,];

	INVFIM = Inv(n*FIMDM(m, piMLE1, rhoMLE1));  *--- Updates FIM;
	SE1    = j(k,1,0);
	Do i = 1 to k;
		SE1[i,] = sqrt(INVFIM[i,i]);
	End;

	ll = 0;                                    *--- Updates log-likelihood;
	Do j = 1 to n;
		tj = T[j,1:(k-1)]`;
		ll = ll + log(ProbDM(m, piMLE1, rhoMLE1, tj));
	End;

	AppStdErr     = SE1;
	Pct_Rel_Error = 100*abs((Pct_Rel_Error - AppStdErr)/Pct_Rel_Error);

	print "Maximum Likelihood Estimates using FIM and Approximate FIM -- Dirichlet-Multinomial Distribution";
	print Parameter Estimate StdErr AppStdErr Pct_Rel_Error;

	/************************************************/
	/*	MLE from RCM Distribution					*/
	/************************************************/
	Load Module=MLERCM;

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

	Estimate      = piMLE1 // rhoMLE1 // ll;
	StdErr        = SE1;
	Pct_Rel_Error = StdErr;

	/****************************************************/
	/*	MLE from RCM Distribution using approximate FIM */
	/****************************************************/

	Load Module=Stage2RCM;

	thetaMLEA = Stage2RCM(m, T);
	piMLE1    = thetaMLEA[1:(k-1),];
	rhoMLE1   = thetaMLEA[k,];

	INVFIM = Inv(n*FIMRCM(m, piMLE1, rhoMLE1)); *--- Updates FIM;
	SE1    = j(k,1,0);
	Do i = 1 to k;
		SE1[i,] = sqrt(INVFIM[i,i]);
	End;

	ll = 0;                                     *--- Updates log-likelihood;
	Do j = 1 to n;
		tj = T[j,1:(k-1)]`;
		ll = ll + log(ProbRCM(m, piMLE1, rhoMLE1, tj));
	End;

	AppStdErr     = SE1;
	Pct_Rel_Error = 100*abs((Pct_Rel_Error - AppStdErr)/Pct_Rel_Error);

	print "Maximum Likelihood Estimates using FIM and Approximate FIM -- Random-clumped Multinomial Distribution";
	print Parameter Estimate StdErr AppStdErr Pct_Rel_Error;

	Quit;

	title;

	%mend DM_RCM_Exact_Approximate;

	
