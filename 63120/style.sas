/****************************************************************/
/*     S T A T I S T I C A L   G R A P H I C S   S A M P L E    */
/*                                                              */
/*    NAME: style                                               */
/*   TITLE: Style Sample Code for Statistical Graphics in SAS   */
/*  SYSTEM: ALL                                                 */
/*    KEYS: statistical graphics                                */
/*                                                              */
/* SUPPORT: Warren F. Kuhfeld     UPDATE: February 2, 2010      */
/*     REF: Statistical Graphics in SAS                         */
/*    MISC:                                                     */
/****************************************************************/

proc template;
   define statgraph classscatter;
      begingraph;
         entrytitle 'Weight By Height';
         layout overlay;
            scatterplot y=weight x=height / markerattrs=GraphData2;
         endlayout;
      endgraph;
   end;
run;

ods listing style=statistical;
proc sgrender data=sashelp.class template=classscatter;
run;

proc template;
   list styles;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphFonts
         "Fonts used in graph styles" /
         'GraphDataFont' = ("<sans-serif>, <MTsans-serif>",7pt)
         'GraphUnicodeFont' = ("<MTsans-serif-unicode>",9pt)
         'GraphValueFont' = ("<sans-serif>, <MTsans-serif>",9pt)
         'GraphLabelFont' = ("<sans-serif>, <MTsans-serif>",10pt,bold)
         'GraphFootnoteFont' = ("<sans-serif>, <MTsans-serif>",10pt)
         'GraphTitleFont' = ("<sans-serif>, <MTsans-serif>",11pt,bold)
         'GraphAnnoFont' = ("<sans-serif>, <MTsans-serif>",10pt);
   end;
run;

ods listing style=default;

proc sgplot data=sashelp.class;
   title 'Class';
   footnote 'Default Style';
   reg y=weight x=height / datalabel=name;
run;

ods listing style=statistical;

proc sgplot data=sashelp.class;
   title 'Class';
   footnote 'Statistical Style';
   reg y=weight x=height / datalabel=name;
run;

ods listing style=mystyle;

proc sgplot data=sashelp.class;
   title 'Class';
   footnote 'MyStyle Style';
   reg y=weight x=height / datalabel=name;
run;

ods listing;

proc template;
   define style mybold;
      parent = styles.statistical;
      style GraphFonts from GraphFonts /
         'GraphDataFont' = ("<sans-serif>, <MTsans-serif>",5pt,bold)
         'GraphLabelFont' = ("<sans-serif>, <MTsans-serif>",10pt,bold)
         'GraphFootnoteFont' = ("<sans-serif>, <MTsans-serif>",10pt,bold);
   end;
run;

ods listing style=mybold;

proc sgplot data=sashelp.class;
   title 'Class';
   footnote 'MyBold Style';
   reg y=weight x=height / datalabel=name;
run;

ods listing;
footnote;

proc template;
   define style myfonts;
      parent = styles.statistical;
      style GraphFonts from GraphFonts /
         'GraphDataFont' = ("Arial",7pt)
         'GraphLabelFont' = ("Times New Roman",10pt)
         'GraphFootnoteFont' = ("Courier New",10pt);
   end;
run;

proc template;
   define style mycolor;
      parent = styles.statistical;
      class GraphFonts /
         'GraphFootnoteFont' = ("<sans-serif>, <MTsans-serif>",10pt);
      class GraphColors /
         'gcfit'  = blue
         'gcfit2' = red;
   end;
run;

ods listing style=statistical;

proc sgplot data=sashelp.class;
   title 'Class';
   footnote 'Statistical Style';
   histogram weight;
   density weight / type=normal;
   density weight / type=kernel;
run;

ods listing style=mycolor;

proc sgplot data=sashelp.class;
   title 'Class';
   footnote 'MyColor Style';
   histogram weight;
   density weight / type=normal;
   density weight / type=kernel;
run;

ods listing;
footnote;

ods listing style=mycolor;
proc sgplot data=sashelp.class;
   reg y=weight x=height / datalabel=name group=sex;
