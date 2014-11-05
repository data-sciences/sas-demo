

/*==========================================================
This code creates the data set Week for export to a csv file
===========================================================*/
DATA Week;
	FORMAT D 8.0 theDate MMDDYY10. theTime DATETIME20.;
	DO D=0 TO 6;
		theDate = '13APR2007'd + D;
		theTime = theDate*60*60*24 + D*60;
		OUTPUT;
	END;
	LABEL D = "Day Number" theDate="The Date" theTime="Date and Time";
RUN;


PROC EXPORT DATA=Week 
	OUTFILE ="&JES.output/Week_Proc_Export.csv" REPLACE;
RUN;

/*==========================================================
This code exports the Week data set 
to the csv file ODS_Week.csv
===========================================================*/ 
ODS CSVALL FILE="&JES.output/ODS_Week.csv"; 
	TITLE "The Week Data Set";
	PROC PRINT DATA=Week LABEL NOOBS; 
		VAR D theTime theDate; 
	RUN;
ODS CSVALL CLOSE;


/*==========================================================
This code creates Week.html with the contents of Week 
which can be opened with MS Word or MS Excel
===========================================================*/
ODS TAGSETS.MSOffice2K FILE="MSO2K_Week.xls" PATH="&JES.output";
	TITLE "The Week Data Set";
	PROC PRINT DATA=Week LABEL NOOBS; 
		VAR D theTime theDate; 
	RUN;
ODS TAGSETS.MSOffice2K CLOSE;

