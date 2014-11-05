/*--------------------------------------------*/
/* The How-To Book for SAS/GRAPH Software     */
/* by Tom Miron                               */
/* pubcode # 55203                            */
/*--------------------------------------------*/


========================================
Chapter: 08   Program: 01   Page: 47

 title "Count of Meetings By Department";

 proc gchart data=lib1.meetings;
    hbar dept;
 run;
 quit;
========================================
Chapter: 08   Program: 02   Page: 48

 title "Count of Meetings By Length";

 proc gchart data=lib1.meetings;
    vbar hours;
 run;
 quit;
========================================
Chapter: 08   Program: 03   Page: 49

 title "Deer Population Count";

 proc gchart data=lib1.deer;
    vbar region /
       type=freq
       freq=pop
    ;
 run;
 quit;
========================================
Chapter: 08   Program: 04   Page: 50

 title "Count of Meetings";

 proc gchart data=lib1.meetings;
    vbar room /
       subgroup=dept
 ;
 run;
 quit;
========================================
Chapter: 08   Program: 05   Page: 51

 title "Count of Meetings";

 proc gchart data=lib1.meetings;
    vbar room /
       group=dept
 ;
 run;
 quit;
========================================
Chapter: 09   Program: 01   Page: 53

 title "Sum of Hours";

 proc gchart data=lib1.meetings;
    vbar dept /
       sumvar=hours
       type=sum
    ;
 run;
 quit;
========================================
Chapter: 09   Program: 02   Page: 54

 title "Sum of Hours";

 proc gchart data=lib1.meetings;
    vbar dept /
       sumvar=hours
       type=sum
       subgroup=room
    ;
 run;
 quit;
========================================
Chapter: 09   Program: 03   Page: 55

 title "Sum of Hours";

 proc gchart data=lib1.meetings;
    vbar dept /
       sumvar=hours
       type=sum
       group=room
    ;
 run;
 quit;
========================================
Chapter: 10   Program: 01   Page: 57

 title "Mean of Hours";

 proc gchart data=lib1.meetings;
    hbar dept /
       sumvar=hours
       type=mean
    ;
 run;
 quit;
========================================
Chapter: 10   Program: 02   Page: 58

 title "Mean of Hours";

 proc gchart data=lib1.meetings;
    vbar dept /
       sumvar=hours
       type=mean
       group=room
    ;
 run;
 quit;
========================================
Chapter: 11   Program: 01   Page: 61


 proc gchart data=lib1.meetings;
    vbar dept /
       type=percent
    ;
 run;
 quit;
========================================
Chapter: 11   Program: 02   Page: 62

 data chart_it;
   set lib1.meetings;
   hours10 = hours * 10;
 run;

 title "Percent of Meeting Hours";

 proc gchart data=chart_it;
    vbar dept /
       type=percent
       freq=hours10
    ;
 run;
 quit;
========================================
Chapter: 11   Program: 03   Page: 63

 title "Percent of Meetings In Each Room";

 proc gchart data=lib1.meetings;
    vbar dept /
       type=percent
       group=room
    ;
 run;
 quit;
========================================
Chapter: 11   Program: 04   Page: 64

 title "Percent of Meetings In Each Room";

 proc gchart data=lib1.meetings;
    vbar dept /
       type=percent
       group=room
       g100
    ;
 run;
 quit;
========================================
Chapter: 11   Program: 05   Page: 65

 title "Percent of Meetings";

 proc gchart data=lib1.meetings;
    vbar dept /
       type=percent
       subgroup=room
    ;
 run;
 quit;
========================================
Chapter: 12   Program: 01   Page: 67

 title height=6 pct 'First Quarter Sales';
 proc gchart data=lib1.salesq1;
    hbar month /
    midpoints='JAN' `FEB' `MAR'
    ;
 run;
 quit;
========================================
Chapter: 12   Program: 02   Page: 68

 title height=6 pct 'First Quarter Sales';
 proc gchart data=lib1.salesq1;
    hbar month /
    sumvar=amount
    midpoints='JAN' `FEB' `MAR'
    ;
 run;
 quit;
========================================
Chapter: 12   Program: 03   Page: 68

 title height=6 pct 'First Quarter Sales';
 proc gchart data=lib1.salesq1;
    hbar month /
    sumvar=amount
    sum mean
    midpoints='JAN' `FEB' `MAR'
    ;
 run;
 quit;
========================================
Chapter: 12   Program: 04   Page: 69

title height=6 pct 'First Quarter Sales';
proc gchart data=lib1.salesq1;
   hbar month /
      nostats
      sumvar=amount
      midpoints= 'JAN' 'FEB' 'MAR'
;
run;
quit;
========================================
Chapter: 12   Program: 05   Page: 70

 title height=6 pct 'First Quarter Sales';
 proc gchart data=lib1.salesq1;
    vbar month /
    mean
    sumvar=amount
    midpoints='JAN' `FEB' `MAR'
    ;
 run;
 quit;
========================================
Chapter: 12   Program: 06   Page: 71

 goptions ftext=triplex htext=2 pct;

 title height=6 pct font=swiss
       `First Quarter Sales';

 proc gchart data=lib1.salesq1;
    format amount dollar6.;
    vbar month /
    mean
    sumvar=amount
    midpoints='JAN' `FEB' `MAR'
    ;
 run;
 quit;
========================================
Chapter: 13   Program: 01   Page: 73

 title "Sum of Hours";

 proc gchart data=lib1.meetings;
    hbar dept /
       sumvar=hours
       type=sum
    ;
 run;
 quit;
========================================
Chapter: 13   Program: 02   Page: 74

 title "Sum of Hours";

 proc gchart data=lib1.meetings;
    vbar dept /
       sumvar=hours
       type=sum
       midpoints = "MARKET" "SHIP" "ACCOUNTS"
    ;
 run;
 quit;
