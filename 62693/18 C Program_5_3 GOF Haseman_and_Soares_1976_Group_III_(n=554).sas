

	/* 
		GOF Test for DataSet III on Neerchal and Morel (1998)
	    Source: Haseman and Soares (1976)
		This program uses "GOF_BB" and "GOF_RCB" Macros
	*/

	data haseman_soares;
		input m t1-t10;
		array tt t1-t10;
		do over tt;
		t    = _i_ - 1;
		freq = tt;
		output;
		end;
		keep m t freq;
		datalines;
		1	7	.	.	.	.	.	.	.	.	.
		2	7	.	.	.	.	.	.	.	.	.
		3	6	.	.	.	.	.	.	.	.	.
		4	5	2	1	.	.	.	.	.	.	.
		5	8	2	1	.	1	1	.	.	.	.
		6	8	.	.	.	.	.	.	.	.	.
		7	4	4	2	1	.	.	.	.	.	.
		8	7	7	1	.	.	.	.	.	.	.
		9	8	9	7	1	1	.	.	.	.	.
		10	22	17	2	.	1	.	.	1	1	.
		11	30	18	9	1	2	.	1	.	1	.
		12	54	27	12	2	1	.	2	.	.	.
		13	46	30	8	4	1	1	.	1	.	.
		14	43	21	13	3	1	.	.	1	.	1
		15	22	22	5	2	1	.	.	.	.	.
		16	6	6	3	.	1	1	.	.	.	.
		18	3	.	2	1	.	.	.	.	.	.
	;

	data haseman_soares;
		set haseman_soares;
		if freq = . then delete;
		do i=1 to freq;
			output;
		end;
		drop i freq;
	run;

	ods html;
	ods graphics on;

	%GOF_BB (inds=haseman_soares,t=t,m=m,title2=DataSet III -- Haseman and Soares (1976));
	%GOF_RCB(inds=haseman_soares,t=t,m=m,title2=Dataset III -- Haseman and Soares (1976));


	*--- Construct QQ Plots;
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
		title1 "DataSet III -- Haseman and Soares (1976)";
		title2 "QQ-Plots of Residuals based on Observed and Expected Frequencies";
		label Resid="Residuals" NQuant="Normal Quantiles";
		reg x=Resid y=NQuant;
	run;

	ods graphics off;
	ods html close;





