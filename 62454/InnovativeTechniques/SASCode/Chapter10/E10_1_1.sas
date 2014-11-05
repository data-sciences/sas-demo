* E10_1_1.sas
* 
* Introducing BOXPLOT;

filename image "&path\results\E10_1_1.emf";
goptions reset=all
         device=emf
         gsfname=image gsfmode=replace
         ftext='Arial';

title1 f=arial '10.1.1 Using PROC BOXPLOT';
proc sort data=advrpt.demog out=demog;
   by symp wt;
   run;

symbol1 color = blue h = .8 v=dot;
axis1 minor=none color=black
      label=(angle=90 rotate=0);

proc boxplot data=demog;
    plot wt*symp/ cframe  = cxdedede
                  boxstyle = schematicid
                  cboxes   = red
                  cboxfill = cyan
                  vaxis    = axis1
                  ;
   id race;
    run;
