Example 17.1  HTML for Online Registration Form

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html;
 charset=windows-1252" />
    <title>DHTML with AJAX and SAS</title>
    <script type="text/javascript" src="getCityState1.js">
    </script>
</head>
<body>
<h1>Sample On-line Registration Application Form</h1>
<h3>Enter registration information:</h3>
<form method="GET" action="">
<table>
	<tr>
		<th>First name:</th>
		<td><input type="text" name="firstName" size="40"></td>
	</tr>
	<tr>
		<th>Last name:</th>
		<td><input type="text" name="lastName" size="40"></td>
	</tr>
	<tr>
		<th>Address:</th>
		<td><input type="text" name="address1" size="40"></td>
	</tr>
	<tr>
		<th>&nbsp;</th>
		<td><input type="text" name="address2" size="40"></td>
	</tr>
	<tr>
		<th>Zip:</th>
		<td><input type="text" name="zipcode" size="10"></td>
	</tr>
	<tr>
           	<th>City:</th>
           	<td id="cityState">
           		<input type="text name="city" size=”24”/>
           		<strong>State: </strong>
            		<input type="text" "state" size="2"/>
          	</td>
      </tr>
</table>
<p>
	<input type="submit" value="Submit">
	<input type="reset" value="Reset">
</p> 
</form>
</body>
</html>

Example 17.2  SAS/IntrNet Code to Create HTML

/*
 *    getZipcode1.sas
 *
 *    create HTML table cell with city and state code
 *
 *    Parameter: zipcode
 */
data _null_;

    zip=&zipcode;
    set sashelp.zipcode key=zip;
    file _webout;

    /* if invalid zip display error message */
    if _iorc_ then do;
        put '<span style="color: red; font-weight: bold;">
            Zipcode ' zip 'not found!</span>';
        _error_=0;                
    end;
    else do;    
        /* check to see if there are any other city names */
        /* if so, create a list box, otherwise write text box */
        if (alias_city>" ") then do;
            put '<select name="city" style="width: 14em">'/
			'<option>' city '</option>';
            index=1;
            do while(index);
                city=scan(alias_city,index,"||");
                if (city>" ") then do;
                    put '<option>' city '</option>';
                    index+1;
                end;
                else index=0;
            end;
            put '</select>';
        end;
        else put '<input type="text" name="city" value="' city '"/>';

        /* add state code */
        put '<strong>State: </strong>’
		‘<input type="text" size="2" value="' statecode '"</>';
    end;
    
    stop; /* required with direct access to index variable */

run;

 
Example 17.3  JavaScript Functions: getXmlHttp

// define a global XML HTTP Request Object
var XHR;

// cross platform method to create XHR object
function getXmlHttp() {

// make sure there is only one instance (singleton pattern)
if (!XHR) {
if (window.XMLHttpRequest) {
XHR = new XMLHttpRequest();} else if (window.ActiveXObject) {
XHR = new ActiveXObject("Msxml2.XMLHTTP");
}
}
}


Example 17.4  JavaScript Functions: catchEvent

// cross platform method to register event handler
function catchEvent(eventObj, event, eventHandler) {

if (eventObj.addEventListener) {
eventObj.addEventListener(event, eventHandler,false);
} else if (eventObj.attachEvent) {
event = "on" + event;
eventObj.attachEvent(event, eventHandler);
}
}

// add listener to zipcode text box on page load
catchEvent(window,"load", function() {

document.getElementById('zip').onchange=sendZipcode;   
});


Example 17.5  JavaScript Functions: sendZipCode (SAS/IntrNet)

// prepare and send XHR request
function sendZipcode() {

var zipcode = document.getElementById("zip").value; 
var server = "http://"+window.location.hostname+"/scripts";
var url = server + "/broker.exe?_service=default&_debug=0&" +
"_program=pgmlib.getZipcode.sas&zipcode="+zipcode

getXmlHttp();
XHR.open('GET', url, true);
XHR.onreadystatechange = getCityState;
XHR.send(null);
}
 

Example 17.6  JavaScript Functions: getCityState

