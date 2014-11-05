
%INCLUDE "&JES.utility_macros/delvars.sas";

/*===== lines to add to your autoexec.sas =====*/
%LET JES=c:\JES\; /* Use the path to your JES folder */
LIBNAME JES "&JES.sas_data";

FILENAME jesautos "&JES.utility_macros";
/*=== you may need these lines for UNIX ====
 %let SASROOT =/(location of your sasautos)/;
 FILENAME SASAUTOS "&SASROOT.sasautos";
===========================================*/
OPTIONS MAUTOSOURCE SASAUTOS=(SASAUTOS, jesautos);
%check_autocall;
