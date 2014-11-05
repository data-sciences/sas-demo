/***********************************************************************************
Changes:

2008-07-19 - Adding the new versiom of makelong and makewide macro
2008-10-07 - Remove the $ sign of the INPUT functions calls
2008-10-07 - change the default of parameter LIB from WORK to SASUSER in the macros 
			 %RememberCategories, %CheckCategories, %RememberDistribution, %CheckDistribution
2008-12-16 - Macro %CREATEPROPS: Adding an %UPCASE function to the %IF clause, when checking the parameter MV_BASELINE
2012-10-10 - Change MAKEWIDE and MAKELONG to work if no BY variable exists;


************************************************************************************/


/*-------------------------------------------------------------------------------------------
Macros

Chapter 14
				MAKEWIDE
				MAKELONG
				TRANSP_CAT
				REPLACE_MV

Chapter 16
			    INTERACT
				SHIFT
				FILTER

Chapter 18		
                CONCENTRATE

Chapter 20
				CREATEPROPS
				PROPSCORING
				TARGETCHART

Chapter 22
				RESTRICTEDSAMPLE
				SAMPLINGVAR
				CLUS_SAMPLE
				CLUS_SAMPLE_RES

Chapter 23
				ALERTNUMERICMISSING
				ALTERCHARMISSING
				REMEMBERCATEGORIES
				CHECKCATEGORIES
				REMEBERDISTRIBUTION
				SCOREDISTRIBUTION

Appendix C
				MAKEWIDE_DS
				MAKELONG_DS
				TRANSP_CAT_DS


-------------------------------------------------------------------------------------------*/




/*-------------------------------------------------------------------------------------------
Chapter 14
-------------------------------------------------------------------------------------------*/

%MACRO MAKEWIDE (DATA=,OUT=out,COPY=,ID=,
                 VAR=, TIME=time);


%MACRO MAKEWIDE_BASIS (DATA=,OUT=out,COPY=,ID=,
                 VAR=, TIME=time);
*** Macro that transposes one variable per by-group;
*** Dr. Gerhard Svolba, May 2nd 2008 - Rel 2.1; 
PROC TRANSPOSE DATA   = &data
               PREFIX = &var
               OUT    = &out(DROP = _name_);
 %IF &ID ne %THEN %DO; BY  &id &copy; %END;
 VAR &var;
 ID  &time;
RUN;
%MEND;

*** Calculate number of variables;
%LET c=1; 
%DO %WHILE(%SCAN(&var,&c) NE); 
	%LET c=%EVAL(&c+1);
%END;
%LET nvars=%EVAL(&c-1);

%IF &nvars=1 %then %do; %*** macro is  called with only one variable;  
   %MAKEWIDE_BASIS(data=&data, out = &out, copy=&copy, id=&id, var=&var,time=&time);
%END; %** end: only 1 variable;

%ELSE %DO; ** more then 2 vars;

 %DO i = 1 %TO &nvars;
    %MAKEWIDE_BASIS(data=&data, out = _mw_tmp_&i., copy=&copy, id=&id, var=%scan(&var,&i),time=&time);
 %END; *** end do loop;

 data &out;
  %IF &ID ne %THEN %DO;
   merge %do i = 1 %to &nvars; _mw_tmp_&i. %end; ;
   by &id;
  %END;
  %ELSE %DO;
    %do  i = 1 %to &nvars; set _mw_tmp_&i. ; %end; 
  %END;
 run;


%END;


%MEND;




%MACRO MAKELONG(DATA=,OUT=,COPY=,ID=,ROOT=,MEASUREMENT=Measurement);


*** Define a help macro; 
%MACRO MAKELONG_BASIS(DATA=,OUT=,COPY=,ID=,ROOT=,MEASUREMENT=Measurement);
*** Macro that transposes one variable per by-group;
*** Dr. Gerhard Svolba, May 2nd 2008 - Rel 2.1; 
PROC TRANSPOSE DATA = &data(keep = &id &copy &root.:)
               OUT  = &out(rename = (col1 = &root))
               NAME = _measure;
 %IF &ID ne %THEN %DO;  BY &id &copy; %end;
