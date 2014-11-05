/****************************************************************/
/*     S T A T I S T I C A L   G R A P H I C S   S A M P L E    */
/*                                                              */
/*    NAME: tips                                                */
/*   TITLE: Tips Sample Code for Statistical Graphics in SAS    */
/*  SYSTEM: ALL                                                 */
/*    KEYS: statistical graphics                                */
/*                                                              */
/* SUPPORT: Warren F. Kuhfeld     UPDATE: February 2, 2010      */
/*     REF: Statistical Graphics in SAS                         */
/*    MISC:                                                     */
/****************************************************************/

proc template;
   define statgraph Stat.KDE.Graphics.ScatterPlot;
      BeginGraph;
         layout Overlay;
            ScatterPlot x=X y=Y;
         EndLayout;
      EndGraph;
   end;
run;

proc template;
   define statgraph Stat.KDE.Graphics.ScatterPlot;
      BeginGraph;
         layout Overlay;
            ScatterPlot x=X y=Y;
            SeriesPlot  x=MyMadeUpVariable y=Y;
         EndLayout;
      EndGraph;
   end;
run;

proc kde data=sashelp.class;
   bivar height weight / plots=scatter;
run;

proc template;
   define statgraph ScatterPlot;
      BeginGraph;
         layout Overlay;
            ScatterPlot x=height y=weight;
            SeriesPlot  x=MyMadeUpVariable y=weight;
         EndLayout;
      EndGraph;
   end;
run;

proc sgrender data=sashelp.class template=scatterplot;
run;
