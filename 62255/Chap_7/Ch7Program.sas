Example 7.1  Starting the Application

/* **********************************************
 * This file starts an Application Server for the
 * default service.
 * ********************************************** */

/* **********************************************
 * The ifcexist macro is defined so that catalogs
 * can be conditionally included in a
 * proglibs statement.
 * ********************************************** */
%macro ifcexist(catname);
  %local catname;
  %if %sysfunc(cexist(&catname)) %then &catname;
%mend;

proc appsrv unsafe='&";%'''   &sysparm ;
  allocate file    sample  '!SASROOT/samples/intrnet';
  allocate library samplib '!SASROOT/samples/intrnet' access=readonly;
  allocate library sampdat '!SASROOT/samples/intrnet' access=readonly;
  allocate library tmplib  '/var/apache2/htdocs/default/tmp';
  allocate file    logfile
	'/var/apache2/htdocs/default/logs/%a_%p.log';
  proglibs sample samplib %ifcexist(sashelp.webeis) sashelp.webprog;
  proglibs sashelp.websdk1;
  adminlibs sashelp.webadmn;
  datalibs sampdat tmplib;
  log file=logfile;

/* ***************************************************
 * Web clients may execute any program in any libref,
 * fileref or libref.catalog listed in a PROGLIBS
 * statement.  Consider security carefully when adding
 * new program libraries.  Operating system security
 * should be used to restrict which users can place
 * programs in these locations.
 *
 * DATALIBS statements list librefs or filerefs
 * that are defined for all programs executed by this
 * server.  Clients may not execute programs in these
 * librefs or filerefs unless they are also listed in
 * a PROGLIBS statement.  The DATALIBS statement
 * does not accept two-level libref.catalog names.
 * The DATALIBS statement does not restrict programs
 * from assigning additional library or file references.
 *
 * To add program and data libraries to this server
 * insert ALLOCATE, PROGLIBS, and DATALIBS statements
 * in a block before the RUN statement.  You may issue
 * multiple PROGLIBS and DATALIBS statements in a
 * single appsrv procedure.  Repeat this syntax as
 * necessary.
 *
 
 
* For example:
 *
 *    allocate library mylib 'path';
 *    allocate file myfile 'path';
 *    allocate library mydata 'path';
 *    proglibs mylib myfile;
 *    datalibs mydata;
 *
 * ************************************************** */

run;

Example 7.2  SAS/IntrNet: Hello World 

NOTE: running request program sample.webhello.sas
NOTE: %INCLUDE (level 1) file /usr/local/SAS/SASFoundation/9.2/samples/intrnet/webhello.sas is file /usr/local/SAS/SASFoundation/9.2/samples/intrnet/webhello.sas.
2   + /*****************************************************************/
3   + /*           S A S   S A M P L E   L I B R A R Y           */
4   + /*                                                         */
5   + /*     NAME: WEBHELLO                                      */
6   + /*    TITLE: Hello World                                   */
7   + /*  PRODUCT: SAS/IntrNet (Application Dispatcher)          */
8   + /*   SYSTEM: ALL                                           */
9   + /*     KEYS:                                               */
10  + /*    PROCS:                                               */
11  + /*     DATA:                                               */
12  + /*                                                         */
13  + /*  SUPPORT: Web Tools Group        UPDATE: 13Oct2000      */
14  + /*      REF: http://www.sas.com/rnd/web/intrnet/dispatch/  */
15  + /*     MISC:                                               */
16  + ************************************************************/
17  +
18  + /*simply write out a web page that says "Hello World!"*/
19  +data _null_;
20  +  file _webout;
21  +  put '<HTML>';
22  +  put '<HEAD><TITLE>Hello World!</TITLE></HEAD>';
23  +  put '<BODY>';
24  +  put '<H1>Hello World!</H1>';
25  +  put '</BODY>';
26  +  put '</HTML>';
27  +run;
NOTE: The file _WEBOUT is:
Access Method=Application Server Access Method,
Network connection type=Full Duplex,
Peer IP address=::ffff:127.0.0.1

