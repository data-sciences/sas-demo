* S2_4_1.sas
*
* Specify the statistic on the DEFINE statement;

ods pdf file="&path\results\ch2_4_1.pdf" style=rtf;
title1 'Using Proc REPORT';
title2 'Specify the MEAN on the DEFINE Statement';
proc report data=rptdata.clinics nowd;
   column region sex edu wt;
   define region / group;
   define sex / across;
   define wt / analysis mean;
   define edu / analysis;
   run;
ods pdf close;
