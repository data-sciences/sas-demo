LIBNAME Candy "C:\Program Files\SAS\EnterpriseGuide\4.2\Sample\Data";
proc sql;
  create table Combined as 
    select t1.name, t2.units
    from candy.candy_customers as t1 
    inner join candy.candy_sales_history as t2 
       on (t1.custid = t2.customer);
quit;
