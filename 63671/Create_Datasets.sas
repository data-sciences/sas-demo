*variables

Region
Advertising
Gender
Book_Sales
Music_Sales
Electronics_Sales
Total_Sales
;

proc format;
   value yesno 1 = 'Yes'
               0 = 'No';
data Store;
   length Region $ 5;
   call streaminit(57676);
   do Transaction = 1 to 200;
      R = ceil(rand('uniform')*10);
      select(R);
         when(1) Region = 'East';
         when(2) Region = 'West';
         when(3) Region = 'North';
         when(4) Region = 'South';
         otherwise;
      end;
      Advertising = rand('bernouli',.6);
      if rand('uniform') lt .6 then Gender = 'Female';
         else Gender = 'Male';
      Book_Sales = abs(round(rand('normal',250,50) + 30*(Gender = 'Female')
                    + 30*Advertising,10)) ;
      Music_Sales = abs(round(rand('uniform')*40 + rand('normal',50,5)
         + 30*(Region = 'East' and Gender = 'Male')
         - 20*(Region = 'West' and Gender = 'Female'),5) + 10*Advertising);
      Electronics_Sales = abs(round(rand('normal',300,60) + 70*(Gender = 'Male')
       + 55*Advertising + 50*(Region = 'East') - 20*(Region = 'South') 
       + 75*(Region = 'West'),10));
      Total_Sales = sum(Book_Sales,Music_Sales,Electronics_Sales);
   output;
   end;
   drop R;
   format Book_Sales Music_Sales Electronics_Sales Total_Sales dollar9.
          Advertising yesno.;
run;
 
/*title "Listing of Store";*/
/*proc print data=store heading=h;*/
/*run;*/

/*proc univariate data=store;*/
/*   var Book_Sales -- Total_Sales;*/
/*   histogram;*/
/*run;*/
/**/
/*title "Scatter Matrix for Store Variables";*/
/*proc sgscatter data=store;*/
/*   matrix Book_Sales -- Total_Sales / group = Gender;*/
/*run;*/
/**/
/*proc sgplot data=store;*/
/*   scatter x=Book_Sales y=Total_Sales / group=Gender;*/
/*run;*/

proc rank data=store out=median_sales groups=2;
   var Total_Sales;
   ranks Sales_Group;
run;

proc format;
   value sales 0 = 'Low'
               1 = 'High';
run;

/*proc logistic data=median_sales order=formatted;*/
/*   class Gender(param=ref ref='Male');*/
/*   model Sales_Group = Gender;*/
/*   format Sales_Group sales.;*/
/*quit;*/
/**/
/*proc logistic data=median_sales order=formatted;*/
/*   class Gender(param=ref ref='Male')*/
/*         Advertising (param=ref ref='No');*/
/*   model Sales_Group = Gender Advertising;*/
/*   format Sales_Group sales.;*/
/*quit;*/

*Create test data set;
libname example 'c:\books\statistics by example';
data example.Blood_Pressure;
   call streaminit(37373);
   do Drug = 'Placebo','Drug A','Drug B';
      do i = 1 to 20;
         Subj + 1;
         if mod(Subj,2) then Gender = 'M';
         else Gender = 'F';
         SBP = rand('normal',130,10) +
               7*(Drug eq 'Placebo') - 6*(Drug eq 'Drug B');
         SBP = round(SBP,2);
         DBP = rand('normal',80,5) +
               3*(Drug eq 'Placebo') - 2*(Drug eq 'Drug B');
         DBP = round(DBP,2);
         if Subj in (5,15,25,55) then call missing(SBP, DBP);
         if Subj in (4,18) then call missing(Gender);
         output;
      end;
   end;
   drop i;
run;

/*title "Listing of the first 25 observations from Blood_Pressure";*/
/*proc print data=example.Blood_Pressure(obs=25) noobs;*/
/*   var Subj Drug SBP DBP;*/
/*run;*/

data exercise;
   call streaminit(7657657);
   do Subj = 1 to 50;
      Age = round(rand('normal',50,15));
      Pushups = abs(int(rand('normal',40,10) - .30*age));
      Rest_Pulse = round(rand('normal',50,8) + .35*age);
      Max_Pulse = round(rest_pulse + rand('normal',50,5) - .05*age);
      Run_Pulse = round(max_pulse - rand('normal',3,3));
      output;
   end;
run;

*Data set for a paired t-test example;
data reading;
   input Subj Before After @@;
datalines;
1 100 110  2 120 121  3 130 140  4 90 110  5 85 92
6 133 137  7 210 209  8 155 179
;

/*title "Listing of Data Set READING";*/
/*proc print data=reading noobs;*/
/*run;*/

*Data set that violates assumptions for a t-test;
data salary;
   call streaminit(57575);
   do Subj = 1 to 50;
      do Gender = 'M','F';
         Income = round(20000*rand('exponential') + rand('uniform')*7000*(Gender = 'M'));
         output;
      end;
   end;
run;
/*proc univariate data=salary;*/
/*   class Gender;*/
/*   id Subj;*/
/*   var Income;*/
/*   histogram Income;*/
/*run;*/

*Data set risk for logistic regression example;
proc format;
   value yesno 1 = 'Yes'
               0 = 'No';
run;

data Risk;
   call streaminit(13579);
   length Age_Group $ 7;
   do i = 1 to 250;
      do Gender = 'F','M';
         Age = round(rand('uniform')*30 + 50);
         if missing(Age) then Age_Group = ' ';
         else if Age lt 60 then Age_Group = '1:< 60';
         else if Age le 70 then Age_Group = '2:60-70';
         else Age_Group = '3:71+';
         Chol = rand('normal',200,30) + rand('uniform')*8*(Gender='M');
         Chol = round(Chol);
         Score = .3*chol + age + 8*(Gender eq 'M');
         Heart_Attack = (Score gt 130)*(rand('uniform') lt .2);
         output;
       end;
   end;
   keep Gender Age Age_Group chol Heart_Attack;
   format Heart_Attack yesno.;
run;

/*title "Listing of first 100 observations from RISK";*/
/*proc print data=risk(obs=100);*/
/*run;*/

