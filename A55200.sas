/****************************************************************\
| This file contains selected programs that appear in            |
| "The Little SAS(R) Book: A Primer," by Lora D. Delwiche and    |
| Susan J. Slaughter (pubcode 55200).                            |
|                                                                |
| Copyright (C) 1995 by SAS Institute Inc., Cary, NC, USA.       |
|                                                                |
| SAS(R) is a registered trademark of SAS Institute Inc.         |
|                                                                |
| SAS Institute does not assume responsibility for the accuracy  |
| of any material presented in this file.                        |
|                                                                |
\****************************************************************/


---------------
Chapter 2
---------------

*** Program Section 2.3 ***;

DATA distance;
   miles = 23;
   kilometr = 1.61 * miles;
PROC PRINT DATA = distance;
RUN;


*** Program Section 2.6 ***;

* Create a SAS data set named distance;
* Convert miles to kilometers;
DATA distance;
   miles = 23;
   kilometr = 1.61 * miles;
* Print the results;
PROC PRINT DATA = distance;
RUN;

---------------
Chapter 3
---------------

*** First Program Section 3.1 ***;

* Read internal data into SAS data set uspres;
DATA uspres;
   INPUT pres $ party $ number;
   CARDS;
Adams     F  2
Lincoln   R 16
Grant     R 18
Kennedy   D 35
   ;
RUN;

*** Data for Second Program Section 3.1 - presiden.dat ***;

Adams     F  2
Lincoln   R 16
Grant     R 18
Kennedy   D 35

*** Second Program Section 3.1 ***;

* Read data from external file into SAS data set;
DATA uspres;
   INFILE 'c:\mydir\presiden.dat';
   INPUT pres $ party $ number;
RUN;

*** Data for Program Section 3.2 - toadjump.dat ***;

Lucky 2.3 1.9 . 3.0
Spot 4.6 2.5 3.1 .5
Tubs 7.1 . . 3.8
Hop 4.5 3.2 1.9 2.6
Noisy 3.8 1.3 1.8
1.5
Winner 5.7 . . .

*** Program Section 3.2 ***;

* Create a SAS data set named toads;
* Read the data file toadjump.dat using list input;
DATA toads;
   INFILE 'toadjump.dat';
   INPUT toadname $ weight jump1 jump2 jump3;
* Print the data to make sure the file was read correctly;
PROC PRINT;
   TITLE 'SAS Data Set Toads';
RUN;

*** Data for Program Section 3.3 - onions.dat ***;

Columbia Peaches      35  67  1 10  2  1
Plains Peanuts       210      2  5  0  2
Gilroy Garlics        151035 12 11  7  6
Sacramento Tomatoes  124  85 15  4  9  1

*** Program Section 3.3 ***;

* Create a SAS data set named sales;
* Read the data file onions.dat using column input;
DATA sales;
   INFILE 'onions.dat';
   INPUT vteam $ 1-20 csales 21-24 bsales 25-28 ourhits 29-31
         vhits 32-34 ourruns 35-37 vruns 38-40;
* Print the data to make sure the file was read correctly;
PROC PRINT;
   TITLE 'SAS Data Set Sales';
RUN;

*** Data for Program Section 3.4 - pumpkin.dat ***;

Alicia Grossman  13 c 10-28-93 7.8 6.5 7.2 8.0 7.9
Matthew Lee       9 D 10-30-93 6.5 5.9 6.8 6.0 8.1
Elizabeth Garcia 10 C 10-29-93 8.9 7.9 8.5 9.0 8.8
Lori Newcombe     6 D 10-30-93 6.7 5.6 4.9 5.2 6.1
Jose Martinez     7 d 10-31-93 8.9 9.510.0 9.7 9.0
Brian Williams   11 C 10-29-93 7.8 8.4 8.5 7.9 8.0

*** Program Section 3.4 ***;

* Create a SAS data set contest;
* Read the file pumpkin.dat using formatted input;
DATA contest;
   INFILE 'pumpkin.dat';
   INPUT name $16. age 3. +1 type $1. +1 date MMDDYY8.
         (score1 score2 score3 score4 score5) (4.1);
* Print the data set to make sure the file was read correctly;
PROC PRINT;
   TITLE 'Pumpkin Carving Contest';
RUN;

*** Data for Program Section 3.6 - park.dat ***;

Yellowstone              ID/MT/WY 1872    4,065,493
Everglades               FL 1934          1,398,800
Yosemite                 CA 1864            760,917
Great Smoky Mountians    NC/TN 1926         520,269
Wolf Trap Farm           VA 1966                130

*** Program Section 3.6 ***;

* Create a SAS data set named natparks;
* Read a data file park.dat mixing input styles;
DATA natparks;
   INFILE 'park.dat';
   INPUT parkname $ 1-22 state $ year @43 acreage COMMA9.;
PROC PRINT;
   TITLE 'Selected National Parks';
RUN;

*** Data for Program Section 3.7 - temperat.dat ***;

Nome AK
55 44
88 29
Miami FL
90 75
97 65
Raleigh NC
88 68
105 50

*** Program Section 3.7 ***;

* Create a SAS data set named highlow;
* Read the data file using line pointers;
DATA highlow;
   INFILE 'temperat.dat';
   INPUT city $ state $
         / normhigh normlow
         #3 rechigh reclow;
PROC PRINT;
   TITLE 'High and Low Temperatures for July';
RUN;

*** Data for Program Section 3.8 - precip.dat ***;

Nome AK 2.5 15 Miami FL 6.75
18 Raleigh NC . 12

*** Program Section 3.8 ***;

* Create a SAS data set using the @@ line pointer;
* Read the data file precip.dat;
DATA rainfall;
   INFILE 'precip.dat';
   INPUT city $ state $ normrain daysrain @@;
PROC PRINT;
   TITLE 'Normal Total Precipitation and';
   TITLE2 ' Mean Days with Precipitation for July';
RUN;

*** Data for Program Section 3.9 - traffic.dat ***;

freeway 408                           3684 3459
surface Martin Luther King Jr. Blvd.  1590 1234
surface Broadway                      1259 1290
surface Rodeo Dr.                     1890 2067
freeway 608                           4583 3860
freeway 808                           2386 2518
surface Lake Shore Dr.                1590 1234
surface Pennsylvania Ave.             1259 1290

