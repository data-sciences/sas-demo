/*-------------------------------------------------------------------------------------------
Daten
-------------------------------------------------------------------------------------------*/
data wide;
 input CustID M1 M2 M3 M4 M5 M6 8.;
 Cards;
1	52	54	58	47	38	22
2	22	24	30	28	31	30
3	100	120	110	115	100	95
4	43	43	43	.	42	41
5  20	29	35	39	28	44
6  16  24	18	25	30	24
7	80	70	60	50	60	70
8  90	95	80	100	100	90
9  47	47	47	47	47	47
10 50	52	0	50	0	52
 ;
run;



data Billing;
 input CustID B1 B2 B3 B4 B5 B6 8.;
 Cards;
1	26	54	58	47	38	22
2	44	24	44	28	44	44
3	100	100	110	100	100	100
4	53	53	53	10	52	51
5  200	180	170	160	140	120
6  32  48	36	50	60	48
7	160	170	110	150	110	170
8  190	195	100	100	100	190
9  147	94	94	100	147	90
10 150	152	20	70	20	72
 ;
run;


PROC TRANSPOSE DATA = BILLING OUT = LONG_BILL;
 BY custId;
RUN;

DATA LONG_BILL;
 SET LONG_BILL;
 FORMAT Month 8.;
 RENAME col1 = Billing;
 Month = compress(_name_,'B');
 DROP _name_;
RUN;


PROC TRANSPOSE DATA = WIDE OUT = LONG;
 BY custId;
RUN;

DATA LONG;
 SET LONG;
 FORMAT Month 8.;
 RENAME col1 = Usage;
 Month = compress(_name_,'M');
 DROP _name_;
RUN;


DATA CORR;
 merge long long_bill;
 by custid month;
run;











data Usage;
 input CustID ContractID Usage1;
 Usage2=Usage1**2;
 cards;
 1 1 20
 1 2 40
 1 3 60
 1 4 5
 1 5 2
 1 6 1
 2 1 10
 2 2 10
 2 3 12
 2 4 11
 3 1 40
 3 2 30
 3 3 30
 3 4 10
 3 5 5
 4 1 4
 5 1 1
 5 2 2
 5 3 3
 6 1 1
 6 2 2
 6 3 3
 6 4 4
 ;
 run;





/*-------------------------------------------------------------------------------------------
Section 18.2
-------------------------------------------------------------------------------------------*/


PROC TRANSPOSE DATA = WIDE OUT = LONG;
 BY custId;
RUN;

DATA LONG;
 SET LONG;
 FORMAT Month 8.;
 RENAME col1 = Usage;
 Month = compress(_name_,'M');
 DROP _name_;
RUN;





DATA wide;
 SET wide;
 Usage_Mean = MEAN(of M1-M6);
 Usage_Std  = STD(of M1-M6);
 Usage_Median = MEDIAN(of M1-M6);
RUN;



PROC MEANS DATA = long NOPRINT NWAY;
 CLASS CustID;
 VAR Usage;
 OUTPUT OUT = aggr_static(DROP = _type_ _freq_) 
              MEAN= SUM= N= STD= MIN= MAX=/AUTONAME;
RUN;



/*-------------------------------------------------------------------------------------------
Section 18.3
-------------------------------------------------------------------------------------------*/

PROC CORR DATA = Corr NOPRINT 
          OUTS=CorrSpearman(where = (_type_ = 'CORR') DROP = _name_);
 BY Custid;
 VAR usage;
 WITH billing;
RUN;



PROC MEANS DATA = long NOPRINT NWAY;
 CLASS month;
 VAR usage;
 OUTPUT OUT = M_Mean MEAN=m_mean;
RUN;

PROC SQL;
 CREATE TABLE interval_corr
 AS SELECT * 
    FROM long a, m_mean b
	WHERE a.month = b.month;
QUIT;

PROC CORR DATA = interval_corr 
          OUTS = Corr_CustID(WHERE = (_type_ = 'CORR')) NOPRINT;
 BY CustID;
 VAR Usage;
 WITH m_mean;
RUN;





/*-------------------------------------------------------------------------------------------
Section 18.4
-------------------------------------------------------------------------------------------*/



%concentrate(usage,usage1,CustID);





%concentrate(usage,usage1,CustID);
%concentrate(usage,usage2,CustID);

