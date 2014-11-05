/****************************************************************/
/*     S T A T I S T I C A L   G R A P H I C S   S A M P L E    */
/*                                                              */
/*    NAME: gtl                                                 */
/*   TITLE: GTL Sample Code for Statistical Graphics in SAS     */
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
            scatterplot y=weight x=height;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=classscatter;
run;

proc sgplot data=sashelp.class;
   title 'Weight By Height';
   scatter y=weight x=height;
run;

proc template;
   define statgraph classscatter;
      begingraph;
         entrytitle 'Weight By Height';
         layout overlay /
            xaxisopts=(offsetmin=0.05 offsetmax=0.05 label='Class Height')
            yaxisopts=(offsetmin=0.05 offsetmax=0.05 label='Class Weight'
                       linearopts=(tickvaluesequence=(start=50
                       end=150 increment=25) viewmin=50));
            scatterplot y=weight x=height / datalabel=name
                        markerattrs=(symbol=circlefilled
                                     color=black size=3px);
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=classscatter;
run;

proc sgplot data=sashelp.class;
   title 'Weight By Height';
   scatter y=weight x=height / datalabel=name
                               markerattrs=(symbol=circlefilled
                                            color=black size=3px);
   xaxis offsetmin=0.05 offsetmax=0.05 label='Class Height';
   yaxis offsetmin=0.05 offsetmax=0.05 label='Class Weight'
         values=(50 to 150 by 25);
run;

proc template;
   define statgraph classreg;
      begingraph;
         entrytitle 'Linear Regression';
         layout overlay;
            scatterplot y=weight x=height;
            regressionplot y=weight x=height;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=classreg;
run;

proc sgplot data=sashelp.class noautolegend;
   title 'Linear Regression';
   reg y=weight x=height;
run;

proc template;
   define statgraph classreg;
      begingraph;
         entrytitle 'Cubic Fit Function';
         layout overlay;
            scatterplot y=weight x=height;
            regressionplot y=weight x=height / degree=3;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=classreg;
run;

proc sgplot data=sashelp.class noautolegend;
   title 'Cubic Fit Function';
   reg y=weight x=height / degree=3;
run;

proc sgplot data=sashelp.class noautolegend tmplout='fittmplt.sas';
   title 'Cubic Fit Function';
   reg y=weight x=height / degree=3;
run;

ods graphics on;

proc reg data=sashelp.class;
   model weight = height;
run;

proc glm data=sashelp.class;
   model weight = height;
run;

proc template;
   define statgraph classloess;
      begingraph;
         entrytitle 'Loess Fit Function';
         layout overlay;
            scatterplot y=weight x=height;
            loessplot y=weight x=height;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=classloess;
run;

proc sgplot data=sashelp.class noautolegend;
   title 'Loess Fit Function';
   loess y=weight x=height;
run;

data ENSO;
   input Pressure @@;
   Month=_N_;
   format Pressure 4.1;
   format Month 3.0;
   datalines;
12.9  11.3  10.6  11.2  10.9   7.5   7.7  11.7
12.9  14.3  10.9  13.7  17.1  14.0  15.3   8.5
 5.7   5.5   7.6   8.6   7.3   7.6  12.7  11.0
12.7  12.9  13.0  10.9  10.4  10.2   8.0  10.9
13.6  10.5   9.2  12.4  12.7  13.3  10.1   7.8
 4.8   3.0   2.5   6.3   9.7  11.6   8.6  12.4
10.5  13.3  10.4   8.1   3.7  10.7   5.1  10.4
10.9  11.7  11.4  13.7  14.1  14.0  12.5   6.3
 9.6  11.7   5.0  10.8  12.7  10.8  11.8  12.6
15.7  12.6  14.8   7.8   7.1  11.2   8.1   6.4
 5.2  12.0  10.2  12.7  10.2  14.7  12.2   7.1
 5.7   6.7   3.9   8.5   8.3  10.8  16.7  12.6
12.5  12.5   9.8   7.2   4.1  10.6  10.1  10.1
11.9  13.6  16.3  17.6  15.5  16.0  15.2  11.2
14.3  14.5   8.5  12.0  12.7  11.3  14.5  15.1
10.4  11.5  13.4   7.5   0.6   0.3   5.5   5.0
 4.6   8.2   9.9   9.2  12.5  10.9   9.9   8.9
 7.6   9.5   8.4  10.7  13.6  13.7  13.7  16.5
16.8  17.1  15.4   9.5   6.1  10.1   9.3   5.3
11.2  16.6  15.6  12.0  11.5   8.6  13.8   8.7
 8.6   8.6   8.7  12.8  13.2  14.0  13.4  14.8
;

ods graphics on;

proc loess data=ENSO;
   model Pressure=Month;
run;

proc loess data=ENSO;
   model Pressure=Month / select=AICC(global);
run;

proc template;
   define statgraph classpbs;
      begingraph;
         entrytitle 'Penalized B-Spline Fit Function';
         layout overlay;
            scatterplot  y=weight x=height;
            pbsplineplot y=weight x=height;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=classpbs;
