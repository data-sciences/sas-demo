/*-------------------------------------------------------------------*/
/*        SAS Guide to Report Writing: Examples, Second Edition      */
/*                        by Michele M. Burlew                       */
/*       Copyright(c) 2005 by SAS Institute Inc., Cary, NC, USA      */
/*                   SAS Publications order # 59602                  */
/*                        ISBN 1-59047-575-5                         */
/*-------------------------------------------------------------------*/
/*                                                                   */
/* This material is provided "as is" by SAS Institute Inc.  There    */
/* are no warranties, expressed or implied, as to merchantability or */
/* fitness for a particular purpose regarding the materials or code  */
/* contained herein. The Institute is not responsible for errors     */
/* in this material as it now exists or will exist, nor does the     */
/* Institute provide technical support for it.                       */
/*                                                                   */
/*-------------------------------------------------------------------*/
/* Questions or problem reports concerning this material may be      */
/* addressed to the author:                                          */
/*                                                                   */
/* SAS Institute Inc.                                                */
/* SAS Press                                                         */
/* Attn: Michele M. Burlew                                           */
/* SAS Campus Drive                                                  */
/* Cary, NC   27513                                                  */
/*                                                                   */
/*                                                                   */
/* If you prefer, you can send email to:  saspress@sas.com           */
/* Use this for subject field:                                       */
/*                                                                   */
/*     Comments for Michele M. Burlew                                */
/*                                                                   */
/*-------------------------------------------------------------------*/
/* Date Last Updated:   July 15, 2005                                */
/*-------------------------------------------------------------------*/
/*                                                                   */
/* Note:                                                             */
/*                                                                   */
/* The data sets for this book are also included in this file;       */
/* however, they are included after the example code.                */                                                                                                                                      */
/*-------------------------------------------------------------------*/
 


/***************************************************************/
/* Example 2.1                                                 */
/***************************************************************/
proc sort data=housing;
   by descending price;
run;

proc format;
  value $zonefmt '1'='North Ridge'
                 '2'='Inside Beltline'
                 '3'='Southside'
                 '4'='East Lake'
                 '5'='Westend'
                 '6'='Mountain Brook'
                 '7'='Ensley'
                 '8'='Roebuck';
run;

proc print data=housing
           n='Total Available Properties within Price Range: '
           noobs split='/'
           uniform;

  title 'Selected Listing of Local Residential Properties';
  title2 'Price Range $200,000 to $350,000';

  where price between 200000 and 350000;
  var zone type address price bedr bath sqfeet age;

  format sqfeet comma5. price dollar9. zone $zonefmt.;
  label zone='Residential/Zone'
        type='House/Style'
        address='Address'
        price='Listing/Price'
        bedr='Bedrooms'
        bath='Bathrooms'
        sqfeet='Square/Feet'
        age='Age';
run;


/***************************************************************/
/* Example 2.2                                                 */
/***************************************************************/
proc report data=housing nowindows
                         headline
                         split='/'
                         spacing=1;

  title 'Listing of Local Residential Properties';
  title2 'Price Range $200,000 to $350,000';
  title3 'Listed by Zone';

  footnote "Listing Produced on %sysfunc(today(),worddate12.)";

  where price between 200000 and 350000;

  column zone price type address bedr bath sqfeet age;

  define  zone    / order format=$zonefmt15. width=15
                    'Residential/Zone';
  define  price   / order descending format=dollar10. width=10
                    'Listing/Price';
  define  type    / display format=$9.'House/Style';
  define  address / format=$25. width=25 'Address';
  define  bedr    / format=2. width=8 'Bedrooms';
  define  bath    / format=3.1 width=9 'Bathrooms';
  define  sqfeet  / format=comma6. width=6  'Square/Feet';
  define  age     / format=3. 'Age';

  break after zone / skip;
run;

/***************************************************************/
/* Example 2.2 Related Technique                               */
/***************************************************************/
proc sort data=housing out=ordered;
  by zone type;
run;

proc print data=ordered uniform
                        split='/';
  title 'Listing of Local Residential Properties';
  title2 'Price Range $200,000 to $350,000';
  title3 'Listed by Zone';

  footnote "Listing Produced on %sysfunc(today(),worddate12.)";

  where price between 200000 and 350000;

  by zone;
  id zone;
  var type address bedr bath sqfeet age price;

  format sqfeet comma6. price dollar10. zone $zonefmt15.;

  label zone='Zone/---------------'
        type='House/Style/--------'
        address='Address/-------------------------'
        bedr='Bedrooms/--------'
        bath='Bathrooms/---------'
        sqfeet='Square/Feet/------'
        age='Age/---'
        price='Listing/Price/----------';
run;


/***************************************************************/
/* Example 2.3                                                 */
/***************************************************************/
options nobyline nocenter missing='0';
proc format;
  value size 1='Very small -- a window or hanging feeder only'
             2='Small (< 1,000 sq ft/100 sq m)'
             3='Medium (1,001-4,000 sq ft/101-375 sq m)'
             4='Large (> 4,000 sq ft/375 sq m)';
  value desc 1='no vegetation (pavement only)'
             2='garden or courtyard'
             3='mix of natural and landscaped vegetation'
             4='landscaped yard (with lawn and plantings)'
             5='natural vegetation (woods, fields)'
             6='desert: natural or landscaped'
             7='other type';
  value pop  1='1 to 5,000'
             2='5,001 to 25,000'
             3='25,001 to 100,000'
             4='More than 100,000';
  value dens 1='Rural'
             2='Rural/suburban mix'
             3='Suburban'
             4='Urban';
  value $species 'amecro'='American crow' 'amegfi'='American goldfinch'
                 'amerob'='American robin' 'amtspa'='American tree sparrow'
                 'bkcchi'='Black-capped chickadee' 'blujay'='Blue jay'
                 'borchi'='Boreal chickadee' 'brncre'='Brown creeper'
                 'chispa'='Chipping sparrow' 'comgra'='Common grackle'
                 'comred'='Common redpoll' 'coohaw'='Cooper''s hawk'
                 'daejun'='Dark-eyed junco' 'dowwoo'='Downy woodpecker'
                 'eursta'='European starling' 'foxspa'='Fox sparrow'
                 'haiwoo'='Hairy woodpecker' 'houfin'='House finch'
                 'houspa'='House sparrow' 'logshr'='Loggerhead shrike'
                 'mallar'='Mallard' 'moudov'='Mourning dove'
                 'norcar'='Northern cardinal' 'norfli'='Norther flicker'
                 'norshr'='Northern shrike' 'pilwoo'='Pileated woodpecker'
                 'pinsis'='Pine siskin' 'purfin'='Purple finch'
                 'rebnut'='Red-breasted nuthatch' 'rebwoo'='Reb-bellied woodpecker'
                 'rewbla'='Red-winged blackbird' 'rocdov'='Rock dove'
                 'shshaw'='Sharp-shinned hawk' 'sonspa'='Song sparrow'
                 'tuftit'='Tufted titmouse' 'whbnut'='White-breasted nuthatch'
                 'whtspa'='White-throated sparrow';
  value everseen 0=' '
                 1='****';

run;
proc sort data=feederbirds;
  by id;
run;
proc print data=feederbirds label;
  by id notsorted countsitesize notsorted countsitedesc
        notsorted density notsorted pop;
  id species;
  title "Project Feederwatch Counts for Ten Observation Periods in Minnesota during 2002-2003";
  title2 "Counts for Site #byval(id)";
  title3 "Site Description: #byval(countsitesize) in #byval(countsitedesc)";
  title4 "Community: #byval(density) with a population of #byval(pop)";
  footnote1 "Key to Ten Observation Periods:";
  footnote2 ' 1: 09nov2002-22nov2002  '
            '2: 23nov2002-06dec2002  '
            '3: 07dec2002-20dec2002 '
            '4: 21dec2002-03jan2003';
  footnote3 ' 5: 04jan2003-17jan2003  '
            '6: 18jan2003-31jan2003  '
            '7: 01feb2003-14feb2003 '
            '8: 15feb2003-28feb2003';
  footnote4 ' 9: 01mar2003-14mar2003 '
            '10: 15mar2003-28mar2003';
  var everseen p1-p10;
  format countsitesize size. countsitedesc desc. density dens. pop pop.
         species $species. everseen everseen.;
  label species='Species'
        p1='P1'
        p2='P2'
        p3='P3'
        p4='P4'
        p5='P5'
        p6='P6'
        p7='P7'
        p8='P8'
        p9='P9'
       p10='P10'
       everseen='Ever Seen';
run;
options byline center missing='.';


/***************************************************************/
/* Example 2.4                                                 */
/***************************************************************/
proc format;
  value $type    'res'='Residential'
                 'com'='Commercial';
  value $service 'gen'='General Service'
                 'wtr'='Water Heating'
                 'op' ='Off Peak'
                 'spc'='Space Heating'
                 'fld'='Flood Lights'
                 'area'='Area Lights'
                 'oth'='Other Service';
run;

title 'Regional Energy';
title2 'Quarterly Use by Residential and Commercial Customers';
proc report data=poweruse nowindows;
  column type service
         ('-First Quarter-' jan feb mar)
         ('-Second Quarter-' apr may jun);

  define type / order format=$type. width=11 ' ';
  define service / order format=$service. width=15 'Service';
  define jan / analysis sum 'January' width=8 format=comma6.;
  define feb / analysis sum 'February' width=8 format=comma6.;
  define mar / analysis sum 'March' width=8 format=comma6.;
  define apr / analysis sum 'April' width=8 format=comma6.;
  define may / analysis sum 'May' width=8 format=comma6.;
  define jun / analysis sum 'June' width=8 format=comma6.;

  break after type / summarize dol dul skip;
  rbreak after / summarize dol dul skip;
run;


/***************************************************************/
/* Example 2.4 Related Technique                               */
/***************************************************************/
proc format;
  value $type    'res'='Residential'
                 'com'='Commercial';
  value $service 'gen'='General Service'
                 'wtr'='Water Heating'
                 'op' ='Off Peak'
                 'spc'='Space Heating'
                 'fld'='Flood Lights'
                 'area'='Area Lights'
                 'oth'='Other Service';
run;

proc sort data=poweruse out=sorted;
  by type service;
run;

title 'Regional Energy';
title2 'Quarterly Use by Residential and Commercial Customers';
proc print data=sorted label;
  id type;
  by type;
  var service jan feb mar apr may jun;
  sum jan feb mar apr may jun;
  label type='00'x
        service='Service'
        jan='January'
        feb='February'
        mar='March'
        apr='April'
        may='May'
        jun='June';
  format type $type. service $service.
         jan--jun comma6.;
run;


/***************************************************************/
/* Example 2.5                                                 */
/***************************************************************/
proc format;
  value $type    'res'='Residential'
                 'com'='Commercial';
  value $service 'gen'='General Service'
                 'wtr'='Water Heating'
                 'op' ='Off Peak'
                 'spc'='Space Heating'
                 'fld'='Flood Lights'
                 'area'='Area Lights'
                 'oth'='Other Service';
run;

proc report data=poweruse nowindows split='/';
  title 'Regional Energy';
  title2 'Quarterly Use by Residential and Commercial Customers';
  column type service
         ('-First Quarter-' jan feb mar quarter1)
         ('-Second Quarter-' apr may jun quarter2)
         total;

  define type    / order format=$type. width=11 ' ';
  define service / order format=$service. width=15
                  'Service';

  define jan     / analysis sum 'January' width=8
                   format=comma8.;
  define feb     / analysis sum 'February' width=8
                   format=comma8.;
  define mar     / analysis sum 'March' width=8
                   format=comma8.;
  define apr     / analysis sum 'April' width=8
                   format=comma8.;
  define may     / analysis sum 'May' width=8
                  format=comma8.;
  define jun     / analysis sum 'June' width=8
                  format=comma8.;

  define quarter1 / computed 'Quarter/Total' width=8
                    format=comma8.;
  define quarter2 / computed 'Quarter/Total' width=8
                    format=comma8.;
  define total    / computed 'Total' width=8
                    format=comma8.;

  compute quarter1;
    quarter1=sum(jan.sum,feb.sum,mar.sum);
  endcomp;

  compute quarter2;
    quarter2=sum(apr.sum,may.sum,jun.sum);
  endcomp;

  compute total;
    total=sum(quarter1,quarter2);
  endcomp;


  break after type / summarize dol dul skip;
  rbreak after / summarize dol dul skip;
run;


/***************************************************************/
/* Example 2.5 Table 2.5 Program                               */
/***************************************************************/
proc format;
  value $type    'res'='Residential'
                 'com'='Commercial';
  value $service 'gen'='General Service'
                 'wtr'='Water Heating'
                 'op' ='Off Peak'
                 'spc'='Space Heating'
                 'fld'='Flood Lights'
                 'area'='Area Lights'
                 'oth'='Other Service';
run;

proc report data=poweruse nowindows split='/';
  title 'Regional Energy';
  title2 'Quarterly Use by Residential and Commercial Customers';
  column type service
         ('-First Quarter-' jan feb mar quarter1);

  define type    / order format=$type. width=11 ' ';
  define service / order format=$service. width=15
                  'Service';
  define jan     / analysis sum 'January' width=8
                   format=comma8.;
  define feb     / analysis sum 'February' width=8
                   format=comma8.;
  define mar     / analysis sum 'March' width=8
                   format=comma8.;
  define quarter1 / computed 'Quarter/Total' width=8
                    format=comma8.;
  compute quarter1;
    quarter1=sum(jan.sum,feb.sum,mar.sum);
  endcomp;

  compute after type;
    line '****** Total for the quarter is ' quarter1 comma8.;
    line ' ';
  endcomp;
run;




/***************************************************************/
/* Example 2.6                                                 */
/***************************************************************/
proc format;
  value $type    'res'='Residential'
                 'com'='Commercial';
  value $service 'gen'='General Service'
                 'wtr'='Water Heating'
                 'op' ='Off Peak'
                 'spc'='Space Heating'
                 'fld'='Flood Lights'
                 'area'='Area Lights'
                 'oth'='Other Service';
run;
title 'Regional Energy';
title2 'Quarterly Use by Residential and Commercial Customers';
proc report data=poweruse nowindows;
  column type service
         jan feb mar apr may jun
         quarter1 quarter2 total;

  define type    / order format=$type. width=11 ' ';
  define service / order format=$service. width=15
                  'Service';

  define jan     / analysis sum noprint;
  define feb     / analysis sum noprint;
  define mar     / analysis sum noprint;
  define apr     / analysis sum noprint;
  define may     / analysis sum noprint;
  define jun     / analysis sum noprint;

  define quarter1 / computed 'First/Quarter/Total' width=8
                    format=comma8.;
  define quarter2 / computed 'Second/Quarter/Total' width=8
                    format=comma8.;
  define total    / computed 'Total' width=8
                    format=comma8.;

  compute quarter1;
    quarter1=sum(jan.sum,feb.sum,mar.sum);
  endcomp;

  compute quarter2;
    quarter2=sum(apr.sum,may.sum,jun.sum);
  endcomp;

  compute total;
    total=sum(quarter1,quarter2);
  endcomp;


  break after type / summarize dol dul skip;
  rbreak after / summarize dol dul skip;
run;


/***************************************************************/
/* Example 2.7                                                 */
/***************************************************************/

proc format;
  value ratio low-<-.1='Improved'
              -.1-.1='Minimal Change'
              >.1-high='Worsened';
  value $gender 'M'='Males'
                'F'='Females';
  value $results 'Pre'='Pre$Program$Results'
                 'Post'='Post$Program$Results';
run;
proc report data=lipids nowindows split='$' ;
  title 'Exercise Program Results';

  column gender studyid testperiod,(chol hdl) ratiopre ratiopost results;

  define gender / group descending 'Gender' format=$gender.;
  define studyid / group 'Study ID' width=5;
  define testperiod / across descending ' ' center format=$results.;
  define chol / display 'Chol' width=5;
  define hdl / display 'HDL' width=5;
  define ratiopre /computed format=5.1 'Chol/HDL Pre' center;
  define ratiopost /computed format=5.1 'Chol/HDL Post' center;
  define results / computed format=ratio. 'Chol/HDL Change' left width=14;

  break after gender / skip;

  compute ratiopre;
    ratiopre=_c3_/_c4_;
  endcomp;
  compute ratiopost;
    ratiopost=_c5_/_c6_;
  endcomp;
  compute results;
    results=(ratiopost-ratiopre)/ratiopre;
  endcomp;
run;



/***************************************************************/
/* Example 2.8                                                 */
/***************************************************************/
proc format;
  value $yn 'Y'='Yes'
            'N'='No';
  value $area 'L'='Lakeside'
              'T'='Town Center'
              'N'='Northwest'
              'P'='Prairie';
  value yrslived 1='< 2'
                 2='2-10'
                 3='More than 10';
run;
proc report data=townsurvey nowindows
                            headline;

  title 'Town Survey';
  title2 'Comments Received';

  where comments ne ' ';

  column area yrslived surveyid kids seniors comments;

  define area     / order format=$area. width=12 'Residential/Area';
  define yrslived / order format=yrslived. width=12 order=internal
                    'Years/Lived in/Town' left;
  define surveyid / order noprint;
  define kids     / format=$yn. 'Children/Under 18?' width=8 center;
  define seniors  / format=$yn. 'Adults/Over 65?' width=8 center;
  define comments / width=35 flow 'Comments';

  break after surveyid / skip;
  break after area / skip;
run;


/***************************************************************/
/* Example 2.9                                                 */
/***************************************************************/
proc sort data=marathon;
  by gender;
run;

proc format;
  value $div    'M'="Men's Division"
                'F'="Women's Division";
  value quarter   3='Top'
                  2='High Mid'
                  1='Low Mid'
                  0='Bottom';
run;

proc rank data=marathon out=ordered ties=low;
  by gender;
  var time;
  ranks order;
run;

proc rank data=marathon out=grouped groups=4 descending ties=high;
  by gender;
  var time;
  ranks quartile;
run;

data combine;
  merge ordered grouped;
run;

options nobyline pageno=1 ps=45 ls=90;

proc report data=combine nowindows box;
  title1 'Official Results of Boston Marathon 1980-2004';
  title2 'With Winning Times Ranked from Fastest(1) to Slowest(N)';
  title4 '#byval(gender)';

  by gender;
  column year winner country time order quartile;

  define year / order format=4. 'Year';
  define winner / width=22 'Winner';
  define country / width=13 'Country';
  define time    / width=7 'Time' format=time7.;
  define order   / width=5 'Order';
  define quartile / width=8 'Quartile' format=quarter.;

  format gender $div.;
run;
options byline;


/***************************************************************/
/* Example 3.1                                                 */
/***************************************************************/
proc format;
  value $statfmt 'PRIM/RES' ='Resolved on Initial Call'
                 'AUTOMATED'='Automated Troubleshooting'
                 'TOTAL'    ='Total for Day'
                 other      ='Tracked to Specialist';
  value hourfmt  9='9:00'
                10='10:00'
                11='11:00'
                12='12:00'
                13='1:00'
                14='2:00'
                15='3:00'
                16='4:00';
run;
proc report data=phondata nowindows;
  title1 'Calls Received by Technical Support on January 31, 2005';

  column hour status N hourpct primtime;
  define hour     / group format=hourfmt. center order=internal
                    'Hour';
  define status   / group format=$statfmt. width=25
                    'Status of Problems';
  define n        / format=3. width=8 center 'Number/of Calls';
  define hourpct  / computed format=percent. width=7 center
                    'Percent/within/Hour';
  define primtime / analysis mean format=time8. width=9 center
                    'Average/Length of/Calls';

  compute before hour;
    totaln=n;
  endcomp;

  compute hourpct;
    hourpct=n/totaln;
  endcomp;

  break after hour / summarize ol skip;

  rbreak after / summarize dol;

  compute after;
    status='TOTAL';
    hourpct=1;
  endcomp;
run;


/***************************************************************/
/* Example 3.1 Related Technique                               */
/***************************************************************/
proc format;
  value $statfmt 'AUTOMATED'='  Automated Troubleshooting'
                 'PRIM/RES' =' Resolved on Initial Call'
                 other      ='Tracked to Specialist';
  value hourfmt  9='9:00'
                10='10:00'
                11='11:00'
                12='12:00'
                13='1:00'
                14='2:00'
                15='3:00'
                16='4:00';
run;
proc tabulate data=phondata;
  class hour status;
  var primtime;
  table hour='Hour'*(status='Status' all='Total for Hour') all='Total for Day',
         primtime=' '*
         (n='Number of Calls'*f=6.
          pctn<status all>='Percent within Hour'*f=7.
          mean='Average Length of Calls'*f=time8.) / rts=55;
  format status $statfmt. hour hourfmt.;
run;


/***************************************************************/
/* Example 3.2                                                 */
/***************************************************************/
proc format;
  value $type 'Sandwich'='Sandwich'
              ' '=' '
              other='Specialty';
run;
proc means data=bread n mean min max
           maxdec=2
           fw=7
           nonobs;
  title 'Nutritional Information about Breads Available in the Region';
  title2 'Values Per Bread Slice, Calories in kcal, Fiber in Grams';

  class source brand flour type;
  types () type flour source source*type source*brand;
  var calories dietary_fiber;
  output out=breadstats
         idgroup(min(calories) out[3]
             (brand flour type calories)=wherecal flourcal typecal mincal)
         idgroup(max(dietary_fiber) out[3]
             (brand flour type dietary_fiber)=wherefiber flourfiber typefiber maxfiber);
  label calories=' '
        dietary_fiber=' ';
  format type $type.;
run;

/***************************************************************/
/* Example 3.2 Related Technique                               */
/***************************************************************/
proc format;
  value $flavor 'Regular'='Regular'
                ' '=' '
                other='Specialty';
  value _type_ 1='1: Type'
               2='2: Flour'
               8='8: Source'
               9='9: Source*Flavor'
              12='12: Source*Brand';
run;
proc tabulate data=bread;
  title 'Nutritional Information about Breads Available in the Region';
  title2 'Values Per Bread Slice, Calories in kcal, Fiber in Grams';

  class source brand type flour;
  var calories dietary_fiber;

  table all='Overall'
        flavor type source
        source*flavor source*brand,
        (calories dietary_fiber)*(n*f=3. (mean min max)*f=7.2) / rts=30;

  format type $type.;
run;

/***************************************************************/
/* Example 3.2 A Closer Look                                   */
/***************************************************************/
proc format;
  value _type_ 0='0: Overall'
               1='1: Type'
               2='2: Flour'
               8='8: Source'
               9='9: Source*Type'
              12='12: Source*Brand';
run;
proc print data=breadstats;
  title 'Nutritional Information about Breads Available in the Region';
  title2 'Values Per Bread Slice, Calories in kcal, Fiber in Grams';
  title3 'Breads with Fewest Calories and Most Dietary Fiber';
  by _type_;
  format _type_ _type_. ;
run;


/***************************************************************/
/* Example 3.2 A Closer Look                                   */
/***************************************************************/
data complex;
  attrib source length=$7  label='Source'
         flour  length=$15 label='Type of Bread' ;
  source='Grocery';
  flour='Whole Wheat';
  output;
  source='Bakery';
  output;
  source='Other';
  output;
  source='Grocery';
  flour='Multigrain';
  output;
  source='Bakery';
  output;
  flour='Multigrain';
  output;
  source='Grocery';
  flour='Multigrain';
  output;
  source='Bakery';
  output;
  source='Other';
  output;
run;
proc format;
  value $texture
          'Multigrain','Oatmeal','Whole Wheat'='Whole Grain'
          'White','Bleached White'='Refined'
          'Garbanzo','Soy'='Beans';
run;
proc means data=bread;
  class source brand flour type;
  var calories dietary_fiber;
run;
proc means data=bread printalltypes;
  class source brand flour type;
  var calories dietary_fiber;
run;
proc means data=bread;
  class source brand flour type;
  types () source source*brand flour type source*type;
  var calories dietary_fiber;
run;
proc means data=bread;
  class source brand flour type;
  ways 2 4;
  var calories dietary_fiber;
run;
proc means data=bread classdata=complex ;
  class source flour;
  var calories dietary_fiber;
run;
proc means data=bread classdata=complex completetypes;
  class source flour;
  var calories dietary_fiber;
run;
proc means data=bread classdata=complex exclusive;
  class source flour;
  var calories dietary_fiber;
run;
proc means data=bread completetypes;
  class flour / preloadfmt;
  var calories dietary_fiber;
  format flour $texture.;
run;
proc means data=bread;
  class flour / preloadfmt exclusive;
  var calories dietary_fiber;
  format flour $texture.;
run;



/***************************************************************/
/* Example 3.3                                                 */
/***************************************************************/
options ls=90;
proc format;
  value $gender 'M'='Males'
                'F'='Females';
run;

proc tabulate data=lipids;
  title 'Exercise Program Results';
  class gender testperiod / descending;
  var chol hdl tri;
  table (gender='Gender' all='Both Genders')*testperiod='Testing Period',
         all='Lipid Profile'*
         (chol='Cholesterol' hdl='HDL' tri='Triglycerides')*
         (n*f=3. (mean std='Std Dev' p25 p50 p75)*f=5.1) /
         condense rts=20 nocontinued;
  format gender $gender.;
run;


/***************************************************************/
/* Example 3.3 Related Technique                               */
/***************************************************************/
proc format;
  value $gender 'M'='Males'
                'F'='Females';
run;

proc report data=lipids nowindows box;
  title 'Exercise Program Results';
  column gender testperiod
         chol,(n mean std p25 p50 p75)
         hdl,(n mean std p25 p50 p75)
         tri,(n mean std p25 p50 p75);

  define gender / group format=$gender. left id descending 'Gender';
  define testperiod / group left id descending 'Testing Period' width=7;
  define chol / '-Cholesterol-';
  define hdl / '-HDL-';
  define tri / '-Triglycerides-';

  define n / format=4. 'N';
  define mean / format=5.1 'Mean';
  define std / format=5.1 'Std Dev';
  define p25 / format=5.1 'P25';
  define p50 / format=5.1 'P50';
  define p75 / format=5.1 'P75';
run;



/***************************************************************/
/* Example 3.4                                                 */
/***************************************************************/
proc format;
   value gendfmt 1='Female'
                 2='Male';
   value occupfmt 1='Technical'
                  2='Manager/Supervisor'
                  3='Clerical'
                  4='Administrative';
run;
proc tabulate data=jobclass format=8.1;
   title 'Gender Distribution within Job Classes';
   title2 'for Four Regions';

   class gender occupat;

   table (occupat='Job Class' all='All Jobs')*
           (n='Number of employees'*f=9.
            rowpctn='Percent of row total'
            colpctn='Percent of column total'
            reppctn='Percent of total'),
          gender='Gender' all='All Employees' / rts=50;

   format gender gendfmt. occupat occupfmt.;

run;

/***************************************************************/
/* Example 3.4 Related Technique                               */
/***************************************************************/
proc format;
  value gendfmt 1='Female'
                2='Male';
  value occupfmt 1='Technical'
                 2='Manager/Supervisor'
                 3='Clerical'
                 4='Administrative';
run;
proc freq data=jobclass;
  title 'Gender Distribution within Job Classes';
  title2 'for Four Regions';

  table occupat*gender;

  label occupat='Job class';
  format gender gendfmt. occupat occupfmt.;
run;


/***************************************************************/
/* Example 3.5                                                 */
/***************************************************************/
proc format;
   value gendfmt 1='Female'
                 2='Male';
   value occupfmt 1='Technical'
                  2='Manager/Supervisor'
                  3='Clerical'
                  4='Administrative';
   value regfmt 1='North'
                2='South'
                3='East'
                4='West';
run;
proc tabulate data=jobclass format=5. noseps;
  title 'Regional Gender Distribution';
  title2 'among Job Classes';

  class gender region occupat;

  table occupat=' ' all='All Employees',
        (region='Region' all='All Regions Combined')*gender=' '*
        (n='Count' pctn<gender>='%'*f=7.1) / rts=20
                                             condense
                                             nocontinued
                                             misstext='0'
                                             box='Job Class';
  format gender gendfmt. occupat occupfmt. region regfmt.;
run;

/***************************************************************/
/* Example 3.6                                                 */
/***************************************************************/
proc format;
   value gendfmt 1='Female'
                 2='Male';
   value occupfmt 1='Technical'
                  2='Manager/Supervisor'
                  3='Clerical'
                  4='Administrative';
   value regfmt 1='North'
                2='South'
                3='East'
                4='West';
run;
proc tabulate data=jobclass format=5.;
  title 'Summarization of Jobs by Region';
  title2 'for Each Gender and for All Employees';

  class gender region occupat;
  table gender='Gender: ' all='All Employees',
        occupat=' ' all='All Jobs',
        (region='Region' all='All Regions')
         *(n='Count' pctn<gender all>='% of Category'*f=8.1) /
        rts=20
        misstext='0'
        box=_page_;
   format gender gendfmt. occupat occupfmt. region regfmt.;
run;



/***************************************************************/
/* Example 3.6 Related Technique                               */
/***************************************************************/
proc format;
  value gendfmt 1='Female'
                2='Male';
  value occupfmt 1='Technical'
                 2='Manager/Supervisor'
                 3='Clerical'
                 4='Administrative';
  value regfmt 1='North'
               2='South'
               3='East'
               4='West';
