


	/*
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

	ods html;
	proc glimmix data=toxoplasmosis;
		model t/m = z z*z z*z*z / s; *--- z|z|z will also work;
		random _residual_ ;
	run;
	ods html close;





	data toxoplasmosis;
		set toxoplasmosis;
		city = _n_;
	run;

	ods html;
	proc glimmix data=toxoplasmosis;
		class city;
		model t/m = z z*z z*z*z / s;
		random _residual_ / subject=city;
	run;
	ods html close;






	*--- Replicating Generalized Analysis of Variance in Efron (1978);

	data temp;
		set toxoplasmosis;
		do i=1 to t;
			y=1;
			output;
		end;
		do i=1 to m-t;
			y=0;
			output;
		end;
	run;

	proc genmod data=temp;
		model y = z z*z z*z*z / link=logit dist=bin type1;
	run;










