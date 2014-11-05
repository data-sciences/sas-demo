*Programs used in Cody's Collection of Popular SAS 
 Programming Tasks and How to Tackle Them;

*1-1;
*Converting character values to numeric;

data Num_Values;
   set Char_Values(rename=(Age = C_Age
                           Weight = C_Weight));
   Age = input(C_Age,best12.);
   Weight = input(C_Weight,best12.);
   drop C_:;
run;

*1-2;
*Macro to convert selected character variables to
 numeric variables;
%macro char_to_num(In_dsn=,   /*Name of the input data set*/                                                                            
                   Out_dsn=,  /*Name of the output data set*/                                                                           
                   Var_list=  /*List of character variables that you                                                                    
                                want to convert from character to                                                                       
                                numeric, separated by spaces*/);                                                                        
   /*Check for null var list */                                                                                                          
   %if &var_list ne %then %do;                                                                                                           
   /*Count the number of variables in the list */                                                                                       
   %let n=%sysfunc(countw(&var_list));                                                                                                  
   data &Out_dsn;                                                                                                                       
      set &In_dsn(rename=(                                                                                                             
      %do i = 1 %to &n;                                                                                                                 
      /* break up list into variable names */                                                                                           
         %let Var = %scan(&Var_list,&i);                                                                                                
      /*Rename each variable name to C_ variable name */                                                                                
         &Var = C_&Var                                                                                                                  
      %end;                                                                                                                             
      ));                                                                                                                               
                                                                                                                                        
   %do i = 1 %to &n;                                                                                                                   
      %let Var = %scan(&Var_list,&i);                                                                                                   
      &Var = input(C_&Var,best12.);                                                                                                     
   %end;                                                                                                                               
   drop C_:;                                                                                                                           
   run;                                                                                                                                 
  %end;                                                                                                                                 
%mend char_to_num;

*1-3;
*Test the macro;
%char_to_num(In_dsn=char_values, Out_dsn=Num_values,
             Var_list=Age Weight)
*1-4;
             *Converting a specific value such as 999 to a missing value for 
 all numeric variables in a SAS data set;

data Num_missing;
   set Demographic;
   array Nums[*] _numeric_;
   do i = 1 to dim(Nums);
      if Nums[i] = 999 then Nums[i] = .;
   end;
   drop i;
run;

*1-5;
*Converting a specific value such as "NA" to a missing value for all 
 character variables in a SAS data set;
data Char_missing;
   set Demographic;
   array Chars[*] _character_;
   do i = 1 to dim(Chars);
      if Chars[i] in ('NA' 'na') then Chars[i] = ' ';
   end;
   drop i;
run;

*1-6;
*Converting all character values to uppercase (or lower- or proper-case);
 data Upper;
   set Demographic;
   array Chars[*] _character_;
   do i = 1 to dim(Chars);
      Chars[i] = upcase(Chars[i]);
   end;
   drop i;
run;

*1-7;
*Reading data values that contain units;
 data No_Units;
   set Units;
   Weight_Lbs = input(compress(Weight,,'kd'),12.);
   if findc(Weight,'k','i') then Weight_lbs = Weight_lbs*2.2;
   Height = compress(Height,,'kds');
   Feet = input(scan(Height,1,' '),12.);
   Inches = input(scan(Height,2,' '),12.);
   if missing(Inches) then Inches = 0;
   Height_Inches = 12*Feet + Inches;
   drop Feet Inches;
run;

*1-8;
*Solution using Perl Regular expressions;
data No_Units;
   set Units(drop=Height);
   if _n_ = 1 then do;
      Regex = "/^(\d+)(\D)/";
      re = prxparse(Regex);
   end;
   retain re;
   if prxmatch(re,Weight) then do;
      Weight_Lbs = input(prxposn(re,1,Weight),8.);
      Units = prxposn(re,2,Weight);
      if upcase(Units) = 'K' then Weight_Lbs = Weight_Lbs*2.2;
   end;
   keep Subj Weight Weight_Lbs;
run;

