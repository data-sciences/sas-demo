

/*--------------------------------------------------------------------------------------*/
/*                  Multiple-Plot Displays: Simplified with Macros                      */
/*                                by Perry Watts                                        */
/*              Copyright(c) 2002 by SAS Institute Inc., Cary, NC, USA                  */
/*                       SAS Publications order # 58314                                 */
/*                             ISBN 1-59047-037-0                                       */
/*--------------------------------------------------------------------------------------*/
/*                                                                                      */
/* This material is provided "as is" by SAS Institute Inc.  There                       */
/* are no warranties, expressed or implied, as to merchantability or                    */
/* fitness for a particular purpose regarding the materials or code                     */
/* contained herein. The Institute is not responsible for errors                        */
/* in this material as it now exists or will exist, nor does the                        */
/* Institute provide technical support for it.                                          */
/*                                                                                      */
/*--------------------------------------------------------------------------------------*/
/*                                                                                      */
/* Questions or problem reports concerning this material may be                         */
/* addressed to the author:                                                             */
/*                                                                                      */
/* SAS Institute Inc.                                                                   */
/* Books by Users Press                                                                 */
/* Attn:  Perry Watts                                                                   */
/* SAS Campus Drive                                                                     */
/* Cary, NC   27513                                                                     */
/*                                                                                      */
/*                                                                                      */
/* If you prefer, you can send email to:  sasbbu@sas.com                                */
/* Use this for subject field:                                                          */
/* Comments for Perry Watts                                                             */
/*                                                                                      */
/*--------------------------------------------------------------------------------------*/
/* Date Last Updated:  6Mar02                                                           */ 
/*--------------------------------------------------------------------------------------*/

/*
SAS programs from "Multiple-Plot Displays: Simplified with Macros" are listed in the 
following order:
               GREPLAY Extension Macros
               Baseball Matrix
               Mouse Tumor Growth Study
               Survival Analysis
The extension macros are included into a calling program through the autocall facility,
and only the WINPRTC, CGM and HTML graphics devices are used in the programs. Input data
are read in with a CARDS statement.
*/

**GREPLAY Extension Macros


/*  -----------------------------------------------------------------------
    Program  :  DelGCat.sas
    Purpose  :  Delete all entries from the graphics catalog specified
                as a parameter.
     ------------------------------------------------------------------- */
%macro DelGCat(CatName);
  %if %sysfunc(cexist(&CatName)) %then
    %do;
       proc greplay igout=&CatName nofs;
         delete _all_;
       run;
       quit;
    %end;
%mend DelGCat;


/*  -----------------------------------------------------------------------
    Program  :  SizeIt.sas
    Purpose  :  Generates GOPTION HSIZE and VSIZE lengths given
                XMAX and YMAX from PROC GDEVICE. This macro
                corrects text and shape distortion that occurs when
                graphs are displayed through panels that do not conform
                to the aspect ratio defined by the relationship between
                XMAX and YMAX.
    Input    :  macro parameter values
    Output   :  GOPTIONS HSIZE and VSIZE statement
    Parms    :
            MARGIN  is the border surrounding the group of equal-sized
                    plots on a page. If 2.5 is entered, for example,
                    then a margin of 2.5% will surround the plots.
                    Horizontal and vertical margins have the same values.
            SCALEX  Each plot can be scaled along the X axis or the
                    Y axis. To get space between the plots enter a
                    value less than one (e.g. 0.9). Values greater
                    than 1 are not allowed. 
            SCALEY  The plots can also be scaled along the Y-axis.
                    The two axes can have different scales.
            NROWS   Number of rows containing plots 
            MAXNCOL Maximum number of plots in a row of plots 
            XMAX    used for calculating HSIZE
            YMAX    used for calculating VSIZE
     ------------------------------------------------------------------- */
 
%macro SizeIt(Margin=0,ScaleX=1,ScaleY=1,NRows=,MaxNCol=,XMax=,YMax=);

  %let margin2 = %sysevalf(2.0 * &margin);
  /* CORRECT PARM ERRORS */
  %if %sysevalf(&ScaleX gt 1.0,boolean) %then
    %do;
      %put Maximum ScaleX factor is 1.0;
      %let ScaleX=1.0;
    %end;
  %if %sysevalf(&ScaleY gt 1.0,boolean) %then 
    %do;
      %put Maximum ScaleY factor is 1.0;
      %let ScaleY=1.0;
    %end;
  %if %sysevalf(&NRows gt 8, boolean)  %then
    %do;
      %put Maximum Number of Rows of panels is 8;
      %let NRows=8;
    %end;

  /* CALCULATE VSIZE AND HSIZE. */
  %let VSize=%sysevalf(((100-&Margin2)/&NRows) * &ScaleY * &YMax *0.01);
  %let HSize=%sysevalf(((100-&Margin2)/&MaxNCol) * &ScaleX * &XMax *0.01);

  /*THE OUTPUT */
  goptions vsize=&VSize in hsize=&HSize in;
%mend SizeIt;


/*  -----------------------------------------------------------------------
    Program  :  Tmplt.sas
    Purpose  :  Generate a template for multiple plot displays.
                Also embed the TREPLAY macro so that it can be invoked
                as an option to replay plots lockstep through the newly
                generated template.
    Input    :  Macro parameter values
    Output   :  A template catalog entry (i.e. a template)
    Parms    :
            MARGIN  is the border surrounding the group of equal-sized
                    panels on a page. If 2.5 is entered, for example,
                    then a margin of 2.5% will surround the panels.
            SCALEX  Each panel can be scaled along the X axis or the
                    Y axis. To space the panels further apart, enter a
                    value less than one (e.g. 0.9). A value greater than
                    1 is not allowed.
            SCALEY  The panels can also be scaled along the Y-axis.
                    The two axes can be scaled differently.
            XLATEY  Translate-Y. The group of panels can be moved up or
                    down the vertical axis.
            XLATEX  Translate-X. The group of panels can move right or
                    left along the horizontal axis.
            R1...R8 Number of panels in Row1 to Row8
            COLOR   Color=border-color.
            ROTATE  Rotate=degrees. Only internal panels are rotated. The
                    title panel remains fixed.
            CLIP    Regulates graphics display beyond panel borders.
            IGOUT   Name of the Input graphics catalog.
            TC      Name of template catalog. 
            TNAME   Template name i.e. template catalog entry. 
            TREPLAY A switch for invoking the %treplay macro.
    ------------------------------------------------------------------- */

