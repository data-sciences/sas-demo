* S7_8_2b.sas
*
* Using LINE to add repeated text;

* Base the line width on the width of the page;
* Show width based on LS;
* The %LET statement could be anywhere earlier in program;
%let pgwidth = %eval(%sysfunc(getoption(LS)) - 4);

proc format;
   value $regname
     '1','2','3' = 'No. East'  
     '4'         = 'So. East'
     '5' - '8'   = 'Mid West' 
     '9', '10'   = 'Western';
   run;

title1 'Extending Compute Blocks';
title2 'Using LINE to Add Repeated Text';

ods html path = "&path\results"
         body = 'ch7_8_2b.html'
         style= minimal;
proc report data=rptdata.clinics
            nowd split='*';
   column region clinnum n;
   define region  / group   format=$regname8.;
   define clinnum / group   'Clinic*Number';
   define n       / width=7 'Patient*Count';
  
   compute before;
      * Determine line length using two different methods;
      line @3 &pgwidth*'_';
      * Use GETOPTION without macro variables.;
      str=repeat('_',getoption('LS') - 5);
      line @3 str $;
      line ' ';
   endcomp;
   compute before region;
      clincnt = 0;
      patcnt  = 0; 
   endcomp;

   compute n;
      if _break_= ' ' then do;
         patcnt  + n;
         clincnt + 1;
      end;
   endcomp;

   compute after region;
      clinpct = clincnt/8;
      patpct = patcnt/clincnt/5;
      line @25 'Total of ' clincnt 3. ' clinics is ' clinpct percent8.1 ' of target';
      line @5 'Patient enrollment is ' patcnt 4.;
      line @5 'Per clinic this is ' patpct percent8.1 ' of target'; 
      line @3 8*'------';
      line ' ';
   endcomp;
   run;
ods html close;