*** Program Section 3.9 ***;


* Use a trailing @ to delete surface streets;
DATA freeways;
   INFILE 'traffic.dat';
   INPUT type $ @;
   IF type = 'surface' THEN DELETE;
   INPUT name $ 9-38 amtraff pmtraff;

PROC PRINT;
   TITLE 'Traffic for Freeways';
RUN;

*** Data for First Program Section 3.10 - sales.dat ***;

Ice-cream sales data for the summer of 1993
Flavor     Location   Boxes sold
Chocolate  213        123
Vanilla    213        512
Chocolate  415        242

*** First Program Section 3.10 ***;

DATA icecrm;
   INFILE 'sales.dat' FIRSTOBS = 3;
   INPUT flavor $ 1-9 loc boxes;
RUN;
proc print;
run;

*** Data for Second Program Section 3.10 - scores.dat ***;

Nguyen 89 76 91 82
Ramos 67 72 80 76 86
Robbins 76 65 79

*** Second Program Section 3.10 ***;

DATA class102;
   INFILE 'scores.dat' MISSOVER;
   INPUT name $ test1 test2 test3 test4 test5;
RUN;

*** Data for Third Program Section 3.10 - address.dat ***;

John Garcia     114  Maple Ave.
Slyvia Chung   1302  Washington Drive
Martha Newton    45  S.E. 14th St.

*** Third Program Section 3.10 ***;

DATA homeadd;
   INFILE 'address.dat' PAD;
   INPUT name $ 1-15 number 16-19 street $ 22-37;
RUN;

*** Data for Fourth Program Section 3.10 - books.dat ***;

Grace,3,1,5,2,6
Martin,1,2,4,1,3
Scott,9,10,4,8,6

*** Fourth Program Section 3.10 ***;

DATA reading;
   INFILE 'books.dat' DLM = ',';
   INPUT name $ week1 week2 week3 week4 week5;
RUN;

*** Program Section 3.11 ***;

DATA funnies;
   INPUT id name $ height weight dob MMDDYY8.;
   LABEL id  = 'Identification no.'
      height = 'Height in inches'
      weight = 'Weight in pounds'
      dob    = 'Date of birth';
   INFORMAT dob MMDDYY8.;
   FORMAT dob WORDDATE18.;
   CARDS;
53 Susie    42  41  07-11-81
54 Charlie  46  55  10-26-54
55 Calvin   40  35  01-10-81
56 Lucy     46  52  01-13-55
   ;
* Use PROC CONTENTS to describe data set funnies;
PROC CONTENTS DATA = funnies;
RUN;

*** First Program Section 3.12 ***;

DATA distance;
   miles = 23;
   kilometr = 1.61 * miles;
RUN;

*** Second Program Section 3.12 ***;

LIBNAME sasbook 'c:\mysaslib';
DATA sasbook.distance;
   miles = 23;
   kilometr = 1.61 * miles;
RUN;

*** Data for First Program Section 3.13 - mag.dat ***;

M. grandiflora Southern Magnolia 80 15 E white
M. campbellii                    80 20 D rose
M. liliiflora  Lily Magnolia     12  4 D purple
M. soulangiana Saucer Magnolia   25  3 D pink
M. stellata    Star Magnolia     10  3 D white

*** First Program Section 3.13 ***;

LIBNAME plants 'c:\mysaslib';
DATA plants.magnolia;
   INFILE 'mag.dat';
   INPUT sciname $ 1-14 comname $ 16-32 maxhigh
      agebloom type $ color $;
RUN;

*** Second Program Section 3.13 ***;

LIBNAME example 'c:\mysaslib';
PROC PRINT DATA = example.magnolia;
   TITLE 'Magnolias';
RUN;

*** Data for Program Section 3.14 - toads2.dat ***;

Lucky,2.3,1.9,,3.0
Spot,4.6,2.5,3.1,.5
Tubs,7.1,,,3.8
Hop,4.5,3.2,1.9,2.6
Noisy,3.8,1.3,1.8,1.5
Winner,5.7,,,,

*** Program Section 3.14 ***;

* Read raw data using the DLM= and DSD options;
DATA toads;
   INFILE 'toads2.dat' DLM = ',' DSD;
   INPUT toadname $ weight jump1 jump2 jump3;
RUN;

*** First Program Section 3.15 ***;

LIBNAME mylib 'c:\mysaslib';
DATA mylib.toads;
   INPUT toadname $ weight jump1 jump2 jump3;
   CARDS;
lucky 2.3 1.9 . 3.0
Spot 4.6 2.5 3.1 .5
Tubs 7.1 . . 3.8
;
RUN;

*** Second Program Section 3.15 ***;

LIBNAME mylib 'c:\mysaslib';
LIBNAME trans XPORT 'a:\toads.tra';
PROC COPY IN = mylib OUT = trans;
   SELECT toads;
RUN;

*** Third Program Section 3.15 ***;

LIBNAME sdata 'Hard Disk:SAS data';
LIBNAME trans XPORT 'pcdisk:toads.tra';
PROC COPY IN = trans OUT = sdata;
RUN;

*** Data for First Program Section 3.16 - tooth.dat ***;

white    1 5 4 end
blue     2 4 3 mid
white    1 5 2 end
green    2 4 1 mid
magenta  3 2 2 mid

*** First Program Section 3.16 ***;

LIBNAME survey 'c:\mysaslib';
DATA survey.teeth;
   INFILE 'tooth.dat';
   INPUT favcolor $ mint banana cola squeeze $;
PROC PRINT;
RUN;

*** Second Program Section 3.16 ***;

LIBNAME survey 'c:\mysaslib';
DATA _NULL_;
   SET survey.teeth;
   FILE 'newfile.dat';
   PUT mint banana cola favcolor squeeze;
RUN;

---------------
Chapter 4
---------------

*** Data for Program Section 4.1 - garden.dat ***;

Gregor  10  2  40    0
Molly   15  5  10 1000
Luther  50 10  15   50
Susan   20  0   .   20

*** Program Section 4.1 ***;


* Modify home data set with assignment statements;
DATA home;
   INFILE 'garden.dat';
   INPUT name $ 1-7 tomato zucchini peas grapes;
   year = 1995;
   type = 'home';
   zucchini = zucchini * 10;
   total = tomato + zucchini + peas + grapes;
   pertom = (tomato / total) * 100;
