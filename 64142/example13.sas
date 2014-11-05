%let name=example13;
filename odsout '.';

/*
SAS/Graph imitation of ...
http://www.census.gov/prod/2003pubs/c2kbr-34.pdf
*/


data foreign;
input age_range $ 1-5 male female;
length  myhtml $400;
myhtml=
 'title='||quote( 'Age: '||trim(left(age_range))||'0d'x||
   'Male:     '||trim(left(put(male,comma10.1)))||'%'||'0d'x||
   'Female: '||trim(left(put(female,comma10.1)))||'%' 
   )
  ||' '||
 'href="http://www.census.gov/prod/2003pubs/c2kbr-34.pdf"';
male=-1*male;
data_order=_n_;
datalines;
 85+  0.4 0.9     
80-84 0.5 0.7
75-79 0.9 1.3
70-74 1.1 1.7
65-69 1.4 1.9
60-64 1.8 2.3
55-59 2.2 2.6
50-54 3.2 3.4
45-49 4.0 4.1
40-44 5.1 5.0
35-39 5.8 5.6
30-34 6.0 5.5
25-29 5.8 5.2
20-24 4.8 3.9
15-19 3.0 2.5
10-14 1.9 1.8
 5-9  1.2 1.2
 0-4  0.6 0.6
;
run;

/*
I want the bars in the bar chart to be in a certain order,
so I put a numeric variable in the dataset with the values
in the order I want (I just happen to call that variable
'order' - you could call it anything).  I then create a
dynamic user-defined format on-the-fly that maps the
numeric values to the "station" name.
*/
data control; set foreign (rename = ( data_order=start age_range=label));
fmtname = 'my_fmt';
type = 'N';
end = START;
run;
proc format lib=work cntlin=control;
run;


data foreign_left1;
length text $20;
function='label'; 
xsys='3'; ysys='3'; position='5'; when='a'; 
x=50; y=92; text='Male'; output;
run;

data foreign_left2; set foreign;
function='label'; 
xsys='2'; ysys='2'; position='4'; when='a';
x=male-.1; midpoint=data_order;
text=trim(left(put(abs(male),comma5.1)));
run;



data foreign_right1;
length text $20;
xsys='3'; ysys='3'; 
function='label';
when='a';
position='5'; 
x=8;  y=95.5; text='Foreign Born'; style='"albany amt/bold"'; output;
x=8;  y=92; text='Age'; style=''; output;
x=65; y=92; text='Female'; output;
run;

data foreign_right2; set foreign;
function='label'; position='6'; when='a';
xsys='2'; ysys='2'; 
x=female+.2; midpoint=data_order;
text=trim(left(put(female,comma5.1)));
run;



goptions nodisplay;

goptions device=png;
goptions cback=white;

goptions ftitle="albany amt/bold" ftext="albany amt" gunit=pct htitle=4 htext=2.6 ctext=gray33;

axis1 label=none value=none style=0;
axis2 label=none minor=none major=none value=(color=white) style=0 order=(-7 to 0 by 1);

goptions xpixels=165 ypixels=435;
pattern v=s c=cx6782b1;
title1 h=7pct " ";
proc gchart data=foreign anno=foreign_left1; 
 hbar data_order / discrete
 type=sum sumvar=male
 nostats noframe coutline=black space=0
 maxis=axis1 raxis=axis2
 anno=foreign_left2
 html=myhtml
 name="f_male";  
run;



axis3 label=none value=(justify=center);
axis4 label=none minor=none major=none value=(color=white) style=0 order=(0 to 7 by 1);

goptions xpixels=186 ypixels=435;
pattern v=s c=cx6782b1;
title1 h=7pct " ";
proc gchart data=foreign anno=foreign_right1; 
 format data_order my_fmt.;
 hbar data_order / discrete
 type=sum sumvar=female
 nostats noframe coutline=black space=0
 maxis=axis3 raxis=axis4
 anno=foreign_right2
 html=myhtml
 name="f_female";  
run;



data native;
input age_range $ 1-5 male female;
length  myhtml $400;
myhtml=
 'title='||quote( 'Age: '||trim(left(age_range))||'0d'x||
   'Male:     '||trim(left(put(male,comma10.1)))||'%'||'0d'x||
   'Female: '||trim(left(put(female,comma10.1)))||'%' 
   )
  ||' '||
 'href="http://www.census.gov/prod/2003pubs/c2kbr-34.pdf"';
male=-1*male;
data_order=_n_;
datalines;
 85+  0.4 1.1     
80-84 0.7 1.2
75-79 1.1 1.6
70-74 1.4 1.8
65-69 1.6 1.8
60-64 1.8 2.0
55-59 2.3 2.4
50-54 3.0 3.1
45-49 3.5 3.6
40-44 3.9 4.0
35-39 3.9 3.9
30-34 3.3 3.4
25-29 3.2 3.2
20-24 3.3 3.2
15-19 3.7 3.5
10-14 4.0 3.8
 5-9  4.1 3.9
 0-4  3.8 3.6
