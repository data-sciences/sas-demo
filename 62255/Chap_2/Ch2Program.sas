Example 2.1  Sample XHTML Source Code 

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
<div><img class="hdr" src="http://cs.eou.edu/images/csmm.jpg"
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
<p><a href="http://www.eou.edu">
<img class="logo"
src="http://cs.eou.edu/images/eoulogow2.gif"
alt="EOU logo" /></a></p>
</body>
</html>

Example 2.2  Sample Cascading Style Sheet

body { 
background-image: url("Underwater.jpg"); 
background-repeat: no-repeat; 
background-position: center; }
h1 { 
color: red; 
font-weight: bold; 
text-align: center; }
h2 { 
color: blue; 
font-weight: bold; 
text-align: center; }
h3 { 
color: yellow; 
text-align: center; }
h4 { 
color: cyan; 
text-align: center; }
p { 
color: green; 
font-size: 12 pt; 
text-align: center; }

Example 2.3  Sample Page with Link to External CSS

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<title>Example Stylesheet</title>
<link href="mystyle.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<h1>heading 1</h1>
<h2>heading 2</h2>
<h3>heading 3</h3>
<h4>heading 4</h4>
<p>paragraph1</p>
</body>
</html>
 
Example 2.4  Sample Cascading Style Sheet with Table Formats

body {
background-color: #FFFFFF;
font-family: verdana, helvetica, arial; }
:link {
color: #000080; }
:visited {
color: #0000FF }
:active {
color: #800000 }
table {
width:100%;
height:300px;
border: 0; }
td {	
width: 50%;
font-size: 10pt;
vertical-align: top;
padding: 2pt; }
td.row_hdr {
color: #800000;
background-color: #C0C0C0;
font-size: 12pt;
font-weight: bold;
height: 20px;
width: 100%; }
img.hdr	{
height: 100px;
width:  400px; }
img.logo {
border: 0;
float:	left;
height: 55px;	
width: 165px; }
 
Example 2.5  Sample HTML Form

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


