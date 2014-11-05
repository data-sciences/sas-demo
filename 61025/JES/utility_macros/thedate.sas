/*==========================================================
Macro:	%theDate;
Action: Creates two global macro variables
		  &theDate = Date when the macro is run
		  %theDateTime = Date and time when the macro is run
Example:
	%theDate;
	%PUT theDate = [&theDate] theDateTime=[&theDateTime];
==========================================================*/

%MACRO theDate;
	%GLOBAL theDate theDateTime;
	DATA _NULL_;
		CALL SYMPUT('theDate', PUT(TODAY(),DATE9.));
		CALL SYMPUT('theDateTime', PUT(DATETIME(),DATETIME20.));
	RUN;
%MEND theDate;
