 /*-------------------------------------------------------------------*/
 /*       The Little SAS(r) Book: A Primer, Fifth Edition             */
 /*          by Lora D. Delwiche and Susan J. Slaughter               */
 /*       Copyright(c) 2012 by SAS Institute Inc., Cary, NC, USA      */
 /*                   SAS Publications order                          */
 /*                   ISBN 978-1-61290-343-9                          */
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
 /* Date Last Updated: 30SEP2012                                      */
 /*-------------------------------------------------------------------*/
 /* Questions or problem reports concerning this material may be      */
 /* addressed to the author:                                          */
 /*                                                                   */
 /* SAS Institute Inc.                                                */
 /* SAS Press                                                         */
 /* Attn: Lora Delwiche and Susan Slaughter                           */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  saspress@sas.com           */
 /* Use this for subject field:                                       */
 /*     Comments for Lora Delwiche and Susan Slaughter                */
 /*                                                                   */
 /*-------------------------------------------------------------------*/


/* Chapter 9 */

/* Section 9.1 */

/* Program */
DATA class;
   INFILE 'c:\MyRawData\Scores.dat';
   INPUT Score @@;
RUN;
PROC UNIVARIATE DATA = class;
   VAR Score;
   TITLE;
RUN;


/* Section 9.2 */

/* Program */
DATA class;
   INFILE 'c:\MyRawData\Scores.dat';
   INPUT Score @@;
RUN;
PROC UNIVARIATE DATA = class;
   VAR Score;
   HISTOGRAM Score/NORMAL;
   PROBPLOT Score;
   TITLE;
RUN;



/* Section 9.3 */

/* Program */
DATA booklengths;    
   INFILE 'c:\MyRawData\Picbooks.dat';
   INPUT NumberOfPages @@;
RUN;
*Produce summary statistics;
PROC MEANS DATA=booklengths N MEAN MEDIAN CLM ALPHA=.10;
   TITLE 'Summary of Picture Book Lengths';
RUN;


/* Section 9.4 */

/* Program */
DATA Swim;
   INFILE 'c:\MyRawData\Olympic50mSwim.dat';
   INPUT Swimmer $ FinalTime SemiFinalTime @@;
RUN;
PROC TTEST DATA=Swim;
   TITLE '50m Freestyle Semifinal vs. Final Results';
   PAIRED SemiFinalTime * FinalTime;
RUN;


/* Section 9.5 */

/* Program */
DATA Swim;
   INFILE 'c:\MyRawData\Olympic50mSwim.dat';
   INPUT Swimmer $ FinalTime SemiFinalTime @@;
RUN;
PROC TTEST DATA=Swim PLOTS(ONLY) = (SUMMARYPLOT QQPLOT);
   TITLE '50m Freestyle Semifinal vs. Final Results';
   PAIRED SemiFinalTime * FinalTime;
RUN;


/* Section 9.6 */

/* Program */
DATA bus;
   INFILE 'c:\MyRawData\Bus.dat';
   INPUT BusType $  OnTimeOrLate $ @@;
RUN;
PROC FREQ DATA = bus;
   TABLES BusType * OnTimeOrLate / CHISQ;
   TITLE;
RUN;


/* Section 9.7 */

/* Program */
DATA bus;
   INFILE 'c:\MyRawData\Bus.dat';
   INPUT BusType $  OnTimeOrLate $ @@;
RUN;
PROC FORMAT;
  VALUE $type 'R'='Regular'
              'E'='Express';
  VALUE $late 'O'='On Time'
              'L'='Late';
RUN;
PROC FREQ DATA = bus;
   TABLES BusType * OnTimeOrLate / PLOTS=FREQPLOT(TWOWAY = GROUPHORIZONTAL);
   TITLE;
   FORMAT BusType $Type. OnTimeOrLate $Late.;
RUN;
 


/* Section 9.8 */

/* Program */	
DATA class;
   INFILE 'c:\MyRawData\Exercise.dat';
   INPUT Score Television Exercise @@;
RUN;
PROC CORR DATA = class;
   VAR Television Exercise;
   WITH Score;
   TITLE 'Correlations for Test Scores';
   TITLE2 'With Hours of Television and Exercise';
RUN;


/* Section 9.9 */

/* Program */
DATA class;
   INFILE 'c:\MyRawData\Exercise.dat';
   INPUT Score Television Exercise @@;
RUN;
PROC CORR DATA = class PLOTS = (SCATTER MATRIX);
   VAR Television Exercise;
   WITH Score;
   TITLE 'Correlations for Test Scores';
   TITLE2 'With Hours of Television and Exercise';
RUN;
 

/* Section 9.10 */

/* Program */
DATA hits;
   INFILE 'c:\MyRawData\Baseball.dat';
   INPUT Height Distance @@;
RUN;
* Perform regression analysis;
PROC REG DATA = hits;
   MODEL Distance = Height;
   TITLE 'Results of Regression Analysis';
RUN;



/* Section 9.11 */

/* Program */
DATA hits;
   INFILE 'c:\MyRawData\Baseball.dat';
   INPUT Height Distance @@;
RUN;
PROC REG DATA = hits PLOTS(ONLY) = (DIAGNOSTICS FITPLOT);
   MODEL Distance = Height;
   TITLE 'Results of Regression Analysis';
RUN;


/* Section 9.12 */

/* Program */
DATA heights;
   INFILE 'c:\MyRawData\GirlHeights.dat';
   INPUT Region $ Height @@;
RUN;
* Use ANOVA to run one-way analysis of variance;
PROC ANOVA DATA = heights;
   CLASS Region;
   MODEL Height = Region;
   MEANS Region / SCHEFFE;
   TITLE "Girls' Heights from Four Regions";
RUN;


/* Section 9.13 */

/* Program */
PROC ANOVA DATA = heights;
   CLASS Region;
   MODEL Height = Region;
   MEANS Region / SCHEFFE;
   TITLE "Girls' Heights from Four Regions";
RUN;
