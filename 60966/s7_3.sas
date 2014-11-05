* S7_3.sas
*
* Using the BEFORE and AFTER locations;

proc format;
   * Create PNDS.
   * Used to formulate the weight groups of interest.; 
   value pnds
         low-<100 = ' < 100'
         100-<200 = '100-< 200'
         200-<300 = '200-< 300'
         300-high = '300 and over';
   value $gender
     'M'='Male' 
     'F'='Female';
   run;

title1 'Extending Compute Blocks';
title2 'Using BEFORE and AFTER';

ods pdf file="&path\results\ch7_3.pdf" style=printer;
proc report data=rptdata.clinics nowd 
            out=outpct split='*';
   column sex wt wt=wtn percnt tpercnt;
   define sex      / group  format=$gender6. 'Gender' ;
   define wt       / group  format=pnds.     'Weight'
                     order=formatted ;
   define wtn      / analysis n format=2.    'N';  
   define percnt   / computed   format=percent8.  
                      'Percent*by Sex';
   define tpercnt  / computed format=percent8.  
                      'Percent*Total';
   compute before;  
      * Total number of Patients;
      totcount = wtn;
   endcomp;

   compute before sex;  
      * Total number within gender group;
      count = wtn;
   endcomp;

   compute percnt;  
      * percent within weight group;
      percnt= wtn/count;
   endcomp;
   compute tpercnt;  
      * Total percent within weight group;
      tpercnt= wtn/totcount;
   endcomp;

   * Percent count for summary after SEX; 
   compute after sex;  
      percnt= wtn/count;
      tpercnt= wtn/totcount;
   endcomp;
   break after sex / suppress summarize dol skip;
 
   * Percent count for summary after the report 
   * (across SEX);
   compute after;  
      percnt= .;
      tpercnt= wtn/totcount;
   endcomp;
   rbreak after / summarize dol;
   run;

title3 'Final Report Rows';
proc print data=outpct;
   run;
ods pdf close;
