/*-------------------------------------------------------------------*/
/*                                                                   */
/* Map Made Easy Using SAS                                           */
/* by Mike Zdeb                                                      */
/* Copyright(c) 2002 by SAS Institute Inc., Cary, NC, USA            */
/* SAS Publications order # 57495                                    */
/* ISBN 1-59047-093-1                                                */
/*                                                                   */
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
/*                                                                   */
/* Questions or problem reports concerning this material may be      */
/* addressed to the author:                                          */
/*                                                                   */
/* SAS Institute Inc.                                                */
/* Books by Users                                                    */
/* Attn: Mike Zdeb                                                   */
/* SAS Campus Drive                                                  */
/* Cary, NC   27513                                                  */
/*                                                                   */
/* If you prefer, you can send email to:  sasbbu@sas.com             */
/* Use this for subject field:                                       */
/* Comments for Mike Zdeb                                            */
/*                                                                   */
/*-------------------------------------------------------------------*/
/* Date Last Updated: August  28, 2002                               */
/*-------------------------------------------------------------------*/
/*                                                                   */
/* Please NOTE...                                                    */
/*                                                                   */
/* PART ONE of this file contains the SAS DATA steps that            */
/* are shown in the Appendices of Maps Made Easy Using SAS. These    */ 
/* DATA steps produce the data sets that are used in the examples.   */ 
/* Create these data sets first so that your examples will run       */ 
/* without problems.                                                 */ 
/*                                                                   */ 
/* PART TWO of this file contains the SAS PROC steps that            */
/* are shown in the book's examples. Each code segment is labeled    */
/* with the chapter and example number. 
/*                                                                   */
/* Some examples in this file may differ slightly from the code      */
/* presented in the book:                                            */
/*                                                                   */
/* A LEGEND statement may be added prior to PROC GMAP and a          */
/* LEGEND option may be added to PROC GMAP in order to make the      */
/* output conform to that displayed in the book.                     */
/*                                                                   */
/* A GOPTIONS statement in Appendix C controls the appearance        */
/* of text in some examples.  It is added to examples when needed.   */
/*                                                                   */
/* A GOPTIONS statement in Example #3 of Chapter #3 reduces the      */
/* overall size of the graphics output, resulting in the text in     */
/* appearing close to the map as shown in the book.                  */
/*                                                                   */
/* A GOPTIONS statement in Appendix C can be used to direct          */
/* PROC GMAP output to a GIF file rather than the graphics output    */
/* window.                                                           */
/*                                                                   */
/* All current GOPTIONS settings are cleared prior to running        */
/* each example by using the statement... GOPTIONS RESET=ALL;        */
/*                                                                   */
/*-------------------------------------------------------------------*/

/*****************************PART ONE********************************/


/*-------------------------------------------------------------------*/
/*--------------------------APPENDIX A-------------------------------*/
/*-------------------------------------------------------------------*/


/* APPENDIX 1.1 -----------------------------------------------------*/

data us2000st;
   informat region $9. pop2000 pop1990 comma.;
   input state region pop2000 pop1990 @@;
   label
   state   = 'State FIPS Code'
   pop2000 = 'Year 2000 Census Population'
   pop1990 = 'Year 1990 Census Population'
   region  = 'Census Region'
   ;
datalines;
01 SOUTH         4,447,100   4,040,587   02 WEST            626,932     550,043
04 WEST          5,130,632   3,665,228   05 SOUTH         2,673,400   2,350,725
06 WEST         33,871,648  29,760,021   08 WEST          4,301,261   3,294,394
09 NORTHEAST     3,405,565   3,287,116   10 SOUTH           783,600     666,168
11 SOUTH           572,059     606,900   12 SOUTH        15,982,378  12,937,926
13 SOUTH         8,186,453   6,478,216   15 WEST          1,211,537   1,108,229
16 WEST          1,293,953   1,006,749   17 MIDWEST      12,419,293  11,430,602
18 MIDWEST       6,080,485   5,544,159   19 MIDWEST       2,926,324   2,776,755
20 MIDWEST       2,688,418   2,477,574   21 SOUTH         4,041,769   3,685,296
22 SOUTH         4,468,976   4,219,973   23 NORTHEAST     1,274,923   1,227,928
24 SOUTH         5,296,486   4,781,468   25 NORTHEAST     6,349,097   6,016,425
26 MIDWEST       9,938,444   9,295,297   27 MIDWEST       4,919,479   4,375,099
28 SOUTH         2,844,658   2,573,216   29 MIDWEST       5,595,211   5,117,073
30 WEST            902,195     799,065   31 MIDWEST       1,711,263   1,578,385
32 WEST          1,998,257   1,201,833   33 NORTHEAST     1,235,786   1,109,252
34 NORTHEAST     8,414,350   7,730,188   35 WEST          1,819,046   1,515,069
36 NORTHEAST    18,976,457  17,990,455   37 SOUTH         8,049,313   6,628,637
38 MIDWEST         642,200     638,800   39 MIDWEST      11,353,140  10,847,115
40 SOUTH         3,450,654   3,145,585   41 WEST          3,421,399   2,842,321
42 NORTHEAST    12,281,054  11,881,643   44 NORTHEAST     1,048,319   1,003,464
45 SOUTH         4,012,012   3,486,703   46 MIDWEST         754,844     696,004
47 SOUTH         5,689,283   4,877,185   48 SOUTH        20,851,820  16,986,510
49 WEST          2,233,169   1,722,850   50 NORTHEAST       608,827     562,758
51 SOUTH         7,078,515   6,187,358   53 WEST          5,894,121   4,866,692
54 SOUTH         1,808,344   1,793,477   55 MIDWEST       5,363,675   4,891,769
56 WEST            493,782     453,588
;
run;
/*-------------------------------------------------------------------*/


/* APPENDIX 1.2 -----------------------------------------------------*/

data us2000co;
input
@01 state          2.
@03 county         3.
@07 cname        $35.
@54 pop1990  comma16.
@70 pop2000  comma16.
;
* remove word County from variable CNAME;
cname = tranwrd(cname,' County','');

