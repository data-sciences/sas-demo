* E9_3_2b.sas
*
* Using the LEGEND statement;


* For SAS9.3 uncomment the following ODS statement
* if you want to create the EMF file;
* ods graphics off;


filename reg932b "&path\results\E9_3_2b.emf";
filename reg932c "&path\results\E9_3_2c.emf";


goptions reset=all;
goptions ftext='arial'
         dev=emf
         gsfname=reg932b gsfmode=replace;

title1 f=arial bold 'Regression of HT and WT';
title2 '9.3.2b Using a LEGEND Statement';
symbol1 c=blue  v=dot;
symbol2 c=red;
symbol3 c=green r=2;

legend1 position=(top left inside)
        mode=share
        value=(f='arial' t=1 'Height'
                         t=2 'Predicted'
                         t=3 'Upper 95'
                         t=4 'Lower 95')
        label=none
        frame
        across=2;

proc reg data=advrpt.demog;
model ht = wt;
plot ht*wt/conf
           legend=legend1; 
run;
quit;

goptions gsfname=reg932c;
title2 '9.3.2c Eliminating the Legend';

legend2 value= none
        label=none
        shape=symbol(.001,.001);

proc reg data=advrpt.demog;
model ht = wt;
plot ht*wt/conf
           legend=legend2; 
run;
quit;
