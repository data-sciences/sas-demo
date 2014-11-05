/*****************************************************************************
***  Macros for the Book "Data Quality for Analytics Using SAS"
***  Actual Version 1.1 - October, 9th 2012
***  Dr. Gerhard Svolba
***
***  Earlier versions: Version 1.0 - May, 22nd 2012
***
***  List of provided macros:
***  %COUNT_MV
***  %MV_PROFILING
***  %PROFILE_TS_MV
***  %CHECK_TIMEID
***  %TS_History_CHECK
***  %TS_HISTORY_CHECK_ESM
***
***  Report any problems and questions for the macros to the author:
***  mail: sastools.by.gerhard@gmx.net
***
******************************************************************************/




/**************************************************************************
*** COUNT_MV -- see section 10.2 Simple Profiling of Missing Values
***************************************************************************/

*** 20121008 - Version slightly changed form the printed version in the book in order to make
               columns available in table 10.2 available;

%MACRO COUNT_MV(data=,vars=);
*** LOAD THE NUMBER OF ITEMS IN &VARS INTO MACRO VARIABLE NVARS;
%LET C=1;
%DO %WHILE(%SCAN(&vars,&c) NE);
    %LET C=%EVAL(&c+1);
%END;
%LET NVARS=%EVAL(&C-1);
*** CALCULATE THE NUMBER OF OBSERVATIONS IN THE DATASET;
DATA _NULL_;
  CALL SYMPUT('N0',STRIP(PUT(nobs,8.)));
  STOP;
  SET &data NOBS=NOBS;
RUN;
PROC DELETE DATA = _CharMissing_;RUN;
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
 PROC APPEND BASE = _CharMissing_ DATA = DATA_%SCAN(&vars,&i) FORCE;
 RUN;
 PROC DELETE DATA=DATA_%SCAN(&vars,&i);RUN;
%END;

DATA _CharMissing_;
 SET _CharMissing_;
 FORMAT Proportion_Missing 8.2;
 N=&N0;
 Proportion_Missing = Count/N;
 RENAME var = Variable
        Count = NumberMissing;
RUN;

PROC PRINT DATA = _CharMissing_;
RUN;
TITLE;TITLE2;

%MEND;





/**************************************************************************
*** MV_PROFILING -- see section 10.3 Profiling the Structure of Missing Values
***************************************************************************/


%macro MV_PROFILING (data=,vars=_ALL_,ODS=YES,varclus=YES,princomp=YES,ncomp=2,sample=1,seed=123456,order=ALPHA);
%* Analyses Frequencies and the structure of missing values in a dataset;
%* Dr. Gerhard Svolba - 2010-01-10;

title "Missing Value Profiling for data = &data";

%*** 1. Prepare a list of variables, if necessary;
%if %upcase(&vars) = _ALL_ or %INDEX(&vars,:) ne 0 %then %do; 

%* Retrieve Variables from Proc Contents;
proc contents data = &data
              out = _Vars_content_(keep =  name npos)
			  noprint;
run;

%if %INDEX(&vars,:) ne 0 %then %do;
 data _Vars_content_;
  set _Vars_content_;
  if upcase(name)=:"%upcase(%scan(&vars,1,:))" then output;
 run;


%end;

%if %upcase(&order) = POS %then %do;
  proc sort data = _Vars_content_;
    by npos;
  run;
%end;

%*Initiatlize vars;
%let vars = ;

proc sql noprint;
 select name 
 into :vars separated by " "
 from _vars_content_ ;
quit;

%put vars = &vars;

%end; %* END: Prepare a list of variables, if necessary;



%*** 2. Calculate number of variables in the macro list;
%LET c=1; 
%DO %WHILE(%SCAN(&vars,&c) NE); 
	%LET c=%EVAL(&c+1);
%END;
%LET nvars=%EVAL(&c-1);
%put nvars = &nvars;

%put nvars = &nvars;
%if &nvars ne 0 %then %do;

%*** 3. Create Flags for Missing Values;

data _profile_mv_tmp_;
 set &data(keep = &vars);
 format MV_PROFILE_CHAIN $%eval(&nvars.+8).;  %* Format length = Number of Variables;
 %if &sample ne 1 %then %do;
      if uniform(&seed) gt &sample then delete;
 %end;
