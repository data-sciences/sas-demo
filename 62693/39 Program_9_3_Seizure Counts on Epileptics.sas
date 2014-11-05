

	/*
		Analysis Thall and Vail (1990) Example
		using a Marginal GEE Model with R-side
		random effects.
		Program can be found in the GLIMMIX documentation.
	*/

   data seizures;
      array c{5};
      input id trt c1-c5;
      do i=1 to 5;
         x1    = (i > 1);
         ltime = (i=1)*log(8) + (i ne 1)*log(2);
         cnt   = c{i};
         output;
      end;
      keep id cnt x1 trt ltime;
      datalines;
   101 1  76 11 14  9  8
   102 1  38  8  7  9  4
   103 1  19  0  4  3  0
   104 0  11  5  3  3  3
   106 0  11  3  5  3  3
   107 0   6  2  4  0  5
   108 1  10  3  6  1  3
   110 1  19  2  6  7  4
   111 1  24  4  3  1  3
   112 1  31 22 17 19 16
   113 1  14  5  4  7  4
   114 0   8  4  4  1  4
   116 0  66  7 18  9 21
   117 1  11  2  4  0  4
   118 0  27  5  2  8  7
   121 1  67  3  7  7  7
   122 1  41  4 18  2  5
   123 0  12  6  4  0  2
   124 1   7  2  1  1  0
   126 0  52 40 20 23 12
   128 1  22  0  2  4  0
   129 1  13  5  4  0  3
   130 0  23  5  6  6  5
   135 0  10 14 13  6  0
   137 1  46 11 14 25 15
   139 1  36 10  5  3  8
   141 0  52 26 12  6 22
   143 1  38 19  7  6  7
   145 0  33 12  6  8  4
   147 1   7  1  1  2  3
   201 0  18  4  4  6  2
   202 0  42  7  9 12 14
   203 1  36  6 10  8  8
   204 1  11  2  1  0  0
   205 0  87 16 24 10  9
   206 0  50 11  0  0  5
   208 1  22  4  3  2  4
   209 1  41  8  6  5  7
   210 0  18  0  0  3  3
   211 1  32  1  3  1  5
   213 0 111 37 29 28 29
   214 1  56 18 11 28 13
   215 0  18  3  5  2  5
   217 0  20  3  0  6  7
   218 1  24  6  3  4  0
   219 0  12  3  4  3  4
   220 0   9  3  4  3  4
   221 1  16  3  5  4  3
   222 0  17  2  3  3  5
   225 1  22  1 23 19  8
   226 0  28  8 12  2  8
   227 0  55 18 24 76 25
   228 1  25  2  3  0  1
   230 0   9  2  1  2  1
   232 1  13  0  0  0  0
   234 0  10  3  1  4  2
   236 1  12  1  4  3  2
   238 0  47 13 15 13 12
   ;

	ods html;
	title "*** Poisson Generalized Linear Model ***"; 
   	proc glimmix data=seizures;
    	model cnt = x1 trt x1*trt / dist=poisson offset=ltime
                                  ddfm=none s;
   	run;

 	title "*** Marginal GEE Poisson Model with Compound Symmetry ***"; 
  	proc glimmix data=seizures empirical;
	   class id;
	   model cnt = x1 trt x1*trt / dist=poisson offset=ltime
                                  ddfm=none s;
	   random _residual_ / subject=id type=cs vcorr;
   	run;
	ods html close;






	
	ods html;
 	title "*** Rates Progabide Trial ***"; 
  	proc glimmix data=seizures empirical;
	   class id;
	   model cnt = x1 trt x1*trt / dist=poisson offset=ltime
                                  ddfm=none s;
	   random _residual_ / subject=id type=vc vcorr;
	   estimate 'Rate Placebo Baseline' int 1 / ilink;
	   estimate 'Rate Placebo TRT Phase' int 1 x1 1 / ilink;
	   estimate 'Rate Progabide Baseline' int 1 trt 1 / ilink;
	   estimate 'Rate Progabide TRT Phase' int 1 x1 1 trt 1 x1*trt 1 / ilink;
	   estimate 'Placebo Baseline / Progabide Baseline' trt -1 / ilink;
	   estimate 'Placebo TRT Phase / Progabide TRT Phase' trt -1 x1*trt -1 / ilink;
	   estimate '(R1) Placebo TRT Phase / Placebo Baseline' x1 1 / ilink;
	   estimate '(R2) Progabide TRT Phase / Progabide Baseline' x1 1 x1*trt 1 / ilink;
	   estimate '(R3) = (R1) / (R2)' x1*trt -1 / ilink;
   	run;
	ods html close;




 
