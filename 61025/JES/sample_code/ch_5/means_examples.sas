



PROC MEANS DATA=JES.Results_1 ;
RUN;

/*==================================================
  Use an OUTPUT statement to send
  the Results of PROC MEANS to a SAS data set
====================================================*/
PROC MEANS DATA=JES.Results_1 NOPRINT;
	OUTPUT OUT=Tab_1;
RUN;


/*=====================================================
  Use a VAR statement to select VARiables for analysis
======================================================*/
PROC MEANS DATA=JES.Results_1 NOPRINT;
	VAR Defects Resistance Fail ;
	OUTPUT OUT=Tab_2;
	FORMAT Defects Fail 6.2;
RUN;


/*=====================================================
  Use keywords to select the required statistics
======================================================*/
PROC MEANS DATA=JES.Results_1 NOPRINT;
	VAR Defects Resistance Fail ;
	OUTPUT OUT=Tab_3
    N(Defects)=N
	SUM(Defects) = N_Def
	MEAN(Defects)=M_Def
	MEAN(Resistance)=M_Res
	SUM(Fail) = N_Fail
	MEAN(Fail) = P_Fail ;
	FORMAT M_Def P_Fail 6.2;
RUN;


/*=====================================================
  Use a CLASS statement to request statistics for each
  distinct value of the specified variable
======================================================*/
PROC MEANS DATA=JES.Results_Q4 NOPRINT;
	CLASS Vendor;
	VAR Defects Resistance Fail ;
	OUTPUT OUT=Tab_4
    N(Defects)=N
	SUM(Defects) = N_Def
	MEAN(Defects)=M_Def
	MEAN(Resistance)=M_Res
	SUM(Fail) = N_Fail
	MEAN(Fail) = P_Fail ;
	FORMAT M_Def P_Fail 6.2;
RUN;


/*=======================================================
  Use a CLASS statement to request statistics for each
  distinct combination of values of two or more VARiables
========================================================*/
PROC MEANS DATA=JES.Results_Q4 NOPRINT;
	CLASS Vendor Month;
	VAR Defects Resistance Fail ;
	OUTPUT OUT=Tab_5
    N(Defects)=N
	SUM(Defects) = N_Def
	MEAN(Defects)=M_Def
	MEAN(Resistance)=M_Res
	SUM(Fail) = N_Fail
	MEAN(Fail) = P_Fail;
	FORMAT M_Def P_Fail 6.2;
RUN;



/*=========================================================
  Use the NWAY option to limit the OUTPUT to only the 
  distinct combinations of each value in the CLASS statement
==========================================================*/
PROC MEANS DATA=JES.Results_Q4 NOPRINT NWAY;
	CLASS Vendor Month;
	VAR Defects Resistance Fail ;
	OUTPUT OUT=Tab_5A
    N(Defects)=N
	SUM(Defects) = N_Def
	MEAN(Defects)=M_Def
	MEAN(Resistance)=M_Res
	SUM(Fail) = N_Fail
	MEAN(Fail) = P_Fail;
	FORMAT M_Def P_Fail 6.2;
RUN;


/*=========================================================
  Use the TYPES option to limit the OUTPUT to only the 
  specifies combinations of the values in the CLASS statement
==========================================================*/
PROC MEANS DATA=JES.Results_Q4 NOPRINT;
	CLASS Vendor Month;
	TYPES Vendor Vendor*Month;
	VAR Defects Resistance Fail ;
	OUTPUT OUT=Tab_5B
    N(Defects)=N
	SUM(Defects) = N_Def
	MEAN(Defects)=M_Def
	MEAN(Resistance)=M_Res
	SUM(Fail) = N_Fail
	MEAN(Fail) = P_Fail;
	FORMAT M_Def P_Fail 6.2;
RUN;


/*=========================================================
  Use the LCLM and UCLM keywords to add confidence limits 
  on the MEAN Resistance
==========================================================*/
PROC MEANS DATA=JES.Results_Q4 NOPRINT NWAY ALPHA=.10;
	CLASS Vendor Month;
	VAR Defects Resistance Fail ;
	OUTPUT OUT=Tab_6
    N(Defects)=N
	SUM(Defects) = N_Def
	MEAN(Defects)=M_Def
	MEAN(Resistance)=M_Res
	LCLM(Resistance) = R_L
	UCLM(Resistance) = R_U
	SUM(Fail) = N_Fail
	MEAN(Fail) = P_Fail;
	FORMAT M_Def P_Fail 6.2;
RUN;


/*=========================================================
  Use the LCLM and UCLM keywords to add confidence limits 
  on the MEAN Resistance
==========================================================*/
PROC MEANS DATA=JES.Results_Q4 NOPRINT NWAY ALPHA=.05;
	CLASS Vendor Month;
	VAR Defects Resistance Fail ;
	OUTPUT OUT=Tab_7
    N(Defects)=N
	SUM(Defects) = N_Def
	MEAN(Defects)=M_Def
	MEAN(Resistance)=M_Res
	LCLM(Resistance) = R_L
	SUM(Fail) = N_Fail
	MEAN(Fail) = P_Fail;
	FORMAT M_Def P_Fail R_L 6.2;
RUN;


/*=========================================================
  Use the BETAINV and CINV functions to add confidence  
  limits on the Defect Rate and Probability of Failure
==========================================================*/
DATA Tab_8; SET Tab_6;
	FORMAT D_L D_U 8.2 P_L P_U PERCENT7.0;
	IF N_Def>0 THEN D_L=CINV(.05, 2*N_Def)/(2*N);
	D_U=CINV(.95, 2*(N_Def+1))/(2*N);
	IF N_Fail>0 THEN P_L=BETAINV(.05, N_Fail,   N+1-N_Fail);
	IF N_Fail<N THEN P_U=BETAINV(.95, N_Fail+1, N-N_Fail);
RUN;