========================================
Chapter: 13   Program: 03   Page: 75

 title "Length of Meetings";

 proc gchart data=lib1.meetings;
    vbar hours /
       midpoints = 4 to 2 by -0.5
    ;
 run;
 quit;
========================================
Chapter: 13   Program: 04   Page: 76

 title "Length of Meetings";

 axis1 order = 1 to 4 by .5;

 proc gchart data=lib1.meetings;
    vbar hours /
       maxis=axis1
    ;
 run;
 quit;
========================================
Chapter: 13   Program: 05   Page: 77

 title "Total Meeting Hours";

 proc gchart data=lib1.meetings;
    vbar dept /
       sumvar=hours
       type=sum
       ascending
    ;
 run;
 quit;
========================================
Chapter: 13   Program: 06   Page: 78

 title "Total Meeting Hours";
 axis1 order= "C301" "C339" "B100";

 proc gchart data=lib1.meetings;
    vbar dept /
       sumvar=hours
       type=sum
       group=room
       gaxis=axis1
    ;
 run;
 quit;
========================================
Chapter: 14   Program: 01   Page: 81

 title "Count of Meetings By Department";

 proc gchart data=lib1.meetings;
    hbar dept /
       nostats
    ;
 run;
 quit;
========================================
Chapter: 14   Program: 02   Page: 82

 title "Count of Meetings By Department";

 proc gchart data=lib1.meetings;
    hbar dept /
       nostats
       width=6
    ;
 run;
 quit;
========================================
Chapter: 14   Program: 03   Page: 83

 title "Count of Meetings By Department";

 proc gchart data=lib1.meetings;
    vbar dept;
 run;
 quit;
========================================
Chapter: 14   Program: 04   Page: 83

 title "Count of Meetings By Department";

 proc gchart data=lib1.meetings;
    vbar dept /
       space=8
    ;
 run;
 quit
========================================
Chapter: 14   Program: 05   Page: 84

 title "Count of Meetings By Department";

 proc gchart data=lib1.meetings;
    vbar dept /
       group=room
    ;
 run;
 quit;
========================================
Chapter: 14   Program: 06   Page: 85

 title "Count of Meetings By Department";

 proc gchart data=lib1.meetings;
    vbar dept /
       group=room
       gspace=8
    ;
 run;
 quit;
========================================
Chapter: 15   Program: 01   Page: 88

 title "Length of Meetings";

 proc gchart data=lib1.meetings;
    vbar hours;
 run;
 quit;
========================================
Chapter: 15   Program: 02   Page: 89

 title "Length of Meetings";

 proc gchart data=lib1.meetings;
    vbar hours /
       discrete
    ;
 run;
 quit
========================================
Chapter: 15   Program: 03   Page: 90

 title "Length of Meetings";

 proc gchart data=lib1.meetings;
    vbar hours /
       levels=3
    ;
 run;
 quit;
========================================
Chapter: 15   Program: 04   Page: 91

 title "Length of Meetings";

 proc gchart data=lib1.meetings;
    vbar hours /
       midpoints = 0.5  1.0  1.5
    ;
 run;
 quit;
========================================
Chapter: 16   Program: 01   Page: 96

 proc format;
    value salegrp
       low-<500 = "less than $500"
       500-1000 = "$500 to $1000"
       1000<-1200 = "$1000 to $1200"
       1200<-high = "over $1200"
    ;
 run;

 title "Sales By Amount Category";

 proc gchart data=lib1.salesq1;
    format amount salegrp.;
    vbar amount /
       discrete;
 run;
 quit;
========================================
Chapter: 16   Program: 02   Page: 97

 proc format;
    value $levels
       "B100" = "B Level"
       "C301", "C339" = "C Level"
    ;
 run;

 title "Meetings On Each Level";

 proc gchart data=lib1.meetings;
    format room $levels.;
    vbar room;
 run;
 quit;
========================================
Chapter: 17   Program: 01   Page: 100

 goptions reset=pattern;

 title "Count of Meetings";

 proc gchart data=lib1.meetings;
    vbar room /
       subgroup=dept
 ;
 run;
 quit;
========================================
Chapter: 17   Program: 02   Page: 101

 goptions reset=pattern;

 pattern1 color=black value=solid;

 title "Count of Meetings";

 proc gchart data=lib1.meetings;
    vbar room /
       subgroup=dept
    ;
 run;
 quit;
========================================
Chapter: 17   Program: 03   Page: 101

 pattern1 value=solid color=gray77;
 pattern2 value=solid color=graybb;
 pattern3 value=solid color=grayee;

 title "Count of Meetings";

 proc gchart data=lib1.meetings;
    vbar room /
       subgroup=dept
 ;
 run;
 quit;
========================================
Chapter: 17   Program: 04   Page: 102

 pattern1 value=solid color=grayee;
 pattern2 value=solid color=graybb;
 pattern3 value=solid color=gray77;

 title "Count of Meetings";

 proc gchart data=lib1.meetings;
    vbar room /
       subgroup=dept
 ;
 run;
 quit;
========================================
Chapter: 17   Program: 05   Page: 103

 pattern1 value=solid color=gray77;
 pattern2 value=solid color=graybb;
 pattern3 value=solid color=grayee;

 title "Number of Meetings";
 title2 height=2 "In Each Room";

 proc gchart data=lib1.meetings;
    vbar room /
       patternid=midpoint;
 run;
 quit;
========================================
Chapter: 17   Program: 06   Page: 104

 pattern1 value=solid color=gray77;
 pattern2 value=solid color=graybb;
 pattern3 value=solid color=grayee;

 title "Deer Count";

 proc gchart data=lib1.deer;
    by region notsorted;
    vbar type /
       sumvar=pop
       patternid=by
    ;
 run;
 quit;
========================================
Chapter: 17   Program: 07   Page: 105

 pattern1 value=solid color=gray77;
 pattern2 value=solid color=graybb;
 pattern3 value=solid color=grayee;

 title "Count of Meetings";

 proc gchart data=lib1.meetings;
    vbar room /
       group=dept
       patternid=group
 ;
 run;
 quit;