*2-1;
*Grouping values using if-then-else statements;
data Grouped;
   length HR_Group $ 10.;
   set Blood_Pressure(keep=Subj Heart_Rate);
   if missing(Heart_Rate) then HR_Group = ' ';
   else if Heart_Rate lt 40 then HR_Group = '<40';
   else if Heart_Rate lt 60 then HR_Group = '40-<60';
   else if Heart_Rate lt 80 then HR_Group = '60-<80';
   else if Heart_Rate lt 100 then HR_Group = '80-<100';
   else HR_Group = '100 +';
run;

*2-2;
*Grouping values using formats;
proc format;
   value HRgrp 0 - <40  = '<40'
               40 - <60 = '40-<60'
               60 - <80 = '60-<80'
               80 - <100 = '80-<100'
               100 - high = '100 +';
run;
data Grouped;
   set Blood_Pressure(keep=Subj Heart_Rate);
   HR_Group = put(Heart_Rate,HRgrp.);
run;

*2-3;
proc rank data=Raw_Data out=Rank_Data;
   var X;
   ranks Rank_X;
run;

*2-4;
proc rank data=Raw_Data(keep=Subj X) out=Rank_Data groups=2;
   var X;
   ranks Rank_X;
run;

*2-5;
*Grouping using PROC RANK;
proc rank data=Blood_Pressure(Keep=Subj Heart_Rate)
          out=Grouped groups=5;
   var Heart_Rate;
   ranks HR_Group;
run;

*3-1;
*Computing the mean of all observations and outputting it to a
 SAS data set;
proc means data=Blood_Pressure noprint;
   var Heart_Rate;
   output out=Summary(keep=Mean_HR) mean=Mean_HR;
run;

*3-2;
*Computing the mean for each value of a BY variable;
proc sort data=Blood_Pressure;
   by Drug;
run;

proc means data=Blood_Pressure noprint;
   by Drug;
   var Heart_Rate;
   output out=Summary mean=Mean_HR;
run;

*3-3;
*Using PROC MEANS to create a summary data set;
proc means data=Blood_Pressure noprint;
   class Drug;
   var Heart_Rate;
   output out=Summary mean=Mean_HR;
run;

*3-4;
*Demonstrating the NWAY option;
proc means data=Blood_Pressure noprint nway;
   class Drug;
   var Heart_Rate;
   output out=Summary mean=Mean_HR;
run;

*3-5;
*Demonstrating the AUTONAME option;
proc means data=Blood_Pressure noprint nway;
   class Drug;
   var Heart_Rate;
   output out=Summary(drop=_type_ _freq_)
      n= mean= min= max= / autoname;
run;

*3-6;
*Demonstrating the CHARTYPE procedure option;
proc means data=Blood_Pressure noprint chartype;
   class Drug Gender;
   var Heart_Rate;
   output out=Summary mean=Mean_HR;
run;

*3-7;
data Grand(drop=Drug Gender) 
     ByGender(drop=Drug)
     ByDrug(drop=Gender)
     ByDrugGender;
     drop _type_ _freq_;
   set Summary;
   if _type_ = '00' then output Grand;
   else if _type_ = '01' then output ByGender;
   else if _type_ = '10' then output ByDrug;
   else if _type_ = '11' then output ByDrugGender;
run;

*3-8;
*Program to compare each person's heart rate with the mean heart 
 rate of all the observations;
proc means data=Blood_Pressure noprint;
   var Heart_Rate;
   output out=Summary(keep=Mean_HR) mean=Mean_HR;
run;

*3-9;
data Percent_of_Mean;
   set Blood_Pressure(keep=Heart_Rate Subj);
   if _n_ = 1 then set Summary;
   Percent = round(100*(Heart_Rate / Mean_HR));
run;

3-10;
*Solution using PROC SQL;
proc sql;
   create table Percent_of_Mean as
   select Subj,Heart_Rate,Mean_HR
   from Blood_Pressure, Summary;
quit;

