
/*=====================================================
Macro: %my_SYMBOLs(H=2, W=1, I=JOIN);
Action: Run SYMBOL1,...,SYMBOL10 statements
Parameters: 
	H = HEIGHT of SYMBOLs
	W = WIDTH of SYMBOLs
	I = VALUE of INTERPOLATE option
		- NONE, JOIN, STEPJ, SM40 etc
Example:

DATA A; DO Y=1 TO 10;
	X=Y; OUTPUT; X=Y+5; OUTPUT; END;
RUN;

PROC DATASETS MEMTYPE=CAT NOLIST; DELETE GSEG; RUN; QUIT;
FILENAME Fig "c:\JES\figures\Chapter_11\";
GOPTIONS RESET=ALL BORDER; 
GOPTIONS DEVICE=PSLEPSFC XMAX=6IN YMAX=4IN GSFNAME=Fig GSFMODE=REPLACE;  

GOPTIONS GUNIT=PCT HTEXT=3 FTEXT='Arial';
%my_symbols(H=3, W=2, I=JOIN)
%foot_note(Note=Test of my_symbols macro)
TITLE1 H=4 "my_symbols Example";
PROC GPLOT DATA=A;
	PLOT Y*X=Y / NAME="F11_1_";
RUN; QUIT;

=====================================================*/

  %MACRO my_symbols(H=2, W=1, I=JOIN);

   SYMBOL1  VALUE='PLUS'      HEIGHT=&H  COLOR=green  W=&W I=&I ;
   SYMBOL2  VALUE='x'         HEIGHT=&H  COLOR=red    W=&W I=&I ;
   SYMBOL3  VALUE='star'      HEIGHT=&H  COLOR=blue   W=&W I=&I ;
   SYMBOL4  VALUE='square'    HEIGHT=&H  COLOR=brown  W=&W I=&I ;
   SYMBOL5  VALUE='diamond'   HEIGHT=&H  COLOR=black  W=&W I=&I ;

   SYMBOL6  VALUE='triangle' HEIGHT=&H  COLOR=brown  W=&W I=&I ;
   SYMBOL7  VALUE='hash'     HEIGHT=&H  COLOR=orange W=&W I=&I ;
   SYMBOL8  VALUE='Y'        HEIGHT=&H  COLOR=violet W=&W I=&I ;
   SYMBOL9  VALUE='Z'        HEIGHT=&H  COLOR=cyan   W=&W I=&I ;
   SYMBOL10 VALUE='paw'      HEIGHT=&H  COLOR=violet W=&W I=&I ;

   SYMBOL11  VALUE='point'   HEIGHT=&H  COLOR=green  W=&W I=&I ;
   SYMBOL12  VALUE='dot'     HEIGHT=&H  COLOR=red    W=&W I=&I ;
   SYMBOL13  VALUE='circle'  HEIGHT=&H  COLOR=blue   W=&W I=&I ;
   SYMBOL14  VALUE='_'       HEIGHT=&H  COLOR=brown  W=&W I=&I ;
   SYMBOL15  VALUE='"'       HEIGHT=&H  COLOR=black  W=&W I=&I ;

   SYMBOL16  VALUE='#'      HEIGHT=&H  COLOR=brown  W=&W I=&I ;
   SYMBOL17  VALUE='$'      HEIGHT=&H  COLOR=orange W=&W I=&I ;
   SYMBOL18  VALUE='%'      HEIGHT=&H  COLOR=violet W=&W I=&I ;
   SYMBOL19  VALUE='&'      HEIGHT=&H  COLOR=cyan   W=&W I=&I ;
   SYMBOL20  VALUE="'"      HEIGHT=&H  COLOR=violet W=&W I=&I ;

   SYMBOL21  VALUE='='      HEIGHT=&H  COLOR=green  W=&W I=&I ;
   SYMBOL22  VALUE='-'      HEIGHT=&H  COLOR=red    W=&W I=&I ;
   SYMBOL23  VALUE='@'      HEIGHT=&H  COLOR=blue   W=&W I=&I ;
   SYMBOL24  VALUE='*'      HEIGHT=&H  COLOR=brown  W=&W I=&I ;
   SYMBOL25  VALUE='+'      HEIGHT=&H  COLOR=black  W=&W I=&I ;

   SYMBOL26  VALUE='>'      HEIGHT=&H  COLOR=brown  W=&W I=&I ;
   SYMBOL27  VALUE='.'      HEIGHT=&H  COLOR=orange W=&W I=&I ;
   SYMBOL28  VALUE='<'      HEIGHT=&H  COLOR=violet W=&W I=&I ;
   SYMBOL29  VALUE=','      HEIGHT=&H  COLOR=cyan   W=&W I=&I ;
   SYMBOL30  VALUE='/'      HEIGHT=&H  COLOR=violet W=&W I=&I ;

   SYMBOL31  VALUE='?'      HEIGHT=&H  COLOR=orange W=&W I=&I ;
   SYMBOL32  VALUE='('      HEIGHT=&H  COLOR=violet W=&W I=&I ;
   SYMBOL33  VALUE=')'      HEIGHT=&H  COLOR=cyan   W=&W I=&I ;
   SYMBOL34  VALUE=':'      HEIGHT=&H  COLOR=violet W=&W I=&I ;
 %MEND my_SYMBOLs;



