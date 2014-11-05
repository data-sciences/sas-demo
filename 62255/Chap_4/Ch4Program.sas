Example 4.1  Sample XML Document

<?xml version="1.0" encoding="UTF-8"?>
<class>
   <student id=”1”>
      <Name>Alfred</Name>
      <Sex>M</Sex>
      <Age>14</Age>
      <Height>69</Height>
      <Weight>112.5</Weight>
   </student>
   <student id=”2”>
      <Name>Alice</Name>
      <Sex>F</Sex>
      <Age>13</Age>
      <Height>56.5</Height>
      <Weight>84</Weight>
   </student>
	…
</class>

Example 4.2  Sample XML Document Type Definition

<!ELEMENT class (student)+>
<!ELEMENT student (Name,Sex,Age,Height,Weight)>
<!ATTLIST student id CDATA #REQUIRED>
<!ELEMENT Name (#PCDATA)>
<!ELEMENT Sex (#PCDATA)>
<!ELEMENT Age (#PCDATA)>
<!ELEMENT Height (#PCDATA)>
<!ELEMENT Weight (#PCDATA)>
 
Example 4.3  Sample XML Schema

<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" 
elementFormDefault="qualified">
<xs:element name="class">
<xs:complexType>
<xs:sequence>
<xs:element maxOccurs="unbounded" ref="student"/>
</xs:sequence>
</xs:complexType>
</xs:element>
<xs:element name="student">
<xs:complexType>
<xs:sequence>
<xs:element ref="Name"/>
<xs:element ref="Sex"/>
<xs:element ref="Age"/>
<xs:element ref="Height"/>
<xs:element ref="Weight"/>
</xs:sequence>
<xs:attribute name="id" use="required" type="xs:integer"/>
</xs:complexType>
</xs:element>
<xs:element name="Name" type="xs:NCName"/>
<xs:element name="Sex" type="xs:NCName"/>
<xs:element name="Age" type="xs:integer"/>
<xs:element name="Height" type="xs:decimal"/>
<xs:element name="Weight" type="xs:decimal"/>
</xs:schema>

Example 4.4  Using the SAS XML LIBNAME Engine

LIBNAME xmlout XML “class.xml”;
DATA xmlout.class;
SET sashelp.class; 
RUN;

Example 4.5  Using the SAS XML LIBNAME Engine to Create CDISC XML

LIBNAME output XML “ae.xml” XMLTYPE=CDISCODM FORMATACTIVE=YES;
DATA output.ae;
SET odm.ae;
RUN;

Example 4.6  Using XML Maps

FILENAME out 'student.xml';
FILENAME map 'class.map';                                               

LIBNAME out XML92 XMLTYPE=XMLMAP XMLMAP=MAP XMLENCODING='UTF-8';
DATA out.student;
SET SASHELP.class;
id=_n_;
RUN;
 
Example 4.7  Sample XML Map

<?xml version="1.0" encoding="windows-1252"?>
<SXLEMAP name="class" version="1.2">
<TABLE name="student">
<TABLE-PATH syntax="XPath">/class/student</TABLE-PATH>
<COLUMN name="id">
<PATH syntax="XPath">/class/student/@id</PATH>
<TYPE>numeric</TYPE>
<DATATYPE>integer</DATATYPE>
</COLUMN>
<COLUMN name="Name">
<PATH syntax="XPath">/class/student/Name</PATH>
<TYPE>character</TYPE>
<DATATYPE>string</DATATYPE>
<LENGTH>8</LENGTH>
</COLUMN>
<COLUMN name="Sex">
<PATH syntax="XPath">/class/student/Sex</PATH>
<TYPE>character</TYPE>
<DATATYPE>string</DATATYPE>
<LENGTH>1</LENGTH>
</COLUMN>
<COLUMN name="Age">
<PATH syntax="XPath">/class/student/Age</PATH>
<TYPE>numeric</TYPE>
<DATATYPE>integer</DATATYPE>
</COLUMN>
<COLUMN name="Height">
<PATH syntax="XPath">/class/student/Height</PATH>
<TYPE>numeric</TYPE>
<DATATYPE>double</DATATYPE>
</COLUMN>
<COLUMN name="Weight">
<PATH syntax="XPath">/class/student/Weight</PATH>
<TYPE>numeric</TYPE>
<DATATYPE>double</DATATYPE>
</COLUMN>
</TABLE>
</SXLEMAP>
 
Example 4.8  Using ODS to Create XML

ods listing close;
ods markup body='C:\My Documents\xml\class.xml';
proc print data=sashelp.class;run;
ods markup close;

Example 4.9  Using ODS to Create a Document Type Definition

libname myfiles 'C:\My Documents\myfiles';
ods listing close;
ods markup body='C:\My Documents\xml\statepop.xml' 
frame='C:\My Documents\xml\statepop.dtd' tagset=default;
proc univariate data=myfiles.statepop;
var citypop_90 citypop_80;
title 'US Census of Population and Housing';
run;
ods markup close;

Example 4.9  Using ODS to Create a Document Type Definition

libname myfiles 'C:\My Documents\myfiles';
ods listing close;
ods markup body='C:\My Documents\xml\statepop.xml' 
frame='C:\My Documents\xml\statepop.dtd' tagset=default;
proc univariate data=myfiles.statepop;
var citypop_90 citypop_80;
title 'US Census of Population and Housing';
run;
ods markup close;

Example 4.10  ODS Markup: XHTML

filename OUT "Example4-10.html";

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
 
Example 4.11  XHTML Template

proc template;
          
define tagset Tagsets.xhtml / store = SASUSER.TEMPLAT;
define event cell_is_empty;
put %nrstr("&nbsp;");
end;
                
define event doc;
start:
put '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"' NL;
put '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">' NL;
put '<html xmlns="http://www.w3.org/1999/xhtml">' NL;
ndent;
finish:
xdent;
put "</html>" NL;
end;
         
define event doc_head;
start:
put '<head>' NL;
ndent;
put '<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />' NL;
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
put     VALUE;
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
run;




