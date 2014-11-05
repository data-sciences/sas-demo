
 /*-------------------------------------------------------------------*/
 /*                     The Power of PROC FORMAT                      */
 /*                        by Jonas V. Bilenas                        */
 /*       Copyright(c) 2005 by SAS Institute Inc., Cary, NC, USA      */
 /*                   SAS Publications order # 59498                  */
 /*                        ISBN: 1-59047-573-9                        */
 /*-------------------------------------------------------------------*/
 /*                                                                   */
 /* This material is provided "as is" by SAS Institute Inc.  There    */
 /* are no warranties, expressed or implied, as to merchantability or */
 /* fitness for a particular purpose regarding the materials or code  */
 /* contained herein. The Institute is not responsible for errors     */
 /* in this material as it now exists or will exist, nor does the     */
 /* Institute provide technical support for it.                       */
 /*                                                                   */
 /*-------------------------------------------------------------------*/
 /* Questions or problem reports concerning this material may be      */
 /* addressed to the author:                                          */
 /*                                                                   */
 /* SAS Institute Inc.                                                */
 /* SAS Press                                                         */
 /* Attn: Jonas V. Bilenas                                            */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  saspress@sas.com           */
 /* Use this for subject field:                                       */
 /*     Comments for Jonas V. Bilenas                                 */
 /*                                                                   */
 /*-------------------------------------------------------------------*/
 /* Date Last Updated:  March 18, 2005                                */
 /*-------------------------------------------------------------------*/


/* -------------- Chapter 1 - FILENAME transact------------------- */
124325   08/10/2003      1250.03  
     7   08/11/2003     12500.02
114565   08/11/2003         5.11
/* --------------------------------------------------------------- */

/* -------------- Chapter 1 - Figure 1.1 ------------------------- */
filename transact 'C:\BBU FORMAT\DATA\TRANS1.DAT';

data transact;                      
  infile transact;                    
  input   @1     id           $6.              
          @10    tran_date    mmddyy10.             
          @25    amount       8.2               
            ;
run;

proc   print data=transact;
run;
/* --------------------------------------------------------------- */

/* -------------- Chapter 1, Page 5 - Modified transact file ----- */
124325   08/10/2003      $1,250.03 
     7   08/11/2003     $12,500.02
114565   08/11/2003           5.11
/* --------------------------------------------------------------- */

/* -------------- Chapter 1, Page 5 - Using COMMA INFORMAT ------- */
data transact;
  infile transact;
  input @1  id         $6.                               
        @10 tran_date  mmddyy10.       
              @25 amount     comma10.2       
        ;
run;

proc print data=transact;
run;
/* --------------------------------------------------------------- */

/* -------------- Chapter 1, Page 6 - Using $CHAR INFORMAT ------- */
filename transact 'C:\BBU FORMAT\DATA\TRANS1.DAT';

data transact;
  infile transact;
  input @1  id         $CHAR6.                               
        @10 tran_date  mmddyy10.       
          @25 amount     comma10.2 
        ;
run;

proc print data=transact;
run;
/* --------------------------------------------------------------- */

/* -------------- Chapter 1, Section 1.2.2 - INPUT Function ------ */
 data transact2;
   set transact;
   id_num = input(id,6.);
 
 proc print data=transact2;
 run;
/* --------------------------------------------------------------- */

/* -------------- Chapter 1, Section 1.2.3 - INPUTC and INPUTN --- */
options yearcutoff=1920;

data fixdates (drop=start readdate);
  length jobdesc $12 readdate $8;
  input source id lname $ jobdesc $ start $;
  if source=1 then readdate= 'date7.  ';
  else readdate= 'mmddyy8.';
  newdate = inputn(start, readdate);
  datalines;
   1 1604 Ziminski writer 09aug90
   1 2010 Clavell editor 26jan95
   2 1833 Rivera writer 10/25/92
   2 2222 Barnes proofreader 3/26/98
   ;
