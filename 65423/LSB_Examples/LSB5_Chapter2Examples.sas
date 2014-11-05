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


/* Chapter 2 */

/* Section 2.4 */

/* First program */

* Read internal data into SAS data set uspresidents; 
DATA uspresidents;    
INPUT President $ Party $ Number;
   DATALINES;
Adams F 2
Lincoln R 16
Grant R 18
Kennedy D 35
   ;
RUN;


/* Section 2.4 */

/* Second program */

* Read data from external file into SAS data set; 
DATA uspresidents;
   INFILE 'c:\MyRawData\President.dat';
   INPUT President $ Party $ Number;
RUN;


/* Section 2.5 */

/* Program */

* Create a SAS data set named toads;
* Read the data file ToadJump.dat using list input;
DATA toads;
   INFILE 'c:\MyRawData\ToadJump.dat';
   INPUT ToadName $ Weight Jump1 Jump2 Jump3;
RUN;
* Print the data to make sure the file was read correctly;
PROC PRINT DATA = toads;
   TITLE 'SAS Data Set Toads';
RUN;


/* Section 2.6 */

/* Program */

* Create a SAS data set named sales;
* Read the data file OnionRing.dat using column input;
DATA sales;
   INFILE 'c:\MyRawData\OnionRing.dat';
   INPUT VisitingTeam $ 1-20 ConcessionSales 21-24 BleacherSales 25-28
         OurHits 29-31 TheirHits 32-34 OurRuns 35-37 TheirRuns 38-40;
RUN;
* Print the data to make sure the file was read correctly;
PROC PRINT DATA = sales;
   TITLE 'SAS Data Set Sales';
RUN;


/* Section 2.7 */

/* Program */

* Create a SAS data set named contest;
* Read the file Pumpkin.dat using formatted input;
DATA contest;
   INFILE 'c:\MyRawData\Pumpkin.dat';
   INPUT Name $16. Age 3. +1 Type $1. +1 Date MMDDYY10.
         (Score1 Score2 Score3 Score4 Score5) (4.1);
RUN;
* Print the data set to make sure the file was read correctly;
PROC PRINT DATA = contest;
   TITLE 'Pumpkin Carving Contest';
RUN;


/* Section 2.9 */

/* Program */

* Create a SAS data set named nationalparks;
* Read a data file NatPark.dat mixing input styles;
DATA nationalparks;
   INFILE 'c:\MyRawData\NatPark.dat';
   INPUT ParkName $ 1-22 State $ Year @40 Acreage COMMA9.;
RUN;
PROC PRINT DATA = nationalparks;
   TITLE 'Selected National Parks';
RUN;


/* Section 2.10 */

/* Program */


DATA canoeresults;
  INFILE 'c:\MyRawData\Canoes.dat';
  INPUT  @'School:' School $ @'Time:' RaceTime :STIMER8.;
RUN;
PROC PRINT DATA = canoeresults;
  TITLE "Concrete Canoe Men's Sprint Results";
RUN;


/* Section 2.11 */

/* Program */

* Create a SAS data set named highlow;
* Read the data file using line pointers;
DATA highlow;
   INFILE 'c:\MyRawData\Temperature.dat';
   INPUT City $ State $ 
         / NormalHigh NormalLow
         #3 RecordHigh RecordLow;
RUN;
PROC PRINT DATA = highlow;
   TITLE 'High and Low Temperatures for July';
RUN;


/* Section 2.12 */

/* Program */

* Input more than one observation from each record;
DATA rainfall;
   INFILE 'c:\MyRawData\Precipitation.dat';
   INPUT City $ State $ NormalRain MeanDaysRain @@;
RUN;
PROC PRINT DATA = rainfall;
   TITLE 'Normal Total Precipitation and';
   TITLE2 'Mean Days with Precipitation for July';
RUN;


/* Section 2.13 */

/* Program */

* Use a trailing @, then delete surface streets;
DATA freeways;
   INFILE 'c:\MyRawData\Traffic.dat';
   INPUT Type $ @;
   IF Type = 'surface' THEN DELETE;
   INPUT Name $ 9-38 AMTraffic PMTraffic;
