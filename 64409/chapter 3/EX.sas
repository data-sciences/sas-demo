*---------------------------------------------------------------*;
* EX.sas creates the SDTM EX dataset and saves it
* as a permanent SAS datasets to the target libref.
*---------------------------------------------------------------*;
 
%common 

**** CREATE EMPTY EX DATASET CALLED EMPTY_EX;
%make_empty_dataset(metadatafile=C:\path\SDTM_METADATA.xlsx,dataset=EX)
 

**** DERIVE THE MAJORITY OF SDTM EX VARIABLES;
options missing = ' ';
data ex;
  set EMPTY_EX
      source.dosing;

    studyid = 'XYZ123';
    domain = 'EX';
    usubjid = left(uniqueid);
    exdose = dailydose;
    exdostot = dailydose;
    exdosu = 'mg';
    exdosfrm = 'TABLET, COATED';
    %make_dtc_date(dtcdate=exstdtc, year=startyy, month=startmm, day=startdd)
    %make_dtc_date(dtcdate=exendtc, year=endyy, month=endmm, day=enddd)
run;
 
proc sort
  data=ex;
    by usubjid;
run;

**** CREATE SDTM STUDYDAY VARIABLES AND INSERT EXTRT;
data ex;
  merge ex(in=inex) target.dm(keep=usubjid rfstdtc arm);
    by usubjid;

    if inex;

    %make_sdtm_dy(date=exstdtc); 
    %make_sdtm_dy(date=exendtc); 

    **** in this simplistic case all subjects received the treatment they were randomized to;
    extrt = arm;
run;


**** CREATE SEQ VARIABLE;
proc sort
  data=ex;
    by studyid usubjid extrt exstdtc;
run;

data ex;
  retain &EXKEEPSTRING;
  set ex(drop=exseq);
    by studyid usubjid extrt exstdtc;

    if not (first.exstdtc and last.exstdtc) then
      put "WARN" "ING: key variables do not define an unique record. " usubjid=;

    retain exseq;
    if first.usubjid then
      exseq = 1;
    else
      exseq = exseq + 1;
		
    label exseq = "Sequence Number";
run;


**** SORT EX ACCORDING TO METADATA AND SAVE PERMANENT DATASET;
%make_sort_order(metadatafile=C:\path\SDTM_METADATA.xlsx,dataset=EX)

proc sort
  data=ex(keep = &EXKEEPSTRING)
  out=target.ex;
    by &EXSORTSTRING;
run;
