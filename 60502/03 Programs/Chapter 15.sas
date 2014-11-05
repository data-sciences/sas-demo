************************************************************************
***  Datenaufbereitung;
************************************************************************;



data diy_all
     diy_cross(drop = quantity);
 set buch.diy_market;
 output diy_all;
 output diy_cross;
run;


data diy_cross_standard;
 set diy_all;
run;


proc means data = diy_all noprint;
 var quantity volume;
 class date;
 types date;
 output out = diy_standard(drop = _type_ _freq_) sum = ;
;
run;




/*-------------------------------------------------------------------------------------------
Section 15.2
-------------------------------------------------------------------------------------------*/

PROC TRANSPOSE DATA = diy_standard
               OUT  = diy_intleaved
                      (rename = (Col1 = Value))
               NAME = Type;
 BY date;
RUN;


PROC TRANSPOSE DATA = diy_intleaved
               OUT  = diy_standard_back
                      (drop = _name_);
 BY date;
 ID Type;
 VAR value;
RUN;








PROC TRANSPOSE DATA = diy_cross
               OUT  = diy_standard(drop = _name_);
 BY date;
 VAR volume;
 ID Category;
RUN;


PROC TRANSPOSE DATA = diy_standard
               OUT  = diy_cross_back(rename = (Col1 = Value))
   NAME = Type;
 BY date;
RUN;






/*-------------------------------------------------------------------------------------------
Section 15.3
-------------------------------------------------------------------------------------------*/


PROC TRANSPOSE DATA = diy_cross_standard
               OUT  = diy_intlv_standard
               NAME = Type;
 BY date;
 ID category;
RUN;


PROC TRANSPOSE DATA = diy_intlv_standard
               OUT  = diy_cross_standard_back
               NAME = Category;
 BY date;
 ID Type;
;
RUN;







PROC TRANSPOSE DATA = diy_cross_standard
               OUT  = diy_intlv_cross(rename = (Col1 = Value))
               NAME = Type;
 BY date category;
RUN;


PROC TRANSPOSE DATA = diy_intlv_cross
               OUT  = diy_cross_standard_back2(drop = _name_);
 BY date category;
 VAR value;
 ID type;
RUN;








DATA diy_intlv_cross_tmp;
 SET diy_intlv_cross;
 Varname = CATX("_",Category,Type);
RUN;

PROC TRANSPOSE DATA = diy_intlv_cross_tmp
               OUT  = diy_standard_complete(drop = _name_);
 BY date;
 ID Varname;
 VAR value;
RUN;

