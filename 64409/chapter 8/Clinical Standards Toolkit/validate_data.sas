**********************************************************************************;
* validate_data.sas                                                              *;
*                                                                                *;
* Sample driver program to perform a primary Toolkit action, in this case,       *;
* validation, to assess compliance of some source data and metadata with a       *;
* registered standard.  A call to a standard-specific validation macro is        *;
* required later in this code.                                                   *;
*                                                                                *;
* Assumptions:                                                                   *;
*   The SASReferences file must exist, and must be identified in the call to     *;
*    cstutil_processsetup if it is not work.sasreferences.                       *;
*                                                                                *;
* CSTversion  1.3                                                                *;
**********************************************************************************;

* define _ctsGroot macro variable;
%cstutil_setcstgroot;

%let workPath=%sysfunc(pathname(work));

* Note the number of calls should match the unique studyOutputPath subdirectories in sasreferences  *;
%****cstutil_createunixsubdir(_cstSubDir=results);      *   <--- example UNIX override  *;

%let _cstSetupSrc=SASREFERENCES;
%let _cstStandard=XYZ std CDISC-SDTM;
%let _cstStandardVersion=3.1.2;

*****************************************************************************************;
* One strategy to defining the required library and file metadata for a CST process     *;
*  is to optionally build SASReferences in the WORK library.  An example of how to do   *;
*  this follows.                                                                        *;
*                                                                                       *;
* The call to cstutil_processsetup below tells CST how SASReferences will be provided   *;
*  and referenced.  If SASReferences is built in work, the call to cstutil_processsetup *;
*  may, assuming all defaults, be as simple as  %cstutil_processsetup()                 *;
*****************************************************************************************;

%cst_setStandardProperties(_cstStandard=CST-FRAMEWORK,_cstSubType=initialize);
%cst_createds(_cstStandard=CST-FRAMEWORK, _cstType=control,_cstSubType=reference, _cstOutputDS=work.sasreferences);

***********************************************************************************************************;
* column order:  standard, standardversion, type, subtype, sasref, reftype, path, order, memname, comment *;
* note that &_cstGRoot points to the Global Library root directory                                        *;
* path and memname are not required for Global Library references - defaults will be used                 *;
***********************************************************************************************************;
proc sql;
  insert into work.sasreferences 
  values ("CST-FRAMEWORK"       "1.2"    "messages"          ""                  "messages" "libref"  "C:\sas\toolkit_global_library\standards\XYZ_program_cdisc-sdtm-3.1.2-1.3\messages" 1 "messages.sas7bdat" "") 
  values ("XYZ std CDISC-SDTM"  "3.1.2"  "autocall"          ""                  "sdtmauto" "fileref" "C:\sas\toolkit_global_library\standards\XYZ_program_cdisc-sdtm-3.1.2-1.3\macros"   1 ""  "") 
  values ("XYZ std CDISC-SDTM"  "3.1.2"  "control"           "reference"         "cntl_s"   "libref"  "&workpath"                                                 1 "sasreferences"               "") 
  values ("XYZ std CDISC-SDTM"  "3.1.2"  "control"           "validation"        "cntl_v"   "libref"  "C:\Documents and Settings\XPMUser\Desktop\CDISC_book\CST_validate_sdtm\metadata\control"  2 "validation_control.sas7bdat" "") 
  values ("XYZ std CDISC-SDTM"  "3.1.2"  "fmtsearch"         ""                  "ctfmt"    "libref"  "C:\Documents and Settings\XPMUser\Desktop\CDISC_book\CST_validate_sdtm\metadata\source_metadata"  1  " formats.sas7bcat"  "")
  values ("XYZ std CDISC-SDTM"  "3.1.2"  "messages"          ""                  "sdtmmsg"  "libref"  ""                                                          2 ""                            "") 
  values ("XYZ std CDISC-SDTM"  "3.1.2"  "properties"        "initialize"        "inprop"   "fileref" ""                                                          1 "initialize.properties"       "") 
  values ("XYZ std CDISC-SDTM"  "3.1.2"  "properties"        "validation"        "valprop"  "fileref" "C:\Documents and Settings\XPMUser\Desktop\CDISC_book\CST_validate_sdtm" 2 "validation.properties"  "") 
  values ("XYZ std CDISC-SDTM"  "3.1.2"  "referencecontrol"  "validation"        "refcntl"  "libref"  "C:\sas\toolkit_global_library\standards\XYZ_program_cdisc-sdtm-3.1.2-1.3\validation\control"  . "validation_master.sas7bdat"  "")
  values ("XYZ std CDISC-SDTM"  "3.1.2"  "referencecontrol"  "standardref"       "refcntl"  "libref"  "C:\sas\toolkit_global_library\standards\XYZ_program_cdisc-sdtm-3.1.2-1.3\validation\control"  . "validation_stdref.sas7bdat"  "")
  values ("XYZ std CDISC-SDTM"  "3.1.2"  "referencecterm"    ""                  "ctref"    "libref"  "C:\Documents and Settings\XPMUser\Desktop\CDISC_book\CST_validate_sdtm\metadata\source_metadata" . "meddra.sas7bdat"  "") 
  values ("XYZ std CDISC-SDTM"  "3.1.2"  "referencemetadata" "column"            "refmeta"  "libref"  "C:\sas\toolkit_global_library\standards\XYZ_program_cdisc-sdtm-3.1.2-1.3\metadata" . "reference_columns.sas7bdat"  "") 
  values ("XYZ std CDISC-SDTM"  "3.1.2"  "referencemetadata" "table"             "refmeta"  "libref"  "C:\sas\toolkit_global_library\standards\XYZ_program_cdisc-sdtm-3.1.2-1.3\metadata" . "reference_tables.sas7bdat"  "") 
  values ("XYZ std CDISC-SDTM"  "3.1.2"  "results"           "validationmetrics" "results"  "libref"  "C:\Documents and Settings\XPMUser\Desktop\CDISC_book\CST_validate_sdtm"  . "validation_metrics.sas7bdat" "") 
  values ("XYZ std CDISC-SDTM"  "3.1.2"  "results"           "validationresults" "results"  "libref"  "C:\Documents and Settings\XPMUser\Desktop\CDISC_book\CST_validate_sdtm"  . "validation_results.sas7bdat" "") 
  values ("XYZ std CDISC-SDTM"  "3.1.2"  "sourcedata"        ""                  "srcdata"  "libref"  "C:\Documents and Settings\XPMUser\Desktop\CDISC_book\CST_based_sdtm_code\sdtm_data" . ""  "") 
  values ("XYZ std CDISC-SDTM"  "3.1.2"  "sourcemetadata"    "column"            "srcmeta"  "libref"  "C:\Documents and Settings\XPMUser\Desktop\CDISC_book\CST_validate_sdtm\metadata\source_metadata"  . "source_columns.sas7bdat"     "") 
  values ("XYZ std CDISC-SDTM"  "3.1.2"  "sourcemetadata"    "table"             "srcmeta"  "libref"  "C:\Documents and Settings\XPMUser\Desktop\CDISC_book\CST_validate_sdtm\metadata\source_metadata"  . "source_tables.sas7bdat"      "") 
  values ("CDISC-TERMINOLOGY"   "201003" "fmtsearch"         ""                  "cstfmt"   "libref"  "C:\Program Files\SAS\SASClinicalStandardsToolkitTerminology201003\1.3\standards\cdisc-terminology-201003\formats" 2 "cterms.sas7bcat"  "") 
  ;
