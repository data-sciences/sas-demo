/*-------------------------------------------------------------------*/
/*     Analysis of Clinical Trials Using SAS: A Practical Guide      */
/*          by Alex Dmitrienko, Geert Molenberghs,                   */
/*             Christy Chuang-Stein, and Walter Offen                */
/*       Copyright(c) 2005 by SAS Institute Inc., Cary, NC, USA      */
/*                   SAS Publications order # 59390                  */
/*                        ISBN 1-59047-504-6                         */
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
/* Questions or problem reports concerning this material may be      */
/* addressed to the author:                                          */
/*                                                                   */
/* SAS Institute Inc.                                                */
/* Books by Users                                                    */
/* Attn: Alex Dmitrienko, et al.                                     */
/* SAS Campus Drive                                                  */
/* Cary, NC   27513                                                  */
/*                                                                   */
/*                                                                   */
/* If you prefer, you can send email to:  saspress@sas.com           */
/* Use this for subject field:                                       */
/*     Comments for Alex Dmitrienko, et al.                          */
/*                                                                   */
/*-------------------------------------------------------------------*/
/* Date Last Updated: 18JUL07                                        */
/* 18JUL07: Removed NOPRINT from PROC FREQ step based on correction  */ 
/*          from Tech Support.                                       */ 
/*                                                                   */
/*-------------------------------------------------------------------*/
/* Date Last Updated: 19FEB08                                        */
/* 19FEB08: Updated the following programs based on corrections      */ 
/*          that were added to the 2nd printing of the book:         */
/*          Program 3.3, Program 4.9, and Program 4.10               */
/*                                                                   */
/*-------------------------------------------------------------------*/


/* Program 1.1, Page 3         */         

data hamd17;
    input center drug $ change @@;
    datalines;
100 P 18 100 P 14 100 D 23 100 D 18 100 P 10 100 P 17 100 D 18 100 D 22
100 P 13 100 P 12 100 D 28 100 D 21 100 P 11 100 P  6 100 D 11 100 D 25
100 P  7 100 P 10 100 D 29 100 P 12 100 P 12 100 P 10 100 D 18 100 D 14
101 P 18 101 P 15 101 D 12 101 D 17 101 P 17 101 P 13 101 D 14 101 D  7
101 P 18 101 P 19 101 D 11 101 D  9 101 P 12 101 D 11 102 P 18 102 P 15
102 P 12 102 P 18 102 D 20 102 D 18 102 P 14 102 P 12 102 D 23 102 D 19
102 P 11 102 P 10 102 D 22 102 D 22 102 P 19 102 P 13 102 D 18 102 D 24
102 P 13 102 P  6 102 D 18 102 D 26 102 P 11 102 P 16 102 D 16 102 D 17
102 D  7 102 D 19 102 D 23 102 D 12 103 P 16 103 P 11 103 D 11 103 D 25
103 P  8 103 P 15 103 D 28 103 D 22 103 P 16 103 P 17 103 D 23 103 D 18
103 P 11 103 P -2 103 D 15 103 D 28 103 P 19 103 P 21 103 D 17 104 D 13
104 P 12 104 P  6 104 D 19 104 D 23 104 P 11 104 P 20 104 D 21 104 D 25
104 P  9 104 P  4 104 D 25 104 D 19
;
proc sort data=hamd17;
    by drug center;
proc means data=hamd17 noprint;    
    by drug center;
    var change;
    output out=summary n=n  mean=mean std=std;
data summary;
    set summary;
    format mean std 4.1;
    label drug="Drug" 
    center="Center"
    n="Number of patients"
    mean="Mean HAMD17 change"
    std="Standard deviation";
proc print data=summary noobs label;
    var drug center n mean std;
data plac(rename=(mean=mp)) drug(rename=(mean=md));
    set summary;
    if drug="D" then output drug; else output plac; 
data comb;
    merge plac drug;
    by center;
    delta=md-mp;
axis1 minor=none label=(angle=90 "Treatment difference") 
    order=(-8 to 12 by 4);
axis2 minor=none label=("Center") order=(100 to 104 by 1);
symbol1 value=dot color=black i=none height=10;
proc gplot data=comb;
    plot delta*center/frame haxis=axis2 vaxis=axis1 vref=0 lvref=34;
    run;

/* Program 1.2, Page 6         */         

proc glm data=hamd17;
    class drug center;
    model change=drug|center/ss1;
    run;

/* Program 1.3, Page 8         */         

proc glm data=hamd17;
    class drug center;
    model change=drug|center/ss1;
    estimate "Trt diff"
        drug 1 -1 
        center -0.04 0 0.04 -0.02 0.02 
        drug*center 0.22 0.14 0.32 0.18 0.14 -0.26 -0.14 -0.28 -0.2 -0.12;
    run;

/* Program 1.4, Page 8         */         

proc glm data=hamd17;
    class drug center;
    model change=drug|center/ss2;
    run;

/* Program 1.5, Page 10         */        

proc glm data=hamd17;
    class drug center;
    model change=drug|center/ss2;
    estimate "Trt diff"
        drug 1 -1
        drug*center 0.23936 0.14060 0.29996 0.19029 0.12979
            -0.23936 -0.14060 -0.29996 -0.19029 -0.12979;
    run;

/* Program 1.6, Page 11         */        

proc glm data=hamd17;
    class drug center;
    model change=drug|center/ss3;
    run;

/* Program 1.7, Page 12         */        

proc glm data=hamd17;
    class drug center;
    model change=drug|center/ss3;
    estimate "Trt diff"
        drug 1 -1
        drug*center 0.2 0.2 0.2 0.2 0.2 -0.2 -0.2 -0.2 -0.2 -0.2;
    run;

/* Program 1.8, Page 14         */        

proc mixed data=hamd17;
    class drug center;
    model change=drug/ddfm=satterth;
    random center drug*center;
    estimate "Trt eff" drug 1 -1;
    run;

/* Program 1.9, Page 16         */        

data urininc;    
    input therapy $ stratum @@;
    do i=1 to 10; 
        input change @@; 
        if (change^=.) then output; 
    end;
    drop i;
    datalines;
Placebo  1  -86  -38   43 -100  289    0  -78   38  -80  -25
Placebo  1 -100 -100  -50   25 -100 -100  -67    0  400 -100
Placebo  1  -63  -70  -83  -67  -33    0  -13 -100    0   -3
Placebo  1  -62  -29  -50 -100    0 -100  -60  -40  -44  -14
Placebo  2  -36  -77   -6  -85   29  -17  -53   18  -62  -93
Placebo  2   64  -29  100   31   -6 -100  -30   11  -52  -55
Placebo  2 -100  -82  -85  -36  -75   -8  -75  -42  122  -30
Placebo  2   22  -82    .    .    .    .    .    .    .    .
Placebo  3   12  -68 -100   95  -43  -17  -87  -66   -8   64
Placebo  3   61  -41  -73  -42  -32   12  -69   81    0   87
Drug     1   50 -100  -80  -57  -44  340 -100 -100  -25  -74
Drug     1    0   43 -100 -100 -100 -100  -63 -100 -100 -100
Drug     1 -100 -100    0 -100  -50    0    0  -83  369  -50
Drug     1  -33  -50  -33  -67   25  390  -50    0 -100    .
Drug     2  -93  -55  -73  -25   31    8  -92  -91  -89  -67
Drug     2  -25  -61  -47  -75  -94 -100  -69  -92 -100  -35
Drug     2 -100  -82  -31  -29 -100  -14  -55   31  -40 -100
Drug     2  -82  131  -60     .   .    .    .    .    .    .
Drug     3  -17  -13  -55  -85  -68  -87  -42   36  -44  -98
Drug     3  -75  -35    7  -57  -92  -78  -69   -21 -14    .
;
proc sort data=urininc;
    by stratum therapy;
proc kde data=urininc out=density;
    by stratum therapy;
    var change;
proc sort data=density;
    by stratum;
* Plot the distribution of the primary endpoint in each stratum;
%macro PlotDist(stratum,label);
axis1 minor=none major=none value=none label=(angle=90 "Density") 
    order=(0 to 0.012 by 0.002);
axis2 minor=none order=(-100 to 150 by 50)
    label=("&label");    
symbol1 value=none color=black i=join line=34;
symbol2 value=none color=black i=join line=1;
data annotate;
    xsys="1"; ysys="1"; hsys="4"; x=50; y=90; position="5";  
    size=1; text="Stratum &stratum"; function="label";
proc gplot data=density anno=annotate;
    where stratum=&stratum;
    plot density*change=therapy/frame haxis=axis2 vaxis=axis1 nolegend;
    run;
    quit;
%mend PlotDist;
%PlotDist(1,);
%PlotDist(2,);
%PlotDist(3,Percent change in the frequency of incontinence episodes);

/* Program 1.10, Page 17         */       

proc freq data=urininc;
    ods select cmh;
    table stratum*therapy*change/cmh2 scores=modridit;
    run;

/* Program 1.11, Page 21         */       

data sepsis;
    input stratum therapy $ outcome $ count @@;
    if outcome="Dead" then survival=0; else survival=1;
    datalines;
    1 Placebo Alive 189 1 Placebo Dead 26
    1 Drug    Alive 185 1 Drug    Dead 33
    2 Placebo Alive 165 2 Placebo Dead 57
    2 Drug    Alive 169 2 Drug    Dead 49
    3 Placebo Alive 104 3 Placebo Dead 58
    3 Drug    Alive 156 3 Drug    Dead 48
    4 Placebo Alive 123 4 Placebo Dead 118
    4 Drug    Alive 130 4 Drug    Dead 80
    ;
proc freq data=sepsis;
    where stratum=4;
    table therapy*survival/riskdiff relrisk;
    weight count;
    run;

/* Program 1.12, Page 23         */      
/* 18JUL07: Removed NOPRINT from PROC FREQ step based on correction from Tech Support. */ 

proc freq data=sepsis;
    by stratum;
    table therapy*survival/riskdiff relrisk;
    ods output riskdiffcol1=riskdiff relativerisks=relrisk;
    weight count;
* Plot of mortality rates;
data mortrate;
    set riskdiff;
    format risk 3.1;
    if row="Row 1" then therapy="D";
    if row="Row 2" then therapy="P";
    if therapy="" then delete; 
axis1 minor=none label=(angle=90 "Mortality rate") order=(0 to 0.6 by 0.2);
axis2 label=none;   
pattern1 value=empty color=black;
pattern2 value=r1 color=black;
proc gchart data=mortrate;
    vbar therapy/frame raxis=axis1 maxis=axis2 gaxis=axis2
        sumvar=risk subgroup=therapy group=stratum nolegend;
    run;
* Plot of risk differences;
data mortdiff;
    set riskdiff;
    format risk 4.1;
    if row="Difference";
axis1 minor=none label=(angle=90 "Risk difference") 
    order=(-0.2 to 0.1 by 0.1);
axis2 label=("Stratum");  
pattern1 value=empty color=black;
proc gchart data=mortdiff;
    vbar stratum/frame raxis=axis1 maxis=axis2 sumvar=risk 
    midpoints=1 2 3 4;
    run;
* Plot of relative risks;
data riskratio;
    set relrisk;
    format value 3.1;
    if studytype="Cohort (Col1 Risk)";
axis1 minor=none label=(angle=90 "Relative risk") 
    order=(0.5 to 1.3 by 0.1);
axis2 label=("Stratum");  
pattern1 value=empty color=black;
proc gchart data=riskratio;
    vbar stratum/frame raxis=axis1 maxis=axis2 sumvar=value 
    midpoints=1 2 3 4;
    run;
* Plot of odds ratios;
data oddsratio;
    set relrisk;
    format value 3.1;
    if studytype="Case-Control (Odds Ratio)";
axis1 label=(angle=90 "Odds ratio") order=(0.4 to 1.4 by 0.2);
axis2 label=("Stratum");  
pattern1 value=empty color=black;
proc gchart data=oddsratio;
    vbar stratum/frame raxis=axis1 maxis=axis2 sumvar=value 
    midpoints=1 2 3 4;
    run;

/* Program 1.13, Page 27         */       

proc freq data=sepsis;
    table stratum*therapy*survival/cmh;
    weight count;
    run;

/* Program 1.14, Page 30         */       

data sepsis1;
    input center therapy $ outcome $ count @@;
    if outcome="Dead" then survival=0; else survival=1;
    datalines;
    1 Placebo Alive 2 1 Placebo Dead 2
    1 Drug    Alive 4 1 Drug    Dead 0
    2 Placebo Alive 1 2 Placebo Dead 2
    2 Drug    Alive 3 2 Drug    Dead 1
    3 Placebo Alive 3 3 Placebo Dead 2
    3 Drug    Alive 3 3 Drug    Dead 0
    ;
proc freq data=sepsis1;
    table center*therapy*survival/cmh;
    weight count;
proc multtest data=sepsis1;
    class therapy;
    freq count;
    strata center;
    test ca(survival/permutation=20);
    run;

/* Program 1.15, Page 31         */       

proc multtest data=sepsis;
    class therapy;
    freq count;
    strata stratum;
    test ca(survival/permutation=500);
    run;

/* Program 1.16, Page 33         */       

data sepsis2;
    input event1 noevent1 event2 noevent2 @@;
    datalines;
    185 33 189 26
    169 49 165 57
    156 48 104 58
    130 80 123 118
    ;
%MinRisk(dataset=sepsis2);

/* Program 1.17, Page 35         */       

proc logistic data=sepsis;
    class therapy stratum;
    model survival=therapy stratum/clodds=pl;
    freq count;
    run;

/* Program 1.18, Page 36         */       

proc genmod data=sepsis;
    class therapy stratum;
    model survival=therapy stratum/dist=bin link=logit type3;
    freq count;
    run;

/* Programs on Page 37         */         

proc genmod data=sepsis;
    class therapy stratum;
    model survival=therapy stratum/dist=bin link=logit type3;
    freq count;
    estimate "PROC LOGISTIC treatment effect" therapy 1 -1 /divisor=2;
    run;

proc logistic data=sepsis;
    class therapy stratum/param=glm;
    model survival=therapy stratum/clodds=pl;
    freq count;
    run;

/* Program 1.19, Page 38         */       

data sepsis1;
    input center therapy $ outcome $ count @@;
    if outcome="Dead" then survival=0; else survival=1;
    datalines;
    1 Placebo Alive 2 1 Placebo Dead 2
    1 Drug    Alive 4 1 Drug    Dead 0
    2 Placebo Alive 1 2 Placebo Dead 2
    2 Drug    Alive 3 2 Drug    Dead 1
    3 Placebo Alive 3 3 Placebo Dead 2
    3 Drug    Alive 3 3 Drug    Dead 0
    ;
proc logistic data=sepsis1 exactonly;
    class therapy center/param=reference;    
    model survival(event="0")=therapy center;
    exact therapy/estimate=odds;        
    freq count;
    run;

/* Program 1.20, Page 39         */       

proc logistic data=sepsis exactonly;
    class therapy stratum/param=reference;    
    model survival(event="0")=therapy stratum;
    exact therapy/estimate=odds;        
    freq count;
    run;

/* Program 1.21, Page 41         */       

data sepsurv;  
    call streaminit(9544); 
    do stratum=1 to 4;
        do patient=1 to 400;
            if patient<=200 then treat=0; else treat=1;
            if stratum=1 and treat=0 then b=25;
            if stratum=1 and treat=1 then b=13;
            if stratum=2 and treat=0 then b=10;
            if stratum=2 and treat=1 then b=13;
            if stratum=3 and treat=0 then b=3;
            if stratum=3 and treat=1 then b=5.5;
            if stratum=4 and treat=0 then b=1.2;
            if stratum=4 and treat=1 then b=2.5;
            survtime=rand("weibull",0.5,1000*b);
            censor=(survtime<=672);
            survtime=min(survtime,672);
        output; 
        end;
    end;

proc lifetest data=sepsurv notable outsurv=surv;
    by stratum;
    time survtime*censor(0);
    strata treat;

* Plot Kaplan-Meier survival curves in each stratum;
%macro PlotKM(stratum);
    axis1 minor=none label=(angle=90 "Survival") order=(0 to 1 by 0.5);
    axis2 minor=none label=("Time (h)") order=(0 to 700 by 350);
    symbol1 value=none color=black i=j line=1;
    symbol2 value=none color=black i=j line=20;
    data annotate;
        xsys="1"; ysys="1"; hsys="4"; x=50; y=20; position="5";
        size=1; text="Stratum &stratum"; function="label";
    proc gplot data=surv anno=annotate;
        where stratum=&stratum;
        plot survival*survtime=treat/frame haxis=axis2 vaxis=axis1 nolegend;
        run;
        quit;
%mend PlotKM;

%PlotKM(1);
%PlotKM(2);
%PlotKM(3);
%PlotKM(4);

/* Program 1.22, Page 44         */       

proc lifetest data=sepsurv notable;
    ods select HomTests;
    by stratum;
    time survtime*censor(0);
    strata treat;
    run;

/* Program 1.23, Page 46         */       

proc lifetest data=sepsurv notable;
    ods select LogUniChisq WilUniChiSq;
    by stratum;
    time survtime*censor(0);
    test treat;
    run;

/* Program on Page 48         */          

proc lifetest data=sepsurv notable;
    ods select HomTests;
    by stratum;
    time survtime*censor(0);
    strata treat/test=(tarone fleming(0.5));
    run;

/* Program 1.24, Page 49         */       

proc lifetest data=sepsurv notable;   
    ods select LogUniChisq WilUniChiSq;
    time survtime*censor(0);
    strata stratum;
    test treat;
    run;

/* Program 1.25, Page 51         */       

data cov;
    treat=0; output;
    treat=1; output;
proc phreg data=sepsurv;   
    model survtime*censor(0)=treat/risklimits;
    strata stratum;   
    baseline out=curve survival=est covariates=cov/nomean;

%macro PlotPH(stratum);
    axis1 minor=none label=(angle=90 "Survival") order=(0 to 1 by 0.5);
    axis2 minor=none label=("Time (h)") order=(0 to 700 by 350);
    symbol1 value=none color=black i=j line=1;
    symbol2 value=none color=black i=j line=20;
    data annotate;
        xsys="1"; ysys="1"; hsys="4"; x=50; y=20; position="5";  
        size=1; text="Stratum &stratum"; function="label";
    proc gplot data=curve anno=annotate;
        where stratum=&stratum;
        plot est*survtime=treat/frame haxis=axis2 vaxis=axis1 nolegend;
        run;
        quit;
%mend PlotPH;

%PlotPH(1);
%PlotPH(2);
%PlotPH(3);
%PlotPH(4);

/* Program 1.26, Page 54         */       

title "Efron method for handling ties";
proc phreg data=sepsurv;   
    model survtime*censor(0)=treat/ties=efron;
    strata stratum;   
    run;
title "Exact method for handling ties";
proc phreg data=sepsurv;   
    model survtime*censor(0)=treat/ties=exact;
    strata stratum;   
    run;

/* Program 1.27, Page 58         */       

proc sort data=hamd17;
    by drug center;
proc means data=hamd17 noprint;
    where drug="P";
    by center;
    var change;
    output out=plac mean=mp var=vp n=np;
proc means data=hamd17 noprint;
    where drug="D";
    by center;
    var change;
    output out=drug mean=md var=vd n=nd;
data comb;
    merge plac drug;
    by center;
    d=md-mp;
    n=np+nd;
    stderr=sqrt((1/np+1/nd)*((np-1)*vp+(nd-1)*vd)/(n-2));
%GailSimon(dataset=comb,est=d,stderr=stderr,testtype="P");
%GailSimon(dataset=comb,est=d,stderr=stderr,testtype="N");
%GailSimon(dataset=comb,est=d,stderr=stderr,testtype="T");

/* Program 1.28, Page 59         */       

proc sort data=sepsis;
    by stratum;
data est;
    set sepsis;   
    by stratum;
    retain ad dd ap dp;
    if therapy="Drug" and outcome="Alive" then ad=count;
    if therapy="Drug" and outcome="Dead" then dd=count;
    if therapy="Placebo" and outcome="Alive" then ap=count;
    if therapy="Placebo" and outcome="Dead" then dp=count;
    survd=ad/(ad+dd);
    survp=ap/(ap+dp);
    d=survd-survp;
    stderr=sqrt(survd*(1-survd)/(ad+dd)+survp*(1-survp)/(ap+dp));
    if last.stratum=1;
%GailSimon(dataset=est,est=d,stderr=stderr,testtype="P");
%GailSimon(dataset=est,est=d,stderr=stderr,testtype="N");
%GailSimon(dataset=est,est=d,stderr=stderr,testtype="T");

/* Program 1.29, Page 61         */       

%Pushback(dataset=comb,est=d,stderr=stderr,n=n,
    testtype="N",outdata=pushadj);
axis1 order=(-8 to 12 by 4);
axis2 label=("Ordered strata");
symbol1 value=circle color=black i=none;
proc gplot data=pushadj;
    plot d*ordstr/frame haxis=axis2 vaxis=axis1 vref=0 lvref=34;
    run;
axis1 order=(-8 to 12 by 4);
axis2 label=("Ordered strata");
symbol1 value=circle color=black i=none;
symbol2 value=triangle color=black i=none;
proc gplot data=pushadj;
    plot tau*ordstr t*ordstr/frame overlay haxis=axis2 vaxis=axis1
    vref=0 lvref=34;
    run;
axis1 order=(-8 to 12 by 4);
axis2 label=("Ordered strata");
symbol1 value=circle color=black i=none;
proc gplot data=pushadj;
    plot rho*ordstr/frame haxis=axis2 vaxis=axis1 vref=0 lvref=34;
    run;	
axis1 order=(-8 to 12 by 4);
axis2 label=("Ordered strata");
symbol1 value=circle color=black i=none;
proc gplot data=pushadj;
    plot dstar*ordstr/frame haxis=axis2 vaxis=axis1 vref=0 lvref=34;
    run;

/* Program 1.30, Page 63         */       

%Pushback(dataset=comb,est=d,stderr=stderr,n=n,
    testtype="T",outdata=pushadj);
axis1 order=(-8 to 12 by 4);
axis2 label=("Ordered strata");
symbol1 value=circle color=black i=none;
proc gplot data=pushadj;
    plot d*ordstr/frame haxis=axis2 vaxis=axis1 vref=0 lvref=34;
    run;
axis1 order=(-8 to 12 by 4);
axis2 label=("Ordered strata");
symbol1 value=circle color=black i=none;
symbol2 value=triangle color=black i=none;
proc gplot data=pushadj;
    plot tau*ordstr t*ordstr/frame overlay haxis=axis2 vaxis=axis1
    vref=0 lvref=34;
    run;
axis1 order=(-8 to 12 by 4);
axis2 label=("Ordered strata");
symbol1 value=circle color=black i=none;
proc gplot data=pushadj;
    plot rho*ordstr/frame haxis=axis2 vaxis=axis1 vref=0 lvref=34;
    run;	
axis1 order=(-8 to 12 by 4);
axis2 label=("Ordered strata");
symbol1 value=circle color=black i=none;
proc gplot data=pushadj;
    plot dstar*ordstr/frame haxis=axis2 vaxis=axis1 vref=0 lvref=34;
    run;

/* Program 2.1, Page 71         */        

data antihyp1;
    input test $ raw_p @@;
    datalines;
    L 0.047 M 0.0167 H 0.015
    ;

proc multtest pdata=antihyp1 bonferroni sidak out=adjp;

axis1 minor=none order=(0 to 0.15 by 0.05) label=(angle=90 "P-value");
axis2 minor=none value=("Low" "Medium" "High") label=("Dose")
    order=("L" "M" "H");
symbol1 value=circle color=black i=j;
symbol2 value=diamond color=black i=j;
symbol3 value=triangle color=black i=j;
proc gplot data=adjp;
    plot raw_p*test bon_p*test sid_p*test/frame overlay nolegend
    haxis=axis2 vaxis=axis1 vref=0.05 lvref=34;
    run;

/* Program 2.2, Page 77         */        

proc multtest pdata=antihyp1 bonferroni stepbon out=adjp;

axis1 minor=none order=(0 to 0.15 by 0.05) label=(angle=90 "P-value");
axis2 minor=none value=("Low" "Medium" "High") label=("Dose")
    order=("L" "M" "H");
