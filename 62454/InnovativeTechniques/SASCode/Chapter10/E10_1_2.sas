* E10_1_2.sas
* 
* Using the SYMBOL statement to form BOX plots;

filename image "&path\results\E10_1_2.emf";
goptions reset=all noborder
         device=emf
         gsfname=image gsfmode=replace
         ftext='Arial';

title1 f=arial '10.1.2 Box Plots using the I= Option';
proc sort data=advrpt.demog out=demog;
   by symp wt;
   run;

symbol1 color = blue v=none i=box10 bwidth=3;
symbol2 color = red  v=dot  i=none h=1.2;

axis1 minor=none color=black
      order=(50 to 250 by 50)
      label=(angle=90 rotate=0);
axis2 order = ('00' '01' '02' '03' '04' '05' 
               '06' '07' '08' '09' '10' '11')
      value = (t=1  ' ' t=12 ' ');

proc gplot data=demog;
   plot wt*symp/ haxis   = axis2
                 vaxis   = axis1
                 ;
   run;
   quit;
