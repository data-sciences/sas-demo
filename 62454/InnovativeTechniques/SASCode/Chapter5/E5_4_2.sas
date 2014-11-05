*E5_4_2.sas
*
* Protecting Passwords;

data advrpt.passtab(encrypt=yes  pwreq=yes 
                    read=readpwd write=writepwd 
                    alter=chngpwd);
  format dsn uid pwd $8.;
  dsn='dbprod'; uid='mary'; pwd='wish2pharm'; output;
  dsn='dbprod'; uid='john'; pwd='data4you';   output;
  dsn='dbdev';  uid='mary'; pwd='hope2pharm'; output;
  run;
%let syslast=;
