/*-------------------------------------------------------------------------------------------
Section 16.2
-------------------------------------------------------------------------------------------*/



DATA class2;
 SET sashelp.class;
 %INTERACT(age weight height,quadr=1);
RUN;



/*-------------------------------------------------------------------------------------------
Section 16.3
-------------------------------------------------------------------------------------------*/


DATA class;
 FORMAT ID 8.;
 SET sashelp.class(KEEP = weight);
 ID = _N_;
 Weight_Shift = Weight-100.03;
 Weight_Ratio = Weight/100.03;
 Weight_CentRatio = (Weight-100.03)/100.03;
RUN;

PROC STANDARD DATA = class(keep = id weight)  out = class2
              mean=0 std=1;
 VAR weight;
RUN;

DATA class;
 MERGE class class2(RENAME = (weight = Weight_Std));
 BY id;
RUN;

PROC RANK DATA = class OUT = class TIES = low;
 VAR weight;
 RANKS Weight_Rnk;
RUN;

PROC SORT DATA = class; BY weight;RUN;





/*-------------------------------------------------------------------------------------------
Section 16.4
-------------------------------------------------------------------------------------------*/


DATA _NULL_;
 years_yrdiff = YRDIF('16MAY1970'd,'22OCT2006'd,'ACTUAL');
 years_divide = ('22OCT2006'd - '16MAY1970'd) / 365.2242;
 output;
 PUT years_yrdiff= years_divide=;
RUN;



/*-------------------------------------------------------------------------------------------
Section 16.5
-------------------------------------------------------------------------------------------*/


PROC RANK DATA = sashelp.air OUT = air
          GROUPS = 10;
 VAR air;
 RANKS air_grp;
RUN;


DATA air;
 SET sashelp.air;
 Air_grp1 = CEIL(air/10);
 Air_grp2 = CEIL(air/10)*10;
 Air_grp3 = CEIL(air/10)*10 - 5;
 Air_grp4 = CEIL(air/10)-10;
RUN;



DATA air;
 SET sashelp.air;
 FORMAT air_grp $15.;
 IF      air =  .   THEN air_grp = '00: MISSING';
 ELSE IF air < 220 THEN air_grp = '01: < 220';
 ELSE IF air < 275 THEN air_grp = '02: 220 - 274';
 ELSE                    air_grp = '03: >= 275';
RUN;





PROC FORMAT;
 VALUE air 
   .  = '00: MISSING'
   LOW -< 220 = '01: < 220'
   220 -< 275 = '02: 220 - 274'
   275 - HIGH = '03: > 275';
RUN;

DATA air;
 SET sashelp.air;
 Air_grp = PUT(air,air.);
RUN;




/*-------------------------------------------------------------------------------------------
Section 16.6
-------------------------------------------------------------------------------------------*/


DATA skewed;
INPUT a @@;
CARDS;
1 0 -1 20 4 60 8 50 2 4 7 4 2 1
;
RUN;




PROC MEANS DATA = skewed MIN;
RUN;


 PROC UNIVARIATE DATA = skewed NORMAL PLOT; RUN;
ODS SELECT ALL;



DATA skewed;
 SET skewed;
 log_a = log(a+2);
 root4_a = (a+2) ** 0.25;
RUN;

ODS SELECT TestsForNormality  Plots;
 PROC UNIVARIATE DATA = skewed NORMAL PLOT; RUN;
ODS SELECT ALL;






%SHIFT(min,a,20);
%SHIFT(min,a,0,MISSING=REPLACE);


%FILTER(a,<,20);

%FILTER(a,<,0);

%FILTER(a,<=,0,MISSING=DELETE);



/*-------------------------------------------------------------------------------------------
Section 16.7
-------------------------------------------------------------------------------------------*/



DATA TEST;
INPUT AGE @@;
CARDS;
12 60 . 24 . 50 48 34 .
;
RUN;

PROC STANDARD DATA = TEST REPLACE;
 VAR age;
RUN;
