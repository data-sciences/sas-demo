 /*-------------------------------------------------------------------*/
 /*       Carpenter's Complete Guide to the SAS(R) Macro Language     */
 /*                         by Art Carpenter                          */
 /*       Copyright(c) 1998 by SAS Institute Inc., Cary, NC, USA      */
 /*                   SAS Publications order # 56100                  */
 /*                        ISBN 1-58025-137-4                         */
 /*-------------------------------------------------------------------*/
 /*                                                                   */
 /* This material is provided "as is" by SAS Institute Inc.  There    */
 /* are no warranties, express or implied, as to merchantability or   */
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
 /* Attn: Art Carpenter                                               */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  sasbbu@sas.com             */
 /* Use this for subject field: Comments for Art Carpenter            */
 /*                                                                   */
 /*-------------------------------------------------------------------*/

Following are the programs used in the text and appendicies of the book.

Search for the appropriate code by finding the section number associated
with the program in the book.  For instance to find the code used in
section 3.1.2 search for the string ***3.1.2***.  The examples available
listed below.

For those macros that are named you may also search for the name of the macro.

The following examples are contained in this file:

***2.6.1***
***2.6.3***
***2.7.1***
***2.7.2***
***2.9***
***3.1.1***
***3.1.2***
***3.4***
***3.5.2***
***3.7***
***4.2.1***
***4.2.2***
***4.3.1***
***4.4***
***4.6***
***5.1.1a***
***5.1.1b***
***5.2.2***
***5.3.1***
***5.3.2***
***5.3.3***
***5.3.4***
***5.6.8***
***5.6.9***
***6.2.1a***
***6.2.1b***
***6.2.1c***
***6.2.2***
***6.3***
***6.4.1***
***6.4.2a***
***6.4.2b***
***7.1.2***
***7.2.2***
***7.2.3***
***7.3.3***
***7.4.2a***
***7.4.2b***
***8.2.4***
***8.3.2***
***9.1***
***9.2***
***9.3***
***10.1.1***
%CATCOPY
***10.1.2***
%DUMPIT
Clarence Wm. Jackson
***10.1.3***
%UPDATE
Jorn Lodahl
***10.1.4***
%CHKCOPY
***10.1.5a***
%CMBNSUBJ
***10.1.5b***
%CMBNSUBJ
***10.1.5c***
%CMBNSUBJ
***10.2.1***
%TF
David Shannon
***10.2.2***
%REPORT
Paul Kairis
NIKH Corporation
***11.1.1***
%SAS2RAW
***11.1.2***
%DELIM
Susan Haviar
***11.2.1***
%TOPPCNT
Diane Goldschmidt
***11.2.2***
%SELPCNT
***11.2.3a***
%RAND_WO
***11.2.3b***
%RAND_W
***11.3***
%EXIST
***11.4.1a**
Kim Kubasek
***11.4.1b***
Kim Kubasek
***11.4.2***
Jorn Lodahl
***11.5.1***
%OBSCNT
***11.5.2***
 %TESTPRT
Jerry Kagan
Kagan Associates, Inc.
***12.2.2***
%LEFT
SAS Institute, Inc.
***12.2.3***
%CMPRES
SAS Institute, Inc.
***12.2.4***
%LOWCASE
SAS Institute, Inc.
***13.1.1***
%COUNTER
David Shannon
***13.1.2***
%INDVAR
Jorn Lodahl
***13.1.3***
%SUMS
Justina M. Flavin
STATPROBE, Inc.
***13.1.4***
%GETKEYS
Richard O. Smith
Science Explorations
***13.1.5***
%SYMCHK
***13.2***
%DBVAL
***A.2.1***
***A.2.3***
***A.3.1***
***A.4.3***
***A.5.2***
***A.5.6***
***A.5.7***
***A.6.2***
***A.6.3***
***A.6.4***
***A.7.4***
***BIOMASS***
***CLINICS***


***2.6.1***

          data old;
          do batch=1 to 3;
            conc=2;
            datadate='02jan97'd;
            datatime = '09:00't;
            output;
          end;
          format datadate mmddyy10. datatime time5.;
          run;

          data new;
          set old;
          if batch = 2 then do;
            conc=2.5;
            datadate="&sysdate"d;
            datatime="&systime"t;
          end;
          run;

          proc print data=new;
          title1 'Drug concentration';
          title2 "Mod date &sysdate";
          run;

          ***2.6.3***

          * Copy the current version of the COMBINE files
          * to COMBTEMP;
          proc datasets memtype=data;
             copy in=combine out=combtemp;
          quit;
          %put SYSERR is  &syserr;

***2.7.1***

          %let cln = Beth;
          proc sql noprint;
          select count(*)
                 into :nobs
                 from clinics(where=(clinname=:"&cln"));
          quit;

          %put number of clinics for &cln is &nobs;

***2.7.2***

          data class;
          input name $ 8. grade $1.;
          cards;
          Billy   B
          Jon     C
          Sally   A
          run;

          data school;
          input name $ 8. gradcode $1.;
          cards;
          Billy   Y
          Frank   Y
          Jon     N
          Laura   Y
          Sally   Y
          run;

          proc sql noprint;
          select quote(name)
              into :clnames separated by ' '
             from class;
          quit;

          data clasgrad;
          set school (where=(name in(&clnames)));
          run;

          proc print data=clasgrad;
          title 'Class Graduate Status';
          run;

***2.9***

          *******************************************************;
          **** The class data set, CLINICS,  contains 80     ****;
          **** observations and 20 variables.  The following ****;
          **** program will be used to complete the exercises****;
          **** in this chapter.                              ****;
          *******************************************************;

          PROC PLOT DATA=CLASS.CLINICS;
                PLOT EDU * DOB;
                TITLE1 'YEARS OF EDUCATION COMPARED TO BIRTH DATE';
          RUN;

          PROC CHART DATA=CLASS.CLINICS;
                VBAR WT / SUMVAR=HT TYPE=MEAN;
                TITLE1 'AVERAGE HEIGHT FOR WEIGHT GROUPS';
          RUN;


***3.1.1***

          %LET DSN = CLINICS;

          %MACRO LOOK;


          PROC CONTENTS DATA=&dsn;
               TITLE "DATA SET &dsn";
          RUN;

          PROC PRINT DATA=&dsn (OBS=10);
          RUN;

          %MEND LOOK;

***3.1.2***

          DATA invert.SPECIE;
             INFILE 'SPECIES.mas';
             LENGTH  SPCODE $ 5 SPNAME $ 40;
             INPUT   SPCODE 21-25 SPNAME;
          run;

          %macro comment;
          * Create the POSITION data set;
          DATA DBMASTER.POSITION;
             INFILE POS;
             LENGTH POS $ 2;
             INPUT POS 1-2 /*COORD 4-8*/;
             FILE ERRS;
             IF _ERROR_ THEN PUT '-1';
          run;
          %mend comment;


          data new;
          set big;
          run;

          %macro debugnew;
          proc print data=new (obs=5);
          title 'listing for NEW';
          run;
          %mend debugnew;

***3.4***

          %macro pgm;
             pgm;
             recall;
             zoom on;
          %mend pgm;

***3.5.2***

          option cmdmac;

          %macro zpgm / cmd;
             pgm;
             recall;
             zoom on;
          %mend zpgm;

***3.7***

          *******************************************************;
          **** The class data set, CLINICS,  contains 80     ****;
          **** observations and 20 variables.  The following ****;
          **** program will be used to complete the exercises****;
          **** in this chapter.                              ****;
          *******************************************************;

          PROC PLOT DATA=CLASS.CLINICS;
                PLOT EDU * DOB;
                TITLE1 'YEARS OF EDUCATION COMPARED TO BIRTH DATE';
          RUN;

          PROC CHART DATA=CLASS.CLINICS;
                VBAR WT / SUMVAR=HT TYPE=MEAN;
                TITLE1 'AVERAGE HEIGHT FOR WEIGHT GROUPS';
          RUN;


***4.2.1***

          %MACRO DOCHART(VAR1,VAR2);
          proc chart data=ptstats;
          vbar &var1 &var2;
          run;
          %mend dochart;


          %MACRO LOOK(dsn,obs);

               PROC CONTENTS DATA=&dsn;
                    TITLE "DATA SET &dsn";
               RUN;

               PROC PRINT DATA=&dsn (OBS=&obs);
                    TITLE2 "FIRST &obs OBSERVATIONS";
               RUN;

          %MEND LOOK;


***4.2.2***

          %MACRO SORTIT(DSN,BY1,BY2,BY3);

               PROC SORT DATA=&DSN;
                    BY &BY1 &BY2 &BY3;
               RUN;

          %MEND SORTIT;

***4.3.1***

          %MACRO LOOK(dsn=CLINICS,obs=);

               PROC CONTENTS DATA=&dsn;
                    TITLE "DATA SET &dsn";
               RUN;

               PROC PRINT DATA=&dsn (OBS=&obs);
                    TITLE2 "FIRST &obs OBSERVATIONS";
               RUN;

          %MEND LOOK;

***4.4***

          %MACRO LOOK(dsn,obs=10);
               PROC CONTENTS DATA=&dsn;
                    TITLE "DATA SET &dsn";
               RUN;

               PROC PRINT DATA=&dsn (OBS=&obs);
                    TITLE2 "FIRST &obs OBSERVATIONS";
               RUN;
          %MEND LOOK;

***4.6***

          *******************************************************;
          **** The class data set, CLINICS, contains 80     ****;
          **** observations and 20 variables.  The following ****;
          **** program will be used to complete the exercises****;
          **** in this chapter.                              ****;
          *******************************************************;

          PROC PLOT DATA=CLASS.CLINICS;
                PLOT EDU * DOB;
                TITLE1 'YEARS OF EDUCATION COMPARED TO BIRTH DATE';
          RUN;

          PROC CHART DATA=CLASS.CLINICS;
                VBAR WT / SUMVAR=HT TYPE=MEAN;
                TITLE1 'AVERAGE HEIGHT FOR WEIGHT GROUPS';
          RUN;


***5.1.1a***

          %MACRO DOBOTH;
               %SORTIT(CLINICS,LNAME,FNAME)
               %LOOK(OBS=10)
          %MEND DOBOTH;

          %MACRO LOOK(dsn=CLINICS,obs=);
               PROC CONTENTS DATA=&dsn;
                    TITLE "DATA SET &dsn";
               RUN;
               PROC PRINT DATA=&dsn (OBS=&obs);
                    TITLE2 "FIRST &obs OBSERVATIONS";
               RUN;
          %MEND LOOK;

          %MACRO SORTIT(DSN,BY1,BY2,BY3);
               PROC SORT DATA=&DSN;
                    BY &BY1 &BY2 &BY3;
               RUN;
          %MEND SORTIT;

***5.1.1b***

          %MACRO DOBOTH(d,o,b1,b2,b3);
               %SORTIT(&d,&b1,&b2,&b3)
               %LOOK(&d,&o)
          %MEND DOBOTH;

          %MACRO LOOK(dsn,obs);
               PROC CONTENTS DATA=&dsn;
                    TITLE "DATA SET &dsn";
               RUN;
               PROC PRINT DATA=&dsn (OBS=&obs);
                    TITLE2 "FIRST &obs OBSERVATIONS";
               RUN;
          %MEND LOOK;

          %MACRO SORTIT(DSET,BY1,BY2,BY3);
               PROC SORT DATA=&DSET;
                    BY &BY1 &BY2 &BY3;
               RUN;
          %MEND SORTIT;

