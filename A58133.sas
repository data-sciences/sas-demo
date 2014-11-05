/*-------------------------------------------------------------------*/
/*          Step-by-Step Programming with Base SAS Software          */
/*       Copyright(c) 2001 by SAS Institute Inc., Cary, NC, USA      */
/*                   SAS Publications order # 58133                  */
/*                        ISBN 1-58025-791-7                         */
/*-------------------------------------------------------------------*/
/*                                                                   */
/* This material is provided "as is" by SAS Institute Inc.  There    */
/* are no warranties, expressed or implied, as to merchantability or */
/* fitness for a particular purpose regarding the materials or code  */
/* contained herein. The Institute is not responsible for errors     */
/* in this material as it now exists or will exist, nor does the     */
/* Institute provide technical support for it.                       */
/*                                                                   */
/*-------------------------------------------------------------------*/
/* Date Last Updated:  20AUG01                                       */
/*-------------------------------------------------------------------*/
/*                                                                   */
/*-------------------------------------------------------------------*/
/*                                                                   */
/* Each sample begins with a comment that states the chapter and     */
/* page number where the code is shown. The complete raw data and    */
/* DATA steps are shown with the report-writing code in the examples.*/
/*-------------------------------------------------------------------*/
/*********************************************************************/
/* Examples for Chapter 1 Begin Here                                 */
/* This code is shown in Chapter 1 on page 5.                        */

data weight_club;
   input IdNumber 1-4 Name $ 6-24 Team $ StartWeight EndWeight; 
   Loss=StartWeight-EndWeight; 
   datalines; 
1023 David Shaw          red 189 165
1049 Amelia Serrano      yellow 145 124
1219 Alan Nance          red 210 192
1246 Ravi Sinha          yellow 194 177
1078 Ashley McKnight     red 127 118
;

/* This code is shown in Chapter 1 on page 6.                        */
/* The SAS data set WEIGHT_CLUB was created earlier in Chapter 1     */
/* on page 5.                                                        */

options linesize=80 pagesize=60 pageno=1 nodate;  

proc print data=weight_club;
   title 'Health Club Data';
run;

/* This code is shown in Chapter 1 on page 7.                        */
/* The SAS data set WEIGHT_CLUB was created earlier in Chapter 1     */
/* on page 5.                                                        */

options linesize=80 pagesize=60 pageno=1 nodate;  

proc tabulate data=weight_club; 
   class team;
   var StartWeight EndWeight Loss;
   table team, mean*(StartWeight EndWeight Loss); 
   title 'Mean Starting Weight, Ending Weight,';
   title2 'and Weight Loss'; 
run;

/*********************************************************************/
/* Examples for Chapter 2 Begin Here                                 */
/* This code is shown in Chapter 2 on page 24.                       */

options linesize=80 pagesize=60 pageno=1 nodate;

data weight_club;    
   input IdNumber Name $ 6--20 Team $ 22--27 StartWeight EndWeight;
   datalines;
1023 David Shaw      red    189 165
1049 Amelia Serrano  yellow 145 124
1219 Alan Nance      red    210 192
1246 Ravi Sinha      yellow 194 177
1078 Ashley McKnight red    127 118
1221 Jim Brown       yellow 220 .
;

proc print data = weight_club;
run;

/* This code is shown in Chapter 2 on page 29.                       */

data weight_club;
   input IdNumber 1-4 Name $ 6-24 Team $ StartWeight EndWeight;
   Loss = StartWeight - EndWeight;
   
   datalines;
1023 David Shaw         red    189 165
1049 Amelia Serrano     yellow 145 124
1219 Alan Nance         red    210 192
1246 Ravi Sinha         yellow 194 177
1078 Ashley McKnight    red    127 118
1221 Jim Brown          yellow 220   .
1095 Susan Stewart      blue   135 127
1157 Rosa Gomez         green  155 141
1331 Jason Schock       blue   187 172
1067 Kanoko Nagasaka    green  135 122
1251 Richard Rose       blue   181 166
1333 Li-Hwa Lee         green  141 129
1192 Charlene Armstrong yellow 152 139
1352 Bette Long         green  156 137
1262 Yao Chen           blue   196 180
1087 Kim Sikorski       red    148 135
1124 Adrienne Fink      green  156 142
1197 Lynne Overby       red    138 125
1133 John VanMeter      blue   180 167
1036 Becky Redding      green  135 123
1057 Margie Vanhoy      yellow 146 132
1328 Hisashi Ito        red    155 142
1243 Deanna Hicks       blue   134 122
1177 Holly Choate       red    141 130
1259 Raoul Sanchez      green  189 172
1017 Jennifer Brooks    blue   138 127
1099 Asha Garg          yellow 148 132
1329 Larry Goss         yellow 188 174
;

/* This code is shown in Chapter 2 on page 32.                       */
/* The SAS data set WEIGHT_CLUB was created earlier in Chapter 2     */
/* on page 29.                                                       */

options pagesize=60 linesize=80 pageno=1 nodate;

proc print data=weight_club;
      title 'Fitness Center Weight Club'; 
run;

/* This code is shown in Chapter 2 on page 34.                       */

data scores;    
   input Name $ Test_1 Test_2 Test_3;
   datalines;
Bill 187 97 103
Carlos 156 76 74
Monique 99 102 129
;

/* This code is shown in Chapter 2 on page 34.                       */

data scores;    
   input Name $ 1-7 Test_1 9-11 Test_2 13-15 Test_3 17-19;
   datalines;
Bill    187  97 103
Carlos  156  76  74
Monique  99 102 129
;

/* This code is shown in Chapter 2 on page 34.                       */

data total_sales;    
   input Date mmddyy10. +2 Amount comma5.
   datalines;
09/05/2000  1,382
10/19/2000  1,235
11/30/2000  2,391
;

/* This code is shown in Chapter 2 on pages 36 and 37.               */

data weight_club;    
   input IdNumber 1-4 Name $ 6-24 Team $ StartWeight EndWeight;
   Loss = StartWeight - EndWeight;    
   datalines; 
1023 David Shaw         red    189 165 
1049 Amelia Serrano     yellow 145 124 
1219 Alan Nance         red    210 192 
1246 Ravi Sinha         yellow 194 177 
1078 Ashley McKnight    red    127 118 
;

/* This code is shown in Chapter 2 on page 37.                       */
/* Copy the following data to an external file.                      */              
1023 David Shaw         red    189 165 
1049 Amelia Serrano     yellow 145 124 
1219 Alan Nance         red    210 192 
1246 Ravi Sinha         yellow 194 177 
1078 Ashley McKnight    red    127 118 
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */ 

data weight_club;    
   infile 'your-input-file';
   input IdNumber $ 1-4 Name $ 6-23 StartWeight 24-26 
         EndWeight 28-30;
   Loss=StartWeight-EndWeight;
run;

/* This code is shown in Chapter 2 on page 37.                       */
/* The SAS data set WEIGHT_CLUB was created earlier in Chaper 2      */
/* on pages 36 and 37.                                               */

data red;    
   set weight_club;
   LossPercent = Loss / StartWeight * 100;
run;

/* This code is shown in Chapter 2 on page 38.                       */
/* Note that in the LIBNAME statement you must supply your userid,   */
/* your password, and a valid path to an Oracle file.                */
/* Note that in the SET statement you must specify the Oracle file.  */

libname dblib oracle user=your-id password=your-pswd 
   path='hrdept_002'; 
data employees;
   set dblib.employees; 
run;

/* This code is shown in Chapter 2 on page 38.                       */
/* Copy the following data to an external file.                      */              
1023 David Shaw         red    189 165 
1049 Amelia Serrano     yellow 145 124 
1219 Alan Nance         red    210 192 
1246 Ravi Sinha         yellow 194 177 
1078 Ashley McKnight    red    127 118 
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

data temp;    
infile 'your-input-file';
   input IdNumber $ 1-4 Name $ 6-23 StartWeight 24-26 
         EndWeight 28-30;
run;

/* This code is shown in Chapter 2 on page 39.                       */
/* Copy the following data to an external file.                      */              
1023 David Shaw         red    189 165 
1049 Amelia Serrano     yellow 145 124 
1219 Alan Nance         red    210 192 
1246 Ravi Sinha         yellow 194 177 
1078 Ashley McKnight    red    127 118 
/* Note that in the FILENAME statement you must supply the path and  */
/* the name of the external file created above.                      */  

filename fitclub 'your-input-file';

data temp;
   infile fitclub;
   input IdNumber $ 1-4 Name $ 6-23 StartWeight 24-26 EndWeight 28-30;
run;

/* This code is shown in Chapter 2 on page 40.                       */
/* Copy the following data to two external files with the names of   */
/* CLUB1 and CLUB2 within a directory, PDS, or MACLIB.               */               
1023 David Shaw         red    189 165 
1049 Amelia Serrano     yellow 145 124 
1219 Alan Nance         red    210 192 
1246 Ravi Sinha         yellow 194 177 
1078 Ashley McKnight    red    127 118 
/* Note that in the FILENAME statement you must supply the name of   */
/* the directory, PDS, or MACLIB where the external file is stored.  */

filename fitclub 'directory-or-PDS-or-MACLIB';

data temp;
   infile fitclub(club1);
   input IdNumber $ 1-4 Name $ 6-23 StartWeight 24-26 EndWeight 28-30;
run;

data temp2;
   infile fitclub(club2);
   input IdNumber $ 1-4 Name $ 6-23 StartWeight 24-26 EndWeight 28-30;
run;

/*********************************************************************/
/* Examples for Chapter 3 Begin Here                                 */
/* This code is shown in Chapter 3 on page 45.                       */

options pagesize=60 linesize=80 pageno=1 nodate;

data club1;    
   input IdNumber Name $ Team $ StartWeight EndWeight;
   datalines;
1023 David red 189 165 
1049 Amelia yellow 145 124 
1219 Alan red 210 192 
1246 Ravi yellow 194 177 
1078 Ashley red 127 118 
1221 Jim yellow 220 . 
;  

proc print data=club1;
   title 'Weight of Club Members';
run;

/* This code is shown in Chapter 3 on page 46.                       */

options pagesize=60 linesize=80 pageno=1 nodate;
data club1;     
   infile datalines dlm=',';
   input IdNumber Name $ Team $ StartWeight EndWeight;
   datalines;
1023,David,red,189,165 
1049,Amelia,yellow,145,124 
1219,Alan,red,210,192 
1246,Ravi,yellow,194,177 
1078,Ashley,red,127,118 
1221,Jim,yellow,220,. 
; 
proc print data=club1;
   title 'Weight of Club Members';
run;

/* This code is shown in Chapter 3 on page 47.                       */

options pagesize=60 linesize=80 pageno=1 nodate;

data club1;    
   input IdNumber 1-4 Name $ 6-11 Team $ 13-18 StartWeight 20-22
         EndWeight 24-26;
   datalines; 
1023 David  red    189 165 
1049 Amelia yellow 145 
1219 Alan   red    210 192 
1246 Ravi   yellow     177 
1078 Ashley red    127 118 
1221 Jim    yellow 220 
;

proc print data=club1;
   title 'Weight Club Members'; 
run;

/* This code is shown in Chapter 3 on pages 48 and 49.               */

options pagesize=60 linesize=80 pageno=1 nodate;

data club2;    
   input IdNumber 1-4 Name $ 6-23 Team $ 25-30 StartWeight 32-34
         EndWeight 36-38;
   datalines;
1023 David Shaw         red    189 165 
1049 Amelia Serrano     yellow 145 124
1219 Alan Nance         red    210 192 
1246 Ravi Sinha         yellow 194 177 
1078 Ashley McKnight    red    127 118 
1221 Jim Brown          yellow 220 
; 
 
proc print data=club2;
   title 'Weight Club Members'; 
run;

/* This code is shown in Chapter 3 on page 49.                       */

options pagesize=60 linesize=80 pageno=1 nodate;

data club2;    
   input Team $ 25 Name $ 6-23 StartWeight 32-34 EndWeight 36-38;
   datalines; 
1023 David Shaw         red    189 165  
1049 Amelia Serrano     yellow 145 124  
1219 Alan Nance         red    210 192  
1246 Ravi Sinha         yellow 194 177  
1078 Ashley McKnight    red    127 118  
1221 Jim Brown          yellow 220 
;

proc print data=club2;
   title 'Weight Club Members'; 
run;

/* This code is shown in Chapter 3 on pages 50 and 51.               */

options pagesize=60 linesize=80 pageno=1 nodate;

data january_sales;    
   input Item $ 1-16 Amount comma5.;
   datalines; 
trucks          1,382 
vans            1,235 
sedans          2,391 
;  

proc print data=january_sales;
   title 'January Sales in Thousands'; 
run;

/* This code is shown in Chapter 3 on page 52.                       */

data january_sales;    
   input Item $ 1-16 Amount comma5.;    
   datalines;  
trucks          1,382  
vans            1,235 
sedans          2,391  
;

/* This code is shown in Chapter 3 on page 52.                       */

data january_sales;    
   input Item $10. @17 Amount comma5.;
   datalines;
trucks          1,382  
vans            1,235  
sedans          2,391 
;

/* This code is shown in Chapter 3 on pages 52 and 53.               */

data january_sales;    
   input Item $10. +6 Amount comma5.;
   datalines;    
trucks          1,382    
vans            1,235    
sedans          2,391
; 

/* This code is shown in Chapter 3 on pages 53 and 54.               */

options pagesize=60 linesize=80 pageno=1 nodate;

data january_sales;    
   input Item : $12. Amount : comma5.;
   datalines;
Trucks 1,382 
Vans 1,235 
Sedans 2,391 
SportUtility 987
;  

proc print data=january_sales;     
   title 'January Sales in Thousands';    
run;

/* This code is shown in Chapter 3 on page 54.                       */

options pagesize=60 linesize=80 pageno=1 nodate;

data club2;    
   input IdNumber Name &amp; $18. Team $ StartWeight EndWeight;
   datalines;    
1023 David Shaw   red 189 165
1049 Amelia Serrano  yellow 145 124    
1219 Alan Nance  red 210 192   
1246 Ravi Sinha  yellow 194 177    
1078 Ashley McKnight  red 127 118    
1221 Jim Brown  yellow 220 .    
;

proc print data=club2;
   title 'Weight Club Members';
run;

/* This code is shown in Chapter 3 on page 55.                       */

options pagesize=60 linesize=80 pageno=1 nodate;

data club1;    
   input IdNumber 
         Name $18.
         Team $ 25-30
         StartWeight EndWeight;
   datalines;
1023 David Shaw         red    189 165
1049 Amelia Serrano     yellow 145 124
1219 Alan Nance         red    210 192
1246 Ravi Sinha         yellow 194 177
1078 Ashley McKnight    red    127 118
1221 Jim Brown          yellow 220   .
;

proc print data=club1;
   title 'Weight Club Members';
run;

/* This code is shown in Chapter 3 on page 56.                       */

data scores;    
   input Team $ 1-6 Score 12-13;
   datalines;
red        59
blue       95
yellow     63
green      76
;

/* This code is shown in Chapter 3 on pages 56 and 57.               */

data scores;    
   input Team $6. +5 Score 2.;
   datalines;
red        59    
blue       95    
yellow     63    
green      76    
;

/* This code is shown in Chapter 3 on page 57.                       */

data scores;    
   input Team $ Score;
   datalines;
red        59
blue       95
yellow     63
green      76
;

/*********************************************************************/
/* Examples for Chapter 4 Begin Here                                 */
/* This code is shown in Chapter 4 on pages 62 and 63.               */

options pagesize=60 linesize=80 pageno=1 nodate;

data red_team;    
   input Team $ 13-18 @;
   if Team='red';
   input IdNumber 1-4 StartWeight 20-22 EndWeight 24-26;
   datalines;
1023 David  red    189 165
1049 Amelia yellow 145 124
1219 Alan   red    210 192
1246 Ravi   yellow 194 177
1078 Ashley red    127 118
1221 Jim    yellow 220   . 
;  

proc print data=red_team;      
   title 'Red Team'; 
run;

/* This code is shown in Chapter 4 on pages 63 and 64.               */

options pagesize=60 linesize=80 pageno=1 nodate;

data body_fat;    
   input Gender $ PercentFat @@;
   datalines; 
m 13.3 f 22    
m 22   f 23.2    
m 16   m 12    
;

proc print data=body_fat;
    title 'Results of Body Fat Testing';
run;

/* This code is shown in Chapter 4 on page 68.                       */

options pagesize=60 linesize=80 pageno=1 nodate;

data club2;    
   input IdNumber 1-4;
   input;
   input StartWeight 1-3 EndWeight 5-7;
   datalines;
1023 David Shaw
red
189 165
1049 Amelia Serrano
yellow
145 124 
1219 Alan Nance
red
210 192
1246 Ravi Sinha
yellow
194 177
1078 Ashley McKnight
red
127 118
1221 Jim Brown
yellow
220  .
;

proc print data=club2;
   title 'Weight Club Members';
run;

/* This code is shown in Chapter 4 on page 69.                       */

options pagesize=60 linesize=80 pageno=1 nodate;

data club2;    
   input IdNumber 1-4 / / StartWeight 1-3 EndWeight 5-7;
   datalines;
1023 David Shaw
red
189 165
1049 Amelia Serrano
yellow
145 124
1219 Alan Nance
red
210 192
1246 Ravi Sinha
yellow
194 177
1078 Ashley McKnight
red
127 118
1221 Jim Brown
yellow
220   . 
;

proc print data=club2;
   title 'Weight Club Members';
run;

/* This code is shown in Chapter 4 on pages 70 and 71.               */

options pagesize=60 linesize=80 pageno=1 nodate;

data club2;    
   input #2 Team $ 1-6 #1 Name $ 6-23 IdNumber 1-4           
         #3 StartWeight 1-3 EndWeight 5-7;
   datalines;
1023 David Shaw
red
189 165
1049 Amelia Serrano
yellow
145 124
1219 Alan Nance
red
210 192
1246 Ravi Sinha
yellow
194 177
1078 Ashley McKnight
red
127 118
1221 Jim Brown
yellow
220   . 
;

proc print data=club2;
   title 'Weight Club Members';
run;

/* This code is shown in Chapter 4 on page 74.                       */
/* Copy the following data to an external file.                      */
22 
333 
4444 
55555
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

options pagesize=60 linesize=80 pageno=1 nodate;

data numbers;    
   infile 'your-external-file';    
   input TestNumber 5.; 
run;

proc print data=numbers;    
   title 'Test DATA Step'; 
run;

/* This code is shown in Chapter 4 on page 76.                       */
/* Copy the following data to an external file.                      */
22 
333 
4444 
55555
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

options pagesize=60 linesize=80 pageno=1 nodate;

data numbers;    
   infile 'your-external-file' missover;
   input TestNumber 5.;
run;

proc print data=numbers;    
   title 'Test DATA Step'; 
run;

/* This code is shown in Chapter 4 on page 77.                       */
/* Copy the following data to an external file.                      */
22 
333 
4444 
55555
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

options pagesize=60 linesize=80 pageno=1 nodate;

data numbers;    
   infile 'your-external-file' truncover;
   input TestNumber 5.;
run;

proc print data=numbers;    
   title 'Test DATA Step'; 
run;

/*********************************************************************/
/* Examples for Chapter 5 Begin Here                                 */
/* This code is shown in Chapter 5 on page 82.                       */
/* Run the following DATA Step to create the CITY data set.          */
data city;    
   input Year 4. @7 ServicesPolice comma6.          
         @15 ServicesFire comma6. @22 ServicesWater_Sewer comma6.          
         @30 AdminLabor comma6. @39 AdminSupplies comma6.          
         @45 AdminUtilities comma6.;    
   ServicesTotal=ServicesPolice+ServicesFire+ServicesWater_Sewer;
   AdminTotal=AdminLabor+AdminSupplies+AdminUtilities;    
   Total=ServicesTotal+AdminTotal;
   label               Total='Total Outlays'                
               ServicesTotal='Services: Total'               
              ServicesPolice='Services: Police'                 
                ServicesFire='Services: Fire'          
         ServicesWater_Sewer='Services: Water & Sewer'         
                  AdminTotal='Administration: Total'                   
                  AdminLabor='Administration: Labor'                
               AdminSupplies='Administration: Supplies'           
              AdminUtilities='Administration: Utilities' ;    
   datalines; 
1980  2,819   1,120    422   391      63     98 
1981  2,477   1,160    500   172      47     70 
1982  2,028   1,061    510   269      29     79 
1983  2,754     893    540   227      21     67 
1984  2,195     963    541   214      21     59 
1985  1,877     926    535   198      16     80 
1986  1,727   1,111    535   213      27     70 
1987  1,532   1,220    519   195      11     69
1988  1,448   1,156    577   225      12     58 
1989  1,500   1,076    606   235      19     62 
1990  1,934     969    646   266      11     63 
1991  2,195   1,002    643   256      24     55 
1992  2,204     964    692   256      28     70 
1993  2,175   1,144    735   241      19     83 
1994  2,556   1,341    813   238      25     97 
1995  2,026   1,380    868   226      24     97 
1996  2,526   1,454    946   317      13     89 
1997  2,027   1,486  1,043   226       .     82 
1998  2,037   1,667  1,152   244      20     88
1999  2,852   1,834  1,318   270      23     74 
2000  2,787   1,701  1,317   307      26     66 
;

options pagesize=60 linesize=80 pageno=1 nodate;

proc datasets library=work nolist;
   contents data=city;
run;

/* This code is shown in Chapter 5 on page 84.                       */
/* Run the following DATA Step to create the CITY data set.          */
data city;    
   input Year 4. @7 ServicesPolice comma6.          
         @15 ServicesFire comma6. @22 ServicesWater_Sewer comma6.          
         @30 AdminLabor comma6. @39 AdminSupplies comma6.          
         @45 AdminUtilities comma6.;    
   ServicesTotal=ServicesPolice+ServicesFire+ServicesWater_Sewer;
   AdminTotal=AdminLabor+AdminSupplies+AdminUtilities;    
   Total=ServicesTotal+AdminTotal;
   label               Total='Total Outlays'                
               ServicesTotal='Services: Total'               
              ServicesPolice='Services: Police'                 
                ServicesFire='Services: Fire'          
         ServicesWater_Sewer='Services: Water & Sewer'         
                  AdminTotal='Administration: Total'                   
                  AdminLabor='Administration: Labor'                
               AdminSupplies='Administration: Supplies'           
              AdminUtilities='Administration: Utilities' ;    
   datalines; 
1980  2,819   1,120    422   391      63     98 
1981  2,477   1,160    500   172      47     70 
1982  2,028   1,061    510   269      29     79 
1983  2,754     893    540   227      21     67 
1984  2,195     963    541   214      21     59 
1985  1,877     926    535   198      16     80 
1986  1,727   1,111    535   213      27     70 
1987  1,532   1,220    519   195      11     69
1988  1,448   1,156    577   225      12     58 
1989  1,500   1,076    606   235      19     62 
1990  1,934     969    646   266      11     63 
1991  2,195   1,002    643   256      24     55 
1992  2,204     964    692   256      28     70 
1993  2,175   1,144    735   241      19     83 
1994  2,556   1,341    813   238      25     97 
1995  2,026   1,380    868   226      24     97 
1996  2,526   1,454    946   317      13     89 
1997  2,027   1,486  1,043   226       .     82 
1998  2,037   1,667  1,152   244      20     88
1999  2,852   1,834  1,318   270      23     74 
2000  2,787   1,701  1,317   307      26     66 
;

options pagesize=60 linesize=80 pageno=1 nodate;

data city2;    
   set city(firstobs=12);
run;

proc print;
   title 'City Expenditures';
   title2 '1991 - 2000';
run;

/* This code is shown in Chapter 5 on page 85.                       */
/* Run the following DATA Step to create the CITY data set.          */
data city;    
   input Year 4. @7 ServicesPolice comma6.          
         @15 ServicesFire comma6. @22 ServicesWater_Sewer comma6.          
         @30 AdminLabor comma6. @39 AdminSupplies comma6.          
         @45 AdminUtilities comma6.;    
   ServicesTotal=ServicesPolice+ServicesFire+ServicesWater_Sewer;
   AdminTotal=AdminLabor+AdminSupplies+AdminUtilities;    
   Total=ServicesTotal+AdminTotal;
   label               Total='Total Outlays'                
               ServicesTotal='Services: Total'               
              ServicesPolice='Services: Police'                 
                ServicesFire='Services: Fire'          
         ServicesWater_Sewer='Services: Water & Sewer'         
                  AdminTotal='Administration: Total'                   
                  AdminLabor='Administration: Labor'                
               AdminSupplies='Administration: Supplies'           
              AdminUtilities='Administration: Utilities' ;    
   datalines; 
1980  2,819   1,120    422   391      63     98 
1981  2,477   1,160    500   172      47     70 
1982  2,028   1,061    510   269      29     79 
1983  2,754     893    540   227      21     67 
1984  2,195     963    541   214      21     59 
1985  1,877     926    535   198      16     80 
1986  1,727   1,111    535   213      27     70 
1987  1,532   1,220    519   195      11     69
1988  1,448   1,156    577   225      12     58 
1989  1,500   1,076    606   235      19     62 
1990  1,934     969    646   266      11     63 
1991  2,195   1,002    643   256      24     55 
1992  2,204     964    692   256      28     70 
1993  2,175   1,144    735   241      19     83 
1994  2,556   1,341    813   238      25     97 
1995  2,026   1,380    868   226      24     97 
1996  2,526   1,454    946   317      13     89 
1997  2,027   1,486  1,043   226       .     82 
1998  2,037   1,667  1,152   244      20     88
1999  2,852   1,834  1,318   270      23     74 
2000  2,787   1,701  1,317   307      26     66 
;

data city3;    
   set city (firstobs=10 obs=15);
run;

/* This code is shown in Chapter 5 on page 86.                       */
/* Run the following DATA Step to create the CITY data set.          */
data city;    
   input Year 4. @7 ServicesPolice comma6.          
         @15 ServicesFire comma6. @22 ServicesWater_Sewer comma6.          
         @30 AdminLabor comma6. @39 AdminSupplies comma6.          
         @45 AdminUtilities comma6.;    
   ServicesTotal=ServicesPolice+ServicesFire+ServicesWater_Sewer;
   AdminTotal=AdminLabor+AdminSupplies+AdminUtilities;    
   Total=ServicesTotal+AdminTotal;
   label               Total='Total Outlays'                
               ServicesTotal='Services: Total'               
              ServicesPolice='Services: Police'                 
                ServicesFire='Services: Fire'          
         ServicesWater_Sewer='Services: Water & Sewer'         
                  AdminTotal='Administration: Total'                   
                  AdminLabor='Administration: Labor'                
               AdminSupplies='Administration: Supplies'           
              AdminUtilities='Administration: Utilities' ;    
   datalines; 
1980  2,819   1,120    422   391      63     98 
1981  2,477   1,160    500   172      47     70 
1982  2,028   1,061    510   269      29     79 
1983  2,754     893    540   227      21     67 
1984  2,195     963    541   214      21     59 
1985  1,877     926    535   198      16     80 
1986  1,727   1,111    535   213      27     70 
1987  1,532   1,220    519   195      11     69
1988  1,448   1,156    577   225      12     58 
1989  1,500   1,076    606   235      19     62 
1990  1,934     969    646   266      11     63 
1991  2,195   1,002    643   256      24     55 
1992  2,204     964    692   256      28     70 
1993  2,175   1,144    735   241      19     83 
1994  2,556   1,341    813   238      25     97 
1995  2,026   1,380    868   226      24     97 
1996  2,526   1,454    946   317      13     89 
1997  2,027   1,486  1,043   226       .     82 
1998  2,037   1,667  1,152   244      20     88
1999  2,852   1,834  1,318   270      23     74 
2000  2,787   1,701  1,317   307      26     66 
;

options pagesize=60 linesize=80 pageno=1 nodate;
 
data services;    
   set city (keep=Year ServicesTotal ServicesPolice ServicesFire
            ServicesWater_Sewer);
run;

proc print data=services;
   title 'City Services-Related Expenditures';
run;

/* This code is shown in Chapter 5 on page 86.                       */
/* Run the following DATA Step to create the CITY data set.          */
data city;    
   input Year 4. @7 ServicesPolice comma6.          
         @15 ServicesFire comma6. @22 ServicesWater_Sewer comma6.          
         @30 AdminLabor comma6. @39 AdminSupplies comma6.          
         @45 AdminUtilities comma6.;    
   ServicesTotal=ServicesPolice+ServicesFire+ServicesWater_Sewer;
   AdminTotal=AdminLabor+AdminSupplies+AdminUtilities;    
   Total=ServicesTotal+AdminTotal;
   label               Total='Total Outlays'                
               ServicesTotal='Services: Total'               
              ServicesPolice='Services: Police'                 
                ServicesFire='Services: Fire'          
         ServicesWater_Sewer='Services: Water & Sewer'         
                  AdminTotal='Administration: Total'                   
                  AdminLabor='Administration: Labor'                
               AdminSupplies='Administration: Supplies'           
              AdminUtilities='Administration: Utilities' ;    
   datalines; 
1980  2,819   1,120    422   391      63     98 
1981  2,477   1,160    500   172      47     70 
1982  2,028   1,061    510   269      29     79 
1983  2,754     893    540   227      21     67 
1984  2,195     963    541   214      21     59 
1985  1,877     926    535   198      16     80 
1986  1,727   1,111    535   213      27     70 
1987  1,532   1,220    519   195      11     69
1988  1,448   1,156    577   225      12     58 
1989  1,500   1,076    606   235      19     62 
1990  1,934     969    646   266      11     63 
1991  2,195   1,002    643   256      24     55 
1992  2,204     964    692   256      28     70 
1993  2,175   1,144    735   241      19     83 
1994  2,556   1,341    813   238      25     97 
1995  2,026   1,380    868   226      24     97 
1996  2,526   1,454    946   317      13     89 
1997  2,027   1,486  1,043   226       .     82 
1998  2,037   1,667  1,152   244      20     88
1999  2,852   1,834  1,318   270      23     74 
2000  2,787   1,701  1,317   307      26     66 
;

data services;    
   set city;    
   keep Year ServicesTotal ServicesPolice ServicesFire
        ServicesWater_Sewer;
run;

/* This code is shown in Chapter 5 on page 87.                       */
/* Run the following DATA Step to create the CITY data set.          */
data city;    
   input Year 4. @7 ServicesPolice comma6.          
         @15 ServicesFire comma6. @22 ServicesWater_Sewer comma6.          
         @30 AdminLabor comma6. @39 AdminSupplies comma6.          
         @45 AdminUtilities comma6.;    
   ServicesTotal=ServicesPolice+ServicesFire+ServicesWater_Sewer;
   AdminTotal=AdminLabor+AdminSupplies+AdminUtilities;    
   Total=ServicesTotal+AdminTotal;
   label               Total='Total Outlays'                
               ServicesTotal='Services: Total'               
              ServicesPolice='Services: Police'                 
                ServicesFire='Services: Fire'          
         ServicesWater_Sewer='Services: Water & Sewer'         
                  AdminTotal='Administration: Total'                   
                  AdminLabor='Administration: Labor'                
               AdminSupplies='Administration: Supplies'           
              AdminUtilities='Administration: Utilities' ;    
   datalines; 
1980  2,819   1,120    422   391      63     98 
1981  2,477   1,160    500   172      47     70 
1982  2,028   1,061    510   269      29     79 
1983  2,754     893    540   227      21     67 
1984  2,195     963    541   214      21     59 
1985  1,877     926    535   198      16     80 
1986  1,727   1,111    535   213      27     70 
1987  1,532   1,220    519   195      11     69
1988  1,448   1,156    577   225      12     58 
1989  1,500   1,076    606   235      19     62 
1990  1,934     969    646   266      11     63 
1991  2,195   1,002    643   256      24     55 
1992  2,204     964    692   256      28     70 
1993  2,175   1,144    735   241      19     83 
1994  2,556   1,341    813   238      25     97 
1995  2,026   1,380    868   226      24     97 
1996  2,526   1,454    946   317      13     89 
1997  2,027   1,486  1,043   226       .     82 
1998  2,037   1,667  1,152   244      20     88
1999  2,852   1,834  1,318   270      23     74 
2000  2,787   1,701  1,317   307      26     66 
;

data services (keep=Year ServicesTotal ServicesPolice ServicesFire
               ServicesWater_Sewer);
   set city;
run;