label
state    = 'State FIPS Code'
county   = 'County FIPS Code'
cname    = 'County Name'
pop1990  = 'Census Population in 1990'
pop2000  = 'Census Population in 2000'
;
datalines;
01001 Autauga County                               AL          34,222          43,671
01003 Baldwin County                               AL          98,280         140,415
01005 Barbour County                               AL          25,417          29,038
01007 Bibb County                                  AL          16,576          20,826
01009 Blount County                                AL          39,248          51,024
01011 Bullock County                               AL          11,042          11,714
01013 Butler County                                AL          21,892          21,399
01015 Calhoun County                               AL         116,034         112,249
01017 Chambers County                              AL          36,876          36,583
01019 Cherokee County                              AL          19,543          23,988
01021 Chilton County                               AL          32,458          39,593
01023 Choctaw County                               AL          16,018          15,922
01025 Clarke County                                AL          27,240          27,867
01027 Clay County                                  AL          13,252          14,254
01029 Cleburne County                              AL          12,730          14,123
01031 Coffee County                                AL          40,240          43,615
01033 Colbert County                               AL          51,666          54,984
01035 Conecuh County                               AL          14,054          14,089
01037 Coosa County                                 AL          11,063          12,202
01039 Covington County                             AL          36,478          37,631
01041 Crenshaw County                              AL          13,635          13,665
01043 Cullman County                               AL          67,613          77,483
01045 Dale County                                  AL          49,633          49,129
01047 Dallas County                                AL          48,130          46,365
01049 DeKalb County                                AL          54,651          64,452
01051 Elmore County                                AL          49,210          65,874
01053 Escambia County                              AL          35,518          38,440
01055 Etowah County                                AL          99,840         103,459
01057 Fayette County                               AL          17,962          18,495
01059 Franklin County                              AL          27,814          31,223
01061 Geneva County                                AL          23,647          25,764
01063 Greene County                                AL          10,153           9,974
01065 Hale County                                  AL          15,498          17,185
01067 Henry County                                 AL          15,374          16,310
01069 Houston County                               AL          81,331          88,787
01071 Jackson County                               AL          47,796          53,926
01073 Jefferson County                             AL         651,525         662,047
01075 Lamar County                                 AL          15,715          15,904
01077 Lauderdale County                            AL          79,661          87,966
01079 Lawrence County                              AL          31,513          34,803
01081 Lee County                                   AL          87,146         115,092
01083 Limestone County                             AL          54,135          65,676
01085 Lowndes County                               AL          12,658          13,473
01087 Macon County                                 AL          24,928          24,105
01089 Madison County                               AL         238,912         276,700
01091 Marengo County                               AL          23,084          22,539
01093 Marion County                                AL          29,830          31,214
01095 Marshall County                              AL          70,832          82,231
01097 Mobile County                                AL         378,643         399,843
01099 Monroe County                                AL          23,968          24,324
01101 Montgomery County                            AL         209,085         223,510
01103 Morgan County                                AL         100,043         111,064
01105 Perry County                                 AL          12,759          11,861
01107 Pickens County                               AL          20,699          20,949
01109 Pike County                                  AL          27,595          29,605
01111 Randolph County                              AL          19,881          22,380
01113 Russell County                               AL          46,860          49,756
01115 St. Clair County                             AL          50,009          64,742
01117 Shelby County                                AL          99,358         143,293
01119 Sumter County                                AL          16,174          14,798
01121 Talladega County                             AL          74,107          80,321
01123 Tallapoosa County                            AL          38,826          41,475
01125 Tuscaloosa County                            AL         150,522         164,875
01127 Walker County                                AL          67,670          70,713
01129 Washington County                            AL          16,694          18,097
01131 Wilcox County                                AL          13,568          13,183
01133 Winston County                               AL          22,053          24,843
02013 Aleutians East Borough                       AK           2,464           2,697
02016 Aleutians West Census Area                   AK           9,478           5,465
02020 Anchorage Borough                            AK         226,338         260,283
02050 Bethel Census Area                           AK          13,656          16,006
02060 Bristol Bay Borough                          AK           1,410           1,258
02068 Denali Borough                               AK           1,764           1,893
02070 Dillingham Census Area                       AK           4,012           4,922
02090 Fairbanks North Star Borough                 AK          77,720          82,840
02100 Haines Borough                               AK           2,117           2,392
02110 Juneau Borough                               AK          26,751          30,711
02122 Kenai Peninsula Borough                      AK          40,802          49,691
02130 Ketchikan Gateway Borough                    AK          13,828          14,070
02150 Kodiak Island Borough                        AK          13,309          13,913
02164 Lake and Peninsula Borough                   AK           1,668           1,823
02170 Matanuska-Susitna Borough                    AK          39,683          59,322
02180 Nome Census Area                             AK           8,288           9,196
02185 North Slope Borough                          AK           5,979           7,385
02188 Northwest Arctic Borough                     AK           6,113           7,208
02201 Prince of Wales-Outer Ketchikan Census Area  AK           6,278           6,146
02220 Sitka Borough                                AK           8,588           8,835
02232 Skagway-Hoonah-Angoon Census Area            AK           3,680           3,436
02240 Southeast Fairbanks Census Area              AK           5,913           6,174
02261 Valdez-Cordova Census Area                   AK           9,952          10,195
02270 Wade Hampton Census Area                     AK           5,791           7,028
02280 Wrangell-Petersburg Census Area              AK           7,042           6,684
02282 Yakutat Borough                              AK             705             808
02290 Yukon-Koyukuk Census Area                    AK           6,714           6,551
04001 Apache County                                AZ          61,591          69,423
04003 Cochise County                               AZ          97,624         117,755
04005 Coconino County                              AZ          96,591         116,320
04007 Gila County                                  AZ          40,216          51,335
04009 Graham County                                AZ          26,554          33,489
04011 Greenlee County                              AZ           8,008           8,547
04012 La Paz County                                AZ          13,844          19,715
04013 Maricopa County                              AZ       2,122,101       3,072,149
04015 Mohave County                                AZ          93,497         155,032
04017 Navajo County                                AZ          77,658          97,470
04019 Pima County                                  AZ         666,880         843,746
04021 Pinal County                                 AZ         116,379         179,727
04023 Santa Cruz County                            AZ          29,676          38,381
04025 Yavapai County                               AZ         107,714         167,517
04027 Yuma County                                  AZ         106,895         160,026
05001 Arkansas County                              AR          21,653          20,749
05003 Ashley County                                AR          24,319          24,209
05005 Baxter County                                AR          31,186          38,386
05007 Benton County                                AR          97,499         153,406
05009 Boone County                                 AR          28,297          33,948
05011 Bradley County                               AR          11,793          12,600
05013 Calhoun County                               AR           5,826           5,744
05015 Carroll County                               AR          18,654          25,357
05017 Chicot County                                AR          15,713          14,117
05019 Clark County                                 AR          21,437          23,546
05021 Clay County                                  AR          18,107          17,609
05023 Cleburne County                              AR          19,411          24,046
05025 Cleveland County                             AR           7,781           8,571
05027 Columbia County                              AR          25,691          25,603
05029 Conway County                                AR          19,151          20,336
05031 Craighead County                             AR          68,956          82,148
05033 Crawford County                              AR          42,493          53,247
05035 Crittenden County                            AR          49,939          50,866
05037 Cross County                                 AR          19,225          19,526
05039 Dallas County                                AR           9,614           9,210
05041 Desha County                                 AR          16,798          15,341
05043 Drew County                                  AR          17,369          18,723
05045 Faulkner County                              AR          60,006          86,014
05047 Franklin County                              AR          14,897          17,771
05049 Fulton County                                AR          10,037          11,642
05051 Garland County                               AR          73,397          88,068
05053 Grant County                                 AR          13,948          16,464
05055 Greene County                                AR          31,804          37,331
05057 Hempstead County                             AR          21,621          23,587
05059 Hot Spring County                            AR          26,115          30,353
05061 Howard County                                AR          13,569          14,300
05063 Independence County                          AR          31,192          34,233
05065 Izard County                                 AR          11,364          13,249
05067 Jackson County                               AR          18,944          18,418
05069 Jefferson County                             AR          85,487          84,278
05071 Johnson County                               AR          18,221          22,781
05073 Lafayette County                             AR           9,643           8,559
05075 Lawrence County                              AR          17,457          17,774
05077 Lee County                                   AR          13,053          12,580
05079 Lincoln County                               AR          13,690          14,492
05081 Little River County                          AR          13,966          13,628
05083 Logan County                                 AR          20,557          22,486
05085 Lonoke County                                AR          39,268          52,828
05087 Madison County                               AR          11,618          14,243
05089 Marion County                                AR          12,001          16,140
05091 Miller County                                AR          38,467          40,443
05093 Mississippi County                           AR          57,525          51,979
05095 Monroe County                                AR          11,333          10,254
05097 Montgomery County                            AR           7,841           9,245
05099 Nevada County                                AR          10,101           9,955
05101 Newton County                                AR           7,666           8,608
05103 Ouachita County                              AR          30,574          28,790
05105 Perry County                                 AR           7,969          10,209
05107 Phillips County                              AR          28,838          26,445
05109 Pike County                                  AR          10,086          11,303
05111 Poinsett County                              AR          24,664          25,614
05113 Polk County                                  AR          17,347          20,229
05115 Pope County                                  AR          45,883          54,469
05117 Prairie County                               AR           9,518           9,539
05119 Pulaski County                               AR         349,660         361,474
05121 Randolph County                              AR          16,558          18,195
05123 St. Francis County                           AR          28,497          29,329
05125 Saline County                                AR          64,183          83,529
05127 Scott County                                 AR          10,205          10,996
05129 Searcy County                                AR           7,841           8,261
05131 Sebastian County                             AR          99,590         115,071
05133 Sevier County                                AR          13,637          15,757
05135 Sharp County                                 AR          14,109          17,119
05137 Stone County                                 AR           9,775          11,499
05139 Union County                                 AR          46,719          45,629
05141 Van Buren County                             AR          14,008          16,192
05143 Washington County                            AR         113,409         157,715
05145 White County                                 AR          54,676          67,165
05147 Woodruff County                              AR           9,520           8,741
05149 Yell County                                  AR          17,759          21,139
06001 Alameda County                               CA       1,279,182       1,443,741
06003 Alpine County                                CA           1,113           1,208
06005 Amador County                                CA          30,039          35,100
06007 Butte County                                 CA         182,120         203,171
06009 Calaveras County                             CA          31,998          40,554
06011 Colusa County                                CA          16,275          18,804
06013 Contra Costa County                          CA         803,732         948,816
06015 Del Norte County                             CA          23,460          27,507
06017 El Dorado County                             CA         125,995         156,299
06019 Fresno County                                CA         667,490         799,407
06021 Glenn County                                 CA          24,798          26,453
06023 Humboldt County                              CA         119,118         126,518
06025 Imperial County                              CA         109,303         142,361
06027 Inyo County                                  CA          18,281          17,945
06029 Kern County                                  CA         543,477         661,645
06031 Kings County                                 CA         101,469         129,461
06033 Lake County                                  CA          50,631          58,309
06035 Lassen County                                CA          27,598          33,828
06037 Los Angeles County                           CA       8,863,164       9,519,338
06039 Madera County                                CA          88,090         123,109
06041 Marin County                                 CA         230,096         247,289
06043 Mariposa County                              CA          14,302          17,130
06045 Mendocino County                             CA          80,345          86,265
06047 Merced County                                CA         178,403         210,554
06049 Modoc County                                 CA           9,678           9,449
06051 Mono County                                  CA           9,956          12,853
06053 Monterey County                              CA         355,660         401,762
06055 Napa County                                  CA         110,765         124,279
06057 Nevada County                                CA          78,510          92,033
06059 Orange County                                CA       2,410,556       2,846,289
06061 Placer County                                CA         172,796         248,399
06063 Plumas County                                CA          19,739          20,824
06065 Riverside County                             CA       1,170,413       1,545,387
06067 Sacramento County                            CA       1,041,219       1,223,499
06069 San Benito County                            CA          36,697          53,234
06071 San Bernardino County                        CA       1,418,380       1,709,434
06073 San Diego County                             CA       2,498,016       2,813,833
06075 San Francisco County                         CA         723,959         776,733
06077 San Joaquin County                           CA         480,628         563,598
06079 San Luis Obispo County                       CA         217,162         246,681
06081 San Mateo County                             CA         649,623         707,161
06083 Santa Barbara County                         CA         369,608         399,347
06085 Santa Clara County                           CA       1,497,577       1,682,585
06087 Santa Cruz County                            CA         229,734         255,602
06089 Shasta County                                CA         147,036         163,256
06091 Sierra County                                CA           3,318           3,555
06093 Siskiyou County                              CA          43,531          44,301
06095 Solano County                                CA         340,421         394,542
06097 Sonoma County                                CA         388,222         458,614
06099 Stanislaus County                            CA         370,522         446,997
06101 Sutter County                                CA          64,415          78,930
06103 Tehama County                                CA          49,625          56,039
06105 Trinity County                               CA          13,063          13,022
06107 Tulare County                                CA         311,921         368,021
06109 Tuolumne County                              CA          48,456          54,501
06111 Ventura County                               CA         669,016         753,197
06113 Yolo County                                  CA         141,092         168,660
06115 Yuba County                                  CA          58,228          60,219
08001 Adams County                                 CO         265,038         363,857
08003 Alamosa County                               CO          13,617          14,966
08005 Arapahoe County                              CO         391,511         487,967
08007 Archuleta County                             CO           5,345           9,898
08009 Baca County                                  CO           4,556           4,517
08011 Bent County                                  CO           5,048           5,998
08013 Boulder County                               CO         225,339         291,288
08015 Chaffee County                               CO          12,684          16,242
08017 Cheyenne County                              CO           2,397           2,231
08019 Clear Creek County                           CO           7,619           9,322
08021 Conejos County                               CO           7,453           8,400
08023 Costilla County                              CO           3,190           3,663
08025 Crowley County                               CO           3,946           5,518
08027 Custer County                                CO           1,926           3,503
08029 Delta County                                 CO          20,980          27,834
08031 Denver County                                CO         467,610         554,636
08033 Dolores County                               CO           1,504           1,844
08035 Douglas County                               CO          60,391         175,766
08037 Eagle County                                 CO          21,928          41,659
08039 Elbert County                                CO           9,646          19,872
08041 El Paso County                               CO         397,014         516,929
08043 Fremont County                               CO          32,273          46,145
08045 Garfield County                              CO          29,974          43,791
08047 Gilpin County                                CO           3,070           4,757
08049 Grand County                                 CO           7,966          12,442
08051 Gunnison County                              CO          10,273          13,956
08053 Hinsdale County                              CO             467             790
08055 Huerfano County                              CO           6,009           7,862
08057 Jackson County                               CO           1,605           1,577
08059 Jefferson County                             CO         438,430         527,056
08061 Kiowa County                                 CO           1,688           1,622
08063 Kit Carson County                            CO           7,140           8,011
08065 Lake County                                  CO           6,007           7,812
08067 La Plata County                              CO          32,284          43,941
08069 Larimer County                               CO         186,136         251,494
08071 Las Animas County                            CO          13,765          15,207
08073 Lincoln County                               CO           4,529           6,087
08075 Logan County                                 CO          17,567          20,504
08077 Mesa County                                  CO          93,145         116,255
08079 Mineral County                               CO             558             831
08081 Moffat County                                CO          11,357          13,184
08083 Montezuma County                             CO          18,672          23,830
08085 Montrose County                              CO          24,423          33,432
08087 Morgan County                                CO          21,939          27,171
08089 Otero County                                 CO          20,185          20,311
08091 Ouray County                                 CO           2,295           3,742
08093 Park County                                  CO           7,174          14,523
08095 Phillips County                              CO           4,189           4,480
08097 Pitkin County                                CO          12,661          14,872
08099 Prowers County                               CO          13,347          14,483
08101 Pueblo County                                CO         123,051         141,472
08103 Rio Blanco County                            CO           5,972           5,986
08105 Rio Grande County                            CO          10,770          12,413
08107 Routt County                                 CO          14,088          19,690
08109 Saguache County                              CO           4,619           5,917
08111 San Juan County                              CO             745             558
08113 San Miguel County                            CO           3,653           6,594
08115 Sedgwick County                              CO           2,690           2,747
08117 Summit County                                CO          12,881          23,548
08119 Teller County                                CO          12,468          20,555
08121 Washington County                            CO           4,812           4,926
08123 Weld County                                  CO         131,821         180,936
08125 Yuma County                                  CO           8,954           9,841
09001 Fairfield County                             CT         827,645         882,567
09003 Hartford County                              CT         851,783         857,183
09005 Litchfield County                            CT         174,092         182,193
09007 Middlesex County                             CT         143,196         155,071
09009 New Haven County                             CT         804,219         824,008
09011 New London County                            CT         254,957         259,088
09013 Tolland County                               CT         128,699         136,364
09015 Windham County                               CT         102,525         109,091
10001 Kent County                                  DE         110,993         126,697
10003 New Castle County                            DE         441,946         500,265
10005 Sussex County                                DE         113,229         156,638
11001 District of Columbia                         DC         606,900         572,059
12001 Alachua County                               FL         181,596         217,955
12003 Baker County                                 FL          18,486          22,259
12005 Bay County                                   FL         126,994         148,217
12007 Bradford County                              FL          22,515          26,088
12009 Brevard County                               FL         398,978         476,230
12011 Broward County                               FL       1,255,488       1,623,018
12013 Calhoun County                               FL          11,011          13,017
12015 Charlotte County                             FL         110,975         141,627
12017 Citrus County                                FL          93,515         118,085
12019 Clay County                                  FL         105,986         140,814
12021 Collier County                               FL         152,099         251,377
12023 Columbia County                              FL          42,613          56,513
12027 DeSoto County                                FL          23,865          32,209
12029 Dixie County                                 FL          10,585          13,827
12031 Duval County                                 FL         672,971         778,879
12033 Escambia County                              FL         262,798         294,410
12035 Flagler County                               FL          28,701          49,832
12037 Franklin County                              FL           8,967          11,057
12039 Gadsden County                               FL          41,105          45,087
12041 Gilchrist County                             FL           9,667          14,437
12043 Glades County                                FL           7,591          10,576
12045 Gulf County                                  FL          11,504          13,332
12047 Hamilton County                              FL          10,930          13,327
12049 Hardee County                                FL          19,499          26,938
12051 Hendry County                                FL          25,773          36,210
12053 Hernando County                              FL         101,115         130,802
12055 Highlands County                             FL          68,432          87,366
12057 Hillsborough County                          FL         834,054         998,948
12059 Holmes County                                FL          15,778          18,564
12061 Indian River County                          FL          90,208         112,947
12063 Jackson County                               FL          41,375          46,755
12065 Jefferson County                             FL          11,296          12,902
12067 Lafayette County                             FL           5,578           7,022
12069 Lake County                                  FL         152,104         210,528
12071 Lee County                                   FL         335,113         440,888
12073 Leon County                                  FL         192,493         239,452
12075 Levy County                                  FL          25,923          34,450
12077 Liberty County                               FL           5,569           7,021
12079 Madison County                               FL          16,569          18,733
12081 Manatee County                               FL         211,707         264,002
12083 Marion County                                FL         194,833         258,916
12085 Martin County                                FL         100,900         126,731
12086 Miami-Dade County                            FL       1,937,094       2,253,362
12087 Monroe County                                FL          78,024          79,589
12089 Nassau County                                FL          43,941          57,663
12091 Okaloosa County                              FL         143,776         170,498
12093 Okeechobee County                            FL          29,627          35,910
12095 Orange County                                FL         677,491         896,344
12097 Osceola County                               FL         107,728         172,493
12099 Palm Beach County                            FL         863,518       1,131,184
12101 Pasco County                                 FL         281,131         344,765
12103 Pinellas County                              FL         851,659         921,482
12105 Polk County                                  FL         405,382         483,924
12107 Putnam County                                FL          65,070          70,423
12109 St. Johns County                             FL          83,829         123,135
12111 St. Lucie County                             FL         150,171         192,695
12113 Santa Rosa County                            FL          81,608         117,743
12115 Sarasota County                              FL         277,776         325,957
12117 Seminole County                              FL         287,529         365,196
12119 Sumter County                                FL          31,577          53,345
12121 Suwannee County                              FL          26,780          34,844
12123 Taylor County                                FL          17,111          19,256
12125 Union County                                 FL          10,252          13,442
12127 Volusia County                               FL         370,712         443,343
12129 Wakulla County                               FL          14,202          22,863
12131 Walton County                                FL          27,760          40,601
12133 Washington County                            FL          16,919          20,973
13001 Appling County                               GA          15,744          17,419
13003 Atkinson County                              GA           6,213           7,609
13005 Bacon County                                 GA           9,566          10,103
13007 Baker County                                 GA           3,615           4,074
13009 Baldwin County                               GA          39,530          44,700
13011 Banks County                                 GA          10,308          14,422
13013 Barrow County                                GA          29,721          46,144
13015 Bartow County                                GA          55,911          76,019
13017 Ben Hill County                              GA          16,245          17,484
13019 Berrien County                               GA          14,153          16,235
13021 Bibb County                                  GA         149,967         153,887
13023 Bleckley County                              GA          10,430          11,666
13025 Brantley County                              GA          11,077          14,629
13027 Brooks County                                GA          15,398          16,450
13029 Bryan County                                 GA          15,438          23,417
13031 Bulloch County                               GA          43,125          55,983
13033 Burke County                                 GA          20,579          22,243
13035 Butts County                                 GA          15,326          19,522
13037 Calhoun County                               GA           5,013           6,320
13039 Camden County                                GA          30,167          43,664
13043 Candler County                               GA           7,744           9,577
13045 Carroll County                               GA          71,422          87,268
13047 Catoosa County                               GA          42,464          53,282
13049 Charlton County                              GA           8,496          10,282
13051 Chatham County                               GA         216,935         232,048
13053 Chattahoochee County                         GA          16,934          14,882
13055 Chattooga County                             GA          22,242          25,470
13057 Cherokee County                              GA          90,204         141,903
13059 Clarke County                                GA          87,594         101,489
13061 Clay County                                  GA           3,364           3,357
13063 Clayton County                               GA         182,052         236,517
13065 Clinch County                                GA           6,160           6,878
13067 Cobb County                                  GA         447,745         607,751
13069 Coffee County                                GA          29,592          37,413
13071 Colquitt County                              GA          36,645          42,053
13073 Columbia County                              GA          66,031          89,288
13075 Cook County                                  GA          13,456          15,771
13077 Coweta County                                GA          53,853          89,215
13079 Crawford County                              GA           8,991          12,495
13081 Crisp County                                 GA          20,011          21,996
13083 Dade County                                  GA          13,147          15,154
13085 Dawson County                                GA           9,429          15,999
13087 Decatur County                               GA          25,511          28,240
13089 DeKalb County                                GA         545,837         665,865
13091 Dodge County                                 GA          17,607          19,171
13093 Dooly County                                 GA           9,901          11,525
13095 Dougherty County                             GA          96,311          96,065
13097 Douglas County                               GA          71,120          92,174
13099 Early County                                 GA          11,854          12,354
13101 Echols County                                GA           2,334           3,754
13103 Effingham County                             GA          25,687          37,535
13105 Elbert County                                GA          18,949          20,511
13107 Emanuel County                               GA          20,546          21,837
13109 Evans County                                 GA           8,724          10,495
13111 Fannin County                                GA          15,992          19,798
13113 Fayette County                               GA          62,415          91,263
13115 Floyd County                                 GA          81,251          90,565
13117 Forsyth County                               GA          44,083          98,407
13119 Franklin County                              GA          16,650          20,285
13121 Fulton County                                GA         648,951         816,006
13123 Gilmer County                                GA          13,368          23,456
13125 Glascock County                              GA           2,357           2,556
13127 Glynn County                                 GA          62,496          67,568
13129 Gordon County                                GA          35,072          44,104
13131 Grady County                                 GA          20,279          23,659
13133 Greene County                                GA          11,793          14,406
13135 Gwinnett County                              GA         352,910         588,448
13137 Habersham County                             GA          27,621          35,902
13139 Hall County                                  GA          95,428         139,277
13141 Hancock County                               GA           8,908          10,076
13143 Haralson County                              GA          21,966          25,690
13145 Harris County                                GA          17,788          23,695
13147 Hart County                                  GA          19,712          22,997
13149 Heard County                                 GA           8,628          11,012
13151 Henry County                                 GA          58,741         119,341
13153 Houston County                               GA          89,208         110,765
13155 Irwin County                                 GA           8,649           9,931
13157 Jackson County                               GA          30,005          41,589
13159 Jasper County                                GA           8,453          11,426
13161 Jeff Davis County                            GA          12,032          12,684
13163 Jefferson County                             GA          17,408          17,266
13165 Jenkins County                               GA           8,247           8,575
13167 Johnson County                               GA           8,329           8,560
13169 Jones County                                 GA          20,739          23,639
13171 Lamar County                                 GA          13,038          15,912
13173 Lanier County                                GA           5,531           7,241
13175 Laurens County                               GA          39,988          44,874
13177 Lee County                                   GA          16,250          24,757
13179 Liberty County                               GA          52,745          61,610
13181 Lincoln County                               GA           7,442           8,348
13183 Long County                                  GA           6,202          10,304
13185 Lowndes County                               GA          75,981          92,115
13187 Lumpkin County                               GA          14,573          21,016
13189 McDuffie County                              GA          20,119          21,231
13191 McIntosh County                              GA           8,634          10,847
13193 Macon County                                 GA          13,114          14,074
13195 Madison County                               GA          21,050          25,730
13197 Marion County                                GA           5,590           7,144
13199 Meriwether County                            GA          22,411          22,534
13201 Miller County                                GA           6,280           6,383
13205 Mitchell County                              GA          20,275          23,932
13207 Monroe County                                GA          17,113          21,757
13209 Montgomery County                            GA           7,163           8,270
13211 Morgan County                                GA          12,883          15,457
13213 Murray County                                GA          26,147          36,506
13215 Muscogee County                              GA         179,278         186,291
13217 Newton County                                GA          41,808          62,001
13219 Oconee County                                GA          17,618          26,225
13221 Oglethorpe County                            GA           9,763          12,635
13223 Paulding County                              GA          41,611          81,678
13225 Peach County                                 GA          21,189          23,668
13227 Pickens County                               GA          14,432          22,983
13229 Pierce County                                GA          13,328          15,636
13231 Pike County                                  GA          10,224          13,688
13233 Polk County                                  GA          33,815          38,127
13235 Pulaski County                               GA           8,108           9,588
13237 Putnam County                                GA          14,137          18,812
13239 Quitman County                               GA           2,209           2,598
13241 Rabun County                                 GA          11,648          15,050
13243 Randolph County                              GA           8,023           7,791
13245 Richmond County                              GA         189,719         199,775
13247 Rockdale County                              GA          54,091          70,111
13249 Schley County                                GA           3,588           3,766
13251 Screven County                               GA          13,842          15,374
13253 Seminole County                              GA           9,010           9,369
13255 Spalding County                              GA          54,457          58,417
13257 Stephens County                              GA          23,257          25,435
13259 Stewart County                               GA           5,654           5,252
13261 Sumter County                                GA          30,228          33,200
13263 Talbot County                                GA           6,524           6,498
13265 Taliaferro County                            GA           1,915           2,077
13267 Tattnall County                              GA          17,722          22,305
13269 Taylor County                                GA           7,642           8,815
13271 Telfair County                               GA          11,000          11,794
13273 Terrell County                               GA          10,653          10,970
13275 Thomas County                                GA          38,986          42,737
13277 Tift County                                  GA          34,998          38,407
13279 Toombs County                                GA          24,072          26,067
13281 Towns County                                 GA           6,754           9,319
13283 Treutlen County                              GA           5,994           6,854
13285 Troup County                                 GA          55,536          58,779
13287 Turner County                                GA           8,703           9,504
13289 Twiggs County                                GA           9,806          10,590
13291 Union County                                 GA          11,993          17,289
13293 Upson County                                 GA          26,300          27,597
13295 Walker County                                GA          58,340          61,053
13297 Walton County                                GA          38,586          60,687
13299 Ware County                                  GA          35,471          35,483
13301 Warren County                                GA           6,078           6,336
13303 Washington County                            GA          19,112          21,176
13305 Wayne County                                 GA          22,356          26,565
13307 Webster County                               GA           2,263           2,390
13309 Wheeler County                               GA           4,903           6,179
13311 White County                                 GA          13,006          19,944
13313 Whitfield County                             GA          72,462          83,525
13315 Wilcox County                                GA           7,008           8,577
13317 Wilkes County                                GA          10,597          10,687
13319 Wilkinson County                             GA          10,228          10,220
13321 Worth County                                 GA          19,745          21,967
15001 Hawaii County                                HI         120,317         148,677
15003 Honolulu County                              HI         836,231         876,156
15005 Kalawao County                               HI             130             147
15007 Kauai County                                 HI          51,177          58,463
15009 Maui County                                  HI         100,374         128,094
16001 Ada County                                   ID         205,775         300,904
16003 Adams County                                 ID           3,254           3,476
16005 Bannock County                               ID          66,026          75,565
16007 Bear Lake County                             ID           6,084           6,411
16009 Benewah County                               ID           7,937           9,171
16011 Bingham County                               ID          37,583          41,735
16013 Blaine County                                ID          13,552          18,991
16015 Boise County                                 ID           3,509           6,670
16017 Bonner County                                ID          26,622          36,835
16019 Bonneville County                            ID          72,207          82,522
16021 Boundary County                              ID           8,332           9,871
16023 Butte County                                 ID           2,918           2,899
16025 Camas County                                 ID             727             991
16027 Canyon County                                ID          90,076         131,441
16029 Caribou County                               ID           6,963           7,304
16031 Cassia County                                ID          19,532          21,416
16033 Clark County                                 ID             762           1,022
16035 Clearwater County                            ID           8,505           8,930
16037 Custer County                                ID           4,133           4,342
16039 Elmore County                                ID          21,205          29,130
16041 Franklin County                              ID           9,232          11,329
16043 Fremont County                               ID          10,937          11,819
16045 Gem County                                   ID          11,844          15,181
16047 Gooding County                               ID          11,633          14,155
16049 Idaho County                                 ID          13,783          15,511
16051 Jefferson County                             ID          16,543          19,155
16053 Jerome County                                ID          15,138          18,342
16055 Kootenai County                              ID          69,795         108,685
16057 Latah County                                 ID          30,617          34,935
16059 Lemhi County                                 ID           6,899           7,806
16061 Lewis County                                 ID           3,516           3,747
16063 Lincoln County                               ID           3,308           4,044
16065 Madison County                               ID          23,674          27,467
16067 Minidoka County                              ID          19,361          20,174
16069 Nez Perce County                             ID          33,754          37,410
16071 Oneida County                                ID           3,492           4,125
16073 Owyhee County                                ID           8,392          10,644
16075 Payette County                               ID          16,434          20,578
16077 Power County                                 ID           7,086           7,538
16079 Shoshone County                              ID          13,931          13,771
16081 Teton County                                 ID           3,439           5,999
16083 Twin Falls County                            ID          53,580          64,284
16085 Valley County                                ID           6,109           7,651
16087 Washington County                            ID           8,550           9,977
17001 Adams County                                 IL          66,090          68,277
17003 Alexander County                             IL          10,626           9,590
17005 Bond County                                  IL          14,991          17,633
17007 Boone County                                 IL          30,806          41,786
17009 Brown County                                 IL           5,836           6,950
17011 Bureau County                                IL          35,688          35,503
17013 Calhoun County                               IL           5,322           5,084
17015 Carroll County                               IL          16,805          16,674
17017 Cass County                                  IL          13,437          13,695
17019 Champaign County                             IL         173,025         179,669
17021 Christian County                             IL          34,418          35,372
17023 Clark County                                 IL          15,921          17,008
17025 Clay County                                  IL          14,460          14,560
17027 Clinton County                               IL          33,944          35,535
17029 Coles County                                 IL          51,644          53,196
17031 Cook County                                  IL       5,105,067       5,376,741
17033 Crawford County                              IL          19,464          20,452
17035 Cumberland County                            IL          10,670          11,253
17037 DeKalb County                                IL          77,932          88,969
17039 De Witt County                               IL          16,516          16,798
17041 Douglas County                               IL          19,464          19,922
17043 DuPage County                                IL         781,666         904,161
17045 Edgar County                                 IL          19,595          19,704
17047 Edwards County                               IL           7,440           6,971
17049 Effingham County                             IL          31,704          34,264
17051 Fayette County                               IL          20,893          21,802
17053 Ford County                                  IL          14,275          14,241
17055 Franklin County                              IL          40,319          39,018
17057 Fulton County                                IL          38,080          38,250
17059 Gallatin County                              IL           6,909           6,445
17061 Greene County                                IL          15,317          14,761
17063 Grundy County                                IL          32,337          37,535
17065 Hamilton County                              IL           8,499           8,621
17067 Hancock County                               IL          21,373          20,121
17069 Hardin County                                IL           5,189           4,800
17071 Henderson County                             IL           8,096           8,213
17073 Henry County                                 IL          51,159          51,020
17075 Iroquois County                              IL          30,787          31,334
17077 Jackson County                               IL          61,067          59,612
17079 Jasper County                                IL          10,609          10,117
17081 Jefferson County                             IL          37,020          40,045
17083 Jersey County                                IL          20,539          21,668
17085 Jo Daviess County                            IL          21,821          22,289
17087 Johnson County                               IL          11,347          12,878
17089 Kane County                                  IL         317,471         404,119
17091 Kankakee County                              IL          96,255         103,833
17093 Kendall County                               IL          39,413          54,544
17095 Knox County                                  IL          56,393          55,836
17097 Lake County                                  IL         516,418         644,356
17099 La Salle County                              IL         106,913         111,509
17101 Lawrence County                              IL          15,972          15,452
17103 Lee County                                   IL          34,392          36,062
17105 Livingston County                            IL          39,301          39,678
17107 Logan County                                 IL          30,798          31,183
17109 McDonough County                             IL          35,244          32,913
17111 McHenry County                               IL         183,241         260,077
17113 McLean County                                IL         129,180         150,433
17115 Macon County                                 IL         117,206         114,706
17117 Macoupin County                              IL          47,679          49,019
17119 Madison County                               IL         249,238         258,941
17121 Marion County                                IL          41,561          41,691
17123 Marshall County                              IL          12,846          13,180
17125 Mason County                                 IL          16,269          16,038
17127 Massac County                                IL          14,752          15,161
17129 Menard County                                IL          11,164          12,486
17131 Mercer County                                IL          17,290          16,957
17133 Monroe County                                IL          22,422          27,619
17135 Montgomery County                            IL          30,728          30,652
17137 Morgan County                                IL          36,397          36,616
17139 Moultrie County                              IL          13,930          14,287
17141 Ogle County                                  IL          45,957          51,032
17143 Peoria County                                IL         182,827         183,433
17145 Perry County                                 IL          21,412          23,094
17147 Piatt County                                 IL          15,548          16,365
17149 Pike County                                  IL          17,577          17,384
17151 Pope County                                  IL           4,373           4,413
17153 Pulaski County                               IL           7,523           7,348
17155 Putnam County                                IL           5,730           6,086
17157 Randolph County                              IL          34,583          33,893
17159 Richland County                              IL          16,545          16,149
17161 Rock Island County                           IL         148,723         149,374
17163 St. Clair County                             IL         262,852         256,082
17165 Saline County                                IL          26,551          26,733
17167 Sangamon County                              IL         178,386         188,951
17169 Schuyler County                              IL           7,498           7,189
17171 Scott County                                 IL           5,644           5,537
17173 Shelby County                                IL          22,261          22,893
17175 Stark County                                 IL           6,534           6,332
17177 Stephenson County                            IL          48,052          48,979
17179 Tazewell County                              IL         123,692         128,485
17181 Union County                                 IL          17,619          18,293
17183 Vermilion County                             IL          88,257          83,919
17185 Wabash County                                IL          13,111          12,937
17187 Warren County                                IL          19,181          18,735
17189 Washington County                            IL          14,965          15,148
17191 Wayne County                                 IL          17,241          17,151
17193 White County                                 IL          16,522          15,371
17195 Whiteside County                             IL          60,186          60,653
17197 Will County                                  IL         357,313         502,266
17199 Williamson County                            IL          57,733          61,296
17201 Winnebago County                             IL         252,913         278,418
17203 Woodford County                              IL          32,653          35,469
18001 Adams County                                 IN          31,095          33,625
18003 Allen County                                 IN         300,836         331,849
18005 Bartholomew County                           IN          63,657          71,435
18007 Benton County                                IN           9,441           9,421
18009 Blackford County                             IN          14,067          14,048
18011 Boone County                                 IN          38,147          46,107
18013 Brown County                                 IN          14,080          14,957
18015 Carroll County                               IN          18,809          20,165
18017 Cass County                                  IN          38,413          40,930
18019 Clark County                                 IN          87,777          96,472
18021 Clay County                                  IN          24,705          26,556
18023 Clinton County                               IN          30,974          33,866
18025 Crawford County                              IN           9,914          10,743
18027 Daviess County                               IN          27,533          29,820
18029 Dearborn County                              IN          38,835          46,109
18031 Decatur County                               IN          23,645          24,555
18033 De Kalb County                               IN          35,324          40,285
18035 Delaware County                              IN         119,659         118,769
18037 Dubois County                                IN          36,616          39,674
18039 Elkhart County                               IN         156,198         182,791
18041 Fayette County                               IN          26,015          25,588
18043 Floyd County                                 IN          64,404          70,823
18045 Fountain County                              IN          17,808          17,954
18047 Franklin County                              IN          19,580          22,151
18049 Fulton County                                IN          18,840          20,511
18051 Gibson County                                IN          31,913          32,500
18053 Grant County                                 IN          74,169          73,403
18055 Greene County                                IN          30,410          33,157
18057 Hamilton County                              IN         108,936         182,740
18059 Hancock County                               IN          45,527          55,391
18061 Harrison County                              IN          29,890          34,325
18063 Hendricks County                             IN          75,717         104,093
18065 Henry County                                 IN          48,139          48,508
18067 Howard County                                IN          80,827          84,964
18069 Huntington County                            IN          35,427          38,075
18071 Jackson County                               IN          37,730          41,335
18073 Jasper County                                IN          24,960          30,043
18075 Jay County                                   IN          21,512          21,806
18077 Jefferson County                             IN          29,797          31,705
18079 Jennings County                              IN          23,661          27,554
18081 Johnson County                               IN          88,109         115,209
18083 Knox County                                  IN          39,884          39,256
18085 Kosciusko County                             IN          65,294          74,057
18087 Lagrange County                              IN          29,477          34,909
18089 Lake County                                  IN         475,594         484,564
18091 La Porte County                              IN         107,066         110,106
18093 Lawrence County                              IN          42,836          45,922
18095 Madison County                               IN         130,669         133,358
18097 Marion County                                IN         797,159         860,454
18099 Marshall County                              IN          42,182          45,128
18101 Martin County                                IN          10,369          10,369
18103 Miami County                                 IN          36,897          36,082
18105 Monroe County                                IN         108,978         120,563
18107 Montgomery County                            IN          34,436          37,629
18109 Morgan County                                IN          55,920          66,689
18111 Newton County                                IN          13,551          14,566
18113 Noble County                                 IN          37,877          46,275
18115 Ohio County                                  IN           5,315           5,623
18117 Orange County                                IN          18,409          19,306
18119 Owen County                                  IN          17,281          21,786
18121 Parke County                                 IN          15,410          17,241
18123 Perry County                                 IN          19,107          18,899
18125 Pike County                                  IN          12,509          12,837
18127 Porter County                                IN         128,932         146,798
18129 Posey County                                 IN          25,968          27,061
18131 Pulaski County                               IN          12,643          13,755
18133 Putnam County                                IN          30,315          36,019
18135 Randolph County                              IN          27,148          27,401
18137 Ripley County                                IN          24,616          26,523
18139 Rush County                                  IN          18,129          18,261
18141 St. Joseph County                            IN         247,052         265,559
18143 Scott County                                 IN          20,991          22,960
18145 Shelby County                                IN          40,307          43,445
18147 Spencer County                               IN          19,490          20,391
18149 Starke County                                IN          22,747          23,556
18151 Steuben County                               IN          27,446          33,214
18153 Sullivan County                              IN          18,993          21,751
18155 Switzerland County                           IN           7,738           9,065
18157 Tippecanoe County                            IN         130,598         148,955
18159 Tipton County                                IN          16,119          16,577
18161 Union County                                 IN           6,976           7,349
18163 Vanderburgh County                           IN         165,058         171,922
18165 Vermillion County                            IN          16,773          16,788
18167 Vigo County                                  IN         106,107         105,848
18169 Wabash County                                IN          35,069          34,960
18171 Warren County                                IN           8,176           8,419
18173 Warrick County                               IN          44,920          52,383
18175 Washington County                            IN          23,717          27,223
18177 Wayne County                                 IN          71,951          71,097
18179 Wells County                                 IN          25,948          27,600
18181 White County                                 IN          23,265          25,267
18183 Whitley County                               IN          27,651          30,707
19001 Adair County                                 IA           8,409           8,243
19003 Adams County                                 IA           4,866           4,482
19005 Allamakee County                             IA          13,855          14,675
19007 Appanoose County                             IA          13,743          13,721
19009 Audubon County                               IA           7,334           6,830
19011 Benton County                                IA          22,429          25,308
19013 Black Hawk County                            IA         123,798         128,012
19015 Boone County                                 IA          25,186          26,224
19017 Bremer County                                IA          22,813          23,325
19019 Buchanan County                              IA          20,844          21,093
19021 Buena Vista County                           IA          19,965          20,411
19023 Butler County                                IA          15,731          15,305
19025 Calhoun County                               IA          11,508          11,115
19027 Carroll County                               IA          21,423          21,421
19029 Cass County                                  IA          15,128          14,684
19031 Cedar County                                 IA          17,381          18,187
19033 Cerro Gordo County                           IA          46,733          46,447
19035 Cherokee County                              IA          14,098          13,035
19037 Chickasaw County                             IA          13,295          13,095
19039 Clarke County                                IA           8,287           9,133
19041 Clay County                                  IA          17,585          17,372
19043 Clayton County                               IA          19,054          18,678
19045 Clinton County                               IA          51,040          50,149
19047 Crawford County                              IA          16,775          16,942
19049 Dallas County                                IA          29,755          40,750
19051 Davis County                                 IA           8,312           8,541
19053 Decatur County                               IA           8,338           8,689
19055 Delaware County                              IA          18,035          18,404
19057 Des Moines County                            IA          42,614          42,351
19059 Dickinson County                             IA          14,909          16,424
19061 Dubuque County                               IA          86,403          89,143
19063 Emmet County                                 IA          11,569          11,027
19065 Fayette County                               IA          21,843          22,008
19067 Floyd County                                 IA          17,058          16,900
19069 Franklin County                              IA          11,364          10,704
19071 Fremont County                               IA           8,226           8,010
19073 Greene County                                IA          10,045          10,366
19075 Grundy County                                IA          12,029          12,369
19077 Guthrie County                               IA          10,935          11,353
19079 Hamilton County                              IA          16,071          16,438
19081 Hancock County                               IA          12,638          12,100
19083 Hardin County                                IA          19,094          18,812
19085 Harrison County                              IA          14,730          15,666
19087 Henry County                                 IA          19,226          20,336
19089 Howard County                                IA           9,809           9,932
19091 Humboldt County                              IA          10,756          10,381
19093 Ida County                                   IA           8,365           7,837
19095 Iowa County                                  IA          14,630          15,671
19097 Jackson County                               IA          19,950          20,296
19099 Jasper County                                IA          34,795          37,213
19101 Jefferson County                             IA          16,310          16,181
19103 Johnson County                               IA          96,119         111,006
19105 Jones County                                 IA          19,444          20,221
19107 Keokuk County                                IA          11,624          11,400
19109 Kossuth County                               IA          18,591          17,163
19111 Lee County                                   IA          38,687          38,052
19113 Linn County                                  IA         168,767         191,701
19115 Louisa County                                IA          11,592          12,183
19117 Lucas County                                 IA           9,070           9,422
19119 Lyon County                                  IA          11,952          11,763
19121 Madison County                               IA          12,483          14,019
19123 Mahaska County                               IA          21,522          22,335
19125 Marion County                                IA          30,001          32,052
19127 Marshall County                              IA          38,276          39,311
19129 Mills County                                 IA          13,202          14,547
19131 Mitchell County                              IA          10,928          10,874
19133 Monona County                                IA          10,034          10,020
19135 Monroe County                                IA           8,114           8,016
19137 Montgomery County                            IA          12,076          11,771
19139 Muscatine County                             IA          39,907          41,722
19141 O'Brien County                               IA          15,444          15,102
19143 Osceola County                               IA           7,267           7,003
19145 Page County                                  IA          16,870          16,976
19147 Palo Alto County                             IA          10,669          10,147
19149 Plymouth County                              IA          23,388          24,849
19151 Pocahontas County                            IA           9,525           8,662
19153 Polk County                                  IA         327,140         374,601
19155 Pottawattamie County                         IA          82,628          87,704
19157 Poweshiek County                             IA          19,033          18,815
19159 Ringgold County                              IA           5,420           5,469
19161 Sac County                                   IA          12,324          11,529
19163 Scott County                                 IA         150,979         158,668
19165 Shelby County                                IA          13,230          13,173
19167 Sioux County                                 IA          29,903          31,589
19169 Story County                                 IA          74,252          79,981
19171 Tama County                                  IA          17,419          18,103
19173 Taylor County                                IA           7,114           6,958
19175 Union County                                 IA          12,750          12,309
19177 Van Buren County                             IA           7,676           7,809
19179 Wapello County                               IA          35,687          36,051
19181 Warren County                                IA          36,033          40,671
19183 Washington County                            IA          19,612          20,670
19185 Wayne County                                 IA           7,067           6,730
19187 Webster County                               IA          40,342          40,235
19189 Winnebago County                             IA          12,122          11,723
19191 Winneshiek County                            IA          20,847          21,310
19193 Woodbury County                              IA          98,276         103,877
19195 Worth County                                 IA           7,991           7,909
19197 Wright County                                IA          14,269          14,334
20001 Allen County                                 KS          14,638          14,385
20003 Anderson County                              KS           7,803           8,110
20005 Atchison County                              KS          16,932          16,774
20007 Barber County                                KS           5,874           5,307
20009 Barton County                                KS          29,382          28,205
20011 Bourbon County                               KS          14,966          15,379
20013 Brown County                                 KS          11,128          10,724
20015 Butler County                                KS          50,580          59,482
20017 Chase County                                 KS           3,021           3,030
20019 Chautauqua County                            KS           4,407           4,359
20021 Cherokee County                              KS          21,374          22,605
20023 Cheyenne County                              KS           3,243           3,165
20025 Clark County                                 KS           2,418           2,390
20027 Clay County                                  KS           9,158           8,822
20029 Cloud County                                 KS          11,023          10,268
20031 Coffey County                                KS           8,404           8,865
20033 Comanche County                              KS           2,313           1,967
20035 Cowley County                                KS          36,915          36,291
20037 Crawford County                              KS          35,568          38,242
20039 Decatur County                               KS           4,021           3,472
20041 Dickinson County                             KS          18,958          19,344
20043 Doniphan County                              KS           8,134           8,249
20045 Douglas County                               KS          81,798          99,962
20047 Edwards County                               KS           3,787           3,449
20049 Elk County                                   KS           3,327           3,261
20051 Ellis County                                 KS          26,004          27,507
20053 Ellsworth County                             KS           6,586           6,525
20055 Finney County                                KS          33,070          40,523
20057 Ford County                                  KS          27,463          32,458
20059 Franklin County                              KS          21,994          24,784
20061 Geary County                                 KS          30,453          27,947
20063 Gove County                                  KS           3,231           3,068
20065 Graham County                                KS           3,543           2,946
20067 Grant County                                 KS           7,159           7,909
20069 Gray County                                  KS           5,396           5,904
20071 Greeley County                               KS           1,774           1,534
20073 Greenwood County                             KS           7,847           7,673
20075 Hamilton County                              KS           2,388           2,670
20077 Harper County                                KS           7,124           6,536
20079 Harvey County                                KS          31,028          32,869
20081 Haskell County                               KS           3,886           4,307
20083 Hodgeman County                              KS           2,177           2,085
20085 Jackson County                               KS          11,525          12,657
20087 Jefferson County                             KS          15,905          18,426
20089 Jewell County                                KS           4,251           3,791
20091 Johnson County                               KS         355,054         451,086
20093 Kearny County                                KS           4,027           4,531
20095 Kingman County                               KS           8,292           8,673
20097 Kiowa County                                 KS           3,660           3,278
20099 Labette County                               KS          23,693          22,835
20101 Lane County                                  KS           2,375           2,155
20103 Leavenworth County                           KS          64,371          68,691
20105 Lincoln County                               KS           3,653           3,578
20107 Linn County                                  KS           8,254           9,570
20109 Logan County                                 KS           3,081           3,046
20111 Lyon County                                  KS          34,732          35,935
20113 McPherson County                             KS          27,268          29,554
20115 Marion County                                KS          12,888          13,361
20117 Marshall County                              KS          11,705          10,965
20119 Meade County                                 KS           4,247           4,631
20121 Miami County                                 KS          23,466          28,351
20123 Mitchell County                              KS           7,203           6,932
20125 Montgomery County                            KS          38,816          36,252
20127 Morris County                                KS           6,198           6,104
20129 Morton County                                KS           3,480           3,496
20131 Nemaha County                                KS          10,446          10,717
20133 Neosho County                                KS          17,035          16,997
20135 Ness County                                  KS           4,033           3,454
20137 Norton County                                KS           5,947           5,953
20139 Osage County                                 KS          15,248          16,712
20141 Osborne County                               KS           4,867           4,452
20143 Ottawa County                                KS           5,634           6,163
20145 Pawnee County                                KS           7,555           7,233
20147 Phillips County                              KS           6,590           6,001
20149 Pottawatomie County                          KS          16,128          18,209
20151 Pratt County                                 KS           9,702           9,647
20153 Rawlins County                               KS           3,404           2,966
20155 Reno County                                  KS          62,389          64,790
20157 Republic County                              KS           6,482           5,835
20159 Rice County                                  KS          10,610          10,761
20161 Riley County                                 KS          67,139          62,843
20163 Rooks County                                 KS           6,039           5,685
20165 Rush County                                  KS           3,842           3,551
20167 Russell County                               KS           7,835           7,370
20169 Saline County                                KS          49,301          53,597
20171 Scott County                                 KS           5,289           5,120
20173 Sedgwick County                              KS         403,662         452,869
20175 Seward County                                KS          18,743          22,510
20177 Shawnee County                               KS         160,976         169,871
20179 Sheridan County                              KS           3,043           2,813
20181 Sherman County                               KS           6,926           6,760
20183 Smith County                                 KS           5,078           4,536
20185 Stafford County                              KS           5,365           4,789
20187 Stanton County                               KS           2,333           2,406
20189 Stevens County                               KS           5,048           5,463
20191 Sumner County                                KS          25,841          25,946
20193 Thomas County                                KS           8,258           8,180
20195 Trego County                                 KS           3,694           3,319
20197 Wabaunsee County                             KS           6,603           6,885
20199 Wallace County                               KS           1,821           1,749
20201 Washington County                            KS           7,073           6,483
20203 Wichita County                               KS           2,758           2,531
20205 Wilson County                                KS          10,289          10,332
20207 Woodson County                               KS           4,116           3,788
20209 Wyandotte County                             KS         161,993         157,882
21001 Adair County                                 KY          15,360          17,244
21003 Allen County                                 KY          14,628          17,800
21005 Anderson County                              KY          14,571          19,111
21007 Ballard County                               KY           7,902           8,286
21009 Barren County                                KY          34,001          38,033
21011 Bath County                                  KY           9,692          11,085
21013 Bell County                                  KY          31,506          30,060
21015 Boone County                                 KY          57,589          85,991
21017 Bourbon County                               KY          19,236          19,360
21019 Boyd County                                  KY          51,150          49,752
21021 Boyle County                                 KY          25,641          27,697
21023 Bracken County                               KY           7,766           8,279
21025 Breathitt County                             KY          15,703          16,100
21027 Breckinridge County                          KY          16,312          18,648
21029 Bullitt County                               KY          47,567          61,236
21031 Butler County                                KY          11,245          13,010
21033 Caldwell County                              KY          13,232          13,060
21035 Calloway County                              KY          30,735          34,177
21037 Campbell County                              KY          83,866          88,616
21039 Carlisle County                              KY           5,238           5,351
21041 Carroll County                               KY           9,292          10,155
21043 Carter County                                KY          24,340          26,889
21045 Casey County                                 KY          14,211          15,447
21047 Christian County                             KY          68,941          72,265
21049 Clark County                                 KY          29,496          33,144
21051 Clay County                                  KY          21,746          24,556
21053 Clinton County                               KY           9,135           9,634
21055 Crittenden County                            KY           9,196           9,384
21057 Cumberland County                            KY           6,784           7,147
21059 Daviess County                               KY          87,189          91,545
21061 Edmonson County                              KY          10,357          11,644
21063 Elliott County                               KY           6,455           6,748
21065 Estill County                                KY          14,614          15,307
21067 Fayette County                               KY         225,366         260,512
21069 Fleming County                               KY          12,292          13,792
21071 Floyd County                                 KY          43,586          42,441
21073 Franklin County                              KY          43,781          47,687
21075 Fulton County                                KY           8,271           7,752
21077 Gallatin County                              KY           5,393           7,870
21079 Garrard County                               KY          11,579          14,792
21081 Grant County                                 KY          15,737          22,384
21083 Graves County                                KY          33,550          37,028
21085 Grayson County                               KY          21,050          24,053
21087 Green County                                 KY          10,371          11,518
21089 Greenup County                               KY          36,742          36,891
21091 Hancock County                               KY           7,864           8,392
21093 Hardin County                                KY          89,240          94,174
21095 Harlan County                                KY          36,574          33,202
21097 Harrison County                              KY          16,248          17,983
21099 Hart County                                  KY          14,890          17,445
21101 Henderson County                             KY          43,044          44,829
21103 Henry County                                 KY          12,823          15,060
21105 Hickman County                               KY           5,566           5,262
21107 Hopkins County                               KY          46,126          46,519
21109 Jackson County                               KY          11,955          13,495
21111 Jefferson County                             KY         664,937         693,604
21113 Jessamine County                             KY          30,508          39,041
21115 Johnson County                               KY          23,248          23,445
21117 Kenton County                                KY         142,031         151,464
21119 Knott County                                 KY          17,906          17,649
21121 Knox County                                  KY          29,676          31,795
21123 Larue County                                 KY          11,679          13,373
21125 Laurel County                                KY          43,438          52,715
21127 Lawrence County                              KY          13,998          15,569
21129 Lee County                                   KY           7,422           7,916
21131 Leslie County                                KY          13,642          12,401
21133 Letcher County                               KY          27,000          25,277
21135 Lewis County                                 KY          13,029          14,092
21137 Lincoln County                               KY          20,045          23,361
21139 Livingston County                            KY           9,062           9,804
21141 Logan County                                 KY          24,416          26,573
21143 Lyon County                                  KY           6,624           8,080
21145 McCracken County                             KY          62,879          65,514
21147 McCreary County                              KY          15,603          17,080
21149 McLean County                                KY           9,628           9,938
21151 Madison County                               KY          57,508          70,872
21153 Magoffin County                              KY          13,077          13,332
21155 Marion County                                KY          16,499          18,212
21157 Marshall County                              KY          27,205          30,125
21159 Martin County                                KY          12,526          12,578
21161 Mason County                                 KY          16,666          16,800
21163 Meade County                                 KY          24,170          26,349
21165 Menifee County                               KY           5,092           6,556
21167 Mercer County                                KY          19,148          20,817
21169 Metcalfe County                              KY           8,963          10,037
21171 Monroe County                                KY          11,401          11,756
21173 Montgomery County                            KY          19,561          22,554
21175 Morgan County                                KY          11,648          13,948
21177 Muhlenberg County                            KY          31,318          31,839
21179 Nelson County                                KY          29,710          37,477
21181 Nicholas County                              KY           6,725           6,813
21183 Ohio County                                  KY          21,105          22,916
21185 Oldham County                                KY          33,263          46,178
21187 Owen County                                  KY           9,035          10,547
21189 Owsley County                                KY           5,036           4,858
21191 Pendleton County                             KY          12,036          14,390
21193 Perry County                                 KY          30,283          29,390
21195 Pike County                                  KY          72,583          68,736
21197 Powell County                                KY          11,686          13,237
21199 Pulaski County                               KY          49,489          56,217
21201 Robertson County                             KY           2,124           2,266
21203 Rockcastle County                            KY          14,803          16,582
21205 Rowan County                                 KY          20,353          22,094
21207 Russell County                               KY          14,716          16,315
21209 Scott County                                 KY          23,867          33,061
21211 Shelby County                                KY          24,824          33,337
21213 Simpson County                               KY          15,145          16,405
21215 Spencer County                               KY           6,801          11,766
21217 Taylor County                                KY          21,146          22,927
21219 Todd County                                  KY          10,940          11,971
21221 Trigg County                                 KY          10,361          12,597
21223 Trimble County                               KY           6,090           8,125
21225 Union County                                 KY          16,557          15,637
21227 Warren County                                KY          76,673          92,522
21229 Washington County                            KY          10,441          10,916
21231 Wayne County                                 KY          17,468          19,923
21233 Webster County                               KY          13,955          14,120
21235 Whitley County                               KY          33,326          35,865
21237 Wolfe County                                 KY           6,503           7,065
21239 Woodford County                              KY          19,955          23,208
22001 Acadia Parish                                LA          55,882          58,861
22003 Allen Parish                                 LA          21,226          25,440
22005 Ascension Parish                             LA          58,214          76,627
22007 Assumption Parish                            LA          22,753          23,388
22009 Avoyelles Parish                             LA          39,159          41,481
22011 Beauregard Parish                            LA          30,083          32,986
22013 Bienville Parish                             LA          15,979          15,752
22015 Bossier Parish                               LA          86,088          98,310
22017 Caddo Parish                                 LA         248,253         252,161
22019 Calcasieu Parish                             LA         168,134         183,577
22021 Caldwell Parish                              LA           9,810          10,560
22023 Cameron Parish                               LA           9,260           9,991
22025 Catahoula Parish                             LA          11,065          10,920
22027 Claiborne Parish                             LA          17,405          16,851
22029 Concordia Parish                             LA          20,828          20,247
22031 De Soto Parish                               LA          25,346          25,494
22033 East Baton Rouge Parish                      LA         380,105         412,852
22035 East Carroll Parish                          LA           9,709           9,421
22037 East Feliciana Parish                        LA          19,211          21,360
22039 Evangeline Parish                            LA          33,274          35,434
22041 Franklin Parish                              LA          22,387          21,263
22043 Grant Parish                                 LA          17,526          18,698
22045 Iberia Parish                                LA          68,297          73,266
22047 Iberville Parish                             LA          31,049          33,320
22049 Jackson Parish                               LA          15,705          15,397
22051 Jefferson Parish                             LA         448,306         455,466
22053 Jefferson Davis Parish                       LA          30,722          31,435
22055 Lafayette Parish                             LA         164,762         190,503
22057 Lafourche Parish                             LA          85,860          89,974
22059 La Salle Parish                              LA          13,662          14,282
22061 Lincoln Parish                               LA          41,745          42,509
22063 Livingston Parish                            LA          70,526          91,814
22065 Madison Parish                               LA          12,463          13,728
22067 Morehouse Parish                             LA          31,938          31,021
22069 Natchitoches Parish                          LA          36,689          39,080
22071 Orleans Parish                               LA         496,938         484,674
22073 Ouachita Parish                              LA         142,191         147,250
22075 Plaquemines Parish                           LA          25,575          26,757
22077 Pointe Coupee Parish                         LA          22,540          22,763
22079 Rapides Parish                               LA         131,556         126,337
22081 Red River Parish                             LA           9,387           9,622
22083 Richland Parish                              LA          20,629          20,981
22085 Sabine Parish                                LA          22,646          23,459
22087 St. Bernard Parish                           LA          66,631          67,229
22089 St. Charles Parish                           LA          42,437          48,072
22091 St. Helena Parish                            LA           9,874          10,525
22093 St. James Parish                             LA          20,879          21,216
22095 St. John the Baptist Parish                  LA          39,996          43,044
22097 St. Landry Parish                            LA          80,331          87,700
22099 St. Martin Parish                            LA          43,978          48,583
22101 St. Mary Parish                              LA          58,086          53,500
22103 St. Tammany Parish                           LA         144,508         191,268
22105 Tangipahoa Parish                            LA          85,709         100,588
22107 Tensas Parish                                LA           7,103           6,618
22109 Terrebonne Parish                            LA          96,982         104,503
22111 Union Parish                                 LA          20,690          22,803
22113 Vermilion Parish                             LA          50,055          53,807
22115 Vernon Parish                                LA          61,961          52,531
22117 Washington Parish                            LA          43,185          43,926
22119 Webster Parish                               LA          41,989          41,831
22121 West Baton Rouge Parish                      LA          19,419          21,601
22123 West Carroll Parish                          LA          12,093          12,314
22125 West Feliciana Parish                        LA          12,915          15,111
22127 Winn Parish                                  LA          16,269          16,894
23001 Androscoggin County                          ME         105,259         103,793
23003 Aroostook County                             ME          86,936          73,938
23005 Cumberland County                            ME         243,135         265,612
23007 Franklin County                              ME          29,008          29,467
23009 Hancock County                               ME          46,948          51,791
23011 Kennebec County                              ME         115,904         117,114
23013 Knox County                                  ME          36,310          39,618
23015 Lincoln County                               ME          30,357          33,616
23017 Oxford County                                ME          52,602          54,755
23019 Penobscot County                             ME         146,601         144,919
23021 Piscataquis County                           ME          18,653          17,235
23023 Sagadahoc County                             ME          33,535          35,214
23025 Somerset County                              ME          49,767          50,888
23027 Waldo County                                 ME          33,018          36,280
23029 Washington County                            ME          35,308          33,941
23031 York County                                  ME         164,587         186,742
24001 Allegany County                              MD          74,946          74,930
24003 Anne Arundel County                          MD         427,239         489,656
24005 Baltimore County                             MD         692,134         754,292
24009 Calvert County                               MD          51,372          74,563
24011 Caroline County                              MD          27,035          29,772
24013 Carroll County                               MD         123,372         150,897
24015 Cecil County                                 MD          71,347          85,951
24017 Charles County                               MD         101,154         120,546
24019 Dorchester County                            MD          30,236          30,674
24021 Frederick County                             MD         150,208         195,277
24023 Garrett County                               MD          28,138          29,846
24025 Harford County                               MD         182,132         218,590
24027 Howard County                                MD         187,328         247,842
24029 Kent County                                  MD          17,842          19,197
24031 Montgomery County                            MD         757,027         873,341
24033 Prince George's County                       MD         729,268         801,515
24035 Queen Anne's County                          MD          33,953          40,563
24037 St. Mary's County                            MD          75,974          86,211
24039 Somerset County                              MD          23,440          24,747
24041 Talbot County                                MD          30,549          33,812
24043 Washington County                            MD         121,393         131,923
24045 Wicomico County                              MD          74,339          84,644
24047 Worcester County                             MD          35,028          46,543
24510 Baltimore city                               MD         736,014         651,154
25001 Barnstable County                            MA         186,605         222,230
25003 Berkshire County                             MA         139,352         134,953
25005 Bristol County                               MA         506,325         534,678
25007 Dukes County                                 MA          11,639          14,987
25009 Essex County                                 MA         670,080         723,419
25011 Franklin County                              MA          70,092          71,535
25013 Hampden County                               MA         456,310         456,228
25015 Hampshire County                             MA         146,568         152,251
25017 Middlesex County                             MA       1,398,468       1,465,396
25019 Nantucket County                             MA           6,012           9,520
25021 Norfolk County                               MA         616,087         650,308
25023 Plymouth County                              MA         435,276         472,822
25025 Suffolk County                               MA         663,906         689,807
25027 Worcester County                             MA         709,705         750,963
26001 Alcona County                                MI          10,145          11,719
26003 Alger County                                 MI           8,972           9,862
26005 Allegan County                               MI          90,509         105,665
26007 Alpena County                                MI          30,605          31,314
26009 Antrim County                                MI          18,185          23,110
26011 Arenac County                                MI          14,931          17,269
26013 Baraga County                                MI           7,954           8,746
26015 Barry County                                 MI          50,057          56,755
26017 Bay County                                   MI         111,723         110,157
26019 Benzie County                                MI          12,200          15,998
26021 Berrien County                               MI         161,378         162,453
26023 Branch County                                MI          41,502          45,787
26025 Calhoun County                               MI         135,982         137,985
26027 Cass County                                  MI          49,477          51,104
26029 Charlevoix County                            MI          21,468          26,090
26031 Cheboygan County                             MI          21,398          26,448
26033 Chippewa County                              MI          34,604          38,543
26035 Clare County                                 MI          24,952          31,252
26037 Clinton County                               MI          57,883          64,753
26039 Crawford County                              MI          12,260          14,273
26041 Delta County                                 MI          37,780          38,520
26043 Dickinson County                             MI          26,831          27,472
26045 Eaton County                                 MI          92,879         103,655
26047 Emmet County                                 MI          25,040          31,437
26049 Genesee County                               MI         430,459         436,141
26051 Gladwin County                               MI          21,896          26,023
26053 Gogebic County                               MI          18,052          17,370
26055 Grand Traverse County                        MI          64,273          77,654
26057 Gratiot County                               MI          38,982          42,285
26059 Hillsdale County                             MI          43,431          46,527
26061 Houghton County                              MI          35,446          36,016
26063 Huron County                                 MI          34,951          36,079
26065 Ingham County                                MI         281,912         279,320
26067 Ionia County                                 MI          57,024          61,518
26069 Iosco County                                 MI          30,209          27,339
26071 Iron County                                  MI          13,175          13,138
26073 Isabella County                              MI          54,624          63,351
26075 Jackson County                               MI         149,756         158,422
26077 Kalamazoo County                             MI         223,411         238,603
26079 Kalkaska County                              MI          13,497          16,571
26081 Kent County                                  MI         500,631         574,335
26083 Keweenaw County                              MI           1,701           2,301
26085 Lake County                                  MI           8,583          11,333
26087 Lapeer County                                MI          74,768          87,904
26089 Leelanau County                              MI          16,527          21,119
26091 Lenawee County                               MI          91,476          98,890
26093 Livingston County                            MI         115,645         156,951
26095 Luce County                                  MI           5,763           7,024
26097 Mackinac County                              MI          10,674          11,943
26099 Macomb County                                MI         717,400         788,149
26101 Manistee County                              MI          21,265          24,527
26103 Marquette County                             MI          70,887          64,634
26105 Mason County                                 MI          25,537          28,274
26107 Mecosta County                               MI          37,308          40,553
26109 Menominee County                             MI          24,920          25,326
26111 Midland County                               MI          75,651          82,874
26113 Missaukee County                             MI          12,147          14,478
26115 Monroe County                                MI         133,600         145,945
26117 Montcalm County                              MI          53,059          61,266
26119 Montmorency County                           MI           8,936          10,315
26121 Muskegon County                              MI         158,983         170,200
26123 Newaygo County                               MI          38,202          47,874
26125 Oakland County                               MI       1,083,592       1,194,156
26127 Oceana County                                MI          22,454          26,873
26129 Ogemaw County                                MI          18,681          21,645
26131 Ontonagon County                             MI           8,854           7,818
26133 Osceola County                               MI          20,146          23,197
26135 Oscoda County                                MI           7,842           9,418
26137 Otsego County                                MI          17,957          23,301
26139 Ottawa County                                MI         187,768         238,314
26141 Presque Isle County                          MI          13,743          14,411
26143 Roscommon County                             MI          19,776          25,469
26145 Saginaw County                               MI         211,946         210,039
26147 St. Clair County                             MI         145,607         164,235
26149 St. Joseph County                            MI          58,913          62,422
26151 Sanilac County                               MI          39,928          44,547
26153 Schoolcraft County                           MI           8,302           8,903
26155 Shiawassee County                            MI          69,770          71,687
26157 Tuscola County                               MI          55,498          58,266
26159 Van Buren County                             MI          70,060          76,263
26161 Washtenaw County                             MI         282,937         322,895
26163 Wayne County                                 MI       2,111,687       2,061,162
26165 Wexford County                               MI          26,360          30,484
27001 Aitkin County                                MN          12,425          15,301
27003 Anoka County                                 MN         243,641         298,084
27005 Becker County                                MN          27,881          30,000
27007 Beltrami County                              MN          34,384          39,650
27009 Benton County                                MN          30,185          34,226
27011 Big Stone County                             MN           6,285           5,820
27013 Blue Earth County                            MN          54,044          55,941
27015 Brown County                                 MN          26,984          26,911
27017 Carlton County                               MN          29,259          31,671
27019 Carver County                                MN          47,915          70,205
27021 Cass County                                  MN          21,791          27,150
27023 Chippewa County                              MN          13,228          13,088
27025 Chisago County                               MN          30,521          41,101
27027 Clay County                                  MN          50,422          51,229
27029 Clearwater County                            MN           8,309           8,423
27031 Cook County                                  MN           3,868           5,168
27033 Cottonwood County                            MN          12,694          12,167
27035 Crow Wing County                             MN          44,249          55,099
27037 Dakota County                                MN         275,227         355,904
27039 Dodge County                                 MN          15,731          17,731
27041 Douglas County                               MN          28,674          32,821
27043 Faribault County                             MN          16,937          16,181
27045 Fillmore County                              MN          20,777          21,122
27047 Freeborn County                              MN          33,060          32,584
27049 Goodhue County                               MN          40,690          44,127
27051 Grant County                                 MN           6,246           6,289
27053 Hennepin County                              MN       1,032,431       1,116,200
27055 Houston County                               MN          18,497          19,718
27057 Hubbard County                               MN          14,939          18,376
27059 Isanti County                                MN          25,921          31,287
27061 Itasca County                                MN          40,863          43,992
27063 Jackson County                               MN          11,677          11,268
27065 Kanabec County                               MN          12,802          14,996
27067 Kandiyohi County                             MN          38,761          41,203
27069 Kittson County                               MN           5,767           5,285
27071 Koochiching County                           MN          16,299          14,355
27073 Lac qui Parle County                         MN           8,924           8,067
27075 Lake County                                  MN          10,415          11,058
27077 Lake of the Woods County                     MN           4,076           4,522
27079 Le Sueur County                              MN          23,239          25,426
27081 Lincoln County                               MN           6,890           6,429
27083 Lyon County                                  MN          24,789          25,425
27085 McLeod County                                MN          32,030          34,898
27087 Mahnomen County                              MN           5,044           5,190
27089 Marshall County                              MN          10,993          10,155
27091 Martin County                                MN          22,914          21,802
27093 Meeker County                                MN          20,846          22,644
27095 Mille Lacs County                            MN          18,670          22,330
27097 Morrison County                              MN          29,604          31,712
27099 Mower County                                 MN          37,385          38,603
27101 Murray County                                MN           9,660           9,165
27103 Nicollet County                              MN          28,076          29,771
27105 Nobles County                                MN          20,098          20,832
27107 Norman County                                MN           7,975           7,442
27109 Olmsted County                               MN         106,470         124,277
27111 Otter Tail County                            MN          50,714          57,159
27113 Pennington County                            MN          13,306          13,584
27115 Pine County                                  MN          21,264          26,530
27117 Pipestone County                             MN          10,491           9,895
27119 Polk County                                  MN          32,498          31,369
27121 Pope County                                  MN          10,745          11,236
27123 Ramsey County                                MN         485,765         511,035
27125 Red Lake County                              MN           4,525           4,299
27127 Redwood County                               MN          17,254          16,815
27129 Renville County                              MN          17,673          17,154
27131 Rice County                                  MN          49,183          56,665
27133 Rock County                                  MN           9,806           9,721
27135 Roseau County                                MN          15,026          16,338
27137 St. Louis County                             MN         198,213         200,528
27139 Scott County                                 MN          57,846          89,498
27141 Sherburne County                             MN          41,945          64,417
27143 Sibley County                                MN          14,366          15,356
27145 Stearns County                               MN         118,791         133,166
27147 Steele County                                MN          30,729          33,680
27149 Stevens County                               MN          10,634          10,053
27151 Swift County                                 MN          10,724          11,956
27153 Todd County                                  MN          23,363          24,426
27155 Traverse County                              MN           4,463           4,134
27157 Wabasha County                               MN          19,744          21,610
27159 Wadena County                                MN          13,154          13,713
27161 Waseca County                                MN          18,079          19,526
27163 Washington County                            MN         145,896         201,130
27165 Watonwan County                              MN          11,682          11,876
27167 Wilkin County                                MN           7,516           7,138
27169 Winona County                                MN          47,828          49,985
27171 Wright County                                MN          68,710          89,986
27173 Yellow Medicine County                       MN          11,684          11,080
28001 Adams County                                 MS          35,356          34,340
28003 Alcorn County                                MS          31,722          34,558
28005 Amite County                                 MS          13,328          13,599
28007 Attala County                                MS          18,481          19,661
28009 Benton County                                MS           8,046           8,026
28011 Bolivar County                               MS          41,875          40,633
28013 Calhoun County                               MS          14,908          15,069
28015 Carroll County                               MS           9,237          10,769
28017 Chickasaw County                             MS          18,085          19,440
28019 Choctaw County                               MS           9,071           9,758
28021 Claiborne County                             MS          11,370          11,831
28023 Clarke County                                MS          17,313          17,955
28025 Clay County                                  MS          21,120          21,979
28027 Coahoma County                               MS          31,665          30,622
28029 Copiah County                                MS          27,592          28,757
28031 Covington County                             MS          16,527          19,407
28033 DeSoto County                                MS          67,910         107,199
28035 Forrest County                               MS          68,314          72,604
28037 Franklin County                              MS           8,377           8,448
28039 George County                                MS          16,673          19,144
28041 Greene County                                MS          10,220          13,299
28043 Grenada County                               MS          21,555          23,263
28045 Hancock County                               MS          31,760          42,967
28047 Harrison County                              MS         165,365         189,601
28049 Hinds County                                 MS         254,441         250,800
28051 Holmes County                                MS          21,604          21,609
28053 Humphreys County                             MS          12,134          11,206
28055 Issaquena County                             MS           1,909           2,274
28057 Itawamba County                              MS          20,017          22,770
28059 Jackson County                               MS         115,243         131,420
28061 Jasper County                                MS          17,114          18,149
28063 Jefferson County                             MS           8,653           9,740
28065 Jefferson Davis County                       MS          14,051          13,962
28067 Jones County                                 MS          62,031          64,958
28069 Kemper County                                MS          10,356          10,453
28071 Lafayette County                             MS          31,826          38,744
28073 Lamar County                                 MS          30,424          39,070
28075 Lauderdale County                            MS          75,555          78,161
28077 Lawrence County                              MS          12,458          13,258
28079 Leake County                                 MS          18,436          20,940
28081 Lee County                                   MS          65,581          75,755
28083 Leflore County                               MS          37,341          37,947
28085 Lincoln County                               MS          30,278          33,166
28087 Lowndes County                               MS          59,308          61,586
28089 Madison County                               MS          53,794          74,674
28091 Marion County                                MS          25,544          25,595
28093 Marshall County                              MS          30,361          34,993
28095 Monroe County                                MS          36,582          38,014
28097 Montgomery County                            MS          12,388          12,189
28099 Neshoba County                               MS          24,800          28,684
28101 Newton County                                MS          20,291          21,838
28103 Noxubee County                               MS          12,604          12,548
28105 Oktibbeha County                             MS          38,375          42,902
28107 Panola County                                MS          29,996          34,274
28109 Pearl River County                           MS          38,714          48,621
28111 Perry County                                 MS          10,865          12,138
28113 Pike County                                  MS          36,882          38,940
28115 Pontotoc County                              MS          22,237          26,726
28117 Prentiss County                              MS          23,278          25,556
28119 Quitman County                               MS          10,490          10,117
28121 Rankin County                                MS          87,161         115,327
28123 Scott County                                 MS          24,137          28,423
28125 Sharkey County                               MS           7,066           6,580
28127 Simpson County                               MS          23,953          27,639
28129 Smith County                                 MS          14,798          16,182
28131 Stone County                                 MS          10,750          13,622
28133 Sunflower County                             MS          32,867          34,369
28135 Tallahatchie County                          MS          15,210          14,903
28137 Tate County                                  MS          21,432          25,370
28139 Tippah County                                MS          19,523          20,826
28141 Tishomingo County                            MS          17,683          19,163
28143 Tunica County                                MS           8,164           9,227
28145 Union County                                 MS          22,085          25,362
28147 Walthall County                              MS          14,352          15,156
28149 Warren County                                MS          47,880          49,644
28151 Washington County                            MS          67,935          62,977
28153 Wayne County                                 MS          19,517          21,216
28155 Webster County                               MS          10,222          10,294
28157 Wilkinson County                             MS           9,678          10,312
28159 Winston County                               MS          19,433          20,160
28161 Yalobusha County                             MS          12,033          13,051
28163 Yazoo County                                 MS          25,506          28,149
29001 Adair County                                 MO          24,577          24,977
29003 Andrew County                                MO          14,632          16,492
29005 Atchison County                              MO           7,457           6,430
29007 Audrain County                               MO          23,599          25,853
29009 Barry County                                 MO          27,547          34,010
29011 Barton County                                MO          11,312          12,541
29013 Bates County                                 MO          15,025          16,653
29015 Benton County                                MO          13,859          17,180
29017 Bollinger County                             MO          10,619          12,029
29019 Boone County                                 MO         112,379         135,454
29021 Buchanan County                              MO          83,083          85,998
29023 Butler County                                MO          38,765          40,867
29025 Caldwell County                              MO           8,380           8,969
29027 Callaway County                              MO          32,809          40,766
29029 Camden County                                MO          27,495          37,051
29031 Cape Girardeau County                        MO          61,633          68,693
29033 Carroll County                               MO          10,748          10,285
29035 Carter County                                MO           5,515           5,941
29037 Cass County                                  MO          63,808          82,092
29039 Cedar County                                 MO          12,093          13,733
29041 Chariton County                              MO           9,202           8,438
29043 Christian County                             MO          32,644          54,285
29045 Clark County                                 MO           7,547           7,416
29047 Clay County                                  MO         153,411         184,006
29049 Clinton County                               MO          16,595          18,979
29051 Cole County                                  MO          63,579          71,397
29053 Cooper County                                MO          14,835          16,670
29055 Crawford County                              MO          19,173          22,804
29057 Dade County                                  MO           7,449           7,923
29059 Dallas County                                MO          12,646          15,661
29061 Daviess County                               MO           7,865           8,016
29063 DeKalb County                                MO           9,967          11,597
29065 Dent County                                  MO          13,702          14,927
29067 Douglas County                               MO          11,876          13,084
29069 Dunklin County                               MO          33,112          33,155
29071 Franklin County                              MO          80,603          93,807
29073 Gasconade County                             MO          14,006          15,342
29075 Gentry County                                MO           6,848           6,861
29077 Greene County                                MO         207,949         240,391
29079 Grundy County                                MO          10,536          10,432
29081 Harrison County                              MO           8,469           8,850
29083 Henry County                                 MO          20,044          21,997
29085 Hickory County                               MO           7,335           8,940
29087 Holt County                                  MO           6,034           5,351
29089 Howard County                                MO           9,631          10,212
29091 Howell County                                MO          31,447          37,238
29093 Iron County                                  MO          10,726          10,697
29095 Jackson County                               MO         633,232         654,880
29097 Jasper County                                MO          90,465         104,686
29099 Jefferson County                             MO         171,380         198,099
29101 Johnson County                               MO          42,514          48,258
29103 Knox County                                  MO           4,482           4,361
29105 Laclede County                               MO          27,158          32,513
29107 Lafayette County                             MO          31,107          32,960
29109 Lawrence County                              MO          30,236          35,204
29111 Lewis County                                 MO          10,233          10,494
29113 Lincoln County                               MO          28,892          38,944
29115 Linn County                                  MO          13,885          13,754
29117 Livingston County                            MO          14,592          14,558
29119 McDonald County                              MO          16,938          21,681
29121 Macon County                                 MO          15,345          15,762
29123 Madison County                               MO          11,127          11,800
29125 Maries County                                MO           7,976           8,903
29127 Marion County                                MO          27,682          28,289
29129 Mercer County                                MO           3,723           3,757
29131 Miller County                                MO          20,700          23,564
29133 Mississippi County                           MO          14,442          13,427
29135 Moniteau County                              MO          12,298          14,827
29137 Monroe County                                MO           9,104           9,311
29139 Montgomery County                            MO          11,355          12,136
29141 Morgan County                                MO          15,574          19,309
29143 New Madrid County                            MO          20,928          19,760
29145 Newton County                                MO          44,445          52,636
29147 Nodaway County                               MO          21,709          21,912
29149 Oregon County                                MO           9,470          10,344
29151 Osage County                                 MO          12,018          13,062
29153 Ozark County                                 MO           8,598           9,542
29155 Pemiscot County                              MO          21,921          20,047
29157 Perry County                                 MO          16,648          18,132
29159 Pettis County                                MO          35,437          39,403
29161 Phelps County                                MO          35,248          39,825
29163 Pike County                                  MO          15,969          18,351
29165 Platte County                                MO          57,867          73,781
29167 Polk County                                  MO          21,826          26,992
29169 Pulaski County                               MO          41,307          41,165
29171 Putnam County                                MO           5,079           5,223
29173 Ralls County                                 MO           8,476           9,626
29175 Randolph County                              MO          24,370          24,663
29177 Ray County                                   MO          21,971          23,354
29179 Reynolds County                              MO           6,661           6,689
29181 Ripley County                                MO          12,303          13,509
29183 St. Charles County                           MO         212,907         283,883
29185 St. Clair County                             MO           8,457           9,652
29186 Ste. Genevieve County                        MO          16,037          17,842
29187 St. Francois County                          MO          48,904          55,641
29189 St. Louis County                             MO         993,529       1,016,315
29195 Saline County                                MO          23,523          23,756
29197 Schuyler County                              MO           4,236           4,170
29199 Scotland County                              MO           4,822           4,983
29201 Scott County                                 MO          39,376          40,422
29203 Shannon County                               MO           7,613           8,324
29205 Shelby County                                MO           6,942           6,799
29207 Stoddard County                              MO          28,895          29,705
29209 Stone County                                 MO          19,078          28,658
29211 Sullivan County                              MO           6,326           7,219
29213 Taney County                                 MO          25,561          39,703
29215 Texas County                                 MO          21,476          23,003
29217 Vernon County                                MO          19,041          20,454
29219 Warren County                                MO          19,534          24,525
29221 Washington County                            MO          20,380          23,344
29223 Wayne County                                 MO          11,543          13,259
29225 Webster County                               MO          23,753          31,045
29227 Worth County                                 MO           2,440           2,382
29229 Wright County                                MO          16,758          17,955
29510 St. Louis city                               MO         396,685         348,189
30001 Beaverhead County                            MT           8,424           9,202
30003 Big Horn County                              MT          11,337          12,671
30005 Blaine County                                MT           6,728           7,009
30007 Broadwater County                            MT           3,318           4,385
30009 Carbon County                                MT           8,080           9,552
30011 Carter County                                MT           1,503           1,360
30013 Cascade County                               MT          77,691          80,357
30015 Chouteau County                              MT           5,452           5,970
30017 Custer County                                MT          11,697          11,696
30019 Daniels County                               MT           2,266           2,017
30021 Dawson County                                MT           9,505           9,059
30023 Deer Lodge County                            MT          10,278           9,417
30025 Fallon County                                MT           3,103           2,837
30027 Fergus County                                MT          12,083          11,893
30029 Flathead County                              MT          59,218          74,471
30031 Gallatin County                              MT          50,463          67,831
30033 Garfield County                              MT           1,589           1,279
30035 Glacier County                               MT          12,121          13,247
30037 Golden Valley County                         MT             912           1,042
30039 Granite County                               MT           2,548           2,830
30041 Hill County                                  MT          17,654          16,673
30043 Jefferson County                             MT           7,939          10,049
30045 Judith Basin County                          MT           2,282           2,329
30047 Lake County                                  MT          21,041          26,507
30049 Lewis and Clark County                       MT          47,495          55,716
30051 Liberty County                               MT           2,295           2,158
30053 Lincoln County                               MT          17,481          18,837
30055 McCone County                                MT           2,276           1,977
30057 Madison County                               MT           5,989           6,851
30059 Meagher County                               MT           1,819           1,932
30061 Mineral County                               MT           3,315           3,884
30063 Missoula County                              MT          78,687          95,802
30065 Musselshell County                           MT           4,106           4,497
30067 Park County                                  MT          14,562          15,694
30069 Petroleum County                             MT             519             493
30071 Phillips County                              MT           5,163           4,601
30073 Pondera County                               MT           6,433           6,424
30075 Powder River County                          MT           2,090           1,858
30077 Powell County                                MT           6,620           7,180
30079 Prairie County                               MT           1,383           1,199
30081 Ravalli County                               MT          25,010          36,070
30083 Richland County                              MT          10,716           9,667
30085 Roosevelt County                             MT          10,999          10,620
30087 Rosebud County                               MT          10,505           9,383
30089 Sanders County                               MT           8,669          10,227
30091 Sheridan County                              MT           4,732           4,105
30093 Silver Bow County                            MT          33,941          34,606
30095 Stillwater County                            MT           6,536           8,195
30097 Sweet Grass County                           MT           3,154           3,609
30099 Teton County                                 MT           6,271           6,445
30101 Toole County                                 MT           5,046           5,267
30103 Treasure County                              MT             874             861
30105 Valley County                                MT           8,239           7,675
30107 Wheatland County                             MT           2,246           2,259
30109 Wibaux County                                MT           1,191           1,068
30111 Yellowstone County                           MT         113,419         129,352
31001 Adams County                                 NE          29,625          31,151
31003 Antelope County                              NE           7,965           7,452
31005 Arthur County                                NE             462             444
31007 Banner County                                NE             852             819
31009 Blaine County                                NE             675             583
31011 Boone County                                 NE           6,667           6,259
31013 Box Butte County                             NE          13,130          12,158
31015 Boyd County                                  NE           2,835           2,438
31017 Brown County                                 NE           3,657           3,525
31019 Buffalo County                               NE          37,447          42,259
31021 Burt County                                  NE           7,868           7,791
31023 Butler County                                NE           8,601           8,767
31025 Cass County                                  NE          21,318          24,334
31027 Cedar County                                 NE          10,131           9,615
31029 Chase County                                 NE           4,381           4,068
31031 Cherry County                                NE           6,307           6,148
31033 Cheyenne County                              NE           9,494           9,830
31035 Clay County                                  NE           7,123           7,039
31037 Colfax County                                NE           9,139          10,441
31039 Cuming County                                NE          10,117          10,203
31041 Custer County                                NE          12,270          11,793
31043 Dakota County                                NE          16,742          20,253
31045 Dawes County                                 NE           9,021           9,060
31047 Dawson County                                NE          19,940          24,365
31049 Deuel County                                 NE           2,237           2,098
31051 Dixon County                                 NE           6,143           6,339
31053 Dodge County                                 NE          34,500          36,160
31055 Douglas County                               NE         416,444         463,585
31057 Dundy County                                 NE           2,582           2,292
31059 Fillmore County                              NE           7,103           6,634
31061 Franklin County                              NE           3,938           3,574
31063 Frontier County                              NE           3,101           3,099
31065 Furnas County                                NE           5,553           5,324
31067 Gage County                                  NE          22,794          22,993
31069 Garden County                                NE           2,460           2,292
31071 Garfield County                              NE           2,141           1,902
31073 Gosper County                                NE           1,928           2,143
31075 Grant County                                 NE             769             747
31077 Greeley County                               NE           3,006           2,714
31079 Hall County                                  NE          48,925          53,534
31081 Hamilton County                              NE           8,862           9,403
31083 Harlan County                                NE           3,810           3,786
31085 Hayes County                                 NE           1,222           1,068
31087 Hitchcock County                             NE           3,750           3,111
31089 Holt County                                  NE          12,599          11,551
31091 Hooker County                                NE             793             783
31093 Howard County                                NE           6,055           6,567
31095 Jefferson County                             NE           8,759           8,333
31097 Johnson County                               NE           4,673           4,488
31099 Kearney County                               NE           6,629           6,882
31101 Keith County                                 NE           8,584           8,875
31103 Keya Paha County                             NE           1,029             983
31105 Kimball County                               NE           4,108           4,089
31107 Knox County                                  NE           9,534           9,374
31109 Lancaster County                             NE         213,641         250,291
31111 Lincoln County                               NE          32,508          34,632
31113 Logan County                                 NE             878             774
31115 Loup County                                  NE             683             712
31117 McPherson County                             NE             546             533
31119 Madison County                               NE          32,655          35,226
31121 Merrick County                               NE           8,042           8,204
31123 Morrill County                               NE           5,423           5,440
31125 Nance County                                 NE           4,275           4,038
31127 Nemaha County                                NE           7,980           7,576
31129 Nuckolls County                              NE           5,786           5,057
31131 Otoe County                                  NE          14,252          15,396
31133 Pawnee County                                NE           3,317           3,087
31135 Perkins County                               NE           3,367           3,200
31137 Phelps County                                NE           9,715           9,747
31139 Pierce County                                NE           7,827           7,857
31141 Platte County                                NE          29,820          31,662
31143 Polk County                                  NE           5,675           5,639
31145 Red Willow County                            NE          11,705          11,448
31147 Richardson County                            NE           9,937           9,531
31149 Rock County                                  NE           2,019           1,756
31151 Saline County                                NE          12,715          13,843
31153 Sarpy County                                 NE         102,583         122,595
31155 Saunders County                              NE          18,285          19,830
31157 Scotts Bluff County                          NE          36,025          36,951
31159 Seward County                                NE          15,450          16,496
31161 Sheridan County                              NE           6,750           6,198
31163 Sherman County                               NE           3,718           3,318
31165 Sioux County                                 NE           1,549           1,475
31167 Stanton County                               NE           6,244           6,455
31169 Thayer County                                NE           6,635           6,055
31171 Thomas County                                NE             851             729
31173 Thurston County                              NE           6,936           7,171
31175 Valley County                                NE           5,169           4,647
31177 Washington County                            NE          16,607          18,780
31179 Wayne County                                 NE           9,364           9,851
31181 Webster County                               NE           4,279           4,061
31183 Wheeler County                               NE             948             886
31185 York County                                  NE          14,428          14,598
32001 Churchill County                             NV          17,938          23,982
32003 Clark County                                 NV         741,459       1,375,765
32005 Douglas County                               NV          27,637          41,259
32007 Elko County                                  NV          33,530          45,291
32009 Esmeralda County                             NV           1,344             971
32011 Eureka County                                NV           1,547           1,651
32013 Humboldt County                              NV          12,844          16,106
32015 Lander County                                NV           6,266           5,794
32017 Lincoln County                               NV           3,775           4,165
32019 Lyon County                                  NV          20,001          34,501
32021 Mineral County                               NV           6,475           5,071
32023 Nye County                                   NV          17,781          32,485
32027 Pershing County                              NV           4,336           6,693
32029 Storey County                                NV           2,526           3,399
32031 Washoe County                                NV         254,667         339,486
32033 White Pine County                            NV           9,264           9,181
32510 Carson City                                  NV          40,443          52,457
33001 Belknap County                               NH          49,216          56,325
33003 Carroll County                               NH          35,410          43,666
33005 Cheshire County                              NH          70,121          73,825
33007 Coos County                                  NH          34,828          33,111
33009 Grafton County                               NH          74,929          81,743
33011 Hillsborough County                          NH         336,073         380,841
33013 Merrimack County                             NH         120,005         136,225
33015 Rockingham County                            NH         245,845         277,359
33017 Strafford County                             NH         104,233         112,233
33019 Sullivan County                              NH          38,592          40,458
34001 Atlantic County                              NJ         224,327         252,552
34003 Bergen County                                NJ         825,380         884,118
34005 Burlington County                            NJ         395,066         423,394
34007 Camden County                                NJ         502,824         508,932
34009 Cape May County                              NJ          95,089         102,326
34011 Cumberland County                            NJ         138,053         146,438
34013 Essex County                                 NJ         778,206         793,633
34015 Gloucester County                            NJ         230,082         254,673
34017 Hudson County                                NJ         553,099         608,975
34019 Hunterdon County                             NJ         107,776         121,989
34021 Mercer County                                NJ         325,824         350,761
34023 Middlesex County                             NJ         671,780         750,162
34025 Monmouth County                              NJ         553,124         615,301
34027 Morris County                                NJ         421,353         470,212
34029 Ocean County                                 NJ         433,203         510,916
34031 Passaic County                               NJ         453,060         489,049
34033 Salem County                                 NJ          65,294          64,285
34035 Somerset County                              NJ         240,279         297,490
34037 Sussex County                                NJ         130,943         144,166
34039 Union County                                 NJ         493,819         522,541
34041 Warren County                                NJ          91,607         102,437
35001 Bernalillo County                            NM         480,577         556,678
35003 Catron County                                NM           2,563           3,543
35005 Chaves County                                NM          57,849          61,382
35006 Cibola County                                NM          23,794          25,595
35007 Colfax County                                NM          12,925          14,189
35009 Curry County                                 NM          42,207          45,044
35011 DeBaca County                                NM           2,252           2,240
35013 Dona Ana County                              NM         135,510         174,682
35015 Eddy County                                  NM          48,605          51,658
35017 Grant County                                 NM          27,676          31,002
35019 Guadalupe County                             NM           4,156           4,680
35021 Harding County                               NM             987             810
35023 Hidalgo County                               NM           5,958           5,932
35025 Lea County                                   NM          55,765          55,511
35027 Lincoln County                               NM          12,219          19,411
35028 Los Alamos County                            NM          18,115          18,343
35029 Luna County                                  NM          18,110          25,016
35031 McKinley County                              NM          60,686          74,798
35033 Mora County                                  NM           4,264           5,180
35035 Otero County                                 NM          51,928          62,298
35037 Quay County                                  NM          10,823          10,155
35039 Rio Arriba County                            NM          34,365          41,190
35041 Roosevelt County                             NM          16,702          18,018
35043 Sandoval County                              NM          63,319          89,908
35045 San Juan County                              NM          91,605         113,801
35047 San Miguel County                            NM          25,743          30,126
35049 Santa Fe County                              NM          98,928         129,292
35051 Sierra County                                NM           9,912          13,270
35053 Socorro County                               NM          14,764          18,078
35055 Taos County                                  NM          23,118          29,979
35057 Torrance County                              NM          10,285          16,911
35059 Union County                                 NM           4,124           4,174
35061 Valencia County                              NM          45,235          66,152
36001 Albany County                                NY         292,594         294,565
36003 Allegany County                              NY          50,470          49,927
36005 Bronx County                                 NY       1,203,789       1,332,650
36007 Broome County                                NY         212,160         200,536
36009 Cattaraugus County                           NY          84,234          83,955
36011 Cayuga County                                NY          82,313          81,963
36013 Chautauqua County                            NY         141,895         139,750
36015 Chemung County                               NY          95,195          91,070
36017 Chenango County                              NY          51,768          51,401
36019 Clinton County                               NY          85,969          79,894
36021 Columbia County                              NY          62,982          63,094
36023 Cortland County                              NY          48,963          48,599
36025 Delaware County                              NY          47,225          48,055
36027 Dutchess County                              NY         259,462         280,150
36029 Erie County                                  NY         968,532         950,265
36031 Essex County                                 NY          37,152          38,851
36033 Franklin County                              NY          46,540          51,134
36035 Fulton County                                NY          54,191          55,073
36037 Genesee County                               NY          60,060          60,370
36039 Greene County                                NY          44,739          48,195
36041 Hamilton County                              NY           5,279           5,379
36043 Herkimer County                              NY          65,797          64,427
36045 Jefferson County                             NY         110,943         111,738
36047 Kings County                                 NY       2,300,664       2,465,326
36049 Lewis County                                 NY          26,796          26,944
36051 Livingston County                            NY          62,372          64,328
36053 Madison County                               NY          69,120          69,441
36055 Monroe County                                NY         713,968         735,343
36057 Montgomery County                            NY          51,981          49,708
36059 Nassau County                                NY       1,287,348       1,334,544
36061 New York County                              NY       1,487,536       1,537,195
36063 Niagara County                               NY         220,756         219,846
36065 Oneida County                                NY         250,836         235,469
36067 Onondaga County                              NY         468,973         458,336
36069 Ontario County                               NY          95,101         100,224
36071 Orange County                                NY         307,647         341,367
36073 Orleans County                               NY          41,846          44,171
36075 Oswego County                                NY         121,771         122,377
36077 Otsego County                                NY          60,517          61,676
36079 Putnam County                                NY          83,941          95,745
36081 Queens County                                NY       1,951,598       2,229,379
36083 Rensselaer County                            NY         154,429         152,538
36085 Richmond County                              NY         378,977         443,728
36087 Rockland County                              NY         265,475         286,753
36089 St. Lawrence County                          NY         111,974         111,931
36091 Saratoga County                              NY         181,276         200,635
36093 Schenectady County                           NY         149,285         146,555
36095 Schoharie County                             NY          31,859          31,582
36097 Schuyler County                              NY          18,662          19,224
36099 Seneca County                                NY          33,683          33,342
36101 Steuben County                               NY          99,088          98,726
36103 Suffolk County                               NY       1,321,864       1,419,369
36105 Sullivan County                              NY          69,277          73,966
36107 Tioga County                                 NY          52,337          51,784
36109 Tompkins County                              NY          94,097          96,501
36111 Ulster County                                NY         165,304         177,749
36113 Warren County                                NY          59,209          63,303
36115 Washington County                            NY          59,330          61,042
36117 Wayne County                                 NY          89,123          93,765
36119 Westchester County                           NY         874,866         923,459
36121 Wyoming County                               NY          42,507          43,424
36123 Yates County                                 NY          22,810          24,621
37001 Alamance County                              NC         108,213         130,800
37003 Alexander County                             NC          27,544          33,603
37005 Alleghany County                             NC           9,590          10,677
37007 Anson County                                 NC          23,474          25,275
37009 Ashe County                                  NC          22,209          24,384
37011 Avery County                                 NC          14,867          17,167
37013 Beaufort County                              NC          42,283          44,958
37015 Bertie County                                NC          20,388          19,773
37017 Bladen County                                NC          28,663          32,278
37019 Brunswick County                             NC          50,985          73,143
37021 Buncombe County                              NC         174,821         206,330
37023 Burke County                                 NC          75,744          89,148
37025 Cabarrus County                              NC          98,935         131,063
37027 Caldwell County                              NC          70,709          77,415
37029 Camden County                                NC           5,904           6,885
37031 Carteret County                              NC          52,556          59,383
37033 Caswell County                               NC          20,693          23,501
37035 Catawba County                               NC         118,412         141,685
37037 Chatham County                               NC          38,759          49,329
37039 Cherokee County                              NC          20,170          24,298
37041 Chowan County                                NC          13,506          14,526
37043 Clay County                                  NC           7,155           8,775
37045 Cleveland County                             NC          84,714          96,287
37047 Columbus County                              NC          49,587          54,749
37049 Craven County                                NC          81,613          91,436
37051 Cumberland County                            NC         274,566         302,963
37053 Currituck County                             NC          13,736          18,190
37055 Dare County                                  NC          22,746          29,967
37057 Davidson County                              NC         126,677         147,246
37059 Davie County                                 NC          27,859          34,835
37061 Duplin County                                NC          39,995          49,063
37063 Durham County                                NC         181,835         223,314
37065 Edgecombe County                             NC          56,558          55,606
37067 Forsyth County                               NC         265,878         306,067
37069 Franklin County                              NC          36,414          47,260
37071 Gaston County                                NC         175,093         190,365
37073 Gates County                                 NC           9,305          10,516
37075 Graham County                                NC           7,196           7,993
37077 Granville County                             NC          38,345          48,498
37079 Greene County                                NC          15,384          18,974
37081 Guilford County                              NC         347,420         421,048
37083 Halifax County                               NC          55,516          57,370
37085 Harnett County                               NC          67,822          91,025
37087 Haywood County                               NC          46,942          54,033
37089 Henderson County                             NC          69,285          89,173
37091 Hertford County                              NC          22,523          22,601
37093 Hoke County                                  NC          22,856          33,646
37095 Hyde County                                  NC           5,411           5,826
37097 Iredell County                               NC          92,931         122,660
37099 Jackson County                               NC          26,846          33,121
37101 Johnston County                              NC          81,306         121,965
37103 Jones County                                 NC           9,414          10,381
37105 Lee County                                   NC          41,374          49,040
37107 Lenoir County                                NC          57,274          59,648
37109 Lincoln County                               NC          50,319          63,780
37111 McDowell County                              NC          35,681          42,151
37113 Macon County                                 NC          23,499          29,811
37115 Madison County                               NC          16,953          19,635
37117 Martin County                                NC          25,078          25,593
37119 Mecklenburg County                           NC         511,433         695,454
37121 Mitchell County                              NC          14,433          15,687
37123 Montgomery County                            NC          23,346          26,822
37125 Moore County                                 NC          59,013          74,769
37127 Nash County                                  NC          76,677          87,420
37129 New Hanover County                           NC         120,284         160,307
37131 Northampton County                           NC          20,798          22,086
37133 Onslow County                                NC         149,838         150,355
37135 Orange County                                NC          93,851         118,227
37137 Pamlico County                               NC          11,372          12,934
37139 Pasquotank County                            NC          31,298          34,897
37141 Pender County                                NC          28,855          41,082
37143 Perquimans County                            NC          10,447          11,368
37145 Person County                                NC          30,180          35,623
37147 Pitt County                                  NC         107,924         133,798
37149 Polk County                                  NC          14,416          18,324
37151 Randolph County                              NC         106,546         130,454
37153 Richmond County                              NC          44,518          46,564
37155 Robeson County                               NC         105,179         123,339
37157 Rockingham County                            NC          86,064          91,928
37159 Rowan County                                 NC         110,605         130,340
37161 Rutherford County                            NC          56,918          62,899
37163 Sampson County                               NC          47,297          60,161
37165 Scotland County                              NC          33,754          35,998
37167 Stanly County                                NC          51,765          58,100
37169 Stokes County                                NC          37,223          44,711
37171 Surry County                                 NC          61,704          71,219
37173 Swain County                                 NC          11,268          12,968
37175 Transylvania County                          NC          25,520          29,334
37177 Tyrrell County                               NC           3,856           4,149
37179 Union County                                 NC          84,211         123,677
37181 Vance County                                 NC          38,892          42,954
37183 Wake County                                  NC         423,380         627,846
37185 Warren County                                NC          17,265          19,972
37187 Washington County                            NC          13,997          13,723
37189 Watauga County                               NC          36,952          42,695
37191 Wayne County                                 NC         104,666         113,329
37193 Wilkes County                                NC          59,393          65,632
37195 Wilson County                                NC          66,061          73,814
37197 Yadkin County                                NC          30,488          36,348
37199 Yancey County                                NC          15,419          17,774
38001 Adams County                                 ND           3,174           2,593
38003 Barnes County                                ND          12,545          11,775
38005 Benson County                                ND           7,198           6,964
38007 Billings County                              ND           1,108             888
38009 Bottineau County                             ND           8,011           7,149
38011 Bowman County                                ND           3,596           3,242
38013 Burke County                                 ND           3,002           2,242
38015 Burleigh County                              ND          60,131          69,416
38017 Cass County                                  ND         102,874         123,138
38019 Cavalier County                              ND           6,064           4,831
38021 Dickey County                                ND           6,107           5,757
38023 Divide County                                ND           2,899           2,283
38025 Dunn County                                  ND           4,005           3,600
38027 Eddy County                                  ND           2,951           2,757
38029 Emmons County                                ND           4,830           4,331
38031 Foster County                                ND           3,983           3,759
38033 Golden Valley County                         ND           2,108           1,924
38035 Grand Forks County                           ND          70,683          66,109
38037 Grant County                                 ND           3,549           2,841
38039 Griggs County                                ND           3,303           2,754
38041 Hettinger County                             ND           3,445           2,715
38043 Kidder County                                ND           3,332           2,753
38045 LaMoure County                               ND           5,383           4,701
38047 Logan County                                 ND           2,847           2,308
38049 McHenry County                               ND           6,528           5,987
38051 McIntosh County                              ND           4,021           3,390
38053 McKenzie County                              ND           6,383           5,737
38055 McLean County                                ND          10,457           9,311
38057 Mercer County                                ND           9,808           8,644
38059 Morton County                                ND          23,700          25,303
38061 Mountrail County                             ND           7,021           6,631
38063 Nelson County                                ND           4,410           3,715
38065 Oliver County                                ND           2,381           2,065
38067 Pembina County                               ND           9,238           8,585
38069 Pierce County                                ND           5,052           4,675
38071 Ramsey County                                ND          12,681          12,066
38073 Ransom County                                ND           5,921           5,890
38075 Renville County                              ND           3,160           2,610
38077 Richland County                              ND          18,148          17,998
38079 Rolette County                               ND          12,772          13,674
38081 Sargent County                               ND           4,549           4,366
38083 Sheridan County                              ND           2,148           1,710
38085 Sioux County                                 ND           3,761           4,044
38087 Slope County                                 ND             907             767
38089 Stark County                                 ND          22,832          22,636
38091 Steele County                                ND           2,420           2,258
38093 Stutsman County                              ND          22,241          21,908
38095 Towner County                                ND           3,627           2,876
38097 Traill County                                ND           8,752           8,477
38099 Walsh County                                 ND          13,840          12,389
38101 Ward County                                  ND          57,921          58,795
38103 Wells County                                 ND           5,864           5,102
38105 Williams County                              ND          21,129          19,761
39001 Adams County                                 OH          25,371          27,330
39003 Allen County                                 OH         109,755         108,473
39005 Ashland County                               OH          47,507          52,523
39007 Ashtabula County                             OH          99,821         102,728
39009 Athens County                                OH          59,549          62,223
39011 Auglaize County                              OH          44,585          46,611
39013 Belmont County                               OH          71,074          70,226
39015 Brown County                                 OH          34,966          42,285
39017 Butler County                                OH         291,479         332,807
39019 Carroll County                               OH          26,521          28,836
39021 Champaign County                             OH          36,019          38,890
39023 Clark County                                 OH         147,548         144,742
39025 Clermont County                              OH         150,187         177,977
39027 Clinton County                               OH          35,415          40,543
39029 Columbiana County                            OH         108,276         112,075
39031 Coshocton County                             OH          35,427          36,655
39033 Crawford County                              OH          47,870          46,966
39035 Cuyahoga County                              OH       1,412,140       1,393,978
39037 Darke County                                 OH          53,619          53,309
39039 Defiance County                              OH          39,350          39,500
39041 Delaware County                              OH          66,929         109,989
39043 Erie County                                  OH          76,779          79,551
39045 Fairfield County                             OH         103,461         122,759
39047 Fayette County                               OH          27,466          28,433
39049 Franklin County                              OH         961,437       1,068,978
39051 Fulton County                                OH          38,498          42,084
39053 Gallia County                                OH          30,954          31,069
39055 Geauga County                                OH          81,129          90,895
39057 Greene County                                OH         136,731         147,886
39059 Guernsey County                              OH          39,024          40,792
39061 Hamilton County                              OH         866,228         845,303
39063 Hancock County                               OH          65,536          71,295
39065 Hardin County                                OH          31,111          31,945
39067 Harrison County                              OH          16,085          15,856
39069 Henry County                                 OH          29,108          29,210
39071 Highland County                              OH          35,728          40,875
39073 Hocking County                               OH          25,533          28,241
39075 Holmes County                                OH          32,849          38,943
39077 Huron County                                 OH          56,240          59,487
39079 Jackson County                               OH          30,230          32,641
39081 Jefferson County                             OH          80,298          73,894
39083 Knox County                                  OH          47,473          54,500
39085 Lake County                                  OH         215,499         227,511
39087 Lawrence County                              OH          61,834          62,319
39089 Licking County                               OH         128,300         145,491
39091 Logan County                                 OH          42,310          46,005
39093 Lorain County                                OH         271,126         284,664
39095 Lucas County                                 OH         462,361         455,054
39097 Madison County                               OH          37,068          40,213
39099 Mahoning County                              OH         264,806         257,555
39101 Marion County                                OH          64,274          66,217
39103 Medina County                                OH         122,354         151,095
39105 Meigs County                                 OH          22,987          23,072
39107 Mercer County                                OH          39,443          40,924
39109 Miami County                                 OH          93,182          98,868
39111 Monroe County                                OH          15,497          15,180
39113 Montgomery County                            OH         573,809         559,062
39115 Morgan County                                OH          14,194          14,897
39117 Morrow County                                OH          27,749          31,628
39119 Muskingum County                             OH          82,068          84,585
39121 Noble County                                 OH          11,336          14,058
39123 Ottawa County                                OH          40,029          40,985
39125 Paulding County                              OH          20,488          20,293
39127 Perry County                                 OH          31,557          34,078
39129 Pickaway County                              OH          48,255          52,727
39131 Pike County                                  OH          24,249          27,695
39133 Portage County                               OH         142,585         152,061
39135 Preble County                                OH          40,113          42,337
39137 Putnam County                                OH          33,819          34,726
39139 Richland County                              OH         126,137         128,852
39141 Ross County                                  OH          69,330          73,345
39143 Sandusky County                              OH          61,963          61,792
39145 Scioto County                                OH          80,327          79,195
39147 Seneca County                                OH          59,733          58,683
39149 Shelby County                                OH          44,915          47,910
39151 Stark County                                 OH         367,585         378,098
39153 Summit County                                OH         514,990         542,899
39155 Trumbull County                              OH         227,813         225,116
39157 Tuscarawas County                            OH          84,090          90,914
39159 Union County                                 OH          31,969          40,909
39161 Van Wert County                              OH          30,464          29,659
39163 Vinton County                                OH          11,098          12,806
39165 Warren County                                OH         113,909         158,383
39167 Washington County                            OH          62,254          63,251
39169 Wayne County                                 OH         101,461         111,564
39171 Williams County                              OH          36,956          39,188
39173 Wood County                                  OH         113,269         121,065
39175 Wyandot County                               OH          22,254          22,908
40001 Adair County                                 OK          18,421          21,038
40003 Alfalfa County                               OK           6,416           6,105
40005 Atoka County                                 OK          12,778          13,879
40007 Beaver County                                OK           6,023           5,857
40009 Beckham County                               OK          18,812          19,799
40011 Blaine County                                OK          11,470          11,976
40013 Bryan County                                 OK          32,089          36,534
40015 Caddo County                                 OK          29,550          30,150
40017 Canadian County                              OK          74,409          87,697
40019 Carter County                                OK          42,919          45,621
40021 Cherokee County                              OK          34,049          42,521
40023 Choctaw County                               OK          15,302          15,342
40025 Cimarron County                              OK           3,301           3,148
40027 Cleveland County                             OK         174,253         208,016
40029 Coal County                                  OK           5,780           6,031
40031 Comanche County                              OK         111,486         114,996
40033 Cotton County                                OK           6,651           6,614
40035 Craig County                                 OK          14,104          14,950
40037 Creek County                                 OK          60,915          67,367
40039 Custer County                                OK          26,897          26,142
40041 Delaware County                              OK          28,070          37,077
40043 Dewey County                                 OK           5,551           4,743
40045 Ellis County                                 OK           4,497           4,075
40047 Garfield County                              OK          56,735          57,813
40049 Garvin County                                OK          26,605          27,210
40051 Grady County                                 OK          41,747          45,516
40053 Grant County                                 OK           5,689           5,144
40055 Greer County                                 OK           6,559           6,061
40057 Harmon County                                OK           3,793           3,283
40059 Harper County                                OK           4,063           3,562
40061 Haskell County                               OK          10,940          11,792
40063 Hughes County                                OK          13,023          14,154
40065 Jackson County                               OK          28,764          28,439
40067 Jefferson County                             OK           7,010           6,818
40069 Johnston County                              OK          10,032          10,513
40071 Kay County                                   OK          48,056          48,080
40073 Kingfisher County                            OK          13,212          13,926
40075 Kiowa County                                 OK          11,347          10,227
40077 Latimer County                               OK          10,333          10,692
40079 Le Flore County                              OK          43,270          48,109
40081 Lincoln County                               OK          29,216          32,080
40083 Logan County                                 OK          29,011          33,924
40085 Love County                                  OK           8,157           8,831
40087 McClain County                               OK          22,795          27,740
40089 McCurtain County                             OK          33,433          34,402
40091 McIntosh County                              OK          16,779          19,456
40093 Major County                                 OK           8,055           7,545
40095 Marshall County                              OK          10,829          13,184
40097 Mayes County                                 OK          33,366          38,369
40099 Murray County                                OK          12,042          12,623
40101 Muskogee County                              OK          68,078          69,451
40103 Noble County                                 OK          11,045          11,411
40105 Nowata County                                OK           9,992          10,569
40107 Okfuskee County                              OK          11,551          11,814
40109 Oklahoma County                              OK         599,611         660,448
40111 Okmulgee County                              OK          36,490          39,685
40113 Osage County                                 OK          41,645          44,437
40115 Ottawa County                                OK          30,561          33,194
40117 Pawnee County                                OK          15,575          16,612
40119 Payne County                                 OK          61,507          68,190
40121 Pittsburg County                             OK          40,581          43,953
40123 Pontotoc County                              OK          34,119          35,143
40125 Pottawatomie County                          OK          58,760          65,521
40127 Pushmataha County                            OK          10,997          11,667
40129 Roger Mills County                           OK           4,147           3,436
40131 Rogers County                                OK          55,170          70,641
40133 Seminole County                              OK          25,412          24,894
40135 Sequoyah County                              OK          33,828          38,972
40137 Stephens County                              OK          42,299          43,182
40139 Texas County                                 OK          16,419          20,107
40141 Tillman County                               OK          10,384           9,287
40143 Tulsa County                                 OK         503,341         563,299
40145 Wagoner County                               OK          47,883          57,491
40147 Washington County                            OK          48,066          48,996
40149 Washita County                               OK          11,441          11,508
40151 Woods County                                 OK           9,103           9,089
40153 Woodward County                              OK          18,976          18,486
41001 Baker County                                 OR          15,317          16,741
41003 Benton County                                OR          70,811          78,153
41005 Clackamas County                             OR         278,850         338,391
41007 Clatsop County                               OR          33,301          35,630
41009 Columbia County                              OR          37,557          43,560
41011 Coos County                                  OR          60,273          62,779
41013 Crook County                                 OR          14,111          19,182
41015 Curry County                                 OR          19,327          21,137
41017 Deschutes County                             OR          74,958         115,367
41019 Douglas County                               OR          94,649         100,399
41021 Gilliam County                               OR           1,717           1,915
41023 Grant County                                 OR           7,853           7,935
41025 Harney County                                OR           7,060           7,609
41027 Hood River County                            OR          16,903          20,411
41029 Jackson County                               OR         146,389         181,269
41031 Jefferson County                             OR          13,676          19,009
41033 Josephine County                             OR          62,649          75,726
41035 Klamath County                               OR          57,702          63,775
41037 Lake County                                  OR           7,186           7,422
41039 Lane County                                  OR         282,912         322,959
41041 Lincoln County                               OR          38,889          44,479
41043 Linn County                                  OR          91,227         103,069
41045 Malheur County                               OR          26,038          31,615
41047 Marion County                                OR         228,483         284,834
41049 Morrow County                                OR           7,625          10,995
41051 Multnomah County                             OR         583,887         660,486
41053 Polk County                                  OR          49,541          62,380
41055 Sherman County                               OR           1,918           1,934
41057 Tillamook County                             OR          21,570          24,262
41059 Umatilla County                              OR          59,249          70,548
41061 Union County                                 OR          23,598          24,530
41063 Wallowa County                               OR           6,911           7,226
41065 Wasco County                                 OR          21,683          23,791
41067 Washington County                            OR         311,554         445,342
41069 Wheeler County                               OR           1,396           1,547
41071 Yamhill County                               OR          65,551          84,992
42001 Adams County                                 PA          78,274          91,292
42003 Allegheny County                             PA       1,336,449       1,281,666
42005 Armstrong County                             PA          73,478          72,392
42007 Beaver County                                PA         186,093         181,412
42009 Bedford County                               PA          47,919          49,984
42011 Berks County                                 PA         336,523         373,638
42013 Blair County                                 PA         130,542         129,144
42015 Bradford County                              PA          60,967          62,761
42017 Bucks County                                 PA         541,174         597,635
42019 Butler County                                PA         152,013         174,083
42021 Cambria County                               PA         163,029         152,598
42023 Cameron County                               PA           5,913           5,974
42025 Carbon County                                PA          56,846          58,802
42027 Centre County                                PA         123,786         135,758
42029 Chester County                               PA         376,396         433,501
42031 Clarion County                               PA          41,699          41,765
42033 Clearfield County                            PA          78,097          83,382
42035 Clinton County                               PA          37,182          37,914
42037 Columbia County                              PA          63,202          64,151
42039 Crawford County                              PA          86,169          90,366
42041 Cumberland County                            PA         195,257         213,674
42043 Dauphin County                               PA         237,813         251,798
42045 Delaware County                              PA         547,651         550,864
42047 Elk County                                   PA          34,878          35,112
42049 Erie County                                  PA         275,572         280,843
42051 Fayette County                               PA         145,351         148,644
42053 Forest County                                PA           4,802           4,946
42055 Franklin County                              PA         121,082         129,313
42057 Fulton County                                PA          13,837          14,261
42059 Greene County                                PA          39,550          40,672
42061 Huntingdon County                            PA          44,164          45,586
42063 Indiana County                               PA          89,994          89,605
42065 Jefferson County                             PA          46,083          45,932
42067 Juniata County                               PA          20,625          22,821
42069 Lackawanna County                            PA         219,039         213,295
42071 Lancaster County                             PA         422,822         470,658
42073 Lawrence County                              PA          96,246          94,643
42075 Lebanon County                               PA         113,744         120,327
42077 Lehigh County                                PA         291,130         312,090
42079 Luzerne County                               PA         328,149         319,250
42081 Lycoming County                              PA         118,710         120,044
42083 McKean County                                PA          47,131          45,936
42085 Mercer County                                PA         121,003         120,293
42087 Mifflin County                               PA          46,197          46,486
42089 Monroe County                                PA          95,709         138,687
42091 Montgomery County                            PA         678,111         750,097
42093 Montour County                               PA          17,735          18,236
42095 Northampton County                           PA         247,105         267,066
42097 Northumberland County                        PA          96,771          94,556
42099 Perry County                                 PA          41,172          43,602
42101 Philadelphia County                          PA       1,585,577       1,517,550
42103 Pike County                                  PA          27,966          46,302
42105 Potter County                                PA          16,717          18,080
42107 Schuylkill County                            PA         152,585         150,336
42109 Snyder County                                PA          36,680          37,546
42111 Somerset County                              PA          78,218          80,023
42113 Sullivan County                              PA           6,104           6,556
42115 Susquehanna County                           PA          40,380          42,238
42117 Tioga County                                 PA          41,126          41,373
42119 Union County                                 PA          36,176          41,624
42121 Venango County                               PA          59,381          57,565
42123 Warren County                                PA          45,050          43,863
42125 Washington County                            PA         204,584         202,897
42127 Wayne County                                 PA          39,944          47,722
42129 Westmoreland County                          PA         370,321         369,993
42131 Wyoming County                               PA          28,076          28,080
42133 York County                                  PA         339,574         381,751
44001 Bristol County                               RI          48,859          50,648
44003 Kent County                                  RI         161,135         167,090
44005 Newport County                               RI          87,194          85,433
44007 Providence County                            RI         596,270         621,602
44009 Washington County                            RI         110,006         123,546
45001 Abbeville County                             SC          23,862          26,167
45003 Aiken County                                 SC         120,940         142,552
45005 Allendale County                             SC          11,722          11,211
45007 Anderson County                              SC         145,196         165,740
45009 Bamberg County                               SC          16,902          16,658
45011 Barnwell County                              SC          20,293          23,478
45013 Beaufort County                              SC          86,425         120,937
45015 Berkeley County                              SC         128,776         142,651
45017 Calhoun County                               SC          12,753          15,185
45019 Charleston County                            SC         295,039         309,969
45021 Cherokee County                              SC          44,506          52,537
45023 Chester County                               SC          32,170          34,068
45025 Chesterfield County                          SC          38,577          42,768
45027 Clarendon County                             SC          28,450          32,502
45029 Colleton County                              SC          34,377          38,264
45031 Darlington County                            SC          61,851          67,394
45033 Dillon County                                SC          29,114          30,722
45035 Dorchester County                            SC          83,060          96,413
45037 Edgefield County                             SC          18,375          24,595
45039 Fairfield County                             SC          22,295          23,454
45041 Florence County                              SC         114,344         125,761
45043 Georgetown County                            SC          46,302          55,797
45045 Greenville County                            SC         320,167         379,616
45047 Greenwood County                             SC          59,567          66,271
45049 Hampton County                               SC          18,191          21,386
45051 Horry County                                 SC         144,053         196,629
45053 Jasper County                                SC          15,487          20,678
45055 Kershaw County                               SC          43,599          52,647
45057 Lancaster County                             SC          54,516          61,351
45059 Laurens County                               SC          58,092          69,567
45061 Lee County                                   SC          18,437          20,119
45063 Lexington County                             SC         167,611         216,014
45065 McCormick County                             SC           8,868           9,958
45067 Marion County                                SC          33,899          35,466
45069 Marlboro County                              SC          29,361          28,818
45071 Newberry County                              SC          33,172          36,108
45073 Oconee County                                SC          57,494          66,215
45075 Orangeburg County                            SC          84,803          91,582
45077 Pickens County                               SC          93,894         110,757
45079 Richland County                              SC         285,720         320,677
45081 Saluda County                                SC          16,357          19,181
45083 Spartanburg County                           SC         226,800         253,791
45085 Sumter County                                SC         102,637         104,646
45087 Union County                                 SC          30,337          29,881
45089 Williamsburg County                          SC          36,815          37,217
45091 York County                                  SC         131,497         164,614
46003 Aurora County                                SD           3,135           3,058
46005 Beadle County                                SD          18,253          17,023
46007 Bennett County                               SD           3,206           3,574
46009 Bon Homme County                             SD           7,089           7,260
46011 Brookings County                             SD          25,207          28,220
46013 Brown County                                 SD          35,580          35,460
46015 Brule County                                 SD           5,485           5,364
46017 Buffalo County                               SD           1,759           2,032
46019 Butte County                                 SD           7,914           9,094
46021 Campbell County                              SD           1,965           1,782
46023 Charles Mix County                           SD           9,131           9,350
46025 Clark County                                 SD           4,403           4,143
46027 Clay County                                  SD          13,186          13,537
46029 Codington County                             SD          22,698          25,897
46031 Corson County                                SD           4,195           4,181
46033 Custer County                                SD           6,179           7,275
46035 Davison County                               SD          17,503          18,741
46037 Day County                                   SD           6,978           6,267
46039 Deuel County                                 SD           4,522           4,498
46041 Dewey County                                 SD           5,523           5,972
46043 Douglas County                               SD           3,746           3,458
46045 Edmunds County                               SD           4,356           4,367
46047 Fall River County                            SD           7,353           7,453
46049 Faulk County                                 SD           2,744           2,640
46051 Grant County                                 SD           8,372           7,847
46053 Gregory County                               SD           5,359           4,792
46055 Haakon County                                SD           2,624           2,196
46057 Hamlin County                                SD           4,974           5,540
46059 Hand County                                  SD           4,272           3,741
46061 Hanson County                                SD           2,994           3,139
46063 Harding County                               SD           1,669           1,353
46065 Hughes County                                SD          14,817          16,481
46067 Hutchinson County                            SD           8,262           8,075
46069 Hyde County                                  SD           1,696           1,671
46071 Jackson County                               SD           2,811           2,930
46073 Jerauld County                               SD           2,425           2,295
46075 Jones County                                 SD           1,324           1,193
46077 Kingsbury County                             SD           5,925           5,815
46079 Lake County                                  SD          10,550          11,276
46081 Lawrence County                              SD          20,655          21,802
46083 Lincoln County                               SD          15,427          24,131
46085 Lyman County                                 SD           3,638           3,895
46087 McCook County                                SD           5,688           5,832
46089 McPherson County                             SD           3,228           2,904
46091 Marshall County                              SD           4,844           4,576
46093 Meade County                                 SD          21,878          24,253
46095 Mellette County                              SD           2,137           2,083
46097 Miner County                                 SD           3,272           2,884
46099 Minnehaha County                             SD         123,809         148,281
46101 Moody County                                 SD           6,507           6,595
46103 Pennington County                            SD          81,343          88,565
46105 Perkins County                               SD           3,932           3,363
46107 Potter County                                SD           3,190           2,693
46109 Roberts County                               SD           9,914          10,016
46111 Sanborn County                               SD           2,833           2,675
46113 Shannon County                               SD           9,902          12,466
46115 Spink County                                 SD           7,981           7,454
46117 Stanley County                               SD           2,453           2,772
46119 Sully County                                 SD           1,589           1,556
46121 Todd County                                  SD           8,352           9,050
46123 Tripp County                                 SD           6,924           6,430
46125 Turner County                                SD           8,576           8,849
46127 Union County                                 SD          10,189          12,584
46129 Walworth County                              SD           6,087           5,974
46135 Yankton County                               SD          19,252          21,652
46137 Ziebach County                               SD           2,220           2,519
47001 Anderson County                              TN          68,250          71,330
47003 Bedford County                               TN          30,411          37,586
47005 Benton County                                TN          14,524          16,537
47007 Bledsoe County                               TN           9,669          12,367
47009 Blount County                                TN          85,969         105,823
47011 Bradley County                               TN          73,712          87,965
47013 Campbell County                              TN          35,079          39,854
47015 Cannon County                                TN          10,467          12,826
47017 Carroll County                               TN          27,514          29,475
47019 Carter County                                TN          51,505          56,742
47021 Cheatham County                              TN          27,140          35,912
47023 Chester County                               TN          12,819          15,540
47025 Claiborne County                             TN          26,137          29,862
47027 Clay County                                  TN           7,238           7,976
47029 Cocke County                                 TN          29,141          33,565
47031 Coffee County                                TN          40,339          48,014
47033 Crockett County                              TN          13,378          14,532
47035 Cumberland County                            TN          34,736          46,802
47037 Davidson County                              TN         510,784         569,891
47039 Decatur County                               TN          10,472          11,731
47041 DeKalb County                                TN          14,360          17,423
47043 Dickson County                               TN          35,061          43,156
47045 Dyer County                                  TN          34,854          37,279
47047 Fayette County                               TN          25,559          28,806
47049 Fentress County                              TN          14,669          16,625
47051 Franklin County                              TN          34,725          39,270
47053 Gibson County                                TN          46,315          48,152
47055 Giles County                                 TN          25,741          29,447
47057 Grainger County                              TN          17,095          20,659
47059 Greene County                                TN          55,853          62,909
47061 Grundy County                                TN          13,362          14,332
47063 Hamblen County                               TN          50,480          58,128
47065 Hamilton County                              TN         285,536         307,896
47067 Hancock County                               TN           6,739           6,786
47069 Hardeman County                              TN          23,377          28,105
47071 Hardin County                                TN          22,633          25,578
47073 Hawkins County                               TN          44,565          53,563
47075 Haywood County                               TN          19,437          19,797
47077 Henderson County                             TN          21,844          25,522
47079 Henry County                                 TN          27,888          31,115
47081 Hickman County                               TN          16,754          22,295
47083 Houston County                               TN           7,018           8,088
47085 Humphreys County                             TN          15,795          17,929
47087 Jackson County                               TN           9,297          10,984
47089 Jefferson County                             TN          33,016          44,294
47091 Johnson County                               TN          13,766          17,499
47093 Knox County                                  TN         335,749         382,032
47095 Lake County                                  TN           7,129           7,954
47097 Lauderdale County                            TN          23,491          27,101
47099 Lawrence County                              TN          35,303          39,926
47101 Lewis County                                 TN           9,247          11,367
47103 Lincoln County                               TN          28,157          31,340
47105 Loudon County                                TN          31,255          39,086
47107 McMinn County                                TN          42,383          49,015
47109 McNairy County                               TN          22,422          24,653
47111 Macon County                                 TN          15,906          20,386
47113 Madison County                               TN          77,982          91,837
47115 Marion County                                TN          24,860          27,776
47117 Marshall County                              TN          21,539          26,767
47119 Maury County                                 TN          54,812          69,498
47121 Meigs County                                 TN           8,033          11,086
47123 Monroe County                                TN          30,541          38,961
47125 Montgomery County                            TN         100,498         134,768
47127 Moore County                                 TN           4,721           5,740
47129 Morgan County                                TN          17,300          19,757
47131 Obion County                                 TN          31,717          32,450
47133 Overton County                               TN          17,636          20,118
47135 Perry County                                 TN           6,612           7,631
47137 Pickett County                               TN           4,548           4,945
47139 Polk County                                  TN          13,643          16,050
47141 Putnam County                                TN          51,373          62,315
47143 Rhea County                                  TN          24,344          28,400
47145 Roane County                                 TN          47,227          51,910
47147 Robertson County                             TN          41,494          54,433
47149 Rutherford County                            TN         118,570         182,023
47151 Scott County                                 TN          18,358          21,127
47153 Sequatchie County                            TN           8,863          11,370
47155 Sevier County                                TN          51,043          71,170
47157 Shelby County                                TN         826,330         897,472
47159 Smith County                                 TN          14,143          17,712
47161 Stewart County                               TN           9,479          12,370
47163 Sullivan County                              TN         143,596         153,048
47165 Sumner County                                TN         103,281         130,449
47167 Tipton County                                TN          37,568          51,271
47169 Trousdale County                             TN           5,920           7,259
47171 Unicoi County                                TN          16,549          17,667
47173 Union County                                 TN          13,694          17,808
47175 Van Buren County                             TN           4,846           5,508
47177 Warren County                                TN          32,992          38,276
47179 Washington County                            TN          92,315         107,198
47181 Wayne County                                 TN          13,935          16,842
47183 Weakley County                               TN          31,972          34,895
47185 White County                                 TN          20,090          23,102
47187 Williamson County                            TN          81,021         126,638
47189 Wilson County                                TN          67,675          88,809
48001 Anderson County                              TX          48,024          55,109
48003 Andrews County                               TX          14,338          13,004
48005 Angelina County                              TX          69,884          80,130
48007 Aransas County                               TX          17,892          22,497
48009 Archer County                                TX           7,973           8,854
48011 Armstrong County                             TX           2,021           2,148
48013 Atascosa County                              TX          30,533          38,628
48015 Austin County                                TX          19,832          23,590
48017 Bailey County                                TX           7,064           6,594
48019 Bandera County                               TX          10,562          17,645
48021 Bastrop County                               TX          38,263          57,733
48023 Baylor County                                TX           4,385           4,093
48025 Bee County                                   TX          25,135          32,359
48027 Bell County                                  TX         191,088         237,974
48029 Bexar County                                 TX       1,185,394       1,392,931
48031 Blanco County                                TX           5,972           8,418
48033 Borden County                                TX             799             729
48035 Bosque County                                TX          15,125          17,204
48037 Bowie County                                 TX          81,665          89,306
48039 Brazoria County                              TX         191,707         241,767
48041 Brazos County                                TX         121,862         152,415
48043 Brewster County                              TX           8,681           8,866
48045 Briscoe County                               TX           1,971           1,790
48047 Brooks County                                TX           8,204           7,976
48049 Brown County                                 TX          34,371          37,674
48051 Burleson County                              TX          13,625          16,470
48053 Burnet County                                TX          22,677          34,147
48055 Caldwell County                              TX          26,392          32,194
48057 Calhoun County                               TX          19,053          20,647
48059 Callahan County                              TX          11,859          12,905
48061 Cameron County                               TX         260,120         335,227
48063 Camp County                                  TX           9,904          11,549
48065 Carson County                                TX           6,576           6,516
48067 Cass County                                  TX          29,982          30,438
48069 Castro County                                TX           9,070           8,285
48071 Chambers County                              TX          20,088          26,031
48073 Cherokee County                              TX          41,049          46,659
48075 Childress County                             TX           5,953           7,688
48077 Clay County                                  TX          10,024          11,006
48079 Cochran County                               TX           4,377           3,730
48081 Coke County                                  TX           3,424           3,864
48083 Coleman County                               TX           9,710           9,235
48085 Collin County                                TX         264,036         491,675
48087 Collingsworth County                         TX           3,573           3,206
48089 Colorado County                              TX          18,383          20,390
48091 Comal County                                 TX          51,832          78,021
48093 Comanche County                              TX          13,381          14,026
48095 Concho County                                TX           3,044           3,966
48097 Cooke County                                 TX          30,777          36,363
48099 Coryell County                               TX          64,213          74,978
48101 Cottle County                                TX           2,247           1,904
48103 Crane County                                 TX           4,652           3,996
48105 Crockett County                              TX           4,078           4,099
48107 Crosby County                                TX           7,304           7,072
48109 Culberson County                             TX           3,407           2,975
48111 Dallam County                                TX           5,461           6,222
48113 Dallas County                                TX       1,852,810       2,218,899
48115 Dawson County                                TX          14,349          14,985
48117 Deaf Smith County                            TX          19,153          18,561
48119 Delta County                                 TX           4,857           5,327
48121 Denton County                                TX         273,525         432,976
48123 DeWitt County                                TX          18,840          20,013
48125 Dickens County                               TX           2,571           2,762
48127 Dimmit County                                TX          10,433          10,248
48129 Donley County                                TX           3,696           3,828
48131 Duval County                                 TX          12,918          13,120
48133 Eastland County                              TX          18,488          18,297
48135 Ector County                                 TX         118,934         121,123
48137 Edwards County                               TX           2,266           2,162
48139 Ellis County                                 TX          85,167         111,360
48141 El Paso County                               TX         591,610         679,622
48143 Erath County                                 TX          27,991          33,001
48145 Falls County                                 TX          17,712          18,576
48147 Fannin County                                TX          24,804          31,242
48149 Fayette County                               TX          20,095          21,804
48151 Fisher County                                TX           4,842           4,344
48153 Floyd County                                 TX           8,497           7,771
48155 Foard County                                 TX           1,794           1,622
48157 Fort Bend County                             TX         225,421         354,452
48159 Franklin County                              TX           7,802           9,458
48161 Freestone County                             TX          15,818          17,867
48163 Frio County                                  TX          13,472          16,252
48165 Gaines County                                TX          14,123          14,467
48167 Galveston County                             TX         217,399         250,158
48169 Garza County                                 TX           5,143           4,872
48171 Gillespie County                             TX          17,204          20,814
48173 Glasscock County                             TX           1,447           1,406
48175 Goliad County                                TX           5,980           6,928
48177 Gonzales County                              TX          17,205          18,628
48179 Gray County                                  TX          23,967          22,744
48181 Grayson County                               TX          95,021         110,595
48183 Gregg County                                 TX         104,948         111,379
48185 Grimes County                                TX          18,828          23,552
48187 Guadalupe County                             TX          64,873          89,023
48189 Hale County                                  TX          34,671          36,602
48191 Hall County                                  TX           3,905           3,782
48193 Hamilton County                              TX           7,733           8,229
48195 Hansford County                              TX           5,848           5,369
48197 Hardeman County                              TX           5,283           4,724
48199 Hardin County                                TX          41,320          48,073
48201 Harris County                                TX       2,818,199       3,400,578
48203 Harrison County                              TX          57,483          62,110
48205 Hartley County                               TX           3,634           5,537
48207 Haskell County                               TX           6,820           6,093
48209 Hays County                                  TX          65,614          97,589
48211 Hemphill County                              TX           3,720           3,351
48213 Henderson County                             TX          58,543          73,277
48215 Hidalgo County                               TX         383,545         569,463
48217 Hill County                                  TX          27,146          32,321
48219 Hockley County                               TX          24,199          22,716
48221 Hood County                                  TX          28,981          41,100
48223 Hopkins County                               TX          28,833          31,960
48225 Houston County                               TX          21,375          23,185
48227 Howard County                                TX          32,343          33,627
48229 Hudspeth County                              TX           2,915           3,344
48231 Hunt County                                  TX          64,343          76,596
48233 Hutchinson County                            TX          25,689          23,857
48235 Irion County                                 TX           1,629           1,771
48237 Jack County                                  TX           6,981           8,763
48239 Jackson County                               TX          13,039          14,391
48241 Jasper County                                TX          31,102          35,604
48243 Jeff Davis County                            TX           1,946           2,207
48245 Jefferson County                             TX         239,397         252,051
48247 Jim Hogg County                              TX           5,109           5,281
48249 Jim Wells County                             TX          37,679          39,326
48251 Johnson County                               TX          97,165         126,811
48253 Jones County                                 TX          16,490          20,785
48255 Karnes County                                TX          12,455          15,446
48257 Kaufman County                               TX          52,220          71,313
48259 Kendall County                               TX          14,589          23,743
48261 Kenedy County                                TX             460             414
48263 Kent County                                  TX           1,010             859
48265 Kerr County                                  TX          36,304          43,653
48267 Kimble County                                TX           4,122           4,468
48269 King County                                  TX             354             356
48271 Kinney County                                TX           3,119           3,379
48273 Kleberg County                               TX          30,274          31,549
48275 Knox County                                  TX           4,837           4,253
48277 Lamar County                                 TX          43,949          48,499
48279 Lamb County                                  TX          15,072          14,709
48281 Lampasas County                              TX          13,521          17,762
48283 La Salle County                              TX           5,254           5,866
48285 Lavaca County                                TX          18,690          19,210
48287 Lee County                                   TX          12,854          15,657
48289 Leon County                                  TX          12,665          15,335
48291 Liberty County                               TX          52,726          70,154
48293 Limestone County                             TX          20,946          22,051
48295 Lipscomb County                              TX           3,143           3,057
48297 Live Oak County                              TX           9,556          12,309
48299 Llano County                                 TX          11,631          17,044
48301 Loving County                                TX             107              67
48303 Lubbock County                               TX         222,636         242,628
48305 Lynn County                                  TX           6,758           6,550
48307 McCulloch County                             TX           8,778           8,205
48309 McLennan County                              TX         189,123         213,517
48311 McMullen County                              TX             817             851
48313 Madison County                               TX          10,931          12,940
48315 Marion County                                TX           9,984          10,941
48317 Martin County                                TX           4,956           4,746
48319 Mason County                                 TX           3,423           3,738
48321 Matagorda County                             TX          36,928          37,957
48323 Maverick County                              TX          36,378          47,297
48325 Medina County                                TX          27,312          39,304
48327 Menard County                                TX           2,252           2,360
48329 Midland County                               TX         106,611         116,009
48331 Milam County                                 TX          22,946          24,238
48333 Mills County                                 TX           4,531           5,151
48335 Mitchell County                              TX           8,016           9,698
48337 Montague County                              TX          17,274          19,117
48339 Montgomery County                            TX         182,201         293,768
48341 Moore County                                 TX          17,865          20,121
48343 Morris County                                TX          13,200          13,048
48345 Motley County                                TX           1,532           1,426
48347 Nacogdoches County                           TX          54,753          59,203
48349 Navarro County                               TX          39,926          45,124
48351 Newton County                                TX          13,569          15,072
48353 Nolan County                                 TX          16,594          15,802
48355 Nueces County                                TX         291,145         313,645
48357 Ochiltree County                             TX           9,128           9,006
48359 Oldham County                                TX           2,278           2,185
48361 Orange County                                TX          80,509          84,966
48363 Palo Pinto County                            TX          25,055          27,026
48365 Panola County                                TX          22,035          22,756
48367 Parker County                                TX          64,785          88,495
48369 Parmer County                                TX           9,863          10,016
48371 Pecos County                                 TX          14,675          16,809
48373 Polk County                                  TX          30,687          41,133
48375 Potter County                                TX          97,874         113,546
48377 Presidio County                              TX           6,637           7,304
48379 Rains County                                 TX           6,715           9,139
48381 Randall County                               TX          89,673         104,312
48383 Reagan County                                TX           4,514           3,326
48385 Real County                                  TX           2,412           3,047
48387 Red River County                             TX          14,317          14,314
48389 Reeves County                                TX          15,852          13,137
48391 Refugio County                               TX           7,976           7,828
48393 Roberts County                               TX           1,025             887
48395 Robertson County                             TX          15,511          16,000
48397 Rockwall County                              TX          25,604          43,080
48399 Runnels County                               TX          11,294          11,495
48401 Rusk County                                  TX          43,735          47,372
48403 Sabine County                                TX           9,586          10,469
48405 San Augustine County                         TX           7,999           8,946
48407 San Jacinto County                           TX          16,372          22,246
48409 San Patricio County                          TX          58,749          67,138
48411 San Saba County                              TX           5,401           6,186
48413 Schleicher County                            TX           2,990           2,935
48415 Scurry County                                TX          18,634          16,361
48417 Shackelford County                           TX           3,316           3,302
48419 Shelby County                                TX          22,034          25,224
48421 Sherman County                               TX           2,858           3,186
48423 Smith County                                 TX         151,309         174,706
48425 Somervell County                             TX           5,360           6,809
48427 Starr County                                 TX          40,518          53,597
48429 Stephens County                              TX           9,010           9,674
48431 Sterling County                              TX           1,438           1,393
48433 Stonewall County                             TX           2,013           1,693
48435 Sutton County                                TX           4,135           4,077
48437 Swisher County                               TX           8,133           8,378
48439 Tarrant County                               TX       1,170,103       1,446,219
48441 Taylor County                                TX         119,655         126,555
48443 Terrell County                               TX           1,410           1,081
48445 Terry County                                 TX          13,218          12,761
48447 Throckmorton County                          TX           1,880           1,850
48449 Titus County                                 TX          24,009          28,118
48451 Tom Green County                             TX          98,458         104,010
48453 Travis County                                TX         576,407         812,280
48455 Trinity County                               TX          11,445          13,779
48457 Tyler County                                 TX          16,646          20,871
48459 Upshur County                                TX          31,370          35,291
48461 Upton County                                 TX           4,447           3,404
48463 Uvalde County                                TX          23,340          25,926
48465 Val Verde County                             TX          38,721          44,856
48467 Van Zandt County                             TX          37,944          48,140
48469 Victoria County                              TX          74,361          84,088
48471 Walker County                                TX          50,917          61,758
48473 Waller County                                TX          23,390          32,663
48475 Ward County                                  TX          13,115          10,909
48477 Washington County                            TX          26,154          30,373
48479 Webb County                                  TX         133,239         193,117
48481 Wharton County                               TX          39,955          41,188
48483 Wheeler County                               TX           5,879           5,284
48485 Wichita County                               TX         122,378         131,664
48487 Wilbarger County                             TX          15,121          14,676
48489 Willacy County                               TX          17,705          20,082
48491 Williamson County                            TX         139,551         249,967
48493 Wilson County                                TX          22,650          32,408
48495 Winkler County                               TX           8,626           7,173
48497 Wise County                                  TX          34,679          48,793
48499 Wood County                                  TX          29,380          36,752
48501 Yoakum County                                TX           8,786           7,322
48503 Young County                                 TX          18,126          17,943
48505 Zapata County                                TX           9,279          12,182
48507 Zavala County                                TX          12,162          11,600
49001 Beaver County                                UT           4,765           6,005
49003 Box Elder County                             UT          36,485          42,745
49005 Cache County                                 UT          70,183          91,391
49007 Carbon County                                UT          20,228          20,422
49009 Daggett County                               UT             690             921
49011 Davis County                                 UT         187,941         238,994
49013 Duchesne County                              UT          12,645          14,371
49015 Emery County                                 UT          10,332          10,860
49017 Garfield County                              UT           3,980           4,735
49019 Grand County                                 UT           6,620           8,485
49021 Iron County                                  UT          20,789          33,779
49023 Juab County                                  UT           5,817           8,238
49025 Kane County                                  UT           5,169           6,046
49027 Millard County                               UT          11,333          12,405
49029 Morgan County                                UT           5,528           7,129
49031 Piute County                                 UT           1,277           1,435
49033 Rich County                                  UT           1,725           1,961
49035 Salt Lake County                             UT         725,956         898,387
49037 San Juan County                              UT          12,621          14,413
49039 Sanpete County                               UT          16,259          22,763
49041 Sevier County                                UT          15,431          18,842
49043 Summit County                                UT          15,518          29,736
49045 Tooele County                                UT          26,601          40,735
49047 Uintah County                                UT          22,211          25,224
49049 Utah County                                  UT         263,590         368,536
49051 Wasatch County                               UT          10,089          15,215
49053 Washington County                            UT          48,560          90,354
49055 Wayne County                                 UT           2,177           2,509
49057 Weber County                                 UT         158,330         196,533
50001 Addison County                               VT          32,953          35,974
50003 Bennington County                            VT          35,845          36,994
50005 Caledonia County                             VT          27,846          29,702
50007 Chittenden County                            VT         131,761         146,571
50009 Essex County                                 VT           6,405           6,459
50011 Franklin County                              VT          39,980          45,417
50013 Grand Isle County                            VT           5,318           6,901
50015 Lamoille County                              VT          19,735          23,233
50017 Orange County                                VT          26,149          28,226
50019 Orleans County                               VT          24,053          26,277
50021 Rutland County                               VT          62,142          63,400
50023 Washington County                            VT          54,928          58,039
50025 Windham County                               VT          41,588          44,216
50027 Windsor County                               VT          54,055          57,418
51001 Accomack County                              VA          31,703          38,305
51003 Albemarle County                             VA          68,040          79,236
51005 Alleghany County                             VA          13,176          12,926
51007 Amelia County                                VA           8,787          11,400
51009 Amherst County                               VA          28,578          31,894
51011 Appomattox County                            VA          12,298          13,705
51013 Arlington County                             VA         170,936         189,453
51015 Augusta County                               VA          54,677          65,615
51017 Bath County                                  VA           4,799           5,048
51019 Bedford County                               VA          45,656          60,371
51021 Bland County                                 VA           6,514           6,871
51023 Botetourt County                             VA          24,992          30,496
51025 Brunswick County                             VA          15,987          18,419
51027 Buchanan County                              VA          31,333          26,978
51029 Buckingham County                            VA          12,873          15,623
51031 Campbell County                              VA          47,572          51,078
51033 Caroline County                              VA          19,217          22,121
51035 Carroll County                               VA          26,594          29,245
51036 Charles City County                          VA           6,282           6,926
51037 Charlotte County                             VA          11,688          12,472
51041 Chesterfield County                          VA         209,274         259,903
51043 Clarke County                                VA          12,101          12,652
51045 Craig County                                 VA           4,372           5,091
51047 Culpeper County                              VA          27,791          34,262
51049 Cumberland County                            VA           7,825           9,017
51051 Dickenson County                             VA          17,620          16,395
51053 Dinwiddie County                             VA          20,960          24,533
51057 Essex County                                 VA           8,689           9,989
51059 Fairfax County                               VA         818,584         969,749
51061 Fauquier County                              VA          48,741          55,139
51063 Floyd County                                 VA          12,005          13,874
51065 Fluvanna County                              VA          12,429          20,047
51067 Franklin County                              VA          39,549          47,286
51069 Frederick County                             VA          45,723          59,209
51071 Giles County                                 VA          16,366          16,657
51073 Gloucester County                            VA          30,131          34,780
51075 Goochland County                             VA          14,163          16,863
51077 Grayson County                               VA          16,278          17,917
51079 Greene County                                VA          10,297          15,244
51081 Greensville County                           VA           8,853          11,560
51083 Halifax County                               VA          29,033          37,355
51085 Hanover County                               VA          63,306          86,320
51087 Henrico County                               VA         217,881         262,300
51089 Henry County                                 VA          56,942          57,930
51091 Highland County                              VA           2,635           2,536
51093 Isle of Wight County                         VA          25,053          29,728
51095 James City County                            VA          34,859          48,102
51097 King and Queen County                        VA           6,289           6,630
51099 King George County                           VA          13,527          16,803
51101 King William County                          VA          10,913          13,146
51103 Lancaster County                             VA          10,896          11,567
51105 Lee County                                   VA          24,496          23,589
51107 Loudoun County                               VA          86,129         169,599
51109 Louisa County                                VA          20,325          25,627
51111 Lunenburg County                             VA          11,419          13,146
51113 Madison County                               VA          11,949          12,520
51115 Mathews County                               VA           8,348           9,207
51117 Mecklenburg County                           VA          29,241          32,380
51119 Middlesex County                             VA           8,653           9,932
51121 Montgomery County                            VA          73,913          83,629
51125 Nelson County                                VA          12,778          14,445
51127 New Kent County                              VA          10,445          13,462
51131 Northampton County                           VA          13,061          13,093
51133 Northumberland County                        VA          10,524          12,259
51135 Nottoway County                              VA          14,993          15,725
51137 Orange County                                VA          21,421          25,881
51139 Page County                                  VA          21,690          23,177
51141 Patrick County                               VA          17,473          19,407
51143 Pittsylvania County                          VA          55,655          61,745
51145 Powhatan County                              VA          15,328          22,377
51147 Prince Edward County                         VA          17,320          19,720
51149 Prince George County                         VA          27,394          33,047
51153 Prince William County                        VA         215,686         280,813
51155 Pulaski County                               VA          34,496          35,127
51157 Rappahannock County                          VA           6,622           6,983
51159 Richmond County                              VA           7,273           8,809
51161 Roanoke County                               VA          79,332          85,778
51163 Rockbridge County                            VA          18,350          20,808
51165 Rockingham County                            VA          57,482          67,725
51167 Russell County                               VA          28,667          30,308
51169 Scott County                                 VA          23,204          23,403
51171 Shenandoah County                            VA          31,636          35,075
51173 Smyth County                                 VA          32,370          33,081
51175 Southampton County                           VA          17,550          17,482
51177 Spotsylvania County                          VA          57,403          90,395
51179 Stafford County                              VA          61,236          92,446
51181 Surry County                                 VA           6,145           6,829
51183 Sussex County                                VA          10,248          12,504
51185 Tazewell County                              VA          45,960          44,598
51187 Warren County                                VA          26,142          31,584
51191 Washington County                            VA          45,887          51,103
51193 Westmoreland County                          VA          15,480          16,718
51195 Wise County                                  VA          39,573          40,123
51197 Wythe County                                 VA          25,466          27,599
51199 York County                                  VA          42,422          56,297
51510 Alexandria city                              VA         111,183         128,283
51515 Bedford city                                 VA           6,073           6,299
51520 Bristol city                                 VA          18,426          17,367
51530 Buena Vista city                             VA           6,406           6,349
51540 Charlottesville city                         VA          40,341          45,049
51550 Chesapeake city                              VA         151,976         199,184
51560 Clifton Forge city                           VA           4,679           4,289
51570 Colonial Heights city                        VA          16,064          16,897
51580 Covington city                               VA           6,991           6,303
51590 Danville city                                VA          53,056          48,411
51595 Emporia city                                 VA           5,306           5,665
51600 Fairfax city                                 VA          19,622          21,498
51610 Falls Church city                            VA           9,578          10,377
51620 Franklin city                                VA           7,864           8,346
51630 Fredericksburg city                          VA          19,027          19,279
51640 Galax city                                   VA           6,670           6,837
51650 Hampton city                                 VA         133,793         146,437
51660 Harrisonburg city                            VA          30,707          40,468
51670 Hopewell city                                VA          23,101          22,354
51678 Lexington city                               VA           6,959           6,867
51680 Lynchburg city                               VA          66,049          65,269
51683 Manassas city                                VA          27,957          35,135
51685 Manassas Park city                           VA           6,734          10,290
51690 Martinsville city                            VA          16,162          15,416
51700 Newport News city                            VA         170,045         180,150
51710 Norfolk city                                 VA         261,229         234,403
51720 Norton city                                  VA           4,247           3,904
51730 Petersburg city                              VA          38,386          33,740
51735 Poquoson city                                VA          11,005          11,566
51740 Portsmouth city                              VA         103,907         100,565
51750 Radford city                                 VA          15,940          15,859
51760 Richmond city                                VA         203,056         197,790
51770 Roanoke city                                 VA          96,397          94,911
51775 Salem city                                   VA          23,756          24,747
51790 Staunton city                                VA          24,461          23,853
51800 Suffolk city                                 VA          52,141          63,677
51810 Virginia Beach city                          VA         393,069         425,257
51820 Waynesboro city                              VA          18,549          19,520
51830 Williamsburg city                            VA          11,530          11,998
51840 Winchester city                              VA          21,947          23,585
53001 Adams County                                 WA          13,603          16,428
53003 Asotin County                                WA          17,605          20,551
53005 Benton County                                WA         112,560         142,475
53007 Chelan County                                WA          52,250          66,616
53009 Clallam County                               WA          56,464          64,525
53011 Clark County                                 WA         238,053         345,238
53013 Columbia County                              WA           4,024           4,064
53015 Cowlitz County                               WA          82,119          92,948
53017 Douglas County                               WA          26,205          32,603
53019 Ferry County                                 WA           6,295           7,260
53021 Franklin County                              WA          37,473          49,347
53023 Garfield County                              WA           2,248           2,397
53025 Grant County                                 WA          54,758          74,698
53027 Grays Harbor County                          WA          64,175          67,194
53029 Island County                                WA          60,195          71,558
53031 Jefferson County                             WA          20,146          25,953
53033 King County                                  WA       1,507,319       1,737,034
53035 Kitsap County                                WA         189,731         231,969
53037 Kittitas County                              WA          26,725          33,362
53039 Klickitat County                             WA          16,616          19,161
53041 Lewis County                                 WA          59,358          68,600
53043 Lincoln County                               WA           8,864          10,184
53045 Mason County                                 WA          38,341          49,405
53047 Okanogan County                              WA          33,350          39,564
53049 Pacific County                               WA          18,882          20,984
53051 Pend Oreille County                          WA           8,915          11,732
53053 Pierce County                                WA         586,203         700,820
53055 San Juan County                              WA          10,035          14,077
53057 Skagit County                                WA          79,555         102,979
53059 Skamania County                              WA           8,289           9,872
53061 Snohomish County                             WA         465,642         606,024
53063 Spokane County                               WA         361,364         417,939
53065 Stevens County                               WA          30,948          40,066
53067 Thurston County                              WA         161,238         207,355
53069 Wahkiakum County                             WA           3,327           3,824
53071 Walla Walla County                           WA          48,439          55,180
53073 Whatcom County                               WA         127,780         166,814
53075 Whitman County                               WA          38,775          40,740
53077 Yakima County                                WA         188,823         222,581
54001 Barbour County                               WV          15,699          15,557
54003 Berkeley County                              WV          59,253          75,905
54005 Boone County                                 WV          25,870          25,535
54007 Braxton County                               WV          12,998          14,702
54009 Brooke County                                WV          26,992          25,447
54011 Cabell County                                WV          96,827          96,784
54013 Calhoun County                               WV           7,885           7,582
54015 Clay County                                  WV           9,983          10,330
54017 Doddridge County                             WV           6,994           7,403
54019 Fayette County                               WV          47,952          47,579
54021 Gilmer County                                WV           7,669           7,160
54023 Grant County                                 WV          10,428          11,299
54025 Greenbrier County                            WV          34,693          34,453
54027 Hampshire County                             WV          16,498          20,203
54029 Hancock County                               WV          35,233          32,667
54031 Hardy County                                 WV          10,977          12,669
54033 Harrison County                              WV          69,371          68,652
54035 Jackson County                               WV          25,938          28,000
54037 Jefferson County                             WV          35,926          42,190
54039 Kanawha County                               WV         207,619         200,073
54041 Lewis County                                 WV          17,223          16,919
54043 Lincoln County                               WV          21,382          22,108
54045 Logan County                                 WV          43,032          37,710
54047 McDowell County                              WV          35,233          27,329
54049 Marion County                                WV          57,249          56,598
54051 Marshall County                              WV          37,356          35,519
54053 Mason County                                 WV          25,178          25,957
54055 Mercer County                                WV          64,980          62,980
54057 Mineral County                               WV          26,697          27,078
54059 Mingo County                                 WV          33,739          28,253
54061 Monongalia County                            WV          75,509          81,866
54063 Monroe County                                WV          12,406          14,583
54065 Morgan County                                WV          12,128          14,943
54067 Nicholas County                              WV          26,775          26,562
54069 Ohio County                                  WV          50,871          47,427
54071 Pendleton County                             WV           8,054           8,196
54073 Pleasants County                             WV           7,546           7,514
54075 Pocahontas County                            WV           9,008           9,131
54077 Preston County                               WV          29,037          29,334
54079 Putnam County                                WV          42,835          51,589
54081 Raleigh County                               WV          76,819          79,220
54083 Randolph County                              WV          27,803          28,262
54085 Ritchie County                               WV          10,233          10,343
54087 Roane County                                 WV          15,120          15,446
54089 Summers County                               WV          14,204          12,999
54091 Taylor County                                WV          15,144          16,089
54093 Tucker County                                WV           7,728           7,321
54095 Tyler County                                 WV           9,796           9,592
54097 Upshur County                                WV          22,867          23,404
54099 Wayne County                                 WV          41,636          42,903
54101 Webster County                               WV          10,729           9,719
54103 Wetzel County                                WV          19,258          17,693
54105 Wirt County                                  WV           5,192           5,873
54107 Wood County                                  WV          86,915          87,986
54109 Wyoming County                               WV          28,990          25,708
55001 Adams County                                 WI          15,682          18,643
55003 Ashland County                               WI          16,307          16,866
55005 Barron County                                WI          40,750          44,963
55007 Bayfield County                              WI          14,008          15,013
55009 Brown County                                 WI         194,594         226,778
55011 Buffalo County                               WI          13,584          13,804
55013 Burnett County                               WI          13,084          15,674
55015 Calumet County                               WI          34,291          40,631
55017 Chippewa County                              WI          52,360          55,195
55019 Clark County                                 WI          31,647          33,557
55021 Columbia County                              WI          45,088          52,468
55023 Crawford County                              WI          15,940          17,243
55025 Dane County                                  WI         367,085         426,526
55027 Dodge County                                 WI          76,559          85,897
55029 Door County                                  WI          25,690          27,961
55031 Douglas County                               WI          41,758          43,287
55033 Dunn County                                  WI          35,909          39,858
55035 Eau Claire County                            WI          85,183          93,142
55037 Florence County                              WI           4,590           5,088
55039 Fond du Lac County                           WI          90,083          97,296
55041 Forest County                                WI           8,776          10,024
55043 Grant County                                 WI          49,264          49,597
55045 Green County                                 WI          30,339          33,647
55047 Green Lake County                            WI          18,651          19,105
55049 Iowa County                                  WI          20,150          22,780
55051 Iron County                                  WI           6,153           6,861
55053 Jackson County                               WI          16,588          19,100
55055 Jefferson County                             WI          67,783          74,021
55057 Juneau County                                WI          21,650          24,316
55059 Kenosha County                               WI         128,181         149,577
55061 Kewaunee County                              WI          18,878          20,187
55063 La Crosse County                             WI          97,904         107,120
55065 Lafayette County                             WI          16,076          16,137
55067 Langlade County                              WI          19,505          20,740
55069 Lincoln County                               WI          26,993          29,641
55071 Manitowoc County                             WI          80,421          82,887
55073 Marathon County                              WI         115,400         125,834
55075 Marinette County                             WI          40,548          43,384
55077 Marquette County                             WI          12,321          15,832
55078 Menominee County                             WI           3,890           4,562
55079 Milwaukee County                             WI         959,275         940,164
55081 Monroe County                                WI          36,633          40,899
55083 Oconto County                                WI          30,226          35,634
55085 Oneida County                                WI          31,679          36,776
55087 Outagamie County                             WI         140,510         160,971
55089 Ozaukee County                               WI          72,831          82,317
55091 Pepin County                                 WI           7,107           7,213
55093 Pierce County                                WI          32,765          36,804
55095 Polk County                                  WI          34,773          41,319
55097 Portage County                               WI          61,405          67,182
55099 Price County                                 WI          15,600          15,822
55101 Racine County                                WI         175,034         188,831
55103 Richland County                              WI          17,521          17,924
55105 Rock County                                  WI         139,510         152,307
55107 Rusk County                                  WI          15,079          15,347
55109 St. Croix County                             WI          50,251          63,155
55111 Sauk County                                  WI          46,975          55,225
55113 Sawyer County                                WI          14,181          16,196
55115 Shawano County                               WI          37,157          40,664
55117 Sheboygan County                             WI         103,877         112,646
55119 Taylor County                                WI          18,901          19,680
55121 Trempealeau County                           WI          25,263          27,010
55123 Vernon County                                WI          25,617          28,056
55125 Vilas County                                 WI          17,707          21,033
55127 Walworth County                              WI          75,000          93,759
55129 Washburn County                              WI          13,772          16,036
55131 Washington County                            WI          95,328         117,493
55133 Waukesha County                              WI         304,715         360,767
55135 Waupaca County                               WI          46,104          51,731
55137 Waushara County                              WI          19,385          23,154
55139 Winnebago County                             WI         140,320         156,763
55141 Wood County                                  WI          73,605          75,555
56001 Albany County                                WY          30,797          32,014
56003 Big Horn County                              WY          10,525          11,461
56005 Campbell County                              WY          29,370          33,698
56007 Carbon County                                WY          16,659          15,639
56009 Converse County                              WY          11,128          12,052
56011 Crook County                                 WY           5,294           5,887
56013 Fremont County                               WY          33,662          35,804
56015 Goshen County                                WY          12,373          12,538
56017 Hot Springs County                           WY           4,809           4,882
56019 Johnson County                               WY           6,145           7,075
56021 Laramie County                               WY          73,142          81,607
56023 Lincoln County                               WY          12,625          14,573
56025 Natrona County                               WY          61,226          66,533
56027 Niobrara County                              WY           2,499           2,407
56029 Park County                                  WY          23,178          25,786
56031 Platte County                                WY           8,145           8,807
56033 Sheridan County                              WY          23,562          26,560
56035 Sublette County                              WY           4,843           5,920
56037 Sweetwater County                            WY          38,823          37,613
56039 Teton County                                 WY          11,172          18,251
56041 Uinta County                                 WY          18,705          19,742
56043 Washakie County                              WY           8,388           8,289
56045 Weston County                                WY           6,518           6,644
;
run;
/*-------------------------------------------------------------------*/


