
libname sgbook 'C:\Work\SGBook\SAS\Validate\Data';
ods html close;
ods listing;

/*--1. Data Set SGBOOK.SERIES--*/ 
data sgbook.series; 
format Date Date9.; 
do i=0 to 364; 
date='01jan2009'd+i; 
A = 10+ 3*sin(i/90+0.5) + 1*sin(3*i/90+0.7); 
B = 5+ 3*sin(i/90+0.5) + 1*cos(3*i/90+0.7); 
C = 10+ 3*cos(i/90+0.5) + 1*sin(3*i/90+0.7); 
if mod (i, 50) = 0 then do; 
LabelA = A; 
LabelB = B; 
LabelC = C; 
end; 
else do; 
LabelA = .; 
LabelB = .; 
LabelC = .; 
end; 
output; 
end; 
run; 

/*--2. Data Set SGBOOK.SERIESGROUP--*/ 
data sgbook.seriesGroup; 
format Date Date9.; 
do i=0 to 364; 
date='01jan2009'd+i; 
if mod (i, 30) =0 then freq=1; else freq=0; 
Drug='Drug A'; Val = 16+ 3*sin(i/90+0.5) + 1*sin(3*i/90+0.7); output; 
Drug='Drug B'; Val = 10+ 3*sin(i/90+0.5) + 1*cos(3*i/90+0.7); output; 
Drug='Drug C'; Val = 10+ 3*cos(i/90+0.5) + 1*sin(3*i/90+0.7); output; 
end; 
run;


/*--3. Data Set SGBOOK.SERIESBREAK--*/ 
data sgbook.seriesBreak; 
format Date Date9.; 
do i=0 to 364; 
date='01jan2009'd+i; 
A = 10+ 3*sin(i/90+0.5) + 1*sin(3*i/90+0.7); 
B = 5+ 3*sin(i/90+0.5) + 1*cos(3*i/90+0.7); 
C = 10+ 3*cos(i/90+0.5) + 1*sin(3*i/90+0.7); 
if (i >200 and i < 250) then c=.; 
output; 
end; 
run; 

/*--4. Data Set SGBOOK.SERIESDISCRETE--*/ 
data sgbook.seriesDiscrete; 
input Qtr $ SalesA SalesB SalesC; 
label salesa='A'; 
label salesb='B'; 
label salesc='C'; 
datalines; 
Q1 6000 6100 6200 
Q2 8500 8400 8600 
Q3 8100 8200 8000 
Q4 6500 6600 6400 
; 
run; 

/*--5. Data Set SGBOOK.SERIESDISCRETEGROUP--*/ 
data sgbook.seriesDiscreteGroup; 
input Qtr $ Drug $ Sales; 
High=sales*1.05; 
Low=sales*0.95; 
datalines; 
Q1 A 6000 
Q1 B 6100 
Q1 C 6200 
Q2 A 8500 
Q2 B 8400 
Q2 C 8600 
Q3 A 8100 
Q3 B 8200 
Q3 C 8000 
Q4 A 6500 
Q4 B 6600 
Q4 C 6400 
; 
run; 

/*--6. Data Set SGBOOK.STEP--*/ 
data sgbook.step; 
format Date Date9.; 
do i=0 to 364 by 30; 
date='01jan2009'd+i; 
A = 10+ 3*sin(i/90+0.5) + 1*sin(3*i/90+0.7); 
B = 5+ 3*sin(i/90+0.5) + 1*cos(3*i/90+0.7); 
C = 10+ 3*cos(i/90+0.5) + 1*sin(3*i/90+0.7); 
output; 
end; 
run; 

/*--7. Data Set SGBOOK.STEPGROUP--*/ 
data sgbook.stepGroup; 
format Date Date9.; 
do i=0 to 364 by 40; 
date='01jan2009'd+i; 
if mod (i, 30) =0 then freq=1; else freq=0; 
Drug='Drug A'; Val = 16+ 3*sin(i/90+0.5) + 1*sin(3*i/90+0.7); 
upper=val*1.1; lower=val*0.95; output; 
Drug='Drug B'; Val = 11+ 3*sin(i/90+0.5) + 1*cos(3*i/90+0.7); 
upper=val*1.1; lower=val*0.95; output; 
Drug='Drug C'; Val = 7+ 3*cos(i/90+0.5) + 1*sin(3*i/90+0.7); 
upper=val*1.1; lower=val*0.95; output; 
end; 
run; 

/*--8. Data Set SGBOOK.STEPBREAK--*/ 
data sgbook.stepBreak; 
format Date Date9.; 
do i=0 to 364 by 40; 
date='01jan2009'd+i; 
A = 16+ 3*sin(i/90+0.5) + 1*sin(3*i/90+0.7); 
upperA=a*1.1; lowerA=a*0.95; 
B = 11+ 3*sin(i/90+0.5) + 1*cos(3*i/90+0.7); 
upperB=b*1.1; lowerB=b*0.95; 
C = 7+ 3*cos(i/90+0.5) + 1*sin(3*i/90+0.7); 
upperC=c*1.1; lowerC=c*0.95; 
if (i >=200 and i < 270) then do; a=.; b=.; c=.; end; 
output; 
end; 
run; 

/*--9. Data Set SGBOOK.BANDGROUP--*/ 
data sgbook.bandGroup; 
format Date Date9.; 
do i=0 to 364 by 1; 
date='01jan2009'd+i; 
if mod (i, 30) =0 then freq=1; else freq=0; 
Drug='Drug A'; Val = 16+ 3*sin(i/90+0.5) + 1*sin(3*i/90+0.7); upper=val*1.1; lower=val*0.95; output; 
Drug='Drug B'; Val = 11+ 3*sin(i/90+0.5) + 1*cos(3*i/90+0.7); upper=val*1.1; lower=val*0.95; output; 
Drug='Drug C'; Val = 12+ 3*cos(i/90+0.5) + 1*sin(3*i/90+0.7); upper=val*1.1; lower=val*0.95; output; 
end; 
run; 

