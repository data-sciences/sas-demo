

%INCLUDE "&JES.sample_code/ch_2/sort_merge.sas";
PROC DATASETS LIBRARY=WORK;
	CONTENTS DATA=Units_U;
QUIT;

/*===========================================================
Delete the Dups data set, and any data set beginning with
'F' or 'f', in the WORK library
============================================================*/
PROC DATASETS LIBRARY=WORK; DELETE Fa: Units_U; QUIT;
/*===========================================================
Delete all data sets in the WORK library
============================================================*/
PROC DATASETS LIBRARY=WORK MEMTYPE=DATA GENNUM=ALL KILL; QUIT;
