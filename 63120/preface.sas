/****************************************************************/
/*     S T A T I S T I C A L   G R A P H I C S   S A M P L E    */
/*                                                              */
/*    NAME: preface                                             */
/*   TITLE: Preface Sample Code for Statistical Graphics in SAS */
/*  SYSTEM: ALL                                                 */
/*    KEYS: statistical graphics                                */
/*                                                              */
/* SUPPORT: Warren F. Kuhfeld     UPDATE: February 2, 2010      */
/*     REF: Statistical Graphics in SAS                         */
/*    MISC:                                                     */
/****************************************************************/

ods graphics on;

proc glm data=sashelp.class;
   model weight = height;
run;

proc sgplot data=sashelp.class;
   title 'Fit Plot for Weight';
   reg y=weight x=height / cli clm;
run;

proc template;
   define statgraph FitPlot;
      begingraph;
         entrytitle 'Fit Plot for Weight';
         layout overlay;
            modelband "cliband" / display=(outline)
                      outlineattrs=GraphPredictionLimits
                      name='cli' legendlabel='95% Prediction Limits'
                      datatransparency=0.5;
            modelband "clmband" /
                      fillattrs=GraphConfidence
                      name='clm' legendlabel='95% Confidence Limits'
                      datatransparency=0.5;
            scatterplot y=weight x=height;
            regressionplot y=weight x=height / name='reg'
                           clm="clmband" cli="cliband" legendlabel='Fit';
            discretelegend 'reg' 'clm' 'cli';
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=FitPlot;
run;