PROC PRINT;
   TITLE 'Home Gardening Survey';
RUN;

*** Data for Program Section 4.2 - pumpkin.dat ***;

Alicia Grossman  13 c 10-28-93 7.8 6.5 7.2 8.0 7.9
Matthew Lee       9 D 10-30-93 6.5 5.9 6.8 6.0 8.1
Elizabeth Garcia 10 C 10-29-93 8.9 7.9 8.5 9.0 8.8
Lori Newcombe     6 D 10-30-93 6.7 5.6 4.9 5.2 6.1
Jose Martinez     7 d 10-31-93 8.9 9.510.0 9.7 9.0
Brian Williams   11 C 10-29-93 7.8 8.4 8.5 7.9 8.0

*** Program Section 4.2 ***;

DATA contest;
   INFILE 'pumpkin.dat';
   INPUT name $16. age 3. +1 type $1. +1 date MMDDYY8.
         (sc1 sc2 sc3 sc4 sc5) (4.1);
   avgsc = MEAN(sc1, sc2, sc3, sc4, sc5);
   dayenter = DAY(date);
   type = UPCASE(type);
PROC PRINT;
   TITLE 'Pumpkin Carving Contest';
RUN;

*** Data for Program Section 4.4 - cars.dat ***;

Corvette 1955 .      2 black
XJ6      1985 Jaguar 2 teal
Mustang  1966 Ford   4 red
Miata    1992 .      . silver
CRX      1991 Honda  2 black
Camaro   1990 .      4 red

*** Program Section 4.4 ***;

DATA sporty;
   INFILE 'cars.dat';
   INPUT model $ year make $ seats color $;
   IF year < 1970 THEN status = 'classic';
   IF model = 'Corvette' OR model = 'Camaro' THEN make = 'Chevy';
   IF model = 'Miata' THEN DO;
      make = 'Mazda';
      seats = 2;
   END;
PROC PRINT;
   TITLE "Eddy's Excellent Emporium of Used Sports Cars";
RUN;

*** Data for Program Section 4.5 - home.dat ***;

Bob     kitchen cabinet face-lift   1253.00
Shirley bathroom addition          11350.70
Silvia  paint exterior                  .
Al      backyard gazebo             3098.63
Norm    paint interior               647.77
Kathy   second floor addition      75362.93

*** Program Section 4.5 ***;

* Group observations by cost;
DATA homefix;
   INFILE 'home.dat';
   INPUT owner $ 1-7 descrip $ 9-33 cost;
   IF cost = . THEN costgrp = 'missing';
      ELSE IF cost < 2000 THEN costgrp = 'low';
      ELSE IF cost < 10000 THEN costgrp = 'medium';
      ELSE costgrp = 'high';
PROC PRINT;
   TITLE 'Home Improvement Cost Groups';
RUN;

*** Data for Program Section 4.6 - shakesp.dat ***;

A Midsummer Night's Dream 1595 comedy
Comedy of Errors          1590 comedy
Hamlet                    1600 tragedy
Macbeth                   1606 tragedy
Richard III               1594 history
Romeo and Juliet          1596 tragedy
Taming of the Shrew       1593 comedy
Tempest                   1611 romance

*** Program Section 4.6 ***;

* Choose only comedies;
DATA comedy;
   INFILE 'shakesp.dat';
   INPUT title $ 1-26 year type $;
   IF type = 'comedy';
PROC PRINT;
   TITLE 'Shakespearean Comedies';
RUN;

*** Data for Program Section 4.7 - dates.dat ***;

A. Jones    01jan60 09-15-90
M. Rincon   05oct49 01-24-92
Z. Grandage 18mar88 10-10-93
K. Kaminaka 29feb80 05-29-94

*** Program Section 4.7 ***;

DATA libcards;
   INFILE 'dates.dat';
   INPUT name $12. bdate DATE8. effdate MMDDYY8.;
   expdate = effdate + (365.25 * 3);
   expqtr = QTR(expdate);
   IF effdate > '01jan94'D THEN newcard = 'yes';
PROC PRINT;
   FORMAT effdate MMDDYY8. expdate WEEKDATE17.;
   TITLE 'SAS Dates without and with Formats';
RUN;

*** Data for Program Section 4.9 - games.dat ***;

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

*** Program Section 4.9 ***;


DATA runs;
   INFILE 'games.dat';
   INPUT month 1 day 3-4 team $ 6-25 hits 27-28 runs 30-31;
   RETAIN maxruns;
   maxruns = MAX(maxruns, runs);
   runstodt + runs;
PROC PRINT;
   TITLE "Season's Record to Date";
RUN;

*** Data for Program Sections 4.10 and 4.11 - wbrk.dat ***;

Albany          54 4 3 5 9 9 2 1 4 4 9
Richmond        33 5 2 4 3 9 2 9 3 3 3
Oakland         27 1 3 2 9 9 9 3 4 2 3
Richmond        41 4 3 5 5 5 2 9 4 5 5
Berkeley        18 3 4 9 1 4 9 3 9 3 2

*** Program Section 4.10 ***;

DATA songs;
   INFILE 'wbrk.dat';
   INPUT city $ 1-15 age domk wj hwow simbh kt aomm libm tr filp ttr;
   ARRAY song (10) domk wj hwow simbh kt aomm libm tr filp ttr;
   DO i = 1 TO 10;
      IF song(i) = 9 THEN song(i) = .;
   END;
PROC PRINT;
   TITLE 'WBRK Song Survey';
RUN;

*** Program Section 4.11 ***;

DATA songs;
   INFILE 'wbrk.dat';
   INPUT city $ 1-15 age domk wj hwow simbh kt aomm libm tr filp ttr;
   ARRAY new (10) song1 - song10;
   ARRAY old (10) domk -- ttr;
   DO i = 1 TO 10;
      IF old(i) = 9 THEN new(i) = .;
         ELSE new(i) = old(i);
   END;
   avgsc = MEAN(OF song1 - song10);
PROC PRINT;
   TITLE 'WBRK Song Survey';
RUN;

---------------
Chapter 5
---------------

*** Data for Program Section 5.2 - artists.dat ***;

