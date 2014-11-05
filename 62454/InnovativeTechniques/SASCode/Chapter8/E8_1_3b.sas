* E8_1_3b.sas
*
* Using STYLE= with TABULATE;

ods html style=journal
         path="&path\results"
         body='E8_1_3b.html';
title1 '8.1.3b TABULATE Using the Journal Style';
title2 'Various STYLE= Attributes Have Been Changed';
proc tabulate data=advrpt.demog;
   class race / style={font_style=roman};
   classlev race / style={just=center};
   var ht wt  / style={font_weight=bold
                       font_size=4};
   table race='(encoded)',
         (ht wt)*(n*f=2.*{style={font_weight=bold 
                                 font_face='times new roman'}}
                  min*f=4. median*f=7.1 max*f=4.)
         /rts=6 
          box={label='Race'
               style={background=grayee}};
   keyword n / style={font_weight=bold};
   run;
ods html close;
