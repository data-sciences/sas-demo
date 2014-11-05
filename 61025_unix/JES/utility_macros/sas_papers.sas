/*==========================================================================
Macro:  %sas_papers
Usage: 
	Edit the ~JES\docs\SUGI_Papers.csv file to add pdf files if desired
		Add any new pdf foles to ~JES\docs\pdfs
	Close the SUGI_Papers.csv file
	Run %sas_papers
	The ~\JES\docs\papers.html file will be updated

%SAS_papers
options mprint mlogic symbolgen; 
============================================================================*/

%MACRO SAS_papers;
PROC IMPORT DATAFILE="&JES.docs/SUGI_Papers.csv"
	OUT =Papers REPLACE ;
	GUESSINGROWS= 500 ;
RUN;
DATA Papers; SET Papers;
	ChapterTitle=TRANSLATE(ChapterTitle, ' ', ',');
RUN;
%MACRO Table_of_Papers(dsin, title, Chapter);
  ODS PROCLABEL="&title"; 
  TITLE2 H=5 "&Title";
  ODS NOPROCTITLE;
  PROC REPORT DATA=&dsin NOWINDOWS HEADLINE LS=256;
	COLUMN &Chapter Paper Author TITLE ;
	DEFINE &Chapter/ GROUP;
	DEFINE Paper/ DISPLAY;
	DEFINE Title / DISPLAY ;
	DEFINE Author / DISPLAY ;
	COMPUTE Paper;
		ref="./pdfs/"||TRIM(LEFT(Paper));
		CALL DEFINE (_COL_, 'URL', ref);
	ENDCOMP;
	BREAK AFTER &Chapter / SKIP;
  RUN;
%MEND Table_of_Papers;
ODS HTML PATH="&JES.docs" (URL=NONE)
	BODY ="papers_body.html" headtext="<base target=_blank>"
	CONTENTS="papers_toc.html"
	FRAME="papers.html" (TITLE="SAS Papers") STYLE=Minimal NEWFILE=PAGE;
	TITLE1 H=7  "Papers included with Just Enough SAS";
	FOOTNOTE;
	%Table_of_Papers(Papers, All Papers, Chapter);
	%DO i=1 %TO 12; 
		DATA Chapter; SET Papers(where=(Chapter=&i)); RUN;
		%IF %obscnt(Chapter)>0 %THEN %DO;
			PROC SQL NOPRINT; SELECT ChapterTitle INTO :Title FROM Chapter; QUIT: 
			%Table_of_Papers(Chapter, &Title, Chapter);
		%END;
	%END;
ODS HTML CLOSE;
%MEND sas_papers;

