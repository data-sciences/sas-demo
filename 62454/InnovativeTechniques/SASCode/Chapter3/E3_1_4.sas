* E3_1_4.sas
* 
* Look-Ahead with a merge;

title1 '3.1.4 MERGE Statement Look-Ahead';
proc sort data=advrpt.lab_chemistry(keep=subject visit labdt)
           out= labdates
           nodupkey;
   by subject labdt;
   run;
%let mnby= %sysfunc(getoption(mergenoby,keyword));
options mergenoby=nowarn ;
data nextvisit(keep=subject visit labdt days2nextvisit);
   merge labdates(keep=subject visit labdt)
         labdates(firstobs=2
                  keep=subject labdt
                 rename=(subject=nextsubj labdt=nextdt));
   Days2NextVisit = ifn(subject=nextsubj,nextdt-labdt, ., .);
   run;
proc print data=nextvisit;
run;
option &mnby;
