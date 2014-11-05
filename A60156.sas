/*------------------------------------------------------------------- */
 /*                   SAS Graphics for Java                           */
 /*               by Wendy Bohnenkamp and Jackie Iverson              */
 /*       Copyright(c) 2004 by SAS Institute Inc., Cary, NC, USA      */
 /*                      ISBN 978-1-59047-693-2                       */
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
 /* Attn: Wendy Bohnenkamp                                            */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  sasbbu@sas.com             */
 /* Use this for subject field:                                       */
 /*     Comments for Wendy Bohnenkamp                                 */
 /*                                                                   */
 /*-------------------------------------------------------------------*/

***Sample Code used in "SAS Graphics for Java" ;
Chapter 1.2   Code snipets

ADS2 connection example:
<sasads:DataSet connection="bbuConnection" dataSet="samples.grains"
	id="dsBar" scope="session" displayedColumns="country amount" />

ADS3 example of data model and bar chart:
<jsp:useBean id="barChartTableDataModel1" scope="session" 
  class="com.sas.graphics.components.barchart.BarChartTableDataModel">
  <jsp:setProperty name="barChartTableDataModel1" property="model" 
    value="<%=jdbcTableModelAdaptor%>" /> 
</jsp:useBean>

<%
barChartTableDataModel1.setCategoryVariable(
  new com.sas.graphics.components.ClassificationVariable("COUNTRY"));
barChartTableDataModel1.setResponseVariable(
  new com.sas.graphics.components.AnalysisVariable("AMOUNT"));
%>


***Sample Code used in Chapter 2 ;
Chapter 2.1.1 sasads:Bar
<sasads:Bar id="bbuBar" model="dsBar" scope="session" />

Chapter 2.1.2 sasads:Combination
<sasads:Combination id="bbuCombination" model="dsBar" scope="session" 
   categoryVariableName="year" responseVariableName="amount"
   subGroupVariableName="country" />

Chapter 2.1.3 sasads:Pie
<sasads:Pie id="bbuPie" model="dsBar" scope="session" />

Chapter 2.1.4 sasads:Scatter
<sasads:Scatter id="bbuScatter" model="dsBar" scope="session" />

Chapter 2.1.5 sasads:SegmentedBar
<sasads:SegmentedBar id="bbuSegmentedBar" model="dsBar" scope="session" 
   categoryVariableName="year" responseVariableName="amount"
   subGroupVariableName="country" />

Chapter 2.2.1 sas:BarChart
<jsp:useBean id="barChartTableDataModel1" scope="session" 
   class="com.sas.graphics.components.barchart.BarChartTableDataModel">
   <jsp:setProperty name="barChartTableDataModel1" property="model" 
      value="<%=jdbcTableModelAdaptor%>" /> 
</jsp:useBean>

<%
barChartTableDataModel1.setCategoryVariable(
   new com.sas.graphics.components.ClassificationVariable("COUNTRY"));
barChartTableDataModel1.setResponseVariable(
   new com.sas.graphics.components.AnalysisVariable("AMOUNT"));
%>

<sas:BarChart id="bbuSASBarChart" model="barChartTableDataModel1" 
   scope="session" >
</sas:BarChart>

Chapter 2.2.2 sas:BarLineChart
<jsp:useBean id="barLineChartTableDataModel1" scope="session" 
   class="com.sas.graphics.components.barlinechart.
   BarLineChartTableDataModel">
   <jsp:setProperty name="barLineChartTableDataModel1"
      property="model" value="<%=jdbcTableModelAdaptor%>" /> 
</jsp:useBean>

<%
barLineChartTableDataModel1.setCategoryVariable(
   new com.sas.graphics.components.ClassificationVariable("TEACHER"));
barLineChartTableDataModel1.setLineResponseVariable(
   new com.sas.graphics.components.AnalysisVariable("AGE", 
   com.sas.graphics.components.GraphConstants.STATISTIC_MEAN));
barLineChartTableDataModel1.setBarResponseVariable(
   new com.sas.graphics.components.AnalysisVariable("HEART", 
   com.sas.graphics.components.GraphConstants.STATISTIC_MEAN));