*3-11;
*PROC SQL solution not using PROC MEANS;
proc sql;
   create table Percent_of_Mean as
   select Subj,Heart_Rate, round(100*Heart_Rate / mean(Heart_Rate))
      as Percent
   from Blood_Pressure;
quit; 

*3-12;
*Solution using a macro variable;
data _null_;
   set summary;
   call symputx('Macro_Mean',Mean_HR);
run;

*3-13;
proc sql noprint;
   select mean(Heart_Rate)
   into :Macro_Mean
   from Blood_Pressure;
quit;

*3-14;
data Percent_of_Mean;
   set Blood_Pressure(keep=Heart_Rate Subj);
   Percent = round(100*(Heart_Rate / &Macro_Mean));
run;

*3-15;
*Program to compare each person's heart
 rate with the mean heart rate for each
 value of Gender;

proc means data=Blood_Pressure noprint nway;
   class Gender;
   var Heart_Rate;
   output out=By_Gender(keep=Gender Mean_HR) mean=Mean_HR;
run;

*3-16;
proc sort data=Blood_Pressure;
   by Gender;
run;

data Percent_of_Mean;
   merge Blood_Pressure(keep=Heart_Rate Gender Subj) By_Gender;
   by Gender;
   Percent = round(100*(Heart_Rate / Mean_HR));
run;

*Put the observations back in Subj order;
proc sort data=Percent_of_Mean;
   by Subj;
run;

*4-1;
*Concatenating SAS data sets;
data Combined;
   set Name1 Name2;
run;

*4-2;
*Method 2 - Using PROC APPEND;
proc append base=Name1 data=Name2;
run;

*4-3;
*Attempting to combine data sets with character variables
 of different lengths using the FORCE option;
proc append base=Name2 data=Name3 force;
run;

*4-4;
Data Combined;
   length Gender $2 Name $ 18;
   set Name2 Name3;
run;

*4-5;
proc contents data=Name2 noprint 
   out=Out1(keep=Name Type Length where=(Type=2));
run;
proc contents data=Name3 noprint 
   out=Out2(keep=Name Type Length where=(Type=2));
run;

*4-6;
data _null_;
      merge Out1 
            Out2(rename=(Length=Length2))
            end=last;
      by Name;
      file "c:\books\tasks\Combined.sas";
 
   if _n_ = 1 then put "Data Combined;";
   L = max(Length,Length2);
   put "   length " Name " $ " L 3. ";";
   if Last then do;
      put "   set Name1 Name2;";
      put "run;";
   end;
run;

%include "combined.sas";

*4-7;
Data Combined;
   length Gender  $   2;
   length Name  $  18;
   set Name1 Name2;
run;

*4-8;
*Using a macro to concatenate two data sets that contain
 character variables of different lengths;

%macro Concatenate
   (Dsn1=,     /*Name of the first data set    */
    Dsn2=,     /*Name of the second data set   */
    Out=       /*Name of combined data set     */);
   
   proc contents data=&Dsn1 noprint 
      out=out1(keep=Name Type Length where=(Type=2));
   run;

   proc contents data=&Dsn2 noprint 
      out=out2(keep=Name Type Length where=(Type=2));
   run;

   data out1;
      set out1;
      Name = propcase(Name);
   run;

   data out2;
      set out2;
      Name = propcase(Name);
   run;

   data _null_;
      file "c:\books\tasks\combined.sas";
      merge out1 out2(rename=(Length=Length2)) end=Last;
      by Name;
      if _n_ = 1 then put "Data &out;";
      l = max(Length,Length2);
      put "   length " Name " $ " L 2. ";";
      if Last then do;
         put "   set &Dsn1 &Dsn2;";
         put "run;";
      end;
   run;

   %include "c:\books\tasks\Combined.sas";

%mend concatenate;

*4-9;
*Testing the macro;
%Concatenate(Dsn1=Name2, Dsn2=name3, out=Combined)

title "Contents of COMBINED";
proc contents data=combined;
run;

*4-10;
*Updating values in a SAS data set using a transaction data set;
Data New_Prices;
   input Item_Number : $4. Price;
datalines;
2002 5.98
4006 16.98
;

