


	/*
		Birth Defects Example, Morel and Koehler (1995)
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

	*--- Fits Cumulative Logits -- Full Model;
	ods output ParameterEstimates=beta;
	proc logistic data=new_birth_defects;
		model y = zn2 cd2 cd3 zn2_cd3 zn2_cd2 / link=clogit scale=pearson 
					aggregate=(litter_id);
		output out=out1 predprobs=individual;
		freq count;
	run;

	data out1;
		set out1;
		if y = 1;
		keep litter_id IP_1 IP_2;
	run;

	ods html;

	title1 "Birth Defects Example";
	title2 "Cumulative Logits Model -- Full Model";

	proc iml;
		use birth_defects;
		read all var{t1, t2, t3} into obs_ts;
		use out1;
		read all var{IP_1 IP_2} into pred_probs;
		use birth_defects;
		read all var{zn2 cd2 cd3 zn2_cd3 zn2_cd2} into x_matrix;
		use beta;
		read all var{estimate} into beta;

		m   = obs_ts[,+];
		n   = nrow(obs_ts);
		d   = ncol(obs_ts) - 1;
		k   = ncol(x_matrix);
		df  = n - (d + k);  *--- Recall model being fit is Cumulative Logits;
		a   = j(d,d,0);

		/*
			Given a vector of probabilities p, p=(p(1),p(2),...p(d))'
			this module computes the inverse of the matrix C(p), say A(p), such that
			C(p)*C(p)' = Diag(p) - p*p', 
			where C(p) is obtained using Cholesky decomposition.

			The matrix A(p) is given by

			A(i,j) =  { q(i-1) / ( p(i)   * q(i) ) } ** 0.5   if i=j       
			       =  { p(i)   / ( q(i-1) * q(i) ) } ** 0.5   if i>j
			       =   0                                      if i<j

			See: Tanabe and Sagae (1992)
		*/
		start inv_cp(p,a,d);
		q = {1} // (1 - cusum(p));
		do i=1 to d;
			i1 = i + 1;
			a[i,i] = sqrt( q[i,1] / p[i,1] / q[i1,1] );
			if d > 1 then do;
				do j=1 to i-1;
				a[i,j] = sqrt( p[i,1] / q[i,1] / q[i1,1] );
				end;
			end;
		end;
		finish inv_cp;

		*--- Part 1) Compute Phi;

		Scale   = 0;
		Phi     = j(d,1,0);
		z1 = j(1,1,0);
		z2 = z1;
		do j=1 to n;
			p  = t(pred_probs[j,]);
			t  = t(obs_ts[j,1:d]);
			call inv_cp(p,a,d);
			z       = a * (t - m[j,1] * p) / sqrt(m[j,1]);
			scale   = scale + z` * z;
			phi     = phi + z # z;
			z1      = z1 || z[1,1];
			z2      = z2 || z[2,1];
		end;

		scale   = scale / d / (n-k);
		phi     = phi / df;

		print n d k ,, scale[format=8.4] ,, phi[format=8.4] ,,,;

		*--- Part 2) Compute Generalized Scale Multinomial Variance;

		u            = j(d+k,1,0);
		h            = j(d+k,d+k,0);
		inv_diag_phi = inv( diag( phi ) );

		do j=1 to n;
			p     = t(pred_probs[j,]);
			t     = t(obs_ts[j,1:d]);
			f1f   = cusum(p);
			f1f   = f1f # (1 - f1f);
			f2f   = f1f;

			temp  = diag( f1f );
			if d > 1 then do;
				do i=1 to d-1;
				i1         = i+1;
				temp[i1,i] = -f1f[i,1];
				f2f[i1,1]  = f2f[i1,1] - f1f[i,1];
				end;
			end;

			der   = temp || f2f @ x_matrix[j,];
			call inv_cp(p,a,d);
			aux   = der` * a` * inv_diag_phi * a;
			u     = u + aux * (t - m[j,1] * p); 
			h     = h + m[j,1] * aux * der;
		end;

		covb = inv(h);

		StdErr = diag(covb) ## 0.5 * j(d+k,1,1);
		create StdErr2 var {StdErr}; 
		append;
	 
		create Residuals var {z1 z2}; 
		append;

	quit;

	data beta1;
		format Variance $29.;
		Variance = "Scale Multinomial";
		set beta;
	run;

	data beta2;
		format Variance $29.;
		Variance = "Generalized Scale Multinomial";
		merge beta stderr2;
		WaldChiSq = Estimate * Estimate / StdErr / StdErr;
		ProbChiSq = 1 - probchi(WaldChiSq,DF);
	run;

	data beta12;
		set beta1 beta2;
		format ProbChiSq pvalue6.4; 
	run;

	proc print data=beta12 noobs;
	run;

	ods html close;


	


	*--- Box Plots Residuals Z1 and Z2;
	data Residuals;
		set Residuals;
		if _n_ > 1;
		Z = Z1; Component = 1; Output;
		Z = Z2; Component = 2; Output;
	run;

	ods html;
	ods graphics on;
	proc sgplot data=Residuals;
	  	title "Standardized Components";
	  	vbox z / category=Component extreme;
	run;
	ods graphics off;
	ods html close;


