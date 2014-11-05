/*-------------------------------------------------------------------------------------------
Compare Datasets
-------------------------------------------------------------------------------------------*/

data old;
 set mining.kunden_crm;
 keep kundennr alter betreuer geschlecht kontoanzahl kontobausparabs kontobausparprz produktkauf;
run;
data new;
 set meta_tmp.chap25_mart;
 keep custid alter  gender nraccounts branch churn;* kontobausparabs kontobausparprz;
run;

/*-------------------------------------------------------------------------------------------
Change Flag
-------------------------------------------------------------------------------------------*/
data change_flag;
 set meta_tmp.chap25_mart;
 if    (
       loanpct > 50
   or  alter > 40 
   or  branch = 'Fil2'
   or  savingaccountpct > 50
   or  gender = 'male') 
   and uniform(1234899) > 0.85
 then ValueSegmentNew = '8. LOST';
 else if uniform(123444899) > 0.85 then ValueSegmentNew = lag(ValueSegmentNew);
run; 

proc freq;
 table churn*flag/ missing;
 run;


data change_flag_ids;
 set change_flag;
 *if flag = 1 and churn=0;
 keep custid date ValueSegmentNew;
 date = '01AUG2003'd;
run;


/*-------------------------------------------------------------------------------------------
Update der chap25.scores
-------------------------------------------------------------------------------------------*/

*** Save old scores;
data chap25.scores_old;
 set chap25.scores;
run;

proc freq data = chap25.scores;     table ValueSegment;run;
proc freq data = chap25.scores_old; table ValueSegment;run;

data chap25.scores;
 merge chap25.scores
       change_flag_ids(in=in2);
 by custid date;
 *if in2 then ValueSegment = '8. LOST';
 ValueSegment = ValueSegmentNew;
run;

proc freq data = chap25.scores; 
 table ValueSegment;
run;

*** Durchführung im DI-Studio;

*** Neue Verteilung;

proc freq data = meta_tmp.chap25_mart;
 table churn;
run;



/*-------------------------------------------------------------------------------------------
Verwende die Verteilung von Produktkauf
-------------------------------------------------------------------------------------------*/

data old_target;
 set old;
 keep kundennr produktkauf date;
 rename kundennr = CustID;
 rename ProduktKauf = Churn;
  date = '01AUG2003'd;
run;


proc sort data = old_target;
 by custid date;
run;

*** Erzeuge Bestand für Input DS;
data new_july; 
 set old_target;
 if churn=1;
 date = '01JUL2003'd;
 drop Churn;
run;


data chap25.scores;
 merge chap25.scores_old(in=in1)
       old_target(in=in2);
 by custid date;
 *if in1;
 if Churn=1 then ValueSegment = '8. LOST';
 else ValueSegment = lag(ValueSegment);
 if _N_ = 1 then ValueSegment = '3. BRONCE';
run;


*** Erzeuge Bestand für Input DS;
data new_july; 
 set old_target;
 if churn=1;
 date = '01JUL2003'd;
 drop Churn;
run;


data chap25.scores;
 set chap25.scores new_july;
run;

proc sort data = chap25.scores nodupkey;
 by custid date;
run;

data chap25.scores;
 set chap25.scores;
 if valuesegment = '' then valuesegment = lag(valuesegment);
 if scoreid = . then scoreid = lag(scoreid);
 drop churn;
 run;



proc freq data = chap25.scores;
 table Churn;
 run;


