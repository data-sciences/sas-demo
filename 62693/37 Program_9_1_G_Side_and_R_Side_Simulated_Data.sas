


	data hair;
		seed = 1999;
		beta = 1.386294;  *--- P is approximately 0.8;
		do Subj_id=1 to 1000;
		s1 = 2*normal(seed);
		s2 = sqrt(1.5)*normal(seed);
			do week=1 to 8;
				score = round(s1 + normal(seed), 0.01);
				p     = 1/(1+exp(-beta - s2));
				y     = 0;
				u     = uniform(seed);
				if u < p then y = 1;
				output;
			end;
		end;
	keep subj_id score y;
	run;

	ods html;
	title "*** Linear Mixed Model with G-side Random Effects ***";
	 proc glimmix data=hair;
		class subj_id;
		model score =  / s;
		random int / subject=subj_id;
	run;

	title "*** Linear Mixed Model with R-side Random Effects ***";
	proc glimmix data=hair;
		class subj_id;
		model score =  / s;
		random _residual_ / subject=subj_id type=cs;
	run;

	title "*** Logistic Model with G-side Random Effects ***";
	 proc glimmix data=hair;
		class subj_id;
		model y (ref='0') =  / dist=binary link=logit s;
		random int / subject=subj_id; 
		estimate 'P' int 1 / ilink;
	run;

	title "*** Logistic Model with R-side Random Effects ***";
	proc glimmix data=hair;
		class subj_id;
		model y (ref='0')=  / dist=binary link=logit s;
		random _residual_ / subject=subj_id type=cs;
		estimate 'P' int 1 / ilink;
	run;
	ods html close;









	proc sort data=hair;
		by id;
	run;

	proc means data=hair sum noprint;
		by id;
		var y;
		output out=sum_hair sum=t;
	run;

	data sum_hair;
		set sum_hair;
		m_t = _freq_ - t;
		rename _freq_ = m;
		drop _type_;
	run;

	proc nlmixed data=sum_hair;
	   parms beta=0 rho=0.1;
	   pi  = 1/(1+exp(-beta));
	   pic = 1 - pi;
	   p1  = ( 1 - rho )*pi + rho;
	   p1c = 1 - p1;
	   p2  = p1 - rho;
	   p2c = 1 - p2;
	   z   = lgamma(m+1) - lgamma(t+1) - lgamma(m_t+1);
	   ll  = z + log( pi*p1**t*p1c**m_t  +  pic*p2**t*p2c**m_t );
	   model t ~ general( ll );
	   estimate 'P'    1/(1+exp(-beta));
	   estimate 'Rho*Rho' rho*Rho;
	run;
