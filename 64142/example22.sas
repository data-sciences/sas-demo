/*
http://sww.sas.com/sww-bin/broker9?_service=appdev92&_program=ctntest.example22.sas&birthdate=27nov1964
*/

/* Rather than hardcoding this macro variable, assume it's passed in to the stored process */
/*
%let birthdate=27nov1964;
*/

ods listing close;
ods html body=_webout path=&_tmpcat (url=&_replay) rs=none style=minimal;

goptions cback=white;
goptions characters;
goptions device=png;
goptions border;

goptions gunit=pct htitle=5.5 htext=3.5 ctext=gray33 ftitle="albany amt" ftext="albany amt";
goptions xpixels=700 ypixels=375;

/* The value for the birthdate macro variable should be passed in as a parameter on the url */
/*
%let birthdate=27nov1964;
*/

/* 
convert the text date into a sas numeric date, and put it into a macro variable,
and also put today's date (and +/- 30 days) into macro variables.
*/
data foo;
bdate="&birthdate"d;
call symput('bdate',bdate);
today=today();
call symput('today',today);
startdate=today-30;
enddate=today+30;
call symput('startdate',startdate);
call symput('enddate',enddate);
run;

/* calculate the biorhythm values along the 3 lines for each date */
data mydata;
  length id $15;
  format date date9.;
  format value percentn7.0;
  d2r=(atan(1)/45);  /* degrees to radians conversion factor */
  do Date = &startdate to &enddate by 1;
   t=Date-&bdate; /* days since birth */
   /* similar to value=sin(2*pi * t/23) ... */
   Value = sin((t/23)*360*d2r); id='Physical'; output;
   Value = sin((t/28)*360*d2r); id='Emotional'; output;
   Value = sin((t/33)*360*d2r); id='Intellectual'; output;
  end;
run;

title1 "Biorhythm Chart";
title2 "For someone born &birthdate";

axis1 label=none order=(-1 to 1 by .50) value=(color=gray33 h=3.5) minor=none offset=(0,0);
axis2 label=none order=(&startdate to &enddate by 30) value=(color=gray33 h=3.5) minor=(number=29) offset=(0,0);

symbol1 color=red i=join value=none width=2;
symbol2 color=blue i=join value=none width=2;
symbol3 color=cx00ff00 i=join value=none width=2;

legend1 label=none position=(bottom center) across=3;

proc gplot data=mydata;
plot Value*Date=id /
 vref=(-.5 0 .5)
 cvref=(graydd black graydd)
 href=(&today)
 chref=(black)
 vaxis=axis1
 haxis=axis2
 legend=legend1
 cframe=white
 ;
run;

quit;
ods html close;
