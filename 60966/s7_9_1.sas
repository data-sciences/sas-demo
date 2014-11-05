* S7_9_1.sas
*
* Showing report wide totals on each page;

proc format;
   value $regname
     '1','2','3' = 'No. East'  
     '4'         = 'So. East'
     '5' - '8'   = 'Mid West' 
     '9', '10'   = 'Western';
   run;

title1 'Extending Compute Blocks';
title2 'Repeating Report Wide Totals';

proc report data=rptdata.clinics
            nowd;
   column region clinnum name  
            ('Patient'
            ('Weight' wt=wtn   wt) 
            ('Height' ht=htn   ht));  
   define region / group     format=$regname. noprint; 
   define clinnum/ group     noprint; 
   define name   / computed  ' ' right;   
   define wtn    / analysis  n 
                   format=2.  'N';
   define wt     / analysis  mean 
                   format=5.1 'Mean';
   define htn    / analysis  n 
                   format=2.  'N';
   define ht     / analysis  mean 
                   format=4.1 'Mean';

   break before region / summarize;  
   break after  region / page;  

   * Compute the Report totals;
   compute before;  
      * Hold values of interest in DATA step variables;
      allwtn = put(wtn,3.);
      allwt  = put(wt.mean,6.2);
      linevalwt = cats('Study Weights (',allwtn,',',allwt,')');
      allhtn = put(htn,3.);
      allht  = put(ht.mean,6.2);
      linevalht=  cats('Study Heights (',allhtn,',',allht,')');
   endcomp;

   * Write the overall statistics;
   compute before _page_;  
      line @15 '( N, MEAN )';
      line @1 linevalwt $35.;
      line @1 linevalht $35.;
      line ' ';
   endcomp;

   * Determine the line header;
   compute name / char length=8;  
      if clinnum = ' ' then name=put(region,$regname.);  
      else name = clinnum;
   endcomp;
   run;
