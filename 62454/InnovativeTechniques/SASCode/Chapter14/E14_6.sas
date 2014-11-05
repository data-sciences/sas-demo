*E14_6.sas
*
* Returning a Physical location;
title 'Returning a Physical Location';

****************************************;
title2 '14.6.1 Using PATHNAME';
filename saspgm "&path\sascode\E14_6.sas";

%let pgmpath = %sysfunc(pathname(saspgm));
%put &pgmpath; 

%put %sysfunc(pathname(sasautos));

***************************************;
title2 '14.6.2 SASHELP VIEWS and DICTIONARY Tables';
proc print data=sashelp.vlibnam;
run;

* External files;
data _null_;
   set sashelp.vextfl(keep=fileref xpath
                      where=(fileref='SASPGM'));
   call symputx('pgmpath2',xpath,'l');
   run;
%put &pgmpath2;

proc sql noprint;
select xpath into :pgmsqlpath
   from dictionary.extfiles
      where fileref='SASPGM';
quit;
%put &pgmsqlpath;
**********************************************;
title2 '14.6.3 Determining the Executing Program Name and Path';
* Retrieve the name using SAS_EXECFILENAME;
%put %sysget(SAS_EXECFILENAME); 

%put %qscan(%sysget(SAS_EXECFILENAME),1,.); 

* Retrieve the path using SAS_EXECFILEPATE;
%macro grabpathname;
   %sysget(SAS_EXECFILEPATH)
%mend grabpathname;

%put %grabpathname;

*Path only;
%macro grabpath;
   %qsubstr(%sysget(SAS_EXECFILEPATH), 
         1, 
         %length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILEname))
         )
%mend grabpath;

**************************************************;
title2 '14.6.4 Retrieving the UNC Path';

* Create the catalog source for the DLL;
filename sascbtbl catalog "work.temp.attrfile.source";
 
data _null_;
  file sascbtbl;
 
  put "routine WNetGetConnectionA module=mpr minarg=3 maxarg=3 stackpop=called returns=long;";
  put "  arg 1 char input  byaddr format=$cstr200.;";
  put "  arg 2 char output byaddr format=$cstr200.;";
  put "  arg 3 num  update byaddr format=pib4.;";
  run;

%macro grabdrive;
   %qtrim(%qleft(%qscan(%sysget(SAS_EXECFILEPATH),1,\)))
%mend grabdrive;

* The DLL is call through the GETUNC macro;
%MACRO getUNC;
   %local dir path;
   %* Determine the UNC path for the SAS program being executed.;
   DATA _NULL_;
      length input_dir $200 output_dir $200;
       
      * The input directory can only be a drive letter + colon ONLY e.g. j: ;
      input_dir = "%grabdrive";  
      output_dir = ' ';
      output_len = 200;
      rc=modulec("WNetGetConnectionA", input_dir, output_dir, output_len);  
 
      call symputx('dir',input_dir,'l');  
      call symputx('path',output_dir,'l');  
      RUN;
   
   %* Get the name for the program of execution.;
   %put drive letter is &dir;  
   %put path is &path; 
   %put name is %grabpathname;  
%MEND getunc;
