* E11_1_5.sas
*
* Using MATCH_ALL and PERSIST together;

ods listing close;


***********************************************;
title1 '11.1.5 Using MATCH_ALL and PERSIST Together';
ods output extremeobs(match_all=series persist=proc)=HT_WT;
ods listing close;

proc univariate data=advrpt.demog;
   class sex;
   id lname fname;
   var ht wt;
   run;

proc univariate data=advrpt.demog;
   class edu;
   id lname fname;
   var ht wt;
   run;
ods output close;

ods listing;
title2 'First of HT_WT Series';
proc print data=ht_wt;
   run; 

%put &series;

data HT_WT_all;
   set &series;
   if edu < '13';
   run;

title2 'All Data In the Series';
proc print data=ht_wt_all;
   run;

proc datasets library=work memtype=data nolist;
   delete ht_wt_all;
   run;

data HT_WT_allso;
   set ht_wt:;
   if edu < '13';
   run;

***********************************************;
title1 '11.1.5b Using PERSIST without MATCH_ALL';
ods output extremeobs(persist=proc)=ALLHT_WT;
ods listing close;

proc univariate data=advrpt.demog;
   class sex;
   id lname fname;
   var ht wt;
   run;

proc univariate data=advrpt.demog;
   class edu;
   id lname fname;
   var ht wt;
   run;
ods output close;

ods listing;
title2 'ALL Data combined';
proc print data=ALLht_wt;
   run; 