RUN;
*** Create variable with measurement number;
DATA &out;
 SET &out;
 FORMAT &measurement 8.;
 _measure=upcase(_measure);
 &Measurement = INPUT(TRANWRD(_measure,upcase("&root"),''),8.);
 DROP _measure;
RUN;
%MEND;


*** Calculate number of variables;
%LET c=1; 
%DO %WHILE(%SCAN(&root,&c) NE); 
	%LET c=%EVAL(&c+1);
%END;
%LET nvars=%EVAL(&c-1);

%IF &nvars=1 %then %do; %*** macro is  called with only one variable;  
   %MAKELONG_BASIS(data=&data, out = &out, copy=&copy, id=&id, root=&root,measurement=&measurement);
%END; %** end: only 1 variable;

%ELSE %DO; ** more then 2 vars;

 %DO i = 1 %TO &nvars;
    %MAKELONG_BASIS(data=&data, out = _mw_tmp_&i., copy=&copy, id=&id, root=%scan(&root,&i),MEASUREMENT=&Measurement);
 %END; *** end do loop;


 data &out;
  %IF &ID ne %THEN %DO;
   merge %do i = 1 %to &nvars; _mw_tmp_&i. %end; ;
   by &id;
  %END;
  %ELSE %DO;
    %do  i = 1 %to &nvars; set _mw_tmp_&i. ; %end; 
  %END;
 run;


%END;


%MEND;






%MACRO TRANSP_CAT(DATA = , OUT = TRANSP, VAR = , ID =);

PROC FREQ DATA  = &data NOPRINT;
 TABLE &id * &var / OUT = tmp(DROP = percent);
RUN;

PROC TRANSPOSE DATA = tmp
               OUT  = &out (DROP = _name_);
 BY &id;
 VAR count;
 ID &var;
RUN;

%MEND;




%MACRO REPLACE_MV(cols,mv=.,rplc=0);
 ARRAY varlist {*}  &cols;
 DO _i = 1 TO dim(varlist);
   IF varlist{_i} = &mv THEN varlist{_i}=&rplc;
 END;
 DROP _i;
%MEND;



/*-------------------------------------------------------------------------------------------
Chapter 16
-------------------------------------------------------------------------------------------*/



%MACRO interact(vars, quadr = 1, prefix = INT);
*** Load the number of itenms in &VARS into macro variable NVARS;
%LET c=1; 
%DO %WHILE(%SCAN(&vars,&c) NE); 
	%LET c=%EVAL(&c+1);
%END;
%LET nvars=%EVAL(&c-1);
 %DO i = 1 %TO &nvars;
   %DO j = %EVAL(&i+1-&quadr) %TO &nvars;
      &prefix._%SCAN(&vars,&i)_%SCAN(&vars,&j) = 
                        %SCAN(&vars,&i) * %SCAN(&vars,&j);
   %END;
 %END;
%MEND;





%MACRO SHIFT (OPERATION,VAR,VALUE, MISSING=PRESERVE);
 %IF %UPCASE(&missing) = PRESERVE %THEN %DO;
          IF &var NE . THEN &var = &operation(&var,&value); 
  %END;
  %ELSE %IF %UPCASE(&missing) = REPLACE %THEN %DO;
          &var = &operation(&var,&value); 
  %END;
%MEND;






%MACRO FILTER (VAR,OPERATION,VALUE, MISSING=PRESERVE);
 %IF %UPCASE(&missing) = PRESERVE %THEN %DO;
          IF &var NE . AND &var &operation &value THEN DELETE; %END;
 %ELSE %IF %UPCASE(&missing) = DELETE %THEN %DO;
         IF &var &operation &value THEN DELETE; %END;
%MEND;


/*-------------------------------------------------------------------------------------------
Chapter 18
-------------------------------------------------------------------------------------------*/

%MACRO Concentrate(data,var,id);

*** Sort by ID and VALUE;
PROC SORT DATA=&data(keep=&var &id) OUT=_conc_;
 BY &id DESCENDING &var;
RUN;