/* --------------------------------------------------------------- */

/* --- Chapter 1, Section 1.2.4 - ATTRIB and INFORMAT STATEMENTS - */
data transact;
  infile transact;
  attrib id        informat=$6.
         tran_date informat=mmddyy10.
           amount    informat=comma10.2
         ;
  input @1  id 
        @10 tran_date 
          @25 amount 
          ;
run;

data transact;
  infile transact;
  informat id        $6.
           tran_date mmddyy10.
             amount    comma10.2
           ;
  input @1  id 
        @10 tran_date 
          @25 amount 
          ;
run;
/* --------------------------------------------------------------- */

/* -- Chapter 1, Section 1.3.1 - FORMAT Statements in Procedures - */
options center;
filename transact 'C:\BBU FORMAT\DATA\TRANS1.DAT';

data transact;
  infile transact;
  input @1  id          $6.
        @10 tran_date   mmddyy10.
              @25 amount      8.2
              ;
run;

proc print data=transact;
  format tran_date  mmddyy10.
         amount     dollar10.2;
run;
/* --------------------------------------------------------------- */

/* -- Chapter 1, Section 1.3.2 - PUT Statement ------------------- */
data _null_;                            
  set transact;                                   
  file 'c:\transact_out.dat';           
  put @1  id        $char6.             
      @10 tran_date mmddyy10.
            @25 amount    8.2
      ;
run;
/* --------------------------------------------------------------- */

/* -- Chapter 1, Section 1.3.2 - INPUT Function ------------------ */
data _null_;
  set transact;
  file 'c:\transact_out.dat';
  id_num = input(id,6.);
  put @1  id_num    6.
      @10 tran_date mmddyy10.
      @25 amount    8.2
      ;
run;
/* --------------------------------------------------------------- */

/* ------ Chapter 1, Section 1.3.2 - Zw.d FORMAT ----------------- */
data _null_;
  set transact;
  file 'c:\transact_out.dat';
  id_num = input(id,6.);
  put @1  id_num    z6.
      @10 tran_date mmddyy10.
      @25 amount    8.2
      ;
run;
/* --------------------------------------------------------------- */

/* ------ Chapter 1, Section 1.3.5 - BESTw.d FORMAT -------------- */
data test;
input @1 x $5. @7 y $5. @13 z 1.;
datalines;
117.7 1.746 1
06.61 97239 2
97123 0.126 3
;;
run;

data test2;
  set test;
  num_x = input(x,5.);
  num_y = input(y,5.);

proc print data=test2;
  var x num_x y num_y;
run;

proc print data=test2;
  var x num_x y num_y;
  format num_y best10.;
run;

/* FORMAT all numeric with BESTw.d FORMAT */
proc print data=test2;
  var x num_x y num_y;
  format _numeric_ best10.;
run;
/* --------------------------------------------------------------- */

/* ---------------------- Chapter 2 - Data ----------------------- */
/* 1. Adult Growth Hormone Deficiency (AGHD) Survey Data           */
/* FORMAT for CAUSE is not provided to protect identity of         */
/* responders.  Typical causes include pituitary brain tumor,      */
/* brain tumor radiation, unkown (idiopathic), Sheehans,           */
/* empty sella, genetic.  More information from MAGIC FOUNDATION   */
/* (800) 3-MAGIC-3                                                 */
/* --------------------------------------------------------------- */
libname bbu "C:\SAS BBU Format\DATA";

data bbu.aghd;
input @ 1 dosage        
      @10 age
      @15 agediag             
      @20 agestart
      @25 cause $12.          
      @40 diag_as_child  $1.
      @45 happy_endo  $1.    
      @50 mstat  $1.
      @55 number_surgeries    
      @60 rad   $1.
      @65 sat   $1.           
      @70 sex   $1.
      @75 state $2.
        ;
 