run;

proc sgplot data=sashelp.class noautolegend;
   title 'Penalized B-Spline Fit Function';
   pbspline y=weight x=height;
run;

ods graphics on;

proc transreg data=enso;
   model identity(pressure) = pbspline(month);
run;

proc transreg data=enso;
   model identity(pressure) = pbspline(month / sbc lambda=2 10000 range);
run;

proc sort data=sashelp.class out=class;
   by sex;
run;

proc template;
   define statgraph classgroup;
      begingraph;
         entrytitle 'Separate Fit By Sex';
         layout overlay;
            scatterplot y=weight x=height / group=sex;
            regressionplot y=weight x=height / group=sex degree=3
                                               name='reg';
            discretelegend 'reg' / title='Sex';
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=class template=classgroup;
run;

proc sgplot data=class;
   title 'Separate Fit By Sex';
   reg y=weight x=height / group=sex degree=3;
run;

%modstyle(parent=statistical, name=StatColor)

proc sgrender data=class template=classgroup;
run;

proc sgplot data=class;
   title 'Separate Fit By Sex';
   reg y=weight x=height / group=sex degree=3;
run;

ods graphics on;

proc transreg data=sashelp.class;
   model identity(weight) = spline(height);
   output out=class clm cli p;
run;

proc sgplot data=sashelp.class;
   title 'Cubic Fit';
   reg y=weight x=height / degree=3 cli clm;
run;

proc template;
   define statgraph classfit;
      begingraph;
         entrytitle 'Cubic Fit';
         layout overlay;
            bandplot limitupper=cmuweight limitlower=cmlweight x=height /
                  connectorder=axis outlineattrs=GraphConfidence
                  name='95% Confidence Limits';
            bandplot limitupper=ciuweight limitlower=cilweight x=height /
                  connectorder=axis display=(outline)
                  outlineattrs=GraphPredictionLimits
                  name='95% Prediction Limits';
            scatterplot y=weight x=height;
            seriesplot y=pweight x=height / name='Fit' legendlabel='Fit'
                           connectorder=xaxis lineattrs=GraphFit;
            discretelegend 'Fit' '95% Confidence Limits'
                           '95% Prediction Limits';
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=class template=classfit;
run;

proc sort data=class out=sorted;
   by height;
run;

proc sgplot data=sorted;
   title 'Cubic Fit';
   band upper=cmuweight lower=cmlweight x=height /
        fillattrs=GraphConfidence
        name='b1' legendlabel='95% Confidence Limits';
   band upper=ciuweight lower=cilweight x=height /
        nofill lineattrs=GraphPredictionLimits
        name='b2' legendlabel='95% Prediction Limits';
   scatter y=weight x=height;
   series y=pweight x=height / legendlabel='Fit' lineattrs=GraphFit name='f';
   keylegend 'f' 'b1' 'b2';
run;

proc template;
   define statgraph classfit1;
      begingraph;
         entrytitle 'Cubic Fit';
         layout overlay;
            modelband "cliband" / display=(outline);
            modelband "clmband";
            scatterplot y=weight x=height;
            regressionplot y=weight x=height / degree=3
                           clm="clmband" cli="cliband";
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=classfit1;
run;

proc template;
   define statgraph classfit2;
      begingraph;
         entrytitle 'Cubic Fit';
         layout overlay;
            modelband "cliband" / fillattrs=GraphConfidence;
            modelband "clmband" / fillattrs=GraphConfidence2;
            scatterplot y=weight x=height;
            regressionplot y=weight x=height / degree=3
                           clm="clmband" cli="cliband";
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=classfit2;
run;

proc template;
   define statgraph classfit3;
      begingraph;
         entrytitle 'Cubic Fit';
         layout overlay;
            modelband "cliband" / outlineattrs=GraphPredictionLimits
                                  display=(outline)
                                  datatransparency=0.5;
            modelband "clmband" / fillattrs=GraphConfidence
                                  datatransparency=0.5;
            scatterplot y=weight x=height;
            regressionplot y=weight x=height / degree=3
                           clm="clmband" cli="cliband";
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=classfit3;
run;

proc template;
   define statgraph classfit4;
      begingraph;
         entrytitle 'Cubic Fit';
         layout overlay;
            modelband "cliband" /
                      outlineattrs=GraphPredictionLimits(pattern=solid)
                      display=(outline)
                      datatransparency=0.5;
            modelband "clmband" /
                      fillattrs=GraphConfidence(color=cx88AAAA)
                      datatransparency=0.5;
            scatterplot y=weight x=height;
            regressionplot y=weight x=height / degree=3
                           clm="clmband" cli="cliband";
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=classfit4;
run;

proc transreg data=sashelp.class ss2;
   ods output fitstatistics=fs;
   model identity(weight) = spline(height);
run;

data _null_;
   set fs;
   if _n_ = 1 then call symputx('R2', put(value2, 4.2), 'G');
   if _n_ = 2 then call symputx('mean', put(value1, best6.), 'G');
run;

