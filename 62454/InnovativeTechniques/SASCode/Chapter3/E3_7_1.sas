* E3_7_1.sas
* 
* Inconsistent Joining Criteria;

title1 'Inconsistent Joining Criteria';
title2 '3.7.1a Incorrect Type';
data labnames;
   merge advrpt.demog(keep=subject lname fname)
         advrpt.lab_chemistry(keep=subject visit labdt
                              in=inlab);
   by subject;
   if inlab;
   run;

title2 '3.7.1b Converted Type';
data demog_c;
   set advrpt.demog(keep=subject lname fname
                     rename=(subject=ptid));
   subject = put(ptid,4.);
   run;

data labnames;
   merge demog_c(keep=subject lname fname)
         advrpt.lab_chemistry(keep=subject visit labdt
                              in=inlab);
   by subject;
   if inlab;
   run;

proc print data=labnames;
   run;

* Demonstrate inconsistent characteristics;
data pets(keep=lname fname pet);
   length lname $5;
   set advrpt.demog(keep=lname fname subject
                    rename=(lname=llname)
                    where=(subject le 104));
   lname = llname;
   if mod(subject,2)=0 then pet='Dog';
   else pet='Cat';
   run;

proc sort data=pets;
   by lname fname;
   run;
proc sort data=advrpt.demog(keep=subject lname fname symp)
          out=demogsymp;
   by lname fname;
   run;

data petsymptoms;
   merge pets(keep=lname fname pet) 
         demogsymp(keep=subject lname fname symp);
   by lname fname;
   run;

*****************************************************
* numeric values (similar or equal?);
data similar;
x = 1;
*y = 3.0000000000000001/3; /* close enough*/
y =  3.000000000000001/3;
if x=y then put 'the same';
put x= best32.;
put y= best32.;
put x= hex16.;
put y= hex16.;
run;
data other;
y=1; a='a';
run;
data both;
merge similar other;
by y;
run;