quit;


************************************************************;
* Debugging aid:  set _cstDebug=1                          *;
* Note value may be reset in call to cstutil_processsetup  *;
*  based on property settings.  It can be reset at any     *;
*  point in the process.                                   *;
************************************************************;
%let _cstDebug=0;
data _null_;
  _cstDebug = input(symget('_cstDebug'),8.);
  if _cstDebug then
    call execute("options mprint mlogic symbolgen mautolocdisplay;");
  else
    call execute("options nomprint nomlogic nosymbolgen;");
run;

*****************************************************************************************;
* Clinical Standards Toolkit utilizes autocall macro libraries to contain and           *;
*  reference standard-specific code libraries.  Once the autocall path is set and one   *;
*  or more macros have been used within any given autocall library, deallocation or     *;
*  reallocation of the autocall fileref cannot occur unless the autocall path is first  *;
*  reset to exclude the specific fileref.                                               *;
*                                                                                       *;
* This becomes a problem only with repeated calls to %cstutil_processsetup() or         *;
*  %cstutil_allocatesasreferences within the same sas session.  Doing so, without       *;
*  submitting code similar to the code below may produce SAS errors such as:            *;
*     ERROR - At least one file associated with fileref SDTMAUTO is still in use.       *;
*     ERROR - Error in the FILENAME statement.                                          *;
*                                                                                       *;
* If you call %cstutil_processsetup() or %cstutil_allocatesasreferences more than once  *;
*  within the same sas session, typically using %let _cstReallocateSASRefs=1 to tell    *;
*  CST to attempt reallocation, use of the following code is recommended between each   *;
*  code submission.                                                                     *;
*                                                                                       *;
* Use of the following code is NOT needed to run this driver module initially.          *;
*****************************************************************************************;

%*let _cstReallocateSASRefs=1;
%*include "&_cstGRoot/standards/cst-framework-1.3/programs/resetautocallpath.sas";


*****************************************************************************************;
* The following macro (cstutil_processsetup) utilizes the following parameters:         *;
*                                                                                       *;
* _cstSASReferencesSource - Setup should be based upon what initial source?             *;
*   Values: SASREFERENCES (default) or RESULTS data set. If RESULTS:                    *;
*     (1) no other parameters are required and setup responsibility is passed to the    *;
*                 cstutil_reportsetup macro                                             *;
*     (2) the results data set name must be passed to cstutil_reportsetup as            *;
*                 libref.memname                                                        *;  
*                                                                                       *;
* _cstSASReferencesLocation - The path (folder location) of the sasreferences data set  *;
*                              (default is the path to the WORK library)                *;
*                                                                                       *;
* _cstSASReferencesName - The name of the sasreferences data set                        *;
*                              (default is sasreferences)                               *;
*****************************************************************************************;

%cstutil_processsetup();

**********************************************************************************;
* Run the standard-specific validation macro.                                    *;
**********************************************************************************;

%sdtm_validate;

