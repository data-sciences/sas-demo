* E8_2_3.sas
* 
* UNIVARIATE Plotting;

* For SAS9.3 uncomment the following ODS statement;
* ods graphics off;

filename out823a "&path\results\g823a.emf";
goptions device=emf
         gsfname=out823a
         noprompt
         ftext=arial;

title1 f=arial '8.2.3a Probability Plots';
symbol1 v=dot c=blue;

proc univariate data=advrpt.demog;
   var wt;
   probplot /normal(mu=est sigma=est
                    color=red l=2 w=2);

   inset mean='Mean: ' (6.2)
         std ='STD: ' (6.3) / position=nw
                              height=4 font=arial;
   run;
   quit;


filename out823b "&path\results\g823b.emf";
goptions device=emf
         gsfname=out823b
         noprompt
         ftext=arial;

title1 f=arial '8.2.3b Q-Q (Quantile) Plots';
symbol1 v=dot c=blue;

proc univariate data=advrpt.demog;
   var wt;
   qqplot /normal(mu=est sigma=est
                  color=red l=2 w=2);

   inset mean='Mean: ' (6.2)
         std ='STD: ' (6.3) / position=nw
                              height=4 font=arial;
   run;
   quit;
