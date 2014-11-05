* E3_8_1a.sas
* 
* Using NOBS and POINT;

title1 '3.8.1a Using NOBS= and POINT=';
*************************************************************;
* Select last 10 observations;
data lastfew;
   if obs ge 10 then do pt =obs-9 to obs by 1;
      set sashelp.class point=pt nobs=obs;
      output lastfew;
   end; 
   else put 'NOTE: Only ' obs ' observations.';
   stop;
   run;
proc print data=lastfew;
   run;

*************************************************************;
%macro rand_wo(dsn=,pcnt=0);
   * Randomly select observations from &DSN;
   data rand_wo(drop=cnt totl);
      * Calculate the number of obs to read;
      totl = ceil(&pcnt*obscnt);
      array obsno {10000} _temporary_;

      do until(cnt = totl);
         point = ceil(ranuni(0)*obscnt);
         if obsno{point} ne 1 then do;
            * This obs has not been selected before;
            set &dsn point=point nobs=obscnt;
            output;
            obsno{point}=1;
            cnt+1;
         end;
      end;
      stop;
      run;
%mend rand_wo;
%rand_wo(dsn=advrpt.demog,pcnt=.3)
