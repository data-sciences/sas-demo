/****************************************************************/
/*     S T A T I S T I C A L   G R A P H I C S   S A M P L E    */
/*                                                              */
/*    NAME: tmplmod                                             */
/*   TITLE: Template Modification Sample Code                   */
/*  SYSTEM: ALL                                                 */
/*    KEYS: statistical graphics                                */
/*                                                              */
/* SUPPORT: Warren F. Kuhfeld     UPDATE: February 2, 2010      */
/*     REF: Statistical Graphics in SAS                         */
/*    MISC:                                                     */
/****************************************************************/

ods path (prepend) work.templat(update);
ods graphics on;
ods trace on;

proc template;
   define statgraph Stat.KDE.Graphics.ScatterPlot;
      dynamic _VAR1NAME _VAR1LABEL _VAR2NAME _VAR2LABEL;
      BeginGraph;
         EntryTitle "Distribution of " _VAR1label " by " _VAR2label;
         layout Overlay / xaxisopts=(offsetmin=0.05 offsetmax=0.05)
                          yaxisopts=(offsetmin=0.05 offsetmax=0.05);
            ScatterPlot x=X y=Y / markerattrs=GRAPHDATADEFAULT;
         EndLayout;
      EndGraph;
   end;
run;

proc kde data=sashelp.class;
   bivar height weight / plots=scatter;
   label height = 'Height in Inches' weight = 'Weight in Pounds';
run;

proc template;
   define statgraph Stat.KDE.Graphics.ScatterPlot;
      dynamic _VAR1NAME _VAR1LABEL _VAR2NAME _VAR2LABEL;
      BeginGraph;
         EntryTitle _VAR1NAME " by " _VAR2NAME;
         layout Overlay / xaxisopts=(offsetmin=0.05 offsetmax=0.05)
                          yaxisopts=(offsetmin=0.05 offsetmax=0.05);
            ScatterPlot x=X y=Y / markerattrs=GRAPHDATADEFAULT;
         EndLayout;
      EndGraph;
   end;
run;

ods graphics on;
proc kde data=sashelp.class;
   ods output scatterplot=sp;
   bivar height weight / plots=scatter;
run;

proc sgrender data=sp template=Stat.KDE.Graphics.ScatterPlot;
   dynamic  _VAR1NAME='Student Height' _var2name='Student Weight';
run;

proc template;
   define statgraph Stat.KDE.Graphics.ScatterPlot;
      dynamic _VAR1NAME _VAR1LABEL _VAR2NAME _VAR2LABEL;
      BeginGraph;
         EntryTitle _VAR1NAME " by " _VAR2NAME;
         layout Overlay / xaxisopts=(offsetmin=0.05 offsetmax=0.05)
                          yaxisopts=(offsetmin=0.05 offsetmax=0.05);
            ScatterPlot x=height y=weight / markerattrs=GRAPHDATADEFAULT;
         EndLayout;
      EndGraph;
   end;
run;

proc sgrender data=sashelp.class template=Stat.KDE.Graphics.ScatterPlot;
   dynamic  _VAR1NAME='Student Height' _var2name='Student Weight';
run;

proc template;
   define statgraph Stat.KDE.Graphics.ScatterPlot;
      dynamic _VAR1NAME _VAR1LABEL _VAR2NAME _VAR2LABEL x y;
      BeginGraph;
         EntryTitle _VAR1NAME " by " _VAR2NAME;
         layout Overlay / xaxisopts=(offsetmin=0.05 offsetmax=0.05)
                          yaxisopts=(offsetmin=0.05 offsetmax=0.05);
            ScatterPlot x=X y=Y / markerattrs=GRAPHDATADEFAULT;
         EndLayout;
      EndGraph;
   end;
run;

proc sgrender data=sashelp.class template=Stat.KDE.Graphics.ScatterPlot;
   dynamic  _VAR1NAME='Student Height' _var2name='Student Weight'
            x='height' y='weight';
run;

proc factor data=sashelp.cars plots(unpack)=scree;
run;

proc template;
   source Stat.Factor.Graphics.ScreePlot1;
run;

proc template;
   define statgraph Stat.Factor.Graphics.ScreePlot1;
      notes "Scree Plot for Extracted Eigenvalues";
      BeginGraph / designwidth=DefaultDesignHeight;
         Entrytitle "Eigenvalue ((*ESC*){Unicode Lambda}) Plot";
         layout overlay / yaxisopts=(label="Eigenvalue")
            xaxisopts=(label="Factor Number"
                       linearopts=(tickvaluelist=(1 2 3 4 5 6 7 8 9 10)));
            seriesplot y=EIGENVALUE x=NUMBER / display=ALL;
         endlayout;
      EndGraph;
   end;
