/*------------------------------------------------------------------- */
 /*            SAS Functions by Example, Second Edition               */
 /*                      by Ron Cody                                  */
 /*       Copyright(c) 2010 by SAS Institute Inc., Cary, NC, USA      */
 /*                   SAS Publications order # 62857                  */
 /*                        ISBN 978-1-60764-340-1                     */
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
 /* SAS Press                                                         */
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





***Programs used in "Functions by Example.";
* Program 1.1: How SAS determines storage lengths of character variables;
data example1;
   input Group $ 
     @10 String $3.;
   Left  = 'x    '; *x and 4 blanks;
   Right = '    x'; *4 blanks and x;
   Sub = substr(Group,1,2);
   Rep = repeat(Group,1);
datalines;
ABCDEFGH 123
XXX        4
Y        5
;

* Program 1.2: Running PROC CONTENTS to determine storage lengths;
title "PROC CONTENTS for Data Set EXAMPLE1";
proc contents data=example1 varnum;
run;

* Program 1.3:  Changing lowercase to uppercase for all character variables 
                       in a data set;
***Primary function: UPCASE;
***Other function: DIM;

data mixed;
   length a b c d e $ 1;
   input a b c d e x y;
datalines;
M f P p D 1 2
m f m F M 3 4
;
data upper;
   set mixed;
   array all_c[*] _character_;
   do i = 1 to dim(all_c);
      all_c[i] = upcase(all_c[i]);
   end;
   drop i;
run;

title 'Listing of Data Set UPPER';
proc print data=upper noobs;
run;

* Program 1.4:  Program to demonstrate the LOWCASE function;
***Primary function: LOWCASE;

data wt;
   Input ID : $3. Unit : $1. Weight;
   Unit = lowcase(Unit);
   if Unit eq 'k' then Wt_lbs = 2.2*Weight;
   else if Unit = 'l' then Wt_lbs = Weight;
datalines;
001 k 100
002 K 101
003 L 201
004 l 166
;
title "Listing of Data Set WT";
proc print data=wt noobs;
run;

* Program 1.5:  Capitalizing the first letter of each word in a string;
***Primary function: PROPCASE;

data proper;
   input Name $60.;
   Name = propcase(Name);
datalines;
ronald cODy
THomaS eDISON
albert einstein
;
title "Listing of Data Set PROPER";
proc print data=proper noobs;
run;

* Program 1.6:  Prpgram to capitalize the first letter of each
                word in a string;
***Primary function: PROPCASE;
***Other functions: CATX;
***First and last name are two separate variables.;

data proper;
   informat First Last $30.;
   input First Last;
   length Name $ 60;
   Name =  catx(' ', First, Last);
   Name = propcase(Name);
datalines;
ronald cODy
THomaS eDISON
albert einstein
;
title "Listing of Data Set PROPER";
proc print data=proper noobs;
run;

* Program 1.7:  Using the COMPBL function to convert multiple blanks to a 
                single blank;
data squeeze;
   input #1 @1  Name    $20.
         #2 @1  Address $30.
         #3 @1  City    $15.
            @20 State    $2.
            @25 Zip      $5.;
   Name = compbl(Name);
   Address = compbl(Address);
   City = compbl(City);
datalines;
Ron Cody
89 Lazy Brook Road
Flemington         NJ   08822
Bill     Brown
28   Cathy   Street
North   City       NY   11518
;
title 'Listing of Data Set SQUEEZE';
proc print data=squeeze;
   id Name;
   var Address City State Zip;
run;

* Program 1.8:  Removing dashes and parentheses from phone numbers;
***Primary function: COMPRESS;

data phone_number;
   input Phone $ 1-15;  
   Phone1 = compress(Phone);
   Phone2 = compress(Phone,'(-) ');
   Phone3 = compress(Phone,,'kd');
datalines;
(908)235-4490
(201) 555-77 99
;
Title 'Listing of Data Set PHONE_NUMBER';
proc print data=phone_number;
run;

* Program 1.9:  Converting social security numbers from character to 
                ic;
***Primary function: COMPRESS;
***Other function:  INPUT;

data social;
   input @1 SS_char $11.
         @1 Mike_Zdeb comma11.;
   SS_numeric = input(compress(SS_char,'-'),9.);
   SS_formatted = SS_numeric;
   format SS_formatted ssn.;
datalines;
123-45-6789
001-11-1111
;
title "Listing of Data Set SOCIAL";
proc print data=social noobs;
run;

* Program 1.10: Counting the number of numerals in a string;
***Primary functions: COMPRESS, LENGTHN;

data count;
   input String $20.;
   Only_letters = compress(String,,'d');
   Num_numerals = lengthn(String) - lengthn(Only_letters);
datalines;
ABC123XYZ
XXXXX
12345
1234X
;
title "Listing of Data Set COUNT";
proc print data=count noobs;
run;

* Program 1.11:  Demonstrating the "ANY" character functions;
***Primary functions: ANYALNUM, ANYALPHA, ANYDIGIT, ANYPUNCT,
   ANYSPACE, ANYUPPER, and ANYLOWER;

data anywhere;
   input String $char20.;
   Alpha_num   = anyalnum(String);
   Alpha_num_9 = anyalnum(String,-999);
   Alpha       = anyalpha(String);
   Alpha_5     = anyalpha(String,-5);
   Digit       = anydigit(String);
   Digit_9     = anydigit(String,-999);
   Punct       = anypunct(String);
   Space       = anyspace(String);
   Up          = anyupper(String);
   Low         = anylower(String);
datalines;
Once upon a time 123 
HELP!
987654321
UPPER and lower
;
title "Listing of Data Set ANYWHERE";
proc print data=anywhere noobs heading=h;
run;

* Program 1.12:  Using the functions ANYDIGIT and ANYSPACE to find the 
                         first number in a string;
***Primary functions: ANYDIGIT and ANYSPACE;
***Other functions: INPUT and SUBSTR;

data search_num;
   input String $60.;
   Start = anydigit(String);
   End = anyspace(String,Start);
   if Start then
      Num = input(substr(String,Start,End-Start),9.);
datalines;
This line has a 56 in it
two numbers 123 and 456 in this line
No digits here
;
title "Listing of Data Set SEARCH_NUM";
proc print data=search_num noobs;
run;

* Program 1.13:  Demonstrating the "NOT" character functions;
***Primary functions: NOTALNUM, NOTALPHA, NOTDIGIT, NOTUPPER, and NOTLOWER;

data negative;
   input String $5.;
   Not_alpha_numeric = notalnum(String);
   Not_alpha         = notalpha(String);
   Not_digit         = notdigit(String);
   Not_upper         = notupper(String);
   Not_lower         = notlower(String);
datalines;
ABCDE
abcde
abcDE
12345
:#$%&
ABC
;
title "Listing of Data Set NEGATIVE";
proc print data=negative noobs;
run;

* Program 1.14: Using the FIND and FINDC functions to search for strings 
               and characters;
***Primary functions: FIND and FINDC;

data find_vowel;
   input @1 String $20.;
   Pear = find(String,'pear');
   Pos_vowel = findc(String,'aeiou','i');
   Upper_vowel = findc(String,'AEIOU');
   Not_vowel = findc(String,'aeiou','ik');
datalines;      
XYZABCabc
XYZ
Apple and Pear
;
title "Listing of Data Set FIND_VOWEL";
proc print data=find_vowel noobs;
run;

* Program 1.15:  Converting numeric values of mixed units (e.g., kg and lbs) 
                 to a single numeric quantity;
***Primary functions: COMPRESS, FINDC, INPUT;
***Other function: ROUND;

data heavy;
   input Char_wt $ @@;
   Weight = input(compress(Char_wt,,'kd'),8.);
   if findc(Char_wt,'k','i') then Weight = 2.22 * Weight;
   Weight = round(Weight);
datalines;
60KG 155 82KG 54kg 98
;
title "Listing of Data Set HEAVY";
proc print data=heavy noobs;
   var Char_wt Weight;
run;

* Program 1.16:  Searching for one of several characters in a character 
                 variable;
***Primary function: FINDC;

data check;
   input Tag_number $ @@;
   ***if the Tag number contains an x, y, or z, it indicates
      an international destination, otherwise, the destination
      is domestic;
   if findc(tag_number,'xyz','i') then 
      Destination = 'International';
   else Destination = 'Domestic';
datalines;
T123 ty333 1357Z UZYX 888 ABC
;
title "Listing of Data Set CHECK";
proc print data=check noobs;
   id Tag_number;
   var Destination;
run;

* Program 1.17: Demonstrating the o modifier with FINDC;
***Primary function: FINDC;

data o_modifier;
   input String      $15. 
         @16 Look_for $1.;
   Position = findc(String,Look_for,'io');
datalines;
Capital A here A
Lower a here   X
Apple          B
;
title "Listing of Data Set O_MODIFIER";
proc print data=o_modifier noobs heading=h;
run;

* Program 1.18: Searching for a word using the FINDW function;
***Primary functions: FIND and FINDW;

data find_word;
   input String $40.;
   Position_w = findw(String,"the");
   Position   = find(String,"the");
datalines;
there is a the in this line
ends in the
ends in the.
none here
;
title "Listing of Data Set FIND_WORD";
proc print data=find_word;
run;

* Program 1.19: Reading dates in a mixture of formats;
***Primary function: INDEXC;
***Other function: INPUT;

***Program to read mixed dates;
data mixed_dates;
   input @1 Dummy $15.;
   if indexc(dummy,'/-:') then Date = input(Dummy,mmddyy10.);
   else Date = input(Dummy,date9.);
   format Date worddate.;
datalines;
10/21/1946
06JUN2002
5-10-1950
7:9:57
;
title "Listing of Data Set MIXED_DATES";
proc print data=mixed_dates noobs;
run;

* Program 1.20:  Using the VERIFY function to check for invalid character 
                         data values;
***Primary function: VERIFY;

data very_fi;
   input ID     $ 1-3
         Answer $ 5-9;
   P = verify(Answer,'ABCDE');
   OK = P eq 0;
datalines;
001 ACBED
002 ABXDE
003 12CCE
004 ABC E
;
title "listing of Data Set VERY_FI";
proc print data=very_fi noobs;
run;

* Program 1.21:  Extracting portions of a character value and creating a 
                 character variable and a numeric value;
***Primary function: SUBSTR;
***Other function: INPUT;

data substring;
   input ID $ 1-9;
   length State $ 2;
   State = ID;
   Num = input(substr(ID,7,3),3.);
datalines;
NYXXXX123
NJ1234567
;
title 'Listing of Data Set SUBSTRING';
proc print data=substring noobs;
run;

* Program 1.22:  Extracting the last two characters from a string, regardless 
                 of the length;
***Primary functions: LENGTH, SUBSTR;

data extract;
   input @1 String $20.;
        Last_two = substr(String,length(String)-1,2);
datalines;
ABCDE
AX12345NY
126789
;
title "Listing of Data Set EXTRACT";
proc print data=extract noobs;
run;

* Program 1.23: Using the SUBSTR function to "unpack" a string;
***Primary function: SUBSTR;
***Other functions: INPUT;

data pack;
   input String $ 1-5;
datalines;
12345
8 642
;
data unpack;
   set pack;
   array x[5];
   do j = 1 to 5;
      x[j] = input(substr(String,j,1),1.);
   end;
   drop j;
run;
title "Listing of Data Set UNPACK";
proc print data=unpack noobs;
run;

* Program 1.24:  Demonstrating the SUBSTR function on the left-hand side 
                         of the equal sign;
***Primary function: SUBSTR;
***Other function: PUT;

data stars;
   input SBP DBP @@;
   length SBP_chk DBP_chk $ 4;
   SBP_chk = put(SBP,3.);
   DBP_chk = put(DBP,3.);
   if SBP gt 160 then substr(SBP_chk,4,1) = '*';
   if DBP gt 90 then substr(DBP_chk,4,1) = '*';
datalines;
120 80 180 92 200 110
;
title "Listing of data set STARS";
proc print data=stars noobs;
run;

* Program 1.25: Demonstrating the unique features of the SUBSTRN 
                function;
***Primary function: SUBSTRN;

title "Demonstrating the SUBSTRN Function";
data hoagie;
   String = 'abcdefghij';
   length Result $5.;
   Result = substrn(String,2,5);
   Sub1 = substrn(String,-1,4);
   Sub2 = substrn(String,3,0);
   Sub3 = substrn(String,7,5);
   Sub4 = substrn(String,0,2);
   file print;
   put "Original string ="      @25 String  /
       "Substrn(string,2,5) ="  @25 Result  /
       "Substrn(string,-1,4) =" @25 Sub1    /
       "Substrn(string,3,0) ="  @25 Sub2    /
       "Substrn(string,7,5) ="  @25 Sub3    /
       "Substrn(string,0,2) ="  @25 Sub4;
run;

* Program 1.26: Demonstrating the CHAR function;

***Primary functions: CHAR, FIRST;
data char;
   String = "ABC123";
   First = char(String,1);
   Length = lengthc(First);
   Second = char(String,2);
   Beyond = char(String,9);
   L_Beyond = lengthc(Beyond);
run;
title"Demonstrating the CHAR function";
proc print data=char noobs;
run;

* Program 1.27: Demonstrating the FIRST function;
***Primary function: FIRST;
data names;
   input (First Middle Last)(: $10.);
   Initials = first(First) || first(Middle) || first(Last);
datalines;
Brian Page Watson
Sarah Ellen Washington
Nelson W. Edwards
;
title "Listing of data set NAMES";
proc print data=names noobs;
run;

* Program 1.28: Demonstrating the three concatenation call routines;
***Primary functions: CAT, CATS, CATT, CATX, CATQ;

***Primary functions: CALL CATS, CALL CATT, CALL CATX;

data call_cat;
   String1 = "ABC";       * no spaces;
   String2 = "DEF   ";    * three trailing spaces;
   String3 = "   GHI";    * three leading spaces;
   String4 = "   JKL   "; * three leading and trailing spaces;
   length Result1 - Result4 $ 20;
   call cats(Result1,String2,String4);
   call catt(Result2,String2,String1);
   call catx(" ",Result3,String1,String3);
   call catx(",",Result4,String3,String4);
run;
title "Listing of Data Set CALL_CAT";
proc print data=call_cat noobs;
run;

* Program 1.29: Demonstrating the five concatenation functions;
***Primary functions: CAT, CATS, CATT, CATX;

title "Demonstrating the CAT functions";
data _null_;
   file print;
   String1 = "ABC";       * no spaces;
   String2 = "DEF   ";    * three trailing spaces;
   String3 = "   GHI";    * three leading spaces;
   String4 = "   JKL   "; * three leading and trailing spaces;
   length Join1 - Join10 $ 20;
   Join1 = cat(String2,String3);
   Join2 = cats(String2,String4);
   join3 = cats(12,34,56);
   Join4 = catt(String2,String1);
   Join5 = catx(" ",String1,String3);
   Join6 = catx(",",String3,String4);
   Join7 = catx("-",908,782,6562);
   Join8 = catq(" ",String1,String3);
   Join9 = catq("a",String1,String3);
   Join10 = catq("as",String1,String3);
   S1 = ':' || String1 || ':';
   S2 = ':' || String2 || ':';
   S3 = ':' || String3 || ':';
   S4 = ':' || String4 || ':';
   put /"String 1 " S1/ 
   "String 2 " S2/
   "String 3 " S3/
   "String 4 " S4/
   Join1= / 
   Join2= / 
   Join3= / 
   Join4= / 
   Join5= / 
   Join6= / 
   Join7= / 
   Join8= / 
   Join9= / 
   Join10= / ;
