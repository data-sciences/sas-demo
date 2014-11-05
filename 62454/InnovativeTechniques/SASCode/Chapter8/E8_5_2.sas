* E8_5_2.sas
*
* Using STYLE= with PRINT;

ods html style=journal
         file="&path\results\E8_5_2a.html";
title1 'Using STYLE= with PRINT';
title2 '8.5.2a on the PROC Statement';
proc print data=advrpt.demog(obs=5)
      style(col)= [background=cyan]
      style(header)= [background=yellow
                      font_weight=bold]
      style(obs)= [background=pink]
      style(obsheader)= [background=cyan]
      ;
   var clinnum subject sex dob;
   run;
ods html close;

ods html style=journal
         file="&path\results\E8_5_2b.html";
title1 'Using STYLE= with PRINT';
title2 '8.5.2b on Supporting  Statements';
proc print data=advrpt.demog(obs=5)
      style(col)= [background=cyan]
      style(header)= [background=yellow
                      font_weight=bold]
      ;
   id clinnum / style(hdr data)={background=blue
                                 foreground=white};
   var subject / style(header)={background=red
                                foreground=white}
                 style(column)={background=red
                                foreground=white};
   var sex dob edu;
   sum edu / style(grandtotal)={font_weight=bold
                                background=blue
                                foreground=white};
   run;
ods html close;