proc template;
   define statgraph classreg1;
      mvar r2 mean;
      begingraph;
         entrytitle 'Cubic Fit Function';
         layout overlay;
            entry halign=left 'R' {sup '2'} ' = ' r2
                  ",   Mean = " mean / valign=top;
            scatterplot y=weight x=height;
            regressionplot y=weight x=height / degree=3;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=classreg1;
run;

proc template;
   define statgraph classreg2;
      mvar r2 mean;
      begingraph;
         entrytitle 'Cubic Fit Function';
         layout overlay;
            layout gridded / autoalign=(topright topleft
                                        bottomright bottomleft);
               entry 'R' {sup '2'} ' = ' r2;
               entry "  (*ESC*){unicode mu}(*ESC*){unicode hat}    = " mean /
                     textattrs=GraphValueText(family=GraphUnicodeText:FontFamily);
               endlayout;
            scatterplot y=weight x=height;
            regressionplot y=weight x=height / degree=3;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=classreg2;
run;

proc sgplot data=sashelp.class noautolegend;
   title 'Cubic Fit Function';
   inset "R(*ESC*){sup '2'} =  &r2"
         "(*ESC*){unicode mu}(*ESC*){unicode hat}   = &mean" /
         position=topleft;
   reg y=weight x=height / degree=3;
run;

proc template;
   define statgraph classreg3;
      mvar r2 mean;
      begingraph;
         entrytitle 'Cubic Fit Function';
         layout overlay;
            layout gridded / autoalign=(topright topleft
                                        bottomright bottomleft);
               entry 'R' {sup '2'} ' = ' r2;
               entry '  ' {unicode mu}{unicode hat} '  = ' mean /
                     textattrs=GraphValueText(family=GraphUnicodeText:FontFamily);
               endlayout;
            scatterplot y=weight x=height;
            regressionplot y=weight x=height / degree=3;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=classreg3;
run;

proc template;
   define statgraph barchart;
      begingraph;
         entrytitle 'Average Highway Mileage';
         layout overlay;
            barchart x=type y=mpg_highway / stat=mean orient=horizontal;
         endlayout;
      endgraph;
   end;
run;

proc sort data=sashelp.cars out=cars;
   by descending type;
run;

proc sgrender data=cars template=barchart;
run;

proc sgplot data=sashelp.cars;
   title 'Average Highway Mileage';
   hbar type / response=mpg_highway stat=mean;
run;

proc template;
   define statgraph barchart;
      begingraph;
         entrytitle 'Average Highway Mileage';
         layout overlay;
            barchart x=type y=mpg_highway / stat=mean;
         endlayout;
      endgraph;
   end;
run;

proc sort data=sashelp.cars out=cars;
   by type;
run;

proc sgrender data=cars template=barchart;
run;

proc sgplot data=sashelp.cars;
   title 'Average Highway Mileage';
   vbar type / response=mpg_highway stat=mean;
run;

proc sgplot data=sashelp.cars noautolegend;
   title 'Average Mileage by Vehicle Type';
   vbar type / response=mpg_highway stat=mean numstd=2 limitstat=stderr;
   footnote justify=left 'Error Bars Show 2 Standard Errors';
run;

proc summary data=sashelp.cars nway;
   class type;
   var mpg_highway;
   output out=mileage mean=mean stderr=stderr;
run;

proc template;
   define statgraph barchartparm;
      begingraph;
         entrytitle    "Average Mileage by Vehicle Type";
         entryfootnote halign=left textattrs=GraphValueText
                       "Error Bars Show 2 Standard Errors";
         layout overlay;
            barchartparm x=type y=mean /
                     errorlower=eval(mean - 2 * stderr)
                     errorupper=eval(mean + 2 * stderr);
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=mileage template=barchartparm;
run;

proc template;
   define statgraph barchartparm;
      begingraph;
         entrytitle    "Average Mileage by Vehicle Type";
         entryfootnote halign=left textattrs=GraphValueText
                       "Error Bars Show 2 Standard Errors";
         layout overlay;
            barchartparm x=type y=mean / orient=horizontal
                     datatransparency=0.75
                     errorlower=eval(mean - 2 * stderr)
                     errorupper=eval(mean + 2 * stderr);
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=mileage template=barchartparm;
run;

proc template;
   define statgraph classhist;
      begingraph;
         entrytitle 'Distribution of Weight';
         layout overlay;
            histogram weight;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=classhist;
run;

proc sgplot data=sashelp.class;
   title 'Distribution of Weight';
   histogram weight / showbins;
run;

proc template;
   define statgraph classhist;
      begingraph;
         entrytitle 'Distribution of Weight';
         layout overlay;
            histogram weight / binaxis=false;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=classhist;
run;

proc sgplot data=sashelp.class;
   title 'Distribution of Weight';
   histogram weight;
run;

proc template;
   define statgraph classhist;
      begingraph;
         entrytitle 'Distribution of Weight';
         layout overlay;
            histogram weight / endlabels=true;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=classhist;
run;

