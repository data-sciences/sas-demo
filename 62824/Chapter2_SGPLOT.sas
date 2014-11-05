/* Replace this data path with the correct location on your own PC */
libname candy "C:\Program Files\SASHome\x86\SASEnterpriseGuide\5.1\Sample\Data";
ods graphics / width=700 height=450;
title "Customer report: sales and volume";

proc sgplot
  data=candy.candy_sales_summary
  noautolegend;
  vbar name /
    response=sale_amount
    transparency=.8
    fillattrs=graphdata1;
  vline name /
    response=units
    lineattrs=graphdata2
    y2axis;
  format
    sale_amount dollar12.
    units comma12.;
  xaxis display=(nolabel);
  yaxis label="Sale amount";
  y2axis label="Units sold";
run;
