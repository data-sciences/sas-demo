* E12_2_3b.sas
* 
* Picture Formats and data directives;

title1 '12.2.3b Using the PREFIX and MULT Options';
title2 'Including Negative Values';
proc format;
      picture pounds
         -1  - <0  = '99'  (mult=63.5 prefix='£-0,')
         0         = '9'   (prefix='£')
         0 < - <1  = '99'  (mult=63.5 prefix='£0,')
         1   - 10  = '9,00'(mult=63.5 prefix='£')
         10< - 100 = '99,0'(mult=6.35 prefix='£')
         100<- high= '000.000.000' (mult=.635 prefix='£');
      run;
      
data money;
   do dollars = -.123, 0, .123, 1.0, 1.23, 12.3, 123, 1230, 12300;
      pounds = dollars;
      output;
   end;
   format dollars dollar10.2 pounds pounds.;
   run;
   
proc print data=money;
   run;

