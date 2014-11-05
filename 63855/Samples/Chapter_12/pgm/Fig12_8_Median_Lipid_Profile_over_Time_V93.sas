
/*--Lipid data by test, separate columns for each drug--*/
data lipid;
label a_med="Drug A" b_med="Drug B" c_med="Drug C" p_med="Placebo";
input by $ 1-7 X $ 8-17 xc a_med a_lcl a_ucl b_med b_lcl b_ucl c_med c_lcl c_ucl p_med p_lcl p_ucl;
cards;
Test 1 Baseline  1  5.21 5.04 5.52 5.17 4.94 5.47 5.24 4.97 5.33 5.08 4.81 5.35
Test 2 Baseline  1  4.90 4.80 4.90 5.00 4.90 5.10 5.10 5.00 5.10 4.90 4.90 5.00
Test 1 Day 14    2    4.90 4.60 5.79 6.65 4.81 7.51 5.74 5.51 6.78 4.49 4.03 4.94
Test 2 Day 14    2    5.00 4.80 5.10 5.10 4.90 5.20 5.15 5.10 5.30 5.10 5.00 5.30
Test 1 Day 42    3    5.30 5.04 6.44 4.77 4.15 7.84 4.40 3.34 6.13 4.94 4.81 5.11
Test 2 Day 42    3    5.00 4.90 5.10 5.00 4.90 5.20 5.20 5.10 5.40 5.05 4.90 5.20
Test 1 Day 70    4    6.05 4.91 6.84 5.15 3.91 6.83 5.81 5.17 6.65 5.09 4.29 5.90
Test 2 Day 70    4    5.00 4.90 5.20 5.10 5.00 5.20 5.20 5.00 5.20 5.10 5.00 5.20
Test 1 Day 98    5    5.20 5.07 5.39 5.28 5.15 5.38 5.35 5.22 5.52 5.10 4.94 5.23
Test 2 Day 98    5    5.10 4.90 5.10 4.90 4.80 5.00 5.20 5.10 5.30 5.10 5.10 5.20
Test 1 End Point 6 5.24 4.97 5.48 5.15 5.09 5.42 5.34 5.15 5.53 5.04 4.94 5.22
Test 2 End Point 6 4.90 4.80 5.20 5.10 4.90 5.20 5.10 5.10 5.30 5.20 5.20 5.30
;

/*--Transform data into classified by test and drug--*/
data lipid_grp;
  set lipid;
  length Drug $8;
  label Median='Median with 84% CI';
  format median 5.2;
  drop xc;
  drop a_med b_med c_med p_med a_lcl b_lcl c_lcl p_lcl a_ucl b_ucl c_ucl p_ucl;
  Drug='Drug A';  Median=a_med; Lcl=a_lcl; Ucl=a_ucl; output;
  Drug='Drug B';  Median=b_med; Lcl=b_lcl; Ucl=b_ucl; output;
  Drug='Drug C';   Median=c_med; Lcl=c_lcl; Ucl=c_ucl; output;
  Drug='Placebo'; Median=p_med; Lcl=p_lcl; Ucl=p_ucl; output;
  run;

ods html close;

/*--Create graph using cluster grouped plots with cluster--*/ 
ods listing style=htmlblue image_dpi=200;
ods graphics / reset width=6in height=3in  imagename="Fig12_8_Median_Lipid_Profile_Over_Time_V93";
title 'Median of Lipid Profile over Time by Treatment';
proc sgplot data=lipid_grp;
  where by='Test 1';
  series x=x y=median / group=drug  groupdisplay=cluster clusterwidth=0.5;
  scatter x=x y=median / group=drug yerrorupper=ucl yerrorlower=lcl markerattrs=(size=7)
          groupdisplay=cluster clusterwidth=0.5 name='s';
  scatter x=x y=median / group=drug markerattrs=(size=5 symbol=circlefilled color=white) 
          groupdisplay=cluster clusterwidth=0.5;
  scatter x=x y=drug / markerchar=median y2axis group=drug;
  refline 'Placebo' / discreteoffset=0.5 axis=y2;
  keylegend 's';
  xaxis display=(nolabel);
  yaxis grid offsetmin=0.30;
  y2axis offsetmax=0.8 display=(noticks nolabel) valueattrs=(size=7);
  run;




