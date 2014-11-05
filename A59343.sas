

/*------------------------------------------------------------------- */
 /*                 SAS Functions by Example                          */
 /*                      by Ron Cody                                  */
 /*       Copyright(c) 2004 by SAS Institute Inc., Cary, NC, USA      */
 /*                   SAS Publications order # 59343                  */
 /*                        ISBN 1-59047-378-7                         */
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
 /* Attn: Ron Cody                                                    */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  sasbbu@sas.com             */
 /* Use this for subject field:                                       */
 /*     Comments for Ron Cody                                         */
 /*                                                                   */
 /*-------------------------------------------------------------------*/





***Programs used in "Functions by Example." ;
Program 1.1: How SAS determines storage lengths of character variables
DATA EXAMPLE1;
   INPUT GROUP $ 
     @10 STRING $3.;
   LEFT  = 'X    '; *X AND 4 BLANKS;
   RIGHT = '    X'; *4 BLANKS AND X;
   SUB = SUBSTR(GROUP,1,2);
   REP = REPEAT(GROUP,1);
DATALINES;
ABCDEFGH 123
XXX        4
Y        5
;

Program 1.2: Running PROC CONTENTS to determine storage lengths
PROC CONTENTS DATA=EXAMPLE1 VARNUM;
   TITLE "PROC CONTENTS for Data Set EXAMPLE1";
RUN;

Program 1.3:  Changing lowercase to uppercase for all character variables 
                       in a data set
***Primary function: UPCASE
***Other function: DIM;

DATA MIXED;
   LENGTH A B C D E $ 1;
   INPUT A B C D E X Y;
DATALINES;
M f P p D 1 2
m f m F M 3 4
;
DATA UPPER;
   SET MIXED;
   ARRAY ALL_C[*] _CHARACTER_;
   DO I = 1 TO DIM(ALL_C);
      ALL_C[I] = UPCASE(ALL_C[I]);
   END;
   DROP I;
RUN;

PROC PRINT DATA=UPPER NOOBS;
   TITLE 'Listing of Data Set UPPER';
RUN;

Program 1.4:  Program to capitalize the first letter of the first and last 
                       name (using SUBSTR)
***Primary functions: LOWCASE, UPCASE
***Other function: SUBSTR (used on the left and right side of the equal sign);

DATA CAPITALIZE;
   INFORMAT FIRST LAST $30.;
   INPUT FIRST LAST;
   FIRST = LOWCASE(FIRST);
   LAST = LOWCASE(LAST);
   SUBSTR(FIRST,1,1) = UPCASE(SUBSTR(FIRST,1,1));
   SUBSTR(LAST,1,1) = UPCASE(SUBSTR(LAST,1,1));
DATALINES;
ronald cODy
THomaS eDISON
albert einstein
;
PROC PRINT DATA=CAPITALIZE NOOBS;
   TITLE "Listing of Data Set CAPITALIZE";
RUN;

Program 1.5:  Capitalizing the first letter of each word in a string
***Primary function: PROPCASE;

DATA PROPER;
   INPUT NAME $60.;
   NAME = PROPCASE(NAME);
DATALINES;
ronald cODy
THomaS eDISON
albert einstein
;
PROC PRINT DATA=PROPER NOOBS;
   TITLE "Listing of Data Set PROPER";
RUN;

Program 1.6:  Alternative program to capitalize the first letter of each
                       word in a string
***First and last name are two separate variables.

DATA PROPER;
   INFORMAT FIRST LAST $30.;
   INPUT FIRST LAST;
   LENGTH NAME $ 60;
   CALL CATX(' ', NAME, FIRST, LAST);
   NAME = PROPCASE(NAME);
DATALINES;
ronald cODy
THomaS eDISON
albert einstein
;
PROC PRINT DATA=PROPER NOOBS;
   TITLE "Listing of Data Set PROPER";
RUN;

Program 1.7:  Using the COMPBL function to convert multiple blanks to a 
                       single blank
***Primary function: COMPBL;

DATA SQUEEZE;
   INPUT #1 @1  NAME    $20.
         #2 @1  ADDRESS $30.
         #3 @1  CITY    $15.
            @20 STATE    $2.
            @25 ZIP      $5.;
   NAME = COMPBL(NAME);
   ADDRESS = COMPBL(ADDRESS);
   CITY = COMPBL(CITY);
DATALINES;
RON CODY
89 LAZY BROOK ROAD
FLEMINGTON         NJ   08822
BILL     BROWN
28   CATHY   STREET
NORTH   CITY       NY   11518
;
PROC PRINT DATA=SQUEEZE;
   TITLE 'Listing of Data Set SQUEEZE';
   ID NAME;
   VAR ADDRESS CITY STATE ZIP;
RUN;

Program 1.8:  Removing dashes and parentheses from phone numbers
***Primary function: COMPRESS;

DATA PHONE_NUMBER;
   INPUT PHONE $ 1-15;  
   PHONE1 = COMPRESS(PHONE);
   PHONE2 = COMPRESS(PHONE,'(-) ');
DATALINES;
(908)235-4490
(201) 555-77 99
;
PROC PRINT DATA=PHONE_NUMBER;
   TITLE 'Listing of Data Set PHONE_NUMBER';
RUN;

Program 1.9:  Converting social security numbers from character to 
                       numeric
***Primary function: COMPRESS
***Other function:  INPUT;

DATA SOCIAL;
   INPUT @1 SS_CHAR $11.
         @1 MIKE_ZDEB COMMA11.;
   SS_NUMERIC = INPUT(COMPRESS(SS_CHAR,'-'),9.);
   SS_FORMATTED = SS_NUMERIC;
   FORMAT SS_FORMATTED SSN.;
DATALINES;
123-45-6789
001-11-1111
;
PROC PRINT DATA=SOCIAL NOOBS;
   TITLE "Listing of Data Set SOCIAL";
RUN;

Program 1.10: Counting the number of numerals in a string
***Primary functions: COMPRESS, LENGTHN;

DATA COUNT;
   INPUT STRING $20.;
   ONLY_LETTERS = COMPRESS(STRING,'0123456789');
   NUM_NUMERALS = LENGTHN(STRING) - LENGTHN(ONLY_LETTERS);
DATALINES;
ABC123XYZ
XXXXX
12345
1234X
;
PROC PRINT DATA=COUNT NOOBS;
   TITLE "Listing of Data Set COUNT";
RUN;

Program 1.11:  Demonstrating the "ANY" character functions 
***Primary functions: ANYALNUM, ANYALPHA, ANYDIGIT, ANYPUNCT, and ANYSPACE;

DATA ANYWHERE;
   INPUT STRING $CHAR20.;
   ALPHA_NUM   = ANYALNUM(STRING);
   ALPHA_NUM_9 = ANYALNUM(STRING,-999);
   ALPHA       = ANYALPHA(STRING);
   ALPHA_5     = ANYALPHA(STRING,-5);
   DIGIT       = ANYDIGIT(STRING);
   DIGIT_9     = ANYDIGIT(STRING,-999);
   PUNCT       = ANYPUNCT(STRING);
   SPACE       = ANYSPACE(STRING);
DATALINES;
Once upon a time 123 
HELP!
987654321
;
PROC PRINT DATA=ANYWHERE NOOBS HEADING=H;
   TITLE "Listing of Data Set ANYWHERE";
RUN;

Program 1.12:  Using the functions ANYDIGIT and ANYSPACE to find the 
                         first number in a string
***Primary functions: ANYDIGIT and ANYSPACE
***Other functions: INPUT and SUBSTR;

DATA SEARCH_NUM;
   INPUT STRING $60.;
   START = ANYDIGIT(STRING);
   END = ANYSPACE(STRING,START);
   IF START NE 0 THEN
      NUM = INPUT(SUBSTR(STRING,START,END-START),9.);
DATALINES;
This line has a 56 in it
two numbers 123 and 456 in this line
No digits here
;
PROC PRINT DATA=SEARCH_NUM NOOBS;
   TITLE "Listing of Data Set SEARCH_NUM";
RUN;

Program 1.13:  Demonstrating the "NOT" character functions
***Primary functions: NOTALNUM, NOTALPHA, NOTDIGIT, AND NOTUPPER;

DATA NEGATIVE;
   INPUT STRING $5.;
   NOT_ALPHA_NUMERIC = NOTALNUM(STRING);
   NOT_ALPHA         = NOTALPHA(STRING);
   NOT_DIGIT         = NOTDIGIT(STRING);
   NOT_UPPER         = NOTUPPER(STRING);
DATALINES;
ABCDE
abcde
abcDE
12345
:#$%&
ABC
;
PROC PRINT DATA=NEGATIVE NOOBS;
   TITLE "Listing of Data Set NEGATIVE";
RUN;

Program 1.14: Using the FIND and FINDC functions to search for strings 
                        and characters
***Primary functions: FIND and FINDC;

DATA FIND_VOWEL;
   INPUT @1 STRING $20.;
   PEAR = FIND(STRING,"Pear");
   POS_VOWEL = FINDC(STRING,"aeiou",'I');
   UPPER_VOWEL = FINDC(STRING,"aeiou");
   NOT_VOWEL = FINDC(STRING,"AEIOU",'IV');
DATALINES;      
XYZABCabc
XYZ
Apple and Pear
;
PROC PRINT DATA=FIND_VOWEL NOOBS;
   TITLE "Listing of Data Set FIND_VOWEL";
RUN;

Program 1.15: Demonstrating the o modifier with FINDC
***Primary function: FINDC;

DATA O_MODIFIER;
   INPUT STRING      $15. 
         @16 LOOK_FOR $1.;
   POSITION = FINDC(STRING,LOOK_FOR,'IO');
DATALINES;
Capital A here A
Lower a here   X
Apple          B
;
PROC PRINT DATA=O_MODIFIER NOOBS HEADING=H;
   TITLE "Listing of Data Set O_MODIFIER";
RUN;

Program 1.16:  Converting numeric values of mixed units (e.g., kg and lbs) 
                         to a single numeric quantity
***Primary functions: COMPRESS, INDEX, INPUT
***Other function: ROUND;

DATA HEAVY;
   INPUT CHAR_WT $ @@;
   WEIGHT = INPUT(COMPRESS(CHAR_WT,'KG'),8.);
   IF INDEX(CHAR_WT,'K') NE 0 THEN WEIGHT = 2.22 * WEIGHT;
   WEIGHT = ROUND(WEIGHT);
   DROP CHAR_WT;
DATALINES;
60KG 155 82KG 54KG 98
;
PROC PRINT DATA=HEAVY NOOBS;
   TITLE "Listing of Data Set HEAVY";
   VAR WEIGHT;
RUN;

Program 1.17:  Searching for one of several characters in a character 
                         variable
***Primary function: INDEXC;

DATA CHECK;
   INPUT TAG_NUMBER $ @@;
   ***If the tag number contains an X, Y, or Z, it indicates
      an international destination, otherwise, the destination
      is domestic;
   IF INDEXC(TAG_NUMBER,'X','Y','Z') GT 0 THEN 
      DESTINATION = 'INTERNATIONAL';
   ELSE DESTINATION = 'DOMESTIC';
DATALINES;
T123 TY333 1357Z UZYX 888 ABC
;
PROC PRINT DATA=CHECK NOOBS;
   TITLE "Listing of Data Set CHECK";
   ID TAG_NUMBER;
   VAR DESTINATION;
RUN;

Program 1.18: Reading dates in a mixture of formats 
***Primary function: INDEXC
***Other function: INPUT;

***Note: Version 9 has some enhanced date reading ability;

***Program to read mixed dates;
DATA MIXED_DATES;
   INPUT @1 DUMMY $15.;
   IF INDEXC(DUMMY,'/-:') NE 0 THEN DATE = INPUT(DUMMY,MMDDYY10.);
   ELSE DATE = INPUT(DUMMY,DATE9.);
   FORMAT DATE WORDDATE.;
   DROP DUMMY;
DATALINES;
10/21/1946
06JUN2002
5-10-1950
7:9:57
;
PROC PRINT DATA=MIXED_DATES NOOBS;
   TITLE "Listing of Data Set MIXED_DATES";
   VAR DATE;
RUN;

Program 1.19: Searching for a word using the INDEXW function
***Primary functions: INDEX and INDEXW;

DATA FIND_WORD;
   INPUT STRING $40.;
   POSITION_W = INDEXW(STRING,"the");
   POSITION   = INDEX(STRING,"the");
DATALINES;
there is a the in this line
ends in the
ends in the.
none here
;
PROC PRINT DATA=FIND_WORD;
   TITLE "Listing of Data Set FIND_WORD";
RUN;

Program 1.20:  Using the VERIFY function to check for invalid character 
                         data values
***Primary function: VERIFY;

DATA VERY_FI;
   INPUT ID     $ 1-3
         ANSWER $ 5-9;
   P = VERIFY(ANSWER,'ABCDE');
   OK = P EQ 0;
DATALINES;
001 ACBED
002 ABXDE
003 12CCE
004 ABC E
;
PROC PRINT DATA=VERY_FI NOOBS;
   TITLE "listing of Data Set VERY_FI";
RUN;

Program 1.21:  Extracting portions of a character value and creating a 
                         character variable and a numeric value
***Primary function: SUBSTR
***Other function: INPUT;

DATA SUBSTRING;
   INPUT ID $ 1-9;
   LENGTH STATE $ 2;
   STATE = SUBSTR(ID,1,2);
   NUM = INPUT(SUBSTR(ID,7,3),3.);
DATALINES;
NYXXXX123
NJ1234567
;
PROC PRINT DATA=SUBSTRING NOOBS;
   TITLE 'Listing of Data Set SUBSTRING';
RUN;

Program 1.22:  Extracting the last two characters from a string, regardless 
                         of the length
***Primary functions: LENGTH, SUBSTR;

DATA EXTRACT;
   INPUT @1 STRING $20.;
        LAST_TWO = SUBSTR(STRING,LENGTH(STRING)-1,2);
DATALINES;
ABCDE
AX12345NY
126789
;
PROC PRINT DATA=EXTRACT NOOBS;
   TITLE "Listing of Data Set EXTRACT";
        VAR STRING LAST_TWO;
RUN;

Program 1.23: Using the SUBSTR function to "unpack" a string
***Primary function: SUBSTR
***Other functions: INPUT;

DATA PACK;
   INPUT STRING $ 1-5;
DATALINES;
12345
8 642
;
DATA UNPACK;
   SET PACK;
   ARRAY X[5];
   DO J = 1 TO 5;
      X[J] = INPUT(SUBSTR(STRING,J,1),1.);
   END;
   DROP J;
RUN;
PROC PRINT DATA=UNPACK NOOBS;
   TITLE "Listing of Data Set UNPACK";
RUN;

Program 1.24:  Demonstrating the SUBSTR function on the left-hand side 
                         of the equal sign
***Primary function: SUBSTR
***Other function: PUT;

DATA STARS;
   INPUT SBP DBP @@;
   LENGTH SBP_CHK DBP_CHK $ 4;
   SBP_CHK = PUT(SBP,3.);
   DBP_CHK = PUT(DBP,3.);
   IF SBP GT 160 THEN SUBSTR(SBP_CHK,4,1) = '*';
   IF DBP GT 90 THEN SUBSTR(DBP_CHK,4,1) = '*';
DATALINES;
120 80 180 92 200 110
;
PROC PRINT DATA=STARS NOOBS;
   TITLE "Listing of Data Set STARS";
RUN;

Program 1.25: Demonstrating the unique features of the SUBSTRN 
                        function
***Primary function: SUBSTRN;

DATA HOAGIE;
   STRING = 'ABCDEFGHIJ';
   LENGTH RESULT $5.;
   RESULT = SUBSTRN(STRING,2,5);
   SUB1 = SUBSTRN(STRING,-1,4);
   SUB2 = SUBSTRN(STRING,3,0);
   SUB3 = SUBSTRN(STRING,7,5);
   SUB4 = SUBSTRN(STRING,0,2);
   FILE PRINT;
   TITLE "Demonstrating the SUBSTRN Function";
   PUT "Original String ="      @25 STRING  /
       "SUBSTRN(STRING,2,5) ="  @25 RESULT  /
       "SUBSTRN(STRING,-1,4) =" @25 SUB1    /
       "SUBSTRN(STRING,3,0) ="  @25 SUB2    /
       "SUBSTRN(STRING,7,5) ="  @25 SUB3    /
       "SUBSTRN(STRING,0,2) ="  @25 SUB4;
RUN;

Program 1.26: Demonstrating the three concatenation call routines
***Primary functions: CALL CATS, CALL CATT, CALL CATX;

DATA CALL_CAT;
   STRING1 = "ABC";       * No spaces;
   STRING2 = "DEF   ";    * Three trailing spaces;
   STRING3 = "   GHI";    * Three leading spaces;
   STRING4 = "   JKL   "; * Three leading and trailing spaces;
   LENGTH RESULT1 - RESULT4 $ 20;
   CALL CATS(RESULT1, STRING2, STRING4);
   CALL CATT(RESULT2, STRING2, STRING1);
   CALL CATX(" ", RESULT3 ,STRING1,STRING3);
   CALL CATX(",", RESULT4,STRING3,STRING4);
RUN;
PROC PRINT DATA=CALL_CAT NOOBS;
   TITLE "Listing of Data Set CALL_CAT";
RUN;

Program 1.27: Demonstrating the four concatenation functions
***Primary functions: CAT, CATS, CATT, CATX;