%* Initialize Liste;
MV_PROFILE_CHAIN=''; 
%let vars_mv=;

%* Create derived variables and list;
%do i = 1 %to &nvars;
  %SCAN(&vars,&i)_MV = missing(%SCAN(&vars,&i));
  %let vars_mv = &vars_mv %SCAN(&vars,&i)_MV;
  MV_PROFILE_CHAIN=cats(MV_PROFILE_CHAIN,%SCAN(&vars,&i)_MV);
%end;
N_MV = sum(of &vars_mv);
MV_PROFILE_CHAIN=catx('_',MV_PROFILE_CHAIN,put(n_mv,best.));
run;

proc means data = _profile_mv_tmp_  noprint;
 var &vars_mv;
 output out = _profile_mv_sum_ sum=;
run;

proc transpose data = _profile_mv_sum_(drop = _type_) out = _profile_mv_sum_tp;
run;

data _profile_mv_sum_tp;
 set _profile_mv_sum_tp;
 retain nobs;
 if _n_ = 1 then nobs = col1;
 else do;
	Variable = substr(_name_,1,length(_name_)-3);
    format Missing_Rel percent8.2;
	Missing_Rel = col1/nobs;
  end;
 rename col1 = Missing_Abs;
 if _n_=1 then delete;
run;

*** Create Lookup for MV_Profiles;
proc sql;
 title2 Lookup for variable names and MV_PROFILE patterns;
 select upcase(Variable) as Variable,
		%do i = 1 %to &nvars;put((variable="%scan(&vars,&i)"),1.)||%end;'' as MV_PROFILE
 from _profile_mv_sum_tp
 order by 2 desc;
quit;

%*** 4. Create Frequencies for Missing Values per Variable and Missing Value Profile;
%* Missing Value Profile;

proc freq data = _profile_mv_tmp_ order = freq;
 title2 Distribution of MV_PROFILE_CHAIN;
 table MV_PROFILE_CHAIN/out = _profile_mv_freq_;
run;

%* Display patterns of missing values graphically with a TILE Chart;
%if %upcase(&ods) = YES %THEN %DO;
proc gtile data=_profile_mv_freq_;
  title2 Tile-Chart for the distribution of MV_PROFILE_CHAIN;
  tile count tileby = (MV_PROFILE_CHAIN);
run;
quit;
%end; %* ODS TILE CHART YES/NO;

%put vars = &vars;
%put vars_mv = &vars_mv;

data _profile_mv_tmp_vc;
set _profile_mv_tmp_(drop = &vars);
 where scan(MV_PROFILE_CHAIN,2,'_') ne '0';
 %do i = 1 %to &nvars;
     rename %SCAN(&vars_mv,&i) = %SCAN(&vars,&i); 
	 %put i = &i;
 %end;
run;

proc freq data = _profile_mv_tmp_;
 title2 Distribution of Number of Missing Values per Observation;
 table n_mv;
run;

%* Frequenies for Missing Values per Variable;
 
proc sql;
 title2 Variable list ordered by number of missing values;
 select upcase(Variable) as Variable,
        Missing_Abs,
		Missing_Rel,
		%do i = 1 %to &nvars;put((variable="%scan(&vars,&i)"),1.)||%end;'' as MV_PROFILE
 from _profile_mv_sum_tp
 order by 2 desc;
quit;

%if %upcase(&varclus) = YES and %upcase(&ods) = YES %then %do;
proc varclus data=_profile_mv_tmp_vc centroid outtree = _mv_profile_tree_ noprint;
 var &vars;
run;

axis1 order=(0.5 to 1 by 0.1);
axis2 label=none;
proc tree data = _mv_profile_tree_ horizontal haxis=axis1 vaxis=axis2;
 title2 Missing Valule based Clustering of Variables;
      height _propor_;
      id _label_;
run;

%end; %* Varclas YES/NO;

%if %upcase(&princomp) = YES and %upcase(&ods)=YES %then %do;
ods select  eigenvalues patternplot;
ods graphics on;
PROC PRINCOMP DATA = _profile_mv_tmp_vc  out=pc_out outstat = pc_out_stat
	PREFIX='PRIN'n
	SINGULAR=1E-08
	VARDEF=DF
	plots(ncomp=&ncomp) = pattern	
