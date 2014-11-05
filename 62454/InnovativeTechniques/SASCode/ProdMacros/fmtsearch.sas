/***********************;*/
/****10.3.2a*/
/****%FMTSRCH*/
/***********************;*/
%macro fmtsrch(lib,add);
   %* Check to see if a libref is in the format search path
   %* lib   libref to check
   %* add   If &add is not null, then add the libref, if
   %*       it is not already in the fmtsearch value;

   %* Macro returns.
   %* &add is null
   %*    0  if &lib is not on path
   %*    >0 if &lib is on path
   %* &add is not null
   %*    Option statement to add &lib if it is not on path
   %*    null if &lib is on path;

   %local optval insrch;

   %* Determine if the library is on the fmt search path;
   %let optval = %sysfunc(getoption(fmtsearch));
   %let insrch = %index(&optval,%upcase(&lib));

   %if &add ne %then %do;
      %* Add &lib to format search,
      %* if it is not already on the path;
      %if &insrch = 0 %then %do;
         %* Remove the trailing close parenthesis;
         %let optval =
               %substr(&optval,1,%eval(%length(&optval)-1));
         %* Add the library;
         options fmtsearch=&optval &lib);
      %end;
   %end;
   %else &insrch;
%mend fmtsrch;