datalines;
0.7143   46    7   41   1              Y    Y    M    2    Y    5    M    CT
0.8      51   49   50   2              N    Y    M    .         5    M    NY
0.3      .    13   30   3              Y    Y    S    .         5    F    IN
0.6      51   12   51   2              Y    Y    M    .         5    M    CA
0.4      29   27   27   1              N    Y    S    1    Y    5    F    Fl
0.7      35   11   32   3              Y    Y    M    .         5    F    CA
.        53   49   50   4              N    Y    S    .         5    F    OR
0.4      54   48   51   5              N    Y    M    .         5    F    OR
0.4      38   38   38   3              N    N    M    .         5    F    TX
0.6      46   46   46   4              N    Y    M    .         5    F    KY
0.3      31   23   29   1              N    N    S    1    Y    4    M    XX
0.6      41   40   40   1              N    Y    M    1    N    5    F    WI
.        17   14   .    2              Y    Y    S    .         5    F    OH
.        18   11   11   1              Y    N    S    .    Y    5    F    GA
.        39    8   .    2              Y    N    D    .         5    F    MI
.        .    .    .                   Y    Y    S    .         5    F    XX
0.8      65   19   60   4              N    Y    M    .         5    F    TX
0.6      49   48   48   1              N    Y    M    2    N    5    F    AR
0.02     19   18   18   3              N    Y    S    .         3    M    PA
0.5      37   37   37   1              N    Y    M    2    N    4    F    IN
0.28     28    7    5   1              Y    Y    S    1    N    4    M    MO
.        44   40   41   4              N    N    M    .         4    F    NY
.        61   5    61   2              Y    Y    W    .         3    M    HI
0.5      28   26   26   4              N    Y    M    .         5    F    TX
0.8      52   50   50   3              N    Y    S    .         5    F    MO
0.06     30   29   29   6              N    Y    M    .         4    F    CA
0.4      40   29   38   4              N    Y    M    .         4    F    MN
0.6      46   45   45   4              N    Y    M    0         5    F    SC
0.8      49   45   48   1              N    Y    M    1    Y    5    F    FL
0.4      37   37   37   6              N    N    S    .         4    F    CA
.        45   45   45   4              N    Y    M    .         3    F    IL
.        61   56   56   4              N    Y    M    .         5    F    TX
0.54     20    8   18   1              Y    Y    S    1    N    4    F    WI
0.08     22    3   19   3              Y    Y    S    .         4    M    GA
0.0002   50   50   50   1              N    Y    S    1    N    5    M    IN
0.3      23   15   16   1              Y    Y    S    1    N    5    M    NJ
0.6      40   35   39   1              N    Y    M    1    Y    3    F    RI
0.8      52   52   52   1              N    Y    M    1    N    2    F    ID
.        32   30   .    1              N    N    S    1    N    5    M    NY
0.4      46   44   45   1              N    Y    D    1    N    5    M    VA
.        53   .    .    1              N    N    M    0    N    1    F    MD
0.7      35   16   18   1              Y    Y    M    1    N    5    F    XX
.        24   .    .    1              Y    N    S    1    N    1    F    WI
0.6      40   38   38   1              N    Y    D    0    N    5    M    MI
0.8      42   40   41   1              N    Y    D    2    Y    4    M    MN
1        32   31   31   1              N    Y    M    1    N    5    F    KY
.        32   16   27   1              Y    N    S    1    N    1    F    CA
0.4      27   26   26   1              N    Y    S    1    N    4    M    XX
0.6      23    1    1   2              Y    Y    M    .         5    F    NH
0.6      70   68   68   3              N    Y    S    .         4    M    MO
.        30   23   23   1              N    Y    M    1    N    4    F    FL
.        39   38   38   2              N    Y    S    .         5    F    NY
0.4      35   16   34   1              Y    Y    S    1    N    5    F    WA
;;;
run;
/* --------------------------------------------------------------- */
/* 2. Simulated Credit Score Data                                  */
/* --------------------------------------------------------------- */
data bbu.scores;
  do id = 1 to 10000;
    x = rannor(98);
    score = INT(196 +16*x);
    lnest = -5.322033893 + 0.034657359*score;
    pbad = exp(lnest)/(exp(lnest)+1);
    a = ranuni(56);
    bad = (a>pbad);
    income_est = INT(15000 <> (-130948.5714 + 905.1428571*score + 
                 rannor(4)*5500));
    drop x a pbad lnest;
    output;
  end;