***5.2.2***

          %macro senrate(&num);

           ... code not shown ...

          data senrate.rtsen&num;
          set ratedata;
          * Table 5 has sex already defined.  3 & 7 do not;
          * output one obs for each sex;
          %if &num=5 %then output senrate.rtsen&num;
          %else %do;
             * output the obs for each sex;
             sex='F';output senrate.rtsen&num;
             sex='M';output senrate.rtsen&num
          %end;;

           ... code not shown ...

          %mend senrate;

***5.3.1***


          %MACRO DOBOTH(dsn,obs,by1,by2,by3);

               %IF &BY1 ^= %THEN %DO;
                    PROC SORT DATA=&DSN;
                         BY &BY1 &BY2 &BY3;
                    RUN;
               %END;

               PROC CONTENTS DATA=&dsn;
                    TITLE "DATA SET &dsn";
               RUN;

               PROC PRINT DATA=&dsn
               %IF &OBS>0 %THEN %DO;
                    (OBS=&obs);
                    TITLE2 "FIRST &obs OBSERVATIONS"
               %END;
                    ;
               RUN;
          %MEND DOBOTH;

***5.3.2***

          %MACRO ALLYR(START,STOP);
             DATA ALLYEAR;
                SET
                %DO YEAR = &START %TO &STOP;
                      YR&YEAR(IN=IN&YEAR)
                %END;;

                YEAR = 1900
                %DO YEAR = &START %TO &STOP;
                     + (IN&YEAR*&YEAR)
                %END;;

                RUN;
          %MEND ALLYR;

***5.3.3***

          %MACRO ALLYR(START,STOP);
               %LET CNT = 0;
               %DO %UNTIL(&YEAR >= &STOP);
                    %LET YEAR = %EVAL(&CNT + &START);

                    DATA TEMP;
                         SET YR&YEAR;
                         YEAR = 1900 + &YEAR;
                    RUN;

                    PROC APPEND BASE=ALLYEAR DATA=TEMP;
                    RUN;

                    %LET CNT = %EVAL(&CNT + 1);
               %END;
          %MEND ALLYR;

***5.3.4***

          %MACRO ALLYR(START,STOP);
               %LET CNT = 0;
               %DO %WHILE(&YEAR <= &STOP);
                    %LET YEAR = %EVAL(&CNT + &START);

                    DATA TEMP;
                         SET YR&YEAR;
                         YEAR = 1900 + &YEAR;
                    RUN;

                    PROC APPEND BASE=ALLYEAR DATA=TEMP;
                    RUN;

                    %LET CNT = %EVAL(&CNT + 1);
               %END;
          %MEND ALLYR;

***5.6.8***

          %macro regtest(indat,outdat);
            proc reg data=&indat;
            model count=distance;
            output out=&outdat r=resid;
            run;
          %mend regtest;

          %macro dotests(indat,outdat);
            data r1;
            set &indat;
            if station=1;
            run;
            %regtest(r1,r1out);

            data r2;
            set &indat;
            if station=2;
            run;
            %regtest(r2,r2out);

            data &outdat;
            set r1out r2out;
            run;
          %mend dotests;

          %dotests(biodat,bioreg)

***5.6.9***

          %let a = AAA;
          %macro try;
          %put &a;
          %if  &a   =  AAA  %then %put no quotes;
          %if '&a'  = 'AAA' %then %put single quotes;
          %if 'AAA' = 'AAA' %then %put exact strings;
          %if "&a"  = "AAA" %then %put double quotes;
          %if "&a"  = 'AAA' %then %put mixed quotes;
          %if "&a"  =  AAA  %then %put quotes on one side only;
          %mend;
          %try

***6.2.1a***

          %MACRO PLOTIT;
             PROC SORT DATA=CLINICS;
               BY REGION;
             RUN;

             * Count the unique regions and create
             * a macro variable for each value.;
             DATA _NULL_;
               SET CLINICS;
               BY REGION;
               IF FIRST.REGION THEN DO;
                  * Count the regions;
                  I+1;
                  * Create char var with count (II).  Allow;
                  * up to 99 unique regions;
                  II=LEFT(PUT(I,2.));
                  * Assign value of region to a mac var;
                  CALL SYMPUT('REG'||II,REGION);
                  CALL SYMPUT('TOTAL',II);
               END;
            RUN;

          * Do a separate PROC PLOT step for;
          * each unique region;
          %DO I=1 %TO &TOTAL;
            PROC PLOT DATA=CLINICS;
               PLOT HT * WT;
               WHERE REGION="&&REG&I";
               TITLE1 "Height/Weight for REGION &&REG&I";
            RUN;
          %END;
          %MEND PLOTIT;

***6.2.1b***

          %MACRO PLOTIT;
             PROC SORT DATA=CLINICS
                       OUT=REGCLN(KEEP=REGION)
                       NODUPKEY;
               BY REGION;
             RUN;
             DATA _NULL_;
               SET REGCLN END=EOF;
               * Count the regions;
               I+1;
               * Create char var with count (II);
               II=LEFT(PUT(I,2.));
               CALL SYMPUT('REG'||II,REGION);
               IF EOF THEN CALL SYMPUT('TOTAL',II);
            RUN;
          %DO I=1 %TO &TOTAL;
            PROC PLOT DATA=CLINICS;
               PLOT HT * WT;
               WHERE REGION="&&REG&I";
               TITLE1 "Height/Weight for REGION &&REG&I";
            RUN;
          %END;
          %MEND PLOTIT;

***6.2.1c***

          %macro doit;

          * Create the macro variables.
          * One set for each STATION X DEPTH;
          data _null_;
          set a1;
          by station depth;
          length ii $1 dd $2 fn $14;
          if first.depth then do;
             i+1;
             ii = left(put(i,2.));
             * Create a character value of the numeric depth;
             dd = trim(left(put(depth,3.)));
             * Construct the filename;
             fn = compress(station || dd || '.dat');
             call symput('i',ii);
             call symput('d'||ii,dd);
             call symput('sta'||ii,station);
             call symput('fn'||ii,fn);
          end;
          run;

          * There will be &i files;
          %do j=1 %to &i;
             filename toascii "&&fn&j";
            * print the ascii files;
             data _null_;
             set a1;
             where station="&&sta&j" and depth=&&d&j;
             cnt + 1;
             file toascii;
             if cnt=1 then put '**********  ' "&&fn&j";
             put @1 date mmddyy8. @10 aveday;
             run;
          %end;
          %mend doit;

          %doit

***6.2.2***

          data relation;
          family = 'MC24';
          relation='mom'; name='Sally'; output;
          relation='dad'; name='Fred'; output;
          relation='son'; name='Clint'; output;
          family = 'MC33';
          relation='mom'; name='Jane'; output;
          relation='dad'; name='John'; output;
          relation='son'; name='Jack'; output;
          run;

          %macro listfam(famcode);
          data _null_;
          set relation;
          where family="&famcode";
          * Create one macro var for each observation.
          * Use RELATION to name the macro var and NAME for its value;
          call symput(relation,name);
          run;

          proc print data=reunion(where=(mother="&mom" & father="&dad"));
          run;
          %mend listfam;
          %listfam(MC24)

***6.3***
          * Load the names of the
          * data sets;
          data _null_;
          length ii $2;
          infile 'pages.txt'
                  missover;
          input @1 dsn $8.;
          I+1;
          ii = left(put(i,2.));
          call symput('n',ii);
          call symput('dsn'||ii,left(dsn));                      run;

***6.4.1***

          %do q = 1 %to &n;
           PROC FSEDIT DATA=dedata.p&&dsn&q  mod
            SCREEN=GLSCN.descn.p&&dsn&q...SCREEN;
           RUN;
          %end;

***6.4.2a***

          %global keyfld;
          %macro keyfld(pggrp);
           %if &pggrp = 012_015 %then
              %let keyfld = subject dgtyp;
           %else %if &pggrp = 016_017 %then
              %let keyfld = subject sess occ1;
           %else %if &pggrp = 018 %then
              %let keyfld = subject aepga_;
          %mend keyfld;

          %KEYFLD(&&DSN&I)


***6.4.2b***

          %macro chkdup;
          %do i=1 %to &n;
             *.... code not shown ....;

             *determine the list of key vars;
             %keyfld(&&dsn&i)
             data _null_;
             * count the number of keyvars
             * save each for later;
             str="&keyfld";
             do i = 1 to 6;
                key = scan(str,i,' ');
                if key ne ' ' then do;
                   ii=left(put(i,1.));
                   call symput('key'||ii,trim(left(key)));
                   call symput('keycnt',ii);
                end;
             end;
             run;

             * Make sure that there are no
             * duplicate keys;
             %let dupp = 0;
             data dupp; set dedata.p&&dsn&i;
             by &keyfld;
             * determine if this is a dup obs;
             if not (first.&&key&keycnt and last.&&key&keycnt);
             call symput('dupp','1');
             run;

             *.... code not shown ....;
          %end;
          %mend chkdup;

***7.1.2***

          %macro exist(dsn);
          %global exist;
          %if &dsn ne %then %str(
             data _null_;
             if 0 then set &dsn;
             stop;
             run;
          );
          %if &syserr=0 %then %let exist=yes;
          %else %do;
             %let exist=no;
             %put PREVIOUS ERROR USED TO CHECK FOR PRESENCE ;
             %put OF DATASET & IS NOT A PROBLEM;
          %end;
          %mend exist;

***7.2.2***

          %MACRO LOOK(dsn,obs);
          %if %length(&dsn) gt 8 %then
               %put Name is too long - &dsn;
          %else %do;

               PROC CONTENTS DATA=&dsn;
                    TITLE "DATA SET &dsn";
               RUN;

               PROC PRINT DATA=&dsn (OBS=&obs);
                    TITLE2 "FIRST &obs OBSERVATIONS";
               RUN;

          %MEND LOOK;

***7.2.3***

          %Macro cntvar;
               %let I = 1;
               %do %until(%scan(&keyfld,&I,%str( ) )=%str() );
                  %let var&I = %scan(&keyfld,&I,%str( ) );
                  %let I = %eval(&I + 1);
               %end;
               %let cnt = %eval(&I-1);
          %mend cntvar;

***7.3.3***

          %macro figureit(a,b);
            %let y=%sysevalf(&a+&b);
            %put The result with SYSEVALF is: &y;
            %put  Type BOOLEAN is: %sysevalf(&a +&b, boolean);
            %put  Type CEIL is: %sysevalf(&a +&b, ceil);
            %put  Type FLOOR is: %sysevalf(&a +&b, floor);
            %put  Type INTEGER is: %sysevalf(&a +&b, int);
          %mend figureit;

          %figureit(100,1.597)

***7.4.2a***

          %macro engchng(engine,dsn);
          * engine - output engine for this &dsn
          * dsn    - name of data set to copy
          *;

          data _null_;
            * libref for location of new file;
            aa = pathname("sasuser");
            call symput('outpath',aa);
          run;

          * Create a libref for the stated Engine;
          libname dbmsout clear;
          libname dbmsout &engine "&outpath";

          * Copy the SAS data set using the alternate engine;
          proc datasets;
          copy in=sasuser out=dbmsout;
          select &dsn;
          run;

          %mend engchng;

          ***************************************************;
          %engchng(v604,classwt)    * convert to alt. engine;