/* This code is shown in Chapter 5 on page 87.                       */
/* Run the following DATA Step to create the CITY data set.          */
data city;    
   input Year 4. @7 ServicesPolice comma6.          
         @15 ServicesFire comma6. @22 ServicesWater_Sewer comma6.          
         @30 AdminLabor comma6. @39 AdminSupplies comma6.          
         @45 AdminUtilities comma6.;    
   ServicesTotal=ServicesPolice+ServicesFire+ServicesWater_Sewer;
   AdminTotal=AdminLabor+AdminSupplies+AdminUtilities;    
   Total=ServicesTotal+AdminTotal;
   label               Total='Total Outlays'                
               ServicesTotal='Services: Total'               
              ServicesPolice='Services: Police'                 
                ServicesFire='Services: Fire'          
         ServicesWater_Sewer='Services: Water & Sewer'         
                  AdminTotal='Administration: Total'                   
                  AdminLabor='Administration: Labor'                
               AdminSupplies='Administration: Supplies'           
              AdminUtilities='Administration: Utilities' ;    
   datalines; 
1980  2,819   1,120    422   391      63     98 
1981  2,477   1,160    500   172      47     70 
1982  2,028   1,061    510   269      29     79 
1983  2,754     893    540   227      21     67 
1984  2,195     963    541   214      21     59 
1985  1,877     926    535   198      16     80 
1986  1,727   1,111    535   213      27     70 
1987  1,532   1,220    519   195      11     69
1988  1,448   1,156    577   225      12     58 
1989  1,500   1,076    606   235      19     62 
1990  1,934     969    646   266      11     63 
1991  2,195   1,002    643   256      24     55 
1992  2,204     964    692   256      28     70 
1993  2,175   1,144    735   241      19     83 
1994  2,556   1,341    813   238      25     97 
1995  2,026   1,380    868   226      24     97 
1996  2,526   1,454    946   317      13     89 
1997  2,027   1,486  1,043   226       .     82 
1998  2,037   1,667  1,152   244      20     88
1999  2,852   1,834  1,318   270      23     74 
2000  2,787   1,701  1,317   307      26     66 
;

options pagesize=60 linesize=80 pageno=1 nodate;

data services2;    
   set city (drop=Total AdminTotal AdminLabor AdminSupplies 
             AdminUtilities);
run;

proc print data=services2;
   title 'City Services-Related Expenditures';
run;

/* This code is shown in Chapter 5 on page 88.                       */
/* Run the following DATA Step to create the CITY data set.          */
data city;    
   input Year 4. @7 ServicesPolice comma6.          
         @15 ServicesFire comma6. @22 ServicesWater_Sewer comma6.          
         @30 AdminLabor comma6. @39 AdminSupplies comma6.          
         @45 AdminUtilities comma6.;    
   ServicesTotal=ServicesPolice+ServicesFire+ServicesWater_Sewer;
   AdminTotal=AdminLabor+AdminSupplies+AdminUtilities;    
   Total=ServicesTotal+AdminTotal;
   label               Total='Total Outlays'                
               ServicesTotal='Services: Total'               
              ServicesPolice='Services: Police'                 
                ServicesFire='Services: Fire'          
         ServicesWater_Sewer='Services: Water & Sewer'         
                  AdminTotal='Administration: Total'                   
                  AdminLabor='Administration: Labor'                
               AdminSupplies='Administration: Supplies'           
              AdminUtilities='Administration: Utilities' ;    
   datalines; 
1980  2,819   1,120    422   391      63     98 
1981  2,477   1,160    500   172      47     70 
1982  2,028   1,061    510   269      29     79 
1983  2,754     893    540   227      21     67 
1984  2,195     963    541   214      21     59 
1985  1,877     926    535   198      16     80 
1986  1,727   1,111    535   213      27     70 
1987  1,532   1,220    519   195      11     69
1988  1,448   1,156    577   225      12     58 
1989  1,500   1,076    606   235      19     62 
1990  1,934     969    646   266      11     63 
1991  2,195   1,002    643   256      24     55 
1992  2,204     964    692   256      28     70 
1993  2,175   1,144    735   241      19     83 
1994  2,556   1,341    813   238      25     97 
1995  2,026   1,380    868   226      24     97 
1996  2,526   1,454    946   317      13     89 
1997  2,027   1,486  1,043   226       .     82 
1998  2,037   1,667  1,152   244      20     88
1999  2,852   1,834  1,318   270      23     74 
2000  2,787   1,701  1,317   307      26     66 
;


options pagesize=60 linesize=80 pageno=1 nodate;

data services2;    
   set city;    
   drop Total AdminTotal AdminLabor AdminSupplies AdminUtilities;
run;
proc print data=services2; 
run;

/* This code is shown in Chapter 5 on pages 88 and 89.               */
/* Run the following DATA Step to create the CITY data set.          */
data city;    
   input Year 4. @7 ServicesPolice comma6.          
         @15 ServicesFire comma6. @22 ServicesWater_Sewer comma6.          
         @30 AdminLabor comma6. @39 AdminSupplies comma6.          
         @45 AdminUtilities comma6.;    
   ServicesTotal=ServicesPolice+ServicesFire+ServicesWater_Sewer;
   AdminTotal=AdminLabor+AdminSupplies+AdminUtilities;    
   Total=ServicesTotal+AdminTotal;
   label               Total='Total Outlays'                
               ServicesTotal='Services: Total'               
              ServicesPolice='Services: Police'                 
                ServicesFire='Services: Fire'          
         ServicesWater_Sewer='Services: Water & Sewer'         
                  AdminTotal='Administration: Total'                   
                  AdminLabor='Administration: Labor'                
               AdminSupplies='Administration: Supplies'           
              AdminUtilities='Administration: Utilities' ;    
   datalines; 
1980  2,819   1,120    422   391      63     98 
1981  2,477   1,160    500   172      47     70 
1982  2,028   1,061    510   269      29     79 
1983  2,754     893    540   227      21     67 
1984  2,195     963    541   214      21     59 
1985  1,877     926    535   198      16     80 
1986  1,727   1,111    535   213      27     70 
1987  1,532   1,220    519   195      11     69
1988  1,448   1,156    577   225      12     58 
1989  1,500   1,076    606   235      19     62 
1990  1,934     969    646   266      11     63 
1991  2,195   1,002    643   256      24     55 
1992  2,204     964    692   256      28     70 
1993  2,175   1,144    735   241      19     83 
1994  2,556   1,341    813   238      25     97 
1995  2,026   1,380    868   226      24     97 
1996  2,526   1,454    946   317      13     89 
1997  2,027   1,486  1,043   226       .     82 
1998  2,037   1,667  1,152   244      20     88
1999  2,852   1,834  1,318   270      23     74 
2000  2,787   1,701  1,317   307      26     66 
;

options pagesize=60 linesize=80 pageno=1 nodate;

data services(keep=ServicesTotal ServicesPolice ServicesFire
              ServicesWater_Sewer)
     admin(keep=AdminTotal AdminLabor AdminSupplies
           AdminUtilities);
   set city;
run;

proc print data=services;
   title 'City Expenditures: Services';
run;

proc print data=admin;
   title 'City Expenditures: Administration';
run;

/* This code is shown in Chapter 5 on pages 91 and 92.               */
/* Run the following DATA Step to create the CITY data set.          */
data city;    
   input Year 4. @7 ServicesPolice comma6.          
         @15 ServicesFire comma6. @22 ServicesWater_Sewer comma6.          
         @30 AdminLabor comma6. @39 AdminSupplies comma6.          
         @45 AdminUtilities comma6.;    
   ServicesTotal=ServicesPolice+ServicesFire+ServicesWater_Sewer;
   AdminTotal=AdminLabor+AdminSupplies+AdminUtilities;    
   Total=ServicesTotal+AdminTotal;
   label               Total='Total Outlays'                
               ServicesTotal='Services: Total'               
              ServicesPolice='Services: Police'                 
                ServicesFire='Services: Fire'          
         ServicesWater_Sewer='Services: Water & Sewer'         
                  AdminTotal='Administration: Total'                   
                  AdminLabor='Administration: Labor'                
               AdminSupplies='Administration: Supplies'           
              AdminUtilities='Administration: Utilities' ;    
   datalines; 
1980  2,819   1,120    422   391      63     98 
1981  2,477   1,160    500   172      47     70 
1982  2,028   1,061    510   269      29     79 
1983  2,754     893    540   227      21     67 
1984  2,195     963    541   214      21     59 
1985  1,877     926    535   198      16     80 
1986  1,727   1,111    535   213      27     70 
1987  1,532   1,220    519   195      11     69
1988  1,448   1,156    577   225      12     58 
1989  1,500   1,076    606   235      19     62 
1990  1,934     969    646   266      11     63 
1991  2,195   1,002    643   256      24     55 
1992  2,204     964    692   256      28     70 
1993  2,175   1,144    735   241      19     83 
1994  2,556   1,341    813   238      25     97 
1995  2,026   1,380    868   226      24     97 
1996  2,526   1,454    946   317      13     89 
1997  2,027   1,486  1,043   226       .     82 
1998  2,037   1,667  1,152   244      20     88
1999  2,852   1,834  1,318   270      23     74 
2000  2,787   1,701  1,317   307      26     66 
;

options pagesize=60 linesize=80 pageno=1 nodate;

data services (keep=ServicesTotal ServicesPolice ServicesFire
               ServicesWater_Sewer)
     admin (keep=AdminTotal AdminLabor AdminSupplies
            AdminUtilities);
   set city(drop=Total);
run;

proc print data=services;
   title 'City Expenditures: Services';
run;

proc print data=admin;
   title 'City Expenditures: Administration';
run;

/*********************************************************************/
/* Examples for Chapter 6 Begin Here                                 */
/* This code is shown in Chapter 6 on page 98.                       */
/* Copy the following data to an external file.                      */
France 8 793 575 Major 
Spain 10 805 510 Hispania 
India 10   . 489 Royal 
Peru   7 722 590 Mundial
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

options pagesize=60 linesize=80 pageno=1 nodate; 
libname mylib 'permanent-data-library';

data mylib.internationaltours;
    infile 'input-file';
    input Country $ Nights AirCost LandCost Vendor $;

proc print data = mylib.internationaltours;
   title 'Data Set MYLIB.INTERNATIONALTOURS';
run;

/* This code is shown in Chapter 6 on page 99.                       */
/* The SAS data set MYLIB.INTERNATIONALTOURS was created earlier     */
/* in Chapter 6 on page 98.                                          */

options pagesize=60 linesize=80 pageno=1 nodate; 
data newair;    
   set mylib.internationaltours;
   NewAirCost = AirCost + 10;

proc print data=newair;
   var Country AirCost NewAirCost;
   title 'Increasing the Air Fare by $10 for All Tours';
run;

/* This code is shown in Chapter 6 on page 100.                      */
/* The SAS data set MYLIB.INTERNATIONALTOURS was created earlier     */
/* in Chapter 6 on page 98.                                          */

options pagesize=60 linesize=80 pageno=1 nodate; 
data bonus;    
   set mylib.internationaltours;
   if Vendor = 'Hispania' then BonusPoints = 'For 10+ people';
   else if Vendor = 'Mundial' then BonusPoints = 'Yes';
run;

proc print data=bonus;
   var Country Vendor BonusPoints;
   title1 'Adding Information to Observations for';
   title2 'Vendors Who Award Bonus Points';
run;

/* This code is shown in Chapter 6 on page 101.                      */
/* The SAS data set MYLIB.INTERNATIONALTOURS was created earlier     */
/* in Chapter 6 on page 98.                                          */

options pagesize=60 linesize=80 pageno=1 nodate; 
data newair2;    
   set mylib.internationaltours;
   AirCost = AirCost + 10;

proc print data=newair2;
   var Country AirCost;
   title 'Adding Tax to the Air Cost Without Adding a New Variable';
run;

/* This code is shown in Chapter 6 on page 102.                      */
/* The SAS data set MYLIB.INTERNATIONALTOURS was created earlier     */
/* in Chapter 6 on page 98.                                          */

options pagesize=60 linesize=80 pageno=1 nodate; 
data tourinfo;    
   set mylib.internationaltours;
   if Vendor = 'Hispania' then BonusPoints = 'For 10+ people';
   else if Vendor = 'Mundial' then BonusPoints = 'Yes';
        else if Vendor = 'Major' then Discount = 'For 30+ people';
run;

proc print data=tourinfo;
   var Country Vendor BonusPoints Discount;
   title 'Information About Vendors';
run;

/* This code is shown in Chapter 6 on page 102.                      */
/* The SAS data set MYLIB.INTERNATIONALTOURS was created earlier     */
/* in Chapter 6 on page 98.                                          */

options pagesize=60 linesize=80 pageno=1 nodate; 
data newinfo;    
   set mylib.internationaltours;
   if Vendor = 'Hispania' then Remarks = 'Bonus for 10+ people';
   else if Vendor = 'Mundial' then Remarks = 'Bonus points';
        else if Vendor = 'Major' then Remarks = 'Discount: 30+ people';
run; 
  
proc print data=newinfo;
   var Country Vendor Remarks;
   title 'Information About Vendors';
run;

/* This code is shown in Chapter 6 on page 103.                      */
/* The SAS data set MYLIB.INTERNATIONALTOURS was created earlier     */
/* in Chapter 6 on page 98.                                          */

options pagesize=60 linesize=80 pageno=1 nodate; 
data newlength;    
   set mylib.internationaltours;
   length Remarks $ 30;
   if Vendor = 'Hispania' then Remarks = 'Bonus for 10+ people';
   else if Vendor = 'Mundial' then Remarks = 'Bonus points';
        else if Vendor = 'Major' then Remarks = 'Discount for 30+ people';
run;

proc print data=newlength;
   var Country Vendor Remarks;
   title 'Information About Vendors';
run;

/* This code is shown in Chapter 6 on page 104.                      */
/* The SAS data set MYLIB.INTERNATIONALTOURS was created earlier     */
/* in Chapter 6 on page 98.                                          */

options pagesize=60 linesize=80 pageno=1 nodate; 
data subset;    
   set mylib.internationaltours;
   if Country = 'Peru' then delete;
run;

proc print data=subset;
   title 'Omitting a Discontinued Tour';
run;

/*********************************************************************/
/* Examples for Chapter 7 Begin Here                                 */
/* This code is shown in Chapter 7 on page 109.                      */
/* Copy the following data to an external file.                      */
Japan         8  982 1020 Express 
Greece       12   .   748 Express 
New Zealand  16 1368 1539 Southsea 
Ireland       7  787  628 Express 
Venezuela     9  426  505 Mundial 
Italy         8  852  598 Express 
Russia       14 1106 1024 A-B-C 
Switzerland   9  816  834 Tour2000 
Australia    12 1299 1169 Southsea
Brazil        8  682  610 Almeida
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

options pagesize=60 linesize=80 pageno=1 nodate; 
libname mylib 'permanent-data-library';

data mylib.populartours;
   infile 'input-file';
   input Country $ 1-11 Nights AirCost LandCost Vendor $;
run;

proc print data=mylib.populartours;
   title 'Data Set MYLIB.POPULARTOURS';
run;

/* This code is shown in Chapter 7 on page 110.                      */
/* The SAS data set MYLIB.POPULARTOURS was created earlier           */
/* in Chapter 7 on page 109.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data newtour;    
   set mylib.populartours;
   TotalCost = AirCost + LandCost;
   PeakAir = (AirCost * 1.10) + 8;
   NightCost = LandCost / Nights;
run;

proc print data=newtour;
   var Country Nights AirCost LandCost TotalCost PeakAir NightCost;
   title 'Costs for Tours';
run;

/* This code is shown in Chapter 7 on page 113.                      */
/* The SAS data set MYLIB.POPULARTOURS was created earlier           */
/* in Chapter 7 on page 109.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data moretour;    
   set mylib.populartours;
   RoundAir = round(AirCost,50);
   TotalCostR = round(AirCost + LandCost,100);
   CostSum = sum(AirCost,LandCost);
   RoundSum = round(sum(AirCost,LandCost),100);
run;

proc print data=moretour;
   var Country AirCost LandCost RoundAir TotalCostR CostSum RoundSum;
   title 'Rounding and Summing Values';
run;

/* This code is shown in Chapter 7 on page 114.                      */
/* The SAS data set MYLIB.POPULARTOURS was created earlier           */
/* in Chapter 7 on page 109.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data toursunder2K;    
   set mylib.populartours;    
   TotalCost = AirCost + LandCost;  
if TotalCost gt 2000 then delete;
run;
proc print data=toursunder2K;
   var Country Nights AirCost Landcost TotalCost Vendor;
   title 'Tours $2000 or Less';
run;

/* This code is shown in Chapter 7 on page 115.                      */
/* The SAS data set MYLIB.POPULARTOURS was created earlier           */
/* in Chapter 7 on page 109.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data toursunder2K2;    
   set mylib.populartours;    
   TotalCost = AirCost + LandCost;    
   if TotalCost gt 2000 or Totalcost = . then delete;
run;

proc print data=toursunder2K2;
   var Country Nights TotalCost Vendor;
   title 'Tours $2000 or Less';
run;

/* This code is shown in Chapter 7 on page 116.                      */
/* The SAS data set MYLIB.POPULARTOURS was created earlier           */
/* in Chapter 7 on page 109.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data shorter;    
   set mylib.populartours;
   length Nights AirCost LandCost RoundAir TotalCostR
          Costsum RoundSum 4;
   RoundAir = round(AirCost,50);
   TotalCostR = round(AirCost + LandCost,100);
   CostSum = sum(AirCost,LandCost);
   RoundSum = round(sum(AirCost,LandCost),100);
run;

/*********************************************************************/
/* Examples for Chapter 8 Begin Here                                 */
/* This code is shown in Chapter 8 on page 120.                      */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */

options pagesize=60 linesize=80 pageno=1 nodate; 
libname mylib 'permanent-data-library';

data mylib.departures;
   input Country $ 1-9 CitiesInTour 11-12 USGate $ 14-26 
         ArrivalDepartureGates $ 28-48;
   datalines;
Japan      5 San Francisco          Tokyo, Osaka
Italy      8 New York               Rome, Naples
Australia 12 Honolulu           Sydney, Brisbane
Venezuela  4 Miami            Caracas, Maracaibo
Brazil     4               Rio de Janeiro, Belem
;
proc print data=mylib.departures;
   title 'Data Set AIR.DEPARTURES';
run;

/* This code is shown in Chapter 8 on page 122.                      */
/* The SAS data set MYLIB.DEPARTURES was created earlier             */
/* in Chapter 8 on page 120.                                         */

options pagesize=60 linesize=80 pageno=1 nodate;  
data charvars;    
   set mylib.departures;
   Schedule = '3-4 tours per season';
   Remarks = "See last year's schedule";
   if USGate = 'San Francisco' then Airport = 'SFO';
    else if USGate = 'Honolulu' then Airport = 'HNL';
run;

proc print data=charvars noobs;
   var Country Schedule Remarks USGate Airport;
   title 'Tours By City of Departure';
run;

/* This code is shown in Chapter 8 on page 123.                      */
/* The SAS data set MYLIB.DEPARTURES was created earlier             */
/* in Chapter 8 on page 120.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data aircode;    
   set mylib.departures;
   if USGate = 'San Francisco' then Airport = 'SFO';    
   else if USGate = 'Honolulu' then Airport = 'HNL';         
   else if USGate = 'New York' then Airport = 'JFK or LGA';
run;

proc print data=aircode;
   var Country USGate Airport;
   title 'Country by US Point of Departure';
run;   

/* This code is shown in Chapter 8 on page 124.                      */
/* The SAS data set MYLIB.DEPARTURES was created earlier             */
/* in Chapter 8 on page 120.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data aircode2;   
   length Airport $ 10;
   set mylib.departures;
   if USGate = 'San Francisco' then Airport = 'SFO';
   else if USGate = 'Honolulu' then Airport = 'HNL';
        else if USGate = 'New York' then Airport = 'JFK or LGA';
             else if USGate = 'Miami' then Airport = 'MIA';
run;

proc print data=aircode2;
   var Country USGate Airport;
   title 'Country by US Point of Departure';
run;

/* This code is shown in Chapter 8 on page 125.                      */

options pagesize=60 linesize=80 pageno=1 nodate;  

data missingval;    
   length Country $ 10 TourGuide $ 10;    
   input Country TourGuide;    
   datalines; 
Japan Yamada 
Italy Militello 
Australia Edney
Venezuela .
Brazil Cardoso
;

proc print data=missingval;
   title 'Missing Values for Character List Input Data';
run;

/* This code is shown in Chapter 8 on pages 125 and 126.             */
/* The SAS data set MYLIB.DEPARTURES was created earlier             */
/* in Chapter 8 on page 120.                                         */

options pagesize=60 linesize=80 pageno=1 nodate;  

data checkgate;    
   length GateInformation $ 15;    
   set mylib.departures;    
   if USGate = ' ' then GateInformation = 'Missing';
   else GateInformation = 'Available';
run;
proc print data=checkgate;
   var Country CitiesIntour USGate ArrivalDepartureGates GateInformation;
   title 'Checking For Missing Gate Information';
run;

/* This code is shown in Chapter 8 on page 126.                      */
/* The SAS data set MYLIB.DEPARTURES was created earlier             */
/* in Chapter 8 on page 120.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data departuredays;    
   set mylib.departures;    
   length DayOfDeparture $ 8;    
   if CitiesInTour <=7 then DayOfDeparture = 'Sunday';
   else DayOfDeparture = ' ';
run;

proc print data=departuredays;
   var Country CitiesInTour DayOfDeparture;
   title 'Departure Day is Sunday or Missing';
run;

/* This code is shown in Chapter 8 on page 128.                      */
/* The SAS data set MYLIB.DEPARTURES was created earlier             */
/* in Chapter 8 on page 120.                                         */

options pagesize=60 linesize=80 pageno=1 nodate;
  
data gates;    
   set mylib.departures;
   ArrivalGate = scan(ArrivalDepartureGates,1,',');
   DepartureGate = left(scan(ArrivalDepartureGates,2,','));
run;

proc print data=gates;
   var Country ArrivalDepartureGates ArrivalGate DepartureGate;
   title 'Arrival and Departure Gates';
run;

/* This code is shown in Chapter 8 on page 129.                      */
/* The SAS data set MYLIB.DEPARTURES was created earlier             */
/* in Chapter 8 on page 120.                                         */

data gatelength;    
   length ArrivalGate $ 14 DepartureGate $ 9;
   set mylib.departures;
   ArrivalGate = scan(ArrivalDepartureGate,1,',');
   DepartureGate = left(scan(ArrivalDepartureGate,2,','));
run;

/* This code is shown in Chapter 8 on page 130.                      */
/* The SAS data set MYLIB.DEPARTURES was created earlier             */
/* in Chapter 8 on page 120.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data all;    
   set mylib.departures;
   AllGates = USGate || ArrivalDepartureGates;
run;

proc print data=all;
   var Country USGate ArrivalDepartureGates AllGates;
   title 'All Tour Gates';
run;

/* This code is shown in Chapter 8 on page 131.                      */
/* The SAS data set MYLIB.DEPARTURES was created earlier             */
/* in Chapter 8 on page 120.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data all2;    
   set mylib.departures;
   AllGate2 = trim(USGate) || ArrivalDepartureGates;
run;

proc print data=all2;
   var Country USGate ArrivalDepartureGates AllGate2;
   title 'All Tour Gates';
run;

/* This code is shown in Chapter 8 on page 132.                      */
/* The SAS data set MYLIB.DEPARTURES was created earlier             */
/* in Chapter 8 on page 120.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data all3;    
   set mylib.departures;
   AllGate3 = trim(USGate)||', '||ArrivalDepartureGates;
   if Country = 'Brazil' then AllGate3 = ArrivalDepartureGates;
run;

proc print data=all3;
   var Country USGate ArrivalDepartureGates AllGate3;
   title 'All Tour Gates';
run;

/* This code is shown in Chapter 8 on pages 132 and 133.             */
/* The SAS data set MYLIB.DEPARTURES was created earlier             */
/* in Chapter 8 on page 120.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data gates;    
   set mylib.departures;
   ArrivalGate = scan(ArrivalDepartureGates,1,',');    
   DepartureGate = left(scan(ArrivalDepartureGates,2,','));
run;

options pagesize=60 linesize=80 pageno=1 nodate; 
data gates2;    
   set gates;
   ADGates = ArrivalGate||', '||DepartureGate;
   ADLength = vlength(ADGates);
run;

proc print data=gates2;
   var Country ArrivalDepartureGates ADGates ADLength;
   title 'All Tour Gates';
run;

/* This code is shown in Chapter 8 on pages 133 and 134.             */
/* The SAS data set GATES was created earlier                        */
/* in Chapter 8 on pages 132 and 133.                                */

options pagesize=60 linesize=80 pageno=1 nodate; 
data gates3;    
   length ADGates $ 30; 
   set gates;
   ADGates = trim(ArrivalGate)||', '||DepartureGate;
run;

proc print data=gates3;
   var country ArrivalDepartureGates ADGates;
   title 'All Tour Gates';
run;

/* This code is shown in Chapter 8 on page 134.                      */

options pagesize=60 linesize=80 pageno=1 nodate;

data hotels;    
   input Country $ 1-9 HotelRank $ 11 LandCost;
   datalines;
Italy     2  498
Italy     4  698
Australia 2  915
Australia 3 1169
Australia 4 1399
;

proc print data=hotels;
   title 'Hotel Rankings';
run;

/*********************************************************************/
/* Examples for Chapter 9 Begin Here                                 */
/* This code is shown in Chapter 9 on page 140.                      */
/* Copy the following data to an external file.                      */
Rome      3  750 7 4 M, 3 G          D'Amico  Torres 
Paris     8 1680 6 5 M, 1 other      Lucas    Lucas 
London    6 1230 5 3 M, 2 G          Wilson   Lucas 
New York  6    . 8 5 M, 1 G, 2 other Lucas    D'Amico 
Madrid    3  370 5 3 M, 2 other      Torres   D'Amico 
Amsterdam 4  580 6 3 M, 3 G                   Vandever
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

options pagesize=60 linesize=80 pageno=1 nodate; 
libname mylib 'permanent-data-library';

data mylib.arttours;
   infile 'input-file' truncover;
   input City $ 1-9 Nights 11 LandCost 13-16 NumberOfEvents 18 
         EventDescription $ 20-36 TourGuide $ 38-45 
         BackUpGuide $ 47-54;
run;

proc print data=mylib.arttours;
   title 'Data Set MYLIB.ARTTOURS';
run;

/* This code is shown in Chapter 9 on page 142.                      */
/* The SAS data set MYLIB.ARTTOURS was created earlier               */
/* in Chapter 9 on page 140.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data revise;    
   set mylib.arttours;
   if City = 'Rome' then LandCost = LandCost + 30;
   if NumberOfEvents > Nights then Calendar = 'Check schedule';
   if TourGuide = 'Lucas' and Nights > 7 then TourGuide = 'Torres';
run;

proc print data=revise;
   var City Nights LandCost NumberOfEvents TourGuide Calendar;
   title 'Tour Information';
run;

/* This code is shown in Chapter 9 on page 143.                      */
/* The SAS data set MYLIB.ARTTOURS was created earlier               */
/* in Chapter 9 on page 140.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data revise2;    
   set mylib.arttours;
   if City = 'Rome' then LandCost = LandCost + 30;    
   if NumberOfEvents > Nights then Calendar = 'Check schedule';
   else Calendar = 'No problems';
   if TourGuide = 'Lucas' and Nights > 7 then TourGuide = 'Torres';
run;

proc print data=revise2;
   var City Nights LandCost NumberOfEvents TourGuide Calendar;
   title 'Tour Information';
run;

/* This code is shown in Chapter 9 on pages 144 and 145.             */
/* The SAS data set MYLIB.ARTTOURS was created earlier               */
/* in Chapter 9 on page 140.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data prices;    
   set mylib.arttours;
   if LandCost >= 1500 then Price = 'High   ';
   else if LandCost >= 700 then Price = 'Medium';
          else Price = 'Low';
run;

proc print data=prices;
   var City LandCost Price;
   title 'Tour Prices';
run;

/* This code is shown in Chapter 9 on page 146.                      */
/* The SAS data set MYLIB.ARTTOURS was created earlier               */
/* in Chapter 9 on page 140.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data changes;    
   set mylib.arttours;
   if Nights >= 6 then Stay = 'Week+';
   else Stay = 'Days';
   if LandCost ne . then Remarks = 'OK  ';
   else Remarks = 'Redo';
   if LandCost lt 600 then Budget = 'Low   ';
   else Budget = 'Medium';
   if NumberOfEvents / Nights > 2 then Pace = 'Too fast';
   else Pace = 'OK';
run;

proc print data=changes;
   var City Nights LandCost NumberOfEvents Stay Remarks Budget Pace;
   title 'Tour Information';
run;

/* This code is shown in Chapter 9 on pages 147 and 148.             */
/* The SAS data set MYLIB.ARTTOURS was created earlier               */
/* in Chapter 9 on page 140.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data showand;    
   set mylib.arttours;
   if City = 'Paris' and TourGuide = 'Lucas' then Remarks = 'Bilingual';
   if 1000 <= LandCost <= 1500 then Price = '1000-1500';
run;

proc print data=showand;
   var City LandCost TourGuide Remarks Price;
   title 'Tour Information';
run;

/* This code is shown in Chapter 9 on page 148.                      */
/* The SAS data set MYLIB.ARTTOURS was created earlier               */
/* in Chapter 9 on page 140.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data showor;    
   set mylib.arttours;
   if LandCost gt 1500 or LandCost / Nights gt 200 then Level = 'Deluxe';
run;
proc print data=showor;
   var City LandCost Nights Level;
   title 'Tour Information';
run;

/* This code is shown in Chapter 9 on page 149.                      */
/* The SAS data set MYLIB.ARTTOURS was created earlier               */
/* in Chapter 9 on page 140.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data test;    
   set mylib.arttours;
   if TourGuide ne BackUpGuide or TourGuide ne ' ' then GuideCheckUsingOR = 'OK';
   else GuideCheckUsingOR = 'No';
   if TourGuide ne BackUpGuide and TourGuide ne ' ' then GuideCheckUsingAND = 'OK';
   else GuideCheckUsingAND = 'No';
run;

proc print data = test;
   var City TourGuide BackUpGuide GuideCheckUsingOR GuideCheckUsingAND;
   title 'Negative Operators with OR and AND';
run;

/* This code is shown in Chapter 9 on page 150.                      */
/* The SAS data set MYLIB.ARTTOURS was created earlier               */
/* in Chapter 9 on page 140.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data combine;    
   set mylib.arttours;
   if (City = 'Paris' or City = 'Rome') and
      (TourGuide = 'Lucas' or TourGuide = "D'Amico") then
      Topic = 'Art history';
run;

proc print data=combine;
   var City TourGuide Topic;
   title 'Tour Information';
run;

/* This code is shown in Chapter 9 on page 151.                      */
/* The SAS data set MYLIB.ARTTOURS was created earlier               */
/* in Chapter 9 on page 140.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data morecomp;    
   set mylib.arttours;
   if LandCost then Remarks = 'Ready to budget';
   else Remarks = 'Need land cost';
   if Nights = 6 or Nights = 8 then Stay = 'Medium';
   else Stay = 'Short';
run;

proc print data=morecomp;
   var City Nights LandCost Remarks Stay;
   title 'Tour Information';
run;

/* This code is shown in Chapter 9 on page 152.                      */
/* The SAS data set MYLIB.ARTTOURS was created earlier               */
/* in Chapter 9 on page 140.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data newguide;    
   set mylib.arttours;
   if upcase(City) = 'MADRID' then TourGuide = 'Balarezo';
run;

proc print data=newguide;
   var City TourGuide;
   title 'Tour Guides';
run;

/* This code is shown in Chapter 9 on pages 153 and 154.             */
/* The SAS data set MYLIB.ARTTOURS was created earlier               */
/* in Chapter 9 on page 140.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data dguide;    
   set mylib.arttours;
   if TourGuide =: 'D' then Chosen = 'Yes';
   else Chosen = 'No';
run;

proc print data=dguide;
   var City TourGuide Chosen;
   title 'Guides Whose Names Begin with D';
run;

/* This code is shown in Chapter 9 on page 154.                      */
/* The SAS data set MYLIB.ARTTOURS was created earlier               */
/* in Chapter 9 on page 140.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data guidegrp;    
   set mylib.arttours;
   if TourGuide <=: 'L' then TourGuideGroup = 'A-L';
   else TourGuideGroup = 'M-Z';
run;

proc print data=guidegrp;
   var City TourGuide TourGuideGroup;
   title 'Tour Guide Groups';
run;

/* This code is shown in Chapter 9 on pages 155 and 156.             */
/* The SAS data set MYLIB.ARTTOURS was created earlier               */
/* in Chapter 9 on page 140.                                         */

