


	/* 
		Ossification Example from Morel and Neerchal (1997), 
		Statistics in Medicine, 16, 2843-2853
	*/

	data ossification;
	   length tx $8;
	   input tx$ n @@;
	   do i=1 to n;
	      input t m @@;
		  m_t = m - t;
	      output;
	   end;
	   drop n i;
	   datalines;
	Control  18 8 8 9  9  7  9 0  5 3  3 5 8 9 10 5 8 5 8 1 6 0 5
	            8 8 9 10  5  5 4  7 9 10 6 6 3  5 
	Control  17 8 9 7 10 10 10 1  6 6  6 1 9 8  9 6 7 5 5 7 9
	            2 5 5  6  2  8 1  8 0  2 7 8 5  7
	PHT      19 1 9 4  9  3  7 4  7 0  7 0 4 1  8 1 7 2 7 2 8 1 7
	            0 2 3 10  3  7 2  7 0  8 0 8 1 10 1 1
	TCPO     16 0 5 7 10  4  4 8 11 6 10 6 9 3  4 2 8 0 6 0 9
	            3 6 2  9  7  9 1 10 8  8 6 9
	PHT+TCPO 11 2 2 0  7  1  8 7  8 0 10 0 4 0  6 0 7 6 6 1 6 1 7
	;

	ods html;

	title "Binomial Distribution, Full Model on the Betas";
	proc nlmixed data=ossification;
	   parms b0=0, b1=0, b2=0, b3=0;
	   if (tx='Control')       then linp = b0;
	   else if (tx='TCPO')     then linp = b0+b1;
	   else if (tx='PHT')      then linp = b0+b2; 
	   else if (tx='PHT+TCPO') then linp = b0+b1+b2+b3;
	   pi = 1/(1+exp(-linp));
	   model t ~ binomial( m,pi );
	   estimate 'Pi  Control'  1/(1+exp(-b0));
	   estimate 'Pi  TCPO'     1/(1+exp(-b0-b1));
	   estimate 'Pi  PHT'      1/(1+exp(-b0-b2));
	   estimate 'Pi  PHT+TCPO' 1/(1+exp(-b0-b1-b2-b3));
	   estimate 'Logarithm Odds-Ratio PHT Vs Control when TCPO Absent ' b2; 
	   estimate 'Logarithm Odds-Ratio PHT Vs Control when TCPO Present' b2+b3; 
	run;

	title "Beta-binomial Distribution, Full Model on the Betas, Common Rho";
	proc nlmixed data=ossification;
	   parms b0=0, b1=0, b2=0, b3=0, a0=0;
	   linr = a0;
	   rho = 1/(1+exp(-linr));
	   c   = 1 / rho / rho - 1;
	   if (tx='Control')       then linp = b0;
	   else if (tx='TCPO')     then linp = b0+b1;
	   else if (tx='PHT')      then linp = b0+b2; 
	   else if (tx='PHT+TCPO') then linp = b0+b1+b2+b3;
	   pi  = 1/(1+exp(-linp));
	   pic = 1 - pi;
	   z   = lgamma(m+1) - lgamma(t+1) - lgamma(m_t+1);
	   ll  = z + lgamma(c) + lgamma(t+c*pi) + lgamma(m_t+c*pic)
	         - lgamma(m+c) - lgamma(c*pi) - lgamma(c*pic);
	   model t ~ general(ll);
	   estimate 'Pi  Control'    1/(1+exp(-b0));
	   estimate 'Pi  TCPO'       1/(1+exp(-b0-b1));
	   estimate 'Pi  PHT'        1/(1+exp(-b0-b2));
	   estimate 'Pi  PHT+TCPO'   1/(1+exp(-b0-b1-b2-b3));
	   estimate 'Logarithm Odds-Ratio PHT Vs Control when TCPO Absent ' b2; 
	   estimate 'Logarithm Odds-Ratio PHT Vs Control when TCPO Present' b2+b3; 
	   estimate 'Common Rho*Rho' 1/(1+exp(-a0))/(1+exp(-a0));
	run;

	title "Random-clumped Binomial Distribution, Full Model on the Betas, Common Rho";
	proc nlmixed data=ossification;
	   parms b0=0, b1=0, b2=0, b3=0, a0=0;
	   linr = a0;
	   rho  = 1/(1+exp(-linr));
	   if (tx='Control')       then linp = b0;
	   else if (tx='TCPO')     then linp = b0+b1;
	   else if (tx='PHT')      then linp = b0+b2; 
	   else if (tx='PHT+TCPO') then linp = b0+b1+b2+b3;
	   pi  = 1/(1+exp(-linp));
	   pic = 1 - pi;
	   p1  = ( 1 - rho )*pi + rho;
	   p1c = 1 - p1;
	   p2  = p1 - rho;
	   p2c = 1 - p2;
	   z   = lgamma(m+1) - lgamma(t+1) - lgamma(m_t+1);
	   ll  = z + log( pi*p1**t*p1c**m_t  +  pic*p2**t*p2c**m_t );
	   model t ~ general( ll );
	   estimate 'Pi  Control'    1/(1+exp(-b0));
	   estimate 'Pi  TCPO'       1/(1+exp(-b0-b1));
	   estimate 'Pi  PHT'        1/(1+exp(-b0-b2));
	   estimate 'Pi  PHT+TCPO'   1/(1+exp(-b0-b1-b2-b3));
	   estimate 'Logarithm Odds-Ratio PHT Vs Control when TCPO Absent ' b2; 
	   estimate 'Logarithm Odds-Ratio PHT Vs Control when TCPO Present' b2+b3; 
	   estimate 'Common Rho*Rho' 1/(1+exp(-a0))/(1+exp(-a0));
	run;

	ods html close;








	ods html;

	title "Beta-binomial, Full Model on the Betas, Full Model on the Alphas";
	proc nlmixed data=ossification cov;
	   parms b0=0, b1=0, b2=0, b3=0, a0=0, a1=0, a2=0, a3=0;
	   if (tx='Control')       then linr = a0;
	   else if (tx='TCPO')     then linr = a0+a1;
	   else if (tx='PHT')      then linr = a0+a2;
	   else if (tx='PHT+TCPO') then linr = a0+a1+a2+a3;
	   rho = 1/(1+exp(-linr));
	   c   = 1 / rho / rho - 1;
	   if (tx='Control')       then linp = b0;
	   else if (tx='TCPO')     then linp = b0+b1;
	   else if (tx='PHT')      then linp = b0+b2; 
	   else if (tx='PHT+TCPO') then linp = b0+b1+b2+b3;
	   pi  = 1/(1+exp(-linp));
	   pic = 1 - pi;
	   z   = lgamma(m+1) - lgamma(t+1) - lgamma(m-t+1);
	   ll  = z + lgamma(c)   + lgamma(t+c*pi) + lgamma(m-t+c*pic)
	         -  lgamma(m+c) - lgamma(c*pi)   - lgamma(c*pic);
	   model t ~ general(ll);
	   estimate 'Pi  Control'      1/(1+exp(-b0));
	   estimate 'Pi  TCPO'         1/(1+exp(-b0-b1));
	   estimate 'Pi  PHT'          1/(1+exp(-b0-b2));
	   estimate 'Pi  PHT+TCPO'     1/(1+exp(-b0-b1-b2-b3));
	   estimate 'Logarithm Odds-Ratio PHT Vs Control when TCPO Absent ' b2; 
	   estimate 'Logarithm Odds-Ratio PHT Vs Control when TCPO Present' b2+b3; 
	   estimate 'Rho*Rho Control'  1/(1+exp(-a0))/(1+exp(-a0));
	   estimate 'Rho*Rho TCPO'     1/(1+exp(-a0-a1))/(1+exp(-a0-a1));
	   estimate 'Rho*Rho PHT'      1/(1+exp(-a0-a2));
	   estimate 'Rho*Rho PHT+TCPO' 1/(1+exp(-a0-a1-a2-a3))/(1+exp(-a0-a1-a2-a3));
	run;

	title "Random-clumped Binomial, Full Model on the Betas, Full Model on the Alphas";
	proc nlmixed data=ossification cov;
	   parms b0=0, b1=0, b2=0, b3=0, a0=0, a1=0, a2=0, a3=0;
	   if (tx='Control')       then linr = a0;
	   else if (tx='TCPO')     then linr = a0+a1;
	   else if (tx='PHT')      then linr = a0+a2;
	   else if (tx='PHT+TCPO') then linr = a0+a1+a2+a3;
	   rho = 1/(1+exp(-linr));
	   if (tx='Control')       then linp = b0;
	   else if (tx='TCPO')     then linp = b0+b1;
	   else if (tx='PHT')      then linp = b0+b2; 
	   else if (tx='PHT+TCPO') then linp = b0+b1+b2+b3;
	   pi  = 1/(1+exp(-linp));
	   pic = 1 - pi;
	   p1  = ( 1 - rho )*pi + rho;
	   p1c = 1 - p1;
	   p2  = p1 - rho;
	   p2c = 1 - p2;
	   z   = lgamma(m+1) - lgamma(t+1) - lgamma(m_t+1);
	   ll  = z + log( pi*p1**t*p1c**m_t  +  pic*p2**t*p2c**m_t );
	   model t ~ general( ll );
	   estimate 'Pi  Control'      1/(1+exp(-b0));
	   estimate 'Pi  TCPO'         1/(1+exp(-b0-b1));
	   estimate 'Pi  PHT'          1/(1+exp(-b0-b2));
	   estimate 'Pi  PHT+TCPO'     1/(1+exp(-b0-b1-b2-b3));
	   estimate 'Logarithm Odds-Ratio PHT Vs Control when TCPO Absent ' b2; 
	   estimate 'Logarithm Odds-Ratio PHT Vs Control when TCPO Present' b2+b3; 
	   estimate 'Rho*Rho Control'  1/(1+exp(-a0))/(1+exp(-a0));
	   estimate 'Rho*Rho TCPO'     1/(1+exp(-a0-a1))/(1+exp(-a0-a1));
	   estimate 'Rho*Rho PHT'      1/(1+exp(-a0-a2));
	   estimate 'Rho*Rho PHT+TCPO' 1/(1+exp(-a0-a1-a2-a3))/(1+exp(-a0-a1-a2-a3));
	run;

	ods html close;

