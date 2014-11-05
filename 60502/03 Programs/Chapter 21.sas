/*-------------------------------------------------------------------------------------------
Daten
-------------------------------------------------------------------------------------------*/

 data assoc;
  set sampsio.assocs;
  rename customer = PurchaseID;
 run;
 data assoc2;
 format CustomerID PurchaseID 8.;
 drop time;
  set assoc;
   if purchaseID in (2 0) then CustomerID = 1;
   else CustomerID = 2;
   format ProductGroup $20.;
   if product in ('ham' 'turkey' 'corned_b') then ProductGroup = 'Meat';
   else if product in ('heineken' 'bourbon') then ProductGroup = 'Alcoholics';
   else if product in ('hering' 'sardines') then ProductGroup = 'Fish';
   else if product in ('olives' 'avocado') then ProductGroup = 'Fruits';
   else ProductGroup = 'Others';
   if _n_ = 12 or _n_ > 20 then delete;
run;







DATA class; 
 SET sashelp.class;
 ID = _N_;
RUN;


PROC TRANSPOSE DATA = class OUT = class_tp;
 BY ID name;
 VAR sex age height weight;
RUN;


DATA Key_Value;
 SET class_tp;
 RENAME _name_ = Key; 
 Value = strip(col1);
 DROP col1;
RUN;






data prdsale; 
 format month date9. product $10. actual dollar12.2;
 set sashelp.prdsale;
 keep actual product month;

run;



proc sql;
 create table lookup as
 select distinct product, prodtype from sashelp.prdsale
 order by 2;
 quit;





data Cal_Month; 
      format date Month yymmp7.;
      do m = 1 to 12; 
      date = mdy(m,1,1993);
      d0 = intnx( 'month', date, 0 ) - 1; 
      d1 = intnx( 'month', date, 1 ) - 1; 
      Monday  = intck( 'week.2', d0, d1 ); 
      Tuesday = intck( 'week.3', d0, d1 ); 
      Wednesday  = intck( 'week.4', d0, d1 ); 
      Thursday = intck( 'week.5', d0, d1 ); 
      Friday  = intck( 'week.6', d0, d1 ); 
      Saturday  = intck( 'week.7', d0, d1 ); 
      Sunday  = intck( 'week.1', d0, d1 ); 
 	  NrDays = sum(of monday tuesday Wednesday thursday
                      friday saturday sunday);
      Month = Date;
	  output;
	  end;
      drop m d0 d1; 
   run;

DATA Shops;
FORMAT Month mmyyp8.;
INPUT m Shops;
Month = mdy(m,1,1993);
CARDS;
1	12
2	12
3	14
4	14
5	14
6	14
7	14
8	17
9	17
10	17
11	17
12	17
;
RUN;




/*-------------------------------------------------------------------------------------------
Section 21.2
-------------------------------------------------------------------------------------------*/


PROC SORT DATA = assoc2(KEEP = CustomerID ProductGroup)
          OUT  = assocs_nodup
          NODUPKEY;
 BY CustomerID ProductGroup;
RUN;



DATA Key_Value;
 SET Key_Value;
 Feature = CATX("=",key,value);
RUN;


/*-------------------------------------------------------------------------------------------
Section 21.3
-------------------------------------------------------------------------------------------*/



PROC SQL;
 CREATE TABLE prdsale_sql
 AS SELECT *
    FROM prdsale AS a,
         lookup  AS b
    WHERE a.product = b.product;
QUIT;




DATA FMT_PG(RENAME =(Product=start ProdType=label));
 SET lookup end=last;
 RETAIN fmtname 'PG' type 'c';
RUN;
PROC FORMAT LIBRARY=work CNTLIN=FMT_PG; 
RUN;

DATA prdsale_fmt;
 SET prdsale;
 FORMAT Prodtype $12.;
 Prodtype = PUT(product,PG.);
RUN;





data Prdsale_promotion;
 set prdsale;
IF product = 'BED' AND '01APR1993'd <= MONTH <= '01AUG1993'd THEN 
                                                      PROMOTION = 1;
ELSE PROMOTION = 0;
run;



PROC SQL;
 CREATE TABLE prdsale_enh
 AS SELECT a.*, b.NrDays, c.Shops
    FROM prdsale   AS a,
        cal_month  AS b,
        shops      AS c
    WHERE a.month = b.month
      AND a.month = c.month;
QUIT;



/*-------------------------------------------------------------------------------------------
Section 21.4
-------------------------------------------------------------------------------------------*/

PROC MEANS DATA = prdsale_sql NOPRINT NWAY;
 CLASS prodtype month;
 VAR actual;
 OUTPUT OUT = prdtype_aggr(DROP = _type_ _freq_) SUM=;
RUN;


