* S7_1_3c.sas
*
* Compute Process;
* Adding silly code to check event order;

* Percentage of visits;
Proc format;
   value $regname
     '1','2','3' = 'No. East'  
     '4'         = 'So. East'
     '5' - '8'   = 'Mid West' 
     '9', '10'   = 'Western';

title1 'Regional Patient Vists';
proc report data=rptdata.clinics 
            out=outreg nowd;
   column region n percnt;
   define region / group    format=$regname8.;
   define n      /          'Number of Visits';
   define percnt / computed format=percent9.2;

   rbreak after  / summarize;

   compute before ;
      totvisits = n;
   endcomp;

   compute percnt;
      percnt = n/totvisits;
      * Add two silly assignment statements to test order of
      * events.  Check the output data to see what happens;
      if totvisits = . then percnt=22;
      else if _break_ = '_RBREAK_' then percnt=4;
   endcomp;
   run;

proc print data=outreg;
run;
