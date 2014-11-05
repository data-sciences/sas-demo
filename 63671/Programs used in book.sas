libname example 'c:\books\statistics by example';
%include 'c:\books\statistics by example\create_datasets.sas';

*Program 1.1;
*Note: you have to run the Import Wizard first to create this data set;
proc print data=SampleData;
run;

*Program 1.2;
title "Displaying the Descriptor Portion of a SAS Data Set";
proc contents data=SampleData;
run;

*Program 1.3;
data Sample2;
   infile 'c:\books\statistics by example\delim.txt';
   length Gender $ 1;
   input ID Age Gender $;
run;

*Program 1.4;
title "Listing of Data Set Sample2";
proc print data=Sample2;
run;

*Program 1.5;
data Sample2;
   infile 'c:\books\statistics by example\comma.csv' dsd;
   length Gender $ 1;
   input ID Age Gender $;
run;

*Listing of example.Blood_Pressure;
title "First 25 Observations from Blood_Pressure";
proc print data=example.blood_pressure(obs=25) noobs;
run;


*Program 2.1;
libname example 'c:\books\statistics by example';

title "Descriptive Statistics for SBP and DBP";
proc means data=example.Blood_Pressure n nmiss mean std median maxdec=3;
   var SBP DBP;
run;

*Program 2.2;
title "Descriptive Statistics Broken Down by Drug";
proc means data=example.Blood_Pressure n nmiss mean std median maxdec=3;
   class Drug;
   var SBP DBP;
run;

*Program 2.3;
title "Descriptive Statistics Broken Down by Drug";
proc means data=example.Blood_Pressure n nmiss 
           mean std median  printalltypes maxdec=3;
   class Drug;
   var SBP DBP;
run;

*Program 2.4;
title "Computing a 95% Confidence Interval and the Standard Error";
proc means data=example.Blood_Pressure n mean clm stderr
           maxdec=3;
   class Drug;
   var SBP DBP;
run;

*Program 2.5;
title "Demonstrating PROC UNIVARIATE";
proc univariate data=example.Blood_Pressure;
   id Subj;
   var SBP DBP;
   histogram;
   probplot / normal(mu=est sigma=est);
run;

*Program 2.5 (with MIDPOINTS option);
*Note shown in the text;
title "Demonstrating MIDPOINT= Histogram Option";
proc univariate data=example.Blood_Pressure;
   id Subj;
   var SBP;
   histogram / normal midpoints=100 to 170 by 5;
   probplot / normal(mu=est sigma=est);
run;

*Program 2.6;
title "Using SGPLOT to Produce a Histogram";
proc sgplot data=example.Blood_Pressure;
   histogram SBP;
run;

*Program 2.7;
title "Using SGPLOT to Produce a Box Plot";
proc sgplot data=example.Blood_Pressure;
   hbox SBP;
run;

*Program to make a temporary SAS data set Blood_Pressure_Out that
contains two outliers, one for Subj 5, one for Subj 55;
data Blood_Pressure_Out;
   set example.Blood_Pressure(keep=Subj SBP);
   if Subj = 5 then SBP = 200;
   else if Subj = 55 then SBP = 180;
run;

*Program 2.8;
title "Demonstrating How Outliers are Displayed with a Box Plot";
proc sgplot data=Blood_Pressure_Out;
   hbox SBP;
run;

*Program 2.9;
title "labeling Outliers on a Box Plot";
proc sgplot data=Blood_Pressure_Out;
   hbox SBP / datalabel=Subj;
run;

title "Box Plots of SBP for Each Value of Drug";
proc sgplot data=example.Blood_Pressure;
   hbox SBP / category=Drug;
run;

*Program 3.1;
title "Computing Frequencies and Percentages Using PROC FREQ";
proc freq data=example.Blood_Pressure;
   tables Gender Drug;
run;

*Program 3.2;
title "Demonstrating the NOCUM Tables Option";
proc freq data=example.Blood_Pressure;
   tables Gender Drug / nocum;
run;

*Program 3.3;
title "Demonstrating the effect of the MISSING Option";
proc freq data=example.Blood_Pressure;
   tables Gender Drug / nocum missing;
run;

*Program 3.4;
title "Computing Frequencies on a Continuous Variable";
proc freq data=example.Blood_Pressure;
   tables SBP / nocum;
run;

*Program 3.5;
proc format;
   value $gender 'M' = 'Male'
                 'F' = 'Female';
   value sbpgroup low-140 = 'Normal'
         141-high         = 'High';
   value dbpgroup low-80 = 'Normal'
         81-high         = 'High';