Mary Cassatt          impressionism      U
Paul Cezanne          post-impressionism F
Edgar Degas           impressionism      F
Paul Gauguin          post-impressionism F
Claude Monet          impressionism      F
Pierre Auguste Renoir impressionism      F
Vincent van Gogh      post-impressionism N

*** Programs Section 5.2 ***;

LIBNAME art 'c:\mysaslib';
DATA art.style;
   INFILE 'artists.dat';
   INPUT name $ 1-21 genre $ 23-40 home $ 42;
RUN;

LIBNAME art 'c:\mysaslib';
PROC PRINT DATA = art.style;
   WHERE genre = 'impressionism';
   TITLE 'Major Impressionist Painters';
   FOOTNOTE 'F = France N = Netherlands U = US';
RUN;

*** Data for Program Section 5.3 - sealife.dat ***;

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

*** Program Section 5.3 ***;

DATA marine;
   INFILE 'sealife.dat';
   INPUT name $ family $ length;
* Sort the data;
PROC SORT OUT = seasort NODUPKEY;
   BY family DESCENDING length;
PROC PRINT DATA = seasort;
   TITLE 'Whales and Sharks';
RUN;

*** Data for Program Sections 5.4 and 5.5 - candy.dat ***;

Adriana    21  3/21/95 MP  7
Nathan     14  3/21/95 CD 19
Matthew    14  3/21/95 CD 14
Claire     14  3/22/95 CD 11
Caitlin    21  3/24/95 CD  9
Ian        21  3/24/95 MP 18
Chris      14  3/25/95 CD  6
Anthony    21  3/25/95 MP 13
Stephen    14  3/25/95 CD 10
Erika      21  3/25/95 MP 17

*** Program Section 5.4 ***;

DATA sales;
   INFILE 'candy.dat';
   INPUT name $ 1-11 class @15 returned MMDDYY8. candy $ quantity;
   profit = quantity * 1.25;
PROC SORT;
   BY class;
PROC PRINT;
   BY class;
   SUM profit;
   VAR name returned candy profit;
   TITLE 'Candy Sales for Field Trip by Class';
RUN;

*** Program Section 5.5 ***;

DATA sales;
   INFILE 'candy.dat';
   INPUT name $ 1-11 class @15 returned MMDDYY8. candy $ quantity;
   profit = quantity * 1.25;
PROC PRINT;
   VAR name returned candy profit;
   FORMAT returned DATE7. profit DOLLAR6.2;
   TITLE 'Candy Sale Data Using Formats';
RUN;

*** Data for Program Section 5.7 - cars.dat ***;

19 1 14000 Y
45 1 65000 G
72 2 35000 B
31 1 44000 Y
58 2 83000 W

*** Program Section 5.7 ***;

DATA carsurv;
   INFILE 'cars.dat';
   INPUT age sex income color $;
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
PROC PRINT;
   FORMAT sex gender. age agegroup. color $col. income DOLLAR8.;
   TITLE 'Survey Results Printed with User-Defined Formats';
RUN;

*** Data for Program Section 5.8 - candy.dat ***;

Adriana    21 3/21/95 MP  7
Nathan     14 3/21/95 CD 19
Matthew    14 3/21/95 CD 14
Claire     14 3/22/95 CD 11
Caitlin    21 3/24/95 CD  9
Ian        21 3/24/95 MP 18
Chris      14 3/25/95 CD  6
Anthony    21 3/25/95 MP 13
Stephen    14 3/25/95 CD 10
Erika      21 3/25/95 MP 17

*** Program Section 5.8 ***;

* Write a report with FILE and PUT statements;
DATA _NULL_;
   INFILE 'candy.dat';
   INPUT name $ 1-11 class @15 returned MMDDYY8. candy $ quantity;
   profit = quantity * 1.25;
   FILE 'student.rep' PRINT;
   TITLE;
   PUT @5 'Candy sales report for ' name 'from classroom ' class
     // @5 'Congratulations!  You sold ' quantity 'boxes of candy'
     / @5 'and earned ' profit DOLLAR6.2 ' for our field trip.';
   PUT _PAGE_;
RUN;

*** Data for Program Sections 5.9 and 5.10 - flowers.dat ***;

756-01  05/04/97 120  80 110
834-01  05/12/97  90 160  60
901-02  05/18/97  50 100  75
834-01  06/01/97  80  60 100
756-01  06/11/97 100 160  75
901-02  06/19/97  60  60  60
756-01  06/25/97  85 110 100

*** Program Section 5.9 ***;

DATA sales;
   INFILE 'flowers.dat';
   INPUT custid $ @9 saledate MMDDYY8. petunia snapdrag marigold;
   month = MONTH(saledate);
PROC SORT;
   BY month;
* Calculate means by month for flower sales;
PROC MEANS;
   BY month;
   VAR petunia snapdrag marigold;
   TITLE 'Summary of Flower Sales by Month';
RUN;

*** Program Section 5.10 ***;

DATA sales;
   INFILE 'flowers.dat';
   INPUT custid $ @9 saledate MMDDYY8. petunia snapdrag marigold;
PROC SORT;
   BY custid;
* Calculate means by custid, output sum and mean to new data set;
PROC MEANS NOPRINT;
   BY custid;
   VAR petunia snapdrag marigold;
   OUTPUT OUT = totals MEAN(petunia snapdrag marigold) = mp ms mm
      SUM(petunia snapdrag marigold) = petunia snapdrag marigold;
PROC PRINT;
   TITLE 'Sum of Flower Data over Customer ID';
   FORMAT mp ms mm 3.;
RUN;

*** Data for Program Section 5.11 - ufo.dat ***;

85845 AM R white with long tail
85776 PM z bright white light
85873 PM R white and red flashing lights
85879 AM R little green men carrying boomboxes
86790 PM C throbbing purple light
86823 PM R giant toads

*** Program Section 5.11 ***;

DATA ufos;
   INFILE 'ufo.dat' PAD;
   INPUT repnum time $ zone $ descrip $ 12-46;
* Print tables for zone and time by zone;
PROC FREQ;
   TABLES zone time * zone;
   TITLE 'UFO Reports';
RUN;

*** Data for Program Section 5.12 - onions.dat ***;