/*--10. Data Set SGBOOK.BANDBREAK--*/ 
data sgbook.bandBreak; 
format Date Date9.; 
do i=0 to 364 by 1; 
date='01jan2009'd+i; 
A = 16+ 3*sin(i/90+0.5) + 1*sin(3*i/90+0.7); upperA=a*1.1; lowerA=a*0.95; 
B = 11+ 3*sin(i/90+0.5) + 1*cos(3*i/90+0.7); upperB=b*1.1; lowerB=b*0.95; 
C = 12+ 3*cos(i/90+0.5) + 1*sin(3*i/90+0.7); upperC=c*1.1; lowerC=c*0.95; 
if (i >=200 and i < 270) then do; a=.; b=.; c=.; end; 
output; 
end; 
run; 


/*--11. Data Set SGBOOK.STEPBAND--*/ 
data sgbook.StepBand; 
format Date Date9.; 
do i=0 to 364 by 30; 
date='01jan2009'd+i; 
A = 16+ 3*sin(i/90+0.5) + 1*sin(3*i/90+0.7); 
upperA=a*1.1; lowerA=a*0.9; 
B = 11+ 3*sin(i/90+0.5) + 1*cos(3*i/90+0.7); 
upperB=b*1.1; lowerB=b*0.9; 
C = 12+ 3*cos(i/90+0.5) + 1*sin(3*i/90+0.7); 
upperC=c*1.1; lowerC=c*0.9; 
output; 
end; 
run; 

/*--12. Data Set SGBOOK.NEEDLETRADE--*/ 
data sgbook.needleTrade; 
format Date Date9.; 
do i=0 to 364 by 20; 
date='01jan2009'd+i; 
if (ranuni(0) < 0.5) then Trade='Buy'; 
else Trade='Sell'; 
Val = 16+ 3*sin(i/90+0.5) + 1*sin(3*i/90+0.7); upper=val*1.1; lower=val*0.95; output; 
end; 
run; 

/*--13. Data Set SGBOOK.NEEDLEMULTI--*/ 
data sgbook.needleMulti; 
format Date Date9.; 
do i=0 to 364 by 40; 
date='01jan2009'd+i; 
A = 16+ 3*sin(i/90+0.5) + 1*sin(3*i/90+0.7); 
upperA=a*1.1; lowerA=a*0.95; 
B = 11+ 3*sin(i/90+0.5) + 1*cos(3*i/90+0.7); 
upperB=b*1.1; lowerB=b*0.95; 
C = 7+ 3*cos(i/90+0.5) + 1*sin(3*i/90+0.7); 
upperC=c*1.1; lowerC=c*0.95; 
output; 
end; 
run; 


/*--14. Data Set SGBOOK.NEEDLEDISCRETE--*/ 
data sgbook.needleDiscrete; 
input Month $ Trade $ Val; 
datalines; 
Jan Sell 10 
Jan Buy 12 
Feb Sell 12 
Feb Buy 14 
Mar Buy 15 
Mar Sell 12 
Apr Sell 8 
Apr Buy 10 
May Buy 12 
May Sell 16 
Jun Sell 10 
Jun Buy 9 
; 
run; 

/*--15. Data Set SGBOOK.VECTOR--*/ 
data sgbook.vector; 
do i=1 to 10; 
x=ranuni(0); xo=x-0.1; 
y=ranuni(0); yo=y-0.1; 
if (ranuni(0) < 0.5) then Type='A'; 
else Type='B'; 
output; 
end; 
run; 
 

/*--16. Data Set SGBOOK.STOCK--*/ 
data sgbook.Stock; 
set sashelp.stocks; 
length Trend $4; 
where stock='IBM' and date >= '01Apr2003'd; 
if close > open then Trend ='Up'; else Trend='Down'; 
run; 
proc sort data=sgbook.Stock; 
by date; 
run;  


/*--17. Data Set SGBOOK.VECTORGROUP--*/ 
data sgbook.vectorgroup; 
format Date Date9.; 
length group $8; 
count=364; 
do xo=0 to count by 30; 
date='01jan2009'd+x; 
yo = 100+ 3*sin(xo/90+0.5) + 1*sin(3*xo/90+0.7); 
dx=4+50*(ranuni(1)-0.5); 
dy=2+4*(ranuni(1)-0.5); 
x=xo+dx; 
y=yo+dy; 
if (dx > 0) then group='Forward'; 
else group='Reverse'; 
output; 
end; 
run; 

/*--18. Data Set SGBOOK.HIGHLOW--*/ 
data sgbook.highlow; 
length cap $ 12; 
input drug $ 1-10 low high cap $; 
datalines; 
Drug A      10 20 NONE 
Drug A      30 60 NONE 
Drug B      20 35 NONE 
Drug B      50 75 NONE 
Drug C      30 90 FILLEDARROW 
; 
run;

/*--19. Data Set SGBOOK.BUBBLEGROUP --*/
data sgbook.bubbleGroup; 
input x y value group $; 
datalines; 
1 2 1 A 
8 1 2 A 
6 3 4 B 
; 
run;  


/*--20. Data Set SGBOOK.BUBBLE--*/ 
data sgbook.bubble; 
input x y value group $; 
datalines; 
1 2 1 A 
8 1 2 A 
6 3 6 B 
; 
run; 

