 /*------------------------------------------------------------------ */
 /*              Validating Clinical Trials Using SAS®                */
 /*                                                                   */                                                                                               
 /*               by Carol I. Matthews and Brian C. Shilling          */
 /*       Copyright(c) 2008 by SAS Institute Inc., Cary, NC, USA      */
 /*                        ISBN 978-1-59994-128-8                     */                  
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
 /* addressed to the authors:                                         */
 /*                                                                   */
 /* SAS Institute Inc.                                                */
 /* SAS Press Series                                                  */
 /* Attn: Carol I. Matthews and Brian C. Shilling                     */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  saspress@sas.com           */
 /* Use this for subject field:                                       */
 /*     Comments for Carol I. Matthews and Brian C. Shilling          */
 /*                                                                   */
 /*-------------------------------------------------------------------*/


/*--------------------------------------------------------------**
** PROGRAM:    CHAPTER4_EXAMPLES.SAS
**
** PURPOSE:    PROGRAM EXAMPLES SHOWN IN CHAPTER 4
**
** CREATED:    12/2007
**
** INPUT:      ORGLIB.DEMO
**             ORGLIB.MEDHIST
**             ORGLIB.VISIT
**             ORGLIB.VITALS
**
**--------------------------------------------------------------**
** PROGRAMMED USING SAS VERSION 9.1.3                           **
**--------------------------------------------------------------*/

libname orglib "C:\Data\Original" ;

options nodate nocenter noreplace ls=68 ;



**-------------------------------------------------------------------------------**;
**  EXAMPLE 4.1 - SELECTING VALIDATION IDS                                       **;
**-------------------------------------------------------------------------------**;

%let valid = patid in(1 3 8) ;

proc print data=orglib.demo (where=(&valid)) ;
   var inv_no patid ;
   title 'INCOMING DATA' ;
run ;

data demo2 ;
   set orglib.demo ;
   length sitesubj $7 ;
   sitesubj = put(inv_no,z3.) || '-' || put(patid, z3.) ;
run ;

proc print data=demo2 (where=(&valid)) ;
   var inv_no patid sitesubj ;
   title 'DATA AFTER MANIPULATION' ;
run ;


**-------------------------------------------------------------------------------**;
**  EXAMPLE 4.2 - PRINT MISSING VALUES                                           **;
**-------------------------------------------------------------------------------**;

proc print data=orglib.vitals (where=(sysbp lt .Z)) ;
   var inv_no patid visit sysbp diabp resp pr ;
   title 'MISSING VITAL SIGNS?!' ;
run ;


**-------------------------------------------------------------------------------**;
**  EXAMPLES 4.3/4.4 - CELL INDEX                                                **;
**-------------------------------------------------------------------------------**;

proc sort data=orglib.medhist (where=(mhstatcd eq 1))
           out=body
           nodupkey;
   by mhbodsys inv_no patid ;
run ;

proc print data=body n ;
   where mhbodsys in('HEMATOLOGIC/ONCOLOGIC' 'HEPATIC/RENAL') ;
   by mhbodsys ;
   id mhbodsys ;
   var inv_no patid ;
   title "SUBJECTS GOING INTO TOTAL BODY SYSTEM COUNTS" ;
run ;

proc freq data=body noprint ;
   table mhbodsys / missing out=bsyscnt (drop=percent) ;
run ;

proc print data=bsyscnt ;
   title "COUNTS OF BODY SYSTEM" ;
run ;


**-------------------------------------------------------------------------------**;
**  EXAMPLE 4.5 - PROC FREQ TO CHECK RECODING                                    **;
**-------------------------------------------------------------------------------**;

proc format ;
   value racecd 1 = 'Caucasian'
                2 = 'Black'
                3 = 'Asian'
                4 = 'Hispanic'
                5 = 'American Indian'
                6 = 'Other' ;
run ;