Columbia Peaches    102  67  1 10 2 1
Plains Peanuts      210  54  2  5 0 1
Gilroy Garlics       15 335 12 11 7 6
Sacramento Tomatoes 124 185 15  4 9 1
Boise Spuds         162  75  5  6 2 3
Orlando Tangelos    144  86  9  3 4 2
Des Moines Corncobs  73 210 10  5 9 3

*** Program Section 5.12 ***;

DATA sales;
   INFILE 'onions.dat';
   INPUT vteam $ 1-20 csales bsales ourhits vhits ourruns vruns;
   action = ourhits + vhits + ourruns + vruns;

* Plot action by bsales;
PROC PLOT;
   PLOT bsales * action = vteam;
   TITLE 'Onion Ring Sales';
RUN;

---------------
Chapter 6
---------------

*** Data for Program Section 6.1 - train.dat ***;

10:10  6 21
12:15 10 56
15:30 10 25
11:30  8 34
13:15  8 12
10:45  6 13
20:30  6 32
23:15  6 12

*** First Program Section 6.1 ***;

* Define library name for permanent SAS data set trains;
LIBNAME mylib 'c:\mydir';
DATA mylib.trains;
   INFILE 'train.dat';
   INPUT time TIME5. cars people;
RUN;

*** Second Program Section 6.1 ***;

* Read the SAS data set mylib.trains with a SET statement;
LIBNAME mylib 'c:\mydir';
DATA avgtrain;
   SET mylib.trains;
   avgpeopl = people / cars;
PROC PRINT;
   TITLE 'Average Number of People per Train Car';
   FORMAT time TIME5.;
RUN;

*** Data for South Entrance Sections 6.2 and 6.3 - south.dat ***;

S 43 3 27
S 44 3 24
S 45 3  2

*** Data for North Entrance Sections 6.2 and 6.3 - north.dat ***;

N 21 5 41 1
N 87 4 33 3
N 65 2 67 1
N 66 2  7 1

*** Program Section 6.2 ***;

DATA sentr;
   INFILE 'south.dat';
   INPUT enter $ passnum prtysize age;
PROC PRINT;
   TITLE 'South Entrance Data';

DATA nentr;
   INFILE 'north.dat';
   INPUT enter $ passnum prtysize age lot;
PROC PRINT;
   TITLE 'North Entrance Data';

* Create a data set, both, combining nentr and sentr;
* Create a variable, paid, based on value of variable age;
DATA both;
   SET sentr nentr;
   IF age = . THEN paid = .;
      ElSE IF age < 3  THEN paid = 0;
      ELSE IF age < 65 THEN paid = 17;
      ELSE paid = 12;
PROC PRINT;
   TITLE 'Both Entrances';
RUN;


*** Program Section 6.3 ***;

DATA sentr;
   INFILE 'south.dat';
   INPUT enter $ passnum prtysize age;
PROC PRINT;
   TITLE 'South Entrance Data';

DATA nentr;
   INFILE 'north.dat';
   INPUT enter $ passnum prtysize age lot;
PROC SORT;
   BY passnum;
PROC PRINT;
   TITLE 'North Entrance Data';

* Interleave observations by passnum;
DATA intrleav;
   SET nentr sentr;
   BY passnum;
PROC PRINT;
   TITLE 'Both Entrances, By Pass Number';
RUN;

*** Entrance Data Section 6.4 - enter.dat ***;

N 21  5 41
S 43  3 27
S 44  3 24
S 45  3  2
N 65  2 67
N 66  2  7
N 87  4 41

*** Screaming Data Section 6.4 - scream.dat ***;

21 1
43 0
44 1
66 0
87 0

*** Program Section 6.4 ***;

DATA entrance;
   INFILE 'enter.dat';
   INPUT enter $ passnum prtysize age;

DATA screams;
   INFILE 'scream.dat';
   INPUT passnum scream;

* Merge data sets by passnum;
DATA all;
   MERGE entrance screams;
   BY passnum;
PROC PRINT;
   TITLE 'SAS Data Set All';
   TITLE2 'Merge of Entrance Data and Screaming Data';
RUN;

*** Videos Data Section 6.5 - vid.dat ***;

Adorable Abs                  aerobics 12.99
Aerobic Childcare for Parents aerobics 13.99
Judy Murphy's Fun Fitness     step     12.99
Lavonnes' Low Impact Workout  aerobics 13.99
Muscle Makers                 weights  15.99
Rock N Roll Step Workout      step     12.99

*** Discount Data Section 6.5 - disc.dat ***;

aerobics  .20
step      .30
weights   .25

*** Program Section 6.5 ***;

DATA videos;
   INFILE 'vid.dat';
   INPUT name $ 1-29 extype $ regprice;
PROC SORT DATA = videos;
   BY extype;

DATA discount;
   INFILE 'disc.dat';
   INPUT extype $ adjust;

* Perform many-to-one match merge;
DATA prices;
   MERGE videos discount;
   BY extype;
   newprice = ROUND(regprice - (regprice * adjust), .01);
PROC PRINT DATA = prices;
   TITLE 'Price List for May 21-27';
RUN;

*** Data for Program Sections 6.6 and 6.7 - vidsales.dat ***;

Adorable Abs                  aerobics 1930
Aerobic Childcare for Parents aerobics 2250
Judy Murphy's Fun Fitness     step     4150
Lavonnes' Low Impact Workout  aerobics 1130
Muscle Makers                 weights  2230
Rock N Roll Step Workout      step     1190

*** Program Section 6.6 ***;

DATA videos;
   INFILE 'vidsales.dat';
   INPUT title $ 1-29 extype $ sales;
PROC SORT DATA = videos;
   BY extype;

* Summarize sales by extype and print;
PROC MEANS NOPRINT;
   VAR sales;
   BY extype;
   OUTPUT OUT = sumdata SUM(sales) = total;
PROC PRINT DATA = sumdata;
   TITLE 'Summary Data Set';

* Merge totals with the original data set;
DATA videosum;
   MERGE videos sumdata;
   BY extype;
   percent = sales / total * 100;
PROC PRINT DATA = videosum;
   BY extype;
   ID extype;
   VAR title sales total percent;
   TITLE 'Sales Share by Type of Exercise';
RUN;

*** Program Section 6.7 ***;

DATA videos;
   INFILE 'vidsales.dat';
   INPUT title $ 1-29 extype $ sales;

