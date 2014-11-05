/******************************************************/
/* Data set EMPHOURS                                  */
/******************************************************/
data emphours;
  attrib empid length=$6 label='Employee ID';
  input empid emphours;
datalines;
6XBIFI 38.5
WA4D7N 22.0
VPA9EF 43.0
TZ6OUB 11.5
L6KKHS 29.0
8TN7WL 38.0
;;;

/******************************************************/
/* Data set EMPLOYEES                                 */
/******************************************************/
data employees;
  attrib empid length=$6 label='Employee ID'
         empln length=$30 label='Employee Last Name'
         empfn length=$25 label='Employee First Name'
         empmi length=$1  label='Employee Middle Initial'
         gender length=$1 label='Employee Gender'
         startdate length=8 format=mmddyy10.
         emppaylevel length=$5;

    array lastnames{279} $ 15 _temporary_ (
      'Williams' 'Anderson' 'Scott' 'Martin' 'Bean' 'Howard' 'Thompson' 'Roberts' 'Martinez' 'Miller' 'Lee' 'Jones' 'Kelly'
'Perez' 'Morgan' 'Smith' 'Hill' 'Miller' 'Taylor' 'Ward' 'Smith' 'Hall' 'Howard' 'Jones' 'Butler' 'Reed' 'Peterson' 'Price'
'Rodriguez' 'Bell' 'Harris' 'Allen' 'Adams' 'Morgan' 'Perez' 'Bell' 'Smith' 'Foster' 'Smith' 'Gray' 'Johnson' 'Kelly' 'Davis'
'Morgan' 'Scott' 'Phillips' 'White' 'Moore' 'Gonzalez' 'Sanchez' 'Williams' 'Wilson' 'Scott' 'Alexander' 'Gonzalez'
'Williams' 'Clark' 'Williams' 'Moore' 'Ross' 'Hernandez' 'White' 'James' 'Smith' 'Adams' 'Williams' 'Williams' 'Baker'
'Lewis' 'Bell' 'Edwards' 'Johnson' 'Phillips' 'Stewart' 'Gonzales' 'Davis' 'Green' 'Jones' 'Perry' 'Brooks' 'Brown' 'Cox'
'Hughes' 'White' 'Carter' 'Hernandez' 'Martinez' 'Bryant' 'Wilson' 'Chang' 'Thompson' 'Hall' 'Martin' 'Baker' 'Simmons'
'Prasad' 'White' 'Long' 'Cox' 'Baker' 'Harris' 'Peterson' 'Rodriguez' 'Alexander' 'Green' 'Long' 'Lee' 'Russell' 'Thomas'
'Bennett' 'Nelson' 'Martin' 'Williams' 'Brown' 'Butler' 'Garcia' 'Davis' 'Sanders' 'Jones' 'Murphy' 'Chua' 'Jones'
'Nelson' 'Miller' 'Smith' 'Thomas' 'Hernandez' 'Anderson' 'Thomas' 'Henderson' 'Brooks' 'Patterson' 'Adams' 'Parker'
'King' 'Murphy' 'Johnson' 'Lewis' 'Foster' 'Davis' 'Moore' 'Gray' 'Scott' 'Garcia' 'White' 'Williams' 'Peterson'
'Washington' 'Williams' 'Clark' 'Brown' 'Smith' 'Johnson' 'Jones' 'Patterson' 'Diaz' 'Baker' 'Perry' 'Davis' 'Thomas'
'Morgan' 'Baker' 'Stewart' 'Miller' 'Morris' 'Parker' 'Harris' 'Washington' 'Smith' 'Hall' 'Taylor' 'Martinez' 'Thompson'
'Davis' 'Davis' 'Brown' 'Brown' 'Williams' 'Parker' 'Moore' 'Davis' 'Thompson' 'Moore' 'Smith' 'Roberts' 'Jones' 'Bryant'
'Jackson' 'Baker' 'Campbell' 'Brown' 'Hill' 'Smith' 'Cox' 'Miller' 'Robinson' 'Blauvelt' 'Adams' 'Johnson' 'Turner' 'Smith'
'Chou' 'Martinez' 'Reed' 'Jackson' 'White' 'Mitchell' 'Nelson' 'Smith' 'Adams' 'Ward' 'Cook' 'Chang' 'Williams'
'Perez' 'Mitchell' 'Anderson' 'Davis' 'Phillips' 'Thomas' 'Stewart' 'Smith' 'Kelly' 'White' 'Stewart' 'Taylor' 'Wilson'
'Jones' 'Parker' 'Scott' 'Jones' 'Thomas' 'Walker' 'Cox' 'Thomas' 'Lee' 'Ramirez' 'Brown' 'Johnson' 'Coleman' 'Johnson'
'Davis' 'Butler' 'Mitchell' 'Rodriguez' 'Mitchell' 'Hernandez' 'Cooper' 'Cooper' 'Jones' 'Moore' 'Martinez' 'Brown'
'Adams' 'Coleman' 'Torres' 'Brown' 'Brown' 'Turner' 'Chang' 'Jones' 'Wilson' 'Edwards' 'Jackson' 'Johnson' 'Davis'
'Sanders' 'Miller' 'Clark' 'Long' 'Smith' 'Baker' 'Richardson' 'Jones' 'Smith' 'Martin' 'Gray' 'Bryant' 'Hernandez'
);

  array firstnames{200} $ 15 _temporary_ (
            'Michael' 'Emily' 'Matthew' 'Jessica' 'Jacob' 'Ashley' 'Christopher' 'Sarah'
            'Joshua' 'Samantha' 'Nicholas' 'Taylor' 'Tyler' 'Hannah' 'Brandon' 'Alexis'
            'Austin' 'Rachel' 'Andrew' 'Elizabeth' 'Daniel' 'Kayla' 'Joseph' 'Megan'
            'David' 'Amanda' 'Zachary' 'Brittany' 'John' 'Madison' 'Ryan' 'Lauren'
            'James' 'Brianna' 'William' 'Victoria' 'Anthony' 'Jennifer' 'Justin' 'Stephanie'
            'Jonathan' 'Courtney' 'Alexander' 'Nicole' 'Robert' 'Alyssa' 'Christian' 'Rebecca'
            'Kyle' 'Morgan' 'Kevin' 'Alexandra' 'Jordan' 'Amber' 'Thomas' 'Jasmine'
            'Benjamin' 'Danielle' 'Samuel' 'Haley'  'Cody' 'Katherine' 'Jose' 'Abigail'
            'Dylan' 'Anna' 'Aaron' 'Olivia' 'Eric' 'Shelby' 'Brian' 'Kelsey'
            'Nathan' 'Maria' 'Steven' 'Allison' 'Adam' 'Sydney' 'Timothy' 'Kaitlyn'
            'Jason' 'Kimberly' 'Logan' 'Melissa' 'Charles' 'Savannah' 'Patrick' 'Mary'
            'Richard' 'Brooke' 'Sean' 'Natalie' 'Hunter' 'Michelle' 'Caleb' 'Julia'
            'Cameron' 'Jordan' 'Noah' 'Sara' 'Jesse' 'Erin' 'Juan' 'Tiffany'
            'Connor' 'Emma' 'Alex' 'Gabrielle' 'Mark' 'Chelsea' 'Jeremy' 'Destiny'
            'Luis' 'Christina' 'Dakota' 'Sabrina' 'Devin' 'Marissa' 'Stephen' 'Vanessa'
            'Gabriel' 'Andrea' 'Ethan' 'Sierra' 'Trevor' 'Mariah' 'Jared' 'Katelyn'
            'Evan' 'Paige' 'Bryan' 'Laura' 'Carlos' 'Madeline' 'Tristan' 'Jacqueline'
            'Nathaniel' 'Cheyenne' 'Ian' 'Kristen' 'Isaiah' 'Heather' 'Jeffrey' 'Briana'
            'Travis' 'Kelly' 'Lewis' 'Breanna' 'Luke' 'Mackenzie' 'Chase' 'Alexandria'
            'Kenneth' 'Miranda' 'Dustin' 'Caroline' 'Paul' 'Erica' 'Antonio' 'Shannon'
            'Elijah' 'Monica' 'Taylor' 'Katie' 'Bradley' 'Jenna' 'Blake' 'Caitlin'
            'Garrett' 'Bailey' 'Isaac' 'Lindsey' 'Marcus' 'Kathryn' 'Mitchell' 'Amy'
            'Jack' 'Cassandra' 'Tanner' 'Angela' 'Miguel' 'Alicia' 'Adrian' 'Crystal'
            'Lucas' 'Hailey' 'Corey' 'Catherine'  'Edward' 'Grace' 'Peter' 'Jamie'
            'Malik' 'Angelica' 'Gregory' 'Leah' 'Dalton' 'Molly' 'Victor' 'Alexa');

  retain alphanum 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  drop alphanum i j pos fnidx l m n;

  array level{4} $ 1 _temporary_ ('T','P','A','M');
  array levelb{3} $ 3 _temporary_ ('I' 'II' 'III');
  array levelc{4} $ 1 _temporary_ ('a' 'b' 'c' 'd');

  call streaminit(3810);

  do j=1 to 3224;
    empid=' ';
    do i=1 to 6;
      pos=ceil(rand('uniform')*36);
      empid=cats(empid,substr(alphanum,pos,1));
    end;
    startdate=8035+ceil(rand('uniform')*11600);
    empln=lastnames{ceil(rand('uniform')*dim(lastnames))};
    fnidx=ceil(rand('uniform')*dim(firstnames));
    empfn=firstnames{fnidx};
    if mod(fnidx,2)=1 then gender='M';
    else gender='F';
    empmi=substr(alphanum,ceil(rand('uniform')*26),1);

    l=rand('table',.20,.45,.20,.15);
    m=rand('table',.55,.30,.15);
    n=rand('table',.50,.25,.15,.1);

    emppaylevel=cats(level{l},levelb{m},levelc{n});

    output;
  end;
