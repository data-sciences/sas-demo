


GOPTIONS RESET=ALL BORDER;
OPTIONS NODATE;

GOPTIONS RESET=ALL BORDER FTEXT='Helvetica' FTITLE='Helvetica/Bold';
GOPTIONS GUNIT=PCT HTEXT=5 DEVICE=SASEMF XMAX=6IN YMAX=4IN; 
ODS RTF STARTPAGE=NEVER FILE="&JES.ods_output/report.rtf";

%INCLUDE "&JES.sample_code/ch_7/vendors_1.sas";
%INCLUDE "&JES.sample_code/ch_7/vendors_2.sas";
%INCLUDE "&JES.sample_code/ch_7/vendors_3.sas";
%INCLUDE "&JES.sample_code/ch_7/chitronix_1.sas";
ODS RTF EXCLUDE Moments BasicMeasures TestsForLocation Quantiles 
         ExtremeObs ParameterEstimates FitQuantiles GoodnessOfFit;
%INCLUDE "&JES.sample_code/ch_7/chitronix_2.sas";

%INCLUDE "&JES.sample_code/ch_7/duality_1.sas";
ODS RTF EXCLUDE Moments BasicMeasures TestsForLocation Quantiles 
         ExtremeObs ParameterEstimates FitQuantiles GoodnessOfFit;
%INCLUDE "&JES.sample_code/ch_7/duality_2.sas";

%INCLUDE "&JES.sample_code/ch_7/empirical_1.sas";
ODS RTF EXCLUDE Moments BasicMeasures TestsForLocation Quantiles 
         ExtremeObs ParameterEstimates FitQuantiles GoodnessOfFit;
%INCLUDE "&JES.sample_code/ch_7/empirical_2.sas";

ODS RTF CLOSE;