run;

proc freq data=example.Blood_Pressure;
   tables Gender SBP DBP / nocum;
   format Gender $gender.
          SBP sbpgroup.
          DBP dbpgroup.;
run;

*Program 3.6;
goptions reset=all;
pattern value = solid color = blue;
title "Generating a Bar Chart - Using PROC GCHART";
proc gchart data=store;
   vbar Region;
run;
quit;

*Program 3.7;
title "Generating a Bar Chart - Using PROC SGPLOT";
proc sgplot data=store;
   vbar Region;
run;

*Program 3.8;
ods pdf file='c:\books\statistics by example\bar.pdf'
        style=journal;
ods listing close;
proc sgplot data=store;
   vbar Region;
run;
quit;
ods pdf close;
ods listing;

*Program 3.9;
title "Demonstrating a Cross-Tabulation Table using PROC FREQ";
proc freq data=store;
   tables Gender * Region;
run;

*Program 3.10;
proc format;
   value $region 'North' = '1 North'
                 'East'  = '2 East'
                 'South' = '3 South'
                 'West'  = '4 West';
run;

title "Change the Order in a PROC FREQ Output";
proc freq data=store order=formatted;
   tables Gender * Region;
   format Region $region.;
run;

*Program 4.1;
title "Creating a Scatter Plot Using PROC GPLOT";
symbol value=dot;
proc gplot data=store;
   plot Book_Sales * Music_Sales;
run;
quit;

*Program 4.2;
goptions reset=all;
title "Creating a Scatter Plot Using PROC GPLOT";
title2 "Adding Gender Information to the Plot";
symbol1 color=black value=dot;
symbol2 color=black value=square;
proc gplot data=store;
   plot Book_Sales * Music_Sales = Gender;
run;
quit;

*Program 4.3;
title "Using PROC SGPLOT to Produce a Scatter Plot";
proc sgplot data=store;
   scatter x=Book_Sales y=Music_Sales;
run;
quit;

*Program 4.4;
title "Using PROC SGPLOT to Produce a Scatter Plot";
title2 "Adding Gender Information to the Plot";
proc sgplot data=store;
   scatter x=Book_Sales y=Music_Sales / group=Gender;
run;
quit;

*Program 4.5;
title "Demonstrating the PLOT Statement of PROC SGSCATTER";
proc sgscatter data=store;
   plot Book_Sales * Music_Sales  Total_Sales * Electronics_Sales;
run;

*Program 4.6;
title "Comparing Total Sales to Book, Music, and Electronics Sales";
proc sgscatter data=store;
   compare y=Total_Sales x=(Book_Sales Music_Sales Electronics_Sales);
run;

*Program 4.7;
title "Switching Axes and Adding a GROUP= Option";
proc sgscatter data=store;
   compare x=Total_Sales 
           y=(Book_Sales Music_Sales Electronics_Sales) / group=Gender;
run;

*Program 4.8;
title "Producing a Scatter Plot Matrix";
proc sgscatter data=store;
    matrix Book_Sales Music_Sales Electronics_Sales / diagonal=(histogram);
run;

*Program 5.1;
title "Conducting a One-tail T-test Using PROC TTEST";
proc ttest data=exercise h0=50 sides=2 alpha=.05;
   var Age;
run;

*Program 5.2;
ods graphics on;
title "Demonstrating the Default ODS Graphics for PROC TTEST";
proc ttest data=exercise h0=50 sides=2 alpha=.05;
   var Age;
run;
ods graphics off;

*Program 5.3;
title "Conducting a One-Sample T-test";
proc univariate data=exercise mu0=50;
   var Age;
   id Subj;
run;

*Program 5.4;
title "Conducting a One-Sample T-test with a Given Population Mean";
proc univariate data=exercise mu0=50;
   var Age;
   id Subj;
run;

*Program 5.5;
title "Testing if a Variable is Normally Distributed";
proc univariate data=exercise normal;
   var Age;
   probplot / normal (mu=est sigma=est);
run;

*Program 6.1;
options ls=86;
title "Conducting a Two-Sample T-test";
proc ttest data=example.blood_pressure;
   class Gender;
   var SBP DBP;
run;

*Program 6.2;
ods graphics on;
title "Demonstrating ODS Statistical Graphics";
proc ttest data=example.blood_pressure;
   class Gender;
   var SBP DBP;
run;
ods graphics off;

