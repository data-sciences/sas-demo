* E2_3_2b.sas
*
* Error Exception Reporting;

title1 '2.3.2b Hardcoded Exception Reporting';

data errrpt(keep=dsn errvar errval errtxt errrating 
                 subject visit labdt);
   length dsn        $25
          errvar     $15
          errval     $25
          errtxt     $20
          errrating  8;
   set advrpt.lab_chemistry;
   if potassium lt 3.1 then do;
      dsn = 'advrpt.lab_chemistry';
      errvar = 'potassium';
      errval = potassium;
      errtxt = 'Low value(<3.1)';
      errrating= 1;
      output errrpt;
      end;
   if potassium gt 6.7 then do;
      dsn = 'advrpt.lab_chemistry';
      errvar = 'potassium';
      errval = potassium;
      errtxt = 'High value(>6.7)';
      errrating=2;
      output errrpt;
      end;
   run;

proc print data=errrpt;
   run;
