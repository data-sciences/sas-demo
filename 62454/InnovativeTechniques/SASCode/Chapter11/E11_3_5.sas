* E11_3_5.sas
*
* Sending RAW commands to RTF;


ods listing close;
ods rtf style=rtf
    file="&path\results\E11_3_5.rtf";

ods escapechar = '~';

proc format;
   value $gender
      'f','F'='~{raw \b F\b0\i emale}'
      'm','M'='~{raw \b M\b0\i ale}';
   run;
title1  ~{raw '11.3.5 \i0 Using \b\ul RTF\b0\ul0  Codes'};
title2 ~{raw '\i0 Italics off'};
proc report data=advrpt.demog nowd;
   columns sex ht wt;
   define sex   / group format=$gender.;
   define ht    / analysis mean
                  format=5.2
                  'Height';
   define wt    / analysis mean
                  format=6.2
                  'Weight';
   rbreak after / summarize;
   run;
ods _all_ close;