run;

proc sort data=jobclass;
  by gender;
run;

options nobyline;

proc tabulate data=jobclass format=5.;
  title 'Summarization of Jobs by Region';
  title3 'Data for #byline';

  by gender;

  class region occupat;
   table occupat=' ' all='All Jobs',
         (region='Region' all='All Regions')
         *(n='Count' pctn='%'*f=7.2) /
            rts=20 misstext='0';
  label gender='Gender';
   format gender gendfmt. occupat occupfmt.
          region regfmt.;
run;
options byline;


/***************************************************************/
/* Example 3.7                                                 */
/***************************************************************/
proc format;
  value $aud (multilabel)
             'Adult'          ='   Adult'
             'Juvenile'       ='  Juvenile'
             "YoungPeople's"  =" Young People's"
             'Juvenile',
             "YoungPeople's"  ='All Youth';
  value $med (multilabel)
             'Books'          ='      Books'
             'Periodicals'    ='    Periodicals'
             'Books',
               'Periodicals'  ='   All Print Material'
             'TalkingBooks'  ='  Talking Books'
             'Audio'          ='  Audio'
             'Video'          =' Video'
             'TalkingBooks',
               'Audio','Video'='All Recordings';
run;
proc tabulate data=libraries order=formatted;
  title 'Monthly Circulation Report';
  class media audience / mlf;
  class type;
  var items;

  table media=' '*(type=' ' all='Total for Media') all='Total Items Circulated',
         All='Items Circulated'*(audience=' ' all='Total')*items=' '*sum=' '*f=10. /
         rts=35 misstext='0';

  format media $med. audience $aud.;
run;


/***************************************************************/
/* Example 3.8                                                 */
/***************************************************************/
proc format;
   value mnthfmt 1-3 = '1st'
                 4-6 = '2nd'
                 7-9 = '3rd'
               10-12 = '4th';
run;
proc report data=carsales nowindows ls=80;
  title 'Quality Motor Company';

  column name month numsold amtsold avgsales maxsales;

  define name     / group width=18
                    '    Sales/Representative';
  define month    / group width=8 'Quarter' center
                    format=mnthfmt.;

  define numsold  / analysis sum 'Cars Sold/by/Quarter'
                    format=2. width=9;
  define amtsold  / analysis sum
                    'Total Sales/by/Quarter'
                    format=dollar13.2;

  define avgsales / computed 'Average/Sale'
                    format=dollar13.2;

  define maxsales / computed noprint;


  compute before name;
    bigsales=0;
    bigqtr=50;
    line @6 70*'=';
  endcomp;


  compute avgsales;
     avgsales = amtsold.sum / numsold.sum;
  endcomp;

  compute maxsales;
    if _break_=' ' and bigsales lt amtsold.sum then do;
      bigsales=amtsold.sum;
      bigqtr=month;
    end;
  endcomp;

  compute after name;
    length fullline $ 50;
    fullline=catx(' ','Best Quarter for',
                  cats(name,':'),
                  put(bigqtr,mnthfmt.));

    line @6 70*'=';
    line @6 'Sales Totals for ' name  $14.
         @42 numsold.sum 3. @45 amtsold.sum dollar15.2
         @60 avgsales dollar15.2;
    line @6 fullline $50.;
    line @6 70*'=';
    line ' ';
  endcomp;

  compute after;
    line @6 70*'=';
    line @6 'Annual Totals ' @41 numsold.sum 4.
         @45 amtsold.sum dollar15.2
         @60 avgsales dollar15.2;
    line @6 70*'=';
    line ' ';
  endcomp;

run;


/***************************************************************/
/* Example 3.9                                                 */
/***************************************************************/
proc format;
  value $q 'q1'='1. Road Maintenance'
        'q2'='2. Parks Upkeep'
        'q3'='3. Snowplowing'
        'q4'='4. Sheriff Patrolling'
        'q5'='5. Ordinance Enforcement'
        'q6'='6. Town Office Hours'
        'q7'='7. Community Events'
        'q8'='8. Youth Programs'
        'q9'='9. Senior Services';
  value response 1='Strongly Disapprove'
                 2='Disapprove'
                 3='Neutral'
                 4='Approve'
                 5='Strongly Approve'
                 .='No response';
run;
proc sort data=townsurvey;
  by surveyid;
run;
proc transpose data=townsurvey
               out=townsurvey2(rename=(col1=choice))
               name=question;
  by surveyid;
  var q1-q9;
run;

%let dsid=%sysfunc(open(work.townsurvey,i));
%let nlobs=%sysfunc(attrn(&dsid,nlobs));
%let rc=%sysfunc(close(&dsid));

proc tabulate data=townsurvey2 ;
  title 'Town Survey Results';
  title2 "Number of Participants: &nlobs";

  class question choice;
  table question='Survey Question',
         (choice=' ' all='Total Responses')*
         (n='N'*f=4. rowpctn='Row %'*f=5.1) /
         misstext='0' rts=20;

  format question $q. choice response.;
run;


/***************************************************************/
/* Example 3.9 Related Technique                               */
/***************************************************************/
proc format;
  value $q 'q1'='1. Road Maintenance'
        'q2'='2. Parks Upkeep'
        'q3'='3. Snowplowing'
        'q4'='4. Sheriff Patrolling'
        'q5'='5. Ordinance Enforcement'
        'q6'='6. Town Office Hours'
        'q7'='7. Community Events'
        'q8'='8. Youth Programs'
        'q9'='9. Senior Services';
  value response 1='Strongly/Disapprove'
                 2='Disapprove'
                 3='Neutral'
                 4='Approve'
                 5='Strongly/Approve'
                 .='No response';
run;
proc sort data=townsurvey;
  by surveyid;
run;
proc transpose data=townsurvey
               out=townsurvey2(rename=(col1=choice))
               name=question;
  by surveyid;
  var q1-q9;
run;

%let dsid=%sysfunc(open(work.townsurvey,i));
%let nlobs=%sysfunc(attrn(&dsid,nlobs));
%let rc=%sysfunc(close(&dsid));

proc report data=townsurvey2 nowindows box;
  title 'Town Survey Results';
  title2 "Number of Participants: &nlobs";
  column n=totaln1 question choice,(n pct) n=totaln2;

  define totaln1 / noprint;
  define question / group 'Survey Question' format=$q.;
  define choice / across ' ' order=internal format=response.;
  define n / format=4. 'N';
  define pct / format=5.1 computed 'Pct';
  define totaln2 / format=5. 'Total/N';

   compute pct;
    array cn{5}   _c3_ _c5_ _c7_ _c9_  _c11_;
    array cpct{5} _c4_ _c6_ _c8_ _c10_ _c12_;
    do i=1 to 5;
      if cn{i} ne . and totaln1 gt 0 then cpct{i}=100*(cn{i}/totaln1);
      else cpct{i}=0;
    end;
  endcomp;
run;



/***************************************************************/
/* Example 3.10                                                */
/***************************************************************/
proc format;
  picture pctfmt (default=7) low-high='009.9%' ;
run;

%let dsid=%sysfunc(open(work.custresp,i));
%let nresps=%sysfunc(attrn(&dsid,nlobs));
%let rc=close(&dsid);

options formdlim=' ';
title "Customer Survey Results: &nresps Respondents";
proc tabulate data=custresp;
  title3 'Factors Influencing the Decision to Buy';
  var factor1-factor4 customer;
  table factor1='Cost'
        factor2='Performance'
        factor3='Reliability'
        factor4='Sales Staff',
        (n='Count'*f=7. pctn<customer>='Percent'*f=pctfmt.);
run;
proc tabulate data=custresp;
  title 'Source of Company Name';
  var source1-source3 customer;
  table source1='TV/Radio'
        source2='Internet'
        source3='Word of Mouth',
        (n='Count'*f=7. pctn<customer>='Percent'*f=pctfmt.);
run;
proc tabulate data=custresp;
  title 'Visits Resulting in Sales';
  var website store;
  table website='Website' store='Store',
        (sum='Total Visits'*f=7. mean='Average Visits Per Customer'*f=8.1);
run;
options formdlim='';


/***************************************************************/
/* Example 4.1                                                 */
/***************************************************************/
proc report data=service nowindows noheader spacing=5 ls=80 ps=25;
  title 'Supreme Tire and Auto Repair';
  title2 'Service Record';
  footnote1 'Labor cost is calculated at $65.00 per hour';
  footnote2 'Total cost = Labor cost + Parts cost';

  column name address city state zipcode cartype date
         workdone hours labor parts total;

  define name--zipcode / order noprint;
  define cartype       / order noprint;
  define date          / order format=mmddyy10.;
  define workdone      / order;

  define hours         / analysis sum format=4.1 width=4;
  define parts         / analysis sum format=dollar8.2 width=7;

  define labor         / computed format=dollar8.2;
  define total         / computed format=dollar8.2;

  compute labor;
    labor=hours.sum*65.00;
  endcomp;

  compute total;
    total=labor+parts.sum;
  endcomp;

  compute before cartype;
    length fulladdress $ 55;
    fulladdress=catx(' ',cats(city,','),state,zipcode);
    line @2 name $20.;
    line @2 address $20.;
    line @2 fulladdress $55.;
    line @2 cartype $21.;
    line ' ';
    line @36 'Hours' @49 'Labor' @62 'Parts' @74 'Total';
    line @6 'Date'  @19 'Description' @35 'Worked' @50 'Cost'
         @63 'Cost' @75 'Cost';
    line @2 10*'-'   @17 15*'-' @35 6*'-'
           @46 8*'-' @59 8*'-' @71 8*'-';
  endcomp;

  break after cartype / summarize ol ul page;

run;

/***************************************************************/
/* Example 4.1 Related Technique                               */
/***************************************************************/
proc sort data=service;
  by name address city state zipcode cartype;
run;
options nobyline;
proc report data=service nowindows;
  title 'Supreme Tire and Auto Repair';
  title2 'Service Record';

  title4 justify=left "#byval(name)";
  title5 justify=left "#byval(address)";
  title6 justify=left "#byval(city), #byval(state)   #byval(zipcode)";
  title7 justify=left "#byval(cartype)";

  by name address city state zipcode cartype;

  column cartype date workdone hours labor parts total;

  define cartype / order noprint;

  define date     / order format=mmddyy10. 'Date';
  define workdone / order 'Description';

  define hours / analysis sum format=4.1 'Hours/Worked';
  define parts / analysis sum format=dollar8.2 'Parts/Cost';

  define labor / computed format=dollar8.2 'Labor/Cost';
  define total / computed format=dollar8.2 'Total/Cost';

  compute labor;
    labor=hours.sum*65.00;
  endcomp;

  compute total;
    total=labor+parts.sum;
  endcomp;

  break after cartype / summarize ol ul page;
  compute after cartype;
    line 'Labor cost is calculated at $65.00 per hour';
    line 'Total cost = Labor cost + Parts cost';
  endcomp;
run;





/***************************************************************/
/* Example 4.2                                                 */
/***************************************************************/
proc format;
  invalue colplc 'Active'=45
                 'Placebo'=63;

  value racefmt  0='Non-White'
                 1='White';
  value gendrfmt 0='Male'
                 1='Female';
  value tmtdgfmt 0='Active'
                 1='Placebo';
  picture percen (round)     .='  ( %)' (noedit)
                         other='0009%)' (prefix='(');
run;
proc freq data=demog;
  table tmtdg / out=t1 noprint;
  table tmtdg*gender / out=t2 outpct noprint;
run;
proc means data=demog noprint nway;
  class tmtdg;
  var age;
  output out=t3 min=min max=max mean=mean q3=q3 q1=q1 nmiss=nmiss
         stderr=stderr;
run;
proc freq data=demog;
  table tmtdg*race / out=t4 outpct noprint;
run;
proc means data=demog noprint nway;
  class tmtdg;
  var height;
  output out=t5 min=min max=max mean=mean q3=q3 q1=q1 nmiss=nmiss
         stderr=stderr;
run;
proc means data=demog noprint nway;
  class tmtdg;
  var weight;
  output out=t6 min=min max=max mean=mean q3=q3 q1=q1 nmiss=nmiss
         stderr=stderr;
run;
data _null_;

  file 'external-file' print n=ps notitles header=reporttop;

  set t1(in=in1) t2(in=in2) t3(in=in3) t4(in=in4) t5(in=in5) t6(in=in6);

  inds+1;

  col=input(tmtdg,colplc.);

  if in1 then do;
    if inds=1 then put #row @13 'Number of Patients' @(col+2) count;
    else do;
      put #row @(col) count;
      inds=0;
      row+2;
    end;
  end;
  else if in2 or in4 then do;
    if inds=1 then do;
      if in2 then put #row @13 'Gender';
      else do;
        row+5;
        put #row @13 'Race';
      end;
      row+1;
    end;

    if in2 then put #(row+gender) @15 gender gendrfmt.
                                  @(col-1) count pct_row percen5.;
    else put #(row+race) @15 race racefmt.
                         @(col-1) count pct_row percen5.;
    if inds=4 then inds=0;
  end;
  else if in3 or in5 or in6 then do;
    if inds=1 then do;
      if in3 or in5 then row+3;
      else row+5;
      if in3 then put #row @13 'Age (years)';
      else if in5 then put #row @13 'Height (inches)';
      else put #row @13 'Weight (lbs)';
      row+1;
    end;

    if in3 or in5 then put #row @16 'Mean (SEM)'
                           @(col-2) mean 4.1
                           @(col+3) '(' stderr 4.2 ')'
                           #(row+1) @15 '25th - 75th'
                                    @(col-2) q1 4.1 ' -  ' q3 4.1
                           #(row+2) @16 'Min - Max'
                                    @(col-2) min 4.1 ' -  ' max 4.1
                           #(row+3) @15 'No. Missing' @(col+3) nmiss 1.;
    else put #row @16 'Mean (SEM)' @(col-3) mean 5.1
             @(col+3) '(' stderr 4.2 ')'
             #(row+1) @15 '25th - 75th' @(col-3) q1 5.1 ' - ' q3 5.1
             #(row+2) @16 'Min - Max'   @(col-3) min 5.1 ' - ' max 5.1
             #(row+3) @15 'No. Missing' @(col+3) nmiss 1.;

    if (in3 or in5) and inds=2 then inds=0;
    if in6 and inds=2 then put #(row+4) @13 60*'-';
  end;
  return;

  reporttop:
    put #2  @67 'Client'
        #3  @65 'Protocol'
        #4  @63 'Population'
        #6  @38 'Table  2.14'
        #8  @32 'Baseline Demographics'
        #9  @13 60*'-'
        #10 @45 'Active' @62 'Placebo'
        #11 @13 60*'-';
  row=12;
  return;
run;


/***************************************************************/
/* Example 4.3                                                 */
/***************************************************************/
ods output selectionsummary=ss selparmest=spe nobs=nobs anova=anova;
proc reg data=fitness;
   model oxygen=age weight runtime runpulse rstpulse maxpulse
       / selection=forward;
quit;

proc transpose data=spe out=transpe;
  by step;
  var estimate;
  id variable;
run;
data merged(drop=source);
  merge transpe
        anova(where=(source='Model') keep=fvalue probf source step)
        ss(keep=step partialrsquare modelrsquare cp);
    by step;

run;

proc format;
  picture notselected  .='NS'
                       low-<0='009.999'(prefix='-')
                       0-high='0009.999';

run;

data _null_;
  set nobs;
  call symput('NOBSREAD',nobsread);
  call symput('NOBSUSED',nobsused);
  call symput('NOBSMISS',nobsmiss);
run;

proc report data=merged nowindows box;
  title 'Analysis of Fitness Data Set';
  title2 'Forward Selection of Predictors of Oxygen Consumption';

  column step intercept runtime age runpulse weight maxpulse fvalue probf partialrsquare modelrsquare cp;
  define step / order width=4;
  define intercept--cp / display;

  compute after;
    line "Number of Observations Read=%left(&nobsread)";
    line "Number of Observations Used=%left(&nobsused)";
    line "Number of Observations with Missing Values=%left(&nobsmiss)";
    line ' ';
    line '* NS=Not Selected';
  endcomp;
  format runtime--weight notselected.
         intercept 9.3 fvalue probf cp 6.2 partialrsquare modelrsquare 8.2;
run;

/***************************************************************/
/* Example 4.3 A Closer Look                                   */
/***************************************************************/
ods output anova(persist=proc)=multmodels;
proc reg data=sasuser.fitness;
   model oxygen=age;
quit;
proc reg data=sasuser.fitness;
  model oxygen=runtime;
quit;
ods output close;

proc sort data=sasuser.fitness out=fitsorted;
  by group;
run;
ods output anova(match_all)=multsets;
proc reg data=fitsorted;
  by group;
  model oxygen=age;
quit;

ods output anova(match_all=multsetsnames)=
                      multsets;
proc sort data=sasuser.fitness out=fitsorted;
  by group;
run;
proc reg data=fit;
  by group;
  model oxygen=age;
quit;
data combined;
  set &multsetsnames;
run;
ods output anova
    (match_all persist=proc)= multrun;
proc reg data=sasuser.fitness;
  model oxygen=age;
quit;
proc reg data=sasuser.fitness;
  model oxygen=runpulse;
quit;
proc reg data=sasuser.fitness;
  model oxygen=rstpulse;
quit;
proc reg data=sasuser.fitness;
  model oxygen=maxpulse;
quit;
ods output close;




/***************************************************************/
/* Example 5.1                                                 */
/***************************************************************/
proc report data=inventory panels=99 pspace=5 nowindows box;
  title "Parts Listing as of %sysfunc(date(),mmddyy10.)";

  column partnmbr quantity price;

  define partnmbr / 'Part Number';
  define quantity / format=3. width=7 'In Stock';
  define price    / format=dollar6.2 'Price';

run;


/***************************************************************/
/* Example 5.2                                                 */
/***************************************************************/
proc sort data=students;
  by department fullname;
run;

options ls=80 ps=56;

title 'Biology Division Upperclass List';
data _null_;
  set students;

  retain panel row colptr nstudents colpos1 colpos2;
  retain dots '..............................';
  retain stars '********************************';

  length deptstr $ 32 namedots $ 20;

  array colpos{2} colpos1-colpos2 (5,45);

  file print n=ps;

  by department;

  if first.department then do;
    if _n_=1 then do;
      panel=1;
      row=3;
    end;
    if row gt 50 then do;
      if panel=1 then panel=2;
      else do;
        put _page_;
        panel=1;
      end;
      row=3;
    end;

    nstudents=0;
    colptr=colpos{panel};

    deptl=length(department);
    deptstr=stars;
    if deptl lt 32 then substr(deptstr,(32-deptl)/2,deptl)=department;
    else deptstr=department;

    put #row @colptr deptstr;
    row+1;
  end;

  namel=length(fullname);
  ndots=23-namel;
  namedots=substr(dots,1,ndots);

  put #row @colptr fullname $varying. namel
      namedots +(-1) extension +(-1) '...' class;

  row+1;
  nstudents+1;

  if last.department then do;
    put #row @colptr '******Students in Department: ' nstudents;
    row+1;
    put #row;
    row+1;
  end;

  if row gt 53 then do;
    if panel=1 then panel=2;
    else do;
      put _page_;
      panel=1;
    end;
    colptr=colpos{panel};
    row=3;
  end;
run;

/***************************************************************/
/* Example 6.1                                                 */
/***************************************************************/
ods listing close;
ods html file='c:\reports\example22.html';

proc format;
  value $zonefmt '1'='North Ridge'
                 '2'='Inside Beltline'
                 '3'='Southside'
                 '4'='East Lake'
                 '5'='Westend'
                 '6'='Mountain Brook'
                 '7'='Ensley'
                 '8'='Roebuck';
run;

proc report data=housing nowindows split='/'
            style(report)={rules=rows cellspacing=0}
            style(header)={font_style=italic};

                   ;
   title 'Listing of Local Residential Properties';
   title2 'Price Range $200,000 to $350,000';
   title3 'Listed by Zone';

   footnote "Listing Produced on %sysfunc(today(),worddate12.)";

   where price between 200000 and 350000;

   column zone price type address bedr bath sqfeet age;

   define  zone    / order format=$zonefmt15. width=15
                     'Residential/Zone'
                     style(column)={font_weight=bold};
   define  price   / order descending format=dollar10. width=10
                     'Listing/Price';

   define  type    / display format=$9.'House/Style';

   define  address / format=$25. width=25 'Address'
                     style(header)={just=left};
   define  bedr    / format=2. width=8 'Bedrooms'
                     style(column)={just=center};
   define  bath    / format=3.1 width=9 'Bathrooms'
                     style(column)={just=center};
   define  sqfeet  / format=comma6. width=6  'Square/Feet';
   define  age     / format=3. 'Age';

   break after zone / skip;

run;

ods html close;
ods listing;


/***************************************************************/
/* Example 6.2                                                 */
/***************************************************************/
ods listing close;
ods rtf file='c:\reports\example38.rtf';
proc format;
   value mnthfmt 1-3 = '1st'
                 4-6 = '2nd'
                 7-9 = '3rd'
               10-12 = '4th';
run;

data carsales;
  length name $ 50;
  set carsales;
run;

proc report data=carsales nowindows
                 style(summary)={font_weight=bold}
                 style(lines)={font_weight=bold font_style=italic
                               just=center};


  column name month numsold amtsold avgsales maxsales;

  define name     / group width=25
                    'Sales/Representative'
                    style(column)={font_weight=bold};
  define month    / group width=8 'Quarter' center
                    format=mnthfmt. width=8;

  define numsold  / analysis sum 'Cars Sold/by/Quarter'
                    format=2. width=9;
  define amtsold  / analysis sum
                    'Total Sales/by/Quarter'
                    format=dollar13.2;

  define avgsales / computed 'Average/Sale'
                    format=dollar13.2;

  define maxsales / computed noprint;


  compute before name;
    bigsales=0;
    bigqtr=50;
  endcomp;

  compute avgsales;
     avgsales = amtsold.sum / numsold.sum;
  endcomp;

  compute maxsales;
    if _break_=' ' and bigsales lt amtsold.sum then do;
      bigsales=amtsold.sum;
      bigqtr=month;
    end;
  endcomp;

  break after name / summarize;

  compute after name;
    length fullline $ 50;
    fullline=catx(' ','Best Quarter for',
                  cats(name,':'),
                  put(bigqtr,mnthfmt.));
    line fullline $50.;

    name=catx(' ','Sales Totals for ',name);
  endcomp;

  rbreak after / summarize;

  compute after;
    name='Annual Totals';
  endcomp;

run;
ods rtf close;
ods listing;



/***************************************************************/
/* Example 6.3                                                 */
/***************************************************************/
proc format;
   value gendfmt 1='Female'
                 2='Male';
   value occupfmt 1='Technical'
                  2='Manager/Supervisor'
                  3='Clerical'
                  4='Administrative';
   value regfmt 1='North'
                2='South'
                3='East'
                4='West';
run;

ods listing close;
ods rtf file='c:\reports\example35.rtf';

proc tabulate data=jobclass format=5. style={background=white};
  title 'Regional Gender Distribution';
  title2 'among Job Classes';

  class occupat;
  class gender / style={background=white};
  class region /  style={background=white font_style=italic};
  classlev region / style={background=white font_style=italic};
  classlev gender occupat / style={background=white};

  table occupat=' '  all='All Employees'*{style={background=grayee}},
        (region='Region' all='All Regions Combined')* gender=' '*
        (n='Count' pctn<gender>='%'*f=7.1*{style={background=grayee}}) /
          nocontinued misstext='0'
          box={label="Job Class" style={background=grayee font_style=italic}};

  keyword pctn / style={background=grayee};
  keyword all / style={background=grayee font_style=italic};
  keyword n / style={background=grayaa};

  format gender gendfmt. occupat occupfmt. region regfmt.;
run;

ods rtf close;
ods listing;




/***************************************************************/
/* Example 6.4                                                 */
/***************************************************************/
ods listing close;
ods rtf file='c:\reports\example27.rtf';

proc format;
  value ratio low-<-.1='Improved'
              -.1-.1  ='Minimal Change'
              .1<-high='Worsened';
  value $gender 'M'='Males'
                'F'='Females';
  value $results 'Pre'='Pre$Program$Results'
                 'Post'='Post$Program$Results';
run;
proc report data=lipids nowindows split='$'
                 style(header)={background=grayee};

  title 'Exercise Program Results';

  column gender studyid testperiod,(chol hdl) ratiopre ratiopost results;

  define gender / group 'Gender' format=$gender.
                  style={font_weight=bold};
  define studyid / group 'Study ID'
                   style={font_weight=bold};

  define testperiod / across order=data ' ' center format=$results.;
  define chol / display 'Chol';
  define hdl / display 'HDL';

  define ratiopre  / computed format=5.1 'Chol/HDL Pre' center;
  define ratiopost / computed format=5.1 'Chol/HDL Post' center;
  define results   / computed format=ratio. 'Chol/HDL Change'
                     left
                     style={font_weight=bold};

  compute ratiopre;
    ratiopre=_c3_/_c4_;
  endcomp;
  compute ratiopost;
    ratiopost=_c5_/_c6_;
  endcomp;

  compute results;
    results=(ratiopost-ratiopre)/ratiopre;
    if results <-.1 then
      call define(_ROW_,'style','style={background=white}');
    else if -.1 le results le .1 then
      call define(_ROW_,'style','style={background=graydd}');
    else if results gt .1 then
      call define(_ROW_,'style','style={background=grayaa}');
  endcomp;
run;

ods rtf close;
ods listing;


/***************************************************************/
/* Example 6.4 Related Technique                               */
/***************************************************************/
ods listing close;
ods rtf file='c:\reports\example26b.rtf';

proc format;
  value ratio low-<-.1='Improved'
              -.1-.1  ='Minimal Change'
              .1<-high='Worsened';
  value $gender 'M'='Males'
                'F'='Females';
  value $results 'Pre'='Pre$Program$Results'
                 'Post'='Post$Program$Results';
  value colorres low-<-.1='white'
                 -.1-.1  ='graydd'
                 .1<-high='grayaa';
run;
proc report data=lipids nowindows split='$'
                 style(header)={background=grayee};

  title 'Exercise Program Results';

  column gender studyid testperiod,(chol hdl) ratiopre ratiopost results;

  define gender / group 'Gender' format=$gender.
                  style={font_weight=bold};
  define studyid / group 'Study ID'
                   style={font_weight=bold};

  define testperiod / across order=data ' ' center format=$results.;
  define chol / display 'Chol' width=5;
  define hdl / display 'HDL' width=5;

  define ratiopre  / computed format=5.1 'Chol/HDL Pre' center;
  define ratiopost / computed format=5.1 'Chol/HDL Post' center;
  define results   / computed format=ratio.
                     'Chol/HDL Change'
                     left style={background=colorres.};

  compute ratiopre;
    ratiopre=_c3_/_c4_;
  endcomp;
  compute ratiopost;
    ratiopost=_c5_/_c6_;
  endcomp;

  compute results;
    results=(ratiopost-ratiopre)/ratiopre;
  endcomp;
run;

ods rtf close;
ods listing;

/***************************************************************/
/* Example 6.5                                                 */
/***************************************************************/
ods listing close;
ods rtf file='c:\reportsw\example32.rtf';

proc format;
  value colorcal low-85='graycc'
                 95-high='grayee';
  value colorfib low-1.8='grayee'
                 2-high='graycc';

run;
proc tabulate data=bread;
  title 'Nutritional Information about Breads Available in the Region';
  title2 'Values Per Bread Slice, Calories in kcal, Fiber in Grams';

  class source brand / style={background=grayee};
  classlev source brand  / style={background=white};

  var calories dietary_fiber / style={background=grayee};

  table source*brand,
        calories*(n*f=3.
                 (mean*{style={background=colorcal.}}
                  min max)*f=7.1)
        dietary_fiber*(n*f=3.
                      (mean*{style={background=colorfib.}}
                       min max)*f=7.1) /
           box={style={background=white}} rts=30;

  keyword n mean min max / style={background=white};

run;

ods rtf close;
ods listing;


/***************************************************************/
/* Example 6.6                                                 */
/***************************************************************/
ods listing close;
ods rtf file='c:\reports\example38a.rtf';

proc format;
   value mnthfmt 1-3 = '1st'
                 4-6 = '2nd'
                 7-9 = '3rd'
               10-12 = '4th';
run;

data carsales;
  length name $ 50;
  set carsales;
run;

proc report data=carsales nowindows
                 style(summary)={font_weight=bold}
                 style(lines)={font_weight=bold font_style=italic
                               just=center}
                 style(report)={preimage='c:\reports\vroomsales.jpg'};


  column name month numsold amtsold avgsales maxsales;

  define name     / group 'Sales/Representative'
                    style(column)={font_weight=bold};
  define month    / group 'Quarter' center
                    format=mnthfmt.;

  define numsold  / analysis sum 'Cars Sold/by/Quarter'
                    format=2.;
  define amtsold  / analysis sum
                    'Total Sales/by/Quarter'
                    format=dollar13.2;

  define avgsales / computed 'Average/Sale'
                    format=dollar13.2;

  define maxsales / computed noprint;


  compute before name;
    bigsales=0;
    bigqtr=50;
  endcomp;

  compute avgsales;
     avgsales = amtsold.sum / numsold.sum;
  endcomp;

  compute maxsales;
    if _break_=' ' and bigsales lt amtsold.sum then do;
      bigsales=amtsold.sum;
      bigqtr=month;
    end;
  endcomp;

  break after name / summarize;

  compute after name;
    length fullline $ 50;
    fullline=catx(' ','Best Quarter for',
                  cats(name,':'),
                  put(bigqtr,mnthfmt.));


    name=catx(' ','Sales Totals for ',name);

    line fullline $50.;
  endcomp;

  rbreak after / summarize;

  compute after;
    name='Annual Totals';
  endcomp;

  compute before _page_ / style={preimage='c:\reports\qmc.jpg'};
    line ' ';
  endcomp;
  compute after _page_ / style={postimage='c:\reports\keepselling.jpg'};
    line ' ';
  endcomp;

