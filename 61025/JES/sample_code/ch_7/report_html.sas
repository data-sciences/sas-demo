

PROC DATASETS MEMTYPE=CAT NOLIST; DELETE HTML; RUN; QUIT; 
GOPTIONS RESET=ALL BORDER;
OPTIONS NODATE;

GOPTIONS RESET=ALL BORDER FTEXT='Helvetica' FTITLE='Helvetica/Bold';
GOPTIONS GUNIT=PCT DEVICE=PNG HTEXT=4 HTITLE=5 HSIZE=9IN VSIZE=6IN; 

ODS HTML PATH="&JES.ods_output/page1" 
	(URL=NONE)
	BODY="report.html"
	STYLE=MINIMAL;
	%INCLUDE "&JES.sample_code/ch_7/vendors_1.sas";
	%INCLUDE "&JES.sample_code/ch_7/vendors_2.sas";
	%INCLUDE "&JES.sample_code/ch_7/vendors_3.sas";
	
	%INCLUDE "&JES.sample_code/ch_7/chitronix_1.sas";
	ODS HTML EXCLUDE Moments BasicMeasures TestsForLocation Quantiles 
         ExtremeObs ParameterEstimates FitQuantiles GoodnessOfFit;
	%INCLUDE "&JES.sample_code/ch_7/chitronix_2.sas";
	%INCLUDE "&JES.sample_code/ch_7/duality_1.sas";
	ODS HTML EXCLUDE Moments BasicMeasures TestsForLocation Quantiles 
         ExtremeObs ParameterEstimates FitQuantiles GoodnessOfFit;
	%INCLUDE "&JES.sample_code/ch_7/duality_2.sas";
	%INCLUDE "&JES.sample_code/ch_7/empirical_1.sas";
	ODS HTML EXCLUDE Moments BasicMeasures TestsForLocation Quantiles 
         ExtremeObs ParameterEstimates FitQuantiles GoodnessOfFit;
	%INCLUDE "&JES.sample_code/ch_7/empirical_2.sas";
ODS HTML CLOSE;



/* HTML with FRAMES  */ 
ODS HTML PATH="&JES.ods_output/page2" (URL=NONE)
	BODY="report_body.html"
	CONTENTS="report_toc.html"
	FRAME = "report_frame.html"
	STYLE=MINIMAL;
	%INCLUDE "&JES.sample_code/ch_7/vendors_1.sas";
	%INCLUDE "&JES.sample_code/ch_7/vendors_2.sas";
	%INCLUDE "&JES.sample_code/ch_7/vendors_3.sas";

	ODS PROCLABEL="Delay vs Resistance - ChiTronix";
	%INCLUDE "&JES.sample_code/ch_7/chitronix_1.sas";
	ODS HTML EXCLUDE Moments BasicMeasures TestsForLocation Quantiles 
         ExtremeObs ParameterEstimates FitQuantiles GoodnessOfFit;
	ODS PROCLABEL="Distribution of Resistance - ChiTronix";
	%INCLUDE "&JES.sample_code/ch_7/chitronix_2.sas";

	ODS PROCLABEL="Delay vs Resistance - Duality";
	%INCLUDE "&JES.sample_code/ch_7/duality_1.sas";
	ODS HTML EXCLUDE Moments BasicMeasures TestsForLocation Quantiles 
         ExtremeObs ParameterEstimates FitQuantiles GoodnessOfFit;
	ODS PROCLABEL="Distribution of Resistance - Duality";
	%INCLUDE "&JES.sample_code/ch_7/duality_2.sas";

	ODS PROCLABEL="Delay vs Resistance - Empirical";
	%INCLUDE "&JES.sample_code/ch_7/empirical_1.sas";
	ODS HTML EXCLUDE Moments BasicMeasures TestsForLocation Quantiles 
         ExtremeObs ParameterEstimates FitQuantiles GoodnessOfFit;
	ODS PROCLABEL="Distribution of Resistance - Empirical";
	%INCLUDE "&JES.sample_code/ch_7/empirical_2.sas";
ODS HTML CLOSE;

/* HTML with FRAMES  Output on Separate Pages*/

