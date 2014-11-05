* E2_9_5.sas
*
* Eliminating duplicates using the HASH object;
******************************************;

title1 '2.9.5 Using the Hash Object';
title2 'Eliminating Duplicate KEY Values';
data _null_;
   if _n_=1 then do;
      declare hash chem (ordered:'Y') ;
      chem.definekey ('subject', 'visit');
      chem.definedata ('subject', 'visit','labdt') ;
      chem.definedone () ;
   end;
   set advrpt.lab_chemistry end=eof;
   rc = chem.replace();
   if eof then chem.output(dataset:'nokeydups');
   run;
proc print data=Nokeydups;
   run;

******************************************;
title2 'Eliminating Duplicate Observations';
data _null_;
   if _n_=1 then do;
      declare hash chem (ordered:'Y') ;
      chem.definekey ('subject', 'visit','labdt', 'sodium', 'potassium', 'chloride');
      chem.definedata('subject', 'visit','labdt', 'sodium', 'potassium', 'chloride') ;
      chem.definedone () ;
   end;
   set advrpt.lab_chemistry end=eof;
   rc = chem.replace();
   if eof then chem.output(dataset:'nodups');
   run;
proc print data=NOdups;
   run;

* An alternate more efficient DATA step;
data _null_;
   declare hash chem (ordered:'Y') ;
   chem.definekey ('subject', 'visit','labdt', 'sodium', 'potassium', 'chloride');
   chem.definedata('subject', 'visit','labdt', 'sodium', 'potassium', 'chloride') ;
   chem.definedone () ;
   do until(eof);
      set advrpt.lab_chemistry end=eof;
      rc = chem.replace();
   end;
   chem.output(dataset:'nodups');
   stop;
   run;
proc print data=NOdups;
   run;

******************************************;
* Using the LENGTH statement to set the attributes and the 
* MISSING method to initialize the variables;
title2 'Using the Hash Object To Eliminate Duplicate Observations';
data _null_;
   length subject $3
          visit    8
          labdt    8
          sodium potassium chloride 8;
   declare hash chem (dataset:'advrpt.lab_chemistry', ordered:'Y') ;
   chem.definekey ('subject', 'visit','labdt', 'sodium', 'potassium', 'chloride');
   chem.definedata('subject', 'visit','labdt', 'sodium', 'potassium', 'chloride') ;
   chem.definedone () ;
   call missing(subject,visit,labdt, sodium, potassium,chloride);
   chem.output(dataset:'nodups');
   run;
proc print data=NOdups;
   run;

* Using a dummy SET statement;
title2 'Using the Hash Object To Eliminate Duplicate Observations';
data _null_;
   if 0 then set advrpt.lab_chemistry(keep= subject visit labdt
                                            sodium potassium chloride);
   declare hash chem (dataset:'advrpt.lab_chemistry', ordered:'Y') ;
   chem.definekey ('subject', 'visit','labdt', 'sodium', 'potassium', 'chloride');
   chem.definedata('subject', 'visit','labdt', 'sodium', 'potassium', 'chloride') ;
   chem.definedone () ;
   chem.output(dataset:'nodups');
   stop;
   run;
proc print data=NOdups;
   run;
