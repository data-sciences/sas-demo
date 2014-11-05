
TITLE;
/* This code was taken from:

Smith, Kevin D.. 2007. 
"The Output Delivery System (ODS) from Scratch.", 
In Proceedings of the 2007 SAS Global Forum, Orlando, FL, paper 219-2007. 

The only change made to the code was the addition of '&JES.styles/' 
in four places to direct the output to the &JES/styles/ folder, a TITLE statement

*/

/* This program prints a sample report in HTML, PDF, and RTF */
/* in every style that is specified in ODS path. */

ods listing close;
proc template;
define table vstyle;
	column libname memname style links;
	define links;
		header = 'Samples';
		compute as '<a href="' || trim(style) || '.html">HTML</a> ' ||
				'<a href="' || trim(style) || '.pdf">PDF</a> ' ||
				'<a href="' || trim(style) || '.rtf">RTF</a>';
	end;
end;
run;
/* Print index of all styles. */
ods html file="&JES.styles/index.html" (TITLE="Styles")
	headtext="<base target=_blank>";
data _null_;
	set sashelp.vstyle;
	file print ods=(template='vstyle');
	put _ods_;
run;
ods html close;
%macro generateods();
	ods html file="&JES.styles/&style..html" 
	(TITLE="&style") style=&style;
	ods pdf file="&JES.styles/&style..pdf" style=&style;
	ods rtf file="&JES.styles/&style..rtf" style=&style;
	proc contents data=sashelp.class; run;
	ods rtf close;
	ods pdf close;
	ods html close;
%mend;
/* Print a sample of each style.*/
data _null_;
	set sashelp.vstyle;
	call symput('style', trim(style));
	call execute('%generateods');
run;
ods listing;
