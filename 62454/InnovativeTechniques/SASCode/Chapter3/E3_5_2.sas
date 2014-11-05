* E3_5_2.sas
* 
* Decimal conversions to hex and binary;

title1 '3.5.2 Conversions to Hex and Binary';

data convert;
length bin $20;
* Converting from Decimal;
dec = 456;
bin = put(dec,binary9.);
oct = put(dec,octal.);
hex = put(dec,hex.);
put dec= bin= oct= hex=;

* Converting to Decimal;
bdec = input(bin,binary9.);
odec = input(oct,octal.);
hdec = input(hex,hex.);
put bdec= odec= hdec=;
run;

* Create a hex coded value;
data hexcode;
code = '25'x;put code=;
run;

%macro hexcodes;
* Create a hex coded value;
data hexcode;
%do h = 10 %to 99;
code = "&h"x;put "&h " code=;
%end;
run;
%mend hexcodes;
%hexcodes
