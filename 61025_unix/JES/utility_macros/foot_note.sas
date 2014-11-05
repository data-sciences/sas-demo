/*===========================================================
Macro: %Foot_Note(H=1, Note=Note);
Action: Creates a footnote including 
		- your name, the date, and an optional note
Parameters:
	Height = Height of font to be used to print the Footnote
	Note   = Any text you want to add to the footnote
Example:
 	DATA A; DO i=1 TO 10; x=i*i; OUTPUT; END; RUN;
 	GOPTIONS RESET=ALL GUNIT=PCT HTEXT=3 FTEXT='Arial';
	%Foot_Note(H=3, Note=Foot_Note Example);
	PROC GPLOT DATA=A; PLOT x*i; RUN; QUIT;
	%Foot_Note;
	PROC GPLOT DATA=A; PLOT x*i; RUN; QUIT;
============================================================*/

%MACRO Foot_Note(H=3, Note=);
   %theDate
   FOOTNOTE HEIGHT=&H JUSTIFY=LEFT "&Note   " 
	  JUSTIFY=RIGHT "(Your Name Here) &theDate";
%MEND Foot_Note;

