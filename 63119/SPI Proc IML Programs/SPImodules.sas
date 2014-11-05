   /* %include this file to define some modules
    *  that are used in simulation and sampling.
    *  For example:
    *     proc iml;
    *     %include(SPImodules);
    */

   /* Module to simulate the flip of a fair coin.
    * Call the RANDSEED function before calling this module. 
    * The module returns a vector of ones (heads) and zeros (tails).
    */
   start TossCoin(N);
      c = j(N,1);                        /* allocate Nx1 vector        */
      call randgen(c, "uniform");        /* fill with values in (0,1)  */
      c = floor(2*c);                    /* convert to integers 0 or 1 */
      return ( c );
   finish;
   
   /* Module to roll two six-sided dice N times.
    * Call the RANDSEED function before calling this module. 
    * The return value is the sum of the values of the roll. 
    * This module calls the Table distribution with equal probability.
    */
   start RollDice(N);
       d = j(N,2);                     /* allocate Nx2 vector          */
       prob = j(6,1,1)/6;              /* equal prob. for six outcomes */
       call randgen(d, "Table", prob); /* fill with  integers in 1-6   */
       return ( d[,+] );               /* values of the N rolls        */
   finish;

   /* Random sampling with replacement. The arguments are:
    * A           events (sample space)
    * numSamples  number of times to sample from A. 
    *             numSamples[1] specifies the number of rows returned.
    *             If numSamples is a vector, then numSamples[2]
    *             specifies the number of repeated draws from A
    *             contained in each sample.
    * prob        specifies the probabilities associated with each
    *             element of A. If prob=. (missing), then equal
    *             probabilities are used.
    * The module returns a matrix that contains elements of A. The matrix
    * has numSamples[1] rows. It has either 1 or numSamples[2] columns.
    */      
   start SampleWithReplace(A, numSamples, prob);
      x = rowvec(A);                                        /* 1 */
      k = ncol(x);

      if prob = . then 
         p = j(1, k, 1) / k;                                /* 2 */
      else do;              
         p = rowvec(prob);
         if ncol(p) ^= k then do;                           /* 3 */
            msg = "ERROR: The probability vector must have the same
                   number of elements as the set being sampled.";
            /* Runtime.Error(msg); */         /* use in SAS/IML Studio */
            reset log; print msg; reset nolog;/* use in PROC IML       */
            stop;
         end;
      end;

      /* overload the numSamples argument: 
         if a vector, then sumSamples[2] is a repetition factor */
      if nrow(numSamples)*ncol(numSamples)=1 then do;
         nSamples = numSamples;                             /* 4 */
         nRep = 1;
      end;
      else do;
         nSamples = numSamples[1];
         nRep = numSamples[2];
      end;
            
      results = j(nSamples, nRep);                          /* 5 */
      call randgen(results, "Table", p);
      
      return (shape(A[results], nSamples));                 /* 6 */
   finish;