options pagesize=60 linesize=80 pageno=1 nodate; 
data otherevent;    
   set mylib.arttours;
   if index(EventDescription,'other') then OtherEvents = 'Yes';
   else OtherEvents = 'No';
run;

proc print data=otherevent;
   var City EventDescription OtherEvents;
   title 'Tour Events';
run;

/*********************************************************************/
/* Examples for Chapter 10 Begin Here                                */
/* This code is shown in Chapter 10 on page 160.                     */
/* Copy the following data to an external file.                      */
Rome      3  750 Medium D'Amico 
Paris     8 1680 High   Lucas 
London    6 1230 High   Wilson 
New York  6    .        Lucas 
Madrid    3  370 Low    Torres
Amsterdam 4  580 Low
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

options pagesize=60 linesize=80 pageno=1 nodate; 
libname mylib 'permanent-data-library';

data mylib.arts;
   infile 'input-file' truncover;
   input City $ 1-9 Nights 11 LandCost 13-16 Budget $ 18-23
         TourGuide $ 25-32;
run;

proc print data=mylib.arts;
   title 'Data Set MYLIB.ARTS';
run;

/* This code is shown in Chapter 10 on page 161.                     */
/* The SAS data set MYLIB.ARTS was created earlier                   */
/* in Chapter 10 on page 160.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
data remove;    
   set mylib.arts;
   if LandCost = . then delete;
run;

proc print data=remove;
   title 'Tours With Complete Land Costs';
run;

/* This code is shown in Chapter 10 on page 162.                     */
/* Copy the following data to an external file.                      */
Rome      3  750 Medium D'Amico 
Paris     8 1680 High   Lucas 
London    6 1230 High   Wilson 
New York  6    .        Lucas 
Madrid    3  370 Low    Torres
Amsterdam 4  580 Low
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

options pagesize=60 linesize=80 pageno=1 nodate; 
data remove2;    
   infile 'input-file' truncover;
   input City $ 1-9 Nights 11 LandCost 13-16 Budget $ 18-23
         TourGuide $ 25-32;
   if LandCost = . then delete;
run;

proc print data=remove2;
   title 'Tours With Complete Land Costs';
run;

/* This code is shown in Chapter 10 on pages 162 and 163.            */
/* The SAS data set MYLIB.ARTS was created earlier                   */
/* in Chapter 10 on page 160.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
data subset6;    
   set mylib.arts;
   if nights=6;
run; 

proc print data=subset6;
   title 'Six-Night Tours';
run;

/* This code is shown in Chapter 10 on page 163.                     */
/* The SAS data set MYLIB.ARTS was created earlier                   */
/* in Chapter 10 on page 160.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
data lowmed;    
   set mylib.arts;
   if upcase(Budget) = 'HIGH' then delete;
run; 

proc print data=lowmed;
   title 'Medium and Low Priced Tours';
run;

/* This code is shown in Chapter 10 on page 164.                     */
/* The SAS data set MYLIB.ARTS was created earlier                   */
/* in Chapter 10 on page 160.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
data lowmed2;    
   set mylib.arts;
   if upcase(Budget) = 'MEDIUM' or upcase(Budget) = 'LOW';
run;

proc print data=lowmed2;
   title 'Medium and Low Priced Tours';
run;

/* This code is shown in Chapter 10 on page 165.                     */
/* The SAS data set MYLIB.ARTS was created earlier                   */
/* in Chapter 10 on page 160.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
data lucastour othertours;
   set mylib.arts;
   if TourGuide = 'Lucas' then output lucastour;
   else output othertours;
run;

proc print data=lucastour;
   title "Data Set with TourGuide = 'Lucas'";
run;

proc print data=othertours;
   title "Data Set with Other Guides";
run;

/* This code is shown in Chapter 10 on page 166.                     */
/* The SAS data set MYLIB.ARTS was created earlier                   */
/* in Chapter 10 on page 160.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
data lucastour2 othertour2;
   set mylib.arts;
   if TourGuide = 'Lucas' then output lucastour2;
run;

proc print data=lucastour2;
   title "Data Set with Guide = 'Lucas'";
run;

proc print data=othertour2;
   title "Data Set with Other Guides";
run;

/* This code is shown in Chapter 10 on pages 166 and 167.            */
/* The SAS data set MYLIB.ARTS was created earlier                   */
/* in Chapter 10 on page 160.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
data lucasdays otherdays;
   set mylib.arts;    
   if TourGuide = 'Lucas' then output lucasdays;
   else output otherdays;
   Days = Nights+1;
run;

proc print data=lucasdays;
   title "Number of Days in Lucas's Tours";
run;

proc print data=otherdays;
   title "Number of Days in Other Guides' Tours";
run;

/* This code is shown in Chapter 10 on pages 167 and 168.            */
/* The SAS data set MYLIB.ARTS was created earlier                   */
/* in Chapter 10 on page 160.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
data lucasdays2 otherdays2;
   set mylib.arts;    
   Days = Nights + 1;
   if TourGuide = 'Lucas' then output lucasdays2;
   else output otherdays2;
run;

proc print data=lucasdays2;
   title "Number of Days in Lucas's Tours";
run;

proc print data=otherdays2;
   title "Number of Days in Other Guides' Tours";
run;

/* This code is shown in Chapter 10 on pages 168 and 169.            */
/* The SAS data set MYLIB.ARTS was created earlier                   */
/* in Chapter 10 on page 160.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
data lucastour othertour weektour daytour;
   set mylib.arts;
   if TourGuide = 'Lucas' then output lucastour;
   else output othertour;
   if nights >= 6 then output weektour;
   else output daytour;
run;

proc print data=lucastour;
   title "Lucas's Tours";
run;

proc print data=othertour;
   title "Other Guides' Tours";
run;

proc print data=weektour;
   title 'Tours Lasting a Week or More';
run;

proc print data=daytour;
   title 'Tours Lasting Less Than a Week';
run;

/*********************************************************************/
/* Examples for Chapter 11 Begin Here                                */
/* This code is shown in Chapter 11 on page 174.                     */
/* Copy the following data to an external file.                      */
Spain       architecture  10  510 World 
Japan       architecture   8  720 Express 
Switzerland scenery        9  734 World 
France      architecture   8  575 World 
Ireland     scenery        7  558 Express 
New Zealand scenery       16 1489 Southsea 
Italy       architecture   8  468 Express 
Greece      scenery       12  698 Express
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

options pagesize=60 linesize=80 pageno=1 nodate; 

libname mylib 'permanent-data-library';
data mylib.arch_or_scen;
   infile 'input-file' truncover;
   input Country $ 1-11 TourType $ 13-24 Nights LandCost Vendor $;
run;

proc print data=mylib.arch_or_scen;
   title 'Data Set MYLIB.ARCH_OR_SCEN';
run;

/* This code is shown in Chapter 11 on page 176.                     */
/* The SAS data set MYLIB.ARCH_OR_SCEN was created earlier           */
/* in Chapter 11 on page 174.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
proc sort data=mylib.arch_or_scen out=tourorder;    
   by TourType; 
run; 

proc print data=tourorder;
   var TourType Country Nights LandCost Vendor;
   title 'Tours Sorted by Architecture or Scenic Tours';
run;

/* This code is shown in Chapter 11 on page 177.                     */
/* The SAS data set MYLIB.ARCH_OR_SCEN was created earlier           */
/* in Chapter 11 on page 174.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
proc sort data=mylib.arch_or_scen out=tourorder2;    
   by TourType Vendor Landcost;
run;

proc print data=tourorder2;
   var TourType Vendor Landcost Country Nights;
   title 'Tours Grouped by Type of Tour, Vendor, and Price';
run;

/* This code is shown in Chapter 11 on pages 177 and 178.            */
/* The SAS data set MYLIB.ARCH_OR_SCEN was created earlier           */
/* in Chapter 11 on page 174.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
proc sort data=mylib.arch_or_scen out=tourorder3;    
   by descending TourType Vendor LandCost;
run;

proc print data=tourorder3;
   var TourType Vendor LandCost Country Nights;
   title 'Descending Order of TourType';
run;

/* This code is shown in Chapter 11 on page 178.                     */
/* The SAS data set MYLIB.ARCH_OR_SCEN was created earlier           */
/* in Chapter 11 on page 174.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
proc sort data=mylib.arch_or_scen out=tourorder4;    
   by TourType LandCost;
run;

proc print data=tourorder4;
   var TourType LandCost Country Nights Vendor;
   title 'Tours Arranged by TourType and LandCost';
run;

/* This code is shown in Chapter 11 on pages 179 and 180.            */
/* The SAS data set MYLIB.ARCH_OR_SCEN was created earlier           */
/* in Chapter 11 on page 174.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
data temp;    
   set tourorder4;
   by TourType;    
   FirstTour = first.TourType;
   LastTour = last.TourType;
run;
proc print data=temp;
   var Country Tourtype FirstTour LastTour;
   title 'Specifying FIRST.TOURTYPE and LAST.TOURTYPE';
run;

/* This code is shown in Chapter 11 on page 180.                     */
/* The SAS data set MYLIB.ARCH_OR_SCEN was created earlier           */
/* in Chapter 11 on page 174.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
proc sort data=mylib.arch_or_scen out=tourorder4;    
   by TourType LandCost; 
run;  

data lowcost;    
   set tourorder4;
   by TourType;    
   if first.TourType;
run;

proc print data=lowcost;
   title 'Least Expensive Tour for Each Type of Tour';
run;

/* This code is shown in Chapter 11 on page 181.                     */
/* The SAS data set MYLIB.ARCH_OR_SCEN was created earlier           */
/* in Chapter 11 on page 174.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
proc sort data=mylib.arch_or_scen out=bycountry;    
   by Country;
run;

proc print data=bycountry;
   title 'Tours in Alphabetical Order by Country';
run;

/* This code is shown in Chapter 11 on page 182.                     */
/* Copy the following data to an external file.                      */
Spain       architecture  10  510 World 
Japan       architecture   8  720 Express 
Switzerland scenery        9  734 World 
France      architecture   8  575 World 
Switzerland scenery        9  734 World 
Ireland     scenery        7  558 Express 
New Zealand scenery       16 1489 Southsea 
Italy       architecture   8  468 Express 
Greece      scenery       12  698 Express
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

options pagesize=60 linesize=80 pageno=1 nodate;  

libname mylib '.';
data mylib.arch_or_scen2;
   infile 'f:\pub\doc\802\authoring\TW6025\admin\arch_or_scen2.txt';
   input Country $ 1-11 TourType $ 13-24 Nights LandCost Vendor $;
run;

proc print data=mylib.arch_or_scen2;
   title 'Data Set MYLIB.ARCH_OR_SCEN2';
run;

/* This code is shown in Chapter 11 on page 183.                     */
/* The SAS data set MYLIB.ARCH_OR_SCEN was created earlier           */
/* in Chapter 11 on page 174.                                        */

options pagesize=60 linesize=80 pageno=1 nodate;
proc sort data=mylib.arch_or_scen2 out=fixed noduprecs;
    by Country;
run;

proc print data=fixed;
   title 'Data Set FIXED: MYLIB.ARCH_OR_SCEN2 With Duplicates Removed';
run;

/*********************************************************************/
/* Examples for Chapter 12 Begin Here                                */
/* This code is shown in Chapter 12 on page 188.                     */
/* Copy the following data to an external file.                      */
France       575 Express  10 
Spain        510 World    12 
Brazil       540 World     6 
India        489 Express   . 
Japan        720 Express  10 
Greece       698 Express  20 
New Zealand 1489 Southsea  6 
Venezuela    425 World     8 
Italy        468 Express   9 
Russia       924 World     6 
Switzerland  734 World    20 
Australia   1079 Southsea 10 
Ireland      558 Express   9
/* Note that the data had been updated to replace USSR with Russia.  */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

options pagesize=60 linesize=80 pageno=1 nodate; 
libname mylib 'permanent-data-library';

data mylib.tourrevenue;
   infile 'input-file' truncover;
   input Country $ 1-11 LandCost Vendor $ NumberOfBookings;
run;

proc print data=mylib.tourrevenue;
   title 'SAS Data Set MYLIB.TOURREVENUE';
run;

/* This code is shown in Chapter 12 on pages 189 and 190.            */
/* The SAS data set MYLIB.TOURREVENUE was created earlier            */
/* in Chapter 12 on page 188.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
data total;    
   set mylib.tourrevenue;
   TotalBookings + NumberOfBookings;
run;

proc print data=total;
   var Country NumberOfBookings TotalBookings;
   title 'Total Tours Booked';
run;

/* This code is shown in Chapter 12 on page 191.                     */
/* The SAS data set MYLIB.TOURREVENUE was created earlier            */
/* in Chapter 12 on page 188.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
data total2(keep=TotalBookings);
   set mylib.tourrevenue end=Lastobs;
   TotalBookings + NumberOfBookings;
   if Lastobs;
run;

proc print data=total2;
   title 'Total Number of Tours Booked';
run;

/* This code is shown in Chapter 12 on pages 191 and 192.            */
/* The SAS data set MYLIB.TOURREVENUE was created earlier            */
/* in Chapter 12 on page 188.                                        */

options pagesize=60 linesize=80 pageno=1 nodate;
proc sort  data=mylib.tourrevenue out=mylib.sorttour;
    by Vendor;
run;

data totalby;
   set mylib.sorttour;
   by Vendor;
   if First.Vendor then VendorBookings = 0;
   VendorBookings + NumberOfBookings;
run;

proc print data=totalby;
   title 'Summary of Bookings by Vendor';
run;

/* This code is shown in Chapter 12 on pages 192 and 193.            */
/* The SAS data set MYLIB.TOURREVENUE was created earlier            */
/* in Chapter 12 on page 188.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
proc sort data=mylib.tourrevenue out=mylib.sorttour;    
   by Vendor; 
run;  

data totalby(drop=country landcost);
   set mylib.sorttour;
   by Vendor;
   if First.Vendor then VendorBookings = 0;
   VendorBookings + NumberOfBookings;
   if Last.Vendor;
run;

proc print data=totalby;
   title 'Total Bookings by Vendor';
run;

/* This code is shown in Chapter 12 on pages 194 and 195.            */
/* The SAS data set MYLIB.TOURREVENUE was created earlier            */
/* in Chapter 12 on page 188.                                        */

options pagesize=60 linesize=80 pageno=1 nodate;
proc sort data=mylib.tourrevenue out=mylib.sorttour;
   by Vendor;
run;

data tourdetails(drop=VendorBookings VendorMoney)
     vendordetails(keep=Vendor VendorBookings VendorMoney);
   set mylib.sorttour;
   by Vendor;
   Money = LandCost * NumberOfBookings;
   output tourdetails;
   if First.Vendor then
      do;
         VendorBookings = 0;
         VendorMoney = 0;
      end;
   VendorBookings + NumberOfBookings;
   VendorMoney + Money;
   if Last.Vendor then output vendordetails;
run;

proc print data=tourdetails;
   title 'Detail Records: Dollars Spent on Individual Tours';
run;

proc print data=vendordetails;
   title 'Vendor Totals: Dollars Spent and Bookings by Vendor';
run;

/* This code is shown in Chapter 12 on page 196.                     */
/* The SAS data set MYLIB.TOURREVENUE was created earlier            */
/* in Chapter 12 on page 188.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
data temp;    
   set mylib.tourrevenue;
   retain HoldRevenue;
   Revenue = LandCost * NumberOfBookings;
   output;
   HoldRevenue = Revenue;
run;

proc print data=temp;
   var Country LandCost NumberOfBookings Revenue HoldRevenue;
   title 'Tour Revenue';
run;

/* This code is shown in Chapter 12 on page 197.                     */
/* The SAS data set MYLIB.TOURREVENUE was created earlier            */
/* in Chapter 12 on page 188.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
data mostrevenue;    
   set mylib.tourrevenue;    
   retain HoldRevenue;    
   Revenue = LandCost * NumberOfBookings;
   if Revenue > HoldRevenue then HoldRevenue = Revenue;
run;

proc print data=mostrevenue;
   var Country LandCost NumberOfBookings Revenue HoldRevenue;
   title 'Tour Revenue';
run;

/* This code is shown in Chapter 12 on page 198.                     */
/* The SAS data set MYLIB.TOURREVENUE was created earlier            */
/* in Chapter 12 on page 188.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
data mostrevenue (keep=HoldCountry HoldRevenue);
   set mylib.tourrevenue  end=LastOne;
   retain HoldRevenue HoldCountry;
   Revenue = LandCost * NumberOfBookings;
   if Revenue > HoldRevenue then
      do;
         HoldRevenue = Revenue;
         HoldCountry = Country;
      end;
   if LastOne;
run;
proc print data=mostrevenue;
   title 'Country with the Largest Value of Revenue';
run;

/*********************************************************************/
/* Examples for Chapter 13 Begin Here                                */
/* This code is shown in Chapter 13 on page 202.                     */
/* Copy the following data to an external file.                      */
Rome      4 3 . D'Amico  2 
Paris     5 . 1 Lucas    5 
London    3 2 . Wilson   3 
New York  5 1 2 Lucas    5 
Madrid    . . 5 Torres   4 
Amsterdam 3 3 .          .
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

options pagesize=60 linesize=80 pageno=1 nodate; 
libname mylib '.';

data mylib.attractions;
   infile 'f:\pub\doc\802\authoring\TW6025\admin\attractions.txt';
   input City $ 1-9 Museums 11 Galleries 13
         Other 15 TourGuide $ 17-24 YearsExperience 26;
run;

proc print data=mylib.attractions;
   title 'Data Set MYLIB.ATTRACTIONS';
run;

/* This code is shown in Chapter 13 on page 203.                     */
/* The SAS data set MYLIB.ATTRACTIONS was created earlier            */
/* in Chapter 13 on page 202.                                        */

options pagesize=60 linesize=80 pageno=1 nodate;    

data updatedattractions2;    
   set mylib.attractions;    
   if City = 'Madrid' then
      do;
         Museums = 3;
         Other = 2;
      end;
   else if City = 'Amsterdam' then
      do;
         TourGuide = 'Vandever';
         YearsExperience = 4;
      end;
run;

proc print data=updatedattractions2;
   title 'Data Set MYLIB.UPDATEDATTRACTIONS';
run;

/* This code is shown in Chapter 13 on page 204.                     */
/* The SAS data set MYLIB.ATTRACTIONS was created earlier            */
/* in Chapter 13 on page 202.                                        */

data changes;    
   set mylib.attractions;    
   if Museums = . then Museums = 0;
   if Galleries = . then Galleries = 0;
   if Other = . then Other = 0;
run;

/* This code is shown in Chapter 13 on page 206.                     */
/* The SAS data set MYLIB.ATTRACTIONS was created earlier            */
/* in Chapter 13 on page 202.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
data changes;    
   set mylib.attractions;
   array changelist{3} Museums Galleries Other;
   do Count = 1 to 3;
      if changelist{Count} = . then changelist{Count} = 0;
   end;
run;

proc print data=changes;
   title 'Tour Attractions';
run;

/* This code is shown in Chapter 13 on page 207.                     */
/* The SAS data set MYLIB.ATTRACTIONS was created earlier            */
/* in Chapter 13 on page 202.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
data changes2 (drop=Count);
   set mylib.attractions;
   array changelist{3} Museums Galleries Other;
   do Count = 1 to 3;
      if changelist{Count} = . then changelist{count} = 0;
   end;
run;

proc print data=changes2;
   title 'Tour Attractions';
run;

/*********************************************************************/
/* Examples for Chapter 14 Begin Here                                */
/* This code is shown in Chapter 14 on page 214.                     */
/* Copy the following data to an external file.                      */
Japan       13may2000  8 
Greece      17oct99   12 
New Zealand 03feb2001 16
Brazil      28feb2001  8 
Venezuela   10nov00    9 
Italy       25apr2001  8
Russia      03jun1997 14 
Switzerland 14jan2001  9 
Australia   24oct98   12
Ireland     27aug2000  7
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

options yearcutoff=1920 pagesize=60 linesize=80 pageno=1 nodate; 
libname mylib 'permanent-data-library';

data mylib.tourdates;
   infile 'input-file';
   input Country $ 1-11 @13 DepartureDate date9. Nights;
run;

proc print data=mylib.tourdates;
   title 'Tour Departure Dates as SAS Date Values';
run;

/* This code is shown in Chapter 14 on pages 215 and 216.            */
/* Copy the following data to an external file.                      */
Japan       13may2000  8 
Greece      17oct99   12 
New Zealand 03feb2001 16
Brazil      28feb2001  8 
Venezuela   10nov00    9 
Italy       25apr2001  8
USSR        03jun1997 14 
Switzerland 14jan2001  9 
Australia   24oct98   12
Ireland     27aug2000  7
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */
/* The MYLIB libref was declared earlier in Chapter 14 on page 214.  */

options yearcutoff=1920 pagesize=60 linesize=80 pageno=1 nodate;  

data mylib.tourdates7;
   infile 'input-file';
   input Country $ 1-11 @13 DepartureDate date7. Nights;
run;

proc print data=mylib.tourdates7;
   title 'Tour Departure Dates Using the DATE7. Informat';
   title2 'Displayed as Two-Digit Calendar Dates';
   format DepartureDate date7.;
run;

proc print data=mylib.tourdates7;
   title 'Tour Departure Dates Using the DATE7. Informat';
   title2 'Displayed as Four-Digit Calendar Dates'; 
   format DepartureDate date9.;
run;

/* This code is shown in Chapter 14 on page 217.                     */
/* The SAS data set MYLIB.TOURDATES was created earlier              */
/* in Chapter 14 on page 214.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
data correctdates;    
   set mylib.tourdates;    
   if Country = 'Switzerland' then DepartureDate = '21jan2001'd;
run;

proc print data=correctdates;
   title 'Corrected Departure Date for Switzerland';
   format DepartureDate date9.;
run;

/* This code is shown in Chapter 14 on page 218.                     */
/* The SAS data set MYLIB.TOURDATES was created earlier              */
/* in Chapter 14 on page 214.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
proc print data=mylib.tourdates;
   title 'Departure Dates in Two-Digit Calendar Format';    
   format DepartureDate mmddyy8.;
run;

proc print data=mylib.tourdates;
   title 'Departure Dates in Four-Digit Calendar Format';
   format DepartureDate mmddyy10.;
run;

/* This code is shown in Chapter 14 on page 219.                     */
/* The SAS data set MYLIB.TOURDATES was created earlier              */
/* in Chapter 14 on page 214.                                        */

options yearcutoff=1920 pagesize=60 linesize=80 pageno=1 nodate;  
data mylib.fmttourdate;
   set mylib.tourdates;    
   format DepartureDate date9.;
run;

proc contents data=mylib.fmttourdate nodetails;
run;

/* This code is shown in Chapter 14 on page 220.                     */
/* The SAS data set MYLIB.TOURDATES was created earlier              */
/* in Chapter 14 on page 214.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
proc print data=mylib.tourdates;
   title 'Tour Departure Dates';    
   format DepartureDate worddate18.;
run;

/* This code is shown in Chapter 14 on page 221.                     */
/* The SAS data set MYLIB.FMTTOURDATE was created earlier            */
/* in Chapter 14 on page 219.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
proc sort data=mylib.fmttourdate out=sortdate;    
   by DepartureDate;
run;

proc print data=sortdate;
   var DepartureDate Country Nights;
   title 'Departure Dates Listed in Chronological Order';
run;

/* This code is shown in Chapter 14 on page 222.                     */
/* The SAS data set MYLIB.TOURDATES was created earlier              */
/* in Chapter 14 on page 214.                                        */

options yearcutoff=1920 pagesize=60 linesize=80 pageno=1 nodate; 
data home;
   set mylib.tourdates;    
   Return = DepartureDate + Nights;
   format Return date9.;
run;

proc print data=home;
   title 'Dates of Departure and Return';
run;

/* This code is shown in Chapter 14 on pages 223 and 224.            */
/* The SAS data set MYLIB.TOURDATES was created earlier              */
/* in Chapter 14 on page 214.                                        */

options yearcutoff=1920 pagesize=60 linesize=80 pageno=1 nodate; 
data pay;
   set mylib.tourdates;    
   DueDate = DepartureDate - 30;
   if Weekday(DueDate) = 1 then DueDate = DueDate - 1;
   format DueDate weekdate29.;
run;

proc print data=pay;
   var Country DueDate;
   title 'Date and Day of Week Payment Is Due';
run;

/* This code is shown in Chapter 14 on page 225.                     */
/* The SAS data set MYLIB.TOURDATES was created earlier              */
/* in Chapter 14 on page 214.                                        */
/* DEPARTUREDATE values will have to be changed in the SAS data set  */
/* if output is desired.  The values you change them to will depend  */
/* on today's date.                                                  */

options yearcutoff=1920 pagesize=60 linesize=80 pageno=1 nodate; 
data ads;
   set mylib.tourdates;    
   Now = today();
   if Now + 90 <= DepartureDate <= Now + 180;
run;

proc print data=ads;
title 'Tours Departing between 90 and 180 Days from Today';
   format DepartureDate Now date9.;
run;

/* This code is shown in Chapter 14 on page 225.                     */

options yearcutoff=1920 pagesize=60 linesize=80 pageno=1 nodate;    
data ttage;    
   Start = '08feb82'd;    
   RightNow = today();
   Age = RightNow - Start;
   format Start RightNow date9.;
run;

proc print data=ttage;
   title 'Age of Tradewinds Travel';
run;

/* This code is shown in Chapter 14 on page 226.                     */

options yearcutoff=1920 pagesize=60 linesize=80 pageno=1 nodate;    

data ttage2;    
   Start = '08feb82'd;    
   RightNow = today();
   AgeInDays = RightNow - Start;
   AgeInYears = AgeInDays / 365.25;
   format AgeInYears 4.1 Start RightNow date9.;
run;

proc print data=ttage2;
   title 'Age in Years of Tradewinds Travel';
 run;

/*********************************************************************/
/* Examples for Chapter 16 Begin Here                                */
/* This code is shown in Chapter 16 on page 243.                     */ 

options pagesize=60 linesize=80 pageno=1 nodate; 
data sales;
   input EmployeeID $ 1-9 Name $ 11-29 @30 HireDate date9.
         Salary HomePhone $;
   format HireDate date9.;
   datalines;
429685482 Martin, Virginia   09aug1990 34800 493-0824
244967839 Singleton, MaryAnn 24apr1995 27900 929-2623
996740216 Leighton, Maurice  16dec1993 32600 933-6908
675443925 Freuler, Carl      15feb1998 29900 493-3993
845729308 Cage, Merce        19oct1992 39800 286-0519
;

proc print data=sales;
   title 'Sales Department Employees';
run;

data customer_support;
   input EmployeeID $ 1-9 Name $ 11-29 @30 HireDate date9.
         Salary HomePhone $;
   format HireDate date9.;
   datalines;
324987451 Sayre, Jay         15nov1994 44800 933-2998
596771321 Tolson, Andrew     18mar1998 41200 929-4800
477562122 Jensen, Helga      01feb1991 47400 286-2816
894724859 Kulenic, Marie     24jun1993 41400 493-1472
988427431 Zweerink, Anna     07jul1995 43700 929-3885
;

proc print data=customer_support;
   title 'Customer Support Department Employees';
run;

/* This code is shown in Chapter 16 on page 244.                     */
/* The SAS data sets SALES and CUSTOMER_SUPPORT were created         */
/* earlier in Chapter 16 on page 243.                                */ 

options pagesize=60 linesize=80 pageno=1 nodate; 
data dept1_2;
   set sales customer_support;
run;

proc print data=dept1_2;
   title 'Employees in Sales and Customer Support Departments';
run;

/* This code is shown in Chapter 16 on page 245.                     */ 

options pagesize=60 linesize=80 pageno=1 nodate; 
data security;
   input EmployeeID $ 1-9 Name $ 11-29 Gender $ 30
         @32 HireDate date9. Salary;
   format HireDate date9.;
   datalines;
744289612 Saparilas, Theresa F 09may1998 33400
824904032 Brosnihan, Dylan   M 04jan1992 38200
242779184 Chao, Daeyong      M 28sep1995 37500
544382887 Slifkin, Leah      F 24jul1994 45000
933476520 Perry, Marguerite  F 19apr1992 39900
;

proc print data=security;    
   title 'Security Department Employees';
run;

/* This code is shown in Chapter 16 on page 245.                     */
/* The SAS data sets SALES and CUSTOMER_SUPPORT were created         */
/* earlier  in Chapter 16 on page 243, and the SAS data set          */
/* SECURITY was created earlier in Chapter 16 on page 245.           */

options pagesize=60 linesize=80 pageno=1 nodate;
data dept1_3;
   set sales customer_support security;
run;

proc print data=dept1_3;
   title 'Employees in Sales, Customer Support,';
   title2 'and Security Departments';
run;

/* This code is shown in Chapter 16 on page 247.                     */
/* The SAS data sets SALES and CUSTOMER_SUPPORT were created         */
/* earlier in Chapter 16 on page 243, and the SAS data set           */
/* SECURITY was created earlier in Chapter 16 on page 245.           */ 

options pagesize=60 linesize=80 pageno=1 nodate;

data accounting;
   input EmployeeID 1-9 Name $ 11-29 Gender $ 30
         @32 HireDate date9. Salary;
   format HireDate date9.;
   datalines;
634875680 Gardinski, Barbara F 29may1998 49800
824576630 Robertson, Hannah  F 14mar1995 52700
744826703 Gresham, Jean      F 28apr1992 54000
824447605 Kruize, Ronald     M 23may1994 49200
988674342 Linzer, Fritz      M 23jul1992 50400
;

proc print data=accounting;
   title 'Accounting Department Employees';
run;

data dept1_4;
   set sales customer_support security accounting;
run; 

/* This code is shown in Chapter 16 on page 248.                     */
/* The SAS data set ACCOUNTING was created earlier                   */
/* in Chapter 16 on page 247.                                        */

options pagesize=60 linesize=80 pageno=1 nodate; 
data new_accounting (rename=(TempVar=EmployeeID)drop=EmployeeID); 
   set accounting;  
   TempVar=put(EmployeeID, 9.);
run;

proc datasets library=work; 
   contents data=new_accounting;
run;

/* This code is shown in Chapter 16 on page 249.                     */
/* The SAS data sets SALES, CUSTOMER_SUPPORT, SECURITY,              */
/* and NEW_ACCOUNTING were created earlier in Chapter 16             */
/* on pages 243, 243, 245, and 248, respectively.                    */

options pagesize=60 linesize=80 pageno=1 nodate;

data dept1_4;
   set sales customer_support security new_accounting;
run;
proc print data=dept1_4;
   title 'Employees in Sales, Customer Support, Security,';
   title2 'and Accounting Departments';
run;

/* This code is shown in Chapter 16 on page 250.                     */

options pagesize=60 linesize=80 pageno=1 nodate;

data shipping;
   input employeeID $ 1-9 Name $ 11-29 Gender $ 30
         @32 HireDate date9.
         @42 Salary;
   format HireDate date7.
          Salary comma6.;
   datalines;
688774609 Carlton, Susan     F 28jan1995 29200
922448328 Hoffmann, Gerald   M 12oct1997 27600
544909752 DePuis, David      M 23aug1994 32900
745609821 Hahn, Kenneth      M 23aug1994 33300
634774295 Landau, Jennifer   F 30apr1996 32900
;

proc print data=shipping;
   title 'Shipping Department Employees';
run;

/* This code is shown in Chapter 16 on page 251.                     */
/* The SAS data sets SALES, CUSTOMER_SUPPORT, SECURITY,              */
/* NEW_ACCOUNTING, and SHIPPING were created earlier                 */ 
/* in Chapter 16 on pages 243, 243, 245, 248, and                    */                        
/* 250, respectively.                                                */

options pagesize=60 linesize=80 pageno=1 nodate;

data dept1_5;
   set sales customer_support security new_accounting shipping;
run;
proc print data=dept1_5;
   title 'Employees in Sales, Customer Support, Security,';
   title2 'Accounting, and Shipping Departments';
run;

/* This code is shown in Chapter 16 on page 252.                     */
/* The SAS data sets SALES, CUSTOMER_SUPPORT, SECURITY,              */
/* NEW_ACCOUNTING, and SHIPPING  were created earlier                */ 
/* in Chapter 16 on pages 243, 243, 245, 248, and                    */                        
/* 250, respectively.                                                */

options pagesize=60 linesize=80 pageno=1 nodate;

data dept5_1;
   set shipping new_accounting security customer_support sales;