*** Calculation of the SUM per ID;
PROC MEANS DATA=_conc_ NOPRINT;
 VAR &var;
 BY &id;
 OUTPUT out = _conc_sum_(DROP=_type_ _freq_) SUM=&var._sum;
 WHERE &var ge 0;
RUN;

*** Merge the sum to the original sorted dataset;
DATA _conc2_;
 MERGE _conc_
       _conc_sum_;
 BY &id;
 IF FIRST.&id THEN &var._cum=&var;  			        
 ELSE &var._cum+&var;
 &var._cum_rel=&var._cum/&var._sum; 
 IF LAST.&id AND NOT FIRST.&id THEN skip = 1; ELSE skip=0;
RUN;

*** Calcuation of the median per ID;
PROC UNIVARIATE DATA=_conc2_ noprint;
 BY &id;
 VAR &var._cum_rel;
 OUTPUT out=concentrate_&var. MEDIAN=&var._conc;
 WHERE skip =0;
RUN;
%MEND;




/*-------------------------------------------------------------------------------------------
Chapter 20
-------------------------------------------------------------------------------------------*/

%MACRO CreateProps(data=,vars=,target=,library=sasuser,
                   out_ds=,mv_baseline=YES,type=c,other_tag="OTHER");
*** Load the number of items in &VARS into macro variable NVARS;
%LET c=1; 
%DO %WHILE(%SCAN(&vars,&c) NE); 
	%LET c=%EVAL(&c+1);
%END;
%LET nvars=%EVAL(&c-1);

*** Loop over the Variables in Vars;
%DO i = 1 %TO &nvars;
   *** Calculate the MEAN of the target variable for each group;
   PROC MEANS DATA = &data NOPRINT MISSING;
   FORMAT &target 16.3;
    VAR &target;
    CLASS %SCAN(&vars,&i);
    OUTPUT OUT = work.prop_%SCAN(&vars,&i) MEAN=;
   RUN;

   %IF %UPCASE(&MV_BASELINE) = YES %THEN %DO;
       PROC SORT DATA = work.prop_%SCAN(&vars,&i);
	    BY _type_ %SCAN(&vars,&i);
	   RUN;
   	   DATA work.prop_%SCAN(&vars,&i);
	    SET work.prop_%SCAN(&vars,&i);
        &target._lag=lag(&target);
		IF _type_ = 1 and %SCAN(&vars,&i) IN ("",".") Then
		       &target=&target._lag;
	   RUN;
   %END;

   *** Prepare a dataset that is used to create a format;
   DATA work.prop_%SCAN(&vars,&i);
        %IF &type = n %THEN %DO;
	    	SET work.prop_%SCAN(&vars,&i)(rename = (%SCAN(&vars,&i) = tmp_name));;
		    %SCAN(&vars,&i) = PUT(tmp_name,16.);
        %END;
		%ELSE %DO; 
            SET work.prop_%SCAN(&vars,&i);;
			IF UPCASE(%SCAN(&vars,&i)) = 'OTHER' THEN %SCAN(&vars,&i) = '_OTHER';
        %END;
  		IF _type_ = 0 THEN DO; 
                                %SCAN(&vars,&i)=&other_tag;
								_type_ = 1;
												END;
	   RUN;
          
   DATA fmt_tmp;
    SET work.prop_%SCAN(&vars,&i)(RENAME=(%SCAN(&vars,&i) = start &target=label)) END = last;;
	*WHERE _type_ = 1;
    RETAIN fmtname "%SCAN(&vars,&i)F" type "&type";
   RUN;
   *** Run PROC Format to create the format;
   PROC format library = &library CNTLIN = fmt_tmp;
   RUN;
%end;
*** Use the available Formats to create new variables;
options fmtsearch = (&library work sasuser);
DATA &out_ds;
 SET &data;
 FORMAT %DO i = 1 %TO &nvars;    %SCAN(&vars,&i)_m  %END; 16.3;
 %DO i = 1 %TO &nvars;
   %IF &type = c %THEN IF UPCASE(%SCAN(&vars,&i)) = 'OTHER' THEN %SCAN(&vars,&i) = '_OTHER';;
   %SCAN(&vars,&i)_m = INPUT(PUT(%SCAN(&vars,&i),%SCAN(&vars,&i)f.),16.3);
 %END;
