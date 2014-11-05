/*-------------------------------------------------------------------------------------------
Creating Formats
-------------------------------------------------------------------------------------------*/


data FMT_PG(rename =(ProductGroupID=start ProductGroupName=label));
 set ProductGroups end=last;
 retain fmtname 'PG' type 'n';
run;
PROC format library=work cntlin=FMT_PG; 
run;
data FMT_PSG(rename =(ProductSubGroupName=label));
 set ProductSubGroups end=last;
 retain fmtname 'PSG' type 'n';
 Start = ProductGroupID*100+ProductSubGroupID;
run;
PROC format library=work cntlin=FMT_PSG; run;



/*-------------------------------------------------------------------------------------------
Derived Variables
-------------------------------------------------------------------------------------------*/


PROC MEANS DATA = PointOfSale NOPRINT NWAY;
 CLASS CustID;
 VAR Date Sale Profit;
 OUTPUT OUT = Cust_POS(DROP = _TYPE_ _FREQ_) 
                       SUM(Sale)=Total_Sale
                       SUM(Profit)=Total_Profit
                       MAX(Date)=LastVisit
                       MIN(Date)=FirstVisit 
;
RUN;

*** Number Visits;
PROC SQL;
 CREATE TABLE Visit_Days AS
 SELECT CustID, COUNT(DISTINCT date) AS Visit_Days
 FROM PointOfSale
 GROUP BY CustID
 ORDER BY CustID;
QUIT;


*** Promotion Proportion;
PROC MEANS DATA = PointOfSale NOPRINT NWAY;
 CLASS CustID;
 VAR Sale;
 WHERE PromoID NE .;
 OUTPUT OUT = Cust_Promo(DROP = _TYPE_ _FREQ_) SUM(Sale)=Promo_Amount;
RUN;


*** Return ;

PROC MEANS DATA = PointOfSale NOPRINT NWAY;
 CLASS CustID;
 VAR Sale;
 WHERE Quantity < 0;
 OUTPUT OUT = Cust_Return(DROP = _TYPE_ _FREQ_) SUM(Sale)=Return_Amount;
RUN;


PROC SQL;
 CREATE TABLE Cust_PG_tmp AS
 SELECT CustID,
        ProductGroupID FORMAT=PG.,
		SUM(Sale) AS Sale
 FROM PointOfSale AS a,
      Product AS b
 WHERE a.ProdID = b.ProdID
 GROUP BY CustID, ProductGroupID
 ORDER BY CustID, ProductGroupID;
QUIT;


PROC TRANSPOSE DATA = Cust_PG_tmp
               OUT = Cust_PG(DROP = _NAME_);
 BY CustID;
 VAR Sale;
 ID ProductGroupID;
RUN;




/*-------------------------------------------------------------------------------------------
Customer Data Mart
-------------------------------------------------------------------------------------------*/


%LET SnapDate = "01JUL05"d;


DATA CustMart;

ATTRIB /* Customer Demographics */
CustID		FORMAT=8.	
Birthdate 	FORMAT=DATE9.	LABEL ="Date of Birth"
Age			FORMAT=8.		LABEL ="Age (years)"
;
ATTRIB /* Card Details */
Card_Start	FORMAT=DATE9.	LABEL ="Date of Card Issue"
AgeCardMonths FORMAT=8.1		LABEL ="Age of Card (months)"
AgeCardIssue FORMAT=8.		LABEL ="Age at Card Issue (years)"
;

ATTRIB /* Visit Frequency and Recency */
FirstVisit           FORMAT=DATE9. LABEL = "First Visit"
LastVisit            FORMAT=DATE9. LABEL = "Last Visit"
Visit_Days           FORMAT=8.     LABEL = "Nr of Visit Days"
ActivePeriod         FORMAT=8.     LABEL = "Interval of Card Usage (months)"
MonthsSinceLastVisit FORMAT = 8.1  LABEL = "Months since last visit (months)"
VisitDaysPerMonth    FORMAT = 8.2  LABEL = "Average Visit Days per Month"
;

ATTRIB /* Sale and Profit */
Total_Sale      FORMAT = 8.2 LABEL = "Total Sale Amount"
Total_Profit    FORMAT = 8.2 LABEL = "Total Profit Amount"
ProfitMargin    FORMAT = 8.1 LABEL = "Profit Marin (%)"
SalePerYear     FORMAT = 8.2 LABEL = "Average Sale per Year"
ProfitPerYear   FORMAT = 8.2 LABEL = "Average Profit per Year"
SalePerVisitDay FORMAT = 8.2 LABEL = "Average Sale per VisitDay";

ATTRIB /* Promotion and Return */
BuysInPromo     FORMAT = 8.  LABEL = "Buys in Promotion ever"
Promo_Amount    FORMAT = 8.2 LABEL = "Sale Amount in Promotion"
PromoPct        FORMAT = 8.2 LABEL ="Sale Proportion (%) in promotion"
ReturnsProducts FORMAT = 8.  LABEL= "Returns Products ever"
Return_Amount   FORMAT = 8.2 LABEL = "Returned Sale Amount"
ReturnPct       FORMAT = 8.2 LABEL = "Return Amount Proportion (%) on sale"
;

ATTRIB /* Product Groups */
Tools        FORMAT = 8.2 LABEL = "Sale in PG Tools"
Car          FORMAT = 8.2 LABEL = "Sale in PG Car"
Gardening    FORMAT = 8.2 LABEL = "Sale in PG Gardening"
ToolsPct     FORMAT = 8.2 LABEL = "Sale Proportion (%) in PG Tools"
CarPct       FORMAT = 8.2 LABEL = "Sale Proportion (%) in PG Car"
GardeningPct FORMAT = 8.2 LABEL = "Sale Proportion (%) in PG Gardening"
;


 MERGE Customer(IN = IN_Customer)
       Cust_pos
	   Visit_days
	   Cust_promo(IN = IN_Promo)
	   Cust_return(IN = IN_Return)
	   Cust_pg;
 BY CustID;
 IF IN_Customer;


 ARRAY vars {*} tools car gardening Promo_Amount Return_Amount ;
 DO i = 1 TO dim(vars);
  IF vars{i}=. THEN vars{i}=0;
 END;
 DROP i;


 /* Customer Demographics */
 Age = (&snapdate - birthdate)/365.25;

 /* Card Details */
 AgeCardIssue = (Card_Start - birthdate)/365.25;
 AgeCardMonths = (&snapdate - Card_Start)/(365.25/12);

 /* Visit Frequency and Recency */
 VisitDaysPerMonth = Visit_Days / AgeCardMonths;
 MonthsSinceLastVisit = (&snapdate - LastVisit)/(365.25/12);
 ActivePeriod = (LastVisit - FirstVisit)/(365.25/12);

 /* Sale and Profit */
 SalePerYear = Total_Sale * 12 / AgeCardMonths;
 SalePerVisitDay = Total_Sale / Visit_Days;
 ProfitPerYear = Total_Profit * 12 / AgeCardMonths;
 ProfitMargin = Total_Profit / Total_Sale * 100;

 /* Promotion and Return */
 BuysInPromo = In_Promo;
 PromoPct = Promo_Amount / Total_Sale *100;
 ReturnsProducts = In_Return;
 ReturnPct = -Return_Amount / Total_Sale *100;

 /* Product Groups */
 ToolsPct = Tools/ Total_Sale *100;
 CarPct = Car / Total_Sale *100;
 GardeningPct = Gardening/ Total_Sale *100;

RUN;

