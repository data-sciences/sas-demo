************************************************************************;
** Variables in the pci15k.sas7bdat dataset.                          **;
** Y1: mort6mo = Binary 6-month mortality indicator.                  **;
** Y2: cardcost = Cumulative 6-month cardiac related charges.         **;
**  T: trtm = Binary indicator (1 => treated, 0 => control).          **;
** X1: stent = Binary (1 => coronary stent deployment, 0 => no).      **;
** X2: height = Patient height rounded to the nearest centimeter.     **;
** X3: female = Binary sex indicator (1 => yes, 0 => male.)           **;
** X4: diabetic = Binary indicator (1 => diabetes mellitus, 0 => no.) **;
** X5: acutemi = Binary indicator (1 => acute myocardial infarction   **;
**               within the previous 7 days, 0 => no.)                **;
** X6: ejfract = Left ejection fraction % rounded to integer.         **;
** X7: ves1proc = Number of vessels involved in initial PCI.          **;
************************************************************************;

libname  data "/home/psbb";
filename sumstats "/home/psbb/PCIstats.pdf";
filename iceplane "/home/psbb/PCIicepl.pdf";
filename icsthist "/home/psbb/PCIchist.pdf";

** Create survival effectiveness measure. **;
** Effectiveness measures have a larger-is-better interpretation. ******;
data ce_data;
  set data.pci15k;
  surv6mo = 1.0 - mort6mo;
run;

/************************************************************************
** Compute propensity score strata                                     **
************************************************************************/

option spool;

proc genmod data = ce_data;
  class stent female diabetic acutemi;
  model trtm = stent height female diabetic acutemi ejfract ves1proc 
               / dist = bin link = logit type3 obstats;
  output out = gmpred pred = pstrtm0;
run;

data gmpred;
  set gmpred;
  pstrtm1 = 1.0 - pstrtm0;
  keep pstrtm1 pstrtm0 trtm cardcost surv6mo stent height female
       diabetic acutemi ejfract ves1proc;
run;

*** Form 5 propensity score bins. **************************************;
proc rank data = gmpred groups = 5 out = rank01;
  ranks subgrp;
  var pstrtm1;
run;

data rank01;
  set rank01;
  bin_ps = subgrp + 1;
run;

proc sort data = rank01;
  by trtm; 
run;

ods listing close;
ods pdf file=sumstats notoc;

proc univariate data = rank01;
  by trtm;
  var pstrtm1;
  title "Distribution of Propensity Scores";
run;

proc freq data = rank01;
  tables bin_ps*trtm;
  title 'Treated Patients: Counts by Bin'; 
run;

proc tabulate data = rank01;
  class trtm bin_ps;
  var surv6mo cardcost;
  tables bin_ps*trtm,
    (cardcost='Total Cost' surv6mo='Survive >= 6 Months')*
    (n*format=5. mean*format=12.4 std*format=12.4);
run;

ods pdf close;
ods listing;

/************************************************************************
Macro PSBB implements Propensity Score Bin Bootstraping analysis               

Inputs:

REP    = Number of bootstrap replications
AVARC  = Variable name for Total Cost 
AVARE  = Variable name for Effectiveness
INDAT  = Data set to be analyzed
BINVAR = Variable name for propensity score bin number
TRTVAR = Variable name of (binary) treatment indicator

Outputs:

ICEPLANE = Permanent PDF file showing the PSBB distribution scatter 
BSSUMM = Temporary/Work dataset of Effectiveness and Cost differences
************************************************************************/

%MACRO PSBB( rep=, avarc=, avare=, binvar=, trtvar=, indat=);

data temp;
  set &indat;
  keep &trtvar &binvar &avarc &avare;
run;

proc freq data=temp noprint;
  tables &trtvar / out = freqnums;
  where not(&trtvar=.);
run;

data _null_;
  set freqnums;
  call symput('val'||compress(put(_n_, 4.)), trim(left(&trtvar)));
  call symput('ssize'||compress(put(_n_, 4.)), trim(left(count)));
run;

*** Create empty temporary dataset to augment later. *******************;		
data bssumm;	
 if _n_ eq 1 then stop;
run;

proc sort data=temp;
  by &trtvar &binvar;
run;

%let ss1=%qsysfunc(round((&ssize1)/5,1));
%let ss2=%qsysfunc(round((&ssize2)/5,1));

%do i=1 %to &rep;

  proc surveyselect data=temp method=urs outhits rep=1
         n=(&ss1. &ss1. &ss1. &ss1. &ss1. &ss2. &ss2. &ss2. &ss2. &ss2.)
         noprint out=tbout;  
    strata &trtvar &binvar;
  run;

  *** Compute mean outcomes for the bootstrap sample. ******************;
  proc means data=tbout noprint;
    class &trtvar &binvar;
    var &avarc &avare;
    output out = mn mean = bbavgc bbavge;
  run;
  
  *** Create datasets with 5 bins for each treatment. ******************;
  data trt0 trt1;	
    set mn;
    if (&binvar ne . and &trtvar=&val1) then output trt0;
    else if (&binvar ne . and &trtvar=&val2) then output trt1;
	keep &binvar bbavgc bbavge;
  run;
  
  data trt0;	
    set trt0;
    cav0 = bbavgc;
	eav0 = bbavge;
	keep &binvar cav0 eav0;
  run;
  
  data trt1;	
    set trt1;
    cav1 = bbavgc;
	eav1 = bbavge;
	keep &binvar cav1 eav1;
  run;

  *** Compute within bin differences in avg trtm outcomes. *************;
  data tbout;
    merge trt0 trt1;
    by &binvar;
	cdifbin = cav1 - cav0;
	edifbin = eav1 - eav0;
	keep cdifbin edifbin;
  run;
  
  *** Only then, average outcome differences across bins. **************;
  proc means data=tbout noprint;
    var cdifbin edifbin;
    output out = mn mean = cdiff ediff;
  run;

  %** Update dataset with statistics from this sample **;
  data bssumm;
    set bssumm mn;
  run;

  %**Clean work library**;
  proc datasets library=work memtype=data nolist;
	delete tbout trt0 trt1 mn;
  run;
  quit;

