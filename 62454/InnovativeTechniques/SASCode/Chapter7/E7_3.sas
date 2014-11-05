* E7_3.sas
* 
* Specifying Statistics;

title1 '7.3 Stat=';
proc summary data=advrpt.demog;
   class race;
   var ht wt;
   output out=stats
          n = n_ht n_wt
          mean= meanHT MeanWT
          ;
   run;
proc print data=stats;
   run; 

title1 '7.3 Stat(varlist)=';
proc summary data=advrpt.demog;
   class race;
   var ht wt;
   output out=stats
          n(wt) = n_wt
          mean(wt ht) = mean_WT Mean_HT
          ;
   run;
proc print data=stats;
   run;

title1 '7.3 Splitting the Stat(varlist)=';
proc summary data=advrpt.demog;
   class race;
   var ht wt;
   output out=stats
          n(wt) = n_wt
          mean(wt) = mean_WT
          n(ht) = n_ht
          mean(ht) = Mean_HT
          ;
   run;
proc print data=stats;
   run; 

