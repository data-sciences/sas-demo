* E2_1_2.sas
* 
* Password protection for data tables;

title1 '2.1.2 Password protection';

data advrpt.pword(encrypt=yes pwreq=yes read=readpwd write=writepwd);
   DB='DEApp'; UID='MaryJ'; pwd='12z3'; output;
   DB='p127';  UID='Mary';  pwd='z123'; output;
   run;

proc print data=advrpt.pword;
  run;
