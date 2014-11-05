* E3_1_6.sas
* 
* Look-Back using a double SET;

title1 '3.1.6 Double SET Statement Look-Back';
proc sort data=advrpt.lab_chemistry(keep=subject visit labdt potassium)
           out= labdates
           nodupkey;
   by subject labdt;
   run;

data BetweenPeaks(keep=subject visit labdt potassium);
   set labdates(keep=subject labdt potassium);
   by subject labdt;
   retain firstloc .
          found ' ';
   obscnt+1;
   if first.subject then do;
      found=' ';
      firstloc=.;
   end;
   if found=' ' and potassium ge 4.2 then do;
      if firstloc=. then firstloc=obscnt;
      else do;
         * This is the second find, write list;
         found='x';
         do point=firstloc to obscnt;
            set labdates(keep= subject visit labdt potassium) point=point;
            output betweenpeaks;
         end;
      end;
   end;
   run;
proc print data=betweenpeaks;
run;

