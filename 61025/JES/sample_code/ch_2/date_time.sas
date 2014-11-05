

DATA Temp;
	aDate     = '13AUG1954'd;
	aDateTime = '13AUG1954:08:30:25'dt;
	Today=TODAY();
	Time = TIME();
	Now = DATETIME();
RUN;
TITLE "Temp"; PROC PRINT DATA=Temp NOOBS; RUN;

DATA Better; SET Temp; 
	FORMAT aDate Today DATE9. aDateTime Now DATETIME20. Time TIME8.;
RUN;
TITLE "Better"; PROC PRINT DATA=Better NOOBS; RUN;

DATA OneWeek;
	FORMAT theDate WEEKDATE29.  weekEnd DATE7. nextMonth MMDDYY10.;
	DO I=0 TO 6;
		theDate = '28MAR2007'd + I;
		M = MONTH(theDate); D = DAY(theDate); Y = YEAR(theDate);
		Q = QTR(theDate);
		DOW = WEEKDAY(theDate);
		nextMonth = MDY(M+1, D, Y);
		NDays   = INTCK('DAY', theDate, nextMonth);
		weekEnd = INTNX('WEEK', theDate, 0, 'E');
		OUTPUT;
	END;
RUN; 
TITLE "OneWeek"; PROC PRINT DATA=OneWeek NOOBS; RUN;


/*==== Illustration of the formats in Table 2-2 ====*/
DATA Tab;
FORMAT DATE7 DATE7. DATE9 DATE9. MMDDYY10 MMDDYY10. WEEKDATE15 WEEKDATE15. 
DATETIME13 DATETIME13. DATETIME16 DATETIME16. DATETIME20 DATETIME20.;
DATE7 = '15MAR2007'd; 
DATE9=DATE7;
MMDDYY10=DATE7;
WEEKDATE15=DATE7;
DATETIME13 = '15MAR2007:08:30:27'dt;
DATETIME16 = DATETIME13;
DATETIME20 = DATETIME13;
RUN;
TITLE "Tab"; PROC PRINT DATA=Tab NOOBS; RUN;