***7.4.2b***

          %macro engchng(engine,dsn);
          * engine - output engine for this &dsn
          * dsn    - name of data set to copy
          *;

          * Create a libref for the stated Engine;
          libname dbmsout clear;
          libname dbmsout &engine "%sysfunc(pathname(sasuser))";

          * Copy the SAS data set using the alternate engine;
          proc datasets;
          copy in=sasuser out=dbmsout;
          select &dsn;
          run;

          %mend engchng;

          ***************************************************;
          %engchng(v604,classwt)  * convert to alt. engine;

***8.2.4***

          INIT:
             * Specify a macro var used for SCL in edit screens;
             call symput('scrntype','DE');

             * Create a libref for the log used
             * by this Data Entry userid;
             userid = symget('userid');
             tst = symget('tst');
             path = compress('h:\studyx\phase2\'
                    ||tst||'datprep\d_entry\'
                    ||userid);
             call libname('delog',path);
             control enter;
             cursor subject;
          return;

***8.3.2***

          %macro datastmp(var1,var2,var3,var4);

          * determine the number of vars;
          %do i = 1 %to 4;
             %if &&var&i ne %then %let varcnt = &i;
          %end;

          fseinit:
             scrntype=symget('scrntype');
             if scrntype in ('CLN', 'PED') then do;
                control enter;

             . . . . ordinary SCL not shown . . . .
          return;

          init:
             if scrntype='DE' or word(1)='ADD' then do;
             %do i = 1 %to &varcnt;
                unprotect &&var&i;
                &&var&i = symget("&&var&i");
                protect &&var&i;
             %end;
             end;
          return;

          . . . . ordinary SCL not shown . . . .

          %mend datastmp;


***9.1***

%if &nobs ge 10 %then %do;
   proc means data=statdata mean n stderr;
   var ht wt;
   title "Analysis Data - &nobs Observations";
   run;
%end;
%else %if &nobs gt 0 %then %do;
   proc print data=statdata;
   var subject ht wt;
   title "Data NOT Summarized";
   run;
%end;
%else %put Data Set STATDATA is empty;


***9.2***

%macro onereg;
   proc sort data=sasclass.clinics out=clinics;
      by region;
      run;
   data _null_;
      set clinics;
      by region;
      if first.region then do;
         i+1;
         ii=left(put(i,2.));
         call symput('reg'||ii,region);
         call symput('total',ii);
      end;
      run;

   %do i=1 %to &total;
      proc means data=clinics mean n stderr;
         where region="&&reg&i";
         var ht wt;
         title1 "summary for height and weight";
         title2 "region &&reg&i";
         run;
      proc plot data=clinics;
         where region="&&reg&i";
         plot ht * wt;
         title1 "plot of height and weight";
         title2 "region &&reg&i";
         run;
   %end;
%mend onereg;


***9.3***


data  %do i = 1 %to &total; r&&reg&i %end;;
   set clinics;
   %* Build the &total output statements;
   %do i = 1 %to &total;
      %if &i=1 %then if region="&&reg&i" then output r&&reg&i;
      %else else if region="&&reg&i" then output r&&reg&i;
      ;
   %end;
   run;


***10.1.1***
%CATCOPY


* Copy catalogs from the TEST to the PRODUCTION
* areas.;

options nomprint nomlogic nosymbolgen;

%macro catcopy(test,prod);
* test  - libref for the test area
* prod  - libref for the production area
*;

* Determine catalogs in TEST area;
data _null_;
set sashelp.vscatlg(where=(libname="%upcase(&test)"));
length ii $2;

* Select only some of the catalog members;
if memname in: ('DE', 'ED', 'PH');

i+1;
ii=left(put(i,2.));
call symput('cname'||ii,memname);
call symput('catcnt', ii);
run;

proc datasets ;
copy in=&test out=&prod memtype=catalog;
select
  %do i = 1 %to &catcnt;
      &&cname&i
  %end;
;
quit;
%mend catcopy;

%catcopy(appls,work)

***10.1.2***
%DUMPIT
Clarence Wm. Jackson

%MACRO DUMPIT (CNTOUT);
 %* Create a local counter;
 %LOCAL CWJ;

 %DO CWJ=1 %TO &NUMOBS;

  %* Fileref to identify the file to list;
  FILENAME DUMP&CWJ "&&INVAR&CWJ"   DISP=SHR;

  * Read and write the first &CNTOUT records;
  DATA _NULL_;
    INFILE DUMP&CWJ END=DONE;
    * Read the next record;
    INPUT;
    INCNT+1;
    IF INCNT LE &CNTOUT THEN LIST;
    IF DONE THEN DO;
       FILE PRINT;
       PUT //@10 "TOTAL RECORDS FOR &&INVAR&CWJ IS "
             +2 INCNT COMMA9. ;
    END;
  RUN;

  FILENAME DUMP&CWJ CLEAR;

 %END;
%MEND DUMPIT; * The Macro definition ends;

* Read the control file and establish macro variables;
DATA DUMPIT;
 INFILE CARDS END=DONE;
 INPUT FILENAM $25.;
 CNT+1;
 NEWNAME=TRIM(FILENAM);
 * The macro variable INVARi contains the ith file name;
 CALL SYMPUT ('INVAR'!!TRIM(LEFT(PUT(CNT,3.))),NEWNAME);
 * Store the number of files to read;
 IF DONE THEN CALL SYMPUT('NUMOBS',CNT);
CARDS;
PNB7.QSAM.BANK.RECON
PNB7.QSAM.CHECKS
PNB7.QSAM.CHKNMBR
PNB7.QSAM.CKTOHIST
PNB7.QSAM.DRAIN
PNB7.QSAM.RECON
PNB7.BDAM.BDAMCKNO
PNB7.BDAM.VCHRCKNO
PNB7.QSAM.CS2V3120.CARDIN
PNB7.QSAM.CASVCHCK
PNB7.QSAM.CASVOUCH
PNB7.QSAM.VCHR3120.CARDIN
PNB7.QSAM.VOUCHERS
TAX7.JACKSON
;;;

TITLE "CITY OF DALLAS - ECI (FINSYS), JOBNAME IS &SYSJOBID";
TITLE2 "LIST OF FILES TO DUMP &CNTOUT RECORDS";
PROC PRINT data=dumpit;
RUN;

* Pass the number of records to dump from each file;
%DUMPIT (25);


***10.1.3***
%UPDATE
J rn Lodahl

/*****************************************************
SYNTAX:
  %update(string_var)
EXAMPLES:
  %update(all)
  %update(timestr)
This macro updates some or all of the following date/time
string macro variables:
  &timestr
  &todaystr
  &nowstr
*******************************************************/

%macro update(string);
%global timestr todaystr nowstr;
  %if &string=all %then %do;
    %let string=nowstr;
  %end;
  data _null_;
    %if &string=todaystr or &string=nowstr %then %do;
      call symput('todaystr',put(today(),worddate.));
    %end;
    %if &string=timestr or &string=nowstr %then %do;
      call symput('timestr',put(time(),HHMM.));
    %end;
    %if &string=nowstr %then %do;
      %let nowstr=&timestr&todaystr;
    %end;
  run;
%mend update;


***10.1.4***
%CHKCOPY


%macro chkcopy;
* Copy the current version of the COMBINE files
* to COMBTEMP;
proc datasets memtype=data;
   copy in=combine out=combtemp;
quit;
%if &syserr ge 5 %then %do;
data _null_;
   put '***************************';
   put '***************************';
   put '***************************';
   put '*** combine copy failure **';
   put 'One of the data sets may be in use.';
   put '***************************';
   put '***************************';
   put '***************************';
   abort;
run;
* When aborted (inside this macro do block) nothing else
* should execute in this job including the following
* message;
%put JOB ABORTED!!!!
%put this message should not ever be written!!;
%end;
%mend chkcopy;


***10.1.5a***
%CMBNSUBJ


%macro cmbnsubj;

* Determine the subjects, make a macro var for each;
* DECNTRL.INxxxxxx data sets have one obs per subject;
data _null_;
set sashelp.vtable(keep=libname memname);
where libname='DECNTRL' & memname=:'IN';
length ii $3 subject $6;
i+1;
ii=left(put(i,3.));
subject=substr(memname,3);
call symput('subj'||ii,subject);
call symput('subjcnt',ii);
run;

proc datasets library=work;
delete subjstat;

* Combine the subject control files;
%do i = 1 %to &subjcnt;
   append base=subjstat data=decntrl.in&&subj&i;
%end;
quit;
%mend cmbnsubj;


***10.1.5b***
%CMBNSUBJ



%macro cmbnsubj;

* Determine the subjects, make a macro var for each;
* DECNTRL.INxxxxxx data sets have one obs per subject;

* Create a list of all data sets in the libref DECNTRL;
* ALLCONT will have one observation for each variable in each data set;
proc contents data=decntrl._all_
              out=allcont(keep=memname)
              noprint;
run;

* Eliminate duplicate observations;
proc sort data=allcont nodupkey;
  by memname;
  run;

data _null_;
set allcont;
where memname=:'IN';
length ii $3 subject $6;
i+1;
ii=left(put(i,3.));
subject=substr(memname,3);
call symput('subj'||ii,subject);
call symput('subjcnt',ii);
run;

proc datasets library=work;
delete subjstat;

* Combine the subject control files;
%do i = 1 %to &subjcnt;
   append base=subjstat data=decntrl.in&&subj&i;
%end;
quit;
%mend cmbnsubj;


***10.1.5c***
%CMBNSUBJ

%macro cmbnsubj;

* Determine the subjects, make a macro var for each;
* DECNTRL.INxxxxxx data sets have one obs per subject;

* Create a list of all data sets in the libref DECNTRL;
%let depath = %sysfunc(pathname(decntrl));

x "dir &depath\in*.sd2 /o:n /b > d:\junk\dirhold.txt";

data null;
infile 'd:\junk\dirhold.txt' length=len;
input @;
input memname $varying12. len;
length ii $3 subject $6;
i+1;
ii=left(put(i,3.));
subject=substr(memname,3,len-6);
call symput('subj'||ii,subject);
call symput('subjcnt',ii);
run;

proc datasets library=work;
delete subjstat;

* Combine the subject control files;
%do i = 1 %to &subjcnt;
   append base=subjstat data=decntrl.in&&subj&i;
%end;
quit;
%mend cmbnsubj;


***10.2.1***
%TF
David Shannon


