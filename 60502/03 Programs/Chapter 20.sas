/*-------------------------------------------------------------------------------------------
Daten
-------------------------------------------------------------------------------------------*/
data test;
 input response gender $6.;
cards;
1 MALE
0 MALE
0 MALE
1 MALE
0 MALE
1 MALE
0 MALE
0 MALE
0 MALE
1 MALE
0 MALE
0 FEMALE
1 FEMALE
1 FEMALE
1 FEMALE
0 FEMALE
1 FEMALE
0 FEMALE
1 FEMALE
1 FEMALE
0 FEMALE
;
run;




data age;
 do AGE = 20 to 85;
  do rep = 1 to ranpoi(50,50);
     RESPONSE = abs((age-50)**2+500+rannor(44)*300)+700;
	 AGE_Qdr_Std = (age-50)**2;
     AGE_Qdr = age**2;
	 if age < 30 then Age_GRP = 1; 
	 else if age < 45 then Age_GRP = 2;
	 else if age < 55 then Age_GRP = 3;
	 else if age < 75 then Age_GRP = 4;
	 else Age_GRP = 5;
	 GRP1 = (Age_GRP = 1);
	 GRP2 = (Age_GRP = 2);
	 GRP3 = (Age_GRP = 3);
	 GRP4 = (Age_GRP = 4);
	 output;
  end;
 end;
run; 



data raw_data;
 set sampsio.hmeq;
 run;

/*-------------------------------------------------------------------------------------------
Section 20.1
-------------------------------------------------------------------------------------------*/

PROC MEANS DATA = test;
 CLASS gender;
 VAR response;
RUN;












%CreateProps(DATA=sampsio.hmeq,OUT_DS=work.hmeq,VARS=job,
             TARGET=bad,MV_BASELINE=NO);


%CreateProps(DATA=sampsio.hmeq,OUT_DS=work.hmeq,VARS=job,
             TARGET=bad,MV_BASELINE=YES);






PROC RANK DATA = sampsio.hmeq OUT = ranks GROUPS = 10;
 VAR value;
 RANKS value_grp;
RUN;

DATA ranks;
 SET ranks;
      IF Value_grp <= 50000  THEN Value_grp2 = 1;
 ELSE IF Value_grp <= 100000 THEN Value_grp2 = 2;
 ELSE IF Value_grp <= 200000 THEN Value_grp2 = 3;
 ELSE Value_grp2=4;
RUN;





/*-------------------------------------------------------------------------------------------
Section 20.2
-------------------------------------------------------------------------------------------*/


%TARGETCHART(DATA=age,TARGET=response,interval = age age_qdr_std);

data age;
 set age;
if age < 30 then Age_GRP = 1; 
 else if age < 45 then Age_GRP = 2;
 else if age < 55 then Age_GRP = 3;
 else if age < 75 then Age_GRP = 4;
 else Age_GRP = 5;
run;


%TARGETCHART(DATA=age,TARGET=response,class = age_grp);

/*-------------------------------------------------------------------------------------------
Section 20.3
-------------------------------------------------------------------------------------------*/

DATA training_data
     validation_data;
 SET raw_data;
 IF UNIFORM(3) < 0.67 THEN OUTPUT training_data;
 ELSE OUTPUT validation_data;
RUN;


DATA training_data
     validation_data
     test_data;
 SET raw_data;
 IF UNIFORM(3) <= 0.50 THEN OUTPUT training_data;
 ELSE IF UNIFORM(4) <= 0.50 THEN OUTPUT validation_data;
 ELSE OUTPUT test_data;
RUN;
