* S7_7_1a.sas
*
* Using the SUM statement.;

proc format;
   value $regname
     '1','2','3' = 'No. East'  
     '4'         = 'So. East'
     '5' - '8'   = 'Mid West' 
     '9', '10'   = 'Western';
   run;

title1 'Extending Compute Blocks';
title2 'Using the SUM Statement';

proc report data=rptdata.clinics
                     (where=(region in('1' '2' '3' '4')))
            nofs split='*';
   column region cnt clinnum ('   Patient' wt=wtn wt);
   define region / group format=$regname.;
   define cnt    / computed ' ';  
   define clinnum/ group 'Clinic*Number';
   define wtn    / analysis n 'N';
   define wt     / analysis mean 
                   format=6. 'Mean*Weight';

   compute before region;
      clincount=0;  
   endcomp;
   compute before clinnum;
      clincount+1;  
   endcomp;
   compute cnt;
      cnt=clincount;  
   endcomp;

   break after region/ suppress skip;
   run;