*Program 6.3;
ods graphics on;
proc ttest data=example.blood_pressure
   plots(unpack shownull) = all;
   class Gender;
   var SBP DBP;
run;
ods graphics off;   

*Listing of READING;
title "Listing of READING";
proc print data=reading noobs;
run;

*Progranm 6.4;
title "Demonstrating a Paired T-test";
proc ttest data=reading;
   paired After*Before;
run;

*Program 6.5;
ods graphics on;
title "Comparing Income by Gender";
proc ttest data=salary;
   class Gender;
   var Income;
run;
ods graphics off;

*Program 7.1;
ods graphics on;
options ls=74;
title "Running a One-Way ANOVA Using PROC GLM";
proc glm data=store plots = diagnostics;
   class Region;
   model Electronics_Sales = Region / ss3;
   means Region / hovtest;
run;
quit;
ods graphics off;

*Program 7.2;
options ls=96;
title "Requesting Multiple Comparison Tests";
proc glm data=store;
   class Region;
   model Electronics_Sales = Region / ss3;
   means Region / snk;
   lsmeans Region / pdiff adjust=tukey;
run;
quit;

*Program 7.3;
options ls=96;
ods graphics on;
title "Requesting Multiple Comparison Tests";
proc glm data=store plots(only) = diffplot;
   class Region;
   model Electronics_Sales = Region / ss3;
   means Region / snk;
   lsmeans Region / pdiff adjust=tukey;
run;
quit;
ods graphics off;

*Program 7.4;
title "Performing a Two-way Factorial design";
proc glm data=store;
   class Region Gender;
   model Electronics_Sales = Region | Gender / ss3;
   lsmeans Region | Gender / pdiff adjust=tukey;
run;
quit;

*Program 7.5;
title "Analyzing a Factorial Design with a Significant Interaction";
ods graphics on;
proc glm data=store;
   class Region Gender;
   model Music_Sales = Gender | Region / ss3;
   lsmeans Region | Gender;
run;
quit;
ods graphics off;

*Demonstrating the Slice LSMEANS option;
title "Analyzing Factorial Design with a Significant Interaction";
ods graphics on;
proc glm data=store;
   class Region Gender;
   model Music_Sales = Gender | Region / ss3;
   lsmeans Region*Gender / slice=Region;
run;
quit;
ods graphics off;

*Program 7.6;
title "Analyzing a Randomized Block Design";
proc glm data=store;
   class Region Gender;
   model Book_Sales = Gender Region / ss3;
   lsmeans Gender;
run;
quit;

*Program 8.1;
ods graphics on;
title "Computing Pearson Correlation Coefficients";
proc corr data=exercise nosimple rank;
   var Rest_Pulse Max_Pulse Run_Pulse Age;
   with Pushups;
run;
ods graphics off;

*Program 8.2;
ods graphics on;
title "Computing Pearson Correlation Coefficients";
proc corr data=exercise nosimple
   plots = matrix(histogram);
   var Pushups Rest_Pulse Max_Pulse Run_Pulse Age;
run;
ods graphics off;

*Program 8.3;
ods graphics on / imagemap=on;
ods listing close;

ods html gpath='c:\books\statistics by example'
         path='c:\books\statistics by example'
         file='scatter.html'
         style=statistical;
title "Computing Pearson Correlation Coefficients";
proc corr data=exercise nosimple plots(only)=scatter(ellipse=none);
   var Rest_Pulse Max_Pulse Run_Pulse Age;
   with Pushups;
   id Subj;
run;
ods html close;
ods graphics off;
ods listing;

*Program 8.4;
title "Computing Spearman Rank Correlations";
proc corr data=exercise nosimple spearman;
   var Rest_Pulse Max_Pulse Run_Pulse Age;
   with Pushups;
run;

*Program 8.5;
ods graphics on;
title "Running a Simple Linear Regression Model";
proc reg data=exercise;
   model Pushups = Rest_Pulse;
run;
quit;
ods graphics off;

*Program 8.6;
options ls=78;
ods graphics on;
title "Displaying Influential Observations";
proc reg data=exercise plots(only) = (cooksd(label)
   rstudentbypredicted(label));
   id Subj;
   model Pushups = Rest_Pulse / influence r;
run;
quit;
ods graphics off;

*Program 8.7;
data need_predictions;
   input Rest_Pulse @@;
datalines;
50 60 70 80 90
;
data combined;
   set exercise need_predictions;
run;

title "Last 8 Observations from Data Set COMBINED";
proc print data=combined(firstobs=48);
run;

