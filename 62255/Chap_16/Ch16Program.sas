Example 16.1  SOAP Request

<soap:Envelope 
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xmlns:xsd="http://www.w3.org/2001/XMLSchema"
xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
<soap:Body>
<GetCityForecastByZIP xmlns="http://ws.cdyne.com/WeatherWS/">
<ZIP>27511</ZIP>
</GetCityForecastByZIP>
</soap:Body>
</soap:Envelope>

Example 16.2  Sending a SOAP request
/*
 *  Path to SOAP messages
 */
filename REQUEST  "c:\data\examples\getWeatherRequest.xml";
filename RESPONSE "c:\data\examples\getWeatherResponse.xml";

/*
 *  Run SOAP request
 */
proc soap in=REQUEST
out=RESPONSE
url="http://ws.cdyne.com/WeatherWS/Weather.asmx"
     soapaction="http://ws.cdyne.com/WeatherWS/GetCityForecastByZIP";
run;

/* 
 *    Parse response data
 */
filename SXLEMAP 'c:\data\examples\getWeatherByZip.map';
libname  RESPONSE xml xmlmap=SXLEMAP access=READONLY;

data _null_; 
set RESPONSE.GetCityForecastByZIPResult;
call symput("City",trim(city));
call symput("State",trim(state));
call symput("Station",trim(WeatherStationCity));
run;

/*
 *  Combine 7-day data tables
 */
data results;
merge RESPONSE.Forecast 
RESPONSE.Temperatures 
RESPONSE.ProbabilityOfPrecipiation;
day=input(substr(date,1,10),yymmdd10.);
format day date.;
label day="Date"
desciption="Forecast"
NightTime="Prob of Precip: Night"
DayTime="Prob of Precip: Day";
run; 
/*
 *  Display response
 */
proc print label;
id day;
var desciption MorningLow DayTimeHigh DayTime NightTime;
title "7 Day Forecast for &city, &state";
title2 "Weather Station: &station";
run;

Example 16.3  SOAP Response 

<GetCityForecastByZIPResponse
xmlns="http://ws.cdyne.com/WeatherWS/">
<GetCityForecastByZIPResult>
<Success>true</Success>
<ResponseText>City Found</ResponseText>
<State>NC</State>
<City>Cary</City>
<WeatherStationCity>Bunn</WeatherStationCity>
<ForecastResult>
<Forecast>
<Date>2010-07-01T00:00:00</Date>
<WeatherID>2</WeatherID>
<Desciption>Partly Cloudy</Desciption>
<Temperatures>
<MorningLow>69</MorningLow>
<DaytimeHigh>85</DaytimeHigh>
</Temperatures>
<ProbabilityOfPrecipiation>
<Nighttime>70</Nighttime>
<Daytime>20</Daytime>
</ProbabilityOfPrecipiation>
</Forecast>
… several days’ forecasts omitted …
</ForecastResult>
</GetCityForecastByZIPResult>
</GetCityForecastByZIPResponse>
 
Example 16.4  Response Object XML Map

<SXLEMAP name="getWeatherbyZip" version="1.2">
<TABLE name="GetCityForecastByZIPResult">
    <TABLE-PATH syntax="XPath">
        /GetCityForecastByZIPResponse/GetCityForecastByZIPResult
    </TABLE-PATH>
    <COLUMN name="State">
        <PATH syntax="XPath">            /GetCityForecastByZIPResponse/GetCityForecastByZIPResult/State
        </PATH>
        <TYPE>character</TYPE>
        <DATATYPE>string</DATATYPE>
        <LENGTH>32</LENGTH>
    </COLUMN>
    <COLUMN name="City">
        <PATH syntax="XPath">            /GetCityForecastByZIPResponse/GetCityForecastByZIPResult/City
        </PATH>
        <TYPE>character</TYPE>
        <DATATYPE>string</DATATYPE>
        <LENGTH>32</LENGTH>
    </COLUMN>
    <COLUMN name="WeatherStationCity">
        <PATH syntax="XPath">            /GetCityForecastByZIPResponse/GetCityForecastByZIPResult/WeatherStationCity
        </PATH>
        <TYPE>character</TYPE>
        <DATATYPE>string</DATATYPE>
        <LENGTH>32</LENGTH>
    </COLUMN>
</TABLE>
<TABLE name="Forecast">
    <TABLE-PATH syntax="XPath">        /GetCityForecastByZIPResponse/GetCityForecastByZIPResult/ForecastResult/Forecast
    </TABLE-PATH>
    <COLUMN name="Date">
        <PATH syntax="XPath">            /GetCityForecastByZIPResponse/GetCityForecastByZIPResult/ForecastResult/Forecast/Date
        </PATH>
        <TYPE>character</TYPE>
        <DATATYPE>string</DATATYPE>
        <LENGTH>32</LENGTH>
    </COLUMN>
    <COLUMN name="Desciption">
        <PATH syntax="XPath">            /GetCityForecastByZIPResponse/GetCityForecastByZIPResult/ForecastResult/Forecast/Desciption
        </PATH>
        <TYPE>character</TYPE>
        <DATATYPE>string</DATATYPE>
        <LENGTH>32</LENGTH>
    </COLUMN>
