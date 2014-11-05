/*------------------------------------------------------------------- */
 /*       SAS Programming in the Pharmaceutical Industry              */
 /*                   by Jack Shostak                                 */
 /*       Copyright(c) 2005 by SAS Institute Inc., Cary, NC, USA      */
 /*                                                                   */
 /*                        ISBN 1-59047-793-6                         */
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
 /* Attn: Jack Shostak                                                */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  saspress@sas.com           */
 /* Use this for subject field:                                       */
 /*     Comments for Jack Shostak                                     */
 /*                                                                   */
 /*-------------------------------------------------------------------*/





Program 1.1	Librefs That Commonly Occur at the Start of a SAS Program

libname trialdata "c:\mytrial\sasdata";
libname library "c:\mytrial\mysasformats";
libname otherdata "c:\someotherdata";
---------------------------------------------------------------------------
Program 1.2	Using a SAS Macro to Define Common Librefs

%macro mylibs;
   libname trialdata "c:\mytrial\sasdata";
   libname library "c:\mytrial\mysasformats";
   libname otherdata "c:\someotherdata";
%mend mylibs;
---------------------------------------------------------------------------
Program 1.3	Subsetting a Data set for Patients With an Adverse Event

data aes;
   set aes;
      by subjectid;
         where aeyn = "YES";
run;
---------------------------------------------------------------------------
Program 1.4	Subsetting a Data set for Patients With an Adverse Event Using Defensive Programming Techniques

data aes;
   set aes;
      by subjectid;

      **** PARENT-CHILD WARNING;
      if (aeyn ne "YES" and aetext ne "") or
         (aeyn = "YES" and aetext = "") then
         put "WARN" "ING: ae parent-child bug " aeyn= aetext=;

      **** GET AES;
      if aeyn = "YES" or aetext ne "";
run;
---------------------------------------------------------------------------
Program 1.5	Example of Simple Conditional Logic IF-THEN-ELSE

if a > b then
   a + b;
else if a < b then
   a - b;
---------------------------------------------------------------------------
Program 1.6	Example of Simple Conditional Logic IF-THEN-ELSE Using Defensive Programming Techniques

if a > b then
   a = a + b;
else if a < b then
   a = a - b;
else 
   put "How does a relate to b? " a= b=;
---------------------------------------------------------------------------
Program 1.7	Example of Simple Conditional Logic SELECT

select;
   when(a > b) a = a + b;
   when(a < b) a = a - b;
   otherwise put "What am I missing " a= b=;
end;
---------------------------------------------------------------------------
Program 1.8	Example of SAS Macro Code that You Should Not Write

data &&some&i;
   &getfile &subopt;
      &subset;
      %makecod
%run
---------------------------------------------------------------------------
Program 1.9	Reinventing SAS BY-Processing with a SAS Macro 

proc sort
   data = demog;
      by subjectid;
run;

**** SAS MACRO TO PRINT MY DEMOGRAPHIC DATA BY PATIENT;
%macro printpt(subjectid);
   proc print
      data = demog;
      where subjectid = "&subjectid";
      var subjectid age sex race;
   run;
%mend printpt;

%printpt(101-001)
%printpt(101-002)
%printpt(101-003)
---------------------------------------------------------------------------
Program 1.10	Using SAS BY-Processing Instead of SAS Macro

proc sort
   data = demog;
      by subjectid;
run;

**** PRINT MY DEMOGRAPHIC DATA BY PATIENT;
proc print
   data = demog;
      by subjectid;
      var subjectid age sex race;
run;
---------------------------------------------------------------------------
Program 2.1	Categorizing Numeric Data

data demog;
   set demog;
      by subject;

      if .z < age <= 18 then
         age_cat = 1;
      else if 18 < age <= 60 then
         age_cat = 2;
      else if 60 < age then
         age_cat = 3; 
run;
---------------------------------------------------------------------------
Program 2.2	Summarizing Free Text Adverse Event Data

data adverse;
input subjectid $ 1-7 ae $ 9-41;
datalines;
100-101 HEDACHE
100-105 HEADACHE
100-110 MYOCARDIAL INFARCTION
200-004 MI
300-023 BROKEN LEG
400-010 HIVES
500-001 LIGHTHEADEDNESS/FACIAL LACERATION
;
run;

proc freq 
   data = adverse;
   tables ae;
run;
---------------------------------------------------------------------------
Program 2.3	Summarizing Coded Adverse Event Data

data adverse;

label aecode      = "Adverse Event Code"
      ae_verbatim = "AE Verbatim CRF text"
      ae_pt       = "AE preferred term";

input subjectid $ 1-7 aecode $ 9-16 
      ae_verbatim $ 18-39 ae_pt $ 40-60;

datalines;
100-101 10019211 HEDACHE               HEADACHE
100-105 10019211 HEADACHE              HEADACHE
100-110 10028596 MYOCARDIAL INFARCTION MYOCARDIAL INFARCTION
200-004 10028596 MI                    MYOCARDIAL INFARCTION
300-023 10061599 BROKEN LEG            LOWER LIMB FRACTURE
400-010 10046735 HIVES                 URTICARIA
500-001 10013573 LIGHTHEADEDNESS       DIZZINESS
500-001 10058818 FACIAL LACERATION     SKIN LACERATION
;
run;

proc freq
   data = adverse;
   tables ae_pt;
run;
---------------------------------------------------------------------------
Program 2.4	A Hardcoding Example

data endstudy;
   set endstudy;

   if subjid = "101-1002" then
      discterm = "Death";
run;
---------------------------------------------------------------------------
Program 2.5	An Improved Hardcoding Example

data endstudy;
   set endstudy;

   **** HARDCODE APPROVED BY DR. NAME AT SPONSOR ON 02/02/2002;
   if subjid = "101-1002" and "&sysdate" <= "01MAY2002"d then
      do;
         discterm = "Death";
         put "Subject " subjid "hardcoded to termination reason "
             discterm;
      end;
run;
---------------------------------------------------------------------------
Program 3.1	Using SQL Pass-through to Get Data From Oracle

proc sql;
   connect to oracle as oracle_tables
           (user = USERID  orapw = PASSWORD  path = "INSTANCE");

   create table AE as
      select * from connection to oracle_tables
      (select * from AE_ORACLE_TABLE );

   disconnect from oracle_tables;
quit;
---------------------------------------------------------------------------
Program 3.2	Using SQL Pass-through to Get Select Data From Oracle

proc sql;
   connect to oracle as oracle_tables
      (user = USERID  orapw = PASSWORD  path ="INSTANCE");

   create table library.AE as
      select * from connection to oracle_tables
      (select subject, verbatim, ae_date, pt_text
         from AE_ORACLE_TABLE 
         where query_clean="YES");

   disconnect from oracle_tables;
quit;
---------------------------------------------------------------------------
Program 3.3	Using SAS/ACCESS LIBNAME Engine to Get Data From Oracle

libname oratabs oracle user=USERNAME
        orapw = PASSWORD  path = "@INSTANCE"  schema = TRIALNAME;

data adverse;
   set oratabs.AE_ORACLE_TABLE;
      where query_clean = "YES";
      keep subject verbatim ae_date pt_text; 
run;
---------------------------------------------------------------------------
Program 3.4	PROC IMPORT Code Written by the Import Wizard to Read ASCII file

PROC IMPORT OUT= WORK.LABNORM 
            DATAFILE= "C:normal_ranges.txt" 
            DBMS=DLM REPLACE;
     DELIMITER='7C'x; 
     GETNAMES=YES;
     DATAROW=2; 
     GUESSINGROWS=20; 
RUN;
---------------------------------------------------------------------------
Program 3.5	Writing Custom SAS Code to Import Lab Normal Data

proc format;
   value $gender  "F" = "Female"
                  "M" = "Male";
run;

data labnorm;
   infile 'C:\normal_ranges.txt' delimiter = '|' DSD MISSOVER                
          firstobs = 2;

   informat 	Lab_Test $20. 
               	Units $9. 
               	Gender $1. ;

   format	Lab_Test $20.
    		Units $9. 
               	Gender $gender.;

   input  	Lab_Test $
	       	Units $
       		Gender $
       		Low_Age
       		High_Age
       		Low_Normal
       		High_Normal;

   label 	Lab_Test    = "Laboratory Test"
		Units       = "Lab Units"
		Gender      = "Gender"
		Low_Age     = "Lower Age Range"
		High_Age    = "Higher Age Range"
		Low_Normal  = "Low Normal Lab Value Range"
		High_Normal = "High Normal Lab Value Range";
run;
---------------------------------------------------------------------------
Program 3.6	Using the LIBNAME Statement to Read Excel Data

libname xlsfile EXCEL "C:\normal_ranges.xls";
proc contents 
   data = xlsfile._all_;
run;
  	
proc print 
   data = XLSFILE.'normal_ranges$'n;
run;
---------------------------------------------------------------------------
Program 3.7	Using the LIBNAME Statement to Read Access Data

libname accfile ACCESS "C:\normal_ranges.mdb"; 

proc contents 
   data = accfile._all_;
run;
  	
proc print 
   data = accfile.normal_ranges;
run;
---------------------------------------------------------------------------
Program 3.8	PROC IMPORT Code Written by the Import Wizard to Read Excel file

PROC IMPORT OUT= WORK.normal_ranges 
            DATAFILE= "C:\normal_ranges.xls" 
            DBMS=EXCEL REPLACE;
     SHEET="normal_ranges$"; 
     GETNAMES=YES;
     MIXED=NO;  
     SCANTEXT=YES;   
     USEDATE=YES;    
     SCANTIME=YES;   
RUN;
---------------------------------------------------------------------------
Program 3.9	Using SQL Pass-through to Read Excel Data

**** OBTAIN AVAILABLE WORKSHEET NAMES FROM EXCEL FILE;
proc sql;      
   connect to excel (path = "C:\normal_ranges.xls");
   select table_name from connection to excel(jet::tables); 
quit;

**** GO GET NORMAL_RANGES WORKSHEET FROM EXCEL FILE;
proc sql;
   connect to EXCEL (path = "C:\normal_ranges.xls" header = yes    
           mixed = yes  version = 2000 );
   create table normal_ranges as
      select * from connection to excel
      (select * from [normal_ranges$]);
   disconnect from excel; 
quit; 
---------------------------------------------------------------------------
Program 3.10  Using SQL Pass-through to Read Access Data

*** OBTAIN AVAILABLE TABLE NAMES FROM ACCESS FILE;
proc sql;      
  connect to access (path = "C:\normal_ranges.mdb");
  select table_name from connection to access(jet::tables); 
quit;

**** GO GET NORMAL_RANGES WORKSHEET FROM ACCESS FILE;
proc sql;
   connect to access (path = "C:\normal_ranges.mdb");
   create table normal_ranges as
      select * from connection to access
      (select * from normal_ranges);
   disconnect from access; 
quit;
---------------------------------------------------------------------------
Program 3.11  Using the SML LIBNAME Engine to Read XML Data

filename  normals 'C:\normal_ranges.xml';
libname   normals xml xmlmap=XML_MAP;
filename  XML_MAP 'C:\xml_map.map';

proc contents 
   data = normals.normals; 
run;

proc print 
   data = normals.normals; 
run;
---------------------------------------------------------------------------
Program 3.12  Using PROC CDISC to Read ODM XML Data

**** FILENAME POINTING TO ODM FILE;
filename dmodm "C:\SAS_BOOK\sas_code\import\dm.xml";

**** PROC CDISC TO IMPORT DM.XML TO DM WORK DATA SET;
proc cdisc
   model               = odm
   read                = dmodm
   formatactive        = yes
   formatnoreplace     = no;

   odm         
   odmversion          = "1.2"                   
   odmmaximumoidlength = 30 
   odmminimumkeyset    = no;

   clinicaldata 
   out                 = work.dm
   sasdatasetname      = "DM";
run;
---------------------------------------------------------------------------
Program 4.1	Deriving Last Observation Carried Forward (LOCF) Variables

**** INPUT SAMPLE CHOLESTEROL DATA.;
**** SUBECT = PATIENT NUMBER, SAMPDATE = LAB SAMPLE DATE, HDL = HDL,;
**** LDL = LDL, AND TRIG = TRIGLYCERIDES.;
data chol;
input subject $ sampdate date9. hdl ldl trig; 
datalines;
101 05SEP2003 48 188 108
101 06SEP2003 49 185 .  
102 01OCT2003 54 200 350
102 02OCT2003 52 .   360
103 10NOV2003 .  240 900
103 11NOV2003 30 .   880
103 12NOV2003 32 .   .  
103 13NOV2003 35 289 930
; 
run;

**** INPUT SAMPLE PILL DOSING DATA.;
**** SUBECT = PATIENT NUMBER, DOSEDATE = DRUG DOSING DATE.;
data dosing;
input subject $ dosedate date9.; 
datalines;
101 07SEP2003
102 07OCT2003
103 13NOV2003
;
run;

**** SORT CHOLESTEROL DATA FOR MERGING WITH DOSING DATA.;
proc sort
   data = chol;
      by subject sampdate;
run;

**** SORT DOSING DATA FOR MERGING WITH CHOLESTEROL DATA.;
proc sort
   data = dosing;
      by subject;
run;

**** DEFINE BASELINE HDL, LDL, AND TRIG VARIABLES;
data baseline;
   merge chol dosing;
      by subject;

      **** SET UP ARRAYS FOR BASELINE VARIABLES AND LAB VALUES;
      array base {3} b_hdl b_ldl b_trig;
      array chol {3}   hdl   ldl   trig;

      keep subject b_hdl b_ldl b_trig;
      retain b_hdl b_ldl b_trig;

      **** INITIALIZE BASELINE VARIABLES TO MISSING;
      if first.subject then
         do i = 1 to 3;
            base{i} = .;
         end;
		
      **** IF LAB VALUE IS WITHIN 5 DAYS OF DOSING, RETAIN IT AS A;
      **** VALID BASELINE VALUE.;
      if 1 <= (dosedate - sampdate) <= 5 then
         do i = 1 to 3;
            if chol{i} ne . then
               base{i} = chol{i};
         end;

      **** KEEP LAST RECORD PER PATIENT AS THESE HOLD THE LOCF VALUES.;
      if last.subject;

      label b_hdl  = "Baseline HDL"
            b_ldl  = "Baseline LDL"
            b_trig = "Baseline triglicerides";
run;
---------------------------------------------------------------------------
Program 4.2	Calculating a Continuous Study Day

study_day = event_date - intervention_date + 1;
---------------------------------------------------------------------------
Program 4.3	Calculating a Study Day Without Day Zero

if event_date < intervention_date then
   study_day = event_date ? intervention_date;
else if event_date >= intervention_date then
   study_day = event_date ? intervention_date + 1;
---------------------------------------------------------------------------
Program 4.4	Deriving a Visit Based on Visit Windowing

**** INPUT SAMPLE LAB DATA.
**** SUBJECT = PATIENT NUMBER, LAB_TEST = LABORATORY TEST NAME,
**** LAB_DATE = lABORATORY COLLECTION DATE, LAB_RESULT = LAB VALUE.;
data labs;
input subject $ lab_test $ lab_date lab_result; 
datalines;
101 HGB 999 1.0
101 HGB 1000 1.1
101 HGB 1011 1.2
101 HGB 1029 1.3
101 HGB 1030 1.4
101 HGB 1031 1.5
101 HGB 1058 1.6
101 HGB 1064 1.7
101 HGB 1725 1.8
101 HGB 1735 1.9
;
run;

**** INPUT SAMPLE DOSING DATE.
**** SUBJECT = PATIENT NUMBER, DOSE_DATE = DATE OF DOSING.;
data dosing;
input subject $ dose_date; 
datalines;
101 1001
;
run;

**** SORT LAB DATA FOR MERGE WITH DOSING;
proc sort
   data = labs;
      by subject;
run;

**** SORT DOSING DATA FOR MERGE WITH LABS.;
proc sort
   data = dosing;
      by subject;
run;

**** MERGE LAB DATA WITH DOSING DATE. CALCULATE STUDY DAY AND
**** DEFINE VISIT WINDOWS BASED ON STUDY DAY.;
data labs;
   merge labs(in = inlab)  
         dosing(keep = subject dose_date);
      by subject;

      **** KEEP RECORD IF IN LAB AND RESULT IS NOT MISSING.;
      if inlab and lab_result ne .;
        
      **** CALCULATE STUDY DAY.;
      if lab_date < dose_date then
         study_day = lab_date - dose_date;
      else if lab_date >= dose_date then
         study_day = lab_date - dose_date + 1;

      **** SET VISIT WINDOWS AND TARGET DAY AS THE MIDDLE OF THE WINDOW.;
      if . < study_day < 0 then
         target = 0;
      else if 25 <= study_day <= 35 then
         target = 30;
      else if 55 <= study_day <= 65 then
         target = 60;
      else if 350 <= study_day <= 380 then
         target = 365;
      else if 715 <= study_day <= 745 then
         target = 730;

      **** CALCULATE OBSERVATION DISTANCE FROM TARGET AND
      **** ABSOLUTE VALUE OF THAT DIFFERENCE.;
      difference = study_day - target;          
      absdifference = abs(difference);      
run;

**** SORT DATA BY DECREASING ABSOLUTE DIFFERENCE AND ACTUAL DIFFERENCE
**** WITHIN A VISIT WINDOW.;
proc sort
   data = labs;
      by subject lab_test target absdifference difference;
run;

**** SELECT THE RECORD CLOSEST TO THE TARGET AS THE RECORD OF CHOICE
**** TIES ON BOTH SIDES OF THE TARGET GO TO THE EARLIER OF THE TWO OBSERVATIONS.;
data labs;
   set labs;
      by subject lab_test target absdifference difference;

      if first.target and target ne . then
         visit_number = target;          
run; 
---------------------------------------------------------------------------
Program 4.5	Transposing Data with PROC TRANSPOSE