symbol1 value=circle color=black i=j;
symbol2 value=diamond color=black i=j;
symbol3 value=triangle color=black i=j;
proc gplot data=adjp;
    plot raw_p*test bon_p*test stpbon_p*test/frame overlay nolegend
    haxis=axis2 vaxis=axis1 vref=0.05 lvref=34;
    run;

/* Program 2.3, Page 79         */        

proc iml;
    use antihyp1;
    read all var {raw_p} into p;                
    h=j(7,3,0);
    decision_matrix=j(7,3,0);
    adjusted_p=j(1,3,0);
    do i=1 to 3;
        do j=0 to 6;
            k=floor(j/2**(3-i));
            if k/2=floor(k/2) then h[j+1,i]=1;
        end;
    end;    
    do i=1 to 7;
        decision_matrix[i,]=h[i,]*sum(h[i,])*min(p[loc(h[i,])]);
    end; 
    do i=1 to 3; 
        adjusted_p[i]=max(decision_matrix[,i]); 
    end;    
    title={"L vs P", "M vs P", "H vs P"};
    print decision_matrix[colname=title];
    print adjusted_p[colname=title];
    quit;

/* Program 2.4, Page 80         */        

data antihyp2;
    input test $ raw_p @@;
    datalines;
    L 0.047 M 0.027 H 0.015
    ;
proc multtest pdata=antihyp2 stepbon hommel out=adjp;

axis1 minor=none order=(0 to 0.06 by 0.02) label=(angle=90 "P-value");
axis2 minor=none value=("Low" "Medium" "High") label=("Dose")
    order=("L" "M" "H");
symbol1 value=circle color=black i=j;
symbol2 value=diamond color=black i=j;
symbol3 value=triangle color=black i=j;
proc gplot data=adjp;
    plot raw_p*test stpbon_p*test hom_p*test/frame overlay nolegend
    haxis=axis2 vaxis=axis1 vref=0.05 lvref=34;
    run;

/* Program 2.5, Page 82         */        

data antihyp3;
    input test $ raw_p @@;
    datalines;
    L 0.053 M 0.026 H 0.017
    ;
proc multtest pdata=antihyp2 hochberg hommel out=adjp;

axis1 minor=none order=(0 to 0.06 by 0.02) label=(angle=90 "P-value");
axis2 minor=none value=("Low" "Medium" "High") label=("Dose")
    order=("L" "M" "H");
symbol1 value=circle color=black i=j;
symbol2 value=diamond color=black i=j;
symbol3 value=triangle color=black i=j;
proc gplot data=adjp;
    plot raw_p*test hoc_p*test hom_p*test/frame overlay nolegend
    haxis=axis2 vaxis=axis1 vref=0.05 lvref=34;
    run;

/* Program 2.6, Page 85         */        

data fev1;
    input time n1 mean1 sd1 n2 mean2 sd2;
    datalines;
    0.25 10 0.58  0.29 10 0.71 0.35
    0.5  10 0.62  0.31 10 0.88 0.33
    0.75 10 0.51  0.33 10 0.73 0.36
    1    10 0.34  0.27 10 0.68 0.29
    2    10 -0.06 0.22 10 0.37 0.25
    3    10 0.05  0.23 10 0.43 0.28
    ;
data summary;
    set fev1;
    meandif=mean2-mean1;
    se=sqrt((1/n1+1/n2)*(sd1*sd1+sd2*sd2)/2);
    t=meandif/se;
    p=1-probt(t,n1+n2-2);
    lower=meandif-tinv(0.95,n1+n2-2)*se;
axis1 minor=none label=(angle=90 "Treatment difference (L)")
    order=(-0.2 to 0.5 by 0.1);
axis2 minor=none label=("Time (hours)") order=(0 to 3 by 1);
symbol1 value=none i=j color=black line=1;
symbol2 value=none i=j color=black line=20;
proc gplot data=summary;
    plot meandif*time lower*time/overlay frame vaxis=axis1 haxis=axis2 
    vref=0 lvref=34;
    run;
axis1 minor=none label=(angle=90 "Raw p-value") order=(0 to 0.2 by 0.05);
axis2 minor=none label=("Time (hours)") order=(0 to 3 by 1);
symbol1 value=dot i=j color=black line=1;
proc gplot data=summary;
    plot p*time/frame vaxis=axis1 haxis=axis2 vref=0.05 lvref=34;
    run;

/* Program 2.7, Page 88         */        

proc sort data=summary;
    by descending time;
data rejcount;
    set summary nobs=m;
    retain index 1 minlower 100;     
    if lower>0 and index=_n_ then index=_n_+1;
    if lower<minlower then minlower=lower;
    keep index minlower;
    if _n_=m;
data adjci;
    set summary nobs=m;
    if _n_=1 then set rejcount;
    if index=m+1 then adjlower=minlower;
    if index<=m and _n_<=index then adjlower=min(lower,0);
axis1 minor=none label=(angle=90 "Treatment difference (L)")
    order=(-0.2 to 0.5 by 0.1);
axis2 minor=none label=("Time (hours)") order=(0 to 3 by 1);
symbol1 value=none i=j color=black line=1;
symbol2 value=none i=j color=black line=20;
proc gplot data=adjci;
    plot meandif*time lower*time/overlay frame vaxis=axis1 haxis=axis2 
    vref=0 lvref=34;
    run;
axis1 minor=none label=(angle=90 "Treatment difference (L)")
    order=(-0.2 to 0.5 by 0.1);
axis2 minor=none label=("Time (hours)") order=(0 to 3 by 1);
symbol1 value=none i=j color=black line=1;
symbol2 value=none i=j color=black line=20;
proc gplot data=adjci;
    plot meandif*time adjlower*time/overlay frame vaxis=axis1 haxis=axis2 
    vref=0 lvref=34;
    run;

/* Program 2.8, Page 91         */        
data colitis;
    do dose="Dose 0", "Dose 1", "Dose 2", "Dose 3";
        do patient=1 to 12;
            input reduct @@; output;
        end;
    end;
    datalines;
    -2 -1 -1 -1 0 0 0 0 0 2 4  5
    -1  0  1  1 1 2 3 3 3 4 7  9
     1  2  2  3 3 3 3 3 4 6 8  8
     1  4  5  5 6 7 7 7 8 8 11 12
      ;
proc multtest data=colitis bootstrap stepboot seed=47292 n=10000;
    class dose;
    test mean(reduct);
    contrast "Dose 0 vs Dose 1" 1 -1 0 0;
    contrast "Dose 0 vs Dose 2" 1 0 -1 0;
    contrast "Dose 0 vs Dose 3" 1 0 0 -1;
    run;

/* Program 2.9, Page 92         */        

data trouble;
    input group outcome count @@;
    datalines;
    1 0 4    1 1 0    2 0 1    2 1 3    3 0 3    3 1 1
    ;
proc multtest data=trouble stepboot seed=443 n=20000;
    title "Adjustment based on the Fisher exact test";
    class group;
    freq count;
    test fisher(outcome/lower);
    contrast "1 vs 2" 1 -1 0;
    contrast "1 vs 3" 1  0 -1;
    contrast "2 vs 3" 0  1 -1;
proc multtest data=trouble stepboot seed=443 n=20000;
    title "Adjustment based on the Freeman-Tukey test";
    class group;
    freq count;
    test ft(outcome/lower);
    contrast "1 vs 2" 1 -1 0;
    contrast "1 vs 3" 1  0 -1;
    contrast "2 vs 3" 0  1 -1;
    run;

/* Program 2.10, Page 95         */       

data ra;
    input group $ sjc tjc pta pha @@;
    datalines;
    Placebo   -5  -9  -14  -21 Placebo   -3  -7   -5  -25
    Placebo   -7  -4  -28  -15 Placebo   -3   0  -17   -6
    Placebo   -4  -1   -5    5 Placebo    0   5   -8  -11
    Placebo   -3   1   15    0 Placebo    2   6   15   27
    Placebo   -1  -4  -11   -8 Placebo    0   1    8   12
    Placebo    2  -2    6   -9 Placebo    8   2   11   33
    Therapy   -7  -1  -21   -9 Therapy   -6 -11  -36  -12
    Therapy   -3  -7  -14  -21 Therapy   -4   2   10  -10
    Therapy  -11  -4  -28  -45 Therapy   -4  -1  -11  -23
    Therapy   -3  -1   -7  -15 Therapy   -5  -9  -36  -15
    Therapy   -4  -9  -35  -32 Therapy  -11 -10  -47  -31
    Therapy    3  -1    6   17 Therapy   -1  -9   -5  -27
    ;

/* Program 2.11, Page 96         */       

ods listing close;
proc ttest data=ra;
    class group;
    var sjc tjc pta pha;
    ods output ttests=ttest(where=(method="Pooled"));
proc print data=ttest noobs label;
    ods listing;
    run;

/* Program 2.12, Page 98         */       

%GlobTest(dataset=ra,group=group,ngroups=2,varlist=sjc tjc pta pha,
    test="OLS");

/* Program 2.13, Page 99         */       

%GlobTest(dataset=ra,group=group,ngroups=2,varlist=sjc tjc pta pha,
    test="GLS");
%GlobTest(dataset=ra,group=group,ngroups=2,varlist=sjc tjc pta pha,
    test="MGLS");

/* Program 2.14, Page 100         */      

%GlobTest(dataset=ra,group=group,ngroups=2,varlist=sjc tjc pta pha,
    test="RS");

/* Program 2.15, Page 101         */       

proc multtest data=ra stepboot n=10000 seed=57283;
    class group;
    test mean(sjc tjc pta pha);
    contrast "Treatment effect" 1 -1;
    run;

/* Program 2.16, Page 102         */       

%let varname=sjc tjc pta pha;
data hyp;
    length varlist $50;
    array h{*} h1-h4;
    do i=15 to 1 by -1;
        string=put(i,binary4.);
        hypnum=16-i;
        do j=1 to 4;
            h{j}=substr(string,j,1);
        end;
        varlist=" ";
        do j=1 to 4;
            if h{j}=1 then varlist=
            trim(varlist) || " " || scan("&varname",j);
        end;
    output;
    end;
    keep hypnum h1-h4 varlist;
data pvalcomb;
%macro pval;
    %do j=1 %to 15;
    data _null_;
        set hyp;
        if hypnum=&j then call symput("varlist",trim(varlist));
        run;				
        %GlobTest(ra,group,2,&varlist,"OLS");
    data pvalcomb;
        set pvalcomb pval;
        keep adjp;
        run;
    %end;
%mend pval;

%pval;

data decrule;
    merge hyp pvalcomb(where=(adjp^=.));
    array h{*} h1-h4;
    array hyp{*} hyp1-hyp4;
    do i=1 to 4;
        hyp{i}=adjp*h{i};
    end;
    keep hyp1-hyp4;
proc means data=decrule noprint;
    var hyp1-hyp4;
    output out=indadjp(keep=adjp1-adjp4)
    max(hyp1-hyp4)=adjp1-adjp4;
data indadjp;
    set indadjp;
    format adjp1-adjp4 6.4;
proc print data=indadjp noobs;
    title "Adjusted p-values for individual hypotheses";
    run;

/* Program 2.17, Page 110         */      

data example1;
    input hyp $ family serial weight relimp raw_p;
    datalines;
    H11 1 1 1   0 0.046
    H21 2 1 0.5 0 0.048
    H22 2 1 0.5 0 0.021	
    ;

%GateKeeper(dataset=example1,test="B",outdata=out1);

axis1 minor=none order=(0 to 0.06 by 0.02) label=(angle=90 "P-value");
axis2 minor=none label=("Hypothesis") order=("H11" "H21" "H22");
symbol1 value=circle color=black i=j;
symbol2 value=triangle color=black i=j;
proc gplot data=out1;
    plot raw_p*hyp adjp*hyp/frame overlay nolegend haxis=axis2 vaxis=axis1
        vref=0.05 lvref=34;
    run;

/* Program 2.18, Page 113         */      

data example2a;
    input hyp $ family serial weight relimp raw_p @@;
    datalines;
    H11 1 0 0.9 0 0.024   H12 1 0 0.1 0 0.002
    H21 2 1 0.5 0 0.010   H22 2 1 0.5 0 0.005	
    ;
data example2b;
    input hyp $ family serial weight relimp raw_p @@;
    datalines;
    H11 1 0 0.9 0 0.024   H12 1 0 0.1 0 0.006
    H21 2 1 0.5 0 0.010   H22 2 1 0.5 0 0.005	
    ;

%GateKeeper(dataset=example2a,test="B",outdata=out2a);
%GateKeeper(dataset=example2b,test="B",outdata=out2b);

axis1 minor=none order=(0 to 0.06 by 0.02) label=(angle=90 "P-value");
axis2 minor=none label=("Hypothesis") order=("H11" "H12" "H21" "H22");
symbol1 value=circle color=black i=j;
symbol2 value=triangle color=black i=j;
proc gplot data=out2a;
    plot raw_p*hyp adjp*hyp/frame overlay nolegend haxis=axis2 vaxis=axis1
        vref=0.05 lvref=34;
    run;
proc gplot data=out2b;
    plot raw_p*hyp adjp*hyp/frame overlay nolegend haxis=axis2 vaxis=axis1
        vref=0.05 lvref=34;
    run;

/* Program 2.19, Page 114         */      

%GateKeeper(dataset=example2a,test="MB",outdata=out2a);
%GateKeeper(dataset=example2b,test="MB",outdata=out2b);

axis1 minor=none order=(0 to 0.06 by 0.02) label=(angle=90 "P-value");
axis2 minor=none label=("Hypothesis") order=("H11" "H12" "H21" "H22");
symbol1 value=circle color=black i=j;
symbol2 value=triangle color=black i=j;
proc gplot data=out2a;
    plot raw_p*hyp adjp*hyp/frame overlay nolegend haxis=axis2 vaxis=axis1
        vref=0.05 lvref=34;
    run;
proc gplot data=out2b;
    plot raw_p*hyp adjp*hyp/frame overlay nolegend haxis=axis2 vaxis=axis1
        vref=0.05 lvref=34;
    run;

/* Program 2.20, Page 117         */      

data example2c;
    set example2a;
    if family=1 then relimp=0.9;
data example2d;
    set example2b;
    if family=1 then relimp=0.9;

%GateKeeper(dataset=example2c,test="B",outdata=out2c);
%GateKeeper(dataset=example2d,test="B",outdata=out2d);

axis1 minor=none order=(0 to 0.06 by 0.02) label=(angle=90 "P-value");
axis2 minor=none label=("Hypothesis") order=("H11" "H12" "H21" "H22");
symbol1 value=circle color=black i=j;
symbol2 value=triangle color=black i=j;
proc gplot data=out2c;
    plot raw_p*hyp adjp*hyp/frame overlay nolegend haxis=axis2 vaxis=axis1
        vref=0.05 lvref=34;
    run;
proc gplot data=out2d;
    plot raw_p*hyp adjp*hyp/frame overlay nolegend haxis=axis2 vaxis=axis1
        vref=0.05 lvref=34;
    run;

/* Program 2.21, Page 118         */      

data dftrial(drop=dose0-dose4);
    array dose{*} dose0-dose4;    
    input dose0-dose4 @@;
    do group=0 to 4;
        change=dose{group+1};
        if change^=. then output;
    end;
    datalines;
    -7.5 -4.8  0.9  1.9 19.3 -6.2  -0.9 -3.2 13.7 -5.9
    17.5 10.6 18.6  4.4  7.9  8.7 -10.2  5.6  5.8 -1.2
     5.6 -3.2  6.6  8.1 -0.3  1.3  -5.1  4.6  2.2 10.3
    -6.1  3.6  7.6  8.2  3.3 -2.0   3.5  6.0 -3.2 14.0
    -6.8 13.3 12.2 19.4 15.0  4.0   9.5  9.8  0.5  5.3
    -1.5 -2.9  5.9 -7.6 11.6 -2.9 -13.3 -7.7 12.1  0.1
     0.0  2.0 -3.0  0.0  3.9  0.6   2.1 15.6  9.8 11.2
     3.5  7.3  3.9 -6.6 11.1 -6.3  -5.5 13.8 23.1  4.0
    10.7  0.3 12.0 11.8  4.8  0.5   3.6  2.8  2.3 16.1
    -1.1 13.2  5.3  0.7  7.6  2.1   0.3  5.0 12.1  3.3
    12.5  2.6 -3.0  1.4  9.5 -5.2  -8.7  2.4 14.5 -0.5
    -9.8 -7.4 -2.6  0.1 12.8  4.8    .   7.9   .   9.9
     1.2 -9.7  4.0  0.4 13.7   .     .   5.6   .   3.8
    ;
proc multtest data=dftrial;
    class group;
    test mean(change);
    ods output continuous=doseresp;
axis1 minor=none order=(0 to 10 by 5) label=(angle=90 "Mean reduction (mmHg)");
axis2 minor=none value=("P" "D1" "D2" "D3" "D4") label=("Treatment group");    
symbol1 value=dot color=black i=j;
proc gplot data=doseresp;
    plot mean*group/frame haxis=axis2 vaxis=axis1;
    run;

/* Program 2.22, Page 119         */      

proc multtest data=dftrial;
    class group;
    test mean(change);
    contrast "H11" -1 0 0 0 1;
    contrast "H12" -1 0 0 1 0;
    contrast "H21" -1 0 1 0 0;
    contrast "H22" -1 1 0 0 0;
    contrast "H31" 0 -1 0 0 1;
    contrast "H32" 0 0 -1 0 1;        
    contrast "H33" 0 -1 0 1 0;    
    contrast "H34" 0 0 -1 1 0;
    ods output pvalues=pval;
data seqfam;
    set pval;
    relimp=0; raw_p=raw;
    if contrast in ("H11","H12") then
        do; family=1; serial=0; weight=0.5; end;  
    if contrast in ("H21","H22") then
        do; family=2; serial=0; weight=0.5; end;
    if contrast in ("H31","H32","H33","H34") then
        do; family=3; serial=1; weight=0.25; end;
    keep contrast family serial weight relimp raw_p;

%GateKeeper(dataset=seqfam,test="B",outdata=out);

proc multtest pdata=seqfam noprint hommel out=hommel;

symbol1 value=circle color=black i=none;
symbol2 value=triangle color=black i=none;
axis1 minor=none order=(0 to 0.1 by 0.05) label=(angle=90 "P-value");
axis2 label=("Hypothesis")
    order=("H11" "H12" "H21" "H22" "H31" "H32" "H33" "H34");
proc gplot data=out;
    plot raw_p*contrast adjp*contrast/frame overlay
    haxis=axis2 vaxis=axis1 vref=0.05 lvref=34;
    run;
proc gplot data=hommel;
    plot raw_p*contrast hom_p*contrast/frame overlay
    haxis=axis2 vaxis=axis1 vref=0.05 lvref=34;
    run;

/* Program 2.23, Page 121         */      

%GateKeeper(dataset=seqfam,test="S",outdata=out);

symbol1 value=circle color=black i=none;
symbol2 value=triangle color=black i=none;
axis1 minor=none order=(0 to 0.1 by 0.05) label=(angle=90 "P-value");
axis2 label=("Hypothesis")
    order=("H11" "H12" "H21" "H22" "H31" "H32" "H33" "H34");
proc gplot data=out;
    plot raw_p*contrast adjp*contrast/frame overlay
    haxis=axis2 vaxis=axis1 vref=0.05 lvref=34;
    run;

/* Program 2.24, Page 122         */      

%let contrasts=%str(
    contrast "H11" -1 0 0 0 1;
    contrast "H12" -1 0 0 1 0;
    contrast "H21" -1 0 1 0 0;
    contrast "H22" -1 1 0 0 0;
    contrast "H31" 0 -1 0 0 1;
    contrast "H32" 0 0 -1 0 1;
    contrast "H33" 0 -1 0 1 0;
    contrast "H34" 0 0 -1 1 0;
    );

%macro resam(n);
    data resam;
    proc transpose data=pval out=raw_p prefix=p;
        var raw;
    %do i=1 %to &n;
    proc multtest data=dftrial noprint bootstrap n=1 seed=388&i
        outsamp=resdata;
        class group;
        test mean(change);
        &contrasts;
    proc multtest data=resdata noprint out=p;
        class _class_;
        test mean(change);
        &contrasts;               
    proc transpose data=p out=boot_p prefix=p;
        var raw_p;
    data resam;
        set resam boot_p;
        run;
    %end;
    data resam;
        set resam; if p1^=.;
%mend resam;

%resam(20000);

%ResamGate(dataset=seqfam,resp=resam,test="B",outdata=out1);
%ResamGate(dataset=seqfam,resp=resam,test="S",outdata=out2);

symbol1 value=circle color=black i=none;
symbol2 value=triangle color=black i=none;
axis1 minor=none order=(0 to 0.1 by 0.05) label=(angle=90 "P-value");
axis2 label=("Hypothesis")
    order=("H11" "H12" "H21" "H22" "H31" "H32" "H33" "H34");
proc gplot data=out1;
    plot raw_p*contrast adjp*contrast/frame overlay
    haxis=axis2 vaxis=axis1 vref=0.05 lvref=34;
    run;
proc gplot data=out2;
    plot raw_p*contrast adjp*contrast/frame overlay
    haxis=axis2 vaxis=axis1 vref=0.05 lvref=34;
    run;

/* Program 3.1, Page 131         */       

data qtc;
    length x 6.4;
    do id=1 to 3000;
        x=input(10+50*ranuni(343+23*id),6.4);
        if x<=20 then mean=-0.5*(x-10)+415; else mean=x+390;
        sigma=mean/20;
        upper=mean+probit(0.9)*sigma;
        y=mean+sigma*normal(623+84*id);
        output;
    end;
    run;

/* Program 3.2, Page 132         */       

proc univariate data=qtc noprint;
    var y;
    output out=quantile pctlpts=10, 90 pctlpre=quantile;
proc print data=quantile noobs label;
    run;

/* Program 3.3, Page 133         */       

data age1 age2 age3 age4;
    set qtc;
    if x<22.5 then output age1;
    if 22.5<=x<35 then output age2;
    if 35<=x<47.5 then output age3;
    if 47.5<=x then output age4;

%macro DistPlot(dataset,label);
    proc univariate data=&dataset noprint;		
        histogram y/outhist=hist;	
    axis1 minor=none major=none value=none label=none 
        order=(0 to 25 by 5);
    axis2 minor=none label=("QTc interval (msec)") 
        order=(350 to 510 by 40);
    symbol1 value=none i=j;
    data annotate;
        xsys="1"; ysys="1"; hsys="4"; x=50; y=90; position="5";  
        size=1; text="&label"; function="label";
    proc gplot data=hist anno=annotate;
        plot _obspct_*_midpt_/haxis=axis2 vaxis=axis1 
            href=394.292, 458.076 lhref=34;
        run;
        quit;
%mend DistPlot;

%DistPlot(age1,Age<22.5);
%DistPlot(age2,22.5<=Age<35);
%DistPlot(age3,35<=Age<47.5);
%DistPlot(age4,47.5<=Age);

/* Program 3.4, Page 135         */       

%TolLimit(dataset=qtc,var=y,gamma=0.9,beta=0.95,outdata=tollimit);
proc print data=tollimit noobs label;
    run;

/* Program 3.5, Page 138         */       

proc means data=qtc noprint;
    var y;
    output out=initial mean=mean;
data _null_;
    set initial;
    call symput("initial",mean);
proc nlin data=qtc nohalve converge=0.001;
    ods select EstSummary ParameterEstimates;
    parms quantile=&initial;
    model y=quantile;
    der.quantile=1; resid=y-model.y;
    if resid>0 then _weight_=0.9/resid;
    if resid<0 then _weight_=-0.1/resid;
    if resid=0 then _weight_=0;
    run;

/* Program 3.6, Page 140         */       

ods listing close;
data grid100;
    do i=0 to 100;
        x=10+50*i/100;
        output;
    end;

%GlobalQSmooth(dataset=qtc,grid=grid100,gamma=0.9,p=2,
    outdata=poly2);
%GlobalQSmooth(dataset=qtc,grid=grid100,gamma=0.9,p=10,
    outdata=poly10);

data comb; 
    set qtc(in=in1) poly2(in=in2) poly10(in=in3);
    group=in1+2*in2+3*in3;
    if (in1) then y=upper; else y=poly;		 
    keep y x group;
