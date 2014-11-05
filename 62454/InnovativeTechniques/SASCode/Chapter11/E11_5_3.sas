* E11_5_3.sas
*
* Using Traffic lighting with PROC REPORT;

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


title1 '11.5.3a Traffic Lighting: REPORT';
title2 'Adverse Event List';
ods listing close;
ods pdf file="&path\results\E11_5_3a.pdf"
        style=journal;
proc report data=advrpt.ae(where=(sev>'1')) nofs;
   column subject aestdt ser sev aedesc;
   define subject / order;
   define aedesc / order;
   define aestdt / display;
   define ser / display
                style(column) ={background=$serious_b.
                                foreground=$serious_f.};
   define sev / display
                style(column) ={background=$severity_b.
                                foreground=$severity_f.};
    run;
ods pdf close;


title1 '11.5.3b Traffic Lighting: REPORT';
title2 'Adverse Event List';
ods listing close;
ods pdf file="&path\results\E11_5_3b.pdf"
        style=journal;
proc report data=advrpt.ae(where=(sev>'1')) nofs;
   column subject aestdt ser sev aedesc;
   define subject / order;
   define aedesc / order;
   define aestdt / display;
   define ser / display
                style(column) ={background=$serious_b.
                                foreground=$serious_f.};
   define sev / display;
   compute sev;
      if ser='YES' then 
        call define(_col_,
                    'style',
                    'style ={background=$severity_b.
                             foreground=$severity_f.}');
   endcomp;

   run;
ods pdf close;
