

/*===== Sort Examples =====*/



PROC SORT DATA=JES.Units 
	OUT=Units_Sorted; 
	BY SN DESCENDING Install; 
RUN;



DATA Units_Sorted_Plus; SET Units_Sorted; BY SN DESCENDING Install;
	F_SN   = FIRST.SN;
	L_SN    = LAST.SN;
	F_Install  = FIRST.Install;
	L_Install  = LAST.Install;
RUN;



DATA Units_U Units_Dup; SET Units_Sorted; BY SN DESCENDING Install;
	IF LAST.SN=1 THEN OUTPUT Units_U;
	IF FIRST.SN=0 or LAST.SN=0 THEN OUTPUT Units_Dup;
RUN;




/*===== Merge Examples =====*/


PROC SORT DATA=Units_U; BY SN; RUN;
PROC SORT DATA=JES.Fails; BY SN; RUN;
DATA Units_Fails; MERGE Units_U JES.Fails; BY SN;
RUN;

DATA Units_Fails_2; MERGE Units_U JES.Fails(RENAME=(Loc=Position)); BY SN;
RUN;


DATA Units_Fails_Plus; 
MERGE Units_U(IN=in_u) JES.Fails(IN=in_f RENAME=(Loc=Position)); BY SN;
	In_Units = in_u;
	In_Fails = in_f;
RUN;



DATA Units_Fails_OK Fails_OK Fails_WO_Install; 
	MERGE Units_U(IN=In_U) JES.Fails(IN=In_F RENAME=(Loc=Position)); BY SN;
	IF In_U=1 THEN OUTPUT Units_Fails_OK;
	IF In_U=1 and In_F=1 THEN OUTPUT Fails_OK;
	IF In_U=0 and In_F=1 THEN OUTPUT Fails_WO_Install;
RUN;