========================================
Chapter: 18   Program: 01   Page: 110

 title "Average Fuel Use";

 proc gplot data=lib1.allfuel;
   plot mpg*length;
 run;
 quit;
========================================
Chapter: 18   Program: 02   Page: 111

 symbol1 color=black value=dot height=2;

 title "Average Fuel Use";

 proc gplot data=lib1.allfuel;
   plot mpg*length;
 run;
 quit;
========================================
Chapter: 18   Program: 03   Page: 112

 symbol1 value=dot height=2 color=grayaa;

 title "Average Fuel Use";

 proc gplot data=lib1.allfuel;
   plot mpg*length;
 run;
 quit;
========================================
Chapter: 19   Program: 01   Page: 115

 symbol1
    value=none
    interpol=join
    color=black
 ;

 title "Average Fuel Use";

 proc gplot data=lib1.allfuel;
   plot mpg*length;
 run;
 quit;
========================================
Chapter: 19   Program: 02   Page: 116

 symbol1
    value=diamond
    interpol=join
    color=black
 ;

 title "Average Fuel Use";

 proc gplot data=lib1.allfuel;
   plot mpg*length;
 run;
 quit;
========================================
Chapter: 19   Program: 03   Page: 117

 symbol1
    value=diamond
    height=2
    interpol=join
    color=black
 ;

 title "Average Fuel Use";

 proc gplot data=lib1.allfuel1;
   plot mpg*length;
 run;
 quit;
========================================
Chapter: 19   Program: 04   Page: 118

 proc sort data=lib1.allfuel1 out=plotit;
    by length;
 run;

 symbol1
    value=diamond
    height=2
    interpol=join
    color=black
 ;

 title "Average Fuel Use";

 proc gplot data=plotit;
   plot mpg*length;
 run;
 quit;
========================================
Chapter: 19   Program: 05   Page: 119

 symbol1
    value=diamond
    interpol=join
    line=4
    color=black
 ;

 title "Average Fuel Use";

 proc gplot data=lib1.allfuel;
   plot mpg*length;
 run;
 quit;
========================================
Chapter: 19   Program: 06   Page: 120

 symbol1
    value=diamond
    height=2
    interpol=join
    line=1
    width=10
    color=black
 ;

 title "Average Fuel Use";

 proc gplot data=lib1.allfuel;
   plot mpg*length;
 run;
 quit;
========================================
Chapter: 20   Program: 01   Page: 123

 symbol1
    value=diamond
    height=2
    interpol=spline
    color=black
 ;

 title "Average Fuel Use";

 proc gplot data=lib1.allfuel;
   plot mpg*length;
 run;
 quit;
========================================
Chapter: 20   Program: 02   Page: 124

 symbol1
    value=diamond
    height=2
    interpol=r
    color=black
 ;

 title "Average Fuel Use";

 proc gplot data=lib1.allfuel;
   plot mpg*length;
 run;
 quit;
========================================
Chapter: 20   Program: 03   Page: 125

 symbol1
    value=triangle
    interpol=rcclm90
    co=grayaa
    color=black
 ;

 title h=2 "Average Fuel Use";
 title2 h=1.5 "90% Confidence Limit";
 title3 h=1.5 "For Mean Predicted Values";

 proc gplot data=lib1.allfuel;
   plot mpg*length;
 run;
 quit;
========================================
Chapter: 21   Program: 01   Page: 127

 symbol1
    value=none
    interpol=join
    color=black
 ;

 title "Average Fuel Use";
 title2 "MPG and Total Use";

 proc gplot data=lib1.allfuel;
   plot mpg*length;
   plot2 total*length;
 run;
 quit;
========================================
Chapter: 21   Program: 02   Page: 129

 symbol1
    interpol=join
    value=dot
    height=2
    line=1
    color=black
 ;

 symbol2
    interpol=join
    value=circle
    height=2
    line=3
    color=black
 ;

 title "Fuel Use";
 title2 "MPG and Total Use";

 proc gplot data=lib1.allfuel;
   plot mpg*length / legend overlay;
   plot2 total*length / legend overlay;
 run;
 quit;
========================================
Chapter: 21   Program: 03   Page: 130

 goptions colors=(black grayaa);

 symbol1
    interpol=join
    value=dot
    height=2
    line=1
 ;

 symbol2
   interpol=join
    value=circle
    height=2
    line=3
    color=black
 ;

 title "Fuel Use";
 title2 "MPG and Total Use";

 proc gplot data=lib1.allfuel;
   plot mpg*length / legend overlay;
   plot2 total*length/ legend overlay;
 run;
 quit;
========================================
Chapter: 22   Program: 01   Page: 134

 symbol1
    interpol=join
    value=diamond
    height=1
    line=1
    color=black
 ;

 symbol2
    interpol=join
    value=circle
    height=1
    line=3
    color=black
 ;

 symbol3
    interpol=join
    value=dot
    height=1
    line=5
    color=black
 ;

 symbol4
    interpol=join
    value=star
    height=1
    line=8
    color=black
 ;

 title "Fuel Use and Car Type";

 proc gplot data=lib1.typefuel;
   plot mpg*length=type;
 run;
 quit;
========================================
Chapter: 22   Program: 02   Page: 135

 symbol1
    interpol=join
    value=diamond
    height=1
    line=1
    color=black
 ;

 symbol2
    interpol=join
    value=circle
    height=1
    line=3
    color=black
 ;

 title "Fuel Use and Car Type";

 proc gplot data=lib1.typefuel;
   where type="LARGE" or type="COMPACT";
   plot mpg*length=type;
 run;
 quit;
