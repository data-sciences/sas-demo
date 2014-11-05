libname SPI (SASUSER);                  /* location of data sets */
%let Have922OrGreater = 0;              /* set to 1 if you have SAS/IML 9.22, 9.3, ...*/

%macro LoadPre922Modules();
   %if ^&Have922OrGreater %then %do;
      %include SPImodules922;            /* read module definitions    */
   %end;
%mend;

proc iml;
   /* read variables from a SAS data set into vectors */
   varNames = {"Make" "Model" "Mpg_City" "Mpg_Hwy"};
   use SPI.Vehicles;          /* open data set for reading             */
   read all var varNames;     /* create four vectors: Make,...,Mpg_Hwy */
   close SPI.Vehicles;        /* close the data set                    */
   
   idx = 1:3;                 /* print only the first 3 observations   */
   print (Make[idx]) 
         (Model[idx]) 
         (Mpg_City[idx])[label="Mpg_City"]
         (Mpg_Hwy[idx])[label= "Mpg_Hwy"];

   /* read variables from a SAS data set into a matrix */
   varNames = {"Mpg_City" "Mpg_Hwy" "Engine_Cylinders"};
   use SPI.Vehicles;
   read all var varNames into m;   /* create matrix with three columns */
   close SPI.Vehicles;
   print (m[1:3,])[colname=VarNames];

   /* read all numeric variables from a SAS data set into a matrix */
   use SPI.Vehicles;
   read all var _NUM_ into y[colname=NumericNames]; 
   close SPI.Vehicles;
   print NumericNames;


   /* create SAS data set from vectors */
   call randseed(12345);          /* set seed for RANDGEN              */
   x = j(10, 1);                  /* allocate 10 x 1 vector            */
   e = x;                         /* allocate 10 x 1 vector            */
   call randgen(x, "Uniform");    /* fill x; values from uniform dist  */
   call randgen(e, "Normal");     /* fill e; values from normal dist   */
   y = 3*x + 2 + e;               /* linear response plus normal error */

   create MyData var {x y};       /* create Work.MyData for writing    */
   append;                        /* write data in x and y             */
   close MyData;                  /* close the data set                */


   /* create SAS data set from a matrix */
   call randseed(12345);            /* set seed for RANDGEN            */
   x = j(10, 3);                    /* allocate 10 x 3 matrix          */
   call randgen(x, "Normal");       /* fill x; values from normal dist */

   create MyData2 from x[colname={"Random1" "Random2" "Random3"}];
   append from x;
   close MyData2;


   /* apply log transform to data */
   use SPI.Movies;                        /* open data set for reading */
   read all var {"Budget"};               /* read data                 */
   close SPI.Movies;                      /* close data set            */

   logBudget = log(Budget);               /* apply log transform       */


   /* apply log10 transform to data with negative values */
   y = {10 0 -29 -20 273 70};
   c = 1 - min(y);                 /* (y + c) > 0 whenever c > -min(y) */
   log10Y = log10(y + c);          /* apply log10 transformation       */
   print log10Y;


