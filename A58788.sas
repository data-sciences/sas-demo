 /*-------------------------------------------------------------------*/
 /*       The Little SAS(r) Book: A Primer, Revised Second Edition    */
 /*          by Lora D. Delwiche and Susan J. Slaughter               */
 /*       Copyright(c) 2002 by SAS Institute Inc., Cary, NC, USA      */
 /*                   SAS Publications order # 58788                  */
 /*                        ISBN 1-59047-113-X                         */
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
 /* Date Last Updated: 05OCT04                                        */
 /*-------------------------------------------------------------------*/
 /* Questions or problem reports concerning this material may be      */
 /* addressed to the author:                                          */
 /*                                                                   */
 /* SAS Institute Inc.                                                */
 /* Books by Users                                                    */
 /* Attn: Lora Delwiche and Susan Slaughter                           */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  sasbbu@sas.com             */
 /* Use this for subject field:                                       */
 /*     Comments for Lora Delwiche and Susan Slaughter                */
 /*                                                                   */
 /*-------------------------------------------------------------------*/

/* Section 2.2 */
/* First program */

* Read internal data into SAS data set uspresidents;
DATA uspresidents;
   INPUT President $ Party $ Number;
   DATALINES;
Adams     F  2
Lincoln   R 16
Grant     R 18
Kennedy   D 35
   ;
RUN;

/* President.dat */

Adams    F  2
Lincoln  R 16
Grant    R 18
Kennedy  D 35

/* Second program */

* Read data from external file into SAS data set;
DATA uspresidents;
   INFILE 'c:\MyRawData\President.dat';
   INPUT President $ Party $ Number;
RUN;

/* Section 2.3 */

/* ToadJump.dat */

Lucky 2.3 1.9 . 3.0
Spot 4.6 2.5 3.1 .5
Tubs 7.1 . . 3.8
Hop 4.5 3.2 1.9 2.6
Noisy 3.8 1.3 1.8 
1.5
Winner 5.7 . . .

/* Program */

* Create a SAS data set named toads;
* Read the data file ToadJump.dat using list input;
DATA toads;
   INFILE 'c:\MyRawData\ToadJump.dat';
   INPUT ToadName $ Weight Jump1 Jump2 Jump3;
* Print the data to make sure the file was read correctly;
PROC PRINT DATA = toads;
   TITLE 'SAS Data Set Toads';
RUN;

/* Section 2.4 */

/* Onions.dat */

Columbia Peaches      35  67  1 10  2  1
Plains Peanuts       210      2  5  0  2
Gilroy Garlics        151035 12 11  7  6
Sacramento Tomatoes  124  85 15  4  9  1

/* Program */

* Create a SAS data set named sales;
* Read the data file Onions.dat using column input;
DATA sales;
   INFILE 'c:\MyRawData\Onions.dat';
   INPUT VisitingTeam $ 1-20 ConcessionSales 21-24 BleacherSales 25-28
         OurHits 29-31 TheirHits 32-34 OurRuns 35-37 TheirRuns 38-40;
* Print the data to make sure the file was read correctly;
PROC PRINT DATA = sales;
   TITLE 'SAS Data Set Sales';
RUN;

/* Section 2.5 */

/* Pumpkin.dat */

Alicia Grossman  13 c 10-28-1999 7.8 6.5 7.2 8.0 7.9
Matthew Lee       9 D 10-30-1999 6.5 5.9 6.8 6.0 8.1
Elizabeth Garcia 10 C 10-29-1999 8.9 7.9 8.5 9.0 8.8
Lori Newcombe     6 D 10-30-1999 6.7 5.6 4.9 5.2 6.1
Jose Martinez     7 d 10-31-1999 8.9 9.510.0 9.7 9.0
Brian Williams   11 C 10-29-1999 7.8 8.4 8.5 7.9 8.0

/* Program */

* Create a SAS data set named contest;
* Read the file Pumpkin.dat using formatted input;
DATA contest;
   INFILE 'c:\MyRawData\Pumpkin.dat';
   INPUT Name $16. Age 3. +1 Type $1. +1 Date MMDDYY10.
         (Score1 Score2 Score3 Score4 Score5) (4.1);
* Print the data set to make sure the file was read correctly;
PROC PRINT DATA = contest;
   TITLE 'Pumpkin Carving Contest';
RUN;

/* Section 2.7 */

/* Park.dat */

Yellowstone           ID/MT/WY 1872    4,065,493
Everglades            FL 1934          1,398,800
Yosemite              CA 1864            760,917
Great Smoky Mountains NC/TN 1926         520,269
Wolf Trap Farm        VA 1966                130

/* Program */

* Create a SAS data set named nationalparks;
* Read a data file Park.dat mixing input styles;
DATA nationalparks;
   INFILE 'c:\MyRawData\Park.dat';
   INPUT ParkName $ 1-22 State $ Year @40 Acreage COMMA9.;
PROC PRINT DATA = nationalparks;
   TITLE 'Selected National Parks';
RUN;

/* Section 2.8 */

/* Dogweblogs.txt */

130.192.70.235 - - [08/Jun/2001:23:51:32 -0700] "GET /rover.jpg HTTP/1.1" 200 66820
128.32.236.8 - - [08/Jun/2001:23:51:40 -0700] "GET /grooming.html HTTP/1.0" 200 8471
128.32.236.8 - - [08/Jun/2001:23:51:40 -0700] "GET /Icons/brush.gif HTTP/1.0" 200 89
128.32.236.8 - - [08/Jun/2001:23:51:40 -0700] "GET /H_poodle.gif HTTP/1.0" 200 1852
118.171.121.37 - - [08/Jun/2001:23:56:46 -0700] "GET /bath.gif HTTP/1.0" 200 14079
128.123.121.37 - - [09/Jun/2001:00:57:49 -0700] "GET /lobo.gif HTTP/1.0" 200 18312
128.123.121.37 - - [09/Jun/2001:00:57:49 -0700] "GET /statemnt.htm HTTP/1.0" 200 238
128.75.226.8 - - [09/Jun/2001:01:59:40 -0700] "GET /Icons/leash.gif HTTP/1.0" 200 98

/* Program */

DATA weblogs;
  INFILE 'c:\MyWebLogs\dogweblogs.txt';
  INPUT @'[' AccessDate DATE11. @'GET' File :$20.;
PROC PRINT;
  TITLE 'Dog Care Web Logs';
RUN;

/* Section 2.9*/

/* Program */

DATA funnies;
   INPUT Id Name $ Height Weight DoB;
   LABEL Id  = 'Identification no.'
      Height = 'Height in inches'
      Weight = 'Weight in pounds'
      DoB    = 'Date of birth';
   INFORMAT DoB MMDDYY8.;
   FORMAT DoB WORDDATE18.;
   DATALINES;
53 Susie    42  41  07-11-81
54 Charlie  46  55  10-26-54
55 Calvin   40  35  01-10-81
56 Lucy     46  52  01-13-55
   ;
* Use PROC CONTENTS to describe data set funnies;
PROC CONTENTS DATA = funnies;
RUN;

/* Section 2.10 */

/* First Program */

DATA distance;
   Miles = 26.22;
   Kilometers = 1.61 * Miles;
PROC PRINT DATA = distance;
RUN;

/* Second Program */

DATA 'c:\MySASLib\distance';
   Miles = 26.22;
   Kilometers = 1.61 * Miles;
PROC PRINT DATA = 'c:\MySASLib\distance';
RUN;

/* Section 2.11 */

/* Mag.dat */

M. grandiflora Southern Magnolia 80 15 E white
M. campbellii                    80 20 D rose
M. liliiflora  Lily Magnolia     12  4 D purple
M. soulangiana Saucer Magnolia   25  3 D pink
M. stellata    Star Magnolia     10  3 D white

/* First Program */

LIBNAME plants 'c:\MySASLib';
DATA plants.magnolia;
   INFILE 'c:\MyRawData\Mag.dat';
   INPUT ScientificName $ 1-14 CommonName $ 16-32 MaximumHeight
      AgeBloom Type $ Color $;