;
 title2 Principal component analysis based of missing values;
 var &vars;
 where scan(MV_PROFILE_CHAIN,2,'_') ne '0';
RUN;
ods select all;
ods graphics off;
%end; %* Princompo YES/NO;

%end; %* IF elements in VARS;

title2;title;
%mend;





/**************************************************************************
*** PROFILE_TS_MV -- see section 11.2 Profiling the Structure of Missing Values for Time Series Data
***************************************************************************/



%macro Profile_TS_MV (data=,id=,cross=,date=,value=,
                      mv=(.),zv=(0),plot=YES,w=1,nmax_ts=100);
proc sql noprint;
 select count(distinct &date) into :maxlength from &data;
 select count(distinct &id) into :nseries from &data;
quit;

proc sort data = &data(rename = (&id = _id_)) out = sorted_input_data;
 by _id_;
run;

** if cross sectional dimension are specified, create a concatenated _ID_ variable ;
%if &cross ne %then %do; 

%LET c=1; 
%DO %WHILE(%SCAN(&cross,&c) NE); 
	%LET c=%EVAL(&c+1);
%END;
%LET ncrossvars=%EVAL(&c-1);

data sorted_input_data;
   set sorted_input_data; 
   %do i= 1 %to &ncrossvars;
     _id_ = catx('_',_id_,%scan(&cross,&i));
   %end;
  drop &cross;
  run;
%end;

** Resort may be necessary as '_' is concatenated to a string of variable length;
proc sort data =  sorted_input_data;
 by _id_;
run;

data MV_PROFILE_TS(keep = _id_ TS_Profile_Chain TS_Profile_Chain_Unique n nmiss)
     MV_PROFILE_TS_PLOT(keep = _id_ &date idx2);
 set sorted_input_data;
 by _id_;
 format TS_Profile_Chain TS_Profile_Chain_Unique $%eval(&maxlength.+9).;
 retain TS_Profile_Chain TS_Profile_Chain_unique;
 
 *** Init;
 if first._id_ then do; 
                 TS_Profile_Chain = ''; 
                 TS_Profile_Chain_unique=''; 
				 N=1;NMiss=0;
                                end;

 *** Missing;
 n+1;								
 *_ActualMV_ = put(1-(&value in &mv.),1.);
 if &value in &mv. then _ActualMV_='X';
 else if &value in &zv. then _ActualMV_='0';
 else _ActualMV_='1';
 if _ActualMV_ = 'X' then nmiss+1;
 TS_Profile_Chain = cats(TS_Profile_Chain,_ActualMV_);
 lag_actual_MV = lag(_ActualMV_);
 if first._id_ or _ActualMV_ ne lag_actual_MV then TS_Profile_Chain_Unique=cats(TS_Profile_Chain_Unique,_ActualMV_);
 if _ActualMV_  in &mv.  
        or _ActualMV_ in &zv. then idx2 = .; else idx2 = 1;

 if last._id_ then do;
             TS_Profile_Chain=catx('_',TS_Profile_Chain,n,nmiss);
             output MV_PROFILE_TS;
 end;
 output MV_PROFILE_TS_PLOT;
run;

title Time Series Profiling for Data = &data;

proc freq data = MV_PROFILE_TS order = freq;
 title2 Frequencies of TS_PROFILE_CHAIN;
 table TS_Profile_Chain;
run;

proc freq data = MV_PROFILE_TS order = freq;
 title2 Frequencies of TS_PROFILE_CHAIN_UNIQUE;
 table TS_Profile_Chain_Unique; 
run;

proc freq data = MV_PROFILE_TS;
 title2 Distribution of time series length and number of missing values;
 table  N NMiss;
run;

%if %upcase(&plot) EQ YES %then %do;

proc sql;
 select count(*)
 into :n_ts
 from  MV_PROFILE_TS
 ;
quit;
%put n_ts = &n_ts;

proc sql;
 create table MV_PROFILE_TS_PLOT
 as select catx('_',b.TS_Profile_Chain,a._id_) as _ID_,
           a.&date,
		   a.idx2,
		   a.*
    from MV_PROFILE_TS_PLOT as a
	left join MV_PROFILE_TS as b
	on a._id_ = b._id_
	order by calculated _ID_, a.&date
;
quit;

