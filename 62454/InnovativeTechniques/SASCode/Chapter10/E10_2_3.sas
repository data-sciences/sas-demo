* E10_2_3.sas
* 
* Demonstrating the use of Fonts;

filename image "&path\results\E10_2_3.emf";
goptions reset=all noborder
         device=emf
         gsfname=image gsfmode=replace
         ftext='Arial';


title1 f=arial '10.2.3 Box Plots using PROC SHEWHART';
proc sort data=advrpt.demog out=demog;
   by symp wt;
   run;

symbol1 c=blue f='wingdings 2' v='ð' i=box10 bwidth=3;
symbol2 c=red v=dot  i=none h=1.2;

axis1 minor=none color=black
      order=(50 to 250 by 50)
      label=(f='arial/bo' 
             angle=90 rotate=0 
             'Patient Weight');
axis2 order = ('00' '01' '02' '03' '04' '05' 
               '06' '07' '08' '09' '10' '11')
      value = (t=1  ' ' t=12 ' ');

proc shewhart data=demog;
   boxchart wt*symp/ 
      haxis   = axis2
      vaxis   = axis1
      ;
   run;
   quit;