*Program 8.8;
title "Using PROC REG to Compute Predicted Values";
proc reg data=combined;
   model Pushups = Rest_Pulse / p;
   id Rest_Pulse;
run;
quit;

*Program 8.9;
title "Describing a More Efficient Way to Compute Predicted Values";
proc reg data=exercise noprint outest=betas;
   model Pushups = Rest_Pulse;
run;
quit;
proc print data=betas noobs;
run;

*Program 8.10;
proc score data=need_predictions score=betas
   out=predictions type=parms;
   var Rest_Pulse;
run;

title "Using PROC SCORE to Compute Predicted Values";
proc print data=predictions noobs;
run;

*Program 9.1;
title "Running a Multiple Regression Model";
proc reg data=exercise;
   model Pushups = Age Max_Pulse;
run;
quit;

*Program 9.2;
ods graphics on;
title "Demonstrating the RSQUARE Selection Method";
proc reg data=exercise;
   model Pushups = Age Rest_Pulse Max_Pulse Run_Pulse /
      selection = rsquare cp adjrsq;
run;
quit;
ods graphics off;

*Program 9.3;

ods graphics on;
title "Generating Plots of R-Square, Adjusted R-Square and C(p)";
proc reg data=exercise plots(only) = (rsquare adjrsq cp);
   model Pushups = Age Rest_Pulse Max_Pulse Run_Pulse /
      selection = rsquare cp adjrsq;
run;
quit;
ods graphics off;

*Program 9.4;
title "Forward, Backward, and Stepwise Selection Methods";
title2 "Using Default Values for SLENTRY and SLSTAY";
proc reg data=exercise;
   Forward: model Pushups = Age Rest_Pulse Max_Pulse Run_Pulse /
      selection = forward;
   Backward: model Pushups = Age Rest_Pulse Max_Pulse Run_Pulse /
      selection = backward;
   Stepwise: model Pushups = Age Rest_Pulse Max_Pulse Run_Pulse /
      selection = stepwise;
run;
quit;

*Program 9.5;
title "Forward Method";
title2 "SLENTRY Set at .15";
proc reg data=exercise;
   Forward: model Pushups = Age Rest_Pulse Max_Pulse Run_Pulse /
      selection = forward slentry=.15;
run;
quit;

*program 9.6;
title "Forcing Variables into a Stepwise Model";
proc reg data=exercise;
   model Pushups = Max_Pulse Age Rest_Pulse Run_Pulse /
      selection = stepwise include=1;
run;
quit;

*Program 9.7;
data Dummy;
   set Store;
   *Create dummy variable for Gender;
   if Gender = 'Male' then Male = 1;
   else if Gender = 'Female' then Male = 0;
   *Create Dummy Variable for Region;
   if Region not in ('North' 'East' 'South' 'West') then 
      call missing(North, East, South);
   else if Region = 'North' then North = 1;
   else North = 0;
   if Region = 'East' then East = 1;
   else East = 0;
   if Region = 'South' then South = 1;
   else South = 0;
run;
title "Creating and Using Dummy variables";
proc print data=Dummy(obs=10) noobs;
   var Region Gender Male North East South; 
run;

*Program 9.8;
title "Running a Multiple Regression with Dummy Variables";
proc reg data=Dummy;
   model Music_Sales = Total_Sales Male North East South;
run;
quit;

*Program 9.9;
title "Using the VIF to Detect Collinearity";
proc reg data=exercise;
   model Pushups = Age Rest_Pulse Max_Pulse Run_Pulse / VIF;
run;
quit;

*Program 9.10;
ods graphics on;
title "Detecting Influential Observations in Multiple Regression";
proc reg data=exercise
   plots(label only) = (cooksd 
                        rstudentbypredicted 
                        dffits
                        dfbetas);
   id Subj;
   model Pushups = Age Max_Pulse Run_Pulse / influence;
run;
quit;
ods graphics off;

*Problem 10.1
title "Comparing Proportions";
proc freq data=risk;
   tables Gender * Heart_Attack / chisq;
run;

*Problem 10.2;
proc format;
   value $gen 'M' = '1:Male'
              'F' = '2:Female';
   value attack 1 = '1:Yes'
                0 = '2:No';
run;

title "Reordering the Rows and Columns in a 2x2 Table";
proc freq data=risk order=formatted;
   tables Gender * Heart_Attack / chisq relrisk;
   format Gender $gen. Heart_Attack attack.;
run;

