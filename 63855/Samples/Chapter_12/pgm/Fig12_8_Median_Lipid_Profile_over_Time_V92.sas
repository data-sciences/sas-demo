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

/*--Convert data into classified by drug, with linear x value with jitter--*/
data lipid_linear;
  set lipid (where=(by='Test 1'));
  keep Xl Xb Drug Med Lcl Ucl;
  length Drug $8;
  format med lcl ucl 4.2;

  /*--Jitter values for placement of drugs--*/
  j1=0.075; j2=3*j1;

  select (x);
    when ('Baseline') do;
         Xb=1; 
         xl= xb-j2; drug='Drug A'; med=a_med; lcl=a_lcl; ucl=a_ucl; output; 
		 xl= xb-j1; drug='Drug B'; med=b_med; lcl=b_lcl; ucl=b_ucl; output;
		 xl= xb+j1; drug='Drug C'; med=c_med; lcl=c_lcl; ucl=c_ucl; output;
		 xl= xb+j2; drug='Placebo'; med=p_med; lcl=p_lcl; ucl=p_ucl; output;
      end;
	when ('Day 14')  do;  
         Xb=2;
         xl= xb-j2; drug='Drug A'; med=a_med; lcl=a_lcl; ucl=a_ucl; output; 
		 xl= xb-j1; drug='Drug B'; med=b_med; lcl=b_lcl; ucl=b_ucl; output;
		 xl= xb+j1; drug='Drug C'; med=c_med; lcl=c_lcl; ucl=c_ucl; output;
		 xl= xb+j2; drug='Placebo'; med=p_med; lcl=p_lcl; ucl=p_ucl; output;
      end;
	when ('Day 42')  do;  
         Xb=3; 
         xl= xb-j2; drug='Drug A'; med=a_med; lcl=a_lcl; ucl=a_ucl; output; 
		 xl= xb-j1; drug='Drug B'; med=b_med; lcl=b_lcl; ucl=b_ucl; output;
		 xl= xb+j1; drug='Drug C'; med=c_med; lcl=c_lcl; ucl=c_ucl; output;
		 xl= xb+j2; drug='Placebo'; med=p_med; lcl=p_lcl; ucl=p_ucl; output;
      end;  
	when ('Day 70')  do;  
         Xb=4;
         xl= xb-j2; drug='Drug A'; med=a_med; lcl=a_lcl; ucl=a_ucl; output; 
		 xl= xb-j1; drug='Drug B'; med=b_med; lcl=b_lcl; ucl=b_ucl; output;
		 xl= xb+j1; drug='Drug C'; med=c_med; lcl=c_lcl; ucl=c_ucl; output;
		 xl= xb+j2; drug='Placebo'; med=p_med; lcl=p_lcl; ucl=p_ucl; output;
      end; 
	when ('Day 98')   do;  
         Xb=5;
         xl= xb-j2; drug='Drug A'; med=a_med; lcl=a_lcl; ucl=a_ucl; output; 
		 xl= xb-j1; drug='Drug B'; med=b_med; lcl=b_lcl; ucl=b_ucl; output;
		 xl= xb+j1; drug='Drug C'; med=c_med; lcl=c_lcl; ucl=c_ucl; output;
		 xl= xb+j2; drug='Placebo'; med=p_med; lcl=p_lcl; ucl=p_ucl; output;
      end;
	when ('End Point')  do;  
         Xb=6;
         xl= xb-j2; drug='Drug A'; med=a_med; lcl=a_lcl; ucl=a_ucl; output; 
		 xl= xb-j1; drug='Drug B'; med=b_med; lcl=b_lcl; ucl=b_ucl; output;
		 xl= xb+j1; drug='Drug C'; med=c_med; lcl=c_lcl; ucl=c_ucl; output;
		 xl= xb+j2; drug='Placebo'; med=p_med; lcl=p_lcl; ucl=p_ucl; output;
      end;
	otherwise;
  end;
  run;
/*proc print;run;*/

/*--UDF for X axis labels--*/
proc format;
  value x  
    1='Baseline'
	2='Day 14'
	3='Day 42'
	4='Day 70'
	5='Day 98'
	6='End Point'
	;
           
/*--Create graph using cluster grouped plots with cluster--*/ 
ods listing style=listing image_dpi=200;
ods graphics / reset width=6in height=3in  imagename="Fig12_8_Median_Lipid_Profile_Over_Time_V92";
title 'Median of Lipid Profile over Time by Treatment';
proc sgplot data=lipid_linear;
  format xl x.;
  series x=xl y=med / group=drug lineattrs=(pattern=solid);
  scatter x=xl y=med / group=drug yerrorupper=ucl yerrorlower=lcl 
          markerattrs=(symbol=circle size=7) name='s';
  scatter x=xl y=med / group=drug markerattrs=(symbol=circlefilled size=4 color=white);
  scatter x=xb y=drug / markerchar=med markercharattrs=(size=8) y2axis group=drug;
  refline 3 / noclip;
  keylegend 's' / title='';
  xaxis display=(nolabel) values=(1 to 6 by 1) offsetmin=0.1 offsetmax=0.1;
  yaxis grid offsetmin=0.3 label='Median with 85% CL';
  y2axis offsetmax=0.75 display=(noticks nolabel);
  run;





