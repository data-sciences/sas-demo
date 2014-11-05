* E3_6_6.sas
* 
* Other functions;

title1 '3.6.6 Using Other Functions';
*****************************************;
title2 'ARCOS and CONSTANT';
data ;
pi1 =arcos(-1);
pi2 = constant('pi');
put pi1=;
put pi2=;
run;

****************************************;
* Count the words in a list;
proc sql noprint;
select lname
   into :namelist separated by '/'
      from advrpt.demog(where=(lname=:'S'));
quit;
%put &namelist;
%put the number of names is %sysfunc(countw(&namelist,/));

*****************************************;
* DIM Function;
proc sql noprint;
select lname
   into :namelist separated by ' '
      from advrpt.demog(where=(lname=:'S'));
quit;
%macro wcount(list);                                                             
%* Count the number of words in &LIST;                                       
%global count;                                                                            
   data _null_;                                                                
      array nlist{*} &list;               
      call symputx('count', dim(nlist));                                                      
      run;                                                                                                                                    
%mend wcount;
%wcount(&namelist)
%put The total number of words in &namelist is: &count;
*****************************************;
* Geometric mean to calculate nth roots;
title2 'GEOMEAN';
data roots;
do x = 0 to 30 by 5;
   root2 = sqrt(x);
   nth2  = x**(1/2);
   g2    = geomean(x,1);
   nth3  = x**(1/3);
   g3    = geomean(x,1,1);
   nth4  = x**(1/4);
   g4    = geomean(x,1,1,1);
   output;
end;
run;
proc print data=roots;
run;
      

****************************************;
title2 'IFC and IFN';
data generation;
   set advrpt.demog(keep=lname fname dob);
   length generation $10;
   if year(dob) = . then generation='Unknown';
   else if year(dob) lt 1945 then generation= 'Greatest';
   else if year(dob) ge 1945 then generation = 'Boomer';
   run;

data generation2;
   set advrpt.demog(keep=lname fname dob);
   length generation $10;
   generation =ifc(year(dob)*(year(dob) ge 1945),'Boomer','Greatest','Unknown');
   run;
proc print data=generation2;
run;




****************************************;
title2 'FINDC';
* Code suggested by @Patrick;
data lists; 
input list $; 
datalines;
A
A,B
A,B,C
A,B,C,D
A,B,C,D,
run;

data shorter;
   set lists;
   commaloc=findc(list, ',','b',-length(list)) ; 
   *newlist = ifc(commaloc,substr(list,1,commaloc-1),list);
   if commaloc=0 then newlist=list;
   else newlist=substr(list,1,commaloc-1);
run;

proc print data=shorter;
run;
*********************;
data listloc (keep=id cnt position);
  informat id $30.;
  input id;
  delimiter='!';
  cnt=0;
  position=0;
  do until(position=0);
    position=findc(id,delimiter,position+1);
/*    if position ne 0 then cnt+1;*/
    cnt+ ^^position;
    if cnt=0 or position ne 0 then output listloc;
  end;
cards;
1!2!3445!!!
!!!
123
run;

proc print data=listloc;
   run;

****************************************;
title2 'ROUND';
data wtgroup;
   set advrpt.demog(keep=lname fname wt);
   wtgroup = round(wt,50);
   run;
proc print data=wtgroup;
run;

****************************************;
title2 'Using SCAN with the Q & R modifiers';
data locations;
autoloc = " 'c:\my documents' 'c:\temp' sasautos";
do i = 1 to 3;
   woq = scan(autoloc,i,' ');
   wq  = scan(autoloc,i,' ','q');
   wqr = scan(autoloc,i,' ','qr');
   output locations;
end;
run;
proc print data=locations;
run;
****************************************;
title2 'Using SUBSTR to Insert Characters';
data conmed200(keep=subject medstdt_);
   set advrpt.conmed(where=(subject='200'));
   if substr(medstdt_,1,2)='XX' then substr(medstdt_,1,2)='01';
   if substr(medstdt_,4,2)='XX' then substr(medstdt_,4,2)='15';
   run;
proc print data=conmed200;
   run;
proc format ;
   value $moconv
   'XX', 'xx' = '06'
   'LL', 'll' = '01'
   'ZZ', 'zz' = '12';
   run;

data conmed204(keep=subject medstdt_);
   set advrpt.conmed(where=(subject='204'));
   if anyalpha(substr(medstdt_,1,2)) then substr(medstdt_,1,2)=put(substr(medstdt_,1,2),$moconv.);
   run;
proc print data=conmed204;
   run;
*****************************************;
title2 'Using WHICHN to check Visit Order';
data Visitdates(keep=subject date visit note);
   set advrpt.lab_chemistry;
   by subject;
   array dates {16} _temporary_;
   array maxvis {3} _temporary_;
   if first.subject then call missing(of dates{*});
   * Save dates;
   dates{visit} = labdt;
   if last.subject then do i = 1 to 3;
      date = largest(i,of dates{*});
      visit = whichn(date,of dates{*});
      if i=1 then do;
         call missing(of maxvis{*});
         note=' ';
      end;
      else if visit>=min(of maxvis{*}) then note='*';
      else note=' ';
      output visitdates;
      maxvis{i}=visit;
   end;
   format date date9.;
   run;
proc print data=visitdates;
   run;