data MV_PROFILE_TS_PLOT;
 set MV_PROFILE_TS_PLOT;
 by _ID_;
 retain idx_tmp 0;
 if first._ID_ then idx_tmp = idx_tmp + 1;
 if idx2 = . then idx = .; else  idx = -idx_tmp;
run;

%* Only plot if number of time series is lower eqal than threshold;
%if &n_ts <= &nmax_ts %then %do; 

PROC GPLOT DATA = MV_PROFILE_TS_PLOT;
 title2 Profile plot for the time series structure;
 symbol i = join c=black v=none w = &w r=&nseries;
  PLOT idx * &date 	 =_ID_ / nolegend SKIPMISS;
run;
quit;

%end; %* check max ts OK;

%else %do;
 %put ---------------------------------------------------------------------------------------;
 %put ---  Number of time series = &n_ts, is higher then nmax_ts value (= &nmax_ts).         ;
 %put ---  No plot has been created. Reset parameter NMAX_TS to a value of at least &n_ts.   ;
 %put ---------------------------------------------------------------------------------------; 
%end;  %* check max ts non OK;

%end; %*plot=yes;

title; title2;
%mend Profile_TS_MV;



/**************************************************************************
*** CHECK_TIMEID -- see section 11.3 Checking and Assuring the Contiguity of Time Series Data
***************************************************************************/


%macro CHECK_TIMEID (data=,out=TIMEID_INSERTED,out_check=TIMEID_MISSING,
                     timeid=, Interval=MONTH,
                     value=,by=,mode=INSERT,
                     Insertvalue=0,CheckDummyValue=-123456789.123456789);

 %IF &by ne %THEN %DO;
  %*** If a BY-Statement is used, data needs to be sorted for Proc Timeseries
       In this case the data macro variable is set to the sorted data;
   proc sort data = &data out = TIMEID_DATA_SORT;
    by &by;
   run;
   %let data = TIMEID_DATA_SORT;
   %put data = &data;
 %END;

 %IF %upcase(&mode) = CHECK %THEN %DO;
   %*** Insert the CheckDummyValue for those TIMEIDs that are missing
       output only those observations that hold the CheckDummyValue to see
         those observations that were inserted;
   proc timeseries data = &data out = &out_check(where=(&value=&CheckDummyValue));
     id &timeid interval =&interval setmiss=&CheckDummyValue;
     var &value;
     by &by;
   run;
 %END;
 %ELSE %IF %upcase(&mode) = INSERT %THEN %DO;
   %*** Insert the InsertValue for those observations that are missing
       Output the a table that holds the existing and the inserted observations;
   proc timeseries data = &data out = &out;
     id &timeid interval =&interval setmiss=&InsertValue;
     var &value;
     by &by;
   run;
 %END; 
 
%mend;


/**************************************************************************
*** TS_History_Check -- see Appendix D – Macro to determine the optimal length of the available data history
***************************************************************************/


%macro TS_History_Check(data=,tsid=tsid,y=qty,timeid=monyear,  
                   interval=month, minhist=1,maxhist=48,
                   shiftfrom=0,shiftto=12,shiftby=1,periodvalid=12,
                   mrep=sashelp.hpfdflt,sellist=tsfsselect,  
                   stat=mape,aggrstat=median);

/*** Part I - Prepare Data for the Analysis ***/
*** Calculate the number of observations per time series; 
proc means data=&data noprint nway;
 class &tsid;
 var &y;
 output out=ts_count(drop = _type_ _freq_) n=_count_obs_;
run;

*** Join the number of observations to the base table;
proc sql noprint;
 create table _Hist_check_tmp_
 as select a.*, b._count_obs_
    from &data as a
	left join ts_count as b
	on a.tsid = b.tsid
    order by a.&tsid., a.&timeid.;
quit;

*** Generate _LEAD_ variable;
data _Hist_check_tmp_;
 set _Hist_check_tmp_;
 by &tsid;
 if first.tsid then _idx_=1;
 else _idx_+1;
 _lead_ = -(_count_obs_-_idx_)-1;
 drop _idx_;
run;

*** Generate Empty Demplate table for appending the MAPE values;
data mape_base;
 set &data(keep=&tsid);
 format mape 16.8 rmse 16.8 shift 8. history 8.;
 delete; 
run; 


/*** Iterate Scenarios ***/