run;

ods rtf close;
ods listing;


/***************************************************************/
/* Example 6.7                                                 */
/***************************************************************/
options orientation=landscape;

ods listing close;
ods escapechar='^';
ods rtf file='c:\reports\example35b.rtf';
proc format;
  value gendfmt 1='Female'
                2='Male';
  value occupfmt 1='Technical'
                 2='Manager/Supervisor'
                 3='Clerical'
                 4='Administrative';
  value regfmt 1='North'
               2='South'
               3='East'
               4='West';
  value regjpg 1='c:\reports\north.jpg'
               2='c:\reports\south.jpg'
               3='c:\reports\east.jpg'
               4='c:\reports\west.jpg';
run;
proc tabulate data=jobclass format=5. noseps style={background=white};
  title 'Regional Gender Distribution';
  title2 'among Job Classes';

  class occupat;
  class gender / style={background=white};
  class region / style={font_style=italic background=white};
  classlev region    / style={font_style=italic background=white
                              postimage=regjpg.};
  classlev gender occupat / style={background=white};

  table occupat=' ' all='All Employees'*{style={background=grayee}},
        (region='Region'
        all="^S={postimage='c:\reports\allstates.jpg' background=white}All Regions Combined")*
        gender=' '*
        (n='Count'
          pctn<gender>='%'*f=7.1*{style={background=grayee}})/
          rts=20 condense nocontinued misstext='0'
          box={label="Job Class" style={background=grayee font_style=italic}};

  keyword pctn  / style={background=grayee};
  keyword all / style={background=grayee font_style=italic};

  keyword n / style={background=white};

  format gender gendfmt. occupat occupfmt. region regfmt.
         ;
run;
ods rtf close;
ods listing;


/***************************************************************/
/* Example 6.8                                                 */
/***************************************************************/
ods listing close;
ods rtf file='c:\reports\example33b.rtf'
        startpage=no;

proc format;
  value $gender 'M'=' Males'
                'F'='Females';
  value $prepost 'Pre'='Pre Exercise Results'
                 'Post'='Post Exercise Results';
run;

title 'Exercise Program Results';
proc univariate data=lipids
                noprint;
  class gender (order=formatted)
        testperiod (order=data);
  var chol;
  label chol='Cholesterol';
  histogram /
              normal(noprint color=black)
              font=swiss
              midpoints=125 to 300 by 25
              href=200 hreflabels='200';
  format gender $gender. testperiod $prepost.;
run;

proc tabulate data=lipids;
  class gender testperiod / descending
                            style={background=white};
  classlev gender testperiod / style={background=white};
  var chol hdl tri / style={background=white};
  table (gender='Gender'
        all='Both Genders')*testperiod='Testing Period',
         all='Lipid Profile'*(chol='Cholesterol'
                 hdl='HDL' tri='Triglycerides')*
       (n*f=3. (mean std='Std Dev' p25 p50 p75)*f=5.1) /
         nocontinued
         box={style={background=white}};
  keyword all n mean std p25 p50 p75 /
             style={background=white};
  format gender $gender.;
run;
ods rtf close;
ods listing;


/***************************************************************/
/* Example 6.9                                                 */
/***************************************************************/
ods escapechar='^';

ods listing close;
ods rtf file='c:\reports\example33c.rtf';

proc format;
  value $gender 'M'="^S={url='c:\reports\lipids.xls#Males!A1'}Males    "
                'F'="^S={url='c:\reports\lipids.xls#Females!A1'}Females";
run;


proc tabulate data=lipids;
  title 'Exercise Program Results';
  class gender testperiod / descending style={background=white};
  classlev gender testperiod / style={background=white};
  var chol hdl tri / style={background=white};
  table (gender='Gender' all="^S={url='c:\reports\lipids.html'}Both Genders")*
         testperiod='Testing Period',
         all='Lipid Profile'*
         (chol='Cholesterol' hdl='HDL' tri='Triglycerides')*
         (n*f=3. (mean std='Std Dev' p25 p50 p75)*f=5.1) /
         box={label='Exercise and Lipids Study'
         style={url='c:\reports\lipidsdesc.txt' background=white}}
         condense rts=20 nocontinued;
  keyword all n mean std p25 p50 p75 / style={background=white};
  format gender $gender.;
run;

ods rtf close;
ods listing;







/***************************************************************/
/* Example 6.9 Related Technique                               */
/***************************************************************/
ods listing close;
ods rtf file='c:\reports\example33d.rtf';
proc format;
  value $gender 'M'='Males'
                'F'='Females';
run;

proc report data=lipids nowindows box
            style(header)={background=white};
  title 'Exercise Program Results';
  column ("^S={url='c:\reports\lipidsdesc.txt'}Exercise and Lipids Study" gender testperiod)

         chol,(n mean std p25 p50 p75)
         hdl,(n mean std p25 p50 p75)
         tri,(n mean std p25 p50 p75);

  define gender / group format=$gender. left id descending 'Gender';
  define testperiod / group left id descending 'Testing Period';
  define chol / 'Cholesterol';
  define hdl / 'HDL';
  define tri / 'Triglycerides';

  define n / format=4. 'N';
  define mean / format=5.1 'Mean';
  define std / format=5.1 'Std Dev';
  define p25 / format=5.1 'P25';
  define p50 / format=5.1 'P50';
  define p75 / format=5.1 'P75';

  compute gender;
    length urllink $ 100;
    if gender='M' then urllink="c:\reports\lipids.xls#Males!A1";
    else if gender='F' then urllink="c:\reports\lipids.xls#Females!A1";
    call define('gender','url',urllink);
  endcomp;

  compute after;
    line "^S={url='c:\reports\lipids.html'}View Data for Both Genders";
  endcomp;

run;
ods rtf close;
ods listing;


/***************************************************************/
/* Example 6.10                                                */
/***************************************************************/
ods listing close;
ods html file='c:\reports\example24.html';

proc format;
  value $type    'res'='Residential'
                 'com'='Commercial';
  value $service 'gen'='General Service'
                 'wtr'='Water Heating'
                 'op' ='Off Peak'
                 'spc'='Space Heating'
                 'fld'='Flood Lights'
                 'area'='Area Lights'
                 'oth'='Other Service';
  value $colorserv 'Area Lights','Flood Lights'='grayee'
                   'General Service','Other Service'='graydd'
                   'Off Peak'='graycc'
                   'Space Heating','Water Heating'='graybb';
run;

proc sort data=poweruse out=sorted;
  by type service;
run;

title 'Regional Energy';
title2 'Quarterly Use by Residential and Commercial Customers';
proc print data=sorted label
  style(data)={background=white}
  style(header)={background=white font_face='Times'}
  style(obs)={background=white}
  style(obsheader)={background=white}
  style(total)={background=white font_face='Times' font_style=italic }
  style(table)={background=black}
  ;

  id type / style={font_face='Times' font_style=italic };
  by type;
  var service / style={background=$colorserv. font_style=italic font_weight=bold
                       font_face='Times'};
  var jan feb mar apr may jun;
  sum jan feb mar apr may jun;

  label type='00'x
        service='Service'
        jan='January'
        feb='February'
        mar='March'
        apr='April'
        may='May'
        jun='June';
  format type $type. service $service.
         jan--jun comma6.;
run;

ods html close;
ods listing;






/***************************************************************/
/* Example 6.11                                                 */
/***************************************************************/
ods listing close;
ods rtf file='c:\reports\example52.rtf' columns=3;

proc report data=inventory nowindows box
            style(column)={font_size=12pt};
  title "Parts Listing as of %sysfunc(date(),worddate.)";

  column partnmbr quantity price;

  define partnmbr / 'Part Number';
  define quantity / format=3. 'In Stock';
  define price    / format=dollar6.2 'Price';

run;

ods rtf close;
ods listing;


/***************************************************************/
/* Example 6.12                                                */
/***************************************************************/

proc format;
  invalue colplc 'Active'=45
                 'Placebo'=63;
  value racefmt  0='Non-White'
                 1='White';
  value gendrfmt 0='Male'
                 1='Female';
  value tmtdgfmt 0='Active'
                 1='Placebo';
  picture percen (round)     .='  ( %)' (noedit)
                         other='0009%)' (prefix='(');
run;
proc freq data=demog;
  table tmtdg / out=t1 noprint;
  table tmtdg*gender / out=t2 outpct noprint;
run;
proc means data=demog noprint;
  class tmtdg;
  types tmtdg;
  var age;
  output out=t3 min=min max=max mean=mean q3=q3 q1=q1 nmiss=nmiss
         stderr=stderr;
run;
proc freq data=demog;
  table tmtdg*race / out=t4 outpct noprint;
run;
proc means data=demog noprint;
  class tmtdg;
  types tmtdg;
  var height;
  output out=t5 min=min max=max mean=mean q3=q3 q1=q1 nmiss=nmiss
         stderr=stderr;
run;
proc means data=demog noprint;
  class tmtdg;
  types tmtdg;
  var weight;
  output out=t6 min=min max=max mean=mean q3=q3 q1=q1 nmiss=nmiss
         stderr=stderr;
run;
data all;
  set t1(in=in1) t2(in=in2) t3(in=in3) t4(in=in4)
      t5(in=in5) t6(in=in6);

  length text $ 25 factor $ 50;

  if in1 then do;
    section=1;
    row=1;
    factor='Number of Patients';
    text=put(count,4.);
    output;
  end;
  else if in2 then do;
    section=2;
    if gender=0 then do;
      row=1;
      factor='Male';
    end;
    else if gender=1 then do;
      row=2;
      factor='Female';
    end;
    text=catx(' ',put(count,4.),cats('(',put(percent,3.),'%',')'));
    output;
  end;
  else if in4 then do;
    section=4;
    if race=0 then do;
      row=1;
      factor='Non-White';
    end;
    else if race=1 then do;
      row=2;
      factor='White';
    end;
    text=catx(' ',put(count,4.),cats('(',put(percent,3.),'%',')'));
    output;
  end;
  else if in3 or in5 or in6 then do;
    if in3 then section=3;
    else if in5 then section=5;
    else if in6 then section=6;
    factor='Mean (SEM)';
    text=catx(' ',put(mean,5.1),cats('(',put(stderr,5.2),')'));
    row=1;
    output;
    factor='25th - 75th';
    text=catx(' ',put(q1,5.1),'-',put(q3,5.1));
    row=2;
    output;
    factor='Min - Max';
    text=catx(' ',put(min,5.1),'-',put(max,5.1));
    row=3;
    output;
    factor='No. Missing';
    text=put(nmiss,2.);
    row=4;
    output;
  end;
run;
proc sort data=all;
  by section row factor;
run;
proc transpose data=all out=all2;
  by section row factor;
  id tmtdg;
  var text;
run;

ods escapechar='^';

title  justify=right '^S={font_style=roman}Client';
title2 justify=right '^S={font_style=roman}Protocol';
title3 justify=right '^S={font_style=roman}Population';
title5 '^S={font_style=roman}Table 2.14';
title7 '^S={font_style=roman}Baseline Demographics';

proc template;
  define header sasuser.statscol;
    style={background=_undef_};
  end;
  define table sasuser.demog;
    style={rules=none frame=void};
    column a b c;
    define column a;
      define header notext;
        style={background=_undef_};
        text ' ';
      end;
      header=notext;
    end;
    define column b;
      just=center;
      header=sasuser.statscol;
    end;
    define column c;
      just=center;
      header=sasuser.statscol;
    end;
  end;
run;

ods listing close;
ods rtf file='c:\reports\example42.rtf';

data _null_;
  set all2;

  file print ods=(template='sasuser.demog'
                  columns=(a=factor b=active
                           c=placebo));

  if row=1 then do;
    if section=1 then factor=cats("^S={font_weight=bold}" ,factor);
    else if section=2 then
        put /
            @1 "^S={font_weight=bold}Gender";
    else if section=3 then
        put / @1 '^S={font_weight=bold}Age (years)';
    else if section=4 then
        put / @1 '^S={font_weight=bold}Race';
    else if section=5 then
        put / @1 '^S={font_weight=bold}Height (inches)';
    else if section=6 then
        put / @1 '^S={font_weight=bold}Weight (lbs)';
  end;

  put _ods_ ;
run;

ods rtf close;
ods listing;


/***************************************************************/
/* Example 6.13                                                */
/***************************************************************/
ods listing close;
ods rtf file='c:\reports\example310.rtf' startpage=no;

proc format;
  picture pctfmt (default=7) low-high='009.9%' ;
run;

%let dsid=%sysfunc(open(work.custresp,i));
%let nresps=%sysfunc(attrn(&dsid,nlobs));
%let rc=close(&dsid);

title "Customer Survey Results: &nresps Respondents";

proc tabulate data=custresp;
  var factor1-factor4 customer;
  table factor1='Cost'
        factor2='Performance'
        factor3='Reliability'
        factor4='Sales Staff',
        (n='Count'*f=7. pctn<customer>='Percent'*f=pctfmt.) /
        box={label='Factors Influencing the Decision to Buy'
             style={font_size=12pt cellwidth=2in}} ;

run;
proc tabulate data=custresp;
  var source1-source3 customer;
  table source1='TV/Radio'
        source2='Internet'
        source3='Word of Mouth',
        (n='Count'*f=7. pctn<customer>='Percent'*f=pctfmt.) /
        box={label='Source of Company Name'
        style={font_size=12pt cellwidth=2in}};
run;
proc tabulate data=custresp;
  var website store;
  table website='Website'
        store='Store',
        (sum='Total Visits'*f=7.
        mean='Average Visits Per Customer'*f=8.1) /
        box={label='Visits Resulting in Sales'
        style={font_size=12pt cellwidth=2in}}
         ;
run;

ods rtf close;
ods listing close;


/***************************************************************/
/* Example 6.14                                                */
/***************************************************************/
proc template;
  define style marketing / store=sasuser.templat;
    parent=styles.printer;

    replace fonts /
           'TitleFont2' = ("Times Roman",12pt,Bold)
           'TitleFont' = ("Times Roman",14pt,Bold)
           'StrongFont' = ("Times Roman",10pt,Bold)
           'EmphasisFont' = ("Times Roman",10pt,Italic)
           'FixedEmphasisFont' = ("Courier",9pt,Italic)
           'FixedStrongFont' = ("Courier",9pt,Bold)
           'FixedHeadingFont' = ("Courier",9pt,Bold)
           'BatchFixedFont' = ("SAS Monospace, Courier",6.7pt)
           'FixedFont' = ("Courier",9pt)
           'headingEmphasisFont' = ("Times Roman",11pt,Bold Italic)
           'headingFont' = ("Times Roman",12pt,Bold)
           'docFont' = ("Times Roman",12pt);

    replace color_list
           "Chnage background to undefined" /
           'link' = blue
           'bgH' = _undef_
           'fg' = black
           'bg' = _undef_;
    replace Body from Document
           "Change margins" /
           bottommargin = 1in
           topmargin = 1in
           rightmargin = 1in
           leftmargin = 1in;
    style SystemFooter from TitlesAndFooters
         "Controls system title text." /
          font = Fonts('EmphasisFont');
    style table from table /
          rules=rows;
  end;
run;


options nodate nonumber;
ods listing close;
ods rtf file='c:\reports\example312b.rtf' style=marketing startpage=no ;

proc format;
  picture pctfmt (default=7) low-high='009.9%' ;
run;

%let dsid=%sysfunc(open(work.custresp,i));
%let nresps=%sysfunc(attrn(&dsid,nlobs));
%let rc=close(&dsid);

%let companyname=Great Electronics Everyday;
%let today=%sysfunc(date(),worddate.);

ods escapechar='^';

title '^S={preimage="c:\reports\xyz.jpg"}';
title2 "Customer Survey Results for ^S={font_style=italic}&companyname";
title3 "&nresps Respondents";
footnote "Report Prepared &today";
footnote2 "83872 West Lake Road  Townville, CA  99999";
footnote3 "http://www.xyzmarketingconsultants.com   (999)555-5555";

proc tabulate data=custresp;
  var factor1-factor4 customer;
  table factor1='Cost'
        factor2='Performance'
        factor3='Reliability'
        factor4='Sales Staff',
        (n='Count'*f=7. pctn<customer>='Percent'*f=pctfmt.) /
        box={label='Factors Influencing the Decision to Buy'
              style={font_size=12pt cellwidth=2in}} ;

run;
proc tabulate data=custresp;
  var source1-source3 customer;
  table source1='TV/Radio'
        source2='Internet'
        source3='Word of Mouth',
        (n='Count'*f=7. pctn<customer>='Percent'*f=pctfmt.) /
        box={label='Source of Company Name'
        style={font_size=12pt cellwidth=2in}};
run;
proc tabulate data=custresp;
  var website store;
  table website='Website' store='Store',
         (sum='Total Visits'*f=7.
         mean='Average Visits Per Customer'*f=8.1) /
         box={label='Visits Resulting in Sales'
         style={font_size=12pt cellwidth=2in}}
         ;
run;

ods rtf close;
ods listing;


/***************************************************************/
/* Example 6.15                                                */
/***************************************************************/
proc template;
  define table categories;
    mvar titleone;
    dynamic categoryheader;

    column (category1) (category2) (calories) (mincal) (fiber) (maxfiber);

    overline=on;
    underline=on;

    header table_header_1;
    define table_header_1;
      text 'Results ' titleone;
    end;

    define category1;
      generic=on;
      header=categoryheader;
    end;
    define category2;
      generic=on;
      header=categoryheader;
    end;
    define calories;
      generic=on;
      header='Lowest Calories';
    end;
    define mincal;
      generic=on;
      header='kcal';
      style={just=center};
    end;
    define fiber;
      generic=on;
      header='Highest Fiber';
    end;
    define maxfiber;
      generic=on;
      header='grams';
      style={just=center};
    end;
  end;
run;

ods listing close;
ods rtf file='c:\reports\example32b.rtf'
        startpage=no;

/* Start Table 1 */
%let titleone=Overall;
data _null_;
  set breadstats(where=(_type_=0));
  length fullcal1 fullcal2 fullcal3
         fullfiber1 fullfiber2 fullfiber3 $ 50;

  fullcal1=catx(' ',wherecal_1,flourcal_1,typecal_1);
  fullcal2=catx(' ',wherecal_2,flourcal_2,typecal_2);
  fullcal3=catx(' ',wherecal_3,flourcal_3,typecal_3);
  fullfiber1=catx(' ',
      wherefiber_1,flourfiber_1,typefiber_1);
  fullfiber2=catx(' ',
      wherefiber_2,flourfiber_2,typefiber_2);
  fullfiber3=catx(' ',
      wherefiber_3,flourfiber_3,typefiber_3);

  file print ods=(template='categories'
    columns=(calories=fullcal1(generic=on)
             calories=fullcal2(generic=on)
             calories=fullcal3(generic=on)
             mincal=mincal_1(generic=on)
             mincal=mincal_2(generic=on)
             mincal=mincal_3(generic=on)
             fiber=fullfiber1(generic=on)
             fiber=fullfiber2(generic=on)
             fiber=fullfiber3(generic=on)
             maxfiber=maxfiber_1(generic=on)
             maxfiber=maxfiber_2(generic=on)
             maxfiber=maxfiber_3(generic=on)
  ));
  put _ods_;
run;

/* Start Table 2 */
%let titleone=by Source;
data _null_;
  set breadstats(where=(_type_=8));
  length fullcal1 fullcal2 fullcal3
         fullfiber1 fullfiber2 fullfiber3 $ 50;

  fullcal1=catx(' ',wherecal_1,flourcal_1,typecal_1);
  fullcal2=catx(' ',wherecal_2,flourcal_2,typecal_2);
  fullcal3=catx(' ',wherecal_3,flourcal_3,typecal_3);
  fullfiber1=catx(' ',
      wherefiber_1,flourfiber_1,typefiber_1);
  fullfiber2=catx(' ',
      wherefiber_2,flourfiber_2,typefiber_2);
  fullfiber3=catx(' ',
      wherefiber_3,flourfiber_3,typefiber_3);

  file print ods=(template='categories'
   columns=(category2=source(generic=on
    dynamic=(categoryheader='Source'))
             calories=fullcal1(generic=on)
             calories=fullcal2(generic=on)
             calories=fullcal3(generic=on)
             mincal=mincal_1(generic=on)
             mincal=mincal_2(generic=on)
             mincal=mincal_3(generic=on)
             fiber=fullfiber1(generic=on)
             fiber=fullfiber2(generic=on)
             fiber=fullfiber3(generic=on)
             maxfiber=maxfiber_1(generic=on)
             maxfiber=maxfiber_2(generic=on)
             maxfiber=maxfiber_3(generic=on)
  ));
  put _ods_;
run;
/* Start Table 3 */
%let titleone=by Type;
data _null_;
  set breadstats(where=(_type_=1));
  length fullcal1 fullcal2 fullcal3
         fullfiber1 fullfiber2 fullfiber3 $ 30;

  fullcal1=catx(' ',wherecal_1,flourcal_1);
  fullcal2=catx(' ',wherecal_2,flourcal_2);
  fullcal3=catx(' ',wherecal_3,flourcal_3);
  fullfiber1=catx(' ',wherefiber_1,flourfiber_1);
  fullfiber2=catx(' ',wherefiber_2,flourfiber_2);
  fullfiber3=catx(' ',wherefiber_3,flourfiber_3);
  file print ods=(template='categories'
    columns=(category2=type(generic=on
    dynamic=(categoryheader='Type'))
             calories=fullcal1(generic=on)
             calories=fullcal2(generic=on)
             calories=fullcal3(generic=on)
             mincal=mincal_1(generic=on)
             mincal=mincal_2(generic=on)
             mincal=mincal_3(generic=on)
             fiber=fullfiber1(generic=on)
             fiber=fullfiber2(generic=on)
             fiber=fullfiber3(generic=on)
             maxfiber=maxfiber_1(generic=on)
             maxfiber=maxfiber_2(generic=on)
             maxfiber=maxfiber_3(generic=on)
  ));
  put _ods_;
run;

ods rtf startpage=now;

/* Start Table 4 */
%let titleone=by Source and Brand;
data _null_;
  set breadstats(where=(_type_=12));
  length fullcal1 fullcal2 fullcal3
         fullfiber1 fullfiber2 fullfiber3 $ 30;
  fullcal1=catx(' ',flourcal_1,typecal_1);
  fullcal2=catx(' ',flourcal_2,typecal_2);
  fullcal3=catx(' ',flourcal_3,typecal_3);
  fullfiber1=catx(' ',flourfiber_1,typefiber_1);
  fullfiber2=catx(' ',flourfiber_2,typefiber_2);
  fullfiber3=catx(' ',flourfiber_3,typefiber_3);

  file print ods=(template='categories'
    columns=(category1=source(generic=on
    dynamic=(categoryheader='Source'))
             category2=brand(generic=on
    dynamic=(categoryheader='Brand'))
             calories=fullcal1(generic=on)
             calories=fullcal2(generic=on)
             calories=fullcal3(generic=on)
             mincal=mincal_1(generic=on)
             mincal=mincal_2(generic=on)
             mincal=mincal_3(generic=on)
             fiber=fullfiber1(generic=on)
             fiber=fullfiber2(generic=on)
             fiber=fullfiber3(generic=on)
             maxfiber=maxfiber_1(generic=on)
             maxfiber=maxfiber_2(generic=on)
             maxfiber=maxfiber_3(generic=on)
  ));
  put _ods_;
run;

ods rtf close;
ods listing;
 




/***************************************************************/
/* Create HOUSING Data Set                                     */
/* Used in Examples 2.1, 2.2, 6.1                              */
/***************************************************************/
data housing;
   input zone $1. +1 type : $9. bedr bath sqfeet age
         schools : $15. / address & $25. price;
datalines;
4 capecod 4 2.5 2538 6 920:340/400/368
211 Whitehall Way  354900
1 colonial 4 2.5 2700 7 920:470/360/552
1800 Bridgeport  369900
3 townhouse 2 2 1595 6 320:332/366/312
154 Montrose  202000
1 colonial 3 2.5 2750 0 920:628/388/348
4000 Skipjack Ct.  314900
4 split 3 2 1306 0 920:576/512/436
5933 South Downs Dr.  195400
2 capecod 3 3.5 2590 0 920:364/608/368
727 Crabtree Crossing  392400
5 split 3 2 1959 31 680:308/316/332
627 Riverside Dr.  158900
2 townhouse 3 2.5 1374 15 920:304/604/368
907 Lexington Ct.  165500
4 condo 2 2 1275 5 920:448/472/318
6010-102 Winterpoint  170000
4 ranch 3 2 1526 6 920:476/424/428
6509 Orchard Knoll  207900
1 split 3 1.5 1329 23 920:396/360/552
500 E. Millbrook Rd.  282900
1 condo 3 2.5 1300 5 920:448/472/318
6010-101 Winterpoint  168900
8 townhouse 2 2 1120 4 320:364/366/312
521 Woodwinds  184600
2 condo 2 2 1066 1 920:520/604/368
1324 Killiam Ct.  174900
4 split 4 2.5 2600 10 920:476/424/428
7141 Eastridge  398000
2 townhouse 2 1.5 1150 15 920:304/400/368
1239 Donaldson Ct.  249900
4 ranch 3 2.5 2441 1 920:540/512/436
9354 Sauls Rd.  497000
1 split 3 1 1245 36 920:524/388/348
2414 Van Dyke  285000
7 townhouse 2 1.5 1280 4 920:584/592/588
409 Galashiels  260000
4 ranch 3 3 2400 2 920:420/424/428
8122 Maude Steward Rd.  329900
2 duplex 2 2.5 1184 4 920:364/604/368
112 Lake Hollow  167900
6 duplex 3 1 1569 73 350:324/328/336
108 South Elm St.  200000
2 townhouse 2 1.5 1040 9 920:414/604/316
216 Concannon Ct.  259900
4 condo 3 2 1448 5 920:448/472/318
6000-102 Winterpoint  179900
2 townhouse 3 2 1471 1 920:364/604/368
765 Crabtree Crossing  284000
4 capecod  3 2.5 1940 4 920:328/312/316
1641 Pricewood Lane  395000
5 split 2 1 960 2 680:308/304/332
Rt.5 Yarbororugh Rd.  278900
8 townhouse 2 2 1167 5 320:364/366/312
5001 Pine Cone  178500
2 condo 2 2 1246 4 920:364/604/316
721 Springfork  176900
1 townhouse 2 1 980 4 920:304/360/552
1203 Berley Ct  172400
8 colonial 4 2.5 3446 0 320:313/316/356
Lot 10 Red Coach Rd.  425000
8 split 3 1.5 1441 28 320:315/316/356
5617 Laurel Crest Dr.  286900
5 twostory 3 2.5 1900 4 680:308/316/332
1532 St. Mary's Rd.  518500
8 split 3 2 1976 10 320:348/316/356
110 Skylark Way  323500
8 townhouse 2 2 1276 6 321:360/304/356
8 Stonevillage  271000
5 split 3 2 1533 5 680:308/316/322
603 Greentree Dr.  217800
2 capecod  4 2.5 2584 0 920:364/640/368
114 Grey Horse Dr.  389900
8 capecod  4 2.5 2608 0 320:362/366/312
2103 Carriage Way  389900
2 townhouse 3 2.5 2080 4 920:530/400/318
108 Chattle Close  279900
5 colonial 3 2.5 2863 7 680:308/316/332
5521 Horseshoe Circle  599200
8 split 2 2.5 2900 38 320:315/316/356
2617 Snow Hill Rd  625000
3 colonial 4 4.5 4926 5 320:362/366/312
49 Birn Ham Lane  560000
4 split 3 1 1010 28 920:432/404/436
4341 Rock Quarry  260000
1 split 3 2 1662 12 920:488/360/552
6324 Lakeland, Lake Park  200000
2 split 3 2 2004 0 920:568/400/318
101 Meadowglade Ln.  279950
2 capecod  3 2.5 1650 0 920:364/608/368
100 Cumberland Green  343000
1 bungalow 3 2.5 2416 6 920:568/356/318
6008 Brass Lantern Ct.  344500
4 ranch 3 2.5 2441 1 920:540/512/436
9356 Sauls Rd.  497000
1 colonial 5 4.5 4850 3 920:540/512/436
9317 Sauls Rd.  539950
4 split 3 1.5 1225 18 920:328/312/316
6424 Old Jenks Rd.  281900
;