run;
ods listing;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphWalls /
         linethickness = 1px
         linestyle = 1
         frameborder = on
         contrastcolor = GraphColors('gaxis')
         backgroundcolor = GraphColors('gwalls')
         color = GraphColors('gwalls');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphAxisLines /
         tickdisplay = "outside"
         linethickness = 1px
         linestyle = 1
         contrastcolor = GraphColors('gaxis')
         color = GraphColors('gaxis');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphGridLines /
         displayopts = "auto"
         linethickness = 1px
         linestyle = 1
         contrastcolor = GraphColors('ggrid')
         color = GraphColors('ggrid');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphOutlines /
         linethickness = 1px
         linestyle = 1
         contrastcolor = GraphColors('goutlines')
         color = GraphColors('goutlines');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphBorderLines /
         linethickness = 1px
         linestyle = 1
         contrastcolor = GraphColors('gborderlines')
         color = GraphColors('gborderlines');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphReference /
         linethickness = 1px
         linestyle = 1
         contrastcolor = GraphColors('greferencelines');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphTitleText /
         font = GraphFonts('GraphTitleFont')
         color = GraphColors('gtext');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphFootnoteText /
         font = GraphFonts('GraphFootnoteFont')
         color = GraphColors('gtext');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphDataText /
         font = GraphFonts('GraphDataFont')
         color = GraphColors('gtext');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphLabelText /
         font = GraphFonts('GraphLabelFont')
         color = GraphColors('glabel');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphValueText /
         font = GraphFonts('GraphValueFont')
         color = GraphColors('gtext');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphUnicodeText /
         font = GraphFonts('GraphUnicodeFont');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphBackground /
         backgroundcolor = colors('docbg')
         color = colors('docbg');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphFloor /
         backgroundcolor = GraphColors('gfloor')
         color = GraphColors('gfloor');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphLegendBackground /
         backgroundcolor = GraphColors('glegend')
         color = GraphColors('glegend');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphHeaderBackground /
         backgroundcolor = GraphColors('gheader')
         color = GraphColors('gheader');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphDataDefault /
         endcolor = GraphColors('gramp3cend')
         neutralcolor = GraphColors('gramp3cneutral')
         startcolor = GraphColors('gramp3cstart')
         markersize = 7px
         markersymbol = "circle"
         linethickness = 1px
         linestyle = 1
         contrastcolor = GraphColors('gcdata')
         color = GraphColors('gdata');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphData1 /
         markersymbol = "circle"
         linestyle = 1
         contrastcolor = GraphColors('gcdata1')
         color = GraphColors('gdata1');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphData2 /
         markersymbol = "plus"
         linestyle = 4
         contrastcolor = GraphColors('gcdata2')
         color = GraphColors('gdata2');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphData3 /
         markersymbol = "X"
         linestyle = 8
         contrastcolor = GraphColors('gcdata3')
         color = GraphColors('gdata3');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphData4 /
         markersymbol = "triangle"
         linestyle = 5
         contrastcolor = GraphColors('gcdata4')
         color = GraphColors('gdata4');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphData5 /
         markersymbol = "square"
         linestyle = 14
         contrastcolor = GraphColors('gcdata5')
         color = GraphColors('gdata5');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphData6 /
         markersymbol = "asterisk"
         linestyle = 26
         contrastcolor = GraphColors('gcdata6')
         color = GraphColors('gdata6');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphData7 /
         markersymbol = "diamond"
         linestyle = 15
         contrastcolor = GraphColors('gcdata7')
         color = GraphColors('gdata7');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphData8 /
         linestyle = 20
         contrastcolor = GraphColors('gcdata8')
         color = GraphColors('gdata8');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphData9 /
         linestyle = 41
         contrastcolor = GraphColors('gcdata9')
         color = GraphColors('gdata9');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphData10 /
         linestyle = 42
         contrastcolor = GraphColors('gcdata10')
         color = GraphColors('gdata10');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphData11 /
         linestyle = 2
         contrastcolor = GraphColors('gcdata11')
         color = GraphColors('gdata11');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphData12 /
         contrastcolor = GraphColors('gcdata12')
         color = GraphColors('gdata12');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class TwoColorRamp /
         endcolor = GraphColors('gramp2cend')
         startcolor = GraphColors('gramp2cstart');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class ThreeColorRamp /
         endcolor = GraphColors('gramp3cend')
         neutralcolor = GraphColors('gramp3cneutral')
         startcolor = GraphColors('gramp3cstart');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class ThreeColorAltRamp /
         endcolor = GraphColors('gconramp3cend')
         neutralcolor = GraphColors('gconramp3cneutral')
         startcolor = GraphColors('gconramp3cstart');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphOutlier /
         linethickness = 2px
         linestyle = 42
         markersize = 7px
         markersymbol = "circle"
         contrastcolor = GraphColors('gcoutlier')
         color = GraphColors('goutlier');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphFit /
         linethickness = 2px
         linestyle = 1
         markersize = 7px
         markersymbol = "circle"
         contrastcolor = GraphColors('gcfit')
         color = GraphColors('gfit');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphFit2 /
         linethickness = 2px
         linestyle = 4
         markersize = 7px
         markersymbol = "X"
         contrastcolor = GraphColors('gcfit2')
         color = GraphColors('gfit2');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphConfidence /
         linethickness = 1px
         linestyle = 1
         markersize = 7px
         markersymbol = "triangle"
         contrastcolor = GraphColors('gcconfidence')
         color = GraphColors('gconfidence');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphConfidence2 /
         linethickness = 1px
         linestyle = 4
         markersize = 7px
         markersymbol = "diamond"
         contrastcolor = GraphColors('gcconfidence2')
         color = GraphColors('gconfidence2');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphPrediction /
         linethickness = 2px
         linestyle = 4
         markersize = 7px
         markersymbol = "plus"
         contrastcolor = GraphColors('gcpredict')
         color = GraphColors('gpredict');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphPredictionLimits /
         linethickness = 1px
         linestyle = 2
         markersize = 7px
         markersymbol = "chain"
         contrastcolor = GraphColors('gcpredictlim')
         color = GraphColors('gpredictlim');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphError /
         linethickness = 1px
         linestyle = 1
         markersize = 7px
         markersymbol = "asterisk"
         contrastcolor = GraphColors('gcerror')
         color = GraphColors('gerror');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphBox /
         capstyle = "serif"
         connect = "mean"
         displayopts = "fill caps median mean outliers";
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphBoxMedian /
         linestyle = 1
         linethickness = 1px
         contrastcolor = GraphColors('gcdata');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphBoxMean /
         markersize = 9px
         markersymbol = "diamond"
         contrastcolor = GraphColors('gcdata');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphBoxWhisker /
         linestyle = 1
         linethickness = 1px
         contrastcolor = GraphColors('gcdata');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphHistogram /
         displayopts = "fill outline";
   end;
