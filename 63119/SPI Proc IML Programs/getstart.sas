libname SPI (SASUSER);                  /* location of data sets */

proc iml;
   /* create matrices of various types and sizes */
   x = 1;                        /* scalar                             */
   x = {1 2 3};                  /* reassign to row vector             */
   y = {1 2 3, 4 5 6};           /* 2 x 3 numeric matrix               */
   y = {"male" "female"};        /* reassign to 1 x 2 character matrix */
   print x, y;

   /* print marital status of 24 people */
   ageGroup = {"<= 45", " > 45"};              /* headings for rows    */
   status = {"Single" "Married" "Divorced"};   /* headings for columns */
   counts = {   5         5         0,         /* data to print        */
                2         9         3     };
   print counts[colname=status 
                rowname=ageGroup
                label="Marital Status by Age Group"];
                
   pct = counts / 24;                          /* compute proportions  */
   print pct[format=PERCENT7.1];               /* print as percentages */

   /* dimensions of a matrix */
   n_x = nrow(x);
   p_x = ncol(x);
   print n_x p_x;

   /* dimensions of an empty matrix */
   n_u = nrow(empty_matrix);
   p_u = ncol(empty_matrix);
   print n_u p_u;

   /* determine the type of a matrix */
   x = {1 2 3};            
   y = {"male" "female"};  
   type_x = type(x);
   type_y = type(y);
   print type_x type_y;

   /* handle an empty or undefined matrix */
   type_u = type(undefined_matrix);
   if type_u = 'U' then 
      msg = "The matrix is not defined.";
   else
      msg = "The matrix is defined.";
   print msg;


   c = {"Low" "Med" "High"};   /* maximum length is 4 characters */

   /* find the length of a character matrix and of each element */
   nlen = nleng(c);            /* length of matrix                     */
   len = length(c);            /* number of characters in each element */
   print nlen len;

   /* assign a long string to a matrix with a shorter length */
   c[2] = "Medium";            /* value is truncated! */
   print c;

   /* copy character strings to a matrix with a longer length */
   c = {"Low" "Med" "High"};   /* maximum length is 4 characters       */
   d = putc(c, "$6.");         /* copy into vector with length 6       */
   d[2] = "Medium";            /* value fits into d without truncation */
   nlen = nleng(d);
   print nlen, d;

   /* use the '+' operator to concatenate strings */
   msg1 = "I like the " + c[1] + " value.";               /* blanks!   */
   msg2 = "I like the " + trim(c[1]) + " value.";         /* no blanks */
   print msg1, msg2;


   /* create constant matrices */
   c = j(10, 1, 0);                /* 10 x 1 column vector of 0's      */
   r = j( 1, 5);                   /*  1 x 5 row vector of 1's         */
   m = j(10, 5, 3.14);             /* 10 x 5 matrix; each element 3.14 */
   miss = j(3, 2, .);              /*  3 x 2 matrix of missing values  */

   /* create a matrix by repeating values from another matrix */
   g = repeat({0 1}, 3, 2);         /* repeat the pattern 3 times down */
   print g;                         /*    and 2 times across           */

   /* create a vector of sequential values */
   i = 1:5;                 /* increment of 1           */
   j = 5:1;                 /* increment of -1          */
   k = do(1, 10, 2);        /* odd numbers 1, 3, ..., 9 */
   print i, j, k;

   /* the index creation operator has low precedence */
   n1 = 1;
   n2 = 10;
   h = n1+2:n2-3;           /* equivalent to 3:7 */ 
   print h;

   /* create variable names with sequential values */
   varNames = "x1":"x10";
   print varNames;