/*______________________________________________________________
|                                                              |
|                               TF                             |
|                              ____                            |
|                                                              |
| TF macro allows Titles or Footnotes to be specified in any   |
| combination of LEFT, CENTRED or RIGHT aligned in one line.   |
| The user can optionally stop the output page number from being|
| overwritten.  Specifying SLINE in the LEFT parameter will    |
| print a solid line the width of the page.                    |
|______________________________________________________________|
|            |         |                                       |
| Parameter  | Default | Description                           |
|____________|_________|_______________________________________|
|            |         |                                       |
| TF=        | TITLE   | OPTIONAL:  Parameter which defines if |
|            |         | texts are TITLEs or FOOTNOTEs.        |
|            |         |                                       |
| N=         | 1       | OPTIONAL:  Title/Footnote number.  SAS|
|            |         | currently allows up to 10 titles /    |
|            |         | footnotes.                            |
|            |         |                                       |
| Left=      |         | OPTIONAL:  Text to be left aligned.   |
|            |         | If you                                |
|            |         | specify SLINE then a solid line will  |
|            |         | be                                    |
|            |         | drawn the width of the linesize.      |
|            |         |                                       |
| Centre=    |         | OPTIONAL:  Text to be centred on the  |
|            |         | page.                                 |
|            |         |                                       |
| Right=     |         | OPTIONAL:  Text to be right aligned.  |
|            |         |                                       |
| PNum=      | NO      | OPTIONAL:  Used when TF is a TITLE,   |
|            |         | and if set to YES it stops right      |
|            |         | set to YES it stops right aligned     |
|            |         | title1 from over writing the automatic| |            |         | page
number.                          |
|            |         | NB: Use OPTIONS NUMBER to start page  |
|            |         | numbering.                            |
|____________|_________|_______________________________________|
|                                                              |
| Usage      : See documentation in the software library.      |
|                                                              |
| Written by : David Shannon, V1.0, Spring 97, Engine 6.10+    |
|              david@schweiz.demon.co.uk                       |
|              David Shannon, V1.1, 09SEP1997, Engine 6.12.    |
|              (Reduced to LS-2 allowing paging macros to work)|
|                                                              |
| References : SAS Language, Version 6, SAS Institute.         |
|            : SAS Guide to Macro Processing, Version 6,       |
|            : SAS nst.                                        |
|____________________________________________________________*/;

%Macro TF(TF=T,N=1,Left=,Centre=,Right=,PNum=No);
%Local ERRCOD1 ERRCOD2 GAP3 LWAS;
Options NoMprint NoMlogic NoSymbolgen;

%**************************************************************;
%* Determine if TF is title or footnote (defaults to TITLE)         *;

%If %Upcase(%Substr(&TF,1,1))=F %Then %Do; %Let TF=FOOTNOTE; %End;
%Else %Do; %Let TF=TITLE; %End;

%**************************************************************;
%* Ensure that Title and Number parameters are valid.               *;

Data _null_;
     Length N $2 Pnum $3;
     N=symget('N');
     If N not in('1' '2' '3' '4' '5' '6' '7' '8' '9' '10') then
        Do;
           PUT "ERROR: Valid &TF lines are integers from 1 to 10.";Put;
           Call Symput('ERRCODE','1');
        End;
     PNum=Upcase(Symget('PNum'));
     If substr(PNum,1,1) not in ('N','Y') then
        Do;
           Call Symput('PNUM','NO');
           PUT "WARNING: Invalid NUMBER option specified.  Defaulted to NO.";Put;
        End;
Run;
%If &ERRCOD1=1 %Then %Goto EOM;

%*************************************************************;
%* If pnum is set to no then stop page numbering                    *;

%If (%Upcase(%Substr(&pnum,1,1))=N AND &TF=TITLE) %Then
%Do;
    Options NoNumber;
%End;

%**************************************************************;
%* Determine FROM and TO positions of texts and spaces              *;

Data _null_;
Set  SASHELP.VOPTION(Where=(optname='LINESIZE'));
     Length to1 from2 to2 from3 gap1 gap2 settn 8.;
     settn=(input(setting,??best.)-3);
     If Upcase("&LEFT")="SLINE" Then
     Do;
        %Let lwas=&left;
        Call symput('LEFT',Left(Repeat('Ž',settn)));
     End;
     Left=Trim(Symget(Resolve('Left')));
     Centre=Trim(Symget('Centre'));
     Right=Trim(Symget('Right'));

     If Left^="" Then
     Do;
        To1=Length(Trim(left));
     End;
     Else Do;
        To1=0;
     End;

     If Centre^="" Then
     Do;
        From2=Floor( Floor(settn/2) - Length(Trim(centre))/2);
        To2=(from2 + Length(Trim(centre)))-1;
     End;
     Else Do;
        From2=Floor(settn/2);
        To2=Floor(settn/2)+1;
       Call Symput('Centre',repeat(byte(32),1));
     End;

     If Right^="" Then
     Do;
        From3=( settn+1 - Length(Trim(right))-1);
        If (%Eval(&N)=1 AND upcase(substr("&Pnum",1,1))='Y') then From3=from3-4;
     End;
     Else Do;
        From3=settn+1;
     End;

     gap1=( (from2) - (to1) -1 );
     gap2=( (from3) - (to2) -1 );

     If gap1 gt 0 then Call Symput('Gap1', repeat(byte(32),gap1));
     Else %let gap1=;;
     If gap2 gt 0 then Call Symput('Gap2', repeat(byte(32),gap2));
     Else %let gap2=;;

     %If %Upcase(&PNum)=YES %Then Call Symput('Gap3', repeat(byte(32),3));
     %Else Call Symput('Gap3',repeat(byte(32),1));;

     If ((to1 ge from2) AND centre ne '') then
     Do;
        PUT "ERROR: Centre aligned text will overwrite left aligned text.";
        PUT "ERROR: Either shorten text or increase linesize";
        Call Symput ('ERRCOD2','1');
     End;

     If ((to2 ge from3) AND right  ne '') then
     Do;
        PUT "ERROR: Right aligned text will overwrite centre aligned text.";
        PUT "ERROR: Either shorten text or increase linesize";
        Call Symput ('ERRCOD2','1');
     End;
Run;

%**************************************************************;
%* Check for error status, if true jump to end of macro             *;

%If &ERRCOD2=1 %then %Goto EOM;

%**************************************************************;
%* Create Title/Footnote                                            *;

%If %Upcase(&LWAS)=SLINE %Then
%Do;
    &TF&N " &LEFT ";
%End;
%Else %Do;
    &TF&N " &LEFT&GAP1&CENTRE&GAP2&RIGHT&GAP3.";
%End;
%EOM:
Options Mprint Mlogic Symbolgen;
%Mend TF;



***10.2.2***
%REPORT
Paul Kairis
NIKH Corporation
(Originally published in The Valley of the Sun SAS Users Group, VALSUG, Newsletter, 1996)


%macro report(dsn);
proc summary data =&dsn nway;
   class tpcorder sysname bldgname grpname;
   output out=calllist;
   run;

data _null_;
   set calllist end=eof;
   numcall+1;
   * Build macro variable(s) to hold WHERE clause;
   call symput('call'||left(put(numcall,3.)),
      "tpcorder='"||tpcorder||
      "'and sysname= '"||sysname||
      "'and bldgname='"||bldgname||
      "'and grpname= '"||grpname||"'");
   if eof then call symput('numcalls',left(put(numcall,3.)));
   run;

%do i = 1 %to &numcalls;
   options nobyline pageno=1;
   proc report data=&dsn nowindows headline;
      by tpcorder sysname bldgname grpname;
      where &&call&i;
      run;
%end;
%mend report;


***11.1.1***
%SAS2RAW


* sas2raw.sas
*
* Convert a SAS data set to a RAW or flat text file.  Include
* SAS statements on the flat file as documentation.
*;

* DSN  LIBREF OF THE DATA BASE (data base name) e.g. BEN;
*      This argument can be used to control the path.
* MEM  NAME OF DATA SET AND RAW FILE (member name)
*      e.g. FULLBEN;
* The raw file will have the same name as the data set.
*;
%MACRO SAS2RAW(dsn, mem);

* The libref for incoming data is &dsn;
libname &dsn   "d:\training\sas\&dsn";
* New text file written to the fileref ddout;
filename ddout "d:\junk\&mem..raw ";

*  DETERMINE LENGTHS AND FORMATS OF THE VARIABLES;
PROC CONTENTS DATA=&dsn..&mem OUT=A1 NOPRINT;
RUN;

PROC SORT DATA=A1; BY NPOS;
RUN;

* MANY NUMERIC VARIABLES DO NOT HAVE FORMATS AND THE RAW FILE;
* WILL BE TOO WIDE IF WE JUST USE A LENGTH OF 8;
* Count the number of numeric variables;
DATA _NULL_; SET A1 END=EOF;
IF TYPE=1 THEN NNUM + 1;
IF EOF THEN CALL SYMPUT('NNUM',LEFT(PUT(NNUM,3.)));
RUN;


%if &nnum > 0 %then %do;
* DETERMINE HOW MANY DIGITS ARE NEEDED FOR EACH NUMERIC VARIABLE;
* _D STORES THE MAXIMUM NUMBER OF DIGITS NEEDED FOR EACH NUMERIC VARIABLE;
DATA M2; SET &dsn..&mem (KEEP=_NUMERIC_) END=EOF;
ARRAY _D  DIGIT1 - DIGIT&NNUM;
ARRAY _N  _NUMERIC_;
KEEP DIGIT1 - DIGIT&NNUM;
RETAIN DIGIT1 - DIGIT&NNUM;
IF _N_ = 1 THEN  DO OVER _D; _D=1; END;
DO OVER _D;
     _NUMBER = _N;
     _D1 = LENGTH(LEFT(PUT(_NUMBER,BEST16.)));
     _D2 = _D;
     * NUMBER OF DIGITS NEEDED;
     _D = MAX(_D1, _D2);
END;
IF EOF THEN OUTPUT;
RUN;
%end;


*** THIS SECTION DOES NOT WRITE DATA ONLY THE PUT STATEMENT;
*MAKE THE PUT STATEMENT AND SET IT ASIDE .;
* It will serve as documentation as well as the PUT;
DATA _NULL_; SET A1 END=EOF;
RETAIN _TOT 0 _COL 1;
FILE DDOUT NOPRINT lrecl=250;
IF _N_ = 1 THEN DO;
     %if &nnum > 0 %then SET M2;;
     _TOT = NPOS;
END;
%if &nnum > 0 %then %do;
ARRAY _D (NNUM) DIGIT1 - DIGIT&NNUM;
* TYPE=1 FOR NUMERIC VARS;
IF TYPE=1 THEN DO;
     NNUM + 1;
     DIGIT = _D;
     * TAKE THE FORMATTED LENGTH INTO CONSIDERATION;
     LENGTH = MAX(FORMATL, FORMATD, DIGIT);
END;
%end;
_TOT = _TOT + LENGTH + 1;
CHAR = '               ';
* SPECIAL HANDLING IS REQUIRED WHEN FORMATS ARE USED.
* CHAR IS USED TO STORE THE FORMAT;
IF FORMAT ^= ' ' | FORMATL>0 | FORMATD >0 THEN DO;
    * BUILD THE FORMAT FOR THIS VARIABLE;
    CHAR = TRIM(FORMAT);
    IF FORMATL>0 THEN CHAR= TRIM(CHAR)||TRIM(LEFT(PUT(FORMATL,3.)));
    CHAR= TRIM(CHAR)||'.';
    IF FORMATD>0 THEN CHAR= TRIM(CHAR)||TRIM(LEFT(PUT(FORMATD,3.)));
END;
IF TYPE = 2 & FORMAT = ' ' THEN CHAR = '$';
* _COL IS THE STARTING COLUMN;
IF _N_ = 1 THEN _COL = 1;
IF _N_ = 1 THEN PUT '/* *** */ PUT @' _COL NAME CHAR;
ELSE            PUT '/* *** */     @' _COL NAME CHAR;
_COL = _COL + LENGTH + 1;
IF EOF THEN DO;
     PUT '/* *** */ ;' ;
     CALL SYMPUT('LRECL',_TOT);
