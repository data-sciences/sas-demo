
/*--This sample uses data from sample 49_2_1--*/
proc format;
   value risk 1='ALL' 2='Low Risk' 3='High Risk';

/*--Data for proc LIFETEST--*/
data BMT;
   input Group T Status @@;
   format Group risk.;
   label T='Disease Free Time';
   datalines;
1 2081 0 1 1602 0 1 1496 0 1 1462 0 1 1433 0
1 1377 0 1 1330 0 1  996 0 1  226 0 1 1199 0
1 1111 0 1  530 0 1 1182 0 1 1167 0 1  418 1
1  383 1 1  276 1 1  104 1 1  609 1 1  172 1
1  487 1 1  662 1 1  194 1 1  230 1 1  526 1
1  122 1 1  129 1 1   74 1 1  122 1 1   86 1
1  466 1 1  192 1 1  109 1 1   55 1 1    1 1
1  107 1 1  110 1 1  332 1 2 2569 0 2 2506 0
2 2409 0 2 2218 0 2 1857 0 2 1829 0 2 1562 0
2 1470 0 2 1363 0 2 1030 0 2  860 0 2 1258 0
2 2246 0 2 1870 0 2 1799 0 2 1709 0 2 1674 0
2 1568 0 2 1527 0 2 1324 0 2  957 0 2  932 0
2  847 0 2  848 0 2 1850 0 2 1843 0 2 1535 0
2 1447 0 2 1384 0 2  414 1 2 2204 1 2 1063 1
2  481 1 2  105 1 2  641 1 2  390 1 2  288 1
2  421 1 2   79 1 2  748 1 2  486 1 2   48 1
2  272 1 2 1074 1 2  381 1 2   10 1 2   53 1
2   80 1 2   35 1 2  248 1 2  704 1 2  211 1
2  219 1 2  606 1 3 2640 0 3 2430 0 3 2252 0
3 2140 0 3 2133 0 3 1238 0 3 1631 0 3 2024 0
3 1345 0 3 1136 0 3  845 0 3  422 1 3  162 1
3   84 1 3  100 1 3    2 1 3   47 1 3  242 1
3  456 1 3  268 1 3  318 1 3   32 1 3  467 1
3   47 1 3  390 1 3  183 1 3  105 1 3  115 1
3  164 1 3   93 1 3  120 1 3   80 1 3  677 1
3   64 1 3  168 1 3   74 1 3   16 1 3  157 1
3  625 1 3   48 1 3  273 1 3   63 1 3   76 1
3  113 1 3  363 1
;

ods html close;
ods listing close;
ods graphics on;

/*--Get survival plot data from LIFETEST procedure--*/
ods output Survivalplot=SurvivalPlotData;
proc lifetest data=BMT plots=survival(atrisk=0 to 2500 by 500);
   time T * Status(0);
   strata Group / test=logrank adjust=sidak;
   run;

/*--Format for StratumNum--*/
proc format;
  value aml
  3 = 'Low'
  2 = 'High'
  1 = 'All';
run;

/*--Create graph with curve labels--*/
ods listing style=styles.listing image_dpi=200;
ods graphics / reset width=6in height=4in imagename='Fig12_4_SurvivalPlot_V93';
title 'Product-Limit Survival Estimates';
title2 h=7pt 'With Number of AML Subjects at Risk';
proc sgplot data=SurvivalPlotData;
  format stratumNum aml.;

  /*--Use step plot with curvelabels for the survival curves--*/
  step x=time y=survival / group=stratum curvelabel lineattrs=(pattern=solid) 
       name='survival';

  /*--The draw censored observations--*/
  scatter x=time y=censored / markerattrs=(symbol=plus) name='censored';
  scatter x=time y=censored / markerattrs=(symbol=plus) GROUP=stratum;

  /*--Draw the At Risk values--*/
  scatter x=tatrisk y=stratumnum / markerchar=atrisk y2axis group=stratumnum;

  /*--Draw other items--*/
  refline 0;
  keylegend 'censored' / location=inside position=topright;

  /*--Set axis properties and offsets to separate the Graph from the table--*/
  yaxis offsetmin=0.15 min=0;
  y2axis offsetmax=0.88 display=(nolabel noticks) valueattrs=(size=7);
  run;
title;

