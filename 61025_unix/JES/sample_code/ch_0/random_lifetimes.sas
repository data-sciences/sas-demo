
/*======================================================
JES.LifeTest
JES.Repair
=======================================================*/

%MACRO Acc_Lifetest_Data;
	PROC DATASETS LIBRARY=WORK GENNUM=ALL NOLIST;
        DELETE Chi: Dual: Emp: Lifetest;
	RUN; QUIT;
	%LET EA = 1.2; %LET TU=90; %LET T1 = 120; %LET T2=140; %LET T3=160; %PUT &T1;

	DATA _NULL_;
		TU=&TU; T1=&T1; T2=&T2; T3=&T3; EA=&EA;
		AF1=EXP( EA*(  (11605/(273.15+TU)) - (11605/(273.15+T1)) ) );
		CALL SYMPUT('AF1', AF1);
		AF2=EXP( EA*(  (11605/(273.15+TU)) - (11605/(273.15+T2)) ) );
		CALL SYMPUT('AF2', AF2);
		AF3=EXP( EA*(  (11605/(273.15+TU)) - (11605/(273.15+T3)) ) );
		CALL SYMPUT('AF3', AF3);
	RUN;
	%PUT AF1=&AF1 AF2=&AF2 AF3=&AF3;
	
	%Rand_Weibull(123457, 100, 100, 20000, 1.5, 150, 150, Chi_120, 
		SEEDR=12345, Mean=20, Sigma= 3, Repair=NO, Class_Name=Temp, Class=120, ACC=&AF1); 
	%Rand_Weibull(123457, 100, 500, 20000, 1.5, 150, 150, Chi_140, 
		SEEDR=23456, Mean=20, Sigma= 3, Repair=NO, Class_Name=Temp, Class=140, ACC=&AF2); 
	%Rand_Weibull(123457, 100, 800, 20000, 1.5, 150, 150, Chi_160, 
		SEEDR=34567, Mean=20, Sigma= 3, Repair=NO, Class_Name=Temp, Class=160, ACC=&AF3); 
	DATA Chi; LENGTH Vendor $10.; SET Chi_120 Chi_140 Chi_160; Vendor="ChiTronix"; RUN;

	%Rand_Weibull(123457, 100, 1000, 80000, 1, 150, 150, Dual_120, 
		SEEDR=45678, Mean=16, Sigma= 2, Repair=NO, Class_Name=Temp, Class=120, ACC=&AF1); 
	%Rand_Weibull(123457, 100, 1500, 80000, 1, 150, 150, Dual_140, 
		SEEDR=56789, Mean=16, Sigma= 2, Repair=NO, Class_Name=Temp, Class=140, ACC=&AF2); 
	%Rand_Weibull(123457, 100, 1800, 80000, 1, 150, 150, Dual_160, 
		SEEDR=67890, Mean=16, Sigma= 2, Repair=NO, Class_Name=Temp, Class=160, ACC=&AF3); 
	DATA Dual; SET Dual_120 Dual_140 Dual_160; Vendor="Duality"; RUN;

	%Rand_Weibull(7, 100, 2000, 120000, 1, 150, 150, Emp_120, 
		SEEDR=78901, Mean=12, Sigma= 2, Repair=NO, Class_Name=Temp, Class=120, ACC=&AF1); 
	%Rand_Weibull(123457, 100, 2300, 120000, 1, 150, 150, Emp_140, 
		SEEDR=89012, Mean=12, Sigma= 2, Repair=NO, Class_Name=Temp, Class=140, ACC=&AF2); 
	%Rand_Weibull(123457, 100, 2600, 120000, 1, 150, 150, emp_160, 
		SEEDR=90123, Mean=12, Sigma= 2, Repair=NO, Class_Name=Temp, Class=160, ACC=&AF3); 
	DATA Emp; SET Emp_120 emp_140 Emp_160; Vendor="Empirical"; RUN;

	DATA LifeTest; SET Chi Dual Emp; Temp_C = INPUT(Temp, 8.0); 
		TestTime=CEIL(TestTime);
		DROP TstopMax Tstop Temp; 
	RUN;
	
	PROC SORT DATA=LifeTest; BY SN ; RUN;
	PROC DATASETS LIBRARY=WORK GENNUM=ALL NOLIST;
        DELETE Chi: Dual: Emp: Temp ShipFail;
	RUN; QUIT;
%MEND Acc_Lifetest_Data;

%MACRO Repair_Data;
	PROC DATASETS LIBRARY=WORK GENNUM=ALL NOLIST;
        DELETE Chi Dual Emp Temp ShipFail FieldFails;
	RUN; QUIT;
	%Rand_Weibull(123457, 1000, 1000, 1000, 1.5, 200, 500, Chi, Repair=YES, Class_Name=Vendor, Class=ChiTronix); 
	%Rand_Weibull(234567, 1000, 5000, 10000, 1, 200, 500, Dual, Repair=YES, Class_Name=Vendor, Class=Duality); 
	%Rand_Weibull(345678, 1000, 7000, 5000, .6, 200, 500, Emp, Repair=YES, Class_Name=Vendor, Class=Empirical); 
	DATA Repair; SET Chi Dual Emp; 
		FORMAT Start Stop EventDate DATE9. EventTime 8.0;
		Stop='13AUG2008'd;
		Tstop=CEIL(Tstop);
		Start=Stop-Tstop; 
		FieldTime=CEIL(FieldTime);
		EventDate=Start+FieldTime; 
		EventTime=EventDate-Start;
		Cens=Censor;
		KEEP Vendor SN Cens Start Stop EventDate EventTime;
	RUN;
	DATA Repair; SET Repair; Censor=CEns; DROP Cens; RUN;
	PROC SORT DATA=Repair; BY SN EventTime; RUN;
	PROC DATASETS LIBRARY=WORK GENNUM=ALL NOLIST;
        delete Chi Dual Emp Temp ShipFail;
	RUN; QUIT;