/* APPENDIX 1.3 -----------------------------------------------------*/

data nys2000co;
informat pop2000 comma.;
input county pop2000 @@;
label
county  = 'County FIPS Code'
pop2000 = 'Year 2000 Census Population'
;
datalines;
001    294,565     003     49,927   005  1,332,650     007    200,536
009     83,955     011     81,963   013    139,750     015     91,070
017     51,401     019     79,894   021     63,094     023     48,599
025     48,055     027    280,150   029    950,265     031     38,851
033     51,134     035     55,073   037     60,370     039     48,195
041      5,379     043     64,427   045    111,738     047  2,465,326
049     26,944     051     64,328   053     69,441     055    735,343
057     49,708     059  1,334,544   061  1,537,195     063    219,846
065    235,469     067    458,336   069    100,224     071    341,367
073     44,171     075    122,377   077     61,676     079     95,745
081  2,229,379     083    152,538   085    443,728     087    286,753
089    111,931     091    200,635   093    146,555     095     31,582
097     19,224     099     33,342   101     98,726     103  1,419,369
105     73,966     107     51,784   109     96,501     111    177,749
113     63,303     115     61,042   117     93,765     119    923,459
121     43,424     123     24,621
;
run;
/*-------------------------------------------------------------------*/


/* APPENDIX 1.4 -----------------------------------------------------*/