NOTE: 6 records were written to the file _WEBOUT.
The minimum record length was 6.
The maximum record length was 40.
NOTE: DATA statement used (Total process time):
real time           0.00 seconds
                                                                 
NOTE: %INCLUDE (level 1) ending.
NOTE: request has completed

Example 7.3  PROC APPSRV Start File with Modifications

proc appsrv  unsafe='&";%''' &sysparm;
allocate file sample '!SASROOT\IntrNet\sample';
allocate library samplib '!SASROOT\IntrNet\sample' 
access=readonly;
allocate library sampdat '!SASROOT\IntrNet\sample'
access=readonly;
allocate library tmplib 'C:\Program 
Files\SAS\IntrNet\default\temp';
allocate file logfile 
'C:\Program Files\SAS\IntrNet\default\logs\%a_%p.log';

/* allocate new program library */
allocate file examples 'c:\Data\examples';
proglibs examples;

proglibs sample samplib %ifcexist(sashelp.webeis)
sashelp.webprog;
proglibs sashelp.websdk1;
adminlibs sashelp.webadmn;
datalibs sampdat tmplib;
log file=logfile; 

Example 7.4  SAS/IntrNet: Temperature Conversion Program

/* SAS/IntrNet program to convert F to C and vice versa */

data _null_;

file _webout;

***** write generic XHTML header *****;
put '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0
Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'/
'<html xmlns="http://www.w3.org/1999/xhtml" lang=
"en-US">';

write top of page *****;
put '<head>'/
'<title>SAS/IntrNet Temperature Conversion 
Calculator</title>'/
'</head>'/
'<body>'/
'<div style="text-align: center">'/
'<h1 style="color: blue">Temperature Conversion 
Calculator</h1>';

**** create HTML form * with hidden text fields ***;
put '<form name="calculator" action="" method="get">'/
'<input type="hidden" name="_service" value="default" 
/>'/
'<input type="hidden" name="_program" value="' 
"&_program" '"/>';

***** get parameter values *****;
temp = symget("input");
type = symget("convert");		

***** input temperature *****;
put '<p><strong>Enter a temperature and select a 
conversion 
type: </strong>'/
'<input type="text" name="input" value="' temp '"/></p>';    

***** select conversion/compute result *****;
put '<p><input type="radio" name="convert" value="1"' @;
if (type = '1') then do;
put 'checked="checked"' @;
result = 5*(input(temp,8.) - 32)/9;
end;
put '> Fahrenheit to Centigrade</p>';
put '<p><input type="radio" name="convert" value="2"' @;
if (type = '2') then do;
put 'checked="checked"' @;
result = 9*input(temp,8.)/5 + 32;
end;    
put '> Centigrade to Fahrenheit</p>';    

 
***** Submit button *****;
put '<p><input type="submit" value = "Submit"></p>';    

***** Display results *****;
if (temp > ' ') then do;
put '<p><strong>Result: </strong>'/
'<input type="text" name="result" value="' 
result 6.2'"/> </p>';
end;    

**** write bottom of page *****;    
put '</form>'/
'</div>'/
'</body>'/
'</html>';
run;

Example 7.5  Using ODS to Display Procedure Output

title "Sales by Region and Product";                                               
footnote;                                                          
                                                                       
ods listing close;                                                        
ods html body=_webout path=&_tmpcat (url=&_replay) rs=none;                 
                                                                     
proc report data=sashelp.shoes;                                             
column region product sales;                                                
define region / group;                                                     
define product / group;                                                  
define sales / analysis sum;                                                
break after region / ol summarize suppress skip;         
run;

ods html close; 
 
Example 7.6  Using ODS MARKUP to Customize Procedure Output

/* prepend XHTML template */
libname userlib "c:\data\samples";
ods path (prepend) userlib.templat; 

/* redirect output to client */
ods markup body=_webout tagset=xhtml; 

