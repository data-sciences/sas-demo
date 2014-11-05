**********************************************************************************;
* create_crtdds10_from_sdtm311.sas                                               *;
*                                                                                *;
* Sample driver program to perform a primary Toolkit action, in this case,       *;
* creating the CRTDDS Version 1.0 data sets from the SDTM 3.1.1 model            *;
* A call to a standard-specific CRTDDS macro is required later in this code.     *;
*                                                                                *;
* Assumptions:                                                                   *;
*         The SASReferences file must exist, and must be identified in the       *;
*         call to cstutil_processsetup if it is not work.sasreferences.          *;
*                                                                                *;
* CSTversion  1.3                                                                *;
*                                                                                *;
*  The following statements may require information from the user                *;
**********************************************************************************;

* define _ctsGroot macro variable;
%cstutil_setcstgroot;



%let workPath=%sysfunc(pathname(work));

* Note the number of calls should match the unique studyOutputPath subdirectories in sasreferences  *;
%****cstutil_createunixsubdir(_cstSubDir=data);      *   <--- example UNIX override  *;

%let _cstSetupSrc=SASREFERENCES;
%let _cstStandard=CDISC-CRTDDS;
%let _cstStandardVersion=1.0;


*****************************************************************************************;
* One strategy to defining the required library and file metadata for a CST process     *;
*  is to optionally build SASReferences in the WORK library.  An example of how to do   *;
*  this follows.                                                                        *;
*                                                                                       *;
* The call to cstutil_processsetup below tells CST how SASReferences will be provided   *;
*  and referenced.  If SASReferences is built in work, the call to cstutil_processsetup *;
*  may, assuming all defaults, be as simple as:                                         *;
*        %cstutil_processsetup(_cstStandard=CDISC-SDTM)                                 *;
*****************************************************************************************;

%cst_setStandardProperties(_cstStandard=CST-FRAMEWORK,_cstSubType=initialize);
%cst_createds(_cstStandard=CST-FRAMEWORK, _cstType=control,_cstSubType=reference, _cstOutputDS=work.sasreferences);

proc sql;
  insert into work.sasreferences 
  values ("CST-FRAMEWORK"     "1.2"    "messages"        ""           "messages" "libref"  ""                          1  ""                      "") 
  values ("CDISC-CRTDDS"      "1.0"    "messages"        ""           "crtmsg"   "libref"  ""                          2  ""                      "") 
  values ("CDISC-CRTDDS"      "1.0"    "autocall"        ""           "auto1"    "fileref" ""                          1  ""                      "") 
  values ("CDISC-CRTDDS"      "1.0"    "properties"      "initialize" "inprop"   "fileref" ""                          1  "initialize.properties" "") 
  values ("CDISC-CRTDDS"      "1.0"    "sourcedata"      ""           "srcdata"  "libref"  "C:\Documents and Settings\XPMUser\Desktop\CDISC_book\CST_make_define\define_data\target_metadata"  .  ""  "")
  values ("CDISC-SDTM"        "3.1.2"  "sourcemetadata"  "table"      "sampdata" "libref"  "C:\Documents and Settings\XPMUser\Desktop\CDISC_book\CST_make_define\define_data\source_metadata"  .  "source_tables"  "")
  values ("CDISC-SDTM"        "3.1.2"  "sourcemetadata"  "column"     "sampdata" "libref"  "C:\Documents and Settings\XPMUser\Desktop\CDISC_book\CST_make_define\define_data\source_metadata"  .  "source_columns"  "")
  values ("CDISC-TERMINOLOGY" "201003" "fmtsearch"       ""           "ctfmt"    "libref"  ""                                                                                                  1  ""                   "") 
  values ("CUSTOM"            "XYZ123F" "fmtsearch"      ""           "ctfmt"    "libref"  "C:\Documents and Settings\XPMUser\Desktop\CDISC_book\CST_make_define\define_data\source_metadata"  2  " formats.sas7bcat"  "")
  ;
quit; 

************************************************************;
* Debugging aid:  set _cstDebug=1                          *;
* Note value may be reset in call to cstutil_processsetup  *;
*  based on property settings.  It can be reset at any     *;
*  point in the process.                                   *;
************************************************************;
%let _cstDebug=1;
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
*     ERROR - At least one file associated with fileref AUTO1 is still in use.          *;
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

%crtdds_sdtm311todefine10(
  _cstOutLib=srcdata, 
  _cstSourceTables=sampdata.source_tables, 
  _cstSourceColumns=sampdata.source_columns,
  _cstSourceStudy=sampdata.source_study);
