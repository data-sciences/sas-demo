* S10_5_3.sas
*
* Using startpage=never;


ods rtf style=rtf
         file="&path\results\ch10_5_3.rtf"
         bodytitle
         startpage=never;

ods pdf style=printer
         file="&path\results\ch10_5_3.pdf"
         startpage=never;


title1 'Common REPORT Problems';
title2 'Multiple Reports on a Page';
title3 'Product Sales';

proc report data=sashelp.prdsale 
            nowd;
   column country product,actual;
   define country  / group;
   define product  / across;
   define actual   / analysis sum 
                     format=dollar8. 
                     ' ';
   run;

title3 'Shoe Sales';
proc report data=sashelp.shoes(where=(region  in:('Cana', 'West', 'United') &
                                      product in:('Men',  'Boot', 'Sport'))) 
            nowd;
   column region product,sales;
   define region     / group;
   define product    / across;
   define sales      / analysis sum 
                       format=dollar8. 
                       ' ';
   run;

ods _all_ close;

