*E3_9_2.sas
*
* demonstrate compound loops;
data showloop;
   do count=1 to 3, 5 to 20 by 5, 25, 33;
      output showloop;
   end;
   run;
proc print data=showloop;
   run;

data showloop2;
   * No error - but not what you think;
   * What happens when CNT=4?;
   /*cnt=4;*/
   do count=1 to 3, cnt=4 to 8 by 2;
      output showloop2;
   end;
   run;
proc print data=showloop2;
   run;

data _null_;
do month = 'Jan', 'Feb', 'Mar';
   put month=;
end;
run;