run;

proc template;
   define style mystyle;
      class GraphEllipse /
         displayopts = "outline";
      parent = styles.statistical;
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphBand /
         displayopts = "fill";
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphContour /
         displayopts = "LabeledLineGradient";
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphBlock /
         color = GraphColors('gblock');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphAltBlock /
         color = GraphColors('gablock');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphAnnoLine /
         linestyle = 1
         linethickness = 2px
         contrastcolor = GraphColors('gcdata');
   end;
run;

proc template;
   define style mystyle;
      parent = styles.statistical;
      class GraphAnnoText /
         font = GraphFonts('GraphAnnoFont')
         color = GraphColors('gtext');
   end;
run;

proc template;
   define style mystyle;
      class GraphAnnoShape /
         markersize = 12px
         markersymbol = "starfilled"
         linethickness = 2px
         linestyle = 1
         contrastcolor = GraphColors('gcdata')
         color = GraphColors('gdata');
      parent = styles.statistical;
   end;
run;

proc format;
   value vf 5 = 'GraphValueText';
run;

data x;
   array y[20] y0 - y19;
   do x = 1 to 20; y[x] = x - 0.5; end;
   do x = 0 to 10 by 5; output; end;
   label y0 = 'GraphLabelText' x = 'GraphLabelText';
   format x y0 vf.;
run;

%macro l(i, l);
   reg y=y&i x=x / lineattrs=&l markerattrs=&l curvelabel="  &l"
                   curvelabelpos=max;
%mend;

ods listing style=default;
proc sgplot noautolegend;
   title 'GraphTitleText';
   %macro d; %do i = 1 %to 12;
      reg y=y%eval(19-&i) x=x / lineattrs=GraphData&i markerattrs=GraphData&i
                                curvelabel="  GraphData&i" curvelabelpos=max;
   %end; %mend; %d
   %l(19, GraphDataDefault)
   %l( 6, GraphFit)
   %l( 5, GraphFit2)
   %l( 4, GraphPredictionLimits)
   %l( 3, GraphConfidence)
   %l( 2, GraphGridLines)
   %l( 1, GraphOutlier)
   %l( 0, GraphReference)
   xaxis values=(0 5 10);
run;

data x;
   do y = 40 to 1 by -1;
      group = 'Group' || put(41 - y, 2. -L);
      do x = 0 to 10 by 5;
         if x = 10 then do; z = 11; l = group; end;
         else           do; z = .;  l = ' ';   end;
         output;
      end;
   end;