data demo ;
   set orglib.demo ;
        if sexcd eq 1 then sex = "Male" ;
   else if sexcd eq 2 then sex = "Female" ;
   if racecd ne 6 then race = put(racecd, racecd.) ;
   else race = "Other";
run ;

proc freq data=demo ;
   tables racecd*race sexcd*sex / list missing nopercent nocum ;
   title 'CHECK RECODES' ;
run ;


**-------------------------------------------------------------------------------**;
**  EXAMPLE 4.6 - PROC FREQ WITH FORMATS TO CHECK DATA                           **;
**-------------------------------------------------------------------------------**;

proc format ;
   value chknums  . - .Z = 'MISSING'
                low - <0 = 'negative'
                       0 = 'ZERO'
                 0<-high = 'positive'
                   other = 'other???'
                    ;
   value chkbyten . - .Z = 'MISSING'
                 low -<0 = 'negative'
                       0 = 'ZERO'
                   0<-10 = '>0 - 10'
                  10<-20 = '>10 - 20'
                  20<-30 = '>20 - 30'
                  30<-40 = '>30 - 40'
                  40<-50 = '>40 - 50'
                  50<-60 = '>40 - 50'
                  60<-70 = '>40 - 50'
                  70<-80 = '>40 - 50'
                  80<-90 = '>40 - 50'
                   other = 'over 200?!'
                    ;
   value chkbyten
      . - .Z = 'MISSING'
      -9999999999-<0 = 'negative'
      0 = 'ZERO'
      0<-10 = '>0 - 10'
      10<-20 = '>10 - 20'
      20<-30 = '>20 - 30'
      30<-40 = '>30 - 40'
      40<-50 = '>40 - 50'
      50<-60 = '>50 - 60'
      60<-70 = '>60 - 70'
      70<-80 = '>70 - 80'
      80<-90 = '>80 - 90'
      90<-100= '>90 - 100'
      100<-110= '>100 - 110'
      110<-120= '>110 - 120'
      120<-130= '>120 - 130'
      130<-140= '>130 - 140'
      140<-150= '>140 - 150'
      150<-160= '>150 - 160'
      160<-170= '>160 - 170'
      170<-180= '>170 - 180'
      180<-190= '>180 - 190'
      190<-200= '>190 - 200'
      other = 'over 200'
      ;

   value chkdate    . - .Z     = '<<MISSING>>'
                  LOW - -21915 = 'Pre-1900?!'
                -21914- -18263 = '1900s'
                -18262- -14611 = '1910s'
                -14610- -10958 = '1920s'
                -10957-  -7306 = '1930s'
                -7305 -  -3653 = '1940s'
                -3652 -     -1 = '1950s'
                    0 -   3652 = '1960s'
                 3653 -   7304 = '1970s'
                 7305 -  10957 = '1980s'
                10958 -  14609 = '1990s'
                14610 -  16802 = '2000 - 2005'
                16803 -  17030 = '2006'
                17031 -  %sysfunc(today()) = '2007'
                %sysfunc(today()) - HIGH = 'FUTURE?!'
                ;

run ;

proc freq data=orglib.vitals ;
   format sysbp chkbyten. ;
   table sysbp / missing list nopercent ;
   title "CHECK SYSTOLIC BP ON ORIGINAL VITALS DATA" ;
run ;

proc freq data=orglib.visit ;
   format actdt chkdate. ;
   table actdt / missing list nopercent ;
   title "CHECK VISIT DATES" ;
run ;

proc print data=orglib.visit ;
   where actdt gt today() or actdt lt '01JAN2005'd ;
   var inv_no patid visit actdt ;
   title "CHECK ODD DATES" ;
run ;

**-------------------------------------------------------------------------------**;
**  CODE FOR OUTPUT 4.7 - CHECK OBS AFTER MERGE                                  **;
**-------------------------------------------------------------------------------**;

proc sort data=orglib.vitals out=vitals ;
   by inv_no patid visit ;
run ;

