* E10_2_1.sas
* 
* Using GFONT to build a Circle;
goptions reset=all border
         ftext=simplex;

title1 f=arial '10.2.1 Using GFONTT';

symbol1 color = blue v=dot h=2;
* Using the default symbol;
proc gplot data=advrpt.demog;
plot ht*wt;
run;

data fontdata(keep=char seg x y lp ptype);
retain char 'c'       
       seg   1       
       lp   'p';
ptype='w'; x=-10;   y=110; output fontdata;
ptype='v'; x=100; y=50;  output fontdata;
do deg = 0 to 360 by .5;   
   rad = deg*arcos(-1)/180;   
   x=50*cos(rad)+50; 
   y=50*sin(rad)+50; 
   output fontdata;
end;
run;
libname gfont0 "&path\data";
proc gfont data=fontdata
            name=mydot 
            nodisplay 
            filled 
            resolution=3;   
run;
symbol1 f=mydot c=blue v='c' h=1;
proc gplot data=advrpt.demog;
plot ht*wt;
run;
quit;

