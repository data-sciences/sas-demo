/* ===================================================== */
PROC OLAP
   CUBE                   = "/Projects/Cubes/Candy_Sales"
   DATA                   = candy.CANDY_SALES_SUMMARY

  ADD_DATA UPDATE_INPLACE UPDATE_DISPLAY_NAMES
;
/* ===================================================== */
