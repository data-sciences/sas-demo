options nodate nonumber ps=60 ls=80;
proc format;
   value $subtxt    
         'speced' = 'Special Ed'
         'mathem' = 'Mathematics'
         'langua' = 'Language'
         'music'  = 'Music'     
         'scienc' = 'Science'
         'socsci' = 'Social Science'; 
run;

data salary;    
   input subjarea $ annsal @@;    
   label subjarea='Subject Area'          
         annsal='Annual Salary';    
   format subjarea $subtxt.;    
   datalines; 
speced 35584 mathem 27814 langua 26162 mathem 25470 
speced 41400 mathem 34432 music 21827 music 35787 music 30043 
mathem 45480 mathem 25358 speced 42360 langua 23963 langua 27403 
mathem 29610 music 27847 mathem 25000 mathem 29363 mathem 25091 
speced 31319 music 24150 langua 30180 socsci 42210 mathem 55600 
langua 32134 speced 57880 mathem 47770 langua 33472 music 21635 
mathem 31908 speced 43128 mathem 33000 music 46691 langua 28535 
langua 34609 music 24895 speced 42222 speced 39676 music 22515 
speced 41899 music 27827 scienc 44324 scienc 43075 langua 49100 
langua 44207 music 46001 music 25666 scienc 30000 mathem 26355 
mathem 39201 mathem 32000 langua 26705 mathem 37120 langua 44888 
mathem 62655 scienc 24532 mathem 36733 langua 29969 mathem 28521 
langua 27599 music 27178 mathem 26674 langua 28662 music 41161 
mathem 48836 mathem 25096 langua 27664 music 23092 speced 45773 
mathem 27038 mathem 27197 music 44444 speced 51096 mathem 25125 
scienc 34930 speced 44625 mathem 27829 mathem 28935 mathem 31124 
socsci 36133 music 28004 mathem 37323 music 32040 scienc 39784 
mathem 26428 mathem 39908 mathem 34692 music 26417 mathem 23663 
speced 35762 langua 29612 scienc 32576 mathem 32188 mathem 33957 
speced 35083 langua 47316 mathem 34055 langua 27556 langua 35465 
socsci 49683 langua 38250 langua 30171 mathem 53282 langua 32022 
socsci 31993 speced 52616 langua 33884 music 41220 mathem 43890 
scienc 40330 langua 36980 scienc 59910 mathem 26000 langua 29594 
socsci 38728 langua 47902 langua 38948 langua 33042 mathem 29360 
socsci 46969 speced 39697 mathem 31624 langua 30230 music 29954 
mathem 45733 music 24712 langua 33618 langua 29485 mathem 28709 
music 24720 mathem 51655 mathem 32960 mathem 45268 langua 31006 
langua 48411 socsci 59704 music 22148 mathem 27107 scienc 47475 
langua 33058 speced 53813 music 38914 langua 49881 langua 42485 
langua 26966 mathem 31615 mathem 24032 langua 27878 mathem 56070 
mathem 24530 mathem 40174 langua 27607 speced 31114 langua 30665 
scienc 25276 speced 36844 mathem 24305 mathem 35560 music 28770 
langua 34001 mathem 35955 
;  
run;
                                                                                           
proc means data=salary;                                                                                                       
   class subjarea;                                                                                                                      
   var annsal;                                                                                                                          
title 'Brief Summary of Teacher Salaries';                                                                                                    
run; 
                 
proc univariate data=salary noprint;                                                                                                       
   class subjarea;                                                                                                                      
   var annsal;                                                                                                                          
   histogram annsal / nrows=6;                                                                                                                    
title 'Comparative Histograms by Subject Area';                                                                                                    
run; 

proc sort data=salary;
   by subjarea;
run;

proc boxplot data=salary;
   plot annsal*subjarea / boxwidthscale=1 bwslegend;
title 'Comparative Box Plots by Subject Area';
run;

proc anova data=salary;
   class subjarea;
   model annsal=subjarea;
title 'ANOVA for Teacher Salaries';
run;
quit;
  
ods select means HOVFtest;
proc anova data=salary;
   class subjarea;
   model annsal=subjarea;
   means subjarea / hovtest;
title 'Testing for Equal Variances';
run;
quit;

ods select Welch;
proc anova data=salary;
   class subjarea;
   model annsal=subjarea;
   means subjarea / welch;
title 'Welch ANOVA for Salary Data';
run;
   
proc npar1way data=salary wilcoxon;
   class subjarea;
   var annsal;
title 'Nonparametric Tests for Teacher Salaries' ;
run;

proc anova data=salary;
   class subjarea;
   model annsal=subjarea;
   means subjarea / t;
title 'Multiple Comparisons with t tests';
run;
   means subjarea / bon ;
title 'Multiple Comparisons with Bonferroni Approach' ;
run;
   means subjarea / tukey;
title 'Means Comparisons with Tukey-Kramer Test';
run;
   means subjarea / tukey alpha=0.10 ;
title 'Tukey-Kramer Test at 90%';
run;
   means subjarea / dunnett('Mathematics') ;
title 'Means Comparisons with Mathematics as Control';
run;

data bullets;    
   input powder $ velocity @@;    
   datalines; 
BLASTO 27.3 BLASTO 28.1 BLASTO 27.4 BLASTO 27.7 BLASTO 28.0 
BLASTO 28.1 BLASTO 27.4 BLASTO 27.1 ZOOM 28.3 ZOOM 27.9 
ZOOM 28.1 ZOOM 28.3 ZOOM 27.9 ZOOM 27.6 ZOOM 28.5 ZOOM 27.9 
KINGPOW 28.4 KINGPOW 28.9 KINGPOW 28.3 KINGPOW 27.9 
KINGPOW 28.2 KINGPOW 28.9 KINGPOW 28.8 KINGPOW 27.7 
;
run;

proc means data=bullets;                                                                                                       
   class powder;                                                                                                                      
   var velocity;                                                                                                                          
title 'Brief Summary of Bullets Data';                                                                                                    
run; 

proc boxplot data=bullets;
   plot velocity*powder / boxwidthscale=1 bwslegend;
title 'Comparative Box Plots by Gunpowder';
run;
 
ods select HOVFtest;
proc anova data=bullets;
   class powder;
   model velocity=powder;
   means powder / hovtest;
title 'Testing Equal Variances for Bullets Data';
run;
quit;

ods select TestsForNormality;
proc univariate data=bullets normal;
   class powder;
   var velocity;
title 'Testing Normality for Bullets Data';
run;

proc anova data=bullets;
   class powder;
   model velocity=powder;
title 'ANOVA for Bullets Data';
run;
   means powder / tukey;
title 'Tukey Kramer Test for Bullets Data';
run;
quit;
   
proc npar1way data=bullets wilcoxon;
   class powder;
   var velocity;
title 'Nonparametric Tests for Bullets Data' ;
run;