*Program 10.3;
data small_counts;
   input Group $ Outcome $ @@;
datalines;
A Good A Good A Good A Poor A Good A Good
B Poor B Poor B Good B Poor B Poor
;
title "Tables with Small Expected Frequencies";
proc freq data=small_counts;
   tables Group * Outcome / chisq;
run;

*Program 10.4;
data frequencies;
   input Treatment $ Outcome $ Count;
datalines;
Placebo Sick 30
Placebo Well 10
Drug Sick 15
Drug Well 40
;
title "Listing of Data Set FREQUENCIES";
proc print data=frequencies noobs;
run;

title "Computing Chi_Square from Frequency Data";
proc freq data=frequencies;
   tables Treatment * Outcome / chisq;
   weight Count;
run;

*Program 10.5;
/***********************************************************
Macro CHISQ
Purpose: To compute chi-square (and any other valid
         PROC FREQ TABLES options) from frequencies in a
         2 x 2 table.
Sample Calling Sequencies;
   %CHISQ(10,20,30,40)
   %CHISQ(10,20,30,40,OPTIONS=CMH)
   %CHISQ(10,20,30,40,OPTIONS=CHISQ CMH)
************************************************************/
%macro chisq(a,b,c,d,options=chisq);
   data chisq;
      array cells[2,2] _temporary_ (&a &b &c &d);
      do row = 1 to 2;
         do Col = 1 to 2;
            Count = cells[Row,Col];
            output;
         end;
      end;
   run;
   proc freq data=chisq;
      tables Row*Col / &options;
      weight Count;
   run;
%mend chisq;

%chisq(30,10,15,40)

*Program 10.6;
data kappa;
   input Rater1 : $1. Rater2 : $1. @@;
datalines;
Y Y N N Y N N Y Y Y Y Y Y Y N N N N N N Y Y Y N Y Y N N N Y N N N N N N
Y Y Y Y N N N N Y N Y Y Y Y N N N N N N N N Y Y N N Y Y N N 
;
title "Computing Coefficient Kappa";
proc freq data=kappa;
   tables Rater1 * Rater2 / agree;
   test kappa;
run;

*Program 10.7;
data trend;
   input Outcome $ Dose Count;
datalines;
Success 1 8
Success 2 8
Success 3 10
Success 4 15
Failure 1 12
Failure 2 12
Failure 3 10
Failure 4 5
;
title "Computing Tests for Trend";
proc freq data=trend;
   tables Outcome * Dose / cmh trend;
   weight Count;
run;

*Program 10.8;
data bloodtype;
   input type $ Count @@;
datalines;
O 88 A 76 B 24 AB 12
;
title "Computing Chi-Square for a One-Way Table";
proc freq data=bloodtype;
   tables type / testp = (.40 .04 .11 .45);
   weight Count;
run;

*Program 11.1;
title "Logistic Regression with One Categorical Predictor Variable";
proc logistic data=risk;
   class Gender (param=ref ref='F');
   model Heart_Attack (event='Yes') = Gender / clodds = pl;
run;
quit;

*Program 11.2;
title "Logistic Regression with One Continuous Predictor Variable";
proc logistic data=risk;
   model Heart_Attack (event='Yes') = Chol / clodds = pl;
   units Chol = 10;
run;
quit;

*Program 11.3;
proc format;
   value cholgrp low-200   = 'Low to Medium'
                 201-high  = 'High';
run;

title "Using a Format to Create a Categorical Variable";
proc logistic data=risk;
   class Chol (param=ref ref='Low to Medium');
   model Heart_Attack (event='Yes') = Chol / clodds = pl;
   format Chol cholgrp.;
run;
quit;

*Program 11.4;
ods graphics on;
title "Using a Combination of Categorical and Continuous Variables";
proc logistic data=risk;
   class Age_Group (param=ref ref='1:< 60')
         Gender (param=ref ref='F');
   model Heart_Attack (event='Yes') = Gender Age_Group Chol / clodds = pl;
   units Chol=10;
run;
quit;
ods graphics off;

*Program 11.5;
options ls=78;

ods graphics on;
title "Running a Logistic Model with Interactions";
proc logistic data=risk plots(only)=(roc oddsratio);
   class Gender (ref='F')
         Age_Group (ref='1:< 60') / param=ref;
   model Heart_Attack (event='Yes') = Gender | Age_Group | Chol @2 /
         selection=backward slstay=.10 clodds=pl;
   units Chol=10;
   oddsratio Chol;
   oddsratio Gender;
   oddsratio Age_Group;
