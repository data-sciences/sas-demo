/****************************************************************/
/*     S T A T I S T I C A L   G R A P H I C S   S A M P L E    */
/*                                                              */
/*    NAME: panels                                              */
/*   TITLE: Panel Sample Code for Statistical Graphics in SAS   */
/*  SYSTEM: ALL                                                 */
/*    KEYS: statistical graphics                                */
/*                                                              */
/* SUPPORT: Warren F. Kuhfeld     UPDATE: February 2, 2010      */
/*     REF: Statistical Graphics in SAS                         */
/*    MISC:                                                     */
/****************************************************************/

proc format;
   value specname   1='Setosa    '    2='Versicolor'    3='Virginica ';
run;

data iris;
   input SepalLength SepalWidth PetalLength PetalWidth Species @@;
   format Species specname.;
   label SepalLength='Sepal Length'    SepalWidth ='Sepal Width'
         PetalLength='Petal Length'    PetalWidth ='Petal Width';
   datalines;
50 33 14 02 1 64 28 56 22 3 65 28 46 15 2 67 31 56 24 3
63 28 51 15 3 46 34 14 03 1 69 31 51 23 3 62 22 45 15 2
59 32 48 18 2 46 36 10 02 1 61 30 46 14 2 60 27 51 16 2
65 30 52 20 3 56 25 39 11 2 65 30 55 18 3 58 27 51 19 3
68 32 59 23 3 51 33 17 05 1 57 28 45 13 2 62 34 54 23 3
77 38 67 22 3 63 33 47 16 2 67 33 57 25 3 76 30 66 21 3
49 25 45 17 3 55 35 13 02 1 67 30 52 23 3 70 32 47 14 2
64 32 45 15 2 61 28 40 13 2 48 31 16 02 1 59 30 51 18 3
55 24 38 11 2 63 25 50 19 3 64 32 53 23 3 52 34 14 02 1
49 36 14 01 1 54 30 45 15 2 79 38 64 20 3 44 32 13 02 1
67 33 57 21 3 50 35 16 06 1 58 26 40 12 2 44 30 13 02 1
77 28 67 20 3 63 27 49 18 3 47 32 16 02 1 55 26 44 12 2
50 23 33 10 2 72 32 60 18 3 48 30 14 03 1 51 38 16 02 1
61 30 49 18 3 48 34 19 02 1 50 30 16 02 1 50 32 12 02 1
61 26 56 14 3 64 28 56 21 3 43 30 11 01 1 58 40 12 02 1
51 38 19 04 1 67 31 44 14 2 62 28 48 18 3 49 30 14 02 1
51 35 14 02 1 56 30 45 15 2 58 27 41 10 2 50 34 16 04 1
46 32 14 02 1 60 29 45 15 2 57 26 35 10 2 57 44 15 04 1
50 36 14 02 1 77 30 61 23 3 63 34 56 24 3 58 27 51 19 3
57 29 42 13 2 72 30 58 16 3 54 34 15 04 1 52 41 15 01 1
71 30 59 21 3 64 31 55 18 3 60 30 48 18 3 63 29 56 18 3
49 24 33 10 2 56 27 42 13 2 57 30 42 12 2 55 42 14 02 1
49 31 15 02 1 77 26 69 23 3 60 22 50 15 3 54 39 17 04 1
66 29 46 13 2 52 27 39 14 2 60 34 45 16 2 50 34 15 02 1
44 29 14 02 1 50 20 35 10 2 55 24 37 10 2 58 27 39 12 2
47 32 13 02 1 46 31 15 02 1 69 32 57 23 3 62 29 43 13 2
74 28 61 19 3 59 30 42 15 2 51 34 15 02 1 50 35 13 03 1
56 28 49 20 3 60 22 40 10 2 73 29 63 18 3 67 25 58 18 3
49 31 15 01 1 67 31 47 15 2 63 23 44 13 2 54 37 15 02 1
56 30 41 13 2 63 25 49 15 2 61 28 47 12 2 64 29 43 13 2
51 25 30 11 2 57 28 41 13 2 65 30 58 22 3 69 31 54 21 3
54 39 13 04 1 51 35 14 03 1 72 36 61 25 3 65 32 51 20 3
61 29 47 14 2 56 29 36 13 2 69 31 49 15 2 64 27 53 19 3
68 30 55 21 3 55 25 40 13 2 48 34 16 02 1 48 30 14 01 1
45 23 13 03 1 57 25 50 20 3 57 38 17 03 1 51 38 15 03 1
55 23 40 13 2 66 30 44 14 2 68 28 48 14 2 54 34 17 02 1
51 37 15 04 1 52 35 15 02 1 58 28 51 24 3 67 30 50 17 2
63 33 60 25 3 53 37 15 02 1
;