RUN;

/* Second Program */

LIBNAME example 'c:\MySASLib';
PROC PRINT DATA = example.magnolia;
   TITLE 'Magnolias';
RUN;

/* Section 2.13 */

/* Temperature.dat */

Nome AK
55 44
88 29
Miami FL
90 75
97 65
Raleigh NC
88 68
105 50

/* Program */

* Create a SAS data set named highlow;
* Read the data file using line pointers;
DATA highlow;
   INFILE 'c:\MyRawData\Temperature.dat';
   INPUT City $ State $ 
         / NormalHigh NormalLow
         #3 RecordHigh RecordLow;
PROC PRINT DATA = highlow;
   TITLE 'High and Low Temperatures for July';
RUN;

/* Section 2.14 */

/* Precipitation.dat */

Nome AK 2.5 15 Miami FL 6.75 
18 Raleigh NC . 12

/* Program */

* Input more than one observation from each record;
DATA rainfall;
   INFILE 'c:\MyRawData\Precipitation.dat';
   INPUT City $ State $ NormalRain MeanDaysRain @@;
PROC PRINT DATA = rainfall;
   TITLE 'Normal Total Precipitation and';
   TITLE2 'Mean Days with Precipitation for July';
RUN;

/* Section 2.15 */

/* Traffic.dat */

freeway 408                           3684 3459
surface Martin Luther King Jr. Blvd.  1590 1234
surface Broadway                      1259 1290
surface Rodeo Dr.                     1890 2067
freeway 608                           4583 3860
freeway 808                           2386 2518
surface Lake Shore Dr.                1590 1234
surface Pennsylvania Ave.             1259 1290

/* Program */

* Use a trailing @ to delete surface streets;
DATA freeways;
   INFILE 'c:\MyRawData\Traffic.dat';
   INPUT Type $ @;
   IF Type = 'surface' THEN DELETE;
   INPUT Name $ 9-38 AMTraffic PMTraffic;
PROC PRINT DATA = freeways;
   TITLE 'Traffic for Freeways';
RUN;

/* Section 2.16 */

/* Sales.dat */

Ice-cream sales data for the summer of 1999
Flavor     Location   Boxes sold
Chocolate  213        123
Vanilla    213        512
Chocolate  415        242

/* First Program */

DATA icecream;
   INFILE 'c:\MyRawData\Sales.dat' FIRSTOBS = 3;
   INPUT Flavor $ 1-9 Location BoxesSold;
RUN;

/* Sales.dat */

Ice-cream sales data for the summer of 1999
Flavor     Location   Boxes sold
Chocolate  213        123
Vanilla    213        512
Chocolate  415        242
Data verified by Blake White

/* Second Program */

DATA icecream;
   INFILE 'c:\MyRawData\Sales.dat' FIRSTOBS = 3 OBS=5;
   INPUT Flavor $ 1-9 Location BoxesSold;
RUN;

/* Scores.dat */

Nguyen   89 76 91 82
Ramos    67 72 80 76 86
Robbins  76 65 79

/* Third Program */

DATA class102;
   INFILE 'c:\MyRawData\Scores.dat' MISSOVER;
   INPUT Name $ Test1 Test2 Test3 Test4 Test5;
RUN; 

/* Address.dat */

John Garcia     114  Maple Ave.
Sylvia Chung   1302  Washington Drive
Martha Newton    45  S.E. 14th St.

/* Fourth Program */

DATA homeaddress;
   INFILE 'c:\MyRawData\Address.dat' TRUNCOVER;
   INPUT Name $ 1-15 Number 16-19 Street $ 22-37;
RUN;

/* Section 2.17 */

/* Books.dat */

Grace,3,1,5,2,6
Martin,1,2,4,1,3
Scott,9,10,4,8,6

/* First Program */

DATA reading;
   INFILE 'c:\MyRawData\Books.dat' DLM = ',';
   INPUT Name $ Week1 Week2 Week3 Week4 Week5;
RUN;

/* Bands.csv */

Lupine Lights,5/15/1999,45,63,70,
Awesome Octaves,6/3/1999,17,28,44,12
"Stop, Drop, and Rock-N-Roll",7/10/1999,34,62,77,91
The Silveyville Jazz Quartet,7/19/1999,38,30,42,43
Catalina Converts,8/28/1999,56,,65,34


/* Third Program (second program intentionally left out) */

DATA music;
   INFILE 'c:\MyRawData\Bands.csv' DLM = ',' DSD MISSOVER;
   INPUT BandName :$30. GigDate :MMDDYY10. EightPM NinePM TenPM ElevenPM;
PROC PRINT DATA = music;
   TITLE 'Customers at Each Gig';
RUN;

/* Section 2.18 */

/* Bands.csv */

Band Name,Gig Date,Eight PM,Nine PM,Ten PM,Eleven PM
Lupine Lights,5/15/1999,45,63,70,
Awesome Octaves,6/3/1999,17,28,44,12
"Stop, Drop, and Rock-N-Roll",7/10/1999,34,62,77,91
The Silveyville Jazz Quartet,7/19/1999,38,30,42,43
Catalina Converts,8/28/1999,56,,65,34

/* Program */

PROC IMPORT DATAFILE ='c:\MyRawData\Bands.csv' OUT = music REPLACE;
 PROC PRINT DATA = music;
   TITLE 'Customers at Each Gig';
RUN;

/* Section 2.19 */

/* First Program (data must be read from spreadsheet) */

* Read an Excel spreadsheet using DDE;
FILENAME baseball DDE 'CLIPBOARD';
DATA sales;
  INFILE baseball NOTAB DLM='09'x DSD MISSOVER;
  LENGTH VisitingTeam $ 20;
  INPUT VisitingTeam CSales BSales OurHits TheirHits OurRuns TheirRuns;
RUN;

/* Second Program (data must be read from a spreadsheet,        */
/* must replace DDE triplet with DDE triplet for your own file) */

* Read an Excel spreadsheet using DDE;
OPTIONS NOXSYNC NOXWAIT;
X '"C:\MyFiles\BaseBall.xls"';
FILENAME baseball DDE 'Excel|C:\MyFiles\[BaseBall.xls]sheet1!R2C1:R5C7';
DATA sales;
  INFILE baseball NOTAB DLM='09'x DSD MISSOVER;
  LENGTH VisitingTeam $ 20;
  INPUT VisitingTeam CSales BSales OurHits TheirHits OurRuns TheirRuns;
RUN;

/* Section 2.20 */

/* Program (data must be read from a spreadsheet) */

* Read an Excel spreadsheet using PROC IMPORT;
PROC IMPORT DATAFILE = 'c:\MyExcelFiles\Onions2.xls' OUT = sales2;
PROC PRINT DATA = sales2;
   TITLE 'SAS Data Set Read From Excel File';
RUN;

/* Section 2.21 */

/* Golf.dat */

Kapalua Plantation 18 73 7263 125.00
Pukalani           18 72 6945  55.00
Sandlewood         18 72 6469  35.00
Silversword        18 71 6801  57.00
Waiehu Municipal   18 72 6330  25.00
Grand Waikapa      18 72 6122 200.00

/* First Program */

LIBNAME travel 'c:\MySASLib';
DATA travel.golf;
   INFILE 'c:\MyRawData\Golf.dat';
   INPUT CourseName $18. NumberOfHoles Par Yardage GreenFees;
RUN;

/* Second Program */

LIBNAME sports 'c:\MySASLib';
* Create Tab-delimited file;
PROC EXPORT DATA = sports.golf OUTFILE = 'c:\MyRawData\Golf.txt' REPLACE;
RUN;

/* Section 2.22 */

/* First Program */

LIBNAME travel 'c:\MySASLib';
DATA travel.golf;
   INFILE 'c:\MyRawData\Golf.dat';
   INPUT CourseName $18. NumberOfHoles Par Yardage GreenFees;
RUN;

/* Second Program */

LIBNAME activity 'c:\MySASLib';
DATA _NULL_;
   SET activity.golf;
   FILE 'c:\MyRawData\Newfile.dat';
   PUT CourseName 'Golf Course' @32 GreenFees DOLLAR7.2 @40 'Par ' Par;