data class;
   set sashelp.class;
   w1 = round(weight - 10, 20) + 10;
   w2 = round(weight, 25);
   label w1 = 'Weight' w2 = 'Weight';
run;

proc freq data=class;
   tables w1 / out=freqs1 noprint;
   tables w2 / out=freqs2 noprint;
run;

proc template;
   define statgraph classhist;
      mvar x;
      begingraph;
         entrytitle 'Distribution of Weight';
         layout overlay;
            histogramparm x=x y=count;
         endlayout;
      endgraph;
   end;
run;

%let x = w1;
proc sgrender data=freqs1 template=classhist;
run;

%let x = w2;
proc sgrender data=freqs2 template=classhist;
run;

proc template;
   define statgraph classhist;
      begingraph;
         entrytitle 'Distribution of Weight';
         layout overlay;
            histogramparm x=w1 y=count;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=freqs1 template=classhist;
run;

proc template;
   define statgraph classhist;
      begingraph;
         entrytitle 'Distribution of Weight';
         layout overlay;
            histogramparm x=w2 y=count;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=freqs2 template=classhist;
run;

proc template;
   define statgraph classhistden;
      begingraph;
         entrytitle 'Distribution of Weight';
         layout overlay;
            histogram weight;
            densityplot weight / kernel();
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=classhistden;
run;

proc sgplot data=sashelp.class noautolegend;
   title 'Distribution of Weight';
   histogram weight / showbins;
   density weight / type=kernel;
run;

proc template;
   define statgraph classhistden2;
      begingraph;
         entrytitle 'Distribution of Weight';
         layout overlay;
            histogram weight;
            densityplot weight / normal();
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=classhistden2;
run;

proc sgplot data=sashelp.class noautolegend;
   title 'Distribution of Weight';
   histogram weight / showbins;
   density weight / type=normal;
run;

ods graphics on;

proc kde data=sashelp.class;
   univar weight;
run;

proc kde data=sashelp.class;
   bivar height weight;
run;

proc univariate data=sashelp.class;
   var weight;
   histogram weight / kernel normal;
run;

proc univariate data=sashelp.class;
   class sex;
   var weight;
   histogram weight / kernel normal;
run;

proc template;
   define statgraph classhistden;
      begingraph;
         entrytitle 'Distribution of Weight';
         layout overlay;
            histogram weight;
            densityplot weight / kernel();
            fringeplot weight;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=classhistden;
run;

data x(drop=c);
   c = sqrt(2 * constant('pi'));
   do x = -4 to 4 by 0.05;
      y = exp(-0.5 * x ** 2) / c;
      if -3.5 le x le 3.5 and abs(x - round(x)) < 1e-8 then z = y;
      else z = .;
      output;
   end;
run;

proc template;
   define statgraph normal;
      begingraph;
         entrytitle 'Normal Density Function';
         layout overlay;
            seriesplot x=x y=y / lineattrs=graphfit;
            dropline x=x y=z / dropto=x;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=x template=normal;
run;

data x(drop=c);
   c = sqrt(2 * constant('pi'));
   do x = -4 to 4 by 0.05;
      y = exp(-0.5 * x ** 2) / c;
      output;
   end;
run;

proc template;
   define statgraph normal;
      begingraph;
         entrytitle 'Normal Density Function';
         layout overlay;
            seriesplot x=x y=y / lineattrs=graphfit;
            scatterplot x=eval((log(-3.5 le x le 3.5 and
                           abs(x - round(x)) < 1e-8) + 1) * x - 0.5)
                        y=eval(0 * x + 0.04) /
                        markercharacter=eval(put(probnorm(x), 4.3));
            dropline x=x y=eval((log(-3.5 le x le 3.5 and
                           abs(x - round(x)) < 1e-8) + 1) * y) / dropto=x;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=x template=normal;
   label x = '00'x y = '00'x;
run;

proc template;
   define statgraph classbox;
      begingraph;
         entrytitle 'Distribution of Weight By Sex';
         layout overlay;
            boxplot y=weight x=sex;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=classbox;
run;

proc sgplot data=sashelp.class noautolegend;
   title 'Distribution of Weight By Sex';
   vbox weight / category=sex;
run;

proc template;
   define statgraph classbox;
      begingraph;
         entrytitle 'Distribution of Weight By Sex';
         layout overlay;
            boxplot y=weight x=sex / orient=horizontal;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=classbox;
run;

proc sgplot data=sashelp.class noautolegend;
   title 'Distribution of Weight By Sex';
   hbox weight / category=sex;
run;

ods graphics on;

proc sort data=sashelp.class out=class;
   by sex;
run;

proc boxplot data=class;
   plot weight*sex;
run;

proc boxplot data=class;
   plot weight*sex / horizontal;
run;

proc univariate data=sashelp.class;
   var weight;
   class sex;
   ods output quantiles=q;
run;

data q2;
   set q;
   quantile = scan(quantile, 2, ' ');
   if quantile ne ' ';
run;

proc print;
run;

