* S7_9_4.sas
*
* Calculating a weighted mean;


data temp;
   input product $ quantity price;
   label product  = 'Product Code'
         quantity = 'Number Sold'
         price    = 'Unit price';
   datalines;
   a 1 1.5
   a 10 1.0
   a 100 .5
   ;
run;

* 7.8.4a Use the FREQ statement to weight the observations;
title1 'Extending Compute Blocks';
title2 'Calculating a Weighted Mean';
title3 'Using the FREQ statement';
proc report data=temp nowd;
   columns product quantity price price=revenue;
   define product / display;
   define quantity / analysis sum;
   define price / analysis mean format=dollar5.2 width=7;
   define revenue / sum 'Total Revenue' format=dollar6.2 width=7;
   freq quantity;
   rbreak after / summarize dol;
   run; 

* 7.8.4b Calculated the weighted mean using a compute block;
title3 'Computed Values';
proc report data=temp nowd;
   columns product quantity price revenue;
   define product / display;
   define quantity / analysis sum;
   define price / analysis mean format=dollar5.2 width=7;
   define revenue / computed 'Total Revenue' format=dollar6.2 width=7;

   compute revenue;
      revenue = price.mean * quantity.sum;
   endcomp;
   rbreak after / summarize dol;
run; 

* 7.8.4c Use the _BREAK_ and a compute AFTER;
title3 'Computed Values Utilizing the _BREAK_';
proc report data=temp nowd;
   columns product quantity price revenue;
   define product / display;
   define quantity / analysis sum;
   define price / analysis mean format=dollar5.2 width=7;
   define revenue / computed 'Total Revenue' format=dollar6.2 width=7;

   compute revenue;
      revenue = price.mean * quantity.sum;
      if _break_ = ' ' then _sum_revenue + revenue;
   endcomp;

   compute after;
      price.mean = _sum_revenue / quantity.sum;
      revenue = _sum_revenue;
   endcomp;

   rbreak after / summarize dol;
run; 
*/ *;