PROC MEANS DATA = prdsale_sql NOPRINT NWAY;
 FORMAT month yyq6.;
 CLASS prodtype month;
 VAR actual;
 OUTPUT OUT = prdtype_aggr_qtr(DROP = _type_ _freq_) SUM=;
RUN;


PROC SQL;
 CREATE TABLE prdtype_sql_aggr
 AS SELECT prodtype,
           month,
           SUM(actual) AS Actual
    FROM prdsale_sql
    GROUP BY month, prodtype
    ORDER BY 1,2;
QUIT;




PROC SQL;
 CREATE VIEW prdtype_sql_aggr_view
 AS SELECT prodtype,
           month,
           SUM(actual) AS Actual
    FROM prdsale_sql
    GROUP BY month, prodtype
    ORDER BY 1,2;
QUIT;

PROC SQL;
 CREATE VIEW prdtype_sql_aggr_view2
 AS SELECT prodtype,
           Month FORMAT = yyq6.,
           SUM(actual) AS Actual
    FROM prdsale_sql
    GROUP BY month, prodtype
    ORDER BY 1,2;
QUIT;




PROC SQL;
 CREATE VIEW prdtype_sql_aggr_view3
 AS SELECT prodtype,
           Put(Month,yyq6.) As Quarter,
           SUM(actual) AS Actual
    FROM prdsale_sql
    GROUP BY Quarter, prodtype
    ORDER BY 1,2;
QUIT;







PROC SQL;
 CREATE TABLE prdtype_aggr_shops
 AS SELECT product,
           Month,
           SUM(actual) AS Actual,
           AVG(shops) AS Shops
    FROM prdsale_enh
	GROUP BY month, product
    ORDER BY 1,2;
QUIT;

PROC MEANS DATA = prdsale_enh NOPRINT NWAY;
 CLASS product month;
 VAR actual;
 ID Shops;
 OUTPUT OUT = prdtype_aggr(DROP = _type_ _freq_) SUM=;
RUN;

PROC MEANS DATA = prdsale_enh NOPRINT NWAY;
 CLASS product month;
 VAR actual;
 OUTPUT OUT = prdtype_aggr(DROP = _type_ _freq_) 
         SUM(Actual) = Actual
         Mean(Shops) = Shops;
RUN;




/*-------------------------------------------------------------------------------------------
Section 21.5
-------------------------------------------------------------------------------------------*/


data weekdays; 
      format date yymmp7.;
      do m = 1 to 12; 
      date = mdy(m,1,2005);
      d0 = intnx( 'month', date, 0 ) - 1; 
      d1 = intnx( 'month', date, 1 ) - 1; 
      nsunday  = intck( 'week.1', d0, d1 ); 
      nmonday  = intck( 'week.2', d0, d1 ); 
      ntuesday = intck( 'week.3', d0, d1 ); 
      nwedday  = intck( 'week.4', d0, d1 ); 
      nthurday = intck( 'week.5', d0, d1 ); 
      nfriday  = intck( 'week.6', d0, d1 ); 
      nsatday  = intck( 'week.7', d0, d1 ); 
	  output;
	  end;
      drop m d0 d1; 
   run;



   DATA air;
 SET sashelp.air;
 lag_air = LAG(air);
 dif_air = DIF(air);
 lag2_air = LAG2(air);
RUN;






PROC SQL;
 CREATE TABLE prdsale_sum
 AS SELECT month FORMAT = yymmp6.,
           product,
           SUM(actual) as Actual
    FROM sashelp.prdsale
	WHERE year(month) = 1993
	GROUP BY month, product
    ORDER BY product, month;         
QUIT;


DATA prdsale_sum;
 SET prdsale_sum;
 BY product;
 *** Method 1 - WORKS!;
 lag_actual = LAG(actual);
 IF FIRST.product then lag_actual = .;
 *** Method 2 - Does not work!;
 IF NOT(FIRST.product) THEN lag_actual2 = lag(actual);
RUN;



/*-------------------------------------------------------------------------------------------
Section 21.6
-------------------------------------------------------------------------------------------*/

PROC EXPAND DATA = sashelp.air OUT = air_month
            FROM = month TO = qtr;
 CONVERT air / observed = total;
 ID DATE;
RUN;



PROC EXPAND DATA = sashelp.air OUT = air_week
            FROM = month TO = week;
 CONVERT air / OBSERVED = total;
 ID DATE;
RUN;





DATA air_missing;
 SET sashelp.air;
 IF uniform(23) < 0.1 THEN air = .;
RUN;

PROC EXPAND DATA = air_missing OUT = air_impute;
 CONVERT air / OBSERVED = total;
RUN;




PROC SORT DATA = sashelp.prdsale OUT= prdsale;
 BY product month;
RUN;

PROC TIMESERIES DATA = prdsale
                OUT  = prdsale_aggr3;
 BY product;
 ID month   INTERVAL = qtr 
            ACCUMULATE = total
            SETMISS = 0;
 VAR actual;
RUN;