**** INPUT SAMPLE NORMALIZED SYSTOLIC BLOOD PRESSURE VALUES.
**** SUBJECT = PATIENT NUMBER, VISIT = VISIT NUMBER, 
**** SBP = SYSTOLIC BLOOOD PRESSURE.;
data sbp;
input subject $ visit sbp; 
datalines;
101 1 160
101 3 140
101 4 130
101 5 120
202 1 141
202 3 161
202 4 171
202 5 181
;
run;

**** TRANSPOSE THE NORMALIZED SBP VALUES TO A FLAT STRUCTURE.;
proc transpose
   data = sbp
   out = sbpflat
   prefix = VISIT;
      by subject;
      id visit;
      var sbp;
run; 
---------------------------------------------------------------------------
Program 4.6	Using PROC TRANSPOSE Without and With an ID Statement

**** INPUT SAMPLE NORMALIZED SYSTOLIC BLOOD PRESSURE VALUES.
**** SUBJECT = PATIENT NUMBER, VISIT = VISIT NUMBER, 
**** SBP = SYSTOLIC BLOOOD PRESSURE.;
data sbp;
input subject $ visit sbp; 
datalines;
101 1 160
101 3 140
101 4 130
101 5 120
202 1 141
202 2 151
202 3 161
202 4 171
202 5 181
;
run;

**** TRANSPOSE THE NORMALIZED SBP VALUES TO A FLAT STRUCTURE WITHOUT ID.;
proc transpose
   data = sbp
   out = sbpflat
   prefix = VISIT;
      by subject;
      var sbp;
run; 

**** TRANSPOSE THE NORMALIZED SBP VALUES TO A FLAT STRUCTURE WITH ID.;
proc transpose
   data = sbp
   out = sbpflat
   prefix = VISIT;
      by subject;
      id visit;
      var sbp;
run;
---------------------------------------------------------------------------
Program 4.7	Transposing Data with the DATA step

**** INPUT SAMPLE NORMALIZED SYSTOLIC BLOOD PRESSURE VALUES.
**** SUBJECT = PATIENT NUMBER, VISIT = VISIT NUMBER, 
**** SBP = SYSTOLIC BLOOOD PRESSURE.;
data sbp;
input subject $ visit sbp; 
datalines;
101 1 160
101 3 140
101 4 130
101 5 120
202 1 141
202 3 161
202 4 171
202 5 181
;
run;

**** SORT SBPS BY SUBJECT.;
proc sort
   data = sbp;
      by subject;
run;

**** TRANSPOSE THE NORMALIZED SBP VALUES TO A FLAT STRUCTURE.;
data sbpflat;
   set sbp;
      by subject;

      keep subject visit1-visit5;
      retain visit1-visit5;
         
      **** DEFINE ARRAY TO HOLD SBP VALUES FOR 5 VISITS.;
      array sbps {5} visit1-visit5;

      **** AT FIRST SUBJECT, INITIALIZE ARRAY TO MISSING.;
      if first.subject then
         do i = 1 to 5;
            sbps{i} = .;
	 end;

      **** AT EACH VISIT LOAD THE SBP VALUE INTO THE PROPER SLOT
      **** IN THE ARRAY.;
      sbps{visit} = sbp;

      **** KEEP THE LAST OBSERVATION PER SUBJECT WITH 5 SBPS.;
      if last.subject;
run;
---------------------------------------------------------------------------
Program 4.8	Performing a Many-to-Many Join with PROC SQL

**** ADVERSE EVENTS;
data aes;
informat ae_start date9. ae_stop date9.;
input @1 subject_id $3.
      @5 ae_start date9.  
      @15 ae_stop date9. 
      @25 adverse_event $15.;
datalines;
101 01JAN2004 02JAN2004 Headache
101 15JAN2004 03FEB2004 Back Pain
102 03NOV2003 10DEC2003 Rash
102 03JAN2004 10JAN2004 Abdominal Pain
102 04APR2004 04APR2004 Constipation
;
run;

**** CONCOMITANT MEDICATIONS;
data conmeds;
informat cm_start date9. cm_stop date9.;
input @1 subject_id $3.
      @5 cm_start date9.  
      @15 cm_stop date9. 
      @25 conmed $20.;
datalines;
101 01JAN2004 01JAN2004 Acetaminophen
101 20DEC2003 20MAR2004 Tylenol w/ Codeine
101 12DEC2003 12DEC2003 Sudafed
102 07DEC2003 18DEC2003 Hydrocortizone Cream
102 06JAN2004 08JAN2004 Simethicone
102 09JAN2004 10MAR2004 Esomeprazole
;
run;

**** MERGE MEDICATIONS WITH ADVERSE EVENTS;
proc sql;
   create table ae_meds as
   select a.subject_id, a.ae_start, a.ae_stop, a.adverse_event,
          c.cm_start, c.cm_stop, c.conmed from
   aes as a  left join  conmeds as c
   on (a.subject_id = c.subject_id) and
      ( (a.ae_start <= c.cm_start <= a.ae_stop) or
        (a.ae_start <= c.cm_stop <= a.ae_stop) or
       ((c.cm_start < a.ae_start) and (a.ae_stop < c.cm_stop)) );
quit; 
---------------------------------------------------------------------------
Program 4.9	Bringing the MedDRA Dictionary Tables Together 

**** SORT LOW LEVEL TERM DATA FROM MEDDRA WHERE
**** LOW_LEVEL_TERM = LOWEST LEVEL TERM, LLT_CODE = LOWEST
**** LEVEL TERM CODE, AND PT_CODE = PREFERRED TERM CODE.;
proc sort
   data = low_level_term(keep = low_level_term llt_code pt_code);
      by pt_code;
run;  

**** SORT PREFERRED TERM DATA FROM MEDDRA WHERE
**** PREFERRED_TERM = PREFERRED TERM, SOC_CODE = SYSTEM
**** ORGAN CLASS CODE, AND PT_CODE = PREFERRED TERM CODE.; 
proc sort
   data = preferred_term(keep = preferred_term pt_code soc_code);
      by pt_code;
run;

**** MERGE LOW LEVEL TERMS WITH PREFERRED TERMS KEEPING ALL LOWER 
**** LEVEL TERM RECORDS.;
data llt_pt;
   merge low_level_term (in = inlow)
         preferred_term;
      by pt_code;

      if inlow;
run;

**** SORT BODY SYSTEM DATA FROM MEDDRA WHERE
**** SYSTEM_CLASS_TERM = SYSTEM ORGAN CLASS TERM AND SOC_CODE =
**** SYSTEM ORGAN CLASS CODE.; 
proc sort
   data = soc_term(keep = system_class_term soc_code);
      by soc_code;
run;

**** SORT LOWER LEVEL TERM AND PREFERRED TERMS FOR MERGE WITH
**** SYSTEM ORGAN CLASS DATA.;
proc sort
   data = llt_pt;
      by soc_code;
run;

**** MERGE PREFERRED TERM LEVEL WITH BODY SYSTEMS;
data meddra;
   merge llt_pt (in = in_llt_pt)
         soc_term;
      by soc_code;

      if in_llt_pt;
run;
---------------------------------------------------------------------------
Program 4.10   Pulling Preferred Terms Out of WHODrug 

proc sort
   data = whodrug(keep = seq1 seq2 drug_name drugrecno
                  where = (seq1 = '01' and seq2 = '001') );
          nodupkey
      by drugrecno drug_name;
run;
---------------------------------------------------------------------------
Program 4.11    Using Implicit or Explicit Centuries with Dates

**** DISPLAY YEARCUTOFF SETTING PIVOT POINT;
proc options option=yearcutoff;
run;

**** DATES DEFINED WITH IMPLICIT CENTURY;
data _null_;
   date = "01JAN19"d;
   put date = date9.;
   date = "01JAN20"d;
   put date = date9.;
run;

**** DATES DEFINED WITH EXPLICIT CENTURY;
data _null_;
   date = "01JAN1919"d;
   put date = date9.;
   date = "01JAN1920"d;
   put date = date9.;
run;
---------------------------------------------------------------------------
Program 4.12    Redefining a Variable within a DATA step

**** INPUT SAMPLE ADVERSE EVENT DATA WHERE SUBJECT = PATIENT ID 
**** AND ADVERSE_EVENT = ADVERSE EVENT TEXT.;
data aes;
input @1  subject $3.
      @5  adverse_event $15.;
datalines;
101 Headache
102 Rash
102 Fatal MI
102 Abdominal Pain
102 Constipation
;
run;

**** INPUT SAMPLE DEATH DATA WHERE SUBJECT = PATIENT NUMBER AND
**** DEATH = 1 IF PATIENT DIED, 0 IF NOT.;
data death;
input @1 subject $3. 
      @5 death 1.;
datalines;
101 0
102 0
;
run;

**** SET DEATH = 1 FOR PATIENTS WHO HAD ADVERSE EVENTS THAT
**** RESULTED IN DEATH.;
data aes;
   merge demog aes;
      by subject;

      if adverse_event = "Fatal MI" then
         death = 1;
run;



For the above example, the following code is a workaround to the automatic variable retention feature



**** FLAG EVENTS THAT RESULTED IN DEATH;
data aes;
   merge death(rename = (death = _death)) aes;
      by subject;

      **** DROP OLD DEATH VARIABLE.;
      drop _death;

      **** CREATE NEW DEATH VARIABLE.;
      if adverse_event = "Fatal MI" then
         death = 1;
      else
	 death = _death;
run;
---------------------------------------------------------------------------
Program 4.13    Using the ROUND function with Floating Point Comparisons

**** FLAG LAB VALUE AS LOW OR HIGH;
data labs;
   set labs;

   if .z < lab_value < 3.15 then
      hi_low_flag = "L";
   else if lab_value > 5.5 then
      hi_low_flag = "H";
run;


To handle the floating point comparison problem, the above example can be written more safely like this:


**** FLAG LAB VALUE AS LOW OR HIGH;
data labs;
   set labs;

   if .z < round(lab_value,.000000001) < 3.15 then
      hi_low_flag = "L";
   else if round(lab_value,.000000001) > 5.5 then
      hi_low_flag = "H";
run;
---------------------------------------------------------------------------
Program 4.14   Creating a Blood Pressure Change from Baseline Data Set

**** INPUT SAMPLE BLOOD PRESSURE VALUES WHERE
**** SUBJECT = PATIENT NUMBER, WEEK = WEEK OF STUDY, AND 
**** TEST = SYSTOLIC (SBP) OR DIASTOLIC (DBP) BLOOD PRESSURE.;
data bp;
input subject $ week test $ value; 
datalines;
101 0 DBP 160
101 0 SBP  90
101 1 DBP 140
101 1 SBP  87
101 2 DBP 130
101 2 SBP  85
101 3 DBP 120
101 3 SBP  80
202 0 DBP 141
202 0 SBP  75
202 1 DBP 161
202 1 SBP  80
202 2 DBP 171
202 2 SBP  85
202 3 DBP 181
202 3 SBP  90
;
run;
 
**** SORT DATA BY SUBJECT, TEST NAME, AND WEEK;
proc sort
   data = bp;
      by subject test week;
run;

**** CALCULATE CHANGE FROM BASELINE SBP AND DBP VALUES.;
data bp;
   set bp;
      by subject test week;

      **** CARRY FORWARD BASELINE RESULTS.;
      retain baseline;
      if first.test then
         baseline = .;
	    
      **** DETERMINE BASELINE OR CALCULATE CHANGES.;
      if visit = 0 then
         baseline = value;
      else if visit > 0 then
         do;
	    change = value - baseline;
	    pct_chg = ((value - baseline) /baseline )*100;
	 end;
run;
---------------------------------------------------------------------------
Program 4.15   Creating a Time to Seizure Event Data Set

**** INPUT SAMPLE SEIZURE DATA WHERE
**** SUBJECT = PATIENT NUMBER, SEIZURE = BOOLEAN FLAG 
**** INDICATING A SEIZURE AND SEIZDATE = DATE OF SEIZURE.;
data seizure;
informat seizdate date9.;
format seizdate date9.;
label subject  = "Patient Number"
      seizdate = "Date of Seizure"
      seizure  = "Seizure: 1=Yes,0=No";
input subject $ seizure seizdate; 
datalines;
101 1 05MAY2004
102 0 .
103 . .
104 1 07JUN2004
;
run;

**** INPUT SAMPLE END OF STUDY DATA WHERE
**** SUBJECT = PATIENT NUMBER, EOSDATE = END OF STUDY DATE.;
data eos;
informat eosdate date9.;
format eosdate date9.;
label subject  = "Patient Number"
      eosdate = "End of Study Date";
input subject $ eosdate; 
datalines;
101 05AUG2004
102 10AUG2004
103 12AUG2004
104 20AUG2004
;
run;

**** INPUT SAMPLE DOSING DATA WHERE
**** SUBJECT = PATIENT NUMBER AND DOSEDATE = DRUG DOSING DATE.;
data dosing;
informat dosedate date9.;
format dosedate date9.;
label subject  = "Patient Number"
      dosedate = "Start of Drug Therapy";
input subject $ dosedate; 
datalines;
101 01JAN2004
102 03JAN2004
103 06JAN2004
104 09JAN2004
;
run;
  
**** CREATE TIME TO SEIZURE DATA SET;
data time_to_seizure;
   merge dosing eos seizure;
      by subject;

      if seizure = 1 then
         time_to_seizure = seizdate - dosedate + 1;
      else if seizure = 0 then
         time_to_seizure = eosdate - dosedate + 1;
      else 
         time_to_seizure = .;

      label time_to_seizure = "Days to Seizure or Censor Day";
run;

proc print 
  label data = time_to_seizure; 
run;
---------------------------------------------------------------------------
Program 5.1	Using PROC TABULATE to Create a Summary of Demographics

**** INPUT SAMPLE DEMOGRAPHICS DATA;
data demog;
label subjid   = "Subject Number"
      trt      = "Treatment"
      gender   = "Gender"
      race     = "Race"
      age      = "Age";
input subjid trt gender race age @@;
datalines;
101 0 1 3 37  301 0 1 1 70  501 0 1 2 33  601 0 1 1 50  701 1 1 1 60
102 1 2 1 65  302 0 1 2 55  502 1 2 1 44  602 0 2 2 30  702 0 1 1 28
103 1 1 2 32  303 1 1 1 65  503 1 1 1 64  603 1 2 1 33  703 1 1 2 44
104 0 2 1 23  304 0 1 1 45  504 0 1 3 56  604 0 1 1 65  704 0 2 1 66
105 1 1 3 44  305 1 1 1 36  505 1 1 2 73  605 1 2 1 57  705 1 1 2 46
106 0 2 1 49  306 0 1 2 46  506 0 1 1 46  606 0 1 2 56  706 1 1 1 75
201 1 1 3 35  401 1 2 1 44  507 1 1 2 44  607 1 1 1 67  707 1 1 1 46
202 0 2 1 50  402 0 2 2 77  508 0 2 1 53  608 0 2 2 46  708 0 2 1 55
203 1 1 2 49  403 1 1 1 45  509 0 1 1 45  609 1 2 1 72  709 0 2 2 57
204 0 2 1 60  404 1 1 1 59  510 0 1 3 65  610 0 1 1 29  710 0 1 1 63
205 1 1 3 39  405 0 2 1 49  511 1 2 2 43  611 1 2 1 65  711 1 1 2 61
206 1 2 1 67  406 1 1 2 33  512 1 1 1 39  612 1 1 2 46  712 0 . 1 49
;
 
**** DEFINE VARIABLE FORMATS NEEDED FOR TABLE;
proc format;
   value trt
      1 = "Active"
      0 = "Placebo"; 
   value gender 
      1 = "Male"
      2 = "Female";
   value race
      1 = "White"
      2 = "Black"
      3 = "Other*";
run;

**** DEFINE OPTIONS FOR ASCII TEXT OUTPUT;
options nodate ls = 80 ps = 38 formchar = "|----|+|---+=|-/\<>*";

**** CREATE SUMMARY OF DEMOGRAPHICS WITH PROC TABULATE;
proc tabulate
   data = demog
   missing;

   class trt gender race;
   var age;
   table age = 'Age' * 
               (n = 'n' * f = 8. 
                mean = 'Mean' * f = 5.1 
                std = 'Standard Deviation' * f = 5.1
                min = 'Min' * f = 3. Max = 'Max' * f = 3.)
         gender = 'Gender' * 
               (n='n' * f = 3. colpctn = '%' * f = 4.1)
         race = 'Race' * 
               (n = 'n' * f = 3. colpctn = '%' * f = 4.1),
		
         (trt = "  ") (all = 'Overall');

   format trt trt. race race. gender gender.;

   title1 'Table 5.1';
   title2 'Demographics and Baseline Characteristics';
   footnote1 "* Other includes Asian, Native American, and other" 
             " races.";
   footnote2 "Created by %sysfunc(getoption(sysin)) on"  
             " &sysdate9..";  
run;
---------------------------------------------------------------------------
Program 5.2	Using PROC REPORT to Create a Summary of Demographics

**** INPUT SAMPLE DEMOGRAPHICS DATA;
data demog;
label subjid   = "Subject Number"
      trt      = "Treatment"
      gender   = "Gender"
      race     = "Race"
      age      = "Age";
input subjid trt gender race age @@;
datalines;
101 0 1 3 37  301 0 1 1 70  501 0 1 2 33  601 0 1 1 50  701 1 1 1 60
102 1 2 1 65  302 0 1 2 55  502 1 2 1 44  602 0 2 2 30  702 0 1 1 28
103 1 1 2 32  303 1 1 1 65  503 1 1 1 64  603 1 2 1 33  703 1 1 2 44
104 0 2 1 23  304 0 1 1 45  504 0 1 3 56  604 0 1 1 65  704 0 2 1 66
105 1 1 3 44  305 1 1 1 36  505 1 1 2 73  605 1 2 1 57  705 1 1 2 46
106 0 2 1 49  306 0 1 2 46  506 0 1 1 46  606 0 1 2 56  706 1 1 1 75
201 1 1 3 35  401 1 2 1 44  507 1 1 2 44  607 1 1 1 67  707 1 1 1 46
202 0 2 1 50  402 0 2 2 77  508 0 2 1 53  608 0 2 2 46  708 0 2 1 55
203 1 1 2 49  403 1 1 1 45  509 0 1 1 45  609 1 2 1 72  709 0 2 2 57
204 0 2 1 60  404 1 1 1 59  510 0 1 3 65  610 0 1 1 29  710 0 1 1 63
205 1 1 3 39  405 0 2 1 49  511 1 2 2 43  611 1 2 1 65  711 1 1 2 61
206 1 2 1 67  406 1 1 2 33  512 1 1 1 39  612 1 1 2 46  712 0 . 1 49
;