DATA CAT_FUNCTIONS;
   STRING1 = "ABC";       * No spaces;
   STRING2 = "DEF   ";    * Three trailing spaces;
   STRING3 = "   GHI";    * Three leading spaces;
   STRING4 = "   JKL   "; * Three leading and trailing spaces;
   LENGTH JOIN1 - JOIN5 $ 20;
   JOIN1 = CAT(STRING2, STRING3);
   JOIN2 = CATS(STRING2, STRING4);
   JOIN3 = CATT(STRING2, STRING1);
   JOIN4 = CATX(" ",STRING1,STRING3);
   JOIN5 = CATX(",",STRING3,STRING4);
RUN;
PROC PRINT DATA=CAT_FUNCTIONS NOOBS;
   TITLE "Listing of Data Set CAT_FUNCTIONS";
RUN;

Program 1.28:  Left-aligning text values from variables read with the 
                         $CHAR informat
***Primary function: LEFT;

DATA LEAD_ON;
   INPUT STRING $CHAR15.;
   LEFT_STRING = LEFT(STRING);
DATALINES;
ABC
   XYZ
  Ron Cody
;
PROC PRINT DATA=LEAD_ON NOOBS;
   TITLE "Listing of Data Set LEAD_ON";
   FORMAT STRING LEFT_STRING $QUOTE17.;
RUN;

Program 1.29: Right-aligning text values
***Primary function: RIGHT;

DATA RIGHT_ON;
   INPUT STRING $CHAR10.;
   RIGHT_STRING = RIGHT(STRING);
DATALINES;
   ABC
   123 456
Ron Cody
;
PROC PRINT DATA=RIGHT_ON NOOBS;
   TITLE "Listing of Data Set RIGHT_ON";
   FORMAT STRING RIGNT_STRING $QUOTE12.;
RUN;

Program 1.30:  Creating a program to concatenate first, middle, and last 
                         names into a single variable
***Primary function: TRIM;

DATA PUT_TOGETHER;
   LENGTH NAME $ 45;
   INFORMAT NAME1-NAME3 $15.;
   INFILE DATALINES MISSOVER;
   INPUT NAME1 NAME2 NAME3;
   NAME = TRIM(NAME1) || ' ' || TRIM(NAME2) || ' ' || TRIM(NAME3);
   WITHOUT = NAME1 || NAME2 || NAME3;
   KEEP NAME WITHOUT;
DATALINES;
Ronald Cody
Julia     Child
Henry    Ford
Lee Harvey Oswald
;
PROC PRINT DATA=PUT_TOGETHER NOOBS;
   TITLE "Listing Of Data Set PUT_TOGETHER";
RUN;

Program 1.31:  Demonstrating the difference between the TRIM and TRIMN 
                         functions
***Primary functions: TRIM, TRIMN, and LENGTHC
***Other function: COMPRESS;

DATA ALL_THE_TRIMMINGS;
   A = "AAA";
   B = "BBB";
   LENGTH_AB = LENGTHC(A || B);
   LENGTH_AB_TRIM = LENGTHC(TRIM(A) || TRIM(B));
   LENGTH_AB_TRIMN = LENGTHC(TRIMN(A) || TRIMN(B));
   LENGTH_NULL = LENGTHC(COMPRESS(A,"A") || COMPRESS(B, "B"));
   LENGTH_NULL_TRIM = LENGTHC(TRIM(COMPRESS(A,"A")) || 
                      TRIM(COMPRESS(B,"B")));
   LENGTH_NULL_TRIMN = LENGTHC(TRIMN(COMPRESS(A,"A")) || 
                       TRIMN(COMPRESS(B,"B")));
   PUT A= B= /
       LENGTH_AB= LENGTH_AB_TRIM= LENGTH_AB_TRIMN= /
       LENGTH_NULL= LENGTH_NULL_TRIM= LENGTH_NULL_TRIMN=;
RUN;

Program 1.32:  Using the STRIP function to strip both leading and trailing 
                         blanks from a string
***Primary function: STRIP;

DATA _NULL_;
   ONE = "   ONE   "; ***Note: three leading and trailing blanks;
   TWO = "   TWO   "; ***Note: three leading and trailing blanks;
   CAT_NO_STRIP = ":" || ONE || "-" || TWO || ":";
   CAT_STRIP    = ":" || STRIP(ONE) || "-" || STRIP(TWO) || ":";
   PUT ONE= TWO= / CAT_NO_STRIP= / CAT_STRIP=;
RUN;

Program 1.33: Comparing two strings using the COMPARE function
***Primary function: COMPARE
***Other function: UPCASE;

DATA COMPARE;
   INPUT @1 STRING1 $CHAR3.
         @5 STRING2 $CHAR10.;
   IF UPCASE(STRING1) = UPCASE(STRING2) THEN EQUAL = 'YES';
   ELSE EQUAL = 'NO';
   IF UPCASE(STRING1) =: UPCASE(STRING2) THEN COLON = 'YES';
   ELSE COLON = 'NO';
   COMPARE = COMPARE(STRING1,STRING2);
   COMPARE_IL = COMPARE(STRING1,STRING2,'IL');
   COMPARE_IL_COLON = COMPARE(STRING1,STRING2,'IL:');
DATALINES;
Abc    ABC
abc ABCDEFGH
123 311
;

PROC PRINT DATA=COMPARE NOOBS;
   TITLE "Listing of Data Set COMPARE";
RUN;

Program 1.34: Using the COMPGED function with a SAS n-literal
***Primary function: COMPGED;

OPTIONS VALIDVARNAME=ANY;

DATA N_LITERAL;
   STRING1 = "'INVALID#'N";
   STRING2 = 'INVALID';
   COMP1 = COMPGED(STRING1,STRING2);
   COMP2 = COMPGED(STRING1,STRING2,'N:');
RUN;

PROC PRINT DATA=N_LITERAL NOOBS;
   TITLE "Listing of Data Set N_LITERAL";
RUN;

Program 1.35:  Demonstration of the generalized edit distance (COMPGED) 
                         and Levenshtein  edit distance (COMPLEV) functions
***Primary functions: COMPGED and COMPLEV;

DATA _NULL_;
   INPUT @1  STRING1 $CHAR10.
         @11 STRING2 $CHAR10.;
   PUT "Function COMPGED";
   DISTANCE = COMPGED(STRING1, STRING2);
   IGNORE_CASE = COMPGED(STRING1, STRING2, 'I');
   LEAD_BLANKS = COMPGED(STRING1, STRING2, 'L');
   CASE_TRUNC = COMPGED(STRING1, STRING2, ':I');
   MAX = COMPGED(STRING1, STRING2, 250);
   PUT STRING1= STRING2= /
       DISTANCE= IGNORE_CASE= LEAD_BLANKS= CASE_TRUNC= MAX= /;

   PUT "Function COMPLEV";
   DISTANCE = COMPLEV(STRING1, STRING2);
   IGNORE_CASE = COMPLEV(STRING1, STRING2, 'I');
   LEAD_BLANKS = COMPLEV(STRING1, STRING2, 'L');
   CASE_TRUNC = COMPLEV(STRING1, STRING2, ':I');
   MAX = COMPLEV(STRING1, STRING2, 3);
   PUT STRING1= STRING2= /
       DISTANCE= IGNORE_CASE= LEAD_BLANKS= CASE_TRUNC= MAX= /;
DATALINES;
SAME      SAME
cAsE      case
Longer    Long
abcdef    xyz
   lead   lead
;
 
Program 1.36:  Changing the effect of the call to COMPCOST on the result 
                         from COMPGED
***Primary functions: CALL COMPCOST and COMPGED;

DATA _NULL_;
   TITLE "Program without Call to COMPCOST";
   INPUT @1  STRING1 $CHAR10.
         @11 STRING2 $CHAR10.;
   DISTANCE = COMPGED(STRING1, STRING2);
   PUT STRING1= STRING2= /
       DISTANCE=;
DATALINES;
Ron       Run
ABC       AB
;
DATA _NULL_;
   TITLE "Program with Call to COMPCOST";
   INPUT @1  STRING1 $CHAR10.
         @11 STRING2 $CHAR10.;
   IF _N_ = 1 THEN CALL COMPCOST('APPEND=',33);
   DISTANCE = COMPGED(STRING1, STRING2);
   PUT STRING1= STRING2= /
       DISTANCE=;
DATALINES;
Ron       Run
ABC       AB
;

Program 1.37:  Fuzzy matching on names using the SOUNDEX function
***Primary function: SOUNDEX
***Prepare data sets FILE_1 and FILE_2 to be used in the match;

DATA FILE_1;
   INPUT @1  NAME  $10.
         @11 X       1.;
DATALINES;
Friedman  4
Shields   1
MacArthur 7
ADAMS     9
Jose      5
Lundquist 9
;
DATA FILE_2;
   INPUT @1  NAME  $10.
         @11 Y       1.;
DATALINES;
Freedman  5
Freidman  9
Schields  2
McArthur  7
Adams     3
Jones     6
Londquest 9
;
***PROC SQL is used to create a Cartesian Product, combinations of all
   the names in one data set against all the names in the other;

PROC SQL;
   CREATE TABLE BOTH AS
   SELECT FILE_1.NAME AS NAME1, X, 
          FILE_2.NAME AS NAME2, Y
   FROM FILE_1 ,FILE_2
QUIT;

DATA POSSIBLE;
   SET BOTH;
   SOUND_1 = SOUNDEX(NAME1);
   SOUND_2 = SOUNDEX(NAME2);
   IF SOUND_1 EQ SOUND_2;
RUN;
PROC PRINT DATA=POSSIBLE NOOBS;
   TITLE "Possible Matches between two files";
   VAR NAME1 SOUND_1 NAME2 SOUND_2 X Y;
RUN;

Program 1.38:  Using the SPEDIS function to match social security 
                         numbers that are the same or differ by a small amount
***Primary function: SPEDIS;

DATA FIRST;
   INPUT ID_1 : $2. SS : $11.;
DATALINES;
1A 123-45-6789
2A 111-45-7654
3A 999-99-9999
4A 222-33-4567
;
DATA SECOND;
   INPUT ID_2 : $2. SS : $11.;
DATALINES;
1B 123-45-6789
2B 111-44-7654
3B 899-99-9999
4B 989-99-9999
5B 222-22-5467
;
%LET CUTOFF = 10;
PROC SQL;
   TITLE "Output from SQL when CUTOFF is set to &CUTOFF";
   SELECT ID_1,
          FIRST.SS AS FIRST_SS, 
          ID_2,
          SECOND.SS AS SECOND_SS
   FROM FIRST, SECOND
   WHERE SPEDIS(FIRST.SS, SECOND.SS) LE &CUTOFF;
QUIT;

Program 1.39:  Fuzzy matching on names using the spelling distance 
                         (SPEDIS) function
***Primary function: SPEDIS
***Other function: UPCASE;

***See Program 1-37 for the creation of data set BOTH and the
   explanation of the PROC SQL code.;

DATA POSSIBLE;
   SET BOTH;
   DISTANCE = SPEDIS(UPCASE(NAME1),UPCASE(NAME2));
RUN;

PROC PRINT DATA=POSSIBLE NOOBS;
   WHERE DISTANCE LE 15;
   TITLE "Possible Matches between two files";
   VAR NAME1 NAME2 DISTANCE X Y;
RUN;

Program 1.40:  A novel use of the SCAN function to convert mixed 
                         numbers to decimal values
***Primary function: SCAN
***Other function: INPUT;

DATA PRICES;
   INPUT @1 STOCK $3.
         @5 MIXED $6.;
   INTEGER = SCAN(MIXED,1,'/ ');
   NUMERATOR = SCAN(MIXED,2,'/ ');
   DENOMINATOR = SCAN(MIXED,3,'/ ');
   IF NUMERATOR = ' ' THEN VALUE = INPUT(INTEGER,8.);
   ELSE VALUE = INPUT(INTEGER,8.) + 
                (INPUT(NUMERATOR,8.) / INPUT(DENOMINATOR,8.));
   KEEP STOCK VALUE;
DATALINES;
ABC 14 3/8
XYZ 8
TWW 5 1/8
;
PROC PRINT DATA=PRICES NOOBS;
   TITLE "Listing of Data Set PRICES";
RUN;

Program 1.41: Program to read a tab-delimited file
***Primary function: SCANQ;

DATA READ_TABS;
   INFILE 'C:\BOOKS\FUNCTIONS\TAB_FILE.TXT' PAD;
   INPUT @1 STRING $30.;
   LENGTH FIRST MIDDLE LAST $ 12;
   FIRST = SCANQ(STRING,1);
   MIDDLE = SCANQ(STRING,2);
   LAST = SCANQ(STRING,3);
   DROP STRING;
RUN;
PROC PRINT DATA=READ_TABS NOOBS;
   TITLE "Listing of Data Set READS_TABS";
RUN;

Program 1.42:  Alphabetical listing by last name when the name field 
                         contains first name, possibly middle initial, and last name
***Primary function: SCAN;

***Making the problem a little harder.  Extracting the last name
   when there may or may not be a middle initial;

DATA FIRST_LAST;
   INPUT @1  NAME  $20.
         @21 PHONE $13.;
   ***Extract the last name from NAME;
   LAST_NAME = SCAN(NAME,-1,' '); /* Scans from the right */
DATALINES;
Jeff W. Snoker      (908)782-4382
Raymond Albert      (732)235-4444
Steven J. Foster    (201)567-9876
Jose Romerez        (516)593-2377
;
PROC REPORT DATA=FIRST_LAST NOWD;
   TITLE "Names and Phone Numbers in Alphabetical Order (by Last Name)";
   COLUMNS NAME PHONE LAST_NAME;
   DEFINE LAST_NAME / ORDER NOPRINT WIDTH=20;
   DEFINE NAME      / DISPLAY 'Name' LEFT WIDTH=20;
   DEFINE PHONE     / DISPLAY 'Phone Number' WIDTH=13 FORMAT=$13.;
RUN;

Program 1.43: Demonstrating the SCAN call routine
***Primary function: CALL SCAN;

DATA WORDS;
   INPUT STRING $40.;
   DELIM = 'Default';
   N = 2;
   CALL SCAN(STRING,N,POSITION,LENGTH);
   OUTPUT;
   N = -1;
   CALL SCAN(STRING,N,POSITION,LENGTH);
   OUTPUT;
   DELIM = '#';
   N = 2;
   CALL SCAN(STRING,N,POSITION,LENGTH,'#');
   OUTPUT;
DATALINES;
ONE TWO THREE
One*#Two Three*Four
;
PROC PRINT DATA=WORDS NOOBS;
   TITLE "Listing of Data Set WORDS";
RUN;

Program 1.44: Using CALL SCANQ to count the words in a string
***Primary function: CALL SCANQ;

DATA COUNT;
   INPUT STRING $40.;
   DO I = 1 TO 99 UNTIL (LENGTH EQ 0);
      CALL SCANQ(STRING,I,POSITION,LENGTH);
   END;
   NUM_WORDS = I-1;
   DROP POSITION LENGTH I;
DATALINES;
ONE TWO THREE
ONE TWO
ONE
;
PROC PRINT DATA=COUNT NOOBS;
   TITLE "Listing of Data Set COUNT";
RUN;

Program 1.45:  Converting values of '1','2','3','4', and '5' to 'A','B','C','D', and 
                         'E' respectively
***Primary function: TRANSLATE;

DATA MULTIPLE;
   INPUT QUES : $1. @@;
   QUES = TRANSLATE(QUES,'ABCDE','12345');
DATALINES;
1 4 3 2 5
5 3 4 2 1
;
PROC PRINT DATA=MULTIPLE NOOBS;
   TITLE "Listing of Data Set MULTIPLE";
RUN;

Program 1.46:  Converting the values "Y" and "N" to 1's and 0's
***Primary functions: TRANSLATE, UPCASE
***Other functions: INPUT;

DATA YES_NO;
   LENGTH CHAR $ 1;
   INPUT CHAR @@;
   X = INPUT(
       TRANSLATE(
       UPCASE(CHAR),'01','NY'),1.);
DATALINES;
N Y n y A B 0 1
;
PROC PRINT DATA=YES_NO NOOBS;
   TITLE "Listing of Data Set YES_NO";
RUN;

Program 1.47:  Converting words such as Street to their abbreviations 
                         such as St. in an address
***Primary function: TRANWRD;

DATA CONVERT;
   INPUT @1 ADDRESS $20. ;
   *** Convert Street, Avenue and Road to their abbreviations;
   ADDRESS = TRANWRD(ADDRESS,'Street','St.');
   ADDRESS = TRANWRD (ADDRESS,'Avenue','Ave.');
   ADDRESS = TRANWRD (ADDRESS,'Road','Rd.');
DATALINES;
89 Lazy Brook Road 
123 River Rd.
12 Main Street
;
PROC PRINT DATA=CONVERT;
   TITLE 'Listing of Data Set CONVERT';
RUN;

Program 1.48:  Demonstrating the LENGTH, LENGTHC, LENGTHM, and 
                         LENGTHN functions
***Primary functions: LENGTH, LENGTHC, LENGTHM, LENGTHN;