* Find the grand total for sales;
* Output total to a data set and print;
PROC MEANS NOPRINT;
   VAR sales;
   OUTPUT OUT = sumdata SUM(sales) = grandtot;
PROC PRINT DATA = sumdata;
   TITLE 'Summary Data Set';

* Combine the grand total with the original data;
DATA videosum;
   IF _N_ = 1 THEN SET sumdata;
   SET videos;
   percent = sales / grandtot * 100;
PROC PRINT DATA = videosum;
   VAR title extype sales grandtot percent;
   TITLE 'Overall Sales Share';
RUN;

*** Data for First Program Section 6.8 - admit.dat ***;

620135 Smith    234 Aspen St.     12-21-75 m CBC 02-16-93
645722 Miyamoto 65 3rd. Ave.      04-03-36 f MCR 05-30-94
645739 Jensvold 505 Glendale Ave. 06-15-60 f HLT 09-23-88
874329 Kazoyan  .                 .        . MCD 01-15-94

*** First Program Section 6.8 ***;

LIBNAME perm 'c:\mysaslib';
DATA perm.patients;
   INFILE 'admit.dat';
   INPUT acctno lastname $ 8-16 address $ 17-34
      bdate MMDDYY8. sex $ inscode $ 46-48 @50 lastdate MMDDYY8.;
RUN;

*** Data for Second Program Section 6.8 - newadmit.dat ***;

620135 .        .                 .        . HLT 06-15-94
874329 Kazoyan  76-C La Vista     04-24-54 m .   06-15-94
235777 Harman   5656 Land Way     01-18-60 f MCD 06-15-94

*** Second Program Section 6.8 ***;

LIBNAME perm 'c:\mysaslib';
DATA trans;
   INFILE 'newadmit.dat';
   INPUT acctno lastname $ 8-16 address $ 17-34
      bdate MMDDYY8. sex $ inscode $ 46-48 @50 lastdate MMDDYY8.;
PROC SORT DATA = trans;
   BY acctno;

* Update patient data with transactions;
DATA perm.patients;
   UPDATE perm.patients trans;
   BY acctno;
PROC PRINT DATA = perm.patients;
   FORMAT bdate lastdate MMDDYY8.;
   TITLE 'Admissions Data';
RUN;

*** Customer Data for Section 6.10 - address.dat ***;

101 Murphy's Sports   115 Main St.
102 Sun N Ski         2106 Newberry Ave.
103 Sports Outfitters 19 Cary Way
104 Cramer & Johnson  4106 Arlington Blvd.
105 Sports Savers     2708 Broadway

*** Orders Data for Section 6.10 - ordersq3.dat ***;

102 562.01
104 254.98
104 1642.00
101 3497.56
102 385.30

*** Program Section 6.10 ***;

DATA customer;
   INFILE 'address.dat' PAD;
   INPUT custno name $ 5-21 address $ 23-42;
DATA orders;
   INFILE 'ordersq3.dat';
   INPUT custno total;
PROC SORT DATA = orders;
   BY custno;

* Combine the data sets using the IN= option;
DATA noorders;
   MERGE customer orders (IN = recent);
   BY custno;
   IF recent = 0;
PROC PRINT;
   TITLE 'Customers with No Orders in the Third Quarter';
RUN;

*** Data for Program Section 6.11 - zoo.dat ***;

bears      Mammalia  254 15
elephants  Mammalia  542 65
flamingos  Aves      434  8
frogs      Amphibian 120  3
kangaroos  Mammalia  332 12
lions      Mammalia  450 53
parrots    Aves      345  6
snakes     Reptilia  120 14
tigers     Mammalia  449 42
zebras     Mammalia  409 15

*** Program Section 6.11 ***;

DATA mammals others;
   INFILE 'zoo.dat';
   INPUT animal $ 1-10 class $ 12-20 viewed favorite;
   IF class = 'Mammalia' THEN OUTPUT mammals;
      ELSE OUTPUT others;
PROC PRINT DATA = mammals;
   TITLE 'Survey Results for Mammals';
PROC PRINT DATA = others;
   TITLE 'Survey Results for Non-mammals';
RUN;

*** First Program Section 6.12 ***;

* Create data for variables x and y;
DATA generate;
   DO x = 1 TO 6;
      y = x ** 2;
      OUTPUT;
   END;
PROC PRINT;
   TITLE 'Generated Data';
RUN;

*** Data for Second Program Section 6.12 - movies.dat ***;

Jan Varsity 56723 Downtown 69831 Super-6 70025
Feb Varsity 62137 Downtown 43901 Super-6 81534
Mar Varsity 49982 Downtown 55783 Super-6 69800

*** Second Program Section 6.12 ***;

* Create three observations for each data line read
*   using three OUTPUT statements;
DATA theaters;
   INFILE 'movies.dat';
   INPUT month $ location $ tickets @;
   OUTPUT;
   INPUT location $ tickets @;
   OUTPUT;
   INPUT location $ tickets;
   OUTPUT;
PROC PRINT;
   TITLE 'Ticket Sales';
RUN;

*** Data for Program Section 6.13 - transpos.dat ***;

Garlics 10 salary 43000
Peaches  8 salary 38000
Garlics 21 salary 51000
Peaches 10 salary 47500
Garlics 10 batavg .281
Peaches  8 batavg .252
Garlics 21 batavg .265
Peaches 10 batavg .301

*** Program Section 6.13 ***;

DATA baseball;
   INFILE 'transpos.dat';
   INPUT team $ player type $ entry;
PROC SORT;
   BY team player;
PROC PRINT;
   TITLE 'Baseball Data After Sorting and Before Transposing';

* Transpose data so salary and batavg are variables;
PROC TRANSPOSE DATA = baseball OUT = flipped;
   BY team player;
   ID type;
   VAR entry;
PROC PRINT;
   TITLE 'Baseball Data After Transposing';
RUN;

*** Data for Program Section 6.14 - walk.dat ***;

54 youth  35.5 21 adult  21.6  6 adult  25.8 13 senior 29.0
38 senior 40.3 19 youth  39.6  3 adult  19.0 25 youth  47.3
11 adult  21.9  8 senior 54.3 41 adult  43.0 32 youth  38.6

*** Program Section 6.14 ***;

DATA walkers;
   INFILE 'walk.dat';
   INPUT entry agegrp $ time @@;
