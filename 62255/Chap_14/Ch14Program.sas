Example 14.1  Hello World Servlet

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Date;

public class HelloWorld extends HttpServlet {
 
public void doGet (HttpServletRequest request,
HttpServletResponse response)
throws ServletException, IOException {
String title = “Simple Servlet Output”;
Date now = new Date(); // The current date/time
response.setContentType(“text/html”);
String name = request.getParameter(“name”);
if (name == null) name = “World”;
PrintWriter out = response.getWriter();
out.println(“<html>\n<head>\n<title>“);
out.println(title);
out.println(“</title>\n</head>\n<body>“);
out.println(“<h1 style=\”color: blue;\”>“ + 
title + “</h1>“);
out.println(“<p>Hello “+name+”!</p>“);
out.println(“<p>The current system time is “+
now+”</p>“);
out.println(“</body>\n</html>“);
out.close();
}
public void doPost (HttpServletRequest request,
HttpServletResponse response)
throws ServletException, IOException {
doGet(request, response);
}
}
Example 14.2  Servlet Configuration File web.xml

<?xml version="1.0" encoding="ISO-8859-1"?>
<web-app xmlns="http://java.sun.com/xml/ns/j2ee" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee 
    	http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd" version="2.4">

<display-name>Hello World Servlet</display-name>

<servlet>
<servlet-name>HelloWorld</servlet-name>
<servlet-class>HelloWorld</servlet-class>
</servlet>

<servlet-mapping>
<servlet-name>HelloWorld</servlet-name>
<url-pattern>/hello</url-pattern>
</servlet-mapping>
</web-app>

Example 14.3  Simple JSP Example

<!DOCTYPE html PUBLIC “-//W3C//DTD XHTML 1.0 Transitional//EN”
“http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd”>
<html xmlns=“http://www.w3.org/1999/xhtml”>
<head>
<title>JSP Examples</title>
<style type=“text/css”>
h1   { color: blue; }        
body { font-family: helvetica, arial; }
</style>
</head>
<body>
<h1>Simple JavaServer Page</h1>
<% out.print(“Hello World!”); %>
The time now is <%= new java.util.Date() %>
</body>
</html>

Example 14.4  Custom Tag Handler

package tags;
import java.util.Date;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;

public class SimpleTag extends TagSupport {

public int doStartTag() throws JspException {
try {
pageContext.getOut().print
(“Hello World.” + “The time now is “ +
new Date());
}
catch (Exception ex) {
throw new JspTagException
(“SimpleTag: “ + ex.getMessage());
}

return SKIP_BODY;
}

public int doEndTag(){
return EVAL_PAGE;
}
}
 
Example 14.5  Tag Library Description

<?xml version=“1.0”?>
<!DOCTYPE taglib PUBLIC
 “-//Sun Microsystems, Inc.//DTD JSP Tag Library 1.2//EN”
 “http://java.sun.com/dtd/web-jsptaglibrary_1_2.dtd” >
<taglib>
<tlib-version>1.0</tlib-version>
<jsp-version>1.2</jsp-version>
<short-name>Sample tag library</short-name>
<description>Library for simple tag example</description>
    
<tag>
<name>SayHello</name>
<tag-class>tags.SimpleTag</tag-class>
<description>Hello world example</description>
</tag>
</taglib>

Example 14.6  JSP Using Custom Tags

<!DOCTYPE html PUBLIC “-//W3C//DTD XHTML 1.0 Transitional//EN”
 “http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd”>
<html xmlns=“http://www.w3.org/1999/xhtml”>
<%@ taglib URL=“simple.tld” prefix=“test” %>
<head>
<title>JSP Examples - Custom Tag Library</title>
<style type=“text/css”>
h1   { color: blue; }        
body { font-family: helvetica, arial; }
</style>
</head>
<body>
<h1>JavaServer Page Custom Tag Example</h2>	
<test:SayHello />
</body>
</html>
 
Example 14.7  The Basic JavaBean

package beans;

public class UserProfile {
 
private String firstName, lastName, 
streetAddress, city, state;
private int zip;

public void setFirstName(String firstName) {
this.firstName = firstName;
}
public String getFirstName() {
return firstName;
}
public void setLastName(String lastName) {
this.lastName = lastName;
}
public String getLastName() {
return lastName;
}
public void setStreetAddress(String streetAddress) {
this.streetAddress = streetAddress;
}
public String getStreetAddress() {
return streetAddress;
}
public void setCity(String city) {
this.city = city;
}
public String getCity() {
return city;
}
public void setState(String state) {
this.state = state;
}
public String getState() {
return state;
}
public void setZip(int zip) {
this.zip = zip;
}
public int getZip() {
/* add a try-catch block here 		*/
/* to test whether the value is numeric  */
return zip;
}
}

 
Example 14.8  Simple Data Entry Form in XHTML

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Use Beans with EL</title>
<link href="styles.css" type="text/css" rel="stylesheet" />
  
<body>
<h1>Java Server Page Examples: Beans</h1>
<h2>Enter User Profile</h2>
<form method="GET" action="request_profile.jsp">
<table class="center"> 
<tr>
<th>First name:</th>
<td><input type="text" name="firstName" size="20" /></td>
</tr>
<tr>
<th>Last Name:</th>
<td><input type="text" name="lastName" size="20" /></td>
</tr>
<tr>
<th>Address:</th>
<td><input type="text" name="streetAddress" size="20" /></td>
</tr>
<tr>
<th>City:</th>
<td><input type="text" name="city" size="20" /></td>
</tr>
<tr>
<th>State:</th>
<td><input type="text" name="state" size="20" /></td>
</tr>
<tr>
<th>Zip:</th>
<td><input type="text" name="zip" size="20" /></td>
</tr>
</table>
<p class="center"><input type="submit" value="Submit" /></p> 
</form>
</body>
</html>