proc sort data=Hardware;
   by Item_Number;
run;

proc sort data=New_Prices;
   by Item_Number;
run;

Data Hardware_June2012;
   update Hardware New_Prices;
   by Item_Number;
run;

*4-11;
data Hardware;
   modify Hardware New_Prices;
   by Item_Number;
run;

*4-12;
*Use "Named Input" method to create the transaction data set;
data New_Values;
   informat Gender $6. Party $10. DOB Date9.;
   input Subj= Score= Weight= Heart_Rate= DOB= Gender= Party=;
   format DOB date9.;
datalines;
Subj=2 Score=72 Party=Republican
Subj=7 DOB=26Nov1951 Weight=140
;

*4-13;
proc sort data=Demographic;
   by Subj;
run;
proc sort data=New_Values;
   by Subj;
run;

Data Demographic_June2012;
   update Demographic New_Values;
   by Subj;
run;

*4-14;
proc sql;
   create table Possible_Matches as
   select * from Name_One, Name_Two
   where spedis(upcase(Name1),upcase(Name2)) between 1 and 25 and
   DOB1 eq DOB2 and
   Gender1 eq Gender2;
quit;

proc sql;
   create table Exact_Matches as
   select * from Name_One, Name_Two
   where spedis(upcase(Name1),upcase(Name2)) eq 0 and
   DOB1 eq DOB2 and
   Gender1 eq Gender2;
quit;

*5-1;
*Program to create a control data set from a SAS data set;
data Control;
   set Codes(rename=
            (ICD9 = Start
             Description = Label));
   retain Fmtname '$ICDFMT'
          Type 'C';
run;

*5-2;
proc format cntlin=Control;
   select $ICDFMT;
run;

*Using the CNTLIN= created data set;
data disease;
   input ICD9 : $5. @@;
datalines;
020 410 500 493
;
title "Listing of DISEASE";
proc report data=disease nowd headline;
   columns ICD9=Unformatted ICD9;
   define ICD9 / "Formatted Value" width=11 format= $ICDFMT.;
   define Unformatted / "Original Unformatted Value" width=11;
run;

*5-3;
*Adding an OTHER category to your format;
data control;
   set Codes(rename=
            (ICD9 = Start
             Description = Label))
             End = Last;
   retain Fmtname '$ICDFMT'
          Type 'C';
   output;
   if Last then do;
      HLO = 'o';
      Label = 'Not Found';
      output;
   end;
run;

title "Adding OTHER Category";
proc format cntlin=Control;
   select $ICDFMT;
run;

*5-4;
*Adding new formats to an existing format using a CNTLOUT data set;
proc format cntlout=Control_Out;
   select $icdfmt.;
run;

data New_control;
   length Label $ 25;
   set Control_Out(drop=End) end=Last;
   output;
   if Last then do;
      Hlo = ' ';
      Start = '427.5';
      Label = 'Cardiac Arrest';
      output;
      Start = '466';
      Label = 'Bronchitis - nonspecific';
      output;
   end;
run;

proc format cntlin=New_control;
   select $ICDFMT;
run;

*6-1;
proc sort data=Goals;
   by Year;
run;

proc sort data=Sales;
   by Year;
run;

data Sales_Goals;
   merge Goals Sales;
   by Year;
   Difference = Sales - Goal;
run;

proc sort data=Sales_Goals;
   by Sales_ID Year;
run;

*6-2;
*Creating the INFORMAT "manually" using PROC FORMAT;
proc format;
   invalue Goalfmt 2004=20
                   2005=21
                   2006=24
                   2007=28
                   2008=34
                   2009=40
                   2010=49
                   2011=60
                   2012=75;
run;

*6-3;
data Sales_Goals;
   set Sales;
   Goal = input(put(Year,4.),goalfmt.);
   Difference = Sales - Goal;
run;

*6-4;
*Creating the INFORMAT using a CNTLIN data set;
data Control;
   set Goals(rename=(Year=Start Goal=Label));
   retain Fmtname '@goalfmt' Type 'I';
