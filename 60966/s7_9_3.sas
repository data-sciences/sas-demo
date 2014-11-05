* S7_9_3.sas
*
* Combining values under nested columns;

proc format;
   value $regname
     '1','2','3' = 'No. East'  
     '4'         = 'So. East'
     '5' - '8'   = 'Mid West' 
     '9', '10'   = 'Western';
   value $gender
      'm', 'M'  = 'Male'
      'f', 'F'  = 'Female';
   value birthgrp
      '01jan1945'd - '31dec1959'd = '   Boomer'  
      other                       = 'Non-Boomer';
   run;

title1 'Extending Compute Blocks';
title2 'Combining Values in ACROSS Columns';

proc report data=rptdata.clinics
            out=outreg  
            nowd;
   column region n sex,dob,  
          (wt=wtmean wt wtval);  
   define region / group  format=$regname. 'Area'; 
   define n      /        format=3.        ' N';  
   define sex    / across format=$gender.  ' ';
   define dob    / across format=birthgrp. ' ';
   define wtmean / analysis mean noprint;   
   define wt     / analysis std  noprint;
   define wtval  / computed ' Mean (SD)';  

   * Combine the WT values;  
   compute wtval / char length=12;  
      _c5_  = cats(put(_c3_,5.1),' (',  
                   put(_c4_,7.1),')');  
      _c8_  = cats(put(_c6_,5.1),' (',
                   put(_c7_,7.1),')');
      _c11_ = cats(put(_c9_,5.1),' (',
                   put(_c10_,7.1),')');
      _c14_ = cats(put(_c12_,5.1),' (',
                   put(_c13_,7.1),')');
   endcomp;
   run;

proc print data=outreg;
run;