run;
/* --------------------------------------------------------------- */
 
/* ---- Chapter 3, Section 3.2.1 - Using Data Step IF-THEN-ELSE -- */
options nocenter errors=2;
libname bbu "C:\SAS BBU Format\DATA";

data example1;
  set bbu.Aghd;
  if sex='M' then sexg='Male';
  else sexg='Female';

proc freq data=example1;
  tables sexg;
run;
/* --------------------------------------------------------------- */

/* ---- Chapter 3, Section 3.2.2 - Using the VALUE STATEMENT ----- */
options nocenter errors=2;
libname bbu "C:\SAS BBU Format\DATA";

proc format;
  value $sex 'M' = 'Male'    
             'F' = 'Female'
  ;                                

proc freq data=bbu.Aghd;
  tables sex;
  format sex $sex.;
run;
/* --------------------------------------------------------------- */

/* - Chapter 3, Section 3.3 - Internal SAS Chatacter INFORMAT Impact */
/* ----------------------------------------------------------------- */
/* 1. Using $w. INFORMAT                                             */
/* ----------------------------------------------------------------- */
proc format;
  value $sx  'Fe' = 'Female'
             'M'  = 'Male'
  ;

data test;
  input sex $2.;
  datalines;
Fe
 M
Fe
Fe
 M
 M
;

proc freq data=test;
  table sex;
  format sex $sx.;
run;
/* ----------------------------------------------------------------- */
/* 2. Using $CHARw. INFORMAT                                         */
/* ----------------------------------------------------------------- */
data test2;
  input sex $char2.;
  datalines;
Fe
 M
Fe
Fe
 M
 M
;
proc freq data=test2;
  table sex;
  format sex $sx.; run;
run;
/* ----------------------------------------------------------------- */
/* 3. Solution                                                       */
/* ----------------------------------------------------------------- */
proc format;
  value $sx   'Fe'      = 'Female'
              'M',' M'  = 'Male'
  ;

proc freq data=test;  /* DATA using $2. */    
  table sex;
  format sex $sx.;
run;
proc freq data=test2; /* DATA using $CHAR2. */ 
  table sex;
  format sex $sx.;
run;
/* ----------------------------------------------------------------- */

/* ---- Chapter 3, Section 3.4 - Order of Format Labels  --------- */
proc freq data=test2 ORDER=FORMATTED;
  table sex;
  format sex $sx.;
run;

proc format;
  value $srta 'Fe'      = 'Female'
              'M',' M'  = '  Male'
  ;
  value $srtb 'Fe'      = '2: Female'
              'M',' M'  = '1: Male'
  ;

proc freq data=test ORDER=FORMATTED;
  tables sex;
  format sex $srta.;

proc freq data=test ORDER=FORMATTED;
  tables sex;
  format sex $srtb.;
run;
/* --------------------------------------------------------------- */

/* ---- Chapter 3, Section 3.5 - INVALUE Statements -------------- */
proc format;
  invalue $sx  'Fe' = 'Female'
               ' M' = 'Male'
  ;


data informat_test;
  input sex $sx.;
  datalines;
Fe
 M
Fe
Fe
 M
 M
;

proc print data=informat_test;
run;
/* --------------------------------------------------------------- */

/* ---- Chapter 3, Section 3.5.1 - JUST and UPCASE Options ------- */
proc format;
  invalue $sx (just upcase) 
              'FE' = 'Female'
              'M'  = 'Male'
  ;

