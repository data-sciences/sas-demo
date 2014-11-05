 /*-------------------------------------------------------------------*/
 /*               Web Development with SAS by Example                 */
 /*                   by Frederick E. Pratter                         */
 /*       Copyright(c) 2003 by SAS Institute Inc., Cary, NC, USA      */
 /*                   SAS Publications order # 58694                  */
 /*                        ISBN 1-59047-329-9                         */
 /*-------------------------------------------------------------------*/
 /*                                                                   */
 /* This material is provided "as is" by SAS Institute Inc.  There    */
 /* are no warranties, expressed or implied, as to merchantability or */
 /* fitness for a particular purpose regarding the materials or code  */
 /* contained herein. The Institute is not responsible for errors     */
 /* in this material as it now exists or will exist, nor does the     */
 /* Institute provide technical support for it.                       */
 /*                                                                   */
 /*-------------------------------------------------------------------*/
 /* Questions or problem reports concerning this material may be      */
 /* addressed to the author:                                          */
 /*                                                                   */
 /* SAS Institute Inc.                                                */
 /* Books by Users                                                    */
 /* Attn: Frederick Pratter                                           */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  sasbbu@sas.com             */
 /* Use this for subject field:                                       */
 /*     Comments for Frederick Pratter                                */
 /*                                                                   */
 /*-------------------------------------------------------------------*/
 /* Date Last Updated:  August 20, 2003                               */
 /*-------------------------------------------------------------------*/


Chapter 2

Example 2.1

<html>
<head>
	<title>CS395: Beyond HTML</title>
</head>
<body style="font-family: arial, helvetica, sans-serif">
<h1 style="text-align: center; color: #800000">Spring 2001</h1>
<h2 style="text-align: center; color: #0000FF">
	CS395 - Beyond HTML: Web Server Programming</h2>
<table cellspacing="0" cellpadding="1" border="1" align="center">
<tr>
<td><strong>Session:</strong></td>
	<t>8:10-9:30AM, Tuesday/Thursday</td>
</tr>
<tr>
	<td><strong>Instructor:</strong></td>
	<td>Frederick Pratter</td>
</tr>
<tr>
	<td><strong>Office:</strong></td>
	<td>SS404</td>
</tr>
<tr>
	<td><strong>Office Hours:</strong></td>
	<td>9:30-10:45AM, Tuesday/Thursday</td>
</tr>
<tr>
	<td><strong>E-mail:</strong></td>
	<td><a href="mailto:pratter@cs.umt.edu">
	pratter@cs.umt.edu</a></td>
</tr>
</table>

<p style="text-align: center; color: #FF0000">
	NOTE: Class will be held in Social Sciences 344</p>
<p><a href="Syllabus.htm">Syllabus</a></p>
<p><a href="http://www.umt.edu/homepage/academics/calendar.htm">
	UM Schedule</a></p>
<p><a href="schedule.htm">	Assignments</a></p>
<p><a href="notes.htm">	Notes</a></p>
<p><a href="grades.htm">Grades</a></p>
<p><a href="http://www.cs.umt.edu/">
	Computer Science Department Home Page</a></p>
<p><a href="http://www.cs.umt.edu/CS/COURSES/classes.htm">
	Other Computer Science Pages</a></p>
</body>
</html>

Example 2.2

<html>
<head>
	<title>CS395: Student Questionnaire</title>
</head>
<body>
<h1 style="text-align: center; color: #0000FF ">
	CS395: Student Questionnaire</h1>
<form name="students">
<p style="font-weight: bold; color: #0000FF">Last Name: 
	<input type="text" name="lastname" /></p>
<p style="font-weight: bold; color: #0000FF">First Name: 
	<input type="text" name="firstname" /></p>
<p style="font-weight: bold; color: #0000FF">Year: 
	<blockquote>
		<input type="radio" name="year" value=1>
		Freshman</input><br />
		<input type="radio" name="year" value=2>
		Sophomore</input><br />
		<input type="radio" name="year" value=3>
		Junior</input><br />
		<input type="radio" name="year" value=4>
		Senior</input><br />
		<input type="radio" name="year" value=5>
		Graduate</input><br />
		<input type="radio" name="year" value=9>
		Other</input>
	</blockquote>
</p>
<p style="font-weight: bold; color: #0000FF">Major: 
	<select name="major">
		<option value="CS">Computer Science</option>
		<option value="B">Business</option>
		<option value="F">Forestry</option>
		<option value="M">Media Arts</option>
		<option value="O">Other</option>
		<option value="U">Undecided</option>
	</select>
</p>
<p style="font-weight: bold; color: #0000FF">
		Check if this is your first computer class
	<input type="checkbox" name="firstCS" value="Y" /></p>
<p style="font-weight: bold; color: #0000FF">
	Thank you for completing this form.</p>
<p>
	<input type="reset" value="reset form" />
	<input type="submit" value="send form" />
</p>
</form>
</body>
</html>

Example 2.3

body	{
		background-image: url("underwater.jpg")
	}
h1	{
		color: red; font-weight: bold; text-align: center
	}
h2	{
		color: blue; font-weight: bold; text-align: center
	}
p	{
		color: yellow; font-size: 14 pt; text-align: left
	}






Example 2.4

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


Chapter 3

Example 3.1

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


Example 3.2

<html>
<head>
	<title>Retails Sales Table</title>
</head>
<body>
<h1 style="font-family: helvetica, tahoma, arial; color: blue">
	Retail Sales in Millions of $</h1>
<pre>

|Year  | Total  |Overall | Number |Average |Smallest|Largest |
|      | Sales  |Percent |of Sales|  Sale  |  Sale  |  Sale  |
|------+--------+--------+--------+--------+--------+--------|
|1994  |  $1,874|    5.97|       2| $937.00|    $876|    $998|
|------+--------+--------+--------+--------+--------+--------|
|1993  |  $3,578|   11.40|       4| $894.50|    $758|    $991|
|------+--------+--------+--------+--------+--------+--------|
|1992  |  $3,204|   10.21|       4| $801.00|    $692|    $889|
|------+--------+--------+--------+--------+--------+--------|
|1991  |  $2,947|    9.39|       4| $736.75|    $703|    $807|
|------+--------+--------+--------+--------+--------+--------|
|1990  |  $2,734|    8.71|       4| $683.50|    $606|    $749|
|------+--------+--------+--------+--------+--------+--------|
|1989  |  $2,592|    8.26|       4| $648.00|    $594|    $670|
|------+--------+--------+--------+--------+--------+--------|
|1988  |  $2,412|    7.69|       4| $603.00|    $546|    $643|
|------+--------+--------+--------+--------+--------+--------|
|1987  |  $2,164|    6.90|       4| $541.00|    $484|    $595|
|------+--------+--------+--------+--------+--------+--------|
|1986  |  $1,922|    6.13|       4| $480.50|    $419|    $541|
|------+--------+--------+--------+--------+--------+--------|
|1985  |  $1,596|    5.09|       4| $399.00|    $337|    $448|
|------+--------+--------+--------+--------+--------+--------|
|1984  |  $1,528|    4.87|       4| $382.00|    $342|    $413|
|------+--------+--------+--------+--------+--------+--------|
|1983  |  $1,393|    4.44|       4| $348.25|    $299|    $384|
|------+--------+--------+--------+--------+--------+--------|
|1982  |  $1,252|    3.99|       4| $313.00|    $284|    $343|
|------+--------+--------+--------+--------+--------+--------|
|1981  |  $1,148|    3.66|       4| $287.00|    $247|    $323|
|------+--------+--------+--------+--------+--------+--------|
|1980  |  $1,030|    3.28|       4| $257.50|    $220|    $295|
|------+--------+--------+--------+--------+--------+--------|
|Total | $31,374|  100.00|      58| $540.93|    $220|    $998|
--------------------------------------------------------------
</pre>
</body>
</html>

Example 3.3

options noovp nodate nonumber nocenter ls=80;

filename temp 'Example 3-3.lst';
filename out  'Example 3-3.html';

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

Example 3.4

options noovp nodate nonumber nocenter ls=80;
filename OUT  'Example 3-4.html';

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

Example 3.5

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<HTML> 
<HEAD>
  <META NAME="GENERATOR"
   	CONTENT="SAS Institute Inc. HTML Formatting Tools, 		http://www.sas.com/">
  <TITLE></TITLE>
</HEAD> 
<BODY> 
<PRE><STRONG>The MEANS Procedure

Analysis Variable : SALES Retail sales in millions of $

    YEAR     N        Mean     Minimum     Maximum
--------------------------------------------------</STRONG></PRE>
<PRE>    1994     2      937.00      876.00      998.00

    1993     4      894.50      758.00      991.00

    1992     4      801.00      692.00      889.00

    1991     4      736.75      703.00      807.00

    1990     4      683.50      606.00      749.00

    1989     4      648.00      594.00      670.00

    1988     4      603.00      546.00      643.00

    1987     4      541.00      484.00      595.00

    1986     4      480.50      419.00      541.00

    1985     4      399.00      337.00      448.00

    1984     4      382.00      342.00      413.00

    1983     4      348.25      299.00      384.00

    1982     4      313.00      284.00      343.00

    1981     4      287.00      247.00      323.00

    1980     4      257.50      220.00      295.00</PRE>
<PRE><STRONG>--------------------------------------------------</STRONG></PRE>
<HR>
 </BODY>
 </HTML>


Example 3.6

options noovp nodate nonumber nocenter ls=80;	

filename OUT 'Example 3-6.html';

title "1994 Sales Total by Month";

%ds2htm (data=SASHELP.RETAIL,
	 	where = YEAR gt 1990,
	 	var = YEAR MONTH SALES,
       	htmlfref = out);

Example 3.7

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<HTML>
<HEAD>
  <META    NAME="GENERATOR"
   CONTENT="SAS Institute Inc. HTML Formatting Tools, http://www.sas.com/">
  <TITLE></TITLE>
