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


/* Chapter 3 */

/* Section 3.1 */
/* Program */

* Modify homegarden data set with assignment statements;
DATA homegarden;
   INFILE 'c:\MyRawData\Garden.dat';
   INPUT Name $ 1-7 Tomato Zucchini Peas Grapes;
   Zone = 14;
   Type = 'home';
   Zucchini = Zucchini * 10;
   Total = Tomato + Zucchini + Peas + Grapes;
   PerTom = (Tomato / Total) * 100;
RUN;
PROC PRINT DATA = homegarden;
   TITLE 'Home Gardening Survey';
RUN;


/* Section 3.2 */
/* Program */

DATA contest;
   INFILE 'c:\MyRawData\Pumpkin.dat';
   INPUT Name $16. Age 3. +1 Type $1. +1 Date MMDDYY10.
         (Scr1 Scr2 Scr3 Scr4 Scr5) (4.1);
   AvgScore = MEAN(Scr1, Scr2, Scr3, Scr4, Scr5);
   DayEntered = DAY(Date);
   Type = UPCASE(Type);
RUN;
PROC PRINT DATA = contest;
   TITLE 'Pumpkin Carving Contest';
RUN;


/* Section 3.5 */
/* Program */

DATA oldcars;
   INFILE 'c:\MyRawData\Auction.dat';
   INPUT Make $ 1-13 Model $ 15-29 YearMade Seats MillionsPaid;
   IF YearMade < 1890 THEN Veteran = 'Yes';
   IF Model = 'F-88' THEN DO;
      Make = 'Oldsmobile';
      Seats = 2;
   END;
RUN;
PROC PRINT DATA = oldcars;
   TITLE 'Cars Sold at Auction';
RUN;


/* Section 3.6 */
/* Program */

* Group observations by cost;
DATA homeimprovements;
   INFILE 'c:\MyRawData\Home.dat';
   INPUT Owner $ 1-7 Description $ 9-33 Cost;
   IF Cost = . THEN CostGroup = 'missing';
      ELSE IF Cost < 2000 THEN CostGroup = 'low';
      ELSE IF Cost < 10000 THEN CostGroup = 'medium';
      ELSE CostGroup = 'high';
RUN;
PROC PRINT DATA = homeimprovements;
   TITLE 'Home Improvement Cost Groups';
RUN;


/* Section 3.7 */
/* Program */

* Choose only comedies;
DATA comedy;
   INFILE 'c:\MyRawData\Shakespeare.dat';
   INPUT Title $ 1-26 Year Type $;
   IF Type = 'comedy';
RUN;
PROC PRINT DATA = comedy;
   TITLE 'Shakespearean Comedies';
RUN;


/* Section 3.8 */
/* Program */

DATA librarycards;
   INFILE 'c:\MyRawData\Library.dat' TRUNCOVER;
   INPUT Name $11. + 1 BirthDate MMDDYY10. +1 IssueDate ANYDTDTE10.
      DueDate DATE11.;
   DaysOverDue = TODAY() - DueDate;
   CurrentAge = INT(YRDIF(BirthDate, TODAY(), 'AGE'));
   IF IssueDate > '01JAN2012'D THEN NewCard = 'yes';
RUN;
PROC PRINT DATA = librarycards;
   FORMAT Issuedate MMDDYY8. DueDate WEEKDATE17.;
   TITLE 'SAS Dates without and with Formats';
RUN;


/* Section 3.10 */
/* Program */

* Using RETAIN and sum statements to find most runs and total runs;
DATA gamestats;
   INFILE 'c:\MyRawData\Games.dat';
   INPUT Month 1 Day 3-4 Team $ 6-25 Hits 27-28 Runs 30-31;
   RETAIN MaxRuns;
   MaxRuns = MAX(MaxRuns, Runs);
   RunsToDate + Runs;
RUN;
PROC PRINT DATA = gamestats;
   TITLE "Season's Record to Date";
RUN;


/* Section 3.11*/
/* Program */

* Change all 9s to missing values;
DATA songs;
   INFILE 'c:\MyRawData\KBRK.dat';
   INPUT City $ 1-15 Age wj kt tr filp ttr;
   ARRAY song (5) wj kt tr filp ttr;
   DO i = 1 TO 5;
      IF song(i) = 9 THEN song(i) = .;
   END;
RUN;
PROC PRINT DATA = songs;
   TITLE 'KBRK Song Survey';
RUN;


/* Section 3.12 */
/* Program */

DATA songs;
   INFILE 'c:\MyRawData\KBRK.dat';
   INPUT City $ 1-15 Age wj kt  tr filp ttr;
   ARRAY new (5) Song1 - Song5;
   ARRAY old (5) wj -- ttr;
   DO i = 1 TO 5;
      IF old(i) = 9 THEN new(i) = .;
         ELSE new(i) = old(i);
   END;
   AvgScore = MEAN(OF Song1 - Song5);
PROC PRINT DATA = songs;
   TITLE 'KBRK Song Survey';
RUN;
