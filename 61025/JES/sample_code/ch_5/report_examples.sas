

/* Print out selected columns for all rows in the data set */
PROC REPORT DATA=JES.Results_Q4 NOWINDOWS;
	COLUMN Vendor Month Resistance Fail;
RUN; 



/* Print the mean of Resistance and Fail for each
   combination of Vendor and Month                 */

PROC REPORT DATA=JES.Results_Q4 NOWINDOWS HEADLINE;
	COLUMN Vendor Month Resistance Fail;
	DEFINE Vendor/GROUP;
	DEFINE Month/ GROUP;
	DEFINE Resistance / ANALYSIS 'Avg./Resistance' WIDTH=12 MEAN;
	DEFINE Fail / ANALYSIS 'Percent/Failure' FORMAT = 8.3 WIDTH=8 MEAN;
	BREAK AFTER Vendor / SUMMARIZE OL SKIP ;
	RBREAK AFTER / SUMMARIZE  DOL;
RUN; 


