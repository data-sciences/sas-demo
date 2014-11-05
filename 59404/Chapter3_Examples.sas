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
** PROGRAM:    CHAPTER3_EXAMPLES.SAS
**
** PURPOSE:    PROGRAM EXAMPLES SHOWN IN CHAPTER 3
**
** CREATED:    12/2007
**
** INPUT:      ORGLIB.DEMO
**             ORGLIB.DEMOG
**             SUBLIB.DM_EX1
**
**--------------------------------------------------------------**
** PROGRAMMED USING SAS VERSION 9.1.3                           **
**--------------------------------------------------------------*/

libname orglib "C:\Data\Original" ;
libname sublib "C:\Data\Submission" ;

options nodate nocenter noreplace ls=68 ;

**-------------------------------------------------------------------------------**;
**  EXAMPLE 3.5 - BODY COMMENTS                                                  **;
**-------------------------------------------------------------------------------**;

**---------------------------------------------------------------**;
**  SUMMARY COUNTS OF EACH DEMOGRAPHIC CHARACTERISTIC BY SITE    **;
**---------------------------------------------------------------**;

proc sort data=sublib.dm_ex1 (keep=siteid sitesubj sex race)
           out=demo;
   by siteid sitesubj ;
run;

data demo ;
   set demo (rename=(race=racec)) ;
   by siteid sitesubj ;

   length race $30. ;
   ** PER SAP, IF RACE IN (HISPANIC, AMERICAN INDIAN),
      REPORT THEM WITH OTHER **;
   if racec not in ('Caucasian' 'Black' 'Asian') then
        race = 'Other' ;
   else race = trim(left(racec)) ;

   ** CREATE NUMERIC SORT VARIABLES TO ORDER SEX AND RACE **;
   racen = index('CBAO',substr(race,1,1)) ;
        if sex eq 'M' then sexn = 1 ;
   else if sex eq 'F' then sexn = 2 ;

   output ;

   ** CREATE RECORD FOR TOTAL ACROSS SITES **;
   siteid = '99' ;
   output ;
run ;

proc print data=demo (obs=50) ;
   title "REFORMATTED DATA FOR DEMO SUMMARY" ;
run ;


**-------------------------------------------------------------------------------**;
**  EXAMPLE 3.12 (AND EARLIER) - CODE WITH CONVENTIONS USED SO EASY TO READ      **;
**-------------------------------------------------------------------------------**;

** CODE WITH CASE CONVENTIONS **;
data test ;
   set orglib.demo ;
   by inv_no patid ;
   ** OUTPUT ONE RECORD PER SUBGROUP FOR EACH SUBJECT **;
   if patid lt 10 then
   do i = 1 to 4 ;
      subgroup = i ;
      output ;
   end ;
run ;

proc print data=test ;
   title 'TEST DATA' ;
run ;


**-------------------------------------------------------------------------------**;
**  EXAMPLES 3.13 AND 3.14 - ORDER YOUR DATA                                     **;
**-------------------------------------------------------------------------------**;

proc format ;
   value racecd 1 = 'Caucasian'
                2 = 'Black'
                3 = 'Asian'
                4 = 'Hispanic'
                5 = 'American Indian'
                6 = 'Other' ;
run ;


**--------------------------------------------------------------**;
**  GET VARIABLES FROM DEMO DATA                                **;
**--------------------------------------------------------------**;

proc contents data=orglib.demo ;
   title 'DEMO DATA FOR PROC CONTENTS EXAMPLE' ;
run ;

