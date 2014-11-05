* E9_1.sas
*
* Using the TITLE and FOOTNOTE options with ODS;

title1  f='times new roman' h=15pt c=blue bc=yellow 
        '9.1a Using TITLE Options';

ods rtf file="&path\results\E9_1a.rtf"
        style=rtf;
ods pdf file="&path\results\E9_1a.pdf"
        style=rtf;
ods html file="&path\results\E9_1a.html"
        style=rtf;

title2 f='Arial' h=13pt c=red j=l bold 'English Units';
footnote1 j=l c=b f=Arial 'Example 9.1';

proc report data=advrpt.demog nowd split='*';
  column symp ('Mean Weight*in Pounds' sex,wt ratio);
  define symp    / group width=10 'Symptom';
  define sex     / across 'Gender' order=data;
  define wt      / analysis mean format=6. ' ';
  define ratio   / computed format=6.3 'Ratio*F/M ';
  rbreak after   / dol skip summarize;
  compute ratio;
     ratio = _c3_ / _c2_;
  endcomp;
  run;

ods _all_ close;

title1  f='times new roman' h=15pt c=blue bc=yellow 
        '9.1b Using  BODYTITLE';

ods rtf file="&path\results\E9_1b.rtf"
        style=rtf
        bodytitle;

title2 f='Arial' h=13pt c=red j=l bold 'English Units';

proc report data=advrpt.demog nowd split='*';
  column symp ('Mean Weight*in Pounds' sex,wt ratio);
  define symp    / group width=10 'Symptom';
  define sex     / across 'Gender' order=data;
  define wt      / analysis mean format=6. ' ';
  define ratio   / computed format=6.3 'Ratio*F/M ';
  rbreak after   / dol skip summarize;
  compute ratio;
     ratio = _c3_ / _c2_;
  endcomp;
  run;

ods _all_ close;

*****************************;
* Placing horizontal lines;
title1 '9.1c Horizontal Lines';
title2  h=5pt bcolor=blue ' ';
footnote h=5pt bcolor=blue ' ';
ods html file="&path\results\E9_1c.html";
proc print data=sashelp.class(obs=4);
run;
ods html close;
