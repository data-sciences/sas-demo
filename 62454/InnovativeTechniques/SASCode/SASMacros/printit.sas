%macro printit(dsn=sashelp.class);
title1 "Partial Listing of &dsn";
proc print data=&dsn(obs=20);
run;
%mend printit;
