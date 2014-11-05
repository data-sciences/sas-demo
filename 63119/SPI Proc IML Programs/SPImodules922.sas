   /* %include this file when necessary in order to define modules
    *  that mimic some of the new functions in SAS/IML 9.22.
    *  For example:
    *     proc iml;
    *     %include(SPImodules922);
    */

   /* Mean: return sample mean of each column of a data matrix */
   /* For this module
    *    x     is a matrix that contains the data
    */
   start Mean(x);
      mean = x[:,];
      return ( mean );
   finish;

   /* Var: return sample variance of each column of a data matrix */
   /* For this module
    *    x     is a matrix that contains the data
    */
   start Var(x);
      mean = x[:,];
      countn = j(1,ncol(x));             /* allocate vector for counts */
      do i = 1 to ncol(x);               /* count nonmissing values    */
         countn[i] = sum(x[,i]^=.);      /* in each column             */
      end;
      var = (x-mean)[##,] / (countn-1);
      return ( var );
   finish;


   /* Qntl: compute quantiles (Defn. 5 from the UNIVARIATE doc) */
   /* For this module
    *    q     upon return, q contains the specified quantiles of
    *          the data.
    *    x     is a column vector that contains the univariate data
    *    p     specifies the quantiles. For example, 0.5 specifies the 
    *          median whereas {0.25 0.75} specifies the first and 
    *          third quartiles. 
    * This module does not handle missing values in the data.
    */
   start Qntl(q, x, p);            /* definition 5 from UNIVARIATE doc */
      n = nrow(x);                 /* assume nonmissing data           */
      q = j(ncol(p),ncol(x));
      do j = 1 to ncol(x);
         y = x[,j];
         call sort(y,1);
         do i = 1 to ncol(p);
            k  = n*p[i];           /* position in ordered data         */
            k1 = int(k);           /* indices into ordered data        */
            k2 = k1 + 1;
            g =  k - k1;
            if g>0 then 
               q[i,j] = y[k2];     /* return a data value              */
            else                   /* average adjacent data            */
               q[i,j] = (y[k1]+y[k2])/2;
         end;
      end;
   finish;


