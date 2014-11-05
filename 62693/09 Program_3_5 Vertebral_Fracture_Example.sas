


	/*
		Vertebral fracture example from Morel and Neerchal (2010)

		treat = treatment
		    y = number of incident vertebral fractures (new and worsening)
		    z = person years of observation

	*/

	data fractures;
	input treat $ n @@;
		do subjid=1 to n;
		input y z @@;
		logz = log(z);
		output;
		end;
	drop n;
	datalines;
	Active 	28  1 2.9897 2 2.9843 0 2.9897 1 2.9843 2 2.9459 0 3.0445 1 3.0582
		0 2.9897 1 1.2567 0 2.9678 3 2.9596 1 2.9843 0 2.9925 1 1.4346
		1 3.0116 0 2.9733 2 3.0637 1 2.9706 0 1.1882 0 2.9733 1 1.2676
		2 2.9541 0 2.3874 0 1.2868 0 1.2813 2 2.7625 2 2.4504 4 2.8747
	Placebo	25	0 1.3771 11 3.0418 0 2.4312 3 3.1650 1 3.0034 2 2.9843 0 2.9651
		2 1.3087 5 3.0363 8 3.0691 2 2.9706 2 3.2553 4 2.9624 0 3.2060
		1 2.9596 7 3.0144 0 2.9569 2 2.9843 0 1.1937 3 3.0062 1 2.9870
		4 3.0089 1 1.2621 1 2.9788 5 2.8556
	;

	ods html;
	proc genmod data=fractures;
		class treat;
		model y = treat / dist=poisson link=log offset=logz pscale;
		estimate 'Placebo   ' int 1 treat 0  1; 
		estimate 'Active    ' int 1 treat 1  0;
		estimate 'Rate Ratio'       treat 1 -1;
		title '*** Vertebral Fracture Data, Poisson Quasi-likelihood Model ***';
	run;
	ods html close;


