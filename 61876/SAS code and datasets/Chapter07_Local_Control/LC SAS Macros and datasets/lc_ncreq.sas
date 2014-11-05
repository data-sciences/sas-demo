***********************************************************************************
************** MACROs for Local Control: Phase One (EXPLORE) **********************
***********************************************************************************
Macro "LC_NCreq" performs all Phase One LC calculations for only a single requested
  (maximum) number of clusters, NCreq.  Instead of computing a Dendrogram Tree that
  can be cut any number of times, this macro invokes proc FASTCLUS to perform
  K-means clustering.  This approach is ideal for detecting EXACT matches on all
  X-variables iff the value of NCreq has been set to be large enough.
***********************************************************************************;
***	Copyright (c) 2009 Foundation for the National Institutes of Health (FNIH).
***
***	Licensed under the Apache License, Version 2.0 (the "License".)  You may not
***	use this file except in compliance with the License. You may obtain a copy
***	of the License at http://omop.fnih.org/publiclicense.
***
***	Unless required by applicable law or agreed to in writing, software
***	distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
***	WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. Any
***	redistributions of this work or any derivative work or modification based on
***	this work should be accompanied by the following source attribution: "This
***	work is based on work by the Observational Medical Outcomes Partnership (OMOP)
***	and used under license from the FNIH at http://omop.fnih.org/publiclicense.
***
***	Any scientific publication that is based upon this work should include a
***	reference to http://omop.fnih.org.
***
***********************************************************************************;
***********************************************************************************;

%MACRO lc_ncreq(LC_Path =, LC_YTXdata =, LC_LTDoutput =, NCreq =, LC_T01var =, LC_Yvar =,
                LC_Xvars =, LC_LTDtable =, LC_Unbias =);

proc fastclus noprint data=&LC_Path..&LC_YTXdata out=&LC_Path..&LC_LTDoutput maxc=&NCreq;
var &LC_Xvars; 
run;

* Output dataset same as original but augmented with 2 new variables: CLUSTER and DISTANCE;
* If the value (NCreq) of the "maxc" parameter was large enough, all identified clusters
* will contain either only exact X-matches or only a single patient;
* NCreq macro value will be reduced (if necessaary) to equal the number of clusters identified;

proc means noprint data=&LC_Path..&LC_LTDoutput;
output out=nclactual max=nclactual;
var cluster;
run;

data nclactual;
  set nclactual;
  %LET NCreq = nclactual;
run;

***** Prepare to use clusters from output;

proc sort data=&LC_Path..&LC_LTDoutput;
by cluster &LC_T01var;
run;

* LC_LTDoutput will ultimately be a primary output dataset from LC Phase One;
* Compute within-cluster statistics by treatment;
* Output the cell means by cluster and treatment;
 
proc means noprint nway 
data=&LC_Path..&LC_LTDoutput;
output out=nctrtavg n=n mean=mean var=var;
class cluster &LC_T01var;
var &LC_Yvar;
run;

***** Keep only observations with cluster and &LC_T01var values not missing;
  
data nctrtavg;
set nctrtavg;
where (cluster ne . and  &LC_T01var ne .);
run;

***** Prepare to form wide dataset with summary stats by treatment;

data nctrtavg2;
set nctrtavg;
  if &LC_T01var = 0 then n0 = n; 
  if &LC_T01var = 0 then ybar0 = mean;
  if &LC_T01var = 0 then var0 = var;
  if &LC_T01var = 0 then vbar0 = var/n;
  if &LC_T01var = 1 then n1 = n; 
  if &LC_T01var = 1 then ybar1 = mean;
  if &LC_T01var = 1 then var1 = var;
  if &LC_T01var = 1 then vbar1 = var/n;
run;

***** Select data for treatment zero;

data nctrtavg0;
set nctrtavg2;
keep cluster n0 ybar0 var0 vbar0;
if &LC_T01var = 0;
run;

proc sort data=nctrtavg0;
by cluster;
run;

***** Select data for treatment one;

data nctrtavg1;
set nctrtavg2;
keep cluster n1 ybar1 var1 vbar1;
if &LC_T01var = 1;
run;

proc sort data=nctrtavg1;
by cluster;
run;

***** Merge data summary statistics by &LC_T01var within each cluster;

data &LC_Path..&LC_LTDtable;
merge nctrtavg1 nctrtavg0;
by cluster;
run;

***** Calculate Sums of Squares (sos_) and Informative on Spread (is_) flags;

