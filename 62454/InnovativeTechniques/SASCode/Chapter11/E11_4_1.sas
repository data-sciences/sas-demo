*E11_4_1.sas
*
* Establishing Hyperlinks;

%macro sympRPT;
title1  '11.4.1 Hyperlinks Using Style Overrides';

ods html file="&path\results\E11_4_1.htm" 
         style=journal;
title2 'Symptoms';
proc report data=advrpt.demog nowd split='*';
   column symp wt ht;
   define symp / group 'Symptom' order=internal
                 missing;
   define wt   / analysis mean format=6.1 'Weight';
   define ht   / analysis mean format=6.1 'Height';
   compute symp;
      stag = 'E11_4_1_'||trim(left(symp))||'.htm';
      call define(_col_,'url',stag);
   endcomp;
   run;
ods _all_ close;

proc sql noprint;
   select distinct symp
      into: sym1-:sym999
         from advrpt.demog;

%do s=1 %to &sqlobs;
ods html file="&path\results\E11_4_1_&&sym&s...htm" 
         style=journal;
title2 "Symptom &&sym&s";
proc report data=advrpt.demog(where=(symp="&&sym&s"))
            nowd split='*';
   column sex wt ht;
   define sex / group 'Sex' order=internal
                style(header)={url='e11_4_1.htm'};
   define wt   / analysis mean format=6.1 'Weight';
   define ht   / analysis mean format=6.1 'Height';
   run;
ods _all_ close;
%end;
%mend symprpt;

%symprpt
