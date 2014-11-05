* E13_2_2.sas
* 
* Using SYMPUTX to create macro variable with a name unknown
* at the time of coding;

title1 '13.2.2 Creating Unknown Macro Variable Names';

%macro ScalePos(hvscale=2.5);
data _null_;
   set sashelp.vgopt(keep=optname setting);
   where optname in('HPOS','VPOS');

   * In SAS9.3 these two options might be initialized as blank;
   * Set values to a windows standard default;
   if optname='HPOS' and setting = ' ' then setting='149';
   if optname='VPOS' and setting = ' ' then setting='43';
   call symputx(optname,setting,'g');
   run;

goptions hpos=%sysevalf(&hpos * &hvscale)
         vpos=%sysevalf(&vpos * &hvscale);
%mend scalepos;

goptions reset=all dev=win;
title2 'xPOS before scaling';
proc print data=sashelp.vgopt(where=(optname in('HPOS','VPOS')));
   var optname setting;
   run;

%scalepos(hvscale=1.5)
title2 'xPOS After scaling';
proc print data=sashelp.vgopt(where=(optname in('HPOS','VPOS')));
   var optname setting;
   run;
%* Use scaled values here;

%* When task using scaled values is complete;
%* Reset to original values;
goptions hpos=&hpos vpos=&vpos;
