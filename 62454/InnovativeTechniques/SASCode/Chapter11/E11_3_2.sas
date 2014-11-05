*E11_3_2.sas
*
* Using escape characters and in-line formatting;
title1  '11.3.2 In-line Formatting';

ods escapechar='~';

ods pdf file="&path\results\E11_3_2.pdf"
        style=printer;
title2 'Superscripts and a Dagger ~{dagger}';
proc report data=advrpt.demog nowd split='*';
   column symp wt ht;
   define symp / group 'symptom' order=data;
   define wt   / analysis mean format=6.1 'Weight~{super 1}';
   define ht   / analysis mean format=6.1 'Height~{super 2}';
   compute after;
      line @1 '~{super 1}Pounds';
      line @1 '~{super 2}Inches';
      line @1 '~{dagger} Using inline formatting';
   endcomp;
   run;
ods _all_ close;
