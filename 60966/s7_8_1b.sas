* S7_8_1b.sas
*
* Using the LINE statement
* An alternate approach;


proc format;
   value $regname
     '1','2','3' = 'No. East'  
     '4'         = 'So. East'
     '5' - '8'   = 'Mid West' 
     '9', '10'   = 'Western';
   run;

title1 'Extending Compute Blocks';
title2 'Using LINE for Group Totals';

* Show the use of an ALIAS for the statistic N;
proc report data=rptdata.clinics
            nowd split='*';
   column region n clinnum n=dispn;
   define region / group   format=$regname8.;
   define n      / noprint;
   define clinnum/ group   'Clinic*Number';
   * DISPN is an alias of N;
   define dispn  / width=7 'Patient*Count';
  
   compute before region;
      clincnt = 0;
      patcnt  = 0; 
   endcomp;

   compute clinnum;
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
      line ' '; 
      line ' ';
   endcomp;
   run;
