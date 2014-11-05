* E10_2_4.sas
* 
* Using PROC GKPI;

%macro slider(gname,bmi);
proc gkpi mode=raised;
hbullet actual=&bmi bounds=(0 18.5 25 30 50)/
         noavalue nobvalue
         target=. colors=(blue,green,yellow,red) 
         name="c:\temp\&gname";
run;
quit;
%mend slider;

goptions reset=all noborder 
         device=javaimg 
         xpixels=130 ypixels=50 
         ftext='Arial';

* Using PROC GKPI;
title;
ods html file="c:\temp\slider.gif";
data bmi(keep=subject ht wt gname bmi);
   set advrpt.demog(obs=8);
   length gname $4;
   bmi = wt / (ht*ht) * 703; 
   gname=cats('G',subject);
   txt='%slider('||gname||','||put(bmi,4.1)||')'; put txt;
   *call execute('%slider('||gname||','||put(bmi,4.1)||')');
   run;
ods html close;

ods pdf file="&path\results\E10_2_4.pdf" style=default;
title font=arial '10.2.4 Using GKPI';
proc report data=bmi nowd;
   column subject gname ht wt bmi slider;
   define subject/ display 'Subject Number';
   define gname / noprint;
   define ht / analysis 'Height';
   define wt / analysis 'Weight';
   define bmi/ analysis f=4.1 'Body Mass Index';
   define slider / computed ' ';

   compute slider/char length=62;
      slider=' ';
      imgfile = "style={postimage='c:\temp\"||trim(left(gname))||".png'}";
      call define ('slider','style',imgfile);
   endcomp;
   run;
ods pdf close;
