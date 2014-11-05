

%INCLUDE "&JES.sample_code/ch_2/transpose.sas";
DATA CUM_Fails; set TRates;
	ARRAY Q(4)    Q1-Q4; 
	ARRAY CF(4) CF1-CF4;
	DO i=1 TO 4; 
		IF Q(i)=. THEN Q(i)=0; 
	END;
	Cf(1)=Q(1); 
	DO i=2 TO 4;
		CF(i)=CF(i-1)+Q(i);
	END;
	DROP i _NAME_ GEO;
RUN;

TITLE "CUM_Fails"; PROC PRINT DATA=CUM_Fails NOOBS; RUN;