run;

* Program 1.30:  Left-aligning text values from variables read with the 
                 $CHAR informat;
***Primary function: LEFT;

data lead_on;
   input String $char15.;
   Left_string = left(String);
datalines;
ABC
   XYZ
  Ron Cody
;
title "Listing of Data Set LEAD_ON";
proc print data=lead_on noobs;
   format String Left_string $quote.;
run;

* Program 1.31: Right-aligning text values;
***Primary function: RIGHT;

data right_on;
   input String $char10.;
   Right_string = right(String);
datalines;
   ABC
   123 456
Ron Cody
;
title "Listing of Data Set RIGHT_ON";
proc print data=right_on noobs;
   format String Right_string $quote.;
run;

* Program 1.32:  Creating a program to concatenate first, middle, and last 
                         names into a single variable;
***Primary function: TRIM;

data put_together;
   length Name $ 45;
   informat Name1-Name3 $15.;
   infile datalines missover;
   input Name1 Name2 Name3;
   Name = trim(Name1) || ' ' || trim(Name2) || ' ' || Name3;
   Without = Name1 || Name2 || Name3;
   keep Name Without;
datalines;
Ronald Cody
Julia     Child
Henry    Ford
Lee Harvey Oswald
;
title "Listing Of Data Set PUT_TOGETHER";
proc print data=put_together noobs;
run;

* Program 1.33:  Demonstrating the difference between the TRIM and TRIMN 
                 functions;
***Primary functions: TRIM, TRIMN, and LENGTHC;
***Other function: COMPRESS;

data all_the_trimmings;
   A = "AAA";
   B = "BBB";
   Length_ab = lengthc(A || B);
   Length_ab_trim = lengthc(trim(A) || trim(A));
   Length_ab_trimn = lengthc(trimn(A) || trimn(B));
   Length_null = lengthc(compress(A,"A") || compress(B, "B"));
   Length_null_trim = lengthc(trim(compress(A,"A")) || 
                      trim(compress(B,"B")));
   Length_null_trimn = lengthc(trimn(compress(A,"A")) || 
                       trimn(compress(B,"B")));
   put A= B= /
       Length_ab= Length_ab_trim= Length_ab_trimn= /
       Length_null= Length_null_trim= Length_null_trimn=;
run;

* Program 1.34:  Using the STRIP function to strip both leading and trailing 
                 blanks from a string;
***Primary function: STRIP;

data _null_;
   One = "   ONE   "; ***note: three leading and trailing blanks;
   Two = "   TWO   "; ***note: three leading and trailing blanks;
   Cat_no_strip = ":" || One || "-" || Two || ":";
   Cat_strip    = ":" || strip(One) || "-" || strip(Two) || ":";
   put One= Two= / Cat_no_strip= / Cat_strip=;
run;

* Program 1.35: Comparing two strings using the COMPARE function;
***Primary function: COMPARE;
***Other function: UPCASE;

data compare;
   input @1 String1 $char3.
         @5 String2 $char10.;
   if upcase(String1) = upcase(String2) then Equal = 'Yes';
   else Equal = 'No';
   if upcase(String1) =: upcase(String2) then Colon = 'Yes';
   else Colon = 'No';
   Compare = compare(String1,String2);
   Compare_il = compare(String1,String2,'il');
   Compare_il_colon = compare(String1,String2,'il:');
datalines;
Abc    ABC
abc ABCDEFGH
123 311
;

title "Listing of Data Set COMPARE";
proc print data=compare noobs;
run;

* Program 1.36: Using the COMPGED function with a SAS n-literal;
***Primary function: COMPGED;

options validvarname=any;

data n_literal;
   String1 = "'Invalid#'n";
   String2 = 'Invalid';
   Comp1 = compged(String1,String2);
   Comp2 = compged(String1,String2,'n:');
run;

title "Listing of Data Set N_LITERAL";
proc print data=n_literal noobs;
run;

* Program 1.37:  Demonstration of the generalized edit distance (COMPGED) 
                 and Levenshtein  edit distance (COMPLEV) functions;
***Primary functions: COMPGED and COMPLEV;

title "Demonstrating COMPGED and COMPLEV functions";
data _null_;
   input @1  String1 $char10.
         @11 String2 $char10.;
   file print;
   put "Function COMPGED";
   Distance = compged(String1, String2);
   Ignore_case = compged(String1, String2, 'i');
   Lead_blanks = compged(String1, String2, 'l');
   Case_trunc = compged(String1, String2, ':i');
   Max = compged(String1, String2, 250);
   put String1= String2= /
       Distance= Ignore_case= Lead_blanks= Case_trunc= Max= /;

   put "Function COMPLEV";
   Distance = complev(String1, String2);
   Ignore_case = complev(String1, String2, 'i');
   Lead_blanks = complev(String1, String2, 'l');
   Case_trunc = complev(String1, String2, ':i');
   Max = complev(String1, String2, 3);
   put String1= String2= /
       Distance= Ignore_case= Lead_blanks= Case_trunc= Max= /;
datalines;
SAME      SAME
cAsE      case
Longer    Long
abcdef    xyz
   lead   lead
;
 
* Program 1.38:  Changing the effect of the call to COMPCOST on the result 
                 from COMPGED;
***Primary functions: CALL COMPCOST and COMPGED;

title "Program without Call to COMPCOST";
data _null_;
   input @1  String1 $char10.
         @11 String2 $char10.;
   Distance = compged(String1, String2);
   put String1= String2= /
       Distance=;
datalines;
Ron       Run
ABC       AB
;

title "Program with Call to COMPCOST";
data _null_;
   input @1  String1 $char10.
         @11 String2 $char10.;
   if _n_ = 1 then call compcost('append=',33);
   Distance = compged(String1, String2);
   put String1= String2= /
       Distance=;
datalines;
Ron       Run
ABC       AB
;

* Program 1.39:  Fuzzy matching on names using the SOUNDEX function;
***Primary function: SOUNDEX;
***Prepare data sets FILE_1 and FILE_2 to be used in the match;

data file_1;
   input @1  Name  $10.
         @11 X       1.;
   Sound_1 = soundex(Name);
datalines;
Friedman  4
Shields   1
MacArthur 7
ADAMS     9
Jose      5
Lundquist 9
;
data file_2;
   input @1  Name  $10.
         @11 Y       1.;
   Sound_2 = soundex(Name);
datalines;
Freedman  5
Freidman  9
Schields  2
McArthur  7
Adams     3
Jones     6
Londquest 9
;
***PROC SQL is used to create a Cartesian Product, combinations of all
   the names in one data set against all the names in the other.

   If you are not familiar with a Cartesian Product, run the
   PROC SQL code below without the WHERE clause.  Note that
   the size of the resulting table is the number of rows in 
   one table times the number of rows in the other table.  With
   "real" data sets the resulting table would most likely be very
   large.;

proc sql;
   create table possible as
   select file_1.name as Name1, X, 
          file_2.name as Name2, Y
   from file_1 ,file_2
   where Sound_1 eq Sound_2;
quit;

title "Possible Matches between two files";
proc print data=possible noobs;
run;

* Program 1.40:  Using the SPEDIS function to match social security 
                 numbers that are the same or differ by a small amount;
***Primary function: SPEDIS;

data first;
   input ID_1 : $2. SS : $11.;
datalines;
1A 123-45-6789
2A 111-45-7654
3A 999-99-9999
4A 222-33-4567
;
data second;
   input ID_2 : $2. SS : $11.;
datalines;
1B 123-45-6789
2B 111-44-7654
3B 899-99-9999
4B 989-99-9999
5B 222-22-5467
;
%let Cutoff = 10;
title "Output from SQL when CUTOFF is set to &CUTOFF";
proc sql;
   select ID_1,
          First.SS as First_SS, 
          ID_2,
          Second.SS as Second_SS
   from first, second
   where spedis(First.SS, Second.SS) le &Cutoff;
quit;

* Program 1.41:  Fuzzy matching on names using the spelling distance 
                (SPEDIS) function;
***Primary function: SPEDIS;
***Other function: PROPCASE;

data file_1;
   input @1  Name  $10.
         @11 X       1.;
datalines;
Friedman  4
Shields   1
MacArthur 7
ADAMS     9
Jose      5
Lundquist 9
;
data file_2;
   input @1  Name  $10.
         @11 Y       1.;
datalines;
Freedman  5
Freidman  9
Schields  2
McArthur  7
Adams     3
Jones     6
Londquest 9
;
***PROC SQL is used to create a Cartesian Product, combinations of all
   the names in one data set against all the names in the other.;

proc sql;
   create table possible as
   select file_1.name as Name1, X, 
          file_2.name as Name2, Y
   from file_1 ,file_2
   where spedis(propcase(Name1),propcase(Name2)) le 15
         and spedis(propcase(Name1),propcase(Name2)) ne 0;
quit;

title "Possible Matches between two files";
proc print data=possible noobs;
run;

* Program 1.42:  A novel use of the SCAN function to convert mixed 
                 numbers to decimal values;
***Primary function: SCAN;
***Other function: INPUT;

data prices;
   input @1 Stock $3.
         @5 Mixed $6.;
   Integer = scan(Mixed,1,'/ ');
   Numerator = scan(Mixed,2,'/ ');
   Denominator = scan(Mixed,3,'/ ');
   if missing(Numerator) then Value = input(Integer,8.);
   else Value = input(Integer,8.) + 
                (input(Numerator,8.) / input(Denominator,8.));
   keep Stock Mixed Value;
datalines;
ABC 14 3/8
XYZ 8
TWW 5 1/8
;
title "Listing of Data Set PRICES";
proc print data=prices noobs;
run;

* Program 1.43: Program to read a tab-delimited file;
***Primary function: SCAN;

data read_tabs;
   infile 'c:\books\functions\tab_file.txt' pad;
   input @1 String $30.;
   length First Middle Last $ 12;
   First = scan(String,1,' ','h');
   Middle = scan(String,2,' ','h');
   Last = scan(String,3,' ','h');
   drop String;
run;
title "Listing of Data Set READS_TABS";
proc print data=read_tabs noobs;
run;

* Program 1.44:  Alphabetical listing by last name when the name field 
                 contains first name, possibly middle initial, and last name;
***Primary function: SCAN;

***Making the problem a little harder.  Extracting the last name
   when there may or may not be a middle initial;

data first_last;
   input @1  Name  $20.
         @21 Phone $13.;
   ***extract the last name from name;
   Last_name = scan(Name,-1,' '); /* scans from the right */
datalines;
Jeff W. Snoker      (908)782-4382
Raymond Albert      (732)235-4444
Steven J. Foster    (201)567-9876
Jose Romerez        (516)593-2377
;
title "Names and Phone Numbers in Alphabetical Order (by Last Name)";
proc report data=first_last nowd;
   columns Name Phone Last_name;
   define Last_name / order noprint width=20;
   define Name      / display 'Name' left width=20;
   define Phone     / display 'Phone Number' width=13 format=$13.;
run;

* Program 1.45: Demonstrating the SCAN call routine;
***Primary function: CALL SCAN;

data words;
   input String $40.;
   Delim = 'Default';
   N = 2;
   call scan(String,N,Position,Length);
   output;
   N = -1;
   call scan(String,N,Position,Length);
   output;
   Delim = '#';
   N = 2;
   call scan(String,N,Position,Length,'#');
   output;
datalines;
ONE TWO THREE
One*#Two Three*Four
;
title "Listing of Data Set WORDS";
proc print data=words noobs;
run;

* Program 1.46: Using CALL SCAN to count the words in a string;
***Primary function: CALL SCAN;

data count;
   input String $40.;
   do i = 1 to 99 until (Length eq 0);
      call scan(String,i,Position,Length);
   end;
   Num_words = i-1;
   drop Position Length i;
datalines;
ONE TWO THREE
ONE TWO
ONE
;
title "Listing of Data Set COUNT";
proc print data=count noobs;
run;

* Program 1.47:  Converting values of '1','2','3','4', and '5' to 'A','B','C','D', and 
                 'E' respectively;
***Primary function: TRANSLATE;

data multiple;
   input Ques : $1. @@;
   Ques = translate(Ques,'ABCDE','12345');
datalines;
1 4 3 2 5
5 3 4 2 1
;
title "Listing of Data Set MULTIPLE";
proc print data=multiple noobs;
run;

* Program 1.48:  Converting the values "Y" and "N" to 1's and 0's;
***Primary functions: TRANSLATE, UPCASE;
***Other functions: INPUT;

data yes_no;
   length Char $ 1;
   input Char @@;
   x = input(
       translate(
       upcase(Char),'01','NY'),1.);
datalines;
N Y n y A B 0 1
;
title "Listing of Data Set YES_NO";
proc print data=yes_no noobs;
run;

* Program 1.49:  Converting words such as Street to their abbreviations 
                 such as St. in an address;
***Primary function: TRANWRD;

data convert;
   input @1 address $20. ;
   *** Convert Street, Avenue and Road to their abbreviations;
   Address = tranwrd(Address,'Street','St.');
   Address = tranwrd (Address,'Avenue','Ave.');
   Address = tranwrd (Address,'Road','Rd.');
datalines;
89 Lazy Brook Road 
123 River Rd.
12 Main Street
;
title 'Listing of Data Set CONVERT';
proc print data=convert;
run;

* Program 1.50:  Demonstrating the LENGTH, LENGTHC, LENGTHM, and 
                 LENGTHN functions;
***Primary functions: LENGTH, LENGTHC, LENGTHM, LENGTHN;

data length_func;
   file print;
   Notrail = "ABC";
   Trail   = "DEF   "; * Three trailing blanks;
   Null    = " ";      * Null string;
   Length_notrail = length(Notrail);
   Length_trail   = length(Trail);
   Length_null    = length(Null);
   Lengthc_notrail = lengthc(Notrail);
   Lengthc_trail   = lengthc(Trail);
   Lengthc_null    = lengthc(Null);
   Lengthn_notrail = lengthn(Notrail);
   Lengthn_trail   = lengthn(Trail);
   Lengthn_null    = lengthn(Null);
   put "Notrail:" Notrail /
        "Trail:" Trail /
        "Null:" Null / 25*'-'/
       (Length_:) (=) /
       (Lengthc:) (=) /
       (Lengthn:) (=) ;
run;

* Program 1.51:  Using the COUNT function to count the number of times the 
                 word "the" appears in a string;
***Primary Function: COUNT;

data dracula;
   input String $char60.;
   Num = count(String,"the");
   num_no_case = count(String,"the",'i');
datalines;
The number of times "the" appears is the question
THE the
None on this line!
There is the map
;
title "Listing of Data Set DRACULA";
proc print data=dracula noob;
run;

* Program 1.52:  Demonstrating the COUNTC function to find one or more 
                 characters or to check if characters are not present in a 
                 string;
***Primary Function: COUNTC;

data count_char;
   input String $20.;
   Num_A = countc(String,'A');
   Num_Aa = countc(String,'a','i');
   Num_A_or_B = countc(String,'AB');
   Not_A = countc(String,'A','v');
   Not_A_trim = countc(String,'A','vt');
   Not_Aa = countc(String,'A','iv');
datalines;
UPPER A AND LOWER a
abAB
BBBbbb
;
title "Listing of Data Set COUNT_CHAR";
proc print data=count_char;
run;

* Program 1.53: Demonstrating the COUNTW function;
***Primary function: COUNTW;
data count_words;
   input String $40.;
   Words = countw(String,,'sp');
datalines;
One two three four
One, and 3,4,5
oneword
;
title "Listing of data set COUNT_WORDS";
proc print data=count_words noobs;
run;