%>

<sas:BarLineChart id="bbuSASBarLineChart" 
   model="barLineChartTableDataModel1" scope="session" >
</sas:BarLineChart>

Chapter 2.2.3 sas:LineChart
<jsp:useBean id="lineChartTableDataModel1" scope="session" 
   class="com.sas.graphics.components.linechart.
   LineChartTableDataModel">
   <jsp:setProperty name="lineChartTableDataModel1" property="model" 
      value="<%=jdbcTableModelAdaptor%>" /> 
</jsp:useBean>

<%
lineChartTableDataModel1.setCategoryVariable(
   new com.sas.graphics.components.ClassificationVariable("COUNTRY"));
lineChartTableDataModel1.setResponseVariable(
   new com.sas.graphics.components.AnalysisVariable("AMOUNT"));
%>

<sas:LineChart id="bbuSASLineChart" model="lineChartTableDataModel1" 
   scope="session" >
</sas:LineChart>

Chapter 2.2.4 sas:LinePlot
<jsp:useBean id="linePlotTableDataModel1" scope="session" 
   class="com.sas.graphics.components.lineplot.LinePlotTableDataModel">
   <jsp:setProperty name="linePlotTableDataModel1" property="model" 
      value="<%=jdbcTableModelAdaptor%>" /> 
</jsp:useBean>

<%
linePlotTableDataModel1.setXVariable(
   new com.sas.graphics.components.PlotVariable("IDNAME"));
linePlotTableDataModel1.setYVariable(
   new com.sas.graphics.components.PlotVariable("POPDEN"));
%>

<sas:LinePlot id="bbuSASLinePlot" model="linePlotTableDataModel1" 
   scope="session" >
</sas:LinePlot>

Chapter 2.2.5 sas:PieChart
<jsp:useBean id="pieChartTableDataModel1" scope="session" 
   class="com.sas.graphics.components.piechart.PieChartTableDataModel">
   <jsp:setProperty name="pieChartTableDataModel1" property="model" 
      value="<%=jdbcTableModelAdaptor%>" /> 
</jsp:useBean>

<%
pieChartTableDataModel1.setCategoryVariable(
   new com.sas.graphics.components.ClassificationVariable("COUNTRY"));
pieChartTableDataModel1.setResponseVariable(
   new com.sas.graphics.components.AnalysisVariable("AMOUNT"));
%>

<sas:PieChart id="bbuSASPieChart" model="pieChartTableDataModel1" 
   scope="session" >
</sas:PieChart>

Chapter 2.2.6 sas:RadarChart
<jsp:useBean id="radarChartTableDataModel1" scope="session" 
   class="com.sas.graphics.components.radarchart.
   RadarChartTableDataModel">
   <jsp:setProperty name="radarChartTableDataModel1" property="model" 
      value="<%=jdbcTableModelAdaptor%>" /> 
</jsp:useBean>

<%
radarChartTableDataModel1.setCategoryVariable(
   new com.sas.graphics.components.ClassificationVariable("COUNTRY"));
radarChartTableDataModel1.setResponseVariable(
   new com.sas.graphics.components.AnalysisVariable("AMOUNT"));
%>

<sas:RadarChart id="bbuSASRadarChart" model="radarChartTableDataModel1" 
   scope="session" >
</sas:RadarChart>

Chapter 2.2.7 sas:ScatterPlot
<jsp:useBean id="scatterPlotTableDataModel1" scope="session" 
   class="com.sas.graphics.components.scatterplot.
   ScatterPlotTableDataModel">
   <jsp:setProperty name="scatterPlotTableDataModel1" property="model" 
      value="<%=jdbcTableModelAdaptor%>" /> 
</jsp:useBean>

<%
scatterPlotTableDataModel1.setXVariable(
   new com.sas.graphics.components.PlotVariable("IDNAME"));
scatterPlotTableDataModel1.setYVariable(
   new com.sas.graphics.components.PlotVariable("POPDEN"));
%>

<sas:ScatterPlot id="bbuSASScatterPlot" 
   model="scatterPlotTableDataModel1" scope="session">