%do shift = &shiftfrom. %to &shiftto. %by &shiftby.;
  %do history = &minhist. %to &maxhist.;
              *** only leave the observations in the table that are needed for the analysis;
			  data _Hist_check_tmp_input_;
			   set _Hist_check_tmp_(where = (_count_obs_ >= &minHist.));
			   _y_valid_ = &y.;
			   if _lead_*(-1) <= &periodvalid then &y.       = .;    
			   if _lead_*(-1) > (&periodvalid + &history) then delete;
			  run;

			/*** Forecast the Szenario ***/
			proc hpfengine   data = _Hist_check_tmp_input_
			                 out=_out_
			                 outfor = _Hist_check_tmp_fc_
				               (drop = lower upper error std)	
						 	 modelrepository = &mrep
			                 globalselection = &sellist
						     lead = &periodvalid back=0
			                 task = select(criterion = &stat 
			                 minobs=(season=1) 
			                 seasontest = none
			                 ) ;
			by &tsid; 
			id &timeid interval = &interval;
			forecast &y;
			run;

            proc delete data=_out_;run;
			
            *** Join Forecast Values with original 
                values for MAPE calculation; 
			proc sql;
			 create table _Hist_check_tmp_fc_xt_
			 as select a.*,b._lead_,b._y_valid_
			    from _Hist_check_tmp_fc_(drop = _name_) as a
			    left join _Hist_check_tmp_input_ as b 
			        on a.&tsid. = b.&tsid.
			       and a.&timeid. = b.&timeid.
                order by &tsid., &timeid.;
			quit;

			/**** Validate the Szenario ****/
			** Calculate the mean;
			data _ape_;
			  set _Hist_check_tmp_fc_xt_;
			  _FC_Period_ = (_lead_*(-1) <= &periodvalid);
			  _APE_ = abs(predict-_y_valid_)/_y_valid_;
			  _MS_  = (predict-_y_valid_)**2;
			run;

			proc means data = _ape_(rename = 
                                     (_ape_ = mape _ms_ = _mse_)) 
                                 noprint nway;
			 class &tsid _fc_period_;
			 var mape _mse_;
			 output out = _mape_(drop=_type_ _freq_ 
                            where=(_fc_period_=1)) mean=;
			run;

			data _mape_;
			 set _mape_;
			 rmse = _mse_ ** 0.5;
			 drop _mse_;
			 shift=&shift;
			 History=&history;
			 drop _fc_period_;
			run;

      *** Append the results of this run;
    proc append base=mape_base  data=_mape_ force nowarn;
	  run;

  %end; ** Hist Loop; 			 
%end; ** SHIFT LOOP;

*** Aggregate data per time history;
proc means data = mape_base noprint nway;
 class history;
 var rmse mape;
 output out = _mape_aggr_(drop=_type_ _freq_) &aggrstat=;
run;

*** Output the results;
proc print data=_mape_aggr_ noobs;
run;

*** Lineplot;
proc sgplot data = _mape_aggr_;
 series x=history y=&stat;
run;

*** Calculate the number of optimal history months;
proc sort data = mape_base;
 by &tsid shift history;
run;

data BestHistory;
 set mape_base(where=(mape ne .));
 by &tsid shift;
 retain BestHistory MinMAPE;
 if first.shift then do; BestHistory = History;
                         MinMAPE = MAPE;
					 end;
 if MAPE < MinMAPE then do;
                           BestHistory = History;
 			               MinMAPE = MAPE;
					 end;
 if last.shift then output;
run;

proc sgplot data=BestHistory;
 vbar besthistory/ barwidth=1;
 xaxis label="Best Length of History";
 yaxis label="Frequency";
run;

%mend;

/**************************************************************************
*** %TS_HISTORY_CHECK_ESM -- see Appendix D – Macro to determine the optimal length of the available data history
***************************************************************************/

%macro TS_History_Check_ESM(data=,tsid=tsid,y=qty,timeid=monyear,interval=month,
                        minhist=1,maxhist=48,shiftfrom=0,shiftto=12,shiftby=1,periodvalid=12,
                        stat=mape,aggrstat=median,seasonality=12,model=seasonal);

/*** Part I - Prepare Data for the Analysis ***/
*** Calculate the number of observations per time series; 
proc means data=&data noprint nway;
 class &tsid;
 var &y;
 output out=ts_count(drop = _type_ _freq_) n=_count_obs_;