**** DEFINE VARIABLE FORMATS NEEDED FOR TABLE;
proc format;
      value trt
      1 = "-- Active --"
      0 = "-- Placebo --"; 
   value gender 
      1 = "Male"
      2 = "Female";
   value race
      1 = "White"
      2 = "Black"
      3 = "Other*";
run;

**** DEFINE OPTIONS FOR ASCII TEXT OUTPUT;
options nodate nocenter ls = 70 
        formchar = "|----|+|---+=|-/\<>*";

**** CREATE SUMMARY OF DEMOGRAPHICS WITH PROC TABULATE;
proc report
   data = demog
   nowindows
   missing 
   headline;

   column ('--' trt,
          ( ("-- Age --" 
             age = agen age = agemean age = agestd age = agemin
             age = agemax)
             gender,(gender = gendern genderpct) 
             race,(race = racen racepct)));       
                                                             
   define trt /across format = trt. "  ";                         
   define agen /analysis n format = 3. 'N';
   define agemean /analysis mean format = 5.3 'Mean';
   define agestd /analysis std format = 5.3 'SD';
   define agemin /analysis min format = 3. 'Min';
   define agemax /analysis max format = 3. 'Max';

   define gender /across "-- Gender --" format = gender.;         
   define gendern /analysis n format = 3. 'N';                    
   define genderpct /computed format = percent5. '(%)';           
   define race /across "-- Race --" format = race.;                    
   define racen /analysis n format = 3. width = 6 'N';                    
   define racepct /computed format = percent5. '(%)';           

   compute before;                                              
   totga = sum(_c6_,_c8_,_c10_);                                              
   totgp = sum(_c23_,_c25_,_c27_);                                              
   totra = sum(_c12_,_c14_,_c16_);                                              
   totrp = sum(_c29_,_c31_,_c33_);                                              
   endcomp;                                                     
   compute genderpct;                                           
   _c7_ = _c6_ / totga;                                              
   _c9_ = _c8_ / totga;                                              
   _c11_ = _c10_ / totga;                                              
   _c24_ = _c23_ / totgp;                                              
   _c26_ = _c25_ / totgp;                                              
   _c28_ = _c27_ / totgp;                                              
   endcomp;                   
   compute racepct;                                           
   _c13_ = _c12_ / totra;                                              
   _c15_ = _c14_ / totra;                                              
   _c17_ = _c16_ / totra;                                              
   _c30_ = _c29_ / totrp;                                              
   _c32_ = _c31_ / totrp;                                              
   _c34_ = _c33_ / totrp;                                              
   endcomp;        

   title1 'Table 5.2';
   title2 'Demographics and Baseline Characteristics';
   footnote1 "Created by %sysfunc(getoption(sysin))"
             " on &sysdate9..";  
run;     
---------------------------------------------------------------------------
Program 5.3	Creating a Typical Summary of Demographics

**** INPUT SAMPLE DEMOGRAPHICS DATA.;
data demog;
label subjid   = "Subject Number"
      trt      = "Treatment"
      gender   = "Gender"
      race     = "Race"
      age      = "Age";
input subjid trt gender race age @@;
datalines;
101 0 1 3 37  301 0 1 1 70  501 0 1 2 33  601 0 1 1 50  701 1 1 1 60
102 1 2 1 65  302 0 1 2 55  502 1 2 1 44  602 0 2 2 30  702 0 1 1 28
103 1 1 2 32  303 1 1 1 65  503 1 1 1 64  603 1 2 1 33  703 1 1 2 44
104 0 2 1 23  304 0 1 1 45  504 0 1 3 56  604 0 1 1 65  704 0 2 1 66
105 1 1 3 44  305 1 1 1 36  505 1 1 2 73  605 1 2 1 57  705 1 1 2 46
106 0 2 1 49  306 0 1 2 46  506 0 1 1 46  606 0 1 2 56  706 1 1 1 75
201 1 1 3 35  401 1 2 1 44  507 1 1 2 44  607 1 1 1 67  707 1 1 1 46
202 0 2 1 50  402 0 2 2 77  508 0 2 1 53  608 0 2 2 46  708 0 2 1 55
203 1 1 2 49  403 1 1 1 45  509 0 1 1 45  609 1 2 1 72  709 0 2 2 57
204 0 2 1 60  404 1 1 1 59  510 0 1 3 65  610 0 1 1 29  710 0 1 1 63
205 1 1 3 39  405 0 2 1 49  511 1 2 2 43  611 1 2 1 65  711 1 1 2 61
206 1 2 1 67  406 1 1 2 33  512 1 1 1 39  612 1 1 2 46  712 0 . 1 49
;
run; 

**** CREATE FORMATS NEEDED FOR TABLE ROWS.; 
proc format;
   value gender 
      1 = "Male"
      2 = "Female";
   value race
      1 = "White"
      2 = "Black"
      3 = "Other*";
run; 


**** DUPLICATE THE INCOMING DATA SET FOR OVERALL COLUMN 
**** CALCULATIONS SO NOW TRT HAS VALUES 0 = PLACEBO, 1 = ACTIVE,
**** AND 2 = OVERALL.;
data demog;
   set demog;
   output;
   trt = 2;
   output;
run;


**** AGE STATISTICS PROGRAMMING ********************************;
**** GET P VALUE FROM NON PARAMETRIC COMPARISON OF AGE MEANS.;
proc npar1way 
   data = demog
   wilcoxon 
   noprint;
      where trt in (0,1);
      class trt;
      var age;
      output out = pvalue wilcoxon;
run;

proc sort 
   data = demog;
      by trt;
run;
 
***** GET AGE DESCRIPTIVE STATISTICS N, MEAN, STD, MIN, AND MAX.;
proc univariate 
   data = demog noprint;
      by trt;

      var age;
      output out = age 
             n = _n mean = _mean std = _std min = _min 
             max = _max;
run;

**** FORMAT AGE DESCRIPTIVE STATISTICS FOR THE TABLE.;
data age;
   set age;

   format n mean sd min max $14.;
   drop _n _mean _std _min _max;

   n = put(_n,3.);
   mean = put(_mean,7.1);
   std = put(_std,8.2);
   min = put(_min,7.1);
   max = put(_max,7.1);
run;

**** TRANSPOSE AGE DESCRIPTIVE STATISTICS INTO COLUMNS.;
proc transpose 
   data = age 
   out = age 
   prefix = col;
      var n mean std min max;
      id trt;
run; 
 
**** CREATE AGE FIRST ROW FOR THE TABLE.;
data label;
   set pvalue(keep = p2_wil rename = (p2_wil = pvalue));
   length label $ 85;
   label = "Age (years)";
run;
 
**** APPEND AGE DESCRIPTIVE STATISTICS TO AGE P VALUE ROW AND 
**** CREATE AGE DESCRIPTIVE STATISTIC ROW LABELS.; 
data age;
   length label $ 85 col0 col1 col2 $ 25 ;
   set label age;

   keep label col0 col1 col2 pvalue ;
   if _n_ > 1 then 
      select;
         when(_NAME_ = 'n')    label = "     N";
         when(_NAME_ = 'mean') label = "     Mean";
         when(_NAME_ = 'std')  label = "     Standard Deviation";
         when(_NAME_ = 'min')  label = "     Minimum";
         when(_NAME_ = 'max')  label = "     Maximum";
         otherwise;
      end;
run;
**** END OF AGE STATISTICS PROGRAMMING *************************;

 
**** GENDER STATISTICS PROGRAMMING *****************************;
**** GET SIMPLE FREQUENCY COUNTS FOR GENDER.;
proc freq 
   data = demog 
   noprint;
      where trt ne .; 
      tables trt * gender / missing outpct out = gender;
run;
 
**** FORMAT GENDER N(%) AS DESIRED.;
data gender;
   set gender;
      where gender ne .;
      length value $25;
      value = put(count,4.) || ' (' || put(pct_row,5.1)||'%)';
run;

proc sort
   data = gender;
      by gender;
run;
 
**** TRANSPOSE THE GENDER SUMMARY STATISTICS.;
proc transpose 
   data = gender 
   out = gender(drop = _name_) 
   prefix = col;
      by gender;
      var value;
      id trt;
run;
 
**** PERFORM CHI-SQUARE ON GENDER COMPARING ACTIVE VS PLACEBO.;
proc freq 
   data = demog 
   noprint;
      where gender ne . and trt not in (.,2);
      table gender * trt / chisq;
      output out = pvalue pchi;
run;

**** CREATE GENDER FIRST ROW FOR THE TABLE.;
data label;
   set pvalue(keep = p_pchi rename = (p_pchi = pvalue));
   length label $ 85;
   label = "Gender";
run;

**** APPEND GENDER DESCRIPTIVE STATISTICS TO GENDER P VALUE ROW
**** AND CREATE GENDER DESCRIPTIVE STATISTIC ROW LABELS.; 
data gender;
   length label $ 85 col0 col1 col2 $ 25 ;
   set label gender;

   keep label col0 col1 col2 pvalue ;
   if _n_ > 1 then 
        label= "     " || put(gender,gender.);
run;
**** END OF GENDER STATISTICS PROGRAMMING **********************;

 
**** RACE STATISTICS PROGRAMMING *******************************;
**** GET SIMPLE FREQUENCY COUNTS FOR RACE;
proc freq 
   data = demog 
   noprint;
      where trt ne .; 
      tables trt * race / missing outpct out = race;
run;
 
**** FORMAT RACE N(%) AS DESIRED;
data race;
   set race;
      where race ne .;
      length value $25;
      value = put(count,4.) || ' (' || put(pct_row,5.1)||'%)';
run;

proc sort
   data = race;
      by race;
run;
 
**** TRANSPOSE THE RACE SUMMARY STATISTICS;
proc transpose 
   data = race 
   out = race(drop = _name_) 
   prefix=col;
      by race;
      var value;
      id trt;
run;
 
**** PERFORM FISHER'S EXACT ON RACE COMPARING ACTIVE VS PLACEBO.;
proc freq 
   data = demog 
   noprint;
      where race ne . and trt not in (.,2);
      table race * trt / exact;
      output out = pvalue exact;
run;
 
**** CREATE RACE FIRST ROW FOR THE TABLE.;
data label;
   set pvalue(keep = xp2_fish rename = (xp2_fish = pvalue));
   length label $ 85;
   label = "Race";
run;

**** APPEND RACE DESCRIPTIVE STATISTICS TO RACE P VALUE ROW AND 
**** CREATE RACE DESCRIPTIVE STATISTIC ROW LABELS.; 
data race;
   length label $ 85 col0 col1 col2 $ 25 ;
   set label race;

   keep label col0 col1 col2 pvalue ;
   if _n_ > 1 then 
        label= "     " || put(race,race.);
run;
**** END OF RACE STATISTICS PROGRAMMING ************************;


**** CONCATENATE AGE, GENDER, AND RACE STATISTICS AND CREATE
**** GROUPING GROUP VARIABLE FOR LINE SKIPPING IN PROC REPORT.;
data forreport;
   set age(in = in1)
       gender(in = in2)
       race(in = in3);

       group = sum(in1 * 1, in2 * 2, in3 * 3);
run;


**** DEFINE THREE MACRO VARIABLES &N0, &N1, AND &NT THAT ARE USED 
**** IN THE COLUMN HEADERS FOR "PLACEBO," "ACTIVE" AND "OVERALL" 
**** THERAPY GROUPS.;
data _null_;
   set demog end = eof;

   **** CREATE COUNTER FOR N0 = PLACEBO, N1 = ACTIVE.;
   if trt = 0 then
      n0 + 1;
   else if trt = 1 then
      n1 + 1;

   **** CREATE OVERALL COUNTER NT.; 
   nt + 1;
  
   **** CREATE MACRO VARIABLES &N0, &N1, AND &NT.;
   if eof then
      do;     
         call symput("n0",compress('(N='||put(n0,4.) || ')'));
         call symput("n1",compress('(N='||put(n1,4.) || ')'));
         call symput("nt",compress('(N='||put(nt,4.) || ')'));
      end;
run;


**** USE PROC REPORT TO WRITE THE TABLE TO FILE.; 
options nonumber nodate ls=84 missing = " "
        formchar="|----|+|---+=|-/\<>*";

proc report
   data = forreport
   nowindows
   spacing=1
   headline
   headskip
   split = "|";

   columns ("--" group label col1 col0 col2 pvalue);

   define group   /order order = internal noprint;
   define label   /display width=23 " ";
   define col0    /display center width = 14 "Placebo|&n0";
   define col1    /display center width = 14 "Active|&n1";
   define col2    /display center width = 14 "Overall|&nt";
   define pvalue  /display center width = 14 " |P-value**" 
                   f = pvalue6.4;

   break after group / skip;

   title1 "Company                                              "
          "                              ";
   title2 "Protocol Name                                        "
          "                              ";
   title3 "Table 5.3";
   title4 "Demographics";
 
   footnote1 "------------------------------------------"
             "-----------------------------------------";
   footnote2 "*  Other includes Asian, Native Amerian, and other"
             " races.                          ";
   footnote3 "** P-values:  Age = Wilcoxon rank-sum, Gender "  
             "= Pearson's chi-square,              ";
   footnote4 "              Race = Fisher's exact test. "
             "                                         ";
   footnote5 "Created by %sysfunc(getoption(sysin)) on" 
             " &sysdate9..";  
run;
---------------------------------------------------------------------------
Program 5.4	 Summary of Adverse Events by Maximum Severity

**** INPUT SAMPLE TREATMENT DATA.;
data treat;
label subjid      = "Subject Number"
      trtcd       = "Treatment";      
input subjid trtcd @@;
datalines;
101 1  102 0  103 0  104 1  105 0  106 0  107 1  108 1  109 0  110 1
111 0  112 0  113 0  114 1  115 0  116 1  117 0  118 1  119 1  120 1
121 1  122 0  123 1  124 0  125 1  126 1  127 0  128 1  129 1  130 1
131 1  132 0  133 1  134 0  135 1  136 1  137 0  138 1  139 1  140 1
141 1  142 0  143 1  144 0  145 1  146 1  147 0  148 1  149 1  150 1
151 1  152 0  153 1  154 0  155 1  156 1  157 0  158 1  159 1  160 1
161 1  162 0  163 1  164 0  165 1  166 1  167 0  168 1  169 1  170 1
;
run;

**** INPUT SAMPLE ADVERSE EVENT DATA.;
data ae;
label subjid   = "Subject Number"
      aebodsys = "Body System of Event"
      aedecod  = "Preferred Term for Event"
      aerel    = "Relatedness: 1=not,2=possibly,3=probably"
      aesev    = "Severity/Intensity:1=mild,2=moderate,3=severe";      
input subjid 1-3 aerel 5 aesev 7 
      aebodsys $ 9-34 aedecod $ 38-62;
datalines;
101 1 1 Cardiac disorders            Atrial flutter
101 2 1 Gastrointestinal disorders   Constipation
102 2 2 Cardiac disorders            Cardiac failure
102 1 1 Psychiatric disorders        Delirium
103 1 1 Cardiac disorders            Palpitations
103 1 2 Cardiac disorders            Palpitations
103 2 2 Cardiac disorders            Tachycardia
115 3 2 Gastrointestinal disorders   Abdominal pain
115 3 1 Gastrointestinal disorders   Anal ulcer
116 2 1 Gastrointestinal disorders   Constipation
117 2 2 Gastrointestinal disorders   Dyspepsia
118 3 3 Gastrointestinal disorders   Flatulence
119 1 3 Gastrointestinal disorders   Hiatus hernia
130 1 1 Nervous system disorders     Convulsion
131 2 2 Nervous system disorders     Dizziness
132 1 1 Nervous system disorders     Essential tremor
135 1 3 Psychiatric disorders        Confusional state
140 1 1 Psychiatric disorders        Delirium
140 2 1 Psychiatric disorders        Sleep disorder
141 1 3 Cardiac disorders            Palpitations
;
run;

**** CREATE FORMAT FOR AE SEVERITY.;
proc format;
   value aesev
      1 = "Mild"
      2 = "Moderate"
      3 = "Severe";
run; 


**** PERFORM A SIMPLE COUNT OF EACH TREATMENT ARM AND OUTPUT.
**** RESULT AS MACRO VARIABLES.  N1 = 1ST COLUMN N FOR ACTIVE 
**** THERAPY, N2 = 2ND COLUMN N FOR PLACEBO, N3 REPRESENTS THE
**** 3RD COLUMN TOTAL N.;
data _null_;
   set treat end = eof;

   **** INCREMENT (AND RETAIN) EACH TREATMENT COUNTER.;
   if trtcd = 1 then
      n1 + 1;
   else if trtcd = 0 then
      n2 + 1;

   **** INCREMENT (AND RETAIN) TOTAL COUNTER.;
   n3 + 1;
  
   **** AT THE END OF THE FILE, CREATE &N1, &N2, AND &N3.; 
   if eof then
      do;     
         call symput("n1", put(n1,4.));
         call symput("n2", put(n2,4.));
         call symput("n3", put(n3,4.));
      end;
run;

proc sort
   data = ae;
      by subjid;
run;

proc sort
   data = treat;
      by subjid;
run;

***** MERGE ADVERSE EVENT AND DEMOGRAPHICS DATA;
data ae;
   merge treat(in = intreat) ae(in = inae);
      by subjid;

      if intreat and inae;
run;


