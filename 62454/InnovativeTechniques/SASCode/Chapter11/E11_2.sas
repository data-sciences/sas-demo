*E11_2.sas
*
* Using the EXCELXP Tagset;
title1 '11.2 Using the EXCELXP Tagset';

ods tagsets.excelxp
           style=default
           path="&path\results"
           body="E11_2.xls";

title2 "Using the ExcelXP Tagset";

proc report data=advrpt.demog nowd split='*';
  column symp ('Mean Weight*in Pounds' sex,wt ratio);
  define symp    / group width=10 'Symptom';
  define sex     / across 'Gender' order=data;
  define wt      / analysis mean format=6. ' ';
  define ratio   / computed format=6.3 'Ratio*F/M ';
  rbreak after   / dol skip summarize;
  compute ratio;
     ratio = _c3_ / _c2_;
  endcomp;
  run;

ods _all_ close;
