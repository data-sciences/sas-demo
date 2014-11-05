* S8_6_2b.sas
*
* Displaying page numbers;

ods listing close;

ods pdf style=printer
        file="&path\results\ch8_6_2b.pdf";
ods rtf style=rtf
        file="&path\results\ch8_6_2b.rtf"
        bodytitle;

ods escapechar='~';
proc sort data=sashelp.prdsale
          out=prdsale;
   by prodtype region;
   run;

options nobyline;
title1 '#byval1';
title2 'In the Title: Page ~{thispage} out of ~{lastpage} ';
footnote1;

proc report data=prdsale
            nowd;
   by prodtype;
   column prodtype region product,actual;
   define prodtype / group page;
   define region  / group ;
   define product / across;
   define actual  / analysis sum
                    format=dollar8.
                    'Sales';
   compute after _page_;
      line @3 'Page ~{thispage} out of ~{lastpage} ';
   endcomp;
   rbreak after / summarize;
   run;
ods _all_ close;
