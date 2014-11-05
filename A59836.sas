
 /*------------------------------------------------------------------*/
 /*       Web Development with SAS by Example, Second Edition        */
 /*                    by Frederick E. Pratter                       */
 /*       Copyright(c) 2006 by SAS Institute Inc., Cary, NC, USA     */
 /*                        ISBN: 978-1-59047-501-0                   */
 /*                        ISBN-10: 1-59047-501-1                    */
 /*                                                                  */                     
 /*-------------------------------------------------------------------/
 /*                                                                  */
 /* This material is provided "as is" by SAS Institute Inc.  There   */
 /* are no warranties, expressed or implied, as to merchantability or*/
 /* fitness for a particular purpose regarding the materials or code */
 /* contained herein. The Institute is not responsible for errors    */
 /* in this material as it now exists or will exist, nor does the    */
 /* Institute provide technical support for it.                      */
 /*                                                                  */
 /*-------------------------------------------------------------------/
 /* Questions or problem reports concerning this material may be     */
 /* addressed to the author:                                         */
 /*                                                                  */
 /* SAS Institute Inc.                                               */
 /* SAS Publishing                                                   */
 /* Attn: Frederick E. Pratter                                       */
 /* SAS Campus Drive                                                 */
 /* Cary, NC 27513                                                   */
 /*                                                                  */
 /*                                                                  */
 /* If you prefer, you can send email to:                            */
 /*                                                                  */
 /* saspress@sas.com                                                 */
 /*                                                                  */
 /* Use this for subject field:                                      */
 /*                                                                  */
 /* Comments for Frederick Pratter                                   */
 /*                                                                  */
 /*------------------------------------------------------------------*/
 /* Date Last Updated:  September 25, 2006                           */
 /*------------------------------------------------------------------*/





Chapter 2
Example 2.1 Sample HTML Page Source
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html public="public" xhtml="xhtml"
xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Eastern Oregon University Computer Science &amp;
Multimedia Studies Program</title>
<link href="styles.css" type="text/css" rel="stylesheet" />
</head>
<body>
<div>
<img class="hdr" src="http://cs.eou.edu/images/csmm.jpg"
alt="EOU Computer Science/Multimedia Studies Program" />
</div>
<table summary="Program Information">
<tr>
<td colspan="2" class="row_hdr">Program Information</td>
</tr>
<tr>
<td class="row1">
<ul>
<li><a href="programinfo.htm">Program Overview</a></li>
<li><a href="http://www.eou.edu/advising/checklist/CSMM.pdf">
Major &amp; Minor Requirements (PDF)</a></li>
<li><a href="http://www.eou.edu/catalog/compmulti.html">
Course Descriptions</a></li>
<li><a href="http://cs.eou.edu/CSMM/EOU_tour_site/index.html">
Tour the EOU Campus</a></li>
</ul>
</td>
<td class="row1">
<ul>
<li><a href="cslab.htm">Computer Science Lab</a></li>
<li><a href="http://cs.eou.edu/cslabuse.htm">
Lab Use and Behavior</a></li>
<li><a href="mmlab.htm">Multimedia Lab</a></li>
<li><a href="http://www.oregonetic.org/
05-07/ETICSuccessStoriesRevC.pdf">
ETIC Success Stories (PDF)</a></li>
</ul>
</td>
</tr>
<tr>
<td colspan="2" class="row_hdr">People</td>
</tr>
<tr>
<td class="row2">
<ul>
<li><a href="http://cs.eou.edu/faculty.htm">
Faculty</a></li>
</ul>
</td>
<td class="row2">
<ul>
<li><a href="http://cs.eou.edu/students.htm">
Students</a></li>
</ul>
</td>
</tr>
</table>
<hr />
<p>
<a href="http://www.eou.edu">
<img class="logo"
src="http://cs.eou.edu/images/eoulogow2.gif"
alt="EOU logo" /></a>
</p>
</body>
</html>

