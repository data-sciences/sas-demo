/*-------------------------------------------------------------------*/
/*      Reading External Data Files Using SAS: Examples Handbook     */
/*                      by Michele M. Burlew                         */
/*       Copyright(c) 2002 by SAS Institute Inc., Cary, NC, USA      */
/*                   SAS Publications order # 57743                  */
/*                        ISBN 1-59047-115-6                         */
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
/* Attn: Michele Burlew                                              */
/* SAS Campus Drive                                                  */
/* Cary, NC   27513                                                  */
/*                                                                   */
/*                                                                   */
/* If you prefer, you can send email to:  sasbbu@sas.com             */
/* Use this for subject field:                                       */
/*     Comments for Michele Burlew                                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
/* Date Last Updated: 08UAG03                                        */
/*-------------------------------------------------------------------*/

/* Example 1.1 Reading Instream Data Lines */
data runners;
  input name $ age runtime1 runtime2 runtime3 runtime4;
datalines;
Scott 15 23.3 21.5 22.0 21.9
Mark 13 25.2 24.1 23.5 22.0
Jon 13 25.1 25.7 24.3 25.0
Michael 14 24.6 24.1 24.3 24.6
Matt 14 22.0 21.5 21.4 21.6
;;;;

/* Example 1.2 Reading Data Lines from an External File */
data runners;
  infile 'c:\readdata\runnersapril.dat';
  input name $ age runtime1 runtime2 runtime3 runtime4;
run;

/* Example 1.3 Working with Dates */
data payments;
  input id $4.  	@6 paydate1 mmddyy10. 
               	@17 paydate2 mmddyy10.;
datalines;
QDSW 04/15/2002 	06/15/2002
JDHA 5-2-02     	8-1-2002
MPWZ 12012002   	03042003
;;;;
proc print data=payments;
  title 'Payment Dates';
  format paydate1 mmddyy10.;
run;   

/* Example 1.4 Reading Data Lines with Column Input */
data stores;
  input 	storeid $ 1-6 state $ 1-2 
       	phone 7-16 areacode 7-9 
       	zipcode 17-25 zip1 17-21 zip2 22-25;
datalines;
WI03819205553945549101234
WI62356085553823537007362
WI72007155554820550017654
WI54124145550087532003221
;;;;

/* Example 1.5 Reading Data Lines with Formatted Input */
data patients;
  input @1 id $5.
      @1 initials $3. +3 ssn comma11.
      @19 (test1-test3) (4. +1)  ;
datalines;
AFG03 999-99-0393 381  1.3  	5
TEY01 999-99-7362          	3
REW17 999-99-4313 25   3   	0
;;;;

/* Example 1.6. Reading Data Lines with Modified List Input */ 
data survey;
  infile datalines 
         delimiter=',';
  input name : $15. 
        comments ~ $50.;
datalines;
Mary Ann,More restrictions on emails
Scott,Did not like slogan "Our Team is Tops"
Luke,Would like to have comp time
Rosa,Would like manager's input on reports
;;;;

/* Example 1.7 Reading Data Lines with Named Input */
data grades;
  length name $ 15;
  input name=$ math=;
datalines;
name=Linda english=95 math=94 science=90
name=Susan math=88 english=91 science=90
name=Mary Louise math=90 english=84 science=81
;;;;


/* Example 2.1, External File */
A03885 HR 1039.65 543.87 109.83 257.45
A03918 Acctg 3029.98 837.00 . 362.91
A05291 . . . . .
A06573 IT 5603.81 2091.23 393.39 103.95

/* Example 2.1, Program */
data expenses;
   infile 'c:\readdata\example2_1.dat';
   input personid $ dept $ hardware software books supplies;
run;
proc print data=expenses;
  title 'Expenses by Employee';
run;

/* Example 2.2, External File */
Neda,0,4,0,3,0,11
Amy,8,3,9,2,4,6
Janet,3,0,12,0,2,1
Pauline,0,1,3,0,4,2
Jo Ann,0,1,0,1,0,1

/* Example 2.2, Program */
data booksread;
  infile 'c:\readdata\example2_2.dat' 
           delimiter=',';                                                                                        
  input name $ biography business fiction science selfhelp
       travel;                                                                      
run;                                                                                                                                    
proc print data=booksread;                                                                                                              
  title 'Number of Books Read';                                                                                                         
run;

/* Example 2.3, External File */
Pat^12^0^30^10^25
Louise^22^16^45^38^67
Howard^43^88^0^0^103
Terri^8^70^5^1^10
Martin^21^10^3^0^33
Billy^9^0^18^19^14

/* Example 2.3, Program */
data helpline;                                                                                                                          
  infile 'c:\readdata\example2_3.dat'       
         delimiter='09'x;                                                                                                                 
  input name $ password hardware wordproc spreadsheet   
       virus;                                                                            
run;                                                                                                                                    
proc print data=helpline;                                                                                                               
  title 'Number of Help Line Calls by Consultant';                                                                                      
run;

/* Example 2.4, External File */
"Reynolds, Randy","3005 Mountain Rd","Germantown,PA 16240"
"Bain, Darlene","Box 44","Springs, WV 25045"
"Board, Carl","Route 44, Box 365","N. Freedom, PA 27460"

/* Example 2.4, Program */
data info; 
  infile 'c:\readdata\example2_4.dat'
         dsd;
  input name     : $20. 
        address1 : $25. 
        address2 : $25.;
run;
proc print data=info;
  title "Names and Addresses";
run;


/* Example 2.5, External File */
email,13,,,,3,5,2,2,4,,
phone,31,5,,3,3,4,1,,,3,5
phone,46,5,,3,3,4,1,,,3,5
email,63,5,4,5,4,4,4,4,4,5,

/* Example 2.5, Program */
data survey;
  infile 'c:\readdata\example2_5.dat'
         dsd;
  input type $ id q1-q10;
run;
proc print data=survey;
  title 'Survey Responses';
run;

/* Example 2.6, External File */
Franklin,Terry,01/15/2002,Sales,"$55,039.39",10%
Yen,Steve,010102,Accounting,"$51,003.00",
Drake,Wanda,02/15/02,Support Staff,"$43,429.37",
Top,Ronald,06/18/2002,Accounting,"$53,387.93",
McFarlen,Virginia,03/01/2002,Design,"$66,938.34",
Robertson,Jonathon,11/15/2002,Design,"$68,382.34",
Marks,Ann Marie,12/01/2002,Sales,"$57,543.00",10%

/* Example 2.6, Program */
data newhires;
  infile 'c:\readdata\example2_6.dat'
         dsd;
  input lastname   : $25.
        firstname  : $15.  
        hiredate   : mmddyy10.
        department : $15.
        salary     : comma11.2
        commission : percent4.;
  if commission=. then commission=0;
  format hiredate   mmddyy10.
         salary     dollar11.2
         commission percent5.;
run;
proc print data=newhires;
  title 'Employees Hired in 2002';
run;

/* Example 2.7, External File */
01/03   Sporting Goods	18000         
15000
01/03   Hardware	35300         
38000
01/03   Domestics	25000         
32000
01/03   Toys	15000         
17735
01/03   Health and Beauty	20000         
22000

02/03   Sporting Goods	20000         
19000
02/03   Hardware	45300         
40000
02/03   Domestics	15000         
21000
02/03   Toys	25000         
23000
02/03   Health and Beauty	22000         
22500

