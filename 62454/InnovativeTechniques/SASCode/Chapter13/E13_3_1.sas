* E13_3_1.sas
*
* Generalizing a program;

%macro mymeans(dsn=advrpt.demog, classlst=sex, 
               varlst=ht wt, 
               outdsn=stats, print=noprint);
title1 "&dsn";
proc means data=&dsn 
  %if &outdsn = %then print;
  %else &print;;
%if &classlst ne %then %do;class &classlst;%end; 
%if &varlst ne %then %do; var &varlst; %end; 
%if &outdsn ne %then %do; 
  output out=&outdsn n= mean= stderr= / autoname;
%end; 
run;
%mend mymeans;
%mymeans(dsn=sashelp.class,varlst=height weight)
%mymeans(outdsn=)
