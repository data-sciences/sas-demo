* E7_9.sas
* 
* Using the CLASSDATA and EXCLUSIVE Options;

title1 '7.9 Using the CLASSDATA and EXCLUSIVE Options';
data selectlevels(keep=race edu symp);
   set advrpt.demog(where=(race in('1','4')
                         & 12 le edu le 15
                         & symp in('01','02','03')));
   output;
   * For fun add some nonexistent levels;
   if _n_=1 then do;
      edu=0;
      race='0';
      symp='00';
      output;
      end;
   run;

title2 'CLASSDATA without EXCLUSIVE';
proc summary data=advrpt.demog
             classdata=selectlevels;
   class race edu symp;
   var ht;
   output out=stats mean= meanHT;
   run;

proc print data=stats;
   run;


title2 'CLASSDATA with EXCLUSIVE';
proc summary data=advrpt.demog
             classdata=selectlevels
             exclusive;
   class race edu symp;
   var ht;
   output out=stats mean= meanHT;
   run;

proc print data=stats;
   run;


* Sorting the classdata data set is 
* not necessary.  The following is 
* just to show the data;
title2 'Show the SELECTLEVELS Data';
proc sort data=selectlevels nodupkey;
   by race edu symp;
   run;
proc print data=selectlevels;
   run;
