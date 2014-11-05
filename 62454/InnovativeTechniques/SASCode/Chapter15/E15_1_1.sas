*E15_1_1.sas
*
* Customizing ERRORS, WARNINGS, and NOTES;

%PUT NOTE: if not locked the CLEAR gives an error;
lock sashelp.class clear;

%put NOTE: sashelp.class should be unlocked;
lock sashelp.class query;

lock sashelp.class;
%put NOTE: class should be locked;
lock sashelp.class query;

lock sashelp.class clear;
%put NOTE: class should be unlocked;