ODS HTML PATH="&JES.ods_output/page3" (URL=NONE)
	BODY="report_body.html"
	CONTENTS="report_toc.html"
	FRAME = "report_frame.html"
	STYLE=MINIMAL
	NEWFILE=PAGE;
	%INCLUDE "&JES.sample_code/ch_7/vendors_1.sas";
	%INCLUDE "&JES.sample_code/ch_7/vendors_2.sas";
	%INCLUDE "&JES.sample_code/ch_7/vendors_3.sas";

	ODS PROCLABEL="Delay vs Resistance - ChiTronix";
	%INCLUDE "&JES.sample_code/ch_7/chitronix_1.sas";
	ODS HTML EXCLUDE Moments BasicMeasures TestsForLocation Quantiles 
         ExtremeObs ParameterEstimates FitQuantiles GoodnessOfFit;
	ODS PROCLABEL="Distribution of Resistance - ChiTronix";
	%INCLUDE "&JES.sample_code/ch_7/chitronix_2.sas";

	ODS PROCLABEL="Delay vs Resistance - Duality";
	%INCLUDE "&JES.sample_code/ch_7/duality_1.sas";
	ODS HTML EXCLUDE Moments BasicMeasures TestsForLocation Quantiles 
         ExtremeObs ParameterEstimates FitQuantiles GoodnessOfFit;
	ODS PROCLABEL="Distribution of Resistance - Duality";
	%INCLUDE "&JES.sample_code/ch_7/duality_2.sas";

	ODS PROCLABEL="Delay vs Resistance - Empirical";
	%INCLUDE "&JES.sample_code/ch_7/empirical_1.sas";
	ODS HTML EXCLUDE Moments BasicMeasures TestsForLocation Quantiles 
         ExtremeObs ParameterEstimates FitQuantiles GoodnessOfFit;
	ODS PROCLABEL="Distribution of Resistance - Empirical";
	%INCLUDE "&JES.sample_code/ch_7/empirical_2.sas";
ODS HTML CLOSE;



/* Hyperlinks */
/* First create some HTML pages to Link to */

/* ChiTronix Page */
ODS HTML PATH="&JES.ods_output/page4" (URL=NONE) 
	BODY="ChiTronix.html" (TITLE="ChiTronix")STYLE=MINIMAL ;
	%INCLUDE "&JES.sample_code/ch_7/chitronix_1.sas";
	ODS HTML EXCLUDE Moments BasicMeasures TestsForLocation Quantiles 
         ExtremeObs ParameterEstimates FitQuantiles GoodnessOfFit;
	%INCLUDE "&JES.sample_code/ch_7/chitronix_2.sas";
ODS HTML CLOSE;

/* Duality Page */
ODS HTML PATH="&JES.ods_output/page4" (URL=NONE) 
	BODY="Duality.html"  (TITLE="Duality") STYLE=MINIMAL ;
	%INCLUDE "&JES.sample_code/ch_7/duality_1.sas";
	ODS HTML EXCLUDE Moments BasicMeasures TestsForLocation Quantiles 
         ExtremeObs ParameterEstimates FitQuantiles GoodnessOfFit;
	%INCLUDE "&JES.sample_code/ch_7/duality_2.sas";
	TITLE1 H=7 "Duality Defect Rate by Month";
ODS HTML CLOSE;

/* Empirical Page */
ODS HTML PATH="&JES.ods_output/page4" (URL=NONE) 
	BODY="Empirical.html" (TITLE="Empirical") STYLE=MINIMAL ;
	%INCLUDE "&JES.sample_code/ch_7/empirical_1.sas";
	ODS HTML EXCLUDE Moments BasicMeasures TestsForLocation Quantiles 
         ExtremeObs ParameterEstimates FitQuantiles GoodnessOfFit;
	%INCLUDE "&JES.sample_code/ch_7/empirical_2.sas";
ODS HTML CLOSE;


/* Add url information for links */
DATA Results_Tab_2; SET JES.Results_Tab_2;
	Print_Link = CATS('<A HREF="',Vendor,'.html" 
		TARGET="_blank">',Vendor,'</A>');
	LABEL Print_Link="Vendor";
RUN;
DATA Results_Tab; SET JES.Results_Tab;
	Report_Link=CATS(Vendor,'.html');
	Point_Link=CATS('HREF="',Vendor,'.html"');
	Legend_Link=CATS('HREF="',Vendor,'.html" TARGET="_blank"');
RUN;


/* Main page with links to the Vendor pages */
ODS HTML PATH="&JES.ods_output/page4" (URL=NONE) 
	BODY="report_w_links.html" (TITLE="All Vendors")
	STYLE=MINIMAL;
	%INCLUDE "&JES.sample_code/ch_7/vendors_1a.sas";
	%INCLUDE "&JES.sample_code/ch_7/vendors_2a.sas";
	%INCLUDE "&JES.sample_code/ch_7/vendors_3a.sas";
ODS HTML CLOSE;


/* Main page with links to the Vendor pages
	- using the HEADTEXT option 
	- with Traffic Lighting in PROC REPORT */
ODS HTML PATH="&JES.ods_output/page4" (URL=NONE) 
	BODY="report_w_links_2.html" (TITLE="All Vendors") 
	STYLE=MINIMAL
	HEADTEXT="<base TARGET=_BLANK>";
	%INCLUDE "&JES.sample_code/ch_7/vendors_1a.sas";
	%INCLUDE "&JES.sample_code/ch_7/vendors_2b.sas";
	%INCLUDE "&JES.sample_code/ch_7/vendors_3a.sas";
ODS HTML CLOSE;








