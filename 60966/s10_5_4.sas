* S10_5_4.sas
*
* Aligning cells across reports;

ods pdf style=printer
         file="&path\results\ch10_5_4.pdf"
         startpage=never;


title1 'Common REPORT Problems';
title2 'Multiple Reports on a Page';
title3 'Aligned Columns';

proc report data=sashelp.prdsale 
            nowd;
   column country product,actual;
   define country  / group  style(column)={cellwidth=25mm};
   define product  / across ;
   define actual   / analysis sum 
                     style(column)={cellwidth=20mm}
                     format=dollar8. 
                     ' ';
   run;

proc report data=sashelp.shoes(where=(region  in:('Cana', 'West', 'United') &
                                      product in:('Men',  'Boot', 'Sport'))) 
            nowd;
   column region product,sales;
   define region     / group  style(column)={cellwidth=25mm};
   define product    / across;
   define sales      / analysis sum 
                       style(column)={cellwidth=20mm}
                       format=dollar8. 
                       ' ';
   run;

ods _all_ close;

