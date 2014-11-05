*E11_3_3.sas
*
* Using escape characters and in-line formatting;

ods escapechar='~';

ods pdf file="&path\results\E11_3_3a.pdf"
        style=journal;
title1  '11.3.3a In-line Formatting';
title2 '~S={font_face="times new roman"}Initial' 
       '~S={font_style=roman} Coded'
       '~S={} Symptoms';
proc report data=advrpt.demog nowd split='*';
   column symp wt ht;
   define symp / group 'symptom' order=data;
   define wt   / analysis mean format=6.1 'Weight~{super 1}';
   define ht   / analysis mean format=6.1 'Height~{super 2}';
   compute after;
      line @3 '~{super 1}~S={font_weight=bold}Pounds';
      line @3 '~{super 2}~S={font_weight=light}Inches';
   endcomp;
   run;
ods _all_ close;

************************************************;
ods pdf file="&path\results\E11_3_3b.pdf"
        style=journal;
title1  '11.3.3b In-line Formatting';
title2 '~{style [font_face="times new roman"]Initial}' 
       '~{style [font_style=roman] Coded}'
       ' Symptoms';
proc report data=advrpt.demog nowd split='*';
   column symp wt ht;
   define symp / group 'symptom' order=data;
   define wt   / analysis mean format=6.1 'Weight~{super 1}';
   define ht   / analysis mean format=6.1 'Height~{super 2}';
   compute after;
      line @3 '~{style [font_weight=bold font_size=3] ~{super 1} Pounds}';
      line @3 '~{style [font_weight=light] ~{super 2}Inches}';
   endcomp;
   run;
ods _all_ close;