</sas:ScatterPlot>


***Selected Sample Code used in Chapter 2 ;
Chapter 2.3 Common Attributes - alignment (page 25)

<%@taglib uri="http://www.sas.com/taglib/sas" prefix="sas"%>

<!--  JDBC Properties -->
<jsp:useBean id="jdbcProperties" scope="session"
	class="java.util.Properties" />
<%
jdbcProperties.setProperty("librefs", "samples 'c:/projects/BBU/data';" );
jdbcProperties.setProperty( "username", "sasdemo" );
jdbcProperties.setProperty( "password", "SAS1demo" );
%>

<jsp:useBean id="jdbcConn" scope="session"
	class="com.sas.storage.jdbc.JDBCConnection" >
	<jsp:setProperty name="jdbcConn" property="databaseURL"
		value="jdbc:sasiom://localhost:8591" />
	<jsp:setProperty name="jdbcConn" property="connectionInfo" 
		value="<%=jdbcProperties%>" />
	<jsp:setProperty name="jdbcConn" property="driverName" 
		value="com.sas.rio.MVADriver" />
</jsp:useBean>

<!-- JDBC to Table Model Adapter -->
<jsp:useBean id="tma1"  scope="session"
	class="com.sas.storage.jdbc.JDBCToTableModelAdapter"> 
	<jsp:setProperty name="tma1" property="queryStatement" value="select * from samples.grains"/> 
	<jsp:setProperty name="tma1" property="connection" value="<%=jdbcConn%>" /> 
</jsp:useBean>

<!-- Table Data Models -->
<jsp:useBean id="barChartTDM1" scope="session"
	class="com.sas.graphics.components.barchart.BarChartTableDataModel">
	<jsp:setProperty name="barChartTDM1" property="model" value="<%=tma1%>" />
</jsp:useBean>

<%
	barChartTDM1.setCategoryVariable(
	     new com.sas.graphics.components.ClassificationVariable("COUNTRY"));
	barChartTDM1.setResponseVariable(
	     new com.sas.graphics.components.AnalysisVariable("AMOUNT"));
%>

<html>
<body>

<table width="100%" border="1">
<tr><td>
<sas:BarChart id="bbuSASBarChart" model="barChartTDM1" scope="session" 
	alignment="RIGHT" >
</sas:BarChart>
</td></tr>
</table>

</body>
</html>



***Selected Sample Code used in Chapter 3 ;
Chapter 3.3 LineChartModel - fillAreaEnabled (page 65)

<%@taglib uri="http://www.sas.com/taglib/sas" prefix="sas"%>

<!--  JDBC Properties -->
<jsp:useBean id="jdbcProperties" scope="session"
	class="java.util.Properties" />
<%
jdbcProperties.setProperty("librefs", "samples 'c:/projects/BBU/data';" );
jdbcProperties.setProperty( "username", "sasdemo" );
jdbcProperties.setProperty( "password", "SAS1demo" );
%>

<!-- Establish the connection -->
<jsp:useBean id="jdbcConn" scope="session"
	class="com.sas.storage.jdbc.JDBCConnection" >
	<jsp:setProperty name="jdbcConn" property="databaseURL"
		value="jdbc:sasiom://localhost:8591" />
	<jsp:setProperty name="jdbcConn" property="connectionInfo" 
		value="<%=jdbcProperties%>" />
	<jsp:setProperty name="jdbcConn" property="driverName" 
		value="com.sas.rio.MVADriver" />
</jsp:useBean>

<!-- Table Model Adapters -->
<% 
com.sas.storage.jdbc.JDBCConnection jdbcConn =
	(com.sas.storage.jdbc.JDBCConnection)
	session.getAttribute("jdbcConn");
%>
<jsp:useBean id="jdbcTMAGrains"  scope="session"
	class="com.sas.storage.jdbc.JDBCToTableModelAdapter"> 
	<jsp:setProperty name="jdbcTMAGrains" property="queryStatement" 
		value="select * from samples.grains"/> 
	<jsp:setProperty name="jdbcTMAGrains" property="connection" 
		value="<%=jdbcConn%>" /> 