run;
quit;
ods graphics off;

*Program 12.1;
title "Displaying the Distribution of Incomes in the Salary Data Set";
proc univariate data=salary;
   id Subj;
   class Gender;
   var Income;
   histogram / normal;
   probplot / normal(mu=est sigma=est);
run;

*Program 12.2;
title "Performing a Wilcoxon Rank Sum Test";
proc npar1way data=Salary wilcoxon;
   class Gender;
   var Income;
run;

*Program 12.3;
title "Performing a Wilcoxon Rank Sum Test";
title2 "Requesting an Exact p-value";
proc npar1way data=Salary wilcoxon;
   class Gender;
   var Income;
   exact;
run;

*Program 12.4;
data difference;
   set reading;
   Diff = After - Before;
run;

ods select testsforlocation;
title "Performing a Wilcoxon Signed Rank Test";
proc univariate data=difference;
   var Diff;
run;

*Program 12.5;
title "Performing a Kruskas-Wallis ANOVA";
proc npar1way data=store wilcoxon;
   class Region;
   var Music_Sales;
run;

*Program 12.6;
data twogroups;
   do Group = 'One','Two';
      do Subj = 1 to 15;
         input Score @;
         output;
      end;
   end;
datalines;
1 3 5 7 11 20 25 30 40 55 66 77 88 90 100
2 4 8 20 24 33 40 45 55 59 60 68 69 70 71
;
title "Performing the Ansari-Bradley Test for Spread";
proc npar1way data=twogroups ab;
   class Group;
   var Score;
run;

*Program 12.7;
data one;
   input Subj x y;
datalines;
1 3 100
2 1 200
3 5 300
4 77 400
;
proc rank data=one out=two;
   var x;
   ranks Rank_x;
run;

title "Listing of data set TWO";
proc print data=two noobs;
run;

*Program 12.8;
proc rank data=salary out=rank_salary;
   var Income;
   ranks Rank_of_Salary;
run;

title "Converting Data to Ranks and Performing a T-Test";
proc ttest data=rank_salary;
   class Gender;
   var Rank_of_Salary;
run;

*Program 12.9;
title "Using PROC RANK to Create Groups";
proc rank data=salary out=new_salary groups=4;
   var Income;
   ranks Salary_Group;
run;
proc print data=new_salary(obs=10) noobs;
run;

*Program 13.1;
title "Sample Size Requirements for a T-Test";
proc power;
   twosamplemeans
   groupmeans = (20 30) (22 28)
   stddev = 10 15
   power= .80 .90
   npergroup = .;
   plot x = power min = .70 max = .90;
run;

*Program 13.2;
title "Computing the Power of a T-Test";
proc power;
   twosamplemeans
   groupmeans = 20 | 30 35
   stddev = 10 15
   power= .
   npergroup = 30 35;
   plot x = n min = 20 max = 50;
run;

*Program 13.3;
title "Computing the Power for an ANOVA Model";
proc power;
   onewayanova
   groupmeans = 20 | 25 | 30
   stddev = 8 10
   power = .80 .90
   npergroup = .;
   plot x = power min = .70 max = .90;
run;

*Program 13.4;
title "Computing Sample Size for a Difference in Two Proportions";
proc power;
   twosamplefreq
   test = pchi
   groupproportions = .15 | .20 .225 .25
   power = .80 .90
   npergroup = .;
   plot x = power min = .70 max = .90;
run;

*Program 14.1;
title "Taking a Simple Random Sample";
proc surveyselect data=risk out=risk_sample
   method = srs
   samprate = .1
   seed = 1357924;
run;

*Program 14.2;
title "Taking a Random Sample with Replacement";
proc surveyselect data=reading out=read_replace
   method = urs
   outhits
   sampsize = 5
   seed = 1324354;
run;

title "Listing of Data Set READ_REPLACE";
proc print data=read_replace;
run;

*Program 14.3;
title "Taking a Random Sample with Replacement";
title2 "Omitting the OUTHITS Option";
proc surveyselect data=reading out=read_replace
   method = urs
   sampsize = 5
   seed = 1324354;
run;

title "Listing of Data Set READ_REPLACE - OUTHITS Option Removed";
proc print data=read_replace;
run;

*Program 14.4;
title "Requesting Replicate Samples";
proc surveyselect data=risk out=riskrep
   method = srs
   sampsize = 5
   reps = 3
   seed = 1357924;
run;

title "Listing of Data Set RISKREP";
proc print data=riskrep;
run;