DATA LENGTH_FUNC;
   NOTRAIL = "ABC";
   TRAIL   = "DEF   "; * Three trailing blanks;
   NULL    = " ";      * Null string;
   LENGTH_NOTRAIL = LENGTH(NOTRAIL);
   LENGTH_TRAIL   = LENGTH(TRAIL);
   LENGTH_NULL    = LENGTH(NULL);
   LENGTHC_NOTRAIL = LENGTHC(NOTRAIL);
   LENGTHC_TRAIL   = LENGTHC(TRAIL);
   LENGTHC_NULL    = LENGTHC(NULL);
   LENGTHM_NOTRAIL = LENGTHM(NOTRAIL);
   LENGTHM_TRAIL   = LENGTHM(TRAIL);
   LENGTHM_NULL    = LENGTHM(NULL);
   LENGTHN_NOTRAIL = LENGTHN(NOTRAIL);
   LENGTHN_TRAIL   = LENGTHN(TRAIL);
   LENGTHN_NULL    = LENGTHN(NULL);
RUN;

Program 1.49:  Using the COUNT function to count the number of times the 
                         word "the" appears in a string
***Primary Function: COUNT;

DATA DRACULA;
   INPUT STRING $CHAR60.;
   NUM = COUNT(STRING,"the");
   NUM_NO_CASE = COUNT(STRING,"the",'I');
DATALINES;
The number of times "the" appears is the question
THE the
None on this line!
There is the map
;
PROC PRINT DATA=DRACULA NOOB;
   TITLE "Listing of Data Set Dracula";
RUN;

Program 1.50:  Demonstrating the COUNTC function to find one or more 
                         characters or to check if characters are not present in a 
                         string
***Primary Function: COUNTC;

DATA COUNT_CHAR;
   INPUT STRING $20.;
   NUM_A = COUNTC(STRING,'A');
   NUM_Aa = COUNTC(STRING,'a','i');
   NUM_A_OR_B = COUNTC(STRING,'AB');
   NOT_A = COUNTC(STRING,'A','v');
   NOT_A_TRIM = COUNTC(STRING,'A','vt');
   NOT_Aa = COUNTC(STRING,'A','iv');
DATALINES;
UPPER A AND LOWER a
abAB
BBBbbb
;
PROC PRINT DATA=COUNT_CHAR;
   TITLE "Listing of Data Set COUNT_CHAR";
RUN;

Program 1.51:  Determining if there are any missing values for all variables 
                         in a data set
***Primary function: MISSING
***Other function: DIM;

***First, create a data set for testing;
DATA TEST_MISS;
   INPUT @1 (X Y Z)(1.) 
         @4 (A B C D)($1.);
DATALINES;
123ABCD
..7 FFF
987RONC
;
DATA FIND_MISS;
   SET TEST_MISS END=LAST;
   ARRAY NUMS[*] _NUMERIC_;
   ARRAY CHARS[*] _CHARACTER_;
   DO I = 1 TO DIM(NUMS);
      IF MISSING(NUMS[I]) THEN NN + 1;
   END;
   DO I = 1 TO DIM(CHARS);
      IF MISSING(CHARS[I]) THEN NC + 1;
   END;
   FILE PRINT;
   TITLE "Count of Missing Values";
   IF LAST THEN PUT NN "Numeric and " NC "Character values missing";
RUN;   

Program 1.52:  Using the collating sequence to convert plain text to Morse
                         Code
***Primary function: RANK
***Other functions: LENGTH, UPCASE, SUBSTR;

DATA _NULL_;
  ARRAY DOT_DASH[26] $ 4 _TEMPORARY_ ('.-' '-...' '-.-.' '-..' '.' 
                                      '..-.' '-..' '....' '..' '.---' 
                                      '-.-' '.-..' '--' '-.' '---' '.--.'
                                      '--.-' '.-.' '...' '-' '..-'
                                      '...-' '.--' '-..-' '-.--' '--..'); 
   INPUT @1 STRING $80.;
   FILE PRINT;
      TITLE "Morse Code Conversion Using the RANK Function";
   DO I = 1 TO LENGTH(STRING);
      LETTER = UPCASE(SUBSTR(STRING,I,1));
      IF LETTER = ' ' THEN PUT LETTER @;
      ELSE  DO;
         NUM = RANK(LETTER) - 64;
         PUT DOT_DASH[NUM] ' ' @;
      END;
   END;
   PUT;
DATALINES;
This is a test SOS
Now is the time for all good men
;

Program 1.53: Using the REPEAT function to underline output values
***Featured Function: REPEAT;

DATA _NULL_;
   FILE PRINT;
   TITLE "Demonstrating the REPEAT Function";
   LENGTH DASH $ 50;
   INPUT STRING $50.;
   IF _N_ = 1 THEN PUT 50*"*";
   DASH = REPEAT("-",LENGTH(STRING) - 1);
   PUT STRING / DASH;
DATALINES;
Short line
This is a longer line
Bye
;

Program 1.54: Using the REVERSE function to create backwards writing
***Primary function: REVERSE;

DATA BACKWARDS;
   INPUT @1 STRING $CHAR10.;
   GNIRTS = REVERSE(STRING);
DATALINES;
Ron Cody
   XYZ   
ABCDEFG
         x
1234567890
;
PROC PRINT DATA=BACKWARDS NOOBS;
   TITLE "Listing of Data Set BACKWARDS";
RUN;

Program 2.1: Using a Perl regular expression to locate lines with an exact 
                      text match
***Primary functions: PRXPARSE, PRXMATCH; 

DATA _NULL_;
   TITLE "Perl Regular Expression Tutorial - Program 1";

   IF _N_ = 1 THEN PATTERN_NUM = PRXPARSE("/cat/");
   *Exact match for the letters 'cat' anywhere in the string;
   RETAIN PATTERN_NUM;

   INPUT STRING $30.;
   POSITION = PRXMATCH(PATTERN_NUM,STRING);
   FILE PRINT;
   PUT PATTERN_NUM= STRING= POSITION=;
DATALINES;
There is a cat in this line.
Does not match CAT
cat in the beginning
At the end, a cat
cat
;

Program 2.2:  Using a regular expression to search for phone numbers in a 
                       string
***Primary functions: PRXPARSE, PRXMATCH;

DATA PHONE;
   IF _N_ = 1 THEN PATTERN = PRXPARSE("/\(\d\d\d\) ?\d\d\d-\d{4}/");
   ***Regular expression will match any phone number in the form:
      (nnn)nnn-nnnn or (nnn) nnn-nnnn.;
   /*
      \(       matches a left parenthesis
      \d\d\d   matches any three digits
      (blank)? matches zero or one blank
      \d\d\d   matches any three digits
      -        matches a dash
      \d{4}    matches any four digits
   */
   RETAIN PATTERN;

   INPUT STRING $CHAR40.;
   IF PRXMATCH(PATTERN,STRING) GT 0 THEN OUTPUT;
DATALINES;
One number (123)333-4444
Two here:(800)234-2222 and (908) 444-2344
None here
;
PROC PRINT DATA=PHONE NOOBS;
   TITLE "Listing of Data Set Phone";
RUN;

Program 2.3:  Modifying Program 2.2  to search for toll-free phone 
                       numbers
***Primary functions: PRXPARSE, PRXMATCH
***Other function: MISSING;

DATA TOLL_FREE;
   IF _N_ = 1 THEN DO
      RE = PRXPARSE("/\(8(00|77|87)\) ?\d\d\d-\d{4}\b/");
      ***Regular expression looks for phone numbers of the form:
         (nnn)nnn-nnnn or (nnn) nnn-nnnn.  In addition the first
         digit of the area code must be an 8 and the next two
         digits must be either a 00, 77, or 87.;
      IF MISSING(RE) THEN DO;
         PUT "ERROR IN COMPILING REGULAR EXPRESSION";
         STOP;
      END;
   END;
   RETAIN RE;
   INPUT STRING $CHAR80.;
   POSITION = PRXMATCH(RE,STRING);
   IF POSITION GT 0 THEN OUTPUT;
DATALINES;
One number on this line (877)234-8765
No numbers here
One toll free, one not:(908)782-6354 and (800)876-3333 xxx
Two toll free:(800)282-3454 and (887) 858-1234
No toll free here (609)848-9999 and (908) 345-2222
;
PROC PRINT DATA=TOLL_FREE NOOBS;
   TITLE "Listing of Data Set TOLL_FREE";
RUN;

Program 2.4:  Using PRXMATCH without PRXPARSE (entering the regular 
                       expression directly in the function)
***Primary function: PRXMATCH;

DATA MATCH_IT;
   INPUT @1 STRING $20.;
   POSITION = PRXMATCH("/\d\d\d/",STRING);
DATALINES;
LINE 345 IS HERE
NONE HERE
ABC1234567
;
PROC PRINT DATA=MATCH_IT NOOBS;
   TITLE "Listing of Data Set MATCH_IT";
RUN;

Program 2.5:  Locating all 5- or 9-digit zip codes in a list of addresses
***Primary functions: PRXPARSE and CALL PRXSUBSTR
***Other function: SUBSTRN;

DATA ZIPCODE;
   IF _N_ = 1 THEN RE = PRXPARSE("/ \d{5}(-\d{4})?/");
   RETAIN RE;
   /*
      Match a blank followed by 5 digits followed by
      either nothing or a dash and 4 digits

      \d{5}     matches 5 digits
      -         matches a dash
      \d{4}     matches 4 digits
      ?         matches zero or one of the preceding subexpression

   */

   INPUT STRING $80.;
   LENGTH ZIP_CODE $ 10;
   CALL PRXSUBSTR(RE,STRING,START,LENGTH);
   IF START GT 0 THEN DO;
      ZIP_CODE = SUBSTRN(STRING,START + 1,LENGTH - 1);
      OUTPUT;
   END;
   KEEP ZIP_CODE;
DATALINES;
John Smith
12 Broad Street
Flemington, NJ 08822
Philip Judson
Apt #1, Building 7
777 Route 730
Kerrville, TX 78028
Dr. Roger Alan
44 Commonwealth Ave.
Boston, MA 02116-7364
;
PROC PRINT DATA=ZIPCODE NOOBS;
   TITLE "Listing of Data Set ZIPCODE";
RUN;

Program 2.6:  Extracting a phone number from a text string
***Primary functions: PRXPARSE, CALL PRXSUBSTR
***Other functions: SUBSTR, COMPRESS, and MISSING;

DATA EXTRACT;
   IF _N_ = 1 THEN DO;
      PATTERN = PRXPARSE("/\(\d\d\d\) ?\d\d\d-\d{4}/");
      IF MISSING(PATTERN) THEN DO;
         PUT "ERROR IN COMPILING REGULAR EXPRESSION";
         STOP;
      END;
   END;
   RETAIN PATTERN;

   LENGTH NUMBER $ 15;
   INPUT STRING $CHAR80.;
   CALL PRXSUBSTR(PATTERN,STRING,START,LENGTH);
      IF START GT 0 THEN DO;
      NUMBER = SUBSTR(STRING,START,LENGTH);
      NUMBER = COMPRESS(NUMBER," ");
      OUTPUT;
   END;
   KEEP NUMBER;
DATALINES;
THIS LINE DOES NOT HAVE ANY PHONE NUMBERS ON IT
THIS LINE DOES: (123)345-4567 LA DI LA DI LA
ALSO VALID (123) 999-9999
TWO NUMBERS HERE (333)444-5555 AND (800)123-4567
;
PROC PRINT DATA=EXTRACT NOOBS;
   TITLE "Extracted Phone Numbers";
RUN;

Program 2.7:  Using the PRXPOSN function to extract the area code and 
                       exchange from a phone number
***Primary functions: PRXPARSE, PRXMATCH, CALL PRXPOSN
***Other function: SUBSTR;
RUN; 
DATA PIECES;
   IF _N_ THEN RE = PRXPARSE("/\((\d\d\d)\) ?(\d\d\d)-\d{4}/");
   /*
      \(       matches an open parenthesis
      \d\d\d   matches three digits
      \)       matches a closed parenthesis
      b?       matches zero or more blanks (b = blank)
      \d\d\d   matches three digits
      -        matches a dash
      \d{4}    matches four digits
   */
   RETAIN RE;

   INPUT NUMBER $CHAR80.;
   MATCH = PRXMATCH(RE,NUMBER);
   IF MATCH GT 0 THEN DO;
      CALL PRXPOSN(RE,1,AREA_START);
      CALL PRXPOSN(RE,2,EX_START,EX_LENGTH);
      AREA_CODE = SUBSTR(NUMBER,AREA_START,3);
      EXCHANGE = SUBSTR(NUMBER,EX_START,EX_LENGTH);
   END;
   DROP RE;
DATALINES;
THIS LINE DOES NOT HAVE ANY PHONE NUMBERS ON IT
THIS LINE DOES: (123)345-4567 LA DI LA DI LA
ALSO VALID (609) 999-9999
TWO NUMBERS HERE (333)444-5555 AND (800)123-4567
;
PROC PRINT DATA=PIECES NOOBS HEADING=H;
   TITLE "Listing of Data Set PIECES";
RUN;

Program 2.8:  Using regular expressions to read very unstructured data
***Primary functions: PRSPARSE, PRXMATCH, CALL PRXPOSN
***Other functions: SUBSTR, INPUT;

***This program will read every line of data and, for any line
   that contains two or more numbers, will assign the first 
   number to X and the second number to Y;

DATA READ_NUM;
***Read the first number and second numbers on line;
   IF _N_ = 1 THEN RET = PRXPARSE("/(\d+) +\D*(\d+)/");
   /*
      \d+     matches one or more digits
      b+      matches one or more blanks (b = blank)
      \D*     matches zero or more non-digits
      \d+     matches one or more digits
   */
   RETAIN RET;

   INPUT STRING $CHAR40.;
   POS = PRXMATCH(RET,STRING);
   IF POS GT 0 THEN DO;
      CALL PRXPOSN(RET,1,START1,LENGTH1);
      IF START1 GT 0 THEN X = INPUT(SUBSTR(STRING,START1,LENGTH1),9.);
      CALL PRXPOSN(RET,2,START2,LENGTH2);
      IF START2 GT 0 THEN Y = INPUT(SUBSTR(STRING,START2,LENGTH2),9.);
      OUTPUT;
   END;
   KEEP STRING X Y;
DATALINES;
XXXXXXXXXXXXXXXXXX 9 XXXXXXX         123
This line has a 6 and a 123 in it
456 789
None on this line
Only one here: 77
;
PROC PRINT DATA=READ_NUM NOOBS;
   TITLE "Listing of Data Set READ_NUM";
RUN;

Program 2.9:  Finding digits in random positions in an input string using 
                       CALL PRXNEXT
***Primary functions: PRXPARSE, CALL PRXNEXT
***Other functions: LENGTH, INPUT;

DATA FIND_NUM;
   IF _N_ = 1 THEN RET = PRXPARSE("/\d+/");
   *Look for one or more digits in a row;
   RETAIN RET;

   INPUT STRING $40.;
   START = 1;
   STOP = LENGTH(STRING);
   CALL PRXNEXT(RET,START,STOP,STRING,POSITION,LENGTH);
   ARRAY X[5];
   DO I = 1 TO 5 WHILE (POSITION GT 0);
      X[I] = INPUT(SUBSTR(STRING,POSITION,LENGTH),9.);
      CALL PRXNEXT(RET,START,STOP,STRING,POSITION,LENGTH);
   END;
   KEEP X1-X5 STRING;
DATALINES;
THIS 45 LINE 98 HAS 3 NUMBERS
NONE HERE
12 34 78 90
;
PROC PRINT DATA=FIND_NUM NOOBS;
   TITLE "Listing of Data Set FIND_NUM";
RUN;

Program 2.10: Demonstrating the PRXPAREN function
***Primary functions: PRXPARSE, PRXMATCH, PRXPAREN;

DATA PAREN;
   IF _N_ = 1 THEN PATTERN = PRXPARSE("/(\d )|(\d\d )|(\d\d\d )/");
   ***One or two or three digit number followed by a blank;
   RETAIN PATTERN;

   INPUT STRING $CHAR30.;
   POSITION = PRXMATCH(PATTERN,STRING);
   IF POSITION GT 0 THEN WHICH_PAREN = PRXPAREN(PATTERN);
DATALINES;
one single digit 8 here
two 888 77
12345 1234 123 12 1
;
PROC PRINT DATA=PAREN NOOBS;
   TITLE "Listing of Data Set PAREN";
RUN;

Program 2.11:  Demonstrating the CALL PRXCHANGE function
***Primary functions: PRXPARSE, CALL PRXCHANGE;

DATA CAT_AND_MOUSE;
   INPUT TEXT $CHAR40.;
   LENGTH NEW_TEXT $ 80;

   IF _N_ = 1 THEN MATCH = PRXPARSE("s/[Cc]at/Mouse/");
   *Replace "Cat" or "cat" with Mouse;
   RETAIN MATCH;

   CALL PRXCHANGE(MATCH,-1,TEXT,NEW_TEXT,R_LENGTH,TRUNC,N_OF_CHANGES);
   IF TRUNC THEN PUT "Note: NEW_TEXT was truncated";
DATALINES;
The Cat in the hat
There are two cat cats in this line
;
PROC PRINT DATA=CAT_AND_MOUSE NOOBS;
   TITLE "Listing of CAT_AND_MOUSE";
RUN;

Program 2.12:  Demonstrating the use of capture buffers with PRXCHANGE
***Primary functions: PRXPARSE, CALL PRXCHANGE;

DATA CAPTURE;
   IF _N_ = 1 THEN RETURN = PRXPARSE("S/(\w+ +)(\w+)/$2 $1/");
   RETAIN RETURN;

   INPUT STRING $20.;
   CALL PRXCHANGE(RETURN,-1,STRING);