RUN;

/* Section 3.1 */

/* Garden.dat */

Gregor  10  2  40    0
Molly   15  5  10 1000
Luther  50 10  15   50
Susan   20  0   .   20

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
PROC PRINT DATA = homegarden;
   TITLE 'Home Gardening Survey';
RUN;

/* Section 3.2 */

/* Pumpkin.dat */

Alicia Grossman  13 c 10-28-1999 7.8 6.5 7.2 8.0 7.9
Matthew Lee       9 D 10-30-1999 6.5 5.9 6.8 6.0 8.1
Elizabeth Garcia 10 C 10-29-1999 8.9 7.9 8.5 9.0 8.8
Lori Newcombe     6 D 10-30-1999 6.7 5.6 4.9 5.2 6.1
Jose Martinez     7 d 10-31-1999 8.9 9.510.0 9.7 9.0
Brian Williams   11 C 10-29-1999 7.8 8.4 8.5 7.9 8.0


/* Program */

DATA contest;
   INFILE 'c:\MyRawData\Pumpkin.dat';
   INPUT Name $16. Age 3. +1 Type $1. +1 Date MMDDYY10.
         (Scr1 Scr2 Scr3 Scr4 Scr5) (4.1);
   AvgScore = MEAN(Scr1, Scr2, Scr3, Scr4, Scr5);
   DayEntered = DAY(Date);
   Type = UPCASE(Type);
PROC PRINT DATA = contest;
   TITLE 'Pumpkin Carving Contest';
RUN;

/* Section 3.4 */

/* Cars.dat */

Corvette 1955 .      2 black
XJ6      1985 Jaguar 2 teal
Mustang  1966 Ford   4 red
Miata    1992 .      . silver
CRX      1991 Honda  2 black
Camaro   1990 .      4 red

/* Program */

DATA sportscars;
   INFILE 'c:\MyRawData\Cars.dat';
   INPUT Model $ Year Make $ Seats Color $;
   IF Year < 1975 THEN Status = 'classic';
   IF Model = 'Corvette' OR Model = 'Camaro' THEN Make = 'Chevy';
   IF Model = 'Miata' THEN DO;
      Make = 'Mazda';
      Seats = 2;
   END;
PROC PRINT DATA = sportscars;
   TITLE "Eddy's Excellent Emporium of Used Sports Cars";
RUN;

/* Section 3.5 */

/* Home.dat */

Bob     kitchen cabinet face-lift   1253.00
Shirley bathroom addition          11350.70
Silvia  paint exterior                  .  
Al      backyard gazebo             3098.63
Norm    paint interior               647.77
Kathy   second floor addition      75362.93

/* Program */

* Group observations by cost;
DATA homeimprovements;
   INFILE 'c:\MyRawData\Home.dat';
   INPUT Owner $ 1-7 Description $ 9-33 Cost;
   IF Cost = . THEN CostGroup = 'missing';
      ELSE IF Cost < 2000 THEN CostGroup = 'low';
      ELSE IF Cost < 10000 THEN CostGroup = 'medium';
      ELSE CostGroup = 'high';
PROC PRINT DATA = homeimprovements;
   TITLE 'Home Improvement Cost Groups';
RUN;

/* Section 3.6 */

/* Shakespeare.dat */

A Midsummer Night's Dream 1595 comedy
Comedy of Errors          1590 comedy
Hamlet                    1600 tragedy
Macbeth                   1606 tragedy
Richard III               1594 history
Romeo and Juliet          1596 tragedy
Taming of the Shrew       1593 comedy
Tempest                   1611 romance

/* Program */

* Choose only comedies;
DATA comedy;
   INFILE 'c:\MyRawData\Shakespeare.dat';
   INPUT Title $ 1-26 Year Type $;
   IF Type = 'comedy';
PROC PRINT DATA = comedy;
   TITLE 'Shakespearean Comedies';
RUN;

/* Section 3.7 */

/* Dates.dat */

A. Jones    1jan60    9-15-95
M. Rincon   05OCT1949 01-24-1997
Z. Grandage 18mar1988 10-10-1999
K. Kaminaka 29may1996 02-29-2000

/* Program */

DATA librarycards;
   INFILE 'c:\MyRawData\Dates.dat' TRUNCOVER;
   INPUT Name $11. +1 BirthDate DATE9. +1 IssueDate MMDDYY10.;
   ExpireDate = IssueDate + (365.25 * 3);
   ExpireQuarter = QTR(ExpireDate);
   IF IssueDate > '01jan1999'D THEN NewCard = 'yes';
PROC PRINT DATA = librarycards;
   FORMAT IssueDate MMDDYY8. ExpireDate WEEKDATE17.;
   TITLE 'SAS Dates without and with Formats';
RUN;

/* Section 3.9 */

/* Games.dat */

6-19 Columbia Peaches      8  3  
6-20 Columbia Peaches     10  5  
6-23 Plains Peanuts        3  4  
6-24 Plains Peanuts        7  2  
6-25 Plains Peanuts       12  8  
6-30 Gilroy Garlics        4  4  
7-1  Gilroy Garlics        9  4  
7-4  Sacramento Tomatoes  15  9  
7-4  Sacramento Tomatoes  10 10  
7-5  Sacramento Tomatoes   2  3  
 
/* Program */

DATA gamestats;
   INFILE 'c:\MyRawData\Games.dat';
   INPUT Month 1 Day 3-4 Team $ 6-25 Hits 27-28 Runs 30-31;
   RETAIN MaxRuns;
   MaxRuns = MAX(MaxRuns, Runs);
   RunsToDate + Runs;
PROC PRINT DATA = gamestats;
   TITLE "Season's Record to Date";
RUN;

/* Section 3.10 */

/* WBRK.dat */

Albany         54 4 3 5 9 9 2 1 4 4 9
Richmond       33 5 2 4 3 9 2 9 3 3 3
Oakland        27 1 3 2 9 9 9 3 4 2 3
Richmond       41 4 3 5 5 5 2 9 4 5 5
Berkeley       18 3 4 9 1 4 9 3 9 3 2

/* Program */

DATA songs;
   INFILE 'c:\MyRawData\WBRK.dat';
   INPUT City $ 1-15 Age domk wj hwow simbh kt aomm libm tr filp ttr;
   ARRAY song (10) domk wj hwow simbh kt aomm libm tr filp ttr;
   DO i = 1 TO 10;
      IF song(i) = 9 THEN song(i) = .;
   END;
PROC PRINT DATA = songs;
   TITLE 'WBRK Song Survey';
RUN;

/* Section 3.11 */

/* Program */

DATA songs;
   INFILE 'c:\MyRawData\WBRK.dat';
   INPUT City $ 1-15 Age domk wj hwow simbh kt aomm libm tr filp ttr;
   ARRAY new (10) Song1 - Song10;
   ARRAY old (10) domk -- ttr;
   DO i = 1 TO 10;
      IF old(i) = 9 THEN new(i) = .;
         ELSE new(i) = old(i);
   END;
   AvgScore = MEAN(OF Song1 - Song10);
PROC PRINT DATA = songs;
   TITLE 'WBRK Song Survey';
RUN;

/* Section 4.2 */

/* Artists.dat */

Mary Cassatt          Impressionism      U
Paul Cezanne          Post-impressionism F
Edgar Degas           Impressionism      F
Paul Gauguin          Post-impressionism F
Claude Monet          Impressionism      F
Pierre Auguste Renoir Impressionism      F
Vincent van Gogh      Post-impressionism N

/* First Program */

DATA 'c:\MySASLib\style';
   INFILE 'c:\MyRawData\Artists.dat';
   INPUT Name $ 1-21 Genre $ 23-40 Origin $ 42;
RUN;

/* Second Program */

PROC PRINT DATA = 'c:\MySASLib\style';
   WHERE Genre = 'Impressionism';
   TITLE 'Major Impressionist Painters';
   FOOTNOTE 'F = France N = Netherlands U = US';
