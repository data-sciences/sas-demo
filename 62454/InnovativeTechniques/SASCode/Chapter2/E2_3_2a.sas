* E2_3_2a.sas
* 
* Collecting Date Errors;

title1 '2.3.2a Collecting Date Errors';

data medstartdates(keep=subject mednumber drug medstdt_ medstartdate)
     medstarterr(keep=subject mednumber drug medstdt_);
   set advrpt.conmed(keep=subject mednumber drug medstdt_);
   medstartdate = input(medstdt_,?? mmddyy10.);
   if medstartdate = . then output medstarterr;
   output medstartdates;
   run;

proc print data=medstarterr;
   run; 




