* Autoexec.sas
*
* specify libref and path for examples and data;

%let path = &sysparm\InnovativeTechniques;
filename advmac "&path\sascode\sasmacros";
libname advrpt v9 "&path\Data";
options nodate nonumber nocenter;
options sasautos=(advmac, sasautos);