data tx2000co;
   informat pop2000 comma.;
   input county pop2000 @@;
   label
   county  = 'County FIPS Code'
   pop2000 = 'Year 2000 Census Population'
   ;
datalines;
001     55,109   003     13,004    005     80,130   007     22,497
009      8,854   011      2,148    013     38,628   015     23,590
017      6,594   019     17,645    021     57,733   023      4,093
025     32,359   027    237,974    029  1,392,931   031      8,418
033        729   035     17,204    037     89,306   039    241,767
041    152,415   043      8,866    045      1,790   047      7,976
049     37,674   051     16,470    053     34,147   055     32,194
057     20,647   059     12,905    061    335,227   063     11,549
065      6,516   067     30,438    069      8,285   071     26,031
073     46,659   075      7,688    077     11,006   079      3,730
081      3,864   083      9,235    085    491,675   087      3,206
089     20,390   091     78,021    093     14,026   095      3,966
097     36,363   099     74,978    101      1,904   103      3,996
105      4,099   107      7,072    109      2,975   111      6,222
113  2,218,899   115     14,985    117     18,561   119      5,327
121    432,976   123     20,013    125      2,762   127     10,248
129      3,828   131     13,120    133     18,297   135    121,123
137      2,162   139    111,360    141    679,622   143     33,001
145     18,576   147     31,242    149     21,804   151      4,344
153      7,771   155      1,622    157    354,452   159      9,458
161     17,867   163     16,252    165     14,467   167    250,158
169      4,872   171     20,814    173      1,406   175      6,928
177     18,628   179     22,744    181    110,595   183    111,379
185     23,552   187     89,023    189     36,602   191      3,782
193      8,229   195      5,369    197      4,724   199     48,073
201  3,400,578   203     62,110    205      5,537   207      6,093
209     97,589   211      3,351    213     73,277   215    569,463
217     32,321   219     22,716    221     41,100   223     31,960
225     23,185   227     33,627    229      3,344   231     76,596
233     23,857   235      1,771    237      8,763   239     14,391
241     35,604   243      2,207    245    252,051   247      5,281
249     39,326   251    126,811    253     20,785   255     15,446
257     71,313   259     23,743    261        414   263        859
265     43,653   267      4,468    269        356   271      3,379
273     31,549   275      4,253    277     48,499   279     14,709
281     17,762   283      5,866    285     19,210   287     15,657
289     15,335   291     70,154    293     22,051   295      3,057
297     12,309   299     17,044    301         67   303    242,628
305      6,550   307      8,205    309    213,517   311        851
313     12,940   315     10,941    317      4,746   319      3,738
321     37,957   323     47,297    325     39,304   327      2,360
329    116,009   331     24,238    333      5,151   335      9,698
337     19,117   339    293,768    341     20,121   343     13,048
345      1,426   347     59,203    349     45,124   351     15,072
353     15,802   355    313,645    357      9,006   359      2,185
361     84,966   363     27,026    365     22,756   367     88,495
369     10,016   371     16,809    373     41,133   375    113,546
377      7,304   379      9,139    381    104,312   383      3,326
385      3,047   387     14,314    389     13,137   391      7,828
393        887   395     16,000    397     43,080   399     11,495
401     47,372   403     10,469    405      8,946   407     22,246
409     67,138   411      6,186    413      2,935   415     16,361
417      3,302   419     25,224    421      3,186   423    174,706
425      6,809   427     53,597    429      9,674   431      1,393
433      1,693   435      4,077    437      8,378   439  1,446,219
441    126,555   443      1,081    445     12,761   447      1,850
449     28,118   451    104,010    453    812,280   455     13,779
457     20,871   459     35,291    461      3,404   463     25,926
465     44,856   467     48,140    469     84,088   471     61,758
473     32,663   475     10,909    477     30,373   479    193,117
481     41,188   483      5,284    485    131,664   487     14,676
489     20,082   491    249,967    493     32,408   495      7,173
497     48,793   499     36,752    501      7,322   503     17,943
505     12,182   507     11,600
;
run;
/*-------------------------------------------------------------------*/