proc template;
   define statgraph matrix;
      begingraph / designheight=defaultdesignwidth;
         entrytitle 'Fisher Iris Data';
         layout gridded;
            scatterplotmatrix petallength petalwidth sepallength /
                       ellipse=(type=mean) diagonal=(histogram normal kernel);
         endlayout;
      EndGraph;
   end;
run;

proc sgrender data=iris(where=(species eq 3))
              template=matrix;
run;

proc sgscatter data=iris(where=(species eq 3));
   title 'Fisher Iris Data';
   matrix petallength petalwidth sepallength /
          ellipse=(type=mean) diagonal=(histogram normal kernel);
run;

proc template;
   define statgraph compare1;
      begingraph;
         entrytitle 'Fisher Iris Data';
         layout gridded;
            scatterplotmatrix petalwidth sepallength sepalwidth /
                              rowvars=(petallength);
         endlayout;
      EndGraph;
   end;
run;

proc sgrender data=iris template=compare1;
run;

proc sgscatter data=iris;
   title 'Fisher Iris Data';
   compare y=petallength x=(petalwidth sepallength sepalwidth);
run;

proc template;
   define statgraph compare2;
      begingraph / designheight=defaultdesignwidth;
         entrytitle 'Fisher Iris Data';
         layout gridded;
            scatterplotmatrix sepallength sepalwidth /
                              rowvars=(petallength petalwidth );
         endlayout;
      EndGraph;
   end;
run;

proc sgrender data=iris template=compare2;
run;

proc sgscatter data=iris;
   title 'Fisher Iris Data';
   compare y=(petallength petalwidth) x=(sepallength sepalwidth);
run;

proc sgscatter data=iris tmplout='template.sas';
   title 'Fisher Iris Data';
   compare y=(petallength petalwidth) x=(sepallength sepalwidth);
run;

proc template;
   define statgraph scatter;
      begingraph / designheight=defaultdesignwidth;
         entrytitle "Fisher Iris Data";
         layout lattice / rows=2 columns=2 rowgutter=10 columngutter=10;
            scatterplot x=petalwidth y=petallength;
            scatterplot x=sepalwidth y=sepallength;
            scatterplot x=sepallength y=petallength;
            scatterplot x=sepalwidth y=petalwidth;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=iris template=scatter;
run;

ods graphics on / height=640px width=640px;

proc sgscatter data=iris;
   title 'Fisher Iris Data';
   plot petallength * petalwidth sepallength * sepalwidth
        petallength * sepallength petalwidth * sepalwidth;
run;

ods graphics on / reset=all;

proc template;
   define statgraph scatter;
      begingraph;
         entrytitle "Fisher Iris Data";
         layout lattice / rows=2 columns=2 rowgutter=10 columngutter=10;
            layout overlay;
               scatterplot x=petalwidth y=petallength;
            endlayout;
            layout overlay;
               scatterplot x=sepalwidth y=sepallength;
            endlayout;
            layout overlay;
               scatterplot x=sepallength y=petallength;
            endlayout;
            layout overlay;
               scatterplot x=sepalwidth y=petalwidth;
            endlayout;
         endlayout;
      endgraph;
   end;