Example 2.2 Sample Cascading Style Sheet
body{ background-image: url("underwater.jpg") }
h1 { color: red; font-weight: bold; text-align: center }
h2 { color: blue; font-weight: bold; text-align: center }
p{ color: yellow; font-size: 14 pt; text-align: left }
Example 2.3 Sample Page with Link to External CSS
<html>
<head>
<link rel="stylesheet" type="text/css" href="mystyle.css">
</head>
<body>
<h1>heading 1</h1>
<h2>heading 2</h2>
<p>paragraph1</p>
<p>paragraph2</p>
<p>paragraph3</p>
</body>
</html>
Example 2.4 Sample Cascading Style Sheet with Table Formats
body {
background-color: #FFFFFF;
font-family: verdana, helvetica, arial;
}
:link {
color: #000080;
}
:visited {
color: #0000FF
}
:active {
color: #800000
}
table {
width:100%;
height:300px;
border: 0;
}
td {
width: 50%;
font-size: 10pt;
vertical-align: top;
padding: 2pt;
}
td.row_hdr {
color: #800000;
background-color: #C0C0C0;
font-size: 12pt;
font-weight: bold;
height: 20px;
width: 100%;
}
img.hdr {
height: 100px;
width: 400px;
}
img.logo {
border: 0;
float: left;
height: 55px;
width: 165px;
}
Example 2.5 Sample HTML Source Code
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Sample Form</title>
<style type="text/css">
h1 { text-align: center; color: #0000FF }
.label { font-weight: bold; color: #0000FF }
</style>
</head>
<body>
<h1>Student Questionnaire</h1>
<form name="students" method="get" action="index.html">
<blockquote>
<p>
<span class="label">Last Name:</span>
<input type="text" name="lastname" />
</p>
<p>
<span class="label">First Name:</span>
<input type="text" name="firstname" />
</p>
<p>
<span class="label">Year:</span>
</p>
<blockquote>
<input type="radio" name="year" value="1" />Freshman<br />
<input type="radio" name="year" value="2" />Sophomore<br />
<input type="radio" name="year" value="3" />Junior<br />
<input type="radio" name="year" value="4" />Senior<br />
<input type="radio" name="year" value="5" />Graduate<br />
<input type="radio" name="year" value="9" />Other
</blockquote>
<p>
<span class="label">Major:</span>
<select name="major">
<option value="CS">Computer Science</option>
<option value="B">Business</option>
<option value="F">Forestry</option>
<option value="M">Media Arts</option>
<option value="O">Other</option>
<option value="U">Undecided</option>
</select>
</p>
<p>
<span class="label">Check if this is your first computer class</span>
<input type="checkbox" name="firstCS" value="Y" />
</p>
<p>
<span class="label">Thank you for completing this form.</span>
</p>
<p>
<input type="reset" value="reset" />
<input type="submit" value="submit" />
</p>
</blockquote>
</form>
</body>
</html>

Chapter 3
Example 3.1 Sample PROC TABULATE Program
options noovp nodate nonumber nocenter ls=80;
proc tabulate data=SASHELP.RETAIL
formchar="|----|+|---+=|-/\<>*";
title "Retail Sales In Millions Of $";
class YEAR/descending;
var SALES;
table YEAR="" all="Total", SALES="" *
(sum="Total Sales"*f=dollar8.
pctsum="Overall Percent"*f=8.2
n="Number of Sales"*f=8.
mean="Average Sale"*f=dollar8.2
min="Smallest Sale"*f=dollar8.
max="Largest Sale"*f=dollar8.)/
box="Year" rts=8;
run;
Example 3.2 Using HTML Pre-formatting
<html>
<head>
<title>Retail Sales Table</title>
</head>
<body>
<h1 style="font-family: helvetica, tahoma, arial; color: blue">
Retail Sales in Millions of $</h1>
<pre>
--------------------------------------------------------------
|Year | Total |Overall | Number |Average |Smallest|Largest |
| | Sales |Percent |of Sales| Sale | Sale | Sale |
|------+--------+--------+--------+--------+--------+--------|
|1994 | $1,874| 5.97| 2| $937.00| $876| $998|
|------+--------+--------+--------+--------+--------+--------|
|1993 | $3,578| 11.40| 4| $894.50| $758| $991|
|------+--------+--------+--------+--------+--------+--------|
|1992 | $3,204| 10.21| 4| $801.00| $692| $889|
|------+--------+--------+--------+--------+--------+--------|
|1991 | $2,947| 9.39| 4| $736.75| $703| $807|
|------+--------+--------+--------+--------+--------+--------|
|1990 | $2,734| 8.71| 4| $683.50| $606| $749|
|------+--------+--------+--------+--------+--------+--------|
|1989 | $2,592| 8.26| 4| $648.00| $594| $670|
|------+--------+--------+--------+--------+--------+--------|
|1988 | $2,412| 7.69| 4| $603.00| $546| $643|
|------+--------+--------+--------+--------+--------+--------|
|1987 | $2,164| 6.90| 4| $541.00| $484| $595|
|------+--------+--------+--------+--------+--------+--------|
|1986 | $1,922| 6.13| 4| $480.50| $419| $541|
|------+--------+--------+--------+--------+--------+--------|
|1985 | $1,596| 5.09| 4| $399.00| $337| $448|
|------+--------+--------+--------+--------+--------+--------|
|1984 | $1,528| 4.87| 4| $382.00| $342| $413|
|------+--------+--------+--------+--------+--------+--------|
|1983 | $1,393| 4.44| 4| $348.25| $299| $384|
|------+--------+--------+--------+--------+--------+--------|
|1982 | $1,252| 3.99| 4| $313.00| $284| $343|
|------+--------+--------+--------+--------+--------+--------|
|1981 | $1,148| 3.66| 4| $287.00| $247| $323|
|------+--------+--------+--------+--------+--------+--------|
|1980 | $1,030| 3.28| 4| $257.50| $220| $295|
|------+--------+--------+--------+--------+--------+--------|
|Total | $31,374| 100.00| 58| $540.93| $220| $998|
--------------------------------------------------------------
</pre>
</body>
</html>
Example 3.3 Using PUT statements to Write HTML
filename temp 'Example 3-3.lst';
filename out 'Example 3-3.html';

*** redirect procedure output ***;
proc printto new file=temp;

*** create table ***;
proc tabulate data=SASHELP.RETAIL
formchar='|----|+|---+=|-/\<>*';
title 'Retail Sales In Millions Of $';
class YEAR/descending;
var SALES;
table YEAR='' all='Total', SALES='' *
(sum='Total Sales'*f=dollar8.
pctsum='Overall Percent'*f=8.2
n='Number of Sales'*f=8.
mean='Average Sale'*f=dollar8.2
min='Smallest Sale'*f=dollar8.
max='Largest Sale'*f=dollar8.)/
box='Year' rts=8;
run;

*** turn off redirection ****;
proc printto;

*** generate HTML output ***;
data _null_;
infile temp end=eof;
input;
file out;
if (_n_ eq 1) then /* write header and title */
put '<html>'/
'<head>'/
'<title>' _infile_ '</title>'/
'<body>'/
'<h1 style="color: blue">' _infile_ '</h1>'/
'<pre>';
else put _infile_;
if (eof) then /* write closing tags */
put '</pre>'/ '</body>'/' </html>';
run;
Example 3.4 HTML Output Formatter Macro
filename OUT '../public_html/example3-4.html';
%OUT2HTM(capture=on);

*** create table ***;
proc means data=SASHELP.RETAIL
n mean min max
nonobs fw=8 maxdec=2;
class YEAR/descending;
var SALES;
title;
run;
%OUT2HTM(capture=off, htmlfref=OUT);
Example 3.5 %OUT2HTM Macro HTML Source
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<HTML>
<HEAD>
<META NAME="GENERATOR"
CONTENT="SAS Institute Inc. HTML Formatting Tools,
http://www.sas.com/">
<TITLE></TITLE>
</HEAD>
<BODY>
<PRE><STRONG>The MEANS Procedure
Analysis Variable : SALES Retail sales in millions of $
YEAR N Mean Minimum Maximum
--------------------------------------------------</STRONG></PRE>
<PRE> 1994 2 937.00 876.00 998.00
1993 4 894.50 758.00 991.00
1992 4 801.00 692.00 889.00
1991 4 736.75 703.00 807.00
1990 4 683.50 606.00 749.00
1989 4 648.00 594.00 670.00
1988 4 603.00 546.00 643.00
1987 4 541.00 484.00 595.00
1986 4 480.50 419.00 541.00
1985 4 399.00 337.00 448.00
1984 4 382.00 342.00 413.00
1983 4 348.25 299.00 384.00
1982 4 313.00 284.00 343.00
1981 4 287.00 247.00 323.00
1980 4 257.50 220.00 295.00</PRE>
<PRE><STRONG>
--------------------------------------------------
</STRONG></PRE>
<HR>
</BODY>
</HTML>
Example 3.6 Data Set Formatter Macro
filename OUT '../public_html/example3-6.html';
title Sales Total by Month;

%ds2htm (
data = SASHELP.RETAIL,
where = YEAR gt 1990,
var = YEAR MONTH SALES,
htmlfref = out);
Example 3.7 %DS2HTM Macro HTML Source
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<HTML>
<HEAD>
<META NAME="GENERATOR"
CONTENT="SAS Institute Inc. HTML Formatting Tools,
http://www.sas.com/">
<TITLE></TITLE>
</HEAD>
<BODY>
<PRE><H3>Sales Total by Month</H3></PRE>
<P>
<TABLE BORDER="1" WIDTH="100%" ALIGN="CENTER" CELLPADDING="1"
CELLSPACING="1">
<TR>
<TH ALIGN="CENTER" VALIGN="MIDDLE">YEAR</TH>
<TH ALIGN="CENTER" VALIGN="MIDDLE">MONTH</TH>
<TH ALIGN="CENTER" VALIGN="MIDDLE">Retail sales in millions of
$</TH>
</TR>
<TR>
<TD ALIGN="CENTER" VALIGN="MIDDLE">1991</TD>
<TD ALIGN="CENTER" VALIGN="MIDDLE">1</TD>
<TD ALIGN="CENTER" VALIGN="MIDDLE"> $703</TD>
</TR>
<TR>
<TD ALIGN="CENTER" VALIGN="MIDDLE">1991</TD>
<TD ALIGN="CENTER" VALIGN="MIDDLE">4</TD>
<TD ALIGN="CENTER" VALIGN="MIDDLE"> $709</TD>
</TR>
<TR>
<TD ALIGN="CENTER" VALIGN="MIDDLE">1991</TD>
<TD ALIGN="CENTER" VALIGN="MIDDLE">7</TD>
<TD ALIGN="CENTER" VALIGN="MIDDLE"> $728</TD>
</TR>
<TR>
<TD ALIGN="CENTER" VALIGN="MIDDLE">1991</TD>
<TD ALIGN="CENTER" VALIGN="MIDDLE">10</TD>
<TD ALIGN="CENTER" VALIGN="MIDDLE"> $807</TD>
</TR>
<TR>
[... repeated lines omitted ...]
<TR>
<TD ALIGN="CENTER" VALIGN="MIDDLE">1994</TD>
<TD ALIGN="CENTER" VALIGN="MIDDLE">1</TD>
<TD ALIGN="CENTER" VALIGN="MIDDLE"> $876</TD>
</TR>
<TR>
<TD ALIGN="CENTER" VALIGN="MIDDLE">1994</TD>
<TD ALIGN="CENTER" VALIGN="MIDDLE">4</TD>
<TD ALIGN="CENTER" VALIGN="MIDDLE"> $998</TD>
</TR>
</TABLE>
<P>
<HR>
</BODY>
</HTML>
Example 3.8 Tabulate Formatter Macro
options noovp nodate nonumber nocenter ls=80
formchar='82838485868788898a8b8c'x;
filename OUT '../public_html/example3-8.html';

%TAB2HTM(capture=on);

*** create table ***;
proc tabulate data=SASHELP.RETAIL;
title 'Retail Sales In Millions Of $';
class YEAR/descending;
var SALES;
table YEAR='' all='Total', SALES='' *
(sum='Total Sales'*f=dollar8.
pctsum='Overall Percent'*f=8.2
n='Number of Sales'*f=8.
mean='Average Sale'*f=dollar8.2
min='Smallest Sale'*f=dollar8.
max='Largest Sale'*f=dollar8.)/
box='Year' rts=8;
run;

%TAB2HTM(capture=off, htmlfref=OUT, center=Y);
Example 3.9 Tabulate Formatter Macro HTML Source
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<HTML>
<HEAD>
<META NAME="GENERATOR" CONTENT="SAS Institute Inc. HTML Formatting
Tools, http://www.sas.com/">
<TITLE></TITLE>
</HEAD>
<BODY>
<CENTER>
<PRE><H3>Retail Sales In Millions Of $</H3></PRE>
<PRE><H3></H3></PRE>
<P>
<TABLE BORDER="1" WIDTH="0%" ALIGN="CENTER" CELLPADDING="1"
CELLSPACING="1">
<TR>
<TH ALIGN="LEFT" VALIGN="TOP" NOWRAP>Year</TH>
<TH ALIGN="CENTER" VALIGN="BOTTOM" NOWRAP>Total<BR>Sales</TH>
<TH ALIGN="CENTER" VALIGN="BOTTOM" NOWRAP>Overall<BR>Percent</TH>
<TH ALIGN="CENTER" VALIGN="BOTTOM" NOWRAP>Number<BR>of Sales</TH>
<TH ALIGN="CENTER" VALIGN="BOTTOM" NOWRAP>Average<BR>Sale</TH>
<TH ALIGN="CENTER" VALIGN="BOTTOM" NOWRAP>Smallest<BR>Sale</TH>
<TH ALIGN="CENTER" VALIGN="BOTTOM" NOWRAP>Largest<BR>Sale</TH>
</TR>
<TR>
<TH ALIGN="LEFT" VALIGN="TOP" NOWRAP>1994</TH>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>$1,874</TD>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>5.97</TD>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>2</TD>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>$937.00</TD>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>$876</TD>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>$998</TD>
</TR>
<TR>
<TH ALIGN="LEFT" VALIGN="TOP" NOWRAP>1993</TH>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>$3,578</TD>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>11.40</TD>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>4</TD>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>$894.50</TD>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>$758</TD>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>$991</TD>
</TR>
[... repeated lines omitted ...]
<TR>
<TH ALIGN="LEFT" VALIGN="TOP" NOWRAP>1980</TH>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>$1,030</TD>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>3.28</TD>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>4</TD>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>$257.50</TD>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>$220</TD>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>$295</TD>
</TR>
<TR>
<TH ALIGN="LEFT" VALIGN="TOP" NOWRAP>Total</TH>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>$31,374</TD>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>100.00</TD>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>58</TD>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>$540.93</TD>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>$220</TD>
<TD ALIGN="RIGHT" VALIGN="BOTTOM" NOWRAP>$998</TD>
</TR>
</TABLE>
<P>
<P>
<HR><P>
</CENTER>
</BODY>
</HTML>
Example 3.10 SAS Display Manager HTML Source
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>SAS Output</TITLE>
<META content="MSHTML 6.00.2900.2802" name=GENERATOR sasversion="9.1">
<META http-equiv=Content-type content="text/html; charset=windows-
1252">
<STYLE type=text/css>.ContentTitle {
[... a whole bunch of CSS styles omitted ...]
}
</STYLE>
<SCRIPT language=javascript type=text/javascript>
<!--
function startup(){
}
function shutdown(){
}
//-->
</SCRIPT>
<NOSCRIPT></NOSCRIPT></HEAD>
<BODY class=Body onload=startup() onunload=shutdown()>
<SCRIPT language=javascript type=text/javascript>
<!--
var _info = navigator.userAgent
var _ie = (_info.indexOf("MSIE") > 0
&& _info.indexOf("Win") > 0
&& _info.indexOf("Windows 3.1") < 0);
//-->
</SCRIPT>
<NOSCRIPT></NOSCRIPT>
<DIV class=branch><A name=IDX></A>
<TABLE class=SysTitleAndFooterContainer cellSpacing=1 cellPadding=1
rules=none width="100%" summary="Page Layout" border=0 frame=void>
<TBODY>
<TR>
<TD class="l SystemTitle">Retail Sales In Millions Of
$</TD></TR></TBODY></TABLE><BR>
<DIV>
<DIV align=left>
<TABLE class=Table borderColor=#000000 cellSpacing=1 cellPadding=7
rules=groups summary="Procedure Tabulate: Table 1" border=1 frame=box>
<COLGROUP>
<COL></COLGROUP>
<COLGROUP>
<COL>
<COL>
<COL>
<COL>
<COL>
<COL></COLGROUP>
<THEAD>
<TR>
<TH class="c m Header" scope=col>Year</TH>
<TH class="c Header" scope=col>Total Sales</TH>
<TH class="c Header" scope=col>Overall Percent</TH>
<TH class="c Header" scope=col>Number of Sales</TH>
<TH class="c Header" scope=col>Average Sale</TH>
<TH class="c Header" scope=col>Smallest Sale</TH>
<TH class="c Header" scope=col>Largest Sale</TH></TR></THEAD>
<TBODY>
<TR>
<TH class="l t RowHeader" scope=row>1994</TH>
<TD class="r b Data">$1,874</TD>
<TD class="r b Data">5.97</TD>
<TD class="r b Data">2</TD>
<TD class="r b Data">$937.00</TD>
<TD class="r b Data">$876</TD>
<TD class="r b Data">$998</TD></TR>
[... repeated lines omitted ...]
<TR>
<TH class="l t RowHeader" scope=row>Total</TH>
<TD class="r b Data">$31,374</TD>
<TD class="r b Data">100.00</TD>
<TD class="r b Data">58</TD>
<TD class="r b Data">$540.93</TD>
<TD class="r b Data">$220</TD>
<TD class="r b Data">
$998</TD></TR></TBODY></TABLE></DIV></DIV><BR></DIV></BODY></HTML>
Example 3.11 Using the ODS HTML Statement
filename OUT "Example 3-11.html";
ods listing close;
ods html body=OUT;
proc tabulate data=SASHELP.RETAIL;
title "Retail Sales In Millions of $";
class YEAR/descending;
var SALES;
table YEAR="" all="Total", SALES="" *
(sum="Total Sales"*f=dollar8.
pctsum="Overall Percent"*f=8.2
n="Number of Sales"*f=8.
mean="Average Sale"*f=dollar8.2
min="Smallest Sale"*f=dollar8.
max="Largest Sale"*f=dollar8.)/
box="Year" rts=8;
run;
ods html close;
ods listing;
Example 3.12 Creating Multiple Web Pages
ods listing close;
ods html body="../public_html/example3-12.html" newfile=proc;

***** Step #1 ****;
proc print data=SASHELP.RETAIL;
title "1994 Sales Total by Month";
where YEAR gt 1990;
var MONTH SALES;
id YEAR;
run;

***** Step #2 ****;
proc means data=SASHELP.RETAIL
n mean min max
nonobs fw=8 maxdec=2;
title 'Retail Sales In Millions Of $';
class YEAR/descending;
var SALES;
run;

***** Step #3 ****;
proc tabulate data=SASHELP.RETAIL;
class YEAR/descending;
var SALES;
table YEAR='' all='Total', SALES='' *
(sum='Total Sales'*f=dollar8.
pctsum='Overall Percent'*f=8.2
n='Number of Sales'*f=8.
mean='Average Sale'*f=dollar8.2
min='Smallest Sale'*f=dollar8.
max='Largest Sale'*f=dollar8.)/
box='Year' rts=8;
run;
ods html close;
ods listing;
Example 3.13 Creating Frames with ODS
ods listing close;
ods html path="../public_html" (url="http://hygelac/BBU/")
body = "body3-13.html"
contents = "contents3-13.html"
frame = "frame3-13.html";

***** Step #1 ****;
proc print data=SASHELP.RETAIL;
title "1994 Sales Total by Month";
where YEAR gt 1990;
var MONTH SALES;
id YEAR;
run;

***** Step #2 ****;
proc means data=SASHELP.RETAIL
n mean min max
nonobs fw=8 maxdec=2;
title 'Retail Sales In Millions Of $';
class YEAR/descending;
var SALES;
run;

***** Step #3 ****;
proc tabulate data=SASHELP.RETAIL;
class YEAR/descending;
var SALES;
table YEAR='' all='Total', SALES='' *
(sum='Total Sales'*f=dollar8.
pctsum='Overall Percent'*f=8.2
n='Number of Sales'*f=8.
mean='Average Sale'*f=dollar8.2
min='Smallest Sale'*f=dollar8.
max='Largest Sale'*f=dollar8.)/
box='Year' rts=8;
run;
ods html close;
ods listing;
Example 3.14 ODS HTML Data Set Listing
filename OUT "../public_html/example3-14.html";
title "Sales Total by Month 1991-1994";
ods listing close;
ods html body=OUT;
data _null_;
set SASHELP.RETAIL;
where (YEAR gt 1990);
file print ods=(variables=(YEAR MONTH SALES));
put _ods_;
run;
ods html close;
ods listing;
Example 3.15 Default Style Template
proc template;
define style Styles.Default;
style fonts
"Fonts used in the default style" /
'TitleFont2' = ("Arial, Helvetica, sans-serif",4,Bold Italic)
'TitleFont' = ("Arial, Helvetica, sans-serif",5,Bold Italic)
'StrongFont' = ("Arial, Helvetica, sans-serif",4,Bold)
'EmphasisFont' = ("Arial, Helvetica, sans-serif",3,Italic)
'FixedEmphasisFont' = ("Courier New, Courier,
monospace",2,Italic)
'FixedStrongFont' = ("Courier New, Courier,
monospace",2,Bold)
'FixedHeadingFont' = ("Courier New, Courier, monospace",2)
'BatchFixedFont' = ("SAS Monospace, Courier New, Courier,
monospace",2)
'FixedFont' = ("Courier",2)
'headingEmphasisFont' = ("Arial, Helvetica, sansserif",
4,Bold Italic)
'headingFont' = ("Arial, Helvetica, sans-serif",4,Bold)
'docFont' = ("Arial, Helvetica, sans-serif",3);
[ ... many more styles omitted ... ]
end;
run;
Example 3.16 ODS Sasweb Style Data Set Listing
filename OUT "../public_html/example3-16.html";
title "Sales Total by Month 1991-1994";
ods listing close;
ods html body=OUT style=sasweb;
data _null_;
set SASHELP.RETAIL;
where (YEAR gt 1990);
file print ods=(variables=(YEAR MONTH SALES));
put _ods_;
run;
ods html close;
ods listing;
Example 3.17 ODS Markup: XHTML
filename OUT "../public_html/example3-17.html";
ods listing close;
ods markup body=OUT tagset=XHTML;
proc tabulate data=SASHELP.RETAIL;
title "Retail Sales In Millions Of $";
class YEAR/descending;
var SALES;
table YEAR="" all="Total", SALES="" *
(sum="Total Sales"*f=dollar8.
pctsum="Overall Percent"*f=8.2
n="Number of Sales"*f=8.
mean="Average Sale"*f=dollar8.2
min="Smallest Sale"*f=dollar8.
max="Largest Sale"*f=dollar8.)/
box="Year" rts=8;
run;
ods markup close;
ods listing;
Example 3.18 XHTML Source
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>SAS Output</title>
</head>
<body>
<h1>Retail Sales In Millions Of $</h1>
<table border="1">
<thead>
<tr>
<th>Year</th><th>Total Sales</th>
<th>Overall Percent</th>
<th>Number of Sales</th>
<th>Average Sale</th><th>Smallest Sale</th>
<th>Largest Sale</th>
</tr>
</thead>
<tbody>
<tr>
<th> 1994</th>
<td> $1,874</td>
<td> 5.97</td>
<td> 2</td>
<td> $937.00</td>
<td> $876</td>
<td> $998</td>
</tr>
[... repeated lines omitted ...]
<tr>
<th> 1980</th>
<td> $1,030</td>
<td> 3.28</td>
<td> 4</td>
<td> $257.50</td>
<td> $220</td>
<td> $295</td>
</tr>
<tr>
<th>Total</th>
<td> $31,374</td>
<td> 100.00</td>
<td> 58</td>
<td> $540.93</td>
<td> $220</td>
<td> $998</td>
</tr>
</tbody>
</table>
<p>
<a href="http://validator.w3.org/check/referer">
<img src="http://www.w3.org/Icons/valid-xhtml11"
alt="Valid XHTML 1.1!" height="31" width="88" /></a>
</p>
</body>
</html>
Example 3.19 XHTML Template
proc template;
define tagset Tagsets.xhtml / store = SASUSER.TEMPLAT;
define event cell_is_empty;
put %nrstr("&nbsp;");
end;
define event doc;
start:
put "<?xml version=""1.0"" encoding=""UTF-8""?>" NL;
put "<!DOCTYPE html PUBLIC ""-//W3C//DTD XHTML 1.1//EN""" NL;
put """http://www.w3.org/TR/xhtml1/DTD/xhtml11.dtd"">" NL;
put "<html xmlns=""http://www.w3.org/1999/xhtml"">" NL;
ndent;
finish:
xdent;
put "</html>" NL;
end;
define event doc_head;
start:
put "<head>" NL;
ndent;
finish:
xdent;
put "</head>" NL;
end;
define event doc_body;
start:
put "<body>" NL;
put TITLE;
finish:
/* add W3C logo to page */
put '<p>' NL;
put '<a href="http://validator.w3.org/check/referer">' NL;
put '<img src="http://www.w3.org/Icons/valid-xhtml11"' NL;
put 'alt="Valid XHTML 1.1!" height="31" width="88" /></a>' NL;
put '</p>' NL;
put '</body>' NL;
end;
define event doc_title;
put "<title>";
put "SAS Output" / if !exists(VALUE);
put VALUE;
put "</title>" NL;
end;
define event proc_title;
put "<h2>" VALUE "</h2>" CR;
end;
define event system_title;
put "<h1>" VALUE "</h1>" CR;
end;
define event system_footer;
put "<h1>" VALUE "</h1>" CR;
end;
define event byline;
put "<h2>" VALUE "</h2>" CR;
end;
define event note;
put "<h3>" VALUE "</h3>" CR;
end;
define event fatal;
put "<h3>" VALUE "</h3>" CR;
end;
define event error;
put "<h3>" VALUE "</h3>" CR;
end;
define event warning;
put "<h3>" VALUE "</h3>" CR;
end;
define event table;
start:
put "<table border=""1"">" NL;
ndent;
finish:
xdent;
put "</table>" NL;
end;
define event row;
start:
put "<tr>" NL;
ndent;
finish:
xdent;
put "</tr>" NL;
end;
define event table_head;
start:
put "<thead>" NL;
ndent;
finish:
xdent;
put "</thead>" NL;
end;
define event table_body;
start:
put "<tbody>" NL;
ndent;
finish:
xdent;
put "</tbody>" NL;
end;
define event table_foot;
start:
put "<tfoot>" NL;
ndent;
finish:
xdent;
put "</tfoot>" NL;
end;
define event rowcol;
putq " rowspan=" ROWSPAN;
putq " colspan=" COLSPAN;
end;
define event header;
start:
put "<th";
trigger rowcol;
put ">";
put VALUE;
finish:
put "</th>";
end;
define event data;
start:
put "<th" / if cmp( section , "head" );
put "<td" / if !cmp( section , "head" );
trigger rowcol;
put ">";
put VALUE;
finish:
put "</th>" NL / if cmp( section , "head" );
put "</td>" NL / if !cmp( section , "head" );
end;
mapsub = %nrstr("/&lt;/&gt;/&amp;/&quot;/");
map = %nrstr("<>&""");
split = "<br />";
output_type = "xml";
indent = 3;
end; /* define tagset */

Chapter 4
Example 4.1 Sample Program to Start the SAS/SHARE Server
*****************************************************;
***** start SAS/SHARE server on local host *****;
***** system administrator password: system *****;
***** user pasword: user *****;
***** authentication is on *****;
*****************************************************;
proc server
id=shr1
oapw=system
uapw=user
authenticate=required;
run;
Example 4.2 Stop the SAS/SHARE Server
*****************************************************;
***** stop SAS/SHARE server on local host *****;
*****************************************************;
proc operate serverid=shr1 sapw=system uid=_prompt_;
stop server;
run;
Example 4.4 Remote Library Services
libname SHARED slibref=SASHELP server=hygelac.shr1 sapw=user passwd=_prompt_;
proc print data=SHARED.RETAIL;
title "Retail Sales Total by Month: 1991-1994";
where YEAR gt 1990;
var MONTH SALES;
id YEAR;
run;
Example 4.5 Remote SQL Pass-Through
proc sql;
connect to remote (server=hygelac.shr1 sapw=user user=frederick password=_prompt_);
select * from connection to remote
(select YEAR, MONTH, sum(SALES)
format=dollar12. label='Total Sales'
from SASHELP.RETAIL
group by YEAR, MONTH);
quit;
Example 4.6 Remote Compute Services
rsubmit;
proc tabulate data=SASHELP.RETAIL;
title "Retail Sales In Millions Of $";
class YEAR/descending;
var SALES;
table YEAR="" all="Total", SALES="" *
(sum="Total Sales"*f=dollar8.
pctsum="Overall Percent"*f=8.2
n="Number of Sales"*f=8.
mean="Average Sale"*f=dollar8.2
min="Smallest Sale"*f=dollar8.
max="Largest Sale"*f=dollar8.)/
box="Year" rts=8;
run;
endrsubmit;

Chapter 5
Example 5.1 Hello World CGI Program
#!/usr/bin/perl
##
## HelloWorld.pl ? My first Perl program
##
use CGI ':standard'; # include CGI module
print header; # generate MIME content line
print start_html "CGI Examples"; # generate starting HTML tags

# print "Hello World"
print h1( { -style=>'color: blue; '}, 'Hello World!');

# generate date/time field
( $s, $m, $h, $d, $mm, $y ) = localtime(time);
$y+=1900; # convert 2-digit year to 4
$mm++; # months start with 0
print p( {-style=>'font-weight: bold; font-size: 24;'},
"The time now: $h:$m on $mm/$d/$y:");
print end_html; # generate ending HTML tags
Example 5.2 Perl-Generated HTML Source
Content-Type: text/html; charset=ISO-8859-1
<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
lang="en-US" xml:lang="en-US">
<head>
<title>CGI Examples</title>
</head>
<body>
<h1 style="color: blue; ">Hello World!</h1>
<p style="font-weight: bold; font-size: 24;">
The time now is 10:44 on 12/22/2005.</p>
</body>
</html>
Example 5.3 Perl Temperature Conversion Calculator
#!/usr/bin/perl
##
## Sample Perl program for temperature conversion
##
use CGI ':standard';
print header;
print start_html "Perl Temperature Conversion Examples";
# get input parameters and calculate result
$temp = param("input");
$type = param("convert");
if ( $type == 1 ) # convert F to C
{
$result = 5*($temp - 32)/9;
}
elsif ( $type == 2 )# convert C to F
{
$result = 9*$temp/5 + 32;
}
print '<div style="text-align: center; ">';
print h1 ( { -style=>'color: blue; '},
'Temperature Conversion Calculator' );
print '<form name="calculator" action="convert.pl" method="get">';
print p ( '<strong>Enter a temperature and select a conversion
type:</strong>',
'<input type="text" name="input" value=', $temp,'>' );
print p ( '<input type="radio" name="convert" value="1">
Fahrenheit to Centigrade' );
print p ( '<input type="radio" name="convert" value="2">
Centigrade to Fahrenheit' );
print p ( '<input type="submit" value = "Submit"
style="color: blue; font-weight: bold;">',
'<input type="reset" value = "Clear"
style="color: blue; font-weight: bold;">' );
if ($temp gt '') # "input" parameter not blank or missing
{
print p ('<strong>Result:</strong>',
'<input type="text" name="result" value=', $result, '>' );
}
print '</div></form>';
print end_html;

Chapter 6
Example 6.1 SAS/IntrNet: Hello World
/*simply write out a web page that says "Hello World!"*/
data _null_;
file _webout;
put '<HTML>';
put '<HEAD><TITLE>Hello World!</TITLE></HEAD>';
put '<BODY>';
put '<H1>Hello World!</H1>';
put '</BODY>';
put '</HTML>';
run;
Example 6.2 SAS/IntrNet: Temperature Conversion Program
/* SAS/IntrNet program to convert F to C and vice versa */
data _null_;
file _webout;
***** write generic XHTML header *****;
put '<?xml version="1.0" encoding="utf-8"?>'/
'<!DOCTYPE html PUBLIC ""-//W3C//DTD XHTML Basic 1.0//EN"'/
' "http://www.w3.org/TR/xhtml-basic/xhtml-basic10.dtd">'/
'<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US">';

***** write top of page *****;
put '<head>'/
'<title>SAS/IntrNet Temperature Conversion
Calculator</title>'/
'</head>'/
'<body>'/
'<div style="text-align: center">'/
'<h1 style="color: blue">Temperature Conversion Calculator</h1>';

**** create HTML form * with hidden text fields ***;
put '<form name="calculator" action="' &_URL
'" method="get">'/
'<input type="hidden" name="_service" value="default" />'/
'<input type="hidden" name="_program" value="' &_program
'"/>';

***** get parameter values *****;
temp = symget('input');
type = symget('convert');

***** input temperature *****;
put '<p><strong>Enter a temperature and select a conversion
type: </strong>'/
'<input type="text" name="input" value="' temp '"/></p>';

***** select conversion/compute result *****;
put '<p><input type="radio" name="convert" value="1"' @;
if (type = '1') then do;
put 'checked="checked"' @;
result = 5*(input(temp,8.) - 32)/9;
end;
put '> Fahrenheit to Centigrade</p>';
put '<p><input type="radio" name="convert" value="2"' @;
if (type = '2') then do;
put 'checked="checked"' @;
result = 9*input(temp,8.)/5 + 32;
end;
put '> Centigrade to Fahrenheit</p>';

***** Submit button *****;
put '<p><input type="submit" value = "Submit"></p>';

***** Display results *****;
if (temp > ' ') then do;
put '<p><strong>Result: </strong>'/
'<input type="text" name="result" value="' result 6.2
'"/></p>';
end;

**** write bottom of page *****;
put '</form>'/
'</div>'/
'</body>'/
'</html>';
run;
Example 6.3 PROC APPSRV
proc appsrv unsafe='&";%''' &sysparm;
allocate file sample '!SASROOT\IntrNet\sample';
allocate library samplib '!SASROOT\IntrNet\sample' access=readonly;
allocate library sampdat '!SASROOT\IntrNet\sample' access=readonly;
allocate library tmplib 'C:\Program Files\SAS\IntrNet\default\temp';
allocate file logfile 
'C:\Program Files\SAS\IntrNet\default\logs\%a_%p.log';

/* allocate new program library */
allocate file examples 'c:\Inetpub\scripts\examples';
proglibs examples;

proglibs sample samplib %ifcexist(sashelp.webeis) sashelp.webprog;
proglibs sashelp.websdk1;
adminlibs sashelp.webadmn;
datalibs sampdat tmplib;
log file=logfile;
quit;
Example 6.4 Using ODS to Display Procedure Output
%* Sales report Example - Display Product by Region;
%macro salesrpt;
%global region;
proc report data=sashelp.shoes;
by region;
%if (&region ne ) %then %do;
where region="&region";
%end;
title "Sales by Product";
footnote "Data are current as of &systime &sysdate9";
column product sales;
define product / group;
define sales / analysis sum;
quit;
%mend salesrpt;
/* redirect output to client */
ods html3 body=_webout;
%salesrpt
Example 6.5 Using ODS MARKUP to Customize Procedure Output
/* prepend XHTML template */
libname userlib 
"c:\Documents and Settings\frederick\My Documents\My SAS Files\9.1";
ods path (prepend) userlib.templat;

/* redirect output to client */
ods markup body=_webout tagset=xhtml;

Chapter 7
Example 7.1 Summarizing Data with htmSQL
<!DOCTYPE html
PUBLIC "-//W3C//DTD XHTML Basic 1.0//EN"
"http://www.w3.org/TR/xhtml-basic/xhtml-basic10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US">
<head>
<title>SAS IntrNet Examples: htmSQL</title>
<style type="text/css">
body { text-align: center; }
caption { font-weight: bold; }
h1 { color: blue; }
h3 { color: red; }
td { text-align: right; }
p.foot { font-weight: bold; }
</style>
</head>
<body>
{query server="hygelac:5011" sapw="user" userid="sas" password="sasuser" }
{sql}
select product,
sum(sales) as total label="Total Sales" format=dollar8.
from sashelp.shoes
where region='{&region}'
group by product
{/sql}
<h1>Shoe Sales by Product</h1>
<hr/>
{norows}
<h3>No rows selected. Check that the region parameter has been specified correctly.</h3>
{/norows}
<table border="1" cellpadding="4" cellspacing="0"
align="center">
<caption>Region: {&region}</caption>
<tr>
{label var="{&sys.colname[*]}"
before="<th>"
between="</th><th>"
after="</th>"}
</tr>
{eachrow}
<tr>
{ &{&sys.colname[*]}
before="<td>"
between="</td><td>"
after="</td>" }
</tr>
{/eachrow}
</table>
{/query}
<hr/>
<p class="foot">Data are current as of {&sys.time}{&sys.ampm}
{&sys.month} {&sys.monthday}, {&sys.year}
</p>
</body>
</html>
Example 7.2 htmSQL Code to Generate Form Control Values
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML Basic 1.0//EN"
"http://www.w3.org/TR/xhtml-basic/xhtml-basic10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US">
<head>
<title>SAS IntrNet Examples: htmSQL</title>
</head>
<body>
{query server="hygelac:5011"
sapw="user" userid="sas" password="sasuser" }
{sql} select distinct region from sashelp.shoes{/sql}
<div style="text-align: center; ">
<form method=get action="http://hunding/scripts/htmSQL.exe/example7-1.hsql">
<h1 style="color: blue;">International Shoe Company</h1>
<h2>Request Current Sales Report</h2>
<p>Select Region:
<select name=region>
{eachrow}<option>{&region}</option>{/eachrow}
</select>
<input type="submit" />
</p>
</form>
</div>
{/query}
</body>
</html>

Chapter 8
Example 8.1 The Basic JavaBean
// A simple Bean
import java.io.Serializable;
public class TestBean
implements Serializable
{
private int num;
public void setValue(int n)
{
num = n;
}
public int getValue()
{
return num;
}
}
Example 8.2 Hello World Servlet
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
public class HelloWorld extends HttpServlet
{
public void doGet (HttpServletRequest request,
HttpServletResponse response)
throws ServletException, IOException
{
PrintWriter out;
String title = "Simple Servlet Output";
response.setContentType("text/html");
out = response.getWriter();
out.println("<HTML><HEAD><TITLE>");
out.println(title);
out.println("</TITLE></HEAD><BODY>");
out.println("<H1>" + title + "</H1>");
out.println("<P>Hello World!");
out.println("</BODY></HTML>");
out.close();
}
public void doPost (HttpServletRequest request, 
HttpServletResponse response)
throws ServletException, IOException
{
doGet(request, response);
}
}
Example 8.3 Servlet Configuration File web.xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE web-app PUBLIC
"-//Sun Microsystems, Inc.//DTD Web Application 2.3//EN"
"http://java.sun.com/dtd/web-app_2_3.dtd">
<web-app>
<display-name>
BBU Examples
</display-name>
<description>
Hello World servlet example
</description>
<servlet>
<servlet-name>HelloWorld</servlet-name>
<servlet-class>HelloWorld</servlet-class>
</servlet>
<servlet-mapping>
<servlet-name>HelloWorld</servlet-name>
<url-pattern>/HelloWorld</url-pattern>
</servlet-mapping>
</web-app>

Example 8.4 Simple JSP Example
<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>JSP Examples</title>
<style type="text/css">
h1 { color: blue; }
body { font-family: helvetica, arial; }
</style>
</head>
<body>
<h1>Simple JavaServer Page</h1>
<% out.print("Hello World!"); %>
The time now is <%= new java.util.Date() %>
</body>
</html>
Example 8.5 Custom Tag Handler
import java.util.Date;import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;
public class SimpleTag extends TagSupport
{
public int doStartTag() throws JspException
{
try
{
pageContext.getOut().print
("Hello World." + "The time now is " + new Date());
}
catch (Exception ex)
{
throw new JspTagException
("SimpleTag: " + ex.getMessage());
}
return SKIP_BODY;
}
public int doEndTag()
{
return EVAL_PAGE;
}
}
Example 8.6 Tag Library Description
<?xml version="1.0"?>
<!DOCTYPE taglib PUBLIC
"-//Sun Microsystems, Inc.//DTD JSP Tag Library 1.2//EN"
"http://java.sun.com/dtd/web-jsptaglibrary_1_2.dtd" >
<taglib>
<tlib-version>1.0</tlib-version>
<jsp-version>1.2</jsp-version>
<short-name>Sample tag library</short-name>
<description>Library for simple tag example</description>
<tag>
<name>SayHello</name>
<tag-class> SimpleTag</tag-class>
<tei-class>EMPTY</tei-class>
<description>Hello world example</description>
</tag>
</taglib>
Example 8.7 JSP Using Custom Tags
<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib URL="simple.tld" prefix="test" %>
<head>
<title>JSP Examples ? Custom Tag Library</title>
<style type="text/css">
h1 { color: blue; }
body { font-family: helvetica, arial; }
</style>
</head>
<body>
<h1>JavaServer Page Custom Tag Example</h2>
<test:SayHello />
</body>
</html>
Example 8.8 JDBC Example
import java.sql.*;
/* connection test to a remote SAS/SHARE server using JDBC */
public class JDBCTest
{
public static void main(String[] args)
{
Connection con = null;
try // open connection to database
{
Class.forName(
"com.sas.net.sharenet.ShareNetDriver");
con = DriverManager.getConnection(
"jdbc:sharenet://hunding:8551?
user=sasdemo&password=sasuser");
// print connection information
DatabaseMetaData dma = con.getMetaData();
System.out.println("Connected to " + dma.getURL());
System.out.println("Driver " + dma.getDriverName());
System.out.println("Version " + dma.getDriverVersion());
}
catch(Exception e) { e.printStackTrace(); }
finally // make sure connection gets closed properly
{
Try { if (null != con) con.close(); }
catch (SQLException e) {}
}
}
}
Example 8.9 Using JDBC with JSTL Custom Tags
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<html>
<head>
<title>JSP Examples - JDBC</title>
<style type="text/css">
h1 { color: maroon; text-align: center; }
h2 { color: blue; text-align: center;}
body { font-family: helvetica, arial; }
td.c { text-align: center; }
td.r { text-align: right; }
th { background-color: yellow; width: 10%; }
</style>
</head>
<body>
<h1>SASHELP.CLASS</h1>
<h2>SAS Share JDBC Driver</h2>
<table border="1" align="center" id="class dataset">
<%-- open a database connection --%>
<sql:setDataSource var="datasource"
driver="com.sas.net.sharenet.ShareNetDriver"
url="jdbc:sharenet://hunding:8551?
user=sasdemo&password=sasuser"/>

<%-- execute the database query --%>
<sql:query var="students" dataSource="${datasource}" >
select * from sashelp.class
</sql:query>

<%-- Print the column names for the header of the table --%>
<tr>
<th>Name</th>
<th>Age</th>
<th>Sex</th>
<th>Height</th>
<th>Weight</th>
</tr>
<%-- loop through the rows of the query --%>
<c:forEach var="row" items="${students.rows}">
<tr>
<td><c:out value="${row.name}"/></td>
<td class="r"><c:out value="${row.age}"/></td>
<td class="c"><c:out value="${row.sex}"/></td>
<td class="r"><c:out value="${row.height}"/></td>
<td class="r"><c:out value="${row.weight}"/></td>
</tr>
</c:forEach>
</table>
</body>
</html>
Example 8.10 HTML Data Entry Form
<html>
<head>
<title>JSP Examples: JSTL Demo</title>
</head>
<body style="font-family: verdana, tahoma, ariel;">
<div style="width: 50%; margin-left: auto; margin-right: auto;">
<h1 style="color: #0000FF;">Demo Entry Form</h1>
<form method="get" action="update.jsp">
<table border="0" id="input form">
<tr>
<td style="font-weight: bold;">Name</td>
<td><input type="text" name="name" /></td>
</tr>
<tr>
<td style="font-weight: bold; verticalalign:top">
Gender
</td>
<td>
<input type="radio" name="sex" value="M"> 
Male <br />
</input>
<input type="radio" name="sex" value="F">
Female
</input>
</td>
</tr>
<tr>
<td style="font-weight: bold;">Age</td>
<td><input type="text" name="age" /></td>
</tr>
<tr>
<td style="font-weight: bold;">Height</td>
<td><input type="text" name="height" /></td>
</tr>
<tr>
<td style="font-weight: bold;">Weight</td>
<td><input type="text" name="weight" /></td>
</tr>
</table>
<p>
<input type="submit" value="Submit"/>
<input type="reset" value="Reset" />
</p>
</form>
</div>
<body>
</html>
Example 8.11 Updating a Database with JSTL and JDBC
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<html>
<head>
<title>JSP Examples: JSTL Demo</title>
</head>
<%-- update data --%>
<% /* SQL code to append parameters to CLASS table */
String strSQL="INSERT INTO sashelp.class SET " +
"name=\""+request.getParameter("name")+"\","+
"sex=\""+request.getParameter("sex")+"\","+
"age="+request.getParameter("age")+","+
"height="+request.getParameter("height")+","+
"weight="+request.getParameter("weight");
%>
<sql:setDataSource var="class" driver="com.sas.rio.MVADriver"
url="jdbc:sasiom://hunding:8591" user="sasdemo" password="sasuser"/>
<sql:update dataSource="${class}">
<%=strSQL %>
</sql:update>
<body style="font-family: verdana, tahoma, arial;">
<p>The class file has been updated.</p>
</body>
</html>

Chapter 9
Example 9.1 JSP Header
<% @taglib URL="http://www.sas.com/taglib/sas" prefix="sas"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>JSP Examples</title>
</head>
<body>
<h1 style="color: blue">Temperature Conversion Calculator</h1>
[Java scriptlet comes next]
[HTML form code follows]
</body>
</html>
Example 9.2 Java Temperature Conversion Scriptlet
<% // Java scriptlet to calculate temperature conversion
String temp = request.getParameter("input");
String type = request.getParameter("convert");
String result = new String();

// make sure that we have values for the parameters
if (null != temp && null != type)
{
double dt = new Double(temp).doubleValue();
if (type.charAt(0) == 'F')
result = String.valueOf(5.0 * (dt - 32.0)/9.0);
else if (type.charAt(0) == 'C')
result = String.valueOf((9.0 * dt) / 5.0d + 32.0);
}
%>
Example 9.3 JSP Temperature Conversion Calculator
<%-- JSP Temperature Conversion Calculator --%>
<%@ include file="header.html" %>
<% // Java scriptlet to calculate temperature
String temp = request.getParameter("input");
String type = request.getParameter("convert");
String result = new String();
// make sure that we have values for the parameters
if (null != temp && null != type)
{
double dt = new Double(temp).doubleValue();
if (type.charAt(0) == 'F')
result = String.valueOf(5d * (dt - 32d)/9d);
else if (type.charAt(0) == 'C')
result = String.valueOf((9d * dt) / 5d + 32d);
}
%>
<h1 style="color: blue">Temperature Conversion Calculator</h1>
<sas:Form id="calculator" action="F2C.jsp" method="get">
<p>
<sas:TextEntry id="input"
prolog="<strong>Enter a temperature and select a
conversion type: </strong>"
size="8" text="<%=temp%>" />
</p>
<p>
<sas:Radio id="convert" selectedItem="<%=type%>">
Fahrenheit to Centigrade
Centigrade to Fahrenheit
</sas:Radio>
</p>
<p>
<sas:TextEntry id="output"
prolog="<strong>Result: </strong>"
size="8" text="<%=result%>" />
</p>
<sas:PushButton id="submit" text="Submit" />
</sas:Form>

Example 9.4 Scriptlet with pageContext Attributes
<%@ page import="com.sas.collection.OrderedCollection" %>
<% // Java scriptlet to calculate temperature
String temp = request.getParameter("input");
String type = request.getParameter("convert");
String result = new String();

// default is 1st radio button
int checked = 0;

// add the labels for the radio buttons to the page context
pageContext.setAttribute
( "values", new OrderedCollection("F,C") );
pageContext.setAttribute
( "labels", new OrderedCollection
("Fahrenheit to Centigrade, Centigrade to Fahrenheit"));
if (null != temp && null != type)
{
double dt = new Double(temp).doubleValue();
if (type.charAt(0) == 'F')
{
result = String.valueOf(5.0 * (dt - 32.0)/9.0);
}
else if (type.charAt(0) == 'C')
{
result = String.valueOf((9.0 * dt) / 5.0 + 32.0);
checked = 1;
}
}
%>
<p>
<sas:Radio id="convert" selectedItem="<%=type%>">
Fahrenheit to Centigrade
Centigrade to Fahrenheit
</sas:Radio></p>
<p><sas:TextEntry id="output" 
prolog="<strong>Result: </strong>"
size="8" text="<%=result%>" /></p>
<sas:PushButton id="submit" text="Submit" />
</sas:Form>
<%@ include file="footer.html" %>
Example 9.5 Sample PROC REPORT Macro
options nodate nonumber noovp nocenter pagesize=20;
/* Sample Program: shoes.sas */
%macro salesrpt(region);
proc report data=sashelp.shoes;
by region;
%if ( &region ne null ) %then %do;
where region="&region";
%end;
title "<h2>Shoe Sales by Region x Product</h2>";
footnote "Data are current as of &systime &sysdate9";
column product sales;
define product / group;
define sales / analysis sum;
quit;
%mend salesrpt;
%salesrpt(<%= request.getParameter("region") %>)
Example 9.6 JavaServer Page Using SubmitInterface
<%@ taglib uri=http://www.sas.com/taglib/sasads prefix="sasads" %>
<%@ include file="header.html" %>
<body>
<h1>SubmitInterface Example</h1>
<sasads:Connection id="connection1" serverArchitecture="IOM"
host="hunding" port="8591" 
username="sasdemo" password="sasuser">
<sasads:Submit
connection="connection1"
display="LASTOUTPUT" scope="page">
<%@ include file="shoes.sas" %>
</sasads:Submit>
</sasads:Connection>
</body>
<html>
Example 9.7 Using the SAS Appdev Studio 2.0 DataSetInfo Interface
<%@ taglib uri="http://www.sas.com/taglib/sasads"
prefix="sasads"%>
<%@ page import="com.sas.sasserver.datasetinfo.DataSetInfoInterface" %>
<%@ page import="com.sas.collection.OrderedCollection" %>
<%@ include file="header.html" %>
<sasads:Connection
id="connection1" serverArchitecture="IOM" scope="session"
host="hunding" port="8591"
username="sasadm" password="system"/>
<% // Java scriptlet to add choicebox values to page context
DataSetInfoInterface dsinfo = (DataSetInfoInterface)
com.sas.servlet.util.Util.newInstance
(connection1.getClassFactory(),
connection1,
DataSetInfoInterface.class);
dsinfo.setDataSet("SASHELP.SHOES");

// display unique values of region
int index = dsinfo.getVariableIndex("REGION");
pageContext.setAttribute("values",
new OrderedCollection
(dsinfo.getVariableUniqueValues(index)));
%>
<div align="center">
<h1>International Shoe Sales Data</h1>
<sasads:Form action="index.jsp" >
<sasads:Choicebox id="region" model="values"
prolog="<strong>Select region for report: </strong>" />
<sasads:PushButton id="submit" text="Submit" />
</sasads:Form>
</div>

Chapter 10
Example 10.1 Visual Basic Code to Test a DCOM Workspace Connection
Option Explicit

' define a global workspace
Dim obSAS As SAS.Workspace
Dim obWSMgr As New SASWorkspaceManager.WorkspaceManager

Private Sub Form_Load()
Dim xmlInfo As String
' create Workspace server
Dim obServer As New SASWorkspaceManager.ServerDef
obServer.MachineDNSName = "hunding"
Set obSAS = obWSMgr.Workspaces.CreateWorkspaceByServer _
("", VisibilityProcess, obServer, "", "", xmlInfo)
End Sub

Private Sub cmdTest1_Click()
' use LanguageService to submit code
obSAS.LanguageService.Submit _
"%include 'c:\temp\IOMTest.sas'; run;"
MsgBox obSAS.LanguageService.FlushLog(100000)
MsgBox obSAS.LanguageService.FlushList(100000)
End Sub

Private Sub cmdTest2_Click()
'run the stored SAS program
Dim obStoredProcessService As SAS.StoredProcessService
Set obStoredProcessService = _
obSAS.LanguageService.StoredProcessService
obStoredProcessService.Repository = "file:c:\temp"
obStoredProcessService.Execute "IOMtest", _
"cond='sex eq ""M""'"
MsgBox obSAS.LanguageService.FlushLog(100000)
MsgBox obSAS.LanguageService.FlushList(1000000)
End Sub

Private Sub Form_Unload(Cancel As Integer)
obWSMgr.Workspaces.RemoveWorkspaceByUUID obSAS.UniqueIdentifier
obSAS.Close
End Sub
Example 10.2 Visual Basic Code to Open an IOM Bridge Workspace Connection
' create Workspace server using IOM Bridge for COM
Dim obServer As New SASWorkspaceManager.ServerDef
obServer.MachineDNSName = "hygelac"
obServer.Protocol = ProtocolBridge
obServer.Port = 8591
Set obSAS = obWSMgr.Workspaces.CreateWorkspaceByServer _
("", VisibilityProcess, obServer, "sassrv", "sasuser", xmlInfo)
Example 10.3 Sample SAS Program
%let cond=;
*ProcessBody;
proc print data=sashelp.class;
title "Test IOM Connection";
where &cond;
run;
Example 10.4 C++ Code to Test a DCOM Workspace Connection
#include <iostream>
#include <stdexcept>
#include <windows.h>
using namespace std;
#import "C:\Program Files\SAS Institute\Shared Files\Integration
Technologies\sas.tlb"
#import "C:\Program Files\SAS Institute\Shared Files\Integration
Technologies\SASWMan.dll"
int main()
{
SASWorkspaceManager::IWorkspaceManager2Ptr pIWorkspaceManager;
SASWorkspaceManager::IServerDef2Ptr pIServerDef = NULL;
SAS::IWorkspacePtr pIWorkspace;
BSTR xmlInfo;
HRESULT hr = CoInitialize(NULL);
hr = pIWorkspaceManager.CreateInstance(
"SASWorkspaceManager.WorkspaceManager.1");
pIServerDef.CreateInstance("SASWorkspaceManager.ServerDef");
pIServerDef->PutMachineDNSName("hygelac");
pIServerDef->Protocol = SASWorkspaceManager::ProtocolBridge;
pIServerDef->put_Port(8591);
pIWorkspace = pIWorkspaceManager->Workspaces->CreateWorkspaceByServer(
_bstr_t(""), //workspace name
SASWorkspaceManager::VisibilityProcess,
pIServerDef, // server
_bstr_t("sassrv"), // login
_bstr_t("sasuser"), // password
&xmlInfo // connection log
);
pIWorkspace->LanguageService->Submit(
"%include '/home/sasadm/IOMTest.sas'; run;");
MessageBox(NULL,
pIWorkspace->LanguageService->FlushLog(10000),
"SAS Log",
MB_OK
);
MessageBox(NULL,
pIWorkspace->LanguageService->FlushList(10000),
"List Output",
MB_OK
);
pIWorkspace->Close();
return(0);
}
Example 10.5 Java Code to Test an IOM Bridge Workspace Connection
import com.sas.services.connection.Server;
import com.sas.services.connection.BridgeServer;
import com.sas.services.connection.ConnectionFactoryConfiguration;
import com.sas.services.connection.ConnectionFactoryManager;
import com.sas.services.connection.ConnectionFactoryInterface;
import com.sas.services.connection.ConnectionFactoryException;
import com.sas.services.connection.ConnectionInterface;
import com.sas.services.connection.ManualConnectionFactoryConfiguration;
import com.sas.iom.SAS.IWorkspace;
import com.sas.iom.SAS.IWorkspaceHelper;
import com.sas.iom.SAS.ILanguageService;
import com.sas.iom.SAS.ILanguageServicePackage.CarriageControlSeqHolder;
import com.sas.iom.SAS.ILanguageServicePackage.LineTypeSeqHolder;
import com.sas.iom.SASIOMDefs.GenericError;
import com.sas.iom.SASIOMDefs.StringSeqHolder;
import javax.swing.JOptionPane;

public class IOMTest{

public IOMTest() throws ConnectionFactoryException, GenericError
{
// connection parameters
String classID = Server.CLSID_SAS;
String host = "hunding";
int port = 8591;
String userName = "sassrv";
String password = "sasuser";

// identify the IOM Bridge server (the Workspace server)
Server server = new BridgeServer(classID,host,port);

// make a manual connection factory configuration
ConnectionFactoryConfiguration cxfConfig =
new ManualConnectionFactoryConfiguration(server);

// get a connection factory manager
ConnectionFactoryManager cxfManager =
new ConnectionFactoryManager();

// get a connection factory interface from the manager
ConnectionFactoryInterface cxf = cxfManager.getFactory(cxfConfig);

// get a connection from the interface
ConnectionInterface cx = cxf.getConnection(userName,password);

// create a workspace by "narrowing" connection to the ORB
IWorkspace iWorkspace = IWorkspaceHelper.narrow(cx.getObject());

// Submit batch SAS code
ILanguageService sasLanguage = iWorkspace.LanguageService();
sasLanguage.Submit("%include 'c:\\temp\\IOMtest.sas'; run;");

// flush log file to string array
StringSeqHolder logHldr = new StringSeqHolder();
sasLanguage.FlushLogLines(
Integer.MAX_VALUE,
new CarriageControlSeqHolder(),
new LineTypeSeqHolder(),
logHldr);

// display log file
String[] logLines = logHldr.value;
JOptionPane.showMessageDialog(null, logLines);

// flush list file to string array
StringSeqHolder listHldr = new StringSeqHolder();
sasLanguage.FlushListLines(
Integer.MAX_VALUE,
new CarriageControlSeqHolder(),
new LineTypeSeqHolder(),
listHldr);

// display list file
String[] listLines = listHldr.value;
JOptionPane.showMessageDialog(null, listLines);
iWorkspace.Close();
cx.close();
}
public static void main(String args[]) {
try {
new IOMTest();
System.exit(0);
}
catch(Exception ex) {
ex.printStackTrace();
System.exit(1);
}
}
}

Chapter 11
Example 11.1 Tomcat Installation Batch File
set JAVA_HOME=C:\j2sdk1.4.2_05
set CATALINA_HOME=C:\Tomcat4.1
set CATALINA_OPTS=-Xms512m -Xmx1024m 
-server XX:-UseOnStackReplacement -Djava.awt.headless=true
rem The following command should be on a single line
%CATALINA_HOME%/bin/tomcat.exe
install Apache-Catalina %JAVA_HOME%/jre/bin/server/jvm.dll -
Djava.security.manager
Djava.security.policy=%CATALINA_HOME%/conf/catalina.policy -
Djava.class.path=%CATALINA_HOME%/bin/bootstrap.jar;
%JAVA_HOME%/lib/tools.jar
Dcatalina.home=%CATALINA_HOME% %CATALINA_OPTS% -Xrs
start org.apache.catalina.startup.BootstrapService
params start
stop org.apache.catalina.startup.BootstrapService
params stop
out %CATALINA_HOME%/logs/stdout.log
err %CATALINA_HOME%/logs/stderr.log\
Example 11.2 Sample Program to Generate Dynamic Output
%* Sales report Example ? Display Product by Region;
%macro salesrpt;
%global region;
proc report data=sashelp.shoes;
by region;
%if (&region ne ) %then %do;
where region="&region";
%end;
title "Sales by Product by Region";
footnote "Data are current as of &systime &sysdate9";
column product sales;
define product / group;
define sales / analysis sum;
quit;
%mend salesrpt;
%salesrpt
Example 11.3 Sample Stored Process Service Application3
package servlets;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.sas.services.discovery.LocalDiscoveryServiceInterface;
import com.sas.services.discovery.DiscoveryService;
import com.sas.services.discovery.ServiceTemplate;
import com.sas.services.user.UserServiceInterface;
import com.sas.services.user.UserContextInterface;
import com.sas.services.session.SessionServiceInterface;
import com.sas.services.session.SessionContextInterface;
import com.sas.services.storedprocess.StoredProcessServiceFactory;
import com.sas.services.storedprocess.StoredProcessServiceInterface;
import com.sas.services.storedprocess.StoredProcessInterface;
import com.sas.services.storedprocess.ExecutionInterface;
import com.sas.services.connection.BridgeServer;
import com.sas.services.connection.Server;
import com.sas.services.connection.ConnectionFactoryInterface;
import com.sas.services.connection.ConnectionFactoryManager;
import com.sas.services.connection.ConnectionInterface;
import com.sas.services.connection.ConnectionFactoryConfiguration;
import
com.sas.services.connection.ManualConnectionFactoryConfiguration;
import com.sas.services.deployment.MetadataSourceInterface;
import com.sas.services.deployment.OMRMetadataSource;
import com.sas.services.deployment.ServiceLoader;
public class SimpleServlet extends HttpServlet
{
public void doPost (HttpServletRequest request,
HttpServletResponse response) throws IOException
{
PrintWriter out=response.getWriter();
response.setContentType("text/html");

// run-time values for Metadata server connection parameters
String host="hunding";
String port = "8561";
String userName = "sasdemo";
String password = "password";
String repository = "Foundation";
String softwareComponent = "Remote Services";
String serviceComponent = "BIP Remote Services OMR";

// run-time values for Stored Process server connection
int bridgeport = 8611;
String file="c:\\Documents and Settings\\sas\\My Documents";
String pgm="shoes.sas";
try 
{
// connect to Metadata server on port 8561 to discover Services
LocalDiscoveryServiceInterface discoveryService =
DiscoveryService.defaultInstance();
MetadataSourceInterface metadataSource = 
new OMRMetadataSource(host,port,userName,password,
repository,softwareComponent,serviceComponent);
ServiceLoader.lookupRemoteDiscoveryServices(
metadataSource, discoveryService);

// create user context
ServiceTemplate stp = new ServiceTemplate(
new Class[] {UserServiceInterface.class} );
UserServiceInterface userService = (UserServiceInterface)
discoveryService.findService(stp);
UserContextInterface user =
userService.newUser(userName,password,"DefaultAuth");

// create session context
stp = new ServiceTemplate( new Class[]
{SessionServiceInterface.class} );
SessionServiceInterface sessionService =
(	SessionServiceInterface)
discoveryService.findService(stp);
SessionContextInterface sessionContext =
sessionService.newSessionContext(user);

// create stored process service
StoredProcessServiceFactory spFactory =
new StoredProcessServiceFactory();
StoredProcessServiceInterface spServiceInterface =
spFactory.getStoredProcessService();
StoredProcessInterface spi =
spServiceInterface.newStoredProcess(
sessionContext,
StoredProcessInterface.SERVER_TYPE_STOREDPROCESS,
StoredProcessInterface.RESULT_TYPE_STREAM);

// send messages to stored process
spi.setSourceFromFile(file,pgm);
spi.setParameterValue("region","Canada");
spi.addInputStream("_WEBOUT");

// connect to Stored Process Server on
// load balancing port 8611
BridgeServer server = new BridgeServer(
Server.CLSID_SASSTP,host,bridgeport);
ConnectionFactoryConfiguration cxfConfig =
new ManualConnectionFactoryConfiguration(server);
ConnectionFactoryInterface cxf = ConnectionFactoryManager.
getConnectionFactory(cxfConfig);
ConnectionInterface ci =
cxf.getConnection(userName,password);

// run stored process
ExecutionInterface ei = spi.execute(false,null,false,ci);

// display results
InputStream is = ei.getInputStream("_WEBOUT");
BufferedReader br = new BufferedReader(
new InputStreamReader(is));
String temp = "";
while((temp = br.readLine()) != null) 
{
out.println(temp);
}
}
catch (Exception ex) {
out.println("<html><body>" + "SAS encountered an error: " +
ex.getLocalizedMessage() + "</body></html>");
}
}
public void doGet(HttpServletRequest request,
HttpServletResponse response)
throws ServletException, IOException
{
doPost(request, response);
}
}

Appendix A
Example A.1 JavaScript Date Example
<html>
<head>
<title>Display Date Using JavaScript</title>
</head>
<body>
<script type="text/javascript">
today = new Date();
var message = "<h1>Today is " +
(today.getMonth()+1) + "/" +
today.getDate() + "/" +
today.getYear() + ".</h1>";
document.write(message);
</script>
</body>
</html>
Example A.2 JavaScript Temperature Conversion Calculator
<html>
<head>
<title>JavaScript Temperature Conversion Calculator</title>
<script type="text/javascript">
function calc(n) {
var temp = document.calculator.input.value;
if (n == 1)
document.calculator.result.value = 5*(temp-32)/9;
else
document.calculator.result.value = (9*temp)/5+32;
}
</script>
</head>
<body>
<div style="text-align: center">
<h1 style="color: blue">Temperature Conversion Calculator</h1>
<form name="calculator">
<p><strong>Enter a temperature and
select a conversion type: </strong>
<input type="text" name="input" /></p>
<p><strong>Result: </strong>
<input type="text" name="result" /></p>
<p><input type="button" onclick="calc(1)"
value="Fahrenheit to Centigrade" /></p>
<p><input type="button" onclick="calc(2)"
value="Centigrade to Fahrenheit" /></p>
</form>
</div>
</body>
</html>

Appendix B
Example B.1 Java Temperature Conversion Applet
<html>
<head>
<title>Java Temperature Conversion Applet</title>
</head>
<body>
<div style="text-align: center">
<h1 style="color: blue">
Temperature Conversion Calculator</h1>
<object code="Calculator.class"
width = 480
height = 120
alt="Java Applets are not supported. You need to update
your browser!" />
</div>
</body>
</html>
Example B.2 Temperature Conversion Applet
// Java Temperature Conversion Applet
import java.applet.*;
import java.awt.*;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
public class calculator extends Applet implements ActionListener
{
private TextField tfInput, tfResult;
private Button btF2C, btC2F;
private final String F2C = 
new String("Fahrenheit to Centigrade");
private final String C2F = 
new String("Centigrade to Fahrenheit");

//initialize user interface
public void init()
{
//set layout and foreground colors
setLayout(new BorderLayout());
setBackground(Color.white);
setFont(new Font("Times New Roman", Font.PLAIN,14));

//create text fields
tfInput = new TextField(6);
tfResult = new TextField(6);

//set result field read only
tfResult.setEditable(false);

//create buttons
btF2C = new Button(F2C);
btC2F = new Button(C2F);

//register listeners
btF2C.addActionListener(this);
btC2F.addActionListener(this);

//create 3 panels
Panel p1 = new Panel();
p1.add(new Label(
"Enter a temperature and select conversion type:"));
p1.add(tfInput);
Panel p2 = new Panel();
p2.add(new Label("Result:"));
p2.add(tfResult);
Panel p3 = new Panel();
p3.add(btF2C);
p3.add(btC2F);

// add panels to frame
add(BorderLayout.NORTH, p1);
add(BorderLayout.CENTER, p2);
add(BorderLayout.SOUTH, p3);
}
//event handler for buttons
public void actionPerformed(ActionEvent e)
{
String actionCommand = e.getActionCommand();
double t1, t2;

// get input temp
t1 = (Double.valueOf(tfInput.getText())).doubleValue();

// compute result
t2 = actionCommand.equals(F2C) ? 5.0*(t1-32.0)/9.0 : 9.0*t1/5.0 + 32.0;

// display result
tfResult.setText(String.valueOf(t2));
}
}
Example B.3 Temperature Conversion Applet (Swing)
import javax.swing.*;
import java.awt.*; // include font, colors, layouts
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
public class Jcalculator extends Japplet implements ActionListener
{
private JTextField tfInput, tfResult;
private JButton btF2C, btC2F;
private final String F2C = new String("Fahrenheit to Centigrade");
private final String C2F = new String("Centigrade to Fahrenheit");

//initialize user interface
public void init()
{
//format the applet's content pane
getContentPane().setLayout(new BorderLayout());
getContentPane().setBackground(Color.white);
getContentPane().setFont
(new Font("Times New Roman", Font.PLAIN, 14));

//create text fields
tfInput = new JTextField(6);
tfResult = new JTextField(12);

//set result field read only
tfResult.setEditable(false);

//create buttons
btF2C = new JButton(F2C);
btC2F = new JButton(C2F);

//register listeners
btF2C.addActionListener(this);
btC2F.addActionListener(this);

//create 3 panels
JPanel p1 = new JPanel();
p1.add(new JLabel(
"Enter a temperature and select conversion type:"));
p1.add(tfInput);
JPanel p2 = new JPanel();
p2.add(new JLabel("Result:"));
p2.add(tfResult);
JPanel p3 = new JPanel();
p3.add(btF2C);
p3.add(btC2F);

// add panels to content pane
getContentPane().add(BorderLayout.NORTH, p1);
getContentPane().add(BorderLayout.CENTER, p2);
getContentPane().add(BorderLayout.SOUTH, p3);
}
}
Example B.4 HTML Source for Locating and Downloading the Java Plug-in
<html>
<head>
<title>Java Temperature Conversion Applet</title>
</head>
<body>
<div style="text-align: center">
<h1 style="color: blue">Temperature Conversion Calculator</h1>
<object classid="clsid:CAFEEFAC-0015-0000-0000-ABCDEFFEDCBA"`
width="480" height="120"
codebase="http://java.sun.com/products/plugin/autodl/
jinstall-1_5_0-windows-i586.cab#Version=1,5,0,0">
<param NAME="code" VALUE="JCalculator.class">
<param NAME="codebase" VALUE="/BBU">
<param name="scriptable" value="false">
</object>
</div>
</body>
</html>
Example B.5 HelloWorld Applet
import java.awt.Graphics;
public class HelloWorld extends java.applet.Applet
{
public void paint( Graphics g )
{
g.drawString( "Hello, World!", 60, 30 );
}
}
Example B.6 HelloWorld HTML
<html>
<head>
<title>Hello World Example</title>
</head>
<body>
<hr>
<applet code="HelloWorld.class" 
name="HelloWorld"
width=200 height=200 />
<hr>
</body>
</html>
Example B.7 webAFCalculator.html
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">
<HTML>
<HEAD>
<TITLE>webAFCalculator</TITLE>
</HEAD>
<BODY>
<!{{~SAS~(APPLET) - Generated Code - Do Not Edit!>
<SCRIPT LANGUAGE="JavaScript"><!--
var _info = navigator.userAgent;
var _ns = false;
var _ie = (_info.indexOf("MSIE") > 0
&& _info.indexOf("Win") > 0
&& _info.indexOf("Windows 3.1") < 0);
//--></SCRIPT>
<COMMENT>
<SCRIPT LANGUAGE="JavaScript1.1"><!--
var _ns = (navigator.appName.indexOf("Netscape") >= 0
&& ((_info.indexOf("Win") > 0
&& _info.indexOf("Win16") < 0
&& java.lang.System.getProperty(
"os.version").indexOf("3.5") < 0)
|| (_info.indexOf("Sun") > 0) ||
(_info.indexOf("Linux") > 0) ));
//--></SCRIPT>
</COMMENT>
<SCRIPT LANGUAGE="JavaScript"><!--
if (_ie == true) {
document.writeln(" <OBJECT");
document.writeln(" CLASSID=\"clsid:8AD9C840-044E-11D1-B3E9-
00805F499D93\"");
document.writeln("
CODEBASE=\"http://java.sun.com/products/plugin/autodl/jinstall-
1_4-windows-i586.cab#Version=1,4,0,0\"");
document.writeln(" HEIGHT=400");
document.writeln(" NAME=\"webAFCalculator\"");
document.writeln(" WIDTH=600");
document.writeln(" ID=\"webAFCalculator\"");
document.writeln(" >");
document.writeln(" <NOEMBED><XMP>");
}
else if (_ns == true) {
document.writeln(" <EMBED");
document.writeln("
PLUGINSPAGE=\"http://java.sun.com/products/plugin/index.html#
download\"");
document.writeln(" TYPE=\"application/x-javaapplet;
version=1.4\"");
document.writeln(" HEIGHT=400");
document.writeln(" NAME=\"webAFCalculator\"");
document.writeln(" WIDTH=600");
document.writeln("
ARCHIVE=\"JSASNetCopyApplet.jar,JSASNetCopy.jar\"");
document.writeln("
CODE=\"com.sas.tools.JSASNetCopy.applet.InstallApplet.class\"");
document.writeln("
java_codebase=\"http://hygelac/sasweb/Tools/JSASNetCopy/\"");
document.writeln(" Applet:CODE=\"webAFCalculator.class\"");
document.writeln(" ><NOEMBED><XMP>");
}
//--></SCRIPT>
<APPLET CODEBASE="http://hygelac/sasweb/Tools/JSASNetCopy/"
ARCHIVE="JSASNetCopyApplet.jar,JSASNetCopy.jar" HEIGHT=400
CODE="com.sas.tools.JSASNetCopy.applet.InstallApplet.class"
NAME="webAFCalculator" WIDTH=600 ></XMP>
<PARAM NAME="CODEBASE"
VALUE="http://hygelac/sasweb/Tools/JSASNetCopy/">
<PARAM NAME="ARCHIVE"
VALUE="JSASNetCopyApplet.jar,JSASNetCopy.jar">
<PARAM NAME="CODE"
VALUE="com.sas.tools.JSASNetCopy.applet.InstallApplet.class">
<PARAM NAME="Applet:CODE" VALUE="webAFCalculator.class">
</APPLET>
</NOEMBED></EMBED></OBJECT>
<!}}~SAS~(APPLET)>
</BODY>
</HTML>

Appendix C
Example C.1 Generated HTML Source Code
<html>
<head>
<title>SAS Design Time Controls Example</title>
</head>
<body>
<h1>DTC Table Control: SASHELP.RETAIL</h1>
<p><!--metadata type="DesignerControl" startspan
<object 
classid="clsid:6ED5010A-D596-11D3-87D7-00C04F2C0BF6" 
id="Table1" dtcid="2">
<param name="BrokerURL" value="/cgi-bin/broker">
<param name="DataSet" value="SASHELP.RETAIL">
<param name="Debug" value="0">
<param name="Password" value>
<param name="ProcessingMode" value="build">
<param name="Program" value="sashelp.websdk1.ds2htm2.scl">
<param name="Service" value="default">
<param name="SQLView" value>
<param name="WebServer" value="hygelac">
<param name="WhereClause" value="year eq 1994">
<param name="PagePart" value="body">
<param name="DisplayVariables" value>
<param name="IDVariables" value>
<param name="ByVariables" value>
<param name="SumVariables" value>
<param name="TranscodingList" value>
<param name="PropertiesList" value>
<param name="Encode" value>
<param name="CharacterSet" value>
<param name="TableWidth" value="0">
<param name="TableWidthUnits" value="Percent">
<param name="Border" value="Y">
<param name="BorderWidth" value>
<param name="TableBackgroundColor" value>
<param name="ObsBackgroundColor" value>
<param name="IDVariableBackgroundColor" value>
<param name="VariableBackgroundColor" value>
<param name="SumVariableBackgroundColor" value>
<param name="ColumnLabelBackgroundColor" value>
<param name="TableCaption" value>
<param name="NumericRoundOff" value>
<param name="CellPadding" value>
<param name="CellSpacing" value>
<param name="Formats" value="Y">
<param name="Labels" value="Y">
<param name="DisplayObs" value="N">
<param name="TableAlign" value="default">
<param name="VariableForegroundColor" value>
<param name="SumVariableForegroundColor" value>
<param name="ColumnLabelForegroundColor" value>
<param name="IDVariableForegroundColor" value>
<param name="ObsForegroundColor" value>
<param name="ByVariableForegroundColor" value>
<param name="VariableHorizontalAlign" value>
<param name="SumVariableHorizontalAlign" value>
<param name="ColumnLabelHorizontalAlign" value>
<param name="IDVariableHorizontalAlign" value>
<param name="ObsHorizontalAlign" value>
<param name="CaptionHorizontalAlign" value>
<param name="VariableVerticalAlign" value>
<param name="SumVariableVerticalAlign" value>
<param name="ColumnLabelVerticalAlign" value>
<param name="IDVariableVerticalAlign" value>
<param name="ObsVerticalAlign" value>
<param name="CaptionVerticalAlign" value>
<param name="VariableFontFace" value="Arial,Helvetica,sansserif">
<param name="SumVariableFontFace" 
value="Arial,Helvetica,sans-serif">
<param name="ColumnLabelFontFace" 
value="Arial,Helvetica,sans-serif">
<param name="IDVariableFontFace"
value="Arial,Helvetica,sansserif">
<param name="ObsFontFace" value="Arial,Helvetica,sans-serif">
<param name="CaptionFontFace" value="Arial,Helvetica,sansserif">
<param name="ByVariableFontFace"
value="Arial,Helvetica,sansserif">
<param name="ExtraParms" value>
<param name="RegistryKey" value="Software\SAS Institute Inc.\ 
SAS Design-Time Controls\TableCtrl">
</object>
-->
<P>
<TABLE BORDER="1" WIDTH="0%" CELLPADDING="1" CELLSPACING="1">
<TR>
<TH ALIGN="CENTER" VALIGN="MIDDLE">
<FONT FACE="Arial,Helvetica,sans-serif"> 
Retail sales in millions of $</FONT>
</TH>
<TH ALIGN="CENTER" VALIGN="MIDDLE">
<FONT FACE="Arial,Helvetica,sans-serif">DATE</FONT>
</TH>
<TH ALIGN="CENTER" VALIGN="MIDDLE">
<FONT FACE="Arial,Helvetica,sans-serif"> YEAR</FONT>
</TH>
<TH ALIGN="CENTER" VALIGN="MIDDLE">
<FONT FACE="Arial,Helvetica,sans-serif"> MONTH</FONT>
</TH>
<TH ALIGN="CENTER" VALIGN="MIDDLE">
<FONT FACE="Arial,Helvetica,sans-serif"> DAY</FONT>
</TH>
</TR>
<TR>
<TD ALIGN="CENTER" VALIGN="MIDDLE">
<FONT FACE="Arial,Helvetica,sans-serif"> $876</FONT>
</TD>
<TD ALIGN="CENTER" VALIGN="MIDDLE">
<FONT FACE="Arial,Helvetica,sans-serif">9 4Q1</FONT>
</TD>
<TD ALIGN="CENTER" VALIGN="MIDDLE">
<FONT FACE="Arial,Helvetica,sans-serif"> 1994</FONT>
</TD>
<TD ALIGN="CENTER" VALIGN="MIDDLE">
<FONT FACE="Arial,Helvetica,sans-serif"> 1</FONT>
</TD>
<TD ALIGN="CENTER" VALIGN="MIDDLE">
<FONT FACE="Arial,Helvetica,sans-serif"> 1</FONT>
</TD>
</TR>
<TR>
<TD ALIGN="CENTER" VALIGN="MIDDLE">
<FONT FACE="Arial,Helvetica,sans-serif"> $998</FONT>
</TD>
<TD ALIGN="CENTER" VALIGN="MIDDLE">
<FONT FACE="Arial,Helvetica,sans-serif"> 94Q2</FONT>
</TD>
<TD ALIGN="CENTER" VALIGN="MIDDLE">
<FONT FACE="Arial,Helvetica,sans-serif"> 1994</FONT>
</TD>
<TD ALIGN="CENTER" VALIGN="MIDDLE">
<FONT FACE="Arial,Helvetica,sans-serif"> 4</FONT>
</TD>
<TD ALIGN="CENTER" VALIGN="MIDDLE">
<FONT FACE="Arial,Helvetica,sans-serif"> 1</FONT>
</TD>
</TR>
</TABLE>
<P>
<!--metadata type="DesignerControl" endspan--></p>
</body>
</html>
Example C.2 DTC Table Control: JavaServer Page Code
<% 
{
appserver.AppServer IappServer = new appserver.AppServer();
IappServer.setURL(null);
IappServer.setURL("http://hygelac/cgi-bin/broker");
String queryString =
"_service=default&_debug=0&
_program=sashelp.websdk1.ds2htm2.scl&data=SASHELP.RETAIL&
pagepart=body&sqlview=Y&where=year%20eq%201994&
twidth=0&twunits=Percent&border=Y&formats=Y&labels=Y&
obsnum=N&talign=default&vface=Arial,Helvetica,sansserif&
sface=Arial,Helvetica,sansserif&
clface=Arial,Helvetica,sansserif&
iface=Arial,Helvetica,sansserif&
oface=Arial,Helvetica,sansserif&
cface=Arial,Helvetica,sansserif&
bface=Arial,Helvetica,sans-serif";
java.io.OutputStream os = IappServer.getOutputStream();
os.write(queryString.getBytes());
os.close();

String HTML = IappServer.getHTML();
int responseCode = IappServer.getResponseCode();
if (responseCode >= 200 && responseCode < 300)
out.println(HTML);
else if (responseCode == 401) {
HTML = "<P><FONT COLOR=\"red\">
ERROR: Authenticated sites are not supported.</FONT>
</P><BR>" + HTML;
IappServer.printDTCError(
new java.io.PrintWriter(out,true),responseCode, HTML);
}
else
IappServer.printDTCError(new java.io.PrintWriter(out, true),
responseCode, HTML);
}
%>
Example C.3 SAS DTC: Table Control: Active Server Page Code
<%
sub displayURL(URL)
Dim AppServer, HTML
Set AppServer = CreateObject("SAS.AppServerPostURL")
AppServer.webServer = "hunding"
AppServer.URL = "/scripts/broker.exe"
AppServer.queryString = URL
HTML = AppServer.openURL()
Response.Write HTML
End sub
displayURL("_service=default&_debug=0&_program=sashelp.websdk1.ds2htm2.scl&
data=SASHELP.RETAIL&pagepart=body&twidth=0&twunits=Percent&border=Y&
formats=Y&labels=Y&obsnum=N&talign=default&vface=Arial,Helvetica,sansserif&
sface=Arial,Helvetica,sansserif&clface=Arial,Helvetica,sansserif&
iface=Arial,Helvetica,sansserif&oface=Arial,Helvetica,sansserif&
cface=Arial,Helvetica,sansserif&bface=Arial,Helvetica,sans-serif")
%>

Appendix D
Example D.1 HTML Code for webEIS Applet
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">
<HTML>
<HEAD>
<TITLE></TITLE>
</HEAD>
<BODY>
<!{{~SAS~(APPLET) - Generated Code - Do Not Edit!>
<SCRIPT LANGUAGE="JavaScript"><!--
var _info = navigator.userAgent;
var _ns = false;
var _ie = (_info.indexOf("MSIE") > 0
&& _info.indexOf("Win") > 0
&& _info.indexOf("Windows 3.1") < 0);
//--></SCRIPT>
<COMMENT>
<SCRIPT LANGUAGE="JavaScript1.1"><!--
var _ns = (navigator.appName.indexOf("Netscape") >= 0
&& ((_info.indexOf("Win") > 0
&& _info.indexOf("Win16") < 0
&&
java.lang.System.getProperty("os.version").indexOf("3.5")<0)
|| (_info.indexOf("Sun") > 0) ||
(_info.indexOf("Linux")>0) ));
//--></SCRIPT>
</COMMENT>
<SCRIPT LANGUAGE="JavaScript"><!--
if (_ie == true) {
document.writeln(" <OBJECT");
document.writeln(
" CLASSID=\"clsid:8AD9C840-044E-11D1-B3E9-
00805F499D93\"");
document.writeln(
"CODEBASE=\"http://java.sun.com/products/plugin/
1.3.0_01/jinstall-130_01-
win32.cab#Version=1,3,0,1\"");
document.writeln(" HEIGHT=790");
document.writeln(" WIDTH=1026");
document.writeln(" >");
document.writeln(" <NOEMBED><XMP>");
}
else if (_ns == true) {
document.writeln(" <EMBED");
document.writeln(
"PLUGINSPAGE=\"http://java.sun.com/products/
plugin/1.3.0_01/plugin-install.html\"");
document.writeln(
" TYPE=\"application/x-javaapplet;version=1.4\"");
document.writeln(" HEIGHT=790");
document.writeln(" WIDTH=1026");
document.writeln(
"ARCHIVE=\"JSASNetCopyApplet.jar,JSASNetCopy.jar\"");
document.writeln(
"CODE=\"com.sas.tools.JSASNetCopy.applet.
InstallApplet.class\"");
document.writeln(
"java_codebase=\"http://localhost/sasweb/Tools/
JSASNetCopy/\"");
document.writeln(" reportURL=\"Example D-1.eis\"");
document.writeln(
"Applet:CODEBASE=\"http://localhost:8082/sasweb/
Tools/JSASNetCopy\"");
document.writeln(
"Applet:CODE=\"com.sas.tools.JSASNetCopy.applet.
InstallApplet.class\"");
document.writeln(
"Applet:ARCHIVE=\"JSASNetCopyApplet.jar,
JSASNetCopy.jar\"");
document.writeln(" ><NOEMBED><XMP>");
}
//--></SCRIPT>
<APPLET CODEBASE="http://localhost/sasweb/Tools/JSASNetCopy/"
ARCHIVE="JSASNetCopyApplet.jar,JSASNetCopy.jar" HEIGHT=790
CODE="com.sas.tools.JSASNetCopy.applet.InstallApplet.class"
WIDTH=1026 ></XMP>
<PARAM NAME="CODEBASE" 
VALUE="http://localhost/sasweb/Tools/JSASNetCopy/">
<PARAM NAME="ARCHIVE"
VALUE="JSASNetCopyApplet.jar,JSASNetCopy.jar">
<PARAM NAME="CODE"
VALUE="com.sas.tools.JSASNetCopy.applet.InstallApplet.
class">
<PARAM NAME="reportURL" VALUE="Example D-1.eis">
<PARAM NAME="Applet:CODEBASE"
VALUE="http://localhost:8082/sasweb/Tools/JSASNetCopy">
<PARAM NAME="Applet:CODE"
VALUE="com.sas.tools.JSASNetCopy.applet.InstallApplet.
class">
<PARAM NAME="Applet:ARCHIVE"
VALUE="JSASNetCopyApplet.jar,JSASNetCopy.jar">
</APPLET>
</NOEMBED>
</EMBED>
</OBJECT>
<!}}~SAS~(APPLET)>
</BODY>
</HTML>