/*--21. Data Set SGBOOK.CARS--*/ 
data sgbook.cars; 
set sashelp.cars(where=(type='Sedan' or type='Sports')); 
label mpg='Mileage'; 
label mpgc='MPG City'; 
label mpgh='MPG Highway'; 
label hp='Horse Power'; 
mpgc=mpg_city; 
mpgh=mpg_highway; 
hp=horsepower; 
mpg=mpgc; 
run; 

/*--22. Data Set SGBOOK.CARS2--*/ 
data sgbook.cars2; 
length model2 $8; 
set sgbook.cars;
label msrp='Price (K)'; 
if mpg >= 25 then model2=put(model, $8.);
msrp=msrp / 1000; 
run; 

/*--23. Data Set SGBOOK.CARS3--*/ 
data sgbook.cars3; 
length model2 model3 $10; 
length labelgrp $10; 
set sgbook.cars; 
model2=put(model, $10.); 
labelgrp='Unlabeled'; 
if mpg >= 50 or hp > 475 then do; 
model3=put(model, $10.); 
labelgrp='Labeled'; 
end; 
run;  


/*--24. Data Set SGBOOK.CARS4--*/ 
data sgbook.cars4; 
keep mpg model model2 model3 hp labelgrp; 
length model2 model3 $10; 
length labelgrp $10; 
set sashelp.cars; 
mpg=mpg_city; 
hp=horsepower; 
model2=put(model, $10.); 
labelgrp='Unlabeled'; 
if mpg >= 50 or hp > 400 then do; 
model3=put(model, $10.); 
labelgrp='Labeled'; 
end; 
run; 

/*--25. Data Set SGBOOK.CARMEANS--*/ 
proc sort data=sashelp.cars out=carsSorted; 
by origin type; 
run; 
proc means data=carsSorted noprint; 
class origin type; 
var mpg_city mpg_highway horsepower; 
output out=sgbook.carMeans 
mean(mpg_city mpg_highway horsepower) = 
mean_mpg_city mean_mpg_highway mean_horsepower 
max(mpg_city mpg_highway horsepower) = 
max_mpg_city max_mpg_highway max_horsepower 
min(mpg_city mpg_highway horsepower) = 
min_mpg_city min_mpg_highway min_horsepower; 
run; 
data sgbook.carMeans; 
set sgbook.carMeans; 
label mean_mpg_city='Mean MPG (City)'; 
label mean_mpg_highway='Mean MPG (Highway)'; 
label mean_horsepower='Mean Horsepower'; 
label max_mpg_city='Max MPG (City)'; 
label max_mpg_highway='Max MPG (Highway)'; 
label max_horsepower='Max Horsepower'; 
label min_mpg_city='Min MPG (City)'; 
label min_mpg_highway='Min MPG (Highway)'; 
label min_horsepower='Min Horsepower'; 
run;  


/*--26. Data Set SGBOOK.STOCKCAP--*/ 
data sgbook.stockCap; 
set sgbook.stock; 
format lower higher dollar.; 
if trend='Up' then do; 
highcap='FilledArrow'; 
lower=open; higher=close; 
end; 
else do; 
lowcap='BarbedArrow'; 
lower=close; higher=open; 
end; 
run; 

/*--27. Data Set SGBOOK.CARMEANSLINE--*/ 
data lineParms; 
input x y slope label $; 
datalines; 
0 0 0 Null 
100 20 -0.1 Low 
100 50 -0.08 High 
; 
run; 
data sgbook.carMeansLine; 
merge sgbook.carMeans lineParms; 
run; 

/*--28. Data Set SGBOOK.CARFREQ--*/
data sgbook.carsFreq; 
set sashelp.cars (where=(type='Sedan')); 
freq=round(5*ranuni(1)); 
run;  


/*--29. Data Set SGBOOK.INTERVALBOXMULTI--*/ 
data sgbook.intervalBoxMulti; 
format Date Date2 date5.; 
label drugA='Drug A'; 
label drugB='Drug B'; 
drop i; 
do Date='01Jan2009'd, '15Jan2009'd,'01Feb2009'd,'15Feb2009'd, 
'01Mar2009'd, '01Apr2009'd, '01Jun2009'd,'01Sep2009'd, 
'01Dec2009'd; 
do i=1 to 10; 
Date2=date-3; DrugA=abs(rannorm(1)); DrugB=.; output; 
Date2=date-3; DrugA=abs(rannorm(1)); DrugB=.; output; 
Date2=date+3; DrugB=abs(rannorm(1)); DrugA=.; output; 
Date2=date+3; DrugB=abs(rannorm(1)); DrugA=.; output; 
end; 
end; 
run; 

/*--30. Data Set SGBOOK.CARLABEL--*/ 
data sgbook.carlabel; 
set sashelp.cars (where=(type='Sedan' and origin='USA')); 
if (mpg_city < 15) then outlier=mpg_city; 
if (horsepower < 200) and (mpg_city < 17) then outlier=mpg_city; 
if (horsepower < 150) and (mpg_city > 28) then outlier=mpg_city; 
run; 

/*--31. Data Set SGBOOK.CARLABEL2--*/
data sgbook.carlabel2; 
set sashelp.cars (where=(type='Sedan' and origin='USA')); 
if (mpg_city < 15) then minmax=mpg_city; 
if (mpg_city > 28) then minmax=mpg_city; 
run; 

/*--32. Data Set SGBOOK.HEARTLABEL--*/ 
data sgbook.heartLabel; 
set sashelp.heart (where=(ageatstart <= 30)); 
if (Cholesterol > 260) then outlier=Cholesterol; 
run; 