========================================
Chapter: 22   Program: 03   Page: 137

 symbol1
    interpol=join
    value="S"
    height=1
    line=1
    color=black
 ;

 symbol2
    interpol=join
    value="L"
    height=1
    line=3
    color=black
 ;

 axis1 label=("MPG");

 title "Fuel Use and Car Type";

 proc gplot data=lib1.fuel2;
   plot subcom*length
        large*length /
      overlay
      vaxis=axis1
      legend
   ;
 run;
 quit;
========================================
Chapter: 23   Program: 01   Page: 139

 symbol1
   interpol=join
   value=none
   color=black
 ;

 pattern1 value=solid color=graybb;

 title "Fuel Use and Car Type";

 proc gplot data=lib1.typefuel;
    where type="LARGE";
    plot mpg*length=type /
       areas=1
    ;

 run;
 quit;
========================================
Chapter: 23   Program: 02   Page: 141

 symbol1 interpol=join value=none color=black;
 symbol2 interpol=join value=none color=black;;

 pattern1 value=solid color=graycc;
 pattern2 value=solid color=gray88;

 legend1 shape=bar(3,1);

 title "Fuel Use and Car Type";

 proc gplot data=lib1.typefuel
   where type="LARGE" or type="SUBCOMPACT";
   plot mpg*length=type /
      areas=2
      legend=legend1
   ;

 run;
 quit;
========================================
Chapter: 24   Program: 01   Page: 145

 data plotit;
    keep year cost source;
    set lib1.utilyear;

    cost=gas;
    source="1_Gas";
    output;

    cost=gas+elec;
    source="2_Elec";
    output;

    cost=gas+elec+tele;
    source="3_Tele";
    output;
 run;


 symbol1 interpol=join color=black;
 symbol2 interpol=join color=black;
 symbol3 interpol=join color=black;

 pattern1 color=gray77 value=solid;
 pattern2 color=grayaa value=solid;
 pattern3 color=graydd value=solid;

 axis1 label=("Total");

 legend1
    shape=bar(3,1)
    value=("Gas" "Electric" "Communications")
 ;

 title "Utility Cost Components";

 proc gplot data=plotit;
    plot cost*year=source /
       areas=3
       legend=legend1
       vaxis=axis1
    ;
 run;
 quit;
========================================
Chapter: 25   Program: 01   Page: 149

 symbol1
    value=none
    interpol=join
 ;

 title h=2 "Average Fuel Use";

 proc gplot data=lib1.allfuel;
   plot mpg*length /
      autohref
      autovref
      lvref=3
      lhref=23
   ;
 run;
 quit;
========================================
Chapter: 25   Program: 02   Page: 150

 symbol1
    value=none
    interpol=join
 ;

 title h=2 "Average Fuel Use";

 proc gplot data=lib1.allfuel;
   plot mpg*length /
     cframe=grayee
   ;
 run;
 quit;
========================================
Chapter: 25   Program: 03   Page: 151

 symbol1
    value=none
    interpol=join
 ;

 title h=2 "Average Fuel Use";

 proc gplot data=lib1.allfuel;
   plot mpg*length /
      vzero
       ;
 run;
 quit;
========================================
Chapter: 26   Program: 01   Page: 160

 proc gproject data=maps.counties out=wicounty;
    where state=55;
    id state county;
 run;

 title "Lake Count";

 proc gmap data=lib1.lakes map=wicounty;
    id state county;
    choro lakes;
 run;
 quit;
========================================
Chapter: 27   Program: 01   Page: 164

 pattern1 value=solid color=gray11;
 pattern2 value=solid color=gray77;
 pattern3 value=solid color=gray99;
 pattern4 value=solid color=grayaa;
 pattern5 value=solid color=graycc;
 pattern6 value=solid color=grayd0;
 pattern7 value=solid color=graye0;

 title "Lake Count";

 proc gmap
    data=lib1.lakes
    map=maps.wicounty
 ;
    id state county;
    choro lakes /
      coutline=black
    ;
 run;
 quit;
========================================
Chapter: 27   Program: 02   Page: 165

 pattern1 value=solid color=gray77;
 pattern2 value=solid color=graybb;
 pattern3 value=solid color=grayee;

 title "Lake Count"

 proc gmap
    data=lib1.lakes
    map=maps.wicounty
 ;
    id state county;
    choro lakes /
       coutline = black
       midpoints = 30 60 90;
 run;
 quit;
========================================
Chapter: 27   Program: 03   Page: 166

 pattern1 value=solid color=gray77;
 pattern2 value=solid color=gray99;
 pattern3 value=solid color=graybb;
 pattern4 value=solid color=graydd;

 title "Lake Count";

 proc gmap
    data=lib1.lakes
    map=maps.wicounty
 ;
    id state county;
    choro lakes /
       coutline = black
       levels = 4
    ;
 run;
 quit;
========================================
Chapter: 27   Program: 04   Page: 167

 pattern1 value=solid color=gray77;
 pattern2 value=solid color=graybb;
 pattern3 value=solid color=grayee;

 title "Sales Territories";

 proc gmap data=lib1.salesrep map=maps.us all;
    id state;
    choro name /
       coutline=black
 ;
 run;
 quit;
========================================
Chapter: 27   Program: 05   Page: 168

 pattern1 value=empty;

 title;

 proc gmap all
    data=maps.wicounty(obs=1)
    map=maps.wicounty
 ;
    id state county;
    choro state /
       coutline=black
       levels=1
       nolegend
    ;
 run;
 quit;
========================================
Chapter: 28   Program: 01   Page: 171

 proc format;
    value lakecat
        0 -< 15    = "less than 15"
       15 -< 40    = "less than 40"
       40 -  high  = "40 or more"
    ;
 run;

 pattern1 value=solid color=gray77;
 pattern2 value=solid color=graybb;
 pattern3 value=solid color=grayee;

 title "Lake Count";

 proc gmap
    data=lib1.lakes
    map=maps.wicounty
 ;
    format lakes lakecat.;
    id state county;
    choro lakes /
       discrete
       coutline = black
    ;
 run;
 quit;
