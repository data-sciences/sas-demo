%let name=example12;
filename odsout '.';

%let state=37;
%let county=183;

%let year1=07;
%let year2=08;

proc sql;
/* Get the county name and state abbreviation into macro variables */
select propcase(countynm) into :countynm separated by ' ' from maps.cntyname where state=&state and county=&county;
select unique statecode into :statecode separated by ' ' from maps.us where state=&state;
/* Create a list of the states you want in the map (ie, exclude the ones you don't want */
create table good_states as select unique state, statecode from maps.us where statecode not in ('PR' 'DC');
quit; run;


/* 
Using data from:
http://www.irs.gov/taxstats/article/0,,id=212695,00.html
http://www.irs.gov/pub/irs-soi/countyinflow0708.csv

To me, the filenames "inflow" and "outflow" are a little confusing.
Outflow = 'out' of the other county, into the named county.
Inflow = from the named county, 'into' the other county.
(really, best to just look at the variable names.
*/

/*
filename rawurl url "http://www.irs.gov/pub/irs-soi/countyinflow&year1&year2..csv"
 proxy='http://inetgw.fyi.sas.com:80' debug;
PROC IMPORT OUT=raw_data DATAFILE=rawurl DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
*/
PROC IMPORT OUT=raw_data DATAFILE="countyinflow0708.csv" DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;


/* Limit the data to just the people moving into & out of the county of interest */
data out_data (keep=state county county_name gained); 
 set raw_data 
  (where=( 
   (state_code_dest="&state" and county_code_dest="&county") 
   and
   (county_name ^? 'Non-Migrants')
  ));
  state=.; county=.;
  state=state_code_origin;
  county=county_code_origin;
  gained=exmpt_num;
run;

data in_data (keep=state county /* county_name */ lost); 
 set raw_data
  (where=( 
   (state_code_origin="&state" and county_code_origin="&county") 
   and
   (county_name ^? 'Non-Migrants')
  ));
  state=.; county=.;
  state=state_code_dest;
  county=county_code_dest;
  lost=exmpt_num;
run;
/* The data doesn't have the useful county name, so I'm querying it from a SAS data set */
proc sql;
create table in_data as 
select in_data.*, trim(left(propcase(cntyname.countynm)))||' County' as County_Name
from in_data left join maps.cntyname
on in_data.state=cntyname.state and in_data.county=cntyname.county;
quit; run;

/* Limit to just the County values (ie, exclude state 'totals', and such) */
proc sql;
create table out_data as select * from out_data where state in (select unique state from good_states);
create table in_data as select * from in_data where state in (select unique state from good_states);
quit; run;


/* Merge the data */
proc sort data=out_data out=out_data; by state county county_name; run;
proc sort data=in_data out=in_data; by state county county_name; run;
data combined;
 merge out_data in_data;
 by state county county_name;
run;

/* I do my own binning/bucketing of data, and here are the cut-off values for my color bins */
%let bucketn=-100;
%let bucketp=100;
data combined; set combined;
if lost=. then lost=0;
if gained=. then gained=0;
net=gained-lost;
if net<&bucketn then bucket=1;
else if net<0 then bucket=2;
else if net=0 then bucket=3;
else if net<=&bucketp then bucket=4;
else bucket=5;
run;

/* Add html datatips to my data sets */

data out_data; set out_data;
length my_html $500;
my_html='title='||quote('From '||trim(left(county_name))||', '||trim(left(fipstate(state)))||':  '||
 trim(left(put(gained,comma10.0))));
run;

data in_data; set in_data;
length my_html $500;
my_html='title='||quote('To '||trim(left(county_name))||', '||trim(left(fipstate(state)))||':  '||
 trim(left(put(lost,comma10.0))));
run;

data combined; set combined;
length my_html $500;
my_html='title='||quote(trim(left(county_name))||', '||trim(left(fipstate(state)))||':  '||'0d'x||
 county||'0d'x||
 "From &countynm: "||trim(left(put(lost,comma10.0)))||'0d'x||
 "To &countynm: "||trim(left(put(gained,comma10.0)))||'0d'x||
 "Net: "||trim(left(put(net,comma10.0)))
 );
run;



/* Annotate a star (character 'V' of the marker font) on the county of interest */
proc sql;
create table anno_star as
select avg(x) as x, avg(y) as y
from maps.uscounty
where state=&state and county=&county;
quit; run;
data anno_star; set anno_star;
length function style color $8;
xsys='2'; ysys='2'; hsys='3'; when='a';
function='label';
text='V';
size=3.0;
style='marker'; color='cyan'; output;
style='markere'; color='black'; output;
run;



/* Create state outlines (annotate dataset) from maps.uscounty map */
data uscounty;
   set maps.uscounty;
   run;
/* Remove all internal county boundaries, just keeping the state outline */
proc gremove data=uscounty out=outline;
   by STATE; id COUNTY;
   run;
/* Create the annotate dataset */
data outline;
   length COLOR FUNCTION $ 8;
   retain XSYS YSYS '2' COLOR 'gray33' SIZE 1.75 WHEN 'A' FX FY FUNCTION;
   set outline; by State Segment;
   if first.Segment then do;
      FUNCTION = 'Move'; FX = X; FY = Y; end;
   else if FUNCTION ^= ' ' then do;
      if X = .  then do;
         X = FX; Y = FY; output; FUNCTION = ' '; end;
      else FUNCTION = 'Draw';
   end;
   if FUNCTION ^= ' ' then do;
      output;
      if last.Segment then do;
         X = FX; Y = FY; output; end;
   end;
run;


goptions device=png;
goptions cback=white;
goptions noborder;

ODS LISTING CLOSE;
ODS HTML path=odsout body="&name..htm" (title="U.S. Migration, by County (SAS/Graph map)") style=minimal;

goptions gunit=pct htitle=4 ftitle="albany amt/bold" htext=3 ftext="albany amt" ctext=gray55;

footnote1 "For privacy, only inter-county moves of >10 people are included.";

pattern1 v=s c=cxD7191C; 
pattern2 v=s c=cxFDAE61; 
pattern3 v=s c=cxFFFFBF; 
pattern4 v=s c=cxA6D96A; 
pattern5 v=s c=cx1A9641; 

proc format;
value buckets 
1 = "< &bucketn"
2 = "&bucketn to 0"
3 = "0"
4 = "0 to &bucketp"
5 = "> &bucketp"
;
run;

legend1 label=none shape=bar(.15in,.15in) value=(justify=left);

title1 "Net Effect of People moving " c=cxD7191C "out of" c=gray55 " & " c=cx1A9641 "into";
title2 " &countynm County, &statecode";
title3 "between years 20&year1 and 20&year2 "
       "(data source: " c=blue link="http://www.irs.gov/taxstats/article/0,,id=212695,00.html" "IRS" c=gray ")";
proc gmap data=combined map=uscounty all anno=outline;
id state county;
format bucket buckets.;
choro bucket / discrete
 /* Use the midpoints option, to guarantee all ranges will show up in legend */
 midpoints = 1 2 3 4 5
 coutline=graydd
 legend=legend1
 anno=anno_star
 html=my_html
 des='' name="&name";
run;


quit;
ODS HTML CLOSE;
ODS LISTING;