data informat_test;
  input sex $sx.;
  datalines;
Fe
 M
Fe
Fe
 m
 M
;

Proc print data=informat_test;
run;
/* --------------------------------------------------------------- */

/* ---- Chapter 3, Section 3.6.3 - Name OPTIONS ------------------ */
data test;
  do test_values = 1/3, 2/3;
    output;
  end;
run;

proc format;
  value testa .3333 = '1/3'
              .6667 = '2/3'
  ;
  value testb (fuzz=.001) .3333 = '1/3'
                          .6667 = '2/3'
  ;
run;

proc freq data=test;                
  tables test_values;
  format test_values testa.;
run;

proc freq data=test;                  
   tables test_values;
   format test_values testb.;
run;

data test;
  do test_values = 1/3, 2/3, 1/6;
    output;
  end;
run;

proc format;
  value testd (default=6 FUZZ=.001) .3333 = '1/3'
                                    .6667 = '2/3'
  ;
run;

proc freq data=test;
  tables test_values;
  format test_values testd.;
run;
/* --------------------------------------------------------------- */

/* ---- Chapter 3, Section 3.6.5 - Format and Informat Values ---- */
proc format;
  value age low - 20  = 'LE 20'
            21-30     = '21-30'
                        31-40     = '31-40'
                        41-50     = '41-50'
                        51-60     = '51-60'
                        61 - high = 'GT 60'   
                        .         = 'MISSING' 
  ;

proc freq data=bbu.Aghd;
  tables age/missing; 
  format age age.;
run;

proc format;
  value dosage 0             = '0mg'
               0    < - 0.25 = 'GT 0mg - 0.25mg'     
               0.25 < - 0.50 = 'GT 0.25mg - 0.50mg'
                           0.50 < - 0.75 = 'GT 0.50mg - 0.75mg'
                           0.75 < - 1    = 'GT 0.75mg - 1.00mg'
                           1.00 < - high = 'GT 1.00mg'
                           .             = 'MISSING'
                           other         = 'Strange Entry'
  ;
proc freq data=bbu.Aghd;
  tables dosage/missing;
  format dosage dosage.;
run;

/* ---- Chapter 3, Section 3.6.7 - Embedded (Nested) Formats  ---- */
proc format;
  value win     0 = 'Loser'
            other = [dollar5.]
  ;
proc freq data=win;
  tables win;
  format win win.;
run;
/* --------------------------------------------------------------- */

/* ---- Chapter 4, Section 4.3 - Printing Percentages in Tabulate  */
proc format;
  value score low-<200 = 'LT 200'
                  200-high = 'GT 200'
  ;



  picture pct (round) low-high = '009.9%'
  ;

proc tabulate data=bbu.scores noseps;
  class score;
  format score score.;
  table (score all)
        ,
          (N='Frequency'*f=comma10.
         pctn='ROW %'*f=pct.
          )/rts=10 misstext=' ';
run;
/* --------------------------------------------------------------- */

/* ---- Chapter 4, Section 4.5 - PREFIX Options ------------------ */
proc format;
  picture pct (round) low - <0 = '009.99%' (prefix='-')  
                      0 - high = '009.99%'               
  ;
  picture dol (round) low - <0 = '000,009.99' (prefix='-$')  
                      0 - high = '000,009.99' (prefix='$')  
  ;
/* --------------------------------------------------------------- */

/* ---- Chapter 4, Section 4.6 - Label Widths for PICTURE Formats  */
/* 1. Too small of a width --------------------------------------- */
proc format;
  picture dol (round) low-<0  = '0,009' (prefix='-$')
                       0-high = '0,009' (prefix='$')
  ;
run;

data _null_;
  do test = -50000, -1000, -10, -1.5, -0.5, .4, .5, 10, 1000, 50000, 500000;
    put test=  @20 'FORMATED Result: ' test dol.;
  end;
