/*----------------------------------------------------------------------
  This macros finds the maximum length for all character variables 
    within a submission/libname. For each character variable, it 
    will assign the length to the minimum length required to avoid 
    truncation of the values.  This is to prevent file size inflation 
    due to padding of character variables that do not need it.
    
    Exceptions are made for the following types of SDTM and ADaM variables:
      1) **TESTCD or PARAMCD variables are assigned to a length of $8.
      2.) **TEST variables are assigned to $40 (except for IETEST vars).
      3.) **DTC variables are assigned to $20.
      
    Note: for variables that appear in multiple datasets, the maximum 
          length across all datasets is used if &DOMAINS is left blank.  
          
------------------------------------------------------------------------*/

%macro maxlength2(sourcelib=library, outlib=WORK, domains= );

  %local domain;
  %let sourcelib=%upcase(&sourcelib);
  %let varmax=0;
  
  proc format;
    value vtype 1 = " " 2 = '$';

  %** limit the length of all character variables to what is required for the ;
  %** given data set.  The following variables should be (will be) set to a fixed length: ;
  %**    1.) **TESTCD or PARAMCD variables = $8.; 
  %**    2.) **TEST variables = $40.;
  %**    3.) **DTC variables = $20.;
  %macro findmax(domain= );

    data _null_;
      set &sourcelib..&domain end=eof;
            
        length var $8.;
        array chars{*} _character_;
        array nums{*}  _numeric_;
        array maxlength{400} 8.  _temporary_ ; ** assuming no data set will have more than 400 variables;
        do i = 1 to dim(chars);
          maxlength{i} = max(maxlength{i}, length(chars{i}));
        end;
        if eof then
          do i = 1 to dim(chars);
            var = vname(chars{i});
            ** get the max value if this var has been found in other data sets;
            maxlength{i} = max(maxlength{i}, input(symget(trim(var)||"max"), best.));

            *put var= maxlength{i}= ;
            if reverse(trim(var))=:'DCTSET' or var='PARAMCD' then
              call symput(trim(var) || "max", "8");  ** TESTCDs and PARAMCD are set to $8.; 
            else if reverse(trim(var))=:'TSET' and var ne 'IETEST' then
              call symput(trim(var) || "max", "40");  ** --TEST vars are set to $40.;
            else if reverse(trim(var))=:'CTD' then
              call symput(trim(var) || "max", "20");
            else if trim(var) ne 'var' then
              call symput(trim(var) || "max", put(maxlength{i}, 3.));
          end;
          do i = 1 to dim(nums);
            var = vname(nums{i});
            ** assign all numerics a maxlength of 8;
            call symput(trim(var) || "max", "8");
          end;
    run;        
    
  %mend findmax;
            
  *-------------------------------------------------------------;
  * assign each character variable to the max observed length;
  *  (or minimum required length);
  *-------------------------------------------------------------;  
  %macro assignmax(domain= );

    proc contents
      data = &sourcelib..&domain out = __tmp ;*noprint;
    run;

    proc sort
      data = __tmp;
        by varnum;
    data _null_;
      set __tmp end=eof;
        by varnum;
        
        length varlist vartypes $800.;
        retain varlist vartypes;
        varlist  = trim(varlist) || " " || trim(name);
        
        ** if character then provide a '$';
        if _n_=1 then
          do;
            if type=1 then 
              vartypes = " ";
            else
              vartypes = "$";
          end;
        else if type=1 then
          vartypes = trim(vartypes) || "!";
        else 
          vartypes = trim(vartypes) || "$";  
        if eof;
        call symput("varlist", trim(varlist));
        call symput("vartypes", trim(vartypes));
        call symput("dslabel", memlabel);
    run;
    
    %let wrd=1;
    options varlenchk=NOWARN;
    data &outlib..&domain (label="&dslabel");
      length %do %while(%scan(&varlist,&wrd)^= );
                 %let thisvar=%scan(&varlist,&wrd);
                 &thisvar %if %substr(&vartypes,&wrd,1)=$ %then %substr(&vartypes,&wrd,1); &&&thisvar.max..
                 %let wrd = %eval(&wrd+1);
             %end;
      ;
      set &sourcelib..&domain;
      
    run;
        
  %mend assignmax;

  %*-----------------------------------------------------;
  %* get each unique variable name within the library;
  %* create a macro var for each character variable;
  %* and initialize the max length to zero;
  %*-----------------------------------------------------;
  proc sql noprint;
   create table _vars as
   select unique(name) 	
   from dictionary.columns
   where libname="%upcase(&sourcelib.)" ;*and type='char' 
   ;
  quit;
  
  data _null_;
    set _vars;
        call symput(trim(name) || "max", "0");
  run;
          
  %*------------------------------------------------------------------------------------;
  %* Find the minimum required length to avoid truncation
  %* If DOMAINS parameter was specified, then loop through those domains;
  %*   otherwise, go through all data sets in the library;
  %*------------------------------------------------------------------------------------;
  %let _wrd=1;
  %if &DOMAINS^= %then
    %do;
      ** first find the max across all;
      %do %while(%scan(&domains,&_wrd)^= );                
         %let domain=%scan(&domains,&_wrd);
         %findmax(domain=&domain,suppqual=0);
         %let _wrd=%eval(&_wrd+1);
      %end;

      ** now re-assign to the max;
      %do %while(%scan(&domains,&_wrd)^= );                
         %let domain=%scan(&domains,&_wrd);
         %assignmax(domain=&domain,suppqual=0);
         %let _wrd=%eval(&_wrd+1);
      %end;
    %end;
  %else
    %do;                      
       proc sql noprint;
        %** count the number of domains;
        select count(distinct memname)
          into :domn
          from dictionary.members
          where libname="&sourcelib." and memtype='DATA'
          ;   
        %** create a macro var for each domain;
        select distinct memname 
          into :domain1 - :domain%left(&domn)
          from dictionary.members
          where libname="&sourcelib." and memtype='DATA'
          ;
       
      ** first find the max across all;
       %do _i=1 %to &domn;
         %findmax(domain=&&domain&_i);
       %end;

      ** now re-assign to the max;
       %do _i=1 %to &domn;
         %assignmax(domain=&&domain&_i);
       %end;

    %end; %* if domains not specified explicitly...;

%mend maxlength2;