// process response
function getCityState() {

if(XHR.readyState == 4 && XHR.status == 200) {
         
// insert city and state values
var cell = document.getElementById("cityState");
cell.innerHTML = XHR.responseText; 
}
}


Example 17.7  SAS Stored Process to Create JSON Response
/*
 *    getZipcode.sas
 *
 *    create city and state data
 *
 *    Parameter: zipcode
 */
%global zipcode;
data _null_;

    zip=&zipcode;
    set sashelp.zipcode key=zip;
    file _webout;
    length outrec $1024;

    /* if invalid zip, response message is empty */
    if _iorc_ then do;
        _error_=0;    
        outrec="{}"; 
    end;
    else do;    
        outrec = '{ "location": [ {"city": "'||trim(city)|| '" }';        
        /* check to see if there are any other city names */
        if (alias_city>" ") then do;
            index=1;
            do while(index);
                city=scan(alias_city,index,"||");
                if (city>" ") then do;
                    outrec=trim(outrec)||', {"city": "'||
					trim(city)||'"}';
                    index+1;
                end;
                else index=0;
            end;
        end;
        /* add state code */
        outrec=trim(outrec)||' ] , "state": "'||statecode||'" }';
    end;
    put outrec;
    
    stop; /* required with direct access to index variable */

run;


Example 17.8  JavaScript Functions: sendZipCode (Stored Process)

// prepare and send XHR request
function sendZipcode() {

var zipcode = document.getElementById("zip").value; 
var server = "http://"+window.location.hostname+":8080";
var url = server + "/SASStoredProcess/do?" +
"_program=/Users/Frederick/My Folder/getZipcode&" +
"_username=frederick&_password=xxxxxx&zipcode="+zipcode

XHR = getXmlHttp();
XHR.open('GET', url, true);
XHR.onreadystatechange = getCityState;
XHR.send(null);
}


Example 17.9  JavaScript Functions: getCityState (JSON)

// process reponse
function getCityState() {

   if(XHR.readyState == 4 && XHR.status == 200) {
        
       // insert city and state values
       var response = JSON.parse(XHR.responseText); 
	if (response.location) {     
       
        if (response.location.length == 1) {
            strHTML = '<input name="city" type="text" value="' +
response.location[0].city + '" />';            
        }
        else {
           strHTML = '<select name="city" style="width: 14em">';
           for(var i=0; i<response.location.length; i++) {
               strHTML = strHTML+'<option>'+
response.location[i].city+
'</option>';        
           }
           strHTML = strHTML+"</select>";
       }
       
       strHTML= strHTML + ' <strong>State:</strong>'+
           '<input name="state" type="text" value="'+
response.state+'"</>';
    }
        else {
           strHTML = '<span style="color: red; ’+
               'font-weight: bold;">'+
               'Zipcode not found!’+
               '</span>';
        }
       
       var cell = document.getElementById("cityState");
       cell.innerHTML = strHTML;            
    }
}


Example 17.10  SAS Stored Process to Create SOAP Response
/*
 *    getZipcode.sas
 *
 *    create XML document with city and state codes
 *
 *    Parameter: zipcode
 */
%global zipcode;

data cityState (keep=city statecode);

    zip=&zipcode;
    set sashelp.zipcode key=zip;

    /* if invalid zip, response message is empty */
    if _iorc_ then do;
        _error_=0;    
		output;
    end;
    else do;    
		output;
        /* check to see if there are any other city names */
        if (alias_city>" ") then do;
            index=1;
            do while(index);
                city=scan(alias_city,index,"||");
                if (city>" ") then do;
               		output;
                    index+1;
                end;
                else index=0;
            end;
        end;
    end;
  
    stop; /* required with direct access to index variable */
run;

libname ostream XML92;
proc copy in=work out=ostream;                 
   select cityState;                              
run; 
libname ostream;

 
Example 17.11  SOAP Request