/***************************************************************/
/* Create FEEDERBIRDS Data Set                                 */
/* This data set is a random sample of observations taken from */
/* a Cornell Lab of Ornithology data set that manages the      */
/* records in the Project FeederWatch Citizen Science program. */
/* The sample contains records of the bird species seen and    */
/* numbers counted at bird feeders during the 2002-2003 winter */
/* season in Minnesota.                                        */
/* Used in Examples 2.3                                        */
/***************************************************************/
data feederbirds;
  infile datalines dsd;
  attrib id      length=$8 label='Study ID'
         species length=$6 label='Bird Species'
         p1      length=3  label='Birds Seen Period 1'
         p2      length=3  label='Birds Seen Period 2'
         p3      length=3  label='Birds Seen Period 3'
         p4      length=3  label='Birds Seen Period 4'
         p5      length=3  label='Birds Seen Period 5'
         p6      length=3  label='Birds Seen Period 6'
         p7      length=3  label='Birds Seen Period 7'
         p8      length=3  label='Birds Seen Period 8'
         p9      length=3  label='Birds Seen Period 9'
         p10     length=3  label='Birds Seen Period 10'
         countsitesize length=3 label='Size of feeder count site'
         countsitedesc length=3 label='Decscription of count site'
         pop     length=3  label='Population of city or town'
         density length=3  label='Housing density in neighborhood'
         seedground    length=3 label='Number of seed feeders on ground'
         seedhang      length=3 label='Number of hanging seed feeders'
         seedplat      length=3 label='Number of raised platform feeders'
         thistle       length=3 label='Number of thistle feeders'
         suetfat       length=3 label='Number of suet or fat feeders'
         water         length=3 label='Number of water dispensers'
         everseen      length=3 label='Species seen at least once during season';
  input id $ species $ p1-p10 countsitesize countsitedesc pop density
        seedground seedhang seedplat thistle suetfat water everseen;
datalines;
MN1001,amecro,0,0,0,1,2,0,2,0,0,0,3,4,2,1,1,1,2,1,1,0,1
MN1001,amegfi,2,2,3,6,9,7,6,8,7,6,3,4,2,1,1,1,2,1,1,0,1
MN1001,amerob,1,20,1,0,0,0,1,0,0,3,3,4,2,1,1,1,2,1,1,0,1
MN1001,amtspa,0,0,0,0,0,0,0,0,0,0,3,4,2,1,1,1,2,1,1,0,0
MN1001,bkcchi,3,2,2,2,1,1,2,2,1,2,3,4,2,1,1,1,2,1,1,0,1
MN1001,blujay,2,2,1,4,2,2,1,4,3,2,3,4,2,1,1,1,2,1,1,0,1
MN1001,borchi,0,0,0,0,0,0,0,0,0,0,3,4,2,1,1,1,2,1,1,0,0
MN1001,brncre,0,0,0,0,0,0,0,0,0,0,3,4,2,1,1,1,2,1,1,0,0
MN1001,chispa,0,0,0,0,0,0,0,0,1,0,3,4,2,1,1,1,2,1,1,0,1
MN1001,comgra,0,0,0,0,0,0,0,0,0,5,3,4,2,1,1,1,2,1,1,0,1
MN1001,comred,0,0,0,0,0,0,0,0,0,0,3,4,2,1,1,1,2,1,1,0,0
MN1001,coohaw,0,0,0,0,0,0,0,0,0,0,3,4,2,1,1,1,2,1,1,0,0
MN1001,daejun,1,9,1,2,3,2,5,2,20,4,3,4,2,1,1,1,2,1,1,0,1
MN1001,dowwoo,3,2,2,2,3,3,6,3,4,6,3,4,2,1,1,1,2,1,1,0,1
MN1001,eursta,0,0,0,0,0,0,0,0,4,5,3,4,2,1,1,1,2,1,1,0,1
MN1001,foxspa,0,0,0,0,0,0,0,0,0,0,3,4,2,1,1,1,2,1,1,0,0
MN1001,haiwoo,0,0,1,3,2,2,1,0,1,1,3,4,2,1,1,1,2,1,1,0,1
MN1001,houfin,3,0,0,0,0,0,0,0,2,2,3,4,2,1,1,1,2,1,1,0,1
MN1001,houspa,20,30,20,20,20,20,20,20,10,20,3,4,2,1,1,1,2,1,1,0,1
MN1001,logshr,0,0,0,0,0,0,0,0,0,0,3,4,2,1,1,1,2,1,1,0,0
MN1001,mallar,0,0,0,0,0,0,0,0,0,0,3,4,2,1,1,1,2,1,1,0,0
MN1001,moudov,0,0,0,0,0,0,0,1,0,1,3,4,2,1,1,1,2,1,1,0,1
MN1001,norcar,2,2,0,1,3,2,2,2,3,2,3,4,2,1,1,1,2,1,1,0,1
MN1001,norfli,0,0,0,0,0,0,0,2,0,0,3,4,2,1,1,1,2,1,1,0,1
MN1001,norshr,0,0,0,0,0,0,0,0,0,0,3,4,2,1,1,1,2,1,1,0,0
MN1001,pilwoo,0,0,0,1,1,0,0,1,0,0,3,4,2,1,1,1,2,1,1,0,1
MN1001,pinsis,0,0,0,0,0,0,0,0,0,0,3,4,2,1,1,1,2,1,1,0,0
MN1001,purfin,1,0,0,0,0,0,0,0,0,0,3,4,2,1,1,1,2,1,1,0,1
MN1001,rebnut,0,0,0,0,0,0,0,0,0,0,3,4,2,1,1,1,2,1,1,0,0
MN1001,rebwoo,0,1,1,1,1,1,1,1,1,1,3,4,2,1,1,1,2,1,1,0,1
MN1001,rewbla,0,0,0,0,0,0,0,0,0,0,3,4,2,1,1,1,2,1,1,0,0
MN1001,rocdov,0,0,0,0,0,0,0,0,0,0,3,4,2,1,1,1,2,1,1,0,0
MN1001,shshaw,0,0,0,0,0,0,0,0,0,0,3,4,2,1,1,1,2,1,1,0,0
MN1001,sonspa,0,0,0,0,0,0,1,0,0,0,3,4,2,1,1,1,2,1,1,0,1
MN1001,tuftit,0,0,0,0,0,0,0,0,0,0,3,4,2,1,1,1,2,1,1,0,0
MN1001,whbnut,2,1,1,1,1,1,2,1,2,1,3,4,2,1,1,1,2,1,1,0,1
MN1001,whtspa,0,0,0,0,0,0,0,0,0,0,3,4,2,1,1,1,2,1,1,0,0
MN1002,amecro,0,0,0,0,0,0,0,2,2,1,3,5,2,1,3,3,1,1,2,0,1
MN1002,amegfi,1,0,0,2,7,0,1,7,7,0,3,5,2,1,3,3,1,1,2,0,1
MN1002,amerob,0,0,0,0,0,0,0,1,0,0,3,5,2,1,3,3,1,1,2,0,1
MN1002,amtspa,0,0,0,0,0,0,0,0,0,0,3,5,2,1,3,3,1,1,2,0,0
MN1002,bkcchi,3,3,4,4,5,5,4,4,6,4,3,5,2,1,3,3,1,1,2,0,1
MN1002,blujay,2,2,2,1,2,2,0,4,2,1,3,5,2,1,3,3,1,1,2,0,1
MN1002,borchi,0,0,0,0,0,0,0,0,0,0,3,5,2,1,3,3,1,1,2,0,0
MN1002,brncre,1,3,2,2,1,3,1,2,2,1,3,5,2,1,3,3,1,1,2,0,1
MN1002,chispa,0,0,0,0,0,0,0,0,0,0,3,5,2,1,3,3,1,1,2,0,0
MN1002,comgra,2,1,2,1,0,0,0,0,0,0,3,5,2,1,3,3,1,1,2,0,1
MN1002,comred,0,0,0,0,0,0,0,0,0,0,3,5,2,1,3,3,1,1,2,0,0
MN1002,coohaw,0,0,1,0,0,0,0,0,0,0,3,5,2,1,3,3,1,1,2,0,1
MN1002,daejun,30,6,1,12,6,6,0,4,8,0,3,5,2,1,3,3,1,1,2,0,1
MN1002,dowwoo,1,2,2,2,1,1,1,2,2,2,3,5,2,1,3,3,1,1,2,0,1
MN1002,eursta,0,0,0,0,4,1,0,1,0,3,3,5,2,1,3,3,1,1,2,0,1
MN1002,foxspa,0,0,0,0,0,0,0,0,0,0,3,5,2,1,3,3,1,1,2,0,0
MN1002,haiwoo,0,0,0,1,1,0,0,1,1,1,3,5,2,1,3,3,1,1,2,0,1
MN1002,houfin,1,8,0,6,6,8,0,8,8,2,3,5,2,1,3,3,1,1,2,0,1
MN1002,houspa,40,50,50,50,50,50,50,25,30,20,3,5,2,1,3,3,1,1,2,0,1
MN1002,logshr,0,0,0,0,0,0,0,0,0,0,3,5,2,1,3,3,1,1,2,0,0
MN1002,mallar,0,0,0,0,0,0,0,0,0,0,3,5,2,1,3,3,1,1,2,0,0
MN1002,moudov,0,0,0,0,0,0,0,2,2,2,3,5,2,1,3,3,1,1,2,0,1
MN1002,norcar,2,1,1,1,2,2,1,2,2,1,3,5,2,1,3,3,1,1,2,0,1
MN1002,norfli,1,1,0,1,1,1,0,1,0,2,3,5,2,1,3,3,1,1,2,0,1
MN1002,norshr,0,0,0,0,0,0,0,0,0,0,3,5,2,1,3,3,1,1,2,0,0
MN1002,pilwoo,0,0,0,0,0,0,0,0,0,0,3,5,2,1,3,3,1,1,2,0,0
MN1002,pinsis,1,0,0,0,0,0,0,0,0,0,3,5,2,1,3,3,1,1,2,0,1
MN1002,purfin,0,0,0,0,0,0,0,0,0,0,3,5,2,1,3,3,1,1,2,0,0
MN1002,rebnut,0,0,1,0,0,0,0,0,0,0,3,5,2,1,3,3,1,1,2,0,1
MN1002,rebwoo,1,1,1,1,1,0,1,1,1,2,3,5,2,1,3,3,1,1,2,0,1
MN1002,rewbla,0,0,0,0,0,0,0,0,0,1,3,5,2,1,3,3,1,1,2,0,1
MN1002,rocdov,0,0,0,0,0,0,0,0,0,0,3,5,2,1,3,3,1,1,2,0,0
MN1002,shshaw,1,1,0,1,0,0,0,1,1,0,3,5,2,1,3,3,1,1,2,0,1
MN1002,sonspa,0,0,0,0,0,0,0,0,0,0,3,5,2,1,3,3,1,1,2,0,0
MN1002,tuftit,0,0,0,0,0,0,0,0,0,0,3,5,2,1,3,3,1,1,2,0,0
MN1002,whbnut,3,3,3,2,2,3,2,3,3,2,3,5,2,1,3,3,1,1,2,0,1
MN1002,whtspa,24,0,0,0,0,0,0,0,0,0,3,5,2,1,3,3,1,1,2,0,1
MN1003,amecro,2,2,2,2,0,3,2,1,2,2,3,4,4,4,3,3,2,1,2,1,1
MN1003,amegfi,2,2,0,1,1,2,2,0,0,1,3,4,4,4,3,3,2,1,2,1,1
MN1003,amerob,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,amtspa,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,bkcchi,2,2,1,0,2,2,2,2,2,2,3,4,4,4,3,3,2,1,2,1,1
MN1003,blujay,1,1,1,1,1,1,1,1,2,2,3,4,4,4,3,3,2,1,2,1,1
MN1003,borchi,0,0,0,2,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,1
MN1003,brncre,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,chispa,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,comgra,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,comred,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,coohaw,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,daejun,2,2,0,1,1,3,2,2,10,8,3,4,4,4,3,3,2,1,2,1,1
MN1003,dowwoo,0,0,0,1,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,1
MN1003,eursta,4,3,0,4,4,6,5,3,5,6,3,4,4,4,3,3,2,1,2,1,1
MN1003,foxspa,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,haiwoo,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,houfin,3,3,0,3,3,3,3,3,3,4,3,4,4,4,3,3,2,1,2,1,1
MN1003,houspa,42,38,0,44,52,54,43,44,28,36,3,4,4,4,3,3,2,1,2,1,1
MN1003,logshr,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,mallar,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,moudov,0,0,0,0,0,0,0,0,0,1,3,4,4,4,3,3,2,1,2,1,1
MN1003,norcar,2,2,0,2,2,2,2,2,2,2,3,4,4,4,3,3,2,1,2,1,1
MN1003,norfli,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,norshr,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,pilwoo,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,pinsis,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,purfin,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,rebnut,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,rebwoo,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,rewbla,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,rocdov,4,4,5,6,0,6,3,6,4,4,3,4,4,4,3,3,2,1,2,1,1
MN1003,shshaw,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,sonspa,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,tuftit,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,whbnut,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1003,whtspa,0,0,0,0,0,0,0,0,0,0,3,4,4,4,3,3,2,1,2,1,0
MN1004,amecro,0,0,1,0,0,0,0,0,0,2,2,3,3,1,0,0,0,0,1,0,1
MN1004,amegfi,2,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,1
MN1004,amerob,0,0,0,0,0,0,0,0,0,2,2,3,3,1,0,0,0,0,1,0,1
MN1004,amtspa,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,bkcchi,6,6,6,0,5,5,5,4,3,4,2,3,3,1,0,0,0,0,1,0,1
MN1004,blujay,0,1,2,2,2,0,0,0,2,2,2,3,3,1,0,0,0,0,1,0,1
MN1004,borchi,0,0,0,5,0,5,0,0,0,0,2,3,3,1,0,0,0,0,1,0,1
MN1004,brncre,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,chispa,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,comgra,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,comred,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,coohaw,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,daejun,0,0,0,0,0,0,0,0,5,2,2,3,3,1,0,0,0,0,1,0,1
MN1004,dowwoo,0,0,1,1,1,1,0,0,1,0,2,3,3,1,0,0,0,0,1,0,1
MN1004,eursta,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,foxspa,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,haiwoo,0,0,1,1,1,1,0,1,2,0,2,3,3,1,0,0,0,0,1,0,1
MN1004,houfin,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,houspa,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,logshr,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,mallar,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,moudov,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,norcar,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,norfli,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,norshr,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,pilwoo,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,pinsis,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,purfin,1,0,0,0,0,0,0,0,2,4,2,3,3,1,0,0,0,0,1,0,1
MN1004,rebnut,1,0,0,1,0,0,0,0,1,0,2,3,3,1,0,0,0,0,1,0,1
MN1004,rebwoo,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,rewbla,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,rocdov,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,shshaw,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,sonspa,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,tuftit,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,whbnut,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1004,whtspa,0,0,0,0,0,0,0,0,0,0,2,3,3,1,0,0,0,0,1,0,0
MN1005,amecro,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1005,amegfi,0,3,3,2,9,7,6,3,6,11,4,3,1,1,1,1,1,0,1,0,1
MN1005,amerob,0,0,0,0,0,0,0,0,0,2,4,3,1,1,1,1,1,0,1,0,1
MN1005,amtspa,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1005,bkcchi,5,5,6,5,7,9,5,6,7,5,4,3,1,1,1,1,1,0,1,0,1
MN1005,blujay,4,2,2,2,1,1,0,1,1,1,4,3,1,1,1,1,1,0,1,0,1
MN1005,borchi,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1005,brncre,0,0,1,1,0,0,0,1,0,0,4,3,1,1,1,1,1,0,1,0,1
MN1005,chispa,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1005,comgra,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1005,comred,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1005,coohaw,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1005,daejun,0,0,3,3,3,2,3,1,12,13,4,3,1,1,1,1,1,0,1,0,1
MN1005,dowwoo,0,1,1,1,1,1,1,0,0,1,4,3,1,1,1,1,1,0,1,0,1
MN1005,eursta,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1005,foxspa,0,0,2,2,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,1
MN1005,haiwoo,1,0,1,1,1,1,1,1,0,0,4,3,1,1,1,1,1,0,1,0,1
MN1005,houfin,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1005,houspa,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1005,logshr,1,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,1
MN1005,mallar,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1005,moudov,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1005,norcar,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1005,norfli,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1005,norshr,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1005,pilwoo,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1005,pinsis,0,0,0,1,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,1
MN1005,purfin,0,0,2,0,8,8,12,5,8,9,4,3,1,1,1,1,1,0,1,0,1
MN1005,rebnut,0,0,0,0,0,1,1,0,0,0,4,3,1,1,1,1,1,0,1,0,1
MN1005,rebwoo,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1005,rewbla,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1005,rocdov,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1005,shshaw,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1005,sonspa,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1005,tuftit,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1005,whbnut,4,3,3,4,5,6,5,4,4,4,4,3,1,1,1,1,1,0,1,0,1
MN1005,whtspa,0,0,0,0,0,0,0,0,0,0,4,3,1,1,1,1,1,0,1,0,0
MN1006,amecro,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,amegfi,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,amerob,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,amtspa,3,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,1
MN1006,bkcchi,7,2,6,0,0,19,5,4,0,0,4,3,1,1,0,0,1,0,1,1,1
MN1006,blujay,8,3,10,2,3,24,11,3,8,0,4,3,1,1,0,0,1,0,1,1,1
MN1006,borchi,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,brncre,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,chispa,0,0,30,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,1
MN1006,comgra,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,comred,2,4,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,1
MN1006,coohaw,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,daejun,0,0,0,0,0,0,0,0,0,1,4,3,1,1,0,0,1,0,1,1,1
MN1006,dowwoo,3,7,8,8,5,10,7,13,12,1,4,3,1,1,0,0,1,0,1,1,1
MN1006,eursta,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,foxspa,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,haiwoo,2,5,6,9,3,9,5,7,6,1,4,3,1,1,0,0,1,0,1,1,1
MN1006,houfin,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,houspa,39,35,35,49,0,115,93,14,47,0,4,3,1,1,0,0,1,0,1,1,1
MN1006,logshr,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,mallar,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,moudov,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,norcar,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,norfli,1,0,1,0,1,1,1,1,0,0,4,3,1,1,0,0,1,0,1,1,1
MN1006,norshr,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,pilwoo,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,pinsis,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,purfin,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,rebnut,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,rebwoo,1,3,3,0,4,3,2,0,3,0,4,3,1,1,0,0,1,0,1,1,1
MN1006,rewbla,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,rocdov,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,shshaw,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,sonspa,5,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,1
MN1006,tuftit,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1006,whbnut,15,9,12,4,9,11,6,5,9,0,4,3,1,1,0,0,1,0,1,1,1
MN1006,whtspa,0,0,0,0,0,0,0,0,0,0,4,3,1,1,0,0,1,0,1,1,0
MN1007,amecro,2,0,1,1,1,1,1,1,2,2,2,2,4,4,0,0,1,1,1,0,1
MN1007,amegfi,7,5,5,4,4,4,3,4,5,3,2,2,4,4,0,0,1,1,1,0,1
MN1007,amerob,0,0,0,0,0,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,0
MN1007,amtspa,0,0,0,0,0,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,0
MN1007,bkcchi,7,5,5,5,4,3,3,4,4,4,2,2,4,4,0,0,1,1,1,0,1
MN1007,blujay,1,1,1,2,1,1,0,0,0,0,2,2,4,4,0,0,1,1,1,0,1
MN1007,borchi,0,0,0,0,0,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,0
MN1007,brncre,0,0,0,0,0,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,0
MN1007,chispa,0,0,0,0,0,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,0
MN1007,comgra,0,0,0,0,0,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,0
MN1007,comred,0,0,0,0,0,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,0
MN1007,coohaw,0,0,0,0,0,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,0
MN1007,daejun,6,4,3,4,2,2,1,1,2,2,2,2,4,4,0,0,1,1,1,0,1
MN1007,dowwoo,2,2,2,2,2,2,2,2,2,2,2,2,4,4,0,0,1,1,1,0,1
MN1007,eursta,8,7,7,7,3,0,0,2,3,3,2,2,4,4,0,0,1,1,1,0,1
MN1007,foxspa,0,0,0,0,0,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,0
MN1007,haiwoo,1,1,1,1,1,2,2,2,1,1,2,2,4,4,0,0,1,1,1,0,1
MN1007,houfin,3,6,5,4,3,3,2,4,0,4,2,2,4,4,0,0,1,1,1,0,1
MN1007,houspa,13,10,11,8,12,15,15,9,10,8,2,2,4,4,0,0,1,1,1,0,1
MN1007,logshr,0,0,0,0,0,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,0
MN1007,mallar,0,0,0,0,0,0,0,0,0,2,2,2,4,4,0,0,1,1,1,0,1
MN1007,moudov,2,1,0,0,0,0,0,0,1,1,2,2,4,4,0,0,1,1,1,0,1
MN1007,norcar,6,5,6,4,4,4,4,4,4,3,2,2,4,4,0,0,1,1,1,0,1
MN1007,norfli,0,0,0,0,0,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,0
MN1007,norshr,0,0,0,0,0,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,0
MN1007,pilwoo,0,0,0,0,0,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,0
MN1007,pinsis,0,0,0,0,0,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,0
MN1007,purfin,0,0,0,0,0,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,0
MN1007,rebnut,0,0,0,0,0,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,0
MN1007,rebwoo,0,0,0,0,0,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,0
MN1007,rewbla,0,0,0,0,0,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,0
MN1007,rocdov,0,0,0,0,0,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,0
MN1007,shshaw,0,0,0,0,0,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,0
MN1007,sonspa,0,0,0,0,0,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,0
MN1007,tuftit,0,0,0,0,0,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,0
MN1007,whbnut,3,2,1,1,1,0,0,0,0,0,2,2,4,4,0,0,1,1,1,0,1
MN1007,whtspa,5,3,4,3,4,2,1,1,2,2,2,2,4,4,0,0,1,1,1,0,1
MN1008,amecro,0,0,0,0,0,0,0,0,0,0,3,4,1,1,0,0,0,0,3,1,0
MN1008,amegfi,4,7,4,9,5,12,5,32,3,2,3,4,1,1,0,0,0,0,3,1,1
MN1008,amerob,0,0,0,0,0,0,0,1,0,1,3,4,1,1,0,0,0,0,3,1,1
MN1008,amtspa,0,0,0,0,0,0,0,0,0,0,3,4,1,1,0,0,0,0,3,1,0
MN1008,bkcchi,3,4,2,3,4,3,2,3,3,3,3,4,1,1,0,0,0,0,3,1,1
MN1008,blujay,2,1,0,0,1,1,2,1,0,1,3,4,1,1,0,0,0,0,3,1,1
MN1008,borchi,0,0,0,0,0,0,0,0,0,0,3,4,1,1,0,0,0,0,3,1,0
MN1008,brncre,0,0,0,0,0,1,0,1,1,0,3,4,1,1,0,0,0,0,3,1,1
MN1008,chispa,0,0,0,0,0,0,0,0,0,0,3,4,1,1,0,0,0,0,3,1,0
MN1008,comgra,0,0,0,0,0,0,0,0,0,0,3,4,1,1,0,0,0,0,3,1,0
MN1008,comred,0,0,0,0,0,0,0,0,0,0,3,4,1,1,0,0,0,0,3,1,0
MN1008,coohaw,0,0,0,0,0,0,0,0,0,0,3,4,1,1,0,0,0,0,3,1,0
MN1008,daejun,1,1,0,3,2,1,1,1,4,1,3,4,1,1,0,0,0,0,3,1,1
MN1008,dowwoo,2,4,2,3,5,5,4,4,5,2,3,4,1,1,0,0,0,0,3,1,1
MN1008,eursta,0,0,0,0,0,0,0,0,0,0,3,4,1,1,0,0,0,0,3,1,0
MN1008,foxspa,0,0,0,0,0,0,0,0,0,0,3,4,1,1,0,0,0,0,3,1,0
MN1008,haiwoo,1,0,1,1,2,2,2,2,1,1,3,4,1,1,0,0,0,0,3,1,1
MN1008,houfin,4,4,1,2,0,3,1,0,1,4,3,4,1,1,0,0,0,0,3,1,1
MN1008,houspa,0,0,0,0,0,0,0,0,0,0,3,4,1,1,0,0,0,0,3,1,0
MN1008,logshr,0,0,0,0,0,0,0,0,0,0,3,4,1,1,0,0,0,0,3,1,0
MN1008,mallar,0,0,0,0,0,0,0,0,0,0,3,4,1,1,0,0,0,0,3,1,0
MN1008,moudov,4,11,0,9,3,13,1,9,1,2,3,4,1,1,0,0,0,0,3,1,1
MN1008,norcar,0,1,0,1,1,1,2,2,1,1,3,4,1,1,0,0,0,0,3,1,1
MN1008,norfli,0,0,0,0,0,0,0,0,0,0,3,4,1,1,0,0,0,0,3,1,0
MN1008,norshr,0,0,0,0,0,0,0,0,0,0,3,4,1,1,0,0,0,0,3,1,0
MN1008,pilwoo,0,0,0,0,0,0,0,0,0,0,3,4,1,1,0,0,0,0,3,1,0
MN1008,pinsis,0,0,0,0,0,0,0,0,0,0,3,4,1,1,0,0,0,0,3,1,0
MN1008,purfin,0,0,0,0,0,0,0,7,1,0,3,4,1,1,0,0,0,0,3,1,1
MN1008,rebnut,0,0,0,0,0,0,0,0,0,0,3,4,1,1,0,0,0,0,3,1,0
MN1008,rebwoo,1,0,1,1,1,0,1,1,2,1,3,4,1,1,0,0,0,0,3,1,1
MN1008,rewbla,0,0,0,0,0,0,0,0,0,0,3,4,1,1,0,0,0,0,3,1,0
MN1008,rocdov,0,0,0,0,0,0,0,0,0,0,3,4,1,1,0,0,0,0,3,1,0
MN1008,shshaw,0,0,0,0,0,0,0,0,0,0,3,4,1,1,0,0,0,0,3,1,0
MN1008,sonspa,0,0,0,0,0,0,0,0,0,0,3,4,1,1,0,0,0,0,3,1,0
MN1008,tuftit,0,0,0,0,2,2,0,1,0,0,3,4,1,1,0,0,0,0,3,1,1
MN1008,whbnut,1,1,0,1,1,1,1,2,2,1,3,4,1,1,0,0,0,0,3,1,1
MN1008,whtspa,0,0,0,0,0,0,0,0,0,0,3,4,1,1,0,0,0,0,3,1,0
MN1009,amecro,3,2,0,2,0,0,0,0,0,1,2,4,4,3,0,0,0,3,1,0,1
MN1009,amegfi,6,5,3,3,2,5,3,2,4,2,2,4,4,3,0,0,0,3,1,0,1
MN1009,amerob,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1009,amtspa,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1009,bkcchi,4,5,3,4,3,4,5,3,4,4,2,4,4,3,0,0,0,3,1,0,1
MN1009,blujay,2,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,1
MN1009,borchi,0,0,0,0,0,0,0,0,0,4,2,4,4,3,0,0,0,3,1,0,1
MN1009,brncre,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1009,chispa,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1009,comgra,0,0,0,0,0,0,0,0,0,3,2,4,4,3,0,0,0,3,1,0,1
MN1009,comred,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1009,coohaw,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1009,daejun,4,0,0,5,3,0,4,4,0,4,2,4,4,3,0,0,0,3,1,0,1
MN1009,dowwoo,1,0,0,0,1,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,1
MN1009,eursta,0,0,0,0,0,0,2,0,0,0,2,4,4,3,0,0,0,3,1,0,1
MN1009,foxspa,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1009,haiwoo,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1009,houfin,0,0,0,0,0,0,0,0,0,2,2,4,4,3,0,0,0,3,1,0,1
MN1009,houspa,20,9,10,8,5,20,8,10,8,6,2,4,4,3,0,0,0,3,1,0,1
MN1009,logshr,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1009,mallar,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1009,moudov,2,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,1
MN1009,norcar,4,4,4,3,3,5,7,7,6,5,2,4,4,3,0,0,0,3,1,0,1
MN1009,norfli,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1009,norshr,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1009,pilwoo,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1009,pinsis,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1009,purfin,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1009,rebnut,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1009,rebwoo,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1009,rewbla,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1009,rocdov,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1009,shshaw,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1009,sonspa,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1009,tuftit,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1009,whbnut,0,0,0,0,0,0,2,0,0,0,2,4,4,3,0,0,0,3,1,0,1
MN1009,whtspa,0,0,0,0,0,0,0,0,0,0,2,4,4,3,0,0,0,3,1,0,0
MN1010,amecro,0,0,0,0,0,0,0,0,0,2,3,4,1,1,5,5,5,5,1,1,1
MN1010,amegfi,25,27,13,26,16,16,4,11,21,20,3,4,1,1,5,5,5,5,1,1,1
MN1010,amerob,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,amtspa,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,bkcchi,12,12,12,12,12,12,12,12,12,12,3,4,1,1,5,5,5,5,1,1,1
MN1010,blujay,4,3,5,3,2,3,4,5,3,4,3,4,1,1,5,5,5,5,1,1,1
MN1010,borchi,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,brncre,0,0,0,0,0,0,0,1,0,1,3,4,1,1,5,5,5,5,1,1,1
MN1010,chispa,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,comgra,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,comred,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,coohaw,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,daejun,2,0,1,0,0,0,0,0,0,3,3,4,1,1,5,5,5,5,1,1,1
MN1010,dowwoo,2,3,2,2,2,2,1,1,2,2,3,4,1,1,5,5,5,5,1,1,1
MN1010,eursta,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,foxspa,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,haiwoo,1,2,3,1,1,1,1,1,1,0,3,4,1,1,5,5,5,5,1,1,1
MN1010,houfin,1,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,1
MN1010,houspa,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,logshr,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,mallar,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,moudov,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,norcar,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,norfli,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,norshr,1,0,0,0,0,0,0,1,0,0,3,4,1,1,5,5,5,5,1,1,1
MN1010,pilwoo,1,3,2,3,1,2,2,2,2,0,3,4,1,1,5,5,5,5,1,1,1
MN1010,pinsis,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,purfin,1,1,4,4,3,12,4,2,3,5,3,4,1,1,5,5,5,5,1,1,1
MN1010,rebnut,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,rebwoo,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,rewbla,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,rocdov,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,shshaw,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,sonspa,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,tuftit,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
MN1010,whbnut,2,2,3,2,2,2,2,2,2,1,3,4,1,1,5,5,5,5,1,1,1
MN1010,whtspa,0,0,0,0,0,0,0,0,0,0,3,4,1,1,5,5,5,5,1,1,0
;;;;


