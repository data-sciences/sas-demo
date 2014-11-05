* S7_1_3a.sas
*
* Compute Process;

* Percentage of visits;
Proc format;
   value $regname
     '1','2','3' = 'No. East'  
     '4'         = 'So. East'
     '5' - '8'   = 'Mid West' 
     '9', '10'   = 'Western';

title1 'Regional Patient Vists';
proc report data=rptdata.clinics 
            out=regout nowd;
   column region n percnt;
   define region / group    format=$regname8.;
   define n      /          'Number of Visits';
   define percnt / computed format=percent9.2;

   rbreak after / summarize suppress;

   compute before ;
      totvisits = n;
   endcomp;

   compute percnt;
      percnt = n/totvisits;
   endcomp;
   run;

proc print data=regout;
run;
