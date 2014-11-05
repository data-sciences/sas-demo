* E6_8.sas
*
* Table lookups - Using the Hash object.;

title1 'Using the Hash Object';

data hashnames(keep=subject clinnum clinname lname fname);

   * Define the attributes for variables on lookup table;
   if 0 then set advrpt.clinicnames;

   * Create and load the hash object;
   declare hash lookup(dataset: 'advrpt.clinicnames', 
                       hashexp: 8);
   lookup.defineKey('clinnum'); 
   lookup.defineData('clinname'); 
   lookup.defineDone(); 

   * Read the primary data;
   do until(done);
      set  advrpt.demog(keep=subject clinnum lname fname)
           end=done; 
      if lookup.find() = 0 then output hashnames; 
   end;
   stop;
   run;
************************************************************
** alternate DATA step
** simpler code, less efficient?;
data hashnames(keep=subject clinnum clinname lname fname);
   if _n_= 1 then do;
      * Define the attributes for variables on lookup table;
      if 0 then set advrpt.clinicnames; 

      * Create and load the hash object;
      declare hash lookup(dataset: 'advrpt.clinicnames', 
                          hashexp: 8);
      lookup.defineKey('clinnum'); 
      lookup.defineData('clinname');
      lookup.defineDone(); 
   end;

   * Read the primary data;
   set advrpt.demog(keep=subject clinnum lname fname); 
   if lookup.find() = 0 then output hashnames;
run;
