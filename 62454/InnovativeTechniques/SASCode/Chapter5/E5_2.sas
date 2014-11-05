* E5_2.sas
*
* Reordering variables on the PDV;

title1 '5.2 Reordering Variables on the PDV';
Proc contents data=advrpt.demog
   varnum;
   run;

* Use the LENGTH statement;
data demog2(keep=subject lname fname sex ht wt dob symp);
   length lname $10 fname $6 sex $1 symp $2;
   set advrpt.demog(keep=subject lname fname sex edu death ht wt dob symp);
   where death and edu>15;
   run;

proc print data=demog2;
   run;

* Use the RETAIN instead of LENGTH statement;
data demog2b(keep=subject lname fname sex ht wt dob symp);
   retain lname fname sex symp;
   set advrpt.demog(keep=subject lname fname sex edu death ht wt dob symp);
   where death and edu>15;
   run;

proc compare data=demog2 compare=demog2b;
   run;

* Verify that other statements can control order;
data demog3;
   format dob date9.;
   retain sex ' ';
   rename ht=height; /* this does not*/
   informat death date9.;
   label wt = 'Weight';
   attrib edu length=8;
   set advrpt.demog(keep=subject lname fname sex edu death ht wt dob symp);
   run;
proc print data=demog3;
   run;

***************************
* Control variable order using SQL;
proc sql ;
create table demog4 as 
   select lname, fname, sex, symp, subject, dob, wt, ht
      from advrpt.demog(keep=subject lname fname sex edu death ht wt dob symp)
        where death and edu>15;
select *
   from demog4;
quit;
