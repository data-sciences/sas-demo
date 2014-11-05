* S8_6TestAll.sas
*
* Test various in-line formatting sequences;
*
* Primary author Cynthia Zender
*;

title;
footnote;
options nodate nonumber;
ods listing close;

ods escapechar='~';

data esc;
 length example $ 200;
 example='E = mc~{super 2}'; 
 output;
 example='H~{sub 2}O'; 
 output;
 example='Dagger symbol~{dagger}~{dagger}'; 
 output;
 example='Page ~{thispage} of ~{lastpage}'; 
 output;
 example='~S={font_face="Courier New"}Courier New~S={}'||
     '~S={font_weight=bold} bold~S={}'||
     '~S={font_style=italic} italic~S={}';
 output;
 example='~S={foreground=Red}Foreground color~S={} is the text color.';
 output;
 example='This is the first line.~n'||
     'This is the second line.~2n '||
     'This is the fourth line.';
 output;
 example='~1z Yada Yada'; output;
 example='~2z Yada Yada'; output;
 example='~3z Yada Yada'; output;
 example='~4z Yada Yada'; output;
 * upper case does not work;
 example='~4Z Yada Yada'; output;
  example='This is ~S={font_size=36pt}BIG~S={} text.';
 output;
 example='This is ~S={font_size=6pt}SMALL~S={} text.';
 output;
** insert symbols or ascii hex codes;
  example='~S={font_face=symbol font_size=18pt}p~S={} symbol';
 output;
 example='~S={font_face=symbol font_size=18pt}'||'AE'x||'~S={} symbol';
 output;
 example='~S={font_face=symbol font_size=18pt}'||'B3'x||'~S={} symbol';
 output;
 example='~S={font_face=symbol font_size=18pt}'||'D6'x||'~S={} symbol';
 output;
** touch justification and other style attributes;
 example='~S={cellheight=1in}This is a tall cell.';
 output;
 example='~S={just=right}right justified';
 output;
** more style;
 example='~S={url="http://www.setgame.com"}Cool Game to Play~S={}';
 output;
** image must be in same location as output file.;
 example=%unquote(%bquote(')~S={preimage="&path\magic.jpg"} Image%bquote('));
 output;
** raw text insertion -- REALLY HAVE TO KNOW HOW TO DO THIS;
** just for RTF and HTML;
** does not work for PDF at ALL;
 example='Begin~R/RTF"\tab\tab" Two Tabs Later'; output;
 example='Before Test ~R/RTF"\highlight3" After Test'; output;
 example='~R/RTF"\ul" 1st Line~R/RTF"\line" 2nd Line'; output;
 example='The color is ~R/HTML"<font color=blue>"BLUE (HTML ONLY)~R/HTML"</font>"'; output;
 *** Lower case r does NOT work;
 example='~r/RTF"\ul" 1st Line~r/RTF"\line" 2nd Line'; output;
 example='The color is ~r/HTML"<font color=blue>"BLUE (HTML ONLY)~r/HTML"</font>"';  output;

*** line feeds;
 example='-2n ~maaaaaaaa~-2nbbbbbbbbbbbbbb'; output;
 example='-1n ~maaaaaaaa~-1nbbbbbbbbbbbbbb'; output;
 example='-n ~maaaaaaaa~-nbbbbbbbbbbbbbb'; output;
 example='n ~maaaaaaaa~nbbbbbbbbbbbbbb'; output;
 example='2n ~maaaaaaaa~2nbbbbbbbbbbbbbb'; output;
 example='3n ~maaaaaaaa~3nbbbbbbbbbbbbbb'; output;

*** Non-breaking spaces;
 example='aaaaa~_bbbbb'; output;
 example='aaaaa~_~_bbbbb'; output;
 example='aaaaa~3_bbbbb'; output;
run;

ods listing close;
ods html style=defualt file="&path\results\ch8_6TestAll.html"; 
ods pdf  style=printer file="&path\results\ch8_6TestAll.pdf";
ods rtf  style=rtf     file="&path\results\ch8_6TestAll.rtf";
  title j=l '~{pageof}' j=c "note which works where" j=r '~{thispage} of ~{lastpage}';
  title2 'Not all of these will work in all destinations';
  title3 'HTML supports the least. RTF does more. PDF does most';
  footnote1 j=l 'Page Number: ~{thispage}';
  footnote2 j=l 'Last Page: ~{lastpage}';
  footnote3 j=r 'Page ~{thispage} of ~{lastpage}';
  footnote4 j=c 'Page ~{pageof}';
  footnote5 'footnotes with escape char for thispage, lastpage, etc are pretty worthless';

  proc report data=esc nowd;
  run;

ods _all_ close;

title; footnote;
ods listing;
