/*-------------------------------------------------------------------------------------------
Formate
-------------------------------------------------------------------------------------------*/

*** NOTE: A library with names SALES has to be created, that hold the source data of Chapter27;


PROC format lib=sales;
 VALUE OrdType 1 = 'Direct' 2 = 'Indirect';
RUN;




/*-------------------------------------------------------------------------------------------
Aggregation with Proc SQL and a PUT statement
-------------------------------------------------------------------------------------------*/

PROC SQL;
 CREATE TABLE sales.ordermart
 AS
 SELECT SalesOrgClass,
		so.SalesOrgID    Format = $so_fmt.,
		CountryCode,
 		s.ShopID         Format = shop.,
		p.ProductID      Format = product.,
		p.ProductGroupID Format = pg.,
		OrderType        Format = OrdType.,
		ProdStatus,
        put(date,yymmp7.) AS MonthYear,
        SUM(quantity) AS Quantity Format = 8.,
		AVG(Price)    AS AvgPrice Format = 8.2
 FROM	sales.products      AS p,
 		sales.shops         AS S,
		sales.salesorgs     AS SO,
		sales.orders        AS O,
		sales.productgroups AS PG
 WHERE p.productid      = o.productid
   AND s.shopid         = o.shopid
   AND so.salesorgid    = s.salesorgid
   AND p.productgroupid = pg.productgroupid
 GROUP BY
		MonthYear,
		so.SalesOrgClass,
		so.SalesOrgID,
		CountryCode,
		s.ShopID,
		p.ProductID,
		p.ProductGroupID,
		OrderType ,
		ProdStatus
 ORDER BY         
		s.ShopID,
		p.ProductID,
		OrderType,
		MonthYear;
QUIT;



/*-------------------------------------------------------------------------------------------
Aggregation with Proc SQL and a MDY Function
-------------------------------------------------------------------------------------------*/

PROC SQL;
 CREATE TABLE sales.ordermart
 AS
 SELECT SalesOrgClass,
		so.SalesOrgID    Format = $so_fmt.,
		CountryCode,
 		s.ShopID         Format = shop.,
		p.ProductID      Format = product.,
		p.ProductGroupID Format = pg.,
		OrderType        Format = OrdType.,
		ProdStatus,
        mdy(month(date),1,year(date)) as MonthYear format = yymmp7.,
        SUM(quantity) AS Quantity Format = 8.,
		AVG(Price)    AS AvgPrice Format = 8.2
 FROM	sales.products      AS p,
 		sales.shops         AS S,
		sales.salesorgs     AS SO,
		sales.orders        AS O,
		sales.productgroups AS PG
 WHERE p.productid      = o.productid
   AND s.shopid         = o.shopid
   AND so.salesorgid    = s.salesorgid
   AND p.productgroupid = pg.productgroupid
 GROUP BY
		MonthYear,
		so.SalesOrgClass,
		so.SalesOrgID,
		CountryCode,
		s.ShopID,
		p.ProductID,
		p.ProductGroupID,
		OrderType ,
		ProdStatus
 ORDER BY         
		s.ShopID,
		p.ProductID,
		OrderType,
		MonthYear;
QUIT;

/*-------------------------------------------------------------------------------------------
SAS Formate für Join
-------------------------------------------------------------------------------------------*/

options fmtsearch  = (sales sasuser work);

data salesorgfmt(rename =(salesorgid=start salesorgname=label));
 set sales.salesorgs end=last;
 retain fmtname 'SO' type 'c';
run;
PROC format library= sales cntlin=salesorgfmt; run;


data shopfmt(rename =(shopid=start shopname=label));
 set sales.shops end=last;
 retain fmtname 'shop' type 'n';
run;
PROC format library= sales cntlin=shopfmt; run;


data productfmt(rename =(productid=start productname=label));
 set sales.products end=last;
 retain fmtname 'product' type 'n';
run;
PROC format library=sales cntlin=productfmt; run;


data productgroupfmt(rename =(productgroupid=start productgroupname=label));
 set sales.productgroups end=last;
 retain fmtname 'pg' type 'n';
run;
PROC format library= sales cntlin=productgroupfmt; run;



/*-------------------------------------------------------------------------------------------
Datastep Joins
-------------------------------------------------------------------------------------------*/


PROC sort data = sales.shops out= shops (drop=productname);
by salesorgid ;run;
PROC sort data = sales.salesorgs out= salesorgs (drop=salesorgname); by salesorgid ;run;
data s_so;
 merge shops salesorgs;
 by salesorgid;
run;


PROC sort data = sales.products out=products(drop=productname); by productgroupid ;run;
PROC sort data = sales.productgroups out=productgroups(drop=productgroupname); by productgroupid ;run;
data p_pg;
 merge products productgroups;
 by productgroupid;
run;


PROC means data = sales.orders nway noprint
           ;
class shopid productid ordertype date;
var quantity price;
format date yymmp7. price 8.2 quantity 8.;
output out = orders_month mean(price)=price
                          sum(quantity)=quantity;
run;


