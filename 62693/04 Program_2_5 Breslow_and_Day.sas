


	/*
		Ille-et-Vilaine Study of oesophageal cancer, Tuyns et al. (1977)
	*/

	data one;
		input age_stratum $ cancer $ x1 x2;
		format alcohol $ $5.;
		alcohol = 'High'; count = x1; output;
		alcohol = 'Low';  count = x2; output;
		drop x1 x2;
		datalines;
		25-34  Case      1    0
		25-34  Control   9  106
		35-44  Case      4    5
		35-44  Control 	26  164
		45-54  Case     25   21
		45-54  Control  29  138
		55-64  Case     42   34
		55-64  Control  27  139
		65-74  Case	    19   36
		65-74  Control  18   88
		75+    Case	     5    8
		75+    Control   0   31
	;

	proc sort data=one;
		by age_stratum alcohol;
	run;

	proc transpose data=one out=oesophageal_cancer;
		by age_stratum alcohol;
		var count;
		id cancer;
	run;

	data oesophageal_cancer;
	set oesophageal_cancer;
		m = Case + Control;
	drop _name_;
	run;

	ods html;
	proc genmod data=oesophageal_cancer;
		class age_stratum alcohol;
		model case/m = age_stratum alcohol  / dist=binomial link=logit type3;
		estimate 'Ln(OR) High Vs Low' alcohol 1 -1 / exp;
	run;
	ods html close;

	


	proc freq data=one;
		tables age_stratum*alcohol*cancer / cmh;
		weight count;
	run;



	title '*** Saturated Model ***';
	proc genmod data=oesophageal_cancer;
		class age_stratum alcohol;
		model case/m = age_stratum alcohol age_stratum*alcohol/ dist=binomial 
		                                      link=logit type3;
	run;
