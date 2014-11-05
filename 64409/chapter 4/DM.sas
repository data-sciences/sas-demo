*---------------------------------------------------------------*;
* DM.sas creates the SDTM DM and SUPPDM datasets and saves them
* as permanent SAS datasets to the target libref.
*---------------------------------------------------------------*;

**** CREATE EMPTY DM AND SUPPDM DATASETS;
* initialize the toolkit framework;
%cst_setStandardProperties(
  _cstStandard=CST-FRAMEWORK,
  _cstSubType=initialize);

* define _ctsGroot macro variable;
%cstutil_setcstgroot;

%cst_createTablesForDataStandard(
   _cstStandard=XYZ std CDISC-SDTM,
   _cstStandardVersion=3.1.2,
   _cstOutputLibrary=work
   );


**** GET FIRST AND LAST DOSE DATE FOR RFSTDTC AND RFENDTC;
proc sort
  data=source.dosing(keep=subject startdt enddt)
  out=dosing;
    by subject startdt;
run;

**** FIRSTDOSE=FIRST DOSING AND LASTDOSE=LAST DOSING;
data dosing;
  set dosing;
    by subject;

    retain firstdose lastdose;

    if first.subject then
      do;
        firstdose = .;
        lastdose = .;
      end;

    firstdose = min(firstdose,startdt,enddt);
    lastdose = max(lastdose,startdt,enddt);

    if last.subject;
run; 

**** GET DEMOGRAPHICS DATA;
proc sort
  data=source.demographic
  out=demographic;
    by subject;
run;

**** MERGE DEMOGRAPHICS AND FIRST DOSE DATE;
data demog_dose;
  merge demographic
        dosing;
    by subject;
run;

**** DERIVE THE MAJORITY OF SDTM DM VARIABLES;
options missing = ' ';
data dm;
  set dm
    demog_dose(rename=(race=_race));

    studyid = 'XYZ123';
    domain = 'DM';
    usubjid = left(uniqueid);
    subjid = put(subject,3.); 
    rfstdtc = put(firstdose,yymmdd10.);  
    rfendtc = put(lastdose,yymmdd10.); 
    siteid = substr(subjid,1,1) || "00";
    brthdtc = put(dob,yymmdd10.);
    age = floor ((intck('month',dob,firstdose) - 
          (day(firstdose) < day(dob))) / 12);
    ageu = 'YEARS';
    sex = put(gender,sex_demographic_gender.);
    race = put(_race,race_demographic_race.);
    armcd = put(trt,armcd_demographic_trt.);
    arm = put(trt,arm_demographic_trt.);
    country = "USA"; 
run; 


**** DEFINE SUPPDM FOR OTHER RACE page 59 IG; 
data suppdm;
  set suppdm
      dm; 

    keep studyid rdomain usubjid idvar idvarval qnam qlabel qval qorig qeval;

    **** OUTPUT OTHER RACE AS A SUPPDM VALUE;
    if orace ne '' then
      do;
        rdomain = 'DM';
        qnam = 'RACEOTH';
        qlabel = 'Race, Other';
        qval = left(orace);
        qorig = 'CRF';
        output;
      end;

    **** OUTPUT RANDOMIZATION DATE AS SUPPDM VALUE;
    if randdt ne . then
      do;
        rdomain = 'DM';
        qnam = 'RANDDTC';
        qlabel = 'Randomization Date';
        qval = left(put(randdt,yymmdd10.));
        qorig = 'CRF';
        output;
      end;
run;


**** SORT DM ACCORDING TO METADATA AND SAVE PERMANENT DATASET;
%make_sort_order(dataset=DM)

proc sort
  data=dm(keep = studyid domain usubjid subjid rfstdtc rfendtc siteid brthdtc age ageu sex race armcd arm country)
  out=target.dm;
    by &DMSORTSTRING;
run;


**** SORT SUPPDM ACCORDING TO METADATA AND SAVE PERMANENT DATASET;
%make_sort_order(dataset=SUPPDM)

proc sort
  data=suppdm
  out=target.suppdm;
    by &SUPPDMSORTSTRING;
run;
