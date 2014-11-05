* E14_1_3.sas
*
* Saving system option settings;

title '14.1.3 Saving System Options';

***********************************
* using procedures OPTSAVE and OPTLOAD;
proc optsave out=advrpt.current_settings;
   run;

title2 'Options saved using PROC OPTSAVE';
proc print data=advrpt.current_settings;
   run;
options sasautos=adv;
proc options option=sasautos;
   run;
proc optload data=advrpt.current_settings(where=(optname='SASAUTOS'));
   run;
proc options option=sasautos;
   run;
   
***********************************
* using DMOPTSAVE and DMOPTLOAD commands;
title2 'Options saved using DMOPTSAVE';
dm 'dmoptsave advrpt.current_settings';
options sasautos=adv2;
proc options option=sasautos;
   run;
dm "dmoptload advrpt.current_settings(where=(optname='SASAUTOS'))";
   run;
proc options option=sasautos;
   run;