run;

*** Join the number of observations to the base table;
proc sql noprint;
 create table _Hist_check_tmp_
 as select a.*, b._count_obs_
    from &data as a
	left join ts_count as b
	on a.tsid = b.tsid
    order by a.&tsid., a.&timeid.;
quit;

*** Generate _LEAD_ variable;
data _Hist_check_tmp_;
 set _Hist_check_tmp_;
 by &tsid;
 if first.tsid then _idx_=1;
 else _idx_+1;
 _lead_ = -(_count_obs_-_idx_)-1;
 drop _idx_;
run;

*** Generate Empty Demplate table for appending the MAPE values;
data mape_base;
 set &data(keep=&tsid);
 format mape 16.8 rmse 16.8 shift 8. history 8.;
 delete; 
run; 


/*** Iterate Scenarios ***/

%do shift = &shiftfrom. %to &shiftto. %by &shiftby.;
  %do history = &minhist. %to &maxhist.;
              *** only leave the observations in the table that are needed for the analysis;
			  data _Hist_check_tmp_input_;
			   set _Hist_check_tmp_(where = (_count_obs_ >= &minHist.));
			   _y_valid_ = &y.;
			   if _lead_*(-1) <= &periodvalid then &y.       = .;    
			   if _lead_*(-1) > (&periodvalid + &history) then delete;
			  run;

			/*** Forecast the Szenario ***/
            proc esm data=_Hist_check_tmp_input_ out=_out_
			              outfor = _Hist_check_tmp_fc_(drop = lower upper error std)	
                          seasonality=&seasonality lead=&periodvalid;
              by &tsid; 
		      id &timeid interval = &interval;
              forecast &y/model=&model;
            run;
			
            proc delete data=_out_;run;
			
            *** Join Forecast Values with original values for MAPE calculation; 
			proc sql;
			 create table _Hist_check_tmp_fc_xt_
			 as select a.*,b._lead_,b._y_valid_
			    from _Hist_check_tmp_fc_(drop = _name_) as a
			    left join _Hist_check_tmp_input_ as b 
			        on a.&tsid. = b.&tsid. 
			       and a.&timeid. = b.&timeid.
                order by &tsid., &timeid.;
			quit;


			/**** Validate the Szenario ****/
			** Calculate the mean;
			data _ape_;
			  set _Hist_check_tmp_fc_xt_;
			  _FC_Period_ = (_lead_*(-1) <= &periodvalid);
			  _APE_ = abs(predict-_y_valid_)/_y_valid_;
			  _MS_  = (predict-_y_valid_)**2;
			run;

			proc means data = _ape_(rename = (_ape_ = mape _ms_ = _mse_)) noprint nway;
			 class &tsid _fc_period_;
			 var mape _mse_;
			 output out = _mape_(drop=_type_ _freq_ where=(_fc_period_=1)) mean=;
			run;

			data _mape_;
			 set _mape_;
			 rmse = _mse_ ** 0.5;
			 drop _mse_;
			 shift=&shift;
			 History=&history;
			 drop _fc_period_;
			run;

      *** Append the results of this run;
      proc append base=mape_base  data=_mape_ force nowarn;
	  run;

  %end; ** Hist Loop; 			 
%end; ** SHIFT LOOP;

*** Aggregate data per time history;
proc means data = mape_base noprint nway;
 class history;
 var rmse mape;
 output out = _mape_aggr_(drop=_type_ _freq_) &aggrstat=;
run;

*** Output the results;
proc print data=_mape_aggr_ noobs;
run;

*** Lineplot;
proc sgplot data = _mape_aggr_;
 series x=history y=&stat;
run;

*** Calculate the number of optimal history months;
proc sort data = mape_base;
 by &tsid shift history;
run;

data BestHistory;
 set mape_base(where=(mape ne .));
 by &tsid shift;
 retain BestHistory MinMAPE;
 if first.shift then do; BestHistory = History;
                         MinMAPE = MAPE;
					 end;
 if MAPE < MinMAPE then do;
                           BestHistory = History;
 			               MinMAPE = MAPE;
					 end;
 if last.shift then output;
run;

proc sgplot data=BestHistory;
 vbar besthistory/ barwidth=1;
 xaxis label="Best Length of History";
 yaxis label="Frequency";
run;

%mend;

