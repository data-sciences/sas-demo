* E12_5_2.sas
* 
* Using Nested Formats;

title1 '12.5.2 Nesting Multiple Levels';

***********************************************

********************************************
* 12.5.2
* nesting multiple levels;
proc format;
   value agegrps
      low - 40  = 'Out of Range'
      40 - <48  = 'Secondary'
      48 -  52  = 'Primary'
      52<-  65  = 'Secondary'
      65<- high = 'Out of Range'
      other = 'Unknown';
   run;

proc format;
   value primary
      48 -  52  = 'Primary'
      other = [second.];
   value second
      40 - 65   = 'Secondary'
      other = [OOR.];
   value oor
      low - high = 'Out of Range'
      other = 'Unknown';
   run;

data demog(keep=subject dob);
   set advrpt.demog(rename=(subject=Nsubject));
   subject=left(put(nsubject,3.));
   run;
data startage(keep=subject dob labdt startage agegroup ageprime);
   merge demog(keep=subject dob)
         advrpt.lab_chemistry(keep=subject visit labdt
                              where=(visit=1)
                              in=inlab);
   by subject;
   if inlab;
   startage = yrdif(dob,labdt,'actual');
   agegroup = put(startage,agegrps.);
   ageprime = put(startage,primary.);
   run;

proc print data=startage;
   run;