run;

/******************************************************/
/* Data set CONFROOMS                                 */
/******************************************************/
data confrooms;
  attrib roomid   length=$5
         roomno   length=8
         floor    length=$2
         building length=$20
         capacity length=8;
  input roomid $ capacity;
  roomno=input(substr(roomid,4,2),2.);
  floor=ifc(substr(roomid,2,1)='0',substr(roomid,3,1),substr(roomid,2,2));
  if substr(roomid,1,1)='A' then building='Anderson';
  else if substr(roomid,1,1)='B' then building='Baylor';
  else if substr(roomid,1,1)='C' then building='Cummings';
datalines;
A0210 50
A0120 75
B0B05 100
B1004 15
B0212 30
C0P01 150
;;;

/******************************************************/
/* Data set ROOMSCHEDULE                              */
/******************************************************/
data roomschedule;
  attrib meetingdate format=mmddyy10.
         meetingtime format=time5.
         roomid length=$5;
  input meetingdate mmddyy10. +1 meetingtime time5. +1 roomid $;
datalines;
08/13/2013 08: 5 Jul 2012 15:37:51
08/13/2013 11:30 B1004
08/13/2013 01:15 A0120
08/13/2013 02:00 B1004
;;;

/******************************************************/
/* Data set ROOMSCHEDULE2                             */
/******************************************************/
data roomschedule2;
  attrib meetingdate format=mmddyy10.
         meetingtime format=time5.
         roomid length=$5;
  input meetingdate mmddyy10. +1 meetingtime time5. +1 roomid $;
datalines;
08/13/2013 08:30 C0P01
08/13/2013 11:30 B1004
08/13/2013 01:15 A0122
08/13/2013 02:00 B1004
;;;

/***************************************************/
/* Data Set CODELOOKUP                             */
/***************************************************/
data codelookup;
  attrib code length=$6
         codedesc length=$25
         codedate length=8 format=mmddyy10.;
  code='AB871K';
  codedesc='Credit';
  codedate='08feb2013'd;
  output;
  code='GG401P';
  codedesc=' ';
  codedate=.;
  output;
run;

/***************************************************/
/* Data Set PATIENTS_TODAY                         */
/***************************************************/
data patients_today;
  attrib ptid length=$8 label='Patient ID'
         ptln length=$30 label='Patient Last Name'
         ptfn length=$25 label='Patient First Name'
         ptmi length=$1  label='Patient Middle Initial'
         appt length=8   format=datetime13.;

  input ptid $ ptln $ ptfn $ ptmi $;
  appt=dhms('09jul2013'd,9,_n_*20,0);
datalines;
MSG50T7R Miller     Jose        Z
WRYI8G3P Jones      Kaitlyn     R
ZD48VQOV Hernandez  Jessica     U
932UD3PA Smith      Kathryn     E
Z5J33NZ6 Phillips   Isaac       J
9MH1D694 Butler     Jacqueline  I
D3AQ3F79 Martinez   Justin      J
EENQO8XO Green      Ethan       M
;;;;

