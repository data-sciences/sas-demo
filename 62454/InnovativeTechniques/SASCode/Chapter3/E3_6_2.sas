* E3_6_2.sas
* 
* Using the COMPare functions;

title1 '3.6.2 Using COMPARE and COMPGED';

data metals(sortedby=name);
length name $9;
input name $;
datalines;
arsenic 
aluminium
barium
cadmium
chromium
copper
iron
lead
mercury
zinc
run;

* make some name variations;
data namelist(keep=name datname value);
   set metals;
   * Create a random value to simulate data;
   value = 25*ranuni(0);
   datname=name;
   output namelist;
   datname = translate(name,'k','c');output namelist;
   datname = translate(name,'n','m');output namelist;
   datname = tranwrd(name,'ea','ae');output namelist;
   datname = tranwrd(name,'ae','ea');output namelist;
   run;

****************************************;
* show some results of various comparison functions;
data compvalues(keep=name datname c_:);
   array metals {10} $9 _temporary_ ;
   * Load the names ;
   do until(done);
      set metals end=done;
      cnt+1;
      metals{cnt} = name;
   end;
   * compare each data value with each name;
   * Output one observation for each pair of values;
   do until(datdone);
      set namelist end=datdone;
      do i = 1 to 10;
         name = metals{i};
         c_compare = compare(name,datname);
         c_spedis  = spedis(name,datname);
         c_compged = compged(name,datname);
         c_complev = complev(name,datname);
         output compvalues;
      end;
   end;
   stop;
   run;

proc sort data=compvalues nodupkey;
   by name c_compged datname;
   run;
title2 'show costs for various comparison functions';
proc print data=compvalues;
   run;

****************************************;
* find mismatches;
proc sort data=namelist nodupkey;
   by datname;
   run;

* Match names in the data with correct spellings;
data perfect (keep=datname value)
     potential(keep=datname name value mincost);
   array metals {10} $9 _temporary_ ;
   * Load the names ;
   do until(done);
      set metals end=done;
      cnt+1;
      metals{cnt} = name;
   end;
   
   do until(datdone);
      set namelist(keep=datname value) end=datdone;
      mincost=9999999;
      do i = 1 to 10;
         cost = compged(datname,metals{i},'il');
         if cost=0 then do;
            output perfect;
            goto gotit;
         end;
         else if cost lt mincost then do;
            mincost=cost;
            name = metals{i};
         end;
      end;
      output potential;
      gotit:
   end;
   stop;
   run;

title2 'name matches - not too interesting';
proc print data=perfect;
   run;

title2 'Potential match values';   
proc print data=potential;
   run;
