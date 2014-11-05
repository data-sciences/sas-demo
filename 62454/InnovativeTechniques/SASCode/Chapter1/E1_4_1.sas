*E1_4_1.sas
*
* Writing delimited data;
title1 "1.4.1 Writing Delimited Data with the DATA Step";
filename outspot "&path\data\E1_4_1demog.csv";

data _null_;
   set advrpt.demog(keep=fname lname dob);
   file outspot dlm=',' dsd;
   if _n_=1 then put 'FName,LName,DOB';
   put fname lname dob mmddyy10.;
   run;
