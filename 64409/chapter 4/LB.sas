*---------------------------------------------------------------*;
* LB.sas creates the SDTM LB dataset and saves it
* as a permanent SAS datasets to the target libref.
*---------------------------------------------------------------*;
 
**** CREATE EMPTY DM DATASET CALLED EMPTY_LB;
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

**** DERIVE THE MAJORITY OF SDTM LB VARIABLES;
options missing = ' ';
data lb;
  set LB
      source.labs; 

    studyid = 'XYZ123';
    domain = 'LB';
    usubjid = left(uniqueid);
    lbcat = put(labcat,$lbcat_labs_labcat.);
    lbtest = put(labtest,$lbtest_labs_labtest.);
    lbtestcd = put(labtest,$lbtestcd_labs_labtest.);
    lborres = left(put(nresult,best.));
    lborresu = left(colunits);
    lbornrlo = left(put(lownorm,best.));
    lbornrhi = left(put(highnorm,best.));

    **** create standardized results;
    lbstresc = lborres;
    lbstresn = nresult;
    lbstresu = lborresu;
    lbstnrlo = lownorm;
    lbstnrhi = highnorm;

    if lbstnrlo ne . and lbstresn ne . and 
       round(lbstresn,.0000001) < round(lbstnrlo,.0000001) then
      lbnrind = 'LOW';
    else if lbstnrhi ne . and lbstresn ne . and 
       round(lbstresn,.0000001) > round(lbstnrhi,.0000001) then
      lbnrind = 'HIGH';
    else if lbstnrhi ne . and lbstresn ne . then
      lbnrind = 'NORMAL';

    visitnum = month;
    visit = put(month,visit_labs_month.);
    if visit = 'Baseline' then
      lbblfl = 'Y';
	else
	  lbblfl = ' ';

    lbdtc = put(labdate,yymmdd10.); 
run;

 
proc sort
  data=lb;
    by usubjid;
run;

**** CREATE SDTM STUDYDAY VARIABLES;
data lb;
  merge lb(in=inlb) target.dm(keep=usubjid rfstdtc);
    by usubjid;

    if inlb;

    %make_sdtm_dy(refdate=rfstdtc,date=lbdtc) 
run;


**** CREATE SEQ VARIABLE;
proc sort
  data=lb;
    by studyid usubjid lbtestcd visitnum;
run;

data lb;
  retain STUDYID DOMAIN USUBJID LBSEQ LBTESTCD LBTEST LBCAT LBORRES LBORRESU LBORNRLO LBORNRHI 
         LBSTRESC LBSTRESN LBSTRESU LBSTNRLO LBSTNRHI LBNRIND LBBLFL VISITNUM VISIT LBDTC LBDY;
  set lb(drop=lbseq);
    by studyid usubjid lbtestcd visitnum; 

    if not (first.visitnum and last.visitnum) then
      put "WARN" "ING: key variables do not define an unique record. " usubjid=;

    retain lbseq;
    if first.usubjid then
      lbseq = 1;
    else
      lbseq = lbseq + 1;
		
    label lbseq = "Sequence Number";
run;


**** SORT LB ACCORDING TO METADATA AND SAVE PERMANENT DATASET;
%make_sort_order(dataset=LB)

proc sort
  data=lb(keep = STUDYID DOMAIN USUBJID LBSEQ LBTESTCD LBTEST LBCAT LBORRES LBORRESU LBORNRLO LBORNRHI 
         LBSTRESC LBSTRESN LBSTRESU LBSTNRLO LBSTNRHI LBNRIND LBBLFL VISITNUM VISIT LBDTC LBDY)
  out=target.lb;
    by &LBSORTSTRING;
run;