END;
RUN;

* Write out the flat file using the PUT statement in DDOUT;
DATA _NULL_; SET &dsn..&mem;
FILE DDOUT NOPRINT MOD lrecl=250;
%INCLUDE DDOUT;
run;
%MEND sas2raw;

****************************************************;

 %SAS2RAW(sasclass,ca88air)    run;



***11.1.2***
%DELIM
Susan Haviar


%delim(vitals,log)
* delim.sas
*
* Convert a SAS data set to a comma delimited flat file.;
*
* Presented at PharmaSUG April, 1997
* by Susan Haviar
*;

data vitals;
input value $10. target $8. nums err mini maxi;
cards;
Diastolic Baseline 8 64.5 59 74
Diastolic 0.25 hrs 8 66.6 57 72
Diastolic 0.50 hrs 8 62.9 51 70
Diastolic 1 hrs    8 69.5 57 88
Diastolic 2 hrs    8 69.8 53 83
run;


%macro delim(dsn,oout);

   filename &oout "d:\junk\&dsn..txt";

   proc contents data=&dsn
                 out=_temp_(keep=name npos)
                 noprint;
   run;

   proc sort data=_temp_;
   by npos;
   run;

   data _null_;
   set _temp_ end=eof;
   call symput('var'||left(put(_n_,5.)),name);
   if eof then call symput('total',left(put(_n_,8.)));
   run;

   data _null_;
   file &oout noprint;
   set &dsn;
   put
      %do i=1 %to &total;
         &&var&i +(-1)','
      %end;
      +(-1)' ';
   run;
%mend delim;

%delim(vitals,outfile)


***11.2.1***
%TOPPCNT
Diane Goldschmidt


%macro toppcnt(dsn,idvar,pcnt);
****************************************************************;
* CREATE TABLE PCNT FOR INDICATING &PCNT OF Ids  *;
****************************************************************;

PROC SQL NOPRINT;
      SELECT
            COUNT(DISTINCT &IDVAR)  *&PCNT   INTO :IDPCNT
FROM
      &dsn;      ****<--- Number of obs in &dsn is unknown;

****************************************************************;
*         SORT ON DESCENDING &IDVAR                            *;
****************************************************************;

PROC SORT DATA= &dsn OUT=ITEMS;
BY DESCENDING &IDVAR;
RUN;

****************************************************************;
*  KEEP TOP % USING GLOBAL MACRO VARIABLE                      *;
****************************************************************;

DATA TOPITEMS;
SET ITEMS(OBS=%UNQUOTE(&IDPCNT));       **<---- Reflects the % ;
RUN;
%mend toppcnt;


%toppcnt(sasclass.biomass,bmtotl,.25);


***11.2.2***
%SELPCNT


%macro selpcnt(dsn,idvar,pcnt);

* Sort the incoming data set in descending order;
proc sort data=&dsn
          out=items;
by descending &idvar;
run;

* Read the first IDPCNT observations from ITEMS;
data topitems;
idpcnt = nobs*&pcnt;
do point = 1 to idpcnt;
   set items point=point nobs=nobs  ;
   output;
end;
stop;
run;
%mend selpcnt;

%selpcnt(sasclass.biomass,bmtotl,.25);


***11.2.3a***
%RAND_WO

%macro rand_wo(dsn,pcnt=0);

* Randomly select an approximate percentage of
* observations from a data set.
*
* Sample WITHOUT replacement;
*        any given observation can be selected only once
*        all observations have equal probability of selection.
*;

* Randomly select observations from &DSN;
data rand_wo;
set &dsn;
if ranuni(0) le &pcnt then output;
run;
%mend rand_wo;

%rand_wo(study03,pcnt=.25);


***11.2.3b***
%RAND_W

%macro rand_w(dsn,numobs=0,pcnt=0);

* Randomly select either a specified number of
* observations or a percentage from a data set.
*
* Sample WITH replacement;
*        any observation can be selected any number
*        times.

* When NUMOBS is specified create a subset of exactly
* that many observations (ignore PCNT).
* When PCNT is specified (and NUMOBS is not)
* calculate NUMOBS using PCNT*total number in DSN.
*;

* Randomly select &NUMOBS observations from &DSN;
data rand_w;
retain numobs .;
drop numobs i;

* Create a variable (NUMOBS) to hold number of obs
* to write to RAND_W;
%if &pcnt ne 0 and &numobs=0 %then %do;
   numobs = round(nobs*&pcnt);
%end;
%else %do;
   numobs = &numobs;
%end;

* Loop through the SET statement NUMOBS times;
do i = 1 to numobs;
   * Determine the next observation to read;
   point = ceil(ranuni(0)*nobs);

   * Read and output the selected observation;
   set &dsn point=point nobs=nobs  ;
   output;
end;
stop;
run;
%mend rand_w;


%rand_w(study03,numobs=100);

%rand_w(study03,pcnt=.25);



***11.3***
%EXIST

%macro exist(dsn);
%global exist;
%if %sysfunc(exist(&dsn))   %then %let exist=YES;
%else %let exist=NO;
%mend exist;


***11.4.1a**
Kim Kubasek


*** create the transposed data set;
proc transpose data=temp3 out=temp4 ;
by group2 year &spvar ;
var mean ;
id group1 ;
run ;

*** what variable names did proc transpose create?
    the table VARLIST will contain just the variable
    names of interest;
proc sql noprint ;
create table varlist as
select name
  from sashelp.vcolumn
    where libname='WORK'
      and memtype='DATA'
      and memname='TEMP4'
      and not(name in ('GROUP2' 'YEAR' "%upcase(&spvar)"
                       '_NAME_' '_LABEL_')) ;
quit ;

*** write short files of code to be included later that will
    create a space-delimited variable list ;
data _null_ ;
set varlist end=e ;
file 'temp2.sas' lrecl=70 ;
if _n_=1 then put '%let varlist= ' @ ;
put name @ ;
if e then put ';' ;
run ;

%include 'temp2.sas' / source ;


***11.4.1b***
Kim Kubasek

*** create the transposed data set;
proc transpose data=temp3 out=temp4 ;
by group2 year &spvar ;
var mean ;
id group1 ;
run ;

data _null_;
length name $8 str $80;
set temp4;
array allc {*}_character_;
array alln {*}_numeric_;
if dim(allc) then do i=1 to dim(allc);
   call vname(allc{i},name);
   * Exclude vars we know we do not want;
   if name not in('_NAME_' '_LABEL_' 'NAME' 'STR'
                  'GROUP2' 'YEAR' "%upcase(&spvar)" ) then
       str = trim(str)||' '||trim(name);
end;
if dim(alln) then do i=1 to dim(alln);
   call vname(alln{i},name);
   str = trim(str)||' '||trim(name);
end;
call symput('varlist',str);
stop;
run;

***11.4.2***
J rn Lodahl


proc sql noprint;
   select distinct loc
    into :loclist separated by ' '
    from samdat
    order by loc;
   quit;

***11.4.3***

%let keyfld = investid subject treatid;


*determine the list of key vars;
data _null_;
* count the number of keyvars
* save each for later;
str="&keyfld";
do I = 1 to 6;
 key = scan(str,i,' ');
 if key ne ' ' then do;
  ii=left(put(i,1.));
  call symput('key'||ii,
       trim(left(key)));
  call symput('keycnt',ii);
 end;
end;
run;


%Macro doit;

%let I = 1;
%do %until (%scan(&keyfld,&I,%str( )) = %str());
   %let key&I = %scan(&keyfld,&I,%str( ));
   %let I = %eval(&I + 1);
%end;
%let keycnt = %eval(&I-1);
%mend doit;


***11.5.1***
%OBSCNT


%macro obscnt(dsn);
%local nobs;
%let nobs=.;

%* Open the data set of interest;
%let dsnid = %sysfunc(open(&dsn));

%* If the open was successful get the;
%* number of observations and CLOSE &dsn;
%if &dsnid %then %do;
     %let nobs=%sysfunc(attrn(&dsnid,nlobs));
     %let rc  =%sysfunc(close(&dsnid));
%end;
%else %do;
     %put Unable to open &dsn - %sysfunc(sysmsg());
%end;

%* Return the number of observations;
&nobs
%mend obscnt;



***11.5.2***
 %TESTPRT
Jerry Kagan
Kagan Associates, Inc.


/**********************************************************************
* Program:  TestPrt.SAS                                                *
* Language: SAS 6.12/MACRO                                             *
*                                                                      *
* Purpose:  This macro prints samples of the last dataset created for  *
*           program testing                                            *
*                                                                      *
* Protocol: %let test = 1;    *** Turn macro on;                       *
*           %let obs = 10;    *** Print first 10 obs from dataset;     *
*                                                                      *
*           %testPrt(&obs)    *** First &obs is printed;               *
*                                                                      *
* Author:   Jerry Kagan                                               *
*           Kagan Associates, Inc.                                    *
*                                                                     *
*           jerrykagan@msn.com                                        *
*                                                                     *
* Date:     29Jun1993                                                  *
*                                                                      *
* Revisions:                                                           *
* 21Feb97 JBK Modified to use new sysfunc for simplicity and efficiency*
***********************************************************************/

%macro TestPrt(obs);
   %if &test %then
   %do;
      %let _dsid = %sysfunc(open(&syslast));
      %if &_dsid %then %do;
         %let _nobs = %sysfunc(attrn(&_dsid,NOBS));
         %let _nvar = %sysfunc(attrn(&_dsid,NVARS));
         %let _rc = %sysfunc(close(&_dsid));
      %end;

      proc print data=&syslast (obs=&obs) uniform;
      %if &obs < &_nobs %then %do;
         title1 "&syslast (Created with &_nobs observation(s) "
                "& &_nvar variable(s), first &obs printed)";
      %end;
      %else %do;
         title1 "&syslast (Created with &_nobs observation(s) "
                "& &_nvar variable(s), all printed)";
      %end;
      run;
   %end;
%mend TestPrt;

***12.2.2***
%LEFT
SAS Institute, Inc.


%macro left(text);
%*********************************************************************;
%*                                                                   *;
%*  MACRO: LEFT                                                      *;
%*                                                                   *;
%*  USAGE: 1) %left(argument)                                        *;
%*                                                                   *;
%*  DESCRIPTION:                                                     *;
%*    This macro returns the argument passed to it without any       *;
%*    leading blanks in an unquoted form. The syntax for its use     *;
%*    is similar to that of native macro functions.                  *;
%*                                                                   *;
%*    Eg. %let macvar=%left(&argtext)                                *;
%*                                                                   *;
%*  NOTES:                                                           *;
%*    The %VERIFY macro is used to determine the first non-blank     *;
%*    character position.                                            *;
%*                                                                   *;
%*********************************************************************;
%local i;
%if %length(&text)=0 %then %let text=%str( );
%let i=%verify(&text,%str( ));
%if &i  %then %substr(&text,&i);
%mend;


***12.2.3***
%CMPRES
SAS Institute, Inc.


