/*-------------------------------------------------------------------------------------------
proc copy in = chap25 out = work;run;

-------------------------------------------------------------------------------------------*/

/*-------------------------------------------------------------------------------------------
Accounts
-------------------------------------------------------------------------------------------*/

PROC MEANS DATA = accounts NOPRINT;
 CLASS CustID Type;
 VAR Balance Interest;
 OUTPUT OUT = AccountTmp(RENAME = (_FREQ_ = NrAccounts))
              SUM(Balance) = BalanceSum
              MEAN(Interest) = InterestMean;
RUN;


DATA AccountSum(KEEP = CustID NrAccounts BalanceSum InterestMean)
     AccountTypeTmp(KEEP = CustID Type BalanceSum);
 SET AccountTmp;
 Type = COMPRESS(Type);
 IF _TYPE_ = 2 THEN OUTPUT AccountSum;
 ELSE IF _TYPE_ = 3 THEN OUTPUT AccountTypeTmp;
RUN;



PROC TRANSPOSE DATA = AccountTypeTmp 
               OUT = AccountTypes(DROP = _NAME_ _LABEL_);
 BY CustID;
 VAR BalanceSum;
 ID Type;
RUN;

/*-------------------------------------------------------------------------------------------
Leasing
-------------------------------------------------------------------------------------------*/

PROC MEANS DATA = leasing NWAY NOPRINT;
 CLASS CustID;
 VAR Value AnnualRate;
 OUTPUT OUT = LeasingSum(DROP = _TYPE_ 
                         RENAME = (_FREQ_ = NrLeasing)) 
                        SUM(Value) = LeasingValue
                        SUM(AnnualRate) = LeasingAnnualRate;
RUN;


/*-------------------------------------------------------------------------------------------
Call Center
-------------------------------------------------------------------------------------------*/

%let snapdate = "30JUN2003"d;

PROC FREQ DATA = callcenter NOPRINT;
 TABLE CustID / OUT = CallCenterContacts(DROP = Percent RENAME = (Count = Calls));
WHERE datepart(date) < &snapdate;
RUN;

PROC FREQ DATA = callcenter NOPRINT;
 TABLE CustID / OUT = CallCenterComplaints(DROP = Percent RENAME = (Count = Complaints));
 WHERE Category = 'Complaint' and datepart(date) < &snapdate;
RUN;


/*-------------------------------------------------------------------------------------------
Scores
-------------------------------------------------------------------------------------------*/

DATA ScoreFuture(RENAME = (ValueSegment = FutureValueSegment))
     ScoreActual
     ScoreLastMonth(RENAME = (ValueSegment = LastValueSegment));
 SET Scores;
 DATE = INTNX('MONTH',Date,0,'END');
 IF Date = &snapdate THEN OUTPUT ScoreActual;
 ELSE IF Date = INTNX('MONTH',&snapdate,-1,'END') THEN OUTPUT ScoreLastMonth;
 ELSE IF Date = INTNX('MONTH',&snapdate,2,'END') THEN OUTPUT ScoreFuture;
DROP Date;
RUN;

/*-------------------------------------------------------------------------------------------
Customer Mart
-------------------------------------------------------------------------------------------*/




DATA CustomerMart;

