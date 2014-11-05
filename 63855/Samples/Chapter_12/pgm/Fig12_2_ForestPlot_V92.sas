/*--Create Study data--*/
data forest;
  input Study $1-16 grp OddsRatio LowerCL UpperCL Weight;
  format weight percent5.;
  format Q1 Q3 4.2;

  /*--Group=1 are individual study values--*/
  /*--Group=2 are overall values--*/
  ObsId=_N_;
  if grp=1 then do;
    lcl2=lowercl; 
    ucl2=uppercl;
    weight=weight*.05;
    Q1=OddsRatio-OddsRatio*weight;      
    Q3=OddsRatio+OddsRatio*weight;
  end;
  else do;
    study2=study;
	study="";
  end;

  /*--Set up columns to create the stat tables--*/
  OR='OR'; LCL='LCL'; UCL='UCL'; WT='Weight';

  datalines;
Modano  (1967)    1  0.590 0.096 3.634  1
Borodan (1981)    1  0.464 0.201 1.074  3.5
Leighton (1972)   1  0.394 0.076 2.055  2
Novak   (1992)    1  0.490 0.088 2.737  2
Stawer  (1998)    1  1.250 0.479 3.261  3
Truark   (2002)   1  0.129 0.027 0.605  2.5
Fayney   (2005)   1  0.313 0.054 1.805  2
Modano  (1969)    1  0.429 0.070 2.620  2
Soloway (2000)    1  0.718 0.237 2.179  3
Adams   (1999)    1  0.143 0.082 0.250  4
Truark2  (2002)   1  0.129 0.027 0.605  2.5
Fayney2  (2005)   1  0.313 0.054 1.805  2
Modano2 (1969)    1  0.429 0.070 2.620  2
Soloway2(2000)    1  0.718 0.237 2.179  3
Adams2   (1999)   1  0.143 0.082 0.250  4
Overall           2  0.328 0.233 0.462  .
;
run;

/*--Sort observations to reverse the display on Y axis--*/
proc sort data=forest out=forests;
  by descending obsid;
  run;

/*--Assign macro variables based on number of observations for use as Y axis offsets--*/
data _null_;
  pct=0.75/nobs;
  call symputx("pct", pct);
  call symputx("pct2", 2*pct);
  set forests nobs=nobs;
run;

/*--Create custom style--*/
proc template;
   define style styles.ForestColor;
      parent = Styles.analysis;

      style GraphFonts  from GraphFonts /                                                                
         'GraphDataFont' = ("<sans-serif>, <MTsans-serif>",7pt, bold)                                 
         'GraphValueFont' = ("<sans-serif>, <MTsans-serif>",7pt, bold);
      style GraphData1 from GraphData1 /                                      
         contrastcolor = GraphColors('gcdata2')                               
         color = GraphColors('gdata2'); 
      style GraphData2 from GraphData2 /                                      
         contrastcolor = GraphColors('gcdata1')                               
         color = GraphColors('gdata1'); 
   end;
run;

/*--Set Style, DPI, image parameters and titles--*/
ods listing sge=off image_dpi=200 style=Styles.ForestColor;
ods graphics / reset width=6in height=3in  imagename="Fig12_2_ForestPlotColor_V92";
title "Impact of Treatment on Mortality by Study";
title2 h=8pt 'Odds Ratio and 95% CL';

/*--Create the plot--*/
proc sgplot data=forests noautolegend; 
  /*--Display overall values (Study2)--*/
  scatter y=study2 x=oddsratio / markerattrs=(symbol=diamondfilled size=10);

  /*--Display individual values (Study)--*/
  scatter y=study x=oddsratio / xerrorupper=ucl2 xerrorlower=lcl2 markerattrs=(symbol=squarefilled);

  /*--Display statistics columns on X2 axis--*/
  scatter y=study x=or / markerchar=oddsratio x2axis;
  scatter y=study x=lcl / markerchar=lowercl x2axis;
  scatter y=study x=ucl / markerchar=uppercl x2axis;
  scatter y=study x=wt / markerchar=weight x2axis;

  /*--Draw other details in the graph--*/
  refline 1 100  / axis=x;
  refline 0.01 0.1 10 / axis=x lineattrs=(pattern=shortdash) transparency=0.5;
  inset '                          Favors Treatment'  / position=bottomleft;
  inset 'Favors Placebo'  / position=bottom;

  /*--Set X, X2 axis properties with fixed offsets--*/
  xaxis type=log offsetmin=0 offsetmax=0.35 min=0.01 max=100 minor display=(nolabel) ;
  x2axis offsetmin=0.7 display=(noticks nolabel);

  /*--Set Y axis properties using offsets computed earlier--*/
  yaxis display=(noticks nolabel) offsetmin=&pct2 offsetmax=&pct2;
run;

title;