RUN;

/* Section 4.3 */

/* Sealife.dat */

beluga   whale 15
whale    shark 40
basking  shark 30
gray     whale 50
mako     shark 12
sperm    whale 60
dwarf    shark .5
whale    shark 40
humpback   .   50
blue     whale 100
killer   whale 30

/* Program */

DATA marine;
   INFILE 'c:\MyRawData\Sealife.dat';
   INPUT Name $ Family $ Length;
* Sort the data;
PROC SORT DATA = marine OUT = seasort NODUPKEY;
   BY Family DESCENDING Length;
PROC PRINT DATA = seasort;
   TITLE 'Whales and Sharks';
RUN;

/* Section 4.4 */

/* Candy.dat */

Adriana    21  3/21/2000 MP  7
Nathan     14  3/21/2000 CD 19
Matthew    14  3/21/2000 CD 14
Claire     14  3/22/2000 CD 11
Caitlin    21  3/24/2000 CD  9
Ian        21  3/24/2000 MP 18
Chris      14  3/25/2000 CD  6
Anthony    21  3/25/2000 MP 13
Stephen    14  3/25/2000 CD 10
Erika      21  3/25/2000 MP 17

/* Program */

DATA sales;
   INFILE 'c:\MyRawData\Candy.dat';
   INPUT Name $ 1-11 Class @15 DateReturned MMDDYY10. CandyType $
      Quantity;
   Profit = Quantity * 1.25;
PROC SORT DATA = sales;
   BY Class;
PROC PRINT DATA = sales;
   BY Class;
   SUM Profit;
   VAR Name DateReturned CandyType Profit;
   TITLE 'Candy Sales for Field Trip by Class';
RUN;

/* Section 4.5 */

/* Program */

DATA sales;
   INFILE 'c:\MyRawData\Candy.dat';
   INPUT Name $ 1-11 Class @15 DateReturned MMDDYY10. CandyType $
         Quantity;
   Profit = Quantity * 1.25;
PROC PRINT DATA = sales;
   VAR Name DateReturned CandyType Profit;
   FORMAT DateReturned DATE9. Profit DOLLAR6.2;
   TITLE 'Candy Sale Data Using Formats';
RUN;

/* Section 4.7 */

/* Cars.dat */

19 1 14000 Y
45 1 65000 G
72 2 35000 B
31 1 44000 Y
58 2 83000 W

/* Program */

DATA carsurvey;
   INFILE 'c:\MyRawData\Cars.dat';
   INPUT Age Sex Income Color $;
PROC FORMAT;
   VALUE gender 1 = 'Male'
                2 = 'Female';
   VALUE agegroup 13 -< 20 = 'Teen'
                  20 -< 65 = 'Adult'
                  65 - HIGH = 'Senior';
   VALUE $col  'W' = 'Moon White'
               'B' = 'Sky Blue'
               'Y' = 'Sunburst Yellow'
               'G' = 'Rain Cloud Gray';
* Print data using user-defined and standard (DOLLAR8.) formats;
PROC PRINT DATA = carsurvey;
   FORMAT Sex gender. Age agegroup. Color $col. Income DOLLAR8.;
   TITLE 'Survey Results Printed with User-Defined Formats';
RUN;

/* Section 4.8 */

/* Candy.dat */

Adriana    21 3/21/2000 MP  7
Nathan     14 3/21/2000 CD 19
Matthew    14 3/21/2000 CD 14
Claire     14 3/22/2000 CD 11
Caitlin    21 3/24/2000 CD  9
Ian        21 3/24/2000 MP 18
Chris      14 3/25/2000 CD  6
Anthony    21 3/25/2000 MP 13
Stephen    14 3/25/2000 CD 10
Erika      21 3/25/2000 MP 17

/* Program */

* Write a report with FILE and PUT statements;
DATA _NULL_;
   INFILE 'c:\MyRawData\Candy.dat';
   INPUT Name $ 1-11 Class @15 DateReturned MMDDYY10. 
         CandyType $ Quantity;
   Profit = Quantity * 1.25;
   FILE 'c:\MyRawData\Student.rep' PRINT;
   TITLE;
   PUT @5 'Candy sales report for ' Name 'from classroom ' Class
     // @5 'Congratulations!  You sold ' Quantity 'boxes of candy'
     / @5 'and earned ' Profit DOLLAR6.2 ' for our field trip.';
   PUT _PAGE_;
RUN;

/* Section 4.9 */

/* Flowers.dat */

756-01  05/04/2001 120  80 110
834-01  05/12/2001  90 160  60
901-02  05/18/2001  50 100  75
834-01  06/01/2001  80  60 100
756-01  06/11/2001 100 160  75
901-02  06/19/2001  60  60  60
756-01  06/25/2001  85 110 100

/* Program */

DATA sales;
   INFILE 'c:\MyRawData\Flowers.dat';
   INPUT CustomerID $ @9 SaleDate MMDDYY10. Petunia SnapDragon
         Marigold;
   Month = MONTH(SaleDate);
PROC SORT DATA = sales;
   BY Month;
* Calculate means by Month for flower sales;
PROC MEANS DATA = sales;
   BY Month;
   VAR Petunia SnapDragon Marigold;
   TITLE 'Summary of Flower Sales by Month';
RUN;

/* Section 4.10 */

/* Program */

DATA sales;
   INFILE 'c:\MyRawData\Flowers.dat';
   INPUT CustomerID $ @9 SaleDate MMDDYY10. Petunia SnapDragon Marigold;
PROC SORT DATA = sales;
   BY CustomerID;
* Calculate means by CustomerID, output sum and mean to new data set;
PROC MEANS NOPRINT DATA = sales;
   BY CustomerID;
   VAR Petunia SnapDragon Marigold;
   OUTPUT OUT = totals  MEAN(Petunia SnapDragon Marigold) =
          MeanPetunia MeanSnapDragon MeanMarigold
      SUM(Petunia SnapDragon Marigold) = Petunia SnapDragon Marigold;
PROC PRINT DATA = totals;
   TITLE 'Sum of Flower Data over Customer ID';
   FORMAT MeanPetunia MeanSnapDragon MeanMarigold 3.;
RUN;

/* Section 4.11 */

/* Coffee.dat */

esp w cap d cap w kon w ice w kon d esp d kon w ice d esp d
cap w esp d cap d Kon d .   d kon w esp d cap w ice w kon w
kon w kon w ice d esp d kon w esp d esp w kon w cap w kon w

/* Program */

DATA orders;
   INFILE 'c:\MyRawData\Coffee.dat';
   INPUT Coffee $ Window $ @@;
* Print tables for Window and Window by Coffee;
PROC FREQ DATA = orders;
   TABLES Window  Window * Coffee;
   RUN;

/* Section 4.12 */

/* Boats.dat */

Silent Lady  Maalea  sail  sch 75.00
America II   Maalea  sail  yac 32.95
Aloha Anai   Lahaina sail  cat 62.00
Ocean Spirit Maalea  power cat 22.00
Anuenue      Maalea  sail  sch 47.50
Hana Lei     Maalea  power cat 28.99
Leilani      Maalea  power yac 19.99
Kalakaua     Maalea  power cat 29.50
Reef Runner  Lahaina power yac 29.95
Blue Dolphin Maalea  sail  cat 42.95

/* Program */

DATA boats;
   INFILE 'c:\MyRawData\Boats.dat' TRUNCOVER;
   INPUT Name $ 1-12 Port $ 14-20 Locomotion $ 22-26 Type $ 28-30 
      Price 32-36;

* Tabulations with three dimensions;
PROC TABULATE DATA = boats;
   CLASS Port Locomotion Type;
   TABLE Port, Locomotion, Type;
   TITLE 'Number of Boats by Port, Locomotion, and Type';
RUN;

/* Section 4.13 */

/* Program */

DATA boats;
   INFILE 'c:\MyRawData\Boats.dat' TRUNCOVER;
   INPUT Name $ 1-12 Port $ 14-20 Locomotion $ 22-26 Type $ 28-30 
      Price 32-36;

