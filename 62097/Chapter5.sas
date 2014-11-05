
options nodate nonumber ls=80 ps=60;
data falcons;
   input aerieht @@;
   label aerieht='Aerie Height in Meters';
   datalines;
15.00 3.50 3.50 7.00 1.00 7.00 5.75 27.00 15.00 8.00
4.75 7.50 4.25 6.25 5.75 5.00 8.50 9.00 6.25 5.50
4.00 7.50 8.75 6.50 4.00 5.25 3.00 12.00 3.75 4.75
6.25 3.25 2.50
;
run;

proc univariate data=falcons normal plot;
   var aerieht;
	 histogram aerieht / normal(color=red);
	 probplot aerieht / normal(mu=est sigma=est color=red);
title 'Normality Test for Prairie Falcon Data';
run;

ods select moments testsfornormality plots;
proc univariate data=falcons normal plot;
   where aerieht<15;
   var aerieht;
   histogram aerieht / normal(color=red noprint);
   probplot aerieht / normal(mu=est sigma=est color=red);
title 'Normality Test for Subset of Prairie Falcon Data' ;
run;
