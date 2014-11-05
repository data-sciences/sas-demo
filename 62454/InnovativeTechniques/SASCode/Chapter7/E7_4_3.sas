* E7_4_3.sas
* 
* Using Percentiles to identify outliers;

title1 '7.4.3 Using Percentiles';
proc summary data=advrpt.lab_chemistry;
   var potassium;
   output out=stats
          mean= 
          p1=
          p99= /autoname;
   run;

data chkoutlier;
   set stats(keep=potassium_p1 potassium_p99);
   do until (done);
      set advrpt.lab_chemistry(keep=subject visit potassium) end=done;
      if potassium_p1 ge potassium or potassium ge potassium_p99 then output chkoutlier;
   end;
   run;
options nobyline;
proc print data=chkoutlier;
  by potassium_p1 potassium_p99;
  title2 'Potassium 1% Bounds are #byval1, #byval2';
  run; 
