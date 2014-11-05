/*-------------------------------------------------------------------------------------------
Chapter 14 - Code
-------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------
CREATE DATASETS
-------------------------------------------------------------------------------------------*/

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


data dogs_long_2vars;
 set dogs_long;
 Heamoglobin = 14 + round(uniform(4345),0.1);
run;


data assocs;
input customer time product $;
count=1;
cards;
                            0         0  hering
                            0         1  corned_b
                            0         2  olives
                            0         3  ham
                            0         4  turkey
                            0         5  bourbon
                            0         6  ice_crea
                            1         0  baguette
                            1         1  soda
                            1         2  hering
                            1         3  cracker
                            1         4  heineken
                            1         5  olives
                            1         6  corned_b
                            2         0  avocado
                            2         1  cracker
                            2         2  artichok
                            2         3  heineken
                            2         4  ham
                            2         5  turkey
                            2         6  sardines
                            3         0  olives
                            3         1  bourbon
                            3         2  coke
                            3         3  turkey
                            3         4  ice_crea
                            3         5  ham
                            3         6  peppers
                            4         0  hering
                            4         1  corned_b
                            4         2  apples
                            4         3  olives
                            4         4  steak
                            4         5  avocado
                            4         6  turkey
                            5         0  sardines
                            5         1  heineken
                            5         2  chicken
                            5         3  coke
                            5         4  ice_crea
                            5         5  peppers
                            5         6  ham
                            6         0  olives
                            6         1  bourbon
                            6         2  coke
                            6         3  turkey
                            6         4  ice_crea
                            6         5  heineken
                            6         6  apples
                            7         0  corned_b
                            7         1  peppers
                            7         2  bourbon
                            7         3  cracker
                            7         4  chicken
                            7         5  ice_crea
                            7         6  baguette
                            8         0  soda
                            8         1  olives
                            8         2  bourbon
                            8         3  cracker
                            8         4  heineken
                            8         5  peppers
                            8         6  baguette
                            9         0  corned_b
                            9         1  peppers
                            9         2  bourbon
                            9         3  cracker
                            9         4  chicken
                            9         5  bordeaux
                            9         6  hering
                           10         0  baguette
                           10         1  sardines
                           10         2  apples
                           10         3  peppers
                           10         4  avocado
                           10         5  steak
                           10         6  turkey
                           11         0  baguette
                           11         1  hering
                           11         2  avocado
                           11         3  artichok
                           11         4  heineken
                           11         5  apples
                           11         6  corned_b
                           12         0  hering
                           12         1  corned_b
                           12         2  apples
                           12         3  olives
                           12         4  steak
                           12         5  sardines
                           12         6  heineken
                           13         0  baguette
                           13         1  sardines
                           13         2  apples
                           13         3  peppers
                           13         4  avocado
                           13         5  steak
                           13         6  ice_crea
                           14         0  hering
                           14         1  corned_b
                           14         2  olives
                           14         3  ham
                           14         4  turkey
                           14         5  coke
                           14         6  apples
                           15         0  olives
                           15         1  bourbon
                           15         2  coke
                           15         3  turkey
                           15         4  ice_crea
                           15         5  artichok
                           15         6  ham
                           16         0  baguette
                           16         1  hering
                           16         2  avocado
                           16         3  artichok
                           16         4  heineken
                           16         5  coke
                           16         6  turkey
                           17         0  sardines
                           17         1  heineken
                           17         2  chicken
                           17         3  coke
                           17         4  ice_crea
                           17         5  corned_b
                           17         6  apples
                           18         0  soda
                           18         1  olives
                           18         2  bourbon
                           18         3  cracker
                           18         4  heineken
                           18         5  baguette
                           18         6  peppers
                           19         0  soda
                           19         1  olives
                           19         2  bourbon
                           19         3  cracker
                           19         4  heineken
                           19         5  steak
                           19         6  hering
                           20         0  hering
                           20         1  corned_b
                           20         2  olives
                           20         3  ham
                           20         4  turkey
                           20         5  apples
                           20         6  baguette
;
run;



/*-------------------------------------------------------------------------------------------
Section 14.2
-------------------------------------------------------------------------------------------*/