%macro Tmplt(Margin=0,ScaleX=1,ScaleY=1,XLateX=0,XLateY=0,
             R1= ,R2= ,R3= ,R4= ,R5= ,R6= ,R7= ,R8= ,
             color=NONE,rotate=0,clip=OFF,
             igout=work.gseg,tc=tempcat,tname=TmpMac,Treplay=N);

  /* THE TREPLAY MACRO USES MACRO VARIABLES IGOUT AND NPANELS FROM %TMPLT */
  %macro treplay;

  /* OBTAIN NUMBER OF PLOTS */
    %let indexL=%eval(%index(&igout,.)-1); /*INDEXLIBNAME -- EG WORK.GSEG = 4 */
    %let indexM=%eval(&indexL.+2);         /*INDEXMEMNAME */
    %let libname=%upcase(%substr(&igout,1,&indexL));
    %let memname=%upcase(%substr(&igout,&indexM));

     proc sql noprint;
       select left(trim(put(count(*),2.))) into :nplots
       from dictionary.catalogs
       where upcase(libname) eq "&libname"
         and upcase(memname) eq "&memname"
         and substr(objname,1,1) eq 'G';
     quit;

  /* WRITE THE TREPLAY COMMAND */
     proc greplay nofs igout=&igout tc=&tc;
     template &tname;

    %let numgrafs=%sysfunc(ceil(&nplots./&npanels.) );
    %let plot=1;
    %do i= 1 %to &numgrafs;
       treplay
      %do panel=1 %to &npanels;
         /* LAST PANEL IS ALWAYS THE GRAND TITLE GSLIDE */
          %if &panel eq &npanels %then
            %do;        
              &panel.:&nplots.  
            %end;
         /*****
          PUTS ALL NON GRAND-TITLE PLOTS ON A GRAPH. 
          FEWER THAN &NPANELS-1 OF THEM MAY APPEAR ON ONE
          PAGE IN A MULTIPLE-PAGE GRAPHICS DISPLAY.
         *****/
          %else %if &plot lt &nplots %then %do;
             &panel.:&plot.
             %let plot=%eval(&plot + 1);
          %end;
      %end;
    ;
   %end;
   run;
  %mend treplay;

  /* BACK TO TMPLT*/

  %let margin2 = %sysevalf(2.0 * &margin); 
  /*****
   CALCULATE MACRO VARIABLES:
     MAXNCOL IS THE MAXIMUM NUMBER OF PLOTS IN A ROW OF PLOTS
     NROWS   IS THE TOTAL NUMBER OF ROWS IN A GRAPH
     NPANELS IS THE SUM OF N1 ... N8
  *****/
  %let MaxNCol= 0;
  %let NRows= 0;
  %let NPanels=0;
  %do i=1 %to 8;
    %if &&r&i ne %then 
      %do;
        %let NROWS = &i; 
        %if &&r&i gt &MaxNCol %then %let maxncol=&&r&i;
        %let NPanels = %eval(&NPanels + &&r&i);
      %end;
  %end;
  %let Npanels = %eval(&NPanels +1); /*FOR GRAND TITLE*/

   proc greplay tc=&tc igout=&igout nofs;
     tdef &TName
     /* CORRECT PARAMETER ERRORS */
     %if %sysevalf(&ScaleX gt 1.0,boolean) %then
       %do;
         %put ==>Maximum ScaleX factor is 1.0;
         %let ScaleX=1.0;
       %end;
     %if %sysevalf(&ScaleY gt 1.0,boolean) %then
       %do;
         %put ==>Maximum ScaleY factor is 1.0;
         %let ScaleY=1.0;
       %end;

     /* WANT XLATES TO BE WITHIN THE BOUNDS OF THE MARGIN */
     /* X */
     %if %sysevalf(%sysevalf(-1.0 * &XLateX) gt &Margin , boolean) %then
       %do;
         %put ==>Maximum Abs(XLateX) is the Margin: &margin;
         %let XLateX = %sysevalf(-1.0 * &Margin );
       %end;
     %if %sysevalf(&XLateX gt &Margin , boolean) %then 
       %do;
         %put ==>Maximum XLateX is the Margin: &margin;
         %let XLateX = %sysevalf(&Margin );
       %end;
     /* Y */
     %if %sysevalf(%sysevalf(-1.0 * &XLateY) gt &Margin , boolean) %then
       %do;
         %put ==>Maximum Abs(XLateY) is the Margin: &Margin;
         %let XLateY = %sysevalf(-1.0 * &Margin );
       %end;
     %if %sysevalf(&XLateY gt &Margin, boolean) %then
       %do;
         %put ==>Maximum XLateY is the Margin: &margin;
         %let XLateY = %sysevalf(&Margin );
       %end;
     %if %sysevalf(&NRows gt 8, boolean) %then
       %do;
         %put Maximum Number of Rows of panels is 8;
         %let NRows=8;
       %end;

     /* CALCULATE PANEL COORDINATES */

     /*****
      HEIGHT AND WIDTH ARE CALCULATED FOR THE INDIVIDUAL PANELS.
      THE WIDTH OF EACH PANEL IS DETERMINED BY THE ROW CONTAINING
      THE GREATEST NUMBER OF PANELS. (MAXNCOL)  
     *****/
     %let height=%sysevalf((100-&Margin2.)/&NRows);
     %let width=%sysevalf((100-&Margin2.)/&MaxNCol);

     %let PanelNum=1;                
     %do row = 1 %to &NRows;        /* FOR Y COORDINATES */
       %do column = 1 %to &&R&row;  /* FOR X COORDINATES */ 
        /*****
         CALCULATE Y COORDINATES BY WORKING FROM TOP OF GRAPH 
         DOWNWARDS. THIS MAKES Y1 GREATER IN VALUE THAN Y2.
         CALCULATE Y1, Y2 ONCE PER ROW OF PANELS (WHEN &COLUMN=1)  
        *****/
         %if &column eq 1 %then
           %do;  
             %if &row eq 1 %then
               %do;             /*ROW1,COL1=PANEL1 UPPER LEFT */
                 %let y1=%sysevalf(100.0-(&margin ));   
               %end;
             %else 
               %do;
                 %let y1 = &y2;     /* NEXT ROW UPPER Y = PREVIOUS ROW LOWER Y */
               %end;
             %let y2=%sysevalf(&y1-&height);
           %end; /* CALCULATING Y COORDS */

           /*****
            CALCULATE X COORDINATES. THE NUMBER OF COLUMNS (PANELS PER ROW)
            CAN BE DIFFERENT. TEMPLATES ARE ALWAYS CENTERED LIKE THIS
                   |--||--||--|  (3 PANELS)
                     |--||--|    (2 PANELS)
            THEREFORE, GET COORDS FOR 1ST TEMPLATE TO THE FAR LEFT BY
            CALCULATING FROM THE MIDDLE (50%). WIDTH ALLOWS FOR MARGIN.
            E.G. THREE PANELS NO MARGIN: WIDTH=33.3. X1 = 50-(1.5*33.3) = 0. 
                 TWO PANELS,  2% MARGIN : WIDTH=48   X1 = 50-(1*48)     = 2.
           *****/
           %if &column=1 %then
             %do;
               %let x1 = %sysevalf(50-(&&R&row./2 * &width));
             %end;
           %else
             %do;
               %let x1=&x2;    /*Next col left-X = current col right-X */
             %end;
           %let x2=%sysevalf(&x1+&width);

           /* WRITE OUT A PANEL */
           &PanelNum / llx=&x1 ulx=&x1 urx=&x2 lrx=&x2
                       lly=&y2 uly=&y1 ury=&y1 lry=&y2
                       ScaleX=&ScaleX ScaleY=&ScaleY
                       XLateX=&XLateX XLateY=&XLateY
                       Rotate=&Rotate
                      %if %upcase(&color) ne NONE %then Color=&Color;
                      %if %upcase(&clip) ne OFF %then %str(clip);

           %let PanelNum=%eval(&PanelNum+1);

       %end; /* COLUMN */
     %end;   /* ROW */

    /* FOR THE GRAND TITLE */
    &PanelNum / llx=0 ulx=0 urx=100 lrx=100
               lly=0 uly=100 ury=100 lry=0;

   /* ASSIGN TEMPLATE */
   Template &TName;

   run;

   /* CONDITIONALLY INVOKE %TREPLAY -- FOR LOCK-STEP PANEL|PLOT ASSIGNMENTS */
  %if %upcase(&treplay) eq Y %then %do;
    %treplay;
  %end;
%mend Tmplt;


**Baseball Matrix


/*  -----------------------------------------------------------------------
    Program  :  PltBaseBallHTML.sas
    Purpose  :  Create a upper triangle scatter plot matrix with an
                abbreviated version the SCATMAT macro from "SAS System
                for Statistical Graphics"(577) by Michael Friendly.
                Use the GREPLAY extension macros to create the templates.
                Add source code for a Web drill-down application.
    Input    :  CARDS statement.
                Data are originally from "The 1987 Baseball Encyclopedia
                Update" published by Collier Books, Macmillan Publishing 
                Co., New York. Salary data from "Sports Illustrated (April
                20, 1987). Data appear in Michael Friendly "SAS System for
                Statistical Graphics" published by SAS Institute in 1991.
                (See pp. 598-607). 
    Output   :  A complete upper triangular matrix of baseball plots with
                drill-down capabilities. Output found in subdirectory
                referenced by filename WEBOUT. Run the application by
                opening UTMATRIX.HTML

                From original header comments by Michael Friendly:

  * SCATMAT SAS     Construct a scatterplot matrix - all pairwise     *
  *                 plots for n variables.                            *
  *                                                                   *
  * %scatmat(data=, var=, nvar=);                                     *
  *-------------------------------------------------------------------*
  * Author:  Michael Friendly             <FRIENDLY@YORKVM1>          *
  * Created:  4 Oct 1989 11:07:50                                     *
  * Revised:  24 May 1991 17:33:41                                    *
  * Version:  1.1                                                     *
  *      From ``SAS System for Statistical Graphics, First Edition''  *
  *      Copyright(c) 1991 by SAS Institute Inc., Cary, NC, USA       *
  * Macro params: var=variable list to be plotted, nvar is obvious    *
    ------------------------------------------------------------------- */
