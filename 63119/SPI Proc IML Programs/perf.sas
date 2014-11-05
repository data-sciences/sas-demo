libname SPI (SASUSER);                  /* location of data sets */


proc iml;
   /* use the INV function to solve a linear system; not efficient */
   n = 1000;                            /* size of matrix              */
   x = rannor(j(n,n,1));                /* n x n matrix                */
   y = rannor(j(n,1,1));                /* n x 1 vector                */

   xInv = inv(x);                       /* compute inverse of x        */
   b = xInv*y;                          /* solve linear equation x*b=y */

   /* time portions of the program to identify where time is spent */
   n = 1000;                            /* size of matrix              */

   /* measure time spent generating matrices */
   t0 = time();                         /* begin timing RANNOR         */
   x = rannor(j(n,n,1));                /* n x n matrix                */
   y = rannor(j(n,1,1));                /* n x 1 vector                */
   t1 = time() - t0;                    /* end timing                  */
   print "Elapsed time RANNOR (n=1000):" t1;
   
   /* measure time spent solving linear system with the INV function   */
   t0 = time();                         /* begin timing INV            */
   xInv = inv(x);                       /* compute inverse of x        */
   b = xInv*y;                          /* solve linear equation x*b=y */
   t2 = time() - t0;                    /* end timing                  */
   print "Elapsed time INV (n=1000):" t2;


   /* measure time spent solving linear system with the SOLVE function */
   t0 = time();                      /* begin timing SOLVE             */
   b = solve(x,y);                   /* solve linear equation directly */
   t3 = time() - t0;                 /* end timing                     */
   print "Elapsed time SOLVE (n=1000):" t3;

   /* measure time spent solving linear system 1000 times */
   n = 50;                           /* size of matrix                 */
   x = rannor(j(n,n,1));             /* n x n matrix                   */
   y = rannor(j(n,1,1));             /* n x 1 vector                   */
   
   t0 = time();                      /* begin timing                   */
   do i = 1 to 1000;                 /* repeat computations many times */
      b = solve(x,y);                /* solve linear equation directly */
   end;
   t3 = time() - t0;                 /* end timing                     */
   print "Elapsed time 1000 SOLVE (n=50):" t3;
   print "Average time for SOLVE (n=50):" (t3/1000);

proc iml;
   /* Remove missing values from a vector. */
   /* Investigate the relative speeds of each algorithm. */
   /* Algorithm 1: use subscripts to remove missing values */
   start DeleteMissBySubscript(x);
      do i = 1 to 1000;            /* repeat computation 1000 times    */
         idx = loc(x^=.);          /* find elements NOT missing        */
         if ncol(idx)>0 then 
            y = x[idx];            /* extract them                     */
      end;   
      return ( y );
   finish;
   
   /* Algorithm 2: use the REMOVE function to remove missing values */
   start DeleteMissByRemove(x);
      do i = 1 to 1000;            /* repeat computation 1000 times    */
         idx = loc(x=.);           /* find elements that ARE missing   */
         if ncol(idx)>0 then 
            y = remove(x, idx);    /* remove them; assign what is left */
      end;
      return ( y );
   finish;


   /* compare time required by each algorithm (5% missing values) */
   n   = 1e4;                          /* length of data vector        */
   x = j(n,1,1);                       /* constant data vector         */
   pct = 0.05;                         /* percentage of missing values */
   
   NumMissing = ceil(n*pct);           /* number of missing values     */
   x[1:NumMissing] = .;                /* assign missing values        */
   
   print pct[r="PCT Missing:"];
   t0 = time();                        /* begin timing                 */
   y = DeleteMissBySubscript(x);       /* run the first algorithm      */
   t1 = time() - t0;                   /* end timing                   */
   print t1[r="Elapsed time SUBSCRIPT:"];
   
   t0 = time();                        /* begin timing                 */
   y = DeleteMissByRemove(x);          /* run the second algorithm     */
   t2 = time() - t0;                   /* end timing                   */
   print t2[r="Elapsed time REMOVE:"];


   /* compare time spent by each algorithm as a parameter is varied */
   n  = 1e4;                           /* length of data vector        */
   x0 = j(n,1,1);                      /* constant data vector         */

   /* define list of percentages */
   pctList = 0.01 || 0.05 || do(0.1, 0.9, 0.1) || 0.95;
   
   /* allocate 3 columns for results: "PctMissing" "Subscript" "Remove" */
   results = j(ncol(PctList), 3); 
   do k = 1 to ncol(pctList);
      pct = pctList[k];                /* percentage of missing values */
      NumMissing = ceil(n*pct);        /* number of missing values     */
      x = x0;                          /* copy original data           */
      x[1:NumMissing] = .;             /* assign missing values        */
   
      t0 = time();
      y = DeleteMissBySubscript(x);    /* run the first algorithm      */
      t1 = time() - t0;
      
      t0 = time();
      y = DeleteMissByRemove(x);       /* run the second algorithm     */
      t2 = time() - t0;

      results[k,] = pct || t1 || t2;
   end;


   /* time each algorithm multiple times as a parameter is varied */
   NReplicates = 5;                    /* run each trial several times */
   n   = 1e4;                          /* length of data vector        */
   x0 = j(n,1,1);                      /* constant data vector         */

   /* define list of percentages */
   pctList = 0.01 || 0.05 || do(0.1, 0.9, 0.1) || 0.95;
   
   NTrials = NReplicates * ncol(PctList);
   /* allocate 3 columns for results: "PctMissing" "Subscript" "Remove" */
   results = j(2*NTrials, 3);
   cnt = 1;                            /* index to store results       */
   do k = 1 to ncol(pctList);
      pct = pctList[k];                /* percentage of missing values */
      NumMissing = ceil(n*pct);        /* number of missing values     */
      x = x0;                          /* copy original data           */
      x[1:NumMissing] = .;             /* assign missing values        */

      do repl = 1 to NReplicates;      /* repeat multiple times        */
         t0= time();
         y = DeleteMissBySubscript(x); /* run the first algorithm      */
         t1 = time() - t0;
         results[cnt,] = pct || repl || t1;
         cnt = cnt+1;
               
         t0 = time();
         y = DeleteMissByRemove(x);    /* run the second algorithm     */
         t2 = time() - t0;
         results[cnt,] = pct || repl || t2;
         cnt = cnt+1;
      end;
   end;

   PctMissing = results[,1];
   Replicate = results[,2];
   Time = results[,3];
   Algorithm = {"Subscript", "Remove"};    /* odd rows are "Subscript"  */
   Algorithm = repeat(algorithm, NTrials); /* even rows are "Remove"    */

   create DeleteMissing var {"PctMissing" "Replicate" "Time" "Algorithm"};
   append;
   close DeleteMissing;
quit;


   proc sgplot data=DeleteMissing;
      pbspline x=PctMissing y=Time / group=Algorithm;
   run;

