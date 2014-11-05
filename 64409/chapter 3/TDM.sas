*---------------------------------------------------------------*;
* TDM.sas creates the SDTM TA, TE, TI, TS, and TV datasets and 
* saves them as a permanent SAS datasets to the target libref.
*---------------------------------------------------------------*;

%common
 
**** CREATE EMPTY TA DATASET CALLED EMPTY_TA;
%make_empty_dataset(metadatafile=C:\path\SDTM_METADATA.xlsx,dataset=TA)

proc import 
  datafile="C:\path\trialdesign.xlsx"
  out=ta 
  dbms=excelcs
  replace;
  sheet='TA';
run;

**** SET EMPTY DOMAIN WITH ACTUAL DATA;
data ta;
  set EMPTY_TA
      ta;
run;

**** SORT DOMAIN ACCORDING TO METADATA AND SAVE PERMANENT DATASET;
%make_sort_order(metadatafile=C:\path\SDTM_METADATA.xlsx,dataset=TA)

proc sort
  data=ta(keep = &TAKEEPSTRING)
  out=target.ta;
    by &TASORTSTRING;
run;



**** CREATE EMPTY TE DATASET CALLED EMPTY_TE;
%make_empty_dataset(metadatafile=C:\path\SDTM_METADATA.xlsx,dataset=TE)

proc import 
  datafile="C:\path\trialdesign.xlsx"
  out=te
  dbms=excelcs
  replace;
  sheet='TE';
run;

**** SET EMPTY DOMAIN WITH ACTUAL DATA;
data te;
  set EMPTY_TE
      te;
run;

**** SORT DOMAIN ACCORDING TO METADATA AND SAVE PERMANENT DATASET;
%make_sort_order(metadatafile=C:\path\SDTM_METADATA.xlsx,dataset=TE)

proc sort
  data=te(keep = &TEKEEPSTRING)
  out=target.te;
    by &TESORTSTRING;
run;



**** CREATE EMPTY TI DATASET CALLED EMPTY_TI;
%make_empty_dataset(metadatafile=C:\path\SDTM_METADATA.xlsx,dataset=TI)

proc import 
  datafile="C:\path\trialdesign.xlsx"
  out=ti 
  dbms=excelcs
  replace;
  sheet='TI';
run;

**** SET EMPTY DOMAIN WITH ACTUAL DATA;
data ti;
  set EMPTY_TI
      ti;
run;

**** SORT DOMAIN ACCORDING TO METADATA AND SAVE PERMANENT DATASET;
%make_sort_order(metadatafile=C:\path\SDTM_METADATA.xlsx,dataset=TI)

proc sort
  data=ti(keep = &TIKEEPSTRING)
  out=target.ti;
    by &TISORTSTRING;
run;



**** CREATE EMPTY TS DATASET CALLED EMPTY_TS;
%make_empty_dataset(metadatafile=C:\path\SDTM_METADATA.xlsx,dataset=TS)

proc import 
  datafile="C:\path\trialdesign.xlsx"
  out=ts 
  dbms=excelcs
  replace;
  sheet='TS';
run;

**** SET EMPTY DOMAIN WITH ACTUAL DATA;
data ts;
  set EMPTY_TS
      ts;
run;

**** SORT DOMAIN ACCORDING TO METADATA AND SAVE PERMANENT DATASET;
%make_sort_order(metadatafile=C:\path\SDTM_METADATA.xlsx,dataset=TS)

proc sort
  data=ts(keep = &TSKEEPSTRING)
  out=target.ts;
    by &TSSORTSTRING;
run;



**** CREATE EMPTY TV DATASET CALLED EMPTY_TV;
%make_empty_dataset(metadatafile=C:\path\SDTM_METADATA.xlsx,dataset=TV)

proc import 
  datafile="C:\path\trialdesign.xlsx"
  out=tv 
  dbms=excelcs
  replace;
  sheet='TV';
run;

**** SET EMPTY DOMAIN WITH ACTUAL DATA;
data tv;
  set EMPTY_TV
      tv;
run;

**** SORT DOMAIN ACCORDING TO METADATA AND SAVE PERMANENT DATASET;
%make_sort_order(metadatafile=C:\path\SDTM_METADATA.xlsx,dataset=TV)

proc sort
  data=tv(keep = &TVKEEPSTRING)
  out=target.tv;
    by &TVSORTSTRING;
run;