run;

proc sgplot data=x;
   title 'Colors, Markers, Line Patterns for Groups';
   series  y=y x=x / group=group markers;
   scatter y=y x=z / group=group markerchar=l;
run;

ods listing;

proc transreg data=sashelp.class;
   model identity(weight) = class(sex / zero=none) | identity(height);
run;

%modstyle(parent=statistical, name=StatColor)

ods listing style=StatColor;

proc transreg data=sashelp.class;
   model identity(weight) = class(sex / zero=none) | identity(height);
run;

%modstyle(parent=statistical, name=GenderStyle, type=CLM,
          colors=red blue, fillcolors=red blue,
          markers=plus circle, linestyles=solid solid)

ods listing style=GenderStyle;

proc transreg data=sashelp.class;
   model identity(weight) = class(sex / zero=none) | identity(height);
run;

%modstyle(parent=statistical, name=GenderStyle, type=CLM,
          colors=GraphColors("gcdata1") GraphColors("gcdata2")
                 green cx543005 cx9D3CDB cx7F8E1F cx2597FA cxB26084
                 cxD17800 cx47A82A cxB38EF3 cxF9DA04 magenta,
          fillcolors=colors,
          linestyles=Solid ShortDash MediumDash LongDash MediumDashShortDash
                  DashDashDot DashDotDot Dash LongDashShortDash Dot
                  ThinDot ShortDashDot MediumDashDotDot,
          markers=ArrowDown Asterisk Circle CircleFilled Diamond
                  DiamondFilled GreaterThan Hash HomeDown Ibeam Plus
                  Square SquareFilled Star StarFilled Tack Tilde
                  Triangle TriangleFilled Union X Y Z)

ods listing style=GenderStyle;

proc transreg data=sashelp.class;
   model identity(weight) = class(sex / zero=none) | identity(height);
run;

proc template;
define statgraph Stat.Lifetest.Graphics.ProductLimitSurvival;
dynamic NStrata xName plotAtRisk plotCensored plotCL plotHW plotEP labelCL
   labelHW labelEP maxTime StratumID classAtRisk plotBand plotTest
   GroupName yMin Transparency SecondTitle TestName pValue;