</HEAD>
<BODY>
<PRE><H3>1994 Sales Total By Month</H3></PRE>
<P>
<TABLE BORDER="1" WIDTH="100%" ALIGN="CENTER" 
	CELLPADDING="1" CELLSPACING="1">
  <TR>
    <TH ALIGN="CENTER" VALIGN="MIDDLE">MONTH</TH>
    <TH ALIGN="CENTER" VALIGN="MIDDLE">Retail sales in millions of $</TH>
  </TR>
  <TR>
    <TD ALIGN="CENTER" VALIGN="MIDDLE">1</TD>
    <TD ALIGN="CENTER" VALIGN="MIDDLE">      $876</TD>
  </TR>
  <TR>
    <TD ALIGN="CENTER" VALIGN="MIDDLE">4</TD>
    <TD ALIGN="CENTER" VALIGN="MIDDLE">      $998</TD>
  </TR>
</TABLE>
<P>
<HR>
</BODY>
</HTML>

Example 3.8

options noovp nodate nonumber nocenter ls=80;

filename OUT  'Example 3-8.html';

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
%TAB2HTM(capture=off, htmlfref=OUT);

Example 3.9

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<HTML>

<HEAD>
  <META  NAME="GENERATOR"
	   CONTENT="SAS Institute Inc. HTML Formatting Tools, http://www.sas.com/">
  <TITLE></TITLE>
</HEAD>
 
<BODY>

<PRE><H3>                         Retail Sales In Millions Of $</H3></PRE>
 
<PRE><H3></H3></PRE>
 
<P>
<TABLE BORDER="1" WIDTH="0%" ALIGN="CENTER" CELLPADDING="1" CELLSPACING="1">

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
			[13 rows omitted]
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

</BODY>
</HTML>

Example 3.10

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<HTML>
<!-- Generated by SAS Software -->
<!-- Http://www.sas.com -->
<HEAD>
<TITLE>SAS Output</TITLE>
<META http-equiv="Content-type" content="text/html;  charset=windows-1252">
</HEAD>
<BODY onload="startup()" onunload="shutdown()" vlink="#004488" link="#0066AA" leftmargin=8 rightmargin=8 bgcolor="#E0E0E0">
<SCRIPT LANGUAGE="JavaScript">
<!-- 
// This script is to load all object onLoad() functions 
function startup(){ }
function shutdown(){ }
//-->
</SCRIPT>

<font  face="Arial, Helvetica, Helv" size="3" color="#002288"><A NAME="IDX">&nbsp;</A>
<font  face="Arial, Helvetica, Helv" size="3" color="#002288"> 

<TABLE  cellspacing=1 cellpadding=1 rules=NONE frame=VOID border=0 width=100% bgcolor="#E0E0E0">
<TR>
 <TD ALIGN=LEFT bgcolor="#E0E0E0"><font  face="Arial, Helvetica, Helv" size="5" color="#002288"><b><i>Retail Sales In Millions Of $</i></b></font></TD>
</TR>
</TABLE>
</font><P>
 
<TABLE  rules=none frame=void>
<TR>
<font  face="Arial, Helvetica, Helv" size="3" color="#002288"> 
<TABLE  cellspacing=1 cellpadding=7 rules=GROUPS frame=BOX border=1 bgcolor="#F0F0F0" bordercolor="#000000">
<thead>
<TR>
 <TD ALIGN=CENTER VALIGN=CENTER bgcolor="#B0B0B0"><font  face="Arial, Helvetica, Helv" size="4" color="#0033AA"><b>Year</b></font></TD>
 <TD ALIGN=CENTER bgcolor="#B0B0B0"><font  face="Arial, Helvetica, Helv" size="4" color="#0033AA"><b>Total Sales</b></font></TD>
 <TD ALIGN=CENTER bgcolor="#B0B0B0"><font  face="Arial, Helvetica, Helv" size="4" color="#0033AA"><b>Overall Percent</b></font></TD>
 <TD ALIGN=CENTER bgcolor="#B0B0B0"><font  face="Arial, Helvetica, Helv" size="4" color="#0033AA"><b>Number of Sales</b></font></TD>
 <TD ALIGN=CENTER bgcolor="#B0B0B0"><font  face="Arial, Helvetica, Helv" size="4" color="#0033AA"><b>Average Sale</b></font></TD>
 <TD ALIGN=CENTER bgcolor="#B0B0B0"><font  face="Arial, Helvetica, Helv" size="4" color="#0033AA"><b>Smallest Sale</b></font></TD>
 <TD ALIGN=CENTER bgcolor="#B0B0B0"><font  face="Arial, Helvetica, Helv" size="4" color="#0033AA"><b>Largest Sale</b></font></TD>
</TR>
</thead>
<TR>
 <TD ALIGN=LEFT VALIGN=TOP bgcolor="#B0B0B0"><font  face="Arial, Helvetica, Helv" size="4" color="#0033AA"><b>        1994</b></font></TD>
 <TD ALIGN=RIGHT VALIGN=BOTTOM bgcolor="#D3D3D3"><font  face="Arial, Helvetica, Helv" size="3" color="#000000">  $1,874</font></TD>
 <TD ALIGN=RIGHT VALIGN=BOTTOM bgcolor="#D3D3D3"><font  face="Arial, Helvetica, Helv" size="3" color="#000000">    5.97</font></TD>
 <TD ALIGN=RIGHT VALIGN=BOTTOM bgcolor="#D3D3D3"><font  face="Arial, Helvetica, Helv" size="3" color="#000000">       2</font></TD>
 <TD ALIGN=RIGHT VALIGN=BOTTOM bgcolor="#D3D3D3"><font  face="Arial, Helvetica, Helv" size="3" color="#000000"> $937.00</font></TD>
 <TD ALIGN=RIGHT VALIGN=BOTTOM bgcolor="#D3D3D3"><font  face="Arial, Helvetica, Helv" size="3" color="#000000">    $876</font></TD>
 <TD ALIGN=RIGHT VALIGN=BOTTOM bgcolor="#D3D3D3"><font  face="Arial, Helvetica, Helv" size="3" color="#000000">    $998</font></TD>
</TR>
	[13 rows omitted]
<TR>
 <TD ALIGN=LEFT VALIGN=TOP bgcolor="#B0B0B0"><font  face="Arial, Helvetica, Helv" size="4" color="#0033AA"><b>        1980</b></font></TD>
 <TD ALIGN=RIGHT VALIGN=BOTTOM bgcolor="#D3D3D3"><font  face="Arial, Helvetica, Helv" size="3" color="#000000">  $1,030</font></TD>
 <TD ALIGN=RIGHT VALIGN=BOTTOM bgcolor="#D3D3D3"><font  face="Arial, Helvetica, Helv" size="3" color="#000000">    3.28</font></TD>
 <TD ALIGN=RIGHT VALIGN=BOTTOM bgcolor="#D3D3D3"><font  face="Arial, Helvetica, Helv" size="3" color="#000000">       4</font></TD>
 <TD ALIGN=RIGHT VALIGN=BOTTOM bgcolor="#D3D3D3"><font  face="Arial, Helvetica, Helv" size="3" color="#000000"> $257.50</font></TD>
 <TD ALIGN=RIGHT VALIGN=BOTTOM bgcolor="#D3D3D3"><font  face="Arial, Helvetica, Helv" size="3" color="#000000">    $220</font></TD>
 <TD ALIGN=RIGHT VALIGN=BOTTOM bgcolor="#D3D3D3"><font  face="Arial, Helvetica, Helv" size="3" color="#000000">    $295</font></TD>
</TR>
<TR>
 <TD ALIGN=LEFT VALIGN=TOP bgcolor="#B0B0B0"><font  face="Arial, Helvetica, Helv" size="4" color="#0033AA"><b>Total</b></font></TD>
 <TD ALIGN=RIGHT VALIGN=BOTTOM bgcolor="#D3D3D3"><font  face="Arial, Helvetica, Helv" size="3" color="#000000"> $31,374</font></TD>
 <TD ALIGN=RIGHT VALIGN=BOTTOM bgcolor="#D3D3D3"><font  face="Arial, Helvetica, Helv" size="3" color="#000000">  100.00</font></TD>
 <TD ALIGN=RIGHT VALIGN=BOTTOM bgcolor="#D3D3D3"><font  face="Arial, Helvetica, Helv" size="3" color="#000000">      58</font></TD>
 <TD ALIGN=RIGHT VALIGN=BOTTOM bgcolor="#D3D3D3"><font  face="Arial, Helvetica, Helv" size="3" color="#000000"> $540.93</font></TD>
 <TD ALIGN=RIGHT VALIGN=BOTTOM bgcolor="#D3D3D3"><font  face="Arial, Helvetica, Helv" size="3" color="#000000">    $220</font></TD>
 <TD ALIGN=RIGHT VALIGN=BOTTOM bgcolor="#D3D3D3"><font  face="Arial, Helvetica, Helv" size="3" color="#000000">    $998</font></TD>
</TR>
</TABLE>
</font></TR>
</TABLE>
</font><SCRIPT LANGUAGE="JavaScript">

<!-

// This script is to load all object onLoad() functions 
function startup(){
}

function shutdown(){
}
 
//-->
</SCRIPT>

</BODY>
</HTML>

Example 3.11

options noovp ls=80 nodate nonumber;
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

Example 3.12

options noovp nodate nonumber nocenter ls=80;

ods listing close;
ods html body="Example 3-9.html" newfile=proc;

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

Example 3.13

options noovp ls=80 nodate nonumber;

ods listing close;
ods html
	path="c:\Documents and Settings\All Users\Documents"
		(url="http://hrothgar/examples/")
	body="Example 3-13.html"
	contents="Contents 3-13.html"
	frame="Frame 3-13.html";

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

Example 3.14

options ls=80 noovp nodate nonumber;

filename OUT  "Example 3-14.html";
title "Sales Total by Month 1991-1994";

ods listing close;
ods html body=OUT;

data _null_;
	set SASHELP.RETAIL;
	where (YEAR gt 1990);
	file print 
	ods=(variables=(YEAR MONTH SALES));
	put _ods_;
run;

ods html close;
ods listing;

Example 3.15

proc template;                                                           
	define style Styles.Default;                                        
      style fonts "Fonts used in the default style" /                     
      'TitleFont2' = ("Arial, Helvetica, Helv",4,Bold Italic)              
      'TitleFont' = ("Arial, Helvetica, Helv",5,Bold Italic)               
	[more define statements...]
end;
run;