03/03   Sporting Goods	25000         
27000
03/03   Hardware	38600         
41000
03/03   Domestics	18000         
17000
03/03   Toys	26000         
25000
03/03   Health and Beauty	26000         
21000

/* Example 2.7, Program */
data salesperdept;
  infile 'c:\readdata\jan2003_2_7.dat' 
         end=endjan;
  do until (endjan);
    input @1  monyr $5. 
          @9  department $20.
          @34 actualsales 
          @48 salesgoal;
    output;
  end;

  infile 'c:\readdata\feb2003_2_7.dat' 
         end=endfeb;
  do until (endfeb);
        input @1  monyr $5. 
              @8  department $20.
              @34 actualsales 
              @48 salesgoal;
    output;
  end;

  infile 'c:\readdata\mar2003_2_7.dat' 
         end=endmar;
  do until (endmar);
    input @1  monyr $5. 
          @9  department $20.
          @34 actualsales 
          @48 salesgoal;
    output;
  end;

  format actualsales salesgoal dollar10.2;
run;
proc print data=salesperdept;
  title "Sales per Department";
run;

/* Example 2.8, External File */
01/03   Sporting Goods	18000         
15000
01/03   Hardware	35300         
38000
01/03   Domestics	25000         
32000
01/03   Toys	15000         
17735
01/03   Health and Beauty	20000         
22000

02/03   Sporting Goods	20000         
19000
02/03   Hardware	45300         
40000
02/03   Domestics	5000          
21000
02/03   Toys	25000         
23000
02/03   Health and Beauty	22000         
22500

03/03   Sporting Goods	25000         
27000
03/03   Hardware	38600         
41000
03/03   Domestics	18000         
17000
03/03   Toys	26000         
25000
03/03   Health and Beauty	26000         
21000

/* Example 2.8, Program */
data salesperdept;
  infile 'c:\readdata\salesfiles_2_7.dat';
  input salesfile : $75.;
  infile dummy 
         filevar=salesfile 
         end=endfile;
  do while (not endfile);
    input @1  monyr $5.
          @8  department $20.
          @34 actualsales
          @48 salesgoal;
    output;
  end;
  format actualsales salesgoal dollar10.2;
run;
proc print data=salesperdept;
  title "Sales per Department";
run;

/* Example 2.9, External File */
Dana           98   96   96   98
Charley        80   84   88   80
Martin         78   74   80  100
Amber         100   84    .   96

Dana           98   96   96   98
Charley        80   84   88   80
Martin         78   74   80  100
Amber          90   82   88   98

Dana           64   72   80   76
Charley        80   84   88   92
Martin          .  100  100  100
Amber          88   86   84   70

Dana           98   92   90   99
Martin         70   80   90  100
Amber          90   90   90   90

/* Example 2.9, Program */
data grades;  
  do quarter=1 to 4;
    classdata='c:\readdata\qtr' ||
              put(quarter,1.) || '.dat';
    infile dummy 
           filevar=classdata 
           end=endfile;
    do while (not endfile);
      input name      $ 1-12
            chemistry   15-17
            english     20-22
            history     25-27
            mathematics 30-32;
      output;
    end;
  end;
  stop;
run;

/* Example 2.10, External File */
Brandywine,5,13,0,5
Best Red,8,12,11,13
Roma,15,18,17,8
Chunky Cherry,25,18,30,31  

