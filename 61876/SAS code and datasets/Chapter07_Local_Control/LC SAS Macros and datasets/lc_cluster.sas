***********************************************************************************
************** MACROs for Local Control: Phase One (EXPLORE) **********************
***********************************************************************************
Macro "LC_Cluster" invokes proc CLUSTER to form a Dendrogram Tree using specified
  patient baseline X-characteristic variables.
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

%MACRO LC_Cluster(LC_path =, LC_YTXdata =, LC_PatID = sequen_id, LC_Xvars =,
                  LC_Stand = STD, LC_ClusMeth =, LC_Tree =);

data &LC_Path..&LC_YTXdata;
  set &LC_Path..&LC_YTXdata;
  &LC_PatID = _n_;
run;

proc stdize data=&LC_Path..&LC_YTXdata out=LC1stdize method=&LC_Stand; 
  var &LC_Xvars;
run;

proc cluster noprint data=LC1stdize method=&LC_ClusMeth outtree=&LC_Path..&LC_Tree;
  var &LC_Xvars;
  id &LC_PatID; 
run;

%MEND LC_Cluster;