</TABLE>

<TABLE name="Temperatures">
    <TABLE-PATH syntax="XPath">        /GetCityForecastByZIPResponse/GetCityForecastByZIPResult/ForecastResult/Forecast/Temperatures
    </TABLE-PATH>
    <COLUMN name="MorningLow">
        <PATH syntax="XPath">            /GetCityForecastByZIPResponse/GetCityForecastByZIPResult/ForecastResult/Forecast/Temperatures/MorningLow
        </PATH>
        <TYPE>character</TYPE>
        <DATATYPE>string</DATATYPE>
        <LENGTH>32</LENGTH>
    </COLUMN>
    <COLUMN name="DaytimeHigh">
        <PATH syntax="XPath">            /GetCityForecastByZIPResponse/GetCityForecastByZIPResult/ForecastResult/Forecast/Temperatures/DaytimeHigh
        </PATH>
        <TYPE>character</TYPE>
        <DATATYPE>string</DATATYPE>
        <LENGTH>32</LENGTH>
    </COLUMN>
</TABLE>
<TABLE name="ProbabilityOfPrecipiation">
    <TABLE-PATH syntax="XPath">        /GetCityForecastByZIPResponse/GetCityForecastByZIPResult/ForecastResult/Forecast/ProbabilityOfPrecipiation
    </TABLE-PATH>
    <COLUMN name="Nighttime">
        <PATH syntax="XPath">            /GetCityForecastByZIPResponse/GetCityForecastByZIPResult/ForecastResult/Forecast/ProbabilityOfPrecipiation/Nighttime
        </PATH>
        <TYPE>character</TYPE>
        <DATATYPE>string</DATATYPE>
        <LENGTH>32</LENGTH>
    </COLUMN>
    <COLUMN name="Daytime">
        <PATH syntax="XPath">            /GetCityForecastByZIPResponse/GetCityForecastByZIPResult/ForecastResult/Forecast/ProbabilityOfPrecipiation/Daytime
        </PATH>
        <TYPE>character</TYPE>
        <DATATYPE>string</DATATYPE>
        <LENGTH>32</LENGTH>
    </COLUMN>
</TABLE>

</SXLEMAP>
 
Example 16.5  Sample: MEANS Procedure Web Service Stored Process

%put &tablename

libname _WEBOUT xml xmlmeta = &_XMLSCHEMA;
libname instream xml;

proc means data=instream.&tablename
output out=_WEBOUT.mean;
run;

libname _WEBOUT clear;
libname instream clear;

Example 16.6  Using the Sample BI Web Service

filename REQUEST "c:\data\examples\sasxmla_request.xml" ; 
filename RESPONSE "c:\data\examples\sasxmla_response.xml";

/*
*  send SOAP request
*/
proc soap 
	in=request
out=response
url="http://odin:8080/SASBIWS/services/XMLA"
soapaction="urn:schemas-microsoft-com:xml-analysis:Execute";
run;

filename SXLEMAP 'c:\data\examples\sasmeans.map';
libname  RESPONSE xml xmlmap=SXLEMAP access=READONLY;

/*
 *  transpose rows to columns
 */
proc transpose data=RESPONSE.MEAN 
	out=MEANS (drop=_name_ _label_ n); 
	var col1-col3;
	id statistic;
run;

/*
*  Printing
*/
title 'Sample: MEANS Procedure Web Service';
proc print data=MEANS noobs;
run;
 
Example 16.7  Request to the Sample BI Web Service

<soapenv:Envelope 
xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
xmlns:urn="urn:schemas-microsoft-com:xml-analysis">                                 
<soapenv:Body>                                                                                                                                               
<urn:Execute>                                                                                                                                             
<urn:Command>                                                                                                                                          
<StoredProcess 
name="Sample: MEANS Procedure Web Service">                                                                                                      
<Parameter name="tablename">
InData
</Parameter>                                                                                                                
<Stream name="instream">                                                                                                                                      
<Table>                                                                                                                                                     
<InData>                                                                                                                                                  
<Column1>1</Column1>                                                                                                                                    
<Column2>20</Column2>                                                                                                                                   
<Column3>99</Column3>                                                                                                                                   
</InData>                                                                                                                                                 
<InData>                                                                                                                                                  
<Column1>50</Column1>                                                                                                                                   
<Column2>200</Column2>                                                                                                                                  
<Column3>9999</Column3>                                                                                                                                 
</InData>                                                                                                                                                 
<InData>                                                                                                                                                  
<Column1>100</Column1>                                                                                                                                  
<Column2>2000</Column2>                                                                                                                                 
<Column3>1000000</Column3>                                                                                                                              
</InData>                                                                                                                                                 
</Table>                                                                                                                                                    
</Stream>                                                                                                                                                     
</StoredProcess>                                                                                                                                                
</urn:Command>                                                                                                                                         
<urn:Properties>                                                                                                                                       
<PropertyList xmlns="urn:schemas-microsoft-com:xml-analysis">                                                                                                   
<DataSourceInfo>Provider=SASSPS</DataSourceInfo>                                                                                                              
</PropertyList>                                                                                                                                                 

