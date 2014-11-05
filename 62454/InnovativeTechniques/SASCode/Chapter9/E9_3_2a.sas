* E9_3_2a.sas
*
* Using the AXIS statement;

* For SAS9.3 uncomment the following ODS statement
* if you want to create the EMF file;
* ods graphics off;

filename reg932a "&path\results\E9_3_2a.emf";

   
goptions reset=all noborder;
title1 f=arial bold '9.3.2a Initial Visit BMI and Potassium';
title2 'Using an AXIS Statement';
options cmplib=(advrpt.functions);
data demog(keep=subject bmi);
   set advrpt.demog(keep=subject ht wt
                    rename=(subject=sbj));
   subject=put(sbj,3.);
   * the E_BMI function is defined in Section 15.2;
   bmi=e_bmi(ht,wt);
   run;
data bmi(keep=subject bmi potassium);
   merge advrpt.lab_chemistry(keep=subject visit potassium
                              where=(visit=1))
         demog(keep=subject bmi);
   by subject;
   run;


goptions ftext='arial'
         dev=emf
         gsfname=reg932a gsfmode=replace;

symbol1 c=blue  v=dot i=join;

axis2 order =(3 to 6 by 1) 
      label =(h=2
              angle=90  
              rotate=0    
              font='Times New Roman'  
              "Potassium Levels") 
      minor =(n=1); 
axis1 minor=(n=4)  
      color=black
      label=("BMI")
      order=(15 to 40 by 5);
proc sort data=bmi;
   by bmi potassium;
   run;
proc gplot data=bmi;
   plot potassium*bmi/haxis=axis1
                      vaxis=axis2;
   run;
quit;