/***************************************************************/
/* Create POWERUSE Data Set                                    */
/* Used in Examples 2.4, 2.5, 2.6, 6.10                        */
/***************************************************************/
data poweruse;
  input type $3. +1 service $4. jan feb mar apr may jun;
datalines;
com area 6526 11999 17533 10221 17218 8857
com fld  10911 12648 15502 9120 8624 18338
com gen  1203 641 728 1039 1156 782
com op   15062 15635 9509 11717 11456 12461
com oth  1390 1672 1638 1282 1654 1915
com spc  111 85 121 109 125 103
com wtr  160 168 130 187 101 101
res area 118 116 91 92 95 137
res fld  96 89 75 87 75 82
res gen  22281 21505 22556 22784 25977 25371
res op   1152 1362 698 1047 534 1492
res oth  286 238 109 33 158 465
res spc  8280 10984 10111 13234 13723 11072
res wtr  9589 10625 14160 18130 8592 7654
;;;;


/***************************************************************/
/* Create LIPIDS Data Set                                      */
/* Used in Examples 2.7, 3.3, 6.4, 6.8, 6.9                    */
/***************************************************************/
data lipids;
  input studyid gender $ testperiod :$4. chol hdl tri;
datalines;
1001 F Pre  156  48 134
1001 F Post 150  50 127
1002 F Pre  151  50 102
1002 F Post 139  54  81
1003 F Pre  165  51 114
1003 F Post 149  51 101
1004 F Pre  158  51 150
1004 F Post 143  53 124
1005 M Pre  296  47 129
1005 M Post 272  51 116
1006 M Pre  155  31 145
1006 M Post 152  33 136
1007 M Pre  250  55 149
1007 M Post 231  60 141
1008 M Pre  264  43  55
1008 M Post 195  44  47
1009 F Pre  187  71  57
1009 F Post 174  69  72
1010 F Pre  161  64  50
1010 F Post 155  66  43
1011 F Pre  164  72  43
1011 F Post 149  73  32
1012 F Pre  160  66  65
1012 F Post 168  61  56
1013 M Pre  183  51 182
1013 M Post 192  49 170
1014 M Pre  256  43 100
1014 M Post 235  43  83
1015 M Pre  235  43 151
1015 M Post 216  44 141
1016 M Pre  238  36 198
1016 M Post 207  36 174
1017 M Pre  215  50  68
1017 M Post 205  52  59
1018 M Pre  190  31 252
1018 M Post 164  32 249
1019 M Pre  168  52  95
1019 M Post 172  44  90
1020 M Pre  219  57  78
1020 M Post 207  58  63
1021 M Pre  203  28 301
1021 M Post 169  28 232
1022 M Pre  215  51 325
1022 M Post 205  52 285
1023 M Pre  222  32 125
1023 M Post 210  32 122
1024 F Pre  196  61  70
1024 F Post 186  62  69
1025 F Pre  216  51  64
1025 F Post 171  54  59
1026 F Pre  195  60  61
1026 F Post 195  60  61
;;;;


/***************************************************************/
/* Create TOWNSURVEY Data Set                                  */
/* Used in Examples 2.8, 3.9                                   */
/***************************************************************/
data townsurvey;
  infile datalines truncover dsd;
  length area kids seniors $ 1 comments $ 100;
  input surveyid area $ yrslived kids $ seniors $ q1-q9 comments;

datalines;
1,N,1,N,N,4,4,,4,2,2,3,4,4,
2,P,1,N,N,5,4,2,2,4,4,4,4,2,
3,T,2,N,N,4,2,1,2,3,4,4,4,5,
4,L,1,N,N,,5,4,4,1,4,4,4,2,
5,T,3,N,N,2,4,2,4,5,4,,4,,
6,T,2,N,N,3,5,3,4,3,4,4,4,3,
7,T,2,Y,N,2,1,1,3,3,3,4,2,3,"Please add more soccer fields"
8,N,2,N,N,2,4,4,3,3,,5,4,2,
9,T,3,N,Y,4,2,1,2,3,4,4,,4,"Enforce the dog barking ordinance"
10,P,3,Y,N,4,4,4,3,2,,5,2,2,"Loved the community picnic"
11,P,3,N,N,4,2,2,3,,4,5,4,,
12,T,2,Y,N,3,3,1,2,2,4,3,5,5,
13,T,2,N,N,2,4,4,4,4,3,4,2,4,
14,T,2,N,N,4,1,,5,3,5,5,4,4,
15,T,1,N,N,,4,2,,3,3,5,5,4,"Partner with neighboring communities to build a public library"
16,L,1,N,N,4,3,3,5,2,4,3,2,1,
17,T,1,N,N,2,4,2,4,4,2,5,,4,
18,T,2,Y,N,5,3,3,,5,5,5,4,3,
19,P,2,N,N,3,4,4,4,3,3,4,4,2,
20,T,1,N,N,2,3,2,5,2,4,,2,4,
21,T,3,N,N,,4,2,3,4,2,4,5,5,
22,N,1,Y,N,,4,3,3,2,,4,2,4,
23,N,2,N,Y,4,,1,2,,,4,4,5,"Replace wornout street signs"
24,T,1,Y,N,3,4,4,4,3,4,3,4,2,
25,P,3,Y,N,2,2,4,4,2,2,4,5,,
26,N,3,Y,N,2,4,4,2,3,,4,,4,"Advertise the brush pickup earlier than two weeks before the pickup"
27,T,3,N,N,3,4,1,2,2,4,,5,4,
28,T,2,N,N,2,4,,2,2,,4,5,4,
29,P,1,N,N,4,4,2,4,3,,5,4,3,
30,T,1,N,N,,4,3,2,2,3,2,4,2,
31,N,2,N,N,3,4,2,,2,4,5,4,4,
32,P,1,Y,N,3,2,3,,,4,,,3,
33,T,3,N,N,4,2,1,2,2,4,5,4,4,
34,P,1,Y,N,2,3,3,3,2,2,5,5,2,
35,T,1,N,N,5,2,2,,5,2,3,3,5,
36,T,2,N,N,4,1,3,4,,5,5,4,,
37,T,3,N,N,,3,2,3,2,2,5,4,2,
38,N,1,N,N,2,3,2,4,5,5,4,5,,
39,T,1,N,N,3,,4,2,3,4,4,5,3,
40,T,1,Y,N,3,2,2,3,3,4,4,2,4,
41,N,3,N,N,,4,,4,5,4,,,2,
42,T,3,N,N,,4,2,2,4,4,3,5,3,
43,P,3,N,N,2,5,2,2,1,5,,2,4,
44,T,1,Y,Y,3,5,4,,2,5,4,5,3,
45,T,3,Y,N,4,,1,4,2,3,4,4,3,
46,N,1,N,N,3,2,3,2,,3,5,3,3,
47,N,3,N,N,,3,2,4,4,2,4,4,5,
48,T,2,N,N,2,,5,2,3,4,4,5,3,
49,P,2,N,N,3,3,2,,,4,2,2,2,
50,T,1,N,N,4,3,3,4,4,4,,4,3,
51,T,3,N,N,3,,1,4,2,3,5,4,,
52,P,1,Y,N,4,4,4,3,4,3,3,,5,
53,P,2,N,Y,3,3,2,4,2,3,5,5,4,
54,T,3,N,N,,,3,3,1,3,4,4,,
55,L,3,Y,N,4,,2,,4,2,5,5,3,"We loved the canoe derby"
56,T,1,Y,N,2,4,4,5,2,3,4,2,5,
57,T,3,N,N,3,4,1,4,,5,4,4,3,
58,T,1,Y,N,2,4,4,2,2,4,3,5,3,
59,P,3,N,N,3,3,1,4,3,3,,5,5,
60,T,1,N,N,3,4,3,,2,3,4,4,2,
61,N,1,N,N,3,,2,,2,4,4,2,4,
62,N,1,N,N,3,4,4,3,2,5,4,,2,
63,T,2,N,N,4,5,2,4,2,4,4,4,4,
64,N,2,N,N,4,3,3,4,2,5,5,4,3,
65,P,1,N,Y,3,5,1,2,4,3,,5,4,
66,T,2,Y,N,4,4,3,3,4,2,5,4,2,
67,P,1,N,N,2,4,2,,1,3,4,,2,
68,N,1,Y,N,,4,4,2,4,4,,5,3,
69,T,2,N,N,4,4,1,3,3,4,2,,4,
70,T,1,N,N,,2,3,2,2,3,5,5,3,
71,T,3,N,N,3,,1,4,3,5,3,5,4,
72,T,1,Y,N,3,3,4,4,2,4,4,3,3,
73,T,2,Y,N,2,4,2,3,4,2,4,4,4,
74,P,1,N,Y,,4,3,,3,2,,,,
75,T,1,N,N,2,5,1,4,4,2,5,5,,
76,T,1,N,N,4,5,3,4,2,3,4,4,3,
77,T,1,N,N,2,4,,2,3,3,5,4,4,
78,T,3,N,N,3,3,2,3,,4,4,4,2,
79,P,1,Y,N,4,4,2,2,4,,4,4,4,
80,P,1,N,N,4,2,4,,3,3,2,2,4,
81,T,1,N,N,3,4,1,,2,2,4,5,4,
82,N,3,Y,N,3,3,3,2,4,,5,3,3,
83,T,1,N,N,2,2,1,4,2,1,4,5,4,
84,L,2,N,N,2,,4,2,3,2,3,5,2,
85,T,1,N,Y,4,4,2,2,2,3,4,4,2,
86,N,2,N,N,,5,,,2,2,,,4,
87,T,2,N,N,,2,2,4,4,,,4,1,
88,T,1,N,N,,2,2,4,,4,4,2,,
89,N,3,N,N,4,4,3,4,4,4,4,5,4,
90,T,1,N,N,3,4,4,4,3,4,5,3,4,
91,L,3,N,N,4,4,3,4,3,4,,4,3,
92,P,2,N,N,,3,4,3,2,3,2,5,2,
93,T,1,N,N,2,5,2,,,3,5,4,4,"City office is never open when I'm off work. Please expand the hours."
94,N,1,N,N,4,4,3,4,4,4,,3,2,
95,P,3,N,Y,2,3,2,3,,3,4,4,5,
96,T,1,N,N,2,4,3,4,4,,5,5,4,
97,N,3,N,N,4,4,2,4,4,,4,4,5,
98,P,2,N,N,5,3,2,2,2,4,2,,3,
99,T,1,N,N,3,5,2,,5,,,4,,
100,P,1,N,N,4,4,3,5,4,3,,3,4,
101,P,2,Y,N,2,4,,,5,2,5,4,5,"Stop all outdoor burning because it aggravates my asthma"
102,T,2,N,Y,2,4,,2,4,4,2,5,3,
103,N,2,Y,N,,2,1,2,2,4,4,4,4,
104,T,1,Y,Y,4,4,2,2,3,,,,,"Plow the snow early and plow often"
105,T,1,N,N,4,3,4,,2,5,5,4,,
106,N,3,N,N,2,,2,2,3,3,3,5,,
107,T,2,Y,Y,3,4,4,3,3,,4,3,3,
108,T,1,N,N,4,3,,4,2,5,,4,4,
109,P,1,Y,N,3,4,3,5,2,3,2,,3,
110,T,1,N,N,3,5,2,,3,5,5,5,4,
111,T,1,N,N,4,2,2,4,4,4,4,4,2,
112,N,1,N,N,5,4,3,,4,2,,4,4,
113,P,1,N,N,3,2,1,2,2,,2,2,4,
114,T,1,N,N,3,4,2,2,2,2,4,,4,
115,N,1,N,N,2,,2,3,2,2,4,1,2,
116,T,1,N,N,4,5,5,4,3,2,2,5,2,
117,T,2,N,Y,2,4,2,2,4,3,5,3,4,
118,N,2,N,N,2,3,,,2,4,5,4,,
119,P,3,N,N,3,2,2,4,5,4,4,4,2,
120,T,1,N,N,4,3,2,4,,2,,5,4,
121,L,2,Y,N,2,3,5,3,2,4,5,4,2,"Too much paperwork to just remodel a kitchen"
122,N,2,N,N,,,2,4,3,4,4,4,,
123,L,3,N,N,,3,4,,4,4,3,,4,
124,T,2,N,N,1,2,2,,2,3,5,5,4,
125,N,3,N,N,2,,,4,2,,4,4,2,
126,T,3,Y,N,,2,1,3,3,4,5,5,2,
127,N,1,N,N,3,4,2,3,,,3,5,4,
128,L,2,N,Y,3,4,4,4,3,4,4,3,,
129,T,1,N,N,4,,4,4,3,3,2,4,5,
130,P,3,N,N,3,,3,3,4,,,,,
131,T,3,N,N,2,4,2,4,2,4,4,,2,
132,T,2,N,N,3,4,1,3,2,4,3,3,4,
133,T,1,N,N,5,,3,3,5,5,4,4,,
134,N,2,N,N,,3,1,3,2,4,4,5,2,
135,T,3,N,N,2,,4,4,4,3,5,4,3,
136,N,1,N,N,5,,2,4,2,2,3,5,3,
137,P,1,N,N,4,3,2,3,3,3,4,4,4,
138,T,3,N,N,5,,2,2,,4,5,,4,
139,L,1,N,N,2,2,2,5,3,3,3,2,3,
140,N,1,N,N,4,4,2,3,3,2,4,,4,
141,T,3,N,Y,2,4,3,4,3,4,,5,4,
142,N,1,N,N,2,2,2,2,2,4,2,4,4,
143,N,1,N,N,4,4,2,5,3,4,4,4,,
144,T,1,Y,N,4,4,1,2,3,4,4,4,,"More soccer fields now!!!"
145,N,3,N,N,3,4,4,5,2,4,4,4,4,
146,N,2,N,N,3,2,4,2,4,4,4,4,5,
147,T,3,N,N,3,,,2,3,3,4,,4,
148,P,1,N,N,4,4,4,3,2,4,5,4,5,
149,T,2,N,N,4,4,5,3,4,2,,4,5,
150,T,1,Y,N,2,,1,3,3,4,2,4,3,
151,T,1,N,N,,4,3,2,3,3,,3,3,
152,P,1,N,N,2,3,1,,,3,,,2,
153,T,3,N,N,2,4,2,4,4,,3,3,2,
154,N,2,N,N,2,2,4,5,2,3,,5,4,
155,N,1,N,N,3,3,2,4,2,3,4,4,5,
156,L,2,N,N,5,4,2,4,,3,4,4,,
157,N,1,N,N,2,4,2,4,3,,,4,3,
158,N,3,N,Y,4,3,4,3,,2,4,4,,"Change the yield sign to a stop sign at W. Lake and Hilltop"
159,T,1,Y,N,5,,2,4,3,,4,,,
160,T,1,N,N,2,2,,,,,4,5,2,
161,T,2,N,N,2,,1,3,3,,5,,,
162,T,1,N,N,3,5,2,4,4,4,4,4,4,
163,L,2,N,N,4,3,4,5,2,4,4,,2,
164,T,1,N,Y,3,4,1,2,2,3,,4,2,
165,T,1,N,N,5,2,2,4,3,4,4,4,4,
166,N,3,N,N,4,4,3,3,4,4,4,4,3,
167,L,1,N,N,2,2,1,4,,3,4,4,2,
168,T,2,Y,N,2,2,5,4,4,4,3,3,2,"Add rink lights for lacrosse and hockey at night"
169,T,2,N,N,,3,2,3,4,,5,4,2,
170,P,1,Y,N,4,4,2,3,5,5,,4,,
171,T,3,N,N,4,2,2,4,3,4,4,5,3,
172,L,1,Y,N,3,2,2,4,4,4,3,5,3,
173,P,2,N,Y,2,,4,4,,2,5,4,2,
174,T,3,N,N,2,2,2,4,2,4,4,3,4,
175,N,1,Y,N,2,5,3,5,4,2,4,5,3,
176,N,1,N,N,2,2,1,4,3,3,5,5,,
177,L,1,Y,N,4,1,3,4,2,,4,4,4,
178,T,1,N,N,,2,4,4,4,2,5,2,2,
179,P,2,N,N,4,5,4,3,3,2,,5,,
180,T,1,N,N,3,3,2,2,3,4,2,5,,
181,P,1,N,N,2,3,3,4,5,,5,3,3,
182,T,2,N,Y,2,4,2,3,2,3,3,4,3,
183,L,3,N,N,,,3,4,3,3,5,5,2,"Enforce the beach curfew"
184,T,1,N,N,3,,1,5,2,4,4,,2,
185,P,3,N,Y,4,2,4,3,,4,,5,3,
186,T,1,Y,N,5,3,2,4,3,4,4,4,4,
187,T,2,Y,N,2,4,2,2,3,5,4,2,4,"Salt the roads faster after each snowfall"
188,P,1,N,N,2,4,3,2,3,3,5,5,,
189,T,2,N,N,2,2,2,3,2,2,2,5,3,
190,T,1,N,N,,2,2,2,2,4,4,4,3,
191,N,1,N,N,4,4,3,4,2,,,4,,
192,T,1,N,N,3,,1,3,,5,5,2,2,
193,N,2,N,N,3,3,4,4,4,2,3,4,4,
194,T,3,N,N,2,3,4,4,3,5,5,5,3,
195,T,1,N,N,3,3,4,4,4,4,5,4,4,
196,P,1,N,Y,4,4,2,3,3,,5,4,3,
197,T,2,N,N,4,5,4,3,2,2,,,5,
198,T,2,N,N,3,4,2,4,1,3,4,4,,
199,P,2,N,N,2,,3,4,5,3,4,4,3,
200,N,1,Y,N,2,3,,5,2,2,2,3,4,"More organized sports for the kids"
201,T,1,N,N,2,5,2,4,2,3,4,5,3,
202,T,3,N,N,3,2,4,4,4,4,,4,2,
203,P,2,N,N,2,4,2,2,3,3,5,,2,
204,T,2,N,Y,4,4,2,2,3,2,2,2,3,
205,T,1,N,N,4,4,3,4,2,4,4,5,4,
206,N,3,N,N,3,2,2,,4,,4,5,3,
207,T,1,N,N,3,4,4,4,4,4,,4,4,
208,N,1,N,N,4,4,2,5,2,3,5,,,
209,P,1,N,Y,2,4,3,4,3,,2,5,3,
210,L,3,N,N,3,2,1,4,4,4,4,4,3,
211,T,1,N,N,2,,4,4,3,3,4,4,2,
212,P,1,N,N,5,2,2,4,3,3,4,4,4,
213,T,1,N,N,4,3,2,2,3,4,4,5,2,
214,T,3,Y,N,4,2,1,4,,,5,4,4,
215,P,1,N,N,,2,1,,3,3,4,4,3,
216,T,1,N,N,,4,5,4,1,3,5,2,2,
217,T,2,Y,Y,2,5,1,2,1,2,4,,2,
218,N,1,N,N,3,4,4,,3,4,4,4,4,
219,T,1,N,Y,4,,1,2,4,3,5,3,2,
220,L,1,Y,N,4,3,3,3,4,,2,4,3,
221,P,1,Y,N,,4,4,4,5,3,4,5,3,
222,T,2,N,N,4,3,,2,3,3,5,4,4,
223,P,1,Y,N,4,3,,4,5,3,2,4,4,
224,N,1,N,N,,4,4,3,2,5,4,4,4,
225,L,3,N,N,,4,4,4,2,,5,4,2,
226,T,2,Y,N,2,3,2,3,,,2,3,3,
227,P,2,N,N,4,5,2,3,4,3,4,4,4,
228,T,2,N,N,3,4,3,4,2,3,3,5,2,
229,T,3,N,N,2,3,2,4,2,3,,5,3,
230,N,1,N,N,4,4,,2,2,4,2,4,,
231,T,2,N,N,,4,1,4,2,2,4,2,3,
232,P,2,N,N,5,2,4,2,4,4,4,4,3,
233,T,1,N,N,2,2,1,3,3,3,5,5,2,
234,T,2,N,N,2,4,4,4,5,4,,4,2,
235,N,1,Y,N,2,2,1,,1,2,4,3,5,
236,P,1,N,N,2,4,4,,4,3,3,4,5,
237,T,1,N,N,3,5,2,3,5,4,4,5,,
238,N,3,N,N,5,3,1,3,1,2,5,3,3,
239,P,2,N,N,4,,4,4,,3,4,4,4,
240,T,1,N,N,3,2,2,2,4,3,2,4,3,
241,P,3,Y,N,,4,4,,2,3,4,,4,
242,P,2,N,N,2,4,2,5,5,,5,,3,
243,T,3,N,N,4,4,3,4,,4,4,4,3,
244,T,2,N,N,,4,2,4,,,4,4,4,
245,T,1,Y,N,2,,1,4,3,,4,4,2,
246,T,1,Y,N,4,4,4,,2,5,4,4,4,
247,L,1,Y,N,,5,2,4,2,4,3,2,3,
248,T,2,N,Y,4,,2,,2,4,4,4,4,
249,T,2,N,N,3,4,3,3,2,4,4,,,
250,N,1,N,N,2,2,1,4,4,3,4,4,5,
251,N,2,N,N,2,3,,5,4,4,,4,4,
252,T,1,N,N,4,4,1,3,3,4,,4,4,
253,N,1,N,N,4,,3,5,2,3,4,3,3,
254,P,3,N,N,2,3,2,4,,4,5,5,4,
255,T,1,N,N,3,3,2,4,,3,4,3,3,
256,T,2,N,N,5,2,3,3,2,3,4,5,2,
257,N,1,N,N,4,4,1,4,2,3,4,2,2,
258,T,2,N,N,4,2,3,2,2,,3,5,,
259,L,1,N,N,2,4,,4,5,4,5,2,3,
260,P,1,N,N,3,4,2,4,3,4,3,5,4,
261,T,2,N,N,3,,2,5,3,3,5,4,3,
262,T,1,Y,N,,,3,5,3,4,4,4,,
263,L,1,Y,N,4,3,2,4,2,3,3,2,2,
264,T,1,N,N,3,4,,5,4,5,4,5,4,
265,T,1,N,N,2,4,3,4,4,3,5,,2,
266,T,2,Y,N,3,,1,2,2,,,4,2,
267,T,2,N,N,3,4,2,,4,4,4,5,5,
268,T,1,N,Y,4,4,4,3,4,4,5,4,3,
269,T,2,N,N,2,3,2,5,2,4,2,,5,
270,T,1,N,N,4,5,2,5,3,3,5,3,3,
271,P,2,N,N,2,3,1,4,4,4,5,4,,
272,L,1,N,N,4,3,3,4,3,4,4,4,2,
273,L,1,N,N,,,2,4,4,2,2,4,4,
274,L,3,N,N,4,,2,3,1,5,5,4,4,
275,N,1,N,N,2,4,2,4,2,2,4,4,2,
276,T,2,N,N,2,4,3,3,3,3,5,5,3,
277,L,2,N,N,4,4,1,,4,2,3,4,4,
278,L,2,N,N,4,4,4,2,3,2,,5,4,
279,T,1,N,N,5,2,2,4,3,4,4,5,2,
280,N,1,N,N,3,4,3,4,3,4,4,5,5,
281,N,3,N,N,3,4,2,5,1,,4,4,4,
282,T,1,Y,N,4,,4,4,4,5,4,2,4,
283,N,2,N,N,3,2,4,4,2,4,4,,5,
284,T,1,N,N,4,,2,2,3,4,4,,4,
285,T,1,N,Y,2,3,1,3,4,4,3,4,2,
286,P,3,N,N,4,,3,3,2,,4,5,2,
287,N,2,Y,Y,3,2,1,4,4,2,,5,5,"We want snowmobile trails"
288,T,2,N,N,2,4,5,2,2,2,4,,2,
289,T,3,Y,N,3,,1,3,5,3,4,4,4,
290,N,1,N,N,,3,3,4,2,2,4,3,3,
291,T,1,N,N,4,4,1,5,4,4,,5,1,
292,L,1,N,N,4,3,3,3,3,3,4,2,4,
293,P,2,N,N,2,3,,,1,4,4,5,3,
294,T,2,N,N,2,2,2,3,2,4,4,4,4,
295,P,3,N,N,3,4,4,2,,4,5,5,4,
296,P,2,N,N,3,,2,4,2,4,5,4,4,
297,T,2,N,N,2,3,3,4,3,2,,2,3,
298,N,1,N,N,4,3,,,3,4,4,4,4,
299,P,3,N,N,3,5,3,,3,4,5,,4,
300,T,1,N,Y,5,3,2,4,3,5,3,4,5,"Too many potholes"
301,T,3,N,N,4,4,2,3,2,4,4,5,5,
302,N,3,N,N,2,5,4,2,3,3,,4,2,
303,T,3,N,N,4,3,2,4,3,3,4,4,5,
304,P,1,N,N,4,4,1,3,2,4,4,2,,
305,T,1,N,N,,4,3,3,4,2,4,4,4,
306,T,1,N,Y,4,3,2,,1,5,2,5,2,
307,P,2,N,Y,2,3,3,2,2,4,4,4,5,
308,P,1,N,N,2,2,2,3,3,4,5,5,,
309,T,3,N,N,4,,3,3,2,4,3,4,4,
310,N,1,N,N,4,3,2,4,2,4,4,4,,
311,P,2,N,N,3,4,4,,4,5,4,4,2,
312,T,1,N,N,4,5,4,,3,,2,3,4,
313,N,2,N,N,2,2,4,3,2,4,4,4,2,
314,P,1,Y,N,3,3,2,4,2,2,5,5,,
315,T,1,N,N,3,3,4,4,4,4,3,,2,
316,N,2,N,N,3,5,1,2,4,3,5,2,,
317,T,2,Y,N,5,4,4,2,2,3,5,,3,
318,T,1,N,Y,3,4,2,4,2,4,4,4,4,
319,P,2,Y,N,3,2,,4,2,3,3,3,3,
320,T,1,N,N,2,2,2,,2,4,5,5,3,
321,T,3,Y,N,4,3,2,2,4,4,4,3,2,
322,N,1,Y,N,4,3,2,2,2,3,5,5,4,
323,N,3,N,N,3,4,,,3,4,2,2,3,
324,T,2,N,N,1,4,1,2,3,4,,4,4,
325,P,1,N,N,3,3,3,,,2,3,1,4,
326,N,2,N,N,4,2,2,5,4,4,4,3,4,
327,T,1,N,N,2,3,,5,2,,4,4,4,
328,T,2,N,N,2,4,3,3,2,4,5,4,4,
329,T,2,N,N,2,4,2,4,4,,3,4,3,
330,T,3,Y,N,2,2,2,4,2,3,5,5,2,
331,T,1,N,N,,4,2,,3,5,5,5,3,
332,T,1,N,N,4,,4,5,3,2,2,3,,
333,T,2,N,N,3,4,,2,3,4,4,5,,
334,P,2,N,N,3,3,1,4,2,3,5,4,4,
335,L,1,N,N,4,4,5,4,,4,3,2,2,"Empty the garbage cans at the parks more frequently"
336,T,1,N,N,2,4,,3,3,,4,,3,
337,N,3,Y,N,,,4,4,4,4,4,4,4,
338,N,2,N,N,3,3,4,5,2,4,2,3,5,
339,T,2,N,N,4,4,2,4,2,4,4,4,2,
340,N,1,N,N,2,4,4,4,2,4,4,4,,
341,T,2,N,N,,4,,4,5,2,,4,4,
342,T,3,N,N,4,4,2,,1,3,,4,4,
343,N,2,N,Y,4,3,,2,2,4,5,5,2,
344,T,1,N,Y,3,4,,,3,,,5,,
345,T,3,Y,N,3,2,3,2,4,2,5,5,4,"Our kids love the new playground equipment"
346,P,1,Y,N,4,2,1,4,2,2,4,2,3,
347,P,3,N,N,2,4,4,2,3,3,5,4,2,
348,T,2,N,N,2,3,2,4,2,4,3,5,4,
349,P,2,N,N,,4,1,2,4,2,4,,,"Enforce the leash laws. Add an off leash dog park."
350,P,3,N,N,4,4,3,4,4,4,,4,,
351,T,1,N,N,2,2,4,2,2,4,4,4,4,
352,N,1,N,N,2,3,,3,2,3,4,,2,
353,T,1,N,N,3,,,3,2,4,,3,5,
354,T,2,N,N,3,4,1,4,4,2,4,5,4,
355,N,3,N,N,4,4,4,4,2,2,3,5,4,
356,L,2,Y,N,2,4,2,4,2,4,4,2,4,
357,T,2,N,Y,4,2,,4,3,2,5,,3,
358,T,2,N,N,3,3,2,,3,4,2,,2,
359,L,1,N,N,4,4,5,3,,2,5,4,3,
360,T,1,N,N,2,4,1,4,4,2,5,4,3,
361,T,1,N,N,,2,4,3,,3,3,4,3,
362,P,3,N,N,4,,2,5,4,4,,4,2,
363,T,3,N,N,2,2,3,2,2,4,4,5,4,
364,L,1,N,N,4,2,2,4,3,4,5,5,,
365,P,1,N,N,,5,4,4,2,4,4,2,4,
366,T,2,N,N,,,2,3,2,3,4,4,,
367,P,3,N,N,2,3,3,3,1,3,2,5,2,
368,T,1,N,N,4,3,1,4,3,3,,2,3,
369,T,1,N,N,4,4,3,4,,5,3,,3,
370,N,3,N,N,,4,2,4,2,4,,4,4,
371,N,2,N,N,,,5,,2,3,4,2,3,
372,T,1,N,N,3,3,1,3,3,,,4,4,
373,P,3,N,N,3,4,3,4,,4,5,5,3,
374,N,3,Y,N,4,4,1,4,,,,4,5,
375,T,3,N,N,2,3,2,2,4,2,5,3,3,
376,P,1,Y,N,3,5,4,3,,2,4,,4,
377,N,3,N,N,4,4,2,4,,4,4,5,4,
378,T,1,N,N,5,4,4,3,5,,5,3,5,
379,T,1,N,N,3,4,,4,2,4,4,4,4,
380,L,1,N,N,,4,3,2,3,4,,4,3,
381,T,2,N,N,2,2,2,4,3,3,5,4,4,
382,N,1,N,N,3,3,3,4,2,5,,2,4,
383,N,1,Y,N,4,3,2,3,2,,4,5,4,
384,T,1,N,N,4,3,2,5,4,2,4,2,2,
385,L,1,N,N,2,4,2,4,5,2,4,5,4,
386,T,3,Y,N,3,2,1,3,2,5,4,4,4,
387,L,2,N,N,5,2,3,4,1,5,4,5,3,
388,N,1,Y,N,2,4,1,3,1,3,5,4,4,
389,T,1,N,N,2,5,3,4,4,3,,4,4,
390,T,1,N,N,4,4,4,4,2,4,5,5,,
391,N,3,Y,N,3,4,2,4,,3,3,,4,
392,N,2,N,N,4,4,2,4,5,3,5,3,3,
393,T,2,N,N,4,4,4,,2,2,4,4,3,
394,P,2,N,N,2,4,1,4,4,3,4,5,3,
395,P,1,N,N,,4,4,,2,4,2,5,4,
396,T,1,N,N,2,4,1,4,4,,5,3,3,
397,P,1,Y,N,3,4,,,2,4,4,4,4,
398,N,3,N,N,3,2,2,3,,2,4,5,2,
399,T,2,N,N,3,,3,3,4,4,4,4,4,
400,T,1,Y,N,3,4,1,,,4,4,3,2,
401,N,1,N,N,5,3,4,2,3,3,4,5,2,
402,T,2,Y,N,4,,4,2,4,4,2,4,3,
403,P,3,N,N,3,4,3,2,2,3,4,3,4,
404,T,1,N,N,3,5,2,,5,3,4,4,4,
405,T,3,Y,N,,,4,4,2,2,5,4,2,
406,P,2,N,N,3,3,4,4,3,3,,4,3,
407,T,2,N,N,4,4,1,,,4,1,4,4,
408,T,1,N,N,3,2,2,3,4,3,4,5,3,
409,P,1,N,N,3,,1,4,3,4,4,3,4,
410,N,1,N,N,3,4,2,4,4,2,4,5,4,
411,T,2,N,N,4,4,2,3,3,3,5,,3,
412,T,2,N,N,,4,5,4,2,2,,5,,
413,N,1,N,N,3,2,1,4,1,3,,2,5,
414,T,3,Y,N,4,,3,4,,3,5,5,4,
415,N,1,N,N,2,2,1,4,2,3,3,4,4,
416,N,2,Y,N,4,4,3,2,4,3,5,4,4,
417,T,2,N,N,4,4,,2,5,2,,5,4,
418,N,3,N,N,4,2,3,3,3,3,3,5,4,
419,T,1,N,N,2,4,2,3,4,4,5,5,3,
420,T,1,N,N,4,2,3,3,4,4,4,4,2,
421,T,1,N,N,,4,2,2,,,4,2,,
422,N,3,Y,N,5,4,3,3,5,4,4,5,3,
423,T,2,Y,N,2,,2,3,4,3,,3,2,
424,N,2,N,N,5,3,5,2,3,5,3,,3,
425,T,3,N,Y,3,2,4,,3,2,5,5,2,
426,T,3,N,N,5,,5,3,2,2,5,4,3,
427,P,3,N,N,3,4,1,4,2,,3,4,4,
428,P,1,N,N,4,2,,3,4,3,4,3,3,
429,T,3,N,N,2,3,2,3,5,4,,4,3,
430,N,1,N,N,2,4,2,3,2,2,4,4,3,
431,P,3,Y,N,2,4,2,4,4,,5,4,4,
432,L,1,Y,N,2,,1,3,1,3,4,5,4,
433,T,2,N,N,4,4,3,2,2,4,2,4,4,
434,P,2,N,Y,5,2,2,3,4,,4,5,3,
435,T,1,N,Y,2,,1,3,3,,5,,4,
436,T,1,Y,N,2,2,3,3,3,4,3,5,2,
437,T,2,N,N,4,4,2,,4,4,5,2,,
438,L,1,N,N,,4,2,2,3,3,5,5,4,
439,P,2,N,Y,2,,4,4,2,5,3,5,3,
440,N,1,N,N,1,2,2,3,5,4,5,2,3,
441,T,1,N,N,4,,3,2,1,4,3,4,4,
442,N,1,N,N,4,4,,2,4,2,4,5,4,
443,P,2,N,N,,,2,3,2,2,5,4,2,
444,T,1,N,N,2,,,4,3,4,4,5,4,
445,P,3,Y,N,4,4,2,4,3,4,4,,4,
446,N,3,N,N,3,,2,4,,4,4,2,4,
447,T,2,N,N,4,4,5,4,4,4,4,4,4,
448,P,1,N,N,,4,2,4,4,3,3,5,3,
449,T,1,N,N,2,2,2,3,3,4,5,2,4,
450,T,1,N,N,1,2,2,2,4,3,4,5,3,
451,P,3,N,N,4,3,2,2,3,4,,,4,
452,N,1,N,N,2,4,3,5,2,4,4,3,3,
453,T,3,Y,N,4,4,,3,5,3,4,5,2,
454,N,1,N,N,3,3,2,4,4,,5,2,3,
455,N,1,N,Y,2,,3,,2,5,4,4,4,
456,L,1,N,N,2,4,2,2,2,4,4,5,5,
457,T,1,N,N,4,3,4,4,2,3,4,2,2,
458,T,3,N,N,4,2,,3,,2,4,5,2,
459,T,2,N,N,4,,4,3,,4,,4,4,
460,T,1,N,N,2,4,4,2,3,2,5,3,4,
461,T,3,N,N,3,4,4,3,2,5,2,4,5,
462,L,3,N,N,2,4,3,5,2,3,4,2,3,
463,N,3,N,N,,,2,5,3,,5,5,4,
464,P,1,Y,N,2,4,3,3,4,3,4,4,3,
465,L,3,Y,N,4,4,2,4,4,4,4,2,4,
466,T,1,Y,N,4,4,1,2,3,2,4,5,5,
467,P,3,N,N,2,2,2,2,3,4,2,4,3,
468,T,2,N,N,2,,4,4,4,4,5,3,,
469,N,1,N,N,3,,4,,2,,3,4,3,
470,P,1,N,N,4,2,4,4,2,2,5,5,4,
471,T,1,Y,N,4,4,4,,4,4,4,,3,
472,T,1,N,N,4,4,2,4,2,3,4,4,,
473,T,3,N,N,3,3,5,3,5,,5,4,,
474,T,1,Y,Y,2,3,2,3,3,3,2,5,3,
475,T,1,Y,N,2,4,,4,2,2,4,4,3,
476,T,1,N,N,,4,2,3,4,4,5,2,4,
477,T,3,N,N,1,5,3,5,3,,4,4,4,
478,N,2,N,N,4,4,2,3,2,3,3,4,4,
479,L,3,N,N,4,2,1,5,2,5,5,4,3,
480,T,1,N,N,4,3,2,2,2,4,4,4,3,
481,N,3,Y,N,3,,4,2,4,,,4,2,
482,T,1,N,N,2,4,,2,4,,5,3,4,
;;;;

