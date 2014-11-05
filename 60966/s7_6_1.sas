* S7_6_1.sas
*
* Compute statement justification options;

option nocenter;
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
 
ods html file="&path\results\ch7_6_1.html";
 
title1 'Extending Compute Blocks';
title2 'Using Justification Options';
proc report data=rptdata.clinics nowd;
   column region sex ('Weight' wt wt=wtmean);
   define region / group    format=$regname8.;
   define sex    / group    format=$gender. 
                   'Gender';
   define wt     / analysis format=3. 
                   n 'N' ;
   define wtmean / analysis format=5.1 
                   mean 'Mean';
   compute after region;
     line ' ';
   endcomp;
   compute before _page_ / left;
     line 'Weight taken during';
     line 'the entrance exam.';
   endcomp;
   run;
ods html close;