**** CALCULATE ANY EVENT LEVEL COUNTS.  THIS IS THE FIRST ROW IN
**** THE SUMMARY.;
data anyevent;
   set ae end = eof;
      by subjid;

      keep rowlabel count1 count2 count3;

	   **** KEEP ONLY LAST RECORD PER SUBJECT AS WE ONLY WANT TO 
	   **** COUNT A PATIENT ONCE IF THEY HAD ANY ADVERSE EVENTS.;
      if last.subjid;

      **** INCREMENT (AND RETAIN) EACH AE COUNT.;
      if trtcd = 1 then
         count1 + 1;
      else if trtcd = 0 then
         count2 + 1;

      **** INCREMENT (AND RETAIN) TOTAL AE COUNT.;
      count3 + 1;
        
	   **** KEEP LAST RECORD OF THE FILE WITH TOTALS.; 
      if eof;
    
      **** CREATE ROW LABEL FOR REPORT.;
      length rowlabel $ 30;
      rowlabel = "Any Event";
run;


**** CALCULATE ANY EVENT BY MAXIMUM SEVERITY LEVEL COUNTS.  THIS
**** IS THE BY SEVERITY BREAKDOWN UNDER THE FIRST ROW OF THE
**** SUMMARY.;
proc sort
   data = ae
   out = bysev;
      by subjid aesev;
run;

**** KEEP ONLY LAST RECORD PER SUBJECT AT HIGHEST SEVERITY AS WE 
**** ONLY WANT TO COUNT A PATIENT ONCE AT MAX SEVERITY IF THEY 
**** HAD ANY ADVERSE EVENTS.;
data bysev;
   set bysev;
      by subjid aesev;
      
      if last.subjid;
run;

proc sort
   data = bysev;
      by aesev;
run;

data bysev;
   set bysev end = eof;
      by aesev;

      keep rowlabel count1 count2 count3;

      **** INITIALIZE AE COUNTERS TO ZERO AT EACH SEVERITY LEVEL.;
      if first.aesev then
         do;
            count1 = 0;
            count2 = 0;
            count3 = 0;
         end;
        
      **** INCREMENT (AND RETAIN) EACH AE COUNT.;
      if trtcd = 1 then
         count1 + 1;
      else if trtcd = 0 then
         count2 + 1;

      **** INCREMENT (AND RETAIN) TOTAL COUNT.;
      count3 + 1;
       
      **** KEEP LAST RECORD WITHIN EACH SEVERITY LEVEL.;
      if last.aesev;

      **** CREATE ROW LABEL FOR REPORT.;
      length rowlabel $ 30;
      rowlabel = "      " || put(aesev, aesev.);
run;


**** CALCULATE BODY SYSTEM BY MAXIMUM SEVERITY LEVEL COUNTS.  
**** THIS IS THE BY SEVERITY BREAKDOWN UNDER THE BODY SYSTEMS OF
**** THE SUMMARY.;
proc sort
   data = ae
   out = bysys_sev;
      by subjid aebodsys aesev;
run;

**** KEEP ONLY LAST RECORD PER SUBJECT PER BODY SYSTEM AT HIGHEST 
**** SEVERITY AS WE ONLY WANT TO COUNT A PATIENT ONCE AT MAX 
**** SEVERITY WITHIN A BODY SYSTEM.;
data bysys_sev;
   set bysys_sev;
      by subjid aebodsys aesev;
       
      if last.aebodsys;
run;

proc sort
   data = bysys_sev;
      by aebodsys aesev;
run;

data bysys_sev;
   set bysys_sev;
      by aebodsys aesev;

      keep aebodsys rowlabel count1 count2 count3;

      **** INITIALIZE COUNTERS TO ZERO AT EACH SEVERITY LEVEL.;
      if first.aesev then
         do;
            count1 = 0;
            count2 = 0;
            count3 = 0;
         end;
        
      **** INCREMENT (AND RETAIN) EACH AE COUNT.;
      if trtcd = 1 then
         count1 + 1;
      else if trtcd = 0 then
         count2 + 1;

      **** INCREMENT (AND RETAIN) TOTAL COUNT.;
      count3 + 1;
        
      **** KEEP LAST RECORD FOR EACH BODY SYSTEM SEVERITY LEVEL.;
      if last.aesev;

      **** CREATE ROW LABEL FOR REPORT.;
      length rowlabel $ 30;
      rowlabel = "      " || put(aesev, aesev.);
run;



**** CALCULATE BODY SYSTEM LEVEL AE COUNTS.  THIS IS DONE BY 
**** ADDING UP THE BODY SYSTEM BY SEVERITY COUNTS.;
data bysys;
   set bysys_sev(rename = (count1 = _count1 
                           count2 = _count2 
                           count3 = _count3));
      by aebodsys;

      keep aebodsys rowlabel count1 count2 count3;

      **** INITIALIZE COUNTERS TO ZERO AT EACH NEW BODY SYSTEM.;
      if first.aebodsys then
         do;
            count1 = 0;
            count2 = 0;
            count3 = 0;
         end;
        
      **** INCREMENT (AND RETAIN) EACH AE COUNT.;
      count1 + _count1;
      count2 + _count2;
      count3 + _count3;
 
      **** KEEP LAST RECORD WITHIN EACH BODY SYSTEM.;
      if last.aebodsys;

      **** CREATE ROW LABEL FOR REPORT.;
      length rowlabel $ 30;
      rowlabel = aebodsys;
run;


**** INTERLEAVE OVERALL BODY SYSTEM COUNTS WITH BY SEVERITY
**** COUNTS.;
data bysys;
   set bysys bysys_sev;
      by aebodsys;
run;


**** CALCULATE PREFERRED TERM BY MAXIMUM SEVERITY LEVEL COUNTS.  
**** THIS IS THE BY SEVERITY BREAKDOWN UNDER THE PREFERRED TERMS 
**** IN THE SUMMARY.;
proc sort
   data = ae
   out = byterm_sev;
      by subjid aebodsys aedecod aesev;
run;

**** KEEP ONLY LAST RECORD PER SUBJECT PER BODY SYSTEM PER 
**** ADVERSE EVENT AT HIGHEST SEVERITY AS WE ONLY WANT TO COUNT A 
**** PATIENT ONCE AT MAX SEVERITY WITHIN A PREFERRED TERM.;
data byterm_sev;
   set byterm_sev;
      by subjid aebodsys aedecod aesev;
  
      if last.aedecod;
run;

proc sort
   data = byterm_sev;
      by aebodsys aedecod aesev;
run;

data byterm_sev;
   set byterm_sev;
      by aebodsys aedecod aesev;

      keep aebodsys aedecod rowlabel count1 count2 count3;

      **** INITIALIZE COUNTERS TO ZERO AT EACH SEVERITY LEVEL.;
      if first.aesev then
         do;
            count1 = 0;
            count2 = 0;
            count3 = 0;
         end;
        
      **** INCREMENT (AND RETAIN) EACH AE COUNT.;
      if trtcd = 1 then
         count1 + 1;
      else if trtcd = 0 then
         count2 + 1;

      **** INCREMENT (AND RETAIN) TOTAL COUNT.;
      count3 + 1;
        
      **** KEEP LAST RECORD FOR EACH PREF. TERM SEVERITY LEVEL.;
      if last.aesev;

      **** CREATE ROW LABEL FOR REPORT.;
      length rowlabel $ 30;
      rowlabel = "      " || put(aesev, aesev.) ;
run;

**** CALCULATE PREFERRED TERM LEVEL AE COUNTS.  THIS IS DONE BY 
**** ADDING UP THE PREFERRED TERM BY SEVERITY COUNTS.;
data byterm;
   set byterm_sev(rename = (count1 = _count1 
                            count2 = _count2 
                            count3 = _count3));
      by aebodsys aedecod;

      keep aebodsys aedecod rowlabel count1 count2 count3;

      **** INITIALIZE COUNTERS TO ZERO AT EACH NEW PREF. TERM.;
      if first.aedecod then
         do;
            count1 = 0;
            count2 = 0;
            count3 = 0;
         end;
        
      **** INCREMENT (AND RETAIN) EACH AE COUNT.;
      count1 + _count1;
      count2 + _count2;
      count3 + _count3;
        
      **** KEEP LAST RECORD WITHIN EACH PREFERRED TERM.;
      if last.aedecod;
    
      **** CREATE ROW LABEL FOR REPORT.;
      length rowlabel $ 30;
      rowlabel = "   " || aedecod ;
run;

**** INTERLEAVE PREFERRED TERM COUNTS WITH BY SEVERITY COUNTS.; 
data byterm;
   set byterm byterm_sev;
      by aebodsys aedecod;
run;


**** INTERLEAVE BODY SYSTEM COUNTS WITH PREFERRED TERM COUNTS.; 
data bysys_byterm;
   set bysys byterm;
      by aebodsys;
run;
 

**** SET ALL INTERMEDIATE DATA SETS TOGETHER AND CALCULATE 
**** PERCENTAGES.;
data all;
   set anyevent
       bysev 
       bysys_byterm;

      length col1 col2 col3 $ 10;

      **** CALCULATE %S AND CREATE N/% TEXT IN COL1-COL3.;
      if rowlabel ne '' then
         do;
            pct1 = (count1 / &n1) * 100;
            pct2 = (count2 / &n2) * 100;
            pct3 = (count3 / &n3) * 100;
           
            col1 = put(count1,3.) || " (" || put(pct1,3.) || "%)";
            col2 = put(count2,3.) || " (" || put(pct2,3.) || "%)";
            col3 = put(count3,3.) || " (" || put(pct3,3.) || "%)";
         end;

      **** CREATE SYSTEM_AND_TERM USED AS AN INDEX FOR INSERTING
      **** BLANK LINES AND PAGE BREAKS IN THE DATA _NULL_ BELOW.;
      length system_and_term $ 200;
      system_and_term = aebodsys || aedecod;
run;


**** WRITE AE SUMMARY TO FILE USING DATA _NULL_.;
options nodate nonumber;
title1 "Table 5.4";
title2 "Summary of Adverse Events";
title3 "By Body System, Preferred Term, and Greatest Severity";
 
data _null_;
   set all(sortedby = aebodsys system_and_term) end = eof;
      by aebodsys system_and_term;

      **** SET UP OUTPUT FILE OPTIONS.;
      file print titles linesleft = ll pagesize = 40 linesize = 70;

      **** DEFINE A NEW PAGE FLAG.  IF 1, THEN INSERT PAGE BREAK.;
      retain newpage 0;
 
      **** PRINT OUTPUT PAGE HEADER.;
      if _n_ = 1 or newpage = 1 then
         do;
            put @1 "--------------------------------"
                   "--------------------------------------" /
                @1 "Body System" /
                @4 "Preferred Term" @33 "Active" @47 "Placebo" 
                   @62 "Overall" /
                @7 "Severity" @33 "N=&n1" @48 "N=&n2" @63 "N=&n3" /
                @1 "--------------------------------"
                   "--------------------------------------" ;
            **** IF A BODY SYSTEM SPANS PAGES, REPEAT THE
            **** BODY SYSTEM WITH A CONTINUED INDICATOR.;
            if not first.aebodsys then
               put @1 aebodsys " (Continued)";
         end;

      **** PUT AE COUNTS AND PERCENTAGES ON THE PAGE.;
      put @1 rowlabel $40. @30 col1 $10. @45 col2 $10. 
          @60 col3 $10.;
        
      **** RESET NEW PAGE FLAG.;
      newpage = 0;

      **** IF AT THE END OF THE PAGE, PUT A DOUBLE UNDERLINE.
      **** OTHERWISE IF AT THE END OF A PREFERRED TERM AND NEAR THE
      **** BOTTOM OF THE PAGE (LL <= 6) THEN PUT A PAGE BREAK. 
      **** OTHERWISE IF AT THE END OF A PREFERRED TERM PUT A BLANK  
      **** LINE.;
      if eof then
         put @1 "--------------------------------"
                "--------------------------------------" /
             @1 "--------------------------------"
                "--------------------------------------";
      else if last.system_and_term and ll <= 6 then
         do;
            put @1 "--------------------------------"
                   "--------------------------------------" /
                @60 "(CONTINUED)";
            put _page_;
            newpage = 1;
         end;
      else if last.system_and_term then
         put;
run;
---------------------------------------------------------------------------
Program 5.5	 Summary of Concomitant Medications

**** INPUT SAMPLE TREATMENT DATA.;
data treat;
label subjid      = "Subject Number"
      trtcd       = "Treatment";      
input subjid trtcd @@;
datalines;
101 1  102 0  103 0  104 1  105 0  106 0  107 1  108 1  109 0  110 1
111 0  112 0  113 0  114 1  115 0  116 1  117 0  118 1  119 1  120 1
121 1  122 0  123 1  124 0  125 1  126 1  127 0  128 1  129 1  130 1
131 1  132 0  133 1  134 0  135 1  136 1  137 0  138 1  139 1  140 1
141 1  142 0  143 1  144 0  145 1  146 1  147 0  148 1  149 1  150 1
151 1  152 0  153 1  154 0  155 1  156 1  157 0  158 1  159 1  160 1
161 1  162 0  163 1  164 0  165 1  166 1  167 0  168 1  169 1  170 1
;

**** INPUT SAMPLE CONCOMITANT MEDICATION DATA.;
data cm;
label subjid      = "Subject Number"
      cmdecod     = "Standardized Medication Name";      
input subjid 1-3 cmdecod $ 5-27;
datalines;
101 ACETYLSALICYLIC ACID   
101 HYDROCORTISONE         
102 VICODIN                
102 POTASSIUM              
102 IBUPROFEN              
103 MAGNESIUM SULFATE      
103 RINGER-LACTATE SOLUTION
115 LORAZEPAM              
115 SODIUM BICARBONATE     
116 POTASSIUM              
117 MULTIVITAMIN           
117 IBUPROFEN              
119 IRON                   
130 FOLIC ACID             
131 GABAPENTIN             
132 DIPHENHYDRAMINE        
135 SALMETEROL             
140 HEPARIN                
140 HEPARIN                
140 NICOTINE               
141 HYDROCORTISONE         
141 IBUPROFEN      
;


**** PERFORM A SIMPLE COUNT OF EACH TREATMENT ARM AND OUTPUT RESULT
**** AS MACRO VARIABLES.  N1 = 1ST COLUMN N FOR ACTIVE THERAPY,
**** N2 = 2ND COLUMN N FOR PLACEBO, N3 REPRESENTS THE 3RD COLUMN
**** TOTAL N.;
proc sql
   noprint;

   **** PLACE THE NUMBER OF ACTIVE SUBJECTS IN &N1.;
   select count(distinct subjid) format = 3.
      into :n1 
      from treat
      where trtcd = 1;
   **** PLACE THE NUMBER OF PLACEBO SUBJECTS IN &N2.;
   select count(distinct subjid) format = 3.
      into :n2 
      from treat
      where trtcd = 0;
   **** PLACE THE TOTAL NUMBER OF SUBJECTS IN &N3.;
   select count(distinct subjid) format = 3.
      into :n3 
      from treat
      where trtcd ne .;
quit;

***** MERGE CCONCOMITANT MEDICATIONS AND TREATMENT DATA.
***** KEEP RECORDS FOR SUBJECTS WHO HAD CONMEDS AND TOOK STUDY 
***** THERAPY.  GET UNIQUE CONCOMITANT MEDICATIONS WITHIN PATIENTS.;
proc sql
   noprint;
   create table cmtosum as
      select unique(c.cmdecod) as cmdecod, c.subjid, t.trtcd
         from cm as c, treat as t
         where c.subjid = t.subjid
         order by subjid, cmdecod;
quit;

**** TURN OFF LST OUTPUT.;
ods listing close;       

**** GET MEDICATION COUNTS BY TREATMENT AND PLACE IN DATA SET 
**** COUNTS.;
ods output CrossTabFreqs = counts; 
proc freq
   data = cmtosum;
      tables trtcd * cmdecod;
run;
ods output close;
ods listing;

proc sort
   data = counts;
      by cmdecod;
run;

**** MERGE COUNTS DATA SET WITH ITSELF TO PUT THE THREE 
**** TREATMENT COLUMNS SIDE BY SIDE FOR EACH CONMED.  CREATE GROUP
**** VARIABLE, WHICH ARE USED TO CREATE BREAK LINE IN THE REPORT. 
**** DEFINE COL1-COL3 WHICH ARE THE COUNT/% FORMATTED COLUMNS.;
data cm;
   merge counts(where = (trtcd = 1) rename = (frequency = count1))
         counts(where = (trtcd = 0) rename = (frequency = count2))
         counts(where = (trtcd = .) rename = (frequency = count3))
         end = eof;
      by cmdecod;

      keep cmdecod rowlabel col1-col3 group lastrec;
      length rowlabel $ 25 col1-col3 $ 10;

      **** LABEL "ANY MEDICATION" ROW AND PUT IN FIRST GROUP.
      **** BY MEDICATION COUNTS GO IN THE SECOND GROUP.;
      if cmdecod = '' then
         do;
	    rowlabel = "ANY MEDICATION";	
	    group = 1;
         end;
      else 
	 do;
            rowlabel = cmdecod;
	    group = 2;
         end;

      **** CALCULATE PERCENTAGES AND CREATE N/% TEXT IN COL1-COL3.;
      pct1 = (count1 / &n1) * 100;
      pct2 = (count2 / &n2) * 100;
      pct3 = (count3 / &n3) * 100;
           
      col1 = put(count1,3.) || " (" || put(pct1, 3.) || "%)";
      col2 = put(count2,3.) || " (" || put(pct2, 3.) || "%)";
      col3 = put(count3,3.) || " (" || put(pct3, 3.) || "%)";

     **** CREATE LASTERC FLAG AT THE END OF THE DATA SET FOR A 
     **** SPECIAL END OF REPORT LINE IN PROC REPORT.;
     lastrec = eof;
run;


**** WRITE SUMMARY STATISTICS TO FILE USING PROC REPORT.; 
options  nonumber nodate;
options formchar = "|----|+|---+=|-/\<>*";
 
