* E10_1_3.sas
* 
* Using PROC SHEWHART to form BOX plots;

filename image "&path\results\E10_1_3.emf";
goptions reset=all noborder
         device=emf
         gsfname=image gsfmode=replace
         ftext='Arial';


title1 f=arial '10.1.3 Box Plots using PROC SHEWHART';
proc sort data=advrpt.demog out=demog;
   by symp wt;
   run;

symbol1 color = blue v=dot i=box10 bwidth=3;
symbol2 color = red  v=dot  i=none h=1.2;

axis1 minor=none color=black
      order=(50 to 250 by 50)
      label=(angle=90 rotate=0);
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