%end;	%* End of %do loop *;
  
%** Compute differences and test statistics **;
data bssumm;
  set bssumm;
  if cdiff ne . and ediff ne . then do;
    if cdiff ge 0 and ediff ge 0 then ce_quad = '++';
    if cdiff ge 0 and ediff lt 0 then ce_quad = '+-';
    if cdiff lt 0 and ediff ge 0 then ce_quad = '-+';
    if cdiff lt 0 and ediff lt 0 then ce_quad = '--';
  end;
  label ediff="Average for &avare Diff: TrLev2-TrLev1"
	  cdiff="Average for &avarc Diff: TrLev2-TrLev1";
run;

*** Calculate Quadrant percentages and macro variables for graph. ******;

ods output OneWayFreqs=quadrt(keep=ce_quad percent);

proc freq data = bssumm;
  tables ce_quad;
  title2 "ICE Quadrant Confidence Levels";
  title3 "Variables &avarc and &avare";
run;

%let pospos=0;
%let posneg=0;
%let negpos=0;
%let negneg=0;

data _null_;
  set quadrt;
  if ce_quad='++' then call symput('pospos', compress(percent));
  if ce_quad='+-' then call symput('posneg', compress(percent));
  if ce_quad='-+' then call symput('negpos', compress(percent));
  if ce_quad='--' then call symput('negneg', compress(percent));
run;

proc univariate data=bssumm freq noprint;
  var cdiff ediff;
  output out = pctls pctlpts = 2.5 97.5 pctlpre = &avarc &avare 
    pctlname = _lcl _ucl;
run;

%** Create graph of bootstrap ce **;

axis1 label=(angle=90 h=1.5 c=black "Cost Difference: 1-0" J=CENTER)
      value=(h=1.5 c=black) ;
axis2 label=(h=1.5 c=black "Effectiveness Difference: 1-0" 
             J=CENTER) value=(h=1.5 c=black) ;

ods listing close;
ods pdf file=iceplane notoc;

proc gplot data=bssumm;
  plot cdiff*ediff = 'x'/nolegend haxis=axis2
                                     vaxis=axis1 href=0 vref=0;

  %**Add Quadrant frequency percentage **;
  %if &pospos.>0 %then %do;
    note height=1.75 m=(80pct,80pct) "&pospos.%";
  %end;
  %if &posneg.>0 %then %do;
    note height=1.75 m=(20pct,80pct) "&posneg.%";
  %end;
  %if &negneg.>0 %then %do;
    note height=1.75 m=(20pct,20pct) "&negneg.%";
  %end;
  %if &negpos.>0 %then %do;
    note height=1.75 m=(80pct,20pct) "&negpos.%";
  %end;

  title1 h=2.5 lspace=1 "ICE Quadrant Confidence Levels"; 
run;

proc means data=bssumm;
  var cdiff ediff;
run;

proc print data=pctls;
  title2 "Bootstrap 95% Pct. Conf. Limits for &avarc and &avare";
run;

ods pdf close;
ods listing;
quit;

%**clean work library**;
proc datasets library=work memtype=data nolist;
  delete temp freqnums pctls;
run;
quit;

goptions reset=all;

%MEND PSBB;		/* End of macro */

************************************************************************;

%PSBB(rep = 10000, avarc = cardcost, avare = surv6mo, indat = rank01,
    binvar = bin_ps, trtvar = trtm);

quit;

***Draw histogram of mean difference in cost (Trtm1 - Trtm0) ***********;

data bssumm;
  set bssumm;
  cdiff1=cdiff/1000; 
  ** Rescale cost axis: unit = $1K **;
run;

ods listing close;
ods pdf file=icsthist notoc;

title ' ';
footnote ' ';
pattern1 v=solid c=black;
footnote1  h=1.5 "Mean Difference in Costs: 1-0 ($1K)";
AXIS1 LABEL=(H=2 C=BLACK angle=90 "Frequency" J=CENTER) value=(H=1.5
   C=BLACK) order=(0 to 3000 by 1000);
AXIS2 LABEL=(H=2 C=BLACK  J=CENTER ' ') ; 

PROC GCHART data=bssumm;
  VBAR cdiff1/ref=(0 to 3000 by 1000) midpoints=(-.2 to +1.0 by 0.1)
    raxis=axis1 maxis=axis2 space=5 width=2;
run;

ods pdf close;
ods listing;
quit;

goptions reset=all;
quit;     