proc sort data=orglib.visit out=visit (where=(patid ne 25)) ;
   by inv_no patid visit ;
run ;

data vitals ;
   merge vitals(in=invl)
         visit (in=invt)
         ;
   by inv_no patid visit ;
   if invl and invt then output vitals ;
run ;



**-------------------------------------------------------------------------------**;
**  EXAMPLE 4.7 - MERGE WITH MSGLEVEL=I                                          **;
**-------------------------------------------------------------------------------**;

proc sort data=orglib.vitals (drop=pageno proto e_stat)
           out=vitals ;
   by inv_no patid visit ;
run ;

proc sort data=orglib.visit (drop=pageno proto e_stat)
           out=visit ;
   by inv_no patid visit ;
run ;

options msglevel=i ;

data vitals checkme ;
   merge vitals(in=invl)
         visit (in=invt) ;
   by inv_no patid visit ;
   if invl and invt then output vitals ;
                    else output checkme ;
run ;

proc print data=checkme ;
   title 'OBS NOT IN BOTH VISIT AND VITALS' ;
run ;


**-------------------------------------------------------------------------------**;
**  EXAMPLES 4.8, 4.9 AND 4.10 - TRANSPOSE VS. MERGE DATA TO ITSELF              **;
**-------------------------------------------------------------------------------**;

data demo ;
   set orglib.demo ;
   ** SET UP DATA FOR EXAMPLE **;
   if birthdt lt '01JAN1970'D then trtcd=1 ;
                              else trtcd=2 ;
   if barcode in('010011' '031171' '041611') then safety='N';
                                             else safety='Y';
run ;

proc freq data=demo ;
   table trtcd*safety / out=totsafe (drop=percent) noprint ;
run ;

proc print data=totsafe ;
   title 'SAFETY POPULATION COUNTS FROM PROC FREQ' ;
run ;

proc transpose data=totsafe out=transtot prefix=trt_;
   by safety ;
   id trtcd ;
   var count ;
run ;

proc print data=transtot ;
   title "TRANSPOSED TOTSAFE FROM PROC TRANSPOSE" ;
run ;

data mrgtot (drop = trtcd) check ;
   merge totsafe (where=(trtcd = 1) rename=(count = trt_1))
         totsafe (where=(trtcd = 2) rename=(count = trt_2));
   by safety;
   if trt_1 eq . and safety eq 'N' then trt_1 = 0 ;
   if trt_2 eq . and safety eq 'N' then trt_2 = 0 ;
   if (trt_1 eq . or trt_2 eq .) and safety eq 'Y' then output check ;
   else output mrgtot ;
run ;

proc print data=check ;
   title 'TREATEMENT GROUP WITH NO SAFETY EVAL PATIENTS - ISSUE?' ;
run ;

proc print data=mrgtot ;
   title 'TRANSPOSED TOTSAFE FROM DATA STEP MERGE' ;
run ;


**-------------------------------------------------------------------------------**;
**  EXAMPLE 4.12 - SEE MCHECK.SAS                                                **;
**-------------------------------------------------------------------------------**;


**-------------------------------------------------------------------------------**;
**  EXAMPLE 4.13 - USING MPRINT MACRO OPTION TO DEBUG                            **;
**-------------------------------------------------------------------------------**;

%macro dostuff(invar=,cutoff=) ;
   data d&invar dropped ;
      set vitals ;
      by inv_no patid ;
      retain &invar.flag ;
      if first.patid then &invar.flag = . ;
           if &invar lt &cutoff and &invar.flag lt 2 then &invar.flag = 1 ;
      else if &invar ge &cutoff                      then &invar.flag = 2 ;
      if not last.patid then output dropped ;
                        else output d&invar ;
   run ;
   proc print data=d&invar (obs=10) ;
      var inv_no patid visit &invar &invar.flag ;
      title "PTS WITH &INVAR SEVERITY FLAG CUTOFF OF &CUTOFF (10 OBS)" ;
   run ;
   proc print data=dropped ;
      var inv_no patid visit &invar &invar.flag ;
      title "DUPLICATES DROPPED - CHECK SEVERITY FLAG FOR &INVAR" ;
   run ;