DATALINES;
Ron Cody
Russell Lynn
;
PROC PRINT DATA=CAPTURE NOOBS;
   TITLE "Listing of Data Set CAPTURE");
RUN;

Program 2.13:  Data cleaning example using PRXPARSE and 
                         CALL PRXFREE
***Primary functions: PRXPARSE, RXMATCH, CALL PRXFREE;

DATA INVALID;
   ***Valid ID's are 1 to 3 digits with leading blanks;
   INFILE 'C:\BOOKS\FUNCTIONS\IDNUMS.DAT' END=LAST;
   IF _N_ = 1 THEN VALID = PRXPARSE("/\d\d\d| \d\d|  \d/");
   /*
      \d\d\d               matches three digits
      (single blank)\d\d   matches a blank followed by two digits
      (two blanks)\d       matches two blanks followed by one digit
   */

   RETAIN VALID;
   INPUT @1 ID $CHAR3.;
   POS = PRXMATCH(VALID,ID);
   IF POS EQ 0 THEN OUTPUT INVALID;
   IF LAST THEN CALL PRXFREE(VALID);
   DROP VALID;
RUN;

Program 3.1:  Using a SAS regular expression to locate data lines 
                       containing telephone numbers
***Primary functions: RXPARSE, RXMATCH
***Other function: MISSING;

DATA LOCATE;
   IF _N_ = 1 THEN DO;
      PHONE = RXPARSE("'('$D$D$D')'(' ')*$D$D$D'-'$D$D$D$D");
      RETAIN PHONE;
      IF MISSING(PHONE) THEN DO;
         PUT "Bad parsing of regular expression";
         STOP;
      END;
   END;

   INPUT STRING $CHAR80.;
   IF RXMATCH(PHONE,STRING) THEN OUTPUT;
DATALINES;
THIS LINE DOES NOT HAVE ANY PHONE NUMBERS ON IT
THIS LINE DOES: (123)345-4567 LA DI LA DI LA
(800)    123-1234 NOTE: MULTIPLE SPACES
TWO NUMBERS HERE (333)444-5555 AND (800)123-4567
;
PROC PRINT DATA=LOCATE NOOBS;
   TITLE "Lines Containing Phone Numbers";
RUN;

Program 3.2:  Extracting a phone number from a string, using a SAS 
                       regular expression
***Primary functions: RXPARSE and CALL RXSUBSTR
***Other functions: SUBSTR, COMPRESS, MISSING;

DATA EXTRACT;
   IF _N_ = 1 THEN DO;
      PHONE = RXPARSE("'('$D$D$D')'(' ')*$D$D$D'-'$D$D$D$D");
      RETAIN PHONE;
      IF MISSING(PHONE) THEN DO;
         PUT "Bad parsing of regular expression";
         STOP;
      END;
   END;
   LENGTH PHONE_NUMBER $ 13;
   INPUT STRING $CHAR80.;
   CALL RXSUBSTR(PHONE,STRING,START,LENGTH);
   IF START GT 0; ***Only valid numbers beyond this point;
   TEMP = SUBSTR(STRING,START,LENGTH);
   PHONE_NUMBER = COMPRESS(TEMP,' ');
   KEEP PHONE_NUMBER;
DATALINES;
THIS LINE DOES NOT HAVE ANY PHONE NUMBERS ON IT
THIS LINE DOES: (123)345-4567 LA DI LA DI LA
(800)    123-1234 NOTE: MULTIPLE SPACES
TWO NUMBERS HERE (333)444-5555 AND (800)123-4567
;
PROC PRINT DATA=EXTRACT NOOBS;
   TITLE "Lines Containing Phone Numbers";
RUN;

Program 3.3:  Using RXCHANGE to place two asterisks around every 
                       number
***Primary functions: RXPARSE, RXMATCH, CALL RXCHANGE;

DATA EXCHANGE;
   INPUT STRING $CHAR80.;
   LENGTH NEW_STRING $ 80;
   IF _N_ = 1 THEN 
      RETURN = RXPARSE("<$d+> TO '**' =1 '**'");
   RETAIN RETURN;
   POS = RXMATCH(RETURN,STRING);
   IF POS GT 0 THEN CALL RXCHANGE(RETURN,99,STRING,NEW_STRING);
DATALINES;
89 Lazy Brook Road
123 Sesame street
none here
;
PROC PRINT DATA=EXCHANGE NOOBS;
   TITLE "Listing of Data Set EXCHANGE";
RUN;

Program 3.4: Data cleaning example using RXPARSE and CALL RXFREE
***Primary functions: RXPARSE, RXMATCH, CALL RXFREE;

DATA INVALID;
   ***Valid ID's are 1 to 3 digits with leading blanks;
   INFILE 'C:\BOOKS\FUNCTIONS\IDNUMS.DAT' END=LAST;
   IF _N_ = 1 THEN VALID = RXPARSE("$d$d$d | ' ' $d$d | '  '$d");
   RETAIN VALID;
   INPUT @1 ID $CHAR3.;
   POS = RXMATCH(VALID,ID);
   IF POS EQ 0 THEN OUTPUT INVALID;
   IF LAST THEN CALL RXFREE(VALID);
   DROP VALID;
RUN;
PROC PRINT DATA=INVALID NOOBS;
   TITLE "Listing of Data Set INVALID";
RUN;

Program 4.1:  Creating a SAS date value from separate variables 
                       representing the day, month, and year of the date
***Primary function: MDY;

DATA FUNNYDATE;
   INPUT @1  MONTH  2. 
         @7  YEAR   4. 
         @13 DAY    2.;
   DATE = MDY(MONTH,DAY,YEAR);
   FORMAT DATE MMDDYY10.;
DATALINES;
05    2000  25
11    2001  02
;
PROC PRINT DATA=FUNNYDATE NOOBS;
   TITLE "Listing of FUNNYDATE";
RUN;

Program 4.2:  Program to read in dates and set the day of the month to 15 
                       if the day is missing from the date
***Primary function: MDY
   Other functions:  SCAN, INPUT;

DATA MISSING;
   INPUT @1 DUMMY $10.;
   DAY = SCAN(DUMMY,2,'/');
   IF DAY NE ' ' THEN DATE = INPUT(DUMMY,MMDDYY10.);
   ELSE DATE = MDY(INPUT(SCAN(DUMMY,1,'/'),2.),
                   15,
             INPUT(SCAN(DUMMY,3,'/'),4.));
   FORMAT DATE DATE9.;
DATALINES;
10/21/1946
1/  /2000
01/  /2002
;
PROC PRINT DATA=MISSING NOOBS;
   TITLE "Listing of MISSING";
RUN;

Program 4.3:  Determining the date, datetime value, and time of day 
***Primary functions: DHMS, HMS, TODAY, DATETIME, and TIME
***Other functions: YRDIF, INT;

DATA TEST;
   DATE = TODAY();
   DT = DATETIME();
   TIME = TIME();
   DT2 = DHMS(DATE,8,15,30);
   TIME2 = HMS(8,15,30);
   DOB = '01JAN1960'D;
   AGE = INT(YRDIF(DOB, TODAY(), 'ACTUAL'));
   FORMAT DATE DOB DATE9. DT DT2 DATETIME. TIME TIME2 TIME.;
RUN;

PROC PRINT DATA=TEST NOOBS;
   TITLE "Listing of Data Set TEST";
RUN;

Program 4.4:    Program to create the DATES data set
DATA DATES;
   INFORMAT DATE1 DATE2 DATE9.;
   INPUT DATE1 DATE2;
   FORMAT DATE1 DATE2 DATE9.;
DATALINES;
01JAN1960 15JAN1960 
02MAR1961 18FEB1962
25DEC2000 03JAN2001
01FEB2002 31MAR2002
;
PROC PRINT DATA=DATES NOOBS;
   TITLE "Listing of Data Set DATES";
RUN;

Program 4.5 :  Demonstrating the functions YEAR, QTR, MONTH, WEEK, 
                        DAY, and WEEKDAY
***Primary functions: YEAR, QTR, MONTH, WEEK, DAY, and WEEKDAY;

DATA DATE_FUNCTIONS;
   SET DATES(DROP=DATE2);
   YEAR = YEAR(DATE1);
   QUARTER = QTR(DATE1);
   MONTH = MONTH(DATE1);
   WEEK = WEEK(DATE1);
   DAY_OF_MONTH = DAY(DATE1);
   DAY_OF_WEEK = WEEKDAY(DATE1);
RUN;
PROC PRINT DATA=DATE_FUNCTIONS NOOBS;
   TITLE "Listing of Data Set DATE_FUNCTIONS";
RUN;

Program 4.6:  Demonstrating the HOUR, MINUTE, and SECOND functions
***Primary functions: HOUR, MINUTE, and SECOND;

DATA TIME;
   DT = '01JAN1960:5:15:30'DT;
   T = '10:05:23'T;
   HOUR_DT = HOUR(DT);
   HOUR_TIME = HOUR(T);
   MINUTE_DT = MINUTE(DT);
   MINUTE_TIME = MINUTE(T);
   SECOND_DT = SECOND(DT);
   SECOND_TIME = SECOND(T);
   FORMAT DT DATETIME.;
RUN;

PROC PRINT DATA=TIME NOOBS HEADING=H;
   TITLE "Listing of Data Set TIME";
RUN;

Program 4.7:  Extracting the date part and time part of a SAS datetime 
                       value
***Primary functions: DATEPART and TIMEPART;

DATA PIECES_PARTS;
   DT = '01JAN1960:5:15:30'DT;
   DATE = DATEPART(DT);
   TIME = TIMEPART(DT);
   FORMAT DT DATETIME. TIME TIME. DATE DATE9.;
RUN;

PROC PRINT DATA=PIECES_PARTS NOOBS;
   TITLE "Listing of Data Set PIECES_PARTS";
RUN;

Program 4.8:    Program to demonstrate the date interval functions
***Primary functions: INTCK, INTNX, YRDIF;

DATA PERIOD;
   SET DATES;
   INTERVAL_MONTH = INTCK('MONTH',DATE1,DATE2);
   INTERVAL_YEAR  = INTCK('YEAR',DATE1,DATE2);
   YEAR_DIFF      = YRDIF(DATE1,DATE2,'ACTUAL');
   INTERVAL_QTR   = INTCK('QTR',DATE1,DATE2);
   NEXT_MONTH     = INTNX('MONTH',DATE1,1);
   NEXT_YEAR      = INTNX('YEAR',DATE1,1);
   NEXT_QTR       = INTNX('QTR',DATE1,1);
   SIX_MONTH      = INTNX('MONTH',DATE1,6);
   FORMAT NEXT: SIX_MONTH DATE9.;
RUN;
PROC PRINT DATA=PERIOD HEADING=H;
   ID DATE1 DATE2;
   TITLE "Listing of Data Set PERIOD";
RUN;

Program 4.9: Demonstrating the three Julian date functions
***Primary functions: DATEJUL, JULDATE, and JULDATE7.;

***Note: option YEARCUTOFF set to 1920;
OPTIONS YEARCUTOFF = 1920;
DATA JULIAN;
   INPUT DATE : DATE9. JDATE;
   JDATE_TO_SAS = DATEJUL(JDATE);
   SAS_TO_JDATE = JULDATE(DATE);
   SAS_TO_JDATE7 = JULDATE7(DATE);
   FORMAT DATE JDATE_TO_SAS MMDDYY10.;
DATALINES;
01JAN1960 2003365
15MAY1901 1905001
21OCT1946 5001
;

PROC PRINT DATA=JULIAN NOOBS;
   TITLE "Listing of Data Set JULIAN";
   VAR DATE SAS_TO_JDATE SAS_TO_JDATE7 JDATE JDATE_TO_SAS;
RUN;

Program 5.1: Setting all numeric values of 999 to missing and all 
                   character values of 'NA' to missing
***Primary function: DIM
***Other function: UPCASE;

DATA MIXED;
   INPUT X1-X5 A $ B $ Y Z;
DATALINES;
1 2 3 4 5 A b 6 7
2 999 6 5 3 NA C 999 10
5 4 3 2 1 na B 999 999
;
DATA ARRAY_1;
   SET MIXED;
   ARRAY NUMS[*] _NUMERIC_;
   ARRAY CHARS[*] _CHARACTER_;
   DO I = 1 TO DIM(NUMS);
      IF NUMS[I] = 999 THEN NUMS[I] = .;
   END;
  
 DO I = 1 TO DIM(CHARS);
      CHARS[I] = UPCASE(CHARS[I]);
      IF CHARS[I] = 'NA' THEN CHARS[I] = ' ';
   END;
   DROP I;
RUN;
PROC PRINT DATA=ARRAY_1 NOOBS;
   TITLE "Listing of Data Set ARRAY_1";
RUN;

Program 5.2:  Creating a macro to compute and print out the number of 
                       numeric and character variables in a SAS data set
***Primary function: DIM;

%MACRO COUNT(DSN);
   DATA _NULL_;
      IF 0 THEN SET &DSN;
      ARRAY NUMS[*] _NUMERIC_;
      ARRAY CHARS[*] _CHARACTER_;
      N_NUMS = DIM(NUMS);
      N_CHARS = DIM(CHARS);
      FILE PRINT;
      TITLE1 "*** Statistics for Data Set &DSN ***";
      PUT / "There are " N_NUMS "numeric variables and " 
          N_CHARS "character variables";
   RUN;
%MEND COUNT;

Program 5.3:  Determining the lower and upper bounds of an array where
                        the array bounds do not start from one
***Primary functions: LBOUND and HBOUND;

DATA ARRAY_2;
   ARRAY INCOME[1990:1995] INCOME1990-INCOME1995;
   ARRAY TAX[1990:1995] TAX1990-TAX1995;
   INPUT INCOME1990 - INCOME1995;
   DO YEAR = LBOUND(INCOME) TO HBOUND(INCOME);
      TAX[YEAR] = .25 * INCOME[YEAR];
   END;
   FORMAT INCOME: TAX: DOLLAR8.;
   DROP YEAR;
DATALINES;
50000 55000 57000 66000 65000 68000
;
PROC PRINT DATA=ARRAY_2 NOOBS;
   TITLE "Listing of Data Set ARRAY_2";
RUN;
   
Program 6.1:  Using the CEIL function to round up a value to the next 
                       penny
***Primary function CEIL;

DATA ROUNDUP;
   INPUT MONEY @@;
   UP = CEIL(100*MONEY)/100;
DATALINES;
123.452 45 1.12345 4.569
;
PROC PRINT DATA=ROUNDUP NOOBS;
   TITLE "Listing of Data Set ROUNDUP";
RUN;

Program 6.2:  Computing a person's age as of his or her last birthday 
                       (rounding down)
***Primary function: FLOOR
***Other function: YRDIF;

DATA FLEUR;
   INPUT @1 DOB MMDDYY10.;
   AGE = YRDIF(DOB,'01JAN2003'D,"ACTUAL");
   AGE_FLOOR = FLOOR(AGE);
   ***Note: Since AGE is positive, the INT function is equivalent;
   FORMAT DOB MMDDYY10.;
DATALINES;
10/21/1946
05/25/2000
;
PROC PRINT DATA=FLEUR NOOBS;
   TITLE "Listing of Data Set FLEUR";
RUN;

Program 6.3:  Using the INT function to compute age as of a person's last 
                        birthday
***Primary function: INT;

DATA AGES;
   INFORMAT DOB MMDDYY10.;
   INPUT DOB @@;
   AGE = ('01JAN2003'D - DOB) / 365.25;
   AGE_INT = INT(AGE);
   FORMAT DOB MMDDYY10.;
DATALINES;
10/21/1946 11/12/1956 6/7/2002 12/20/1966 3/6/1930 5/8/1980
;
PROC PRINT DATA=AGES NOOBS;
   TITLE "Listing of Data Set AGES";
RUN;

Program 6.4: Rounding students' grades several ways
***Primary function: ROUND
***Other function: MEAN;

DATA SCORES;
   INPUT ID TEST1-TEST3;
   TEST_AVE = MEAN(OF TEST1-TEST3);
   ROUND_ONE = ROUND(TEST_AVE);
   ROUND_TENTH = ROUND(TEST_AVE,.1);
   ROUND_TWO = ROUND(TEST_AVE,2);
DATALINES;
1  100 95 95
2  78 79 88
;
PROC PRINT DATA=SCORES NOOBS;
   TITLE "Listing of Data Set SCORES";
   ID ID;
   VAR TEST_AVE ROUND:;
RUN;

Program 6.5:  Using the ROUND function to group ages into 10-year 
                       intervals
***Primary function: ROUND
***Other function: YRDIF;

DATA DECADES;
   INFORMAT DOB MMDDYY10.;
   INPUT DOB @@;
   AGE = YRDIF(DOB,'01JAN2003'D,"ACTUAL");
   DECADE = ROUND(AGE + 5., 10);
   FORMAT DOB MMDDYY10.;
DATALINES;
10/21/1946 11/12/1956 6/7/2002 12/20/1966 3/6/1930 5/8/1980
11/11/1998 10/21/1990 5/5/1994 10/21/1992
;
PROC PRINT DATA=DECADES NOOBS;
   TITLE "Listing of Data Set DECADES";
RUN;

Program 6.6: Demonstrating the various truncation functions
***Primary functions: CEIL, FLOOR, INT, and ROUND;

DATA TRUNCATE;
   INPUT X @@;
   CEIL = CEIL(X);
   FLOOR = FLOOR(X);
   INT = INT(X);
   ROUND = ROUND(X);
