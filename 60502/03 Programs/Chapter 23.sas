/*-------------------------------------------------------------------------------------------
Daten
-------------------------------------------------------------------------------------------*/



data fitness; 
      input Age Weight Oxygen RunTime RestPulse RunPulse MaxPulse @@; 
      datalines; 
   44 89.47 44.609 11.37 62 178 182   40 75.07 45.313 10.07 62 185 185 
   44 85.84 54.297  8.65 45 156 168   42 68.15 59.571  8.17 40 166 172 
   38 89.02 49.874  9.22 55 178 180   47 77.45 44.811 11.63 58 176 176 
   40 75.98 45.681 11.95 70 176 180   43 81.19 49.091 10.85 64 162 170 
   44 81.42 39.442 13.08 63 174 176   38 81.87 60.055  8.63 48 170 186 
   44 73.03 50.541 10.13 45 168 168   45 87.66 37.388 14.03 56 186 192 
   45 66.45 44.754 11.12 51 176 176   47 79.15 47.273 10.60 47 162 164 
   54 83.12 51.855 10.33 50 166 170   49 81.42 49.156  8.95 44 180 185 
   51 69.63 40.836 10.95 57 168 172   51 77.91 46.672 10.00 48 162 168 
   48 91.63 46.774 10.25 48 162 164   49 73.37 50.388 10.08 67 168 168 
   57 73.37 39.407 12.63 58 174 176   54 79.38 46.080 11.17 62 156 165 
   52 76.32 45.441  9.63 48 164 166   50 70.87 54.625  8.92 48 146 155 
   51 67.25 45.118 11.08 48 172 172   54 91.63 39.203 12.88 44 168 172 
   51 73.71 45.790 10.47 59 186 188   57 59.08 50.545  9.93 49 148 155 
   49 76.32 48.673  9.40 56 186 188   48 61.24 47.920 11.50 52 170 176 
   52 82.78 47.467 10.50 53 170 172 
   ; 
run;



DATA NewObs;
 AGE = 35;
 Weight = 81;
 Runtime = 11.6;
 OUTPUT;
 AGE = 55;
 Weight = 91;
 Runtime = 12.6;
 OUTPUT;
 AGE = 25;
 Weight = 61;
 Runtime = 9.6;
 OUTPUT;
RUN;




 data Remission;
      input remiss cell smear infil li blast temp;
      label remiss='Complete Remission';
      datalines;
   1   .8   .83  .66  1.9  1.1     .996
   1   .9   .36  .32  1.4   .74    .992
   0   .8   .88  .7    .8   .176   .982
   0  1     .87  .87   .7  1.053   .986
   1   .9   .75  .68  1.3   .519   .98
   0  1     .65  .65   .6   .519   .982
   1   .95  .97  .92  1    1.23    .992
   0   .95  .87  .83  1.9  1.354  1.02
   0  1     .45  .45   .8   .322   .999
   0   .95  .36  .34   .5  0      1.038
   0   .85  .39  .33   .7   .279   .988
   0   .7   .76  .53  1.2   .146   .982
   0   .8   .46  .37   .4   .38   1.006
   0   .2   .39  .08   .8   .114   .99
   0  1     .9   .9   1.1  1.037   .99
   1  1     .84  .84  1.9  2.064  1.02
   0   .65  .42  .27   .5   .114  1.014
   0  1     .75  .75  1    1.322  1.004
   0   .5   .44  .22   .6   .114   .99
   1  1     .63  .63  1.1  1.072   .986
   0  1     .33  .33   .4   .176  1.01
   0   .9   .93  .84   .6  1.591  1.02
   1  1     .58  .58  1     .531  1.002
   0   .95  .32  .3   1.6   .886   .988
   1  1     .6   .6   1.7   .964   .99
   1  1     .69  .69   .9   .398   .986
   0  1     .73  .73   .7   .398   .986
   .  1     .5   .8   2.7   .464   .89
   .  0.5   .59  .89  1.9   .498   .886
   .  1     .53  .83  1.7   .498   .886
   ;
run;






DATA NewClusObs;
 AGE = 35;
 Weight = 81;
 Oxygen = 39.3;
 Runtime = 11.6;
 OUTPUT;
 AGE = 55;
 Weight = 91;
 Oxygen = 59.3;
 Runtime = 12.6;
 OUTPUT;
 AGE = 25;
 Weight = 61;
 Oxygen = 69.3;
 Runtime = 9.6;
 OUTPUT;
RUN;




DATA hmeq_score;
 Format job reason $20.;
 JOB = 'Office';
 REASON ='HomeImp';
 OUTPUT;
 JOB = 'Sales';
 REASON ='New';
 OUTPUT;
 JOB = 'SAS-Consultant';
 REASON ='DebtInc';
 OUTPUT;
