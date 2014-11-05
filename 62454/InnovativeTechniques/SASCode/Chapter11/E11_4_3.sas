* E11_4_3.sas
*
* Drilling through a graph;

filename e1143 "&path\results\E11_4_3.png";

* Initialize graphics options;
goptions reset=all border 
         ftext=swiss 
         htext=1;
goptions device=png
         gsfname=E1143;

data demog;
   set advrpt.demog(keep=edu wt);
   drilledu = catt('href=E11_4_3.pdf#_',
                   left(put(edu,2.)));
   run;

* Create the histogram of education;
title1 'E11.4.3 Graphics Drilldown';
title2 'Weight for Years of Education';

axis1 label = none
      order=(100 to 200 by 10)
      minor=(n=1);

* Create a chart that links to the summary report;
ods html path="&path\results" (url=none)
         body='E11_4_3.html';

PROC GCHART DATA=demog;
   VBAR edu / type=mean sumvar=wt
              discrete
              patternid=midpoint
              html=drilledu
              raxis=axis1
              ;
   run;
   quit;
ods html close;

%macro BldRpt;
ods pdf file="&path\results\e11_4_3.pdf"
        style=journal;

proc sql noprint;
   select distinct edu
      into :edu1 - :edu99
         from advrpt.demog(keep=edu);
   %let educnt=&sqlobs;
   quit;

%do i = 1 %to &educnt;
   ods pdf anchor="_&&edu&i";
   ods proclabel 'Symptom Summary';
   title3 "&&edu&i Years of Education";
   proc report data=advrpt.demog(where=(edu=&&edu&i)) 
               contents="_&&edu&i Years"
               nowd;
      columns symp sex,wt;
      define symp / group;
      define sex  / across 'Gender';
      define wt   / analysis mean;
      run;
%end;
ods pdf close;
%mend bldrpt;
%bldrpt
