libname SPI (SASUSER);                  /* location of data sets */

proc iml;
   /* standardize data by using robust estimates of center and scale */
   use Sashelp.Class;              /* open data set for reading        */
   read all var _NUM_ into x[colname=VarNames];   /* read variables    */
   close Sashelp.Class;            /* close data set                   */
   
   /* estimate centers and scales of each variable */
   c = median(x);                  /* centers = medians of each column */
   s = mad(x);                     /* scales = MAD of each column      */
   stdX = (x - c) / s;             /* standardize the data             */

   print c[colname=varNames];      /* print statistics for each column */
   print s[colname=varNames];


   /* convert temperatures from Celsius to Fahrenheit scale */
   Celsius = {-40, 0, 20, 37, 100}; /* some interesting temperatures */
   Fahrenheit = 9/5 * Celsius + 32; /* convert to Fahrenheit scale   */
   print Celsius Fahrenheit;

   Kelvin = Celsius + 273.15;       /* convert to Kelvin scale       */
   print Kelvin;


   /* Present a simple example program with comments.                    */
   /* The PROC IML statement is not required in SAS/IML Studio programs. */
   x = 3;        /* 1 */               /* NUMBERS indicate steps that    */
   y = 2;                              /* are described in a list        */
   z = x + y;    /* 2 */               /* AFTER the program.             */

   print z;      /* display result */  /* Other statements are briefly   */
                                       /* described WITHIN the program.  */

quit;

