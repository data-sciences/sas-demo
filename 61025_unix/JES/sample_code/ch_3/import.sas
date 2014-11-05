

PROC IMPORT DATAFILE="&JES.output/ODS_Week_New.csv" 
	OUT =Week_Import REPLACE;
RUN;

PROC IMPORT DATAFILE="&JES.input_data/sample.csv" 
	OUT =Sample_Import REPLACE;
RUN;

  /**********************************************************************
 *   PRODUCT:   SAS
 *   VERSION:   9.1
 *   CREATOR:   External File Interface
 *   DATE:      26MAR07
 *   DESC:      Generated SAS Datastep Code
 *   TEMPLATE SOURCE:  (None Specified.)
 ***********************************************************************/
    data SAMPLE_IMPORT                               ;
    %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
    infile "&JES.input_data/sample.csv" delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
       informat Vendor $9. ;
       informat SN $8. ;
       informat Symptom $22. ;
       informat Install mmddyy10. ;
       informat Fail $25. ;
       format Vendor $9. ;
       format SN $8. ;
       format Symptom $22. ;
       format Install mmddyy10. ;
       format Fail $25. ;
    input
                Vendor $
                SN $
                Symptom $
                Install
                Fail $
    ;
    if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
    run;

DATA Sample_Import; SET Sample_Import;
	FORMAT Fail_Date MMDDYY10.;
	Fail_Date = INPUT(SCAN(Fail, 1, " "), MMDDYY10.);
RUN;

PROC IMPORT DATAFILE="&JES.input_data/sample.csv" 
	OUT =Sample_Import_2 REPLACE;
	GUESSINGROWS=500;
RUN;

PROC EXPORT DATA=Sample_Import 
	OUTFILE ="&JES.output/sample_export.csv" REPLACE;
RUN;

DATA Sample_Import_OK; SET Sample_Import;
	Symptom=COMPRESS(Symptom, , 'WK');
RUN;

PROC EXPORT DATA=Sample_Import_OK 
	OUTFILE ="&JES.output/sample_export_ok.csv" REPLACE;
RUN;
