Example 3.1  Sample PROC TABULATE Program

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

Example 3.2  Using HTML Pre-formatting

<html>
<head>
<title>Retail Sales Table</title>
</head>
<body>
<h1 style="font-family: helvetica, tahoma, arial; color: blue">
Retail Sales in Millions of $</h1>
<pre>
--------------------------------------------------------------
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
 
Example 3.3  Using PUT Statements to Write HTML

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
 
Example 3.4  Using the ODS HTML Statement

filename OUT "Example 3-4.html";

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

Example 3.5  Creating Multiple Web Pages 

ods listing close;
ods html body="Example3-4.html" newfile=proc;

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

 
Example 3.6  Creating Frames with ODS

ods listing close;
ods html path="c:\Data\examples" (url=NONE)
body = "body3-6.html"
contents = "contents3-6.html"
frame = "frame3-6.html";

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
 
Example 3.7  ODS HTML Data Set Listing

filename OUT "Example3-7.html";
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

Example 3.8  Default Style Template

proc template;          
                                                      
define style Styles.Default;                                               

style fonts                                                             
"Fonts used in the default style" /                                  
'TitleFont2' = ("Arial, Helvetica, sans-serif",4,Bold Italic)        
'TitleFont' = ("Arial, Helvetica, sans-serif",5,Bold Italic)         
'StrongFont' = ("Arial, Helvetica, sans-serif",4,Bold)               
'EmphasisFont' = ("Arial, Helvetica, sans-serif",3,Italic)           
'FixedEmphasisFont' = ("Courier New, Courier, monospace",2,Italic)   
'FixedStrongFont' = ("Courier New, Courier, monospace",2,Bold)       
'FixedHeadingFont' = ("Courier New, Courier, monospace",2)       
'BatchFixedFont' = ("SAS Monospace, Courier New, Courier, monospace",2)                                          
'FixedFont' = ("Courier",2)                                          
'headingEmphasisFont' = ("Arial, Helvetica, sans-serif",4,Bold Italic)
'headingFont' = ("Arial, Helvetica, sans-serif",4,Bold)              
'docFont' = ("Arial, Helvetica, sans-serif",3);                      

	[ ... many more styles omitted ... ]

end; 

Example 3.9  ODS Sasweb Style Data Set Listing 

filename OUT  "Example3-9.html";
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
