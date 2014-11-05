 /*-------------------------------------------------------------------*/
 /*       The Little SAS(r) Book: A Primer, Fifth Edition             */
 /*          by Lora D. Delwiche and Susan J. Slaughter               */
 /*       Copyright(c) 2012 by SAS Institute Inc., Cary, NC, USA      */
 /*                   SAS Publications order                          */
 /*                   ISBN 978-1-61290-343-9                          */
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
 /* Date Last Updated: 30SEP2012                                      */
 /*-------------------------------------------------------------------*/
 /* Questions or problem reports concerning this material may be      */
 /* addressed to the author:                                          */
 /*                                                                   */
 /* SAS Institute Inc.                                                */
 /* SAS Press                                                         */
 /* Attn: Lora Delwiche and Susan Slaughter                           */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  saspress@sas.com           */
 /* Use this for subject field:                                       */
 /*     Comments for Lora Delwiche and Susan Slaughter                */
 /*                                                                   */
 /*-------------------------------------------------------------------*/


/* Chapter 5 */


/* Section 5.2 */
/* First Program */	

DATA giant;
   INFILE 'c:\MyRawData\GiantTom.dat' DSD;
   INPUT Name :$15. Color $ Days Weight @@;
RUN;
* Trace PROC MEANS;
ODS TRACE ON;
PROC MEANS DATA = giant;
   BY Color;
RUN;
ODS TRACE OFF;

/* Section 5.2 */
/* Second Program */	

PROC MEANS DATA = giant;
   BY Color;
ODS SELECT Means.ByGroup1.Summary;
RUN;


/* Section 5.3 */
/* First Program */

DATA giant;
   INFILE 'c:\MyRawData\GiantTom.dat' DSD;
   INPUT Name :$15. Color $ Days Weight @@;
RUN;
ODS TRACE ON;
PROC TABULATE DATA = giant;
   CLASS Color;
   VAR Days Weight;
   TABLE Color ALL, (Days Weight) * MEAN;
RUN;
ODS TRACE OFF;

/* Section 5.3 */
/* Second Program */

PROC TABULATE DATA = giant;
   CLASS Color;
   VAR Days Weight;
   TABLE Color ALL, (Days Weight) * MEAN;
   TITLE 'Standard TABULATE Output';
ODS OUTPUT Table = tabout;
RUN;
PROC PRINT DATA = tabout;
   TITLE 'OUTPUT SAS Data Set from TABULATE';
RUN;


/* Section 5.4 */
/* Program */

* Create the text output and remove procedure name;
ODS LISTING; ODS NOPROCTITLE;
DATA marine;
   INFILE 'c:\MyRawData\Lengths8.dat';
   INPUT Name $ Family $ Length @@;
RUN;
PROC MEANS DATA = marine MEAN MIN MAX;
   CLASS Family;
   TITLE 'Whales and Sharks';
RUN;
PROC PRINT DATA = marine;
RUN;


/* Section 5.5 */
/* Program */

* Create the HTML files and remove procedure name;
ODS HTML STYLE = D3D  BODY = 'c:\MyHTMLFiles\Marine.html'
      FRAME = 'c:\MyHTMLFiles\MarineFrame.html'
      CONTENTS = 'c:\MyHTMLFiles\MarineTOC.html';
ODS NOPROCTITLE;
DATA marine;
   INFILE 'c:\MyRawData\Lengths8.dat';
   INPUT Name $ Family $ Length @@;
RUN;
PROC MEANS DATA = marine MEAN MIN MAX;
   CLASS Family;
   TITLE 'Whales and Sharks';
RUN;
PROC PRINT DATA = marine;
RUN;
ODS HTML CLOSE;


/* Section 5.6 */
/* Program */

* Create an RTF file;
ODS RTF FILE = 'c:\MyRTFFiles\Marine.rtf' BODYTITLE STARTPAGE = NO;
ODS NOPROCTITLE;
DATA marine;
   INFILE 'c:\MyRawData\Lengths8.dat';
   INPUT Name $ Family $ Length @@;
RUN;
PROC MEANS DATA = marine MEAN MIN MAX;
   CLASS Family;
   TITLE 'Whales and Sharks';
RUN;
PROC PRINT DATA = marine;
RUN;
* Close the RTF file;
ODS RTF CLOSE;


/* Section 5.7 */
/* Program */

* Create the PDF file;
ODS PDF FILE = 'c:\MyPDFFiles\Marine.pdf' STARTPAGE = NO;
ODS NOPROCTITLE;
DATA marine;
   INFILE 'c:\MyRawData\Lengths8.dat';
   INPUT Name $ Family $ Length @@;
