***********************************************************************************
*************** MACRO for Local Control: Phase Two (CONFIRM) **********************
***********************************************************************************
Macro "LC_Salient" simulates the empirical Cumulative Distribution Function (eCDF)
  for the "artificial" Local Treatment Difference (LTD) distribution that randomly
  assigns patients to the same number of clusters, of the same size, and with the
  same treatment/control fractions as a given observed LTD distribution.  To enable
  visual comparisons between the observed and artifical empirical CDFs, the pair of
  eCDFs are also plotted using proc UNIVARIATE (requires SAS 9.2).  An observed
  LTD distribution is said to be "salient" when it is meaningfully different
  from its corresponding artificial LTD distribution.
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

%MACRO LC_Salient(LC_Path =, LC_LTDoutput =, LC_T01var =, LC_Yvar =, LC_aLTDreps =,
       LC_aLTDdist =, LC_seed =, NCinform =, LC_pdfaltdd =);

*** Collect key info on the LTD distribution for the "oa" variable.  The initial
*** rows of the ltddists dataset are for the ltds within the "observed" clustering.
*** This info was previously computed and stored for individual patients, freq = 1,
*** using the LC PhaseOne (EXPLORE) macro procedure;

data ltddists;
  set &LC_Path..&LC_LTDoutput;
  oa = "obsLTD";
  freq = 1;
  where ltd ne .;
  keep oa ltd freq;
run;

*** Prepare to simulate the LTD distribution for oa = "aLTD" clusterings;
*** This info will be computed at the cluster level ...i.e. where freq = size 
*** of each informative cluster;

data clusdata;
  set &LC_Path..&LC_LTDoutput;
  keep cluster &LC_T01var &LC_Yvar;
run;

proc sort data=clusdata;
  by &LC_T01var cluster;
run;

*** Form dataset of cluster size and treatment selection combinations that will
*** be held constant across all replications of the aLTD simulation;

data clusfixed;
  set clusdata;
  order = _n_;
  keep cluster &LC_T01var order;
run;

*** Form dataset of raw Y = outcome data that will be randomly sampled
*** without replacement (equivalently, randomly permuted) in each
*** replication of the aLTD simulation;

data clusrand;
  set clusdata;
  order = 1;
  altdrand = .5;
  keep &LC_T01var &LC_Yvar altdrand order;
run;

******* Main Macro LOOP: Perform multiple replications to *****;
**********   reliably estimate the aLTD distribution.  ********;

%DO I = 1 %TO &LC_aLTDreps; 

  *** Randomize Y-outcomes across fixed cluster / treatment combinations;
  
  data clusrand;
    set clusrand;
    altdrand = ranuni(&LC_seed);
  run;
  
  proc sort data=clusrand;
    by &LC_T01var altdrand;
  run;
  
  data clusrand;
    set clusrand;
    order = _n_;
  run;

  data altddata;
    merge clusfixed clusrand;
    by order &LC_T01var;	
  run;
  
  *** Compute within-cluster statistics by treatment;
  *** Output cell means by cluster and treatment;
 
  proc means noprint data=altddata;
    output out=nctrtavg n=n mean=mean;
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
    if &LC_T01var = 1 then n1 = n; 
    if &LC_T01var = 1 then ybar1 = mean;
  run;

  ***** Select data for treatment zero;

  data nctrtavg0;
    set nctrtavg2;
    keep cluster n0 ybar0;
    if &LC_T01var = 0;
  run;

  proc sort data=nctrtavg0;
    by cluster;
  run;

  ***** Select data for treatment one;

  data nctrtavg1;
    set nctrtavg2;
    keep cluster n1 ybar1;
    if &LC_T01var = 1;
  run;

  proc sort data=nctrtavg1;
    by cluster;
  run;

  ***** Merge &LC_T01var summary statistics by cluster;

  data altdtable;
    merge nctrtavg1 nctrtavg0;
    by cluster;
  run;
  
  data altdtable; 
    set altdtable;
    if n0 ge 1 and n1 ge 1 then ltd = ybar1 - ybar0;
    else ltd = .;
	freq = n0 + n1;
  run;
  
  *** Keep only statistics from informative clusters;
  
  data altdtable; 
    set altdtable;
	oa = "aLTD";
    where (ltd ne . and freq ne .);
	keep oa ltd freq;
  run;

  data ltddists;
    set ltddists altdtable;
  run;
  
%END;

********* End of Main Macro LOOP ***********;
********************************************;

data &LC_Path..&LC_aLTDdist;
  set ltddists;
  where oa eq "aLTD";
  keep ltd freq;
run;

goptions htext=2 gunit=pct rotate=landscape;

title h=4 "Comparison of LTD Distributions";
footnote "Number of Informative Clusters = &NCinform";

ods listing close;
ods pdf file=&LC_pdfaltdd notoc;

*** histogram comparison plot executes properly under SAS 9.1;

proc univariate /*noprint*/ data=ltddists;
      class oa;
	  freq freq;
         histogram ltd / nrows=2 href=0;
	  inset median mean std="Std Dev";
run;

*** eCDF comparison plot requires SAS 9.2;

proc univariate noprint data=ltddists;
      class oa;
	  freq freq;
      cdfplot ltd / overlay href=0;				
run;

ods pdf close;
ods listing;

%MEND LC_Salient;

*********************************** END *******************************************;