Example 3.16

options ls=80 noovp nodate nonumber;

filename OUT  "Example 3-16.html";
title "Sales Total by Month 1991-1994";

ods listing close;
ods html body=OUT style=sasweb;

data _null_;
	set SASHELP.RETAIL;
	where (YEAR gt 1990);
	file print 
	ods=(variables=(YEAR MONTH SALES));
	put _ods_;
run;

ods html close;
ods listing;

Example 3.17

options noovp ls=80 nodate nonumber;

filename OUT "Example 3-17.html";

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


Example 3.18

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
   <head>
      <style type="text/css">
         h1 { color: blue; text-align: center; }
         h2 { color: navy; text-align: center; }
      </style>
      <title>SAS Output</title>
   </head>
   <body>
   <h1>Retail Sales In Millions Of $</h1>
   <table border="1" align="center">
      <thead>
         <tr>
            <th>Year</th>
            <th>Total Sales</th>
            <th>Overall Percent</th>
            <th>Number of Sales</th>
            <th>Average Sale</th>
            <th>Smallest Sale</th>
            <th>Largest Sale</th>
         </tr>
      </thead>
      <tr>
         <td>        1994</td>
         <td>  $1,874</td>
         <td>    5.97</td>
         <td>       2</td>
         <td> $937.00</td>
         <td>    $876</td>
         <td>    $998</td>
      </tr>
[13 rows omitted]
      <tr>
         <td>        1980</td>
         <td>  $1,030</td>
         <td>    3.28</td>
         <td>       4</td>
         <td> $257.50</td>
         <td>    $220</td>
         <td>    $295</td>
      </tr>
      <tr>
         <td>Total</td>
         <td> $31,374</td>
         <td>  100.00</td>
         <td>      58</td>
         <td> $540.93</td>
         <td>    $220</td>
         <td>    $998</td>
      </tr>
   </table>
   </body>
</html>

Example 3.19

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
		put	 VALUE;
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

Example 4.1

# Copyright (c) 1993-1999 Microsoft Corp.
#
# This file contains port numbers for well-known services defined by IANA
#
# Format:
#
# <service name>	<port number>/<protocol>    [aliases...]   [#<comment>]
#

echo                7/tcp
echo                7/udp
discard             9/tcp    sink null
discard             9/udp    sink null
systat             11/tcp    users                  #Active users
systat             11/tcp    users                  #Active users
daytime            13/tcp
daytime            13/udp

                         [many lines omitted]
#SAS/CONNECT service
spawner		2323/tcp	# UNIX or OS/390 spawner

#AppDevStudio service
shr1          	5010/tcp	# local SAS server
shr2          	5011/tcp	# SAS/SHARE SERVER


Example 4.2

*****************************************************;
*****   start SAS/SHARE server on local host    *****;
*****   system administrator password: system   *****;
*****   user pasword: user                      *****;
*****   authentication is on                    *****;
*****************************************************;

proc server 
	id=shr1 
	oapw=system 
	uapw=user 
	authenticate=required;
run;

Example 4.3

*****************************************************;
*****   stop SAS/SHARE server on local host     *****;
*****************************************************;
proc operate serverid=shr1 sapw=system uid=_prompt_;
      stop server;
run;




Example 4.4

libname SHARED
	slibref=SASHELP
	server=hygelac.shr1
	sapw=user
	uid=Frederick 
	passwd=_prompt_;

proc print data=SHARED.RETAIL;
	title "Retail Sales Total by Month: 1991-1994";
	where YEAR gt 1990;
	var MONTH SALES;
	id YEAR;
run;

Example 4.5

proc sql;

	connect to remote 
		(server=hygelac.shr1 sapw=user 
	 	 user=frederick password=_prompt_);

	select * from connection to remote 
		(select YEAR, MONTH, sum(SALES) 
			format=dollar12. label='Total Sales'
		 from SASHELP.RETAIL
		 group by YEAR, MONTH);
quit;

Example 4.6

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

Example 5.1

#!/usr/bin/perl
##
##  HelloWorld.pl - My first Perl program
##
use CGI ':standard';			# include CGI module
print header;				# generate MIME content line
print start_html "CGI Examples";	# generate starting HTML tags

# print "Hello World"
print h1( { -style=>'color: blue; '}, 'Hello World!');

# generate date/time field
( $s, $m, $h, $d, $mm, $y ) = localtime(time);

$y+=1900;					# convert 2-digit year to 4
$mm++;					# months start with 0

print p( {-style=>'font-weight: bold; font-size: 24;'}, 
     "The time now: $h:$m on $mm/$d/$y:"); 

print end_html;              # generate ending HTML tags



Example 5.2

Content-Type: text/html; charset=ISO-8859-1
<?xml version="1.0" encoding="utf-8"?>
	<!DOCTYPE html
	PUBLIC "-//W3C//DTD XHTML Basic 1.0//EN"
	"http://www.w3.org/TR/xhtml-basic/xhtml-basic10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US">
<head>
	<title>CGI Examples</title>
</head>
<body>
	<h1 style="color: blue; ">Hello World!</h1>
	<p style="font-weight: bold; font-size: 24;">
		The time now: 23:36 on 6/28/2002:</p>
</body>
</html>

Example 5.3

#!/usr/bin/perl
##
## calculator.pl - Sample Perl Program	
##
use CGI ':standard';

print header;
print start_html "Perl Temperature Conversion Examples";

# get input parameters and calculate result
$temp = param("input");
$type = param("convert");

if ( $type == 1 ) 		# convert F to C
{
        $result = 5*($temp - 32)/9;
}
elsif ( $type == 2 )	# convert C to F
{
       $result = 9*$temp/5 + 32;
} 

print '<div style="text-align: center; ">';
print h1 ( { -style=>'color: blue; '}, 
	'Temperature Conversion Calculator' );
print '<form name="calculator" action="convert.pl" method="get">';
print p ( '<strong>Enter a temperature and select a conversion type:</strong>', 
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
        print p (	'<strong>Result:</strong>', 
		'<input type="text" name="result" value=', $result, '>' );
}

print '</div></form>';
print end_html;

Chapter 6

Example 6.1

[root@hrothgar frederick]# cd /tmp/inet/websrv 
[root@hrothgar websrv]# ksh INSTALL 

Welcome to the SAS/IntrNet CGI Tools installation script.  

You will be prompted for information about your Web server configuration and how you wish to install SAS/IntrNet. This installation script will move the files that were extracted from the CGI Tools package into a directory under your Web server.  You will 
be able to review and confirm your responses before any updates are made to your system. 

The CGI Tools samples must be installed in the Web server directory corresponding to the URL http://<your_server>/sasweb.  

Enter the physical path corresponding to http://<your_server>/sasweb.
If this directory does not exist, it will be created for you.  
Path: /var/www/html/sasweb 

Enter the physical path for SAS/IntrNet CGI executables. This can be a standard CGI directory or a new directory reserved for SAS/IntrNet.  Setup will create this directory for you if it does not exist.

Path [/var/www/cgi-bin]: [CR] (This is a carriage return, not the text "CR" obtained by pressing the Enter key.)

The CGI executables and configuration files must be installed in a Web server directory with execute privilege.  We suggest using the URL http://<your_server>/cgi-bin for these files, although you may use any URL.

Enter the URL path corresponding to the physical path /var/www/cgi-bin.

