* S9_3_3b.sas
*
* Spanning headers in HTML;

ods listing;
ods html Path="&path\results\"
         body="ch9_3_3b.html"; 

title1 'Spanning Headers in HTML';
proc report data=rptdata.clinics nowd;
  column region sex ("<i> Weight <i>" wt,(n mean));
  define region / group;
  define sex    / across ;
  define wt     / analysis ;
  run;

ods html close;