%MEND Repair_Data;

%MACRO First_Fail(SEED, All, D, B, SEEDR=12345, Mean=20, Sigma=0);
    proc datasets library=work gennum=all NOLIST;
        delete temp: ;
    quit;
	data temp; set &All(drop=Tfail Seed Seedr where=(Flag=1) ); retain Seed &seed SeedR &SeedR;
		D=&D; Mean=&Mean; Sigma=&Sigma;
		CALL RANNOR(SEEDR, Z);
		Resistance = Mean + Sigma*Z;
		A=(exp(Resistance/3))/(EXP(Mean/3));
		call ranuni(Seed,U);   
		R=exp(-(Tstart/(D))**&B); 
		format Tfail 8.1;
		/* Tfail=&D*(  (-log(U*R))**(1/&B)  ); */
		Tfail=D*A*(  (-log(U*R))**(1/&B)  );
		Nfail=Nfail+1;
		FORMAT TestTime 8.0;
		TestTime=Tstop; Censor=-1;
		IF Tfail<Tstop THEN DO;
			TestTime=Tfail;
			Censor=1;
		END;
		Tstart=Tfail;
		CALL SYMPUT('theSeed', seed);
	run;
	%put theSeed=&theSeed;
	data &All; set Temp; 
		KEEP &Class_Name SN TestTime Censor Tstop TStopMax;
	run;
%MEND First_Fail;

%MACRO Next_Fail(SEED, All, D, B);
    proc datasets library=work gennum=all NOLIST;
        delete temp: ;
    quit;
	data temp; set &All(drop=Tfail Seed where=(Flag=1) ); retain Seed &seed;
		call ranuni(Seed,U);   
		R=exp(-(Tstart/&D)**&B); 
		format Tfail 8.1;
		Tfail=&D*(  (-log(U*R))**(1/&B)  );
		Nfail=Nfail+1;
		if Tfail<Tstop;
		Tstart=Tfail;
		Censor=1;
		CALL SYMPUT('theSeed', seed);
	run;
	data &All; set &All; Flag=0; run;
	data &All; set &All Temp; run;
%MEND Next_Fail;

%MACRO rand_weibull(SEED, NumUnit, firstSN, D0,    B, TstopMin, TstopMax, Ship_Fail, 
	SEEDR=12345, Mean=20, Sigma=0, Repair=NO, Class_Name=Class_Name, Class=CLASS, ACC=1 );
	%put SEEDR=&SEEDR;
	%LET D=%SYSEVALF(&D0/&Acc); %PUT D = &D;
	data ShipFail; LENGTH &Class_Name $15. SN TestTime FieldTime Censor 8.0;
		&Class_Name="&Class";
		do I=1 to &NumUnit; 
			first=&firstSN;
			SN=first+I-1;
			TstopMin=&TstopMin;
			TstopMax=&TstopMax;
			NumUnit=&NumUnit;
			Tstart=0; 
			Tstop=TstopMin+round((I/NumUnit)*(TstopMax-TstopMin)); 
			Tfail=0; Nfail=0; 
			Censor=-1; Flag=1; 
			seed=SN; SEEDR=SN; output ShipFail; 
		end; 
	run;
	%IF "&Repair"="NO" %THEN %DO;
		%LET theSEED=&SEED; 
		%First_Fail(&theSEED, ShipFail, &D, &B, SEEDR=&SEEDR, Mean=&Mean, Sigma=&Sigma);
		data &Ship_Fail; set ShipFail; RUN;
	%END;
	%IF "&Repair"="YES" %THEN %DO;
		%let theSEED=&SEED; 
		%let iii=0;
  		%MORE: ;
    	%let iii=%sysevalf(1+&iii);
		%Next_Fail(&theSEED, ShipFail, &D, &B);
		proc sql noprint;
	   		select count(*) into :Num
	   		from ShipFail
	   		where Flag=1; quit;
		%put Num=&Num;
		%if &Num>0 %then %goto MORE;
	 	data &Ship_Fail; set ShipFail; drop Tstart Flag SEED U R NumUnit; run;
	 	DATA &Ship_Fail; SET &Ship_Fail;
			FORMAT FieldTime 8.0;
			IF Censor=-1 THEN FieldTime=Tstop;
			IF Censor=1 THEN FieldTime=Tfail;
		KEEP &Class_Name SN FieldTime Censor Tstop TstopMax;
		RUN;
	%END;
%MEND rand_weibull; 
%Acc_Lifetest_Data
%Repair_Data
DATA JES.LifeTest; SET LifeTest; RUN;
DATA JES.Repair; SET Repair; RUN;

PROC DATASETS LIBRARY=WORK GENNUM=ALL NOLIST;
        DELETE LifeTest Repair;
RUN; QUIT;