/***************************************************/
/* Data Set PATIENTS_HISTORY                       */
/***************************************************/
data patient_history;
  attrib ptid length=$8 label='Patient ID'
         ptln length=$30 label='Patient Last Name'
         ptfn length=$25 label='Patient First Name'
         ptmi length=$1  label='Patient Middle Initial'
         gender length=$1 label='Patient Gender'
         dob  length=8 format=mmddyy10.
         pthistdate label='Last Patient History' format=mmddyy10.;

    array lastnames{279} $ 15 _temporary_ (
      'Williams' 'Anderson' 'Scott' 'Martin' 'Bean' 'Howard' 'Thompson' 'Roberts' 'Martinez' 'Miller' 'Lee' 'Jones' 'Kelly'
'Perez' 'Morgan' 'Smith' 'Hill' 'Miller' 'Taylor' 'Ward' 'Smith' 'Hall' 'Howard' 'Jones' 'Butler' 'Reed' 'Peterson' 'Price'
'Rodriguez' 'Bell' 'Harris' 'Allen' 'Adams' 'Morgan' 'Perez' 'Bell' 'Smith' 'Foster' 'Smith' 'Gray' 'Johnson' 'Kelly' 'Davis'
'Morgan' 'Scott' 'Phillips' 'White' 'Moore' 'Gonzalez' 'Sanchez' 'Williams' 'Wilson' 'Scott' 'Alexander' 'Gonzalez'
'Williams' 'Clark' 'Williams' 'Moore' 'Ross' 'Hernandez' 'White' 'James' 'Smith' 'Adams' 'Williams' 'Williams' 'Baker'
'Lewis' 'Bell' 'Edwards' 'Johnson' 'Phillips' 'Stewart' 'Gonzales' 'Davis' 'Green' 'Jones' 'Perry' 'Brooks' 'Brown' 'Cox'
'Hughes' 'White' 'Carter' 'Hernandez' 'Martinez' 'Bryant' 'Wilson' 'Chang' 'Thompson' 'Hall' 'Martin' 'Baker' 'Simmons'
'Prasad' 'White' 'Long' 'Cox' 'Baker' 'Harris' 'Peterson' 'Rodriguez' 'Alexander' 'Green' 'Long' 'Lee' 'Russell' 'Thomas'
'Bennett' 'Nelson' 'Martin' 'Williams' 'Brown' 'Butler' 'Garcia' 'Davis' 'Sanders' 'Jones' 'Murphy' 'Chua' 'Jones'
'Nelson' 'Miller' 'Smith' 'Thomas' 'Hernandez' 'Anderson' 'Thomas' 'Henderson' 'Brooks' 'Patterson' 'Adams' 'Parker'
'King' 'Murphy' 'Johnson' 'Lewis' 'Foster' 'Davis' 'Moore' 'Gray' 'Scott' 'Garcia' 'White' 'Williams' 'Peterson'
'Washington' 'Williams' 'Clark' 'Brown' 'Smith' 'Johnson' 'Jones' 'Patterson' 'Diaz' 'Baker' 'Perry' 'Davis' 'Thomas'
'Morgan' 'Baker' 'Stewart' 'Miller' 'Morris' 'Parker' 'Harris' 'Washington' 'Smith' 'Hall' 'Taylor' 'Martinez' 'Thompson'
'Davis' 'Davis' 'Brown' 'Brown' 'Williams' 'Parker' 'Moore' 'Davis' 'Thompson' 'Moore' 'Smith' 'Roberts' 'Jones' 'Bryant'
'Jackson' 'Baker' 'Campbell' 'Brown' 'Hill' 'Smith' 'Cox' 'Miller' 'Robinson' 'Blauvelt' 'Adams' 'Johnson' 'Turner' 'Smith'
'Chou' 'Martinez' 'Reed' 'Jackson' 'White' 'Mitchell' 'Nelson' 'Smith' 'Adams' 'Ward' 'Cook' 'Chang' 'Williams'
'Perez' 'Mitchell' 'Anderson' 'Davis' 'Phillips' 'Thomas' 'Stewart' 'Smith' 'Kelly' 'White' 'Stewart' 'Taylor' 'Wilson'
'Jones' 'Parker' 'Scott' 'Jones' 'Thomas' 'Walker' 'Cox' 'Thomas' 'Lee' 'Ramirez' 'Brown' 'Johnson' 'Coleman' 'Johnson'
'Davis' 'Butler' 'Mitchell' 'Rodriguez' 'Mitchell' 'Hernandez' 'Cooper' 'Cooper' 'Jones' 'Moore' 'Martinez' 'Brown'
'Adams' 'Coleman' 'Torres' 'Brown' 'Brown' 'Turner' 'Chang' 'Jones' 'Wilson' 'Edwards' 'Jackson' 'Johnson' 'Davis'
'Sanders' 'Miller' 'Clark' 'Long' 'Smith' 'Baker' 'Richardson' 'Jones' 'Smith' 'Martin' 'Gray' 'Bryant' 'Hernandez'
);

  array firstnames{200} $ 15 _temporary_ (
            'Michael' 'Emily' 'Matthew' 'Jessica' 'Jacob' 'Ashley' 'Christopher' 'Sarah'
            'Joshua' 'Samantha' 'Nicholas' 'Taylor' 'Tyler' 'Hannah' 'Brandon' 'Alexis'
            'Austin' 'Rachel' 'Andrew' 'Elizabeth' 'Daniel' 'Kayla' 'Joseph' 'Megan'
            'David' 'Amanda' 'Zachary' 'Brittany' 'John' 'Madison' 'Ryan' 'Lauren'
            'James' 'Brianna' 'William' 'Victoria' 'Anthony' 'Jennifer' 'Justin' 'Stephanie'
            'Jonathan' 'Courtney' 'Alexander' 'Nicole' 'Robert' 'Alyssa' 'Christian' 'Rebecca'
            'Kyle' 'Morgan' 'Kevin' 'Alexandra' 'Jordan' 'Amber' 'Thomas' 'Jasmine'
            'Benjamin' 'Danielle' 'Samuel' 'Haley'  'Cody' 'Katherine' 'Jose' 'Abigail'
            'Dylan' 'Anna' 'Aaron' 'Olivia' 'Eric' 'Shelby' 'Brian' 'Kelsey'
            'Nathan' 'Maria' 'Steven' 'Allison' 'Adam' 'Sydney' 'Timothy' 'Kaitlyn'
            'Jason' 'Kimberly' 'Logan' 'Melissa' 'Charles' 'Savannah' 'Patrick' 'Mary'
            'Richard' 'Brooke' 'Sean' 'Natalie' 'Hunter' 'Michelle' 'Caleb' 'Julia'
            'Cameron' 'Jordan' 'Noah' 'Sara' 'Jesse' 'Erin' 'Juan' 'Tiffany'
            'Connor' 'Emma' 'Alex' 'Gabrielle' 'Mark' 'Chelsea' 'Jeremy' 'Destiny'
            'Luis' 'Christina' 'Dakota' 'Sabrina' 'Devin' 'Marissa' 'Stephen' 'Vanessa'
            'Gabriel' 'Andrea' 'Ethan' 'Sierra' 'Trevor' 'Mariah' 'Jared' 'Katelyn'
            'Evan' 'Paige' 'Bryan' 'Laura' 'Carlos' 'Madeline' 'Tristan' 'Jacqueline'
            'Nathaniel' 'Cheyenne' 'Ian' 'Kristen' 'Isaiah' 'Heather' 'Jeffrey' 'Briana'
            'Travis' 'Kelly' 'Lewis' 'Breanna' 'Luke' 'Mackenzie' 'Chase' 'Alexandria'
            'Kenneth' 'Miranda' 'Dustin' 'Caroline' 'Paul' 'Erica' 'Antonio' 'Shannon'
            'Elijah' 'Monica' 'Taylor' 'Katie' 'Bradley' 'Jenna' 'Blake' 'Caitlin'
            'Garrett' 'Bailey' 'Isaac' 'Lindsey' 'Marcus' 'Kathryn' 'Mitchell' 'Amy'
            'Jack' 'Cassandra' 'Tanner' 'Angela' 'Miguel' 'Alicia' 'Adrian' 'Crystal'
            'Lucas' 'Hailey' 'Corey' 'Catherine'  'Edward' 'Grace' 'Peter' 'Jamie'
            'Malik' 'Angelica' 'Gregory' 'Leah' 'Dalton' 'Molly' 'Victor' 'Alexa');

  retain alphanum 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  drop alphanum i j pos fnidx z addyear d y diff;

  call streaminit(910381);

  do j=1 to 100000;
    z=rand('table',.05,.07,.1,.18,.18,.07,.07,.1,.1,.08);
    addyear=floor(rand('uniform')*10);
    d=ceil(rand('uniform')*365);
    y=1915+((z-1)*10)+addyear;
    if y=2014 then y=2012;
    else if y=2013 then y=2011;
    dob=datejul(y*1000+d);
    ptid=' ';
    do i=1 to 8;
      pos=ceil(rand('uniform')*36);
      ptid=cats(ptid,substr(alphanum,pos,1));
    end;
    ptln=lastnames{ceil(rand('uniform')*dim(lastnames))};
    fnidx=ceil(rand('uniform')*dim(firstnames));
    ptfn=firstnames{fnidx};
    if rand('bernoulli',.65)=1 then gender='F';
    else gender='M';
    ptmi=substr(alphanum,ceil(rand('uniform')*26),1);

    d=ceil(rand('uniform')*365);
    y=2012-floor(rand('uniform')*5);
    pthistdate=datejul(y*1000+d);
    if pthistdate le dob then do;
      diff=dob-pthistdate;
      pthistdate=pthistdate+diff+ceil(rand('uniform')*100);
    end;
    if mod(j,20)=3 then pthistdate=.;
    output;
  end;
