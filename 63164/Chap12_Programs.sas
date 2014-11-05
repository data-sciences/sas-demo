/*****************************************************************************
***  Programs for the Book "Data Quality for Analytics Using SAS"
***  Download Version 1.0 - May, 22nd 2012
***  Dr. Gerhard Svolba
***
***  Report any problems and questions for the programs to the author:
***  mail: sastools.by.gerhard@gmx.net
***
******************************************************************************/


/**********************************************
*** Section 12.2
***********************************************/

data Cust_Acct_Matches
     Cust_Only
     Acct_Only;
merge customer (in=in_cust)
      accounts (in=in_acct);
by custid;
if in_cust and in_acct then output Cust_Acct_Matches;
else if in_cust then output Cust_Only;
else if in_acct then output Acct_Only;
run;




/**********************************************
*** Hash Tables
***********************************************/



DATA accounts_no_parent;
 format AccountId CustID 8. Type $20. Opendate date9.;
 *** Define the Hash;
 if _n_ = 1 then do;
    declare hash customer(dataset: "customer");
    customer.definekey('custid');
    customer.definedone();
    call missing(custid);
 end;
 *** Now SET the accounts table;
 SET accounts;
 *** Check for each record whether the CUSTID exists in the parent table; 
 if customer.find() ne 0 then output; 
RUN;


DATA accounts_opendate_check;
 format AccountId CustID 8. Type $20. Opendate CustomerSince date9.;
 *** Define the Hash;
 if _n_ = 1 then do;
    declare hash customer(dataset: "customer");
    customer.definekey('custid');
	customer.definedata('customersince');
    customer.definedone();
    call missing(custid, customersince);
 end;
 *** Now SET the accounts table;
 SET accounts;
 *** Call the HASH and check the integrity rule;
 rc = customer.find();
 if opendate < customersince then output;
 drop rc;
RUN;

