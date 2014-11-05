/*-------------------------------------------------------------------------------------------
Daten erzeugen
-------------------------------------------------------------------------------------------*/


data customer;
input CustID Age Month	Value;
cards;
1	26	7	45
1	26	8	34
1	26	9	5
2	37	7	34
2	37	8	32
2	37	9	44
3	46	7	56
3	46	8	54
3	46	9	32
;
run;


DATA Series;
INPUT Date Value;
CARDS;
1999	45
2000	34
2001	5
2002	34
2003	32
2004	44
;
RUN;




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



PROC TRANSPOSE DATA = WIDE OUT = SALES_HISTORY(RENAME = ());
 BY custId;
RUN;




DATA SALES_HISTORY;
 SET SALES_HISTORY;
 FORMAT Month 8.;
 RENAME col1 = Volume;
 Month = compress(_name_,'M');
 DROP _name_;
RUN;

/*-------------------------------------------------------------------------------------------
Section B.4
-------------------------------------------------------------------------------------------*/

PROC TRANSPOSE DATA   = customer
               OUT    = customer_tp(drop = _name_)
               PREFIX = Month;
 BY  CustID Age;
 VAR Value;
 ID  Month;
RUN;



DATA customer_hierarchic;
INPUT CustID Age  Month Value;
CARDS;
1	26	7	45
.	.	8	34
.	.	9	5
2	37	7	34
.	.	8	32
.	.	9	44
3	46	7	56
.	.	8	54
.	.	9	32
;
RUN;



/*-------------------------------------------------------------------------------------------
Section B.5
-------------------------------------------------------------------------------------------*/


DATA customer_last;
 SET customer;
 BY  CustID;
 IF LAST.CustID THEN OUTPUT;
RUN;



DATA customer;
 SET customer;
 BY CustID;
 IF FIRST.CustID THEN sequence = 1;
 ELSE sequence + 1;
RUN;



DATA Series;
 SET Series;
 Lag_Value = LAG(Value);
 Dif_Value = DIF(Value);
RUN;




DATA customer_filled;
 SET customer_hierarchic;
 RETAIN custid_tmp age_tmp;
 IF CustID NE . THEN DO; custid_tmp = CustID; age_tmp = age;  END;
 ELSE DO; CustID = custid_tmp; age = age_tmp; END;
 DROP custid_tmp age_tmp;
RUN;


/*-------------------------------------------------------------------------------------------
Section B.6
-------------------------------------------------------------------------------------------*/


DATA CUSTOMER_TP;
 SET CUSTOMER_TP;
ARRAY Months {3} Month7 Month8 Month9;
DO I = 1 to 3;
 IF Months{i} = . THEN Months{i}=0;
END;
DROP I;
RUN;


DATA customer_sample_10pct;
SET customer;
IF UNIFORM(1234) < 0.1;
RUN;


DATA customer_sample1
Customer_sample2;
Set customer;
IF UNIFORM(1234) lt 0.2 THEN OUTPUT customer_sample1;
ELSE IF UNIFORM(2345) lt 0.2/(1-0.2) THEN OUTPUT customer_sample2;
RUN;



PROC RANK DATA = customer
OUT = customer
GROUPS = 10;
VAR value;
RANKS value_deciles;
RUN;



PROC MEANS DATA = sashelp.prdsale SUM;
 VAR actual;
 CLASS product country;
 TYPES product*country country;
RUN;



PROC REG DATA = sales_history 
          OUTEST = sales_trend_coeff
                NOPRINT;
 MODEL volume = month;
BY CustID;
RUN;
QUIT;



/*-------------------------------------------------------------------------------------------
Section B.7
-------------------------------------------------------------------------------------------*/

%LET Actual_Month = 200606;

DATA Customer_TMP;
 SET customer_&Actual_Month;
---- Other SAS statements ---
RUN;

%LET varlist = AGE INCOME NR_CARS NR_CHILDREN;

PROC MEANS DATA = customer;
 VAR &varlist;
RUN;
PROC LOGISTIC DATA = customer;
 MODEL claim = &varlist;
RUN;
QUIT;




%MACRO dataset_names (name =, number = );
%DO n = 1 %TO &number;
&name&n
%END;
;
%MEND;



DATA tmp_data;
SET %dataset_names(name=customer,number=4);
RUN;

%LET var = product country region;
PROC FREQ DATA = sashelp.prdsale;
 TABLE &var;
RUN;





%MACRO loop(data=,var=,n=);
  PROC FREQ DATA = &data;
 %DO i = 1 %TO &n;
   TABLE %SCAN(&var,&i) / OUT = %SCAN(&var,&i)_Table;
 %END;
  RUN;
%MEND;

%LOOP(DATA = sashelp.prdsale, 
      VAR = product country region, N   = 3);