CGI URL [http://<your_server>/cgi-bin]: http://hrothgar/cgi-bin

The following steps will be performed:

- Sample files will be updated to use http://<your_server>/cgi-bin for all CGI references.
 
- Sample files will be installed to /var/www/html/sasweb/IntrNet8. Existing files will be overwritten.
 
- CGI executables and configuration files will be installed to /var/www/cgi-bin. Existing executables will be renamed as a backup before the new executables are installed. New configuration files are installed with a .cfg_v8 extension so that existing conf
iguration files are not overwritten. If no existing configuration file is found the .cfg_v8 file is copied to create a new .cfg file.
 
- Java Graphics files will be moved to /var/www/html/sasweb/graph. Existing files will be renamed as a backup.
 
Do you wish to continue [Y]? [CR]

Modifying URL to CGI Tools in sample files

Moving samples to /var/www/html/sasweb/IntrNet8

Moving CGI files to /var/www/cgi-bin

Moving Java Graphics files to /var/www/html/sasweb/graph

The installation is complete.  Verify that your Web server is configured to:

 - map http://<your_server>/cgi-bin to /var/www/cgi-bin
 - allow CGI execution in http://<your_server>/cgi-bin
 - map http://<your_server>/sasweb to /var/www/html/sasweb

Once your SAS Servers are configured and started, you can view SAS/IntrNet samples at http://<your_server>/sasweb/IntrNet8/samples.html.

Example 6.2

[root@hrothgar]# cd /usr/local/SAS_8.2/utilities/bin 
[root@hrothgar bin]# ./inetcfg.pl 

Root directory for SAS/IntrNet services (/root/intrnet): /var/www/html/sasweb/IntrNet8

What kind of service do you wish to configure?

1 - Socket Service2 - Pool Service
3 - Launch Service
4 - Load Manager
5 - Spawner

Enter service type? (1): [CR]

This script will set up a service definition for the SAS/IntrNet Application Dispatcher. You should know the type of service you wish to create and the TCP port number(s) or name(s) you wish to use (socket service only) before continuing.

You will be asked to provide a directory name. The script will create this directory and place server startup and log files in it. 

Name of the new service? (default): [CR]
How many servers would you like for this service (maximum 20)? (1):[CR]

Please enter TCP/IP port values for this service. You may use a service name such as appsrv or a port number such as 5001. If you use a name, please remember to include this name in your network services file along with a port number.

Port name or number for server 1 (5001): [CR]

Do you want to protect the administration of this service with a password? (N): [CR]

Service name : default
Service type : Socket
Root Directory : /var/www/html/sasweb/IntrNet8/default
Number of servers : 1
Server port(s) : 5001
Admin password : none

Create this service? (Y): [CR]

The service directory has been created.

To start the default service execute
/var/www/html/sasweb/IntrNet8/default/start.pl

The files necessary for this service have been created. To complete the configuration perform the steps outlined in this checklist.

* Install the Application Broker on your Web server machine.

* Create a service definition in your broker.cfg file for the 
 "default" service. For example:

 SocketService default
 ServiceAdmin "[your-name]"
 ServiceAdminMail "[your-email]@[your-site]"
 Server hrothgar.beowulf
 Port 5001
 FullDuplex True

Example 6.3

##----------------------------------------------------------------- 
## Definitions for full-time ("socket") servers 
##----------------------------------------------------------------- 

# Supplied Directive Description 
# ------------------ ----------- 
# 
# SocketService Starts a service definition. Parameters are the service # name and short description. The name given here is the value
# specified in the "_service" hidden field submitted to the broker. 
## ServiceDescription Longer description used when building a list 
# of services. [optional, no default] 
## ServiceAdmin Specifies the name of the service administrator. 
# If omitted the global Administrator is used. 
## ServiceAdminMail Specifies the email address of the administrator of
# this service. If omitted the global Administrator is used. 
## Server DNS name or IP address of application server host 
## Port TCP port number (256-65535) 
#
# ServiceCompatibility Used to specify compatibility with Version 6 and 7
# 
# Application Servers. Set to 1.0 for non-V8. 
#
# FullDuplex Communicate with a V8.1 or later App Server over one 
# bidirectional socket 
# 
# Consult the Application Dispatcher documentation for a complete list
# of directives. We recommend each site define a default service. 
#
# There is nothing special about the name 'default', it is simply a
# convention you can use at your site. 
 
SocketService default "Reuse existing session" 
 ServiceDescription "Pages reference this generic server when they don't care which service is used." 
 ServiceAdmin "Your Name" 
 ServiceAdminMail "yourname@yoursite" 
 Server appsrv.yourcomp.com 
 Port 5001 
# Remove the following line for any servers before V8.1 
 FullDuplex True


Example 6.4

/**************************************************************/
/*           S A S   S A M P L E   L I B R A R Y              */
/*                                                            */
/*     NAME: WEBHELLO                                         */
/*    TITLE: Hello World                                      */
/*  PRODUCT: SAS/IntrNet (Application Dispatcher)             */
/*   SYSTEM: ALL                                              */
/*                                                            */
/*  SUPPORT: Web Tools Group             UPDATE: 13Oct2000    */
/*      REF: http://www.sas.com/rnd/web/dispatch/             */
/**************************************************************/

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



Example 6.5

/* sample SAS program to convert F to C and vice versa */
 data _null_;

 	file _webout;

	***** write generic XHTML header *****;
	put '<?xml version="1.0" encoding="utf-8"?>'/
	    '<!DOCTYPE html PUBLIC ""-//W3C//DTD XHTML Basic 1.0//EN"'/
	    '	"http://www.w3.org/TR/xhtml-basic/xhtml-basic10.dtd">'/
	    '<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US">';
	
	***** write top of page *****;
	put '<head>'/
	    '	<title>SAS/IntrNet Temperature Conversion Calculator </title>'/
	    '</head>'/
	    '<body>'/
	    '<div  style="text-align: center">'/
	    '<h1 style="color: blue">Temperature Conversion Calculator</h1>';

       **** create HTML form * with hidden text fields ***;
       put '<form name="calculator" 
                  action="/cgi-bin/broker" method="get">'/
            '	<input type="hidden" 
                  name="_service" value="default" />'/
            '	<input type="hidden" name="_program"
					value="examples.convert.sas" />';
        
	***** get parameter values *****;
	temp = symget('input');
	type = symget('convert');		

   	***** input temperature *****;
   	put '	<p><strong>Enter a temperature and select a conversion type: </strong>'/
       '	<input type="text" name="input" value="' temp '"/></p>';        
        
   	***** select conversion/compute result *****;
   	put '	<p><input type="radio" name="convert" value="1"' @;
   	if (type = '1') then do;
   		put 'checked="checked"' @;
      	result = 5*(input(temp,8.) - 32)/9;
   	end;
   	put '> Fahrenheit to Centigrade</p>';
        
   	put '	<p><input type="radio" name="convert" value="2"' @;
   	if (type = '2') then do;
   		put 'checked="checked"' @;
     	result = 9*input(temp,8.)/5 + 32;
   	end;        
   	put '> Centigrade to Fahrenheit</p>';        
        
   	***** Submit button *****;
        put '	<p><input type="submit" value = "Submit"></p>';        
                
   	***** Display results *****;

   	if (temp > ' ') then do;
		put '	<p><strong>Result: </strong>'/
     	    '	<input type="text" name="result" value="' result 6.2 '"/></p>';
   end;        
         
   **** write bottom of page *****;        
   put '</form>'/
       '</div>'/
       '</body>'/
       '</html>';
run;

Example 6.6

proc appsrv unsafe='&";%'''   &sysparm ;
  allocate file    sample  '!SASROOT/samples/intrnet';
  allocate library samplib '!SASROOT/samples/intrnet' 	access=readonly;
  allocate library sampdat '!SASROOT/samples/intrnet' 	access=readonly;
  allocate library tmplib  '';
  allocate file logfile '../logs/%a_%p.log';
  allocate file examples '/home/frederick/cgi-bin';
  proglibs examples;
  proglibs sample samplib %ifcexist(sashelp.webeis) sashelp.webprog;
  proglibs sashelp.websdk1;
  adminlibs sashelp.webadmn;
  datalibs sampdat tmplib;
  log file=logfile;


Example 6.7

%* Sales report Example - Display Product by Region;
%macro salesrpt;

  %global region;
   proc report data=sashelp.shoes;
	by region;
	%if (&region ne ) %then %do;
		where region="&region";
	%end;
	title "Sales By Product";
	footnote "Data are current as of &systime &sysdate9";
	column product sales;
 	define product / group;
 	define sales / analysis sum;
   quit;

%mend salesrpt;

/* prepend XHTML template */
libname userlib '/usr/local/SAS_8.2/users';
ods path (prepend) userlib.templat; 

/* redirect output to client */
ods markup body=_webout tagset=xhtml; 

%salesrpt


Chapter 7

Example 7.1

<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html
	PUBLIC "-//W3C//DTD XHTML Basic 1.0//EN"
	"http://www.w3.org/TR/xhtml-basic/xhtml-basic10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US">

<head>
	<title>SAS IntrNet Examples: htmSQL</title>
	<style type="text/css">
		caption { font-weight: bold; font-size: 24; }
h3      { font-weight: bold; font-size: 18; }
		td	  { text-align: right; }	
	</style>
</head>

<body>
{query server="hygelac.shr1" sapw="user"}
{sql}
	select product, 
		sum(sales) as total label="Total Sales" format=dollar8.
	from sashelp.shoes
	group by product
	where region="Africa";
{/sql}
{norows}
	<h1>Sales by Product</h1>
{/norows}
<table border="1">
	<caption>Region=Africa</caption>
	<tr>	
		{label var="{&sys.colname[*]}" before="<th>" 
			between="</th><th>" after="</th>"}
	</tr>
	{eachrow}
		<tr>
			{&{&sys.colname[*]} before="<td>" 
				between="</td><td>" after="</td>"}
		</tr>
	{/eachrow}
</table>
{/query}
<h3>Data are current as of 
	{&sys.time}{&sys.ampm} {&sys.month} {&sys.monthday}, {&sys.year}
</h3></body>
</html>

Example 7.2

<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML Basic 1.0//EN"
	"http://www.w3.org/TR/xhtml-basic/xhtml-basic10.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US">
<head>
	<title>SAS IntrNet Examples: htmSQL</title>
</head>

<body>
	{query server="hygelac.shr1" sapw="user"}

	{sql} 
		select distinct region from sashelp.shoes;
	{/sql}
	<div style="text-align: center; ">
	<form method=get action="http://hrothgar/cgi-bin/htmSQL/ examples/Example7-1.hsql">
	<h1>International Shoes</h1>
	<h2>Request Current Sales Report</h2>
	<p>Select Region: 
		<select name=region>
			{eachrow}
				<option>{&region}</option>
			{/eachrow}
		</select>
	</p>
	<input type="submit" />
	</div>
	</form>
	{/query}
</body>
</html>

Chapter 8 

Example 8.1

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

Example 8.2

html>
<head>
	<title>JavaScript Temperature Conversion Calculator</title>	
	<script type="text/javascript">	
	function calc(n) {
			var temp = document.calculator.input.value;
			if (n == 1)
	     		document.calculator.result.value=5*(temp-32)/9;
			else
				document.calculator.result.value=(9*temp)/5 + 32;
		}		
	</script>
</head>

<body>
<div style="text-align: center">
<h1 style="color: blue">
		Temperature Conversion Calculator</h1>
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

Example 8.3

<html>
<head>
	<title>Java Temperature Conversion Applet</title>
</head>
<body>
	<div style="text-align: center">
	<h1 style="color: blue">
     Temperature Conversion Calculator</h1>
	<object code="calculator.class"
		width = 480
		height = 120
		alt="You need to update your browser!" />
	</div>
</body>
</html>

Example 8.4

// Temperature Conversion Applet
import java.applet.*;
import java.awt.*;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class calculator
	extends Applet
  	implements ActionListener
{
  	private TextField tfInput, tfResult;
  	private Button btF2C, btC2F;

  	private final String F2C = new String("Fahrenheit to Centigrade");
  	private final String C2F = new String("Centigrade to Fahrenheit");

  	//initialize user interface
  	public void init()
  	{
    	     	//set layout and foreground colors
    	     	setLayout(new BorderLayout());
    	     	setBackground(Color.white);
	     	setFont(new Font("Times New Roman", Font.PLAIN, 14));

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
    	     t1=(Double.valueOf(tfInput.getText())).doubleValue();

    	     // compute result
    	     t2=actionCommand.equals(F2C) ? 5*(t1-32)/9 : 9*t1/5 + 32 ;

    	     // display result
    	     tfResult.setText(String.valueOf(t2));
	}
}





Example 8.5

import javax.swing.*;
import java.awt.*;	// include font, colors, layouts
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class Jcalc
	extends JApplet
  	implements ActionListener
{
  	private JTextField tfInput, tfResult;
  	private JButton btF2C, btC2F;
  	private final String F2C = new String
		("Fahrenheit to Centigrade");
  	private final String C2F = new String
		("Centigrade to Fahrenheit");

  	//initialize user interface
  	public void init()
  	{
		//format the applet's content pane
		getContentPane().setLayout(new BorderLayout());
		getContentPane().setBackground(Color.white);
		getContentPane().setFont
new Font("Times New Roman", Font.PLAIN, 14));

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
    	p1.add(new JLabel
("Enter a temperature and select conversion type:"));
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


Example 8.6

<html>
<head>
    <title>Java Temperature Conversion Applet (JDK 1.2 Plugin)</title>
</head>
<body>
	<div style="text-align: center">
	<h1 style="color: blue">Temperature Conversion Calculator</h1>
	<OBJECT classid="clsid:8AD9C840-044E-11D1-B3E9-00805F499D93"
	     	width="480" height="120"
	     	codebase="http://java.sun.com/products/plugin/1.2/
jinstall-12-win32.cab#Version=1,2,0,0">
	<PARAM NAME="code" VALUE="Jcalc.class">
	<PARAM NAME="type" VALUE="application/x-java-applet;version=1.2">
	<COMMENT>
	     <EMBED type="application/x-java-applet;version=1.2"
	     	width="480" height="120"  
code="abc.class"
	      pluginspage="http://java.sun.com/products/plugin/1.2/
plugin-install.html">
	     </COMMENT>
	</EMBED>
	</OBJECT>
	</div>
</body>
</html>

Example 8.7

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


Chapter 9

Example 9.1

<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">
<HTML>
<HEAD>
	<TITLE>Calculator</TITLE>
</HEAD>

<BODY>
	<!{{~SAS~(APPLET) - Generated Code - Do Not Edit!>
	<SCRIPT LANGUAGE="JavaScript"><!--
		var _info = navigator.userAgent;
		var _ns = false;
		var _ie = (_info.indexOf("MSIE") > 0
			&& _info.indexOf("Win") > 0
			&& _info.indexOf("Windows 3.1") < 0);
	//-->
	</SCRIPT>
	
	<COMMENT>	
	<SCRIPT LANGUAGE="JavaScript1.1">
	<!--
		var _ns = (navigator.appName.indexOf("Netscape") >= 0
			&& ((_info.indexOf("Win") > 0
			&& _info.indexOf("Win16") < 0
			&& java.lang.System.getProperty
		 		("os.version").indexOf("3.5") < 0)
		|| (_info.indexOf("Sun") > 0) 
		|| (_info.indexOf("Linux") > 0) ));
	//-->	</SCRIPT>
	</COMMENT>
	
	<SCRIPT LANGUAGE="JavaScript">	<!--
		if (_ie == true) 
		{
			document.writeln(" <OBJECT");
			document.writeln(" CLASSID=\"clsid:8AD9C840-044E-11D1-B3E9-00805F499D93\"");
			document.writeln(" CODEBASE=\"http://java.sun.com/ products/plugin/1.3.0_01/jinstall-130_01-win32.cab #Version=1,3,0,1\"");
			document.writeln(" HEIGHT=400");
			document.writeln(" NAME=\"calculator\"");
			document.writeln(" WIDTH=600");
			document.writeln(" >");
			document.writeln(" <NOEMBED><XMP>");
		}
		else if (_ns == true) 
		{
			document.writeln(" <EMBED");
			document.writeln(" PLUGINSPAGE=\"http://java.sun.com/ products/plugin/1.3.0_01/plugin-install.html\"");
			document.writeln(" TYPE=\"application/x-java-applet; jpi-version=1.3.0_01\"");
			document.writeln(" HEIGHT=400");
			document.writeln(" NAME=\"calculator\"");
			document.writeln(" WIDTH=600");
			document.writeln(" ARCHIVE=\"JSASNetCopyApplet.jar, 

JSASNetCopy.jar\"");
			document.writeln(" CODE=\"com.sas.tools.JSASNetCopy. applet.InstallApplet.class\"");
			document.writeln(" CODEBASE=\"http://ASTERIX/sasweb/ Tools/JSASNetCopy/\"");
			document.writeln(" Applet: CODE="calculator.class\"");
			document.writeln(" ><NOEMBED><XMP>");
		}
	//--></SCRIPT>
	
	<APPLET CODE="calculator.class" WIDTH=600 
		NAME="calculator" HEIGHT=400 >
	</XMP>
	<PARAM NAME="ARCHIVE"
		VALUE="JSASNetCopyApplet.jar,JSASNetCopy.jar">
	<PARAM NAME="CODE" 
		VALUE="com.sas.tools.JSASNetCopy.applet.InstallApplet. class">
	<PARAM NAME="CODEBASE"
		VALUE="http://ASTERIX/sasweb/Tools/JSASNetCopy/">
	<PARAM NAME="Applet:CODE" 
		VALUE="calculator.class">
	</APPLET>
	</NOEMBED>
	</EMBED>
	</OBJECT>
	<!}}~SAS~(APPLET)>
</BODY>
</HTML>

Example 9.2

Threaded connection test starting...
Telnet session established on Tue Apr 09 19:48:36 PDT 2002
Telnet client: com.sas.net.connect.SASTelnetClient
Host: ETHELREDPort: 2323
Looking for message from host containing one of the following
	Hello>
Received: Hello>
Sent: sas 
Looking for message from host containing one of the following
	PORT=
Received: 
SAS(R) TCPIP REMOTE LINK PORT=Fetching SAS port number
NOTE: Copyright (c) 1999-2001 by SAS Institute Inc., Cary, NC, USA. 
NOTE: SAS (r) Proprietary Software Release 8.2 (TS2M0)
      Licensed to FREDERICK PRATTER.
NOTE: This session is executing on the WIN_98 platform.

NOTE: SAS initialization used:
      real time           1.80 seconds
      
1    %put RemoteSASInfoStart &SYSVER RemoteSASInfoEnd;
RemoteSASInfoStart 8.2 RemoteSASInfoEnd

NOTE: PROCEDURE PRINTTO used:
      real time           0.00 seconds

NOTE: SAS Server: Authorization commencing... 
NOTE: SAS Server: Client LOGON 
NOTE: NEW task=3 factory=8387 oid=8425 class=sashelp.prdauth.userinfo.class 
NOTE: NEW task=3 factory=8387 oid=8505 class=SASHELP.RSASMOD.SRVINFO.CLASS 
NOTE: Ofactory : _term 
NOTE: TERM task=3 factory=8387 oid=8505 
NOTE: TERM task=3 factory=8387 oid=8425 
NOTE: SAS Server: Client LOGOFF 
NOTE: Stopping task  taskid=3 curtask=1 

Success!!

Example 9.3

libname corehelp "d:\sas\core\sashelp";
filename updates
  "d:\AppDevStudio\ads203Deployment\SASUpdates\V8\appdev.cpo";

proc cimport force library=corehelp infile=updates;
run;

Example 9.4

<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML//EN\">
<HTML>
<HEAD>
<TITLE>TableViewExample</TITLE>
</HEAD>
<BODY>
<!{{~SAS~(APPLET)- Generated Code - Do Not Edit!>

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
		&& java.lang.System.getProperty("os.version").
indexOf("3.5") < 0)
	|| (_info.indexOf("Sun") > 0)  
	|| (_info.indexOf("Linux") > 0) ));
//--></SCRIPT>
</COMMENT>

<SCRIPT LANGUAGE="JavaScript"><!--
	if (_ie == true) 
	{
		document.writeln(" <OBJECT");
		document.writeln
(" CLASSID=\"clsid:8AD9C840-044E-11D1-B3E9-00805F499D93\"");
		document.writeln
(" CODEBASE=\"http://java.sun.com/products/plugin/1.3.0_01/ jinstall-130_01-win32.cab#Version=1,3,0,1\"");
		document.writeln(" HEIGHT=400");
		document.writeln(" NAME=\"TableViewExample\"");
		document.writeln(" WIDTH=600");
		document.writeln(" >");
		document.writeln(" <NOEMBED><XMP>");
	}
	else if (_ns == true) 
	{
		document.writeln(" <EMBED");
		document.writeln(" PLUGINSPAGE=\"http://java.sun.com/ products/plugin/1.3.0_01/plugin-install.html\"");
		document.writeln(" TYPE=\"application/x-java-applet;jpi-version=1.3.0_01\"");
		document.writeln(" HEIGHT=400");
		document.writeln(" NAME=\"TableViewExample\"");
		document.writeln(" WIDTH=600");
		document.writeln(" CODE=\"TableViewExample.class\"");
		document.writeln(" ><NOEMBED><XMP>");
	}
//--></SCRIPT>

<APPLET CODE="TableViewExample.class" WIDTH=600 	NAME="TableViewExample" HEIGHT=400></XMP>
	<PARAM NAME="CODE" VALUE="TableViewExample.class">
</APPLET>
</NOEMBED>
</EMBED>
</OBJECT>
<!}}~SAS~(APPLET)>
</BODY>
</HTML>