</jsp:useBean>

<% 
com.sas.storage.jdbc.JDBCToTableModelAdapter jdbcTMAGrains =
	(com.sas.storage.jdbc.JDBCToTableModelAdapter)
	session.getAttribute("jdbcTMAGrains"); 
%>

<!-- Table Data Model -->
<jsp:useBean id="lcTDMGrains2" scope="session" 
	class="com.sas.graphics.components.linechart.LineChartTableDataModel">
	<jsp:setProperty name="lcTDMGrains2" property="model" 
		value="<%=jdbcTMAGrains%>" /> 
</jsp:useBean>

<%
	lcTDMGrains2.setCategoryVariable(
	     new com.sas.graphics.components.ClassificationVariable("COUNTRY"));
	lcTDMGrains2.setResponseVariable(
	     new com.sas.graphics.components.AnalysisVariable("AMOUNT"));
%>

<html>
<body>

<sas:LineChart id="fillAreaEnabled_SASLineChart1" model="lcTDMGrains2" 
	scope="session" >
	<sas:LineChartModel fillAreaEnabled="True">
	</sas:LineChartModel>
</sas:LineChart>

</body>
</html>


***Selected Sample Code used in Chapter 4 ;
Chapter 4.4 Text Style Tags - various attributes (page 116)

<%@taglib uri="http://www.sas.com/taglib/sas" prefix="sas"%>

<!--  JDBC Properties -->
<jsp:useBean id="jdbcProperties" scope="session"
	class="java.util.Properties" />
<%
jdbcProperties.setProperty("librefs", "samples 'c:/projects/BBU/data';" );
jdbcProperties.setProperty( "username", "sasdemo" );
jdbcProperties.setProperty( "password", "SAS1demo" );
%>

<!-- Establish the connection -->
<jsp:useBean id="jdbcConn" scope="session"
	class="com.sas.storage.jdbc.JDBCConnection" >
	<jsp:setProperty name="jdbcConn" property="databaseURL"
		value="jdbc:sasiom://localhost:8591" />
	<jsp:setProperty name="jdbcConn" property="connectionInfo" 
		value="<%=jdbcProperties%>" />
	<jsp:setProperty name="jdbcConn" property="driverName" 
		value="com.sas.rio.MVADriver" />
</jsp:useBean>

<!-- Table Model Adapters -->
<% 
com.sas.storage.jdbc.JDBCConnection jdbcConn =
	(com.sas.storage.jdbc.JDBCConnection)
	session.getAttribute("jdbcConn");
%>

<jsp:useBean id="jdbcTMAPopData"  scope="session"
	class="com.sas.storage.jdbc.JDBCToTableModelAdapter"> 
	<jsp:setProperty name="jdbcTMAPopData" property="queryStatement" 
		value="select * from samples.popdata"/> 
	<jsp:setProperty name="jdbcTMAPopData" property="connection" 
		value="<%=jdbcConn%>" /> 
</jsp:useBean>

<% 
com.sas.storage.jdbc.JDBCToTableModelAdapter jdbcTMAPopData =
	(com.sas.storage.jdbc.JDBCToTableModelAdapter)
	session.getAttribute("jdbcTMAPopData");
%>

<!-- Table Data Model -->
<jsp:useBean id="lpTDMPopData" scope="session" 
	class="com.sas.graphics.components.lineplot.LinePlotTableDataModel">
	<jsp:setProperty name="lpTDMPopData" property="model" 
		value="<%=jdbcTMAPopData%>" /> 
</jsp:useBean>

<%
	lpTDMPopData.setXVariable(
	     new com.sas.graphics.components.PlotVariable("IDNAME"));
	lpTDMPopData.setYVariable(
	     new com.sas.graphics.components.PlotVariable("POPDEN"));
%>
<html>
<body>

<sas:LinePlot id="bottomMarkerLabelTextStyleAttributes" 
  model="lpTDMPopData" scope="session" >
  <sas:LinePlotModel bottomMarkerLabelContent="X" >
    <sas:BottomMarkerLabelTextStyle baselineAngle="50.0"
      color="red" justification="right" visible="true" />
  </sas:LinePlotModel>
