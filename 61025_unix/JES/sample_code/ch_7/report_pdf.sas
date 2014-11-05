

  
GOPTIONS RESET=ALL BORDER;
OPTIONS NODATE ORIENTATION=PORTRAIT;
GOPTIONS RESET=ALL BORDER FTEXT='Helvetica' FTITLE='Helvetica/Bold';
GOPTIONS GUNIT=PCT HTEXT=5 DEVICE=SASPRTC; 
ODS LISTING CLOSE;
ODS PDF FILE="&JES.ods_output/report.pdf" STARTPAGE=NEVER PDFTOC=1;
GOPTIONS  HORIGIN=1IN VORIGIN=0.5IN HSIZE=6IN VSIZE=4IN;
%INCLUDE "&JES.sample_code/ch_7/vendors_3.sas";
%INCLUDE "&JES.sample_code/ch_7/vendors_1.sas";
%INCLUDE "&JES.sample_code/ch_7/vendors_2.sas";

ODS PDF STARTPAGE=YES;
ODS PDF STARTPAGE=NOW; 	
GOPTIONS HORIGIN=1IN VORIGIN=5.0IN HSIZE=6IN VSIZE=4IN;
ODS PROCLABEL="Delay vs Resistance - ChiTronix";
%INCLUDE "&JES.sample_code/ch_7/chitronix_1.sas";
ODS PDF STARTPAGE=NEVER; 
GOPTIONS HORIGIN=1IN VORIGIN=0.5IN HSIZE=6IN VSIZE=4IN;
ODS PDF EXCLUDE Moments BasicMeasures TestsForLocation Quantiles 
         ExtremeObs ParameterEstimates FitQuantiles GoodnessOfFit;
ODS PROCLABEL="Distribution of Resistance - ChiTronix";
%INCLUDE "&JES.sample_code/ch_7/chitronix_2.sas";


ODS PDF STARTPAGE=YES;
ODS PDF STARTPAGE=NOW; 
GOPTIONS HORIGIN=1IN VORIGIN=5.0IN HSIZE=6IN VSIZE=4IN;
ODS PROCLABEL="Delay vs Resistance - Duality";
%INCLUDE "&JES.sample_code/ch_7/duality_1.sas";
ODS PDF STARTPAGE=NEVER;
GOPTIONS HORIGIN=1IN VORIGIN=0.5IN HSIZE=6IN VSIZE=4IN;
ODS PDF EXCLUDE Moments BasicMeasures TestsForLocation Quantiles 
         ExtremeObs ParameterEstimates FitQuantiles GoodnessOfFit;
ODS PROCLABEL="Distribution of Resistance - Duality";
%INCLUDE "&JES.sample_code/ch_7/duality_2.sas";

ODS PDF STARTPAGE=YES;
ODS PDF STARTPAGE=NOW; 
GOPTIONS HORIGIN=1IN VORIGIN=5.0IN HSIZE=6IN VSIZE=4IN;
ODS PROCLABEL="Delay vs Resistance - Empirical";
%INCLUDE "&JES.sample_code/ch_7/empirical_1.sas";
ODS PDF STARTPAGE=NEVER;
GOPTIONS HORIGIN=1IN VORIGIN=0.5IN HSIZE=6IN VSIZE=4IN;
ODS PDF EXCLUDE Moments BasicMeasures TestsForLocation Quantiles 
         ExtremeObs ParameterEstimates FitQuantiles GoodnessOfFit;
ODS PROCLABEL="Distribution of Resistance - Empirical";
%INCLUDE "&JES.sample_code/ch_7/empirical_2.sas";

ODS PDF CLOSE;
ODS LISTING;
