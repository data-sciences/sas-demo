*------------------------------------------------------------*;
* ADSL.sas creates the ADaM ADSL data set
* as permanent SAS datasets to the ADaM libref.
*------------------------------------------------------------*;

%include "..\setup.sas";

**** CREATE EMPTY ADSL DATASET CALLED EMPTY_ADSL;

%let metadatafile=&path/data/adam-metadata/adam_metadata.xlsx;
%make_empty_dataset(metadatafile=&metadatafile, dataset=ADSL) 

** merge supplemental qualifiers into DM;
%mergsupp(sourcelib=sdtm, domains=DM); 

** find the change from baseline so that responders can be flagged ;
** (2-point improvement in pain at 6 months);
%cfb(indata=sdtm.xp, outdata=responders, dayvar=xpdy, avalvar= xpstresn, 
     keepvars=usubjid visitnum chg);
data ADSL;
    merge EMPTY_ADSL
          	DM         (in = inDM) 
          	responders (in = inresp where=(visitnum=2))
          	;
      by usubjid;

        * convert RFSTDTC to a numeric SAS date named TRTSDT;
        %dtc2dt(RFSTDTC, prefix=TRTS );  

        * create BRTHDT, RANDDT, TRTEDT;
        %dtc2dt(BRTHDTC, prefix=BRTH);        
        %dtc2dt(RANDDTC, prefix=RAND);
        %dtc2dt(RFENDTC, prefix=TRTE);

        * created flags for ITT and safety-evaluable;
        ittfl = put(randdt, popfl.);
        saffl = put(trtsdt, popfl.);

        trt01p = ARM;
        trt01a = trt01p;
        trt01pn = input(put(trt01p, $trt01pn.), best.);
        trt01an = trt01pn;                 
        agegr1n = input(put(age, agegr1n.), best.);
        agegr1  = put(agegr1n, agegr1_.);
        RESPFL = put((.z <= chg <= -2), _0n1y.);         
run;

**** SORT ADSL ACCORDING TO METADATA AND SAVE PERMANENT DATASET;  
%make_sort_order(metadatafile=&metadatafile, dataset=ADSL) 

proc sort
  data=adsl
  (keep = &ADSLKEEPSTRING)
  out=adam.adsl;
    by &ADSLSORTSTRING;
run;