run;

/*******************************************************/
/* Data Set PRIZEWINNERS                               */
/*******************************************************/
data prizewinners;
  attrib winnername length=$20 label='Name of Winner'
         age label='Age of Winner'
         prizetype length=$6 label='Type of Prize Selected'
         prizelevel label='Prize Level';

  input winnername $ 1-20 age @25 prizetype $ prizelevel;
datalines;
Allison Johnson      32 class  3
Jeffrey Davis        28 pass   2
Brady Hall           10 pass   3
Courtney Hill        16 sports 2
Tiffany Scott        41 class  4
Teresa Martinez      18 pass   4
Patricia Rodriguez   48 class  1
Samantha Washington  12 class  2
;;;

/*******************************************************/
/* Data Set PRIZECATALOG                               */
/*******************************************************/
data prizecatalog;
  attrib prizecode length=$8 label='Prize Code'
         prize length=$25 label='Prize Description';
  input prizecode $ prize $ 12-36;

datalines;
ASPORTS1   Heart Rate Monitor
ASPORTS2   Walking Poles
ASPORTS3   Free Weights
CSPORTS1   Kick Scooter
CSPORTS2   Inline Skates
CSPORTS3   Skateboard
APASS1     Athletic Center Pass
APASS2     Hiking Trails Pass
APASS3     Swim Center Pass
CPASS1     Indoor Playground Pass
CPASS2     Swim Center Pass
CPASS3     Skateboard Park Pass
CLASS1     Golf Lessons
CLASS2     Tennis Lessons
CLASS3     Fitness Class
CLASS4     Yoga Class
;;;

/*******************************************************/
/* Data Set DOCTORS_SOUTHSIDE                          */
/*******************************************************/
data doctors_southside;
  attrib empid length=$6 label='Employee ID';
  input empid $ @@;
datalines;
3D401A NBJ588 WE3HJH
;;;

/*******************************************************/
/* Data Set DOCTORS_MAPLEWOOD                          */
/*******************************************************/
data doctors_maplewood;
  attrib empid length=$6 label='Employee ID';
  input empid $ @@;
datalines;
3D401A LDT47L NBK588 O0OBRU
;;;

/*******************************************************/
/* Data Set DOCTORS_MIDTOWN                            */
/*******************************************************/
data doctors_midtown;
  attrib empid length=$6 label='Employee ID';
  input empid $ @@;
datalines;
2VIHPJ 3D401A HPM27C NBK588  NTWJLF S7JHOM
;;;

/*******************************************************/
/* Data Set DOCTORLIST                                 */
/*******************************************************/
data doctorlist;
  attrib empid length=$6 label='Employee ID'
         empln length=$30 label='Employee Last Name'
         empfn length=$25 label='Employee First Name'
         empmi length=$1  label='Employee Middle Initial';

  input empid $ empln $ empfn $ empmi $;
datalines;
2VIHPJ Thomas   Noah      S
3D401A Long     Alicia    E
BKK94F Robinson Michael   M
HPM27C Cooper   Brian     F
LDT47L Torres   Chelsea   Q
MN2ZY6 Anderson Chase     P
NBK588 Scott    Kyle      S
O0OBRU Cooper   Bradley   D
WE3HJH Peterson Jamie     Z
;;;

/*******************************************************/
/* Data Set STUDYSUBJECTS                              */
/*******************************************************/
data studysubjects;
  input studyid $ 1-6 nurseid 8-10 dieticianid 12-14 treatmentgroup $ 16;
datalines;
GHY101 461 582 A
REA102 391 592 B
PLK103 393 387 A
MIJ104 461 592 B
NHC105 240 439 A
UMB106 391 592 B
TRC107 371 104 A
CDF108 240 592 B
LIM109 240 397 A
TUY110 371 592 B
WCM111 371 104 A
NDM112 240 397 B
YEA113 391 439 A
GAL114 240 439 B
AFF115 371 592 A
DRO116 371 592 B
GEA117 391 397 A
DDL118 240 104 B
RGZ119 461 439 A
MBO120 461 104 B
LOE121 461 592 A
DHZ122 461 592 B
BBR123 461 397 A
VPD124 240 439 B
TEP125 391 397 A
;;;

/*******************************************************/
/* Data Set STUDYAPPTS                                 */
/*******************************************************/
data studyappts;
  input studyid $ 1-6 baseweight basesystol basediast apptstring $ 19-33;

  retain seeddate 19390 mem ind lab tks;

  keep studyid apptdate appttype weight systol diast;
  attrib apptdate format=mmddyy10. label='Appointment Date'
         appttype length=$15 label='Appointment Type';

  if _n_=1 then do;
    mem=holiday('memorial',2013);
    ind=holiday('usindependence',2013);
    lab=holiday('labor',2013);
    tks=holiday('thanksgiving',2013);
  end;

  call streaminit(30015);

  appttype='Baseline';
  weight=baseweight;
  systol=basesystol;
  diast=basediast;

  diff=ceil(rand('uniform')*44);
  apptdate=seeddate+diff;
  if weekday(apptdate)=7 then apptdate=apptdate-1;
  else if weekday(apptdate)=1 then apptdate=apptdate+1;
  output;

  if index(apptstring,',30') gt 0 then do;
    appttype='One Month';
    diff=ceil(rand('uniform')*15);
    apptdate=apptdate+45-diff;
    if weekday(apptdate)=7 then apptdate=apptdate-1;
    else if weekday(apptdate)=1 then apptdate=apptdate+1;

    diff=.01*((rand('uniform')*10)-5);
    weight=round(weight+weight*diff,1);
    diff=.01*((rand('uniform')*10)-5);
    systol=floor(systol+systol*diff);
    diff=.01*((rand('uniform')*10)-5);
    diast=floor(diast+diast*diff);
    output;
  end;
  if index(apptstring,',60') gt 0 then do;
    appttype='Two Month';
    diff=ceil(rand('uniform')*20);
    apptdate=apptdate+85-diff;
    if weekday(apptdate)=7 then apptdate=apptdate-1;
    else if weekday(apptdate)=1 then apptdate=apptdate+1;
    if apptdate=mem then apptdate=apptdate+1;
    else if apptdate=ind then apptdate=apptdate+3;
    diff=.01*(ceil(rand('uniform')*10)-6);
    weight=round(weight+weight*diff,1);
    diff=.01*(ceil(rand('uniform')*10)-6);
    systol=floor(systol+systol*diff);
    diff=.01*(ceil(rand('uniform')*10)-6);
    diast=floor(diast+diast*diff);
    output;
  end;
  if index(apptstring,',120') gt 0 then do;
    appttype='Four Month';
    diff=ceil(rand('uniform')*31);
    apptdate=apptdate+152-diff;
    if weekday(apptdate)=7 then apptdate=apptdate-1;
    else if weekday(apptdate)=1 then apptdate=apptdate+1;
    if apptdate=mem then apptdate=apptdate+1;
    else if apptdate=ind then apptdate=apptdate+3;
    diff=.01*(ceil(rand('uniform')*10)-7);
    weight=round(weight+weight*diff,1);
    diff=.01*(ceil(rand('uniform')*10)-7);
    systol=floor(systol+systol*diff);
    diff=.01*(ceil(rand('uniform')*10)-7);
    diast=floor(diast+diast*diff);
    output;
  end;
  if index(apptstring,',180') gt 0 then do;
    diff=ceil(rand('uniform')*44);
    apptdate=apptdate+225-diff;
    if weekday(apptdate)=7 then apptdate=apptdate-1;
    else if weekday(apptdate)=1 then apptdate=apptdate+1;
    if apptdate=mem or apptdate=lab then apptdate=apptdate+1;
    else if apptdate=ind then apptdate=apptdate+3;
    else if apptdate=tks then apptdate=apptdate-2;

    appttype='Six Month';
    diff=.01*(ceil(rand('uniform')*10)-9.5);
    weight=round(weight+weight*diff,1);
    diff=.01*(ceil(rand('uniform')*10)-9.5);
    systol=floor(systol+systol*diff);
    diff=.01*(ceil(rand('uniform')*10)-9.5);
    diast=floor(diast+diast*diff);
    output;
  end;
