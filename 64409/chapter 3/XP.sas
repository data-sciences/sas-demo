*---------------------------------------------------------------*;
* XP.sas creates the SDTM XP dataset and saves it
* as a permanent SAS datasets to the target libref.
*---------------------------------------------------------------*; 
**** CREATE EMPTY DM DATASET CALLED EMPTY_XP;
%make_empty_dataset(metadatafile=C:\path\SDTM_METADATA.xlsx,dataset=XP)
 
proc format;
  value pain
    0='None'
    1='Mild'
    2='Moderate'
    3='Severe';
run;

**** DERIVE THE MAJORITY OF SDTM XP VARIABLES;
options missing = ' ';
data xp;
  set EMPTY_XP
      source.pain; 

    studyid = 'XYZ123';
    domain = 'XP';
    usubjid = left(uniqueid);

    xptest = 'Pain Score';
    xptestcd = 'XPPAIN';

    **** transpose pain data;
    array dates {3} randomizedt month3dt month6dt;
    array scores {3} painbase pain3mo pain6mo;

    do i = 1 to 3;
      visitnum = i - 1;
      visit = put(visitnum,visit_labs_month.);
      if scores{i} ne . then
        do;
          xporres = left(put(scores{i},pain.));
          xpstresc = xporres;
          xpstresn = scores{i};
          xpdtc = put(dates{i},yymmdd10.);
          output;
        end;
    end;
run;

 
proc sort
  data=xp;
    by usubjid;
run;

**** CREATE SDTM STUDYDAY VARIABLES;
data xp;
  merge xp(in=inxp) target.dm(keep=usubjid rfstdtc);
    by usubjid;

    if inxp;

    %make_sdtm_dy(date=xpdtc) 
run;


**** CREATE SEQ VARIABLE;
proc sort
  data=xp;
    by studyid usubjid xptestcd visitnum;
run;


data xp;
  retain &XPKEEPSTRING;
  set xp(drop=xpseq);
    by studyid usubjid xptestcd visitnum; 

    if not (first.visitnum and last.visitnum) then
      put "WARN" "ING: key variables do not define an unique record. " usubjid=;

    retain xpseq;
    if first.usubjid then
      xpseq = 1;
    else
      xpseq = xpseq + 1;
		
    label xpseq = "Sequence Number";
run;


**** SORT XP ACCORDING TO METADATA AND SAVE PERMANENT DATASET;
%make_sort_order(metadatafile=C:\path\SDTM_METADATA.xlsx,dataset=XP)


proc sort
  data=xp(keep = &XPKEEPSTRING)
  out=target.xp;
    by &XPSORTSTRING;
run;