options mautosource;
options sasautos=(sasautos 'c:\sasauto');
options date number pageno=1;

footnote1;
title1;

data baseball;
  length league $1;
  input league batavgc runs hits years salary @@; 
  cards;
A  225  30  66   1    .  N  242  24  81  14  475  A  281  66 130   3  480  N  280  65 141  11  500
N  255  39  87   2   92  A  257  74 169  11  750  N  196  23  37   2   70  A  212  24  73   3  100
N  252  26  81   2   75  A  256  49  92  13 1100  A  281 107 159  10  517  N  249  31  53   9  513
N  259  48 113   4  550  A  263  30  60   6  700  N  255  29  43  13  240  A  209  20  39   3    .
N  282  89 158  15  775  A  213  24  46   5  175  A  282  57 104  12    .  N  248  16  32   8  135
N  223  72  92   1  100  A  256  55 109   1  115  A  310   4  10   6    .  N  254  60 116   6  600
A  292  73 168  18  777  A  277  92 163   6  765  N  254  32  73   7  708  N  259  50 129  10  750
N  274  92 152   5  625  A  266  90 137  14  900  A  266  42  84  17    .  N  252  55 108   3  110
N  278  70 141   9    .  A  275  83 168   5  613  A  235  23  49   7  300  N  307  38 106  14  850
A  232  19  36   4    .  N  223  24  60   2   90  A  273  31  98  16    .  N  253  34  61   1    .
A  216  15  41   2   68  N  263  21  54  18    .  N  272  23  57   9    .  A  231  32  46   4  180
A  256  19  40  11    .  A  236  28  68   6  305  N  293  57 132   3  215  A  254  34  57   5  248
A  300  46 140  16    .  N  270  71 146   6  815  A  271  42 101  17  875  N  261  30  53   2   70
A  317   1   7   4    .  A  292  80 168   9 1200  A  277  45 101  12  675  N  243  49 102   6  415
N  249  28  58   4  340  A  262  24  61  14    .  N  259  32  78  12  417  A  289  98 177   6 1350
A  272  58 113   1   90  N  246  21  44  16  275  A  242  27  56   4  230  N  227  31  53   4  225
A  176   1   3   3    .  A  263  93 139  17  950  N  211  12  37   4    .  A  233  29  53   3   75
A  252  67 142   4  105  A  275  44 113  12    .  N  267  42  81  17  320  N  217  18  31   3    .
A  261  69 131  14  850  A  251  78 122  18  535  A  268  86 137  15  933  A  286  57 119   9  850
N  281  55  97   4  210  N  257  24  55   8    .  A  255  59 103   6  325  A  273  37  96   4  275
A  236  70 118  16    .  N  263  49  70  15  450  A  332 117 238   5 1975  A  245  23  46   5    .
N  277  89 163  11 1900  A  248  50  83   9  600  N  301  89 174  14 1042  A  264  44  82   2  110
A  247  21  41  16  260  A  221  67 114   4  475  A  278  39  83   5  432  N  260  76 123   4 1220
A  246  35  78   1   70  A  277  76 138   3  145  N  272  24  69   8    .  N  278  54 119  12  595
A  286  90 148  14 1861  N  277  27  71  15    .  N  259  97 115   3  300  N  255  70 110   7  490
A  299  61 151  10 2460  A  267  69 132   2    .  A  249  41  49   8  375  A  248  48 106  10    .
A  292  67 114  13    .  A  245  15  37   6    .  N  215  55  95   3    .  A  260  76 154  14  750
A  287 101 198   5 1175  A  237  19  51   1   70  A  314  70 128  14 1500  N  233  33  76   5  385
N  271  81 125  13 1926  N  264  91 152   3  215  N  274  30  64  18    .  A  254  91 171   6  900
A  236  63 118   4  155  A  279  45  77  16  700  N  242  42  94   9  535  A  265  30  85   8  363
N  282  49  96  15  733  N  249  36  77  20  200  A  251  93 139   5  400  N  248  62  84   5  400
N  284  42 126  11  738  A  225  45  59  13    .  A  275  37  78   5  500  A  289  54 120   8  600
N  270  70 158   5  663  A  287  72 169   7  950  N  278  50 104   7  750  N  252  30  54   5  298
A  290  22  70  18  325  A  209  46  99   4   88  N  236  18  39   9  175  N  239  23  40   3   90
A  273 107 170   6 1238  A  275  48 103  15  430  A  257  33  69   5    .  A  234  65 103   2  100
A  249  85 144   2  165  A  279 108 200   4  250  N  275  34  55  12 1300  N  287  48 133  17  773
A  237  38  45  10    .  N  254  61 132   6 1008  A  255  18  39  14  275  A  288  80 183   5  775
A  275  58 136  11  850  A  280  32  70  15  365  A  260  32  61  11    .  A  236  26  41   2   95
N  309  33  86   1  110  N  273  48  95  10  100  N  266  58 147  10  278  A  249  56 102   5   80
N  288  37  94  13  600  N  272  60 100   4    .  A  279  35  93  15    .  A  262  83 163   3  200
A  241  24  47  12    .  N  288  67 174   6  657  A  224  13  39   3   75  A  303  98 200  13 2413
N  250  31  66  14  250  N  240  35  76   3  155  N  268  90 157   4  640  A  240  54  92   6  300
A  240  23  73   4  110  N  298  32  69   4    .  A  250  41  91  13  825  A  253  28  54   2    .
N  230  46 101   3  195  A  253  17  43   3    .  N  268  20  47  11  450  N  274  83 184   5  630
N  320  34  58   1   87  A  275  84 118   8 1300  A  300  69 150  14 1000  N  302  94 171  13 1800
A  289  85 147   6 1310  N  271  34  74  10  738  N  263  89 161   4  625  N  275  51  91   2  125
N  286  72 159   9 1043  N  283  62 136  10  725  A  235  69  85   7  300  A  304 119 223   3  365
N  229  31  64   1   75  N  281  66 127   7 1183  N  280  77 127   2  203  A  273  33  70  12  225
A  289  77 141  15  525  N  237  26  52   6  265  A  261  89 149   7  788  A  263  53  84  10  800
A  266  67 128  13  588  N  205  20  34   1    .  A  271  42  92   3  145  A  291  80 146   9    .
A  281  95 157  10  420  N  250  27  54   1   75  A  281  94 179   5  575  N  267  18  53   4    .
A  268  77 131   7  780  N  269  22  56   2   90  N  237  47  93   2  150  A  294  64 148  13  700
N  236  20  59   4    .  A  281  68 131   6  550  A  281  40  88   8    .  N  248  30  65   9  650
A  258  25  54   1   68  N  221  18  71   3  100  N  268  47  77   6  670  A  239  71 120   3  175
A  266  28  60   3  137  N  220   0   1   2 2127  N  264  36  94   7  875  A  233  26  43   3  120
N  276  38  75   3  140  N  282  89 167   4  210  N  277  61 110   7  800  N  248  34  76   4  240
A  257  43  93   5  350  N  238  35  76   4    .  A  261  58 137   2  175  A  255 105 152   2  200
N  252  46  84  12    .  N  247  67 144   9 1940  N  240  45  80   7  700  A  302  88 163   4  750
N  262  43  83  14  450  A  250  82 135   1  172  A  291  62 123   9 1260  A  269  86 160   5    .
N  303  15  52  24  750  A  262  41  56   5  190  A  288  61 154   6  580  N  232  33  72   5  130
A  275  35  77  12  450  A  247  50  96   5  300  A  238  22  56  12  250  N  261  42  70  16 1050
A  218  75 108   3  215  A  238  42  68  18  400  A  274  49 119   7    .  A  282  45 110   9  560
A  290 130 160   8 1670  A  263  65 101  20  488  A  182   2   6   1    .  A  231  42  82   5  425
N  278  51 145  11  500  N  237  28  44   1    .  A  271  42  80   7    .  A  257  35  76   6  250
A  258  31  52  12  400  A  268  50  90  10  450  N  266  52 135   9  750  A  218  32  68   1   70
N  263  57 119   7  875  N  205   8  27   4  190  N  248  42  68   6  191  N  287  68 178   6  740
N  245  38  86   4  250  N  260  32  57   3  140  A  264  50 101   1   98  A  256  59 113  12  740
N  271  73 149   1  140  A  249  25  63  10  342  N  279  35  84   2    .  A  287  82 163  13 1000
A  235  54 117   6  100  A  276  20  66   3   90  N  253  73 140   4  200  A  235  54 112   2  135
N  253  66 145   2  155  A  263  82 159   6  475  N  295  58 142  18 1450  N  208  44  96   4  150
A  243  53 103   2  105  A  235  67 122   4  350  N  284  91 210   6   90  A  143   1   2   2    .
A  264  88 169   8  530  A  247  42  76   8  342  A  248  69 152   6  940  A  295  91 213   4  350
N  260  48 103   8  327  N  248  26  70   4  250  N  326 107 211   5  740  N  254  26  68   7  425
A  264  36  63  17    .  N  276  48 141   8  925  A  245  53 120   4  185  N  211   2   4   1  920
N  256  24  43   7  287  A  225  21  47   6  245  A  254  19  46   5    .  A  282  17  61  17  235
N  286  56 147   7 1150  N  255  56 138   3  160  N  279  14  51  23    .  A  257  76 113   5  425
N  281  17  42  10  900  N  305  91 194   8    .  N  286  14  32  19  500  N  261  35  69   4  278
N  254  50 112   7  750  N  250  94 139   2  160  N  276 107 186   6 1300  N  250  37  81   7  525
N  285  67 124   7  550  A  352 107 207   5 1600  N  287  66 117   1  120  A  290  82 172   1  165
N  266  21  53   8    .  N  298  65 127   5  700  A  274  76 136  12  875  A  255  61 126   6  385
A  268  85 144   8  960  A  297  77 170  11 1000
run;

