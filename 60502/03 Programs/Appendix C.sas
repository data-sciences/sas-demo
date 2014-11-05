/*-------------------------------------------------------------------------------------------
Daten erzeugen
-------------------------------------------------------------------------------------------*/




data dogs_wide; 
      input Drug $12. Depleted $ Histamine0 Histamine1 
            Histamine3 Histamine5; 
      ID = _n_;
      datalines; 
Morphine      N  .04  .20  .10  .08 
Morphine      N  .02  .06  .02  .02 
Morphine      N  .07 1.40  .48  .24 
Morphine      N  .17  .57  .35  .24 
Morphine      Y  .10  .09  .13  .14 
Morphine      Y  .12  .11  .10   . 
Morphine      Y  .07  .07  .06  .07 
Morphine      Y  .05  .07  .06  .07 
Trimethaphan  N  .03  .62  .31  .22 
Trimethaphan  N  .03 1.05  .73  .60 
Trimethaphan  N  .07  .83 1.07  .80 
Trimethaphan  N  .09 3.13 2.06 1.23 
Trimethaphan  Y  .10  .09  .09  .08 
Trimethaphan  Y  .08  .09  .09  .10 
Trimethaphan  Y  .13  .10  .12  .12 
Trimethaphan  Y  .06  .05  .05  .05 
   ; 
run;


PROC TRANSPOSE DATA = dogs_wide(keep = id drug depleted Histamine:) 
               OUT = dogs_long(rename = (col1 = Histamine)) NAME = _measure;
 BY id drug depleted;
RUN;



*** Create variable with measurement number;
DATA dogs_long;
SET dogs_long;
FORMAT Measurement 8.;
Measurement = INPUT(TRANWRD(_measure,"Histamine",''),$32.);
DROP _measure;
RUN;






data LONG;
 input ID TIME WEIGHT;
 CARDS;
 1	1	77
 1	2	79
 1	3	83
 2	1	62
 2	2	58
 2	3	59
 3	1	99
 3	2	97
 3	3	92
 ;
 run;




PROC TRANSPOSE DATA = long 
               OUT = wide(DROP = _name_)
               PREFIX = weight;
BY id ;
VAR weight;
ID time;
RUN;




/*-------------------------------------------------------------------------------------------
Section C.2
-------------------------------------------------------------------------------------------*/



%MAKEWIDE_DS(DATA=dogs_long,OUT=dogs_wide_2,
          ID=id, COPY=drug depleted,
          VAR=Histamine,
          TIME=Measurement);



/*-------------------------------------------------------------------------------------------
Section C.3
-------------------------------------------------------------------------------------------*/




%MAKELONG_DS(DATA=dogs_wide,OUT=dogs_long2,COPY=drug depleted,ID=id,
             ROOT=Histamine,TIME=Measurement,LIST=(0 1 3 5),MAX=4);


%MAKELONG_DS(data=wide,out=long,id=id,min=1,max=3,
             root=weight,time=time);



/*-------------------------------------------------------------------------------------------
Section C.4
-------------------------------------------------------------------------------------------*/


%TRANSP_CAT_DS (DATA = sampsio.assocs, OUT = assoc_tp, 
             ID = customer, VAR = Product);