RUN;
%mend;





%MACRO PropScoring(data=, out_ds=,vars=,library=sasuser,type=c);
options fmtsearch = (&library work sasuser);
%LET c=1; 
%DO %WHILE(%SCAN(&vars,&c) NE); 
	%LET c=%EVAL(&c+1);
%END;
%LET nvars=%EVAL(&c-1);

DATA &out_ds;
 SET &data;
 FORMAT %DO i = 1 %TO &nvars;    %SCAN(&vars,&i)_m  %END; 16.3;;
 %DO i = 1 %TO &nvars;
   %IF &type = c %THEN IF UPCASE(%SCAN(&vars,&i)) = 'OTHER' THEN %SCAN(&vars,&i) = '_OTHER';;
   %SCAN(&vars,&i)_m = INPUT(PUT(%SCAN(&vars,&i),%SCAN(&vars,&i)f.),16.3);
 %END;
RUN;
%MEND;




%MACRO TARGETCHART(data=,target=,interval=,class=); 
PROC SQL NOPRINT;
 SELECT AVG(&Target) INTO :_Mean FROM &data;
QUIT;
PROC GCHART DATA=&data;
%IF &class ne %THEN; HBAR &class /TYPE=MEAN FREQ DISCRETE MISSING SUMVAR=&target SUM MEAN REF=&_mean;
%IF &interval ne %THEN; HBAR &interval/type=MEAN FREQ MISSING SUMVAR=&target SUM MEAN REF=&_mean;
RUN;
QUIT;
%MEND;


/*-------------------------------------------------------------------------------------------
Chapter 22
-------------------------------------------------------------------------------------------*/



%MACRO RestrictedSample(data=,sampledata=,n=);
*** Count the number of observations in the input
    dataset, without using PROC SQL or other table scans
    --> Saves Time;
DATA _NULL_;
  CALL SYMPUT('n0',STRIP(PUT(nobs,8.)));
  STOP;
  SET &data nobs=nobs;
RUN;

DATA &sampledata;
 SET &data;
 IF smp_count < &n THEN DO;
  IF RANUNI(123)*(&n0 - _N_) <= (&n - smp_count) THEN DO;
      OUTPUT;
      Smp_count+1;
  END;
 END;
RUN;
%MEND;




%MACRO SamplingVAR(eventvar=,eventrate=);
FORMAT Sampling 8.1;
IF &eventvar=1 THEN Sampling=101;
ELSE IF &eventvar=0 THEN 	
   Sampling=(&eventrate*100)/(RANUNI(34)*(1-&eventrate)+&eventrate);
%MEND;



%MACRO Clus_Sample (data = , id =, outsmp=, prop = 0.1, n=, seed=12345 );
 /*** Macro for clustered unrestricted sampling
      Gerhard Svolba, Feb 2005
      The macro draws a clustered sample in one datastep.
      The exact sample count or sample proportion is not
      controlled.
      Macro Parameters:
      DATA  The name of the base dataset
            The name of the sample dataset will be created 
            as DATA_SMP_<sample count (n)>
      ID    The name of the ID-Variable, that identifes the
            subject or BY group;
      PROP  Sample Proportion as a number from 0 to 1
      N     Sample count as an absolute number 
      SEED  Seed for the random number function;
     Note that PROP and N relate to the distinct ID-values;
 ***/
DATA _test_;
   SET &data;
   BY &ID;
   IF first.&id;
RUN;
DATA _NULL_;
  CALL SYMPUT('n0',STRIP(PUT(nobs,8.)));
  STOP;
  SET _test_ nobs=nobs;
RUN; 
%IF &n NE %THEN %let prop = %SYSEVALF(&n/&n0);

DATA &outsmp;
  SET &data;
  BY &id;
  RETAIN smp_flag;
  	IF FIRST.&id AND RANUNI(&seed) < &prop THEN DO; 
    smp_flag=1;
    OUTPUT;          
  	END;
  	ELSE IF smp_flag=1 THEN DO;
    OUTPUT;  
    IF LAST.&id THEN smp_flag=0;
  	END;
  DROP smp_flag;
 RUN;
