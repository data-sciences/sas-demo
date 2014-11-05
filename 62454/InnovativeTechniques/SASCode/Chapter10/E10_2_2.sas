* E10_2_2.sas
* 
* Splitting text lines using the JUSTIFY option;
filename gfile "&path\results\E10_2_2.emf";
goptions reset=all noborder
         ftext='arial' 
         gsfname = gfile 
         device=emf;

title1 f=arial h=1.2 justify=c '10.2.2'
                     j=center 'Splitting Text';
title2 'BMI Index by Birth Year';
data bmi(keep=year bmi plttype);
   set advrpt.demog;
   year = year(dob);
   bmi = wt / (ht*ht) * 703; 
   if bmi>25 then plttype=2;
   else plttype=1;
   run;
symbol1 c=blue v=dot h=1.5;
symbol2 c=red v=dot h=1.5;
axis1 reflabel = (h=1.5
                t=1 c=red  j=left 'Overweight' j=l ' ' j=l c=blue  'Normal'); 
axis2 order=(1920 to 1970 by 10)
      label=(j=c 'Birthyear' j=c 'All Subjects'); 

proc gplot data=bmi;
plot bmi*year=plttype/
              vaxis=axis1 haxis=axis2 
              nolegend
              vref = 25
              lvref= 2
              cvref= blue;
run;
quit; 