proc template;
   define statgraph boxplotparm1;
      begingraph;
         entrytitle "Class Data Set Weights";
         layout overlay;
            boxplotparm y=estimate x=sex stat=quantile;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=q2 template=boxplotparm1;
run;

proc template;
   define statgraph boxplotparm2;
      begingraph;
         entrytitle "Class Data Set Weights";
         layout overlay;
            boxplotparm y=estimate x=sex stat=quantile /
                        orient=horizontal display=(median);
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=q2 template=boxplotparm2;
run;

proc template;
   define statgraph seriesplot;
      begingraph;
         entrytitle 'Stock Trends';
         layout overlay; 	
           seriesplot x=date y=close / group=stock name='stocks';
           discretelegend 'stocks' / title='Stock';
         endlayout;	
      endgraph;
   end;
run;

proc sgrender data=sashelp.stocks template=seriesplot;
run;

proc sgplot data=sashelp.stocks;
   title 'Stock Trends';
   series x=date y=close / group=stock;
run;

proc means data=sashelp.class noprint nway;
   var height;
   class age;
   output out=class mean=height lclm=lower uclm=upper;
   label height = 'Height(Mean)';
run;

proc template;
   define statgraph dotplot;
      begingraph;
         entrytitle 'Average Height By Age';
         layout overlay / yaxisopts=(type=discrete griddisplay=on
                                     reverse=true);
            scatterplot y=age x=height / xerrorlower=lower xerrorupper=upper
                        markerattrs=(symbol=circlefilled) name='dot'
                        legendlabel='Height(Mean), 95% Confidence Limits';
            discretelegend 'dot';
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=class template=dotplot;
run;

proc sgplot data=sashelp.class;
   title 'Average Height By Age';
   dot age / response=height stat=mean limits=both;
run;

proc template;
   define statgraph ellipse;
      begingraph;
         entrytitle 'Prediction Ellipse';
         layout overlay;
            scatterplot x=height y=weight;
            ellipse x=height y=weight / type=predicted
                    legendlabel='95% Prediction Ellipse' name='ellipse';
            discretelegend 'ellipse' / location=inside
                    halign=right valign=bottom;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.class template=ellipse;
run;

proc sgplot data=sashelp.class;
   title 'Prediction Ellipse';
   scatter x=height y=weight;
   ellipse x=height y=weight;
   keylegend / location=inside position=bottomright;
run;

proc sgplot data=sashelp.class;
   title 'Prediction Ellipse';
   scatter x=height y=weight;
   ellipse x=height y=weight / name='e';
   keylegend 'e' / location=inside position=bottomright;
run;

data x;
   major = 0.5;
   minor = 0.25;
   input slope x y;
   l = slope;
   datalines;
-1.00  -1 -1
-0.75  -1  0
-0.50  -1  1
-0.25   0  1
 0.00   1  1
 0.25   1  0
 0.50   1 -1
 0.75   0 -1
 1.00   0  0
;

proc template;
   define statgraph ellipse;
      begingraph;
         layout overlayequated / equatetype=square;
            scatterplot x=x y=y / markercharacter=l;
            ellipseparm semimajor=major semiminor=minor slope=slope
                        xorigin=x yorigin=y;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=x template=ellipse;
run;

data y;
   input slope major minor x y;
   l = put(major, 2.1) || ', ' || put(minor, 2.1) || ', ' || put(slope, 5.2);
   datalines;
-1.00  .4  .2  -1  -1
-0.75  .4  .3  -1   0
-0.50  .4  .4  -1   1
-0.25  .5  .3   0   1
 0.00  .5  .4   1   1
 0.25  .5  .5   1   0
 0.50  .6  .2   1  -1
 0.75  .6  .4   0  -1
 1.00  .6  .6   0   0
;

proc sgrender data=y template=ellipse;
run;

%let title     = Weight by Height with Age Grouped by Sex;
%let data      = sashelp.class;
%let xvar      = height;
%let yvar      = weight;
%let opts      = group=sex;
%let bubblevar = age - 10;
%let function  = sqrt;
%let scale     = 0.01;

proc means data=&data noprint;
   output out=__minmax min(&xvar &yvar)=mx my max(&xvar &yvar)=mxx mxy;
run;

data _null_;
   set __minmax;

   range = max(mxx - mx, 1e-16);
   inc = 10 ** ceil(log10(range) - 1.0);
   if range / inc >= 7.5 then inc = inc * 2;
   if range / inc <= 2.5 then inc = inc / 2;
   if range / inc <= 2.5 then inc = inc / 2;
   call symputx('__xmin', floor(mx / inc) * inc);
   call symputx('__xmax', ceil(mxx / inc) * inc);
   call symputx('__xinc', inc);

   range = max(mxy - my, 1e-16);
   inc = 10 ** ceil(log10(range) - 1.0);
   if range / inc >= 7.5 then inc = inc * 2;
   if range / inc <= 2.5 then inc = inc / 2;
   if range / inc <= 2.5 then inc = inc / 2;
   call symputx('__ymin', floor(my / inc) * inc);
   call symputx('__ymax', ceil(mxy / inc) * inc);
   call symputx('__yinc', inc);
