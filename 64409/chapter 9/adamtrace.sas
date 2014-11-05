/* Program:: adamtrace.sas
    Author::    Chris Holland
    Date::       Monday, September 05, 2011   21:10:06
    
    Description:: Checks ADaM traceability.  Compares AVAL to a value in a corresponding SDTM or ADaM 
                   data set using the record identified by --SEQ or SRCDOM, SRCVAR, and SRCSEQ.
                  
                  The user can either specify one data set via the DATASET parameter to perform 
                    traceability checks for that one data set, or perform traceability checks for 
                    an entire directory of ADaM data sets.  See assumptions.
                   
    Assumptions:: 
        The macro checks each data set with an "AD" prefix in the SOURCELIB, or the one specified data set,  
                to see if it contains SRC--- vars or a --SEQ var.
                
        If it contains SRC--- vars, then the AVAL is checked against SRCVAR from the corresponding SRCDOM 
                data set (for the given USUBJID and SRCSEQ value).  It is therefore assumed that --SEQ 
                in the SRCDOM domain is unique within a subject.  If it is not, then an er-ror is written 
                to the log.
                
        If it contains only a --SEQ variable and the data set does not have the string "ADAE" in the name, 
                                        then it is assumed that AVAL comes from a --STRESN variable in the SDTM domain (determined 
                                        by the prefix of the --SEQ variable).  If AVAL is missing then AVALC is checked against 
                                        --STRESC.  The assumption that --SEQ is unique within a subject still holds.
                
        If the data set *does* have the string "ADAE" in the name, then AEDECOD in ADaM is checked against 
                                        AEDECOD in SDTM using either --SEQ vars or SRC--- vars (but SRCVAR must be AEDECOD).

        For example, if the data set contains a LBSEQ variable, then the macro checks each value of AVAL to 
                see that it matches the value of LBSTRESN with the matching LBSEQ value.  
                    
                        
    Data sets::    Reads in either data sets specified by the DATASETS parameter or all data sets 
                     within in the library specified by ADAMLIB.
                   Also reads in all data sets referenced by the ADaM data that exist in the library 
                     specified by SRCLIB 
    Output::    Creates a data set called TRACEPROBLEMS_[datetime] in the library referenced by ADAMLIB
                  where [datetime] is replaced with the date/time in the following format: yyyy_mm_ddThh_mm_ss.  
                This dataset contains issues found.
                Optionally creates an Excel spreadsheet with the same name, if the EXCEL parameter is set to 1.

    Revision::  
*/ 

