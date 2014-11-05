* S7_1_3b.sas
*
* Compute Process;
* Showing that item order DOES matter on the COLUMN statement;

* Percentage of visits;
proc format;
   value $regname
     '1','2','3' = 'No. East'  
     '4'         = 'So. East'
     '5' - '8'   = 'Mid West' 
     '9', '10'   = 'Western';
   run;

title1 'Regional Patient Vists';
proc report data=rptdata.clinics nowd;
   * The order of PERCNT and N are reversed.
   * This causes the assignment statement for PERCNT
   * to fail since N is to the right of PERCNT on the 
   * COLUMN statement;
   column region percnt n;
   define region / group    format=$regname8.;
   define n      /          'Number of Visits';
   define percnt / computed format=percent9.2;

   rbreak after  / summarize;

   compute before ;
      totvisits = n;
   endcomp;

   compute percnt;
      percnt = n/totvisits;
   endcomp;
   run;
