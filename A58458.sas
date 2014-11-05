 /*-------------------------------------------------------------------*/
 /*           Quick Results with the Output Delivery System           */
 /*                         by Sunil Gupta                            */
 /*       Copyright(c) 2003 by SAS Institute Inc., Cary, NC, USA      */
 /*                   SAS Publications order # 58458                  */
 /*                        ISBN 1-59047-163-6                         */
 /*-------------------------------------------------------------------*/
 /*                                                                   */
 /* This material is provided "as is" by SAS Institute Inc.  There    */
 /* are no warranties, expressed or implied, as to merchantability or */
 /* fitness for a particular purpose regarding the materials or code  */
 /* contained herein. The Institute is not responsible for errors     */
 /* in this material as it now exists or will exist, nor does the     */
 /* Institute provide technical support for it.                       */
 /*                                                                   */
 /*-------------------------------------------------------------------*/
 /* Questions or problem reports concerning this material may be      */
 /* addressed to the author:                                          */
 /*                                                                   */
 /* SAS Institute Inc.                                                */
 /* Books by Users                                                    */
 /* Attn: Sunil Gupta                                                 */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  sasbbu@sas.com             */
 /* Use this for subject field:                                       */
 /*     Comments for Sunil Gupta                                      */
 /*                                                                   */
 /*-------------------------------------------------------------------*/
 /* Date Last Updated:  February 18, 2003                             */
 /*-------------------------------------------------------------------*/


/* -------------- Appendix - DEMOG sample Data set --------------- */

libname mylib 'c:\odsrslts';

data mylib.demog;
  input patient $3. gender 3. height 4.1 weight 4. age 5.1 
        race 3. drug $7.;
  format height age 4.1;
  label patient='Patient' gender='Sex' height='Height'
        weight='Weight' age='Age' race='Race' drug='Drug';
datalines;
001 1 74.4 257 67.9 1 Active
002 1 63.1 168 36.7 0 Active
003 1 69.6 264 74.6 0 Placebo
004 1 63.2 270 73.8 1 Placebo
005 1 67.8 209 57.8 1 Active
006 0 56.7 116 47.5 1 Active
007 1 70.4 150 47.8 1 Active
008 1 68.5 172 82.6 1 Active
009 0 66.4 212 25.1 0 Active
010 1 68.1 216 60.6 1 Placebo
011 1 62.8 193 80.0 1 Active
012 1 73.6 198 77.4 1 Active
013 0 59.8 117 72.3 1 Active
014 0 74.7 179 37.4 0 Placebo
015 1 73.0 195 21.4 1 Active
016 1 57.7 213 27.3 1 Active
017 1 59.9 199 43.1 1 Active
018 1 70.2 219 67.3 0 Active
019 1 68.6 236 62.2 1 Placebo
020 1 70.7 255 66.4 1 Active
021 1 71.6 228 27.3 1 Active
022 1 58.9 111 68.3 1 Active
023 1 65.7 194 67.1 0 Active
024 1 63.2 234 65.2 0 Active
025 1 72.4 162 56.1 0 Placebo
;
run;


/* ---------  Chapter 2 - Writing to Report Generation Destinations  --------- */

/* ---------- Example 2.1:  How to create HTML files  ------------------------------*/

ODS LISTING CLOSE;
ODS HTML FILE = 'C:\ODSRSLTS\BODY.HTML';
        
PROC UNIVARIATE DATA=DEMOG;
     VAR WEIGHT;
RUN; 

ODS HTML CLOSE;
ODS LISTING;


/* Example 2.2:  How to create body, contents, and frame files for better navigation */

ODS HTML  
   PATH = 'C:\ODSRSLTS\' (URL=NONE)
   BODY = 'BODY.HTML' 
   CONTENTS = 'CONTENTS.HTML' 
   FRAME = 'FRAME.HTML' 
   NEWFILE = NONE;
        
