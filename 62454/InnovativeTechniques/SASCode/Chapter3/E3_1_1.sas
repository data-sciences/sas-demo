* E3_1_1.sas
* 
* Using FIRST and LAST processing;

title1 '3.1.1 Using FIRST. and LAST. Processing';

* DEMOG contains clinnum but not region;
proc sort data=advrpt.demog(keep=clinnum ssn)
          out= clinics
          nodupkey;
by clinnum ssn;
run;

* Merge on the region number;
data regions;
   merge clinics
         advrpt.clinicnames(keep=clinnum region);
   by clinnum;
   run;

proc sort data=regions;
   by region clinnum;
   run;

data showfirstlast;
   set regions;
   by region clinnum;
   FirstRegion = first.region;
   LastRegion = last.region;
   FirstClin = first.clinnum;
   LastClin = last.clinnum;
   run;

title2 'Show FIRST. and LAST. Values';
proc print data=showfirstlast;
   var region clinnum ssn firstregion lastregion firstclin lastclin;
   run;

data counter(keep=region clincnt patcnt);
   set regions(keep=region clinnum);
   by region clinnum;
   if first.region then do;
      clincnt=0;
      patcnt=0;
   end;
   if first.clinnum then clincnt + 1;
   patcnt+1;
   if last.region then output;
   run;

title2 'Region and Clinic Counts';
proc print data=counter;
   run;

**********************************
title2 'show lower level changes';
*Example to show low level changes;
data silly;
input unit $ part $;
datalines;
A w 
A x 
B x 
B x 
C x 
run;
data show;
   set silly;
   by unit part;
   FirstUnit = first.unit;
   LastUnit = last.unit;
   FirstPart = first.part;
   LastPart = last.part;
   run;
proc print data=show;
   var unit part firstunit lastunit firstpart lastpart;
   run;