/*--33. Data Set SGBOOK.HEARTLABEL2--*/ 
data sgbook.heartLabel2; 
set sashelp.heart (where=(ageatstart <= 30)); 
if (Cholesterol > 280) then outlier=Cholesterol; 
if (Weight > 240) then outlier=Cholesterol; 
run;  


/*--34. Data Set SGBOOK.PRODUCT_SALES--*/ 
data sgbook.product_sales; 
set sashelp.prdsale; 
format actual predict dollar12.0; 
label actual="Actual Sales (in millions)"; 
label predict="Predicted Sales (in millions)"; 
if (product = "BED") then product="A"; 
if (product = "CHAIR") then product="B"; 
if (product = "DESK") then product="C"; 
if (product = "SOFA") then product="D"; 
if (product = "TABLE") then product=" "; 
actual = actual / (10000 * ranuni(1)) ; 
predict = predict / (10000* ranuni(3)); 
run; 

/*--35. Data Set SGBOOK.WORKERS_MISSING--*/ 
data sgbook.workers_missing; 
set sashelp.workers; 
if ((date >= '01jan1979'd) and (date <= '31dec1979'd)) 
then electric=.; 
run; 

/*--36. Data Set SGBOOK.WORKERS_GROUP--*/ 
proc transpose data=sashelp.workers out=sgbook.workers_group; 
by date; 
var electric masonry; 
run; 

/*--37. Data Set SGBOOK.RANDOM--*/ 
data sgbook.random; 
do x=1 to 5; 
y=ranuni(123) * 3; 
output; 
end; 
run;  


/*--38. Data Set SGBOOK.LOGDATA--*/ 
data sgbook.logdata; 
do x=1 to 15; 
if (x <= 5) then y=ranuni(123) * 10; 
else if (x <= 10) then y=ranuni(123) * 100; 
else if (x <= 15) then y=ranuni(123) * 1000; 
output; 
end; 
run; 

/*--39. Data Set WORK.MONTH_DATA --*/
proc summary data=sashelp.prdsale nway; 
class month; 
var actual; 
output out=month_data sum=; 
run; 

/*--40. Data Set SGBOOK.Quarter --*/
data sgbook.quarter;
  input Quarter $ Revenues Expenses;
  datalines;
Q1   230   200
Q2   250   260
Q3   280   300
Q4   260   320
run;

/*--41. Data Set SGBOOK.Limits --*/
data sgbook.limits;
  input Group $ X Y xl xh yl yh;
  datalines;
A  5  5  4   6   4   6    
B  3  7  2.5 3.5 6.5 7.5  
C  8  4  7   9   3   5    
;
run;

/*--42. Data Set SGBOOK.Weather --*/
data sgbook.weather;
  input Month $ high low precip;
  highC = (high-32) / 1.8;
  lowC  = (low-32) / 1.8;
  label high= 'Fahrenheit';
  label low = 'Fahrenheit';
  label highc='Celsius';
  label lowc= 'Celsius';
  label precip= 'Precipitation (in)';
  format high low 2.0;
  format highc lowc precip 4.1;
  x1=1; x2=2; x3=3;
  datalines;
Jan    49   30  4.46
Feb    53   32  3.53
Mar    61   40  4.46
Apr    71   48  2.98
May    78   57  4.03
Jun    84   65  4.06
Jul    88   69  4.35
Aug    86   68  4.30
Sep    80   62  4.27
Oct    70   49  3.28
Nov    61   42  3.06
Dec    52   33  3.25
;
run;

/*--43. Data Set SGBOOK.WeatherTable --*/
data sgbook.weatherTable;
  input Month $ high low precip;
  highC = (high-32) / 1.8;
  lowC  = (low-32) / 1.8;
  label high= 'Fahrenheit';
  label low = 'Fahrenheit';
  label highc='Celsius';
  label lowc= 'Celsius';
  label precip= 'Precipitation (in)';
  format high low 2.0;
  format highc lowc precip 4.1;
  x1='High(F)'; x2='Low(F)'; x3='High(C)'; x4='Low(C)'; x5='Precip(in)';
  datalines; 
Jan    49   30  4.46
Feb    53   32  3.53
Mar    61   40  4.46
Apr    71   48  2.98
May    78   57  4.03
Jun    84   65  4.06
Jul    88   69  4.35
Aug    86   68  4.30
Sep    80   62  4.27
Oct    70   49  3.28
Nov    61   42  3.06
Dec    52   33  3.25
;
run;

/*--44. Data Set SGBOOK.AdverseEvents --*/
data sgbook.AdverseEvents;
  input ae $1-30 a b low mean high;
  label a='Percent';
  label b='Percent';
  datalines;
ARTHRALGIA                    1   3    3    5     8
NAUSIA                        4   18   2    4     7  
ANOREXIA                      2   3    0.9  3.8   9
HEMATURIA                     2   4    0.8  3.2   8
INSOMNIA                      3   5.5  1.1  3.0   7
VOMITING                      3.5 6    1.2  2.5   6
DYSPEPSIA                     4   10   1.1  2.4   4.5
WEIGHT DECREASE               1.5 3    0.5  2.0   4.2
RESIPRATORY DISORDER          3   4    0.4  1.4   4
HEADACHE                      7   10   0.8  1.1   2
GASTROESOPHAGEAL REFLUX       3   4    0.5  1.05  3.8
BACK PAIN                     5   6    0.8  1.04  2
CHRONIC OBSTRUCTIVE AIRWAY    22  38   0.6  0.7   0.8
DYSPNEA                       7   2.5  0.13 0.3   0.7
;
run;

/*--45. Data Set SGBOOK.Bubble2 --*/
data sgbook.Bubble2;
  input X  Y  Value AbsValue Group $;
  format value 2.0;
  datalines;