* Tabulations with two dimensions and statistics;
PROC TABULATE DATA = boats;
   CLASS Locomotion Type;
   VAR Price;
   TABLE Locomotion ALL, MEAN*Price*(Type ALL);
   TITLE 'Mean Price by Locomotion and Type';
RUN;

/* Section 4.14 */

/* Program */

DATA boats;
   INFILE 'c:\MyRawData\Boats.dat' TRUNCOVER;
   INPUT Name $ 1-12 Port $ 14-20 Locomotion $ 22-26 Type $ 28-30 
      Price 32-36;

* PROC TABULATE report with options;
PROC TABULATE DATA = boats FORMAT=dollar9.2;
   CLASS Locomotion Type;
   VAR Price;
   TABLE Locomotion ALL, MEAN*Price*(Type ALL)
      /BOX='Full Day Excursions' MISSTEXT='none';
   TITLE;
RUN;

/* Section 4.15 */

/* Program */

DATA boats;
   INFILE 'c:\MyRawData\Boats.dat' TRUNCOVER;
   INPUT Name $ 1-12 Port $ 14-20 Locomotion $ 22-26 Type $ 28-30 
      Price 32-36;

* Changing headers;
PROC FORMAT;
   VALUE $typ  'cat' = 'catamaran'
               'sch' = 'schooner'
               'yac' = 'yacht';

PROC TABULATE DATA = boats FORMAT=dollar9.2;
   CLASS Locomotion Type;
   VAR Price;
   FORMAT Type $typ.;
   TABLE Locomotion='' ALL, 
      MEAN=''*Price='Mean Price by Type of Boat'*(Type='' ALL)
      /BOX='Full Day Excursions' MISSTEXT='none';
   TITLE;
RUN;

/* Section 4.16 */

/* Boats.dat */

Silent Lady  Maalea  sail  sch 75.00  64
America II   Maalea  sail  yac 32.95  65
Aloha Anai   Lahaina sail  cat 62.00  60
Ocean Spirit Maalea  power cat 22.00  65
Anuenue      Maalea  sail  sch 47.50  52
Hana Lei     Maalea  power cat 28.99 110
Leilani      Maalea  power yac 19.99  45
Kalakaua     Maalea  power cat 29.50  70
Reef Runner  Lahaina power yac 29.95  50
Blue Dolphin Maalea  sail  cat 42.95  65

/* Program */

DATA boats;
   INFILE 'c:\MyRawData\Boats.dat' TRUNCOVER;
   INPUT Name $ 1-12 Port $ 14-20 Locomotion $ 22-26 Type $ 28-30 
      Price 32-36 Length 38-41;

* Using the FORMAT= option in the TABLE statement;
PROC TABULATE DATA = boats;
   CLASS Locomotion Type;
   VAR Price Length;
   TABLE Locomotion ALL, 
      MEAN * (Price*FORMAT=dollar6.2 Length*FORMAT=6.0) * (Type ALL);
   TITLE 'Price and Length by Type of Boat';
RUN;

/* Section 4.17 */

/* Onions.dat */

Columbia Peaches    102  67  1 10 2 1
Plains Peanuts      210  54  2  5 0 1
Gilroy Garlics       15 335 12 11 7 6
Sacramento Tomatoes 124 185 15  4 9 1
Boise Spuds         162  75  5  6 2 3
Orlando Tangelos    144  86  9  3 4 2
Des Moines Corncobs  73 210 10  5 9 3

/* Program */

DATA onionrings;
   INFILE 'c:\MyRawData\Onions.dat';
   INPUT VisTeam $ 1-20 CSales BSales OurHits VisHits OurRuns VisRuns;
   Action = OurHits + VisHits + OurRuns + VisRuns;

* Plot Action by BSales;
PROC PLOT DATA = onionrings;
   PLOT BSales * Action = VisTeam;
   TITLE 'Onion Ring Sales';
RUN;

/* Section 4.18 */

/* First Program */

* Trace ODS for TABULATE procedure;
ODS TRACE OUTPUT;
DATA boats;
   INFILE 'c:\MyRawData\Boats.dat' TRUNCOVER;
   INPUT Name $13. Length Locomotion $ @25 Type $9.;
   Port = 'Maalea';
PROC TABULATE DATA = boats;
   CLASS Port Locomotion Type;
   TABLE Port, Locomotion, Type;
   TITLE 'Number of Boats by Port, Locomotion, and Type';
RUN;
ODS TRACE OFF;

/* Second Program */

* Create an output data set from TABULATE procedure;
PROC TABULATE DATA = boats;
   CLASS Port Locomotion Type;
   TABLE Port, Locomotion, Type;
ODS OUTPUT REPORT = tabulateoutput;

PROC PRINT DATA = tabulateoutput;
   TITLE 'Output Data Set from Tabulate';
RUN;


/* Section 5.2 */

/* Sealife.dat*/

beluga   whale 15   dwarf    shark .5    sperm   whale 60
basking  shark 30   humpback whale 50    whale   shark 40
gray     whale 50   blue     whale 100   killer  whale 30
mako     shark 12   

/* Program */

* Create the HTML files;
ODS HTML BODY = 'c:\MyHTMLFiles\MarineBody.html'
         CONTENTS = 'c:\MyHTMLFiles\MarineTOC.html'
         PAGE = 'c:\MyHTMLFiles\MarinePage.html'
         FRAME = 'c:\MyHTMLFiles\MarineFrame.html';
DATA marine;
   INFILE 'c:\MyRawData\Sealife.dat';
   INPUT Name $ Family $ Length @@;
PROC MEANS DATA = marine;
   CLASS Family;
   TITLE 'Whales and Sharks';
PROC PRINT DATA = marine;
RUN;
* Close the HTML files;
ODS HTML CLOSE;

/* Section 5.3 */

/* Program */

* Create an RTF file;
ODS RTF FILE = 'c:\MyRTFFiles\Marine.rtf' BODYTITLE;
DATA marine;
   INFILE 'c:\MyRawData\Sealife.dat';
   INPUT Name $ Family $ Length @@;
PROC MEANS DATA = marine;
   CLASS Family;
   TITLE 'Whales and Sharks';
PROC PRINT DATA = marine;
RUN;
* Close the RTF file;
ODS RTF CLOSE;

/* Section 5.4 */

/* Program */

* Create the PDF file;
ODS PDF FILE = 'c:\MyPDFFiles\Marine.pdf';
DATA marine;
   INFILE 'c:\MyRawData\Sealife.dat';
   INPUT Name $ Family $ Length @@;
PROC MEANS DATA = marine;
   CLASS Family;
   TITLE 'Whales and Sharks';
PROC PRINT DATA = marine;
RUN;
* Close the PDF file;
ODS PDF CLOSE;

/* Section 5.6 */

/* Women.csv*/

1988,Yvonne van Gennip,NED,7:14.13,WR
1992,Gunda Niemann,GER,7:31.57 
1994,Claudia Pechstein,GER,7:14.37 
1998,Claudia Pechstein,GER,6:59.61,WR
2002,Claudia Pechstein,GER,6:46.91,WR

/* First Program */

ODS HTML FILE='c:\MyHTML\results.htm';
DATA skating;
  INFILE 'c:\mydir\women.csv' DSD MISSOVER;
  INPUT Year Name :$20. Country $ 
        Time $ Record $;
PROC PRINT DATA=skating;
  TITLE 'Women''s 5000 Meter Speed Skating';
  ID Year;
RUN;
ODS HTML CLOSE;

/* Second Program */

ODS HTML FILE='c:\MyHTML\results2.htm';
PROC PRINT DATA=skating 
     STYLE(DATA)={BACKGROUND=light blue};
  TITLE 'Women''s 5000 Meter Speed Skating';
  ID Year;
RUN;
ODS HTML CLOSE;

/* Third Program */

ODS HTML FILE='c:\MyHTML\results3.htm';
PROC PRINT DATA=skating 
     STYLE(DATA)={BACKGROUND=light blue};
  TITLE 'Women''s 5000 Meter Speed Skating';
  VAR Name Country Time;
  VAR Record/STYLE(DATA)=
         {FOREGROUND=white FONT_WEIGHT=bold};
  ID Year;