run;
proc print data=dept5_1;
   title 'Employees in Shipping, Accounting, Security,';
   title2 'Customer Support, and Sales Departments';
run;

/* This code is shown in Chapter 16 on pages 253 and 254.            */
/* The SAS data sets SALES, CUSTOMER_SUPPORT, SECURITY,              */
/* NEW_ACCOUNTING, and SHIPPING  were created earlier                */ 
/* in Chapter 16 on pages 243, 243, 245, 248, and                    */                         
/* 250, respectively.                                                */

options pagesize=60 linesize=80 pageno=1 nodate;
data research;
   input EmployeeID $ 1-9 Name $ 11-37 Gender $ 38
         @40 HireDate date9. Salary;
   format HireDate date9.;
   datalines;
922854076 Schoenberg, Marguerite     F 19nov1994 39800
770434994 Addison-Hardy, Jonathon    M 23feb1992 41400
242784883 McNaughton, Elizabeth      F 24jul1993 45000
377882806 Tharrington, Catherine     F 28sep1994 38600
292450691 Frangipani, Christopher    M 12aug1990 43900
;

proc print data=research;
   title 'Research Department Employees';
run;

data dept6_1;
   set research shipping new_accounting
       security customer_support sales;
run;

/* This code is shown in Chapter 16 on page 255.                     */
/* The SAS data sets SALES, CUSTOMER_SUPPORT, SECURITY,              */
/* NEW_ACCOUNTING, SHIPPING and RESEARCH were created earlier        */ 
/* in Chapter 16 on pages 243, 243, 245, 248 ,250                    */                        
/* and 254, respectively.                                            */

options pagesize=60 linesize=80 pageno=1 nodate;

data dept1_6a;
   length Name $ 27;
   set sales customer_support security
       new_accounting shipping research;
run;
proc print data=dept1_6a;
   title 'Employees in All Departments';
run;

/* This code is shown in Chapter 16 on page 255.                     */
/* The SAS data sets SALES and CUSTOMER_SUPPORT were                 */
/* created earlier on page 243.                                      */

options pagesize=60 linesize=80 pageno=1 nodate;

proc append base=sales data=customer_support;
run;

proc print data=sales;
   title 'Employees in Sales and Customer Support Departments';
run;

/* This code is shown in Chapter 16 on page 257.                     */
/* The SAS data sets SALES and SECURITY were                         */
/* created earlier on pages 243 and 245.                             */

options pagesize=60 linesize=80 pageno=1 nodate;

proc append base=sales data=security;
run;

proc append base=sales data=security force;
run;

proc print data=sales;
   title 'Employees in the Sales and the Security Departments';
run;

/*********************************************************************/
/* Examples for Chapter 17 Begin Here                                */
/* This code is shown in Chapter 17 on pages 264 and 265.            */
 
options pagesize=60 linesize=80 pageno=1 nodate;
data research_development;
   length Department Manager $ 10;
   input Project $ Department $ Manager $ StaffCount;
   datalines;
MP971 Designing Daugherty 10
MP971 Coding Newton 8
MP971 Testing Miller 7
SL827 Designing Ramirez 8
SL827 Coding Cho 10
SL827 Testing Baker 7
WP057 Designing Hascal 11
WP057 Coding Constant 13
WP057 Testing Slivko 10
;

proc print data=research_development;
   title 'Research and Development Project Staffing';
run;

/* This code is shown in Chapter 17 on page 265.                     */

options pagesize=60 linesize=80 pageno=1 nodate;
data publications;
   length Department Manager $ 10;
   input Manager $ Department $ Project $ StaffCount;
   datalines;
Cook Writing WP057 5
Deakins Writing SL827 7
Franscombe Editing MP971 4
Henry Editing WP057 3
King Production SL827 5
Krysonski Production WP057 3
Lassiter Graphics SL827 3
Miedema Editing SL827 5
Morard Writing MP971 6
Posey Production MP971 4
Spackle Graphics WP057 2
;

proc sort data=publications;
   by Project;
run;

proc print data=publications;
   title 'Publications Project Staffing';
run;

/* This code is shown in Chapter 17 on page 266.                     */
/* The SAS data sets RESEARCH_DEVELOPMENT and PUBLICATIONS           */
/* were created earlier in Chapter 17 on pages 264 and 265.          */

options pagesize=60 linesize=80 pageno=1 nodate;
data rnd_pubs;
   set research_development publications;
   by Project;
run;

proc print data=rnd_pubs;
   title 'Project Participation by Research and Development';
   title2 'and Publications Departments';
   title3 'Sorted by Project';
run;

/*********************************************************************/
/* Examples for Chapter 18 Begin Here                                */
/* This code is shown in Chapter 18 on page 271.                     */ 

options pagesize=60 linesize=80 pageno=1 nodate;
data class;
   input Name $ 1-25 Year $ 26-34 Major $ 36-50;
   datalines;
Abbott, Jennifer         first
Carter, Tom              third     Theater
Kirby, Elissa            fourth    Mathematics
Tucker, Rachel           first
Uhl, Roland              second
Wacenske, Maurice        third     Theater
;
proc print data=class;
   title 'Acting Class Roster';
run;

/* This code is shown in Chapter 18 on pages 271 and 272.            */

options pagesize=60 linesize=80 pageno=1 nodate;
data time_slot;
   input Date date9.  @12 Time $ @19 Room $;
   format date date9.;
   datalines;
14sep2000  10:00  103
14sep2000  10:30  103
14sep2000  11:00  207
15sep2000  10:00  105
15sep2000  10:30  105
17sep2000  11:00  207
;

proc print data=time_slot;
   title 'Dates, Times, and Locations of Conferences';
run;

/* This code is shown in Chapter 18 on page 272.                     */
/* The SAS data sets CLASS and TIME_SLOT were created                */
/* earlier in Chapter 18 on page 271.                                */

options pagesize=60 linesize=80 pageno=1 nodate;
data schedule;
   merge class time_slot;
run;

proc print data=schedule;
   title 'Student Conference Assignments';
run;

/* This code is shown in Chapter 18 on page 273.                     */

options pagesize=60 linesize=80 pageno=1 nodate;
data class2;
   input Name $ 1-25 Year $ 26-34 Major $ 36-50;
   datalines;
Hitchcock-Tyler, Erin    second
Keil, Deborah            third     Theater
Nacewicz, Chester        third     Theater
Norgaard, Rolf           second
Prism, Lindsay           fourth    Anthropology
Singh, Rajiv             second
Wittich, Stefan          third     Physics
;

proc print data=class2;
   title 'Acting Class Roster';
   title2 '(second section)';
run;

/* This code is shown in Chapter 18 on page 274.                     */
/* The SAS data sets CLASS, TIME_SLOT, and CLASS2  were created      */
/* earlier in Chapter 18 on pages 271, 271 & 272, and 273,           */
/* respectively.                                                     */

options pagesize=60 linesize=80 pageno=1 nodate;
data exercise;
   merge class (drop=Year Major)
         class2 (drop=Year Major rename=(Name=Name2))
         time_slot;
run;

proc print data=exercise;
   title 'Acting Class Exercise Schedule';
run; 

/* This code is shown in Chapter 18 on pages 276 and 277.            */

options pagesize=60 linesize=80 pageno=1 nodate;

data company;
   input Name $ 1-25 Age 27-28 Gender $ 30;
   datalines;
Vincent, Martina          34 F
Phillipon, Marie-Odile    28 F
Gunter, Thomas            27 M
Harbinger, Nicholas       36 M
Benito, Gisela            32 F
Rudelich, Herbert         39 M
Sirignano, Emily          12 F
Morrison, Michael         32 M
;

proc sort data=company;
   by Name;
run;

data finance;
   input IdNumber $ 1-11 Name $ 13-40 Salary;
   datalines;
074-53-9892 Vincent, Martina             35000
776-84-5391 Phillipon, Marie-Odile       29750
929-75-0218 Gunter, Thomas               27500
446-93-2122 Harbinger, Nicholas          33900
228-88-9649 Benito, Gisela               28000
029-46-9261 Rudelich, Herbert            35000
442-21-8075 Sirignano, Emily             5000
;
proc sort data=finance;
  by Name;
run;

proc print data=company;
   title 'Little Theatre Company Roster';
run;

proc print data=finance;
   title 'Little Theatre Employee Information';
run;

/* This code is shown in Chapter 18 on page 278.                     */
/* The SAS data sets COMPANY and FINANCE were created                */
/* earlier in Chapter 18 on pages 276 and 277.                       */

options pagesize=60 linesize=80 pageno=1 nodate;
data employee_info;
   merge company finance;
   by name;
run;

proc print data=employee_info;
   title 'Little Theatre Employee Information';
   title2 '(including personal and financial information)';
run; 

/* This code is shown in Chapter 18 on page 279.                     */  

options pagesize=60 linesize=80 pageno=1 nodate;
data repertory;
   input Play $ 1-23 Role $ 25-48 IdNumber $ 50-60;
   datalines;
No Exit                 Estelle                  074-53-9892
No Exit                 Inez                     776-84-5391
No Exit                 Valet                    929-75-0218
No Exit                 Garcin                   446-93-2122
Happy Days              Winnie                   074-53-9892
Happy Days              Willie                   446-93-2122
The Glass Menagerie     Amanda Wingfield         228-88-9649
The Glass Menagerie     Laura Wingfield          776-84-5391
The Glass Menagerie     Tom Wingfield            929-75-0218
The Glass Menagerie     Jim O'Connor             029-46-9261
The Dear Departed       Mrs. Slater              228-88-9649
The Dear Departed       Mrs. Jordan              074-53-9892
The Dear Departed       Henry Slater             029-46-9261
The Dear Departed       Ben Jordan               446-93-2122
The Dear Departed       Victoria Slater          442-21-8075
The Dear Departed       Abel Merryweather        929-75-0218
;

proc print data=repertory;
   title 'Little Theater Season Casting Assignments';
run; 

/* This code is shown in Chapter 18 on page 280.                     */ 
/* The SAS data sets FINANCE and REPERTORY were created              */
/* earlier in Chapter 18 on pages 277 and 279.                       */

options pagesize=60 linesize=80 pageno=1 nodate;
proc sort data=finance;
   by IdNumber;
run;

proc sort data=repertory;
   by IdNumber;
run;

proc print data=finance;
   title 'Little Theatre Employee Information';
   title2 '(sorted by employee ID number)';
run;

proc print data=repertory;
   title 'Little Theatre Season Casting Assignments';
   title2 '(sorted by employee ID number)';
run; 

/* This code is shown in Chapter 18 on pages 281 and 282.            */
/* The SAS data sets FINANCE and REPERTORY were created              */
/* earlier in Chapter 18 on pages 277 and 279.                       */

options pagesize=60 linesize=80 pageno=1 nodate;
options linesize=120;

data repertory_name;
   merge finance repertory;
   by IdNumber;
run;

proc print data=repertory_name;
   title 'Little Theatre Season Casting Assignments';
   title2 'with employee financial information';
run;    

/* This code is shown in Chapter 18 on page 284.                     */   
/* The SAS data sets FINANCE and REPERTORY were created              */
/* earlier in Chapter 18 on pages 277 and 279.                       */

options pagesize=60 linesize=80 pageno=1 nodate;
options linesize=120;

data newrep (drop=IdNumber);
   merge finance (drop=Salary) repertory;
   by IdNumber;
run;

proc print data=newrep;
   title 'Final Little Theatre Season Casting Assignments';
run;   

/* This code is shown in Chapter 18 on pages 285 and 286.            */   
/* The SAS data sets COMPANY, FINANCE, and REPERTORY                 */
/* were created earlier in Chapter 18 on pages 276 & 277, 277,       */
/* and 279, respectively.                                            */
 
options pagesize=60 linesize=80 pageno=1 nodate;
options linesize=120;
   /* Sort FINANCE and COMPANY by Name */
proc sort data=finance;
   by Name;
run;

proc sort data=company;
   by Name;
run;

   /* Merge COMPANY and FINANCE into a */
   /* temporary data set.              */
data temp;
   merge company finance;
   by Name;
run;

proc sort data=temp;
   by IdNumber;
run;

   /* Merge the temporary data set with REPERTORY */
data all;
   merge temp repertory;
   by IdNumber;
run;

proc print data=all;
   title 'Little Theatre Complete Casting Information';
run;    

/* This code is shown in Chapter 18 starting on page 287.            */
/* The SAS data set FINANCE was created earlier in Chapter 18        */
/* on page 277.                                                      */  

options pagesize=60 linesize=80 pageno=1 nodate;
options linesize=120;

data company2;
   input name $ 1-25 age 27-28 gender $ 30;
   datalines;
Benito, Gisela            32 F
Gunter, Thomas            27 M
Harbinger, Nicholas       36 M
Phillipon, Marie-Odile    28 F
Rudelich, Herbert         39 M
Sirignano, Emily          12 F
Vincent, Martina          34 F
;

proc print data=company2;
   title 'Little Theatre Company Roster';
run;

proc print data=finance;
   title 'Little Theatre Employee Information';
run; 

/*********************************************************************/
/* Examples for Chapter 19 Begin Here                                */
/* This code is shown in Chapter 19 on pages 295 and 296.            */

options pagesize=60 linesize=80 pageno=1 nodate;
data mail_list;
   input SubscriberId 1-8 Name $ 9-27 StreetAddress $ 28-47 City $ 48-62
         StateProv $ 63-64 PostalCode $ 67-73 Country $;
   datalines;
1001    Ericson, Jane      111 Clancey Court   Chapel Hill    NC  27514   USA
1002    Dix, Martin        4 Shepherd St.      Vancouver      BC  V6C 3E8 Canada
1003    Gabrielli, Theresa Via Pisanelli, 25   Roma               00196   Italy
1004    Clayton, Aria      14 Bridge St.       San Francisco  CA  94124   USA
1005    Archuleta, Ruby    Box 108             Milagro        NM  87429   USA
1006    Misiewicz, Jeremy  43-C Lakeview Apts. Madison        WI  53704   USA
1007    Ahmadi, Hafez      52 Rue Marston      Paris              75019   France
1008    Jacobson, Becky    1 Lincoln St.       Tallahassee    FL  32312   USA
1009    An, Ing            95 Willow Dr.       Toronto        ON  M5J 2T3 Canada
1010    Slater, Emily      1009 Cherry St.     York           PA  17407   USA
;
proc print data=mail_list (obs=10);
   title 'Magazine Master Mailing List';
run; 

/* This code is shown in Chapter 19 on page 297                      */
/* Copy the following data to an external file.                      */ 
1002    Dix-Rosen, Martin
1001                                                              27516
1006                       932 Webster St.
1009                       2540 Pleasant St.   Calgary        AB  T2P 4H2
1011    Mitchell, Wayne    28 Morningside Dr.  New York       NY  10017   USA
1002                       P.O. Box 1850       Seattle        WA  98101   USA
1012    Stavros, Gloria    212 Northampton Rd. South Hadley   MA  01075   USA
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

options pagesize=60 linesize=80 pageno=1 nodate;
data mail_trans;
   infile 'your-input-file' missover;
   input SubscriberId 1-8 Name $ 9-27 StreetAddress $ 28-47 City $ 48-62
         StateProv $ 63-64 PostalCode $ 67-73 Country $ 75-80;
run;

proc sort data=mail_trans;
   by SubscriberId;
run;

proc print data=mail_trans;
   title 'Magazine Mailing List Changes';
   title2 '(for current month)';
run;

/* This code is shown in Chapter 19 on page 298.                     */
/* The SAS data sets MAIL_LIST and MAIL_TRANS were                   */
/* created earlier in Chapter 19 on pages 295 & 296, and 297,        */
/* respectively.                                                     */

options pagesize=60 linesize=80 pageno=1 nodate;
data mail_newlist;
   update mail_list mail_trans;
   by SubscriberId;
run;

proc print data=mail_newlist;
   title 'Magazine Mailing List';
   title2 '(updated for current month)';
run;

/* This code is shown in Chapter 19 on page 300.                     */

options pagesize=60 linesize=80 pageno=1 nodate;
data year_sales;
   input Title $ 1-25 Author $ 27-50 Sales;
   datalines;
The Milagro Beanfield War Nichols, John            303
The Stranger              Camus, Albert            150
Always Coming Home        LeGuin, Ursula            79
Falling through Space     Gilchrist, Ellen         128
Don Quixote               Cervantes, Miguel de      87
The Handmaid's Tale       Atwood, Margaret          64
;

proc sort data=year_sales;
   by title;
run;

proc print data=year_sales (obs=6);
   title 'Bookstore Sales, Year-to-Date';
   title2 'By Title';
run;

/* This code is shown in Chapter 19 on pages 300 and 301.            */

options pagesize=60 linesize=80 pageno=1 nodate;
data week_sales;
   input Title $ 1-25 Author $ 27-50 Sales;
   datalines;
The Milagro Beanfield War Nichols, John            32
The Stranger              Camus, Albert            17
Always Coming Home        LeGuin, Ursula           10
Falling through Space     Gilchrist, Ellen         12
The Accidental Tourist    Tyler, Anne              15
The Handmaid's Tale       Atwood, Margaret         8
;
proc sort data=week_sales;
   by title;
run;

proc print data=week_sales;
   title 'Bookstore Sales for Current Week';
   title2 'By Title';
run;

/* This code is shown in Chapter 19 on page 301.                     */
/* The SAS data sets YEAR_SALES and WEEK_SALES were created          */
/* in Chapter 19 on pages 300, and 300 & 301, respectively.          */

options pagesize=60 linesize=80 pageno=1 nodate;
data total_sales;
   drop NewSales;
   update year_sales week_sales (rename=(Sales=NewSales)); 
   by Title;
   sales=sum(Sales,NewSales);
run;

proc print data=total_sales;
   title 'Updated Year-to-Date Sales';
run; 

/* This code is shown in Chapter 19 on page 303.                     */
/* The SAS data sets MAIL_LIST and MAIL_TRANS were                   */
/* created earlier in Chapter 19 on pages 295 & 296, and 297,        */
/* respectively.                                                     */

options pagesize=60 linesize=80 pageno=1 nodate;
data mail_merged;
   merge mail_list mail_trans;
   by SubscriberId;
run;

proc print data=mail_merged;
   title 'Magazine Mailing List';
run;

/* This code is shown in Chapter 19 on page 306.                     */

options pagesize=60 linesize=80 pageno=1 nodate;
data inventory;
   input PartNumber $ Description $ InStock @17 
         ReceivedDate date9. @27 Price;
   format  ReceivedDate date9.;
datalines;
K89R seal   34  27jul1998 245.00
M4J7 sander 98  20jun1998 45.88
LK43 filter 121 19may1999 10.99
MN21 brace 43   10aug1999 27.87
BC85 clamp 80   16aug1999 9.55
NCF3 valve 198  20mar1999 24.50
KJ66 cutter 6   18jun1999 19.77
UYN7 rod  211   09sep1999 11.55
JD03 switch 383 09jan2000 13.99
BV1E timer 26   03aug2000 34.50
;

proc print data=inventory;
   title 'Tool Warehouse Inventory';
run;

/* This code is shown in Chapter 19 on page 306.                     */

data add_inventory_4;
   input PartNumber $ 1-4 NewStock 6-8;
   datalines;
BC85 57
NCF3 
KJ66 2
MN21 
UYN7 108
JD03 55
;

/* This code is shown in Chapter 19 on page 307.                     */
/* The SAS data set ADD_INVENTORY_4 was created earlier              */
/* in Chapter 19 on page 306, and the SAS data                       */
/* set INVENTORY is created in Chapter 20 on page 310.               */

options pagesize=60 linesize=80 pageno=1 nodate;
data inventory;
   update inventory add_inventory_4 updatemode=nomissingcheck;
   by PartNumber;
   ReceivedDate=today();
   InStock=InStock+NewStock;
run;

proc print data=inventory;
   title 'Tool Warehouse Inventory';
run;

/*********************************************************************/
/* Examples for Chapter 20 Begin Here                                */
/* This code is shown in Chapter 20 on page 310.                     */

options pagesize=60 linesize=80 pageno=1 nodate;
data inventory;
   input PartNumber $ Description $ InStock @17 
         ReceivedDate date9. @27 Price;
   format ReceivedDate date9.;
   datalines;
K89R seal   34  27jul1998 245.00
M4J7 sander 98  20jun1998 45.88
LK43 filter 121 19may1999 10.99
MN21 brace 43   10aug1999 27.87
BC85 clamp 80   16aug1999 9.55
NCF3 valve 198  20mar1999 24.50
KJ66 cutter 6   18jun1999 19.77
UYN7 rod  211   09sep1999 11.55
JD03 switch 383 09jan2000 13.99
BV1E timer 26   03aug2000 34.50
;

proc print data=inventory;
   title 'Tool Warehouse Inventory';
run;

/* This code is shown in Chapter 20 on page 311.                     */
/* The SAS data set INVENTORY was created earlier                    */
/* in Chapter 20 on page 310.                                        */

options pagesize=60 linesize=80 pageno=1 nodate;
data inventory;
   modify inventory;
   price=price+(price*.15);
run;

proc print data=inventory;
   title 'Tool Warehouse Inventory';
   title2 '(Price reflects 15% increase)';
   format price 8.2;
run;

/* This code is shown in Chapter 20 on pages 313 and 314.            */
/* The SAS data set INVENTORY was created earlier                    */
/* in Chapter 20 on page 310.                                        */

options pagesize=60 linesize=80 pageno=1 nodate;
data add_inventory;
   input PartNumber $ Description $ NewStock @16 NewPrice;
   datalines;
K89R seal   6  247.50 
AA11 hammer 55 32.26 
BB22 wrench 21 17.35  
KJ66 cutter 10 24.50  
CC33 socket 7  22.19   
BV1E timer 30  36.50
;

options pagesize=60 linesize=80 pageno=1 nodate;

data inventory;
   modify inventory add_inventory;
   by PartNumber;
   select (_iorc_);
      /* The observation exists in the master data set. */
      when (%sysrc(_sok)) do; 
         InStock=InStock+NewStock;
         ReceivedDate=today();
         Price=NewPrice;
         <emph>replace;
      end;
      /* The observation does not exist in the master data set. */
      <when (%sysrc(_dsenmr)) do; 
         InStock=NewStock;
         ReceivedDate=today();
         Price=NewPrice;
         output;;
         _error_=0;
      end;
     otherwise do;
           put 'An unexpected I/O error has occurred.'
             'Check your data and your program.';
         _error_=0;
         stop;
      end; 
   end; 
 
proc print data=inventory;
   title 'Tool Warehouse Inventory';
run;

/* This code is shown in Chapter 20 on pages 316 and 317.            */

options pagesize=60 linesize=80 pageno=1 nodate;
data inventory_2;
   input PartNumber $ Description $ InStock @17 
         ReceivedDate date9. @27 Price;
   format  ReceivedDate date9.;
   datalines;
K89R seal   34  27jul1998 245.00
M4J7 sander 98  20jun1998 45.88
M4J7 sander 98  20jun1998 45.88
LK43 filter 121 19may1999 10.99
MN21 brace 43   10aug1999 27.87
M4J7 sander 98  20jun1998 45.88
BC85 clamp 80   16aug1999 9.55
NCF3 valve 198  20mar1999 24.50
KJ66 cutter 6   18jun1999 19.77
;

data add_inventory_2;
   input PartNumber $ Description $ NewStock;
   datalines;
K89R abc 17
M4J7 def 72
M4J7 ghi 66
LK43 jkl 311 
M4J7 mno 43
BC85 pqr 75
;

data inventory_2;
   modify inventory_2 add_inventory_2;
   by PartNumber;
   ReceivedDate=today(); 
   InStock=InStock+NewStock; 
run;

proc print data=inventory_2;
   title "Tool Warehouse Inventory";
run;

/* This code is shown in Chapter 20 on pages 317 and 318.            */

options pagesize=60 linesize=80 pageno=1 nodate;
data Event_List;
   input Event $ 1-10 Weekday $ 12-20 TimeofDay $ 22-30 Fee Code; 
   datalines;
Basketball Monday    evening   10 58
Soccer     Tuesday   morning   5  33
Yoga       Wednesday afternoon 15 92
Swimming   Wednesday morning   10 63
;

data Event_Change;
   input Event $ 1-10 Weekday $ 12-20 Fee Code;
   datalines;
Basketball Wednesday 10 .
Yoga       Monday    . 63
Swimming             .  .
;

options pagesize=60 linesize=80 pageno=1 nodate;

data Event_List;
    modify Event_List Event_Change updatemode=nomissingcheck; 
    by Event;
 run;

proc print data=Event_List;
   title 'Schedule of Athletic Events';
run;

/*********************************************************************/
/* Examples for Chapter 21 Begin Here                                */
/* This code is shown in Chapter 21 on pages 322 and 323.            */

data southamerican;
   title "South American World Cup Finalists from 1954 to 1998";
   input  Year $  Country $ 9-23 Score $ 25-28 Result $ 32-36;
   datalines;
1998    Brazil          0-3    lost
1994    Brazil          3-2    won
1990    Argentina       0-1    lost
1986    Argentina       3-2    won
1978    Argentina       3-1    won 
1970    Brazil          4-1    won
1962    Brazil          3-1    won
1958    Brazil          5-2    won
;

data european;
   title "European World Cup Finalists From 1954 to 1998";
   input  Year $  Country $ 9-23 Score $ 25-28 Result $ 32-36;
   datalines;
1998    France          3-0    won
1994    Italy           2-3    lost
1990    West Germany    1-0    won
1986    West Germany    2-3    lost
1982    Italy           3-1    won
1982    West Germany    1-3    lost
1978    Holland         1-2    lost
1974    West Germany    2-1    won
1974    Holland         1-2    lost
1970    Italy           1-4    lost
1966    England         4-2    won
1966    West Germany    2-4    lost
1962    Czechoslovakia  1-3    lost
1958    Sweden          2-5    lost
1954    West Germany    3-2    won
1954    Hungary         2-3    lost
;

options pagesize=60 linesize=80 pageno=1 nodate;

proc sort data=southamerican;
   by year;
   run;

proc print data=southamerican;
   title 'World Cup Finalists:';
   title2 'South American Countries';
   title3 'from 1954 to 1998';
run;

proc sort data=european;
   by year;
run;

proc print data=european;
   title 'World Cup Finalists:';
   title2 'European Countries';
   title3 'from 1954 to 1998';
run;

/* This code is shown in Chapter 21 on page 325.                     */
/* The SAS data sets SOUTHAMERICAN and EUROPEAN                      */
/* were created earlier in Chapter 21 on page 322.                   */

options pagesize=60 linesize=80 pageno=1 nodate;

data finalists;
   set southamerican european;
   by year;
run;

proc print data=finalists;
   title 'World Cup Finalists';
   title2 'from 1958 to 1998';
run;

/* This code is shown in Chapter 21 on pages 325 and 326.            */
/* The SAS data sets SOUTHAMERICAN and EUROPEAN                      */
/* were created earlier in Chapter 21 on page 322.                   */

options pagesize=60 linesize=80 pageno=1 nodate;  
data finalists;    
   set southamerican (in=S) european;
   by Year;
   if S then Continent='South America';
   else Continent='Europe';
run;

proc print data=finalists;
   title 'World Cup Finalists';
   title2 'from 1954 to 1998';
run;

/* This code is shown in Chapter 21 on page 327.                     */
/* The SAS data sets SOUTHAMERICAN and EUROPEAN                      */
/* were created earlier in Chapter 21 on page 322.                   */

options pagesize=60 linesize=80 pageno=1 nodate;  
data champions(drop=result);
   set southamerican (in=S) european;
   by Year;
   if result='won';
   if S then Continent='South America';
   else Continent='Europe';
run;

proc print data=champions;
   title 'World Cup Champions from 1954 to 1998';
   title2 'including Countries'' Continent';
run;

/* This code is shown in Chapter 21 starting on pages 328 and 329.   */
/* The SAS data sets SOUTHAMERICAN and EUROPEAN                      */
/* were created earlier in Chapter 21 on page 322.                   */

options pagesize=60 linesize=80 pageno=1 nodate;  
data timespan (keep=YearsSouthAmerican keep=YearsEuropean);
   set southamerican (in=S) european  end=LastYear;
   by Year;
   if result='won' then     
      do;
         if S then SouthAmericanWins+1;
         else EuropeanWins+1;
      end;
   if lastyear then
      do;
         YearsSouthAmerican=SouthAmericanWins*4;
         YearsEuropean=EuropeanWins*4;
         output;
      end;

proc print data=timespan;
   title 'Total Years as Reigning World Cup Champions';
   title2 'from 1954 to 1998';
run;

/*********************************************************************/
/* Examples for Chapter 22 Begin Here                                */
/* This code is shown in Chapter 22 on page 337.                     */
/* Run the following DATA Step to create the SAT_SCORES data set.    */
data sat_scores;
   input Test $ Gender $ Year SATscore @@;
   datalines;
Verbal m 1972 531  Verbal f 1972 529
Verbal m 1973 523  Verbal f 1973 521
Verbal m 1974 524  Verbal f 1974 520
Verbal m 1975 515  Verbal f 1975 509
Verbal m 1976 511  Verbal f 1976 508
Verbal m 1977 509  Verbal f 1977 505
Verbal m 1978 511  Verbal f 1978 503
Verbal m 1979 509  Verbal f 1979 501
Verbal m 1980 506  Verbal f 1980 498
Verbal m 1981 508  Verbal f 1981 496
Verbal m 1982 509  Verbal f 1982 499
Verbal m 1983 508  Verbal f 1983 498
Verbal m 1984 511  Verbal f 1984 498
Verbal m 1985 514  Verbal f 1985 503
Verbal m 1986 515  Verbal f 1986 504
Verbal m 1987 512  Verbal f 1987 502
Verbal m 1988 512  Verbal f 1988 499
Verbal m 1989 510  Verbal f 1989 498
Verbal m 1990 505  Verbal f 1990 496
Verbal m 1991 503  Verbal f 1991 495
Verbal m 1992 504  Verbal f 1992 496
Verbal m 1993 504  Verbal f 1993 497
Verbal m 1994 501  Verbal f 1994 497
Verbal m 1995 505  Verbal f 1995 502
Verbal m 1996 507  Verbal f 1996 503
Verbal m 1997 507  Verbal f 1997 503
Verbal m 1998 509  Verbal f 1998 502
Math   m 1972 527  Math   f 1972 489
Math   m 1973 525  Math   f 1973 489
Math   m 1974 524  Math   f 1974 488
Math   m 1975 518  Math   f 1975 479
Math   m 1976 520  Math   f 1976 475
Math   m 1977 520  Math   f 1977 474
Math   m 1978 517  Math   f 1978 474
Math   m 1979 516  Math   f 1979 473
Math   m 1980 515  Math   f 1980 473
Math   m 1981 516  Math   f 1981 473
Math   m 1982 516  Math   f 1982 473
Math   m 1983 516  Math   f 1983 474
Math   m 1984 518  Math   f 1984 478
Math   m 1985 522  Math   f 1985 480
Math   m 1986 523  Math   f 1986 479
Math   m 1987 523  Math   f 1987 481
Math   m 1988 521  Math   f 1988 483
Math   m 1989 523  Math   f 1989 482
Math   m 1990 521  Math   f 1990 483
Math   m 1991 520  Math   f 1991 482
Math   m 1992 521  Math   f 1992 484
Math   m 1993 524  Math   f 1993 484
Math   m 1994 523  Math   f 1994 487
Math   m 1995 525  Math   f 1995 490
Math   m 1996 527  Math   f 1996 492
Math   m 1997 530  Math   f 1997 494
Math   m 1998 531  Math   f 1998 496
;
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */

libname out 'your-data-library';

data _null_;
   set out.sat_scores;
   if SATscore >= 500 then put test gender year;
run;