PROC sort data = p_pg; by productid; run;
PROC sort data = orders_month ; by productid ;run;
data p_pg_o;
 merge p_pg orders_month(in=in2);
 by productid;
 if in2;
run;


PROC sort data =  s_so ; by shopid ;run;
PROC sort data =  p_pg_o ; by shopid productid ordertype date;run;
data sales.ordermart_datastep;
 merge s_so p_pg_o(in=in2);
 by shopid;
 if in2;
run;



/*-------------------------------------------------------------------------------------------
Proc Timeseries
-------------------------------------------------------------------------------------------*/


PROC timeseries data = orders10_sort out = aggr ;
 BY shopid productid ordertype ;
 ID date INTERVAL = MONTH  ACCUMULATE=TOTAL;
 var quantity /ACCUMULATE=TOTAL;
 var price    /ACCUMULATE=average;;
 format date yymmp7. price 8.2 quantity 8. shopid shop. 
        productid   product. ordertype ordtype.;
run;




/*-------------------------------------------------------------------------------------------
Further Aggregations
-------------------------------------------------------------------------------------------*/


PROC SQL;
Create table sales.PROD_MONTH
 as
 select
  ProductID AS ProductID format = product.,
  ProductGroupID AS ProductGroupID format = PG.,
  monthyear,
  sum(quantity) as Quantity format=8.,
  avg(avgprice) as Price format = 8.2
 from sales.ordermart
 group by monthyear, ProductID, productgroupid
 order by ProductID, monthyear;
QUIT;





PROC SQL;
Create VIEW sales.PROD_MONTH_VIEW
 as
 select
  ProductID AS ProductID format = product.,
  ProductGroupID AS ProductGroupID format = PG.,
  monthyear,
  sum(quantity) as Quantity format=8.
 from sales.ordermart
 group by monthyear, ProductID, productgroupid
 order by ProductID, monthyear;
QUIT;



PROC MEANS DATA = sales.ordermart NOPRINT NWAY;
 CLASS productid productgroupid monthyear;
 VAR quantity avgprice;
 OUTPUT OUT = sales.PROD_MONTH(DROP = _TYPE_ _FREQ_)
                    SUM(quantity) = Quantity
                    MEAN(avgprice) = Price;
RUN;


PROC MEANS DATA = sales.ordermart NOPRINT NWAY;
 CLASS productid productgroupid monthyear;
 FORMAT monthyear YYQ5.;
 VAR quantity avgprice;
 OUTPUT OUT = sales.PROD_QTR(DROP = _TYPE_ _FREQ_)
                    SUM(quantity) = Quantity
                    MEAN(avgprice) = Price;
RUN;


proc sql;
create table MDY_Version
as select 
mdy(ceil(month(monthyear)/3*3),1,year(monthyear)) 
                                 AS QTR_YEAR FORMAT = yyq7.
from sales.ordermart;
quit;


/*-------------------------------------------------------------------------------------------
Derived Variables
-------------------------------------------------------------------------------------------*/


DATA SALES.ORDERMART;
 SET SALES.ORDERMART;
 IF '01SEP2004'd <= monthyear <= '30NOV2004'd 
                                              THEN Promotion =1;
 ELSE Promotion = 0;
RUN;


DATA SALES.ORDERMART;
 SET SALES.ORDERMART;
 Promotion=('01SEP2004'd <= monthyear <= '30NOV2004'd); 
RUN;


PROC SQL;
Create table sales.PROD_MONTH
 as
 select
 ProductID AS ProductID format = product.,
 ProductGroupID AS ProductGroupID format = PG.,
 monthyear,
 sum(quantity) as Quantity format=8.,
  avg(avgprice) as Price format = 8.2,
('01SEP2004'd <= monthyear <= '30NOV2004'd) 
                                                 AS Promotion
 from sales.ordermart
 group by monthyear, ProductID, productgroupid
 order by ProductID, monthyear;
QUIT;



/*-------------------------------------------------------------------------------------------
Number of Shops
-------------------------------------------------------------------------------------------*/


PROC sql;
 create table sales.nr_shops as
 select productid, 
        mdy(1,1,year(monthyear)) as Year format = year4.,
        count(distinct shopid) as Nr_Shops
 from sales.ordermart
 group by productid,
     calculated Year;
quit;


PROC sql;
 create table sales.ordermart_enh
 as
 select o.*,
        n.Nr_Shops
 from sales.ordermart as o
      left join sales.nr_shops as n
   on o.productid = n.productid
    and year(o.monthyear) = year(n.year);
quit;



/*-------------------------------------------------------------------------------------------
Lead Months
-------------------------------------------------------------------------------------------*/

 %LET FirstMonth = '01Apr2005'd;
 DATA sales.Lead_Months;
  FORMAT ProductID product. ProductGroupID pg. 
         Monthyear yymmp7. Quantity 8.;
  SET sales.lead_base;
  DO lead = 1 TO 12;
    Quantity = .;
    MonthYear = intnx('MONTH',&FirstMonth,lead);
    IF month(MonthYear) in (9,10,11) THEN Promotion = 1; 
                                     ELSE Promotion = 0;
   OUTPUT;
  END;
  DROP lead;
RUN;


