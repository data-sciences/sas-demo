/*-------------------------------------------------------------------*/
 /*         SAS FOR FORECASTING TIME SERIES, SECOND EDITION           */
 /*          by John C. Brocklebank and David A. Dickey               */
 /*       Copyright(c) 2003 by SAS Institute Inc., Cary, NC, USA      */
 /*                   SAS Publications order # 57275                  */
 /*  Jointly co-published by SAS Institute and John Wiley & Sons 2003 */
 /*                   SAS ISBN 1-59047-182-2                          */
/*               John Wiley & Sons, Inc. ISBN 0-471-39566-8            */
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
 /* Books by Users                                                    */
 /* Attn: John Brocklebank and David Dickey                           */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  sasbbu@sas.com             */
 /* Use this for subject field:                                       */
 /*     Comments for John Brocklebank and David Dickey                */
 /*                                                                   */
 /*-------------------------------------------------------------------*/


 /* Use the DATA steps below with the appropriate PROC statements in  */
 /* Chapter 1, "Overview of Time Series," of the SAS FOR              */
 /* FORECASTING TIME SERIES, SECOND EDITION, to produce Output 1.1-   */
 /* Output 1.2.                                                       */


DATA SALES;
   T=0;
   ONE: 
   T=T+1;
   IF T>1 THEN GO TO TWO;
   E1=0;
   ADV1=150000;
   COMP1=2000000+500000*NORMAL(1137745)/SQRT(.51);
   TWO:
   E=300000*NORMAL(1137745);
   COMP=2000000 +.7*(COMP1-2000000) +500000*NORMAL(1137745);
   ADV=150000+NORMAL(1137745)*30000;
   SALES=3000000-.6*(COMP-2000000)+10*(ADV-ADV1)+E+.7*E1;
   OUTPUT;
   RETAIN;
   E1=E;
   ADV1=ADV;
   COMP1=COMP;
   IF T < 120 THEN GO TO ONE;
RUN;

DATA SALES;
   SET SALES(FIRSTOBS=41);
   T=_N_;
   DATE='01DEC77'D;
   DATE=INTNX('MONTH',DATE,_N_);
   FORMAT DATE MONYY5.;
   FORMAT SALES E7.;
RUN;

DATA NCSALES;
  adv1 = round(10000 + 1000*normal(2871381)/.8);
  comp1 = 20875 ; Z  = 1000;
do t=1 to 80;
  adv = 10000 + .6*(adv1-10000) + 1000*normal(1828713);
  comp = 20000 + .95*(comp1-20000) +  5000*normal(1828713);
  adv = round(adv); comp=round(comp);
   Z = .2*Z +  4000*normal(1827655);
  sales = round( 40000 +  6*(adv-.9*adv1) -.6*comp + Z);
  delta = adv-adv1;
  keep sales adv adv1 comp comp1 delta t; 
  output; 
  adv1=adv; comp1=comp; 
end;
run;
DATA NCSALES;
   SET NCSALES/*(FIRSTOBS=41)*/;
   T=_N_;
   DATE='01DEC77'D;
   DATE=INTNX('MONTH',DATE,_N_);
   FORMAT DATE MONYY5.;
   /*FORMAT SALES E7.;*/
run;

 /* Use the DATA step below with the appropriate PROC statements in   */
 /* Chapter 1, "Overview of Time Series," of the SAS FOR              */
 /* FORECASTING TIME SERIES, SECOND EDITION, to produce Output 1.3-   */
 /* Output 1.9.                                                       */

DATA SALES;
   INPUT T SALES @@;
   SALES = ROUND(SALES /1000000,.01);
   DATE = INTNX('MONTH','01JAN83'D,T-1);
   FORMAT DATE MONYY.;
   MONTH=MONTH(DATE);
   QTR = QTR(DATE);
   YEAR=YEAR(DATE);
