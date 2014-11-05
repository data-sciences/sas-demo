* E3_3_6.sas
*
* Breaking up a data set into named subsets
* hash objects that point to hash objects;
******************************************;


title1 '3.3.6 Building Data Subsets';

******************************************;
title2 'Using the HASH Object to Load Hash objects';
title3 'Step Through Using Logic';

data _null_;

   * Hash object to hold just the HASHNUM pointers;
   declare hash eachclin(ordered:'Y');
      eachclin.definekey('clinnum');
      eachclin.definedata('clinnum','hashnum');
      eachclin.definedone ();
   declare hiter heach('eachclin');

   * Declare the HASHNUM object;
   declare hash hashnum;

   do until(done);
      set advrpt.demog(keep=clinnum subject lname fname dob) end=done;
      * Determine if this clinic number has been seen before;
      if  eachclin.check() then do;
         * This is the first instance of this clinic number;
         * create a hash table for this clinic number;
         hashnum = _new_ hash(ordered:'Y');
            hashnum.definekey ('clinnum','subject');
            hashnum.definedata ('clinnum','subject','lname','fname','dob');
            hashnum.definedone ();
         * Add to the overall list;
         rc=eachclin.replace();
      end;
      * Retrieve this clinic number and its hash number;
      rc=eachclin.find();
      * Add this observation to the the hash table for this clinic.;
      rc=hashnum.replace();
   end;

   * Write the individual data sets;
   * There will be one data set for each clinic;
   do while(heach.next()=0);
      * Write the observations associated with this clinic;
      rc=hashnum.output(dataset:'clinic'||clinnum);
   end;
   stop;
   run;
