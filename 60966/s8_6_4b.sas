* S8_6_4b.sas
*
* In-line formatting in formats;

ods listing close;
ods pdf style=printer
    file="&path\results\ch8_6_4b.pdf";
ods escapechar = '~';

proc format;
   value $genttl
      'f','F'='~S={font_weight=bold}F~S={font_weight=light}emale'
      'm','M'='~S={font_weight=bold}M~S={font_weight=light}ale';
   run;

title1 "Ages 11 - 16";
proc report data=sashelp.class nowd;
   columns sex height weight;
   define sex    / group format=$genttl.;
   define height / analysis mean
                   format=5.2
                   'Height';
   define weight / analysis mean
                   format=6.2
                   'Weight';
   rbreak after  / summarize;

   compute after;
      line @3 'Height(in.) Weight(lbs.)';
   endcomp;
   run;
ods pdf close;