RUN;
ODS HTML CLOSE;

/* Section 5.7 */

/* Records.dat*/

1992 m500 None 1994 m500 OR 1998 m500 OR 2002 m500 OR
1992 m1000 None 1994 m1000 WR 1998 m1000 OR 2002 m1000 WR
1992 m1500 None 1994 m1500 WR 1998 m1500 WR 2002 m1500 WR
1992 m5000 None 1994 m5000 WR 1998 m5000 WR 2002 m5000 WR
1992 m10000 None 1994 m10000 WR 1998 m10000 WR 2002 m10000 WR

/* First Program */

ODS HTML FILE='c:\MyHTML\table.htm';
DATA skating;
  INFILE 'c:\MyData\records.dat';
  INPUT Year  Event $ Record $ @@;
PROC TABULATE DATA=skating;
  CLASS Year Record;
  TABLE Year='',Record*N='';
  TITLE 'Men''s Speed Skating';
  TITLE2 'Records Set at Olympics';
RUN;
ODS HTML CLOSE;

/* Second Program */

PROC TABULATE DATA=skating
     STYLE={JUST=center BACKGROUND=white};
  CLASS Year Record;
  TABLE Year='',Record*N='';
  TITLE 'Men''s Speed Skating';
  TITLE2 'Records Set at Olympics';
RUN;
ODS HTML CLOSE;

/* Section 5.8 */

/* Mens5000.dat */

1,Jochem Uytdehaage, Netherlands,374.66
2,Derek Parra, United States,377.98
3,Jens Boden, Germany,381.73
4,Dmitry Shepel, Russia,381.85
5,KC Boutiette, United States,382.97

/* First Program */

ODS HTML FILE='c:\MyHTML\mens.html';
DATA results;
  INFILE
     'c:\MyRawData\mens5000.dat' DSD;
  INPUT Place Name :$20.
        Country :$15. Time ;
PROC PRINT DATA=results;
  ID Place;
  TITLE 'Men''s 5000m Speed Skating';
  TITLE2 '2002 Olympic Results';
RUN;
ODS HTML CLOSE;

/* Second Program */

ODS HTML FILE='c:\MyHTML\mens2.html';
PROC FORMAT;
  VALUE rec 0 -< 378.72 ='red'
            378.72 -< 382.20 = 'orange'
            382.20 - HIGH = 'white';
PROC PRINT DATA=results;
  ID Place;
  VAR Name Country;
  VAR Time/STYLE={BACKGROUND=rec.};
  TITLE 'Men''s 5000m Speed Skating';
  TITLE2 '2002 Olympic Results';
RUN;
ODS HTML CLOSE;

/* Section 6.1 */

/* Train.dat */

10:10  6 21
12:15 10 56
15:30 10 25
11:30  8 34
13:15  8 12
10:45  6 13
20:30  6 32
23:15  6 12

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
PROC PRINT DATA = averagetrain;
   TITLE 'Average Number of People per Train Car';
   FORMAT Time TIME5.;
RUN;

/* Section 6.2 */

/* South.dat */

S 43 3 27
S 44 3 24       
S 45 3  2       
                
/* North.dat */

N 21 5 41 1
N 87 4 33 3
N 65 2 67 1 
N 66 2  7 1

/* Program */

DATA southentrance;
   INFILE 'c:\MyRawData\South.dat';
   INPUT Entrance $ PassNumber PartySize Age;
PROC PRINT DATA = southentrance;
   TITLE 'South Entrance Data';

DATA northentrance;
   INFILE 'c:\MyRawData\North.dat';
   INPUT Entrance $ PassNumber PartySize Age Lot;
PROC PRINT DATA = northentrance;
   TITLE 'North Entrance Data';
* Create a data set, both, combining northentrance and southentrance;
* Create a variable, AmountPaid, based on value of variable Age;
DATA both;
   SET southentrance northentrance;
   IF Age = . THEN AmountPaid = .;
      ELSE IF Age < 3  THEN AmountPaid = 0;
      ELSE IF Age < 65 THEN AmountPaid = 17;
      ELSE AmountPaid = 12;
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

DATA northentrance;
   INFILE 'c:\MyRawData\North.dat';
   INPUT Entrance $ PassNumber PartySize Age Lot;
PROC SORT DATA = northentrance;
   BY PassNumber;
PROC PRINT DATA = northentrance;
   TITLE 'North Entrance Data';

* Interleave observations by PassNumber;
DATA interleave;
   SET northentrance southentrance;
   BY PassNumber;
PROC PRINT DATA = interleave;
   TITLE 'Both Entrances, By Pass Number';
RUN;

/* Section 6.4 */

/* chocsales.dat */

   C865 15
   K086  9
   A536 21
   S163 34
   K014  1
   A206 12
   B713 29

/* chocolate.dat */

   A206 Mokka     Coffee buttercream in dark chocolate
   A536 Walnoot   Walnut halves in bed of dark chocolate
   B713 Frambozen Raspberry marzipan covered in milk chocolate
   C865 Vanille   Vanilla-flavored rolled in ground hazelnuts
   K014 Kroon     Milk chocolate with a mint cream center
   K086 Koning    Hazelnut paste in dark chocolate
   M315 Pyramide  White with dark chocolate trimming
   S163 Orbais    Chocolate cream in dark chocolate

/* Program */

DATA descriptions;
   INFILE 'c:\MyRawData\chocolate.dat' TRUNCOVER;
   INPUT CodeNum $ 1-4 Name $ 6-14 Description $ 15-60;
DATA sales;
   INFILE 'c:\MyRawData\chocsales.dat';
   INPUT CodeNum $ 1-4 PiecesSold 6-7;
PROC SORT DATA = sales;
   BY CodeNum;

* Merge data sets by CodeNum;
DATA chocolates;
   MERGE sales descriptions;
   BY CodeNum;
PROC PRINT DATA = chocolates;
   TITLE "Today's Chocolate Sales";
RUN;

/* Section 6.5 */

/* Shoe.dat */

Max Flight      running 142.99
Zip Fit Leather walking  83.99
Zoom Airborne   running 112.99
Light Step      walking  73.99
Max Step Woven  walking  75.99
Zip Sneak       c-train  92.99

/* Disc.dat */

c-train .25
running .30
walking .20

/* Program */

DATA regular;
   INFILE 'c:\MyRawData\Shoe.dat';
   INPUT Style $ 1-15 ExerciseType $ RegularPrice;
PROC SORT DATA = regular;
   BY ExerciseType;

DATA discount;
   INFILE 'c:\MyRawData\Disc.dat';
   INPUT ExerciseType $ Adjustment;

* Perform many-to-one match merge;
DATA prices;
   MERGE regular discount;
   BY ExerciseType;
   NewPrice = ROUND(RegularPrice - (RegularPrice * Adjustment), .01);
PROC PRINT DATA = prices;
   TITLE 'Price List for May';
RUN;


/* Section 6.6 */

/* Shoesales.dat */
Max Flight      running 1930
Zip Fit Leather walking 2250
Zoom Airborne   running 4150
Light Step      walking 1130
Max Step Woven  walking 2230
Zip Sneak       c-train 1190

/* Program */

DATA shoes;
   INFILE 'c:\MyRawData\Shoesales.dat';
   INPUT Style $ 1-15 ExerciseType $ Sales;
PROC SORT DATA = shoes;
   BY ExerciseType;

* Summarize sales by ExerciseType and print;
PROC MEANS NOPRINT DATA = shoes;
   VAR Sales;
   BY ExerciseType;
   OUTPUT OUT = summarydata SUM(Sales) = Total;
PROC PRINT DATA = summarydata;
   TITLE 'Summary Data Set';

* Merge totals with the original data set;
DATA shoesummary;
   MERGE shoes summarydata;
   BY ExerciseType;
   Percent = Sales / Total * 100;
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