run;

proc template;
   define statgraph scatter;
      begingraph / designheight=defaultdesignwidth;
         entrytitle "Fisher Iris Data";
         layout lattice / rows=2 columns=2 rowgutter=10 columngutter=10;
            layout overlay;
               scatterplot x=petalwidth y=petallength;
               ellipse x=petalwidth y=petallength / type=predicted;
               pbsplineplot x=petalwidth y=petallength;
            endlayout;
            layout overlay;
               scatterplot x=sepalwidth y=sepallength;
               ellipse x=sepalwidth y=sepallength / type=predicted;
               pbsplineplot x=sepalwidth y=sepallength;
            endlayout;
            layout overlay;
               scatterplot x=sepallength y=petallength;
               ellipse x=sepallength y=petallength / type=predicted;
               pbsplineplot x=sepallength y=petallength;
            endlayout;
            layout overlay;
               scatterplot x=sepalwidth y=petalwidth;
               ellipse x=sepalwidth y=petalwidth / type=predicted;
               pbsplineplot x=sepalwidth y=petalwidth;
            endlayout;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=iris(where=(species=3)) template=scatter;
run;

ods graphics on / height=640px width=640px;

proc sgscatter data=iris(where=(species=3));
   title 'Fisher Iris Data';
   plot petallength * petalwidth sepallength * sepalwidth
        petallength * sepallength petalwidth * sepalwidth /
        ellipse=(type=predicted) pbspline;
run;

ods graphics on / reset=all;

proc template;
   define statgraph scatter4;
      begingraph / designheight=defaultdesignwidth;
         entrytitle "Fisher Iris Data";
         layout lattice / rows=2 columns=2 rowgutter=10 columngutter=10;

            %macro layout(v1,v2);
               layout overlay;
                  scatterplot  x=&v1 y=&v2;
                  ellipse      x=&v1 y=&v2 / type=predicted;
                  pbsplineplot x=&v1 y=&v2;
               endlayout;
            %mend;

            %layout(petalwidth,  petallength)

            %layout(sepalwidth,  sepallength)

            %layout(sepallength, petallength)

            %layout(sepalwidth,  petalwidth)
         endlayout;
      endgraph;
   end;
run;

proc glm data=sashelp.class;
   class sex;
   model weight = height age sex;
   output out=res r=r;
run;

proc template;
   define statgraph res;
      begingraph;
         entrytitle 'Residuals by Predictor';

         layout lattice / rows=2 columns=2;

            layout overlay;
               scatterplot y=r x=height / markercharacter=sex group=sex;
               loessplot   y=r x=height;
            endlayout;

            layout overlay;
               boxplot y=r x=sex;
            endlayout;

            layout overlay;
               scatterplot y=r x=age / markercharacter=sex group=sex;
               loessplot   y=r x=age;
            endlayout;

         endlayout;
      endgraph;
   end;
run;

proc sgrender data=res template=res;
label r ='Residual';
run;

proc template;
   define statgraph res;
      begingraph;
         entrytitle 'Residuals by Predictor';
         layout lattice / rows=2 columns=2;

            layout overlay / yaxisopts=(label='Residual');
               entry "Continuous" / location=outside;
               scatterplot y=r x=height / markercharacter=sex group=sex;
               loessplot   y=r x=height;
            endlayout;

            layout overlay / yaxisopts=(label='Residual');
               entry "Categorical" / location=outside;
               boxplot y=r x=sex;
            endlayout;

            layout overlay / yaxisopts=(label='Residual');
               entry "Continuous" / location=outside;
               scatterplot y=r x=age / markercharacter=sex group=sex;
               loessplot   y=r x=age;
            endlayout;

         endlayout;
      endgraph;
   end;
run;

proc sgrender data=res template=res;
run;

