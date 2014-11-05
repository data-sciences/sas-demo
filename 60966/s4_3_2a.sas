* S4_3_2a.sas
*
* Splitting text headers in the DEFINE statement;
title1 'Only in LISTING';
title2 'Repeated Text and the SPLIT Option';
proc report data=rptdata.clinics 
            nowd split='*';  
  column region sex wt,(n mean);
  define region / group;
  define sex    / across   'Sex';
  define wt     / analysis 'Patient Weight*=(lb)=';  
  run;
