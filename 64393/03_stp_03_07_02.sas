/*=== Start the Stored Process ============*/
/*=== Define the library to the stored process ==========*/
      libname mylib meta liburi="SASLibrary?@name='Candy'";

/*=== Use ODS HTML Statements instead of %STPBEGIN and %STPEND to use html code within the _webout*/
/*=== no_bottom_matter = suppresses writing lower half of standard html code*/



   ods html body=_webout(no_bottom_matter 
        title='Order Detail Report') 
path=&_tmpcat (url=&_replay) 
style=sasweb;

/*=== close the ods html output location to allow for writing to the _webout*/
      ods html close;

/*=== setting the order_number prompt value to global*/
      %global order_number;

/*=== use an empty data step to write out to the file _webout*/
     data _null_;
/*=== define the file _webout*/
      file _webout;

/*=== set the source dataset*/
      set mylib.candy_sales_summary;

/*=== filter the data table on the prompt value 'order_number'*/
       where orderid = &order_number;

/*===	create a custom measure to write out total sales $ with a format to dollar9.*/

	format total dollar9.;
	total=retail_price*units;

/*=== use HTML code within put ''; or put ""; statements*/
   PUT "<p>";
   PUT "<a href=http://www.sasbibooks.com>More Information</a>";
   PUT "</p>";
   PUT "<!--GENERAL AREA ============================================ -->";
   PUT "<table border=0 cellpadding=2 cellspacing=2 width=95%>";
   PUT "<tr valign=middle bgcolor=#B0B0B0 >";
   PUT "<td align=left colspan=5>";
   PUT "<a id=1><font size=2><b>Order Number: " orderid"</b></font></a>";
   PUT "</td>";
   PUT "</tr>";
   PUT "<!-- ============================== -->";
   PUT "<tr valign=middle bgcolor=#D3D3D3>";
   PUT "<td><font size=2><b>Name</b></font></td>";
   PUT "<td><font size=2><b>Region</b></font></td>";
   PUT "<td><font size=2><b>Category</b></font></td>";
   PUT "<td><font size=2><b>Product</b></font></td>";
   PUT "<td><font size=2><b>Units</b></font></td>";
   PUT "</tr>";
/*==There are three other rows created using the same code and format as above*/
size=2>" total"</font></td>";
   PUT "</tr>";
   PUT "</table>";
run;

/*=== no_top_matter = used at the bottom of the process to suppress the writing of the top half of standard html*/

ods html body=_webout(no_top_matter 
                   title='Order Detail Report') 
         path=&_tmpcat (url=&_replay) style=sasweb;
ods html close;

/*=== END OF CODE ===*/