* Output grand total of sales to a data set and print;
PROC MEANS NOPRINT DATA = shoes;
   VAR Sales;
   OUTPUT OUT = summarydata SUM(Sales) = GrandTotal;
PROC PRINT DATA = summarydata;
   TITLE 'Summary Data Set';

* Combine the grand total with the original data;
DATA shoesummary;
   IF _N_ = 1 THEN SET summarydata;
   SET shoes;
   Percent = Sales / GrandTotal * 100;
PROC PRINT DATA = shoesummary;
   VAR Style ExerciseType Sales GrandTotal Percent;
   TITLE 'Overall Sales Share';
RUN;

/* Section 6.8 */

/* Admit.dat */

620135 Smith    234 Aspen St.     12-21-1975 m CBC 02-16-1998
645722 Miyamoto 65 3rd Ave.       04-03-1936 f MCR 05-30-1999
645739 Jensvold 505 Glendale Ave. 06-15-1960 f HLT 09-23-1993
874329 Kazoyan  76-C La Vista     .          . MCD 01-15-2001

/* NewAdmit.dat */

620135 .        .                 .          . HLT 06-15-2001
874329 .        .                 04-24-1954 m .   06-15-2001
235777 Harman   5656 Land Way     01-18-1960 f MCD 06-15-2001

/* First Program */

DATA 'c:\MySASLib\patientmaster';
   INFILE 'c:\MyRawData\Admit.dat';
   INPUT Account LastName $ 8-16 Address $ 17-34
      BirthDate MMDDYY10. Sex $ InsCode $ 48-50 @52 LastUpdate MMDDYY10.;
RUN;

/* Second Program */

DATA transactions;
   INFILE 'c:\MyRawData\NewAdmit.dat';
   INPUT Account LastName $ 8-16 Address $ 17-34 BirthDate MMDDYY10. 
      Sex $ InsCode $ 48-50 @52 LastUpdate MMDDYY10.;
PROC SORT DATA = transactions;
   BY Account;

* Update patient data with transactions;
DATA 'c:\MySASLib\patientmaster';
   UPDATE 'c:\MySASLib\patientmaster' transactions;
   BY Account;
PROC PRINT DATA = 'c:\MySASLib\patientmaster';
   FORMAT BirthDate LastUpdate MMDDYY10.;
   TITLE 'Admissions Data';
RUN;

/* Section 6.10 */

/* Address.dat */

101 Murphy's Sports     115 Main St.    
102 Sun N Ski   2106 Newberry Ave.      
103 Sports Outfitters   19 Cary Way     
104 Cramer & Johnson    4106 Arlington Blvd.    
105 Sports Savers       2708 Broadway   

/* OrdersQ3.dat */

102 562.01
104 254.98
104 1642.00
101 3497.56
102 385.30

/* Program */

DATA customer;
   INFILE 'c:\MyRawData\Address.dat' TRUNCOVER;
   INPUT CustomerNumber Name $ 5-21 Address $ 23-42;
DATA orders;
   INFILE 'c:\MyRawData\OrdersQ3.dat';
   INPUT CustomerNumber Total;
PROC SORT DATA = orders;
   BY CustomerNumber;

* Combine the data sets using the IN= option;
DATA noorders;
   MERGE customer orders (IN = Recent);
   BY CustomerNumber;
   IF Recent = 0;
PROC PRINT DATA = noorders;
   TITLE 'Customers with No Orders in the Third Quarter';
RUN;

/* Section 6.11 */

/* Zoo.dat */

bears     Mammalia E2 both
elephants Mammalia W3 am
flamingos Aves     W1 pm
frogs     Amphibia S2 pm
kangaroos Mammalia N4 am
lions     Mammalia W6 pm
snakes    Reptilia S1 pm
tigers    Mammalia W9 both
zebras    Mammalia W2 am

/* Program */

DATA morning afternoon;
   INFILE 'c:\MyRawData\Zoo.dat';
   INPUT Animal $ 1-9 Class $ 11-18 Enclosure $ FeedTime $;
   IF FeedTime = 'am' THEN OUTPUT morning;
      ELSE IF FeedTime = 'pm' THEN OUTPUT afternoon;
      ELSE IF FeedTime = 'both' THEN OUTPUT;
PROC PRINT DATA = morning;
   TITLE 'Animals with Morning Feedings';
PROC PRINT DATA = afternoon;
   TITLE 'Animals with Afternoon Feedings';
RUN;

/* Section 6.12 */

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

/* Movies.dat */

Jan Varsity 56723 Downtown 69831 Super-6 70025
Feb Varsity 62137 Downtown 43901 Super-6 81534
Mar Varsity 49982 Downtown 55783 Super-6 69800


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
PROC PRINT DATA = theaters;
   TITLE 'Ticket Sales';
RUN;

/* Section 6.13 */

/* Transpos.dat */

Garlics 10 salary 43000
Peaches  8 salary 38000
Garlics 21 salary 51000
Peaches 10 salary 47500
Garlics 10 batavg .281
Peaches  8 batavg .252
Garlics 21 batavg .265
Peaches 10 batavg .301

/* Program */

DATA baseball;
   INFILE 'c:\MyRawData\Transpos.dat';
   INPUT Team $ Player Type $ Entry;
PROC SORT DATA = baseball;
   BY Team Player;
PROC PRINT DATA = baseball;
   TITLE 'Baseball Data After Sorting and Before Transposing';

* Transpose data so salary and batavg are variables;
PROC TRANSPOSE DATA = baseball OUT = flipped;
   BY Team Player;
   ID Type;
   VAR Entry;
PROC PRINT DATA = flipped;
   TITLE 'Baseball Data After Transposing';
RUN;

/* Section 6.14 */

/* Walk.dat */

54 youth  35.5 21 adult  21.6  6 adult  25.8 13 senior 29.0
38 senior 40.3 19 youth  39.6  3 adult  19.0 25 youth  47.3
11 adult  21.9  8 senior 54.3 41 adult  43.0 32 youth  38.6

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

/* Section 7.2 */

/* TropicalSales.dat */

240W 02-07-2000 Ginger    120
356W 02-08-2000 Heliconia  60
356W 02-08-2000 Anthurium 300
188R 02-11-2000 Ginger     24
188R 02-11-2000 Anthurium  24
240W 02-12-2000 Protea    180
356W 02-12-2000 Ginger    240

/* Program */

%LET flowertype = Ginger;

* Read the data and subset with a macro variable;
DATA flowersales;
   INFILE 'c:\MyRawData\TropicalSales.dat';
   INPUT CustomerID $ @6 SaleDate MMDDYY10. 
      @17 Variety $9. Quantity;
   IF Variety = "&flowertype";

* Print the report using a macro variable;
PROC PRINT DATA = flowersales;
   FORMAT SaleDate WORDDATE18.;
   TITLE "Sales of &flowertype";
RUN;

/* Section 7.3 */

/* Program */

* Macro to print 5 largest sales;
%MACRO sample;
   PROC SORT DATA = flowersales;
      BY DESCENDING Quantity;
   PROC PRINT DATA = flowersales (OBS = 5);
      FORMAT SaleDate WORDDATE18.;
      TITLE 'Five Largest Sales';
%MEND sample;

* Read the flower sales data;
DATA flowersales;
   INFILE 'c:\MyRawData\TropicalSales.dat';
   INPUT CustomerID $ @6 SaleDate MMDDYY10. @17
      Variety $9. Quantity;
RUN;

* Invoke the macro;
%sample
RUN;

/* Section 7.4 */

/* Program */

* Macro with parameters;
%MACRO select(customer=,sortvar=);
   PROC SORT DATA = flowersales OUT = salesout;
      BY &sortvar;
      WHERE CustomerID = "&customer";
   PROC PRINT DATA = salesout;
      FORMAT SaleDate WORDDATE18.;
      TITLE "Orders for Customer Number &customer";
%MEND select;

* Read all the flower sales data;
DATA flowersales;
   INFILE 'c:\MyRawData\TropicalSales.dat';
   INPUT CustomerID $ @6 SaleDate MMDDYY10. @17
      Variety $9. Quantity;
RUN;

