/*====================== MACRO CONCORR ========================
  Author:    Edward F. Vonesh, PhD 
  Written:   July 13, 1992     
  Modified:  April 26, 2010                 
  Program:   This macro program performs the following:
          1) Macro CONCORR computes the concordance correlation
             coefficients (CCC) for a group of variables. It 
             is based on the CCC as defined by Lin in a series
             of papers (Biometrics, 1989, 1992). 
          2) The macro CONCORR was modified on April 26, 2010
             to allow one to compute pairwise estimates of the
             CCC when faced with unbalanced data. The macro 
             computes summary statistics (N, MEAN, STD)
             and both the Pearson correlation (R) and the 
             Lin concordance correlation (Rc) for pairwise
             variables defined by a VAR statement. To use this
             newer version of CONCORR, we assume that the 
             concordance correlations are needed on pairwise
             variables which are listed side by side in the VAR
             statement. Thus specifying the following VAR 
             statement
                VAR Y1 X1 Y2 X2 Y3 X3 ...
             will cause CONCORR to print the summary statistics
             N MEAN STD and correlation coefficients R and Rc
             for Y1 with X1 and Y2 with X2 and Y3 with X3 etc.
===============================================================
 

===============================================================
  NOTES 1.As a simple example, one can run the following code
          to illustrate how the CONCORR macro works.
     DATA TEST;
        DO I=1 TO 20;
           X=NORMAL(945723848);
           Y=.15+1.05*X + NORMAL(45678123);
           OUTPUT;
        END;
     %CONCORR(BY=,LASTBY=, DATA=TEST, VAR=Y X, FORMAT=12.2,);
===============================================================

   Macro Key:
   WHERE    = a where clause that defines a where statement for
              exclusion purposes
   BY       = Defines a SAS BY statement that will compute the
              pairwise CCC's by the levels of the different 
              groups specified in the BY argumnet
   LASTBY   = Defines the value of the last variable listed in
              the above BY statement. This is needed in order
              for the macro to sort and print results from IML
              NOTE: If one specifies one or more BY variables
                    then one MUST specify the LASTBY variable
                    or risk running into errors 
   BYLABEL  = Lists labels for the BY variables. The following
              example illustrates its use: 
                 BY = ModelType Typical,
                 BYLABEL={'Model', 'Typical'},
              In this example we label ModelType by 'Model' 
              and Typical by 'Typical'. Note that the value of
              BYLABEL should be in the matrix character format
              in order to be directly implemented within the
              program
   BYFORMAT = Lists formats for the BY variables 
              The default is BYFORMAT=$char8.
   DATA     = Defines the SAS dataset containing the variables
   VAR      = Lists the variables one wishes to compute the 
              concordance correlations for. It assumes this 
              list results in an even number of variables with
              concordance correlations desired on each pair of
              variables listed in the VAR.  Thus if we specify
              the VAR statement as 
                 VAR=Y1 X1 Y2 X2 Y3 X3, 
              then we will get a column-wise printing of 
              correlations between Y1 and X1 and between Y2 
              and X2 and between Y3 and X3, etc. This 
              simplifies the output and presents everything in
              a one table format. 
   VARLABEL = Lists labels for the various variables listed in
              the VAR statement using same structure as used 
              for the BYLABEL argument. For example, 
                 VAR = y_obs y_pred, 
                 VARLABEL = {'Observed Y' 'Predicted Y'}
              could be used to label the variables y_obs and
              y_pred 
   STATFMT  = Define the numeric format for summary measures
              like N, mean, and standard deviation
              The default is STATFMT=6.2
   FORMAT   = Define the numeric format for the pairwise
              correlations (CCC's and Pearson correlation)
              The default is FORMAT=4.2
   LABEL1   = Defines a label for the odd numbered variables
              in the VAR statement 
              The default is LABEL1=Variables
   LABEL2   = Defines a label for the even numbered variables
              in the VAR statement 
              The default is LABEL2=With 
===============================================================
Important Note: All BY variables must be character so one MUST
                convert these to character variables within 
                the dataset prior to running CONCORR.  
===============================================================
=============================================================*/