run;

proc factor data=sashelp.cars plots(unpack)=scree;
run;

proc template;
   delete Stat.Factor.Graphics.ScreePlot1;
run;

proc glimmix data=sashelp.class plots=boxplot;
    class sex;
    model height = sex;
run;

proc template;
   source Stat.Glimmix.Graphics.BoxPlot;
run;

proc template;
   define statgraph Stat.Glimmix.Graphics.BoxPlot;
      dynamic _TITLE _YVAR _SHORTYLABEL;
      BeginGraph;
         entrytitle _TITLE;
         entrytitle "exists? " eval(exists(_yvar)) " _yvar: " _yvar;
         entrytitle "exists? " eval(exists(_shortylabel))
                    " _shortylabel: " _shortylabel;
         layout overlay / yaxisopts=(gridDisplay=auto_on shortlabel=_SHORTYLABEL)
            xaxisopts=(discreteopts=(tickvaluefitpolicy=rotatethin));
            boxplot y=_YVAR x=LEVEL / labelfar=on datalabel=OUTLABEL
               primary=true freq=FREQ;
         endlayout;
      EndGraph;
   end;

proc glimmix data=sashelp.class plots=boxplot;
    class sex;
    ods output boxplot=bp;
    model height = sex;
run;

proc contents p;
   ods select position;
run;

proc template;
   define statgraph Stat.Glimmix.Graphics.BoxPlot;
      dynamic _TITLE _YVAR _SHORTYLABEL;
      mvar datetag xlabel;
      BeginGraph;
         entrytitle _TITLE;
         entryfootnote halign=left textattrs=graphvaluetext datetag;
         layout overlay / yaxisopts=(gridDisplay=auto_on shortlabel=_SHORTYLABEL)
            xaxisopts=(label=xlabel
                       discreteopts=(tickvaluefitpolicy=rotatethin));
            boxplot y=_YVAR x=LEVEL / labelfar=on datalabel=OUTLABEL
               primary=true freq=FREQ;
         endlayout;
      EndGraph;
   end;
run;

%let DateTag = Acme 01Apr2008;
%let xlabel  = Gender;

proc glimmix data=sashelp.class plots=boxplot;
    class sex;
    ods output boxplot=bp;
    model height = sex;
run;

proc template;
   delete Stat.Glimmix.Graphics.BoxPlot;
run;

title;
footnote 'halign=left textattrs=graphvaluetext "Acme 01Apr2008"';
%modtmplt(template=Stat.Glimmix.Graphics.BoxPlot, steps=t,
          options=titles noquotes)
footnote;

proc glimmix data=sashelp.class plots=boxplot;
    class sex;
    ods output boxplot=bp;
    model height = sex;
run;

%modtmplt(template=Stat.Glimmix.Graphics.BoxPlot, steps=d)

proc template;
   define statgraph Stat.KDE.Graphics.ScatterPlot;
      dynamic _VAR1NAME _VAR1LABEL _VAR2NAME _VAR2LABEL;
      BeginGraph;
         EntryTitle "Distribution of " _VAR2LABEL " by " _VAR1LABEL;
         layout Overlay /
            xaxisopts=(offsetmin=0.05 offsetmax=0.05 griddisplay=on)
            yaxisopts=(offsetmin=0.05 offsetmax=0.05 griddisplay=on);
            pbsplineplot x=y y=x / lineattrs=(color=red pattern=2 thickness=1);
            ScatterPlot  x=y y=x / markerattrs=(color=green size=5px
                                   symbol=starfilled weight=bold);
         EndLayout;
      EndGraph;
   end;
run;

proc kde data=sashelp.class;
   label height = 'Class Height' weight = 'Class Weight';
   bivar height weight / plots=scatter;
run;

proc template;
   define statgraph Stat.KDE.Graphics.ScatterPlot;
      dynamic _VAR1NAME _VAR1LABEL _VAR2NAME _VAR2LABEL;
      BeginGraph;
         EntryFootNote "Distribution of " _VAR1NAME " by " _VAR2NAME;
         EntryFootNote "with a Cubic Fit Function";
         layout Overlay / walldisplay=none
            xaxisopts=(display=(label))
            yaxisopts=(display=(label));
            referenceline y=eval(mean(y));
            referenceline x=eval(mean(x));
            ScatterPlot x=X y=Y / markerattrs=GRAPHDATADEFAULT;
            regressionplot x=x y=y / degree=3;
         EndLayout;
      EndGraph;
   end;
run;

proc kde data=sashelp.class;
   bivar height weight / plots=scatter;
