%let whichOrigin = USA;
data localCars;
  set sashelp.cars(where=(origin="&whichOrigin"));
run;

%let rightNow = %sysfunc(date(),date9.) %sysfunc(time(),timeampm.);
%put &rightNow;

%macro runMeans;
  proc means data=sashelp.cars
    mean stddev n mode;
  run;
%mend;

%runMeans;

%macro runMeans(whichData);
  title "Output of MEANS for &whichData";
  proc means data=&whichData
    mean stddev n mode;
  run;
%mend;

%runMeans(sashelp.class);
%runMeans(sashelp.cars);