%macro SCATMAT( data=?, var=?, nvar=?, group=?);
/* MANIPULATE DATA FOR DISPLAY */
  %let linknum=1;
  %do i = 1 %to &nvar;                   /* ROWS */
    %let vi = %scan(&var , &i );
       proc means noprint data=&data;
         var &vi;
         output out=minmax min=min max=max;
       run;

    %do j = &i %to &nvar;                     /* COLS - GET TRIANGULAR MATRIX HERE */
      %let vj = %scan(&var , &j );
      /* CREATE ANNOTATE DATA SET TITLE FOR DATA DEPENDENT ANNOTATIONS */
      %if &i = &j %then
        %do;                                    /* DIAGONAL PANEL */
          data title;
            length text style function $8;
            set minmax;
            style='SWISS'; function = 'LABEL';
            xsys = '1'; ysys = '1';            /*ABS % OF DATA AREA*/
            x = 50; y = 50;                    /*RIGHT IN THE MIDDLE*/
            text = "&vi";                      /*VARIABLE NAME */
            size = 1.5 * &nvar;
            output;

            style='SWISS'; function = 'LABEL';
            xsys='2'; ysys='2';
            function='label'; 
            x = min; y = min; position = '3';  /*LEFT JUSTIFY*/
            text = left(put(min, best6.));
            size = 1.2 * &nvar;                /*MORE PLTS LARGER FOR VISIBILITY*/
            output;

            style='none'; function = 'symbol'; 
            text='dot'; color='black'; output;

            style='SWISS'; function = 'LABEL';
            x = max; y = max; position = 'D';  /*RIGHT JUSTIFY*/
            text = trim(put(max, best6.));
            size = 1.2 *&nvar;
            output;

            style='none'; function = 'symbol'; 
            text='dot'; color='black'; output;
            symbol1 c=white i=none font=swiss v=none h=7;
          run;
          proc gplot data = &data;            /* TICK MARKS */
              plot &vi * &vi
                / frame anno=title vaxis=axis1 haxis=axis1;
                  axis1 label=none value=none major=(h=-%eval(&nvar-1) n=4 w=10)
                  minor=none w=10 offset=(2);
          run;
        %end;
      %else 
        %do;                                  /* OFF-DIAGONAL PANEL */   
          data subset(keep= &vi &vj &group links);
            length links $40; 
            set &data;   
            /*****
             MACRO LINKS ASSIGNMENT REPLACES SERIES:
             LINKS='HREF="YBYX1.HTML"';
             ...
             LINKS='HREF="YBYX10.HTML"';
            *****/
            links="href="||quote("YbyX&linknum..html");
          run;
          symbol1 c=black i=none font=swiss v=+ h=9;
          symbol2 c=black i=none font=swiss v=X h=8;
          proc gplot data = subset imagemap=dummymap;
            title1;
            plot &vi * &vj = &group
               / frame nolegend vaxis=axis1 haxis=axis1 html=links;
                 axis1 label=none value=none major=none minor=none
                 w=10 offset=(2);
          run;
          %let linknum = %eval(&linknum + 1);
        %end;  /* OFF-DIAGONAL PANEL */   
    %end;      /* COLS */
  %end;        /* ROWS */
%mend Scatmat;

/*****
 SET UP GRAPHICS ENVIRONMENT BEFORE INVOKING THE SCATMAT MACRO. 
 SUBSTITUTE YOUR OWN LOCATION FOR WEBOUT. THIS IS THE ONLY
 ADJUSTMENT YOU HAVE TO MAKE TO THE PROGRAM.
*****/

filename webout 'c:\BBU\ScatterPltMtrx\HTMLTest';
goptions reset=global gunit=pct
ftext=swiss rotate=landscape;

goptions gsfname=webout device=html;

%delgcat(work.gseg);
%SCATMAT( data=work.baseball, 
          var=%str(batavgc,runs,hits,years,salary),
          nvar=5,
          group=league);
proc gslide;
  footnote1 h=2.5 j=l 'ADAPTED FROM: "SAS System for Statistical Graphics"';
  footnote2 h=2.5 j=l 'BY: Michael Friendly';
  footnote3 h=2.5 j=l 'AMERICAN LEAGUE:' h=3 '+';
  footnote4 h=2.5 j=l 'NATIONAL LEAGUE: X';
  title1 h=3.5 'Upper Triangle Scatterplot Matrix for Baseball Data';
run;

goptions reset=goptions;
goptions nocharacters transparency noborder
  xmax=5.75in ymax=4in
  gsfname=webout device=GIF;

%Tmplt(Margin=2.5, XLateY=-2.5, ScaleY=0.95, ScaleX=0.95,
       R1=5, R2=5, R3=5, R4=5, R5=5);
       ods html body='UTMatrix.html' path=webout;
           treplay 1:1  2:2  3:3    4:4    5:5
                        7:6  8:7    9:8   10:9
                           13:10  14:11  15:12
                                  19:13  20:14
                                         25:15  
                  26: 16;
   
quit;
ods html close;

/*****
 DO NOT ISSUE A QUIT STATEMENT INSIDE THE MACRO ZOOM. SUBSEQUENT
 TREPLAY COMMANDS ARE RELATED TO THE SINGLE INVOCATION OF GREPLAY
 INSIDE TMPLTMAC. A QUIT WOULD ONLY BE VALID IF THE ZOOM MACRO ISSUED
 A CALL TO PROC GREPLAY TOO. ODS WORKS WELL WITH THESE CONVENTIONS.
 *****/

%Tmplt(Margin=2, R1=2, R2=2);

%macro zoom(num,treplay);
  ods html body="YbyX&num..html" path=webout;
    treplay &treplay;
  ods html close;
%mend zoom;

%zoom(1,%str(1:1 2:2 4:6));
%zoom(2,%str(1:1 2:3 4:10));
%zoom(3,%str(1:1 2:4 4:13));
%zoom(4,%str(1:1 2:5 4:15));
%zoom(5,%str(1:6 2:7 4:10));
%zoom(6,%str(1:6 2:8 4:13));
%zoom(7,%str(1:6 2:9 4:15));
%zoom(8,%str(1:10 2:11 4:13));
%zoom(9,%str(1:10 2:12 4:15));
%zoom(10,%str(1:13 2:14 4:15));

