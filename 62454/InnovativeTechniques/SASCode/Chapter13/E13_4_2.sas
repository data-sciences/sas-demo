* E13_4_2.sas
* Tracing an autocall macro location;

filename mymacs "&path\sascode\sasmacros";
options mautosource
        sasautos=(mymacs sasautos)
        mautolocdisplay;

%put There are %obscnt(sashelp.shoes) obs in sashelp.shoes;

