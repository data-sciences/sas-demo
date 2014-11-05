* S9_3_3c.sas
*
* Spanning headers in HTML;

ods listing;
ods html Path="&path\results\"
         body="ch9_3_3c.html"; 

title1 'Spanning Headers in HTML';
proc report data=rptdata.clinics nowd;
  * The / is seen as a split character;
  column region sex ("<i> Weight </i>" wt,(n mean));
  define region / group;
  define sex    / across ;
  define wt     / analysis ;
  run;

ods html close;
