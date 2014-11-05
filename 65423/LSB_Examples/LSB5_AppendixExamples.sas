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


/* Appendix */

/* Program 1 */

LIBNAME sports 'c:\MySASLib';
PROC SQL;
   CREATE TABLE sports.customer
      (CustomerNumber num,
       Name char(17),
       Address char(20));
   INSERT INTO sports.customer
      VALUES (101, 'Murphy''s Sports ', '115 Main St. ')
      VALUES (102, 'Sun N Ski ', '2106 Newberry Ave. ')
      VALUES (103, 'Sports Outfitters', '19 Cary Way ')
      VALUES (104, 'Cramer & Johnson ', '4106 Arlington Blvd.')
      VALUES (105, 'Sports Savers ', '2708 Broadway ');
   TITLE 'Sports Customer Data';
   SELECT *
      FROM sports.customer;

/* Program 2 */

LIBNAME sports 'c:\MySASLib';
DATA sports.customer;
   INPUT CustomerNumber Name $ 5-21 Address $ 23-42;
   DATALINES;
101 Murphy's Sports   115 Main St.
102 Sun N Ski         2106 Newberry Ave.
103 Sports Outfitters 19 Cary Way
104 Cramer & Johnson  4106 Arlington Blvd.
105 Sports Savers     2708 Broadway
   ;
PROC PRINT DATA = sports.customer;
   TITLE 'Sports Customer Data';
RUN;

/* Program 3 */

LIBNAME sports 'c:\MySASLib';
PROC SQL;
   TITLE 'Customer Number 102';
   SELECT *
      FROM sports.customer
      WHERE CustomerNumber = 102;

/* Program 4 */

LIBNAME sports 'c:\MySASLib';
DATA sunnski;
   SET sports.customer;
   IF CustomerNumber = 102;
PROC PRINT DATA = sunnski;
   TITLE 'Customer Number 102';
RUN;

/* Program 5 */

LIBNAME sports 'c:\MySASLib';
DATA outfitters;
   SET sports.customer;
   IF Name = 'Sports Outfitters';
PROC PRINT DATA = outfitters;
   TITLE 'Sports Outfitters';
RUN;

/* Program 6 */

LIBNAME sports 'c:\MySASLib';
DATA outfitters;
   SET sports.customer;
   WHERE Name = 'Sports Outfitters';
PROC PRINT DATA = outfitters;
   TITLE 'Sports Outfitters';
RUN;

/* Program 7 */

LIBNAME sports 'c:\MySASLib';
DATA outfitters (WHERE = (Name = 'Sports Outfitters'));
   SET sports.customer;
PROC PRINT DATA = outfitters;
   TITLE 'Sports Outfitters';
RUN;

/* Program 8 */

LIBNAME sports 'c:\MySASLib';
PROC PRINT DATA = sports.customer;
   WHERE Name = 'Sports Outfitters';
   TITLE 'Sports Outfitters';
RUN;

/* Program 9 */

LIBNAME sports 'c:\MySASLib';
PROC PRINT DATA = sports.customer (WHERE = (Name = 'Sports Outfitters'));
   TITLE 'Sports Outfitters';
RUN;