axis1 minor=none label=(angle=90 "QTc interval (msec)") 
    order=(420 to 480 by 20);
axis2 minor=none label=("Age (years)") order=(10 to 60 by 10);
symbol1 value=none color=black i=join line=1;
symbol2 value=none color=black i=join line=20;
symbol3 value=none color=black i=join line=34;
ods listing;
proc gplot data=comb;
    plot y*x=group/frame nolegend haxis=axis2 vaxis=axis1;
    run;

/* Program 3.7, Page 142         */       

ods listing close;
%macro cp(dataset,gamma,pmax);
    data comb;
    %do j=&pmax %to 1 %by -1;

    %GlobalQSmooth(dataset=&dataset,grid=&dataset,gamma=&gamma,p=&j,
    outdata=poly);

    data res;
        set poly;
        res=0.5*(abs(y-poly)+2*(&gamma-1)*(y-poly));
        keep res;
    proc means data=res noprint;
        var res;
        output out=cp sum(res)=s;
    data _null_;
        set cp;
        if &j=&pmax then call symput("smax",s);
    data _null_;
        set &dataset nobs=m;
        call symput("n",m);
        run;
    data cp;
        set cp;
        degree=&j;
        smax=&smax/(&n-&pmax-1);
        cp=s/smax-&n+2*(&j+1);
        keep s cp degree;
    data comb;
        set comb cp;
        run;
    %end;
%mend cp;

%cp(dataset=qtc,gamma=0.9,pmax=10);

axis1 minor=none label=(angle=90 "S(p)") order=(50000 to 52000 by 1000);
axis2 minor=none label=("Degree (p)") order=(1 to 10 by 1);
symbol1 value=dot color=black i=none;
proc gplot data=comb;
    plot s*degree/frame nolegend haxis=axis2 vaxis=axis1;
    run;
axis1 minor=none label=(angle=90 "Cp") order=(0 to 100 by 50);
axis2 minor=none label=("Degree (p)") order=(1 to 10 by 1);
symbol1 value=dot color=black i=none;
ods listing;
proc gplot data=comb;
    plot cp*degree/frame nolegend haxis=axis2 vaxis=axis1;
    run;

/* Program 3.8, Page 145         */       

ods listing close;
data grid50;
    do i=0 to 50;
        x=10+50*i/50;
        output;
    end;
data grid500;
    do i=0 to 500;
        x=10+50*i/500;
        output;
    end;

%GlobalQSmooth(dataset=qtc,grid=grid50,gamma=0.9,p=6,outdata=poly6a);
%GlobalQSmooth(dataset=qtc,grid=grid500,gamma=0.9,p=6,outdata=poly6b);

* Bandwidth=2;
data initial1;
    set poly6a;
    h=2;

%LocalQSmooth(dataset=qtc,gamma=0.9,initial=initial1,outdata=loc1);

* Bandwidth=2;
data initial2;
    set poly6b;
    h=2;

%LocalQSmooth(dataset=qtc,gamma=0.9,initial=initial2,outdata=loc2);

* Bandwidth=4;
data initial3;
    set poly6a;
    h=4;

%LocalQSmooth(dataset=qtc,gamma=0.9,initial=initial3,outdata=loc3);

* Bandwidth=4;
data initial4;
    set poly6b;
    h=4;

%LocalQSmooth(dataset=qtc,gamma=0.9,initial=initial4,outdata=loc4);

ods listing;

* Plot the reference limits;
%macro QPlot(dataset,label1,label2);
axis1 minor=none label=(angle=90 "QTc interval (msec)") 
    order=(420 to 480 by 20);
axis2 minor=none label=("Age (years)") order=(10 to 60 by 10);
symbol1 value=none color=black i=join line=1;
data temp;
    set &dataset;
    format estimate 3.0 x 3.0;
proc sort data=temp; 
    by x;
data annotate;
    length text $50;
    xsys="1"; ysys="1"; hsys="4"; x=50; y=16; position="5";  
    size=0.8; text="&label1"; function="label"; output;
    xsys="1"; ysys="1"; hsys="4"; x=50; y=8; position="5";  
    size=0.8; text="&label2"; function="label"; output;
proc gplot data=temp anno=annotate;
    plot estimate*x/frame haxis=axis2 vaxis=axis1;
    run;
    quit;
%mend QPlot;

ods listing;

%QPlot(dataset=loc1,label1=Bandwidth=2,label2=50 grid points);
%QPlot(dataset=loc2,label1=Bandwidth=2,label2=500 grid points);
%QPlot(dataset=loc3,label1=Bandwidth=4,label2=50 grid points);
%QPlot(dataset=loc4,label1=Bandwidth=4,label2=500 grid points);

/* Program 3.9, Page 149         */       

ods listing close;
%macro bandwidth(dataset,gamma,p,outdata);
    data _null_;
        set &dataset nobs=m;
        call symput("n",m);
        run;

    %GlobalQSmooth(dataset=&dataset,grid=grid100,gamma=&gamma,
    p=&p,outdata=q1);
    %GlobalQSmooth(dataset=&dataset,grid=grid100,gamma=probnorm(1),
    p=&p,outdata=q2);
    %GlobalQSmooth(dataset=&dataset,grid=grid100,gamma=0.5,
    p=&p,outdata=q3);

    data q1;
        set q1;
        keep x secder;
    data q2;
        set q2;
        qprob1=poly;
        keep x qprob1;
    data q3;
        set q3;
        median=poly;
        keep x median;
    proc kde data=&dataset ngrid=101 gridl=10 gridu=60 out=margdens;
        var x;
    proc sort data=margdens;
        by x;
    data comb;
        merge q1 q2 q3 margdens;				
        by x;
    data &outdata;
        set comb;
        dens=pdf("normal",probit(&gamma))/(qprob1-median);
        denom=3.546*&n*density*secder*secder*dens*dens;
        h=(&gamma*(1-&gamma)/denom)**0.2;
%mend bandwidth;

data grid100;
    do i=0 to 100;
        x=10+50*i/100;
        output;
    end;

%bandwidth(dataset=qtc,gamma=0.9,p=6,outdata=h6);
%bandwidth(dataset=qtc,gamma=0.9,p=10,outdata=h10);
axis1 minor=none label=(angle=90 "Bandwidth") order=(0 to 20 by 5);
axis2 minor=none label=("Age (years)") order=(10 to 60 by 10);
symbol1 value=none color=black i=join line=1;
ods listing close;
proc gplot data=h6;
    plot h*x;
    run;
proc gplot data=h10;
    plot h*x;
    run;

/* Program 3.10, Page 151         */      

data qtcconc1;
    set qtcconc;
    y=qtcchange;
    x=conc;    
    keep x y;
axis1 minor=none order=(-40 to 40 by 20) label=(angle=90 "Change in QTc (msec)");
axis2 minor=none order=(0 to 6 by 1) label=("Log plasma drug concentration");
symbol1 value=dot color=black i=rlcli90;
proc gplot data=qtcconc1;
    plot y*x/frame overlay haxis=axis2 vaxis=axis1;
    run;

/* Program 3.11, Page 152         */      

proc loess data=qtcconc1;
    model y=x;
    ods output outputstatistics=smooth;
data smooth;
    set smooth;
    format x 3.0 depvar pred 5.1;
axis1 minor=none order=(-40 to 40 by 20) label=(angle=90 "Change in QTc (msec)");
axis2 minor=none order=(0 to 6 by 1) label=("Log plasma drug concentration");
symbol1 value=dot color=black i=rl line=1;
symbol2 value=none i=j line=20;
proc gplot data=smooth;
    plot depvar*x pred*x/frame haxis = axis2 vaxis = axis1 overlay;
    run;

/* Program 3.12, Page 153         */      

ods listing close;
data grid20;
    do i=0 to 20;
        x=6*i/20;
        output;
    end; 

%VarPlot(dataset=qtcconc1,grid=grid20,q1=0.1,q2=0.5,q3=0.9,
    h=1,outdata=qtcsmooth);

data temp;
    set qtcsmooth;
    format estimate 3.0 x 3.0;
axis1 minor=none order=(-40 to 40 by 20) label=(angle=90 "Change in QTc (msec)");
axis2 minor=none order=(0 to 6 by 1) label=("Log plasma drug concentration");
symbol1 value=dot color=black i=none;
symbol2 value=none color=black i=join line=20;
symbol3 value=none color=black i=join line=1;
symbol4 value=none color=black i=join line=20;
ods listing;
proc gplot data=temp;
    plot estimate*x=quantile/nolegend frame haxis=axis2 vaxis=axis1;
    run;

/* Program 3.13, Page 155         */      

ods listing close;
data tender;
    set racount;
    y=ptpain;
    x=tjcount;    
    keep x y;
data swollen;
    set racount;
    y=ptpain;
    x=sjcount;    
    keep x y;
data grid20;
    do i=0 to 20;
        x=30*i/20;
    output;
    end; 

%VarPlot(dataset=tender,grid=grid20,q1=0.1,q2=0.5,q3=0.9,
    h=4,outdata=tsmooth);

data temp;
    set tsmooth;
    format estimate 3.0 x 3.0;
axis1 minor=none order=(0 to 100 by 20) 
    label=(angle=90 "Pain assessment (mm)");
axis2 minor=none order=(3 to 28 by 5) label=("Tender joint count");
symbol1 value=dot color=black i=none;
symbol2 value=none color=black i=join line=20;
symbol3 value=none color=black i=join line=1;
symbol4 value=none color=black i=join line=20;
proc gplot data=temp;
    plot estimate*x=quantile/nolegend frame haxis=axis2 vaxis=axis1;
    run;

%VarPlot(dataset=swollen,grid=grid20,q1=0.1,q2=0.5,q3=0.9,
    h=4,outdata=ssmooth);

data temp;
    set ssmooth;
    format estimate 3.0 x 3.0;
axis1 minor=none order=(0 to 100 by 20) 
    label=(angle=90 "Pain assessment (mm)");
axis2 minor=none order=(3 to 28 by 5) label=("Swollen joint count");
symbol1 value=dot color=black i=none;
symbol2 value=none color=black i=join line=20;
symbol3 value=none color=black i=join line=1;
symbol4 value=none color=black i=join line=20;
ods listing;
proc gplot data=temp;
    plot estimate*x=quantile/nolegend frame haxis=axis2 vaxis=axis1;
    run;

/* Program 3.14, Page 159         */      

data ast;
    input therapy $ baseline endpoint count @@;
    datalines;
    Placebo 0 0 34 Placebo 1 0 2 Placebo 0 1 1 Placebo 1 1 3
    Drug    0 0 30 Drug    1 0 1 Drug    0 1 7 Drug    1 1 1
    ;
data ast1;
    set ast;
    do i=1 to count;
        if therapy="Placebo" then group=1; else group=0;
        subject=10000*group+1000*baseline+100*endpoint+i;
        outcome=baseline; time=0; output;
        outcome=endpoint; time=1; output;
    end;
proc genmod data=ast1 descending; 
    ods select GEEEmpPEst Type3;
    class subject group time;
    model outcome=group|time/link=logit dist=bin type3;
    repeated subject=subject/type=unstr;
    run;

/* Programs on Page 161         */        

proc genmod data=temp descending;         
    class subject group time;
    model outcome=group time group*time/link=logit dist=bin type3;
    repeated subject=subject/type=unstr;    
    lsmeans time*group;
    ods output LSMeans=LogOdds;    
data odds;
    set LogOdds;
    LogOdds=estimate;
    Odds=exp(estimate);
    keep group time Odds LogOdds;
proc print data=odds noobs;
    run;

/* Program 3.15, Page 162         */      

data modast;
    input therapy $ baseline endpoint count @@;
    datalines;
    Placebo 0 0 34 Placebo 1 0 0 Placebo 0 1 0 Placebo 1 1 3
    Drug    0 0 30 Drug    1 0 0 Drug    0 1 7 Drug    1 1 1
    ;
data modast1;
    set modast;
    do i=1 to count;
        if therapy="Placebo" then group=1; else group=0;
        subject=10000*group+1000*baseline+100*endpoint+i;
        outcome=baseline; time=0; output;
        outcome=endpoint; time=1; output;
    end;
proc genmod data=modast1 descending; 
    ods select GEEEmpPEst Type3;
    class subject group time;
    model outcome=group time group*time/link=logit dist=bin type3;
    repeated subject=subject/type=unstr;
    run;

/* Program 3.16, Page 165         */      

data qtcprol;
    input therapy $ baseline endpoint count @@;
    datalines;
    Placebo 0 0 50 Placebo 1 0  1 Placebo 2 0  0
    Placebo 0 1  3 Placebo 1 1  7 Placebo 2 1  1
    Placebo 0 2  0 Placebo 1 2  1 Placebo 2 2  0
    Drug    0 0 42 Drug    1 0  1 Drug    2 0  0
    Drug    0 1 11 Drug    1 1  5 Drug    2 1  1
    Drug    0 2  0 Drug    1 2  0 Drug    2 2  0
    ;
data qtcprol1;
    set qtcprol;
    do i=1 to count;
        if therapy="Placebo" then group=1; else group=0;
        subject=10000*group+1000*baseline+100*endpoint+i;
        outcome=baseline; time=0; output;
        outcome=endpoint; time=1; output;
    end;
proc genmod data=qtcprol1 descending;
    ods select GEEEmpPEst Type3;
    class subject group time;
    model outcome=group time group*time/link=cumlogit dist=multinomial 
    type3;
    repeated subject=subject/type=ind;
    run;

/* Program 3.17, Page 167         */      

data ast2;
    set ast;
    do i=1 to count;
        if therapy="Placebo" then gr=1; else gr=0;
        subject=10000*gr+1000*baseline+100*endpoint+i;     
        outcome=baseline; tm=0; int=tm*gr; output;
        outcome=endpoint; tm=1; int=tm*gr; output;
    end;
proc nlmixed data=ast2 qpoints=50;
    ods select ParameterEstimates;
    parms intercept=-2.2 group=0.8 time=0.3 interaction=-1.8 sigmasq=1;
    logit=intercept+group*gr+time*tm+interaction*int+se;
    p=exp(logit)/(1+exp(logit));
    model outcome~binary(p);
    random se~normal(0,sigmasq) subject=subject;
    run;

/* Program 3.18, Page 170         */      

proc nlmixed data=ast2 qpoints=50;
    parms intercept=-2.2 group=0.8 time=0.3 interaction=-1.8 sigmasq=1;
    logit=intercept+group*gr+time*tm+interaction*int+se;        
    p0=1/(1+exp(logit));
    p1=exp(logit)/(1+exp(logit));    
    if outcome=0 then logp=log(p0);     
    if outcome=1 then logp=log(p1);     
    model outcome~general(logp);
    random se~normal(0,sigmasq) subject=subject;
    run;

/* Program 3.19, Page 171         */      

data qtcprol1;
    set qtcprol;
    do i=1 to count;
        if therapy="Placebo" then gr=1; else gr=0;
        subject=10000*gr+1000*baseline+100*endpoint+i; 
        outcome=baseline; tm=0; int=tm*gr; output;
        outcome=endpoint; tm=1; int=tm*gr; output;
    end;
proc nlmixed data=qtcprol1 qpoints=50;
    ods select ParameterEstimates;
    parms intercept1=-4.4 intercept2=-1.4 group=0.5 time=-0.2 
        interaction=-0.8 sigmasq=1;    
    logit1=intercept1+group*gr+time*tm+interaction*int+se;
    logit2=intercept2+group*gr+time*tm+interaction*int+se;
    p0=1/(1+exp(logit2));
    p1=exp(logit2)/(1+exp(logit2))-exp(logit1)/(1+exp(logit1));    
    p2=exp(logit1)/(1+exp(logit1));
    if outcome=0 then logp=log(p0);     
    if outcome=1 then logp=log(p1); 
    if outcome=2 then logp=log(p2);      
    model outcome~general(logp);
    random se~normal(0,sigmasq) subject=subject;
    run;

/* Program 3.20, Page 174         */      

data ecgeval;
    input therapy $ baseline endpoint count @@;
    datalines;
    DrugA 0 0 83 DrugA 1 0 1 DrugA 0 1 1 DrugA 1 1 18
    DrugB 0 0 80 DrugB 1 0 8 DrugB 0 1 7 DrugB 1 1  7
    ;
data transform;
    set ecgeval;
    if baseline+endpoint^=1 then change="Same";
    if baseline=0 and endpoint=1 then change="Up";
    if baseline=1 and endpoint=0 then change="Down";
proc sort data=transform;
    by therapy change;
proc means data=transform noprint;
    by therapy change;
    var count;
    output out=sum sum=sum;
data estimate;
    set sum;
    by therapy;
    retain nminus nzero nplus; 
    if change="Same" then nzero=sum;
    if change="Up" then nplus=sum;
    if change="Down" then nminus=sum; 
    alpha=(nminus+nplus)/(nminus+nzero+nplus);	
    if nminus+nplus>0 then beta=nplus/(nminus+nplus); else beta=1;
    if last.therapy=1;
    keep therapy beta alpha; 
proc print data=estimate noobs;
proc freq data=sum;
    ods select LRChiSq;
    table therapy*change;
    exact lrchi;
    weight sum;
    run;

/* Program 4.1, Page 187         */       

data DepTrial;
    input fraction @@;
    datalines;
    0.50 0.75 1
    ;
%EffDesign(fraction=DepTrial,effsize=0.375,power=0.9,alpha=0.025,
    rho=0,boundary=OFBoundary,sizepower=OFPower);
proc print data=OFBoundary noobs label;
    var Analysis Size TestStBoundary PValBoundary;
proc print data=OFBoundary noobs label;
    var Analysis ProbH0 CumProbH0 ProbH1 CumProbH1;
* Stopping boundary on a test statistic scale;
axis1 minor=none label=(angle=90 "Test statistic") order=(1 to 3 by 1);
axis2 minor=none label=("Sample size per group") order=(0 to 200 by 50);
symbol1 value=dot color=black i=join line=1;
symbol2 value=circle color=black i=none;
data plot1;
    set OFBoundary;
    format TestStBoundary 1.0;
    group=1;
data plot2;
    size=150; TestStBoundary=1.96; group=2; 
data plot;
    set plot1 plot2;
proc gplot data=plot;
    plot TestStBoundary*Size=group/frame nolegend haxis=axis2 vaxis=axis1;
    run;
* Stopping boundary on a p-value scale;
axis1 minor=none label=(angle=90 "P-value") order=(0 to 0.03 by 0.01);
axis2 minor=none label=("Sample size per group") order=(0 to 200 by 50);
symbol1 value=dot color=black i=join line=1;
symbol2 value=circle color=black i=none;
data plot1;
    set OFBoundary;
    format PValBoundary 4.2;
    group=1;
data plot2;
    size=150; PValBoundary=0.025; group=2; 
data plot;
    set plot1 plot2;
proc gplot data=plot;
    plot PValBoundary*Size=group/frame nolegend haxis=axis2 vaxis=axis1;
    run;
* Power function;
axis1 minor=none label=(angle=90 "Power") order=(0 to 1 by 0.2);
axis2 minor=none label=("True effect size") order=(0 to 0.6 by 0.1);
symbol1 value=none color=black i=join line=1;
symbol2 value=none color=black i=join line=34;
data plot;
    set OFPower;
    format Power FixedSamplePower 3.1;
    FixedSampleSize=150;
    alpha=0.025;
    FixedSamplePower=probnorm(sqrt(FixedSampleSize/2)*EffSize
    -probit(1-alpha));
proc gplot data=plot;
    plot Power*EffSize FixedSamplePower*EffSize/frame overlay nolegend 
    haxis=axis2 vaxis=axis1;
    run;
* Average sample size;
axis1 minor=none label=(angle=90 "Average sample size per group") 
    order=(0 to 200 by 50);
axis2 minor=none label=("True effect size") order=(0 to 0.6 by 0.1);
symbol1 value=none color=black i=join line=1;
data plot;
    set OFPower;
    format AveSize 4.0;
proc gplot data=plot;
    plot AveSize*EffSize/frame nolegend haxis=axis2 vaxis=axis1
        vref=150 lvref=34;
    run;

/* Program 4.2, Page 192         */       

data DepTrial;
    input fraction @@;
    datalines;
    0.5 0.75 1
    ;
%EffDesign(fraction=DepTrial,effsize=0.375,power=0.9,alpha=0.025,
    rho=0.5,boundary=PBoundary,sizepower=PPower);
proc print data=PBoundary noobs label;
    var Analysis Size TestStBoundary PValBoundary;
proc print data=PBoundary noobs label;
    var Analysis ProbH0 CumProbH0 ProbH1 CumProbH1;
* Compare with the O'Brien-Fleming sequential plan;
%EffDesign(fraction=DepTrial,effsize=0.375,power=0.9,alpha=0.025,
    rho=0,boundary=OFBoundary,sizepower=OFPower);
data plot1;
    set OFBoundary; group=1;
data plot2;
    set PBoundary; group=2;
data plot3;
    set plot1 plot2;
    format TestStBoundary 1.0 PValBoundary 4.2;
* Stopping boundaries on a test statistic scale;
axis1 minor=none label=(angle=90 "Test statistic") order=(1 to 3 by 1);
axis2 minor=none label=("Sample size per group") order=(0 to 200 by 50);
symbol1 value=dot color=black i=join line=1;
symbol2 value=dot color=black i=join line=20;
proc gplot data=plot3;
    plot TestStBoundary*Size=group/frame haxis=axis2 vaxis=axis1 nolegend;
    run;
* Stopping boundaries on a p-value scale;
axis1 minor=none label=(angle=90 "P-value") order=(0 to 0.03 by 0.01);
axis2 minor=none label=("Sample size per group") order=(0 to 200 by 50);
symbol1 value=dot color=black i=join line=1;
symbol2 value=dot color=black i=join line=20;
proc gplot data=plot3;
    plot PValBoundary*Size=group/frame nolegend;
data plot1;
    set OFPower; group=1;
data plot2;
    set PPower; group=2;
data plot3;
    set plot1 plot2;
    format Power 3.1 AveSize 4.0;
    run;
* Power functions;
axis1 minor=none label=(angle=90 "Power") order=(0 to 1 by 0.2);
axis2 minor=none label=("True effect size") order=(0 to 0.6 by 0.1);
symbol1 value=none color=black i=join line=1;
symbol2 value=none color=black i=join line=20;
proc gplot data=plot3;
    plot Power*EffSize=group/frame haxis=axis2 vaxis=axis1 nolegend;
    run;
* Average sample size;
axis1 minor=none label=(angle=90 "Average sample size per group") 
    order=(0 to 200 by 50);
axis2 minor=none label=("True effect size") order=(0 to 0.6 by 0.1);
symbol1 value=none color=black i=join line=1;
symbol2 value=none color=black i=join line=20;
proc gplot data=plot3;
    plot AveSize*EffSize=group/frame haxis=axis2 vaxis=axis1 nolegend;
    run;

/* Program 4.3, Page 199         */       

data SepTrial;
    input fraction @@;
    datalines;
    0.2 0.66 1
    ;
%EffFutDesign(fraction=SepTrial,effsize=0.1352,power=0.8,alpha=0.025,
    rhoeff=0,rhofut=0.5,boundary=Boundary,sizepower=Power);
proc print data=Boundary noobs label;
    var Analysis Size LowerTestStBoundary UpperTestStBoundary 
        LowerPValBoundary UpperPValBoundary;
proc print data=Boundary noobs label;
    var Analysis ProbH0 CumProbH0 ProbH1 CumProbH1;
    run;
* Stopping boundaries on a test statistic scale;
axis1 minor=none label=(angle=90 "Test statistic") order=(0 to 5 by 1);
axis2 minor=none label=("Sample size per group") order=(0 to 1200 by 200);
symbol1 value=dot color=black i=join line=1;
symbol2 value=dot color=black i=join line=1;
symbol3 value=circle color=black i=none;
data plot1;
    set Boundary;
    boundary=LowerTestStBoundary;
    group=1;
    keep size boundary group;    
data plot2;
    set Boundary;
    boundary=UpperTestStBoundary;
    group=2;
    keep size boundary group;    
data plot3;
    size=859; boundary=1.96; group=3; 
data plot;
    format boundary 1.0;
    set plot1 plot2 plot3;