========================================
Chapter: 29   Program: 01   Page: 173

 pattern1 value=solid color=gray77;
 pattern2 value=solid color=graybb;
 pattern3 value=solid color=grayee;

 title "US Jobsites";

 proc gmap data=lib1.jobsites  map=maps.us;
    id state;
    choro sites /
       levels = 3
       coutline = black
    ;
 run;
========================================
Chapter: 29   Program: 02   Page: 174

 pattern1 value=solid color=gray77;
 pattern2 value=solid color=graybb;
 pattern3 value=solid color=grayee;

 title "US Jobsites";

 proc gmap data=lib1.jobsites  map=maps.us all;
    id state;
    choro sites /
       levels = 3
       coutline = black
    ;
 run;
========================================
Chapter: 30   Program: 01   Page: 178

 pattern1 color=gray77 value=m3x45;
 pattern2 color=gray77 value=m3n0;
 pattern3 color=gray77 value=m3x90;

 title "Lake Count";

 proc gmap
    data=lib1.lakes
    map=maps.wicounty
 ;
    id state county;
    choro lakes /
       coutline = black
       levels = 3
    ;
 run;
 quit;
========================================
Chapter: 30   Program: 02   Page: 179

 pattern1 color=gray99 value=solid;
 pattern2 color=graycc value=solid;
 pattern3 color=black  value=empty;

 title "Lake Count";

 proc gmap
    data=lib1.lakes
    map=maps.wicounty
 ;
    id state county;
    choro lakes /
       coutline = black
       levels = 3
    ;
 run;
 quit;
========================================
Chapter: 30   Program: 03   Page: 180

 pattern1 color=gray77 value=solid;
 pattern2 color=grayaa value=solid;
 pattern3 color=grayee value=solid;

 title "Lake Count";

 proc gmap
    data=lib1.lakes
    map=maps.wicounty
 ;
    id state county;
    choro lakes /
       coutline = black
       levels = 4
    ;
 run;
 quit;
========================================
Chapter: 31   Program: 01   Page: 185

 title "Meetings Per Room";

 proc gchart data=lib1.meetings;
    pie room;
 run;
 quit;
========================================
Chapter: 31   Program: 02   Page: 186

 title "Length of Meetings";

 proc gchart data=lib1.meetings;
    pie hours;
 run;
 quit;
========================================
Chapter: 31   Program: 03   Page: 187

 title "Length of Meetings";

 proc gchart data=lib1.meetings;
    pie hours /
       levels=3
    ;
 run;
 quit;
========================================
Chapter: 31   Program: 04   Page: 188

 title "Length of Meetings";

 proc gchart data=lib1.meetings;
    pie hours /
      midpoints= 1.0 1.5 3.0
    ;
 run;
 quit;
========================================
Chapter: 31   Program: 05   Page: 189

 title "Length of Meetings";

 proc gchart data=lib1.meetings;
    pie hours /
       discrete
    ;
 run;
 quit;
========================================
Chapter: 31   Program: 06   Page: 190

 title "Total Meeting Hours";

 proc gchart data=lib1.meetings;
    pie dept /
       sumvar=hours
    ;
 run;
 quit;
========================================
Chapter: 32   Program: 01   Page: 194

 title "Meetings Per Room";

 proc gchart data=lib1.meetings;
    pie room /
       percent=outside
    ;
 run;
 quit;
========================================
Chapter: 32   Program: 02   Page: 195

 title "Meetings Per Room";

 proc gchart data=lib1.meetings;
    pie room /
       percent=outside
       slice=none
       value=none
    ;
 run;
 quit;
========================================
Chapter: 32   Program: 03   Page: 196

 title "Meetings Per Room";

 proc gchart data=lib1.meetings;
    pie room /
       percent=arrow
       slice=inside
       value=none
    ;
 run;
 quit;
========================================
Chapter: 33   Program: 01   Page: 199

 title "Meeting Room Use";

 proc gchart data=lib1.meetings;
    pie room /
       group=dept
       across=3
    ;
 run;
 quit;
========================================
Chapter: 33   Program: 02   Page: 200

 title "Meeting Room Use";

 proc gchart data=lib1.meetings;
    pie room /
       group=dept
       across=2
       down=2
    ;
 run;
 quit;
========================================
Chapter: 34   Program: 01   Page: 203

 title "Meeting Room Use";

 proc gchart data=lib1.meetings;
    pie room /
       explode="B100"
    ;
 run;
 quit;
========================================
Chapter: 34   Program: 02   Page: 204

 title "Meeting Room Use";

 proc gchart data=lib1.meetings;
    pie room /
      coutline=black
    ;
 run;
 quit;
========================================
Chapter: 34   Program: 03   Page: 205

 title "Meeting Room Use";

 proc gchart data=lib1.meetings;
    pie room /
      invisible="B100"
    ;
 run;
 quit;
========================================
Chapter: 34   Program: 04   Page: 206

 title "Meeting Room Use";

 proc gchart data=lib1.meetings;
    pie room /
      matchcolor
    ;
 run;
 quit;
========================================
Chapter: 34   Program: 05   Page: 207

 title "Meeting Room Use";

 proc gchart data=lib1.meetings;
    pie room /
      noheading
    ;
 run;
 quit;
========================================
Chapter: 34   Program: 06   Page: 208

 title "Meeting Room Use";

 proc gchart data=lib1.meetings;
    pie room /
      angle=90
    ;
 run;
 quit;
========================================
Chapter: 34   Program: 07   Page: 209

 title "Meeting Room Use";

 proc gchart data=lib1.meetings;
    pie room /
       midpoints = "C301" "B100" "C339"
    ;
 run;
 qui
========================================
Chapter: 35   Program: 01   Page: 212

 pattern1 color=gray77 value=p3x45;
 pattern2 color=gray77 value=p3n0;
 pattern3 color=gray77 value=p3x90;

 title "Meeting Room Use";

 proc gchart data=lib1.meetings;
    pie room;
 run;
 quit;
