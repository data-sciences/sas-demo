ods graphics on;

data btb;
  infile 'c:\handbook3\datasets\BtB.dat' expandtabs missover;
  input idno drug$ Duration$ Treatment$ BDIpre BDI2m BDI3m BDI5m BDI8m;
run;

data btbl;
  set btb;
  array bdis {*} BDIpre -- BDI8m;
  array t {*} t1-t5 (0 2 3 5 8);
  do i=1 to 5;
    bdi=bdis{i};
    time=t{i};
    if i<5 and bdis{i+1}~=. then next=1;
    else next=0;
    if bdi~=. then output;
  end;
  drop BDI2m -- BDI8m t1-t5 i;
run;

proc sort data=btbl;
  by treatment time;
run;
proc boxplot data=btbl;
  plot bdi*time  / boxstyle=schematic continuous;
  by treatment;
run;

proc sort data=btb; 
  by treatment;
run;
proc sgscatter data=btb;
  matrix BDIpre -- BDI8m;
  by treatment;
run;

proc mixed data=btbl covtest noclprint=3;
 class drug duration treatment idno;
 model bdi=bdipre drug duration treatment time / s ddfm=bw;
 random int time /subject=idno type=un;
 where time>0;
run;

proc mixed data=btbl covtest noclprint=3;
 class drug duration treatment idno;
 model bdi=bdipre drug duration treatment time / s ddfm=bw;
 random int /subject=idno;
 where time>0;
run;

data btbl;
  set btbl;
  nexttime=time+next*.2;
run;

proc sgpanel data=btbl;
   panelby treatment / rows=2;
   scatter y=bdi x=nexttime / group=next;
   where time<8;
run;

