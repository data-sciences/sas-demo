






	/* 
		Score Test Statistic, Dean (1992)
		H0:Binomial Distribution Versus
		H1:Beta-binomial or similar distribution such as 
	       Random-clumped Binomial
		   as far as Bernoulli outcomes are positively correlated 

		Toxoplasmosis in 34 cities of El Salvador
		Example from Efron (1978, 1986)
	*/

	data toxoplasmosis;
		input t m rain;
		z = rain;
		datalines;
		2	4	1735
		3	10	1936
		1	5	2000
		3	10	1973
		2	2	1750
		3	5	1800
		2	8	1750
		7	19	2077
		3	6	1920
		8	10	1800
		7	24	2050
		0	1	1830
		15	30	1650
		4	22	2200
		0	1	2000
		6	11	1770
		0	1	1920
		33	54	1770
		4	9	2240
		5	18	1620
		2	12	1756
		0	1	1650
		8	11	2250
		41	77	1796
		24	51	1890
		7	16	1871
		46	82	2063
		9	13	2100
		23	43	1918
		53	75	1834
		8	13	1780
		3	10	1900
		1	6	1976
		23	37	2292
		;

	proc stdize data=toxoplasmosis out=toxoplasmosis;
		var z;
	run;

	ods select none;
	proc glimmix data=toxoplasmosis;
		model t/m = z z*z z*z*z / link=logit dist=bin s;
		output out=pdata pred(noblup ilink) = pi;
	run;
	ods select all;

	data pdata;
	set pdata;
		pic     = 1 - pi;
		pipic   = pi * pic;
		mpi     = m * pi;
		t_mpi   = t - mpi;
		pit_mpi = pi * t_mpi;
		tpic    = t * pic;
		mm_1    = m * (m-1);
		aux     = ( t_mpi*t_mpi + pit_mpi - tpic ) / pipic;
	keep aux mm_1; 
	run;

	proc means data=pdata sum noprint;
		var aux mm_1;
		output out=new sum=aux mm_1;
	run; 

	data new;
	set new;
		label Z    = "GOF Test";
		label PVal = "P-Value";
		format Z 8.2 Pval pvalue6.;
		z    = aux / sqrt( 2*mm_1 );
		pval = 1 - probnorm( z );
	run;

	ods html;
	title "Score Test Statistic, Dean (1992)";
	proc print data=new noobs label;
		var z pval;
	run;
	ods html close;