<soapenv:Envelope 
	xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
	xmlns:get="http://tempuri.org/getZipcode">
   <soapenv:Header/>
   <soapenv:Body>
      <get:getZipCodeXML>
         <get:parameters>
             <get:zipcode>97850</get:zipcode>
         </get:parameters>
      </get:getZipCodeXML>
   </soapenv:Body>
</soapenv:Envelope>


Example 17.12  SOAP Request

<m:getZipCodeXMLResponse
xmlns:m="http://tempuri.org/getZipcode">
<m:getZipCodeXMLResult>
<axis2ns4:Streams xmlns:axis2ns4="http://tempuri.org/getZipcode">
<axis2ns5:ostream xmlns:axis2ns5=http://tempuri.org/getZipcode
contentType="text/xml;charset=windows-1252">
<axis2ns6:Value xmlns:axis2ns6="http://tempuri.org/getZipcode">
<TABLE>
<CITYSTATE>
<CITY>La Grande</CITY>
<STATECODE>OR</STATECODE>
</CITYSTATE>
<CITYSTATE>
<CITY>Island City</CITY>
<STATECODE>OR</STATECODE>
</CITYSTATE>
</TABLE>
</axis2ns6:Value>
</axis2ns5:ostream>
</axis2ns4:Streams>
</m:getZipCodeXMLResult>
</m:getZipCodeXMLResponse>


Example 17.13  JavaScript Functions: getSOAP
// create SOAP message
function getSOAP(zip) {

var msg = '<soapenv:Envelope' + 
' xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"' + 
' xmlns:get="http://tempuri.org/getZipcode">' + 
'<soapenv:Header/>'+
'<soapenv:Body>'+
'<get:getZipcodeXML>'+
'<get:parameters>' + 
'<get:zipcode>'+zip+'</get:zipcode>'+
'</get:parameters>'+
'</get:getZipcodeXML>'+
'</soapenv:Body>'+
'</soapenv:Envelope>';
       
return msg;
}

Example 17.14  JavaScript Functions: sendZipcode (BI Web Services)

// create wrapper for message
function sendZipcode() {

var url = "http://odin:8080/SASBIWS/services/getZipcode";
var action = "http://tempuri.org/getZipcode/getZipcodeXML";
    
var zipcode = document.getElementById("zip").value; 
var xmlToSend = getSOAP(zipcode);    

// create and send the request    
getXmlHttp();
XHR.onreadystatechange = getCityState;
XHR.open("POST", url, false); 
XHR.setRequestHeader ("SOAPAction", action); 
XHR.setRequestHeader ("Content-Type", "text/xml"); 
XHR.send(xmlToSend); 
}


Example 17.15  JavaScript Functions: getCityState (BI Web Services)

// process response
function getCityState() {

   if(XHR.readyState == 4) {
       if (XHR.status == 200) {
        
           // get city and state values
           var xmlDoc=XHR.responseXML;  
           var strHTML = "";  
         
           // get value of city/cities
           var city = xmlDoc.getElementsByTagName("CITY");

		// check to see if the city element is empty 
           	if (city[0].firstChild!=null) {
               if (city.length==1) {
                   strHTML = '<input name="city" type="text" value="' +
                       city[0].firstChild.data+'"</>';
               }
               else {
                   strHTML = '<select name="city" style="width: 14em">';
                   for(var i=0; i<city.length; i++) {
                       strHTML = strHTML+'<option>'+
					     city[i].firstChild.data+'</option>';        
                   }
                   strHTML = strHTML+"</select>";
               }

               // get value of state
               var state = xmlDoc.getElementsByTagName("STATECODE");
               if (state[0].firstChild!=null) {
                   strHTML= strHTML + '<strong>State:</strong>'+
                      '<input name="state" type="text" value="'+
                         state[0].firstChild.data+'"</>';
               }           
            }
            else {
            	strHTML = '<span style="color: red; ’+'font-weight: bold;">'+
            		'Zipcode not found!’+'</span>';
            }
            
          // add the generated HTML to the document
	    var cell = document.getElementById("cityState");
            cell.innerHTML = strHTML;
        }
        else {
              alert("Request Failed: "+XHR.responseText);              
        } 
    } 
}