Example 14.9  Store JavaBean in Request Scope

<jsp:useBean id="profile" class="beans.UserProfile" scope="request">
<jsp:setProperty name="profile" property="*"/>
</jsp:useBean>

<jsp:forward page="UserProfile.jsp" />
 
Example 14.10  Get Stored Values from JavaBean

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ taglib uri=' http://www.oracle.com/technetwork/java/index-jsp-135995.html ' prefix='c' %>
<html>
<head>
<title>Accessing Beans with the EL</title>
<link href="styles.css" type="text/css" rel="stylesheet" />
</head>
<body>
<%-- Show profile information --%>
<h1>Profile for
<c:out value='${profile.firstName}' />
<c:out value='${profile.lastName}' />
</h1>
<table class="center">
<tr>
<th>Street Address:</th>
<td><c:out value='${profile.streetAddress}' /> </td>
</tr>
<tr>
<th>City:</th>
<td><c:out value='${profile.city}' /> </td>
</tr>
<tr>
<th>State:</th>
<td><c:out value='${profile.state}' /> </td>
</tr>
<tr>
<th>Zip Code:</th>
<td> <c:out value='${profile.zip}' /> </td>
</tr>
</table>
</body>
</html>
 
Example 14.11  Console JDBC Example

import java.sql.*;

/* connection test to a remote server using JDBC */
public class JDBCTest
{
public static void main(String[] args)
{
Connection con = null;

try 
{
// open connection to database
Class.forName(“com.sas.rio.MVADriver”);
String user = “sas”;
String password =
 “{sas002}ACFD2406354EB53359FB76435B5FB53C”;
con = DriverManager.getConnection(
“jdbc:sasiom://loki:8591”, user, password);

// print connection information
DatabaseMetaData dma = con.getMetaData();
System.out.println(
“Connected to “ + dma.getURL());
System.out.println(
“Driver “ + dma.getDriverName());
}
catch(Exception e) { System.err.println(e); }
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
 
Example 14.12  Using JDBC with JSTL Custom Tags

<%@ taglib prefix=“c” uri=“http://java.sun.com/jsp/jstl/core” %>
<%@ taglib prefix=“sql” uri=“http://java.sun.com/jsp/jstl/sql” %>
<html>
<head>
<title>JSP Examples - JDBC</title>
<meta http-equiv=“Content-Type” content=“text/html; charset=utf-8” />
<link href=“styles.css” type=“text/css” rel=“stylesheet” />
</head>
<body>
<h1>SAS IOM JDBC Driver</h1>
<h2>Using Java Standard Tag Library</h2>
<table border=“1” align=“center”>        
<%-- open a database connection --%>
<sql:setDataSource
var=“datasource”
driver=“com.sas.rio.MVADriver”
url=“jdbc:sasiom://localhost:8591” user=“sas”
password=“{sas002}ACFD2406354EB53359FB76435B5FB53C”
/>
<%-- execute the database query --%>      
<sql:query var=“table” dataSource=“${datasource}” >
select * from sashelp.class where sex='M'
</sql:query>
             
<%-- Get the column names for the header of the table --%>
<c:forEach var=“columnName” items=“${table.columnNames}”>
<th><c:out value=“${columnName}”/></th>
</c:forEach>

<%-- Get value of each column by iterating over rows --%>
<c:forEach var=“row” items=“${table.rowsByIndex}”>
<tr>
<c:forEach var=“column” items=“${row}”>
<td><c:out value=“${column}”/></td>
</c:forEach>
</tr>
</c:forEach>
</table>
</body>
</html>
 
Example 14.13  HTML Data Entry Form

<html>
<head>
<title>JSP Examples: JSTL Demo</title>
<link href="styles.css" type="text/css" rel="stylesheet" />
<style>
input { position: absolute; left: 120px }
</style>
</head>
<body>
<h1>Demo Entry Form</h1>
<form method="get"
action="update.jsp">
<p><strong>Name:</strong>
<input type="text" name="name" size="12"/></p>
<p><strong>Gender:</strong>
<blockquote>
<input type="radio" name="sex" value="M"/>Male<br />
<input type="radio" name="sex" value="F"/> Female
</blockquote>
<p><strong>Age:</strong>
<input type="text" name="age" size="4"/></p>
<p><strong>Height:</strong>
<input type="text" name="height" size="4"/></p>
<p><strong>Weight:</strong>
<input type="text" name="weight" size="4"/></p>
<p><input type="submit" value="Submit"/></p>
</form>
<body>
</html>

Example 14.14  Updating a Database with JSTL and JDBC

<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%-- update data --%>
<%
/* SQL code to append parameters to CLASS table */
String strSQL="INSERT INTO data.class SET " +
"name=\""+request.getParameter("name")+"\","+
"sex=\""+request.getParameter("sex")+"\","+
"age="+request.getParameter("age")+","+
"height="+request.getParameter("height")+","+
"weight="+request.getParameter("weight");
%>

<sql:setDataSource
var="datasource"
driver="com.sas.rio.MVADriver"
url="jdbc:sasiom://loki:8591?” +
“librefs=data '/home/sas/Public’"
user="sas" 
password = "{sas002}ACFD2406354EB53359FB76435B5FB53C"/>
<sql:update dataSource="${datasource}">
<%=strSQL %>
</sql:update>

<jsp:forward page="JDBCTest.jsp" />
