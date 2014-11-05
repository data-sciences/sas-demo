* E12_2_2.sas
* 
* Picture Formats Working with Fractional Values;

title1 '12.2.2 Working with Fractional Values';
title2 'Showing Decimals';

proc format;
   picture showval
      other = '0000';
   picture withdec
      other = '00.0';
   picture twodec
      other = '09.00';
   run;

data vallist;
   do val = 0 to 3 by .25;
      val2 = val;
      val3 = val;
      val4 = val;
      output;
   end;
   format val2 showval. val3 withdec. val4 twodec.;
   run;
proc print data=vallist;
   run;

****************************************;
* Fraction rounding and truncation.;
proc format;
   picture showdec
      other = '09.00';
      run;
data x;
do x = .007,.017,.123,1.234, 12.345, 1234;
   y=x;
   output;
end;
format y showdec. x 8.3;
run;
proc print data=x;
run; 
****************************************;
* Fraction rounding and truncation.;
proc format;
   picture showdecr (round)
      other = '00009.00';
      run;
data x;
do x = .007,.017,.123,1.234, 12.345, 1234;
   y=x;
   output;
end;
format y showdecr.
       x 8.3;
run;
proc print data=x;
run; 
