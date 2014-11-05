/*-------------------------------------------------------------------------------------------
Daten
-------------------------------------------------------------------------------------------*/

data basis;
 set sampsio.hmeq 
	sampsio.hmeq 
	sampsio.hmeq 
    sampsio.hmeq
sampsio.hmeq 
	sampsio.hmeq 
	sampsio.hmeq 
    sampsio.hmeq
sampsio.hmeq 
	sampsio.hmeq 
	sampsio.hmeq 
    sampsio.hmeq
sampsio.hmeq 
	sampsio.hmeq 
	sampsio.hmeq 
    sampsio.hmeq
;
if _N_ le 60000;
 run;



DATA NewObs;
 AGE = 35;
 Weight = 81;
 Runtime = 11.6;
 OUTPUT;
 AGE = 55;
 Weight = 91;
 Runtime = 12.6;
 OUTPUT;
 AGE = 25;
 Weight = 61;
 Runtime = 9.6;
 OUTPUT;
RUN;




/*-------------------------------------------------------------------------------------------
Section 22.3
 -------------------------------------------------------------------------------------------*/

DATA SAMPLE;
 SET BASIS;
 IF RANUNI(123) < 0.1 THEN OUTPUT;
RUN;


DATA SAMPLE;
 SET BASIS;
 IF RANUNI(123) < 6000/60000 THEN OUTPUT;
RUN;



DATA SAMPLE_FORCE;
 SET BASIS;
 IF smp_count < 6000 THEN DO;
  IF RANUNI(123)*(60000 - _N_) <= (6000 - smp_count) THEN DO;
      OUTPUT;
      Smp_count+1;
  END;
 END;
RUN;





%RestrictedSample(data = sampsio.hmeq,sampledata=hmeq_2000,n=2000);



/*-------------------------------------------------------------------------------------------
Section 22.4
-------------------------------------------------------------------------------------------*/

DATA oversample1;
 SET sampsio.hmeq;
 IF bad = 1 or 
    bad = 0 and RANUNI(44) <= 0.5 THEN OUTPUT;
RUN;


%let eventrate = 0.1995;
DATA oversample2;
 SET sampsio.hmeq;
IF bad = 1 or
   bad = 0 and (&eventrate*100)/(RANUNI(34)*(1-&eventrate) 
               +&eventrate) > 25 THEN OUTPUT;
RUN;






DATA hmeq;
 SET sampsio.hmeq;
 %SamplingVar(eventrate=0.1995,eventvar=bad);
RUN;



PROC FREQ DATA = hmeq;
 TABLE bad;
 WHERE sampling > 30;
RUN;



/*-------------------------------------------------------------------------------------------
Section 22.5
-------------------------------------------------------------------------------------------*/

%Clus_Sample (data = sampsio.assocs , outsmp=assoc_smp,
               id =customer, prop = 0.1, n=, seed=12345 );





%Clus_Sample_Res (data = sampsio.assocs , outsmp=assoc_smp,
               id =customer, prop = 0.1, n=, seed=12345 );



PROC SQL;
 SELECT COUNT(DISTINCT customer)
 FROM assoc_smp;
QUIT;






DATA prdsal2;
 SET sashelp.prdsal2;
 ID = CATX('_',state,product);
RUN;

PROC SORT DATA = prdsal2;
 BY ID;
RUN;

%Clus_sample_Res ( data = prdsal2,outsmp = prd_smp,n=25,id=id);


PROC SQL;
 SELECT COUNT(DISTINCT ID)
 FROM prd_smp;
QUIT;
