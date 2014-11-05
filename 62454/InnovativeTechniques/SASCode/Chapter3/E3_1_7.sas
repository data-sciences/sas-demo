* E3_1_7.sas
* 
* Creating a Stack;

title1 '3.1.7 Creating a Stack';
proc sort data=advrpt.lab_chemistry(keep=subject visit labdt potassium)
           out= labdates
           nodupkey;
   by subject labdt;
   run;

* Three visit running average for potassium;
data Average(keep=subject visit labdt potassium Avg3day);
   set labdates;
   by subject;

   * dimension of array is number of items to be averaged;
   retain temp0-temp2 
          visitcnt .;
   array stack {0:2} temp0-temp2;
   if first.subject then do;
      do i = 0 to 2 by 1;
         stack{i}=.;
      end;
      visitcnt=0;
   end;
   visitcnt+1;
   index = mod(visitcnt,3);
   stack{index} = potassium;
   avg3day = mean(of temp:);
   run;

title2 'Using a FIFO stack';
proc print data=average;
   run;