ods listing;
quit;


**Mouse Tumor Growth Study
/*  -----------------------------------------------------------------------
    Program  :  Plot32MiceHTML.sas
    Purpose  :  Produce drill down web-access version of the 32 mice
                plots. Pressing a DOT enables you to toggle between
                two graphs of 16 plots each. Click on a data point in
                an individual plot to drill down to four enlarged plots
                from the same row in the 16 plot display.
    Notes    : *The regression lines are NOT reproduced in version 8.1
                SAS. They are in Version 8.0 and Version 8.2.
               *If you ever see a partial display of a GIF file, back
                out via the Web browser and try again. The problem
                corrects itself this way.
               *If the text at the top of the pages is too large, just
                rerun the program in the same session to recreate the
                HTML files. The size of the text is corrected this way.
    Input    :  CARDS statement
    Output   :  Output found in the subdirectory referenced by filename 
                WEBOUT. Run the application by opening FIRST16.HTML
    ------------------------------------------------------------------- */
 
options SASAUTOS=(sasautos 'c:\sasauto');
footnote1;
 
proc format;
  value grpfmt 1='A' 2='B' 3='C' 4='D';
run;

/*****
 DATA CONVERTED FROM ONE ROW CONTAINING LEFT AND RIGHT TUMORS
 FOR 4 GROUPS OF MICE WITH 4 MICE IN EACH GROUP FOR ONE DAY
 TO A ROW OF DATA (LEFT AND RIGHT TUMORS) ON ONE MOUSE FOR ONE DAY.
 FROM: [ROW# DAY] T1-T32
 TO:   [MOUSEID DAY] LEFTT RIGHTT
 MICE ARE NOW NUMBERED WITH IDS RANGING FROM 1 TO 8. ALL NEGATIVE
 MEASUREMENTS ARE CONVERTED TO MISSING.
*****/
data raw(keep=Day i Id Group LeftT RightT);
  array v[32] v1-v32;
  input row day v1-v32;
  do i=1 to 32;
    if(mod(i,8)=0)then
      group=floor(i/8);
    else
      group=ceil(i/8);
    if(mod(i,2)=1)then
      do; /*odd number for i*/
        LeftT=v[i];
        if(LeftT lt 0)then LeftT=.;
      end;
    else 
      do; /*even number for i*/
        id=floor(i/2);           /*2,4,6,...64 BECOMES 1,2,3,...32*/
        id=mod(id,4);            /*1,2,3,...32 BECOMES 1,2,3,0*/
        if(id=0) then id=4;      /*1,2,3,0 BECOMES 1,2,3,4*/
        if(row=2) then id=id+4;  /*FOR ROW 2, 1,2,3,4 BECOMES 5,6,7,8*/
        RightT=v[i];
        if(RightT lt 0) then RightT=.;
        output;
      end;
  end;
cards;
1 13 
14 0.5 6.3 4.2 0.5 4.2 14 4.2 0.5 4.2 1 0.5 4.2 0.5 4.2 6.3
8.4 6.3 6.3 6.3 18.8 14 6.3 4.2 0 0 0 4.2 0.5 0 33.5 0.5
2 13
6.3 4.2 4.2 6.3 0.5 0 6.3 4.2 0.5 0 4.2 4.2 0 6.3 6.3 6.3
4.2 256 335 4.2 18.8 6.3 1.0 1.0 0.06 1 1.0 1.0 1 0.5 0.06 0
1 16 
179.5 33.5 8.37 179.5 6.3 33.5 466.3 424 4.2 65.4 8.4 18.8 33.5 18.8 42 50 
170 105 205 78.5 170 205 231 78.5 18.8 0 14 18.8 6.3 65.4 268 4.2
2 16 
231 78.5 466.3 105 42 14 207 132 0.5 0 18.8 33.5 0 78.5 205 231 
78.5 256 696.5 256 188 178 104.7 231 1 8.4 18.8 18.8 6.3 6.3 0.5 0.06
1 18 
301 65.4 83.7 188.4 197 37.7 523 523 6.3 78.5 18.8 18.8 78.5 18.8 91.6 67
381.5 118 179.5 113 231 231 78.5 20.5 65.4 0 33.5 42 12.6 132 381.5 4.2
2 18 
188.4 150.7 256 188.4 78.5 4.2 245 118 0.5 0 50 42 0 113 256 231 
42 402 696.6 132 188 105 105 151 1 10.5 132 18.8 42 14 0.5 0.06
1 20 
466 91.6 207 268 151 335 697 509 42 151 151 78.5 91.6 50 335 282 
523 576 301 301 424 335 179.5 368.4 132 0 113 132 151 20.5 523 18.8
2 20 
256 301 680 402 113 6.3 636 268 14 0 132 113 0 132 368 256 
132 509 1130 576 368 169.6 205 301.4 14 188 205 42 78.5 33.5 1 0.06
1 22 
678 231 282 678 205 576 1503 576 78.5 256 131 78.5 170 105 256 368 
268 509 167 205 466 205 167 256 78.5 0 78.5 132 105 151 424 18.8
2 22 
551 636 785 680 256 14 785 509 14 0 151 268 6.3 231 697 282 
118 509 886.5 466 282 91.6 231 335 14 301 205 50 65 18.8 1 0.06
1 24 
942 282 368 1206 466 466 1503 368 91.6 256 231 78.5 169.6 91.6 256 268 
576 368 205 268 368 205 151 308 78.5 0 78.5 151 105 151 523 23.6
2 24 
593 1013 733 823 368 14 1503 466 33.5 14 231 268 18.8 205 886.5 335 
78.5 509 980 301 207 151 170 509 6.3 301 179.5 42 23.6 18.8 0.5 0.06
1 26 
1432 466 435 1592 402 785 2411 837 170 402 282 268 256 205 402 551 
628 466 231 205 509 231 151 333 78.5 0 78.5 151 151 151 301 42
2 26 
733 1281 890 1130 466 42 1504 593 61 18.8 368 301 78.5 335 1013 402 
151 368 1238 301 226 105 282 282 6.3 151 179.5 50 65.4 18.8 0.5 0.06
1 28 
2034 466 733 1680 509 950 3349 785 308 733 551 268 402 256 469 1130 
628 628 231 301 509 424 188 226 65.4 0 78.5 205 78.5 205 301 42
2 28 
1013 1206 1203 1415 551 92 1857 785 368 18.8 282 424 205 335 1744 551 
151 509 1743 335 333 105 256 282 6.3 151 179.5 50 65.4 42 0.5 0.06
1 30 
2708 680 837 2813 785 1769 4409 890 368 1076 402 335 636 466 593 950 
636 733 509 301 950 760 256 593 -2 -2 151 466 170 335 523 205
2 30 
1356 2120 1769 1281 1055 151 1857 785 551 78.5 1055 523 301 628 205 785 
335 950 2679 301 245 151 435 435 84 335 435 59 180 78.5 -2 -2
1 32 
3349 1013 890 3081 1281 1583 4748 942 469 1140 502 402 636 509 837 1013 
733 696 435 424 1013 823 886 837 -1 -1 335 551 170 551 1130 151
2 32 
-2 -2 2473 2120 1503 231 2123 1238 436 151 335 424 886 697 1846 1130 
502 1327 2722 551 301 151 469 551 226 680 308 144 301 151 -1 -1
1 34 
-3 -3 -3 -3 -3 -3 -3 -3 636 1356 593 466 733 733 785 1013 
823 950 551 576 1206 1150 402 837 -1 -1 509 509 466 628 887 205
2 34 
-3 -3 -3 -3 -3 -3 -3 -3 436 231 781 576 466 509 3349 785 
308 1238 2511 424 339 151 402 950 402 551 551 207 301 151 -1 -1
1 36 
-3 -3 -3 -3 -3 -3 -3 -3 837 1507 837 628 837 887 950 1013 
1130 785 509 697 1846 1436 551 950 -1 -1 466 628 628 551 1238 301
2 36 
-3 -3 -3 -3 -3 -3 -3 -3 603 170 1281 823 466 628 3479 1013 
435 950 3391 697 462 231 551 1130 402 551 466 282 551 393 -1 -1
1 38 
-3 -3 -3 -3 -3 -3 -3 -3 837 1769 1076 733 890 1130 1238 1281 
1281 1076 723 760 1846 2002 593 950 -1 -1 576 628 409 680 1238 335
2 38 
-3 -3 -3 -3 -3 -3 -3 -3 670 301 1356 680 823 680 3630 1140 
466 1281 3589 760 603 231 950 1539 -2 -2 509 188 576 170 -1 -1
1 40 
-3 -3 -3 -3 -3 -3 -3 -3 636 2034 1076 733 1203 1415 1055 1680 
1281 1076 733 1206 2120 2571 680 1415 -1 -1 466 760 680 887 1539 368
2 40 
-3 -3 -3 -3 -3 -3 -3 -3 1151 402 1680 1327 1017 950 4409 2051 
466 1415 4156 823 -2 -2 950 1766 -1 -1 593 368 628 523 -1 -1
run;
 
