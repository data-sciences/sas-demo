
**************************************************;
* Program Name: Program_Example_Chapter3         *;
*   As the database presented in Chapter 3 could *;
* not be posted to the website, this program     *;
* runs the code presented in chapter 3 on an     *;
* example dataset.  The simulated dataset,       *;
* Chapter3_Example_Data, must be downloaded from *;
* the website to your D drive in a folder to     *;
* match the libname statement (or a new libname  *;
* statement created to link to the dataset).     *;
* The code here is the same code as in Chapter 3 *;
* except variable names have been changed to     *;
* match the example dataset.                     *;
**************************************************;
* Key information for dataset Chapter3_Example_Data  *;
*   Outcome Measures: mort6mo (binary) and           *;
*      tte (time to event) and cens (0 denotes a     *;
*      censored time.                                *;
*   Cohort Variable:  trtm (values of 0 or 1)        *;
*   Baseline Covariates: height, stent, female,      *;
*      diabetic, acutemi.                            *;
*   The dataset was modified from the example data   *;
*   from Chapter 7 and is not meant to represent     *;
*   any real clinical relationships among variables. *;
******************************************************;


libname in 'D:\sasbook';
        
data Chapt3;
  set in.chapter3_example_data;

    proc print data = Chapt3 (obs=5);
	  title 'test listing of dataset'; run;

proc freq data = Chapt3;
  tables trtm*mort6mo / chisq;
  title 'unadjusted group test'; run;
                


***********************************************************;
* Program 3.1 SAS code for fitting propensity score model *;
***********************************************************;
/******************************************************************************/
/* SAS code for estimating propensity score model.			      	          */
/* Indicator variable denoting receipt of a DES is regressed on baseline      */
/* characteristics.							                                  */
/******************************************************************************/

proc logistic descending data=Chapt3;
  model trtm = height stent female diabetic acutemi  ;
  output out=out_ps prob=ps xbeta=logit_ps;
  /* Output the propensity score and logit of the propensity score */
run;


*********************************************************************;
* Program 3.2  SAS code for forming propensity score matched sample *;
*********************************************************************;
* Compute standard deviation of the logit of the propensity score	*;

proc means std data=out_ps;
  var logit_ps;
  output out=stddata (keep = std) std=std;
run;

data stddata;
  set stddata;
  std = 0.2*std;
  /* calipers of width 0.2 standard deviations of the logit of PS.      */
run;

/* Create macro variable that contains the width of the caliper for matching */

data _null_;
  set stddata;
  call symput('stdcal',std);
run;

/* Match subjects on the logit of the propensity score.			*/

proc sort data=out_ps;
  by trtm;
run;

data out_ps;
  set out_ps;
  id=_N_;
run;

** copy of the gmatch macro is placed here **;
  ************************************************************************************;

  /*------------------------------------------------------------------*
   | The documentation and code below is supplied by HSR CodeXchange.             
   |              
   *------------------------------------------------------------------*/
                                                                                      
                                                                                      
                                                                                      
  /*------------------------------------------------------------------*
   | MACRO NAME  : gmatch
   | SHORT DESC  : Match 1 or more controls to cases using the
   |               GREEDY algorithm
   *------------------------------------------------------------------*
   | CREATED BY  : Kosanke, Jon                  (04/07/2004 16:32)
   |             : Bergstralh, Erik
   *------------------------------------------------------------------*
   | PURPOSE
   |
   | GMATCH Macro to match 1 or more controls for each of N cases
   | using the GREEDY algorithm--REPLACES GREEDY option of MATCH macro.
   | Changes:
   | --cases and controls in same dataset
   | --not mandatory to randomly pre-ort cases and controls, but recommended
   | --options to transform X's and to choose distance metric
   | --input parameters consistent with %DIST macro for optimal matching
   |
   | *******
   |
   | Macro name: %gmatch
   |
   | Authors: Jon Kosanke and Erik Bergstralh
   |
   | Date: July 23, 2003
   |       October 31, 2003...tweaked print/means based on "time" var
   |
   | Macro function:
   |
   | Matching using the GREEDY algorithm
   |
   | The purpose of this macro is to match 1 or more controls(from a total
   | of M) for each of N cases.  The controls may be matched to the cases by
   | one or more factors(X's).  The control selected for a particular
   | case(i) will be the control(j) closest to the case in terms of Dij.
   | Dij can be defined in multiple ways. Common choices are the Euclidean
   | distance and the weighted sum of the absolute differences between the
   | case and control matching factors.  I.e.,
   |
   |     Dij= SQRT [SUM { W.k*(X.ik-X.jk)**2} ],  or
   |
   |     Dij= SUM { W.k*ABS(X.ik-X.jk) },
   |
   |                                      where the sum is over the number
   |                                      of matching factors X(with index
   |                                      k) and W.k = the weight assigned
   |                                      to matching factor k and X.ik =
   |                                      the value of variable X(k) for
   |                                      subject i.
   |
   | The control(j) selected for a case(i) is the one with the smallest Dij
   | (subject to constraints DMAX and DMAXK, defined below). In the case of
   | ties, the first one encountered will be used. The higher the user-defined
   | weight, the more likely it is that the case and control will be matched
   | on the factor.  Assign large weights (relative to the other weights) to
   | obtain exact matches for two-level factors such as gender. An option to
   | using weights might be to standarize the X's in some fashion. The macro
   | has options to standardize all X's to mean 0 and variance 1 and to use
   | ranks.
   |
   | The matching algorithm used is the GREEDY method. Using the greedy method,
   | once a match is made it is never broken.  This may result in inefficiencies
   | if a previously matched control would be a better match for the current
   | case than those controls currently available. (An alternative method is to
   | do optimal matching using the VMATCH & DIST macros. This method guarantees
   | the best possible matched set in terms of minimizing the total Dij.)
   | The GREEDY method generally produces very good matches, especially if the
   | control pool is large relative to the number of cases. When  multiple
   | controls/case are desired, the algorithm first matches 1 control to all
   | cases and then proceeds to select second controls.
   |
   |
   | The gmatch macro checks for missing values of matching variables and the
   | time variable(if specified) and deletes those observations from the input
   | dataset.
   |
   | Call statement:
   |
   |
   | %gmatch(data=,group=,id=,
   |       mvars=,wts=,dmaxk=,dmax=,transf,
   |       time=, dist=,
   |       ncontls=,seedca=,seedco=,
   |       out=,outnmca=,outnmco=,print=);
   |
   | Parameter definitions(R=required parameter):
   |
   |
   |  R    data  SAS data set containing cases and potential controls. Must
   |             contain the ID, GROUP, and the matching variables.
   |
   |  R    group SAS variable defining cases. Group=1 if case, 0 if control.
   |
   |  R     id   SAS CHARACTER ID variable for the cases and controls.
   |
   |
   |  R   mvars  List of numeric matching variables common to both case and
   |             control data sets.  For example, mvars=male age birthyr.
   |
   |  R     wts  List of non-negative weights corresponding to each matching
   |             variable.  For example wts=10 2 1 corresponding to male, age
   |             and birthyr as in the above example.
   |
   |      dmaxk  List of non-negative values corresponding to each matching
   |             variable.  These numbers are the largest possible absolute
   |             differences compatible with a valid match.  Cases will
   |             NOT be matched to a control if ANY of the INDIVIDUAL
   |             matching factor  differences are >DMAXK.  This optional
   |             parameter allows one to form matches of the type male+/-0,
   |             age+/-2, birth year+/-5 by specifying DMAXK=0 2 5.
   |
   |      dmax   Largest value of Dij considered to be a valid match.  If
   |             you want to match exactly on a two-level factor(such as
   |             gender coded as 0 or 1) then assign DMAX to be less than
   |             the weight for the factor.  In the example above, one could
   |             use wt=10 for male and dmax=9.  Leave DMAX blank if any
   |             Dij is a valid match.  One would typically NOT use both
   |             DMAXK and DMAX.  The only advantage to using both, would be
   |             to further restrict potential matches that meet the
   |             DMAXK criteria.
   |
   |       dist  Indicates type of distance to calculate.
   |
   |             1=weighted sum(over matching vars) of
   |             absolute case-control differences(default)
   |
   |             2=weighted Euclidean distance
   |
   |       time  Time variable used for risk set matching.  Matches are only
   |             valid if the control time > case time. May need to
   |
   |     transf  Indicates whether all matching vars are to be transformed
   |             (using the combined case+control data) prior to computing
   |             distances.  0=no(default),
   |                         1=standardize to mean 0 and variance 1,
   |                         2=use ranks of matching variables.
   |
   |    ncontls  Indicates the number of controls to match to each case.  The
   |             default is 1.  With multiple controls per case, the algorithm
   |             will first match every case to one control and then again
   |             match each case to a second control, etc.  Controls selected
   |             on the first pass will be stronger matches than those selected in
   |             later rounds.  The output data set contains a variable (cont_n)
   |             which indicates on which round the control was selected.
   |
   |    seedca   Seed value used to randomly sort the cases prior to
   |             matching. This positive integer will be used as input to
   |             the RANUNI function.  The greedy matching algorithm is
   |             order dependent which, among other things means that
   |             cases matched first will be on average more similar to
   |             their controls than those matched last(as the number of
   |             control choices will be limited).  If the matching order
   |             is related to confounding factors (possibly age or
   |             calendar time) then biases may result.  Therefore it is
   |             generally considered good practice when using the GREEDY
   |             method to randomly sort both the cases and controls
   |             before beginning the matching process.
   |
   |    seedco   Seed value used to randomly sort the controls prior to
   |             matching using the GREEDY method.  This seed value must
   |             also be a positive integer.
   |
   |
   | print= Option to print data for matched cases. Use PRINT=y to
   |        print data and PRINT=n or blank to not print.  Default is y.
   |
   |        out=name of SAS data set containing the results of the matching
   |            process.  Unmatched cases are not included.  See outnm
   |            below.  The default name is __out.  This data set will have
   |            the following layout:
   |
   |          Case_id  Cont_id  Cont_n  Dij  Delta_caco MVARS_ca  MVARS_co
   |             1        67      1     5.2  (Differences & actual
   |             1        78      2     6.1   values for matching factors
   |             2        52      1     2.9   for cases & controls)
   |             2        92      2     3.1
   |             .        .       .      .
   |             .        .       .      .
   |
   |        outnmca=name of SAS data set containing NON-matched cases.
   |                Default name is __nmca .
   |
   |        outnmco=name of SAS data set containing NON-matched controls.
   |                Default name is __nmco .
   |
   |
   |  References:  Bergstralh, EJ and Kosanke JL(1995).  Computerized
   |               matching of controls.  Section of Biostatistics
   |               Technical Report 56.  Mayo Foundation.
   |
   |
   |  Example: 1-1 matching by male(exact), age(+-2) and year(+-5).
   |           The wt for male is not relevant, as only exact matches
   |           on male will be considered.  The weight for age(2) is
   |           double that for year(1).
   |
   |
   |       %gmatch(data=all, group=ca_co,id=clinic,
   |              mvars=male age_od yr_od,
   |              wts=2 2 1, dmaxk=0 2 5,out=mtch,
   |              seedca=87877,seedco=987973);
   |
   *------------------------------------------------------------------*
   | OPERATING SYSTEM COMPATIBILITY
   |
   | UNIX SAS v8   :   YES
   | UNIX SAS v9   :
   | MVS SAS v8    :
   | MVS SAS v9    :
   | PC SAS v8     :
   | PC SAS v9     :
   *------------------------------------------------------------------*
   | EXAMPLES
   |
   | Another example is located at the bottom of the code.
   *------------------------------------------------------------------*
   | Copyright 2004 Mayo Clinic College of Medicine.
   |
   | This program is free software; you can redistribute it and/or
   | modify it under the terms of the GNU General Public License as
   | published by the Free Software Foundation; either version 2 of
   | the License, or (at your option) any later version.
   |
   | This program is distributed in the hope that it will be useful,
   | but WITHOUT ANY WARRANTY; without even the implied warranty of
   | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
   | General Public License for more details.
   *------------------------------------------------------------------*/
 
%MACRO GMATCH(DATA=,GROUP=,ID=,
             MVARS=,WTS=,DMAXK=,DMAX=,DIST=,
             NCONTLS=, TIME=,TRANSF=1,
             SEEDCA=,SEEDCO=,PRINT=,
             OUT=,OUTNMCA=,OUTNMCO=);
 
   %LET BAD=0;
 
   %IF %LENGTH(&DATA)=0 %THEN %DO;
      %PUT ERROR: NO DATASET SUPPLIED;
      %LET BAD=1;
   %END;
 
   %IF %LENGTH(&ID)=0 %THEN %DO;
      %PUT ERROR: NO ID VARIABLE SUPPLIED;
      %LET BAD=1;
   %END;
 
   %IF %LENGTH(&GROUP)=0 %THEN %DO;
      %PUT ERROR: NO CASE(1)/CONTROL(0) GROUP VARIABLE SUPPLIED;
      %LET BAD=1;
   %END;
 
   %IF %LENGTH(&MVARS)=0 %THEN %DO;
      %PUT ERROR: NO MATCHING VARIABLES SUPPLIED;
      %LET BAD=1;
   %END;
 
  %IF %LENGTH(&WTS)=0 %THEN %DO;
      %PUT ERROR: NO WEIGHTS SUPPLIED;
      %LET BAD=1;
   %END;
 
   %LET NVAR=0;
   %DO %UNTIL(%SCAN(&MVARS,&NVAR+1,' ')= );
      %LET NVAR=%EVAL(&NVAR+1);
   %END;
   %LET NWTS=0;
   %DO %UNTIL(%QSCAN(&WTS,&NWTS+1,' ')= );
      %LET NWTS=%EVAL(&NWTS+1);
   %END;
   %IF &NVAR^= &NWTS %THEN %DO;
      %PUT ERROR: #VARS MUST EQUAL #WTS;
      %LET BAD=1;
   %END;
 
  %LET NK=0;
   %IF %QUOTE(&DMAXK)^=  %THEN %DO %UNTIL(%QSCAN(&DMAXK,&NK+1,' ')= );
      %LET NK=%EVAL(&NK+1);
   %END;
   %IF &NK>&NVAR %THEN %LET NK=&NVAR;
   %DO I=1 %TO &NVAR;
      %LET V&I=%SCAN(&MVARS,&I,' ');
   %END;
 
  %IF &NWTS>0 %THEN %DO;
        DATA _NULL_;
        %DO I=1 %TO &NWTS;
             %LET W&I=%SCAN(&WTS,&I,' ');
             IF &&W&I<0 THEN DO;
                  PUT 'ERROR: WEIGHTS MUST BE NON-NEGATIVE';
                  CALL SYMPUT('BAD','1');
             END;
        %END;
        RUN;
   %END;
 
  %IF &NK>0 %THEN %DO;
        DATA _NULL_;
        %DO I=1 %TO &NK;
             %LET K&I=%SCAN(&DMAXK,&I,' ');
             IF &&K&I<0 THEN DO;
                  PUT 'ERROR: DMAXK VALUES MUST BE NON-NEGATIVE';
                  CALL SYMPUT('BAD','1');
             END;
        %END;
        RUN;
   %END;
 
    %MACRO MAX1;
      %IF &DMAX^= %THEN %DO;
         & __D<=&DMAX
      %END;
      %DO I=1 %TO &NK;
         & ABS(__CA&I-__CO&I)<=&&K&I
      %END;
    %MEND MAX1;
 
   %macro greedy;
    %GLOBAL BAD2;
 
      data __CHECK; set &DATA;
          __id=&id;
          if __id="" then delete;
          %DO I=1 %TO &NVAR;
                IF %scan(&mvars,&i)=. THEN DELETE;
           %END;
           %IF &TIME^= %THEN %DO;
                IF &TIME=. THEN DELETE;
           %END;
       run;
 
      *** transform data if requested/separate cases & controls;
      %if &transf=1 %then %do;
      proc standard data=__check m=0 s=1 out=_stdzd; var &mvars;
      data _caco;
        set _stdzd;
      %end;
 
      %if &transf=2 %then %do;
      proc rank data=__check out=_ranks; var &mvars;
      data _caco;
        set _ranks;
      %end;
 
      %if &transf=0 %then %do;
      data _caco;
        set __check;
      %end;
 
 
      DATA __CASE; SET _caco;
           if &group=1;
      DATA __CASE; SET __CASE END=EOF;
       KEEP __IDCA __CA1-__CA&NVAR __R &mvars
         %if &time^= %then %do;
             __catime
         %end;
          ;
         __IDCA=&ID;
         %if &time^= %then %do;
            __catime=&time;
         %end;
         %DO I=1 %TO &NVAR;
            __CA&I=&&V&I;
         %END;
         %if &seedca^= %then %do;
         SEED=&SEEDCA;
         __R=RANUNI( SEED  );
         %end;
         %else %do;
         __R=1;
         %end;
 
         IF EOF THEN CALL SYMPUT('NCA',_N_);
      PROC SORT; BY __R __IDCA;
 
      DATA __CONT; SET _caco;
         if &group=0;
      DATA __CONT; SET __CONT END=EOF;
       KEEP __IDCO __CO1-__CO&NVAR __R &mvars
        %if &time^= %then %do;
           __cotime
        %end;
        ;
         __IDCO=&ID;
         %if &time^= %then %do;
            __cotime=&time;
         %end;
         %DO I=1 %TO &NVAR;
            __CO&I=&&V&I;
         %END;
         %if &seedco^= %then %do;
         SEED=&SEEDCo;
         __R=RANUNI( SEED  );
         %end;
         %else %do;
         __R=1;
         %end;
 
         IF EOF THEN CALL SYMPUT('NCO',_N_);
      RUN;
      %LET BAD2=0;
      %IF &NCO < %EVAL(&NCA*&NCONTLS) %THEN %DO;
         %PUT ERROR: NOT ENOUGH CONTROLS TO MAKE REQUESTED MATCHES;
         %LET BAD2=1;
      %END;
 
      %IF &BAD2=0 %THEN %DO;
         PROC SORT; BY __R __IDCO;
         DATA __MATCH;
          KEEP __IDCA __CA1-__CA&NVAR __DIJ __MATCH __CONT_N
          %if &time^= %then %do;
             __catime __cotime
          %end;
          ;
          ARRAY __USED(&NCO) $ 1 _TEMPORARY_;
            DO __I=1 TO &NCO;
               __USED(__I)='0';
            END;
            DO __I=1 TO &NCONTLS;
               DO __J=1 TO &NCA;
                  SET __CASE POINT=__J;
                  __SMALL=.;
                  __MATCH=.;
                  DO __K=1 TO &NCO;
                     IF __USED(__K)='0' THEN DO;
                        SET __CONT POINT=__K;
 
                       %if &dist=2 %then %do;
                        **wtd euclidian dist;
                         __D= sqrt(
                         %do k=1 %to &nvar;
                         %scan(&wts,&k)*(__ca&k - __co&k)**2
                         %if &k<&nvar %then + ;
                        %end;
                         );
                       %end;
                       %else %do;
                        **wtd sum absolute diff;
                         __D=
                        %do k=1 %to &nvar;
                        %scan(&wts,&k)*abs(__ca&k - __co&k )
                        %if &k<&nvar %then + ;
                        %end;
                          ;
                       %end;
 
                        IF __d^=. & (__SMALL=. | __D<__SMALL) %MAX1
                        %if &time^= %then %do;
                           & __cotime > __catime
                        %end;
                        THEN DO;
                           __SMALL=__D;
                           __MATCH=__K;
                           __DIJ=__D;
                           __CONT_N=__I;
                        END;
                     END;
                  END;
                  IF __MATCH^=. THEN DO;
                     __USED(__MATCH)='1';
                     OUTPUT;
                  END;
               END;
            END;
            STOP;
         DATA &OUT;
          SET __MATCH;
          SET __CONT POINT=__MATCH;
          KEEP __IDCA __IDCO __CONT_N __DIJ __CA1-__CA&NVAR
               __CO1-__CO&NVAR __d1-__d&nvar __absd1-__absd&nvar  __WT1-__WT&NVAR
                  __catime __cotime __dtime;
 
          %if &time= %then %do;
              __cotime=.; __catime=.;
          %end;
          LABEL
                   __catime="&time/CASE"
                   __cotime="&time/CONTROL"
                   __dtime="&time/ABS. DIFF"
                __CONT_N='CONTROL/NUMBER'
                __DIJ='DISTANCE/D_IJ'
               %DO I=1 %TO &NVAR;
                __CA&I="&&V&I/CASE"
                __CO&I="&&V&I/CONTROL"
                __absd&I="&&V&I/ABS. DIFF "
                __d&I="&&V&I/DIFF "
                __WT&I="&&V&I/WEIGHT"
              %END;
                ;
             %DO I=1 %TO &NVAR;
                __d&i= (__CA&I-__CO&I);      **raw diff;
                __absd&I=abs(__CA&I-__CO&I); **abs diff;
                __WT&I=&&W&I;
             %END;
                __dtime=__cotime-__catime;
 
         PROC SORT DATA=&OUT; BY __IDCA __CONT_N;
         proc sort data=__case; by __IDCA;
         data &outnmca; merge __case
              &out(in=__inout where=(__cont_n=1)); by __idca;
              if __inout=0; **non-matches;
 
         proc sort data=__cont; by __IDCO;
         proc sort data=&out; by __IDCO;
         data &outnmco; merge __cont
              &out(in=__inout); by __idco;
              if __inout=0; **non-matched controls;
         proc sort data=&out; by __IDCA; **re-sort by case id;
 
       %if %upcase(&print)=Y %then %do;
         PROC PRINT data=&out LABEL SPLIT='/';
          VAR __IDCA __IDCO __CONT_N
 
           __DIJ
          %DO I=1 %TO &NVAR;
           __absd&I
          %END;
          %if &time^= %then %do;
           __dtime
          %end;
          %DO I=1 %TO &NVAR;
           __CA&I __CO&I
          %END;
          %if &time^= %then %do;
           __catime __cotime
          %end;
           ;
          sum __dij;
 
         title9'Data listing for matched cases and controls';
         footnote"Greedy matching(gmatch) macro: data=&data group=&group id=&id    ";
         footnote2"   mvars=&mvars  wts=&wts dmaxk=&dmaxk dmax=&dmax ncontls=&ncontls";
         footnote3"   transf=&transf dist=&dist time=&time seedca=&seedca  seedco=&seedco";
         footnote4"   out=&out   outnmca=&outnmca  outnmco=&outnmco";
         run;
         title9'Summary data for matched cases and controls--one obs/control';
          %if &sysver ge 8 %then %do;
         proc means data=&out  maxdec=3 fw=8
           n mean median min p10 p25 p75 p90 max sum;
         %end;
         %else %do;
         proc means data=&out maxdec=3
          n mean min max sum;
         %end;
         class __cont_n;
          var __dij
 
              %do I=1 %TO &NVAR;
                  __absd&I
              %end;
              %if &time^= %then %do;
                  __dtime
              %end;
              %do I=1 %TO &NVAR;
                  __ca&I
              %end;
              %if &time^= %then %do;
                  __catime
              %end;
              %do I=1 %TO &NVAR;
                  __co&I
              %end;
              %if &time^= %then %do;
                  __cotime
              %end;
                 ;
         run;
         *** estimate matching var means within matched sets for controls;
         proc means data=&out  n mean noprint; by __idca;
          var __dij
         %do i=1 %to &nvar;
            __co&i
         %end;
              __cotime
            ;
         output out=_mcont n=n_co mean=__dijm
         %do i=1 %to &nvar;
           __com&i
         %end;
             __tcom
           ;
         data _onecase; set &out; by __idca; if first.__idca;
         data __camcon; merge _onecase _mcont; by __idca;
 
         keep __idca n_co __dijm
             __dtime __catime  __tcom
          %do i=1 %to &nvar;
           __ca&i __com&i  __actd&i __absd&i
          %end;
         ;
 
 
         %do i=1 %to &nvar;
         __absd&i=abs(__ca&i - __com&i);
         __actd&i=(__ca&i - __com&i);
        %end;
         __dtime=__tcom-__catime
          ;
 
       label
        n_co="No./CONTROLS"
        __dijm="Average/Dij"
        __dtime="&time/Mean Time DIFF"
        __tcom="&time/Mean CONT TIME"
 
       %do i=1 %to &nvar; %let vvar=%scan(&mvars,&i);
         __absd&i="&vvar/Mean ABS. DIFF"
         __com&i="&vvar/Mean CONTROL"
       %end;
         ;
      title9'Summary data for matched cases and controls--one obs/case(using average control value)';
      %if &sysver ge 8 %then %do;
      proc means data=__camcon maxdec=3 fw=8
        n mean median min p10 p25 p75 p90 max sum;
      %end;
      %else %do;
      proc means data=__camcon maxdec=3
        n mean min max sum;
      %end;
      var n_co __dijm
      %do i=1 %to &nvar;
       __absd&i
      %end;
      %if &time^= %then %do;
       __dtime
      %end;
      %do i=1 %to &nvar;
      __ca&i
      %end;
      %if &time^= %then %do;
       __catime
      %end;
      %do i=1 %to &nvar;
      __com&i
      %end;
      %if &time^= %then %do;
      __tcom
      %end;
          ;
    %end; **end of print=y loop**;
   %END;  **end of bad2=0 loop**;
   run;
   title9; footnote;
   run;
 
   %mend greedy;
 
   %IF &BAD=0 %THEN %DO;
         %GREEDY
   %END;
%MEND GMATCH;
 

** end gmatch macro and resume Chapter 3 code **;


%gmatch(
  data = out_ps,
  group = trtm,
  id = id,
  mvars = logit_ps,
  wts = 1,
  dist = 1,
  dmaxk = &stdcal,
  ncontls = 1,
  seedca = 25102007,
  seedco = 26102007,
  out = matchpairs,
  print = F
);

data matchpairs;
  set matchpairs;
  pair_id = _N_;
run;

/* Create a data set containing the matched BMS patients (untreated subjects) */

data control_match;
  set matchpairs;
  control_id = __IDCO;
  logit_ps = __CO1;
  keep pair_id control_id logit_ps;
run;

/* Create a data set containing the matched DES patients (treated subjects) */

data case_match;
  set matchpairs;
  case_id = __IDCA;
  logit_ps = __CA1;
  keep pair_id case_id logit_ps;
run;

proc sort data=control_match;
  by control_id;
run;

proc sort data=case_match;
  by case_id;
run;

data exposed;
  set out_ps;
  if trtm = 1;
  case_id = id;
run;

data control;
  set out_ps;
  if trtm = 0;
  control_id = id;
run;

proc sort data=exposed;
  by case_id;
run;

proc sort data=control;
  by control_id;
run;

data control_match;
  merge control_match (in=f1) control (in=f2);
  by control_id;
  if f1 and f2;
run;

data case_match;
  merge case_match (in=f1) exposed (in=f2);
  by case_id;
  if f1 and f2;
run;

data long;
  set control_match case_match;
  prop_score = exp(logit_ps) / (exp(logit_ps) + 1);
run;

data wide_des;
  set case_match;
  mort6mo_t1 = mort6mo;
  cardcost_t1 = cardcost;
  tte_t1 = tte;
  cens_t1 = cens;

run;

data wide_bms;
  set control_match;
  mort6mo_t0 = mort6mo;
  cardcost_t0 = cardcost;
  tte_t0 = tte;
  cens_t0 = cens;

run;

proc sort data=wide_des;
  by pair_id;
run;

proc sort data=wide_bms;
  by pair_id;
run;
 
/* Data set containing outcomes for the matched subjects.		 	*/
/* Each row contains outcomes for the treated and untreated subjects	*/
/* in the matched pair.							*/

data wide_combo;
  merge wide_des (in=f1) wide_bms (in=f2);
  by pair_id;
  if f1 and f2;
run;



**********************************************************************************************************;
** Program 3.3 SAS code for calculating standardized differences between treated and untreated subjects **;
**********************************************************************************************************;

/******************************************************************************/
/* Compute standardized differences for each covariate in the matched sample. */
/******************************************************************************/

proc sort data=long;
  by trtm;
run;

/******************************************************************************/
/* Macro for computing standardized differences for continuous variables.     */
/******************************************************************************/

%macro cont(var=,label=);

proc means mean stddev data=long noprint;
  var &var;
  by trtm;
  output out=outmean (keep = trtm mean stddev) mean = mean stddev=stddev;
run;

data des0;
  set outmean;
  if trtm = 0;
  mean_0 = mean;
  s_0 = stddev;
 
  keep mean_0 s_0;
run;

data des1;
  set outmean;
  if trtm = 1;
  mean_1 = mean;
  s_1 = stddev;

  keep mean_1 s_1;
run;

data newdata;
  length label $ 25;
  merge des0 des1;

  d = (mean_1 - mean_0)/ sqrt((s_1*s_1 + s_0*s_0)/2);
  d = round(abs(d),0.001);

  label = &label;

  keep d label;
run;

proc append data=newdata base=standiff force;
run;

%mend cont;

/******************************************************************************/
/* Macro for computing standardized differences for binary variables.         */
/******************************************************************************/

%macro binary(var=,label=);

proc means mean data=long noprint;
  var &var;
  by trtm;
  output out=outmean (keep = trtm mean) mean = mean;
run;

data des0;
  set outmean;
  if trtm = 0;
  mean_0 = mean;
 
  keep mean_0;
run;

data des1;
  set outmean;
  if trtm = 1;
  mean_1 = mean;

  keep mean_1;
run;

data newdata;
  length label $ 25;
  merge des0 des1;

  d = (mean_1 - mean_0)/ sqrt((mean_1*(1-mean_1) + mean_0*(1-mean_0))/2);
  d = round(abs(d),0.001);

  label = &label;

  keep d label;
run;

proc append data=newdata base=standiff force;
run;

%mend binary;

%cont(var=height,label="Height");

%binary(var=stent,label="Stent");
%binary(var=female,label="Female");
%binary(var=diabetic,label="Diabetic");
%binary(var=acutemi,label="Acutemi");

proc print data=standiff;
  title 'Standardized differences in propensity score matched sample';
run;


**********************************************************************************************************;
** Program 3.4  SAS code for estimating effect of treatment on dichotomous outcomes                     **;
**********************************************************************************************************;

proc freq data=wide_combo;
  exact agree;
  tables mort6mo_t1*mort6mo_t0 /nopercent agree;
  title "McNemar's test for comparing risk of death within 6 months";
run;

* Program 3.5 not run as no significant difference was observed in this example *;

**********************************************************************************************************;
** Program 3.6 SAS code for comparing the Kaplan-Meier survival curves between groups in the propensity **;
** score matched sample                                                                                 **;
**********************************************************************************************************;

data long;
  set long;
  if trtm = 1 then trt = "T1";
    else trt = "T0";
run;

proc lifetest data=long outsurv=kmdata_tvra notable;
  time tte*cens(0);
  strata trt;
   /* 'tte' denotes time to event */
   /* 'cens' is the censoring indicator: 1 indicates that the event occurred, while   */
   /* 0 indicates that the subject has been censored.				   */
   /* 'trt' denotes the exposure group              				   */
  title 'Kaplan-Meier survival curves';
run;

data km_compare;
  set wide_combo;
  if (tte_t1 < tte_t0) and (cens_t1 = 0) then delete;
  if (tte_t0 < tte_t1) and (cens_t0 = 0) then delete;
  /* Delete pairs in which the shorter of the two observation times */
  /* is for a subject who is censored.				    */

  if (tte_t1 < tte_t0) and (cens_t1 = 1) then D1 = 1;
    else D1 = 0;

  if (tte_t0 < tte_t1) and (cens_t0 = 1) then D2 = 1;
    else D2 = 0;
run;

proc means sum data=km_compare noprint;
  var D1 D2;
  output out=km_stat (keep = D1 D2) sum = D1 D2;
run;

data km_stat;
  set km_stat;
  z = (D1 - D2)/sqrt(D1 + D2);
  /* Test statistic for comparing K-M curves from matched sample */

  p_value = 2*(1 - probnorm(abs(z)));
run;

proc print data=km_stat;
  var D1 D2 z p_value;
  title 'Comparing K-M survival curve from matched sample';
run;



**********************************************************************************************************;
** Program 3.7 SAS code for fitting Cox proportional hazards models in the propensity score matched sample **;
**********************************************************************************************************;

/* Cox proportional hazards model stratifying on matched pairs.		*/

proc phreg data=long nosummary;
  model tte*cens(0) = trtm/ties=exact rl;
  strata pair_id;
  title 'Cox proportional hazards model stratifying on matched sets';
run;

/* Cox proportional hazards model with robust standard errors to 	*/
/* account for clustering in matched pairs.				*/

proc phreg data=long covs(aggregate);
  model tte*cens(0) = trtm/ties=exact rl;
  id pair_id;
  title 'Cox proportional hazards model with robust standard errors';
run;


      