* Program 1.54: Using the CHOOSEC function to randomly select one of 
                three reviewers for each candidate (numbered 1 to n)
***Primary function: CHOOSEC;
***Other functions: CEIL, RANUNI;

data reviewer;
   do Candidate = 1 to 10;
      Name = choosec(ceil(ranuni(0)*3),"Fred","Mary","Xi");
      output;
   end;
run;

title "Listing of data set REVIEWER";
proc print data=reviewer noobs;
run;

* Program 1.55: Randomly choose an interviewer, by number (out of three)
  for each of n candidates;

***Primary function: CHOOSEN;
***Other functions: CEIL, RANUNI;
data reviewer;
   do Candidate = 1 to 10;
      NumberN= choosen(ceil(ranuni(0)*3),850,620,103);
      output;
   end;
run;

title "Listing of data set REVIEWER";
proc print data=reviewer noobs;
run;


* Program 1.56:  Determining if there are any missing values for all variables 
                 in a data set;
***Primary function: MISSING;
***Other function: DIM;

***First, create a data set for testing;
data test_miss;
   input @1 (X Y Z)(1.) 
         @4 (A B C D)($1.);
datalines;
123ABCD
..7 FFF
987RONC
;
title "Count of Missing Values";
data find_miss;
   set test_miss end=Last;
   array nums[*] _numeric_;
   array chars[*] _character_;
   do i = 1 to dim(nums);
      if missing(nums[i]) then NN + 1;
   end;
   do i = 1 to dim(chars);
      if missing(chars[i]) then NC + 1;
   end;
   file print;
   if Last then put NN "numeric and " NC "character values missing";
run;   

* Program 1.57: Demonstrating the MISSING function with .A, .B, etc
  numeric values;
***Primary function: MISSING;
*Create a data set with alternate missing values:
 Code of 888 means "Not applicable"
 Code of 999 means "Did not answer";
proc format;
   invalue readit 888 = .A
                  999 = .B
               other  = _same_;
   value miss .A = "Not applicable"
              .B = "Did not answer";
run;
data alternate_missing;
   input Value : readit. @@;
   format Value miss.;
   *Count total number of missing values;
   if missing(Value) then Miss_count + 1;
datalines;
100 200 . 888 300 999 999 600
;
title "Listing of data set ALTERNATE_MISSING";
proc print data=alternate_missing noobs;
run;

* Program 1.58: Demonstrating the COALESCEC function;
***Primary function: COALESCEC;
data first_nonmissing;
   length First_nonmiss $ 10;
   input (Name1-Name3) (: $10.);
   First_nonmiss = coalescec(of Name1-Name3);
datalines;
Able Baker Charlie
. . Martin
Ron . Roger
;

title "Listing of data set FIRST_MISSING";
proc print data=first_nonmissing;
run;


* Program 1.59:  Using the IFC function to select a character
                value, based on the value of a logical expression;

***Primary function: IFC;

data  testscore;
   length Category $ 9;
   input Name : $10. Score;
   if not missing(Score) then 
      Category = ifc(Score ge 90, 'Excellent','Below 90');
datalines;
Ron 99
Mike 78
Susan .
Pete 91
George 65
;

title "Listing of data set TESTSCORE";
proc print data=testscore noobs;
run;


* Program 1.60:  Using the collating sequence to convert plain text to Morse
                 Code;
***Primary function: RANK;
***Other functions: LENGTH, UPCASE, SUBSTR;

title "Morse Code Conversion Using the RANK Function";
data _null_;
  array Dot_dash[26] $ 4 _temporary_ 
    ('.-' '-...' '-.-.' '-..' '.' 
     '..-.' '-..' '....' '..' '.---' 
     '-.-' '.-..' '--' '-.' '---' '.--.'
     '--.-' '.-.' '...' '-' '..-'
     '...-' '.--' '-..-' '-.--' '--..'); 
   input @1 String $80.;
   file print;
   do i = 1 to length(String);
      Letter = upcase(substr(String,i,1));
      if missing(Letter) then put letter @;
      else  do;
         Num = rank(Letter) - 64;
         put Dot_dash[num] ' ' @;
      end;
   end;
   put;
datalines;
This is a test SOS
Now is the time for all good men
;

* Program 1.61: Using the REPEAT function to underline output values;
***Featured Function: REPEAT;

title "Demonstrating the REPEAT Function";
data _null_;
   file print;
   length Dash $ 50;
   input String $50.;
   if _n_ = 1 then put 50*"*";
   Dash = repeat("-",length(String) - 1);
   put String / Dash;
datalines;
Short line
This is a longer line
Bye
;

* Program 1.62: Using the REVERSE function to create backwards writing;
***Primary function: REVERSE;

data backwards;
   input @1 String $char10.;
   Gnirts = reverse(String);
datalines;
Ron Cody
   XYZ   
ABCDEFG
         x
1234567890
;
title "Listing of Data Set BACKWARDS";
proc print data=backwards noobs;
run;

* Program 1.63: Demonstrating the NLITERAL function;

***Primary function: NLITERAL;

data literal;
   input @1 Varname $32. Value;
   SASName = nliteral(Varname);
datalines;
Valid123                        100
In valid                        200
Black&White                     300
'Single Quotes'                 400
"Double Quotes"                 500
Contains%                       600
;
title "Listing of data set LITERAL";
proc print data=literal noobs;
run;

* Program 1.64: Demonstrating the NVALID function;

***Primary function: NVALID;
options validvarname=v7;
data valid_names;
   input @1 Varname $32.;
   if nvalid(Varname) then Result_def = 'OK    ';
   else Result_def = 'Not OK';
   if nvalid(Varname, 'V7') then Result_V7 = 'OK    ';
   else Result_V7 = 'Not OK';
   if nvalid(Varname,'ANY') then Result_ANY = 'OK    ';
   else Result_ANY = 'Not OK';
   if nvalid(Varname,'Nliteral') then Result_nlit = 'OK    ';
   else Result_nlit = 'Not OK';
datalines;
Valid123
Contains blank
Black&White
;
title "Listing of data set VALID_NAMES";
title2 "Validvarnames set equal to V7";
proc print data=valid_names noobs;
run;

options validvarname=ANY;
data valid_names;
   input @1 Varname $32.;
   if nvalid(Varname) then Result_def = 'OK    ';
   else Result_def = 'Not OK';
   if nvalid(Varname, 'V7') then Result_V7 = 'OK    ';
   else Result_V7 = 'Not OK';
   if nvalid(Varname,'ANY') then Result_ANY = 'OK    ';
   else Result_ANY = 'Not OK';
   if nvalid(Varname,'Nliteral') then Result_nlit = 'OK    ';
   else Result_nlit = 'Not OK';
datalines;
Valid123
Contains blank
Black&White
;
title "Listing of data set VALID_NAMES";
title2 "Validvarnames set equal to ANY";
proc print data=valid_names noobs;
run;

* Program 1.65: Using NVALID to count the number of valid V7
  and non-valid V7 variable names in a data set;

***Primary function: NVALID;

*Note:The system option VALIDVARNAME was set to 'ANY' before
 theImport Wizard imported the data;

options validvarname=any;
title "Listing of imported spreadsheet";
title2 "With VALIDVARNAME set to ANY";
proc print data=import_xls;
run;

proc contents data=import_xls out=cont_out noprint;
run;

title "Listing of data set CONT_OUT (Name only)";
proc print data=cont_out(keep=Name);
run;

title "Report on Variable Names";
data _null_;
   file print;
   set cont_out(keep=Name) end=last;
   if nvalid(Name,'v7') then Name_V7 + 1;
   else Name_any + 1;
   if last then put // 
   "There are " Name_V7 "variables with V7 names" /
   "There are " Name_any "variables with non-V7 names";
run;


* Program 2.1: Using a Perl regular expression to locate lines with an exact 
               text match;
***Primary functions: PRXPARSE, PRXMATCH; 

title "Perl Regular Expression Tutorial - Program 1";
data _null_;

   if _n_ = 1 then Pattern_num = prxparse("/cat/");
   *exact match for the letters 'cat' anywhere in the string;
   retain Pattern_num;

   input String $30.;
   Position = prxmatch(Pattern_num,String);
   file print;
   put Pattern_num= String= Position=;
datalines;
there is a cat in this line.
does not match dog
cat in the beginning
at the end, a cat
cat
;

* Program 2.2:  Using a regular expression to search for phone numbers in a 
                string;
***Primary functions: PRXPARSE, PRXMATCH;

data phone;
   input String $char40.;
   if _n_ = 1 then Pattern = prxparse("/\(\d\d\d\) ?\d\d\d-\d{4}/");
   retain Pattern;
   if prxmatch(Pattern,String) then output;
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
datalines;
One number (123)333-4444
Two here:(800)234-2222 and (908) 444-2344
None here
;
title "Listing of Data Set Phone";
proc print data=phone noobs;
run;

* Program 2.3:  Modifying Program 2.2  to search for toll-free phone 
                numbers;
***Primary functions: PRXPARSE, PRXMATCH;
***Other function: MISSING;

data toll_free;
   if _n_ = 1 then
      re = prxparse("/\(8(00|77|87)\) ?\d\d\d-\d{4}\b/");
      ***regular expression looks for phone numbers of the form:
         (nnn)nnn-nnnn or (nnn) nnn-nnnn.  in addition the first
         digit of the area code must be an 8 and the next two
         digits must be either a 00, 77, or 87.;
   retain re;
   input String $char80.;
   Position = prxmatch(re,String);
   if Position then output;
datalines;
One number on this line (877)234-8765
No numbers here
One toll free, one not:(908)782-6354 and (800)876-3333 xxx
Two toll free:(800)282-3454 and (887) 858-1234
No toll free here (609)848-9999 and (908) 345-2222
;
title "Listing of Data Set TOLL_FREE";
proc print data=toll_free noobs;
run;

* Program 2.4:  Using PRXMATCH without PRXPARSE (entering the regular 
                expression directly in the function);
***Primary function: PRXMATCH;

data match_it;
   input @1 String $20.;
   Position = prxmatch("/\d\d\d/",String);
datalines;
LINE 345 IS HERE
NONE HERE
ABC1234567
;
title "Listing of Data Set MATCH_IT";
proc print data=match_it noobs;
run;

* Program 2.5:  Locating all 5- or 9-digit zip codes in a list of addresses;
***Primary functions: PRXPARSE and CALL PRXSUBSTR;
***Other function: SUBSTRN;

data zipcode;
   if _n_ = 1 then RE = prxparse("/ \d{5}(-\d{4})?/");
   retain RE;
   /*
      Match a blank followed by 5 digits followed by
      either nothing or a dash and 4 digits

      \d{5}     matches 5 digits
      -         matches a dash
      \d{4}     matches 4 digits
      ?         matches zero or one of the preceding subexpression

   */

   input String $80.;
   length Zip_code $ 10;
   call prxsubstr(RE,String,Start,Length);
   if Start then do;
      Zip_code = substrn(String,Start + 1,Length - 1);
      output;
   end;
   keep Zip_code;
datalines;
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
title "Listing of Data Set ZIPCODE";
proc print data=zipcode noobs;
run;

* Program 2.6:  Extracting a phone number from a text string;
***Primary functions: PRXPARSE, CALL PRXSUBSTR
***Other functions: SUBSTR, COMPRESS, and MISSING;

data extract;
   if _n_ = 1 then
      Pattern = prxparse("/\(\d\d\d\) ?\d\d\d-\d{4}/");
   retain Pattern;

   length Number $ 15;
   input String $char80.;
   call prxsubstr(Pattern,String,Start,Length);
      if Start then do;
      Number = substr(String,Start,Length);
      Number = compress(Number," ");
      output;
   end;
   keep number;
datalines;
THIS LINE DOES NOT HAVE ANY PHONE NUMBERS ON IT
THIS LINE DOES: (123)345-4567 LA DI LA DI LA
ALSO VALID (123) 999-9999
TWO NUMBERS HERE (333)444-5555 AND (800)123-4567
;
title "Extracted Phone Numbers";
proc print data=extract noobs;
run;

* Program 2.7:  Using the PRXPOSN function to extract the area code and 
                exchange from a phone number;
***Primary functions: PRXPARSE, PRXMATCH, CALL PRXPOSN;
***Other function: SUBSTR;
 
data pieces;
   if _n_ then RE = prxparse("/\((\d\d\d)\) ?(\d\d\d)-\d{4}/");
   /*
      \(       matches an open parenthesis
      \d\d\d   matches three digits
      \)       matches a closed parenthesis
      b?       matches zero or more blanks (b = blank)
      \d\d\d   matches three digits
      -        matches a dash
      \d{4}    matches four digits
   */
   retain RE;

   input Number $char80.;
   Match = prxmatch(RE,Number);
   if Match then do;
      call prxposn(RE,1,Area_start);
      call prxposn(RE,2,Ex_start,Ex_length);
      Area_code = substr(Number,Area_start,3);
      Exchange = substr(Number,Ex_start,Ex_length);
   end;
   drop RE;
datalines;
THIS LINE DOES NOT HAVE ANY PHONE NUMBERS ON IT
THIS LINE DOES: (123)345-4567 LA DI LA DI LA
ALSO VALID (609) 999-9999
TWO NUMBERS HERE (333)444-5555 AND (800)123-4567
;
title "Listing of Data Set PIECES";
proc print data=pieces noobs heading=h;
run;

* Program 2.8:  Using regular expressions to read very unstructured data;
***Primary functions: PRSPARSE, PRXMATCH, CALL PRXPOSN;
***Other functions: SUBSTR, INPUT;

***This program will read every line of data and, for any line
   that contains two or more numbers, will assign the first 
   number to X and the second number to Y;

data read_num;
***Read the first number and second numbers on line;
   if _n_ = 1 then ret = prxparse("/(\d+) +\D*(\d+)/");
   /*
      \d+     matches one or more digits
      b+      matches one or more blanks (b = blank)
      \D*     matches zero or more non-digits
      \d+     matches one or more digits
   */
   retain ret;

   input String $char40.;
   Pos = prxmatch(ret,String);
   if Pos then do;
      call prxposn(ret,1,Start1,Length1);
      if Start1 then X = input(substr(String,Start1,Length1),9.);
      call prxposn(ret,2,Start2,Length2);
      if Start2 then Y = input(substr(String,Start2,Length2),9.);
      output;
   end;
   keep String X Y;
datalines;
XXXXXXXXXXXXXXXXXX 9 XXXXXXX         123
This line has a 6 and a 123 in it
456 789
None on this line
Only one here: 77
;
title "Listing of Data Set READ_NUM";
proc print data=read_num noobs;
run;

* Program 2.9:  Finding digits in random positions in an input string using 
                CALL PRXNEXT;
***Primary functions: PRXPARSE, CALL PRXNEXT;
***Other functions: LENGTHN, INPUT;

data find_num;
   if _n_ = 1 then ret = prxparse("/\d+/");
   *Look for one or more digits in a row;
   retain ret;

   input String $40.;
   Start = 1;
   Stop = lengthn(String);
   call prxnext(ret,Start,Stop,String,Position,Length);
   array x[5];
   do i = 1 to 5 while (Position gt 0);
      x[i] = input(substr(String,Position,Length),9.);
      call prxnext(ret,Start,Stop,String,Position,Length);
   end;
   keep x1-x5 String;
datalines;
THIS 45 LINE 98 HAS 3 NUMBERS
NONE HERE
12 34 78 90
;
title "Listing of Data Set FIND_NUM";
proc print data=find_num noobs;
run;

* Program 2.10: Demonstrating the PRXPAREN function;
***Primary functions: PRXPARSE, PRXMATCH, PRXPAREN;