data &LC_Path..&LC_LTDtable; 
set &LC_Path..&LC_LTDtable;
if n0 gt 1 then sos0=(n0-1)*var0;
else sos0 = 0;
if n0 gt 1 then is0 = 1;
else is0 = 0;
if n1 gt 1 then sos1=(n1-1)*var1;
else sos1 = 0;
if n1 gt 1 then is1 = 1;
else is1 = 0;
if n0 ge 1 and n1 ge 1 then iclust = 1;
else iclust = 0;
run;

***** form data sets with sample size and sos sums;

proc means noprint data=&LC_Path..&LC_LTDtable;
output out=sn0 sum=sn0;
var n0;
run;

proc means noprint data=&LC_Path..&LC_LTDtable;
output out=sn1 sum=sn1;
var n1;
run;

proc means noprint data=&LC_Path..&LC_LTDtable;
output out=sis0 sum=sis0;
var is0;
run;

proc means noprint data=&LC_Path..&LC_LTDtable;
output out=sis1 sum=sis1;
var is1;
run;

proc means noprint data=&LC_Path..&LC_LTDtable;
output out=ssos0 sum=ssos0;
var sos0;
run;

proc means noprint data=&LC_Path..&LC_LTDtable;
output out=ssos1 sum=ssos1;
var sos1;
run;

proc means noprint data=&LC_Path..&LC_LTDtable;
output out=siclust sum=siclust;
var iclust;
run;

* Form Local Treatment Difference (LTD) and Local Average Treatment Effect (LATE) statistics;

data &LC_Path..&LC_LTDtable; 
set &LC_Path..&LC_LTDtable;
if iclust = 1 then ltd = ybar1 - ybar0;
else ltd = .;
if iclust = 1 then ltdsehet = sqrt( vbar1 + vbar0 );
else ltdsehet = .;
if n1 = . then n1 = 0;
if n0 = . then n0 = 0;
if n1 gt 0 and n0 gt 0 then ltdvrhom = (n1 + n0)**3/(n1 * n0);
else ltdvrhom = .;
if n1 gt 0 and n0 gt 0 then ltdvrden = (n1 + n0);
else ltdvrden = .;
if n1 = 0 then late = ybar0;
if n0 = 0 then late = ybar1;
if n1 gt 0 and n0 gt 0 then late = (n1*ybar1 + n0*ybar0)/(n1 + n0);
run;

proc means noprint data=&LC_Path..&LC_LTDtable;
output out=svrhom sum=svrhom;
var ltdvrhom;
run;

proc means noprint data=&LC_Path..&LC_LTDtable;
output out=svrden sum=svrden;
var ltdvrden;
run;

proc sort data=&LC_Path..&LC_LTDtable;
by cluster;
run;

***** LC_LTDtable is now a primary output dataset from LC Phase One;

proc sort data=&LC_Path..&LC_LTDoutput;
by cluster;
run;

***** Merge LC_LTDtable cluster info with LC_LTDoutput patient level data;

data &LC_Path..&LC_LTDoutput;
merge &LC_Path..&LC_LTDoutput &LC_Path..&LC_LTDtable;
by cluster;
run;

***** form overall average ltd and late, plus total patients in ltd informative clusters;

proc means noprint data=&LC_Path..&LC_LTDoutput;
output out=ltdavg mean=ltdavg;
var ltd;
run;

proc means noprint data=&LC_Path..&LC_LTDoutput;
output out=sicpats sum=sicpats;
var iclust;
run;

proc means noprint data=&LC_Path..&LC_LTDoutput;
output out=late mean=late;
var late;
run;

***** form dataset with summary statistics for each cluster;

data lcsummary;
merge ltdavg svrhom svrden siclust sicpats late sn0 sis0 ssos0 sn1 sis1 ssos1;
sigma = sqrt((ssos0 + ssos1)/(sn0 + sn1 - sis0 - sis1));
ltdsehom = sigma * sqrt( svrhom ) / svrden;
sigma0 = sqrt( ssos0 / (sn0 - sis0) );
sigma1 = sqrt( ssos1 / (sn1 - sis1) );
%let NCinform = siclust;
run;

%if %sysfunc(exist(&LC_Path..&LC_UnBias)) %then %do;
  data &LC_Path..&LC_UnBias;
    set &LC_Path..&LC_UnBias lcsummary;
  run;
%end;
%else %do;
  data &LC_Path..&LC_UnBias;
    set lcsummary;
  run;
%end;

%MEND LC_NCreq;