proc template;
   define statgraph res;
      begingraph;
         layout lattice / rows=2 columns=2;

            cell;
               cellheader;
                  entry "Continuous" / textattrs=(weight=bold);
                  entry "Predictor" / textattrs=(weight=bold);
               endcellheader;
               layout overlay / yaxisopts=(label='Residual');
                  scatterplot y=r x=height / markercharacter=sex group=sex;
                  loessplot   y=r x=height;
               endlayout;
            endcell;

            cell;
               cellheader;
                  entry "Categorical" / textattrs=(weight=bold);
                  entry "Predictor" / textattrs=(weight=bold);
               endcellheader;
               layout overlay / yaxisopts=(label='Residual');
                  boxplot y=r x=sex;
               endlayout;
            endcell;

            cell;
               cellheader;
                  entry "Continuous" / textattrs=(weight=bold);
                  entry "Predictor" / textattrs=(weight=bold);
               endcellheader;
               layout overlay / yaxisopts=(label='Residual');
                  scatterplot y=r x=age / markercharacter=sex group=sex;
                  loessplot   y=r x=age;
               endlayout;
            endcell;

         endlayout;
      endgraph;
   end;
run;

proc sgrender data=res template=res;
run;

proc template;
   define statgraph res;
      begingraph;
         entrytitle 'Residuals by Predictor';
         layout lattice / rows=2 columns=2 rowgutter=20 columngutter=100;

            layout overlay / yaxisopts=(label='Residual');
               entry "Continuous" / location=outside;
               scatterplot y=r x=height / markercharacter=sex group=sex;
               loessplot   y=r x=height;
            endlayout;

            layout overlay / yaxisopts=(label='Residual');
               entry "Categorical" / location=outside;
               boxplot y=r x=sex;
            endlayout;

            layout overlay / yaxisopts=(label='Residual');
               entry "Continuous" / location=outside;
               scatterplot y=r x=age / markercharacter=sex group=sex;
               loessplot   y=r x=age;
            endlayout;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=res template=res;
run;

proc template;
   define statgraph res;
      begingraph;
         entrytitle 'Residuals by Predictor';
         layout lattice / rows=2 columns=2 rowgutter=20 columngutter=20;

            layout overlay / xaxisopts=(offsetmin=0.1 offsetmax=0.1)
                             yaxisopts=(offsetmin=0.1 offsetmax=0.1
                             display=(line ticks tickvalues));
               scatterplot y=r x=height / markercharacter=sex group=sex;
               loessplot   y=r x=height;
            endlayout;

            layout overlay / yaxisopts=(display=(line ticks tickvalues));
               boxplot y=r x=sex;
            endlayout;

            layout overlay / xaxisopts=(offsetmin=0.1 offsetmax=0.1)
                             yaxisopts=(offsetmin=0.1 offsetmax=0.1
                             display=(line ticks tickvalues));
               scatterplot y=r x=age / markercharacter=sex group=sex;
               loessplot   y=r x=age;
            endlayout;

         sidebar / align=left;
            entry "Residual" / rotate=90;
         endsidebar;

         sidebar / align=bottom;
            entry "Analysis of the Class Data Set - July 25, 2009" /
                  textattrs=(weight=bold);
         endsidebar;

         endlayout;
      endgraph;
   end;
run;

proc sgrender data=res template=res;
run;

proc template;
   define statgraph res;
      begingraph;
         entrytitle 'Residuals by Predictor';
         layout lattice / rows=2 columns=2 rowgutter=20
                          rowdatarange=unionall;
            rowaxes;
               rowaxis / label="Residual";
               rowaxis / label="Residual";
            endrowaxes;

            layout overlay / xaxisopts=(offsetmin=0.1 offsetmax=0.1)
                             yaxisopts=(offsetmin=0.1 offsetmax=0.1);
               scatterplot y=r x=height / markercharacter=sex group=sex;
               loessplot   y=r x=height;
            endlayout;

            layout overlay;
               boxplot y=r x=sex;
            endlayout;

            layout overlay / xaxisopts=(offsetmin=0.1 offsetmax=0.1)
                             yaxisopts=(offsetmin=0.1 offsetmax=0.1);
               scatterplot y=r x=age / markercharacter=sex group=sex;
               loessplot   y=r x=age;
            endlayout;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=res template=res;