/* Orders are identified by a numeric type: 1= Retail    2=Catalog  3=Internet
   Use the sale description to identify the type of sale and set OrderType */ 
 
data paren;
   if _n_ = 1 then Pattern  = prxparse("/(Retail|Store)|(Catalog)|(Internet|Web)/i");
   ***look for order type in Description field;
   retain Pattern;

   input Description $char30.;
   Position = prxmatch(Pattern,Description);
   if Position then OrderType = prxparen(Pattern);
datalines;
Order placed on Internet
Retail order
Store 123: Retail purchase
Spring catalog order
Order from specialty catalog
internet order
Web order 
San Francisco store purchase
;
title "Listing of Data Set PAREN";
proc print data=paren noobs;
run;

* Program 2.11:  Demonstrating the CALL PRXCHANGE function;
***Primary functions: PRXPARSE, CALL PRXCHANGE;

data cat_and_mouse;
   input Text $char40.;
   length New_text $ 80;

   if _n_ = 1 then Match = prxparse("s/[Cc]at/Mouse/");
   *replace "Cat" or "cat" with Mouse;
   retain Match;

   call prxchange(Match,-1,Text,New_text,R_length,Trunc,N_of_changes);
   if Trunc then put "Note: New_text was truncated";
datalines;
The Cat in the hat
There are two cat cats in this line
;
title "Listing of CAT_AND_MOUSE";
proc print data=cat_and_mouse noobs;
run;

* Program 2.12:  Demonstrating the use of capture buffers with PRXCHANGE;
***Primary functions: PRXPARSE, CALL PRXCHANGE;

data capture;
   if _n_ = 1 then Return = prxparse("S/(\w+ +)(\w+)/$2 $1/");
   retain Return;

   input String $20.;
   call prxchange(Return,-1,String);
datalines;
Ron Cody
Russell Lynn
;
title "Listing of Data Set CAPTURE";
proc print data=capture noobs;
run;

* Program 2.13:  Data cleaning example using PRXPARSE and 
                 CALL PRXFREE;
***Primary functions: PRXPARSE, PRXMATCH, CALL PRXFREE;

data invalid;
   ***Valid ID's are 1 to 3 digits with possible leading blanks;
   infile 'c:\books\functions\idnums.dat' end=last;
   if _n_ = 1 then Valid = prxparse("/\d\d\d| \d\d|  \d/");
   /*
      \d\d\d               matches three digits
      (single blank)\d\d   matches a blank followed by two digits
      (two blanks)\d       matches two blanks followed by one digit
   */

   retain Valid;
   input @1 ID $char3.;
   Pos = prxmatch(Valid,ID);
   if Pos eq 0 then output invalid;
   if last then call prxfree(Valid);
   drop Valid;
run;

* Program 3.1: Program to grade quizzes, dropping the two lowest
               quiz scores (using call sortn);
***Primary function: CALL SORTN;
***Other function: MEAN;
data quiz_scores;
   input Name : $15.Quiz1-Quiz10;
   call sortn(of Quiz1-Quiz10);
   Grade = mean(of Quiz3-Quiz10);
datalines;
George 78 90 90 95 88 . 100 98 95 90
Susan 100 100 100 100 100 100 . . . .
Maxwell 50 50 90 90 95 88 87 86 84 90
;
title "Listing of data set QUIZ_SCORES";
proc print data=quiz_scores noobs heading=h;
run;

* Program 3.2: Another example of CALL SORTN using
               array elements as the arguments;
***Primary function: CALL SORTN;
data top_scores;
   input Name : $15. Score1-Score8;
   array Score[8];
   call sortn(of Score[*]);
datalines;
King 8 4 6 7 9 9 9 4
Weisenbaum 9 9 8 . . 7 8 8
Chien 9 8 7 6 7 8 9 9
;
title "Listing of TOP_SCORES";
proc print data=top_scores;
  id Name;
run;

* Program 3.3: Demonstrating the CALL SORTC routine;
***Primary function: CALL SORTC;
data names;
   input (Name1-Name5)(: $12.);
   call sortc(of Name1-Name5);
datalines;
Charlie Able Hotel Golf Echo
Zemlachenko Cody Lane Lubsen Veneziale
bbb BBB aaa aaa ZZZ
;
title "Listing of data set NAMES";
proc print data=names noobs;
run;



* Program 4.1:  Creating a SAS date value from separate variables 
                representing the day, month, and year of the date;
***Primary function: MDY;

data funnydate;
   input @1  Month  2. 
         @7  Year   4. 
         @13 Day    2.;
   Date = mdy(Month,Day,Year);
   format Date mmddyy10.;
datalines;
05    2000  25
11    2001  02
;
title "Listing of FUNNYDATE";
proc print data=funnydate noobs;
run;

* Program 4.2:  Program to read in dates and set the day of the month to 15 
                if the day is missing from the date;
***Primary function: MDY;
***Other functions:  SCAN, INPUT;

data missing;
   input @1 Dummy $10.;
   Day = scan(Dummy,2,'/');
   if not missing (Day)then Date = input(Dummy,mmddyy10.);
   else Date = mdy(input(scan(Dummy,1,'/'),2.),
                   15,
             input(scan(Dummy,3,'/'),4.));
   format date date9.;
datalines;
10/21/1946
1/  /2000
01/  /2002
;
title "Listing of MISSING";
proc print data=missing noobs;
run;

* Program 4.3:  Determining the date, datetime value, and time of day;
***Primary functions: DHMS, HMS, TODAY, DATETIME, and TIME;
***Other functions: INT;

data test;
   Date = today();
   DT = datetime();
   Time = time();
   DT2 = dhms(Date,8,15,30);
   Time2 = hms(8,15,30);
   DOB = '01jan1960'd;
   Age = int(yrdif(DOB,Date,'actual'));
   format Date DOB date9. DT DT2 datetime. Time Time2 time.;
run;

title "Listing of Data Set TEST";
proc print data=test noobs heading=h;
run;

* Program 4.4:    Program to create the DATES data set;
data dates;
   informat Date1 Date2 date9.;
   input Date1 Date2;
   format Date1 Date2 date9.;
datalines;
01JAN1960 15JAN1960 
02MAR1961 18FEB1962
25DEC2000 03JAN2001
01FEB2002 31MAR2002
;
title "Listing of Data Set DATES";
proc print data=dates noobs;
run;

* Program 4.5 :  Demonstrating the functions YEAR, QTR, MONTH, WEEK, 
                 DAY, and WEEKDAY;
***Primary functions: YEAR, QTR, MONTH, WEEK, DAY, and WEEKDAY;
data date_functions;
   set dates(drop=Date2);
   Year = year(Date1);
   Quarter = qtr(Date1);
   Month = month(Date1);
   Week = week(Date1);
   Day_of_month = day(Date1);
   Day_of_week = weekday(Date1);
run;
title "Listing of Data Set DATE_FUNCTIONS";
proc print data=date_functions noobs;
run;

* Program 4.6:  Demonstrating the HOUR, MINUTE, and SECOND functions;
***Primary functions: HOUR, MINUTE, and SECOND;

data time;
   DT = '01jan1960:5:15:30'dt;
   T = '10:05:23't;
   Hour_dt = hour(DT);
   Hour_time = hour(T);
   Minute_dt = minute(DT);
   Minute_time = minute(T);
   Second_dt = second(DT);
   Second_time = second(T);
   format DT datetime.;
run;

title "Listing of Data Set TIME";
proc print data=time noobs heading=h;
run;

* Program 4.7:  Extracting the date part and time part of a SAS datetime 
                value;
***Primary functions: DATEPART and TIMEPART;

data pieces_parts;
   DT = '01jan1960:5:15:30'dt;
   Date = datepart(DT);
   Time = timepart(DT);
   format DT datetime. Time time. Date date9.;
run;

title "Listing of Data Set PIECES_PARTS";
proc print data=pieces_parts noobs;
run;