DATALINES;
7.2 7.8 -7.2 -7.8
;
PROC PRINT DATA=TRUNCATE NOOBS;
   TITLE "Listing of Data Set TRUNCATE";
RUN;

Program 6.7:  Logical comparisons with numbers stored with fewer than 
                       8 bytes of precision
***Primary function: TRUNC;

DATA TEST;
   LENGTH X4 4 X8 8;
   INPUT X4 X8;
DATALINES;
1.234 1.234
;
DATA TRUNCTEST;
   SET TEST;
   IF X8 = 1.234 THEN COMPARE_X8 = 'TRUE ';
   ELSE COMPARE_X8 = 'FALSE';
   IF X4 = 1.234 THEN COMPARE_X4 = 'TRUE ';
   ELSE COMPARE_X4 = 'FALSE';
   IF X4 = TRUNC(1.234,4) THEN COMPARE_TRUNC_X4 = 'TRUE ';
   ELSE COMPARE_TRUNC_X4 = 'FALSE';
RUN;

PROC PRINT DATA=TRUNTEST NOOBS;
   TITLE "Listing of Data Set TRUNTEST";
RUN;

Program 7.1:  Using the N function to determine the number of 
                       non-missing values in a list of variables
***Primary functions: N, MEAN;

DATA QUIZ;
   INPUT QUIZ1-QUIZ10;
   ***Compute quiz average if 8 or more quizzes taken;
   IF N(OF QUIZ1-QUIZ10) GE 8 THEN QUIZ_AVE = MEAN(OF QUIZ1-QUIZ10);
DATALINES;
90 88 79 100 97 96 94 95 93 88
60 90 66 77 . . . 88 84 86
90 . . 90 90 90 90 90 90 90
;
PROC PRINT DATA=QUIZ NOOBS HEADING=H;
   TITLE "Listing of Data Set QUIZ";
RUN;

Program 7.2:  Computing a SUM and MEAN of a list of variables, only if 
                       there are no missing values
***Primary functions: NMISS, MEAN and SUM
***Other function: N;

 DATA NOMISS;
   INPUT X1-X3 Y Z;
   IF NMISS(OF X1-X3,Y,Z) EQ 0 THEN DO;

   ***An alternative statement is:
   IF N(OF X1-X3,Y,Z) EQ 5 THEN DO;

      SUM_VARS = SUM(OF X1-X3,Y,Z);
      AVERAGE = MEAN(OF X1-X3,Y,Z);
   END;
DATALINES;
1 2 3 4 5
9 . 8 7 6
8 8 8 8 8
;
PROC PRINT DATA=NOMISS NOOBS;
   TITLE "Listing of Data Set NOMISS";
RUN;

Program 7.3:  Computing a mean, median, and sum of eight variables, only 
                       if there are at least six non-missing values
***Primary functions: N, MEAN, MEDIAN, SUM;

DATA SCORE;
   INPUT @1 (ITEM1-ITEM8)(1.);
   IF N(OF ITEM1-ITEM8) GE 6 THEN DO;
      MEAN = MEAN(OF ITEM1-ITEM8);
      MEDIAN = MEDIAN(OF ITEM1-ITEM8);
      SUM = SUM(OF ITEM1-ITEM8);
   END;
DATALINES;
12345678
1.3.5678
1...5678
;
PROC PRINT DATA=SCORE NOOBS;
   TITLE "Listing of SCORE";
RUN;

Program 7.4:  Computing a range, interquartile range, and standard 
                       deviation for each subject
***Primary functions: RANGE, IQR, and STD;

DATA HOME_ON_THE_RANGE;
   INPUT SUBJECT X1-X10;
   RANGE = RANGE(OF X1-X10);
   IQR = IQR(OF X1-X10);
   SD = STD(OF X1-X10);
DATALINES;
1  1 2 3 4 5 6 7 8 9 10
2  9 7 4 1 15 0 . 2 7 4
3  1 3 5 7 9 11 13 15 20 100
;
PROC PRINT DATA=HOME_ON_THE_RANGE;
   TITLE "Listing of Data Set HOME_ON_THE_RANGE";
   ID SUBJECT;
RUN;

Program 7.5:  Program to read hourly temperatures and determine the 
                       daily minimum and maximum temperature
***Primary functions: MIN and MAX;

DATA MIN_MAX_TEMP;
   INFORMAT DATE MMDDYY10.;
   INPUT DATE;
   INPUT TEMP1-TEMP24;
   MIN_TEMP = MIN(OF TEMP1-TEMP24);
   MAX_TEMP = MAX(OF TEMP1-TEMP24);
   KEEP MIN_TEMP MAX_TEMP DATE;
   FORMAT DATE MMDDYY10.;
DATALINES;
05/1/2002
38 38 39 40 41 42 55 58 60 60 59 62 66 70 75 77 60 59 58 57 54 52 51 50
05/02/2002
36 41 39 40 41 46 57 59 63 . 59 62 64 72 79 80 78 62 62 62 60 50 55 55
;
PROC PRINT DATA=MIN_MAX_TEMP NOOBS;
   TITLE "Listing of Data Set MIN_MAX_TEMP";
RUN;

Program 7.6:  Computing the three lowest golf scores for each player 
                       (using the SMALLEST function)
***Primary function: SMALLEST;

DATA GOLF;
   INFILE DATALINES MISSOVER;
   INPUT ID $ SCORE1-SCORE8;
   LOWEST = SMALLEST(1 ,OF SCORE1-SCORE8);
   NEXT_LOWEST = SMALLEST(2, OF SCORE1-SCORE8);
   THIRD_LOWEST = SMALLEST(3, OF SCORE1-SCORE8);
DATALINES;
001 100 98 . . 96 93
002 90 05 07 99 103 106 110
003 110 120
;
PROC PRINT DATA=GOLF NOOBS HEADING=H;
   TITLE "Listing of Data Set GOLF";
RUN;

Program 7.7:  Computing a grade based on the five highest scores
***Primary function: LARGEST, N;

***This program will compute a grade based on the 5 highest
   (out of 9) scores.  If there are fewer than 5 non-missing scores, 
   a missing value will be returned;

DATA HIGH_5;
   INPUT SCORE1-SCORE9;
   ARRAY SCORE[9];
   IF N(OF SCORE1-SCORE9) LT 5 THEN RETURN;
   SUM = 0;
   DO I = 1 TO 5;
      SUM = SUM + LARGEST(I,OF SCORE1-SCORE9);
   END;
   GRADE = SUM / 5;
   DROP I;
DATALINES;
90 100 89 88 10 . . 29 77
. . . . . 100 99 98 97
10 20 30 40 50 60 70 80 90
;
PROC PRINT DATA=HIGH_5 NOOBS;
   TITLE "Listing of Data Set HIGH_5";
RUN;

Program 7.8:  Macro to compute an average of n scores where the lowest 
                       m scores are dropped
***Primary functions: N, MIN, LARGEST;
*----------------------------------------------------------------*
| Macro: DROP_N                                                  |
| Purpose: Takes the average of "n" scores by dropping the       |
|          lowest "m" scores from the calculation.               |
| Arguments: DSN      Data set name                              |
|            BASE     Base of variable name holding scores       |
|            N        Total number of scores                     |
|            N_DROP   Number of scores to drop                   |
|            VARNAME  The name of the variable to hold the       |
|                     average                                    |
|            Note: The average variable is added to the original |
|                  data set.                                     |
| Example: %MACRO DROP_N(ROSTER,QUIZ,12,2,AVERAGE);              |
*----------------------------------------------------------------*;

%MACRO DROP_N(DSN, BASE, N, N_DROP, VARNAME);
   DATA &DSN;
      SET &DSN;
      N_OF_SCORES = N(OF &BASE.1-&BASE&N);
      MIN = MIN(N_OF_SCORES,%EVAL(&N - &N_DROP));
      SUM = 0;
      DO I = 1 TO MIN;
         SUM + LARGEST(I,OF &BASE.1-&BASE&N);
      END;
      &VARNAME = SUM / MIN;
      ***Replace MIN with %EVAL(&N - &N_DROP) to penalize
         students taking fewer than the minimum number of quizzes;
      DROP I N_OF_SCORES SUM MIN;
   RUN;
%MEND DROP_N;

Program 7.9:  Using the PCTL function to determine 25th, 50th, and 75th 
                       percentile in a list of values
***Primary function: PCTL
***Other functions: RANNOR;

***Generate data set for testing;
DATA TEMPERATURE;
   ARRAY T[24]; ***Temperature for each hour;
   DO DAY = 1 TO 5;
      ***T values normally distributed with mean = 70 and 
         standard deviation = 10;
      DO HOUR = 1 TO 24;
         T[HOUR] = 10*RANNOR(0) + 70;
      END;
      OUTPUT;
   END;
   KEEP T1-T24 DAY;
RUN;

DATA PERCENTILE;
   SET TEMPERATURE;
   P25 = PCTL(25, OF T1-T24);
   P50 = PCTL(50, OF T1-T24);
   P75 = PCTL(75, OF T1-T24);
   IQR = P75 - P25;
   LABEL P25 = "25th Percentile"
         P50 = "Median"
         P75 = "75th Percentile"
         IQR = "Inter-quartile Range";
RUN;

PROC PRINT DATA=PERCENTILE NOOBS LABEL;
   TITLE "Listing of Data Set PERCENTILE";
   ID DAY;
   VAR P25 P50 P75 IQR;
RUN;

Program 7.10:  Program to compute a quiz grade by dropping none, one, or 
                         two of the lowest quiz scores, depending on how many 
                         quizzes were taken
***Primary function: ORDINAL
***Other functions: N, MEAN, and SUM;

DATA QUIZ_AVE;
   INPUT ID $ QUIZ1-QUIZ9;
   N_OF_QUIZZES = N(OF QUIZ1-QUIZ9);
   IF N_OF_QUIZZES  = 9 THEN 
      QUIZ_AVE = (SUM(OF QUIZ1-QUIZ9) - 
                  ORDINAL(1,OF QUIZ1-QUIZ9) -
                  ORDINAL(2,OF QUIZ1-QUIZ9))/7;
   ELSE IF N_OF_QUIZZES = 8 THEN 
      QUIZ_AVE = (SUM(OF QUIZ1-QUIZ9) - ORDINAL(2,OF QUIZ1-QUIZ9))/7;
   ELSE QUIZ_AVE = MEAN(OF QUIZ1-QUIZ9);
DATALINES;
001 6 7 8 9 8 7 6 7 8
002 6 8 8 8 8 8 8 8 .
003 7 8 9 . . . . . .
004 9 9 1 9 9 9 9 . .
;
PROC PRINT DATA=QUIZ_AVE NOOBS;
   TITLE "Listing of Data Set QUIZ_AVE";
RUN;

Program 7.11:  Alternate version of Program 7.10
***Primary function: ORDINAL
***Other functions: N and MIN;

DATA QUIZ_AVE2;
   INPUT ID $ QUIZ1-QUIZ9;
   N_OF_QUIZZES = N(OF QUIZ1-QUIZ9);
   SUM = 0;
   DO I = 1 TO MIN(N_OF_QUIZZES,7);
      SUM + ORDINAL(10 - I,OF QUIZ1-QUIZ9);
   END;
   QUIZ_AVE = SUM / MIN(N_OF_QUIZZES,7);
DATALINES;
001 6 7 8 9 8 7 6 7 8
002 6 8 8 8 8 8 8 8 .
003 7 8 9 . . . . . .
004 9 9 1 9 9 9 9 . .
;
PROC PRINT DATA=QUIZ_AVE2 NOOBS;
   TITLE "Listing of Data Set QUIZ_AVE2";
RUN;

Program 7.12: Sorting values within an observation
***Primary function: ORDINAL
***Other functions: CALL SORTN;

DATA SORT;
   INPUT X1-X10;
   ARRAY X[10] X1-X10;
   ARRAY SORT_X[10] SORT_X1-SORT_X10;
   DO I = 1 TO 10;
      SORT_X[I] = ORDINAL(I,OF X1-X10);
   END;
   DROP I;
DATALINES;
5 2 9 1 3 6 . 22 7 0
PROC PRINT DATA=SORT NOOBS HEADING=H;
   TITLE "Listing of Data Set SORT";
RUN;

/**************************************************
Experimental:
CALL SORTN solution (with the result placed in the
                     original array)

DATA SORT;
   INPUT X1-X10;
   ARRAY X[10] X1-X10;
   CALL SORTN(OF X[*]);
DATALINES;
5 2 9 1 3 6 . 22 7 0
***************************************************/

Program 7.13: Macro to sort values within an observation
***Primary function: ORDINAL;

%MACRO SORT_ARRAY(DSN, BASE, N_OF_ELEMENTS);
   DATA &DSN;
      SET &DSN;
      ARRAY &BASE[&N_OF_ELEMENTS];
      ARRAY TEMP[&N_OF_ELEMENTS] _TEMPORARY_;
      ***Transfer values to temporary arry;
      DO I = 1 TO &N_OF_ELEMENTS;
         TEMP[I] = ORDINAL(I,OF &BASE.1 - &BASE&N_OF_ELEMENTS);
      END;
      ***Put them back in the original variable names in order;
      DO I = 1 TO &N_OF_ELEMENTS;
         &BASE[I] = TEMP[I];
      END;
   RUN;
%MEND  SORT;

Program 7.14:  Performing a t test where values for each group are in a 
                         single observation
***Primary function: STD
***Other functions: N, MEAN, SQRT, PROBT, ABS;

DATA _NULL_;
   FILE PRINT;
   INFILE DATALINES MISSOVER;
   INPUT GROUP $ X1-X50;
   RETAIN N1 MEAN1 SD1 GROUP1;
   IF _N_ = 1 THEN DO;
      GROUP1 = GROUP;
      N1 = N(OF X1-X50);
      MEAN1 = MEAN(OF X1-X50);
      SD1 = STD(OF X1-X50);
   END;
   IF _N_ = 2 THEN DO;
      GROUP2 = GROUP;
      N2 = N(OF X1-X50);
      MEAN2 = MEAN(OF X1-X50);
      SD2 = STD(OF X1-X50);
      DIFF = MEAN1 - MEAN2;
      SD_POOLED_2 = ((N1-1)*SD1**2 + (N2-1)*SD2**2)/(N1 + N2 - 2);
      T = ABS(DIFF) / SQRT(SD_POOLED_2/N1 + SD_POOLED_2/N2);
      PROB = 2*(1 - PROBT(T,N1+N2-2));

      ***Prepare the report;
      TITLE "T-Test Calculation";
      PUT @1  "Group " GROUP1 +(-1) ":" 
          @10 "N = " N1 3. 
          @20 "Mean = " MEAN1 7.3
          @35 "SD = " SD1 7.4 /
          @1  "Group " GROUP2 +(-1) ":" 
          @10 "N = " N2  3.
          @20 "Mean = " MEAN2 7.3
          @35 "SD = " SD2 7.4 /
          @1 "Difference = " DIFF 7.3
          @25 "T = " T 7.4
          @40 "P(2-tail) = " PROB 7.4;
      END;
DATALINES;
A 4 5 8 7 6 5 7
B 9 7 8 8 6 7 9 9 11
;

Program 8.1:  Determining mathematical constants and machine 
                       constants using the CONSTANT function
***Primary function: CONSTANT;

DATA _NULL_;
   FILE PRINT;
   PI = CONSTANT('PI');
   E = CONSTANT('E');

   PUT "Mathematical Constants" /
       "Pi = " PI /
       "E = " E //
       "Largest Integers stored in 'n' bytes:";
   DO BYTES = 3 TO 8;
      INT = CONSTANT('EXACTINT',BYTES);
      PUT +5 "Largest Integer Stored in " BYTES "Bytes is: " INT;
   END;
   LARGE = CONSTANT('BIG');
   SMALL = CONSTANT('SMALL');
   PRECISION = CONSTANT('MACEPS');
   PUT / "Machine Constants" /
         "Largest 8 Byte Value is: " LARGE /
         "Smallest 8 Byte Value is: " SMALL / 
         "Precision constant is: " PRECISION;
RUN;

Program 8.2:  Using the MOD function to choose every nth observation 
                       from a SAS data set
***Primary function: MOD
***Other functions: INT, RANUNI;

***Create test input data set;
DATA BIG;
   DO SUBJ = 1 TO 20;
      X = INT(10*RANUNI(0)); /* Random integers from 0 to 9 */
      OUTPUT;
   END;
RUN;

%LET N = 4; /* Every 4th observation will be selected */

DATA EVERY_N;
   SET BIG;
   IF MOD(_N_ ,&N) = 1; 
   /* Selects every nth observation, starting with the 1st */
RUN;

PROC PRINT DATA=EVERY_N NOOBS;
   TITLE "Listing of Data Set EVERY_N";
RUN;

Program 8.3:  Using the MOD function as a toggle switch, alternating 
                       group assignments
***Primary function: MOD;
***In this program, we want to assign every other subject into 
   group A or group B;

DATA SWITCH;
   DO SUBJ = 1 TO 10;
      IF MOD(SUBJ,2) EQ 1 THEN GROUP = 'A';
      ELSE GROUP = 'B';
      OUTPUT;
   END;
RUN;
PROC PRINT DATA=SWITCH NOOBS;
   TITLE "Listing of Data Set SWITCH";
RUN;

Program 8.4:  Computing Chi-square with Yates' correction, which 
                       requires an absolute value
***Primary function: ABS
***Other function: PROBCHI;