run;

proc format cntlin=Control;
   select @goalfmt;                 
run;

*6-5;
*Load a temporary with the Goals data;
data Sales_Goals;
   array Goalsarray[2004:2012] _temporary_;
   if _n_ = 1 then do Year = 2004 to 2012;
      set Goals;
      goalsarray[Year] = Goal;
   end;

   set Sales;
   Difference = Sales - Goalsarray[Year];
run;

*6-6;
*Twoway table lookup using temporary arrays;
data Two_Way;
   array Goals_Job[2004:2012,4] _temporary_;
   if _n_ = 1 then do Year = 2004 to 2012;
      do Job = 1 to 4;
         set Goals_Job;
         Goals_Job[Year,Job] = Goal;
      end;
   end;

   set Sales_Job;
   drop Goal Job;
   Difference = Sales - Goals_Job[Year,Job];
run;

*7-1;
*One observation per subject to several observations per subject
 Data step approach;

data ManyPer;
   set OnePer;
   array Dx[3];
   do Visit = 1 to 3;
      if not missing(Dx[Visit]) then do;
         Diagnosis = Dx[Visit];
         output;
      end;
   end;
   keep Subj Diagnosis Visit;
run; 

*7-2;
*PROC TRANSPOSE solution;
*First try;
proc transpose data=oneper 
               out=manyper;
   by Subj;
   var Dx1-Dx3;
run;

*7-3;
proc transpose data=OnePer 
               out=ManyPer(rename=(col1=Diagnosis)
                          drop=_name_
                          where=(Diagnosis is not null));
   by Subj;
   var Dx1-Dx3;
run;

*7-4;
*Going from a data set with several observations per subject
 to on with one observation per subject.;

proc sort data=ManyPer;
   by Subj Visit;
run;

data OnePer;
   set ManyPer;
   by Subj;
   array Dx[3];
   retain Dx1-Dx3;
   if first.Subj then call missing(of Dx1-Dx3);
   Dx[Visit] = Diagnosis;
   if last.Subj then output;
   keep Subj Dx1-Dx3;
run;

*7-5;
proc transpose data=ManyPer out=OnePer(drop=_Name_)
   prefix=Dx;
   by Subj;
   id Visit;
   var Diagnosis;
run;

*8-1;
*Computing a person's age, given a date of birth;
data Compute_Age;
   set Demographic;
   Age_Exact = yrdif(DOB,'01jan2012'd);
   Age_Last_Birthday = int(Age_Exact);
run;

*8-2;
*Creating a SAS date when the day of the month may be missing;
data Compute_Date;
   set MoDayYear;
   if missing(Day) then Date = MDY(Month,15,Year);
   else Date = MDY(Month,Day,Year);
   format Date date9.;
run;

*8-3;
*Alternative (elegant) solution suggested by Mark Jordan;
data Compute_Date;
   set MoDayYear;
   Date = MDY(Month,coalesce(Day,15),Year);
   format Date date9.;
run;

*9-1;
*Method using known ranges;
title "Listing of Patient Numbers and Invalid Data Values";
data _null_;
   set Blood_Pressure;
   file print;
   ***Check Heart_Rate;
   if (Heart_Rate lt 40 and not missing(Heart_Rate)) or 
      Heart_Rate gt 100 then put Subj= @10 Heart_Rate=;
   ***Check SBP;
   if (SBP lt 80 and not missing(SBP)) or 
      SBP gt 200 then put Subj= @10 SBP=;
   ***Check DBP;
   if (DBP lt 60 and not missing(DBP)) or 
      DBP gt 120 then put Subj= @10 DBP=;
run;

*9-2;
*Macro to perform range checking for numeric variables;
%macro Errors(Var=,    /* Variable to test     */
              Low=,    /* Low value            */
              High=,   /* High value           */
              Missing=IGNORE 
                       /* How to treat missing values         */
                       /* Ignore is the default.  To flag     */
                       /* missing values as errors set        */
                       /* Missing=error                       */);