run;

proc template;
   define statgraph res1;
      begingraph;
         entrytitle 'Residuals by Predictor';
         layout lattice / rows=2 columns=2;
            scatterplot y=r x=height / markercharacter=sex group=sex;
            scatterplot y=r x=age / markercharacter=sex group=sex;
            boxplot y=r x=sex;
         endlayout;
      endgraph;
   end;

   define statgraph res2;
      begingraph;
         entrytitle 'Residuals by Predictor';
         layout gridded / rows=2 columns=2;
            scatterplot y=r x=height / markercharacter=sex group=sex;
            scatterplot y=r x=age / markercharacter=sex group=sex;
            boxplot y=r x=sex;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=res template=res1;
   label r = 'Residual';
run;

proc sgrender data=res template=res2;
   label r = 'Residual';
run;

proc template;
   define statgraph panel;
      begingraph;
         layout datapanel classvars=(make) / rows=2 columns=3;
            layout prototype;
               scatterplot x=mpg_city y=mpg_highway;
            endlayout;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.cars(where=(origin='Europe')) template=panel;
run;

proc sgpanel data=sashelp.cars(where=(origin='Europe'));
   title 'Cars by Make';
   panelby make / rows=2 columns=3;
   scatter x=mpg_city y=mpg_highway;
run;

data cars;
   if _n_ = 1 then do;
      type = 'Truck   '; output;
      type = 'SUV     '; output;
      type = 'Wagon   '; output;
      type = 'Sedan   '; output;
      type = 'Sports  '; output;
      type = 'Hybrid  '; output;
   end;
   set sashelp.cars;
   output;
run;

proc sgpanel data=sashelp.cars(where=(cylinders in (4, 6)));
   title 'Cars by Cylinders and Type'; 
   panelby cylinders type / rows=2 columns=3 sparse;
   scatter x=mpg_city y=mpg_highway;
run;

proc template;
   define statgraph panel;
      begingraph;
         layout datapanel classvars=(cylinders type) /
                          rows=2 columns=3 sparse=true;
            layout prototype;
               scatterplot x=mpg_city y=mpg_highway;
            endlayout;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.cars(where=(cylinders in (4, 6)))
              template=panel;
run;

proc template;
   define statgraph lattice;
      begingraph;
         layout datalattice columnvar=type rowvar=cylinders /
                            rows=2 columns=3;
            layout prototype;
               scatterplot x=mpg_city y=mpg_highway;
            endlayout;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.cars(where=(cylinders in (4, 6)))
              template=lattice;
run;

proc template;
   define statgraph lattice;
      begingraph;
         layout datalattice columnvar=type rowvar=cylinders /
                            rows=2 columns=3 panelnumber=2;
            layout prototype;
               scatterplot x=mpg_city y=mpg_highway;
            endlayout;
         endlayout;
      endgraph;
   end;
run;

proc sgrender data=sashelp.cars(where=(cylinders in (4, 6)))
              template=lattice;
run;

proc template;
   define statgraph panel;
      begingraph / designheight=defaultdesignwidth;
         layout datapanel classvars=(species) / rows=2 columns=2
                          rowdatarange=union columndatarange=union;
            layout prototype;
               scatterplot x=petallength y=petalwidth;
            endlayout;
         endlayout;
      endgraph;
   end;
run;

proc sgpanel data=sashelp.iris;
   title 'Fisher Iris Data';
   panelby species;
   scatter x=petallength y=petalwidth;
run;

proc sgrender data=sashelp.iris template=panel;
run;