PROC SORT;
   BY time;
* Create a new variable, place;
DATA ordered;
   SET walkers;
   place = _N_;
PROC PRINT;
   TITLE 'Results of Walk';

PROC SORT;
   BY agegrp time;
* Set the data by agegrp and keep the first
  observation in each group;
DATA winners;
   SET ordered;
   BY agegrp;
   IF FIRST.agegrp = 1;
PROC PRINT;
   TITLE 'Winners in Each Age Group';
RUN;

---------------
Chapter 7
---------------

*** Data for Program Section 7.1 - scores.dat ***;

56 78 84 73 90 44 76 87 92 75
85 67 90 84 74 64 73 78 69 56
87 73 100 54 81 78 69 64 73 65

*** Program Section 7.1 ***;

DATA class;
   INFILE 'scores.dat';
   INPUT score @@;
PROC UNIVARIATE;
   VAR score;
   TITLE;
RUN;

*** Data for Program Section 7.2 - study.dat ***;

56 6 2  78 7 4  84 5 5  73 4 2  90 6 4
44 2 0  76 5 1  87 6 3  92 6 7  75 8 3
85 7 1  67 4 2  90 5 5  84 6 5  74 5 2
64 4 1  73 8 5  78 5 2  69 6 1  56 4 1
87 8 4  73 8 3 100 5 6  54 8 0  81 5 4
78 5 2  69 4 1  64 7 1  73 7 3  65 4 4

*** Program Section 7.2 ***;

DATA class;
   INFILE 'study.dat';
   INPUT score study exercise @@;
PROC CORR;
   VAR study exercise;
   WITH score;
   TITLE 'Correlations for Test Scores';
   TITLE2 'With Hours of Studying and Exercise';
RUN;

*** Data for Program Section 7.3 - baseball.dat ***;

50 110  49 135  48 129  53 150  48 124
50 143  51 126  45 107  53 146  50 154
47 136  52 144  47 124  50 133  50 128
50 118  48 135  47 129  45 126  48 118
45 121  53 142  46 122  47 119  51 134
49 130  46 132  51 144  50 132  50 131

*** Program Section 7.3 ***;

DATA hits;
   INFILE 'baseball.dat';
   INPUT height distance @@;
* Perform regression analysis, plot observed and predicted values;
PROC REG;
   MODEL distance = height;
   PLOT distance * height = '*' P. * height = 'p' / OVERLAY;
   TITLE 'Results of Regression Analysis';
RUN;

*** Data for Program Section 7.5 - softball.dat ***;

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

*** Program Section 7.5 ***;

DATA soft;
   INFILE 'softball.dat';
   INPUT team $ height @@;
* Use ANOVA to run one-way analysis of variance;
PROC ANOVA;
   CLASS team;
   MODEL height = team;
   MEANS team / SCHEFFE;
   TITLE "Girls' Heights on Softball Teams";
RUN;

---------------
Chapter 8
---------------

*** First Program Section 8.3 ***;

* Read the data file toadjump.dat using list input
DATA toads;
   INFILE 'toadjump.dat';
   INPUT toadname $ weight jump1 jump2 jump3;
RUN;

*** Second Program Section 8.3 ***;

* Read the data file toadjump.dat using list input;
DATA toads
   INFILE 'toadjump.dat';
   INPUT toadname $ weight jump1 jump2 jump3;
RUN;

*** Data for Program Section 8.4 - toadjmp2.dat ***;

13  65 1.9 3.0
25 131 2.5 3.1 .5
10 202 3.8
8  128 3.2 1.9 2.6
3  162
21  99 2.4 1.7 3.0

*** Program Section 8.4 ***;

DATA toads;
   INFILE 'toadjmp2.dat';
   INPUT toadnum weight jump1 jump2 jump3;
PROC PRINT;
   TITLE 'SAS Data Set Toads';
RUN;

*** First Data File Section 8.5 - temps.dat ***;

Nome AK
55 44
88 29
Miami FL
90 75
97 65
Raliegh NC
88 68

*** Second Data File Section 8.5 - temps.dat ***;

Nome AK
88 29
Miami FL
90 75
97 65
Raliegh NC
88 68
105 50

*** Third Data File Section 8.5 - temps.dat ***;

Nome AK
55 44
88 29
Miami FL
90 75
97 65
Raliegh NC
88 68
105

*** Program Section 8.5 ***;

DATA highlow;
   INFILE 'temps.dat';
   INPUT city $ state $ / normhigh normlow / rechigh reclow;
RUN;

*** Data for Program Section 8.7 - jump.dat ***;

Lucky  1.9  .  3.0
Spot   2.5 3.1 0.5
Tubs    .   .  3.8
Hop    3.2 1.9 2.6
Noisy  1.3 1.8 1.5
Winner  .   .   .

*** Programs Section 8.7 ***;

DATA toads;
   INFILE 'jump.dat';
   INPUT toadname $ jump1 jump2 jump3;
   avgjump = (jump1 + jump2 + jump3) / 3;
RUN;

DATA missing;
   INFILE 'jump.dat';
   INPUT toadname $ jump1 jump2 jump3;
   avgjump = (jump1 + jump2 + jump3) / 3;
   IF avgjump = .;

PROC PRINT;
   TITLE 'Observations with Missing Values Generated';
RUN;

*** First Program Section 8.8 ***;

DATA numchar;
   a = 5;
   b = '5';
   c = a * b;
   d = 98;
   e = SUBSTR(d, 2, 1);
RUN;

*** Second Program Section 8.8 ***;

DATA numchar;
   a = 5;
   b = '5';
   newb = INPUT(b, 1.);
   c = a * newb;
   d = 98;
   newd = PUT(d, 2.);
   e = SUBSTR(newd, 2, 1);
RUN;

*** Data for Program Section 8.9 - class.dat ***;

Derek   72 64  56 39
Kathy   98 82 100 48
Linda   53 60  66 42
Michael 80 55  95 50

*** First Program Section 8.9 ***;

* Keep only students with mean below 70;
DATA lowscore;
   INFILE 'class.dat';
   INPUT name $ score1 score2 score3 hmwk;
   hmwk = hmwk * 2;
   avgscore = MEAN(score1 + score2 + score3 + hmwk);
   IF avgscore < 70;
