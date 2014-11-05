* S10_5_1.sas
*
* Using ODS Layout;


ods pdf style=printer
        file="&path\results\ch10_5_1.pdf";

ods layout start;

ODS region x=.5in y=.1in width=7in height=10in;
title1 'Common REPORT Problems';
title2 f=swissb 'Multiple Reports on a Page';
title3 f='times new roman' 'Using ODS Layout';
title4 f=swiss '      Office                 Furniture';
proc gslide;
   run;

ods region x=1in y=1.85in width=3in height=4in;
title1;
proc report data=sashelp.prdsale(where=(prodtype='OFFICE')) 
            nowd;
   column country product,actual;
   define country / group;
   define product / across;
   define actual  / analysis sum 
                    format=dollar8. 
                    'Sales';
   run;

ods region x=5in y=1.85in width=3in height=4in;
proc report data=sashelp.prdsale(where=(prodtype='FURNITURE')) 
            nowd;
   column country product,actual;
   define country / group;
   define product / across;
   define actual  / analysis sum 
                    format=dollar8. 
                    'Sales';
   run;

ods layout end;
ods _all_ close;

