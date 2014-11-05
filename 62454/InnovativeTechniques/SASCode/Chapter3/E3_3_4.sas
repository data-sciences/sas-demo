* E3_3_4.sas
*
* Steping through a HASH table.;
******************************************;

title1 '3.3.4 Steping through a HASH table';

******************************************;
title2 'Using FIND with Incremented the Keys';
title3 'Assumes that the CONMED table is sorted by subject';
data drugEvents(keep=subject medstdt drug aestdt aedesc sev);
   declare hash meds(ordered:'Y') ;
      meds.definekey ('subject', 'counter');
      meds.definedata('subject', 'medstdt','drug','counter') ;
      meds.definedone () ;

   * Load the medication data into the hash object;
   do until(allmed);
      set advrpt.conmed(keep=subject medstdt drug) end=allmed;
      by subject;
      if first.subject then counter=0;
      counter+1;
      rc = meds.add();
   end;

   do until(allae);
      set advrpt.ae(keep=subject aedesc aestdt sev) end=allae;
      counter=1;
      rc=meds.find();
      do while(rc=0);
         * Was this drug started within 5 days of the AE?;
         * Use this PUT to observe the process as it steps through the hash table.;
         * put subj= counter= medstdt= subject= aestdt=;
         if (0 le aestdt - medstdt lt 5) then output drugevents;
         counter+1;
         rc=meds.find();
      end;       
   end;
   stop;
   run;

proc print data=DrugEvents;
   run;

******************************************;
title2 'Using FIND with Incremented the Keys';
title3 'Does not Assume an incoming sort order';
data drugEvents(keep=subject medstdt drug aestdt aedesc sev);
   * define a hash table to hold the subject counter;
   declare hash subjcnt(ordered:'y');
      subjcnt.definekey('subject');
      subjcnt.definedata('counter');
      subjcnt.definedone();

   declare hash meds(ordered:'Y') ;
      meds.definekey ('subject', 'counter');
      meds.definedata('subject', 'medstdt','drug','counter') ;
      meds.definedone () ;

   * Load the medication data into the hash object;
   do until(allmed);
      set advrpt.conmed(keep=subject medstdt drug) end=allmed;
      * Check subject counter: initialize if not found, otherwise increment;
      if subjcnt.find() then counter=1;
      else counter+1;
      * update the subject counter hash table;
      rc=subjcnt.replace();
      * Use the counter to add this row to the meds hash table;
      rc=meds.add();
   end;

   do until(allae);
      set advrpt.ae(keep=subject aedesc aestdt sev) end=allae;
      counter=1;
      rc=meds.find();
      do while(rc=0);
         * Was this drug started within 5 days of the AE?;
         * Use this PUT to observe the process as it steps through the hash table.;
         * put subj= counter= medstdt= subject= aestdt=;
         if (0 le aestdt - medstdt lt 5) then output drugevents;
         counter+1;
         rc=meds.find();
      end;       
   end;
   stop;
   run;

proc print data=DrugEvents;
   run;


******************************************;
title2 'Using the HASH Iterator Object';
data drugEvents(keep=subject medstdt drug aestdt aedesc sev);
   declare hash meds(ordered:'Y') ;
      declare hiter medsiter('meds');
      meds.definekey ('subj', 'counter');
      meds.definedata('subj', 'medstdt','drug','counter') ;
      meds.definedone () ;

   * Load the medication data into the hash object;
   do until(allmed);
      set advrpt.conmed(keep=subject medstdt drug) end=allmed;
      by subject;
      if first.subject then do;
         counter=0;
         subj=subject;
      end;
      counter+1;
      rc=meds.add();
   end;

   do until(allae);
      set advrpt.ae(keep=subject aedesc aestdt sev) end=allae;
      rc = medsiter.first();
      do until(rc);
         * Was this drug started within 5 days of the AE?;
         if subj = subject and (0 le aestdt - medstdt lt 5) then output drugevents;
         if subj gt subject then leave;
         rc=medsiter.next();
      end;       
   end;
   stop;
   run;

proc print data=DrugEvents;
   run;