DATA _concentrate_;
 MERGE concentrate_Usage1
       concentrate_Usage2;
 BY CustID;
RUN;





/*-------------------------------------------------------------------------------------------
Section 18.5
-------------------------------------------------------------------------------------------*/


DATA indiv;
 SET wide;
 FORMAT CustID 8. M1-M6 m_avg 8.2;
 ARRAY m {*} M1 - M6;
 ARRAY m_mean {*} M1 - M6;
 m_avg = MEAN(of M1 - M6);
 DO i = 1 TO DIM(m);
 	m_mean{i} = ((m{i}-m_avg)/m_avg);
 END;
 DROP i;
RUN;


PROC MEANS DATA = wide MEAN MAXDEC=2;
 VAR M1 - M6;
 OUTPUT OUT = M_Mean MEAN = /AUTONAME;
RUN;


DATA interval_month;
 SET wide;
 FORMAT M1 - M6 8.2;
M1=M1/ 52.00;
M2=M2/ 55.80;
M3=M3/ 48.10;
M4=M4/ 55.67;
M5=M5/ 47.60;
M6=M6/ 51.50;
RUN;








PROC PRINTTO PRINT='C:\data\somefile.lst';
RUN;

ODS OUTPUT CrossTabFreqs = freq;

PROC FREQ DATA = long;
 TABLE CustID * Month / EXPECTED;
 WEIGHT Usage;
RUN;

ODS OUTPUT CLOSE;
PROC PRINTTO;RUN;

DATA freq;
 SET freq;
 KEEP CustID Month Expected RowPercent ColPercent;
 WHERE _type_ = '11';
RUN;







/*-------------------------------------------------------------------------------------------
Section 18.6
-------------------------------------------------------------------------------------------*/


DATA SimpleTrend;
 SET wide;
 FORMAT Last2MonthsDiff Last2MonthsRatio Last2MonthsStd 8.2;
 Last2MonthsDiff = MEAN(of m5-m6)-MEAN(of m1-m4);
 Last2MonthsRatio = MEAN(of m5-m6)/MEAN(of m1-m4);
 Last2MonthsStd = (MEAN(of m5-m6)-MEAN(of m1-m4))/MEAN(of m1-m4);
RUN;


PROC REG DATA = long NOPRINT 
         OUTEST=Est(KEEP = CustID intercept month);
 MODEL usage = month;
 BY CustID;
RUN;




PROC REG DATA = long NOPRINT 
         OUTEST=Est(KEEP = CustID intercept month);
 MODEL usage = month;
 BY CustID;
 WHERE month in (3,4,5,6);
RUN;






PROC REG DATA = long NOPRINT 
         OUTEST=Est_LongTerm(KEEP = CustID month
                             RENAME = (month=LongTerm));
 MODEL usage = month;
 BY CustID;
RUN;

PROC REG DATA = long NOPRINT 
         OUTEST=Est_ShortTerm(KEEP = CustID month
                              RENAME = (month=ShortTerm));
 MODEL usage = month;
 BY CustID;
 WHERE month in (5 6);
RUN;

DATA mart;
 MERGE wide
       est_longTerm
       est_shortTerm;
 BY CustID;
RUN;




PROC FORMAT;
 VALUE est LOW -< -1     = '-'
           -1  -  1      = '='
            1   <- HIGH  = '+';
RUN;

DATA mart;
 SET mart;
 LongShortInd = CAT(put(LongTerm,est.),put(ShortTerm,est.));
RUN;








PROC SORT DATA = sashelp.prdsal3 OUT = Prdsal3; 
 BY state date;
RUN;


PROC TIMESERIES DATA=prdsal3
                OUTSEASON=season
                OUTTREND=trend
                OUTDECOMP=decomp
                OUTCORR = corr
                MAXERROR=0;
 BY state;
 WHERE product = 'SOFA';
 SEASON SUM / TRANSPOSE = YES;
 TREND MEAN / TRANSPOSE = YES;
 CORR ACOV /  TRANSPOSE = YES;
 DECOMP TCS / LAMBDA = 1600 TRANSPOSE = YES;
 ID date INTERVAL=MONTH ACCUMULATE=TOTAL SETMISSING=MISSING;
 VAR actual ;
RUN;