proc report
   data = cm
   nowindows
   spacing = 1
   headline
   ls = 80 ps = 20
   split = "|";

   columns ("--" lastrec group rowlabel col1 col2 col3);

   define lastrec  /display noprint;
   define group    /order noprint;
   define rowlabel /order width = 25 "Preferred Medication Term";
   define col1     /display center width = 14 "Active|N=&n1";
   define col2     /display center width = 14 "Placebo|N=&n2";
   define col3     /display center width = 14 "Total|N=&n3";
 
   break after group / skip;

   compute after _page_ / left;
   if not lastrec then 
      contline = "(Continued)"; 
   else 
      contline = "-----------"; 

   line @6 "-----------------------------"
           "------------------------------" contline $11.;
   endcomp;

title1 "Table 5.5";
title2 "Summary of Concomitant Medication";
footnote1 "Created by %sysfunc(getoption(sysin)) on &sysdate9..";  
run;
---------------------------------------------------------------------------
Program 5.6	 Laboratory Shift Table

**** INPUT SAMPLE TREATMENT DATA;
data treat;
label subjid      = "Subject Number"
      trtcd       = "Treatment";      
input subjid trtcd @@;
datalines;
101 1  102 0  103 0  104 1  105 0  106 0  107 1  108 1  109 1  110 1
;

**** INPUT SAMPLE LABORATORY DATA;
data lb;
label subjid      = "Subject Number"
      week        = "Week Number"
      lbcat       = "Category for Lab Test"
      lbtest      = "Laboratory Test"
      lbstresu    = "Standard Units"
      lbstresn    = "Numeric Result/Finding in Std Units"
      lbstnrlo    = "Normal Range Lower Limit in Std Units"
      lbstnrhi    = "Normal Range Upper Limit in Std Units"
      lbnrind     = "Reference Range Indicator";

input subjid 1-3 week 6 lbcat $ 9-18 lbtest $ 20-29
      lbstresu $ 32-35 lbstresn 38-41 lbstnrlo 45-48 
      lbstnrhi 52-55 lbnrind $ 59;
datalines;
101  0  HEMATOLOGY HEMATOCRIT  %     31     35     49     L
101  1  HEMATOLOGY HEMATOCRIT  %     39     35     49     N
101  2  HEMATOLOGY HEMATOCRIT  %     44     35     49     N
101  0  HEMATOLOGY HEMOGLOBIN  g/dL  11.5   11.7   15.9   L
101  1  HEMATOLOGY HEMOGLOBIN  g/dL  13.2   11.7   15.9   N
101  2  HEMATOLOGY HEMOGLOBIN  g/dL  14.3   11.7   15.9   N
102  0  HEMATOLOGY HEMATOCRIT  %     39     39     52     N
102  1  HEMATOLOGY HEMATOCRIT  %     39     39     52     N
102  2  HEMATOLOGY HEMATOCRIT  %     44     39     52     N
102  0  HEMATOLOGY HEMOGLOBIN  g/dL  11.5   12.7   17.2   L
102  1  HEMATOLOGY HEMOGLOBIN  g/dL  13.2   12.7   17.2   N
102  2  HEMATOLOGY HEMOGLOBIN  g/dL  18.3   12.7   17.2   H
103  0  HEMATOLOGY HEMATOCRIT  %     50     35     49     H
103  1  HEMATOLOGY HEMATOCRIT  %     39     35     49     N
103  2  HEMATOLOGY HEMATOCRIT  %     55     35     49     H
103  0  HEMATOLOGY HEMOGLOBIN  g/dL  12.5   11.7   15.9   N
103  1  HEMATOLOGY HEMOGLOBIN  g/dL  12.2   11.7   15.9   N
103  2  HEMATOLOGY HEMOGLOBIN  g/dL  14.3   11.7   15.9   N
104  0  HEMATOLOGY HEMATOCRIT  %     55     39     52     H
104  1  HEMATOLOGY HEMATOCRIT  %     45     39     52     N
104  2  HEMATOLOGY HEMATOCRIT  %     44     39     52     N
104  0  HEMATOLOGY HEMOGLOBIN  g/dL  13.0   12.7   17.2   N
104  1  HEMATOLOGY HEMOGLOBIN  g/dL  13.3   12.7   17.2   N
104  2  HEMATOLOGY HEMOGLOBIN  g/dL  12.8   12.7   17.2   N
105  0  HEMATOLOGY HEMATOCRIT  %     36     35     49     N
105  1  HEMATOLOGY HEMATOCRIT  %     39     35     49     N
105  2  HEMATOLOGY HEMATOCRIT  %     39     35     49     N
105  0  HEMATOLOGY HEMOGLOBIN  g/dL  13.1   11.7   15.9   N
105  1  HEMATOLOGY HEMOGLOBIN  g/dL  14.0   11.7   15.9   N
105  2  HEMATOLOGY HEMOGLOBIN  g/dL  14.0   11.7   15.9   N
106  0  HEMATOLOGY HEMATOCRIT  %     53     39     52     H
106  1  HEMATOLOGY HEMATOCRIT  %     50     39     52     N
106  2  HEMATOLOGY HEMATOCRIT  %     53     39     52     H
106  0  HEMATOLOGY HEMOGLOBIN  g/dL  17.0   12.7   17.2   N
106  1  HEMATOLOGY HEMOGLOBIN  g/dL  12.3   12.7   17.2   L
106  2  HEMATOLOGY HEMOGLOBIN  g/dL  12.9   12.7   17.2   N
107  0  HEMATOLOGY HEMATOCRIT  %     55     39     52     H
107  1  HEMATOLOGY HEMATOCRIT  %     56     39     52     H
107  2  HEMATOLOGY HEMATOCRIT  %     57     39     52     H
107  0  HEMATOLOGY HEMOGLOBIN  g/dL  18.0   12.7   17.2   N
107  1  HEMATOLOGY HEMOGLOBIN  g/dL  18.3   12.7   17.2   H
107  2  HEMATOLOGY HEMOGLOBIN  g/dL  19.2   12.7   17.2   H
108  0  HEMATOLOGY HEMATOCRIT  %     40     39     52     N
108  1  HEMATOLOGY HEMATOCRIT  %     53     39     52     H
108  2  HEMATOLOGY HEMATOCRIT  %     54     39     52     H
108  0  HEMATOLOGY HEMOGLOBIN  g/dL  15.0   12.7   17.2   N
108  1  HEMATOLOGY HEMOGLOBIN  g/dL  18.0   12.7   17.2   H
108  2  HEMATOLOGY HEMOGLOBIN  g/dL  19.1   12.7   17.2   H
109  0  HEMATOLOGY HEMATOCRIT  %     39     39     52     N
109  1  HEMATOLOGY HEMATOCRIT  %     53     39     52     H
109  2  HEMATOLOGY HEMATOCRIT  %     57     39     52     H
109  0  HEMATOLOGY HEMOGLOBIN  g/dL  13.0   12.7   17.2   N
109  1  HEMATOLOGY HEMOGLOBIN  g/dL  17.3   12.7   17.2   H
109  2  HEMATOLOGY HEMOGLOBIN  g/dL  17.3   12.7   17.2   H
110  0  HEMATOLOGY HEMATOCRIT  %     50     39     52     N
110  1  HEMATOLOGY HEMATOCRIT  %     51     39     52     N
110  2  HEMATOLOGY HEMATOCRIT  %     57     39     52     H
110  0  HEMATOLOGY HEMOGLOBIN  g/dL  13.0   12.7   17.2   N
110  1  HEMATOLOGY HEMOGLOBIN  g/dL  18.0   12.7   17.2   H
110  2  HEMATOLOGY HEMOGLOBIN  g/dL  19.0   12.7   17.2   H
;
run;
 
proc sort
   data = lb;
      by subjid lbcat lbtest lbstresu week;
run;

proc sort
   data = treat;
      by subjid;
run;

**** MERGE TREATMENT INFORMATION WITH LAB DATA.;
data lb;
   merge treat(in = intreat) lb(in = inlb);
      by subjid;

      **** CHECK TO MAKE SURE TREATMENT DATA EXISTS.;
      if inlb and not intreat then
         put "WARN" "ING: Missing treatment assignment for subject " subjid=;

      if intreat and inlb;
run;

**** CARRY FORWARD BASELINE LABORATORY ABNORMAL FLAG.;
data lb;
   set lb;
      by subjid lbcat lbtest lbstresu week;

      retain baseflag " ";

      **** INITIALIZE BASELINE FLAG TO MISSING.;
      if first.lbtest then
         baseflag = " ";

      **** AT WEEK 0 ASSIGN BASELINE FLAG.;
      if week = 0 then
         baseflag = lbnrind;
run;
  
proc sort
   data = lb;
      by lbcat lbtest lbstresu week trtcd;
run;

**** GET COUNTS AND PERCENTAGES FOR SHIFT TABLE.
**** WE DO NOT WANT COUNTS FOR WEEK 0 BY WEEK 0 SO WEEK 0 IS
**** SUPRESSED.;
ods listing close;
ods output CrossTabFreqs = freqs;
proc freq
   data = lb(where = (week ne 0));
      by lbcat lbtest lbstresu week trtcd;
    
      tables baseflag*lbnrind;
run;
ods output close;
ods listing;
 

**** WRITE LAB SHIFT SUMMARY TO FILE USING DATA _NULL_;
options nodate nonumber;
title1 "Table 5.6";
title2 "Laboratory Shift Table";
title3 " ";
data _null_;
   set freqs end = eof;
      by lbcat lbtest lbstresu week trtcd; 

      **** SUPPRESS TOTALS.;
      where baseflag ne '' and lbnrind ne '';

      **** SET OUTPUT FILE OPTIONS.;
      file print titles linesleft = ll pagesize = 50 linesize = 80;

      **** WHEN NEWPAGE = 1, A PAGE BREAK IS INSERTED.;
      retain newpage 0;
 
      **** WRITE THE HEADER OF THE TABLE TO THE PAGE.;
      if _n_ = 1 or newpage = 1 then 
         put @1 "-----------------------------------" 
                "-----------------------------------" /
             @1 lbcat ":" @39 "Baseline Value" /
             @1 lbtest 
             @17 "--------------------------------"
                 "----------------------" /
             @1 "(" lbstresu ")" @25 "Placebo" @55 "Active" /
             @17 "--------------------------  "
                 "--------------------------" /
             @20 "Low     Normal    High      Low     Normal"
                 "    High" /
             @1 "-----------------------------------" 
                "-----------------------------------" /;
 
      **** RESET NEWPAGE TO ZERO.;
      newpage = 0;

      **** DEFINE ARRAY VALUES WHICH REPRESENTS THE 3 ROWS AND
      **** 6 COLUMNS FOR ANY GIVEN WEEK.;
      array values {3,6} $10 _temporary_;

      **** INITIALIZE ARRAY TO "0(  0%)".;
      if first.week then
         do i = 1 to 3;
            do j = 1 to 6;
               values(i,j) = "0(  0%)";
            end;
         end;

      **** LOAD FREQUENCY/PRECENTS FROM FREQS DATA SET TO 
      **** THE PROPER PLACE IN THE VALUES ARRAY.;  
      values( sum((lbnrind = "L") * 1,(lbnrind = "N") * 2,
                  (lbnrind = "H") * 3) ,
              sum((baseflag = "L") * 1,(baseflag = "N") * 2,
                  (baseflag = "H") * 3) + (trtcd * 3)) = 
         put(frequency,2.) || "(" || put(percent,3.) || "%)";

      **** ONCE ALL DATA HAS BEEN LOADED INTO THE ARRAY FOR THE 
      **** WEEK, PUT THE DATA ON THE PAGE.;
      if last.week then
         do;
            put @1 "Week " week
                @10 "Low"    @18 values(1,1) @27 values(1,2) 
                             @36 values(1,3) @46 values(1,4) 
                             @55 values(1,5) @64 values(1,6) /
                @10 "Normal" @18 values(2,1) @27 values(2,2) 
                             @36 values(2,3) @46 values(2,4) 
                             @55 values(2,5) @64 values(2,6) /
                @10 "High"   @18 values(3,1) @27 values(3,2) 
                             @36 values(3,3) @46 values(3,4) 
                             @55 values(3,5) @64 values(3,6) /; 

            **** IF IT IS THE END OF THE FILE, PUT A DOUBLE LINE.;
            if eof then
               put @1 "-----------------------------------" 
                   "-----------------------------------" /
                   "-----------------------------------" 
                   "-----------------------------------" //
                   "Created by %sysfunc(getoption(sysin))"
                   "on &sysdate9..";  
		   **** IF ONLY THE LAST WEEK IN A TEST, THEN PAGE BREAK.;
		   else if last.lbtest then
               do;
                  put @1 "-----------------------------------" 
                      "-----------------------------------" /
                      @60 "(CONTINUED)" /
                          "Created by %sysfunc(getoption(sysin)) "
                          "on &sysdate9.."
                      _page_;
                  newpage = 1;
               end;
         end;    
run;
---------------------------------------------------------------------------
Program 5.7	 Kaplan-Meier Survival Estimate Table

**** INPUT SAMPLE TREATMENT AND TIME TO DEATH DATA.;
data death;
label trt         = "Treatment"
      daystodeath = "Days to Death"
      deathcensor = "Death Censor";
input trt $ daystodeath deathcensor @@;
datalines;
A  52    1     A  825   0     C  693   0     C  981   0
B  279   1     B  826   0     B  531   0     B  15    0
C  1057  0     C  793   0     B  1048  0     A  925   0
C  470   0     A  251   1     C  830   0     B  668   1
B  350   0     B  746   0     A  122   1     B  825   0
A  163   1     C  735   0     B  699   0     B  771   1
C  889   0     C  932   0     C  773   1     C  767   0
A  155   0     A  708   0     A  547   0     A  462   1
B  114   1     B  704   0     C  1044  0     A  702   1
A  816   0     A  100   1     C  953   0     C  632   0
C  959   0     C  675   0     C  960   1     A  51    0
B  33    1     B  645   0     A  56    1     A  980   1
C  150   0     A  638   0     B  905   0     B  341   1
B  686   0     B  638   0     A  872   1     C  1347  0
A  659   0     A  133   1     C  360   0     A  907   1
C  70    0     A  592   0     B  112   0     B  882   1
A  1007  0     C  594   0     C  7     0     B  361   0
B  964   0     C  582   0     B  1024  1     A  540   1
C  962   0     B  282   0     C  873   0     C  1294  0
B  961   0     C  521   0     A  268   1     A  657   0
C  1000  0     B  9     1     A  678   0     C  989   1
A  910   0     C  1107  0     C  1071  1     A  971   0
C  89    0     A  1111  0     C  701   0     B  364   1
B  442   1     B  92    1     B  1079  0     A  93    0
B  532   1     A  1062  0     A  903   0     C  792   0
C  136   0     C  154   0     C  845   0     B  52    0
A  839   0     B  1076  0     A  834   1     A  589   0
A  815   0     A  1037  0     B  832   0     C  1120  0
C  803   0     C  16    1     A  630   0     B  546   0
A  28    1     A  1004  0     B  1020  0     A  75    0
C  1299  0     B  79    0     C  170   0     B  945   0
B  1056  0     B  947   0     A  1015  0     A  190   1
B  1026  0     C  128   1     B  940   0     C  1270  0
A  1022  1     A  915   0     A  427   1     A  177   1
C  127   0     B  745   1     C  834   0     B  752   0
A  1209  0     C  154   0     B  723   0     C  1244  0
C  5     0     A  833   0     A  705   0     B  49    0
B  954   0     B  60    1     C  705   0     A  528   0
A  952   0     C  776   0     B  680   0     C  88    0
C  23    0     B  776   0     A  667   0     C  155   0
B  946   0     A  752   0     C  1076  0     A  380   1
B  945   0     C  722   0     A  630   0     B  61    1
C  931   0     B  2     0     B  583   0     A  282   1
A  103   1     C  1036  0     C  599   0     C  17    0
C  910   0     A  760   0     B  563   0     B  347   1
B  907   0     B  896   0     A  544   0     A  404   1
A  8     1     A  895   0     C  525   0     C  740   0
C  11    0     C  446   1     C  522   0     C  254   0
A  868   0     B  774   0     A  500   0     A  27    0
B  842   0     A  268   1     B  505   0     B  505   1
; 
run;
  

**** PERFORM LIFETEST AND EXPORT SURVIVAL ESTIMATES TO 
**** SURVIVALEST DATA SET.;
ods listing close;
ods output ProductLimitEstimates = survivalest;
proc lifetest
   data = death;
    
   time daystodeath * deathcensor(0);
   strata trt;
run;
ods output close;
ods listing;
  
 
**** CALCULATE VISIT WINDOW (MONTHS/YEARS).;
data survivalest;
   set survivalest; 
 
   if daystodeath = 0 then
      visit = 0;    **** Baseline;
   else if 1 <= daystodeath <= 91 then
      visit = 91;   **** 3 Months;
   else if 92 <= daystodeath <= 183 then
      visit = 183;  **** 6 Months;
   else if 184 <= daystodeath <= 365 then
      visit = 365;  **** 1 Year;
   else if 366 <= daystodeath <= 731 then
      visit = 731;  **** 2 Years;
   else if 732 <= daystodeath <= 1096 then
      visit = 1096; **** 3 Years;
   else if 1097 <= daystodeath <= 1461 then
      visit = 1461; **** 4 Years;
   else 
      put "ERR" "OR: event data beyond visit mapping " 
          daystodeath = ;
run;

proc sort
   data = survivalest;
      by trt visit daystodeath;
run;
  
**** CREATE 95% CONFIDENCE INTERVAL AROUND THE ESTIMATE 
**** AND RETAIN PROPER SURVIVAL ESTIMATE FOR TABLE.;
data survivalest;
   set survivalest;
      by trt visit daystodeath;

      keep trt visit count left survprob lcl ucl; 
      retain count survprob lcl ucl;

      **** INITIALIZE VARIABLES TO MISSING FOR EACH TREATMENT.;
      if first.trt then
         do;                
            survprob = .;
            count = .;
            lcl = .;
            ucl = .;
         end;
        
      **** CARRY FORWARD OBSERVATIONS WITH AN ESTIMATE.;
      if survival ne . then
         do;
            count = failed;
            survprob = survival;           
	    **** SUPPRESS CONFIDENCE INTERVALS AT BASELINE.;
            if visit ne 0 then
               do;
                  lcl = survival - (stderr*1.96);
                  ucl = survival + (stderr*1.96);
               end;
         end;
    
      **** KEEP ONE RECORD PER VISIT WINDOW.; 
      if last.visit;