datalines;
GHY101 180 180 90 B,30,60,120,180
REA102 154 173 85 B,30,60,120
MIJ104 205 135 90 B,30,60,120
NHC105 222 148 82 B,30,120
UMB106 193 139 78 B,30,60,120,180
TRC107 135 152 85 B,30,60,120,180
CDF108 244 143 89 B,30,60,120
LIM109 173 137 76 B,30,60,120
TUY110 188 143 91 B,30,60,180
WCM111 140 156 90 B,30,60,120,180
NDM112 161 128 88 B,30
YEA113 133 151 92 B,30,60
GAL114 144 146 82 B,30,60,120,180
AFF115 175 153 88 B,30,60
DRO116 168 143 79 B,30,60,120,180
GEA117 199 140 86 B,30,60,120,180
DDL118 187 162 95 B,30,60,120,180
RGZ119 230 150 88 B,30,60
MBO120 203 138 85 B,30
LOE121 255 149 82 B,30,60,120
DHZ122 138 142 83 B,30
BBR123 163 155 93 B,30,60,120,180
VPD124 177 138 90 B,30,60,120,180
TEP125 129 152 89 B,30,60
;;;;
proc sort data=studyappts;
  by studyid apptdate;
run;

/*******************************************************/
/* Data Set STUDYSTAFF                                 */
/*******************************************************/
data studystaff;
  input staffid 1-3 unit $ 5-11 staffname $ 14-24 degree $ 26-28 siteid 30;
datalines;
371 Nursing  EN Cameron  RN  1
461 Nursing  YU Garcia   CNP 4
104 Dietary  RD Hong     RD  1
240 Nursing  TR Howe     RN  3
439 Dietary  KA Izzo     RD  2
592 Dietary  HS James    RD  2
387 Dietary  HN Lee      RD  3
391 Nursing  MR Smith    CNP 2
;;;;

/*******************************************************/
/* Data Set STUDYSTAFF                                 */
/*******************************************************/
data studysites;
  input siteid 1 sitename $ 3-31 sitemanager $ 33-41;
datalines;
1 Midtown Primary Care Clinic   FD Weston
2 Southside Primary Care Clinic AW Liu
3 Maplewood Wellness Clinic     PR Ross
;;;

/*******************************************************/
/* Data Set FINDSCHED                                  */
/*******************************************************/
data findsched;
  attrib eventdate format=mmddyy10.
         shift length=$2 label='Event Shift'
         empid length=$6 label='Employee ID'
         empname length=$40 label='Employee Name';

  input empid $ 1-6 @8 eventdate mmddyy8. @17 shift $2.
        empname $ 20-39;
datalines;
LISUUC 10222013 AM Davis, Laura W.
OYMEE3 10222013 AM Thomas, Hannah I.
OYMEE3 10222013 PM Thomas, Hannah I.
8I4YKY 10222013 PM Brooks, Shelby B.
7YN5NV 10232013 AM Perez, Paige O.
8VLUT7 10222013 PM Hall, Kelsey H.
8VLUT7 10232013 PM Hall, Kelsey H.
;;;

/*******************************************************/
/* Data Set OCTOBEREVENT                               */
/*******************************************************/
data octoberevent;
  infile datalines truncover;
  attrib eventdate format=mmddyy10.
         shift length=$2 label='Event Shift'
         activity length=$20 label='Event Activity'
         empid length=$6 label='Employee ID'
         empname length=$40 label='Employee Name';

  input @1 eventdate mmddyy8. @10 shift $2.
        @13 activity $14. @29 empid $6. @37 empname $40.;