DATA YATES;
   INPUT A B C D;
   N = A + B + C + D;
   YATES = ( ABS(A*D - B*C) - N/2)**2 * N / 
           ( (A+B)*(C+D)*(A+C)*(B+D) );
      PROB_YATES = 1 - PROBCHI(YATES,1); 
DATALINES;
10 20 30 40
2 9 8 5
;
PROC PRINT DATA=YATES NOOBS;
   TITLE "Listing of Data Set YATES";
RUN;

Program 8.5:  Program to compute and print out a table of integers and 
                       square roots
***Primary function: SQRT;

OPTIONS PS=15; /* So the panels will display in PROC REPORT */
DATA SQUARE_ROOT;
   DO N = 1 TO 40;
      SQUARE_ROOT = SQRT(N);
      OUTPUT;
   END;
RUN;

PROC REPORT DATA=SQUARE_ROOT NOWD PANELS=99;
   TITLE "Table of Integers and Square Roots";
   COLUMNS N SQUARE_ROOT;
   DEFINE N / DISPLAY WIDTH=3 FORMAT=3.0;
   DEFINE SQUARE_ROOT /'Square Root' WIDTH=7 FORMAT=7.6;
RUN;

Program 8.6:  Creating tables of integers, their base-10 and base E 
                       logarithms and their value taken to the nth power
***Primary functions: EXP, LOG, LOG10;
***Program to print a pretty table of integers (from 1 to 100),
   results of the exponential function, base ten and base E logs;

DATA TABLE;
   DO N = 1 TO 40;
      E = .EXP(N);
      LN = LOG(N);
      LOG = LOG10(N);
      OUTPUT;
   END;
RUN;

PROC REPORT DATA=TABLE NOWD PANELS=99;
   TITLE "Table of Exponents, natural and base 10 logs";
   COLUMNS N E LN LOG;
   DEFINE N / DISPLAY RIGHT WIDTH=3 FORMAT=3.;
   DEFINE E / DISPLAY RIGHT WIDTH=8 FORMAT=BEST8. 'Exp';
   DEFINE LN / DISPLAY RIGHT WIDTH=7 FORMAT=7.4 'Natural Log';
   DEFINE LOG / DISPLAY RIGHT WIDTH=7 FORMAT=7.4 'Base 10 Log';
RUN;

Program 8.7:  Creating a table of integers and factorials
***Primary function: FACT;

DATA FACTORIAL;
   DO N = 1 TO 12;
      FACTORIAL_N = FACT(N);
      OUTPUT;
   END;
   FORMAT FACTORIAL_N COMMA12.;
RUN;

PROC PRINT DATA=FACTORIAL NOOBS;
   TITLE "Listing of Data Set FACTORIAL";
RUN;

Program 8.8:  Demonstrating the GAMMA function
***Primary function: GAMMA;

DATA TABLE;
   DO X = 1 TO 5 BY .05;
      GAMMA = GAMMA(X);
      OUTPUT;
   END;
RUN;

ODS RTF FILE='C:\BOOKS\FUNCTIONS\GAMMA.RTF';
GOPTIONS DEVICE=JPEG;
SYMBOL V=NONE I=SM;
PROC GPLOT DATA=TABLE;
   TITLE "Graph of Gamma Function from 1 to 5";
   PLOT GAMMA * X;
RUN;
ODS RTF CLOSE;

Program 9.1:  Demonstrating differences between random functions and 
                       call routines (function example)
DATA RAN_FUNCTION;
   DO N = 1 TO 3;
      X = RANUNI(1234);
      Y = RANUNI(0);
      OUTPUT;
   END;
RUN;

PROC PRINT DATA=RAN_FUNCTION NOOBS;
   TITLE "Listing of Data Set RAN_FUNCTION - First Run";
RUN;

PROC PRINT DATA=RAN_FUNCTION NOOBS;
   TITLE "Listing of Data Set RAN_FUNCTION - Second Run";
RUN;

Program 9.2:  Demonstrating differences between random functions and 
                       call routines (call routine example)
DATA RAN_CALL;
   SEED1 = 1234;
   SEED2 = 0;
   DO N = 1 TO 3;
      CALL RANUNI(SEED1,X);
      CALL RANUNI(SEED2,Y);
      OUTPUT;
   END;
RUN;

PROC PRINT DATA=RAN_CALL NOOBS;
   TITLE "Listing of Data Set RAN_CALL - First Run";
RUN;

PROC PRINT DATA=RAN_CALL NOOBS;
   TITLE "Listing of Data Set RAN_CALL - Second Run";
RUN;

Program 9.3:  Selecting an approximate n% random sample
***Primary function: RANUNI;

***This first DATA step generates a test data set;
DATA BIG;
   DO SUBJ = 1 TO 1000;
      OUTPUT;
   END;
RUN;

***This DATA step demonstrates how to select a random subset;
DATA RANDOM1;
   SET BIG (WHERE=(RANUNI(456) LE .10));
RUN;

Program 9.4:  Selecting a random sample with exactly n observations
***Primary function: RANUNI;

DATA RANDOM2;
   SET BIG;
   SHUFFLE = RANUNI(0);
RUN;

PROC SORT DATA=RANDOM2;
   BY SHUFFLE;
RUN;

DATA EXACT_N;
   SET RANDOM2(DROP=SHUFFLE);
   IF _N_ GT 100 THEN STOP;
RUN;

Program 9.5:  Simulating random throws of two dice
***Primary function: RANUNI
***Other function: INT;

DATA DICE;
   DO I = 1 TO 1000; /* Generate 1000 throws */
      DIE_1 = INT(RANUNI(0)*6 + 1);
      DIE_2 = INT(RANUNI(0)*6 + 1);
      THROW = DIE_1 + DIE_2;
      OUTPUT;
   END;
RUN;

PROC FREQ DATA=DICE;
   TITLE "Frequencies of Dice Throws";
   TABLES DIE_1 DIE_2 THROW / NOCUM NOPERCENT;
RUN;

Program 9.6:  Randomly assigning n subjects into two groups: Method 1 - 
                       Approximate number of subjects in each group
***Primary function: RANUNI;

DATA ASSIGN1;
   DO SUBJ = 1 TO 12;
      IF RANUNI(123) LT .5 THEN GROUP = 'A';
    ELSE GROUP = 'B';
    OUTPUT;
   END;
RUN;

PROC PRINT DATA=ASSIGN1 NOOBS;
   TITLE "List of Random Assignments";
RUN;

Program 9.7:  Randomly assigning n subjects into two groups: Method 2 - 
                       Equal number of subjects in each group
***Primary function: RANUNI;

PROC FORMAT;
   VALUE GRPFMT 0 = 'A'  1 = 'B';
RUN;

DATA ASSIGN2;
   DO SUBJ = 1 TO 12;
      GROUP = RANUNI(123);
      OUTPUT;
   END;
RUN;

PROC RANK DATA=ASSIGN2 OUT=RANDOM GROUPS=2;
   VAR GROUP;
RUN;

PROC PRINT DATA=RANDOM NOOBS;
   TITLE "Random assignment of subjects, equal number in each group";
   ID SUBJ;
   VAR GROUP;
   FORMAT GROUP GRPFMT.;
RUN;

Program 9.8:  Randomly assigning n subjects into two groups: Method 3 -
                       Equal number of subjects in each group within blocks of four 
                       subjects
*** Primary function: RANUNI;

DATA ASSIGN3;
   DO BLOCK = 1 TO 3;
      DO I = 1 TO 4;
         SUBJ + 1;
         GROUP = RANUNI(123);
         OUTPUT;
      END;
   END;
   DROP I;
RUN;

PROC RANK DATA=ASSIGN3 OUT=RANDOM GROUPS=2;
   BY BLOCK;
   VAR GROUP;
RUN;

PROC PRINT DATA=RANDOM NOOBS;
   TITLE "Random assignment of subjects, blocks of four";
   ID SUBJ;
   VAR GROUP;
   FORMAT GROUP GRPFMT.;
RUN;

Program 9.9: Macro to assign n subjects into k groups
***Primary function: RANUNI;

***Macro to assign n subjects into k groups;
*------------------------------------------------------------*
| Macro Name: ASSIGN                                         |
| Purpose: Random assignment of k treatments for n subjects  |
| Arguments: DSN     : Data set to hold output               |
|            N       : Number of subjects                    |
|            K       : Number of groups                      |
|            SEED=   : Number for seed, seed is 0 if omitted |
|            REPORT= : NO if no report is desired            |
| Example: %ASSIGN (MYDATA, 100, 4) will assign 100 subjects |
|          into four (equal) groups                          |
| Example: %ASSIGN (MYDATA, 100, 2, SEED=123, REPORT=NO)     |
|          100 subjects assigned to two groups, the random   |
|          seed is 123 and no report is desired              |
*------------------------------------------------------------*;
%MACRO ASSIGN(DSN,N,K,SEED=0,REPORT=YES);
   DATA _TEMP_;
      DO SUBJ = 1 TO &N;
         GROUP = RANUNI(&SEED);
         OUTPUT;
      END;
      RUN;
   PROC RANK DATA=_TEMP_ OUT=&DSN GROUPS=&K;
      VAR GROUP;
   RUN;
   ***Increment GROUP so group numbers start with 1;
   DATA &DSN;
      SET &DSN;
      GROUP = GROUP + 1;
   RUN;
   %IF &REPORT EQ YES %THEN %DO;
      PROC REPORT DATA=&DSN NOWD PANELS=99;
         TITLE "&N of Subjects Randomly Assigned to &K Groups";
         COLUMNS SUBJ GROUP;
         DEFINE SUBJ / DISPLAY WIDTH=4 RIGHT FORMAT=4.0 'Subj';
         DEFINE GROUP / DISPLAY WIDTH=5 CENTER FORMAT=2. 'Group';
      RUN;
   %END;
   PROC DATASETS LIBRARY=WORK;
      DELETE _TEMP_;
   RUN;
   QUIT;
%MEND ASSIGN;

Program 9.10:  Macro to assign n subjects into k groups, with b subjects 
                         per block
***Primary function: RANUNI;

***Macro to assign n subjects into k groups with b subjects
   per block;
*------------------------------------------------------------*
| Macro Name: ASSIGN_BALANCE                                 |
| Purpose: Random assignment of k treatments for n subjects  |
| Arguments: DSN      : Data set to hold output              |
|            N       : Number of subjects                    |
|            K       : Number of groups                      |
|            B       : Number of subjects per block          |
|                      B must be evenly divisible by k       |
|            SEED=   : Number for seed, seed is 0 if omitted |
|            REPORT= : NO if no report is desired            |
| Example: %ASSIGN (MYDATA, 100, 4, 20) will assign 100      |
|          subjects into four (equal) groups, with the same  |
|          number of subjects in each of the k groups in     |
|          every block of 20 subjects.                       |
| Example: %ASSIGN (MYDATA, 100, 2, 100,SEED=123, REPORT=NO) |
|          100 subjects assigned to two groups, the random   |
|          seed is 123 and no report is desired              |
*------------------------------------------------------------*;
%MACRO ASSIGN_BALANCE(DSN, N, K, B, SEED=0,REPORT=YES);
   DATA _TEMP_;
   %IF %EVAL(%SYSEVALF(&B/&K, FLOOR) - %SYSEVALF(&B/&K, CEIL))
      NE 0 %THEN %DO;
      FILE PRINT;
      PUT "The number of subjects per group (&B) is not"/ 
          "evenly divisible by the number of groups (&K)";
      STOP;
   %END;
      %LET N_BLOCKS = %SYSEVALF(&N/&B,FLOOR);
      DO BLOCK = 1 TO &N_BLOCKS;
         DO J = 1 TO &B;
            SUBJ + 1;
            GROUP = RANUNI(&SEED);   
            OUTPUT;
         END;
      END;
   RUN;
   PROC RANK DATA=_TEMP_ OUT=&DSN GROUPS=&K;
      BY BLOCK;
      VAR GROUP;
   RUN;
   ***Increment GROUP so group numbers start with 1;
   DATA &DSN;
      SET &DSN(DROP = BLOCK);
      GROUP = GROUP + 1;
   RUN;
   %IF &REPORT EQ YES %THEN %DO;
   PROC REPORT DATA=&DSN NOWD PANELS=99;
      TITLE1 "&N of Subjects Randomly Assigned to &K Groups";
      TITLE2 "Equal number of subjects in each group of &B subjects";
      COLUMNS SUBJ GROUP;
      DEFINE SUBJ / DISPLAY WIDTH=4 RIGHT FORMAT=4.0 'Subj';
      DEFINE GROUP / DISPLAY WIDTH=5 CENTER FORMAT=2. 'Group';
   RUN;
   %END;
   PROC DATASETS LIBRARY=WORK;
      DELETE _TEMP_;
   RUN;
   QUIT;
%MEND ASSIGN_BALANCE;

Program 9.11:  Demonstrating a Monte-Carlo simulation to determine the 
                         power of a t test
***Primary function: RANNOR;

/*****************************************************************
   Group 1:mean = 100 n = 8 standard deviation = 10
   Group 2:mean = 115 n = 6 standard deviation = 12
   Scores are normally distributed in each group.
   This program generates 1000 samples;
******************************************************************/
DATA GENERATE;
   DO BLOCK = 1 TO 1000;
      DO GROUP = 'A', 'B';
         IF GROUP = 'A' THEN DO SUBJ = 1 TO 6;
            X = RANNOR(123)*10 + 100;
            OUTPUT;
         END;
         ELSE IF GROUP = 'B' THEN DO SUBJ = 1 TO 8;
            X = RANNOR(123)*12 + 115;
            OUTPUT;
         END;
      END;
   END;
RUN;

***Test the distributions;
PROC MEANS DATA=GENERATE N MEAN STD;
   TITLE "Mean and Standard Deviation of the 1000 Samples";
   CLASS GROUP;
   VAR X;
RUN;

***Run 1000 t-tests and capture the p-values;
ODS LISTING CLOSE;
ODS OUTPUT TTESTS=WORK.P_VALUES;
PROC TTEST DATA=GENERATE;
   BY BLOCK;
   CLASS GROUP;
   VAR X;
RUN;
ODS OUTPUT CLOSE;
ODS LISTING;

***Examine the results;
DATA POWER_T;
   SET P_VALUES;
   IF PROBT LE .05 THEN RESULT = 'Power';
   ELSE RESULT = 'Beta';
RUN;
PROC TABULATE DATA=POWER_T;
   TITLE "Power of a t-test for assumptions of equal or unequal variance";
   CLASS VARIANCES RESULT;
   TABLES VARIANCES , (RESULT ALL)*PCTN<RESULT ALL>=' ';
RUN;
PROC CHART DATA=P_VALUES;
   TITLE "Power of a T-Test with Equal Variances";
   WHERE VARIANCES = 'Equal';
   VBAR PROBT / MIDPOINTS = 0 TO .7 BY .05;
RUN;
QUIT;

Program 9.12:  Program to generate random values of heart rates that are 
                         normally distributed
***Primary function: RANNOR;
***Other function: ROUND;

DATA GENERATE;
   SEED = 0;
   DO SUBJ = 1 TO 100;
      CALL RANNOR(SEED, HR);
      HR = ROUND(15*HR + 70);
      OUTPUT;
   END;
RUN;

OPTIONS PS=16;
PROC REPORT DATA=GENERATE PANELS=99 NOWD;
   TITLE "Listing of Data Set GENERATE";
   COLUMNS SUBJ HR;
   DEFINE SUBJ / DISPLAY WIDTH=4;
   DEFINE HR / DISPLAY WIDTH=4 FORMAT=4.0;
RUN;

Program 10.1: Using the LAGn functions to compute a moving average
***Primary functions: LAG and LAG2
***Other function: MEAN;

***Program to compute a moving average, based on three observations;
DATA MOVING;
   INPUT X @@;
   X1 = LAG(X);
   X2 = LAG2(X);
   MOVING = MEAN(X, X1, X2);
   IF _N_ GE 3 THEN OUTPUT;
DATALINES;
1 3 9 5 7 10
;
PROC PRINT DATA=MOVING NOOBS;
   TITLE "Listing of Data Set MOVING";
RUN;

Program 10.2:  Computing changes in blood pressure from one visit to 
                         another
***Primary function: DIF;
***Create a test data set of patient visits;

DATA VISITS;
   INPUT ID VISIT_DATE : MMDDYY10. SBP DBP @@;
   FORMAT VISIT_DATE DATE9.;
   LABEL SBP = 'Systolic Blood Pressure'
         DBP = 'Diastolic Blood Pressure';
DATALINES;
1 02/01/2003 180 110   1 03/02/2003 178 100   1 04/01/2003 170 90
2 03/03/2003 170 100   2 04/01/2003 172 100
3 04/01/2003 130 80    3 06/01/2003 128 82    3 08/01/2003 128 78
;
PROC SORT DATA=VISITS;
   BY ID VISIT_DATE;
RUN;

***Program to compute changes between visits;
DATA CHANGE;
   SET VISITS;
   BY ID;

   ***Delete any subject with only one visit;
   IF FIRST.ID AND LAST.ID THEN DELETE;

   DIFF_SBP = DIF(SBP);
   DIFF_DBP = DIF(DBP);
   IF NOT FIRST.ID THEN OUTPUT;
RUN;

PROC PRINT DATA=CHANGE NOOBS;
   TITLE "Listing of Data Set CHANGE";
RUN;

Program 10.3:  Computing the difference in blood pressure between the 
                         first and last visit for each patient