run;

proc sort
   data = survivalest;
      by visit;
run;

**** COLLAPSE TABLE BY TREATMENT.  THIS IS DONE BY MERGING THE 
**** SURVIVALEST DATA SET AGAINST ITSELF 3 TIMES.;
data table;
  merge survivalest
        (where = (trt = "A")
         rename = (count = count_a left = left_a
                   survprob = survprob_a lcl = lcl_a ucl = ucl_a))
        survivalest
        (where = (trt = "B")
         rename = (count = count_b left = left_b
                   survprob = survprob_b lcl = lcl_b ucl = ucl_b))
        survivalest
        (where = (trt = "C")
         rename = (count = count_c left = left_c
                   survprob = survprob_c lcl = lcl_c ucl = ucl_c));
      by visit;
run;
 
**** CREATE VISIT FORMAT USED IN TABLE.;
proc format;
   value visit
      0    = "Baseline"
      91   = "3 Months"
      183  = "6 Months"
      365  = "1 Year"
      731  = "2 Years"
      1096 = "3 Years"
      1461 = "4 Years";
run;

**** WRITE SUMMARY STATISTICS TO FILE USING PROC REPORT.; 
options  nonumber nodate missing = " "
         formchar = "|----|+|---+=|-/\<>*";
proc report
   data = table
   nowindows
   spacing = 1
   headline
   ls = 101 ps = 30
   split = "|";

   columns ("--" visit 
           ("Placebo|--" count_a left_a survprob_a 
                         ("95% CIs|--" lcl_a ucl_a))
           ("Old Drug|--" count_b left_b survprob_b 
                         ("95% CIs|--" lcl_b ucl_b))
           ("New Drug|--" count_c left_c survprob_c 
                          ("95% CIs|--" lcl_c ucl_c)) );

    define visit      /order order = internal "Visit" left 
                       format = visit.;
    define count_a    /display "Cum. Deaths" width = 6 
                       format = 3. center;
    define left_a     /display "Remain at Risk" width = 6 
                       format = 3. center spacing = 0;
    define survprob_a /display "Surv- ival Prob." center 
                       format = pvalue5.3;
    define lcl_a      /display "Lower" format = 5.3;
    define ucl_a      /display "Upper" format = 5.3;
    define count_b    /display "Cum. Deaths" width = 6 
                       format = 3. center;
    define left_b     /display "Remain at Risk" width = 6 
                       format = 3. center spacing = 0;
    define survprob_b /display "Surv- ival Prob." center 
                       format = pvalue5.3;
    define lcl_b      /display "Lower" format = 5.3;
    define ucl_b      /display "Upper" format = 5.3;
    define count_c    /display "Cum. Deaths" width = 6 
                       format = 3. center;
    define left_c     /display "Remain at Risk" width = 6 
                       format = 3. center spacing = 0;
    define survprob_c /display "Surv- ival Prob." center 
                       format = pvalue5.3;
    define lcl_c      /display "Lower" format = 5.3;
    define ucl_c      /display "Upper" format = 5.3;

    break after visit / skip;
 
title1 "Table 5.7";
title2 "Kaplan-Meier Survival Estimates for Death Over Time";
footnote1 "Created by %sysfunc(getoption(sysin)) on &sysdate9..";  
run;
---------------------------------------------------------------------------
Program 5.8	 Listing of Demographic Data Using PROC REPORT

**** INPUT SAMPLE DEMOGRAPHICS DATA.;
data demog;
label subjid   = "Subject Number"
      trt      = "Treatment"
      gender   = "Gender"
      race     = "Race"
      age      = "Age";
input subjid trt gender race age @@;
datalines;
101 0 1 3 37  301 0 1 1 70  501 0 1 2 33  601 0 1 1 50  701 1 1 1 60
102 1 2 1 65  302 0 1 2 55  502 1 2 1 44  602 0 2 2 30  702 0 1 1 28
103 1 1 2 32  303 1 1 1 65  503 1 1 1 64  603 1 2 1 33  703 1 1 2 44
104 0 2 1 23  304 0 1 1 45  504 0 1 3 56  604 0 1 1 65  704 0 2 1 66
105 1 1 3 44  305 1 1 1 36  505 1 1 2 73  605 1 2 1 57  705 1 1 2 46
106 0 2 1 49  306 0 1 2 46  506 0 1 1 46  606 0 1 2 56  706 1 1 1 75
201 1 1 3 35  401 1 2 1 44  507 1 1 2 44  607 1 1 1 67  707 1 1 1 46
202 0 2 1 50  402 0 2 2 77  508 0 2 1 53  608 0 2 2 46  708 0 2 1 55
203 1 1 2 49  403 1 1 1 45  509 0 1 1 45  609 1 2 1 72  709 0 2 2 57
204 0 2 1 60  404 1 1 1 59  510 0 1 3 65  610 0 1 1 29  710 0 1 1 63
205 1 1 3 39  405 0 2 1 49  511 1 2 2 43  611 1 2 1 65  711 1 1 2 61
206 1 2 1 67  406 1 1 2 33  512 1 1 1 39  612 1 1 2 46  712 0 . 1 49
;

proc sort
   data = demog;
      by subjid;
run;

***** LASTREC VARIABLE IS USED FOR CONTINUING FOOTNOTE.;
data demog;
   set demog end = eof;

   **** FLAG THE LAST OBSERVATION IN THE DATA SET.;
   if eof then
      lastrec = 1;
run;

**** CREATE FORMATS NEEDED FOR LISTING.; 
proc format;
   value trt
      1 = "Active"
      0 = "Placebo"; 
   value gender 
      1 = "Male"
      2 = "Female";
   value race
      1 = "White"
      2 = "Black"
      3 = "Other";
run; 

**** USE PROC REPORT TO WRITE LISTING OF DEMOGRAPHICS.;
options formchar="|----|+|---+=|-/\<>*" ls=75 ps=20 
        missing = " " nodate nonumber;
proc report
   data = demog
   split = "|"
   spacing = 3
   missing
   nowindows
   headline;

   columns ("--" lastrec subjid trt gender race age);

   define lastrec  /display noprint;
   define subjid  /order center width = 7  "Subject|ID" f = 3.;
   define trt     /display left width = 10 "Treatment" f = trt.;
   define gender  /display center width = 10 "Gender" 
                   f = gender.;
   define race    /display center width = 10 "Race" f = race.;
   define age     /display center width = 10 "Age" f = 3.;

   **** COMPUTE BLOCK TO PUT CONTINUING TEXT TO PAGE.;
   compute after _page_ / left;
   if not lastrec then 
      contline = "(Continued)"; 
   else 
      contline = "-----------"; 

   line @9 "------------------------------------------------" 
           contline $11.;
   endcomp;

   title1 "Listing 5.8";
   title2 "Subject Demographics";
   footnote1 "Created by %sysfunc(getoption(sysin)) on"
             " &sysdate9..";  
run;
---------------------------------------------------------------------------
Program 6.1	Laboratory Data Scatter Plot Using PROC GPLOT

**** INPUT SAMPLE HEMATOCRIT LAB DATA.;
data labs;
label baseline = "Baseline Result"
      value    = "Visit 3 Result"
      trt      = "Treatment";
input subject_id lbtest $ value baseline trt $ @@;
datalines;
101 hct 35.0 31.0 a    102 hct 40.2 30.0 a 
103 hct 42.0 42.4 b    104 hct 41.2 41.4 b 
105 hct 35.0 33.3 a    106 hct 34.3 34.3 a 
107 hct 30.3 44.0 b    108 hct 34.2 42.0 b 
109 hct 40.0 41.1 b    110 hct 41.0 42.1 b 
111 hct 33.3 33.8 a    112 hct 34.0 31.0 a 
113 hct 34.0 41.0 b    114 hct 34.0 40.0 b 
115 hct 37.2 35.2 a    116 hct 39.3 36.2 a 
117 hct 36.3 38.3 b    118 hct 37.4 37.3 b 
119 hct 44.2 34.3 a    120 hct 42.2 36.5 a
;
run;

**** DEFINE GRAPHICS OPTIONS:  SET DEVICE DESTINATION TO MS 
**** OFFICE CGM FILE, REPLACE ANY EXISTING CGM FILE, RESET ANY 
**** SYMBOL DEFINITIONS, AND SET COLORS TO BLACK.;
filename fileref1 "C:\lab_scatter.cgm";
goptions device  = CGMOF97L
         gsfname = fileref1
         gsfmode = replace
         reset   = symbol
         colors  = (black);

**** DEFINE PLOT SYMBOLS. TRT = A = CIRCLE, B = PLUS SIGN.; 
symbol1 value = CIRCLE;
symbol2 value = PLUS;

**** DEFINE VERTICAL AXIS OPTIONS.;
axis1 order = (30 to 45 by 5) 
      label = (angle = 90 height = 1.5)
      value = (height = 1.5)
      offset = (1 cm, );

**** DEFINE HORIZONTAL AXIS OPTIONS.;
axis2 order = (30 to 45 by 5)  
      label = (height = 1.5)
      value = (height = 1.5)
      offset = (1 cm, );

**** DEFINE THE LEGEND FOR THE BOTTOM OF THE GRAPH.;
legend1 frame
        value = (height = 1.5)
        label = (height = 1.5 justify = right 'Treatment:')
        position = (bottom center outside);


**** CREATE LINE OF EQUIVALENCE USING AN ANNOTATE DATA SET.;
data annotate; 

   format function $8.;
   format xsys ysys $1.; 
 
   **** SET COORDINATE SYSTEM AND POSITIONING.
   **** XSYS/YSYS = 1 SETS THE COORDINATES RELATIVE TO THE 
   **** PLOT AREA.;
   xsys = '1';
   ysys = '1';
   line = 1;
   size = 2;
   color = 'BLACK';

   **** MOVE TO LOWER LEFT CORNER.;
   function = 'MOVE';
   x = 0;
   y = 0;
   output;

   **** DRAW LINE FROM LOWER LEFT CORNER TO UPPER RIGHT CORNER.;
   function = 'DRAW';
   x = 100;
   y = 100;
   output;
run;

**** CREATE SCATTERPLOT.  BASELINE IS ON THE Y AXIS, VISIT 3 IS 
**** ON THE X AXIS, AND THE VALUES ARE PLOTTED BY TREATMENT.;
proc gplot
   data = labs; 

   plot baseline * value = trt / vaxis = axis1
                                 haxis = axis2
	                              anno = annotate  
                                 legend = legend1 
                                 noframe;
 
title1 height = 2 font = "Helvetica" 
       "Figure 6.1"; 
title2 height = 2 font = "Helvetica" 
       "Hematocrit (%) Scatter Plot"; 
title3 height = 2 font = "Helvetica" 
       "at Visit 3"; 
run;
quit;
---------------------------------------------------------------------------
Program 6.2	Clinical Response Line Plot Using PROC GPLOT

**** INPUT SAMPLE MEAN CLINICAL RESPONSE VALUES.;
data response;
label response = "Mean Clinical Response"
      visit    = "Visit"
      trt      = "Treatment";
input trt visit response @@;
datalines;
1  0 9.40    2  0 9.35
1  1 9.35    2  1 9.40
1  2 8.22    2  2 8.78
1  3 6.33    2  3 8.23
1  4 4.00    2  4 7.77
1  5 2.22    2  5 4.46
1  6 1.44    2  6 2.00
1  7 1.13    2  7 1.86
1  8 0.55    2  8 1.44
1  9 0.67    2  9 1.33
1 10 0.45    2 10 1.01
;
run;
 
**** CREATE VISIT FORMAT.;
proc format;
   value visit
      0 = "Baseline"
      1 = "Day 1"
      2 = "Day 2"
      3 = "Day 3"
      4 = "Day 4"
      5 = "Day 5"
      6 = "Day 6"
      7 = "Day 7"
      8 = "Day 8"
      9 = "Day 9"
      10 = "Day 10";

   value trt
      1 = "Super Drug"
      2 = "Old Drug";
run;

**** DEFINE GRAPHICS OPTIONS:  SET DEVICE DESTINATION TO MS 
**** OFFICE CGM FILE, REPLACE ANY EXISTING CGM FILE, RESET ANY 
**** SYMBOL DEFINITIONS, AND SET COLORS TO BLACK.;
filename fileref "C:\plot_signsymp_mean.cgm";
goptions device = CGMOF97L
         gsfname = fileref
         gsfmode = REPLACE
         reset = symbol
         colors = (black);

**** DEFINE PLOT SYMBOLS. DOT = SUPER DRUG WITH SOLID LINE, 
**** CIRCLE = OLD DRUG WITH DOTTED LINE.  I = J CONNECTS POINTS.; 
symbol1 c = black line = 1 v = dot i = j;
symbol2 c = black line = 2 v = circle i = j;

**** DEFINE HORIZONTAL AXIS OPTIONS.;
axis1 order = (0 to 10 by 1)
      value = (angle = 90 height = 1.5)
      label = (height = 1.5 "Visit")
      minor = none
      offset = (1,1);

**** DEFINE VERTICAL AXIS OPTIONS.;
axis2 order = (0 to 10 by 1)   
      value = (height = 1.5)
      label = (height = 1.5 angle = 90 "Mean Clinical Response")
      minor = none
      offset = (1,1);

**** DEFINE THE LEGEND FOR THE TOP RIGHT OF THE GRAPH.;
legend1 label = (height = 1.5 "Treatment:")
           order = (1 2)
        value = (height = 1.5 justify = left 
                 "Super Drug" "Old Drug" )  
        down = 2
        position = (top right inside)
           mode = protect
           frame; 
  
**** CREATE LINE PLOT.  VISIT IS ON THE X AXIS, RESPONSE IS ON
**** THE Y AXIS, AND THE VALUES ARE PLOTTED BY TREATMENT.  A 
**** REFERENCE LINE IS DRAWN JUST BEFORE DAY 1 TO SET APART 
**** POST TREATMENT DATA.;
proc gplot
   data = response;

   plot response * visit = trt /haxis = axis1 
                                vaxis = axis2
                                legend = legend1
                                href = (0.9);
   format visit visit.;
   title1 h = 2 font = "TimesRoman" 
          "Figure 6.2";
   title2 h = 2 font = "TimesRoman" 
          "Mean Clinical Response By Visit";
run;
quit;
---------------------------------------------------------------------------
Program 6.3	Clinical Response Line Plot Using PROC GPLOT

**** INPUT SAMPLE PAIN SCALE DATA.;
data pain;
label subject = "Subject"
      pain    = "Pain Score"
      trt     = "Treatment";
input subject pain trt @@;
datalines;
113	1 1		420	1 2		780	0 3
121	1 1		423	0 2		784	0 3
122	1 1		465	4 2		785	1 3
124	4 1		481	3 2		786	3 3
164	4 1		482	0 2		787	0 3
177	4 1		483	0 2		789	0 3
178	0 1		484	0 2		790	2 3
179	1 1		485	0 2		791	0 3
184	0 1		486	1 2		793	3 3
185	0 1		487	0 2		794	2 3
186	3 1		489	0 2		795	1 3
187	0 1		490	1 2		796	4 3
188	1 1		491	0 2		797	2 3
189	3 1		493	2 2		798	1 3
190	3 1		494	1 2		799	2 3
191	2 1		495	0 2		800	2 3
192	3 1		496	2 2		822	1 3
193	4 1		498	0 2		841	1 3
194	4 1		499	2 2		842	1 3
195	0 1		500	2 2		847	2 3
196	4 1		521	1 2		863	1 3
197	1 1		522	1 2		881	2 3
198	4 1		541	1 2		966	1 3
199	3 1		542	0 2		967	0 3
100	4 1		561	3 2		968	0 3
121	2 1		562	2 2		981	1 3
122	2 1		581	2 2		982	1 3
123	4 1		561	1 2		985	0 3
124	2 1		564	1 2		986	0 3
141	3 1		566	1 2		987	0 3
142	2 1		567	2 2		989	2 3
143	2 1		568	2 2		990	3 3
147	4 1		569	0 2		991	0 3
161	4 1		581	0 2		992	2 3
162	4 1		582	3 2		993	1 3
163	4 1		584	1 2		994	0 3
164	0 1		585	0 2		995	1 3
165	2 1		586	1 2		996	0 3
166	1 1		587	1 2		997	3 3
167	3 1		591	1 2		998	0 3
181	2 1		592	1 2		999	0 3
221	4 1		594	1 2		706	0 3
281	4 1		595	0 2		707	3 3
282	4 1		596	0 2		708	1 3
361	4 1		597	0 2		709	0 3
362	4 1		601	0 2		710	1 3
364	3 1		602	1 2		711	1 3
365	4 1		603	2 2		712	0 3
366	3 1		604	1 2		713	4 3
367	4 1		605	1 2		714	0 3
;

**** MAKE FORMATS FOR CHART.;
proc format;
   value trt
      1 = 'Placebo'
      2 = 'Old Drug'
      3 = 'New Drug';

   value score
      0 = '0'
      1 = '1-2'
      2 = '3-4'
      3 = '5-6'
      4 = '7-8';

   picture newpct (round)
      0 = " "
      0 < - < .5 = "<1%"
      .6 < - high = "000%";
run;
 
proc sort
   data = pain;
      by trt;
run;

**** GET FREQUENCY COUNTS FOR CHART AND PUT IN FREQOUT DATA SET.;
proc freq
   data = pain 
   noprint;
      by trt;

      tables pain /out = freqout;
run;
 
**** DEFINE GRAPHICS OPTIONS:  SET DEVICE DESTINATION TO MS 
**** OFFICE CGM FILE, REPLACE ANY EXISTING CGM FILE, RESET ANY 
**** SYMBOL DEFINITIONS, AND SET BACKGROUND TO WHITE AND OTHER **** COLORS TO BLACK.;
filename fileref "C:\bar_chart.cgm";
goptions device = cgmof97l
         gsfname = fileref 
         gsfmode = replace 
         reset = symbol
         cback = white 
         colors = (black)
         chartype = 6;