proc gplot data=plot;
    plot boundary*size=group/frame nolegend haxis=axis2 vaxis=axis1;
    run;
* Stopping boundaries on a p-value scale;
axis1 minor=none label=(angle=90 "P-value") order=(0 to 0.5 by 0.1);
axis2 minor=none label=("Sample size per group") order=(0 to 1200 by 200);
symbol1 value=dot color=black i=join line=1;
symbol2 value=dot color=black i=join line=1;
symbol3 value=circle color=black i=none;
data plot1;
    set Boundary;
    boundary=LowerPValBoundary;
    group=1;
    keep size boundary group;    
data plot2;
    set Boundary;
    boundary=UpperPValBoundary;
    group=2;
    keep size boundary group;    
data plot3;
    size=859; boundary=0.025; group=3; 
data plot;
    format boundary 3.1;
    set plot1 plot2 plot3;
proc gplot data=plot;
    plot boundary*size=group/frame nolegend haxis=axis2 vaxis=axis1;
    run;
* Power function;
axis1 minor=none label=(angle=90 "Power") order=(0 to 1 by 0.2);
axis2 minor=none label=("True effect size") order=(0 to 0.25 by 0.05);
symbol1 value=none color=black i=join line=1;
symbol2 value=none color=black i=join line=34;
data plot;
    set Power;
    format Power FixedSamplePower 3.1;
    FixedSampleSize=859; alpha=0.025;
    FixedSamplePower=probnorm(sqrt(FixedSampleSize/2)*EffSize
    -probit(1-alpha));
proc gplot data=plot;
    plot Power*EffSize FixedSamplePower*EffSize/frame overlay 
    nolegend haxis=axis2 vaxis=axis1;
    run;
* Average sample size;
axis1 minor=none label=(angle=90 "Average sample size per group") 
    order=(0 to 900 by 300);
axis2 minor=none label=("True effect size") order=(0 to 0.25 by 0.05);
symbol1 value=none color=black i=join line=1;
data plot;
    set Power;
    format AveSize 4.0;
proc gplot data=plot;
    plot AveSize*EffSize/frame nolegend haxis=axis2 vaxis=axis1
        vref=859 lvref=34;
    run;

/* Program 4.4, Page 211         */       

data DepTrialData;
    input n1 mean1 sd1 n2 mean2 sd2;
    datalines;
     78 8.3 6.2  78 5.9 6.5
    122 8.0 6.3 120 6.3 5.9 
    150 8.2 5.9 152 6.1 5.8
    ;
data teststat;
    set DepTrialData;
    format stat p 6.4;
    n=(n1+n2)/2;
    s=sqrt(((n1-1)*sd1*sd1+(n2-1)*sd2*sd2)/(n1+n2-2));
    stat=(mean1-mean2)/(s*sqrt(1/n1+1/n2));
    p=1-probnorm(stat);    
    label n="Sample size"
          stat="Z statistic"
          p="P-value";
    keep n stat p;
proc print data=teststat noobs label;
    var n stat p;
    run;

/* Program 4.5, Page 212         */       

data DepTrial;
    input fraction @@;
    datalines;
    0.5 0.75 1
    ;

* First interim analysis;
data stat;
    set teststat;
    if _n_=1;
    keep n stat;
%EffMonitor(fraction=DepTrial,data=stat,effsize=0.375,power=0.9,
    alpha=0.025,rho=0,spfunction=1,sprho=0,decision=OFdecision,
    inference=OFinference);
proc print data=OFdecision noobs label;
    var Analysis TestStatistic Pvalue TestStBoundary PValBoundary Decision;

* Second interim analysis;
data stat;
    set teststat;
    if _n_<=2;
    keep n stat;
%EffMonitor(fraction=DepTrial,data=stat,effsize=0.375,power=0.9,
    alpha=0.025,rho=0,spfunction=1,sprho=0,decision=OFdecision,
    inference=OFinference);
proc print data=OFdecision noobs label;
    var Analysis TestStatistic Pvalue TestStBoundary PValBoundary Decision;

* Final analysis;
data stat;
    set teststat;
    keep n stat;
%EffMonitor(fraction=DepTrial,data=stat,effsize=0.375,power=0.9,
    alpha=0.025,rho=0,spfunction=1,sprho=0,decision=OFdecision,
    inference=OFinference);
proc print data=OFdecision noobs label;
    var Analysis TestStatistic Pvalue TestStBoundary PValBoundary Decision;
    run;

/* Program 4.6, Page 215         */       

* First interim analysis;
data stat;
    set teststat;
    if _n_=1;
    keep n stat;
%EffMonitor(fraction=DepTrial,data=stat,effsize=0.375,power=0.9,
    alpha=0.025,rho=0.5,spfunction=1,sprho=0,decision=OFdecision,
    inference=OFinference);
proc print data=OFdecision noobs label;
    var Analysis TestStatistic Pvalue TestStBoundary PValBoundary Decision;
    run;

/* Program 4.7, Page 216         */       

data SepTrialData;
    input n1 alive1 n2 alive2;
    datalines;
    220 164 216 152
    715 538 715 526
    ;
data teststat;
    set SepTrialData;
    format stat p 6.4;
    n=(n1+n2)/2;
    p1=alive1/n1; p2=alive2/n2;
    pave=(p1+p2)/2;
    s=sqrt(pave*(1-pave)*(1/n1+1/n2));
    stat=(p1-p2)/s;  
    p=1-probnorm(stat);    
    label n="Sample size"
          stat="Z statistic"
          p="P-value";
    keep n stat p;
proc print data=teststat noobs label;
    var n stat p;
    run;

/* Program 4.8, Page 217         */       

data SepTrial;
    input fraction @@;
    datalines;
    0.2 0.66 1
    ;

* First interim analysis;
data stat;
    set teststat;
    if _n_=1;
    keep n stat;
%EffFutMonitor(fraction=SepTrial,data=stat,effsize=0.1352,power=0.8,
    alpha=0.025,rhoeff=0,rhofut=0.5,spfunction=1,sprho=1,
    decision=decision,inference=inference);
proc print data=decision noobs label;    
    var Analysis TestStatistic LowerTestStBoundary UpperTestStBoundary 
    Decision;
proc print data=decision noobs label;    
    var Analysis PValue LowerPValBoundary UpperPValBoundary Decision;

* Second interim analysis;
data stat;
    set teststat;
    if _n_=2;
    keep n stat;
%EffFutMonitor(fraction=SepTrial,data=stat,effsize=0.1352,power=0.8,
    alpha=0.025,rhoeff=0,rhofut=0.5,spfunction=1,sprho=1,
    decision=decision,inference=inference);
proc print data=decision noobs label;    
    var Analysis TestStatistic LowerTestStBoundary UpperTestStBoundary 
    Decision;
proc print data=decision noobs label;    
    var Analysis PValue LowerPValBoundary UpperPValBoundary Decision;
    run;

/* Program 4.9, Page 220         */       

data stat;
    set teststat;
    keep n stat;
%EffMonitor(fraction=SepTrial,data=stat,effsize=0.375,power=0.9,
    alpha=0.025,rho=0,spfunction=1,sprho=0,decision=OFdecision,
    inference=OFinference);
proc print data=OFdecision noobs label;    
    var Analysis Size Fraction LowerLimit;
    run;

/* Program 4.10, Page 223         */      

data stat;
    set teststat;
    keep n stat;
%EffMonitor(fraction=SepTrial,data=stat,effsize=0.375,power=0.9,
    alpha=0.025,rho=0,spfunction=1,sprho=0,decision=OFdecision,
    inference=OFinference);
proc print data=OFinference noobs label;    
    run;

/* Program 4.11, Page 225         */      

proc iml;
    * Two-sided Type I error probability;
    alpha=0.05; 
    * Pocock plan;
    Rho=0.5; 
    * Number of analyses;
    m=5;     
    * Two-sided boundary on the cumulative sum scale;    
    SBoundary=-(1:m)##Rho//(1:m)##Rho; 
    call seqscale(prob,CritValue,SBoundary,1-alpha) eps=1e-8;     
    * Two-sided boundary on the test statistic scale;
    ZBoundary=CritValue*(1:m)##(Rho-0.5);
    print ZBoundary[format=7.4];
    * Adjusted significance level;
    AdjAlpha=2*(1-probnorm(CritValue)); 
    print AdjAlpha[format=7.4];
    * Stopping probabilities under the null hypothesis;
    SBoundary=-CritValue*(1:m)##Rho//CritValue*(1:m)##Rho; 
    call seq(prob0,SBoundary) eps=1e-8;    
    StopProb=prob0[3,]-prob0[2,]+prob0[1,]; 
    print StopProb[format=7.4];
    run;
    quit;

/* Program 4.12, Page 226         */      

proc iml;
    * Two-sided Type I error probability;
    alpha=0.05; 
    * Pocock plan;
    Rho=0.5; 
    * Fractions of the total sample size at three analyses;
    fraction={0.2,0.5,1}; 
    * Number of analyses;
    m=nrow(fraction);
    * Standardized fractions;
    StFraction=fraction/fraction[1];
    * Increments;
    inc=j(1,m-1,0);
    do i=1 to m-1;
        inc[i]=StFraction[i+1]-StFraction[i];
    end; 
    * Two-sided boundary on the cumulative sum scale;    
    SBoundary=-StFraction`##Rho//StFraction`##Rho; 
    call seqscale(prob,CritValue,SBoundary,1-alpha) tscale=inc eps=1e-8;     
    * Two-sided boundary on the test statistic scale;
    ZBoundary=CritValue*StFraction`##(Rho-0.5);
    print ZBoundary[format=7.4];
    * Adjusted significance level;
    AdjAlpha=2*(1-probnorm(CritValue)); 
    print AdjAlpha[format=7.4];
    * Stopping probabilities under the null hypothesis;
    SBoundary=-CritValue*StFraction`##Rho//CritValue*StFraction`##Rho; 
    call seq(prob0,SBoundary) tscale=inc eps=1e-8;    
    StopProb=prob0[3,]-prob0[2,]+prob0[1,]; 
    print StopProb[format=7.4];
    run;
    quit;

/* Program 4.13, Page 228         */      

proc iml;
    * Two-sided Type I error probability;
    alpha=0.05; 
    * Type II error probability;
    beta=0.1; 
    * Pocock plan;
    Rho=0.5; 
    * Number of analyses;
    m=5; 
    start DriftSearch(d) global(m,rho,critvalue,beta);        
        lower=-critvalue*(1:m)##rho;
        upper=critvalue*(1:m)##rho;
        adjustment=d*(1:m);
        boundary=(lower-adjustment)//(upper-adjustment);                     
        call seq(p,boundary) eps=1e-8; 
        diff=abs(beta-(p[2,]-p[1,])[m]);          
        return(diff);
    finish;           
    * Two-sided boundary on the cumulative sum scale;    
    SBoundary=-(1:m)##rho//(1:m)##rho; 
    call seqscale(prob,CritValue,SBoundary,1-alpha) eps=1e-8; 
    * Starting value for the drift parameter search;
    start=(probit(1-beta)+probit(1-alpha))/sqrt(m);
    * Convergence parameters;
    tc=repeat(.,1,12);
    tc[1]=100;
    tc[3]=1e-5;
    call nlpdd(rc,drift,"DriftSearch",start) tc=tc;
    * Drift parameter;
    print drift[format=6.2];
    run;
    quit;


/* Program 4.14, Page 229         */      

