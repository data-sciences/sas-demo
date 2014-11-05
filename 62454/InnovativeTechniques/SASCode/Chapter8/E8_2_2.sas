* E8_2_2.sas
* 
* UNIVARIATE Plotting;

* For SAS9.3 uncomment the following ODS statement;
* ods graphics off;

filename out822 "&path\results\g822.emf";
goptions device=emf
         gsfname=out822
         noprompt;

title1 f=arial '8.2.2 KEYLEVEL Plots by PROC UNIVARIATE';
proc univariate data=advrpt.demog;
class race sex/keylevel=('3' 'M');
var ht;
histogram /nrows=5 ncols=2
           intertile=1 cfill=cyan vscale=count
           vaxislabel='Count';
run;
quit;

