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


/* Chapter 6 */

/* Section 6.1 */

/* First Program */
* Create permanent SAS data set trains; 
DATA 'c:\MySASLib\trains';    
   INFILE 'c:\MyRawData\Train.dat';    
   INPUT Time TIME5. Cars People; 
RUN;
	
/* Second Program */
* Read the SAS data set trains with a SET statement;
DATA averagetrain;
   SET 'c:\MySASLib\trains';
   PeoplePerCar = People / Cars;
RUN;
PROC PRINT DATA = averagetrain;
   TITLE 'Average Number of People per Train Car';
   FORMAT Time TIME5.;
RUN;


/* Section 6.2 */
	
/* Program */	
DATA southentrance;
   INFILE 'c:\MyRawData\South.dat';
   INPUT Entrance $ PassNumber PartySize Age;
PROC PRINT DATA = southentrance;
   TITLE 'South Entrance Data';
RUN;
DATA northentrance;
   INFILE 'c:\MyRawData\North.dat';
   INPUT Entrance $ PassNumber PartySize Age Lot;
PROC PRINT DATA = northentrance;
   TITLE 'North Entrance Data';
RUN; 

* Create a data set, both, combining northentrance and southentrance;
* Create a variable, AmountPaid, based on value of variable Age;
DATA both;
   SET southentrance northentrance;
   IF Age = . THEN AmountPaid = .;
      ELSE IF Age < 3  THEN AmountPaid = 0;
      ELSE IF Age < 65 THEN AmountPaid = 35;
      ELSE AmountPaid = 27;
RUN;
PROC PRINT DATA = both;
   TITLE 'Both Entrances';
RUN;


/* Section 6.3 */
/* Program */	
DATA southentrance;
   INFILE 'c:\MyRawData\South.dat';
   INPUT Entrance $ PassNumber PartySize Age;
PROC PRINT DATA = southentrance;
   TITLE 'South Entrance Data';
RUN;
DATA northentrance;
   INFILE 'c:\MyRawData\North.dat';
   INPUT Entrance $ PassNumber PartySize Age Lot;
PROC SORT DATA = northentrance;
   BY PassNumber;
PROC PRINT DATA = northentrance;
   TITLE 'North Entrance Data';
RUN;
* Interleave observations by PassNumber;
DATA interleave;
   SET northentrance southentrance;
   BY PassNumber;
RUN;
PROC PRINT DATA = interleave;
   TITLE 'Both Entrances, By Pass Number';
RUN;


/* Section 6.4 */

/* Program */

DATA descriptions;     
   INFILE 'c:\MyRawData\chocolate.dat' TRUNCOVER;    
   INPUT CodeNum $ 1-4 Name $ 6-14 Description $ 15-60; 
RUN;
DATA sales;    
   INFILE 'c:\MyRawData\chocsales.dat';    
   INPUT CodeNum $ 1-4 PiecesSold 6-7; 
PROC SORT DATA = sales;
   BY CodeNum;
RUN;
* Merge data sets by CodeNum;
DATA chocolates;    
   MERGE sales descriptions;    
   BY CodeNum;
RUN;
PROC PRINT DATA = chocolates;   
   TITLE "Today's Chocolate Sales"; 
RUN;


/* Section 6.5 */

/* Program */	
DATA regular;
   INFILE 'c:\MyRawData\Shoe.dat';
   INPUT Style $ 1-15 ExerciseType $ RegularPrice;
RUN;
PROC SORT DATA = regular;
   BY ExerciseType;
RUN;
DATA discount;
   INFILE 'c:\MyRawData\Disc.dat';
   INPUT ExerciseType $ Adjustment;
RUN;
* Perform many-to-one match merge;
DATA prices;
   MERGE regular discount;
   BY ExerciseType;
   NewPrice = ROUND(RegularPrice - (RegularPrice * Adjustment), .01);
RUN;
PROC PRINT DATA = prices;
   TITLE 'Price List for May';
RUN;


/* Section 6.6 */

/* Program */
DATA shoes;
   INFILE 'c:\MyRawData\Shoesales.dat';
   INPUT Style $ 1-15 ExerciseType $ Sales;
RUN;
PROC SORT DATA = shoes;
   BY ExerciseType;
RUN;
* Summarize sales by ExerciseType and print;
PROC MEANS NOPRINT DATA = shoes;
   VAR Sales;
   BY ExerciseType;
   OUTPUT OUT = summarydata SUM(Sales) = Total;
RUN;
PROC PRINT DATA = summarydata;
   TITLE 'Summary Data Set';
RUN;
* Merge totals with the original data set;
DATA shoesummary;
   MERGE shoes summarydata;
   BY ExerciseType;
   Percent = Sales / Total * 100;
RUN;
PROC PRINT DATA = shoesummary;
   BY ExerciseType;
   ID ExerciseType;
   VAR Style Sales Total Percent;
   TITLE 'Sales Share by Type of Exercise';
RUN;
	

/* Section 6.7 */
/* Program */
DATA shoes;
   INFILE 'c:\MyRawData\Shoesales.dat';
   INPUT Style $ 1-15 ExerciseType $ Sales;
RUN;
* Output grand total of sales to a data set and print;
PROC MEANS NOPRINT DATA = shoes;
   VAR Sales;
   OUTPUT OUT = summarydata SUM(Sales) = GrandTotal;
RUN;
PROC PRINT DATA = summarydata;
   TITLE 'Summary Data Set';
