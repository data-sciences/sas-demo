* S8_6_4a.sas
*
* In-line formatting in the TITLE and FOOTNOTE;

ods listing close;
ods pdf style=printer
    file="&path\results\ch8_6_4a.pdf";
ods escapechar = '~';

title1 "~S={font_face=Arial}Ages "
       "~S={font_style=roman}11 - 16";
proc report data=sashelp.class nowd;
   columns sex height weight;
   define sex    / group;
   define height / analysis mean
                   format=5.2
                   'Height';
   define weight / analysis mean
                   format=6.2
                   'Weight';
   rbreak after  / summarize;

   compute after;
      line @3 '~S={font_weight=bold}Height(in.)'
              '~S={font_weight=light}Weight(lbs.)';
   endcomp;
   run;
ods pdf close;