proc sort data=raw out=sraw;
  by Group Id Day;
run;

proc format;
  value $grpidF
    11=1 12=2 21=3 22=4 31=5 32=6 41=7 42=8;
run;

data sraw(keep=Day Id Group By4 LeftT RightT links);
  length links $40;
  length incr chgrp $1 Concat By4 $2;
  set sraw;
  if id/8 le 0.5 then incr='1';   /* ID RANGES FROM 1-8 */
  else incr='2';
  chgrp=put(group,1.);            /* GROUP RANGES FROM 1-4 */
  Concat=left(trim(chgrp||incr));
  By4=put(concat,$grpidF.);
  select(By4);
    when ('1') links='href="by1.html"';
    when ('2') links='href="by2.html"';
    when ('3') links='href="by3.html"';
    when ('4') links='href="by4.html"';
    when ('5') links='href="by5.html"';
    when ('6') links='href="by6.html"';
    when ('7') links='href="by7.html"';
    when ('8') links='href="by8.html"';
    when ('9') links='href="by9.html"';
    when ('10') links='href="by10.html"';
    otherwise links='';
  end;
run;
 
data anno1;
  length html text $30 function style color $8 position $1;
  retain xsys '3' ysys '3';
  function='symbol'; style='none'; color='blue';
    text='dot'; size=2; x=60; y=97; html='href="Last16.html"';
    output;
  function='Label'; color='black'; style='swiss';
    size=1.25; x=62; y=97; position='6';
    text='Blue DOT For Last 16 Mice'; html=' ';
    output;
  stop;
run;
 
data anno2;
  length html text $30 function style color $8 position $1;
  retain xsys '3' ysys '3';
  function='symbol'; style='none'; color='red';
    text='dot'; size=2; x=60; y=97; html='href="First16.html"';
    output;
  function='Label'; color='black'; style='swiss';
    size=1.25; x=62; y=97; position='6';
    text='Red DOT For First 16 Mice'; html=' '; 
    output;
  stop;
run;
 
/*****
 CHANGE FILENAME TO FIT YOUR DIRECTORY STRUCTURE.
 THIS IS THE ONLY REQUIRED ADJUSTMENT IN THE PROGRAM.
*****/
filename webout 'c:\BBU\MicePgms\HTMLTEST';
 
goptions reset=global gunit=pct ftext=swiss rotate=landscape htext=7 htitle=8 hby=7;
 
goptions transparency noborder xpixels=450 ypixels=400 gsfname=webout device=html;
 
%DelGcat(work.gseg);
 
axis1 major=(w=4 h=.7) minor=none w=4 label=("Day");
axis2 major=(w=4 h=.9) minor=none w=4 label=("Size")
      order=(0 to 5000 by 1250) offset=(2,5);
symbol1 color=black v=star h=8 i=RC w=2;
symbol2 color=black v=dot  h=6.5 i=RC w=2;
 
/* GPLOT GENERATES 32 PLOTS */
proc gplot data=sraw uniform imagemap=dummymap;
  title1;
  by Group Id;
  plot LeftT*Day RightT*Day /overlay
                             haxis=axis1
                             vaxis=axis2
                             noframe
                             html=links;
  format group grpfmt.;
  format leftT rightT comma5.;
run;
 
/* GSLIDE GENERATES 2 PLOTS */
 
proc gslide anno=anno1;
  title1;
  footnote1;
  note h=3 move=(5,96.5) "ODS Drill Down Mouse Plots: First 16 Mice";
run;

proc gslide anno=anno2;
  title1;
  footnote1;
  note h=3 move=(5,96.5) "ODS Drill Down Mouse Plots: Last 16 Mice";
run;
 
goptions reset=goptions;
goptions transparency nocharacters noborder xpixels=450 ypixels=400
         xmax=8in ymax=5in gsfname=webout device=GIF;
 
%tmplt(Margin=3, XLateY=-2, ScaleY=0.95, ScaleX=0.95,
       R1=4, R2=4, R3=4, R4=4);
 
ods html body='First16.html' path=webout;
   treplay 1:1 2:2 3:3 4:4 5:5 6:6 7:7 8:8
           9:9 10:10 11:11 12:12
           13:13 14:14 15:15 16:16 17:33;
ods html close;
ods html body='Last16.html' path=webout;
   treplay 1:17 2:18 3:19 4:20
           5:21 6:22 7:23 8:24
           9:25 10:26 11:27 12:28
           13:29 14:30 15:31 16:32 17:34;
   quit; /* OK TO QUIT HERE */
ods html close;
 
goptions reset=goptions;
goptions transparency nocharacters noborder xmax=5.75in ymax=4in
         gsfname=webout device=GIF;

%Tmplt(Margin=2, R1=2, R2=2);

%macro zoom(num,treplay);
  ods html body="By&num..html" path=webout;
    treplay &treplay;
  ods html close;
%mend zoom;

%zoom(1,%str(1:1 2:2 3:3 4:4));
%zoom(2,%str(1:5 2:6 3:7 4:8));
%zoom(3,%str(1:9 2:10 3:11 4:12));
%zoom(4,%str(1:13 2:14 3:15 4:16));
%zoom(5,%str(1:17 2:18 3:19 4:20));
%zoom(6,%str(1:21 2:22 3:23 4:24));
%zoom(7,%str(1:25 2:26 3:27 4:28));
%zoom(8,%str(1:29 2:30 3:31 4:32));
 
ods listing;
quit;


**Survival Analysis

/*  -----------------------------------------------------------------------
    Program  :  KM2Strata.sas
    Purpose  :  Create K-M plots -- with 2 strata per plot for
                a multiple plot display.
                Replace PRINTTO with ODS to label
                the plots with homogeneity test results (Wilcoxon,
                Log-Rank tests).
    Notes    :  *Only two strata per plot
                *Only one title per graph listing the STRATA
                *One title per plot listing the GROUP identity
                *Terms:
                  A Stratum is expressed as a KM Curve.
                  A Group is expressed as a Plot.
                  A Graph contains multiple plots.
                *The macro is exercised once per PLOT.
                *Subset the data on the GROUP variable.
                *Do NOT issue the following with ODS:
                     proc datasets lib=work kill;
                     quit;
                 UNLESS you delete all the ODS Objects in the Results
                 window with the right mouse button. New ODS
                 objects and data will NOT be created.
                *%DelGCat also will NOT work if the Graphics window
                 is open. In V8, must close this window between runs.
                 VERY IMPORTANT.
                *Graphics device is WIN. If you change the device, most
                 likely you will need to adjust the font, text heights,
                 and line widths.
    Input    :  CARDS statement.
                Data and input data step are from SAS Sample Library.
                The VALUNG data originate with R.L. Prentice (1974)
                and are included in Appendix 1 of J.D. Kalbfleisch 
                and R.L. Prentice(1980): The Statistical Analysis of
                Failure Time Data. John Wiley and Sons, New York.
    Output   :  A plot with two strata. The macro is exercised
                multiple times for multiple plot displays.
    KM macro
    Parms    :
           LIBNAME   Libname for SAS data set.
           SDS       Input SAS Data Set (sds)
           STIME     Variable name for survival time (default=SURVTIME)
           CENSOR    Variable name for CENSOR: typically dead(1) or alive(0) 
                     (default=DORA)
           STRATVBL  Variable name for stratification variable.
           GRPVBL    Variable name for group variable
           GRPVAL    Value of GRPVBL for subsetting purposes.
           XLBL      For labeling TIME UNITS.  Used to label the X-axis.
           YLBL      For labeling the Y-axis. Usually "Survival".
           ABBSTRT1  Abbreviation of Stratum #1 value for identification
           ABBSTRT2  Abbreviation of Stratum #2 value for identification
           FIRSTTIME When True, X axis coordinates are determined for all plots
                     in the graph.
 ---------------------------------------------------------------------- */
