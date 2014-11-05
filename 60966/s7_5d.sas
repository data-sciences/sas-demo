* S7_5d.sas
*
* Using CALL DEFINE;

proc format;
   value $regname
     '1','2','3' = 'No. East'  
     '4'         = 'So. East'
     '5' - '8'   = 'Mid West' 
     '9', '10'   = 'Western';
   value $gender
     'M'='Male' 
     'F'='Female';
   run;
   
title1 'Extending Compute Blocks';
title2 'Mean Weight';
title3 'Using CALL DEFINE to Format a column';

proc report data=rptdata.clinics nowd;
   column region sex,wt,(n mean);
   define region / group   format=$regname.;
   define sex    / across  format=$gender6. 'Gender' ;
   define wt     / analysis                 ' ';
   compute wt;
      call define('_c2_','format','2.');
      call define('_c3_','format','5.1');
      call define('_c4_','format','2.');
      call define('_c5_','format','5.1');
   endcomp;
   run;
