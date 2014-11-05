/*=============================================================
Macro: %sasver_os;
Action: Define macro variables
	&SASver = SAS Version (8 or 9)
	&SASver  = SAS Version and ReleaseNumber (e.g. 9_1, 9_2)
	&OS = operating system (PC or UNIX)
	&Slash = Slash appropriate for operating system (\ or /)

Example:
%sasver_os
%PUT OS=[&OS] Slash=[&Slash] SASver=[&SASver] SASnum=[&SASnum];

==============================================================*/


%MACRO sasver_os;
	%GLOBAL OS Slash SASver SASnum;
	%LET SASver=%SUBSTR(&SYSVER,1,1); 
	%LET SASnum=&SASver._%SUBSTR(&SYSVER,3,1);
	%LET OS=UNIX;
	%IF (&SYSSCP=WIN) %THEN %LET OS = PC;
	%IF "&OS"="PC"    %THEN %LET Slash = \;
	%IF "&OS"="UNIX"  %THEN %LET Slash = /;
%MEND sasver_os; 	