CARDS;
   1    3015233240    2    2955239916    3    3515214728    4    3542214765  
   5    3760171602    6    3861710890    7    3948119154    8    3857400765  
   9    3991808107   10    3948837758   11    3921635986   12    4589204139  
  13    3582540514   14    3593985541   15    3999557560   16    4140218132  
  17    4281220370   18    4432775221   19    4159835215   20    4315634965  
  21    4148268958   22    4298093629   23    4198142376   24    4865188861  
  25    3822276523   26    3738759522   27    4172822522   28    4499215432  
  29    4659777577   30    4712862641   31    5138285448   32    4552951360  
  33    4629119174   34    4407727513   35    4480340715   36    5092533750  
  37    4168979178   38    3758286873   39    4762263293   40    4836162269  
  41    4563588932   42    4952266631   43    4914763054   44    4817538596  
  45    4898717646   46    4238335573   47    5053206004   48    5259807722  
  49    3831340056   50    4195136895   51    4814880192   52    5056575931  
  53    5014523206   54    5350107966   55    5199749767   56    5137618567  
  57    5092012083   58    5021674707   59    5230130577   60    5513206337  
  61    4365582516   62    4763441579   63    5421186857   64    5304659927  
  65    5414260129   66    5567846625   67    5284476010   68    5609751909  
  69    5408956886   70    5410544436   71    5480087886   72    5938593773  
  73    4739957101   74    4892357822   75    5510490235   76    5528040726  
  77    5759246907   78    5849332089   79    5606143536   80    5767758001  
  81    5523094676   82    5204967070   83    5356075563   84    5755816787  
  85    5740884501   86    4764878261   87    4350542761   88    5330998336  
  89    5440514664   90    5534389517   91    5296402425   92    5432986126  
  93    5381120395   94    5507066162   95    5428411250   96    5686731051  
  97    4848427291   98    4527984507   99    5348286416  100    5499316297  
 101    5547571463  102    5537091238  103    5476273000  104    5545760000  
 105    5342833000  106    5189157303  107    5884632993  108    5939546709  
 109    5092972858  110    5024931153  111    5487910805  112    5839360817  
 113    5762005354  114    6006131480  115    5994432994  116    5816598976  
 117    6020755821  118    5374133502  119    6236755808  120    6226614995  
 121    5413204686  122    5741224957  123    6006012812  124    5949198302  
 125    6439172197  126    6534264382  127    6428879136  128    6332846966  
 129    6597102019  130    6174000990  131    6549795335  132    7107194675  
 133    5588577234  134    6386696014  135    6790093648  136    6665606199  
 137    6874612107  138    7046904256  139    6981728317  140    6937376730  
 141    7211616880  142    7365763115  143    6758181964  144    8533735305  
;
RUN;

** Compute monthly means **;
PROC GLM DATA=SALES; CLASS MONTH;
  MODEL SALES = T|T|T|T|T|T|T|T MONTH/SOLUTION;
RUN;

** Convert monthly to quarterly sales ***;
PROC MEANS NOPRINT; 
 VAR SALES;
 BY YEAR QTR;  ID DATE;
 OUTPUT OUT=NCSALES SUM=QSALES;
RUN;

** Macro for high degree polynomial and seasonal dummies **;
%MACRO XGEN;
   TT+1; T1=TT; T2=T1*T1; T3=T2*T1; T4=T2*T2; T5=T2*T3; T6=T3*T3;
   T7=T3*T4; T8=T4*T4 ; T9=T5*T4;
   S1 = (QTR=1); S2=(QTR=2); S3=(QTR=3); S4=(QTR=4);
   Q4_HAT = 679.43 - 44.9929*T1 + 0.99152*T2;
%MEND XGEN;

** Add Xs to data **;
DATA NCSALES;
   SET SALES END=EOF ;
   CHANGE = QSALES-LAG(QSALES);
    %XGEN;
   FORMAT DATE YYQ.;
   OUTPUT;
RUN;

**display output 1.3**;
PROC PRINT DATA=NCSALES;
  FORMAT DATE YYQ4.;
  VAR DATE CHANGE S1 S2 S3 T1 T2;
