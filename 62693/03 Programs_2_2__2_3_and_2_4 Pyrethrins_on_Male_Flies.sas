


	/* 
		Dosage-Mortality of Pyrethrins on Male Flies, Murray (1938)
	*/

	data pyrethrins;
		input dose m t;
		label dose = "Concentration Pyrethrins mg/100 cc"
		         m = "Number of Male Flies"
		         t = "Number of Male Flies Killed"
		         x = "Log of Dose";
		x = log(dose);
		datalines;
		40	 462  109
		60	 500  199
		80	 467  298
		100	 515  370
		120	 561  459
		140	 469  400
		160	 550  495
		180	 542  499
		200	 479  450
		250	 497  476
		300	 453  442
		;

	ods html;
	ods graphics on;
	title1 "Dosage-Mortality of Pyrethrins on Male Flies, Murray (1938)";
	title2 "GLM with Binomial Distribution and Logit Link";
	proc glimmix data=pyrethrins plots=residualpanel;
		model t/m = x / dist=binomial link=logit solution;
	run;
	ods graphics off;
	ods html close;

	ods html;
	ods graphics on;
	title1 "Dosage-Mortality of Pyrethrins on Male Flies, Murray (1938)";
	title2 "GLM with Binomial Distribution and Probit Link";
	proc glimmix data=pyrethrins plots=residualpanel;
		model t/m = x / dist=binomial link=probit solution;
	run;
	ods graphics off;
	ods html close;





	
	ods html;
	title1 "Dosage-Mortality of Pyrethrins on Male Flies, Murray (1938)";
	title2 "GLM with Binomial Distribution and Logit Link using PROC PROBIT";
	proc probit data=pyrethrins log;
		model t/m = dose / d=logistic inversecl;
	run;

	title1 "Dosage-Mortality of Pyrethrins on Male Flies, Murray (1938)";
	title2 "GLM with Binomial Distribution and Probit Link using PROC PROBIT";
	proc probit data=pyrethrins log;
		model t/m = dose / inversecl;
	run;
	ods html close;







 	*--- Plotting 
		1)Estimated Logistic Curve and Observed Proportions
		2)Estimated Probit Curve and Observed Proportions;
	data temp;
		do dose=38 to 301 by 0.1; *--- Dose range in increments of 0.1;
			x = log(dose);
			output;
		end;
	drop dose;
	run;

	data new;
		set pyrethrins temp;
	run; 

	proc glimmix data=new; 
		model t/m = x / link=probit;
		output out=pred_out1 pred(ilink)=pi_hat;
	run;

	proc glimmix data=new;
		model t/m = x;
		output out=pred_out2 pred(ilink)=pi_hat;
	run;

	data pred_out1;
		set pred_out1;
		label pi_hat = 'Predicted Probability'
		      obs_pi = 'Observed Probability';
		obs_pi = .;
		if t >= 0 then do;
			obs_pi = t/m;
			pi_hat = .;
		end;
	drop t m;
	run;

	data pred_out2;
		set pred_out2;
		label pi_hat = 'Predicted Probability'
		     obs_pi  = 'Observed Probability';
		obs_pi = .;
		if t >= 0 then do;
			obs_pi = t/m;
			pi_hat = .;
		end;
	drop t m;
	run;

	ods html;
	ods graphics on;
	proc sgplot data=pred_out1;
		title1 "Estimated Probit Curve"; 
		title2 "Dosage-Mortality of Pyrethrins on Male Flies, Murray (1938)"; 
		scatter x=x y=obs_pi;
		series  x=x y=pi_hat / y2axis;
	run; 
	proc sgplot data=pred_out2;
		title1 "Estimated Logistic Curve"; 
		title2 "Dosage-Mortality of Pyrethrins on Male Flies, Murray (1938)"; 
		scatter x=x y=obs_pi;
		series  x=x y=pi_hat / y2axis;
	run; 
	ods graphics off;
	ods html close;








	*--- Plots can be also obtained using PROC LOGISTIC;

	
	ods html;
	ods graphics on;
	title1 "Dosage-Mortality of Pyrethrins on Male Flies, Murray (1938)";
	title2 "GLM with Binomial Distribution and Logit Link";
	proc logistic data=pyrethrins;
		model t/m = x / scale=none;
		effectplot fit / YRANGE=(0.2, 1.0);
	run;
	title2 "GLM with Binomial Distribution and Probit Link";
	proc logistic data=pyrethrins;
		model t/m = x / scale=none link=probit;
		effectplot fit / YRANGE=(0.2, 1.0);
	run;
	ods graphics off;
	ods html close;
 