options mautosource;
options sasautos=(sasautos 'c:\sasauto');
options date number pageno=1;
 
/*****
 READ IN DATA SET
*****/
data valung(Keep=therapy cell dora survtime);
   drop check m;
   retain therapy cell;
   infile cards column = column;
   length check $ 1;
   label t     = 'Failure or Censoring Time'
      kps      = 'Karnofsky Index'
      diagtime = 'Months till Randomization'
      age      = 'Age in Years'
      prior    = 'Prior Treatment?'
      cell     = 'Cell Type'
      therapy  = 'Type of Treatment'
      treat    = 'Treatment Indicator';
   m = column;
   input check $ @@;
   if m > column then m = 1;
   if check = 's' | check = 't' then input @m therapy $ cell $ ;
   else input @m t kps diagtime age prior @@;
   if t gt . and t le 600;
   censor=(t<0); t=abs(t);
   treat=(therapy='test');
   if censor=0 then dora=1;
   else dora=0;
   survtime=t;
cards;
standard squamous
72 60 7 69  0      411 70 5 64 10     228 60 3 38 0     126 60 9 63 10
118 70 11 65 10    10  20 5 49 0      82 40 10 69 10    110 80 29 68 0
314 50 18 43 0     -100 70 6 70 0     42 60 4 81 0      8 40 58 63 10
144 30 4 63 0      -25 80 9 52 10     11 70 11 48 10
standard small
30 60 3 61 0       384 60 9 42 0      4 40 2 35 0       54 80 4 63 10
13 60 4 56 0       -123 40 3 55 0     -97 60 5 67 0     153 60 14 63 10
59 30 2 65 0       117 80 3 46 0      16 30 4 53 10     151 50 12 69 0
22 60 4 68 0       56 80 12 43 10     21 40 2 55 10     18 20 15 42 0
139 80 2 64 0      20 30 5 65 0       31 75 3 65 0      52 70 2 55 0
287 60 25 66 10    18 30 4 60 0       51 60 1 67 0      122 80 28 53 0
27 60 8 62 0       54 70 1 67 0       7 50 7 72 0       63 50 11 48 0
392 40 4 68 0      10 40 23 67 10
standard adeno
8 20 19 61 10      92 70 10 60 0      35 40 6 62 0      117 80 2 38 0
132 80 5 50 0      12 50 4 63 10      162 80 5 64 0     3 30 3 43 0
95 80 4 34 0
standard large
177 50 16 66 10    162 80 5 62 0      216 50 15 52 0    553 70 2 47 0
278 60 12 63 0     12 40 12 68 10     260 80 5 45 0     200 80 12 41 10
156 70 2 66 0      -182 90 2 62 0     143 90 8 60 0     105 80 11 66 0
103 80 5 38 0      250 70 8 53 10     100 60 13 37 10
test squamous
999 90 12 54 10    112 80 6 60 0      -87 80 3 48 0     -231 50 8 52 10
242 50 1 70 0      991 70 7 50 10     111 70 3 62 0     1 20 21 65 10
587 60 3 58 0      389 90 2 62 0      33 30 6 64 0      25 20 36 63 0
357 70 13 58 0     467 90 2 64 0      201 80 28 52 10   1 50 7 35 0
30 70 11 63 0      44 60 13 70 10     283 90 2 51 0     15 50 13 40 10
test small
25 30 2 69 0       -103 70 22 36 10   21 20 4 71 0      13 30 2 62 0
87 60 2 60 0       2 40 36 44 10      20 30 9 54 10     7 20 11 66 0
24 60 8 49 0       99 70 3 72 0       8 80 2 68 0       99 85 4 62 0
61 70 2 71 0       25 70 2 70 0       95 70 1 61 0      80 50 17 71 0
51 30 87 59 10     29 40 8 67 0
test adeno
24 40 2 60 0       18 40 5 69 10      -83 99 3 57 0     31 80 3 39 0
51 60 5 62 0       90 60 22 50 10     52 60 3 43 0      73 60 3 70 0
8 50 5 66 0        36 70 8 61 0       48 10 4 81 0      7 40 4 58 0
140 70 3 63 0      186 90 3 60 0      84 80 4 62 10     19 50 10 42 0
45 40 3 69 0       80 40 4 63 0
test large
52 60 4 45 0       164 70 15 68 10    19 30 4 39 10     53 60 12 66 0
15 30 5 63 0       43 60 11 49 10     340 80 10 64 10   133 75 1 65 0
111 60 5 64 0      231 70 18 67 10    378 80 4 65 0     49 30 3 37 0
run;
 
 
%macro KM2(libname=?, sds=?, STime=survtime, censor=dora, StratVbl=?, GrpVbl=?,
           GrpVal=ALL, xlbl=Time(Months), ylbl=Survival,AbbStrt1=?, AbbStrt2=?,
           FirstTime=0);
 
  /* SET UP: GLOBAL MACRO VARIABLE DECLARATIONS */
  %global maxtime incr fuzz;
 
  /*SUBSET THEN SORT SO THAT THE STRATUM IS CORRECTLY ASSIGNED. */
  %if %upcase(&GrpVal) eq ALL %then 
    %do;
      data subset;
        set &libname..&sds;
      run;
    %end;
  %else 
    %do;
      data subset;
        set &libname..&sds(where=(upcase(&GrpVbl.) = upcase("&GrpVal.")));
      run;
    %end;
  proc sort data=subset;
    by &StratVbl;
  run;
 
  /* GET PRODUCT LIMIT ESTIMATE AND HOMOGENEITY TEST RESULTS WITH ODS */
  ODS listing close;
  ods output clear;
  ods output ProductLimitEstimates = PLE&GrpVal
             (keep=stratum &StratVbl &STime censor survival &GrpVbl);
  ods output HomTests = HT&GrpVal
             (keep=test ChiSq ProbChiSq);

  proc lifetest data=subset method=km;
    time &STime.*&censor.(0);
    id &GrpVbl;
    strata &StratVbl;
  run;

  ods listing;
  ods output close;
   
  /*****
   CREATE DATA TO BE PLOTTED
   SAS CREATED VARIABLES:
     STRATUM, SURVIVAL (FRACTION OF POP. SURVIVING) AND CENSOR.
   DATA SET VARIABLE: 
     PLE&GRPVAL SORTED IN STRATUM SURVIVAL ORDER.
   WHILE THERE ARE TWO STRATA, THERE IS A MAX OF FOUR CURVES PER PLOT.
   EACH STRATUM WILL HAVE AN EVENT (DEAD) CURVE (STEP LEFT JOIN LINE)
   AND OPTIONALLY A CENSOR CURVE (DISCRETE FORWARD SLASH TICK MARKS).
  *****/

  data plot(keep=&StratVbl stratum curve &STime censor survival);
    retain retsurv;
    set PLE&GrpVal;
    by STRATUM notsorted;
      /*****
       SAS THROWS IN AN EXTRA OBS IN THE BEGINNING OF EACH STRATUM
       WITH SURVIVAL=1.0. THUS RETSURV WILL ALWAYS RETRIEVE THE
       MOST RECENT NON-MISSING VALUE OF SURVIVAL.
      *****/
    if survival ne . then retsurv=survival;
    curve=stratum;
    if CENSOR eq 1 then survival=retsurv;
    if last.STRATUM and CENSOR eq 1 then
      do;
      /* DRAW A LINE TO THE LAST (CENSORED) OBSERVATION */
        CENSOR=0;
        output;
        CENSOR=1;
      end;
    if CENSOR eq 1 then curve=curve+0.1;
    if survival ne . then output;
  run;
 
  /*****
   GET MACRO VARS LOGRNK AND WILCOX CONTAINING CHI-SQUARES
   AND PVALS FROM DATA SET HT&GRPVAL (HOMOGENEOUS TESTS).
  *****/
  data _null_;
    set HT&GrpVal.;
    if test eq 'Log-Rank' then
      call symput('LOGRnk','Log-Rnk Chi-Sq: '||
                            left(put(chisq,8.3))||
                            'Prob: '||
                            put(ProbChiSq,6.3));
    else if test eq 'Wilcoxon' then
      call symput('WILCOX','Wilcoxon  Chi-Sq: '||
                            left(put(chisq,8.3))||
                            'Prob: '||
                            put(ProbChiSq,6.3));
  run;
 
  /* DEFINE GRAPHICS ELEMENTS (WIDTH, SYMBOL STMTS ETC.) */
  %let w1=5;           /* WIDTH OF AXES LINES AND DASHED PLOT LINE */
  %let ticksize = 4;   /* HEIGHT OF CENSOR MARK */
 
  /*****
   CREATE SYMBOL STMTS. REMEMBER, SURVIVAL PLOTS CAN COME WITHOUT
   CENSORS. CENSORS ARE DENOTED BY A FORWARD SLASH (/). LINES (CENSOR=0)
   HAVE INCREASING THICKNESS. DOUBLE QUOTES BELOW ARE A FUNCTION OF 
   SYMPUT NOT THE SYMBOL CLAUSE.
  *****/

  proc sort data=plot out=splot nodupkey;
    by curve CENSOR;
  run;
   
  data _null_;
    retain multiple 5;
    set splot end=last;
    by curve CENSOR;
    iter+1;
    if CENSOR =0 then
      do;
        solidw=iter*multiple;
        call symput('sstr'||left(put(iter,2.)),
                    "c=black i=steplj v=none l=1 w="||left(put(solidw,2.))||";");
      end;
    else
      do;
        call symput('sstr'||left(put(iter,2.)),
                    "c=black i=none font=swiss v=/ h=&ticksize;");
      end;
    if last then call symput('maxit',right(put(iter,2.)));
  run;

  /* HERE IS WHERE SYMBOL STATEMENTS ACTUALLY ARE PRINTED. */
  %do j=1 %to &maxit;
    symbol&j;           /* DELETE ALL PREVIOUS SYMBOL STMTS */
    symbol&j &&sstr&j;  /* NOW RE-ISSUE THE SYMBOL STATEMENT */
  %end;

  /*****
   REBUILD THE UNIFORM AXES:
    OBTAIN THE SAME X-AXIS COORDINATES FOR ALL PLOTS IN THE
    GRAPH. INCR MUST BE CALCULATED, BECAUSE THE DEFAULT VALUE
    IN THE ORDER CLAUSE IS 1. MAXTIME HAS TO BE LESS THAN LIMIT,
    SO THAT THE ANNOTATION WILL FIT ON THE SCREEN.
  *****/
  %if &firsttime eq 1 %then
    %do;
      data _null_;
        array limit(11) _temporary_
                        (10,20,50,100,200,500,600,1000,2500,5000,10000);
        array _incr(11) _temporary_
                        ( 1, 2, 5, 10, 25, 50, 75, 100, 250, 500, 1000);
        retain maxtime Nincr 0;
        set &libname. &sds. end=eof;
        if &STime gt maxtime then maxtime=&STime;
         if eof=1 then
           do;
             do i=1 to dim(limit);
               if maxtime lt limit[i] then
                 do;
                   incr = _incr[i];
                   Nincr = ceil(maxtime/incr);
                   maxtime = Nincr*incr;
                   leave;
                 end;
             end;
             if Nincr eq 0 then
               put "error computing maxtime in data set &libname..&sds.";
             else 
               do;
                 fuzz=0.01*maxtime;           /* FOR PLOT LABEL OFFSETS */
                 call symput('maxtime',put(maxtime,5.));
                 call symput('incr',put(incr,4.));
                 call symput('fuzz',put(fuzz,best8.));
               end;
           end;
        run;
   %end;
 
  /*****
   THE ORDER CLAUSE IN THE AXES STATEMENTS SIMULATES THE UNIFORM STATEMENT
   IN BY-GROUP PROCESSING.
  *****/
  axis1
    width=&w1 offset=(1,1) label=none label=(a=90 "&ylbl")
    order=(0.0 to 1.0 by 0.2) major=(w=&w1 h=0.7) minor=(w=&w1 h=0.6 n=1);
  axis2
    width=&w1 label=("&xlbl") order=(0 to &maxtime by &incr)
    major=(w=&w1 h=1.2) minor=(w=&w1 h=1.1 n=1);
 
  /* CREATE AN ANNOTATE DATA SET THAT LABELS THE STRATA */
 
  data anno(keep=style function size xsys ysys position text x y);
    length function style $8 text $40;
    retain style 'swiss' function 'label' position '6';
    set plot end=last;
    by &StratVbl notsorted;
    if last.&StratVbl then 
      do;
        size=1.5; xsys='2'; ysys='2';
        if STRATUM EQ 1 then text="&AbbStrt1";
        else text="&AbbStrt2";
        x=&STime + &fuzz.;
        if CENSOR eq 0 then y=0.015;   /* LAST EVENT=DEATH: LOOKS LIKE |ABBSTRT */
        else y=survival;               /* LAST EVENT=CENSOR: LOOKS LIKE -----/ABBSTRT */
        output;
      end;
    if last then
      do;
        size=1.5; xsys='1'; ysys='1'; x=30; y=78; text="&LOGRNK";
        output;
        x=30; y=68; text="&WILCOX";
        output;
      end;
  run;
 
  /* RUN PROC GPLOT WITH ADDITIONAL ANNOTATION IN THE NOTE STATEMENT. */

  proc gplot annotate=anno data=plot;
    plot survival*&STime=curve / vaxis=axis1
                                 haxis=axis2
                                 nolegend
                                 noframe;   /* DEFAULT IS FRAME IN V8 */
    format survival 3.1;
    format &STime 4.;
    title1;
    note h=5
       move=(20,95) angle=0 "Group Variable &GrpVbl = &GrpVal";
    footnote1;
  run;
  quit;