proc iml;
    * Two-sided Type I error probability;
    alpha=0.05; 
    * Type II error probability;
    beta=0.1; 
    * Pocock plan;
    Rho=0.5; 
    * Number of analyses;
    m=5; 
    start DriftSearch(d) global(m,rho,critvalue,beta);        
        lower=-critvalue*(1:m)##rho;
        upper=critvalue*(1:m)##rho;
        adjustment=d*(1:m);
        boundary=(lower-adjustment)//(upper-adjustment);                     
        call seq(p,boundary) eps=1e-8; 
        diff=abs(beta-(p[2,]-p[1,])[m]);          
        return(diff);
    finish;           
    * Two-sided boundary on the cumulative sum scale;    
    SBoundary=-(1:m)##rho//(1:m)##rho; 
    call seqscale(prob,CritValue,SBoundary,1-alpha) eps=1e-8; 
    * Starting value for the drift parameter search;
    start=(probit(1-beta)+probit(1-alpha))/sqrt(m);
    * Convergence parameters;
    tc=repeat(.,1,12);
    tc[1]=100;
    tc[3]=1e-5;
    call nlpdd(rc,drift,"DriftSearch",start) tc=tc;
    * Maximum sample size;        
    maximum=2*m*drift*drift;
    * Expected sample size under the alternative hypothesis;        
    lower=-critvalue*(1:m)##rho;
    upper=critvalue*(1:m)##rho;
    adjustment=drift*(1:m);
    boundary=(lower-adjustment)//(upper-adjustment);           
    call seq(prob1,boundary) eps=1e-8; 
    StopProb=prob1[3,]-prob1[2,]+prob1[1,]; 
    n=2*(maximum/m)*(m-(m-(1:m))*StopProb`);       
    print n[format=6.2];
    run;
    quit;

/* Program 4.15, Page 232         */      

data PTKTrial;
    input fraction @@;
    datalines;
    0.25 0.5 0.75 1
    ;
%EffFutDesign(fraction=PTKTrial,effsize=0.25,power=0.9,alpha=0.05,
    rhoeff=0,rhofut=0,boundary=Boundary,sizepower=Power);
    run;

/* Program 4.16, Page 234         */      

data PTKTrial;
    input fraction @@;
    datalines;
    0.25 0.5 0.75 1
    ;
data TestStat;
    input n stat;
    datalines;        
    112.5 0.6
    187 1.2
    ;
%EffFutMonitor(fraction=PTKTrial,data=TestStat,effsize=0.25,power=0.9,
    alpha=0.05, rhoeff=0,rhofut=0,spfunction=2,sprho=1,decision=decision,
    inference=inference);
proc print data=decision noobs label;    
    var Analysis TestStatistic LowerTestStBoundary UpperTestStBoundary;
    run;

/* Program 4.17, Page 239         */      

data sevsep;
    input ExpN ExpAlive PlacN PlacAlive;
    datalines;
     55  33  45  29
     79  51  74  49
    101  65  95  62
    117  75 115  77
    136  88 134  88
    155  99 151  99
    ; 
data test;
    set sevsep;    
    diff=ExpAlive/ExpN-PlacAlive/PlacN;
    ave=(ExpAlive/ExpN+PlacAlive/PlacN)/2;    
    n=(ExpN+PlacN)/2;
    teststat=diff/sqrt(2*ave*(1-ave)/n);    
    keep n teststat;
%CondPowerLSH(data=test,effsize=0.2065,alpha=0.1,gamma=0.8,nn=212,
    prob=p,boundary=boundary);
proc print data=p noobs label;    
data test;
    set test;
    group=1;
    fraction=n/212;
    StopBoundary=teststat;
data boundary;
    set boundary;
    group=2;
data plot;
    set test boundary;    
axis1 minor=none label=(angle=90 "Test statistic") order=(-3 to 1 by 1);
axis2 minor=none label=("Fraction of total sample size")
    order=(0 to 1 by 0.2);
symbol1 i=none v=dot color=black;
symbol2 i=join v=none color=black line=1;
proc gplot data=plot;
    plot StopBoundary*Fraction=group/frame nolegend 
    haxis=axis2 vaxis=axis1 vref=0 lvref=34;
    run;

/* Program 4.18, Page 241         */      

proc iml;
    expn={55, 79, 101, 117, 136, 155};
    placn={45, 74, 95, 115, 134, 151};
    lower=0.2;
    upper=0.8;
    nn=212;
    alpha=0.1;
    effsize=0.2065;  
    gamma=0.8; 
    boundary=j(1,3,.); 
    do analysis=1 to 6;    
    start=ceil(expn[analysis]*lower);
    end=floor(expn[analysis]*upper);
    temp=j(end-start+1,3,0);    
    do i=start to end;     
        p1=i/expn[analysis];
        j=ceil(placn[analysis]*lower)-1;
        prob=1;
        do while(prob>1-gamma & j<=placn[analysis]);        
        j=j+1;
        p2=j/placn[analysis];
        ave=(p1+p2)/2;    
        n=(expn[analysis]+placn[analysis])/2;        
        teststat=(p1-p2)/sqrt(2*ave*(1-ave)/n);                
        prob=1-probnorm((sqrt(nn)*probit(1-alpha)-sqrt(n)*teststat
        -(nn-n)*effsize/sqrt(2))/sqrt(nn-n));         
        end;
        k=i-start+1;
        temp[k,1]=p1;
        temp[k,2]=p2;    
        temp[k,3]=analysis;                 
    end;    
    boundary=boundary//temp;
    end;
    varnames={"p1" "p2" "analysis"};    
    create boundary from boundary[colname=varnames];
    append from boundary;            
    quit;
data points;    
    p1=33/55; p2=29/45; analysis=7; output;
    p1=51/79; p2=49/74; analysis=8; output;
    p1=65/101; p2=62/95; analysis=9; output;
    p1=75/117; p2=77/115; analysis=10; output;
    p1=88/136; p2=88/134; analysis=11; output;
    p1=99/155; p2=99/151; analysis=12; output;
data boundary;
    set boundary points;
%macro BoundPlot(subset,analysis);
axis1 minor=none label=(angle=90 "Observed survival rate (Placebo)")
    order=(0.5 to 0.8 by 0.1);
axis2 minor=none label=("Observed survival rate (Exp drug)")
    order=(0.5 to 0.8 by 0.1);
symbol1 i=j v=none color=black line=1;
symbol2 i=none v=dot color=black;
data annotate;
    xsys="1"; ysys="1"; hsys="4"; x=50; y=10; position="5"; 
    size=1; text="Interim analysis &analysis"; function="label";
proc gplot data=boundary anno=annotate;
    where &subset;
    plot p2*p1=analysis/frame nolegend haxis=axis2 vaxis=axis1;
    run;
    quit;
%mend BoundPlot;
%BoundPlot(%str(analysis in (1,7)),1);
%BoundPlot(%str(analysis in (2,8)),2);
%BoundPlot(%str(analysis in (3,9)),3);
%BoundPlot(%str(analysis in (4,10)),4);
%BoundPlot(%str(analysis in (5,11)),5);
%BoundPlot(%str(analysis in (6,12)),6);

/* Program 4.19, Page 244         */      

%CondPowerLSH(data=test,effsize=0.1,alpha=0.1,gamma=0.8,nn=212,
    prob=p,boundary=boundary);
title "Effect size is 0.1";
proc print data=p noobs label;
%CondPowerLSH(data=test,effsize=0,alpha=0.1,gamma=0.8,nn=212,
    prob=p,boundary=boundary);
title "Effect size is 0";
proc print data=p noobs label;
    run;    

/* Program 4.20, Page 246         */      

%CondPowerPAB(data=test,alpha=0.1,gamma=0.8,c=1,nn=212,
    prob=p,boundary=boundary1);
title "Pepe-Anderson-Betensky test with c=1";
proc print data=p noobs label;    
%CondPowerPAB(data=test,alpha=0.1,gamma=0.8,c=2.326,nn=212,
    prob=p,boundary=boundary2);
%CondPowerLSH(data=test,effsize=0.2065,alpha=0.1,gamma=0.8,nn=212,
    prob=p,boundary=boundary3);
title "Pepe-Anderson-Betensky test with c=2.326";
proc print data=p noobs label;    
    run;
data test;
    set test;
    group=1;
    fraction=n/212;
    StopBoundary=teststat;
data boundary1;
    set boundary1;
    group=2;
data boundary2;
    set boundary2;
    group=3;
data boundary3;
    set boundary3;
    group=4;
data plot;
    set test boundary1 boundary2 boundary3;
axis1 minor=none label=(angle=90 "Test statistic") order=(-3 to 1 by 1);
axis2 minor=none label=("Fraction of total sample size")
    order=(0 to 1 by 0.2);
symbol1 i=none v=dot color=black;
symbol2 i=join v=none color=black line=20;
symbol3 i=join v=none color=black line=34;
symbol4 i=join v=none color=black line=1;
proc gplot data=plot;
    plot StopBoundary*Fraction=group/frame nolegend
    haxis=axis2 vaxis=axis1;
    run;
    quit;

/* Program 4.21, Page 254         */      

data genanx;
    input n1 mean1 sd1 n2 mean2 sd2;
    datalines;
    11 -8.4 6.4 10 -9.2 7.3   
    20 -8.1 6.9 20 -9.4 6.7 
    30 -9.1 7.7 31 -8.9 7.4 
    ;
data lowconf;
    input nn1 nn2 mu1 mu2 sigma;
    datalines;
    41 41 -8 -12 10    
    ;
data highconf;
    input nn1 nn2 mu1 mu2 sigma;
    datalines;
    41 41 -8 -12 1    
    ;
%BayesFutilityCont(data=genanx,par=lowconf,delta=0,eta=0.9,alpha=0.1,
    prob=lowout);
%BayesFutilityCont(data=genanx,par=highconf,delta=0,eta=0.9,alpha=0.1,
    prob=highout);
proc print data=lowout noobs label;
    title "Predictive power test, Low confidence prior";
    var Analysis Fraction PredPower;
proc print data=highout noobs label;
    title "Predictive power test, High confidence prior";
    var Analysis Fraction PredPower;
data test;
    set genanx;        
    s=sqrt(((n1-1)*sd1*sd1+(n2-1)*sd2*sd2)/(n1+n2-2));
    teststat=(mean1-mean2)/(s*sqrt(1/n1+1/n2));    
    n=(n1+n2)/2;
    keep n teststat;
%CondPowerLSH(data=test,effsize=0.4706,alpha=0.1,gamma=0.8,nn=41,
    prob=out,boundary=boundary);
proc print data=out noobs label;  
    title "Conditional power test"; 
    var Analysis Fraction CondPower;
    run;

/* Program 4.22, Page 260         */      

data sevsep2;
    input n1 count1 n2 count2;
    datalines;
     55  33  45  29
     79  51  74  49
    101  65  95  62
    117  75 115  77
    136  88 134  88
    155  99 151  99
    ;
data LowConf;
    input nn1 nn2 alpha1 alpha2 beta1 beta2;
    datalines;
    212 212  1  1  1  1    
    ;
data HighConf;
    input nn1 nn2 alpha1 alpha2 beta1 beta2;
    datalines;    
    212 212 335 479 89 205
    ;
%BayesFutilityBin(data=sevsep2,par=LowConf,delta=0,eta=0.9,
    alpha=0.1,prob=LowProb);
%BayesFutilityBin(data=sevsep2,par=HighConf,delta=0,eta=0.9,
    alpha=0.1,prob=HighProb);
proc print data=LowProb noobs label;
    title "Low confidence prior";
    var Analysis Fraction PredPower;
proc print data=HighProb noobs label;
    title "High confidence prior";
    var Analysis Fraction PredPower;
    run;

/* Program 4.23, Page 263         */      

%BayesFutilityCont(data=genanx,par=lowconf,delta=1,eta=0.9,
    alpha=0.1,prob=delta1);
%BayesFutilityCont(data=genanx,par=lowconf,delta=2,eta=0.9,
    alpha=0.1,prob=delta2);
%BayesFutilityCont(data=genanx,par=lowconf,delta=3,eta=0.9,
    alpha=0.1,prob=delta3);
proc print data=delta1 noobs label;
    title "Delta=1";
    var Analysis Fraction PredProb;
proc print data=delta2 noobs label;
    title "Delta=2";
    var Analysis Fraction PredProb;
proc print data=delta3 noobs label;
    title "Delta=3";
    var Analysis Fraction PredProb;
    run;

/* Program 4.24, Page 265         */      

%BayesFutilityBin(data=sevsep2,par=lowconf,delta=0,eta=0.9,
    alpha=0.1,prob=delta1);
%BayesFutilityBin(data=sevsep2,par=lowconf,delta=0.05,eta=0.9,
    alpha=0.1,prob=delta2);
%BayesFutilityBin(data=sevsep2,par=lowconf,delta=0.1,eta=0.9,
    alpha=0.1,prob=delta3);
proc print data=delta1 noobs label;
    title "Delta=0";
    var Analysis Fraction PredProb;
proc print data=delta2 noobs label;
    title "Delta=0.05";
    var Analysis Fraction PredProb;
proc print data=delta3 noobs label;
    title "Delta=0.1";
    var Analysis Fraction PredProb;
    run;

/* Program 5.1, Page 279          */      

proc mixed data = growth method = ml covtest;
    title "Growth Data, Model 1";
    class idnr sex age;
    model measure = sex age*sex / s;
    repeated / type = un subject = idnr r rcorr;
    run;

/* Program 5.2, Page 281          */      

proc mixed data = growth method = ml covtest;
    title "Growth Data, Model 0";
    class idnr sex age;
    model measure = sex age*sex / s;
    repeated / type = un subject = idnr
        r = 1,12 rcorr = 1,12 group = sex;
    run;

/* Program 5.3, Page 282          */      

proc mixed data = growth method = ml covtest empirical;
    title "Growth Data, Model 1, Empirically Corrected";
    class idnr sex age;
    model measure = sex age*sex / s;
    repeated / type = un subject = idnr r rcorr;
    run;

/* Program 5.4, Page 285          */      

proc mixed data = growth method = ml covtest;
    title "Growth Data, Model 4";
    class sex idnr;
    model measure = sex age*sex / s;
    repeated / type = toep subject = idnr r rcorr;
    run;

/* Program 5.5, Page 286          */      

proc mixed data = growth method = ml covtest;
    title "Jennrich and Schluchter, Model 7";
    class sex idnr;
    model measure = sex age*sex / s;
    random intercept / type = un subject = idnr g;
    run;

/* Program 5.6, Page 287          */      

proc mixed data = growth method = ml covtest;
    title "Jennrich and Schluchter, Model 7";
    class sex idnr;
    model measure = sex age*sex / s;
    repeated / type = cs subject = idnr r rcorr;
    run;

/* Program 5.7, Page 290          */      

%macro cc(data=,id=,time=,response=,out=);
%if %bquote(&data)= %then %let data=&syslast;
proc freq data=&data noprint;
    tables &id /out=freqsub;
    tables &time / out=freqtime;
    run;
proc iml;
    use freqsub;
    read all var {&id,count};
    nsub = nrow(&id);
    use freqtime;
    read all var {&time,count};
    ntime = nrow(&time);
    use &data;
    read all var {&id,&time,&response};
    n = nrow(&response);
    complete = j(n,1,1);
    ind = 1;
    do while (ind <= nsub);
        if (&response[(ind-1)*ntime+ntime]=.) then
        complete[(ind-1)*ntime+1:(ind-1)*ntime+ntime]=0;
        ind = ind+1;
    end;
    create help var {&id &time &response complete};
    append;
    quit;
data &out;
    merge &data help;
    if complete=0 then delete;
    drop complete;
    run;
%mend;

/* Program 5.8, Page 293          */      

proc mixed data=cc method=ml noitprint ic;
    class patient visit invest trt;
    model change = trt invest visit trt*visit basval basval*visit
        / solution ddfm=satterth;
    repeated visit / subject=patient type=un;
    run;

/* Program 5.9, Page 297          */      

%macro locf(data=,id=,time=,response=,out=);
%if %bquote(&data)= %then %let data=&syslast;
proc freq data=&data noprint;
    tables &id /out=freqsub;
    tables &time / out=freqtime;
    run;
proc iml;
    use freqsub;
    read all var {&id,count};
    nsub = nrow(&id);
    use freqtime;
    read all var {&time,count};
    ntime = nrow(&time);
    use &data;
    read all var {&id,&time,&response};
    n = nrow(&response);
    locf = &response;
    ind = 1;
    do while (ind <= nsub);
        if (&response[(ind-1)*ntime+ntime]=.) then
        do;
            i =1;
            do while (&response[(ind-1)*ntime+i]^=.);
            i = i+1;
	    end;
        lastobserved = i-1;
        locf[(ind-1)*ntime+lastobserved+1:(ind-1)*ntime+ntime]
            = locf[(ind-1)*ntime+lastobserved];
        end;
        ind = ind+1;
    end;
    create help var {&id &time &response locf};
    append;
    quit;
data &out;
    merge &data help;
    run;
%mend;

/* Program 5.10, Page 299         */      

proc mixed data=locf method=ml noclprint noitprint;
    class patient visit invest trt;
    model locf = trt invest visit trt*visit basval basval*visit
        / solution ddfm=satterth;
    repeated visit / subject=patient type=un;
    run;

/* Programs on Page 304           */      

proc mixed data = growthav method = ml;
    title 'Jennrich and Schluchter (MAR, Altern.), Model 1';
    class sex idnr age;
    model measure = sex age*sex / s;
    repeated age / type = un subject = idnr r rcorr;
    run;

proc mixed data = growthav method = ml;
    title 'Jennrich and Schluchter (MAR, Altern.), Model 2';
    class sex idnr;
    model measure = sex age*sex / s;
    repeated age / type = un subject = idnr r rcorr;
    run;

data help;
    set growthav;
    agec = age;
    run;

proc mixed data = help method = ml;
    title 'Jennrich and Schluchter (MAR, Altern.), Model 2';
    class sex idnr agec;
    model measure = sex age*sex / s;
    repeated agec / type = un subject = idnr r rcorr;
    run;

/* Program 5.11, Page 306         */      

proc mixed data=depression method=ml noitprint ic;
    class patient visit invest trt;
    model change = trt invest visit trt*visit basval basval*visit
        / solution ddfm=satterth;
    repeated visit / subject=patient type=un;
    run;

/* Program 5.12, Page 313         */      

proc mixed data=growthax asycov covtest;
    title "Standard proc mixed analysis";
    class idnr age sex;
    model measure=age*sex / noint solution covb;
    repeated age / subject=idnr type=cs;
    run;

/* Program 5.13, Page 313         */      

data hulp1;
    set growthax;
    meas8=measure;
    if age=8 then output;
    run;
data hulp2;
    set growthax;
    meas10=measure;
    if age=10 then output;
    run;
data hulp3;
    set growthax;
    meas12=measure;
    if age=12 then output;
    run;
data hulp4;
    set growthax;
    meas14=measure;
    if age=14 then output;
    run;
data growthmi;
    merge hulp1 hulp3 hulp4 hulp2;
    run;
proc sort data=growthmi;
    by sex;
proc print data=growthmi;
    title "Horizontal data set";
    run;

/* Program 5.14, Page 314         */      

proc mi data=growthmi seed=459864 simple nimpute=10
    round=0.1 out=outmi;
    by sex;
    monotone method=reg;
    var meas8 meas12 meas14 meas10;
    run;

/* Program 5.15, Page 315         */      

proc sort data=outmi;
    by _imputation_ idnr;
    run;
proc print data=outmi;
    title 'Horizontal imputed data set';
    run;
data outmi2;
    set outmi;
    array y (4) meas8 meas10 meas12 meas14;
    do j=1 to 4;
        measmi=y(j);
        age=6+2*j;
        output;
    end;
    run;
proc print data=m.outmi2;
    title "Vertical imputed data set";
    run;

/* Program 5.16, Page 316         */      

proc mixed data=m.outmi2 asycov;
    title "Multiple Imputation Call of PROC MIXED";
    class idnr age sex;
    model measmi=age*sex / noint solution covb;
    repeated age / subject=idnr type=cs;
    by _Imputation_;
    ods output solutionF=mixbetap covb=mixbetav
    covparms=mixalfap asycov=mixalfav;
    run;
proc print data=mixbetap;
    title "Fixed effects: parameter estimates";
    run;
proc print data=mixbetav;
    title "Fixed effects: variance-covariance matrix";
    run;
proc print data=mixalfav;
    title "Variance components: covariance parameters";
    run;
proc print data=mixalfap;
    title "Variance components: parameter estimates";
    run;

/* Program 5.17, Page 320         */      

data mixbetap0;
    set mixbetap;
    if age= 8 and sex=1 then effect='as081';
    if age=10 and sex=1 then effect='as101';
    if age=12 and sex=1 then effect='as121';
    if age=14 and sex=1 then effect='as141';
    if age= 8 and sex=2 then effect='as082';
    if age=10 and sex=2 then effect='as102';
    if age=12 and sex=2 then effect='as122';
    if age=14 and sex=2 then effect='as142';
    run;
data mixbetap0;
    set mixbetap0 (drop=age sex);
    run;
proc print data=mixbetap0;
    title "Fixed effects: parameter estimates (after manipulation)";
    run;
data mixbetav0;
    set mixbetav;
    if age= 8 and sex=1 then effect='as081';
    if age=10 and sex=1 then effect='as101';
    if age=12 and sex=1 then effect='as121';
    if age=14 and sex=1 then effect='as141';
    if age= 8 and sex=2 then effect='as082';
    if age=10 and sex=2 then effect='as102';
    if age=12 and sex=2 then effect='as122';
    if age=14 and sex=2 then effect='as142';
    run;
data mixbetav0;
    title "Fixed effects: variance-covariance matrix (after manipulation)";
    set mixbetav0 (drop=row age sex);
    run;
proc print data=mixbetav0;
    run;
data mixalfap0;
    set mixalfap;
    effect=covparm;
    run;
data mixalfav0;
    set mixalfav;
    effect=covparm;
    Col1=CovP1;
    Col2=CovP2;
    run;
proc print data=mixalfap0;
    title "Variance components: parameter estimates
    (after manipulation)";
    run;
proc print data=mixalfav0;
    title "Variance components: covariance parameters
    (after manipulation)";
    run;

/* Program 5.18, Page 324         */      

proc mianalyze parms=mixbetap0 covb=mixbetav0;
    title "Multiple Imputation Analysis for Fixed Effects";
    var as081 as082 as101 as102 as121 as122 as141 as142;
    run;
proc mianalyze parms=mixalfap0 covb=mixalfav0;
    title "Multiple Imputation Analysis for Variance Components";
    var CS Residual;
    run;

/* Program 5.19, Page 330         */      

proc mi data=growthmi seed=495838 simple nimpute=0;
    em itprint outem=growthem1;
    var meas8 meas12 meas14 meas10;
    by sex;
    run;

/* Program 5.20, Page 332         */      

proc mi data=growthmi seed=495838 simple nimpute=5 out=growthmi2;
    em itprint outem=growthem2;
    var meas8 meas12 meas14 meas10;
    by sex;
    run;

/* Program 5.21, Page 338         */      

data depression;
    set depression;
    if y<=7 then ybin=0;
    else ybin=1;
    run;

/* Program 5.22, Page 339         */      

proc genmod data=depression descending;
    class patient visit trt;
    model ybin = trt visit trt*visit basval basval*visit / dist=binomial type3;
    repeated subject=patient / withinsubject=visit type=cs corrw modelse;
    contrast 'endpoint' trt 1 -1 visit*trt 0 0 0 0 0 0 0 0 1-1;
    contrast 'main' trt 1 -1;
    run;

/* Program 5.23, Page 342         */      

%macro dropout(data=,id=,time=,response=,out=);
%if %bquote(&data)= %then %let data=&syslast;
    proc freq data=&data noprint;
    tables &id /out=freqid;
    tables &time / out=freqtime;
    run;
proc iml;
    reset noprint;
    use freqid;
    read all var {&id};
    nsub = nrow(&id);
    use freqtime;
    read all var {&time};
    ntime = nrow(&time);
    time = &time;
    use &data;
    read all var {&id &time &response};
    n = nrow(&response);
    dropout = j(n,1,0);
    ind = 1;
    do while (ind <= nsub);
        j=1;
        if (&response[(ind-1)*ntime+j]=.)
        then print "First Measurement is Missing";
        if (&response[(ind-1)*ntime+j]^=.) then
        do;
            j = ntime;
            do until (j=2);
            if (&response[(ind-1)*ntime+j]=.) then
            do;
            dropout[(ind-1)*ntime+j]=1;
            j = j-1;
            end;
            else j = 2;
            end;
            end;
            ind = ind+1;
        end;
    prev = j(n,1,1);
    prev[2:n] = &response[1:n-1];
    i=1;
    do while (i<=n);
        if &time[i]=time[1] then prev[i]=.;
        i = i+1;
    end;
    create help var {&id &time &response dropout prev};
    append;
    quit;
data &out;
    merge &data help;
    run;
%mend;

%dropout(data=depression,id=patient,time=visit,response=ybin,out=dropout);

/* Program 5.24, Page 344         */      

proc genmod data=dropout descending;
    class trt;
    model dropout = prev trt / pred dist=b;
    output out=pred p=pred;
    run;

/* Program 5.25, Page 344         */      

data studdrop;
    merge pred dropout;
    if (pred=.) then delete;
    run;
data wgt (keep=patient wi);
    set studdrop;
    by patient;
    retain wi;
    if first.patient then wi=1;
    if not last.patient then wi=wi*(1-pred);
    if last.patient then do;
    if visit<8 then wi=wi*pred; /* DROPOUT BEFORE LAST OBSERVATION */
    else wi=wi*(1-pred); /* NO DROPOUT */
    wi=1/wi;
    output;
    end;
    run;
data total;
    merge dropout wgt;
    by patient;
    run;

/* Program 5.26, Page 345         */      

proc genmod data=total descending;
    weight wi;
    class patient visit trt;
    model ybin = trt visit trt*visit basval basval*visit / dist=bin type3;
    repeated subject=patient / withinsubject=visit type=cs corrw modelse;
    contrast 'endpoint' trt 1 -1 visit*trt 0 0 0 0 0 0 0 0 1-1;
    contrast 'main' trt 1 -1;
    run;

/* Program 5.27, Page 348         */      

data dummy;
    set depression;
    if trt=1 then treat=1;
    else treat=0;
    visit_4=0;
    visit_5=0;
    visit_6=0;
    visit_7=0;
    if visit=4 then visit_4=1;
    if visit=5 then visit_5=1;
    if visit=6 then visit_6=1;
    if visit=7 then visit_7=1;
    run;

/* Program 5.28, Page 348         */      

proc nlmixed data=dummy noad;
    parms intercept=0.5 trt=0.5 basvalue=0.5
    vis4=0.5 vis5=0.5 vis6=0.5 vis7=0.5 trtvis4=0.5
    trtvis5=0.5 trtvis6=0.5 trtvis7=0.5 basvis4=0.5 basvis5=0.5
    basvis6=0.5 basvis7=0.5 sigma=0.5;
    teta = b + intercept + basvalue*BASVAL + trt*TREAT
    + vis4*VISIT_4 + vis5*VISIT_5 + vis6*VISIT_6 + vis7*VISIT_7
    + trtvis4*TREAT*VISIT_4 + trtvis5*TREAT*VISIT_5
    + trtvis6*TREAT*VISIT_6 + trtvis7*TREAT*VISIT_7
    + basvis4*BASVAL*VISIT_4 + basvis5*BASVAL*VISIT_5
    + basvis6*BASVAL*VISIT_6 + basvis7*BASVAL*VISIT_7;
    expteta=exp(teta);
    p=expteta/(1+expteta);
    model ybin ~ binary(p);
    random b ~ normal(0,sigma**2) subject=patient;
    run;

/* Appendix         */                    

/* %MinRisk macro, Page 355         */    

%macro MinRisk(dataset);
/*
Inputs:
 
DATASET  = Input data set with event rates observed in each stratum.
           The input data set must include variables named EVENT1 (number 
           of events of interest in Treatment group 1), EVENT2 (number of 
           events of interest in Treatment group 2), NOEVENT1 (number of 
           non-events in Treatment group 1), NOEVENT2 (number of non-events
           in Treatment group 2) with one record per stratum.
*/
proc iml;
    use &dataset;
    read all var {event1 noevent1 event2 noevent2} into data;   
    m=nrow(data);
    p=j(m,2,0); n=j(m,2,0);
    n[,1]=data[,1]+data[,2];
    n[,2]=data[,3]+data[,4];
    total=sum(n);
    p[,1]=data[,1]/n[,1];
    p[,2]=data[,3]/n[,2];
    delta=p[,1]-p[,2];
    v=p[,1]#(1-p[,1])/n[,1]+p[,2]#(1-p[,2])/n[,2];
    pave=(p[,1]#n[,1]+p[,2]#n[,2])/(n[,1]+n[,2]);
    v0=pave#(1-pave)#(1/n[,1]+1/n[,2]);
    alpha=delta*sum(1/v)-sum(delta/v);   
    c=1+alpha*sum((n[,1]+n[,2])#delta/total);
    h=diag(v*sum(1/v))+alpha*delta`;
    wmr=inv(h)*c;
    dmr=wmr`*delta; 
    zmr1=abs(dmr)-3/(16*sum(n[,1]#n[,2]/(n[,1]+n[,2])));
    zmr2=sqrt(sum(wmr#wmr#v0));
    zmr=zmr1/zmr2;
    pmr=2*(1-probnorm(zmr));
    title={"Estimate", "Statistic", "P-value"};
    minrisk=dmr||zmr||pmr;
    print minrisk [colname=title format=best6.];
    win=(1/v)/sum(1/v);
    din=win`*delta;   
    zin=abs(din)/sqrt(sum(win#win#v0));
    pin=2*(1-probnorm(zin));
    invar=din||zin||pin;
    print invar [colname=title format=best6.];
    wss=(n[,1]#n[,2]/(n[,1]+n[,2]))/sum(n[,1]#n[,2]/(n[,1]+n[,2]));
    dss=wss`*delta;   
    zss=abs(dss)/sqrt(sum(wss#wss#v0));
    pss=2*(1-probnorm(zss));
    ssize=dss||zss||pss;
    print ssize [colname=title format=best6.];
    quit;
%mend MinRisk;

/* %GailSimon macro, Page 356         */  

%macro GailSimon(dataset,est,stderr,testtype);
/*
Inputs:
 
DATASET  = Data set with test statistics and associated standard
           errors for each stratum.
 
EST      = Name of the variable containing the test statistics.
 
STDERR   = Name of the variable containing the standard errors.
 
TESTTYPE = P, N, T to carry out the one-sided Gail-Simon test
           for positive or negative differences or the two-sided
           Gail-Simon test, respectively.
*/
data pvalue;
    set &dataset nobs=m;
    format stat 6.3 p 6.4;
    retain qminus 0 qplus 0;   
    qminus=qminus+(&est>0)*(&est/&stderr)**2;
    qplus=qplus+(&est<0)*(&est/&stderr)**2;
    if _n_=m then do;
        if upcase(&testtype)="P" then do; stat=qplus; df=m+1; end;
        if upcase(&testtype)="N" then do; stat=qminus; df=m+1; end;
        if upcase(&testtype)="T" then do; stat=min(qminus,qplus); df=m; end;
        p=0;
        do i=1 to df-1;
            p=p+pdf("binomial",i,0.5,df-1)*(1-probchi(stat,i));
        end;
    end;
    label stat="Test statistic" p="P-value";
    if _n_=m;
    keep stat p;
proc print data=pvalue noobs label;
    %if %upcase(&testtype)="P" %then %do;
        title "One-sided Gail-Simon test for positive differences"; %end;
    %if %upcase(&testtype)="N" %then %do;
        title "One-sided Gail-Simon test for negative differences"; %end;
    %if %upcase(&testtype)="T" %then %do;
        title "Two-sided Gail-Simon test"; %end;
    run;
%mend GailSimon;

/* %Pushback macro, Page 357         */   

%macro pushback(dataset,est,stderr,n,testtype,outdata);
/*
Inputs:
 
DATASET  = Data set with test statistics, associated standard
           errors and numbers of patients for each strata.
 
EST      = Name of the variable containing the test statistics.
 
STDERR   = Name of the variable containing the standard errors.
 
N        = Name of the variable containing the numbers of patients.
 
TESTTYPE = N, T to carry out the pushback test using the order
           statistics from a normal or t distribution, respectively.
*/
proc univariate data=&dataset noprint;   
    var &est;
    weight &n;
    output out=med median=med;   
data stand;
    set &dataset;
    if _n_=1 then set med;   
    tau=(&est-med)/&stderr;
proc sort data=stand;
    by tau;
data &outdata;
    set stand nobs=m;   
    ordstr=_n_;
    if upcase(&testtype)="N" then do;
        t=probit((3*ordstr-1)/(3*m+1));
    end;
    if upcase(&testtype)="T" then do;
        if ordstr<=m/2 then t=tinv(betainv(0.1,ordstr,m-ordstr+1),&n-2);
        if ordstr>m/2 then t=tinv(betainv(0.9,ordstr,m-ordstr+1),&n-2);
        if ordstr=(m+1)/2 then t=0;
    end;
    if tau*(tau-t)>0 then rho=tau-t;
    if tau*(tau-t)<=0 then rho=0;   
    dstar=&stderr*rho+med;   
    run;
%mend pushback;

/* %GlobTest macro, Page 357         */  

%macro GlobTest(dataset,group,ngroups,varlist,test);
/*
Inputs:
 
DATASET = Data set to be analyzed
 
GROUP   = Name of the group variable in the data set
 
NGROUPS = Number of groups in the data set
 
VARLIST = List of variable names corresponding to
          multiple endpoints
 
TEST    = OLS, GLS, MGLS or RS, for OLS test, GLS test, 
          modified GLS test or rank-sum test, respectively
*/
%if &test="RS" %then %do;
proc rank data=&dataset out=ranks;
    var &varlist;    
data comp;
    set ranks;
    array endp{*} &varlist;
    comp=0;
    do i=1 to dim(endp);
        comp=comp+endp{i};
    end;
proc mixed data=comp;
    class &group;
    model comp=&group;
    ods output tests3=pval;
data pval;
    set pval;
    format fvalue 5.2 ndf 3.0 ddf 3.0 adjp 6.4;
    ndf=numdf;
    ddf=dendf;
    adjp=probf;
    label fvalue="F-value" adjp="Global p-value";
    keep ndf ddf fvalue adjp;
%end;
%else %do;
%let m=1;
%let word=%scan(&varlist,&m);
%do %while (&word ne);
    %let m=%eval(&m+1);
    %let word=%scan(&varlist,&m);
%end;
%let m=%eval(&m-1);
data stand;
%do i=1 %to &m;
    %let var=%scan(&varlist,&i);
    proc glm data=&dataset;
        class &group;
        model &var=&group;
        ods output FitStatistics=est(keep=rootmse depmean);
    data stand;
        set stand est;
%end;
data stand;
    set stand;
    if rootmse^=.;
data _null_;
    set &dataset nobs=m;
    call symput("n",trim(put(m,5.0)));
proc corr data=&dataset outp=corr(where=(_type_="CORR")) 
    noprint;
    var &varlist;
proc iml;
    use &dataset var{&varlist};
    read all into data;
    use stand var{depmean};
    read all into mean;
    meanmat=j(nrow(data),ncol(data),1)*diag(mean);
    use stand var{rootmse};
    read all into pooledsd;
    sdmat=inv(diag(pooledsd));
    use corr var{&varlist};
    read all into r;
    stand=(data-meanmat)*sdmat;
    rinv=inv(r);
    if &test="OLS" then comp=stand*j(&m,1);
    if &test="GLS" then comp=stand*rinv*j(&m,1);
    if &test="MGLS" then comp=stand*sqrt(diag(rinv))*j(&m,1);
    create comp from comp;
    append from comp;
data comp;
    merge comp &dataset;
    comp=col1;
    drop col1;
proc mixed data=comp;
    class &group;
    model comp=&group;
    ods output tests3=pval;
data pval;
    set pval;
    format fvalue 5.2 ndf 3.0 ddf 3.0 adjp 6.4;
    ndf=&ngroups-1;
    ddf=&n-&m*&ngroups;
    adjp=1-probf(fvalue,ndf,ddf);
    label fvalue="F-value" adjp="Global p-value";
    keep ndf ddf fvalue adjp;
%end;
proc print data=pval noobs label;
    run;
%mend GlobTest;

/* %GateKeeper macro, Page 359         */ 

%macro GateKeeper(dataset,test,outdata);
/*
Inputs:
 
DATASET = Data set with information about sequential families
          of hypotheses (testing type, weights, relative importance of                                           
          gatekeeper hypotheses and raw p-values).
 
TEST    = B, MB, or S for Bonferroni, modified Bonferroni
          or Simes gatekeeping procedure, respectively.
 
OUTDATA = Output data set with adjusted p-values.
*/
proc iml; 
    use &dataset;
    read all var {family serial weight relimp raw_p} into data;     
    data=t(data);
    nhyps=ncol(data); nfams=data[1,ncol(data)]; nints=2**nhyps-1;
    h=j(nints,nhyps,0);
    do i=1 to nhyps;
        do j=0 to nints-1;
            k=floor(j/2**(nhyps-i));
            if k/2=floor(k/2) then h[j+1,i]=1;
        end;
    end; 
    v=j(nints,nhyps,0); modv=j(nints,nhyps,0);
    hyp=j(nints,nhyps,0); adjp=j(nhyps,1,0);
    do i=1 to nints;     
        r=1; tempv=j(1,nhyps,0); tempmodv=j(1,nhyps,0);     
        do j=1 to nfams;         
            window=(data[1,]=j);         
            sumw=sum(window#data[3,]#h[i,]);      
            serial=sum(window#data[2,]);          
            if (serial=0 & j<nfams) & sumw>0 then do;
                tempv=r#window#data[3,]#h[i,]#
                    ((1-data[4,])+data[4,]/sumw);             
                if sum(h[i,]#(data[1,]>j))=0 then
                tempmodv=r#window#data[3,]#h[i,]/sumw;
                else tempmodv=tempv;
            end;
            if (serial>0 | j=nfams) & sumw>0 then do;
                tempv=r#window#data[3,]#h[i,]/sumw; 
                tempmodv=tempv;
            end;                                                  
            if sumw>0 then do;
                r=r-sum(tempv); v[i,]=v[i,]+tempv; 
                modv[i,]=modv[i,]+tempmodv;         
            end;         
        end;     
        if &test="B" then hyp[i,]=h[i,]*
            min(data[5,loc(v[i,])]/v[i,loc(v[i,])]);
        if &test="MB" then hyp[i,]=h[i,]*
            min(data[5,loc(modv[i,])]/modv[i,loc(modv[i,])]);
        if &test="S" then do;         
            comb=data[5,loc(modv[i,])]//modv[i,loc(modv[i,])]; 
            temp=comb; 
            comb[,rank(data[5,loc(modv[i,])])]=temp; 
            hyp[i,]=h[i,]*min(comb[1,]/cusum(comb[2,]));
        end;
    end;
    do i=1 to nhyps; adjp[i]=max(hyp[,i]); end; 
    create adjp from adjp[colname={adjp}];
    append from adjp; 
    quit;
data &outdata;
    merge &dataset adjp;
    run;
%mend GateKeeper;

/* %ResamGate macro, Page 361         */  

%macro ResamGate(dataset,resp,test,outdata);
/*
Inputs:
 
DATASET = Data set with information about sequential families
          of hypotheses (testing type, weights, relative importance of                                           
          gatekeeper hypotheses and raw p-values).
 
RESP    = Data set with p-values obtained via resampling.
 
TEST    = B, MB, or S for Bonferroni, modified Bonferroni
          or Simes gatekeeping procedure, respectively.
 
OUTDATA = Output data set with adjusted p-values.
*/
proc iml;   
    use &dataset;
    read all var {family serial weight relimp raw_p} into data;       
    data=t(data);
    use &resp;
    read all var _all_ into resp;               
    nhyps=ncol(data); nfams=data[1,ncol(data)];
    nints=2**nhyps-1; nsims=nrow(resp);
    h=j(nints,nhyps,0);
    do i=1 to nhyps;
        do j=0 to nints-1;
            k=floor(j/2**(nhyps-i));
            if k/2=floor(k/2) then h[j+1,i]=1;
        end;
    end;   
    v=j(nints,nhyps,0); modv=j(nints,nhyps,0);
    hyp=j(nints,nhyps,0); adjp=j(nhyps,1,0);
    start bonf(p,w);
        bonfp=min(p[loc(w)]/w[loc(w)]);
        return(bonfp);
    finish bonf;
    start simes(p,w);
        comb=t(p[loc(w)])//t(w[loc(w)]); temp=comb;   
        comb[,rank(p[loc(w)])]=temp;   
        simesp=min(comb[1,]/cusum(comb[2,]));
        return(simesp);
    finish simes; 
    do i=1 to nints;       
        r=1; tempv=j(1,nhyps,0); tempmodv=j(1,nhyps,0);       
        do j=1 to nfams;           
            window=(data[1,]=j);           
            sumw=sum(window#data[3,]#h[i,]);        
            serial=sum(window#data[2,]);            
            if (serial=0 & j<nfams) & sumw>0 then do;
                tempv=r#window#data[3,]#h[i,]#
                    ((1-data[4,])+data[4,]/sumw);               
                if sum(h[i,]#(data[1,]>j))=0 then
                tempmodv=r#window#data[3,]#h[i,]/sumw;
                else tempmodv=tempv;
            end;
            if (serial>0 | j=nfams) & sumw>0 then do;
                tempv=r#window#data[3,]#h[i,]/sumw; 
                tempmodv=tempv;
            end;                                                    
            if sumw>0 then do;
                r=r-sum(tempv); v[i,]=v[i,]+tempv; 
                modv[i,]=modv[i,]+tempmodv;           
            end;           
        end;       
        if &test="B" then samp=bonf(data[5,],v[i,]);
        if &test="MB" then samp=bonf(data[5,],modv[i,]);
        if &test="S" then samp=simes(data[5,],modv[i,]);           
        do j=1 to nsims;
            if &test="B" then resamp=bonf(resp[j,],v[i,]);
            if &test="MB" then resamp=bonf(resp[j,],modv[i,]);
            if &test="S" then resamp=simes(resp[j,],modv[i,]);
            hyp[i,]=hyp[i,]+h[i,]*(resamp<samp)/nsims;   
        end;       
    end;   
    do i=1 to nhyps; adjp[i]=max(hyp[,i]); end;   
    create adjp from adjp[colname={adjp}];
    append from adjp;   
    quit;
data &outdata;
    merge &dataset adjp;
    run;
%mend ResamGate;

/* QTCCONC data set, Page 362         */  

data qtcconc;
    input qtcchange conc @@;
    datalines;
-11 0.0 -12 0.0   0 0.0 -14 0.0 -11 0.0 -30 0.0  -8 0.0 -14 0.0   3 0.0
 11 0.0 -25 0.0   8 0.0  10 0.0 -29 0.1  10 0.1  -2 0.1  10 0.2   4 0.2
  0 0.2  12 0.2 -10 0.3 -11 0.3  -3 0.3  -4 0.3   2 0.3  -4 0.4  11 0.4
  1 0.4 -12 0.4   1 0.4   3 0.4  -8 0.4  24 0.5  -3 0.5   8 0.5  -1 0.5
 -1 0.6 -18 0.6   9 0.6  -5 0.6 -18 0.6   5 0.6  -8 0.6  11 0.6 -29 0.7
 21 0.7  -6 0.7 -23 0.7  11 0.8 -25 0.8   3 0.8   0 0.8   7 0.8  10 0.8
-13 0.9   8 0.9 -30 0.9   5 0.9   3 1.0   0 1.0   6 1.0  -8 1.0   3 1.0
 10 1.0   0 1.0   5 1.0 -15 1.0   6 1.0  -3 1.0  12 1.1  -7 1.1  12 1.2
 -4 1.2  11 1.2 -11 1.2   9 1.2   5 1.2   8 1.2  -1 1.2   1 1.2   2 1.2
 10 1.2  12 1.2   6 1.2 -16 1.2  16 1.3   7 1.3  10 1.3   2 1.3   3 1.3
  1 1.3  -4 1.4   8 1.4  10 1.5  10 1.5  -6 1.5  14 1.5  15 1.5   0 1.5
-18 1.5  -3 1.6   9 1.6 -25 1.6   5 1.6 -10 1.6 -20 1.6   0 1.6   5 1.6
 11 1.7 -28 1.7   9 1.7  -8 1.7 -18 1.8  11 1.8  14 1.8  16 1.8  12 1.8
 -2 1.8   6 1.9   7 1.9 -14 1.9 -22 1.9 -25 1.9  -6 1.9  -5 1.9  -6 1.9
 30 1.9   0 1.9 -25 2.0 -21 2.0   4 2.0  -5 2.0  10 2.0   3 2.0  -9 2.0
-25 2.0   6 2.0   1 2.0 -17 2.1  -9 2.1  20 2.1   7 2.1   2 2.1  21 2.1
-16 2.1   8 2.1   9 2.2  16 2.2  22 2.2   8 2.2  -4 2.2  -6 2.2  12 2.2
-14 2.2  12 2.2   0 2.3  21 2.3  -5 2.3  11 2.3  -8 2.3  -9 2.4 -13 2.4
  1 2.4 -11 2.4 -20 2.4 -12 2.5 -11 2.5   2 2.5  15 2.5   9 2.5 -27 2.5
  1 2.6   3 2.6   1 2.7  -3 2.7 -11 2.7   8 2.7  11 2.7   1 2.8  -4 2.8
 -8 2.8 -10 2.8  18 2.8   7 2.8  20 2.9  -5 3.0  24 3.0  -2 3.0   0 3.0
-11 3.1 -11 3.1  14 3.1   5 3.2  17 3.3  22 3.3 -11 3.3  34 3.4   5 3.4
-11 3.5  -1 3.5  10 3.5   2 3.7 -11 3.8   7 3.9 -10 3.9  -6 4.0 -11 4.0
-11 4.0  17 4.0   0 4.0 -12 4.0 -24 4.0 -10 4.1  -3 4.1  18 4.1  -9 4.1
 -2 4.2   0 4.3  16 4.3 -12 4.3  -8 4.3   8 4.3  -6 4.4  -6 4.4  14 4.5
 11 4.5  -7 4.6  -1 4.6   5 4.6  22 4.7  18 4.7 -11 4.7   6 4.7   4 4.7
  2 4.8  22 4.8  12 4.8  12 4.8 -23 4.8   2 4.9  30 4.9  -7 4.9   8 4.9
-11 4.9  15 4.9   0 4.9   3 4.9  13 5.0  -6 5.0  -8 5.0 -21 5.0  -9 5.1
 12 5.1 -12 5.1  -5 5.1  -2 5.1  -5 5.2 -15 5.2  -3 5.2  -4 5.2  19 5.2
 -9 5.3   8 5.4   0 5.4  18 5.4   0 5.4   9 5.4
;

/* RACOUNT data set, Page 363         */  

data racount;
    input ptpain tjcount sjcount @@;
    datalines;
68 25 23  66 23 23  50 16 18  75 23 20  67 26 25  50 22 18  39 18 21
50 18 10  41  8  7  29 11  9  60 20 21  55 17 12  18  7  3  46 13 16
37  9 17  59 11 13  68 18 24  96 27 27  47 16 12  64 24 13  72 18 17
51 10  8  43 14 12  55 12 20  51 14 12  80 13 19  77 24 18  80 23  9
42 12 12  11 12 14  42  8  9  26 16 24  60  8  8  77 12  6  45 16 10
16  7  6  58  9  4  53 12 10  90 10 10  63 12 14  57 18 15  69 27 19
78 13 12  76 14 17  18  8 10  49 12 15  17  8 10  70 23 22  84 16 20
46 16 19  46  7 13  50  7 11  58  9 13  18  8 10  73 14 10  75 15 13
69 20 13  75 21 19  61 16 17  64 12 15  16  2 20  37  9 11  58 11 12
68 23 24  60  8 11  34 12 20  54 19 18  70 12 17  94 10  5  46 17 16
49 23 22  82 13 16  55 10 13  67 22 20  56 17 13  38 11  8  68 12 10
48 15 12  47 11  8  81 16 15  34 12  7  52 14 19  58 24 22  69 16 10
51  5  6  64 19 21  15 15 12  22 10 11  45 10 11  49 19 10  83 18 20
70 17  9  33 10 11  15 10  4  17 13  9  52 17 17  48  7  5  47  5  7
47 16 12  20  9  9  38 10  9  39 12 12  45 14 12  52 11  8  37  7 12
60 13 13  69 20  7  34 12 20  82 15 15  60  8  7  15  8  6  69 12 16
59 10 10  70 13  5  35 12 16  32  8 14  59  5 15  88 23 10  67 28 25
75 12 21  85 13 21  53 16 12  83 12 17  64 11 15  36  7 10 100 26 21
91 13 24  55 12 11  64 17 14  56 14 13  49  8 10  71 10 13  65 21 19
75 18 17  85 26 21  79 14 18  50 10 14  74 26 21  46 15 13  65 19 15
50 17 11  34  9  6  30 14  9  55 23 12  61 19 14  66  9  6  82 20 12
70 16 11  83 28 20  17 14 13  59 11 12  58  9  6  54 12  8  59  7  6
55  9  4  83 26 12  18 12 11  51 10 12  65 22 11  23 24 11  51 22 15
50 26 15  49 13 12  49  8  6  50  9  5  29  9  9  39 15 11  26 10 19
65 14 14  36 12 11  88 25 25  42  8 15  66 20 18  73 16 16  80 24 24
53 25 12  82 21 21  73 16 13  89 25 14  86 24 13  37 20 16  39 10  9
31  6  4  50 11  6  25  6  4  18  9  7  18 12 14  46 13  5  39  8 14
60 19 19  58 21 15  68 12 16  56  6  6  50 16 20  56 10  5  31 12  9
70 16 14  77 12 15  54 11  7  53 24 20  68 16  9  77 18 14  42 16 12
67 26 25  76 26 14  51 16 10  20 26 24  92 14  7  60 18 11  48 25 23
71 17 13  66 13 11  74  9 11  75 14 13  66 18 14  44 13 12  41 10  9
34 23 18  50 24 21  41  9 12  57 18 10  64 15 13  67 15 14  47 17 15
61 19 17  64 24 18  58 11 11  42 14 12  16  7  6  39 23 20  23 11 10
64 18  6  85 12  7  68  9  9  51 15  5   9 10  7  41 17  8  80 22 18
78 18 15  69  8  6  19 13  9  60 23 16  47  9  4  38 14 14  77 19 10
68 14 11  87 24 17  60 22 21  82 24 23  31 21 21  77  7  8
;

/* %GlobalQSmooth macro, Page 364                                

%macro GlobalQSmooth(dataset,grid,gamma,p,outdata);
/*
Inputs:
 
DATASET = Data set to be analyzed
 
GRID    = Data set with grid points (X variable)
 
GAMMA   = Quantile of the conditional distribution function
 
P       = Degree of the polynomial approximation
 
OUTDATA = Output data set containing the polynomial (POLY variable),
          its first derivative (FIRSTDER variable) and second derivative
          (SECDER variable) evaluated at the grid points	
*/

data variable;
    set &dataset;
    array cov{*} cov1-cov&p;
    do i=1 to &p; cov{i}=x**i; end;
proc mixed data=variable;
    model y=cov1-cov&p/s;
    ods output SolutionF=param;
data equation;
    set param nobs=m;
    retain c0-c&p;
    if effect="Intercept" then c0=estimate;
    call symput("c0",compress(put(c0,best8.)));
    %do i=1 %to &p;
        if effect="cov&i" then c&i=estimate;
        call symput("c&i",compress(put(c&i,best8.)));
    %end;
    if _n_=m;
    run;
proc nlin data=variable nohalve maxiter=500 converge=0.0005;
    parms c0=&c0 %do i=1 %to &p; c&i=&&c&i %end;;
    model y=c0 %do i=1 %to &p; +c&i*cov&i %end;;
    der.c0=1;
    %do i=1 %to &p; der.c&i=cov&i; %end;
    resid=y-model.y;
    if resid>0 then _weight_=&gamma/resid;
    if resid<0 then _weight_=(&gamma-1)/resid;
    if resid=0 then _weight_=0;
    ods output ParameterEstimates=est;
data coef;
    set est nobs=m;
    retain d0-d&p;
    %do i=0 %to &p;
        if parameter="c&i" then d&i=estimate;
    %end;
    if _n_=m;
data &outdata;
    set &grid;
    if _n_=1 then set coef;
    array d{*} d1-d&p;
    poly=d0; firstder=d1;
    if &p>=2 then secder=2*d2; else secder=0;
    do i=1 to &p;
        poly=poly+d{i}*x**i;
        if i>=2 then firstder=firstder+i*d{i}*x**(i-1);
        if i>=3 then secder=secder+(i-1)*i*d{i}*x**(i-2);
    end;
    run;
%mend GlobalQSmooth;

/* %LocalQSmooth macro, Page 365                                 

%macro LocalQSmooth(dataset,gamma,initial,outdata);
/*
Inputs:
 
DATASET = Data set to be analyzed
 
GAMMA   = Quantile of the conditional distribution function
 
INITIAL = Data set with the grid points (X variable),
          initial values of the intercept and slope
          of the local linear model (POLY and FIRSTDER variables)
          and the bandwidth parameter (H variable)
 
OUTDATA = Output data set containing the local estimates
          of the quantile function evaluated at the grid points
          (ESTIMATE variable)
*/

data quantile;
data _null_;
    set &initial nobs=m;
    call symput("n",m);
	run;
%do i=1 %to &n;
data _null_;
    set &initial;
    if _n_=&i then do;
        call symput("x",x);		
        call symput("inita",poly);		
        call symput("initb",firstder);		
        call symput("h",h);		
    end;
    run;
proc nlin data=&dataset nohalve noitprint maxiter=300 converge=0.001;
    parms a=&inita b=&initb;
    model y=a+b*(x-&x);
    der.a=1; der.b=x-&x; resid=y-model.y;
    if resid>0 then w1=&gamma/resid;
    if resid<0 then w1=(&gamma-1)/resid;
    if resid=0 then w1=0;
    w2=pdf("normal",(x-&x)/&h)/&h; _weight_=w1*w2;
    ods output ParameterEstimates=est(where=(parameter="a"));
data result;
    set est;
    x=&x;
data quantile;
    set quantile result;
    keep x estimate;
%end;
data &outdata;
    set quantile;
    where x^=.;
    run;
%mend LocalQSmooth;

/* %TolLimit macro, Page 366         */   

%macro TolLimit(dataset,var,gamma,beta,outdata);
/*
Inputs:
 
DATASET = Data set to be analyzed
 
VAR     = Variable for which tolerance limits will be computed

GAMMA   = Content of the tolerance interval

BETA    = Confidence of the tolerance interval
 
OUTDATA = Data set with one-sided and two-sided tolerance limits

*/

data _null_;
    set &dataset nobs=m;
    call symput("n",compress(put(m,6.0)));
    run;
data _null_;
    prev1=probbeta(&gamma,&n,1);	
    do s=2 to &n; 
        next1=probbeta(&gamma,&n-s+1,s);
        if prev1<=1-&beta and next1>1-&beta then 
            call symput("rank1",compress(put(s-1,6.0)));        
        prev1=next1;
    end;
	prev2=probbeta(&gamma,&n-1,2);
    do s=2 to &n/2; 
        next2=probbeta(&gamma,&n-2*s+1,2*s);
        if prev2<=1-&beta and next2>1-&beta then 
            call symput("rank2",compress(put(s-1,6.0)));        
        prev2=next2;
    end;
    run;
proc rank data=&dataset out=ranks;
    var &var;
    ranks ranky;
proc sort data=ranks;
    by ranky;
data upper1;
    set ranks;
    if ranky>&n-&rank1+1 then delete;
data _null_;
    set upper1 nobs=m;	
    if _n_=m then call symput("upper1",compress(put(&var,best8.)));
data upper2;
    set ranks;
    if ranky>&n-&rank2+1 then delete;
data _null_;
    set upper2 nobs=m;	
    if _n_=m then call symput("upper2",compress(put(&var,best8.))); 
data lower2;
    set ranks;
    if ranky>&rank2 then delete;
data _null_;
    set lower2 nobs=m;	
    if _n_=m then call symput("lower2",compress(put(&var,best8.))); 
    run;
data &outdata;
    upper1=&upper1; lower2=&lower2; upper2=&upper2; 
    label upper1="Upper one-sided tolerance limit"
          upper2="Upper two-sided tolerance limit"
          lower2="Lower two-sided tolerance limit";
    run;
%mend TolLimit;

/* %VarPlot macro, Page 367         */    

%macro VarPlot(dataset,grid,q1,q2,q3,h,outdata);
/*
Inputs:

DATASET = Data set to be analyzed

GRID    = Data set with the grid points (X variable)

Q1, Q2, Q3
        = Low, middle and upper quantiles to be estimated

H       = Bandwidth parameter for local smoothing

OUTDATA = Output data set containing the local estimates
          of the three quantile functions evaluated at the grid points
          (ESTIMATE variable) as well as the raw data points
*/

%GlobalQSmooth(dataset=&dataset,grid=&grid,gamma=&q1,p=5,outdata=upper);
%GlobalQSmooth(dataset=&dataset,grid=&grid,gamma=&q2,p=5,outdata=mid);
%GlobalQSmooth(dataset=&dataset,grid=&grid,gamma=&q3,p=5,outdata=lower);
data initial;
    set upper; h=&h;
%LocalQSmooth(dataset=&dataset,gamma=&q1,initial=initial,outdata=q1);
data initial;
    set mid; h=&h;
%LocalQSmooth(dataset=&dataset,gamma=&q2,initial=initial,outdata=q2);
data initial;
    set lower; h=&h;
%LocalQSmooth(dataset=&dataset,gamma=&q3,initial=initial,outdata=q3);
data q1;
    set q1;
    quantile=1;
data q2;
    set q2;
    quantile=2;
data q3;
    set q3;
    quantile=3;
data rawdata;
    set &dataset;
    quantile=0;
    estimate=y;
data &outdata;
    set q1 q2 q3 rawdata;
%mend VarPlot;

/* %TolLimit macro, Page 366         */   

%macro TolLimit(dataset,var,gamma,beta,outdata);
/*
Inputs:
 
DATASET = Data set to be analyzed
 
VAR     = Variable for which tolerance limits will be computed

GAMMA   = Content of the tolerance interval

BETA    = Confidence of the tolerance interval
 
OUTDATA = Data set with one-sided and two-sided tolerance limits

*/

data _null_;
    set &dataset nobs=m;
    call symput("n",compress(put(m,6.0)));
    run;
data _null_;
    prev1=probbeta(&gamma,&n,1);	
    do s=2 to &n; 
        next1=probbeta(&gamma,&n-s+1,s);
        if prev1<=1-&beta and next1>1-&beta then 
            call symput("rank1",compress(put(s-1,6.0)));        
        prev1=next1;
    end;
	prev2=probbeta(&gamma,&n-1,2);
    do s=2 to &n/2; 
        next2=probbeta(&gamma,&n-2*s+1,2*s);
        if prev2<=1-&beta and next2>1-&beta then 
            call symput("rank2",compress(put(s-1,6.0)));        
        prev2=next2;
    end;
    run;
proc rank data=&dataset out=ranks;
    var &var;
    ranks ranky;
proc sort data=ranks;
    by ranky;
data upper1;
    set ranks;
    if ranky>&n-&rank1+1 then delete;
data _null_;
    set upper1 nobs=m;	
    if _n_=m then call symput("upper1",compress(put(&var,best8.)));
data upper2;
    set ranks;
    if ranky>&n-&rank2+1 then delete;
data _null_;
    set upper2 nobs=m;	
    if _n_=m then call symput("upper2",compress(put(&var,best8.))); 
data lower2;
    set ranks;
    if ranky>&rank2 then delete;
data _null_;
    set lower2 nobs=m;	
    if _n_=m then call symput("lower2",compress(put(&var,best8.))); 
    run;
data &outdata;
    upper1=&upper1; lower2=&lower2; upper2=&upper2; 
    label upper1="Upper one-sided tolerance limit"
          upper2="Upper two-sided tolerance limit"
          lower2="Lower two-sided tolerance limit";
    run;
%mend TolLimit;

/* %VarPlot macro, Page 367         */    

%macro VarPlot(dataset,grid,q1,q2,q3,h,outdata);
/*
Inputs:

DATASET = Data set to be analyzed

GRID    = Data set with the grid points (X variable)

Q1, Q2, Q3
        = Low, middle and upper quantiles to be estimated

H       = Bandwidth parameter for local smoothing

OUTDATA = Output data set containing the local estimates
          of the three quantile functions evaluated at the grid points
          (ESTIMATE variable) as well as the raw data points
*/

%GlobalQSmooth(dataset=&dataset,grid=&grid,gamma=&q1,p=5,outdata=upper);
%GlobalQSmooth(dataset=&dataset,grid=&grid,gamma=&q2,p=5,outdata=mid);
%GlobalQSmooth(dataset=&dataset,grid=&grid,gamma=&q3,p=5,outdata=lower);
data initial;
    set upper; h=&h;
%LocalQSmooth(dataset=&dataset,gamma=&q1,initial=initial,outdata=q1);
data initial;
    set mid; h=&h;
%LocalQSmooth(dataset=&dataset,gamma=&q2,initial=initial,outdata=q2);
data initial;
    set lower; h=&h;
%LocalQSmooth(dataset=&dataset,gamma=&q3,initial=initial,outdata=q3);
data q1;
    set q1;
    quantile=1;
data q2;
    set q2;
    quantile=2;
data q3;
    set q3;
    quantile=3;
data rawdata;
    set &dataset;
    quantile=0;
    estimate=y;
data &outdata;
    set q1 q2 q3 rawdata;
%mend VarPlot;

/* %EffDesign macro, Page 368       */    

%macro EffDesign(fraction, effsize, power, alpha, rho, boundary, sizepower);
/*
Inputs:
 
FRACTION = Input data set that contains fractions of the total sample 
           size accrued at successive analyses

EFFSIZE  = True effect size
 
POWER    = Power

ALPHA    = One-sided Type I error probability

RHO      = Shape parameter of stopping boundary
           (0.5 if Pocock boundary and 0 if O'Brien-Fleming boundary)

BOUNDARY = Output data set that contains stopping probabilities at scheduled 
           looks

SIZEPOWER= Output data set that contains average sample number and power for 
           selected effect sizes

*/
proc iml;
    start DriftSearch(d) global(m,critvalue,stfract,inc,infinity);        
        upper=critvalue*stfract##&rho;
        adjustment=d*stfract;
        boundary=infinity//(upper-adjustment);                     
        call seq(p,boundary) eps=1e-8 tscale=inc; 
        diff=abs(1-&power-(p[2,]-p[1,])[m]);          
        return(diff);
    finish;
    use &fraction;
    read all var _all_ into fraction;    
    m=nrow(fraction);    
    fract=t(fraction);    
    stfract=fract/fract[1];   
    inc=j(1,m-1,0);
    do i=1 to m-1;
        inc[i]=(fract[i+1]-fract[i])/fract[1];
    end;        
    infinity=repeat(.m,1,m);
    upper=stfract##&rho;
    boundary=infinity//upper;    
    call seqscale(prob,critvalue,boundary,1-&alpha) eps=1e-8 tscale=inc; 
    upper=critvalue*stfract##&rho;
    boundary=infinity//upper;    
    stopz=critvalue*stfract##(&rho-0.5);    
    stopp=1-probnorm(stopz);
    call seq(prob0,boundary) eps=1e-8 tscale=inc; 
    nfixed=2*((probit(&power)+probit(1-&alpha))/&effsize)**2;    
    start=&effsize*sqrt(nfixed*fract[1]/2);
    tc=repeat(.,1,12);
    tc[1]=100;
    tc[3]=1e-5;
    call nlpdd(rc,drift,"DriftSearch",start) tc=tc;
    max=2*(drift/&effsize)*(drift/&effsize)/fract[1];
    upper=critvalue*stfract##&rho;    
    adjustment=drift*stfract;
    boundary=infinity//(upper-adjustment);                 
    call seq(prob1,boundary) eps=1e-8 tscale=inc;   
    &boundary=j(m,8,0);
    &boundary[,1]=t(1:m);
    &boundary[,2]=ceil(cusum(fraction)*max);
    &boundary[,3]=t(stopz);
    &boundary[,4]=t(stopp);
    &boundary[,5]=t(prob0[3,]-prob0[2,]+prob0[1,]); 
    &boundary[,6]=t(cusum(prob0[3,]-prob0[2,]+prob0[1,]));     
    &boundary[,7]=t(prob1[3,]-prob1[2,]+prob1[1,]); 
    &boundary[,8]=t(cusum(prob1[3,]-prob1[2,]+prob1[1,]));             
    varnames={"Analysis", "Size", "TestStBoundary", "PValBoundary", "ProbH0", 
        "CumProbH0", "ProbH1", "CumProbH1"};    
    create &boundary from &boundary[colname=varnames];
    append from &boundary;    
    &sizepower=j(21,3,0);
    do i=0 to 20;
        upper=critvalue*stfract##&rho;
        adjustment=i*&effsize*sqrt(max*fract[1]/2)*stfract/10;
        boundary=infinity//(upper-adjustment);                     
        call seq(prob2,boundary) eps=1e-8 tscale=inc; 
        stop=prob2[3,]-prob2[2,]+prob2[1,]; 
        &sizepower[i+1,1]=i*&effsize/10;
        &sizepower[i+1,2]=ceil(max*(1-(1-fract)*stop`));   
        &sizepower[i+1,3]=1-(prob2[2,]-prob2[1,])[m]; 
    end;
    varnames={"EffSize", "AveSize", "Power"};    
    create &sizepower from &sizepower[colname=varnames];
    append from &sizepower;        
    summary=j(1,4,0);
    summary[1]=ceil(max); summary[2]=&sizepower[1,2]; 
    summary[3]=&sizepower[11,2];    
    summary[4]=ceil(nfixed);
    create summary from summary;
    append from summary;        
    quit; 
data summary;
    set summary;
    format value best6.;
    length par $50;
    par="One-sided Type I error probability"; 
        value=&alpha; output;    
    par="Power"; value=&power; output;
    par="True effect size"; value=&effsize; output;
    par="Stopping boundary parameter"; value=&rho; output;
    par="Maximum sample size per group"; value=col1; output;
    par="Average sample size per group under H0"; value=col2; output;
    par="Average sample size per group under H1"; value=col3; output;
    par="Fixed sample size per group"; value=col4; output;
    label par="Summary" value="Value";
    keep par value;
proc print data=summary noobs label;
    var par value;
data &boundary;
    set &boundary;
    format TestStBoundary PValBoundary ProbH0 CumProbH0 ProbH1 CumProbH1 6.4
        Analysis Size 4.0;
    label Analysis="Analysis"
          Size="Sample size per group"
          TestStBoundary="Stopping boundary (test statistic scale)"
          PValBoundary="Stopping boundary (p-value scale)"
          ProbH0="Stopping probability under H0"
          CumProbH0="Cumulative stopping probability under H0"
          ProbH1="Stopping probability under H1"
          CumProbH1="Cumulative stopping probability under H1";
data &sizepower;
    set &sizepower;
    format EffSize best6. AveSize 5.0;
    label EffSize="True effect size"
          AveSize="Average sample size per group"
          Power="Power";
    run;
%mend EffDesign;

/* %EffFutDesign macro, Page 370    */    

%macro EffFutDesign(fraction, effsize, power, alpha, rhoeff, rhofut, 
boundary, sizepower);
/*
Inputs:
 
FRACTION = Input data set that contains fractions of the total sample 
           size accrued at successive analyses

EFFSIZE  = True effect size
 
POWER    = Power

ALPHA    = One-sided Type I error probability

RHOEFF   = Shape parameter of upper (efficacy) stopping boundary
           (0.5 if Pocock boundary and 0 if O'Brien-Fleming boundary)

RHOFUT   = Shape parameter of lower (futility) stopping boundary
           (0.5 if Pocock boundary and 0 if O'Brien-Fleming boundary)

BOUNDARY = Output data set that contains stopping probabilities at scheduled 
           looks

SIZEPOWER= Output data set that contains average sample number and power for 
           selected effect sizes

*/
proc iml;
    start ParSearch(c) global(m,lastlook,stfract,inc);
        drift=(c[1]*lastlook##&rhoeff+c[2]*lastlook##&rhofut)/lastlook;
        upper=c[1]*stfract##&rhoeff;
        lower=drift*stfract-c[2]*stfract##&rhofut;
        lower[m]=lower[m]-1e-5;
        boundary=lower//upper;
        call seq(p,boundary) eps=1e-8 tscale=inc;
        crossh0=sum(p[3,]-p[2,])-&alpha;
        adjustment=drift*stfract;
        boundary=(lower-adjustment)//(upper-adjustment);
        call seq(p,boundary) eps=1e-8 tscale=inc;
        crossh1=sum(p[3,]-p[2,])-&power;
        diff=abs(crossh0)+abs(crossh1);
        return(diff);
    finish;
    use &fraction;
    read all var _all_ into fraction;    
    m=nrow(fraction);    
    fract=t(fraction);    
    stfract=fract/fract[1];   
    inc=j(1,m-1,0);
    do i=1 to m-1;
        inc[i]=(fract[i+1]-fract[i])/fract[1];
    end;     
    lastlook=stfract[m];
    nfixed=2*((probit(&power)+probit(1-&alpha))/&effsize)**2;      
    start={1 1};
    tc=repeat(.,1,12);
    tc[1]=100;
    tc[3]=1e-5;
    call nlpdd(rc,c,"ParSearch",start) tc=tc;
    drift=(c[1]*lastlook##&rhoeff+c[2]*lastlook##&rhofut)/lastlook;
    upper=c[1]*stfract##&rhoeff;
    lower=drift*stfract-c[2]*stfract##&rhofut;    
    lower[m]=lower[m]-1e-5;
    boundary=lower//upper;
    call seq(prob0,boundary) eps=1e-8 tscale=inc;    
    adjustment=drift*stfract;
    boundary=(lower-adjustment)//(upper-adjustment);               
    call seq(prob1,boundary) eps=1e-8 tscale=inc;
    upperz=(stfract##(-0.5))#upper;
    lowerz=(stfract##(-0.5))#lower;        
    upperp=1-probnorm(upperz);
    lowerp=1-probnorm(lowerz);
    max=2*(drift/&effsize)*(drift/&effsize)/fract[1];        
    boundary=j(m,10,0);
    boundary[,1]=t(1:m);
    boundary[,2]=ceil(cusum(fraction)*max);
    boundary[,3]=t(lowerz);
    boundary[,4]=t(upperz);
    boundary[,5]=t(lowerp);
    boundary[,6]=t(upperp);
    boundary[,7]=t(prob0[3,]-prob0[2,]+prob0[1,]); 
    boundary[,8]=t(cusum(prob0[3,]-prob0[2,]+prob0[1,]));     
    boundary[,9]=t(prob1[3,]-prob1[2,]+prob1[1,]); 
    boundary[,10]=t(cusum(prob1[3,]-prob1[2,]+prob1[1,]));             
    varnames={"Analysis", "Size", "LowerTestStBoundary", "UpperTestStBoundary",
        "LowerPValBoundary", "UpperPValBoundary", 
        "ProbH0", "CumProbH0", "ProbH1", "CumProbH1"};    
    create &boundary from boundary[colname=varnames];
    append from boundary;  
    sizepower=j(21,3,0);
    do i=0 to 20;          
        adjustment=i*drift*stfract/10;
        boundary=(lower-adjustment)//(upper-adjustment);           
        call seq(prob2,boundary) eps=1e-8 tscale=inc; 
        stop=prob2[3,]-prob2[2,]+prob2[1,]; 
        sizepower[i+1,1]=i*&effsize/10;
        sizepower[i+1,2]=ceil(max*(1-(1-fract)*stop`));   
        sizepower[i+1,3]=sum(prob2[3,]-prob2[2,]);*1-(prob2[2,]-prob2[1,])[m]; 
    end;
    varnames={"EffSize", "AveSize", "Power"};    
    create &sizepower from sizepower[colname=varnames];
    append from sizepower;        
    summary=j(1,4,0);
    summary[1]=ceil(max); summary[2]=sizepower[1,2]; summary[3]=sizepower[11,2];    
    summary[4]=ceil(nfixed);
    create summary from summary;
    append from summary;        
    quit;
data summary;
    set summary;
    format value best6.;
    length par $50;
    par="One-sided Type I error probability"; value=&alpha; output;    
    par="Power"; value=&power; output;
    par="True effect size"; value=&effsize; output;
    par="Shape parameter of upper boundary"; value=&rhoeff; output;
    par="Shape parameter of lower boundary"; value=&rhofut; output;
    par="Maximum sample size per group"; value=col1; output;
    par="Average sample size per group under H0"; value=col2; output;
    par="Average sample size per group under H1"; value=col3; output;
    par="Fixed sample size per group"; value=col4; output;
    label par="Summary" value="Value";
    keep par value;
proc print data=summary noobs label;
    var par value;
data &boundary;
    set &boundary;
    format LowerTestStBoundary UpperTestStBoundary LowerPValBoundary 
        UpperPValBoundary ProbH0 CumProbH0 ProbH1 CumProbH1 6.4 
        Analysis Size 4.0;
    label Analysis="Analysis"
          Size="Sample size per group"
          LowerTestStBoundary="Lower stopping boundary (test statistic scale)"
          UpperTestStBoundary="Upper stopping boundary (test statistic scale)"
          LowerPValBoundary="Lower stopping boundary (p-value scale)"
          UpperPValBoundary="Upper stopping boundary (p-value scale)"
          ProbH0="Stopping probability under H0"
          CumProbH0="Cumulative stopping probability under H0"
          ProbH1="Stopping probability under H1"
          CumProbH1="Cumulative stopping probability under H1";
data &sizepower;
    set &sizepower;
    format EffSize best6. AveSize 5.0;
    label EffSize="True effect size"
          AveSize="Average sample size per group"
          Power="Power";
    run;    
%mend EffFutDesign;

/* %EffMonitor macro, Page 373      */    

%macro EffMonitor(fraction, data, effsize, power, alpha, rho, spfunction, 
sprho, decision, inference);
/*
Inputs:
 
FRACTION  = Input data set that contains fractions of the total sample 
            size accrued at successive analyses.

DATA      = Input data set containing summary statistics computed at each
            analysis. The data set must include the following two variables:
            N is the number of patients in each treatment group (or the 
            average of the numbers of patients if they are not the same) 
            and STAT is the value of a normally distributed test statistic.

EFFSIZE   = True effect size.
 
POWER     = Power.

ALPHA     = One-sided Type I error probability.

RHO       = Shape parameter of stopping boundary
            (0.5 if Pocock boundary and 0 if O'Brien-Fleming boundary).

SPFUNCTION= Error spending function code (1, design-based function; 
            2, ten-look function; 3, a function the Lan-DeMets family; 
            4, a function from the Jennison-Turnbull family; 
            5, a function from the Hwang-Shih-DeCani family).

SPRHO     = Shape parameter of the error spending function.

DECISION  = Output data set that contains stopping boundaries and 
            probabilities as well as one-sided repeated confidence 
            intervals for treatment difference at each interim look.

INFERENCE = Output data set containing bias-adjusted estimate of treatment
            effect with a one-sided confidence interval computed at the 
            last look.

*/
proc iml;
    start DriftSearch(d) global(m,critvalue,stfract,inc,infinity);        
        upper=critvalue*stfract##&rho;
        adjustment=d*stfract;
        boundary=infinity//(upper-adjustment);                     
        call seq(p,boundary) eps=1e-8 tscale=inc; 
        diff=abs(1-&power-(p[2,]-p[1,])[m]);          
        return(diff);
    finish;
    start BoundSearch(new) global(stage,alpha,adjbound,sinf,infinc);
        alphainc=alpha[stage]-alpha[stage-1];
        tempb=t(adjbound[1:stage]#sqrt(sinf[1:stage]));
        tempb[stage]=new*sqrt(sinf[stage]);
        tempinf=repeat(.m,1,stage);
        tempinc=t(infinc[1:stage-1]);
        boundary=tempinf//tempb;        
        call seq(p,boundary) eps=1e-8 tscale=tempinc;
        diff=abs(p[3,stage]-p[2,stage]-alphainc);
        return(diff);
    finish;
    start AdjQuant(est) global(quantile,sall,observed,tempinc,infinity);
        adjustment=est*sall;
        upper=observed#(sall##0.5);
        boundary=infinity//(upper-adjustment);        
        call seq(prob,boundary) eps=1e-8 tscale=tempinc;         
        sss=sum(prob[3,]-prob[2,]);        
        diff=abs(quantile-sss);            
        return(diff);
    finish;
    use &fraction;
    read all var _all_ into fraction;    
    m=nrow(fraction);    
    fract=t(fraction);    
    stfract=fract/fract[1];   
    inc=j(1,m-1,0);
    do i=1 to m-1;
        inc[i]=(fract[i+1]-fract[i])/fract[1];
    end;       
    infinity=repeat(.m,1,m);
    upper=stfract##&rho;
    boundary=infinity//upper;    
    call seqscale(prob,critvalue,boundary,1-&alpha) eps=1e-8 tscale=inc;    
    upper=critvalue*stfract##&rho;
    boundary=infinity//upper;    
    call seq(prob1,boundary) eps=1e-8 tscale=inc;
    spend1=cusum(prob1[3,]-prob1[2,]+prob1[1,]);     
    beta=1-&power;
    nfixed=2*((probit(&power)+probit(1-&alpha))/&effsize)**2;    
    start=&effsize*sqrt(nfixed*fract[1]/2);
    tc=repeat(.,1,12);
    tc[1]=100;
    tc[3]=1e-5;
    call nlpdd(rc,drift,"DriftSearch",start) tc=tc;
    max=2*(drift/&effsize)*(drift/&effsize)/fract[1];    
    use &data;
    read all var {n stat} into mon;
    n=nrow(mon);    
    ss=mon[,1];    
    infofrac=ss/max;        
    statistic=mon[,2];
    pvalue=1-probnorm(mon[,2]);
    sinf=infofrac/infofrac[1];
    if n>1 then do;
        infinc=j(1,n-1,0);
        do i=1 to n-1;
            infinc[i]=sinf[i+1]-sinf[i];
        end;
    end;
    else infinc=j(1,1,1);
    alpha=j(n,1,0);
    level=j(n,1,0);
    adjbound=j(n,1,0);
    tc=repeat(.,1,12);
    tc[1]=200;
    tc[3]=1e-6;   
    * Design-based error spending function;
    if &spfunction=1 then 
    do;    
        t=0 || fract;
        s=0 || spend1;        
        do stage=1 to n;
            x=infofrac[stage];
            do i=1 to m;
                if t[i]<=x & x<t[i+1] then
                    alpha[stage]=(s[i+1]*(x-t[i])+s[i]*(t[i+1]-x))/
                        (t[i+1]-t[i]);
            end;
            if x>=1 then alpha[stage]=&alpha;         
        end;        
    end;
    * Ten-look error spending function;
    if &spfunction=2 then 
    do;
        k=10;
        infinity=repeat(.m,1,k);
        upper=(1:k)##&rho;
        boundary=infinity//upper;
        call seqscale(prob,critvalue,boundary,1-&alpha) eps=1e-8;
        upper=critvalue*(1:k)##&rho;
        boundary=infinity//upper;
        call seq(prob0,boundary) eps=1e-8;
        spend=t(cusum(prob0[3,]-prob0[2,]+prob0[1,]));   
        do stage=1 to n;
            x=infofrac[stage];
            if x<1 then do;
                l=floor(k*x); u=floor(k*x)+1;
                alpha[stage]=spend[l]+(k*x-l)*(spend[u]-spend[l])/(u-l);
            end;                    
            if x>=1 then alpha[stage]=&alpha;            
        end;                    
    end;
    * Lan-DeMets error spending function;
    if &spfunction=3 then 
    do;
        do stage=1 to n;
            x=infofrac[stage];
            if x<1 & &sprho=0 then alpha[stage]=2-
                2*probnorm(probit(1-&alpha/2)/sqrt(x));
            if x<1 & &sprho=0.5 then alpha[stage]=&alpha*log(1+(exp(1)-1)*x);
            if x>=1 then alpha[stage]=&alpha;
        end;          
    end;
    * Jennison-Turnbull error spending function;
    if &spfunction=4 then 
    do;
        do stage=1 to n;
            x=infofrac[stage];            
            if x<1 then alpha[stage]=&alpha*(x**&sprho);
            if x>=1 then alpha[stage]=&alpha;
        end; 
    end;
    * Hwang-Shih-DeCani error spending function;
    if &spfunction=5 then 
    do;
        do stage=1 to n;
            x=infofrac[stage];            
            if x<1 & &sprho^=0 then alpha[stage]=
                &alpha*(1-exp(-&sprho*x))/(1-exp(-&sprho));
            if x<1 & &sprho=0 then alpha[stage]=&alpha*x;
            if x>=1 then alpha[stage]=&alpha;
        end; 
    end;
    do stage=1 to n;
        if stage=1 then do;
            adjbound[1]=probit(1-alpha[1]);
            level[1]=alpha[1];
        end;
        if stage>1 then do;                        
            new=probit(1-alpha[stage]);
            call nlpdd(rc,adj,"BoundSearch",new) tc=tc;
            adjbound[stage]=adj;
            level[stage]=1-probnorm(adj);
        end;
    end;
    lowercl=(statistic-adjbound)#sqrt(2/ss);
    reject=(statistic>adjbound);        
    stop=0;
    do i=1 to n;
        if reject[i]=1 & stop=0 then stop=i;
    end;
    if stop=0 then last=n; else last=stop;     
    observed=t(adjbound[1:last]);
    observed[last]=statistic[last];
    tall=t(ss[1:last]);    
    k=ncol(tall);
    tall=tall/tall[k];
    sall=tall/tall[1];    
    tempinc=j(1,k-1,0);
    do i=1 to k-1;
        tempinc[i]=sall[i+1]-sall[i];
    end;      
    infinity=repeat(.m,1,k);    
    tc=repeat(.,1,12);
    tc[1]=100;
    tc[3]=1e-5;
    inference=j(2,1,.);
    quantile=0.5;
    est=statistic[last];  
    call nlpdd(rc,qest,"AdjQuant",est) tc=tc;
    qest=&effsize*qest/drift;
    inference[1]=qest;            
    quantile=&alpha;
    est=((statistic-probit(1-&alpha))#sqrt(2/ss))[last];    
    est=est*drift/&effsize;    
    call nlpdd(rc,qest,"AdjQuant",est) tc=tc;
    qest=&effsize*qest/drift;
    inference[2]=qest;    
    create &inference from inference;
    append from inference;
    &decision=j(last,9,0);
    &decision[,1]=t(1:last);
    &decision[,2]=ss[1:last];
    &decision[,3]=infofrac[1:last];
    &decision[,4]=statistic[1:last];
    &decision[,5]=pvalue[1:last];
    &decision[,6]=adjbound[1:last];
    &decision[,7]=level[1:last];
    &decision[,8]=lowercl[1:last];
    &decision[,9]=reject[1:last];
    varnames={"Analysis", "Size", "Fraction", "TestStatistic", "PValue",
        "TestStBoundary", "PValBoundary", "LowerLimit", "Reject"};
    create &decision from &decision[colname=varnames];
    append from &decision;
    quit;
%let conf=%sysevalf(100*(1-&alpha));
data &inference;
    set &inference;
    length par $50;
    format value best6.;    
    if _n_=1 then par="Median unbiased estimate"; value=col1;     
    if _n_=2 then par="Lower &conf.% confidence limit"; value=col1;     
    label par="Parameter" value="Value";
    keep par value;
data &decision;
    set &decision;
    format TestStatistic PValue TestStBoundary PValBoundary LowerLimit
        Fraction 6.4 Analysis Size 4.0;
    length Decision $10.;
    label Analysis="Analysis"
          Size="Sample size per group"
          Fraction="Sample size fraction"
          TestStatistic="Test statistic"
          PValue="P-value"
          TestStBoundary="Stopping boundary (test statistic scale)"
          PValBoundary="Stopping boundary (p-value scale)"
          LowerLimit="Lower &conf.% repeated confidence limit"        
          Decision="Decision";
    if reject=0 then decision="Continue"; else decision="Reject H0";
    drop reject;
    run;
%mend EffMonitor;

/* %EffFutMonitor macro, Page 378   */    

%macro EffFutMonitor(fraction,data,effsize,power,alpha,rhoeff,rhofut,
    spfunction,sprho,decision,inference);
/*
Inputs:
 
FRACTION  = Input data set that contains fractions of the total sample 
            size accrued at successive analyses.

DATA      = Input data set containing summary statistics computed at each analysis.
            The data set must include the following two variables: N is the number of 
            patients in each treatment group (or the average of the numbers of 
            patients if they are not the same) and STAT is the value of a normally 
            distributed test statistic.

EFFSIZE   = True effect size.
 
POWER     = Power.

ALPHA     = One-sided Type I error probability.

RHOEFF   = Shape parameter of upper (efficacy) stopping boundary
           (0.5 if Pocock boundary and 0 if O'Brien-Fleming boundary)

RHOFUT   = Shape parameter of lower (futility) stopping boundary
           (0.5 if Pocock boundary and 0 if O'Brien-Fleming boundary)

SPFUNCTION= Error spending function code (1, design-based function; 2, ten-look function;
            3, a function the Lan-DeMets family; 4, a function from the Jennison-Turnbull
            family; 5, a function from the Hwang-Shih-DeCani family).

SPRHO     = Shape parameter of the error spending function.

DECISION  = Output data set that contains stopping boundaries and probabilities as well as 
            one-sided repeated confidence intervals for treatment difference at each interim 
            look.

INFERENCE = Output data set containing bias-adjusted estimate of treatment effect 
            with a one-sided confidence interval computed at the last look.
*/
proc iml;        
    start ParSearch(c) global(lastlook,scf,scale);
        drift=(c[1]*lastlook##&rhoeff+c[2]*lastlook##&rhofut)/lastlook;
        upper=c[1]*scf##&rhoeff;
        lower=drift*scf-c[2]*scf##&rhofut;
        length=ncol(lower);
        lower[length]=lower[length]-1e-5;
        boundary=lower//upper;
        call seq(p,boundary) eps=1e-8 tscale=scale;
        crossh0=sum(p[3,]-p[2,])-&alpha;
        adjustment=drift*scf;
        boundary=(lower-adjustment)//(upper-adjustment);
        call seq(p,boundary) eps=1e-8 tscale=scale;
        crossh1=sum(p[3,]-p[2,])-&power;
        diff=abs(crossh0)+abs(crossh1);
        return(diff);
    finish;
    start BoundSearch(guess) global(stage,alpha,beta,adjlower,adjupper,
        ss,sinf,infinc);        
        if guess[1]>guess[2] then do;
            alphainc=alpha[stage]-alpha[stage-1];
            betainc=beta[stage]-beta[stage-1];        
            tempupp=t(adjupper[1:stage]#sqrt(sinf[1:stage]));
            templow=t(adjlower[1:stage]#sqrt(sinf[1:stage]));
            tempinc=t(infinc[1:stage-1]);
            tempupp[stage]=guess[1]*sqrt(sinf[stage]);
            templow[stage]=guess[2]*sqrt(sinf[stage]);                        
            boundary=templow//tempupp;                
            call seq(p,boundary) eps=1e-8 tscale=tempinc;
            crossh0=p[3,stage]-p[2,stage]-alphainc;
            adjustment=&effsize*t(sqrt(ss[1:stage]#sinf[1:stage]/2));
            boundary=(templow-adjustment)//(tempupp-adjustment);
            call seq(p,boundary) eps=1e-8 tscale=tempinc;
            crossh1=p[1,stage]-betainc;                
            diff=abs(crossh0)+abs(crossh1);                
            return(diff);
        end;
        if guess[1]<=guess[2] then do;
            diff=1;                
            return(diff);
        end;
    finish;  
    start AdjQuant(est) global(quantile,sall,observed,tempinc,infinity);
        adjustment=est*sall;
        upper=observed#(sall##0.5);
        boundary=infinity//(upper-adjustment);        
        call seq(prob,boundary) eps=1e-8 tscale=tempinc;         
        sss=sum(prob[3,]-prob[2,]);        
        diff=abs(quantile-sss);            
        return(diff);
    finish;
    use &fraction;
    read all var _all_ into fraction;    
    m=nrow(fraction);    
    fract=t(fraction);    
    stfract=fract/fract[1];   
    inc=j(1,m-1,0);
    do i=1 to m-1;
        inc[i]=(fract[i+1]-fract[i])/fract[1];
    end;   
    nfixed=2*((probit(&power)+probit(1-&alpha))/&effsize)**2;   
    start={1 1};
    tc=repeat(.,1,12);
    tc[1]=100;
    tc[3]=1e-5;
    lastlook=stfract[m];
    scf=stfract;
    scale=inc;
    call nlpdd(rc,c,"ParSearch",start) tc=tc;
    drift=(c[1]*lastlook##&rhoeff+c[2]*lastlook##&rhofut)/lastlook;
    max=2*(drift/&effsize)*(drift/&effsize)/fract[1];        
    upper=c[1]*stfract##&rhoeff;
    lower=drift*stfract-c[2]*stfract##&rhofut;  
    lower[m]=lower[m]-1e-5;  
    boundary=lower//upper;
    call seq(prob0,boundary) eps=1e-8 tscale=inc;    
    alspend=cusum(prob0[3,]-prob0[2,]);
    adjustment=drift*stfract;
    boundary=(lower-adjustment)//(upper-adjustment);               
    call seq(prob1,boundary) eps=1e-8 tscale=inc;    
    bespend=cusum(prob1[1,]);    
    use &data;
    read all var {n stat} into mon;
    n=nrow(mon);    
    ss=mon[,1];    
    infofrac=ss/max;        
    statistic=mon[,2];
    pvalue=1-probnorm(statistic);
    sinf=infofrac/infofrac[1];
    infinc=j(1,n-1,0);
    do i=1 to n-1;
        infinc[i]=sinf[i+1]-sinf[i];
    end;
    alpha=j(n,1,0);
    beta=j(n,1,0);    
    * Design-based error spending function;
    if &spfunction=1 then 
    do;    
        t=0 || fract;
        a=0 || alspend;
        b=0 || bespend;
        do stage=1 to n;
            x=infofrac[stage];
            do i=1 to m;
                if t[i]<=x & x<t[i+1] then do;
                    alpha[stage]=(a[i+1]*(x-t[i])+a[i]*(t[i+1]-x))/
                        (t[i+1]-t[i]);
                    beta[stage]=(b[i+1]*(x-t[i])+b[i]*(t[i+1]-x))/
                        (t[i+1]-t[i]);
                end;
            end;
            if x>=1 then do; 
                alpha[stage]=&alpha; 
                beta[stage]=1-&power; 
            end;
        end;
    end;
    * Ten-look error spending function;
    if &spfunction=2 then 
    do;
        k=10;
        t=repeat(0.1,1,10);        
        cf=cusum(t);        
        scf=cf/cf[1];   
        in=j(1,k-1,0);
        do i=1 to k-1;
            in[i]=t[i+1]/t[1];
        end;   
        start={1 1};
        tc=repeat(.,1,12);
        tc[1]=100;
        tc[3]=1e-5;        
        lastlook=k;                
        scale=in;
        call nlpdd(rc,c,"ParSearch",start) tc=tc;
        drift=(c[1]*lastlook##&rhoeff+c[2]*lastlook##&rhofut)/lastlook;
        upper=c[1]*scf##&rhoeff;
        lower=drift*scf-c[2]*scf##&rhofut;    
        boundary=lower//upper;
        call seq(prob0,boundary) eps=1e-8 tscale=in;    
        als=cusum(prob0[3,]-prob0[2,]);
        adjustment=drift*scf;
        boundary=(lower-adjustment)//(upper-adjustment);               
        call seq(prob1,boundary) eps=1e-8 tscale=in;    
        bes=cusum(prob1[1,]);
        do stage=1 to n;
            x=infofrac[stage];
            if x<1 then do;
                l=floor(k*x); u=floor(k*x)+1;
                alpha[stage]=als[l]+(k*x-l)*(als[u]-als[l])/(u-l);
                beta[stage]=bes[l]+(k*x-l)*(bes[u]-bes[l])/(u-l);
            end;                    
            if x>=1 then do;
                alpha[stage]=&alpha;  
                beta[stage]=1-&power;  
            end;
        end;                    
    end;
    * Lan-DeMets error spending function;
    if &spfunction=3 then 
    do;
        do stage=1 to n;
            x=infofrac[stage];
            if x<1 & &sprho=0 then alpha[stage]=2-
                2*probnorm(probit(1-&alpha/2)/sqrt(x));
            if x<1 & &sprho=0.5 then alpha[stage]=&alpha*log(1+(exp(1)-1)*x);
            if x>=1 then alpha[stage]=&alpha;
        end;          
    end;
    * Jennison-Turnbull error spending function;
    if &spfunction=4 then 
    do;
        do stage=1 to n;
            x=infofrac[stage];            
            if x<1 then alpha[stage]=&alpha*(x**&sprho);
            if x>=1 then alpha[stage]=&alpha;
        end; 
    end;
    * Hwang-Shih-DeCani error spending function;
    if &spfunction=5 then 
    do;
        do stage=1 to n;
            x=infofrac[stage];            
            if x<1 & &sprho^=0 then alpha[stage]=
                &alpha*(1-exp(-&sprho*x))/(1-exp(-&sprho));
            if x<1 & &sprho=0 then alpha[stage]=&alpha*x;
            if x>=1 then alpha[stage]=&alpha;
        end; 
    end;      
    adjlower=j(n,1,0);
    adjupper=j(n,1,0);    
    adjlowp=j(n,1,0);
    adjuppp=j(n,1,0);
    reject=j(n,1,0);
    guess=j(1,2,0);
    tc=repeat(.,1,12);
    tc[1]=100;
    tc[3]=1e-5;        
    do stage=1 to n;    
        if stage=1 then do;
            adjupper[1]=probit(1-alpha[1]);
            stdelta=&effsize*sqrt(ss[1]/2);
            adjlower[1]=stdelta+probit(beta[1]);    
            adjuppp[1]=alpha[1];
            adjlowp[1]=1-probnorm(adjlower[1]);            
        end;        
        if stage>1 then do;
            guess[1]=probit(1-alpha[stage]);
            stdelta=&effsize*sqrt(ss[stage]/2);        
            guess[2]=stdelta+probit(beta[stage]);          
            call nlpdd(rc,adj,"BoundSearch",guess) tc=tc;
            adjupper[stage]=adj[1];
            adjlower[stage]=adj[2];
            adjuppp[stage]=1-probnorm(adj[1]);
            adjlowp[stage]=1-probnorm(adj[2]);
        end;
    end;  
    lowercl=(statistic-adjupper)#sqrt(2/ss);
    reject=(statistic>adjupper)-(statistic<adjlower);         
    stop=0;
    do i=1 to n;        
        if reject[i]^=0 & stop=0 then stop=i;
    end;    
    if stop=0 then last=n; else last=stop;    
    observed=t(adjupper[1:last]);
    observed[last]=statistic[last];
    tall=t(ss[1:last]);    
    k=ncol(tall);
    tall=tall/tall[k];
    sall=tall/tall[1];    
    tempinc=j(1,k-1,0);
    do i=1 to k-1;
        tempinc[i]=sall[i+1]-sall[i];
    end;      
    infinity=repeat(.m,1,k);    
    tc=repeat(.,1,12);
    tc[1]=100;
    tc[3]=1e-5;
    inference=j(2,1,.);
    quantile=0.5;
    est=statistic[last];  
    call nlpdd(rc,qest,"AdjQuant",est) tc=tc;
    qest=&effsize*qest/drift;
    inference[1]=qest;            
    quantile=&alpha;
    est=((statistic-probit(1-&alpha))#sqrt(2/ss))[last];    
    est=est*drift/&effsize;    
    call nlpdd(rc,qest,"AdjQuant",est) tc=tc;
    qest=&effsize*qest/drift;
    inference[2]=qest;    
    create &inference from inference;
    append from inference;
    &decision=j(last,11,0);
    &decision[,1]=t(1:last);
    &decision[,2]=ss[1:last];
    &decision[,3]=infofrac[1:last];
    &decision[,4]=statistic[1:last];
    &decision[,5]=pvalue[1:last];
    &decision[,6]=adjupper[1:last];
    &decision[,7]=adjlower[1:last];
    &decision[,8]=adjuppp[1:last];
    &decision[,9]=adjlowp[1:last];
    &decision[,10]=lowercl[1:last];    
    &decision[,11]=reject[1:last];
    varnames={"Analysis", "Size", "Fraction", "TestStatistic", "PValue",
        "UpperTestStBoundary", "LowerTestStBoundary", "UpperPValBoundary", 
        "LowerPValBoundary", "LowerLimit", "Reject"};
    create &decision from &decision[colname=varnames];
    append from &decision;
    quit;
%let conf=%sysevalf(100*(1-&alpha));
data &inference;
    set &inference;
    length par $50;
    format value best6.;    
    if _n_=1 then par="Median unbiased estimate"; value=col1;     
    if _n_=2 then par="Lower &conf.% confidence limit"; value=col1;     
    label par='Parameter' value='Value';
    keep par value;
data &decision;
    set &decision;
    format TestStatistic PValue UpperTestStBoundary LowerTestStBoundary 
        UpperPValBoundary LowerPValBoundary LowerLimit Fraction 6.4 Analysis Size 4.0;
    length Decision $10.;
    label Analysis='Analysis'
          Size='Sample size per group'
          Fraction='Sample size fraction'
          TestStatistic='Test statistic'
          PValue='P-value'
          UpperTestStBoundary='Upper stopping boundary (test statistic scale)'
          LowerTestStBoundary='Lower stopping boundary (test statistic scale)'
          UpperPValBoundary='Upper stopping boundary (p-value scale)'
          LowerPValBoundary='Lower stopping boundary (p-value scale)'
          LowerLimit="Lower &conf.% repeated confidence limit"
          Decision='Decision';
    if reject=0 then decision='Continue'; 
    if reject=1 then decision='Reject H0';
    if reject=-1 then decision='Reject H1';
    drop reject;
    run;
%mend EffFutMonitor;

/* %CondPowerLSH macro, Page 384    */    

%macro CondPowerLSH(data,effsize,alpha,gamma,nn,prob,boundary);
/*
Inputs:

DATA    = Data set to be analyzed (includes number of patients per
          group and test statistic at each interim look)

EFFSIZE = Hypothesized effect size

ALPHA   = One-sided Type I error probability of the significance 
          test carried out at the end of the trial

GAMMA   = Futility index

NN      = Projected number of patients per treatment group

PROB    = Name of an output data set containing conditional power
          at each interim look

BOUNDARY= Name of an output data set containing stopping boundary
          of the conditional power test

*/
proc iml;
    use &data;
    read all var {n teststat} into data;
    m=nrow(data); 
    n=data[,1]; 
    teststat=data[,2]; 
    prob=j(m,4,0);
    prob[,1]=t(1:m);
    prob[,2]=n/&nn;
    prob[,3]=teststat;
    prob[,4]=1-probnorm((sqrt(&nn)*probit(1-&alpha)-sqrt(n)#teststat
        -(&nn-n)*&effsize/sqrt(2))/sqrt(&nn-n));    
    varnames={"Analysis" "Fraction" "TestStat" "CondPower"};    
    create &prob from prob[colname=varnames];
    append from prob;        
    bound=j(50,2,0);
    frac=(1:50)*&nn/50;
    bound[,1]=t(frac/&nn);
    bound[,2]=t(sqrt(&nn/frac)*probit(1-&alpha)+sqrt((&nn-frac)/frac)
            *probit(1-&gamma)-&effsize*(&nn-frac)/sqrt(2*frac));    
    varnames={"Fraction" "StopBoundary"};    
    create &boundary from bound[colname=varnames];
    append from bound;        
    quit;     
data &prob;
    set &prob;
    format Fraction 4.2 TestStat 7.4 CondPower 6.4;
    label Fraction="Fraction of total sample size"
          TestStat="Test statistic"
          CondPower="Conditional power";
%mend CondPowerLSH;

/* %CondPowerPAB macro, Page 385    */    

%macro CondPowerPAB(data,alpha,gamma,c,nn,prob,boundary);
/*********************************************************
Inputs:

DATA    = Data set to be analyzed (includes number of patients per
          group and test statistic at each interim look)

ALPHA   = One-sided Type I error probability of the significance 
          test carried out at the end of the trial

GAMMA   = Futility index

C       = Parameter determining the shape of the stopping boundary 
          (Pepe and Anderson (1992) set C to 1 and Betensky (1997)
          recommended to set C to 2.326)

NN      = Projected number of patients per treatment group

PROB    = Name of an output data set containing conditional power
          at each interim look

BOUNDARY= Name of an output data set containing stopping boundary
          of the conditional power test

*********************************************************/
proc iml;
    use &data;
    read all var {n teststat} into data;
    m=nrow(data); 
    n=data[,1]; 
    teststat=data[,2]; 
    prob=j(m,4,0);
    prob[,1]=t(1:m);
    prob[,2]=n/&nn;
    prob[,3]=teststat;
    prob[,4]=1-probnorm((sqrt(&nn)*probit(1-&alpha)-sqrt(n)#teststat
        -(&nn-n)#(teststat+&c)/sqrt(n))/sqrt(&nn-n));
    varnames={"Analysis" "Fraction" "TestStat" "CondPower"};    
    create &prob from prob[colname=varnames];
    append from prob;        
    bound=j(50,2,0);
    frac=(1:50)*&nn/50;
    bound[,1]=t(frac/&nn);
    bound[,2]=t(sqrt(frac/&nn)*probit(1-&alpha)+sqrt(frac#(&nn-frac)/
        (&nn*&nn))*probit(1-&gamma)-&c*(&nn-frac)/&nn);    
    varnames={"Fraction" "StopBoundary"};    
    create &boundary from bound[colname=varnames];
    append from bound;    	    
    quit;     
data &prob;
    set &prob;
    format Fraction 4.2 TestStat 7.4 CondPower 6.4;
    label Fraction="Fraction of total sample size"
          TestStat="Test statistic"
          CondPower="Conditional power";
%mend CondPowerPAB;

/* %BayesFutilityCont macro, Page 386 */    

%macro BayesFutilityCont(data,par,delta,eta,alpha,prob);
/*
Inputs:

DATA    = Data set to be analyzed (includes number of patients,
          estimated mean treatment effects and sample standard 
          deviations in two treatment groups at each interim look)

PAR     = Name of an input data set with projected sample size in 
          each treatment group and parameters of prior distributions

DELTA   = Clinically significant difference (required by Bayesian 
          predictive probability method and ignored by predictive 
          power method)

ETA     = Confidence level of Bayesian predictive probability method
          (required by Bayesian predictive probability method and 
          ignored by predictive power method)

ALPHA   = One-sided Type I error probability of the significance 
          test carried out at the end of the trial (required by 
          predictive power method and ignored by Bayesian predictive
          probability method

PROB    = Name of an output data set containing predictive power and 
          predictive probability at each interim look

*/
proc iml;    
    use &data;
    read all var {n1 mean1 sd1 n2 mean2 sd2} into data;
    n=(data[,1]+data[,4])/2;
    s=sqrt(((data[,1]-1)#data[,3]#data[,3]+(data[,4]-1)
        #data[,6]#data[,6])/(data[,1]+data[,4]-2));	
    z=(data[,2]-data[,5])/(s#sqrt(1/data[,1]+1/data[,4]));    
    m=nrow(data);
    use &par;
    read all var {nn1 nn2 mu1 mu2 sigma} into par;
    nn=(par[,1]+par[,2])/2;
    sigma=par[,5];
    a1=(n-nn)/nn+(nn-n)/(nn#(1+(s/sigma)#(s/sigma)/n));
    b1=sqrt(n/(2*nn))#(nn-n)#(par[,3]-par[,4])/(1+n#(sigma/s)
        #(sigma/s));
    c1=1/(1+n#(sigma/s)#(sigma/s));
    output=j(m,4,0);
    output[,1]=t(1:m);
    output[,2]=n/nn;
    num1=sqrt(nn)#z#(1+a1)+b1/s-sqrt(n)*probit(1-&alpha);
    den1=sqrt((nn-n)#((nn-n)#(1-c1)+n)/nn);
    output[,3]=probnorm(num1/den1);      
    an=1/(1+n#(sigma/s)#(sigma/s));
    ann=1/(1+nn#(sigma/s)#(sigma/s));	
    b2=sqrt(n#nn/2)#(par[,3]-par[,4])/(1+n#(sigma/s)#(sigma/s));
    c2=1-1/sqrt(1+(s/sigma)#(s/sigma)/nn);
    num2=sqrt(nn)#z#(1-an)+b2/s-(&delta/s)#sqrt(n#nn/2)-sqrt(n)
        #(1-c2)*probit(&eta);
    den2=sqrt((1-ann)#(1-ann)#(nn-n)#((nn-n)#(1-an)+n)/nn);
    output[,4]=probnorm(num2/den2);      
    varnames={"Analysis", "Fraction", "PredPower", "PredProb"};
    create &prob from output[colname=varnames];
    append from output;    
    quit;
data &prob;
    set &prob;
    format Fraction 4.2 PredPower PredProb 6.4;
    label Fraction="Fraction of total sample size"          
          PredPower="Predictive power"
          PredProb="Predictive probability";
%mend BayesFutilityCont;

/* %BayesFutilityBin macro, Page 387 */    

%macro BayesFutilityBin(data,par,delta,eta,alpha,prob);
/*********************************************************
Inputs:

DATA    = Data set to be analyzed (includes number of patients and
          observed event counts in two treatment groups at each 
          interim look)

PAR     = Name of an input data set with projected sample size in 
          each treatment group and parameters of prior distributions

DELTA   = Clinically significant difference (required by Bayesian 
          predictive probability method and ignored by predictive 
          power method)

ETA     = Confidence level of Bayesian predictive probability method
          (required by Bayesian predictive probability method and 
          ignored by predictive power method)

ALPHA   = One-sided Type I error probability of the significance 
          test carried out at the end of the trial (required by 
          predictive power method and ignored by Bayesian predictive
          probability method

PROB    = Name of an output data set containing predictive power and 
          predictive probability at each interim look

*********************************************************/
proc iml;
    start integral(p) global(ast,bst);
        i=p**(ast[1]-1)*(1-p)**(bst[1]-1)*
            probbeta(p-&delta,ast[2],bst[2]);
        return(i);
    finish;
    start beta(a,b);
        beta=exp(lgamma(a)+lgamma(b)-lgamma(a+b));
        return(beta);
    finish;
    use &data;
    read all var {n1 count1 n2 count2} into data;
    n=data[,1]||data[,3];    
    s=data[,2]||data[,4];
    m=nrow(n);
    use &par;
    read all var {nn1 nn2 alpha1 alpha2 beta1 beta2} into par;
    nn=t(par[1:2]);
    a=t(par[3:4]);
    b=t(par[5:6]);    
    t=j(1,2,0);
    output=j(m,4,0);
    range=j(1,2,0);
    range[1]=&delta; range[2]=1;
    do i=1 to m;
    output[i,1]=i;
    output[i,2]=(n[i,1]+n[i,2])/(nn[1]+nn[2]);
    do t1=0 to nn[1]-n[i,1];
    do t2=0 to nn[2]-n[i,2];
        t[1]=t1; t[2]=t2;
        ast=s[i,]+t+a; 
        bst=nn-s[i,]-t+b;                
        b1=beta(ast,bst);                    
        b2=exp(lgamma(nn-n[i,]+1)-lgamma(nn-n[i,]-t+1)-lgamma(t+1));
        b3=beta(s[i,]+a,n[i,]-s[i,]+b);
        pr=(b1#b2)/b3;
        mult=pr[1]*pr[2];
        p=(s[i,]+t)/nn;
        ave=(p[1]+p[2])/2;
        aven=(nn[1]+nn[2])/2;
        teststat=(p[1]-p[2])/sqrt(2*ave*(1-ave)/aven);        
        output[i,3]=output[i,3]+(teststat>probit(1-&alpha))*mult;
        call quad(value,"integral",range) eps=1e-8;
        output[i,4]=output[i,4]+(value/beta(ast[1],bst[1])>&eta)*mult;
    end;
    end;
    end;    
    varnames={"Analysis", "Fraction", "PredPower", "PredProb"};
    create &prob from output[colname=varnames];
    append from output;
    quit;
data &prob;
    set &prob;
    format Fraction 4.2 PredPower PredProb 6.4;
    label Fraction="Fraction of total sample size"          
          PredPower="Predictive power"
          PredProb="Predictive probability";
%mend BayesFutilityBin;


