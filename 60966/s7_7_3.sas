* s7_7_3.sas;
*
* Counting group and page breaks;

proc format;
   value $regname
     '1','2','3' = 'No. East'  
     '4'         = 'So. East'
     '5' - '8'   = 'Mid West' 
     '9', '10'   = 'Western';
   run;

title1 'Extending Compute Blocks';
title2 'Counting Group and Page Breaks';

options ps=15;

proc report data=rptdata.clinics
            out=outreg
            nowd split='*';
   column region regname clinnum 
            ('Patient*Weight' wt=wtn wt) rcnt pgcnt;  
   define region / group format=$regname. noprint;  
   define regname/ computed 'Region';  
   define clinnum/ group 'Clinic*Number';
   define wtn    / analysis n 
                   format=1. 'N';
   define wt     / analysis mean 
                   format=4. 'Mean';

   compute before region;
      rname = put(region,$regname.);
      * Initialize within region line counter;
      rcounter=0;  
   endcomp;

   compute after _page_;  
      * Initialize within page line counter;
      pcounter=0;  
   endcomp;

   compute regname / character length=12;  
      rcounter+1;
      pcounter+1;
      * Create region name at the start of region
      * and/or page;
      if rcounter=1 or pcounter=1 then regname = rname;  
   endcomp;

   compute rcnt;  
      rcnt = rcounter;
   endcomp;

   compute pgcnt;  
      pgcnt = pcounter;
   endcomp;

   break after region/ suppress skip;
   run;

options ps=56;
proc print data=outreg;  
   run;
