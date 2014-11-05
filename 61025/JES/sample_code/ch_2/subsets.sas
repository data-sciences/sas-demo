

/* ============================
Select a Subset of Columns 
=============================*/

DATA Subset_1; SET JES.First;
	KEEP Batch Sample Result;
RUN;
DATA Subset_2; SET JES.First;
	DROP Resistance Fail Defects;
RUN;
DATA Subset_3; SET JES.First(KEEP=Batch Sample Result);
RUN;
DATA Subset_4; SET JES.First(DROP=Resistance Fail Defects);
RUN;


DATA Subset_5; SET JES.First(KEEP=Batch Sample Result RENAME=(Result=Outcome) );
RUN;


/*==========================
Select a Subset of Rows 
===========================*/
DATA Temp; SET JES.First(FIRSTOBS=8 OBS=10);
RUN;

DATA Temp_2; SET JES.First;
IF _N_ >= 8 AND _N_ <= 10;
RUN;

DATA LowRes HighRes; SET JES.First(WHERE=(Batch>=23)); 
	IF Result="Low Res" THEN OUTPUT LowRes;
	IF Result="High Res"  THEN OUTPUT HighRes;
RUN;