***Primary function: DIF;
***This example uses the data set VISITS from the example above;

DATA FIRST_LAST;
   SET VISITS;
   BY ID;
   ***Note: The DIF function is being executed conditionally.
      Be VERY careful if you do this;
   ***Delete any subject with only one visit;
   IF FIRST.ID AND LAST.ID THEN DELETE;

   IF FIRST.ID OR LAST.ID THEN DO;
      DIFF_SBP = DIF(SBP);
      DIFF_DBP = DIF(DBP);
   END;
   IF LAST.ID THEN OUTPUT;
RUN;

PROC PRINT DATA=FIRST_LAST NOOBS;
   TITLE "Listing of Data Set FIRST_LAST";
RUN;

Program 10.4:  Using the INPUT function to perform character-to-numeric 
                         conversion
***Primary function: INPUT;
***Create test data set;

DATA CHAR;
   INPUT NUM $ DATE1 : $10. DATE2 : $9. MONEY : $12.;
DATALINES;
123 10/21/1980 21OCT1980 $123,000.45
XYZ 11/11/2003 01JAN1960 $123
;
DATA CONVERT;
   SET CHAR(RENAME=(NUM=C_NUM));
   NUM = INPUT(C_NUM,9.);
   SASDATE1 = INPUT(DATE1,MMDDYY10.);
   SASDATE2 = INPUT(DATE2,DATE9.);
   DOLLAR = INPUT(MONEY,COMMA12.);
   FORMAT SASDATE1 SASDATE2 MMDDYY10.;
RUN;

PROC PRINT DATA=CONVERT NOOBS;
   TITLE "Listing of Data Set CONVERT";
RUN;

Program 10.5:  Using the INPUTC function to specify an informat at 
                         run time
***Primary function: INPUTC
***Other functions: PUT;

PROC FORMAT;
   INVALUE $CODEA 'A' = 'Chair'
                  'B' = 'Desk'
                  'C' = 'Table';
   INVALUE $CODEB 'A' = 'Office Chair'
                  'B' = 'Big Desk'
                  'C' = 'Coffee Table';
   VALUE CODE 1 = '$CODEA.'
              2 = '$CODEB.';
RUN;

DATA ITEMS;
   INPUT YEAR LETTER : $1. @@;
   LENGTH ITEM $ 12;
   ITEM = INPUTC(LETTER, PUT(YEAR, CODE.));
DATALINES;
1 A  1 B  2 A  1 C  2 C  2 B
;
PROC PRINT DATA=ITEMS NOOBS;
   TITLE "Listing of Data Set ITEMS";
RUN;

Program 10.6:  Using the INPUTN function to read dates in mixed formats
***Primary function: INPUTN
***Other function: PUT;

PROC FORMAT;
   VALUE WHICH 1 = 'MMDDYY10.'
               2 = 'DATE9.';
RUN;

DATA MIXED_DATES;
   INPUT WHICH_ONE DUMMY : $10.;
   DATE = INPUTN(DUMMY, PUT(WHICH_ONE, WHICH.));
   FORMAT DATE WEEKDATE.;
DATALINES;
1 10/21/1980
2 21OCT1980
1 01/01/1960
2 03NOV2003
;
PROC PRINT DATA=MIXED_DATES NOOBS;
   TITLE "Listing of Data Set MIXED_DATES";
RUN;

Program 10.7:  Performing a table look-up using a format and the PUT function
***Primary functions: PUT, INPUT;

PROC FORMAT;
   VALUE ITEM 1 = 'APPLE'
              2 = 'PEAR'
              3 = 'GRAPE'
              OTHER = 'UNKNOWN';
   VALUE $COST 'A' - 'C' = '44.45'
               'D'       = '125.'
               OTHER     = ' ';
RUN;

DATA TABLE;
   INPUT ITEM_NO CODE $ @@;
   ITEM_NAME = PUT(ITEM_NO, ITEM.);
   AMOUNT = INPUT(PUT(CODE, $COST.),9.);
DATALINES;
1 B   2 D   3 X   4 C
;
PROC PRINT DATA=TABLE NOOBS;
   TITLE "Listing of Data Set TABLE";
RUN;

Program 10.8:  Using the PUTC function to assign a value to a character 
                         variable at run time
***Primary function: PUTC
***Other function: PUT;

PROC FORMAT;
   VALUE $TOOL '1' = 'Hammer'
               '2' = 'Pliers'
               '3' = 'Saw';
   VALUE $SUPPLY '1' = 'Paper'
                 '2' = 'Pens'
                 '3' = 'Paperclips';
   VALUE TYPE 1 = '$TOOL.'
              2 = '$SUPPLY.';
RUN;

DATA TOOLS_SUPPLIES;
   INPUT TYPE VALUE $; 
   LENGTH NAME $ 10;
   FORMAT = PUT(TYPE, TYPE.);
   NAME = PUTC(VALUE, FORMAT);
DATALINES;
1 1
2 1
1 2
2 3
;
PROC PRINT DATA=TOOLS_SUPPLIES NOOBS;
   TITLE "Listing of Data Set TOOLS_SUPPLIES";
RUN;

Program 10.9:  Using the PUTN function to assign a value to a character 
                         variable at run time
***Primary function: PUTN;

PROC FORMAT;
   VALUE TOOL 1 = 'Hammer'
              2 = 'Pliers'
              3 = 'Saw';
   VALUE SUPPLY 1 = 'Paper'
                2 = 'Pens'
                3 = 'Paperclips';
RUN;
DATA TOOLS_SUPPLIES;
   INPUT TYPE $ VALUE;
   NAME = PUTN(VALUE, TYPE);
DATALINES;
TOOL. 1
SUPPLY. 1
TOOL. 2
SUPPLY. 2
;
PROC PRINT DATA=TOOLS_SUPPLIES NOOBS;
   TITLE "Listing of Data Set TOOLS_SUPPLIES";
RUN;

Program 11.1:  Converting FIPS codes to state names and abbreviations
***Primary functions: FIPNAME, FIPNAMEL, and FIPSTATE;

DATA FIPS;
   INPUT FIPS @@;
   UPPER_STATE = FIPNAME(FIPS);
   MIXED_STATE = FIPNAMEL(FIPS);
   ABBREV      = FIPSTATE(FIPS);
DATALINES;
1 2 3 4 5 34 . 50 95 99
;
PROC PRINT DATA=FIPS NOOBS;
   TITLE "Listing of Data Set FIPS";
RUN;

Program 11.2:  Converting state abbreviations to zip codes, FIPS codes, 
                         and state names
***Primary functions: STFIPS, STNAME, and STNAMEL;

DATA STATE_TO_OTHER;
   INPUT STATE : $2. @@;
   FIPS = STFIPS(STATE);
   UPPER_NAME = STNAME(STATE);
   MIXED_NAME = STNAMEL(STATE);
DATALINES;
NY NJ nj NC AL
;
PROC PRINT DATA=STATE_TO_OTHER NOOBS;
   TITLE "Listing of Data Set STATE_TO_OTHER";
RUN;

Program 11.3:  Converting zip codes to FIPS codes, state names, and state 
                         abbreviations
***Primary functions: ZIPFIPS, ZIPNAME, ZIPNAMEL, and ZIPSTATE;

DATA ZIP_TO_OTHER;
   INPUT ZIP @@;
   FIPS = ZIPFIPS(ZIP);
   STATE_CAPS = ZIPNAME(ZIP);
   STATE_MIXED = ZIPNAMEL(ZIP);
   STATE_ABBRE = ZIPSTATE(ZIP);
   FORMAT ZIP Z5.;
DATALINES;
1234 12345 08822 98765
;
PROC PRINT DATA=ZIP_TO_OTHER NOOBS;
   TITLE "Listing of Data Set ZIP_TO_OTHER";
RUN;

Program 11.4:  Adding a state abbreviation to an address containing only 
                         city and zip code
***Primary function: ZIPSTATE;

DATA ADDRESS;
   INPUT #1 NAME $30.
         #2 STREET $40.
         #3 CITY & $20. ZIP;
   STATE = ZIPSTATE(ZIP);

   FILE PRINT;
   ***Create Mailing list;
   PUT NAME /
       STREET /
       CITY +(-1) ", " STATE ZIP Z5.//;
DATALINES;
Mr. James Joyce
123 Sesame Street
East Rockaway  11518
Mrs. Deborah Goldstein
87 Hampton Corner Road
Flemington  08822
;

Program 12.1:  Creating a table of trigonometric functions
***Primary functions: COS, SIN, TAN
***Other function: CONSTANT;

DATA TRIG_TABLE;
   IF _N_ = 1 THEN PI = CONSTANT('PI');
   RETAIN PI;

   DO ANGLE = 0 TO 360 BY 10;
      RADIAN = PI*ANGLE/180;
      SIN = SIN(RADIAN);
      COS = COS(RADIAN);
      TAN = TAN(RADIAN);
      OUTPUT;
   END;

   DROP PI RADIAN;
RUN;

OPTIONS LS=22 MISSING='-';
PROC REPORT DATA=TRIG_TABLE NOWD PANELS=99;
   TITLE "Table of Basic Trig Functions";
   COLUMNS ANGLE SIN COS TAN;
   DEFINE ANGLE / DISPLAY 'Angle' WIDTH=5 FORMAT=4.;
   DEFINE SIN / DISPLAY 'Sin' WIDTH=6 FORMAT=6.4;
   DEFINE COS / DISPLAY 'Cos' WIDTH=6 FORMAT=6.4;
   DEFINE TAN / DISPLAY 'Tan' WIDTH=6 FORMAT=6.2;
RUN;

Program 12.2:  Computing arccosines and arcsines
***Primary functions: ARCOS and ARSIN
***Other function: CONSTANT;

DATA ARC_D_TRIUMPH;
   IF _N_ = 1 THEN PI = CONSTANT('PI');
   RETAIN PI;
   DROP PI;

   DO VALUE = 0 TO 1 BY .1;
      COS_RADIAN = ARCOS(VALUE);
      COS_ANGLE = COS_RADIAN * 180/PI;
      SIN_RADIAN = ARSIN(VALUE);
      SIN_ANGLE = SIN_RADIAN * 180/PI;
      OUTPUT;
   END;
RUN;

PROC PRINT DATA=ARC_D_TRIUMPH NOOBS;
   TITLE "Listing of Data Set ARC_D_TRIUMPH";
RUN;

Program 12.3:  Computing arctangents
***Primary function: ATAN;
***Other function: CONSTANT;

DATA ON_A_TANGENT;
   IF _N_ = 1 THEN PI = CONSTANT('PI');
   RETAIN PI;
   DROP PI;

   DO VALUE = 0 TO 10;
      TAN_RADIAN = ATAN(VALUE);
      TAN_ANGLE = TAN_RADIAN * 180/PI;
      OUTPUT;
   END;
RUN;

PROC PRINT DATA=ON_A_TANGENT NOOBS;
   TITLE "Listing of Data Set ON_A_TANGENT";
RUN;

Program 13.1:  Using the SYMPUT and SYMPUTX call routines to assign a 
                         value to a macro variable during the execution of a DATA 
                         step
***Primary functions: SYMPUT and SYMPUTX;

DATA TEST;
   INPUT STRING $CHAR10.;
   CALL SYMPUT("NOTX",STRING);
   CALL SYMPUTX("YESX",STRING);
DATALINES;
   abc         
;
DATA _NULL_;
   NOSTRIP = ":" || "&NOTX" || ":";
   STRIP   = ":" || "&YESX" || ":";
   PUT "Value of NOSTRIP is  " NOSTRIP;
   PUT "Value of STRIP is  " STRIP;
RUN;

Program 13.2:  Passing DATA step values from one step to another, using 
                         macro variables created by CALL SYMPUT and CALL 
                         SYMPUTX
***Primary functions: SYMPUT and SYMPUTX
***Other functions: STRIP and PUT;

DATA SUM;
   INFILE "C:\BOOKS\FUNCTIONS\DATA.DTA" END=LAST;
   INPUT N @@;
   SUM + N;
   COUNT + 1;
   IF LAST THEN DO;
      CALL SYMPUT("SUM_OF_N",STRIP(PUT(SUM,3.)));
      CALL SYMPUTX("NUMBER",PUT(COUNT,3.));
   END;
RUN;

PROC PRINT DATA=SUM NOOBS;
   TITLE "Listing of Data Set NEXT";
   TITLE2 "Summary data: There were &NUMBER values";
   TITLE3 "The sum was &SUM_OF_N";
   VAR N;
RUN;

Program 13.3:  Using RESOLVE to pass DATA step values to macro 
                         variables during the execution of the DATA step
***Primary function: RESOLVE;

%LET X1 = 10;
%LET X2 = 100;
%LET X3 = 1000;
DATA TEST;
   INPUT N @@;
   VALUE = RESOLVE('&X' || LEFT(PUT(N,3.)));
   PUT _ALL_;
DATALINES;
1 3 2 1
;

Program 13.4:  Using CALL EXECUTE to conditionally execute a macro
***Primary function: CALL EXECUTE;

%MACRO SIMPLE(DSN);
   PROC PRINT DATA=&DSN NOOBS;
     TITLE "Simple Listing - Today is &SYSDAY";
   RUN;
%MEND SIMPLE;

%MACRO COMPLEX(DSN);
   PROC MEANS DATA=&DSN N MEAN STD CLM MAXDEC=2;
      TITLE "Complex Statistics - Friday";
   RUN;
%MEND COMPLEX;

DATA TEST;
   INPUT X Y @@;
DATALINES;
7 5 1 2 3 4 9 8
;
DATA _NULL_;
   IF "&SYSDAY" NE "Friday" THEN CALL EXECUTE('%SIMPLE(TEST)');
   ELSE CALL EXECUTE('%COMPLEX(TEST)');
RUN;

Program 13.5: A non-macro example of CALL EXECUTE
***Primary function: CALL EXECUTE;

DATA EXECUTE;
   STRING = "PROC PRINT DATA=EXECUTE NOOBS;
   TITLE 'Listing of Data Set EXECUTE'; RUN;";
   DROP STRING;
   INFILE 'C:\BOOKS\FUNCTIONS\DATA2.DAT' END=LAST;
   INPUT X;
   IF LAST THEN CALL EXECUTE(STRING);
RUN;

Program 13.6:  Using the SYMGET function to assign a macro value to a 
                         DATA step variable
***Primary function: SYMGET
***Other function: CATS;

%LET X1 = 5;
%LET X2 = 10;
%LET X3 = 15;
DATA TEST;
   INPUT TYPE $ VALUE @@;
   MULT = SYMGET(CATS('X',TYPE));
   NEW_VALUE = MULT * VALUE;
DATALINES;
1 5  2 5  3 5
;
PROC PRINT DATA=TEST;
   TITLE "Listing of Data Set TEST";
RUN;

Program 14.1:  Program to create two SAS data sets, TEST and MISS
DATA TEST(LABEL="This is the data set label");
   LENGTH X3 4;
   INPUT @1  SUBJ     $CHAR3.
         @4  DOB    MMDDYY10.
         @14 (X1-X3)     (1.)
         @17 F_NAME   $CHAR10.
         @27 L_NAME   $CHAR15.;
   LABEL SUBJ   = 'Subject'
         DOB    = 'Date of Birth'
         X1     = 'The first X'
         X2     = 'Second X'
         X3     = 'Third X'
         F_NAME = 'First Name'
         L_NAME = 'Last Name';
   FORMAT DOB MMDDYY10. X3 ROMAN.;
DATALINES;
00110/21/1946123George    Hincappie
00211/05/1956987Pincus    Zukerman
00701/01/19903..Jose      Juarez
;

DATA MISS;
   INPUT X Y A$ Z1-Z3;
DATALINES;
1 2 abc 4 5 6
999 5 xyz 999 4 5
999 999 xxx 9 8 999
2 8 ZZZ 999 999 999
;
PROC SORT DATA=TEST;
   BY SUBJ;
RUN;
PROC PRINT DATA=TEST NOOBS LABEL;
   TITLE "Listing of Data Set TEST";
RUN;

PROC PRINT DATA=MISS NOOBS;
   TITLE "Listing of Data Set MISS";
RUN;

Program 14.2:  Macro to determine the number of observations in a SAS 
                         data set
***Primary functions: OPEN, EXIST, ATTRN, CLOSE;

%MACRO NOBS(DSN);
   IF EXIST("&DSN") THEN DO;
      DSID = OPEN("&DSN","I");
      NOBS = ATTRN(DSID,"NLOBS");
   END;
   ELSE NOBS=.;
   RC = CLOSE(DSID);
%MEND NOBS;

Using the macro:

DATA USEIT;
   %NOBS(TEST);
   PUT NOBS=;
RUN;

Program 14.3:  Determining the number of observations, variables, and 
                         other characteristics of a SAS data set using SAS I/O 
                         functions
***Primary functions: OPEN, ATTRC, ATTRN, CLOSE;

DATA _NULL_;
   DSID = OPEN ('TEST');
   ANY = ATTRN(DSID,'ANY');
   NLOBS = ATTRN(DSID,'NLOBS');
   NVARS = ATTRN(DSID,'NVARS');
   LABEL = ATTRC(DSID,'LABEL');
   ENGINE = ATTRC(DSID,'ENGINE');
   CHARSET =ATTRC(DSID,'CHARSET');
   DSN = DSNAME(DSID);
   RC = CLOSE(DSID);
   FILE PRINT;
   TITLE;
   PUT "Characteristics of Data Set Test" /
      40*'-'/
      "DSID ="    @11 DSID    /
      "ANY ="     @11 ANY     /
      "NLOBS ="   @11 NLOBS   /
      "NVARS ="   @11 NVARS   /
      "LABEL ="   @11 LABEL   /
      "ENGINE ="  @11 ENGINE  /
      "CHARSET =" @11 CHARSET /
      "DSN ="     @11 DSN     /
      "RC ="      @11 RC;