%MACRO CONCORR(where,
               by=dum82152,
               lastby=dum82152,
			   bylabel=,
			   byformat=$char8.,
               data=_LAST_, 
               var=,
			   varlabel=,
               label1=Variables,
               label2=With,
			   statfmt=6.2,
               format=4.2);

 DATA EFV82152;
  SET &DATA;
  dum82152='Overall';
  &WHERE;
 RUN;
 proc sort data=efv82152;
  by &by;
 run;
 data efv82152;set efv82152;
  by &by;
  retain counter 0;
  track=0;
  if first.&lastby then counter+1;
 run;

 PROC IML;
  START CONCORR;
  USE EFV82152;
  read all var {&VAR} into novar;
  P=NCOL(NOVAR);       ** p is number of variables analyzed;
  HALF_P=P/2;          ** HALF_P is number of paired variables analyzed;
  /*--- The following create index vectors for getting pairwise ---*/
  /*--- elements of VAR for printing purposes.                  ---*/
  r1=do(1,p-1,2);
  r2=do(2,p,2);

  read all var {counter} into counter;
  byn = max(counter);  ** byn is the number of levels of by variables; 

  DO byi = 1 to byn by 1;
   READ ALL VAR {&VAR} where(counter=byi) INTO COVAR (|COLNAME=OUTNAME|);
   READ ALL VAR {&BY}  where(counter=byi) INTO BYVAR (|COLNAME=LISTBY|);
   NO_BY=NCOL(BYVAR);
   EQUALS={'='};
   DO I=2 TO NO_BY BY 1;
    EQUALS = EQUALS||('=');
   END;

   FOR1=LISTBY;
   FOR2=BYVAR[1,];
   FOR = concat(for1,equals,for2);

   /*---Initialize the matrices for STAT1 and STAT2--*/
   CORR=J(P,P,0);
   CONCORR=J(P,P,0);
   DIFF=J(P,P,0);
   NOBS=J(P,1,0);
   MEAN=J(P,1,0);
   MIN=J(P,1,0);
   MAX=J(P,1,0);
   STD=J(P,1,0);
   VEC_CORR=J(HALF_P,1,1); 
   VEC_CONCORR=J(HALF_P,1,1);

   /*--- Start pairwise computations ---*/
   DO PAIR=1 to HALF_P;
    Pi=2; 
    JJ=r1[,PAIR]:r2[,PAIR];
    COVARi=COVAR[,JJ];    ** Select pairwise elements of 
	                         COVAR to process;   
    N=NROW(COVARi);       ** N is number of observations;
    VAR=J(1,Pi,0);

    DO I=1 TO N;
     IF ANY(COVARi[I,]=.) THEN GO TO SKIP;
     VAR=VAR//COVARi[I,];
    SKIP:
    END;

    N=NROW(VAR);
    VAR=VAR[2:N,];
    N=NROW(VAR);
    Pi=NCOL(VAR);
    E=J(N,1,1);
    SIGMA=VAR`*(I(N)-(1/N)*E*E`)*VAR/N;

    DO I=1 TO Pi;
	 II=JJ[,I];
	 NOBS[II,]=N;
     MEAN[II,]=SUM(VAR[,I])/N;
     STD[II,]=SQRT((N/(N-1))*SIGMA[I,I]);
     MIN[II,]=MIN(VAR[,I]);
     MAX[II,]=MAX(VAR[,I]);
    END;

    DO I=1 TO Pi;
     DO J=1 TO Pi;
	  II=JJ[,I];
	  KK=JJ[,J]; 
      CORR[II,KK]=SIGMA[I,J]/SQRT(SIGMA[I,I]*SIGMA[J,J]);
      CONCORR[II,KK]=2*SIGMA[I,J]/(SIGMA[I,I]+SIGMA[J,J]+(MEAN[II,]-MEAN[KK,])##2);
     END;
    END;

   END;      
   /*--- End of pairwise computations ---*/

   DO K=1 TO HALF_P BY 1;
    I=r1[,K];
    J=r2[,K]; 
    VEC_CORR[K,]=CORR[I,J];
    VEC_CONCORR[K,]=CONCORR[I,J];
   END;

   RESET NONAME;
   NO=NOBS;
   STAT=NO||MEAN||STD;
   CNAME={"N" "MEAN" "STD"};
   CNAME1={"R"};
   CNAME2={"Rc"};
   STAT1 = STAT[r1,]; 
   STAT2 = STAT[r2,];
   STAT2 = STAT2;    
   BYLABEL=FOR1;
   %if %length(&BYLABEL) %then %do;
    BYLABEL=&BYLABEL; 
   %end;
   if byi=1 then do;
    if HALF_P=1 then BYVALUE=FOR2;
    else BYVALUE=FOR2//J(HALF_P-1,NO_BY,' ');
    STACK_STAT1=STAT1;
    STACK_STAT2=STAT2;
    STACK_CORR=VEC_CORR;
    STACK_CONCORR=VEC_CONCORR;
   end;
   if byi>1 then do;
    if HALF_P=1 then BYVALUE=BYVALUE//FOR2;
    else BYVALUE=BYVALUE//FOR2//J(HALF_P-1,NO_BY,' ');
    STACK_STAT1=STACK_STAT1//STAT1;
    STACK_STAT2=STACK_STAT2//STAT2;
    STACK_CORR=STACK_CORR//VEC_CORR;
    STACK_CONCORR=STACK_CONCORR//VEC_CONCORR;
   end;
   OUTNAME1 = repeat(OUTNAME[,r1], byn,1);
   OUTNAME2 = repeat(OUTNAME[,r2], byn,1);
   %if %length(&VARLABEL) %then %do;
    VARLABEL=&VARLABEL;
    OUTNAME1 = repeat(VARLABEL[,r1], byn,1);
    OUTNAME2 = repeat(VARLABEL[,r2], byn,1);
   %end;
   MATTRIB STAT1 ROWNAME=OUTNAME1
                COLNAME=CNAME
                LABEL={"&label1"}; 
   MATTRIB STAT2 ROWNAME=OUTNAME2
                COLNAME=CNAME
                LABEL={"&label2"}; 
   MATTRIB VEC_CORR COLNAME=CNAME1
				FORMAT=&FORMAT; 
   MATTRIB VEC_CONCORR COLNAME=CNAME2
				FORMAT=&FORMAT; 
   MATTRIB STACK_STAT1 ROWNAME=OUTNAME1
                COLNAME=CNAME
				FORMAT=&STATFMT
                LABEL={"&label1"}; 
   MATTRIB STACK_STAT2 ROWNAME=OUTNAME2
                COLNAME=CNAME
				FORMAT=&STATFMT
                LABEL={"&label2"}; 
   MATTRIB STACK_CORR COLNAME=CNAME1
				FORMAT=&FORMAT; 
   MATTRIB STACK_CONCORR COLNAME=CNAME2
	 			FORMAT=&FORMAT; 
   MATTRIB BYVALUE COLNAME=BYLABEL FORMAT=&BYFORMAT;
  END;

 %if %index(&by, dum82152) %then %do;
 PRINT / "Summary Statistics (N, Mean, SD), Correlation (R) and Concordance Correlation (Rc)",
         ,,,
        STACK_STAT1 ' ' STACK_STAT2 STACK_CORR STACK_CONCORR;
 %end;
 %else %do;
 PRINT / "Summary Statistics (N, Mean, SD), Correlation (R) and Concordance Correlation (Rc)",
         ,,,
        BYVALUE STACK_STAT1 ' ' STACK_STAT2 STACK_CORR STACK_CONCORR;
 %end;
 FINISH;

RUN CONCORR;
QUIT;
%MEND;