;
run;

/*
I want the bars in the bar chart to be in a certain order,
so I put a numeric variable in the dataset with the values
in the order I want (I just happen to call that variable
'order' - you could call it anything).  I then create a
dynamic user-defined format on-the-fly that maps the
numeric values to the "station" name.
*/
data control; set native (rename = ( data_order=start age_range=label));
fmtname = 'my_fmt';
type = 'N';
end = START;
run;
proc format lib=work cntlin=control;
run;

data native_left1;
length text $20;
xsys='3'; ysys='3'; 
function='label';
when='a';
position='5'; 
x=50; y=92; text='Male'; output;
run;

data native_left2; set native;
function='label'; position='4'; when='a';
xsys='2'; ysys='2'; 
x=male-.1; midpoint=data_order;
text=trim(left(put(abs(male),comma5.1)));
run;



data native_right1;
length text $20;
xsys='3'; ysys='3'; 
function='label';
when='a';
position='5'; 
x=8;  y=95.5; text='Native'; style='"albany amt/bold"'; output;
x=8;  y=92; text='Age'; style=''; output;
x=65; y=92; text='Female'; output;
run;

data native_right2; set native;
function='label'; position='6'; when='a';
xsys='2'; ysys='2'; 
x=female+.2; midpoint=data_order;
text=trim(left(put(female,comma5.1)));
run;



goptions nodisplay;

goptions device=png;
goptions cback=white;

goptions ftitle="albany amt/bold" ftext="albany amt" gunit=pct htitle=4 htext=2.6 ctext=gray33;

axis1 label=none value=none style=0;
axis2 label=none minor=none major=none value=(color=white) style=0 order=(-7 to 0 by 1);

goptions xpixels=165 ypixels=435;
pattern v=s c=cxc0c5dd;
title1 h=7pct " ";
proc gchart data=native anno=native_left1; 
 hbar data_order / discrete
 type=sum sumvar=male
 nostats noframe coutline=black space=0
 maxis=axis1 raxis=axis2
 anno=native_left2
 html=myhtml
 name="n_male" ;  
run;



axis3 label=none value=(justify=center);
axis4 label=none minor=none major=none value=(color=white) style=0 order=(0 to 7 by 1);

goptions xpixels=186 ypixels=435;
pattern v=s c=cxc0c5dd;
title1 h=7pct " ";
proc gchart data=native anno=native_right1; 
 format data_order my_fmt.;
 hbar data_order / discrete
 type=sum sumvar=female
 nostats noframe coutline=black space=0
 maxis=axis3 raxis=axis4
 anno=native_right2
 html=myhtml
 name="n_female" ;  
run;





goptions xpixels=700 ypixels=500;
title1 j=l c=cx005096 ls=.8 " Age and Sex by Nativity: 2000";
title2 j=l h=2.4 ls=.4 " (Data based on sample.  For information on confidentiality protection, sampling error, nonsampling error.";
title3 j=l h=2.4 ls=.4 " and definitions, see " 
 link="http://www.census.gov/prod/cen2000/doc/sf3.pdf" f="albany amt/italic" "www.census.gov/prod/cen2000/doc/sf3.pdf" f="albany amt" link='' " )";
footnote1 j=l h=2.2 " Each bar represents the percent of the population (foreign-born or native) who were in the specified age-sex group.";
footnote2 j=l h=2.2 " Source: U.S. Census Bureau, Census 2000, special tabulations.";
footnote3 h=1pct " ";
proc gslide name="titles";
run;




goptions display;

goptions cback=white;
goptions xpixels=700 ypixels=500;

ODS LISTING CLOSE;
ODS HTML path=odsout body="&name..htm" (title="Hawaii Population (SAS/Graph gchart)") style=minimal;
goptions border;

proc greplay tc=tempcat nofs igout=work.gseg;
  tdef census des='Panels'

   1/llx = 0   lly =  3
     ulx = 0   uly = 90
     urx =24   ury = 90
     lrx =24   lry =  3
   2/llx =24   lly =  3
     ulx =24   uly = 90
     urx =50   ury = 90
     lrx =50   lry =  3

   3/llx =50   lly =  3
     ulx =50   uly = 90
     urx =74   ury = 90
     lrx =74   lry =  3
   4/llx =74   lly =  3
     ulx =74   uly = 90
     urx =100  ury = 90
     lrx =100  lry =  3

   5/llx = 0   lly =  0
     ulx = 0   uly = 100
     urx =100  ury = 100
     lrx =100  lry =  0

;
template = census;
treplay
 1:f_male 2:f_female  3:n_male 4:n_female
 5:titles
 des='' name="&name";
run;

quit;
ODS HTML CLOSE;
ODS LISTING;
