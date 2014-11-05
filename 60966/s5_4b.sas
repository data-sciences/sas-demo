* S5_4b.sas
*
* Using _PAGE_ with the compute block;
title1 'Using the COMPUTE Block';
title2 'Using BEFORE _PAGE_';
proc report data=rptdata.clinics 
            nowd ps=22;
  column region sex wt,(n mean);
  define region / group format=$6.;
  define sex    / group format=$6. 'Gender';
  define wt     / analysis;
  compute after region;
    line ' ';
  endcomp;
  compute before _page_;
    line @10 'Weight taken during';
    line @10 'the entrance exam.';
  endcomp;
  run;