run; 
/* 2. Modified width --------------------------------------------- */
proc format;
  picture dol (round) low-<0  = '000,000,009' (prefix='-$')
                       0-high = '000,000,009' (prefix='$')
  ;
/* 3. DEFAULT Width  In a PUT statment----------------------------- */  
data _null_;
  do test = -50000, -1000, -10, -1.5, -0.5, .4, .5, 10, 1000, 50000, 500000;
    put test=  @20 'FORMATED Result: ' test dol8.;
  end;
run; 
/* --------------------------------------------------------------- */


/* ---- Chapter 4, Section 4.9 - MULTIPLIER OPTION --------------- */
/* 1. Devide values by 1000 -------------------------------------- */
proc format; 
  picture dolm (round) low-<0  = '000,000,009M' 
                                (prefix='-$' mult=1e-3)
                       0-high = '000,000,009M' 
                                (prefix='$'  mult=1e-3)
  ;
run;

data _null_;
  do test = -55678,  10, 1000, 51230, 500132;
    put test=  @20 'FORMATED Result: ' test dolm.;
  end;
run;
/* 2. Adding a decimal with a PICTURE: Incorrect ----------------- */
proc format;
  picture dolm (round) low-<0  = '000,000,009.9M' 
                                (prefix='-$' mult=1e-3)
                      0-high = '000,000,009.9M' 
                                (prefix='$'  mult=1e-3)
  ;
run;
/* 3. Corrected -------------------------------------------------- */
proc format;
  picture dolm (round) low-<0  = '000,000,009.9M'
                                (prefix='-$' mult=1e-2) 
                      0-high = '000,000,009.9M' 
                                (prefix='$'  mult=1e-2)
  ;
run;

data _null_;
  do test = -55678,  10, 1000, 51230, 500132;
    put test=  @20 'FORMATED Result: ' test dolm.;
  end;
run;
/* --------------------------------------------------------------- */

/* ---- Chapter 4, Section 4.10 Additional  OPTIONS -------------- */
/* 1. NOEDIT OPTION ---------------------------------------------- */
proc format;
  picture dolm (round) low-0   = '000,000,009.9M' 
                                 (prefix='-$' mult=1e-2)
                      0-100000 = '000,000,009.9M' 
                                 (prefix='$'  mult=1e-2)
                   100000-high = 'GE $100,000' (noedit)
  ;
run;

data _null_;
  do  test = -55678,  10, 1000, 51230, 500132;
    put test=  @20 'FORMATED Result: ' test dolm.;
  end;
run;
/* 2. Time and Date Directives ----------------------------------- */
proc format;
  picture dt 
   low-high = 'TIME STAMP: %A %B %d, %Y.'
              (datatype=date)
  ;
  picture tm 
    low-high = '%I:%M.%S%p'
               (datatype=time);

data _null_;
  file print;
  now = today();
  tm = time();
  put  now dt40.  tm tm.;
run;
/* --------------------------------------------------------------- */

/* ---- Chapter 5, Section 5.2 Table Lookup ---------------------- */
/*1. Using INVALUE ---------------------------------------------- */
proc format;
  invalue STL low-<160 = 1000 
              160-179  = 2500
              180-199  = 5000
              200-219  = 7500
                220-high = 9500
  ;

data scores;
  set bbu.scores;
  cr_line = input(score,STL.);         
run;
/*2. Using VALUE ------------------------------------------------ */
proc format;
  value STL low-<160 = 1000 
            160-179  = 2500
            180-199  = 5000
            200-219  = 7500
            220-high = 9500
  ;

data scores;
  set bbu.scores;
  cr_line = input(put(score,STL.),best12.);  
/* --------------------------------------------------------------- */

