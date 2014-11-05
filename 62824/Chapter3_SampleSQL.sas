/* Replace this data path with the correct location on your own PC */
libname candy "C:\Program Files\SASHome\x86\SASEnterpriseGuide\5.1\Sample\Data";

PROC SQL;
  CREATE TABLE WORK.Quarterly_Sales_Summary AS
    SELECT t1.Quarter,
      t2.Name AS Customer_Name,
      t2.Region,
      t3.Product,
      /* Net_Sale_Amount calculation*/
  (t3.Retail_Price * t4.Units * (1 - t4.Discount)) FORMAT=DOLLAR12. 
    AS Net_Sale_Amount, t3.Retail_Price, t4.Units, t4.Discount 
FROM /* Tables to join */
  Candy.Candy_Products AS t3,
  Candy.Candy_Sales_History AS t4,
  Candy.Candy_Customers AS t2,
  Candy.Candy_Time_Periods AS t1
  /* Join conditions */
  WHERE (t3.ProdID = t4.ProdID
    AND t2.CustID = t4.Customer
    AND t1.Date_ID = t4.Date);
QUIT;