%mend ;

%dostuff(invar=pr,cutoff=100)

options mprint ;

%dostuff(invar=pr,cutoff=100)


**-------------------------------------------------------------------------------**;
**  EXAMPLE 4.14 - USING MACRO OPTIONS SYMBOLGEN AND MLOGIC TO DEBUG             **;
**-------------------------------------------------------------------------------**;

%let valid=0;

%macro dostuff(invar=,cutoff=) ;
   data d&invar dropped ;
      set vitals ;
      by inv_no patid ;
      retain &invar.flag ;
      if first.patid then &invar.flag = . ;
           if &invar lt &cutoff and &invar.flag lt 2 then &invar.flag = 1 ;
      else if &invar ge &cutoff                      then &invar.flag = 2 ;
      if not last.patid then output dropped ;
                        else output d&invar ;
   run ;
   %if &valid=1 %then
   %do ;
      proc print data=d&invar (obs=10) ;
         var inv_no patid visit &invar &invar.flag ;
         title "PTS W/&INVAR SEVERITY FLAG CUTOFF=&CUTOFF (10 OBS)" ;
      run ;
      proc print data=dropped ;
         var inv_no patid visit &invar &invar.flag ;
         title "DUPLICATES DROPPED - CHECK SEVERITY FLAG FOR &INVAR" ;
      run ;
   %end ;
%mend ;


options symbolgen ;

%dostuff(invar=pr,cutoff=100)

options nosymbolgen mlogic ;

%dostuff(invar=pr,cutoff=100)


**-------------------------------------------------------------------------------**;
**  EXAMPLE 4.16 - PRINTS ON/OFF USING MACROS                                    **;
**-------------------------------------------------------------------------------**;

%let printme=0 ;

Proc print data=orglib.demo (where=(&printme)) ;
   Title "INCOMING DEMO DATA" ;
Run ;


**-------------------------------------------------------------------------------**;
**  EXAMPLE 4.18 - CHECK COMPLICATED LOGIC WITH FLAGS                            **;
**-------------------------------------------------------------------------------**;

data flags ;
   set orglib.vitals ;
   if temp lt 96 or temp gt 104 then tcheck = 1 ;
   if pr gt 95 then
   do ;
      gothere = 1 ;
      if resp le 16 then
      do ;
         gothere = 2 ;
         if temp ge 99 then newvar = 1 ;
      end ;
   end ;
run ;

proc print data=flags (where=(tcheck eq 1)) ;
   var inv_no patid visit temp ;
   title 'CHECK TEMPERATURE - DATA LOOKS TOO HIGH OR TOO LOW' ;
run ;

proc print data=flags (where=(gothere ne .)) ;
   var inv_no patid visit pr resp temp gothere newvar ;
   title "CHECK LOGIC FOR NEWVAR" ;
run ;


**-------------------------------------------------------------------------------**;
**  EXAMPLES 4.19 AND 4.20 - PROC TRANSPOSE VS. DATA STEP TRANSPOSE              **;
**-------------------------------------------------------------------------------**;

data vitals ;
   set orglib.vitals ;
   if barcode in('041421' '011971') and visit eq 'Day -8' then visit = ' ' ;
run ;

proc sort data=vitals ;
   by inv_no patid visit ;
run ;

proc print data=vitals (obs=10) ;
   var inv_no patid visit resp ;
   title 'VITALS BEFORE TRANSPOSE' ;
run ;

proc transpose data=vitals out=tresp ;
   by inv_no patid ;
   id visit ;
   var resp ;
run ;

proc print data=tresp (obs=10) ;
   title 'VITALS AFTER TRANSPOSE' ;
run ;

proc print data=tresp (where=( patid in(142 197) )) ;
run ;