PROC UNIVARIATE DATA=DEMOG;
     VAR WEIGHT;
RUN;
ODS HTML CLOSE;


/* Example 2.3: How to create graphs in HTML files */

DATA DEMOG;
     SET DEMOG;
     LENGTH HTMLVARIABLE $ 40;

     HTMLVARIABLE = 'HREF=' || TRIM(DRUG) || '.HTML';
RUN;

ODS LISTING CLOSE;
ODS HTML
  PATH     ='C:\ODSRSLTS\' (URL=NONE)
  BODY     ='GRAPH_BODY.HTML'
 ;
GOPTIONS DEVICE=GIF HSIZE=5IN VSIZE=2.5IN;

PATTERN1 V=EMPTY C=RED;
PATTERN2 V=X3 C=RED;

TITLE 'SUMMARY LEVEL: AVERAGE WEIGHT BY DRUG';
PROC GCHART DATA=DEMOG;
     VBAR DRUG / SUMVAR=WEIGHT TYPE=MEAN
                               SUBGROUP=DRUG
                               HTML=HTMLVARIABLE;
     WHERE DRUG IN ('Active' 'Placebo');
RUN;
QUIT;
ODS HTML CLOSE;

ODS HTML
  PATH     ='C:\ODSRSLTS\' (URL=NONE)
  BODY     ='ACTIVE.HTML'  ;

TITLE 'DETAIL LEVEL: LISTING OF ACTIVE PATIENTS'; 
FOOTNOTE '<A HREF="GRAPH_BODY.HTML">BACK</A>';

PROC PRINT DATA=DEMOG;
     VAR PATIENT DRUG WEIGHT GENDER RACE AGE HEIGHT;  

     WHERE DRUG='Active';
RUN;

ODS HTML CLOSE;

ODS HTML
  PATH     ='C:\ODSRSLTS\' (URL=NONE)
  BODY     ='PLACEBO.HTML'  ; 

TITLE 'DETAIL LEVEL: LISTING OF PLACEBO PATIENTS'; 
FOOTNOTE '<A HREF="GRAPH_BODY.HTML">BACK</A>';

PROC PRINT DATA=DEMOG;
     VAR PATIENT DRUG WEIGHT GENDER RACE AGE HEIGHT;  
     WHERE DRUG='Placebo';
RUN;
TITLE;
FOOTNOTE;

ODS HTML CLOSE;


/* Example 2.4:  How to create an RTF File */

OPTIONS ORIENTATION = LANDSCAPE NOCENTER NODATE;
ODS RTF FILE='C:\ODSRSLTS\DRUG.RTF'; 

TITLE  'Drug Freqs' ;
FOOTNOTE1 'Active = Drug A, Placebo = Drug B';
FOOTNOTE2 'BioTech Inc., confidential 2001'; 

PROC FREQ DATA=DEMOG;
    TABLES DRUG;
RUN;
ODS RTF CLOSE; 


/* Example 2.5:  How to format text in RTF Files */

OPTIONS ORIENTATION = LANDSCAPE NOCENTER NODATE NONUMBER;  
ODS ESCAPECHAR = "^"; 
ODS RTF FILE='C:\ODSRSLTS\DRUG_FORMATTED.RTF' STARTPAGE=YES;

TITLE j=l "Drug Freqs^{super a}"
      j=r "{Page}  {\field{\*\fldinst{ PAGE }}}   
           \~{of}\~{\field{\*\fldinst { NUMPAGES }}}" ;
FOOTNOTE1 '^{super a}Active = Drug A, Placebo = Drug B'; 
FOOTNOTE2 '^{sub BioTech Inc., confidential 2001}'; 

PROC FREQ DATA=DEMOG;
   TABLES DRUG;
RUN;
ODS RTF CLOSE; 


/* Example 2.6:  How to create PDF files */

OPTIONS ORIENTATION = LANDSCAPE NOCENTER;  
         