/* This code is shown in Chapter 22 on page 338.                     */
/* Copy the following data to an external file.                      */ 
Verbal m 1972 531  Verbal f 1972 529
Verbal m 1973 523  Verbal f 1973 521
Verbal m 1974 524  Verbal f 1974 520
Verbal m 1975 515  Verbal f 1975 509
Verbal m 1976 511  Verbal f 1976 508
Verbal m 1977 509  Verbal f 1977 505
Verbal m 1978 511  Verbal f 1978 503
Verbal m 1979 509  Verbal f 1979 501
Verbal m 1980 506  Verbal f 1980 498
Verbal m 1981 508  Verbal f 1981 496
Verbal m 1982 509  Verbal f 1982 499
Verbal m 1983 508  Verbal f 1983 498
Verbal m 1984 511  Verbal f 1984 498
Verbal m 1985 514  Verbal f 1985 503
Verbal m 1986 515  Verbal f 1986 504
Verbal m 1987 512  Verbal f 1987 502
Verbal m 1988 512  Verbal f 1988 499
Verbal m 1989 510  Verbal f 1989 498
Verbal m 1990 505  Verbal f 1990 496
Verbal m 1991 503  Verbal f 1991 495
Verbal m 1992 504  Verbal f 1992 496
Verbal m 1993 504  Verbal f 1993 497
Verbal m 1994 501  Verbal f 1994 497
Verbal m 1995 505  Verbal f 1995 502
Verbal m 1996 507  Verbal f 1996 503
Verbal m 1997 507  Verbal f 1997 503
Verbal m 1998 509  Verbal f 1998 502
Math   m 1972 527  Math   f 1972 489
Math   m 1973 525  Math   f 1973 489
Math   m 1974 524  Math   f 1974 488
Math   m 1975 518  Math   f 1975 479
Math   m 1976 520  Math   f 1976 475
Math   m 1977 520  Math   f 1977 474
Math   m 1978 517  Math   f 1978 474
Math   m 1979 516  Math   f 1979 473
Math   m 1980 515  Math   f 1980 473
Math   m 1981 516  Math   f 1981 473
Math   m 1982 516  Math   f 1982 473
Math   m 1983 516  Math   f 1983 474
Math   m 1984 518  Math   f 1984 478
Math   m 1985 522  Math   f 1985 480
Math   m 1986 523  Math   f 1986 479
Math   m 1987 523  Math   f 1987 481
Math   m 1988 521  Math   f 1988 483
Math   m 1989 523  Math   f 1989 482
Math   m 1990 521  Math   f 1990 483
Math   m 1991 520  Math   f 1991 482
Math   m 1992 521  Math   f 1992 484
Math   m 1993 524  Math   f 1993 484
Math   m 1994 523  Math   f 1994 487
Math   m 1995 525  Math   f 1995 490
Math   m 1996 527  Math   f 1996 492
Math   m 1997 530  Math   f 1997 494
Math   m 1998 531  Math   f 1998 496
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

data out.sat_scores3;
   infile 'your-input-file';
   input test $ gender $ year SATscore @@;
   if SATscore < 500 then delete;
   else list;
run;

/* This code is shown in Chapter 22 on page 341.                     */
/* Copy the following data to an external file.                      */ 
Verbal m 1972 531  Verbal f 1972 529
Verbal m 1973 523  Verbal f 1973 521
Verbal m 1974 524  Verbal f 1974 520
Verbal m 1975 515  Verbal f 1975 509
Verbal m 1976 511  Verbal f 1976 508
Verbal m 1977 509  Verbal f 1977 505
Verbal m 1978 511  Verbal f 1978 503
Verbal m 1979 509  Verbal f 1979 501
Verbal m 1980 506  Verbal f 1980 498
Verbal m 1981 508  Verbal f 1981 496
Verbal m 1982 509  Verbal f 1982 499
Verbal m 1983 508  Verbal f 1983 498
Verbal m 1984 511  Verbal f 1984 498
Verbal m 1985 514  Verbal f 1985 503
Verbal m 1986 515  Verbal f 1986 504
Verbal m 1987 512  Verbal f 1987 502
Verbal m 1988 512  Verbal f 1988 499
Verbal m 1989 510  Verbal f 1989 498
Verbal m 1990 505  Verbal f 1990 496
Verbal m 1991 503  Verbal f 1991 495
Verbal m 1992 504  Verbal f 1992 496
Verbal m 1993 504  Verbal f 1993 497
Verbal m 1994 501  Verbal f 1994 497
Verbal m 1995 505  Verbal f 1995 502
Verbal m 1996 507  Verbal f 1996 503
Verbal m 1997 507  Verbal f 1997 503
Verbal m 1998 509  Verbal f 1998 502
Math   m 1972 527  Math   f 1972 489
Math   m 1973 525  Math   f 1973 489
Math   m 1974 524  Math   f 1974 488
Math   m 1975 518  Math   f 1975 479
Math   m 1976 520  Math   f 1976 475
Math   m 1977 520  Math   f 1977 474
Math   m 1978 517  Math   f 1978 474
Math   m 1979 516  Math   f 1979 473
Math   m 1980 515  Math   f 1980 473
Math   m 1981 516  Math   f 1981 473
Math   m 1982 516  Math   f 1982 473
Math   m 1983 516  Math   f 1983 474
Math   m 1984 518  Math   f 1984 478
Math   m 1985 522  Math   f 1985 480
Math   m 1986 523  Math   f 1986 479
Math   m 1987 523  Math   f 1987 481
Math   m 1988 521  Math   f 1988 483
Math   m 1989 523  Math   f 1989 482
Math   m 1990 521  Math   f 1990 483
Math   m 1991 520  Math   f 1991 482
Math   m 1992 521  Math   f 1992 484
Math   m 1993 524  Math   f 1993 484
Math   m 1994 523  Math   f 1994 487
Math   m 1995 525  Math   f 1995 490
Math   m 1996 527  Math   f 1996 492
Math   m 1997 530  Math   f 1997 494
Math   m 1998 531  Math   f 1998 496 
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

libname out 'your-data-library';
options nosource nonotes errors=0;

data out.sats5; 
   infile 'your-input-file';
   input test $ gender year SATscore 25-27;
run;

proc print;
   by test;
run;

/*********************************************************************/
/* Examples for Chapter 23 Begin Here                                */
/* This code is shown in Chapter 23 on page 348.                     */

options pagesize=60 linesize=80 pageno=1 nodate;
data sat_scores;
   input Test $ Gender $ Year SATscore @@;    
   datalines;
Verbal m 1972 531  Verbal f 1972 529 
Verbal m 1974 524  Verbal f 1974 520 
Verbal m 1976 511  Verbal f 1976 508 
Verbal m 1978 511  Verbal f 1978 503 
Verbal m 1980 506  Verbal f 1980 498 
Verbal m 1982 509  Verbal f 1982 499 
Verbal m 1984 511  Verbal f 1984 498 
Verbal m 1986 515  Verbal f 1986 504 
Verbal m 1988 512  Verbal f 1988 499 
Verbal m 1990 505  Verbal f 1990 496 
Verbal m 1992 504  Verbal f 1992 496 
Verbal m 1994 501  Verbal f 1994 497 
Verbal m 1996 507  Verbal f 1996 503 
Verbal m 1998 509  Verbal f 1998 502 
Math   m 1973 525  Math   f 1973 489 
Math   m 1975 518  Math   f 1975 479 
Math   m 1977 520  Math   f 1977 474 
Math   m 1979 516  Math   f 1979 473 
Math   m 1981 516  Math   f 1981 473 
Math   m 1983 516  Math   f 1983 474 
Math   m 1985 522  Math   f 1985 480 
Math   m 1987 523  Math   f 1987 481 
Math   m 1989 523  Math   f 1989 482 
Math   m 1991 520  Math   f 1991 482 
Math   m 1993 524  Math   f 1993 484 
Math   m 1995 525  Math   f 1995 490 
Math   m 1997 530  Math   f 1997 494 
Verbal m 1973 523  Verbal f 1973 521
Verbal m 1975 515  Verbal f 1975 509
Verbal m 1977 509  Verbal f 1977 505
Verbal m 1979 509  Verbal f 1979 501
Verbal m 1981 508  Verbal f 1981 496
Verbal m 1983 508  Verbal f 1983 498
Verbal m 1985 514  Verbal f 1985 503
Verbal m 1987 512  Verbal f 1987 502
Verbal m 1989 510  Verbal f 1989 498
Verbal m 1991 503  Verbal f 1991 495
Verbal m 1993 504  Verbal f 1993 497
Verbal m 1995 505  Verbal f 1995 502
Verbal m 1997 507  Verbal f 1997 503
Math   m 1972 527  Math   f 1972 489
Math   m 1974 524  Math   f 1974 488
Math   m 1976 520  Math   f 1976 475
Math   m 1978 517  Math   f 1978 474
Math   m 1980 515  Math   f 1980 473
Math   m 1982 516  Math   f 1982 473
Math   m 1984 518  Math   f 1984 478
Math   m 1986 523  Math   f 1986 479
Math   m 1988 521  Math   f 1988 483
Math   m 1990 521  Math   f 1990 483
Math   m 1992 521  Math   f 1992 484
Math   m 1994 523  Math   f 1994 487
Math   m 1996 527  Math   f 1996 492
Math   m 1998 531  Math   f 1998 496
;

/* This code is shown in Chapter 23 on page 349.                     */
/* Note that in the PRINTTO statement you must supply the name of    */
/* your alternate output file.                                       */
/* The SAS data set SAT_SCORES was created earlier in                */
/* Chapter 23 on page 348.                                           */

options pagesize=60 linesize=80 pageno=1 nodate;
proc printto print='alternate-output-file' new;
run;

proc print data=sat_scores;
   title 'Mean SAT Scores for Entering University Classes';
run;

proc printto;
run;

/*********************************************************************/
/* Examples for Chapter 25 Begin Here                                */
/* This code is shown in Chapter 25 on page 369.                     */
/* Run the following DATA Step to create the YEAR_SALES data set.    */
data year_sales;
   input Month $ Quarter $ SalesRep $14. Type $ Units Price @@;
   AmountSold=Units*price;
   datalines;
01 1 Hollingsworth Deluxe    260 49.50                                                            
01 1 Hollingsworth Standard  330 30.97                                                            
01 1 Garcia        Deluxe    715 49.50                                                            
02 1 Garcia        Standard 2045 30.97                                                            
02 1 Garcia        Standard   40 30.97                                                            
02 1 Jensen        Standard  153 30.97                                                            
03 1 Hollingsworth Standard  125 30.97                                                            
03 1 Garcia        Standard  118 30.97                                                            
03 1 Jensen        Standard  525 30.97                                                            
04 2 Garcia        Standard  150 30.97                                                            
04 2 Hollingsworth Standard  530 30.97                                                            
04 2 Garcia        Standard 1715 30.97                                                            
05 2 Jensen        Standard   45 30.97                                                            
05 2 Garcia        Standard   40 30.97                                                            
05 2 Jensen        Standard  153 30.97                                                            
06 2 Jensen        Standard  154 30.97                                                            
06 2 Jensen        Standard  276 30.97                                                            
06 2 Garcia        Standard  512 30.97                                                            
07 3 Garcia        Standard  250 30.97                                                            
07 3 Garcia        Standard   90 30.97                                                            
07 3 Jensen        Standard  110 30.97                                                            
07 3 Hollingsworth Standard  130 30.97                                                            
07 3 Garcia        Standard  265 30.97                                                            
07 3 Garcia        Standard 1250 30.97                                                            
07 3 Garcia        Standard   90 30.97                                                            
07 3 Garcia        Standard   90 30.97                                                            
07 3 Jensen        Standard  110 30.97                                                            
07 3 Jensen        Standard  675 30.97                                                            
08 3 Garcia        Deluxe    110 49.50                                                            
08 3 Hollingsworth Standard  230 30.97                                                            
08 3 Garcia        Standard  240 30.97                                                            
08 3 Jensen        Standard  453 30.97                                                            
08 3 Hollingsworth Standard  290 30.97                                                            
08 3 Jensen        Deluxe     45 49.50                                                            
08 3 Garcia        Deluxe    110 49.50                                                            
08 3 Garcia        Standard  240 30.97                                                            
08 3 Jensen        Standard  453 30.97                                                            
08 3 Jensen        Deluxe    225 49.50                                                            
09 3 Jensen        Standard  254 30.97                                                            
09 3 Hollingsworth Standard 1000 30.97                                                            
09 3 Garcia        Standard  412 30.97                                                            
09 3 Garcia        Standard  100 30.97                                                            
09 3 Hollingsworth Standard  125 30.97                                                            
09 3 Garcia        Standard 1118 30.97                                                            
09 3 Jensen        Standard  284 30.97                                                            
09 3 Jensen        Deluxe    275 49.50                                                            
09 3 Jensen        Standard  876 30.97                                                            
10 4 Hollingsworth Standard  530 30.97                                                            
10 4 Hollingsworth Standard  265 30.97                                                            
10 4 Garcia        Standard  365 30.97                                                            
11 4 Jensen        Standard  453 30.97                                                            
11 4 Jensen        Standard   70 30.97                                                            
11 4 Hollingsworth Deluxe    150 49.50                                                            
12 4 Jensen        Standard  876 30.97                                                            
12 4 Jensen        Standard 1254 30.97  
01 1 Garcia        Standard   41 30.97 
01 1 Jensen        Standard  110 30.97 
01 1 Jensen        Standard  675 30.97 
02 1 Garcia        Deluxe     10 49.50 
02 1 Hollingsworth Standard 1030 30.97 
02 1 Garcia        Standard   98 30.97 
03 1 Jensen        Standard  154 30.97 
03 1 Hollingsworth Standard   25 30.97 
03 1 Garcia        Standard  310 30.97 
04 2 Hollingsworth Standard  260 30.97 
04 2 Jensen        Standard 1110 30.97 
04 2 Jensen        Standard  675 30.97 
05 2 Hollingsworth Standard 1120 30.97 
05 2 Hollingsworth Standard 1030 30.97 
05 2 Garcia        Standard   98 30.97 
06 2 Hollingsworth Deluxe     25 49.50 
06 2 Hollingsworth Standard  125 30.97 
06 2 Garcia        Standard 1000 30.97 
07 3 Hollingsworth Deluxe     60 49.50 
07 3 Hollingsworth Deluxe     30 49.50 
07 3 Garcia        Standard   90 30.97 
07 3 Jensen        Standard  110 30.97 
07 3 Jensen        Standard  275 30.97 
07 3 Hollingsworth Deluxe     60 49.50 
07 3 Jensen        Standard  110 30.97 
07 3 Hollingsworth Standard  330 30.97 
07 3 Garcia        Standard  465 30.97 
08 3 Jensen        Standard  145 30.97 
08 3 Hollingsworth Standard  120 30.97 
08 3 Jensen        Standard  453 30.97 
08 3 Hollingsworth Standard  230 49.50 
08 3 Garcia        Standard  198 30.97 
08 3 Garcia        Standard 1198 30.97 
08 3 Jensen        Standard  145 30.97 
08 3 Hollingsworth Standard  330 30.97 
08 3 Hollingsworth Deluxe     50 49.50 
08 3 Garcia        Standard  198 30.97 
09 3 Hollingsworth Standard  125 30.97 
09 3 Garcia        Standard  118 30.97 
09 3 Jensen        Standard  284 30.97 
09 3 Jensen        Deluxe    275 49.50 
09 3 Jensen        Standard  876 30.97 
09 3 Jensen        Standard  254 30.97 
09 3 Hollingsworth Standard  175 30.97 
09 3 Garcia        Standard  412 30.97 
09 3 Garcia        Standard  100 30.97 
10 4 Garcia        Standard  250 30.97 
10 4 Jensen        Standard  975 30.97 
10 4 Jensen        Standard   55 30.97 
11 4 Hollingsworth Standard 1230 30.97 
11 4 Garcia        Standard  198 30.97 
11 4 Garcia        Standard  120 30.97 
12 4 Garcia        Standard 1000 30.97 
12 4 Hollingsworth Deluxe    125 49.50 
12 4 Hollingsworth Standard  175 30.97   
;
 
/* This code is shown in Chapter 25 on page 369.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */ 
/* Run the following DATA Step to create the QTR01 data set.         */
data qtr01;
   set year_sales;
   if Quarter = '1';
run;
 
options linesize=80 pageno=1 nodate;

proc print data=qtr01;                                                 
  title 'TruBlend Coffee Makers Quarterly Sales Report';
run;

/* This code is shown in Chapter 25 on page 370.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */ 
/* Run the following DATA Step to create the QTR01 data set.         */
data qtr01;
   set year_sales;
   if Quarter = '1';
run;

options linesize=80 pageno=1 nodate;

proc print data=qtr01 obs='Observation Number';
   title 'TruBlend Coffee Makers Quarterly Sales Report';
run;

/* This code is shown in Chapter 25 on page 371.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */ 
/* Run the following DATA Step to create the QTR01 data set.         */
data qtr01;
   set year_sales;
   if Quarter = '1';
run;

options linesize=80 pageno=1 nodate;

proc print data=qtr01 noobs;
   title 'TruBlend Coffee Makers Quarterly Sales Report';
run;

/* This code is shown in Chapter 25 on page 372.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */ 
/* Run the following DATA Step to create the QTR01 data set.         */
data qtr01;
   set year_sales;
   if Quarter = '1';
run;

options linesize=80 pageno=1 nodate;

proc print data=qtr01;
   id SalesRep;
   title 'TruBlend Coffee Makers Quarterly Sales Report';
run;

/* This code is shown in Chapter 25 on page 373.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */ 
/* Run the following DATA Step to create the QTR01 data set.         */
data qtr01;
   set year_sales;
   if Quarter = '1';
run;

options linesize=80 pageno=1 nodate;

proc print data=qtr01;
   by SalesRep;
   title 'TruBlend Coffee Makers Quarterly Sales Report';
run;

proc print data=qtr01;
   id SalesRep;
   title 'TruBlend Coffee Makers Quarterly Sales Report';
run;

/* This code is shown in Chapter 25 on page 374.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */ 
/* Run the following DATA Step to create the QTR01 data set.         */
data qtr01;
   set year_sales;
   if Quarter = '1';
run;

options linesize=80 pageno=1 nodate;

proc print data=qtr01 noobs;
   var SalesRep Month Units AmountSold;
   title 'TruBlend Coffee Makers Quarterly Sales Report';
run;

/* This code is shown in Chapter 25 on pages 375 and 376.            */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */ 
/* Run the following DATA Step to create the QTR01 data set.         */
data qtr01;
   set year_sales;
   if Quarter = '1';
run;

options linesize=80 pageno=1 nodate;

proc print data=qtr01 noobs;
   var SalesRep Month Units AmountSold;
   where SalesRep='Garcia';
   title 'TruBlend Coffee Makers Quarterly Sales for Garcia';
run;

/* This code is shown in Chapter 25 on page 376.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */

options linesize=80 pageno=1 nodate;

proc print data=year_sales;
   var SalesRep Month Units AmountSold;
   where SalesRep='Garcia' and Month='01';
   title 'TruBlend Coffee Makers Monthly Sales for Garcia';
run;

/* This code is shown in Chapter 25 on page 377.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */ 
/* Run the following DATA Step to create the QTR01 data set.         */
data qtr01;
   set year_sales;
   if Quarter = '1';
run;

options linesize=80 pageno=1 nodate;

proc print data=qtr01 noobs;
   var SalesRep Month Units AmountSold;
   where Units>500 or AmountSold>20000;
   title 'Quarterly Report for Sales above 500 Units or $20,000';
run;

/* This code is shown in Chapter 25 on page 378.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */ 
/* Run the following DATA Step to create the QTR02 data set.         */
data qtr02;
   set year_sales;
   if Quarter = '2';
run;

options linesize=80 pageno=1 nodate;

proc print data=qtr02 noobs;
   var SalesRep Month Units AmountSold;
   where Units>500 or AmountSold>20000;
   format Units comma7. AmountSold dollar14.2;
   title 'Quarterly Report for Sales above 500 Units or $20,000';
run;

/* This code is shown in Chapter 25 on page 379.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */ 
/* Run the following DATA Step to create the QTR02 data set.         */
data qtr02;
   set year_sales;
   if Quarter = '2';
run;

options linesize=80 pageno=1 nodate;

proc print data=qtr02 noobs;
   var SalesRep Month Units AmountSold;
   where Units>500 or AmountSold>20000;
   format Units comma7. AmountSold dollar14.2;
   sum Units AmountSold;
   title 'Quarterly Sales Total for Sales above 500 Units or $20,000';
run;

/* This code is shown in Chapter 25 on page 380.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */ 
/* Run the following DATA Step to create the QTR02 data set.         */
data qtr02;
   set year_sales;
   if Quarter = '2';
run;

options linesize=80 pageno=1 nodate;

proc sort data=qtr02;
   by SalesRep;
run;

proc print data=qtr02 noobs;
   var Month Units AmountSold;
   where Units>500 or AmountSold>20000;
   format Units comma7. AmountSold dollar14.2;
   sum Units AmountSold;
   by SalesRep;
   title1 'Sales Rep Quarterly Totals for Sales Above 500 Units or $20,000'; 
run;

/* This code is shown in Chapter 25 on pages 381 and 382.            */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */ 
/* Run the following DATA Step to create the QTR02 data set.         */
data qtr02;
   set year_sales;
   if Quarter = '2';
run;

options linesize=80 pageno=1 nodate;

proc print data=qtr02;
   var Month Units AmountSold;
   where Units>500 or AmountSold>20000;
   format Units comma7. AmountSold dollar14.2;
   sum Units AmountSold;
   by SalesRep;
   id SalesRep;
   title1 'Sales Rep Quarterly Totals for Sales above 500 Units or $20,000'; 
run;

/* This code is shown in Chapter 25 on pages 382 and 383.            */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */ 
/* Run the following DATA Step to create the QTR02 data set.         */
data qtr02;
   set year_sales;
   if Quarter = '2';
run;

options linesize=80 pageno=1 nodate;

proc sort data=qtr02;
   by SalesRep Month;
run;

proc print data=qtr02 noobs n='Sales Transactions:'
                              'Total Sales Transactions:';
   var Units AmountSold;
   where Units>500 or AmountSold>20000;
   format Units comma7. AmountSold dollar14.2;
   sum Units AmountSold;
   by SalesRep Month;
   title1 'Monthly Sales Rep Totals for Sales above 500 Units or $20,000';
run;

/* This code is shown in Chapter 25 on page 385.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */ 
/* Run the following DATA Step to create the QTR02 data set.         */
data qtr02;
   set year_sales;
   if Quarter = '2';
run;

options linesize=80 pageno=1 nodate;

proc print data=qtr02;
   var Units AmountSold;
   where Units>500 or AmountSold>20000;
   format Units comma7. AmountSold dollar14.2;
   sum Units AmountSold;
   by SalesRep Month;
   id SalesRep Month;
   sumby SalesRep;
   title1 'Sales Rep Quarterly Totals for Sales above 500 Units or $20,000'; 
run;

/* This code is shown in Chapter 25 on page 386.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */ 
/* Run the following DATA Step to create the QTR02 data set.         */
data qtr02;
   set year_sales;
   if Quarter = '2';
run;

options linesize=80 pageno=1 nodate;

proc print data=qtr02 noobs;
   var Units AmountSold;
   where Units>500 or AmountSold>20000;
   format Units comma7. AmountSold dollar14.2;
   sum Units AmountSold;
   by SalesRep Month;
   id SalesRep Month;
   sumby SalesRep;
   pageby SalesRep;
   title1 'Sales Rep Quarterly Totals for Sales above 500 Units or $20,000'; 
run;

/* This code is shown in Chapter 25 on pages 388 and 389.            */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */ 
/* Run the following DATA Step to create the QTR02 data set.         */
data qtr02;
   set year_sales;
   if Quarter = '2';
run;

options linesize=80 pageno=1 nodate;

proc sort data=qtr02;
   by SalesRep; 
run;

proc print data=qtr02 noobs;
   var SalesRep Month Units AmountSold;
   where Month='04';
   format Units comma7. AmountSold dollar14.2;
   sum Units AmountSold;
   title1 'TruBlend Coffee Makers, Inc.';
   title3 'Quarterly Sales Report';
   footnote1 'April Sales Totals';
   footnote2 'COMPANY CONFIDENTIAL INFORMATION';
run;

/* This code is shown in Chapter 25 on page 390.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */ 
/* Run the following DATA Step to create the QTR02 data set.         */
data qtr02;
   set year_sales;
   if Quarter = '2';
run;

options linesize=80 pageno=1 nodate;

proc sort data=qtr02;
   by SalesRep; 
run;

proc print data=qtr02 noobs label;
   var SalesRep Month Units AmountSold;
   where Month='04';
   format Units comma7. AmountSold dollar14.2;
   sum Units AmountSold;
   label SalesRep   = 'Sales Rep.'
         Units      = 'Units Sold'
         AmountSold = 'Amount Sold';
   title 'TruBlend Coffee Maker Sales Report for April';
   footnote;
run;

/* This code is shown in Chapter 25 on page 391.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */ 
/* Run the following DATA Step to create the QTR02 data set.         */
data qtr02;
   set year_sales;
   if Quarter = '2';
run;

options linesize=80 pageno=1 nodate;

proc sort data=qtr02;
   by SalesRep; 
run;

proc print data=qtr02 noobs split='/';
   var SalesRep Month Units AmountSold;
   where Month='04';
   format Units comma7. AmountSold dollar14.2;
   sum Units AmountSold;
   title 'TruBlend Coffee Maker Sales Report for April';
   label SalesRep   = 'Sales/Representative'
         Units      = 'Units/Sold'
         AmountSold = 'Amount/Sold';
run;

/* This code is shown in Chapter 25 on pages 391 and 392.            */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */ 
/* Run the following DATA Step to create the QTR02 data set.         */
data qtr02;
   set year_sales;
   if Quarter = '2';
run;

options linesize=80 pageno=1 nodate;

proc sort data=qtr02;
   by SalesRep; 
run;

proc print data=qtr02 noobs split='/' double;
   var SalesRep Month Units AmountSold;
   where Month='04';
   format Units comma7. AmountSold dollar14.2;
   sum Units AmountSold;
   title 'TruBlend Coffee Maker Sales Report for April';
   label SalesRep   = 'Sales/Representative'
         Units      = 'Units/Sold'
         AmountSold = 'Amount/Sold';
run;

/* This code is shown in Chapter 25 on page 393.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */ 
/* Run the following DATA Step to create the QTR03 data set.         */
data qtr03;
   set year_sales;
   if Quarter = '3';
run;

options pagesize=66 linesize=80 pageno=1 nodate;

proc sort data=qtr03;
   by SalesRep;
run;

proc print data=qtr03 split='/' width=uniform;
   var SalesRep Month Units AmountSold;
   format Units comma7. AmountSold dollar14.2;
   sum Units AmountSold;
   title 'TruBlend Coffee Makers 3rd Quarter Sales Report';
   label SalesRep    = 'Sales/Rep.'
         Units       = 'Units/Sold'
         AmountSold  = 'Amount/Sold';
run;

/* This code is shown in Chapter 25 on page 396.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */ 
/* Run the following DATA Step to create the QTR04 data set.         */
data qtr04;
   set year_sales;
   if Quarter = '4';
run;

options linesize=80 pageno=1 nodate;

proc sort data=qtr04;
   by SalesRep;
run;

proc print data=qtr04 noobs split='/' width=uniform;
   var SalesRep Month Units AmountSold;
   format Units comma7. AmountSold dollar14.2;
   sum Units AmountSold;
   title1 'TruBlend Coffee Maker Quarterly Sales Report';
   title2 "Produced on &amp;SYSDATE9";
   label SalesRep    = 'Sales/Rep.'
         Units       = 'Units/Sold'
         AmountSold  = 'Amount/Sold';
run;

/* This code is shown in Chapter 25 on page 397.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 25 on page 369.                                        */ 
/* Run the following DATA Step to create the QTR04 data set.         */
data qtr04;
   set year_sales;
   if Quarter = '4';
run;

options linesize=80 pageno=1 nodate;

%let Quarter=Fourth;
%let Year=2000;

proc sort data=qtr04;
   by SalesRep;
run;

proc print data=qtr04 noobs split='/' width=uniform;
   var SalesRep Month Units AmountSold;
   format Units comma7. AmountSold dollar14.2;
   sum Units AmountSold;
   title1 'TruBlend Coffee Maker Quarterly Sales Report';
   title2 "Produced on &amp;SYSDATE9";
   title3 "&amp;Quarter Quarter &amp;Year Sales Totals";
   label SalesRep    = 'Sales/Rep.'
         Units       = 'Units/Sold'
         AmountSold  = 'Amount/Sold';
run;

/*********************************************************************/
/* Examples for Chapter 26 Begin Here                                */
/* This code is shown in Chapter 26 on page 409.                     */
/* Run the following DATA Step to create the YEAR_SALES data set.    */
data year_sales;
   input Month $ Quarter $ SalesRep $14. Type $ Units Price @@;
   AmountSold=Units*price;
   datalines;
01 1 Hollingsworth Deluxe    260 49.50                                                            
01 1 Hollingsworth Standard  330 30.97                                                            
01 1 Garcia        Deluxe    715 49.50                                                            
02 1 Garcia        Standard 2045 30.97                                                            
02 1 Garcia        Standard   40 30.97                                                            
02 1 Jensen        Standard  153 30.97                                                            
03 1 Hollingsworth Standard  125 30.97                                                            
03 1 Garcia        Standard  118 30.97                                                            
03 1 Jensen        Standard  525 30.97                                                            
04 2 Garcia        Standard  150 30.97                                                            
04 2 Hollingsworth Standard  530 30.97                                                            
04 2 Garcia        Standard 1715 30.97                                                            
05 2 Jensen        Standard   45 30.97                                                            
05 2 Garcia        Standard   40 30.97                                                            
05 2 Jensen        Standard  153 30.97                                                            
06 2 Jensen        Standard  154 30.97                                                            
06 2 Jensen        Standard  276 30.97                                                            
06 2 Garcia        Standard  512 30.97                                                            
07 3 Garcia        Standard  250 30.97                                                            
07 3 Garcia        Standard   90 30.97                                                            
07 3 Jensen        Standard  110 30.97                                                            
07 3 Hollingsworth Standard  130 30.97                                                            
07 3 Garcia        Standard  265 30.97                                                            
07 3 Garcia        Standard 1250 30.97                                                            
07 3 Garcia        Standard   90 30.97                                                            
07 3 Garcia        Standard   90 30.97                                                            
07 3 Jensen        Standard  110 30.97                                                            
07 3 Jensen        Standard  675 30.97                                                            
08 3 Garcia        Deluxe    110 49.50                                                            
08 3 Hollingsworth Standard  230 30.97                                                            
08 3 Garcia        Standard  240 30.97                                                            
08 3 Jensen        Standard  453 30.97                                                            
08 3 Hollingsworth Standard  290 30.97                                                            
08 3 Jensen        Deluxe     45 49.50                                                            
08 3 Garcia        Deluxe    110 49.50                                                            
08 3 Garcia        Standard  240 30.97                                                            
08 3 Jensen        Standard  453 30.97                                                            
08 3 Jensen        Deluxe    225 49.50                                                            
09 3 Jensen        Standard  254 30.97                                                            
09 3 Hollingsworth Standard 1000 30.97                                                            
09 3 Garcia        Standard  412 30.97                                                            
09 3 Garcia        Standard  100 30.97                                                            
09 3 Hollingsworth Standard  125 30.97                                                            
09 3 Garcia        Standard 1118 30.97                                                            
09 3 Jensen        Standard  284 30.97                                                            
09 3 Jensen        Deluxe    275 49.50                                                            
09 3 Jensen        Standard  876 30.97                                                            
10 4 Hollingsworth Standard  530 30.97                                                            
10 4 Hollingsworth Standard  265 30.97                                                            
10 4 Garcia        Standard  365 30.97                                                            
11 4 Jensen        Standard  453 30.97                                                            
11 4 Jensen        Standard   70 30.97                                                            
11 4 Hollingsworth Deluxe    150 49.50                                                            
12 4 Jensen        Standard  876 30.97                                                            
12 4 Jensen        Standard 1254 30.97  
01 1 Garcia        Standard   41 30.97 
01 1 Jensen        Standard  110 30.97 
01 1 Jensen        Standard  675 30.97 
02 1 Garcia        Deluxe     10 49.50 
02 1 Hollingsworth Standard 1030 30.97 
02 1 Garcia        Standard   98 30.97 
03 1 Jensen        Standard  154 30.97 
03 1 Hollingsworth Standard   25 30.97 
03 1 Garcia        Standard  310 30.97 
04 2 Hollingsworth Standard  260 30.97 
04 2 Jensen        Standard 1110 30.97 
04 2 Jensen        Standard  675 30.97 
05 2 Hollingsworth Standard 1120 30.97 
05 2 Hollingsworth Standard 1030 30.97 
05 2 Garcia        Standard   98 30.97 
06 2 Hollingsworth Deluxe     25 49.50 
06 2 Hollingsworth Standard  125 30.97 
06 2 Garcia        Standard 1000 30.97 
07 3 Hollingsworth Deluxe     60 49.50 
07 3 Hollingsworth Deluxe     30 49.50 
07 3 Garcia        Standard   90 30.97 
07 3 Jensen        Standard  110 30.97 
07 3 Jensen        Standard  275 30.97 
07 3 Hollingsworth Deluxe     60 49.50 
07 3 Jensen        Standard  110 30.97 
07 3 Hollingsworth Standard  330 30.97 
07 3 Garcia        Standard  465 30.97 
08 3 Jensen        Standard  145 30.97 
08 3 Hollingsworth Standard  120 30.97 
08 3 Jensen        Standard  453 30.97 
08 3 Hollingsworth Standard  230 49.50 
08 3 Garcia        Standard  198 30.97 
08 3 Garcia        Standard 1198 30.97 
08 3 Jensen        Standard  145 30.97 
08 3 Hollingsworth Standard  330 30.97 
08 3 Hollingsworth Deluxe     50 49.50 
08 3 Garcia        Standard  198 30.97 
09 3 Hollingsworth Standard  125 30.97 
09 3 Garcia        Standard  118 30.97 
09 3 Jensen        Standard  284 30.97 
09 3 Jensen        Deluxe    275 49.50 
09 3 Jensen        Standard  876 30.97 
09 3 Jensen        Standard  254 30.97 
09 3 Hollingsworth Standard  175 30.97 
09 3 Garcia        Standard  412 30.97 
09 3 Garcia        Standard  100 30.97 
10 4 Garcia        Standard  250 30.97 
10 4 Jensen        Standard  975 30.97 
10 4 Jensen        Standard   55 30.97 
11 4 Hollingsworth Standard 1230 30.97 
11 4 Garcia        Standard  198 30.97 
11 4 Garcia        Standard  120 30.97 
12 4 Garcia        Standard 1000 30.97 
12 4 Hollingsworth Deluxe    125 49.50 
12 4 Hollingsworth Standard  175 30.97   
;

