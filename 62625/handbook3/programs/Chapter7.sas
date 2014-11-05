ods graphics on;

data uscrime;
    infile 'c:\handbook3\datasets\uscrime.dat' expandtabs;
    input R Age S Ed Ex0 Ex1 LF M N NW U1 U2 W X;
run;

proc sgscatter data=uscrime;
  matrix R--X;
run;

proc reg data=uscrime;
    model R= Age--X / vif;
run;

proc reg data=uscrime;
    model R= Age--Ed Ex1--X / vif;
run;

proc reg data=uscrime;
    model R= Age--Ed Ex1--X / selection=stepwise sle=.05 sls=.05;
run;