/*-------------------------------------------------------------------*/
/*--------------------------APPENDIX B-------------------------------*/
/*-------------------------------------------------------------------*/


data fip_func;
do fips_code = 1 to 95;
   postal = fipstate(fips_code);
   name_u = fipname(fips_code);
   name_m = fipnamel(fips_code);
   if name_u ne : 'INVALID' then output;
end;
label
fips_code = "FIPS CODE"
postal    = 'POSTAL CODE'
name_u    = 'UPPERCASE NAME'
name_m    = 'MIXED CASE NAME'
;
run;

title 'FIPS CODES, POSTAL CODES, NAMES';
proc print data=fip_func noobs label;
run;

data st_func;
do fips = 1 to 79;
   postal    = fipstate(fips);
   if postal ne '--' then do;
     fips_code = stfips(postal);
     sname_u   = stname(postal);
     sname_m   = stnamel(postal);
   output;
   end;
end;
label
fips_code = "FIPS CODE"
postal    = 'TWO-CHARACTER POSTAL CODE'
sname_u   = 'UPPER CASE NAME'
sname_m   = 'MIXED CASE NAME'
;
drop fips;
run;

title 'ST_FUNCTIONS';
proc print data=st_func noobs label;
run;

title;
/*-------------------------------------------------------------------*/


