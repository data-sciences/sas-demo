* E11_6.sas
*
* Using ODS LAYOUT;
*
* Depending on your version of SAS you may need to adjust the layout regions
* to reproduce the table in the book.  In the code below the SAS9.2 code has
* been commented out (code in the book), and replaced with the region layout 
* locations for SAS9.3.  You may need to experiment a bit to get it right on
* your system;

%let text1 = ~S={font_face=arial font_weight=bold}11.6 Using ODS LAYOUT~S={font_face=arial}~nMean Weight and Height;
%let text2 = ~nfor Symptom and Years of Education;
title1;

ods pdf file="&path\results\E11_6.pdf" 
        style=journal
        startpage=never;
ods escapechar='~';
ods layout start width=7in height=10in;

ods region x=1in y=1in width=7in height=.5in;
ods pdf text="&text1&text2";

/*ods region x=0.5in y=1.5in width=7in height=4in;*/
ods region x=1in y=1.5in width=7in height=4in;
 
proc report data=advrpt.demog nowd ;
   column symp wt ht;
   define symp / group 'Symptom' order=internal;
   define wt   / analysis mean format=6.1 'Weight';
   define ht   / analysis mean format=6.1 'Height';
   run;

/*ods region x=1.5in y=1.5in width=3in height=4in;*/
ods region x=3in y=1.5in width=3in height=4in;
 
proc report data=advrpt.demog nowd;
   column edu sex,(wt ht);
   define Edu  / group 'Years of Education' order=internal;
   define sex  / across 'Gender';
   define wt   / analysis mean format=6.1 'Weight';
   define ht   / analysis mean format=6.1 'Height';
   run;
ods _all_ close;
ods layout end;