data Tmp;
   set &Dsn(keep=&Idvar &Var);
   length Reason $ 10 Variable $ 32;
   Variable = "&Var";
   Value = &Var;
   if &Var lt &Low and not missing(&Var) then do;
      Reason='Low';
      output;
   end;
   %if %upcase(&Missing) ne IGNORE %then %do;
   else if missing(&Var) then do;
      Reason='Missing';
      output;
   end;
   %end;

   else if &Var gt &High then do;
      Reason='High';
      output;
      end;
      drop &Var;
   run;
   proc append base=Errors data=Tmp;
   run;

%mend errors;

*9-3;
*Macro to generate an error report after the errors macro has been run;
%macro report;
   proc sort data=errors;
      by &Idvar;
   run;
   
   proc print data=errors;
      title "Error Report for Data Set &Dsn";
      id &Idvar;
      var Variable Value Reason;
   run;

   proc datasets library=work nolist;
      delete errors;
      delete tmp;
   run;
   quit;

%mend report;

*9-4;
*Test the macro;
%let Dsn = Blood_Pressure;
%let Idvar = Subj;
%errors(Var=Heart_Rate, Low=40, High=100, Missing=error)
%errors(Var=SBP, Low=80, High=200, Missing=ignore)
%errors(Var=DBP, Low=60, High=120, Missing=ignore)

%report

*9-5;
*Method using automatic outlier detection;
%macro Auto_Outliers(
   Dsn=,      /* Data set name                        */
   ID=,       /* Name of ID variable                  */
   Var_list=, /* List of variables to check           */
              /* separate names with spaces           */
   Trim=.1,   /* Integer 0 to n = number to trim      */
              /* from each tail; if between 0 and .5, */
              /* proportion to trim in each tail      */
   N_sd=2     /* Number of standard deviations        */);
   ods listing close;
   ods output TrimmedMeans=Trimmed(keep=VarName Mean Stdmean DF);
   proc univariate data=&Dsn trim=&Trim;
     var &Var_list;
   run;
   ods output close;

   data Restructure;
      set &Dsn;
      length Varname $ 32;
      array vars[*] &Var_list;
      do i = 1 to dim(vars);
         Varname = vname(vars[i]);
         Value = vars[i];
         output;
      end;
      keep &ID Varname Value;
   run;

   proc sort data=trimmed;
      by Varname;
   run;

   proc sort data=restructure;
      by Varname;
   run;

   data Outliers;
      merge Restructure Trimmed;
      by Varname;
      Std = StdMean*sqrt(DF + 1);
      if Value lt Mean - &N_sd*Std and not missing(Value) 
         then do;
            Reason = 'Low  ';
            output;
         end;
      else if Value gt Mean + &N_sd*Std
         then do;
         Reason = 'High';
         output;
      end;
   run;

   proc sort data=Outliers;
      by &ID;
   run;

   ods listing;
   title "Outliers Based on Trimmed Statistics";
   proc print data=Outliers;
      id &ID;
      var Varname Value Reason;
   run;

   proc datasets nolist library=work;
      delete Trimmed;
      delete Restructure;
   run;
   quit;
%mend auto_outliers;

*9-6;
*Testing the auto_outliers macro;
%auto_outliers(Dsn=Blood_Pressure,
               ID=Subj,
               Var_List=Heart_Rate SBP DBP,
               N_Sd=2.5) 

*10-1;
*A traditional approach to reading a combination
 of character and numeric data;
data Temperatures;
   input Dummy $ @@;
   if upcase(Dummy) = 'N' then Temp = 98.6;
   else Temp = input(Dummy,8.);
   if Temp gt 106 or Temp lt 96 then Temp = .;;
   drop Dummy;
datalines;
101 N 97.3 111 n N 104.5 85 
;

*10-2;
*Using an enhanced numeric informat to read 
 a combination of character and numeric data;
proc format;
   invalue readtemp(upcase)
                96 - 106 = _same_
                'N'      = 98.6
                other    = .;
run;
data Temperatures;
   input Temp : readtemp5. @@;
datalines;
101 N 97.3 111 n N 67 104.5 85
;