%macro cmpres(text);
%*********************************************************************;
%*                                                                   *;
%*  MACRO: CMPRES                                                    *;
%*                                                                   *;
%*  USAGE: 1) %cmpres(argument)                                      *;
%*                                                                   *;
%*  DESCRIPTION:                                                     *;
%*    This macro returns the argument passed to it in an unquoted    *;
%*    form with multiple blanks compressed to single blanks and also *;
%*    with leading and trailing blanks removed.                      *;
%*                                                                   *;
%*    Eg. %let macvar=%cmpres(&argtext)                              *;
%*                                                                   *;
%*  NOTES:                                                           *;
%*    The %LEFT and %TRIM macros in the autocall library are used    *;
%*    in this macro.                                                 *;
%*                                                                   *;
%*********************************************************************;
%local i;
%let i=%index(&text,%str(  ));
%do %while(&i^=0);
  %let text=%qsubstr(&text,1,&i)%qleft(%qsubstr(&text,&i+1));
  %let i=%index(&text,%str(  ));
%end;
%left(%qtrim(&text))
%mend;


***12.2.4***
%LOWCASE
SAS Institute, Inc.

%macro lowcase(string);
%*********************************************************************;
%*                                                                   *;
%*  MACRO: LOWCASE                                                   *;
%*                                                                   *;
%*  USAGE: 1) %lowcase(argument)                                     *;
%*                                                                   *;
%*  DESCRIPTION:                                                     *;
%*    This macro returns the argument passed to it unchanged         *;
%*    except that all upper-case alphabetic characters are changed   *;
%*    to their lower-case equivalents.                               *;
%*                                                                   *;
%*  E.g.:          %let macvar=%lowcase(SAS Institute Inc.);        %*;
%*  The variable macvar gets the value "sas institute inc."          *;
%*                                                                   *;
%*  NOTES:                                                           *;
%*    Although the argument to the %UPCASE macro function may        *;
%*    contain commas, the argument to %LOWCASE may not, unless       *;
%*    they are quoted.  Because %LOWCASE is a macro, not a function, *;
%*    it interprets a comma as the end of a parameter.               *;
%*                                                                   *;
%*********************************************************************;
%local i length c index result;
%let length = %length(&string);
%do i = 1 %to &length;
   %let c = %substr(&string,&i,1);
   %if &c eq %then %let c = %str( );
   %else %do;
      %let index = %index(ABCDEFGHIJKLMNOPQRSTUVWXYZ,&c);
      %if &index gt 0 %then
           %let c = %substr(abcdefghijklmnopqrstuvwxyz,&index,1);
      %end;
   %let result = &result.&c;
   %end;
&result
%mend;


***13.1.1***
%COUNTER
David Shannon


/*--------------------------------------------------------------------
|                             COUNTER                                |
|                            ---------                               |
| The number of observations contained in the input dataset, after   |
| completion of the datastep, is stored in the macro variable.       |
|                                                                    |
|--------------------------------------------------------------------|
| Parameter  | Default | Description                                 |
|--------------------------------------------------------------------|
| DATA       | _Last_  | Optional:  Data source to count number of   |
|            |         |            observations.                    |
| INTO       | Counter | Optional:  Macro variable to store number of|
|            |         |            observations.                    |
|--------------------------------------------------------------------|
| Usage      : %COUNTER;                                             |
|            : %COUNTER(NEWDAT,NOOBS);                               |
|                       ^      ^                                     |
|                       |      - Macro variable to store count       |
|                       - Dataset name                               |
|                                                                    |
| Note(s)    : Datasets may be empty, but must have at least one     |
|              variable, and therefore must exist.                   |
|                                                                    |
| Written by : David Shannon, V1, 14/4/97, V6.10+                    |
| Bugs to    : David@schweiz.demon.co.uk                             |
| References : Getting Started With the SQL Procedure, S.I., 1994.   |
-------------------------------------------------------------------*/;

%MACRO Counter(data,into);

%********************************************************************;
%* Define local macro variables (those only referred to locally)    *;

%Local DATA INTO;

%********************************************************************;
%* Set defaults if not provided in positional macro call.           *;

%If &DATA EQ %Then %Let DATA=_last_;
%If &INTO EQ %Then %Let INTO=COUNTER;

%********************************************************************;
%* Make output variable global, hence can be refered to outside this*;
%* macro.                                                           *;

%Global &INTO;

%********************************************************************;
%* Count observations and store result in the global macro variable.*;

Proc Sql Noprint;
     Select count(*) into:&INTO
     From &DATA;
Quit;

%PUT Counted &&&INTO. observations, stored in macro variable &&INTO..;

%MEND Counter ;



***13.1.2***
%INDVAR
J rn Lodahl

/****************************************************************
SYNTAX:
%indvar(datasetname,classvar,prefix_for_ind_var,basevar=)

This macro creates a series of indicator variables from a
class-variable and adds them to the dataset. The class-variable
MUST be restricted to positive integers or zero. The prefix_for_ind_var
is used as the prefix for names of the indicator variables.

A macro variable named prefix_for_ind_var is also created as a
string.  This string contains the names of all of the newly
created indicator variables.  The names are seperated by a space.
By default (basevar=min), the indicator variable associated with the
minimum value of the class-variable is excluded from this list (the
indicator variable is still included on the data set).  Setting
basevar=none excludes no names from the list.  A specific name can be
excluded by setting basevar=x, where x is a value taken on by the clas-variable.

EXAMPLE:
Consider a data set where the variable class takes values 1, 2 and 4.

  %indvar(&syslast,class,c)

Variables c1 c2 and c4 with values 0 or 1 are added to the data set.
(c3 is allways 0 since class is never 3 and therefore c3 is not
created). Moreover the macro variable c equals "c2 c4" (c1 is omitted
since by default basevar=min and 1 is the minimum value of class).
If instead %indvar(&syslast,class,c,basevar=2) was called, c2 would be
omitted from the macro variable. Basevar=none includes all.
****************************************************************/

%macro indvar(dataset,byvar,prefix,basevar=min);
%local item list value min;
%global &prefix;

  /* generate list */
  PROC SQL NOPRINT;
    SELECT DISTINCT &byvar INTO :list SEPARATED BY ' '
    FROM &dataset
    ORDER BY &byvar;
    SELECT min(&byvar) INTO :min
    FROM &dataset;
  QUIT;

  /* create variables */
  %LET item=1;
  %LET value = %scan(&list, &item) ;
  /* in other words: element no. &item in &list = &value */
  %LET &prefix= ;  /* turns into a list of "all" ind variables */

  data &dataset;
    set &dataset;
    %IF &basevar=min %THEN %LET basevar=&min;;
    %do %while( %quote(&value) ^= ) ;
      IF &byvar=&value THEN &prefix&value=1; ELSE &prefix&value=0;
      %IF %quote(&value)^=%quote(&basevar) %THEN
        %LET &prefix=&&&prefix &prefix&value;;
      %LET item = %eval( &item +1) ;
      %let value = %scan( &list, &item );
    %end;
  run;
%put macro indvar created macro variable &prefix = &&&prefix;
%mend indvar;


***13.1.3***
%SUMS
Justina M. Flavin
STATPROBE, Inc.
jflavin@statprobe.com


%let total=4;
%let numtreat=3;

data freqpref;
drop i;
array lst {&numtreat} pref1 - pref&numtreat;
do body = 1 to 5;
  do i = 1 to &numtreat;
     lst{i} = int(ranuni(9999)*10);
  end;
  output;
end;
run;

data freqbody;
drop i;
array lst {&numtreat} body1 - body&numtreat;
do body = 1 to 5;
  do i = 1 to &numtreat;
     lst{i} = int(ranuni(9999)*5);
  end;
  output;
end;
run;

data event;
drop i;
array lst {&numtreat} event1-event&numtreat;
do body = 1 to 5;
  do i = 1 to &numtreat;
     lst{i} = int(ranuni(9999)*3);
  end;
  output;
end;
run;


***13.1.4***
%GETKEYS
Richard O. Smith
Science Explorations


%macro getkeys(inlib ,indsn );
* getkeys.sas
* 25Jun97 - ROSmith
* macro to get the key variables for selected library & member.
* assumes that the global macros for the databases & keys are created.
* Outputs a macro variable KEYVARS.
*;

%do k = 1 %to &&&inlib.cnt;
   %if %upcase(&indsn ) = %upcase(&&&inlib.db&k ) %then
        %let KEYVARS = &&KEYS&k;
%end;

%mend getkeys;


***13.1.5***
%SYMCHK


%macro symchk(name);

%if %nrquote(&&&name)=%nrstr(&)&name %then
    %let yesno=NO;

%else %let yesno=YES;

&yesno
%mend symchk;

%put 'Does &tmp exist? ' %symchk(tmp);


***13.2***
%DBVAL

data _null_;
set counts (keep=body  pref1 pref2 body1 body2);
array vlist {4} pref1 pref2 body1 body2;
length name $8 ii jj $2;
i+1;
ii = trim(left(put(i,2.)));
call symput('rowcnt',ii);
if i=1 then call symput('colcnt','4');

* Store values for this row;
rowname = 'r'||ii||'c';

* Step through the values for this observation;
do j = 1 to 4;
   jj= left(put(j,2.));

   * Save the value for this row and column;
   call symput(trim(compress(rowname))||jj,vlist{j});

   * Save the variable name;
   call vname(vlist(j),name);
   if i=1 then call symput('vname'||jj,name);
end;
run;


%let rr = 4;
%let cc = 3;
%put Row &rr and col &cc (%cmpres(&&vname&cc)) is %left(&&r&rr.c&cc);

%macro dbval(maxrow,maxcol);
   %put row  col  value;
   %do row = 1 %to &maxrow;
      %do col = 1 %to &maxcol;
         %put &row    &col    %left(&&r&row.c&col);
      %end;
   %end;
%mend dbval;

%dbval(&rowcnt, &colcnt);


***A.2.1***

LIBNAME CLASS 'd:training\sas\sasclass';

%let dsn = clinics;
%let var1 = edu;
%let var2 = dob;
%let type = mean;

PROC PLOT DATA=CLASS.&dsn;
      PLOT &var1 * &var2;
      TITLE1 'YEARS OF EDUCATION COMPARED TO BIRTH DATE';
RUN;

PROC CHART DATA=CLASS.&dsn;
      VBAR WT / SUMVAR=HT TYPE=&type;
      TITLE1 'AVERAGE HEIGHT FOR WEIGHT GROUPS';
RUN;


***A.2.3***

%let dsn=clinic;
%let lib=sasuser;
%let i=3;
%let dsn3 = studydrg;
%let b=dsn;

%put '&lib&dsn ' &lib&dsn;
%put '&lib.&dsn ' &lib.&dsn;
%put '&lib..&dsn ' &lib..&dsn;

%put '&dsn&i ' &dsn&i;
%put '&&dsn&i ' &&dsn&i;
%put '&dsn.&i ' &dsn.&i;

%put '&&bb ' &&bb;
%put '&&&b ' &&&b;

* Extra credit;
%put '&dsn..&&dsn&i ' &dsn..&&dsn&i;


***A.3.1***

LIBNAME CLASS 'd:training\sas\sasclass';

options mlogic mprint symbolgen;
%macro plotit;
PROC PLOT DATA=CLASS.CLINICS;
      PLOT EDU * DOB;
      TITLE1 'YEARS OF EDUCATION COMPARED TO BIRTH DATE';
RUN;

PROC CHART DATA=CLASS.CLINICS;
      VBAR WT / SUMVAR=HT TYPE=MEAN;
      TITLE1 'AVERAGE HEIGHT FOR WEIGHT GROUPS';
RUN;
%mend plotit;
%plotit


***A.4.3***