run;

proc template;
   define statgraph bubbleplot;
      begingraph;
         entrytitle "&title";
         layout overlay /
            xaxisopts=(linearopts=(
                       viewmin=&__xmin viewmax=&__xmax
                       tickvaluesequence=(start=&__xmin
                       end=&__xmax increment=&__xinc)))
            yaxisopts=(linearopts=(
                       viewmin=&__ymin viewmax=&__ymax
                       tickvaluesequence=(start=&__ymin
                       end=&__ymax increment=&__yinc)));
            scatterplot x=&xvar y=&yvar / datatransparency=1;
            ellipseparm semimajor=__a1 semiminor=__a2 slope=0
                        xorigin=&xvar yorigin=&yvar /
                        outlineattrs=(pattern=solid)
                        &opts;
         endlayout;
      endgraph;
   end;
run;

data __minmax;
   set &data;
   __a1 = &scale * (&__xmax - &__xmin) * &function(max(&bubblevar, 1e-16)) *
          (480 / 640);
   __a2 = &scale * (&__ymax - &__ymin) * &function(max(&bubblevar, 1e-16));
run;

proc sgrender data=__minmax template=bubbleplot;
run;

%let title     = Weight by Height with Age Grouped by Sex;
%let data      = sashelp.class;
%let xvar      = height;
%let yvar      = weight;
%let opts      = group=sex;
%let bubblevar = age - 10;
%let function  = ;
%let scale     = 0.01;

proc template;
   define statgraph bubbleplot;
      nmvar __xmin __xmax __xinc __ymin __ymax __yinc;
      mvar title xvar yvar;
      begingraph;
         entrytitle title;
         layout overlay /
            xaxisopts=(linearopts=(
                       viewmin=__xmin viewmax=__xmax
                       tickvaluesequence=(start=__xmin
                       end=__xmax increment=__xinc)))
            yaxisopts=(linearopts=(
                       viewmin=__ymin viewmax=__ymax
                       tickvaluesequence=(start=__ymin
                       end=__ymax increment=__yinc)));
            scatterplot x=xvar y=yvar / datatransparency=1;
            ellipseparm semimajor=__a1 semiminor=__a2 slope=0
                        xorigin=xvar yorigin=yvar /
                        outlineattrs=(pattern=solid)
                        &opts;
         endlayout;
      endgraph;
   end;
run;

proc means data=sashelp.class noprint nway;
   var height;
   class age;
   output out=class mean=height lclm=lower uclm=upper;
   label height = 'Height(Mean)';
run;

proc template;
   define statgraph vline;
      begingraph;
         entrytitle 'Average Height By Age';
         layout overlay / xaxisopts=(type=discrete);
            seriesplot x=age y=height /
                legendlabel='Height (Mean), 95% Confidence Limits' name='vline';
             scatterplot x=age y=height / markerattrs=(size=0)
                yerrorupper=upper yerrorlower=lower;
            discretelegend 'vline';
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=class template=vline;
run;

proc sgplot data=sashelp.class;
   title 'Average Height By Age';
   vline age / response=height stat=mean limits=both;
run;

proc means data=sashelp.class noprint nway;
   var height;
   class age;
   output out=class mean=height lclm=lower uclm=upper;
   label height = 'Height(Mean)';
run;

proc template;
   define statgraph hline;
      begingraph;
         entrytitle 'Average Height By Age';
         layout overlay / yaxisopts=(type=discrete reverse=true);
            seriesplot x=height y=age /
                legendlabel='Height (Mean), 95% Confidence Limits'
                            name='hline';
             scatterplot x=height y=age / markerattrs=(size=0)
                xerrorupper=upper xerrorlower=lower;
            discretelegend 'hline';
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=class template=hline;
run;

proc sgplot data=sashelp.class;
   title 'Average Height By Age';
   hline age / response=height stat=mean limits=both;
run;

proc template;
   define statgraph needle;
      begingraph;
         entrytitle 'Stock Trends';
         layout overlay;
            needleplot x=date y=close;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.stocks template=needle;
run;

proc sgplot data=sashelp.stocks;
   title 'Stock Trends';
   needle x=date y=close;
run;

proc means data=sashelp.class noprint nway;
   var weight;
   class height;
   output out=class mean=weight lclm=lower uclm=upper;
   label weight = 'Mean Weight';
run;

proc template;
   define statgraph step;
      begingraph;
         entrytitle 'Average Weight by Height';
         layout overlay;
            stepplot x=height y=weight / display=(markers)
                                         markerattrs=(size=3px);
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=class template=step;
run;

proc sgplot data=class;
   title 'Average Weight by Height';
   step x=height y=weight;
run;

proc sgplot data=class;
   title 'Average Height by Weight';
   step x=height y=weight / markers markerattrs=(size=3px);
run;

data corresp;
   input Type $ Name $ 5-25 Dim1 Dim2;
   label dim1 = 'Dimension 1' dim2 = 'Dimension 2';
   datalines;