RUN;
PROC MEANS DATA = marine MEAN MIN MAX;
   CLASS Family;
   TITLE 'Whales and Sharks';
RUN;
PROC PRINT DATA = marine;
RUN;
* Close the PDF file;
ODS PDF CLOSE;


/* Section 5.8 */
/* Program */

* Demonstrate styles of titles;
DATA marine;
   INFILE 'c:\MyRawData\Lengths8.dat';
   INPUT Name $ Family $ Length @@;
RUN;
PROC PRINT DATA = marine;
TITLE COLOR=BLACK 'Black  ' COLOR=GRAY 'Gray  ' COLOR=LTGRAY 'Light Gray';
TITLE2 BCOLOR='#C0C0C0' 'This Title Has a Gray Background';
TITLE3 HEIGHT=12PT 'Small  ' HEIGHT=.25IN 'Medium  ' HEIGHT=1CM 'Large';
TITLE4 JUSTIFY=LEFT 'Left ' JUSTIFY=CENTER 'vs. ' JUSTIFY=RIGHT 'Right';
TITLE5 'Default    ' FONT=Arial 'Arial    ' 
   FONT='Times New Roman' 'Times New Roman    ' FONT=Courier 'Courier';
TITLE6 FONT=Courier 'Courier  ' BOLD 'Courier Bold  ' 
   ITALIC 'Courier Bold and Italic';
RUN;


/* Section 5.9 */
/* First Program */

DATA skating;
   INFILE 'c:\MyRawData\Women5000.csv' DSD MISSOVER;
   INPUT Year Name :$20. Country $ Time $ Record $;
RUN;
PROC PRINT DATA = skating;
   TITLE 'Women''s 5000 Meter Speed Skating';
   ID Year;
RUN;

/* Section 5.9 */
/* Second Program */

PROC PRINT DATA = skating 
           STYLE(DATA) = {BACKGROUND = GRAY FOREGROUND = WHITE};
   TITLE 'Women''s 5000 Meter Speed Skating';
   VAR Name Country Time;
   VAR Record/STYLE(DATA) = {FONT_STYLE = ITALIC JUST = CENTER};
   ID Year;
RUN;


/* Section 5.10 */
/* First Program */

DATA skating;
   INFILE 'c:\MyRawData\Speed.dat' DSD;
   INPUT Name :$20. Country $ NumYears NumGold @@;
RUN;
PROC REPORT DATA = skating NOWINDOWS;
   COLUMN Country Name NumGold;
   DEFINE Country / GROUP;
   TITLE 'Olympic Women''s Speed Skating';
RUN;

/* Section 5.10 */
/* Second Program */

* STYLE= option in PROC and DEFINE statements;
PROC REPORT DATA = skating NOWINDOWS SPANROWS 
      STYLE(COLUMN) = {BACKGROUND = GRAY FOREGROUND = WHITE};
   COLUMN Country Name NumGold;
   DEFINE Country / GROUP 
      STYLE(COLUMN) = {FONT_STYLE = ITALIC JUST = CENTER};
   TITLE 'Olympic Women''s Speed Skating';
RUN;


/* Section 5.11 */
/* First Program */

DATA skating;
   INFILE 'c:\MyRawData\Records.dat';
   INPUT Year  Event $ Record $ @@;
RUN;
PROC TABULATE DATA = skating;
   CLASS Year Record;
   TABLE Year = '',Record*N = '';
   TITLE 'Men''s Speed Skating Olympic Records';
RUN;

/* Section 5.11 */
/* Second Program */

PROC TABULATE DATA = skating
      STYLE = {BACKGROUND = GRAY FOREGROUND = WHITE JUST = CENTER}; 
   CLASS Year Record;
   TABLE Year = '',Record*N = '';
   TITLE 'Men''s Speed Skating Olympic Records';
RUN;


/* Section 5.12 */
/* First Program */

DATA results;
   INFILE 'c:\MyRawData\Mens5000.dat' DSD;
   INPUT Place Name :$20. Country :$15. Time ;
RUN;
PROC PRINT DATA = results;
   ID Place;
   TITLE 'Men''s 5000m Speed Skating';
RUN;

/* Section 5.12 */
/* Second Program */	

PROC FORMAT;
   VALUE rec 0 -< 378.72 = 'LIGHT GRAY'
             378.72 -< 382.20 = 'VERY LIGHT GRAY'
             382.20 - HIGH = 'WHITE';
RUN;
PROC PRINT DATA = results;
   ID Place;
   VAR Name Country;
   VAR Time / STYLE = {BACKGROUND = rec.};
   TITLE 'Men''s 5000m Speed Skating';
RUN;
