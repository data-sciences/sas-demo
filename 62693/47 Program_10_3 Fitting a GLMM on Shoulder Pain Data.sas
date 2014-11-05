

   	/* 
		Reference: Lumley, T. (1996) "Generalized Estimating Equations for Ordinal
		Data: A Note on Working Correlation Structures."  Biometrics 52, 354-363 
	*/

    data Shoulder_tip_pain;
	    input trt $ gender $ age t1-t6;
	    subject_id = _n_;
		array tt t1-t6;
       	do over tt;
          	y    = tt;
		  	time = _i_;
          	output;
       	end;
	    datalines;
	    y  f  64  1  1  1  1  1  1
	    y  m  41  3  2  1  1  1  1
	    y  f  77  3  2  2  2  1  1
	    y  f  54  1  1  1  1  1  1
	    y  f  66  1  1  1  1  1  1
	    y  m  56  1  2  1  1  1  1
	    y  m  81  1  3  2  1  1  1
	    y  f  24  2  2  1  1  1  1
	    y  f  56  1  1  1  1  1  1
	    y  f  29  3  1  1  1  1  1
	    y  m  65  1  1  1  1  1  1
	    y  f  68  2  1  1  1  1  2
	    y  m  77  1  2  2  2  2  2
	    y  m  35  3  1  1  1  3  3
	    y  m  66  2  1  1  1  1  1
	    y  f  70  1  1  1  1  1  1
	    y  m  79  1  1  1  1  1  1
	    y  f  65  2  1  1  1  1  1
	    y  f  61  4  4  2  4  2  2
	    y  f  67  4  4  4  2  1  1
	    y  f  32  1  1  1  2  1  1
	    y  f  33  1  1  1  2  1  2
	    n  f  20  5  2  3  5  5  4
	    n  f  50  1  5  3  4  5  3
	    n  f  40  4  4  4  4  1  1
	    n  m  54  4  4  4  4  4  3
	    n  m  34  2  3  4  3  3  2
	    n  f  34  3  4  3  3  3  2
	    n  m  56  3  3  4  4  4  3
	    n  f  82  1  1  1  1  1  1
	    n  m  56  1  1  1  1  1  1
	    n  m  52  1  5  5  5  4  3
	    n  f  65  1  3  2  2  1  1
	    n  f  53  2  2  3  4  2  2
	    n  f  40  2  2  1  3  3  2
	    n  f  58  1  1  1  1  1  1
	    n  m  63  1  1  1  1  1  1
	    n  f  41  5  5  5  4  3  3
	    n  m  72  3  3  3  3  1  1
	    n  f  60  5  4  4  4  2  2
	    n  m  61  1  3  3  3  2  1
    ;

	proc format;
		value $abc 'y' = 'Active'
		           'n' = 'Placebo';
		value $xyz 'f' = 'Female'
		           'm' = 'Male';
	run;





	ods html;
	proc glimmix data=Shoulder_tip_pain method=quad;
		class subject_id trt gender;
		model y  = trt gender age time / dist=mult link=clogit solution;
		random int / subject=subject_id;
		format trt $abc. gender $xyz. ;
		estimate  'Active Vs Placebo' trt 1 -1 / or;
		title '*** Fitting a Cumulative Logit GLMM to the Shoulder Tip Pain Data ***';
	run;

	proc glimmix data=Shoulder_tip_pain empirical=classical method=quad;
		class subject_id trt gender;
		model y  = trt gender age time / dist=mult link=clogit solution;
		random int / subject=subject_id;
		format trt $abc. gender $xyz. ;
		estimate  'Active Vs Placebo' trt 1 -1 / or;
		title1 '*** Fitting a Cumulative Logit GLMM to the Shoulder Tip Pain Data ***';
		title2 '*** with an Empirical Variance for Estimates of Fixed Effects     ***';
	run;

	proc glimmix data=Shoulder_tip_pain empirical=mbn method=quad;
		class subject_id trt gender;
		model y  = trt gender age time / dist=mult link=clogit solution;
		random int / subject=subject_id;
		format trt $abc. gender $xyz. ;
		estimate  'Active Vs Placebo' trt 1 -1 / or;
		title1 '*** Fitting a Cumulative Logit GLMM to the Shoulder Tip Pain Data ***';
		title2 '*** with an Empirical Variance for Estimates of Fixed Effects     ***';
		title3 '*** and the MBN small sample variance correction                  ***';
	run;
	ods html close;

