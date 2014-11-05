/*****************************************************************************
***  Programs for the Book "Data Quality for Analytics Using SAS"
***  Download Version 1.0 - May, 22nd 2012
***  Dr. Gerhard Svolba
***
***  Report any problems and questions for the programs to the author:
***  mail: sastools.by.gerhard@gmx.net
***
******************************************************************************/


data class_5_obs;
 set sashelp.class(obs=5);
 retain seed1 123;
 call ranuni(seed1,RND_Fixed);
 retain seed2 0;
 call ranuni(seed2,RND_Flexible);
 call ranuni(seed2,RND_Flexible2);
 keep name rnd_fixed rnd_flexible rnd_flexible2;
run;
proc print; run;

