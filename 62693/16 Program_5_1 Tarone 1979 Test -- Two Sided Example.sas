




	/* 
		Tarone (1979) Two-sided GOF test
		H0:Binomial Distribution Versus
		H1:Generalized Binomial Distribution with Additive Interaction (Altham, 1978) 
		Altham's model was simultaneously proposed by Kupper and Haseman (1978) 
		and termed “Correlated Binomial Model”
		Data below were taken from Kupper and Haseman (1978, page 75) 

	*/

	data kupper_haseman;
		input t m;
		datalines;
		0 5
		2 5
		1 7
		0 8
		2 8
		3 8
		0 9
		4 9
		1 10
		6 10
		;

	ods select none;
	ods output Ratio=Ratio;
	proc surveymeans data=kupper_haseman;
		ratio t/m;
	run;
	ods select all;

	data Ratio;
		set Ratio;
		call symput('Pi',trim(left(Ratio)));
	run;

	data out1;
	set kupper_haseman;
		pi      = &Pi;
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

	proc means data=out1 sum noprint;
		var aux mm_1;
		output out=out2 sum=aux mm_1;
	run; 

	data out2;
	set out2;
		label X2   = "GOF Test";
		label PVal = "P-Value";
		format X2 8.2 Pval pvalue6.;
		x2  = aux / sqrt( 2*mm_1 );
		x2  = x2 * x2;
		pval = 1 - probchi(x2,1,0);
	run;

	ods html;
	title "Tarone (1979) GOF Test";
	proc print data=out2 noobs label;
		var x2 pval;
	run;
	ods html close;