%MEND;



%MACRO Clus_Sample_Res (data = , id =, outsmp=, prop = 0.1, n=, seed=12345 );
DATA _test_;
   SET &data;
   BY &ID;
   IF first.&id;
RUN;
DATA _NULL_;
  CALL SYMPUT('n0',STRIP(PUT(nobs,8.)));
  STOP;
  SET _test_ nobs=nobs;
RUN; 
 %IF &n EQ %THEN %let n = %SYSEVALF(&prop*&n0);
 DATA &outsmp;
  SET &data;
  BY &id;
  RETAIN smp_flag;
  IF smp_count < &n THEN DO;
   IF FIRST.&id THEN DO;
     id_count + 1;
     IF uniform(&seed)*(&n0 - id_count) < (&n - smp_count) THEN DO; 
  	        smp_flag=1;
          OUTPUT;   
     END; 
    END;
   ELSE IF smp_flag=1 THEN DO;
        OUTPUT;  
        IF LAST.&id THEN DO;
             smp_flag=0;
             smp_count + 1;
        END;
   END;
  END;	 
  DROP smp_flag smp_count;
 RUN;
%MEND;



/*-------------------------------------------------------------------------------------------
Chapter 23
-------------------------------------------------------------------------------------------*/


%MACRO AlertNumericMissing (data=,vars=_NUMERIC_,alert=0.2);
PROC MEANS DATA = &data NMISS NOPRINT;
 VAR &vars;
 OUTPUT OUT = miss_value NMISS=;
RUN;
PROC TRANSPOSE DATA  = miss_Value(DROP = _TYPE_)
               OUT   = miss_value_tp;
RUN;
DATA miss_value_tp;
 SET miss_value_tp;
 FORMAT Proportion_Missing 8.2;
 RETAIN N;
 IF _N_ = 1 THEN N = COL1;
 Proportion_Missing = COL1/N;
 Alert = (Proportion_Missing >=  &alert);
 RENAME _name_ = Variable
        Col1 = NumberMissing;
 IF _name_ = '_FREQ_' THEN DELETE;		
RUN;
TITLE Alertlist for Numeric Missing Values;
TITLE2 Data = &data -- Alertlimit >= &alert;
PROC PRINT DATA = miss_value_tp;
RUN;
TITLE;TITLE2;
%MEND;




%MACRO ALERTCHARMISSING(data=,vars=,alert=0.2);
*** LOAD THE NUMBER OF ITENMS IN &VARS INTO MACRO VARIABLE NVARS;
%LET C=1; 
%DO %WHILE(%SCAN(&vars,&c) NE); 
	%LET C=%EVAL(&c+1);
%END;
%LET NVARS=%EVAL(&C-1);
*** CALCULATE THE NUMBER OF OBSERVATIOSN IN THE DATASET;
DATA _NULL_;
  CALL SYMPUT('N0',STRIP(PUT(nobs,8.)));
  STOP;
  SET &data NOBS=NOBS;
RUN;
PROC DELETE DATA = work._CharMissing_;RUN;
%DO I = 1 %TO &NVARS;
 PROC FREQ DATA = &data(KEEP =%SCAN(&VARS,&I))  NOPRINT;
    TABLE %SCAN(&vars,&I) / MISSING OUT = DATA_%SCAN(&vars,&I)(WHERE =(%SCAN(&vars,&I) IS MISSING));
 RUN;
 DATA DATA_%SCAN(&vars,&i);
 FORMAT VAR $32.;
  SET data_%SCAN(&vars,&i);
  VAR = "%SCAN(&vars,&i)";
  DROP %SCAN(&vars,&i) PERCENT;
 RUN;
 PROC APPEND BASE = work._CharMissing_ DATA = DATA_%SCAN(&vars,&i) FORCE;
 RUN;
%END;
PROC PRINT DATA = work._CharMissing_;
RUN;