</urn:Properties>                                                                                                                                      
</urn:Execute>                                                                                                                                            
</soapenv:Body>                                                                                                                                              
</soapenv:Envelope>  
 
Example 16.8  Response from the Sample BI Web Service

<m:ExecuteResponse 
xmlns:m="urn:schemas-microsoft-com:xml-analysis">
<m:return>
<TABLE>
<xs:schema 
xmlns:xs=http://www.w3.org/2001/XMLSchema xmlns:od="urn:schemas-microsoft-com:officedata">
<xs:element name="TABLE">
<xs:complexType>
<xs:sequence>
<xs:element ref="MEAN" minOccurs="0" maxOccurs="unbounded" />
</xs:sequence>
</xs:complexType>
</xs:element>
<xs:element name="MEAN">
<xs:complexType>
<xs:sequence>
<xs:element name="_TYPE_" 
minOccurs="0" 
od:jetType="double" 
od:sqlSType="double" 
type="xs:double" />
<xs:element name="_FREQ_" 
minOccurs="0" 
od:jetType="double" 
od:sqlSType="double" 
type="xs:double" />
<xs:element name="_STAT_" 
minOccurs="0" 
od:jetType="text" 
od:sqlSType="nvarchar">
<xs:simpleType>
<xs:restriction base="xs:string">
  <xs:maxLength value="8" />
</xs:restriction>
</xs:simpleType>
</xs:element>
<xs:element name="COLUMN3" 
minOccurs="0" 
od:jetType="double" 
od:sqlSType="double" 
type="xs:double" />
<xs:element name="COLUMN2" 
minOccurs="0" 
od:jetType="double" 
od:sqlSType="double" 
type="xs:double" />
<xs:element name="COLUMN1" 
minOccurs="0" 
od:jetType="double" 
od:sqlSType="double" 
type="xs:double" />
</xs:sequence>
</xs:complexType>
</xs:element>
</xs:schema>
<MEAN>
<_TYPE_>0</_TYPE_>
<_FREQ_>3</_FREQ_>
<_STAT_>N</_STAT_>
<COLUMN3>3</COLUMN3>
<COLUMN2>3</COLUMN2>
<COLUMN1>3</COLUMN1>
</MEAN>
<MEAN>
<_TYPE_>0</_TYPE_>
<_FREQ_>3</_FREQ_>
<_STAT_>MIN</_STAT_>
<COLUMN3>99</COLUMN3>
<COLUMN2>20</COLUMN2>
<COLUMN1>1</COLUMN1>
</MEAN>
<MEAN>
<_TYPE_>0</_TYPE_>
<_FREQ_>3</_FREQ_>
<_STAT_>MAX</_STAT_>
<COLUMN3>1000000</COLUMN3>
<COLUMN2>2000</COLUMN2>
<COLUMN1>100</COLUMN1>
</MEAN>
<MEAN>
<_TYPE_>0</_TYPE_>
<_FREQ_>3</_FREQ_>
<_STAT_>MEAN</_STAT_>
<COLUMN3>336699.333</COLUMN3>
<COLUMN2>740</COLUMN2>
<COLUMN1>50.3333333</COLUMN1>
</MEAN>
<MEAN>
<_TYPE_>0</_TYPE_>
<_FREQ_>3</_FREQ_>
<_STAT_>STD</_STAT_>
<COLUMN3>574456.555</COLUMN3>
<COLUMN2>1094.89726</COLUMN2>
<COLUMN1>49.5008417</COLUMN1>
</MEAN>
</TABLE>
</m:return>
</m:ExecuteResponse>
 
Example 16.9  XML Map for the Sample BI Web Service

<SXLEMAP name="AUTO_GEN" version="1.2">
<TABLE name="MEAN">
<TABLE-PATH syntax="XPath">
/m:ExecuteResponse/m:return/TABLE/MEAN
</TABLE-PATH>
<COLUMN name="Statistic">
<PATH syntax="XPath">
/m:ExecuteResponse/m:return/TABLE/MEAN/_STAT_
</PATH>
<TYPE>character</TYPE>
<DATATYPE>string</DATATYPE>
<LENGTH>32</LENGTH>
</COLUMN>

<COLUMN name="col1">
<PATH syntax="XPath">
/m:ExecuteResponse/m:return/TABLE/MEAN/COLUMN1
</PATH>
<TYPE>character</TYPE>
<DATATYPE>string</DATATYPE>
<LENGTH>32</LENGTH>
</COLUMN>
<COLUMN name="col2">
<PATH syntax="XPath">
/m:ExecuteResponse/m:return/TABLE/MEAN/COLUMN2
</PATH>
<TYPE>character</TYPE>
<DATATYPE>string</DATATYPE>
<LENGTH>32</LENGTH>
</COLUMN>
<COLUMN name="col3">
<PATH syntax="XPath">
/m:ExecuteResponse/m:return/TABLE/MEAN/COLUMN3
</PATH>
<TYPE>character</TYPE>
<DATATYPE>string</DATATYPE>
<LENGTH>32</LENGTH>
</COLUMN>
</TABLE>
</SXLEMAP>

