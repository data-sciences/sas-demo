* E3_3_5.sas
*
* Breaking up a data set into named subsets;
******************************************;


title1 '3.3.5 Building Data Subsets';
title2 'Brute Force Approach';

* determine the list of unique clinic numbers;
proc sort data=advrpt.demog out=clinlist(keep=clinnum) nodupkey;
   by clinnum;
   run;
proc print data=clinlist;
   run;

* Use the list to hard code the DATA step;
* These are only a few of the clinics;
data clin011234 clin014321 clin023910 clin024477;
   set advrpt.demog;
   if clinnum= '011234' then output clin011234;
   else if clinnum= '014321' then output clin014321;
   else if clinnum= '023910' then output clin023910;
   else if clinnum= '024477' then output clin024477;
   run;



******************************************;
title2 'Using the HASH Object';
title3 'Step Through Using Logic';

data _null_;
   if 0 then set advrpt.demog(keep=clinnum subject lname fname dob);
   * Hash ALL object to hold all the data;
   declare hash all (dataset: 'advrpt.demog', ordered:'Y') ;
      all.definekey ('clinnum','subject');
      all.definedata ('clinnum','subject','lname','fname','dob') ;
      all.definedone () ;
   declare hiter hall('all');

   * CLIN object holds one clinic at a time;
   declare hash clin;

   * define the hash for the first clinic; 
   clin = _new_ hash(ordered:'Y') ;
      clin.definekey ('clinnum','subject');
      clin.definedata ('clinnum','subject','lname','fname','dob') ;
      clin.definedone () ;

   * Read the first item from the full list;
   done=hall.first();
   lastclin = clinnum;

   do until(done);  *loop across all clinics;
      rc=clin.add();
      done = hall.next();
      if clinnum ne lastclin or done then do;
         * This is the first obs for this clinic or the very last obs;
         * write out the data for the previous clinic;
         rc=clin.output(dataset:'clin'||lastclin);
         * Delete the CLIN hash object;
         rc=clin.delete(); 
         clin = _new_ hash(ordered:'Y') ;
            clin.definekey ('clinnum','subject');
            clin.definedata ('clinnum','subject','lname','fname','dob') ;
            clin.definedone () ;
         lastclin=clinnum;
      end; 
   end;
   stop;
   run;

******************************************;
title2 'Using the HASH Object';
title3 'Step Through Using Logic';
title4 'Clear rather than delete the CLIN object';

data _null_;
   if 0 then set advrpt.demog(keep=clinnum subject lname fname dob);
   * Hash ALL object to hold all the data;
   declare hash all (dataset: 'advrpt.demog', ordered:'Y') ;
      all.definekey ('clinnum','subject');
      all.definedata ('clinnum','subject','lname','fname','dob') ;
      all.definedone () ;
   declare hiter hall('all');

   * CLIN object holds one clinic at a time;
   declare hash clin;

   * define the hash for the first clinic; 
   clin = _new_ hash(ordered:'Y') ;
      clin.definekey ('clinnum','subject');
      clin.definedata ('clinnum','subject','lname','fname','dob') ;
      clin.definedone () ;

   * Read the first item from the full list;
   done=hall.first();
   lastclin = clinnum;

   do until(done);  *loop across all clinics;
      rc=clin.add();
      done = hall.next();
      if clinnum ne lastclin or done then do;
         * This is the first obs for this clinic or the very last obs;
         * write out the data for the previous clinic;
         rc=clin.output(dataset:'clin'||lastclin);
         * Clear the CLIN hash object;
         rc=clin.clear();
         lastclin=clinnum;
      end; 
   end;
   stop;
   run;
