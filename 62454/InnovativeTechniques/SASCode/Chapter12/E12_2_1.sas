* E12_2_1.sas
* 
* Picture Formats and data directives;

title1 '12.2.1 Picture Formats';
title2 'Using Date Directives';
proc format;
   picture dbdate
      other = '%Y-%0m-%0d:%0H:%0M:%0S' (datatype=datetime);
   run;

data _null_;
   now = '11sep2010:15:05:27'dt;
   put now=;
   put now= dbdate.;
   call symputx('selldate',now);
   run;

%put %sysfunc(putn(&selldate,dbdate.));

**********************************************;
* Month name and month name abbreviation;
proc format;
   picture monthname
      other = '%B        ' (datatype=datetime);
   picture monthabb
      other = '%b ' (datatype=datetime);
   run;


data _null_;
   now = '11sep2010:15:05:27'dt;;
   put now=;
   put now= monthname.;
   put now= monthname3.;
   put now= monthabb.;
   run;


**********************************************;
* Examples contributed by Rick Langston;
proc format;
 picture myDayT (round)
        low - high = '%0d%b%0Y:%0H:%0M:%0S'(datatype=datetime)
     ;
run;


data _null_; 
    datetime = '01apr2011:12:34:56.7'dt; 
    put datetime=myDayT.; 
    datetime = '01apr2011:23:59:59.7'dt; 
    put datetime=myDayT.; 
    run;

/*pre-9.3: 01APR2011:12:34:56  9.3: 01APR2011:12:34:57*/
/*pre-93:  01APR2011:23:59:59  9.3: 02APR2011:00:00:00*/

**********************************************************;
 /* The utility industry often wants to reference a midnight date 
    to be 24:00:00 instead of 00:00:00. The new DATATYPE= value 
    DATETIME_UTIL allows this. */

proc format; 
     picture abc (default=19)
          other='%Y-%0m-%0d %0H:%0M:%0S' (datatype=datetime_util);
     run;

data _null_; 
     x = '01nov2008:00:00:00'dt; put x=abc.; 
     x = '01nov2008:00:00:01'dt; put x=abc.; 
     run;

/*produces */
/**/
/*x=2008-10-31 24:00:00*/
/*x=2008-11-01 00:00:01*/

*********************************************************;
* Count days using %n directive.;
proc format; 
     picture durtest(default=27)
       other='%n days %H hours %M minutes' (datatype=time); 
     run;

data _null_; 
     start = '01jan2010:12:34'dt; 
     end = '01feb2010:18:36'dt; 
     diff = end - start; 
     put diff=durtest.; 
     run;

/*produces */
/**/
/*diff=31 days 6 hours 2 minutes*/