</sas:LinePlot>

</body>
</html>



***Selected Sample Code used in Chapter 5 ;
Chapter 5.1 Fill Tags - fillType (page 127)

<%@taglib uri="http://www.sas.com/taglib/sas" prefix="sas"%>

<!--  JDBC Properties -->
<jsp:useBean id="jdbcProperties" scope="session"
	class="java.util.Properties" />
<%
jdbcProperties.setProperty("librefs", "samples 'c:/projects/BBU/data';" );
jdbcProperties.setProperty( "username", "sasdemo" );
jdbcProperties.setProperty( "password", "SAS1demo" );
%>

<!-- Establish the connection -->
<jsp:useBean id="jdbcConn" scope="session"
	class="com.sas.storage.jdbc.JDBCConnection" >
	<jsp:setProperty name="jdbcConn" property="databaseURL"
		value="jdbc:sasiom://localhost:8591" />
	<jsp:setProperty name="jdbcConn" property="connectionInfo" 
		value="<%=jdbcProperties%>" />
	<jsp:setProperty name="jdbcConn" property="driverName" 
		value="com.sas.rio.MVADriver" />
</jsp:useBean>

<!-- Table Model Adapters -->
<% 
com.sas.storage.jdbc.JDBCConnection jdbcConn =
	(com.sas.storage.jdbc.JDBCConnection)
	session.getAttribute("jdbcConn");
%>
<jsp:useBean id="jdbcTMAGrains"  scope="session"
	class="com.sas.storage.jdbc.JDBCToTableModelAdapter"> 
	<jsp:setProperty name="jdbcTMAGrains" property="queryStatement" 
		value="select * from samples.grains"/> 
	<jsp:setProperty name="jdbcTMAGrains" property="connection" 
		value="<%=jdbcConn%>" /> 
</jsp:useBean>

<% 
com.sas.storage.jdbc.JDBCToTableModelAdapter jdbcTMAGrains =
	(com.sas.storage.jdbc.JDBCToTableModelAdapter)
	session.getAttribute("jdbcTMAGrains"); 
%>

<!-- Table Data Model -->
<jsp:useBean id="bcTDMGrains2" scope="session" 
	class="com.sas.graphics.components.barchart.BarChartTableDataModel">
	<jsp:setProperty name="bcTDMGrains2" property="model" 
		value="<%=jdbcTMAGrains%>" /> 
</jsp:useBean>

<%
	bcTDMGrains2.setCategoryVariable(
	     new com.sas.graphics.components.ClassificationVariable("COUNTRY"));
	bcTDMGrains2.setResponseVariable(
	     new com.sas.graphics.components.AnalysisVariable("AMOUNT"));
%>

<html>
<body>
<% /* 
[fillType="SolidColor|Gradient|Image|
ImageColorBlend|ImageGradientBlend"] 

[gradientFill="LeftToRight|BottomToTop|
FrontToBack|DiagonalUp|DiagonalDown"]
*/ %>
<sas:BarChart id="gradientFill" 
	model="bcTDMGrains2" scope="session">
	<sas:BarChartModel>
			<sas:BackgroundFillStyle fillType="Gradient"
				gradientFillBeginColor="red" 
				gradientFillEndColor="yellow" 
				gradientFill="DiagonalDown"/>
	</sas:BarChartModel>
</sas:BarChart>

</body>
</html>



***Sample Code used in Chapter 6 ;
Chapter 6.2 General JSP Structure
<%@taglib uri="http://www.sas.com/taglib/sasads" prefix="sasads"%>

<%@ page import = "com.sas.servlet.util.SocketListener" %>
<%@ page import = "com.sas.servlet.util.Util" %>
<%@ page import = "com.sas.rmi.Connection" %>

<sasads:Connection id="bbuConnection" scope="session" />

<html>
<body>

<%
SocketListener socket = new SocketListener();
int port = socket.setup();
String host = (java.net.InetAddress.getLocalHost()).getHostAddress();
String archivePath="../assets/graph/";
String libraryPath = "c:\\Projects\\BBU\\data";

