* S9_3_3a.sas
*
* Spanning headers in HTML;

ods html file="&path\results\ch9_3_3a.html"; 

title1 'Spanning Headers in HTML';
proc report data=rptdata.clinics nowd;
  column region sex ('_ wt(lb) _' wt,(n mean));
  define region / group;
  define sex    / across;
  define wt     / analysis;
  run;

ods html close;