/***************************************************************/
/* Create MARATHON Data Set                                    */
/* Used in Examples 2.9                                        */
/***************************************************************/
data marathon;
   input year 4. +1 gender $1. +1 winner $25. +1 country $13. +1 time time7.;
datalines;
1980 M Bill Rodgers              United States 2:12:11
1981 M Toshihiko Seko            Japan         2:09:26
1982 M Alberto Salazar           United States 2:08:52
1983 M Greg Meyer                United States 2:09:00
1984 M Geoff Smith               Great Britain 2:10:34
1985 M Geoff Smith               Great Britain 2:14:05
1986 M Robert de Castella        Australia     2:07:51
1987 M Toshihiko Seko            Japan         2:11:50
1988 M Ibrahim Hussein           Kenya         2:08:43
1989 M Abebe Mekonnen            Ethiopia      2:09:06
1990 M Gelindo Bordin            Italy         2:08:19
1991 M Ibrahim Hussein           Kenya         2:11:06
1992 M Ibrahim Hussein           Kenya         2:08:14
1993 M Cosmas Ndeti              Kenya         2:09:33
1994 M Cosmas Ndeti              Kenya         2:07:15
1995 M Cosmas Ndeti              Kenya         2:09:22
1996 M Moses Tanui               Kenya         2:09:15
1997 M Lameck Aguta              Kenya         2:10:34
1998 M Moses Tanui               Kenya         2:07:34
1999 M Joseph Chebet             Kenya         2:09:52
2000 M Elijah Lagat              Kenya         2:09:47
2001 M Lee Bong-Ju               Korea         2:09:43
2002 M Rodgers Rop               Kenya         2:09:02
2003 M Robert Kipkoech Cheruiyot Kenya         2:10:11
2004 M Timothy Cherigat          Kenya         2:10:37
1980 F Jacqueline Gareau         Canada        2:34:28
1981 F Allison Roe               New Zealand   2:26:46
1982 F Charlotte Teske           West Germany  2:29:33
1983 F Joan Benoit               United States 2:22:43
1984 F Lorraine Moller           New Zealand   2:29:28
1985 F Lisa Larsen Weidenbach    United States 2:34:06
1986 F Ingrid Kristiansen        Norway        2:24:55
1987 F Rosa Mota                 Portugal      2:25:21
1988 F Rosa Mota                 Portugal      2:24:30
1989 F Ingrid Kristiansen        Norway        2:24:33
1990 F Rosa Mota                 Portugal      2:25:24
1991 F Wanda Panfil              Poland        2:24:18
1992 F Olga Markova              Russia        2:23:43
1993 F Olga Markova              Russia        2:25:27
1994 F Uta Pippig                Germany       2:21:45
1995 F Uta Pippig                Germany       2:25:11
1996 F Uta Pippig                Germany       2:27:12
1997 F Fatuma Roba               Ethiopia      2:26:23
1998 F Fatuma Roba               Ethiopia      2:23:21
1999 F Fatuma Roba               Ethiopia      2:23:25
2000 F Catherine Ndereba         Kenya         2:26:11
2001 F Catherine Ndereba         Kenya         2:23:53
2002 F Margaret Okayo            Kenya         2:20:43
2003 F Svetlana Zakharova        Russia        2:25:20
2004 F Cathering Ndereba         Kenya         2:24:27
;;;;


/***************************************************************/
/* Create PHONDATA Data Set                                    */
/* Used in Examples 3.1                                        */
/***************************************************************/
data phondata;
  input hour primtime time8. status $10. @@;
datalines;
12 0:04:20 PRIM/RES   12 0:13:29 AUTOMATED  10 0:08:06 PRIM/RES
13 0:06:06 PRIM/RES   11 0:04:05 PRIM/RES   14 0:02:23 PRIM/RES
16 0:01:40 NO ANSWER  15 0:00:30 PRIM/RES    9 0:08:51 LMOM
13 0:10:53 PRIM/RES   12 0:03:30 PRIM/RES   11 0:02:55 AUTOMATED
13 0:03:52 PRIM/RES   11 0:05:45 PRIM/RES   10 0:01:59 PRIM/RES
14 0:24:38 PINK SLIP  14 0:01:43 PRIM/RES   13 0:01:20 PRIM/RES
14 0:04:15 PRIM/RES   12 0:10:35 USER CALLD 14 0:07:23 PRIM/RES
15 0:09:32 AUTOMATED  16 0:21:29 PRIM/RES   14 0:07:15 PRIM/RES
16 0:01:42 DISTRIB    13 0:04:14 PRIM/RES   15 0:14:01 AUTOMATED
11 0:08:51 PRIM/RES   13 0:04:37 PRIM/RES   12 0:10:20 PRIM/RES
13 0:03:54 PRIM/RES   11 0:10:19 PRIM/ACC   15 0:04:19 PRIM/RES
 9 0:01:14 PRIM/RES   11 0:12:47 PRIM/RES    9 0:07:24 NO ANSWER
14 0:02:38 PRIM/RES   10 0:07:43 PRIM/ACC   10 0:02:36 PRIM/RES
13 0:17:28 PRIM/ACC   10 0:00:04 PRIM/RES   14 0:13:39 PRIM/RES
16 0:13:06 PRIM/RES   15 0:09:36 PRIM/RES   15 0:07:50 PRIM/RES
16 0:02:42 PRIM/RES   11 0:09:52 PRIM/RES   11 0:07:43 PRIM/RES
15 0:07:55 PRIM/RES   15 0:15:54 PRIM/RES   16 0:11:36 PRIM/RES
15 0:04:13 PRIM/RES   11 0:14:44 PRIM/RES   15 0:05:00 PRIM/RES
11 0:02:46 PRIM/RES   14 0:04:44 AUTOMATED  16 0:01:05 PRIM/RES
10 0:01:56 PRIM/RES   14 0:15:37 CALLD USER 10 0:01:56 PRIM/RES
15 0:08:44 PRIM/ACC   12 0:12:14 PRIM/RES   11 0:02:41 PRIM/RES
14 0:02:31 PRIM/RES   11 0:02:41 PRIM/RES    9 0:08:12 LMWA
14 0:07:50 PRIM/RES   13 0:08:33 CALL        9 0:03:45 PRIM/RES
10 0:08:06 AUTOMATED  10 0:02:57 PRIM/RES   13 0:05:19 CALLD USER
15 0:06:06 PRIM/RES   16 0:04:56 PRIM/RES   14 0:13:46 AUTOMATED
10 0:02:12 PRIM/RES   16 0:03:37 PRIM/ACC   10 0:08:28 PRIM/RES
14 0:19:48 AUTOMATED  12 0:00:11 PRIM/RES   11 0:02:28 PRIM/RES
16 0:22:08 PRIM/RES    9 0:08:29 AUTOMATED  15 0:03:23 PRIM/RES
12 0:02:09 PRIM/RES   12 0:04:33 PRIM/RES   12 0:14:34 PRIM/RES
14 0:01:55 PRIM/RES   15 0:01:31 PRIM/RES   13 0:05:43 PRIM/RES
14 0:00:56 RESPONSE   10 0:05:15 PRIM/RES   10 0:04:52 PRIM/RES
14 0:05:05 PRIM/RES   10 0:04:26 PRIM/RES   13 0:10:48 PRIM/RES
10 0:13:20 AUTOMATED  14 0:04:18 PRIM/RES   14 0:01:14 PRIM/RES
13 0:15:45 LMOM       15 0:04:07 PRIM/RES   13 0:05:23 PRIM/RES
15 0:04:02 AUTOMATED  16 0:07:23 PRIM/RES   11 0:00:58 PRIM/RES
11 0:02:45 PRIM/RES   12 0:05:52 PRIM/RES   13 0:02:26 PRIM/RES
10 0:05:51 PRIM/RES    9 0:07:20 RESPONSE   14 1:26:50 PRIM/RES
14 0:04:27 PRIM/RES   14 0:13:44 USER CALLD  9 0:08:13 PRIM/RES
10 0:38:28 PRIM/RES   12 0:06:12 PINK SLIP   9 0:03:53 PRIM/RES
10 0:02:54 PRIM/RES   14 0:03:34 AUTOMATED  14 0:02:36 PRIM/RES
 9 0:20:24 TELL USER  14 0:05:53 PRIM/RES   11 0:16:18 PRIM/ACC
14 0:13:10 PRIM/RES   14 0:02:03 PRIM/RES   15 0:05:02 PRIM/RES
14 0:04:12 AUTOMATED  10 0:04:35 PRIM/RES   14 0:03:46 PRIM/RES
13 0:00:21 PRIM/RES   11 0:01:27 AUTOMATED   9 0:02:29 PRIM/RES
15 0:05:06 RESPONSE   16 0:07:25 PRIM/RES   16 0:14:25 AUTOMATED
15 0:07:30 PRIM/RES   10 0:10:12 AUTOMATED  10 0:02:49 PRIM/RES
16 0:05:35 PRIM/ACC    9 0:00:12 PRIM/RES   13 0:05:24 PRIM/RES
11 0:12:09 PINK SLIP   9 0:06:14 PRIM/RES   14 0:07:03 PRIM/RES
11 0:04:55 AUTOMATED  14 0:13:50 PRIM/RES   16 0:15:53 PRIM/ACC
16 0:03:19 PRIM/RES   12 0:08:41 PRIM/RES   11 0:04:25 PRIM/RES
14 0:03:46 PRIM/RES   16 0:07:45 CALLD USER 15 0:18:52 PRIM/RES
16 0:01:47 AUTOMATED  16 0:05:21 PRIM/RES   16 0:10:24 PRIM/RES
10 0:03:53 PRIM/RES   11 0:11:21 PRIM/RES   15 0:02:32 PRIM/RES
16 0:01:59 PRIM/RES   12 0:10:38 CALLD USER 16 0:03:26 PRIM/RES
16 0:03:29 PRIM/ACC   15 0:05:14 PRIM/RES   15 0:06:45 PRIMARY
15 0:00:19 PRIM/RES   14 0:12:57 PRIM/RES   10 0:13:36 PRIM/RES
 9 0:06:56 CALLD USER 13 0:01:45 PRIM/RES   11 0:15:17 CALLD USER
10 0:03:45 PRIM/RES   11 0:14:36 PINK SLIP  15 0:08:07 PRIM/RES
15 0:11:05 PRIM/RES   13 0:05:26 PRIM/RES   13 0:06:48 PRIM/ACC
15 0:01:35 PRIM/RES   11 0:09:56 PRIM/RES   11 0:20:13 PRIM/RES
15 0:04:39 PRIM/RES   15 0:06:22 PRIM/RES   15 0:06:49 PRIM/RES
14 0:08:12 HOLD-2/2   14 0:02:40 PRIM/RES   10 0:05:11 AUTOMATED
14 0:09:09 PRIM/RES   13 0:02:44 PRIM/RES   10 0:08:10 AUTOMATED
14 0:32:54 PRIM/RES    9 0:01:54 PRIM/RES   13 0:05:01 PRIM/RES
10 0:04:10 PRIM/RES   15 0:14:46 AUTOMATED   9 0:03:44 PRIM/RES
14 0:08:13 AUTOMATED   9 0:09:18 PRIM/RES   13 0:03:24 AUTOMATED
10 0:03:46 PRIM/RES   10 0:03:41 PRIM/RES   11 0:17:24 AUTOMATED
14 0:04:22 PRIM/RES   16 0:05:16 PRIM/ACC    9 0:04:34 PRIM/RES
13 0:12:17 AUTOMATED   9 0:01:39 PRIM/RES   11 0:01:00 PRIM/RES
10 0:11:44 PRIM/RES   13 0:00:23 AUTOMATED   9 0:01:29 PRIM/RES
11 0:18:14 PRIM/ACC   12 0:14:32 PRIM/RES   12 0:16:05 PRIM/RES
16 0:03:30 PRIM/RES   14 0:00:55 PRIM/RES   12 0:08:10 PRIM/RES
13 0:16:21 CALLD USER 10 0:03:59 PRIM/RES   15 0:04:40 PRIM/RES
14 0:02:33 PRIM/RES   13 0:05:07 CALLD USER 15 0:08:53 PRIM/RES
10 0:03:21 AUTOMATED   9 0:09:18 PRIM/RES    9 0:11:51 PRIM/RES
16 0:17:37 PRIM/RES   16 0:16:38 PRIM/RES   12 0:12:19 AUTOMATED
14 0:07:45 PRIM/RES   13 0:13:14 PRIM/ACC    9 0:02:11 PRIM/RES
10 0:11:07 AUTOMATED  10 0:03:33 PRIM/RES   16 0:05:21 PRIM/RES
15 0:13:23 PRIM/RES   12 0:23:04 AUTOMATED  10 0:03:57 PRIM/RES
 9 0:04:32 PRIM/RES   16 0:00:22 PRIM/RES   15 0:26:49 HOLD-FR-4
16 0:05:31 PRIM/RES    9 0:07:55 AUTOMATED  13 0:09:00 PRIM/RES
14 0:11:26 PRIM/RES   13 0:04:27 PRIM/RES   10 0:05:16 CALLD USER
 9 0:09:07 PRIM/RES   14 0:11:21 AUTOMATED  14 0:07:25 PRIM/RES
 9 0:10:07 PRIM/RES   10 0:02:10 PRIM/RES   12 0:32:13 PRIM/RES
15 0:09:51 PRIM/RES   15 0:03:53 PRIM/RES   15 0:34:44 PRIM/RES
 9 0:07:37 PRIM/RES   11 0:05:06 PRIM/RES   12 0:02:39 PRIM/RES
12 0:29:14 WORK       11 0:02:35 PRIM/RES   15 0:12:38 HOLD-0207
14 0:02:27 PRIM/RES   15 0:06:36 PRIM/RES   10 0:25:47 PRIM/RES
11 0:05:33 PRIM/RES   10 0:20:42 AUTOMATED  13 0:02:56 PRIM/RES
11 0:04:04 AUTOMATED  16 0:07:56 PRIM/RES   12 0:08:20 PRIM/RES
15 0:22:29 AUTOMATED  10 0:03:35 PRIM/RES   15 0:07:05 PRIM/RES
14 0:03:54 PRIM/RES    9 0:03:57 PRIM/RES   11 0:05:44 PRIM/ACC
13 0:18:00 PRIM/RES   14 0:04:23 PRIM/RES    9 0:30:26 PRIM/RES
10 0:06:31 PRIM/RES   15 0:02:03 PRIM/RES   11 0:10:34 RESPONSE
14 0:07:18 PRIM/RES   11 0:12:26 PRIM/RES   13 0:03:02 PRIM/RES
13 0:03:41 LMOM       15 0:09:59 PRIM/RES   16 0:05:47 PRIMARY
16 0:05:53 PRIM/RES   16 0:00:20 PRIM/RES   13 0:02:52 PRIM/RES
15 0:02:00 PINK SLIP  16 0:01:45 PRIM/RES   16 0:11:58 PRIM/RES
15 0:02:06 PRIM/RES   16 0:05:22 CALLD USER 15 0:07:21 PRIM/RES
16 0:05:26 PRIM/RES   13 0:02:18 PRIM/ACC   15 0:01:54 PRIM/RES
16 0:12:50 PRIMARY    10 0:08:11 PRIM/RES   15 0:03:03 PRIM/RES
14 0:11:35 PRIM/RES   11 0:06:49 LMOM-1/31  14 0:02:37 PRIM/RES
15 0:08:38 PRIM/RES   15 0:16:16 AUTOMATED  12 0:18:09 PRIM/RES
15 0:03:18 PINK SLIP  16 0:02:20 PRIM/RES    9 0:09:10 LMOM-2/2
16 0:06:36 PRIM/RES    9 0:05:30 PRIM/RES   16 0:03:29 PRIM/RES
11 0:04:12 PRIM/RES   10 0:00:23 PRIM/RES   16 0:27:56 PRIM/RES
15 0:02:16 AUTOMATED  16 0:09:39 PRIM/RES   15 0:10:04 PRIMARY
14 0:22:48 PRIM/RES   15 0:05:33 AUTOMATED  15 0:04:48 PRIM/RES
11 0:02:12 PRIM/RES   10 0:09:08 AUTOMATED  14 0:02:08 PRIM/RES
13 0:00:04 AUTOMATED  15 0:05:22 PRIM/RES   11 0:11:33 PRIM/RES
11 0:24:08 HOLD-2/2   12 0:15:10 PRIM/RES   10 0:01:49 AUTOMATED
10 0:01:28 PRIM/RES    9 0:00:00 AUTOMATED  11 0:03:23 PRIM/RES
11 0:05:07 PRIM/RES   15 0:16:45 PRIM/RES   11 0:16:01 PRIM/RES
11 0:02:22 PRIM/RES   13 0:04:28 PRIM/RES   12 0:26:20 HOLD-2/7
12 0:06:00 PRIM/RES   14 0:02:45 PRIM/RES   11 0:14:02 PRIM/RES
14 0:02:49 AUTOMATED  16 0:01:45 PRIM/RES   15 0:03:33 PRIM/RES
16 0:13:29 PRIM/RES    9 0:05:19 PRIM/RES   15 0:05:45 PRIM/RES
11 0:03:07 PRIM/RES   12 0:05:41 PRIM/RES   15 0:01:51 PRIM/RES
11 0:32:06 AUTOMATED  10 0:04:31 PRIM/RES   10 0:07:10 CALLD USER
13 0:12:24 PRIM/RES   11 0:29:40 PINK SLIP   9 0:01:37 PRIM/RES
10 0:30:31 PRIM/RES   14 0:02:45 PRIM/RES   10 0:07:46 LMOM
10 0:07:41 PRIM/RES   15 0:06:21 AUTOMATED  14 0:03:04 PRIM/RES
11 0:01:40 AUTOMATED  12 0:00:22 PRIM/RES   12 0:07:45 PRIM/RES
15 0:06:49 AUTOMATED  16 0:05:55 PRIM/RES   11 0:15:36 PRIM/RES
14 0:02:09 AUTOMATED  16 0:01:45 PRIM/RES   12 0:08:49 PRIM/RES
16 0:07:15 PRIM/RES    9 0:09:46 PRIM/RES   12 0:00:42 PRIM/RES
 9 0:01:27 PRIM/RES   12 0:19:26 HOLD-02/04 13 0:05:12 PRIM/RES
10 0:01:56 PRIM/RES   14 0:14:31 PRIM/RES   13 0:04:44 PRIM/RES
11 0:05:44 PRIM/ACC   14 0:10:19 PRIM/RES   10 0:21:16 AUTOMATED
13 0:00:43 PRIM/RES   16 0:04:25 PRIM/RES   11 0:10:29 AUTOMATED
12 0:00:32 PRIM/RES   16 0:12:41 PRIM/RES   14 0:14:46 AUTOMATED
 9 0:02:04 PRIM/RES   10 0:00:18 PRIM/ACC   13 0:09:01 PRIM/RES
13 0:02:16 PRIM/RES   14 0:58:45 RESPONSE   15 0:01:52 PRIM/RES
10 0:08:59 AUTOMATED   9 0:09:31 PRIM/RES   13 0:27:23 CALLD USER
10 0:03:12 PRIM/RES   15 0:00:29 PRIM/RES   13 0:03:46 PRIM/RES
11 0:02:54 PRIM/RES    9 0:09:09 TELL USER  13 0:09:13 PRIM/RES
 9 0:00:00 AUTOMATED  11 0:05:28 PRIM/RES   10 0:06:36 CALLD USER
10 0:03:39 PRIM/RES   12 0:05:12 PRIM/RES   12 0:26:31 CALL
 9 0:03:44 PRIM/RES    9 0:02:49 PRIM/RES   10 0:02:44 AUTOMATED
10 0:30:08 PRIM/RES   16 0:06:32 PRIM/RES   13 0:14:33 PRIM/RES
 9 0:12:21 PRIM/RES   13 0:10:28 CALL        9 0:11:28 PRIM/RES
 9 0:02:15 PRIM/RES   12 0:05:40 DISTRIB    16 0:08:43 PRIM/RES