socket.start();
%>
<sasads:Submit id="smbStreamingBar" display="none" connection="bbuConnection">
libname samples '<%=libraryPath%>';

filename sock SOCKET '<%=host%>:<%=port%>';

goptions reset=all device=java xpixels=600 ypixels=400;

ods listing close;

ODS HTML body=sock rs=none CODEBASE="<%=archivePath%>" ;

proc gchart data=samples.grains;
    hbar country / sumvar=amount;
run; 
quit;

ods html close;
</sasads:Submit>

<%
socket.write(out);
socket.close();
%>

</body>
</html>



***Sample Code used in Chapter 7 ;
Chapter 7.1 Types of Bar Charts
proc gchart data=samples.grains;
   hbar country / sumvar=amount;
run;
proc gchart data=samples.grains;
   hbar3d country / sumvar=amount;
run;
proc gchart data=samples.grains;
   vbar country / sumvar=amount;
run; 

Chapter 7.2 Types of Pie Charts
proc gchart data=samples.grains;
   pie country / sumvar=amount;
run;
proc gchart data=samples.grains;
   pie country / sumvar=amount;
run; 
proc gchart data=samples.grains;
   pie3d country / sumvar=amount;
run; 

Chapter 7.2.2 Donut Charts
proc gchart data=samples.grains;
   donut country / sumvar=amount;
run; 

Chapter 7.2.3 Star Charts
proc gchart data=samples.grains; 
   star country / sumvar=amount;
run;

Chapter 7.3 Contour Plots
proc gcontour data=work.clay; 
   plot y*x=pct_clay / levels=10 to 90 by 5 ; 
run;

Chapter 7.4 Types of Maps
proc gmap map=maps.us data=samples.rgnsites;
   id state;
   block sites;
run;
proc gmap map=maps.us data=samples.rgnsites;
   id state;
   choro sites;
run;
proc gmap map=maps.us data=samples.rgnsites; 
   id state; 
   prism sites; 
run;
proc gmap map=maps.us data=samples.rgnsites; 
   id state; 
   surface sites; 
run;

Chapter 7.5 Types of Plots
proc sql;
   create table work.energyPrice as
   select year as year, consumed as energy, 
      consumed*.03 as dollars, consumed*.03*125 as yen
   from samples.energy1;
quit;
proc gplot data=work.energyPrice;
   bubble dollars*year=energy;
run;
proc gplot data=work.energyPrice; 
   bubble dollars*year=energy;
   bubble2 yen*year=energy;
run;
proc gplot data=work.energyPrice;
   plot dollars*year;
run;
proc gplot data=work.energyPrice; 
   plot dollars*year;
   plot2 yen*year;
run;

Chapter 7.6 Three-Dimensional Graphs
proc g3d data=samples.giris;
   scatter petallen*petalwid=sepallen; 
run;
proc g3d data=samples.hat;
   plot y*x=z;
run;



***Selected Sample Code used in Chapter 8 ;
Chapter 8.1 ODS Parameters - GRADIENTBACKGROUND (page 176)

<%@taglib uri="http://www.sas.com/taglib/sasads" prefix="sasads"%>

<%@ page import = "com.sas.servlet.util.SocketListener" %>
<%@ page import = "com.sas.servlet.util.Util" %>
<%@ page import = "com.sas.rmi.Connection" %>

<sasads:Connection id="bbuConnection" scope="session" />

<html>
<body>

<%
SocketListener socket = new SocketListener();
int port = socket.setup();
String host = (java.net.InetAddress.getLocalHost()).getHostAddress();
String archivePath="../assets/graph/";
String libraryPath = "c:\\Projects\\BBU\\data";

socket.start();
%>
<sasads:Submit id="smbStreamingBar" display="none" connection="bbuConnection">
libname samples '<%=libraryPath%>';
	
filename sock SOCKET '<%=host%>:<%=port%>';

goptions reset=all device=java xpixels=600 ypixels=400;

ods listing;
ods html close;

ODS HTML body=sock rs=none CODEBASE="<%=archivePath%>"
    parameters=("gradientbackground"="vertical"
                "gradientstartcolor"="red"
                "gradientendcolor"="yellow");

