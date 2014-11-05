* E12_6.sas
* 
* Using the ANYDATE Informats;

title1 '12.6 ANYDATE Informats';

***********************************************;
options datestyle=mdy;
data new;
input date anydtdte10.;
format date date9.;
datalines;
01/13/2003
13/01/2003
13jan2003
13jan03
13/01/03
01/02/03
03/02/01
run;
title2 'Reading Mixed Date Values';   
proc print data=new; 
   run;

***********************************************;
* Converting mixed DATETIME Values;
title2 'Converting Mixed DATETIME Values';
data mixed;
   length daytime $30;
   daytime = '10/13/2011:15:45:12'; output mixed;
   daytime = '2011-03-01T15:20:45'; output mixed;
   daytime = '9/13/2011 11:52:54 AM'; output mixed;
   daytime = '9/13/2011 11:52:54 PM'; output mixed;
   daytime = '13/09/2011 11:52:54 PM'; output mixed;
   daytime = '11/09/12 11:52:54 AM'; output mixed;
   daytime = '2011/09/12 11:52:54 PM'; output mixed;
   run;
data dtvalues;
   set mixed;
   dt_plus= input(daytime,anydtdtm.)+12*60*60*(^^index(upcase(daytime),'PM'));
   dt_any = input(daytime,anydtdtm.);
   dt_AMPM= input(daytime,mdyampm.);
/*   dt_ydm = input(daytime,ymddttm.);*/
   format dt: datetime19.;
   run;
proc print data=dtvalues;
   run;


