
/*======================================================
JES.Units_U
JES.Modes
JES.Fails_Codes
=======================================================*/

PROC SORT DATA=JES.Units 
	OUT=Units_Sorted; 
	BY SN DESCENDING Install; 
RUN;

DATA JES.Units_U; SET Units_Sorted; BY SN DESCENDING Install;
	IF LAST.SN=1;
RUN;
PROC SORT DATA=JES.Units_U; BY SN; RUN;

DATA JES.Modes; LENGTH Code $2. Fail_Mode $25.;
        Code= "01"; Fail_Mode = "Blank Display"; OUTPUT;
        Code= "02"; Fail_Mode = "Keyboard"; OUTPUT;
        Code= "03"; Fail_Mode = "Hard Drive Errors"; OUTPUT;
        Code= "04"; Fail_Mode = "Memory Errors"; OUTPUT;
        Code= "05"; Fail_Mode = "Blue Screen"; OUTPUT;
        Code= "06"; Fail_Mode = "Cannot read DVD"; OUTPUT;
        Code= "07"; Fail_Mode = "Power Supply"; OUTPUT;
RUN;

DATA JES.Fails_Codes; FORMAT SN $4. Fail MMDDYY10. Code $2.;
        SEED=12345;
        DO I=1 TO 10;
                CALL RANUNI(SEED, X); CALL RANUNI(SEED, Y); CALL RANUNI(SEED, Z);
                SN=PUT(FLOOR(99*X), Z4.0); 
                Fail = '01JUL2006'd + FLOOR(90*Y);
                Code = PUT(FLOOR(9*Z), Z2.0);  
                OUTPUT;
        END;
        DROP i X Y Z SEED;
RUN;

DATA JES.Fails_Codes; SET JES.Fails_Codes; L=Lag4(SN);
        IF _N_=5 THEN SN=L;
        IF _N_ NE 4; IF _N_ NE 8; IF _N_ NE 10;
        IF _N_=3 THEN Code="NA";
        DROP L;
RUN;
PROC SORT DATA=JES.Fails_Codes; BY Fail; RUN;
        
PROC DATASETS LIBRARY=WORK; DELETE Units_Sorted;  QUIT;