proc iml;   /* compare data; the comparison operator returns zeros and ones */
   x = 1:5;
   t = (x > 2);               /* t = {0 0 1 1 1} */

   /* find indices that correspond to nonzero values */
   idx = loc(t);              /* idx = {3 4 5};  */
   print t, idx;

   /* find indices that satisfy a condition by using the LOC function */
   x = 1:5;
   idx = loc(x > 2);          /* idx = {3 4 5};  */

   /* find vehicles that get at least 33 mpg in the city */
   varNames = {"Make" "Model" "Mpg_City" "Engine_Cylinders"};
   use SPI.Vehicles;                /* read data */
   read all var varNames;
   close SPI.Vehicles;

   idx = loc(Mpg_City >= 33);
   print (Make[idx]) 
         (Model[idx]) 
         (Mpg_City[idx])[label="Mpg_City"];

   /* find vehicles that have six cylinders and get > 30 mpg in the city */
   idx = loc(Engine_Cylinders=6 & Mpg_City>30);
   numSatisfy = ncol(idx);
   print numSatisfy "vehicles satisfy the criteria.";
   print (Make[idx]) (Model[idx]) (Mpg_City[idx])[label="Mpg_City"];

   /* find vehicles with large residuals for a linear model */
   varNames = {"Make" "Model" "Mpg_City" "Mpg_Hwy" "Hybrid"};
   use SPI.Vehicles;                        /* read data               */
   read all var varNames;
   close SPI.Vehicles;

   Pred_Mpg_Hwy = 0.24 + 1.35*Mpg_City;     /* create predicted values */
   residual = Mpg_Hwy - Pred_Mpg_Hwy;       /* create residual values  */
   idx = loc(abs(residual) > 10);
   print (Make[idx]) 
         (Model[idx]) 
         (residual[idx])[label="Residual"] 
         (Hybrid[idx])[label="Hybrid?"];

   /* handle the situation when no observations satisfy a criterion */
   Pred_Mpg_City = 0.24 + 1.35*Mpg_Hwy;
   residual = Mpg_City - Pred_Mpg_City;
   idx = loc(abs(residual) > 10);
   if ncol(idx) > 0 then 
      print (Make[idx]) (Model[idx]) (residual[idx])[label="Residual"] 
            (Hybrid[idx])[label="Hybrid?"];
   else 
      print "No observations satisfy the criterion.";

   /* assign predicted values based on whether vehicle is hybrid-electric */
   varNames = {"Mpg_City" "Mpg_Hwy" "Hybrid"};
   use SPI.Vehicles;               /* read data */
   read all var varNames;
   close SPI.Vehicles;

   /* first approach: use the LOC function */
   Pred = j(nrow(Hybrid),1);  /* allocate vector for predicted values  */
   idx = loc(Hybrid=1);       /* indices that satisfy a criterion      */
   if ncol(idx)>0 then        /* assign an expression to those indices */
      Pred[idx] = 6.91 + 0.7*MPG_City[idx];
   idx = loc(Hybrid^=1);      /* the other indices                     */
   if ncol(idx)>0 then        /* assign a different expression         */
      Pred[idx] = 0.09 + 1.36*MPG_City[idx];

   /* second approach: use the CHOOSE function */
   Pred = choose(Hybrid=1,            /* if the i_th vehicle is hybrid */
                 6.91+0.7*MPG_City,   /* assign this value,            */
                 0.09+1.36*MPG_City); /* otherwise, assign this value  */


proc iml;
   /* incorrect computation for data that contain missing values */
   use SPI.Movies;                  /* read data */
   read all var {"World_Gross"};
   close SPI.Movies;  

   /* mean is wrong because of missing values */
   wrong_mean = sum(World_Gross) / nrow(World_Gross);
   print wrong_mean;

   /* use functions that account for missing values */
   mean1 = World_Gross[:];
*   mean2 = mean(World_Gross);                          /* SAS/IML 9.22 */ 
*   mean3 = sum(World_Gross)/countn(World_Gross);       /* SAS/IML 9.22 */
*   print mean1 mean2 mean3; 


   /* exclude observations with missing values */
   nonMissing = loc(World_Gross ^= .);       /* find nonmissing obs    */
   if ncol(nonMissing)=0 then mean = .;
   else do;                                  /* extract nonmissing obs */
      World_Gross = World_Gross[nonMissing,]; 
      mean4 = sum(World_Gross) / nrow(World_Gross);
   end;
   print mean4;

   /* count the number of observations in each category */
   use SPI.Movies;
   read all var {"MPAARating"};              /* 1 */
   close SPI.Movies;  

   categories = unique(MPAARating);          /* 2 */
   count = j(ncol(categories), 1, 0);        /* 3 */
   do i = 1 to ncol(categories);
      idx = loc(MPAARating = categories[i]); /* 4 */
      count[i] = ncol(idx);                  /* 5 */
   end;
   print count[rowname=categories];

   /* count the number of observations in each pair of categories */
   use SPI.Movies;                          /* read data */
   read all var {"Year" "MPAARating"};   
   close SPI.Movies;  
   
   /* create two-way frequency table */
   uYear = unique(Year);
   uMPAARating = unique(MPAARating);
   Table = j(ncol(uYear), ncol(uMPAARating), 0);    /* 1 */
   do j = 1 to ncol(uMPAARating);                   /* 2 */
      jdx = loc(MPAARating = uMPAARating[j]);       /* 3 */
      t = Year[jdx];                                /* 4 */
      do i = 1 to ncol(uYear);
         idx =  loc(t=uYear[i]);                    /* 5 */
         Table[i,j] = ncol(idx);
      end;
   end;
   YearLabel = char(uYear,4);                       /* 6 */
   print Table[rowname=YearLabel colname=uMPAARating];

