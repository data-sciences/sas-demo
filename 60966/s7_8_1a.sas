* S7_8_1a.sas
*
* Doing more with the LINE statement;

* Build format for regional areas.;
proc format;
   value $regname
     '1','2','3' = 'No. East'  
     '4'         = 'So. East'
     '5' - '8'   = 'Mid West' 
     '9', '10'   = 'Western';
   run;

title1 'Extending Compute Blocks';
title2 'Using LINE for Group Totals';

proc report data=rptdata.clinics
            nowd split='*';
   column region clinnum n;
   define region  / group   format=$regname8.;
   define clinnum / group   'Clinic*Number';
   define n       / width=7 'Patient*Count';
  
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
      * Target 8 clinics per regional area;
      clinpct = clincnt/8;
      * Target recruitment is 5 patients per clinic per area;
      patpct = patcnt/clincnt/5;
      line @5 'Total of ' clincnt 3. ' clinics is ' clinpct percent8.1 ' of target';
      line @5 'Patient enrollment is ' patcnt 4.;
      line @5 'Per clinic this is ' patpct percent8.1 ' of target'; 
      line ' '; 
      line ' ';
   endcomp;
   run;
