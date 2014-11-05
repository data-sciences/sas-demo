/*==========================================================================
Macro:  %Dups(DSIN, FIELD);
Source: "Combining and Modifying SAS® Datasets: 
        Examples, Version 6, First Edition,", p. 111
Parameters:
        DSIN = Name of dataset
        FIELD = Field in DSIN to check for duplicates
Datasets Created:
        DSIN_DP = Records in DSIN which have duplicate values of FIELD
        DSIN_NP = Records in DSIN which do not have duplicate values of FIELD
        DSIN_U  = Subset of DSIN within which all values of FIELD are unique
Example:


DATA Units; SET JES.Units; RUN;
%Dups(Units, SN)

============================================================================*/

%MACRO dups(dsn, variable);
	%GLOBAL Num_Dups Num_Unique;
	PROC SORT DATA=&dsn; BY &variable; RUN;
	DATA &dsn._DP &dsn._ND &dsn._U; 
		SET &dsn; BY &variable;
   		IF FIRST.&variable AND LAST.&variable
        	THEN OUTPUT &DSN._ND;
       	ELSE OUTPUT &DSN._DP;
       	IF LAST.&variable THEN OUTPUT &DSN._U;
	RUN;
 %MEND Dups;