quit;
   /* sort the data by MPAARating */
   proc sort data=SPI.Movies out=movies;
      by MPAARating;
   run;
   
   /* compute quartiles for each BY group */
   proc means data=movies noprint;
      by MPAARating;
      var US_Gross;
      output out=OutStat Q1=Gross_Q1 median=Gross_Q2 Q3=Gross_Q3;
   run;

   proc print data=OutStat noobs;
      var MPAARating Gross_Q1 Gross_Q2 Gross_Q3;
   run;

proc iml;
   /* module to compute Pearson correlation between two column vectors */
   start CorrCoef(x, y);                  /* assume no missing values: */
      xStd = standard(x);                 /* standardize data          */
      yStd = standard(y);     
      df = nrow(x) - 1;                   /* degrees of freedom        */
      return ( xStd` * yStd / df );
   finish;

   u = {1,2,3,4,5};
   v = {2,3,1,4,4};
   r = CorrCoef(u,v);
   print r;

   /* use the GLOBAL clause in a module definition */
   start HasValue(x) global(g_Value);
      idx = loc(x=g_Value);              /* find value, if it exists   */
      return ( ncol(idx)>0 );            /* return 1 if value exists   */
   finish;
   
   g_Value = 1;                          /* global value to search for */
   v = {4,2,1,3,8};                      /* data to search             */
   z = HasValue(v);           

   /* matrices are passed by reference to modules */
   start ReverseRows(x);               /* define subroutine module     */
      r = x[nrow(x):1, ];              /* reverse rows of argument     */
      x = r;                           /* reassign the argument matrix */
   finish;
   
   u = {1,2,3,4,5};                    /* original values              */
   run ReverseRows(u);                 /* values of u are changed      */
   print u;

   /* pass temporary matrices to a function or subroutine */
   w = {1 2, 2 3, 3 1, 4 4, 5 4};
   r = CorrCoef(w[,1], w[,2]);

   /* be careful when you pass a temporary matrix to a subroutine */
   w = {1 2, 2 3, 3 1, 4 4, 5 4};
   run ReverseRows(w[,1]);         /* w[,1] creates a temporary matrix */
   print w;                        /* w is unchanged                   */

   /* create a module to return the nonmissing rows of a matrix */
   start LocNonMissingRows(x);
      c = cmiss(x);                /* matrix of 0 and 1's              */
      r = c[,+];                   /* number of missing in row         */
      nonMissingIdx = loc(r=0);    /* rows that do not contain missing */
      return ( nonMissingIdx );
   finish;
   
   z = {1 2, 3 ., 5 6, 7 8, . 10, 11 12};
   nonMissing = LocNonMissingRows(z);
   if ncol(nonMissing)>0 then
      z = z[nonMissing, ];
   print z;


   /* SAS/IML 9.22: a module to return the nonmissing rows of a matrix */
*   start LocNonMissingRows(x);
*      r = countmiss(x, "row");     /* number of missing in row         */
*      nonMissingIdx = loc(r=0);    /* rows that do not contain missing */
*      return ( nonMissingIdx );
*   finish;

  /* inefficient algorithm which loops over observations */
   use SPI.Movies;
   read all var {"MPAARating"};                      /* 1 */
   close SPI.Movies;  

   /* inefficient: do not imitate */
   categories = MPAARating[1];                       /* 2 */
   count = 1;
   do obs = 2 to nrow(MPAARating);                   /* 3 */
      i = loc(categories = MPAARating[obs]);         /* 4 */
      if ncol(i) = 0 then do;                        /* 5 */
         categories = categories // MPAARating[obs];
         count = count // 1;
      end;
      else count[i] = count[i] + 1;                  /* 6 */
   end;
   print count[rowname=categories];

   /* compute sum and mean of each column */
   x = {1 2 3, 
        4 5 6, 
        7 8 9, 
        4 3 .};
   colSums  = x[+, ];
   colMeans = x[:, ];
   rowSums  = x[ ,+];
   rowMeans = x[ ,:];
   print colSums, colMeans, rowSums rowMeans;   

   /* compute column sums, row sums, and grand sum for a matrix */
   uYear = 2005:2007;
   uMPAARating = {"G"    "NR"    "PG"    "PG-13"   "R"};
   Table = {       6       0      26       63       42,
                   5       3      23       57       48,
                   2       0      17       29       38};
   colSums = Table[+, ];
   rowSums = Table[ ,+];
   Total = Table[+];   
   YearLabel = char(uYear, 7);
   print Table[rowname=YearLabel colname=uMPAARating] rowSums, 
         colSums[rowname="colSums" label=""] Total[label=""];

   /* standardize data: assume no missing values and no constant column */
   x = {7 7, 8 9, 7 9, 5 7, 8 8};
   xc = x - x[:,];              /* 1. center the data                  */
   ss = xc[##,];                /* 2. sum of squares for columns of xc */
   n = nrow(x);                 /* 3. assume no missing values         */
   std = sqrt(ss/(n-1));        /* 4. sample standard deviation        */
   std_x = xc / std;            /* 5. divide each column (standardize) */
   print std_x; 

   %include SPImodules;                  /* read module definitions    */
   %LoadPre922Modules();
   /* standardize data: SAS/IML 9.22 and beyond */
   xc = x - mean(x);               /* center the data                  */
   std = sqrt(var(xc));            /* sample standard deviation        */
   std_x = xc / std;               /* divide each column (standardize) */
   print std_x; 

/************/
proc iml;
   /*  define module that implements the golden section search */
   start GoldenSection(a0,b0,eps);
   /* Find the value that minimizes the continuous unimodal function 
    * f (defined by the module "Func") on the interval [a,b] by using 
    * a golden section search. The algorithm stops when b-a < eps.
    *
    * Example: 
    * start Func(x);
    *    return  ( x#(x-0.5) );
    * finish;
    * x0 = GoldenSection(0,1,1e-4);
    */

   w = (sqrt(5)-1)/2;                     /* "golden ratio" - 1        */
   a = a0; b = b0;
   x1 = w*a + (1-w)*b;
   x2 = (1-w)*a + w*b;
   fx1 = Func(x1);
   fx2 = Func(x2);
   do while (b-a>eps);
      if fx1 < fx2 then do;               /* choose new right endpoint */
         b = x2;                          /* update x1 and x2          */
         x2 = x1;
         fx2 = fx1;
         x1 = w*a + (1-w)*b;
         fx1 = Func(x1);
      end;
      else do;                            /* choose new left endpoint  */
         a = x1;                          /* update x1 and x2          */
         x1 = x2;
         fx1 = fx2;
         x2 = (1-w)*a + w*b;
         fx2 = Func(x2);
      end;
   end;
   return ( choose(fx1<=fx2, a, b) ); 
   finish;


   /* Minimize unimodal function by using GoldenSection module */
   /* define unimodal function on [0,1]. Minimum at x=0.25.    */
   start Func(x);
      return  ( x#(x-0.5) );
   finish;
   
   /* search for minimum on an interval */
   x0 = GoldenSection(0, 1, 1e-4);
   y = Func(x0);
   QuadSoln = x0 || y;
   print  QuadSoln[colname={"XMin", "f(XMin)"}];


   /* evaluate function on a grid, followed by golden section search */
   /* This function has three local minima on [0,1]. Global min at x=0.25. */
   start Func(x);
      pi = constant('PI');                               /* 3.14159... */
      return ( x#(x-0.5) + 0.1 *sin(6*pi*x) );
   finish;
   
   /* use "presearch" evaluation on coarse grid on [0,1] */
   x = do(0, 1, 0.1);               
   y = Func(x);                     /* 1. evaluate at grid on [0,1]    */
   yMinIdx = y[>:<];                /* 2. find index of minimum value  */
   aIdx = max(yMinIdx-1, 1);        /* 3. find index of left endpoint  */
   bIdx = min(yMinIdx+1, ncol(x));  /*    find index of right endpoint */
   a = x[aIdx];                     /* assume global min in interval   */
   b = x[bidx];
   print a b;

   x0 = GoldenSection(a, b, 1e-4);  /* 4. finds minimum on [a,b]       */
   y = Func(x0);
   Soln = x0 || y;
   print Soln[colname={"XMin", "f(XMin)"}];

quit;


