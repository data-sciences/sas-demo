*E12_3_2.sas
*
* Using MLF for calculating rolling averages;

title1 '12.3.2 Using MLF for Calculating Rolling Averages';
data control(keep=fmtname start end label hlo);
      retain fmtname 'avg'
             hlo 'M';
      do start=1 to 14;
         end=start+2; 
        label=cats('VisitGrp', put(start,z2.));
        output Control;
      end; 
      hlo='O'; 
      label='Unknown';
      output;
run;

proc format cntlin=control; 
   run;
proc print data=control;
   run;
*****
* Effectively the AVG. format is defined as;
/*
proc format;
   value avg (multilabel)
      1 - 3 = 'VisitGrp01'
      2 - 4 = 'VisitGrp02'
      3 - 5 = 'VisitGrp03'
      4 - 6 = 'VisitGrp04'
      5 - 7 = 'VisitGrp05'
      6 - 8 = 'VisitGrp06'
      7 - 9 = 'VisitGrp07'
      8 - 10= 'VisitGrp08'
      9 - 11= 'VisitGrp09'
      10- 12= 'VisitGrp10'
      11- 13= 'VisitGrp11'
      12- 14= 'VisitGrp12'
      13- 15= 'VisitGrp13'
      14- 16= 'VisitGrp14'
      other = 'Unknown';
   run;
*/



proc summary data=advrpt.lab_chemistry;
   by subject;
   class visit / mlf; 
   format visit avg.;
   var potassium;
   output out=rollingAVG 
          mean= Avg3Potassium;
   run;
proc print data=rollingavg(where=(subject='201'));
   run; 
proc print data=advrpt.lab_chemistry(where=(subject='201'));
   run; 