Example 9.5

<APPLET CODE="DataBeanwizard.class" 
	WIDTH=449 
	NAME="DataBeanwizard" 
	HEIGHT=400 
	ARCHIVE="DataBeanwizard.jar" >
	<PARAM NAME="ARCHIVE" VALUE="DataBeanwizard.jar">
	<PARAM NAME="CODE" VALUE="DataBeanwizard.class">
</APPLET>


Chapter 10

Example 10.1

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class SimpleServlet extends HttpServlet
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

Example 10.2

<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>JSP Examples</title>
	<style type="text/css">
		h1   { color: blue; }        
		body { font-family: helvetica, arial; }
	</style>
</head>
<body>
	<h1>Example 2. Simple JavaServer Page</h1>
	<% out.print("Hello World!"); %>
	The time now is <%= new java.util.Date() %>
</body>
</html>

Example 10.3

package org.apache.jsp;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.apache.jasper.runtime.*;

public class example1$jsp extends HttpJspBase 
{
	static {} public example1$jsp( ) {}

	private static boolean _jspx_inited = false;
	public final void _jspx_init() 
		throws org.apache.jasper.runtime.JspException {}

	public void _jspService	(HttpServletRequest request,
		HttpServletResponse response)
		throws java.io.IOException, ServletException 
	{
		JspFactory _jspxFactory = null;
		PageContext pageContext = null;
		HttpSession session = null;
		ServletContext application = null;
		ServletConfig config = null;
		JspWriter out = null;
		Object page = this;
		String  _value = null;
		
		try 
		{
			if (_jspx_inited == false) 
			{
				synchronized (this) 
				{
					if (_jspx_inited == false) 
					{
						_jspx_init();
						_jspx_inited = true;
					}
				}
			}
			_jspxFactory = JspFactory.getDefaultFactory();
			response.setContentType("text/html;charset=ISO-8859-1");
			pageContext = _jspxFactory.getPageContext
				(this, request, response,"", true, 8192, true);
			application = pageContext.getServletContext();
			config = pageContext.getServletConfig();
			ses	sion = pageContext.getSession();
			out = pageContext.getOut();

		// HTML 
		// begin [file="/jsp/example1.jsp";from=(0,0); to=(13,1)]
			out.write ("<?xml version=\"1.0\"?>\r\n
				<!DOCTYPE html PUBLIC
				\"-//W3C//DTD XHTML Transitional//EN\"\r\n
				\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-
				transitional.dtd\">\r\n
				<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n
				<head>\r\n
				\t<title>JSP Examples</title>\r\n
				\t<style type=\"text/css\">\r\n
				\t h1   { color: blue; }        \r\n
				\t body { font-family: helvetica, arial;}\r\n
				\t</style>\r\n</head>\r\n
				<body>\r\n
				\t<h1>Example 1. Simple JavaServer Page</h1>\r\n
				\t");
		// end
		// begin [file="/jsp/example1.jsp";from=(13,3);to=(13,33)]
			out.println("Hello World!"); 
		// end
		// begin [file="/jsp/example1.jsp";from=(13,35);to=(14,17)]
			out.write("\r\n\tThe time now is ");
		// end
		// begin [file="/jsp/example1.jsp";from=(14,20);to=(14,42)]
			out.print( new java.util.Date() );
		// end
		// begin [file="/jsp/example1.jsp";from=(14,44);to=(18,0)]
			out.write("\r\n</body>\r\n</html>\r\n\r\n");
		// end
		} 
		catch (Throwable t) 
		{
			if (out != null && out.getBufferSize() != 0)
				out.clearBuffer();
			if (pageContext != null)
				pageContext.handlePageException(t);
		} 
		finally 
		{
			if (_jspxFactory != null)
				_jspxFactory.releasePageContext(pageContext);
		}
	}
}

Example 10.4

<html>
<!-
	Copyright (c) 1999 The Apache Software Foundation.  
	All rights reserved.
-->
<body bgcolor="white">
	<jsp:useBean id='clock' scope='page' 
	   	class='dates.JspCalendar' 
    		type="dates.JspCalendar" />
	<font size=4><ul>
		li>	Day of month: is  <jsp:getProperty name="clock"
			property="dayOfMonth"/>
		<li>Year: is  <jsp:getProperty name="clock" 
			property="year"/>
		<li>Month: is  <jsp:getProperty name="clock" 
			property="month"/>
		<li>Time: is  <jsp:getProperty name="clock" 
			property="time"/>
		<li>Date: is  <jsp:getProperty name="clock" 
			property="date"/>
		<li>Day: is  <jsp:getProperty name="clock" 
			property="day"/>
		<li>Day Of Year: is  <jsp:getProperty name="clock"
			property="dayOfYear"/>
		<li>Week Of Year: is  <jsp:getProperty name="clock"
			property="weekOfYear"/>
		<li>era: is  <jsp:getProperty name="clock" 
			property="era"/>
		<li>DST Offset: is  <jsp:getProperty name="clock"
			property="DSTOffset"/>
		<li>Zone Offset: is  <jsp:getProperty name="clock"
			property="zoneOffset"/>
	</ul></font>
</body>
</html>

Example 10.5

package examples;

import java.util.Date;import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;

public class SimpleTag 
	    extends TagSupport 
{	
   public int doStartTag() throws JspException 
	{	
	      try 
	      {	
		       pageContext.getOut().print
		       ("Hello World." + "The time now is " + 
		        new Date());
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

Example 10.6

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
	<tag-class>examples.SimpleTag</tag-class>
	<tei-class>EMPTY</tei-class>
	<description>Hello world example</description>
	</tag>
</taglib>


Example 10.7

<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib URL="simple.tld" prefix="test" %>
<head>
	<title>JSP Examples - Custom Tag Library</title>
	<style type="text/css">
		h1   { color: maroon; }        
		h2   { color: blue; }        
		body { font-family: helvetica, arial; }
	</style>
</head>
<body>
	<h1>Example 10-7. JavaServer Page</h1>
	<h2>Custom Tag Example</h2>	
	<test:SayHello />
</body>
</html>

Example 10.8

import java.sql.*;

public class ODBCTest
{
	public static void main(String[] args)
	{
		Connection con = null;

		try // open connection to database
		{
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			con = DriverManager.getConnection("jdbc:odbc:Northwind");
			
			// print connection information
			DatabaseMetaData dma = con.getMetaData();
			System.out.println("\nConnected to " + dma.getURI());
			System.out.println("Driver " + dma.getDriverName());
			System.out.println("Version " + dma.getDriverVersion());
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally // make sure connection gets closed properly
		{
			try
			{
				if (null != con) con.close();
			}
			catch (SQLException e) {}
		}
	}
}

Example 10.9

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib URL=http://jakarta.apache.org/taglibs/dbtags
	prefix="sql" %>
<head>
	<title>JSP Examples - JDBC</title>
	<style type="text/css">
		h1   	{ color: maroon; text-align: center; }        
		h2   	{ color: blue; text-align: center;}
		th		{ background-color: cyan; }   
		caption { font-weight: bold; }     
		body 	{ font-family: helvetica, arial; }
	</style>
</head>

<body>
	<h1>Example 10.9. JavaServer Page</h1>
	<h2>JDBC Example</h2>	
	<table border="1" align="center">
		<caption>
			Category = 1
		</caption>
		<tr>
			<th>ProductID</th>
			<th>ProductName</th>  		
		</tr>
		<%-- open a database connection --%>
		<sql:connection id="conn1">
			<sql:driver>
				sun.jdbc.odbc.JdbcOdbcDriver		
			</sql:driver>
			<sql:URL>
				jdbc:odbc:Northwind
			</sql:URL>  	
		</sql:connection>

		<%-- open a database query --%>  	
		<sql:statement id="stmt1" conn="conn1"> 
			<sql:query>
				select ProductID, ProductName   	  		 
					from products
					where CategoryID = 1
			</sql:query>
			<%-- loop through the rows of your query --%>
			<sql:resultSet id="rset2">
				<tr>
					<td><sql:getColumn position="1"/></td>
					<td><sql:getColumn position="2"/></td>
					<td>	
						<sql:wasNull>
							No records were selected.
						</sql:wasNull>
					</td>
				</tr>
			</sql:resultSet>
		</sql:statement>
		<%-- close database connection --%>
		<sql:closeConnection conn="conn1"/>
	</table>
</body>
</html>




Chapter 11


Example 11.1

// start java webserver
-Morg.apache.tomcat.startup.Tomcat
-Dtomcat.home=d:\Apache\htdocs\sasweb
-Djava.class.path=d:\Apache\htdocs\sasweb;
	D:\AppDevStudio\webaf\projects;
	D:\AppDevStudio\java\webserver\webserver.jar;
	D:\AppDevStudio\java\webserver\jasper.jar;
	D:\AppDevStudio\java\misc\servlet.jar;
	D:\AppDevStudio\java\misc\xerces.jar;
	D:\jdk1.3.0_01\lib\tools.jar;
	D:\AppDevStudio\java\misc\webAFServerPages.jar


Example 11.2

Starting tomcat. Check logs/tomcat.log for error messages

2002-08-07 01:24:53 - ContextManager: Adding context Ctx( /examples )

2002-08-07 01:24:53 - ContextManager: Adding context Ctx(  )

2002-08-07 01:24:53 - ContextManager: JspClassDebugInfo: Enabling inclusion of class debugging information in JSP servlets for context "/examples".

2002-08-07 01:24:53 - path="/examples" :jsp: init

2002-08-07 01:24:54 - Scratch dir for the JSP engine is: D:\AppDevStudio\WebAppDev\work\localhost_8082%2Fexamples

2002-08-07 01:24:54 - IMPORTANT: Do not modify the generated servlets

2002-08-07 01:24:54 - ContextManager: JspClassDebugInfo: Enabling inclusion of class debugging information in JSP servlets for context "".

2002-08-07 01:24:54 - path="" :jsp: init

2002-08-07 01:24:54 - PoolTcpConnector: Starting HttpConnectionHandler on 8082

2002-08-07 01:24:54 - PoolTcpConnector: Starting Ajp12ConnectionHandler on 8083

Example 11.3

<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<%@taglib URL="http://www.sas.com/taglib/sasads" prefix="sasads"%>

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

Example 11.4

<% 	// Java scriptlet to calculate temperature conversion
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

Example 11.5

<%-- JSP Temperature Conversion Calculator --%>
<%@ include file="JSPheader.html" %>

<% 	// Java scriptlet to calculate temperature
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

<sasads:Form id="calculator" action="F2C.jsp" method="get">
	<p><sasads:TextEntry id="input" 
		prolog="<strong>Enter a temperature and select a conversion type: </strong>"
		size="8" text="<%=temp%>" /></p>

	<p><sasads:Radio 
		id="convert" selectedItem="<%=type%>">
			Fahrenheit to Centigrade 
			Centigrade to Fahrenheit
	</sasads:Radio></p>

	<p><sasads:TextEntry 
		id="output" 
		prolog="<strong>Result: </strong>" 		
		size="8" text="<%=result%>" /></p>

	<sasads:PushButton 
		id="submit" 	text="Submit" />

</sasads:Form>

<%@ include file="JSPfooter.html" %>

Example 11.6

<%@ page import="com.sas.collection.OrderedCollection" %>

<% 	// Java scriptlet to calculate temperature
	String temp = request.getParameter("input"); 	
	String type = request.getParameter("convert");
	String result = new String();

	// default is 1st radio button
	int checked = 0;

	// add the labels for the radio buttons to the page context
	pageContext.setAttribute
		( "values",	new OrderedCollection("F,C") );
	pageContext.setAttribute
		( "labels",	new OrderedCollection
		("Fahrenheit to Centigrade, Centigrade to Fahrenheit") );

	if (null != temp && null != type)
	{
		double dt = new Double(temp).doubleValue();
		if (type.charAt(0) == 'F')
		{
			result = String.valueOf(5d * (dt - 32d)/9d);			
		}
		else if (type.charAt(0) == 'C')
		{
			result = String.valueOf((9d * dt) / 5d + 32d);		
			checked = 1;
		}	
	}
%>

Example 11.7

<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>JSP Examples</title>
</head>
<body style="text-align: center; ">

<h1 style="color: blue">Temperature Conversion Calculator</h1>

<form name="calculator" method="get" action="F2C.jsp">
	
<p><strong>Enter a temperature and select a conversion type: </strong>
<input type="text" name="input" value="212" size="8" /></p>
<p><input type="radio" name="convert" value="F" checked="checked">
Fahrenheit to Centigrade</input><br />

<input type="radio" name="convert" value="C">
Centigrade to Fahrenheit</input></p>

<p><strong>Result: </strong>
<input type="text" name="output" value="100.0" size="8" /></p>

<input type="submit" name="submit" value="Submit" />

</form>

</body>
</html>

Example 11.8

options nodate nonumber noovp;

/* Sample Program: shoes.sas	*/

%macro salesrpt(region);

	proc report data=sashelp.shoes;
		by region;
		%if (&region ne ) %then %do;
			where region="&region";
		%end;
		title "<h2>Shoe Sales by Region x Product</h2>";
		footnote "Data are current as of &systime &sysdate9";
		column product sales;
	 	define product / group;
 		define sales / analysis sum;
	quit;

%mend salesrpt;


Example 11.9

<%@taglib URL="http://www.sas.com/taglib/sasads" prefix="sasads"%>
<%@ include file="JSPheader.html" %>

<sasads:Connection 
	id="connection1" 
	scope="session" 	 	
	host="ethelred"
	usernamePrompt="Username:" 
	username="IUSR_ETHELRED"
	passwordPrompt="Password:"
	password="" />

<sasads:Submit id="submit1" 
	connection="connection1"	
	display="LASTOUTPUT" >
	<%@ include file="shoes.sas" %>
 	%salesrpt(<%= request.getParameter("region") %>)
</sasads:Submit>

<sasads:Image 
	image="assets/saspower.gif" 
	alignment="RIGHT" />

<%@ include file="JSPfooter.html" %>

Example 11.10

<%@ include file="JSPheader.html" %>
<%@ taglib URL="http://www.sas.com/taglib/sasads" prefix="sasads"%>
<%@ page import="com.sas.sasserver.datasetinfo.DataSetInfoInterface" %>
<%@ page import="com.sas.collection.OrderedCollection" %>

<sasads:Connection 
	id="connection1" 
	scope="session" 	 	
	host="ethelred"
	usernamePrompt="Username:" 
	username="IUSR_ETHELRED"
	passwordPrompt="Password:"
	password="" />

<% // Java scriptlet
	DataSetInfoInterface dsinfo = (DataSetInfoInterface) 
	    	com.sas.servlet.util.Util.newInstance
			(connection1.getClassFactory(),
			 connection1, DataSetInfoInterface.class);	
	dsinfo.setDataSet("SASHELP.SHOES");	

	// display unique values of region
	int index = dsinfo.getVariableIndex("REGION");
 	String[] values = dsinfo.getVariableUniqueValues(index); 	
 	pageContext.setAttribute("values",new OrderedCollection(values));
%>

<h1>International Shoe Sales Data</h1>

<sasads:Form id="form1" action="submit.jsp" >

	<sasads:Listbox 
		id="region" 
		model="values" 	
		prolog="<strong>Select region for report: </strong>" />

	<p><sasads:PushButton id="submit" text="Submit" /></p>

</sasads:Form>
<%@ include file="JSPfooter.html" %>





Example 11.11

<%@taglib uri="http://www.sas.com/taglib/sasads" prefix="sasads"%>
<%@ page import="com.sas.collection.StringCollection" %>

<sasads:Connection 
	id="connection1" 
	scope="session" 
 	initialStatement="libname EXAMS 'd:\\exams';" />

<sasads:DataSet id="table1" 
	connection="connection1" 
	dataSet="EXAMS.TESTS" />
	
<%	// Get unique test names and codes from data set,
	//	add collections to page context
	pageContext.setAttribute	("codes",
		new StringCollection(table1.getFormattedColumn(1)));
	pageContext.setAttribute	("labels",
		new StringCollection(table1.getFormattedColumn(2)));	
%>

<%-- begin HTML --%>
<html>
<head>
	<title>JSP Examples</title>
</head>
<body>
<h1 style="color: blue; text-align: center">
	On-line Exam Demo</h1>

<sasads:Form method="get" action="page1.jsp" 
	style="text-align: center;">

<sasads:Choicebox id="test" 
	prolog="<strong>Select Test: </strong>"
	model="codes" descriptionModel="labels" />

<sasads:PushButton text="Begin" /></p>

</sasads:Form>
</body>
</html>

Example 11.12

<%@taglib URL="http://www.sas.com/taglib/sasads" prefix="sasads"%>
<%@ include file="JSPheader.html" %>

<sasads:Connection 
	id="connection1" 	
	host="ethelred" 	
	usernamePrompt="Username:"
	username="IUSR_ETHELRED"
	passwordPrompt="Password:"
	password=""	
	scope="session" />

<sasads:DataSet 
	id="dataSet1" 
	connection="connection1" 
	dataSet="SASHELP.RETAIL" 
	where="Year ge 1990" />

<h1>SASHELP.RETAIL Data Set</h1>
<h2>Range: 1990 to 1994</h2>

<sasads:Table id="table1" 
	model="dataSet1" 
	useColumnHeadings="true" 
	maxRows="25" 		
	borderWidth="1" 	
 	navigationBarEnabled="false"  
	horizontalAlignment="center"/>

<sasads:Image 
	image="assets/saspower.gif" 
	alignment="RIGHT" />
<%@ include file="JSPfooter.html" %>

Example 11.13

<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>JSP Examples</title>
</head>
<link rel="stylesheet" type="text/css" href="MyStyle.css" />

<body>
<h1>SASHELP.RETAIL Data Set</h1>
<h2>Range: 1990 to 1994</h2>

<TABLE CLASS="tableContainer"  ALIGN="center">
<TR><TD CLASS="tableContent" ALIGN="center">
<table border="1" cellspacing="1" cellpadding="0">
<tr><th>SALES</th><th>DATE</th><th>YEAR</th><th>MONTH</th><th>DAY</th></tr>
<tr><td>$606</td><td>90Q1</td><td>1990</td><td>1</td><td>1</td></tr>
<tr><td>$674</td><td>90Q2</td><td>1990</td><td>4</td><td>1</td></tr>
<tr><td>$705</td><td>90Q3</td><td>1990</td><td>7</td><td>1</td></tr>
<tr><td>$749</td><td>90Q4</td><td>1990</td><td>10</td><td>1</td></tr>
<tr><td>$703</td><td>91Q1</td><td>1991</td><td>1</td><td>1</td></tr>
<tr><td>$709</td><td>91Q2</td><td>1991</td><td>4</td><td>1</td></tr>
<tr><td>$728</td><td>91Q3</td><td>1991</td><td>7</td><td>1</td></tr>
<tr><td>$807</td><td>91Q4</td><td>1991</td><td>10</td><td>1</td></tr>
<tr><td>$692</td><td>92Q1</td><td>1992</td><td>1</td><td>1</td></tr>
<tr><td>$797</td><td>92Q2</td><td>1992</td><td>4</td><td>1</td></tr>
<tr><td>$826</td><td>92Q3</td><td>1992</td><td>7</td><td>1</td></tr>
<tr><td>$889</td><td>92Q4</td><td>1992</td><td>10</td><td>1</td></tr>
<tr><td>$758</td><td>93Q1</td><td>1993</td><td>1</td><td>1</td></tr>
<tr><td>$909</td><td>93Q2</td><td>1993</td><td>4</td><td>1</td></tr>
<tr><td>$920</td><td>93Q3</td><td>1993</td><td>7</td><td>1</td></tr>
<tr><td>$991</td><td>93Q4</td><td>1993</td><td>10</td><td>1</td></tr>
<tr><td>$876</td><td>94Q1</td><td>1994</td><td>1</td><td>1</td></tr>
<tr><td>$998</td><td>94Q2</td><td>1994</td><td>4</td><td>1</td></tr>
</table>
</TD></TR>
</TABLE>

<img name="Image" src="assets/saspower.gif" align="RIGHT" border="0" />

</body>
</html>


Example 11.14

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.sas.rmi.*;
import com.sas.sasserver.dataset.*; 

public class ServletExample extends HttpServlet
{
	public void doPost(HttpServletRequest request,
		HttpServletResponse response)	
		throws IOException, ServletException
	{
		// retrieve the current session identifer
		HttpSession session = request.getSession();
	
		// Setup the connection to SAS       	
		Connection connection1 = new Connection();
		connection1.setHost("ethelred");
		connection1.setUsernamePrompt("Username:");
		connection1.setUsername("IUSR_ETHELRED");
		connection1.setPasswordPrompt("Password:");
		connection1.setPassword("");
		
		try
		{
			Rocf rocf = new Rocf();
			DataSetInterface dataset1 = (DataSetInterface)
			rocf.newInstance(DataSetInterface.class,connection1);
			dataset1.setDataSet("sashelp.shoes");	   	
			RequestDispatcher rd = 		getServletContext().getRequestDispatcher("/table.jsp"); 
			session.setAttribute("dataset1", dataset1);
			rd.forward(request, response);  
		} 
		catch (Exception ex) {}
	}
}


Example 11.15

<%@ taglib URL="http://www.sas.com/taglib/sasads" prefix="sasads" %>
<%@ include file="JSPheader.html" %>

<sasads:DataSet ref="dataset1" scope="session" />
<h1>International Shoes Database</h1>

<sasads:Table 
	id="table1" 
	model="dataset1" 
	prolog="<strong>Sales by Region</strong>"	
   	useColumnHeadings="true" 
	navigationBarEnabled="false"
	borderWidth="1" 
	cellSpacing="2" 
   	cellPadding="1" /> 	

<sasads:Image image="saspower.gif" alignment="RIGHT" />
<%@ include file="JSPfooter.html" %>


Chapter 12

Example 12.1

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
			  && java.lang.System.getProperty("os.version").indexOf("3.5") < 0)
			  || (_info.indexOf("Sun") > 0)  || (_info.indexOf("Linux") > 0) ));
//--></SCRIPT>
</COMMENT>
<SCRIPT LANGUAGE="JavaScript"><!--
if (_ie == true) {
	document.writeln(" <OBJECT");
	document.writeln(" CLASSID=\"clsid:8AD9C840-044E-11D1-B3E9-00805F499D93\"");
	document.writeln(" CODEBASE=\"http://java.sun.com/products/plugin/1.3.0_01/jinstall-130_01-win32.cab#Version=1,3,0,1\"");
	document.writeln(" HEIGHT=494");
	document.writeln(" WIDTH=853");
	document.writeln(" >");
	document.writeln(" <NOEMBED><XMP>");
}
else if (_ns == true) {
	document.writeln(" <EMBED");
	document.writeln(" PLUGINSPAGE=\"http://java.sun.com/products/plugin/1.3.0_01/plugin-install.html\"");
	document.writeln(" TYPE=\"application/x-java-applet;jpi-version=1.3.0_01\"");
	document.writeln(" HEIGHT=494");
	document.writeln(" WIDTH=853");
	document.writeln(" ARCHIVE=\"_webEIS_Preview_.jar\"");
	document.writeln(" CODE=\"DocumentApplet.class\"");
	document.writeln(" reportURL=\"_webEIS_Preview_.eis\"");
	document.writeln(" ><NOEMBED><XMP>");
}
//--></SCRIPT>
<APPLET CODE="DocumentApplet.class" WIDTH=853 HEIGHT=494 ARCHIVE="_webEIS_Preview_.jar" ></XMP>
<PARAM NAME="ARCHIVE" VALUE="_webEIS_Preview_.jar">
<PARAM NAME="CODE" VALUE="DocumentApplet.class">
<PARAM NAME="reportURL" VALUE="_webEIS_Preview_.eis">
</APPLET>
</NOEMBED></EMBED></OBJECT>
<!}}~SAS~(APPLET)>
</BODY>
</HTML>

