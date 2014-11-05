* E11_5_4.sas
*
* Traffic Lighting in Proc PRINT;

title1 '11.5.4 Traffic Lighting Using PROC PRINT';
title2 'Severe Adverse Events';

proc format;
   value $serious_f
      'YES','yes' = 'white';
   value $serious_b
      'YES','yes' = 'red';
   value $severity_f
      '3' = 'black'
      '4','5'= 'white';
   value $severity_b
      '3' = 'yellow'
      '4','5'= 'red';
   run;


ods pdf style=journal
        file="&path\results\E11_5_4.pdf";
proc print data=advrpt.ae(where=(sev>'1'));
   by subject;
   id subject;
   var aestdt ;
   var ser / style(column)={background=$serious_b.
                            foreground=$serious_f.};
   var sev / style(column)={background=$severity_b.
                            foreground=$severity_f.};
   run;
ods pdf close;