========================================
Chapter: 35   Program: 02   Page: 213

 pattern1 color=gray77 value=solid;
 pattern2 color=graybb value=solid;
 pattern3 color=black value=solid;

 title "Meeting Room Use";

 proc gchart data=lib1.meetings;
    pie room;
 run;
 quit;
========================================
Chapter: 35   Program: 03   Page: 214

 pattern1 color=gray77 value=solid;
 pattern2 color=graybb value=solid;
 pattern3 color=black value=p3x135;

 title "Meeting Room Use";

 proc gchart data=lib1.meetings;
    pie room;
 run;
 quit;
========================================
Chapter: 36   Program: 01   Page: 219

 title
    color=gray88
    font=zapfbu
    height=3
    "Department Meetings"
 ;

 proc gchart data=lib1.meetings;
    vbar dept;
 run;
 quit;
========================================
Chapter: 36   Program: 02   Page: 221

 title
    color=black
    font=zapfbu
    height=6 pct
    "Department Meetings"
 ;

 title2
    color=gray88
    height= 3 pct
    "Meeting Count"
 ;

 footnote
    color=black
    box=2
    height=2 pct
    "For Latest Fiscal Year"
 ;

 proc gchart data=lib1.meetings;
    vbar dept;
 run;
 quit;
========================================
Chapter: 36   Program: 03   Page: 222

 title
    color=gray88
    font=zapfbu
    height=3
    "Department Meetings"
 ;

 footnote
    angle=-90
    "For Internal Use Only"
 ;


 proc gchart data=lib1.meetings;
    vbar dept;
 run;
 quit;
========================================
Chapter: 36   Program: 04   Page: 223

 title
    color=gray88
    font=zapfbu
    height=3
    "Department Meetings"
 ;

 footnote
    angle=-90
    rotate=90
    "For Internal Use Only"
 ;

 proc gchart data=lib1.meetings;
    vbar dept;
 run;
 quit;
========================================
Chapter: 36   Program: 05   Page: 224

 title height=2 color=gray88 "Chart of "
       height=4 color=black  "All"
       height=2 color=gray88 " Meetings"
 ;

 proc gchart data=lib1.meetings;
    vbar dept;
 run;
 quit;
========================================
Chapter: 37   Program: 01   Page: 227

 symbol1
    value=none
    interpol=join
 ;

 title "Average Fuel Use";

 proc gplot data=lib1.allfuel;
   format total 5.2;
   plot total*length;
 run;
 quit;
========================================
Chapter: 37   Program: 02   Page: 229

 title "State Revenues";

 proc gmap data=lib1.jobrev  map=maps.us all;
    format revenues dollar12.2;
    id state;
    choro revenues /
       levels = 5
       coutline = black
    ;
 run;
 quit;
========================================
Chapter: 37   Program: 03   Page: 230

 title "State Revenues";

 proc gmap data=lib1.jobrev  map=maps.us  all;
    format revenues dollar12.;
    id state;
    choro revenues /
       levels = 5
       coutline = black
    ;
 run;
 quit;
========================================
Chapter: 38   Program: 01   Page: 233

 symbol1 interpol=join;

 axis1 order=('01jan95'd to '01jan96'd by month);

 title "Monthly Sales";

 proc gplot data=lib1.monthly;
    format date date7.;
    plot sales*date /
       haxis=axis1
    ;
 run;
 quit;
========================================
Chapter: 38   Program: 02   Page: 234

 symbol1 interpol=join;

 axis1 order=('01jan95'd to '01jan96'd by month);

 title "Monthly Sales";

 proc gplot data=lib1.monthly;
    format date worddate3.;
    plot sales*date /
       haxis=axis1;
 run;
 quit;
========================================
Chapter: 38   Program: 03   Page: 236

 title "Monthly Sales";

 proc gchart data=lib1.monthly;
    format date qtr1.;
    vbar date /
       sumvar=sales
       discrete
    ;
 run;
 quit;
========================================
Chapter: 39   Program: 01   Page: 240

 symbol1 value=none interpol=join color=black;

 axis1
    label=(height=2.5 font=zapfbu)
 ;

 axis2
    label=(height=3 color=grayaa "Trip Length")
 ;

 title "Average Fuel Use";

 proc gplot data=lib1.allfuel;
    plot mpg*length /
       vaxis=axis1
       haxis=axis2
    ;
 run;
 quit;
========================================
Chapter: 39   Program: 02   Page: 241

 symbol1
    value=none
    interpol=join
 ;

 axis1
    label=(height=1.5)
    order=(10 to 20 by 5)
 ;

 axis2
    label=(height=3 color=black "Trip Length")
    order=(0 to 50 by 5)
 ;

 title "Average Fuel Use";

 proc gplot data=lib1.allfuel;
    plot mpg*length /
       vaxis=axis1
       haxis=axis2
    ;
 run;
 quit;
========================================
Chapter: 39   Program: 03   Page: 242

 symbol1
    value=none
    interpol=join
 ;

 axis1
    label=(height=1.5)
    order=(10 to 20 by 5)
    value=(height=3)
 ;

 axis2
    label=(height=3 color=black "Trip Length")
    order=(0 to 50 by 5)
    minor=none
 ;

 title "Average Fuel Use";

 proc gplot data=lib1.allfuel;
    plot mpg*length /
       vaxis=axis1
       haxis=axis2
    ;
 run;
 quit;
========================================
Chapter: 39   Program: 04   Page: 243

 axis1
    label=("Number of Meetings")
 ;

 axis2
    label=(height=1.5 "Department")
    value=("Accounting" "Marketing" "Shipping")
 ;

 title "Count of Meetings By Department";

 proc gchart data=lib1.meetings;
    hbar dept /
       raxis=axis1
       maxis=axis2
    ;
 run;
 quit;
