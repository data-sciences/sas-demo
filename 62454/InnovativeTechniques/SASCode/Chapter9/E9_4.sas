* E9_4.sas
* 
* Using ANNOTATE to place a label.;


* For SAS9.3 uncomment the following ODS statement
* if you want to create the EMF file;
* ods graphics off;

filename image "&path\results\g9_4.emf";
goptions reset=all device=emf
         ftext='arial' noborder
         gsfname=image;

title1 f=arial '9.4 Annotated BMI Labels';


data bmilabel(keep=function 
                   xsys ysys x y 
                   text color style position size);
   set advrpt.demog;
   * Define annotate variable attributes;
   length color function $8;
   retain function 'label'
          xsys ysys '2'
          color 'red'
          style 'Arial'
          position '2'
          size .8;

   * Calculate the BMI. Note those outside of 
   * the range of 18 - 26;
   bmi = wt / (ht*ht) * 703; 
   if bmi lt 18 or bmi gt 26 then do;
      * Create a label;
      text = put(bmi,4.1);
      x=wt;
      y=ht;
      output bmilabel; 
   end;
   run;

symbol1 c=blue  v=dot;
symbol2 c=red;
symbol3 c=green r=2;

legend1 position=(top left inside) mode=protect
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
              legend=legend1
              anno=bmilabel; 
   run;
   quit;