*10-3;
proc format;
   invalue readgrade(upcase just)
      'A' = 95
      'B' = 85
      'C' = 75
      'F' = 65
      other = _same_;
run;

data School;
   input ID : $3. Grade : readgrade3.;
datalines;
001 97 
002 99 
003  A 
004 C 
005 72 
006   f 
007 b
;

*11-1;
*Using PROC SORT to detect duplicate BY values;
proc sort data=Duplicates out=Sorted nodupkey;
   by Subj;
run;

*11-2;
*Using PROC SORT to detect duplicate records;
proc sort data=Duplicates out=Sorted noduprecs;
   by Subj;
run;

*11-3;
*Demonstrating a feature) of noduprecs;
proc sort data=Multiple out=Features noduprecs;
   by Subj;
run;

*11-4;
*Possible solution to the problem;
proc sort data=Multiple out=Features noduprecs;
   by _all_;
run;

*11-5;
proc sort data=Duplicates out=Sorted_Duplicates;
   by Subj;
run;

data _null_;
   set Sorted_Duplicates;
   by Subj;
   put Subj= First.Subj= Last.Subj=;
run;

*11-6;
proc sort data=Duplicates out=Sorted_Duplicates;
   by Subj;
run;

data Last;
   set Sorted_Duplicates;
   by Subj;
   if Last.Subj;
run;

*11-7;
*Using a DATA step to detect duplicate BY values;
proc sort data=Duplicates out=Sorted_Duplicates;
   by Subj;
run;

data Dups;
   set Sorted_Duplicates;
   by Subj;
   if first.Subj and last.Subj then delete;
run;

*11-8;
proc sort data=Two_Records;
   by Subj;
run;

data Not_Two;
   set Two_Records;
   by subj;
   if first.Subj then n=0;
   n + 1;
   if last.Subj and n ne 2 then output;
run;

*11-9;
*Computing inter-patient differences;
proc sort data=Visits;
   by Patient Visit;
run;

data Difference;
   set Visits;
   by Patient;
   Diff_Wt = Weight - lag(Weight);
   if not first.Patient then output;
run;

*11-10;
*Computing the difference between the first and last visit;
proc sort data=Visits;
   by Patient Visit;
run;

data First_Last;
   set Visits;
   by Patient;
   *Delete observations where only one visit;
   if first.Patient and last.Patient then delete;
   retain First_Wt;
   if first.Patient then First_Wt = Weight;
   if last.Patient then do;
      Diff_Wt = Weight - First_Wt;
      output;
   end;
run;

*11-11;
*Redoing the previous program using the LAG function;
data _First_Last;
   set Visits;
   by Patient;
   *Delete observations where only one visit;
   if first.Patient and last.Patient then delete;
   if first.Patient or last.Patient then Diff_wt = Weight - lag(Weight);
   if last.Patient then output;
run;

*12-1;
*Determining the number of observations in a SAS data set;
*Using the SET option NOBS=;

data New;
   set Stocks nobs=Number_of_obs;
   if _n_ =1 then
      put "The number of observations in data set STOCKS is: "
           Number_of_obs;
   How_Far = _n_ / Number_of_obs;
run;

*12-2;
*Putting the number of observations in a SAS data set into
 a macro variable;
data _null_;
   if 0 then set Stocks nobs=Number_of_obs;
   call symputx('N_of_obs',Number_of_obs);
   stop;
run;
data _null_;
   put "The number of observations in STOCK is &N_of_obs";
run;

*12-3;
%let Start = %eval(&N_of_obs - 4);

data Last_Five;
   set Stocks(firstobs=&Start);
run;

*12-4;
*Method using library tables;
data _null_ ;
  set sashelp.vtable;
  where libname="WORK" and memname="STOCKS" ;
  ***Note: You must use uppercase values for libname and memname;
  Num_obs=Nobs-Delobs;
  ***Nobs is total number of observations, including deleted ones
     Delobs is the number of deleted observations;
  put "Nobs - Delobs: num_obs = " num_obs;
