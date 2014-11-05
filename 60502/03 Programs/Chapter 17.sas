/*-------------------------------------------------------------------------------------------
Data
-------------------------------------------------------------------------------------------*/

data codes;
input ProductCode $;
datalines;
216
305
404
233
105
311
290
;
run;


data customer;
 do id = 1 to 1000;
   format employment_status $10.;
   if uniform(432) le 0.1 then employment_status =      'Employed';
   else if uniform(432) le 0.4 then employment_status = 'Unemployed';
   else if uniform(432) le 0.6 then employment_status = 'Retired';
   else if uniform(432) le 1 then employment_status =   'Education';
   output;
 end;
run;



DATA BranchList;
 INPUT BranchID BranchName $20.;
 DATALINES;
 1	Vienna-City
 2	Vienna-West
 3	Salzburg
 4	Wels
 5	Linz
 6	Graz
 ;
RUN;


/*-------------------------------------------------------------------------------------------
Section 17.2
-------------------------------------------------------------------------------------------*/


PROC FORMAT;
 VALUE   gender   1='MALE' 0='FEMALE';
 VALUE  $gender_c M='MALE' F='FEMALE';
RUN;

DATA gender_example;
 INPUT Gender Gender2 $;
 DATALINES;
 1  M
 1  M
 0  F
 0  F
 1  M
 ;
RUN;

PROC PRINT DATA = gender_example;
 FORMAT Gender gender. Gender2 $gender_c.;
RUN;


/*-------------------------------------------------------------------------------------------
Section 17.3
-------------------------------------------------------------------------------------------*/

DATA codes;
 SET codes;
 ProductMainGroup = SUBSTR(ProductCode,1,1);
RUN;



PROC FREQ DATA = codes ORDER = FREQ;
 TABLE ProductMainGroup;
RUN;

*Data Codes2;
* set codes;
IF ProductMainGroup = '2' THEN ProductMainGroupMF = 1; 
ELSE ProductMainGroupMF =0;
*run;

*Data Codes2;
* set codes;
ProductMainGroupMF = (ProductMainGroup = '2');
*run;




DATA customer;
 MERGE customer_base    (IN=in1)
       Call_center_aggr (IN=in2)
       Web_usage_aggr   (IN=in3);
    BY CustomerID;
 HasCallCenterRecord = in2;
 HasWebUsage = in3;
RUN;


/*-------------------------------------------------------------------------------------------
Section 17.4
-------------------------------------------------------------------------------------------*/

PROC FREQ DATA = codes ORDER = FREQ;
 TABLE ProductMainGroup;
RUN;

DATA codes;
 SET Codes;
FORMAT ProductMainGroupNEW $6.;
IF ProductMainGroup IN ('1' '4') THEN ProductMainGroupNEW = 'OTHERS'; 
ELSE ProductMainGroupNEW = ProductMainGroup;
run;


LIBNAME lookup 'c:\project1\lookup.xls';

PROC FREQ data = codes ORDER = FREQ;
 TABLE ProductMainGroup / NOPERCENT OUT = lookup.codes1;
RUN;

LIBNAME lookup CLEAR;




LIBNAME lookup 'c:\project1\lookup.xls';

DATA codes1;
 SET lookup.'codes1$'n(RENAME =( ProductMainGroup =start Group_New=label));
 RETAIN fmtname 'ProductMainGroupNEW' type 'c';
RUN;

PROC FORMAT CNTLIN = codes1;
RUN;

DATA codes;
 SET codes;
FORMAT ProductMainGroup $ProductMainGroupNEW.;
RUN;


/*-------------------------------------------------------------------------------------------
Section 17.5
-------------------------------------------------------------------------------------------*/

DATA CUSTOMER;
 SET CUSTOMER;
  SELECT (Employment_Status);
  WHEN ('Employed')   Employed=1;
  WHEN ('Unemployed') Unemployed=1;
  WHEN ('Education')  Education =1;
  OTHERWISE DO;
              Employed  =-1;
              Unemployed=-1;
              Education =-1;
            END;
 END;
RUN;


DATA CUSTOMER;
 SET CUSTOMER;
  SELECT (Employment_Status);
  WHEN ('Employed')   Employed  =1;
  WHEN ('Unemployed') Unemployed=1;
  WHEN ('Education')  Education =1;
  WHEN ('Retired')    Retired   =1;
 END;
RUN;



DATA CUSTOMER;
 SET CUSTOMER;
  Employed   = (Employment_Status = 'Employed');
  Unemployed = (Employment_Status = 'Unemployed');
  Retired    = (Employment_Status = 'Retired');
  Education  = (Employment_Status = 'Education');
RUN;

PROC SQL;
CREATE TABLE Customer_Dummy AS
 SELECT *,
 (Employment_Status = 'Employed') AS Employed,
 (Employment_Status = 'Unemployed') AS Unemployed,
 (Employment_Status = 'Retired') AS Retired,
 (Employment_Status = 'Education') AS Education
 FROM customer;
QUIT;



/*-------------------------------------------------------------------------------------------
Section 17.6
-------------------------------------------------------------------------------------------*/



DATA customer;
 MERGE customer_base
       Product_Server_A (IN = Server_A)
       Product_Server_B (IN = Server_B)
       Product_Server_C (IN = Server_C)
       Product_Server_D (IN = Server_D);
 BY customer_id;
 ProdA = Server_A; ProdB = Server_B;
 ProdC = Server_C; ProdD = Server_D;
 ProductUsage = CAT(ProdA,ProdB,ProdC,ProdD);
RUN;



DATA customer;
 MERGE customer_base
       Product_Server_A (IN = Server_A 
                         RENAME = (PURCHASE_SUM = SUM_A))
       Product_Server_B (IN = Server_B 
                         RENAME = (PURCHASE_SUM = SUM_B))
       Product_Server_C (IN = Server_C 
                         RENAME = (PURCHASE_SUM = SUM_C))
       Product_Server_D (IN = Server_D 
                         RENAME = (PURCHASE_SUM = SUM_D))
       ;
 BY customer_id;
 ProdA = Server_A; ProdB = Server_B;
 ProdC = Server_C; ProdD = Server_D;
 ProductUsage = CAT(ProdA,ProdB,ProdC,ProdD);
 ProductUsage1000 = CAT((SUM_A > 1000),(SUM_B > 1000),
                        (SUM_C > 1000),(SUM_D > 1000));
RUN;




/*-------------------------------------------------------------------------------------------
Section 17.7
------------------------------------------------------------------------------------------*/


DATA BranchList;
 SET BranchList(RENAME =(BranchID=start BranchName=label));
 RETAIN fmtname 'BranchName' type 'n';
RUN;
PROC FORMAT CNTLIN = BranchList;
RUN;



PROC SQL;
 CREATE TABLE branchlist
 AS SELECT DISTINCT BranchID FROM branchlist;
QUIT;

PROC SORT DATA = branchlist OUT = branchlist_nodup NODUP;
 BY BranchID;
RUN;