========================================
Chapter: 40   Program: 01   Page: 248

 symbol1 interpol=join value=diamond
    height=1 line=1 color=black;

 symbol2 interpol=join value=circle
    height=1 line=3 color=black;

 symbol3 interpol=join value=dot
    height=1 line=5 color=black;

 symbol4 interpol=join value=star
    height=1 line=8 color=black;

 title "Fuel Use and Car Type";

 legend1
    across=2
    value=(height=2 color=gray99)
 ;

 proc gplot data=lib1.typefuel;
    plot mpg*length=type /
       legend=legend1
    ;
 run;
 quit;
========================================
Chapter: 40   Program: 02   Page: 249

 symbol1 interpol=join value=diamond
    height=1 line=1 color=black;

 symbol2 interpol=join value=circle
    height=1 line=3 color=black;

 symbol3 interpol=join value=dot
    height=1 line=5 color=black;

 symbol4 interpol=join value=star
    height=1 line=8 color=black;

 title "Fuel Use and Car Type";

 legend1
    label=(height=2 font=zapfbu "Car Type")
    across=2
    value=(height=1.5 color=gray99)
 ;

 proc gplot data=lib1.typefuel;
    plot mpg*length=type /
       legend=legend1
    ;
 run;
 quit;
========================================
Chapter: 40   Program: 03   Page: 250

 symbol1 interpol=join value=diamond
    height=1 line=1 color=black;

 symbol2 interpol=join value=circle
    height=1 line=3 color=black;

 legend1
   shape=symbol(10,4)
 ;
 title "Fuel Use and Car Type";

 proc gplot data=lib1.typefuel;
    where (type="LARGE" or type="COMPACT");

    plot mpg*length=type /
       legend=legend1
    ;
 run;
 quit;
========================================
Chapter: 40   Program: 04   Page: 251

 legend1
    shape=bar(3,2)
    label=(height=1 "Room Number")
    position=(top center outside)
 ;

 title "Sum of Hours";

 proc gchart data=lib1.meetings;
    vbar dept /
       sumvar=hours
       type=sum
       subgroup=room
       legend=legend1
    ;
 run;
 quit;
========================================
Chapter: 40   Program: 05   Page: 252

 title "Lake Count";

 legend1
    shape=bar(2,2)
    value=("Median=30" "Median=60" "Median=90")
    frame
 ;


 proc gmap
    data=lib1.lakes
    map=maps.wicounty
 ;
    id state county;
    choro lakes /
       coutline = black
       midpoints = 30 60 90
       legend=legend1
    ;
 run;
 quit;
========================================
Chapter: 41   Program: 01   Page: 256

 proc sort data=lib1.deer out=plotit;
    by region;
 run;

 title "Deer Type Count";

 proc gchart data=plotit;
    by region;
    vbar type /
       sumvar=pop
    ;
 run;
 quit;
========================================
Chapter: 41   Program: 02   Page: 257

 proc sort data=lib1.deer out=plotit;
    by region;
 run;

 goptions hby=0;

 title "Deer Type Count";

 proc gchart data=plotit;
    by region;
    vbar type /
       sumvar=pop
    ;
 run;
 quit;
========================================
Chapter: 42   Program: 01   Page: 261

 goptions device=win;

 title "Meetings Per Room";

 proc gchart data=lib1.meetings  gout=lib1.mygrafs;
    pie room /
       name='meets1'
       description='Meetings Per Room'
    ;
 run;
 quit;

 goptions nodisplay;

 title "Meetings Per Room";

 proc gchart data=lib1.meetings gout=lib1.mygrafs;
    pie room /
       explode="B100"
       name="meets2"
       description="Meetings, B100 Explode"
    ;
 run;
 quit;

/* LIB1.ALLFUEL  */
data lib1.allfuel;
   input length total mpg;
cards;
1      0.08035     13.7487
2      0.15603     14.2366
5      0.34026     15.9502
8      0.54998     15.9710
10     0.64835     17.0327
15     0.99652     16.8029
25     1.59152     17.2900
run;



/* LIB1.DEER  */
data lib1.deer;
   input region $ type $ pop;
cards;
North   buck    57
North   doe     89
North   fawn    21
Central buck    107
Central doe     231
Central fawn    54
South   buck    72
South   doe     101
South   fawn    15
run;


/* LIB1.FUEL2 */ 
data lib1.fuel2;
   input subcom large length;
cards;
20.6352   9.2401     1
16.3122   7.4282     2
22.6963  10.8119     5
19.1297   9.2644     8
23.3921   9.1327    10
22.5562   9.5771    15
20.1433  10.1883    25
run;


/* LIB1.JOBREV */
data lib1.jobrev;
   input state revenues;
cards;
55      456403.66
56      30605.71
36      678889.72
6       385398.77
38      31030.22
16      81181.69
12      121911.87
29      183142.11
15      10643.04
2       20874.58
1       101325.51
13      141819.66
48      61358.05
4       10198.75
35      10900.19
41      20981.68
53      10731.77
30 10176.05
run;


/* LIB1.JOBSITES */
data lib1.jobsites;
   input statezip $ sites state;
cards;
WI          45        55
WY           3        56
NY          67        36
CA          38         6
ND           2        38
ID           8        16
FL          12        12
MO          18        29
HI           1        15
AK           2         2
AL          10         1
GA          14        13
TX           6        48
AZ           1         4
NM           1        35
OR           2        41
WA           1        53
MT           1        30
run;



/* LIB1.LAKES */
data lib1.lakes;
   input state county lakes;