RUN;

** extended data for forecasting **;
DATA EXTRA;
   DO T=49 TO 56;
      QSALES=.; SALES=.; CHANGE=.;
      DATE = INTNX('QTR','01JAN83'D,T-1);
      FORMAT DATE YYQ.;
      MONTH=MONTH(DATE);
      QTR=QTR(DATE);
      YEAR=YEAR(DATE);
      TT=T-1;
       %XGEN;
      OUTPUT;
   END;
RUN;

**display output 1.7**;
PROC PRINT DATA=EXTRA;
   FORMAT DATE YYQ4.;
   VAR DATE CHANGE S1 S2 S3 T1 T2;
RUN;

** predictions **;
DATA ANNO;
   XSYS="2"; YSYS="2";
   SET OUT1; FUNCTION = "move"; Y=P; X=DATE; OUTPUT;
   FUNCTION = "draw"; Y=Q4_HAT; OUTPUT;
RUN;

** Fit high degree polynomials and check fit **;
PROC AUTOREG DATA=ALL;
  MODEL QSALES = T1 T2 T3  S1 S2 S3/NLAG=13 BACKSTEP;
OUTPUT OUT=OUT3 PREDICTED=P3;
RUN;

PROC AUTOREG DATA=ALL;
  MODEL QSALES = T1 T2 T3 T4 T5 T6 S1 S2 S3/NLAG=13 BACKSTEP;
OUTPUT OUT=OUT6 PREDICTED=P6;
RUN;

PROC AUTOREG DATA=ALL;
  MODEL QSALES = T1 T2 T3 T4 T5 T6 T7 S1 S2 S3/NLAG=13 BACKSTEP;
OUTPUT OUT=OUT7 PREDICTED=P7;
RUN;

PROC AUTOREG DATA=ALL;
  MODEL QSALES = T1 T2 T3 T4 T5 T6 T7 T8 S1 S2 S3/NLAG=13 BACKSTEP;
  OUTPUT OUT=OUT8 PREDICTED=P8;
RUN;

DATA POLY;
   MERGE OUT3 OUT6 OUT7 OUT8;
   IF P8>38000 THEN P8=.;
RUN;



 /* The following should produce Output 1.10*/
 
DATA CURVE;
   DO
      X = 0 TO 4 BY .25;
      TYPE = 'B0=10 B1=2  ';
      Y = 10*2**X;
   OUTPUT;

      TYPE='B0=170 B1=.1 ';
      Y = 170*.1**X;
   OUTPUT;

      TYPE='B0=170 B1=.5 ';
      Y = 170*.5**X;
   OUTPUT;

      TYPE ='B0=2 B1=2 ';
      Y = 2*2**X;
   OUTPUT;

      TYPE='B0=2 B1=3 ';
      Y = 2*3**X;
   OUTPUT;
END;
RUN;

PROC SORT DATA=CURVE;
   BY TYPE ;
RUN;
LEGEND1 ACROSS = 2 ;


PROC GPLOT DATA=CURVE;
   PLOT Y*X = TYPE / LEGEND = LEGEND1 HMINOR=0 VMINOR=0;
      SYMBOL1 I=JOIN V=NONE L=1;
      SYMBOL2 I=JOIN V== L=1;
      SYMBOL3 I=JOIN V=NONE L=4;
      SYMBOL4 I=JOIN V=NONE L=2;
      SYMBOL5 I=JOIN V=DOT L=1;
   LEGEND1 LABEL=("_TYPE_");
   TITLE 'EXPONENTIAL CURVES';
   TITLE2 'MODEL Y=B0*B1**X';
RUN;


 /* Use the DATA step below with the appropriate PROC statements in   */
 /* Chapter 1, "Overview of Time Series," of the SAS FOR              */
 /* FORECASTING TIME SERIES, SECOND EDITION, to produce Output 1.11-  */
 /* Output 1.14.                                                      */

