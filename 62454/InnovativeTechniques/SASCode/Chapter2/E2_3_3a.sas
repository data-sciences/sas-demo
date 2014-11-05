* E2_3_3a.sas
*
* Error Exception Reporting;

title1 '2.3.3a Hardcoded Exception Reporting';

%macro errrpt(dsn=,errvar=,errval=,errtxt=,errrating=);
      dsn = "&dsn";
      errvar = "&errvar";
      errval = &errval;
      errtxt = "&errtxt"; 
      errrating= &errrating;
      output errrpt;
      end;
%mend errrpt;

data errrpt(keep=dsn errvar errval errtxt errrating 
                 subject visit labdt);
   length dsn        $25
          errvar     $15
          errval     $25
          errtxt     $16
          errrating  8;
   set advrpt.lab_chemistry;
   if potassium lt 3.1 then do;
      %errrpt(dsn = advrpt.lab_chemistry,
              errvar = potassium,
              errval = potassium,
              errtxt = %str(Low value%(<3.1%)),
              errrating= 1)

   if potassium gt 6.7 then do;
      %errrpt(dsn = advrpt.lab_chemistry,
              errvar = potassium,
              errval = potassium,
              errtxt = %str(High value%(>6.7%)),
              errrating= 2)
   run;

proc print data=errrpt;
   run;