proc gmap map=maps.us data=samples.rgnsites; 
    id state; 
    prism sites; 
run;
quit;

ods html close;
ods listing;
</sasads:Submit>

<%
socket.write(out);
socket.close();
%>

</body>
</html>



***Selected Sample Code used in Chapter 9 ;
Chapter 9.2 GOPTIONS - FTITLE (page 215)

<%@taglib uri="http://www.sas.com/taglib/sasads" prefix="sasads"%>

<%@ page import = "com.sas.servlet.util.SocketListener" %>
<%@ page import = "com.sas.servlet.util.Util" %>
<%@ page import = "com.sas.rmi.Connection" %>

<sasads:Connection id="bbuConnection" scope="session" />

<html>
<body>

<%
SocketListener socket = new SocketListener();
int port = socket.setup();
String host = (java.net.InetAddress.getLocalHost()).getHostAddress();
String archivePath="../assets/graph/";
String libraryPath = "c:\\Projects\\BBU\\data";

socket.start();
%>
<sasads:Submit id="smbStreamingBar" display="none" connection="bbuConnection">
libname samples '<%=libraryPath%>';

filename sock SOCKET '<%=host%>:<%=port%>';

goptions reset=all device=java xpixels=600 ypixels=400 
    ftitle=courier;
	
ods listing;
ods html close;

ODS HTML body=sock rs=none CODEBASE="<%=archivePath%>";
ODS USEGOPT;

title1 "Proc GChart - Courier Title";

proc gchart data=samples.grains;
    hbar3d country / sumvar=amount;
run;
quit;

ods html close;
ods listing;
</sasads:Submit>

<%
socket.write(out);
socket.close();
%>

</body>
</html>


***Selected Sample Code used in Chapter 10 ;
Chapter 10.1 PROC GCHART - AXIS/RAXIS (page 244)

<%@taglib uri="http://www.sas.com/taglib/sasads" prefix="sasads"%>

<%@ page import = "com.sas.servlet.util.SocketListener" %>
<%@ page import = "com.sas.servlet.util.Util" %>
<%@ page import = "com.sas.rmi.Connection" %>

<sasads:Connection id="bbuConnection" scope="session" />

<html>
<body>

<%
SocketListener socket = new SocketListener();
int port = socket.setup();
String host = (java.net.InetAddress.getLocalHost()).getHostAddress();
String archivePath="../../assets/graph/";
String libraryPath = "c:\\Projects\\BBU\\data";

socket.start();
%>
<sasads:Submit id="smbStreamingBar" display="none" connection="bbuConnection">
libname samples '<%=libraryPath%>';

filename sock SOCKET '<%=host%>:<%=port%>';

goptions reset=all device=java xpixels=600 ypixels=400;

ods listing close;

ODS HTML body=sock rs=none CODEBASE="<%=archivePath%>";

axis1 color=red;
                     
proc gchart data=samples.grains;
    vbar3d country / 
       sumvar=amount
       axis=axis1;
run;
quit;

ods html close;
</sasads:Submit>

<%
socket.write(out);
socket.close();
%>

</body>
</html>




***Programs used in "SAS Graphics for Java" ;
Chapter 11.1   Report 1: Using SAS AppDev Studio 3 Tags

<%@taglib uri="http://www.sas.com/taglib/sas" prefix="sas"%>

<%
java.util.Properties  jdbcProperties = new java.util.Properties();
jdbcProperties.setProperty("librefs", "samples 'c:/projects/BBU/data';" );
jdbcProperties.setProperty( "username", "sasdemo" );
jdbcProperties.setProperty( "password", "SAS1demo" );
session.setAttribute( "jdbcProperties", jdbcProperties );
%>

<sas:JDBCConnection id="jdbcConn"
   databaseURL="jdbc:sasiom://localhost:8591"
   connectionInfo="jdbcProperties"
   driverName="com.sas.rio.MVADriver"
   scope="session" />

