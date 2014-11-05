* E2_3_3b.sas
*
* Using the Macro Language for Error Exception Reporting;

title1 '2.3.3b Data Set with Exception Criteria';

data ValLab(keep=errtst errvar errval errtxt errrating);

   length errtst     $15
          errvar     $15
          errval     $25
          errtxt     $16
          errrating  8;

   errvar = "potassium";
   errval = "potassium";

   errtst = 'lt 3.1';
   errtxt = 'Low value(<3.1)';
   errrating= 1;
   output vallab;

   errtst = 'gt 6.7';
   errtxt = 'High value(>6.7)';
   errrating= 2;
   output vallab;
   run;

proc print data=vallab;
   run;

%macro errrpt(dsn=, bylst=subject);
%local i chkcnt;
proc sql noprint;
   select errtst, errvar, errval, errtxt, errrating
      into :errtst1-:errtst99,
           :errvar1-:errvar99,
           :errval1-:errval99,
           :errtxt1-:errtxt99,
           :errrating1-:errrating99
         from vallab;
   %let chkcnt = &sqlobs;
   quit;
data errrpt(keep=dsn errvar errval errtxt errrating 
                 &bylst);
   length dsn        $25
          errvar     $15
          errval     $25
          errtxt     $16
          errrating  8;

set &dsn;

%do i = 1 %to &chkcnt;
   %* Write as many error checks as are needed;
   if &&errvar&i &&errtst&i then do;
      dsn = "&dsn";
      errvar = "&&errvar&i";
      errval = &&errval&i;
      errtxt = "&&errtxt&i";
      errrating= &&errrating&i;
      output errrpt;
      end;
   %end;
   run;
%mend errrpt;
%errrpt(dsn=advrpt.lab_chemistry, bylst=subject visit labdt)

proc print data=errrpt;
   run;