datalines;
10222013 AM Cholesterol     02QYJG  Howard, Rachel Y.
10222013 AM Cholesterol     8I4YKY  Brooks, Shelby B.
10222013 AM Cholesterol     ADHW3A  Moore, Allison W.
10222013 AM Dietary         IFQZ8S  Nelson, Kelly U.
10222013 AM Dietary         OYMEE3  Thomas, Hannah I.
10222013 AM Dietary         PTBHUP  Thompson, Olivia P.
10222013 AM Pharmaceutical  WVV7PT  Patterson, Vanessa N.
10222013 AM Counseling      14ZN75  Miller, Sierra Q.
10222013 AM Counseling      5KA7JH  Martin, Aaron G.
10222013 AM Counseling      BA8CRZ  Baker, Marissa R.
10222013 AM Counseling      FAL5UZ  Butler, Haley P.
10222013 AM Counseling      TMJTVP  Edwards, Brittany O.
10222013 AM Counseling      YXW78P  Davis, Andrea Y.
10222013 AM Immunization    1CV01H  Brown, Lindsey V.
10222013 AM Immunization    8EHCSX  Hernandez, Elizabeth S.
10222013 AM Immunization    HD8ERT  Paine, Mike J.
10222013 AM Immunization    KRTV2T  Gonzalez, Alejandro F.
10222013 AM Vitals          NCPO4E  Richardson, Bailey U.
10222013 AM Pharmaceutical  P438U8  Price, Katelyn Q.
10222013 AM Vitals          2S57ZI  Thompson, Alexandria B.
10222013 AM Vitals          69BWGZ  Jones, Marissa W.
10222013 AM Vitals          F97SKU  Lee, Alicia Q.
10222013 AM Vitals          FTZMFI  Rodriguez, Samantha E.
10222013 AM Vitals          OV9K5X  Baker, Jasmine O.
10222013 PM Cholesterol     02QYJG  Howard, Rachel Y.
10222013 PM Cholesterol     2S57ZI  Thompson, Alexandria B.
10222013 PM Cholesterol     8I4YKY  Brooks, Shelby B.
10222013 PM Dietary         C800UH  Patterson, Jamie Q.
10222013 PM Dietary         GWS2QS  Parker, Brittany D.
10222013 PM Dietary         LISUUC  Davis, Laura W.
10222013 PM Counseling      OV9K5X  Baker, Jasmine O.
10222013 PM Counseling      OYMEE3  Thomas, Hannah I.
10222013 PM Counseling      WRH1W5  Chou, Alexandria U.
10222013 PM Counseling      4RD316  Cox, Christina Y.
10222013 PM Counseling      DVZ03Q  Ramirez, Alexa M.
10222013 PM Counseling      NGRZ6L  Coleman, Madeline I.
10222013 PM Immunization    67Z8K3  Moore, Vanessa I.
10222013 PM Immunization    8VLUT7  Hall, Kelsey H.
10222013 PM Immunization    PTBHUP  Thompson, Olivia P.
10222013 PM Pharmaceutical  R89AM0  Baker, Amy R.
10222013 PM Pharmaceutical  WL68N7  Murphy, Julia D.
10222013 PM Vitals          14ZN75  Miller, Sierra Q.
10222013 PM Vitals          7YN5NV  Perez, Paige O.
10222013 PM Vitals          ADHW3A  Moore, Allison W.
10222013 PM Vitals          HD8ERT  Paine, Mike J.
10222013 PM Vitals          JDFPHH  Roberts, Laura U.
10222013 PM Vitals          U6ZVDE  Brown, Lindsey X.
10222013 PM Vitals          YU01P0  Mitchell, Catherine A.
10222013 PM Vitals          Z1EJD9  Howard, Amanda X.
10232013 AM Cholesterol     4RD316  Cox, Christina Y.
10232013 AM Cholesterol     GWS2QS  Parker, Brittany D.
10232013 AM Cholesterol     HD8ERT  Paine, Mike J.
10232013 AM Dietary         IEZF48  Thompson, Brianna I.
10232013 AM Dietary         K42ODX  Anderson, Rebecca J.
10232013 AM Pharmaceutical  NGRZ6L  Coleman, Madeline I.
10232013 AM Pharmaceutical  OV9K5X  Baker, Jasmine O.
10232013 AM Counseling      1CV01H  Brown, Lindsey V.
10232013 AM Counseling      81DJ0Z  Martinez, Kelly I.
10232013 AM Counseling      ADHW3A  Moore, Allison W.
10232013 AM Counseling      FTZMFI  Rodriguez, Samantha E.
10232013 AM Counseling      INZOIM  Mitchell, Olivia M.
10232013 AM Counseling      TMJTVP  Edwards, Brittany O.
10232013 AM Counseling      WVV7PT  Patterson, Vanessa N.
10232013 AM Counseling      02QYJG  Howard, Rachel Y.
10232013 AM Immunization    67Z8K3  Moore, Vanessa I.
10232013 AM Immunization    8I4YKY  Brooks, Shelby B.
10232013 AM Immunization    ICDUYL  Hill, Samantha S.
10232013 AM Immunization    P438U8  Price, Katelyn Q.
10232013 AM Immunization    VUH0Z4  Jones, Catherine H.
10232013 AM Vitals          WRH1W5  Chou, Alexandria U.
10232013 AM Immunization    YU01P0  Mitchell, Catherine A.
10232013 AM Vitals          70M6YN  King, Mary K.
10232013 AM Vitals          8VLUT7  Hall, Kelsey H.
10232013 AM Vitals          BA8CRZ  Baker, Marissa R.
10232013 AM Vitals          FAL5UZ  Butler, Haley P.
10232013 AM Vitals          IY69JA  Martinez, Lauren B.
10232013 AM Vitals          V1DPL5  Diaz, Lindsey N.
10232013 PM Cholesterol     7YN5NV  Perez, Paige O.
10232013 PM Cholesterol     ADHW3A  Moore, Allison W.
10232013 PM Cholesterol     F97SKU  Lee, Alicia Q.
10232013 PM Dietary         IEZF48  Thompson, Brianna I.
10232013 PM Dietary         JDFPHH  Roberts, Laura U.
10232013 PM Dietary         OYMEE3  Thomas, Hannah I.
10232013 PM Counseling      WRH1W5  Chou, Alexandria U.
10232013 PM Pharmaceutical  YXW78P  Davis, Andrea Y.
10232013 PM Counseling      67Z8K3  Moore, Vanessa I.
10232013 PM Counseling      K42ODX  Anderson, Rebecca J.
10232013 PM Counseling      KRTV2T  Gonzalez, Alejandro F.
10232013 PM Counseling      TMJTVP  Edwards, Brittany O.
10232013 PM Counseling      V1DPL5  Diaz, Lindsey N.
10232013 PM Counseling      Z1EJD9  Howard, Amanda X.
10232013 PM Immunization    3VGRKR  Jones, Haley L.
10232013 PM Immunization    69BWGZ  Jones, Marissa W.
10232013 PM Immunization    81DJ0Z  Martinez, Kelly I.
10232013 PM Immunization    NGRZ6L  Coleman, Madeline I.
10232013 PM Immunization    YU01P0  Mitchell, Catherine A.
10232013 PM Vitals          5KA7JH  Martin, Aaron G.
10232013 PM Vitals          68W3LT  Phillips, Stephanie Y.
10232013 PM Vitals          8I4YKY  Brooks, Shelby B.
10232013 PM Vitals          95LL7E  Smith, Leah L.
10232013 PM Vitals          BA8CRZ  Baker, Marissa R.
10232013 PM Vitals          GWS2QS  Parker, Brittany D.
10232013 PM Vitals          ICDUYL  Hill, Samantha S.
10232013 PM Vitals          LISUUC  Davis, Laura W.
10232013 PM Vitals          NCPO4E  Richardson, Bailey U.
;;;

/*******************************************************/
/* Data Set BPSTUDY                                    */
/*******************************************************/
data bpstudy;
  input ptid $ 1-8 @10 examdate mmddyy10. weight systolic diastolic;
  format examdate mmddyy10.;
datalines;
V8810YQ4 01/02/2013 182 154 89
V8810YQ4 02/06/2013 175 148 83
V8810YQ4 03/06/2013 170 147 79
V8810YQ4 04/03/2013 158 135 78
V8810YQ4 05/01/2013 155 133 79
V8810YQ4 06/05/2013 154 129 75
V8810YQ4 07/03/2013 148 131 80
V8810YQ4 08/07/2013 150 128 75
V8810YQ4 09/04/2013 149 129 72
V8810YQ4 10/02/2013 146 130 77
V8810YQ4 11/06/2013 140 126 78
V8810YQ4 12/04/2013 146 122 80
56KJR3D9 01/02/2013 142 147 82
56KJR3D9 02/06/2013 144 138 90
56KJR3D9 03/06/2013 139 133 77
56KJR3D9 04/03/2013 133 141 79
56KJR3D9 05/01/2013 131 124 74
56KJR3D9 06/05/2013 134 120 80
56KJR3D9 07/03/2013 133 124 81
56KJR3D9 08/07/2013 130 125 74
56KJR3D9 09/04/2013 129 123 71
56KJR3D9 10/02/2013 129 119 72
56KJR3D9 11/06/2013 126 120 72
56KJR3D9 12/04/2013 124 118 70
;;;


/*******************************************************/
/* Data Set TESTGROUP                                  */
/*******************************************************/
data testgroup;
  attrib testid    length=8
         dob       length=8 format=mmddyy10.
         testdate  length=8 format=mmddyy10.
         treatment length=$25;
  drop g;
  do testid=1001 to 1020;
    testdate=19400+ceil(uniform(97528)*30);
    dob=-ceil(uniform(3058)*18000);
    g=ceil(uniform(3058)*3);
    if g=1 then treatment='No Activity';
    else if g=2 then treatment='Activity A';
    else if g=3 then treatment='Activity B';
    r=uniform(3058);
    output;
  end;
run;
proc sort data=testgroup out=testgroup(drop=r);
  by r;
run;

/*******************************************************/
/* Data Set HH                                         */
/*******************************************************/
data hh;
  attrib hhid length=$4
         tract length=$4
         surveydate format=mmddyy10.
         hhtype length=$10;
  input hhid $ tract $ @9 surveydate mmddyy10.
        hhtype $;
