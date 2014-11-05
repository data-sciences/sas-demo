
%LET JES = c:\JES\;
%PUT JES=&JES;
%INCLUDE "&JES.sas_code\hello_world.sas";
LIBNAME JES "&JES.sas_data";