ATTRIB /* Customer Baseline */
CustID         FORMAT  = 8.    LABEL = "Customer ID"
Birthdate      FORMAT = DATE9. LABEL = "Date of Birth"
Alter          FORMAT = 8.     LABEL = "Age (years)"
Gender         FORMAT = $6.    LABEL = "Gender"
MaritalStatus  FORMAT = $10.   LABEL = "Marital Status"
Title          FORMAT = $10.   LABEL = "Academic Title"
HasTitle       FORMAT = 8.     LABEL = "Has Title? 0/1"
Branch         FORMAT = $5.    LABEL = "Branch Name"
CustomerSince  FORMAT = DATE9. LABEL = "Customer Start Date"
CustomerMonths FORMAT = 8.     LABEL ="Customer Duration (months)"
;
ATTRIB /* Accounts */
HasAccounts      FORMAT = 8.  LABEL ="Customer has any accounts"
NrAccounts       FORMAT = 8.  LABEL ="Number of Accounts"
BalanceSum       FORMAT = 8.2 LABEL ="All Accounts Balance Sum"
InterestMean     FORMAT = 8.1 LABEL ="Average Interest"
Loan             FORMAT = 8.2 LABEL ="Loan Balance Sum"
SavingAccount    FORMAT = 8.2 LABEL ="Savings Account Balance Sum"
Funds            FORMAT = 8.2 LABEL ="Funds Balance Sum"
LoanPct          FORMAT = 8.2 LABEL ="Loan Balance Proportion"
SavingAccountPct FORMAT = 8.2 LABEL ="Savings Account Balance Proportion"
FundsPct         FORMAT = 8.2 LABEL ="Funds Balance Proportion"
;
ATTRIB /* Leasing */
HasLeasing        FORMAT = 8.  LABEL ="Customer has any leasing contract"
NrLeasing         FORMAT  = 8. LABEL ="Number of leasing contracts"
LeasingValue      FORMAT = 8.2 LABEL ="Total leasing value"
LeasingAnnualRate FORMAT = 8.2 LABEL ="Total annual leasingrate"
;
ATTRIB /* Call Center */
HasCallCenter FORMAT =8.   LABEL ="Customer has any call center contact"
Calls         FORMAT = 8.  LABEL ="Number of call center contacts"
Complaints    FORMAT = 8.  LABEL ="Number of complaints"
ComplaintPct  FORMAT = 8.2 LABEL ="Percentage of complaints"
;
ATTRIB /* Value Segment */
ValueSegment       FORMAT =$10.  LABEL ="Currenty Value Segment"
LastValueSegment   FORMAT =$10.  LABEL ="Last Value Segment"
ChangeValueSegment FORMAT =8.2   LABEL ="Change in Value Segment"
Cancel             FORMAT =8.    LABEL ="Customer cancelled"
;
*Next we merge the dataset that we created in the previous steps together and create logical variables for some tables;
MERGE Customer (IN = InCustomer)
       AccountSum (IN = InAccounts)
	   AccountTypes
	   LeasingSum (IN = InLeasing)
	   CallCenterContacts (IN = InCallCenter)
	   CallCenterComplaints
	   ScoreFuture(IN = InFuture)
	   ScoreActual
	   ScoreLastMonth;
 BY CustID;
 IF InCustomer AND InFuture;;
*In the next step we replace those missing values with zero, that can be causally be interpreted as zeros. 
 E.g. in the case of the transposition of account types per customer and a customer does not have a certain account type;
 ARRAY vars {*} Calls Complaints LeasingValue LeasingAnnualRate
                Loan SavingAccount Funds  NrLeasing;              
 DO i = 1 TO dim(vars);
  IF vars{i}=. THEN vars{i}=0;
  END;
 DROP i;
*Finally we calculate derived variables for the data mart;
/* Customer Baseline */
HasTitle = (Title ne "");
Alter = (&Snapdate-Birthdate)/ 365.2422;
CustomerMonths = (&Snapdate- CustomerSince)/(365.2422/12);
/* Accounts */
HasAccounts = InAccounts;
IF BalanceSum NOT IN (.,0) THEN DO;
   LoanPct = Loan / BalanceSum * 100;
   SavingAccountPct = SavingAccount / BalanceSum * 100;
   FundsPct = Funds / BalanceSum * 100;
END;
/* Leasing */
HasLeasing = InLeasing;
/* Call Center */
HasCallCenter = InCallCenter;
IF Calls NOT IN (0,.) THEN ComplaintPct = Complaints / Calls *100;
/* Value Segment */
Cancel = (FutureValueSegment = '8. LOST');
ChangeValueSegment = (ValueSegment = LastValueSegment);
RUN;