datalines;
HH01 CS 07/09/2012 Owner
HH02 CN 03/11/2012 Renter
HH03 CS 05/20/2012 Owner
HH04 SW 01/12/2012 Owner
HH05 NE 10/17/2012 Renter
HH06 NE 05/15/2012 Owner
HH07 SW 02/02/2012 Owner
HH08 NE 04/09/2012 Renter
HH09 CE 11/01/2012 Owner
HH10 CN 03/31/2012 Owner
;;;;

/*******************************************************/
/* Data Set PERSONS                                    */
/*******************************************************/
data persons;
  attrib hhid length=$4
         personid length=$3
         age length=3
         gender length=$1
         income length=8 format=dollar12.
         educlevel length=3;
  input hhid $ personid $ age gender $ income educlevel;
datalines;
HH01 P01 68 M 52000 12
HH01 P02 68 F 23000 12
HH02 P01 42 M 168100 22
HH03 P01 79 F 38000  10
HH04 P01 32 F 56000 16
HH04 P02 31 M 72000 18
HH04 P03 5  F 0 0
HH04 P04 2  F 0 0
HH05 P01 26 M 89000 22
HH06 P01 56 M 123000 18
HH06 P02 48 F 139300 18
HH06 P03 17 F 5000 11
HH07 P01 48 M 90120 16
HH07 P02 50 F 78000 18
HH08 P01 59 F 55500 16
HH09 P01 32 F 48900 14
HH09 P02 10 M 0 5
HH10 P01 47 F 78000 16
HH10 P02 22 F 32000 16
HH10 P03 19 M 20000 12
HH10 P04 14 M 0 8
HH10 P05 12 F 0 6
HH10 P06 9  F 0 4
;;;;

/*******************************************************/
/* Data Set AWARDS                                     */
/*******************************************************/
data awards;
  input @1 awarddate mmddyy10. prize $ 12-33;
  format awarddate mmddyy10.;
datalines;
01/31/2013 Restaurant Certificate
02/28/2013 Shopping Certificate
03/15/2013 Theater Tickets
04/15/2013 Baseball Tickets
;;;;

/*******************************************************/
/* Data Set FINISHERS                                  */
/*******************************************************/
data finishers;
  input name $ 1-20 @22 completed mmddyy10.;
  format completed mmddyy10.;
datalines;
Moore, Kathryn       12/27/2012
Jackson, Barbara     01/15/2013
Brown, Shannon       03/23/2013
Williams, Debra      03/26/2013
Harris, Joseph       02/01/2013
Brown, Patricia      01/08/2013
Johnson, Christopher 02/17/2013
Rodriguez, Shawn     03/31/2013
Gonzalez, Patrick    01/14/2013
Wright, Nicholas     03/02/2013
Jones, Robert        02/28/2013
Miller, Christopher  03/25/2013
Rogers, Francie      05/15/2013
;;;

/*******************************************************/
/* Data Set CODES                                      */
/*******************************************************/
data codes;
  attrib code length=$6
         codedesc length=$25
         codedate length=8 format=mmddyy10.;
  input code $ @8 codedate mmddyy10. codedesc $;
datalines;
AB871K 02/15/2013 Debit
GG401P 02/23/2013 Credit
MI497Q 02/03/2013 Debit
;;;


/*******************************************************/
/* Data Set CLAIMS2012                                 */
/*******************************************************/
data workdays2012;
  do workday='02jan2012'd to '31dec2012'd;
    if weekday(workday) not in (1,7) and
      not(holiday('christmas',2012)-1 le workday le holiday('christmas',2012)+1) and
      workday ne holiday('thanksgiving',2012) and workday ne holiday('thanksgiving',2012)+1 and
      workday ne holiday('labor',2012) and workday ne holiday('memorial',2012) and
      workday ne holiday('usindependence',2012) then output;
  end;
  format workday mmddyy10.;
run;
data claims2012;
  retain alphanum 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  attrib ptid length=$8 label='Patient ID'
         claimdate length=8 format=mmddyy10. label='Claim Date'
         provider_id length=$15 label='Provider ID'
         charge length=8 format=dollar10.2 label='Charge'
         provider_type length=$11 label='Provider Type';

  keep ptid provider_id charge provider_type claimdate;

  call streaminit(451772);

  array prov{75} $ 15 prov1-prov75;
  do p=1 to 75;
    if p le 34 then provider_type='CLINIC';
    else if 35 le p le 48 then provider_type='OPSURGERY';
    else if 49 le p le 62 then provider_type='LAB';
    else if 63 le p le 70 then provider_type='OPRADIOLOGY';
    else if p ge 71 then provider_type='PHYSTHERAPY';
    prov{p}=cats(provider_type,put(p,z3.));
  end;

  do p=1 to 101412;
    ptid=' ';
    do i=1 to 8;
      pos=ceil(rand('uniform')*36);
      ptid=cats(ptid,substr(alphanum,pos,1));
    end;
    nvisits=ceil(abs(rand('normal')*2));
    do v=1 to nvisits;
      pid=ceil(rand('uniform')*75);
      provider_id=prov{pid};
      provider_type=substr(provider_id,1,length(provider_id)-3);
      if provider_type='CLINIC' then charge=round(abs(rand('normal'))*100+50,.2);
      else if provider_type='LAB' then charge=round(rand('uniform')*400+45,.2);
      else if provider_type='OPSURGERY' then charge=round(rand('uniform')*8000+400,.2);
      else if provider_type='OPRADIOLOGY' then charge=round(rand('uniform')*3000+250,.2);
      else if provider_type='PHYSTHERAPY' then charge=round(rand('uniform')*300+100,.2);

      workday=ceil(rand('uniform')*252);
      set workdays2012(keep=workday) point=workday;
      claimdate=workday;
      output;
    end;
  end;
  stop;
run;

/*******************************************************/
/* Data Set CLAIMS2013                                 */
/*******************************************************/
data workdays2013;
  do workday='02jan2013'd to '31dec2013'd;
    if weekday(workday) not in (1,7) and
      not(holiday('christmas',2013)-1 le workday le holiday('christmas',2013)+1) and
      workday ne holiday('thanksgiving',2013) and workday ne holiday('thanksgiving',2013)+1 and
      workday ne holiday('labor',2013) and workday ne holiday('memorial',2013) and
      workday ne holiday('usindependence',2013) then output;
  end;
  format workday mmddyy10.;
run;
data claims2013;
  retain alphanum 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  attrib ptid length=$8 label='Patient ID'
         claimdate length=8 format=mmddyy10. label='Claim Date'
         provider_id length=$15 label='Provider ID'
         charge length=8 format=dollar10.2 label='Charge'
         provider_type length=$11 label='Provider Type';

  keep ptid provider_id charge provider_type claimdate;

  call streaminit(451773);

  array prov{75} $ 15 prov1-prov75;
  do p=1 to 75;
    if p le 34 then provider_type='CLINIC';
    else if 35 le p le 48 then provider_type='OPSURGERY';
    else if 49 le p le 62 then provider_type='LAB';
    else if 63 le p le 70 then provider_type='OPRADIOLOGY';
    else if p ge 71 then provider_type='PHYSTHERAPY';
    prov{p}=cats(provider_type,put(p,z3.));
  end;

  do p=1 to 100000;
    ptid=' ';
    do i=1 to 8;
      pos=ceil(rand('uniform')*36);
      ptid=cats(ptid,substr(alphanum,pos,1));
    end;
    nvisits=ceil(abs(rand('normal')*2));
    do v=1 to nvisits;
      pid=ceil(rand('uniform')*75);
      provider_id=prov{pid};
      provider_type=substr(provider_id,1,length(provider_id)-3);
      if provider_type='CLINIC' then charge=round(abs(rand('normal'))*100+50,.2);
      else if provider_type='LAB' then charge=round(rand('uniform')*400+45,.2);
      else if provider_type='OPSURGERY' then charge=round(rand('uniform')*8000+400,.2);
      else if provider_type='OPRADIOLOGY' then charge=round(rand('uniform')*3000+250,.2);
      else if provider_type='PHYSTHERAPY' then charge=round(rand('uniform')*300+100,.2);

      workday=ceil(rand('uniform')*252);
      set workdays2013(keep=workday) point=workday;
      claimdate=workday;
      output;
    end;
  end;
  stop;
