* S8_6_6b.sas
*
* Using RTF Control words.
*
* Controlling quoting with %BQUOTE;


ods escapechar = '~';

title1 "~R/RTF'\ul' Title is italic and contains underlined text";

data rtfcontrol;
 text = 'This is default text.';
run;

ods rtf file = "&path\results\ch8_6_6b.rtf"
        bodytitle
        style=rtf;

%let code = ul;
%let txt = underlined text;

PROC REPORT  data = rtfcontrol nowd 
   style(header column)=[font_face='arial' font_weight=bold]; 
                                     
   column text my_text;

   define text/display 'Default'; 
   define my_text/computed width=1 'RTF Control Words' flow; 
 
   compute my_text / char length=200;
    my_text = "RTF control word as a macro variable "  ||
       %bquote(')~R"\&code &txt \&code.0 "%bquote(') || ".";
   endcomp;

run;
ods rtf close;