1  1   3   3 Positive
5  4   5   5 Positive
7  2  -6   6 Negative 
3  3  -4   4 Negative
;
run;

/*--46. Data Set SGBOOK.AETimeline --*/
data sgbook.AETimeline;
length lowcap $12;
length highcap $12;
attrib aestdate informat=yymmdd10. format=yymmdd10.;
attrib aeendate informat=yymmdd10. format=yymmdd10.;
input  aeseq aedecod $ 5-39 aesev $ aestdate aeendate aestdy aeendy lowcap $ highcap $;
cards;
1   DIZZINESS                           MODERATE  2013-03-06  2013-03-06     3        3   None   None
2   COUGH                               MILD      2013-03-20  .             17        .   None   None
3   APPLICATION SITE DERMATITIS         MILD      2013-03-26  2013-06-18    23      107   None   None
4   DIZZINESS                           MILD      2013-03-27  2013-03-27    24       24   None   None
5   ELECTROCARDIOGRAM T WAVE INVERSION  MILD      2013-03-30  .             27        .   None   None
6   DIZZINESS                           MILD      2013-04-01  2013-04-11    29       39   None   None
7   DIZZINESS                           MILD      2013-04-01  2013-04-11    29       39   None   None
8   APPLICATION SITE DERMATITIS         MODERATE  2013-03-26  2013-06-18    23      107   None   None
9   HEADACHE                            MILD      2013-05-17  2013-05-18    75       76   None   None
10  APPLICATION SITE DERMATITIS         MODERATE  2013-03-26  2013-06-18    23      107   None   None
11  PRURITUS                            MODERATE  2013-05-27  2013-06-18    85      107   None   None
;
run;

/*--47. Data Set SGBOOK.AETimelineCap --*/
data sgbook.AETImelineCap;
  set sgbook.aetimeline;
  if aeendate = . then do;
    aeendate='18Jun2013'd;
	aeendy=107;
	highcap='FilledArrow';
  end;
run;

/*--48. Data Set SGBOOK.Transactions --*/
data sgbook.transactions;
format Amount dollar12.0;
length Transaction $ 9;
input Transaction $ Type $ Amount;
cards;
Sales     Income  300
Lease     Income  550
Repairs   Expense -150
Rent      Expense -250
;

/*--49. Data Set WORK.DRUG and WORK.PLACEBO --*/
data exposed;
     input Days  Status Treatment $ Sex $ @@;
     datalines;
   179   1   Drug   F   378   0   Drug   M   
   256   1   Drug   F   355   1   Drug   M
   262   1   Drug   M   319   1   Drug   M   
   256   1   Drug   F   256   1   Drug   M
   255   1   Drug   M   171   1   Drug   F   
   224   0   Drug   F   325   1   Drug   M
   225   1   Drug   F   325   1   Drug   M   
   287   1   Drug   M   217   1   Drug   F
   319   1   Drug   M   255   1   Drug   F   
   264   1   Drug   M   256   1   Drug   F
   237   0   Placebo   F   291   1   Placebo   M   
   156   1   Placebo   F   323   1   Placebo   M
   270   1   Placebo   M   253   1   Placebo   M   
   257   1   Placebo   M   206   1   Placebo   F
   242   1   Placebo   M   206   1   Placebo   F   
   157   1   Placebo   F   237   1   Placebo   M
   249   1   Placebo   M   211   1   Placebo   F   
   180   1   Placebo   F   229   1   Placebo   F
   226   1   Placebo   F   234   1   Placebo   F   
   268   0   Placebo   M   209   1   Placebo   F
   ;

ods graphics on;

ods output Lifetest.Stratum1.ProductLimitEstimates=SurvivalDrug;
ods output Lifetest.Stratum2.ProductLimitEstimates=SurvivalPlacebo;
   proc lifetest data=Exposed plots=(survival(atrisk) logsurv);
      time Days*Status(0);
      strata Treatment;
   run;
ods graphics off;
ods trace off;

data survival2;
  set SurvivalDrug SurvivalPlacebo;
  label survival='Survival Probability';
  left2=.;
  class = treatment;
  if treatment='Placebo' then
    class='';
  if survival ~=.;
  run;

data drug placebo;
  set survival2 (keep=days survival left treatment);
  if treatment='Drug' then do; yLabel=-0.1; output drug; end;
  else do; yLabel=-0.2; output placebo; end;;
  run;

/*--50. Data Set SGBOOK.survival --*/
data sgbook.survival;
  merge drug (rename=(Days=DaysD Survival=SurvivalD Left=LeftD YLabel=YlabelD))
        placebo (rename=(Days=DaysP Survival=SurvivalP Left=LeftP YLabel=YlabelP));
  drop treatment;
  if survivalD <> . then plotD=1;
  if survivalP <> . then plotP=1;
  if mod(_n_, 2) =0 then delete;
  run;

/*--50. Data Set SGBOOK.BMI --*/
data bands;
   infile datalines;
    input category $ 1-11 upper_bmi lower_bmi weight_bmi;
   lower_hgt=(703*weight_bmi/lower_bmi)**.5;
   upper_hgt=(703*weight_bmi/upper_bmi)**.5;
   nn=_n_;
   datalines;
Underweight 1 18.5  25.0 4
Underweight 1 18.5  100.0 4
Underweight 1 18.5  175.0 4
Underweight 1 18.5  250.0 4
Underweight 1 18.5  325.0 4
Normal      18.5 25.0  25.0 5
Normal      18.5 25.0  100.0 5
Normal      18.5 25.0  175.0 5
Normal      18.5 25.0  250.0 5
Normal      18.5 25.0  325.0 5
Overweight  25.0 30.0  25.0 6
Overweight  25.0 30.0  100.0 6
Overweight  25.0 30.0  175.0 6
Overweight  25.0 30.0  250.0 6
Overweight  25.0 30.0  325.0 6 
Obese       30.0 150.0  25.0 7
Obese       30.0 150.0  100.0 7
Obese       30.0 150.0  175.0 7
Obese       30.0 150.0  250.0 7
Obese       30.0 150.0  325.0 7
;
run;