RUN;



/*-------------------------------------------------------------------------------------------
Section 23.3
-------------------------------------------------------------------------------------------*/

PROC REG DATA=fitness OUTEST = betas; 
 MODEL Oxygen=Age Weight RunTime ;
 RUN;
QUIT;



PROC SQL;
CREATE TABLE scores
AS SELECT a.*, 
          b.age AS C_age,
          b.weight AS C_weight,
          b.runtime AS C_runtime,
          b.intercept AS Intercept,
          (b.Intercept +
           b.age * a.age +
           b.weight * a.weight +
           b.runtime * a.runtime) AS Score
          FROM NewObs a, 
               betas b;
QUIT;



PROC SQL;
 CREATE VIEW score_view
 AS SELECT   a.*, 
            (b.Intercept          +
             b.age     * a.age    +
             b.weight  * a.weight +
             b.runtime * a.runtime) AS Score
       FROM NewObs  a, 
            betas       b
 ;
QUIT;


/*-------------------------------------------------------------------------------------------
Section 23.4
-------------------------------------------------------------------------------------------*/

DATA fitness2;
 SET fitness NewObs;
RUN;


PROC REG DATA=fitness2; 
   MODEL Oxygen=Age Weight RunTime ;
   OUTPUT OUT = fitness_out P=predicted;
RUN;
QUIT;



DATA fitness2_view / VIEW = fitness2_view;
 SET fitness NewObs;
RUN;


PROC LOGISTIC DATA=Remission OUTEST=betas;
   MODEL remiss(event='1')=cell smear infil li blast temp;
   OUTPUT OUT = remission_out P=p;
RUN;
QUIT;




PROC FASTCLUS DATA = fitness 
              MAXCLUSTERS=5
              OUTSEED = ClusterSeeds;
 VAR age weight oxygen runtime;
RUN;




PROC FASTCLUS DATA = NewClusObs
              OUT  = NewClusObs_scored
              SEED = ClusterSeeds
              MAXCLUSTERS=5
              MAXITER = 0;
 VAR age weight oxygen runtime;
RUN;



/*-------------------------------------------------------------------------------------------
Section 23.5
-------------------------------------------------------------------------------------------*/

PROC REG DATA=fitness OUTEST = betas; 
 MODEL Oxygen=Age Weight RunTime ;
RUN;
QUIT;

PROC SCORE DATA  = NewObs 
           SCORE = betas
           OUT   = NewObs_scored(RENAME = (Model1 = Oxygen_Predict))
           TYPE  = PARMS;
 VAR Age Weight RunTime;
RUN;




/*-------------------------------------------------------------------------------------------
Section 23.6
-------------------------------------------------------------------------------------------*/



PROC ARIMA DATA = sashelp.citimon;
 IDENTIFY VAR =eegp(12);
 ESTIMATE P=2;	
 IDENTIFY VAR = RTRR CROSSCORR = (eegp(12));
 ESTIMATE P=1 Q=1 INPUT=(eegp);
 FORECAST LEAD=12 INTERVAL = month ID = DATE OUT = results;
RUN;
QUIT;



/*-------------------------------------------------------------------------------------------
Section 23.8
-------------------------------------------------------------------------------------------*/





%AlertNumericMissing(data = sampsio.hmeq,alert=0.1);
%AlertNumericMissing(data = sampsio.hmeq,vars=bad loan mortdue,alert=0.1);



%ALERTCHARMISSING(DATA=sampsio.hmeq,VARS=job reason);




%RememberCategories(data=sampsio.hmeq,vars=job reason);



%CheckCategories(scoreds = hmeq_score,vars=job reason);






%RememberDistribution(data=sampsio.dmthmeq,stat=median);
%ScoreDistribution(data=sampsio.dmvhmeq,stat=median);

/*-------------------------------------------------------------------------------------------
Section 23.9
-------------------------------------------------------------------------------------------*/


%LET Period = 200507;
%LET Varlist = CustID Age Gender Region;

DATA customer_&period;
 SET source.customer_&period;
 -- some other statements --;
 KEEP &Varlist;
RUN;



DATA _NULL_;
 CALL symput('MONTH_YEAR',TRIM(YEAR(TODAY()))||PUT(MONTH(TODAY()),z2.));
RUN;


%PUT &MONTH_YEAR;




%MACRO Master(limit=0);
 DATA _NULL_;RUN; *** Start with a valid statement to initialize SYSERR;
 %IF &syserr <= &limit %THEN %DO; PROC PRINT DATA = sashelp.class; RUN; %END;
 %IF &syserr <= &limit %THEN %CREATE_DATASETS;;
 %IF &syserr <= &limit %THEN %INCLUDE 'c:\programm\step03.sas';
%MEND;
%MASTER;
