* S10_1_3b.sas
*
* Decimal Alignment;

ods listing;
ods rtf file="&path\results\ch10_1_3b.rtf"
        style=rtf;
ods pdf file="&path\results\ch10_1_3b.pdf"
        style=printer;

data test;
   length x $ 10;
   x="5.1";   output;
   x='9.99';  output;
   x='100.1'; output;
   x='1001'; output;
   run;

title1 'Common REPORT Problems';
title2 'Vertically Concatenated Tables';
title3 'Decimal Point Alignment';

proc report data=test nowd;
   column x x=new;
   define x   / display 
                style={cellwidth=1in just=dec}
                'Using Just=' ;
   define new / display ;
   run;


ods _all_ close;