data records;
   infile datalines;
   nn=_n_;
   input wgt hgt year name $ ;
datalines;
45 52 . Bob
80 56 1980 Bob
125 66 1986 Bob
175 67 1990 Bob
200 68 1995 Bob
215 69 2000 Bob
250 69 2005 Bob
80  43 . Fred
85  58 1980 Fred
135 70 1986 Fred
180 70 1990 Fred
195 70 2005 Fred
50  42 . Jack
135 54 1980 Jack
140 64 1985 Jack
160 73 1990 Jack
170 76 2000 Jack
180 76 2005 Jack
;
run;

proc sort data=bands;
by nn;
run;

proc sort data=records;
by nn;
run;

data sgbook.bmi;
merge bands records; 
by nn;
if name='' then name='Jack';
run;

/*--51. Data Set SGBOOK.SALES --*/
data sgbook.sales;
  format Date date7.;
  format Sales Low High dollar9.0;
  do date='01jan2009'd to '31Dec2009'd by 7;
    sales=10000+2000*ranuni(0);
	low=8000-2000*ranuni(0);
	high=12000+2000*ranuni(0);
    output;
  end;
run;

/*--52. Data Set SGBOOK.ThemeRiverGroup --*/
data sgbook.themeRiverGroup;
  drop i a b c d;
  format time date5.;
  a=10; b=5; c=1; d=0.8;
  do i=0 to 180;
    val=0;
    do Name='John', 'Mary', 'Bill', 'Jane';
	  time = '01Jan1970'd + i;
	  val=val+abs(a*cos(0.01745*i+1+d*ranuni(0)) - b*cos(2*0.01745*i+2+d*ranuni(0)) + 
                 c*sin(2*0.01745*i+3+d*ranuni(0)));
	  upper=val;
      lower=-val;
	  output;
	end;
  end;
run;

/*--53. Data Set SGBOOK.ThemeRiverMulti --*/
data sgbook.themeRiverMulti;
  drop i a b c d;
  format time date5.;
  a=10; b=5; c=1; d=0.8;
  do i=0 to 180;
    time = '01Jan1970'd + i;
    val=0;
  
	val=val+abs(a*cos(0.01745*i+1+d*ranuni(0)) - b*cos(2*0.01745*i+2+d*ranuni(0)) + 
                 c*sin(2*0.01745*i+3+d*ranuni(0)));
    JohnU=val;  JohnL=-val;

	val=val+abs(a*cos(0.01745*i+1+d*ranuni(0)) - b*cos(2*0.01745*i+2+d*ranuni(0)) + 
                 c*sin(2*0.01745*i+3+d*ranuni(0)));
    MaryU=val;  MaryL=-val;

	val=val+abs(a*cos(0.01745*i+1+d*ranuni(0)) - b*cos(2*0.01745*i+2+d*ranuni(0)) + 
                 c*sin(2*0.01745*i+3+d*ranuni(0)));
    BillU=val;  BillL=-val;

	val=val+abs(a*cos(0.01745*i+1+d*ranuni(0)) - b*cos(2*0.01745*i+2+d*ranuni(0)) + 
                 c*sin(2*0.01745*i+3+d*ranuni(0)));
    JaneU=val;  JaneL=-val;

	output;
  end;
run;

/*--54. Data Set SGBOOK.Pareto --*/
data sgbook.pareto;
  input Product $ Share Cumulative;
  format share PERCENT6.;
  format cumulative PERCENT6.;
  datalines;
  Sofa     0.3   0.3
  LoveSeat 0.2   0.5
  Desk     0.15  0.65
  Chair    0.15  0.8
  Lamp     0.1   0.9
  Cabinet  0.1   1.0
  ;
  run;

/*--55. Data Set SGBOOK.WeatherLine --*/
data sgbook.weatherLine;
  set sgbook.weather;
  ThisYearH=(low+high)/2 + (high-low)*ranuni(0)*0.4;
  ThisYearL=(low+high)/2 - (high-low)*ranuni(0)*0.3;
run;

/*--56. Data Set SGBOOK.ProductStat --*/
data sgbook.productStat;
  input product $ Sales High Low vol margin labelL $ labelS $ labelH $ labelV $ labelM $;
  format Sales High Low Dollar8.;
  format margin percent.;
  datalines;
Sofa     20000 22000  18500  2000 0.1  Low  Sales  High Volume Margin
LoveSeat 15000 18000  13000  1000 0.15 Low  Sales  High Volume Margin
Desk     12000 13000  11000  2500 0.12 Low  Sales  High Volume Margin
Chair    10000 11500   9000  3000 0.11 Low  Sales  High Volume Margin
Lamp      8000  9000   7000  5000 0.20 Low  Sales  High Volume Margin
Cabinet   6000  7000   4500   500 0.18 Low  Sales  High Volume Margin
  ;
run;

/*--57. Data Set SGBOOK.seriesGroup2 --*/
data sgbook.seriesGroup2;
  format Date Date7.;
  drop i;
    do i=0 to 364 by 30;
      date='01jan2009'd+i;
	  Drug='A'; 
      Female = 16+ 3*sin(i/90+0.5) + 1*sin(3*i/90+0.7);
	  Male = 12+ 3*sin(i/90+0.5) + 1*sin(2*i/90+0.7); output;
	  Drug='B'; 
      Female = 10+ 3*sin(i/90+0.5) + 1*cos(3*i/90+0.7);  
      Male = 8+ 2.5*sin(i/90+0.5) + 1*cos(2*i/90+0.7); output;
	  Drug='C'; 
      Female = 10+ 3*cos(i/90+0.5) + 1*sin(3*i/90+0.7); 
      Male = 7+ 2*cos(i/90+0.5) + 1*sin(2*i/90+0.7); output;
    end;
