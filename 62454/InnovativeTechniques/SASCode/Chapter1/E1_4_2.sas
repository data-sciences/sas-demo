* E1_4_2.sas
*
* Writing delimited data with EXPORT;
title1 "1.4.2 Writing Delimited Data PROC EXPORT";
filename outspot "&path\data\E1_4_2demog.csv";

* This step does not give the desired results;
proc export data=advrpt.demog(keep=fname lname dob)
            outfile=outspot
            dbms=csv replace;
   delimiter=',';
   run;

*************************************
* Reduce the variables in a prior step;
data part;
   set advrpt.demog(keep=fname lname dob);
   run;
proc export data=part
            outfile=outspot
            dbms=csv replace;
   delimiter=',';
   run;