DATA _CharMissing_;
 SET _CharMissing_;
 FORMAT Proportion_Missing 8.2;
 N=&N0;
 Proportion_Missing = Count/N;
 Alert = (Proportion_Missing > &alert);
 RENAME var = Variable
        Count = NumberMissing;
 *IF _NAME_ = '_FREQ_' THEN DELETE;		
RUN;
TITLE ALERTLIST FOR CATEGORICAL MISSING VALUES;
TITLE2 DATA = &DATA -- ALERTLIMIT >= &ALERT;
PROC PRINT DATA = _CharMissing_;
RUN;
TITLE;TITLE2;

%MEND;





%MACRO RememberCategories(data =, vars=,lib=sasuser);
*** Load the number of itenms in &VARS into macro variable NVARS;
%LET c=1; 
%DO %WHILE(%SCAN(&vars,&c) NE); 
	%LET c=%EVAL(&c+1);
%END;
%LET nvars=%EVAL(&c-1);

%DO i = 1 %TO &nvars;
PROC FREQ DATA = &data NOPRINT;
 TABLE %SCAN(&vars,&i) / MISSING OUT = &lib..cat_%SCAN(&vars,&i)(DROP = COUNT PERCENT);
RUN;
%END;

%MEND;



%MACRO CheckCategories(scoreds=, vars=,lib=sasuser);
*** Load the number of itenms in &VARS into macro variable NVARS;
%LET c=1; 
%DO %WHILE(%SCAN(&vars,&c) NE); 
	%LET c=%EVAL(&c+1);
%END;
%LET nvars=%EVAL(&c-1);

%DO i = 1 %TO &nvars;
PROC FREQ DATA = &scoreds NOPRINT;
 TABLE %SCAN(&vars,&i) / MISSING OUT = &lib..score_%SCAN(&vars,&i)(DROP = COUNT PERCENT);
RUN;


PROC SQL;
    CREATE TABLE &lib..NEW_%SCAN(&vars,&i)
	AS
    SELECT %SCAN(&vars,&i)
    FROM &lib..score_%SCAN(&vars,&i)
	EXCEPT
    SELECT %SCAN(&vars,&i)
    FROM &lib..cat_%SCAN(&vars,&i)
	;
QUIT;
TITLE New Categories found for variable %SCAN(&vars,&i);
PROC PRINT DATA = &lib..NEW_%SCAN(&vars,&i);
RUN;
TITLE;
%END;	
%MEND;





%MACRO RememberDistribution(data=,vars=_NUMERIC_,lib=sasuser,stat=median);
 PROC MEANS DATA = &data NOPRINT;
  VAR &vars;
  OUTPUT OUT = &lib..train_dist_&stat &stat=;
 RUN;

PROC TRANSPOSE DATA  = &lib..train_dist_&stat(DROP = _TYPE_ _FREQ_)
               OUT   = &lib..train_dist_&stat._tp(RENAME = (_NAME_ = Variable
                                                     Col1   = Train_&stat));
RUN;
%MEND;


%MACRO ScoreDistribution(data=,vars=_NUMERIC_,lib=sasuser,stat=median,alert=0.1);
 PROC MEANS DATA = &data NOPRINT;
  VAR &vars;
  OUTPUT OUT = &lib..score_dist_&stat &stat=;
 RUN;

PROC TRANSPOSE DATA  = &lib..score_dist_&stat(DROP = _TYPE_ _FREQ_)
               OUT   = &lib..score_dist_&stat._tp(RENAME = (_NAME_ = Variable
                                                     Col1   = Score_&stat));
RUN;

PROC SORT DATA = &lib..train_dist_&stat._tp;
 BY variable;
RUN;

PROC SORT DATA = &lib..score_dist_&stat._tp;
 BY variable;
RUN;


DATA &lib..compare_&stat;
 MERGE &lib..train_dist_&stat._tp &lib..score_dist_&stat._tp;
 BY variable;
 DIFF = (Score_&stat - Train_&stat);
 IF Train_&stat NOT IN (.,0) THEN 
      DIFF_REL = (Score_&stat - Train_&stat)/Train_&stat;
 Alert = (ABS(DIFF_REL) > &alert);
