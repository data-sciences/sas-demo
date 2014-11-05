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

/* Chapter 10 */

/* Section 10.3 */

/* First Program */

LIBNAME travel 'c:\MySASLib';
DATA travel.golf;
   INFILE 'c:\MyRawData\Golf.dat';
   INPUT CourseName $18. NumberOfHoles Par Yardage GreenFees;
RUN;

/* Second Program */

LIBNAME travel 'c:\MySASLib';
* Create Tab-delimited file;
PROC EXPORT DATA = travel.golf OUTFILE = 'c:\MyRawData\Golf.txt' REPLACE;
RUN;


/* Section 10.4 */

/* First Program */
LIBNAME travel 'c:\MySASLib';
DATA travel.golf;
   INFILE 'c:\MyRawData\Golf.dat';
   INPUT CourseName $18. NumberOfHoles Par Yardage GreenFees;
RUN;


/* Second Program */
LIBNAME travel 'c:\MySASLib';
* Create Microsoft Excel file';
PROC EXPORT DATA=travel.golf OUTFILE = 'c:\MyExcel\Golf.xls' DBMS=EXCEL REPLACE;
RUN;


/* Section 10.5 */

/* First Program */
LIBNAME travel 'c:\MySASLib';
DATA travel.golf;
   INFILE 'c:\MyRawData\Golf.dat';
   INPUT CourseName $18. NumberOfHoles Par Yardage GreenFees;
RUN;

/* Second Program */
LIBNAME travel 'c:\MySASLib';
DATA _NULL_;
   SET travel.golf;
   FILE 'c:\MyRawData\Newfile.dat';
   PUT CourseName 'Golf Course' @32 GreenFees DOLLAR7.2 @40 'Par ' Par;
RUN;


/* Section 10.6 */

/* First Program */
LIBNAME travel 'c:\MySASLib';
ODS CSV FILE='c:\MyCSVFiles\golfinfo.csv'; 
PROC PRINT DATA = travel.golf;
   TITLE 'Golf Course Information';
RUN;
ODS CSV CLOSE;


/* Second Program */
LIBNAME travel 'c:\MySASLib';
ODS HTML FILE='c:\MyHTMLFiles\golfinfo.html'; 
PROC PRINT DATA = travel.golf NOOBS;
   TITLE 'Golf Course Information';
RUN;
ODS HTML CLOSE;