ODS PDF FILE='C:\ODSRSLTS\DRUG.PDF';

TITLE  'Drug Freqs';  
FOOTNOTE1 'Active = Drug A, Placebo = Drug B';
FOOTNOTE2 'BioTech Inc., confidential 2001'; 

PROC FREQ DATA=DEMOG;
   TABLES DRUG;
RUN;

ODS PDF CLOSE;


/* Example 2.7:  How to create printer, PS, PDF and PCL files simultaneously */

OPTIONS ORIENTATION = LANDSCAPE NOCENTER;  
ODS ESCAPECHAR = "^";              

ODS PRINTER (ID=1);
ODS PS  FILE='C:\ODSRSLTS\DRUG.PS';
ODS PDF FILE='C:\ODSRSLTS\DRUG.PDF';
ODS PRINTER (ID=2) PRINTER='PCL5' 
                   FILE='C:\ODSRSLTS\DRUG.PCL' SAS;

TITLE  'Drug Freqs^{super a}';  
FOOTNOTE1 '^{super a}Active = Drug A, Placebo = Drug B';
FOOTNOTE2 '^{sub BioTech Inc., confidential 2001}'; 

PROC FREQ DATA=DEMOG;
   TABLES DRUG;
RUN;

ODS PRINTER (ID=2) CLOSE;
ODS PDF CLOSE;            
ODS PS CLOSE;
ODS PRINTER (ID=1) CLOSE; 


/* Example 2.5:  How to save output from several SAS procedures to HTML files */

ODS HTML 
PATH = 'C:\ODSRSLTS\' (URL=NONE)
        BODY = 'BODY2.HTML' 
        CONTENTS = 'CONTENTS2.HTML'
        FRAME = 'FRAME2.HTML' ;

PROC FREQ DATA=DEMOG; 
     TABLES DRUG;
RUN;

PROC UNIVARIATE DATA=DEMOG;
     VAR WEIGHT;
RUN;
ODS HTML CLOSE;


/* Example 2.6:  How to create an HTML file and an RTF file simultaneously */

ODS HTML FILE = 'C:\ODSRSLTS\DEMOG.HTML' ;
ODS RTF FILE= 'C:\ODSRSLTS\DEMOG.RTF' ; 

PROC UNIVARIATE DATA=DEMOG;
     VAR WEIGHT;
RUN;

ODS RTF CLOSE;
ODS HTML CLOSE;


/* ---------  Chapter 3 - Manipulating ODS Objects  ------------------------------- */


/* Example 3.1:  How to use the ODS TRACE statement */

ODS TRACE ON / LABEL LISTING; 

PROC UNIVARIATE DATA=DEMOG;
     VAR WEIGHT;
RUN;

ODS TRACE OFF; 


/* Example 3.2:  How to select objects by object name for the HTML destination */

OPTIONS NOCENTER;

ODS LISTING FILE='C:\ODSRSLTS\DEMOG.LST';
ODS HTML FILE = 'C:\ODSRSLTS\SELECT_DEMOG.HTML' ;

ODS HTML 
        SELECT BASICMEASURES;
ODS HTML SHOW;

 PROC UNIVARIATE DATA=DEMOG;
      VAR WEIGHT;
 RUN;
ODS HTML CLOSE;
ODS LISTING CLOSE;


/* Example 3.3:  How to select objects by object name for all destinations */

OPTIONS NOCENTER;

ODS LISTING FILE='C:\ODSRSLTS\SELECT_DEMOG.LST';
ODS HTML FILE = 'C:\ODSRSLTS\SELECT_DEMOG.HTML' ;

ODS 
        SELECT BASICMEASURES;
ODS SHOW;

 PROC UNIVARIATE DATA=DEMOG;
      VAR WEIGHT;
 RUN;
ODS HTML CLOSE;
ODS LISTING CLOSE;


/* Example 3.4: How to exclude objects */