cards;
55       1      51
55       3      17
55       5      68
55       6       6
55       9      15
55      11      46
55      13      33
55      15      33
55      17      28
55      19      68
55      21       1
55      23       9
55      25      80
55      27      84
55      29      71
55      31      96
55      33      48
55      35       7
55      37      30
55      39      90
55      41      72
55      43      48
55      45      91
55      47      38
55      49      42
55      51      83
55      53      72
55      55      81
55      57       8
55      59      58
55      61      37
55      63      17
55      65      2
55      67      38
55      69      52
55      71      34
55      73      76
55      75      7
55      77      74
55      78      63
55      79      77
55      81      14
55      83      58
55      85      2
55      87      27
55      89      21
55      91      94
55      93      0
55      95      77
55      97      40
55      99      30
55      101     60
55      103     48
55      105     61
55      107     4
55      109     3
55      111     10
55      113     85
55      115     86
55      117     52
55      119     65
55      121     44
55      123     42
55      125     80
55      127     12
55      129     25
55      131     11
55      133     57
55      135     26
55      137     20
55      139     27
55      141     56
run;


/* LIB1.MEETINGS */
data lib1.meetings;
   input date date7. dept $ room $ hours;
cards;
10JAN95 ACCOUNTS C339    1.00
24JAN95 ACCOUNTS B100    0.50
30JAN95 SHIP     C339    2.00
24FEB95 MARKET   C301    3.50
28FEB95 SHIP     C339    4.00
01MAR95 MARKET   C301    4.00
03MAR95 ACCOUNTS B100    3.50
08MAR95 ACCOUNTS B100    0.50
21MAR95 ACCOUNTS B100    0.25
27MAR95 SHIP     C301    1.50
29MAR95 ACCOUNTS C301    0.50
12APR95 SHIP     C339    0.50
25APR95 MARKET   C301    1.50
02MAY95 MARKET   B100    0.50
12MAY95 SHIP     C301    2.50
25MAY95 MARKET   C301    3.50
01JUN95 SHIP     C301    2.00
07JUN95 SHIP     C339    3.00
14JUN95 SHIP     C301    2.00
12JUL95 MARKET   C339    0.50
03AUG95 ACCOUNTS B100    3.00
14AUG95 SHIP     C301    2.50
28AUG95 SHIP     C339    1.50
15SEP95 MARKET   C339    3.00
28SEP95 ACCOUNTS C301    0.50
11OCT95 MARKET   C301    3.00
01NOV95 SHIP     C301    1.50
15NOV95 MARKET   C339    1.00
21NOV95 SHIP     B100    2.00
22NOV95 SHIP     C339    3.50
05DEC95 MARKET   C339    2.50
21DEC95 MARKET   C301    2.50
run;

/* LIB1.MONTHLY */
data lib1.monthly;
   input date mmddyy8. sales;
cards;
01/01/95    145830
01/01/95    168930
02/01/95    150922
02/01/95    170082
03/01/95    179500
03/01/95    150040
04/01/95    180090
04/01/95    175035
05/01/95    140010
05/01/95    168500
06/01/95    159950
06/01/95    190010
run;            

/* LIB1.REVENUES */
data lib1.revenues;
   input date mmddyy8. region $ revenue;
cards;
01/01/95     West       10391
02/10/95     East       19045
03/05/95     West       12750
04/16/95     East       25905
05/02/95     West       15755
06/03/95     East       27900
07/07/95     West       16995
08/09/95     East       21000
09/02/95     West       12225
10/16/95     East       23565
11/02/95     West       17890
12/06/95     East       30560
run;


/* LIBl.SALESQ1 */
data lib1.salesq1;
   input month $ amount;
cards;
JAN        823
JAN       1093
JAN        971
JAN       1121
FEB        623
FEB       1200
MAR        789
MAR        450
MAR       1301
MAR        808
MAR        950
run;


/* LIB1.SALESREP */
data lib1.salesrep;
   input name $ state;
cards;
Collins      1
Collins      5
Collins     13
Collins     28
Collins     37
Collins     45
Collins     29
Plotnik      2
Plotnik     53
Plotnik     41
Plotnik     16
Arno        56
Arno         8
Arno        30
Arno        38
Arno        46
run;

/* LIB1.TYPEFUEL */
data lib1.typefuel;
   input type $ length total mpg;
cards;
SUBCOMPACT  1       0.04846   20.635
SUBCOMPACT  2       0.12261   16.3122
SUBCOMPACT  5       0 22030   22.6963
SUBCOMPACT  8       0 41820   19 1297
SUBCOMPACT  10      0.42750   23 3921
SUBCOMPACT  15      0.66500   22.5562
SUBCOMPACT  25      1.24111   20.1433
COMPACT      1      0.05733   17.4432
COMPACT      2      0.13546   14 7641
COMPACT      5      0.26073   19 1771
COMPACT      8      0.43838   18.2490
COMPACT     10      0.51789	19.3090
COMPACT     15      0.73605	20.3790
COMPACT     25      1.34418	18.5986
MIDSIZE      1      0.07625	13.1145
MIDSIZE      2      0.16520	12.1067
MIDSIZE      5      0.32908	15.1936
MIDSIZE      8      0.55777	14.3429
MIDSIZE     10      0.60147	16.6259
MIDSIZE     15      1.09434	13.7068
MIDSIZE     25      1.53006	16.3392
LARGE        1      0.10822	9.2401
LARGE        2      0.26925	7.4282
LARGE        5      0.46245	10.8119
LARGE        8      0.86352	9.2644
LARGE       10      1.09496	9.1327
LARGE       15      1.56623	9.5771
LARGE       25      2.45379	10.1883
run;


/* LIB1.UTILITY */
data lib1.utility;
   input quarter $ ebgas ebelec wbgas wbelec;
cards;
QTR1    1433    780      2052    1148   
QTR2    1555    821      2239    1246   
QTR3    1051    682      1789    1017   
QTR4    850     652      1154    908    
run;

/* LIB1.UTILYEAR */
data lib1.utilyear;
   input year gas elec tele;
cards;
1990   5600    1250    2450   
1991   6250    950     3000   
1992   6100    1025    3400   
1993   6450    1175    3800   
1994   6575    1350    4200   
1995   6500    1425    4350   
1996   6450    1425    4775   
1997   6525    1500    5500   
1998   6600    1700    6550   
1999   6750    1725    7500   
run;