data demo ;
   length race $25 ;
   set orglib.demo (drop  =barcode pageno proto e_stat seq);

   length siteid $3 subjid $5 sitesubj $10 ;

   **  ASSIGN STANDARD CDISC VARIABLES  **;
   studyid = "XYZ4-SAMP-001" ;
   domain  = 'DM' ;
   country = 'USA' ;

   **  GET SITE ID  **;
   siteid = put(inv_no, z2.) ;

   **  GET SUBJECT ID  **;
   subjid = put(patid, z3.) ;

   **  GET REPORTED VERSION OF SUBJECT ID  **;
   sitesubj = compress(siteid) || compress(subjid) ;

   **  GET UNIQUE SUBJECT ID  **;
   usubjid = trim(left(studyid)) || '-' ||
             trim(left(siteid))  || '-' ||
             trim(left(subjid)) ;

   ** CREATE CHARACTER SEX **;
        if sexcd eq 1 then sex = 'M' ;
   else if sexcd eq 2 then sex = 'F' ;

   **  COMBINE RACE AND OTHER SPECIFY  **;
   if racecd eq 6 then race = trim(left(raceoth)) ;
                  else race = put(racecd,racecd.) ;

run ;

proc sort data=demo ;
   by sitesubj ;
run ;

proc print data=demo (where=(racecd in(4 6)) obs=5) heading=H;
   title '5 OBS FROM DEMO WITH CDISC ID VARS ADDED' ;
run ;

**--------------------------------------------------------------**;
**  OUTPUT SORTED DATA SET                                      **;
**--------------------------------------------------------------**;

options replace ;

proc sql ;
   create table sublib.dm_ex1 (label='Demographics') as
   select domain, studyid, country, usubjid, siteid, subjid,
          sitesubj, subjinit, visit, sex, race, birthdt
   from demo
   order by sitesubj ;
quit ;

proc compare base=sublib.dm_ex1 compare=demo listall ;
   id sitesubj ;
   title "COMPARE OF REORDERED DATA SET" ;
run ;

proc print data=sublib.dm_ex1 (obs=10) heading=h ;
   title "10 OBS FROM OUTGOING DEMO DATA" ;
run ;

proc contents data=sublib.dm_ex1 ;
   title "FINAL DEMO DATA SET" ;
run ;


**-------------------------------------------------------------------------------**;
**  EXAMPLE 3.16 - GOOD HOUSEKEEPING/DROP TEMP VARIABLES                         **;
**-------------------------------------------------------------------------------**;

** COUNT EACH SEX **;
data temp ;
   set orglib.demog (keep=site patid sex racecd_) end=lastrec;
   retain cnt1 cnt2 ;
   if sex eq 1 then cnt1+1 ;
   else if sex eq 2 then cnt2+1 ;
   if lastrec then
      do ;
         mcnt = cnt1 ;
         fcnt = cnt2 ;
      end ;
run ;

** COUNT EACH RACE **;
data temp ;
   set temp end=lastrec ;
   retain cnt1 cnt2 ;
   oldcnt1=cnt1 ;  ** THESE 2 LINES FOR EXAMPLE ONLY **;
   oldcnt2=cnt2 ;
   if racecd_ eq 1 then cnt1+1 ;
                   else cnt2+1 ;
   if lastrec then
      do ;
         wcnt = cnt1 ;
         ocnt = cnt2 ;
      end ;
run ;

proc print data=temp ;
   title 'COUNT OF RACE MIXED WITH SEX' ;
run ;


**-------------------------------------------------------------------------------**;
**  EXAMPLE 3.17 - HARDCODING                                                    **;
**-------------------------------------------------------------------------------**;

proc print data=orglib.demog (obs=10) ;
   title "DEMO DATA FOR HARDCODE EXAMPLE" ;
run ;

proc format ;
   value racecd 1 = 'Caucasian'
                2 = 'Black'
                3 = 'Asian'
                9 = 'Other' ;
run ;

data demo ;
   set orglib.demog (rename=(sex=sexcd));

   ** SCENARIO 1 **;
        if site eq 1 and patid eq 2 then sexcd = 2 ;
   else if site eq 2 and patid eq 2 then sexcd = 1 ;

   ** SCENARIO 2 **;
        if site eq 1 then sexcd = 2 ;
   else if site eq 2 then sexcd = 1 ;

   ** SCENARIO 3 **;
        if sexcd eq 1 then sex = 'Male' ;
   else if sexcd eq 2 then sex = 'Female' ;

   ** SCENARIO 4 **;
   length race $40 ;
   if racecd_ ne 9 then race = put(racecd_,racecd.) ;
                   else race = racespec ;

run ;