/* This code is shown in Chapter 26 on page 409.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 26 on page 409.                                        */

options linesize=84 pageno=1 nodate;

proc tabulate data=year_sales format=comma10.;
   title1 'TruBlend Coffee Makers, Inc.';
   title2 'Number of Sales by Each Sales Representative';
   class SalesRep;
   table SalesRep;
run;

/* This code is shown in Chapter 26 on page 410.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 26 on page 409.                                        */

options linesize=84 pageno=1 nodate;

proc tabulate data=year_sales format=comma10.;
   title1 'TruBlend Coffee Makers, Inc.';
   title2 'Amount Sold by Each Sales Representative';
   class SalesRep;
   var AmountSold;
   table SalesRep,
         AmountSold;
run;

/* This code is shown in Chapter 26 on page 411.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 26 on page 409.                                        */

options linesize=84 pageno=1 nodate;

proc tabulate data=year_sales format=comma10.;
   title1 'TruBlend Coffee Makers, Inc.';
   title2 'Quarterly Sales by Each Sales Representative';
   class SalesRep Quarter;
   var AmountSold;
   table SalesRep,
         Quarter,
         AmountSold;
run;

/* This code is shown in Chapter 26 on page 413.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 26 on page 409.                                        */

options linesize=84 pageno=1 nodate;

proc tabulate data=year_sales format=comma10.;
   title1 'TruBlend Coffee Makers, Inc.';
   title2 'Sales of Deluxe Model Versus Standard Model';
   class SalesRep Type;
   var AmountSold Units;
   table Type;
   table Type, Units;      
   table SalesRep, Type, AmountSold;
run;

/* This code is shown in Chapter 26 on pages 415 and 416.            */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 26 on page 409.                                        */

options linesize=84 pageno=1 nodate;

proc tabulate data=year_sales format=comma10.;
   title1 'TruBlend Coffee Makers, Inc.';
   title2 'Amount Sold Per Item by Each Sales Representative'; 
   class SalesRep Type;
   var AmountSold;
   table SalesRep*Type,
         AmountSold;
run;

/* This code is shown in Chapter 26 on pages 416 and 417.            */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 26 on page 409.                                        */

options linesize=84 pageno=1 nodate;

proc tabulate data=year_sales format=comma10.;
   title1 'TruBlend Coffee Makers, Inc.';
   title2 'Amount Sold Per Item by Each Sales Representative'; 
   class SalesRep Type;
   var AmountSold;
   table SalesRep*Type,
         AmountSold*f=dollar16.2;
run;

/* This code is shown in Chapter 26 on page 418.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 26 on page 409.                                        */

options linesize=84 pageno=1 nodate;

proc tabulate data=year_sales format=comma10.;
   title1 'TruBlend Coffee Makers, Inc.';
   title2 'Average Amount Sold Per Item by Each Sales Representative';
   class SalesRep Type;
   var AmountSold;
   table SalesRep*Type,
         AmountSold*mean*f=dollar16.2;
run;

/* This code is shown in Chapter 26 on pages 418 and 419.            */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 26 on page 409.                                        */ 

options linesize=84 pageno=1 nodate;

proc tabulate data=year_sales format=comma10.;
   title1 'TruBlend Coffee Makers, Inc.';
   title2 'Sales Summary by Representative and Product';
   class SalesRep Type;
   var AmountSold;
   table SalesRep*Type,
         AmountSold*n AmountSold*f=dollar16.2;
run;
 
/* This code is shown in Chapter 26 on pages 419 and 420.            */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 26 on page 409.                                        */

options linesize=84 pageno=1 nodate;

proc tabulate data=year_sales format=comma10.;
   title1 'TruBlend Coffee Makers, Inc.';
   title2 'Sales Summary by Representative and Product';
   class SalesRep Type;
   var AmountSold;
   table SalesRep*Type,
         AmountSold*(n sum*f=dollar16.2);
run;
                                    
/* This code is shown in Chapter 26 on pages 420 and 421.            */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 26 on page 409.                                        */

options linesize=84 pageno=1 nodate;

proc tabulate data=year_sales format=comma10.;
   title1 'TruBlend Coffee Makers, Inc.';
   title2 'Sales Report';
   class SalesRep Type;
   var AmountSold;
   table SalesRep*Type all,
         AmountSold*(n (mean sum)*f=dollar16.2);
run;

/* This code is shown in Chapter 26 on pages 421 and 422.            */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 26 on page 409.                                        */

options linesize=84 pageno=1 nodate;

proc tabulate data=year_sales format=comma10.;
   title1 'TruBlend Coffee Makers, Inc.';
   title2 'Sales Performance';
   class SalesRep Type;
   var AmountSold;
   table SalesRep='Sales Representative' *
         (Type='Type of Coffee Maker' all) all,
         AmountSold=' '*
         (N='Sales' 
         SUM='Amount'*f=dollar16.2 
         colpctsum='% Sales' 
         mean='Average Sale'*f=dollar16.2);
run;

/* This code is shown in Chapter 26 on page 423.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 26 on page 409.                                        */
/* Note that in the FILE= statements you must supply                 */
/* your file name for the destination of the HTML or Printer output. */

ods html file='summary-table.htm';
ods printer file='summary-table.ps';

proc tabulate data=year_sales format=comma10.;
   title1 'TruBlend Coffee Makers, Inc.';
   title2 'Sales Performance';
   class SalesRep;
   class Type / style=[font_style=italic];
   var AmountSold;
   table SalesRep='Sales Representative'*(Type='Type of Coffee Maker' 
         all*[style=[background=yellow font_weight=bold]]) 
         all*[style=[font_weight=bold]],
         AmountSold=' '*(colpctsum='% Sales' mean='Average Sale'*
         f=dollar16.2);
run;

ods html close;
ods printer close;

/* This code is shown in Chapter 26 on page 426.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 26 on page 409.                                        */

options linesize=84 pageno=1 nodate;

proc tabulate data=year_sales format=comma10. order=freq;
   title1 'TruBlend Coffee Makers, Inc.';
   title2 'Quarterly Sales and Representative Sales by Frequency';
   class SalesRep Quarter;
   table SalesRep all,
         Quarter all;
run;

/*********************************************************************/
/* Examples for Chapter 27 Begin Here                                */
/* This code is shown in Chapter 27 on page 435.                     */
/* Run the following DATA Step to create the YEAR_SALES data set.    */
data year_sales;
   input Month $ Quarter $ SalesRep $14. Type $ Units Price @@;
   AmountSold=Units*price;
   datalines;
01 1 Hollingsworth Deluxe    260 49.50                                                            
01 1 Hollingsworth Standard  330 30.97                                                            
01 1 Garcia        Deluxe    715 49.50                                                            
02 1 Garcia        Standard 2045 30.97                                                            
02 1 Garcia        Standard   40 30.97                                                            
02 1 Jensen        Standard  153 30.97                                                            
03 1 Hollingsworth Standard  125 30.97                                                            
03 1 Garcia        Standard  118 30.97                                                            
03 1 Jensen        Standard  525 30.97                                                            
04 2 Garcia        Standard  150 30.97                                                            
04 2 Hollingsworth Standard  530 30.97                                                            
04 2 Garcia        Standard 1715 30.97                                                            
05 2 Jensen        Standard   45 30.97                                                            
05 2 Garcia        Standard   40 30.97                                                            
05 2 Jensen        Standard  153 30.97                                                            
06 2 Jensen        Standard  154 30.97                                                            
06 2 Jensen        Standard  276 30.97                                                            
06 2 Garcia        Standard  512 30.97                                                            
07 3 Garcia        Standard  250 30.97                                                            
07 3 Garcia        Standard   90 30.97                                                            
07 3 Jensen        Standard  110 30.97                                                            
07 3 Hollingsworth Standard  130 30.97                                                            
07 3 Garcia        Standard  265 30.97                                                            
07 3 Garcia        Standard 1250 30.97                                                            
07 3 Garcia        Standard   90 30.97                                                            
07 3 Garcia        Standard   90 30.97                                                            
07 3 Jensen        Standard  110 30.97                                                            
07 3 Jensen        Standard  675 30.97                                                            
08 3 Garcia        Deluxe    110 49.50                                                            
08 3 Hollingsworth Standard  230 30.97                                                            
08 3 Garcia        Standard  240 30.97                                                            
08 3 Jensen        Standard  453 30.97                                                            
08 3 Hollingsworth Standard  290 30.97                                                            
08 3 Jensen        Deluxe     45 49.50                                                            
08 3 Garcia        Deluxe    110 49.50                                                            
08 3 Garcia        Standard  240 30.97                                                            
08 3 Jensen        Standard  453 30.97                                                            
08 3 Jensen        Deluxe    225 49.50                                                            
09 3 Jensen        Standard  254 30.97                                                            
09 3 Hollingsworth Standard 1000 30.97                                                            
09 3 Garcia        Standard  412 30.97                                                            
09 3 Garcia        Standard  100 30.97                                                            
09 3 Hollingsworth Standard  125 30.97                                                            
09 3 Garcia        Standard 1118 30.97                                                            
09 3 Jensen        Standard  284 30.97                                                            
09 3 Jensen        Deluxe    275 49.50                                                            
09 3 Jensen        Standard  876 30.97                                                            
10 4 Hollingsworth Standard  530 30.97                                                            
10 4 Hollingsworth Standard  265 30.97                                                            
10 4 Garcia        Standard  365 30.97                                                            
11 4 Jensen        Standard  453 30.97                                                            
11 4 Jensen        Standard   70 30.97                                                            
11 4 Hollingsworth Deluxe    150 49.50                                                            
12 4 Jensen        Standard  876 30.97                                                            
12 4 Jensen        Standard 1254 30.97  
01 1 Garcia        Standard   41 30.97 
01 1 Jensen        Standard  110 30.97 
01 1 Jensen        Standard  675 30.97 
02 1 Garcia        Deluxe     10 49.50 
02 1 Hollingsworth Standard 1030 30.97 
02 1 Garcia        Standard   98 30.97 
03 1 Jensen        Standard  154 30.97 
03 1 Hollingsworth Standard   25 30.97 
03 1 Garcia        Standard  310 30.97 
04 2 Hollingsworth Standard  260 30.97 
04 2 Jensen        Standard 1110 30.97 
04 2 Jensen        Standard  675 30.97 
05 2 Hollingsworth Standard 1120 30.97 
05 2 Hollingsworth Standard 1030 30.97 
05 2 Garcia        Standard   98 30.97 
06 2 Hollingsworth Deluxe     25 49.50 
06 2 Hollingsworth Standard  125 30.97 
06 2 Garcia        Standard 1000 30.97 
07 3 Hollingsworth Deluxe     60 49.50 
07 3 Hollingsworth Deluxe     30 49.50 
07 3 Garcia        Standard   90 30.97 
07 3 Jensen        Standard  110 30.97 
07 3 Jensen        Standard  275 30.97 
07 3 Hollingsworth Deluxe     60 49.50 
07 3 Jensen        Standard  110 30.97 
07 3 Hollingsworth Standard  330 30.97 
07 3 Garcia        Standard  465 30.97 
08 3 Jensen        Standard  145 30.97 
08 3 Hollingsworth Standard  120 30.97 
08 3 Jensen        Standard  453 30.97 
08 3 Hollingsworth Standard  230 49.50 
08 3 Garcia        Standard  198 30.97 
08 3 Garcia        Standard 1198 30.97 
08 3 Jensen        Standard  145 30.97 
08 3 Hollingsworth Standard  330 30.97 
08 3 Hollingsworth Deluxe     50 49.50 
08 3 Garcia        Standard  198 30.97 
09 3 Hollingsworth Standard  125 30.97 
09 3 Garcia        Standard  118 30.97 
09 3 Jensen        Standard  284 30.97 
09 3 Jensen        Deluxe    275 49.50 
09 3 Jensen        Standard  876 30.97 
09 3 Jensen        Standard  254 30.97 
09 3 Hollingsworth Standard  175 30.97 
09 3 Garcia        Standard  412 30.97 
09 3 Garcia        Standard  100 30.97 
10 4 Garcia        Standard  250 30.97 
10 4 Jensen        Standard  975 30.97 
10 4 Jensen        Standard   55 30.97 
11 4 Hollingsworth Standard 1230 30.97 
11 4 Garcia        Standard  198 30.97 
11 4 Garcia        Standard  120 30.97 
12 4 Garcia        Standard 1000 30.97 
12 4 Hollingsworth Deluxe    125 49.50 
12 4 Hollingsworth Standard  175 30.97   
;
  
/* This code is shown in Chapter 27 on page 435.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 27 on page 435.                                        */

options linesize=80 pageno=1 nodate;

proc report data=year_sales nowindows;
   where quarter='1';
   title1 'TruBlend Coffee Makers, Inc.'; 
   title2 'First Quarter Sales Report';
run;

/* This code is shown in Chapter 27 on page 436.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 27 on page 435.                                        */

options linesize=80 pageno=1 nodate;
proc report data=year_sales (keep=Units AmountSold)
            colwidth=10 nowindows;
   title1 'TruBlend Coffee Makers, Inc.'; 
   title2 'Total Yearly Sales';
run;

/* This code is shown in Chapter 27 on page 437.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 27 on page 435.                                        */

options linesize=80 pageno=1 nodate;

proc report data=year_sales nowindows;
   where Quarter='1';
   column SalesRep Month Type Units;
   title1 'TruBlend Coffee Makers, Inc.'; 
   title2 'First Quarter Sales Report';
run;

/* This code is shown in Chapter 27 on page 438.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 27 on page 435.                                        */

options linesize=80 pageno=1 nodate;
proc report data=year_sales nowindows;
   where Quarter='1';
   column SalesRep Month Type Units;
   define SalesRep / order;
   define Month / order;
   title1 'TruBlend Coffee Makers, Inc.'; 
   title2 'First Quarter Sales Report';
run;

/* This code is shown in Chapter 27 on pages 439 and 440.            */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 27 on page 435.                                        */

options linesize=80 pageno=1 nodate;

proc report data=year_sales nowindows colwidth=10;
   column SalesRep Units AmountSold;
   define SalesRep /group;
   define Units / analysis sum;
   define AmountSold/ analysis sum;
   title1 'TruBlend Coffee Makers Sales Report';
   title2 'Total Yearly Sales';
run;

/* This code is shown in Chapter 27 on page 441.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 27 on page 435.                                        */

options linesize=80 pageno=1 nodate;

proc report data=year_sales nowindows;
   where Quarter='1';
   column SalesRep Type Units Month;
   define SalesRep / order order=freq;
   define Units / order descending;
   define Type / order;
   title1 'TruBlend Coffee Makers, Inc.'; 
   title2 'First Quarter Sales Report';
run;

/* This code is shown in Chapter 27 on pages 442 and 443.            */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 27 on page 435.                                        */

options linesize=80 pageno=1 nodate;

proc report data=year_sales nowindows spacing=3;
   column SalesRep Units AmountSold;
   define SalesRep /group right;
   define Units / analysis sum width=5;
   define AmountSold/ analysis sum width=10;
   title1 'TruBlend Coffee Makers Sales Report';
   title2 'Total Yearly Sales';
run;

/* This code is shown in Chapter 27 on page 444.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 27 on page 435.                                        */

options linesize=80 pageno=1 nodate;

proc report data=year_sales nowindows spacing=3 headskip;
   column SalesRep Units AmountSold;
   define SalesRep /group 'Sales/Representative';
   define Units / analysis sum 'Units Sold' width=5;
   define AmountSold/ analysis sum 'Amount' 'Sold';
   title1 'TruBlend Coffee Makers Sales Report';
   title2 'Total Yearly Sales';
run;

/* This code is shown in Chapter 27 on page 445.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 27 on page 435.                                        */

options linesize=80 pageno=1 nodate;

proc report data=year_sales nowindows spacing=3 headskip;
   column SalesRep Units AmountSold;
   define SalesRep / group 'Sales/Representative';
   define Units / analysis sum 'Units Sold' format=comma7.;
   define AmountSold / analysis sum 'Amount' 'Sold' format=dollar14.2;
   title1 'TruBlend Coffee Makers Sales Report';
   title2 'Total Yearly Sales';
run;

/* This code is shown in Chapter 27 on page 446.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 27 on page 435.                                        */

options linesize=84 pageno=1 nodate;

proc report data=year_sales nowindows colwidth=5 headline;
   column SalesRep Type N;
   define SalesRep / group 'Sales Representative'; 
   define Type / across 'Type of Coffee Maker';
   define N / 'Total';
   title1 'TruBlend Coffee Makers Yearly Sales Report';
   title2 'Number of Sales';
 run;

/* This code is shown in Chapter 27 on page 447.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 27 on page 435.                                        */

options linesize=84 pageno=1 nodate;

proc report data=year_sales nowindows headline;
   column SalesRep Type,(Units Amountsold); 
   define SalesRep /group 'Sales Representative'; 
   define Type / across '';
   define units / analysis sum 'Units Sold' format=comma7.;
   define AmountSold / analysis mean 'Average/Sale' format=dollar12.2;
   title1 'TruBlend Coffee Makers Yearly Sales Report';
run;

/* This code is shown in Chapter 27 on page 449.                     */
/* The SAS data set YEAR_SALES was created earlier                   */
/* in Chapter 27 on page 435.                                        */

options linesize=80 pageno=1 nodate linesize=84;

proc report data=year_sales nowindows headskip;
   column Salesrep Quarter Units AmountSold;
   define SalesRep / group 'Sales Representative';
   define Quarter / group center;
   define Units / analysis sum 'Units Sold' format=comma7.;
   define AmountSold / analysis sum 'Amount/Sold' format=dollar14.2;
   break after SalesRep / summarize skip ol suppress;
   rbreak after / summarize skip dol;
   title1 'TruBlend Coffee Makers Sales Report';
   title2 'Total Yearly Sales';
run;

/*********************************************************************/
/* Examples for Chapter 28 Begin Here                                */
/* This code is shown in Chapter 28 on page 460.                     */
/* Run the following DATA Step to create the HIGHLOW data set.       */
data highlow;
   input Year @7 DateOfHigh:date9. DowJonesHigh @28 DateOfLow:date9. DowJonesLow;
   format LogDowHigh LogDowLow 5.2 DateOfHigh DateOfLow date9.;
   LogDowHigh=log(DowJonesHigh);
   LogDowLow=log(DowJonesLow);
datalines;
1954  31DEC1954  404.39  11JAN1954  279.87
1955  30DEC1955  488.40  17JAN1955  388.20
1956  06APR1956  521.05  23JAN1956  462.35
1957  12JUL1957  520.77  22OCT1957  419.79
1958  31DEC1958  583.65  25FEB1958  436.89
1959  31DEC1959  679.36  09FEB1959  574.46
1960  05JAN1960  685.47  25OCT1960  568.05
1961  13DEC1961  734.91  03JAN1961  610.25
1962  03JAN1962  726.01  26JUN1962  535.76
1963  18DEC1963  767.21  02JAN1963  646.79
1964  18NOV1964  891.71  02JAN1964  768.08
1965  31DEC1965  969.26  28JUN1965  840.59
1966  09FEB1966  995.15  07OCT1966  744.32
1967  25SEP1967  943.08  03JAN1967  786.41
1968  03DEC1968  985.21  21MAR1968  825.13
1969  14MAY1969  968.85  17DEC1969  769.93
1970  29DEC1970  842.00  06MAY1970  631.16
1971  28APR1971  950.82  23NOV1971  797.97
1972  11DEC1972 1036.27  26JAN1972  889.15
1973  11JAN1973 1051.70  05DEC1973  788.31
1974  13MAR1974  891.66  06DEC1974  577.60
1975  15JUL1975  881.81  02JAN1975  632.04
1976  21SEP1976 1014.79  02JAN1976  858.71
1977  03JAN1977  999.75  02NOV1977  800.85
1978  08SEP1978  907.74  28FEB1978  742.12
1979  05OCT1979  897.61  07NOV1979  796.67
1980  20NOV1980 1000.17  21APR1980  759.13
1981  27APR1981 1024.05  25SEP1981  824.01
1982  27DEC1982 1070.55  12AUG1982  776.92
1983  29NOV1983 1287.20  03JAN1983 1027.04
1984  06JAN1984 1286.64  24JUL1984 1086.57
1985  16DEC1985 1553.10  04JAN1985 1184.96
1986  02DEC1986 1955.57  22JAN1986 1502.29
1987  25AUG1987 2722.42  19OCT1987 1738.74
1988  21OCT1988 2183.50  20JAN1988 1879.14
1989  09OCT1989 2791.41  03JAN1989 2144.64
1990  16JUL1990 2999.75  11OCT1990 2365.10
1991  31DEC1991 3168.83  09JAN1991 2470.30
1992  01JUN1992 3413.21  09OCT1992 3136.58
1993  29DEC1993 3794.33  20JAN1993 3241.95
1994  31JAN1994 3978.36  04APR1994 3593.35
1995  13DEC1995 5216.47  30JAN1995 3832.08
1996  27DEC1996 6560.91  10JAN1996 5032.94
1997  06AUG1997 8259.31  11APR1997 6391.69
1998  23NOV1998 9374.27  31AUG1998 7539.07
;

proc print data=highlow;
   title 'Dow Jones Industrial Average Yearly High and Low Values';
run;

/* This code is shown in Chapter 28 on page 463.                     */
/* The SAS data set HIGHLOW was created earlier                      */
/* in Chapter 28 on page 460.                                        */

options pagesize=40 linesize=76 pageno=1 nodate;

proc plot data=highlow;
   plot DowJonesHigh*Year;
   title 'Dow Jones Industrial Average Yearly High';
run;

/* This code is shown in Chapter 28 on page 464.                     */
/* The SAS data set HIGHLOW was created earlier                      */
/* in Chapter 28 on page 460.                                        */

options pagesize=40 linesize=76 pageno=1 nodate;

proc plot data=highlow;
   plot LogDowHigh*Year;
   label LogDowHigh='Log of Highest Value'
         Year='Year Occurred';
   title 'Dow Jones Industrial Average Yearly High';
run;

/* This code is shown in Chapter 28 on page 465.                     */
/* The SAS data set HIGHLOW was created earlier                      */
/* in Chapter 28 on page 460.                                        */

options pagesize=40 linesize=76 pageno=1 nodate;

proc plot data=highlow;
   plot LogDowHigh*Year / haxis=1954 to 1998 by 4;
   label LogDowHigh='Log of Highest Value'
         Year='Year Occurred';   
   title 'Dow Jones Industrial Average Yearly High';
run;

/* This code is shown in Chapter 28 on pages 466 and 467.            */
/* The SAS data set HIGHLOW was created earlier                      */
/* in Chapter 28 on page 460.                                        */

options pagesize=40 linesize=76 pageno=1 nodate;

proc plot data=highlow;
   plot LogDowHigh*Year='+' / haxis=1954 to 1998 by 4;
   label LogDowHigh='Log of Highest Value'
         Year='Year Occurred';   
   title 'Dow Jones Industrial Average Yearly High';
run;

/* This code is shown in Chapter 28 on page 468.                     */
/* The SAS data set HIGHLOW was created earlier                      */
/* in Chapter 28 on page 460.                                        */

options pagesize=40 linesize=76 pageno=1 nodate;

proc plot data=highlow nolegend;
   plot LogDowHigh*Year='+' / haxis=1954 to 1998 by 4
                              box;
   label LogDowHigh='Log of Highest Value'
         Year='Year Occurred';   
   title 'Dow Jones Industrial Average Yearly High';
run;

/* This code is shown in Chapter 28 on page 469.                     */
/* The SAS data set HIGHLOW was created earlier                      */
/* in Chapter 28 on page 460.                                        */

options pagesize=40 linesize=76 pageno=1 nodate;

proc plot data=highlow;
   plot LogDowHigh*Year='+' LogDowLow*Year='o' 
                           / haxis=1954 to 1998 by 4 box;
   label LogDowHigh='Log of Highest Value'
         LogDowLow='Log of Lowest Value'
         Year='Year Occurred';   
   title 'Dow Jones Industrial Average Yearly High';
run;

/* This code is shown in Chapter 28 on page 473.                     */
/* The SAS data set HIGHLOW was created earlier                      */
/* in Chapter 28 on page 460.                                        */

options pagesize=40 linesize=76 pageno=1 nodate;

proc plot data=highlow vpercent=50;
   plot LogDowHigh*Year='+' LogDowLow*Year='o' 
                           / haxis=1954 to 1998 by 4 box;
   label LogDowHigh='Log of High'
         LogDowLow='Log of Low'
         Year='Year Occurred';   
   title 'Dow Jones Industrial Average Yearly High';
run;

/* This code is shown in Chapter 28 on pages 474 and 475.            */
/* The SAS data set HIGHLOW was created earlier                      */
/* in Chapter 28 on page 460.                                        */

options pagesize=40 linesize=76 pageno=1 nodate;

proc plot data=highlow;
   plot LogDowHigh*Year='+' LogDowLow*Year='o' 
                           / haxis=1954 to 1998 by 4
                             overlay box;
   label LogDowHigh='Log of High or Low'
         Year='Year Occurred';   
   title 'Dow Jones Industrial Average';
run;

/*********************************************************************/
/* Examples for Chapter 29 Begin Here                                */
/* This code is shown in Chapter 29 on page 481.                     */
/* Run the following DATA Step to create the GRADES data set.        */
data grades;
input Name &  $14. Gender : $2. Section : $3. ExamGrade1 @@;
   datalines;
Abdallah       F Mon  46 Anderson       M Wed  75
Aziz           F Wed  67 Bayer          M Wed  77
Bhatt          M Fri  79 Blair          F Fri  70
Bledsoe        F Mon  63 Boone          M Wed  58
Burke          F Mon  63 Chung          M Wed  85
Cohen          F Fri  89 Drew           F Mon  49
Dubos          M Mon  41 Elliott        F Wed  85
Farmer         F Wed  58 Franklin       F Wed  59
Freeman        F Mon  79 Friedman       M Mon  58
Gabriel        M Fri  75 Garcia         M Mon  79
Harding        M Mon  49 Hazelton       M Mon  55
Hinton         M Fri  85 Hung           F Fri  98
Jacob          F Wed  64 Janeway        F Wed  51
Jones          F Mon  39 Jorgensen      M Mon  63
Judson         F Fri  89 Kuhn           F Mon  89
LeBlanc        F Fri  70 Lee            M Fri  48
Litowski       M Fri  85 Malloy         M Wed  79
Meyer          F Fri  85 Nichols        M Mon  58
Oliver         F Mon  41 Park           F Mon  77
Patel          M Wed  73 Randleman      F Wed  46
Robinson       M Fri  64 Shien          M Wed  55
Simonson       M Wed  62 Smith N        M Wed  71
Smith R        M Mon  79 Sullivan       M Fri  77
Swift          M Wed  63 Wolfson        F Fri  79
Wong           F Fri  89 Zabriski       M Fri  89
;

proc print data=grades;
   title 'Introductory Chemistry Exam Scores';
run;

/* This code is shown in Chapter 29 on page 484.                     */
/* The SAS data set GRADES was created earlier                       */
/* in Chapter 29 on page 481.                                        */

options pagesize=40 linesize=80 pageno=1 nodate;

proc chart data=grades;
   vbar ExamGrade1;
   title 'Grades for First Chemistry Exam';
run;

/* This code is shown in Chapter 29 on page 486.                     */
/* The SAS data set GRADES was created earlier                       */
/* in Chapter 29 on page 481.                                        */

options pagesize=40 linesize=80 pageno=1 nodate;

proc chart data=grades;
   hbar Examgrade1;
   title 'Grades for First Chemistry Exam';
run;

/* This code is shown in Chapter 29 on page 486.                     */
/* The SAS data set GRADES was created earlier                       */
/* in Chapter 29 on page 481.                                        */

options pagesize=40 linesize=80 pageno=1 nodate;

proc chart data=grades;
   hbar Examgrade1 / nostat;
   title 'Grades for First Chemistry Exam';
run;

/* This code is shown in Chapter 29 on page 487.                     */
/* The SAS data set GRADES was created earlier                       */
/* in Chapter 29 on page 481.                                        */

options linesize=120 pagesize=40 pageno=1 nodate;

proc chart data=grades;
   block Examgrade1;
   title 'Grades for First Chemistry Exam';
run;

/* This code is shown in Chapter 29 on page 489.                     */
/* The SAS data set GRADES was created earlier                       */
/* in Chapter 29 on page 481.                                        */

options pagesize=40 linesize=80 pageno=1 nodate;

proc chart data=grades;
   pie ExamGrade1;
   title 'Grades for First Chemistry Exam';
run;

/* This code is shown in Chapter 29 on page 490.                     */
/* The SAS data set GRADES was created earlier                       */
/* in Chapter 29 on page 481.                                        */

options pagesize=40 linesize=80 pageno=1 nodate;

proc chart data=grades;
   vbar Examgrade1 / midpoints=55 to 95 by 10;
   title 'Assigning Grades for First Chemistry Exam';
run;

/* This code is shown in Chapter 29 on page 492.                     */
/* The SAS data set GRADES was created earlier                       */
/* in Chapter 29 on page 481.                                        */

options pagesize=40 linesize=80 pageno=1 nodate;

proc chart data=grades;
   vbar Examgrade1 / levels=5;
   title 'Assigning Grades for First Chemistry Exam';
run;

/* This code is shown in Chapter 29 on page 493.                     */
/* The SAS data set GRADES was created earlier                       */
/* in Chapter 29 on page 481.                                        */

options pagesize=40 linesize=80 pageno=1 nodate;

proc chart data=grades;
   vbar Examgrade1 / discrete;
   title 'Grades for First Chemistry Exam';
run;

/* This code is shown in Chapter 29 on page 494.                     */
/* The SAS data set GRADES was created earlier                       */
/* in Chapter 29 on page 481.                                        */

options pagesize=40 linesize=80 pageno=1 nodate;

proc chart data=grades;
   vbar Section / midpoints='Mon' 'Wed' 'Fri';
   title 'Enrollment for an Introductory Chemistry Course';
run;

/* This code is shown in Chapter 29 on pages 495 and 496.            */
/* The SAS data set GRADES was created earlier                       */
/* in Chapter 29 on page 481.                                        */

options pagesize=40 linesize=80 pageno=1 nodate;

proc chart data=grades;
   vbar Section / midpoints='Mon' 'Wed' 'Fri'
                  subgroup=Gender;
   title 'Enrollment for an Introductory Chemistry Course';
run;

/* This code is shown in Chapter 29 on page 497.                     */
/* The SAS data set GRADES was created earlier                       */
/* in Chapter 29 on page 481.                                        */

options pagesize=40 linesize=80 pageno=1 nodate;

proc chart data=grades;
   vbar Section / midpoints='Mon' 'Wed' 'Fri' group=Gender
                  sumvar=Examgrade1 type=mean;
   title 'Mean Exam Grade for Introductory Chemistry Sections';
run;

/* This code is shown in Chapter 29 on pages 498 and 499.            */
/* The SAS data set GRADES was created earlier                       */
/* in Chapter 29 on page 481.                                        */

