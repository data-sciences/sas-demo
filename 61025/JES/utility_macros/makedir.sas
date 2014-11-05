/*================================================================
Macro: %makedir(newdir);
Source: Carpenter's Complete Guide, Second Edition, p. 251

Parameter: &newdir = path to directory you want to create

Action: This macro checks for the existence of the directory &newdir, 
		and creates  it if it doesn't exist. 

Example:

LIBNAME products "&JES.output\products";
%makedir(&JES.output\products)
LIBNAME products "&JES.output\products";
%sasver_os
%makedir(&JES.output&Slash.products)
%makedir(&JES.output&Slash.prod&Slash.gizmo)

===================================================================*/

%MACRO makedir(newdir);
	%LET rc=%SYSFUNC(FILEEXIST(&newdir));
	%IF &rc=0 %THEN %DO;
		%SYSEXEC mkdir &newdir;
	%END;
	%LET rc=%SYSFUNC(FILEEXIST(&newdir));
	%IF &rc=1 %THEN %PUT &newdir exists;
%MEND makedir;


	
