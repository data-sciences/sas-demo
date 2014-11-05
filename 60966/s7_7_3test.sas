* s7_7_3test.sas;
*
* Counting group and page breaks;

title1 'Extending Compute Blocks';
title2 'Counting Group and Page Breaks';

options ps=15;

proc report data=sashelp.shoes
            out=outdata
            nofs split='*';
   column region regname subsidiary sales rcnt pgcnt;  
   define region / group format=$regname.;  
   define subsidiary / group 'Subsidiary';  
   define sales     / analysis mean 
                      'Mean';

   compute before region;
      rname = region;
      * Initialize within region line counter;
      rcounter=0; 
      regname = 'w'; 
   endcomp;

   compute after _page_;  
      * Initialize within page line counter;
      pcounter=0;   
      regname='x';
   endcomp;

   compute regname / character length=12;  
      rcounter+1;
      pcounter+1;
      * Create region name at the start of region
      * and/or page;
      if rcounter=1 or pcounter=1 then regname = rname;
      regname='y';
   endcomp;

   compute rcnt;  
      rcnt = rcounter;
   endcomp;

   compute pgcnt;  
      pgcnt = pcounter;
      regname='z'; 
   endcomp;

   break after region/ suppress skip;
   run;

options ps=56;
proc print data=outdata;  
   run;