<jsp:useBean id="jdbcTableModelAdaptor"  scope="session"
   class="com.sas.storage.jdbc.JDBCToTableModelAdapter"> 
   <jsp:setProperty name="jdbcTableModelAdaptor" 
      property="queryStatement" 
      value="select * from samples.eprdcon2 where cptype='p'"/> 
   <jsp:setProperty name="jdbcTableModelAdaptor" 
		property="connection" value="<%=jdbcConn%>" /> 
</jsp:useBean>

<jsp:useBean id="report1_TableDataModel" scope="session" 
	class="com.sas.graphics.components.piechart.PieChartTableDataModel">
	<jsp:setProperty name="report1_TableDataModel" 
		property="model" value="<%=jdbcTableModelAdaptor%>" /> 
</jsp:useBean>

<%
	report1_TableDataModel.setCategoryVariable(
		new com.sas.graphics.components.ClassificationVariable("ENGYTYPE"));
	report1_TableDataModel.setResponseVariable(
		new com.sas.graphics.components.AnalysisVariable("AMOUNT"));
	report1_TableDataModel.setSubgroupVariable(
		new com.sas.graphics.components.ClassificationVariable("YEAR"));
%>

<html>
<body>

<h1 align="center" style="font-family: Century Gothic">
  Energy Production 1985- 1988</h1>
  
<table width="100%">
<tr><td align="center">
<sas:PieChart id="report1Pie" model="report1_TableDataModel" 
  scope="session" appliedGraphStyleName="gears"
  height="500" width="500">
  <sas:PieChartModel responseLabelVisiblePolicy="false">
    <sas:SubgroupLabelModel>
      <sas:ValueTextStyle justification="right">
        <sas:Font bold="true"/>
      </sas:ValueTextStyle>
      <sas:LabelTextStyle color="black">
        <sas:Font bold="true" />
      </sas:LabelTextStyle>
    </sas:SubgroupLabelModel>
    <sas:LegendModel label="Energy Type">
      <sas:ValueTextStyle>
        <sas:Font bold="true"/>
      </sas:ValueTextStyle>
      <sas:LabelTextStyle color="black">
        <sas:Font bold="true" />
      </sas:LabelTextStyle>
    </sas:LegendModel>
  </sas:PieChartModel>
</sas:PieChart>
</td></tr>
</table>

</body>
</html>


***Programs used in "SAS Graphics for Java" ;
Chapter 11.2   Report 2: Using ODS

<%@taglib uri="http://www.sas.com/taglib/sasads" prefix="sasads"%>

<%@ page import = "com.sas.servlet.util.SocketListener" %>
<%@ page import = "com.sas.servlet.util.Util" %>
<%@ page import = "com.sas.rmi.Connection" %>

<sasads:Connection id="bbuConnection" scope="session" />

<html>
<body>
<%
SocketListener socket = new SocketListener();
int port = socket.setup();
String host = (java.net.InetAddress.getLocalHost()).getHostAddress();
String archivePath="../../assets/graph/";
String libraryPath = "c:\\Projects\\BBU\\data";

socket.start();
%>
<sasads:Submit id="smbStreamingBar" display="none" 
  connection="bbuConnection">
libname samples '<%=libraryPath%>';
	
filename sock SOCKET '<%=host%>:<%=port%>';

goptions reset=all device=java xpixels=600 ypixels=400;

ods listing close;

ODS HTML body=sock rs=none CODEBASE="<%=archivePath%>"
    parameters=("colorscheme"="fall") style=beige;

legend1 label=('Energy Type');
title1 'Energy Production 1985 - 1988';

proc gchart data=samples.eprdcon2;
    pie engytype / 
      sumvar=amount
      detail=year
      legend=legend1
    ;
run;

ods html close;
</sasads:Submit>

<%
socket.write(out);
socket.close();
%>

</body>
</html>


**WORK Data Sets" ;
Appendix A   Work Data Sets

work.clay
data work.clay;
   set samples.clay;
   where x ge -10 and x le -4 and y ge -10 and y le 2;
run;



proc sql;
create table work.energyPrice as
    select year as year, consumed as energy, consumed*.03 as dollars, 
        consumed*.03*125 as yen
    from samples.energy1;
quit;


