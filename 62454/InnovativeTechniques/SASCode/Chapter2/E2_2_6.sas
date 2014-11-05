* E2_2_6.sas
*
* Boolean Conversions;
title1 '2.2.6  Boolean Conversions';
data Miss2zero;
   set advrpt.demog;
   x = ^^dob;
   y = sum(dob,0);
   z = coalesce(dob,0);
   put dob= x= y= z=;
   format dob 6.;
   run;

* Convert missing to 0 all others to 1;
data a;
do val=.a, ., ._,-2 to 2 by 1;
mval=^missing(val);
put val= mval=;
end;
run;

* distinguish between positive and negative values;
title2 'Positive or Negative?';
data posneg;
   do v=.,-2 to 2;
      *if positieve;
      pos = sign(v)=1;
      * Not positive;
      notpos = (sign(v) in(-1,0));
      * Negative;
      neg = ^sign(v)=-1;
      * Not negative;
      notneg = sign(v) in (0,1);
      output posneg;
   end;
   run;
proc print data=posneg;
   run;