BeginGraph;
   if (NSTRATA=1)
      if (EXISTS(STRATUMID))
      entrytitle "Kaplan-Meier Plot" " for " STRATUMID;
   else
      entrytitle "Kaplan-Meier Plot";
   endif;
   if (PLOTATRISK)
      entrytitle "with Number of Subjects at Risk" / textattrs=
      GRAPHVALUETEXT;
   endif;
   layout overlay / xaxisopts=(shortlabel=XNAME offsetmin=.05 linearopts=(
      viewmax=MAXTIME)) yaxisopts=(label="Survival Probability" shortlabel
      ="Survival" linearopts=(viewmin=0 viewmax=1 tickvaluelist=(0 .2 .4
      .6 .8 1.0)));
      if (PLOTHW=1 AND PLOTEP=0)
         bandplot LimitUpper=HW_UCL LimitLower=HW_LCL x=TIME / modelname=
         "Survival" fillattrs=GRAPHCONFIDENCE name="HW" legendlabel=
         LABELHW;
      endif;
      if (PLOTHW=0 AND PLOTEP=1)
         bandplot LimitUpper=EP_UCL LimitLower=EP_LCL x=TIME / modelname=
         "Survival" fillattrs=GRAPHCONFIDENCE name="EP" legendlabel=
         LABELEP;
      endif;
      if (PLOTHW=1 AND PLOTEP=1)
         bandplot LimitUpper=HW_UCL LimitLower=HW_LCL x=TIME / modelname=
         "Survival" fillattrs=GRAPHDATA1 datatransparency=.55 name="HW"
         legendlabel=LABELHW;
      bandplot LimitUpper=EP_UCL LimitLower=EP_LCL x=TIME / modelname=
         "Survival" fillattrs=GRAPHDATA2 datatransparency=.55 name="EP"
         legendlabel=LABELEP;
      endif;
      if (PLOTCL=1)
         if (PLOTHW=1 OR PLOTEP=1)
         bandplot LimitUpper=SDF_UCL LimitLower=SDF_LCL x=TIME / modelname
         ="Survival" display=(outline) outlineattrs=GRAPHPREDICTIONLIMITS
         name="CL" legendlabel=LABELCL;
      else
         bandplot LimitUpper=SDF_UCL LimitLower=SDF_LCL x=TIME / modelname
         ="Survival" fillattrs=GRAPHCONFIDENCE name="CL" legendlabel=
         LABELCL;
      endif;
      endif;
      stepplot y=SURVIVAL x=TIME / name="Survival" rolename=(_tip1=ATRISK
         _tip2=EVENT) tip=(y x Time _tip1 _tip2) legendlabel="Survival";
      if (PLOTCENSORED=1)
         scatterplot y=CENSORED x=TIME / markerattrs=(symbol=plus) name=
         "Censored" legendlabel="Censored";
      endif;
      if (PLOTCL=1 OR PLOTHW=1 OR PLOTEP=1)
         discretelegend "Censored" "CL" "HW" "EP" / location=outside
         halign=center;
      else
         if (PLOTCENSORED=1)
         discretelegend "Censored" / location=inside autoalign=(topright
         bottomleft);
      endif;
      endif;
      if (PLOTATRISK=1)
         innermargin / align=bottom;
         blockplot x=TATRISK block=ATRISK / repeatedvalues=true display=(
            values) valuehalign=start valuefitpolicy=truncate
            labelposition=left labelattrs=GRAPHVALUETEXT valueattrs=
            GRAPHDATATEXT (size=7pt) includemissingclass=false;
      endinnermargin;
      endif;
   endlayout;
   else
      entrytitle "Kaplan-Meier Plot";
   if (EXISTS(SECONDTITLE))
      entrytitle SECONDTITLE / textattrs=GRAPHVALUETEXT;
   endif;
   layout overlay / xaxisopts=(shortlabel=XNAME offsetmin=.05 linearopts=(
      viewmax=MAXTIME)) yaxisopts=(label="Survival Probability" shortlabel
      ="Survival" linearopts=(viewmin=0 viewmax=1 tickvaluelist=(0 .2 .4
      .6 .8 1.0)));
      if (PLOTHW)
         bandplot LimitUpper=HW_UCL LimitLower=HW_LCL x=TIME / group=
         STRATUM index=STRATUMNUM modelname="Survival" datatransparency=
         Transparency;
      endif;
      if (PLOTEP)
         bandplot LimitUpper=EP_UCL LimitLower=EP_LCL x=TIME / group=
         STRATUM index=STRATUMNUM modelname="Survival" datatransparency=
         Transparency;
      endif;
      if (PLOTCL)
         if (PLOTBAND)
         bandplot LimitUpper=SDF_UCL LimitLower=SDF_LCL x=TIME / group=
         STRATUM index=STRATUMNUM modelname="Survival" display=(outline);
      else
         bandplot LimitUpper=SDF_UCL LimitLower=SDF_LCL x=TIME / group=
         STRATUM index=STRATUMNUM modelname="Survival" datatransparency=
         Transparency;
      endif;
      endif;
      stepplot y=SURVIVAL x=TIME / group=STRATUM index=STRATUMNUM name=
         "Survival" rolename=(_tip1=ATRISK _tip2=EVENT) tip=(y x Time
         _tip1 _tip2);
      if (PLOTCENSORED)
         scatterplot y=CENSORED x=TIME / group=STRATUM index=STRATUMNUM
         markerattrs=(symbol=plus);
      endif;
      if (PLOTATRISK)
         innermargin / align=bottom;
         blockplot x=TATRISK block=ATRISK / class=CLASSATRISK
            repeatedvalues=true display=(label values) valuehalign=start
            valuefitpolicy=truncate labelposition=left labelattrs=
            GRAPHVALUETEXT valueattrs=GRAPHDATATEXT (size=7pt)
            includemissingclass=false;
      endinnermargin;
      endif;
      DiscreteLegend "Survival" / title=GROUPNAME location=outside;
      if (PLOTCENSORED)
         if (PLOTTEST)
         layout gridded / rows=2 autoalign=(TOPRIGHT BOTTOMLEFT TOP BOTTOM
         ) border=true BackgroundColor=GraphWalls:Color Opaque=true;
         entry "+ Censored";
         if (PVALUE < .0001)
            entry TESTNAME " p " eval (PUT(PVALUE, PVALUE6.4));
         else
            entry TESTNAME " p=" eval (PUT(PVALUE, PVALUE6.4));
         endif;
      endlayout;
      else
         layout gridded / rows=1 autoalign=(TOPRIGHT BOTTOMLEFT TOP BOTTOM
         ) border=true BackgroundColor=GraphWalls:Color Opaque=true;
         entry "+ Censored";
      endlayout;
      endif;
      else
         if (PLOTTEST)
         layout gridded / rows=1 autoalign=(TOPRIGHT BOTTOMLEFT TOP BOTTOM
         ) border=true BackgroundColor=GraphWalls:Color Opaque=true;
         if (PVALUE < .0001)
            entry TESTNAME " p " eval (PUT(PVALUE, PVALUE6.4));
         else
            entry TESTNAME " p=" eval (PUT(PVALUE, PVALUE6.4));
         endif;
      endlayout;
      endif;
      endif;
   endlayout;
   endif;