/* ---- Chapter 5, Section 5.3 Two-Dimension Table Lookup--------- */
proc format;
  value score_f low-<160 = 'INCA'    
                160-179  = 'INCB'
                180-199  = 'INCC'
                200-219  = 'INCD'
                220-high = 'INCE'
  ;
  value INCA low-<35000=' 500' 35000-<45000='750' 45000-<55000='1000' 
             55000-high='1250'
  ;
  value INCB low-<35000='1500' 35000-<45000='2000' 45000-<55000='2500' 
             55000-high='3000'
  ;
  value INCC low-<35000='4000' 35000-<45000='4500' 45000-<55000='5000' 
             55000-high='6000'
  ;
  value INCD low-<35000='7000' 35000-<45000='7500' 45000-<55000='8000' 
             55000-high='8500'
  ;
  value INCE low-<35000='9000' 35000-<45000='10000' 45000-<55000='15000'
             55000-high='20000'
  ;

data scores;
  set bbu.scores;
  fmtuse = put(score,score_f.);  
  line = input(putn(income_est,fmtuse),best12.);
run;
/* --------------------------------------------------------------- */

/* ---- Chapter 5, Section 5.4 PUTN and PUTC with MACRO Variables  */
libname bbu 'C:\BBU FORMAT\DATA';

proc format;
  value $var  'age'     = 'Age of Responder'
              'agediag' = 'Age Diagnosed'
              'dosage'  = 'Daily Dosage'
  ;
  picture dosage (round)low-high = '0009.99mg'
  ;
run;

%macro histo(var);
 proc univariate data=bbu.Aghd;
  var &var;
  label &var="%sysfunc(putc(&var,$var.))";
  format dosage dosage.;
  histogram &var  /    vscale    = count
                       cframe    = ligr
                       cfill     = gwh
                       pfill     = solid
                       legend    = legend1;
  inset n mean  median min max 
                      /header='Summary Statistics'
                       cfill   = white
                       ctext   = black;
  legend1 cframe=gray cborder=black;
  title;
  run;
%mend;

%histo(age)
/* --------------------------------------------------------------- */

/* ---- Chapter 5, Section 5.5 Extracting Data ------------------- */
proc format;
  value $key '06980', '0698F', '0699H' = 'OK'
             other                     = 'NG'
  ;
 
data stuff;
  set large.stuff;
  if put(key,$key.)= 'NG' then delete;                  
run;
/* --------------------------------------------------------------- */

/* ---- Chapter 5, Section 5.6 Data Merges and CTLIN Dataset ----- */
/* 1.  First Example --------------------------------------------- */
proc sort data=small (keep=accn) nodupkey force; 
  by accn;
run;

data fmt (rename=(accn=start));  
  retain fmtname 'key'           
         type 'N'
               label 'Y';
  set small;

proc format cntlin=fmt;          
run;

data matched;
  set test;
  where put(accn,key.)='Y';      
run;
/* 2.  Adding an OTHER value ------------------------------------- */
data fmt (rename=(accn=start));
  retain fmtname 'key'
         type 'N'
           label 'Y';
  set small end=eof;
  output;
  if eof then do;
    HLO='O';    
    label='N';
    output;
  end;
/* 3.  For Flat File Extract ------------------------------------- */
data _null_;
  infile test missover;
  file extract;
  input @1 accn 6.;
  if put(accn,key.)='Y' then put _infile_;
run;
/* --------------------------------------------------------------- */

/* ---- Chapter 5, Section 5.7 Outlier Trimming Example ---------- */
options nocenter errors=2 mprint;
libname bbu "C:\SAS BBU Format\DATA";

proc format;
  value sat 5     = 1                        
            other = 0
  ;

%let vars = age agediag agestart dosage;     

proc means data=bbu.aghd noprint;            
  var &vars;
  output out=trim p95=;
run;


%macro fmtcreate(var);                       
  fmtname = '_' || "&var" || '_';            
  start = &var;
  end   = 'high';                            
  label = &var;
  output;
