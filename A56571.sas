This archive contains the programs and data sets from ``Visualizing
Categorical Data''.  These programs are maintained by me at the
VCD web site, http://www.math.yorku.ca/SCS/vcd/, where any updated
versions may be found.

The files are grouped into the following directories:

   catdata- data sets from Appendix B
   doc    - some documentation, in pdf form
   iml    - all the SAS/IML programs
   macros - all the macro programs (Appendix A)
   mosaics- SAS/IML programs for mosaic displays, and examples
   sample - sample programs

INSTALLATION

For ease of use, you should copy these directories to similarly-named
directories under your !SASUSER directory.  In a DOS or Windows
environment, for example, this might be C:\SAS\SASUSER; under a
Unix-like system, this might be ~/sasuser/ where ~ refers to your
home directory.

The macro programs are most easily used if you add the name of the
macros directory to the list of directories recognized by the SAS
Autocall Facility.  Then, SAS will search this directory automatically
for macro programs which you invoke.  You can do this by adding a
statement like the following to your AUTOEXEC.SAS file:

   options sasautos=('vcdmacros', SASAUTOS);

substituting for 'vcdmacros' the directory to which you copied the 
macros; for example under Windows,

   options sasautos=('c:\sasuser\macros', SASAUTOS);

If you are running SAS from a networked installation, you may need to
modify the -autoexec option for SAS invocation so that
your local AUTOEXEC.SAS is used, rather than the system-wide
version.

It is also convenient to define (in your AUTOEXEC.SAS file) FILENAME
statements to point to these directories, for use in %INCLUDE
statements, so that you do not need to refer to full path filenames.
The following FILEREFs are assumed to be defined in most of the
sample programs.  They are illustrated here using pathnames for a
Unix system.

filename iml      '~/sasuser/iml';
filename macros   '~/sasuser/macros';
filename mosaics  '~/sasuser/mosaics';
filename catdata  '~/sasuser/catdata';

Thus, the statement,

   %include catdata(icu);

will find the file ~/sasuser/catdata/icu.sas.

In addition, all of my graphics application programs (in the samples/
and mosaics/ directories) use a single file, goptions.sas, to set
global graphics options the way I want, and to make these applications
portable.  I define this file in a FILENAME statement as,

filename goptions    '~/sasuser/goptions.sas';

and start each program with

   %include goptions;

For Windows systems, this file might contain, for example,

   goptions reset=all device=win target=winprtc;

or might simply be an empty file.  On a Unix system, for direct output
to PostScript files, I use something like,

   goptions lfactor=3 device=pscolor ftext=hwpsl009 htext=1.5 htitle=2;

Instructions for installing the SAS/IML programs for mosaic displays
are given in the INSTALL file in the mosaics/ directory.

REQUIREMENTS:

All of the programs require Base/SAS and SAS/GRAPH.  Many also require
SAS/IML.

LIMITATIONS:

All of the macros and other programs were developed and tested under
SAS Versions 6.07 - 6.12.  Initial testing and modification
for Versions 7 - 8.1 has begun, but I cannot yet say that subtle changes
have all been caught and accounted for.

In addition, all SAS graphics depend on the graphics parameters for fonts,
graph size, etc. set in the graphics device driver and in goptions statements.

/*
title 'Arthritis treatment data';
*/
proc format;
   value outcome 0 = 'not improved'
                 1 = 'improved';
data arthrit;
   length treat $7. sex $6. ;
   input id treat $ sex $ age improve @@ ;
   case = _n_;
   better  = (improve > 0);
   _treat_ = (treat ='Treated') ;     /* dummy variables */
   _sex_   = (sex = 'Female');
  cards ;
57 Treated Male   27 1   9 Placebo Male   37 0
46 Treated Male   29 0  14 Placebo Male   44 0
77 Treated Male   30 0  73 Placebo Male   50 0
17 Treated Male   32 2  74 Placebo Male   51 0
36 Treated Male   46 2  25 Placebo Male   52 0
23 Treated Male   58 2  18 Placebo Male   53 0
75 Treated Male   59 0  21 Placebo Male   59 0
39 Treated Male   59 2  52 Placebo Male   59 0
33 Treated Male   63 0  45 Placebo Male   62 0
55 Treated Male   63 0  41 Placebo Male   62 0
30 Treated Male   64 0   8 Placebo Male   63 2
 5 Treated Male   64 1  80 Placebo Female 23 0
63 Treated Male   69 0  12 Placebo Female 30 0
83 Treated Male   70 2  29 Placebo Female 30 0
66 Treated Female 23 0  50 Placebo Female 31 1
40 Treated Female 32 0  38 Placebo Female 32 0
 6 Treated Female 37 1  35 Placebo Female 33 2
 7 Treated Female 41 0  51 Placebo Female 37 0
72 Treated Female 41 2  54 Placebo Female 44 0
37 Treated Female 48 0  76 Placebo Female 45 0
82 Treated Female 48 2  16 Placebo Female 46 0
53 Treated Female 55 2  69 Placebo Female 48 0
79 Treated Female 55 2  31 Placebo Female 49 0
26 Treated Female 56 2  20 Placebo Female 51 0
28 Treated Female 57 2  68 Placebo Female 53 0
60 Treated Female 57 2  81 Placebo Female 54 0
22 Treated Female 57 2   4 Placebo Female 54 0
27 Treated Female 58 0  78 Placebo Female 54 2
 2 Treated Female 59 2  70 Placebo Female 55 2
59 Treated Female 59 2  49 Placebo Female 57 0
62 Treated Female 60 2  10 Placebo Female 57 1
84 Treated Female 61 2  47 Placebo Female 58 1
64 Treated Female 62 1  44 Placebo Female 59 1
34 Treated Female 62 2  24 Placebo Female 59 2
58 Treated Female 66 2  48 Placebo Female 61 0
13 Treated Female 67 2  19 Placebo Female 63 1
61 Treated Female 68 1   3 Placebo Female 64 0
65 Treated Female 68 2  67 Placebo Female 65 2
11 Treated Female 69 0  32 Placebo Female 66 0
56 Treated Female 69 1  42 Placebo Female 66 0
43 Treated Female 70 1  15 Placebo Female 66 1
                        71 Placebo Female 68 1
                         1 Placebo Female 74 2
;
title 'Berkeley Admissions data';
proc format;
   value admit 1="Admitted" 0="Rejected"          ;
   value yn    1="+"        0="-"                 ;
   value dept  1="A" 2="B" 3="C" 4="D" 5="E" 6="F";
        value $sex  'M'='Male'   'F'='Female';
data berkeley;
   do dept = 1 to 6;
      do gender = 'M', 'F';
         do admit = 1, 0;
            input freq @@;
            output;
   end; end; end;
/* Admit  Rej  Admit Rej */
cards;
     512  313    89   19
     353  207    17    8
     120  205   202  391
     138  279   131  244
      53  138    94  299
      22  351    24  317
;
title 'Hair - Eye color data';
data haireye;
   length  hair $8 eye $6 sex $6;
   drop c i black brown red blond;
   array h{*} black brown red blond;
   c='Black Brown Red Blond';
   input sex $ eye $ black brown red blond;
   do i=1 to dim(h);
      count = h(i); hair=scan(c,i);
      output;
      end;
cards;
M  Brown        32        53        10         3
M  Blue         11        50        10        30
M  Hazel        10        25         7         5
M  Green         3        15         7         8
F  Brown        36        66        16         4
F  Blue          9        34         7        64
F  Hazel         5        29         7         5
F  Green         2        14         7         8
;
/*
Name:      icu.sas
Title:     The ICU data
KEYWORDS:  Logistic Regression
SIZE:  200 observations, 21 variables

NOTE:
        These data come from Appendix 2 of Hosmer and Lemeshow (1989).
These data are copyrighted and must be acknowledged and used accordingly.

DESCRIPTIVE ABSTRACT:
        The ICU data set consists of a sample of 200 subjects who were part of
a much larger study on survival of patients following admission to an adult
intensive care unit (ICU).  The major goal of this study was to develop a
logistic regression model to predict the probability of survival to hospital
discharge of these patients and to study the risk factors associated with 
ICU mortality.  A number of publications have appeared which have focused on
various facets of the problem.  The reader wishing to learn more about the
clinical aspects of this study should start with Lemeshow, Teres, Avrunin,
and Pastides (1988).

SOURCE:  Data were collected at Baystate Medical Center in Springfield,
Massachusetts.

REFERENCES:

1.  Hosmer and Lemeshow, Applied Logistic Regression, Wiley, (1989).

2.  Lemeshow, S., Teres, D., Avrunin, J. S., Pastides, H. (1988). Predicting
    the Outcome of Intensive Care Unit Patients. Journal of the American
    Statistical Association, 83, 348-356.
*/

proc format;
        value yn    0='No' 1='Yes';
        value sex   0='Male'  1='Female';
        value race  1='White' 2='Black'  3='Other';
        value ser   0='Medical' 1='Surgery';
        value admit 0='Elective' 1='Emergency';
        value po    0='>60'     1='<=60';
        value ph    0='>=7.25'  1='<7.25';
        value pco   0='<=45'   1='>45';
        value cre   0='<=2'    1='>2';

data icu;
        input id died age sex race service cancer renal infect
                cpr systolic hrtrate previcu admit fracture po2 ph pco bic
                creatin coma;
        label
                id = 'Patient id code'
                died = 'Died before discharge'      /* 0=No, 1=Yes */
                age = 'Age'                         /* years */
                sex = 'Sex'                         /* 0 = Male, 1 = Female */
                race = 'Race'                       /* 1 = White, 2=Black, 3 = Other */
                service = 'Service at Admission'    /* 0 = Medical, 1 = Surgical */
                cancer = 'Cancer Part of Problem'   /* 0=No, 1=Yes */
                renal = 'History of Chronic Renal'  /* 0=No, 1=Yes */
                infect = 'Infection Probable'       /* 0=No, 1=Yes */
                cpr = 'CPR Prior to ICU Admission'  /* 0=No, 1=Yes */
                systolic = 'Systolic Blood Pressure' /* mm Hg */
                hrtrate = 'Heart Rate at Admission' /* beats/min */
                previcu = 'Previous Admit to ICU'   /* 0=No, 1=Yes */
                admit = 'Type of Admission'         /* 0=Elec 1=Emerg */
                fracture = 'Fracture'               /* 0=No, 1=Yes */
                po2 = 'PO2, inital Blood Gas'       /* 0=>60, 1=<=60 */
                ph = 'PH, inital Blood Gas'         /* 0=7.25, 1= <7.25 */
                pco = 'PCO2, inital Blood Gas'      /* 0=45, 1= >45 */
                bic = 'Bicarbonate, inital Blood'   /* 0=18, 1= <18 */
                creatin = 'Creatinine, inital Blood' /* 0=2, 1= >2 */
                coma = 'Consciousness at ICU'       /* 0=None 1=Stupor 2=Coma */
                uncons = 'Stupor or coma at ICU';

    white = (race=1);
    uncons= (coma>0);

    format died cancer renal infect cpr previcu fracture yn.;
    format sex sex. race race. admit admit. ph ph. pco pco. creatin cre.;
/*
          D         R                                                   C
          I   A  S  A  S  C  C  I  C   S    H   P  T  F  P     P  B  C  O
       I  E   G  E  C  E  A  R  N  P   Y    R   R  Y  R  O  P  C  I  R  M
       D  D   E  X  E  R  N  N  F  R   S    A   E  P  A  2  H  O  C  E  A
*/
cards;
       8  0  27  1  1  0  0  0  1  0  142   88  0  1  0  0  0  0  0  0  0
      12  0  59  0  1  0  0  0  0  0  112   80  1  1  0  0  0  0  0  0  0
      14  0  77  0  1  1  0  0  0  0  100   70  0  0  0  0  0  0  0  0  0
      28  0  54  0  1  0  0  0  1  0  142  103  0  1  1  0  0  0  0  0  0
      32  0  87  1  1  1  0  0  1  0  110  154  1  1  0  0  0  0  0  0  0
      38  0  69  0  1  0  0  0  1  0  110  132  0  1  0  1  0  0  1  0  0
      40  0  63  0  1  1  0  0  0  0  104   66  0  0  0  0  0  0  0  0  0
      41  0  30  1  1  0  0  0  0  0  144  110  0  1  0  0  0  0  0  0  0
      42  0  35  0  2  0  0  0  0  0  108   60  0  1  0  0  0  0  0  0  0
      50  0  70  1  1  1  1  0  0  0  138  103  0  0  0  0  0  0  0  0  0
      51  0  55  1  1  1  0  0  1  0  188   86  1  0  0  0  0  0  0  0  0
      53  0  48  0  2  1  1  0  0  0  162  100  0  0  0  0  0  0  0  0  0
      58  0  66  1  1  1  0  0  0  0  160   80  1  0  0  0  0  0  0  0  0
      61  0  61  1  1  0  0  1  0  0  174   99  0  1  0  0  1  0  1  1  0
      73  0  66  0  1  0  0  0  0  0  206   90  0  1  0  0  0  0  0  1  0
      75  0  52  0  1  1  0  0  1  0  150   71  1  0  0  0  0  0  0  0  0
      82  0  55  0  1  1  0  0  1  0  140  116  0  0  0  0  0  0  0  0  0
      84  0  59  0  1  0  0  0  1  0   48   39  0  1  0  1  0  1  1  0  2
      92  0  63  0  1  0  0  0  0  0  132  128  1  1  0  0  0  0  0  0  0
      96  0  72  0  1  1  0  0  0  0  120   80  1  0  0  0  0  0  0  0  0
      98  0  60  0  1  0  0  0  1  1  114  110  0  1  0  0  0  0  0  0  0
     100  0  78  0  1  1  0  0  0  0  180   75  0  0  0  0  0  0  0  0  0
     102  0  16  1  1  0  0  0  0  0  104  111  0  1  0  0  0  0  0  0  0
     111  0  62  0  1  1  0  1  0  0  200  120  0  0  0  0  0  0  0  0  0
     112  0  61  0  1  0  0  0  1  0  110  120  0  1  0  0  0  0  0  0  0
     136  0  35  0  1  0  0  0  0  0  150   98  0  1  0  0  0  0  0  0  0
     137  0  74  1  1  1  0  0  0  0  170   92  0  0  0  0  0  1  0  0  0
     143  0  68  0  1  1  0  0  0  0  158   96  0  0  0  0  0  0  0  0  0
     153  0  69  1  1  1  0  0  0  0  132   60  0  1  0  0  0  0  0  0  0
     170  0  51  0  1  0  0  0  0  0  110   99  0  1  0  0  0  0  0  0  0
     173  0  55  0  1  1  0  0  0  0  128   92  0  0  0  0  0  0  0  0  0
     180  0  64  1  3  1  0  0  1  0  158   90  1  1  0  0  0  0  0  0  0
     184  0  88  1  1  1  0  0  1  0  140   88  1  1  0  0  0  0  0  0  0
     186  0  23  1  1  1  0  0  0  0  112   64  0  1  1  0  0  0  0  0  0
     187  0  73  1  1  1  1  0  0  0  134   60  0  0  0  0  0  1  0  0  0
     190  0  53  0  3  1  0  0  0  0  110   70  1  0  0  0  0  0  0  0  0
     191  0  74  0  1  1  0  0  0  0  174   86  0  0  0  0  0  0  0  0  0
     207  0  68  0  1  1  0  0  0  0  142   89  0  0  0  0  0  0  0  0  0
     211  0  66  1  1  0  0  0  1  0  170   95  1  1  0  0  0  0  0  0  0
     214  0  60  0  1  1  1  0  1  0  110   92  0  0  0  0  0  0  0  0  0
     219  0  64  0  1  1  0  0  1  0  160  120  0  0  0  0  0  0  0  0  0
     225  0  66  0  2  1  1  0  1  0  150  120  0  0  0  0  0  1  0  0  0
     237  0  19  1  1  1  0  0  1  0  142  106  0  1  1  0  0  0  0  0  0
     247  0  18  1  1  0  0  0  0  0  146  112  0  1  0  0  0  0  0  0  0
     249  0  63  0  1  1  0  0  1  0  162   84  1  1  0  0  0  0  0  0  0
     260  0  45  0  1  0  0  0  0  0  126  110  0  1  0  0  0  0  0  0  0
     266  0  64  0  1  0  0  0  0  0  162  114  0  1  0  0  0  0  0  0  0
     271  0  68  1  1  0  0  0  1  0  200  170  1  1  0  0  0  0  0  0  0
     276  0  64  1  1  0  0  0  1  0  126  122  0  1  0  1  0  1  0  0  0
     277  0  82  0  1  1  0  0  0  0  135   70  0  0  0  0  0  0  0  0  0
     278  0  73  0  1  1  0  0  0  0  170   88  0  0  0  0  0  0  0  0  0
     282  0  70  0  1  0  0  0  0  0   86  153  1  1  0  0  0  1  0  0  0
     292  0  61  0  1  1  0  0  1  0   68  124  0  1  0  0  0  0  0  0  0
     295  0  64  0  1  1  1  0  1  0  116   88  0  0  0  0  0  0  0  0  0
     297  0  47  0  1  1  1  0  1  0  120   83  0  0  0  0  0  0  0  0  0
     298  0  69  0  1  1  0  0  0  0  170  100  0  0  0  0  0  0  0  0  0
     308  0  67  1  1  0  0  0  1  0  190  125  0  1  0  0  0  0  0  0  0
     310  0  18  0  1  1  1  0  0  0  156   99  0  0  0  0  0  0  0  0  0
     319  0  77  0  1  1  0  0  1  0  158  107  0  0  0  0  0  0  0  0  0
     327  0  32  0  2  1  0  0  0  0  120   84  0  1  0  0  0  0  0  0  0
     333  0  19  1  1  1  0  0  1  0  104  121  1  0  0  0  0  0  0  0  0
     335  0  72  1  1  1  0  0  0  0  130   86  0  1  0  0  0  0  0  0  0
     343  0  49  0  1  0  0  0  1  0  112  112  0  1  0  0  0  0  0  0  0
     357  0  68  1  1  1  0  0  0  0  154   74  0  0  0  0  0  0  0  0  0
     362  0  82  0  1  1  0  1  1  0  130  131  0  1  0  0  0  0  0  0  0
     365  0  32  1  3  0  0  0  1  1  110  118  0  1  0  0  0  0  0  0  0
     369  0  78  1  1  1  0  0  1  0  126   96  0  1  0  0  0  0  0  0  0
     370  0  57  0  1  0  0  0  1  0  128  104  0  1  0  0  0  1  0  0  0
     371  0  46  1  1  1  1  0  0  0  132   90  0  1  0  0  0  0  0  0  0
     376  0  23  0  1  0  0  0  1  0  144   88  0  1  0  0  0  0  0  0  0
     378  0  55  0  1  0  0  0  0  0  132  112  0  1  0  0  0  0  0  0  0
     379  0  18  0  1  1  0  0  0  0  112   76  0  1  1  0  0  0  0  0  0
     381  0  20  0  1  1  0  0  0  0  164  108  0  1  0  0  0  0  0  0  0
     382  0  75  1  1  1  0  0  0  0  100   48  0  0  0  0  0  0  0  0  0
     398  0  79  0  1  1  0  0  1  0  112   67  0  0  0  0  0  0  0  0  0
     401  0  40  0  1  1  0  0  0  0  140   65  0  1  1  0  0  0  0  0  0
     409  0  76  0  1  1  0  0  1  0  110   70  0  1  0  0  0  0  0  0  0
     413  0  66  1  1  1  0  0  1  0  139   92  0  0  0  0  0  0  0  0  0
     416  0  76  0  1  0  0  0  1  0  190  100  0  1  0  0  0  0  0  0  0
     438  0  80  1  1  1  0  0  0  0  162   44  0  1  0  0  0  0  0  0  0
     439  0  23  1  1  0  0  0  1  0  120   88  0  1  0  0  0  0  0  0  0
     440  0  48  0  2  1  0  0  1  0   92  162  1  1  0  0  0  0  0  0  0
     455  0  67  0  2  1  0  0  0  0   90   92  1  0  0  0  0  0  0  0  0
     462  0  69  1  1  1  0  0  0  0  150   85  0  1  0  0  0  0  0  0  0
     495  0  65  0  3  1  0  0  0  0  208  124  0  0  0  0  0  0  0  0  0
     498  0  72  0  1  1  0  0  0  0  126   88  0  0  0  0  0  0  0  0  0
     502  0  55  0  1  0  0  0  0  0  190  136  0  1  0  1  1  1  0  0  0
     505  0  40  0  1  0  0  0  0  0  130   65  0  1  0  0  0  0  0  0  0
     508  0  55  1  1  0  0  0  1  0  110   86  0  1  0  0  0  0  0  0  0
     517  0  34  0  1  1  0  0  0  0  110   80  0  1  1  0  0  0  0  0  0
     522  0  47  1  1  1  0  0  0  0  132   68  0  1  0  0  0  0  0  0  0
     525  0  41  1  1  0  0  0  1  0  118  145  0  1  0  0  1  0  1  0  0
     526  0  84  1  1  0  0  1  1  0  100  103  0  1  0  0  0  0  1  1  0
     546  0  88  1  1  1  0  0  0  0  110   46  1  0  0  0  0  0  0  0  0
     548  0  77  1  1  1  1  0  0  0  212   87  0  0  0  0  0  1  0  0  0
     550  0  80  0  1  0  0  0  0  0  122  126  0  1  0  1  0  0  1  0  0
     552  0  16  0  1  1  0  0  0  0  100  140  0  1  1  0  0  0  0  0  0
     560  0  70  0  1  1  0  0  0  0  160   60  0  0  0  0  0  0  0  0  0
     563  0  83  1  1  1  0  0  1  0  138   91  0  1  0  0  0  0  0  0  0
     573  0  23  0  2  0  0  0  0  0  130   52  0  1  0  0  0  0  0  0  0
     575  0  67  1  1  0  0  0  0  1  120  120  0  1  0  0  1  1  0  0  0
     584  0  18  0  1  1  1  0  0  0  130  140  0  0  0  0  0  0  0  0  0
     597  0  77  1  1  0  0  0  1  0  136  138  0  0  0  1  1  1  0  0  0
     598  0  48  1  1  0  0  0  0  1  128   96  0  1  0  0  0  0  0  0  0
     601  0  24  1  2  0  0  0  0  0  140   86  0  1  0  0  0  0  0  0  0
     605  0  71  1  1  0  0  0  1  0  124  106  0  1  0  0  0  0  0  0  0
     607  0  72  0  1  1  0  0  0  0  134   60  0  1  0  0  0  0  0  0  0
     619  0  77  1  1  1  0  1  0  0  170  115  1  0  0  0  0  0  0  0  0
     620  0  60  0  1  1  0  0  1  0  124  135  0  1  0  0  0  0  0  0  0
     639  0  46  0  1  1  1  0  0  0  110  128  0  0  0  0  0  0  0  0  0
     644  0  65  1  1  0  0  0  0  0  100  105  0  1  0  0  0  0  0  0  0
     645  0  36  0  1  0  0  0  0  0  224  125  0  1  0  0  0  0  0  0  0
     648  0  68  0  1  1  0  0  0  0  112   64  0  0  0  0  0  0  0  0  0
     655  0  58  0  1  0  0  0  0  0  154   98  0  1  0  0  0  0  0  0  0
     659  0  76  1  1  0  0  0  1  0   92  112  0  1  0  0  0  0  0  0  0
     669  0  41  1  2  0  0  0  0  0  110  144  0  1  0  0  0  0  1  1  0
     670  0  20  0  3  0  0  0  0  0  120   68  0  1  0  0  0  0  0  0  0
     674  0  91  0  1  0  0  1  1  0  152  125  0  1  0  0  0  0  0  0  0
     675  0  75  0  1  1  0  0  0  0  140   90  0  1  0  0  0  0  0  0  0
     676  0  25  1  1  0  0  0  0  0  131  135  0  1  0  0  0  0  1  0  0
     709  0  70  0  1  0  0  0  1  0   78  143  0  1  0  1  0  0  0  0  0
     713  0  47  0  1  1  0  0  0  0  156  112  0  1  0  0  0  0  0  0  0
     727  0  75  0  3  1  0  0  0  0  144  120  0  1  0  0  0  0  0  1  0
     728  0  40  0  2  0  0  0  1  0  160  150  1  1  1  0  0  0  0  0  0
     732  0  71  0  1  0  0  0  1  0  148  192  0  1  0  1  1  1  0  0  0
     746  0  70  1  1  0  0  0  1  0   90  140  0  1  0  1  0  0  1  0  0
     749  0  58  0  1  1  0  0  0  0  148   95  1  1  0  0  0  0  0  0  0
     754  0  54  0  1  1  0  0  0  0  136   80  0  0  0  0  0  0  0  0  0
     761  0  77  0  1  1  0  0  0  0  128   59  0  0  0  0  0  0  0  0  0
     763  0  55  0  1  1  1  0  1  0  138  140  0  0  0  0  0  0  0  0  0
     764  0  21  0  1  1  0  0  0  0  120   62  0  1  0  0  0  0  0  0  0
     765  0  53  0  2  0  0  1  0  1  170  115  0  1  0  0  0  0  0  0  0
     766  0  31  1  1  0  1  1  1  1  146  100  0  1  0  0  1  1  0  0  0
     772  0  71  0  1  1  1  0  0  0  204   52  0  0  0  0  0  0  0  0  0
     776  0  49  0  2  0  0  0  0  0  150  100  0  1  0  0  0  0  0  0  0
     784  0  60  1  2  0  0  0  1  0  116   92  1  1  0  0  0  0  0  0  0
     794  0  50  0  1  0  0  0  1  0  156   99  0  1  0  1  0  1  0  0  0
     796  0  45  1  1  1  0  0  0  0  132  109  0  1  1  0  0  0  0  0  0
     809  0  21  0  1  1  0  0  0  0  110   90  0  1  0  0  0  0  0  0  0
     814  0  73  1  1  1  0  0  0  0  130   83  0  1  0  0  0  0  0  0  0
     816  0  28  0  1  1  0  0  1  0  122   80  1  0  1  0  0  0  0  0  0
     829  0  17  0  1  1  0  0  0  0  140   78  0  1  1  0  0  0  0  0  0
     837  0  17  1  3  0  0  0  0  0  130  140  0  1  0  0  0  0  0  0  0
     846  0  21  1  1  1  0  0  0  0  142   79  0  1  0  0  0  0  0  0  0
     847  0  68  1  1  1  1  0  0  0   91   79  0  0  0  0  0  0  0  0  0
     863  0  17  0  3  1  0  0  0  0  136   78  0  1  0  0  0  0  0  0  0
     867  0  60  0  1  0  0  0  1  0  108  120  0  1  0  0  0  0  0  0  0
     875  0  69  0  1  1  0  0  0  0  169   73  0  1  0  0  0  0  0  0  0
     877  0  88  1  1  0  0  1  0  0  190   88  0  1  0  0  0  0  0  0  0
     880  0  20  0  1  1  0  0  0  0  120   80  0  1  0  0  0  0  0  0  0
     881  0  89  1  1  1  0  0  0  0  190  114  0  1  0  0  0  1  0  0  2
     889  0  62  1  1  0  0  0  0  0  110   78  0  1  0  0  0  0  0  0  0
     893  0  46  0  1  0  0  1  1  0  142   89  0  1  0  0  1  0  1  0  0
     906  0  19  0  1  1  0  0  1  0  100  137  0  1  0  0  0  0  0  0  0
     912  0  71  0  1  0  0  0  1  0  124  124  0  1  0  1  1  1  0  0  0
     915  0  67  0  1  1  0  0  0  0  152   78  0  0  0  0  0  0  0  0  0
     923  0  20  0  1  1  0  0  0  0  104   83  0  1  0  0  0  0  0  0  0
     924  0  73  1  2  0  0  1  0  0  162  100  0  1  0  0  0  0  0  0  0
     925  0  59  0  1  0  0  0  0  0  100   88  0  1  0  0  0  0  0  0  0
     929  0  42  0  1  1  0  0  0  0  122   84  0  1  1  0  0  0  0  0  0
       4  1  87  1  1  1  0  0  1  0   80   96  0  1  1  1  1  1  0  0  0
      27  1  76  1  1  1  0  0  1  0  128   90  1  1  0  0  0  0  0  0  0
      47  1  78  0  1  0  0  0  1  0  130  132  0  1  0  0  0  0  1  0  0
      52  1  63  0  1  0  0  1  1  0  112  106  1  1  0  1  0  0  0  0  0
     127  1  19  0  1  1  0  0  0  0  140   76  0  1  0  0  0  0  0  0  0
     145  1  67  1  1  0  0  0  1  0   62  145  0  1  0  0  0  0  0  1  0
     154  1  53  1  1  0  0  0  1  0  148  128  0  1  0  0  1  1  0  0  0
     165  1  92  0  1  0  0  0  1  0  124   80  0  1  0  0  0  0  1  0  0
     195  1  57  0  1  0  0  0  1  1  110  124  0  1  0  0  0  0  0  0  2
     202  1  75  1  1  1  1  0  0  0  130  136  0  0  0  0  0  0  0  0  0
     204  1  91  0  1  0  0  0  1  0   64  125  0  1  0  0  0  1  0  0  0
     208  1  70  0  1  1  0  0  0  0  168  122  0  0  0  1  0  0  0  0  1
     222  1  88  0  1  0  0  0  1  1  141  140  0  1  0  0  0  0  0  0  0
     238  1  41  0  1  1  0  0  1  0  140   58  0  1  0  0  0  0  0  0  2
     241  1  61  0  1  0  0  0  0  0  140   81  0  1  0  0  0  0  0  0  0
     273  1  80  0  1  1  0  0  0  0  100   85  0  1  0  0  0  0  0  0  0
     285  1  40  0  1  0  0  0  1  0   86   80  1  1  0  0  0  0  0  0  0
     299  1  75  0  1  0  0  0  1  0   90  100  0  1  0  0  0  0  0  0  1
     331  1  63  1  1  1  0  1  1  1   36   86  0  1  1  0  0  0  0  1  2
     346  1  75  1  1  0  1  0  0  0  190   94  0  1  0  0  0  0  0  0  0
     380  1  20  0  1  1  0  0  0  0  148   72  0  1  1  0  0  0  0  0  0
     384  1  71  0  1  0  0  0  0  0  142   95  0  1  0  0  0  0  0  0  0
     412  1  51  1  1  1  0  0  1  0  134  100  1  1  0  0  0  0  0  0  1
     427  1  65  0  1  0  0  0  0  0   66   94  0  1  0  0  0  0  0  0  2
     442  1  69  1  3  0  0  1  0  0  170   60  1  1  0  1  0  0  0  0  0
     461  1  55  0  1  1  0  1  1  0  122  100  1  1  0  0  0  0  0  0  0
     468  1  50  1  1  1  1  0  0  0  120   96  0  1  0  0  0  0  0  0  0
     490  1  78  0  1  0  0  0  1  0  110   81  0  1  0  0  0  0  0  0  0
     518  1  71  1  1  0  0  0  0  1   70  112  0  1  0  0  0  0  0  0  2
     611  1  85  1  1  1  0  0  0  0  136   96  0  1  0  0  0  0  0  0  0
     613  1  75  0  1  0  0  1  1  0  130  119  0  1  0  0  1  0  1  1  0
     666  1  65  1  1  0  0  0  1  1  104  150  0  1  0  0  0  1  0  0  2
     671  1  49  0  1  0  0  0  1  1  140  108  0  1  0  0  0  0  1  0  0
     706  1  75  1  1  0  0  1  1  1  150   66  0  1  0  0  0  0  0  1  2
     740  1  72  1  1  0  0  0  0  0   90  160  0  1  0  0  0  0  0  0  0
     751  1  69  0  1  0  0  1  0  0   80   81  0  1  0  0  0  0  0  0  2
     752  1  64  0  1  0  1  0  1  0   80  118  0  1  0  1  0  0  0  1  0
     789  1  60  0  1  0  0  0  1  0   56  114  1  1  0  0  1  0  1  0  0
     871  1  60  0  3  1  0  1  1  0  130   55  0  1  0  0  0  0  0  0  1
     921  1  50  1  2  0  0  0  0  0  256   64  0  1  0  0  0  0  0  0  1
;
proc sort;
        by descending died age;
/*
  Name:  marital.sas
 Title:  Pre-marital sex, extra-marital sex, and divorce
Source:  Thornes and Collard 1979, Gilbert 1981
*/ 
data marital;
   input gender $ pre $ extra $ @;
        pre = 'Pre:' || pre;
        extra = 'X:' || extra;
   marital='Divorced';  input count @;  output;
   marital='Married';   input count @;  output;
cards;
Women  Yes  Yes   17   4
Women  Yes  No    54  25
Women  No   Yes   36   4
Women  No   No   214 322
Men    Yes  Yes   28  11
Men    Yes  No    60  42
Men    No   Yes   17   4
Men    No   No    68 130
;
proc sort;
        by marital extra pre gender;
title 'Lifeboats on the Titanic';
/* from the Board of Trade (1912)
        "Report on the Loss of the S.S. Titanic", p, 38
*/
proc format;
        value $side 'p'='Port'  's'='Starboard';
        value period 0='Early'  1='Middle'  2='Late';
        
data lifeboat;
        input  launch time5.2 side $ boat $ crew men women;
        total = sum(crew, men, women);
        format launch hhmm. side $side.;
        port = (side='p');
        int  = launch * port;
        select (boat);
                when ('C', 'D')  cap=47;
                when ('1', '2')  cap=40;
                otherwise        cap=65;
        end;
        label launch='Launch Time'
           side = 'Side'
                boat = 'Boat label'
                crew = 'Men of crew'
                men = 'Men passengers'
                women = 'Women and Children'
                cap = 'Boat capacity'
                total = 'Total loaded';
datalines;
 0:45  p  7   3  4  20
 0:55  p  5   5  6  30
 1:00  p  3  15 10  25
 1:10  p  1   7  3   2
 1:20  p  9   8  6  42
 1:25  p 11   9  1  60
 1:35  p 13   5  0  59
 1:35  p 15  13  4  53
 1:40  p  C   5  2  64
 0:55  s  6   2  2  24
 1:10  s  8   4  0  35
 1:20  s 10   5  0  50
 1:25  s 12   2  0  40
 1:30  s 14   8  2  53
 1:35  s 16   6  0  50
 1:45  s  2   4  1  21
 1:55  s  4   4  0  36
 2:05  s  D   2  2  40
;

proc rank out=lifeboat groups=3;
        var launch;
        ranks period;
        by side;
run;
/*
 Name:   lifeboa2.sas
 Title:  Lifeboats on the Titanic- data set 2
 Source: Extracted from the Encyclopedia Titanica Web Site 
              http://atschool.eduweb.co.uk/phind
1. Boat (1 to 16, and four collapsible boats, A to D)
2. Launch (rank order of departing from Titanic)
3. Side (side of Titanic boat was launched from)
4. Males (just of the passengers, not including servants or crew)
5. Females (same as 4.)
6. First (first class passengers and their servants)
7. Second (second class passengers and their servants)
8. Third (third class passengers)
9. Crew
10. Other (number of lifeboat occupants (6+7+8+9) that got onto the
  lifeboat by other means, e.g. stowaway, pulled from water, jumped etc.)
11. Launch (reported launch time)
*/

proc format;
        value $side 'p'='Port'  's'='Starboard';
data lifeboa2;
        input boat $ order side $ men women class1-class3 crew other
              launch time5.2;
        format launch hhmm. side $side.;
        total=sum(of class1-class3 crew);
        label launch='Launch Time'  order='Launch order'
                boat = 'Boat label'      side='Side'
                men = 'Men passengers'   women = 'Women and Children'
                class1 = '1st Class passengers'  class2='2nd Class passengers'
                class3 = '3rd Class passengers'  other ='Other lifeboat occupants'
                crew = 'Men of crew'
                cap = 'Boat capacity'    total = 'Total loaded';
        port = (side='p');
        select (boat);
                when ('C', 'D')  cap=47;
                when ('1', '2')  cap=40;
                otherwise        cap=65;
        end;
cards; 
 1   5 s   3  1   5  0  0  7 0  1:10
 2  15 p   3  9   8  0  6  4 0  1:45
 3   4 s  11  8  26  0  0 13 0  1:00
 4  16 p   3 16  24  2  0 12 9  1:50
 5   2 s  13 14  27  0  0  8 2  0:55
 6   3 p   2 16  19  0  1  4 1  0:55
 7   1 s  13 12  24  1  0  3 0  0:45
 8   5 p   0 17  23  0  0  4 0  1:10
 9  10 s   9 16   6 17  3 15 0  1:30
10   7 p   5 28   9 18  6  4 0  1:20
11  12 s   7 16   6 14  5 26 0  1:35
12  10 p   1 18   0 17  2  3 1  1:30
13  13 s  15 24   1 12 26 24 2  1:40
14   8 p  10 23   5 21  7  9 4  1:25
15  13 s  23 15   1  1 36 25 0  1:40
16   . p   2 23   0  3 22 12 0  1:35
 A   . s   9  2   3  0  8  5 0  .
 B   . p  10  0   3  1  6 18 0  .
 C  17 s  13 25   2  0 36  6 4  1:40
 D   . s   6 13   8  2  9  5 3  2:05
;
/*
Title:  Mental impariment and parents SES
Source: Haberman, 1979 [p.375], from Srole etal,(1978) p.289
        also, Agresti:90, Lindsey p.99;  
*/
proc format;
        value mental 1='Well' 2='Mild' 3='Moderate' 4='Impaired'; 
        value ses    1='High' 2='2' 3='3' 4='4' 5='5' 6='Low';   
data mental;
   input ses mental count @@;
        label ses="Parents SES"
           mental='Mental Impairment';
cards;
1  1  64   1  2  94   1  3  58   1  4  46
2  1  57   2  2  94   2  3  54   2  4  40
3  1  57   3  2 105   3  3  65   3  4  60
4  1  72   4  2 141   4  3  77   4  4  94
5  1  36   5  2  97   5  3  54   5  4  78
6  1  21   6  2  71   6  3  54   6  4  71
;
*newsas(msdiag);
/*-------------------------------------------------------------------------*
Title:    Diagnosis of multiple sclerosis
Diagnostic classification of mulitiple sclerosis by two neurologists
for two populations.
Source:   Landis, J.R. & Koch, G.G. (1977) "The measurement of observer
          agreement for categorical data." Biometrics 33: 159-174
*--------------------------------------------------------------------------*/
proc format;
     value rating 1="Certain MS" 2="Probable" 3="Possible" 4="Doubtful MS";
data msdiag;
     do patients='Winnipeg  ', 'New Orleans';
        do N_rating = 1 to 4;
           do W_rating = 1 to 4;
              input count @;
              output;
              end;
           end;
        end;
   format N_rating W_rating rating.;
   label N_rating = 'New Orleans neurologist'
         W_rating = 'Winnipeg nurologist';
cards;
38  5  0  1
33 11  3  0
10 14  5  6
 3  7  3 10
 5  3  0  0
 3 11  4  0
 2 13  3  4
 1  2  4 14
;

*-- Agreement, separately, and conrolling for Patients;
proc freq data=msdiag;
     weight count;
     tables patients * N_rating * W_rating / norow nocol nopct agree;
run;
/*
  Title:  NASA space shuttle O-ring failures
  Source: Table 1, Dalal etal, JASA 1989, 84, 945-957, field joint data;
          Damage index from Tufte 1997.
*/
data orings;
        flt_num = _n_;
        input flight $ temp pressure fail failures damage;
        orings = 6;
        label temp='Temperature'  pressure='Leak check pressure'
                fail = 'Any failure?'  failures='Number of O-ring failures'
                damage = 'Damage index';
cards;
  1   66    50   0   0   0
  2   70    50   1   1   4
  3   69    50   0   0   0
  4   80    50   .   .   .
  5   68    50   0   0   0
  6   67    50   0   0   0
  7   72    50   0   0   0
  8   73    50   0   0   0
  9   70   100   0   0   0
41B   57   100   1   1   4
41C   63   200   1   1   2
41D   70   200   1   1   4
41G   78   200   0   0   0
51A   67   200   0   0   0
51C   53   200   1   2  11
51D   67   200   0   0   0
51B   75   200   0   0   0
51G   70   200   0   0   0
51F   81   200   0   0   0
51I   76   200   0   0   0
51J   79   200   0   0   0
61A   75   200   1   2   4
61C   58   200   1   1   4
61I   76   200   0   0   4
;
title 'Suicide Rates by Age, Sex and Method';
data suicide0;
   input sex $1 age poison cookgas toxicgas hang drown gun knife
                    jump other;
   length sexage $ 4;
   sexage=trim(sex)||trim(left(put(age,2.)));
cards;
M 10     4   0   0  247   1  17   1   6   0
M 15   348   7  67  578  22 179  11  74 175
M 20   808  32 229  699  44 316  35 109 289
M 25   789  26 243  648  52 268  38 109 226
M 30   916  17 257  825  74 291  52 123 281
M 35  1118  27 313 1278  87 293  49 134 268
M 40   926  13 250 1273  89 299  53  78 198
M 45   855   9 203 1381  71 347  68 103 190
M 50   684  14 136 1282  87 229  62  63 146
M 55   502   6  77  972  49 151  46  66  77
M 60   516   5  74 1249  83 162  52  92 122
M 65   513   8  31 1360  75 164  56 115  95
M 70   425   5  21 1268  90 121  44 119  82
M 75   266   4   9  866  63  78  30  79  34
M 80   159   2   2  479  39  18  18  46  19
M 85    70   1   0  259  16  10   9  18  10
M 90    18   0   1   76   4   2   4   6   2
F 10    28   0   3   20   0   1   0  10   6
F 15   353   2  11   81   6  15   2  43  47
F 20   540   4  20  111  24   9   9  78  47
F 25   454   6  27  125  33  26   7  86  75
F 30   530   2  29  178  42  14  20  92  78
F 35   688   5  44  272  64  24  14  98 110
F 40   566   4  24  343  76  18  22 103  86
F 45   716   6  24  447  94  13  21  95  88
F 50   942   7  26  691 184  21  37 129 131
F 55   723   3  14  527 163  14  30  92  92
F 60   820   8   8  702 245  11  35 140 114
F 65   740   8   4  785 271   4  38 156  90
F 70   624   6   4  610 244   1  27 129  46
F 75   495   8   1  420 161   2  29 129  35
F 80   292   3   2  223  78   0  10  84  23
F 85   113   4   0   83  14   0   6  34   2
F 90    24   1   0   19   4   0   2   7   0
;
*title 'Suicide rates in Germany'; 
data suicide;
        input sex $ age $ @;
        do method = 'Poison', 'Gas', 'Hang', 'Drown', 'Gun', 'Jump';
                input count @;
                output;
                end;
        input;
cards;
    M  10-20     1160     335    1524      67     512     189
    M  25-35     2823     883    2751     213     852     366
    M  40-50     2465     625    3936     247     875     244
    M  55-65     1531     201    3581     207     477     273
    M  70-90      938      45    2948     212     229     268

    F  10-20      921      40     212      30      25     131
    F  25-35     1672     113     575     139      64     276
    F  40-50     2224      91    1481     354      52     327
    F  55-65     2283      45    2014     679      29     388
    F  70-90     1548      29    1355     501       3     383
;
title 'Survival on the Titanic';

proc format;
  value class 1='1st' 2='2nd' 3='3rd' 4='crew';
  value age   0='Child' 1='Adult';
  value sex   0='Female' 1='Male';
  value surv  1='Survived' 0='Died';

data titanic;
        input survive  age  sex  @;
        format age age. class class. sex sex. survive surv.;
        do class = 1 to 4;
                input count @;
                output;
                end;
cards;
1   1    1         57        14        75       192
1   1    0        140        80        76        20
1   0    1          5        11        13         0
1   0    0          1        13        14         0
0   1    1        118       154       387       670
0   1    0          4        13        89         3
0   0    1          0         0        35         0
0   0    0          0         0        17         0
;
title 'Womens labor-force participation, Canada 1977';
/*
Source: Social Change in Canada Project, York Institute for
Social Research.
*/

proc format;
   value labor    /* labor-force participation */
      1 ='working full-time'
      2 ='working part-time'
      3 ='not working';
   value kids     /* presence of children in the household */
      0 ='Children absent'
      1 ='Children present';
   value region   /* region of Canada */
      1 ='Atlantic Canada'
      2 ='Quebec'
      3 ='Ontario'
      4 ='Prairie provinces'
      5 ='British Columbia';

data wlfpart;
   input case labor husinc children region @@;
   working = labor < 3;
   if working then
      fulltime = (labor = 1);
   /* dummy variables for region */
   r1 = (region=1);
   r2 = (region=2);
   r3 = (region=3);
   r4 = (region=4);
        label husinc="Husband's Income";
cards;
  1  3  15  1  3    2  3  13  1  3    3  3  45  1  3    4  3  23  1  3
  5  3  19  1  3    6  3   7  1  3    7  3  15  1  3    8  1   7  1  3
  9  3  15  1  3   10  3  23  1  3   11  3  23  1  3   12  1  13  1  3
 13  3   9  1  4   14  3   9  1  4   15  3  45  1  1   16  3  15  1  1
 17  3   5  1  3   18  3   9  1  3   19  3  13  1  3   20  3  13  0  3
 21  2  19  0  3   22  3  23  1  4   23  1  10  0  4   24  1  11  0  3
 25  3  23  1  3   26  3  23  1  3   27  3  19  1  3   28  3  19  1  3
 29  3  17  1  4   30  1  14  1  4   31  3  13  1  3   32  3  13  1  3
 33  3  15  1  3   34  3   9  0  3   35  3   9  0  3   36  3  19  0  3
 37  3  15  1  3   38  1  20  0  3   39  3   9  1  1   40  2   6  0  1
 41  3   9  1  5   42  2   4  1  3   43  2  28  0  3   44  3  23  1  3
 45  2   5  1  3   46  3  28  1  3   47  3   7  1  3   48  3   7  1  3
 49  3  23  1  4   50  1  15  0  4   51  2  10  1  4   52  2  10  1  4
 53  3   9  0  3   54  3   9  0  3   55  2   9  1  1   56  3  17  0  1
 57  3  23  1  1   58  3  23  1  1   59  3   9  1  3   60  3   9  1  3
 61  1   9  0  3   62  1  28  0  3   63  2  10  1  3   64  2  23  0  4
 65  3  11  1  4   66  3  15  1  3   67  3  15  1  3   68  3  19  1  3
 69  3  19  1  3   70  3  23  1  3   71  3  17  1  3   72  3  17  1  3
 73  3  17  1  3   74  3  17  1  3   75  3  17  1  3   76  2  38  1  3
 77  2  38  1  3   78  3   7  1  1   79  3  19  1  4   80  2  19  1  5
 81  1  13  0  3   82  2  15  1  3   83  1  17  1  3   84  1  17  1  3
 85  2  23  1  3   86  1  27  0  5   87  1  16  1  5   88  1  27  0  3
 89  3  35  0  3   90  3  35  0  3   91  3  35  0  3   92  2   9  1  3
 93  2   9  1  3   94  2   9  1  3   95  3  13  1  3   96  3  17  1  3
 97  3  17  1  3   98  1  15  0  3   99  1  15  0  3  100  3  15  1  3
101  1  11  0  1  102  3  23  1  1  103  3  15  1  1  104  3  15  0  5
105  2  12  0  5  106  2  12  0  5  107  3  13  1  4  108  3  19  1  3
109  3  19  1  1  110  3   3  1  1  111  3   9  1  1  112  1  17  1  1
113  3   1  1  1  114  3   1  1  1  115  2  13  1  4  116  3  13  1  4
117  3  19  0  5  118  3  19  0  5  119  1  15  0  5  120  2  30  1  3
121  3   9  1  1  122  3  23  1  1  123  1   9  0  3  124  1   9  0  3
125  3  13  1  4  126  2  13  1  3  127  3  17  1  1  128  2  13  1  4
129  2  13  1  4  130  2  19  1  3  131  2  19  1  3  132  3   3  1  3
133  1  14  0  3  134  1  14  0  3  135  1  11  1  3  136  1  11  1  3
137  2  14  1  3  138  3  13  1  3  139  3  28  1  3  140  3  28  1  3
141  3  14  1  3  142  3  14  1  3  143  3  11  1  4  144  3  13  1  4
145  3  13  1  4  146  2  11  1  1  147  2  11  1  1  148  3  19  1  5
149  1   6  0  5  150  3  28  0  5  151  1  13  0  5  152  1  13  0  5
153  3   5  0  5  154  2  28  1  5  155  2  11  1  5  156  3  23  1  5
157  2  15  1  5  158  3  13  1  5  159  1  22  0  3  160  1  15  0  3
161  3  15  1  3  162  3  15  1  1  163  1   5  1  1  164  1   1  0  4
165  1   1  0  4  166  3   9  1  1  167  3  15  1  3  168  1  13  0  3
169  3  19  1  1  170  2   8  1  5  171  1   7  1  4  172  3  19  1  3
173  3   7  1  3  174  1   9  0  3  175  1   9  0  3  176  1  24  0  3
177  3  15  1  3  178  1  13  0  3  179  3  13  0  5  180  1  13  0  5
181  1  17  1  1  182  1  16  0  1  183  1  18  0  3  184  1  18  0  3
185  3  13  0  3  186  2  15  1  5  187  3  13  1  5  188  3   7  1  5
189  1   9  1  1  190  3  23  1  5  191  3  17  1  4  192  3  15  1  5
193  3  11  1  4  194  3  17  1  4  195  3  17  1  4  196  1   5  1  4
197  1   5  1  4  198  3  26  1  3  199  1  10  0  2  200  1  11  0  2
201  1  20  1  2  202  3  13  1  2  203  3  15  1  2  204  3  28  1  2
205  2   9  1  2  206  3  19  1  2  207  3  11  1  2  208  1  11  0  2
209  3   9  1  2  210  1  10  0  2  211  3  19  1  2  212  3  13  1  2
213  1   3  0  2  214  3  15  1  2  215  3  15  1  2  216  2  17  1  2
217  3   7  1  2  218  2  15  0  2  219  3  19  1  2  220  1  16  0  2
221  3   5  0  2  222  3  11  1  2  223  3  11  1  2  224  3  19  1  2
225  3  15  1  2  226  3  15  1  2  227  3  11  1  2  228  1   5  0  2
229  2  23  1  2  230  2  23  1  2  231  3   7  1  2  232  3  13  1  2
233  1  15  0  2  234  1   5  0  2  235  3   7  1  2  236  1   6  0  2
237  1   5  1  2  238  1   5  1  2  239  3  13  1  2  240  3  13  1  2
241  3  13  1  2  242  3  13  0  2  243  3  17  1  2  244  1   6  1  2
245  3   5  1  2  246  2  19  1  2  247  1   3  1  2  248  3  23  0  2
249  3  23  0  2  250  1  15  0  2  251  3  11  0  2  252  3  23  0  2
253  3  13  1  2  254  2  23  1  2  255  1  11  0  2  256  3   9  0  2
257  1   2  0  2  258  3  15  1  2  259  3  15  0  2  260  3  15  1  2
261  3  11  1  2  262  3  11  0  2  263  3  15  1  2  
;
/*
  Name:  vision.sas
 Title:  Visual acuity in left and right eyes
Source:  Kendall and Stuart 1961 [Tables 33.2, 33.5]
*/

data women;
        input right left count @@;
        cards;
1 1 1520    1 2  266    1 3  124    1 4  66
2 1  234    2 2 1512    2 3  432    2 4  78
3 1  117    3 2  362    3 3 1772    3 4 205
4 1   36    4 2   82    4 3  179    4 4 492
;

data men;
        input right left count @@;
        cards;
1 1  821    1 2 112    1 3  85    1 4  35
2 1  116    2 2 494    2 3 145    2 4  27
3 1   72    3 2 151    3 3 583    4 4  87
4 1   43    4 2  34    4 3 106    4 4 331
;
*-- Join the two data sets;
data vision;
        set women (in=w)
            men   (in=m);
        if w then gender='F';
                  else gender='M';
title  'Race and Politics in the 1980 Presidential vote';
proc format;
  value race 0='NonWhite'
             1='White';
data vote;
        input @10 race cons @;
        do votefor='Reagan', 'Carter';
                input count @;
                output;
                end;
cards;
White    1 1    1   12
White    1 2   13   57
White    1 3   44   71
White    1 4  155  146
White    1 5   92   61
White    1 6  100   41
White    1 7   18    8
NonWhite 0 1    0    6
NonWhite 0 2    0   16
NonWhite 0 3    2   23
NonWhite 0 4    1   31
NonWhite 0 5    0    8
NonWhite 0 6    2    7
NonWhite 0 7    0    4
;
title 'von Bortkiewicz data';
data vonbort;
   input year @;
   do corps = 1 to 14;
      input deaths @;
      output;
      end;
/*  1 2  3  4   5 6  7  8    9  10 11 12 13 14 */
/*  G I II III IV V VI VII VIII IX X XI XIV XV */
cards;
75  0  0  0  0  0  0  0  1  1  0  0  0  1  0
76  2  0  0  0  1  0  0  0  0  0  0  0  1  1
77  2  0  0  0  0  0  1  1  0  0  1  0  2  0
78  1  2  2  1  1  0  0  0  0  0  1  0  1  0
79  0  0  0  1  1  2  2  0  1  0  0  2  1  0
80  0  3  2  1  1  1  0  0  0  2  1  4  3  0
81  1  0  0  2  1  0  0  1  0  1  0  0  0  0
82  1  2  0  0  0  0  1  0  1  1  2  1  4  1
83  0  0  1  2  0  1  2  1  0  1  0  3  0  0
84  3  0  1  0  0  0  0  1  0  0  2  0  1  1
85  0  0  0  0  0  0  1  0  0  2  0  1  0  1
86  2  1  0  0  1  1  1  0  0  1  0  1  3  0
87  1  1  2  1  0  0  3  2  1  1  0  1  2  0
88  0  1  1  0  0  1  1  0  0  0  0  1  1  0
89  0  0  1  1  0  1  1  0  0  1  2  2  0  2
90  1  2  0  2  0  1  1  2  0  2  1  1  2  2
91  0  0  0  1  1  1  0  1  1  0  3  3  1  0
92  1  3  2  0  1  1  3  0  1  1  0  1  1  0
93  0  1  0  0  0  1  0  2  0  0  1  3  0  0
94  1  0  0  0  0  0  0  0  1  0  1  1  0  0
;
data vonbort2;
        set vonbort;
        where corps not in (1,2,7,12);

proc freq data=vonbort2;
        tables deaths / out=horskick;
arthrit.sas     Arthritis treatment data
berkeley.sas    Berkeley Admissions data
chi2tab.sas     Generate a Chi-Square table
haireye.sas     Hair - Eye color data
icu.sas The ICU data
lifeboa2.sas    Lifeboats on the Titanic- data set 2
lifeboat.sas    Lifeboats on the Titanic
marital.sas     Pre-marital sex, extra-marital sex, and divorce
mental.sas      Mental impariment and parents SES
msdiag.sas      Diagnosis of multiple sclerosis
orings.sas      NASA space shuttle O-ring failures
suicide.sas     Suicide rates in Germany
suicide0.sas    Suicide Rates by Age, Sex and Method
titanic.sas     Survival on the Titanic
vietnam.sas     Student opinion about the war in Vietnam
vision.sas      Visual acuity in left and right eyes
vonbort.sas     von Bortkiewicz data
vote.sas        Race and Politics in the 1980 Presidential vote
wlfpart.sas     Womens labor-force participation, Canada 1977
/*
  Name:  vietnam.sas
 Title:  Student opinion about the war in Vietnam
 
From Aitken-etal:89  ``Statistical Modelling in GLIM''.
A survey of student opinion on the Vietnam War was taken at the
University of North Carolina at Chapel Hill in May 1967 and published
in the student newspaper. Students were asked to fill in ballot
papers stating which policy out of A,B,C or D they supported.
Responses were cross-classified by gender/year:

Responses:
  1 -- defeat North Vietnam by widespread bombing and land invasion
  2 -- follow the present policy
  3 -- withdraw troops to strong points and open negotiations on elections involving the Viet Cong
  4 -- immediate withdrawal of all U.S. troops
*/

proc format;
        value resp   1='Defeat North Vietnam'  2='Present policy'
                     3='Negotiate'             4='Immediate withdrawal';
        value letter 1='A'  2='B'  3='C'  4='D';
        value yr     1='Freshmen'  2='Sophomore'  3='Junior'
                     4='Senior'    5='Grad student';
        value $sex  'M'='Male'    'F'='Female';

data vietnam;
        do sex = 'F', 'M';
                do year = 1 to 5;
                        do response = 1 to 4;
                                input count @;
                                output;
                                end;
                        end;
                end;
        label year= 'Year of Study'
              sex = 'Sex';
cards;
 13  19  40   5  
  5   9  33   3  
 22  29 110   6  
 12  21  58  10  
 19  27 128  13  
175 116 131  17  
160 126 135  21  
132 120 154  29  
145  95 185  44  
118 176 345 141  
;
title 'Generate a Chi-Square table';
options ls=110;
%let df=  1 to 20,
         25 to 50 by 5,
         60 to 100 by 10,
        200 to 400 by 50;
%let np=12;   %*-- Number of p-values;
%let pvalue=.25 .10 .09 .08 .07 .06 .05 .025 .01 .005 .0025 .001;
%let divisor = 1;     *-- Chi-square values;
*let divisor = df;    *-- Chi-square / df values;

data chisq;
        array pr(*) p1-p&np   (&pvalue); 
        keep df p c;
        label p='Upper Tail Prob'
                        df='df';
   do k = 1 to dim(pr);        /* for each P-value */
                p = 100*pr(k);
                do df = &df;
         c = cinv(1-pr(k), df) / &divisor;
                        output;
         end;
      end;

proc sort;
        by df;
proc transpose out=chi2tab;
        by df; var c;

%*-- Generate variable labels;
%macro lab(k, prefix, values);
        %do i=1 %to &k;
                &&prefix.&i = "%scan(&values,&i,%str( ))"
                %end;
%mend;

proc format;
        picture cvalue low-<100  = '00.00'
                            100-high  = '000.0';
data chi2tab;
        set chi2tab;
        drop _name_;
        format col1-col&np cvalue. df 4.;
        label   %lab(&np, COL, &pvalue);
proc print label;
        id df;
*snip;
*sas2tex(data=chi2prob, 
        id=df, var=col1-col12,
        texalone=Y, tabenv=\small);
/*-------------------------------------------------------------------*
  *    Name: addvar.sas                                               *
  *   Title: Added variable plots for logistic regression             *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/addvar.html             *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *
  * Created: 15 Apr 98 11:16                                          *
  * Revised:  6 Nov 2000 13:04:16                                     *
  * Version: 1.1                                                      *
  *  1.1   Fixed validvarname for V7+                                 *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------*/
 /*Description:
 
 The ADDVAR macro produces added variable plots (TYPE=AVP) for the
 effect of adding a variable to a logistic regression model, or a
 constructed variable plot (TYPE=CVP) for the effect of transforming
 a variable.
 
 For a model with a binary response, Y, and predictors in the list
 X, an added variable plot may be constructed for a new predictor,
 Z, by plotting the residuals of Y given X against the residuals
 of Z given X.  A linear relation in this plot indicates that Z
 should be included in the model, but observations with extreme
 Z-residuals would be highly influential in this decision.  A line
 fitted to this plot should have an intercept approximately zero,
 and a slope approximating the coefficient of Z in the full model.

 The constructed variable plot is designed to detect nonlinear dependence
 of Y on one of the X variables, say X[j].  It is an added variable
 plot for the constructed variable, Z = X[j] log X[j].
 
 Usage:

 The addvar macro is called with keyword parameters.  The X=, Y=,
 and Z= parameters must be specified.  A TRIALS= variable may be
 specified if the data are in events/trials form.  The arguments
 may be listed within parentheses in any order, separated by commas.
 For example:
 
        %addvar(data=icu, y=Died,  x=age admit cancer uncons, z=Systolic,
                id=patient, loptions=order=data noprint);

 This gives an AVP for the variable Systolic, when added to the X=
 variables in the model predicting Y=DIED.
 
Parameters:

* DATA=   Specifies the name of the input data set to be analyzed.
              [Default: DATA=_LAST_]

* Y=              Specifies the name of the response variable.

* TRIALS=     Name of trials variable for event/trial

* X=              Specifies the names of the predictor variables in the model

* Z=          Name of the added variable

* ID=         Name of observation ID variable (char)

* LOPTIONS=   Options for PROC LOGISTIC [Default: LOPTIONS=NOPRINT]

* SMOOTH=     Lowess smoothing parameter [Default: SMOOTH=0.5]

* SUBSET=     Subset of points to label [Default: SUBSET=ABS(STUDRES)>2]

* OUT=        Specifies the name of the output data set [Default: OUT=_RES_]

* SYMBOL=     Plotting symbol for points [Default: SYMBOL=DOT]

* INTERP=     Interpolation options for points [Default: INTERP=RL CI=RED]

* TYPE=       Type of plot: AVP or CVP [Default: TYPE=AVP]

* NAME=       Name of graph in graphic catalog [Default: NAME=ADDVAR]

* GOUT=       Name of the graphics catalog

*/
 
%macro addvar(
        data=_last_,       /* Name of input data set                  */
        y=,                /* Name of response variable               */
        trials=,           /* Name of trials variable for event/trial  */
        x=,                /* Names of predictors                     */
        z=,                /* Name of the added variable              */
        id=,               /* Name of observation ID variable (char)  */
        loptions=noprint,  /* options for PROC LOGISTIC               */
        smooth=0.5,        /* lowess smoothing parameter              */
        subset=abs(studres)>2,   /* subset of points to label         */
        out=_res_,         /* output data set                         */
        symbol=dot,        /* plotting symbol for points              */
        interp=rl ci=red,  /* interpolation options for points        */
        type=AVP,          /* Type of plot: AVP or CVP                */
        name=addvar,       /* Name of graph in graphic catalog        */
        gout=
        );
          
        %*-- Reset required global options;
        %if &sysver >= 7 %then %do;
                %local o1 o2;
                %let o1 = %sysfunc(getoption(notes));
                %let o2 = %sysfunc(getoption(validvarname,keyword));
                options nonotes validvarname=V6;
                %end;
        %else %do;
           options nonotes;
                %end;

%let type=%upcase(&type);

%let abort=0;
%if %length(&y)=0 | %length(&x)=0
   %then %do;
      %put ERROR: The Y= and X= variables must be specified;
      %let abort=1;
      %goto DONE;
   %end;


*-- Fit the original model, get fit quantities in an ODS;
proc logistic nosimple data=&data &loptions outest=parms;
        %if %length(&trials)=0 %then %do;
           model &y         = &x;
                %end;
        %else %do;
           model &y/&trials = &x;
                %end;
   output out=_diag_ pred=p
                        difdev=difdev difchisq=difchisq c=c cbar=cbar h=h
                        resdev=resdev reschi=reschi;

proc print;
%let zl=&z Residual;
%if &type=CVP %then %do;
        *-- protect against negative values;
        proc univariate data=_diag_ noprint;
                var &z;
                output out=_min_ min=min;
        data _diag_;
                set _diag_;
                if _n_=1 then do;
                        set _min_(keep=min);
                        set parms(rename=(&z = beta));
                        end;
*               _z_ = beta * &z * log(&z);
                _z_ =  &z * log(&z);
        %let zl = Constructed &z*log(&z) Residual;
        %let z = _z_;
        %end; 

data _diag_;
   set _diag_;
   label h = 'Leverage (Hat value)'
                        studres = 'Studentized deviance residual';
   format h 3.2;
        studres = resdev / sqrt(1-h);
        drop p n;
        %if %length(&trials)=0 %then %do;
                n=1;
                %end;
        %else %do;
                n=&trials;
                %end;
        yhat = n * p;
        weight = n * p * (1-p);

proc reg data=_diag_ noprint;
        weight weight;
        model &z = &x;
        output out=&out r=zres;

*-- Find slope and intercept in the plot;               
proc reg data=&out outest=_parm_;
*       weight weight;
        model reschi = zres;

data &out;
        set &out;
        zres = zres * sqrt(weight);
        label zres="&zl"
                reschi = "&y Residual";

proc print data=&out;
        %if %length(&id) %then %do;
                id &id;
                %end;
        var &y &trials &x h reschi resdev studres zres;
        format resdev reschi studres zres 6.3;

%label(data=&out, x=zres, y=reschi, text=&id, out=_labels_, pos=-,
        subset=&subset);

*-- Label plot with slope value;
data _parm_;
        set _parm_(keep=zres);
   xsys='1'; ysys='1';
   length text $14 function $8;
   x = 2;   y=4; position='F';
   function = 'LABEL'; color='red';
   text = 'Slope: ' || left(put(zres,7.3));  output;
        %if &type=CVP %then %do;
        power = round(1+zres, 0.5);
        position='C';
   text = 'Power: ' || left(put(power,9.1));  output;
                %end;

data _cross_;
        xsys='2'; ysys='2'; color='red';
        x =0; y=0;  function='move'; output;
        xsys='7';  x= -5; function='draw'; output;
        xsys='7';  x=+10; function='draw'; output;
        xsys='2';  x=  0; function='move'; output;
        ysys='7';  y= -5; function='draw'; output;
        ysys='7';  y=+10; function='draw'; output;

data _labels_;
        length text $14;
        set _labels_ _parm_ _cross_;

%if &smooth>0 %then %do;
        %lowess(data=&out, x=zres, y=reschi, gplot=NO, pplot=NO,
                outanno=_smooth_, silent=YES, f=&smooth, line=20);
        
        data _labels_;
                set _labels_ _smooth_;
        %end;

proc gplot data=&out;
        plot reschi * zres / 
                anno=_labels_ vaxis=axis1 frame vm=1 hm=1
                name="&name" des="Added variable plot for &z in &data";
        symbol1 v=&symbol c=black i=&interp;
        axis1 label=(a=90) offset=(2);
run; quit;
%done:
        %*-- Restore global options;
        %if &sysver >= 7 %then %do;
                options &o1 &o2;
                %end;
        %else %do;
           options notes;
                %end;

%mend;

/*-------------------------------------------------------------------*
  *    Name: dummy.sas                                                *
  *  Title:  Macro to create dummy variables                          *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/dummy.html              *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *
  * Created: 03 Feb 98 11:32                                          *
  * Revised: 06 Aug 98 17:12                                          *
  * Version: 1.2                                                      *
  * 1.1  Added FULLRANK parameter                                     *
  * 1.2  Now handles multiple VARiables                               *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------*/
 /*Description:

 Given a character or discrete numerical variable, the DUMMY macro creates
 dummy (0/1) variables to represent the levels of the original variable
 in a regression model.  If the original variable has c levels, (c-1)
 new variables are produced (or c variables, if FULLRANK=0)
 
Usage:

 The DUMMY macro takes the following named parameters.  The arguments
 may be listed within parentheses in any order, separated by commas.
 For example:
 
   %dummy(var=sex group,prefix=);

 
Parameters:

* DATA=    The name of the input dataset.  If not specified, the most
           recently created dataset is used.
* OUT=     The name of the output dataset.  If not specified, the new
           variables are appended to the input dataset.
* VAR=     The name(s) of the input variable(s) to be dummy coded.  Must be
           specified.  The variable(s) can be character or numeric.
* PREFIX=  Prefix(s) used to create the names of dummy variables.  The
           default is 'D_'.  
* NAME=    If NAME=VAL, the dummy variables are named by appending the
           value of the VAR= variable to the prefix.  Otherwise, the
                          dummy variables are named by appending numbers, 1, 2, ...
                          to the prefix.  The resulting name must be 8 characters or
                          less.
* BASE=    Indicates the level of the baseline category, which is given
           values of 0 on all the dummy variables.  BASE=_FIRST_ 
                          specifies that the lowest value of the VAR= variable is the
                          baseline group; BASE=_LAST_ specifies the highest value of
                          the variable.  Otherwise, you can specify BASE=value to
                          make a different value the baseline group.
* FULLRANK=  0/1, where 1 indicates that the indicator for the BASE category
           is eliminated.  

Example:

 With the input data set,
 
  data test;
    input y group $ @@;
   cards;
   10  A  12  A   13  A   18  B  19  B  16  C  21  C  19  C  
   ;

 The macro statement:

         %dummy ( data = test, var = group) ;

 produces two new variables, D_A and D_B.  Group C is the baseline
 category (corresponding to BASE=_LAST_)

                OBS     Y    GROUP    D_A    D_B
                        1     10      A       1      0
                        2     12      A       1      0
                        3     13      A       1      0
                        4     18      B       0      1
                        5     19      B       0      1
                        6     16      C       0      0
                        7     21      C       0      0
                        8     19      C       0      0

*/
 
%macro dummy( 
        data=_last_ ,    /* name of input dataset */
        out=&data,       /* name of output dataset */
        var= ,           /* variable to be dummied */
        base=_last_,     /* base category */
        prefix = D_,     /* prefix for dummy variable names */
        name  = VAL,     /* VAL: variable names are D_value */
        fullrank=1 
        );

   %if (%length(&var) = 0) %then %do;
       %put ERROR: DUMMY: VAR= must be specified;
       %goto done;
       %end;

%let abort = 0;
%let base = %upcase(&base);
%let name = %upcase(&name);

%if %upcase(&data) = _LAST_ %then %let data = &syslast;
%if %upcase(&data) = _NULL_ %then %do;
        %put ERROR: There is no default input data set (_LAST_ is _NULL_);
        %goto DONE;
        %end;
        
%let prefix = %upcase(&prefix);

%local j vari;
%let j=1;
%let vari= %scan(&var,    &j, %str( ));
%let pre = %scan(&prefix, &j, %str( ));

options nonotes;

%if &out ^= &data %then %do;
        data &out;
                set &data;
        %end;
        
%do %while(&vari ^= );

*-- determine values of variable to be dummied;
proc summary data = &out nway ;
     class &vari ;
     output out = _cats_ ( keep = &vari ) ;
%if &syserr > 4 %then %let abort=1; %if &abort %then %goto DONE;

        %if &fullrank %then %do;
        *-- Eliminate the base category;
        data _cats_;
                set _cats_ end=_eof_;
                %if &base = _FIRST_ %then %str( if _n_ = 1 then delete;);
                %else %if &base = _LAST_ %then %str( if _eof_ then delete;);
                %else                    %str(if &vari = &base then delete;);
        
        run;
        %end;

data _null_ ;
 set _cats_ nobs = numvals ;

 if _n_ = 1 then do;
  call symput('abort',trim( left( put( (numvals=0), best. ) ) ) ) ;
  call symput( 'num', trim( left( put( numvals, best. ) ) ) ) ;
  end;
  call symput ( 'c' || trim ( left ( put ( _n_,     best. ) ) ),
                       trim ( left ( &vari ) ) ) ;
run ;
%if &syserr > 4 %then %let abort=1; %if &abort %then %goto DONE;

%let name = %upcase(&name);
%if "&name" = "VAL" %then %do ;
        %*-- Names by variable value;
%let vl&j =; %do k=1 %to &num; %let vl&j = &&vl&j  &pre&&c&k; %end; ;
%*put vl&j = &&&vl&j;
data &out;
        set &out ;
        
        array __d ( &num ) %do k=1 %to &num ;   &pre&&c&k
                                                        %end ; ;
        %put DUMMY: Creating dummy variables &pre&&c1 .. &pre&&c&num for &vari;
        %end ;

%else %do ;
        %*-- Numeric suffix names;
%let vl&j =; %do k=1 %to &num; %let vl&j = &&vl&j  &pre.&k; %end; ;
%*put vl&j = &&&vl&j;

data &out  ( rename = ( %do k=1 %to &num ;
                                                d&k = &pre.&k
                                                %end ; ) ) ;
        set &out ;
        %put DUMMY: Creating dummy variables &pre.1 .. &pre.&num;
        array __d ( &num ) d1-d&num ;
        %end ;

        drop j;
        do j = 1 to &num ; /* initilaize to 0 */
                __d(j) = 0 ;
        end ;

        if &vari = "&c1" then __d ( 1 ) = 1 ;  /* create dummies */

        %do i = 2 %to &num ;
                else if &vari="&&c&i" then __d ( &i ) = 1 ;
        %end;
run ;

%let j=%eval(&j+1);
%let vari = %scan(&var, &j, %str( ));
%let pre = %scan(&prefix, &j, %str( ));

%*put End of loop(&i): vari = &vari  pre=&pre;
%end;  /* %do %while */

%done:
%if &abort %then %put ERROR: The DUMMY macro ended abnormally.;
options notes;
%mend dummy ;
/*-------------------------------------------------------------------*
  *    Name: halfnorm.sas                                             *
  *   Title: Half normal plot for generalized linear models           *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/halfnorm.html           *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *
  * Created: 08 Nov 1998  9:51                                        *
  * Revised:  9 Nov 2000 13:36:44                                     *
  * Version: 1.1                                                      *
  *  1.1   Fixed make ... noprint for V7+                             *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------*/
 /* Description:
 
 The HALFNORM macro plots the ordered absolute values of residuals
 from a generalized linear model against expected values of normal
 order statistics.  A simulated envelope, correponding to an
 approximate 95% confidence interval, is added to the plot to aid
 assessment of whether the distribution of residuals corresponds
 to a good-fitting model.

Usage:

 The HALFNORM macro is called with keyword parameters.  The RESP=
 and MODEL= parameters are required.  The arguments may be listed
 within parentheses in any order, separated by commas. For example:

        %halfnorm(resp=count, class=sex response, model=sex|year|response@2);

 
Parameters:

* DATA= Specifies the name of the input data set to be analyzed.
            The default is the last data set created.

* Y=
* RESP=     Specifies the name of the response variable to be analyzed

* TRIALS=   The name of a trials variable, for DIST=BIN, with the data
            in events/trials form.

* MODEL=    Specifies the model formula, the right-had-side of the
            MODEL statement.  You can use the | and @ shorthands.

* CLASS=    Names of any class variables in the model.

* DIST=     Error distribution.  [Default: DIST=NORMAL].

* LINK=     Link function.  The default is the canonical link for the
            DIST= error distribution.

* OFFSET=   The name(s) of any offset variables in the model.

* MOPT=     Other model options (e.g., NOINT)

* FREQ=     The name of a frequency variable, when the data are in grouped
            form.

* ID=       The name of a character variable used as an observation
            identifier in the plot.

* OUT=          Specifies the name of the output data set. The output data
            set contains the input variables, absolute residuals (_ARES_),
                                half-normal expected value (_Z_),
                                [Default: _RES_].

* LABEL=    Specifies whether and how to label observations in the plot.
            LABEL=ALL means that all observations are labelled with the
                                ID= variable value; LABEL=NONE means that no observations are
                                labelled; LABEL=ABOVE means that observations above the mean
                                of the simulations are labelled; LABEL=TOP n means that the
                                highest n observations are labelled. [Default: TOP 5]
                                
* SEED=     Specifies the seed for the random number generators. SEED=0
            (the default) uses the time-of-day as the seeed, so a
                                different set of simulated observations is drawn each time
                                the program is run.

* RES=      The type of residual to plot.  Possible values are:
            STRESCHI (adjusted Pearson residual), STRESDEV (adj. deviance
                                residual).
            
* NRES=     Number of simulations for the confidence envelope. [Default: 19]

* SYMBOL=   Plotting symbol for residuals. [Default: dot]

* INTERP=   Interpolation for residuals. [Default: none]

* COLOR     Color for residuals. [Default: red]

* NAME=     Graph name in graphics catalog. [Default: halfnorm]

* GOUT=     The name of the graphics catalog. [Default: GSEG]

 */
 
%macro halfnorm(
   data=_last_,    /* Name of input data set                     */
        y=,             /* Name of response variable                  */
   resp=,          /* Name of response variable                  */
        trials=,        /* Name of trials variable (dist=bin only)    */
   model=,         /* Model specification                        */
   class=,         /* Names of class variables                   */
   dist=,          /* Error distribution                         */
   link=,          /* Link function                              */
        offset=,        /* Offset variable(s)                         */
   mopt=,          /* other model options (e.g., NOINT)          */
   freq=,          /* Freq variable                              */
   id=,            /* Name of observation ID variable (char)     */
        out=_res_,      /* output data set                            */
        label=top 5,    /* NONE|ALL|ABOVE|TOP n                       */
        seed=0,         /* Seed for simulated residuals               */
        res=stresdev,   /* Type of residual to use: streschi/stresdev */
        nres=19,        /* Number of simulations for envelope         */
        symbol=dot,     /* plotting symbol for residuals              */
        interp=none,    /* interpolation for residuals                */
        color=red,      /* color for residuals                        */
        name=halfnorm,  /* graph name in graphics catalog             */
        gout=
);

%let label=%upcase(&label);
%let abort=0;
%if %length(&model) = 0 %then %do;
    %put ERROR: List of model terms (MODEL=) is empty.;
    %let abort=1;
    %goto done;
    %end;

%if %length(&resp) = 0 %then %let resp=&y;
%if %length(&resp) = 0 %then %do;
    %put ERROR: No response (RESP= or Y=) has been specified.;
    %let abort=1;
    %goto done;
    %end;

%let dist=%upcase(&dist);
%if %length(&dist) = 0 %then %do;
    %put WARNING: No distribution (DIST=) has been specified.;
    %put WARNING: GENMOD will use DIST=NORMAL.;
    %end;

%let lres=&res;
      %if %upcase(&res)=STRESDEV %then %let lres=Std Deviance Residual;
%else %if %upcase(&res)=STRESCHI %then %let lres=Std Pearson Residual;
%else %if %upcase(&res)=RESDEV   %then %let lres=Deviance Residual;
%else %if %upcase(&res)=RESCHI   %then %let lres=Pearson Residual;
%else %if %upcase(&res)=RESLIK   %then %let lres=Likelihood Residual;
%else %if %upcase(&res)=RESRAW   %then %let lres=Raw Residual;
%else %do;
    %put WARNING: Residual type &res is unknown.  Using RES=STRESDEV;
    %let res=stresdev;
         %let lres=Std Deviance Residual;
    %goto done;
        %end;

%put HALFNORM: Fitting initial model: &resp = &model.;
%let _print_=OFF;
proc genmod data=&data;
   %if %length(&class)>0 %then %do; class &class; %end;
   %if %length(&freq)>0 %then %do;  freq &freq;   %end;
        %if %length(&trials)=0 %then %do;
           model &resp         = &model /
                %end;
        %else %do;
           model &resp/&trials = &model /
                %end;
        %if %length(&dist)>0 %then %do;  dist=&dist %end;
        %if %length(&link)>0 %then %do;  link=&link %end;
        %if %length(&offset)>0 %then %do; offset=&offset  %end;
        %if %length(&mopt)>0 %then %do;  %str(&mopt) %end;
                obstats residuals;
  make 'obstats'  out=_obstat_ %if &sysver<7 %then noprint;;
  run;

%*-- Find variables listed in model statment;
data _null_;
        length xv $200;
        xv = translate("&model", '    ', '(|)*');
        at= index(xv,'@');
        if at then xv=substr(xv,1,at-1);
        call symput('xvars', trim(left(xv)));
run;
%*put xvars=&xvars;

%*-- Generate simulated response values from the error distribution;
data _obstat_;
   merge &data(keep=&resp &trials &freq &class &xvars &offset &id)
              _obstat_(keep=pred &res);
        array _y_{&nres} _y1 - _y&nres;
        drop i seed;
        retain seed &seed;
        do i=1 to dim(_y_);
                %if %substr(&dist,1,1)=N %then %do;
                        call rannor(seed, _y_[i]);
                        _y_[i] = pred + _y_[i];
                        %end;
                %else %if %substr(&dist,1,1)=B %then %do;
                        n=&trials;
                        call ranbin(seed, n, pred, _y_[i]);
                        %end;
                %else %if %substr(&dist,1,1)=P %then %do;
                        call ranpoi(seed, pred, _y_[i]);
                        %end;
                %else %if %substr(&dist,1,1)=G %then %do;
                        call rangam(seed, pred, _y_[i]);
                        %end;
                end;
run;

%if %length(&id)=0 %then %do;
%put WARNING: No ID= was given.  Using observation number.;
data _obstat_;
        set _obstat_;
        _id_ = left(put(_n_,10.));
run;
%let id=_id_;
%end;

%put HALFNORM: Generating &nres simulated residual sets...;
%if &sysver >= 7 %then %do;
        ods listing exclude all;
        %end;
%do i=1 %to &nres;
options nonotes;
%*put Generating residual set &i;
        
proc genmod data=_obstat_;
   %if %length(&class)>0 %then %do; class &class; %end;
   %if %length(&freq)>0 %then %do;  freq &freq;   %end;
        %if %length(&trials)=0 %then %do;
           model _y&i         = &model /
                %end;
        %else %do;
           model _y&i/&trials = &model /
                %end;
        %if %length(&dist)>0 %then %do;  dist=&dist %end;
        %if %length(&link)>0 %then %do;  link=&link %end;
        %if %length(&offset)>0 %then %do; offset=&offset  %end;
        %if %length(&mopt)>0 %then %do;  %str(&mopt) %end;
                obstats residuals;
  make 'obstats'  out=_hres&i(keep=&res rename=(&res=res&i));
  run;

%end;  /* End %do i */
%let _print_=ON;
%if &sysver >= 7 %then %do;
        ods listing exclude none;
        %end;

%*-- Merge residuals, calculate absolute values;
data _obstat_;
        merge _obstat_
        %do i=1 %to &nres;
                _hres&i
                %end;
                ;
        drop i _y1-_y&nres;
        array _res_{&nres}  res1-res&nres;
        do i=1 to dim(_res_);
                if _res_[i]^=. then _res_[i] = abs(_res_[i]);;
                end;
        _ares_ = abs(&res);

proc sort data=_obstat_;
        by _ares_;

%*-- Sort each set of residuals;
proc iml;
start sortcols(X);
        *-- Sort columns, allowing for missing values;
        do i=1 to ncol(X);
                xi = x[,i];
                if any(xi=.) then do;
                        mi = xi[loc(xi=.),];
                        xi = xi[loc(xi^=.),];
                        end;
                else free mi;
                t = xi; r = rank(xi);
                t[r] = xi;
                x[,i] = mi//t;
                end;
        finish;

start symput(macnm,scal);
  *-- give macro variable &"macnm" the value of the scalar ;
  call execute('%let ',macnm,'=',char(scal),';');
finish;

        use _obstat_;
        read all var( "res1" : "res&nres" ) into X;
        nc=0;
        do i=1 to ncol(X);
                if ^all(X[,i]=.) then do;
                        Y = Y || X[,i];
                        nc = nc+1;
                        end;
                end;
        run symput('nc', nc);
        run sortcols(Y);
        create _sorted_  from Y;
        append from Y;
        quit;
%put NOTE: There are &nc sorted columns of simulated residuals;
%if &nc=0 %then %do;
        %let abort=1;
        %goto done;
        %end;

data _obstat_;
        merge _obstat_ _sorted_;
        array _res_{*} col1-col&nc;
        drop res1-res&nres;
        
        resmin = min(of col1-col&nc);           
        resmax = max(of col1-col&nc);
        resmean = mean(of col1-col&nc);         

*proc print data=_obstat_(obs=20);
run;
                
options notes;
data &out;
        set _obstat_ nobs=nobs end=eof;
        drop col1-col&nres;
        _z_ = probit((_n_ + nobs - .125)/(2*nobs + .5));
        label _z_='Expected value of half normal quantile'
                _ares_="Absolute &lres";
        if eof then call symput('nobs', left(put(nobs,best8.))); 
run;
options nonotes;

%if &label ^= NONE %then %do;
        %if &label=ALL   %then %let subset=1;
        %if &label=ABOVE %then %let subset=(_ares_>resmax);
        %if %scan(&label,1)=TOP %then %do;
                %let which = %scan(&label,2);
                %if %length(&which)=0 %then %let which=5;
                %let subset = (_n_ > %eval(&nobs-&which));
                %end;
%label(data=&out, x=_z_, y=_ares_, text=&id, out=_labels_, pos=4,
        subset=&subset, xoff=-.04);
%end;

proc gplot data=&out;
        plot _ares_  * _z_ = 1
             resmean * _z_ = 2 
             resmin  * _z_ = 3 
             resmax  * _z_ = 3 / overlay  
                vaxis=axis1 frame vm=1 hm=1 
                %if &label ^= NONE %then %do;
                anno=_labels_
                %end;
                name="&name" des="Half normal plot for &resp in &data";
        symbol1 v=&symbol c=&color i=&interp;
        symbol2 v=none    c=black  i=join;
        symbol3 v=none    c=gray60 i=join l=3;
        axis1 label=(a=90);
run; quit;

 /*------------------------------------*
  | Clean up datasets no longer needed |
  *------------------------------------*/
proc datasets nofs nolist nowarn library=work memtype=(data);
    delete _obstat_
        %do i=1 %to &nres;
                _hres&i
                %end;
         ;
         run; quit;

%done:
options notes;
%if &abort %then %put ERROR: The HALFNORM macro ended abnormally.;
%mend;

/*-------------------------------------------------------------------*
  *    Name: mosaic.sas                                               *
  *   Title: Macro interface for mosaic displays                      *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/mosaic.html             *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *
  * Created:   9 Sep 1997 17:04:26                                    *
  * Revised:  14 Dec 1998 11:17:28                                    *
  * Version: 1.3                                                      *
  *  - added BY= variables (calling MOSPART)                          *
  *  - fixed bug with multiple BY= variables                          *
  *  - added check for non-existant vars                              *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------*/
 /*Description:
 
 The MOSAIC macro provides an easily used macro interface to the
 MOSAICS, MOSAICD and MOSPART SAS/IML programs.  Using the
 SAS/IML programs directly means that you must compose a PROC IML
 step and invoke the mosaic module (or mospart, for partial mosaics).

 The MOSAIC macro may be used with any SAS data set in frequency
 form (e.g., the output from PROC FREQ).  The macro simply creates
 the PROC IML step, reads the input data set, and runs the either
 the mosaic module, the mosaicd module, or the mospart module,
 depending on the options specified.  
 
 If your data is in case form, or you wish to collapse over some
 table variables, you must use PROC FREQ first to construct the
 contingency table to be analyzed.  The TABLE macro may be used
 for this purpose.  It has the advantage of allowing formatted
 values of the table factors to be used by the mosaics program.

 Ordinarily, the program fits a model (specified by the FITTYPE=
 parameter) and displays residuals from this model in the mosaic
 for each marginal subtable specified by the PLOTS= parameter.
 However, if you have already fit a model and calculated residuals
 some other way (e.g., using PROC CATMOD or PROC GENMOD), specify
 a RESID= variable in the macro call.  The macro will then call
 the mosaicd module.
 
 If a BY= variable is specified, the macro produces one (partial)
 mosaic plot for each level of the BY variable(s).

Usage:

 The parameters for the mosaic macro are like those of the SAS/IML
 program, except:
 
* DATA=    Specifies the name of the input dataset.  The data set
           should contain one observation per cell, the variables
           listed in VAR= and COUNT=, and possibly RESID= and BY=.

* VAR=     Specifies the names of the factor variables for the 
           contingency table. Abbreviated variable lists (e.g., V1-V3) 
           are not allowed. The levels of the factor variables may be
           character or numeric, but are used `as is' in the input data.
           You may omit the VAR= variables if variable names are used in
           the VORDER= parameter.

* BY=      Specifies the names of one (or more) By variables.  Partial
           mosaic plots are produced for each combination of the levels
           of the BY= variables.  The BY= variable(s) *must* be listed among
           the VAR= variables.

* COUNT=   Specifies the names of the frequency variable in the dataset

* CONFIG=  For a user-specified model, CONFIG= gives the terms in the
           model, separated by '/'.  For example, to fit the model of
           no-three-way association, specify config=1 2 / 1 3 / 2 3,
           or (using variable names) config = A B / A C / B C.
           Note that the numbers refer to the variables after they
           have been reordered, either sorting the data set, or by the
           VORDER= parameter.

* VORDER=  Specifies either the names of the variables or their indices
           in the desired order in the mosaic.  Note that the using the
           VORDER parameter keeps the factor levels in their order in
           the input data set.

* SORT=    Specifies whether and how the input data set is to be sorted
           to produce the desired order of variables in the mosaic.
           SORT=YES sorts the data in the reverse order that they are
           listed in the VAR= paraemter, so that the variables are 
           entered in the order given in the VAR= parameter.  Otherwise,
           SORT= lists the variable names, possibly with the DESENDING
           or NOTSORTED options in the reverse of the desired order.
           e.g., SORT=C DESCENDING B DESCENDING A.  The default is
           SORT=YES, unless VORDER= has been specified.

* RESID=   Specifies that a model has already been fit and that externally
           calculated residuals are contained in the variable named 
           by the RESID= parameter.
 */
 
%macro mosaic(
   data=_last_,     /* Name of input dataset                        */
   var=,            /* Names of all factor variable                 */
   count=count,     /* Name of the frequency variable               */
   by=,             /* Name(s) of BY variables                      */
   fittype=joint,   /* Type of models to fit                        */
   config=,         /* User model for fittype='USER'                */
   devtype=gf,      /* Residual type                                */
   shade=2 4,       /* shading levels for residuals                 */
   plots=,          /* which plots to produce                       */
   colors=blue red, /* colors for + and - residuals                 */
   fill=HLS HLS,    /* fill type for + and - residuals              */
   split=V H,       /* split directions                             */
   vorder=,         /* order of variables in mosaic                 */
   htext=1.5,       /* height of text labels                        */
   font=,           /* font for text labels                         */
   title=,          /* title for plot(s)                            */
   space=,          /* room for spacing the tiles                   */
   cellfill=,       /* write residual in the cell?                  */
   vlabels=,        /* Number of variable names used as plot labels */
   sort=,           /* Pre-sort variables?                          */
   resid=,          /* Name of residual variable                    */
        fuzz=
   );


%if %length(&var)=0 & %length(&vorder)>0 %then %do;
        %if %verify(&vorder, %str(0123456789 ))>0 %then %let var=&vorder;
        %end;

%if %length(&var)=0 %then %do;
   %put ERROR: You must specify the VAR= classification variables;
   %goto done;
   %end;

%if %upcase(&data)=_LAST_ %then %let data = &syslast;

%if %length(&sort)=0 %then %do;
        %if %length(&vorder)>0
                %then %let sort=NO;
                %else %let sort=YES;
        %end;

%let sort=%upcase(&sort);
%if &sort^=NO %then %do;
   %if &sort=YES %then %let sort=%reverse(&var);
   proc sort data=&data;
      by &sort;
%end;
   
%if %upcase(&fittype)=USER and %length(&config)=0 %then %do;
   %put ERROR: You must specify the USER model with the CONFIG= argument;
   %goto done;
   %end;
   
%if %length(&config) %then %do;
   data _null_;
      length config $ 200;
      config = "&config";
      config = translate(config, ',', '/');
      call symput('config', trim(config));
   run;
   %*put config: &config;
%end;

%*-- Get variable labels for use as vnames;
        %*** use summary to reorder the variables in order of var list;
/*
proc summary data=&data(firstobs=1 obs=1);
        id &var;
        output out=_tmp_(drop=_TYPE_ _FREQ_);
proc contents data=_tmp_ out=_work_(keep=name type label npos) noprint;
proc sort data=_work_;
        by npos;

data _null_;
        set _work_;
        call symput("name"||left(put(_n_,5.)),trim(name));
        call symput("type"||left(put(_n_,5.)),put(type,1.));
        call symput("lab"||left(put(_n_,5.)),trim(label));
*/

        %*--Becuase of the large number of modules loaded, it may be
            necessary to adjust the symsize value;
proc iml  symsize=256  /* worksize=10000 */;
   reset storage=mosaic.mosaic;
   load module=_all_;
   *include mosaics(mosaics); 
   %if %length(&resid)>0 %then %do;
      %include mosaics(mosaicd);
      %end;
        %if %length(&by)>0 %then %do;
                %include mosaics(mospart);
                %end;

start str2vec(string);
        *-- String to character vector;
   free out;
   i=1;
   sub = scan(string,i,' ');
   do while(sub ^=' ');
      out = out || sub;
      i = i+1;
      sub = scan(string,i,' ');
   end;
        return(out);
        finish;

   vnames = str2vec("&var");          *-- Preserve case of var names;
        vars = t(contents("&data"));
        ok=1; 
        vn=upcase(vnames) || upcase("&count");
        %if %length(&by)>0 %then %do;
                vn = vn || upcase(str2vec("&by"));
                %end;
        if ncol(union(vars, vn)) > ncol(vars) then ok=0;

        do;
        if ok=0 then do;
                print 'One or more variables are not contained in the input data set';
                print "Data set &data contains", vars;
                print "You asked for" vn;
                goto done; 
                end;

   %*-- Read and reorder residuals if specified;
   %if %length(&resid)>0 %then %do;
      vn = vnames;
      run readtab("&data","&resid", vn, dev,   lev, ln);
                if any(dev = .) then dev[loc(dev=.)] = 0;
      %if %length(&vorder) %then %do;
         vorder  = { &vorder };
         *-- marg bug workaround: subtract min value, then add back in;
         mdev = min(dev);
         dev = dev - mdev;
         run reorder(lev, dev, vn, ln, vorder);
         dev = dev + mdev;
         %end;
   %end;

   %*-- Read and reorder counts;
   run readtab("&data","&count", vnames, table, levels, lnames);

   %if %length(&vorder) %then %do;
      vorder  = { &vorder };
      run reorder(levels, table, vnames, lnames, vorder);
      %end;

   shade={&shade};
   colors={&colors};
   filltype={&fill};
   split={&split};

   htext=&htext;
   title = "&title";
   
   %if %length(&space)>0    %then %do; space={&space};   %end;
   %if %length(&font)>0     %then %do; font = "&font";   %end;
   %if %length(&fuzz)>0     %then %do; fuzz = "&fuzz";   %end;
   %if %length(&vlabels)>0  %then %do; vlabels=&vlabels; %end;
   %if %length(&cellfill)>0 %then %do; cellfill="&cellfill";  %end;


   %if %length(&resid)>0 %then %do;
      run mosaicd(levels, table, vnames, lnames, dev, title); 
      %end;

   %else %do;
      fittype = "&fittype";
      devtype = "&devtype";
      %if %length(&config)>0 %then %do;
         config=t({&config});
         %end;

                %if %length(&by)>0 %then %do;
                        %if %verify(&by, %str(0123456789 ))>0 %then %let by={&by};
                        %*put verify: %verify(&by, %str(0123456789 ));
                        show levels vnames lnames;
                        run mospart(levels, table, vnames, lnames, title, &by); 
                        %end;

                %else %do;
                        %if %length(&plots)=0 %then %do;
                                plots = 1:nrow(vnames);
                                %end;
                        %else %do;
                                %if %index(&plots,:)
                                        %then %str(plots = &plots;);
                                        %else %str(plots = {&plots};);
                                %end;
                        run mosaic(levels, table, vnames, lnames, plots, title);
                        %end;
                %end;
done:
        end;
   quit;
%done:

%mend;

%macro reverse(list);
   %local result i v;
   %let result =;
   %let i = 1;
   %let v = %scan(&list,&i,%str( ));
   %do %while (%length(&v) > 0);
      %let result = &v &result;
      %let i = %eval(&i + 1);
      %let v = %scan(&list,&i,%str( ));
      %end;
   &result
%mend;
/*-------------------------------------------------------------------*
  |     Name: power2x2.sas                                            |
  |    Title: Power for testing two independent proportions           |
  |      Doc: http://www.math.yorku.ca/SCS/vcd/power2x2.html          |
  | ------------------------------------------------------------------|
  |    Procs: print tabulate sort plot gplot                          |
  |  Macdefs: power2x2                                                |
  | ------------------------------------------------------------------|
  | Original: Modified from POWER2x2.SAS by SAS Institute             |
  |   Author: Michael Friendly               <friendly@yorku.ca>      |
  |  Created: 12 May 1999 10:16:12                                    |
  |  Revised: 19 Aug 1999 09:33:12                                    |
  |  Version: 1.1                                                     |
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------*/
 /* Description:

The POWER2X2 macro computes the power of a test comparing proportions
from two, equal-sized, independent samples.  Power is given for
various sizes of the total sample, or required sample size is given
for various power values, allowing you to pick the sample size that
achieves the desired power.                                                                      

Usage:

 The POWER2X2 macro takes 9 keyword arguments.  You must supply the
 DIFF= parameter.  By default the macro computes power for a range
 of sample sizes (given by NMIN= and NMAX=).  Alternatively, you may
 specify a range of power values (given by POWER=) for which the
 required sample size is calculated.

Parameters:

* P1=.5      Specifies an estimate of the "success" rate in one
                            group, the baseline group. [Default: P1=.50]

* DIFF=      Specifies the difference in the proportions that you 
             want to detect.  This is the specification of the 
             alternative hypothesis at which power is computed.
                            The difference MUST be specified; there is NO default.
                                 You may specify a list of values separated by commas, a
                                 range of the form x TO y BY z, or a combination of these.
             However, you must surround the DIFF= value with
             %STR() if any commas appear in it.  For example,

                     diff=.10 to .30 by .05
                     diff=%str(.10, .13, .20)

* ALPHA=.05  Specifies the significance level or size of the test. 
             It is a decimal value less that 1.  
             For example, ALPHA=.05 sets the probability of a Type
             1 error at 0.05.  You may specify a single value, or
                                 a list of values separated by commas, or a range of the
                                 form x TO y by z.  [Default: ALPHA=.05]

* POWER=     Values of power for sample size calculation.
             You may specify a list of values separated by commas, a
                            range of the form x TO y BY z, or a combination of these,
                                 as in a DO statement.
             However, you must surround the POWER= value with
             %STR() if any commas appear in it.

* NMIN=10    Specifies the minimum total sample size at which power 
             will be computed.  [Default: NMIN=10]

* NMAX=200   Specifies the minimum total sample size at which power
             will be computed.  [Default: NMAX=200]
             To get power for a single total sample size, set NMIN and
             NMAX to half of the total sample size.

* PLOT=      is a specification for plotting the results, in the form
             Y * X or Y * X = Z, where X, Y, and Z may be any of the
                                 variables N, DIFF, P2, POWER or OR.  No plots are produced 
                                 if PLOT=  is blank.  [Default: PLOT=POWER * N=DIFF]

* PLOTBY=    is another variable in the OUT= data set.  Separate plots are
             drawn for each level of the PLOTBY= variable.

* OUT=       The name of the output data set. [Default: OUT=_POWER_]

Example:

                %power2x2( p1=.6,  diff=.10 to .20 by .05,  nmin=50);

 With the settings above, the expected baseline success rate is 60%.
 Power for detecting a difference of 10-20% in the two proportions will
 be computed for a .05 level test and for sample sizes ranging from
 50 to 200.

 PRINTED OUTPUT:
 Using the settings shown, the following output is generated:


                 Power for testing two independent proportions
           Two-tailed test, alpha=.05, p1=0.6 diff=.10 to .20 by .05

                   -----------------------------------------
                   |                  |     Diff p1-p2     |
                   |                  |--------------------|
                   |                  | 0.1  | 0.15 | 0.2  |
                   |------------------+------+------+------|
                   |Total Sample Size |      |      |      |
                   |------------------|      |      |      |
                   |50                | 0.116| 0.209| 0.353|
                   |------------------+------+------+------|
                   |60                | 0.129| 0.242| 0.410|
                   |------------------+------+------+------|
                   |70                | 0.143| 0.274| 0.465|
                   |------------------+------+------+------|
                   |80                | 0.156| 0.306| 0.516|
                   |------------------+------+------+------|
                   |90                | 0.170| 0.337| 0.564|
                   |------------------+------+------+------|
                   |100               | 0.184| 0.368| 0.609|
                   |------------------+------+------+------|
                   |110               | 0.198| 0.398| 0.650|
                   |------------------+------+------+------|
                   |120               | 0.211| 0.428| 0.688|
                   |------------------+------+------+------|
                   |130               | 0.225| 0.456| 0.722|
                   |------------------+------+------+------|
                   |140               | 0.239| 0.484| 0.754|
                   |------------------+------+------+------|
                   |150               | 0.252| 0.511| 0.782|
                   |------------------+------+------+------|
                   |160               | 0.266| 0.537| 0.807|
                   |------------------+------+------+------|
                   |170               | 0.280| 0.562| 0.830|
                   |------------------+------+------+------|
                   |180               | 0.293| 0.586| 0.851|
                   |------------------+------+------+------|
                   |190               | 0.306| 0.609| 0.869|
                   |------------------+------+------+------|
                   |200               | 0.320| 0.631| 0.885|
                   -----------------------------------------

Details:

 Hypotheses in the test are:                                          

        H0: p1 = p2                                                       
        Ha: p1 ne p2                                                      

 where p1 and p2 are the success probabilities in the two
 populations.  The Pearson chi-square statistic tests the null
 hypothesis (H0) against the alternative hypothesis (Ha) and is
 available in the FREQ procedure when the CHISQ option is specified
 on the TABLES statement.
                                                                      
 The power is the probability of rejecting H0 and is a function of
 the true difference in proportions.  Power is often computed
 assuming many different settings of the true proportions.  The type
 2 error rate (denoted beta) is the probability of accepting H0 for
 some non-zero true difference and is equal to 1-power.  The power
 and beta are computed for a range of total sample sizes at a
 particular alternative hypothesis that you specify.  It is assumed
 that the total sample size will be split equally between the two
 samples.

References:

* Agresti, A. (1990), Categorical Data Analysis, New York: John Wiley
       & Sons, Inc.
* Agresti, A. (1996), An Introduction to Categorical Data Analysis,
            New York: John Wiley & Sons, Inc.

 =*/

/************************************************************************

                                POWER2x2

   DISCLAIMER:
     THIS INFORMATION IS PROVIDED BY SAS INSTITUTE INC. AS A SERVICE TO
     ITS USERS.  IT IS PROVIDED "AS IS".  THERE ARE NO WARRANTIES,
     EXPRESSED OR IMPLIED, AS TO MERCHANTABILITY OR FITNESS FOR A
     PARTICULAR PURPOSE REGARDING THE ACCURACY OF THE MATERIALS OR CODE
     CONTAINED HEREIN.

   REQUIRES:
     POWER2x2 requires only Version 6 base SAS Software.

   USAGE:
     POWER2x2 is a macro program.  The options and allowable values are:

   SEE ALSO:
     PWR2x2un -- Computes the power of a test comparing proportions from
                 two, unequally-sized, independent samples.

     POWERRxC -- Computes power for Pearson and Likelihood Ratio
                 Chi-square tests of independence in FREQ.  Handles any 
                 number of rows and columns in a two-way table.

************************************************************************/

%macro power2x2(
        p1 = .5,     /* Success probability in baseline group       */
        diff =,      /* difference in proportions to be detected    */ 
        alpha = .05, /* alpha-level of test                         */
        power=,      /* Values of power for sample size calculation */
        nmin = 10,   /* Minimum sample size to consider             */
        nmax = 200,  /* Maximum sample size to consider             */
        plot =power * n=diff,    /* plot request                    */
        plotby =,
        print =diff n power or,  /* variables to be printed         */    
        out=_power_
        );
        
%if %length(&diff)=0 %then %do;
        %put ERROR: The required difference in proportions must be specified;
        %goto done;
        %end;
        
data &out;

  p1=&p1;
  do alpha=&alpha;

  /********************** Compute power ************************/

        za = probit(alpha/2);
        %if %length(&power)>0 %then %do;
                do diff = &diff;
                        p2 = p1 + diff;
                        if (0 < p2 < 1) then do;
                                or = (p2 / (1-p2)) / (p1 / (1-p1));
                                do power = &power;
                                        zb = probit(1-power);
                                        n = 2 * ( (za+zb)**2 * (p1*(1-p1) + (p2*(1-p2))) ) / diff**2;
                                        n = round(n);
                                        output;
                                end;
                        end;
                end;
                drop za zb;
        %end;
        %else %do;    /* determine power for specified n */
                nmin=&nmin;
                nmax=&nmax;
                /* Select 'nice' range of total sample sizes */
                diforder=10**(max(floor(log10(nmax-nmin+1e-8)),1)-1);
                normlen=(nmax-nmin)/diforder;
                step=diforder*((normlen<=20)+2*(20<normlen<=40)+5*(40<normlen<=100));
                
                do n=nmin, nmin+step-mod(nmin+step,step) to nmax by step, nmax;
                        do diff = &diff;
                                /* power and beta computation */
                                p2 = p1 + diff;
                                or = (p2 / (1-p2)) / (p1 / (1-p1));
                                var = 2*( p1*(1-p1) + p2*(1-p2) ) / n;
*                               power=1-probnorm(-za - diff*sqrt(n/(4*p*(1-p)))) +
                                                        probnorm( za - diff*sqrt(n/(4*p*(1-p))));
                                power=1-probnorm(-za - diff/sqrt(var)) +
                                                  probnorm( za - diff/sqrt(var));
                                output;
                        end;
                        if n=round(nmax) then stop;
                end;
        end; /* do &alpha */
                drop diforder normlen step nmin nmax za var;
  %end;
  
  label n='Total Sample Size'
        power='Power'
        diff='Diff p1-p2'
        or = 'Odds ratio';
  run;

%if %length(&print)>0 %then %do;
proc print data=&out noobs split=' ';
  var &print;
  %if %length(&power)=0 %then %do;
        title  "Power for testing two independent proportions";
        %end;
        %else %do;
        title  "Sample size for testing two independent proportions";
        %end;
  title2 "Total sample size to be split equally between the groups";
  title3 "Baseline p1=&p1; p1-p2=&diff; alpha=&alpha";
  run;
%end;

proc tabulate data=&out format=6.0;
        class diff n;
        var power;
        table n,  diff *power=' '*f=6.3  * sum=' ';
        title2 "Two-tailed test, alpha=&alpha, p1=&p1 diff=&diff";
run;

%if %length(&plot)>0 %then %do;
%if %length(&plotby) %then %do;
proc sort data=&out;
        by &plotby;
%end;

title2 "Baseline: p1=&p1; p1-p2=&diff; alpha=&alpha";
proc plot data=&out;
        plot &plot /box ;
        run;

proc gplot data=&out uniform;
        plot &plot / frame hminor=1 vaxis=axis1 haxis=axis2;
        %if %length(&plotby) %then %do;
                by &plotby;
        %end;

        axis1 label=(a=90);
        axis2 offset=(3);
        symbol1 v=circle   i=join l=1 c=black;
        symbol2 v=dot      i=join l=3 c=red;
        symbol3 v=square   i=join l=5 c=blue;
        symbol4 v=triangle i=join l=7 c=green;
        symbol5 v=hash     i=join l=9 c=black;
        symbol6 v=diamond  i=join l=11 c=red;
        symbol7 v=star     i=join l=13 c=blue;
        format n 5.;
run; quit;
        title2;
        goptions reset=symbol;

%end;   
title;
%done:
%mend;

/*-----------------------------------------------------------------*
  |     Name: table.sas                                             |
  |    Title: Construct a grouped frequency table, with recoding    |
  |     Doc: http://www.math.yorku.ca/SCS/vcd/table.html            |
  | ----------------------------------------------------------------|
  |    Procs: freq printto                                          |
  |  Macdefs: table join tempfile tempdel                           |
  | ----------------------------------------------------------------|
  |   Author: Michael Friendly               <friendly@yorku.ca>    |
  |  Created: 09 Jul 1999 16:52:05                                  |
  |  Revised: 17 Nov 2000 12:10:58                                  |
  |  Version: 1.1                                                   |
  *  1.1  Inlined %tempfile %tempdel                                *
  *                                                                 *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)  *         
  *-----------------------------------------------------------------*/
/* Description:

 The TABLE macro constructs a grouped frequency table suitable for 
 input to %mosaics.  The input data may be individual observations,
 or a contingency table,  which may be collapsed to fewer variables.
 Factor variables may be converted to character using user-supplied
 formats.

Usage:

 The TABLE macro takes 7 keyword arguments.  The VAR= parameter
 is required.
 
Parameters:

* DATA=              The name of the input dataset.  [Default: DATA=_LAST_]

* VAR=               Names of all factor (classification) variables to be
                     included in the
                     output dataset.  The observations are summed over
                     any other factors, weighted by the WEIGHT= variable,
                     if any.

* CHAR=              If non-blank, forces the VAR= variables to be
                     converted to character variables (using formatted
                     values) in the output dataset.  If CHAR= a
                     numeric value (e.g., CHAR=8), it specifies the
                     length of each character variable; otherwise, the
                     character variables default to length 16.

* WEIGHT=            Name of a frequency variable, if the input dataset
                     is already in frequency form.

* ORDER=             Specifies the order of the variable levels used
                     in the PROC FREQ step.  ORDER=INTERNAL|FREQ|DATA|
                     FORMATTED are valid option values.

* FORMAT=            List of variable(s), format pairs (suitable for a
                     format statement).  The FORMAT= option may be used
                     to recode the values of any of the VAR= variables.

* OUT=               Name of output dataset.  The variables in the output
                     dataset are the VAR= variables, plus COUNT, the
                     frequency variable for each cell. [Default: OUT=TABLE]

Limitations:

None of the factor variables may be named COUNT.

Example:

 This example reads a three-way frequency table (gender x admit x dept),
 where admit and dept are numeric variables, and collapses it to a
 two-way table, with Gender and Admit as character variables.
 
   %include data(berkeley);
   %table(data=berkeley, var=gender admit, weight=freq, char=Y,
          format=admit admit. gender $sex., order=data, out=berk2);
   %mosaic(data=berk2, var=Gender Admit);

 The formats admit. and $sex. are created with proc format:

   proc format;
      value admit 1="Admitted" 0="Rejected";
      value $sex  'M'='Male'   'F'='Female';

*/ 

%macro table (
   data=_last_,     /* Name of input dataset                        */
   var=,            /* Names of all factor variables                */
   char=,           /* Force factor variables to character?         */
   weight=,         /* Name of a frequency variable                 */
   order=,          /* Specifies the order of the variable levels   */
   format=,         /* List of var, format pairs                    */
   out=table        /* Name of output dataset                       */
   );

%let abort=0;
%let ls=120;
%*-- Save original linesize;
%if &sysver>6.10 %then %do;
   %let lso=%sysfunc(getoption(ls,keyword));
   %let pso=%sysfunc(getoption(ps,keyword));
   %let dto=%sysfunc(getoption(date));
   %let cto=%sysfunc(getoption(center));
   %end;
%else %do; %let lso=; %let pso=; %let dto=; %let cto=; %end;


%if %length(&var)=0 %then %do;
   %put ERROR:  The VAR= variables must be specified.;
   %end;

%let table = %join(&var, *);

proc freq data=&data
   %if %length(&order) %then order=&order;
   ;
   %if %length(&weight) %then %do;
      weight &weight;
      %end;
   tables &table / noprint sparse out=&out(drop=percent);
   %if %length(&format) %then %do;
      format &format;
      %end;

%if %length(&char)>0 %then %do;
   /*
    * Force the VAR= variables to character.  To do this cleanly, we
    * resort to printing the &out dataset, then reading it back as
    * character.  
    */
   %tempfile(table,&ls);
   proc printto new print=table;
   options nodate nocenter nonumber ls=&ls;
   proc print data=&out;
      id &var;
      var count;
      run;
   %if &syserr > 4 %then %let abort=1; %if &abort %then %goto DONE;
   proc printto print=print;


   %let tvar = %join(&var, $) $;
   %*put tvar=&tvar;

   %if %verify(&char,  %str(0123456789))=0
      %then %let clen=&char;
      %else %let clen=16;
   data &out;
      infile table length=len;
      length string $&ls &var $&clen;
      retain skipping 1;
      drop string skipping;
      input @1 string $varying. len @;
      if skipping=0 & string ^= ' ' then do;
         input @1 &tvar count;
         output;
         end;
      else input;
      if index(string,'COUNT')>0 then skipping=0;
   run;
   *proc contents data=&out;

%tempdel(table);
%end;

%done:;
%if &abort %then %put ERROR: The TABLE macro ended abnormally.;
options notes &lso &pso &dto &cto;
%if &sysver<=6.10 %then %do;
        options center date ls=80;
        %end;

%mend;

 /*
Description:

Join the &delim-separated words in &string with &sep.

Usage:

 %let result = %join(A B C, *);   *-- returns: A * B * C;

Parameters:

* STRING        A &delim-separated string of 'words'    

* SEP           The separator character(s) used between each pair

* DELIM         The delimiters [Default: %str( )]

 */

%macro join(string, sep, delim);

   %local count word;
   %if %length(&delim) %then %let delim=%str( );
   %let count=1;
   %let word = %scan(&string,&count,%str( ));
   %let result = &word;
   %do %while(&word^= );
       %let count = %eval(&count+1);
       %let word = %scan(&string,&count,%str( ));
       %if %length(&word)
          %then %let result = &result &sep &word;
   %end;
   &result
   
%mend;

%macro tempfile(fileref,ls);
   %global tempfn;
   %if %length(&ls)=0 %then %let ls=80;
   %if &sysscp = CMS
      %then %let tempfn=&fileref output a;
   %else %if &sysscp = WIN 
      %then %let tempfn=c:\temp\&fileref..out;
   %else /* %if &sysscp = NEXT | &sysscp = RS6000 
      %then  */ %let tempfn=/tmp/&fileref..out;
   filename &fileref "&tempfn" lrecl=&ls;
%mend;

%macro tempdel(fileref);
   %global tempfn;
    *-- Avoid annoying flash with X commands;
    %if &sysver > 6.10 %then %do;
        %let rc=%sysfunc(fdelete(&fileref));
        %let rc=%sysfunc(filename(&fileref,''));
    %end;

    %else %do;
   %if &sysscp = CMS
      %then cms erase &tempfn;
   %else %if &sysscp = WIN
      %then %do;
         options noxsync noxwait; run;
         %sysexec(erase &tempfn); run;
         options   xsync   xwait; run;
      %end;
   %else /* assume flavor of UNIX */
       %sysexec(rm -f &tempfn);
    %end;
%mend;
/*-----------------------------------------------------------------*
  |     Name: equate.sas                                            |
  |    Title: Creates AXIS statements for a GPLOT with equated axes |
  |      Doc: http://www.math.yorku.ca/SCS/vcd/equate.html          |
  | ----------------------------------------------------------------|
  |    Procs: means gplot                                           |
  |  Macdefs: equate                                                |
  | ----------------------------------------------------------------|
  | Original: Warren Kuhfeld (SAS Sample Library)                   |
  |      Ref: P-179, PROC CORRESP, EXAMPLE 3.                       |
  |   Author: Michael Friendly               <friendly@yorku.ca>    |
  |  Created:  28 Jul 1998 14:13:25                                 |
  |  Revised:  10 Dec 1999 15:40:52                                 |
  |  Version:  1.2                                                  |
  |  1.1 Generates AXIS stmts for use by other macros               |
  |    - Determines XMAX, YMAX from DGSI if not specified           |
  |    - Optionally plots the data (if PLOT=YES)                    |
  |  1.2 Added XINC= and YINC= calculation from data                |
  |                                                                 |
  | From ``Visualizing Categorical Data'', Michael Friendly (2000)  |         
  *-----------------------------------------------------------------*/
 /*
Description:

 The EQUATE macro creates AXIS statements for a GPLOT with equated
 axes, and optionally produces a plot using point labels (supplied
 in an input annotate data set).  It is a modified version of the
 macro appearing in the SAS Sample Library.
                                                            
 It creates an AXIS statement for the vertical variable Y and
 an AXIS statement for horizontal variable X such that an inch
 on the vertical axis represents the same data range as an inch on
 the horizontal axis.  Equated axes are necessary whenever
 distances between points, or angles between vectors from the origin
 are to be interpreted.
          
Usage:

 The EQUATE macro takes 15 keyword arguments.  The X= and Y=
 parameters are required.  

 You may wish to reset the defaults below to be more
 suited to your devices.  As well, use GOPTIONS HSIZE= VSIZE=; to
 allow the maximum plot size if you  specify the XMAX= and
 YMAX= parameters as null values.

 As an additional convenience (particularly for use within other
 macros) EQUATE will calculate reasonable tick mark increments
 from the data, to give about 6 tick marks on an axis, if the
 XINC= or YINC= parameters are specified as null values.

Parameters:

* DATA=       Name of the input data set [Default: DATA=_LAST_]

* ANNO=       Name of an Annotate data set (used only if PLOT=YES).
              [Default: ANNO=&DATA]

* X=          Name of the X variable [Default: X=X]

* Y=          Name of the Y variable [Default: Y=Y]

* XMAX=       Maximum X axis length (inches).  If XMAX= (a null value)
              the macro queries the device driver (using the DSGI)
                                  to determine the maximum axis length. [Default: XMAX=6.5]

* YMAX=       Maximum Y axis length (inches).  If YMAX= (a null value)
              the macro queries the device driver (using the DSGI)
                                  to determine the maximum axis length. [Default: YMAX=8.5]

* XINC=       X axis tick increment.  If XINC= (a null value),
              the macro calculates an increment from the data
                                  which is 1, 2, 2.5, 4, or 5 times a power of 10
                                  so that about 6 tick marks will appear on the X
                                  axis. [Default: XINC=0.1]

* YINC=       Y axis tick increment.  If XINC= (a null value),
              the macro calculates an increment from the data
                                  which is 1, 2, 2.5, 4, or 5 times a power of 10
                                  so that about 6 tick marks will appear on the X
                                  axis. [Default: YINC=0.1]

* XPEXTRA=    Number of extra X axis tick marks at the high end.
              Use the XPEXTRA= and XMEXTRA= parameters to extend the
              range of the X variable beyond the data values, e.g.,
                                  to accommodate labels for points in a plot.
                                  [Default: XPEXTRA=0]

* XMEXTRA=    Number of extra X axis tick marks at the low end.
                                  [Default: XMEXTRA=0]

* YPEXTRA=    Number of extra Y axis tick marks at the high end.
              Use the YPEYTRA= and YMEYTRA= parameters to extend the
              range of the Y variable beyond the data values, e.g.,
                                  to accommodate additional annotations in a plot.
                                  [Default: YPEXTRA=0]

* YMEXTRA=    Number of extra Y axis tick marks at the low end.
                                  [Default: XMEXTRA=0]

* VAXIS=      Name of the AXIS statement for Y axis [Default: VAXIS=AXIS98]

* HAXIS=      Name of the AXIS statement for X axis [Default: HAXIS=AXIS99]

* PLOT=       Draw the plot? [Default: PLOT=NO]
                

    This macro performs no error checking.                  

 */
                                                            
   /*---------------------------------------------------------*/
%macro equate(
                        data=_last_,  /* Name of input data set             */
                        anno=&data,   /* Name of Annotate data set          */
                        x=x,          /* Name of X variable                 */
                        y=y,          /* Name of Y variable                 */
                        xmax=6.5,     /* maximum x axis inches              */
                        ymax=8.5,     /* maximum y axis inches              */
                        xinc=0.1,     /* x axis tick increment              */
                        yinc=0.1,     /* y axis tick increment              */
                        xpextra=0,    /* include extra + end x axis ticks   */
                        xmextra=0,    /* include extra - end x axis ticks   */
                        ypextra=0,    /* include extra + end y axis ticks   */
                        ymextra=0,    /* include extra - end y axis ticks   */
                        vaxis=axis98, /* AXIS statement for Y axis          */
                        haxis=axis99, /* AXIS statement for X axis          */
                        plot=NO       /* Draw the plot?                     */
                                  );
 
 
   %if %upcase(&data)=_LAST_ %then %let data=&syslast;
        
   *---Find the Minima and Maxima---;
        options nonotes;
   proc means noprint data=&data;
      var &y &x;
      output out=__temp__ min=ymin xmin max=ymax xmax;
      run;
 
   data _null_;
      set __temp__;
 
      *-- Select increments if values are empty --;
                %if %length(&xinc)=0 %then %do;
                        min=xmin;  max=xmax; link doinc; xinc=inc;
         %end;
                %else %do;
              xinc = &xinc;
                        %end;
                
                %if %length(&yinc)=0 %then %do;
                        min=ymin;  max=ymax; link doinc; yinc=inc;
         %end;
                %else %do;
              yinc = &yinc;
                        %end;
                
      *---Scale Minima and Maxima to Multiples of the Increments---;
      yinc = &yinc;
      ymin = (floor(ymin / yinc) - (&ymextra)) * yinc;
      xmin = (floor(xmin / xinc) - (&xmextra)) * xinc;
      ymax = (ceil (ymax / yinc) + (&ypextra)) * yinc;
      xmax = (ceil (xmax / xinc) + (&xpextra)) * xinc;
 
                *-- Should check that # tics is reasonable;
                xtic = (xmax - xmin) / xinc;
                ytic = (ymax - ymin) / yinc;
                
                *-- Determine XMAX, YMAX if not specified;
                %if %length(&xmax)=0 or %length(&ymax)=0 %then %do;
                        rc=ginit();
                        call gask('maxdisp',units,_xmax_,_ymax_,xpix,ypix,rc2);
                        rc3 = gterm();
                        *-- Convert to inches;
                        _xmax_ = _xmax_ * 100 / 2.54;
                        _ymax_ = _ymax_ * 100 / 2.54;
                        %end;
                %else %do;
                        _xmax_ = &xmax;
                        _ymax_ = &ymax;
                        %end;
                        
      *---Compute the Axis Lengths---;
 
      ytox = (ymax - ymin) / (xmax - xmin);
      if ytox le ((_ymax_) / (_xmax_)) then do;
         xlen =  _xmax_;
         ylen = (_xmax_) * ytox;
         end;
      else do;
         ylen = _ymax_;
         xlen = (_ymax_) / ytox;
         end;
 
      *---Write Results to Symbolic Variables---;
 
      call symput('len1',compress(put(ylen, best6.)));
      call symput('len2',compress(put(xlen, best6.)));
      call symput('min1',compress(put(ymin, best6.)));
      call symput('min2',compress(put(xmin, best6.)));
      call symput('max1',compress(put(ymax, best6.)));
      call symput('max2',compress(put(xmax, best6.)));
      call symput('inc1',compress(put(yinc, best6.)));
      call symput('inc2',compress(put(xinc, best6.)));
      return;

doinc:
                *-- Determine increment to give a nice number with about 6 ticks --;
                inc= abs(max - min)/6;
                pow = 10**floor( log10(inc) );
                nice=1000;
                do in = 1, 2, 2.5, 4, 5;
                        ut = in * pow;
                        if abs(inc-ut) < nice then do;
                                nice = abs(inc-ut);
                                best = ut;
                        end;
                end;
                inc=best;
                return;
run;
 
   *options notes;
 
   *---Write the Generated AXIS Statements to the Log---;
 
   %put EQUATE: The following statements were generated.;
   %put &vaxis length=&len1 IN order=(&min1 to &max1 by &inc1) label=(a=90)%str(;);
   %put &haxis length=&len2 IN order=(&min2 to &max2 by &inc2)%str(;);
        %put;
 
        *-- Create the AXIS statements;
        &vaxis length=&len1 IN order=&min1 to &max1 by &inc1 label=(a=90);
        &haxis length=&len2 IN order=&min2 to &max2 by &inc2;

   *---Create the GPLOT---;
   %if %upcase(&plot)=YES %then %do;
   proc gplot data=&data;
      symbol1 v=none;
      plot &y*&x=1 / annotate=&anno frame haxis=&haxis vaxis=&vaxis
                     href=0 vref=0 lvref=3 lhref=3;
      run;
   %end;
%mend equate;

/*-------------------------------------------------------------------*
  *    Name: inflglim.sas                                             *
  *   Title: Influence plots for generalized linear models            *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/inflglim.html           *
  *                                                                   *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *
  * Created:  24 Nov 1997 10:36:05                                    *
  * Revised:  10 Nov 2000 09:29:04                                    *
  * Version:  1.4                                                     *
  *  - Fixed error if DIST= not specified. Added FREQ= parm           *
  *  - Added MOPT= parm, INFL= parm (what's influential?)             *
  *  1.4   Fixed make ... noprint for V7+                             *
  *    Fixed numerous problems with GENMOD for V7+ (sigh)             *
  *                                                                   *
  * Dependencies:  %gskip (needed for eps/gif only)                   *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/
 /*
Description:
 
 The INFLGLIM macro produces various influence plots for a generalized
 linear model fit by PROC GENMOD.  Each of these is a bubble plot of 
one
 diagnostic measure (specified by the GY= parameter) against another
 (GX=), with the bubble size proportional to a measure of influence
 (usually, BUBBLE=COOKD).  One plot is produced for each combination
 of the GY= and GX= parameters.
 
Usage:

 The macro normally takes an input data set of raw data and fits the
 GLM specified by the RESP=, and MODEL= parameters, using an error
 distribution given by the DIST= parameter.  It fits the model,
 obtains the OBSTATS and PARMEST data sets, and uses these to compute
 some additional influence diagnostics (HAT, COOKD, DIFCHI, DIFDEV,
 SERES), any of which may be used as the GY= and GX= variables.

 Alternatively, if you have fit a model with PROC GENMOD and saved
 the OBSTATS and PARMEST data sets, you may specify these with the
 OBSTATS= and PARMEST= parameters.  The same additional diagnostics
 are calculated and plotted.

 The INFLGLIM macro is called with keyword parameters.  The MODEL=
 and RESP= parameters are required, and you must supply the DIST=
 parameter for any model with non-normal errors.
 The arguments may be listed within parentheses in any order, separated
 by commas. For example: 
 
   %inflglim(data=berkeley,
      class=dept gender admit,
      resp=freq, model=dept|gender dept|admit,
      dist=poisson,
      id=cell,
      gx=hat, gy=streschi);

 
Parameters:

* DATA=       Name of input (raw data) data set. [Default: DATA=_LAST_]

* RESP=       The name of response variable.  For a loglin model, this
              is usually the frequency or cell count variable when the
              data are in grouped form (specify DIST=POISSON in this
              case).

* MODEL=      Gives the model specification.  You may use the '|' and
              '@' symbols to specify the model.

* CLASS=      Specifies the names of any class variables used in the 
model.

* DIST=       The name of the PROC GENMOD error distribution.  If you
              don't specify the error distribution, PROC GENMOD uses
              DIST=NORMAL.

* LINK=       The name of the link function.  The default is the 
canonical
              link function for the error distribution given by the
                                  DIST= parameter.

* MOPT=       Other options on the MODEL statement (e.g., MOPT=NOINT
              to fit a model without an intercept).

* FREQ=       The name of a frequency variable, when the data are in
              grouped form.

* WEIGHT=     The name of an observation weight (SCWGT) variable, used, 
for
              example, to specify structural zeros in a loglin model.

* ID=         Gives the name of a character observation ID variable
              which is used to label influential observations in the
              plots. Usually you will want to construct a character
              variable which combines the CLASS= variables into a
              compact cell identifier.

* GY=         The names of variables in the OBSTATS data set used as
              ordinates for in the plot(s).  One plot is produced for
                                  each combination of the words in GY by the 
words in GX.
                                  [Default: GY=DIFCHI STRESCHI]

* GX=         Abscissa(s) for plot, usually  PRED or HAT. [Default: 
GX=HAT]

* OUT=        Name of output data set, containing the observation
              statistics. [Default: OUT=COOKD]

* OBSTATS=    Specifies the name of the OBSTATS data set (containing
              residuala and other observation statistics) for a model 
              already fitted.

* PARMEST=    Specifies the name of the PARMEST data set (containing
              parameter estimates) for a model already fitted.

* BUBBLE=     Gives the name of the variable to which the bubble size 
is
              proportional. [Default: BUBBLE=COOKD]

* LABEL=      Determines which observations, if any, are labeled in the
              plots.  If LABEL=NONE, no observations are labeled; if
              LABEL=ALL, all are labeled; if LABEL=INFL, only possibly
              influential points are labeled, as determined by the
              INFL= parameter. [Default: LABEL=INFL]

* INFL=       Specifies the criterion used to determine which 
observations
              are influential (when used with LABEL=INFL).
              [Default: INFL=%STR(DIFCHI > 4 OR HAT > &HCRIT OR &BUBBLE 
> 1)]

* LSIZE=      Observation label size. [Default: LSIZE=1.5]. The height 
of
              other text (e.g., axis labels) is controlled by the 
HTEXT=
              goption.

* LCOLOR=     Observation label color. [Default: LCOLOR=BLACK]

* LPOS=       Observation label position, relative to the point.
              [Default: LPOS=5]

* BSIZE=      Bubble size scale factor. [Default: BSIZE=10]

* BSCALE=     Specifies whether the bubble size is proportional to AREA 
              or RADIUS. [Default: BSCALE=AREA]

* BCOLOR=     The color of the bubble symbol. [Default: BCOLOR=RED]

* REFCOL=     Color of reference lines.  Reference
              lines are drawn at nominally 'large' values for HAT 
values,
              standardized residuals, and change in chi square values.
                                  [Default: REFCOL=BLACK]

* REFLIN=     Line style for reference lines. Use REFLIN=0 to suppress
              these reference lines. [Default: REFLIN=33]

* NAME=       Name of the graph in the graphic catalog [Default:
              NAME=INFLGLIM]

* GOUT=       Name of the graphics catalog.

 =*/
 

%macro inflglim(
     data=_last_,    /* Name of input data set                  */
     resp=,          /* Name of criterion variable              */
     model=,         /* Model specification                     */
     class=,         /* Names of class variables                */
     dist=,          /* Error distribution                      */
     link=,          /* Link function                           */
     mopt=,          /* other model options (e.g., NOINT)       */
     freq=,          /* Freq variable                           */
     weight=,        /* Observation weight variable (zeros)     */
     id=,            /* Name of observation ID variable (char)  */
     gy=DIFCHI STRESCHI,      /* Ordinate(s) for plot(s)        */
     gx=HAT,         /* Abscissa(s_ for plot: PRED or HAT       */
     out=cookd,      /* Name of output data set                 */
     obstats=,       /* For a model already fitted              */
     parmest=,       /*  "      "      "      "                 */
     bubble=COOKD,   /* Bubble proportional to: COOKD           */
     label=INFL,     /* Points to label: ALL, NONE, or INFL     */
     infl=%str(difchi > 4 or hat > &hcrit or &bubble > 1),
     lsize=1.5,      /* obs label size.  The height of other    */
                     /* text is controlled by the HTEXT= goption*/
     lcolor=BLACK,   /* obs label color                         */
     lpos=5,         /* obs label position                      */
     bsize=10,       /* bubble size scale factor                */
     bscale=AREA,    /* bubble size proportional to AREA or RADIUS */
     bcolor=RED,     /* bubble color                            */
     refcol=BLACK,   /* color of reference lines                */
     reflin=33,      /* line style for reference lines; 0->NONE */
     name=INFLGLIM,  /* Name of the graph in the graphic catalog */
     gout=
);

        %*-- Reset required global options;
        %if &sysver >= 7 %then %do;
                %local o1 o2;
                %let o1 = %sysfunc(getoption(notes));
                %let o2 = %sysfunc(getoption(validvarname,keyword));
                options nonotes validvarname=V6;
                %end;
        %else %do;
           options nonotes;
                %end;

%let abort=0;
%let gx=%upcase(&gx);
%let gy=%upcase(&gy);
%let dist=%upcase(&dist);
%let label=%upcase(&label);
%let bubble=%upcase(&bubble);

%if %length(&model) = 0 %then %do;
    %put ERROR: List of model terms (MODEL=) is empty.;
    %let abort=1;
    %goto done;
    %end;

%if %length(&resp) = 0 %then %do;
    %put ERROR: No response (RESP=) has been specified.;
    %let abort=1;
    %goto done;
    %end;

%if %length(&dist) = 0 %then %do;
    %put WARNING: No distribution (DIST=) has been specified.;
    %put WARNING: GENMOD will use DIST=NORMAL.;
    %end;

%let nx = %numwords(&gx);       /* number of abscissa vars */
%let ny = %numwords(&gy);       /* number of ordinate vars */

%if &sysver < 6.12 %then %do;
   %if %upcase(&dist)=BINOMIAL %then %do;
      %if %length(%scan(&resp,2,/))=0 %then %do;
         %put ERROR: Response must be specified as RESP=events/trials 
for DIST=BINOMIAL;
         %let abort=1;
         %goto done;
         %end;
      %if %length(&link)=0 %then %let link=logit;
      %end;
   %end;

%if %length(&obstats)=0 or %length(&parmest)=0 %then %do;
proc genmod data=&data;
  class &class;
        %if %length(&freq)>0 %then %do;  freq &freq; %end;
        %if %length(&weight)>0 %then %do;  scwgt &weight; %end;
  model &resp = &model /
        %if %length(&dist)>0 %then %do;  dist=&dist %end;
        %if %length(&link)>0 %then %do;  link=&link %end;
        %if %length(&mopt)>0 %then %do;  %str(&mopt) %end;
        obstats residuals;
        %if &sysver<7 %then %do;
        make 'obstats'  out=_obstat_ noprint;
        make 'parmest'  out=_parms_ noprint;
                %end;
        %else %do;
                ods output ObStats=_obstat_;
                ods output ParameterEstimates=_parms_;
                *proc print data=_parms_;
                %end;
  run;

%if &syserr > 4 %then %let abort=1; %if &abort %then %goto DONE;
%let obstats=_obstat_;
%let parmest=_parms_;
%end;

options nonotes;
%let parms=0;
data _null_;
   set &parmest end=eof;
   parms + df;
   if eof then do;
      call symput('parms', left(put(parms,5.)));
      end;
run;
%*put parms=&parms;
%if &parms=0 %then %let abort=1; %if &abort %then %goto DONE;

data &out;
  /* GENMOD seems to make all class variables character */
  /* keep only the GENMOD computed variables */
  merge &data 
                &obstats(keep=pred--reslik)
                end=eof;
  drop hcrit obs;
  obs=_N_;
  label hat = 'Leverage (H value)'
        cookd = "Cook's Distance"
        difchi = 'Change in Pearson ChiSquare'
        difdev = 'Change in Deviance'
        reschi = 'Pearson residual'
        resdev = 'Deviance residual'
        streschi = 'Adjusted Pearson residual'
        stresdev = 'Adjusted Deviance residual'
        seres = 'Residual Std. Error'
        pred = 'Fitted value';

  /* hat is the leverage */
  hat = Std*Hesswgt*Std;
  if hat<1 then do;
     cookd = hat*Streschi**2/((&parms)*(1-hat));
     seres = sqrt(1-hat);
     end;

  difchi = streschi**2;
  difdev = stresdev**2;

  if eof then do;
     hcrit =  &parms / obs;
     call symput('hcrit', put(hcrit,4.3));
     end;
  run;

proc print data=&out noobs label;
   id &id ;
   format pred hesswgt lower upper 6.2 
          xbeta std resraw--reslik hat cookd difchi difdev seres 7.3 ;
  run;

%do i=1 %to &ny;
   %let gyi = %scan(&gy, &i);
   %do j=1 %to &nx;
   %let gxj = %scan(&gx, &j);
   %put Plotting &gyi vs &gxj ;

   %if &label ^= NONE %then %do;
   data _label_;
      set &out nobs=n;
      length xsys $1 ysys $1 function $8 position $1 text $12 color $8;
      retain xsys '2' ysys '2' function 'LABEL' color "&lcolor";
      keep &id &class x y xsys ysys function position text color size
           position hat difchi &bubble;
      x = &gxj;
      y = &gyi;
      %if &id ^= %str() %then %do;
         text = left( &id );
         %end;
      %else %if %length(&class) %then %do;
         %let c = 1;
         %let v = %scan(&class,&c);
         text = '';
         %do %while (%length(&v) > 0);
            text = trim(text) || trim(&v);
            %let c = %eval(&c + 1);
            %let v = %scan(&class,&c);
            %end;
            %end;
      %else %do;
         text = put(_n_,3.0);
         %end;
      size=&lsize;
      position="&lpos";
      %if &label = INFL %then %do;
         if &infl then output;
         %end;
   run;
   %end;  /* &label ^= NONE */

   proc gplot data=&out &GOUT ;
     bubble &gyi * &gxj = &bubble /
      %if &label ^= NONE %then %do;
      annotate=_label_
      %end;
      frame
      vaxis=axis1 vminor=1 hminor=1
      %if &reflin ^= 0 %then %do;
      %if (&gyi=DIFCHI) or (&gyi=DIFDEV) %then %do;
         vref=4       lvref=&reflin  cvref=&refcol
         %end;
      %else %if (&gyi=STRESCHI) or (&gyi=STRESDEV) %then %do;
         vref=0 -2 2       lvref=&reflin  cvref=&refcol
         %end;
      %if (&gxj = HAT) %then %do;
         href= &hcrit lhref=&reflin  chref=&refcol
         %end;
      %end;
      bsize=&bsize  bcolor=&bcolor  bscale=&bscale
      name="&name"
      Des="Influence plot for &resp (&gyi vs. &gxj)";
     axis1 label=(a=90 r=0);
   run; quit;
   %gskip;
   %end;   /* gx loop */
%end;   /* gy loop */


%done:
%if &abort %then %put ERROR: The INFLGLIM macro ended abnormally.;
        %*-- Restore global options;
        %if &sysver >= 7 %then %do;
                options &o1 &o2;
                %end;
        %else %do;
           options notes;
                %end;
%mend;

%macro numwords(lst);
   %let i = 1;
   %let v = %scan(&lst,&i);
   %do %while (%length(&v) > 0);
      %let i = %eval(&i + 1);
      %let v = %scan(&lst,&i);
      %end;
   %eval(&i - 1)
%mend;
INDEX   
addvar.sas      Added variable plots for logistic regression
bars.sas        Create an annotate data set to draw error bars
biplot.sas      Generalized biplot of observations and variables
catplot.sas     Plot observed and predicted logits for logit models
corresp.sas     Correspondence analysis of contingency tables
distplot.sas    Plots for discrete distributions
dummy.sas       Macro to create dummy variables
equate.sas      Creates AXIS statements for a GPLOT with equated axes
gdispla.sas     Device-independent DISPLAY/NODISPLAY control
gensym.sas      Macro to generate SYMBOL statement for each GROUP
goodfit.sas     Goodness of fit tests for discrete distributions
gskip.sas       Device-independent macro for multiple plots
halfnorm.sas    Half normal plot for generalized linear models
inflglim.sas    Influence plots for generalized linear models
inflogis.sas    Influence plot for logistic regression models
interact.sas    Create interaction variables
label.sas       Create an Annotate dataset to label observations
lags.sas        Macro for lag sequential analysis
logodds.sas     Plot empirical log-odds for logistic regression
mosaic.sas      Macro interface for mosaic displays
mosmat.sas      Macro interface for mosaic matrices
ordplot.sas     Diagnose form of discrete frequency distribution
panels.sas      Macro to display a set of plots in rectangular panels
points.sas      Create an Annotate dataset to draw points in a plot
poisplot.sas    Poissonness plot for discrete distributions
power2x2.sas    Power for testing two independent proportions
powerlog.sas    Power for logistic regression, quantitative predictor
pscale.sas      Construct annotations for a probability scale
robust.sas      M-estimation for robust models fitting via IRLS
rootgram.sas    Hanging rootograms for discrete distributions
sort.sas        Generalized dataset sorting by format or statistic
table.sas       Construct a grouped frequency table, with recoding
triplot.sas     Macro for trilinear plots
/*-------------------------------------------------------------------*
  *    Name: powerlog.sas                                             *
  *   Title: Power for logistic regression, quantitative predictor    *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/powerlog.html           *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *
  * Created: 17 Apr 98 16:43                                          *
  * Revised: 17 Apr 98 16:43                                          *
  * Version: 1.0                                                      *
  *                                                                   *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/
 /*
Description:
 
 The POWERLOG macro calculates sample size required to achived given
 power values for a logistic regression model with one or more 
 quantitative predictors.  Results are displayed as a table of
 sample sizes required for a range of power values, and as a graph.

Usage:

 The POWERLOG macro is called with keyword parameters.  The arguments 
 may be listed within parentheses in any order, separated by commas. 
 You must supply either an input data set containing the 
 variables P1, P2, ALPHA, POWER, and RSQ (one observation for each
 combination for which power is desired), or the macro parameters
 P1= and P2=.
 For example: 
 
        %powerlog(p1=.08, p2=%str(.16, .24));
 
Parameters:

* DATA=  Specifies the name of an input data set containing the 
          variables P1, P2, ALPHA, POWER, and RSQ in all combinations
                    for which power is desired.  If an input DATA= data set 
is
                    specified, the program ignores values for the P1=, P2=, 
ALPHA=, 
                    POWER=, and RSQ= parameters.

* P1=     is the estimated probability of the event at the mean value
          of the quantitative predictor.

* P2=     is the estimated probability of the event at an X-value equal
          to the X-mean plus one standard deviation.
                         You may specify a list of values separated by 
commas, a
                         range of the form x TO y BY z, or a combination of 
these.
                         However, you must surround the P2= value with
                         %STR() if any commas appear in it.  For example,
                        
                                p2=.10 to .30 by .05
                                p2=%str(.10, .13, .20)


* ALPHA=  is the desired Type I error probability for a *one-sided* 
test
          of H0: beta(x) = 0

* POWER=  is the desired power of the test.

* RSQ=    is the squared multiple correlation of the predictor with all
          other predictors.  Use RSQ=0 for a 1-predictor model.

* PLOT=   is a specification for plotting the results.  The default
          is PLOT=N * POWER=RSQ.  No plots are produced if  PLOT=  is
                    blank.

* PLOTBY= is another variable in the OUT= data set.  Separate plots are
          drawn for each level of the PLOTBY= variable.

* OUT=   Specifies the name of the output data set

Reference:  Agresti, 'Introduction to Categorical Data Analysis', p.131

Example:  

Modelling the relation of the probability of heart disease
on X = cholesterol.  If previous studies suggest that heart disease
occurs with P1=0.08 at the mean level of cholesterol, what is the
sample size required to detect a 50% increase (P2 = 1.5*.08 = .12),
or an 87.5% increase (P2 = 1.875*.08 = .15) in the probability of
heart disease, when cholesterol increases by one standard deviation?
        
If age is another predictor, how does sample size vary with the RSQ
between cholesterol and age?
        
   %powerlog(p1=.08, p2=%str(.12, .15), rsq=%str(.2, .4) );

*/

%macro powerlog(
        data=,
        p1=,
        p2=,
        alpha=.05,
        power=.7 to .9 by .05,
        rsq=0 to .6 by .2,
        plot=N * power = rsq,
        plotby=theta,
        out=_power_
        );
         
%if %length(&data)=0 %then %do;
        %if %length(&p1)=0 or %length(&p2) =0 %then %do;
                %put ERROR:  P1= and P2= must be specified.;
                %goto done;
        %end;

        %let data=_in_;
        data _in_;
                label p1='Pr(event) at X-mean'
                                p2='Pr(event) at X-mean+std'
                                alpha = 'Type I risk'
                                power = 'Desired power'
                                rsq   = 'R**2 (X, other Xs)';
                alpha = &alpha;
                do p1 = &p1;
                        do p2 = &p2;
                                do rsq = &rsq;
                                        do power = &power;
                                        output;
                                        end;
                                end;
                        end;
                end;
%end;

data &out;
        set &data;
        drop l1 l2 za zb lambda;
        label theta = 'Odds ratio'
              lambda= 'Log(odds ratio)'
                        delta = 'Delta'
                        N     = 'Sample size';
        format theta 6.3 delta 6.2 n 6.1;
        l1 = p1 / (1-p1);
        l2 = p2 / (1-p2);
        theta = l2 / l1;
        lambda = log(theta);
        
        za = probit(1-alpha);
        zb = probit(power);
        
        delta = (1 + (1+lambda**2) * exp(5*lambda**2/4))
              / (1 + exp(- lambda**2 / 4));
        
        N =  ( (za + zb * exp(- lambda**2 / 4))**2  * (1 + 2*p1*delta))
          / (p1 * lambda**2); 
        
        N = N / (1-rsq);
/*      
proc print label;
        id p1 p2;
        by p1 p2;
*/
proc tabulate data=&out format=6.0;
        class alpha p2 rsq power;
        var n;
        table power='Power',  p2 *n=' '*f=5. * rsq * sum=' ';
        title2 "One-tailed test, alpha=&alpha, p1=&p1 p2=&p2";

%if %length(&plot) %then %do;
%if %length(&plotby) %then %do;
proc sort data=&out;
        by &plotby;
%end;
proc gplot data=&out uniform;
        plot &plot / frame hminor=1 vaxis=axis1 haxis=axis2;
        %if %length(&plotby) %then %do;
                by &plotby;
        %end;

        axis1 label=(a=90);
        axis2 offset=(3);
        symbol1 v=circle   i=join l=1 c=black w=3;
        symbol2 v=dot      i=join l=3 c=red;
        symbol3 v=square   i=join l=5 c=blue;
        symbol4 v=triangle i=join l=7 c=green;
        symbol5 v=hash     i=join l=9 c=black;
        symbol6 v=diamond  i=join l=11 c=red;
        symbol7 v=star     i=join l=13 c=blue;
        format n 5.;
run; quit;
        title2;
        goptions reset=symbol;
%end;
%done:
%mend;

/*-------------------------------------------------------------------*
  *    Name: triplot.sas                                              *
  *   Title: Macro for trilinear plots                                *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/triplot.html            *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *
  * Created:  6 Aug 1996 09:11:33                                     *
  * Revised:  7 Apr 1998 13:05:32                                     *
  * Version:  1.2                                                     *
  *  - Fixed legend bug; added label location (LABLOC=) parameter     *
  *    Fixed xsys/ysys error                                          *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/
 /*
Description:
 
 The TRIPLOT macro plots three variables (rows of an n x 3 table)
 in an equilateral triangle, so that each point represents the
 proportions of each variable to the total for that observation.

Usage:

 The TRIPLOT macro is called with keyword parameters.
 The names of three variables must be given in the VAR= parameter.
 The arguments may be listed within parentheses in any order, separated
 by commas. For example: 
 
        data tridemo;
                input A B C point $12.;
                label point='Point';
        cards;
        40 30 30  (40,30,30)
        20 60 20  (20,60,20)
        10 10 80  (10,10,80)
        ;
        %triplot(var=A B C, class=Point, id=point, gridby=25,
                symbols=dot dot dot, idht=1.6, axes=bot,
                symht=4, gridclr=gray);
 
Parameters:

* DATA=       The name of data set to be plotted. [Default: 
DATA=_LAST_]

* VAR=        The names of three variables used as the axes in the
              plot.  The values of each observation are normally all
                                  non-negative.  Missing values are treated as 
0.

* CLASS=      The name of a class variable determining plotting symbol.
              Different values of the CLASS= variable are represented
                                  by the values in the COLORS= and SYMBOLS= 
lists, used
                                  sequentially.

* ID=         The name of an observation identifier (label) variable

* BY=         The name of a BY variable, for separate plots

* WHERE=      WHERE-clause to subset observations to be plotted.

* IDHT=       Height of ID label [Default: IDHT=2]

* IDCLR=      Color of ID label [Default: IDCLR='BLACK']

* IDPOS=      Position of ID label [Default: IDPOS=8]

* IDSUBSET=   A SAS expression (which may use any data set variables
              used to subset ID labels.  If an ID= variable is given,
                                  and the IDSUBSET= expression evaluates to 
non-zero,
                                  the observation is labelled in the plot.
                                  [Default: IDSUBSET=1]

* INTERP=     Interpolation between points, a SYMBOL statement option.
              If INTERP=JOIN, points within the same CLASS= value are
                                  connected by lines.  Most other SYMBOL 
statement
                                  interpolation options would give bizare 
results.
                                  [Default: INTERP=NONE]

* SYMHT=      Height of point symbols [Default: SYMHT=2]

* SYMBOLS=    A list of one or more symbols for points, corresponding
              to the levels of the CLASS= variable.  The symbols are
                                  reused cyclically if there are more class 
levels than
                                  symbols.
                                  [Default: SYMBOLS=%STR(DOT CIRCLE SQUARE $ : 
TRIANGLE = X _ Y)]

* COLORS=     A list of one or more colors for points, corresponding
              to the levels of the CLASS= variable.  The colors are
                                  also reused cyclically as required.
              [Default: COLORS=BLACK RED BLUE GREEN BROWN ORANGE PURPLE 
YELLOW]

* BACKCLR=    Background color inside the trilinear plot.
              [Default: BACKCLR=WHITE]

* BACKPAT=    Background fill pattern. For a plot with a light gray
              background, for example, specify BACKPAT=SOLID and
                                  BACKCLR=GRAYD0. [Default: BACKPAT=EMPTY]

* GRIDBY=     Grid line interval. For grid lines at 25, 50, and 75%,
              for example, specify GRIDBY=25. [Default: GRIDBY=20]

* GRIDCLR=    Grid line color [Default: GRIDCLR=GRAY]

* GRIDLINE=   Style of grid lines [Default: GRIDLINE=34]

* AXES=       Type of axes, one of NONE, FULL, TOP, or BOT.
              AXES=NONE draws no coordinate axes;  AXES=FULL draws
                                  a line from 0 to 100% for each of the three 
coordinates;
                                  AXES=TOP draws a line from the apex to the 
centroid only;
                                  AXES=BOT draws a line from the centroid to 
the base only. 
              [Default: AXES=NONE]

* AXISCLR=    Color of axis lines [Default: AXISCLR=BLUE]

* AXISLINE=   Style of axis lines [Default: AXISLINE=1]

* XOFF=       X offset, in %, for adjusting the plot [Default: XOFF=2]

* XSCALE=     X scale factor for adjusting the plot.  Before plotting
              the X coordinates are adjusted by X = XOFF + XSCALE * X.
                                  [Default: XSCALE=.96]

* YOFF=       X offset, in %, for adjusting the plot [Default: YOFF=2]

* YSCALE=     Y scale factor for adjusting the plot.  Before plotting
              the Y coordinates are adjusted by Y = YOFF + YSCALE * Y.
                                  [Default: YSCALE=.96]

* LEGEND=     The name of legend statement or 'NONE'.  If LEGEND= is
              not specified, and there is more than one group defined
                                  by a CLASS= variable, a legend statement is 
constructed
                                  internally. If LEGEND=NONE, no legend is 
drawn; otherwise
                                  the LEGEND= value is used as the name of a 
legend statement.

* LABHT=      Height of variable labels, in GUNITs [Default: LABHT=2]

* LABLOC=     Location of variable label: 0 or 100 [Default: 
LABLOC=100]

* NAME=       Name of the graphics catalog entry [Default: NAME=TRIPLT]
                

 */
 /*

Ideas from: Fedencuk & Bercov, "TERNPLOT - SAS creation of ternary 
plots",
        SUGI 16, 1991, 771-778.
*/

%macro triplot(
        data=_last_,    /* name of data set to be plotted           */
        var=,           /* 3 variable names for plot axes           */
        class=,         /* class variable defining plotting symbol  */
        id=,            /* point identifier (label) variable        */
        by=,            /* BY variable for separate plots           */
        where=,         /* where-clause to subset observations      */

        idht=2,         /* height of ID label                       */
        idclr='BLACK',  /* color of ID label                        */
        idpos=8,        /* position of ID label                     */
        idsubset=1,     /* expression to subset ID labels           */
        interp=none,    /* interpolation between points             */
        symht=2,        /* height of point symbols                  */
        symbols=%str(dot circle square $ : triangle = X _ Y),
        symfont=,
        colors=BLACK RED BLUE GREEN BROWN ORANGE PURPLE YELLOW,

        backclr=WHITE,  /* background color                         */
        backpat=EMPTY,  /* background fill pattern                  */
        gridby=20,      /* grid line interval                       */
        gridclr=gray,   /* grid line color                          */
        gridline=34,    /* style of grid lines                      */
        axes=none,      /* type of axes: NONE, FULL, TOP, BOT       */
        axisclr=blue,   /* color of axis lines                      */
        axisline=1,     /* style of axis lines                      */

        xoff=2,         /* X offset, in %, for adjusting the plot   */
        xscale=.96,     /* X scale factor, for adjusting the plot   */
        yoff=2,         /* Y offset, in %, for adjusting the plot   */
        yscale=.96,     /* Y scale factor, for adjusting the plot   */
        legend=,        /* name of legend statement or 'NONE'       */
        labht=2,        /* height of variable labels, in GUNITs     */
        labloc=100,     /* location of variable label: 0 or 100     */
        name=triplot    /* name of graphic output in the catalog    */
        );

%let scale = 1;
%let lab = 100;
%let lbc = 100;
%let lac = 100;
%let abort=0;
%let legend=%upcase(&legend);
%let axes  =%upcase(&axes);

%local xvar yavr zvar xlab ylab zlab;

%*-- parse variable names and labels;
%let pre=x y z;
%do i=1 %to 3;
        %let l = %scan(&pre, &i);
        %let &l.var = %scan(&var, &i);
        %end;
%if %length(&zvar)=0 %then %do;
        %put ERROR:  VAR= must give three variable names;
        %let abort=1;
        %goto done;
%end;
%*put xvar=&xvar yvar=&yvar zvar=&zvar;

   %*-- make &data reusable if _LAST_ was specified;
%if %bquote(&data) = %bquote(_last_) %then %let data = &syslast;

*options nonotes;
proc contents data=&data out=_work_ noprint;
%if &syserr > 4 %then %let abort=1; %if &abort %then %goto DONE;

   %*-- get variable labels, assign names if no labels;
data _null_;
   set _work_(keep=name type label);
                select (name);
                        when (upcase("&xvar")) do;
                                if label = ' ' then call symput('xlab', 
"&xvar");
                                                        else call symput('xlab', 
trim(label));
                                end;
                        when (upcase("&yvar")) do;
                                if label = ' ' then call symput('ylab', 
"&yvar");
                                                        else call symput('ylab', 
trim(label));
                                end;
                        when (upcase("&zvar")) do;
                                if label = ' ' then call symput('zlab', 
"&zvar");
                                                        else call symput('zlab', 
trim(label));
                                end;
                        otherwise ;
                        end;
run;
%*put xlab=&xlab ylab=&ylab zlab=&zlab;

data trianno;
        retain xsys ysys  '1';
        drop triht;
        length text $20;
        format x y 6.1;

        line  = 1;
        size  = 4;

        triht = &scale * sqrt(3) * &lab /2      ;
        %if %upcase(&backpat) ^= EMPTY %then %do;
                style = "&backpat";
                color = "&backclr";
                %end;

        x = 0;      y = 0;     function='poly    '; output;

        color = 'BLACK';       /* color of triangular frame */
        x = &lab;   y = 0;     function='polycont'; output;
        x = &lab/2; y = triht; function='polycont'; output;
        x = 0;      y = 0;     function='polycont'; output;

        size = &labht;
        style = ' ';
        function='label';
        %if &labloc=100 %then %do;    /* labels at corners */
                position='F';
                text = "&xlab";  x = 0;      y = 0;     output;
                position='D';
                text = "&ylab";  x =100;     y = 0;     output;
                position='2';
                text = "&zlab";  x = &lab/2; y = triht; output;
                %end;
        %else %do;                    /* labels at sides  */
                position='2'; angle=-60;
                text = "&xlab";  x = .75*&lab;  y = triht/2; output;
                position='2'; angle=60;
                text = "&ylab";  x = .25*&lab;  y = triht/2; output;
                position='E'; angle=0;
                text = "&zlab";  x = &lab/2;    y = 0;       output;
                %end;
        
run;

%if &gridby > 0 %then %do;
%let mg=9;     /* max number of grid positions */
data trigrid;
        retain xsys ysys  '1';
        length function $8;
        drop triht i gridby ngrid ni;
        array gabx [&mg] _temporary_ ;
        array gaby [&mg] _temporary_ ;
        array gacx [&mg] _temporary_ ;
        array gacy [&mg] _temporary_ ;
        array gbcx [&mg] _temporary_ ;
        array gbcy [&mg] _temporary_ ;

        array tick [&mg] $2 _temporary_ ;
        array tax [&mg]     _temporary_ ;
        array tbx [&mg]     _temporary_ ;
        array tcx [&mg]     _temporary_ ;
        array tay [&mg]     _temporary_ ;
        array tby [&mg]     _temporary_ ;
        array tcy [&mg]     _temporary_ ;

        triht = &scale * sqrt(3) * &lab /2      ;

        gridby = &gridby;
        ngrid  = min(&mg, (100/gridby) - 1);
        do i = 1 to ngrid;
                gabx[i] = gridby * i;
                gaby[i] = 0;
                gacx[i] = gridby * i / 2;
                gacy[i] = triht * i * gridby / 100;
                gbcx[i] = 50 + (gridby * i) / 2;
                gbcy[i] = triht * (ngrid+1 - i) * gridby / 100;

                tick[i] = put( (gridby * i), 2.);

                tax[i]  = 75 - (.75 * gridby * i);
                tay[i]  = (triht - (triht * (i*gridby/100))) / 2;
                tbx[i]  = 25 + (.75 * gridby * i);
                tby[i]  = tay[i];
                tcx[i]  = 50;
                tcy[i]  = triht * i * gridby / 100;

                end;

        line = &gridline;
        color = "&gridclr";
        size = 1;
        position = 'B';
        rotate = 0;

        *-- grid lines parallel to AB;
        angle  = 0;
        do i = 1 to ngrid;
                ni = ngrid+1 - i;
                x = gbcx[i];    y = gbcy[i];     function='move';  output;
                x = gacx[ni];   y = gacy[ni];    function='draw';  output;
                text = tick[i];
                x = tcx[i];     y = tcy[i];      function='label'; output;
                end;

        *-- grid lines parallel to AC;
        angle  = -120;
        do i = 1 to ngrid;
                x = gabx[i];    y = gaby[i];     function='move';  output;
                x = gbcx[i];    y = gbcy[i];     function='draw';  output;
                text = tick[i];
                x = tbx[i];     y = tby[i];      function='label'; output;
                end;

        *-- grid lines parallel to BC;
        angle  = 120;
        do i = 1 to ngrid;
                x = gabx[i];    y = gaby[i];     function='move';  output;
                x = gacx[i];    y = gacy[i];     function='draw';  output;
                text = tick[i];
                x = tax[i];     y = tay[i];      function='label'; output;
                end;
%end; /*-- &gridby > 0 */

*let axes=BOT;
%if &axes ^= NONE %then %do;
                        %if &axes=TOP %then %do; %let f1=draw; %let f2=move; 
%end;
        %else %if &axes=BOT %then %do; %let f1=move; %let f2=draw; %end;
        %else  /* &axes=FULL */   %do; %let f1=draw; %let f2=draw; %end;

data triaxes;
        retain xsys ysys  '1' line &axisline color "&axisclr";
        length function $8;

        root3 = sqrt(3);
        triht = &scale * root3 * &lab /2;
        cx = &lab/2; cy = triht/3;
        drop root3 triht cx cy;

        x = &lab/2;  y = triht;         function='move'; output;
        y = cy;                         function="&f1";  output;
        y = 0;                          function="&f2";  output;

        x = 0;  y = 0;                  function='move'; output;
        x = cx; y = cy;                 function="&f1";  output;
        x = &lab * .75; y=triht/2;      function="&f2";  output;

        x = &lab; y=0;                  function='move'; output;
        x = cx; y = cy;                 function="&f1";  output;
        x = &lab * .25; y=triht/2;      function="&f2";  output;
%end;  /* &axes ^= NONE */

data trianno;
        set trianno
                %if &axes ^=NONE %then
                triaxes ;
                %if &gridby > 0 %then
                trigrid ;
                                ;
        x = &xoff + &xscale * x;
        y = &yoff + &yscale * y;

%if %length(&by) or %length(&class) %then %do;
        proc sort data=&data;
        by &by &class;
        %end;

data tridata;
        retain xsys ysys  '1'
                xa  ya
                xb  yb
                xc  yc
                root3 xa1 ya1 coef_bc _class_ 0;
        drop xa ya xb yb xc yc root3 coef_bc sum xa1 ya1 xaa yaa;
        drop &xvar &yvar &zvar;

        if _n_ = 1 then do;
                root3 = sqrt(3);
                xa = 0;   ya=0;
                xb = 100; yb=0;
                xc = (xb - xa) / 2;
                yc = root3 * xc;
                ya1= yc / 2;
                xa1= root3 * ya1;
                coef_bc = (yc - yb) / (xc - xb);
                end;

        set &data end=eof;
        %if %length(&class)
                %then %do; by &class; if first.&class then _class_+1; %end;
                %else %do;   _class_=1; %end;

        %if %length(&where) %then
                where (&where)%str(;);

        if (&xvar = .) then &xvar=0;
        if (&yvar = .) then &yvar=0;
        if (&zvar = .) then &zvar=0;
        if &xvar < 0 | &yvar < 0 | &zvar < 0
                then put 'WARNING: One or more values are negative in obs' 
_n_
                &xvar= &yvar= &zvar=;

        sum = &xvar + &yvar + &zvar;
        if (sum=0) then delete;

        &xvar = &xvar / sum;
        &yvar = &yvar / sum;
        &zvar = &zvar / sum;

        xaa = xa1 * (1 - &xvar);
        yaa = xaa / root3;

        y = yc * &zvar;
        x = ( (y-yaa)/coef_bc ) + xaa;

        %if %length(&id) %then %do;
                if (&idsubset) then do;
                        text = &id;
                        size = &idht;
                        color= &idclr;
                        position = "&idpos";;
                        function = 'label';
                        end;
        %end;

        x = &xoff + &xscale * x;
        y = &yoff + &yscale * y;

        if eof then do;
                call symput('ngroups', put(_class_, 3.));
        end;
run;
%*put ngroups=&ngroups;
%if %length(&class)=0 %then %let class=_class_;

data trianno;
        set trianno
        %if %length(&id) %then %do;
        tridata(keep=xsys ysys x y text size color position function
                                where=(function='label'))
        %end;
        ;

*proc print;

%gensym(n=&ngroups,
        h=&symht, symbols=&symbols, colors=&colors, interp=&interp,
                  font=&symfont);

axis1 offset=(0) order=(0 to 100)
        label=none value=none major=none minor=none style=0;

%if %length(&legend)=0 & &ngroups>1 %then %do;
        legend1  position=(top right inside) across=1 offset=(0,-2) 
                mode=share frame;
        %let legend=legend=legend1;
        %end;
%else %if &legend=NONE or &ngroups=1 %then %do;
        %let legend=nolegend;
        %end;
%else %do;
        %let legend=legend=&legend;
        %end;

proc gplot data=tridata anno=trianno;
        plot y * x = &class
                                / vaxis=axis1 haxis=axis1 noaxes &legend 
                                name="&name"
                                des="Triplot of &var";
        %if %length(&by) %then %do;
                                by &by ;
                                %end;
run; quit;

%DONE:
%if &abort %then %put ERROR: The TRIPLOT macro ended abnormally.;
options notes;

%mend;
/*-------------------------------------------------------------------*
  *    Name: bars.sas                                                 *
  *   Title: Create an annotate data set to draw error bars           *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/bars.html               *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *
  * Created: 23 Nov 1997 11:32                                        *
  * Revised:  9 Nov 2000 11:30:08                                     *
  * Version: 1.2                                                      *
  * 1.2  Fixed bug with CLASS= not uppercase                          *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/
 /*=
Description:
 
 The BARS macro creates an Annotate data set to draw error bars
 in a plot.  The error bars may be drawn for a response variable 
 displayed on the Y axis or on the X axis.  The other (CLASS=)
 variable may be character or numeric.  

Usage:

 The BARS macro is called with keyword parameters.  The VAR= and CLASS=
 variables must be specified.  The length of the error bars should be
 specified with either the BARLEN= parameter or the LOWER= and UPPER=
 parameters.

 The arguments may be listed within parentheses in any order, separated
 by commas. For example: 
 
        %bars(class=age, var=logodds, lower=lower, upper=upper);
        proc gplot data=mydata;
                plot logodds * age / anno=_bars_;
         
Parameters:

* DATA=       Name of input data set [Default: DATA=_LAST_]

* VAR=        Name of the response variable, to be plotted on the
              axis given by the BAXIS= parameter.

* CLASS=      Name of the independent variable, plotted on the
              other axis.

* CVAR=       Name of a curve variable, when PROC GPLOT is used with
              the statement PLOT &VAR * &CLASS = &CVAR.

* BY=         Name of a BY variable for multiple plots, when PROC GPLOT
              is used with the statement BY &BY;.

* BAXIS=      One of X or Y, indicating the axis along which error bars
              are drawn [Default: BAXIS=Y]

* BARLEN=     A numeric variable or constant giving the error bar 
length,
              for example, when the input data set contains a standard
                                  error variable or multiple thereof.  If 
BARLEN= is given,
                                  the LOWER= and UPPER= values are ignored, and 
error bars
                                  are drawn at the values &VAR +- &Z * &BARLEN.

* Z=          A numeric value giving the multiplier of the BARLEN=
              value used to determine the lower and upper error bar
                                  values.

* LOWER=      A numeric variable or constant giving the lower error bar 
value.
              Use the LOWER= and UPPER= parameters if the error bars 
are
                                  non-symmetric or if the lower and upper 
values are contained
                                  as separate variables in the input data set.

* UPPER=      A numeric variable or constant giving the upper error bar 
value.

* TYPE=       Type of error bars to be drawn: one of UPPER, LOWER, or 
BOTH
              and possibly one of ALT or ALTBY.  TYPE=LOWER draws only 
the
                                  lower error bars; TYPE=UPPER draws only the 
upper error bars;
                                  TYPE=BOTH draws both upper and lower error 
bars.  Use
                                  TYPE=ALT BOTH to have the error bars 
alternate (lower, upper)
                                  over observations in the input data set;  use
                                  TYPE=ALTBY BOTH to have the error bars 
alternate over values
                                  of the BY= variable. [Default: TYPE=BOTH]

* SYMBOL=     The plotting symbol, drawn at (&CLASS, &var).  If not 
specified,
              no symbols are drawn.

* COLOR=      Color for lines and symbols, a character constant 
(enclosed
              in quotes), or variable name [Default: COLOR='BLACK']

* LINE=       The Annotate line style used for error bars [Default: 
LINE=1]

* SIZE=       Size of symbols and thickness of lines [Default: SIZE=1]

* BARWIDTH=   The width of error bar tops, in data units [Default:
              BARWIDTH=.5]

* OUT=        Name of the output data set, to be used as an Annotate
              data set with PROC GPLOT [Default: OUT=_BARS_]
                

 */
 

%macro bars(
        data=_LAST_,   /* name of input data set                       */
        var=,          /* name of response variable                    */
        class=,        /* name of independent variable                 */
        cvar=,         /* name of a curve variable                     */
        by=,           /* name of a BY variable, for multiple curves   */
        baxis=y,       /* axis along which error bars are drawn        */
        barlen=,       /* variable or constant giving error bar length */
        z=1,           /* barlen multiplier                            */
        lower=,        /* or, var or constant giving lower bar value   */
        upper=,        /* + var or constant giving upperr bar value    */
        type=both,         /* type of bars: UPPER, LOWER, BOTH, ALT, ALTBY */
        symbol=,       /* plotting symbol, placed at (&class, &var)    */
        color='black', /* color for lines and symbols, 'const' or var  */
        line=1,        /* line style for error bars                    */
        size=1,        /* thickness of lines, size of symbols          */
        barwidth=.5,   /* width of bar tops                            */
        out=_bars_     /* name of output data set                      */
        );

%let abort=0;
%if &var=%str() | &class=%str()
   %then %do;
      %put ERROR: The VAR= and CLASS= parameters must be specified;
      %let abort=1;
      %goto DONE;
   %end;
%let class=%upcase(&class);

%if %upcase(&baxis) = Y
        %then %let oaxis = X;
        %else %let oaxis = Y;

%let type = %upcase(&type);
%let alt1=1; %let alt2=1;
%if %index(&type,ALTBY)  %then %do;
        %let alt1=mod(nby,2)=1;
        %let alt2=mod(nby,2)=0;
        %end;
%else %if %index(&type,ALT) %then %do;
        %let alt1=mod(_n_,2)=1;
        %let alt2=mod(_n_,2)=0;
        %end;

%let ay = &baxis;
%let ax = &oaxis;
%let gp = &class;

%if %length(&barlen) %then %do;
        %let lower = &var - &z * &barlen;
        %let upper = &var + &z * &barlen;
        %end;

/* determine if class variable is char or num */
proc contents data=&data out=_work_ noprint;
data _null_;
        set _work_;
        where (upcase(name)="&CLASS");
        if type=1 then call symput('gtype', 'NUM');
                                else call symput('gtype', 'CHAR');
run; 
%if "&gtype" = "CHAR" %then %let ax = &ax.c;

proc sort data=&data out=_work_;
        by &by &cvar &class;

data &out;
   length function $8 color $8;
   retain xsys ysys '2';
   set _work_ /*(keep=&var &class &by &upper &lower &barlen) */;
        by &by &cvar &class;
        %if %length(&cvar) %then %do;
                if first.&by then ncv+1;
                %end;
        %if %length(&by) %then %do;
                if first.&by then nby+1;
                %end;

   color = &color;
   line  = &line;
   size  = &size;
        
        &ax = &class;   *-- sets x or xc (or y or yc);
        
   &ay= &var              ; function='MOVE'; output;
        %if %length(&symbol) %then %do;
        text="&symbol"      ; function='SYMBOL'; output;
                %end;

        %if %index(&type,UPPER)=0 %then %do;
                if (&alt1) then do;
                &ay= &lower            ; function='DRAW'; output;
                %if "&gtype" = "NUM" %then %do;
                &ax = &gp - &barwidth  ; function='MOVE'; output;
                &ax = &gp + &barwidth  ; function='DRAW'; output;
                &ax = &gp              ; function='MOVE'; output;
                %end;
                end;
        %end;
         
        %if %index(&type,LOWER)=0 %then %do;
                if (&alt2) then do;
                &ay= &upper            ; function='DRAW'; output;
                %if "&gtype" = "NUM" %then %do;
                &ax = &gp - &barwidth  ; function='MOVE'; output;
                &ax = &gp + &barwidth  ; function='DRAW'; output;
                %end;
                end;
        %end;
%done:
%mend;
/*-------------------------------------------------------------------*
  *    Name: inflogis.sas                                             *
  *   Title: Influence plot for logistic regression models            *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/inflogis.html           *
  *                                                                   *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *
  * Created:  14 Nov 1993 10:42:11                                    *
  * Revised:  24 May 2000 14:49:18                                    *
  * Version:  1.3                                                     *
  *  - Added TRIALS= parameter(for event/trials syntax)               *
  *  - Added OUT= parameter                                           *
  *  - Added INFL= parameter (what's influential?)                    *
  *                                                                   *
  * Dependencies:  %gskip (needed for eps/gif only)                   *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/
 /*
Description:

This SAS macro produces influence plots for a logistic regression
model.  The plot shows a measure of badness of fit for a given
case (DIFDEV or DIFCHISQ) vs.  the fitted probability (PRED) or
leverage (HAT), using an influence measure (C or CBAR) as the
size of a bubble symbol.

Usage:

 The inflogis macro is called with keyword parameters.
 The arguments may be listed within parentheses in any order, separated
 by commas. For example:

        %include data(arthrit);
        %inflogis(data=arthrit,
                        y=better,
                        x=_sex_ _treat_ age,
                        id=case,
                        );

Parameters:

* DATA=       Specifies the name of the input data set to be analyzed.
              [Default: DATA=_LAST_]

* Y=          Name of the response variable

* TRIALS=     Name of trials variable (for event/trials syntax)

* X=          Names of predictors

* CLASS=      Names of class variables among predictors (V8)

* ID=         Name of observation ID variable (char)

* OUT=        Name of the output data set [Default: OUT=_DIAG_]

* GY=         Ordinate for plot: DIFDEV or DIFCHISQ [Default: 
GY=DIFDEV]

* GX=         Abscissa for plot: PRED or HAT [Default: GX=PRED]

* BUBBLE=     Bubble proportional to: C or CBAR [Default: BUBBLE=C]

* LABEL=      Points to label: ALL, NONE, or INFL [Default: LABEL=INFL]

* DEV=        DIFDEV/DIFCHISQ criterion for infl pts [Default: DEV=4]

* INFL=       Specifies the criterion used to determine which 
observations
              are influential (when used with LABEL=INFL).
              [Default: INFL=%STR(DIFCHISQ > &DEV OR &BUBBLE > 1)]

* LSIZE=      Observation label size.  The height of other text is 
controlled
              by the HTEXT= goption. [Default: LSIZE=1.5]

* LCOLOR=     Observation label color [Default: LCOLOR=BLACK]

* LPOS=       Observation label position [Default: LPOS=5]

* BSIZE=      Bubble size scale factor [Default: BSIZE=10]

* BSCALE=     Bubble size proportional to AREA or RADIUS [Default: 
BSCALE=AREA]

* BCOLOR=     Bubble color [Default: BCOLOR=BLACK]

* REFCOL=     Color of reference lines [Default: REFCOL=BLACK]

* REFLIN=     Line style for reference lines; 0->NONE [Default: 
REFLIN=33]

* LOPTIONS=   Options for PROC LOGISTIC [Default: LOPTIONS=NOPRINT]

* NAME=       Name of the graph in the graphic catalog [Default: 
NAME=INFLOGIS]

* GOUT=       Name of the graphics catalog

 */

%macro inflogis(
   data=_last_,    /* Name of input data set                  */
   y=,             /* Name of criterion variable              */
   trials=,        /* Name of trials variable                 */
   x=,             /* Names of predictors                     */
        class=,         /* Names of class variables (V8+)          */
   id=,            /* Name of observation ID variable (char)  */
   out=_diag_,     /* Name of the output data set             */
   gy=DIFDEV,      /* Ordinate for plot: DIFDEV or DIFCHISQ   */
   gx=PRED,        /* Abscissa for plot: PRED or HAT          */
   bubble=C,       /* Bubble proportional to: C or CBAR       */
   label=INFL,     /* Points to label: ALL, NONE, or INFL     */
   infl=%str(difchisq > &dev or &bubble > 1),
   dev=4,          /* DIFDEV/DIFCHISQ criterion for infl pts  */
   lsize=1.5,      /* obs label size.  The height of other    */
                   /* text is controlled by the HTEXT= goption*/
   lcolor=BLACK,   /* obs label color                         */
   lpos=5,         /* obs label position                      */
   bsize=10,       /* bubble size scale factor                */
   bscale=AREA,    /* bubble size proportional to AREA or RADIUS */
   bcolor=BLACK,   /* bubble color                            */
   refcol=BLACK,   /* color of reference lines                */
   reflin=33,      /* line style for reference lines; 0->NONE */
   loptions=noprint,/* options for PROC LOGISTIC              */
   name=INFLOGIS,
   gout=
   );

%let nv = %numwords(&x);        /* number of predictors */
%let nx = %numwords(&gx);       /* number of abscissa vars */
%let ny = %numwords(&gy);       /* number of ordinate vars */
%if &nv = 0 %then %do;
    %put ERROR: List of predictors (X=) is empty;
    %goto done;
    %end;

%let gx=%upcase(&gx);
%let gy=%upcase(&gy);
%let label=%upcase(&label);
%let bubble=%upcase(&bubble);
%if not ((%bquote(&bubble) = C)
    or   (%bquote(&bubble) = CBAR)) %then %do;
    %put BUBBLE=%bquote(&bubble) is not valid. BUBBLE=C will be used;
    %let bubble=C;
    %end;

%if %length(&class) > 0 and &sysver < 8 %then %do;
        %let class=;
        %put INFLOGIS:  The CLASS= parameter is not supported in SAS 
&sysver;
        %end;

proc logistic nosimple data=&data &loptions ;
   %if %length(&class)>0 %then %do;
                class &class;
                %end;
   %if %length(&trials)=0 %then %do;
      model &y         = &x / influence;
      %end;
   %else %do;
      model &y/&trials = &x / influence;
      %end;
   output out=&out h=hat pred=pred
                     difdev=difdev
                     difchisq=difchisq
                     c=c  cbar=cbar
                     resdev=resdev;

data &out;
   set &out;
   label difdev='Change in Deviance'
         difchisq='Change in Pearson Chi Square'
         hat = 'Leverage (Hat value)'
         studres = 'Studentized deviance residual';
   studres = resdev / sqrt(1-hat);

%do i=1 %to &ny;
   %let gyi = %scan(&gy, &i);
   %do j=1 %to &nx;
   %let gxj = %scan(&gx, &j);
   %put Plotting &gyi vs &gxj ;

   %if &label ^= NONE %then %do;
   data _label_;
      set &out nobs=n;
      length xsys $1 ysys $1 function $8 position $1 text $16 color $8;
      retain xsys '2' ysys '2' function 'LABEL' color "&lcolor";
      retain hcrit;
      drop hcrit;
      *keep &id x y xsys ysys function position text color size 
position
      hat difchisq difdev &bubble;
      x = &gxj;
      y = &gyi;
      %if &id ^= %str() %then %do;
         text = left( &id );
         %end;
      %else %do;
         text = put(_n_,3.0);
         %end;
      if _n_=1 then do;
         hcrit = 2 * (&nv+1)/n;
         put 'Hatvalue criterion: ' hcrit;
         call symput('hcrit',put(hcrit,4.3));
         end;
      size=&lsize;
      position="&lpos";
      %if &label = INFL %then %do;
/*         if %scan(&gy,1) > &dev
                   or difchisq > &dev
         or hat > hcrit  
         or &bubble > 1
            then output;   */
         if &infl then output;
         %end;
   run;
   %if &i=1 and &j=1 %then %do;
      proc print data=_label_;
         var &y &x pred studres hat difchisq difdev &bubble;
                   format hat 3.2 pred 4.3 studres 6.3 difdev difchisq 6.3;
      %if &id ^= %str() %then %do;
         id &id;
         %end;
      %else %do;
         id text;
         %put WARNING:  Observations are identified by sequential 
number (TEXT) because no ID= variable was specified.;
         %end;
      %end;
   %end;  /* &label ^= NONE */

   proc gplot data=&out &GOUT ;
     bubble &gyi * &gxj = &bubble /
           %if &label ^= NONE %then %do;
           annotate=_label_
           %end;
           frame
           vaxis=axis1 vminor=1 hminor=1
           %if &reflin ^= 0 %then %do;
           %if (&gyi = DIFDEV) or (&gyi = DIFCHISQ) %then %do;
              vref=4       lvref=&reflin  cvref=&refcol
              %end;
           %if (&gxj = HAT) %then %do;
              href= &hcrit lhref=&reflin  chref=&refcol
              %end;
           %end;
           bsize=&bsize  bcolor=&bcolor  bscale=&bscale
           name="&name"
           Des="Logistic influence plot for &y";
     axis1 label=(a=90 r=0);
   run; quit;
   %gskip;
   %end;   /* gx loop */
%end;   /* gy loop */
%done:
quit;
%mend;

%macro numwords(lst);
   %let i = 1;
   %let v = %scan(&lst,&i);
   %do %while (%length(&v) > 0);
      %let i = %eval(&i + 1);
      %let v = %scan(&lst,&i);
      %end;
   %eval(&i - 1)
%mend;

/*-------------------------------------------------------------------*
  *    Name: mosmat.sas                                               *
  *   Title: Macro interface for mosaic matrices                      *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/mosmat.html             *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *
  * Created:   3 Nov 1998 09:27:20                                    *
  * Revised:  10 Nov 2000 10:27:37                                    *
  * Version: 1.1                                                      *
  * 1.1  Fixed bug in call to panels when mosmat was called more      *
  *      than once in a job or session.                               *
  *                                                                   *
  * Requires: %gdispla, %panels                                       *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/
 /*
Description:
 
 The MOSMAT macro provides an easily used macro interface to the
 MOSAICS and MOSMAT SAS/IML programs, to create a scatterplot
 matrix of mosaic displays for all pairs of categorical variables.

 Each pairwise plot shows the marginal frequencies to the order 
specified
 by the PLOTS= parameter.  When PLOTS=2, these are the bivariate 
margins,
 and the residuals from marginal independence are shown by shading.
 When PLOTS>2, the observed frequencies in a higher-order marginal
 table are displayed, and the model fit to that marginal table is
 determined by the FITTYPE= parameter.
 
Usage:

 The parameters for the mosaic macro are like those of the SAS/IML
 programs, except:
 
* DATA=    Specifies the name of the input dataset.  Should contain
           one observation per cell, the variables listed in VAR=
           and COUNT=.  [Default: DATA=_LAST_]

* VAR=     Specifies the names of the factor variables for the 
           contingency table. Abbreviated variable lists (e.g., V1-V3) 
           are not allowed. The levels of the factor variables may be
           character or numeric, but are used as is in the input data.
           Upper/lower case in the variable names is respected in the
           diagonal label panels.
           You may omit the VAR= variables if variable names are used 
in
           the VORDER= parameter.

* COUNT=   Specifies the name of the frequency variable in the dataset.
           The COUNT= variable must be specified.

* PLOTS=   The PLOTS= parameter determines the number of table 
variables
           displayed in each pairwise mosaic. [Default: PLOTS=2]

* CONFIG=  For a user-specified model, config= gives the terms in the
           model, separated by '/'.  For example, to fit the model of
           no-three-way association, specify CONFIG=1 2 / 1 3 / 2 3,
           or (using variable names) CONFIG = A B / A C / B C.
           Note that the numbers refer to the variables after they
           have been reordered, either sorting the data set, or by the
           VORDER= parameter.

* VORDER=  Specifies either the names of the variables or their indices
           in the desired order in the mosaic.  Note that the using the
           VORDER= parameter keeps the factor levels in their order in
           the data.

* SORT=    Specifies whether and how the input data set is to be sorted
           to produce the desired order of variables in the mosaic.
           SORT=YES sorts the data in the reverse order that they are
           listed in the VAR= paraemter, so that the variables are 
           entered in the order given in the VAR= parameter.  
Otherwise,
           SORT= lists the variable names, possibly with the DESENDING
           or NOTSORTED options in the reverse of the desired order.
           e.g., SORT=C DESCENDING B DESCENDING A.
*/

%macro mosmat(
   data=_last_,     /* Name of input dataset              */
   var=,            /* Names of factor variables          */
   count=count,     /* Name of the frequency variable     */
   fittype=joint,   /* Type of models to fit              */
   config=,         /* User model for fittype='USER'      */
   devtype=gf,      /* Residual type                      */
   shade=,          /* shading levels for residuals       */
   plots=2,         /* which plots to produce             */
   colors=blue red, /* colors for + and - residuals       */
   fill=HLS HLS,    /* fill type for + and - residuals    */
   split=V H,       /* split directions                   */
   vorder=,         /* order of variables in mosaic       */
   htext=,          /* height of text labels              */
   font=,           /* font for text labels               */
   title=,          /* title for plot(s)                  */
   space=,          /* room for spacing the tiles         */
   fuzz=,           /* smallest abs resid treated as zero */
        abbrev=,         /* abbreviate variable names in model */
   sort=YES,        /* Sort variables first?              */
   );

%if %length(&var)=0 & %length(&vorder)>0 %then %do;
        %if %verify(&vorder, %str(0123456789 ))>0 %then %let var=&vorder;
        %end;

%if %length(&var)=0 %then %do;
   %put ERROR: You must specify the VAR= classification variables.;
   %goto done;
   %end;

%if %length(&count)=0 %then %do;
   %put ERROR: You must specify the COUNT= frequency variable.;
   %goto done;
   %end;

%if %upcase(&data)=_LAST_ %then %let data = &syslast;
%let sort=%upcase(&sort);
%if &sort^=NO %then %do;
   %if &sort=YES %then %let sort=%reverse(&var);
   proc sort data=&data out=_sorted_;
      by &sort;
        %let data=_sorted_;
%end;
   
%if %upcase(&fittype)=USER and %length(&config)=0 %then %do;
   %put ERROR: You must specify the USER model with the CONFIG= 
argument;
   %goto done;
   %end;
   
%if %length(&config) %then %do;
   %*-- Translate / in config to , for iml;
   data _null_;
      length config $ 200;
      config = "&config";
      config = translate(config, ',', '/');
      call symput('config', trim(config));
   run;
   %put config: &config;
%end;

%gdispla(OFF);

   %*--Becuase of the large number of modules loaded, it may be
       necessary to adjust the symsize value;
proc iml /* worksize=10000 */ symsize=256;
   reset storage=mosaic.mosaic;
   load module=_all_;

   %include mosaics(mosmat); 

start str2vec(string);
   *-- String to character vector;
   free out;
   i=1;
   sub = scan(string,i,' ');
   do while(sub ^=' ');
      out = out || sub;
      i = i+1;
      sub = scan(string,i,' ');
   end;
   return(out);
   finish;

start symput(name, val);
   *-- Create a macro variable from a char/numeric scalar;
   if type(val) ='N'
      then value = trim(char(val));
      else value = val;
   call execute('%let ', name, '=', value, ';');
   finish;

   vnames = str2vec("&var");    *-- Preserve case of var names;

   %*-- Read and reorder counts;
   run readtab("&data","&count", vnames, table, levels, lnames);
   nv = ncol(levels);
   run symput('nv', nv);
   %if %length(&vorder) %then %do;
      vorder  = { &vorder };
      run reorder(levels, table, vnames, lnames, vorder);
      %end;

   %*-- These variables have their defaults set in mosaics(globals);
        %*   (Dont set them here unless passed as parameters.);
   %if %length(&space)>0 %then %do;
      space={&space};
      %end;
   %if %length(&shade)>0 %then %do;
      shade={&shade};
      %end;

   %*-- These variables have their defaults set in mosmat module;
   %if %length(&htext)>0 %then %do;
      htext=&htext;
      %end;
   %if %length(&font)>0 %then %do;
      font = "&font";
      %end;

   colors={&colors};
   filltype={&fill};
   split={&split};
   title = "&title";
   fittype = "&fittype";
   devtype = "&devtype";
   %if %length(&config)>0 %then %do; config=t({&config}); %end;
   %if %length(&fuzz)>0   %then %do; fuzz=&fuzz;  %end;
   %if %length(&abbrev)>0 %then %do; abbrev=&abbrev;  %end;

   plots = &plots;
   run mosmat(levels, table, vnames, lnames, plots, title);
quit;
%gdispla(ON);
%if &nv>0 %then %do;
        %let first = %eval(1 - &nv*&nv);
   %panels(rows=&nv, cols=&nv, order=down, first=&first, last=0);
        %end;

%done:

%mend;

%macro reverse(list);
   %local result i v;
   %let result =;
   %let i = 1;
   %let v = %scan(&list,&i,%str( ));
   %do %while (%length(&v) > 0);
      %let result = &v &result;
      %let i = %eval(&i + 1);
      %let v = %scan(&list,&i,%str( ));
      %end;
   &result
%mend;

/*-------------------------------------------------------------------*
  *    Name: pscale.sas                                               *
  *   Title: Construct annotations for a probability scale            *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/pscale.html             *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *
  * Created:  2 Nov 1995 12:07:41                                     *
  * Revised:  4 Dec 1997 12:07:41                                     *
  * Version: 1.0                                                      *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/
 /* Description:
 
 The PSCALE macro constructs an annotate data set to draw an unequally-
 spaced scale of probability values on the vertical axis of a plot
 (at either the left or right).  The probabilities are assumed to 
 correspond to equally-spaced values on a scale corresponding to
 Normal quantiles (using the probit transformation) or Logistic
 quantiles (using the logit transformation).

Usage:

 The PSCALE macro is called with keyword parameters.
 The arguments may be listed within parentheses in any order, separated
 by commas. For example: 
 
        %pscale(out=pscale);
        proc gplot;
                plot logit * X / anno=pscale;
 
Parameters:

* ANNO=       Name of annotate data set [Default: ANNO=PSCALE]

* OUT=        Synonym for ANNO=

* SCALE=      Linear scale: logit or probit [Default: SCALE=LOGIT]

* LO=         Low scale value [Default: LO=-3]

* HI=         High scale value [Default: HI=3]

* PROB=       List of probability values to be displayed on the axis,
              in the form of a list acceptable in a DO statement.
              [Default: PROB=%str(.05, .1 to .9 by .1, .95)]

* AT=         X-axis percent for the axis.  AT=100 plots the axis at
              the right; AT=0 plots the axis at the left. [Default: 
AT=100]

* TICKLEN=    Length of tick marks [Default: TICKLEN=1.3]

* SIZE=       Size of value labels

* FONT=       Font for value labels
                
 */
 
%macro pscale(
        anno=pscale,      /* name of annotate data set     */
        out=,             /* synonym for anno=             */
        scale=logit,      /* linear scale: logit or probit */
        lo=-3,            /* low scale value               */
        hi=3,             /* high scale value              */
        prob=%str(.05, .1 to .9 by .1, .95),
        at=100,           /* x-axis percent for the axis   */
        ticklen=1.3,      /* length of tick marks          */
        size=,            /* size of value labels          */
        font=             /* font for value labels         */
        );

%let scale=%upcase(&scale);
%if %length(&out) %then %let anno=&out;

data &anno;
   xsys = '1';            * percent values for x;
   ysys = '2';            * data values for y;
   length text $4 function $8;
        %if %length(&font) %then %do;
           style="&font";
                %end;
        %if %length(&size) %then %do;
           size=&size;
                %end;
        drop prob scale;
        loc = &at;
   do prob = &prob ;
                %if &scale=LOGIT %then %do;
        scale = log( prob / (1-prob) );   * convert to logit;
                        %end;
                %else %if &scale=PROBIT %then %do;
        scale = probit( prob );           * convert to normal 
quantile;
                        %end;
                %else %do;
                        scale = &scale;
                        %end;

      if (&lo <= scale <= &hi) then do;
         y = scale;
         x = &at + sign(50-&at)*&ticklen; function='MOVE';
                                output;   * tick marks;
         x = &at;  function='DRAW ';
                                output;
         text = put(prob,3.2);
                        position='6';  * values;
         function='LABEL  '; output;
         end;
      end;
        run;
%mend;

/*-------------------------------------------------------------------*         
  *    Name: biplot.sas                                               *
  *   Title: Generalized biplot of observations and variables         *
  *          Uses IML.                                                *         
  *     Doc: http://www.math.yorku.ca/SCS/vcd/biplot.html             *
  *-------------------------------------------------------------------*         
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *         
  * Created:   1 Mar 1989 13:16:36                                    *         
  * Revised:   9 Nov 2000 11:33:21                                    *         
  * Version:  1.9                                                     *         
  * 1.5  Added dimension labels, fixed problem with dim=3,            *
  *      Added colors option, Fixed problem with var=_NUM_            *
  * 1.6  Added power transformation (for log(freq))                   *
  *      Added point symbols, marker styles (interp=)                 *
  *      Made ID optional, can be char or numeric                     *
  *      Fixed bug introduced with ID                                 *
  * 1.7  Added code to equate axes if HAXIS= and VAXIS= are omitted   *
  *      Added code to preserve case of variable names                *
  *      Fixed positioning of variable names                          *
  * 1.8  Allow abbreviated variable lists (X1-X5, etc.)               *
  *      Allow glm-style input (var=A B, response=Y, id=)             *
  *      Added VTOH for PPLOT printer plots                           *
  *      Added FACTYPE=COV and VARDEF=N-1 (Tokuhisa SUZUKI)           *
  * 1.9  Aded POWER= for analysis of log freq & other generalizations *
  *      Added HTEXT= to control size of obs/var labels               *
  *                                                                   *         
  *      From ``SAS System for Statistical Graphics, First Edition''  *         
  *      Copyright(c) 1991 by SAS Institute Inc., Cary, NC, USA       *         
  *      ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/        

 /* Description:
 
 The BIPLOT macro produces generalized biplot displays for multivariate
 data, and for two-way and multi-way tables of either quantitative
 or frequency data.  It also produces labeled plots of the row and
 column points in 2 dimensions, with a variety of graphic options,
 and the facility to equate the axes automatically.


Input data:

 The macro takes input in one of two forms:

 (a) A data set in table form, where the columns are separate
 variables and the rows are separate observations (identified by
 a row ID variable).    In this arrangment, use the VAR= argument
 to specify this list of variables and the ID= variable to specify
 an additional variable whose values are labels for the rows.
 
 Assume a dataset of reaction times to 4 topics in 3 experimental 
tasks,
 in a SAS dataset like this:

     TASK   TOPIC1   TOPIC2   TOPIC3   TOPIC4
          Easy     2.43     3.12     3.68     4.04
          Medium   3.41     3.91     4.07     5.10
          Hard     4.21     4.65     5.87     5.69
             
 For this arrangment, the macro would be invoked as follows:
   %biplot(var=topic1-topic4, id=task);

 (b) A contingency table in frequency form (e.g., the output from
 PROC FREQ), or multi-way data in the univariate format used as
 input to PROC GLM.  In this case, there will be two or more factor
 (class) variables, and one response variable, with one observation
 per cell.  For this form, you must use the VAR= argument to
 specify the two (or more) factor (class) variables, and specify
 the name of response variable as the RESPONSE= parameter. Do not 
specify
 an ID= variable for this form.

 For contingency table data, the response will be the cell frequency, 
and
 you will usually use the POWER=0 parameter to perform an analysis of
 the log frequency.
  
 The same data in this format would have 12 observations, and look 
like:

                TASK  TOPIC    RT
                Easy    1     2.43
                Easy    2     3.12
                Easy    3     3.68
                ...
                Hard    4     5.69
                
 For this arrangment, the macro would be invoked as follows:
   %biplot(var=topic task, response=RT);

 In this arrangement, the order of the VAR= variables does not matter.
 The columns of the two-way table are determined by the variable which
 varies most rapidly in the input dataset (topic, in the example).

Usage:

 The BIPLOT macro is defined with keyword parameters.  The VAR=
 parameter must be specified, together with either one ID= variable
 or one RESPONSE= variable.

 The arguments may be listed within parentheses in any order, separated
 by commas. For example: 
 
        %biplot();
 
 The plot may be re-drawn or customized using the output OUT=
 data set of coordinates and the ANNO= Annotate data set.

 The graphical representation of biplots requires that the axes in the
 plot are equated, so that equal distances on the ordinate and abscissa
 represent equal data units (to perserve distances and angles in the 
plot).
 A '+', whose vertical and horizontal lengths should be equal,
 is drawn at the origin to indicate whether this has been achieved.

 If you do not specifiy the HAXIS= and YAXIS= parameters, the EQUATE
 macro is called to generate the AXIS statements to equate the
 axes.  In this case the INC=, XEXTRA=, and YEXTRA=, parameters
 may be used to control the details of the generated AXIS statements.

 By default, the macro produces and plots a two-dimensional solution.

Parameters:

* DATA=          Specifies the name of the input data set to be 
analyzed.
             [Default: DATA=_LAST_]

* VAR=           Specifies the names of the column variables 
             when the data are in table form, or the names of the
                                 factor variables when the data are in 
frequency form
                                 or GLM form. [Default: VAR=_NUM_]

* ID=        Observation ID variable when the data are in table form.

* RESPONSE=  Name of the response variable (for GLM form)    

* DIM=       Specifies the number of dimensions of the CA/MCA solution.
             Only two dimensions are plotted by the PPLOT and GPLOT 
options,
                                 however. [Default: DIM=2]

* FACTYPE=   Biplot factor type: GH, SYM, JK or COV [Default: 
FACTYPE=SYM]

* VARDEF=    Variance def for FACTYPE=COV: DF | N [Default: VARDEF=DF]

* SCALE=     Scale factor for variable vectors [Default: SCALE=1]

* POWER=     Power transform of response [Default: POWER=1]

* OUT=           Specifies the name of the output data set of 
coordinates.
             [Default: OUT=BIPLOT]

* ANNO=          Specifies the name of the annotate data set of 
labels
             produced by the macro.  [Default: ANNO=BIANNO]

* STD=       How to standardize columns: NONE|MEAN|STD [Default: 
STD=MEAN]

* COLORS=    Colors for OBS and VARS [Default: COLORS=BLUE RED]

* SYMBOLS=   Symbols for OBS and VARS [Default: SYMBOLS=NONE NONE]

* INTERP=    Markers/interpolation for OBS and VARS. [Default: 
INTERP=NONE VEC]

* LINES=     Lines for OBS and VARS interpolation [Default: LINES=33 
20]

* PPLOT=     Produce a printer plot? [Default: PPLOT=NO]

* VTOH=      The vertical to horizontal aspect ratio (height of one
             character divided by the width of one character) of the
                                 printer device, used to equate axes for a 
printer plot,
                                 when PPLOT=YES.  [Default: VTOH=2]

* GPLOT=     Produce a graphics plot? [Default: GPLOT=YES]

* PLOTREQ=   The dimensions to be plotted [Default: PLOTREQ=DIM2*DIM1]

* HAXIS=     AXIS statement for horizontal axis.  If both HAXIS= and
             VAXIS= are omitted, the program calls the EQUATE macro to
                                 define suitable axis statements.  This creates 
the axis
                                 statements AXIS98 and AXIS99, whether or not a 
graph
                                 is produced.

* VAXIS=     The name of an AXIS statement for the vertical axis.

* INC=       The length of X and Y axis tick increments, in data units
             (for the EQUATE macro).  Ignored if HAXIS= and VAXIS= are
             specified. [Default: INC=0.5 0.5]

* XEXTRA=    # of extra X axis tick marks at the left and right.  Use 
to
             allow extra space for labels. [Default: XEXTRA=0 0]

* YEXTRA=    # of extra Y axis tick marks at the bottom and top.
             [Default: YEXTRA=0 0]

* M0=        Length of origin marker, in data units. [Default: M0=0.5]

* DIMLAB=    Prefix for dimension labels [Default: DIMLAB=Dimension]

* NAME=      Name of the graphics catalog entry [Default: NAME=BIPLOT]        

 */
                                                                                 
%macro biplot(                                                                  
        data=_LAST_,       /* Data set for biplot                       
*/         
        var=_NUM_,         /* Variables for biplot                      
*/         
        id=,               /* Observation ID variable (obs x var input) 
*/
        response=,         /* Name of response variable (glm input)     
*/    
        dim=2,             /* Number of biplot dimensions               
*/         
   factype=SYM,       /* Biplot factor type: GH, SYM, JK or COV    */
        vardef=DF,         /* Variance def for factype=COV: DF | N      
*/
        scale=1,           /* Scale factor for variable vectors         
*/
        power=1,           /* Power transform of response               
*/
        out=BIPLOT,        /* Output dataset: biplot coordinates        
*/         
        anno=BIANNO,       /* Output dataset: annotate labels           
*/         
        std=MEAN,          /* How to standardize columns: NONE|MEAN|STD 
*/
        colors=BLUE RED,   /* Colors for OBS and VARS                   
*/
        symbols=none none, /* Symbols for OBS and VARS                  
*/
        interp=none vec,   /* Markers/interpolation for OBS and VARS    
*/          
        lines=33 20,       /* Lines for OBS and VARS interpolation      
*/
        pplot=NO,          /* Produce printer plot?                     
*/
        vtoh=2,            /* PPLOT cell aspect ratio                   
*/
        gplot=YES,         /* Produce hi-res plot?                      
*/
        plotreq=,          /* dimensions to be plotted                  
*/
        haxis=,            /* AXIS statement for horizontal axis        
*/
        vaxis=,            /* and for vertical axis- use to equate axes 
*/
        inc=0.5 0.5,       /* x, y axis tick increments                 
*/
        xextra=0 0,        /* # of extra x axis tick marks              
*/
        yextra=0 0,        /* # of extra y axis tick marks              
*/
        m0=0.5,            /* Length of origin marker                   
*/
        dimlab=,           /* Dimension label                           
*/
        htext=1.5,
        name=biplot        /* Name for graphics catalog entry           
*/
        );        
                                                                                
%let abort=0;
%let std=%upcase(&std);
%let pplot=%upcase(&pplot);
%let gplot=%upcase(&gplot);
                                              
%if %length(&vardef) = 0 %then %let vardef=N;
%if %upcase(&vardef) = DF %then %let vardef = %str( N - 1 ) ;

%let factype=%upcase(&factype);                                                 
      %if &factype=GH  %then %let p=0;                                          
%else %if &factype=SYM %then %let p=.5;                                         
%else %if &factype=JK  %then %let p=1;                                          
%else %if &factype=COV %then %let p=0 ;
%else %do;                                                                      
   %put BIPLOT: FACTYPE must be GH, SYM, JK, or COV "&factype" is not 
valid.;
        %let abort=1;       
   %goto done;                                                                  
   %end;                                                                        
%if &data=_LAST_ %then %let data=&syslast;

%* --- Transform variable lists (X1-X10) into expanded form for IML ---
;
%if %index(&var,-) >0 or 
        "%upcase(&var)"="_NUM_" or 
        "%upcase(&var)"="_NUMERIC_"  %then
 %do;
 %let ovar = &var;
 data _null_;
    set &data (obs=1);
       %*-- convert shorthand variable list to long form;
     length _vname_ $ 8 _vlist_ $ 200;
     array _xx_ &var;
     _vname_ = ' ';
          i=0;
     do over _xx_;
        call vname(_xx_,_vname_);
        _vlist_ = trim(_vlist_)|| ' ' || trim(_vname_);
                  i+1;
     end;
     call symput( 'VAR', trim(_vlist_) );
     call symput( 'NV', trim(put(i,2.0)) );
          put "NOTE:  Variable list (&ovar) expanded to VAR=" _vlist_;
  run;
  %if &nv=0 %then %do;
    %put ERROR: No variables were found in the VAR=&ovar list;
    %goto DONE;
                %end;
  %end;

%if %length(&id) = 0 %then %do;
    %if %bquote(%scan(&var,2,%str( ))) = %str() or
             %length(&response)=0 %then %do;
    %put ERROR: When no ID= variable is specified, you must supply
              two+ VAR= variable names, and the name of the RESPONSE=
                        variable.;
    %goto DONE;
         %end;
%end;

                                                                                
%*-- Set defaults which depend on other options;
%if %length(&plotreq)=0 %then %do;
        %if &dim=2 %then %let plotreq =  dim2 * dim1;
        %if &dim=3 %then %let plotreq =  dim2 * dim1 = dim3;
        %else %let plotreq =  dim2 * dim1;
        %end;

%if %length(&dimlab)=0 %then %do;
        %if &dim=2 %then %let dimlab = Dimension;
        %if &dim=3 %then %let dimlab = Dim;
        %end;

proc iml;                                                                       
start biplot(y,id,vars,out, g, scale);                                      
   N = nrow(Y);                                                                 
   P = ncol(Y);                                                                 
   %if &std = NONE                                                              
       %then Y = Y - Y[:] %str(;);             /* remove grand mean */          
       %else Y = Y - J(N,1,1)*Y[:,] %str(;);   /* remove column means 
*/        
   %if &std = STD %then %do;                                                    
      S = sqrt(Y[##,] / ( &vardef ) );
      Y = Y * diag (1 / S );                                                    
   %end;                                                                        
   print "Standardization Type: &std  (VARDEF = &vardef) " ;
                                                                                
   *-- Singular value decomposition:                                            
        Y is expressed as U diag(Q) V prime                                     
        Q contains singular values, in descending order;                        
   call svd(u,q,v,y);                                                           
                                                                                
   reset fw=8 noname;                                                           
   percent = 100*q##2 / q[##];                                                  
   cum = cusum(percent);                                                           
   c1={'Singular Values'};                                                      
   c2={'Percent'};                                                              
   c3={'Cum % '};                                                               
        ls = 40;
        do i=1 to nrow(q);
                row = cshape('*', 1, 1, round(ls#percent[i]/max(percent)));
                hist = hist // cshape(row,1,1,ls,' ');
                end;
   print "Singular values and variance accounted for",,                         
         q       [colname=c1 format=9.4 ]                                       
         percent [colname=c2 format=8.2 ]                                       
         cum     [colname=c3 format=8.2 ]
                        hist    [colname={'Histogram of %'}];                                     
                                                                                
   d = &dim ;
        *-- Assign macro variables for dimension labels;
        lab = '%let p' + char(t(1:d),1) + '=' + 
left(char(percent[t(1:d)],8,1)) + ';';
        call execute(lab);

   *-- Extract first  d  columns of U & V, and first  d  elements of Q;         
   U = U[,1:d];                                                                 
   V = V[,1:d];                                                                 
   Q = Q[1:d];                                                                  
                                                                                
   *-- Scale the vectors by QL, QR;                                             
   * Scale factor 'scale' allows expanding or contracting the variable          
     vectors to plot in the same space as the observations;                     
   QL= diag(Q ## g );                                                       
   QR= diag(Q ## (1-g));                                                    
   A = U * QL;                                                                  
   B = V * QR;
        ratio = max(sqrt(A[,##])) /  max(sqrt(B[,##]));
        if scale=0 then scale=ratio;                                                         
        print 'OBS / VARS ratio:' ratio 'Scale:' scale;
   B = B # scale;                                                          

  %if %upcase( &factype ) = COV %then
    %do ;
      A = sqrt( &vardef       ) # A ;
      B = ( 1 / sqrt(&vardef) ) # B ;
    %end ;
   OUT=A // B;                                                                  
                                                                                
   *-- Create observation labels;                                               
   id = shape(id,n,1) // shape(vars,p,1);                                                            
   type = repeat({"OBS "},n,1) // repeat({"VAR "},p,1);                         
   id  = concat(type, id);                                                      
                                                                                
        if upcase("&factype")='COV'
                then factype='COV';
        else factype = {"GH" "Symmetric" "JK"}[1 + 2#g];                              
   print "Biplot Factor Type", factype;                                         
                                                                                
   cvar = concat(shape({"DIM"},1,d), char(1:d,1.));                             
   print "Biplot coordinates",                                                  
         out[rowname=id colname=cvar f=9.4];

   create &out  from out[rowname=id colname=cvar];                              
   append from out[rowname=id];                                                 
finish;                                                                         

start power(x, pow);
                if pow=1 then return(x);
                if any(x <= 0) then x = x + ceil(min(x)+.5);
                if abs(pow)<.001 then xt =  log(x);
                        else xt = ((x##pow)-1) / pow;
        return (xt);
        finish;

start str2vec(string);
        *-- String to character vector;
   free out;
   i=1;
   sub = scan(string,i,' ');
   do while(sub ^=' ');
      out = out || sub;
      i = i+1;
      sub = scan(string,i,' ');
   end;
        return(out);
        finish;

/* --------------------------------------------------------------------
 Routine to read frequency and index/label variables from a SAS dataset
 and construct the appropriate levels, and lnames variables

 Input:  dataset - name of SAS dataset (e.g., 'mydata' or 'lib.nydata')
         variable - name of variable containing the response
                   vnames - character vector of names of index variables
 Output: dim (numeric levels vector)
         lnames (K x max(dim)) 
  --------------------------------------------------------------------
*/
 
start readtab(dataset, variable, vnames, table, dim, lnames);
        if type(vnames)^='C'
                then do;
                        print 'VNAMES argument must be a character vector';
                        show vnames;
                        return;
                end;            
   if nrow(vnames)=1 then vnames=vnames`;

        call execute('use ', dataset, ';');
        read all var variable into table;
        run readlab(dim, lnames, vnames);
        call execute('close ', dataset, ';');
        reset noname;
        print 'Variable' variable 'read from dataset' dataset,
                'Factors ordered:' vnames lnames;
        reset name;
        finish;

/* Read variable index labels from an open dataset, construct a dim 
   vector and lnames matrix so that variables are ordered correctly
   for mosaics and ipf (first varying most rapidly).

        The data set is assumed to be sorted by all index variables.  If
        the observations were sorted by A B C, the output will place
        C first, then B, then A.
   Input:    vnames (character K-vector)
 */

start readlab(  dim, lnames, vnames);
        free span lnames dim;
        nv = nrow(vnames);

        spc = '        ';
        do i=1 to nv;
                vi = vnames[i,];
                read all var vi into cli;
                if type(cli) = 'N'
                        then do;
                                tmp = trim(left(char(cli,8)));
                                tmp = substr(tmp,1,max(length(tmp)));
                                cli = tmp;
                                end; 
                cli = trim(cli); 
                span = span || loc(0=(cli[1,] = cli))[1];
                d=design( cli );
                dim = dim || ncol(d);
                free row1;
                *-- find position of each first distinct value;
                do j=1 to ncol(d);
                        row1 = row1 || loc(d[,j]=1)[1];
                        end;
                *-- sort elements in row1 so that var labels are in data 
order;
                order = rank(row1);
                tmp = row1;
                row1[,order]=tmp;       

                li = t(cli[row1]);
                if i=1 then lnames = li;
                        else do;
                                if ncol(lnames) < ncol(row1) 
                                        then lnames=lnames || repeat(spc, i-1, 
ncol(row1)-ncol(lnames));
                                if ncol(lnames) > ncol(row1)
                                        then li = li || repeat(spc, 1, 
ncol(lnames)-ncol(li));
                                lnames = lnames // li;
                        end;
                end;

        *-- sort index variables by span so that last varies most slowly;
        order = rank(span);
        tmp = span;    span[,order] = tmp;
        tmp = dim;     dim[,order] = tmp;
        tmp = lnames;  lnames[order,] = tmp;
        tmp = vnames;  vnames[order,] = tmp;
        finish;
 
start cellname(dim,lnames);
   cn = '';
        d = dim;
   if nrow(dim)=1 then d = dim`;
   do f=nrow(d) to 1 by -1;
      r  = nrow(cn);
      ol = repeat( cn, 1, d[f]);
      ol = shape(ol, r#d[f], 1);
      nl = repeat( (lnames[f,(1:d[f])])`, r,1);
                if f=nrow(d)
                        then cn = trim(nl);
        else cn = trim(nl)+':'+trim(ol);
      end;
   return(cn);
   finish;
 

        /*--- Main routine */

        %if %length(&id) = 0 %then %do;
                run readtab("&data", "&response", {&var}, y, dim, lnames);
                cvar = 1;
                rvar = (cvar+1):ncol(dim);
                y = shape(y, (dim[rvar])[#], dim[1:cvar]);
                vars = lnames[1,1:dim[1]];
                if ncol(dim)=2 
                        then id = t(lnames[2,1:dim[2]]);
                        else id = cellname( dim[rvar], lnames[rvar,]);
                %end;
   %else %do; 
          use &data;
     read all var{&var} into y;
     read all var{&id} into id;
     vars = str2vec("&var");          *-- Preserve case of var names;
          %end;

        %if &power ^= 1 %then %do;
                y = power(y, &power);
                %end;

   scale = &scale;                                                              
   run biplot(y, id, vars, out, &p, scale );                                  
   quit;                                                                        
                                                                                
 /*----------------------------------*                                          
  |  Split ID into _TYPE_ and _NAME_ |                                          
  *----------------------------------*/                                         

data &out;                                                                      
   set &out;                                                                    
   drop id;                                                                     
   length _type_ $3 _name_ $16;                                                 
   _type_ = substr(id,1,3);                                                     
   _name_ = substr(id,5);                                                       
   label                                                                        
   %do i=1 %to &dim;                                                            
       dim&i = "&dimlab &i (&&p&i%str(%%))"                                                   
       %end;                                                                    
   ;                                                                            
 /*--------------------------------------------------*                          
  | Annotate observation labels and variable vectors |                          
  *--------------------------------------------------*/                         
        %local c1 c2 v1 v2 i1 i2 h1 h2;
        %*-- Assign colors and symbols;
        %let c1= %scan(&colors,1);                                                      
        %let c2= %scan(&colors,2);
        %if &c2=%str() %then %let c2=&c1;                                                   

        %let v1= %upcase(%scan(&symbols,1));                                                      
        %let v2= %upcase(%scan(&symbols,2));
        %if &v2=%str() %then %let v2=&v1;                                                   

        %let i1= %upcase(%scan(&interp,1));                                                      
        %let i2= %upcase(%scan(&interp,2));
        %if &i2=%str() %then %let i2=&i1;                                                   

        %let l1= %upcase(%scan(&lines,1));                                                      
        %let l2= %upcase(%scan(&lines,2));
        %if &l2=%str() %then %let l2=&l1;                                                   

        %if %length(&htext) %then %do;
                %let h1= %upcase(%scan(&htext,1));                                                      
                %let h2= %upcase(%scan(&htext,2,%str( )));
                %if &h2=%str() %then %let h2=&h1;                                                   
                %end;

        %*-- Plot increments;
        %let n1= %scan(&inc,1,%str( ));                                                      
        %let n2= %scan(&inc,2,%str( ));
        %if &n2=%str() %then %let n2=&n1;

        %*-- Find dimensions to be ploted;
        %let ya = %scan(&plotreq,1,%str(* ));
        %let xa = %scan(&plotreq,2,%str(* ));
        %let za = %scan(&plotreq,3,%str(=* ));

%if &pplot = YES %then %do;
        %put WARNING: Printer plots may not equate axes (using 
VTOH=&vtoh);                                                     
   %if &sysver < 6.08
       %then %do;
          %put WARNING: BIPLOT cannot label points adequately using
               PROC PLOT in SAS &sysver - use SAS 6.08 or later;
          %let symbol = %str( = _name_ );
          %let place =;
                         %let axes=;
       %end;
       %else %do;
           %let symbol = $ _name_ = '*';
           %let place = placement=((h=2 -2 : s=right left)
                                   (v=1 -1 * h=0 -1 to -3 by alt)) ;
                          %let axes = haxis = by &n1 vaxis = by &n2 ;
       %end;
 
        proc plot data=&out vtoh=&vtoh;
                plot &ya * &xa &symbol
                        / &axes &place box;
%end;


data &anno;                                                                     
   set &out;                                                                    
   length function color $8 text $16;                                                 
   xsys='2'; ysys='2'; %if &dim > 2 %then %str(zsys='2';);                                               
   text = _name_;                                                               
                                                                                
   if _type_ = 'OBS' then do;         /* Label observations (row 
points) */             
      color="&c1";                                                            
%*              if "&i1" = 'NIL' then return;                                                            
                if "&i1" = 'VEC' then link vec;                                                            
      x = &xa; y = &ya;                                                       
      %if &dim > 2 %then %str(z = &za;);
                %if &v1=NONE %then                                     
        %str(position='5';);
                %else %do;
      if &xa >=0                                                               
         then position='>';             /* rt justify         */                
         else position='<';             /* lt justify         */                
      if &ya >=0                                                               
         then position='2';             /* up justify         */                
         else position='E';             /* down justify       */
                        %end;
                size = &h1;                
      function='LABEL   '; output;                                              
      end;                                                                      
                                                                                
   if _type_ = 'VAR' then do;           /* Label variables (col points) 
*/                
      color="&c2";
                if "&i2" = 'VEC' then link vec;                                                            
      x = &xa; y = &ya;                
      %if &dim > 2 %then %str(z = &za;);
                %if &v2=NONE %then                                     
        %str(position='5';);
                %else %do;
      if &ya >=0                                                               
         then position='2';             /* up justify         */                
         else position='E';             /* down justify       */
                        %end;                
                size = &h2;                
      function='LABEL   '; output;      /* variable name      */                
      end;                                                                      
                return;

vec:                    /* Draw line from the origin to point */
      x = 0; y = 0;                
      %if &dim > 2 %then %str(z = 0;);                                          
      function='MOVE'    ; output;                                              
      x = &xa; y = &ya;                
      %if &dim > 2 %then %str(z = &za;);                                       
      function='DRAW'    ; output;                                              
                return;

 /*--------------------------------------------------*
  | Mark the origin                                  |
  *--------------------------------------------------*/
%if &m0 > 0 %then %do;
data _zero_;
        xsys='2';  ysys='2';
        %if &dim=3 %then %do; zsys='2'; z=0; %end;             
        x = -&m0;  y=0;   function='move'; output;
        x =  &m0;         function='draw'; output;
        x = 0;  y = -&m0; function='move'; output;
                y =  &m0; function='draw'; output;

data &anno;                                                                     
   set &anno _zero_;                                                                    
%end;

%if %length(&vaxis)=0 and %length(&haxis)=0 %then %do;
        %let x1= %scan(&xextra,1);                                                      
        %let x2= %scan(&xextra,2);
        %if &x2=%str() %then %let x2=&x1;
        %let y1= %scan(&yextra,1);                                                      
        %let y2= %scan(&yextra,2);
        %if &y2=%str() %then %let y2=&y1;

        %equate(data=&out, x=&xa, y=&ya, plot=no,
                vaxis=axis98, haxis=axis99, xinc=&n1, yinc=&n2,
                xmextra=&x1, xpextra=&x2, ymextra=&y1, ypextra=&y2);
        %let vaxis=axis98;
        %let haxis=axis99;
        options nonotes;
        %end;
%else %do;
%if %length(&vaxis)=0 %then %do;
        %let vaxis=axis98;
        %put WARNING:  You should use an AXISn statement and specify 
VAXIS=AXISn to equate axis units and length;
   axis98 label=(a=90);
        %end;
%if %length(&haxis)=0 %then %do;
        %let haxis=axis99;
        %put WARNING:  You should use an AXISm statement and specify 
HAXIS=AXISm to equate axis units and length;
   axis99 offset=(2);
        %end;
%end;


symbol1 v=&v1 c=&c1 i=&i1 l=&l1;
symbol2 v=&v2 c=&c2 i=&i2 l=&l2;
%if &gplot = YES %then %do;
        %if &i1=VEC %then %let i1=NONE;
        %if &i2=VEC %then %let i2=NONE;
        %let legend=nolegend;

/*
        %let warn=0;
   %if %length(&haxis)=0 %then %do;
                %let warn=1;
                axis2 offset=(1,5) ;
      %let haxis=axis2;
      %end;
   %if %length(&vaxis)=0 %then %do;
                %let warn=1;
                axis1 offset=(1,5) label=(a=90 r=0);
      %let vaxis=axis1;
      %end;
        %if &warn %then %do;
                %put WARNING:  No VAXIS= or HAXIS= parameter was specified, 
so the biplot axes have not;
                %put WARNING:  been equated.  This may lead to incorrect 
interpretation of distance and;
                %put WARNING:  angles.  See the documentation.;
                %end;
*/

        proc gplot data=&out &GOUT;
                plot &ya * &xa = _type_/ 
                        anno=&anno frame &legend
                        %if &m0=0 %then %do;
                        href=0 vref=0 lvref=3 lhref=3
                        %end;
                        vaxis=&vaxis haxis=&haxis
                        vminor=1 hminor=1
                        name="&name" des="Biplot of &data";
        run; quit;
*       goptions reset=symbol;
        %end;  /* %if &gplot=YES */

%done:                                                                          
%mend BIPLOT;                                                                   

/*-------------------------------------------------------------------*
  *    Name: gdispla.sas                                              *
  *   Title: Device-independent DISPLAY/NODISPLAY control             *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/gdispla.html            *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *
  * Created: 14 Feb 91 11:19                                          *
  * Revised: 04 Jan 99 12:39                                          *
  * Version: 1.0                                                      *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/
 /* Description:
 
 The GDISPLA macro is used to switch graphics display off or on in
 a device-independent way.  It allows for the fact that for direct
 output to the display device, the required GOPTIONS are NODISPLAY
 or DISPLAY, whereas for output to a GSF, GIF, or EPS file, the options
 are GSFMODE=NONE or GSFMODE=APPEND.  It is usually used with the
 PANELS macro or the SCATMAT macro, or other programs which produce
 multiple plots and then join those plots in a template using
 PROC GREPLAY.

Usage:

 The GDISPLA macro is called with positional parameters.  The first
 (SWITCH) parameter must be specified.
 
        %let devtype=SCREEN;
        %gdispla(OFF);
        proc gplot;
                plot y * x;
                by group;
        %gdispla(ON);
        %panels(rows=1, cols=3);
 
Parameters:

* SWITCH        A string value, OFF or ON.

* IML           Specify any non-blank value to use the GDISPLA macro
                within SAS/IML.

Global parameters:

The macro uses one global macro parameter, DEVTYP, to determine the
appropriate action. This parameter is normally initialized either in 
the AUTOEXEC.SAS file, or in device-specific macros

* DEVTYP    String value, the type of graphic device driver.  The
            values EPS, GIF, CGM and WMF cause the macro to use
                                the GSMODE option; the value DEVTYP=SCREEN 
causes the
                                macro to use the DISPLAY or NODISPLAY option.
                                All other values are ignored.

 */

%macro gdispla(
          switch,
          iml
                         );

%global DISPLAY DEVTYP;

   %let switch=%upcase(&switch);
   %let devtyp=%upcase(&devtyp);
   %if &switch=ON %then %do;
                %let DISPLAY=ON;
       %if &devtyp=SCREEN /*and &sysver=5.18 */
           %then %let cmd= %str(GOPTIONS DISPLAY;);
           %else
                          %if &devtyp=EPS or &devtyp=GIF
                 or &devtyp=CGM or &devtyp=WMF 
                                        %then %let cmd= %str(GOPTIONS DISPLAY 
GSFMODE=REPLACE;);
                                        %else %let cmd= %str(GOPTIONS DISPLAY 
GSFMODE=APPEND;);
       %end;
   %else %if &switch=OFF %then %do;
                %let DISPLAY=OFF;
       %if &devtyp=SCREEN /*and &sysver=5.18  */
           %then %let cmd= %str(GOPTIONS NODISPLAY;);
           %else %let cmd= %str(GOPTIONS NODISPLAY GSFMODE=NONE;);
       %end;
   %else %put ERROR in GDISPLA: SWITCH must be ON or OFF;

        %if &iml = %str() %then %do;
                run;
                &cmd;
                %*put GDISPLA: &cmd;
                %end;
        %else %do;              /* Called from IML */
                start command(cmd);
                        call execute(cmd);
                finish;
                run command("&cmd");
                %end;
        
%mend gdispla;

/*-------------------------------------------------------------------*
  *    Name: interact.sas                                             *
  *   Title: Create interaction variables                             *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/interact.html           *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *
  * Created: 18 Aug 98  8:32                                          *
  * Revised: 10 Jan 2000 08:50:52                                     *
  * Version: 1.0                                                      *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/
 /* Description:
 
 The INTERACT macro creates interaction variables, formed as the 
product
 of each of the variables given in one set (V1=) with each of the
 variables given in a second set (V2=).

Usage:

 The INTERACT macro is called with keyword parameters.
 The arguments may be listed within parentheses in any order, separated
 by commas. For example: 
 
   %interact(v1=age sex, v2=I1 I2 I3);
 
Parameters:

* DATA=         The name of the input dataset.  If not specified, the 
most
            recently created dataset is used.

* V1=           Specifies the name(s) of the first set of 
variable(s).

* V2=           Specifies the name(s) of the second set of 
variable(s).

* OUT=          The name of the output dataset.  If not specified, 
the new
            variables are appended to the input dataset.

* PREFIX=   Prefix(s) used to create the names of interaction 
variables.
            The default is 'I_'. The names are of the form I_11 I_12 
...
                                I_1m I_21 I_22 ... I_nm, where there are n 
variables in V1
                                and m variables in V2.

* CENTER=   If non-blank, the V1 and V2 variables are mean-centered
            prior to forming their interaction products.
 */
 
%macro interact( 
        data=_last_ ,    /* name of input dataset */
        out=&data,       /* name of output dataset */
        v1= ,            /* first variable(s) */
        v2= ,            /* second variable(s) */
        prefix = I_,     /* prefix for interaction variable names */
        names=,          /* or, a list of n*m names */
        center=,
        );

%let abort = 0;
%if (%length(&v1) = 0 or %length(&v2) = 0) %then %do;
                %put ERROR: INTERACT: V1=  and V2= must be specified;
                %goto done;
                %end;

%if %bquote(&data) = _last_ %then %let data = &syslast;
%if %bquote(&data) = _NULL_ %then %do;
        %put ERROR: There is no default input data set (_LAST_ is 
_NULL_);
        %goto DONE;
        %end;
        
%if %length(&center) %then %do;
proc standard data=&data out=&data m=0;
        var &v1 &v2;
        %end;

data &out;
        set &data;

        %local i j k w1 w2;
        
        %let k=0;
        %let i=1;
        %let w1 = %scan(&v1, &i, %str( ));
        %do %while(&w1 ^= );
        
                %let j=1;
                %let w2 = %scan(&v2, &j, %str( ));
        
                %do %while(&w2 ^= );
                        %* put i=&i j=&j;
                        %let k=%eval(&k+1);
                        %let name = %scan(&names, &k, %str( ));
                        %if %length(&name) %then %do;
                                &name = &w1 * &w2;
                                %end;
                        %else %do;
                                &prefix.&i.&j = &w1 * &w2;
                                %end;
                        %let j=%eval(&j+1);
                        %let w2 = %scan(&v2, &j, %str( ));
                        %end;
        
                %let i=%eval(&i+1);
                %let w1 = %scan(&v1, &i, %str( ));
                %end;
run;

%done:
%if &abort %then %put ERROR: The INTERACT macro ended abnormally.;

%mend;

/*-------------------------------------------------------------------*
  *   Name: ordplot.sas                                               *
  *  Title: Diagnose form of discrete frequency distribution          *
  *         Poisson, Binomial, Neg. Binomial, Log series              *
  *    Doc: http://www.math.yorku.ca/SCS/vcd/ordplot.html             *
  *                                                                   *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *
  * Created:   9 May 1993 11:30:54                                    *
  * Revised:   9 Nov 2000 11:26:00                                    *
  * Version:  1.3                                                     *
  *  1.1  Plot y * &count so label will not be required               *
  *  1.2  Wtd LS line in red, default LEGCLR='RED'                    *
  *  1.3   Fixed validvarname for V7+                                 *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/

 /* Description:
 
 The ORDPLOT macro constructs a plot whose slope and intercept can
 diagnose the form of a discrete frequency distribution.  This is
 a plot of k n(k) / n(k-1) against k, where k is the basic count
 and n(k) is the frequency of occurrence of k. The macro displays
 both a weighted and unweighted least squares line and uses the
 slope and intercept of the weighted line to determine the form
 of the distribution. Rough estimates of the parameters of the
 distribution are also computed from the slope and intercept.

Usage:

 The ORDPLOT macro is called with keyword parameters. The COUNT=
 and FREQ= variables are required.
 The arguments may be listed within parentheses in any order, separated
 by commas. For example: 
 
        data horskick;
                input deaths corpsyrs;
                label deaths='Number of Deaths'
                        corpsyrs='Number of Corps-Years';
        cards;
                        0    109
                        1     65
                        2     22
                        3      3
                        4      1
        ;
        %ordplot(count=Deaths, freq=corpsyrs);
 
Parameters:

* DATA=       Name of the input data set. [Default: DATA=_LAST_]

* COUNT=      The name of the basic count variable.

* FREQ=       The name of the variable giving the number of occurrences
              of COUNT.

* LABEL=      Label for the horizontal (COUNT=) variable.  If not 
specified
              the variable label for the COUNT= variable in the input
                                  data set is used.

* LEGLOC=     X,Y location for interpretive legend [Default: LEGLOC=3 
88]

* LEGCLR=     legend color [Default: LEGCLR=RED]

* OUT=        The name of the output data set. [Default: OUT=ORDPLOT]

* NAME=       Name of the graphics catalog entry. [Default: 
NAME=ORDPLOT]

 */

%macro ordplot(
     data=_last_,       /* input data set                           */
     count=,            /* basic count variable                     */
     freq=,             /* number of occurrences of count           */
     label=,            /* Horizontal (count) label                 */
          legloc=3 88,       /* x,y location for interpretive legend     
*/
          legclr=red,        /* legend color                             
*/
          out=ordplot,       /* The name of the output data set          
*/
     name=ordplot
     );
 
        %*-- Reset required global options;
        %if &sysver >= 7 %then %do;
                %local o1 o2;
                %let o1 = %sysfunc(getoption(notes));
                %let o2 = %sysfunc(getoption(validvarname,keyword));
                options nonotes validvarname=V6;
                %end;
        %else %do;
           options nonotes;
                %end;

%let abort=0;
%if %length(&count)=0 | %length(&freq)=0
   %then %do;
      %put ERROR: The COUNT= and FREQ= variables must be specified;
      %let abort=1;
      %goto DONE;
   %end;

%*if &label=%str() %then %let label=&count;
proc means data=&data noprint;
   var &count;
   weight &freq;
   output out=sum sumwgt=N sum=sum mean=mean min=min max=max;
*proc print data=sum;

data &out;
   set &data;
   if _n_=1 then set sum(drop=_type_ _freq_);
   k = &count;
   nk= &freq;                  * n(k);
   nk1 = lag(&freq);           * n(k-1);
   y =  k * nk / nk1;
   if nk > 1
      then wk = sqrt(nk-1);            * weight for regression line;
      else wk = 0;

proc print data=ordplot;
   id &count;
   var nk nk1 wk y;
   sum nk;
 
proc reg data=&out outest=parms;
   weight wk;
   model y =  k;
%local lx ly;
%let lx=%scan(&legloc,1);
%let ly=%scan(&legloc,2);

data stats;
   set parms (keep=k intercep);
   set sum   (keep=mean min max);
   drop k intercep;
   length text type parm $30 function $8;
   xsys='1'; ysys='1';
   x=&lx;   y=&ly;
   function = 'LABEL';
*   size = 1.4;
   color = "&legclr";
   position='3'; text ='slope =   '||put(k,f6.3);      output;
   position='6'; text ='intercept='||put(intercep,f6.3); output;
 
   *-- Determine type of distribution;
   select;
      when (abs(k) < .1) do;
         type = 'Poisson';
         parm = 'lambda = '||put(intercep,6.3);
         end;
      when (k < -.1) do;
         type = 'Binomial';
         p = (k/(k-1));
         parm = 'p = '||put(p,6.3);
         end;
      otherwise do;  * positive slope;
         if intercep >-.05 then do;
            type = 'Negative binomial';
            parm = 'p ='||put(1-k,6.3);
            end;
         else do;
            type = 'Logarithmic series';
            parm = 'theta ='||put(k,6.3);
            end;
         end;
      end;
   y = &ly - 7;
   position='3'; text ='type: ' ||type;   output;
   position='6'; text ='parm: ' ||parm;   output;
 
   *-- Draw (weighted) regression line;
   xsys='2'; ysys='2';  size=3; color='red';
   x=min; y = intercep + k * x; function='MOVE'; output;
   x=max; y = intercep + k * x; function='DRAW'; output;

proc gplot data=&out;
   plot y * &count / anno=stats vaxis=axis1 haxis=axis2 vm=1
      name="&name"
      des="Ord plot of &count";
   symbol v=- h=2 i=rl l=34 c=black;
   axis1 label=(a=90 r=0
          'Frequency Ratio, (k n(k) / n(k-1))' )
         offset=(3);
   axis2 offset=(3) minor=none
        %if %length(&label) %then %do;
         label=("k  (&label)")
                        %end;
                        ;
   run;quit;
%done:
        %*-- Restore global options;
        %if &sysver >= 7 %then %do;
                options &o1 &o2;
                %end;
        %else %do;
           options notes;
                %end;
%mend;

/*-------------------------------------------------------------------*
  * Name:   robust.sas                                                *
  * Title:  M-estimation for robust models fitting via IRLS           *
  *   Doc:  http://www.math.yorku.ca/SCS/vcd/robust.html              *
  *                                                                   *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@YorkU.ca>         *
  * Created:   2 Dec 1996 11:34:22                                    *
  * Revised:  23 Jun 2000 10:33:51                                    *
  * Version:  1.2                                                     *
  *  1.2  Fixed some errors with LOGISTIC                             *
  *       Allow CLASS= with LOGISTIC for V8+                          *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/
 /* Description:
 
 The ROBUST macro uses iteratively reweighted least squares to  
 fit linear models by M-estimation.  The weights are determined  
 by the BISQUARE, HUBER, LAV or OLS function.  The fitting procedure 
 can be PROC REG, GLM or LOGISTIC               

Usage:

 The ROBUST macro is called with keyword parameters.
 The RESPONSE= and MODEL= parameters are required.
 The arguments may be listed within parentheses in any order, separated
 by commas. For example: 
 
        %include data(icu);
        %robust(data=icu, response=died, model=age cancer uncons admit,
                proc=logistic, id=id, iter=3);
 
Parameters:

* DATA=       The name of the input data set [Default: DATA=_LAST_]

* RESPONSE=   The name of the response variable in the model

* MODEL=      The right-hand-side of the MODEL statement

* PROC=       The name of the estimation procedure to be used,
              one of REG, GLM, or LOGISTIC.  
                                  [Default: PROC=LOGISTIC]

* CLASS=      The names of any CLASS variables in the MODEL (for GLM 
              or LOGISTIC in V8+)

* ID=         The names of any observation ID variables.  These are
              simply copied to the OUT= data set.

* OUT=        The name of the output data set of observation 
statistics.
              [Default: OUT=RESIDS]

* OUTPARM=    The name of the output data set of parameter estimates
              on the final iteration.

* FUNCTION=   Weight function, one of HUBER, LAV (least absolute 
value),
              BISQUARE, or OLS. [Default: FUNCTION=BISQUARE]

* TUNE=       Tuning constant for BISQUARE or HUBER.  The weighting
              function is applied to the value _RESID_ / (&TUNE * MAD)
                                  where MAD is the median absolute value of the 
residuals.
              The default is TUNE=6 for the BISQUARE function, and 
                                  TUNE=2 for the HUBER function.

* ITER=       The maximum number of iterations [Default: ITER=10]

* CONVERGE=   The maximum change in observation weights for 
convergence.
              The value must have a leading 0. [Default: CONVERGE=0.05]

* PRINT=      Controls printing of intermediate and final results
              [Default: PRINT=NOPRINT].

 */

%macro robust(
                data=_LAST_, 
                response=,        /* response variable                         
*/
                model=,           /* RHS of model statement                    
*/
                proc=REG,         /* estimation procedure: GLM, REG, 
LOGISTIC  */ 
                class=,           /* class variables (GLM only)                
*/
                id=,              /* ID variables                              
*/
                out=resids,       /* output observations data set              
*/
                outparm=,         /* output parameters data set                
*/
                function=bisquare, /* weight function: BISQUARE, HUBER or 
LAV  */
                tune=,            /* tuning constant for bisquare/huber        
*/
                iter=,            /* max number of iterations                  
*/ 
                converge=0.05,  /* max change in weight for convergence.     
*/
                        /* NB: must have leading 0                   */
                print=noprint
                );

%let abort=0;
%let proc = %upcase(&proc);
%let doparm = %index(REG LOGISTIC,&proc) ;      %* Getting parameter 
estimates?;

%if %index(REG LOGISTIC,&proc)
        %then %let outparm = outest;
        %else %let outparm = outstat;


%let r=r;
%if &proc = GLM %then %let r=rstudent;
%if &proc = LOGISTIC %then %let r=resdev;

%if %length(&iter)=0 %then %do;
        %let iter=10;
        %if &proc = LOGISTIC %then %let iter=4;
        %end;
                
%let function = %upcase(&function);
%if &tune = %str() %then %do;
        %if &function = BISQUARE %then %let tune = 6;
        %else %let tune = 2;
%end;

%let print = %upcase(&print);

data resids;
        set &data;
        _weight_ = 1;
        lastwt = .;
                
%do it = 1 %to &iter;

        %let pr=noprint;
        %if &print = PRINT %then %let pr=;
        %else %if %index(&print,NOPRINT) %then %let pr=NOPRINT;
        %else %if %index(&print,&it)  %then %let pr=;
        
        %*-- Remove parmest data set from a prior run;
        %if &it=1 %then %do;
        proc datasets nolist nowarn;
                delete parmest;
        %end;
        
        %*-- Fit the model, using current weights;
        proc &proc data=resids %if &it > 1 %then (drop=_resid_ _fit_ 
_hat_);
                 &outparm=parms
                 &pr;
                weight _weight_;                        %*-- observation weights;
                %if %length(&class)>0 & (&proc=GLM or (&proc=LOGISTIC and 
&sysver>=8))
                  %then %do;
                        class &class;
                  %end;
                model &response = &model;
                output out=newres &r=_resid_ p=_fit_ h=_hat_;
                title3 "Iteration &it";
        run;
        %if &syserr > 4 %then %let abort=1; %if &abort %then %goto DONE;

        options nonotes;
        %*-- Find the median absolute residual;
        data resids;
                set newres;
                absres = abs(_resid_);
        
        %*-- Find median absolute deviation (MAD);
        proc univariate data=resids noprint;
                var absres;
                output out=sumry median=mad;
        
        %*-- Calculate new weights;
        data &out;
                set resids end=eof;
                drop w mad _maxdif_ absres lastwt;
                retain _maxdif_ 0;
                lastwt = _weight_;
                if _n_=1 then set sumry(keep=mad);

                if _resid_ ^= . then do;
                        %*-- scaled residual;
                        w = _resid_ / (&tune * mad);
                        %if &function = BISQUARE    %then %bisquare(w);
                        %else %if &function = HUBER %then %huber(w);
                        %else %if &function = LAV   %then %lav(w);
                        %else _weight_=1;        /* OLS */
                        
                        _maxdif_ = max(_maxdif_, abs(_weight_-lastwt));
                end;
                
                if eof then do;
                *       file print;
                        put "NOTE: iteration &it  " _maxdif_=;
                        call symput('maxdif',left(put(_maxdif_,6.4)));
                        end;    
        run;
        %*if &doparm %then %do;
        data parms;
                iter = &it;
                set parms;
                _maxdif_ = input("&maxdif", best.);
        proc append base=parmest new=parms;
        run;
        %*end;
                        
        %if &maxdif < &converge %then %goto fini;

%end;
%fini:;
        data parmest;
                set parmest;
        %if &doparm %then %do;
                drop _type_ 
                %if &proc=REG %then _model_ _depvar_  &response;
                ;
                title3 'Iteration history and parameter estimates';
        %end;
        %else %do;
                drop _name_ prob;
                if _type_='SS1' then delete;
                title3 'Iteration history and test statistics';
        %end;           
        proc print data=parmest;
                id iter;
                run;
        
        %if %length(&outparm)>0 %then %do;
        data &outparm;
                set parmest end=eof;
                drop iter _maxdif_;
                if eof then output;
        %end;

%if %index(&print,NONE)=0 %then %do;
proc print data=&out;
        %if &id ^= %str() | &class ^= %str() %then %do;
                id &class &id;
                var &response _fit_ _weight_ _resid_ _hat_ flag;
                title3 'Residuals, fitted values and weights';
                run;
        %end;
title3;
%end;
%done:
options notes;
%mend;

%macro bisquare(w);
        if abs(&w) < 1 
                then do; _weight_ = (1 - &w**2) **2;  flag=' '; end;
                else do; _weight_ = 0;                flag='*'; end;
%mend;

%macro huber(w);
        if abs(&w) < 1 
                then do; _weight_ = 1;               flag=' '; end;
                else do; _weight_ = 1/abs(&w);       flag='*'; end;
%mend;

%macro lav(w);
        _weight_ = 1/(absres +(absres=0));
%mend;

/*-------------------------------------------------------------------*
 *    Name: catplot.sas                                              *
 *   Title: Plot observed and predicted logits for logit models      *
 *          fit by PROC CATMOD.                                      *
 *     Doc: http://www.math.yorku.ca/SCS/vcd/catplot.html            *
 *                                                                   *
 *-------------------------------------------------------------------*
 *  Author:  Michael Friendly            <friendly@YorkU.CA>         *
 * Created:  9 May 1991 12:20:09         Copyright (c) 1992          *
 * Revised:  9 Nov 2000 11:37:13                                     *
 * Version:  1.4                                                     *
 *  1.4   Fixed validvarname for V7+                                 *
 * Requires: %gensym                                                 *
 *                                                                   *
 * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
 *-------------------------------------------------------------------*/
 /* Description:
 
 The CATPLOT macro is designed to plot observed and/or predicted
 values for logit models fit by the CATMOD procedure.  The macro uses
 the output data set produced with the OUT= option on the RESPONSE
 statement.  This data set normally contains both logit values
 (_TYPE_='FUNCTION') and probability values (_TYPE_='PROB').  Either
 set may be plotted, as specified by the TYPE= parameter.

 The horizontal variable may be character (XC=) or numeric (X=).
 A separate curve is drawn for each value of the CLASS= variable,
 connecting predicted values, with optional standard error bars,
 and separate plots are drawn for each value of the BYVAR= variable.
 
Usage:

 The catplot macro is called with keyword parameters. Either the
 X= or the XC= parameters are required. Use the CLASS= parameter
 to give multiple curves in each plot for the levels of the CLASS
 variable. Use the BYVAR= parameter to give multiple plots for the
 levels of the BYVAR variable. The arguments may be listed within
 parentheses in any order, separated by commas.  For example:

        proc catmod;
                direct husinc;
                response / out=logits;
                model labour = husinc children; 
        %catplot(data=logits, x=husinc, y=_pred_, class=labor, 
byvar=children);
 
Parameters:

* DATA=  The name of the SAS dataset to be plotted, which must be
                         an output data set from PROC CATMOD.  If DATA= is 
not
                         specified, the most recently created data set is 
used.

* X=             Name of a numeric factor variable to be used as the 
horizontal
                         variable in plots.  Use the XC= parameter to specify 
a
                         character variable.  You must specify either the X= 
or XC=
                         variable.

* XC=            Name of a character factor variable used as the horizontal
                         variable in plots.

* Y=             Name of the ordinate variable.  Y=_PRED_ plots the 
predicted
                         value; Y=_OBS_ plots the observed value.  The 
default is
                         Y=_OBS_, but the predicted values are also drawn, 
connected
                         by lines. [Default: Y=_OBS_]

* CLASS=  The name of a factor variable, used to define separate curves
                         which are plotted for each level of this variable.

* BYVAR=         Name of one or more factor variables to be used to define 
                         multiple panels in plots.  

* BYFMT=  Name of a SAS format used to format the value of BYVARs
                         for display in one panel of the plot(s). [Default: 
BYFMT=$16.]

* TYPE=   The type of observations to be plotted.  TYPE=FUNCTION (the
                         default) gives plots of the logit value; TYPE=PROB 
gives
                         plots of the probability value. [Default: 
TYPE=FUNCTION]

* Z=      Standard error multiple for confidence intervals around
                         predicted values, e.g., Z=1.96 gives 95% CI. To 
suppress error
                         bars, use Z=0.  The default is Z=1, giving 67% CI.

* CLFMT=         Name of a SAS format used to format the value the CLASS=
                         variable for display in each panel of the plot(s).

* CLSIDE=       Specifies whether the values of the CLASS= variable should
                         be labelled by annotation in the plot or by a 
legend.  If
                         CLSIDE=LEFT or CLSIDE=FIRST, CLASS= values are 
written at the
                         left side of each curve.  If CLSIDE=RIGHT or 
CLSIDE=LAST,
                         CLASS= values are written at the right side of each 
curve.
                         If CLSIDE=NONE, or if a LEGEND= legend is specified, 
the 
                         CLASS= values appear in the legend.  You should
                         then define a LEGEND statment and use the LEGEND= 
parameter.
                         [Default: CLSIDE=LAST]

* XFMT=  Name of a SAS format used to format the values of the 
horizontal
                         variable.
                        
* POSFMT=   Format to translate the value of the CLASS variable to a 
          SAS/GRAPH annotate position.  This will almost always be a
                         user-specified format created with PROC FORMAT.

* ANNO=  Name of an additional input annotate data set

* SYMBOLS=      List of SAS/GRAPH symbols for the levels of the CLASS= 
variable.  
                         The specified symbols are reused cyclically if the 
number of 
                         distinct values of the \texttt{CLASS=} variable 
exceeds the 
                         number of symbols. [Default: SYMBOLS=CIRCLE SQUARE 
TRIANGLE]

* COLORS=       List of SAS/GRAPH colors for the levels of the CLASS= 
variable.
          The specified colors are reused cyclically if the number of 
                         distinct values of the \texttt{CLASS=} variable 
exceeds the 
                         number of colors. [Default: COLORS=BLACK RED BLUE 
GREEN]

* LINES=         List of SAS/GRAPH line styles for the levels of the CLASS= 
          variable.  The specified line styles are reused cyclically if 
the 
                         number of distinct values of the \texttt{CLASS=} 
variable
                         exceeds the number of line styles. [Default: LINES=1 
20 41 21 7 14 33 12]

* VAXIS=         Axis statement for custom response axis, e.g., 
VAXIS=AXIS1.
          [Default: VAXIS=AXIS1]

* HAXIS=         Axis statement for custom horizontal axis, e.g., 
HAXIS=AXIS2
          [Default: HAXIS=AXIS2]

* LEGEND=       Legend statement for custom CLASS legend, e.g., 
LEGEND=LEGEND1

* PLOC=   For multiple plots (with a BYVAR), PLOC defines the X,Y 
position
          of the panel label, in graph percentage units. [Default: 
PLOC=5 95]

* PRINT=  Print summarized input data set? [Default: PRINT=NO]

* NAME=   Name of graphic catalog entry. [Default: NANME=CATPLOT]

 */
 
%macro catplot(
    data=_last_,  /* OUT= data set from PROC CATMOD                 */
    x=,           /* horizontal value for plot (NUMERIC)            */
    xc=,          /* horizontal value for plot (CHAR)               */
    y=_obs_,      /* ordinate for plotted points (_PRED_ or _OBS_)  */
         ylab=,        /* ordinate label                                 
*/
    class=,       /* variable for curves within each plot           */
    byvar=,       /* one plot for each level of by variable(s)      */
    byfmt=$16.,   /* format for by variable                         */
         type=FUNCTION,/* type of obs. plotted: FUNCTION or PROB         
*/
    z=1,          /* std. error multiple for confidence intervals   */
                  /* e.g., z=1.96 gives 95% CI. No error bars: z=0  */
    anno=,        /* additional input annotate data set             */
    clfmt=,       /* how to format values of class variable         */
    clside=last,  /* side for labels of class var (FIRST|LAST|NONE) */
    xfmt=,        /* format for X variable                          */
    posfmt=,      /* format to translate class var to position      */
    vaxis=axis1,  /* axis statement for logit axis                  */
    haxis=axis2,  /* axis statement for horizontal axis             */
    legend=,      /* legend statement for custom CLASS legend       */
    colors=BLACK RED BLUE GREEN,   /* colors for class levels       */
         symbols=circle square triangle,  /* symbols for class levels    
*/
    lines=1 20 41 21 7 14 33 12,     /* line styles for class levels */
         ploc=5 95,  /* location of panel variable label               */
         print=NO,     /* print summarized input data set?               
*/
         name=catplot
    );
 
        %*-- Reset required global options;
        %if &sysver >= 7 %then %do;
                %local o1 o2;
                %let o1 = %sysfunc(getoption(notes));
                %let o2 = %sysfunc(getoption(validvarname,keyword));
                options nonotes validvarname=V6;
                %end;
        %else %do;
           options nonotes;
                %end;

%let type=%upcase(&type);
%let print=%upcase(&print);
%let legend=%upcase(&legend);
%let clside=%upcase(&clside);
%if &clside=LEFT %then %let clside=FIRST;
%if &clside=RIGHT %then %let clside=LAST;

%let abort=0;

%if &x ^= %str() %then %do;
   %let px = &x;
        %let ax = x;
   %end;
%else %do;
   %if &xc = %str() %then %do;
       %put CATPLOT: Either X= or XC= variable must be specified;
                 %let abort=1;
       %goto DONE;
       %end;
   %let px = &xc;
        %let ax = xc;
   %end;
 
%*-- Find the last by-variable;
%if %length(&byvar) > 0 %then %do;
   %let _byvars=;
   %let _bylast=;
   %let n=1;
   %let token=%qupcase(%qscan(&byvar,&n,%str( )));

   %do %while(&token^=);
      %if %index(&token,-) %then
         %put WARNING: Abbreviated BY list &token.  Specify by= 
individually.;
      %else %do;
         %let token=%unquote(&token);
         %let _byvars=&_byvars &token;
         %let _bylast=&token;
      %end;
      %let n=%eval(&n+1);
      %let token=%qupcase(%scan(&byvar,&n,%str( )));
   %end;
%let nby = %eval(&n-1);
%if %index(&byfmt,%str(.))=0 %then %let byfmt = &byfmt..;
%end;  /* %if &byvar */

 %*-- Select logit (_type_='FUNCTION'), or probability (_type_='PROB') 
obs. ;
/*
data _pred_;
   set &data;
   drop  _type_ ;
   if _type_="&type";
        %if &type=PROB %then %do;
        label _obs_ = 'Observed probability'
                _pred_ = "Predicted probability';
                %end;
        %else %do;
        label _obs_ = 'Observed logit'
                _pred_ = "Predicted logit';
                %end;
*/
 %*-- Average over any other factors not given in &byvar or &class;
proc summary data=&data nway;
   class &byvar &class &px;
   var _pred_ _obs_ _seobs_ _sepred_ _resid_;
        where (_type_="&type");
   output out=_pred_(drop=_type_) mean=;

proc sort;
   by &byvar &class &px;

%if %substr(&print,1,1)=Y %then %do;
proc print data=_pred_;
   id &byvar &class &px;
   var _obs_ _seobs_ _pred_ _sepred_ _resid_;
   format _obs_ _pred_ 8.3 _seobs_ _sepred_ _resid_ 8.4;
%end;

proc contents data=&data out=_work_ noprint;
%if &syserr > 4 %then %let abort=1; %if &abort %then %goto DONE;

data _null_;
   set _work_(keep=name type format);
        %if %length(&clfmt)=0 %then %do;
        if upcase(name) = upcase("&class") then do;
                if format=' ' then do;
                        if type = 2
                                then format='$16.';
                                else format='best.';
                        end;
                if index(format,'.')=0 then format=trim(format)||'.';
                call symput('clfmt', format);
                put name= format=;
                end;
        %end;
 
%let plx = %scan(&ploc,1);
%let ply = %scan(&ploc,2);
%if %length(&posfmt) 
        %then %if %index(&posfmt,%str(.))=0 %then %let posfmt = 
&posfmt..;
data _anno_;
   set _pred_;
   by &byvar &class;
   length function color $8 text $100;
   retain cl 0;
   drop _seobs_ _sepred_ _resid_ cl;
   %if &byvar ^= %str() %then %do;
                %*-- Label for byvar(s) in this plot;
      goptions hby=0;
      if first.&_bylast then do;
         xsys='1'; ysys='1';
                        x = &plx; y=&ply; 
                        position='6';
                        %if &nby=1 %then %do;
                                text = put(&byvar,&byfmt);
                                %end;
                        %else %do;
                                text=' ';
                                %do i=1 %to &nby;
                                        text = trim(text) || %scan(&byvar, &i) || 
' ';
                                        %end;
                                %end;
         function = 'LABEL'; output;
         end;
      if first.&_bylast then cl=0;
      %end;
 
   xsys = '2'; ysys='2';
   %*-- Set X or XC variable ;
        &ax = &px;
 
        *-- Index for line/color;
        %if &class = %str()
                %then %do; cl=1; %end;
        %else %do; if first.&class then cl+1; %end;
   line=input(scan("&lines", cl),5.);
   color = scan("&colors",cl);

        %if (&clside=FIRST or &clside=LAST) & %length(&legend)=0 %then 
%do;
                if &clside..&class then do;
                        y=_pred_;
                        %if %length(&clfmt)
                                %then %str(text = put(&class,&clfmt););
                                %else %str(text = trim(left(&class)););
                        *-- Use a null char to move label a bit;
                        %if %upcase(&clside) = LAST %then %do;
                                position = '6';  text = '00'x || ' ' || text;
                                %end;
                        %else %do;
                                position='4';  text = trim(text) || '00'x;
                                %end;
                        %if &posfmt ^= %str() %then %do;
                        position = put(&class,&posfmt);
                        %end;
                        function = 'LABEL'; output;
                        end;
                %end;

        %if &class = %str()
                %then %do; if _n_=1 then do; %end;
        %else %do; if first.&class then do; %end;
      y = _pred_; function='MOVE'; output;
      end;
   else do;
      y = _pred_; function='DRAW'; output;
      end;
 
    %if &z > 0 %then %do;
    %*-- plot value +- &z * std error;
    line = 33;
    y = _pred_ + &z * _sepred_ ; function='MOVE'; output;
    y = _pred_ ;                 function='DRAW'; output;
    y = _pred_ - &z * _sepred_ ; function='DRAW'; output;
    y = _pred_ ;                 function='MOVE'; output;
    %end;
 
%if &anno ^= %str() %then %do;
   data _anno_;
      set _anno_ &anno;
   %end;
*proc print data=_anno_;
 
%if &class = %str()
        %then %do;
                %let sym = 1;
                symbol1 i=none v=%scan(&symbols,1) h=1.8 
c=%scan(&colors,1);
        %end;
        %else %do;
                %let sym = &class;
                %if %length(&symbols) %then %do;
                *-- How many levels of class variable? --;
                proc freq data = _pred_;
                        tables &class / noprint out=_levels_;
                data _null_;
                        set _levels_(obs=1) nobs=ngroups;
                        call symput( 'NGROUPS', put(ngroups,3.) );
                        run;
                %gensym(n=&ngroups, interp=none, symbols=&symbols, 
colors=&colors);
                %end;
        %end;

%if %length(&legend) %then %let legend=legend=&legend;
%else %if &legend=NONE | &clside ^= NONE %then %let legend=nolegend;


proc gplot data=_pred_;
   plot &y * &px = &sym
        / anno=_anno_ frame
                         &legend
          haxis=&haxis hminor=0
          vaxis=&vaxis vminor=1 name="&name"
                         des="catplot of &data";
   %if &byvar ^= %str() %then %do;
      by &byvar;
      %end;
   %if &xfmt ^= %str() %then %do;
      format &px &xfmt;
      %end;
   %if &ylab ^= %str() %then %do;
      label &y="&ylab";
      %end;
run; quit;

%done:
%if &abort %then %put ERROR: The CATPLOT macro ended abnormally.;

   goptions hby=;
        %*-- Restore global options;
        %if &sysver >= 7 %then %do;
                options &o1 &o2;
                %end;
        %else %do;
           options notes;
                %end;
%mend catplot;

/*-------------------------------------------------------------------*
  *    Name: gensym.sas                                               *
  *   Title: Macro to generate SYMBOL statement for each GROUP        *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/gensym.html             *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *
  * Created: 05 Jan 1999 12:55                                        *
  * Revised:  8 Jun 2000 15:43:36                                     *
  * Version: 1.1                                                      *
  * 1.1 - Added FONT= for those special symbol fonts (only one)       *
  *       Added START= for first SYMBOL stmt.                         *
  *       Fixed bug with large N=                                     *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/
 /* Description:
 
 The GENSYM macro generates a series of SYMBOL statements for multiple
 group plots of the form
 
        proc gplot;
                plot y * x = group;

 Separate plot symbols, colors, line styles and interpolation options
 may be generated for each group.

Usage:

 The GENSYM macro is called with keyword parameters.  All parameters
 have default values, but the N= parameter must usually be specified.
 The arguments may be listed within parentheses in any order, separated
 by commas. For example: 
 
        %gensym(n=4);
 
 The INTERP=, LINE=, SYMBOLS=, and COLORS= parameters are each lists
 of one or more values. If fewer than N (blank delimited) values are
 given,  the available values are reused cyclically as needed.

Parameters:

* N=           The number of symbol statements constructed,
               named SYMBOL&start, ..., SYMBOL&N+&start.

* START=       Number of the first symbol statement. [Default: START=1]

* H=           The height of the plotting symbol. The same H= value is
               used for all SYMBOL statements. [Default: H=1.5]

* INTERP=      List of one or more interpolation options. 
               [Default: INTERP=NONE]

* LINE=        List of one or more numbers in the range 1..46 giving
               SAS/GRAPH line styles [Default: LINE=1]

* SYMBOLS=     A list of one or more names of SAS/GRAPH plotting 
symbols.
               [Default: SYMBOLS=%STR(SQUARE TRIANGLE : $ = X _ Y)]

* COLORS=      A list of one or more names of SAS/GRAPH colors.
               [Default: COLORS=BLACK RED GREEN BLUE BROWN YELLOW 
ORANGE PURPLE]

* FONT=        Font used for the symbols (same for all SYMBOL 
statements)
                
Example:

 To plot the four combinations of age group (old, young) and sex, with
 separate plotting symbols (circle, dot) for old vs. young, and
 separate colors (red, blue) for females vs. males, use the macro as
 follows:
 
        proc gplot;
                plot y * x = agesex;
                %gensym(n=4, symbols=circle circle dot dot, colors=red 
blue,
                        interp=rl);

 This generates the following symbol statements:
 
        symbol1 v=circle h=1.5 i=rl c=red;
        symbol2 v=circle h=1.5 i=rl c=blue;
        symbol3 v=dot    h=1.5 i=rl c=red;
        symbol4 v=dot    h=1.5 i=rl c=blue;
 */

%macro gensym(
      n=1,
                start=1, 
                h=1.5,
                interp=none,
                line=1,
                symbols=%str(square triangle : $ = X _ Y),
                colors=BLACK RED GREEN BLUE BROWN YELLOW ORANGE PURPLE,
                font=,
                );

    %*--  if more than 8 groups symbols and colors are recycled;
  %local chr col int lin k;
  %do k=&start %to &n ;
     %if %length(%scan(&symbols, &k, %str( ))) = 0 
              %then %let symbols = &symbols &symbols;
     %if %length(%scan(&colors, &k, %str( ))) = 0 
              %then %let colors = &colors &colors;
     %if %length(%scan(&interp, &k, %str( ))) = 0 
              %then %let interp = &interp &interp;
     %if %length(%scan(&line,   &k, %str( ))) = 0 
              %then %let line = &line &line;
     %let chr =%scan(&symbols, &k,%str( ));
     %let col =%scan(&colors, &k, %str( ));
     %let int =%scan(&interp, &k, %str( ));
     %let lin =%scan(&line,   &k, %str( ));
     symbol&k
          %if %length(&font) %then font=&font;
          height=&h value=&chr color=&col i=&int l=&lin;
%*put symbol&k h=&h v=&chr c=&col i=&int l=&lin;

  %end;
%mend gensym;


/*------------------------------------------------------------------*
  *    Name: label.sas                                               *
  *   Title: Create an Annotate dataset to label observations        *
  *      in a scatterplot                                            *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/label.html             *
  *------------------------------------------------------------------*
  *  Author:  Michael Friendly         <friendly@yorku.ca>           *
  * Created:  15 May 1991 12:27:15                                   *
  * Revised:  28 Aug 2000 12:56:56                                   *
  * Version:  1.6                                                    *
  *  - Added BY= parameter                                           *
  *  - Added POS=- to position up/down wrt mean y                    *
  *  - Added copy= parameter; fixed bug with subset & pos            *
  *  - Added angle= and rotate=, IN= (then fixed keep= bug)          *
  *                                                                  *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)   *         
  *------------------------------------------------------------------*/
 /* Description:
 
 The LABEL macro creates an Annotate data set used to label
 observations in a 2D (PROC GPLOT) or 3D (PROC G3D) scatterplot.
 The points which are labeled may be selected by an arbitrary
 logical expression from those in the input dataset. The macro
 offers flexible ways to position the text label relative to either
 the data point or the center of the plot. The resulting Annotate
 data set would then be used with the ANNO= option of PROC GPLOT
 or PROC G3D.


Usage:

 Values must be supplied for the X=, Y= and TEXT= parameters.  For a 
PROC
 G3D plot, supply a value for the Z= parameter as well.
 The label macro is called with keyword parameters.
 The arguments may be listed within parentheses in any order, separated
 by commas. For example: 
 
        %label(x=age, y=response, text=name);
 
Parameters:

* DATA=       The name of the input data set [Default: DATA=_LAST_]

* X=          The name of the X variable for the scatterplot

* Y=          The name of the Y variable for the scatterplot

* Z=          The name of the Z variable for a 3D scatterplot

* BY=         The name(s) of any BY variable(s) to be used for multiple
              plots.

* XOFF=       An X-offset for the text label. You may specify a 
              numeric constant
              (XOFF=-1) in data units, or the name of a variable in the
                                  input data set. Positive values move the 
label
              to the right relative to the point; negative values move 
it
                                  to the left.


* YOFF=       A Y-offset for the text label. Positive values move the 
label
              towards larger Y values.


* ZOFF=       A Z-offset for the text label, for a 3D plot.

* TEXT=       The text used to label each point. TEXT= may be
                   specified as a variable in the data set or a SAS
                                  expression involving dataset variables (e.g.,
                                  TEXT=SCAN(MODEL,1)) and/or string 
                                  constants.  If you supply an expression, use 
the 
                                  C<%str()> macro function,  e.g.,
                                  C<TEXT=%str(trim(name || '-' || place))> to 
protect special
                                  characters.

* LEN=        Length of the TEXT variable [Default: LEN=16]

* POS=        Specifies the position of the label relative to the
              data point.       The POS= value can be a character 
constant 
                                  (one of the characters in 
"123456789ABCDEF<+>", as used 
                                  by the Annotate POSITION variable), an 
expression involving 
                                  dataset variables which evaluates to one of 
these characters
                                  (e.g., POS=SCAN('9 1 3', _NUMBER_)) or one of 
the special
                                  characters, "/", "|", or "-".  The special 
position values 
                                  cause the point label to be out-justified 
(moved outward 
                                  toward the edges of the plot relative to the 
data point.)
                                  by comparing the coordinates of the pointto 
the mean of 
                                  X and Y (/), or to the mean of X only (|), or 
to the
                                  mean of Y only (-).
        
* SYS=        Specifies the Annotate XSYS & YSYS value [Default: SYS=2]

* COLOR=      Label color (the name of a dataset character variable or 
a
              string constant enclosed in quotes. [Default: 
COLOR='BLACK']

* SIZE=       The size of label (in whatever units are given by the
              GUNIT goption). There is no 
              default, which means that the labels inherit the 
              global HTEXT setting.

* FONT=       The name of the font used for the label.  There is no 
              default, which means that the labels inherit the 
              global FTEXT setting.

* ANGLE=      Baseline angle for label.

* ROTATE=     Character rotate for label

* SUBSET=     An expression (which may involve any dataset variables) 
to
              select points.  A point will be labeled if the expression 
                                  evaluates to non-zero for the current 
observation.
              [Default: SUBSET=1]

* COPY=       The names of any variables to be copied to output dataset

* IN=         The name of an optional input annotate data set.  If
              specified, the IN= data set is concatenated with the
                                  OUT= data set.

* OUT=        The name of the annotate data set produced.  [Default: 
OUT=_LABEL_]
                
Example:

This example plots Weight against Price for American cars in the Auto 
data,
labeling the most expensive cars.

        %label(data=auto, x=price, y=weight,
                                color='red', size=1.2,
                                subset=origin='A' and price>10000,
                                pos=1, text=scan(model,1));
        
        proc gplot data=auto(where=(origin='A'));
                plot weight * price / frame anno=_label_;
                symbol1 v='+'  i=none color=black h=1.5;

 */

%macro label(
   data=_LAST_,
   x=,             /* X variable for scatterplot       */
   y=,             /* Y variable for scatterplot       */
   z=,             /* Z variable for G3D (optional)    */
   by=,            /* BY variable(s) (mult plots)      */
   xoff=0,         /* X-offset for label (constant     */
   yoff=0,         /* Y-offset for label    or         */
   zoff=0,         /* Z-offset for label  variable)    */
   text=,          /* text variable or expression      */
   len=16,         /* length of text variable          */
   pos=,           /* position for label (/=out-just)  */
   sys=2,          /* XSYS & YSYS value                */
   color='BLACK',  /* label color (quote if const)     */
   size=,          /* size of label                    */
   font=,          /* font for label                   */
   angle=,         /* baseline angle for label         */
   rotate=,        /* character rotate for label       */
   subset=1,       /* expression to select points      */
   copy=,          /* vars copied to output dataset    */
   in=,            /* input annotate data set          */
   out=_label_     /* annotate data set produced       */
        );

options nonotes; 
%* -- pos can be a constant, an expression, or / or -;
%*    if a character constant, put "" around it;
%if %index(|/-,&pos) %then
   %do;  %*-- Out-justify wrt means of x,y;
      proc summary data=&data;
         var &x &y;
         output out=_means_ mean=mx my;
   %end;
%else %if "&pos" ^= "" %then %do;
   %if %verify(&pos,%str(123456789ABCDEF<+>)) = 0
       %then %let pos="&pos" ;
   %end;
%else %let pos = "5";

%if %length(&by) %then %do;
   proc sort data=&data;
   by &by;
   %end;
run;

options notes;
data &out;
   set &data;
   %if %length(&by) %then %do;
      by &by;
      %end;
   keep x y xsys ysys position function
      %if %length(&size) %then  size ;
      %if %length(&angle) %then angle ;
      %if %length(&rotate) %then rotate ;
        color text &by &copy;
   length function color $8 text $ &len position $1;
   xsys = "&sys"; ysys = "&sys"; function='LABEL';
   x = &x + &xoff ;
   y = &y + &yoff ;
   %if &z ^= %str() %then %do;
          retain zsys "&sys"; keep z zsys;
          z = &z + &zoff;
       %end;
   %if "&text" ^= ""
      %then %do; text=&text;  %end;
      %else %do; text=left(put(_n_,5.)); %end;
   %if %length(&size)   %then %str(size=&size;);
   %if %length(&angle)  %then %str(angle=&angle;);
   %if %length(&rotate) %then %str(rotatee=&rotate;);
   color=&color;
   %if &font ^= %str() %then %do;
      keep style;
      style = "&font";
      %end;
   %if "&pos" = "/" %then
      %do;
         retain mx my;
         if _n_=1 then set _means_(keep=mx my);
         if x > mx then
            if y > my then position = '3';
                      else position = '9';
            else
            if y > my then position = '1';
                      else position = '7';
      %end;
   %else %if "&pos" = "-" %then
      %do;
         retain mx my;
         if _n_=1 then set _means_(keep=mx my);
         if y > my then position = '2';
                   else position = '8';
      %end;
   %else %if "&pos" = "|" %then
      %do;
         retain mx my;
         if _n_=1 then set _means_(keep=mx my);
         if x > mx then position = '6';
                   else position = '4';
      %end;
      /* if pos has more than one character, use them cyclically */
   %else %if %qsubstr(&pos,1,1) eq %str(%") %then 
      %str(position=substr(&pos,1+mod(_n_,length(&pos)),1););
   %else %str(position = &pos;);
   if (&subset);
run;

%if %length(&in) %then %do;
   data &out;
      set &in &out;
      %if %length(&by) %then %do;
         by &by;
         %end;
   %end;

%mend label;

/*-------------------------------------------------------------------*
  *    Name: panels.sas                                               *
  *   Title: Macro to display a set of plots in rectangular panels    *
  *           using PROC GREPLAY.                                     *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/panels.html             *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *         
  * Created:  1 Mar 1994 13:16:36                                     *         
  * Revised:  28 May 2000 10:36:45                                    *         
  * Version:  1.6                                                     *
  *  - EQUATE default changed to Y                                    *
  *  - Added ORDER=BYROWS support                                     *         
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/

/* Description:

 The PANELS macro constructs a template in which to replay a series of
 graphs, assumed all the same size, in a rectangular array of R
 rows and C columns. By default, the panels are displayed
 left-to-right across rows,  starting either from the top
 (ORDER=DOWN) or bottom (ORDER=UP).  If the number of rows and
 columns are unequal, the aspect ratio of individual panels can
 be maintained by setting equate=Y.  It is assumed that all the
 plots have already been created, and stored in a graphics catalog
 (the default, WORK.GSEG is used automatically by SAS/GRAPH
 procedures).

 For interactive use within the SAS Session Manager you should be
 aware that all plots are stored cumulatively in the graphics
 catalog throughout your session, unless explicitly changed with
 the GOUT= option in graphics procedures or macros  To create multiple
 panelled plots you can use the FIRST= and LAST= parameters or a 
REPLAY=
 list to specify which plots are used in a given call.
   
Usage:

 Call the PANELS macro after the steps which create the graphs in the
 graphics catalog.  The GDISPLA macro may be used to suppress the
 display of the original full-sized graphs.
 The ROWS= and COLS= parameters must be specified.
 
   goptions hsize=7in vsize=5in;
        %gdispla(OFF);
        proc gplot data=mydata;
                plot y * x = group;
                by sex;
        
        %gdispla(ON);
        %panels(rows=1, cols=2);
        
Parameters:
   
* ROWS=
* COLS=
   The ROWS= and COLS= arguments are required, and specify the
   size of the array of plots to be displayed. These are the only
   required arguments.
   
* PLOTS=
   If there are fewer than &ROWS*&COLS plots, specify the number
   as the PLOTS= argument. Optionally, there can be an additional
   plot, which is displayed (as a GSLIDE title, for example) in
   the top nn% of the display, as specified by the TOP= argument.
   
* TOP=
   If TOP=nn is specified, the top nn% of the display is reserved
        for one additional panel (of width 100%), to serve as the plot
        title or annotation.

* ORDER=
   The ORDER= argument specifies the order of the panels in the
   REPLAY= list, when REPLAY= is not specified. 
        Typically, the panels are displayed across the columns.
        ORDER=UP means that the panels in the bottom row are
        are drawn first, and numbered 1, 2, ..., &COLs. ORDER=DOWN means
        that the panels in the top row are drawn first, numbered 1, 2, 
..., 
        &COLs.  If you add the keyword BYROWS to ORDER=, the panels are
        displayed up or down the rows.  For example, when ROWS=3, COLS=5,
        ORDER=DOWN BYROWS generates the REPLAY= list as,

       replay=1:1  2:4  3:7  4:10  5:13
              6:2  7:5  8:8  9:11 10:14
             11:3 12:6 13:9 14:12 15:15
   
* EQUATE=
        The EQUATE= argument determines if the size of the panels is 
adjusted
        so that the aspect ratio of the plots is preserved.  If EQUATE=Y,
        the size of each plot is adjusted to the maximum of &ROWS and 
&COLS.
        This is usually desired, as long as the graphic options HSIZE and
        VSIZE are the same when the plots are replayed in the panels
        template as when they were originally generated.  The default is
        EQUATE=Y.
        
* REPLAY=
   The REPLAY= argument specifies the list of plots to be replayed
   in the constructed template, in one of the forms used with the
   PROC GREPLAY REPLAY statement, for example, REPLAY=1:1 2:3 3:2
   4:4 or REPLAY=1:plot1 2:plot3 3:plot2 4:plot4
   
* TEMPLATE=
   The name of the template constructed to display the plots. The
        default is TEMPLATE=PANEL&ROWS.&COLS.

* TC=
   The name of the template catalog used to store the template.
        You may use a two-part SAS data set name to save the template
        permanently.

* FIRST=
* LAST=
   By default, the REPLAY= argument is constructed to replay plot
   i in panel i.  If the REPLAY= argument is not specified, you can
   override this default assignment by specifying FIRST= the sequential
   number of the first graph in the graphics catalog to plot (default:
   first=1), where:                       
                >0 means absolute number of first graph,          
                <1 means number of first graph relative to last (i.e. 0 
means 
                 last graph only, -1 means first is one before last, etc.) 
                                            
   last=0          Number of last graph to plot                        
                >0 means absolute number of last graph,           
                <1 means number of last graph relative to number  
                of graphs in the catalog (i.e. 0 means last graph 
                in the catalog, -1 means one before last, etc.)

* GIN=
        GIN specifies the name of the input graphics catalog, from which 
the
        plots to be replayed are taken. The default is GIN=WORK.GSEG.

* GOUT=
        GOUT= specifies the name of the graphics catalog in which the 
panelled
        plot is stored. The default is GOUT=WORK.GSEG.
 */

%macro panels(
        rows=,                              /* number of rows of plots                
*/
        cols=,                              /* number of columns of plots             
*/ 
        plots=&rows * &cols,  /* total number of plots                  
*/
        top=0,                              /* percent of display for top 
panel       */ 
        order=UP,             /* start at bottom (UP) or top (DOWN)?    
*/
        replay=,                                    /* List of plots to replay                
*/
        equate=Y,                           /* Adjust sizes to maintain aspect 
ratio? */ 
        template=panel&rows.&cols,   /* name of template                
*/
        tc=panels,                          /* name of template catalog         
                         */
        first=1,              /* number of the first catalog entry used 
*/
        last=0,               /* number of the last catalog entry used  
*/
        gin=gseg,
        gout=gseg);

%local i j panl panl1 lx ly tx ty sx sy;
%*put PANELS: plots= &plots;

%let order=%upcase(&order);
%let equate=%substr(%upcase(&equate),1,1);

%let abort=0;
%let showgout=0;
%if &rows=%str() | &cols=%str()
        %then %do;
                %put ERROR: The ROWS= and COLS= parameters must be 
specified;
      %let abort=1;
                %goto DONE;
        %end;

%if %length(&top)=0 %then %let top=0;
        
  /* determine how many graphs are in the catalog */
%let npics=0;
  proc catalog catalog=&gin et=grseg;
        contents out=_cont_;
        run;
%if &syserr > 4 %then %let abort=1; %if &abort %then %goto DONE;
  data _null_; 
   set _cont_ end=last; 
        if (last) then call symput('npics',trim(left(put(_n_,5.)))); 
        run;
%put PANELS: The graphics catalog &gin contains &npics graphic entries;
%if &npics=0 %then %goto DONE;
%if &syserr > 4 %then %let abort=1; %if &abort %then %goto DONE;

  %if (&last<1) %then %do;
    %if (%eval(&npics+&last)>=1) %then %let last = %eval(&npics + 
&last);
    %else %do;
      %put NOTE (panels): last=&last too low - setting last=1.;
      %let last = 1;
    %end;
  %end;
  %else %if (&last>&npics) %then %do;
    %put WARNING: last=&last too high - setting last=&npics.;
    %let last = &npics;
  %end;

  %if (&first>&last) %then %do;
        %put WARNING: first=&first too high - no plots done.;
        %goto done;
        %end;

  %if (&first<1) %then %do;
      %if (%eval(&last+&first)>=1) %then %let first = %eval(&last + 
&first);
      %else %do;
        %put WARNING: first=&first too low - setting first=1.;
        %let first = 1;
                  %let showgout=1;
      %end;
  %end;

    %put PANELS: plotting entries &first to &last .... to catalog 
&gout;
  

%*-- If the replay list is not given, construct it, ordering the
        plots across each row, but starting at either the bottom row
        (order=UP) or the top row (order=DOWN);
        
%if &replay=%str() %then %do;
        %if %index(&order,BYROWS)=0 %then %do; 
                %do i = 1 %to &plots;
                        %let j = %eval(&first+&i-1);
                        %let replay = &replay &i:&j ;
                        %end;
                %end;
        %else %do;  /* order= ... BYROWS */
                data _null_;
                        array r(&rows, &cols) $8 _temporary_;
                        length replay $ 200;
                
                        plot = &first;  
                        do j=1 to &cols;
                                do i=1 to &rows;
                                        r[i,j] = left(put(plot,2.));
                                        plot+1;
                                        end;
                                end;
                
                        do i=1 to &rows;
                                do j=1 to &cols;
                                        panel+1;
                                        r[i,j] = trim(left(put(panel,2.))) || ':' 
|| trim(r[i,j]);
                                        replay = trim(replay)  || ' ' || r[i,j];
                                        end;
                                end;
                        call symput('replay', replay);
                run;
                %end;
        %if &top>0 
                %then %let replay = &replay 
%eval(&plots+1):%eval(&first+&plots+1);
        %put PANELS: replay=&replay;
        %end;
        
%*-- Calculate panel size and starting location;
data _null_;
   %if &top>0
       %then %do;  ty=100;      %end;
       %else %do;  ty=100-&top; %end;
   tx=100;
        %if &equate=N %then %do;
                hsize = tx/&cols;
                vsize = ty/&rows;
                sx = 0; sy = 0;
        %end;
        %else %do;
                np = max(&rows,&cols);
                hsize = round(tx/np,.01);
                vsize = round(ty/np,.01);
                sx = round((np - &cols) * hsize/2,.01);
                sy = round((np - &rows) * vsize/2,.01);
        %end;
        lx = round(hsize + sx,.01);
        ly = round(vsize + sy,.01);
*       put hsize= vsize= tx= ty= sx= sy= lx= ly=;

        %if %index(&order,DOWN) %then %do;
                ly = round(ty - sy,.01);
                sy = ly - vsize;
                vsize = -vsize;
        %end;                   

        put 'PANELS: ' hsize= vsize= tx= ty= sx= sy= lx= ly=;
   call symput('hsize', put(hsize,6.2));
   call symput('vsize', put(vsize,6.2));
   call symput('lx', put(lx,6.2));
   call symput('ly', put(ly,6.2));
   call symput('tx', put(tx,6.2));
   call symput('ty', put(ty,6.2));
   call symput('sx', put(sx,6.2));
   call symput('sy', put(sy,6.2));
run;

proc greplay igout=&gin
              gout=&gout  nofs
             template=&template
             tc=&tc ;

%* ---------------------------------------------------------------;
%* Generate a TDEF statement for a plot matrix                    ;
%* Start with (1,1) panel in lower left, and copy it across & up  ;
%* ---------------------------------------------------------------;
   TDEF &template DES="panels template &rows x &cols"
   %let panl=0;
   %* let lx = &hsize;
   %* let ly = &vsize;
   %do i = 1 %to &rows;
   %do j = 1 %to &cols;
                 %if &panl > %eval(&plots) %then %goto fini;
       %let panl  = %eval(&panl + 1);
       %if &j=1 %then
          %do;
             %if &i=1 %then %do;      %* (1,1) panel;
               &panl/
                ULX=&sx  ULY=&ly     URX=&lx  URY=&ly
                LLX=&sx  LLY=&sy     LRX=&lx  LRY=&sy
                %end;
             %else
                %do;                  %* (i,1) panel;
                   %let panl1 = %eval(&panl - &cols );
               &panl/ copy= &panl1 xlatey= &vsize
                %end;
          %end;
       %else
          %do;
               %let panl1 = %eval(&panl - 1);
               &panl/ copy= &panl1 xlatex= &hsize
          %end;
   %end;
   %end;
%fini:
   %if &top>0 %then %do;
       %let panl = %eval(&panl + 1);
         &panl/
          ULX=0  ULY=100     URX=&tx URY=100
          LLX=0  LLY=&ty     LRX=&tx LRY=&ty
   %end;
     %str(;);      %* end the TDEF statement;
   %if &replay ^= %str() %then %do;
      TREPLAY &replay;
                LIST template;
   %end;
        %if &showgout %then %str(LIST IGOUT;);
run;    quit;

%DONE:
%if &abort %then %put ERROR: The PANELS macro ended abnormally.;
options notes;
%mend;

/*-------------------------------------------------------------------*
  *    Name: rootgram.sas                                             *
  *   Title: Hanging rootograms for discrete distributions            *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/rootgram.html           *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *
  * Created: 23 Dec 97 16:28                                          *
  * Revised: 17 Nov 2000 11:40:07                                     *
  * Version: 1.0                                                      *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/
 /* Description:
 
 The ROOTGRAM macro produces histograms, rootograms, and hanging
 rootograms for the distribution of a discrete variable compared
 with expected frequencies according to a theoretical distribution.

Usage:

 The VAR= and  OBS= variables  must be specified.  The expected
 frequencies may be obtained with the GOODFIT macro.
 
 The ROOTGRAM macro is called with keyword parameters.
 The arguments may be listed within parentheses in any order, separated
 by commas. For example: 
 
        %include catdata(madison);
        %goodfit(data=madison, var=count, freq=blocks, dist=poisson);
        %rootgram(data=fit, var=count, obs=blocks);
 
Parameters:

* DATA=       Specifies the name of the input data set [Default: 
DATA=_LAST_]

* VAR=        Specifies the name of the analysis variable, used as the
              abscissa in the plot.

* OBS=        Specifies the observed frequency variable

* EXP=        Expected/fitted frequency [Default: EXP=EXP]

* FUNC=       Function applied to ordinate [Default: FUNC=SQRT]

* BWIDTH=     Bar width [Default: BWIDTH=.5]

* BCOLOR=     Bar color [Default: BCOLOR=GRAYB0]

* BTYPE=      Bar type: One of HANG, DEV, or NEEDLE. [Default: 
BTYPE=HANG]

* ANNO=       The name of an input annotate dataset

* NAME=       Name of the graphics catalog entry

 */

%macro rootgram(
        data=_last_,   /* input dataset                */
        var=,          /* Analysis variable            */
        obs=,          /* observed frequency           */
        exp=exp,       /* expected/fitted frequency    */
        func=Sqrt,     /* function applied to ordinate */
        bwidth=.5,     /* bar width                    */
        bcolor=grayb0, /* bar color                    */
        btype=hang,    /* bar type: HANG, DEV, NEEDLE  */
        anno=,         /* input annotate dataset       */
        name=rootgram  /* graphics catalog entry name  */
        );

%let btype=%upcase(&btype);
data roots;
        set &data;
        
        %if %upcase(&func)^=NONE %then %do;
                &obs = &func(&obs+.000001);
                &exp = &func(&exp+.000001);
                label &exp = "&func(frequency)";
        %end;
        %else %do;      
                label &exp = "Frequency";
        %end;

data bars;
        set roots(keep=&var &obs &exp) end=eof;
        xsys='2'; ysys='2';
        retain min 0 max 0;
        drop inc;
        style = 'solid  ';
        color = "&bcolor";

        %*-- top of bar;
        x = &var - &bwidth/2;
        %if &btype=HANG %then %do;
                y = &exp;
                %end;
        %else %if &btype=DEV %then %do;
                y = &exp - &obs ;
                min = min(y,min);
                max = max(&exp,max);
                %end; 
        %else %do;
                y = &obs;
                %end; 
        function = 'move    '; output;
        max = max(y,max);

        %*-- bottom of bar;
        x = &var + &bwidth/2;
        %if &btype=HANG %then %do;
                y = &exp - &obs;
                %end;
        %else %do;
                y = 0;
                %end; 
        function = 'bar     '; output;
        min = min(y,min);

        if eof then do;
                drop pow nice ut best;
                inc= abs(max - min)/6;
                pow = 10**floor( log10(inc) );
                nice=1000;
                do in = 1, 2, 2.5, 4, 5;
                        ut = in * pow;
                        if abs(inc-ut) < nice then do;
                                nice = abs(inc-ut);
                                best = ut;
                        end;
                end;
                inc=best;
                min = inc * floor(min/inc);
                max = inc * ceil (max/inc);
                put min= max= inc=;
                call symput('max', left(put(max,3.1)));
                call symput('min', left(put(min,3.1)));
                call symput('inc', left(put(inc,3.1)));
                end;
        run;
%put min=&min max=&max inc=&inc;

%if %length(&anno) %then %do;
data bars;
        set bars &anno;
%end;
        
proc gplot data=roots;
        plot &exp * &var / vaxis=axis1 haxis=axis2
                anno=bars hminor=0 vminor=1 vref=0 lvref=7;
        symbol i=spline v=dot c=red h=1.5;
        axis1 label=(a=90) order=(&min to &max by &inc);
        axis2 offset=(5,5);
        run; quit;
%done:
goptions reset=symbol;
%mend;

/*-------------------------------------------------------------------*
  *    Name: corresp.sas                                              *
  *   Title: Correspondence analysis of contingency tables            *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/corresp.html            *
  *                                                                   *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *
  * Created:  19 Jan 1990 15:23:09                                    *
  * Revised:   9 Nov 2000 11:45:28                                    *
  * Version:  1.8                                                     *
  * 1.2  Added dim parameter and colors                               *
  * 1.3  Added graphics GPLOT plot, annotation controls               *
  * 1.5  Uses PROC CORRESP rather than IML , equate axes              *
  *      Now handles MCA, stacked analysis, and other options.        *
  * 1.6  Added 3D plotting (but cant equate axes or control rotation  *
  *      tilt, etc.)                                                  *
  * 1.7  Revised syntax to be more compatible with PROC CORRESP       *
  *      Added Version 8 MCA warning to use BENZECRI/GREENACRE        *
  * 1.8  Fixed validvarname for V7+                                   *
  *                                                                   *
  * Requires: %label, %equate                                         *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/
/* Description:
 
 The CORRESP macro carries out simple correspondence analysis of a
 two-way contingency table, and various extensions (stacked analysis,
 MCA) for a multiway table, as in the CORRESP procedures.  It also
 produces labeled plots of the category points in either 2 or 3
 dimensions, with a variety of graphic options, and the facility to
 equate the axes automatically. 

 The macro takes input in one of two forms:

(a) A data set in contingency table form, where the columns are
 separate variables and the rows are separate observations (identified
 by a row ID variable).  That is, the input data set contains R
 observations, and C variables (whose values are cell frequencies)
 for an R x C table.  For this form, specify:

                ID=ROWVAR, VAR=C1 C2 C3 C4 C5

(b) A contingency table in frequency form (e.g., the output from PROC 
FREQ),
 or raw data, where there is one variable for each factor.  In 
frequency
 form, there will be one observation for each cell.
 For this form, specify:

                TABLES=A B C

 Include the WEIGHT= parameter when the observations are in frequency
 form.
         
Usage:

 The CORRESP macro is called with keyword parameters.  Either the
 VAR= parameter or the TABLES= parameter (but not both) must be
 specified, but other parameters or OPTIONS may be needed to carry
 out the analysis you want.  The arguments may be listed within
 parentheses in any order, separated by commas.  For example:
 
        %corresp(var=response, id=sex year);
 
 The plot may be re-drawn or customized using the output OUT=
 data set of coordinates and the ANNO= Annotate data set.

 The graphical representation of CA plots requires that the axes in the
 plot are equated, so that equal distances on the ordinate and abscissa
 represent equal data units (to perserve distances and angles in the 
plot).
 A '+', whose vertical and horizontal lengths should be equal,
 is drawn at the origin to indicate whether this has been achieved.

 If you do not specifiy the HAXIS= and YAXIS= parameters, the EQUATE
 macro is called to generate the AXIS statements to equate the
 axes.  In this case the INC=, XEXTRA=, and YEXTRA=, parameters
 may be used to control the details of the generated AXIS statements.

 By default, the macro produces and plots a two-dimensional solution.
 
Parameters:

* DATA=         Specifies the name of the input data set to be 
analyzed.
            [Default: DATA=_LAST_]

* VAR=          Specifies the names of the column variables for 
simple
            CA, when the data are in contingency table form.
                                Not used for MCA (use the TABLES= parameter 
instead).

* ID=           Specifies the name(s) of the row variable(s) for simple
            CA.  Not used for MCA.

* TABLES=   Specifies the names of the factor variables used to create
            the rows and columns of the contingency table.  For a 
simple
            CA or stacked analysis, use a ',' or '/' to separate the
                                the row and column variables.

* WEIGHT=   Specifies the name of the frequency (WEIGHT) variable when
            the data set is in frequency form.  If WEIGHT= is omitted,
            the observations in the input data set are not weighted.

* SUP=      Specifies the name(s) of any variables treated as 
supplementary.
            The categories of these variables are included in the 
output,
            but not otherwise used in the computations.  
            These must be included among the variables in the VAR= or
                                TABLES= option.  

* DIM=      Specifies the number of dimensions of the CA/MCA solution.
            Only two dimensions are plotted by the PPLOT option,
                                however. [Default: DIM=2]

* OPTIONS=  Specifies options for PROC CORRESP.  Include MCA for an
            MCA analysis, CROSS=ROW|COL|BOTH for stacked analysis of
                                multiway tables, PROFILE=BOTH|ROW|COLUMN for 
various
                                coordinate scalings, etc.  [Default: 
OPTIONS=SHORT]

* OUT=          Specifies the name of the output data set of 
coordinates.
            [Default: OUT=COORD]

* ANNO=         Specifies the name of the annotate data set of labels
            produced by the macro.  [Default: ANNO=LABEL]

* PPLOT=    Produce a printer plot? [Default: PPLOT=NO]

* GPLOT=    Produce a graphics plot? [Default: GPLOT=YES]

* PLOTREQ=  The dimensions to be plotted [Default: PLOTREQ=DIM2*DIM1
            when DIM=2, PLOTREQ=DIM2*DIM1=DIM3 when DIM=3]

* HTEXT=    Height for row/col labels.  If not specified, the global
            HTEXT goption is used.  Otherwise, specify one or two 
numbers
                                to be used as the height for row and column 
labels.
                                The HTEXT= option overrides the separate ROWHT= 
and COLHT=
                                parameters (maintained for backward 
compatibility).

* ROWHT=    Height for row labels

* COLHT=    Height for col labels

* COLORS=   Colors for row and column points, labels, and 
interpolations.
            In an MCA analysis, only one color is used.
            [Default: COLORS=BLUE RED]

* POS=      Positions for row/col labels relative to the points.
            In addition to the standard Annotate position values, the
                                CORRESP macro also understands the special 
characters "/", 
                                "|", or "-".  [Default: POS=5 5]

* SYMBOLS=  Symbols for row and column points, as in a SYMBOL 
statement.
            [Default: SYMBOLS=NONE NONE]

* INTERP=   Interpolation options for row/column points. In addition to 
the
            standard interpolation options provided by the SYMBOL 
statement,
                                the CORRESP macro also understands the option 
VEC to mean
                                a vector from the origin to the row or column 
point.
                           The option JOIN may be useful for an ordered 
factor, and 
                                the option NEEDLE may be useful to focus on the 
positions 
                                of the row/column points on the horizontal 
variable.
                                [Default: INTERP=NONE NONE, INTERP=VEC for MCA]

* HAXIS=    AXIS statement for horizontal axis.  If both HAXIS= and
            VAXIS= are omitted, the program calls the EQUATE macro to
                                define suitable axis statements.  This creates 
the axis
                                statements AXIS98 and AXIS99, whether or not a 
graph
                                is produced.

* VAXIS=    The name of an AXIS statement for the vertical axis.

* VTOH=     The vertical to horizontal aspect ratio (height of one
            character divided by the width of one character) of the
                                printer device, used to equate axes for a 
printer plot,
                                when PPLOT=YES.  [Default: VTOH=2]

* INC=      The length of X and Y axis tick increments, in data units
            (for the EQUATE macro).  Ignored
            if HAXIS= and VAXIS= are specified. [Default: INC=0.1 0.1]

* XEXTRA=   # of extra X axis tick marks at the left and right.  Use to
            allow extra space for labels. [Default: XEXTRA=0 0]

* YEXTRA=   # of extra Y axis tick marks at the bottom and top.
            [Default: YEXTRA=0 0]

* M0=       Length of origin marker, in data units. [Default: M0=0.05]

* DIMLAB=   Prefix for dimension labels [Default: DIMLAB=Dimension]

* NAME=     Name of the graphics catalog entry [Default: NAME=Corresp]        

Dependencies:
 
 The CORRESP macro calls several other macros not included here.
 It is assumed these are stored in an autocall library.  If not,
 you'll have to %include them in your SAS session or batch program.
 
 LABEL macro - label points 
 EQUATE macro - equate axes
 
 These are all available by ftp://hotspur.psych.yorku.ca/pub/sas
 (though in different subdirectories).

Bugs:

 Using SUP= variables messes up the assignment of symbols and colors
 to the row and column coordinates.
 
*/

%macro CORRESP(
        data=_LAST_,        /* Name of input data set                */
        var=,               /* Column variable(s)                    */
        tables=,            /* TABLES statement variables            */
        id=,                /* Row variable or row labels            */
        weight=,            /* Frequency variable (obs. weight)      */
        count=,             /* Frequency variable (obs. weight)      */
        sup=,               /* Supplementary variable(s)             */
        dim=2,              /* Number of CA dimensions               */
        options=short,      /* options for PROC CORRESP              */       
        out=COORD,          /* output data set for coordinates       */
        anno=LABEL,         /* name of annotate data set for labels  */
        pplot=NO,           /* Produce printer plot?                 */
        gplot=YES,          /* Produce graphics plot?                */
        plotreq=,           /* dimensions to be plotted              */
        htext=,             /* height for row/col labels             */
        rowht=,             /* height for row labels                 */
        colht=,             /* height for col labels                 */
        colors=BLUE RED,    /* Colors for rows and cols              */
        pos=5 5,            /* positions for row/col labels          */
        symbols=none none,  /* symbols for row and column points     */
        interp=,            /* interpolations for row/column points  */
        haxis=,             /* AXIS statement for horizontal axis    */
        vaxis=,             /* and vertical axis- use to equate axes */
        vtoh=2,             /* PPLOT cell aspect ratio               */
        inc=0.1 0.1,        /* x, y axis tick increments             */
        xextra=0 0,         /* # of extra x axis tick marks          */
        yextra=0 0,         /* # of extra y axis tick marks          */
        m0=0.05,            /* Length of origin marker               */
        dimlab=,            /* Dimension label                       */
        name=corresp        /* Name for graphics catalog entry       */
     ); 

        %*-- Reset required global options;
        %if &sysver >= 7 %then %do;
                %local o1 o2;
                %let o1 = %sysfunc(getoption(notes));
                %let o2 = %sysfunc(getoption(validvarname,keyword));
                options nonotes validvarname=V6;
                %end;
        %else %do;
           options nonotes;
                %end;


%let abort=0;
%*-- Check for required parameters;
%if %length(&var)=0 and %length(&tables)=0
   %then %do;
      %put ERROR: Either the VAR= or TABLES= parameter must be 
specified;
      %let abort=1;
      %goto DONE;
   %end;

%*-- Use weight and count as synonyms;
%if %length(&count)=0 and %length(&weight)>0
        %then %let count=&weight;
        
%*-- Set defaults which depend on other options;
%if %length(&plotreq)=0 %then %do;
        %if &dim=2 %then %let plotreq =  dim2 * dim1;
        %if &dim=3 %then %let plotreq =  dim2 * dim1 = dim3;
        %else %let plotreq =  dim2 * dim1;
        %end;

%if %length(&dimlab)=0 %then %do;
        %if &dim=2 %then %let dimlab = Dimension;
        %if &dim=3 %then %let dimlab = Dim;
        %end;

%if %length(&interp)=0 %then %do;
        %if %index(&options, MCA) %then %let interp=vec;
        %else %let interp=none none;
        %end;

%if %index(&options, MCA) & &sysver>7 %then %do;
        %if %index(&options, BENZECRI)=0 & %index(&options, GREENACRE)=0 
%then %do;
                %put WARNING: For MCA in Version &sasver, you should use 
the BENZECRI or GREENACRE options.;
                %end;
        %end;

%*-- Make character options case-insensitive;
%let pplot=%upcase(&pplot);
%let gplot=%upcase(&gplot);
%let interp=%upcase(&interp);
%let options=%upcase(&options);
options nonotes;

%if %length(&tables) %then %do;
        %let i=%index(&tables,/);               %*-- allow '/' rather than 
',' in tables;
        %if &i>0 %then %do;
   data _null_;
      length tables $ 200;
      tables = "&tables";
      tables = translate(tables, ',', '/');
      call symput('tables', trim(tables));
   run;
                %end;
                
        proc corresp data=&data outc=&out dimens=&dim &options;
                %if %length(&count) %then %str(weight &count;);
                tables &tables;
                %if %length(&sup) %then %str(sup &sup;);
        %end;
%else %do;
        proc corresp data=&data outc=&out dimens=&dim &options;
                %if %length(&count) %then %str(weight &count;);
                var &var;
                id &id;
                %if %length(&sup) %then %str(sup &sup;);
        %end;

%if &syserr > 4 %then %let abort=1; %if &abort %then %goto DONE;

%if %index(&options,MCA) %then %do;
        %*-- Find number of table variables;
        data _null_;
                set &data;
                array tab{*} &tables;
                if _n_=1 then do;
                        nv = dim(tab);
                        call symput('nv', left(put(nv,2.)));
                        end;
        run; 
        %end;

 /*-----------------------------------------------*
  |  Add % inertia to DIM labels (fix for MCA)    |
  *-----------------------------------------------*/
data &out;
   set &out nobs=nobs;
   drop i percent label;
   length label $30;
        array dimen{*} dim1-dim&dim;
        array contr{*} contr1-contr&dim;
        
        if nobs=0 then do;     *-- Check for empty output data set;
                call symput('abort', '1');
                stop;
                end;

        %if %length(&id)>0 %then %do;
                rename &id = _name_;
                %end;

        if _type_='INERTIA' then do;
                do i=1 to &dim;
                        %if %index(&options,MCA) %then %do;
                                %*-- Benzecri formula for %inertia in MCA;
                                dimen{i} = (&nv/(&nv-1)) * (contr{i}-(1/&nv));
                                %end;
                        percent = ' (' ||compress(put((100*contr{i} / 
inertia), 5.1)) || '%)';
                        label = "&dimlab" || ' ' || put(i,1.) 
                        %if %index(&options,MCA) = 0
                                %then %str(||  trim(percent));
                                ;
                        call symput('p'||trim(left(put(i,2.))), label);
                        end;
                end;
run;
%if &abort %then %goto DONE;

data &out;
        set &out;
   label                                                                        
   %do i=1 %to &dim;                                                            
       dim&i = "&&p&i"                                                   
       %end;                                                                    
   ;
                                                                       
proc print data=&out;
   id _type_ _name_;
        var dim1-dim&dim quality;

%*-- Plot increments;
%let n1= %scan(&inc,1,%str( ));                                                      
%let n2= %scan(&inc,2,%str( ));
%if &n2=%str() %then %let n2=&n1;

%*-- Find dimensions to be ploted;
%let ya = %scan(&plotreq,1,%str(* ));
%let xa = %scan(&plotreq,2,%str(* ));
%let za = %scan(&plotreq,3,%str(=* ));
%*put Plotting &ya * &xa = &za;
        

%if &pplot = YES %then %do;
        %put WARNING: Printer plots may not equate axes (using 
VTOH=&vtoh);                                                     
   %if &sysver < 6.08
       %then %do;
          %put WARNING: CORRESP cannot label points adequately using
               PROC PLOT in SAS &sysver - use SAS 6.08 or later;
          %let symbol = %str( = _name_ );
          %let place =;
       %end;
       %else %do;
           %let symbol = $ _name_ = '*';
           %let place = placement=((h=2 -2 : s=right left)
                                   (v=1 -1 * h=0 -1 to -3 by alt)) ;
       %end;
 
        proc plot data=&out vtoh=&vtoh;
                where (_type_ ^= 'INERTIA');
                plot &ya * &xa &symbol
                        / haxis =by &n1 vaxis=by &n2 &place box;
%end;

 /*--------------------------------------------------*
  | Annotate row and column labels                   |
  *--------------------------------------------------*/
        %*-- Assign colors / positions;
        %let c1= %scan(&colors,1);                                                      
        %let c2= %scan(&colors,2);
        %if &c2=%str() %then %let c2=&c1;
        %let p1 = %scan(&pos,1,%str( ));
        %let p2 = %scan(&pos,2,%str( ));
        %if "&p2"="" %then %let p2=&p1;

        %if %length(&htext)>0 %then %do;
                %let rowht = %scan(&htext,1,%str( ));
                %let colht = %scan(&htext,2,%str( ));
                %if &colht=%str() %then %let colht=&rowht;
                %end;

        %*-- Assign symbols and interpolations;
        %let s1= %scan(&symbols,1);                                                      
        %let s2= %scan(&symbols,2);
        %if &s2=%str() %then %let s2=&s1;
        %let i1= %upcase(%scan(&interp,1));                                                      
        %let i2= %upcase(%scan(&interp,2));
        %if &i2=%str() %then %let i2=&i1;

data _lab_;
        set &out(keep=_type_ _name_ dim1-dim&dim);
        where (_type_ ^= 'INERTIA');

        %label(data=_lab_, x=&xa, y=&ya, z=&za, text=_name_, size=&rowht,
      color="&c1", subset=_type_='OBS', pos=&p1, out=_lab1_, len=16,
                copy=_type_);
        %label(data=_lab_, x=&xa, y=&ya, z=&za, text=_name_, size=&colht,
      color="&c2", subset=_type_='VAR', pos=&p2, out=_lab2_, len=16,
                copy=_type_);
        %if %length(&sup) %then %do;
        %label(data=_lab_, x=&xa, y=&ya, z=&za, text=_name_, size=&colht,
      color='black', subset=_type_=:'SUP', pos=&p2, out=_lab3_, len=16,
                copy=_type_);
                %end;
        
        options nonotes;

 /*--------------------------------------------------*
  | Handle vector interpolation                      |
  *--------------------------------------------------*/
                                               
%if &i1=VEC or &i2=VEC %then %do;
data _vector_;
        set &out(keep=_type_ _name_ dim1-dim&dim);
        where (_type_ ^= 'INERTIA');
        drop dim1-dim&dim;
        retain xsys ysys '2';
        %if &dim=3 %then %do; retain zsys '2'; %end;             
        %if &i1=VEC %then %do;
      color="&c1";
                if _type_ = 'OBS' then link vec;
                %end;
        %if &i2=VEC %then %do;
      color="&c2";
                if _type_ = 'VAR' then link vec;
                %end;
                return;
vec:                    /* Draw line from the origin to point */
      x = 0; y = 0;
                %if &dim=3 %then %do; z=0; %end;             
      function='MOVE'    ; output;                                              
      x = &xa; y = &ya;                
                %if &dim=3 %then %do; z=&za; %end;             
      function='DRAW'    ; output;                                              
                return;
%end;

 /*--------------------------------------------------*
  | Mark the origin                                  |
  *--------------------------------------------------*/
%if &m0 > 0 %then %do;
data _zero_;
        xsys='2';  ysys='2';
        %if &dim=3 %then %do; zsys='2'; z=0; %end;             
        x = -&m0;  y=0;   function='move'; output;
        x =  &m0;         function='draw'; output;
        x = 0;  y = -&m0; function='move'; output;
                y =  &m0; function='draw'; output;
%end;

 /*--------------------------------------------------*
  | Concatenate anotate data sets                    |
  *--------------------------------------------------*/
data &anno;
        set _lab1_ _lab2_ 
        %if %length(&sup) %then %str(_lab3_);
        %if &m0 > 0 %then _zero_ ;
        %if &i1=VEC or &i2=VEC %then _vector_;
        ;
%if &i1=VEC %then %let i1=none;
%if &i2=VEC %then %let i2=none;

%if %length(&vaxis)=0 and %length(&haxis)=0 %then %do;
        %let x1= %scan(&xextra,1);                                                      
        %let x2= %scan(&xextra,2);
        %if &x2=%str() %then %let x2=&x1;
        %let y1= %scan(&yextra,1);                                                      
        %let y2= %scan(&yextra,2);
        %if &y2=%str() %then %let y2=&y1;

        %equate(data=&out, x=&xa, y=&ya, plot=no,
                vaxis=axis98, haxis=axis99, xinc=&n1, yinc=&n2,
                xmextra=&x1, xpextra=&x2, ymextra=&y1, ypextra=&y2);
        %let vaxis=axis98;
        %let haxis=axis99;
        options nonotes;
        %end;
%else %do;
%if %length(&vaxis)=0 %then %do;
        %let vaxis=axis98;
        %put WARNING:  You should use an AXISn statement and specify 
VAXIS=AXISn to equate axis units and length;
   axis98 label=(a=90);
        %end;
%if %length(&haxis)=0 %then %do;
        %let haxis=axis99;
        %put WARNING:  You should use an AXISm statement and specify 
HAXIS=AXISm to equate axis units and length;
   axis99 offset=(2);
        %end;
%end;

symbol1 v=&s1 i=&i1 l=33 c=&c1;
symbol2 v=&s2 i=&i2 l=20 c=&c2;
symbol3 v=none;
%if &gplot = YES %then %do;
        %if &dim=2 or %length(&za)=0 %then %do;
        proc gplot data=&out  ;
                where (_type_ ^= 'INERTIA');
                plot &ya * &xa = _type_
                                / anno=&anno frame nolegend
                                        vaxis=&vaxis haxis=&haxis vminor=1 
hminor=1
                                        name="&name"
                                        des="CORRESP plot of &data";
        run;quit;
        %end;

        %else %if &dim=3 %then %do;
        %put WARNING: 3D plots do not equate axes.  Try GOPTIONS HSIZE 
and VSIZE.;                                                     
        proc g3d data=&out  ;
                where (_type_ ^= 'INERTIA');
                plot &ya * &xa = &za
                                / anno=&anno  
                                        xticknum=2 yticknum=2 zticknum=2 grid
                                        name="&name"
                                        des="3D CORRESP plot of &data";
        run;quit;
        %end;

%end;   /* %if &gplot = YES */

 /*------------------------------------*
  | Clean up datasets no longer needed |
  *------------------------------------*/
proc datasets nofs nolist library=work memtype=(data);
    delete _lab1_ _lab2_
        %if %length(&sup) %then _lab3_;
         %if &i1=VEC or &i2=VEC %then _vector_;
         ;
         run; quit;

%done:
%if &abort %then %put ERROR: The CORRESP macro ended abnormally.;
        %*-- Restore global options;
        %if &sysver >= 7 %then %do;
                options &o1 &o2;
                %end;
        %else %do;
           options notes;
                %end;
%mend;

/*-------------------------------------------------------------------*
  *    Name: goodfit.sas                                              *
  *   Title: Goodness of fit tests for discrete distributions         *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/goodfit.html            *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *
  * Created: 09 Dec 1997 13:29                                        *
  * Revised: 9 Nov 2000 12:01:48                                     *
  * Version: 1.3                                                      *
  * 1.2  Corrected error in DF calculation with SUMAT= given          *
  * 1.3  Fixed validvarname for V7+                                   *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/
 /* Description:

 The GOODFIT macro carries out Chi-square goodness-of-fit tests for
 discrete distributions.  These include the uniform, binomial,
 Poisson, negative binomial, geometric, and logarithmic series
 distributions, as well as any discrete (multinomial) distribution
 whose probabilities you can specify.  Both the Pearson chi-square
 and likelihood-ratio chi-square are computed.

 The data may consist either of individual observations on a single
 variable, or a grouped frequency distribution.  

 The parameter(s) of the distribution may be specified as constants
 or may be estimated from the data.

Usage:
 
 The GOODFIT macro is called with keyword parameters.
 The arguments may be listed within parentheses in any order, separated 
by commas. For example: 
 
   %goodfit(var=k, freq=freq, dist=binomial);

 You must specify a VAR= analysis variable and the keyword for the
 distribution to be fit with the DIST= parameter.  All other parameters
 are optional.

Parameters:

* DATA= Specifies the name of the input data set to be analyzed.

* VAR=  Specifies the name of the variable to be analyzed, the 
basic
                        count variable.

* FREQ= Specifies the name of a frequency variable for a grouped 
data
                        set.  If no FREQ= variable is specified, the program 
assumes
                        the data set is ungrouped, and calculates frequencies 
using
                        PROC FREQ.  In this case you can specify a SAS format 
with the
                        FORMAT= parameter to control the way the observations 
are
                        grouped.

* DIST=  Specifies the name of the discrete distribution to be fit.
                        The allowable values are:
                        UNIFORM, DISCRETE, BINOMIAL, POISSON, NEGBIN, 
GEOMETRIC,
                        LOGSERIES.

* PARM= Specifies the value of parameter(s) for the distribution 
being
                        fit.  If PARM= is not specified, the parameter(s) are 
estimated
                        using maximum likelihood or method of moment 
estimators.

* SUMAT=        For a distribution where frequencies for values of the VAR=
                        variable >= k have been lumped into a single 
category, specify
                        SUMAT=k causes the macro to sum the probabilities and 
fitted
                        frequencies for all values >=k.

* FORMAT= The name of a SAS format used when no FREQ= variable has been
                        specified.

* OUT=  Name of the output data set containing the grouped 
frequency
                        distribution, estimated fitted frequencies (EXP) and 
the values
                        of the Pearson (CHI) and deviance (DEV) residuals.

* OUTSTAT= Name of the output data set containing goodness-of-fit
                        statistics.

Bugs:

See also:

* ROOTGRAM

 */
 

%macro goodfit(
        data=_last_,       /* name of the input data set             */
        var=,              /* analysis variable                      */
        freq=,             /* frequency variable                     */
        dist=,             /* distribution to be fit                 */
        parm=,             /* required distribution parameters       */
        sumat=100000,
        format=,           /* format for ungrouped analysis variable */
        out=fit,           /* output fit data set                    */
        outstat=stats);    /* output statistics data set             */


        %*-- Reset required global options;
        %if &sysver >= 7 %then %do;
                %local o1 o2;
                %let o1 = %sysfunc(getoption(notes));
                %let o2 = %sysfunc(getoption(validvarname,keyword));
                options nonotes validvarname=V6;
                %end;
        %else %do;
           options nonotes;
                %end;

%let usedata=&data;
%let dist=%upcase(&dist);
%let abort=0;

%if &var=%str() | &dist=%str()
   %then %do;
      %put ERROR: The VAR= and DIST= parameters must be specified.;
      %let abort=1;
      %goto DONE;
   %end;

%if %length(%scan(&var,2))
   %then %do;
      %put ERROR: Only one VAR= variable is allowed.;
      %let abort=1;
      %goto DONE;
   %end;

%if %index(UNIFORM DISCRETE BINOMIAL POISSON NEGBIN GEOMETRIC 
LOGSERIES,&dist)=0
   %then %do;
      %put ERROR: The DIST=&DIST is not a recognized distribution.;
      %let abort=1;
      %goto DONE;
   %end;

%*-- Assume individual observations if no freq was given;
%if %length(&freq)=0 %then %do;
        proc freq data=&data;
                tables &var / noprint out=_counts_;
                %if %length(&format) %then %do;
                        %if %index(&format,.)=0 %then %let format = 
&format..;
                        format &var &format;
                        %end;
                run;
        
        %let usedata=_counts_;
        %let freq=count;
%end;

%*-- Find total frequency, number of cells, mean, var;
proc summary data=&usedata vardef=weight;
        var &var;
        weight &freq;
        output out=_total_ sum=_total_ sumwgt=n mean=_mean_ max=_max_ 
var=_var_;
%if &syserr > 4 %then %let abort=1; %if &abort %then %goto DONE;

%*-- Find number of cells summed, if any;
data _total_;
        set &usedata end=eof nobs=_cells_;
        if _n_=1 then set _total_(drop=_type_);
        keep _total_ n _mean_ _max_ _var_ _sumd_;
        retain _sumd_ 0;
        
        if _cells_ > &sumat then do;
                if &var > &sumat then _sumd_+1;
                end;
        if eof then output;
        
*proc print;

%*-- Determine if any parameters were passed;
%if %length(&parm) > 0
        %then; %let nparm = %words(&parm);
%*put nparm= &nparm;
%let pname=;
%let eparm=;

data &out;
        set &usedata end=eof nobs=_cells_;
        if _n_=1 then set _total_;
        drop _max_ _total_ n _mean_ _sumd_;

        %if &nparm>0 %then %do;
                %*-- Store parameters in an array;
                array _xp_  _xp1-_xp&nparm ( &parm );
                drop _xp1-_xp&nparm;
        %end;
        
        %if &dist=UNIFORM %then %do;
                df = (_cells_ - _sumd_) - 1;
                if &var < &sumat
                        then phat = 1 / _cells_;
                        else phat = (_cells_ - &sumat + 1)/_cells_;
                %end;           

        %else %if &dist=DISCRETE %then %do;
                %let pname=cell proportions;
                %if &nparm=0 %then %do;
            phat = &freq * &var /n;
                        %end;
        %else %do;
                %*-- Parameters are proportional to cell probabilities; 
                if _n_=1 then do;
                        drop _tot_;
                        _tot_ = sum(of _xp1-_xp&nparm);
                        do _i_=1 to &nparm;
                                _xp_[_i_] = _xp_[_i_] / _tot_;
                                end;
                        end;
                        
                phat = _xp_[_n_];
        %end;
                df = (_cells_ - _sumd_) - 1;
                %end;

        %else %if &dist=POISSON %then %do;
                %let pname=lambda;
                %if &nparm=0 %then %do;
                        df = (_cells_ - _sumd_) - 2;
                        parm = _mean_;
                        call symput('eparm', left(put(parm, 7.4)));
                        %end;
                %else %do;
                        parm = _xp_[1];
                        df = (_cells_ - _sumd_) - 1;
                        %end;
                if &var < &sumat
         then phat = exp(-parm) * parm**&var / gamma(&var+1);
                        else phat = 1 - poisson(parm, &var-1);
                %end; 

        %else %if &dist=BINOMIAL %then %do;
                %let pname=p;
                %if &nparm=0 %then %do;
                        p = _mean_ / _max_;
                        call symput('eparm', left(put(p, 7.4)));
                        df = (_cells_ - _sumd_) - 2;
                        %end;
                %else  /* %if &nparm>0 %then */ %do;
                        p = _xp_[1];
                        df = (_cells_ - _sumd_) - 1;
                        %end;
                if &var=0
                        then phat = probbnml(p, _max_, &var);
                        else if &var < &sumat
                 then phat = probbnml(p, _max_, &var) -
                                     probbnml(p, _max_, &var-1);
            else phat =  1 - probbnml(p, _max_, &var-1);
                %end;

        %else %if &dist=NEGBIN %then %do;
                %let pname=n, p;
                %if &nparm=0 %then %do;
                        df = (_cells_ - _sumd_) - 3;
                p = _mean_ / _var_;
                parm = _mean_**2 / (_var_ - _mean_);
                        call symput('eparm', trim(left(put(parm, 7.4))) || ', 
' || left(put(p, 7.4)));
                %end;
        %else %do;              *-- parameters are: n, p;
                        parm = _xp_[1];
                        p =    _xp_[2];
                        df = (_cells_ - _sumd_) - 1;
           %end;
                if &var < &sumat then
                        phat = (gamma(parm+&var)/(gamma(&var+1)*gamma(parm))) 
*
               (p**parm)*(1-p)**&var;
                else do v=&var by 1 until (term < .00001); 
                        term = (gamma(parm+v)/(gamma(v+1)*gamma(parm))) *
               (p**parm)*(1-p)**v;
                        phat = sum(phat, term);
                        end;
                drop term v;
                %end;

        %else %if &dist=GEOMETRIC %then %do;    **-- INCOMPLETE --;
                %let pname=p;
                %if &nparm=0 %then %do;
                        df = (_cells_ - _sumd_) - 2;
         parm = 1/(_mean_);
                        call symput('eparm', left(put(parm, 7.4)));
                        %end;
                %else %do;
                        df = (_cells_ - _sumd_) - 1;
                        parm = _xp_[1];
                        %end;
*               phat = ((_mean_-1)**(&var-1)) /(_mean_**&var);
                if &var < &sumat then
                        phat = parm * (1-parm)**(&var-1);
                else do v=&var by 1 until (term < .00001); 
                        term =  parm * (1-parm)**(v-1);
                        phat = sum(phat, term);
                        end;
                drop term v;
                %end;

        %else %if &dist=LOGSERIES %then %do;
                %let pname=theta;
                %if &nparm=0 %then %do;
                        df = (_cells_ - _sumd_) - 2;
                        *Birch estimator;
                        parm = 1 - (1 / (1 + ((5/3)- log(_mean_)/16)*(_mean_-
1)+2)*log(_mean_));
                        call symput('eparm', left(put(parm, 7.4)));
                        %end;
                %else %do;
                        parm = _xp_[1];
                        df = (_cells_ - _sumd_) - 1;
                        %end;
                if &var < &sumat then
                        phat = parm**&var/(-&var*log(1-parm));
                else do v=&var by 1 until (term < .00001); 
                        term =  parm**v/(-v*log(1-parm));
                        phat = sum(phat, term);
                        end;
                drop term v;
                %end;

        exp  = n * phat;        
        chi = (&freq - exp) / sqrt(exp);
        
        if &freq = 0 
                then dev = 0;
                else dev = 2* &freq * log(&freq/(exp + (exp=0)));
        dev = sign(&freq - exp) * sqrt(abs(dev));
        if &var <= &sumat 
                then output;

        label exp='Fitted frequency'
        phat= 'Fitted probability'
                chi = 'Pearson residual'
                dev = 'Deviance residual';

proc print;             
        id &var;
        var &freq phat exp chi dev;
        sum &freq phat exp;

data &outstat;
        keep dist stat value df prob;
        set &out end=eof;
        chisq + (chi**2);
        g2 + sign(dev)*(dev**2);

        *-- Output statistics to dataset;
        if eof then do;
                pchisq = 1-probchi(chisq,df);
                pg2 = 1-probchi(g2,df);

                dist = "&dist";
                stat = 'Pearson Chi-square  ';
                value= chisq;
                prob = pchisq;
                output;

                stat = 'Likelihood ratio G2';
                value= g2;
                prob = pg2;
                output;

        *-- Prepare printed output summary;
                file print;
                length label $40;
                call label(&var, label);
                if upcase("&var")=label then label='';
                put /  @10 "Goodness-of-fit test for data set 
%upcase(&data)"
                    // @10 "Analysis variable:       %upcase(&var) " label
                    /  @10 "Distribution:            &dist";
                %if &nparm>0 %then %do;
                put    @10 "Specified Parameters:    &pname = &parm";
                %end;
                %if %length(&eparm)>0 %then %do;
                put    @10 "Estimated Parameters:    &pname = &eparm";
                %end;
                                
                put /  @10 'Pearson chi-square    = ' chisq 
                    /  @10 'Prob > chi-square     = ' pchisq
                    // @10 'Likelihood ratio G2   = ' g2 
                    /  @10 'Prob > chi-square     = ' pg2
                         // @10 'Degrees of freedom    = ' df;
                end;
   run;
*proc print;

%done:
%if &abort %then %put ERROR: The GOODFIT macro ended abnormally.;

        %*-- Restore global options;
        %if &sysver >= 7 %then %do;
                options &o1 &o2;
                %end;
        %else %do;
           options notes;
                %end;

%mend;

/*-------------------------------------------------------------------*
  *    Name: lags.sas                                                 *
  *   Title: Macro for lag sequential analysis                        *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/lags.html               *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@YorkU.ca>         *
  * Created: Mar 21 14:03:21 EST 1996                                 *
  * Revised: Apr 26 09:45:34 EDT 1996                                 *
  * Version:  1.1                                                     *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/

 /* Description:

Given a variable containing event codes (char or numeric), the LAGS 
macro
creates:
(a) a dataset containing n+1 lagged variables, _lag0 - _lagN (_lag0
                is just a copy of the input event variable)
(b) optionally, an (n+1)-way contingency table containing frequencies 
of
        all combinations of events at lag0 -- lagN

Either or both of these datasets may be used for subsequent analysis
of sequential dependencies.  One or more BY= variables may be 
specified,
in which case separate lags and frequencies are produced for each 
value of the BY variables.

Usage:

One event variable must be specified with the VAR= option.  All other 
options have default values.  If one or more BY= variables are 
specified,
lags and frequencies are calculated separately for each combination of
values of the BY= variable(s).

The arguments may be listed within parentheses in any order, separated
by commas. For example:

   %lags(data=codes, var=event, nlag=2)

Parameters:

* DATA= The name of the SAS dataset to be lagged.  If DATA= is not
                        specified, the most recently created data set is 
used.

* VAR=   The name of the event variable to be lagged.  The variable may
         be either character or numeric.

* BY=    The name of one or more BY variables.  Lags will be restarted
         for each level of the BY variable(s).  The BY variables may
                        be character or numeric.

* VARFMT=  An optional format for the event VAR= variable.  If the 
codes
         are numeric, and a format specifying what each number means
                        is used (e.g., 1='Active' 2='Passive'), the output 
lag variables
                        will be given the character values. 

* NLAG=   Number of lags to compute.  Default = 1.

* OUTLAG=  Name of the output dataset containing the lagged variables.  
This
         dataset contains the original variables plus the lagged 
variables,
                        named according to the PREFIX= option.

* PREFIX=   Prefix for the name of the created lag variables.  The 
default
         is PREFIX=_LAG, so the variables created are named _LAG1, 
_LAG2,
                        ..., up to _LAG&nlag.  For convenience, a copy of the 
event
                        variable is created as _LAG0.

* FREQOPT=  Options for the TABLES statement used in PROC FREQ for the
         frequencies of each of lag1-lagN vs lag0 (the event variable).
                        The default is FREQOPT= NOROW NOCOL NOPERCENT CHISQ.
                        
Arguments pertaining to the n-way frequency table:

* OUTFREQ=  Name of the output dataset containing the n-way frequency
         table.  The table is not produced if this argument is not
                        specified.

* COMPLETE=    NO, or ALL specifies whether the n-way frequency table
         is to be made 'complete', by filling in 0 frequencies for
                        lag combinations which do not occur in the data.

Example:

 Assume a series of 16 events have been coded with the 3 codes, a, b, 
c,
 for 2 subjects as follows:
 
  Sub1:   c   a   a   b   a   c   a   c   b   b   a   b   a   a   b   c
  Sub2:   c   c   b   b   a   c   a   c   c   a   c   b   c   b   c   c
  
 and these have been entered as the 2 variables SEQ (subject) and CODE
 in the dataset CODES:

                SEQ    CODE
                
                        1      c
                        1      a
                        1      a
                        1      b
                        ....
                        2      c
                        2      c
                        2      b
                        2      b
                        ....
 Then the macro call:

    %lags(data=codes, var=code, by=seq, outfreq=freq);

 produces the lags dataset _lags_ for NLAG=1 that looks like this:

   SEQ    CODE    _LAG0    _LAG1
   
    1      c        c         
           a        a        c
           a        a        a
           b        b        a
           a        a        b
           ....
   
    2      c        c         
           c        c        c
           b        b        c
           b        b        b
           a        a        b
            ....

 The output 2-way frequency table (outfreq=freq) looks liks this:

   SEQ    _LAG0    _LAG1    COUNT
   
    1       a        a        2
            b        a        3
            c        a        2
            a        b        3
            b        b        1
            c        b        1
            a        c        2
            b        c        1
            c        c        0
   
    2       a        a        0
            b        a        0
            c        a        3
            a        b        1
            b        b        1
            c        b        2
            a        c        2
            b        c        3
            c        c        3

 */

%macro lags(data=_last_, 
        outlag=_lags_,   /* output dataset containing lag variables */
        outfreq=,        /* output dataset containing nlag-way 
frequencies */
        var=,            /* variable containing codes for events */
        varfmt=,         /* format for event variable */
        nlag=1,          /* number of lags to compute in the outlag 
dataset */
        by=,             /* by variable: separate lags for each */
        freqopt=norow nocol nopercent chisq,
        complete=ALL,    /* Should the contingency table be made 
complete?  */
        prefix=_lag);    /* prefix for names of lag variables */
        
%if &nlag = %str() %then %do;
        %put NLAG= must be specified;
        %goto done;
        %end;

%let abort=0;
%let complete = %upcase(&complete);
%if %upcase(&data) = _LAST_  %then %let data=&syslast;

%if %bquote(&by) ^=  %then %do;
   %let _byvars=;
   %let _bylast=;
   %let n=1;
   %let token=%qupcase(%qscan(&by,&n,%str( )));

   %do %while(&token^=);
      %if %index(&token,-) %then
         %put WARNING: Abbreviated BY list &token.  Specify by= 
individually.;
      %else %do;
         %let token=%unquote(&token);
         %let _byvars=&_byvars &token;
         %let _bylast=&token;
      %end;
      %let n=%eval(&n+1);
      %let token=%qupcase(%scan(&by,&n,%str( )));
   %end;
%let nby = %eval(&n-1);

%* put found &nby by variable(s) : &_byvars;

        proc sort data=&data;
                by &by;

%end;
        
%*-- Find type/missing value code for &var ;
proc contents data=&data out=_work_ noprint;
%if &syserr > 4 %then %let abort=1; %if &abort %then %goto DONE;

options nonotes;
data _null_;
        set _work_(keep=name type);
        *-- set a missing macro variable for char or numeric variables;
        if name = upcase("&var") then do;
                if type = 2 then miss="' '";
                else miss='.';
                call symput('missing', miss);
                call symput('type', left(put(type,1.0)));
                put type=;
        end;

data &outlag;
        set &data;
        %if %bquote(&by) ^=  %then %do;
                by &by;
                drop cnt;
        %end;
        %do i= &nlag %to 1 %by -1;
                &&prefix.&i = lag&i( &var);
                %end;
   &prefix.0 = &var;

        %if %bquote(&by) ^=  %then %do;
                if first.&_bylast then cnt=0;
                cnt+1;
                %do i = 1 %to &nlag;
                        if cnt <= &i then &&prefix.&i = &missing ;
                        %end;           
        %end;
%if &syserr > 4 %then %let abort=1; %if &abort %then %goto DONE;
        

*-- Frequencies for each lag vs lag0;
proc freq data=&outlag;
        %if &varfmt ^= %str() %then %do;
        format
        %do i = 0 %to &nlag;
                &&prefix.&i
                %end;  &varfmt %str(;);
        %end;
        %do i = 1 %to &nlag;
                tables &&prefix.&i * &prefix.0   / &freqopt;
                %end;           
        %if %bquote(&by) ^=  %then %do;
                by &by;
                %end;
        run;
        
*-- Output nlag-way data set containg lag frequencies;
%if &outfreq ^= %str() %then %do;

        %let sparse=;
        %if &complete ^= NO %then %let sparse = sparse;
        
        proc freq data=&outlag;
                *-- generate a tables lagn * lagn-1 * ... lag 0 statement;
                tables  
                %do i= &nlag %to 1 %by -1;
                        &&prefix.&i   *
                        %end;
                        &prefix.0 / noprint &sparse out=&outfreq;
                %if %bquote(&by) ^=  %then %do;
                        by &by;
                        %end;
        
        %*-- delete any missing lags;
        data &outfreq;
                set &outfreq(drop=percent) ;
                %do i= &nlag %to 1 %by -1; 
                        if &&prefix.&i ^= &missing ;
                         %end;
                         
        %*-- Resort to put BY variable(s) first;
        %if %bquote(&by) ^=  %then %do;
        proc sort data=&outfreq;
                by &by 
                        %do i= &nlag %to 0 %by -1; &&prefix.&i 
                         %end;
                         %str(;);
        %end;
                                
%end;

%done:
%if &abort %then %put ERROR: The LAGS macro ended abnormally.;
options notes;
%mend;

/*-------------------------------------------------------------------*
  *    Name: points.sas                                               *
  *   Title: Create an Annotate dataset to draw points in a plot      *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/points.html             *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly         <friendly@yorku.ca>            *
  * Created:  12 Nov 1998 10:26:09                                    *
  * Revised:  18 Nov 1998 08:37:44                                    *
  * Version:  1.1                                                     *
  *  - Added BY= parameter, IN=                                       *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/
 /* Description:

 The POINTS macro creates an annotate data set to draw point symbols
 in a 2D or 3D scatterplot.  This is useful when you need to plot two
 variables (e.g, observed, predicted) against a common X, with separate
 curves for the levels of a class variable.  In PROC GPLOT, for 
example,
 you cannot do

    proc gplot;
       plot (obs fit) * X = group;

 However, you can add the OBS points to a plot of fit*X:

   %points(x=X, y=obs);
    proc gplot;
       plot fit * X = group / anno=_pts_;

Usage:

 The POINTS macro is called with keyword parameters.  The X= and Y=
 parameters are required.  For a plot with PROC G3D, you must also
 give the Z= variable.
 The arguments may be listed within parentheses in any order, separated
 by commas. 
 
Parameters:

* DATA=       The name of the input data set [Default: DATA=_LAST_]

* X=          The name of the X variable for the scatterplot

* Y=          The name of the Y variable for the scatterplot

* Z=          The name of the Z variable for a 3D scatterplot

* BY=         The name(s) of any BY variable(s) to be used for multiple
              plots.

* CLASS=      The name of a class variable, to be used with PROC GPLOT
              in the PLOT statement for multiple curves, in the form
                                  
                                     plot Y * X = CLASS;

* SYS=        Specifies the Annotate XSYS & YSYS value [Default: SYS=2]

* COLOR=      Point color(s): the name of a dataset character variable,
              or an expression which evaluates to a SAS/GRAPH color, or
              string constant enclosed in quotes. [Default: 
COLOR='BLACK']

* SYMBOL=     Point symbol(s): the name of a dataset character 
variable,
              or an expression which evaluates to a SAS/GRAPH color, or
              string constant enclosed in quotes.  [Default: 
SYMBOL='DOT']

* SIZE=       The size of the symbol (in GUNIT units).  If not 
specified,
              the global graphics option HTEXT value is used.

* FONT=       Font for symbol(s): the name of a dataset character 
variable,
              or an expression which evaluates to a SAS/GRAPH color, or
              string constant enclosed in quotes.  Use for special
                                  symbols, e.g., FONT='MARKER'.  If not 
specified, the
                                  standard symbol font is used.

* SUBSET=     An expression (which may involve any dataset variables) 
to
              select points.  A point will be plotted if the expression 
                                  evaluates to non-zero for the current 
observation.
              [Default: SUBSET=1]

* COPY=       The names of any variables to be copied to output dataset

* IN=         The name of an optional input annotate data set.  If
              specified, the IN= data set is concatenated with the
                                  OUT= data set.

* OUT=        Name of the annotate data set produced. [Default: 
OUT=_PTS_]
                

 */

%macro points(
   data=_LAST_,
   x=,             /* X variable for scatterplot       */
   y=,             /* Y variable for scatterplot       */
   z=,             /* Z variable for G3D (optional)    */
   by=,            /* BY variable(s) (mult plots)      */
   class=,         /* CLASS variable (mult curves)     */
   sys=2,          /* XSYS & YSYS value                */
   color='BLACK',  /* symbol color (quote if const)    */
   symbol='dot',   /* plot symbol                      */
   size=,          /* size of symbol                   */
   font=,          /* font for symbol                  */
   subset=1,       /* expression to select points      */
   copy=,          /* vars copied to output dataset    */
   in=,            /* input annotate data set          */
   out=_pts_       /* annotate data set produced       */
   );

options nonotes; 
%if %length(&by) or %length(&class) %then %do;
        proc sort data=&data;
        by &by &class;
        %end;
run;

options notes;
data &out;
   set &data;
        %if %length(&by) or %length(&class) %then %do;
                by &by &class;
                %end;
   keep x y function text
                %if %length(&size) %then  size ;
        color &by &class &copy xsys ysys ;
   length function $8 text $ 8 ;
   xsys = "&sys"; ysys = "&sys"; function='SYMBOL';
   x = &x;
   y = &y;
   %if &z ^= %str() %then %do;
          zsys = "&sys"; keep z zsys;
          z = &z;
       %end;
        %if %length(&size)   %then %str(size=&size;);
   color=&color;
        text=&symbol;
   %if &font ^= %str() %then %do;
      keep style;
      style = &font;
      %end;

   if (&subset);
run;
%if %length(&in) %then %do;
        data &out;
                set &in &out;
                %if %length(&by) %then %do;
                        by &by;
                        %end;
        %end;

%mend;

/*-------------------------------------------------------------------*
  *    Name: distplot.sas                                             *
  *   Title: Plots for discrete distributions                         *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/distplot.html           *
  *                                                                   *
  *  Hoaglin & Tukey, Checking the shape of discrete distributions.   *
  *   In Hoaglin, Mosteller & Tukey (Eds.), Exploring data tables,    *
  *   trends, and shapes, NY: Wiley, 1985.                            *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *
  * Created:  19 Mar 1991 08:48:26                                    *
  * Revised:   3 Nov 2000 10:09:20                                    *
  * Version:  1.2                                                     *
  *  1.1  Plot y * &count so label will not be required               *
  *       Allow for 0 frequencies                                     *
  *  1.2  Added indicated parameter change plots                      *
  *       Fixed bugs in ngebin and geometric                          *
  *       Fixed validvarname for V7+                                  *
  * Requires: %words %label %gskip                                    *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/

 /* Description:
 
 The DISTPLOT macro constructs plots of a discrete distribution
 designed to diagnose whether the data follows one of the standard
 distributions: the Poisson, Binomial, Negative Binomial, Geometric,
 or Log Series, specified by the DIST= parameter.  The usual
 (PLOT=DIST) plot is constructed so that the points lie along a
 straight line when the data follows that distribution.  An influence
 plot (PLOT=INFL) shows the influence of each observation on the
 choice of the distribution parameter(s).

Usage:

 The DISTPLOT macro is called with keyword parameters.
 You must specify the distribution to be fit (DIST=). and the
 COUNT= and FREQ= variables.
 The arguments may be listed within parentheses in any order, separated
 by commas. For example: 
 
        %distplot(data=queues, count=women, freq=queues, dist=binomial,
            parm=0.435);
 
Parameters:

* DATA=       The name of the input data set [Default: DATA=_LAST_]

* COUNT=      Basic count variable

* FREQ=       Number of occurrences of count

* LABEL=      Horizontal (count) label

* DIST=       Name of distribution, one of POISSON, BINOMIAL, 
              GEOMETRIC, LOGSERIES, or NEGBIN.

* PARM=       Trial value of the distribution parameter(s) to level the 
              plot.  For the Binomial distribution, PARM=p, the 
binomial
                                  probability of success; for the Poisson, 
PARM=lambda,
                                  the Poisson mean.  For the Geometric and 
Negative binomial,
                                  PARM=p

* Z=          Multiplier for error bars in the PLOT=DIST plot.
              [Default: Z=1.96]

* PLOT=       What to plot: DIST and/or INFL [Default: PLOT=DIST]

* HTEXT=      Height of text labels in the plots [Default: HTEXT=1.4]

* OUT=        The name of the output data set [Default: OUT=DISTPLOT]

* NAME=       Name of the graphics catalog entry [Default: 
NAME=DISTPLT]

 */
%macro distplot(
     data=_last_,       /* name of input data set                   */
     count=,            /* basic count variable                     */
     freq=,             /* number of occurrences of count           */
     label=,            /* Horizontal (count) label                 */
     dist=,             /* name of distribution                     */
     parm=,             /* trial value of parm(s) to level the plot */
     z=1.96,            /* multiplier for error bars                */
     plot=DIST,         /* What to plot: DIST and/or INFL           */
          htext=1.4,         /* Height of text labels                    
*/
          out=distplot,      /* name of the output data set              
*/
     name=distplt       /* graphics catalog entry                   */
          );
 
        %*-- Reset required global options;
        %if &sysver >= 7 %then %do;
                %local o1 o2;
                %let o1 = %sysfunc(getoption(notes));
                %let o2 = %sysfunc(getoption(validvarname,keyword));
                options nonotes validvarname=V6;
                %end;
        %else %do;
           options nonotes;
                %end;

%*if &label=%str() %then %let label=&count;
%let plot=%upcase(&plot);
%let dist=%upcase(&dist);
%if %length(&z)=0 %then %let z=0;

%*-- Determine if any parameters were passed;
%global parm1 parm2;
%let parm1=0;
%let parm2=0;
%let nparm = %words(&parm, root=parm);
%* put nparm= &nparm parm1=&parm1 parm2=&parm2;

proc means data=&data N sum sumwgt mean var noprint vardef=weight;
   var &count;
   weight &freq;
   output out=_sum_ sumwgt=N sum=sum mean=_mean_ var=_var_ max=_max_;

data &out;
   set &data nobs=_cells_;
   if _n_=1 then set _sum_(drop=_type_ _freq_);
        drop kf k;
   k = &count;
   nk= &freq;                     * n(k);
        kf= gamma(k+1);                * k!  ;
  
   *-- centered value n*(k), Hoaglin & Tukey, Eqn 9 ;
   p = nk / N;
   if nk >=2 then nkc = nk - .67 - .8*p;
             else nkc = exp(-1);

        %if &dist=POISSON %then %do;
                *-- if levelling the plot, subtract centering value;
                %if &nparm = 0
                                %then %str( level =  0; );
                                %else %str( level = &parm1 - k * log( &parm1 ); 
);
           y =  log(kf * nk / N) + level ;
           yc=  log(kf * nkc/ N) + level ;
                parm = _mean_;       *-- estimate of lambda;
                call symput('eparm', left(put(parm, 6.3)));
           phat = exp(-_mean_) * _mean_**&count / kf;
                if nk<=1 then do;
                        ylo = log(kf*nkc/N) - 2.677 + level;
                        yhi = log(kf*nkc/N) + 2.717 - 2.3/N + level;
                        h = (yhi-ylo)/2;
                        end;
                %end;
        %else %if &dist=BINOMIAL %then %do;
                %if &nparm = 0
                                %then %str( level =  0; );
                                %else %do;
                                        level = -(_max_ * log (1-&parm1) + 
k*log(&parm1/(1-&parm1)));
                                        %end;
                bnk = gamma(_max_+1) / ( gamma(k+1)*gamma(_max_-k+1) );
                y =  log(nk / (N * bnk)) + level ;
                yc=  log(nkc/ (N * bnk)) + level ;

                parm = _mean_ / _max_;     *-- estimate of p;
                call symput('eparm', left(put(parm, 6.3)));
                phat = bnk * (parm**k) * parm**(_max_-k);

                if nk<=1 then do;
                        ylo = log(nkc/(N * bnk)) - 2.677 + level;
                        yhi = log(nkc/(N * bnk)) + 2.717 - 2.3/N + level;
                        h = (yhi-ylo)/2;
                        end;
                %end;
        %else %if &dist=NEGBIN %then %do;
                %if &nparm=0 %then %do;
                        parmn = _mean_**2 / (_var_-_mean_);     *-- n, moment 
est;
                        parm  = _mean_/_var_;                   *-- p, moment 
est;
                        level = 0;
                        %end;
                %else %if &nparm=1 %then %do;
                        parmn = &parm1;
                        parm = _mean_/_var_;                    *-- p, moment 
est;
                        level = -(parmn * log(parm) + k*log(1-parm));
                        %end;
                %else %do;
                        parmn = &parm1;
                        parm = &parm2;
                        level = -(parmn * log(parm) + k*log(1-parm));
                        %end;
*               parm  = (_var_/_mean_**2) -1;           *-- p, moment est;
                bnk = gamma(parmn+k) / (gamma(k+1) * gamma(parmn));
                phat = bnk * (parm**parmn) * (1-parm)**k;
                y =  log(nk / (N * bnk)) + level ;
                yc=  log(nkc/ (N * bnk)) + level ;

                if nk<=1 then do;
                        ylo = log(nkc/(N * bnk)) - 2.677 + level;
                        yhi = log(nkc/(N * bnk)) + 2.717 - 2.3/N + level;
                        h = (yhi-ylo)/2;
                        end;
                %end;
        %else %if &dist=GEOMETRIC %then %do;
                %if &nparm = 0
                        %then %str( level =  0; );
                        %else %str( level = -(log(&parm1) + k*log(1-
&parm1)););
                y =  log(nk / N ) + level ;
                yc=  log(nkc/ N ) + level ;

                parm = 1/_mean_;
                call symput('eparm', left(put(parm, 6.3)));
                phat = parm*(1-parm)**(k-1);

                if nk<=1 then do;
                        ylo = log(nkc/ N ) - 2.677 + level;
                        yhi = log(nkc/ N ) + 2.717 - 2.3/N + level;
                        h = (yhi-ylo)/2;
                        end;
                %end;
        %else %if &dist=LOGSERIES %then %do;
                %if &nparm = 0
                                %then %str( level =  0; );
                y =  log(k * nk / N ) + level ;
                yc=  log(k * nkc/ N ) + level ;

                *Birch estimator;
                parm = 1 - (1 / (1 + ((5/3)- log(mean)/16)*(mean-
1)+2)*log(mean));
                call symput('eparm', left(put(parm, 6.3)));
                if nk<=1 then do;
                        ylo = log(k * nkc/ N ) - 2.677 + level;
                        yhi = log(k * nkc/ N ) + 2.717 - 2.3/N + level;
                        h = (yhi-ylo)/2;
                        end;
                %end;
 
   *-- half-length of confidence interval for log(eta-k) [Eqn 10];
        if nk>1 then do;
                h = &z * sqrt( (1-p) / ( nk-((.47+.25*p)*sqrt(nk)) ) );
                ylo = yc - h;
                yhi = yc + h;
                end;

        *-- Estimated prob and expected frequency;
   exp  = N * phat;

        *-- Leverage and apparent parameter values (p.402);
/*
   %if &parm1 = 0
                %then %str(lev = (&count / _mean_) - 1;);
                %else %str(lev = (&count / &parm1) - 1;);
        hc = sign(lev) * lev / h;
        vc = sign(lev) * (log(nkc) - log(exp)) / h;
        slope = vc / hc;   *-- (lambda - lambda0);
        label y = 'Count metameter'
                hc = 'Scaled Leverage'
                vc = 'Relative parameter change'
                slope = 'Parameter change';
*/

proc print data=&out;
   id &count;
*   var nk y nkc yc h ylo yhi lev hc vc;
   sum nk nkc;
*   format y yc h yhi ylo 6.3 lev hc vc 6.2;

/* 
*-- Calculate goodness of fit chisquare;
data fit;
   set &out;
   chisq= (nk - exp)**2 / exp;
proc print data=fit;
   id &count;
   var nk p phat exp chisq;
   sum nk exp chisq;
*/

*-- Find slope, intercept of line;
proc reg data=&out outest=_parms_ noprint;
   model y =  &count;
data _stats_;        *-- Annotate data set to label the plot;
   set _parms_ (keep=&count intercep);
   set _sum_   (keep=_mean_);
        b = &count;
        a = intercep;
   drop &count intercep ek a b;
   length text $30 function $8;
   xsys='1'; ysys='1';
   x=15;
        *-- set label y location based on slope;
        if &count > 0
                then y=96;
                else y=16; 
   function = 'LABEL';
   size = &htext;
   color = 'RED';
   position='3'; text ='slope(b) = '||left(put(b,f6.3)); output;
   position='6'; text ='intercept= '||left(put(a,f6.3)); output;

   y=y-6;
        %if &dist=POISSON %then %do;
                ek = exp(b - &parm1);
                position='6'; text ="lambda:  mean = &eparm"; output;
                position='9'; text ='       exp(b) = '||put(ek,5.3); 
output;
        %end;
        %else %if &dist=BINOMIAL %then %do;
                %if &parm1>0 %then 
                        %str( b = b - log (&parm1/(1-&parm1)); );
                ek = exp(b)/(1+exp(b));
                position='6'; text ="p:      mean/n = &eparm"; output;
                position='9'; text ='   e(b)/1+e(b) = '||put(ek,5.3); 
output;
        %end;
        %else %if &dist=NEGBIN %then %do;
                %if &parm1>0 %then 
                        %str( b = b - log (1-&parm1); );
                ek = 1 - exp(b);
                en = a / log(ek);
                position='6'; text ='n:  a/log(p) = '||put(en,5.3); output; 
                position='9'; text ='p:    1-e(b) = '||put(ek,5.3); output;
        %end;
        %else %if &dist=GEOMETRIC %then %do;
                %if &parm1>0 %then 
                        %str( b = b - log (1-&parm1); );
                ek = 1 - exp(b);
                en = exp(a);
                position='3'; text ="p:   1/mean = &eparm";        output; 
                position='6'; text ='p:   1-e(b) = '||put(ek,5.3); output;
*               y = y-4;
                position='9'; text ='p:   e(a)   = '||put(en,5.3); output; 
        %end;
        %else %if &dist=LOGSERIES %then %do;
                %if &parm1>0 %then 
                        %str( b = b - log (&parm1); );
                ek = exp(b);
/*              position='6'; text ='p:   e(a)   = '||put(en,5.3); output;   
*/
                position='9'; text ='p:   1-e(b) = '||put(ek,5.3); output;
        %end;

%let order=;
%if &z > 0 %then %do;
data _conf_;
   set &out;
   drop yc;
   xsys='2'; ysys='2';
   x = &count;    line=33;
   y = yc;   function='MOVE  '; output;
   text='+'; function='SYMBOL'; output;
   y = yhi;  function='DRAW  '; output;
   y = yc;   function='MOVE  '; output;
   y = ylo;  function='DRAW  '; output;
data _stats_;
   set _stats_ _conf_;

*-- find range of confidence limits to set y axis extrema;
proc means data=_conf_ noprint;
   var y;
   output out=_range_ min=min max=max;
data _null_;
   set _range_;
        inc = 1;
        if (max-min)>10 then inc=2;
   min = inc * floor(min/inc);
   max = inc * ceil(max/inc);
   call symput('MIN', left(put(min,3.)));
   call symput('MAX', left(put(max,3.)));
   call symput('INC', left(put(inc,3.)));
run;
%let order = order=(&min to &max by &inc);
%end; /* %if &z */

*-- Poissonness-style distribution plot;
proc gplot data=&out;
   plot y * &count / anno=_stats_ vaxis=axis1 haxis=axis2 hminor=0 
vminor=1
                name="&name"
                des="Distribution plot of &count";
   symbol v=- h=2 i=rl c=black;
   axis1 &order
         label=(a=90 r=0
          'Count metameter')
         value=(h=&htext);
   axis2 offset=(3) minor=none
        %if %length(&label) %then %do;
         label=("k  (&label)")
                        %end;
         value=(h=&htext);
        run;

*-- Indicated parameter change (infl) plot;
        %if %index(&plot,INFL) %then %do;
        %label(data=&out, y=vc,    x=hc, text=&count, out=_anno1_, 
size=);
        *-- Draw lines from origin to each point;
        data _lines_;
                set &out(keep=hc vc);
                xsys='2'; ysys ='2';
                x=0;  y=0;  function='move    '; output;
                x=hc; y=vc; function='draw    '; output;
        data _anno1_;
                set _anno1_ _lines_;

        %label(data=&out, y=slope, x=hc, text=left(put(&count,2.)),
                out=anno2, size=);
        %gskip;
        symbol v=- h=2 color=black i=none;
        axis1 label=(a=90);

        proc gplot data=&out;
                plot vc * hc  /
                        hzero vref=0 lvref=33 anno=_anno1_ vaxis=axis1 
hminor=1 vminor=1
                        name="&name"
                        des="Parameter change plot of &count";
                run;
        %gskip;
        proc gplot data=&out;
                bubble slope * hc =hc / 
                        vref=0 lvref=33 anno=anno2 vaxis=axis1  hminor=1 
vminor=1
                        bsize=40 bcolor=red bscale=radius
                        name="&name"
                        des="Parameter change plot of &count";

        run; quit;
%end;
*-- Clean up datasets no longer needed;
proc datasets lib=work memtype=data nolist;
   delete _sum_ _stats_ _conf_ _parms_;
        run; quit;

        %*-- Restore global options;
        %if &sysver >= 7 %then %do;
                options &o1 &o2;
                %end;
        %else %do;
           options notes;
                %end;

%mend;

/*-------------------------------------------------------------------*
  *    Name: gskip.sas                                                *
  *   Title: Device-independent macro for multiple plots              *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/gskip.html              *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *
  * Created: 12 Jul 96 16:43                                          *
  * Revised: 02 Jan 99 12:41                                          *
  * Version: 1.0                                                      *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/
 /* Description:
 
 The GSKIP macro is designed to handle difficulties in producing
 multiple plots in one SAS job.  For EPS, GIF, CGM and WMF drivers,
 it assigns a new output filename for the next plot.  For FOILS
 (on continuous forms) it skips the normally blank non-foil
 separator page.  Otherwise, it has no effect.

Usage:

 The GSKIP macro has one optional positional parameter.  It relies on 
global
 macro parameters, DISPLAY, DEVTYP, FIG, GSASFILE, and GSASDIR.
 These parameters are normally initialized either in the 
F<AUTOEXEC.SAS>
 file, or in device-specific macros.  For example, for normal graphic
 output to the Graph Window, assign DISPLAY and DEVTYP as
 
   %let devtyp=SCREEN;
        %let displa=ON;

 For EPS file output,
 
   %let devtyp=EPS;
        %let fig=1;
        %let gsasfile=myfig;
 
 GSKIP is normally used after each graphic procedure or macro to 
advance
 the FIG counter and open a new graphic output file.  For example,
 
   proc gplot;
                plot y * x;
        %gskip();

Parameters:

* INC       The value by which the FIG counter is incremented, normally
            1 (the default).  Use the INC parameter after a plot with
                                a BY statement.
 
Global Parameters:

* DISPLAY       String value, ON or OFF, usually set by the GDISPLA macro.
            The GISKP macro takes no action if DISPLAY=OFF.

* DEVTYP    String value, the type of graphic device driver.  The
            values EPS, GIF, CGM and WMF cause FIG= to be incremented
                                and a new output filename assigned.  If 
DEVTYP=FOILS,
                                a blank graphic page is produced.  All others 
are ignored.

* FIG       A numeric value, the number of the current figure.

* GSASFILE  String value, the basename of the graphic output file(s).
            The output files are named according to the macro 
expression
                                
               %scan(&gsasfile,1,.)&fig..%lowcase(&devtyp)

            e.g.,  myfile1.eps, myfile2.eps, ....
                                
* GSASDIR   String value, the output directory in which the graphic
            files are written.  If not specified, output goes to the
                                current directory.
 
 */

%global fig gsasfile gsasdir display devtyp;
%macro gskip(inc);
/*  quit; run; */
        %if &DISPLAY = OFF %then %goto done;    %*-- Only if we are 
displaying;
        %if %upcase(&devtyp)=EPS or %upcase(&devtyp)=GIF
         or %upcase(&devtyp)=CGM or %upcase(&devtyp)=WMF 
                %then %do;
        %if %length(&inc)=0 %then %let inc=1;
   %if %defined(gsasdir)=0 %then %let gsasdir=;
                %let fig = %eval(&fig + &inc);
                %let gsas = %scan(&gsasfile,1,.)&fig..%lowcase(&devtyp);
                %put GSKIP: gsasfile now: "&gsasdir.&gsas";
                filename gsas&fig  "&gsasdir.&gsas";
                goptions gsfname=gsas&fig;
        %end;
        
/* Skip the blank page in Zeta foils */
   %if &devtyp=FOILS %then %do;
   Proc Gslide;
      note j=c 'Page skip for FOILS';
   run;
   %end;
%done:;
%mend gskip;

/*-------------------------------------------------------------------*
  *    Name: logodds.sas                                              *
  *   Title: Plot empirical log-odds for logistic regression          *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/logodds.html            *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *
  * Created:  6 Nov 1997 08:45:22                                     *
  * Revised:  23 Jun 2000 10:46:42                                    *
  * Version: 1.0                                                      *
  *  Updated for V7+ (VALIDVARNAME)                                   *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/
 /* Description:
 
 For a binary response variable, Y, taking values 0 or 1, and a
 continuous independent variable, X, the LOGODDS macro groups the
 X variable into some number of ordered, non-overlapping intervals.
 It plots the empirical log-odds of Y=1 (and/or Pr{Y=1}) against
 X for each interval of X, together with the fitted linear logistic
 relation, an optional smoothed curve (using the LOWESS macro),
 and the observed binary responses.
 

Usage:

 The input data to be plotted must be in case form.
 The LOGODDS macro is called with keyword parameters.  The X= and Y=
 variables are required.
 The arguments may be listed within parentheses in any order, separated
 by commas. For example: 
 
        %include catdata(icu);
        %logodds(data=icu, x=age, y=died, smooth=0.25, ncat=16,
                options=order=data);
 
Parameters:

* X=          Name of the continuous independent variable

* Y=          Name of the binary response variable

* EVENT=      Value of Y for the event of interest [Default: EVENT=1]

* DATA=       The name of the input data set [Default: DATA=_LAST_]

* OPTIONS=    Options for PROC LOGISTIC, for example, 
OPTIONS=DESCENDING.

* NCAT=       Number of categories of the X variable.
              For example, if deciles of X are desired, use NCAT=10. 
                                  [Default: NCAT=10]

* PLOT=       Scale(s) for the response. PLOT=LOGIT gives a plot on the
              logit scale, PLOT=PROB on the probability scale.
              [Default: PLOT=LOGIT PROB]

* SMOOTH=     Smoothing parameter for a lowess smooth, in the interval
              (0-1).  No smooth curve is produced unless a SMOOTH=
                                  value is specified.  

* SHOW=       Specifies whether to plot the binary observations.
              [Default: SHOW=OBS]

* OBS=        Specifies how to display the binary observations.  If
              OBS=STACK, the observations are plotted in vertical
                                  columns at the top (Y=1) or bottom (Y=0) of 
the plot.
                                  If OBS=JITTER a small random quantity is 
added (Y=0)
                                  or subtracted (Y=1) to the Y value.  
[Default: OBS=STACK]

* NAME=       The name of the graph in the graphic catalog [Default: 
NAME=LOGODDS]

* GOUT=       The name of the graphic catalog [Default: GOUT=GSEG]
                
 */
 
%macro logodds(
        x=,               /* Name of the continuous independent variable 
*/
        y=,               /* Name of the binary response variable        
*/
        event=1,          /* Value of Y for the event of interest        
*/
        data=_last_,
        options=,         /* Options for PROC LOGISTIC                   
*/
        ncat=10,          /* Number of categories of the X variable      
*/
        plot=logit prob,  /* Scale(s) for the response                   
*/
        smooth=,          /* Smoothing parameter for a lowess smooth     
*/
        hsym=1.5,
        show=obs,         /* How and whether to plot the binary obs.     
*/
        obs=stack,
        name=logodds,
        gout=gseg
        );

%let plot=%upcase(&plot);
%let show=%upcase(&show);

        %*-- Reset required global options;
        %if &sysver >= 7 %then %do;
                %local o1 o2;
                %let o1 = %sysfunc(getoption(notes));
                %let o2 = %sysfunc(getoption(validvarname,keyword));
                options nonotes validvarname=upcase;
                %end;
        %else %do;
           options nonotes;
                %end;

%let abort=0;
%if &x=%str() or &y=%str() %then %do;
   %put ERROR: The X= and Y= variables must be specified;
        %let abort=1;
   %goto DONE;
   %end;
        

proc logistic /*noprint*/ data=&data &options;
   model  &y = &x ;
   output out=results p=predict l=lower u=upper xbeta=plogit 
stdxbeta=selogit;

data results;
        set results;
        uplogit = plogit + selogit;
        lologit = plogit - selogit;
        logit = log(((&y=&event)+.25)/((1-(&y=&event))+.25));
proc sort;
        by &x;

proc sort data=&data;
   by &x &y;
%if &syserr > 4 %then %let abort=1; %if &abort %then %goto DONE;

proc rank data=&data groups=&ncat out=_grouped;
        var &x;
        ranks _gp_;

proc summary data=_grouped nway;
        class _gp_;
        var &x &y;
        output out=_groups_ mean(&x)=xmean sum(&y)=ysum min(&x)=xmin;

data _logits_;
        set _groups_(rename=(_freq_=n) drop=_type_) end=eof;
        label xmean="Mean &x"
              logit="Log Odds &y=&event";
        p = (ysum+.5) / (n+.5);
        logit = log( (ysum+.5) / (n-ysum+.5)  );
        nobs + n;
        if eof then call symput('nobs', put(nobs,8.));
run;
proc print;
        id _gp_;
        var xmin ysum n logit p;

data _pts_;
        set _logits_;
        xsys = '2'; ysys='2';
        x = xmean; y=logit; function='symbol'; size=2; text='square';

%*-- Mark the boundaries between adjacent groups;
data _marks_;
        set _logits_;
        xsys = '2'; ysys = '1';
        color = 'red'; when='A';
        x = xmin; y=0;    function='MOVE    '; output;
        x = xmin; y=2.25; function='DRAW    '; output;

%if %index(&show,OBS) %then %do;
%let otype = %upcase(%scan(&obs,1));
%let oparm = %scan(&obs,2,%str( ));
%let osym  = %scan(&obs,3,%str( ));
%if %length(&osym)=0 %then %let osym=dot;
data _obs_;
        set &data(keep=&x &y);
        by &x &y;
        drop i;
        length text $8;
        if first.&y then i=0;
        xsys = '2'; ysys='1';
        x = &x;
        %if &otype=STACK %then %do;
                %if %length(&oparm)=0 %then %let oparm=2;
                y=100*&y + (3+(&oparm)*i)*sign(.5-&y);
                %end;
        %else %do; /* &otype=JITTER */
                %if %length(&oparm)=0 %then %let oparm=10;
                y=100*&y + (3+(&oparm)*uniform(0))*sign(.5-&y);
                %end;
        function='symbol';
        size=1.3; text="&osym"; color='green  ';
        i+1;
%end;

data _pts_;
        set _pts_
                 %if %index(&show,OBS) %then _obs_ ;
                 _marks_;


%if %length(&smooth)>0 %then %do;
%lowess(data=results, x=&x, y=logit, gplot=NO, pplot=NO, 
outanno=_smooth_,
        silent=YES, robust=0, iter=1, f=&smooth, line=22);

data _pts_;
        set _pts_ _smooth_;
%end;

%if %index(&PLOT,LOGIT) %then %do;
proc gplot data=results gout=&gout;
   plot
        plogit  * &x = 1
        uplogit * &x = 2
        lologit * &x = 2
        / frame overlay vaxis=axis1 anno=_pts_ hminor=1 vminor=1
                  name="&name"
                  des="Empirical log-odds plot of &data";
   axis1 label=(a=90) offset=(3pct);
   symbol1 v=none   i=join l=1  w=3 c=blue;
   symbol2 v=none   i=join l=20 w=2 c=blue;
        label  plogit="Log Odds &y=1";
run; quit;
%gskip;
%end;

%if %index(&PLOT,PROB) %then %do;
data _pts_;
        set _logits_;
        xsys = '2'; ysys='2';
        x = xmean; y=p; function='symbol'; size=2; text='square';

data _pts_;
        set _pts_
                 %if %index(&show,OBS) %then _obs_ ;
                 _marks_;

%if %length(&smooth)>0 %then %do;
%lowess(data=&data, x=&x, y=&y, gplot=NO, pplot=NO, outanno=_smooth_,
        silent=YES, robust=0, iter=1, f=&smooth, line=22);

data _pts_;
        set _pts_ _smooth_;
%end;

proc gplot data=results gout=&gout;
   plot 
        predict * &x = 1
        upper * &x = 2
        lower * &x = 2
        / frame overlay vaxis=axis1 anno=_pts_ hminor=1 vminor=1
                  name="&name"
                  des="Empirical probability plot of &data";
                 
   axis1 label=(a=90) offset=(3pct) order=(0 to 1 by .2);
   symbol1 v=none   i=join l=1  w=3 c=blue;
   symbol2 v=none   i=join l=20 w=2 c=blue;
        label predict = "Probability &y=&event";
        format &y 4.1;
        run; quit;
        goptions reset=symbol;
%end;

%done:
        %*-- Restore global options;
        %if &sysver >= 7 %then %do;
                options &o1 &o2;
                %end;
        %else %do;
           options notes;
                %end;

%if &abort %then %put ERROR: The LOGODDS macro ended abnormally.;
%mend;


/*-------------------------------------------------------------------*
 *    Name: poisplot.sas                                             *
 *   Title: Poissonness plot for discrete distributions              *
 *     Doc: http://www.math.yorku.ca/SCS/vcd/poisplot.html           *
 *     Ref:                                                          *
 *  Hoaglin & Tukey, Checking the shape of discrete distributions.   *
 *   In Hoaglin, Mosteller & Tukey (Eds.), Exploring data tables,    *
 *   trends, and shapes, NY: Wiley, 1985.                            *
 *-------------------------------------------------------------------*
 *  Author:  Michael Friendly            <friendly@yorku.ca>         *
 * Created:  19 Mar 1991 08:48:26                                    *
 * Revised:   9 Nov 2000 11:24:23                                    *
 * Version:  1.3                                                     *
 *  1.1  Plot y * &count so label will not be required               *
 *       Allow for 0 frequencies                                     *
 *  1.2  Added indicated parameter change plots                      *
 *  1.3  Fixed validvarname for V7+                                  *
 *                                                                   *
 *  From ``Visualizing Categorical Data'', Michael Friendly (2000)   *         
 *-------------------------------------------------------------------*/
 /* Description:
 
 The POISPLOT macro constructs a ``Poissonness plot'' for determining
 if discrete data follows the Poisson distribution.  The plot has a
 linear relation between the count metameter n(k) and the basic
 count, k, when the distribution is Poisson.  An influence
 plot displays the effect of each observed frequency on the choice of
 the Poisson parameter, lambda.
 
Usage:

 The POISPLOT macro is called with keyword parameters.  The COUNT=
 and FREQ= parameters are required.  
 The arguments may be listed within parentheses in any order, separated
 by commas. For example: 
 
        data horskick;
                input deaths corpsyrs;
                label deaths='Number of Deaths'
                        corpsyrs='Number of Corps-Years';
        cards;
                        0    109
                        1     65
                        2     22
                        3      3
                        4      1
        ;
        %poisplot(count=Deaths,freq=corpsyrs, plot=dist);
 
Parameters:

* DATA=       The name of the input data set [Default: DATA=_LAST_]

* COUNT=      The name of the basic count variable

* FREQ=       The name of the variable giving the number of occurrences
              of COUNT

* LABEL=      Label for the horizontal (COUNT=) variable.  If not 
specified
              the variable label for the COUNT= variable in the input
                                  data set is used.

* LAMBDA=     Trial value  of the Poisson parameter lambda to level the 
plot.
              If LAMBDA=0 (the default) the plot is not levelled.

* Z=          Multiplier for error bars [Default: Z=1.96]

* PLOT=       What to plot: DIST and/or INFL [Default: PLOT=DIST INFL]

* HTEXT=      Height of text labels [Default: HTEXT=1.4]

* OUT=        The name of the output data set [Default: OUT=POISPLOT]

* NAME=       Name of the graphics catalog entry [Default: 
NAME=POISPLT]
                

*/
 
%macro poisplot(
     data=_last_,
     count=,            /* basic count variable                     */
     freq=,             /* number of occurrences of count           */
     label=,            /* Horizontal (count) label                 */
     lambda=0,          /* trial value of lambda to level the plot  */
     z=1.96,            /* multiplier for error bars                */
          plot=DIST INFL,    /* What to plot: DIST and/or INFL           
*/
          htext=1.4,
          out=poisplot,
          name=poisplt
          );
 
        %*-- Reset required global options;
        %if &sysver >= 7 %then %do;
                %local o1 o2;
                %let o1 = %sysfunc(getoption(notes));
                %let o2 = %sysfunc(getoption(validvarname,keyword));
                options nonotes validvarname=V6;
                %end;
        %else %do;
           options nonotes;
                %end;

%let abort=0;
%if %length(&count)=0 | %length(&freq)=0
   %then %do;
      %put ERROR: The COUNT= and FREQ= variables must be specified;
      %let abort=1;
      %goto DONE;
   %end;

%*if &label=%str() %then %let label=&count;
%let plot=%upcase(&plot);
%if %length(&z)=0 %then %let z=0;

proc means data=&data N sum sumwgt mean var noprint;
   var &count;
   weight &freq;
   output out=sum sumwgt=N sum=sum mean=mean;

data &out;
   set &data;
   if _n_=1 then set sum(drop=_type_ _freq_);
        drop kf k;
   k = &count;
   nk= &freq;                     * n(k);
   kf= gamma(k+1);                * k!  ;
 
   *-- if levelling the plot, subtract centering value;
   %if &lambda = 0
       %then %str( level =  0; );
       %else %str( level = &lambda - k * log( &lambda ); );
 
   y =  log(kf * nk / N) + level ;    * poisson metameter;
 
   *-- centered value n*(k), Hoaglin & Tukey, Eqn 9 ;
   p = nk / N;
   if nk >=2 then nkc = nk - .67 - .8*p;
             else nkc = exp(-1);
*       if nk > 0 then;
           yc=  log(kf * nkc/ N) + level ;
 
   *-- half-length of confidence interval for log(eta-k) [Eqn 10];
        if nk<=1 then do;
                ylo = log(kf*nkc/N) - 2.677 + level;
                yhi = log(kf*nkc/N) + 2.717 - 2.3/N + level;
                h = (yhi-ylo)/2;
                end;
        else do;
                h = &z * sqrt( (1-p) / ( nk-((.47+.25*p)*sqrt(nk)) ) );
                ylo = yc - h;
                yhi = yc + h;
                end;

        *-- Estimated prob and expected frequency;
   phat = exp(-mean) * mean**&count / kf;
   exp  = N * phat;

        *-- Leverage and apparent parameter values (p.402);
   %if &lambda = 0
                %then %str(lev = (&count / mean) - 1;);
                %else %str(lev = (&count / &lambda) - 1;);
        hc = sign(lev) * lev / h;
        vc = sign(lev) * (log(nkc) - log(exp)) / h;
        slope = vc / hc;   *-- (lambda - lambda0);
        label y = 'Count metameter'
                hc = 'Scaled Leverage'
                vc = 'Relative metameter change'
                slope = 'Parameter change';

proc print data=&out;
   id &count;
   var nk y nkc yc h ylo yhi lev hc vc;
   sum nk nkc;
   format y yc h yhi ylo 6.3 lev hc vc 6.2;
 
*-- Calculate goodness of fit chisquare;
data fit;
   set &out;
   chisq= (nk - exp)**2 / exp;
proc print data=fit;
   id &count;
   var nk p phat exp chisq;
   sum nk exp chisq;

*-- Find slope, intercept of line;
proc reg data=&out outest=parms noprint;
   model y =  &count;
data stats;        *-- Annotate data set to label the plot;
   set parms (keep=&count intercep);
   set sum   (keep=mean);
   drop &count intercep;
   length text $30 function $8;
   xsys='1'; ysys='1';
   x=15;
        *-- set label y location based on slope;
        if &count > 0
                then y=96;
                else y=16; 
   function = 'LABEL';
   size = &htext;
   color = 'RED';
   position='3'; text ='slope =   '||put(&count,f6.3);      output;
   position='6'; text ='intercept='||put(intercep,f6.3); output;
   ek = exp(&count - &lambda);
   y=y-6;;
   position='6'; text ='lambda:  mean = '||put(mean,5.3); output;
   position='9'; text ='       exp(slope) = '||put(ek,5.3); output;

%let order=;
%if &z > 0 %then %do;
data conf;
   set &out;
   drop yc;
   xsys='2'; ysys='2';
   x = &count;    line=33;
   y = yc;   function='MOVE  '; output;
   text='+'; function='SYMBOL'; output;
   y = yhi;  function='DRAW  '; output;
   y = yc;   function='MOVE  '; output;
   y = ylo;  function='DRAW  '; output;
data stats;
   set stats conf;

*-- find range of confidence limits to set y axis extrema;
proc means data=conf noprint;
   var y;
   output out=range min=min max=max;
data _null_;
   set range;
        inc = 1;
        if (max-min)>10 then inc=2;
   min = inc * floor(min/inc);
   max = inc * ceil(max/inc);
   call symput('MIN', left(put(min,2.)));
   call symput('MAX', left(put(max,2.)));
   call symput('INC', left(put(inc,2.)));
run;
%let order = order=(&min to &max by &inc);
%end; /* %if &z */

*-- Poissonness plot;
proc gplot data=&out;
   plot y * &count / anno=stats vaxis=axis1 haxis=axis2
                name="&name"
                des="Poissonness plot of &count";
   symbol v=- h=2 i=rl c=black;
   axis1 &order
         label=(a=90 r=0 h=1.4
          'Poisson metameter, ln(k!  n(k) / N)')
         value=(h=&htext);
   axis2 offset=(3) minor=none
        %if %length(&label) %then %do;
         label=("k  (&label)")
                        %end;
         value=(h=&htext);
        run; quit;

*-- Indicated parameter change (infl) plot;
        %if %index(&plot,INFL) %then %do;
        %label(data=&out, y=vc,    x=hc, text=&count, out=anno1, size=);
        *-- Draw lines from origin to each point;
        data lines;
                set &out(keep=hc vc);
                xsys='2'; ysys ='2';
                x=0;  y=0;  function='move    '; output;
                x=hc; y=vc; function='draw    '; output;
        data anno1;
                set anno1 lines;

        %label(data=&out, y=slope, x=hc, text=left(put(&count,2.)),
                out=anno2, size=);
        %gskip;
        symbol v=- h=2 color=black i=none;
        axis1 label=(a=90);

        proc gplot data=&out;
                plot vc * hc  /
                        hzero vref=0 lvref=33 anno=anno1 vaxis=axis1 hminor=1 
vminor=1
                        name="&name"
                        des="Parameter change plot of &count";
                run;
        %gskip;
        proc gplot data=&out;
                bubble slope * hc =hc / 
                        vref=0 lvref=33 anno=anno2 vaxis=axis1  hminor=1 
vminor=1
                        bsize=40 bcolor=red bscale=radius
                        name="&name"
                        des="Parameter change plot of &count";

        run; quit;
%end;
%done:
        %*-- Restore global options;
        %if &sysver >= 7 %then %do;
                options &o1 &o2;
                %end;
        %else %do;
           options notes;
                %end;
%mend;

/*-------------------------------------------------------------------*
  *    Name: sort.sas                                                 *
  *   Title: Generalized dataset sorting by format or statistic       *
  *     Doc: http://www.math.yorku.ca/SCS/vcd/sort.html               *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <friendly@yorku.ca>         *
  * Created: 04 Nov 98 17:17                                          *
  * Revised: 19 Nov 1998 12:26:55                                     *
  * Version: 1.1                                                      *
  *                                                                   *
  * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
  *-------------------------------------------------------------------
*/
 /* Description:
 
 The SORT macro generalizes the idea of sorting the observations in
 a dataset to include:

 - sorting according to the values of a user-specified format.  
 With appropriate user-defined formats, this may be used to arrange the
 observations in a dataset in any desired order.

 - reordering according to the values of a summary statistic computed 
        on the values in each of serveral groups, for example, the mean 
or 
        median of an analysis variable.  Any statistic computed by 
        PROC UNIVARIATE may be used.

Usage:

 You must specify one or more BY= variables.  To sort by the value
 of a statistic, specify name the statistic with the BYSTAT= parameter,
 and specify the analysis variable with VAR=.  To sort by formatted
 values, specify the variable names and associated formats with
 BYFMT=.  
 
 If neither the BYSTAT= or BYFMT= parameters are specified,
 an ordinary sort is performed.

 The sort macro is called with keyword parameters.  The arguments
 may be listed within parentheses in any order, separated by commas.
 For example:
 
        %sort(by=age sex, bystat=mean, var=income);

(sorting observations by mean INCOME, for AGE, SEX groups) or

        proc format;
                value age   0='Child' 1='Adult';
        %sort(by=age decending sex,  byfmt=age:age.);

(sorting by the formatted values of AGE).
 
Parameters:

* DATA=         Name of the input dataset to be sorted.  The default 
is the
            most recently created data set.

* VAR=          Specifies the name of the analysis variable used for 
BYSTAT
            sorting.

* OUT=          Name of the output dataset.  If not specified, the 
            output dataset replaces the input dataset.

* BY=       Names of one or more classification (factor, grouping)
            variables to be used in sorting.  The BY= argument may
                                contain the keyword DESCENDING before a 
variable name
                                for ordinary or formatted-value sorting.  For 
BYSTAT
                                sorting, use ORDER=DESCENDING.  The BY= 
variables may
                                be character or numeric.

* BYFMT=    A list of one or more terms, of the form, VAR:FMT or
            VAR=FMT, where VAR is one of the BY= variables, and FMT is
            a SAS format.  Do not specify BYSTAT= when sorting by
                                formatted values.

* VAR=      Name of the analysis variable to be used in determining
            the sorted order.

* BYSTAT=   Name of the statistic, calculated for the VAR= variable
            for each level of the BY= variables.  BYSTAT may be the
                                name of any statistic computed by PROC 
UNIVARIATE.

* FREQ=     For BYSTAT sorting, specify the name of a frequency 
variable
            if the input data consists of grouped frequency counts.

* ORDER=    Specify ORDER=DESCENDING to sort in descending order
            when sorting by a BYSTAT.  The ORDER= parameter applies
                                to all BY= variables in this case.

Example:
 Given a frequency table of Faculty by Income, sort the faculties
 so they are arranged by mean income:
        
        %sort(data=salary, by=Faculty, bystat=mean, var=income, 
freq=count);

*/
 
%macro sort(
        data=_last_,  /* data set to be sorted           */
        out=&data,    /* output dataset                  */
        by=,          /* name of BY/CLASS variable(s)    */
        byfmt=,       /* variable:format list            */
        var=,         /* name of analysis variable       */
        freq=,        /* frequency variable, for bystat  */        
        bystat=,      /* statistic to sort by            */
        order=        /* DESCENDING for decreasing order */
        );

%if %upcase(&data) = _LAST_ %then %let data = &syslast;

%local abort;
%let abort=0;
%if %length(&by)=0 %then %do;
        %put ERROR: At least one BY= variable must be specified for 
sorting;
        $let abort=1;
        %goto done;
%end;


%*-- If there is no bystat, check byfmt;
%if %length(&bystat)=0 %then %do;
        %if %length(&byfmt)>0 %then %do;
                %sortfmt(data=&data, by=&by, byfmt=&byfmt, out=&out);
                %end;
        %else %do;      
        %*-- There is no bystat, and no byfmt: just an ordinary sort 
step;
        proc sort data=&data out=&out;
                by &order &by;
                run;
                %end;
%end;

%else %do;    /* BYSTAT sorting */
        %if %length(&var)=0 %then %do;
                %put ERROR: Exaxtly one VAR= variable must be specified for 
sorting by &bystat;
                $let abort=1;
                %goto done;     
        %end;
        %if %length(%scan(&var,2)) > 0 %then %do;
                %let ovar=&var;
                %let var = %scan(&var,1);
                %put WARNING: VAR=&ovar was specified.  Using VAR=&var;
        %end;

        %*-- Reorder according to &by variables in reverse order;
        %let rby = %reverse(&by);
        %*put Reversed by list: &rby;

   %let count=1;
   %let word = %unquote(%qscan(&rby,&count,%str( )));
        %*-- Do the first one;
        %reorder(data=&data, out=&out, var=&var, class=&word, 
bystat=&bystat,
                        order=&order, freq=&freq);
   %*-- Do the rest;
   %do %while(&word^= );
       %let count = %eval(&count+1);
       %let word = %unquote(%qscan(&rby,&count,%str( )));
                 %if &word ^= %then %do;
                        %reorder(data=&out, out=&out, var=&var, class=&word, 
bystat=&bystat,
                        order=&order, freq=&freq);
                        %end;
   %end;
 
%end;

%done:
%if &abort %then %put ERROR: The SORT macro ended abnormally.;
%mend;


 /*------------------------------------------------------------*
  *    Name: reorder                                           *
  *   Title: Sort a dataset by the value of a statistic        *
  *------------------------------------------------------------*/

%macro reorder(
        data=_last_,   /* name of input dataset                */
        out=&data,     /* name of output dataset               */
        var=,          /* name of analysis variable            */
        freq=,         /* frequency variable, for bystat  */        
        class=,        /* name of class variable for this sort */
        bystat=,       /* statistic to sort by                 */
        order=,        /* DESCENDING for decreasing order      */
        outvar=,       /* Name of output statistic variable    */
        prefix=_
        );
        
%if %upcase(&data) = _LAST_ %then %let data = &syslast;
*put REORDER: class=&class;

proc sort data=&data;
   by &class ;
        run;
        
%if %length(&outvar)=0
   %then %let outvar =  &&prefix.&class;

proc univariate noprint data=&data;
   by &class ;
   var &var;
        %if %length(&freq) %then %str(freq &freq;) ;
   output out=_stat_ &bystat = &outvar;
   run;
*proc print;


%*-- Merge the statistics with the input dataset;
data &out;
   merge &data _stat_(keep=&class  &outvar);
        by &class;

%*-- Sort them by the statistic;
proc sort data=&out;
        by &order  &outvar;
        run;
%mend;


 /*------------------------------------------------------------*
  *    Name: reverse                                           *
  *   Title: Reverse the words in a string                     *
  *------------------------------------------------------------*/

%macro reverse(string);
   %local count word result;
   %let count=1;
   %let word = %qscan(&string,&count,%str( ));
        %let result=&word;
   %do %while(&word^= );
       %let count = %eval(&count+1);
       %let word = %qscan(&string,&count,%str( ));
                 %let result = &word &result;
   %end;
   %unquote(&result)
%mend;

 /*------------------------------------------------------------*
  *    Name: sorftmt                                           *
  *   Title: Sort variables by formatted values                *
  *------------------------------------------------------------*/

%macro sortfmt(data=, by=, byfmt=, out=&data);

%let tempvar=;
%if %length(&byfmt)>0 %then %do;
        data _temp_;
                set &data;
                %let i=1;
                        %*-- terms are separated by spaces.  Each is var:fmt 
or var=fmt;
                %let term = %scan(&byfmt,1,%str( ));
                %do %while(&term^= );
        %let i = %eval(&i+1);
                        %let var = %scan(&term,1, %str(=:));
                        %let fmt = %scan(&term,2, %str(=:));
                        %if %index(&fmt,%str(.))=0 %then %let fmt=&fmt..;

                                %*-- Create surrogate variable;
                        _&var = put( &var, &fmt );

                        %let tempvar = &tempvar _&var;
                                %*-- Replace the by variable with its 
surrogate;
                        %let by = %replace(&by, &var, _&var);
                        %put var=&var fmt=&fmt by=&by;
        %let term = %scan(&byfmt,&i,%str( ));
                %end;
%*      proc print data=_temp_;
        
        proc sort data=_temp_ out=&out
                %if %length(&tempvar)>0 %then (drop=&tempvar);;
                by &by;
        %end;
%mend;

%*-- Replace a substring with a new string;
%macro replace(string, old, new);
%local i;
%let i=%index( %upcase(&string), %upcase(&old) );
%if &i=0
        %then %let result = &string;
        %else %do;
                %let len = %length(&old);
                %let pre=;
                %if &i>1 %then %let pre=%substr( &string, 1, %eval(&i-1));
                %let result = &pre.&new.%substr( &string,%eval(&i+&len));
                %end;
        &result
%mend;


/*-------------------------------------------------------------------*
 *    Name:  agree.sas                                               *  
 *   Title:  Agreement chart for n x n table                         *
 *                                                                   *
 *-------------------------------------------------------------------*
 *  Author:  Michael Friendly            <friendly@yorku.ca>         *
 * Created:  13 Mar 1991 10:23:12                                    *
 * Revised:  12 Jan 1998 09:15:33                                    *
 * Version:  1.1                                                     *
 *                                                                   *
 * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
 *-------------------------------------------------------------------*/
 /* Description:

The AGREE program is a collection of SAS/IML modules for preparing
observer agreement charts which portray the agreement between two
raters.

Usage:

The modules are typically loaded into the SAS/IML workspace with
the %include statement.  The required input parameters are specified
with IML statements, and the AGREE module is called as follows,
 
   proc iml;
      %include 'path/to/agree.sas';
      *-- set global variables, if desired;
      font = 'hwpsl009';
      htext=1.3;

      *-- data, labels, title, weights;
      freq =
         {  5     3     0      0,
            3    11     4      0,
            2    13     3      4,
            1     2     4     14 };
      vnames = {'New Orleans Neurologist' 'Winnipeg Neurologist'};
      lnames = {'Certain' 'Probable' 'Possible' 'Doubtful'};
      title  = 'Multiple Sclerosis: New Orleans patients';
      w = 1;         *-- diagonals only   , or ...;
      w = {1 (8/9)}; *-- diagonals + 1-off;
      run agree(freq, w, vnames, lnames, title);

Parameters:

The required parameters for the RUN AGREE statement are:

* table     A square numeric matrix containing the contingency table
            to be analyzed.

* weight    A vector of one or more weights used to give ``partial
            credit'' for disagreements by one or more categories.
            To ignore all but exact agreements, let weight=1.  
            To take into account agreements one-step apart (with a 
            weight of 5/6), let weight={1 5/6}.

* vnames    A character vector of two elements, containing the names
            of the row and column variables.

* lnames    A character vector containing the names of the row and
            column categories.  If table is $n \times n$, then
            lnames should contain $n$ elements.

* title    A character string containing the title for the plot.

==Global input variables:

The program uses two global variables to determine the font and
character height for text in the agreement chart.

* font     A character string specifying the font used.
           The default is Helvetica ('hwpsl009') if a PostScript
           driver is being used, SWISS otherwise.

* htext    A numeric value specifying the height of text characters.

 */
 *-- Bangdiwala Observer Agreement Chart [SAS SUGI, 1987, 1083-1088];
 
start agree(freq, w, vnames, lnames, title )
   global (font, htext);

   if type(font ) ^= 'C' then do;
      call execute('device  = upcase("&sysdevic");');
      if index(device,'PS') > 0 then
         font= 'hwpsl009';         /* Helvetica for PS drivers */
         else font = 'SWISS';
      end;
   if type(htext ) ^= 'N' then htext=1.2;

   row_sum = freq[,+];
   col_sum = freq[+,];
   n       = freq[+,+];
   k       = nrow(freq);

   reset noname;
   print (( freq || row_sum ) //
          ( col_sum || n ) )[r=(lnames ||'Total') c=(lnames 
||'Total')];
   obs_agr = ssq( vecdiag(freq) );
   tot_agr = col_sum * row_sum ;

   call gstart;
   call gwindow( (-.15#J(1,2,n)) // (1.1#J(1,2,n)) );
   call gset('FONT', font);
   height = htext;
   call gstrlen(len,lnames,height);

   corner= { 0 0 };
   fill  = 'EMPTY';
   *-- construct marginal rectangles and locate row/col labels --;
   do s = 1 to k;
      thisbox = corner || row_sum[s] || col_sum[s];
      boxes   = boxes  // thisbox;
      fill    = fill   // 'EMPTY';
      center  = corner +((row_sum[s] || col_sum[s])
                       - (len[s]     || len[s]    ))/2;
      labelx  = labelx //(center[1] || (-.06#n)  || 0 )
                       //((-.04#n)  || center[2] || 90);
      labels  = labels // lnames[s]
                       // lnames[s];
      corner  = corner + (row_sum[s] || col_sum[s]);
      ht      = ht     // height // height;
      end;

   *-- variable names;
   height = 1.4#htext;
   call gstrlen(len,vnames,height);
   center = ((1.0#n) - len)/2;
   labelx  = labelx // ( center[1] || (-.12#n)  || 0 )
                    // ( (-.10#n)  || center[2] || 90);
   labels  = labels // vnames[1]
                    // vnames[2];
   ht      = ht     // height // height;

   *-- surrounding frame, for all observations;
   boxes = boxes // ( { 0 0 } || n || n ) ;

   corner= { 0 0 };
   *-- construct agreement squares and scores;
   q = ncol(w) - 1;
   a = J(q+1,k,0);
   *-- b indexes distance from main diagonal for agreement;
   do b = 0 to q;
   do s = 1 to k;
      agr = max(1, s-b) : min(k, s+b) ;    * cells which agree;
      dis = 1 : max(1, s-b-1) ;            * disagre;
      box_loc = choose( (s-b-1)>0,
                        (sum(freq[s,dis]) || sum(freq[dis,s])),
                        { 0 0 } );
 /*   box_size= choose( (s-b) > 0,
                        (sum(freq[s,agr] ... */
      if s=1 then corner = {0 0};
             else corner = boxes[s,1:2] + box_loc;
      thisbox = corner || sum(freq[s,agr]) || sum(freq[agr,s]);
      boxes   = boxes  // thisbox;
      if b>0 then a[b+1,s] =thisbox[3] # thisbox[4];
 
      if b=0 then fill    = fill   // 'SOLID';
      else do;
         if mod(b,2)=1 then dir='L';
                       else dir='R';
         dens = int((b+1) / 2);
         fill    = fill   // (dir + char(dens,1));
         end;
      end;
   end;
   print 'Bangdiwala agreement scores';
   part = diag(w) * A;
   weights = shape(w,0,1);
   steps = 0:q;
   BN =  1 - ( ( tot_agr - obs_agr - part[,+] ) / tot_agr );
   reset name;
   print steps weights[f=8.5] BN[f=8.4];
*  print boxes[c={'BotX' 'BotY' 'LenX' 'LenY'}] fill;
*  print labels labelx[c={X Y ANGLE}] ht;
 
   run gboxes( boxes, labels, labelx, fill, ht, title );
   call gstop;
finish;
 
*-- Draw and label the agreement display --;
start gboxes( boxes, labels, labelx, fill, ht, title )
   global ( htext );
   call gopen('AGREEMT');
   *-- locate the 4 corners of each box;
   ll = boxes[,{1 2}];
   lr = boxes[,{1 3}][,+] || boxes[,2] ;
   ul = boxes[,1] || boxes[,{2 4}][,+] ;
   ur = boxes[,{1 3}][,+] || boxes[,{2 4}][,+];

   xy = ll || ul || ur || lr;
   max = max(ur[,1]) || max(ur[,2]);
   do i=1 to nrow(boxes);
      box = shape(xy[i,], 4);
      color='BLACK';
      pat = fill[i];
      call gpoly( box[,1], box[,2], 1, color, pat, color);
   end;
 
   *-- Draw dotted diagonal line to show marginal homogeneity--;
   call gdrawl( {0 0}, max, 3 , 'RED' );
 
   do f=1 to nrow(labels);
      lxya = labelx[f,];
      labl = labels[f ];
      height = ht[f];
      call gscript( lxya[,1], lxya[,2], labl, lxya[,3], 0, height);
   end;
   height = 1.2#htext;
   call gstrlen(len, title, height);
   tx = (max[1] - len)/2;
   call gscript(tx, max[2]#1.05, title, 0, 0, height);
   call gshow;
finish;

/*-------------------------------------------------------------------*
 |    Name:  sieve.sas                                               |  
 |   Title:  Sieve diagrams for two-way tables                       |
 |                                                                   |
 | Ref: Reidwyl & Schuepbach (1983).                                 |
 |                                                                   |
 *-------------------------------------------------------------------*
 *  Author:  Michael Friendly            <friendly@yorku.ca>         *
 * Created: 14 Apr 1991 14:12:14              (c) 1991-1998          *
 * Revised: 17 Nov 2000 12:21:07                                     *
 * Version:  1.4                                                     *
 *  1.2  Add colors global variable                                  *
 *  1.3  Added filltype='OBSP' to print cell freq in cell            *
 *  1.4  Made colors consistent with mosaics                         *
 *       Default font now depends on device driver                   *
 *                                                                   *
 * From ``Visualizing Categorical Data'', Michael Friendly (2000)    *         
 *-------------------------------------------------------------------*/

 /* Description:

The SIEVE program is a collection of SAS/IML modules for
drawing sieve (or parquet) diagrams for a two-way contingency table.

Usage:

   proc iml;
   %include iml(sieve);
   run sieve( f, vnames, lnames, title );

Parameters:

The required parameters for the RUN SIEVE statement are:

* f        two-way contingency table, size r x c

* vnames   variable names, a 1x2 character matrix.
           vnames[,1]=row variable, vnames[,2]=column variable

* lnames   category names, a 2 x max(r,c) character matrix.
           lnames[1,]=row categories, vnames[2,]=column categories.

* title    plot title

Global variables:

* filltype  'OBS': fill cells in proportion to observed frequencies
            'OBSP': like OBS, but also write obs. freq. in cell
            'DEV': fill in proportion to deviations from independence.
            'EXL': no fill, write expected frequency in cell
            'EXP': expfill, write expected frequency in cell

* margins   ''   : nothing in margins
            'TOTALS': row/col totals in margins

* font      font for text

* colors    names of two colors to use for the positive and
            negative residuals.  [Default: {BLUE RED}]
*/
 
start sieve (f, vnames, lnames, title )
      global(filltype, margins, colors, gout, name, font);
   if type(filltype) ^= 'C' then filltype='OBS';
   if type(margins ) ^= 'C' then margins ='';
   if type(colors)   ^='C'  then colors= {BLUE RED};
   if type(gout    ) ^= 'C' then gout='WORK.GSEG';
   if type(name    ) ^= 'C' then name='SEIVE';
   if type(lnames  )  = 'N' then lnames = trim(left(char(lnames)));

        *-- Set default font based on device driver name;
   if type(font    ) ^= 'C' then do;
                call execute('device  = upcase("&sysdevic");');
                if index(device,'PS') > 0 then
         font= 'hwpsl009';         /* Helvetica for PS drivers */
                else /* if device='WIN' then */
                        font = 'SWISS';
                end;

   filltype = upcase(filltype);
   margins = upcase(margins);
   verbose=0;
 
   nr= nrow(f);
   nc= ncol(f);
   nrc=nr#nc;
   r = f[,+];              * row totals;
   c = f[+,];              * col totals;
   n = c[+];               * grand total;
 
   e = r * c / n;          * expected frequencies;
   d = (f - e) / sqrt(e);  * standard deviates;
   print "Observed Frequencies",
         f [r=(lnames[1,]) c=(lnames[2,]) format=7.0];
   print "Expected Frequencies",
         e [r=(lnames[1,]) c=(lnames[2,]) format=7.1];
   print "Standardized Pearson Deviates",
         d [r=(lnames[1,]) c=(lnames[2,]) format=7.2];
 
   chisq = chisq(f,e);
   df = (nr-1)#(nc-1);
   prob = 1 - probchi(chisq,df);
   print "Test of Independence",
         df ' ' chisq[r={'G.F.' 'L.R.'} format=9.3]
         prob [format=8.4];
 
   rl= (100-nr+1) # r / n;
   cl= (100-nc+1) # c / n;
   cy = 101;
   do i = 1 to nr;
      cx = 0;
      cy = cy - rl[i,] - 1;
      do j = 1 to nc;
         if j= 1 then cx = 0;
         else cx = sum(cl[,1:(j-1)]) + j-1;
         boxes = boxes // ( cx || cy || cl[j] || rl[i] );
      end;
   end;
*  print boxes[c={'BotX' 'BotY' 'LenX' 'LenY'} format=8.3];
 
   call gstart(gout);
   call gopen(name,1);
   call gwindow({ -20 -20 110 110});
 
   if margins = 'TOTALS'          /* y-values for col labels */
      then lcl = {-11 -17 -6};    /* lnames, vnames, totals  */
      else lcl = {-6  -13};
   *-- category names;
   height = 1.1;
   call gset('FONT',font);
   lrx = 15;
   run gheight(lnames,font,lrx-1,1.75, len,height);
*  print lnames len[format=8.2] ;
 
      *-- row labels;
   lry = boxes[nc#(1:nr),2] + rl/2;
   lrx = repeat((-lrx), nr, 1);
   labelx = labelx // ( lrx || lry || repeat((0||height),nr,1) );
   labels = labels // ( shape(lnames[1,], nr,1) );
 
      *-- col labels;
   lcx = boxes[1:nc,1] + (cl/2)`;
   lcy = repeat(lcl[1], nc, 1);
   labelx = labelx // ( (lcx-(len[2,1:nc]`)/2) || lcy
                   || repeat((0||height),nc,1) );
   labels = labels // ( shape(lnames[2,], nc,1) );
 
   *-- variable names;
   ht = 1.1 # height;
   call gstrlen(len,vnames,ht,font);
   center = ( 100 - len)/2;
   labelx  = labelx // (  -16.5    || center[1] || 90 || ht)
                    // ( center[2] || lcl[2]    ||  0 || ht);
   labels  = labels // vnames[1]
                    // vnames[2];
   *-- title;
   if length(title)>1 then do;
      ht = 1.8;
      run gheight(title,font,100,2.2,len,ht);
      center = ( 100 - len)/2;
      labelx = labelx // ( center || 105 ||  0 || ht );
      labels = labels // title;
   end;
 
   *-- cell frequencies;
   if filltype='OBS' then do;
      f1 = loc(f = 1);
      if ncol(f1)>0  then value = repeat({"1"}, ncol(f1), 1);
   end;
   if filltype='EXL' | filltype='EXP' then do;
      f1 = 1:nrc;
      value = compress(char(shape(e, nrc, 1),5,1));
   end;
   if filltype = 'OBSP' then do;
      f1 = 1:nrc;
      value = compress(char(shape(f, nrc, 1),5,0));
   end;

   if /*filltype^='EXP' & */ ncol(f1)>0 then do;
      ht = height - .05;
      center = boxes[f1,] * ( I(2) // .5#I(2) );
      call gstrlen(len, value,ht,font);
      center[,1] = center[,1] - len/2;
      labelx = labelx // ( center || repeat((0||ht), ncol(f1), 1) );
      labels = labels // value;
   end;
   if margins = 'TOTALS' then do;
      ht = height - .05;
      center = repeat({101},nr,1) || lry;
      labelx = labelx // ( center || repeat((0||ht),nr,1) );
      labels = labels // char(shape(r, nr, 1),4,0);
 
      value  = char( shape( c||n , nc+1, 1), 4,0 );
      call gstrlen(len, value,ht,font);
      lcx = lcx // {101};  len[nc+1,]=0;
      center = (lcx -len/2)  || repeat(lcl[3],nc+1,1);
      labelx = labelx // ( center || repeat((0||ht),nc+1,1) );
      labels = labels // value;
   end;
 
   reset fw=7;
   labelx = round(labelx,.001);
*  print labelx[c={'X' 'Y' 'Angle' 'Ht'}] labels[format=$25.];
   d    = shape(d, nrc,1);
   if filltype = 'EXL'    then fill = shape({0}, nrc, 1);
   if filltype = 'DEV'    then fill = shape( d , nrc, 1);
   if filltype = 'OBS'    then fill = shape( f , nrc, 1);
   if filltype = 'OBSP'   then fill = shape( f , nrc, 1);
   if filltype = 'EXP' then do;
      d = j(nrc,1,0);          fill = shape( e , nrc, 1);
      end;
   run gboxes(boxes, labels, labelx, fill, d );
   call gshow;
   finish;
 
start gheight(label, font, maxlen, maxht, len, height);
   *-- determine height<maxht, to not exceed maxlen in length;
   *-- returns len and height;
   call gstrlen(len,label,height,font);
   max = max(len);
   if max > maxlen | max < .80#maxlen then do;
      height = min(maxht, height # .1 # int(10 # maxlen / max));
      call gstrlen(len,label,height,font);
      end;
   finish;
 
start gboxes( boxes, labels, labelx, fill,dev);
   call gopen('sieve');
   *-- locate the 4 corners of each box;
   ll = boxes[,{1 2}];
   lr = boxes[,{1 3}][,+] || boxes[,2] ;
   ul = boxes[,1] || boxes[,{2 4}][,+] ;
   ur = boxes[,{1 3}][,+] || boxes[,{2 4}][,+];
 
   xy = ll || ul || ur || lr;
   max = max(ur[,1]) || max(ur[,2]);
   do i=1 to nrow(boxes);
      box = shape(xy[i,], 4);
      color='BLACK';
      pat = 'EMPTY';
      call gpoly( box[,1], box[,2], 1, color, pat, color);
   end;
   run fillbox(boxes,fill,dev);
   height = 1;
   do f=1 to nrow(labels);
      lxya = labelx[f,];
      ht   = lxya[,4];
      labl = labels[f ];
      call gscript( lxya[,1], lxya[,2], labl, lxya[,3], 0, ht);
   end;
   finish;
 
start fillbox(boxes, fill, sign)
      global(filltype, colors);
   *-- fill each box proportional to abs(fill);
   w = boxes[,3];
   h = boxes[,4];
   totarea = sum(h#w);
   totfill = sum(abs(fill));
   scale = 1;
   if totfill>.1 & filltype='DEV' /* ^all( fill = int(fill) ) */
      then scale = sqrt(totarea / totfill);
*  print totarea totfill scale;
 
   if filltype='DEV'         /* standardized deviations */
      then do;
      s = sqrt(100 / (abs(fill)) ) ;
      s = s + 100#(abs(fill)<2) ;
      end;
      else
      s = sqrt(h # w / (abs(fill)#scale) );    *space between lines;
   nxl = int(w/s);
   nyl = int(h/s);
*  print 'Width, Height, Square', w h s fill nxl nyl;
   do i = 1 to nrow(boxes);
      if sign[i] >= 0
      then do; line = 1; color = colors[1];   /* 'BLUE' */
      end;
      else do; line = 3; color = colors[2];   /* 'RED ' */
      end;
      if filltype='EXP' then line=34;
      if nxl[i]>0 then do;
         from  = ((boxes[i,1] + (1:nxl[i]) # s[i]))`||
                 shape(boxes[i,2], nxl[i], 1);
         to    = from[,1] || shape(sum(boxes[i,{2 4}]), nxl[i], 1);
         call gdrawl( from, to, line, color );
      end;
      if nyl[i]>0 then do;
         from  = shape(boxes[i,1], nyl[i], 1) ||
                 ((boxes[i,2] + (1:nyl[i]) # s[i]))` ;
         to    = shape(sum(boxes[i,{1 3}]), nyl[i], 1) || from[,2] ;
         call gdrawl( from, to, line, color );
      end;
   end;
   finish;
 
start chisq(obs, fit);
   *-- Find Pearson and likelihood ratio chisquares;
   gf = sum ( (obs - fit)##2 / ( fit + (fit=0) ) );
   lr = 2 # sum ( obs # log ( (obs+(obs=0)) / (fit + (fit=0)) ) );
   return (gf // lr);
   finish;


/*----------------------------------------------------------------*
 |    Name:  fourfold.sas                                         |  
 |   Title:  IML modules for fourfold display of 2x2xK tables     |
 *----------------------------------------------------------------*
 *  Author:  Michael Friendly         <friendly@YorkU.CA>         *
 * Citation: SAS/IML graphics for fourfold displays, Observations,*
 *           3rd Quarter 1994, 47-56.                             *
 * Created:  9 May 1991 19:12:12      Copyright (c) 1992-2000     *
 * Revised:  21 Apr 2000 13:16:20                                 *
 * Version:  2.0                                                  *
 * Changes:  Added tests for homogeneity and cond. independence   *
 *  1.6  Added options for colors, patterns, font                 *
 *  1.7  Added confidence rings for odds ratios                   *
 *  1.8  Added option for order of tables (down vs. across)       *
 *  1.9  Fixed problems with zero subtables and zero odds ratios  *
 *       Added std='TOTAL' ??  Added htext=                       *
 *  2.0  Added fillpat routine to select color based on Z val     *
 *       Switched colors/patterns to conform with mosaics         *
 *       Handles 3 or more factors                                *
 *       Default font now depends on device driver                *
 *       Added outstat data set containing OR, LOGOR, etc         *
 *                                                                *
 * From ``Visualizing Categorical Data'', Michael Friendly (2000) *         
 *----------------------------------------------------------------*/
/* Usage:
   proc iml;
   %include fourfold;
   run fourfold( dim, table, vnames, lnames );

Required parameters:
   dim      table dimensions: {2 2 k}
   table    two- or three-way contingency table,
            of size (2k) x 2
   vnames   variable names, 1x3 character matrix.
            vnames[,1]=column variable
            vnames[,2]=row variable
            vnames[,3]=panel variable
   lnames   category names, 3 x k character matrix.
            vnames[1,]=col categories,
            lnames[2,]=row categories,
            lnames[3,]=panel categories.

Global input variables:
   std      ='MARG' standardizes each 2x2 table to equal
            margins, keeping the odds ratio fixed (see config)
            ='MAX' standardizes each table to a maximum
            cell frequency of 100.
            ='MAXALL' standardizes all tables to max(f[i,j,k])=100.
                                ='TOTAL' standardizes to the maximum total over 
all tables.
   config   ={1 2}|{1}|{2} specifies the margins to standardize
   down     number of panels down each page
   across   number of panels across each page
   sangle   angle for side labels (0|90)
   colors   names of two colors to use for the smaller and
            larger diagonals of each 2x2 table.
   patterns names of two fill patterns.  For grayscale, use
            {SOLID SOLID} and colors={GRAYC0 GRAY80}.
        shade    shading levels, corresponding to values of the Z-value
                 for the log odds ration.
   alpha    error rate for confidence rings on odds ratios;
            0 to suppress
   conf     type of confidence rings ='Individual'|'Joint'
   font     font used for labels.
        htext    base height of text labels
   frame    line style for boxed frame (0=none)
        name     name of graphics catalog entry
        order    DOWN|ACROSS - how to arrange multiple plots on a page
        ptitle   panel title, for multiple plots.  The name(s) of the 
panel
                 variable(s) are substituted for '&V'; the levels of the
                                panel variables are substituted for '&L'. 
Default: '&V : &L'.
        outstat  name of output data set containing odds ratio, log odds 
ratio,
                 etc.
*/

goptions gunit=pct;
start fourfold(dim, table, vnames, lnames)
  global (std, config, down, across, name, sangle, colors, patterns,
          alpha, conf, font, order, odds, bounds, verbose, htext, 
frame,
                         filltype, shade, ptitle, outstat );

   if nrow(vnames)=1 then vnames=vnames`;
   if nrow(dim)=1 then dim=dim`;
   print  vnames dim '  ' lnames;
 
   *-- Check conformability of arguments --;
   f = nrow(vnames)||nrow(lnames);
   if dim[#] ^= nrow(table)#ncol(table)
      then do;
         print 'ERROR: TABLE and LEVEL arguments not conformable';
                        show dim table;
         goto done;
      end;
   if ^all(f = nrow(dim))
      then do;
         print 'ERROR: VNAMES or LNAMES not conformable with dim';
                        show dim vnames lnames;
         goto done;
      end;
 
  /*-- Set global defaults --*/
  if type(std)     ^='C' then std='MARG';
  if type(config)  ^='N' then config={1 2};
  if type(name)    ^='C' then name='FFOLD';
  if type(sangle)  ^='N' then sangle=90;
  if type(colors)  ^='C' then colors= {BLUE RED};
  if type(patterns)^='C' then patterns={solid solid};
  if type(filltype) ^= 'C' then filltype = {HLS HLS};
  if type(shade) ^= 'N'
      then shade = {2 4};            /* shading levels            */
  if type(alpha)   ^='N' then alpha=.05;
  if type(conf)    ^='C' then conf='Individual';
  if type(htext)   ^='N' then htext=2;
  if type(order)   ^='C' then order='DOWN';
  if type(verbose) ^='C' then verbose = 'NONE';
  if type(frame)   ^='N' then frame=1;        *-- line style for frame;
  if type(ptitle)  ^='C' then ptitle = '&V : &L';
  if type(outstat)  ^='C' then outstat = '';

        *-- Set default font based on device driver name;
   if type(font ) ^= 'C' then do;
                call execute('device  = upcase("&sysdevic");');
                if index(device,'PS') > 0 then
         font= 'hwpsl009';         /* Helvetica for PS drivers */
                else /* if device='WIN' then */
                        font = 'SWISS';
                end;

  nf = nrow(dim);
  if nf<3 then k=1;     * number of panels;
          else k = (dim[3:nf])[#];

        sysver=&sysver;
        if sysver<6.08 then do;
                *-  Viewports are broken in SAS 6.07;
                if type(down)    ^='N' then down=1;
                if type(across)  ^='N' then across=1;
                end;
        else do; *(;
                if type(across)    ^='N' & type(down)='N' then 
down=ceil(k/down);
        else if type(down)    ^='N' & type(across)='N' then 
down=ceil(k/across);
        else if nf>3 then do; 
                across = dim[3];
                down = (dim[4:nf])[#];
                end;
        else do;
                across = int(sqrt(k));
                down = ceil(sqrt(k));
                end;
        end; *);
   
  print 'Global Options',
         std config down across name sangle,
                        colors patterns alpha conf font order verbose htext 
frame
                        filltype shade ;

  /*-- Establish viewports --*/
  np = max(down,across);
  pd = np - (across||down);
  size = int(100 / np);
  if order='DOWN' then
     do;
        do i = 1 to across;
           px = size # ((i-1) // i) + (pd[1] # size/2);
           do j = 1 to down;
              py = 100 - (size # (j//(j-1)) + (pd[2] # size/2));
              ports = ports // shape( (px||py), 1);
           end;
        end;
     end;
     else do;
        do j = 1 to down;
           py = 100 - (size # (j//(j-1)) + (pd[2] # size/2));
           do i = 1 to across;
              px = size # ((i-1) // i) + (pd[1] # size/2);
              ports = ports // shape( (px||py), 1);
           end;
        end;
     end;
  nport=nrow(ports);
 
  if ncol(table) ^= 2 then table=shape(table,0,2);
        if nf>2 then run facnames(dim, lnames, nf, 3, ':', plab);

  run odds(dim, table, lnames);
  if k>1 then run tests(dim, table, vnames);
  if type(filltype) = 'C' then do; 
        run fillpat(fcolors, fpattern);
        * print 'Selecting colors from', fcolors fpattern;
        end;
  
  page = 0;                    * number of pages;

  pvar = '';
  if k>1 then do j=nf to 3 by -1;
        if pvar ^= '' then pvar = pvar + ':';
        pvar = pvar + trim(vnames[j]);
        end;
         
  do i=1 to k;
     r = 2#i;                  * row index, this table;
     t=table[((r-1):r),];      * current 2x2 table;
 
     /* construct top label for this panel */
     title='';
     if k > 1 & length(ptitle)>1 then do;
                title = ptitle;
                call change(title, '&V', pvar);
                call change(title, '&L', plab[i,]);
                end;
 
     /* standardize table to fit 100x100 square */
     run stdize(fit, t, table);
 
     if verbose ^= 'NONE' then do;
     print title;
     print fit[c=(lnames[1,]) r=(lnames[2,]) f=8.2] ' '
             t[c=(lnames[1,]) r=(lnames[2,]) f=8.0] ;
     end;
 
     /*-- start new page if needed --*/
     if nport=1 | mod(i,nport)=1 then do;
        call gstart;
        page = page+1;                * count pages;
        gname =rowcatc(trim(name) || char(page,2,0));
        call gopen(gname);            * name uniquely;
        end;
 
     /*-- set viewport --*/
     if nport>1 then do;
     ip = 1 + mod(i-1,nport);         * viewport number;
     port = ports[ip,];               * coordinates;
     call gport(port);
     end;
 
                colsave = colors; patsave=patterns;
                colors = fcolors[{2 1}, 1+sum(abs(odds[i,4])>shade)]`;
                patterns = fpattern[{2 1}, 1+sum(abs(odds[i,4])>shade)]`;
        *        print 'Using colors:' colors patterns;

     /*-- draw this panel, display if end-of page --*/
     call gpie2x2(fit, t, lnames, vnames, title, np, odds[i,2]);
          colors = colsave; patterns = patsave;
     if alpha>0 then run conflim(dim, t, bounds[i,], table);
     if mod(i,nport)=0 | i=k then call gshow;
   end;
   call gclose;

        done:
finish;
 
start stdize(fit, t, table) global(std, config);
  /*-- standardize table to equal margins --*/
  if std='MARG' then do;
     newtab = {50 50 , 50 50 };
          if any(t ^=0)
        then call ipf(fit,status,{2 2},newtab,config,t);
                  else fit = j(2,2,0);
  end;
 
  /*-- standardize to largest cell in EACH table --*/
  else if std='MAX' then do;
     n = t[+,+];
          if n>0 then do;
                        fit = (t/n)#200 ;
                        fit = fit# 100/max(fit);
          end;
          else fit = j(2,2,0);
  end;
 
  /*-- standardize to largest cell in ALL tables --*/
  else if std='MAXALL' then do;
          fit = t # 100 / max(table);
  end;
  
  /*-- Standardize to total in largest table --*/
  else if std='TOTAL' then do;
                tot = (shape(table[,+],0,2))[,+];
                fit = t # 200 / max(tot);
  end;
  
  else fit = t;   /* raw counts */
finish;
 
start gpie2x2(tab,freq,lnames,vnames,title,np,d)
      global(sangle, colors, patterns, font, htext, frame);
  /*-- Draw one fourfold display --*/
  t = shape(tab,1,4);     * vector of scaled frequencies;
  r = 5 * sqrt(t);        * radii of each quarter circle;
 
  /*-- set graphic window, font, and text height */
  call gwindow({-16 -16 120 120});
  call gset('FONT',font);
  ht = htext # max(np,2);
  call gset('HEIGHT',ht);
 
  /*-- set shading patterns for each quadrant */
  /* cell:[1,1] [1,2] [2,1] [2,2] */
  angle1 = { 90    0   180   270 };
  angle2 = {180   90   270   360 };
  patt   = (shape(patterns[,{1 2 2 1 2 1 1 2}],2))[1+(d>0),];
  color  = (shape(  colors[,{1 2 2 1 2 1 1 2}],2))[1+(d>0),];
        *print patt color;
 
  /*-- draw quarter circles, with color and shading */
  do i = 1 to 4;
     call gpie(50,50, r[i], angle1[i], angle2[i],
               color[,i], 3, patt[,i]);
     if int(abs(i-2.5)) = (d>0) then do;
                        rad = (r[i] + {0, 10}) / 50;
                        ang = repeat( (angle1[i]+angle2[i])/2, 2, 1 );
                        call gpiexy(xx,yy, rad, ang,{50 50}, 50);
                *       print 'Slice markers' i rad ang xx yy;
                        call gdraw(xx, yy);
                        end;
     end;
 
  /*-- draw frame and axes --*/
  call gxaxis({0 50},100,11,1,1);
  call gyaxis({50 0},100,11,1,1);
  if frame>0 then call ggrid({0 100}, {0 100}, frame);
 
  /*-- set label coordinates, angles --*/
  lx = { 50, -.5, 50, 101};
  ly = { 99, 50, -1,  50};
  ang= {  0,  0,  0,   0};
  /*-- label justification position --*/
       /*  ab  lt  bl   rt  */
  posn = {  2,  4,  8,   6};
  if vnames[1] = " " then vl1 = '';
     else vl1= trim(vnames[1])+': ';
  vl2='';
 
  /*-- are side labels rotated? --*/
  if sangle=90 then do;
     ang[{2 4}] = sangle;
     posn[ {2 4}] = {2 8};
     if vnames[2] ^= " "
        then vl2= trim(vnames[2])+': ';
     end;
  labels = (vl2 + lnames[2,1])//
           (vl1 + lnames[1,1])//
           (vl2 + lnames[2,2])//
           (vl1 + lnames[1,2]);
  run justify(lx,ly,labels,ang,posn,ht,xnew,ynew,len);
 
  /*-- write actual frequencies in the corners --*/
  cells = compress(char(shape(freq,4,1),6,0));
  lx = {  5, 95,  5, 95};
  ly = { 94, 94,  4,  4};
  ang= {  0,  0,  0,  0};
  posn={  6,  4,  6,  4};
  run justify(lx,ly,cells,ang,posn,ht,xnew,ynew,len);
 
  /*-- write panel title centered above */
  if length(title)>1 then do;
     ht=1.25#ht;
     call gstrlen(len,trim(title),ht);
     call gscript((50-len/2),112,title,,,ht);
  end;
finish;
 
start justify(x, y, labels, ang, pos, ht, xnew, ynew, len);
  /* Justify strings a la Annotate POSITION variable.
     x, y, labels, ang and pos are equal-length vectors.
     Returns justified coordinates (xnew, ynew)
  */
 
  n = nrow(x);
  call gstrlen(len,labels);
*print len labels;
  xnew = x; ynew =  y;
 
  /* x and y offset factors for each position   */
  /*       1   2   3   4   5   6   7   8    9   */
  off1 = {-1 -.5   0  -1 -.5   0  -1   -.5   0  };
  off2 = { 1   1   1   0   0   0  -1.6 -1.6 -1.6};
 
  do i=1 to n;
     if ang[i]=0 then do;
        xnew[i] = x[i] + (off1[pos[i]]#len[i]);
        ynew[i] = y[i] + (off2[pos[i]]#ht);
     end;
     else if ang[i]=90 then do;
        ynew[i] = y[i] + (off1[pos[i]]#len[i]);
        xnew[i] = x[i] - (off2[pos[i]]#ht);
     end;
  call gscript(xnew[i], ynew[i], trim(labels[i]), ang[i]);
  end;
  len = round(len,.01);
finish;
 
start odds(dim, table, lnames)
      global(alpha, conf, odds, bounds, outstat);
  /*-- Calculate odds ratios for 2x2xK table --*/
  free odds bounds;

  nf = max(ncol(dim), nrow(dim));
  if nf<3 
        then do;  k = 1;       rl='';  end;
   else do;  
                k = (dim[3:nf])[#];
                run facnames(dim, lnames, nf, 3, ':', rl);
                end;

  do i=1 to k;
     r = 2#i;
     t=table[((r-1):r),];
          if any(t=0) then t=t+0.5;
     d = (t[1,2]||t[2,1]);
     or = or // ( t[1,1]#t[2,2])/ ((d + .01#(d=0))[#]);
     selogor = selogor // sqrt( sum( 1 / (t + .01#(t=0)) ) );
     end;
  logor = log(or);
  z = log(or)/selogor;
  prz = 2#(1 - probnorm(abs(z)));
  odds = or || logor || selogor || z || prz;
 
  title= 'Odds (' + trim(lnames[1,1]) + '|' + trim(lnames[2,1])
         + ') / ('+ trim(lnames[1,1]) + '|' + trim(lnames[2,2]) + ')';
  reset noname;
  print title;
  cl={'Odds Ratio' 'Log Odds' 'SE(LogOdds)' 'Z' 'Pr>|Z|'};
  print odds[r=rl c=cl format=9.3];

  if outstat ^= '' then do;
                vn = 'rl or logor selogor z prz';
                call execute('%let outstat=', outstat, ';');
                call execute("create &outstat var{", vn,  "};");
                append;
     end;
 
  /* Find confidence intervals for log(odds) and odds            */
  if nrow(alpha)>1 then alpha=shape(alpha,1);
  cl={'Lower Odds' 'Upper Odds' 'Lower Log' 'Upper Log'};
  if substr(conf,1,1)='I'
     then conf='Individual';
     else conf='Joint';
  do i=1 to ncol(alpha);
     if conf='Individual'
        then pr=alpha[i];
        else pr= 1 - (1-alpha[i])##(1/k);
     if pr>0 then do;
      z = probit(1 - pr/2);
      ci= (odds[,2] * j(1,2)) + (z # selogor * {-1 1});
      co= exp(ci);
      bounds = bounds || co;
      ci= co || ci;
      print conf 'Confidence Intervals, alpha=' pr[f=6.3]  ' z=' 
z[f=6.3  ],
            ci[r=rl c=cl f=9.3];
      end;
     end;
  reset name;
finish;
 
start tests(dim,table, vnames);
        dm = dim;
        vn = vnames;
        nf = max( nrow(dm), ncol(dm) );
        if nf>3 then do;
                dm[3] = (dim[3:nf])[#];  dm=dm[1:3];
                vn[3] = rowcat( trim(shape(vn[3:nf],1)) );
                end;

  config = {1 1 2,           /*  Test homogeneity of odds ratios */
            2 3 3};          /*  (no three-way association)      */
  call ipf(m, status, dm, table, config);
  chisq = sum ( (table - m)##2 / ( m + (m=0) ) );
  chisq = 2 # sum ( table # log ( (table+(table=0)) / (m + (m=0)) ) );
  df  = dm[3] - 1;
  prob= 1- probchi(chisq, df);
  out = chisq || df || prob;
  test={'Homogeneity of Odds Ratios'};
  print 'Test of Homogeneity of Odds Ratios (no 3-Way Association)',
         test chisq[f=8.3] df prob[f=8.4];
 
  config = {  1 2,           /*  Conditional independence */
              3 3};          /*  (Given no 3-way)         */
  call ipf(m, status, dm, table, config);
  chisq = 2 # sum ( table # log ( (table+(table=0)) / (m + (m=0)) ) )
          - chisq;
  df  = 1;
  prob= 1- probchi(chisq, df);
 
  *-- CMH test (assuming no 3-way);
  free m;
  k = dm[3];
  do i=1 to k;
     r = 2#i;                  * row index, this table;
     t=table[((r-1):r),];      * current 2x2 table;
     n = n // t[1,1];
     s = t[+,+];
     m = m // t[+,1] # t[1,+] / (s + (s=0));
     v = v // (t[+,][#]) # (t[,+][#]) / (s#s#s-1);
     end;
  cmh = (abs(sum(n) - sum(m)) - .5)##2 / sum(v);
 
  chisq = chisq // cmh;
  df = df // df;
  prob = prob // (1 - probchi(cmh,1));
  out = out // (chisq || df || prob);
  test = {'Likelihood-Ratio','Cochran-Mantel-Haenszel    '};
  head = 'Conditional Independence of '+trim(vn[1])
         +' and '+trim(vn[2])+' | '+trim(vn[3]);
  reset noname;
  print head, '(assuming Homogeneity)';
  reset name;
  print test chisq[f=8.3] df prob[f=8.4];
finish;
 
start conflim(dim, t, bounds, table)
      global(std);
  do l=1 to ncol(bounds);
  run limtab(dim, t, bounds[l], tbound);
     *-- standardize the fitted table the same way as data;
  run stdize(fit, tbound, table);
  s = shape(fit,1,4);     * vector of scaled frequencies;
  r = 5 * sqrt(s);        * radii of each quarter circle;
  angle1 = { 90    0   180   270 };
  angle2 = {180   90   270     0 };
  pat = 'EMPTY'; color='BLACK';
  do i = 1 to 4;
     call gpie(50,50, r[i], angle1[i], angle2[i],
               color, 3, pat);
     end;
  end;
finish;
 
start limtab(dim, t, bounds, tbound)
      global(std);
  /* find 2x2 tables whose odds ratios are at the limits of the
     confidence interval for log(odds)=0 */
     odds = bounds[1];
     a = sqrt(odds)/(sqrt(odds)+1);
     b = 1 - a;
     ltab =  (a || b) // (b || a);
     *-- construct a fitted table with given odds ratio,
         but same marginals as data;
     config = {1 2};
     call ipf(tbound,status,{2 2},t,config,ltab);
  *  print odds[f=7.3] ltab[f=6.3] t[f=5.0] tbound[f=8.2];
finish;

start fillpat(fcolors, fpattern)
      global(filltype, shade, colors);
   *-- Set colors and patterns for shading fourfold areas;
   ns = 1+ncol(shade);
*       ns  = 2;
   if ns<5
      then dens=char({1 3 4 5}[1:ns]`,1,0);
      else dens={'1' '2' '3' '4' '5'};
   fpattern = J(2,ns,'EMPTY   ');
   if ncol(colors)=1 then colors=shape(colors,1,2);
   colors = substr(colors[,1:2] + repeat('       ',1,2),1,8);
   fcolors = repeat(colors[1],1,ns) // repeat(colors[2],1,ns);
 
   if ncol(filltype)=1 then      /* if only one filltype */
      do;
         if filltype='M0'  then filltype={M0 M90};
         else if filltype='M45' then filltype={M135 M45};
                        else if filltype='LR' then 
filltype=cshape(filltype,2,1,1);
         else filltype=shape(filltype,1,2);
      end;
 
   do dir=1 to 2;                 * for + and - ;
      ftype = upcase(filltype[dir]);      * fill type for this 
direction;
      if substr(ftype,1,1)='M' then
         do;
            angle = substr(ftype,2);
            if angle=' ' then angle='0';
            if ns=2 then fpattern[dir,] = {M1N M1X}+angle;
               else fpattern[dir,] = {M1N M3N M3X M4X 
M5X}[1:ns]`+angle;
         end;
      else if ftype='L' | ftype='R' then
            fpattern[dir,] = trim(ftype)+dens;
      else if substr(ftype,1,4)='GRAY' then
         do;
            if length(ftype)=4
               then step=16;
               else step = num(substr(ftype,5));
            dark = 256 - step#(1:ns)`;
            *-- convert darkness values to hex;
            fcolors = substr(fcolors,1,max(6,length(fcolors)));
            fcolors[dir,] = compress('GRAY'+hex(dark)`);
            fpattern[dir,] = repeat('SOLID',1,ns);
         end;
      else if substr(ftype,1,3)='HLS' then
         do;
         /* lightness steps for varying numbers of scale values */
         step={ 0 100 0 0 0,
               0 90 100 0 0,
               0 25 70 100 0,
               0 20 45 70 100}[ns-1,];
         /* make step=100 map to '80'x, =0 map to 75% of the way to 
'FF' */
         step =  25 + 0.75#step;
         step = step[1:ns]#255/100;
                        dark = 255-ceil(step/2);
         lval= hex(dark)`;

         clr = upcase(colors[dir]);
         hue = {RED GREEN BLUE MAGENTA CYAN YELLOW,
               '070' '100' '001' '03C' '12C' '0B4'  };
         col = loc(hue[1,]=clr);
         if ncol(col)=0 then col=dir;
         hval= hue[2,col];
          fcolors[dir,] =  compress('H'+hval+lval+'FF');
         fpattern[dir,] = repeat('SOLID',1,ns);
         end;
      end;
   finish;
 
start hex(num);
   *-- Convert 0<num<256 to hex;
   chars = cshape('0123456789ABCDEF',16,1,1);
   if num>255 then num = mod(num,256);
   h = rowcat(chars[1+floor(num/16),] || chars[1+mod(num,16),]);
   return(h);
   finish;
   
*-- Construct factorial combinations of level names;
start facnames (levels, lnames, first, last, sep, rl);
        free rl;
        do i=first to last by sign(last-first)+(first=last);
                cl = lnames[i,1:levels[i]]`;
                if i=first then rl=cl;
                else do;        /* construct row labels for prior factors 
*/
                        ol = repeat(rl, 1, levels[i]);
                        ol = shape(ol,  levels[i]#nrow(rl), 1);
                        nl = shape( (cl[1:(levels[i])]), nrow(ol), 1);
                        rl = trim(rowcatc(ol || shape(sep,nrow(ol),1) || 
nl));
                        end;
                end;
        finish;

/*--------------------------------------------------------------------*
 |    Name:  mosaics.sas                                              |  
 |   Title:  IML modules for general n-way mosaic display             |
 |                                                                    |
 |  This program defines the modules. Use mosaicm.sas to install them |
 |  in a SAS/IML storage catalog.                                     |
 *--------------------------------------------------------------------*
 | Original documentation:  ``Users Guide to MOSAICS: A SAS/IML       |
 |   program for Mosaic Displays'', Dept of Psychology Report 206     |
 | For current version, see:                                          |
 |    http://www.math.yorku.ca/SCS/mosaics/mosaics.html               |
 *--------------------------------------------------------------------*
 *  Author:  Michael Friendly              <friendly@YorkU.ca>        *
 * Created:  11 Aug 1990 10:27:11          (c) 1990-1998              *
 * Revised:  15 Jul 1999 14:59:29                                     *
 * Version:  3.6                                                      *
 * Changes:                                                           *
 *   Added fittype='PARTIAL'                                          *
 *   Stop fitting after last plot                                     *
 * (2.7)                                                              *
 *   Filltype changed to allow separate coding for + and - residuals  *
 *     and grayscale shading (filltype='GRAY')                        *
 *   Colors made global                                               *
 * (2.9)  Added cellfill to print residual symbol                     *
 * (3.0)  Added MARKOVk fittype; fit equiprobability model for f=1    *
 * (3.1)  Added readtab routine to read freq, labels from a SAS       *
 *     dataset; devtype='FT' for Freeman-Tukey residuals;             *
 * (3.2)  Added handling of structural zeros                          *
 *     Changed default values to filltype=HLS, colors={BLUE RED}      *
 * (3.3)  Added gskip module, for EPS output. Added &X2 for title     *
 *     Added makemap stub, fuzz value for 0 residuals                 *
 * (3.4)  Added vlabels control, fuzz now sets line style solid.      *
 *     Global variables in separate module to make changing defaults  *
 *     easier.  In transpos module, can specify the variable names    *
 *     in the new order, rather than indices. Same for config.        *
 *     Added JOINTk and CONDITk models (1<=k<=n)                      *
 * (3.5)  Fixed conflict between global var DEVTYPE and macro var     *
 *     Changed circle blanking for CELLFILL to white/black text       *
 *     Added control of threshold for CELLFILL                        *
 *     Added calculation of adjusted residuals                        *
 *     Default font now depends on device driver                      *
 *     Added NAME global for grseg graph names; fixed adj res bug     *
 *     Added CELLFILL='FREQ' to display cell frequency                *
 *     Added ABBREV=# to abbreviate variable names in model           *
 * (3.6)  Added outstat global variable to generate output data set   *
 *     'reorder' changed to 'transpos'                                *
 *--------------------------------------------------------------------
*/
/* Usage:
  proc iml;
   reset storage=mosaic.mosaic;
   load module=_all_;
   shade = {   }; space = {   }; verbose = ;  see global inputs
   run mosaic(levels, table, vnames, lnames, plots, title);

 where:
   levels    Vector of number of levels of each factor.
   table     Table of cell frequencies, as in IPF: first factor
             varies most rapidly along cols, last factor varies
             most slowly down the rows.  If elements of table are
             a single variable in a SAS data set (e.g., output from
             PROC FREQ), with factors={A B C}, the rows (obs.)
             should be sorted BY C B A to obtain IPF ordering.

   vnames    Vector of factor names, order corresponding to levels
   lnames    Matrix of level names: rows=factors, cols=max(levels)
             lnames[i,1:levels[i]] gives level names for factor i.

   plots     List of margins to be plotted: vector of any of the
             integers 1 - ncol(levels).  If plots contains  i  the
             var1 x var2 x ... var i margin will be plotted.
   title     Character string(s) title for plots.  If title is a
             vector, then title[i] is used for plots = i.  If title
             contains '&MODEL', the model fitted is substituted.

Global input variables:
   colors    Colors used for positive and negative residuals.
             Default: {BLUE RED}.
   config    IPF-style model configuration for fittype='USER'.
             Ignored for other fittypes.
   devtype   Type of deviations to be represented by shading. 'GF'
             calculates components of Pearson goodness of fit
             chisquare; 'LR' calculates components of likelihood
             ratio chisquare. 'FT' calculates Freeman-Tukey
             residuals.  devtype='GF' is the default.
   fittype   Type of sequential models to fit: JOINT,MUTUAL,PARTIAL,
             CONDIT, or USER.  If fittype='USER', specify the model
             in the matrix config.
   filltype  Type of fill pattern to use for shading. A vector of
             one or two character strings. filltype[1] is used for
             positive residuals; filltype[2], if present, is used
             for negative residuals.
               'LR'  --> patterns Ld, Rd, where d=density value
               'M0'  --> patterns MdN0, MdN90
               'M45' --> patterns MdN135, Md45 [default]
               'GRAY'--> patterns GRAYnn
               'HLS' --> solid HLS colors, varying in lightness
   cellfill  What to write about residuals in cells with large ones.
                'NONE' --> nothing
                                         'FREQ' --> cell frequency
                'SIGN' --> draws + or - symbols, # = shading level
                'SIZE' --> draws + or - symbols, size ~ shading
                'DEV'  --> write residual value
   htext     Height of text labels [default: 1.3]
   font      Font for text labels [default: DUPLEX]
   legend    Orientation of legend for shading of residual values
             in mosaic tiles. Possible values are 'H', 'V', and
             'NONE'. Default: 'NONE'.
   order     Specifes whether/how to do a correspondence analysis
             on each marginal subtable.  See the Users Guide.
   outstat   Name of output data set
   shade     Vector of up to 5 values of abs(dev[i]) for boundaries
             between shading levels. If shade={2 4}; (the default),
             then shading density is:
                  0 <= |dev[i]| < 2  ->  0 (empty)
                  2 <= |dev[i]| < 4  ->  1
                  4 <= |dev[i]|      ->  2
             Use shade= a big number to suppress all shading.
   fuzz      Values |dev[i]|< fuzz are outlined in black.
   space     2-vector of x,y: amount of plotting area reserved for
             spacing. Typically {20 20}.
   verbose   Controls verbose or detailed output: 'FIT' and/or 'BOX'
   zeros     A 0/1 matrix of the same size/shape as table where 0
             indicates that the corresponding value in table is to
             be treated as missing or a structural zero.
 */
 
*title 'SAS/IML modules for mosaic displays';
*version(6.06);  *-- Requires SAS Version 6.06 or later;
 
start mosaic(levels, table, vnames, lnames, plots, title)
      global(config, devtype, fittype, filltype, shade, space, split,
             legend, colors, htext, font, verbose, cellfill, order,
                                 zeros, fuzz, vlabels, name, abbrev, outstat);
 
   print / '+-------------------------------------------+',
           '|  Generalized Mosaic Display, Version 3.5  |',
           '+-------------------------------------------+';
        if rowcatc(type(levels)||type(table)||type(vnames)||type(lnames)) 
^= 'NNCC'
                then do;
         print 'ERROR: One or more arguments are not defined or of the 
wrong type';
                        show levels table vnames lnames;
         goto done;
      end;
                
   if nrow(vnames)=1 then vnames=vnames`;
   if nrow(levels)=1 then levels=levels`;
   print title, vnames levels '  ' lnames;
 
   *-- Check conformability of arguments --;
   f = nrow(vnames)||nrow(lnames);
   if levels[#] ^= nrow(table)#ncol(table)
      then do;
         print 'ERROR: TABLE and LEVEL arguments not conformable';
                        show levels table;
         goto done;
      end;
   if ^all(f = nrow(levels))
      then do;
         print 'ERROR: VNAMES or LNAMES not conformable with LEVELS';
                        show levels vnames lnames;
         goto done;
      end;
 
        run globals;    
   print 'Global options', fittype devtype filltype split
                           shade[f=3.0] colors ,htext
                                                                        font legend 
cellfill verbose fuzz;
   if fittype='USER' then do;
      if type(CONFIG) = 'C' then
                        config = name2num(config, vnames);
      if type(CONFIG) = 'N' then do;
         print 'Fitting user specified model', CONFIG;
                        end;
      else do;
                        print "CONFIG must be specified for fittype='USER'";
                        goto done;
         end;
   end;
        
   f = nrow(levels);
   whichway = num(translate(split,'10','HV'));
   dir = shape(whichway,f,1);
   if type(space) ^= 'N'
      then space = 10# (sum(dir=0) || sum(dir=1));
   savspace = space;
 
   call gstart;
   *-- divide the plot into boxes  --;
   run divide(levels, table, vnames, lnames, plots, dir, title);
   call gstop;
   space = savspace;
   done:
   finish;
 
start globals;
   *-- Check global inputs, assign default values if not assigned --;
   *   If you dont like these default values, change them;
   if type(filltype) ^= 'C' then filltype = {HLS HLS};
   if type(fittype) ^= 'C'
      then fittype = 'JOINT';
   if type(devtype) ^= 'C'
      then devtype = 'GF';           /* type of deviations: GF,LR */
   if type(shade) ^= 'N'
      then shade = {2 4};            /* shading levels            */
   if type(split) ^= 'C'
      then split = {H V};            /* divide H V H V ...        */
   if type(htext) ^= 'N'
      then htext = 1.4;              /* height of text labels     */
   if type(colors) ^= 'C'
      then colors= {BLUE RED};
   if type(legend) ^= 'C'
      then legend= 'NONE';
   if type(cellfill) ^= 'C'
           then cellfill = 'NONE'; 
   if type(fuzz) ^= 'N'
      then fuzz = .20;               /* fuzz value for 0 residuals */
        if type(order) ^= 'C' then order='NONE';
   if type(verbose) ^='C'
      then verbose = 'NONE';         /* verbose output?           */
        if type(vlabels) ^= 'N'
                then vlabels = 2;              /* variable labels up to 2 
vars */
        if type(name) ^= 'C' then name='MOSAIC';
        if type(abbrev) ^= 'N' then abbrev=0;
        if type(outstat) ^= 'C' then outstat='';
 
        *-- Set default font based on device driver name;
   if type(font ) ^= 'C' then do;
                call execute('device  = upcase("&sysdevic");');
                if index(device,'PS') > 0 then
         font= 'hwpsl009';         /* Helvetica for PS drivers */
                else /* if device='WIN' then */
                        font = 'SWISS';
                end;

        fittype = upcase(fittype);
        devtype = upcase(devtype);
        cellfill= upcase(cellfill);
        colors  = upcase(colors);
        order   = upcase(order);
        split   = upcase(split);
        verbose = upcase(verbose);
        finish; 

start divide(levels, table, vnames, names, plots, dir, title)
      global(config, devtype, fittype , shade, space, verbose, order, 
zeros,
                abbrev);
   *-- start with origin in lower left corner --;
   length= {100 100};                /* x,y length of box area */
   boxes = {0 0}                     /* lowerleft  x,y  */
         ||( length - space );       /* length     x,y  */
   factors = nrow( levels );

        *-- structural zeros or missing values?;
        if type(zeros) = 'U'
                then zeros = j(1,levels[#]);
                else zeros = shape(zeros,1, levels[#]);
        miss = loc(table = .);
        if ncol(miss)>0 then table[miss] = 0;
        miss = loc( row((table = .)) | (zeros = 0) );
        missing = (ncol(miss) > 0);
        tab = shape(table, 1, levels[#]);
        if missing then tab[miss] = 0;

   rows = 1;                 /* number of rows in margins */
   do f = 1 to factors while (f <= max(plots) );
      whichway =dir[f];
      cols = levels[f];      /* number of cols in margins */
      reset noname;
      print  "Factor:" f (vnames[f]);
      reset name;
      mconfig = (f:1)`;       * n sub f, (f-1), ..., 1 ;
      call marg(loc,margin,levels,tab, mconfig);    * margin, with 
zeros;
      call marg(loc,mtab,levels,table,mconfig);     * margin, original 
data;
      call marg(loc,mzero,levels,zeros,mconfig);    * marginal zeros;
                mzero = mzero > 0;

      *-- Construct row and column labels for marginal table;
      cl = names[f,];
      if f=1 then rl='';
         else do;        /* construct row labels for prior factors */
            ol = repeat(rl, 1, levels[f-1]);
            ol = shape(ol,  levels[f-1]#nrow(rl), 1);
            nl = repeat((names[f-1,1:(levels[f-1])])`, nrow(rl));
            rl = concat(ol,nl);
         end;
      margin = (shape(margin, rows)) ;
      mzero  = (shape(mzero, rows)) ;
 
      if f=1 then do;
                *       dev = J(1,ncol(margin),0);
                        *-- fit equiprobability model;
                        fconfig = 1;
                        model = compress("(="+vnames[1]+")");
                        fit = margin[+]/ncol(margin);
                        fit = repeat(fit, 1, ncol(margin));
                        dev = (margin - fit) / sqrt(fit);
                        end;
      else do;
         if fittype='JOINT' then do;
            fconfig = (1 : (f-1))`  || shape(f, f-1, 1, 0);
            dim = ncol(margin) || rows;
            call ipf(fit,status,dim,margin,{1 2},mzero);
                                run mfix(mzero,fit,margin,mtab);
         end;
         else if substr(fittype,1,5)='JOINT' then do;
            if f=2 then fconfig= 1:2;
            else do;
                                        if length(fittype)=5
                                                then k=f;
                                                else k = num(substr(fittype,6));
                                        fconfig = remove(1:f, k)` || shape(k, f-
1, 1, 0);
                                        end;
            run mfit(margin, fconfig, levels, f, fit, status);
                                run mfix(mzero,fit,margin,mtab);
         end;
         else if fittype='MUTUAL' then do;
            fconfig = 1:f;
            dim = levels[f:1];
            call ipf(fit,status,dim,margin,fconfig,mzero);
                                run mfix(mzero,fit,margin,mtab);
         end;
         else if substr(fittype,1,6)='CONDIT' then do;
            if f=2 then fconfig= 1:2;
            else do;
                                        if length(fittype)=6
                                                then k=f;
                                                else k = num(substr(fittype,7));
                                        fconfig = remove(1:f, k) // j(1, f-1, k);
*                                       fconfig = (1 : (f-1)) // j(1, f-1, k);
                                        end;
            run mfit(margin, fconfig, levels, f, fit, status);
                                run mfix(mzero,fit,margin,mtab);
         end;
         else if fittype='PARTIAL' then do;
            if f=2 then fconfig= 1:2;
                   else fconfig =(1:2) // ((3:f)`|| (3:f)`);
            run mfit(margin, fconfig, levels, f, fit, status);
                                run mfix(mzero,fit,margin,mtab);
         end;

         else if substr(fittype,1,6)='MARKOV' then do;
                                *-- determine order of Markov chain requested;
            if length(fittype)=6
               then k=1;
               else k = num(substr(fittype,7));
                                if factors < (k+2) then do;
                                        print 'Warning: Not enough factors for 
order' k 'Markov chain';
                                        if f=2 then fconfig= 1:2;
                                                                else fconfig =(1:(f-1)) 
// (2:f);
                                end;
                                else do;
                                        if f <= (k+1) then fconfig= 1:f;
                                        else do;
                                                free fconfig;
                                                do i=1 to k+1;
                                                fconfig = fconfig // (i:(f-k+i-1));
                                                end;
                                        end;
                                end;
            run mfit(margin, fconfig, levels, f, fit, status);
                                run mfix(mzero,fit,margin,mtab);
         end;

         else if fittype='USER' then do;
            if f=factors then fconfig=config;
                         else fconfig = reduce(config, f);
            run mfit(margin, fconfig, levels, f, fit, status);
                                run mfix(mzero,fit,margin,mtab);
         end;
         if status[1]^=0 then
            print "IPF ended abnormally", status[c={Error MaxDev 
Iterations}];
      end;
 
                *-- Calculate residuals --;
                if index(devtype, 'GF')              /* Pearson residuals       
*/
                        then do;
                                dtyp='GF';
                                dev = (margin - fit)/sqrt(fit + (0=fit));
                                end;
                        else if index(devtype,'LR')       /* likelihood ratio 
resids */
                        then do;
                                dtyp='LR';
                                dev =    sign(margin-fit) #
                                        sqrt(2#( margin # 
(log((margin+(margin=0))
                                                        / (fit+(fit=0))))
                                                        -margin+fit     ));
                                end;
                                                                                        
        /* Freeman-Tukey resids    */
                        else do;
                                dev = sqrt(margin) + sqrt(margin+1)
                                - sqrt(4#fit + 1);
                                dtyp='FT';
                                end;
                if (index(devtype,'ADJ') | index(devtype,'STD')) & 
any(plots=f) then do;
*                       print dtyp 'Residuals',
                                        dev[r=rl c=cl format=8.2];
                        run adjres(levels[1:f], fconfig, shape(fit`,0,1), 
shape(dev`,0,1), adj);
                        dev = t(shape(adj,0,nrow(fit)));
                        end;

                *-- Chisquare for current model --;
                chisq = chisq(margin,fit);
                df = df(levels[1:f,], fconfig) - sum(mzero=0);
                if df>0 & all(chisq>.0001)
                        then prob = 1 - probchi(chisq,df);
                        else prob = 1;
                if f>1 then run modname(fconfig,vnames,model);
      if any(f=plots) | any(verbose = 'CHISQ') then do;
                        print model
                                        df ' ' chisq[c={'ChiSq'} r={'G.F.' 
'L.R.'} format=9.3]
                                        prob [c={'Prob'} format=8.4];
                        end;

                *-- print fit and deviations matrices;
                reset noname;
                if any(verbose = 'FIT') then do;
                        print 'Marginal totals' ,
                                        margin[r=rl c=cl format=8.0];
                        print 'Fitted frequencies' ,
                                        fit[r=rl c=cl format=8.2];
                        end;
                if prob < .999 & any(f=plots) then do;
                        ltx = {'Pearson residuals' ,
                                        'Likelihood Ratio residuals',
                                        'Freeman-Tukey residuals'}[loc(dtyp={GF 
LR FT})];
                        if (index(devtype,'ADJ') | index(devtype,'STD'))
                                then ltx = 'Adjusted ' + ltx;
                        print (ltx),
                                        dev[r=rl c=cl format=8.2];
                        end;

                *-- Correspondence analysis to reorder this factor?;
                if f>1 & order ^= 'NONE' & missing=0
                        then run corresp( margin, dev, rl, cl);

      *-- Calculate proportions for each row over row totals, allowing
          for 0 margins;
      mar = row( margin );
      margin = margin / ( ( margin[,+] + (0=margin[,+]) )
                            * J(1,levels[f]) );
      if any(verbose = 'FIT') then
         print 'Marginal proportions',
            margin[r=rl  c=cl format=8.4];
 
      *-- Divide boxes for this factor;
      run divide1(levels, margin, boxes, f, whichway);
      reset name;
      if any(verbose = 'BOX') then do;
         bl = shape( (rl || J(rows,cols-1,' ')),rows#cols,1);
         print boxes[r=bl c={'BotX' 'BotY' 'LenX' 'LenY'} format=8.2];
      end;
 
      run  space( levels, boxes, f, dir );
      run labels( levels, vnames, names, f, dir, boxes, labelx, labels 
);
 
      if any(verbose = 'BOX') then
         print labelx[r=labels c={x y 'Angle' 'Height' 'Width'}] ;
 
      *-- display the mosaic for current margins ;
      if any(f=plots) then do;
         if nrow(title) < f
            then titl = title[nrow(title),];
            else titl = title[f,];
         if index(titl, '&MODEL') > 0
            then do;
               modl = compress(model," ,");
               modl = translate(modl,"()()","{}[]");
               call change(titl, '&MODEL', modl);
            end;
         if index(titl, '&G2') > 0
            then do;
               modl = 'G2 (' + trim(left(char(df,4,0))) + ') = '
                                                        + 
trim(left(char(chisq[2],10,2))) ;
               call change(titl, '&G2', modl);
            end;
         else if index(titl, '&X2') > 0
            then do;
               modl = 'X2 (' + trim(left(char(df,4,0))) + ') = '
                                                        + 
trim(left(char(chisq[1],10,2))) ;
               call change(titl, '&X2', modl);
            end;

         *-- ravel dev by rows, so positions match new boxes;
         dev = row( dev );
         run gboxes( boxes, labels, labelx, dev, f, titl, mar );
                        run makemap( boxes, labelx, names, levels, dev, mtab, 
fit, f);
         run gskip;
         end;
 
                mod = model;
                run outstat( vnames, names, levels, dev, mtab, fit, f, 
mod);
      *-- prepare for next factor;
      rows = rows * levels[f];
   end; /* do f=1 to factors */
   finish;
 
start mfit(margin, config, levels, f, fit, status);
   *-- Fit the model given by config to marginal in margin;
                mconfig = (f:1)`;       * n sub f, (f-1), ..., 1 ;
                dim = levels[f:1];
                rows = nrow(margin);
                
                *--turn margin inside-out to match config;
                call marg(loc,cmargin,dim,margin,mconfig);
                call ipf(cfit,status,levels[1:f],cmargin,config);

                *--turn fit inside-out to match margin;
                call marg(loc,fit,levels[1:f],cfit,mconfig);
      fit = shape(fit,rows);
   finish;

start mfix(mzero,fit,margin,mtab);
        *-- Fix up fitted values and margin if missing or structural 
zeros;
*       if missing=0 then return;
        miss = loc(mzero = 0);
        if ncol(miss) > 0 then do;
                fit[miss] = mtab[miss];
                margin[miss] = mtab[miss];
                end;
        finish;
         
start divide1( levels, margin, boxes, f, whichway );
   *-- Divide each old box in proportion to the values in row i
       of margins;
   oldbox = boxes;           /* save previous box locations        */
   ngp = nrow(margin);       /* number of previous marginal totals */
   nit = ncol(margin);       /* number of divisions of each such   */
   free boxes;               /* set up to append new divisions     */
 
   do i= 1 to ngp;                * box we are currently dividing;
      *-- get coordinates of box to divide;
      cx = oldbox[i,1];
      cy = oldbox[i,2];
      lx = oldbox[i,3];
      ly = oldbox[i,4];
      marg = margin[i,];
      p = cusum(marg);            /* cumulative proportions */
      p = 0//shape(p,nit-1,1);
      if whichway=1               /* dividing horizontally  */
         then do;
           thisbox = repeat(cx,nit,1)             ||
                     repeat(cy,nit,1) + ( ly # p) ||
                     repeat(lx,nit,1)             ||
                     repeat(ly,nit,1) # marg` ;
         end;
         else do;                 /* dividing vertically    */
           thisbox = repeat(cx,nit,1) + ( lx # p) ||
                     repeat(cy,nit,1)             ||
                     repeat(lx,nit,1) # marg`     ||
                     repeat(ly,nit,1)     ;
         end;
      boxes = boxes // thisbox ;
   end;
   finish;
 
start space( levels, boxes, f, dir )
      global( verbose, space );
   factors= nrow(levels);
   which  = dir[f];
   *-- determine space available to each variable ;
   ndir   = sum( dir=0 ) || sum ( dir=1 );       * # splits each way;
   vspace = space / ndir;
 
   loc = 1 + which;    /* 1:xspace  2:yspace  */
   units = 1;
   do i = 1 to f;
      if which=dir[i] then units = units * levels[i];
      end;
   units = units-1;
   rows = nrow(boxes) / levels[f];
   scale= J(rows,1) * (0:(levels[f]-1));
   unit =  vspace[loc] / units;
   coord= shape(boxes[,loc], rows, levels[f]);
   coord= coord + scale # unit ;
   boxes[,loc] = shape(coord,nrow(boxes));
   space[loc]  = space[loc] - vspace[loc];
   if any(verbose = 'BOX') then print space vspace units  unit;
   finish;
 
start gboxes( boxes, labels, labelx, dev, fac, title, freq )
      global( shade, verbose, filltype, htext, font, colors, 
                        legend, cellfill, fuzz, name );
   *-- Draw and label the mosaic display --;
   call gopen(trim(name)+char(fac,1,0),0,title);
   *-- locate the 4 corners of each box;
   ll = boxes[,{1 2}];
   lr = boxes[,{1 3}][,+] || boxes[,2] ;
   ul = boxes[,1] || boxes[,{2 4}][,+] ;
   ur = boxes[,{1 3}][,+] || boxes[,{2 4}][,+];
 
   xy = ll || ul || ur || lr;
   max = max(ur[,1]) || max(ur[,2]);
        
   sf  = {100 100} / max;              * scale factor: expand to 100;
   if any(verbose = 'BOX') then
      print max[c={X Y}] sf[c={X Y}];
   window = {-16 -16, 108 108};
   if legend ^= 'NONE' then window[2,]={116 116};
   call gwindow(window);
 
   *-- Set parameters for filling boxes in various fill types;
   lines = {1 3};
   run fillpat(fcolors,fpattern);

        centers = ((ll + ur) / 2) * diag(sf);
        fillmin = max(shade);
        if cellfill ^= 'NONE' then do;
                cfill = cellfill;
                cellfill = scan(cellfill, 1);
                fillmin = scan(cfill, 2,' ');
                if fillmin =' '
                        then fillmin = shade[1];
                        else fillmin = num(fillmin);
                dec = scan(cfill, 3,' ');
                if dec = ' ' then do;
                        if cellfill = 'DEV' 
                                then dec = 1;
                                else dec = 0;
                        end;
                        else dec=num(dec);
                end;
        free cxy txy hxy;
         
   do i=1 to nrow(boxes);
                bwidth = boxes[i,3];
                bheight= boxes[i,4];
      box = shape(xy[i,], 4) * diag(sf);
      *-- Make color and direction of shading reflect deviation
          from model;
      index = 1 + (round(dev[i],.001)<0);
      color = colors[index];
      line  = lines [index];
                if (abs(dev[i])<fuzz) then do;              * fuzz 
residuals;
                        color='BLACK';
                        line = 1;
                        end;   
      fcol= color;
                den   = sum( abs(dev[i]) >= shade );        * shading 
density;
                den   = min(max( 0, den ), 5);              * 0 <= den <= 5  
;
      if filltype ='DRAW' then pat='EMPTY';
      else do;
         if den= 0 then pat = 'EMPTY';               * fill pattern   ;
         else do;
            pat = fpattern[index,den];
            fcol = fcolors[index,den];
         end;
      end;

                *-- Writing something in the cell?  Store locations and 
text;
*               if cellfill ^= 'NONE' & (den>0 | nrow(boxes)<12) then do; 
                if cellfill ^= 'NONE' & (abs(dev[i])>=fillmin | 
nrow(boxes)<12) then do; 
         cxy = cxy // centers[i,];
                        bxy = bxy // (bwidth || bheight);
                        hxy = hxy // den;
                        if cellfill = 'SIGN'
                                then do;
                                        txy = txy // substr(({'+++++','-----
'}[index]),1,max(1,den));
                                        end;
                        else if cellfill = 'SIZE'
                                then do;
                                        txy = txy // ({'+','-'}[index]);  
                                        end;
                        else if cellfill = 'DEV' then do; 
                                txy = txy // compress(char(dev[i], 6, dec));
                                end;
                        else do; /* cellfill = 'FREQ' */
                                txy = txy // compress(char(freq[i], 6, dec));
                                end;
      end;
                *-- Draw and fill the box;              
      call gpoly( box[,1], box[,2], line, color, pat, fcol);
   end; * <---- loop over boxes;
        
   if filltype='DRAW' then run fillbox(boxes,dev,sf);

        *-- Adding cellfill annotations? ;
        if cellfill ^= 'NONE' & nrow(txy)>0 then do;
                cht = j(nrow(txy), 1, htext);
                if cellfill = 'SIGN' then cht = 1.2 # cht;
                if cellfill = 'SIZE' then cht = cht # hxy;
                do i=1 to nrow(txy);
                        call gstrlen(wid, txy[i], cht[i]);  
                        call gstrlen(dep, '+', cht[i]);
                        w = w // (wid || dep);
                        /*
                        if (wid < bxy[i,1]) & (dep < bxy[i,2]) then do;
                        call gpie(cxy[i,1], cxy[i,2], wid/2, 0, 360, 
'WHITE',, 'SOLID');
                        end;
                        */
                        cellclr = {'BLACK' 'WHITE'}[1+(hxy[i]>=2)];
                        sx = cxy[i,1]-wid/2;
                        sy = cxy[i,2]-dep/2;
                        call gscript(sx, sy, txy[i], 0, 0, cht[i], , 
cellclr);
                end;
      if any(verbose='BOX') then do;
                        print "cellfill labels", cxy[f=7.2] txy w[f=7.2] cht 
bxy[f=6.1];  
      end;
        end;
         
   do f=1 to nrow(labels);
      angle  = labelx[f,3];
      height = labelx[f,4];
      if angle = 0 then scale = diag(sf[,1] || {1});
                   else scale = diag({1} || sf[,2]);
      lxya = labelx[f,1:2] * scale;
      labl = labels[f ];
      call gscript( lxya[,1], lxya[,2], labl, angle, 0, height, font);
   end;

        *-- Draw the title;
   if length(title)>1 then do;
      height = max(htext+.1, 1.6);
      call gstrlen(len, title, height, font);
      if len > 110 then do;
         height = height # .1 # int(10 # 110 / len);
         call gstrlen(len, title, height, font);
         end;
      tx = (100 - len)/2;
      call gscript(tx, 104, title, 0, 0, height, font);
   end;

   run glegend(fcolors, fpattern);
   call gshow;
   finish;
 
start fillpat(fcolors, fpattern)
      global(filltype, shade, colors);
   *-- Set colors and patterns for shading  mosaic tiles;
   ns = ncol(shade);
   if ns<5
      then dens=char({1 3 4 5}[1:ns]`,1,0);
      else dens={'1' '2' '3' '4' '5'};
   fpattern = J(2,ns,'EMPTY   ');
   if ncol(colors)=1 then colors=shape(colors,1,2);
   colors = substr(colors[,1:2] + repeat('       ',1,2),1,8);
   fcolors = repeat(colors[1],1,ns) // repeat(colors[2],1,ns);
 
   if ncol(filltype)=1 then      /* if only one filltype */
      do;
         if filltype='M0'  then filltype={M0 M90};
         else if filltype='M45' then filltype={M135 M45};
                        else if filltype='LR' then 
filltype=cshape(filltype,2,1,1);
         else filltype=shape(filltype,1,2);
      end;
 
   do dir=1 to 2;                 * for + and - ;
      ftype = filltype[dir];      * fill type for this direction;
      if substr(ftype,1,1)='M' then
         do;
            angle = substr(ftype,2);
            if angle=' ' then angle='0';
            if ns=2 then fpattern[dir,] = {M1N M1X}+angle;
               else fpattern[dir,] = {M1N M3N M3X M4X 
M5X}[1:ns]`+angle;
         end;
      else if ftype='L' | ftype='R' then
            fpattern[dir,] = trim(ftype)+dens;
      else if substr(ftype,1,4)='GRAY' then
         do;
            if length(ftype)=4
               then step=16;
               else step = num(substr(ftype,5));
            dark = 256 - step#(1:ns)`;
            *-- convert darkness values to hex;
            fcolors = substr(fcolors,1,max(6,length(fcolors)));
            fcolors[dir,] = compress('GRAY'+hex(dark)`);
            fpattern[dir,] = repeat('SOLID',1,ns);
         end;
      else if substr(ftype,1,3)='HLS' then
         do;
         /* lightness steps for varying numbers of scale values */
         step={ 0 100 0 0 0,
               0 40 100 0 0,
               0 25 60 100 0,
               0 20 45 70 100}[max(1,ns-1),];
         /* make step=100 map to '80'x, =0 map to 75% of the way to 
'FF' */
         step =  25 + 0.75#step;
         step = step[1:ns]#255/100;
                        dark = 255-ceil(step/2);
         lval= hex(dark)`;

         clr = upcase(colors[dir]);
         hue = {RED GREEN BLUE MAGENTA CYAN YELLOW,
               '070' '100' '001' '03C' '12C' '0B4'  };
         col = loc(hue[1,]=clr);
         if ncol(col)=0 then col=dir;
         hval= hue[2,col];
          fcolors[dir,] =  compress('H'+hval+lval+'FF');
         fpattern[dir,] = repeat('SOLID',1,ns);
         end;
      end;
   finish;
 
start hex(num);
   *-- Convert 0<num<256 to hex;
   chars = cshape('0123456789ABCDEF',16,1,1);
   if num>255 then num = mod(num,256);
   h = rowcat(chars[1+floor(num/16),] || chars[1+mod(num,16),]);
   return(h);
   finish;
   
start glegend( fcolors, fpattern )
      global( shade, htext, colors, legend, font );
   *-- Draw legend indicating color/shading for standardized residuals;
   if legend='NONE' then return;
   ns = ncol(shade);
   values = ( -shade[ns:1]` ) ||{-.01} ||.01 || shade;
   cval = trim(char(values,3,0));
   nv = ncol(values);
   w = 8;            * width of legend box;
   s = 3;            * spacing between boxes;
   if ns>3 then do; w=7; s=2; end;
   label = {'Standardized' 'residuals:'};
   call gset('font',font);
   call gset('height',htext);
   call gstrlen(len,label);
   if legend = 'H' then
      do;
         y = {-11 -16};
         x = (100+s-(s+w)#nv) + w #(0:nv);
         call gscript(min(x)-len-3, y[1]-{2 5},label,0);
      end;
   else do;
         x = {107 112};
         y = (100+s-(s+w)#nv) + w #(0:nv);
         call gscript(x[1]+{2 5}, min(y)-len-3,label,90);
      end;
 
   do i = 1 to nv;
      sign = 1 + (values[i]<0);
      line={1 3}[sign];
      color = colors[sign];
      den = sum( abs(values[i]) >= shade );
      if den= 0 then pat = 'EMPTY';               * fill pattern   ;
      else do;
         pat = fpattern[sign,den];
         fcol = fcolors[sign,den];
         end;
      if legend='H' then
         do;
            xx = x[i]+ ({0 0}|| w || w) + s#(i-1);
            yy = y[{1 2 2 1}];
         end;
      else do;
            yy = y[i]+ ({0 0}|| w || w) + s#(i-1);
            xx = x[{1 2 2 1}];
         end;
      call gpoly( xx, yy, line, color, pat, fcol);
      if i=1 then             label = '<'+cval[i];
         else if i=nv then    label = '>'+cval[i];
         else if i<=ns+1 then label=cval[i-1]+':'+cval[i];
         else                 label=cval[i]+':'+cval[i+1];
      label = compress(label);
      call gstrlen(len,label);
      if legend='H' then
         do;
            xx = xx[1]+max(0,((xx[3]-xx[1])-len)/2);
            yy = yy[1]+1;
            angle = 0;
         end;
      else do;
            yy = yy[1]+max(0,((yy[3]-yy[1])-len)/2);
            xx = xx[3]+3;
            angle = 90;
         end;
      call gscript(xx,yy,label,angle);
   *print xx yy label len;
   end;
   finish;
 
start labels( levels, vnames, names, f, dir, boxes, labelx, labels )
      global( htext, font, verbose, vlabels );
   *-- generate positions of labels for this factor;
   k = levels[f];
   which = dir[f];
   factors = nrow(levels);
   loc = which + 1;                  /* 2=x, 1=y */
   box = boxes[(1:k),];
 
   str = shape(names[f,],k,1);
   line= sum(which=dir[1:f]);
   call gset('font', font);
   ht = htext - .1 * (line-1);
   call gstrlen( len, str, ht );
 
   *-- Position of labels along the baseline, centering if possible;
   wid = box[,loc+2];
   pos = box[,loc]          /*   center     rt justify */
          + choose( (len<=wid), (wid-len)/2, (wid-len) );
 * end = pos + len;
   if any(verbose = 'BOX') & 
           any(len/(wid+.01) > 1.5) then
      print 'Overfull label', str len wid pos;
   if pos[1]+len[1] > pos[2] then
      pos[1] = min(pos[1],box[1,loc])-1;
   do i=2 to nrow(len);     /* check for overlap of labels */
      if (pos[i] < pos[i-1]+len[i-1])
 /*     |(pos[i] < box[i,loc]) */ then do;
         if i<nrow(len) then do;
            if box[i,loc]+len[i] < pos[i+1] then pos[i] = box[i,loc];
            end;
         else pos[i] = max(box[i,loc],pos[i-1]+len[i-1]+1);
         end;
      end;
 
   *-- Baseline of labels for this factor;
   lines= sum(which = dir);
   sep = choose( (factors<=6), 1, .5);
   base =   3.5*line - 4*(lines+sep) + 2*(loc-1.5);
 
   lx = j(k,5,0);                      /*  1 | 0 : which */
   lx[,2-which] = base;                /*  x | y  */
   lx[,1+which] = pos;                 /*  y | x  */
   lx[,3] = {0 90}[loc];               /*  angle  */
   lx[,4] = ht;                        /*  height */
   lx[,5] = len;                       /*  length */

   if any(factors = vlabels) then do;      *-- variable names;
      ht = ht + .2;
      call gstrlen(len,vnames[f],ht);
      pos = ( max(box[,loc]+wid) - len)/2;
      base= base - 4;
      lx = lx // ( (pos || base || {0} || ht || len) //
                   (base|| pos  || {90}|| ht || len) )[loc,];
      str= str// vnames[f];
      end;
 
   labelx = labelx // round(lx,.01);
   labels = labels // str ;
   finish;
 
start fillbox(boxes, dev, sf)
      global(shade, verbose, colors);
   if ncol(shade)=1 then shade=shade`;
   *-- fill density proportional to number of shading levels
       equalled or exceeded by deviation;
   d = shape(dev,nrow(boxes),1);
   fill = ( (abs(d)*J(1,ncol(shade)))  >=
            repeat(shade,nrow(d),1) )[,+];
 
   *-- fill each box proportional to abs(fill);
   w = boxes[,3] # sf[1];
   h = boxes[,4] # sf[2];
   s =  choose( fill=0, 1000, 4 / abs(fill) );
 
   nxl = int((w-.5)/s);
   nyl = int((h-.5)/s);
   if any(verbose = 'BOX') then
      print 'Width, Height, Square', w h s fill nxl nyl;
   lines = {1 2};
   do i = 1 to nrow(boxes);
      index = 1 + (round(dev[i],.001)<0);
      color = colors[index];
      line  = lines [index];
      if nxl[i]>0 then do;
         from  =(((boxes[i,1] + (1:nxl[i]) # s[i]))`||
                 shape(boxes[i,2], nxl[i], 1))         * diag(sf);
         to    =
                (((boxes[i,1] + (1:nxl[i]) # s[i]))`||
                 shape(sum(boxes[i,{2 4}]), nxl[i], 1))* diag(sf);
         call gdrawl( from, to, line, color );
      end;
      if nyl[i]>0 then do;
         from  =(shape(boxes[i,1], nyl[i], 1) ||
                 ((boxes[i,2] + (1:nyl[i]) # s[i]))`)  * diag(sf);
         to    =(shape(sum(boxes[i,{1 3}]), nyl[i], 1) ||
                 ((boxes[i,2] + (1:nyl[i]) # s[i]))`)  * diag(sf);
         call gdrawl( from, to, line, color );
      end;
   end;
   finish;
 
start reduce(config, f);
   * find loglin config including only factors 1:f ;
   con = config;
   do i=1 to ncol(con);
      term = con[,i];
      if any(term > f) then term = remove(term, loc(term > f));
                if ncol(term) = 0
                        then con[,i] = j(nrow(config), 1, 0);
                        *-- next line would fail if term is now empty;
        else con[,i] = shape(term, nrow(config), 1, 0);
      end;
 
   *-- delete any all-zero rows and cols;
   r = con[+,];
   con = con[,loc(r>0)];
   r = con[,+];
   con = con[loc(r>0),];
 
   *-- rearrrange in order of increasing complexity;
   if ncol(con) > 1 then do;
      orders = (con ^=0)[+,];
      r = rank(orders);
      noc = con;
      con[,r] = noc;
 
      *-- remove terms which are marginal to those later;
      keep = j(1,ncol(con));
      do i = 1 to ncol(con)-1;
         ci = con[,i];
         if any(ci=0) then ci = remove(ci,loc(ci=0));
 
         do j = i+1 to ncol(con);
            cj = con[,j];
            if any(cj=0) then cj = remove(cj,loc(cj=0));
            if ncol(unique(ci,cj)) = ncol(unique(cj)) then keep[i]=0;
            end;
         end;
      con = con[,loc(keep)];
      end;  /* ncol(con)>1 */
   *-- delete any all-zero rows;
   r = con[,+];
   con = con[loc(r>0),];
   return(con);
   finish;
 
start chisq(obs, fit);
   *-- Find Pearson and likelihood ratio chisquares;
   gf = sum ( (obs - fit)##2 / ( fit + (fit=0) ) );
   lr = 2 # sum ( obs # log ( (obs+(obs=0)) / (fit + (fit=0)) ) );
   return (gf // lr);
   finish;
 
start terms(dim, config);
   *-- transform ipf config into list of terms in loglinear model;
   *   returns a matrix with ncol(dim) columns.  Each row is the
       indices of one term in the model;
   nv = nrow(dim);    * number of variables;
   nm = ncol(config); * number of margins in model;
   max= 2##nv - 1;
   do i = 1 to max;
      t = vars_in(i,nv);
      do j = 1 to nm;
         c = config[,j]`;
         *-- are all elements of t contained in this margin? ;
         if ncol(unique(t,c))  = ncol(unique(c))
            then do;
            terms = terms // shape(t,1,nv,0);
            goto next;
            end;
         end;
 next:
      end;
      return (terms);
 
   finish;
 
start vars_in(num,nv);
   *-- determine variables represented by a number from 1...2##nv-1,
       considered as a binary number;
   n = num;
   do i=1 to nv;
      if mod(n,2)=1 then r = r || i;
      n = int(n/2);
      end;
   return ( r );
   finish;
 
start df(dim,config);
        if all(config=1) then return(dim[1]-1);
   terms = terms(dim,config);
   nc = dim[#];         /* number of cells */
   nt = nrow(terms);    /* number of marginal terms */
   np = 0;
   *-- find number of parameters fitted in each term;
   do i = 1 to nt;
      t = terms[i,];
      t = t[,loc(t>0)];
      np= np + (dim[t]-1)[#];
      end;
   df = nc - np - 1;
   return(df);
   finish;
 
start modname(config,names,model) global(abbrev);
   *-- Expand IPF config into symbol for loglinear model;
   free model;
   brackets = {'{' '}'};
   vars = 0;
   do i = 1 to ncol(config);
      vars = unique(vars,config[,i]);
      end;
   if ncol(vars) > nrow(names) then brackets = {'[' ']'};
   do i = 1 to ncol(config);
      effect = config[,i];
      effect = effect[loc(effect>0)];
      term = '';
      do j = 1 to nrow(effect);
         if term ^= '' then
         term=trim(term)+ ',';
                        if abbrev=0
                then term = term + names[ effect[j,] ];
                                else term = term + substr(names[ effect[j,] 
],1,abbrev);
         end;
      term = brackets[1] + trim(term) + brackets[2];
      model= model || term;
   end;
   model = rowcatc(model);
   model = substr(model, 1, length(model));
   finish;
 
*-- Module for correspondence analysis for reordering table categories.
         At present, this analysis merely suggests an ordering, but does 
not
    actually reorder the table or the mosaic display;
         
start corresp( margin, dev, rl, cl)
                global(order);
                
        r = margin[,+];
        c = margin[+,];
        n = sum(margin);
        if (any(order='DEV')) then do;
                *-- use residuals from current model;
                d = shape(dev, nrow(margin), ncol(margin));
                dpd = t(d)*d / n;
                end;
        else do;
                *-- fit joint independence model for current col variable;
                e = r * c / n;
                d = (margin - e) / sqrt(e);
                dpd = t(d)*d / n;
                end;

   call eigen(values, vectors, dpd);
   k = min(nrow(margin), ncol(margin))-1; * number of non-zero 
eigenvalues;
   values  = values[1:k];
   cancorr = sqrt(values);        * singular values = Can R;
   chisq = n * values ;           * contribution to chi-square;
   percent = 100* values / trace(dpd);
        cum = cusum(percent);
        
   print 'Singular values, and Chi-Square Decomposition',,
         cancorr [colname={'Singular Values'} format=9.4]
         chisq   [colname={'Chi-Squares'}     format=9.3]
         percent [colname={'Percent'}         format=8.2]
         cum     [colname={' Cum % '}         format=8.2];

        *-- Find Dim1 scores for row/col categories;
   L = values[1];
   U = vectors[,1];
   Y = diag(1/sqrt(C/N)) * U * diag(sqrt(L));
   X = diag(N/R) * (margin / N) * Y * diag(sqrt(1/L));

        d = dev;
        row = rl;
        col = cl[,1:ncol(margin)];
        *-- sort rows and cols of dev by corresp dimensions1;
        if (any(order='ROW')) then do;
                rx = rank(X);
                t = d;
                d[ rx, ] = t;
                t = row;
                row[ rx, ] = t;
                t = X;
                X[ rx ] = t;
                end;
                
        if (any(order='COL')) then do;
                ry = rank(Y);
                t = d;
                d[, ry] = t;
                t = col;
                col[ ,ry ] = t;
                t = Y;
                Y[ ry ] = t;
                Y = t(Y);
                perm = ry`;
                perm[ , ry] = 1:ncol(Y);
                if ncol(Y)>2 & cum[1]>.5 then
                        print 'Suggested permutation of levels of this 
variable is',
                                perm[c=col];
                end;
                
        print 'Residuals, bordered by Row and Column Scores on CA 
Dimension 1',
                        'Reordered by' order;
        print d [r=row c=col format=7.2] X[c={'RowDim1'} f=7.2], 
                        Y[r={'ColDim1'} f=7.2]; 
        finish;

*-- Modules for data input;
  /* ------------------------------------------------------------------
--
   Routine to read frequency and index/label variables from a SAS 
dataset
   and construct the appropriate levels, and lnames variables

   Input:  dataset - name of SAS dataset (e.g., 'mydata' or 
'lib.nydata')
           variable - name of variable containing frequencies
             vnames - character vector of names of index variables
   Output: dim (numeric levels vector)
           lnames (K x max(dim)) 
  --------------------------------------------------------------------
*/
 
start readtab(dataset, variable, vnames, table, dim, lnames);
        if type(vnames)^='C'
                then do;
                        print 'VNAMES argument must be a character vector';
                        show vnames;
                        return;
                end;            
   if nrow(vnames)=1 then vnames=vnames`;

        call execute('use ', dataset, ';');
        read all var variable into table;
        run readlab(dim, lnames, vnames);
        call execute('close ', dataset, ';');
        reset noname;
        print 'Variable' variable 'read from dataset' dataset,
                'Factors:        ' (vnames`),
                'Levels ordered: ' vnames lnames;
        reset name;
        finish;

/* Read variable index labels from an open dataset, construct a dim 
   vector and lnames matrix so that variables are ordered correctly
   for mosaics and ipf (first varying most rapidly).

        The data set is assumed to be sorted by all index variables.  If
        the observations were sorted by A B C, the output will place
        C first, then B, then A.
   Input:    vnames (character K-vector)
 */

start readlab(  dim, lnames, vnames);
        free span lnames dim;
        nv = nrow(vnames);

        spc = '        ';
        do i=1 to nv;
                vi = vnames[i,];
                read all var vi into cli;
                if type(cli) = 'N'
                        then do;
                                tmp = trim(left(char(cli,8)));
                                tmp = substr(tmp,1,max(length(tmp)));
                                cli = tmp;
                                end;  
                cli = trim(cli); 
                span = span || loc(0=(cli[1,] = cli))[1];
                d=design( cli );
                dim = dim || ncol(d);
                free row1;
                *-- find position of each first distinct value;
                do j=1 to ncol(d);
                        row1 = row1 || loc(d[,j]=1)[1];
                        end;
        *               print vi cli d;
        *               print row1;
                *-- sort elements in row1 so that var labels are in data 
order;
                order = rank(row1);
                tmp = row1;
                row1[,order]=tmp;       

                li = t(cli[row1]);
                if i=1 then lnames = li;
                        else do;
                                if ncol(lnames) < ncol(row1) 
                                        then lnames=lnames || repeat(spc, i-1, 
ncol(row1)-ncol(lnames));
                                if ncol(lnames) > ncol(row1)
                                        then li = li || repeat(spc, 1, 
ncol(lnames)-ncol(li));
                                lnames = lnames // li;
                        end;
                end;
        *       print span;
        *-- sort index variables by span so that last varies most slowly;
        order = rank(span);
        tmp = span;
        span[,order] = tmp;
        tmp = dim;
        dim[,order] = tmp;
        tmp = lnames;
        lnames[order,] = tmp;
        tmp = vnames;
        vnames[order,] = tmp;
        *       print dim lnames vnames;
        finish;

*-- backward compatibility [reorder -> transpos] (until the next 
release);
start reorder(dim, table, vnames, lnames, order);
        run transpos(dim, table, vnames, lnames, order);
        finish;

start transpos(dim, table, vnames, lnames, order);
   *-- Reorder the dimensions of an n-way table.  Order is a 
permutation
            of the integers 1:ncol(dim), such that order[k]=i means that
                 dimension k of the array table becomes dimension i of the 
result.
                 Alternatively, order can be a character vector of the 
names
                 of variables (vnames) in the new order.
   *   Note: to restore a reordered table to its original form, use
                 the anti-rank of the original order;
   *-- Use to rearrange the table prior to calling mosaics;
                 
   if nrow(order) =1 then order=order`;
        if type(order)='C' then do k=1 to nrow(order);
                ord = ord // loc(upcase(order[k,]) = upcase(vnames));
                end;
        else ord = order;

        *-- Dont bother if order = 1 2 3 ... ;
        if all( row(ord)=1:ncol(row(ord)) ) then return;

   if nrow(dim  ) =1 then dim  =dim`;
   if nrow(vnames)=1 then vnames=vnames`;
   call marg(loc,newtab,dim,table,ord);
   table = row(newtab);
   dim = dim[ord,];
   vnames = vnames[ord,];
   lnames = lnames[ord,];
        finish;

start row (x);
   *-- function to convert a matrix into a row vector;
 
   if (nrow(x) = 1) then return (x);
   if (ncol(x) = 1) then return (x`);
   n = nrow(x) * ncol(x);
   return (shape(x,1,n));
        finish;

/*--------------------------------------------------------------*
 |  IML module to handle multiple output EPS files (or other    |
 |  device-dependent multiple plot circumstances).              |
 |  - This implementation requires a macro variable, DEVTYP to  |
 | be set.  Initialize the FIG variable to 1.  
 *--------------------------------------------------------------*/
*global fig gsasfile devtyp;
start gskip;
        call execute('_dev_ = upcase("&DEVTYP");');
        call execute('_disp_ = "&DISPLAY";');
        if upcase(trim(_disp_)) ^= 'OFF' then do;
        if (_dev_ = 'EPS') | (_dev_ = 'GIF') then do;
                _dev_ = lowcase(_dev_);
                call execute('%let fig = %eval(&fig + 1);');
                call execute('%let gsas = %scan(&gsasfile,1,.)&fig..', 
_dev_, ';');
                call execute('%put NOTE: gsasfile now: &gsas;');
                call execute('filename gsas&fig  "&gsas";');
                call execute('goptions gsfmode=replace gsfname=gsas&fig;');
                free _dev_ _disp_;
        end;
        end;
        finish;

/*  Dummy makemap module (replaced by weblet) */
start makemap( boxes, labelx, lnames, levels, dev, margin, fit, f)
        global(legend, verbose);
        dummy=1;
        finish;

/*  Translate a character matrix MAT to a numeric matrix of
    the indices of each element in a vector of NAMES.
         Returns a numeric matrix of the same shape as MAT  */
start name2num(mat, names);
        new = j(nrow(mat), ncol(mat), 0);
        do i=1 to nrow(mat);
                do j=1 to ncol(mat);
                        l = loc(trim(upcase(mat[i,j])) = upcase(names));
                        if type(l)^='U' then new[i,j] = l;
                        end;
                end;
        return(new);
        finish;

start adjres( dim, config, m, res, adj);
        *-- Calculate adjusted residuals for a loglin model;
        
        run cdesign(dim, config,  x );        /* get design matrix */
        D = diag(m);
        S = inv( t(X) * D * X);               /* cov(beta) */
   V = (sqrt(D) * x)`;

         *-- compute leverage, faster than vecdiag(V` * S * V);
        C = t(V)*S  ;                         /* catcher matrix */
        lev = (C#t(V))[,+];                   /* leverage  */

   se  = sqrt(1 - lev);                  /* std errors of resids */
   adj = res / se;                       /* adjusted residuals */
*       print m[f=6.3] lev[f=6.3] res[f=6.3] adj[f=6.3] se[f=6.3];
        finish;

start cdesign(dim, config, x);
   *-- Find (full rank) design matrix, X, from IPF configuration;
   if nrow(dim)=1 then dim = dim`;
   terms = terms(dim,config);
   nc = dim[#];               /* number of cells */
   nt = nrow(terms);          /* number of marginal terms */

   free x;
   *-- construct cols of X matrix for each term;
   do i = 1 to nt;
      t = terms[i,];
      t = t[,loc(t>0)];                /* find vars in this term */
      xi= 1;
      do j=1 to nrow(dim);
         if any(j=t) then do;          /* is variable j in the term?*/
            xj = designf( (1:dim[j])` ) ;
            end;
         else xj = j(dim[j],1) ;
         xi = xj @ xi;
         end;
      x = x || xi;
      end;
   x = j( nrow(x), 1) || x;
   finish;

start outstat( vnames, lnames, levels, dev, margin, fit, f, mod)
        global(outstat);
        
        if outstat='' then return;
        
        do i=1 to f;
      cl = lnames[i,]`;
      if i=1 then do;
                                rl=cl;
                                ml=cl[1:(levels[i])];
                                end;
         else do;        /* construct row labels for prior factors */
            ol = repeat(rl, 1, levels[i]);
                                ml = repeat(ml, (levels[i]), 1);
            ol = shape(ol,  levels[i]#nrow(rl), 1);
            nl = repeat( (cl[1:(levels[i])]), nrow(rl));
            rl = trim(rowcatc(ol || shape(':',nrow(ol),1) ||nl));
                                ml = ml || nl;
         end;
                end;
        labels = rl+ '                                          ';
        residual  = shape(dev, nrow(dev)#ncol(dev), 1);
        fitted = shape(fit, nrow(fit)#ncol(fit), 1);
        freq = shape(margin, nrow(margin)#ncol(margin), 1);
        factors = shape(f, nrow(fit)#ncol(fit), 1);
        model = shape(mod, nrow(fit)#ncol(fit), 1)+'                   ';
        
        vn = rowcat(row(vnames)+' '); 
        vn = vn + ' factors labels residual fitted freq model';
        
        *-- create all the factor variables;
        do i=1 to ncol(row(vnames));
                if i<= ncol(ml)
                        then call execute( vnames[i], '= ml[,i];');
                        else call execute( vnames[i], '= "        ";');
                end;


        *print 'Outstat', factors labels freq fitted residual;
        if f=1 then do;
                call execute('%let outstat=', outstat, ';');
/*
                call execute("create &outstat var{factors labels freq 
fitted residual model};");
*/
                call execute("create &outstat var{", vn,  "};");
                end;
        append;
        finish;


/*--------------------------------------------------------------------*
 | MOSAICM SAS                                          Version 3.4   |
 |  IML modules for general n-way mosaic display of contingency table.|
 |  This program creates and stores the modules in the IML storage    |
 |  library, MOSAIC.MOSAIC                                            |
 *--------------------------------------------------------------------
*/
title 'Install mosaic modules';
*-- Change the path in the following filename statement to point to
    the installed location of mosaics.sas;
*filename mosaics  'c:\sasuser\mosaics';
filename mosaics  '~/sasuser/mosaics/';
*--- Change the path in the libname to point to where the compiled
    modules will be stored, ordinarily the same directory;
*libname  mosaic   'c:\sasuser\mosaics';
libname  mosaic   '~/sasuser/mosaics/';

proc iml ;
   *-- Install mosaics.sas as compiled modules;
   reset storage=mosaic.mosaic;
   %include mosaics(mosaics) ;
   store module=_all_;
   show storage;
quit;

/*--------------------------------------------------------------------*
 | MOSAICD SAS                                                 3.4    |
 |  IML modules for general n-way mosaic display of contingency table.|
 |  This version uses externally calculated cell residuals (dev)      |
 *--------------------------------------------------------------------*
 | Usage:                                                             |
 |  proc iml;                                                         |
 |   %include mosaicd;                                                |
 |   shade = {   }; space = {   }; verbose = ;  see global inputs     |
 |   run mosaicd(levels, table, vnames, lnames, dev, title);          |
 | where:                                                             |
 |   levels    Vector of number of levels of each factor              |
 |   table     Table of cell frequencies, as in IPF: first factor     |
 |             varies most rapidly along cols, last factor varies     |
 |             most slowly down the rows.  If elements of table are   |
 |             a single variable in a SAS data set (e.g., output from |
 |             PROC FREQ), with factors={A B C}, the rows (obs.)      |
 |             should be sorted BY C B A to obtain IPF ordering.      |
 |                                                                    |
 |   vnames    Vector of factor names, order corresponding to levels  |
 |   lnames    Matrix of level names: rows=factors, cols=max(levels)  |
 |             lnames[i,1:levels[i]] gives level names for factor i.  |
 |                                                                    |
 |   dev       Deviations from model                                  |
 |   title     Character string title for plots                       |
 |                                                                    |
 | Global input variables (optional)                                  |
 |   filltype  Type of fill pattern to use for shading.               |
 |               'LR'  --> patterns Ld, Rd, where d=density value     |
 |               'M0'  --> patterns MdN0, MdN90                       |
 |               'M45' --> patterns MdN135, Md45 [default]            |
 |   htext     Height of text labels [default: 1.3]                   |
 |   shade     Vector of up to 5 values of abs(dev[i]) for boundaries |
 |             between shading levels. If shade={2 4}; (the default), |
 |             then shading density is:                               |
 |                   0 <= |dev[i]| < 2  ->  0 (empty)                 |
 |                   2 <= |dev[i]| < 4  ->  1                         |
 |                   4 <= |dev[i]|      ->  2                         |
 |             Use shade= a big number to suppress all shading.       |
 |   space     2-vector of x,y: amount of plotting area reserved for  |
 |             spacing. Typically {20 20}.                            |
 |   verbose   Controls verbose or detailed output                    |
 *--------------------------------------------------------------------*
 *  Author:  Michael Friendly            <friendly@yorku.ca>          *
 * Created:  11 Aug 1990 10:27:11          (c) 1990, 1991             *
 * Revised:  13 May 1998 09:00:11                                     *
 * Version:  3.4                                                      *
 *--------------------------------------------------------------------
*/
*title 'Mosaic displays for externally-fitted models';
*version(6.06);  *-- Requires SAS Version 6.06 or later;
 
*proc iml;
start mosaicd(levels, table, vnames, lnames, dev, title)
      global(config, devtype, fittype, filltype, shade, space, split,
             legend, colors, htext, font, verbose, cellfill, order, 
zeros);
 
   if nrow(vnames)=1 then vnames=vnames`;
   if nrow(levels)=1 then levels=levels`;
   print / '+-------------------------------------------+',
           '|  Specialized Mosaic Display, Version 3.4  |',
           '+-------------------------------------------+',,
           title, vnames levels '  ' lnames;
 
   *-- Check conformability of arguments --;
   f = nrow(vnames)||nrow(lnames);
   if ^all(f = nrow(levels))
      | levels[#] ^= nrow(table)#ncol(table)
      then do;
         print 'Arguments not conformable'; show levels table;
         goto done;
      end;
 
        run globals;    
        reset name;
   print 'Global options', filltype split
                           shade[f=3.0] colors ,htext
                                                                        font legend 
cellfill verbose;
   f = nrow(levels);
   whichway = num(translate(split,'10','HV'));
   dir = shape(whichway,f,1);
   if type(space) ^= 'N'
      then space = 10# (sum(dir=0) || sum(dir=1));
   savspace = space;
        savedev = dev;
         
   call gstart;
   *-- divide the plot into boxes  --;
   run divided(levels, table, vnames, lnames, dev, dir, title);
   call gstop;
   space = savspace;
        dev = savedev;
   done:
   finish;
 
start divided(levels, table, vnames, names, dev, dir, title)
      global(shade, space, verbose);
   *-- start with origin in lower left corner --;
   length= {100 100};                /* x,y length of box area */
   boxes = {0 0}                     /* lowerleft  x,y  */
         ||( length - space );       /* length     x,y  */
   factors = nrow( levels );
   rows = 1;                 /* number of rows in margins */
   do f = 1 to factors ;
      whichway =dir[f];
      cols = levels[f];      /* number of cols in margins */
      reset noname;
      print "Factor:" f (vnames[f]);
      reset name;
      mconfig = (f:1)`;       * n sub f, (f-1), ..., 1 ;
      call marg(loc,margin,levels,table,mconfig);
 
      *-- Construct row and column labels for marginal table;
      cl = names[f,];
      if f=1 then rl='';
         else do;        /* construct row labels for prior factors */
            ol = repeat(rl, 1, levels[f-1]);
            ol = shape(ol,  levels[f-1]#nrow(rl), 1);
            nl = repeat((names[f-1,1:(levels[f-1])])`, nrow(rl));
            rl = concat(ol,nl);
         end;
      margin = (shape(margin, rows)) ;
      print 'Marginal totals', margin[r=rl c=cl ];
 
      *-- Calculate proportions for each row over row totals, allowing
          for 0 margins;
      mar = row( margin );
      margin = margin / ( ( margin[,+] + (0=margin[,+]) )
                            * J(1,levels[f]) );
      *-- Divide boxes for this factor;
      run divide1(levels, margin, boxes, f, whichway);
 
      if any(verbose = 'BOX') then do;
         bl = shape( (rl || J(rows,cols-1,' ')),rows#cols,1);
         print boxes[r=bl c={'BotX' 'BotY' 'LenX' 'LenY'} format=8.2];
      end;
 
      run  space( levels, boxes, f, dir );
      run labels( levels, vnames, names, f, dir, boxes, labelx, labels 
);
 
      if any(verbose = 'BOX') then;
      print labelx[r=labels c={x y 'Angle' 'Height'}] ;
 
      *-- display the mosaic for current margins ;
      if f=factors then do;
         *-- at this point the marginal table has been turned inside-
out;
         *   so, dev must be reordered to match. However, MARG chokes 
on
             values < 0, so subtract minimum value, then add it back;
         mdev = min(dev);
         run marg(loc,newdev,levels, dev-mdev, mconfig);
         dev = newdev + mdev;
*?????   dev = shape( dev,1,(nrow(dev)#ncol(dev)) );
         call gboxes( boxes, labels, labelx, dev, f, title, mar );
         run gskip;
         end;
 
      *-- prepare for next factor;
      rows = rows * levels[f];
   end;
   finish;
 
*reset storage=mosaic.mosaic;
*store module=_all_;
*show storage;

/*  Name:  mosdata.sas
   Title:  Assorted contingency table data sets for mosaic displays
*/

/*
  Running this program creates a SAS/IML storage catalog named
  MOSAIC.MOSDATA.  It is assumed that the libref MOSAIC has been
  defined, e.g., as follows:
libname mosaic   'c:\sasuser\mosaics';         *-- Windows ;
*/
libname mosaic '~/sasuser/mosaics';            *-- Unix    ;

/*
  To use one with mosaics,

  proc iml;
     reset storage=mosaic.mosaic;
     load module=_all_;
     reset storage=mosaic.mosdata;
     load module=bartlett;
     run bartlett;
     ...
*/
proc iml;

start bartlett;
   data='bartlett';
   dim = {2 2 2};
   title="Bartlett data";
        source='Bartlett, 1935, JRSS';
   table = {156 84 84 156,
            107 133 31 209};
   vnames= {'Alive?' 'Time' 'Length' ,
            'A' 'T' 'L'};
   vnames = vnames[1,];
   lnames= {'Alive' 'Dead',
            'Now' 'Spring',
            'Long' 'Short'};
   finish;

start berkeley;
   data='berkeley';
   title='Berkeley Admissions Data';
        source='Bickel-etal:75';
   dim = {2 2 6};
   vnames = {"Admit" "Gender" "Dept"};
   lnames = {"Admitted" "Rejected" " "  " "  " "  " ",
             "Male"  "Female" " "  " "  " "  " ",
             "A" "B" "C" "D" "E" "F"};
          /* Admit Not */
   table = { 512  313,
              89   19,
             353  207,
              17    8,
             120  205,
             202  391,
             138  279,
             131  244,
              53  138,
              94  299,
              22  351,
              24  317};
   *  print table;
   finish;

start cancer;
   data='cancer';
/*
 Three year survival of 474 breast cancer patients according to nuclear
 grade and diagnostic centre.
        Data from Morrison etal
   Whittaker, J. (1990) Graphical Models, p. 220.
   Lindsey, J.K. (1995) Modelling Frequency and Count Data, p38
*/
        source='Morrison etal, Lindsey:95 (p38)';
   dim= {2 2 2};
   table = {
   /*
      Malignant   benign
      Died Surv Died Surv
   */
      35   59   47   112,   /* Boston    */
      42   77   26    76};  /* Glamorgan */

   vnames = {'Survival' 'Grade' 'Center'};
   lnames = {'Died' 'Surv',
            'Malignant' 'Benign',
            'Boston' 'Glamorgan'};
   title = 'Breast Cancer Patients';
   finish;

start cesarean;
   data='cesarean';
   source='Fahrmeir & Tutz (1994)';
        title = 'Risk factors for infection in cesarean births';
   dim = {3 2 2 2};
   vnames = {'Infection' 'Risk?' 'Antibiotics' 'Planned'};
   lnames = {'Type 1' 'Type 2' 'None',
            'Yes' 'No' '',
            'Yes' 'No' '',
            'Yes' 'No' ''
            };
   table = {
      0   1  17,
      0   1   1,
      11  17  30,
      4   4  32,
      4   7  87,
      0   0   0,
      10  13   3,
      0   0   9
            };
   finish;

start detergen;
   data='detergen';
   source='Fienberg:80 (p. 71), RiesSmith:63';
        title = 'Detergent preference data';
   dim = {2 2 2 3};
   vnames = {'Temperature' 'M-User?' 'Preference' 'Water softness'};
   lnames = {'High' 'Low' '',
            'Yes'  'No'  '',
            'Brand X' 'Brand M' '',
            'Soft' 'Medium' 'Hard'};

   table = {
      19  57  29  63,  /* Soft     Brand X */
      29  49  27  53,  /* Soft     Brand M */
      23  47  33  66,  /* Medium   Brand X */
      47  55  23  50,  /* Medium   Brand M */
      24  37  42  68,  /* Hard     Brand X */
      43  52  30  42   /* Hard     Brand M */
   };
   finish;

start dyke;
        data='dyke';
        source='DykePatterson:52, Fienberg:77 (p.73)';
/*
!Sources of knowledge of cancer Dyke & Patterson (1952)
!(Fienberg, 1977, p.73)
!lindsey/cat3ex/ch2ex8.dat
!Stokes, Davis, Koch, sec 14.4
!         Y                     N            Radio
!    Y         N           Y         N      Reading
!Good Poor Good Poor   Good Poor Good Poor
!                                           Newspaper   Lectures
*/
   table = {
  23    8    8    4     27   18    7    6,  /*   Y          Y */
 102   67   35   59    201  177   75  156,  /*   Y          N */
   1    3    4    3      3    8    2   10,  /*   N          Y */
  16   16   13   50     67   83   84  393,  /*   N          N */
   };
   dim = {2 2 2 2 2};
   vnames = {'Knowledge' 'Reading' 'Radio' 'Lectures' 'Newspaper'};
   lnames = {'Good' 'Poor',
            'Yes' 'No',
            'Yes' 'No',
            'Yes' 'No',
            'Yes' 'No' };

        *-- Reversing order of Yes/No vars makes nicer displays;
        table = table[{4 3 2 1},];
        table = table[,{7 8 5 6 3 4 1 2}];
   table = shape(table, 16, 2);
        lnames[2,] = lnames[2,{2 1}];
        lnames[3,] = lnames[3,{2 1}];
        lnames[4,] = lnames[4,{2 1}];
        lnames[5,] = lnames[5,{2 1}];

   title='Sources of knowledge of cancer';
   finish;

start employ;
/*
    Employment status on Jan1 1975, by cause of layoff and length of
    previous employment at time of layoff for employees who lost their
    job in Fall 1974 in Denmark.

        "In 1974 the Danish National Inst for Social Science Research
        investigated 1314 employees who left their jobs during the 2nd
        half of the year.
        Classified by:
                Employment status, 1/1/75:  New job vs. still 
unemployed
                Cause of layoff:            Closure, etc. vs. 
Replacement
                Length of employment at time of layoff
*/

        data='employ';
   title  = 'Employment Status Data';
   source = 'Andersen (1991), Ex 5.3 (p.167); from Kjer (1978) Table 
4.8';
   dim = {2 2 6};
   vnames = {'EmployStatus' 'Layoff' 'LengthEmploy'};
   lnames = {'NewJob' 'Unemployed'    '' '' '' '',
             'Closure'  'Replaced' '' '' '' '',
             '<1 Mo' '1-3 Mo' '3-12 Mo' '1-2 Yr' '2-5 Yr' '>5 Yr'};

       /* B: -Closure-   -Replaced-                 */
       /* A: Job  Unem   Job  Unem                  */
   table = {   8   10,     40   24,        /* < 1 Mo */
              35   42,     85   42,        /* 1-3 Mo */
              70   86,    181   41,        /* 3-12Mo */
              62   80,     85   16,        /* 1-2 Yr */
              56   67,    118   27,        /* 2-5 Yr */
              38   35,     56   10 };      /* > 5 Yr */
        finish;

start gilby;
   title = 'Clothing and intelligence rating of children';
   source = 'Gilby & Pearson 1911, from Anscombe 1981, p 302';
   /*
   Gilby, W. H. and Pearson, K.
   On the significance of the teacher's appreciation of
   general intelligence.  Biometrika, 8, 93-108 (esp p 94)
   Quoted by Kendall (1943,...1953) Table 13.1, p 320

   Schoolboys were classified according to their clothing
   and to their teachers rating of 'dullness'
   Note: the last two categories of clothing were pooled
   as were the first two categories of dullness
   */
   data='gilby';
   dim = {6 4};
   vnames = {'Dullness' 'Clothing'};
   lnames = {
      'Mentally defective or Slow dull' 'Slow' 'Slow intelligent' 
'Fairly intelligent' 'Distinctly capable' 'Very able',
      'Very well clad' 'Well clad' 'Poor but passable' 'Insufficient or 
worse' '' ''
      };
        *-- Shorter labels for the categories;
   lnames = {
      'Ment. defective' 'Slow' 'Slow Intell' 'Fairly Intell' 'Capable' 
'V.Able',
      'V.Well clad' 'Well clad' 'Passable' 'Insufficient' '' ''
      };
   table = {
         33  48 113 209 194  39,
         41 100 202 255 138  15,
         39  58  70  61  33   4,
         17  13  22  10  10   1 };
   finish;

start haireye;
   *-- Hair color, eye color data;
        data='haireye';
        source = 'Snee (1974)';
        table = {
 /* ----brown---   -----blue-----   ----hazel---   ---green--- */
   32  38  10  3   11  50  10  30   10  25  7  5   3  15  7  8,   /* M 
*/
   36  81  16  4    9  34   7  64    5  29  7  5   2  14  7  8 }; /* F 
*/
** changed table[,2] from {38,81} **;
 table = {
 /* ----brown---   -----blue-----   ----hazel---   ---green--- */
   32  53  10  3   11  50  10  30   10  25  7  5   3  15  7  8,   /* M 
*/
   36  66  16  4    9  34   7  64    5  29  7  5   2  14  7  8 }; /* F 
*/


   dim    = { 4 4 2 };
   vnames = {'Hair' 'Eye' 'Sex' };          /* Variable names */
   lnames = {                               /* Category names */
         'Black' 'Brown' 'Red' 'Blond',    /* hair color */
         'Brown' 'Blue' 'Hazel' 'Green',   /* eye color  */
         'Male' 'Female' ' '  ' ' };       /* sex        */
   title  = 'Hair color - Eye color data';
   finish;

start heart;
   data='heart';
   source='Karger, 1980';
        title = 'Sex, occupation and heart disease';

   dim = {2 2 3};
   vnames = {'Disease' 'Gender' 'Occup'};
   lnames = {'Disease' 'None'    '',
             'Male'   'Female'   '',
             'Unempl' 'WhiteCol' 'BlueCol'};
        table = {
        254     759,   /*  Male    Unempl  */
        431     10283, /*  Female  Unempl  */
        158     3155,  /*  Male    WhiteCol*/        
        52      3082,  /*  Female  WhiteCol*/        
        87      2829,  /*  Male    BlueCol */
        16      416};  /*  Female  BlueCol */
        finish;

start heckman;
   data='heckman';
        source='HeckmanWillis:77,Lindsey:93 (p. 185)';
/*
From Lindsey, cat3dat/ch9e5.dat
see also Lindsey 93, Table 6.2, p185
!Labour force participation of married women 1967-1971
!Heckman, J.J. & Willis, R.J. (1977) "A beta-logistic model for the 
analysis
!of sequential labor force participation by married women." Jr. Pol. 
Econ.
!85: 27-58
!1971    1970 1969 1968 1967
!Yes No
*/
   table = {
      426  38 , /*Yes  Yes  Yes  Yes */
         16  47 , /*No   Yes  Yes  Yes */
       11   2 , /*Yes  No   Yes  Yes */
       12  28 , /*No   No   Yes  Yes */
       21   7 , /*Yes  Yes  No   Yes */
        0   9 , /*No   Yes  No   Yes */
        8   3 , /*Yes  No   No   Yes */
        5  43 , /*No   No   No   Yes */
       73  11 , /*Yes  Yes  Yes  No  */
        7  17 , /*No   Yes  Yes  No  */
        9   3 , /*Yes  No   Yes  No  */
        5  24 , /*No   No   Yes  No  */
       54  16 , /*Yes  Yes  No   No  */
        6  28 , /*No   Yes  No   No  */
       36  24 , /*Yes  No   No   No  */
       35 559}; /*No   No   No   No  */

        title='Labour force participation of married women 1967-1971';
   dim = {2 2 2 2 2};
   vnames = '19' + ('71':'67');
   lnames = repeat({'Working   ' 'Not Working'}, 5, 1);
   lnames = repeat({'Yes  ' 'No   '}, 5, 1);
   lnames[,1] = ('71':'67')` + lnames[,1];
   finish;

start hoyt;
        source='Hoyt, Krishnaiah, Torrence (1959); Fienberg pp.91-92';
        data='hoyt';
        title = 'Minnesota High School Graduates';
   dim   = { 4 3 7 2};
   vnames= {'Status' 'Rank' 'Occupation' 'Sex'};
   lnames= {'College' 'School' 'Job' 'Other' '' '' '',
            'Low' 'Middle' 'High' '' '' '' '',
            '1' '2' '3' '4' '5' '6' '7',
            'Male' 'Female' '' '' '' '' ''};
   table = {
     87   3  17 105  216   4  14 118  256   2  10  53 ,
     72   6  18 209  159  14  28 227  176   8  22  95 ,
     52  17  14 541  119  13  44 578  119  10  33 257 ,
     88   9  14 328  158  15  36 304  144  12  20 115 ,
     32   1  12 124   43   5   7 119   42   2   7  56 ,
     14   2   5 148   24   6  15 131   24   2   4  61 ,
     20   3   4 109   41   5  13  88   32   2   4  41 ,
     53   7  13  76  163  30  28 118  309  17  38  89 ,
     36  16  11 111  116  41  53 214  225  49  68 210 ,
     52  28  49 521  162  64 129 708  243  79 184 448 ,
     48  18  29 191  130  47  62 305  237  57  63 219 ,
     12   5  10 101   35  11  37 152   72  20  21  95 ,
      9   1  15 130   19  13  22 174   42  10  19 105 ,
      3   1   6  88   25   9  15 158   36  14  19  93 };
   finish;

start marital;
        source='Agresti, Table 7.3';
        data='marital';
  *-- define the data variables;
                    /* Gender Pre  Extra */
  table={ 17   4 ,  /* Women  Yes  Yes  */
          54  25 ,  /* Women  Yes  No   */
          36   4 ,  /* Women  No   Yes  */
         214 322 ,  /* Women  No   No   */
          28  11 ,  /* Men    Yes  Yes  */
          60  42 ,  /* Men    Yes  No   */
          17   4 ,  /* Men    No   Yes  */
          68 130 }; /* Men    No   No   */
   dim = { 2 2 2 2 };
   vnames = {'Marital' 'Extra' 'Pre' 'Gender'};
   lnames = {'Divorced'   'Married',
             'Extra Sex: Yes' 'No',
             'Pre Sex: Yes'   'No',
             'Women    '      'Men' };
   title  = 'Pre/Extramarital Sex and Marital Status';
   finish;

start mental;
        data = 'mental';
        title='Mental impariment and parents SES';
        source='Haberman, 1979 [p.375], from Srole etal,(1978) p.289';
        * also, Agresti:90, Lindsey p.99;       
        table = {
                64   94   58   46
                57   94   54   40
                57  105   65   60
                72  141   77   94
                36   97   54   78
                21   71   54   71
                };
   dim = { 4 6 };
   vnames= {"Mental Impairment" "Parents SES"};
   lnames= {"Well" "Mild" "Moderate" "Impaired" " " " ",
            "High" "2" "3" "4" 5 "Low"};
        finish;

start mobility;
   data='mobility';
        source='FeathermanHauser:78';
   dim = { 5 5 };
   /* Social Mobility data, Featherman & Hauser, 78 ,
            analyzed by Falguerolles & Mathieu, COMPSTAT 88 */
   /*    Sons occupation
         UNM   LNM    UM    LM  Farm */
   table = {
        1414   521   302   643    40,
         724   524   254   703    48,
         798   648   856  1676   108,
         756   914   771  3325   237,
         409   357   441  1611  1832 };

   title  = {'Social Mobility data'};
   vnames = {"Son's Occupation" "Father's Occupation"};
   lnames = { 'UpNonMan' 'LoNonMan' 'UpManual' 'LoManual' 'Farm',
            'UpNonMan' 'LoNonMan' 'UpManual' 'LoManual'  'Farm'};
   finish;

start abortion;
   data='abortion';
   title='Abortion opinion data';
   source='Christiensen (\S 3.5.2) ';  *-- page 92;

   dim = {2 2 2};
/* SES:      Low      NotLow  */
/* Opinion: Y   N     Y   N   */
   table ={171  79   138 112,      /* Female */
           152 148   167 133};     /* Male   */

   run marg(loc,newtab,dim,table,(3:1)`);
   table = shape(newtab,2,4);
   vnames={'Sex' 'Status' 'Support Abortion'};
   lnames={'Female' 'Male',
           'Lo'  'Hi',
           'Yes' 'No'};
   finish;

start suicide;
   data = 'suicide';
        source = 'Heuer:79,Friendly:94a';
   table = {
     512    25   852    64   875    52   477    29   229     3,  /* Gun 
*/
     335    40   883   113   625    91   201    45    45    29,  /* Gas 
*/
    1524   212  2751   575  3936  1481  3581  2014  2948  1355,  /* 
Hang */
    1160   921  2823  1672  2465  2224  1531  2283   938  1548,  /* 
Poison */
     189   131   366   276   244   327   273   388   268   383,  /* 
Jump */
      67    30   213   139   247   354   207   679   212   501   /* 
Drown */
            };
   dim = {2 5 6};

   meth= {'Gun' 'Gas' 'Hang' 'Poison' 'Jump' 'Drown'};
   age =  char(do(10,55,15),2,0)+shape({'-'},1,4)+
          char(do(20,65,15),2,0)
           || {'>65'  ' '   };
   sex = {'Male' 'Female' ' '  ' '  ' '  ' '  };

   vnames = {'Sex' 'Age' 'Method'};
   lnames = (sex // age // meth) ;
   title  = 'Suicide data';
   free meth age sex;
   finish;

start titanic;
   data='titanic';
        source='Dawson:95';
   title='Survival on the Titanic';
   dim = {4 2 2 2};
   vnames = {'Class' 'Sex' 'Age' 'Survived'};
   lnames = {'1st' '2nd' '3rd' 'Crew',
            'Male'  'Female' '' '',
            'Child' 'Adult' '' '',
            'Died'  'Survived'   '' ''};
   table = {
  /*
 CLASS1    CLASS2    CLASS3    CLASS4    SURVIVE     AGE      SEX
  */
    0         0        35         0,   /* No       Child    Male   */
    0         0        17         0,   /* No       Child    Female */
  118       154       387       670,   /* No       Adult    Male   */
    4        13        89         3,   /* No       Adult    Female */
    5        11        13         0,   /* Yes      Child    Male   */
    1        13        14         0,   /* Yes      Child    Female */
   57        14        75       192,   /* Yes      Adult    Male   */
  140        80        76        20    /* Yes      Adult    Female */
        };
   table = table[{3 4 1 2  7 8 5 6},];
   lnames[3,] = {'Adult' 'Child' '' ''};
   finish;

start victims;
        data='victims';
        source = 'Reiss:80,Fienberg:80 (Table 2-8)';
   crime = {'Rape' 'Assault' 'Robbery' 'PickPock' 'Pers.Larceny'
            'Burglary' 'Hous.Larceny' 'Auto Theft'};
   dim = {8 8};
   vnames = {'First Victimization' 'Second Victimization'};
   lnames = crime // crime ;
   title  = 'Repeat Victimization Data';
   table = {  26   50  11   6    82   39   48   11,
              65 2997 238  85  2553 1083 1349  216,
              12  279 197  36   459  197  221   47,
               3  102  40  61   243  115  101   38,
              75 2628 413 329 12137 2658 3689  687,
              52 1117 191 102  2649 3210 1973  301,
              42 1251 206 117  3757 1962 4646  391,
               3  221  51  24   678  301  367  269}`;
   free crime;
   finish;

/*  transform a vector of character strings into a matrix, whose
    number of rows is ncol(dim) and number of columns is max(dim).
         Useful for creating lnames.
        e.g.,
                ln = {a1 a2 a3 b1 b2 b3 b4 c1 c2};
                lname = vec2mat({3 4 2}, ln);
*/
start vec2mat(dim, vec);
   r = ncol(dim);
   c = max(dim);
   len = max(length(vec));
   blank='                    ';
   mat = j(r, c, substr(blank, 1, len));
   start = 1;
   do i = 1 to r;
      l = dim[i];
      mat[i, 1:l] = shape(vec[start:start+l-1],1);
      start = start+l;
      end;
   return(mat);
   finish;

/*
*-- Stack two matrices, filling out columns of the smaller with 0s or ' 
's;
start ontop(mat1, mat2);
   if type(mat1) = 'N'
      then fill=0;
      else fill=' ';
   nc1 = ncol(mat1);
   nc2 = ncol(mat2);
   if ncol(mat1) = ncol(mat2)
      then return (mat1 // mat2);
   else if nc1 < nc2 then do;
      result = (mat1 || j( nrow(mat1), nc2-nc1, fill)) // mat2;
      end;
   else do;
      result = mat1 // (mat2 || j( nrow(mat2), nc1-nc2, fill));
      end;
   return(result);
   finish;
*/

start datalist(datasets) global(data, title, source, dim, vnames, 
lnames);
   file print;

   put 'dataname' @12 'title / dim / vnames' /;
   do i = 1 to ncol(datasets);
                title = '????';
      call execute('run ', datasets[i], ';');
                namelist = namelist // data;
                titles   = titles // title;
      d = rowcat(char(dim,1+length(vnames[1])));
      v = rowcat(vnames+' ');
      put data @12 title / @12 'dim: ' d / @12 'vn:    ' v;
      put;
      end;
                
   finish;


   datasets = {
    abortion bartlett  berkeley  cancer  cesarean  detergen  dyke
         employ  gilby haireye  heart heckman hoyt  marital mental 
mobility
         suicide titanic victims};

   reset storage=mosaic.mosdata;
   store module=_all_ datasets;
   show storage;

        *-- Make sure all are mentioned in datasets;
   stored = storage();
   util = {vec2mat, datalist, datasets};
   dif = t(setdif(stored, datasets));
   dif = setdif(dif, util);
   if type(dif)^='U' then print stored dif;

   run datalist(datasets);
quit;         ;

/*
   Name:   mospart.sas
   Title:  Mosaics plots for partial association


        The mospart module produces a series of mosaics plots for partial
        association, that is separate plots for each level of one or more
        by variables.

        Input parameters are the same as for mosaic, except that:
        
        byvar - specifies the variables (names or numbers) which are used 
to
                stratify the data.  One mosaic is produced for each 
combination
                of the levels of the byvars.  These may be composed into a 
single
                graphic using the %panels macro after the SAS/IML step.

        plots - is a global variable rather than an input parameter here.
                If not specified, plots = the number of variables not given 
as
                byvariables.

*/
start mospart(dim, table, vnames, lnames, title, byvar)
      global(config, devtype, fittype, filltype, shade, space, split, 
plots,
             htext, verbose, font, cellfill, vlabels, fuzz, sep);
   factors = max(nrow(dim), ncol(dim));

        if type(byvar) = 'C'
                then byvar = name2num(row(byvar), row(vnames));
        if all(byvar=0) then do;
                print 'Error: BYVAR out of bounds in MOSPART';
                show vnames byvar; print byvar;
                return;
                end;
        others = remove( (1:factors), (byvar) );

        bydim = (shape(dim[byvar],1))`;
        byvn  = (shape(vnames[byvar],1))`;
        nby   = nrow(bydim);        *-- number of by variables;
        modim = dim[others];        *-- dimensions for each mosaic;
        rows  = modim[#];
        cols  = bydim[#];           *-- number of mosaic displays;
        * print byvar byvn bydim modim rows;
        cl = lnames[byvar,];
                
        if type(plots) ^= 'N'   then plots = ncol(others);
        if type(htext) ^= 'N'   then htext = cols;
        if type(vlabels) ^= 'N' then vlabels=0;
        if type(sep) ^= 'C' then sep=', ';
                
        * transpos table to put byvars first;
        order = shape(byvar,1)||others;
        dm = dim;
        vn = vnames;
        ln = lnames;
        tab = table;
        run transpos(dm, tab, vn, ln, order);
        * print dm vn ln tab;
        tab = shape(tab,rows);
        
        *-- construct labels for byvars;
        do i=1 to nby;
      cur = ln[i,]`;
      if i=1 then cl=cur;
         else do;        /* construct row labels for prior factors */
                                sp = sep[,min(i-1, ncol(sep))];
            ol = repeat(cl, 1, dm[i]);
            ol = shape(ol,  dm[i]#nrow(cl), 1);
            nl = repeat( (cur[1:(dm[i])]), nrow(cl));
            cl = trim(rowcatc(ol || shape(sp,nrow(ol),1) ||nl));
         end;
                end;
        * print 'transposed, reshaped tab' tab[c=cl];
        print 'Mosaic plots for levels of' byvn, cl;
        
        pn = vn[1:nby];
        dm = dm[(nby+1):factors];
        vn = vn[(nby+1):factors];
        ln = ln[(nby+1):factors,];

   call gstart;
        do ip = 1 to cols;
                bylev = cl[ip];
                if nby=1
                        then titl = trim(pn[1]) + ': ' + bylev;
                        else titl = trim(cl[ip]);
                ptab = tab[,ip];
*               print 'Slab' ip byvn bylev vn ln; * ptab;
      run mosaic(dm, ptab, vn, ln, plots, titl);
        end;
        finish;


*-- Scatterplot matrix of Mosaic displays for pairwise association;
/*
   Name:   mosmat.sas
   Title:  Scatterplot matrix of mosaic displays

        Input parameters are the same as for mosaic, except that vnames
        may contain two rows -- 
        vnames[1,] -- long names (split on '/'), used to label diagonal
                panels
        vnames[2,] -- short variable names used in pairwise mosaics

   Set 
        fittype='PARTIAL'; plots=3;     for partial/conditional association
        fittype=anthing;   plots=2              for marginal association
*/
        
start mosmat(dim, table, vnames, lnames, plots, title)
      global(config, devtype, fittype, filltype, shade, space, split,
             htext, verbose, font);
   factors = max(nrow(dim), ncol(dim));
        if ncol(vnames) = 1 then vnames = vnames`;
   if nrow(vnames) = 2 & ncol(vnames)=factors then
      do;
         vnlong = vnames[1,];    *-- long names (diag panels);
         vnames = vnames[2,];    *-- short names (mosaics);             
      end;
      else do;
         vnlong = vnames;
         vnames = vnames;
      end;
        if type(htext) ^= 'N' then htext=factors;
        if type(split) ^= 'C' then split={V H};
        if type(font)  ^= 'C' then font='hwpsl009';
        
   call gstart;
   ip = 0;  ig=0;      *-- panel and graph numbers;
   replay = '';        *-- greplay list;
   do row = 1 to factors;
      do col = 1 to factors;
         ip = ip+1;
         ig = ig+1;
         if row = col then do;
            run vpanel(vnlong[col]);
            end;
         else do;
            others = remove( (1:factors), (row||col) );
            * transpose table to conform to model;
            order = col||row||others;
            dm = dim;
            vn = vnames;
            ln = lnames;
            tab = table;
                                if type(config)='N' then do;
                                        run modname(config,vn,model);
                                        print row col model config;
                                end;
            run transpos(dm, tab, vn, ln, order);
            ord = rowcatc(vn`);
            titl = title;
            run mosaic(dm, tab, vn, ln, plots, titl);
            end;
         *-- Construct replay list: graph ig in panel ip;
         replay = replay + trim(char(ip,2))+':'+trim(left(char(ig)))+' 
';
         end; /* do row */
      end; /* do col */
 
      nvar = '%let nvar =' + char(factors,2) + ';' ;
      replay = '%let replay =' + replay + ';' ;
      call execute(replay);
      call execute(nvar);
 
finish;

*-- Draw a panel for a variable name; 
start vpanel(name)
        global(font, htext);
   *-- Draw a panel with the variable name;
   call gstart;
   call gopen;
   window = {0 0 100 100};
   call gwindow(window);
   call ggrid( {5  95}, {5  95});
   run split(name, '/', lines);
        nlines = nrow(lines);

   ht=3#htext ;
        *-- Find length of all lines, reduce ht if necessary;
   call gstrlen(len,lines, ht, font);
*       print  lines len;
        if max(len) > 90 
                then ht = round(ht # 90/max(len),.1);
        
   do l = 1 to nlines;
      line = lines[l,];
      call gstrlen(len,line, ht, font);
      x = 50 - len/2;
      y = 50 - ht/2 + 1.5#(ht+1)#(nlines-l);
      call gscript(x,y, line,,,ht,font);
        *       print 'vpanel:' l x y line len ht;
      end;
finish;

start split(in, char, out);
   *-- split a string into separate strings at each occurrence of 
'char';
   free out;
   i=1;
   sub = scan(in,i,char);
   do while(sub ^=' ');
      out = out // sub;
      i = i+1;
      sub = scan(in,i,char);
   end;
finish;


/*
   Name:  mosademo.sas
  Title:  Demonstration program for MOSAICS
   Requires that MOSAICM.SAS be run first to install modules
    in libname 'mosaic'.  See the User's Guide.
*/
goptions vsize=7in hsize=7in;         /* make the plot square */

 
proc iml;
start haireye;
   *-- Hair color, eye color data;
 table = {
 /* ----brown---   -----blue-----   ----hazel---   ---green--- */
   32  38  10  3   11  50  10  30   10  25  7  5   3  15  7  8,   /* M 
*/
   36  81  16  4    9  34   7  64    5  29  7  5   2  14  7  8 }; /* F 
*/
 
levels= { 4 4 2 };
vnames = {'Hair' 'Eye' 'Sex' };    /* Variable names */
lnames = {                         /* Category names */
         black brown red blond,        /* hair color */
         brown blue hazel green,       /* eye color  */
         male female ' '  ' ' };       /* sex        */
title  = 'Hair color - Eye color data';
finish;
 
run haireye;

   reset storage=mosaic.mosaic;
   load module=_all_;

   *-- Fit models of joint independence (fittype='JOINT');
   plots = 2:3;
   split={V H};
   title = ' ';
   htext=1.42;
   run mosaic(levels, table, vnames, lnames, plots, title);
 
   *-- reorder eye colors (brown, hazel, green, blue);
   table  = table[,((1:4) || (9:16) || (5:8))];
   lnames[2,] = lnames[2,{1 3 4 2}];
   plots=2:3;
   run mosaic(levels, table, vnames, lnames, plots, title);
 
   plots=3;
   fittype='MUTUAL';
   run mosaic(levels, table, vnames, lnames, plots, title);
quit;

*include goptions;         *-- set goptions device=  etc;
goptions hsize=7 in vsize=7 in;
title 'Mosaics for specialized models fit externally to mosaics.sas';
 
proc iml;
  dim = { 4 4 };
  /* Unaided distant vision data Bishop etal p. 284*/
     /*    Left eye grade */
  group  = {' (women)'};
  f = {1520   266   124    66,
        234  1512   432    78,
        117   362  1772   205,
         36    82   179   492 };
  title  = {'Unaided distant vision: Independence'} + group;
  vnames = {'Right Eye','Left Eye'};
  lnames = { 'High' '2' '3' 'Low',
             'High' '2' '3' 'Low'};
   reset storage=mosaic.mosaic;
   load module=_all_;
        %include '~/sasuser/mosaics/mosaicd.sas';

   htext=1.5;
   plots={2};
        font='hwpsl009';
        colors={BLUE RED};
        filltype={HLS HLS};
        *-- Independence model;
   run mosaic(dim, f, vnames, lnames, plots, title);
 
        *-- test quasi independence (ignore diagonal);
   initab = j(4,4) - i(4);
   qf = f - diag(f);
   call ipf(fit, stat, dim,qf, {1 2}, initab);
   fit = fit + diag(f);
   dev = (f - fit)/sqrt(fit);
   chisq=chisq(f,fit);
   df = 9-4;
   title={'Quasi Independence Model'} + group;
   print / title , chisq[r={GF LR}] df, fit[f=8.3], dev[f=8.3];

   run mosaicd(dim, f, vnames, lnames, dev, title);
 
   *-- Symmetry model;
   title={'Symmetry Model'} + group;
   fit = (f + f`)/2;
   dev = (f - fit)/sqrt(fit);
   print title, dev;
   chisq=chisq(f,fit);
   df = .5#nrow(f)#(nrow(f)-1);
   print / title , chisq[r={GF LR}] df, fit[f=8.3], dev[f=8.3];
   run mosaicd(dim, f, vnames, lnames, dev, title);
 
        *-- Quasi-symmetry;
   call ipf(fit, stat, dim,qf, config);
   dev = (qf - fit)/sqrt(fit);
   dev = dev[1:4,];
   dev = dev - diag(dev);   *-- Rounding error on diagonal?? ;
   df = .5#(nrow(f)-1)#(nrow(f)-2);
   chisq=ssq(dev) ;
   prob = 1 - probchi(chisq,df);
   print / 'Quasi-Symmetry' config, fit[f=8.3], dev[f=8.3],
                            chisq[r={GF LR} f=8.4] df prob;
   run mosaicd(dim, f, vnames, lnames, dev, title);
 
quit;
%*gfinish;

%include goptions;

goptions vsize=7 in hsize=7 in;
proc iml;
 
start victims;
   crime = {'Rape' 'Assault' 'Robbery' 'PickPock' 'Pers.Larceny'
            'Burglary' 'Hous.Larceny' 'Auto'};
   levels = {8 8};
   vnames = {'First Victimization' 'Second Victimization'};
   lnames = crime // crime ;
   title  = 'Repeat Victimization Data';
   table = t({ 26   50  11   6    82   39   48   11,
              65 2997 238  85  2553 1083 1349  216,
              12  279 197  36   459  197  221   47,
               3  102  40  61   243  115  101   38,
              75 2628 413 329 12137 2658 3689  687,
              52 1117 191 102  2649 3210 1973  301,
              42 1251 206 117  3757 1962 4646  391,
               3  221  51  24   678  301  367  269});
        finish;
        run victims;

        *-- load mosaic modules;
   reset storage=mosaic.mosaic;
   load module=_all_;
 
        *-- select subset of rows/cols;
   keep = {1 2 3 6 8};
   table = table[keep,keep];
   lnames = lnames[,keep];
   levels = {5 5};

        *-- set mosaic global options;
   htext = 1.4;
        
   shade = {2 4 8};

   plots = {2};
   run mosaic(levels, table, vnames, lnames, plots, title);
 
        *-- rearrange rows/cols by CA dim1;
        keep = {2 3 1 5 4};
        table = table[keep,keep];
        lnames = lnames[,keep];
 
        *-- standardize table to equal margins;
   avg = table[,+] / levels[1];
   newtab = repeat(avg,1,5);
   config = {1 2};
   call ipf(adjusted, status, levels, newtab, config, table);
   title  = 'Repeat Victimization Data, Adjusted to Equal Margins';
   lab = crime[keep];
   print title, adjusted[r=lab c=lab f=8.2];
   plots = 2;
   run mosaic(levels, adjusted, vnames, lnames, plots, title);

        *-- fit quasi-independence (ignore diagonal cells);
   title  = 'Repeat Victimization Data, Quasi Independence';
        zeros = J(5,5) - I(5);
   run mosaic(levels, adjusted, vnames, lnames, plots, title);
quit;

%include goptions;
goptions vsize=7 hsize=7;
* Sex, Occupation and heart disease [Karger, 1980];
 
data heart;
   input gender $ occup $  @;
   heart='Disease';  input freq @;  output;
   heart='No Dis';   input freq @;  output;
cards;
Male   WhiteCol   158   3155
Female WhiteCol    52   3082
Male   BlueCol     87   2829
Female BlueCol     16    416
Male   Unempl     254    759
Female Unempl     431  10283
;
proc sort data=heart;
   by descending heart gender;

proc iml;
/*
   use heart;
   read all var{freq} into table;
   levels = { 2 3 2 };
   vnames = {'Gender' 'Occup' 'Heart' };
   lnames = {'Female'  'Male ' ' ',
             'BlueCol' 'Unempl'  'WhiteCol',
             'Disease' 'NoDisease'  ' ' };
*/
   title  = 'Sex, Occupation, and Heart Disease';
 
   reset storage=mosaic.mosaic;
   load module=_all_;

   vnames = {'Gender' 'Occup' 'Heart' };
   run readtab('heart', 'freq', vnames, table, levels, lnames);
 
   plots = 2:ncol(levels);
   run mosaic(levels, table, vnames, lnames, plots, title);
quit;

title 'Alcohol, Cigarette, and Marijuana Use by High School Seniors';
* Source: Agresti, 1996, p. 152;
data druguse;
        input alcohol $ cigaret $ @;
        marijuan = 'Mar:+';  input freq @;  output;
        marijuan = 'Mar:- '; input freq @;  output;
        
cards;
Alc:+  Cig:+   911   538
Alc:+  Cig:-    44   456
Alc:-  Cig:+     3    43
Alc:-  Cig:-     2   279
;
%include goptions;
goptions hsize=7in vsize=7in;
%mosaic(var=alcohol cigaret marijuan, count=freq, plots=2:3,
        fittype=condit,
        title=%str(Alcohol, Cigarette, and Marijuana Use));     

%mosaic(var=alcohol cigaret marijuan, count=freq, plots=2:3,
        fittype=user, config=alcohol cigaret/alcohol marijuan/cigaret 
marijuan,
        title=%str(&MODEL));    

/*
  Name:  ishi.sas
 Title:  Ethnicity, religiosity, and gender ideology
Source: Ishi-Kuntz, M. (1994) ``Ordinal log-linear models'', Sage, p.37
*/
options ls=80 ps=60 nocenter;
%include goptions;
goptions hsize=7in vsize=7in;
proc format ;
   value efmt 1='Hispanic'    2='White'    3='Black';
   value rfmt 1='Religious'   2='Moderate' 3='Non-rel.';
   value gfmt 1='Traditional' 2='Moderate' 3='Liberal';

data ishi ;
   input e  r  g  count @@;
   format e efmt. r rfmt. g gfmt.;

   label ethnicty = 'Ethnicity'
         relig    = 'Religiosity'
         gendidol = 'Gender ideology';
   ethnicty = put(e, efmt.);
   relig    = put(r, rfmt.);
   gendiol  = put(g, gfmt.);
cards;
3 1 1  58    3 1 2  45    3 1 3  49
3 2 1  11    3 2 2  17    3 2 3  21
3 3 1   3    3 3 2   4    3 3 3   7
1 1 1  83    1 1 2  24    1 1 3   8
1 2 1  16    1 2 2  17    1 2 3  13
1 3 1   7    1 3 2   6    1 3 3   2
2 1 1 317    2 1 2 242    2 1 3 145
2 2 1 105    2 2 2 157    2 2 3 148
2 3 1  41    2 3 2 109    2 3 3 150
;
/*
proc freq order=formatted ;
     weight count ;
     tables gendiol*(relig ethnicty) / noprint chisq measures cmh;
     tables relig*ethnicty / noprint chisq measures cmh;
     tables ethnicty*gendiol*relig / chisq measures cmh;
run ;
*/

%mosaic(data=ishi, var=Ethnicty Relig Gendiol,
        sort=g r descending ethnicty, plots=2 3, htext=1.7,
        title=%str(Gender Ideology, Religiosity and Ethnicity
INDEX   
druguse.sas     Alcohol, Cigarette, and Marijuana Use by High School 
Seniors
ishi.sas        Ethnicity, religiosity, and gender ideology
karger.sas      Sex, Occupation, and Heart Disease
mosademo.sas    Demonstration program for MOSAICS
mosaicd.sas     Mosaic displays for externally-fitted models
mosaicm.sas     Install mosaic modules
mosaics.sas     IML modules for general n-way mosaic display
mosdata.sas     Assorted contingency table data sets for mosaic displays
moseye.sas      Mosaics for specialized models fit externally to 
mosaics.sas
mosmat.sas      Scatterplot matrix of mosaic displays
mospart.sas     Mosaics plots for partial association
victims.sas     Repeat Victimization Data

Installing MOSAICS

mosaics.sas consists of a collection of SAS/IML modules which are
designed to be called from another program in a PROC IML step (or
via the MOSAIC or MOSMAT macros).  Because the program is large,
the modules are most conveniently stored in compiled form in a
SAS/IML storage catalog, called MOSAIC.MOSAIC.  To install the
program in this way,

1.  Copy the files mosaics.sas and mosaicm.sas to a directory, 
(~/sasuser/mosaics/, or c:\sasuser\mosaics\, say),

2.  Edit the LIBNAME and FILENAME statements to
correspond to this directory,

  *-- Change the path in the following filename statement to point to
      the installed location of mosaics.sas;
  filename mosaics  '~/sasuser/mosaics/';

  *--- Change the path in the libname to point to where the compiled
     modules will be stored, ordinarily the same directory;
  libname  mosaic   '~/sasuser/mosaics/';

3. You may wish to change some of the program default values, (in
the module globals in mosaics.sas) particularly the font= value.
As of V3.5, this is set to font='SWISS', unless the current graphics
device (&SYSDEVIC) is one of the Postscript drivers (e.g., PSCOLOR,
PSMONO, PSLEPS), in which case the program uses the hardware
Helvetica font (font='hwpsl009') because the resulting output
graphic files are much smaller and can be potentially edited.

4. To store the modules in compiled form, run the mosaicm.sas
program, with the command,

sas mosaicm

5 Optionally, install the sample data sets by running mosdata.sas



Further details are givem in Sect 2.2 of doc/mosaics.pdf.

/*
 Name: TESTMOS.SAS
 Title: Test stream for VCD mosaics programs
 Generator: ls -1 *.sas | tcgrep -v 'mosaic|mosmat|mospart' | perl -pe 
's/(\w+)\.sas\@?/%include mosaics($1);/' > TESTMOS.SAS
*/

/* The following FILENAME and LIBNAME should point to the directory
    where the mosaic programs were installed;
filename mosaics  '~/sasuser/mosaics/';
libname  mosaic   '~/sasuser/mosaics/';
*/

%include mosaics(druguse);
%include mosaics(ishi);
%include mosaics(karger);
%include mosaics(mosademo);
%include mosaics(mosdata);
%include mosaics(moseye);
%include mosaics(victims);