run;

/*--58. Data Set SGBOOK.HeatMap --*/
data sgbook.HeatMap;
  set sashelp.heart (where=(weight_status <> 'Underweight' 
                        and chol_status <> 'Borderline'
                        and bp_status <> 'Optimal'
                        and deathcause = 'Coronary Heart Disease'));
  run;

/*--59. Data Set SGBOOK.CHD --*/
data sgbook.CHD;
  set sashelp.heart (where=(deathcause = 'Coronary Heart Disease'));
  run;

/*--60. Data Set SGBOOK.PE_Data --*/
data sgbook.PE_DATA;
label pe10="Price-Earnings Ratio";
input Year re pe re10 pe10 label;
cards;
1881	8.748326716	12.63265306	7.537763587	18.21479737 .
1882	8.712312283	13.45454545	7.736350471	15.61534241 .
1883	8.772956612	13.51162791	7.860859788	15.21615679 .
1884	7.580501458	12.95	    7.810135656	14.45259058 .
1885	6.838179787	13.67741935	7.82213087	13.27527484 .
1886	8.357775295	19.25925926	8.13992424	16.83662413 .
1887	8.703106708	16.90909091	8.352263165	17.36163361 .
1888	6.584913869	14.75	    8.252704406	15.36958563 .
1889	7.977874028	20.15384615	8.280566537	16.08095171 .
1890	7.523849831	17.93333333	7.979979659	17.27778813 .
1891	9.393863217	16.68965517	8.044533309	15.73568663 .
1892	9.483735093	16.20588235	8.12167559	18.92413597 .
1893	7.682400812	15.16216216	8.01262001	17.70495851 .
1894	4.933176162	16.61538462	7.74788748	15.93062495 .
1895	7.59797756	26.5625	    7.823867257	16.91267357 .
1896	6.570014733	17.08	    7.645091201	16.58686842 .
1897	9.421492175	20.0952381	7.716929748	17.2693833  .
1898	10.48734391	15.74193548	8.107172752	19.21911004 .
1899	12.3032239	17.37142857	8.539707739	22.47147694 .
1900	12.60701841	12.70833333	9.048024598	18.30899549 .
1901	12.81585823	14.72916667	9.390224099	20.52280842 .
1902	14.72837353	16.24	    9.914687943	22.16449102 .
1903	12.96021217	13.42857143	10.44246908	19.94828451 .
1904	11.71288058	12.60377358	11.12043952	15.6426204  .
1905	16.01557141	17.20408163	11.96219891	18.12062854 .
1906	17.38554578	14.73134328	13.04375201	19.72303606 .
1907	15.42972465	12.57894737	13.64457526	16.76602446 .
1908	13.12673905	10.37878788	13.90851477	11.73666722 .
1909	15.5465983	15.62068966	14.23285221	14.74267528 .
1910	16.01064582	13.26315789	14.57321495	14.48739753 .
1911	13.07481658	12.69863014	14.59911079	13.9511611  .
1912	14.45828571	15.45762712	14.572102	13.84369516 .
1913	12.752208	13.28571429	14.55130159	13.18194541 .
1914	10.42141782	13.28571429	14.42215531	11.64309536 .
1915	17.12750769	14.38461538	14.53334894	10.39429155 .
1916	26.46978462	10.60227273	15.44177282	12.49474629 .
1917	18.50660571	6.254901961	15.74946093	10.72194945 .
1918	12.14496	5.6328125	15.65128303	6.618908448 .
1919	9.753724352	7.929292929	15.07199563	6.152910614 .
1920	8.522778947	9.494623656	14.32320894	6.144371604 .
1921	3.473410651	8.8875	    13.36306835	5.288353901 .
1922	8.313514286	25.17241379	12.74859121	6.542968118 .
1923	11.46633988	12.89855072	12.6200044	8.411304745 .
1924	10.88132254	9.010204082	12.66599487	8.186531413 .
1925	14.13519553	11.37634409	12.36676365	9.773386982 .
1926	14.34261943	10.12	    11.15404713	11.56714746 .
1927	12.98738497	10.80645161	10.60212506	13.89565787 .
1928	16.33532632	15.79279279	11.02116169	19.3458461  .
1929	19.0578807	18.01449275	11.95157733	26.70068962 1929
1930	12.34864906	13.48447205	12.33416434	21.50222122 .
1931	8.634528671	16.4742268	12.85027614	16.49357344 .
1932	6.433376744	13.60655738	12.66226238	9.142699232 .
1933	6.7472	    17.29268293	12.1903484	8.78597685  .
1934	7.292929412	23.95454545	11.83150908	13.25853075 .
1935	11.14754783	18.89795918	11.53274431	11.64868162 .
1936	14.64285957	18.10526316	11.56276833	17.50054293 .
1937	16.10775211	17.24509804	11.87480504	21.83884878 .
1938	9.253302857	10.00884956	11.1666027	13.57664964 .
1939	13.10607194	19.53125	10.57142182	16.18474091 .
1940	15.07353191	13.66666667	10.84391011	16.94344617 .
1941	14.95557707	10.04761905	11.47601495	13.96665086 .
1942	12.33659645	7.698275862	12.06633692	10.03241617 .
1943	10.93511724	9.796116505	12.48512864	10.01552807 .
1944	10.57566742	12.60638298	12.81340244	11.04131802 .
1945	10.67688791	14.50537634	12.76633645	11.97215468 .
1946	9.979579535	18.77083333	12.30000845	15.69863714 .
1947	13.75062278	14.3490566	12.06429551	11.64206937 .
1948	19.31386	9.211180124	13.07035123	10.49870365 .
1949	19.9831966	6.707423581	13.75806369	9.911458212 .
1950	22.63234016	7.275862069	14.51394452	10.56798292 .
1951	18.63754868	7.468309859	14.88214168	11.64571967 .
1952	18.26309774	9.913934426	15.47479181	12.4156482  .
1953	18.88714349	10.90833333	16.26999443	12.87383768 .
1954	20.99971236	10.14342629	17.31239893	11.77507151 .
1955	27.34126567	12.85198556	18.9788367	15.58928957 .
1956	25.00864348	12.1961326	20.4817431	17.5699758  .
1957	23.85111608	13.32258065	21.49179243	16.26715402 .
1958	20.17180138	12.20178042	21.57758656	13.54126614 .
1959	23.41946212	19.24567474	21.92121312	17.9918142  .
1960	22.21142013	17.1179941	21.87912111	18.28795752 .
1961	21.523568	18.26299694	22.16772305	18.54037445 .
1962	24.43640526	21.65203762	22.7850538	21.02286748 .
1963	26.33373204	17.72752044	23.52971265	19.01232613 .
1964	29.519	    19.01741294	24.38164142	21.28370472 .
1965	33.03581887	18.92747253	24.95109674	22.9156049  .
1966	34.14616413	17.98073218	25.8648488	23.80689785 .
1967	31.63862991	15.21621622	26.64360018	20.08809023 .
1968	32.75045393	17.83114447	27.90146544	21.17405218 .
1969	30.95144127	17.71527778	28.65466336	20.79401134 .
1970	26.09030352	15.62456747	29.04255169	16.87693471 .
1971	28.07229197	18.22417154	29.69742409	16.37163882 .
1972	30.50494648	18.12280702	30.30427821	17.13107266 .
1973	35.44451845	18.44548287	31.21535685	18.5676248  .
1974	34.53892975	11.77818627	31.71734983	13.37393459 .
1975	28.97898129	8.161979753	31.31166607	8.888070624 .
1976	34.28961641	12.16834171	31.3260113	11.2618136  .
1977	35.26896384	10.4752775	31.68904469	11.46629374 .
1978	36.54157072	8.287419651	32.06815637	9.223651481 .
1979	38.66197635	8.086780211	32.83920988	9.21486248  .
1980	34.48051862	7.460969044	33.67823139	8.783883955 .
1981	32.97041103	8.972334683	34.16804329	9.186074813 .
1982	26.1609227	7.635416667	33.73364092	7.367785849 .
1983	27.86944534	11.41376582	32.97613361	8.851539214 .
1984	31.92608758	11.8595866	32.71484939	10.0230095  .
1985	26.9826438	10.31310096	32.51521564	10.06444996 .
1986	26.35776691	14.24982888	31.72203069	11.82517321 .
1987	30.61607606	18.26726519	31.25674191	15.17823127 .
1988	39.71432007	14.31314286	31.57401684	14.01976801 .
1989	36.336373	12.01220539	31.34145651	15.10915041 .
1990	32.09180862	14.86532575	31.10258551	17.23442627 .
1991	23.31961303	15.25304592	30.13750571	15.73817169 .
1992	27.09762581	26.15210559	30.23117602	20.23581475 .
1993	30.29317428	22.79884756	30.47354891	20.43568003 .
1994	41.21044311	21.61745887	31.40198447	21.48950392 .
1995	44.52103212	15.20424837	33.1558233	19.95331897 .
1996	49.27449202	18.09246172	35.44749581	24.29422615 .
1997	49.7522495	19.78363026	37.36111316	27.50062618 .
1998	46.44603287	24.25377644	38.03428444	32.29775118 .
1999	57.76290711	33.12387268	40.17693785	40.44962333 .
2000	57.80011422	29.59497613	42.74776841	42.54908284 2000
2001	28.21937346	26.6186	    43.23774445	35.99154243 .
2002	30.73559406	46.18104496	43.60154128	30.14033621 .
2003	53.27081987	32.46973541	45.89930583	22.88856259 .
2004	62.14712533	22.17152236	47.99297406	25.73231016 .
2005	71.38149713	20.48181042	50.67902056	26.52233299 .
2006	81.51	    18.04761905	53.90257135	25.42010586 .
2007	63.4335206	17.37725432	55.27069846	26.2774106  2007
2008	14.2649772	22.3514657	52.0525929	25.65251027 .
2009	.			58.97580645	51.41811354	16.1622791  .
;
run;

/*--61. Data Set SGBOOK.Revenue --*/
data sgbook.revenue;
  input Product $ Qtr $ Revenue Mean;
  format Revenue Mean Dollar.;
  datalines;
Books    Q1   2000  2500
Music    Q1   3000  .
Video    Q1   2500  .
Books    Q2   2200  2600
Music    Q2   3000  .
Video    Q2   2600  .
Books    Q3   2100  2700
Music    Q3   3200  .
Video    Q3   2800  .
Books    Q4   2000  2600
Music    Q4   3100  .
Video    Q4   2700  .
;
run;

/*--62. Format AgeFmt--*/ 
proc format; 
value agefmt 
20-30 = "20-30" 
30-40 = "30-40" 
40-50 = "40-50" 
50-60 = "50-60" 
60-70 = "60-70" 
70-80 = "70-80" 
;
run;