RUN;

TITLE Alertlist for Distribution Change;
TITLE2 Data = &data -- Alertlimit >= &alert;
PROC PRINT DATA = &lib..compare_&stat;
RUN;
TITLE;TITLE2;

%MEND;



/*-------------------------------------------------------------------------------------------
Appendix C
-------------------------------------------------------------------------------------------*/



%MACRO makewide_ds(DATA=,OUT=,COPY=,ID=,VAR=,
                   TIME=Measurement);

*** Part 1 - Creating a list of Measurement IDs;
PROC FREQ DATA = &data NOPRINT;
 TABLE &time / OUT = distinct (DROP = count percent);
RUN;

DATA _null_;
 SET distinct END = eof;
 FORMAT _string_ $32767.;
 RETAIN _string_;
 _string_ = CATX(' ',_string_, &time);
 IF eof THEN DO;
    CALL SYMPUT('list',_string_);
	CALL SYMPUT('max',_n_);
 END;
RUN;

*** Part 2 - Using a SAS datastep for the transpose;
DATA &out;
 SET &data;
 BY &id;
 RETAIN %DO i= 1 %to &max; &var%SCAN(&list,&i) %END; ;
 IF FIRST.&id THEN DO;
  %DO i= 1 %TO &max; &var%SCAN(&list,&i)=.; %END; ;
 END;
 %DO i = 1 %TO &max;
 	IF &time = %SCAN(&list,&i) THEN DO;
	  &var%SCAN(&list,&i) = &var;
	END;
 %END;
 IF LAST.&id THEN OUTPUT;
 KEEP &id &copy %DO i= 1 %to &max; &var%SCAN(&list,&i) %END;;
RUN;

%MEND;





%MACRO makelong_ds(DATA=,OUT=,COPY=,ID=,LIST=,MAX=,MIN=,
          ROOT=,TIME=Measurement);

DATA &out(WHERE = (&root NE .));
 SET &data;
 %IF &list NE %THEN %DO;
 *** run the macro in LIST-Mode;

*** Load the number of itenms in &VARS into macro variable NVARS;
%LET c=1; 
%DO %WHILE(%SCAN(&list,&c) NE); 
	%LET c=%EVAL(&c+1);
%END;
%LET nvars=%EVAL(&c-1);

 	%DO i = 1 %TO &nvars;
    	&root=&root.%SCAN(&list,&i); 
    	&time = %SCAN(&list,&i); 
    	OUTPUT;
 	%END;
 %END;
 %ELSE %DO;
 *** run the macro in FROM/TO mode;
 	%DO i = &min %TO &max;
    	&root=&root.&i; 
    	&time= &i; 
    	OUTPUT;
 	%END; 
 %END;
 KEEP &id &copy &root &time;
RUN;

%MEND;



%MACRO TRANSP_CAT_DS (DATA = , OUT = out, VAR = , ID =);
*** PART1 - Aggregating multiple categories per subject;
PROC FREQ DATA  = &data NOPRINT;
 TABLE &id * &var / OUT = out(DROP = percent);
 TABLE &var /  OUT = distinct (drop = count percent); 
RUN;
*** PART2 - Assigning the list of categories into a macro-variable;
DATA _null_;
 SET distinct END = eof;
 FORMAT _string_ $32767.;
 RETAIN _string_;
 _string_ = CATX(' ',_string_, &var);
 IF eof THEN DO;
    CALL SYMPUT('list',_string_);
	CALL SYMPUT('_nn_',_n_);
 END;
RUN;
*** PART3 - Using a SAS-datastep for the transpose;
DATA &out;
 SET out;
 BY &id;
 RETAIN &list ;
 IF FIRST.&id THEN DO;
  %DO i= 1 %TO &_nn_; %SCAN((&list),&i)=.; %END; ;
 END;
 %DO i = 1 %TO &_nn_;
 	IF &var = "%scan(&list,&i)" THEN  %SCAN((&list),&i) = count;
 %END;
 IF LAST.&id THEN OUTPUT;
 DROP &var count;
RUN;

%MEND;