proc iml;
   /* create pseudorandom vectors */
   seed = j(10, 1, 1);           /* set seed (=1) and dimensions       */
   x = uniform(seed);            /* 10 x 1 pseudorandom uniform vector */
   y = 3*x + 2 + normal(seed);   /* linear response plus normal error  */

   /* create pseudorandom vectors (better statistical properties) */
   call randseed(12345);          /* set seed for RANDGEN              */
   x = j(10, 1);                  /* allocate 10 x 1 vector            */
   e = x;                         /* allocate 10 x 1 vector            */
   call randgen(x, "Uniform");    /* fill x; values from uniform dist  */
   call randgen(e, "Normal");     /* fill e; values from normal dist   */
   y = 3*x + 2 + e;               /* linear response plus normal error */


   /* transpose a matrix */
   s = {1 2 3, 4 5 6, 7 8 9, 10 11 12};        /* 4 x 3 matrix */
   transpose = t(s);                           /* 3 x 4 matrix */
   print transpose;

   sPrime = s`;          /* alternative notation to transpose a matrix */

   /* reshape a matrix */
   x = 1:12;                         /* 1 x 12 matrix                  */
   s = shape(x, 4, 3);               /* reshape data into 4 x 3 matrix */
   /* omit dimension; automatically determined */
   s1 = shape(x, 4);                           /* 4 rows ==> 3 columns */
   s2 = shape(x, 0, 3);                        /* 3 columns ==> 4 rows */

   /* pad data with a specified value (missing) */
   s = shape(1:10, 4, 3, .);          /* 4 x 3, pad with missing value */
   print s;

proc iml;
   /* use indices on either side of assignment statements */
   x = {1 2 3, 4 5 6};
   y = x[2, 3];         /* value of 2nd row, 3rd column                */
   x[2, 3] = 7;         /* changes the value of x[2,3]; y is unchanged */
   print x, y;

   /* extract submatrix */ 
   z = {1 2 3 4, 5 6 7 8, 9 10 11 12};
   rows = {1 3};
   cols = {2 4};
   w = z[rows, cols];
   print w;

   /* extract only rows or columns */
   oddRows = z[rows, ];           /* specified rows; all columns */
   evenCols = z[ , cols];         /* all rows; specified columns */

   /* different ways to specify elements of a matrix */
   z = {1 3 5 7 9 11 13};        /* row vector                         */
   w = z[{2 4 6}];               /* column vector with values {3,7,11} */
   t = z[ , {2 4 6}];            /* row vector with values {3 7 11}    */
   print w t;

   /* extract all rows except those specified in a vector v */
   q = {1 2, . 3, 4 5, 6 7, 8 .}; 
   v = {2 5};                   /* specify rows to exclude             */
   idx = setdif(1:nrow(q), v);  /* start with 1:5, exclude values in v */
   r = q[idx, ];                /* extract submatrix                   */
   print idx, r;

   /* extract matrix diagonal */
   m = {1  2  3, 
        2  5  6, 
        3  6 10};
   d = vecdiag(m);
   print d;

   /* create a diagonal matrix from a vector */
   vals = {5, 2, -1};
   s = diag(vals);
   print s;

   /* create an identity matrix */
   ident = I(3);                        /* 3 x 3 identity matrix   */
   print ident;

   /* index the diagonal elements of a matrix */
   n = nrow(m);
   p = ncol(m);
   diagIdx = do(1, n*p, p+1);           /* indices of the diagonal */
   print diagIdx;
   d2 = m[diagIdx];                     /* extract the diagonal    */
   print d2;

   /* compute B = (m - lambda*I) for lambda=1 */
   /* First approach: use the formula */
   B1 = m - I(n);                  /* I(n) gives n x n identity matrix */
   /* Second approach: Do not physically create the identity matrix */
   B = m;
   B[diagIdx] = m[diagIdx] - 1;    /* modify the diagonal              */
   print m B;

   x = shape(1:1000, 0, 4);             /* 4 columns, hundreds of rows */
   print (x[1:3,]);                     /* print first three rows      */
   varNames = 'Col1':'Col4';
   print (x[1:3,])[label="My Data" colname=varNames];

   x = 1:4;
   print (3*x + 1);                    /* print expression */


proc iml;
   /* comparison operators */
   x = {1 2 3, 2 1 1};
   s1 = (x=2);
   print s1;

   z = {1 2 3, 3 2 1};
   s2 = (x<z);
   print s2;

   /* missing values compare as less than any nonmissing value */
   m = .;
   n = 0;
   r = (m<n);
   print r;


   /* an IF-THEN/ELSE statement */
   x = {1 2 3, 2 1 1};
   z = {1 2 3, 3 2 1};
   if x <= z then 
      msg = "all(x <= z)";
   else
      msg = "some element of x is greater than the corresponding element of z";
   print msg;

   /* a DO-END block of statements */
   if x <= z then do;
      msg = "all(x <= z)";
      /* more statements ... */
   end;
   else do;
      msg = "some element of x is greater than the corresponding element of z";
      /* more statements ... */
   end;

   /* the ALL statement */
   if all(x <= z) then do;
      msg = "all(x <= z)";
      /* more statements ... */
   end;

   /* the ANY statement */
   if any(x < z) then
      msg = "some element of x is less than the corresponding element of z";
   print msg;

   /* the iterative DO statement */
   x = 1:5;
   sum = 0;
   do i = 1 to ncol(x);
      sum = sum + x[i];          /* inefficient way to sum elements */
   end;
   print sum;

   sum = sum(x);                 /* efficient; eliminate DO loop */

   /* an UNTIL clause */
   x = 1:5;
   sum = 0;
   do i = 1 to ncol(x) until(sum > 8);
      sum = sum + x[i];   
   end;
   print sum;

   /* a WHILE clause */
   x = {1 2 . 4 5};
   sum = 0;
   do i = 1 to ncol(x) while(x[i]^=.);
      sum = sum + x[i];
   end;
   print sum;

   /* a DO-UNTIL statement */
   x = 0;
   dx = 0.01;
   do until(sin(x) > sin(x+dx));
      x = x + dx;
   end;
   print x;

   /* horizontal concatenation */
   a = {1,2,3,4,5};                    /* 5 x 1 column vectors */
   b = {3,5,4,1,3};
   c = {0,1,0,0,1};
   x = a || b || c;                    /* 5 x 3 matrix         */
   print x;

   /* vertical concatenation */
   males   = {1 3 0, 2 5 1, 3 4 0};    /* 3 x 3 matrix */
   females = {4 1 0, 5 3 1};           /* 2 x 3 matrix */
   x = males // females;               /* 5 x 3 matrix */

   /* construct vector of even integers */
   free x;                             /* make sure x is empty       */
   do i = 1 to 5;
      x = x || 2*i;                    /* inefficient! 5 allocations */
   end;

   /* Improved algorithm: allocate the matrix to hold the 
      even integers. Assign values into the vector. */
   x = j(1, 5, .);                      /* allocate; fill with missing */
   do i = 1 to ncol(x);
      x[i] = 2*i;                       /* assign value                */
   end;

   x = 2*(1:5);

   y = {., 1, ., 2, 3, .};
   v = remove(y, {1 3 6});

proc iml;
   /* logical operators */
   r = {0 0 1 1};
   s = {0 1 0 1};
   and = (r & s);
   or  = (r | s);
   not = ^r;
   print and, or, not;

   /* logical combination of criteria */
   x = do(-1, 1, 0.5);
   if (x>= -1) & (x<=1) then 
      y = sqrt(1-x##2);   /* the ## operator squares each element of x */
   else 
      y = "Unable to compute the function.";
   print y;

   /* different ways to compute the same logical condition */
   if (x< -1) | (x>1) then 
      y = "Unable to compute the function.";
   else
      y = sqrt(1-x##2);
   
   if ^(x< -1) & ^(x>1) then 
      y = sqrt(1-x##2);
   else 
      y = "Unable to compute the function.";


   /* correct: second condition not evaluated if first is false */
   if x>0 then
      if log(x)>1 then do;
         /* more statements */
      end;

proc iml;
   /* union, intersection, and difference of sets */
   A = 1:4;
   B = do(2.5, 4.5, 0.5);
   u = union(A, B);                  /* union                   */
   inter = xsect(A, B);              /* intersection            */
   dif = setdif(A, B);               /* difference between sets */
   print u, inter, dif;

   /* check whether intersection and set difference are empty */
   A = 1:4;
   B = do(5, 8, 0.5);
   inter = xsect(A, B);
   if ncol(inter)>0 then 
      print inter;
   dif = setdif(A, B);
   if ncol(dif)>0 then 
      print dif;

proc iml;
   /* elementwise matrix operations with scalar or vector */
   x = {7 7, 8 9, 7 9, 5 7, 8 8};
   grandmean = 7.5;
   y = x - grandmean;           /* subtract 7.5 from each element */
   mean = {7 8}; 
   xc = x - mean;               /* subtract (7 8) from each row   */
   print y xc;

   /* elementwise matrix operations with vector or matrix */
   /* r is row vector */
   r = {1.225 1};                    /* std dev of each col            */
   std_x = xc / r;                   /* divide each column (normalize) */
   /* c is column vector */
   c = x[,1];                        /* first column of x              */
   y = x - c;                        /* subtract from each column      */
   /* m is matrix */
   m = {6.5 7.5, 7.9 9.1, 7.5 8.5, 5.6 6.4, 7.5 8.5}; 
   deviations = x - m;               /* difference between matrices    */

   print std_x y deviations; 

   /* matrix multiplication */
   A = {7 7, 8 9, 7 9, 5 7, 8 8};    /* 5 x 2 matrix           */
   v = {1, -1};                      /* 2 x 1 vector           */
   y = A*v;                          /* result is 5 x 1 vector */
   print y;

   /* Set up the normal equations (X`X)b = X`y */
   x = (1:8)`;                           /* X data: 8 x 1 vector */
   y = {5 9 10 15 16 20 22 27}`;         /* corresponding Y data */

   /* Step 1: Compute X`X and X`y */
   x = j(nrow(x), 1, 1) || x;            /* add intercept column */
   xpx = x` * x;                         /* cross-products       */
   xpy = x` * y;

   /* solve linear system */
   /* Solution 1: compute inverse with INV (inefficient) */
   xpxi = inv(xpx);                   /* form inverse crossproducts    */
   b = xpxi * xpy;                    /* solve for parameter estimates */

   /* Solution 2: compute solution with SOLVE. More efficient */
   b = solve(xpx, xpy);               /* solve for parameter estimates */
quit;