*Invoke the macro;
%select(customer = 356W, sortvar = Variety)
%select(customer = 240W, sortvar = Quantity)
RUN;

/* Section 7.5 */

/* Program */

%MACRO dailyreports;
   %IF &SYSDAY = Monday %THEN %DO;
      PROC PRINT DATA = flowersales;
         FORMAT SaleDate WORDDATE18.;
         TITLE 'Monday Report: Current Flower Sales';
   %END;
   %ELSE %IF &SYSDAY = Tuesday %THEN %DO;
      PROC MEANS DATA = flowersales;
         CLASS Variety;
         VAR Quantity;
         TITLE 'Tuesday Report: Summary of Flower Sales';
   %END;
%MEND dailyreports;
DATA flowersales;
   INFILE 'c:\MyRawData\TropicalSales.dat';
   INPUT CustomerID $ @6 SaleDate MMDDYY10. @17
      Variety $9. Quantity;
RUN;
%dailyreports
RUN;

/* Section 7.6 */

/* Program */

* Read the raw data;
DATA flowersales;
   INFILE 'c:\MySASLib\TropicalSales.dat';
   INPUT CustomerID $4. @6 SaleDate MMDDYY10. @17
      Variety $9. Quantity;
PROC SORT DATA = flowersales;
   BY DESCENDING Quantity;

* Find biggest order and pass the customer id to a macro variable;
DATA _NULL_;
   SET flowersales;
   IF _N_ = 1 THEN CALL SYMPUT("selectedcustomer",CustomerID);
   ELSE STOP;

PROC PRINT DATA = flowersales;
   WHERE CustomerID = "&selectedcustomer";
   TITLE "Customer &selectedcustomer Had the Single Largest Order";
RUN;

/* Section 8.1 */

/* Scores.dat */

56 78 84 73 90 44 76 87 92 75
85 67 90 84 74 64 73 78 69 56
87 73 100 54 81 78 69 64 73 65

/* Program */

DATA class;
   INFILE 'c:\MyRawData\Scores.dat';
   INPUT Score @@;
PROC UNIVARIATE DATA = class;
   VAR Score;
   TITLE;
RUN;

/* Section 8.2 */

/* Picbooks.dat */

34 30 29 32 52 25 24 27 31 29
24 26 30 30 30 29 21 30 25 28
28 28 29 38 28 29 24 24 29 31
30 27 45 30 22 16 29 14 16 29
32 20 20 15 28 28 29 31 29 36

/* Program */

DATA booklengths;
   INFILE 'c:\MyRawData\Picbooks.dat';
   INPUT NumberOfPages @@;
*Produce summary statistics;
PROC MEANS DATA=booklengths N MEAN MEDIAN CLM ALPHA=.10;
   TITLE 'Summary of Picture Book Lengths';
RUN;

/* Section 8.3 */

/* Bus.dat */

E O E L E L R O E O E O E O R L R O R L
R O E O R L E O R L R O E O E O R L E L
E O R L E O R L E O R L E O R O E L E O
E O E O E O E L E O E O R L R L R O R L
E L E O R L R O E O E O E O E L R O R L

/* Program */

DATA bus;
   INFILE 'c:\MyRawData\Bus.dat';
   INPUT BusType $  OnTimeOrLate $ @@;
PROC FREQ DATA = bus;
   TABLES BusType * OnTimeOrLate / CHISQ;
   TITLE;
RUN;

/* Section 8.4 */

/* Exercise.dat */

56 6 2   78 7 4   84 5 5   73 4 0   90 3 4
44 9 0   76 5 1   87 3 3   92 2 7   75 8 3
85 1 6   67 4 2   90 5 5   84 6 5   74 5 2
64 4 1   73 0 5   78 5 2   69 6 1   56 7 1
87 8 4   73 8 3  100 0 6   54 8 0   81 5 4
78 5 2   69 4 1   64 7 1   73 7 3   65 6 2

/* Program */

DATA class;
   INFILE 'c:\MyRawData\Exercise.dat';
   INPUT Score Television Exercise @@;
PROC CORR DATA = class;
   VAR Television Exercise;
   WITH Score;
   TITLE 'Correlations for Test Scores';
   TITLE2 'With Hours of Television and Exercise';
RUN;

/* Section 8.5 */

/* Baseball.dat */

50 110  49 135  48 129  53 150  48 124
50 143  51 126  45 107  53 146  50 154
47 136  52 144  47 124  50 133  50 128
50 118  48 135  47 129  45 126  48 118
45 121  53 142  46 122  47 119  51 134
49 130  46 132  51 144  50 132  50 131

/* Program */

DATA hits;
   INFILE 'c:\MyRawData\Baseball.dat';
   INPUT Height Distance @@;
* Perform regression analysis, plot observed values with regression line;
PROC REG DATA = hits;
   MODEL Distance = Height;
   PLOT Distance * Height;
   TITLE 'Results of Regression Analysis';
RUN;

/* Section 8.7 */

/* Softball.dat */

red  55 red  48 red  53 red  47 red  51 red  43
red  45 red  46 red  55 red  54 red  45 red  52
blue 46 blue 56 blue 48 blue 47 blue 54 blue 52
blue 49 blue 51 blue 45 blue 48 blue 55 blue 47
gray 55 gray 45 gray 47 gray 56 gray 49 gray 53
gray 48 gray 53 gray 51 gray 52 gray 48 gray 47
pink 53 pink 53 pink 58 pink 56 pink 50 pink 55
pink 59 pink 57 pink 49 pink 55 pink 56 pink 57
gold 53 gold 55 gold 48 gold 45 gold 47 gold 56
gold 55 gold 46 gold 47 gold 53 gold 51 gold 50

/* Program */

DATA soft;
   INFILE 'c:\MyRawData\Softball.dat';
   INPUT Team $ Height @@;
* Use ANOVA to run one-way analysis of variance;
PROC ANOVA DATA = soft;
   CLASS Team;
   MODEL Height = Team;
   MEANS Team / SCHEFFE;
   TITLE "Girls' Heights on Softball Teams";
RUN;

/* Appendix F */

/* First Program (Page 271) */

LIBNAME sports 'c:\MySASLib';
PROC SQL;
   CREATE TABLE sports.customer
      (CustomerNumber num,
       Name           char(17),
       Address        char(20));

   INSERT INTO sports.customer
      VALUES (101, 'Murphy''s Sports ', '115 Main St.        ')
      VALUES (102, 'Sun N Ski        ', '2106 Newberry Ave.  ')
      VALUES (103, 'Sports Outfitters', '19 Cary Way         ')
      VALUES (104, 'Cramer & Johnson ', '4106 Arlington Blvd.')
      VALUES (105, 'Sports Savers    ', '2708 Broadway      ');

   TITLE 'The Sports Customer Data';
   SELECT *
      FROM sports.customer;


/* Second Program (Page 272) */

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
TITLE 'The Sports Customer Data';
RUN;

/* Third Program (page 272) */

LIBNAME sports 'c:\MySASLib';
PROC SQL;
   TITLE 'Customer Number 102';
   SELECT *
      FROM sports.customer
      WHERE CustomerNumber = 102;

/* Fourth Program (page 273) */

LIBNAME sports 'c:\MySASLib';
DATA sunnski;
   SET sports.customer;
   IF CustomerNumber = 102;
PROC PRINT DATA = sunnski;
   TITLE 'Customer Number 102';
RUN;

/* Fifth Program (page 274) */

LIBNAME sports 'c:\MySASLib';
DATA outfitters;
   SET sports.customer;
   IF Name = 'Sports Outfitters';
PROC PRINT DATA = outfitters;
RUN;

/* Sixth Program (page 275) */

LIBNAME sports 'c:\MySASLib';
DATA outfitters;
   SET sports.customer;
   WHERE Name = 'Sports Outfitters';
PROC PRINT DATA = outfitters;
RUN;

/* Seventh Program (page 275) */

LIBNAME sports 'c:\MySASLib';
PROC PRINT DATA = sports.customer;
   WHERE Name = 'Sports Outfitters';
RUN;