options linesize=120 pagesize=40 pageno=1 nodate;

proc chart data=grades;
   block Section / midpoints='Mon' 'Wed' 'Fri'
                   sumvar=Examgrade1 type=mean
                   group=Gender;
   format Examgrade1 4.1;
   title 'Mean Exam Grade for Introductory Chemistry Sections';
run;

/* This code is shown in Chapter 29 on page 501.                     */
/* The SAS data set GRADES was created earlier                       */
/* in Chapter 29 on page 481.                                        */

goptions reset=global
         gunit=pct
         hsize= 5.625 in
         vsize= 3.5 in
         htitle=4
         htext=3
         vorigin=0 in
         horigin= 0 in
         cback=white border
         ctext=black
         colors=(black blue green red yellow)
         ftext=swiss
         lfactor=3; 

proc univariate data=grades noprint;
   histogram ExamGrade1;
   title 'Grades for First Chemistry Exam';
run;

/* This code is shown in Chapter 29 on page 502.                     */
/* The SAS data set GRADES was created earlier                       */
/* in Chapter 29 on page 481.                                        */

goptions reset=global
         gunit=pct
         hsize= 5.625 in
         vsize= 3.5 in
         htitle=4
         htext=3
         vorigin=0 in
         horigin= 0 in
         cback=white border
         ctext=black
         colors=(black blue green red yellow)
         ftext=swiss
         lfactor=3; 

proc univariate data=grades noprint;
   histogram Examgrade1 / vminor=4 grid lgrid=34;
   title 'Grades for First Chemistry Exam';
run;

/* This code is shown in Chapter 29 on page 504.                     */
/* The SAS data set GRADES was created earlier                       */
/* in Chapter 29 on page 481.                                        */

goptions reset=global
         gunit=pct
         hsize= 5.625 in
         vsize= 3.5 in
         htitle=4
         htext=3
         vorigin=0 in
         horigin= 0 in
         cback=white border
         ctext=black
         colors=(black blue green red yellow)
         ftext=swiss
         lfactor=3;
 
proc univariate data=grades noprint;
   histogram Examgrade1 / vscale=count vaxis=0 to 16 by 2 vminor=1; 
   title 'Grades for First Chemistry Exam';
run;

/* This code is shown in Chapter 29 on page 505.                     */
/* The SAS data set GRADES was created earlier                       */
/* in Chapter 29 on page 481.                                        */

goptions reset=global
         gunit=pct
         hsize= 5.625 in
         vsize= 3.5 in
         htitle=4
         htext=3
         vorigin=0 in
         horigin= 0 in
         cback=white border
         ctext=black
         colors=(black blue green red yellow)
         ftext=swiss
         lfactor=3; 

proc univariate data=grades noprint;
   histogram Examgrade1 / vscale=count vaxis=0 to 16 by 2 vminor=1  
                          midpoints=55 65 75 85 95 hoffset=10
                          vaxislabel='Frequency';
   title 'Grades for First Chemistry Exam';
run;

/* This code is shown in Chapter 29 on page 506.                     */
/* The SAS data set GRADES was created earlier                       */
/* in Chapter 29 on page 481.                                        */

goptions reset=global
         gunit=pct
         hsize= 5.625 in
         vsize= 3.5 in
         htitle=4
         htext=3
         vorigin=0 in
         horigin= 0 in
         cback=white border
         ctext=black
         colors=(black blue green red yellow)
         ftext=swiss
         lfactor=3; 

proc univariate data=grades noprint;
   histogram Examgrade1 /vscale=count vaxis=0 to 16 by 2 vminor=1 hoffset=10
                         midpoints=55 65 75 85 95 vaxislabel='Frequency';
   inset n='No. Students' mean='Mean Grade' min='Lowest Grade'
         max='Highest Grade' / header='Summary Statistics' position=ne
                               format=3.;
   title 'Grade Distribution for the First Chemistry Exam';
run;

/* This code is shown in Chapter 29 on page 508.                     */
/* The SAS data set GRADES was created earlier                       */
/* in Chapter 29 on page 481.                                        */

goptions reset=global
         gunit=pct
         hsize= 5.625 in
         vsize= 3.5 in
         htitle=4
         htext=3
         vorigin=0 in
         horigin= 0 in
         cback=white border
         ctext=black
         colors=(black blue green red yellow)
         ftext=swiss
         lfactor=3;
 
proc format;
   value $gendfmt 'M'='Male'
                  'F'='Female';
run;
                                  
proc univariate data=grades noprint;
   class Gender Section(order=data);
   histogram Examgrade1 / midpoints=45 to 95 by 10 vscale=count vaxis=0 to 6 by 2 
                          vaxislabel='Frequency' turnvlabels nrows=2 ncols=3 
                          cframe=ligr cframeside=gwh cframetop=gwh cfill=gwh;
   inset mean(4.1) n / noframe position=(2,65);
   format Gender $gendfmt.;
   title 'Grade Distribution for the First Chemistry Exam';
run;

/*********************************************************************/
/* Examples for Chapter 30 Begin Here                                */
/* This code is shown in Chapter 30 on page 518.                     */

data _null_;
   length state $ 15;
   input state $ morning_copies evening_copies year;
   put state morning_copies evening_copies year;
   datalines;
Massachusetts 798.4 984.7 1999
Massachusetts 834.2 793.6 1998
Massachusetts 750.3 .     1997
Alabama       .     698.4 1999
Alabama       463.8 522.0 1998
Alabama       583.2 234.9 1997
Alabama       .     339.6 1996
;

/* This code is shown in Chapter 30 on page 519.                     */
/* Copy the following data to an external file.                      */              
Massachusetts 798.4 984.7 1999
Massachusetts 834.2 793.6 1998
Massachusetts 750.3 .     1997
Alabama       .     698.4 1999
Alabama       463.8 522.0 1998
Alabama       583.2 234.9 1997
Alabama       .     339.6 1996
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

data _null_;
   length state $ 15;
   infile 'your-input-file';
   input state $ morning_copies evening_copies year;
   if morning_copies=. then put '** Morning Circulation Figures Missing';
   else
   if evening_copies=. then put '** Evening Circulation Figures Missing';

run;

/* This code is shown in Chapter 30 on page 520.                     */
/* Copy the following data to an external file.                      */              
Massachusetts 798.4 984.7 1999
Massachusetts 834.2 793.6 1998
Massachusetts 750.3 .     1997
Alabama       .     698.4 1999
Alabama       463.8 522.0 1998
Alabama       583.2 234.9 1997
Alabama       .     339.6 1996
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

data _null_;
   length state $ 15;
   infile 'your-input-file'; 
   input state $ morning_copies evening_copies year;
   if morning_copies =. then put
      '** Morning Circulation Figures Missing: ' year state;
   else
   if evening_copies =. then put
      '** Evening Circulation Figures Missing: ' year state;
  run;

/* This code is shown in Chapter 30 on page 521.                     */
/* Copy the following data to an external file.                      */              
Massachusetts 798.4 984.7 1999
Massachusetts 834.2 793.6 1998
Massachusetts 750.3 .     1997
Alabama       .     698.4 1999
Alabama       463.8 522.0 1998
Alabama       583.2 234.9 1997
Alabama       .     339.6 1996
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

options linesize=80 pagesize=60;

data _null_;
   length state $ 15;
   infile 'your-input-file'; 
   input state $ morning_copies evening_copies year;
   if morning_copies =. then put 
      '** Morning Tot Missing: ' year state @;
   if evening_copies =. then put 
      '** Evening Tot Missing: ' year state @;
   run;

/* This code is shown in Chapter 30 on page 523.                     */
/* Copy the following data to an external file.                      */              
Massachusetts 798.4 984.7 1999
Massachusetts 834.2 793.6 1998
Massachusetts 750.3 .     1997
Alabama       .     698.4 1999
Alabama       463.8 522.0 1998
Alabama       583.2 234.9 1997
Alabama       .     339.6 1996
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

options linesize=80 pagesize=60;

data _null_;
   length state $ 15;
   infile 'your-input-file'; 
   input state $ morning_copies evening_copies year;
   if morning_copies=. then put 
      '** Morning Tot Missing: ' year state @;
   if evening_copies=. then put 
      '** Evening Tot Missing: ' year state;
   else if morning_copies=. then put;
run;

/* This code is shown in Chapter 30 on page 525.                     */
/* Copy the following data to an external file.                      */              
Massachusetts 798.4 984.7 1999
Massachusetts 834.2 793.6 1998
Massachusetts 750.3 .     1997
Alabama       .     698.4 1999
Alabama       463.8 522.0 1998
Alabama       583.2 234.9 1997
Alabama       .     339.6 1996
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

options pagesize=30 linesize=80 pageno=1 nodate;

data _null_;
   infile 'your-input-file';
   input state $ morning_copies evening_copies year;
   file print notitles;
   put @26 year @53 morning_copies @66 evening_copies;
run;

/* This code is shown in Chapter 30 on page 526.                     */
/* Copy the following data to an external file.                      */              
Massachusetts 798.4 984.7 1999
Massachusetts 834.2 793.6 1998
Massachusetts 750.3 .     1997
Alabama       .     698.4 1999
Alabama       463.8 522.0 1998
Alabama       583.2 234.9 1997
Alabama       .     339.6 1996
/* Note that in the INFILE statement you must supply the path and    */
/* the name of the external file created above.                      */

data _null_;
   infile 'your-input-file';
   input state $ morning_copies evening_copies year;
   file print notitles;
   put @26 year @53 morning_copies 5.1 @66 evening_copies 5.1;
run;

/* This code is shown in Chapter 30 on page 527.                     */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */

options pagesize=30 linesize=80 pageno=1 nodate;

libname news 'SAS-data-library';
data news.circulation;
   length state $ 15;
   input state $ morning_copies evening_copies year;
   datalines;
Massachusetts 798.4 984.7 1999
Massachusetts 834.2 793.6 1998
Massachusetts 750.3 .     1997
Alabama       .     698.4 1999
Alabama       463.8 522.0 1998
Alabama       583.2 234.9 1997
Alabama       .     339.6 1996
;

data _null_;
   set news.circulation;
   by state notsorted;
   file print notitles;
   if first.state then put / @7 state @;
   put @26 year @53 morning_copies 5.1 @66 evening_copies 5.1;
run;

/* This code is shown in Chapter 30 on pages 528 and 529.            */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* The data set NEWS.CIRCULATION was created earlier                 */
/* in Chapter 30 on page 527.                                        */

 options pagesize=30 linesize=80 pageno=1 nodate;
libname news 'SAS-data-library';

data _null_;
   set news.circulation;
   by state notsorted;
   file print notitles;
      /* Set values of accumulator variables to 0 */
      /* at beginning of each BY group.           */
      if first.state then
         do;
            morning_total=0;
            evening_total=0;
            put / @7 state @;
         end;
   put @26 year @53 morning_copies 5.1 @66 evening_copies 5.1;

      /* Accumulate separate totals for morning and */
      /* evening circulations.                      */
   morning_total+morning_copies;
   evening_total+evening_copies;

      /* Calculate total circulation at the end of  */
      /* each BY group.                             */

   if last.state then
      do;      
         all_totals=morning_total+evening_total;      
         put @52 '------' @65 '------' /            
             @26 'Total for each category'
             @52 morning_total 6.1 @65 evening_total 6.1 / 
             @35 'Combined total' @59 all_totals 6.1;    
      end;
run;

/* This code is shown in Chapter 30 on pages 529 and 530.            */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* The data set NEWS.CIRCULATION was created earlier                 */
/* in Chapter 30 on page 527.                                        */

options pagesize=30 linesize=80 pageno=1 nodate;
libname news 'SAS-data-library';

data _null_;
   set news.circulation;
   by state notsorted;
   file print notitles footnotes;
   if _n_=1 then put @16 'Morning and Evening Newspaper Circulation' //
                     @7  'State' @26 'Year' @51 'Thousands of Copies' /
                     @51 'Morning      Evening'; 
   if first.state then
      do;
         morning_total=0;
         evening_total=0;
         put / @7 state @;
      end;
   put @26 year @53 morning_copies 5.1 @66 evening_copies 5.1;
   morning_total+morning_copies;
   evening_total+evening_copies;
   if last.state then
      do;
         all_totals=morning_total+evening_total;
         put @52 '------' @65 '------' /
             @26 'Total for each category'
             @52 morning_total 6.1 @65 evening_total 6.1 /
             @35 'Combined total' @59 all_totals 6.1;
      end;
   footnote 'Preliminary Report';
run;

/*********************************************************************/
/* Examples for Chapter 31 Begin Here                                */
/* This code is shown in Chapter 31 on page 535.                     */
/* Note that in the FILE statement you must supply the name of       */
/* your output file.                                                 */

data _null_;
   set out.sats1;
   file 'your-output-file'; 
   put @10 year @15 test
       @30 gender @35 score; 
run;
                                                                     
/* This code is shown in Chapter 31 on page 536.                     */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
 
options pagesize=60 linesize=80 pageno=1 nodate;
libname admin 'your-data-library';

data admin.sat_scores;
   input Test $ Gender $ Year SATscore @@;
   datalines;
Verbal m 1972 531  Verbal f 1972 529
Verbal m 1973 523  Verbal f 1973 521
Verbal m 1974 524  Verbal f 1974 520
Verbal m 1975 515  Verbal f 1975 509
Verbal m 1976 511  Verbal f 1976 508
Verbal m 1977 509  Verbal f 1977 505
Verbal m 1978 511  Verbal f 1978 503
Verbal m 1979 509  Verbal f 1979 501
Verbal m 1980 506  Verbal f 1980 498
Verbal m 1981 508  Verbal f 1981 496
Verbal m 1982 509  Verbal f 1982 499
Verbal m 1983 508  Verbal f 1983 498
Verbal m 1984 511  Verbal f 1984 498
Verbal m 1985 514  Verbal f 1985 503
Verbal m 1986 515  Verbal f 1986 504
Verbal m 1987 512  Verbal f 1987 502
Verbal m 1988 512  Verbal f 1988 499
Verbal m 1989 510  Verbal f 1989 498
Verbal m 1990 505  Verbal f 1990 496
Verbal m 1991 503  Verbal f 1991 495
Verbal m 1992 504  Verbal f 1992 496
Verbal m 1993 504  Verbal f 1993 497
Verbal m 1994 501  Verbal f 1994 497
Verbal m 1995 505  Verbal f 1995 502
Verbal m 1996 507  Verbal f 1996 503
Verbal m 1997 507  Verbal f 1997 503
Verbal m 1998 509  Verbal f 1998 502
Math   m 1972 527  Math   f 1972 489
Math   m 1973 525  Math   f 1973 489
Math   m 1974 524  Math   f 1974 488
Math   m 1975 518  Math   f 1975 479
Math   m 1976 520  Math   f 1976 475
Math   m 1977 520  Math   f 1977 474
Math   m 1978 517  Math   f 1978 474
Math   m 1979 516  Math   f 1979 473
Math   m 1980 515  Math   f 1980 473
Math   m 1981 516  Math   f 1981 473
Math   m 1982 516  Math   f 1982 473
Math   m 1983 516  Math   f 1983 474
Math   m 1984 518  Math   f 1984 478
Math   m 1985 522  Math   f 1985 480
Math   m 1986 523  Math   f 1986 479
Math   m 1987 523  Math   f 1987 481
Math   m 1988 521  Math   f 1988 483
Math   m 1989 523  Math   f 1989 482
Math   m 1990 521  Math   f 1990 483
Math   m 1991 520  Math   f 1991 482
Math   m 1992 521  Math   f 1992 484
Math   m 1993 524  Math   f 1993 484
Math   m 1994 523  Math   f 1994 487
Math   m 1995 525  Math   f 1995 490
Math   m 1996 527  Math   f 1996 492
Math   m 1997 530  Math   f 1997 494
Math   m 1998 531  Math   f 1998 496
;

proc print data=admin.sat_scores;
run;

/* This code is shown in Chapter 31 on pages 538 and 539.            */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* The SAS data set ADMIN.SAT_SCORES was created earlier             */
/* in Chapter 31 on page 536.                                        */

options linesize=80 pagesize=60 pageno=1 nodate;
libname admin 'SAS-data-library';

data report;
   set admin.sat_scores;
   if year ge 1995 then output;
   title1 'SAT Scores by Year, 1995-1998';
   title3 'Separate Statistics by Test Type';
run;

proc print data=report;
run; 

/* This code is shown in Chapter 31 on page 540.                     */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* The SAS data set ADMIN.SAT_SCORES was created earlier             */
/* in Chapter 31 on page 536.                                        */

options linesize=80 pagesize=30 pageno=1 nodate;
libname admin 'SAS-data-library';

data report;
   set admin.sat_scores;
   if year ge 1996 then output;
   title1 'SAT Scores by Year, 1996-1998';
   title3 'Separate Statistics by Test Type';
   footnote1 '1996 through 1998 SAT scores estimated based on total number';
   footnote2 'of people taking the SAT';
run;

proc print data=report;
run;

/* This code is shown in Chapter 31 on page 542.                     */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* The SAS data set ADMIN.SAT_SCORES was created earlier             */
/* in Chapter 31 on page 536.                                        */

options linesize=80 pagesize=30 pageno=1 nodate;
libname admin 'SAS-data-library';

data report;
   set admin.sat_scores;
   if year ge 1996 then output;
   label Test='Test Type' 
         SATscore='SAT Score';
   title1 'SAT Scores by Year, 1996-1998';
   title3 'Separate Statistics by Test Type';
run;

proc print data=report label;
run;

/* This code is shown in Chapter 31 on pages 542 and 543.            */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* The SAS data set ADMIN.SAT_SCORES was created earlier             */
/* in Chapter 31 on page 536.                                        */

options linesize=80 pagesize=40 pageno=1 nodate; 
libname admin 'SAS-data-library';

proc sort data=admin.satscores;
   by gender;
run;

proc means data=admin.satscores maxdec=2 fw=8;
   by gender;
   label SATscore='SAT score';
   title1 'SAT Scores by Year, 1967-1976';
   title3 'Separate Statistics by Test Type';
   footnote1 '1972 and 1976 SAT scores estimated based on the';
   footnote2 'total number of people taking the SAT';
run;

/* This code is shown in Chapter 31 on page 545.                     */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* The SAS data set ADMIN.SAT_SCORES was created earlier             */
/* in Chapter 31 on page 536.                                        */

options linesize=64 nocenter number date;

libname admin 'SAS-data-library';
data high_scores;
   set admin.sat_scores;
   if SATscore <  525 then delete;
run;

proc print data=high_scores;
   title 'SAT Scores: 525 and Above';
run;

/* This code is shown in Chapter 31 on pages 546 and 547.            */

data circulation_figures;
   length state $ 15;
   input state $ morning_copies evening_copies year;
   datalines;
Colorado  738.6 210.2 1984
Colorado  742.2 212.3 1985
Colorado  731.7 209.7 1986
Colorado  789.2 155.9 1987
Vermont   623.4 566.1 1984
Vermont   533.1 455.9 1985
Vermont   544.2 566.7 1986
Vermont   322.3 423.8 1987 
Alaska     51.0  80.7 1984
Alaska     58.7  78.3 1985
Alaska     59.8  70.9 1986
Alaska     64.3  64.6 1987
Alabama   256.3 480.5 1984
Alabama   291.5 454.3 1985
Alabama   303.6 454.7 1986
Alabama      .  454.5 1987
Maine        .     .  1984
Maine        .   68.0 1985
Maine     222.7  68.6 1986
Maine     224.1  66.7 1987
Hawaii    433.5 122.3 1984 
Hawaii    455.6 245.1 1985
Hawaii    499.3 355.2 1986
Hawaii    503.2 488.6 1987
;

proc print data=circulation_figures;
run;

/* This code is shown in Chapter 31 on page 548.                     */
/* The SAS data set CIRCULATION_FIGURES was created                  */
/* earlier in Chapter 31 on pages 546 and 547.                       */
/** Note- Do not use the INFILE statement as it is                  **/
/** in the book on page 548. use the SET statement below.           **/

options linesize=80 pagesize=20 nodate;

data report1;
   set circulation_figures;
run;

title 'Morning and Evening Newspaper Circulation';
title2;
title3
      'State          Year                     Thousands of Copies';
title4
      '                                          Morning      Evening';

data _null_;
   set report1;
   by state notsorted;
   file print;
   if first.state then
      do;
         morning_total=0;
         evening_total=0;
         put / @7 state @;
      end;
   put @26 year @53 morning_copies 5.1 @66 evening_copies 5.1;
   morning_total+morning_copies;
   evening_total+evening_copies;
   if last.state then
      do;
         all_totals=morning_total+evening_total;
         put @52 '------' @65 '------' /
             @26 'Total for each category'
             @52 morning_total 6.1 @65 evening_total 6.1 /
             @35 'Combined total' @59 all_totals 6.1;
      end;
run;

/* This code is shown in Chapter 31 on page 551.                     */
/* The SAS data set CIRCULATION_FIGURES was created                  */
/* earlier in Chapter 31 on pages 546 and 547.                       */

options linesize=80 pagesize=24;

data _null_;
   set circulation_figures;
   by state notsorted;
   file print notitles header=pagetop;
   if first.state then 
         do;
            morning_total=0;
            evening_total=0;
            put / @7 state @; 
         end;
   put @26 year @53 morning_copies 5.1 @66 evening_copies 5.1;
   morning_total+morning_copies;
   evening_total+evening_copies;
   if last.state then 
      do;
         all_totals=morning_total+evening_total;
         put @52 '------' @65 '------' / 
             @26 'Total for each category'
             @52 morning_total 6.1 @65 evening_total 6.1 /
             @35 'Combined total' @59 all_totals 6.1;
      end;
   return;
   pagetop:
      put @16 'Morning and Evening Newspaper Circulation' // 
          @7 'State' @26 'Year' @51 'Thousands of Copies'/
          @51 'Morning      Evening';
   return;
run;

/* This code is shown in Chapter 31 on page 553.                     */
/* The SAS data set CIRCULATION_FIGURES was created                  */
/* earlier in Chapter 31 on pages 546 and 547.                       */

options linesize=80 pagesize=24;

data _null_;
   set circulation_figures;
   by state notsorted;
   file print notitles header=pagetop;
   if first.state then
         do;
            morning_total=0;
            evening_total=0;
            put / @7 state @;
         end;
   put @26 year @53 morning_copies 5.1 @66 evening_copies 5.1;
   morning_total+morning_copies;
   evening_total+evening_copies;
   if last.state then
      do;
         all_totals=morning_total+evening_total;
         put @52 '------' @65 '------' /
             @26 'Total for each category'
             @52 morning_total 6.1 @65 evening_total 6.1 /
             @35 'Combined total' @59 all_totals 6.1;
      end;
   return;

   pagetop:
      pagenum+1;
      put @16 'Morning and Evening Newspaper Circulation'
              @67 'Page ' pagenum // 
          @7 'State' @26 'Year' @51 'Thousands of Copies'/
          @51 'Morning      Evening';
   return; 
run;

/* This code is shown in Chapter 31 on page 555.                     */
/* The SAS data set CIRCULATION_FIGURES was created                  */
/* earlier in Chapter 31 on pages 546 and 547.                       */

options pagesize=24;

data _null_;
   set circulation_figures;
   by state notsorted;
   file print notitles header=pagetop linesleft=cklines;
   if first.state then
         do;
            morning_total=0;
            evening_total=0;
            if cklines<8 then put _page_;
            put / @7 state @;
         end;
   put @26 year @53 morning_copies 5.1 @66 evening_copies 5.1;
   morning_total+morning_copies;
   evening_total+evening_copies;
   if last.state then
      do;
         all_totals=morning_total+evening_total;
         put @52 '------' @65 '------' /
             @26 'Total for each category'
             @52 morning_total 6.1 @65 evening_total 6.1 /
             @35 'Combined total' @59 all_totals 6.1;
      end;
   return;

   pagetop:
      pagenum+1;
      put @16 'Morning and Evening Newspaper Circulation'
              @67 'Page ' pagenum //
          @7 'State' @26 'Year' @51 'Thousands of Copies'/
          @51 'Morning      Evening';
   return; 
run;

/* This code is shown in Chapter 31 on page 557.                     */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */

options pagesize=60 linesize=80 pageno=1 nodate;

libname admin 'SAS-data-library';
data admin.sat_scores2;
   input Test $ 1-8 Gender $ 10 Year 12-15 SATscore 17-19;
   datalines;
verbal   m 1972 .
verbal   f 1972 529
verbal   m 1975 515
verbal   f 1975 509  
math     m 1972 .
math     f 1972 489
math       1975 518
math       1975 479
;

proc print data=admin.sat_scores2;
   title 'SAT Scores for Years 1972 and 1975';
run;

/* This code is shown in Chapter 31 on page 558.                     */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
   
options missing='M' pageno=1;

libname admin 'SAS-data-library';
data admin.sat_scores2;
   input Test $ 1-8 Gender $ 10 Year 12-15 SATscore 17-19;
   datalines;
verbal   m 1972
verbal   f 1972 529
verbal   m 1975 515
verbal   f 1975 509  
math     m 1972
math     f 1972 489
math       1975 518
math       1975 479
;

proc print data=admin.sat_scores2;
   title 'SAT Scores for Years 1972 and 1975';
run;

/* This code is shown in Chapter 31 on page 559.                     */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* The SAS data set ADMIN.SAT_SCORES2 was created                    */
/* earlier in Chapter 31 on page 558.                                */

options pageno=1;
libname admin 'SAS-data-library';

proc format;
   value xscore .='score unavailable';
run;

proc print data=admin.sat_scores2;
   format SATscore xscore.;
   title 'SAT Scores for Years 1972 and 1975';
run;

/*********************************************************************/
/* Examples for Chapter 32 Begin Here                                */
/* This code is shown in Chapter 32 on page 562.                     */

data sat_scores;
   input Test $ Gender $ Year SATscore @@;
   datalines;
Verbal m 1972 531  Verbal f 1972 529
Verbal m 1973 523  Verbal f 1973 521
Verbal m 1974 524  Verbal f 1974 520
Verbal m 1975 515  Verbal f 1975 509
Verbal m 1976 511  Verbal f 1976 508
Verbal m 1977 509  Verbal f 1977 505
Verbal m 1978 511  Verbal f 1978 503
Verbal m 1979 509  Verbal f 1979 501
Verbal m 1980 506  Verbal f 1980 498
Verbal m 1981 508  Verbal f 1981 496
Verbal m 1982 509  Verbal f 1982 499
Verbal m 1983 508  Verbal f 1983 498
Verbal m 1984 511  Verbal f 1984 498
Verbal m 1985 514  Verbal f 1985 503
Verbal m 1986 515  Verbal f 1986 504
Verbal m 1987 512  Verbal f 1987 502
Verbal m 1988 512  Verbal f 1988 499
Verbal m 1989 510  Verbal f 1989 498
Verbal m 1990 505  Verbal f 1990 496
Verbal m 1991 503  Verbal f 1991 495
Verbal m 1992 504  Verbal f 1992 496
Verbal m 1993 504  Verbal f 1993 497
Verbal m 1994 501  Verbal f 1994 497
Verbal m 1995 505  Verbal f 1995 502
Verbal m 1996 507  Verbal f 1996 503
Verbal m 1997 507  Verbal f 1997 503
Verbal m 1998 509  Verbal f 1998 502
Math   m 1972 527  Math   f 1972 489
Math   m 1973 525  Math   f 1973 489
Math   m 1974 524  Math   f 1974 488
Math   m 1975 518  Math   f 1975 479
Math   m 1976 520  Math   f 1976 475
Math   m 1977 520  Math   f 1977 474
Math   m 1978 517  Math   f 1978 474
Math   m 1979 516  Math   f 1979 473
Math   m 1980 515  Math   f 1980 473
Math   m 1981 516  Math   f 1981 473
Math   m 1982 516  Math   f 1982 473
Math   m 1983 516  Math   f 1983 474
Math   m 1984 518  Math   f 1984 478
Math   m 1985 522  Math   f 1985 480
Math   m 1986 523  Math   f 1986 479
Math   m 1987 523  Math   f 1987 481
Math   m 1988 521  Math   f 1988 483
Math   m 1989 523  Math   f 1989 482
Math   m 1990 521  Math   f 1990 483
Math   m 1991 520  Math   f 1991 482
Math   m 1992 521  Math   f 1992 484
Math   m 1993 524  Math   f 1993 484
Math   m 1994 523  Math   f 1994 487
Math   m 1995 525  Math   f 1995 490
Math   m 1996 527  Math   f 1996 492
Math   m 1997 530  Math   f 1997 494
Math   m 1998 531  Math   f 1998 496
;

/* This code is shown in Chapter 32 on page 566.                     */
/* The SAS data set SAT_SCORES was created earlier                   */
/* in Chapter 32 on page  562.                                       */

options pageno=1 nodate pagesize=30 linesize=78;
ods html file='summary-results.htm';

proc means data=sat_scores fw=8;
   var SATscore;
   class Test Gender;
   title1 'Average SAT Scores Entering College Classes, 1972-1998*';
   footnote1 '* Recentered Scale for 1987-1995';
run;

ods html close;

/* This code is shown in Chapter 32 on pages 567 and 568.            */
/* The SAS data set SAT_SCORES was created earlier                   */
/* in Chapter 32 on page  562.                                       */

proc sort data=sat_scores out=sorted_scores;
   by Test;
run;

options pageno=1 nodate;

ods listing close; 
ods html file='odshtml-body.htm'  
         contents='odshtml-contents.htm'
         page='odshtml-page.htm'
         frame='odshtml-frame.htm'; 

proc univariate data=sorted_scores;
  var SATscore;
  class Gender;
  by Test;
  title1 'Average SAT Scores Entering College students, 1972-1998+';
  footnote1 '* Recentered Scale for 1987-1995';
run;

ods html close; 
ods listing;

/* This code is shown in Chapter 32 on pages 569 and 570.            */
/* The SAS data set SAT_SCORES was created earlier                   */
/* in Chapter 32 on page  562.                                       */

proc sort data=sat_scores out=sorted_scores;
   by Test;
run;

options pageno=1 nodate;

ods listing close;
ods printer ps file='odsprinter_output.ps';

proc means data=sorted_scores fw=8;
   var SATscore;
   class Gender ;
   by Test;
   title1 'Average SAT Scores Entering College Classes, 1972-1998*';
   footnote1 '* Recentered Scale for 1987-1995';
run;

ods printer close;
ods listing;

/* This code is shown in Chapter 32 on page 570.                     */
/* The SAS data set SAT_SCORES was created earlier                   */
/* in Chapter 32 on page  562.                                       */

ods listing close;
ods rtf file='odsrtf_output.rtf';

proc univariate data=sat_scores; 
   var SATscore;
   class Gender;
   title1 'Average SAT Scores Entering College Classes, 1972-1998*';
   footnote1 '* Recentered Scale for 1987-1995';
run;

ods rtf close;
ods listing;

/* This code is shown in Chapter 32 on page 573.                     */
/* The SAS data set SAT_SCORES was created earlier                   */
/* in Chapter 32 on page  562.                                       */

ods trace on;

proc univariate data=sat_scores;
   var SATscore;
   class Gender;
   title1 'Average SAT Scores Entering College Classes, 1972-1998*';
   footnote1 '* Recentered Scale for 1987-1995';
run;

ods trace off;

/* This code is shown in Chapter 32 on page 576.                     */
/* The SAS data set SAT_SCORES was created earlier                   */
/* in Chapter 32 on page  562.                                       */

options nodate pageno=1;

ods listing close;
ods html file='odsselect-body.htm'  
         contents='odsselect-contents.htm'
         page='odsselect-page.htm'
         frame='odsselect-frame.htm';
ods printer file='odsprinter-select.ps';

ods select BasicMeasures TestsForLocation;
proc univariate data=sat_scores;
   var SATscore;
   class Gender; 
   title1 'Average SAT Scores Entering College Classes, 1972-1998*'; 
   footnote1 '* Recentered Scale for 1987-1995'; 
run;

ods html close;
ods printer close;
ods listing;

/* This code is shown in Chapter 32 on page 580.                     */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* The SAS data set SAT_SCORES was created earlier                   */
/* in Chapter 32 on page  562.                                       */

libname myfile 'SAS-data-library';

ods listing close;
ods output BasicMeasures=myfile.measures;

proc univariate data=sat_scores;
   var SATscore;
   class Gender; 
run;

ods output close;
ods listing;

/* This code is shown in Chapter 32 on page 581.                     */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* The SAS data set SAT_SCORES was created earlier                   */
/* in Chapter 32 on page  562.                                       */

