

	/* 
		Ossification Example from Morel and Neerchal (1997), 
		Statistics in Medicine, 16, 2843-2853
	*/

	data ossification;
	  	length tx $8;
	   	input tx$ n @@;
	   	PHT  = 1;
	   	TCPO = 1;
	   	do i=1 to n;
	   	  	Litters + 1;
	      	input t m @@;
				if tx = 'PHT' then PHT = 0;
			  	if tx = 'TCPO' then TCPO = 0;
			  	if tx = 'PHT+TCPO' then do;
					PHT  = 0;
					TCPO = 0;
			  	end;
	      output;
	   end;
	   drop n i;
	   datalines;
	Control  18 8 8 9  9  7  9 0  5 3  3 5 8 9 10 5 8 5 8 1 6 0 5
	            8 8 9 10  5  5 4  7 9 10 6 6 3  5 
	Control  17 8 9 7 10 10 10 1  6 6  6 1 9 8  9 6 7 5 5 7 9
	            2 5 5  6  2  8 1  8 0  2 7 8 5  7
	PHT      19 1 9 4  9  3  7 4  7 0  7 0 4 1  8 1 7 2 7 2 8 1 7
	            0 2 3 10  3  7 2  7 0  8 0 8 1 10 1 1
	TCPO     16 0 5 7 10  4  4 8 11 6 10 6 9 3  4 2 8 0 6 0 9
	            3 6 2  9  7  9 1 10 8  8 6 9
	PHT+TCPO 11 2 2 0  7  1  8 7  8 0 10 0 4 0  6 0 7 6 6 1 6 1 7
	;

	ods html;
	title "*** Ossification Data -- GEE using GENMOD with Independent Working Correlation Matrix***";
	proc genmod data=ossification;
		class litters tcpo pht / param=ref;
	   	model t/m = tcpo pht tcpo*pht / dist=binomial link=logit;
	   	repeated subject=litters / type=ind;
   	run;
	ods html close;





   	data ossification_b;
   	set ossification;
		do i=1 to t;
			y = 1;
			output;
		end;
		do i=1 to m-t;
			y = 0;
			output;
		end;
	run;

	ods html;
 	title "*** Ossification Data -- GEE using GENMOD with Exchangeable Working Correlation Matrix***";
  	proc genmod data=ossification_b descending;
		class litters tcpo pht / param=ref;
		model y = tcpo pht tcpo*pht / dist=binomial link=logit;
	   	repeated subject=litters / type=exch;
   	run;
	ods html close;