/*-------------------------------------------------------------------*/
/*--------------------------APPENDIX D-------------------------------*/
/*-------------------------------------------------------------------*/


data font;
do i=0 to 100;
   char=input(put(i,hex2.),$2.);

   segment=1;
   lp='p';
   x=0;   y=0;   output;
          y=i;   output;
   x=50;         output;
          y=0;   output;
   x=0;          output;

   segment=2;
   lp='l';
   x=0;   y=0;   output;
          y=100; output;
   x=50;         output;
          y=0;   output;
   x=0;          output;

   segment=3;
   x=0;   y=50;  output;
   x=-10;        output;

   segment=4;
   x=60;  y=50;  output;
   x=50;         output;
end;
run;

libname gfont0 'i:\';

title 'THE GAUGE FONT';

proc gfont data=font name=gauge filled nokeymap codelen=2 height=3.5;
run;

title;
/*-------------------------------------------------------------------*/


/*-------------------------------------------------------------------*/
/*--------------------------APPENDIX E-------------------------------*/
/*-------------------------------------------------------------------*/


* MAP - NAME OF MAP DATA SET
* TYPE - VARIABLE THAT IDENTIFIES GEOGRAPHIC AREAS IN MAP (E.G. COUNTY)
* CREATES DATA SET CENTERS;

%macro centroid(map,type);
* CREATE TWO DATA SETS - NUMBER OF POINTS PER AREA AND POINTS;
data
   map(drop=npoints)
   points(keep=x y npoints rename=(x=xlast y=ylast));
   set &map; by &type;
   where x ne .;
   output map;
   npoints+1;
   if last.&type then do;
      output points;
      npoints=0;
   end;
run;

* CALCULATE CENTROIDS;
data
   centers(keep=&type x y rename=(x=xc y=yc));
   retain savptr 1 xold yold 0;
   set points;
   xcg=0; ycg=0;
   aresum=0;
   firstpnt=1;
   endptr=savptr + npoints - 1;
   do ptrm=savptr to endptr;
      set map point=ptrm nobs=nobsm;
      if firstpnt then do;
         xold=x; yold=y;
         savptr=ptrm + npoints;
         firstpnt=0;
      end;
      aretri=((xlast-x)*(yold-ylast)) + ((xold-xlast)*(y-ylast));
      xcg + (aretri*(x+xold));
      ycg + (aretri*(y+yold));
      aresum+aretri;
      xold=x; yold=y;
   end;
   areinv=1.0/aresum;
   x=(((xcg*areinv)+xlast) * (1/3));
   y=(((ycg*areinv)+ylast) * (1/3));
   output;
run;
%mend;

%centroid(maps.states,state);
/*-------------------------------------------------------------------*/


/*-------------------------------------------------------------------*/
/*--------------------------APPENDIX F-------------------------------*/
/*-------------------------------------------------------------------*/


/* GRAY SCALE FILLS -------------------------------------------------*/

goptions reset=all;
goptions ftext=swissb htext=2 gunit=pct;

* uses the catalog file method to store pattern statements for later
* inclusion in job;

filename tempfile catalog "work.includes.temppatt";

* creates a map (squares) and a data set (temp) to be used in creating
* pattern statements and annotation;

data squares (keep=sq x y)
temp (keep=sq x y);
retain sq 0;
do j = 1 to 16;
do i = 1 to 16;
sq+1;
x=i; y=j; output;
x=i+1; output squares;
y=j+1; output squares;
x=i; output squares;
end;
end;
run;

* eliminate lower-left (white) and upper-right (black) map areas;
data squares;
set squares;
if _n_ gt 4 and _n_ lt 1021 then output;
run;

* create patterns and annotation;

data labels (drop=xy txt);
retain xsys ysys '2' when 'a';
file tempfile;
set temp;
sq = sq - 1;
if 1<=sq<=254;
if x gt 5 then color = 'grayfe';
else color = 'gray01';
xy = put(16-x,hex1.) || put(16-y,hex1.);
txt = "pattern" || left(trim(put(sq,3.))) || " v=s c=gray" || xy || ";";
put txt;
text=put(xy,2.);
x=x+.5;
y=y+.5;
run;

* include the pattern statements;

%include tempfile;

* create a map with 254 gray-filled areas;

title h=4 "GRAY SCALE FILLS";

proc gmap map=squares data=squares;
id sq;
choro sq/discrete nolegend coutline=gray01 annotate=labels;
run;
quit;

title;
/*-------------------------------------------------------------------*/

/* CONTINUOUS SHADING -----------------------------------------------*/

goptions reset=all;
goptions ftext='Arial' gunit=pct;

* set staring values for RED, GREEN, BLUE;
%let r=220;
%let g=220;
%let b=220;

data color100;
retain xsys ysys '3' style 's' xinc 1;
r = &r; rinc = -r/100;
g = &g; ginc = -g/100;
b = &b; binc = -b/100;
x = 0;
do i = .5 to 99.5;
color = 'cx' || put( r, hex2. ) || put( g, hex2. ) || put( b, hex2. );
function = 'MOVE'; y = 10; output;
function = 'BAR' ; x + xinc; y = 90; output;
r + rinc;
g + ginc;
b + binc;
end;
run;

title h=4 "STARTING VALUE: R=&r G=&g B=&b";
proc gslide annotate=color100;
run;
quit;

title;
/*-------------------------------------------------------------------*/


/*-------------------------------------------------------------------*/
/*--------------------------APPENDIX G-------------------------------*/
/*-------------------------------------------------------------------*/


data mapdatasets;
set maps.metamaps;
array var(13);
map = 0;
do j=1 to 13;
   if var(j) eq 'SEGMENT' then map = 1;
   if map eq 1 then leave;
end;

if map eq 1 then output;
run;

*** print the first 10 names;

proc print data=mapdatasets (obs=10) noobs;
var memname var1-var7;
run;

proc print data=maps.austria2;
run;

proc contents data=maps.uscenter;
run;

proc freq data=maps.uscity;
table featype / nopercent nocum;
run;
/*-------------------------------------------------------------------*/







/*****************************PART TWO********************************/

/*-------------------------------------------------------------------*/
/*----------------------------CHAPTER #1-----------------------------*/
/*-------------------------------------------------------------------*/


/* CHAPTER #1...EXAMPLE #1 ------------------------------------------*/

goptions reset=all;
goptions gunit=pct ftext='Arial' htext=4 htitle=8;

proc format;
value pop
low     -< 1300000 = '<1.3'
1300000 -< 4000000 = '1.3-3.9'
4000000 -< 6000000 = '4.0-5.9'
6000000 -  high    = '6.0+'
;
run;

pattern1 v=ms c=grayfa;
pattern2 v=ms c=grayda;
pattern3 v=ms c=grayaa;
pattern4 v=ms c=gray5a;

legend1 shape=bar(3,4);

title 'YEAR 2000 CENSUS POPULATION';

proc gmap
map=maps.us
data=us2000st;
id state;
choro  pop2000 / discrete coutline=black legend=legend1;
label  pop2000 = 'MILLIONS';
format pop2000 pop.;
run;
quit;
/*-------------------------------------------------------------------*/

/* CHAPTER #1...EXAMPLE #2 ------------------------------------------*/

goptions reset=all;
goptions gunit=pct ftext='Arial' htext=4 htitle=8;

proc format;
value pop
low     -< 1300000 = '<1.3'     1300000 -< 4000000 = '1.3-3.9'
4000000 -< 6000000 = '4.0-5.9'  6000000 -  high    = '6.0+'
;
run;

pattern1 v=ms c=grayfa;
pattern2 v=ms c=grayda;
pattern3 v=ms c=grayaa;
pattern4 v=ms c=gray5a;

legend1 shape=bar(3,4);

title 'YEAR 2000 CENSUS POPULATION';

proc gmap
map=maps.us
data=us2000st
;
id state;
prism  pop2000 / discrete coutline=black legend=legend1;
label  pop2000 = 'MILLIONS';
format pop2000 pop.;
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #1...EXAMPLE #3 ------------------------------------------*/

goptions reset=all;
goptions gunit=pct ftext='Arial' htext=4 htitle=8;

proc format;
value pop
low     -< 1300000 = '<1.3'
1300000 -< 4000000 = '1.3-3.9'
4000000 -< 6000000 = '4.0-5.9'
6000000 -  high    = '6.0+'
;
run;

pattern1 v=ms c=grayfa;
pattern2 v=ms c=grayda;
pattern3 v=ms c=grayaa;
pattern4 v=ms c=gray5a;

legend1 shape=bar(3,4);

title 'YEAR 2000 CENSUS POPULATION';

proc gmap
map=maps.us
data=us2000st
;
id state;
prism  pop2000 / discrete coutline=black yview=-0.5 zview=4.0 ylight=2 legend=legend1;
label  pop2000 = 'MILLIONS';
format pop2000 pop.;
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #1...EXAMPLE #4 ------------------------------------------*/

goptions reset=all;
goptions gunit=pct ftext='Arial' htext=4 htitle=8;

proc format;
value pop
low     -< 1300000  = '<1.3'
1300000 -< 4000000 = '1.3-3.9'
4000000 -< 6000000 = '4.0-5.9'
6000000 -  high     = '6.0+'
;
run;

pattern1 v=s c=grayfa;
pattern2 v=s c=grayda;
pattern3 v=s c=grayaa;
pattern4 v=s c=gray5a;

legend1 shape=bar(3,4);

title 'YEAR 2000 CENSUS POPULATION';

proc gmap
map=maps.us
data=us2000st
;
id state;
block  pop2000 / discrete coutline=black cblkout=black legend=legend1;
label  pop2000 = 'MILLIONS';
format pop2000 pop.;
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #1...EXAMPLE #5 ------------------------------------------*/

goptions reset=all;
goptions gunit=pct ftext='Arial' htext=4 htitle=8;

proc format;
value pop
low     -< 1300000  = '<1.3'
1300000 -< 4000000 = '1.3-3.9'
4000000 -< 6000000 = '4.0-5.9'
6000000 -  high     = '6.0+'
;
run;

pattern1 v=s c=grayfa;
pattern2 v=s c=grayda;
pattern3 v=s c=grayaa;
pattern4 v=s c=gray5a;
pattern5 v=ms c=grayea;

legend1 shape=bar(3,4);

title 'YEAR 2000 CENSUS POPULATION';

proc gmap
map=maps.us
data=us2000st
;
id state;
block  pop2000 / discrete coutline=black cblkout=black blocksize=6 shape=prism
                 xview=0.75 yview=-1.0 zview=3.5 legend=legend1 ;
label  pop2000 = 'MILLIONS';
format pop2000 pop.;
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #1...EXAMPLE #6 ------------------------------------------*/