options nodate pageno=1;

ods listing close;
ods printer ps file='style_job.ps' style=fancyprinter; 
ods select Moments BasicMeasures;
 
proc univariate data=sat_scores;
   var SATscore;
   title 'Average SAT Scores for Entering College Classes, 1972-1982*';
   footnote1 '* Recentered Scale for 1987-1995'; 
run;

ods printer close; 
ods listing;

/* This code is shown in Chapter 32 on pages 582 and 583.            */
/* The SAS data set SORTED_SCORES was created earlier                */
/* in Chapter 32 on pages 567 and 568.                               */

options nodate nonumber linesize=80 pagesize=60;

proc template;
   define table base.univariate.Measures;
   header h1 h2 h3;
   column VarMeasure VarValue LocMeasure LocValue;

   define h1;
      text "Basic Statistical Measures";
      spill_margin=on;
      space=1;
   end;

   define h2;
      text "Measures of Variability";
      start=VarMeasure;
      end=VarValue;
   end;

   define h3;
      text "Measures of Location";
      start=LocMeasure;
      end=LocValue;
   end;
     define LocMeasure;
      print_headers=off;
      glue=2;
      space=3;
      style=rowheader;
   end;

   define LocValue;
      print_headers=off;
      space=5;
      format=7.3;
      style=data{font_style=italic font_weight=bold};
   end;

   define VarMeasure;
      print_headers=off;
      glue=2;
      space=3;
      style=rowheader;
   end;

   define VarValue;
      print_headers=off;
      format=7.3;
      style=data{font_style=italic font_weight=bold};
   end;
end;
run;

ods listing close;
ods html file='scores-body.htm'
     contents='scores-contents.htm'
         page='scores-page.htm'
         frame='scores-frame.htm';
ods printer file='scores.ps';
ods select BasicMeasures;

title;
proc univariate data=sorted_scores mu0=3.5;
   var SATscore;
run;

ods html close;
ods printer close;
ods listing;

/* This code is shown in Chapter 32 on page 585.                     */
/* The SAS data set SAT_SCORES was created earlier                   */
/* in Chapter 32 on page  562.                                       */

ods listing close;
ods html file='store-links.htm'; 
ods printer file='store-links.ps';
ods rtf file='store-links.rtf';
ods output basicmeasures=measures;

proc univariate data=sat_scores;
   var SATscore;
   class Gender;
   title;
run;

ods _all_ close;
ods listing;

/*********************************************************************/
/* Examples for Chapter 35 Begin Here                                */
/* This code is shown in Chapter 35 on page 604.                     */
/* Run the following DATA Steps to create the USCLIM.HIGHTEMP,       */
/* USCLIM.HURRICANE, USCLIM.LOWTEMP, and USCLIM.TEMPCHNG data sets.  */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* Note that the SAS log will not include the USCLIM.BASETEMP catalog*/
/* or the USCLIM.REPORT catalog as shown in Chapter 35 on page 605.  */
libname usclim 'SAS-data-library';
data usclim.hightemp;
   input State $char14. City $char14. Temp_f Date $ Elevation;
   datalines;
Arizona       Parker         127 07jul05 345
Kansas        Alton          121 25jul36 1651
Nevada        Overton        122 23jun54 1240
North Dakota  Steele         121 06jul36 1857
Oklahoma      Tishomingo     120 26jul43 6709
Texas         Seymour        120 12aug36 1291
;
data usclim.hurricane;
   input @1 State $char11. @13 Date date7. Deaths Millions Name $;
   format Date worddate18. Millions dollar6.;
   informat State $char11. Date date9.;
   label Millions='Damage';
   datalines;
Mississippi 14aug69 256 1420 Camille
Florida     14jun72 117 2100 Agnes
Alabama     29aug79 5   2300 Frederick
Texas       15aug83 21  2000 Alicia
Texas       03aug80 28  300  Allen
;
data usclim.lowtemp;
   input State $char14. City $char14. Temp_f Date $ Elevation;
   datalines;
Alaska        Prospect Creek -80 23jan71 1100
Colorado      Maybell        -60 01jan79 5920
Idaho         Island Prk Dam -60 18jan43 6285
Minnesota     Pokegama Dam   -59 16feb03 1280
North Dakota  Parshall       -60 15feb36 1929
South Dakota  McIntosh       -58 17feb36 2277
Wyoming       Moran          -63 09feb33 6770
;
data usclim.tempchng;
   input @1 State $char13. @15 Date date7. Start_f End_f Minutes;
   Diff=End_f-Start_f;
   informat State $char13. Date date7.;
   format Date date9.;
   datalines;
North Dakota  21feb18 -33 50  720
South Dakota  22jan43 -4  45  2
South Dakota  12jan11 49  -13 120
South Dakota  22jan43 54  -4  27
South Dakota  10jan11 55  8   15
;

options pagesize=60 linesize=80 nonumber nodate; 
libname usclim 'SAS-data-library';

proc datasets library=usclim;

/* This code is shown in Chapter 35 on page 605.                     */
/* Run the following DATA Steps to create the USCLIM.HIGHTEMP,       */
/* USCLIM.HURRICANE, USCLIM.LOWTEMP, and USCLIM.TEMPCHNG data sets.  */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
options pagesize=60 linesize=80 nonumber nodate;  
libname usclim 'SAS-data-library';
data usclim.hightemp;
   input State $char14. City $char14. Temp_f Date $ Elevation;
   datalines;
Arizona       Parker         127 07jul05 345
Kansas        Alton          121 25jul36 1651
Nevada        Overton        122 23jun54 1240
North Dakota  Steele         121 06jul36 1857
Oklahoma      Tishomingo     120 26jul43 6709
Texas         Seymour        120 12aug36 1291
;
data usclim.hurricane;
   input @1 State $char11. @13 Date date7. Deaths Millions Name $;
   format Date worddate18. Millions dollar6.;
   informat State $char11. Date date9.;
   label Millions='Damage';
   datalines;
Mississippi 14aug69 256 1420 Camille
Florida     14jun72 117 2100 Agnes
Alabama     29aug79 5   2300 Frederick
Texas       15aug83 21  2000 Alicia
Texas       03aug80 28  300  Allen
;
data usclim.lowtemp;
   input State $char14. City $char14. Temp_f Date $ Elevation;
   datalines;
Alaska        Prospect Creek -80 23jan71 1100
Colorado      Maybell        -60 01jan79 5920
Idaho         Island Prk Dam -60 18jan43 6285
Minnesota     Pokegama Dam   -59 16feb03 1280
North Dakota  Parshall       -60 15feb36 1929
South Dakota  McIntosh       -58 17feb36 2277
Wyoming       Moran          -63 09feb33 6770
;
data usclim.tempchng;
   input @1 State $char13. @15 Date date7. Start_f End_f Minutes;
   Diff=End_f-Start_f;
   informat State $char13. Date date7.;
   format Date date9.;
   datalines;
North Dakota  21feb18 -33 50  720
South Dakota  22jan43 -4  45  2
South Dakota  12jan11 49  -13 120
South Dakota  22jan43 54  -4  27
South Dakota  10jan11 55  8   15
;

proc datasets library=usclim memtype=data;

/* This code is shown in Chapter 35 on page 606.                     */
/* Run the following DATA Step to create the USCLIM.TEMPCHNG data    */
/* set.                                                              */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
options pagesize=60 linesize=80 nonumber nodate;  
libname usclim 'SAS-data-library';
data usclim.tempchng;
   input @1 State $char13. @15 Date date7. Start_f End_f Minutes;
   Diff=End_f-Start_f;
   informat State $char13. Date date7.;
   format Date date9.;
   datalines;
North Dakota  21feb18 -33 50  720
South Dakota  22jan43 -4  45  2
South Dakota  12jan11 49  -13 120
South Dakota  22jan43 54  -4  27
South Dakota  10jan11 55  8   15
;

proc datasets library=usclim memtype=data;    
   contents data=tempchng;
run;

/* This code is shown in Chapter 35 on page 609.                     */
/* Run the following DATA Step to create the USCLIM.TEMPCHNG data    */
/* set.                                                              */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
options pagesize=60 linesize=80 nonumber nodate;  
libname usclim 'SAS-data-library';
data usclim.tempchng;
   input @1 State $char13. @15 Date date7. Start_f End_f Minutes;
   Diff=End_f-Start_f;
   informat State $char13. Date date7.;
   format Date date9.;
   datalines;
North Dakota  21feb18 -33 50  720
South Dakota  22jan43 -4  45  2
South Dakota  12jan11 49  -13 120
South Dakota  22jan43 54  -4  27
South Dakota  10jan11 55  8   15
;

proc datasets library=usclim memtype=data;    
   contents data=tempchng varnum;
run;

/* This code is shown in Chapter 35 on page 610.                     */
/* Run the following DATA Step to create the USCLIM.TEMPCHNG data    */
/* set.                                                              */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
options pagesize=60 linesize=80 nonumber nodate;                  
libname usclim 'SAS-data-library';
data usclim.tempchng;
   input @1 State $char13. @15 Date date7. Start_f End_f Minutes;
   Diff=End_f-Start_f;
   informat State $char13. Date date7.;
   format Date date9.;
   datalines;
North Dakota  21feb18 -33 50  720
South Dakota  22jan43 -4  45  2
South Dakota  12jan11 49  -13 120
South Dakota  22jan43 54  -4  27
South Dakota  10jan11 55  8   15
;

proc datasets library=usclim memtype=data;    
   contents data=tempchng short;
run;

/*********************************************************************/
/* Examples for Chapter 36 Begin Here                                */
/* This code is shown in Chapter 36 on page 614.                     */
/* Run the following DATA Steps to create the USCLIM.HIGHTEMP,       */ 
/* USCLIM.HURRICANE, USCLIM.LOWTEMP, and USCLIM.TEMPCHNG data sets.  */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* Note that the SAS log will not include the USCLIM.BASETEMP catalog*/
/* or the USCLIM.REPORT catalog as shown in Chapter 36 on page 615.  */
libname usclim 'SAS-data-library';
data usclim.hightemp;
   input State $char14. City $char14. Temp_f Date $ Elevation;
   datalines;
Arizona       Parker         127 07jul05 345
Kansas        Alton          121 25jul36 1651
Nevada        Overton        122 23jun54 1240
North Dakota  Steele         121 06jul36 1857
Oklahoma      Tishomingo     120 26jul43 6709
Texas         Seymour        120 12aug36 1291
;
data usclim.hurricane;
   input @1 State $char11. @13 Date date7. Deaths Millions Name $;
   format Date worddate18. Millions dollar6.;
   informat State $char11. Date date9.;
   label Millions='Damage';
   datalines;
Mississippi 14aug69 256 1420 Camille
Florida     14jun72 117 2100 Agnes
Alabama     29aug79 5   2300 Frederick
Texas       15aug83 21  2000 Alicia
Texas       03aug80 28  300  Allen
;
data usclim.lowtemp;
   input State $char14. City $char14. Temp_f Date $ Elevation;
   datalines;
Alaska        Prospect Creek -80 23jan71 1100
Colorado      Maybell        -60 01jan79 5920
Idaho         Island Prk Dam -60 18jan43 6285
Minnesota     Pokegama Dam   -59 16feb03 1280
North Dakota  Parshall       -60 15feb36 1929
South Dakota  McIntosh       -58 17feb36 2277
Wyoming       Moran          -63 09feb33 6770
;
data usclim.tempchng;
   input @1 State $char13. @15 Date date7. Start_f End_f Minutes;
   Diff=End_f-Start_f;
   informat State $char13. Date date7.;
   format Date date9.;
   datalines;
North Dakota  21feb18 -33 50  720
South Dakota  22jan43 -4  45  2
South Dakota  12jan11 49  -13 120
South Dakota  22jan43 54  -4  27
South Dakota  10jan11 55  8   15
;

options pagesize=60 linesize=80 nonumber nodate; 
libname usclim 'SAS-data-library';

proc datasets library=usclim;
   change hightemp=ushigh lowtemp=uslow;
run;

/* This code is shown in Chapter 36 on page 616.                     */
/* Run the following DATA Step to create the USCLIM.HURRICANE data   */
/* set.                                                              */
options pagesize=60 linesize=80 nonumber nodate;
libname usclim 'SAS-data-library';
data usclim.hurricane;
   input @1 State $char11. @13 Date date7. Deaths Millions Name $;
   format Date worddate18. Millions dollar6.;
   informat State $char11. Date date9.;
   label Millions='Damage';
   datalines;
Mississippi 14aug69 256 1420 Camille
Florida     14jun72 117 2100 Agnes
Alabama     29aug79 5   2300 Frederick
Texas       15aug83 21  2000 Alicia
Texas       03aug80 28  300  Allen
;

proc datasets library=usclim;    
   modify hurricane;
      rename State=Place Deaths=USDeaths;
run;

/* This code is shown in Chapter 36 on page 617.                     */
/* Run the following DATA Step to create the USCLIM.HURRICANE data   */
/* set.                                                              */
options pagesize=60 linesize=80 nonumber nodate;
libname usclim 'SAS-data-library';
data usclim.hurricane;
   input @1 State $char11. @13 Date date7. Deaths Millions Name $;
   format Date worddate18. Millions dollar6.;
   informat State $char11. Date date9.;
   label Millions='Damage';
   datalines;
Mississippi 14aug69 256 1420 Camille
Florida     14jun72 117 2100 Agnes
Alabama     29aug79 5   2300 Frederick
Texas       15aug83 21  2000 Alicia
Texas       03aug80 28  300  Allen
;

proc datasets library=usclim;    
   contents data=hurricane;       
      modify hurricane;
         format Date monyy7. Millions;
   contents data=hurricane;
run;

/* This code is shown in Chapter 36 on page 620.                     */
/* Run the following DATA Step to create the USCLIM.HURRICANE data   */
/* set.                                                              */
options pagesize=60 linesize=80 nonumber nodate;
libname usclim 'SAS-data-library';
data usclim.hurricane;
   input @1 State $char11. @13 Date date7. Deaths Millions Name $;
   format Date worddate18. Millions dollar6.;
   informat State $char11. Date date9.;
   label Millions='Damage';
   datalines;
Mississippi 14aug69 256 1420 Camille
Florida     14jun72 117 2100 Agnes
Alabama     29aug79 5   2300 Frederick
Texas       15aug83 21  2000 Alicia
Texas       03aug80 28  300  Allen
;

proc datasets library=usclim;    
   contents data=hurricane;       
      modify hurricane;
         label Millions='Damage in Millions' Place='State Hardest Hit';
   contents data=hurricane;
run;

/*********************************************************************/
/* Examples for Chapter 37 Begin Here                                */
/* This code is shown in Chapter 37 on page 627.                     */
/* Run the following DATA Steps to create the PRECIP.RAIN and the    */
/* PRECIP.SNOW data sets.                                            */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
libname precip 'SAS-data-library';
data precip.rain;
   input Place $ 1-12 @13 Date date7. Inches Cms;
   format Date date9.;
   datalines;
La Reunion  15mar52 74 188
Taiwan      10sep63 49 125
Australia   04jan79 44 114
Texas       25jul79 43 109
Canada      06oct64 19 49
;
data precip.snow;
   input Place $ 1-12 @13 Date date7. Inches Cms;
   format Date date9.;
   datalines;
Colorado    14apr21 76 193
Alaska      29dec55 62 158
France      05apr69 68 173
;

options pagesize=60 linesize=80 nonumber nodate;  

proc datasets library=precip;
   contents data=_all_ nods;    
   contents data=climate._all_ nods; 
run;

/* This code is shown in Chapter 37 on page 628.                     */
/* Run the following DATA Steps to create the PRECIP.RAIN and the    */
/* PRECIP.SNOW data sets.                                            */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
options pagesize=60 linesize=80 nonumber nodate;
libname precip 'SAS-data-library';
data precip.rain;
   input Place $ 1-12 @13 Date date7. Inches Cms;
   format Date date9.;
   datalines;
La Reunion  15mar52 74 188
Taiwan      10sep63 49 125
Australia   04jan79 44 114
Texas       25jul79 43 109
Canada      06oct64 19 49
;
data precip.snow;
   input Place $ 1-12 @13 Date date7. Inches Cms;
   format Date date9.;
   datalines;
Colorado    14apr21 76 193
Alaska      29dec55 62 158
France      05apr69 68 173
;
libname climate 'SAS-data-library'; 
 
proc datasets library=precip;
   copy out=climate;
run;

/* This code is shown in Chapter 37 on page 629.                     */
/* Run the following DATA Steps to create the CLIMATE.HIGHTEMP,      */
/* CLIMATE.LOWTEMP, STORM.TORNADO, PRECIP.RAIN, PRECIP.SNOW,         */
/* USCLIM.HIGHTEMP, USCLIM.HURRICANE, USCLIM.LOWTEMP, and            */
/* USCLIM.TEMPCHNG data sets.                                        */
/* The SAS data sets CLIMATE.RAIN and CLIMATE.SNOW were created      */
/* earlier in Chapter 37 on page 628.                                */
/* Note that in the LIBNAME statements you must supply the name of   */
/* your SAS data libraries.                                          */
/* Note that the SAS log will not include the USCLIM.BASETEMP catalog*/
/* or the USCLIM.REPORT catalog as shown in Chapter 37 on page 629.  */
options pagesize=60 linesize=80 nonumber nodate; 
libname usclim 'SAS-data-library';
libname weather 'SAS-data-library'; 
libname storm 'SAS-data-library';
libname precip 'SAS-data-library'; 
libname climate 'SAS-data-library';
data climate.hightemp;
   input Place $ 1-13 Date $ Degree_f Degree_c;
   datalines;
Libya         13sep22 136 58
California    10jul13 134 57
Israel        21jun42 129 54
Argentina     11dec05 120 49
Saskatchewan  05jul37 113 45
;
data climate.lowtemp;
   input Place $ 1-13 Date $ Degree_f Degree_c;
   datalines;
Antarctica    21jul83 -129 -89
Siberia       06feb33 -90  -68
Greenland     09jan54 -87  -66
Yukon         03feb47 -81  -63
Alaska        23jan71 -80  -67
;
data storm.tornado;    
   input State $ 1-12 @13 Date date7. Deaths Millions;
   format Date date9. Millions dollar6.;    
   label Millions='Damage in Millions';
   datalines; 
Iowa        11apr65 257 200 
Texas       11may70 26  135 
Nebraska    06may75 3   400 
Connecticut 03oct79 3   200 
Georgia     31mar73 9   115
;
data precip.rain;
   input Place $ 1-12 @13 Date date7. Inches Cms;
   format Date date9.;
   datalines;
La Reunion  15mar52 74 188
Taiwan      10sep63 49 125
Australia   04jan79 44 114
Texas       25jul79 43 109
Canada      06oct64 19 49
;
data precip.snow;
   input Place $ 1-12 @13 Date date7. Inches Cms;
   format Date date9.;
   datalines;
Colorado    14apr21 76 193
Alaska      29dec55 62 158
France      05apr69 68 173
;
data usclim.hightemp;
   input State $char14. City $char14. Temp_f Date $ Elevation;
   datalines;
Arizona       Parker         127 07jul05 345
Kansas        Alton          121 25jul36 1651
Nevada        Overton        122 23jun54 1240
North Dakota  Steele         121 06jul36 1857
Oklahoma      Tishomingo     120 26jul43 6709
Texas         Seymour        120 12aug36 1291
;
data usclim.hurricane;
   input @1 State $char11. @13 Date date7. Deaths Millions Name $;
   format Date worddate18. Millions dollar6.;
   informat State $char11. Date date9.;
   label Millions='Damage';
   datalines;
Mississippi 14aug69 256 1420 Camille
Florida     14jun72 117 2100 Agnes
Alabama     29aug79 5   2300 Frederick
Texas       15aug83 21  2000 Alicia
Texas       03aug80 28  300  Allen
;
data usclim.lowtemp;
   input State $char14. City $char14. Temp_f Date $ Elevation;
   datalines;
Alaska        Prospect Creek -80 23jan71 1100
Colorado      Maybell        -60 01jan79 5920
Idaho         Island Prk Dam -60 18jan43 6285
Minnesota     Pokegama Dam   -59 16feb03 1280
North Dakota  Parshall       -60 15feb36 1929
South Dakota  McIntosh       -58 17feb36 2277
Wyoming       Moran          -63 09feb33 6770
;
data usclim.tempchng;
   input @1 State $char13. @15 Date date7. Start_f End_f Minutes;
   Diff=End_f-Start_f;
   informat State $char13. Date date7.;
   format Date date9.;
   datalines;
North Dakota  21feb18 -33 50  720
South Dakota  22jan43 -4  45  2
South Dakota  12jan11 49  -13 120
South Dakota  22jan43 54  -4  27
South Dakota  10jan11 55  8   15
;

proc datasets library=precip;    
   copy out=weather;
   copy in=storm out=weather;
   copy in=climate out=weather;
   copy in=usclim out=weather;
run;

/* This code is shown in Chapter 37 on page 630.                     */
/* Run the following DATA Step to create the USCLIM.HURRICANE        */
/* data set.                                                         */ 
/* Note that in the LIBNAME statements you must supply the name of   */
/* your SAS data libraries.                                          */
options pagesize=60 linesize=80 nonumber nodate; 
libname usclim 'SAS-data-library';
libname storm 'SAS-data-library';
libname precip 'SAS-data-library';
data usclim.hurricane;
   input @1 State $char11. @13 Date date7. Deaths Millions Name $;
   format Date worddate18. Millions dollar6.;
   informat State $char11. Date date9.;
   label Millions='Damage';
   datalines;
Mississippi 14aug69 256 1420 Camille
Florida     14jun72 117 2100 Agnes
Alabama     29aug79 5   2300 Frederick
Texas       15aug83 21  2000 Alicia
Texas       03aug80 28  300  Allen
; 

proc datasets library=precip;    
   copy in=usclim out=storm;       
      select hurricane;
run;

/* This code is shown in Chapter 37 on page 630.                     */
/* Run the following DATA Steps to create the PRECIP.RAIN and the    */
/* PRECIP.SNOW data sets.                                            */ 
/* Note that in the LIBNAME statements you must supply the name of   */
/* your SAS data libraries.                                          */
options pagesize=60 linesize=80 nonumber nodate; 
libname usclim 'SAS-data-library';
libname precip 'SAS-data-library'; 
data precip.rain;
   input Place $ 1-12 @13 Date date7. Inches Cms;
   format Date date9.;
   datalines;
La Reunion  15mar52 74 188
Taiwan      10sep63 49 125
Australia   04jan79 44 114
Texas       25jul79 43 109
Canada      06oct64 19 49
;
data precip.snow;
   input Place $ 1-12 @13 Date date7. Inches Cms;
   format Date date9.;
   datalines;
Colorado    14apr21 76 193
Alaska      29dec55 62 158
France      05apr69 68 173
;

proc datasets library=precip;    
   copy out=usclim;       
      exclude snow;
run;

/* This code is shown in Chapter 37 on page 631.                     */
/* Run the following DATA Steps to create the PRECIP.RAIN and the    */
/* PRECIP.SNOW data sets.                                            */ 
/* Note that in the LIBNAME statements you must supply the name of   */
/* your SAS data libraries.                                          */
options pagesize=60 linesize=80 nonumber nodate; 
libname climate 'SAS-data-library';
libname precip 'SAS-data-library'; 
data precip.rain;
   input Place $ 1-12 @13 Date date7. Inches Cms;
   format Date date9.;
   datalines;
La Reunion  15mar52 74 188
Taiwan      10sep63 49 125
Australia   04jan79 44 114
Texas       25jul79 43 109
Canada      06oct64 19 49
;
data precip.snow;
   input Place $ 1-12 @13 Date date7. Inches Cms;
   format Date date9.;
   datalines;
Colorado    14apr21 76 193
Alaska      29dec55 62 158
France      05apr69 68 173
;

proc datasets library=precip;    
   copy out=climate move;
run;

proc datasets library=precip;    
   contents data=_all_ nods; 
run;

/* This code is shown in Chapter 37 on page 632.                     */
/* Run the following DATA Step to create the USCLIM.HURRICANE        */
/* data set.                                                         */ 
/* Note that in the LIBNAME statements you must supply the name of   */
/* your SAS data libraries.                                          */
options pagesize=60 linesize=80 nonumber nodate; 
libname usclim 'SAS-data-library';
libname storm 'SAS-data-library';
libname precip 'SAS-data-library';
data usclim.hurricane;
   input @1 State $char11. @13 Date date7. Deaths Millions Name $;
   format Date worddate18. Millions dollar6.;
   informat State $char11. Date date9.;
   label Millions='Damage';
   datalines;
Mississippi 14aug69 256 1420 Camille
Florida     14jun72 117 2100 Agnes
Alabama     29aug79 5   2300 Frederick
Texas       15aug83 21  2000 Alicia
Texas       03aug80 28  300  Allen
; 

proc datasets library=precip;    
   copy in=usclim out=storm move;       
      select hurricane;
run;

/* This code is shown in Chapter 37 on page 632.                     */
/* Run the following DATA Steps to create the CLIMATE.HIGHTEMP       */
/* and the CLIMATE.LOWTEMP data sets.                                */ 
/* Note that in the LIBNAME statements you must supply the name of   */
/* your SAS data libraries.                                          */
/* The SAS data set CLIMATE.RAIN was created                         */
/* earlier in Chapter 37 on page 631.                                */
options pagesize=60 linesize=80 nonumber nodate; 
libname climate 'SAS-data-library';
libname usclim 'SAS-data-library';
libname precip 'SAS-data-library';
data climate.hightemp;
   input Place $ 1-13 Date $ Degree_f Degree_c;
   datalines;
Libya         13sep22 136 58
California    10jul13 134 57
Israel        21jun42 129 54
Argentina     11dec05 120 49
Saskatchewan  05jul37 113 45
;
data climate.lowtemp;
   input Place $ 1-13 Date $ Degree_f Degree_c;
   datalines;
Antarctica    21jul83 -129 -89
Siberia       06feb33 -90  -68
Greenland     09jan54 -87  -66
Yukon         03feb47 -81  -63
Alaska        23jan71 -80  -67
;

proc datasets library=precip;    
   copy in=climate out=usclim move;       
      exclude snow;
run;

/* This code is shown in Chapter 37 on page 633.                     */
/* Run the following DATA Steps to create the USCLIM.HIGHTEMP,       */ 
/* USCLIM.LOWTEMP, USCLIM.TEMPCHNG, USCLIM.USHIGH, and USCLIM.USLOW  */
/* data sets.                                                        */
/* The SAS data set USCLIM.RAIN was created                          */
/* earlier in Chapter 37 on page 632.                                */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* Note that the SAS log will not include the USCLIM.BASETEMP catalog*/
/* or the USCLIM.REPORT catalog as shown in Chapter 37 on page 634.  */
libname usclim 'SAS-data-library';
data usclim.hightemp;
   input State $char14. City $char14. Temp_f Date $ Elevation;
   datalines;
Arizona       Parker         127 07jul05 345
Kansas        Alton          121 25jul36 1651
Nevada        Overton        122 23jun54 1240
North Dakota  Steele         121 06jul36 1857
Oklahoma      Tishomingo     120 26jul43 6709
Texas         Seymour        120 12aug36 1291
;
data usclim.lowtemp;
   input State $char14. City $char14. Temp_f Date $ Elevation;
   datalines;
Alaska        Prospect Creek -80 23jan71 1100
Colorado      Maybell        -60 01jan79 5920
Idaho         Island Prk Dam -60 18jan43 6285
Minnesota     Pokegama Dam   -59 16feb03 1280
North Dakota  Parshall       -60 15feb36 1929
South Dakota  McIntosh       -58 17feb36 2277
Wyoming       Moran          -63 09feb33 6770
;
data usclim.tempchng;
   input @1 State $char13. @15 Date date7. Start_f End_f Minutes;
   Diff=End_f-Start_f;
   informat State $char13. Date date7.;
   format Date date9.;
   datalines;
North Dakota  21feb18 -33 50  720
South Dakota  22jan43 -4  45  2
South Dakota  12jan11 49  -13 120
South Dakota  22jan43 54  -4  27
South Dakota  10jan11 55  8   15
;
data usclim.ushigh;
   input State $char14. City $char14. Temp_f Date $ Elevation;
   datalines;
Arizona       Parker         127 07jul05 345
Kansas        Alton          121 25jul36 1651
Nevada        Overton        122 23jun54 1240
North Dakota  Steele         121 06jul36 1857
Oklahoma      Tishomingo     120 26jul43 6709
Texas         Seymour        120 12aug36 1291
;
data usclim.uslow;
   input State $char14. City $char14. Temp_f Date $ Elevation;
   datalines;
Alaska        Prospect Creek -80 23jan71 1100
Colorado      Maybell        -60 01jan79 5920
Idaho         Island Prk Dam -60 18jan43 6285
Minnesota     Pokegama Dam   -59 16feb03 1280
North Dakota  Parshall       -60 15feb36 1929
South Dakota  McIntosh       -58 17feb36 2277
Wyoming       Moran          -63 09feb33 6770
;

proc datasets library=usclim;    
   delete rain;
run;

/* This code is shown in Chapter 37 on page 634.                     */
/* Run the following DATA Steps to create the USCLIM.HIGHTEMP,       */ 
/* USCLIM.LOWTEMP, USCLIM.TEMPCHNG, USCLIM.USHIGH, and USCLIM.USLOW  */
/* data sets.                                                        */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* Note that the SAS log will not include the USCLIM.BASETEMP catalog*/
/* or the USCLIM.REPORT catalog as shown in Chapter 37 on page 634.  */
libname usclim 'SAS-data-library';
data usclim.hightemp;
   input State $char14. City $char14. Temp_f Date $ Elevation;
   datalines;
Arizona       Parker         127 07jul05 345
Kansas        Alton          121 25jul36 1651
Nevada        Overton        122 23jun54 1240
North Dakota  Steele         121 06jul36 1857
Oklahoma      Tishomingo     120 26jul43 6709
Texas         Seymour        120 12aug36 1291
;
data usclim.lowtemp;
   input State $char14. City $char14. Temp_f Date $ Elevation;
   datalines;
Alaska        Prospect Creek -80 23jan71 1100
Colorado      Maybell        -60 01jan79 5920
Idaho         Island Prk Dam -60 18jan43 6285
Minnesota     Pokegama Dam   -59 16feb03 1280
North Dakota  Parshall       -60 15feb36 1929
South Dakota  McIntosh       -58 17feb36 2277
Wyoming       Moran          -63 09feb33 6770
;
data usclim.tempchng;
   input @1 State $char13. @15 Date date7. Start_f End_f Minutes;
   Diff=End_f-Start_f;
   informat State $char13. Date date7.;
   format Date date9.;
   datalines;
North Dakota  21feb18 -33 50  720
South Dakota  22jan43 -4  45  2
South Dakota  12jan11 49  -13 120
South Dakota  22jan43 54  -4  27
South Dakota  10jan11 55  8   15
;
data usclim.ushigh;
   input State $char14. City $char14. Temp_f Date $ Elevation;
   datalines;
Arizona       Parker         127 07jul05 345
Kansas        Alton          121 25jul36 1651
Nevada        Overton        122 23jun54 1240
North Dakota  Steele         121 06jul36 1857
Oklahoma      Tishomingo     120 26jul43 6709
Texas         Seymour        120 12aug36 1291
;
data usclim.uslow;
   input State $char14. City $char14. Temp_f Date $ Elevation;
   datalines;
Alaska        Prospect Creek -80 23jan71 1100
Colorado      Maybell        -60 01jan79 5920
Idaho         Island Prk Dam -60 18jan43 6285
Minnesota     Pokegama Dam   -59 16feb03 1280
North Dakota  Parshall       -60 15feb36 1929
South Dakota  McIntosh       -58 17feb36 2277
Wyoming       Moran          -63 09feb33 6770
;

proc datasets library=usclim;    
   save tempchng;
run;

/* This code is shown in Chapter 37 on page 635.                     */
/* The SAS data sets WEATHER.HIGHTEMP, WEATHER.HURRICANE,            */
/* WEATHER.LOWTEMP, WEATHER.RAIN, WEATHER.SNOW, WEATHER.TEMPCHNG,    */
/* WEATHER.TORNADO, WEATHER.USHIGH and WEATHER.USLOW were created    */
/* earlier in Chapter 37 on page 629.                                */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your SAS data library.                                            */
/* Note that the SAS log will not include the WEATHER.BASETEMP       */
/* catalog or the WEATHER.REPORT catalog as shown in Chapter 37      */
/* on page 635.                                                      */
libname weather 'SAS-data-library';

proc datasets library=weather kill;
run;
































































