* S8_6_2a.sas
*
* Displaying page numbers;

ods listing close;

ods rtf style=rtf
        file="&path\results\ch8_6_2a.rtf"
        bodytitle;

* Include PDF destination to show that the {pageof} does NOT work;
ods pdf style=printer
        file="&path\results\ch8_6_2a.pdf";

ods escapechar='~';
proc sort data=sashelp.prdsale
          out=prdsale;
   by prodtype region;
   run;

option nobyline;
title1 '#byval1';
footnote1;

proc report data=prdsale
            nowd;
   by prodtype;
   column region product,actual;
   define region  / group ;
   define product / across;
   define actual  / analysis sum
                    format=dollar8.
                    'Sales';
   compute after _page_;
      line @3 'Page ~{pageof}';
   endcomp;
   rbreak after / summarize;
   run;
ods _all_ close;
