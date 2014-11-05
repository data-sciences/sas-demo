/*==========================================================
Macro: %delvars:
Source: Carpenters Complete Guide to the SAS Macro Language,  
        Second Edition, p. 357 
		(adapted to exclude and &JES and variables beginning with &SYS... from deletion)
Action: Deletes all user-defined global macro variables
        - Except: &JES and variables beginning with &SYS
Example:
		%delvars
        %LET a=1; %LET b=2;
        %PUT _GLOBAL_;
        %delvars
        %PUT _GLOBAL_;
======================================================*/

%MACRO delvars;
	DATA Vars; SET SASHELP.VMACRO; RUN;
 	DATA _NULL_; SET VARS;
    	IF Scope='GLOBAL' THEN DO;
  			IF Name NE "JES"  AND SUBSTR(Name,1,3) NE "SYS"
          	THEN DO;
				CALL EXECUTE('%SYMDEL '||TRIM(LEFT(Name))||';');
        	END;
   		END;
	RUN;
%MEND delvars; 


