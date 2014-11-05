* S7_8_2a.sas
*
* Using LINE to add repeated text;

proc format;
   value $regname
     '1','2','3' = 'No. East'  
     '4'         = 'So. East'
     '5' - '8'   = 'Mid West' 
     '9', '10'   = 'Western';
   run;

title1 'Extending Compute Blocks';
title2 'Using LINE to Add Repeated Text';

ods pdf  file="&path\results\s7_8_2a.pdf" 
         style=printer;
ods html path = "&path\results"
         body = 'ch7_8_2a.html'
         style= minimal;
proc report data=rptdata.clinics
            nowd split='*';
   column region clinnum n;
   define region / group   format=$regname8.;
   define clinnum/ group   'Clinic*Number';
   define n      / width=7 'Patient*Count';
  
   compute before;
      line @3 8*'______';
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
      line @5 'Total of ' clincnt 3. ' clinics is ' clinpct percent8.1 ' of target';
      line @5 'Patient enrollment is ' patcnt 4.;
      line @5 'Per clinic this is ' patpct percent8.1 ' of target'; 
      line @3 8*'------';
      line ' ';
   endcomp;
   run;
ods html close;
ods pdf close;
