
%LET JES = c:\JES\;
%PUT JES=&JES;
%INCLUDE "&JES.sas_code/hello_world.sas";

LIBNAME JES "&JES.sas_data";
FILENAME jesautos "&JES.utility_macros";
OPTIONS MAUTOSOURCE SASAUTOS=(SASAUTOS, jesautos);
%check_autocall