**** DEFINE BAR PATTERNS: WHITE = PLACEBO, GRAY = OLD DRUG,
**** BLACK = NEW DRUG.; 
pattern1 value = solid color = white;
pattern2 value = solid color = gray;
pattern3 value = solid color = black ;

**** DEFINE HORIZONTAL AXIS OPTIONS.;
axis1 label = (h = 1 'Pain Score')
      value = (h = 1 )
      order = (0 to 4 by 1);

**** DEFINE VERTICAL AXIS OPTIONS.;
axis2 label = (h = 1.2 r = 0 a = 90  'Percentage of Patients' )
      order = (0 to 50 by 10); 

**** CREATE BAR CHART.  PERCENTAGE OF PATIENTS IS ON THE Y AXIS, 
**** PAIN SCORE BY TREATMENT IS ON THE X AXIS.; 
proc gchart
   data = freqout;

   vbar3d pain /group = trt
                sumvar = percent
                maxis = axis1
                raxis = axis2
                midpoints = 0 1 2 3 4
                cframe = white
                coutline = black
                outside = sum
                patternid = group;

   format trt trt. 
          pain score.
          percent newpct.;
   title1 font = "TimesRoman" h = 2 color = black 
          "Figure 6.3" ;
   title2 font = "TimesRoman" h = 2 color = black
          "Summary of Pain Score by Treatment";
run;
quit;
---------------------------------------------------------------------------
Program 6.4	Creating a Box Plot Using PROC GPLOT

**** INPUT SAMPLE PAIN SCALE DATA;
data seizures;
label seizures = "Seizures per Hour"
      visit    = "Visit"
      trt      = "Treatment";
input trt visit seizures @@;
datalines;
1	2	1.5		2	1	3		2	2	1.8
2	1	2.6		2	2	2		2	3	2
1	1	2.8		2	3	2.6		1	1	3
1	2	2.2		1	1	2.4		2	1	3.2
2	1	3.2		1	2	1.4		1	1	2.6
2	2	2.1		1	3	1.8		1	2	1.2
1	1	2.6		2	1	3		1	3	1.8
2	1	2.2		1	1	3.6		2	1	2.1
2	2	3.2		1	2	2		2	2	1
1	1	2.6		1	3	3.6		2	3	1.8
1	2	2.2		2	1	3.6		1	1	2.6
1	3	2.2		2	2	2.6		2	1	4
2	1	2.8		2	3	2		2	3	3.6
2	2	2.6		1	1	2.8		1	1	3.4
2	3	2.6		1	2	1.8		1	2	3
1	1	2.0		1	3	1.6		2	1	3.4
1	2	2.4		2	1	3.8		2	2	2
2	1	2.1		2	2	3		1	1	2.6
2	2	1.2		2	3	3.4		1	3	1.8
2	3	1		1	1	4		2	1	2.0
1	1	2.9		1	3	3.4		1	1	2.8
1	2	1.6		2	1	2.8		2	1	2.4
1	3	1.2		2	2	1.2		1	1	3.6
2	1	2.8		2	3	1.2		2	1	3.2
2	2	2.6		1	1	1.8		2	2	2.2
2	3	3.2		1	2	2		2	3	3.2
1	1	2.8		1	3	2.2		1	1	4
1	2	1.4		2	1	3		2	1	3.2
1	3	2		2	2	1.4		1	1	2.4
2	1	1.6		2	3	1.4		2	1	4
1	1	2.8		1	1	3.6		2	2	2.2
1	2	1.4		1	2	1.4		1	1	4
1	3	1.2		2	1	2.2
;

proc format;
   value trt
      1 = "Active"
      2 = "Placebo";
run;

**** CREATE PLOTVISIT VARIABLE WHICH IS A SLIGHTLY OFFSET VISIT 
**** VALUE TO MAKE TRT DISTINGUISHABLE ON THE X AXIS.  OTHERWISE,
**** TREATMENT 1 AND 2 WOULD HAVE OVERLAPPING BOXES.;
data seizures;
   set seizures;

   if trt = 1 then
      plotvisit = visit - .1;
   else if trt = 2 then
      plotvisit = visit + .1;
run;
  
**** DEFINE GRAPHICS OPTIONS:  SET DEVICE DESTINATION TO MS 
**** OFFICE CGM FILE, REPLACE ANY EXISTING CGM FILE, RESET ANY 
**** SYMBOL DEFINITIONS, AND DEFINE DEFAULT FONT TYPE.;
filename fileref 'C:\whisker.cgm';
goptions
   device = cgmof97l
   gsfname = fileref
   gsfmode = replace
   reset = symbol
   colors = (black)
   chartype = 6;

**** SET SYMBOL DEFINITIONS.  
**** SET LINE THICKNESS WITH WIDTH AND BOX WIDTH WITH BWIDTH.  
**** ACTIVE DRUG IS DEFINED AS A SOLID BLACK LINE IN SYMBOL1 
**** AND PLACEBO GETS A DASHED GRAY LINE IN SYMBOL2.
**** VALUE = NONE SUPPRESSES THE ACTUAL DATA POINTS.  
**** BOXJT00 MEANS TO CREATE BOX PLOTS WITH BOXES (25TH AND 75TH 
**** PERCENTILES - THE INTERQUARTILE RANGE) JOINED (J) AT THE 
**** MEDIANS WITH WHISKERS EXTENDING TO THE MINIMUM AND MAXIMUM 
**** VALUES (00) AND TOPPED/BOTTOMED (T) WITH A DASH.  
**** MODE = INCLUDE OPTION ENSURES THAT VALUES THAT MIGHT FALL 
**** OUTSIDE OF THE EXPLICITLY STATED AXIS ORDER WOULD BE 
**** INCLUDED IN THE BOX AND WHISKER DEFINITION.;
symbol1 width = 28 bwidth = 3 color = black line = 1 value = none              
        interpol = BOXJT00 mode = include;
symbol2 width = 28  bwidth = 3 color = gray line = 2 value = none 
        interpol = BOXJT00 mode = include;

**** DEFINE THE LEGEND FOR THE BOTTOM CENTER OF THE PAGE.;
legend1  
   frame
   value = (height = 1.5)
   label = (height = 1.5 justify = right 'Treatment:' )
   position = (bottom center outside);

**** DEFINE VERTICAL AXIS OPTIONS.;
axis1 label = (h = 1.5 r = 0 a = 90 "Seizures per Hour")
      value = (h = 1.5 )
      minor = (n = 3);

**** DEFINE HORIZONTAL AXIS OPTIONS.
**** THE HORIZONTAL AXIS MUST GO FROM 0 TO 4 HERE BECAUSE OF THE 
**** OFFSET APPLIED TO VISIT.  NOTICE THAT THE VALUE FOR VISIT 
**** OF 0 AND 4 IS SET TO BLANK.;
axis2 label = (h = 1.5  "Visit")
      value = (h = 1.5 " " "Baseline"  "6 Months" "9 Months" " ")
      order = (0 to 4 by 1)
      minor = none;

**** CREATE BOX PLOT.  VISIT IS ON THE X AXIS, SEIZURES ARE ON
**** THE Y AXIS, AND THE VALUES ARE PLOTTED BY TREATMENT.;
proc gplot
   data = seizures;

   plot seizures * plotvisit = trt  /vaxis = axis1 
                                     haxis = axis2
                                     legend = legend1
                                     noframe;
   format trt trt.;

   title1 h = 2 font = "TimesRoman"
         "Figure 6.4"; 
   title2 h = 2 font = "TimesRoman"
         "Box plot of Seizures per Hour By Treatment"; 
   footnote1 h = 1.5 j = l font = "TimesRoman"
         "Box extends to 25th and 75th percentile.";
   footnote2 h = 1.5 j = l font = "TimesRoman"
         "Whiskers extend to minimum and maximum values.";
run;
quit;
---------------------------------------------------------------------------
Program 6.5	Creating a Box Plot With Means Using PROC GPLOT

proc format;
   value trt
      1 = "Active"
      2 = "Placebo";
run;

**** SORT THE DATA AND GET THE MEAN SEIZURE VALUE BY VISIT AND **** TREATMENT.;
proc sort
   data = seizures;
      by visit trt;
run;

proc univariate
   data = seizures noprint;
      by visit trt;

      var seizures;
      output out = stats mean = mean;
run;
 
**** MERGE THE MEAN VALUES BACK IN WITH THE SEIZURE DATA.;
data seizures;
   merge seizures stats;
      by visit trt;
run;

**** CREATE PLOTVISIT VARIABLE WHICH IS A SLIGHTLY OFFSET VISIT 
**** VALUE TO MAKE TRT DISTINGUISHABLE ON THE X AXIS.  OTHERWISE,
**** TREATMENT 1 AND 2 WOULD HAVE OVERLAPPING BOXES.;
data seizures;
   set seizures;

   if trt = 1 then
      plotvisit = visit - .1;
   else
      plotvisit = visit + .1;
run;

**** DEFINE GRAPHICS OPTIONS:  SET DEVICE DESTINATION TO MS 
**** OFFICE CGM FILE, REPLACE ANY EXISTING CGM FILE, RESET ANY 
**** SYMBOL DEFINITIONS, AND DEFINE DEFAULT FONT TYPE.;
filename fileref 'C:\whisker_mean.cgm';
goptions
   device = cgmof97l
   gsfname = fileref
   gsfmode = replace
   reset = symbol
   colors = (black)
   chartype = 6;

**** SET SYMBOL DEFINITIONS.  
**** SET LINE THICKNESS WITH WIDTH AND BOX WIDTH WITH BWIDTH.  
**** ACTIVE DRUG IS DEFINED AS A SOLID BLACK LINE IN SYMBOL1 
**** AND PLACEBO GETS A DASHED GRAY LINE IN SYMBOL2.
**** VALUE = NONE SUPPRESSES THE ACTUAL DATA POINTS.  
**** BOXJT00 MEANS TO CREATE BOX PLOTS WITH BOXES (25TH AND 75TH 
**** PERCENTILES - THE INTERQUARTILE RANGE) JOINED (J) AT THE 
**** MEDIANS WITH WHISKERS EXTENDING TO THE MINIMUM AND MAXIMUM 
**** VALUES (00) AND TOPPED/BOTTOMED (T) WITH A DASH.  
**** MODE = INCLUDE OPTION ENSURES THAT VALUES THAT MIGHT FALL 
**** OUTSIDE OF THE EXPLICITLY STATED AXIS ORDER WOULD BE 
**** INCLUDED IN THE BOX AND WHISKER DEFINITION.;
symbol1 width = 28 bwidth = 3 color = black line = 1 value = none 
        interpol = BOXJT00 mode = include;
symbol2 width = 28  bwidth = 3 color = gray line = 2 value = none 
        interpol = BOXJT00 mode = include;
**** ADD TWO NEW SYMBOL STATEMENTS TO PLOT THE MEAN VALUES.;  
symbol3 color = black value = dot;
symbol4 color = gray  value = dot;

**** DEFINE THE LEGEND FOR THE BOTTOM CENTER OF THE PAGE.;
legend1  
   frame
   value = (height = 1.5)
   label = (height = 1.5 justify = right 'Treatment:' )
   position = (bottom center outside);

**** DEFINE VERTICAL AXIS OPTIONS.;
axis1 label = (h = 1.5 r = 0 a = 90 "Seizures per Hour")
      value = (h = 1.5 )
      minor = (n = 3);

**** DEFINE HORIZONTAL AXIS OPTIONS.
**** THE HORIZONTAL AXIS MUST GO FROM 0 TO 4 HERE BECAUSE OF THE 
**** OFFSET APPLIED TO VISIT.  NOTICE THAT THE VALUE FOR VISIT 
**** OF 0 AND 4 IS SET TO BLANK.;
axis2 label = (h = 1.5  "Visit")
      value = (h = 1.5 " " "Baseline"  "6 Months" "9 Months" " ")
      order = (0 to 4 by 1)
      minor = none;

**** ADD NEW AXIS FOR PLOT2 STATEMENT BELOW.  WHITE IS USED TO 
**** MAKE THE AXIS INVISIBLE ON THE PLOT.;
axis3 color = white
      label = (color = white h = .3 "  " )
      value = (color = white h = .3)
      order = (1 to 4 by 1);

**** CREATE BOX PLOT.  VISIT IS ON THE X AXIS, SEIZURES ARE ON
**** THE Y AXIS, AND THE VALUES ARE PLOTTED BY TREATMENT. THE 
**** PLOT2 STATEMENT IS RESPONSIBLE FOR PLACING THE MEAN VALUES
**** ON THE PLOT.;
proc gplot
   data = seizures;
 
   plot seizures * plotvisit = trt  /vaxis = axis1 
                                     haxis = axis2
                                     legend = legend1
                                     noframe;
   plot2 mean * plotvisit = trt /vaxis = axis3
                                 nolegend; 

   format trt trt.;

   title1 h = 2 font = "TimesRoman"
         "Figure 6.5"; 
   title2 h = 2 font = "TimesRoman"
         "Box plot of Seizures per Hour By Treatment"; 
   footnote1 h = 1.5 j = l font = "TimesRoman"
         "Box extends to 25th and 75th percentile.  Whiskers"
         " extend to";
   footnote2 h = 1.5 j = l font = "TimesRoman"
         "minimum and maximum values.  Mean values are"
         " represented by";
   footnote3 h = 1.5 j = l font = "TimesRoman"
         "a dot while medians are connected by the line.";
   footnote4 h = .5 "   ";
run;
quit;
---------------------------------------------------------------------------
Program 6.6	Creating a Box Plot With Means Using PROC BOXPLOT

**** CREATE PLOTVISIT VARIABLE WHICH IS A SLIGHTLY OFFSET VISIT 
**** VALUE TO MAKE TRT DISTINGUISHABLE ON THE X AXIS.  OTHERWISE,
**** TREATMENT 1 AND 2 WOULD HAVE OVERLAPPING BOXES.;
data seizures;
   set seizures;

   if trt = 1 then
      plotvisit = visit - .1;
   else if trt = 2 then
      plotvisit = visit + .1;
run;

**** SORT DATA FOR PROC BOXPLOT.; 
proc sort
   data = seizures;
      by plotvisit;
run;

**** FORMATS FOR BOX PLOT.;
proc format;
   value trt
      1 = "Active"
      2 = "Placebo";
   value visit
      1 = "Baseline"
      2 = "6 Months"
      3 = "9 Months"
      other = " ";
run;

**** DEFINE GRAPHICS OPTIONS:  SET DEVICE DESTINATION TO MS 
**** OFFICE CGM FILE, REPLACE ANY EXISTING CGM FILE, RESET ANY 
**** SYMBOL DEFINITIONS, AND DEFINE DEFAULT FONT TYPE.;
filename fileref 'C:\whisker_proc_boxplot.cgm';
goptions
   device = cgmof97l
   gsfname = fileref
   gsfmode = replace
   reset = symbol
   colors = (black)
   chartype = 6;
 
**** SET SYMBOL DEFINITIONS.;
symbol1 value = dot;
symbol2 value = circle;

**** CREATE BOX PLOT.  VISIT IS ON THE X AXIS, SEIZURES ARE ON
**** THE Y AXIS, AND THE VALUES ARE PLOTTED BY TREATMENT.;
proc boxplot 
   data = seizures;

   plot seizures * plotvisit = trt / haxis = (0,1,2,3,4)
                                     boxwidth = 3
                                     hoffset = 0;

   format trt trt. plotvisit visit.;
   label plotvisit = "Visit";

   title1 h = 2 font = "TimesRoman"
         "Figure 6.6"; 
   title2 h = 2 font = "TimesRoman"
         "Box plot of Seizures per Hour By Treatment"; 
   footnote1 h = 1.5 j = l font = "TimesRoman"
         "Box extends to 25th and 75th percentile.  Whiskers"
         " extend to";
   footnote2 h = 1.5 j = l font = "TimesRoman"
         "minimum and maximum values.  Mean values are" 
         " represented by";
   footnote3 h = 1.5 j = l font = "TimesRoman"
         "a dot while medians are horizontal lines.";
   footnote4 h = .5 "   ";
run;
quit;
---------------------------------------------------------------------------
Program 6.7	Creating An Odds Ratio Plot Using PROC GPLOT

**** INPUT SAMPLE PAIN DATA.;
data pain;
label success  = "Therapy Success"
      trt      = "Treatment"
      male     = "Male"
      race     = "Race"
      basepain = "Baseline Pain Score";
input success trt male race basepain @@;
datalines;
1 0 1 3 20   1 0 1 1 31   1 0 1 2 40   1 0 1 1 50   1 1 2 1 60   
1 1 2 1 22   0 0 1 2 23   1 1 2 1 20   0 0 2 2 20   0 0 2 1 23   
1 0 2 2 20   1 1 1 1 25   1 1 1 1 20   1 1 2 1 20   1 1 2 2 20   
1 1 1 1 10   1 0 2 1 25   0 0 1 3 40   1 0 1 1 20   1 0 1 1 20   
0 0 1 3 24   1 1 1 1 30   0 1 1 2 20   0 1 2 1 21   0 1 1 2 34   
0 0 2 1 20   1 0 1 2 20   1 0 1 1 20   1 0 1 2 20   1 1 2 1 55   
1 1 1 3 22   1 1 1 1 34   1 1 1 2 40   1 1 1 1 50   1 1 1 1 60   
0 0 2 1 20   0 0 2 2 20   0 0 2 1 20   0 0 2 2 20   0 0 1 1 20   
1 1 1 2 25   1 1 1 1 23   1 0 2 1 20   1 1 2 1 20   1 0 1 2 22   
1 0 1 1 11   1 0 1 1 33   0 0 2 3 40   1 0 1 1 20   0 1 1 1 21   
1 1 2 3 24   1 0 2 1 30   1 1 1 2 20   1 1 2 1 21   0 1 1 2 33   
0 0 2 1 20   1 1 1 2 22   1 1 2 1 20   1 1 1 2 20   1 0 1 1 50   
0 0 1 1 55   0 0 1 2 12   0 1 1 1 20   1 1 1 2 22   1 1 1 1 12   
;
 