%macro adamtrace(adamlib=adam, srclib=sdtm, datasets= ,excel=1);

    proc format;
        value probtype 1 = "ADaM record not found in source data"
                       2 = "ADaM analysis variable does not match source data"
                        ;
                run;
                
                                       
    %local dataset;
    
    %** loop through each dataset;
    %macro datasetx(dataset= );

        %** determine if the data set has SRC--- vars or a --SEQ variable...;
        proc contents
            data = &adamlib..&dataset out=_varnames;
        run;
      
        %local srcdom1 traceability haseq n_dom;
        data _null_;
          set _varnames end=eof;
          
            retain haseq 0 hasrc 0;
            name = upcase(name);
            if reverse(trim(name))=:'QES' and name ne 'SRCSEQ' then
              do;
                haseq = 1;
                call symput("SRCDOM1", substr(name,1,index(name,'SEQ')-1));
                call symput("HASEQ", "1");
                call symput("N_DOM", "1");
              end;
            if name=:'SRC' then
              hasrc = 1;
            if eof and haseq and hasrc then
              put 'ER' "ROR: &Dataset has both a --SEQ variable and SRC--- variable(s) -- "; 
            if eof and haseq=0 and hasrc=0 then
              do;
                put "NOTE: No traceability variables provided in &dataset.  Ending subroutine."; 
                call symput("TRACEABILITY", "0");
              end;
            else if eof then
              call symput("TRACEABILITY", "1");
        run;
                          %put TRACEABILITY=&TRACEABILITY HASEQ=&HASEQ SRCDOM1=&SRCDOM1 N_DOM=&N_DOM;
                          
        %if &traceability=1 %then
          %do;
            %if &srcdom1= %then
              %do;
                ** determine how many unique SRCDOM values there are;
                proc sql noprint;
                  select count(distinct srcdom)
                  into :n_dom
                  from &adamlib..&dataset
                  ;
                  select distinct srcdom
                  into :srcdom1 - :srcdom%left(&n_dom)
                  from &adamlib..&dataset
                  ;
                quit;    
                %let n_dom=%left(&n_dom);;
              %end;
              
            %** perform the traceability check-- merge the SDTM and ADaM data;
            %do d = 1 %to &n_dom;
              
              %let srcdom=&&srcdom&d;
              %put d=&d TRACEABILITY=&TRACEABILITY HASEQ=&HASEQ SRCDOM=&SRCDOM N_DOM=&N_DOM;
              proc sort
                data = &srclib..&srcdom
                out = sdtm;
                  by usubjid &srcdom.seq;
              run;
              
              %if &HASEQ=1 %then
                %do;
                  proc sort
                    data = &adamlib..&dataset
                    out = adam;
                      by usubjid &srcdom.seq;
                  run;
                %end;
              %else
                %do;
                  proc sort
                    data = &adamlib..&dataset
                    out = adam (rename=(srcseq = &srcdom.seq));
                      where srcdom="&srcdom";
                      by usubjid srcseq ;
                  run;
                                                                        
                  proc sort
                    data = &adamlib..&dataset
                    out = __tst
                    nodupkey;
                      where srcdom="&srcdom";
                      by srcvar;
                  run;

                  data _null_;
                    set __tst nobs=nobs;
                      by srcvar;
                  
                      if nobs>1 then
                        put 'PROB' 'LEM: More than one SRCVAR for ' SRCDOM= ". Using only the first, " SRCVAR= ;
                      if first.srcvar then
                        call symput("srcvar", srcvar);
                  run;
                %end;
                                                          
                %*-------------------------------------------------------------------------------------------------------;  
                %** establish what the ADaM analysis variable is and the corresponding SDTM variable that it should match;
                %*-------------------------------------------------------------------------------------------------------;  
                %if %index(%upcase(&dataset),ADAE)>0 %then
                  %do;
                    %let adamvar=AAEDECOD; * ADAM.AEDECOD will be renamed to this;
                    %let sdtmvar=AEDECOD;
                  %end;
                %else %if &HASEQ=1 %then
                  %do;
                    %let adamvar=AVAL;
                    %let sdtmvar=&srcdom.resn;
                  %end;
                %else 
                  %do;
                    %let adamvar=AVAL;
                    %let sdtmvar=&srcvar;
                  %end;
                  
                  
                data traceproblems&d;
                  %** if checking ADAE rename AEDECOD to AAEDECOD so it can be checked against SDTM.AEDECOD;
                  merge sdtm (in = insrc) adam (in = inadam %if %index(%upcase(&dataset),ADAE)>0 %then rename=(aedecod=aaedecod); );
                    by usubjid &srcdom.seq;
                    
                      keep usubjid srcdom probtype &srcdom.seq _insrc _inadam &adamvar &sdtmvar problem;
                      label _insrc  = "Record exists in source?"
                            _inadam = "Record exists in ADaM?"
                            srcdom  = "Source domain"
                      ;
                      
                        _insrc = insrc;
                        _inadam = inadam;
                        srcdom = "&srcdom"; ** this is for cases where &haseq=1-- otherwise just re-assigning;
                        if inadam and not insrc then
                    probtype = 1; 
                  else if inadam and insrc and &adamvar ne &sdtmvar then 
                    probtype=2;
                  
                  if probtype>0 then
                    do;
                      problem = put(probtype,probtype.);
                      output;
                    end;
                    
                run;               
                                                 
        %end;  %* d-loop through each domain; 
      
        ** derive the date/time suffix for output file names;
        data _null_;
          dat = "&sysdate"d;
          tim = "&systime"t;
          suffix = cat(put(dat,yymmdd8.), "T", left(put(tim,time7.)));
          suffix = translate(suffix,"__", "-:");
          put dat=yymmdd8. tim=time7. suffix= ;
          call symput("datetimesuffix", suffix);
        run;
        
        data &adamlib..traceproblems_&datetimesuffix;
          set traceproblems1-traceproblems&n_dom;
        run;

        %if &excel %then        
          %do;
            proc sql;
            	select distinct path
            	into :adampath
                from dictionary.members
            	where upcase(libname) = upcase("&adamlib")
            	;
            quit;
            
            %let adampath=%cmpres(&adampath);
            %let datetimesuffix=%cmpres(&datetimesuffix);
            %put adampath=&adampath;
            proc export
              data = &adamlib..traceproblems_&datetimesuffix
              /*outfile = "&adampath\traceproblems_&datetimesuffix..xls"*/
              outfile = "c:\users\chris\desktop\traceproblems.xlsx"
              dbms=EXCEL
              replace
              ;
            run;
          %end;      
      %end; %* if &traceability=1;
                                                                        
    %mend datasetx;


    %*------------------------------------------------------------------------------------;
    %** If datasetS parameter specified, then loop through those datasets;
    %**   otherwise, dynamically identify all ADxx data sets and go through them all;
    %*------------------------------------------------------------------------------------;
    %let _wrd=1;
    %if &DATASETS^= %then
      %do %while(%scan(&datasets,&_wrd)^= );                
          %let dataset=%scan(&datasets,&_wrd);
          %datasetx(dataset=&dataset);
          %let _wrd=%eval(&_wrd+1);
      %end;
    %else
      %do;                
          %** find all of the ADxx datasets and loop through each one;
          ods output members=members;
          proc contents
            data = &adamlib.._all_ memtype=data nods ;
          run;
      
          data members;
            set members;
            
              if upcase(name)=:'AD' then
                do;
                  rdataset = substr(name,5,2);
                  put name= rdataset= ;
                  output;
                end;
          run;
          
          %** loop through each dataset;
          proc sql noprint;
           select count(distinct rdataset)
             into :datasetn
             from members;
             ;   
           select distinct rdataset 
             into :dataset1 - :dataset%left(&datasetn)
             from members;
             ;
          %do _i=1 %to &datasetn;
            %datasetx(dataset=&&dataset&_i);
          %end;
      %end; %* if datasets not specified explicitly...;
      
                                                      
%mend adamtrace;


%** test this thing;
libname adam "C:\Users\chris\CDISC_SAS_book\data\adam";
libname sdtm "C:\Users\chris\CDISC_SAS_book\data\sdtm";

options mprint symbolgen mlogic;
** create an altered data set for testing;
data adam.adae_deleteme;
  set adam.adae;
  
    if _n_=3 then
      aedecod = 'THIS WILL NOT MATCH';
      
        rename aeseq = srcseq;
        srcdom = 'AE';
        srcvar = 'AEDECOD'; 
run;

%adamtrace(adamlib=adam, srclib=sdtm, datasets=adae_deleteme);
