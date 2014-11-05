* E3_1_2.sas
* 
* Using ARRAYs to process across observations;

title1 '3.1.2 Using ARRAYs to process across observations';
title2 'Mean time between nominal visits';
data labvisits(keep=subject count meanlength);
   set advrpt.lab_chemistry;
   by subject;

   array Vdate {16} _temporary_;
   retain totaldays count 0;

   * initialize;
   if first.subject then do;
      totaldays=0;
      count = 0;
/*      call missing(of vdate{*});*/  *alternate to clear array;
      do i = 1 to 16;
         vdate{i}=.;
      end;
   end;

   * Load each visit into the array;
   vdate{visit} = labdt;

   * process this subject;
   if last.subject then do;
      do i = 1 to 15;
         between = vdate{i+1}-vdate{i};
         if between ne . then do;
            totaldays = totaldays+between;
            count = count+1;
         end;
      end;
      meanlength = totaldays/count;
      output;
   end;
   run;

proc print data=labvisits;
   run;

****************************************************;   
title2 'Mean time between observed (actual) visits';
data labvisits(keep=subject count meanlength);
   set advrpt.lab_chemistry;
   by subject;

   array Vdate {16} _temporary_;
   retain totaldays count lastdate 0;

   if first.subject then do;
      totaldays=0;
      count = 0;
      lastdate = .;
      call missing(of vdate{*});
   end;

   vdate{visit} = labdt;

   if last.subject then do;
      lastdate=vdate{1};
      do i = 2 to 16;
         between = vdate{i}-lastdate;
         if between ne . then do;
            totaldays = totaldays+between;
            count = count+1;
            lastdate=vdate{i};
         end;
         else if vdate{i} ne . then lastdate=vdate{i};
      end;
      meanlength = totaldays/count;
      output;
   end;
   run;

proc print data=labvisits;
   run;
