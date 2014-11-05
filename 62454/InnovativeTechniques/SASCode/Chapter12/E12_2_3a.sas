* E12_2_3a.sas
* 
* Picture Formats using MULT and PREFIX;

title1 '12.2.3a Picture Formats';
title2 'Using MULT and PREFIX';

********************************************;
* Fractions using the PREFIX and MULT options.;
proc format;
   picture showdec
      0          = '9'
      0<  - <.01 = '9'(prefix='<.01')
      .01 - <1   = '99'(prefix='0.' mult=100)
      other      = '00000.00';
   run;

data x;
do x = 0,.001,.012,.123,1.234, 12.345, 1234;
   y=x;
   output;
end;
format y showdec.;
run;
proc print data=x;
run; 

 

title2 'Using The MULT and PREFIX Options';
proc format;
   picture pounds
      1   - 10  = '9,00'(mult=63.5 prefix='£')
      10< - 100 = '09,0'(mult=6.35 prefix='£')
      100<- high= '000.000.000' (mult=.635 prefix='£');
   run;
      
data money;
   do dollars =  1.23, 12.3, 123, 1230, 12300;
      pounds = dollars;
      output;
   end;
   format dollars dollar10.2 pounds pounds.;
   run;
   
proc print data=money;
   run;