RUN;

*** Second Program Section 8.9 ***;

* Keep only students with mean below 70;
DATA lowscore;
   INFILE 'class.dat';
   INPUT name $ score1 score2 score3 hmwk;
   hmwk = hmwk * 2;
   avgscore = MEAN(score1 + score2 + score3 + hmwk);
   PUT name= score1= score2= score3= hmwk= avgscore=;
   IF avgscore < 70;
RUN;

*** Program Section 8.11 ***;

DATA highscor (KEEP= name total);
   INPUT name $ score1 score2;
   IF scor1 > 5;
   total = score1 + score2;
   CARDS;
PROC PRINT;
   VAR name score2 total;
RUN;

*** Data for Program Section 8.12 - cars.dat ***;

19 1 14000 Y
45 1 65000 G
72 2 35000 B
31 1 44000 Y
58 2 83000 W

*** First Program Section 8.12 ***;

DATA carsurv;
   INFILE 'cars.dat';
   INPUT age sex income color $;
   IF age < 20 THEN agegroup = 'Teen';
      ELSE IF age < 65 THEN agegroup = 'Adult';
      ELSE agegroup = 'Senior';
PROC PRINT;
   TITLE 'Car Color Survey Results';
RUN;

*** Second Program Section 8.12 ***;

* Use the LENGTH statement to set the length of agegroup;
DATA carsurv;
   INFILE 'cars.dat';
   INPUT age sex income color $;
   LENGTH agegroup $7;
   IF age < 20 THEN agegroup = 'Teen';
      ELSE IF age < 65 THEN agegroup = 'Adult';
      ELSE agegroup = 'Senior';

PROC PRINT;
   TITLE 'Car Color Survey Results';
RUN;

---------------
Appendix C
---------------

*** Data for First Program Appendix C - survey.dat ***;

Gail    14 1 5 3 1 3 5
Jim     56 2 3 2 2 3 2
Susan   34 1 4 2 1 1 5
Barbara 45 1 3 3 1 2 4
Steve   13 2 5 4 1 4 5

*** First SAS Program Appendix C ***;

LIBNAME mydir '[]';
DATA mydir.survey;
   INFILE 'survey.dat';
   INPUT name $ 1-8 age
         sex song1-song5;
   LABEL song1 = 'Black Water/DB'
      song2 = 'Bennie and the Jets/EJ'
      song3 = 'Stayin Alive/BG'
      song4 = 'Fire and Rain/JT'
      song5 = 'Country Roads/JD';
PROC FORMAT;
   VALUE sex 1 = 'female'
             2 = 'male';
TITLE 'Music Market Survey';
PROC PRINT;
PROC FREQ;
   table song1 sex*song1;
   FORMAT sex sex.;
RUN;

---------------
Appendix D
---------------

*** Data for Program Appendix D - gpa.dat ***;

Mary   19 3.45
Bob    20 3.12
Scott  22 2.89
Marie  18 3.75
Ruth   20 2.67

*** SAS Program Appendix D ***;

DATA grades;
   INFILE 'gpa.dat';
   INPUT name $ age gpa;
PROC PRINT;
RUN;

*** C Program Appendix D ***;

#include <stdio.h>
#include <stdlib.h>
#define N 1000

void main(void)
{
       FILE *input_fp;
       int i=0,num;

       struct student
       {
                    char name[16];
              int age;
              float gpa;
       } grades[N];

          if ((input_fp=fopen("c:\\lorapgms\\app-d.dat","r"))==NULL)
             exit(-1);
          while (fscanf(input_fp,"%s %d %f",\
       grades[i].name,&grades[i].age,&grades[i].gpa)!=EOF)
             ++i;

       for (num=i, i=0; i<num; ++i)
             printf("%s %2d %.2f\n",\
             grades[i].name,grades[i].age,grades[i].gpa);
}

---------------
Appendix E
---------------

*** First Program Appendix E ***;

LIBNAME sports 'c:\mysaslib';
PROC SQL;
   CREATE TABLE sports.customer
      (custno  num,
       name    char(17),
       address char(20));

   INSERT INTO sports.customer
      VALUES (101, 'Murphy''s Sports ', '115 Main St.        ')
      VALUES (102, 'Sun N Ski        ', '2106 Newberry Ave.  ')
      VALUES (103, 'Sports Outfitters', '19 Cary Way         ')
      VALUES (104, 'Cramer & Johnson ', '4106 Arlington Blvd.')
      VALUES (105, 'Sports Savers    ', '2708 Broadway       ');

   TITLE 'The SPORTS.CUSTOMER Data';
   SELECT *
      FROM sports.customer;

*** Second Program Appendix E ***;

LIBNAME sports 'c:\mysaslib';
DATA sports.customer;
   INPUT custno name $ 5-21 address $ 23-42;
   CARDS;
101 Murphy's Sports   115 Main St.
102 Sun N Ski         2106 Newberry Ave.
103 Sports Outfitters 19 Cary Way
104 Cramer & Johnson  4106 Arlington Blvd.
105 Sports Savers     2708 Broadway
   ;
PROC PRINT;
   TITLE 'The SPORTS.CUSTOMER Data';
RUN;

*** Third Program Appendix E ***;

LIBNAME sports 'c:\mysaslib';
PROC SQL;
   TITLE 'Customer Number 102';
   SELECT *
      FROM sports.customer
      WHERE custno = 102;

*** Fourth Program Appendix E ***;

LIBNAME sports 'c:\mysaslib';
DATA sunnski;
   SET sports.customer;
   IF custno = 102;
PROC PRINT;
   TITLE 'Customer Number 102';
RUN;

*** Fifth Program Appendix E ***;

LIBNAME sports 'c:\mysaslib';
DATA sport;
   SET sports.customer;
   IF name = 'Sports Outfitters';
PROC PRINT DATA = sport;
RUN;

*** Sixth Program Appendix E ***;

LIBNAME sports 'c:\mysaslib';
DATA sport;
   SET sports.customer;
   WHERE name = 'Sports Outfitters';
PROC PRINT DATA = sport;
RUN;

*** Seventh Program Appendix E ***;

LIBNAME sports 'c:\mysaslib';
PROC PRINT DATA = sports.customer;
   WHERE name = 'Sports Outfitters';
RUN;