* Program 4.8: Demonstrating the INTNX function (with the SAMEDAY alignment;
***Primary functions: INTNX, WEEKDAY;
***Other functions: RANUNI, CEIL;

*A dentist wants to see each of his patients in six months for a followup visit.  
 However, if the date in six months falls on a Saturday or Sunday, he wants to 
 pick a random day in the in the following week.;

Data dental;
   input Patno : $5. Visit_date : mmddyy10.;
   format Visit_date weekdate.;
datalines;
001 1/14/2009
002 1/17/2009
003 1/18/2009
004 1/19/2009
005 1/19/2009
006 1/20/2009
007 1/11/2009
008 1/17/2009
;

title "Listing of data set DENTAL";
proc print data=dental noobs;
run;

data followup;
   set dental;
   Six_months = intnx('month',Visit_date,6,'sameday');
   *Check if weekend;
   DayofWeek = weekday(six_months);
   *Keep track of actual day for testing purposes;
   Actual = Six_months; 
   *If Sunday add random integer between 1 and 5;
   if DayofWeek = 1 then 
      Six_months = Six_months + ceil(ranuni(0)*5);
   *If Saturday, add a random integer between 2 and 6;
   else if DayofWeek = 7 then
      Six_months = Six_months + ceil(ranuni(0)*5 + 1);
run;
title "Six Month Appointment Dates";
proc report data=followup nowd headline;
   columns Patno Visit_date Actual Six_months;
   define Patno / display "Patient Number" width=7;
   define Visit_date / display "Initial Date" width=15 format=weekdate.;
   define Actual / display "Actual Day" width=15 format=weekdate.;
   define Six_months / display "Six Month Appt." width=15 format=weekdate.;
run;
quit;

* Program 4.9:    Program to demonstrate the date interval functions;
***Primary functions: INTCK, INTNX, YRDIF;

data period;
   set dates;
   Interval_month = intck('month',Date1,Date2);
   Interval_year  = intck('year',Date1,Date2);
   Year_diff      = yrdif(Date1,Date2,'actual');
   Interval_qtr   = intck('qtr',Date1,Date2);
   Next_month     = intnx('month',Date1,1);
   Next_year      = intnx('year',Date1,1);
   Next_qtr       = intnx('qtr',Date1,1);
   Six_month      = intnx('month',Date1,6);
   format Next: Six_month date9.;
run;
title "Listing of Data Set PERIOD";
proc print data=period heading=h;
   id date1 date2;
run;

* Program 4.10: Demonstrating the HOLIDAY function;

***Primary function: HOLIDAY;
***Other functions: WEEKDAY;
data salary;
   H1 = holiday('Newyear',2005);
   if weekday(H1) = 7 then H1 = H1 + 2;
   else if weekday(H1) = 1 then H1 = H1 + 1;
   H2 = holiday('MLK',2005);
   H3 = holiday('USpresidents',2005);
   H4 = holiday('Easter',2005)-2;
   array H[4];
   First = '01Jan2005'd; *Saturday;
   Second = '31Mar2005'd; *Thursday;
   Work = intck('weekday',First,Second);
   /* if holiday falls between the First and Second date,
      decrement number of working days */
   do i = 1 to 4;
      if First le H[i] le Second then Work = Work - 1;
   end;
   Salary = 500 * Work;
   format First Second mmddyy10. Salary dollar10.;
   keep First Second Work Salary;
run;
title "Listing of SALARY";
proc print data=SALARY noobs;
run;

* Program 4.11: Demonstrating the three Julian date functions;
***Primary functions: DATEJUL, JULDATE, and JULDATE7.;

***Note: option YEARCUTOFF set to 1920;
options yearcutoff = 1920;
data julian;
   input Date : date9. Jdate;
   Jdate_to_sas = datejul(Jdate);
   Sas_to_Jdate = juldate(Date);
   Sas_to_jdate7 = juldate7(Date);
   format Date Jdate_to_sas mmddyy10.;
datalines;
01JAN1960 2003365
15MAY1901 1905001
21OCT1946 5001
;

title "Listing of Data Set JULIAN";
proc print data=julian noobs;
   var Date Sas_to_jdate Sas_to_jdate7 Jdate Jdate_to_sas;
run;

* Program 5.1: Setting all numeric values of 999 to missing and all 
               character values of 'NA' to missing;
***Primary function: DIM;
***Other function: UPCASE;

data mixed;
   input X1-X5 A $ B $ Y Z;
datalines;
1 2 3 4 5 A b 6 7
2 999 6 5 3 NA C 999 10
5 4 3 2 1 na B 999 999
;
data array_1;
   set mixed;
   array nums[*] _numeric_;
   array chars[*] _character_;
   do i = 1 to dim(nums);
      if nums[i] = 999 then nums[i] = .;
   end;
  
   do i = 1 to dim(chars);
      if upcase(chars[i]) = 'NA' then chars[i] = ' ';
   end;
   drop i;
run;
title "Listing of Data Set ARRAY_1";
proc print data=array_1 noobs;
run;

* Program 5.2:  Creating a macro to compute and print out the number of 
                numeric and character variables in a SAS data set;
***Primary function: DIM;

%macro count(Dsn= /*Data set name */);
   title1 "*** statistics for data set &dsn ***";
   data _null_;
      if 0 then set &Dsn;
      array nums[*] _numeric_;
      array chars[*] _character_;
      n_nums = dim(nums);
      n_chars = dim(chars);
      file print;
      put / "There are " n_nums "numeric variables and " 
          n_chars "character variables";
   stop;
   run;
%mend count;

%count(Dsn=array_1)

* Program 5.3:  Determining the lower and upper bounds of an array where
                the array bounds do not start from one;
***Primary functions: LBOUND and HBOUND;

data array_2;
   array Income[1990:1995] Income1990-Income1995;
   array Tax[1990:1995] Tax1990-Tax1995;
   input Income1990 - Income1995;
   do Year = lbound(Income) to hbound(Income);
      Tax[year] = .25 * Income[year];
   end;
   format Income: Tax: dollar8.;
   drop Year;
datalines;
50000 55000 57000 66000 65000 68000
;
title "Listing of Data Set ARRAY_2";
proc print data=array_2 noobs;
run;
   
* Program 6.1:  Using the CEIL function to round up a value to the next 
                penny;
***Primary function CEIL;

data roundup;
   input Money @@;
   Up = ceil(100*Money)/100;
datalines;
123.452 45 1.12345 4.569
;
title "Listing of Data Set ROUNDUP";
proc print data=roundup noobs;
run;

* Program 6.2:  Computing a person's age as of his or her last birthday 
                (rounding down);
***Primary function: FLOOR;
***Other function: YRDIF;

data fleur;
   input @1 DOB mmddyy10.;
   Age = yrdif(DOB,'01jan2003'd,"actual");
   Age_floor = floor(Age);
   ***note: since age is positive, the int function is equivalent;
   format DOB mmddyy10.;
datalines;
10/21/1946
05/25/2000
;
title "Listing of Data Set FLEUR";
proc print data=fleur noobs;
run;

* Program 6.3:  Using the INT function to compute age as of a person's last 
                birthday;
***Primary function: INT;
***Other functions: YRDIF;

data ages;
   informat DOB mmddyy10.;
   input DOB @@;
   Age = ('01jan2003'd - DOB)/365.25;
   Age_int = int(age);
   format DOB mmddyy10.;
   drop Date;
datalines;
10/21/1946 11/12/1956 6/7/2002 12/20/1966 3/6/1930 5/8/1980
;
title "Listing of Data Set AGES";
proc print data=ages noobs;
run;

* Program 6.4: Rounding students' grades several ways;
***Primary function: ROUND;
***Other function: MEAN;

data scores;
   input ID Test1-Test3;
   Test_ave = mean(of Test1-Test3);
   Round_one = round(Test_ave);
   Round_tenth = round(Test_ave,.1);
   Round_two = round(Test_ave,2);
datalines;
1  100 95 95
2  78 79 88
;
title "Listing of Data Set SCORES";
proc print data=scores noobs;
   id ID;
   var Test_ave Round:;
run;

* Program 6.5:  Using the ROUND function to group ages into 10-year 
                intervals;
***Primary function: ROUND;
***Other function: YRDIF;

data decades;
   informat DOB mmddyy10.;
   input DOB @@;
   Age = yrdif(DOB,'01jan2003'd,"actual");
   Decade = round(Age + 5., 10);
   format DOB mmddyy10.;
datalines;
10/21/1946 11/12/1956 6/7/2002 12/20/1966 3/6/1930 5/8/1980
11/11/1998 10/21/1990 5/5/1994 10/21/1992
;
title "Listing of Data Set DECADES";
proc print data=decades noobs;
run;

* Program 6.6: Demonstrating the various truncation functions;
***Primary functions: CEIL, FLOOR, INT, and ROUND;

data truncate;
   input x @@;
   Ceil = ceil(x);
   Floor = floor(x);
   Int = int(x);
   Round = round(x);
datalines;
7.2 7.8 -7.2 -7.8
;
title "Listing of Data Set TRUNCATE";
proc print data=truncate noobs;
run;

* Program 6.7:  Logical comparisons with numbers stored with fewer than 
                8 bytes of precision;
***Primary function: TRUNC;

data test;
   length x4 4 x8 8;
   input x4 x8;
datalines;
1.234 1.234
;
data trunctest;
   set test;
   if x8 = 1.234 then Compare_x8 = 'True ';
   else Compare_x8 = 'False';
   if x4 = 1.234 then Compare_x4 = 'True ';
   else Compare_x4 = 'False';
   if x4 = trunc(1.234,4) then Compare_trunc_x4 = 'True ';
   else Compare_trunc_x4 = 'False';
run;

title "Listing of Data Set TRUNTEST";
proc print data=trunctest noobs;
run;

* Program 7.1:  Using the N function to determine the number of 
                non-missing values in a list of variables;
***Primary functions: N, MEAN;

data quiz;
   input Quiz1-Quiz10;
   ***compute quiz average if 8 or more quizzes taken;
   if n(of Quiz1-Quiz10) ge 8 then Quiz_ave = mean(of Quiz1-Quiz10);
datalines;
90 88 79 100 97 96 94 95 93 88
60 90 66 77 . . . 88 84 86
90 . . 90 90 90 90 90 90 90
;
title "Listing of Data Set QUIZ";
proc print data=quiz noobs heading=h;
run;

* Program 7.2:  Computing a SUM and MEAN of a list of variables, only if 
                there are no missing values;
***Primary functions: NMISS, MEAN and SUM;
***Other function: N;

data nomiss;
   input X1-X3 Y Z;
   if nmiss(of X1-X3,Y,Z) eq 0 then do;

   ***An alternative statement is:
   if n(of X1-X3,Y,Z) eq 5 then do;

      Sum_vars = sum(of X1-X3,Y,Z);
      Average = mean(of X1-X3,Y,Z);
   end;
datalines;
1 2 3 4 5
9 . 8 7 6
8 8 8 8 8
;
title "Listing of Data Set NOMISS";
proc print data=nomiss noobs;
run;

* Program 7.3:  Computing a mean, median, and sum of eight variables, only 
                if there are at least six non-missing values;
***Primary functions: N, MEAN, MEDIAN, SUM;

data score;
   input @1 (Item1-Item8)(1.);
   if n(of Item1-Item8) ge 6 then do;
      Mean = mean(of Item1-Item8);
      Median = median(of Item1-Item8);
      Sum = sum(of Item1-Item8);
   end;
datalines;
12345678
1.3.5678
1...5678
;
title "Listing of SCORE";
proc print data=score noobs;
run;

* Program 7.4:  Computing a range, interquartile range, and standard 
                deviation for each subject;
***Primary functions: RANGE, IQR, and STD;

data home_on_the_range;
   input Subject X1-X10;
   Range = range(of X1-X10);
   IQR = iqr(of X1-X10);
   SD = std(of X1-X10);
datalines;
1  1 2 3 4 5 6 7 8 9 10
2  9 7 4 1 15 0 . 2 7 4
3  1 3 5 7 9 11 13 15 20 100
;
title "Listing of Data Set HOME_ON_THE_RANGE";
proc print data=home_on_the_range;
   id Subject;
run;

* Program 7.5:  Program to read hourly temperatures and determine the 
                daily minimum and maximum temperature;
***Primary functions: MIN and MAX;

data min_max_temp;
   informat Date mmddyy10.;
   input Date;
   input Temp1-Temp24;
   Min_temp = min(of Temp1-Temp24);
   Max_temp = max(of Temp1-Temp24);
   keep Min_temp Max_temp Date;
   format Date mmddyy10.;
datalines;
05/1/2002
38 38 39 40 41 42 55 58 60 60 59 62 66 70 75 77 60 59 58 57 54 52 51 50
05/02/2002
36 41 39 40 41 46 57 59 63 . 59 62 64 72 79 80 78 62 62 62 60 50 55 55
;
title "Listing of Data Set MIN_MAX_TEMP";
proc print data=min_max_temp noobs;
run;

* Program 7.6:  Computing the three lowest golf scores for each player 
                (using the SMALLEST function);
***Primary function: SMALLEST;

data golf;
   infile datalines missover;
   input ID $ Score1-Score8;
   Lowest = smallest(1 ,of Score1-Score8);
   Next_lowest = smallest(2, of Score1-Score8);
   Third_lowest = smallest(3, of Score1-Score8);
datalines;
001 100 98 . . 96 93
002 90 05 07 99 103 106 110
003 110 120
;
title "Listing of Data Set GOLF";
proc print data=golf noobs heading=h;
run;

* Program 7.7:  Computing a grade based on the five highest scores;
***Primary function: LARGEST, N;

***This program will compute a grade based on the 5 highest
   (out of 9) scores.  If there are fewer than 5 non-missing scores, 
   a missing value will be returned;

data high_5;
   input Score1-Score9;
   array Score[9];
   if n(of Score1-Score9) lt 5 then return;
   Sum = 0;
   do i = 1 to 5;
      Sum = Sum + largest(i,of Score1-Score9);
   end;
   Grade = Sum / 5;
   drop i;
datalines;
90 100 89 88 10 . . 29 77
. . . . . 100 99 98 97
10 20 30 40 50 60 70 80 90
;
title "Listing of Data Set HIGH_5";
proc print data=high_5 noobs;
run;

* Program 7.8:  Macro to compute an average of n scores where the lowest 
                m scores are dropped;
***Primary functions: N, MIN, LARGEST;
*----------------------------------------------------------------*
| Macro: DROP_N                                                  |
| Purpose: Takes the average of "n" scores by dropping the       |
|          lowest "m" scores from the calculation.               |
| Arguments: Dsn      Data set name                              |
|            Base     Base of variable name holding scores       |
|            N        Total number of scores                     |
|            N_drop   Number of scores to drop                   |
|            Varname  The name of the variable to hold the       |
|                     average                                    |
|            Note: The average variable is added to the original |
|                  data set.                                     |
| Example: %macro drop_n(Roster=,                                |
|                        Quiz=,                                  |
|                        N=12,                                   |
|                        N_drop=2,                               |
|                        Varname=Average);                       |
*----------------------------------------------------------------*;

%macro drop_n(dsn=, Base=, N= , N_drop=, Varname=);
   data &Dsn;
      set &Dsn;
      N_of_scores = n(of &Base.1-&Base&n);
      Min = min(N_of_scores,%eval(&N - &N_drop));
      Sum = 0;
      do i = 1 to Min;
         Sum + largest(i,of &Base.1-&Base&n);
      end;
      &Varname = Sum / Min;
      ***replace min with %eval(&N - &N_drop) to penalize
         students taking fewer than the minimum number of quizzes;
      drop i N_of_scores Sum Min;
   run;
%mend drop_n;

***Data set to test the macro;
data roster;
   input ID Quiz1-Quiz9;
datalines;
1 6 7 8 9 8 7 6 7 8
2 6 8 8 8 8 8 8 8 .
3 7 8 9 . . . . . .
4 9 9 1 9 9 9 9 . .
;
%drop_n(Dsn=roster, Base=Quiz, N=9, N_drop=2, Varname=Quiz_ave)

title1 "Listing of Data Set QUIZ";
title2 "After running macro DROP_N";
proc print data=roster noobs;
run;

proc print data=roster;
run;

* Program 7.9:  Using the PCTL function to determine 25th, 50th, and 75th 
                percentile in a list of values;
***Primary function: PCTL;
***Other functions: RAND;

***Generate data set for testing;
data temperature;
   array T[24]; ***temperature for each hour;
   do Day = 1 to 5;
      ***T values normally distributed with mean = 70 and 
         standard deviation = 10;
      do Hour = 1 to 24;
         T[hour] = rand('normal',70,10);
      end;
      output;
   end;
   keep T1-T24 Day;
run;

data percentile;
   set temperature;
   P25 = pctl(25, of T1-T24);
   P50 = pctl(50, of T1-T24);
   P75 = pctl(75, of T1-T24);
   IQR = P75 - P25;
   label P25 = "25th Percentile"
         P50 = "Median"
         P75 = "75th Percentile"
         IQR = "Inter-quartile range";
run;

title "Listing of Data Set PERCENTILE";
proc print data=percentile noobs label;
   ID Day;
   var P25 P50 P75 IQR;
run;

* Program 7.10:  Program to compute a quiz grade by dropping none, one, or 
                 two of the lowest quiz scores, depending on how many 
                 quizzes were taken;
***Primary function: ORDINAL;
***Other functions: N, MEAN, and SUM;

data quiz_ave;
   input ID $ Quiz1-Quiz9;
   N_of_quizzes = n(of Quiz1-Quiz9);
   if n_of_quizzes  = 9 then 
      Quiz_ave = (sum(of Quiz1-Quiz9) - 
                  ordinal(1,of Quiz1-Quiz9) -
                  ordinal(2,of Quiz1-Quiz9))/7;
   else if N_of_quizzes = 8 then 
      Quiz_ave = (sum(of Quiz1-Quiz9) - ordinal(2,of Quiz1-Quiz9))/7;
   else Quiz_ave = mean(of Quiz1-Quiz9);
datalines;
001 6 7 8 9 8 7 6 7 8
002 6 8 8 8 8 8 8 8 .
003 7 8 9 . . . . . .
004 9 9 1 9 9 9 9 . .
;
title "Listing of Data Set QUIZ_AVE";
proc print data=quiz_ave noobs heading=h;
run;

* Program 7.11:  Alternate version of Program 7.10;
***Primary function: ORDINAL;
***Other functions: N and MIN;

data quiz_ave2;
   input ID $ Quiz1-Quiz9;
   N_of_quizzes = n(of Quiz1-Quiz9);
   Sum = 0;
   do i = 1 to min(N_of_quizzes,7);
      Sum + ordinal(10 - i,of Quiz1-Quiz9);
   end;
   Quiz_ave = Sum / min(N_of_quizzes,7);
datalines;
001 6 7 8 9 8 7 6 7 8
002 6 8 8 8 8 8 8 8 .
003 7 8 9 . . . . . .
004 9 9 1 9 9 9 9 . .
;
title "Listing of Data Set QUIZ_AVE2";
proc print data=quiz_ave2 noobs heading=h;
run;

* Program 7.12: Sorting values within an observation;
***Primary function: ORDINAL;
***Other functions: CALL SORTN;

data sort;
   input X1-X10;
   array X[10] X1-X10;
   array Sort_x[10] Sort_x1-Sort_x10;
   do i = 1 to 10;
      Sort_x[i] = ordinal(i,of X1-X10);
   end;
   drop i;
datalines;
5 2 9 1 3 6 . 22 7 0
;
title "Listing of Data Set SORT";
proc print data=sort noobs heading=h;
run;

*Using call SORTN;
data sort;
   input X1-X10;
   call sortn(of X1-X10);
datalines;
5 2 9 1 3 6 . 22 7 0
;
title "Listing of Data Set SORT";
proc print data=sort noobs heading=h;
run;


* Program 7.13: Macro to sort values within an observation'
***Primary function: ORDINAL;
*Note: CALL SORTN can be used to sort values within and observation.
 This program is included to provide another example of the ORDINAL
 function as well as temporary arrays;

%macro sort_array(Dsn=,    /* Data set name                     */
                  Base=,   /* Prefix of variable name
                              eg. if variables are Ques1-Ques10,
                              Base would be Ques                 */
                  N_of_elements= /* Number of variables          */);
   data &Dsn;
      set &Dsn;
      array &Base[&n_of_elements];
      array Temp[&N_of_elements] _temporary_;
      ***transfer values to temporary arry;
      do i = 1 to &N_of_elements;
         Temp[i] = ordinal(i,of &Base.1 - &Base&N_of_elements);
      end;
      ***put them back in the original variable names in order;
      do i = 1 to &N_of_elements;
         &Base[i] = Temp[i];
      end;
      drop i;
   run;
%mend  sort_array;

title "Listing of Data Set SORT before macro";
proc print data=sort noobs;
   var x1-x10;
run;

%sort_array(Dsn=sort, Base=x, N_of_elements=10)

title "Listing of Data Set SORT after macro";
proc print data=sort noobs;
   var x1-x10;
run;

* Program 7.14:  Performing a t test where values for each group are in a 
                 single observation;
***Primary function: STD;
***Other functions: N, MEAN, SQRT, PROBT, ABS;

title "T-Test Calculation";
data _null_;
   file print;
   infile datalines missover;
   input Group $ x1-x50;
   retain n1 Mean1 SD1 Group1;
   if _n_ = 1 then do;
      Group1 = Group;
      N1 = n(of x1-x50);
      Mean1 = mean(of x1-x50);
      SD1 = std(of x1-x50);
   end;
   if _n_ = 2 then do;
      Group2 = Group;
      N2 = n(of x1-x50);
      Mean2 = mean(of x1-x50);
      SD2 = std(of x1-x50);
      Diff = Mean1 - Mean2;
      SD_pooled_2 = ((n1-1)*SD1**2 + (n2-1)*SD2**2)/(n1 + n2 - 2);
      T = abs(Diff) / sqrt(SD_pooled_2/n1 + SD_pooled_2/n2);
      Prob = 2*(1 - probt(T,n1+n2-2));

      ***Prepare the report;
      put @1  "Group " Group1 +(-1) ":" 
          @10 "N = " n1 3. 
          @20 "Mean = " Mean1 7.3
          @35 "SD = " SD1 7.4 /
          @1  "Group " Group2 +(-1) ":" 
          @10 "N = " n2  3.
          @20 "Mean = " Mean2 7.3
          @35 "SD = " SD2 7.4 /
          @1 "Difference = " Diff 7.3
          @25 "T = " T 7.4
          @40 "P(2-tail) = " Prob 7.4;
      end;
datalines;
A 4 5 8 7 6 5 7
B 9 7 8 8 6 7 9 9 11
;

* Program 8.1:  Determining mathematical constants and machine 
                       constants using the CONSTANT function;
***Primary function: CONSTANT;

title;
data _null_;
   file print;
   Pi = constant('pi');
   e = constant('e');

   put "Mathematical Constants" /
       "Pi = " Pi /
       "e = " e //
       "Largest Integers stored in 'n' bytes:";
   do Bytes = 3 to 8;
      Int = constant('exactint',Bytes);
      put +5 "Largest integer stored in " Bytes "bytes is: " Int;
   end;
   Large = constant('big');
   Small = constant('small');
   Precision = constant('maceps');
   put / "Machine Constants" /
         "Largest 8 Byte Value is: " Large /
         "Smallest 8 Byte Value is: " Small / 
         "Precision constant is: " Precision;
run;

* Program 8.2:  Using the MOD function to choose every nth observation 
                       from a SAS data set;
***Primary function: MOD
***Other functions: INT, RANUNI;

***Create test input data set;
data big;
   do Subj = 1 to 20;
      x = int(10*ranuni(0)); /* Random integers from 0 to 9 */
      output;
   end;
run;

%let n = 4; /* Every 4th observation will be selected */

data every_n;
   set big;
   if mod(_n_ ,&n) = 1; 
   /* Selects every nth observation, starting with the 1st */
run;

title "Listing of data set EVERY_N";
proc print data=every_n noobs;
run;

* Program 8.3:  Using the MOD function as a toggle switch, alternating 
                       group assignments;
***Primary function: MOD;
***In this program, we want to assign every other subject into 
   group A or group B;

data switch;
   do Subj = 1 to 10;
      if mod(Subj,2) eq 1 then Group = 'A';
      else Group = 'B';
      output;
   end;
run;
title "Listing of data set SWITCH";
proc print data=switch noobs;
run;

* Program 8.4:  Computing Chi-square with Yates' correction, which 
                       requires an absolute value;
***Primary function: ABS
***Other function: PROBCHI;

data yates;
   input A B C D;
   N = A + B + C + D;
   Yates = ( abs(A*D - B*C) - N/2)**2 * N / 
           ( (A+B)*(C+D)*(A+C)*(B+D) );
      Prob_Yates = 1 - probchi(Yates,1); 
datalines;
10 20 30 40
2 9 8 5
;
title "listing of data set YATES";
proc print data=yates noobs;
run;

* Program 8.5:  Program to compute and print out a table of integers and 
                       square roots;
***Primary function: SQRT;

options ps=15; /* So the panels will display in PROC REPORT */
data square_root;
   do n = 1 to 40;
      Square_root = sqrt(n);
      output;
   end;
run;

title "Table of Integers and Square Roots";
proc report data=square_root nowd panels=99;
   columns n Square_root;
   define n / display width=3 format=3.0;
   define Square_root /'Square Root' width=7 format=7.6;
run;

* Program 8.6:  Creating tables of integers, their base-10 and base E 
                       logarithms and their value taken to the nth power;
***Primary functions: EXP, LOG, LOG10;
***Program to print a pretty table of integers (from 1 to 100),
   results of the exponential function, base ten and base E logs;

data table;
   do n = 1 to 40;
      e = exp(n);
      ln = log(n);
      log = log10(n);
      output;
   end;
run;

title "Table of Exponents, Natural and Base 10 Logs";
proc report data=table nowd panels=99;
   columns n e ln log;
   define n / display right width=3 format=3.;
   define e / display right width=8 format=best8. 'Exp';
   define ln / display right width=7 format=7.4 'Natural Log';
   define log / display right width=7 format=7.4 'Base 10 Log';
run;

* Program 8.7:  Creating a table of integers and factorials;
***Primary function: FACT;
options ps=55; 
data factorial;
   do n = 1 to 12;
      Factorial_n = fact(n);
      output;
   end;
   format Factorial_n comma12.;
run;

title "Listing of data set FACTORIAL";
proc print data=factorial noobs;
run;

* Program 8.8:  Demonstrating the GAMMA function;
***Primary function: GAMMA;

data table;
   do x = 1 to 5 by .05;
      Gamma = gamma(x);
      output;
   end;
run;

ods rtf file='c:\books\functions\gamma.rtf';
goptions device=jpeg;
symbol v=none i=sm;
title "Graph of Gamma Function from 1 to 5";
proc gplot data=table;
   plot Gamma * x;
run;
ods rtf close;

* Program 8.9: Demonstrating the IFN function;
***Primary function: IFN;
***Other function: MISSING;
data bonus;
   input Name : $10. Sales;
   if not missing(Sales) then Bonus = ifn(Sales > 5000, 200, 100);
datalines;
Ron 6000
John 4000
Fred .
;
title "Listing of data set BONUS";
proc print data=bonus noobs;
run;

* Program 8.10: Demonstrating the COALESCE function;
***Primary function: COALESCE;
data weigh_in;
   input Name $ Time1-Time3;
   Weight = coalesce(of Time1-Time3);
datalines;
John 180 . .
Fred . 250
Gary . . 350
Peter 200 . .
;
title "Listing of data set WEIGH_IN";
proc print data=weigh_in noobs;
run;


* Program 9.1:  Demonstrating differences between random functions and 
                call routines (function example);
***Primary function: RANUNI;
data ran_function;
   do n = 1 to 3;
      x = ranuni(1234);
      y = ranuni(0);
      output;
   end;
run;

title "Listing of data set RAN_FUNCTION - First run";
proc print data=ran_function noobs;
run;

title "Listing of data set RAN_FUNCTION - Second run";
proc print data=ran_function noobs;
run;

* Program 9.2:  Demonstrating differences between random functions and 
                       call routines (call routine example);
data ran_call;
   Seed1 = 1234;
   Seed2 = 0;
   do n = 1 to 3;
      call ranuni(Seed1,x);
      call ranuni(Seed2,y);
      output;
   end;
run;

title "Listing of data set RAN_CALL - First run";
proc print data=ran_call noobs;
run;

title "Listing of Data Set RAN_CALL - Second Run";
proc print data=ran_call noobs;
run;

* Program 9.3:  Selecting an approximate n% random sample;
***Primary function: RANUNI;

***This first DATA step generates a test data set;
data big;
   do Subj = 1 to 1000;
      output;
   end;
run;

***This DATA step demonstrates how to select a random subset;
data random1;
   set big (where=(ranuni(456) le .10));
run;

* Program 9.4:  Selecting a random sample with exactly n observations;
***Primary function: RANUNI;

data random2;
   set big;
   Shuffle = ranuni(0);
run;

proc sort data=random2;
   by Shuffle;
run;

data exact_n;
   set random2(drop=Shuffle obs=100);
run;

* Program 9.5:  Simulating random throws of two dice;
***Primary function: RANUNI
***Other function: CEIL;

data dice;
   do i = 1 to 1000; /* generate 1000 throws */
      Die_1 = ceil(ranuni(0)*6);
      Die_2 = ceil(ranuni(0)*6);
      Throw = Die_1 + Die_2;
      output;
   end;
run;

title "Frequencies of dice throws";
proc freq data=dice;
   tables Die_1 Die_2 Throw / nocum nopercent;
run;

* Program 9.6:  Randomly assigning n subjects into two groups: Method 1 - 
                       Approximate number of subjects in each group;
***Primary function: RANUNI;

data assign1;
   do Subj = 1 to 12;
      if ranuni(123) lt .5 then Group = 'A';
    else Group = 'B';
    output;
   end;
run;

title "List of random assignments";
proc print data=assign1 noobs;
run;

* Program 9.7:  Randomly assigning n subjects into two groups: Method 2 - 
                       Equal number of subjects in each group;
***Primary function: RANUNI;

proc format;
   value grpfmt 0 = 'A'  1 = 'B';
run;

data assign2;
   do Subj = 1 to 12;
      Group = ranuni(123);
      output;
   end;
run;

proc rank data=assign2 out=random groups=2;
   var Group;
run;

title "Random assignment of subjects, equal number in each group";
proc print data=random noobs;
   id Subj;
   var Group;
   format Group grpfmt.;
run;

* Program 9.8:  Randomly assigning n subjects into two groups: Method 3 -
                       Equal number of subjects in each group within blocks of four 
                       subjects;
*** Primary function: RANUNI;

data assign3;
   do Block = 1 to 3;
      do i = 1 to 4;
         Subj + 1;
         Group = ranuni(123);
         output;
      end;
   end;
   drop i;
run;

proc rank data=assign3 out=random groups=2;
   by Block;
   var Group;
run;

title "Random assignment of subjects, blocks of four";
proc print data=random noobs;
   id Subj;
   var Group;
   format Group grpfmt.;
run;

* Program 9.9: Macro to assign n subjects into k groups;
***Primary function: RANUNI;

***Macro to assign n subjects into k groups;
*------------------------------------------------------------*
| Macro Name: ASSIGN                                         |
| Purpose: Random assignment of k treatments for n subjects  |
| Arguments: Dsn=    : Data set to hold output               |
|            n=      : Number of subjects                    |
|            K=      : Number of groups                      |
|            Seed=   : Number for seed, seed is 0 if omitted |
|            Report= : NO if no report is desired            |
| Example: %assign (Dsn=mydata, n=100, k=4)                  |
|          will assign 100 subjects into 4 equal groups      |
| Example: %assign (Dsn=mydata, n=100, k=4, seed=12345,      |
|                   Report=NO)                               |
|          will assign 100 subjects into 4 equal groups      |
|          Seed is 123 and no report is desired              |
*------------------------------------------------------------*;
%macro assign(Dsn=,   /* Data set to hold output          */
              n=,     /* Number of subjects               */
              k=,     /* Number of groups                 */
              Seed=0, /* Random number seed, 0 for random
                         value > 0 for fixed              */
              Report=YES /* Set to NO for no report       */);
   data _temp_;
      do Subj = 1 to &n;
         Group = ranuni(&Seed);
         output;
      end;
      run;
   proc rank data=_temp_ out=&Dsn groups=&k;
      var Group;
   run;
   ***increment group so group numbers start with 1;
   data &Dsn;
      set &Dsn;
      Group = Group + 1;
   run;
   %if %upcase(&Report) eq YES %then %do;
         title "&n of subjects randomly assigned to &k groups";
         proc report data=&Dsn nowd panels=99;
         columns Subj Group;
         define Subj / display width=4 right format=4.0 'Subj';
         define Group / display width=5 center format=2. 'Group';
      run;
   %end;
   proc datasets library=work;
      delete _temp_;
   run;
   quit;
%mend assign;

***Testing the macro;
%assign (Dsn=mydata, n=100, k=4)
%assign (Dsn=mydata, n=100, k=4, seed=12345, Report=yes)


* Program 9.10:  Macro to assign n subjects into k groups, with b subjects 
                         per block;
***Primary function: RANUNI;

***Macro to assign n subjects into k groups with b subjects
   per block;

%macro assign_balance
   (Dsn=,      /* Data set to hold the output   */
    n=,        /* Number of subjects            */
    k=,        /* Number of groups              */
    b=,        /* Number of subjects per block  */
    Seed=0,    /* Seed value, 0 is default      */
    report=yes /* Set to NO if no report wanter */);

/* Example:
   %assign_balance(Dsn=mydata, n=100, k=2, b=10)
   assign 100 subjects into two groups blocked
   every 10 subjects
*/
   data _temp_;
   %if %eval(%sysevalf(&b/&k, floor) - %sysevalf(&b/&k, ceil))
      ne 0 %then %do;
      file print;
      put "The number of subjects per group (&b) is not"/ 
          "evenly divisible by the number of groups (&k)";
      stop;
   %end;
      %let n_blocks = %sysevalf(&n/&b,floor);
      do Block = 1 to &n_blocks;
         do j = 1 to &b;
            Subj + 1;
            Group = ranuni(&seed);   
            output;
         end;
      end;
   run;
   proc rank data=_temp_ out=&Dsn Groups=&k;
      by Block;
      var Group;
   run;
   ***increment group so group numbers start with 1;
   data &Dsn;
      set &Dsn(drop = Block);
      Group = Group + 1;
   run;
   %if %upcase(&Report) eq YES %then %do;
   title1 "&n subjects randomly assigned to &k groups";
   title2 "Equal number of subjects in each group of &b subjects";
   proc report data=&dsn nowd panels=99;
      columns Subj Group;
      define Subj / display width=4 right format=4.0 'Subj';
      define Group / display width=5 center format=2. 'Group';
   run;
   %end;
   proc datasets library=work;
      delete _temp_;
   run;
   quit;
%mend assign_balance;

* Program 9.11:  Demonstrating a Monte-Carlo simulation to determine the 
                         power of a t test;
***Primary function: RANNOR;

/*****************************************************************
   Group 1:mean = 100 n = 8 standard deviation = 10
   Group 2:mean = 115 n = 6 standard deviation = 12
   Scores are normally distributed in each group.
   This program generates 1000 samples;
******************************************************************/
data generate;
   do Block = 1 to 1000;
      do Group = 'A', 'B';
         if group = 'A' then do Subj = 1 to 6;
            x = rannor(123)*10 + 100;
            output;
         end;
         else if group = 'B' then do subj = 1 to 8;
            x = rannor(123)*12 + 115;
            output;
         end;
      end;
   end;
run;

***Test the distributions;
title "Mean and Standard Deviation of the 1000 Samples";
proc means data=generate n mean std;
   class Group;
   var x;
run;

***run 1000 t-tests and capture the p-values;
ods listing close;
ods output ttests=work.p_values;
proc ttest data=generate;
   by Block;
   class Group;
   var x;
run;
ods output close;
ods listing;

***Examine the results;
data power_t;
   set p_values;
   if Probt le .05 then result = 'Power';
   else Result = 'Beta';
run;
title "Power of a t-test for assumptions of equal or unequal variance";
proc tabulate data=power_t;
   class Variances Result;
   tables Variances , (Result all)*pctn<Result all>=' ';
run;
title "Power of a t-test with equal variances";
proc chart data=p_values;
   where Variances = 'Equal';
   vbar Probt / midpoints = 0 to .7 by .05;
run;
quit;

* Program 9.12:  Program to generate random values of heart rates that are 
                         normally distributed;
***Primary function: RANNOR;
***Other function: ROUND;

data generate;
   Seed = 0;
   do Subj = 1 to 100;
      call rannor(Seed, HR);
      HR = round(15*HR + 70);
      output;
   end;
run;

options ps=16;
title "Listing of Data Set GENERATE";
proc report data=generate panels=99 nowd;
   columns Subj HR;
   define Subj / display width=4;
   define HR / display width=4 format=4.0;
run;

* Program 9.13: Generating a series of normally distributed 
  values using the RAND function;

***Primary function: RAND;
data normal;
   call streaminit(13245);
   do i = 1 to 10;
      x = rand('Normal',100,5);
      output;
   end;
   drop i;
run;

title "Listing of data set NORMAL";
proc print data=normal noobs;
run;


* Program 10.1: Using the LAGn functions to compute a moving average;
***Primary functions: LAG and LAG2
***Other function: MEAN;

***Program to compute a moving average, based on three observations;
data moving;
   input x @@;
   x1 = lag(x);
   x2 = lag2(x);
   Moving = mean(x, x1, x2);
   if _n_ ge 3 then output;
datalines;
1 3 9 5 7 10
;
title "Listing of Data Set MOVING";
proc print data=moving noobs;
run;

* Program 10.2:  Computing changes in blood pressure from one visit to 
                         another;
***Primary function: DIF;
***Create a test data set of patient visits;

data visits;
   input ID Visit_date : mmddyy10. SBP DBP @@;
   format Visit_date date9.;
   label SBP = 'systolic blood pressure'
         DBP = 'diastolic blood pressure';
datalines;
1 02/01/2003 180 110   1 03/02/2003 178 100   1 04/01/2003 170 90
2 03/03/2003 170 100   2 04/01/2003 172 100
3 04/01/2003 130 80    3 06/01/2003 128 82    3 08/01/2003 128 78
;
proc sort data=visits;
   by ID Visit_date;
run;

***Program to compute changes between visits;
data change;
   set visits;
   by ID;

   ***Delete any subject with only one visit;
   if first.ID and last.ID then delete;

   Diff_SBP = dif(SBP);
   Diff_DBP = dif(DBP);
   if not first.ID then output;
run;

title "Listing of Data Set CHANGE";
proc print data=change noobs;
run;

* Program 10.3:  Computing the difference in blood pressure between the 
                         first and last visit for each patient;
***Primary function: DIF;
***This example uses the data set VISITS from the example above;

data first_last;
   set visits;
   by ID;
   ***Note: The DIF function is being executed conditionally.
      Be VERY careful if you do this;
   ***Delete any subject with only one visit;
   if first.ID and last.ID then delete;

   if first.ID or last.ID then do;
      Diff_SBP = dif(SBP);
      Diff_DBP = dif(DBP);
   end;
   if last.ID then output;
run;

title "Listing of Data Set FIRST_LAST";
proc print data=first_last noobs;
run;

* Program 10.4:  Using the INPUT function to perform character-to-numeric 
                         conversion;
***Primary function: INPUT;
***Create test data set;

data char;
   input Num $ Date1 : $10. Date2 : $9. Money : $12.;
datalines;
123 10/21/1980 21OCT1980 $123,000.45
XYZ 11/11/2003 01JAN1960 $123
;
data convert;
   set char(rename=(Num=C_num));
   Num = input(C_num,9.);
   SASdate1 = input(Date1,mmddyy10.);
   SASdate2 = input(Date2,date9.);
   Dollar = input(Money,comma12.);
   format SASdate1 SASdate2 mmddyy10.;
run;

title "Listing of Data Set CONVERT";
proc print data=convert noobs heading=h;
run;

* Program 10.5:  Using the INPUTC function to specify an informat at 
                         run time;
***Primary function: INPUTC
***Other functions: PUT;

proc format;
   invalue $codea 'A' = 'Chair'
                  'B' = 'Desk'
                  'C' = 'Table';
   invalue $codeb 'A' = 'Office Chair'
                  'B' = 'Big Desk'
                  'C' = 'Coffee Table';
   value code 1 = '$codea.'
              2 = '$codeb.';
run;

data items;
   input Year Letter : $1. @@;
   length Item $ 12;
   Item = inputc(Letter, put(Year, code.));
datalines;
1 A  1 B  2 A  1 C  2 C  2 B
;
title "Listing of Data Set ITEMS";
proc print data=items noobs;
run;

* Program 10.6:  Using the INPUTN function to read dates in mixed formats;
***Primary function: INPUTN
***Other function: PUT;

proc format;
   value which 1 = 'mmddyy10.'
               2 = 'date9.';
run;

data mixed_dates;
   input Which_one Dummy : $10.;
   Date = inputn(Dummy, put(Which_one, which.));
   format Date weekdate.;
datalines;
1 10/21/1980
2 21OCT1980
1 01/01/1960
2 03NOV2003
;
title "Listing of Data Set MIXED_DATES";
proc print data=mixed_dates noobs;
run;

* Program 10.7:  Performing a table look-up using a format and the PUT function;
***Primary functions: PUT, INPUT;

proc format;
   value item 1 = 'APPLE'
              2 = 'PEAR'
              3 = 'GRAPE'
              other = 'UNKNOWN';
   value $cost 'A' - 'C' = '44.45'
               'D'       = '125.'
               other     = ' ';
run;

data table;
   input Item_no Code $ @@;
   Item_name = put(Item_no, item.);
   Amount = input(put(Code, $cost.),9.);
datalines;
1 B   2 D   3 X   4 C
;
title "Listing of Data Set TABLE";
proc print data=table noobs;
run;

* Program 10.8:  Using the PUTC function to assign a value to a character 
                         variable at run time;
***Primary function: PUTC
***Other function: PUT;

proc format;
   value $tool '1' = 'Hammer'
               '2' = 'Pliers'
               '3' = 'Saw';
   value $supply '1' = 'Paper'
                 '2' = 'Pens'
                 '3' = 'Paperclips';
   value type 1 = '$TOOL.'
              2 = '$SUPPLY.';
run;

data tools_supplies;
   input Type Value $; 
   length Name $ 10;
   Format = put(Type, type.);
   Name = putc(Value, Format);
datalines;
1 1
2 1
1 2
2 3
;
title "Listing of Data Set TOOLS_SUPPLIES";
proc print data=tools_supplies noobs;
run;

* Program 10.9:  Using the PUTN function to assign a value to a character 
                         variable at run time;
***Primary function: PUTN;

proc format;
   value tool 1 = 'Hammer'
              2 = 'Pliers'
              3 = 'Saw';
   value supply 1 = 'Paper'
                2 = 'Pens'
                3 = 'Paperclips';
run;
data tools_supplies;
   input Type $ Value;
   Name = putn(Value, Type);
datalines;
TOOL. 1
SUPPLY. 1
TOOL. 2
SUPPLY. 2
;
title "Listing of Data Set TOOLS_SUPPLIES";
proc print data=tools_supplies noobs;
run;

* Program 10.10: Demonstrating the CALL MISSING routine;
***Primary function: CALL MISSING;
title;
data _null_;
   input x1-x3 (Char1-Char3)(: $5.);
   file print;
   put "Values before the CALL:" / 
       (x1-x3)(= 4.) /
       (Char1-Char3)(= $5.)/;
   call missing(of x1-x3,of Char1-Char3);
   put "Values after the CALL:" / 
       (x1-x3)(= 4.) /
       (Char1-Char3)(= $5.)//;
datalines;
1 2 3 a b c
100 . 200 One Two Three
;


* Program 11.1:  Converting FIPS codes to state names and abbreviations;
***Primary functions: FIPNAME, FIPNAMEL, and FIPSTATE;

data fips;
   input Fips @@;
   Upper_state = fipname(Fips);
   Mixed_state = fipnamel(Fips);
   Abbrev      = fipstate(Fips);
datalines;
1 2 3 4 5 34 . 50 95 99
;
title "Listing of Data Set FIPS";
proc print data=fips noobs;
run;

* Program 11.2:  Converting state abbreviations to zip codes, FIPS codes, 
                         and state names;
***Primary functions: STFIPS, STNAME, and STNAMEL;

data state_to_other;
   input State : $2. @@;
   Fips = stfips(State);
   Upper_name = stname(State);
   Mixed_name = stnamel(State);
datalines;
NY NJ nj NC AL
;
title "Listing of Data Set STATE_TO_OTHER";
proc print data=state_to_other noobs;
run;

* Program 11.3:  Converting zip codes to FIPS codes, state names, and state 
                         abbreviations;
***Primary functions: ZIPFIPS, ZIPNAME, ZIPNAMEL, and ZIPSTATE;

data zip_to_other;
   input Zip @@;
   Fips = zipfips(Zip);
   State_caps = zipname(Zip);
   State_mixed = Zipnamel(Zip);
   State_abbre = zipstate(Zip);
   format Zip z5.;
datalines;
1234 12345 08822 98765
;
title "Listing of Data Set ZIP_TO_OTHER";
proc print data=zip_to_other noobs;
run;

* Program 11.4:  Adding a state abbreviation to an address containing only 
                         city and zip code;
***Primary function: ZIPSTATE;

data address;
   input #1 Name $30.
         #2 Street $40.
         #3 City & $20. Zip;
   State = zipstate(Zip);

   file print;
   ***Create Mailing list;
   put Name /
       Street /
       City +(-1) ", " State Zip z5.//;
datalines;
Mr. James Joyce
123 Sesame Street
East Rockaway  11518
Mrs. Deborah Goldstein
87 Hampton Corner Road
Flemington  08822
;

* Program 11.5: Measuring the distance between two coordinates
                or two Zip codes;
***Primary functions: GEODIST ZIPCITYDISTANCE;
data distance;
   *Three Bridges New Jersey: N 40 31.680 W 74 47.968
    Camp Verde Texas: N 29 54.597, W 99 04.242;

   ThreeBridges_N = 40 + 31.680/60;
   ThreeBridges_W = -(74 + 47.968/60);
   CampVerde_N = 29 + 54.597/60;
   CampVerde_W = -(99 + 4.242/60);
   Distance_Geo = GEODIST(ThreeBridges_N, ThreeBridges_W,
                            CampVerde_N, CampVerde_W,'MD');
   Distance_Zip = ZIPCITYDISTANCE(08822, 78010);
run;

title "Distance in Miles between Three Bridges NJ and "
      "Camp Verde TX";
proc print data=distance noobs;
run;

*The code below demonstrates how to create a SAS data set
 from a downloaded Zip code files;
proc cimport infile='c:\zipcodes\zipcode_jan09.cpt'
   data=sashelp.zipcode; 
run;

proc contents data=SASHELP.ZIPCODE;
run;

proc print data=sashelp.zipcode(obs=10);
run;


* Program 12.1:  Creating a table of trigonometric functions;
***Primary functions: COS, SIN, TAN
***Other function: CONSTANT;

data trig_table;
   if _n_ = 1 then Pi = constant('pi');
   retain Pi;

   do Angle = 0 to 360 by 10;
      Radian = Pi*Angle/180;
      Sin = sin(Radian);
      Cos = cos(Radian);
      Tan = tan(Radian);
      output;
   end;

   drop Pi Radian;
run;

options ps=22 missing='-';
title "Table of Basic Trig Functions";
proc report data=trig_table nowd panels=99;
   columns angle sin cos tan;
   define angle / display 'Angle' width=5 format=4.;
   define sin / display 'Sin' width=6 format=6.4;
   define cos / display 'Cos' width=6 format=6.4;
   define tan / display 'Tan' width=6 format=6.2;
run;

* Program 12.2:  Computing arccosines and arcsines;
***Primary functions: ARCOS and ARSIN
***Other function: CONSTANT;

data arc_d_triumph;
   if _n_ = 1 then Pi = constant('pi');
   retain Pi;
   drop Pi;

   do Value = 0 to 1 by .1;
      Cos_radian = arcos(Value);
      Cos_angle = Cos_radian * 180/Pi;
      Sin_radian = arsin(Value);
      Sin_angle = Sin_radian * 180/Pi;
      output;
   end;
run;

title "Listing of data set ARC_D_TRIUMPH";
proc print data=arc_d_triumph noobs;
run;

* Program 12.3:  Computing arctangents;
***Primary function: ATAN;
***Other function: CONSTANT;

data on_a_tangent;
   if _n_ = 1 then Pi = constant('pi');
   retain Pi;
   drop Pi;

   do Value = 0 to 10;
      Tan_radian = atan(Value);
      Tan_angle = Tan_radian * 180/Pi;
      output;
   end;
run;

title "Listing of Data Set ON_A_TANGENT";
proc print data=on_a_tangent noobs;
run;

* Program 13.1:  Using the SYMPUT and SYMPUTX call routines to assign a 
                 value to a macro variable during the execution of a DATA 
                 step;
***Primary functions: SYMPUT and SYMPUTX;

data test;
   input String $char10.;
   call symput("Notx",String);
   call symputx("Yesx",String);
datalines;
   abc         
;
data _null_;
   Nostrip = ":" || "&Notx" || ":";
   Strip   = ":" || "&Yesx" || ":";
   put "Value of Nostrip is  " Nostrip;
   put "Value of Strip is  " Strip;
run;

* Program 13.2:  Passing DATA step values from one step to another, using 
                 macro variables created by CALL SYMPUT and CALL 
                 SYMPUTX;
***Primary functions: SYMPUT and SYMPUTX
***Other functions: STRIP and PUT;

data sum;
   infile "c:\books\functions\data.dta" end=last;
   input n @@;
   sum + n;
   count + 1;
   if last then do;
      call symput("Sum_of_n",strip(put(Sum,3.)));
      call symputx("Number",put(Count,3.));
   end;
run;

title "Listing of Data Set NEXT";
title2 "Summary data: There were &NUMBER values";
title3 "The sum was &SUM_OF_N";
proc print data=sum noobs;
   var n;
run;

* Program 13.3:  Using RESOLVE to pass DATA step values to macro
                 variables during the execution of the DATA step;
***Primary function: RESOLVE;

%let x1 = 10;
%let x2 = 100;
%let x3 = 1000;
data test;
   input n @@;
   Value = resolve('&x' || left(put(n,3.)));
   put _all_;
datalines;
1 3 2 1
;

* Program 13.4:  Using CALL EXECUTE to conditionally execute a macro;
***Primary function: CALL EXECUTE;

%macro simple(Dsn=);
   title "Simple listing - today is &sysday";
   proc print data=&Dsn noobs;
   run;
%mend simple;

%macro complex(Dsn=);
   proc means data=&Dsn n mean std clm maxdec=2;
      title "Complex statistics - Friday";
   run;
%mend complex;

data test;
   input x y @@;
datalines;
7 5 1 2 3 4 9 8
;
data _null_;
   if "&Sysday" ne "Friday" then call execute('%simple(Dsn=Test)');
   else call execute('%Complex(Dsn=Test)');
run;

* Program 13.5: A non-macro example of CALL EXECUTE;
***Primary function: CALL EXECUTE;

data execute;
   String = "proc print data=execute noobs;
   title 'Listing of data set EXECUTE'; run;";
   drop String;
   infile 'c:\books\functions\data2.dat' end=Last;
   input x;
   if Last then call execute(String);
run;

* Program 13.6:  Using the SYMGET function to assign a macro value to a 
                 DATA step variable;
***Primary function: SYMGET
***Other function: CATS;

%let x1 = 5;
%let x2 = 10;
%let x3 = 15;
data test;
   input Type $ Value @@;
   Mult = symget(cats('x',Type));
   New_value = Mult * Value;
datalines;
1 5  2 5  3 5
;
title "Listing of Data Set TEST";
proc print data=test;
run;

* Program 14.1:  Program to create two SAS data sets, TEST and MISS;
data test(label="This is the data set label");
   length X3 4;
   input @1  Subj     $char3.
         @4  DOB    mmddyy10.
         @14 (X1-X3)     (1.)
         @17 F_name   $char10.
         @27 L_name   $char15.;
   label Subj   = 'Subject'
         DOB    = 'Date of Birth'
         X1     = 'The first X'
         X2     = 'Second X'
         X3     = 'Third X'
         F_name = 'First Name'
         L_name = 'Last Name';
   format DOB mmddyy10. X3 roman.;
datalines;
00110/21/1946123George    Hincappie
00211/05/1956987Pincus    Zukerman
00701/01/19903..Jose      Juarez
;

data miss;
   input X Y A$ Z1-Z3;
datalines;
1 2 abc 4 5 6
999 5 xyz 999 4 5
999 999 xxx 9 8 999
2 8 ZZZ 999 999 999
;
proc sort data=test;
   by subj;
run;
title "Listing of Data Set TEST";
proc print data=test noobs label;
run;

title "Listing of Data Set MISS";
proc print data=miss noobs;
run;

* Program 14.2:  Macro to determine the number of observations in a SAS 
                         data set;
***Primary functions: OPEN, EXIST, ATTRN, CLOSE;

%macro nobs(Dsn= /*Data set name */);
   if exist("&Dsn") then do;
      Dsid = open("&Dsn","i");
      Nobs = attrn(Dsid,"Nlobs");
   end;
   else Nobs=.;
   rc = close(Dsid);
%mend nobs;

*Using the macro:;

data useit;
   %nobs(Dsn=test);
   put Nobs=;
run;

* Program 14.3:  Determining the number of observations, variables, and 
                 other characteristics of a SAS data set using SAS I/O 
                 functions;
***Primary functions: OPEN, ATTRC, ATTRN, CLOSE;

title;
data _null_;
   Dsid = open ('test');
   Any = attrn(Dsid,'Any');
   Nlobs = attrn(Dsid,'Nlobs');
   Nvars = attrn(Dsid,'Nvars');
   Label = attrc(Dsid,'Label');
   Engine = attrc(Dsid,'Engine');
   Charset =attrc(Dsid,'Charset');
   Dsn = dsname(Dsid);
   RC = close(Dsid);
   file print;
   put "Characteristics of Data Set Test" /
      40*'-'/
      "Dsid ="    @11 Dsid    /
      "Any ="     @11 Any     /
      "Nlobs ="   @11 Nlobs   /
      "Nvars ="   @11 Nvars   /
      "Label ="   @11 Label   /
      "Engine ="  @11 Engine  /
      "Charset =" @11 Charset /
      "Dsn ="     @11 Dsn     /
      "RC ="      @11 RC;
run;

* Program 14.4:  Determining the format, label, and length attributes of a 
                 variable using the VARFMT, VARLEN, and VARNUM 
                 functions;
***Primary functions: OPEN, VARFMT, VARNUM, VARLABEL, VARLEN, CLOSE;

data _null_;
   length Format Label $ 32;
   Dsid = open("test");
   Order = varnum(Dsid,"x3");
   Format = varfmt(Dsid,Order);
   Label = varlabel(Dsid,Order);
   Length = varlen(Dsid,Order);
   RC = close(Dsid);
   put Order= Format= Label= Length=;
run;

* Program 14.5:  Determining a variable name, given its position in a SAS 
                 data set and vice versa;
***Primary functions: OPEN, VARNAME, VARNUM, CLOSE;

data _null_;
   ID = open("test");
   Var_name = varname(ID,1);
   Var_pos  = varnum(ID,"DOB");
   RC = close(ID);
   put "The name of the 1st variable in data set test is: "  Var_name /
       "The position of variable DOB is: " Var_pos;
run;

* Program 14.6:  A general-purpose macro to display data set attributes 
                 such as number of observations, number of variables, 
                 variable list, variable type, formats, labels, etc.;
***Primary functions: EXIST, OPEN, ATTRN, ATTRC, VARNAME, VARTYPE,
                      VARLEN, VARFMT, VARLABEL, and CLOSE;

%macro dsn_info(Dsn= /* Data set name */);
   title;
   data _null_;
      file print;
      if not exist("&dsn") then do;
         put "Data set &Dsn does not exist";
         stop;
      end;

      Dsid    = open("&Dsn","i");
      Nvars   = attrn(Dsid,"Nvars");
      Nobs    = attrn(Dsid,"Nlobs");
      Charset = attrc(Dsid,"Charset");
      Engine  = attrc(Dsid,"Engine");
      Encrypt = attrc(Dsid,"Encrypt");
      Label   = attrc(Dsid,"Label");
      Sort    = attrc(Dsid,"Sortedby");

      put "Information for Data Set &Dsn" /
          72*'-' // ;
      if not missing(Label) then put "Data set Label is: " Label;
      put "Data set created with engine: " Engine /
          "Character set used: " Charset;
      if encrypt = "YES" then put "Data set is encrypted";
      else put "Data set is not encrypted";
      if Sort = " " then put "Data set is not sorted";
      else put "Data set is sorted by: " Sort /;
      put 
         "Number of Observations: " Nobs /
         "Number of Variables   : " Nvars /
         72*'-' /
         "***** Variable Information *****" //
         @1  "Variable Name"
         @20 "Type"
         @26 "Length"
         @34 "Format"
         @47 "Label"/
         72*'-';
      do i = 1 TO Nvars;
         Name = varname(Dsid,i);
         Type = vartype(Dsid,i);
         if Type = "C" THEN TYPE = "Char";
         else if Type = "N" THEN Type = "Num";
        
         Length = varlen(Dsid,i);
         Fmt = varfmt(Dsid,i);
         Label = varlabel(Dsid,i);

         put @1    Name
             @20   Type
             @26   Length
             @34   Fmt
             @47   Label;
      end;

      RC = close(Dsid);
   run;
%mend dsn_info;

%dsn_info(dsn=test)

* Program 15.1:  Creating a test data set for use with most of the V 
                 functions;
proc format;
   value yesno 1='yes' 0='no';
   invalue read 0-5 = 777
                6-9 = 888
                other = 999;
run;
data var;
   informat Char $char1. y read2. z 3.2 Money dollar5.;
   input @1  x       1.
         @2  Char   $char1.
         @3  y       read2.
         @5  z       3.2
         @8  Money   dollar5.
         @13 (a1-a3) (1.)
         @16 Date     mmddyy10.;
   format x yesno. Money dollar8.2 z 7.4;
   label x = 'The x variable'
         y = 'Pain scale'
         Money = 'Housing cost';
   array oscar[3] a1-a3;
datalines;
1B 31231,765987
0N 86549,123234
;

* Program 15.2:  Determining a variable's type (numeric or character) using 
                 VTYPE and VTYPEX;
***Primary functions: VTYPE, VTYPEX;

data char_num;
   set var;
   Type_x = vtype(x);
   Type_char = vtype(Char);
   Type_a1 = vtypex('a' || put(3-2,1.));
run;

title "Listing of Data Set CHAR_NUM";
proc print data=char_num noobs;
run;

* Program 15.3:  Determining the storage length of character and numeric 
                 variables;
***Primary function: VLENGTH;

data _null_;
   length y 4 Name $ 20;
   x = 123;
   y = 123;
   Char = 'abc';
   Long = 'this is a long character variable';
   Pad = 'a    '; ***a followed by 4 blanks;
   Name = 'Frank';

   L_x = vlength(x);
   L_y = vlength(y);
   L_char = vlength(Char);
   L_long = vlength(Long);
   L_pad = vlength(Pad);
   L_name = vlength(Name);

   put L_x = / 
       L_y = /
       L_char = /
       L_long = /
       L_pad = /
       L_name = ;
run;

* Program 15.4:  Program to replace all numeric values of 999 with a SAS 
                 missing value and to provide a list of variable names where 
                 the changes were made;
***Primary functions: VNAME, SYMPUTX
***Other functions: DIM;
***This data step determines the number of numeric
   variables in the data set and assigns it to a macro variable (N);

data _null_;
   set miss;
   array nums[*] _numeric_;
   call symputx('n',dim(nums));
   stop;
run;

data _null_;
   set miss end=Last;
   file print;
   array nums[*] _numeric_;
   length Names1-Names&n $ 32;
   array names[&n];
   array howmany[&n];
   retain Names1-Names&n;
   do i = 1 to dim(nums);
      if nums[i] = 999 then do;
         nums[i] = .;
         names[i] = vname(nums[i]);
         howmany[i] + 1;
      end;
   end;
   if Last then do i = 1 to &n;
      if not missing(Names[i]) then
      put howmany[i] "Values of 999 converted to missing for variable " 
          Names[i];
   end;
run;

* Program 15.5:  Writing a general purpose macro to replace all occurrences 
                 of a particular value (such as 999) to a SAS missing
                 value and produce a report showing the number of
                 replacements for each variable;
***Primary functions: VNAME, CALL SYMPUT
***Other functions: DIM, LEFT, PUT;

%macro replace_missing (
                        Dsn=,       /* the sas data set name */
                        Miss_value= /* the value of the missing value */
                        );
   title "Report on data set &Dsn";
   data _null_;
      set &Dsn;
      array nums[*] _numeric_;
      N_numbers = left(put(dim(Nums),5.));
      call symput('n',N_numbers);
      stop;
   run;
   data _null_;
      set &Dsn end=Last;
      file print;
      array nums[*] _numeric_;
      array names[&n] $ 32 _temporary_ ;
      array howmany[&n] _temporary_;
      do i = 1 to dim(nums);
         if nums[i] = &Miss_value then do;
            nums[i] = .;
            Names[i] = vname(nums[i]);
            howmany[i] + 1;
         end;
      end;
      if Last then do i = 1 to &n;
         if not missing(Names[i]) then
         put howmany[i] 
            "Values of &Miss_value converted to missing for variable " names[i];
      end;
   run;
%mend replace_missing;

*Testing the macro;
%replace_missing(Dsn=miss,Miss_value=999)

* Program 15.6:  Determining the name, type, and length of all variables in a 
                 SAS data set;
***Primary function: CALL VNEXT;

data var_info;
   if 0 then set var;
   length Var_name $ 32 Var_type $ 1;
   do until (missing(Var_name));
      call vnext(Var_name,Var_type,Var_length);
      if not missing(Var_name) then output;
   end;
   keep Var_:;
run;

title "Listing of Data Set VAR_INFO";
proc print data=var_info noobs;
run;

* Program 14.7:  Demonstrating the VVALUE function;

***Primary functions: VVALUE, PUT;

proc format;
   value $gender 'M'='Male'
                 'F'='Famale';
   value age low-20='Group 1'
             21-30 = 'Group 2';
run;
data test_vvalue;
   input gender : $1. age date : mmddyy10.;
   length V_Date $ 9 V_Age $ 8;
   format Gender $gender. Age age. Date date9.;
   V_Gender = vvalue(Gender);
   ***the storage length of V_Gender is 200;
   V_Age = vvalue(Age);
   V_Date = vvalue(Date);
   Put_Gender = put(Gender,$gender.);
   ***the storage length of Put_Gender is 6;
datalines;
M 23 10/21/1946
F 77 11/23/2009
x 2 9/16/2001
;
title "Listing of TEST_VVALUE";
proc print data=test_vvalue noobs;
run;

* Program 15.8:  Demonstrating a variety of SAS V functions;
***Primary functions: VFORMAT, VFORMATD, VFORMATN, VFORMATW, VINFORMAT, 
***VINFORMATD, VINFORMATN, VINFORMATW, VLABEL;

data vfunc;
   set var(obs=1);
   length Vformat_x Vformat_y Vformat_char Vformat_money 
          Vformatn_x Vformatn_y Vformatn_char Vformatn_money $8.
          Vinformat_x Vinformat_y Vinformat_char Vinformat_money 
          Vinformatn_x Vinformatn_y Vinformatn_char Vinformatn_money $8.
          Vlabel_x Vlabel_y Vlabel_char Vlabel_money $ 40;

   ***format functions;
   Vformat_x = vformat(x);
   Vformat_y = vformat(y);
   Vformat_char = vformat(Char);
   Vformat_money = vformat(Money);
   Vformatn_x = vformatn(x);
   Vformatn_y = vformatn(y);
   Vformatn_char = vformatn(Char);
   Vformatn_money = vformatn(Money);
   Vformatw_x = vformatw(x);
   Vformatw_y = vformatw(y);
   Vformatw_char = vformatw(char);
   Vformatw_money = vformatw(Money);
   Vformatd_x = vformatd(x);
   Vformatd_y = Vformatd(y);
   Vformatd_char = vformatd(Char);
   Vformatd_money = vformatd(Money);
   
   ***informat functions;
   Vinformat_x = vinformat(x);
   Vinformat_y = vinformat(y);
   Vinformat_char = vinformat(Char);
   Vinformat_money = vinformat(Money);
   Vinformatn_x = vinformatn(x);
   Vinformatn_y = vinformatn(y);
   Vinformatn_char = vinformatn(Char);
   Vinformatn_money = vinformatn(Money);
   Vinformatw_x = vinformatw(x);
   Vinformatw_y = vinformatw(y);
   Vinformatw_char = vinformatw(Char);
   Vinformatw_money = vinformatw(Money);
   Vinformatd_x = vinformatd(x);
   Vinformatd_y = vinformatd(y);
   Vinformatd_char = vinformatd(Char);
   Vinformatd_money = vinformatd(Money);

   ***Label information;
   Vlabel_x = vlabel(x);
   Vlabel_y = vlabel(y);
   Vlabel_char = vlabel(Char);
   Vlabel_money = vlabel(Money);
run;

title "Listing of Data Set VFUNC";
proc print data=vfunc noobs heading=h;
   var V:;
run;

* Program 16.1: Demonstrating the bitwise logical functions;
***Primary functions: BAND, BNOT, BOR, BXOR;

title "Demonstrating the Bitwise Logical Functions";
data _null_;
   file print;
   input @1  x binary4. /
         @1  y binary4. /
         @1 Afraid binary8.;

   And = band(x,y);
   Not = bnot(Afraid); ***get it, be not afraid?;
   Or  = bor(x,y);
   Xor = bxor(x,y);
   format x y And Or Xor binary4.
          Afraid Not binary8.;
   put x= y= Afraid= / 60*'-' //
       And= Or= Xor= Not=;
datalines;
0101
1100
11110000
;

* Program 16.2: Enciphering and deciphering text using a key;
***Primary functions: BXOR, RANK, BYTE
***Other functions: SUBSTR (used on both sides of the equal sign), DIM;

data encode;
   array l[5] $ 1;
   array num[5];
   array xor[5];
   retain Key 173;
   input String $char5.;
   do i = 1 to dim(l);
      l[i] = substr(String,i,1);
      num[i] = rank(l[i]);
      xor[i] = bxor(num[i],Key);
   end;
   keep Xor1-Xor5;
datalines;
ABCDE
Help
;
title "Encoded Message";
proc print data=encode noobs;
   var Xor1-Xor5;
run;

data decode;
   array l[5] $ 1;
   array num[5];
   array xor[5];
   retain Key 173;
   length String $ 5;
   set encode;
   do i = 1 to dim(l);
      num[i] = bxor(xor[i],Key);
      l[i] = byte(num[i]);
      substr(String,i,1) = l[i];
   end;
   drop i;
run;

title "Decoding output";
proc print data=decode noobs;
   var String;
run;

* Program 16.3:  Writing general purpose encrypting and decrypting macros;
***Primary functions: BXOR, RANK, BYTE
***Other functions: SUBSTR (used on the left-hand side of the equal sign), DIM, RANUNI;

%macro encode(Dsn=,        /* Name of the SAS data set to hold the
                             encrypted message */
              File_name=,  /* The name of the raw data file that holds
                             the plain text */
              Key=         /* A number of your choice which will be the 
                             seed for the random number generator. A 
                             large number is preferable */
              );
   %let len = 80;
   data &dsn;
      array l[&len] $ 1 _temporary_; /* each element holds a character 
                                        of plain text */
      array num[&len] _temporary_;   /* a numerical equivalent for each
                                        letter */
      array xor[&len];               /* the coded value of each letter */
      retain key &key;
      infile "&file_name" pad;
      input string $char&len..;
      do i = 1 to dim(l);
         l[i] = substr(string,i,1);
         num[i] = rank(l[i]);
         xor[i] = bxor(num[i],ranuni(key));
      end;
      keep xor1-xor&len;
   run;
%mend encode;

%macro decode(Dsn=,        /* Name of the SAS data set to hold the
                             encrypted message */
              Key=         /* A number that must match the key of
                             the enciphered message */
              );
   %let Len = 80;
   data decode;
      array l[&Len] $ 1 _temporary_;
      array num[&Len] _temporary_;
      array xor[&Len];
      retain Key &Key;
      length String $ &Len;
      set &Dsn;
      do i = 1 to dim(l);
         num[i] = bxor(xor[i],ranuni(Key));
         l[i] = byte(num[i]);
         substr(String,i,1) = l[i];
      end;
      drop i;
   run;
   title "Decoding Output";
   proc print data=decode noobs;
      var String;
   run;
%mend decode;

%encode (Dsn=code, File_name=c:\books\functions\plaintext.txt, Key=17614353)
%decode (Dsn=code, Key=17614353)