15 0:02:16 PRIM/RES   12 0:03:34 PRIM/RES   10 0:06:03 PRIM/RES
12 0:00:00 PRIM/EMITS  9 0:03:02 PRIM/RES   15 0:15:50 AUTOMATED
12 0:07:16 PRIM/RES   14 0:01:38 PRIM/RES   15 0:01:07 PRIM/RES
11 0:01:46 AUTOMATED  16 0:02:06 PRIM/RES    9 0:14:05 AUTOMATED
10 0:11:28 PRIM/RES   10 0:10:25 PINK SLIP  10 0:06:54 PRIM/RES
 9 0:10:02 AUTOMATED  13 0:00:03 PRIM/RES   11 0:25:08 HOLD-02/04
 9 0:06:39 PRIM/RES   11 0:04:24 CALL       14 0:04:03 PRIM/RES
16 0:04:35 PRIMARY     9 0:03:50 PRIM/RES   12 0:11:47 PRIM/RES
11 0:03:43 PRIM/RES   10 0:22:03 AUTOMATED  10 0:07:08 PRIM/RES
16 0:08:00 PRIM/RES   16 0:07:10 PRIM/RES    9 0:06:16 PRIM/RES
12 0:00:00 PRIM/EMITS  9 0:01:17 PRIM/RES   11 0:20:38 AUTOMATED
10 0:17:48 PRIM/RES   10 0:18:02 PRIM/RES    9 0:09:47 HOLD
15 0:13:17 PRIM/RES   11 0:02:13 PRIM/RES   14 0:01:30 PRIM/RES
16 0:07:47 AUTOMATED  16 0:10:33 PRIM/RES   14 0:02:13 PRIM/RES
13 0:02:15 PRIM/RES   11 0:09:19 AUTOMATED   9 0:05:09 PRIM/RES
11 0:03:21 PRIM/RES    9 0:02:30 PRIM/RES   15 0:05:08 PRIM/RES
11 0:07:55 DISTRIB    14 0:03:48 PRIM/RES   14 0:06:59 PRIM/RES
12 0:01:24 LMOM       15 0:08:45 PRIM/RES   15 0:05:30 AUTOMATED
11 0:08:01 PRIM/RES   11 0:15:40 PRIM/RES   11 0:10:23 PRIM/RES
15 0:04:59 PRIM/RES   11 0:34:08 AUTOMATED  11 0:13:42 PRIM/RES
 9 0:06:36 AUTOMATED  13 0:03:06 PRIM/RES   12 0:00:00 RESPONSE
16 0:16:10 PRIM/RES   15 0:08:59 PRIM/RES   12 0:05:26 PRIM/RES
14 0:09:37 AUTOMATED  14 0:05:40 PRIM/RES    9 0:09:54 CALLD USER
15 0:01:32 PRIM/RES   13 0:02:00 PRIM/RES   12 0:14:06 PRIM/RES
13 0:05:30 AUTOMATED  13 0:24:27 PRIM/RES   15 0:06:26 AUTOMATED
15 0:26:58 PRIM/RES   12 0:06:33 PRIM/RES   12 0:22:03 PRIM/RES
16 0:00:05 PRIM/RES   13 0:03:35 PRIM/RES   16 0:29:27 PRIM/RES
11 0:12:33 PRIM/RES   13 0:06:02 LMOM       15 0:08:11 PRIM/RES
13 0:09:57 PRIM/RES   12 0:13:34 PRIM/RES   10 0:04:25 AUTOMATED
14 0:09:45 PRIM/RES   11 0:01:03 PRIM/RES   11 0:04:50 PRIM/RES
14 0:02:59 PRIM/RES   12 0:01:22 AUTOMATED  12 0:01:53 PRIM/RES
16 0:08:00 PRIMARY    16 0:06:46 PRIM/RES   10 0:02:45 PRIM/RES
10 0:00:19 AUTOMATED  16 0:02:15 PRIM/RES   14 0:20:02 CALL
16 0:07:27 PRIM/RES   12 0:04:04 PRIM/RES   16 0:08:35 PRIM/ACC
15 0:05:01 PRIM/RES   15 0:04:44 PINK SLIP   9 0:06:55 PRIM/RES
14 0:02:06 AUTOMATED  16 0:05:46 PRIM/RES   13 0:02:06 PRIM/RES
14 0:04:27 PRIM/RES    9 0:04:49 PRIM/RES   14 0:03:10 PRIM/RES
10 0:01:59 PRIM/RES   14 0:00:44 HOLD-2/04  14 0:07:38 PRIM/RES
10 0:53:32 CALLD USER 11 0:17:04 PRIM/RES   13 0:05:50 PRIM/RES
12 0:00:20 AUTOMATED   9 0:01:59 PRIM/RES   16 0:05:55 PRIM/RES
15 0:01:32 RESPONSE   16 0:00:07 PRIM/RES   16 0:06:00 PRIMARY
15 0:05:18 PRIM/RES   10 0:00:34 PRIM/RES    9 0:05:28 PRIM/ACC
10 0:00:08 PRIM/RES   12 0:02:29 PRIM/RES    9 0:02:12 AUTOMATED
11 0:04:26 PRIM/RES   12 0:08:40 PINK SLIP  14 0:44:59 PRIM/RES
 9 0:03:47 AUTOMATED  10 0:00:06 PRIM/RES   15 0:06:41 PRIM/RES
14 0:03:22 AUTOMATED  14 0:07:36 PRIM/RES   14 0:05:16 PRIM/RES
16 0:04:27 PRIM/RES   14 0:08:48 PRIMARY    14 0:03:43 PRIM/RES
 9 0:00:00 AUTOMATED  15 0:01:54 PRIM/RES   14 0:02:00 RESPONSE
16 0:04:46 PRIM/RES   12 0:11:15 WORK       16 0:07:41 PRIM/RES
16 0:03:18 PRIM/ACC   13 0:13:26 PRIM/RES   11 0:05:27 PRIM/RES
15 0:00:42 HEADER CHG 14 0:01:01 PRIM/RES   16 0:05:51 PRIM/RES
14 0:04:14 PRIM/RES   11 0:03:36 PRIM/RES
;;;;


/***************************************************************/
/* Create BREAD Data Set                                       */
/* Used in Examples 3.2, 6.5, 6.15                             */
/***************************************************************/
data bread;
  infile datalines dsd;
  attrib source      length=$7  label='Source'
         brand       length=$16 label='Brand'
         flour       length=$15 label='Primary Flour Ingredient'
         type        length=$20 label='Type of Bread'
         calories    label='Calories per Slice'
         total_fat   label='Total Fat(g) per Slice'
         dietary_fiber label='Dietary Fiber(g) per Slice'
         protein       label='Protein(g) per Slice'
         total_carb    label='Total Carbohydrates(g) per Slice';
  input source $ brand $ flour $ type $
        calories total_fat dietary_fiber protein total_carb;
datalines;
Grocery,Fabulous Breads,White,Sandwich,71,1.5,0.5,2.1,12.1
Grocery,Fabulous Breads,White,Egg,92,0.5,0.5,3.3,18.2
Grocery,Fabulous Breads,White,Buttertop,97,1.5,0,3.1,17.5
Grocery,Fabulous Breads,Whole Wheat,Sandwich,90,1.1,3.1,4.4,15.3
Grocery,Fabulous Breads,Whole Wheat,100% Whole Wheat,74,0.5,1.8,2,15
Grocery,Fabulous Breads,Whole Wheat,Bran,89,2.1,2.8,3.2,14.1
Grocery,Fabulous Breads,Whole Wheat,Sandwich,82,1,1.6,2.9,15.1
Grocery,Fabulous Breads,Rye,Sandwich,78,0.5,1.6,3,15.1
Grocery,Fabulous Breads,Rye,Pumpernickel,87,1.2,3.1,3.5,15.2
Grocery,Fabulous Breads,Multigrain,Sandwich,81,1.1,1.5,3,14.4
Grocery,Fabulous Breads,Multigrain,Eight Grain,78,0.9,3.2,2.9,14.4
Grocery,Fabulous Breads,Multigrain,Cornmeal,79,0.7,2.1,3,14.9
Grocery,Fabulous Breads,White,Raisin Cinnamon,82,0.7,1.5,3,15.7
Grocery,Fabulous Breads,Oatmeal,Sandwich,85,1,3,3.9,14.8
Grocery,Fabulous Breads,White,Sourdough,77,0.3,1.3,2.9,15.4
Grocery,Gaia's Hearth,White,Sandwich,91,1.8,0.6,3.1,15.4
Grocery,Gaia's Hearth,Whole Wheat,Sandwich,101,0.8,2.3,4.6,18.5
Grocery,Gaia's Hearth,Whole Wheat,100% Whole Wheat,80,0.9,2.2,3.1,14.6
Grocery,Gaia's Hearth,Rye,Sandwich,85,0.9,1.3,2.8,16.1
Grocery,Gaia's Hearth,Rye,Pumpernickel,92,0.9,3.6,3.9,16.7
Grocery,Gaia's Hearth,Multigrain,Sandwich,92,1.6,2.3,3.7,15.4
Grocery,Gaia's Hearth,Multigrain,High Protein,81,0.5,2.1,4.2,14.6
Grocery,Gaia's Hearth,Multigrain,Spelt,87,1.2,0,3.6,15.2
Grocery,Gaia's Hearth,White,Raisin Cinnamon,98,1.3,0.9,2.8,18.6
Grocery,Gaia's Hearth,Oatmeal,Sandwich,95,1.7,3.5,3.8,15.9
Grocery,Gaia's Hearth,White,Sourdough,77,0.5,1.3,2.6,15.3
Grocery,RiseNShine Breads,White,Sandwich,56,0.7,1,2.2,10
Grocery,RiseNShine Breads,White,Potato,96,0.5,0.9,3.2,19.3
Grocery,RiseNShine Breads,White,Honey,74,0.5,1.7,2.1,15
Grocery,RiseNShine Breads ,Whole Wheat,Sandwich,80,0.5,2,3.3,15.2
Grocery,RiseNShine Breads ,Rye,Sandwich,84,0.5,1.5,2.9,16.6
Grocery,RiseNShine Breads ,Multigrain,Sandwich,76,1.1,1.6,2.8,13.5
Grocery,RiseNShine Breads ,Multigrain,Six Grain,89,1.6,3.1,3.3,15.2
Grocery,RiseNShine Breads ,White,Raisin Cinnamon,100,1.5,1.4,2.3,19
Grocery,Mill City Bakers,White,Sandwich,66,1.4,0.8,2.1,11
Grocery,Mill City Bakers,White,Toaster,112,2.6,0.5,3.4,18.6
Grocery,Mill City Bakers ,Whole Wheat,Sandwich,88,0.9,2.6,3.6,16
Grocery,Mill City Bakers ,Rye,Sandwich,71,0.3,1.3,2.6,14.3
Grocery,Mill City Bakers ,Multigrain,Sandwich,77,0.8,2.2,2.9,14.2
Grocery,Mill City Bakers ,Multigrain,Low Carb,88,2.5,2.3,6,10
Grocery,Mill City Bakers ,Multigrain,Sandwich,87,1.4,2.9,3.1,15.2
Grocery,Mill City Bakers ,Multigrain,Soy ,99,2.5,3.1,4.2,14.7
Grocery,Mill City Bakers ,White,Sourdough,80,0.6,1.6,2.5,15.9
Grocery,Owasco Ovens,White,Sandwich,83,1.9,0.8,1.8,14.3
Grocery,Owasco Ovens ,Whole Wheat,Sandwich,75,1.2,1,2.5,13.3
Grocery,Owasco Ovens ,Whole Wheat,Bran,79,1.2,4.8,3.9,13
Grocery,Owasco Ovens ,Whole Wheat,100% Whole Wheat,72,0.8,4,4,12
Grocery,Owasco Ovens ,Rye,Sandwich,80,1,1,2.5,15.1
Grocery,Owasco Ovens ,Rye,Pumpernickel,92,0.9,2.9,3.7,17
Grocery,Owasco Ovens ,Multigrain,Sandwich,87,1.1,2.2,3.1,16
Grocery,Owasco Ovens ,Multigrain,Rustic,92,1.6,2.3,3.7,15.4
Grocery,Owasco Ovens ,Multigrain,Eight Grain,86,1.3,1.8,2.9,15.5
Grocery,Owasco Ovens ,White,Raisin Cinnamon,85,0.5,1.7,3.3,16.6
Grocery,Owasco Ovens ,Oatmeal,Sandwich,90,0.7,2.8,4.1,16.6
Grocery,Owasco Ovens ,White,Sourdough,79,0.4,1.1,2.7,15.8
Grocery,Choice 123,White,Sandwich,71,1.1,1.5,1.9,13.1
Grocery,Choice 123,White,Egg,87,1.8,1,2.9,14.5
Grocery,Choice 123,White,Sandwich,71,1.2,0.5,2,12.8
Grocery,Choice 123,Whole Wheat,Sandwich,87,1,1.8,3.1,16.2
Grocery,Choice 123,Multigrain,Sandwich,76,1.5,2,2.4,13
Grocery,Choice 123,Multigrain,Seven Grain,92,1.6,2.3,3.7,15.4
Grocery,BBB Brands,White,Sandwich,65,0.5,1.2,1.9,13
Grocery,BBB Brands,Whole Wheat,Sandwich,90,1.8,2.6,2.8,15.4
Grocery,BBB Brands,Rye,Sandwich,82,1,1.5,2.6,15.3
Grocery,BBB Brands,Rye,Pumpernickel,84,0.8,2,2.7,16.2
Grocery,BBB Brands,Multigrain,Sandwich,88,2,1.5,2.3,15
Grocery,Five Chimneys,White,Sandwich,92,1.6,2.3,3.7,15.4
Grocery,Five Chimneys,Whole Wheat,Sandwich,90,0.9,2.9,3.1,17.2
Grocery,Five Chimneys,Whole Wheat,Bran,83,1,3.8,3.6,14.6
Grocery,Five Chimneys,Rye,Sandwich,77,0.5,1.2,2.8,15.1
Grocery,Five Chimneys,Rye,Pumpernickel,98,1,3.5,3.8,18.1
Grocery,Five Chimneys,Multigrain,Sandwich,97,2.1,2.6,4,15.2
Grocery,Five Chimneys,Multigrain,Sandwich,88,1.6,2.3,2.8,15.4
Grocery,Five Chimneys,White,Raisin Cinnamon,82,0.5,2,2.6,16.4
Grocery,Five Chimneys,Oatmeal,Sandwich,84,0.5,3.3,3.7,15.8
Grocery,Five Chimneys,White,Sourdough,75,0.3,1.6,2.8,15.1
Bakery,Downtown Bakers,White,Sandwich,106,2.1,1.6,2.7,18.7
Bakery,Downtown Bakers,White,Baguette,138,1,1,6,26
Bakery,Downtown Bakers,Whole Wheat,Sandwich,90,1.4,3,3.5,15.5
Bakery,Downtown Bakers,Whole Wheat,Bran,85,1.5,4.3,3.3,14.2
Bakery,Downtown Bakers,Rye,Sandwich,82,0.6,1.4,2.8,16.1
Bakery,Downtown Bakers,Rye,Pumpernickel,94,1,3,3.4,17.5
Bakery,Downtown Bakers,Multigrain,Sandwich,90,1.8,3,3.4,14.9
Bakery,Downtown Bakers,Multigrain,Flax and Soy,95,2.4,2.3,4,14.1
Bakery,Downtown Bakers,White,Raisin Cinnamon,107,0.3,2.9,3.4,22.5
Bakery,Downtown Bakers,White,Sourdough,82,0.5,1,2.5,16.7
Bakery,Pain du Prairie,White,Sandwich,108,1.7,2.1,2.6,20.2
Bakery,Pain du Prairie,White,Rustic,88,1.7,0.3,2.6,15.3
Bakery,Pain du Prairie,White,Foccacia,93,3.9,1.4,3.4,10.8
Bakery,Pain du Prairie,White,Baguette,98,0.5,0.7,3.5,19.5
Bakery,Pain du Prairie,Whole Wheat,Sandwich,80,1.1,2.9,3.2,14.1
Bakery,Pain du Prairie,Whole Wheat,Organic,86,1.6,2.8,3.6,14.1
Bakery,Pain du Prairie,Whole Wheat,Bran,76,0.8,4.4,3.4,13.6
Bakery,Pain du Prairie,Rye,Sandwich,84,1.1,1.6,2.9,15.4
Bakery,Pain du Prairie,Rye,Pumpernickel,87,0.9,2.5,3,16.5
Bakery,Pain du Prairie,Multigrain,Sandwich,88,1.3,2.3,3.6,15.1
Bakery,Pain du Prairie,Multigrain,Organic,82,0.5,2.3,3.7,15.4
Bakery,Pain du Prairie,White,Raisin Cinnamon,82,1.5,0.5,2.2,14.6
Bakery,Pain du Prairie,White,Sourdough,74,0.3,0.8,2.7,14.9
Bakery,Aunt Sal Bakes,White,Sandwich,93,1.5,1.3,2.8,16.7
Bakery,Aunt Sal Bakes,White,Toaster,105,2.3,0.5,3.1,17.6
Bakery,Aunt Sal Bakes,White,Baguette,94,0.5,1,4,18
Bakery,Aunt Sal Bakes,Whole Wheat,Sandwich,97,1.5,2.4,3.6,17.1
Bakery,Aunt Sal Bakes,Whole Wheat,Nutty,81,1.3,1.5,2.8,14.2
Bakery,Aunt Sal Bakes,Rye,Sandwich,81,0.5,1,2.8,16
Bakery,Aunt Sal Bakes,Rye,Pumpernickel,97,1.2,3.5,4.1,17.3
Bakery,Aunt Sal Bakes,Multigrain,Sandwich,99,1.9,3.9,3.9,16.4
Bakery,Aunt Sal Bakes,White,Raisin Cinnamon,92,1.6,2.3,3.7,15.4
Bakery,Aunt Sal Bakes,White,Sourdough,74,0.2,1,2.7,15.1
Bakery,Demeter,White,Sandwich,73,1.3,0.5,2,13.1
Bakery,Demeter,White,Rustic,97,2.1,0.5,3,16.2
Bakery,Demeter,White,Baguette,98,0.5,0.5,3,20
Bakery,Demeter,Whole Wheat,Sandwich,97,2,3.3,3.9,15.6
Bakery,Demeter,Whole Wheat,Bran,101,2.3,3.9,3.7,16
Bakery,Demeter,Whole Wheat,Nutty,99,1.5,2.7,3.9,17.3
Bakery,Demeter,Rye,Sandwich,94,1.1,1.5,3,17.8
Bakery,Demeter,Rye,Pumpernickel,105,1.2,4.2,4.2,19.2
Bakery,Demeter,Multigrain,Sandwich,97,2.1,3.5,3.6,15.7
Bakery,Demeter,Multigrain,Cornmeal,95,1.6,2.3,3.7,16.1
Bakery,Demeter,Multigrain,Ten Grain,108,0.5,3.3,4.1,21.5
Bakery,Demeter,Multigrain,High Omega,102,1.5,2.3,3.7,18.1
Bakery,Demeter,White,Raisin Cinnamon,102,0.6,1,2.9,21.1
Bakery,Demeter,Oatmeal,Sandwich,111,1.5,3.9,3.6,20.6
Bakery,Demeter,White,Sourdough,71,0.4,0.9,3,13.6
;;;;


/***************************************************************/
/* Create JOBCLASS Data Set                                    */
/* Used in Examples 3.4, 3.5, 3.6, 6.3, 6.7                    */
/***************************************************************/
data jobclass;
  input gender region occupat @@;
datalines;
1 1 1  1 1 1  1 1 1  1 1 1  1 1 1  1 1 1  1 1 1
1 1 2  1 1 2  1 1 2  1 1 2  1 1 2  1 1 2  1 1 2
1 1 3  1 1 3  1 1 3  1 1 3  1 1 3  1 1 3  1 1 3
1 2 1  1 2 1  1 2 1  1 2 2  1 2 2  1 2 2  1 2 2
1 2 2  1 2 2  1 2 3  1 2 3  1 2 4  1 2 4  1 2 4
1 2 4  1 2 4  1 2 4  1 3 1  1 3 1  1 3 1  1 3 1
1 3 1  1 3 2  1 3 2  1 3 2  1 3 2  1 3 2  1 3 2
1 3 2  1 3 3  1 3 3  1 3 3  1 3 3  1 3 4  1 3 4
1 3 4  1 3 4  1 3 4  1 4 1  1 4 3  2 1 1  2 1 1
2 1 1  2 1 1  2 1 1  2 1 1  2 1 1  2 1 2  2 1 2
2 1 2  2 1 2  2 1 2  2 1 3  2 1 3  2 1 3  2 1 4
2 1 4  2 1 4  2 1 4  2 1 4  2 1 4  2 2 1  2 2 3
2 2 3  2 2 3  2 2 3  2 2 3  2 2 4  2 2 4  2 2 4
2 2 4  2 2 4  2 3 1  2 3 1  2 3 1  2 3 1  2 3 1
2 3 2  2 3 2  2 3 2  2 3 2  2 3 2  2 3 2  2 3 2
2 3 3  2 3 3  2 3 4  2 3 4  2 3 4  2 4 1  2 4 1
2 4 1  2 4 1  2 4 1  2 4 2  2 4 2  2 4 2  2 4 3
2 4 3  2 4 3  2 4 3  2 4 4
;;;;






/***************************************************************/
/* Create LIBRARIES Data Set                                   */
/* Used in Examples 3.7                                        */
/***************************************************************/
data libraries;
  infile datalines dsd;
  length media audience type category subcategory $ 20;
  input media audience type category subcategory items;
datalines;
Audio,Adult,Audiocassettes,All,General,1569
Audio,Adult,CompactDiscs,All,General,2018
Books,Adult,Hardcover,Fiction,General,5210
Books,Adult,Paperback,Fiction,General,1353
Books,Adult,Hardcover,Fiction,Mystery,1293
Books,Adult,Paperback,Fiction,Mystery,1521
Books,Adult,Hardcover,Fiction,Romance,170
Books,Adult,Paperback,Fiction,Romance,854
Books,Adult,Hardcover,Fiction,ScienceFiction,71
Books,Adult,Paperback,Fiction,ScienceFiction,94
Books,Adult,Hardcover,Fiction,Western,9
Books,Adult,Paperback,Fiction,Western,44
Books,Adult,Hardcover,Nonfiction,General,9063
Books,Adult,Paperback,Nonfiction,General,277
TalkingBooks,Adult,Audiocassettes,Fiction,General,424
TalkingBooks,Adult,CompactDiscs,Fiction,General,163
TalkingBooks,Adult,Audiocassettes,Nonfiction,General,59
TalkingBooks,Adult,CompactDiscs,Nonfiction,General,21
Video,Adult,Videocassettes,Fiction,General,5183
Video,Adult,Videocassettes,Nonfiction,General,909
Video,Adult,DVD,Fiction,General,3002
Video,Adult,DVD,Nonfiction,General,1852
Books,Juvenile,Hardcover,Fiction,General,855
Books,Juvenile,Paperback,Fiction,General,2437
Books,Juvenile,Hardcover,Fiction,Mystery,94
Books,Juvenile,Paperback,Fiction,Mystery,395
Books,Juvenile,Hardcover,Fiction,ScienceFiction,16
Books,Juvenile,Paperback,Fiction,ScienceFiction,1
Books,Juvenile,Hardcover,Nonfiction,General,3346
Books,Juvenile,Paperback,Nonfiction,General,385
TalkingBooks,Juvenile,Audiocassettes,Fiction,General,343
TalkingBooks,Juvenile,CompactDiscs,Fiction,General,10
Audio,Juvenile,Audiocassettes,All,General,546
Video,Juvenile,Videocassettes,Fiction,General,2231
Video,Juvenile,Videocassettes,Nonfiction,General,1309
Video,Juvenile,DVD,Fiction,General,936
Video,Juvenile,DVD,Nonfiction,General,206
Books,Adult,LargeType,Fiction,General,60
Books,Adult,LargeType,Fiction,Mystery,29
Books,Adult,LargeType,Nonfiction,General,17
Books,Adult,LargeType,Fiction,Romance,15
Books,Adult,LargeType,Fiction,ScienceFiction,3
Books,Adult,LargeType,Fiction,Western,7
Books,Juvenile,LargeType,All,General,1
Periodicals,Adult,LargeType,All,General,9
Books,YoungPeople's,LargeType,All,General,2
Periodicals,Adult,Magazines,All,General,4162
Periodicals,Juvenile,Magazines,All,General,433
Periodicals,YoungPeople's,Magazines,All,General,134
Books,YoungPeople's,Hardcover,Fiction,General,352
Books,YoungPeople's,Paperback,Fiction,General,668
Books,YoungPeople's,Hardcover,Fiction,Mystery,14
Books,YoungPeople's,Paperback,Fiction,Mystery,25
Books,YoungPeople's,Hardcover,Fiction,ScienceFiction,3
Books,YoungPeople's,Paperback,Fiction,ScienceFiction,2
Books,YoungPeople's,Hardcover,Nonfiction,General,715
Books,YoungPeople's,Paperback,Nonfiction,General,17
Audio,YoungPeople's,Audiocassettes,All,General,388
Audio,YoungPeople's,CompactDiscs,All,General,370
TalkingBooks,YoungPeople's,Audiocassettes,Fiction,General,24
TalkingBooks,YoungPeople's,CompactDiscs,Fiction,General,4
;;;;

/***************************************************************/
/* Create CARSALES Data Set                                    */
/* Used in Examples 3.8, 6.2, 6.6                              */
/***************************************************************/
data carsales;
   length name $ 18;
   input name $ month numsold amtsold @@;
datalines;
Langlois-Peele 1 3 105000 Langlois-Peele 2 2  60000
Langlois-Peele 3 1  52000 Langlois-Peele 4 4 200000
Langlois-Peele 5 7  310000 Langlois-Peele 6 9  425000
Langlois-Peele 7 3 100000 Langlois-Peele 8 4 160000
Langlois-Peele 9 3 98000 Langlois-Peele 10 8  445000
Langlois-Peele 11 1  62000 Langlois-Peele 12 4 160000
Johnson 1 2  65000 Johnson 2 1  44000
Johnson 3 3  95000 Johnson 4 2  61000
Johnson 5 2  75000 Johnson 6 6  200000
Johnson 7 3 97000 Johnson 8 2  85000
Johnson 9 2 73000 Johnson 10 5 195000
Johnson 11 3 140000 Johnson 12 2 72000
;;;;


/***************************************************************/
/* Create CUSTRESP Data Set                                    */
/* Used in Examples 3.10, 6.13, 6.14                           */
/***************************************************************/
data custresp;
   input customer factor1-factor4 source1-source3 website store;
datalines;
  1 . . 1 1 1 1 .  0   1
  2 1 1 . 1 1 1 .  0   8
  3 . . 1 1 1 1 .  0   4
  4 1 1 . 1 . 1 . 10   3
  5 . 1 . 1 1 . .  1   0
  6 . 1 . 1 1 . .  3   0
  7 . 1 . 1 1 . .  0   6
  8 1 . . 1 1 1 .  0   2
  9 1 1 . 1 1 . .  0   1
 10 1 . . 1 1 1 .  0   4
 11 1 1 1 1 . 1 .  6   4
 12 1 1 . 1 1 1 .  4   4
 13 1 1 . 1 . 1 .  9   3
 14 1 1 . 1 1 1 .  0   3
 15 1 1 . 1 . 1 .  1   0
 16 1 . . 1 1 . .  0   2
 17 1 1 . 1 1 1 .  0   5
 18 1 1 . 1 1 1 1  6   1
 19 . 1 . 1 1 1 1  0   7
 20 1 . . 1 1 1 .  5   3
 21 . . . 1 1 1 .  0   1
 22 . . . 1 1 1 .  5   1
 23 1 . . 1 . . .  1   0
 24 . 1 . 1 1 . .  0   2
 25 1 1 . 1 1 . .  1   1
 26 1 1 . 1 1 . .  1   0
 27 1 . . 1 1 . .  5   9
 28 1 1 . 1 . . .  0   9
 29 1 . . 1 1 1 .  5   2
 30 1 . 1 1 1 . .  1   0
 31 . . . 1 1 . .  0   7
 32 1 1 1 1 1 . .  7   8
 33 1 . . 1 1 . .  2   3
 34 . . 1 1 . . . 11   1
 35 1 1 1 1 1 . 1  4   0
 36 1 1 1 1 . 1 .  1   0
 37 1 1 . 1 . . .  3   0
 38 . . . 1 1 1 .  1   0
 39 1 1 . 1 1 . .  5   4
 40 1 . . 1 . . 1  0   2
 41 1 . . 1 1 1 1  1   0
 42 1 1 1 1 . . 1  5   3
 43 1 . . 1 1 1 .  1   0
 44 1 . 1 1 . 1 .  0   7
 45 . . . 1 . . 1  1   0
 46 . . . 1 1 . .  0   7
 47 1 1 . 1 . . 1  0   6
 48 1 . 1 1 1 . 1  2   0
 49 . . 1 1 1 1 .  3   8
 50 . 1 . 1 1 . .  0   1
 51 1 . 1 1 1 1 .  2   2
 52 1 1 1 1 1 1 .  2   5
 53 . 1 1 1 . 1 .  1   0
 54 1 . . 1 1 . .  9   0
 55 1 1 . 1 1 1 .  1   0
 56 1 . . 1 1 . .  8   0
 57 1 1 . 1 1 . 1  4   0
 58 . 1 . 1 . 1 .  1   0
 59 1 1 1 1 . . 1  0   8
 60 . 1 1 1 1 1 .  4   8
 61 1 1 1 1 1 1 .  0   9
 62 1 1 . 1 1 . .  6   0
 63 . . . 1 . . .  0   8
 64 1 . . 1 1 1 .  0   1
 65 1 . . 1 1 1 .  0   7
 66 1 . . 1 1 1 1  0   2
 67 1 1 . 1 1 1 .  0   1
 68 1 1 . 1 1 1 .  0   6
 69 1 1 . 1 1 . 1  8   3
 70 . . . 1 1 1 .  9   4
 71 1 . . 1 1 . 1  0   1
 72 1 . 1 1 1 1 .  1   0
 73 1 1 . 1 . 1 .  2   8
 74 1 1 1 1 1 1 .  0   6
 75 . 1 . 1 1 1 .  1   0
 76 1 1 . 1 1 1 .  0   6
 77 . . . 1 1 1 .  1   0
 78 1 1 1 1 1 1 .  0   2
 79 1 . . 1 1 1 .  0   2
 80 1 1 1 1 1 . 1  9   9
 81 1 1 . 1 1 1 1  8   7
 82 . . . 1 1 1 1  0   1
 83 1 1 . 1 1 1 .  1   0
 84 1 . . 1 1 . .  1   0
 85 . . . 1 . 1 .  3   4
 86 1 . . 1 1 1 .  0   8
 87 1 1 . 1 1 1 .  6   1
 88 . . . 1 . 1 .  1   0
 89 1 . . 1 . 1 .  2   1
 90 1 1 . 1 1 1 .  0   4
 91 . . . 1 1 . .  3   0
 92 1 . . 1 1 1 .  4   0
 93 1 . . 1 1 . .  1   0
 94 1 . . 1 1 1 1  1   5
 95 1 . . 1 . 1 1  0   6
 96 1 . 1 1 1 1 .  0   1
 97 1 1 . 1 1 . .  1   1
 98 1 . 1 1 1 1 1  9   0
 99 1 1 . 1 1 1 1  3   4