Chapter 13

Example 13.1

<html>
<head>
	<meta http-equiv="Content-Language" content="en-us">
	<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
	<meta name="ProgId" content="FrontPage.Editor.Document">
	<meta http-equiv="Content-Type" 
		content="text/html; charset=windows-1252">
	<title>SAS Design Time Controls Example</title>
</head>
<body>
<h1 align="left">
	<font color="#0000FF" face="Verdana">
	SAS Design Time Controls Example</font>
</h1>
<h2 align="left">
	<font color="#993333" face="Arial">
	DTC Table Control: SASHELP.RETAIL</font>
</h2>
<p align="left">

<!--metadata type="DesignerControl" startspan
<object classid="clsid:6ED5010A-D596-11D3-87D7-00C04F2C0BF6"
		id="Table1" dtcid="2">
     <param name="_Version" value="65536">
     <param name="_ExtentX" value="1270">
     <param name="_ExtentY" value="1270">
     <param name="_StockProps" value="0">
     <param name="BrokerURL" value="/cgi-bin/broker">
     <param name="DataSet" value="SASHELP.RETAIL">
     <param name="Debug" value="0">
     <param name="Password" value>
     <param name="ProcessingMode" value="build">
     <param name="Program" value="sashelp.websdk1.ds2htm2.scl">
     <param name="Service" value="default">
     <param name="SQLView" value>
     <param name="WebServer" value="hrothgar">
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
     <param name="VariableFontFace" 
		value="Arial,Helvetica,sans-serif">
     <param name="SumVariableFontFace"
		value="Arial,Helvetica,sans-serif">
     <param name="ColumnLabelFontFace"
		value="Arial,Helvetica,sans-serif">
     <param name="IDVariableFontFace"
		value="Arial,Helvetica,sans-serif">
     <param name="ObsFontFace" 
		value="Arial,Helvetica,sans-serif">
     <param name="CaptionFontFace" 
		value="Arial,Helvetica,sans-serif">
     <param name="ByVariableFontFace"
		value="Arial,Helvetica,sans-serif">
     <param name="ExtraParms" value>
     <param name="RegistryKey" 
		value="Software\SAS Institute Inc.\
			SAS Design-Time Controls\TableCtrl">
