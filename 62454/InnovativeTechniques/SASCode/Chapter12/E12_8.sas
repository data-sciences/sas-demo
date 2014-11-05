* E12_8.sas
*
* Using the PVALUE. format;
title1 '12.8 Using the PVALUE Format';
data smallnums;
   do i = 6 to 0 by -1;
      if i=4 then do;
         * Write out the min for pvalue7.4;
         x=1*10**-i;
         output;
      end;
      x = i*10**-i;
      y=x;
      output;
   end;
   format x 8.6 y pvalue7.4;
   run;
proc print data=smallnums;
   run;

proc format;
   value range
      low - <0 = [best7.]
      0        = [1.]
      0<  -  1 = [pvalue6.4]
      1<  -high= [best6.];
   run;

data tryit;
   do i = -4.1,-.0001,-.00001,0,.00001,.00001,.0003,.02,.1,1,12.34,3456.789;
      j=i;
      k=i;
      output;
   end;
   format i best8. j pvalue7.4 k range.;
   run;
proc print data=tryit;
   run;