**** GET ADJUSTED ODDS RATIOS FROM PROC LOGISTIC AND PLACE
**** THEM IN DATA SET WALD.; 
ods output CloddsWald = odds;
proc logistic
   data = pain
   descending;

   model success = basepain male race trt / clodds = wald; 
run; 
ods output close;

***** RECATEGORIZE EFFECT FOR Y AXIS FORMATING PURPOSES.; 
data odds;
   set odds;

   select(effect);
      when("basepain") y = 1;
      when("male")     y = 2;
      when("race")     y = 3;
      when("trt")      y = 4;
      otherwise;
   end;
run;

**** FORMAT FOR EFFECT;
proc format;
   value effect
      1 = "Baseline Pain (continuous)"
      2 = "Male vs. Female"
      3 = "White vs. Black"
      4 = "Active Therapy vs. Placebo";
run;

**** ANNOTATE DATA SET TO DRAW THE HORIZONTAL LINE, ESTIMATE, AND
**** WHISKER.;    
data annotate;
   set odds;

   length function $ 8 position xsys ysys $ 1; 

   i = 0.10;    **** whisker width.;
   basey = y;   **** hang onto row position.;
      
   **** set coordinate system and positioning.;
   position = '5';
   xsys = '2';
   ysys = '2';
   line = 1;

   **** plot estimates on right part of the graph.;
   if oddsratioest ne . then
      do;
         *** place a DOT at OR estimate.;
         function = 'SYMBOL';
         text = 'DOT';
         size = 1.5;
         x = oddsratioest;
         output; 
         *** move to LCL.;
         function = 'MOVE';
         x = lowercl; 
         output;
         *** draw line to UCL.;
         function = 'DRAW';
         x = uppercl; 
         output;
         *** move to LCL bottom of tickmark.;
         function = 'MOVE';
         x = lowercl;
         y  = basey - i;
         output;
         *** draw line to top of tickmark.;
         function = 'DRAW';
         x = lowercl;
         y = basey + i;
         output;
         *** move to UCL bottom of tickmark.;
         function = 'MOVE';
         x = uppercl;
         y = basey - i;
         *** draw line to top of tickmark.;
         output;
         function = 'DRAW';
         x = uppercl;
         y = basey + i;
         output;
      end;
run;

**** DEFINE GRAPHICS OPTIONS:  SET DEVICE DESTINATION TO MS 
**** OFFICE CGM FILE, REPLACE ANY EXISTING CGM FILE, RESET ANY 
**** SYMBOL DEFINITIONS, AND DEFINE DEFAULT FONT TYPE.;
filename fileref 'C:\odds_ratio.cgm';
goptions
   device = cgmof97l
   gsfname = fileref
   gsfmode = replace
   reset = symbol
   colors = (black)
   chartype = 6;

**** DEFINE SYMBOL TO MAKE THE GRAPH SPACE THE PROPER SIZE BUT 
**** NOT TO ACTUALLY PLOT ANYTHING.;
symbol color = black interpol = none value = none repeat = 2;

**** DEFINE HORIZONTAL AXIS OPTIONS.;
axis1 label = (h = 1.5 "Odds Ratio and 95% Confidence Interval")
      value = (h = 1.2)
      logbase = 2
      logstyle = expand
      order = (0.125,0.25,0.5,1,2,4,8,16)
      offset = (2,2) ;

**** DEFINE VERTICAL AXIS OPTIONS.;
axis2 label = none
      value = (h = 1.2)
      order = (1 to 4 by 1)
      minor = none
      offset = (2,2);

**** CREATE THE ODDS RATIO PLOT.  THIS IS DONE PRIMARILY THROUGH
**** THE INFORMATION IN THE ANNOTATION DATA SET. PUT A HORIZONTAL
**** REFERENCE LINE AT 1 WHICH IS THE LINE OF SIGNIFICANCE.;
proc gplot
   data = odds;

   plot y * lowercl y * uppercl / anno = annotate
                                  overlay
                                  href = 1
                                  lhref = 2
                                  haxis = axis1
                                  vaxis = axis2; 
   format y effect.;
   title1 h = 2 font = "TimesRoman"
          "Figure 6.7"; 
   title2 h = 2.5 font = "TimesRoman" 
          "Odds Ratios for Clinical Success";
run;
quit;  
---------------------------------------------------------------------------
Program 6.8	Creating A Kaplan-Meier Estimate Plot Using PROC GPLOT

**** INPUT SAMPLE TIME TO DEATH DATA.
**** DAYS TO DEATH IS THE NUMBER OF DAYS FROM RANDOMIZATION TO 
**** DEATH OR LAST PATIENT FOLLOW-UP.  DEATHCENSOR VARIABLE IS A 
**** "1" IF THE PATIENT DIED AT THE TIME TO EVENT AND IT IS A "0" 
**** IF THE PATIENT WAS ALIVE AT LAST FOLLOW-UP.  TO SAVE SPACE,
**** PATIENT ID HAS BEEN OMITTED FROM THIS SAMPLE DATA SET.;
data death;
label trt         = "Treatment"
      daystodeath = "Days to Death"
      deathcensor = "Death Censor";
input trt $ daystodeath deathcensor @@;
datalines;
A  52    1     A  825   0     C  693   0     C  981   0
B  279   1     B  826   0     B  531   0     B  15    0
C  1057  0     C  793   0     B  1048  0     A  925   0
C  470   0     A  251   1     C  830   0     B  668   1
B  350   0     B  746   0     A  122   1     B  825   0
A  163   1     C  735   0     B  699   0     B  771   1
C  889   0     C  932   0     C  773   1     C  767   0
A  155   0     A  708   0     A  547   0     A  462   1
B  114   1     B  704   0     C  1044  0     A  702   1
A  816   0     A  100   1     C  953   0     C  632   0
C  959   0     C  675   0     C  960   1     A  51    0
B  33    1     B  645   0     A  56    1     A  980   1
C  150   0     A  638   0     B  905   0     B  341   1
B  686   0     B  638   0     A  872   1     C  1347  0
A  659   0     A  133   1     C  360   0     A  907   1
C  70    0     A  592   0     B  112   0     B  882   1
A  1007  0     C  594   0     C  7     0     B  361   0
B  964   0     C  582   0     B  1024  1     A  540   1
C  962   0     B  282   0     C  873   0     C  1294  0
B  961   0     C  521   0     A  268   1     A  657   0
C  1000  0     B  9     1     A  678   0     C  989   1
A  910   0     C  1107  0     C  1071  1     A  971   0
C  89    0     A  1111  0     C  701   0     B  364   1
B  442   1     B  92    1     B  1079  0     A  93    0
B  532   1     A  1062  0     A  903   0     C  792   0
C  136   0     C  154   0     C  845   0     B  52    0
A  839   0     B  1076  0     A  834   1     A  589   0
A  815   0     A  1037  0     B  832   0     C  1120  0
C  803   0     C  16    1     A  630   0     B  546   0
A  28    1     A  1004  0     B  1020  0     A  75    0
C  1299  0     B  79    0     C  170   0     B  945   0
B  1056  0     B  947   0     A  1015  0     A  190   1
B  1026  0     C  128   1     B  940   0     C  1270  0
A  1022  1     A  915   0     A  427   1     A  177   1
C  127   0     B  745   1     C  834   0     B  752   0
A  1209  0     C  154   0     B  723   0     C  1244  0
C  5     0     A  833   0     A  705   0     B  49    0
B  954   0     B  60    1     C  705   0     A  528   0
A  952   0     C  776   0     B  680   0     C  88    0
C  23    0     B  776   0     A  667   0     C  155   0
B  946   0     A  752   0     C  1076  0     A  380   1
B  945   0     C  722   0     A  630   0     B  61    1
C  931   0     B  2     0     B  583   0     A  282   1
A  103   1     C  1036  0     C  599   0     C  17    0
C  910   0     A  760   0     B  563   0     B  347   1
B  907   0     B  896   0     A  544   0     A  404   1
A  8     1     A  895   0     C  525   0     C  740   0
C  11    0     C  446   1     C  522   0     C  254   0
A  868   0     B  774   0     A  500   0     A  27    0
B  842   0     A  268   1     B  505   0     B  505   1
; 
run;

**** PERFORM LIFETEST AND EXPORT SURVIVAL ESTIMATES.;
ods output ProductLimitEstimates = survest;
proc lifetest
   data = death;
    
   time daystodeath * deathcensor(0);
   strata trt;
run;
ods output close;

proc sort
   data = survest; 
      by trt daystodeath;
run;
 
**** PREPARE THE SURVIVAL ESTIMATE DATA FOR PLOTTING.;  
data survest;
   set survest;
      by trt;

      **** CALCULATE MONTH FOR PLOTTING.;
      month = (daystodeath / 30.417);  *** = 365/12;

      **** ENSURE THAT THE LAST TIME TO EVENT VALUE WITHIN A 
      **** TREATMENT IS REPRESENTED ON THE PLOT IN THE CASE 
      **** THAT IT WAS NOT A DEATH.;
      retain lastsurv;
      if first.trt then
         lastsurv = .;
	
      if survival ne . then
         lastsurv = survival;

      if last.trt and survival = . then
         survival = lastsurv;

      **** REMOVE RECORDS WHERE ESTIMATE MISSING;
      if survival ne . or last.trt;
run;
 

**** DEFINE GRAPHICS OPTIONS:  SET DEVICE DESTINATION TO MS 
**** OFFICE CGM FILE, REPLACE ANY EXISTING CGM FILE, RESET ANY 
**** SYMBOL DEFINITIONS, AND DEFINE DEFAULT FONT TYPE.;
filename fileref 'C:\survival.cgm';
goptions
   device = cgmof97l
   gsfname = fileref
   gsfmode = replace
   reset = symbol
   colors = (black);

**** DEFINE SYMBOLS.  STEPJL INDICATES TO CREATE A STEP
**** FUNCTION AND TO JOIN THE POINTS AT THE LEFT.;
symbol1 c = black line = 2 v = NONE interpol = stepjl ;
symbol2 c = black line = 4 v = NONE interpol = stepjl ;
symbol3 c = black line = 1 v = NONE interpol = stepjl ;

**** DEFINE HORIZONTAL AXIS OPTIONS.;
axis1   order = (0 to 48 by 6)
        label = (h = 1.5 "Months from Randomization")
        minor = (number = 5)  
        offset = (0,1);

**** DEFINE VERTICAL AXIS OPTIONS.;
axis2   order = (0 to 1 by .1)   
        label = (h = 1.5 angle = 90 "Survival Probability")
        minor = none
        offset = (0,.75);

**** DEFINE THE LEGEND FOR THE BOTTOM CENTER OF THE PAGE.;
legend1 label = ("Treatment")
        order = ("A" "B" "C")
        value = ("Placebo" "Old Drug" "New Drug")  
        down = 3
        position = (bottom center)
        frame;
          
**** CREATE KM PLOT.  SURVIVAL ESTIMATE IS ON THE Y AXIS, MONTHS
**** ARE ON THE X AXIS, AND THE VALUES ARE PLOTTED BY TREATMENT.;
proc gplot
   data = survest;

   plot survival * month = trt / haxis = axis1 
                                 vaxis = axis2
                                 legend = legend1 ;

   format survival 4.1 month 2.;                      
   title1 h = 2 font = "TimesRoman"
         "Figure 6.8"; 
   title2 h = 2 font = "TimesRoman" 
          "Kaplan-Meier Survival Estimates for Death";
run ;
quit ;  
---------------------------------------------------------------------------
Program 6.9	Creating A Kaplan-Meier Estimate Plot Using PROC LIFETEST

proc format;
   value $trt
      "A" = "Placebo"
      "B" = "Old Drug"
      "C" = "New Drug";
run;

**** DEFINE GRAPHICS OPTIONS:  SET DEVICE DESTINATION TO MS 
**** OFFICE CGM FILE, REPLACE ANY EXISTING CGM FILE, RESET ANY 
**** SYMBOL DEFINITIONS, AND DEFINE DEFAULT FONT TYPE.;
filename fileref "C:\survival_from_lifetest.cgm";
goptions
   device = cgmof97l
   gsfname = fileref
   gsfmode = replace
   reset = symbol
   colors = (black);

**** DEFINE SYMBOLS.;
symbol1 c = black line = 1 v = NONE;
symbol2 c = black line = 4 v = NONE;
symbol3 c = black line = 2 v = NONE;


**** CREATE KAPLAN-MEIER PLOT WITH PROC LIFETEST.;
proc lifetest
   data = death
   plots = (s)
   censoredsymbol = none
   eventsymbol = none; 
    
   time daystodeath * deathcensor(0);
   strata trt;

   format trt $trt.;
                
   title1 h = 2 font = "TimesRoman"
         "Figure 6.9"; 
   title2 h = 2 font = "TimesRoman" 
          "Kaplan-Meier Survival Estimates for Death";
run;
---------------------------------------------------------------------------
Program 8.1	 Creating SAS XPORT Transport Format Data Sets for the FDA

libname sdtm "C:\sdtm_data";
libname dm xport "C:\dm.xpt";

**** PROC COPY METHOD TO CREATE A TRANSPORT FILE.;
proc copy
   in = sdtm
   out = dm;
      select dm;
run;
  
**** DATA STEP METHOD TO CREATE A TRANSPORT FILE.;
data dm.dm;
   set sdtm.dm;
run;
---------------------------------------------------------------------------
Program 8.2	 Creating Several SAS XPORT Transport Format Data Sets

***** THIS SAS MACRO CREATES A SERIES OF SAS XPORT FILES.;
***** PARAMETERS:  libname = raw data libref;
*****              dset    = name of data set;
%macro makexpt(libname=, dset=);
    
   libname &dset xport "c:\&dset..xpt";

   proc copy
      in = &libname
      out = &dset;
         select &dset;
   run;

%mend makexpt;

**** MAKEXPT CALLS;
%makexpt(libname = sdtm, dset = dm)
%makexpt(libname = sdtm, dset = ae) 
---------------------------------------------------------------------------
Program 8.3	 Using PROC CDISC to Create an ODM XML file

libname sdtm "C:\sdtm_data"; 

**** SPECIFY PROC CDISC PARAMETERS IN DATA STEPS.;
data odm;
   ODMVersion = "1.2";
   fileOID = "2004-09-11 Transfer of XT802";
   FileType = "Snapshot"; 
run; 

data study;
   StudyOID = "XT802";
run;

data globalvariables;
   StudyName = "XT802";
   StudyDescription = 
      "Clinical Trial XT802 - Study of Infectious Agent";
   ProtocolName = "INVAG-XT802";
run;

data metadataversion;
   MetadataVersionOID = "SDTMV3.1_01.00";
   Name = "Submissions Data Tabulation Model Version 3.1 - Trial Meta Version 01.00";
run;

**** GET DM DATA SET AND DEFINE 10 KEYSET VARIABLES.;
data dm;
   length __STUDYOID __METADATAVERSIONOID __STUDYEVENTOID
          __SUBJECTKEY __FORMOID __ITEMGROUPOID 
          __ITEMGROUPREPEATKEY __TRANSACTIONTYPE  
          __STUDYEVENTREPEATKEY __FORMREPEATKEY $ 100.;

   set sdtm.dm;
  
	retain __STUDYOID           "TRIALXT802"
          __METADATAVERSIONOID "SDTMV3.1_01.00" 
          __STUDYEVENTOID      "BASELINE"
          __FORMOID            "DM"
          __ITEMGROUPOID       "DM"
          __ITEMGROUPREPEATKEY "1"
          __TRANSACTIONTYPE    "Snapshot"
          __STUDYEVENTREPEATKEY "1"
          __FORMREPEATKEY       "1"; 

	**** MAP __SUBJECTKEY NEEDED FOR EXPORT TO USUBJID.;
	__SUBJECTKEY = usubjid;
run;

filename xmlout "C:\ODM_FILES\dm.xml";

**** EXPORT ODM DM FILE.;
proc cdisc
   model = odm
   write = xmlout;

	odm 			data = work.odm;
	study			data = work.study;
	globalvariables	data = work.globalvariables;
	metadataversion   data = work.metadataversion;
	clinicaldata	data = work.DM
                     domain  = "DM"
                     name    = "Demographics"
                     comment = "Patient Demographics";
run;
---------------------------------------------------------------------------
Program 8.4	 Using the XML LIBNAME Engine to Create an ODM XML file

libname  sdtm   'C:\sdtm_data';
filename output 'C:\dm.xml';
libname  output xml xmltype = CDISCODM FormatActive = yes;


**** GET DM DATA SET AND DEFINE 10 KEYSET VARIABLES.;
data dm;
   length __STUDYOID __METADATAVERSIONOID __STUDYEVENTOID  
          __SUBJECTKEY __FORMOID __ITEMGROUPOID
          __ITEMGROUPREPEATKEY __TRANSACTIONTYPE                
          __STUDYEVENTREPEATKEY __FORMREPEATKEY $ 100.;

   set sdtm.dm;
  
   retain __STUDYOID           "TRIALXT802"
          __METADATAVERSIONOID "SDTMV3.1_01.00" 
          __STUDYEVENTOID      "BASELINE"
          __FORMOID            "DM"
          __ITEMGROUPOID       "DM"
          __ITEMGROUPREPEATKEY "1"
          __TRANSACTIONTYPE    "Snapshot"
          __STUDYEVENTREPEATKEY "1"
          __FORMREPEATKEY       "1"; 

	**** MAP __SUBJECTKEY NEEDED FOR EXPORT TO USUBJID;
	__SUBJECTKEY = usubjid;
run;

**** EXPORT DM ODM FILE.;
data output.dm;
   set dm;
run;
---------------------------------------------------------------------------
Program 8.5	 Using PROC CPORT to Create a SAS Transport File

libname library "c:\mytrial";
filename tranfile 'c:\mytrial.xpt';

**** COPY ALL SAS DATA SETS AND PERMANENT FORMATS FROM LIBRARY
**** INTO MYTRIAL.XPT.;
proc cport 
   library = library 
   file = tranfile
   exclude sasmacr;
run;

