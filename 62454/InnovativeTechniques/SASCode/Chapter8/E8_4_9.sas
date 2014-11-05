* E8_4_9.sas
*
* Aligning Decimal points;


title1 '8.4.9 Aligning Decimal Points';
ods listing close;


ods pdf file="&path\results\E8_4_9a.pdf" 
        style=journal;
title2 'Unaligned Decimals';
proc report data=advrpt.Lab_chemistry nowd;
column subject visit labdt sodium;
run;
ods pdf close;

ods pdf file="&path\results\E8_4_9b.pdf" 
        style=journal;
title2 'Aligned Decimals';
proc report data=advrpt.Lab_chemistry nowd;
column subject visit labdt sodium;
define sodium / style(column)={just=d};
run;
ods pdf close;

ods pdf file="&path\results\E8_4_9c.pdf" 
        style=journal;
title2 'Aligned Decimals Using a Format';
proc report data=advrpt.Lab_chemistry nowd;
column subject visit labdt sodium;
define sodium / f=4.1;
run;
ods pdf close;


