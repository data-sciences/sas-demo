* S8_6_6a.sas
*
* Using RTF Control words.
*
* Program suggested by Sunil Gupta;


ods escapechar = '~';

title1 "~R/RTF'\ul' Title is italic and contains underlined text";

data rtfcontrol;
 text = 'This is default text.';
run;

ods rtf file = "&path\results\ch8_6_6a.rtf"
        style=rtf;

PROC REPORT  data = rtfcontrol nowd 
   style(header column)=[font_face='arial' font_weight=bold]; 
                                     
   column text my_text;

   define text/display 'Default'; 
   define my_text/computed width=1 'RTF Control Words' flow; 
 
   compute my_text / char length=200;
    my_text = "The text uses RTF control words "  || 
       '~R"\i italic text \i0 "'  || " regular text " ||     
       '~R"\ul underlined text \ul0 "' ||
       '~R"\strike strike text \strike0 "' || ".";
   endcomp;

run;
ods rtf close;