OBS  Married              -0.02783     0.01339
OBS  Married with Kids     0.19912     0.00639
OBS  Single               -0.17160     0.00762
OBS  Single with Kids     -0.01440    -0.19470
VAR  American              0.18472    -0.01660
VAR  European              0.00129     0.10734
VAR  Japanese             -0.14278    -0.01630
;

proc template;
   define statgraph vector;
      begingraph;
         entrytitle 'Automobile Owners and Auto Attributes';
         layout overlayequated / equatetype=fit;
            referenceline x=0;
            referenceline y=0;
            vectorplot y=dim2 x=dim1 xorigin=0 yorigin=0 /
                       datalabel=name group=type lineattrs=(pattern=solid);
          endlayout;
      endgraph;
   end;
run;

proc sgrender data=corresp template=vector;
run;

proc sgplot data=corresp noautolegend;
   title 'Automobile Owners and Auto Attributes';
   refline 0 / axis=x;
   refline 0 / axis=y;
   vector x=dim1 y=dim2 / datalabel=name group=type lineattrs=(pattern=solid);
run;

proc template;
   define statgraph contour;
      mvar title;
      begingraph;
         entrytitle title;
         layout overlayequated / equatetype=square
                xaxisopts=(offsetmin=0 offsetmax=0)
                yaxisopts=(offsetmin=0 offsetmax=0);
            contourplotparm x=x y=y z=z;
         endlayout;
      endgraph;
   end;
run;

data swirl;
   do x = -5 to 5 by 0.1;
      do y = -5 to 5 by 0.1;
         z = x * x + y * y;
         if z > 1e-16 then z = x * y * (x * x - y * y) / z;
         output;
      end;
   end;
run;

data normal;
   do x = -2 to 2 by 0.1;
      do y = -2 to 2 by 0.1;
         z = 0.164 * exp(-0.5 * ((x + y * 0.25) * x + (x * 0.25 + y) * y));
         output;
      end;
   end;
run;

%let title = Contour Plot of the Swirl Data;
proc sgrender data=swirl template=contour;
run;

%let title = Contour Plot of a Bivariate Normal Density;
proc sgrender data=normal template=contour;
run;

proc template;
   define style mystyle;
      parent = Styles.statistical;
      class ThreeColorRamp /
         endcolor = CX6666FF
         neutralcolor = CXFFBBFF
         startcolor = CXFF6666
      end;
   end;

   define statgraph contour;
      mvar title;
      begingraph;
         entrytitle title;
         layout overlayequated / equatetype=square
                xaxisopts=(offsetmin=0 offsetmax=0)
                yaxisopts=(offsetmin=0 offsetmax=0);
            contourplotparm x=x y=y z=z / name='cont';
            continuouslegend 'cont';
         endlayout;
      endgraph;
   end;
run;

ods listing style=mystyle;

%let title = Contour Plot of the Swirl Data;
proc sgrender data=swirl template=contour;
run;

%let title = Contour Plot of a Bivariate Normal Density;
proc sgrender data=normal template=contour;
run;

ods listing;

proc template;
   source styles.default;
   source styles.statistical;
run;

proc template;
   define statgraph contourplotparm;
      mvar title;
      begingraph;
         entrytitle title;
         layout overlayequated / equatetype=square
            xaxisopts=(offsetmin=0 offsetmax=0)
            yaxisopts=(offsetmin=0 offsetmax=0);
            scatterplot x=a y=b / markerattrs=(size=1px);
            contourplotparm x=x y=y z=z;
         endlayout;
      endgraph;
   end;
run;

data normal;
   do x = -4 to 4 by 0.1;
      do y = -4 to 4 by 0.1;
         z = 0.164 * exp(-0.5 * ((x + y * 0.25) * x + (x * 0.25 + y) * y));
         output;
      end;
   end;
run;

data sample(drop=i);
   do i = 1 to 10000;
      a = normal(104);
      b = -0.25 * a + sqrt(1 - 0.25 ** 2) * normal(104);
      output;
   end;
run;

data normal;
   merge normal sample;
run;

proc sgrender data=normal template=contourplotparm;
run;

proc template;
   define statgraph contourplotparm;
      mvar title;
      begingraph;
         entrytitle title;
         layout overlayequated / equatetype=square
            commonaxisopts=(viewmin=-4 viewmax=4)
            xaxisopts=(offsetmin=0 offsetmax=0)
            yaxisopts=(offsetmin=0 offsetmax=0);
            contourplotparm x=x y=y z=z / contourtype=gradient;
            scatterplot x=a y=b / markerattrs=(size=1px);
            contourplotparm x=x y=y z=z / contourtype=labeledline;
         endlayout;
      endgraph;
   end;
run;

data normal;
   do x = -4 to 4 by 0.1;
      do y = -4 to 4 by 0.1;
         z = 0.164 * exp(-0.5 * ((x + y * 0.25) * x + (x * 0.25 + y) * y));
         output;
      end;
   end;
run;

data sample(drop=i);
   do i = 1 to 10000;
      a = normal(104);
      b = -0.25 * a + sqrt(1 - 0.25 ** 2) * normal(104);
      output;
   end;
