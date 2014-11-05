Example 8.1  Summarizing Data with htmSQL

<html>
<head>
<title>SAS IntrNet Examples: htmSQL</title>
<style type="text/css">
body	    { text-align: center; }		
caption { font-weight: bold; }
h1      { color: blue; }	      		
h3      { color: red; }    					
td      { text-align: right; }	
p.foot  { font-weight: bold; }
</style>
</head>
<body>
{query server="odin:5010" sapw="user" 
userid="sas" password="{sas002}65CC6A18386EF24B409005161FBDA6C7”}
{sql}
select product, 
sum(sales) as total label="Total Sales"
format=dollar8.
from sashelp.shoes
where region='{&region}'
group by product	
{/sql}
<h1>Shoe Sales by Product</h1>
<hr/>
{norows}
<h3>No rows selected. Check that the region parameter 
has been specified correctly.</h3>
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

Example 8.2  htmSQL Code to Generate Form Control Values

<html>
<head>
<title>SAS IntrNet Examples: htmSQL</title>
</head>
<body>
	{queryserver="odin:5010" sapw="user" userid="sas" password="{sas002}8E2E601B3514FC3C3228FBD625CED267"
{sql}select distinct region from sashelp.shoes{/sql}
<div style="text-align: center; ">
<form method=get action="shoeSales.hsql">	
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