RUN;
PROC PRINT DATA = freeways;
   TITLE 'Traffic for Freeways';
RUN;


/* Section 2.14 */

/* First Program */

DATA icecream;
   INFILE 'c:\MyRawData\IceCreamSales.dat' FIRSTOBS = 3;
   INPUT Flavor $ 1-9 Location BoxesSold;
RUN;


/* Second Program */

DATA icecream;
   INFILE 'c:\MyRawData\IceCreamSales2.dat' FIRSTOBS = 3 OBS=5;
   INPUT Flavor $ 1-9 Location BoxesSold;
RUN;


/* Third Program */

DATA class102;
   INFILE 'c:\MyRawData\AllScores.dat' MISSOVER;
   INPUT Name $ Test1 Test2 Test3 Test4 Test5;
RUN; 


/* Fourth Program */

DATA homeaddress;
   INFILE 'c:\MyRawData\Address.dat' TRUNCOVER;
   INPUT Name $ 1-15 Number 16-19 Street $ 22-37;
RUN;


/* Section 2.15 */

/* First Program */

DATA reading;
   INFILE 'c:\MyRawData\Books.dat' DLM = ',';
   INPUT Name $ Week1 Week2 Week3 Week4 Week5;
RUN;


/* Third Program (second program intentionally omitted) */

DATA music;
   INFILE 'c:\MyRawData\Bands.csv' DLM = ',' DSD MISSOVER;
   INPUT BandName :$30. GigDate :MMDDYY10. EightPM NinePM TenPM ElevenPM;
RUN;
PROC PRINT DATA = music;
   TITLE 'Customers at Each Gig';
RUN;


/* Section 2.16 */

/* Program */

PROC IMPORT DATAFILE ='c:\MyRawData\Bands2.csv' OUT = music REPLACE;
RUN;
PROC PRINT DATA = music;    
   TITLE 'Customers at Each Gig'; 
RUN;


/* Section 2.17 */

/* Program (data must be read from a spreadsheet) */

PROC IMPORT DATAFILE = 'c:\MyExcel\OnionRing.xls' DBMS=XLS OUT = sales;
RUN;
PROC PRINT DATA = sales;
   TITLE 'SAS Data Set Read From Excel File'; 
RUN;


/* Section 2.18 */

/* First Program */

DATA distance; 
   Miles = 26.22;
   Kilometers = 1.61 * Miles;
RUN;
PROC PRINT DATA = distance;
RUN;

/* Second Program */
DATA Bikes.distance; 
   Miles = 26.22;
   Kilometers = 1.61 * Miles;
RUN;
PROC PRINT DATA = Bikes.distance;
RUN;


/* Section 2.19 */

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


/* Section 2.20 */

/* First Program */

DATA 'c:\MySASLib\magnolia';
   INFILE 'c:\MyRawData\Mag.dat';
   INPUT ScientificName $ 1-14 CommonName $ 16-32 MaximumHeight
      AgeBloom Type $ Color $;
RUN;

/* Second Program */
PROC PRINT DATA = 'c:\MySASLib\magnolia';
   TITLE 'Magnolias';
RUN;


/* Section 2.21 */

/* Program */

DATA funnies (LABEL = 'Comics Character Data');
   INPUT Id Name $ Height Weight DoB MMDDYY8. @@;
   LABEL Id  = 'Identification no.'
      Height = 'Height in inches'
      Weight = 'Weight in pounds'
      DoB    = 'Date of birth';
   INFORMAT DoB MMDDYY8.;
   FORMAT DoB WORDDATE18.;
   DATALINES;
53      Susie 42 41 07-11-81 
54      Charlie 46 55 10-26-54
55      Calvin 40 35 01-10-81 
56      Lucy 46 52 01-13-55
   ;
* Use PROC CONTENTS to describe data set funnies;
PROC CONTENTS DATA = funnies;
RUN;