%mend;

data cntlin (keep=fmtname type  start end label);
  retain type 'N';
  length fmtname $10; 
  set trim (keep=&vars);
  %fmtcreate(age)
  %fmtcreate(agediag)
  %fmtcreate(agestart)
  %fmtcreate(Dosage)
run;

proc sort data=cntlin;
  by fmtname;
run;
proc format cntlin=cntlin fmtlib;                         
run;

%macro missing_trim(var);
  length fmtuse $10;
  fmtuse = '_' || "&var" || '_';                           
  &var = input(putn(&var,fmtuse),best.) <> 0;     
%mend;

data aghd_model;
  set book.aghd;
  /* dependent variable for logistic regression */
  sat=input(put(sat,sat.),1.);                          
  /* set missing values to 0  and trim*/
  %missing_trim(age)
  %missing_trim(agediag)
  %missing_trim(agestart)
  %missing_trim(dosage)
run;  

proc logistic data=aghd_model descending;                
  class sex;
  model sat = sex | age | agestart | dosage@2
              age*age agestart*agestart dosage*dosage
                  /selection=stepwise sle=.05 sls=.05;
run;
/* --------------------------------------------------------------- */

/* ---- Chapter 6, Section 6.2 Multilabel Example ---------------- */
proc format;
  value key low -    0.20 = 'a1'       
            0.20 < - 0.25 = 'a2'
            0.25 < - 0.35 = 'a4'
            0.35 < - 0.80 = 'd1'
                        0.80 < - high = 'd6'
  ;
  picture p8r (round)                  
    low - < 0 = '0009.99%' (prefix='-')
    0 - high  = '0009.99%'
  ;
  value $deccode (multilabel notsorted)          
        'a1'        = 'a1: Approval'
        'a2'        = 'a2: Weak Approval'
        'a4'        = 'a4: Approved Alternate Product'
        'a0' - 'a9' = 'APPROVE TOTALS'
        'd1'        = 'd1: Decline for Credit'
        'd6'        = 'd6: Decline Other'
        'd0' - 'd9' = 'DECLINE TOTALS'
  ;

data decision;                    
  do id = 1 to 1000;
    decision = put(ranuni(7),key.);  
    output;
  end;
/* 1. MEANS Output ----------------------------------------------- */
proc means data=decision n;
  class decision/mlf preloadfmt order=data;
  format decision $deccode.;
run;
/* 2. TABULATE Output -------------------------------------------- */
proc tabulate data=decision 
              noseps 
              formchar='           ';
  class decision/mlf preloadfmt order=data;
  format decision $deccode.;
  table (decision all)
        ,n*f=comma5.
            pctn='%'*f=p8r.
           /rts=33 row=float misstext=' ';
run;
/* --------------------------------------------------------------- */

/* ---- Chapter 7, Section 7.2 Storing Formats ------------------- */
libname library 'c:\temp';

proc format library=library;
  value $sex 'M' = Male
             'F' = Female
  ;
run;
/* --------------------------------------------------------------- */

/* ---- Chapter 7, Section 7.3 Viewing Stored Formats ------------ */
proc format library=library.fmtest fmtlib;
run;

/* OR */
proc format library=library.fmtest cntlout=test;
run;

proc contents data=test;
proc print noobs data=test;  var fmtname start end label;
run; 
/* --------------------------------------------------------------- */

/* ---- Chapter 7, Section 7.4 Format Catalogs ------------------- */
/* 1.  First Example --------------------------------------------- */
proc catalog c=library.fmtest;
  contents;
run; 
/* 2.  Second Example ------------------------------------------- */
options ls=137;
proc catalog c=library.fmtest;
  contents stat;
run;
/* 3.  Adding a label to catalog entry -------------------------- */
proc catalog c=library.fmtest;
  modify sx.formatc (description='Sex Code Format');
  contents;
run;
/* --------------------------------------------------------------- */


