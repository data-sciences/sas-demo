* E3_9_3b.sas
* 
* Using a non-standard loop specification;

title1 '3.9.3b Using a Non-standard Loop Specification';
title2 'With Two SET Statements';

data big;
do i = 1 to 5000000;
   j=i;
   k=j;
   output;
   end;
run;

data _null_;
   set big;
   call symputx('bigx',i);
   run;
   
data _null_;
   set big end=eof;
   if eof then call symputx('bigx',i);
   run;

data _null_;
   if eof then stop;
   do _n_ = nobs to 1 by -1 until(_error_ eq 0);
      _error_ = 0;
      set BIG point=_n_ nobs=nobs;
      end;
   if _error_ eq 0 then call symputx('bigx',i);
   stop;
   set BIG(drop=_all_) end=eof;
   run;
%put &bigx;