EndGraph;
end;
run;

proc format;
   value risk 1='ALL' 2='AML-Low Risk' 3='AML-High Risk';
run;

data BMT;
   input Group T Status @@;
   format Group risk.;
   label T='Disease Free Time';
   datalines;
1 2081 0 1 1602 0 1 1496 0 1 1462 0 1 1433 0
1 1377 0 1 1330 0 1  996 0 1  226 0 1 1199 0
1 1111 0 1  530 0 1 1182 0 1 1167 0 1  418 1
1  383 1 1  276 1 1  104 1 1  609 1 1  172 1
1  487 1 1  662 1 1  194 1 1  230 1 1  526 1
1  122 1 1  129 1 1   74 1 1  122 1 1   86 1
1  466 1 1  192 1 1  109 1 1   55 1 1    1 1
1  107 1 1  110 1 1  332 1 2 2569 0 2 2506 0
2 2409 0 2 2218 0 2 1857 0 2 1829 0 2 1562 0
2 1470 0 2 1363 0 2 1030 0 2  860 0 2 1258 0
2 2246 0 2 1870 0 2 1799 0 2 1709 0 2 1674 0
2 1568 0 2 1527 0 2 1324 0 2  957 0 2  932 0
2  847 0 2  848 0 2 1850 0 2 1843 0 2 1535 0
2 1447 0 2 1384 0 2  414 1 2 2204 1 2 1063 1
2  481 1 2  105 1 2  641 1 2  390 1 2  288 1
2  421 1 2   79 1 2  748 1 2  486 1 2   48 1
2  272 1 2 1074 1 2  381 1 2   10 1 2   53 1
2   80 1 2   35 1 2  248 1 2  704 1 2  211 1
2  219 1 2  606 1 3 2640 0 3 2430 0 3 2252 0
3 2140 0 3 2133 0 3 1238 0 3 1631 0 3 2024 0
3 1345 0 3 1136 0 3  845 0 3  422 1 3  162 1
3   84 1 3  100 1 3    2 1 3   47 1 3  242 1
3  456 1 3  268 1 3  318 1 3   32 1 3  467 1
3   47 1 3  390 1 3  183 1 3  105 1 3  115 1
3  164 1 3   93 1 3  120 1 3   80 1 3  677 1
3   64 1 3  168 1 3   74 1 3   16 1 3  157 1
3  625 1 3   48 1 3  273 1 3   63 1 3   76 1
3  113 1 3  363 1
;

proc lifetest data=BMT plots=survival(atrisk=0 to 2500 by 500);
   time T * Status(0);
   strata Group / test=logrank adjust=sidak;
run;

%modstyle(parent=statistical, name=SurvivalStyle,
          colors=blue red green)

ods listing style=SurvivalStyle;

proc lifetest data=BMT plots=survival(atrisk=0 to 2500 by 500);
   time T * Status(0);
   strata Group / test=logrank adjust=sidak;
run;

data x;
   input cx $2. (Red Green Blue) (hex2.);
   datalines;
cx2A25D9
cx7C95CA
;

proc print;
run;

proc template;
   define style Styles.MyStyle;
      parent = Styles.statistical;
      class GraphDataDefault /
         endcolor = GraphColors('gramp3cend')
         neutralcolor = GraphColors('gramp3cneutral')
         startcolor = GraphColors('gramp3cstart')
         markersize = 7px
         markersymbol = "square"
         linethickness = 1px
         linestyle = 1
         contrastcolor = blue
         color = cyan;
   end;
run;

ods graphics on;
ods listing style=statistical;

proc transreg data=sashelp.class;
   model identity(weight) = pbspline(height);
run;

ods listing style=MyStyle;

proc transreg data=sashelp.class;
   model identity(weight) = pbspline(height);
run;
