/* create a new table with just two columns */
proc sql;
create table example1 as
  select make, mpg_highway
  from sashelp.cars;
quit;

/* create a new table with just two columns */
/* and subset the table with a filter       */
proc sql;
create table example2 as
  select make, mpg_highway
  from sashelp.cars
  where origin="USA";
quit;

/* create a new table that includes a       */
/* calculated column, and then aggregates   */
/* the calculation across a grouping        */
/* column                                   */
proc sql;
create table example3 as
  select make, avg(mpg_highway) as avg_mpg
  from sashelp.cars
  where origin="USA"
  group by make;
quit;


/* create a new table that includes a       */
/* calculated column, and then aggregates   */
/* the calculation across a grouping        */
/* column                                   */
proc sql;
create table example5 as
  select make, avg(msrp/horsepower) as avg_ppp 
      format dollar10.2 label="Price per pony"
  from sashelp.cars
  where origin = "USA"
  group by make
  order by avg_ppp desc;
quit;


/* Putting it all together */
/* First, a macro variable that allows us to */
/* easily change the column we want to use   */
/* in just one place                         */
%let mpgVar = mpg_city; /* or mpg_highway */

/* Next, a PROC SQL step to calculate the */
/* average value across MAKEs             */
proc sql noprint;
create table work.example4 as
  select make, 
         avg(&mpgVar) as avg_mpg format 4.2		 
  from sashelp.cars
  where origin="USA"  
  group by make
  order by avg_mpg desc;

  /* new instruction: count the "makes" and store */
  /* in a macro variable named "howMany"          */
  select count(distinct make) into :howMany
  from sashelp.cars
  where origin="USA";
quit;

/* Now, use the new data table and macro values */
/* in a report                                  */
/* This title and PRINT step create a tabular   */
/* view of the data                             */
title "Analyzed %sysfunc(trim(&howMany)) values of Make";
proc print data=work.example4 
    label noobs;
  var make avg_mpg;
  label avg_mpg="Average &mpgVar";
run;

/* This SGPLOT step creates a vertical bar      */
/* chart of the data                            */
title; /* clear title */
ods graphics / width=600 height=400;
proc sgplot data=work.example4;
  vbar make / response=avg_mpg;
  xaxis label="Make";
  yaxis label="Average &mpgVar";
run;
