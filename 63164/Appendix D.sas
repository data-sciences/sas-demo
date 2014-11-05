/*****************************************************************************
***  Programs for the Book "Data Quality for Analytics Using SAS"
***  Download Version 1.0 - May, 22nd 2012
***  Dr. Gerhard Svolba
***
***  Report any problems and questions for the programs to the author:
***  mail: sastools.by.gerhard@gmx.net
***
******************************************************************************/

data air;
 set sashelp.air;
 tsid = 1;
run;


%ts_history_check(data=air,tsid=tsid,y=air,
                  timeid=date,interval=month,
                  minhist=6,maxhist=36,
                  shiftfrom=0,shiftto=2,shiftby=2,
                  periodvalid=12,
                  mrep=sashelp.hpfdflt,sellist=tsfsselect, 
                  stat=mape,aggrstat=median);