run;

proc glm plots=diagnostics(unpack) data=sashelp.class;
   model weight = height;
   ods output residualhistogram=hr;
run;

proc contents p;
   ods select position;
run;

proc template;
   source Stat.GLM.Graphics.ResidualHistogram;
run;

proc template;
   define statgraph Stat.GLM.Graphics.ResidualHistogram;
      notes "Residual Histogram with Overlayed Normal and Kernel";
      dynamic Residual _DEPNAME;
      BeginGraph;
         entrytitle "Distribution of Residuals" " for " _DEPNAME;
         layout overlay / xaxisopts=(label="Residual")
            yaxisopts=(label="Percent");
            histogram RESIDUAL / primary=true;
            densityplot RESIDUAL / name="Normal"
               legendlabel="Normal" lineattrs=GRAPHFIT;
            densityplot RESIDUAL / kernel ()
               name="Kernel" legendlabel="Kernel" lineattrs=GRAPHFIT2;
            discretelegend "Normal" "Kernel";
         endlayout;
      EndGraph;
   end;
run;

proc glm plots=diagnostics(unpack) data=sashelp.class;
   model weight = height;
run;

proc factor data=sashelp.cars plots=scree;
run;

ods graphics on;

proc reg data=sashelp.class;
   model weight = height;
run; quit;

proc sort data=sashelp.class out=class;
   by sex;
run;

proc glm data=class;
   model weight = height;
   by sex;
   ods select fitplot;
run;

proc template;
   source Stat.GLM.Graphics.Fit;
run;

proc template;
   source Common.Zreg.Graphics.Fit;
run;

%include "\\tappan\AppDocs\common\saslatex_macros.sas" / nosource;

proc sort data=sashelp.class out=class;
   by sex;
run;

proc template;
define statgraph stat.glm.Graphics.Fit;
   dynamic _PREDLABEL _CONFLABEL _DEPLABEL _DEPNAME _INDLABEL 
      _SHORTINDLABEL _OBSNUM _Y _XVAR _UCL _LCL _UCLM _LCLM 
      _TITLE _Y_OBS _XVAR_OBS _PREDICTED _UCL_OBS _LCL_OBS 
      _UCLM_OBS _LCLM_OBS _FREQ _WEIGHT _ID1 _ID2 _ID3 _ID4 _ID5;
   BeginGraph;
      entrytitle _TITLE " for " _DEPNAME;
      layout overlay / xaxisopts=(label=_INDLABEL shortlabel=_SHORTINDLABEL)
         yaxisopts=(label=_DEPLABEL shortlabel=_DEPNAME);
         bandplot limitupper=_UCLM limitlower=_LCLM x=_XVAR / 
      connectorder=axis name="Confidence" LegendLabel=_CONFLABEL 
      outlineattrs= GRAPHCONFIDENCE fillattrs=GRAPHCONFIDENCE 
      datatransparency=0.5; if (EXISTS(_WEIGHT))
            scatterplot x=_XVAR_OBS y=_PREDICTED / markerattrs=(size=0)
            yerrorlower=_LCL_OBS yerrorupper=_UCL_OBS 
      rolename=(_tip1=_OBSNUM _tip2=_LCL_OBS _tip3=_UCL_OBS 
      _tip4=_LCLM_OBS _tip5=_UCLM_OBS _tip6 =_WEIGHT _id1=_ID1 
      _id2=_ID2 _id3=_ID3 _id4=_ID4 _id5=_ID5) tip=(y x _tip1 
      _tip2 _tip3 _tip4 _tip5 _tip6 _id1 _id2 _id3 _id4 _id5) 
      datatransparency=0.5 name="Prediction" LegendLabel=_PREDLABEL; else
            bandplot limitupper=_UCL limitlower=_LCL x=_XVAR / connectorder=
            axis name="Prediction" LegendLabel=_PREDLABEL outlineattrs=
            GRAPHPREDICTIONLIMITS fillattrs=GRAPHPREDICTIONLIMITS
            datatransparency=0.5 display=(outline);
         endif;
         seriesplot x=_XVAR y=_Y / connectorder=xaxis name="Fit" LegendLabel=
            "Fit" lineattrs=GRAPHFIT;
         scatterplot x=_XVAR_OBS y=_Y_OBS / primary=true rolename=(_tip1=
            _OBSNUM _tip2=_LCL_OBS _tip3=_UCL_OBS _tip4=_LCLM_OBS _tip5=
            _UCLM_OBS _id1=_ID1 _id2=_ID2 _id3=_ID3 _id4=_ID4
            _id5=_ID5) 
      tip=(y x _tip1 _tip2 _tip3 _tip4 _tip5 _id1 _id2 _id3 _id4 _id5);
         if (
            EXISTS(_LCLM) OR (EXISTS(_WEIGHT) AND EXISTS(_LCL_OBS))
            OR (NOT EXISTS(_WEIGHT) AND EXISTS(_LCL)))
            discretelegend "Fit" "Confidence" "Prediction";
         endif;
      endlayout;
   EndGraph;
