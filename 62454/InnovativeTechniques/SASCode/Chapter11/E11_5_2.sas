* E11_5_2.sas
*
* Traffic lighting with TABULATE;

proc format;
   value MaxWT_f
      235-high  = 'white';
   value MaxWT_b
      235-high  = 'red';
   value MinWT_f
      low-<100  = 'white';
   value MinWT_b
      low-<100  = 'red';
   run;

title1 '11.5.2 Traffic Lighting: TABULATE';
title2 'Weight Compliance';
ods listing close;
ods pdf file="&path\results\E11_5_2.pdf"
        style=journal;
proc tabulate data=advrpt.demog(where=(clinnum in:('05','06')));
   class clinnum;
   var wt;
   table clinnum,
         wt*(min*{style={background=minwt_b.
                         foreground=minwt_f.}} 
             max*{style={background=maxwt_b.
                         foreground=maxwt_f.}});
   run;
ods pdf close;

