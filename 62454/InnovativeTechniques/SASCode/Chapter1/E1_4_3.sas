* E1_4_3.sas
*
* Using the DS2CSV macro;

title1 '1.4.3 Writing Delimited Data Using %DS2CSV';

data part;
   set advrpt.demog(keep=fname lname dob);
   run;
 
%ds2csv(data=part, 
        runmode=b, 
        labels=n,
        csvfile=&path\data\E1_4_3demog.csv) 