</object>
-->
<P>
 
<TABLE BORDER="1" WIDTH="0%" CELLPADDING="1" CELLSPACING="1">
  <TR>
    <TH ALIGN="CENTER" VALIGN="MIDDLE">
	<FONT FACE="Arial,Helvetica,sans-serif">
	Retail sales in millions of $</FONT></TH>
    <TH ALIGN="CENTER" VALIGN="MIDDLE">
	<FONT FACE="Arial,Helvetica,sans-serif">DATE</FONT></TH>
    <TH ALIGN="CENTER" VALIGN="MIDDLE">
	<FONT FACE="Arial,Helvetica,sans-serif">YEAR</FONT></TH>
    <TH ALIGN="CENTER" VALIGN="MIDDLE">
	<FONT FACE="Arial,Helvetica,sans-serif">MONTH</FONT></TH>
    <TH ALIGN="CENTER" VALIGN="MIDDLE">
	<FONT FACE="Arial,Helvetica,sans-serif">DAY</FONT></TH>
  </TR>
  <TR>
    <TD ALIGN="CENTER" VALIGN="MIDDLE">
	<FONT FACE="Arial,Helvetica,sans-serif">$876</FONT></TD>
    <TD ALIGN="CENTER" VALIGN="MIDDLE">
	<FONT FACE="Arial,Helvetica,sans-serif">94Q1</FONT></TD>
    <TD ALIGN="CENTER" VALIGN="MIDDLE">
	<FONT FACE="Arial,Helvetica,sans-serif">1994</FONT></TD>
    <TD ALIGN="CENTER" VALIGN="MIDDLE">
	<FONT FACE="Arial,Helvetica,sans-serif">1</FONT></TD>
    <TD ALIGN="CENTER" VALIGN="MIDDLE">
	<FONT FACE="Arial,Helvetica,sans-serif">1</FONT></TD>
  </TR>
  <TR>
    <TD ALIGN="CENTER" VALIGN="MIDDLE">
	<FONT FACE="Arial,Helvetica,sans-serif">$998</FONT></TD>
    <TD ALIGN="CENTER" VALIGN="MIDDLE">
	<FONT FACE="Arial,Helvetica,sans-serif">94Q2</FONT></TD>
    <TD ALIGN="CENTER" VALIGN="MIDDLE">
	<FONT FACE="Arial,Helvetica,sans-serif">1994</FONT></TD>
    <TD ALIGN="CENTER" VALIGN="MIDDLE">
	<FONT FACE="Arial,Helvetica,sans-serif">4</FONT></TD>
    <TD ALIGN="CENTER" VALIGN="MIDDLE">
	<FONT FACE="Arial,Helvetica,sans-serif">1</FONT></TD>
  </TR>
