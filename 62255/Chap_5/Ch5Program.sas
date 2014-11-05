Example 5.1  Sample Windows Services File

# Copyright (c) 1993-1999 Microsoft Corp.
#
# This file contains port numbers for well-known services defined by IANA
#
# Format:
#
# <service name>  <port number>/<protocol>  [aliases...]  [#<comment>]
#

echo                7/tcp
echo                7/udp
discard             9/tcp    sink null
discard             9/udp    sink null
systat             11/tcp    users          #Active users
systat             11/tcp    users          #Active users

                 [... many lines omitted ...]
 shr1          	5000/tcp	# SAS/SHARE SERVER

Example 5.2  Starting the SAS/SHARE Server Using PROC SERVER

proc server id=shr1 oapw=system uapw=user 
authenticate=required;
run;

Example 5.3  Stopping the SAS/SHARE Server Using PROC OPERATE

proc operate serverid=shr1 sapw=system uid=_prompt;
stop server;
run;

Example 5.4  Remote Library Services

libname SHARED slibref=SASHELP server=hrothgar.shr1
sapw=user passwd=_prompt_;

proc print data=SHARED.RETAIL;
title "Retail Sales Total by Month: 1991-1994";
where YEAR gt 1990;
var MONTH SALES;
id YEAR;
run; 

Example 5.5  Remote SQL Pass-Through with SAS/SHARE

proc sql;

connect to remote 
(server=hrothgar.shr1 sapw=user passwd=_prompt_);

select * from connection to remote 
(select YEAR, MONTH, sum(SALES) 
format=dollar12. label='Total Sales'
 from SASHELP.RETAIL
 group by YEAR, MONTH);
quit;

