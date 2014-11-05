* E14_2.sas
*
* Using an AUTOEXEC program;
title1 '14.2 Using AUTOEXEC.SAS';

***************************
* Autoexec.sas
*
* specify the path, libref, and options for the examples for this book;

%let path = &sysparm\InnovativeTechniques;
libname advrpt v9 "&path\Data";
filename advmac "&path\sascode\sasmacros";
options nodate nonumber nocenter;
options sasautos=(advmac, sasautos);