</TABLE>

<P>
 
<!--metadata type="DesignerControl" endspan--></p>

</body>
</html>

Example 13.2

<%
{	appserver.AppServer IappServer = new appserver.AppServer();

	IappServer.setURL(null);
	IappServer.setURL("http://hrothgar/cgi-bin/broker");

	String queryString = "_service=default&
		_debug=0&
		_program=sashelp.websdk1.ds2htm2.scl&
		data=SASHELP.RETAIL&
		pagepart=body&
		where=year%20eq%201994&
		twidth=0&
		twunits=Percent&
		border=Y&
		formats=Y&
		labels=Y&
		obsnum=N&
		talign=default&
		vface=Arial,Helvetica,sans-serif&
		sface=Arial,Helvetica,sans-serif&
		clface=Arial,Helvetica,sans-serif&
		iface=Arial,Helvetica,sans-serif&
		oface=Arial,Helvetica,sans-serif&
		cface=Arial,Helvetica,sans-serif&
		bface=Arial,Helvetica,sans-serif";

	java.io.OutputStream os = IappServer.getOutputStream();
	os.write(queryString.getBytes());
	os.close();

	String HTML = IappServer.getHTML();
	int responseCode = IappServer.getResponseCode();

	if (responseCode >= 200 && responseCode < 300)
  		out.println(HTML);
	else if (responseCode == 401) 
	{
HTML = "<P><FONT COLOR=\"red\">ERROR: Authenticated sites are not supported.</FONT></P><BR>" + HTML;
	      IappServer.printDTCError
		   (new PrintWriter(out, true), responseCode, HTML);
	}
  	else 
    		IappServer.printDTCError
		   (new PrintWriter(out, true), responseCode, HTML);
}
%>

Example 13.3

<%
sub displayURL(URL) 

	Dim AppServer, HTML

	Set AppServer = CreateObject("SAS.AppServerPostURL")

	AppServer.webServer = "hrothgar"
	AppServer.URL = "/cgi-bin/broker"
	AppServer.queryString = URL

	HTML = AppServer.openURL()

	Response.Write HTML

End sub


	displayURL("_service=default&
		_debug=0&
		_program=sashelp.websdk1.ds2htm2.scl&
		data=SASHELP.RETAIL&
		pagepart=body&
		where=year%20eq%201994&
		twidth=0&
		twunits=Percent&
		border=Y&
		formats=Y&
		labels=Y&
		obsnum=N&
		talign=default&
		vface=Arial,Helvetica,sans-serif&
		sface=Arial,Helvetica,sans-serif&
		clface=Arial,Helvetica,sans-serif&
		iface=Arial,Helvetica,sans-serif&
		oface=Arial,Helvetica,sans-serif&
		cface=Arial,Helvetica,sans-serif&
		bface=Arial,Helvetica,sans-serif")
%>

