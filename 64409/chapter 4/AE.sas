*---------------------------------------------------------------*;
* AE.sas creates the SDTM AE dataset and saves it
* as permanent SAS datasets to the target libref.
*---------------------------------------------------------------*;
 
**** CREATE EMPTY AE DATASET;

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

**** DERIVE THE MAJORITY OF SDTM AE VARIABLES;
options missing = ' ';
data ae;
  set AE
  source.adverse(rename=(aerel=_aerel aesev=_aesev));

    studyid = 'XYZ123';
    domain = 'AE';
    usubjid = left(uniqueid);
    aeterm = left(aetext);
    aedecod = left(prefterm);
    aebodsys = left(bodysys);
    aesev = put(_aesev,aesev_adverse_aesev.);
    aeacn = put(aeaction,acn_adverse_aeaction.);
    aerel = put(_aerel,aerel_adverse_aerel.);
    aeser = put(serious,$ny_adverse_serious.);
    aestdtc = put(aestart,yymmdd10.);
    aeendtc = put(aeend,yymmdd10.);
run;

 
proc sort
  data=ae;
    by usubjid;
run;

**** CREATE SDTM STUDYDAY VARIABLES;
data ae;
  merge ae(in=inae) target.dm(keep=usubjid rfstdtc);
    by usubjid;

    if inae;

    %make_sdtm_dy(refdate=rfstdtc,date=aestdtc); 
    %make_sdtm_dy(refdate=rfstdtc,date=aeendtc); 
run;


**** CREATE SEQ VARIABLE;
proc sort
  data=ae;
    by studyid usubjid aedecod aestdtc aeendtc;
run;

data ae;
  retain STUDYID DOMAIN USUBJID AESEQ AETERM AEDECOD AEBODSYS AESEV AESER AEACN AEREL AESTDTC
         AEENDTC AESTDY AEENDY;
  set ae(drop=aeseq);
    by studyid usubjid aedecod aestdtc aeendtc;

    if not (first.aeendtc and last.aeendtc) then
      put "WARN" "ING: key variables do not define an unique record. " usubjid=;

    retain aeseq;
    if first.usubjid then
      aeseq = 1;
    else
      aeseq = aeseq + 1;
		
    label aeseq = "Sequence Number";
run;


**** SORT AE ACCORDING TO METADATA AND SAVE PERMANENT DATASET;
%make_sort_order(dataset=AE)

proc sort
  data=ae(keep = STUDYID DOMAIN USUBJID AESEQ AETERM AEDECOD AEBODSYS AESEV AESER AEACN AEREL AESTDTC
                 AEENDTC AESTDY AEENDY)
  out=target.ae;
    by &AESORTSTRING;
run;