goptions reset=all;
goptions gunit=pct ftext='Arial' htext=4 htitle=8;

pattern1 v=s  c=gray8a r=51;
pattern2 v=ms c=grayea;

title 'YEAR 2000 CENSUS POPULATION';

proc gmap
map=maps.us
data=us2000st
;
id state;
block pop2000 / coutline=black nolegend levels=51
                blocksize=6 shape=cylinder;
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #1...EXAMPLE #7 ------------------------------------------*/

goptions reset=all;
goptions gunit=pct ftext='Arial' htext=4 htitle=8;

title 'YEAR 2000 CENSUS POPULATION';

proc gmap
map=maps.us
data=us2000st
;
id state;
surface pop2000;
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #1...EXAMPLE #8 ------------------------------------------*/

goptions reset=all;
goptions gunit=pct ftext='Arial' htext=4 htitle=8;

title 'YEAR 2000 CENSUS POPULATION';

proc gmap
map=maps.us
data=us2000st
;
id state;
surface pop2000 / rotate=110 tilt=60;
;
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #1...EXAMPLE #9 ------------------------------------------*/

goptions reset=all;
goptions gunit=pct ftext='Arial' htext=4 htitle=8;

title 'YEAR 2000 CENSUS POPULATION';

proc gmap
map=maps.us
data=us2000st
;
id state;
surface pop2000 / rotate=110 tilt=50 nlines=100 constant=20;
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #1...EXAMPLE #10 -----------------------------------------*/

goptions reset=all;
goptions gunit=pct ftext='Arial' htext=4 htitle=8;

data usa_mainland;
retain country 'USA';
set maps.us;
where state not in (2,15);
run;

proc gremove
data=usa_mainland
out=usa_outline
;
id state;
by country;
run;

pattern v=me c=black;

title h=6 'US MAP DATA SET - NO INTERNAL BOUNDARIES';

proc gmap
map=usa_outline
data=usa_outline
;
id country;
choro country / nolegend;
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #1...EXAMPLE #11 -----------------------------------------*/

goptions reset=all;
goptions gunit=pct ftext='Arial' htext=4 htitle=8;

proc format;
value pop
low     -< 1300000 = '<1.3'
1300000 -< 4000000 = '1.3-3.9'
4000000 -< 6000000 = '4.0-5.9'
6000000 -  high    = '6.0+'
;
run;

pattern1 v=ms c=grayfa;
pattern2 v=ms c=grayda;
pattern3 v=ms c=grayaa;
pattern4 v=ms c=gray5a;

legend1 shape=bar(3,4);

title 'YEAR 2000 CENSUS POPULATION';

proc gmap
map=maps.states
data=us2000st
;
id state;
choro  pop2000 / discrete coutline=black legend=legend1;
label  pop2000 = 'MILLIONS';
format pop2000 pop.;
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #1...EXAMPLE #12 -----------------------------------------*/

goptions reset=all;
goptions gunit=pct ftext='Arial' htext=4 htitle=8;

proc format;
value pop
low     -< 1300000 = '<1.3'
1300000 -< 4000000 = '1.3-3.9'
4000000 -< 6000000 = '4.0-5.9'
6000000 -  high    = '6.0+'
;
run;

proc gproject
data=maps.states
out=projected_states
;
id state;
run;

pattern1 v=ms c=grayfa; pattern2 v=ms c=grayda;
pattern3 v=ms c=grayaa; pattern4 v=ms c=gray5a;

legend1 shape=bar(3,4);

title 'YEAR 2000 CENSUS POPULATION';

proc gmap
map=projected_states
data=us2000st
;
id state;
choro  pop2000 / discrete coutline=black legend=legend1;
label  pop2000 = 'MILLIONS';
format pop2000 pop.;
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #1...EXAMPLE #13 -----------------------------------------*/

goptions reset=all;
goptions gunit=pct ftext='Arial' htext=4 htitle=8;

proc format;
value pop
low     -< 1300000  = '<1.3'
1300000 -< 4000000 = '1.3-3.9'
4000000 -< 6000000 = '4.0-5.9'
6000000 -  high     = '6.0+'
;
run;

proc gproject
data=maps.states
out=projected_states
;
where fipstate(state) not in ('AK','HI','PR');
id state;
run;

pattern1 v=ms c=grayfa;
pattern2 v=ms c=grayda;
pattern3 v=ms c=grayaa;
pattern4 v=ms c=gray5a;

legend1 shape=bar(3,4);

title 'YEAR 2000 CENSUS POPULATION';

proc gmap
map=projected_states
data=us2000st
;
id state;
choro  pop2000 / discrete coutline=black legend=legend1;
label  pop2000 = 'MILLIONS';
format pop2000 pop.;
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #1...EXAMPLE #14 -----------------------------------------*/

goptions reset=all;
goptions gunit=pct ftext='Arial' htext=4 htitle=8;

proc format;
value pop
low     -< 1300000  = '<1.3'
1300000 -< 4000000 = '1.3-3.9'
4000000 -< 6000000 = '4.0-5.9'
6000000 -  high     = '6.0+'
;
run;

proc gproject
data=maps.states
out=projected_states
;
where fipstate(state) not in ('AK','HI','PR') and density le 2;
id state;
run;

pattern1 v=ms c=grayfa;
pattern2 v=ms c=grayda;
pattern3 v=ms c=grayaa;
pattern4 v=ms c=gray5a;

legend1 shape=bar(3,4);

title 'YEAR 2000 CENSUS POPULATION';

proc gmap
map=projected_states
data=us2000st
;
id state;
choro  pop2000 / discrete coutline=black legend=legend1;
label  pop2000 = 'MILLIONS';
format pop2000 pop.;
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #1...EXAMPLE #15 -----------------------------------------*/

goptions reset=all;
goptions gunit=pct ftext='Arial' htext=4 htitle=8;

proc greduce data=maps.mexico out=mexico_dens;
id id;
run;

proc freq data=mexico_dens;
table density;
run;

pattern v=me c=black r=32;

title h=6 'MAP CREATED WITH MEXICO MAP DATA SET';

proc gmap
map=mexico_dens
data=mexico_dens
;
id id;
choro id / discrete nolegend;
where density le 4;
run;
quit;
/*-------------------------------------------------------------------*/


/*-------------------------------------------------------------------*/
/*----------------------------CHAPTER #2-----------------------------*/
/*-------------------------------------------------------------------*/


/* CHAPTER #2...EXAMPLE #1 ------------------------------------------*/

goptions reset=all;
goptions gunit=pct htext=8;

title1  font=swiss       'SWISS FONT';
title2  f=swissb         'SWISS BOLD FONT';
title3  f=swissi         'SWISS ITALIC FONT';
title4  f='Arial'        'ARIAL FONT';
title5  f='Arial/bo'     'ARIAL BOLD FONT';
title6  f='Arial/it'     'ARIAL ITALIC FONT';
title7  f='Arial Narrow' 'ARIAL NARROW';
title8;
title9  f='Arial' 'MARKER FONT: '   f=marker  'A B C D S U V';
title10 f='Arial' 'SPECIAL FONT:  ' f=special 'J K L M';

proc gslide;
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #2...EXAMPLE #2 ------------------------------------------*/

goptions reset=all;
goptions gunit=pct ftext='Arial';

title1  h=2  'TITLE1 H=2 PCT';
title2  h=4  'TITLE2 H=4 PCT';
title3  h=6  'TITLE3 H=6 PCT';
title4  h=8  'TITLE4 H=8 PCT';
title5  h=10 'TITLE5 H=10 PCT';
title6  h=12 'TITLE6 H=12 PCT';
title7  h=14 'TITLE7 H=14 PCT';
title8  h=16 'TITLE8 H=16 PCT';
title9  h=18 'TITLE9 H=18 PCT';

proc gslide;
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #2...EXAMPLE #3 ------------------------------------------*/

goptions reset=all;
goptions gunit=pct htext=5 htitle=8 ftext='Arial';

title1        'TITLE1 CENTERED (DEFAULT)';
title2    j=l 'TITLE2 LEFT-JUSTIFIED';
title3    j=r 'TITLE3 RIGHT-JUSTIFIED';
footnote1     'FOOTNOTE1 CENTERED (DEFAULT)';
footnote2 j=l 'FOOTNOTE2 LEFT-JUSTIFIED'
          j=r 'FOOTNOTE2 RIGHT-JUSTIFIED';


proc gslide;
note     'NOTE LEFT-JUSTIFIED (DEFAULT)'
     j=l 'NOTE LEFT-JUSTIFIED, NEW LINE CAUSED BY ANOTHER J=L'
     move=(7,50)   'NOTE STARTED USING ABSOLUTE MOVE=(7,50)'
     move=(7,-20)  'NOTE STARTED USING RELATIVE MOVE=(7,-20)'
     move=(-65,-10) 'NOTE STARTED USING RELATIVE MOVE=(-65,-10)';
note 'NEW NOTE STATEMENT';
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #2...EXAMPLE #4 ------------------------------------------*/

goptions reset=all;
goptions gunit=pct htext=5 ftext='Arial';

title1 angle=-10  'TITLE1 ANGLE=-10';
title2 angle=90   'TITLE2 ANGLE=90';
title3            'TITLE3 NO ANGLE SPECIFIED';
title4 angle=10   'TITLE4 ANGLE=10';
title5 angle=90;
title6 a=90 r=270 'TITLE6 A=90 R=270';
title7 angle=-90  'TITLE7 ANGLE=-90';
title8 angle=-90;
title9 a=-90 r=90 'TITLE9 A=90 R=90';

footnote1 angle=90   'FOOTNOTE1 ANGLE=90';
footnote2 angle=90;
footnote3 a=90 r=270 'FOOTNOTE3 A=90 R=270';
footnote4 angle=90;
footnote5 angle=-90  'FOOTNOTE5 ANGLE=-90';
footnote6 angle=-90;
footnote7 a=-90 r=90 'FOOTNOTE7 A=90 R=90';
footnote8 angle=-90;

proc gslide;
note angle=90 'NOTE ANGLE=90';
note angle=-90 'NOTE ANGLE=-90';
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #2...EXAMPLE #5 ------------------------------------------*/

goptions reset=all;
goptions ftext='Arial' htext=4 gunit=pct cpattern=black;

data hatching;
input area x y @@;
datalines;
1 0 0  1 1 0  1 1 1  1 0 1 3 1 0  3 2 0  3 2 1  3 1 1
5 0 1  5 1 1  5 1 2  5 0 2 7 1 1  7 2 1  7 2 2  7 1 2
2 2 0  2 3 0  2 3 1  2 2 1 4 3 0  4 4 0  4 4 1  4 3 1
6 2 1  6 3 1  6 3 2  6 2 2 8 3 1  8 4 1  8 4 2  8 3 2
;
run;

pattern1 v=m1n0; pattern2 v=m1n45; pattern3 v=m1x0; pattern4 v=m1x45;
pattern5 v=m3n0; pattern6 v=m3n45; pattern7 v=m3x0; pattern8 v=m3x45;

legend1 shape=bar(6,8);

proc gmap map=hatching data=hatching;
id area;
choro area / discrete legend=legend1;
label area='PATTERN #';
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #2...EXAMPLE #6 ------------------------------------------*/

goptions reset=all;
goptions gunit=pct ftext='Arial' htext=4 htitle=8;

%macro pattern;
%do j=1 %to 48;
   %let i=%eval(255 - 4*&j);
   %let g=%sysfunc(putn(&i,hex2.));
   pattern&j v=s c=gray&g;
%end;
%mend;

%pattern;

title1 'YEAR 2000 CENSUS POPULATION';
title2 '(DARKER AREAS HAVE HIGHER POPULATIONS)';

proc gmap
map=maps.us
data=us2000st
;
where fipstate(state) not in ('AK','HI','DC');
id state;
choro pop2000 / levels=48 coutline=white nolegend;
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #2...EXAMPLE #7 ------------------------------------------*/

goptions reset=all;
goptions gunit=pct ftext='Arial' htext=4 htitle=8;

pattern1 v=ms c=grayca;
pattern2 v=ms c=gray9a;
pattern3 v=ms c=gray6a;
pattern4 v=ms c=gray3a;

legend1 shape=bar(3,4);

title 'US CENSUS BUREAU REGIONS';

proc gmap
map=maps.us
data=us2000st
;
id state;
choro region / midpoints='NORTHEAST' 'SOUTH' 'MIDWEST' 'WEST' coutline=white
               legend=legend1;
label region = 'REGION';
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #2...EXAMPLE #8 ------------------------------------------*/

goptions reset=all;
goptions gunit=pct ftext='Arial' htext=4 htitle=8;

pattern1 v=ms c=grayca;
pattern2 v=ms c=gray9a;
pattern3 v=ms c=gray6a;
pattern4 v=ms c=gray3a;

legend1
shape=bar(3,4)
position=(top)
label=none
value=(font='Arial/it')
frame
fwidth=3
cshadow=gray9a
;

title 'US CENSUS BUREAU REGIONS';

proc gmap
map=maps.us
data=us2000st
;
id state;
choro region / midpoints='NORTHEAST' 'SOUTH' 'MIDWEST' 'WEST'
               coutline=white legend=legend1;
run;
quit;
/*-------------------------------------------------------------------*/


/*-------------------------------------------------------------------*/
/*----------------------------CHAPTER #3-----------------------------*/
/*-------------------------------------------------------------------*/


/* CHAPTER #3...EXAMPLE #1 ------------------------------------------*/

goptions reset=all;

pattern1 v=me c=black;

proc gproject data=maps.states out=projected_states;
where fipstate(state) in ('ME','NH','VT','MA','RI','CT','NY');
id state;
run;

proc gmap map=projected_states data=projected_states (obs=1) all;
id state;
choro state / cempty=black nolegend;
note h=8 pct f='Arial/bo/it'
    'OUTLINE MAP' j=l 'OF NORTHEAST' j=l 'UNITED STATES';
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #3...EXAMPLE #2 ------------------------------------------*/

goptions reset=all;

* create a format ($STADIV) - used to assign states to census divisions;

proc format;
value $sta2div
'CT','ME','MA','NH','RI','VT'                 = 'NORTHEAST'
'NJ','NY','PA'                                = 'MID-ATLANTIC'
'IL','IN','MI','OH','WI'                      = 'EAST-NORTH-CENTRAL'
'IA','KS','MN','MO','NE','ND','SD'            = 'WEST-NORTH-CENTRAL'
'DE','DC','FL','GA','MD','NC','SC','VA','WV'  = 'SOUTH ATLANTIC'
'AL','KY','MS','TN'                           = 'EAST-SOUTH-CENTRAL'
'AR','LA','OK','TX'                           = 'WEST-SOUTH-CENTRAL'
'AZ','CO','ID','MT','NV','NM','UT','WY'       = 'MOUNTAIN'
'AK','CA','HI','OR','WA'                      = 'PACIFIC'
;
run;

* extract observations from the MAPS.STATES data set and add a new variable
* (DIVISION) using a PUT statement and the format $STADIV;

data states_divisions;
set maps.states;
where density le 3 and fipstate(state) not in ('AK','HI','PR');
division = put(fipstate(state),$sta2div.);
run;

* sort the map data set by DIVISION;

proc sort data=states_divisions;
by division;
run;

* use the GREMOVE procedure to remove the internal (STATE) boundaries from
* the new geographic areas, i.e. census divisions;

proc gremove data=states_divisions out=divisions;
id state;
by division;
run;

* use the GPROJECT procedure to project the map data set;

proc gproject data=divisions out=divisions;
id division;
run;

* select an empty pattern (ME) and repeat nine times, one per census
* division;

pattern1 v=me c=black r=9;


* use the GMAP procedure to create a map of census divisions
* add descriptive text with a NOTE statement;

proc gmap map=divisions data=divisions;
id division;
choro division / discrete nolegend;
note move=(2,3) pct h=4 pct f='Arial/bo/it' box=2
    'US CENSUS BUREAU DIVISIONS';
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #3...EXAMPLE #3 ------------------------------------------*/

goptions reset=all;

* create a CNTLIN data set using only those observations from counties
* that had a 25% or higher population increase from 1990 to 2000;

data countyok (keep=fmtname start label);
retain fmtname '$county' label 'OK';
set us2000co;
if (pop2000 - pop1990) / pop1990 ge .25;
start = put(state,z2.) || put(county,z3.);
run;

* use the FORMAT procedure and the CNTLIN data set to create the format
* $COUNTY;

proc format cntlin=countyok;
run;

* extract observations from the MAPS.COUNTIES data set using a PUT statement
* and the format $COUNTY;

data counties;
set maps.counties;
stcou = put(state,z2.) || put(county,z3.);
if put(stcou,$county.) eq 'OK';
drop stcou;
run;

* combine observations from the MAPS.STATES data set (STATES boundaries)
* with observations that have been extracted from the MAPS.COUNTIES data set * (COUNTIES)exclude observations using a WHERE statement and postal codes
* and the DENSITY variable;

data state_county;
set maps.states (in=from_states) counties;
where fipstate(state) not in ('AK','HI','PR') and density le 3;
if from_states then dummy=1;
else                dummy=2;
run;


* use the PROJECT procedure to project the combined state and county data
* set use two ID variables, STATE and COUNTY;

proc gproject
data=state_county
out=projected_counties
;
id state county;
run;

* select a font for all text and specify that all heights are expressed in
* percentages of the graphics output area;

goptions ftext='Arial/it/bo' gunit=pct;

* select two patterns for map areas - an empty (ME) pattern for states and a * solid (MS) pattern for counties;

pattern1 v=me c=black;
pattern2 v=ms c=grayc8;

* add descriptive text to the map with TITLE and FOOTNOTE statements;

title1       h=6 'COUNTIES WITH 25+% INCREASE IN POPULATION';
title2       h=5 '1990 TO 2000';
footnote j=l h=4 'US CENSUS BUREAU';

* use the GMAP procedure to create the map - use two ID variables, STATE and
* COUNTY;

proc gmap
map=projected_counties
data=projected_counties;
id state county;
choro dummy / discrete coutline=black nolegend;
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #3...EXAMPLE #4 ------------------------------------------*/

goptions reset=all;

* select a font for all text and specify that all heights are expressed in
* percentages of the graphics output area;

goptions ftext='Arial/it/bo' gunit=pct;

* use the GPROJECT procedure to both project the MAPS.STATES data set
* and clip the map at specified latitudes and longitudes;

proc gproject
data=maps.states
out=clipped_map
longmax=105
longmin=87
latmin=33
latmax=44;
id state;
run;

* add descriptive text with a TITLE statement;

title h=6 'MAP CLIPPED WITH PROC GPROJECT';

* select an empty (ME) pattern for map areas;

pattern v=me c=black;

* use the GMAP procedure to create the map from the clipped-projected data
* set;

proc gmap
data=clipped_map (obs=1)
map=clipped_map
all;
id state;
choro state / discrete cempty=black nolegend;
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #3...EXAMPLE #5 ------------------------------------------*/

goptions reset=all;

* select a font for all text and specify that all heights are expressed in
* percentages of the graphics output area;

goptions ftext='Arial/it/bo' gunit=pct;

* use the GPROJECT procedure to project the MAPS.STATES data set
* exclude observations using a WHERE statement and postal codes;

proc gproject data=maps.states out=proj;
id state;
where fipstate(state) not in ('AK','HI','PR');
run;

* select an empty (ME) pattern for map areas;

pattern v=me c=black;

* use the GMAP procedure to create a map
* add the map the the graphics catalog "holdmaps" with the name "usa";

proc gmap
data=proj (obs=1)
map=proj
all
gout=holdmaps;
id state;
choro state / discrete cempty=black nolegend name='usa';
note move=(40,50) h=2 color=white box=1 blank=yes
                      color=black 'MAP CLIPPED WITH PROC GREPLAY';
run;
quit;

* use the GREPLAY procedure to create a clipped map by redrawing the map
* in an enlarged space, displaying only that portion that fits in the
* space ranging from 0 to 100 in both the X and Y direction;

proc greplay igout=holdmaps nofs;
tc   template;
tdef tins 1/llx=-100 ulx=-100 lrx=200  urx=200
            lly=-100 uly=200  lry=-100 ury=200
;
template tins;
tplay 1:usa;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #3...EXAMPLE #6 ------------------------------------------*/

goptions reset=all;
goptions hsize=5.5 in vsize=4.0 in;

* use the SUMMARY procedure to find the minimum and maximum latitude and
* longitude of seven northeastern states;

proc summary data=maps.states;
var y;
where fipstate(state) in ('ME','NH','VT','MA','RI','CT','NY');
output out=stats (keep=max_lat min_lat)
       max=max_lat min=min_lat;
run;

* compute the distance in miles between the minimum and maximum latitudes
* compute map height in inches - divide the distance in miles by 150
* the map will have a scale of 150 miles to the inch
* place that distance (now in inches) in a macro variable named &HEIGHT;

data _null_;
set stats;
range_miles = 3949.99 * (max_lat - min_lat);
height      = range_miles / 150;
call symput('height',put(height,10.2));
run;

* use the PROJECT procedure to project the MAPS.STATES data set
* use a WHERE statement and postal codes to select nine northeastern states;

proc gproject
data=maps.states
out=projected_states
;
where fipstate(state) in ('ME','NH','VT','MA','RI','CT','NY');
id state;
run;

* select an empty (ME) pattern for map areas;

pattern v=me c=black;

* use the GMAP procedure to create the map
* specify map height using the YSIZE= option and the macro variable &HEIGHT
* add descriptive text with a NOTE statement;

proc gmap
map=projected_states
data=projected_states (obs=1)
all
;
id state;
choro state /  discrete ysize=&height in
               cempty=black nolegend;
note h=6 pct f='Arial/bo/it'
         'OUTLINE MAP OF NORTHEAST UNITED STATES'
     j=l 'DRAWN TO SCALE:  1 INCH = 150 MILES';
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #3...EXAMPLE #7 ------------------------------------------*/

goptions reset=all;

* select a font for all text and specify that all heights are expressed in
* percentages of the graphics output area;

goptions ftext='Arial/bo/it' htext=4 gunit=pct ;

* create a format (POP) to group states by population;

proc format;
value pop
 low   -<   50000 = '<50'
 50000 -<  100000 = '50-99'
100000 -<  500000 = '100-499'
500000 -  high    = '500+'
;
run;

* use the GPROJECT procedure twice, each time using a WHERE statement to
* select only New York state counties
* first -project the MAPS.COUNTIES data using all New York state counties
* second - project the MAPS.COUNTIES data set, but
* clip the map on three sides using latitude and longitude, creating a data
* set with projected X-Y coordinates of the New York City area;

proc gproject data=maps.counties out=nys;
where fipstate(state) eq 'NY';
id county;
run;

proc gproject data=maps.counties out=nyc
longmax=74.29
longmin=73.69
latmax=40.95
;
where fipstate(state) eq 'NY';
id county;
run;

* select solid patterns (MS) for map areas - fills are shades of gray;

pattern1 v=ms c=grayda;
pattern2 v=ms c=grayaa;
pattern3 v=ms c=gray8a;
pattern4 v=ms c=gray5a;

* use a LEGEND statement to create a legend;

legend1 shape=bar(3,4) origin=(5,70) pct across=2 mode=share
        label=(j=l position=top 'THOUSANDS');

* add descriptive text with a TITLE statement;

title h=5 'YEAR 2000 CENSUS POPULATION - NEW YORK STATE';

* use the GMAP procedure to create a map of all New York State counties
* add the map to the graphics catalog "holdmaps" with the name "NYS";

proc gmap map=nys data=nys2000co gout=holdmaps;
id  county;
choro pop2000 / discrete coutline=white legend=legend1 name='NYS';
note move=(62,6) pct box=1 h=2 'SEE INSET';
format pop2000 pop.;
run;
quit;

* clear the title and use a GOPTIONS statement to add a BORDER to subsequent
* maps;

title;
goptions border;

* use the GMAP procedure to create a map of the clipped area
* add the map to the graphics catalog "holdmaps" with the name "NYC"
* add descriptive text with a NOTE statement, specify a HEIGHT of 10
* the large text will be reduced when displayed in an inset;

proc gmap map=nyc data=nys2000co gout=holdmaps;
id  county;
choro pop2000 / discrete coutline=white nolegend name='NYC';
format pop2000 pop.;
note h=10 ' NEW YORK CITY';
run;
quit;

* use the GREPLAY procedure to place two maps in the graphics output area
* replay the New York State map in the full output space
* replay the New York City map in a small area in a reduced output space;


proc greplay igout=holdmaps nofs;
tc   template;
tdef tins 1/llx=0    ulx=0   lrx=100 urx=100
            lly=0    uly=100 lry=0   ury=100
          2/llx=30   ulx=30  lrx=55  urx=55
            lly=3    uly=28  lry=3   ury=28 ;
template tins;
tplay 1:nys 2:nyc;

quit;

proc catalog c=holdmaps kill;
quit;
/*-------------------------------------------------------------------*/


/*-------------------------------------------------------------------*/
/*----------------------------CHAPTER #1-----------------------------*/
/*-------------------------------------------------------------------*/


/* CHAPTER #4...EXAMPLE #1 ------------------------------------------*/

goptions reset=all;

* create an Annotate data set (ADD_LABELS)
* extract information on location of the labels for seven northeastern
* states from the MAPS.USCENTER data set (the PROJECTED X-Y coordinates are
* used);

data add_labels;
retain function  'label'
       xsys ysys '2'
       position  '5'
       color     'black'
       style     '"Arial/bo/it"'
       size       3
       hsys      '3'
       cbox      'white'
       when      'a';
set maps.uscenter;
where fipstate(state) in ('CT','ME','MA','NH','NY','RI','VT') and ocean ne 'Y';
text = fipname(state);
run;

* select a solid (MS) pattern for map areas, repeat the pattern seven times;

pattern v=ms c=gray88 r=7;

* use the GMAP procedure to create a map and add labels with an ANNOTATE=
* option add descriptive text with a NOTE statement;

proc gmap
map=maps.us
data=maps.us;
where fipstate(state) in ('CT','ME','MA','NH','NY','RI','VT');
id state;
choro state / discrete coutline=white nolegend annotate=add_labels;
note h=5 pct f='Arial/bo/it' 'MAP LABELS ON US MAP DATA SET';
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #4...EXAMPLE #2 ------------------------------------------*/

goptions reset=all;

* create an Annotate data set (TEMP_LABELS)
* extract information on location of the labels for seven northeastern
* states from the MAPS.USCENTER data set - select the UNPROJECTED X-Y
* coordinates LONG and LAT and convert them from degrees to radians;

data temp_labels;
retain function  'label'
       xsys ysys '2'
       position  '5'
       color     'black'
       style     '"Arial/bo/it"'
       size       3
       hsys      '3'
       when      'a'
       cbox      'white';
set maps.uscenter;
where fipstate(state) in ('CT','ME','MA','NH','NY','RI','VT') and ocean ne 'Y';
x = long * constant('pi') / 180;
y = lat  * constant('pi') / 180;
text = fipname(state);
if fipstate(state) eq 'CT' then position = '8';
else                            position = '5';
run;

* combine selected observations from the MAPS.STATES data set
* with the observations from the Annotate data set TEMP_LABELS;

data map_labels;
set maps.states temp_labels;
where fipstate(state) in ('CT','ME','MA','NH','NY','RI','VT');
run;

* use the GPROJECT procedure to project the combined data set;

proc gproject data=map_labels out=proj_map_labels;
id state;
run;

* separate the combined projected data set into a map data set (MAP)
* and an Annotate data set (LABELS);

data map labels;
set proj_map_labels;
if when eq 'a' then output labels;
else                output map;
run;

* select a solid (MS) pattern for map areas, repeat the pattern seven times;

pattern v=ms c=graya8 r=7;

* use the GMAP procedure to create the map
* add labels using the ANNOTATE= option and the LABELS data set
* add descriptive text with a NOTE statement;

proc gmap
map=map
data=map;
id state;
choro state / discrete coutline=white nolegend annotate=labels;
note h=5 pct f='Arial/bo/it' 'MAP LABELS ON STATES MAP DATA SET';
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #4...EXAMPLE #3 ------------------------------------------*/

goptions reset=all;

proc gfont name=marker nobuild showroman;
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #4...EXAMPLE #4 ------------------------------------------*/

goptions reset=all;

* select a font for all text and specify that all heights are expressed in
* percentages of the graphics output area;

goptions ftext='Arial/bo/it' gunit=pct;

* create an Annotate data set from observations in the MAPS.USCITY data set
* use a WHERE statement to select only observations for nine specified
* cities output two observations for each city - one with a text label (the
* city name) the other with a symbol from the MARKER font;

data add_labels;
retain
function  'label'
xsys
ysys      '2'
hsys      '3'
color     'black'
when      'a'
;
set maps.uscity (keep=state city x y);
where
fipstate(state) eq 'NY' and city eq 'New York' or
fipstate(state) eq 'CA' and city in ('Los Angeles','San Diego') or
fipstate(state) eq 'IL' and city eq 'Chicago' or
fipstate(state) eq 'TX' and city in ('Houston','Dallas','San Antonio') or
fipstate(state) eq 'PA' and city eq 'Philadelphia' or
fipstate(state) eq 'AZ' and city eq 'Phoenix';

if city in ('New York','Chicago','Dallas') then position = '2';
else
if city eq 'Los Angeles' then position = '3';
else
if city in ('Philadelphia','San Antonio') then position = 'd';
else
if city eq 'San Diego' then position = 'e';
else
if city in ('Houston','Phoenix') then position = 'f';

text = city;
size = 4; cbox = 'white'; style = "'Arial/bo/it'" ; output;

position = '5';
text = 'V';
size = 3; cbox = ''     ; style = "marker"        ; output;

drop city state;
run;

* select a solid (MS) pattern for map areas, repeat the pattern 49 times;

pattern v=ms c=graya8 r=49;

* add descriptive text with TITLE and FOOTNOTE statements;

title    h=6      'CITIES WITH 1 MILLION+ POPULATION';
footnote h=4  j=r 'US CENSUS BUREAU, 2000 ';

* use the GMAP procedure to create the map
* use the ANNOTATE= option and the LABELS data set to add markers and city
* names;

proc gmap map=maps.us data=maps.us;
where fipstate(state) not in ('AK','HI');
id state;
choro state / discrete coutline=white
              nolegend annotate=add_labels;
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #4...EXAMPLE #5 ------------------------------------------*/

goptions reset=all;

* NOTE:  THIS EXAMPLE FIRST REQUIRES CREATION OF THE GAUGE FONT
*        SAS CODE TO CREATE THE FONT IS FOUND IN APPENDIX D;

* select a font for all text and specify that all heights are expressed in
* percentages of the graphics output area;

goptions ftext='Arial/bo/it' gunit=pct;

* create a format (POP) to group states by population;

proc format;
value pop
low      -<  1000000 = '<1'
1000000  -<  5000000 = '1.0-4.9'
5000000  -< 10000000 = '5.0-9.9'
10000000 -   high    = '10+'
;
run;

