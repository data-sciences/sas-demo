/*-------------------------------------------------------------------------------------------
Daten
-------------------------------------------------------------------------------------------*/

Data accounts;
 input Cust_id Account_id Account_type $12.;
 cards;
 1 1 SAVING
 1 2 CHECKING
 1 3 SAVING
 1 4 LOAN
 2 5 CHECKING
 2 6 SAVING
 3 7 LOAN
 3 8 MORTGAGE
 3 9 SAVING
 3 10 CHECKING
 4 11 CHECKING
 5 12 LOAN
 5 13 SAVING
 5 14 CHECKING
 5 15 SAVING
 5 16 SPECIAL
 5 17 SAVING
 5 18 SAVING
 ;
run;

/*-------------------------------------------------------------------------------------------
Section 19.2
-------------------------------------------------------------------------------------------*/

PROC FREQ DATA = accounts;
 TABLE cust_id * account_type / NOPERCENT NOCOL; 
RUN;




PROC FREQ DATA  = Accounts ORDER = FREQ;
 TABLE Account_type;
RUN;



DATA Accounts;
 SET Accounts;
 FORMAT Account_Type2 $12.;
 IF UPCASE(Account_Type) IN ('MORTGAGE','SPECIAL') THEN 
                                       Account_Type2 = 'OTHERS';
 ELSE Account_Type2 = Account_Type;
RUN;

PROC FREQ DATA  = Accounts ORDER = FREQ;
 TABLE Account_type2;
RUN;






PROC FREQ DATA = Accounts NOPRINT;
 TABLE cust_id * Account_Type2 / OUT = Account_Freqs(DROP = Percent);
RUN;

PROC TRANSPOSE DATA = Account_Freqs
               OUT  = Account_Freqs_TP(DROP = _name_ _label_);
 BY Cust_ID;
 VAR Count;
 ID Account_Type2;
RUN;



DATA Accounts_Subject;
 SET Account_Freqs_TP ;
 FORMAT Checking_rel loan_rel saving_rel others_rel 8.;
 ARRAY account1 {*} Checking loan saving others;
 ARRAY account2 {*} Checking_rel loan_rel saving_rel others_rel;
 NR_Account = sum(of Checking loan saving others);
 DO i = 1 TO DIM(account1);
  IF account1{i} = . THEN account1{i} = 0;
  account2{i} = account1{i}/Nr_Account * 100;
 END;
DROP i;
RUN;






/*-------------------------------------------------------------------------------------------
Section 19.3
-------------------------------------------------------------------------------------------*/


DATA Accounts_Subject;
 SET Accounts_Subject;
 Account_Freqs  = CATX('_',Checking, Loan, Saving,Others);
 Account_RowPct = CATX('_',PUT(Checking_rel,3.), PUT (Loan_rel,3.),
                           PUT (Saving_rel,3.), PUT (Others_rel,3.));
RUN;




/*-------------------------------------------------------------------------------------------
Section 19.4
-------------------------------------------------------------------------------------------*/


PROC SQL NOPRINT;
 SELECT COUNT(DISTINCT account_type2) 
 INTO :NrDistinctAccounts 
 FROM accounts;

 CREATE TABLE Account_DistFreq
 AS SELECT Cust_ID,
        COUNT(account_type2) AS Nr_Account,
        COUNT(DISTINCT account_type2) AS Distinct_Count,
        CALCULATED Distinct_Count/CALCULATED Nr_Account*100 
                           AS Distinct_Prop FORMAT = 8.1,
        CALCULATED Distinct_Prop = 100 AS OnlyDistinctAccounts,
        CALCULATED Distinct_Count/&NrDistinctAccounts*100 
                           AS Possible_Prop FORMAT = 8.1,
        CALCULATED Possible_Prop = 100 AS AllPossibleAccounts
    FROM accounts
    GROUP BY Cust_ID;
QUIT;



/*-------------------------------------------------------------------------------------------
Section 19.5
-------------------------------------------------------------------------------------------*/


PROC PRINTTO PRINT = 'c:\data\tmpoutput.out'; 
RUN;
ODS OUTPUT CrossTabFreqs = Account_Freqs_ODS(WHERE=(_type_ = '11'));
PROC FREQ DATA = accounts;
 TABLE cust_id * account_type2 / EXPECTED MISSING;
RUN;

PROC PRINTTO PRINT= print ;
RUN;





PROC TRANSPOSE DATA = Account_Freqs_ODS(KEEP  = cust_id Account_Type2 Frequency)
               OUT    = Account_Freqs_TP(DROP = _name_ _label_)
               PREFIX = Freq_;
BY Cust_id;
VAR Frequency;
ID Account_Type2;
RUN;
PROC TRANSPOSE DATA = Account_Freqs_ODS(KEEP  = cust_id Account_Type2 RowPercent _TYPE_)
               OUT  = Account_RowPct_TP(DROP = _name_ _label_)
               PREFIX = RowPct_;
FORMAT RowPercent 8.;
BY Cust_id;
VAR RowPercent;
ID Account_Type2;
RUN;


DATA Customer_Accounts;
 MERGE Account_DistFreq
       Account_Freqs_TP
       Account_RowPct_TP;
 BY Cust_ID;
 Account_Freqs  = CATX('_',Freq_Checking, Freq_Loan, Freq_Others, Freq_Saving);
 Account_RowPct = CATX('_', put(RowPct_Checking,3.), put(RowPct_Loan,3.), put(RowPct_Others,3.), put(RowPct_Saving,3.));
RUN;








PROC TRANSPOSE DATA = Account_Freqs_ODS(KEEP  = cust_id Account_Type2 ColPercent)
               OUT  = Account_ColPct_TP(DROP = _name_ _label_)
               PREFIX = ColPct_;
FORMAT ColPercent 8.2;
BY Cust_id;
VAR ColPercent;
ID Account_Type2;
RUN;

DATA Account_freqs_ODS;
 SET Account_freqs_ODS;
ExpRatio = (Frequency-Expected)/Expected;
RUN;

PROC TRANSPOSE DATA = Account_Freqs_ODS(KEEP  = cust_id Account_Type2 ExpRatio)
               OUT  = Account_ExpRatio_TP(DROP = _name_ _label_)
               PREFIX = ExpRatio_;
FORMAT ExpRatio 8.2;
BY Cust_id;
VAR ExpRatio;
ID Account_Type2;
RUN;