%mend KM2;
 
/* SET UP GRAPHICS ENVIRONMENT BEFORE INVOKING THE KM2 MACRO. */

goptions reset=goptions;
 
goptions device=win targetdevice=winprtc htext=5.5
  ftext=swiss nodisplay rotate=landscape gunit=pct;
 
%delCatMac(work.gseg);
%sizeit(Margin=4, ScaleY=0.9, ScaleX=0.8,NRows=2, MaxNCol=1, 
        YMax=8, XMax=10.667);

%KM2(libname=WORK, sds=VALung, StratVbl=therapy, GrpVbl=Cell, GrpVal=Large,
     xlbl=Time(Days), ylbl=Survival, AbbStrt1=S, AbbStrt2=T, FirstTime=1);

%KM2 (libname=WORK, sds=VALung, StratVbl=therapy, GrpVbl=Cell, GrpVal=Squamous,
     xlbl=Time(Days), ylbl=Survival, AbbStrt1=S, AbbStrt2=T);
 
goptions reset=goptions;
goptions device=win targetdevice=winprtc ftext=swiss nodisplay 
         rotate=landscape gunit=pct;
 
/* GRAND TITLE PLOT */
proc gslide;
  footnote1;
  footnote2;
  title1 h=2.75 'Product Limit Estimate of Survival';
  title2 h=2.25 'VA Lung Cancer Data from Appendix 1 of Kalbflesich & Prentice';
  title3 h=2.25 'Therapy: Standard(S) V. Test(T)';
run;
 
goptions display;
/* INVOKE TMPLT MACRO */
%Tmplt(Margin=4, XLateY=-4, ScaleY=0.90, ScaleX=0.8, R1=1, R2=1, TREPLAY=Y);

quit;