RUN;

Program 14.4:  Determining the format, label, and length attributes of a 
                         variable using the VARFMT, VARLEN, and VARNUM 
                         functions
***Primary functions: OPEN, VARFMT, VARNUM, VARLABEL, VARLEN, CLOSE;

DATA _NULL_;
   LENGTH FORMAT LABEL $ 32;
   DSID = OPEN("TEST");
   ORDER = VARNUM(DSID,"X3");
   FORMAT = VARFMT(DSID,ORDER);
   LABEL = VARLABEL(DSID,ORDER);
   LENGTH = VARLEN(DSID,ORDER);
   RC = CLOSE(DSID);
   PUT ORDER= FORMAT= LABEL= LENGTH=;
RUN;

Program 14.5:  Determining a variable name, given its position in a SAS 
                         data set and vice versa
***Primary functions: OPEN, VARNAME, VARNUM, CLOSE;

DATA _NULL_;
   ID = OPEN("TEST");
   VAR_NAME = VARNAME(ID,1);
   VAR_POS  = VARNUM(ID,"DOB");
   RC = CLOSE(ID);
   PUT "The name of the 1st variable in data set test is: " VAR_NAME /
       "The position of variable DOB is: " VAR_POS;
RUN;

Program 14.6:  A general-purpose macro to display data set attributes 
                         such as number of observations, number of variables, 
                         variable list, variable type, formats, labels, etc.
***Primary functions: EXIST, OPEN, ATTRN, ATTRC, VARNAME, VARTYPE,
                      VARLEN, VARFMT, VARLABEL, and CLOSE;

%MACRO DSN_INFO(DSN);
   DATA _NULL_;
      FILE PRINT;
      IF NOT EXIST("&DSN") THEN DO;
         PUT "Data set &DSN does not exist";
         STOP;
      END;

      DSID    = OPEN("&DSN","I");
      NVARS   = ATTRN(DSID,"NVARS");
      NOBS    = ATTRN(DSID,"NLOBS");
      CHARSET = ATTRC(DSID,"CHARSET");
      ENGINE  = ATTRC(DSID,"ENGINE");
      ENCRYPT = ATTRC(DSID,"ENCRYPT");
      LABEL   = ATTRC(DSID,"LABEL");
      SORT    = ATTRC(DSID,"SORTEDBY");


      PUT "Information for Data Set &DSN" /
          72*'-' // ;
      IF LABEL NE " " then PUT "Data set Label is: " LABEL;
      PUT "Data set created with engine: " ENGINE /
          "Character set used: " CHARSET;
      IF ENCRYPT = "YES" then PUT "Data set is encrypted";
      ELSE PUT "Data set is not encrypted";
      IF SORT = " " then PUT "Data set is not sorted";
      ELSE PUT "Data set is sorted by: " SORT /;
      PUT 
         "Number of Observations: " NOBS /
         "Number of Variables   : " NVARS /
         72*'-' /
         "***** Variable Information *****" //
         @1  "Variable Name"
         @20 "Type"
         @26 "Length"
         @34 "Format"
         @47 "Label"/
         72*'-';
      DO I = 1 TO NVARS;
         NAME = VARNAME(DSID,I);
         TYPE = VARTYPE(DSID,I);
         IF TYPE = "C" THEN TYPE = "Char";
         ELSE IF TYPE = "N" THEN TYPE = "Num";
        
         LENGTH = VARLEN(DSID,I);
         FMT = VARFMT(DSID,I);
         LABEL = VARLABEL(DSID,I);

         PUT @1    NAME
             @20   TYPE
             @26   LENGTH
             @34   FMT
             @47   LABEL;
      END;

      RC = CLOSE(DSID);
   RUN;
%MEND DSN_INFO;

Program 15.1:  Creating a test data set for use with most of the V 
                         functions
PROC FORMAT;
   VALUE YESNO 1='YES' 0='NO';
   INVALUE READ 0-5 = 777
                6-9 = 888
                OTHER = 999;
RUN;
DATA VAR;
   INFORMAT CHAR $CHAR1. Y READ2. Z 3.2 MONEY DOLLAR5.;
   INPUT @1  X       1.
         @2  CHAR   $CHAR1.
         @3  Y       READ2.
         @5  Z       3.2
         @8  MONEY   DOLLAR5.
         @13 (A1-A3) (1.)
         @16 DATE     MMDDYY10.;
   FORMAT X YESNO. MONEY DOLLAR8.2 Z 7.4;
   LABEL X = 'The X variable'
         Y = 'Pain Scale'
         MONEY = 'Housing Cost';
   ARRAY OSCAR[3] A1-A3;
DATALINES;
1B 31231,765987
0N 86549,123234
;

Program 15.2:  Determining a variable's type (numeric or character) using 
                         VTYPE and VTYPEX
***Primary functions: VTYPE, VTYPEX;

DATA CHAR_NUM;
   SET VAR;
   TYPE_X = VTYPE(X);
   TYPE_CHAR = VTYPE(CHAR);
   TYPE_A1 = VTYPEX('A' || PUT(3-2,1.));
RUN;

PROC PRINT DATA=CHAR_NUM NOOBS;
   TITLE "Listing of Data Set CHAR_NUM";
RUN;

Program 15.3:  Determining the storage length of character and numeric 
                         variables
***Primary function: VLENGTH;

DATA _NULL_;
   LENGTH Y 4 NAME $ 20;
   X = 123;
   y = 123;
   CHAR = 'ABC';
   LONG = 'This is a long character variable';
   PAD = 'A    '; ***A followed by 4 blanks;
   NAME = 'Frank';

   L_X = VLENGTH(X);
   L_Y = VLENGTH(Y);
   L_CHAR = VLENGTH(CHAR);
   L_LONG = VLENGTH(LONG);
   L_PAD = VLENGTH(PAD);
   L_NAME = VLENGTH(NAME);

   PUT L_X = / 
       L_Y = /
       L_CHAR = /
       L_LONG = /
       L_PAD = /
       L_NAME = ;
RUN;

Program 15.4:  Program to replace all numeric values of 999 with a SAS 
                         missing value and to provide a list of variable names where 
                         the changes were made
***Primary functions: VNAME, SYMPUTX
***Other functions: DIM;
***This data step determines the number of numeric
   variables in the data set and assigns it to a macro variable (N);

DATA _NULL_;
   SET MISS;
   ARRAY NUMS[*] _NUMERIC_;
   CALL SYMPUTX('N',DIM(NUMS));
   STOP;
RUN;

DATA _NULL_;
   SET MISS END=LAST;
   FILE PRINT;
   ARRAY NUMS[*] _NUMERIC_;
   LENGTH NAMES1-NAMES&N $ 32;
   ARRAY NAMES[&N];
   ARRAY HOWMANY[&N];
   RETAIN NAMES1-NAMES&N;
   DO I = 1 TO DIM(NUMS);
      IF NUMS[I] = 999 THEN DO;
         NUMS[I] = .;
         NAMES[I] = VNAME(NUMS[I]);
         HOWMANY[I] + 1;
      END;
   END;
   IF LAST THEN DO I = 1 TO &N;
      IF NAMES[I] NE ' ' THEN
      PUT HOWMANY[I] "Values of 999 converted to missing for variable " 
          NAMES[I];
   END;
RUN;

Program 15.5:  Writing a general purpose macro to replace all occurrences 
                         of a particular value (such as 999) in a SAS missing value 
                         in a SAS data set and produce a report showing the number 
                         of replacements for each variable
***Primary functions: VNAME, CALL SYMPUT
***Other functions: DIM, LEFT, PUT;

%MACRO REPLACE_MISSING (
                        DSN,       /* the SAS data set name */
                        MISS_VALUE /* the value of the missing value */
                        );
   DATA _NULL_;
      SET &DSN;
      ARRAY NUMS[*] _NUMERIC_;
      N_NUMBERS = LEFT(PUT(DIM(NUMS),5.));
      CALL SYMPUT('N',N_NUMBERS);
      STOP;
   RUN;
   DATA _NULL_;
      SET &DSN END=LAST;
      FILE PRINT;
      ARRAY NUMS[*] _NUMERIC_;
      ARRAY NAMES[&N] $ 32 _TEMPORARY_ ;
      ARRAY HOWMANY[&N] _TEMPORARY_;
      DO I = 1 TO DIM(NUMS);
         IF NUMS[I] = &MISS_VALUE THEN DO;
            NUMS[I] = .;
            NAMES[I] = VNAME(NUMS[I]);
            HOWMANY[I] + 1;
         END;
      END;
      IF LAST THEN DO I = 1 TO &N;
         IF NAMES[I] NE ' ' THEN
         PUT HOWMANY[I] 
            "Values of &MISS_VALUE converted to missing for variable " NAMES[I];
      END;
   RUN;
%MEND REPlACE_MISSING;

Program 15.6:  Determining the name, type, and length of all variables in a 
                         SAS data set
***Primary function: CALL VNEXT;

DATA VAR_INFO;
   IF 0 THEN SET VAR;
   LENGTH VAR_NAME $ 32 VAR_TYPE $ 1;
   DO UNTIL (VAR_NAME = ' ');
      CALL VNEXT(VAR_NAME,VAR_TYPE,VAR_LENGTH);
      IF VAR_NAME NE ' ' THEN OUTPUT;
   END;
   KEEP VAR_:;
RUN;

PROC PRINT DATA=VAR_INFO NOOBS;
   TITLE "Listing of Data Set VAR_INFO";
RUN;

Program 15.7:  Demonstrating a variety of SAS V functions
***Primary functions: VFORMAT, VFORMATD, VFORMATN, VFORMATW, VINFORMAT, ***VINFORMATD, VINFORMATN, VINFORMATW, VLABEL;

DATA VFUNC;
   SET VAR(OBS=1);
   LENGTH VFORMAT_X VFORMAT_Y VFORMAT_CHAR VFORMAT_MONEY 
          VFORMATN_X VFORMATN_Y VFORMATN_CHAR VFORMATN_MONEY $8.
          VINFORMAT_X VINFORMAT_Y VINFORMAT_CHAR VINFORMAT_MONEY 
          VINFORMATN_X VINFORMATN_Y VINFORMATN_CHAR VINFORMATN_MONEY $8.
          VLABEL_X VLABEL_Y VLABEL_CHAR VLABEL_MONEY $ 40;

   ***Format functions;
   VFORMAT_X = VFORMAT(X);
   VFORMAT_Y = VFORMAT(Y);
   VFORMAT_CHAR = VFORMAT(CHAR);
   VFORMAT_MONEY = VFORMAT(MONEY);
   VFORMATN_X = VFORMATN(X);
   VFORMATN_Y = VFORMATN(Y);
   VFORMATN_CHAR = VFORMATN(CHAR);
   VFORMATN_MONEY = VFORMATN(MONEY);
   VFORMATW_X = VFORMATW(X);
   VFORMATW_Y = VFORMATW(Y);
   VFORMATW_CHAR = VFORMATW(CHAR);
   VFORMATW_MONEY = VFORMATW(MONEY);
   VFORMATD_X = VFORMATD(X);
   VFORMATD_Y = VFORMATD(Y);
   VFORMATD_CHAR = VFORMATD(CHAR);
   VFORMATD_MONEY = VFORMATD(MONEY);
   
   ***Informat functions;
   VINFORMAT_X = VINFORMAT(X);
   VINFORMAT_Y = VINFORMAT(Y);
   VINFORMAT_CHAR = VINFORMAT(CHAR);
   VINFORMAT_MONEY = VINFORMAT(MONEY);
   VINFORMATN_X = VINFORMATN(X);
   VINFORMATN_Y = VINFORMATN(Y);
   VINFORMATN_CHAR = VINFORMATN(CHAR);
   VINFORMATN_MONEY = VINFORMATN(MONEY);
   VINFORMATW_X = VINFORMATW(X);
   VINFORMATW_Y = VINFORMATW(Y);
   VINFORMATW_CHAR = VINFORMATW(CHAR);
   VINFORMATW_MONEY = VINFORMATW(MONEY);
   VINFORMATD_X = VINFORMATD(X);
   VINFORMATD_Y = VINFORMATD(Y);
   VINFORMATD_CHAR = VINFORMATD(CHAR);
   VINFORMATD_MONEY = VINFORMATD(MONEY);

   ***Label information;
   VLABEL_X = VLABEL(X);
   VLABEL_Y = VLABEL(Y);
   VLABEL_CHAR = VLABEL(CHAR);
   VLABEL_MONEY = VLABEL(MONEY);
RUN;

PROC PRINT DATA=VFUNC NOOBS HEADING=H;
   TITLE "Listing of Data Set VFUNC";
   VAR V:;
RUN;

Program 16.1: Demonstrating the bitwise logical functions
***Primary functions: BAND, BNOT, BOR, BXOR;

DATA _NULL_;
   TITLE "Demonstrating the Bitwise Logical Functions";
   FILE PRINT;
   INPUT @1  X BINARY4. /
         @1  Y BINARY4. /
         @1 AFRAID BINARY8.;

   AND = BAND(X,Y);
   NOT = BNOT(AFRAID); ***Get it, Be not afraid?;
   OR  = BOR(X,Y);
   XOR = BXOR(X,Y);
   FORMAT X Y AND OR XOR BINARY4.
          AFRAID NOT BINARY8.;
   PUT X= Y= AFRAID= / 60*'-' //
       AND= OR= XOR= NOT=;
DATALINES;
0101
1100
11110000
;

Program 16.2: Enciphering and deciphering text using a key
***Primary functions: BXOR, RANK, BYTE
***Other functions: SUBSTR (used on both sides of the equal sign), DIM;

DATA ENCODE;
   ARRAY L[5] $ 1;
   ARRAY NUM[5];
   ARRAY XOR[5];
   RETAIN KEY 173;
   INPUT STRING $CHAR5.;
   DO I = 1 TO DIM(L);
      L[I] = SUBSTR(STRING,I,1);
      NUM[I] = RANK(L[I]);
      XOR[I] = BXOR(NUM[I],KEY);
   END;
   KEEP XOR1-XOR5;
DATALINES;
ABCDE
Help
;
PROC PRINT DATA=ENCODE NOOBS;
   TITLE "Encoded Message";
   VAR XOR1-XOR5;
RUN;

DATA DECODE;
   ARRAY L[5] $ 1;
   ARRAY NUM[5];
   ARRAY XOR[5];
   RETAIN KEY 173;
   LENGTH STRING $ 5;
   SET ENCODE;
   DO I = 1 TO DIM(L);
      NUM[I] = BXOR(XOR[I],KEY);
      L[I] = BYTE(NUM[I]);
      SUBSTR(STRING,I,1) = L[I];
   END;
   DROP I;
RUN;

PROC PRINT DATA=DECODE NOOBS;
   TITLE "Decoding Output";
   VAR STRING;
RUN;

Program 16.3:  Writing general purpose encrypting and decrypting macros
***Primary functions: BXOR, RANK, BYTE
***Other functions: SUBSTR (used on the left-hand side of the equal sign), DIM, RANUNI;

%MACRO ENCODE(DSN,        /* Name of the SAS data set to hold the
                             encrypted message */
              FILE_NAME,  /* The name of the raw data file that holds
                             the plain text */
              KEY         /* A number of your choice which will be the 
                             seed for the random number generator. A 
                             large number is preferable */
              );
   %LET LEN = 80;
   DATA &DSN;
      ARRAY L[&LEN] $ 1 _TEMPORARY_; /* Each element holds a character 
                                        of plain text */
      ARRAY NUM[&LEN] _TEMPORARY_;   /* A numerical equivalent for each
                                        letter */
      ARRAY XOR[&LEN];               /* The coded value of each letter */
      RETAIN KEY &KEY;
      INFILE "&FILE_NAME" PAD;
      INPUT STRING $CHAR&LEN..;
      DO I = 1 TO DIM(L);
         L[I] = SUBSTR(STRING,I,1);
         NUM[I] = RANK(L[I]);
         XOR[I] = BXOR(NUM[I],RANUNI(KEY));
      END;
      KEEP XOR1-XOR&LEN;
   RUN;
%MEND ENCODE;

%MACRO DECODE(DSN,        /* Name of the SAS data set to hold the
                             encrypted message */
              KEY         /* A number that must match the key of
                             the enciphered message */
              );
   %LET LEN = 80;
   DATA DECODE;
      ARRAY L[&LEN] $ 1 _TEMPORARY_;
      ARRAY NUM[&LEN] _TEMPORARY_;
      ARRAY XOR[&LEN];
      RETAIN KEY &KEY;
      LENGTH STRING $ &LEN;
      SET &DSN;
      DO I = 1 TO DIM(L);
         NUM[I] = BXOR(XOR[I],RANUNI(KEY));
         L[I] = BYTE(NUM[I]);
         SUBSTR(STRING,I,1) = L[I];
      END;
      DROP I;
   RUN;
   PROC PRINT DATA=DECODE NOOBS;
      TITLE "Decoding Output";
      VAR STRING;
   RUN;
%MEND DECODE;