100 1 . 1 1 1 . .  2   1
101 1 . 1 1 1 1 .  0   9
102 1 . . 1 1 . 1  0   1
103 1 1 . 1 1 1 .  8   3
104 . . . 1 1 1 .  3   9
105 1 . 1 1 1 . .  0   1
106 1 1 1 1 1 1 1  1   0
107 1 1 1 1 . . .  2   0
108 1 . . 1 . 1 1  1   0
109 . 1 . 1 1 . .  0   9
110 1 . . 1 . . .  1   0
111 1 . . 1 1 1 .  6   0
112 1 1 . 1 1 1 .  0   1
113 1 1 . 1 1 . 1  8   0
114 1 1 . 1 1 . .  4   0
115 1 1 . 1 1 . .  1   0
116 . 1 . 1 1 1 1  5   0
117 . 1 . 1 1 1 .  4   8
118 . 1 1 1 1 . .  0   1
119 . . . 1 . . .  1   0
120 1 1 . 1 . . .  8   0
;;;;





/***************************************************************/
/* Create SERVICE Data Set                                     */
/* Used in Examples 4.1                                        */
/***************************************************************/
data service;
   input @1 name $10. @12 address $17. @30 city $7.
         @38 state $2. @41 zipcode $5. @47 date mmddyy8.
         @55  workdone $15. @71 hours 4.1 /
         cartype & $25. parts;
datalines;
Bert Allen 1803 Knollton Ct. Bristol NC 29345 07012005 oil change      0.5
Jeep Cherokee 2000  18.00
Bert Allen 1803 Knollton Ct. Bristol NC 29345 01102006 replace brakes  2.0
Jeep Cherokee 2000  45.00
Bert Allen 1803 Knollton Ct. Bristol NC 29345 02202006 rotate tires    1.0
Jeep Cherokee 2000  20.00
Bert Allen 1803 Knollton Ct. Bristol NC 29345 02202006 transmission    5.5
Jeep Cherokee 2000  50.00
Bert Allen 1803 Knollton Ct. Bristol NC 29345 10192005 oil change      0.5
Ford F-150 1998  18.00
Bert Allen 1803 Knollton Ct. Bristol NC 29345 01102006 replace belts   1.5
Ford F-150 1998  0  35.00
Sara Jones 202 Stargate Dr.  Dart    NC 29445 12072005 align frontend  1.5
Chrysler Voyager 2003  20.00
Sara Jones 202 Stargate Dr.  Dart    NC 29445 12072005 rotate tires    1.0
Chrysler Voyager 2003  20.00
Joe Smith  1991 Cohansey St. New Ulm NC 29545 01192006 oil change      0.5
Ford F-150 1998  18.00
Joe Smith  1991 Cohansey St. New Ulm NC 29545 02252006 rotate tires    1.0
Ford F-150 1998  0  20.00
;;;;


/***************************************************************/
/* Create DEMOG Data Set                                       */
/* Used in Examples 4.2, 6.12                                  */
/***************************************************************/
proc format;
  value tmtdgfmt 0='Active'
                 1='Placebo';
run;
data demog;
  do i=1 to 200;
    patient=put(i,z3.);
    gender=(ranuni(770)<=0.5);
    height=ranuni(22878)*20+55;
    weight=ranuni(2179)*170+110;
    age=ranuni(51602)*65+20;
    race=(ranuni(7270)<=0.66);
    tmtdg=left(put((ranuni(76517)<=0.5),tmtdgfmt.));
    output;
  end;
run;


/***************************************************************/
/* Create FITNESS Data Set                                     */
/* Used in Examples 4.3                                        */
/***************************************************************/
data fitness(label = 'Exercise/fitness study table');
   input age weight runtime rstpulse runpulse maxpulse oxygen group;
   label age      = 'Age in years'
         weight   = 'Weight in kg'
         runtime  = 'Min. to run 1.5 miles'
         rstpulse = 'Heart rate while resting'
         runpulse = 'Heart rate while running'
         maxpulse = 'Maximum heart rate'
         oxygen   = 'Oxygen consumption'
         group    = 'Experimental group';
   cards;
57 73.37 12.63 58 174 176 39.407   2
54 79.38 11.17 62 156 165 46.080   2
52 76.32 9.63 48 164 166 45.441    2
50 70.87 8.92 48 146 155 54.625    2
51 67.25 11.08 48 172 172 45.118   2
54 91.63 12.88 44 168 172 39.203   2
51 73.71 10.47 59 186 188 45.790   2
57 59.08 9.93 49 148 155 50.545    2
49 76.32 9.4 56 186 188 48.673     2
48 61.24 11.5 52 170 176 47.920    2
52 82.78 10.5 53 170 172 47.467    2
44 73.03 10.13 45 168 168 50.541   1
45 87.66 14.03 56 186 192 37.388   1
45 66.45 11.12 51 176 176 44.754   1
47 79.15 10.6 47 162 164 47.273    1
54 83.12 10.33 50 166 170 51.855   1
49 81.42 8.95 44 180 185 49.156    1
51 69.63 10.95 57 168 172 40.836   1
51 77.91 10.00 48 162 168 46.672   1
48 91.63 10.25 48 162 164 46.774   1
49 73.37 10.08 76 168 168 50.388   1
44 89.47 11.37 62 178 182 44.609   0
40 75.07 10.07 62 185 185 45.313   0
44 85.84 8.65 45 156 168 54.297    0
42 68.15 8.17 40 166 172 59.571    0
38 89.02 9.22 55 178 180 49.874    0
47 77.45 11.63 58 176 176 44.811   0
40 75.98 11.95 70 176 180 45.681   0
43 81.19 10.85 64 162 170 49.091   0
44 81.42 13.08 63 174 176 39.442   0
38 81.87 8.63 48 170 186 60.055    0
;;;;



/***************************************************************/
/* Create INVENTORY Data Set                                   */
/* Used in Examples 5.1, 6.11                                  */
/***************************************************************/
data inventory;
  input partnmbr $ quantity price @@;
datalines;
B01-03/06 100  5.75 B02-03/08 100  6.60 B03-03/10  79  7.25
B04-03/12  37  7.80 B05-03/14   3  8.40 B06-03/16  15  7.95
B07-03/20  97  8.80 B08-03/25  24  4.25 B09-03/30  18  7.40
B10-03/06  92  7.10 B11-03/08  12  7.20 B12-03/10   9  7.70
B13-03/12   2  8.00 B14-03/14  37  8.80 B15-03/16  22  9.05
B16-03/20  15  9.20 B17-03/25  50  5.75 B18-03/30  50  8.00
B19-04/06 100 10.10 B20-04/08  33  5.90 B21-04/10  41  6.40
B22-04/12   7  6.80 B23-04/14  11  7.50 B24-04/16  17  6.95
B25-04/18  26  7.95 B26-04/20  31  7.20 B27-04/22  99  9.60
B28-04/25  50  3.95 B29-04/30  42  4.60 B30-04/06  87 11.60
B31-04/08  31  6.70 B32-04/10  11  7.10 B33-04/12   8  7.70
B34-04/14  14  8.80 B35-04/16  19  9.05 B36-04/18  17  9.60
B37-04/20  33  8.80 B38-04/22  51 11.20 B39-04/25  50  5.25
B40-04/30  47  5.50 B41-05/06  97 11.80 B42-05/08  13  6.40
B43-05/10  17  6.60 B44-05/12  15  6.80 B45-05/14   2  7.70
B46-05/16   4  6.60 B47-05/18  77  7.95 B48-05/20  11  7.20
B49-05/22  81  8.80 B50-05/25  50  4.15 B51-05/30  31  4.60
B52-05/06 100 13.75 B53-05/08  23  7.05 B54-05/10  59  7.10
B55-05/12  87  7.70 B56-05/14  22  7.95 B57-05/16  83  8.15
B58-05/18  16  8.45 B59-05/20  18  8.90 B60-05/22  29 10.40
B61-05/25  50  4.85 B62-05/30  31  5.25 B63-06/06 100 12.20
B64-06/08 100  7.00 B65-06/10  52  7.20 B66-06/12  43  7.45
B67-06/14  66  7.95 B68-06/16  69  8.05
;;;;

/***************************************************************/
/* Create STUDENTS Data Set                                    */
/* Used in Examples 5.2                                        */
/***************************************************************/
data students;
  length fullname $ 30 department $ 20 class $ 2;

  keep fullname department extension class;

  array dn{7} $ 20 _temporary_
                 ('Biochemistry' 'Biophysics'
                  'Microbiology' 'Ecology' 'Zoology and Behavior'
                  'Plant Sciences' 'Neurobiology');

  array ln{125} $ 15 _temporary_ (
'smith        '  'johnson      ' 'williams     ' 'jones        '
'brown        '  'davis        ' 'miller       ' 'wilson       '
'moore        '  'taylor       ' 'anderson     ' 'thomas       '
'jackson      '  'white        ' 'harris       ' 'martin       '
'thompson     '  'garcia       ' 'martinez     ' 'robinson     '
'clark        '  'rodriguez    ' 'lewis        ' 'lee          '
'walker       '  'hall         ' 'allen        ' 'young        '
'hernandez    '  'king         ' 'wright       ' 'lopez        '
'hill         '  'scott        ' 'green        ' 'adams        '
'baker        '  'gonzalez     ' 'nelson       ' 'carter       '
'mitchell     '  'perez        ' 'roberts      ' 'turner       '
'phillips     '  'campbell     ' 'parker       ' 'evans        '
'edwards      '  'collins      ' 'stewart      ' 'sanchez      '
'morris       '  'rogers       ' 'reed         ' 'cook         '
'morgan       '  'bell         ' 'murphy       ' 'bailey       '
'rivera       '  'cooper       ' 'richardson   ' 'cox          '
'howard       '  'ward         ' 'torres       ' 'peterson     '
'gray         '  'ramirez      ' 'james        ' 'watson       '
'brooks       '  'kelly        ' 'sanders      ' 'price        '
'bennett      '  'wood         ' 'barnes       ' 'ross         '
'henderson    '  'coleman      ' 'jenkins      ' 'perry        '
'powell       '  'long         ' 'patterson    ' 'hughes       '
'flores       '  'washington   ' 'butler       ' 'simmons      '
'foster       '  'gonzales     ' 'bryant       ' 'alexander    '
'russell      '  'griffin      ' 'diaz         ' 'hayes        '
'myers        '  'ford         ' 'hamilton     ' 'graham       '
'sullivan     '  'wallace      ' 'woods        ' 'cole         '
'west         '  'jordan       ' 'owens        ' 'reynolds     '
'fisher       '  'ellis        ' 'harrison     ' 'gibson       '
'mcdonald     '  'cruz         ' 'marshall     ' 'ortiz        '
'gomez        '  'murray       ' 'freeman      ' 'wells        '
'webb         ');

  array fnm{35} $ 11 _temporary_ (
'James      ' 'John       ' 'Robert     ' 'Michael    '
'William    ' 'David      ' 'Richard    ' 'Charles    '
'Joseph     ' 'Thomas     ' 'Christopher' 'Daniel     '
'Paul       ' 'Mark       ' 'Donald     ' 'George     '
'Kenneth    ' 'Steven     ' 'Edward     ' 'Brian      '
'Ronald     ' 'Anthony    ' 'Kevin      ' 'Jason      '
'Matthew    ' 'Gary       ' 'Timothy    ' 'Jose       '
'Larry      ' 'Jeffrey    ' 'Jacob      ' 'Joshua     '
'Ethan      ' 'Andrew     ' 'Nicholas   ');

array fnf{35}  $ 11 _temporary_ (
'Mary       ' 'Patricia   ' 'Linda      ' 'Barbara    '
'Elizabeth  ' 'Jennifer   ' 'Maria      ' 'Susan      '
'Margaret   ' 'Dorothy    ' 'Lisa       ' 'Nancy      '
'Karen      ' 'Betty      ' 'Helen      ' 'Sandra     '
'Donna      ' 'Carol      ' 'Ruth       ' 'Sharon     '
'Michelle   ' 'Laura      ' 'Sarah      ' 'Kimberly   '
'Deborah    ' 'Jessica    ' 'Shirley    ' 'Cynthia    '
'Angela     ' 'Melissa    ' 'Emily      ' 'Hannah     '
'Emma       ' 'Ashley     ' 'Abigail    ');

  do i=1 to 149;
    lnptr=round(125*(uniform(38284)),1.);

    if lnptr=0 then lnptr=1;
    lastname=ln{lnptr};

    fnptr=round(35*(uniform(61961)),1.);
    if fnptr=0 then fnptr=1;
    if i le 90 then firstname=fnf{fnptr};
    else firstname=fnm{fnptr};

    fullname=trim(lastname) || ', ' || trim(firstname);
    substr(fullname,1,1)=upcase(substr(fullname,1,1));

    if mod(i,2)=0 then class='JR';
    else class='SR';

    if i le 35 then department=dn{1};
    else if 36 le i le 49 then department=dn{2};
    else if 50 le i le 77 then department=dn{3};
    else if 78 le i le 100 then department=dn{4};
    else if 101 le i le 123 then department=dn{5};
    else if 124 le i le 136 then department=dn{6};
    else if i ge 137 then department=dn{7};

    extension=5000+round(1000*uniform(10438),1.);
    output;
  end;
run;


/***************************************************************/
/* Create BREADSTATS Data Set                                  */
/* Used in Examples 6.13                                       */
/***************************************************************/
data bread;
  infile datalines dsd;
  attrib source      length=$7  label='Source'
         brand length=$16 label='Brand'
         type        length=$15 label='Type of Bread'
         flavor      length=$20 label='Flavor'
         calories    label='Calories per Slice'
         total_fat   label='Total Fat(g) per Slice'
         dietary_fiber label='Dietary Fiber(g) per Slice'
         protein       label='Protein(g) per Slice'
         total_carb    label='Total Carbohydrates(g) per Slice';
  input source $ brand $ type $ flavor $
        calories total_fat dietary_fiber protein total_carb;
datalines;
Grocery,Fabulous Breads,White,Regular,71,1.5,0.5,2.1,12.1
Grocery,Fabulous Breads,White,Egg,92,0.5,0.5,3.3,18.2
Grocery,Fabulous Breads,White,Buttertop,97,1.5,0,3.1,17.5
Grocery,Fabulous Breads,Whole Wheat,Regular,90,1.1,3.1,4.4,15.3
Grocery,Fabulous Breads,Whole Wheat,100% Whole Wheat,74,0.5,1.8,2,15
Grocery,Fabulous Breads,Whole Wheat,Bran,89,2.1,2.8,3.2,14.1
Grocery,Fabulous Breads,Whole Wheat,Sandwich,82,1,1.6,2.9,15.1
Grocery,Fabulous Breads,Rye,Regular,78,0.5,1.6,3,15.1
Grocery,Fabulous Breads,Pumpernickel,Regular,87,1.2,3.1,3.5,15.2
Grocery,Fabulous Breads,Multigrain,Regular,81,1.1,1.5,3,14.4
Grocery,Fabulous Breads,Multigrain,Eight Grain,78,0.9,3.2,2.9,14.4
Grocery,Fabulous Breads,Multigrain,Cornmeal,79,0.7,2.1,3,14.9
Grocery,Fabulous Breads,Raisin Cinnamon,Regular,82,0.7,1.5,3,15.7
Grocery,Fabulous Breads,Oatmeal,Regular,85,1,3,3.9,14.8
Grocery,Fabulous Breads,Sourdough,Regular,77,0.3,1.3,2.9,15.4
Grocery,Gaia's Hearth,White,Regular,91,1.8,0.6,3.1,15.4
Grocery,Gaia's Hearth,Whole Wheat,Regular,101,0.8,2.3,4.6,18.5
Grocery,Gaia's Hearth,Whole Wheat,100% Whole Wheat,80,0.9,2.2,3.1,14.6
Grocery,Gaia's Hearth,Rye,Regular,85,0.9,1.3,2.8,16.1
Grocery,Gaia's Hearth,Pumpernickel,Regular,92,0.9,3.6,3.9,16.7
Grocery,Gaia's Hearth,Multigrain,Regular,92,1.6,2.3,3.7,15.4
Grocery,Gaia's Hearth,Multigrain,High Protein,81,0.5,2.1,4.2,14.6
Grocery,Gaia's Hearth,Multigrain,Spelt,87,1.2,0,3.6,15.2
Grocery,Gaia's Hearth,Raisin Cinnamon,Regular,98,1.3,0.9,2.8,18.6
Grocery,Gaia's Hearth,Oatmeal,Regular,95,1.7,3.5,3.8,15.9
Grocery,Gaia's Hearth,Sourdough,Regular,77,0.5,1.3,2.6,15.3
Grocery,RiseNShine Breads,White,Regular,56,0.7,1,2.2,10
Grocery,RiseNShine Breads,White,Potato,96,0.5,0.9,3.2,19.3
Grocery,RiseNShine Breads,White,Honey,74,0.5,1.7,2.1,15
Grocery,RiseNShine Breads ,Whole Wheat,Regular,80,0.5,2,3.3,15.2
Grocery,RiseNShine Breads ,Rye,Regular,84,0.5,1.5,2.9,16.6
Grocery,RiseNShine Breads ,Multigrain,Regular,76,1.1,1.6,2.8,13.5
Grocery,RiseNShine Breads ,Multigrain,Six Grain,89,1.6,3.1,3.3,15.2
Grocery,RiseNShine Breads ,Raisin Cinnamon,Regular,100,1.5,1.4,2.3,19
Grocery,Mill City Bakers,White,Regular,66,1.4,0.8,2.1,11
Grocery,Mill City Bakers,White,Toaster,112,2.6,0.5,3.4,18.6
Grocery,Mill City Bakers ,Whole Wheat,Regular,88,0.9,2.6,3.6,16
Grocery,Mill City Bakers ,Rye,Regular,71,0.3,1.3,2.6,14.3
Grocery,Mill City Bakers ,Multigrain,Regular,77,0.8,2.2,2.9,14.2
Grocery,Mill City Bakers ,Multigrain,Low Carb,88,2.5,2.3,6,10
Grocery,Mill City Bakers ,Multigrain,Sandwich,87,1.4,2.9,3.1,15.2
Grocery,Mill City Bakers ,Multigrain,Soy ,99,2.5,3.1,4.2,14.7
Grocery,Mill City Bakers ,Sourdough,Regular,80,0.6,1.6,2.5,15.9
Grocery,Owasco Ovens,White,Regular,83,1.9,0.8,1.8,14.3
Grocery,Owasco Ovens ,Whole Wheat,Regular,75,1.2,1,2.5,13.3
Grocery,Owasco Ovens ,Whole Wheat,Bran,79,1.2,4.8,3.9,13
Grocery,Owasco Ovens ,Whole Wheat,100% Whole Wheat,72,0.8,4,4,12
Grocery,Owasco Ovens ,Rye,Regular,80,1,1,2.5,15.1
Grocery,Owasco Ovens ,Pumpernickel,Regular,92,0.9,2.9,3.7,17
Grocery,Owasco Ovens ,Multigrain,Regular,87,1.1,2.2,3.1,16
Grocery,Owasco Ovens ,Multigrain,Rustic,92,1.6,2.3,3.7,15.4
Grocery,Owasco Ovens ,Multigrain,Eight Grain,86,1.3,1.8,2.9,15.5
Grocery,Owasco Ovens ,Raisin Cinnamon,Regular,85,0.5,1.7,3.3,16.6
Grocery,Owasco Ovens ,Oatmeal,Regular,90,0.7,2.8,4.1,16.6
Grocery,Owasco Ovens ,Sourdough,Regular,79,0.4,1.1,2.7,15.8
Grocery,Choice 123,White,Regular,71,1.1,1.5,1.9,13.1
Grocery,Choice 123,White,Egg,87,1.8,1,2.9,14.5
Grocery,Choice 123,White,Sandwich,71,1.2,0.5,2,12.8
Grocery,Choice 123,Whole Wheat,Regular,87,1,1.8,3.1,16.2
Grocery,Choice 123,Multigrain,Regular,76,1.5,2,2.4,13
Grocery,Choice 123,Multigrain,Seven Grain,92,1.6,2.3,3.7,15.4
Grocery,BBB Brands,White,Regular,65,0.5,1.2,1.9,13
Grocery,BBB Brands,Whole Wheat,Regular,90,1.8,2.6,2.8,15.4
Grocery,BBB Brands,Rye,Regular,82,1,1.5,2.6,15.3
Grocery,BBB Brands,Pumpernickel,Regular,84,0.8,2,2.7,16.2
Grocery,BBB Brands,Multigrain,Regular,88,2,1.5,2.3,15
Grocery,Five Chimneys,White,Regular,92,1.6,2.3,3.7,15.4
Grocery,Five Chimneys,Whole Wheat,Regular,90,0.9,2.9,3.1,17.2
Grocery,Five Chimneys,Whole Wheat,Bran,83,1,3.8,3.6,14.6
Grocery,Five Chimneys,Rye,Regular,77,0.5,1.2,2.8,15.1
Grocery,Five Chimneys,Pumpernickel,Regular,98,1,3.5,3.8,18.1
Grocery,Five Chimneys,Multigrain,Regular,97,2.1,2.6,4,15.2
Grocery,Five Chimneys,Multigrain,Sandwich,88,1.6,2.3,2.8,15.4
Grocery,Five Chimneys,Raisin Cinnamon,Regular,82,0.5,2,2.6,16.4
Grocery,Five Chimneys,Oatmeal,Regular,84,0.5,3.3,3.7,15.8
Grocery,Five Chimneys,Sourdough,Regular,75,0.3,1.6,2.8,15.1
Bakery,Downtown Bakers,White,Regular,106,2.1,1.6,2.7,18.7
Bakery,Downtown Bakers,White,Baguette,138,1,1,6,26
Bakery,Downtown Bakers,Whole Wheat,Regular,90,1.4,3,3.5,15.5
Bakery,Downtown Bakers,Whole Wheat,Bran,85,1.5,4.3,3.3,14.2
Bakery,Downtown Bakers,Rye,Regular,82,0.6,1.4,2.8,16.1
Bakery,Downtown Bakers,Pumpernickel,Regular,94,1,3,3.4,17.5
Bakery,Downtown Bakers,Multigrain,Regular,90,1.8,3,3.4,14.9
Bakery,Downtown Bakers,Multigrain,Flax and Soy,95,2.4,2.3,4,14.1
Bakery,Downtown Bakers,Raisin Cinnamon,Regular,107,0.3,2.9,3.4,22.5
Bakery,Downtown Bakers,Sourdough,Regular,82,0.5,1,2.5,16.7
Bakery,Pain du Prairie,White,Regular,108,1.7,2.1,2.6,20.2
Bakery,Pain du Prairie,White,Rustic,88,1.7,0.3,2.6,15.3
Bakery,Pain du Prairie,White,Foccacia,93,3.9,1.4,3.4,10.8
Bakery,Pain du Prairie,White,Baguette,98,0.5,0.7,3.5,19.5
Bakery,Pain du Prairie,Whole Wheat,Regular,80,1.1,2.9,3.2,14.1
Bakery,Pain du Prairie,Whole Wheat,Organic,86,1.6,2.8,3.6,14.1
Bakery,Pain du Prairie,Whole Wheat,Bran,76,0.8,4.4,3.4,13.6
Bakery,Pain du Prairie,Rye,Regular,84,1.1,1.6,2.9,15.4
Bakery,Pain du Prairie,Pumpernickel,Regular,87,0.9,2.5,3,16.5
Bakery,Pain du Prairie,Multigrain,Regular,88,1.3,2.3,3.6,15.1
Bakery,Pain du Prairie,Multigrain,Organic,82,0.5,2.3,3.7,15.4
Bakery,Pain du Prairie,Raisin Cinnamon,Regular,82,1.5,0.5,2.2,14.6
Bakery,Pain du Prairie,Sourdough,Regular,74,0.3,0.8,2.7,14.9
Bakery,Aunt Sal Bakes,White,Regular,93,1.5,1.3,2.8,16.7
Bakery,Aunt Sal Bakes,White,Toaster,105,2.3,0.5,3.1,17.6
Bakery,Aunt Sal Bakes,White,Baguette,94,0.5,1,4,18
Bakery,Aunt Sal Bakes,Whole Wheat,Regular,97,1.5,2.4,3.6,17.1
Bakery,Aunt Sal Bakes,Whole Wheat,Nutty,81,1.3,1.5,2.8,14.2
Bakery,Aunt Sal Bakes,Rye,Regular,81,0.5,1,2.8,16
Bakery,Aunt Sal Bakes,Pumpernickel,Regular,97,1.2,3.5,4.1,17.3
Bakery,Aunt Sal Bakes,Multigrain,Regular,99,1.9,3.9,3.9,16.4
Bakery,Aunt Sal Bakes,Raisin Cinnamon,Regular,92,1.6,2.3,3.7,15.4
Bakery,Aunt Sal Bakes,Sourdough,Regular,74,0.2,1,2.7,15.1
Bakery,Demeter,White,Regular,73,1.3,0.5,2,13.1
Bakery,Demeter,White,Rustic,97,2.1,0.5,3,16.2
Bakery,Demeter,White,Baguette,98,0.5,0.5,3,20
Bakery,Demeter,Whole Wheat,Regular,97,2,3.3,3.9,15.6
Bakery,Demeter,Whole Wheat,Bran,101,2.3,3.9,3.7,16
Bakery,Demeter,Whole Wheat,Nutty,99,1.5,2.7,3.9,17.3
Bakery,Demeter,Rye,Regular,94,1.1,1.5,3,17.8
Bakery,Demeter,Pumpernickel,Regular,105,1.2,4.2,4.2,19.2
Bakery,Demeter,Multigrain,Regular,97,2.1,3.5,3.6,15.7
Bakery,Demeter,Multigrain,Cornmeal,95,1.6,2.3,3.7,16.1
Bakery,Demeter,Multigrain,Ten Grain,108,0.5,3.3,4.1,21.5
Bakery,Demeter,Multigrain,High Omega,102,1.5,2.3,3.7,18.1
Bakery,Demeter,Raisin Cinnamon,Regular,102,0.6,1,2.9,21.1
Bakery,Demeter,Oatmeal,Regular,111,1.5,3.9,3.6,20.6
Bakery,Demeter,Sourdough,Regular,71,0.4,0.9,3,13.6
;;;;
proc means data=bread n mean min max
           maxdec=2 fw=7
           nonobs;

  title 'Nutritional Information about Breads Available in the Region';
  title2 'Values Per Bread Slice, Calories in kcal, Fiber in Grams';

  class source brand type flavor;
  types () source source*brand type flavor source*flavor;

  var calories dietary_fiber;
  output out=breadstats
         idgroup(min(calories) out[3]
           (brand type flavor calories)=
            wherecal typecal flavorcal mincal)
         idgroup(max(dietary_fiber) out[3]
           (brand type flavor dietary_fiber)=
            wherefiber typefiber flavorfiber maxfiber);

  label calories=' '
        dietary_fiber=' ';

  format flavor $flavor.;
run;

