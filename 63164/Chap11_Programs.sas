/*****************************************************************************
***  Programs for the Book "Data Quality for Analytics Using SAS"
***  Download Version 1.0 - May, 22nd 2012
***  Dr. Gerhard Svolba
***
***  Report any problems and questions for the programs to the author:
***  mail: sastools.by.gerhard@gmx.net
***
******************************************************************************/



/**********************************************
*** Section 11.3
***********************************************/

data air_missing;
 set sashelp.air;
 if uniform(12345) < 0.1 then delete;
run;

proc esm data = air_missing;
 id date  interval = month;
 forecast air;
run;


proc timeseries data = air_missing out = TIMEID_INSERTED;
id date interval =MONTH setmiss=0;
var air;
by ;
run;


%check_timeid(data = air_missing, mode = CHECK,  timeid = date, value = air);
%check_timeid(data = air_missing, mode = INSERT, timeid = date, value = air);


data prdsale_missing;
 set sashelp.prdsale;
 format month yymmp7.;
 if uniform(4567) < 0.2 then delete;
run;


%check_timeid(data = prdsale_missing, out = prdsale_insert, mode = INSERT, timeid = month, value = actual, 
              by = country region division prodtype product);







			  /**********************************************
			  *** Section 11.4
			  ***********************************************/

data air_missing;
 set sashelp.air;
 if uniform(1223) < 0.15 then air_mv = .;
 else air_mv = air;
run;

/*proc print data=air_missing(obs=20);run;*/

proc timeseries data = air_missing 
                out = air_setmissing_zero;
     id date interval =month setmiss=0;
     var air_MV;
   run;

proc timeseries data = air_missing 
                  out  = air_setmissing_previous;
     id date interval =month setmiss=PREVIOUS;
     var air_MV;
  run;

proc timeseries data = air_missing 
                out = air_setmissing_mean;
     id date interval =month setmiss=MEAN;
     var air_MV;
   run;

data air_missing_timeseries;
 merge air_missing
       air_setmissing_zero     (rename=(air_mv=air_mv_zero))
       air_setmissing_previous (rename=(air_mv=air_mv_previous))
       air_setmissing_mean     (rename=(air_mv=air_mv_mean));
  by date;
run;




data sales_original;
set sashelp.air;
if date lt "01JUL49"d then air=0;
if date ge "01JUL51"d then air=0;
if _N_ > 36 then delete;
rename air = sales;
run;
proc timeseries data=sales_original out=sales_corrected;
 id date interval=month zeromiss=both;
 var sales;
run;



/**********************************************
*** 11.5
***********************************************/


proc expand data = air_missing out = air_expand;
 convert air_mv=air_expand;
 id date;
run;


data air_expand;
 format date monyy5. air air_mv 8. air_expand best12.;
 set air_expand;
run;