* create an Annotate data set (ANNO)
* extract information on location of the labels for states in specified
* areas from the MAPS.USCENTER data set - observations selected by merging
* with the US2000CO data set (Appendix A1), selecting WESTERN and
* MIDWESTERN state
*
* select the UNPROJECTED X-Y coordinates
* LONG and LAT and convert them from degrees to radians
*
* the text is from the GAUGE font (Appendix A4) - specific characters are
* chosen based on the percent change in population from 1990 to 2000;


data anno;
retain
xsys ysys  '2'      function   'label'
style      'gauge'  when       'a'
position   '5'      color      'black'
hsys       '3'      size        5
cbox       'white'
;
merge maps.uscenter
      us2000st (where=(region in ('WEST','MIDWEST') and
                       fipstate(state) not in ('AK' 'HI'))
                in=us2000);
by state;
if us2000;
x    = long * constant('pi') / 180;
y    = lat  * constant('pi') / 180;
pct  = 100 * (pop2000 - pop1990) / pop1990;
text = put(round(pct,1),hex2.);
run;

* combine selected observations from the MAPS.STATES data set with
* observations from the Annotate data set ANNO;

data map_anno;
set
maps.states (where=(fipstate(state) in ('AZ','CA','CO','ID','IL','IN','IA',
                                        'KS','MI','MN','MO','MT','NE','NV',
                                        'NM','ND','OH','OR','SD','UT','WA',
                                        'WI','WY') and density le 2))
anno;
run;

* use the GPROJECT procedure to project the combined data set;

proc gproject data=map_anno out=projected;
id state;
run;

* separate the combined projected data set into a map data set (MAP)
* and an Annotate data set (ANNO);

data map anno;
set projected;
if when eq 'a' then output anno;
else                output map;
run;

* select solid (MS) patterns for map areas, colors are shades of gray;

pattern1 v=ms c=grayfa;
pattern2 v=ms c=grayda;
pattern3 v=ms c=grayaa;
pattern4 v=ms c=gray5a;

* create a LEGEND;

legend1
origin=(60,5) pct mode=share shape=bar(3,4) across=2
label=(position=top h=3 'POPULATION (MILLIONS)') value=(j=l h=3);

* add descriptive text with TITLE statements;

title1 h=6 'YEAR 2000 CENSUS POPULATION';
title2 h=4 'GAUGE SHOWS % POPULATION CHANGE, 1990 TO 2000';


* use the GMAP procedure to create the map
* add labels (symbols from the GAUGE font) using the ANNOTATE= option
* and the Annotate data set ANNO
* add descriptive text (explanation of GAUGE font levels) with a NOTE
* statement;

proc gmap
data=us2000st
map=map;
id state;
choro pop2000 / discrete coutline=black legend=legend1 annotate=anno;
note j=c
f=gauge h=5 '00' f='Arial/bo/it' h=3 ' = 0%    '
f=gauge h=5 '32' f='Arial/bo/it' h=3 ' = 50%   '
f=gauge h=5 '64' f='Arial/bo/it' h=3 ' = 100%  ';
format pop2000 pop.;
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #4...EXAMPLE #6 ------------------------------------------*/

goptions reset=all;

* NOTE:  THIS EXAMPLE FIRST REQUIRES CREATION OF THE GAUGE FONT
*        SAS CODE TO CREATE THE FONT IS FOUND IN APPENDIX D;

* select a font for all text and specify that all heights are expressed in
* percentages of the graphics output area;

goptions ftext='Arial/bo/it' gunit=pct;

* create a format (POP) to group states by population;

proc format;
value pop
low      -<  1000000 = '<1'        1000000  -<  5000000 = '1.0-4.9'
5000000  -< 10000000 = '5.0-9.9'   10000000 -   high    = '10+'
;
run;

* create an Annotate data set (ANNO)
* extract information on location of the labels for states in specified
* areas from the MAPS.USCENTER data set - observations selected by merging
* with the US2000CO data set (Appendix A1.2), selecting WESTERN and
* MIDWESTERN state
*
* select the UNPROJECTED X-Y coordinates
* LONG and LAT and convert them from degrees to radians
*
* the text is from the GAUGE font (Appendix A4) - specific characters are
* chosen based on the percent change in population from 1990 to 2000;

data anno;
retain
xsys ysys  '2'      function   'label'
style      'gauge'  when       'a'
position   '5'      color      'black'
hsys       '3'      size        5
cbox       'white'
;
merge maps.uscenter
      us2000st (where=(region in ('WEST','MIDWEST') and
                       fipstate(state) not in ('AK' 'HI'))
                in=us2000);
by state;
if us2000;
x    = long * constant('pi') / 180;
y    = lat  * constant('pi') / 180;
pct  = 100 * (pop2000 - pop1990) / pop1990;
text = put(round(pct,1),hex2.);
run;

* combine selected observations from the MAPS.STATES data set with
* observations from the Annotate data set ANNO;

data map_anno;
set
maps.states (where=(fipstate(state) in ('AZ','CA','CO','ID','IL','IN','IA',
                                        'KS','MI','MN','MO','MT','NE','NV',
                                        'NM','ND','OH','OR','SD','UT','WA',
                                        'WI','WY') and density le 2))
anno;
run;

* use the GPROJECT procedure to project the combined data set;

proc gproject data=map_anno out=projected;
id state;
run;

* separate the combined projected data set into a map data set (MAP)
* and an Annotate data set (ANNO);

data map anno;
set projected;
if when eq 'a' then output anno;
else                output map;

* add a new variable (REGION) to the projected data set MAP and
* create a new data set TWO_REGIONS;

data tworegions;
set map;
if fipstate(state) in ('AZ','CA','CO','ID','MT','NV','NM','OR','UT','WA','WY')
then region = 'WEST   ';
else region = 'MIDWEST';
run;
* sort the TWO_REGIONS data set by REGION and then use the GREMOVE procedure
* to remove the internal boundaries (states) from the new map areas
* (region);

proc sort data=tworegions;
by region;
run;

proc gremove data=tworegions out=tworegions;
by region;
id state;
run;

* use a data step to convert the data set TWO_REGIONS into an
* Annotate data set OUTLINE - specify thick lines using SIZE=4;

data outline;
length function $8;
set tworegions;
by region segment;
retain xsys ysys '2' hsys '3' size 4 color 'black' when  'a';
if first.segment or (lag(x)=. and lag(y)=.) then function='POLY';
else                                             function='POLYCONT';
if x and y then output;
run;

* select solid (MS) patterns for map areas, colors are shades of gray;

pattern1 v=ms c=grayea; pattern2 v=ms c=grayda;
pattern3 v=ms c=grayaa; pattern4 v=ms c=gray5a;

* create a LEGEND;

legend1
origin=(60,5) pct mode=share shape=bar(3,4) across=2
label=(position=top h=3 'POPULATION (MILLIONS)') value=(j=l h=3);

* add descriptive text with TITLE statements;

title1 h=4 'YEAR 2000 CENSUS POPULATION (WEST & MIDWEST REGIONS)';
title2 h=4 'GAUGE SHOWS % POPULATION CHANGE, 1990 TO 2000';

* use the GMAP procedure to create the map
* add labels (symbols from the GAUGE font) using the ANNOTATE= option on the
* CHORO statement (use the data set ANNO)
*
* add thick borders using the ANNOTATE= option on the PROC GMAP statement
* (use the OUTLINE data set)
*
* add descriptive text (explanation of GAUGE font levels) with a NOTE
* statement;

proc gmap
data=us2000st
map=map
annotate=outline
;
id state;
choro pop2000 / discrete coutline=white legend=legend1
                annotate=anno;
note j=c
f=gauge h=5 '00' f='Arial/bo/it' h=3 ' = 0%    '
f=gauge h=5 '32' f='Arial/bo/it' h=3 ' = 50%   '
f=gauge h=5 '64' f='Arial/bo/it' h=3 ' = 100%  ';
format pop2000 pop.;
run;
quit;
/*-------------------------------------------------------------------*/


/* CHAPTER #4...EXAMPLE #7 ------------------------------------------*/

goptions reset=all;

* select a font for all text and specify that all heights are expressed in
* percentages of the graphics output area;

goptions ftext='Arial/bo/it' gunit=pct htext=3;

* create a format (POP) to group states by population;

proc format;
value pop
 low   -<   50000 = '<50'
 50000 -<  100000 = '50-99'
100000 -<  500000 = '100-499'
500000 -  high    = '500+'
;
run;

* create an Annotate data set from observations in the MAPS.USCITY data set
* use a WHERE statement to select only observations for three cities
* the data set will contain:  an observation for a text label for each city;
* an observation for a symbol (from the MARKER font) placed on the
* location of each city - 361 observations comprising a polygon
* around each city, with the polygon looking like a circle;

data anno;
length function color $8 style text $15;
retain xsys ysys '2' hsys '3' color 'white' line 1 when 'a'
       radius 100 r 3949.99;

set maps.uscity (keep=state city lat long);
where fipstate(state) eq 'TX' and city in ('Dallas','Houston','San Antonio');

x=long * constant('pi') / 180;
y=lat  * constant('pi') / 180;

function='label';

size=2.5; color='black'; cbox='white';
style="swissbi"; text=upcase(city); position='8'; output;

size=4;  color='white'; cbox='';
style='marker'  ; text='V' ; position='5'; output;

d2r=constant('pi') / 180;
xcen=long; ycen=lat;
size=5; style='me'; color='black';
do degree=0 to 360 by 1;
   if degree=0 then function='poly';
   else             function='polycont';
   y=arsin(cos(degree*d2r)*sin(radius/R)*cos(ycen*d2r)+
          cos(radius/R)*sin(ycen*d2r))/d2r;
   x=xcen+arsin(sin(degree*d2r)*sin(radius/R)/cos(y*d2r))/d2r;
   x=x*d2r; y=y*d2r;
   output;
end;
drop state city;
run;

* combine selected observations from the MAPS.COUNTIES data set with
* observations from the Annotate data set ANNO;

data map_anno;
set maps.counties (where=(fipstate(state)='TX' and density le 3)) anno;
run;

* use the GPROJECT procedure to project the combined data set
* the DUPOK option is used to allow duplicate X-Y coordinates in the
* projected data set - necessary when X-Y coordinates in map boundaries are
* equal to X-Y coordinates in the Annotate data set;

proc gproject data=map_anno out=projected dupok;
id county;
run;

* separate the combined projected data set into a map data set (MAP)
* and an Annotate data set (ANNO);

data map anno;
set projected;
if when eq 'a' then output anno;
else                output map;
run;

* select solid (MS) patterns for map areas, colors are shades of gray;

pattern1 v=ms c=grayea; pattern2 v=ms c=grayba;
pattern3 v=ms c=gray8a; pattern4 v=ms c=gray5a;

* create a LEGEND;

legend1 shape=bar(3,4) origin=(5,5) pct across=2 mode=share
        label=(j=l position=top 'THOUSANDS');

* use the GMAP procedure to create the map
* use the ANNOTATE= option and data set ANNO to add the symbols, city names,
* and circles around each city;

proc gmap map=map data=tx2000co;
id county;
choro pop2000 / discrete coutline=black legend=legend1 annotate=anno;
format pop2000 pop.;

note h=4 j=r 'YEAR 2000 CENSUS POPULATION '
         j=r 'TEXAS COUNTIES '
     h=3 j=r ' '
         j=r '100 MILE RADIUS CIRCLES AROUND '
         j=r 'CITIES WITH 1 MILLION+ POPULATION ';
run;
quit;
/*-------------------------------------------------------------------*/


/*-------------------------------------------------------------------*/
/*----------------------------CHAPTER #5-----------------------------*/
/*-------------------------------------------------------------------*/


/* CHAPTER #5...EXAMPLE #1A -----------------------------------------*/

goptions reset=all;

* add two variables to the population data set
* new variables are used to link map areas (states) and
* legend boxes (regions) to previously created HTML files;

data links;
set us2000st;
state_link = 'ALT="' || trim(fipname(state)) || '" href=state'
                     || put(state,z2.) || '.htm';
select(region);
   when ('NORTHEAST') region_link = 'ALT="NORTHEAST" href=northeast.htm';
   when ('SOUTH')     region_link = 'ALT="SOUTH"     href=south.htm';
   when ('MIDWEST')   region_link = 'ALT="MIDWEST"   href=midwest.htm';
   when ('WEST')      region_link = 'ALT="WEST"      href=west.htm';
end;
run;

goptions device=gif xpixels=1000 ypixels=750 ftext='Arial' gunit=pct;

ods listing close;
ods html path='i:\' (url=none) file="census2000.htm";

pattern1 v=ms c=grayca; pattern2 v=ms c=gray9a;
pattern3 v=ms c=gray6a; pattern4 v=ms c=gray3a;

legend1 shape=bar(3,4) origin=(88,15) pct mode=share
        label=none value=(font='Arial/bo/it' h=2) across=1;

title    h=8 'US CENSUS BUREAU REGIONS';
footnote h=3 'CLICK ON STATE OR LEGEND BOX TO DRILL DOWN TO YEAR 2000 CENSUS DATA';

* data set links used as the response data set
* it contains variables used to link map areas (STATE_LINK) and the
* legend (REGION_LINK) to previously created HTML files;

proc gmap map=maps.us data=links;
id state;
choro region / midpoints='NORTHEAST' 'SOUTH' 'MIDWEST' 'WEST'
               html=state_link
               html_legend=region_link
               coutline=white legend=legend1 name='regions' ;
run;
quit;

ods html close;
ods listing;
/*-------------------------------------------------------------------*/


/* CHAPTER #5...EXAMPLE #1B -----------------------------------------*/

goptions reset=all;

* create an Annotate data set containing a variable (HTML) that links
* part of the annotation (STARS) to previously created HTML files;

data add_labels;
retain
xsys
ysys      '2'
hsys      '3'
color     'black'
when      'a'
;
input text $12. x y position : $1.;
size = 4; cbox = 'white'; style = "'Arial/bo/it'" ; output;
html='HREF="' || trim(compress(text)) || '.htm"';
size = 3; cbox = ''; style = "marker"; position = '5'; text = 'V'; output;

datalines;
New York      0.28540  0.09317 2
Los Angeles  -0.32135 -0.01648 3
Chicago       0.10520  0.08526 2
Houston       0.00664 -0.13007 f
Philadelphia  0.27260  0.07840 d
Phoenix      -0.23387 -0.04455 f
San Diego    -0.30851 -0.04273 e
Dallas       -0.01374 -0.07733 2
San Antonio  -0.04075 -0.13493 d
;
run;

pattern v=ms c=graya8 r=49;

goptions device=gif ftext='Arial/bo/it';

ods listing close;
ods html path='i:\' (url=none) file='cities.htm';

title1  h=6 pct 'CITIES WITH 1 MILLION+ POPULATION';
title2  h=4 pct 'CLICK ON A STAR TO ACCESS CITY-SPECIFIC DATA';

footnote h=4 pct j=r 'US CENSUS BUREAU, 2000 ';

* use the Annotate data set to add text (CITY NAMES), symbols (STARS),
* and hyperlinks to the map;

proc gmap map=maps.us data=maps.us;
where state not in (2 15);
id state;
choro state / discrete coutline=white nolegend
              annotate=add_labels
              name='cities';
run;
quit;

ods html close;
ods listing;
/*-------------------------------------------------------------------*/


/* CHAPTER #5...EXAMPLE #2 ------------------------------------------*/

goptions reset=all;

goptions device=java xpixels=1000 ypixels=750
         ftext='Arial' htext=3 ctext=black gunit=pct;

* use the CODEBASE= option to specify the location of the MAPAPP.JAR
* applet on the Web server
* output (HTML file) created locally, to be moved to the Web server later
*
* NOTE:  you can also specify a 'local' location of MAPAPP.JAR as shown
* below if you want to view the ouput locally, without moving the
* output to a Web server;

ods listing close;
ods html file="i:\usa2000.htm"
         codebase='c:\sas\applets';
*        codebase="http://webservername/graph/";

* add a new variable (STATE_NAME) to both the map and response data sets
* the variable will be used as the ID variable in PROC GMAP;

data usa;
set maps.us;
state_name = fipname(state);
run;

* add a label and format to the response variable in the response data set
* these attributes control appearance of the pop-up information;

data pop;
set us2000st;
state_name = fipname(state);
label state_name = 'State Name'
      pop2000 = 'Year 2000 Census Population';
format pop2000 comma15.;
run;

pattern1 v=ms c=gray88 r=51;

title1 j=l h=6 'YEAR 2000 CENSUS POPULATION';
title2 j=l h=4 '(PLACE MOUSE POINTER OVER STATE TO SHOW POPULATION)';

proc gmap map=usa data=pop;
id state_name;
choro pop2000 / coutline=white nolegend;
run;
quit;

ods html close;
ods listing;
/*-------------------------------------------------------------------*/


/* CHAPTER #5...EXAMPLE #3 ------------------------------------------*/

goptions reset=all;

proc format;
value pop
low      -< 1300000 = '<1.3'
1300000 -< 4000000  = '1.3-3.9'
4000000 -< 6000000  = '4.0-5.9'
6000000 -  high     = '6.0+'
;
run;

* text to put in floating text box (after line with TIP);

data popup;
length popvar $200;
set us2000st;
pct    = 100*(pop2000 - pop1990) / pop1990;
stname = fipname(state);
popvar = 'tip=['||
         quote(stname) || ' ' ||
         quote('POPULATION')  || ' ' ||
         quote('1990 :  ' || put(pop1990,comma10.)) || ' ' ||
         quote('2000 :  ' || put(pop2000,comma10.)) || ' ' ||
         quote('% CHANGE :  ' || put(pct,10.1))
         || ']';
run;

* reserved filename for javameta device driver;

filename _webout 'i:\jm_usa1.htm';

* write HTML header with selected options;

data _null_;
file _webout;
input;
put _infile_;
datalines;
<html>
<head>
<title>JAVAMETA DEVICE DRIVER</title>
</head>
<body>
<applet archive="http://webservername/graph/metafile.zip"
        code="MetaViewApplet.class"
        width="800" height="600" align="TOP">
<param name="BackgroundColor"    value="0xFFFFFF">
<param name="DataTipStyle"       value="Stick_Fixed">
<param name="ZoomControlEnabled" value="False">
<param name="Metacodes"          value="
;
run;

goptions device=javameta
         gunit=pct
         ftext='HelveticaBold'
         htext=3.75
         htitle=7.25;

pattern1 v=ms c=grayfa;
pattern2 v=ms c=grayca;
pattern3 v=ms c=grayaa;
pattern4 v=ms c=gray5a;

legend1
label=(j=r 'MILLIONS')
shape=bar(3,4)
across=4
;

title 'YEAR 2000 CENSUS POPULATION';

* add metagraphics from PROC GMAP;

proc gmap
map=maps.us
data=popup
imagemap=temp;
id state;
choro  pop2000 / discrete coutline=black legend=legend1 html=popvar;
format pop2000 pop.;
run;
quit;

* write HTML footer;

data _null_;
file _webout mod;
input;
put _infile_;
datalines;
">
   SORRY, YOUR BROWSER DOES NOT SUPPORT THIS APPLICATION
</applet>
</body>
</html>
;
run;

filename _webout;


/* CHAPTER #5...EXAMPLE #4 ------------------------------------------*/

goptions reset=all;

* add a new variable (STATE_NAME) to both the map and response data sets
* the variable will be used as the ID variable in PROC GMAP;

data usa;
set maps.us;
state_name = fipname(state);
run;

* add a label and format to the response variable in the response data set
* these attributes control the appearance of the pop-up information;

data pop;
set us2000st;
state_name = fipname(state);
label state_name = 'STATE'
      pop2000 = 'POPULATION';
format pop2000 comma15.;
run;

ods listing close;

ods html file="i:\ax_prism.htm"
         attributes=(codebase="http://webservername/graph/sasgraph.exe");

goptions device   = activex
         xpixels  = 800
         ypixels  = 600
         cback    = white
         gunit    = pct
         ftext    = 'Helvetica'
         htitle   = 7
         htext    = 4
         border;

pattern1 v=ms c=grayfa;
pattern2 v=ms c=grayca;
pattern3 v=ms c=gray9a;
pattern4 v=ms c=gray5a;

legend1
label=('QUARTILE')
value=(j=l 'FIRST' 'SECOND' 'THIRD' 'FOURTH')
;

title 'YEAR 2000 CENSUS POPULATION';

proc gmap
map=usa
data=pop
;
id state_name;
prism  pop2000 / levels=4 legend=legend1 coutline=black;
run;
quit;

ods html close;
ods listing;
/*-------------------------------------------------------------------*/


/* CHAPTER #5...EXAMPLE #5 ------------------------------------------*/

goptions reset=all;

%macro popchange(diff,change,outfile);

   data countyok (keep=fmtname start label);
   retain fmtname '$county' label 'OK';
   set us2000co;
   if (pop2000 - pop1990) / pop1990 &diff;
   start = put(state,z2.) || put(county,z3.);
   run;

   proc format cntlin=countyok;
   run;

   data counties;
   set maps.counties;
   stcou = put(state,z2.) || put(county,z3.);
   if put(stcou,$county.) eq 'OK';
   drop stcou;
   run;

   data state_county;
   set maps.states  (in=from_states)
       counties;
   where fipstate(state) not in ('AK','HI','PR') and density le 3;
   if from_states then dummy=1;
   else                dummy=2;
   run;

   proc gproject
   data=state_county
   out=projected_counties
   ;
   id state county;
   run;

   filename _webout "&outfile";

   goptions device=javameta
            gunit=pct
            ftext='HelveticaItalicBold'
            htext=4.00
            htitle=4.75;

   pattern1 v=me c=black;
   pattern2 v=ms c=grayc8;

   title1  "COUNTIES WITH A &change IN POPULATION";
   title2  "1990 TO 2000";

   footnote j=l 'US CENSUS BUREAU';

   proc gmap
   map=projected_counties
   data=projected_counties
   all;
   id state county;
   choro dummy / discrete coutline=black nolegend;
   run;
   quit;

   filename _webout;

%mend;

%popchange(le -.05,  5+% DECREASE, i:\popchng1.txt);
%popchange(ge  .10, 10+% INCREASE, i:\popchng2.txt);
%popchange(ge  .25, 25+% INCREASE, i:\popchng3.txt);
%popchange(ge  .50, 50+% INCREASE, i:\popchng4.txt);
/*-------------------------------------------------------------------*/


/* CHAPTER #5...EXAMPLE #6 ------------------------------------------*/

goptions reset=all;

* create an Annotate data set - used to place a symbol at the
* location of the US population center in each of the years in the DATALINES
* file;

data popctr;
   retain function 'label' xsys ysys '2' hsys '3' position '5'
          size 3.5 color 'black' style 'marker' text 'C' when 'a';

   infile datalines dsd;
   input year : $4. y x location : $40.;

   fips = stfips(scan(location,-1));
   y    = y*constant('pi')/180;
   x    = x*constant('pi')/180;

   datalines;
   1790,  39.275,  76.187,  "KENT COUNTY,MD"
   1800,  39.268,  76.943,  "HOWARD COUNTY,MD"
   1810,  39.192,  77.620,  "LOUDON COUNTY,VA"
   1820,  39.095,  78.550,  "HARDY COUNTY,WV"
   1830,  38.965,  79.283,  "GRANT COUNTY,WV"
   1840,  39.033,  80.300,  "UPSHUR COUNTY,WV"
   1850,  38.983,  81.317,  "WIRT COUNTY,WV"
   1860,  39.008,  82.813,  "PIKE COUNTY,OH"
   1870,  39.200,  83.595,  "HIGHLAND COUNTY,OH"
   1880,  39.069,  84.661,  "BOONE COUNTY,KY"
   1890,  39.199,  85.548,  "DECATUR COUNTY,IN"
   1900,  39.160,  85.815,  "BARTHOLOMEW COUNTY,IN"
   1910,  39.170,  86.539,  "MONROE COUNTY,IN"
   1920,  39.173,  86.721,  "OWEN COUNTY,IN"
   1930,  39.064,  87.135,  "GREENE COUNTY,IN"
   1940,  38.948,  87.376,  "SULLIVAN COUNTY,IN"
   1950,  38.804,  88.369,  "CLAY COUNTY,IL"
   1960,  38.600,  89.210,  "CLINTON COUNTY,IL"
   1970,  38.463,  89.706,  "ST CLAIR COUNTY,IL"
   1980,  38.137,  90.574,  "JEFFERSON COUNTY,MO"
   1990,  37.872,  91.215,  "CRAWFORD COUNTY,MO"
   2000,  37.697,  91.810,  "PHELPS COUNTY,MO"
   ;
run;

* combine the Annotate data set with selected state boundaries from
* the STATES map data set;

data both;
   set
   maps.states (where=(fipstate(state) in
                       ("IA" "IL" "IN" "OH" "PA" "MO" "KY" "WV" "VA"
                        "TN" "NC" "MD" "DE" "DC" "AR" "NJ" "NY")
                       and density le 3))
   popctr;
run;

   * project the combined data set;

proc gproject data=both out=bothproj;
   id state;
run;

* separate the projected Annonate data set from the projected map data set;

data pmap pop;
   set bothproj;
   if when eq 'a' then output pop;
   else                output pmap;
run;

goptions device=javameta
         gunit=pct
         ftext='HelveticaBold'
         htext=5
         htitle=6;

filename _webout "i:\popcenter.htm";

* write records to an HTML file
* output from the GMAP procedure will be added to the end of the HTML file;

data _null_;
   file _webout;
   input;
   put _infile_;
   datalines;
   <html>
   <head>
   <title>JAVA METAGRAPHICS</title>
   </head>
   <body>
   <applet archive="http://webservername/graph/metafile.zip"
           code="MetaViewApplet.class"
           width="800" height="600" align="TOP">
   <param name="BackgroundColor"    value="0xffffff">
   <param name="ZoomControlEnabled" value="false">
   <param name="Metacodes"          value="
   ;
run;

* a gray-scale fill will be used to fill one state per map;

pattern v=ms c=grayca;

* a macro will be used to create 22 maps - one for each
* year of data in the POPCTR Annotate data set;

%macro manymaps;

* use a macro Do-loop to repeat the GMAP procedure 22 times;

%do i=1 %to 22;

* create an Annotate data set with the number of observations controlled
* by the index variable (&i) of the macro Do loop
* when the last observation is reached, create macro variables containing
* values of the variable year, location, and state number;

data anno;
   length text $50;
   set pop (obs=&i) end=last;
   if last then do;
       size = '4';
       text = 'V';
       call symput('year',year);
       call symput('cost',location);
       call symput('fips',put(fips,z3.));
   end;
run;

* use the macro variables &YEAR and &COST in the map title;

title1 "CENTER OF US POPULATION:  &YEAR";
title2 "&cost";

* use the same data set as both the map and response data set
* select one state for the response data set - it will be gray-filled
* the remaining states will only be outlined;

proc gmap
map=pmap
data=pmap (where=(state=&fips))
all;
   id state;
   choro state / discrete nolegend
                 coutline=black
                 cempty=black
                 annotate=anno;
   run;
quit;

%end;
%mend;

* use the macro to create the maps
* all output from PROC GMAP is written to one file;

%manymaps;

* write more HTML code to complete the file;

data _null_;
   file _webout mod;
   input;
   put _infile_;
   datalines;
   ">
   </applet>
   </body>
   </html>
   ;
run;

filename _webout;
/*-------------------------------------------------------------------*/


/* CHAPTER #5...EXAMPLE #7 ------------------------------------------*/

* create an Annotate data set - used to place a symbol at the
* location of the US population center in each of the years in the DATALINES file;

data popctr;
   retain function 'label' xsys ysys '2' hsys '3' position '5'
          size 3.5 color 'black' style 'marker' text 'C' when 'a';

   infile datalines dsd;
   input year : $4. y x location : $40.;

   fips = stfips(scan(location,-1));
   y    = y*constant('pi')/180;
   x    = x*constant('pi')/180;

   datalines;
   1790,  39.275,  76.187,  "KENT COUNTY,MD"
   1800,  39.268,  76.943,  "HOWARD COUNTY,MD"
   1810,  39.192,  77.620,  "LOUDON COUNTY,VA"
   1820,  39.095,  78.550,  "HARDY COUNTY,WV"
   1830,  38.965,  79.283,  "GRANT COUNTY,WV"
   1840,  39.033,  80.300,  "UPSHUR COUNTY,WV"
   1850,  38.983,  81.317,  "WIRT COUNTY,WV"
   1860,  39.008,  82.813,  "PIKE COUNTY,OH"
   1870,  39.200,  83.595,  "HIGHLAND COUNTY,OH"
   1880,  39.069,  84.661,  "BOONE COUNTY,KY"
   1890,  39.199,  85.548,  "DECATUR COUNTY,IN"
   1900,  39.160,  85.815,  "BARTHOLOMEW COUNTY,IN"
   1910,  39.170,  86.539,  "MONROE COUNTY,IN"
   1920,  39.173,  86.721,  "OWEN COUNTY,IN"
   1930,  39.064,  87.135,  "GREENE COUNTY,IN"
   1940,  38.948,  87.376,  "SULLIVAN COUNTY,IN"
   1950,  38.804,  88.369,  "CLAY COUNTY,IL"
   1960,  38.600,  89.210,  "CLINTON COUNTY,IL"
   1970,  38.463,  89.706,  "ST CLAIR COUNTY,IL"
   1980,  38.137,  90.574,  "JEFFERSON COUNTY,MO"
   1990,  37.872,  91.215,  "CRAWFORD COUNTY,MO"
   2000,  37.697,  91.810,  "PHELPS COUNTY,MO"
   ;
run;

* combine the Annotate data set with selected state boundaries from
* the STATES map data set;

data both;
   set
   maps.states (where=(fipstate(state) in
                      ("IA" "IL" "IN" "OH" "PA" "MO" "KY" "WV" "VA"
                       "TN" "NC" "MD" "DE" "DC" "AR" "NJ" "NY")
                       and density le 3))
   popctr;
run;

* project the combined data set;

proc gproject data=both out=bothproj;
id state;
run;

* separate the projected Annonate data set from the projected map data set;

data pmap pop;
   set bothproj;
   if when eq 'a' then output pop;
   else                output pmap;
run;

goptions device=gifanim
         gsfname=animout
         gsfmode=replace
         gunit=pct
         ftext='Arial/bo'
         ctext=black
         htext=5
         htitle=6
         iteration=0
         delay=200;

filename animout 'i:\popctr.gif';

pattern v=ms c=grayca;


%macro manymaps;
%do i=1 %to 22;

%if &i eq  2 %then goptions gsfmode=append;;
%if &i eq 22 %then goptions gepilog='3B'x;;

data anno;
length text $40;
set pop (obs=&i) end=last;
if last then do;
    size = 4;
    text ='V';
    call symput('year' ,year);
    call symput('cost' ,location);
    call symput('fips' ,put(fips,z3.));
end;
run;

title1 "CENTER OF US POPULATION:  &YEAR";
title2 "&cost";

proc gmap
map=pmap
data=pmap (where=(state=&fips))
all;
id state;
choro state / discrete
              nolegend
              coutline=black
              cempty=black
              annotate=anno;
run;
quit;
%end;
%mend;

%manymaps;
/*-------------------------------------------------------------------*/

