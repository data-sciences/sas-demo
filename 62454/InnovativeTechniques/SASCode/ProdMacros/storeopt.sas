/***********************;*/
/****10.3.1a*/
/****%STOREOPT*/
/***********************;*/
%macro storeopt(oplist);
%local len i tem;
%if &oplist ne %then %do;
   %let oplist = %cmpres(&oplist);
   %global &oplist;
   %let len = %length(&oplist);
   %* Establish a var with opt names quoted;
   %let tem = ;
   %do i = 1 %to &len;
      %if %substr(&oplist,&i,1) = %str( ) %then %do;
         %* Add quotes around the words in the list;
         %let tem = &tem%str(%', %');
      %end;
      %else %let tem =&tem%UPCASE(%substr(&oplist,&i,1));
   %end;
   %let tem = %bquote(%str(%')&tem%str(%'));

   * Retrieve the current option settings;
   data _null_;
      set sashelp.voption;
      if optname in:(%UNQUOTE(&tem)) then do;
         call symput(optname,left(trim(setting)));
      end;
      run;
%end;
%mend storeopt;

/*%storeopt(linesize pagesize obs mlogic date)*/