ODS HTML FILE = 'C:\ODSRSLTS\EXCLUDE_DEMOG.HTML' ;
ODS HTML EXCLUDE BASICMEASURES;
ODS HTML SHOW;

PROC UNIVARIATE DATA=DEMOG;
     VAR WEIGHT;
RUN;
ODS HTML CLOSE;


/* Example 3.5: How to use the PERSIST option to maintain a selection list */

ODS HTML  FILE = 'C:\ODSRSLTS\SELECT_PERSIST_DEMOG.HTML' ;
ODS HTML SELECT BASICMEASURES(PERSIST) EXTREMEOBS;
ODS HTML SHOW;

TITLE 'RUN 1 - BasicMeasures and Extremeobs objects are selected';
PROC UNIVARIATE DATA=DEMOG;
     VAR WEIGHT;
RUN;
ODS HTML SHOW; 

TITLE 'RUN 2 - BasicMeasures object is still selected';
PROC UNIVARIATE DATA=DEMOG;
     VAR WEIGHT;
RUN;
ODS HTML CLOSE;


/* ---------  Chapter 4 - Writing to the Object Destination ----------------------- */

/* Example 4.1:  How to create SAS data sets with ODS */

ODS OUTPUT BASICMEASURES = MYLIB.MEASURE;
        
PROC UNIVARIATE DATA=DEMOG;
     VAR WEIGHT;
RUN;

ODS OUTPUT CLOSE;


/* Example 4.2:  How to create multiple SAS data sets with ODS */

ODS OUTPUT BASICMEASURES(MATCH_ALL = MEASURE_DSN) = MYLIB.MEASURE;
PROC UNIVARIATE DATA=DEMOG;
     VAR WEIGHT HEIGHT;
RUN;

ODS OUTPUT CLOSE;

%PUT The MEASURE_DSN macro variable contains the following data sets &MEASURE_DSN..;


/* ---------  Chapter 5 - Working with ODS Destinations and Objects ------- */

/* Example 5.1: Working with objects and several different destinations */
ODS HTML FILE = 'C:\ODSRSLTS\BASIC_DEMOG.HTML' ;
ODS HTML SELECT BASICMEASURES;

ODS RTF FILE= 'C:\ODSRSLTS\EXTREME_DEMOG.RTF' ;
ODS RTF SELECT EXTREMEOBS;

PROC UNIVARIATE DATA=DEMOG;
     VAR WEIGHT;
RUN;

ODS RTF CLOSE;
ODS HTML CLOSE;


/* Example 5.2: Working with several objects from the BY Statement */

PROC SORT DATA=DEMOG;
     BY DRUG;
RUN;

ODS HTML FILE='C:\ODSRSLTS\SELECT_WEIGHT_GROUP1_DEMOG.HTML'; 
ODS HTML SELECT UNIVARIATE.BYGROUP1.WEIGHT.BASICMEASURES;

PROC UNIVARIATE DATA=DEMOG;
     BY DRUG;
     VAR WEIGHT;
RUN;
ODS HTML CLOSE;


/* Example 5.3:  Working with several objects from several analysis variables */

ODS HTML FILE='C:\ODSRSLTS\SELECT_UNIVARIATE_DEMOG.HTML';

ODS HTML SELECT UNIVARIATE.WEIGHT.BASICMEASURES
                UNIVARIATE.HEIGHT.EXTREMEOBS;

PROC UNIVARIATE DATA=DEMOG;
     VAR WEIGHT HEIGHT;
RUN;
ODS HTML CLOSE;


/* ---------  Chapter 6 - Enhancing Reports with ODS Styles -------------------- */

/* Example 6.1:  Using ODS styles with destinations */

ODS HTML FILE='C:\ODSRSLTS\DEMOG_STYLE.HTML' STYLE=SASDOCPRINTER;

PROC UNIVARIATE DATA=DEMOG;
     VAR WEIGHT;
RUN;
ODS HTML CLOSE;