/* Example 2.10, Program */
filename plots 'c:\readdata\example2_10.dat';
data veggies(keep=variety plot1-plot4);
  length vegyear $ 100;
  infile plots 
         filename=vegyear 
         end=lastplot 
         dsd;
  input variety : $15. 
        plot1-plot4;
  if lastplot then do;
    vegyear=scan(vegyear,4,'\');
    vegetable=scan(vegyear,1,'_');

    call symput('vegtitle',trim(left(vegetable)));
    trialyear=scan(vegyear,2,'_');

    call symput('yeartitle',trim(left(trialyear)));
  end;
run;
proc print data=veggies;
  title "Results for &vegtitle in &yeartitle";
run;

/* Example 2.11, External File */
Media Source              New York
Tech Ref Publications     Massachusetts
Midwest Books Supply      Wisconsin
Business Resources        Utah   

/* Example 2.11, Program */
data publishers;
  infile 'c:\readdata\example2_11.dat' 
         truncover;
  input @1  publishername $25.
        @27 publisherstate $15.;
run;
proc print data=publishers;
  title 'Publishers';
run;

/* Example 2.12, External File */
EMP0312  28SEP2003   2509.32 MMW
EMP0381  28SEP2003   2699.89 TXP
EMP0543  28SEP2003   9006.19
EMP0387  28SEP2003    875.39 T
EMP0432  28SEP2003
EMP0382  28SEP2003  19392.38 LII

/* Example 2.12, Program */
data sales;
  infile 'c:\readdata\example2_12.dat' 
          missover;
  input @1  employee_id	$7.
        @10 salesdate	date9.
        @20 salesamount	8.
        @30 supvinits	$3.;
  format salesdate date9. salesamount dollar12.2;
run;

proc print data=sales;
  title 'Sales Data';
run;

/* Example 2.13, External File */
EMP0312  28SEP2003   2509.32 MMW
EMP0381  28SEP2003   2699.89 TXP
EMP0543  28SEP2003   9006.19
EMP0387  28SEP2003    875.39 T
EMP0432  28SEP2003
EMP0382  28SEP2003  19392.38 LII

/* Example 2.13, Program */
data sales;
  infile 'c:\readdata\example2_12.dat' 
         stopover;
  input @1  employee_id	$7.
        @10 salesdate	date9.
        @21 salesamount	8.
        @30 supvinits	3.;
  format salesdate date9. salesamount dollar12.2;
run;
proc print data=sales;
  title 'Sales Data';
run;

/* Example 3.1, External File */
Mary Patrick
313-555-9098
2440 West Maple Rd.
Trenton MI  48183
Gregory Higgins

1507 Knightdale Court
Harrisburg PA  19075
Don Lynx
608-555-1332
43 Madison East
Madison WI  54311

/* Example 3.1, Program */
data info;  
  infile 'c:\readdata\example3_1.dat' 
          truncover;
  input #1 name $15.
        #2 phonenumber comma12.
        #3 address1 $30.
        #4 address2 $30.;  
run;
proc print data=info;
  title 'Address Information';
run; 


/* Example 3.2, External File */
09/01/2003 . 09/02/2003 $45.00 09/03/2003 $46.38
09/04/2003 $42.33 09/05/2003 $38.88 09/08/2003 $37.73
09/09/2003 $40.87 09/10/2003 $40.55 09/11/2003 $35.33
09/12/2003 $32.01

/* Example 3.2, Program */
data stockprices;
  infile 'c:\readdata\example3_2.dat';
  input saledate   mmddyy10. 
        stockprice : comma8.2 
        @@;
  format saledate mmddyy10. stockprice dollar8.2;
run;
proc print data=stockprices;
  title "Stock Price at End of Trading";
run; 


/* Example 3.3, External File */
Lake 10/10/2001    8:00 38   16:00 47   24:00 42
City 10/10/2001    8:00 40   16:00 58   24:00 45
Yard 10/10/2001    8:00 33   16:00 52   24:00 41
Lake 10/17/2001    8:00 32   16:00 35   24:00 34
City 10/17/2001    8:00 32   16:00 40   24:00 37

/* Example 3.3, Program */
data octobertemps;
  infile 'c:\readdata\example3_3.dat';
  input @1 location $4. +1 
           datemeasured mmddyy10. 
        @;

  drop i;
  format datemeasured mmddyy10.
         timemeasured timeampm8.;
  do i=1 to 3;
    input +3 timemeasured time5. 
          +1 tempf 2. 
          @;
    output;
  end;
run;
proc print data=octobertemps;
  title "Temperature Readings";
run;    


/* Example 3.4, External File */
Boddorf3  85 83 90 85 90 87 87 86 88
Isley  2  86 78 80 81 85 87
Smith  0
Jones  3  76  . 77 71 80 82 84 85 79
Joyce  1 100 98 95
Morgan 3  90 92 90 93100 91 89 92 94

/* Example 3.4, Program */
data grades;
  infile 'c:\readdata\example3_4.dat';
  input lastname $7. nperiods 1. +1 
          @;
  drop nperiods;
  if nperiods gt 0 then do;
    do period=1 to nperiods;
      input (test quiz homework) (3.) 
            @;
      output;
    end;
  end;

  else do;
    put '****No grading periods specified for ' 
        lastname;
  end;
run;
proc print data=grades;
  title 'Grades for Several Periods';
run;       


/* Example 3.5, External File */
62 63 63 62 . . . 66 70 72
73 77 81 83 86 89 90 88 87 85
78 74 . . 68 66 65 65 63 63
66 69 72 74 79 83 87 90 92 91
91 90 87 85 80 78 76 75 66 66
65 63 62 60 61 64 70 73 76 82
88 89 92 93 92 91 88 84 82 81
78 79

/* Example 3.5, Program */
data threedays;                                                                                                                         
  infile 'c:\readdata\example3_5.dat';                
  array temperature{24} temp1-temp24; 
  drop i; 
  daycount + 1;                        
  do i=1 to 24;    
    input temperature{i} 
          @@;                                                                                                            
  end;                                                                                                                                   
run;        


/* Example 3.6, External File */
NWilliam E. Ghoat
EWilliam.Ghoat@itsuperstars.com
NChris Gomez
AOverland Park           KS 59381
P913-555-3434x9863
Ecb001@kansas.com
F913-555-4439
NLouis Taylor
NSusann Rose
ARiverside               CA 91999
CNo Commission on Last Sale
P714-555-3391
O$335876.76
NMegumi Nakagawa
ALihui                   HI 99889
P808/555-7876
CRequest for Catalog

/* Example 3.6, Program */
data accounts;                                                                                                                          
  infile 'c:\readdata\example3_6.dat' 
         truncover
         end=done;                                                                         
  retain name city state zip comment email fax phone;                                                                                   
  length name $ 25 city $ 24 state $ 2                                                                                                  
        comment email $ 50 fax phone $ 20;                                                                                             
  drop rectype;                                                                                                                         
  input rectype $1. 
        @;                                                                                                                  
  if rectype='N' and _n_ ne 1 then do;            
    output;      
    name=' ';                                                                                                                           
    city=' ';                                                                                                                           
    state=' ';                                                                                                                          
    zip=.;                                                                                                                              
    comment=' ';                                                                                                                        
    email=' ';                                                                                                                          
    fax=' ';                                                                                                                            
    phone=' ';                                                                                                                          
  end;                                                                                                                                  
                
  select (rectype);   
    when ('A') input city $24. state $2. +1 zip 5.;                                                                                     
    when ('C') input comment  $50.;                                                                                                     
    when ('E') input email $50.;                                                                                                        
    when ('F') input fax   $20.;                                                                                                        
    when ('N') input name  $25.;                                                                                                        
    when ('P') input phone $20.;                                                                                                        
    otherwise do;   
      put 'Unknown Record Type: ' rectype                                                                                               
          'for data line: ' _n_ / 
          _infile_;                                                                                             
    end;                                                                                                                                
  end;                                                                                                                                  

  if done then output;
run;                                                                                                                                    
proc print data=accounts;                                                                                                                             
  title 'Accounts Information';                                                                                                         
run;


/* Example 3.7, External File */
T Mary Smith            334
S Emily Livingston      15   333 East Shore Drive    Shoreview
C Algebra              1
C History              2
C Chemistry            4
C Music                5
S Jeremy Anderson       14   153 Winding Way         Shoreview
C Physics              1
C English              2
C Keyboarding          3
C Snowboarding         6
T John Schultz          331
S Katie Carlson         14   9873 South Blvd         Roseville
C Art History          1
C American Literature  2
S Sue Lee               15   873 Valley Pkwy         Roseville
C Calculus             1
C Creative Writing     2
C Computer Programming 3
S Rick Ramirez          15   65 Maple St.            Pleasant Lake
C Computer Programming 2
C Physical Education   3


/* Example 3.7, Program */
data students;
  infile 'c:\readdata\example3_7.dat' 
         end=last;

  retain flag 0 teachername teacherroom
      studentname studentage studentaddress studentcity
      classname1-classname4 classperiod1-classperiod4;

  array classname{4}  $ 20 classname1-classname4;
  array classperiod{4} classperiod1-classperiod4;
  drop classnum i flag type;
  input @1 type $1. @;
  select (type);
    when ('T') do;
      if flag then output;
      flag=0;
      input teachername $ 3-22 teacherroom 25-27;
    end;
    when ('S') do;
      if flag then output;
      classnum=0;
      flag=0;
      do i=1 to 4;
        classname{i}=' ';
        classperiod{i}=.;
      end;
      input studentname $ 3-22 studentage 25-26
            studentaddress $ 30-52 studentcity : $13.;
    end;
    when ('C') do;
      classnum+1;
      flag=1;
      input classname{classnum} $ 3-22
            classperiod{classnum} 24;
    end;
    otherwise do;
      file log;
      put 'Unknown Record Type: ' _infile_;
      delete;
    end;
  end;

  if last then output;
run;
proc sort data=students;
  by teachername teacherroom;
run;
proc print data=students;
  title 'Student Information by Teacher';
  by teachername teacherroom;
run;

/* Example 3.8, External File */
14Highland Hills31Prairie Plants for the Backyard04/03/20023
18West Lake Regional24101 Ways to Retire Early05/02/20025
05Maple39Bed and Breakfasts in the Upper Midwest05/01/20021
24Metropolitan Main Branch25Mammals of the Northwoods01/15/20022
24Metropolitan Main Branch16Investing Basics01/30/200210
24Metropolitan Main Branch18Auto Repair-Safely02/18/20022
05Maple16Halloween Baking09/01/20021
18West Lake Regional26Taking Care of Your Health01/19/20022

/* Example 3.8, Program */
data bookorder;
  infile 'c:\readdata\example3_8.dat' 
           truncover;
  drop liblength titlelength;
  input liblength 2. 
        libraryname $varying50. liblength
        titlelength 2. 
        booktitle $varying50. titlelength
        orderdate mmddyy10. ncopies 2.;
  format orderdate mmddyy10.;
run;
proc sort data=bookorder;
  by libraryname;
run;
proc print data=bookorder;
  title 'Books Ordered by Library';
  by libraryname;
run;



/* Example 3.9, External File */
My pasta was cold.$25.2010/01/2001
Service slow, food great.$38.7310/02/2001
More selection on the children's menu!!!$45.1110/02/2001
More off-street parking.$18.3810/02/2001
$20.8710/02/2001
Too noisy. Food bland. Menu overpriced.$27.6610/03/2001

/* Example 3.9, Program */
data comments;
  infile 'c:\readdata\example3_9.dat'
         length=recordlength; 
  length fullrecord $ 100 comment $ 90;
  drop fullrecord commentlength;
  format visitdate mmddyy10. bill dollar6.2;
  input fullrecord $varying. recordlength 
        @;
  commentlength=index(fullrecord,'$')-1;
  input @1 comment $varying. commentlength
           bill comma6.2
           visitdate mmddyy10.;
  if comment=' ' then comment='No comment recorded.';
run;
proc print data=comments;
  title 'Recent Restaurant Comments';
run;


/* Example 3.10, External File */
NY 339.29 CT 887.87 RI 8763.00 CT 87.98
GA 102.87 FL 978.67 FL 876.33 NH 351.98
MA 2347.01 FL 55361.33 GA 553.01 NH 653.22
NY 120987.33 NJ 999.99 NY 331.30 GA 77789.23
GA 8730.12 GA 5430.90 GA 152.07 CT 109.98

/* Example 3.10, Program */
data _null_;
  infile 'c:\readdata\example3_10.dat' 
         eof=summary;

  length state $ 2;
  input state $ sales 
      @@;
  if state in ('CT' 'MA' 'NH' 'NY' 'NJ' 'RI') then do;
    nsalesne+1;
    sumne+sales;
  end;
  else if state in ('GA' 'FL') then do;
    nsalesse+1;
    sumse+sales;
  end;
  return;

  summary:
    if nsalesne > 0 then avgne=sumne/nsalesne;
    if nsalesse > 0 then avgse=sumse/nsalesse;
    put 29*'*-' /
  'Region     Total Sales     N Sales   Average Sale'/
      'Northeast' @12 sumne dollar15.2 @35 nsalesne 2.
      @43 avgne dollar9.2 /
      'Southeast' @12 sumse dollar15.2 @35 nsalesse 2.
      @43 avgse dollar9.2 /
      29*'*-' ;
run;



/* Example 3.11, External File */
Everyday Web Page Construction
2002 IT Publishing                San Francisco
Strategic Data Mining
2002 Smith, Anderson, Carlson     New York
Retirement Planning for the Next Generation
2002 Home Publishers              Chicago
How to Cope with Busy Teenage Schedules
2002 Home Publishers              Chicago
Favorite Dogs Calendar 2003
2002 Home Publishers              Chicago
Reading Spreadsheet Data
2002 Smith, Anderson, Carlson     New York  

/* Example 3.11, Program */
data mybookorder;
  infile 'c:\readdata\example3_11.dat' 
         truncover
         firstobs=5 
         obs=10;

  input booktitle $50. /
        yearpublished 4. 
        @6 publisher $25. 
        @35 publishercity $15.;
run;
proc print data=mybookorder;
  title 'Selected Books from My Book Order';
run;  


/* Example 3.12, External File */
Pizaro's        Delivery 4 4 . N 
Pizaro's        Delivery 3 R 3 N 
Pizaro's        Dine-In  4 5 . 4 
Pizaro's        Dine-In  4 R 2 5 
Pizaro's        Delivery 4 R 2 N 
Mamamia         Dine-In  1 . 2 R 
Mamamia         Dine-In  R 3 4 4 
Mamamia         Delivery 3 . . N 
Mamamia         Delivery 2 3 3 N 
Mamamia         Dine-In  R 3 4 4 
Mamamia         Delivery 3 3 3 N 

/* Example 3.12, Program */
missing N R;
data pizzasurvey;
  infile 'c:\readdata\example3_12.dat';
  input pizzaplace $15. +1 type $8.
        pizzahot ontime courteous howsoonseated;
run;
proc print data=pizzasurvey;
  title 'Pizza Survey Results';
run; 


/* Example 3.13, External File */
39183~S~09/30/2002~$56,008.32~Network Analyst
39184~A~10/04/2002~76 East Parkway~Westville~MN~55126
39186~S~09/30/2002~$48,399.01~Senior Research Technician
39190~A~10/01/2002~3405 Turtle Lake Rd.~Shoreview~MN~55126
39185~S~09/30/2002~$59,039.77~Business Analyst

/* Example 3.13, Program */
data corp.employees;
  infile 'c:\readdata\example3_13.dat'
         delimiter='~' 
         truncover;
  input personid 
        @;
  modify corp.employees 
         key=personid;
  select (_iorc_);
    when (%sysrc(_sok)) do;
      input updatetype $ 
            @;

      if updatetype='A' then do;
        input addressdate : mmddyy10.
              address : $30.
              city    : $20.
              state     $2.
              zipcode;
        replace;
      end;

      else if updatetype='S' then do;
        input salarydate : mmddyy10.
              salary : comma10.2
              jobtitle : $25.;
        replace;
      end;

      else do;
        put '***** Update Type not A or S for ' personid;
      end; 
    end;

    when (%sysrc(_dsenom)) do;      
      put '***** Person ID Not Found: ' personid;
      _error_=0;
    end;

    otherwise do;
      put '***** Unexpected Error: ' _iorc_= _infile_;
      stop;
    end;
  end;
run;

/* Example 4.1, External File */
----+----1----+----2----+----3----+----4----+----5
Smith	Susan	Rose
Lewis	Carol	Ann
Morris	Mark	D.
----+----1----+----2----+----3----+----4----+----5
Smith                Susan           Rose
Lewis                Carol           Ann
Morris               Mark            D.

----+----6----+----7----+----8----+----9----+----0
   ABC Consulting Inc.            300 West Shore D
   HiTech Company                 One HiTech Place
   Professional Consultants       95 Oak Forest Wa

         1         1         1         1         1
----+----1----+----2----+----3----+----4----+----5
rive           Suite 101                      Mapl
               Mailstop 3028                  High
y              Building 32                    Howa

         1         1         1         1         2
----+----6----+----7----+----8----+----9----+----0
etown            Massachusetts        02999-9999 0
land             Illinois             60000-9999 0
rd               North Carolina       27000-9999 0

         2         2         2         2         2
----+----1----+----2----+----3----+----4----+----5
5/13/2002 SAS Basics I                   06/17/200
1/14/2002 Advanced DATA Step Programming
1/14/2002 Advanced DATA Step Programming 03/04/200

         2         2         2         2         3
----+----6----+----7----+----8----+----9----+----0
2 Report-Writing Fundamentals    09/25/2002 Statis
2 SAS Macro Programming


         3         3
----+----1----+----2----
tical Analysis II


/* Example 4.1, Program */
data sasstudents;
  infile 'c:\readdata\example4_1.dat'
         lrecl=324
         truncover;

  input lastname   $ 1-20
        firstname  $ 22-36
        middlename $ 38-52
        company    $ 54-83
        address1   $ 85-114
        address2   $ 116-145
        city       $ 147-166
        state      $ 168-187
        zip        $ 189-198
        @200 classdate1 mmddyy10.
        classname1 $ 211-240
        @242 classdate2 mmddyy10.
        classname2 $ 253-282
        @284 classdate3 mmddyy10.
        classname3 $ 295-324;

  format classdate1-classdate3 mmddyy10.;
run;
proc print data=sasstudents;
  title 'SAS Students';
run;        


/* Example 4.2, External File 1 */
Mark S.      Green 12 12 15
Brad Y.      Green 13 11 59
Alex C.      Green 14 13 43
Ryan C.      Green 12 15 15
Tom B.       Green 14 10 30
Todd C.      Green 14 9  4
Dan Y.       Green 13 12 11
Jason L.     Green 12 14 5  

/* Example 4.2, External File 2 */
Scott B.     Blue  14 9  50
Mark B.      Blue  13 13 1
Matthew S.   Blue  13 12 39
Colin K.     Blue  12 12 25
Joe K.       Blue  12 13 57
Joel O.      Blue  13 12 32
Mike C.      Blue  14 11 13
Craig A.     Blue  13 13 51


/* Example 4.2, Program */
filename twofiles ('c:\books\readdata\example4_2.dat',
                  'c:\books\readdata\ example4_2b.dat');

data racetimes;
  infile twofiles;
  input @1 name $12. @14 team $5. @20 age 2.
        @23 minutes 2. @26 seconds 2.;
run;
proc print data=racetimes;
  title 'Runners and Race Times';
run;      


/* Example 4.3, External File */
Tilia americana         Basswood        5
Prunus serotina         Black Cherry  121
Quercus macrocapra      Bur Oak         2
Fraxinus pennsylvanica  Green Ash      87
Ostyra virginiana       Ironwood       42
Amelanchier arborea     Juneberry      32
Betula papyrifera       Paper Birch     1
Quercus rubra           Red Oak        39
Acer saccharinum        Silver Maple    2
Acer saccharum          Sugar Maple     8
Quercus alba            White Oak      10


/* Example 4.3, Program */
filename trees ('c:\readdata','d:\readdata');

data trees;
  infile trees(trees2002.dat);
  input @1  scientific $22.
        @25 tree       $11.
        @39 count      3.;
run;
proc print data=trees;
  title 'Trees in Plot';
run;   


/* Example 4.4, External File */
HGH 10/06/2002 3 Chicago
TIW 10/06/2002 1 Atlanta
RON 10/07/2002 1 Dallas
PAA 10/07/2002 3 San Francisco
NBS 10/08/2002 1 Cleveland
EMB 10/08/2002 2 NYC
JAZ 10/09/2002 3 Portland OR
KBB 10/10/2002 1 Boston 

/* Example 4.4, Program */
data weeklytravel;
  infile thisweek truncover;
  input @1  empinits $3.
        @5  departure mmddyy10.
        @16 days 1.
        @18 destination $25.;
  format departure mmddyy10.;
run;
proc print data=weeklytravel;
  title 'This Week''s Travel Schedule';
run;   


/* Example 4.5, External File, Section 1 File */
Martinez, Marie    98   87   90   92
Hughes, Henry      88   78   87   86
Mann, Lois         76   75   .    .
Marks, Teri        89   91   .    90
Lin, Tom           99   100  90   98
Wicz, Art          84   100  95   98
Baker, Katie       86   81   79   81
Zelaska, Jenny     94   93   98   100

/* Example 4.5, External File, Section 2 File */
Mack, Bill         81   77   80   92
Holt, Kathy        96   98   97   86
Chang, Sam         83   85   90   88
Leigh, Joe         74   71   80   82
Glass, Don         87   .    90   95
Gomez, Sandra      91   93   .    88
Trenton, Barb      90   91   89   91

/* Example 4.5, External File, Section 3 File */
Moss, Melinda      94   97   90   95
Stanley, Luis      75   .    81   83
Fields, Rosie      82   85   85   85
Banks, Jon         88   90   84   81
Ramirez, Eduardo   83   .    77   .
Kowal, Mickey      93   97   98   100
Cheer, Nancy       100  100  100  100
Meier, Matt        80   83   88   90  


/* Example 4.5, Program */
title "Files in Directory";
data _null_;
  length fileline $ 50
         ckfilename $ 50;
  checkdir='c:\readdata\testdir\';
  file print;
  put /;
  rc=filename('mydir',checkdir);
  if rc ne 0 then do;
    file log;
    put '***Unable to access directory: 'checkdir;
    stop;
  end;
  dirid=dopen('mydir');
  nfiles=dnum(dirid);
  do i=1 to nfiles;
    ckfilename=dread(dirid,i);
    rc=filename('ckfilref',checkdir || ckfilename);
    if rc ne 0 then do;
      file log;
      put '***Unable to access external file: 'ckfilename;
      stop;
    end;
    fileid=fopen('ckfilref');
    ninfoitems=foptnum(fileid);
    do j=1 to ninfoitems;
      infoitem=foptname(fileid,j);
      infovalue=finfo(fileid,infoitem);
      put infoitem infovalue;
    end;
    put 'First 3 Lines: ' @;
    do k=1 to 3;
      rc=fread(fileid);
      if rc ne 0 then do;
        file log;
        put '***Unable to read from file: ' ckfilename;
        stop;
      end;
      rc=fget(fileid,fileline,50);
      if rc=0 then put @16 fileline;
      else do;
        file log;
        put '***Unable to extract data from: ' ckfilename;
        file print;
      end;
    end;
    put 60*'=';
    rc=fclose(fileid);
    if rc ne 0 then do;
      file log;
      put '***Unable to close external file: ' ckfilename;
      stop;
    end;
  end;
  rc=dclose(dirid);
  if rc ne 0 then do;
    file log;
    put '***Unable to close directory: ' checkdir;
  end;
run;

/* Example 4.6 Create External File on MVS */
data _null_;
  infile datalines;
  input @1 township $15. @17 county $10.
        @29 households 5. @35 taxes 10.;

  /* Specify the name and features of the file */
  /* according to your system requirements.    */
  file 'myid.taxes.janweek1';
  put @1  township   $15.
      @16 county     $10.
      @26 households pd4.
      @30 taxes      pd8.2;

datalines;
Thompson        Washington   3500  100392.39
West Lake       Washington    788   43099.10
Shoreview       Washington   1983  120398.09
Greenbriars     Lake        35988 1938730.98
Bascom          Lake        21971  987738.09
Mendota         Lake          776   44879.54
Stillwater      Lake          410   20987.01
Canalport       Lake         1109   32973.38
;;;;



/* Example 4.6, External File */
----+----1----+----2----+----3----+----4----+----5
Thompson       Washington  &
E8999A994444444E8A8898A99005000000329
3864726500000006128957365030C0001093C
West Lake      Washington          j
E8AA4D898444444E8A8898A99007800004090
6523031250000006128957365008C0000391C
Shoreview      Washington  q
E8998A88A444444E8A8898A99009300002389
2869559560000006128957365018C0001090C
Greenbriars    Lake        q
C988989889A4444D898444444039800013708
7955529919200003125000000058C0009839C
Bascom         Lake        p     g
C8A899444444444D898444444029100008789
2123640000000003125000000017C0009730C
Mendota        Lake         %     gn<
D8989A844444444D898444444007600004894
4554631000000003125000000007C0000475C
Stillwater     Lake               q
EA899A8A8944444D898444444004000002971
2393361359000003125000000001C0000080C
Canalport      Lake               p
C8989999A444444D898444444001900003938
3151376930000003125000000010C0000273C


/* Example 4.6, Program */
filename rlink 'c:\programfiles\sasinstitute\v8\connect\saslink\tcpmvs.scr';
options remote=mvs
        comamid=tcp;
signon;

rsubmit;
  data taxes;
    infile 'myid.taxes.janweek1';
    input @1  township $15. 
          @16 county $10.
          @26 households pd4. 
          @30 taxes pd8.2;
    average=taxes/households;
    format taxes average dollar12.2;
  run;
endrsubmit;
libname rmtwork 
        slibref=work 
        server=mvs;

proc print data=rmtwork.taxes;
  title "Tax Revenue to Date";
run;      

signoff;


/* Example 4.7, External File, Section 1 */
Martinez, Marie    98   87   90   92
Hughes, Henry      88   78   87   86
Mann, Lois         76   75   .    .
Marks, Teri        89   91   .    90
Lin, Tom           99   100  90   98
Wicz, Art          84   100  95   98
Baker, Katie       86   81   79   81
Zelaska, Jenny     94   93   98   100

/* Example 4.7, External File, Section 2 */
Mack, Bill         81   77   80   92
Holt, Kathy        96   98   97   86
Chang, Sam         83   85   90   88
Leigh, Joe         74   71   80   82
Glass, Don         87   .    90   95
Gomez, Sandra      91   93   .    88
Trenton, Barb      90   91   89   91

/* Example 4.7, External File, Section 3 */
Moss, Melinda      94   97   90   95
Stanley, Luis      75   .    81   83
Fields, Rosie      82   85   85   85
Banks, Jon         88   90   84   81
Ramirez, Eduardo   83   .    77   .
Kowal, Mickey      93   97   98   100
Cheer, Nancy       100  100  100  100
Meier, Matt        80   83   88   90  


/* Example 4.7, Program */
proc source noprint
            nodata
            indd='college.english.comp101'
            dirdd='myid.comp101.list';
run;

data students;
  length fullname $ 100;
  infile 'myid.comp101.list';
  input fullname $ ;
  if index(upcase(fullname),'SECTION') > 0 then do;
    fullname='college.english.comp101(' ||
             trim(fullname) || ')';
    infile dummy 
          filevar=fullname 
          end=endmember;
    do until(endmember);
      input student $ 1-16 quiz1-quiz4;
      avgquiz=mean(of quiz1-quiz4);
      output students;
    end;
  end;
run;
proc print data=students;
  title 'Students in English Comp 101';
  var student quiz1-quiz4 avgquiz;
  format avgquiz 5.1;
run;


/* Example 4.8, External File */
AB8372583U
II3757293Z
JY0937639Q
RA3863296P
CV7338728E

AB8372583USMITH             JOSEPH         A    05151970
AZ8372962OEVANS             MARGARET            11231959
BJ3769273YLEE               LINDA          L    04021965
CV7338728ECARLSON           JOANNE         Z    03281968
CZ3872764AANDERSON          JAMES          T    08141952
GE6737863PRICH              ROBERT         W    10201963
HU1937638VLOUIS             KATRINKA       A    01151982
JY0937639QRAMIREZ           ROSA           D    12011954
RA3863296PBOLDT             BRUCE          M    09301962



/* Example 4.8, Program */
data finddriver;
  infile 'myid.finddriv.dat';
  input dlid $10.;
  infile 'minnesota.drivers.ksds' 
          vsam 
          key=dlid
          feedback=vsamrc;
  input @;
  if vsamrc=16 then do;
    _error_=0;
    lastname='** Not Found';
    output;
    return;
  end;
  else if vsamrc ne 0 then do;
    put '**** Unknown Error, Program Halted ' vsamrc=;
    stop;
  end;  
  
  input @11 lastname $18. firstname $15. mi $1.
           dob mmddyy8.;

  output;
  format dob mmddyy10.;
run;
proc print data=finddriver;
  title 'Results of VSAM Key Lookup';
run;

/* Example 4.9, External File */
----+----1----+----2----+----3----+----4----+----5
Marketing        *    1A22Z009B K 130
D8998A8984444444150091FCFFEFFFC0D4FFF
41925395700000000C020C112290092720130
IT                   @2C64Z088D K 131
CE44444444444444000037FCFFEFFFC0D4FFF
93000000000000009C039C236490884720131
IT                    1K36R029A K 2 1
CE44444444444444000391FDFFDFFFC0D4F4F
93000000000000009C110C123690291720201
Human Resources     q 3Y32Z002L K 2 1
CA9894D8A9A988A4180393FEFFEFFFD0D4F4F
84415095264935200C038C383290023720201
Office Resources      5P39T873Q K 2 1
D888884D8A9A988A100371FDFFEFFFD0D4F4F
66693509526493521C588C573938738720201
Office Resources      4T07Q237B K 2 1
D888884D8A9A988A101678FEFFDFFFC0D4F4F
66693509526493521C156C430782372720201


/* Example 4.9 Create External File on MVS to Download */
data _null_;
  infile datalines;
  input dept $16. +2 deptid 3. +2
        cost 8. +1 packageid $9. +1
        shipdate mmddyy10.;

  mo=month(shipdate);
  da=day(shipdate);
  yr=year(shipdate);

  /* Specify the name and features of the file */
  /* according to your system requirements.    */
  file 'myid.shipinfo.dat';
  put dept $16.
      deptid pd2.
      cost pd4.2
      packageid $9.
      yr pib2. mo 2. da 2.;

datalines;
Marketing         105 29.01    1A22Z009B 01/30/2002
IT                090 33.97    2C64Z088D 01/31/2002
IT                090 1319.01  1K36R029A 02/01/2002
Human Resources   108 339.83   3Y32Z002L 02/01/2002
Office Resources  110 5387.81  5P39T873Q 02/01/2002
Office Resources  110 11657.68 4T07Q237B 02/01/2002
;;;;



/* Example 4.9, Program */
data shipinfo;
  infile 'c:\readdata\example4_9.dat'
         recfm=f lrecl=37;         
  input dept      $ebcdic16. 
        deptid    s370fpd2. 
        cost      s370fpd4.2
        packageid $ebcdic9.
        shipyear  s370fpib2. 
        shipmonth s370ff2. 
        shipday   s370ff2.;
  drop shipyear shipmonth shipday;
  shipdate=mdy(shipmonth,shipday,shipyear);
  format cost dollar9.2 shipdate mmddyy10.;
run;
proc print data=shipinfo;
  title "Recent Shipment Information";
run;  



/* Example 4.10, External File */
Y7Johnson422Field Trip and BanquetY5Adams222Field Trip and Ban quetN8JacobsonY9Stevenson213Workshop OnlyY6Walker420Banquet an d WorkshopN8MorrisonY5Green314All ActivitiesN3Lee

/* Example 4.10, Program */
data attendance;
  infile 'c:\readdata\example4_10.dat'
         recfm=n
         eof=last;
  drop famlength actlength;
  input attend $1.
        famlength 1. 
.
        family $varying9. famlength 
  @@;

  if attend='Y' then do;
    input howmany 1.
          actlength 2.
          activity $varying22. actlength 
          @@;
  end;

  else if attend='N' then do;
    howmany=0;
    activity='None';
  end;
  return;

  last:
    put 'Reached end of file';
    stop;
run;
proc sort data=attendance;
  by attend family;
run;
proc print data=attendance;
  title "Families by Attendance";
  by attend;
  var family howmany activity;
run;


/* Example 4.11, External File, pollencampus.dat */
09/01/2002 Medium     Grass
09/02/2002 Low        Mold spores
09/03/2002 High       Grass, Ragweed
09/04/2002 Medium     Grass
09/05/2002 Medium     Grass, Mold spores
09/06/2002 Extreme    Ragweed
09/07/2002 Extreme    Ragweed

/* Example 4.11, External File, pollenpark.dat */
09/01/2002 High       Ragweed, Grass
09/02/2002 Extreme    Mold spores
09/03/2002 High       Mold spores, Ragweed, Grass
09/04/2002 Extreme    Ragweed
09/05/2002 Medium     Grass
09/06/2002 Medium     Grass
09/07/2002 Medium     Grass

/* Example 4.11, External File, pollensuburb.dat */
09/01/2002 Negligible Mold spores
09/02/2002 Low        Mold spores
09/03/2002 Low        Mold Spores
09/04/2002 Medium     Mold Spores, Ragweed
09/05/2002 High       Ragweed, Grass
09/06/2002 High       Ragweed, Grass
09/07/2002 High       Ragweed, Grass


/* Example 4.11, Program */
filename filelist pipe 
        'dir c:\readdata\pollen*.dat/b';
data pollen;
  length pollenfilename $ 60 location $ 6;
  format pollendate mmddyy10.;
  drop startloc endloc;
  infile filelist 
         truncover;
  input pollenfilename $60.;
  startloc=index(upcase(pollenfilename),'POLLEN')+6;
  endloc=index(upcase(pollenfilename),'.DAT');
  location=substr(pollenfilename,startloc,endloc-startloc);
  pollenfilename='c:\books\readdata\' ||        
                  trim(pollenfilename);
  infile dummy 
         filevar=pollenfilename 
         truncover 
         end=lastrec;
  do until (lastrec);
    input @1  pollendate mmddyy10.
          @12 level $10.
          @23 sourcetext $30.;
    output;
  end;
run;
proc print data=pollen;
  title "Pollen Count by Location and Date";
run;


/* Example 4.12, External File */
        Results for Study Group A
   
  A      101      120       65      19.9654
  A      102      183       70      26.2530
  A      105      189       68      28.7322
  A      108      178       74      22.8497
  A      110      176       70      25.2488
  A      111      132       67      20.6704
        Results for Study Group B
 
  B      103      155                       
  B      104      101       62      18.4698
  B      106      193       68      29.3403
  B      107      210       72      28.4760
  B      109      168       66      27.1110
  B      112      125       63      22.1388 
            

/* Example 4.12, Program */
data bmi;
  infile 'c:\readdata\example4_12.dat'
         print
         truncover;
  length group $ 1;
  input group $ @;
  if group not in ('A' 'B') then delete;
  input id weight height bmi;
run;       
proc print data=bmi;
  title 'Body Mass Index as Read from Report';
run; 

/* Example 4.13 Create External File with SAS */
data _null_;
  infile datalines;
  input @1 dept $10. deptid 5. +1
       (budget cost1-cost3 totcost) (: 8.);

  /* Specify the name and features of the file */
  /* according to your system requirements.    */
  file 'myid.deptcost.dat';
  put @1 dept $10.
      @11 deptid zd5.
      @16 budget ib4.2
      @20 (cost1-cost3) (pd4.2)
      @32 totcost pd4.2;

datalines;
Accounting 30400 1500.00  558.21 377.98   291.03  1228.22
Shipping   31401 1500.00  535.94 438.29   301.84  1276.07
Marketing  32101 10000.00 539.82 7938.08  1293.35 9771.25
IT         32200 10000.00 3985.80 3302.11 3398.21 10686.12
Security   31402 5000.00  4039.09 1398.01 539.38  5976.48
;;;;


/* Example 4.13, External File */
----+----1----+----2----+----3----+----4----+----5
Accounting0304{   0  b   `       b
C889A9A898FFFFC004F0581037802130282
1336453957030400290052C079C090C122C
Shipping  0314{   0   <  b    <  -@
E889989844FFFFC004F0554048903140267
2897795700031400290039C032C008C170C
Marketing 0321{      q  l     *   *
D8998A8984FFFFC00440592098802350715
4192539570032100F20038C730C193C972C
IT        0322{     q        b   /
CE44444444FFFFC00440950032103811662
9300000000032200F20388C301C392C081C
Security  0314{  ~           l  p
E88A98AA44FFFFC00A20099038105980968
2534993800031400710430C190C033C574C


/* Example 4.13, Program */
data deptcost;
  infile 'myid.deptcost.dat';
  input @1 dept $10.
        @11 deptid zd5.
        @16 budget ib4.2
        @20 (cost1-cost3) (pd4.2)
        @32 totcost pd4.2;
  format budget cost1-cost3 totcost dollar10.2;
run;
proc print data=deptcost;
  title 'Budget and Costs';
run;


/* Example 4.14, External File */
10938765MN04045046015012      0065000
93817820MN01028               0056000
93781842MN01056               0225000
39817302MN02064060            0121000
91872058MN03030030005         0052000
81743293MN02035032            0048500
93278182MN060400390150110090090095000
32982378MN02051050            0042000
83278233MN02055041            0135000
93879278MN01023               0050000
32872383MN02087086            0043000
38237853MN03078075043         0350000


/* Example 4.14, Program */
$ ALLOCATE tapedevice
$ MOUNT tapedevice census
$ DEFINE indata tapedevice:census.dat
$ SAS
data census;
  infile indata;
  input householdid 1-8 state $ 9-10 nmembers 11-12
        (age1-age6) (3.) income 31-37;
  format income dollar12.2;
run;
proc print data=census;
  title 'Census Data';
run;
endsas;
$ DISMOUNT tapedevice
$ DEALLOCATE tapedevice


/* Example 4.15, External File */
10938765MN04045046015012      0065000
93817820MN01028               0056000
93781842MN01056               0225000
39817302MN02064060            0121000
91872058MN03030030005         0052000
81743293MN02035032            0048500
93278182MN060400390150110090090095000
32982378MN02051050            0042000
83278233MN02055041            0135000
93879278MN01023               0050000
32872383MN02087086            0043000
38237853MN03078075043         0350000


/* Example 4.15, Program */
data census;
  infile indata;
  input householdid 1-8 state $ 9-10 nmembers 11-12
        (age1-age6) (3.) income 31-37;
  format income dollar12.2;
run;
proc print data=census;
  title 'Census Data';
run;


/* Example 4.16, External File */
10938765MN04045046015012      0065000
93817820MN01028               0056000
93781842MN01056               0225000
39817302MN02064060            0121000
91872058MN03030030005         0052000
81743293MN02035032            0048500
93278182MN060400390150110090090095000
32982378MN02051050            0042000
83278233MN02055041            0135000
93879278MN01023               0050000
32872383MN02087086            0043000
38237853MN03078075043         0350000


/* Example 4.16, Program */
options tapeclose=leave;
x 'mt -t /dev/rmt/0mn rewind';
x 'mt -t /dev/rmt/0mn fsf 1';
filename indata pipe 'dd if=/dev/rmt/0mn 2> /dev/null';
data census;
  infile indata;
  input householdid 1-8 state $ 9-10 nmembers 11-12
        (age1-age6) (3.) income 31-37;
  format income dollar12.2;
run;
proc print data=census;
  title 'Census Data';
run;


/* Example 5.1, External File */
Neda,0,4,0,3,0,11
Amy,8,3,9,2,4,6
Janet,3,0,12,0,2,1
Pauline,0,1,3,0,4,2
Jo Ann,0,1,0,1,0,1

/* Example 5.2, External File */
A03885 HR 1039.65 543.87 109.83 257.45
A03918 Acctg 3029.98 837.00 . 362.91
A05291 . . . . .
A06573 IT 5603.81 2091.23 393.39 103.95



/* Example 6.1, External File */
2393834873Keen, Kerry             Genetics       2003
2836183495Lindsay, Nancy          Microbiology   2004
2838378510Lee, Lois               Genetics       2004
2903895839Carlson, Gina	          Cell Biology   2005
2918387281Rhodes, Richard         Cell Biology   2004
2938281731Woski, Donna            Genetics       2004
3293832921Anderson, Robert        Microbiology   2005
3728437267Roscoe, Marie Louise    Genetics       2005
3927823853Bates, Joey             Cell Biology   2005
3982748372Gomez Jr., Ed           Microbiology   2006

/* Example 6.1, Program */
filename myfile ftp 
         'example6_1' 
         user='myid' 
         prompt
         host='biology.univ.edu'
         cd='/students/biology/advisors';

data students;
  infile myfile;
  input studentid 1-10 studentname $ 11-34 major $ 35-49
        gradyear 50-53;
run;
proc print data=students;
  title 'Student List';
run;

/* Example 6.2, External Files */
LewisCA1
LewisCA3
LewisCA4
LewisCA10
OlsenGG2
OlsenGG5
RogersTO6
SmithRA7
YoungCM8
YoungCM9
YoungCM11

3453283471Morris, Susan       88
3727823711Chang, David        77
3821872813Press, Jill         94
3827375938Monroe, Norris      98
3827376218Thorson, Robert     85
3827821739Simon, Lena         81
3831873285Leslie, David       89
3938282818Banks, Mindy       100

3273619371Andrews, Susan      82
3384572671Boston, Betsy      100
3388173948Newly, Neil         90
3457328372Ramirez, Eduardo   100
3727661183Gardner, Sharon     95
3817375923Fields, Elaine      81
3827372192Van Pelt, Rosa      89
3827395928Dixon, Matt         96
3837279187Smith, Chuck        79
3958382938Boxer, Gail         85


/* Example 6.2, Program */
filename instructor ftp 
         'OlsenGG*' 
         mget 
         user='myid'
         prompt
         host='biology.univ.edu'
         cd='/students/biology/general';

data students;
   length hostexfile $ 50;
   infile instructor 
          filename=hostexfile
          eov=firstrec;
   retain section;
   drop num;
   input studentid 1-10 studentname $ 11-29 grade 30-32;

   if _n_=1 or firstrec then do;
     num=indexc(hostexfile,'0123456789');
     section=input(substr(hostexfile,num),best3.);

     firstrec=0;
   end;
run;
proc print data=students;
  title 'Olsen''s Students';
run; 


/* Example 6.3, External File */
/* Example 6.3, Program */
filename local socket 
        ':9999' 
        server 
        reconn=3;
   
data computers;
   infile local 
          eov=newconnect;
   input type $15. +1 id $10. +1 purchasedate mmddyy10.;
   if newconnect then put 'new connection received';  
run;



/* Example 6.4, PROC FORMAT steps */
proc format;                                                                 
  value $inits 'MMD'='Margaret M. Dean         '                             
               'AEK'='Andrea Elizabeth King    '                             
               'JAR'='John A. Ross             '                             
               'SST'='Susan S. Thompson        ';                            
run;

proc format;                                                                                        
  value $inits 'MMD'='Margaret M. Dean         '                                                    
               'AEY'='Andrea Elizabeth Young   '                                                    
               'JAR'='John A. Ross             '                                                    
               'SST'='Susan S. Thompson        ';                                                   
run;

/* Example 6.4, Program */
filename oldprog catalog
        'mycompany.programs.myformats.source';

filename newprog catalog 
        'mycompany.programs.newformats.source';  

data _null_;
  infile oldprog 
         truncover;
  input programline $char100.;

  findaek=index(programline,'AEK');
  if findaek > 0 then do;
    substr(programline,findaek,3)='AEY';
    findln=index(programline,'King');
    if findln > 0 then 
      substr(programline,findln,5)='Young';
  end;

  file newprog;
  put @1 programline $char100.;
run;


/* Example 6.5, External File */
/* Example 6.5, Program */

/* Example 6.6, External File */
Orders Placed through Web Site in 2002
(number of orders, total sales)

  Jan 2002    402   $83,928
  Feb 2002    478  $193,283
  Mar 2002    350   $76,720
  Apr 2002    325   $65,391
  May 2002    366   $89,123
  Jun 2002    390   $81,538
  Jul 2002    303   $43,193
  Aug 2002    277   $38,651
  Sep 2002    463  $198,712
  Oct 2002    573  $236,423
  Nov 2002    629  $263,888
  Dec 2002    435  $173,028   

/* Example 6.6, Program */
filename webpage url
'http://intranet.abcco.com/websales/sales2002.dat';

data websales;
  infile webpage 
         firstobs=4;

  input monsales $ yearsales norders 
        salesamt : comma8.;
run;
proc print data=websales;
  title 'Web Site Sales in 2002 Read from Webpage';
  format salesamt dollar8.;
run;


/* Example 6.7, Existing XML Document */
<?xml version="1.0" ?>
<TABLE>
   <Client1>
      <COMPANY> ABC Inc. </COMPANY>
      <PRICE1998> 38.90 </PRICE1998>
      <PRICE1999> 43.50 </PRICE1999>
      <PRICE2000> 22.20 </PRICE2000>
   </CLIENT1>
   <CLIENT1>
      <COMPANY> Mighty Movers </COMPANY>
      <PRICE1998> 16.20 </PRICE1998>
      <PRICE1999> 22.50 </PRICE1999>
      <PRICE2000> 26.80 </PRICE2000>
      <PRICE2001> 20.10 </PRICE2001>
      <PRICE2002> 21.20 </PRICE2002>
      <PRICE2003> 24.60 </PRICE2003>
   </CLIENT1>
   <CLIENT1>
      <COMPANY> Wireless Wonders </COMPANY>
      <PRICE2001> 5.70 </PRICE2001>
      <PRICE2002> 25.00 </PRICE2002>
      <PRICE2003> 45.60 </PRICE2003>
   </CLIENT1>
   <CLIENT1>
      <COMPANY> Metro Office Supplies </COMPANY>
      <PRICE1998> 63.30 </PRICE1998>
      <PRICE1999> 68.40 </PRICE1999>
      <PRICE2000> 74.10 </PRICE2000>
      <PRICE2001> 55.00 </PRICE2001>
      <PRICE2002> 41.70 </PRICE2002>
   </CLIENT1>
   <Client2>
      <COMPANY> Great Lakes Vegetables </COMPANY>
      <PRICE1999> 21.70 </PRICE1999>
      <PRICE2000> 17.80 </PRICE2000>
      <PRICE2001> 16.00 </PRICE2001>
      <PRICE2002> 25.40 </PRICE2002>
      <PRICE2003> 22.20 </PRICE2003>
   </CLIENT2>
   <CLIENT 2>
      <COMPANY> All Health Inc. </COMPANY>
      <PRICE2003> 16.20 </PRICE 2003>
   </CLIENT 2>
   </TABLE>


/* Example 6.7, Program */
libname mystocks xml 
       'c:\readdata\stockprices.xml';                                                                               

data twoclients;  
  set mystocks.client1(in=in1)                                                                                                          
      mystocks.client2(in=in2);                                                                                                         
  if in1 then client=1;                                                                                                                 
  else if in2 then client=2;                                                                                                            
  yrsheld=n(of price1998-price2003);                                                                                                    
run;                                                                                                                                    
proc print data=twoclients;                                                                                                                
  title "Stocks Held by Two Clients 1998-2003";                                                                                         
run;