run;

*12-5;
*Using SAS functions;
data _null_;
   Exist = exist("stocks");
   if Exist then do;
      Dsid = open("Stocks");
      Num_obs = attrn(Dsid,"Nlobs");
      *Nlobs is the number of logical observations,
       observations not marked for deleting;
      put "Number of observations in STOCK is: " Num_obs;
   end;
   else put "Data set STOCKS does not exist";
   RC = close(Dsid);
run;

*12-6;
*Counting the number of a specific response in a list of variables;
*"Old Fashioned" solution;

data Count_YN;
   set Questionnaire;
   array Q[5];
   Num_Y = 0;
   Num_N = 0;
   do i = 1 to 5;
      if upcase(Q[i]) eq 'Y' then Num_Y + 1;
      else if upcase(Q[i]) eq 'N' then Num_N + 1;
   end;
   drop i;
run;

*12-7;
*Solution using the Count and Cats functions;
data Count_YN;
   set Questionnaire;
   Num_Y = countc(cats(of Q1-Q5),'Y','i');
   Num_N = countc(cats(of Q1-Q5),'N','i');
run;

*12-8;
*How to compute a moving average;
data Moving;
   set Stocks;
   Last = lag(Price);
   Twoback = lag2(Price);
   if _n_ ge 3 then Moving = mean(of Price,Last,Twoback);
run;
title "Plots of Stock Price and Three Day Moving Average";
proc sgplot data=moving;
   series x=Date y=Price;
   series x=Date y=Moving;
run;

*12-9;
*Presenting a macro to compute moving averages;

%macro moving_Ave(In_dsn=,     /*Input data set name          */
                  Out_dsn=,    /*Output data set name         */
                  Var=,        /*Variable on which to compute
                                 the average                  */
                  Moving=,     /* Variable for moving average */
                  n=           /* Number of observations on which
                                  to compute the average      */);
   data &Out_dsn;
      set &In_dsn;
        ***compute the lags;
      _x1 = &Var;
      %do i = 1 %to &n - 1;
         %let Num = %eval(&i + 1);
          _x&Num = lag&i(&Var);
      %end;

        ***if the observation number is greater than or equal to the
           number of values needed for the moving average, output;
   if _n_ ge &n then do;
      &Moving = mean (of _x1 - _x&n);
      output;
      end;
      drop _x: ;
   run;
%mend moving_ave;

*12-10;
*Testing the macro;
%moving_ave(In_dsn=Stocks,
            Out_dsn=Moving_stocks,
            Var=Price,
            Moving=Average,
            n=5)

*12-11;
*Replacing the first 8 digits of a credit card number
 with asterisks;

*Using substrings and concatenation functions;
data Credit_Report;
   length Last_Four $ 12;
   set Credit;
   Last_Four = cats('********',substr(Account,9));
run;

*12-12;
*Using the SUBSTR function on the left-hand side of the equal sign;
data Credit_report;
   set Credit;
   Last_Four = Account;
   substr(Last_Four,1,8) = '********';
run;

*12-13;
*Sorting within an observation: Using the ORDINAL function;
data Ordered_Scores;
   set Scores;
   array Score[10];
   array Sorted[10];
   do i = 1 to 10;
      Sorted[i] = ordinal(i, of Score[*]);
   end;
   drop i;
run;

*12-14;
*Soring within an observation: Using CALL SORTN;
data Ordered_Scores;
   set Scores;
   call sortn(of Score1-Score10);
run;

*12-15;
*Soring within an observation: Using CALL SORTN;
data Ordered_Scores;
   set Scores;
   call sortn(of Score1-Score10);
   Average = mean(of Score3-Score10);
run;

*12-16;
*Extracting the first and last name (possibly a middle initial)
 from a variable containing first (possibly middle) and last name
 in a single variable;
Data Seperate;
   set Full_Name;
   First = scan(Name,1,' ');
   Last = Scan(Name,-1,' ');
   Middle = scan(Name,2,' ');
   if missing(Scan(Name,3)) then Middle = ' ';
run;