end;
run;

ods graphics on;

%macro mygraph;
   proc glm data=__bydata;
      model weight = height;
      ods select fitplot;
%mend;

proc sort data=sashelp.class out=class(where=(sex='F')); by sex; run;

%output(doc)
%modtmplt(by=sex, data=class, template=Stat.GLM.Graphics.Fit, steps=tg)
%write(by1a, objects=FitPlot, width=3.15in)

proc template;
define statgraph stat.glm.Graphics.Fit;
   dynamic _PREDLABEL _CONFLABEL _DEPLABEL _DEPNAME _INDLABEL 
      _SHORTINDLABEL _OBSNUM _Y _XVAR _UCL _LCL _UCLM _LCLM 
      _TITLE _Y_OBS _XVAR_OBS _PREDICTED _UCL_OBS _LCL_OBS 
      _UCLM_OBS _LCLM_OBS _FREQ _WEIGHT _ID1 _ID2 _ID3 _ID4 _ID5;
   BeginGraph;
      entrytitle _TITLE " for " _DEPNAME;
      layout overlay / xaxisopts=(label=_INDLABEL shortlabel=_SHORTINDLABEL)
         yaxisopts=(label=_DEPLABEL shortlabel=_DEPNAME);
         bandplot limitupper=_UCLM limitlower=_LCLM x=_XVAR / 
      connectorder=axis name="Confidence" LegendLabel=_CONFLABEL 
      outlineattrs= GRAPHCONFIDENCE fillattrs=GRAPHCONFIDENCE 
      datatransparency=0.5; if (EXISTS(_WEIGHT))
            scatterplot x=_XVAR_OBS y=_PREDICTED / markerattrs=(size=0)
            yerrorlower=_LCL_OBS yerrorupper=_UCL_OBS 
      rolename=(_tip1=_OBSNUM _tip2=_LCL_OBS _tip3=_UCL_OBS 
      _tip4=_LCLM_OBS _tip5=_UCLM_OBS _tip6 =_WEIGHT _id1=_ID1 
      _id2=_ID2 _id3=_ID3 _id4=_ID4 _id5=_ID5) tip=(y x _tip1 
      _tip2 _tip3 _tip4 _tip5 _tip6 _id1 _id2 _id3 _id4 _id5) 
      datatransparency=0.5 name="Prediction" LegendLabel=_PREDLABEL; else
            bandplot limitupper=_UCL limitlower=_LCL x=_XVAR / connectorder=
            axis name="Prediction" LegendLabel=_PREDLABEL outlineattrs=
            GRAPHPREDICTIONLIMITS fillattrs=GRAPHPREDICTIONLIMITS
            datatransparency=0.5 display=(outline);
         endif;
         seriesplot x=_XVAR y=_Y / connectorder=xaxis name="Fit" LegendLabel=
            "Fit" lineattrs=GRAPHFIT;
         scatterplot x=_XVAR_OBS y=_Y_OBS / primary=true rolename=(_tip1=
            _OBSNUM _tip2=_LCL_OBS _tip3=_UCL_OBS _tip4=_LCLM_OBS _tip5=
            _UCLM_OBS _id1=_ID1 _id2=_ID2 _id3=_ID3 _id4=_ID4
            _id5=_ID5) 
      tip=(y x _tip1 _tip2 _tip3 _tip4 _tip5 _id1 _id2 _id3 _id4 _id5);
         if (
            EXISTS(_LCLM) OR (EXISTS(_WEIGHT) AND EXISTS(_LCL_OBS))
            OR (NOT EXISTS(_WEIGHT) AND EXISTS(_LCL)))
            discretelegend "Fit" "Confidence" "Prediction";
         endif;
      endlayout;
   EndGraph;
end;
run;

proc sort data=sashelp.class out=class(where=(sex='M')); by sex; run;

%output(doc)
%modtmplt(by=sex, data=class, template=Stat.GLM.Graphics.Fit, steps=tg)
%write(by1b, objects=FitPlot, width=3.15in)
%modtmplt(steps=d, template=Stat.GLM.Graphics.Fit)

%modtmplt(by=sex, data=class, statement=entrytitle,
          template=Stat.GLM.Graphics.Fit)