RUN;
* Combine the grand total with the original data;
DATA shoesummary;
   IF _N_ = 1 THEN SET summarydata;
   SET shoes;
   Percent = Sales / GrandTotal * 100;
RUN;
PROC PRINT DATA = shoesummary;
   VAR Style ExerciseType Sales GrandTotal Percent;
   TITLE 'Overall Sales Share';
RUN;


/* Section 6.8 */

/* First Program */	
LIBNAME perm 'c:\MySASLib';
DATA perm.patientmaster;
   INFILE 'c:\MyRawData\Admit.dat';
   INPUT Account LastName $ 8-16 Address $ 17-34
      BirthDate MMDDYY10. Sex $ InsCode $ 48-50 @52 LastUpdate MMDDYY10.;
RUN;


/* Second Program */
LIBNAME perm 'c:\MySASLib';
DATA transactions;
   INFILE 'c:\MyRawData\NewAdmit.dat';
   INPUT Account LastName $ 8-16 Address $ 17-34 BirthDate MMDDYY10. 
      Sex $ InsCode $ 48-50 @52 LastUpdate MMDDYY10.;
RUN;
PROC SORT DATA = transactions;
   BY Account;
RUN;
* Update patient data with transactions;
DATA perm.patientmaster;
   UPDATE perm.patientmaster transactions;
   BY Account;
RUN;
PROC PRINT DATA = perm.patientmaster;
   FORMAT BirthDate LastUpdate MMDDYY10.;
   TITLE 'Admissions Data';
RUN;


/* Section 6.9 */

/* Program */	
DATA morning afternoon;
   INFILE 'c:\MyRawData\Zoo.dat';
   INPUT Animal $ 1-9 Class $ 11-18 Enclosure $ FeedTime $;
   IF FeedTime = 'am' THEN OUTPUT morning;
      ELSE IF FeedTime = 'pm' THEN OUTPUT afternoon;
      ELSE IF FeedTime = 'both' THEN OUTPUT;
RUN;
PROC PRINT DATA = morning;
   TITLE 'Animals with Morning Feedings';
PROC PRINT DATA = afternoon;
   TITLE 'Animals with Afternoon Feedings';
RUN;

	
/* Section 6.10 */
/* First Program */	
* Create data for variables x and y;
DATA generate;
   DO x = 1 TO 6;
      y = x ** 2;
      OUTPUT;
   END;
PROC PRINT DATA = generate;
   TITLE 'Generated Data';
RUN;


/* Second Program */
* Create three observations for each data line read
*   using three OUTPUT statements;
DATA theaters;
   INFILE 'c:\MyRawData\Movies.dat';
   INPUT Month $ Location $ Tickets @;
   OUTPUT;
   INPUT Location $ Tickets @;
   OUTPUT;
   INPUT Location $ Tickets;
   OUTPUT;
RUN;
PROC PRINT DATA = theaters;
   TITLE 'Ticket Sales';
RUN;
	
	
/* Section 6.12 */

/* Program */
DATA customer;
   INFILE 'c:\MyRawData\CustAddress.dat' TRUNCOVER;
   INPUT CustomerNumber Name $ 5-21 Address $ 23-42;
DATA orders;
   INFILE 'c:\MyRawData\OrdersQ3.dat';
   INPUT CustomerNumber Total;
PROC SORT DATA = orders;
   BY CustomerNumber;
RUN;
* Combine the data sets using the IN= option;
DATA noorders;
   MERGE customer orders (IN = Recent);
   BY CustomerNumber;
   IF Recent = 0;
RUN;
PROC PRINT DATA = noorders;
   TITLE 'Customers with No Orders in the Third Quarter';
RUN;


	
/* Section 6.13 */

/* Program */
*Input the data and create two subsets;
DATA tallpeaks (WHERE = (Height > 6000))
     american (WHERE = (Continent CONTAINS ('America')));
   INFILE 'c:\MyRawData\Mountains.dat';
   INPUT Name $1-14 Continent $15-28 Height;
RUN;
PROC PRINT DATA = tallpeaks;
   TITLE 'Members of the Seven Summits above 6,000 Meters';
RUN;
PROC PRINT DATA = american; 
   TITLE 'Members of the Seven Summits in the Americas';
RUN;	


/* Section 6.14 */

/* Program */
DATA baseball;
   INFILE 'c:\MyRawData\Transpos.dat';
   INPUT Team $ Player Type $ Entry;
PROC SORT DATA = baseball;
   BY Team Player;
PROC PRINT DATA = baseball;
   TITLE 'Baseball Data After Sorting and Before Transposing';
RUN;
* Transpose data so salary and batavg are variables;
PROC TRANSPOSE DATA = baseball OUT = flipped;
   BY Team Player;
   ID Type;
   VAR Entry;
PROC PRINT DATA = flipped;
   TITLE 'Baseball Data After Transposing';
RUN;



/* Section 6.15 */

/* Program */	

DATA walkers;   
   INFILE 'c:\MyRawData\Walk.dat';   
   INPUT Entry AgeGroup $ Time @@; 
PROC SORT DATA = walkers;    
   BY Time; 
* Create a new variable, Place; 
DATA ordered;    
   SET walkers;
   Place = _N_;
PROC PRINT DATA = ordered;
  TITLE 'Results of Walk';
RUN;
PROC SORT DATA = ordered;
   BY AgeGroup Time;
* Keep the first observation in each age group;
DATA winners;
   SET ordered;
   BY AgeGroup;
   IF FIRST.AgeGroup = 1;
PROC PRINT DATA = winners;
   TITLE 'Winners in Each Age Group';
RUN;