run;

/*******************************************************/
/* Data Set BOOKLIST                                   */
/*******************************************************/
data booklist;
  infile datalines truncover;
  input bookid $ 1-6 booktitle $ 8-25 chapter author $ 30-49 duedate : mmddyy10.
        editor $ 62-81;
  format duedate mmddyy10.;
datalines;
NF0586 Health Data Sets   1  Smith, Rebecca      09/08/2013  Williams, Stephanie
NF0586 Health Data Sets   2  Williams, Susan     09/08/2013  Williams, Stephanie
NF0586 Health Data Sets   3  Torres, Christopher 09/15/2013  Williams, Stephanie
NF0586 Health Data Sets   4  Torres, Christopher 09/15/2013  Williams, Stephanie
NF0586 Health Data Sets   5  Powell, George      09/15/2013  Williams, Stephanie
NF0586 Health Data Sets   6  Thompson, Tonya     09/15/2013  Williams, Stephanie
NF0586 Health Data Sets   7  Allen, Linda        09/15/2013  Williams, Stephanie
NF0586 Health Data Sets   8  Johnson, Tammy      09/15/2013  Williams, Stephanie
NF0586 Health Data Sets   9  Kelly, Melissa      09/15/2013  Williams, Stephanie
NF0586 Health Data Sets   10 Thompson, Tonya     09/15/2013  Williams, Stephanie
NF2413 Patient Handouts   1  Jones, Robin        08/03/2013  White, Michelle
NF2413 Patient Handouts   2  Sanchez, Brandon    08/11/2013  White, Michelle
NF2413 Patient Handouts   3  Jones, Robin        08/03/2013  White, Michelle
NF2413 Patient Handouts   4  Perez, Joshua       08/03/2013  White, Michelle
NF2413 Patient Handouts   5  Williams, Nicholas  08/03/2013  White, Michelle
NF2413 Patient Handouts   6  Patterson, Mary     08/18/2013  White, Michelle
NF2413 Patient Handouts   7  Torres, Christopher 08/11/2013  White, Michelle
NF2413 Patient Handouts   8  Robinson, Bonnie    08/11/2013  White, Michelle
NF2413 Patient Handouts   9  Brown, Patricia     08/11/2013  White, Michelle
NF8141 Medical Writing    1  Clark, Todd         10/06/2013  Patterson, Daniel
NF8141 Medical Writing    2  Barnes, David       10/06/2013  Patterson, Daniel
NF8141 Medical Writing    3  Young, Richard      09/22/2013  Patterson, Daniel
NF8141 Medical Writing    4  Barnes, David       10/06/2013  Patterson, Daniel
NF8141 Medical Writing    5  Anderson, Daniel    09/22/2013  Patterson, Daniel
NF8141 Medical Writing    6  Anderson, Daniel    09/22/2013  Patterson, Daniel
NF8141 Medical Writing    7  Morris, Laura       09/22/2013  Patterson, Daniel
NF8141 Medical Writing    8  Powell, George      09/22/2013  Patterson, Daniel
;;;

/*******************************************************/
/* Data Set BOOKSADDDEL                                */
/*******************************************************/
data booksadddel;
  infile datalines truncover;
  input action $ 1-3 bookid $ 5-10 chapter booktitle $ 15-32 author $ 36-55 duedate : mmddyy10.
        editor $ 68-87;
  format duedate mmddyy10.;
datalines;
DEL NF0586 2
ADD NF0586 2  Health Data Sets     King, Weston         09/22/2013 Williams, Stephanie
ADD NF2413 10 Patient Handouts     Moses, Winston       08/24/2013 White, Michelle
ADD NF2413 1  Patient Handouts     Johnson, Rosa        08/17/2013 White, Michelle
DEL NF8141 9
ADD NF8411 11 Medical Writing      Powell, George       09/22/2013 Patterson, Daniel
;;;;

/*******************************************************/
/* Data Set BOOKEDITS                                  */
/*******************************************************/
data bookedits;
  infile datalines truncover;
  input action $ 1-3 bookid $ 5-10 chapter newbooktitle $ 15-32 newauthor $ 36-55 newduedate : mmddyy10.
        neweditor $ 68-87;
  format newduedate mmddyy10.;
datalines;
MOD NF0586 8                       Lester, Jose         09/22/2013
MOD NF0586 12                                            .         White, Michelle
MOD NF4213 8                                            09/01/2013
MOD NF2413
DEL NF0586 2
ADD NF0586 2  Health Data Sets     King, Weston         09/22/2013 Williams, Stephanie
ADD NF2413 10 Patient Handouts     Moses, Winston       08/24/2013 White, Michelle
ADD NF2413 1  Patient Handouts     Johnson, Rosa        08/17/2013 White, Michelle
DEL NF8141 9
ADD NF8411 11 Medical Writing      Powell, George       09/22/2013 Patterson, Daniel
;;;;

/*******************************************************/
/* Data Set BPMEASURES                                 */
/*******************************************************/
data bpmeasures;
  attrib ptid length=$8
         bpdate length=8 format=mmddyy10.
         bptime length=8 format=timeampm8.
         systol length=8 label='Systolic BP'
         diast  length=8 label='Diastolic BP';
  input ptid @10 bpdate mmddyy10. @21 bptime time8. systol diast;
datalines;
AU81750Y 05/13/2013 10:15 AM 131 79
AU81750Y 05/14/2013 08:30 AM 125 80
AU81750Y 05/14/2013 03:45 PM 141 83
AU81750Y 05/14/2013 07:10 PM 132 80
AU81750Y 05/15/2013 09:40 AM 125 73
AU81750Y 05/15/2013 01:45 PM 133 85
AU81750Y 05/16/2013 11:20 AM 128 78
;;;

/*******************************************************/
/* Data Set FLUSHOTS                                   */
/*******************************************************/
data flushots;
  array loclist{7} $ 50 _temporary_ ('Downtown Community Center' 'Westside School' 'ABC Pharmacy'
                                     'Lakeside Corporation' 'Parkview School' 'Campus Center'
                                     'Township Hall');
  array datelist{15} _temporary_ (18924,18925,18927,18929,18933,
                                  18934,18935,18936,18940,18942,
                                  18945,18946,18962,18963,18964);

  attrib clinicsite length=$50
         clinicdate length=8 format=mmddyy10.;

  keep clinicsite clinicdate shots18_64 shots65plus;

  call streaminit(567712);

  do l=1 to 7;
    clinicsite=loclist{l};
    nd=ceil(rand('uniform')*4)+7;
    do d=1 to nd;
      dd=ceil(rand('uniform')*15);

      clinicdate=datelist(dd);
      shots18_64=ceil(rand('uniform')*90)+50;
      negpos=ceil(rand('uniform')*2);
      adj=ceil(rand('uniform')*50)/100;
      if negpos=1 then shots65plus=round(shots18_64*(1+adj),1);
      else shots65plus=round(shots18_64*(1-adj));

      output;
    end;
  end;
run;
