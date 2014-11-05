
PROC DATASETS LIBRARY=WORK MEMTYPE=DATA GENNUM=ALL KILL; QUIT;
%LET Code_Path=&JES.sample_code/ch_7/;
%INCLUDE "&Code_Path.report_1.sas";
%INCLUDE "&Code_Path.report_rtf.sas";
%INCLUDE "&Code_Path.report_pdf.sas";
%INCLUDE "&Code_Path.report_html.sas";
%INCLUDE "&Code_Path.output_example.sas";
%INCLUDE "&Code_Path.notobo.sas";
%INCLUDE "&Code_Path.smith_styles.sas";
%INCLUDE "&Code_Path.jes_style.sas";

%INCLUDE "&Code_Path.output_example.sas"; 
TITLE1 "Moments"; PROC PRINT DATA=Moments NOOBS; RUN;
TITLE1 "Basic";   PROC PRINT DATA=Basic   NOOBS; RUN;
TITLE1 "Quant";   PROC PRINT DATA=quant   NOOBS; RUN;

GOPTIONS RESET=ALL BORDER;
OPTIONS NODATE ORIENTATION=PORTRAIT;
GOPTIONS RESET=ALL BORDER FTEXT='Helvetica' FTITLE='Helvetica/Bold';
GOPTIONS GUNIT=PCT HTEXT=5 DEVICE=SASPRTC; 
ODS LISTING CLOSE;
ODS PDF FILE="&JES.ods_output\report.pdf" STARTPAGE=NEVER PDFTOC=1;
GOPTIONS  HORIGIN=1IN VORIGIN=0.5IN HSIZE=6IN VSIZE=4IN;
%INCLUDE "&Code_Path.vendors_3.sas";
%INCLUDE "&Code_Path.vendors_1.sas";
%INCLUDE "&Code_Path.vendors_2.sas";

ODS PDF STARTPAGE=YES;
ODS PDF STARTPAGE=NOW; 	
GOPTIONS HORIGIN=1IN VORIGIN=5.0IN HSIZE=6IN VSIZE=4IN;
ODS PROCLABEL="Delay vs Resistance - ChiTronix";
%INCLUDE "&Code_Path.chitronix_1.sas";
ODS PDF STARTPAGE=NEVER; 
GOPTIONS HORIGIN=1IN VORIGIN=0.5IN HSIZE=6IN VSIZE=4IN;
ODS PDF EXCLUDE Moments BasicMeasures TestsForLocation Quantiles 
         ExtremeObs ParameterEstimates FitQuantiles GoodnessOfFit;
ODS PROCLABEL="Distribution of Resistance - ChiTronix";
%INCLUDE "&Code_Path.chitronix_2.sas";


ODS PDF STARTPAGE=YES;
ODS PDF STARTPAGE=NOW; 
GOPTIONS HORIGIN=1IN VORIGIN=5.0IN HSIZE=6IN VSIZE=4IN;
ODS PROCLABEL="Delay vs Resistance - Duality";
%INCLUDE "&Code_Path.duality_1.sas";
ODS PDF STARTPAGE=NEVER;
GOPTIONS HORIGIN=1IN VORIGIN=0.5IN HSIZE=6IN VSIZE=4IN;
ODS PDF EXCLUDE Moments BasicMeasures TestsForLocation Quantiles 
      