DATA TBILLS;
   INPUT DATE :MONYY. LFYGM3 :15.12 @@;
   FORMAT DATE MONYY.;

   /* To transform the logorithmic data for the first part of Output  */
   /* 1.12, use the following statement:                              */

   *LFYGM3= EXP(LFYGM3);         

CARDS;
 JAN62 1.000631880308 FEB62 1.004301609197 MAR62 1.000631880308
 APR62 1.004301609197 MAY62 0.985816794523 JUN62 1.004301609197
 JUL62 1.071583616280 AUG62 1.036736884950 SEP62 1.022450927703
 OCT62 1.007957920400 NOV62 1.040276711655 DEC62 1.054312029772
 JAN63 1.068153081183 FEB63 1.071583616280 MAR63 1.061256502124
 APR63 1.064710736992 MAY63 1.071583616280 JUN63 1.095273387403
 JUL63 1.156881196792 AUG63 1.199964782928 SEP63 1.217875709495
 OCT63 1.238374231043 NOV63 1.258460989610 DEC63 1.258460989610
 JAN64 1.258460989610 FEB64 1.261297870945 MAR64 1.264126727146
 APR64 1.244154593959 MAY64 1.247032293786 JUN64 1.247032293786
 JUL64 1.241268589070 AUG64 1.252762968495 SEP64 1.261297870945
 OCT64 1.272565595792 NOV64 1.291983681649 DEC64 1.345472366600
 JAN65 1.337629189139 FEB65 1.368639425881 MAR65 1.368639425881
 APR65 1.368639425881 MAY65 1.358409157630 JUN65 1.335001066732
 JUL65 1.345472366600 AUG65 1.345472366600 SEP65 1.366091653802
 OCT65 1.393766375959 NOV65 1.408544970055 DEC65 1.477048724388
 JAN66 1.523880024072 FEB66 1.536867219599 MAR66 1.523880024072
 APR66 1.530394705094 MAY66 1.534714366238 JUN66 1.504077396776
 JUL66 1.568615917914 AUG66 1.601405740737 SEP66 1.680827908521
 OCT66 1.677096560908 NOV66 1.671473303354 DEC66 1.601405740737
 JAN67 1.551808799597 FEB67 1.517322623526 MAR67 1.449269160281
 APR67 1.345472366600 MAY67 1.280933845462 JUN67 1.264126727146
 JUL67 1.437462647694 AUG67 1.451613827241 SEP67 1.486139696090
 OCT67 1.517322623526 NOV67 1.553925202504 DEC67 1.603419840109
 JAN68 1.609437912434 FEB68 1.605429891037 MAR68 1.642872688520
 APR68 1.682688374174 MAY68 1.733423892215 JUN68 1.708377860289
 JUL68 1.669591835254 AUG68 1.627277830562 SEP68 1.646733697178
 OCT68 1.677096560908 NOV68 1.695615608675 DEC68 1.785070481077
 JAN69 1.814824742159 FEB69 1.811562096524 MAR69 1.795087259321
 APR69 1.809926773184 MAY69 1.798404011947 JUN69 1.862528540116
 JUL69 1.945910149055 AUG69 1.943048916774 SEP69 1.958685340544
 OCT69 1.945910149055 NOV69 1.979621206398 DEC69 2.056684554557
 JAN70 2.063058062429 FEB70 1.964311234426 MAR70 1.891604804198
 APR70 1.873339456220 MAY70 1.922787731634 JUN70 1.899117987549
 JUL70 1.864080130808 AUG70 1.857859270933 SEP70 1.813194749948
 OCT70 1.776645831418 NOV70 1.663926097718 DEC70 1.583093937094
 JAN71 1.490654376444 FEB71 1.308332819650 MAR71 1.217875709495
 APR71 1.350667183477 MAY71 1.420695787837 JUN71 1.558144618047
 JUL71 1.686398953570 AUG71 1.597365331200 SEP71 1.545432582458
 OCT71 1.495148766032 NOV71 1.439835128048 DEC71 1.388791241318
 JAN72 1.217875709495 FEB72 1.163150809806 MAR72 1.316408233656
 APR72 1.311031876619 MAY72 1.305626458052 JUN72 1.363537373997
 JUL72 1.381281819296 AUG72 1.391281902631 SEP72 1.539015448138
 OCT72 1.556037135707 NOV72 1.564440546503 DEC72 1.623340817603
 JAN73 1.688249092858 FEB73 1.722766597741 MAR73 1.806648081722
 APR73 1.834180185112 MAY73 1.850028377352 JUN73 1.972691171733
 JUL73 2.080690761080 AUG73 2.159868790792 SEP73 2.115049969147
 OCT73 1.976854952905 NOV73 2.057962510003 DEC73 2.008214032391
 JAN74 2.050270164380 FEB74 1.962907725424 MAR74 2.074428999856
 APR74 2.119863456179 MAY74 2.107786014689 JUN74 2.066862759473
 JUL74 2.021547563261 AUG74 2.192770226987 SEP74 2.086913556519
 OCT74 2.009555414216 NOV74 2.010894999145 DEC74 1.967112356706
 JAN75 1.834180185112 FEB75 1.704748092238 MAR75 1.702928255521
 APR75 1.724550719535 MAY75 1.654411278077 JUN75 1.675225652972
 JUL75 1.813194749948 AUG75 1.862528540116 SEP75 1.859418117702
 OCT75 1.785070481077 NOV75 1.701105100960 DEC75 1.693779060868
 JAN76 1.583093937094 FEB76 1.585145219865 MAR76 1.609437912434
 APR76 1.581038437912 MAY76 1.648658625587 JUN76 1.688249092858
 JUL76 1.654411278077 AUG76 1.637053079467 SEP76 1.625311261590
 OCT76 1.593308530504 NOV76 1.558144618047 DEC76 1.470175845101
 JAN77 1.530394705094 FEB77 1.541159071681 MAR77 1.526056303495
 APR77 1.512927012053 MAY77 1.601405740737 JUN77 1.613429933704
 JUL77 1.646733697178 AUG77 1.702928255521 SEP77 1.759580570864
 OCT77 1.818076777545 NOV77 1.808288771179 DEC77 1.803358605071
 JAN78 1.862528540116 FEB78 1.864080130808 MAR78 1.838961070712
 APR78 1.838961070712 MAY78 1.857859270933 JUN78 1.906575143657
 JUL78 1.947337701046 AUG78 1.957273907706 SEP78 2.060513531794
 OCT78 2.078190759778 NOV78 2.156402582816 DEC78 2.206074192613
 JAN79 2.235376343301 FEB79 2.232162628697 MAR79 2.249184316267
 APR79 2.247072383064 MAY79 2.262804222982 JUN79 2.203869120055
 JUL79 2.223541885654 AUG79 2.253394848803 SEP79 2.328252839743
 OCT79 2.459588841804 NOV79 2.467251714549 DEC79 2.488234439881
 JAN80 2.484906649788 FEB80 2.554121718809 MAR80 2.721295427852
 APR80 2.580216829592 MAY80 2.149433913500 JUN80 1.955860479908
 JUL80 2.086913556519 AUG80 2.211565694607 SEP80 2.329227023940
 OCT80 2.452727751424 NOV80 2.619583219780 DEC80 2.740194654429
 JAN81 2.709382646336 FEB81 2.693951276723 MAR81 2.592265168108
 APR81 2.616665639300 MAY81 2.791165107813 JUN81 2.689886230475
 JUL81 2.704711299837 AUG81 2.741484977188 SEP81 2.687847493785
 OCT81 2.605648267484 NOV81 2.385086314506 DEC81 2.384165079986
 JAN82 2.507971922719 FEB82 2.601207105484 MAR82 2.540025949009
 APR82 2.541601993465 MAY82 2.492378664627 JUN82 2.523325759692
 JUL82 2.429217743927 AUG82 2.161021528672 SEP82 2.069391205826
 OCT82 2.042518187575
;
run;