LIBNAME CLASS 'd:training\sas\sasclass';

options mlogic mprint symbolgen;
%macro plotit(var1, var2, dsn=);
PROC PLOT DATA=CLASS.&dsn;
      PLOT &var1 * &var2;
      TITLE1 'YEARS OF EDUCATION COMPARED TO BIRTH DATE';
RUN;

PROC CHART DATA=CLASS.&dsn;
      VBAR WT / SUMVAR=HT TYPE=MEAN;
      TITLE1 'AVERAGE HEIGHT FOR WEIGHT GROUPS';
RUN;
%mend plotit;
%plotit(edu,dob,dsn=clinics)

***A.5.2***

%macro loop1;
  %do cnt = 1 %to 10;
     %put This is Test &cnt;
  %end;
%mend loop1;

%macro loop2;
  %let cnt=1;
  %do %while(&cnt <= 10);
     %put This is Test &cnt;
     %let cnt = %eval(&cnt + 1);
  %end;
%mend loop2;

%macro loop3;
  %let cnt=1;
  %do %until(&cnt > 10);
     %put This is Test &cnt;
     %let cnt = %eval(&cnt + 1);
  %end;
%mend loop3;

%put loop1; %loop1
%put loop2; %loop2
%put loop3; %loop3


***A.5.6***

%macro genproc(proc,dsn,varlst);
   proc &proc data=&dsn;
      var &varlst;
      title1 "&proc Procedure for &varlst";
   run;
%mend genproc;

%genproc(means,class.clinics, edu ht wt)
%genproc(univariate,class.clinics, edu ht wt)


***A.5.7***

%macro mymeans(dsn, varlst, statlst,
               outdsn, print=noprint);
proc means data=&dsn &statlst
  %if &outdsn = %then print;
  %else &print;;

var &varlst;
%if &outdsn ne %then
  output out=&outdsn mean=&varlst;;
run;
%mend mymeans;

* print selected stats (no output data set);
%mymeans(class.clinics, ht wt, mean stderr)

* no printed stats (output data set only);
%mymeans(class.clinics, ht wt,,outstat)
proc print data=outstat;
run;

* printed stats & an output data set ;
%mymeans(class.clinics, ht wt,sum   max,outstat,print=print)


***A.6.2***

libname class 'd:\training\sas\sasclass';

%MACRO PLOTIT;
   PROC SORT DATA=CLASS.CLINICS OUT=CLINICS;
      BY REGION;
      RUN;
   DATA _NULL_;
      SET CLINICS;
      BY REGION;
      IF FIRST.REGION THEN DO;
         I+1;
         II=LEFT(PUT(I,2.));
         CALL SYMPUT('REG'||II,REGION);
         CALL SYMPUT('TOTAL',II);
      END;
      RUN;

   data
      %* Build the names of the new data sets;
      %do i = 1 %to &total;
         reg&i
      %end;
      ;
      set clinics;
      %do i = 1 %to &total;
         %* Build the output statements;
         %if &i=1 %then if region='1' then output reg1;
         %else else if region="&i" then output reg&i;
         ;
      %end;

   * Plot the &total regions one at a time;
   %DO I=1 %TO &TOTAL;
      PROC PLOT DATA=reg&i;
         PLOT HT * WT;
         TITLE1 "Height/Weight for REGION &I";
      RUN;
   %END;
%MEND PLOTIT;

%plotit


***A.6.3***

libname class 'd:\training\sas\sasclass';

%MACRO PLOTIT;
   PROC SORT DATA=CLASS.CLINICS OUT=CLINICS;
      BY REGION;
      RUN;
   DATA _NULL_;
      SET CLINICS;
      BY REGION;
      IF FIRST.REGION THEN DO;
         I+1;
         II=LEFT(PUT(I,2.));
         CALL SYMPUT('REG'||II,REGION);
         CALL SYMPUT('TOTAL',II);
      END;
      RUN;

   data  %do i = 1 %to &total; r&&reg&i %end;;
      set clinics;
      %* Build the &total output statements;
      %do i = 1 %to &total;
        %if &i=1 %then if region="&&reg&i" then output r&&reg&i;
        %else else if region="&&reg&i" then output r&&reg&i;
        ;
      %end;
      run;

   %DO I=1 %TO &TOTAL;
      PROC PLOT DATA=r&&reg&i;
         PLOT HT * WT;
         TITLE1 "Height/Weight for REGION &&REG&I";
         RUN;
   %END;
%MEND PLOTIT;

%plotit


***A.6.4***

libname class 'd:\training\sas\sasclass';

%macro allchar(dsn);
* Determine the numeric vars in &dsn;
proc contents data=&dsn out=cont noprint;
run;

* Create the macro variables for each numeric var;
data _null_;;
set cont(keep=name type format formatl formatd label);
length fmt $15;
where  type=1;

* Count the numeric vars and save the total number;
i+1;
ii=left(put(i,3.));
call symput('n',ii);

* create a format string;
fmt = 'best.';
if format ne ' ' then fmt = trim(format)
    ||trim(left(put(formatl,3.)))
    ||'.'||left(put(formatd,3.));
fmt = compress(fmt);
call symput('fmt'||ii,fmt);

* Save the variable name;
call symput('name'||ii,name);

* Save the label for this variable;
if label = ' ' then label = name;
call symput('label'||ii,label);
run;

* Establish a data set with only character variables;
* &n       number of numeric variables in &dsn;
* __aa&i   temporary var to hold numeric values;
* &&name&i name of the variable to covert from numeric;
*
* The numeric value of &name1 is stored in __aa1
* by renaming the variable in the SET statement.  __aa1
* is then converted to character and stored in the
* 'new' variable &name1 in the data set CHARONLY.
* ;
data charonly (drop=
   %* Drop the temp. vars used to hold numeric values;
   %do i=1 %to &n;
      __aa&i
   %end;
    );
length
   %* Establish the vars as character;
   %do i=1 %to &n;
      &&name&i
   %end;
    $8;

set &dsn (rename=(
   %* Rename the incoming numeric var to a temp name;
   %* This allows the reuse of the variables name;
   %do i=1 %to &n;
      &&name&i=__aa&i
   %end;
   ));

   * Convert the numeric values to character;
   %do i=1 %to &n;
      &&name&i = left(put(__aa&i,&&fmt&i));
      label &&name&i = "&&label&i";
   %end;
run;

proc contents data=charonly;
proc print data=charonly;
run;
%mend allchar;

%allchar(class.biomass)


***A.7.4***

* Count the number of words in a string
* see p256 in SAS Guide to Macro Processing;

%macro count(string,parm);
   %local word;
   %if &parm= %then %let parm = %str( );
   %let count=1;
   %let word = %qscan(&string,&count,&parm);
   %do %while(&word ne);
      %let count = %eval(&count+1);
      %let word = %qscan(&string,&count,&parm);
   %end;
   %put word count for |&string| is %eval(&count-1);
%mend count;

%count(this is a short string)
%count(%nrstr(this*&is*a*string),%str(*))

***BIOMASS***

*************************************************;
* biomass.sas;
*
* Create the benthos biomass data set.
*************************************************;

data sasclass.biomass;
input  @1 STATION $
       @12 DATE DATE7.
       @20 BMPOLY
       @25 BMCRUS
       @31 BMMOL
       @36 BMOTHR
       @41 BMTOTL ;

format date date7.;

label BMCRUS   = 'CRUSTACEAN BIOMASS (GM WET WEIGHT)'
      BMMOL    = 'MOLLUSC BIOMASS (GM WET WEIGHT)   '
      BMOTHR   = 'OTHER BIOMASS (GM WET WEIGHT)     '
      BMPOLY   = 'POLYCHAETE BIOMASS (GM WET WEIGHT)'
      BMTOTL   = 'TOTAL BIOMASS (GM WET WEIGHT)     '
      DATE     = 'DATE                              '
      STATION  = 'STATION ID                        ';

cards;
DL-25      18JUN85 0.4  0.03  0.17 0.02 0.62
DL-60      17JUN85 0.51 0.09  0.14 0.08 0.82
D1100-25   18JUN85 0.28 0.02  0.01 4.61 4.92
D1100-60   17JUN85 0.36 0.05  0.32 0.47 1.2
D1900-25   18JUN85 0.03 0.02  0.11 1.06 1.22
D1900-60   17JUN85 0.54 0.11  0.03 4.18 4.86
D3200-60   17JUN85 0.52 0.14  0.04 0.05 0.75
D3350-25   18JUN85 0.18 0.02  0.11 0    0.31
D6700-25   18JUN85 0.51 0.06  0.03 0.01 0.61
D6700-60   17JUN85 0.32 0.14  0.04 0.22 0.72
D700-25    18JUN85 0.23 0.03  0.02 0.07 0.35
D700-60    17JUN85 1.11 0.32  0.07 0.02 1.52
DL-25      10JUL85 0.92 0.09  0.1  0.03 1.14
DL-60      09JUL85 0.29 0.14  0.03 0.06 0.52
D1100-25   10JUL85 0.14 0.05  0.05 4.79 5.03
D1100-60   09JUL85 0.88 0.07  0.01 0.01 0.97
D1900-25   10JUL85 0.35 0.05  0.05 1.82 2.27
D1900-60   09JUL85 0.87 0.08  0.42 3.35 4.72
D3200-60   09JUL85 0.22 0.1   0.08 0.01 0.41
D3350-25   10JUL85 0.36 0.06  0.01 0.02 0.45
D6700-25   10JUL85 1.84 0.02  0.11 0.05 2.02
D6700-60   09JUL85 0.47 0.19  0.06 0.06 0.78
D700-25    10JUL85 1.46 0.19  0.12 0.38 2.15
D700-60    09JUL85 0.48 0.18  0.02 0.11 0.79
DL-25      05AUG85 0.92 0.08  0.09 0.02 1.11
DL-60      02AUG85 0.4  0.1   0.59 0.5  1.59
D1100-25   05AUG85 0.18 0.02  0.36 2.33 2.89
D1100-60   02AUG85 0.39 0.12  0.03 0.01 0.55
D1900-25   05AUG85 1.23 0.06  0.04 2.15 3.48
D1900-60   02AUG85 0.56 0.07  0.02 0.11 0.76
D3200-60   02AUG85 0.39 0.11  0.05 0.02 0.57
D3350-25   05AUG85 0.45 44.82 0.02 0.16 45.45
D6700-25   05AUG85 1.13 0.01  0.11 0.04 1.29
D6700-60   02AUG85 0.43 0.15  1.1  0.01 1.69
D700-25    05AUG85 0.31 0.02  0.26 0.03 0.62
D700-60    02AUG85 0.38 0.07  0.12 1.87 2.44
DL-25      26AUG85 0.57 0.01  0.14 0.04 0.76
DL-60      27AUG85 0.46 0.05  0.5  0.18 1.19
D1100-25   26AUG85 0.63 0.02  0.04 0.03 0.72
D1100-60   27AUG85 0.57 0.04  0.09 0.31 1.01
D1900-25   26AUG85 0.26 0.03  0.01 3.89 4.19
D1900-60   27AUG85 0.73 0.07  0.06 0.09 0.95
D3200-60   27AUG85 0.46 0.07  0.02 0.01 0.56
D3350-25   26AUG85 0.57 0.02  0.05 0.05 0.69
D6700-25   26AUG85 0.87 0.01  0.03 0.02 0.93
D6700-60   27AUG85 0.69 0.07  0.03 0.01 0.8
D700-25    26AUG85 0.48 0.19  0.53 0.62 1.82
D700-60    27AUG85 0.25 0.09  0.07 0.01 0.42
run;