data dresp (keep=inv_no patid visit test diff day: week:)
     check (keep=inv_no patid visit barcode) ;
   set vitals ;
   by inv_no patid visit ;

   ** CHECK FOR BAD ID VALUES **;
   if compress(visit) eq ' ' then output check ;

   ** SET UP FOR TRANSPOSE **;
   retain day_8 day_1 week1 - week6 ;
   array vars {8} day_8 day_1 week1 - week6 ;
   array tpts {8} $12 _temporary_ ('DAY -8' 'DAY -1' 'WEEK 1' 'WEEK 2'
                                   'WEEK 3' 'WEEK 4' 'WEEK 5' 'WEEK 6') ;
   ** RESET TEMP VARS FOR EACH NEW PATIENT **;
   if first.patid then
   do i = 1 to 8 ;
      vars{i} = . ;
   end ;
   ** FILL IN VARS HOLDING TRANSPOSED DATA **;
   do i = 1 to 8 ;
      test = "RESP" ;
      if upcase(visit) eq tpts{i} then vars{i} = resp ;
   end ;
   ** CALCULATE END OF STUDY CHANGE FROM BASELINE AND OUTPUT **;
   if last.patid then
   do ;
      if nmiss(day_1, week6) eq 0 then diff = week6 - day_1 ;
      output dresp ;
   end ;
run ;

proc print data=check ;
   title 'PROBLEM: MISSING VISIT ID' ;
run ;

proc print data=dresp (obs=10) ;
   var inv_no patid test day_8 day_1 week1 - week6 diff ;
   title 'VITALS AFTER DATA STEP TRANSPOSE' ;
run ;

proc print data=dresp (where=( patid in(142 197) )) ;
   var inv_no patid test day_8 day_1 week1 - week6 diff ;
run ;


**-------------------------------------------------------------------------------**;
**  EXAMPLE 4.21 - DROP DATA SET RATHER THAN DELETE STATEMENT                    **;
**-------------------------------------------------------------------------------**;

data temp dropped ;
   set vitals (keep=inv_no patid visit temp) ;
   if temp lt 0 then output dropped ;
                else output temp ;
run ;

proc print data=dropped ;
   title 'TEMP LESS THAN 0 SO DROPPED FROM DATA SET' ;
run ;



**-------------------------------------------------------------------------------**;
**  EXAMPLE 4.22 - DROP DUPLICATES WITH SORT AND DATA STEP                       **;
**-------------------------------------------------------------------------------**;

data dtemp dropped ;
   set vitals (where=(pr gt 90));
   by inv_no patid ;
   retain sevflag ;
   if first.patid then sevflag = . ;
        if pr lt 100 and sevflag lt 2 then sevflag = 1 ;
   else if pr ge 100                  then sevflag = 2 ;
   if not last.patid then output dropped ;
                     else output dtemp ;
run ;
proc print data=dtemp (obs=10) ;
   var inv_no patid visit pr sevflag ;
   title 'PATIENTS WITH HEART RATE OVER 90 WITH SEVERITY FLAG (10 OBS)' ;
run ;
proc print data=dropped ;
   var inv_no patid visit pr sevflag ;
   title 'DUPLICATES DROPPED - CHECK SEVERITY FLAG' ;
run ;


**-------------------------------------------------------------------------------**;
**  EXAMPLE 4.23 - DROP DUPLICATES WITH PROC SORT AND DUPOUT OPTION              **;
**-------------------------------------------------------------------------------**;

proc sort data=vitals (where=(pr gt 90))
           out=htemp
           nodupkey
           dupout=dropped ;
   by inv_no patid ;
run ;
proc print data=htemp (obs=10);
   var inv_no patid visit pr ;
   title '10 OBS OF PATIENTS WITH PULSE RATE OVER 90' ;
run ;
proc print data=dropped ;
   var inv_no patid visit pr ;
   title 'DUPLICATES DROPPED FROM PROC SORT' ;
run ;