PROC TRANSPOSE DATA = long 
               OUT = wide_from_long(DROP = _name_)
               PREFIX = weight;
BY id ;
VAR weight;
ID time;
RUN;





%MAKEWIDE(DATA=dogs_long,
          OUT=dogs_wide,
          ID=id,
          COPY=drug depleted,
          VAR=Histamine,
          TIME=Measurement);




%MAKEWIDE(DATA=dogs_long_2vars,OUT=out1,ID=id, COPY=drug depleted,
          VAR=Histamine, TIME=Measurement);
%MAKEWIDE(DATA=dogs_long_2vars,OUT=out2,ID=id, 
          VAR=Heamoglobin, TIME=Measurement);
DATA dogs_wide_2vars;
 MERGE out1 out2;
 BY id;
RUN;


PROC TRANSPOSE DATA = dogs_long_2vars
               OUT  = dogs_tmp;
 BY id measurement drug depleted;
RUN;


DATA dogs_tmp;
 SET dogs_tmp;
 Varname = CATX("_",_NAME_,measurement);
RUN;


PROC TRANSPOSE DATA = dogs_tmp
               OUT  = dogs_wide_2vars_twice(drop = _name_);
 BY id drug depleted;
 VAR col1;
 ID Varname;
RUN;



/*-------------------------------------------------------------------------------------------
Section 14.3
-------------------------------------------------------------------------------------------*/


PROC TRANSPOSE DATA = wide 
               OUT = long_from_wide(rename = (col1 = Weight)) 
               NAME = _Measure;
BY id ;
RUN;



DATA long_from_wide;
SET long_from_wide;
 FORMAT Time 8.;
 time = INPUT(TRANWRD(_measure,"weight",''),$8.);
DROP _measure;
RUN;





%MAKELONG(DATA=dogs_wide,
          OUT=
             dogs_long_from_wide,
          ID=id, 
          COPY=drug depleted,
          ROOT=Histamine,
          MEASUREMENT=  
              Measurement);





%MAKELONG(DATA= dogs_wide_2vars,OUT=out1,ID=id, COPY=drug depleted,
          ROOT=Histamine, MEASUREMENT=Measurement);
%MAKELONG(DATA= dogs_wide_2vars,OUT=out2,ID=id, 
          ROOT=Heamoglobin, MEASUREMENT =Measurement);
DATA dogs_long_2vars;
 MERGE out1 out2;
 BY id measurement;
RUN;


/*-------------------------------------------------------------------------------------------
Section 14.4
-------------------------------------------------------------------------------------------*/


PROC TRANSPOSE DATA = assocs(obs=21)
               OUT = assoc_tp (DROP = _name_);
 BY customer;
 ID Product;
 VAR Count;
RUN;



%TRANSP_CAT (DATA = sampsio.assocs, OUT = assoc_tp, 
             ID = customer, VAR = Product);






DATA assoc_tp ;
 SET assoc_tp ;
 %REPLACE_MV (apples artichok avocado baguette bordeaux bourbon
             chicken coke corned_b cracker ham heineken hering
             ice_crea olives peppers sardines soda steak turkey);
RUN;



/*-------------------------------------------------------------------------------------------
Section 14.5
-------------------------------------------------------------------------------------------*/

DATA class; 
 SET sashelp.class;
 ID = _N_;
RUN;


PROC TRANSPOSE DATA = class OUT = class_tp;
 BY ID name;
 VAR sex age height weight;
RUN;



DATA Key_Value;
 SET class_tp;
 RENAME _name_ = Key; 
 Value = strip(col1);
 DROP col1;
RUN;



PROC TRANSPOSE DATA = key_value OUT = one_row;
 BY id name;
 VAR value;
 ID key ;
RUN;

DATA one_row;
 SET one_row(RENAME = (Age=Age2 Weight=Weight2 Height=Height2));
 FORMAT Age 8. Weight Height 8.1;
 Age = INPUT(Age2,$8.);
 Weight = INPUT(Weight2,$8.);
 Height = INPUT(Height2,$8.);
 DROP Age2 Weight2 Height2;
RUN;
