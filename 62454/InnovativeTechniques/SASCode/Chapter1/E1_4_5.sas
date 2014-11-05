*E1_4_5.sas
*
* Writing delimited data;
title1 "1.4.5 Writing Delimited Data with the DATA Step";

********************************;
filename csv_a "&path\data\E1_4_5a.csv";
title2 'Specify the Delimiter in the PUT';
data _null_;
   set advrpt.demog(keep=fname lname dob);
   file csv_a;
   if _n_=1 then put 'FName,LName,DOB';
   put (_all_)(',');
   run;

********************************;
filename csv_b "&path\data\E1_4_5b.csv";
title2 'Specify the Delimiter in the PUT';
data _null_;
   set advrpt.demog(keep=fname lname dob);
   file csv_b dsd;
   if _n_=1 then put 'FName,LName,DOB';
   put (_all_)(?);
   run;
