***********************************************************************************
*************** MACRO for Local Control: Phase One (EXPLORE) **********************
***********************************************************************************
Macro "LC_UBtrace" plots the Weighted Average LTD and its plus-or-minus K * Sigma
  limits as a function of the log of NCreq, the total number of clusters requested.
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

%MACRO LC_UBtrace(LC_Path =, LC_UnBias =, LC_swidth =, LC_pdftrace =);

data LCubtr;
  set &LC_Path..&LC_UnBias;
  NCreq = _FREQ_;
  lolim = ltdavg - &LC_swidth * ltdsehom;
  uplim = ltdavg + &LC_swidth * ltdsehom;
  sicppct = 100 * sicpats / (sn0 + sn1);
run;

goptions htext=2 gunit=pct rotate=landscape;

title h=4 "LC Unbiasing Trace Display";
footnote "NCreq = number of clusters requested";

symbol1 v=dot i=join h=2.5 l=2;
symbol2 v=dot i=join h=2.5 l=1;
symbol3 v=dot i=join h=2.5 l=3;

axis1 label=(angle=90 rotate=0 "Patient-Weighted Average LTD");
axis2 logbase=10;

ods listing close;
ods pdf file=&LC_pdftrace notoc;

proc gplot data=LCubtr;
    plot (lolim ltdavg uplim)*NCreq/overlay vaxis=axis1 haxis=axis2;
    format ltdavg comma.;
run;

proc print data=LCubtr;
    var NCreq siclust sicpats sicppct ltdavg lolim uplim ltdsehom;
run;

ods pdf close;
ods listing;

%MEND LC_UBtrace;

***************************** END *****************************************;