***CLINICS***

*************************************************;
* clinics.sas;
*
* Create the clinics data set.
*************************************************;

data sasclass.clinics;
infile cards missover;
input clinnum  $ 1-6
      clinname $ 7-33
      region   $ 34-35
      lname    $ 36-45
      fname    $ 46-51
      ssn      $ 52-60
      sex      $ 61
      dob        mmddyy8.
      death      mmddyy8.
      race     $ 78
      edu        79-80
      wt         81-83
      ht         84-85
      exam       mmddyy8.
      symp     $ 94-95
      dt_diag    mmddyy8.
      diag     $ 104
      admit      mmddyy8.
      proced   $ 113
      disch      mmddyy8.;

format dob death exam dt_diag admit disch date7.;

label clinnum  = 'clinic number'
      clinname = 'clinic name'
      region   = 'region'
      lname    = 'last name'
      fname    = 'first name'
      ssn      = 'social security number'
      sex      = 'patient sex'
      dob      = 'date of birth'
      death    = 'date of death'
      race     = 'race'
      edu      = 'years of education'
      wt       = 'weight in pounds'
      ht       = 'height in inches'
      exam     = 'examination date'
      symp     = 'symptom code'
      dt_diag  = 'date of diagnosis'
      diag     = 'diagnosis code'
      admit    = 'admit date'
      proced   = 'procedure code'
      disch    = 'discharge date'
      ;
cards;
031234Bethesda Pioneer Hospital   3Smith     Mike  123456789M03/18/52        1161627102/13/870102/14/87202/14/87302/15/87
036321Naval Memorial Hospital     3Jones     Sarah 043667543F07/02/46        3141056407/01/830607/03/83207/05/83307/10/83
024477New York General Hospital   2Maxwell   Linda 135798642F05/20/53        3141056407/01/830607/03/83207/05/83307/10/83
065742Kansas Metropolitan         7Marshall  Robert489012567M03/11/53        1121556711/02/8702
108531Seattle Medical Complex    10James     Debra 563457897F06/19/4208/03/851171636304/22/830505/03/83607/27/85208/03/85
014321Vermont Treatment Center    1Lawless   Henry 075312468M09/17/60        1101957411/02/860411/05/86311/05/86311/19/86
095277San Francisco Bay General   9Chu       David 784567256M06/18/51        5161476810/10/830410/10/833
043320Miami Bay Medical Center    4Halfner   John  589012773M03/02/47        2171556709/14/850209/14/852
051345Battle Creek Hospital       5Cranberry David 153675389M11/21/3104/13/861132156810/28/851010/29/85510/29/85204/13/86
063901Dallas Memorial Hospital    6Simpson   Donna 373167532F04/18/3305/21/871151876305/12/870405/12/87305/12/87205/21/87
093785Sacramento Medical Complex  9Wright    Sarah 674892109F10/21/48        2121776509/10/8306
024477New York General Hospital   2Little    Sandra376245789F08/01/50        1121096307/01/830607/03/83207/05/83307/07/83
043320Miami Bay Medical Center    4Johnson   Randal537890152M08/29/56        11820173
057312Indiana Help Center         5Henderson Robert932456132M02/25/57        2161587208/15/831008/15/832        3
082287Denver Security Hospital    8Adamson   Joan  011553218F                2161587208/15/831008/15/832        3
033476Mississippi Health Center   4Rodgers   Carl  327654213M11/15/48        1131797212/20/84
066789Austin Medical Hospital     6Alexander Mark  743567875M01/15/30        1121757009/15/88
026789Geneva Memorial Hospital    2Long      Margot531895634F02/28/49        4141156408/15/860108/21/86708/21/86308/21/86
054367Michigan Medical Center     5Cranston  Rhonda287463500F01/03/3704/13/881121606203/28/881003/28/88503/28/88204/13/88
094789San Diego Memorial Hospital 9Dandy     Martin578901234M05/21/37        11218570
084890Montana Municipal Hospital  8Wills     Norma 425617894F05/10/51        1121626802/20/840302/20/841        2
033476Mississippi Health Center   4Cordoba   Juan  327654213M06/06/67        3151336805/07/840905/09/84
108531Seattle Medical Complex    10Robertson Adam  743787764M04/07/4208/03/871121776904/29/850505/03/85603/29/87208/03/87
063742Houston General             6King      Doug  467901234M08/15/34        2122406811/12/881011/12/885
038362Philadelphia Hospital       3Marksman  Joan  634792254F09/28/63        41411265
031234Bethesda Pioneer Hospital   3Candle    Sid   468729812M10/15/17        1101957411/02/860411/05/86311/05/86311/19/86
046789Tampa Treatment Complex     4Baron     Roger 189456372M01/29/37        1101607006/15/8510
011234Boston National Medical     1Nabers    David 345751123M11/03/21        1101957411/02/860411/05/86311/05/86311/19/86
023910New York Metro Medical Ctr  2Harbor    Samuel091550932M01/14/50        3141056405/27/830605/28/832
063742Houston General             6Davidson  Mitch 524189532M02/26/39        2162016905/12/8705        2
059372Ohio Medical Hospital       5Karson    Shawn 297854321F03/05/60        217 9862        04
023910New York Metro Medical Ctr  2Harbor    Samuel091550932M01/14/50        3141056407/01/830607/03/83207/05/83307/10/83
049060Atlanta General Hospital    4Adams     Mary  079932455F08/12/51        2171556709/14/850209/14/852
107211Portland General           10Holmes    Donald315674321M06/21/40        1121776904/29/850505/03/85603/29/87208/03/87
063901Dallas Memorial Hospital    6Simpson   Donna 373167532F04/18/3305/21/871151876305/12/870405/12/87305/12/87205/21/87
095277San Francisco Bay General   9Marks     Gerald638956732M03/03/47        1102156709/02/82
065742Kansas Metropolitan         7Chang     Joseph539873164M08/20/58        5181476501/18/860302/03/86102/03/86102/07/86
036321Naval Memorial Hospital     3Masters   Martha029874182F08/20/58        2171556709/14/850209/14/852
095277San Francisco Bay General   9Marks     Gerald638956732M03/03/47        1102156709/02/821009/03/82509/05/82309/08/82
049060Atlanta General Hospital    4Rymes     Carol 680162534F10/05/57        1151316604/01/850204/01/852
031234Bethesda Pioneer Hospital   3Henry     Louis 467189564M04/19/53        1161627102/13/870102/14/87202/14/87302/15/87
036321Naval Memorial Hospital     3Stubs     Mark  319085647M06/11/47        3141056407/01/830607/03/83207/05/83307/10/83
024477New York General Hospital   2Haddock   Linda 219075362F04/04/51        3141056407/01/830607/03/83207/05/83307/10/83
065742Kansas Metropolitan         7Uno       Robert389036754M03/21/44        1121556711/02/8702
108531Seattle Medical Complex    10Manley    Debra 366781237F01/19/4208/03/851171636304/22/830505/03/83607/27/85208/03/85
014321Vermont Treatment Center    1Mercy     Ronald190473627M09/27/60        1101957411/02/860411/05/86311/05/86311/19/86
095277San Francisco Bay General   9Chang     Tim   198356256M02/18/51        5161476810/10/830410/10/833
043320Miami Bay Medical Center    4Most      Mat   109267433M03/02/47        2171556709/14/850209/14/852
051345Battle Creek Hospital       5Rose      Mary  299816743F11/01/3104/13/861132156810/28/851010/29/85510/29/85204/13/86
063901Dallas Memorial Hospital    6Nolan     Terrie298456241F10/18/3307/21/871151876305/12/870405/12/87305/12/87207/21/87
093785Sacramento Medical Complex  9Tanner    Heidi 456178349F08/08/45        2121776509/10/8306
024477New York General Hospital   2Saunders  Liz   468045789F03/01/49        1121096307/01/830607/03/83207/05/83307/07/83
043320Miami Bay Medical Center    4Jackson   Ted   339984672M12/29/56        11820173
057312Indiana Help Center         5Pope      Robert832456132M02/05/57        2161587208/15/831008/15/832        3
082287Denver Security Hospital    8Olsen     June  743873218F                2161587208/15/831008/15/832        3
033476Mississippi Health Center   4Maxim     Kurt  468721213M10/15/40        1131797212/20/84
066789Austin Medical Hospital     6Banner    John  368267875M01/25/32        1121757009/15/88
026789Geneva Memorial Hospital    2Ingram    Marcia367895634F02/13/48        4141156408/15/860108/21/86708/21/86308/21/86
054367Michigan Medical Center     5Moon      Rachel375363500F01/23/3706/13/881121606203/28/881003/28/88505/28/88206/13/88
094789San Diego Memorial Hospital 9Thomas    Daniel486301234M05/23/38        11218570
084890Montana Municipal Hospital  8East      Jody  086317894F10/10/51        1121626802/20/840302/20/841        2
033476Mississippi Health Center   4Perez     Mathew578254213M07/06/57        3151336805/07/840905/09/84
108531Seattle Medical Complex    10Reilly    Arthur476587764M05/17/4209/03/871121776904/29/850505/03/85608/29/87209/03/87
063742Houston General             6Antler    Peter 489745234M01/15/34        2122406811/12/881011/12/885
038362Philadelphia Hospital       3Upston    Betty 784793254F09/13/63        41411265
031234Bethesda Pioneer Hospital   3Panda     Merv  387549812M10/11/19        1101957411/02/860411/05/86311/05/86311/19/86
046789Tampa Treatment Complex     4East      Clint 842576372M01/26/37        1101607006/15/8510
011234Boston National Medical     1Taber     Lee   479451123M11/05/24        1101957411/02/860411/05/86311/05/86311/19/86
023910New York Metro Medical Ctr  2Leader    Zac   075345932M01/15/50        3141056405/27/830605/28/832
063742Houston General             6Ronson    Gerald474223532M02/27/49        2162016905/12/8705        2
059372Ohio Medical Hospital       5Carlile   Patsy 578854321F03/15/55        217 9862        04
023910New York Metro Medical Ctr  2Atwood    Teddy 066425632M02/14/50        3141056407/01/830607/03/83207/05/83307/10/83
049060Atlanta General Hospital    4Batell    Mary  310967555F01/12/37        2171556709/14/850209/14/852
107211Portland General           10Hermit    Oliver471094671M06/23/38        1121776904/29/850505/03/85603/29/87208/03/87
063901Dallas Memorial Hospital    6Temple    Linda 691487532F04/18/4305/21/871151876305/12/870405/12/87305/12/87205/21/87
095277San Francisco Bay General   9Block     Will  549014532M03/12/51        1102156709/02/82
065742Kansas Metropolitan         7Chou      John  310986734M05/15/58        5181476501/18/860302/03/86102/03/86102/07/86
036321Naval Memorial Hospital     3Herbal    Tammy 041090882F08/23/46        2171556709/14/850209/14/852
095277San Francisco Bay General   9Mann      Steven489956732M03/27/43        1102156709/02/821009/03/82509/05/82309/08/82
049060Atlanta General Hospital    4Rumor     Stacy 409825614F12/05/52        1151316604/01/850204/01/852
run;