run;

data normal;
   merge normal sample;
run;

proc sgrender data=normal template=contourplotparm;
run;

data ENSO;
   input Pressure @@;
   Month  = _N_;
   Year   = ceil(month / 12);
   ElNino = ceil(month / 42);
   format Pressure 4.1;
   format Month 3.0;
   datalines;
12.9  11.3  10.6  11.2  10.9   7.5   7.7  11.7
12.9  14.3  10.9  13.7  17.1  14.0  15.3   8.5
 5.7   5.5   7.6   8.6   7.3   7.6  12.7  11.0
12.7  12.9  13.0  10.9  10.4  10.2   8.0  10.9
13.6  10.5   9.2  12.4  12.7  13.3  10.1   7.8
 4.8   3.0   2.5   6.3   9.7  11.6   8.6  12.4
10.5  13.3  10.4   8.1   3.7  10.7   5.1  10.4
10.9  11.7  11.4  13.7  14.1  14.0  12.5   6.3
 9.6  11.7   5.0  10.8  12.7  10.8  11.8  12.6
15.7  12.6  14.8   7.8   7.1  11.2   8.1   6.4
 5.2  12.0  10.2  12.7  10.2  14.7  12.2   7.1
 5.7   6.7   3.9   8.5   8.3  10.8  16.7  12.6
12.5  12.5   9.8   7.2   4.1  10.6  10.1  10.1
11.9  13.6  16.3  17.6  15.5  16.0  15.2  11.2
14.3  14.5   8.5  12.0  12.7  11.3  14.5  15.1
10.4  11.5  13.4   7.5   0.6   0.3   5.5   5.0
 4.6   8.2   9.9   9.2  12.5  10.9   9.9   8.9
 7.6   9.5   8.4  10.7  13.6  13.7  13.7  16.5
16.8  17.1  15.4   9.5   6.1  10.1   9.3   5.3
11.2  16.6  15.6  12.0  11.5   8.6  13.8   8.7
 8.6   8.6   8.7  12.8  13.2  14.0  13.4  14.8
;

proc template;
   define statgraph block;
      begingraph;
         entrytitle 'Annual Cycle of Pressure Differences';
         layout overlay;
            blockplot x=month  block=year / valuevalign=bottom
               datatransparency=0.75 display=(fill values);
            scatterplot  y=pressure x=month;
            pbsplineplot y=pressure x=month;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=enso template=block;
run;

proc template;
   define statgraph block2;
      begingraph;
         entrytitle 'El Ni(*ESC*){Unicode "00F1"x}o '
                    'Cycle of Pressure Differences';
         layout overlay / xaxisopts=(offsetmin=0 offsetmax=0);
            blockplot x=month  block=elnino /
               datatransparency=0.75 display=(fill outline);
            scatterplot  y=pressure x=month;
            pbsplineplot y=pressure x=month;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=enso template=block2;
run;

data normal;
   do x = -2 to 2 by 0.1;
      do y = -2 to 2 by 0.1;
         z = 0.164 * exp(-0.5 * ((x + y * 0.25) * x + (x * 0.25 + y) * y));
         output;
      end;
   end;
run;

proc template;
   define statgraph surfaceplotparm1;
      begingraph;
         entrytitle "Surface Plot of Normal Density Function";
         layout overlay3d;
            surfaceplotparm x=x y=y z=z;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=normal template=surfaceplotparm1;
run;

proc template;
   define statgraph surfaceplotparm2;
      begingraph;
         entrytitle "Surface Plot of Normal Density Function";
         layout overlay3d / cube=false;
            surfaceplotparm x=x y=y z=z / surfacetype=wireframe
                                          fillattrs=(color=black);
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=normal template=surfaceplotparm2;
run;

data normal;
   do x = -4 to 4 by 0.5;
      do y = -4 to 4 by 0.5;
         z = 0.164 * exp(-0.5 * ((x + y * 0.25) * x + (x * 0.25 + y) * y));
         output;
      end;
   end;
run;

proc template;
   define statgraph bihistogram1;
      begingraph;
         entrytitle "Bivariate Normal Density";
         layout overlay3d / cube=false;
            bihistogram3dparm x=x y=y z=z;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=normal template=bihistogram1;
run;

data sample(drop=i);
   do i = 1 to 100000;
      x = normal(104);
      y = -0.25 * x + sqrt(1 - 0.25 ** 2) * normal(104);
      output;
   end;
run;

data sample2;
   set sample;
   x = round(x, 0.5);
   y = round(y, 0.5);
run;

proc summary data=sample2 nway completetypes;
   class x y;
   var y;
   output out=sample3(keep=x y z) n=z;
run;

proc template;
   define statgraph bihistogram2;
      begingraph;
         entrytitle "Bivariate Normal Density";
         layout overlay3d / cube=false zaxisopts=(griddisplay=on);
            bihistogram3dparm x=x y=y z=z / display=all;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sample3 template=bihistogram2;
run;
