/*-------------------------------------------------------------------*/
/* Getting Started with the SQL Procedure                            */
/* Publication book code:   55042                                    */
/*                                                                   */
/* Each sample begins with a comment that states the example and     */
/* page number where the code is shown.                              */
/*                                                                   */
/* Note that in the LIBNAME statement you must supply the name of    */
/* your own SAS data library.                                        */
/*-------------------------------------------------------------------*/

/* The following code produces the output shown in Output 1.1 on
   page 3. If you want to list the entire table, remove
   the OUTOBS= option.             */

libname sql 'SAS-data-library';
options ls=80 ps=60 nodate nonumber;

data sql.march;
   input flight $3. +5 date date7. +3 depart time5. +2 orig $3.
         +3 dest $3.  +7 miles +6 boarded +6 capacity;
   format date date7. depart time5.;
   informat date date7. depart time5.;
   cards;
114     01MAR94    7:10  LGA   LAX       2475       172       210
202     01MAR94   10:43  LGA   ORD        740       151       210
219     01MAR94    9:31  LGA   LON       3442       198       250
622     01MAR94   12:19  LGA   FRA       3857       207       250
132     01MAR94   15:35  LGA   YYZ        366       115       178
271     01MAR94   13:17  LGA   PAR       3635       138       250
302     01MAR94   20:22  LGA   WAS        229       105       180
114     02MAR94    7:10  LGA   LAX       2475       119       210
202     02MAR94   10:43  LGA   ORD        740       120       210
219     02MAR94    9:31  LGA   LON       3442       147       250
622     02MAR94   12:19  LGA   FRA       3857       176       250
132     02MAR94   15:35  LGA   YYZ        366       106       178
302     02MAR94   20:22  LGA   WAS        229        78       180
271     02MAR94   13:17  LGA   PAR       3635       104       250
114     03MAR94    7:10  LGA   LAX       2475       197       210
202     03MAR94   10:43  LGA   ORD        740       118       210
219     03MAR94    9:31  LGA   LON       3442       197       250
622     03MAR94   12:19  LGA   FRA       3857       180       250
132     03MAR94   15:35  LGA   YYZ        366        75       178
271     03MAR94   13:17  LGA   PAR       3635       147       250
302     03MAR94   20:22  LGA   WAS        229       123       180
114     04MAR94    7:10  LGA   LAX       2475       178       210
202     04MAR94   10:43  LGA   ORD        740       148       210
219     04MAR94    9:31  LGA   LON       3442       232       250
622     04MAR94   12:19  LGA   FRA       3857       137       250
132     04MAR94   15:35  LGA   YYZ        366       117       178
271     04MAR94   13:17  LGA   PAR       3635       146       250
302     04MAR94   20:22  LGA   WAS        229       115       180
114     05MAR94    7:10  LGA   LAX       2475       117       210
202     05MAR94   10:43  LGA   ORD        740       104       210
219     05MAR94    9:31  LGA   LON       3442       160       250
622     05MAR94   12:19  LGA   FRA       3857       185       250
132     05MAR94   15:35  LGA   YYZ        366       157       178
271     05MAR94   13:17  LGA   PAR       3635       177       250
114     06MAR94    7:10  LGA   LAX       2475       128       210
202     06MAR94   10:43  LGA   ORD        740       115       210
219     06MAR94    9:31  LGA   LON       3442       163       250
132     06MAR94   15:35  LGA   YYZ        366       150       178
302     06MAR94   20:22  LGA   WAS        229        66       180
114     07MAR94    7:10  LGA   LAX       2475       160       210
202     07MAR94   10:43  LGA   ORD        740       175       210
219     07MAR94    9:31  LGA   LON       3442       241       250
622     07MAR94   12:19  LGA   FRA       3857       210       250
132     07MAR94   15:35  LGA   YYZ        366       164       178
271     07MAR94   13:17  LGA   PAR       3635       155       250
302     07MAR94   20:22  LGA   WAS        229       135       180
;

proc sql outobs=15;
   select * from sql.march;


/* The following code produces the output shown in Output 1.2 on
   page 3. If you want to list the entire table, remove
   the OUTOBS= option.             */

libname sql 'SAS-data-library';

data sql.delay;
   input flight $3. +5 date date7. +2 orig $3. +3 dest $3. +3
         delaycat $15. +2 destype $15. +8 delay;
   informat date date7.;
   format date date7.;
   cards;
114     01MAR94  LGA   LAX   1-10 Minutes     Domestic                8
202     01MAR94  LGA   ORD   No Delay         Domestic               -5
219     01MAR94  LGA   LON   11+ Minutes      International          18
622     01MAR94  LGA   FRA   No Delay         International          -5
132     01MAR94  LGA   YYZ   11+ Minutes      International          14
271     01MAR94  LGA   PAR   1-10 Minutes     International           5
302     01MAR94  LGA   WAS   No Delay         Domestic               -2
114     02MAR94  LGA   LAX   No Delay         Domestic                0
202     02MAR94  LGA   ORD   1-10 Minutes     Domestic                5
219     02MAR94  LGA   LON   11+ Minutes      International          18
622     02MAR94  LGA   FRA   No Delay         International           0
132     02MAR94  LGA   YYZ   1-10 Minutes     International           5
271     02MAR94  LGA   PAR   1-10 Minutes     International           4
302     02MAR94  LGA   WAS   No Delay         Domestic                0
114     03MAR94  LGA   LAX   No Delay         Domestic               -1
202     03MAR94  LGA   ORD   No Delay         Domestic               -1
219     03MAR94  LGA   LON   1-10 Minutes     International           4
622     03MAR94  LGA   FRA   No Delay         International          -2
132     03MAR94  LGA   YYZ   1-10 Minutes     International           6
271     03MAR94  LGA   PAR   1-10 Minutes     International           2
302     03MAR94  LGA   WAS   1-10 Minutes     Domestic                5
114     04MAR94  LGA   LAX   11+ Minutes      Domestic               15
202     04MAR94  LGA   ORD   No Delay         Domestic               -5
219     04MAR94  LGA   LON   1-10 Minutes     International           3
622     04MAR94  LGA   FRA   11+ Minutes      International          30
132     04MAR94  LGA   YYZ   No Delay         International          -5
271     04MAR94  LGA   PAR   1-10 Minutes     International           5
302     04MAR94  LGA   WAS   1-10 Minutes     Domestic                7
114     05MAR94  LGA   LAX   No Delay         Domestic               -2
202     05MAR94  LGA   ORD   1-10 Minutes     Domestic                2
219     05MAR94  LGA   LON   1-10 Minutes     International           3
622     05MAR94  LGA   FRA   No Delay         International          -6
132     05MAR94  LGA   YYZ   1-10 Minutes     International           3
271     05MAR94  LGA   PAR   1-10 Minutes     International           5
114     06MAR94  LGA   LAX   No Delay         Domestic               -1
202     06MAR94  LGA   ORD   No Delay         Domestic               -3
219     06MAR94  LGA   LON   11+ Minutes      International          27
132     06MAR94  LGA   YYZ   1-10 Minutes     International           7
302     06MAR94  LGA   WAS   1-10 Minutes     Domestic                1
114     07MAR94  LGA   LAX   No Delay         Domestic               -1
202     07MAR94  LGA   ORD   No Delay         Domestic               -2
219     07MAR94  LGA   LON   11+ Minutes      International          15
622     07MAR94  LGA   FRA   11+ Minutes      International          21
132     07MAR94  LGA   YYZ   No Delay         International          -2
271     07MAR94  LGA   PAR   1-10 Minutes     International           4
302     07MAR94  LGA   WAS   No Delay         Domestic                0
;

proc sql outobs=15;
   select * from sql.delay;

/* The following code produces the output shown in Output 1.3 on
   page 4. If you want to list the entire table, remove
   the OUTOBS= option.             */

libname sql 'SAS-data-library';

data sql.internat;
   input flight $3.  +5 date date7. +2 dest $3. +8 boarded;
   informat date date7.;
   format date date7.;
   cards;
219     01MAR94  LON        198
622     01MAR94  FRA        207
132     01MAR94  YYZ        115
271     01MAR94  PAR        138
219     02MAR94  LON        147
622     02MAR94  FRA        176
132     02MAR94  YYZ        106
271     02MAR94  PAR        172
219     03MAR94  LON        197
622     03MAR94  FRA        180
132     03MAR94  YYZ         75
271     03MAR94  PAR        147
219     04MAR94  LON        232
622     04MAR94  FRA        137
132     04MAR94  YYZ        117
271     04MAR94  PAR        146
219     05MAR94  LON        160
622     05MAR94  FRA        185
132     05MAR94  YYZ        157
271     05MAR94  PAR        177
219     06MAR94  LON        163
132     06MAR94  YYZ        150
219     07MAR94  LON        241
622     07MAR94  FRA        210
132     07MAR94  YYZ        164
271     07MAR94  PAR        155
;

proc sql outobs=15;
   select * from sql.internat;

/* The following code produces the output shown in Output 1.4 on
   page 4. If you want to list the entire table, remove
   the OUTOBS= option.             */

libname sql 'SAS-data-library';

data sql.schedule;
   input flight $3. +5 date date7. +2 dest $3. +3 idnum $4.;
   format date date7.;
   informat date date7.;
   cards;
132     01MAR94  YYZ   1739
132     01MAR94  YYZ   1478
132     01MAR94  YYZ   1130
132     01MAR94  YYZ   1390
132     01MAR94  YYZ   1983
132     01MAR94  YYZ   1111
219     01MAR94  LON   1407
219     01MAR94  LON   1777
219     01MAR94  LON   1103
219     01MAR94  LON   1125
219     01MAR94  LON   1350
219     01MAR94  LON   1332
271     01MAR94  PAR   1439
271     01MAR94  PAR   1442
271     01MAR94  PAR   1132
271     01MAR94  PAR   1411
271     01MAR94  PAR   1988
271     01MAR94  PAR   1443
622     01MAR94  FRA   1545
622     01MAR94  FRA   1890
622     01MAR94  FRA   1116
622     01MAR94  FRA   1221
622     01MAR94  FRA   1433
622     01MAR94  FRA   1352
132     02MAR94  YYZ   1556
132     02MAR94  YYZ   1478
132     02MAR94  YYZ   1113
132     02MAR94  YYZ   1411
132     02MAR94  YYZ   1574
132     02MAR94  YYZ   1111
219     02MAR94  LON   1407
219     02MAR94  LON   1118
219     02MAR94  LON   1132
219     02MAR94  LON   1135
219     02MAR94  LON   1441
219     02MAR94  LON   1332
271     02MAR94  PAR   1739
271     02MAR94  PAR   1442
271     02MAR94  PAR   1103
271     02MAR94  PAR   1413
271     02MAR94  PAR   1115
271     02MAR94  PAR   1443
622     02MAR94  FRA   1439
622     02MAR94  FRA   1890
622     02MAR94  FRA   1124
622     02MAR94  FRA   1368
622     02MAR94  FRA   1477
622     02MAR94  FRA   1352
132     03MAR94  YYZ   1739
132     03MAR94  YYZ   1928
132     03MAR94  YYZ   1425
132     03MAR94  YYZ   1135
132     03MAR94  YYZ   1437
132     03MAR94  YYZ   1111
219     03MAR94  LON   1428
219     03MAR94  LON   1442
219     03MAR94  LON   1130
219     03MAR94  LON   1411
219     03MAR94  LON   1115
219     03MAR94  LON   1332
271     03MAR94  PAR   1905
271     03MAR94  PAR   1118
271     03MAR94  PAR   1970
271     03MAR94  PAR   1125
271     03MAR94  PAR   1983
271     03MAR94  PAR   1443
622     03MAR94  FRA   1545
622     03MAR94  FRA   1830
622     03MAR94  FRA   1414
622     03MAR94  FRA   1368
622     03MAR94  FRA   1431
622     03MAR94  FRA   1352
132     04MAR94  YYZ   1428
132     04MAR94  YYZ   1118
132     04MAR94  YYZ   1103
132     04MAR94  YYZ   1390
132     04MAR94  YYZ   1350
132     04MAR94  YYZ   1111
219     04MAR94  LON   1739
219     04MAR94  LON   1478
219     04MAR94  LON   1130
219     04MAR94  LON   1125
219     04MAR94  LON   1983
219     04MAR94  LON   1332
271     04MAR94  PAR   1407
271     04MAR94  PAR   1410
271     04MAR94  PAR   1094
271     04MAR94  PAR   1411
271     04MAR94  PAR   1115
271     04MAR94  PAR   1443
622     04MAR94  FRA   1545
622     04MAR94  FRA   1890
622     04MAR94  FRA   1116
622     04MAR94  FRA   1221
622     04MAR94  FRA   1433
622     04MAR94  FRA   1352
132     05MAR94  YYZ   1556
132     05MAR94  YYZ   1890
132     05MAR94  YYZ   1113
132     05MAR94  YYZ   1475
132     05MAR94  YYZ   1431
132     05MAR94  YYZ   1111
219     05MAR94  LON   1428
219     05MAR94  LON   1442
219     05MAR94  LON   1422
219     05MAR94  LON   1413
219     05MAR94  LON   1574
219     05MAR94  LON   1332
271     05MAR94  PAR   1739
271     05MAR94  PAR   1928
271     05MAR94  PAR   1103
271     05MAR94  PAR   1477
271     05MAR94  PAR   1433
271     05MAR94  PAR   1443
622     05MAR94  FRA   1545
622     05MAR94  FRA   1830
622     05MAR94  FRA   1970
622     05MAR94  FRA   1441
622     05MAR94  FRA   1350
622     05MAR94  FRA   1352
132     06MAR94  YYZ   1333
132     06MAR94  YYZ   1890
132     06MAR94  YYZ   1414
132     06MAR94  YYZ   1475
132     06MAR94  YYZ   1437
132     06MAR94  YYZ   1111
219     06MAR94  LON   1106
219     06MAR94  LON   1118
219     06MAR94  LON   1425
219     06MAR94  LON   1434
219     06MAR94  LON   1555
219     06MAR94  LON   1332
132     07MAR94  YYZ   1407
132     07MAR94  YYZ   1118
132     07MAR94  YYZ   1094
132     07MAR94  YYZ   1555
132     07MAR94  YYZ   1350
132     07MAR94  YYZ   1111
219     07MAR94  LON   1905
219     07MAR94  LON   1478
219     07MAR94  LON   1124
219     07MAR94  LON   1434
219     07MAR94  LON   1983
219     07MAR94  LON   1332
271     07MAR94  PAR   1410
271     07MAR94  PAR   1777
271     07MAR94  PAR   1103
271     07MAR94  PAR   1574
271     07MAR94  PAR   1115
271     07MAR94  PAR   1443
622     07MAR94  FRA   1107
622     07MAR94  FRA   1890
622     07MAR94  FRA   1425
622     07MAR94  FRA   1475
622     07MAR94  FRA   1433
622     07MAR94  FRA   1352
;

proc sql outobs=15;
   select * from sql.schedule;


/* The following code produces the output shown in Output 1.5 on
   page 4. If you want to list the entire table, remove
   the OUTOBS= option.            */

libname sql 'SAS-data-library';

data sql.payroll;
   input idnum $4. +3 sex $1. +4 jobcode $3. +9 salary 5.
         +2 birth date7. +2 hired date7.;
   informat birth date7. hired date7.;
   format birth date7. hired date7.;
   cards;
1919   M    TA2         34376  12SEP60  04JUN87
1653   F    ME2         35108  15OCT64  09AUG90
1400   M    ME1         29769  05NOV67  16OCT90
1350   F    FA3         32886  31AUG65  29JUL90
1401   M    TA3         38822  13DEC50  17NOV85
1499   M    ME3         43025  26APR54  07JUN80
1101   M    SCP         18723  06JUN62  01OCT90
1333   M    PT2         88606  30MAR61  10FEB81
1402   M    TA2         32615  17JAN63  02DEC90
1479   F    TA3         38785  22DEC68  05OCT89
1403   M    ME1         28072  28JAN69  21DEC91
1739   M    PT1         66517  25DEC64  27JAN91
1658   M    SCP         17943  08APR67  29FEB92
1428   F    PT1         68767  04APR60  16NOV91
1782   M    ME2         35345  04DEC70  22FEB92
1244   M    ME2         36925  31AUG63  17JAN88
1383   M    BCK         25823  25JAN68  20OCT92
1574   M    FA2         28572  27APR60  20DEC92
1789   M    SCP         18326  25JAN57  11APR78
1404   M    PT2         91376  24FEB53  01JAN80
1437   F    FA3         33104  20SEP60  31AUG84
1639   F    TA3         40260  26JUN57  28JAN84
1269   M    NA1         41690  03MAY72  28NOV92
1065   M    ME2         35090  26JAN44  07JAN87
1876   M    TA3         39675  20MAY58  27APR85
1037   F    TA1         28558  10APR64  13SEP92
1129   F    ME2         34929  08DEC61  17AUG91
1988   M    FA3         32217  30NOV59  18SEP84
1405   M    SCP         18056  05MAR66  26JAN92
1430   F    TA2         32925  28FEB62  27APR87
1983   F    FA3         33419  28FEB62  27APR87
1134   F    TA2         33462  05MAR69  21DEC88
1118   M    PT3        111379  16JAN44  18DEC80
1438   F    TA3         39223  15MAR65  18NOV87
1125   F    FA2         28888  08NOV68  11DEC87
1475   F    FA2         27787  15DEC61  13JUL90
1117   M    TA3         39771  05JUN63  13AUG92
1935   F    NA2         51081  28MAR54  16OCT81
1124   F    FA1         23177  10JUL58  01OCT90
1422   F    FA1         22454  04JUN64  06APR91
1616   F    TA2         34137  01MAR70  04JUN93
1406   M    ME2         35185  08MAR61  17FEB87
1120   M    ME1         28619  11SEP72  07OCT93
1094   M    FA1         22268  02APR70  17APR91
1389   M    BCK         25028  15JUL59  18AUG90
1905   M    PT1         65111  16APR72  29MAY92
1407   M    PT1         68096  23MAR69  18MAR90
1114   F    TA2         32928  18SEP69  27JUN87
1410   M    PT2         84685  03MAY67  07NOV86
1439   F    PT1         70736  06MAR64  10SEP90
1409   M    ME3         41551  19APR50  22OCT81
1408   M    TA2         34138  29MAR60  14OCT87
1121   M    ME1         29112  26SEP71  07DEC91
1991   F    TA1         27645  07MAY72  12DEC92
1102   M    TA2         34542  01OCT59  15APR91
1356   M    ME2         36869  26SEP57  22FEB83
1545   M    PT1         66130  12AUG59  29MAY90
1292   F    ME2         36691  28OCT64  02JUL89
1440   F    ME2         35757  27SEP62  09APR91
1368   M    FA2         27808  11JUN61  03NOV84
1369   M    TA2         33705  28DEC61  13MAR87
1411   M    FA2         27265  27MAY61  01DEC89
1113   F    FA1         22367  15JAN68  17OCT91
1704   M    BCK         25465  30AUG66  28JUN87
1900   M    ME2         35105  25MAY62  27OCT87
1126   F    TA3         40899  28MAY63  21NOV80
1677   M    BCK         26007  05NOV63  27MAR89
1441   F    FA2         27158  19NOV69  23MAR91
1421   M    TA2         33155  08JAN59  28FEB90
1119   M    TA1         26924  20JUN62  06SEP88
1834   M    BCK         26896  08FEB72  02JUL92
1777   M    PT3        109630  23SEP51  21JUN81
1663   M    BCK         26452  11JAN67  11AUG91
1106   M    PT2         89632  06NOV57  16AUG84
1103   F    FA1         23738  16FEB68  23JUL92
1477   M    FA2         28566  21MAR64  07MAR88
1476   F    TA2         34803  30MAY66  17MAR87
1379   M    ME3         42264  08AUG61  10JUN84
1104   M    SCP         17946  25APR63  10JUN91
1009   M    TA1         28880  02MAR59  26MAR92
1412   M    ME1         27799  18JUN56  05DEC91
1115   F    FA3         32699  22AUG60  29FEB80
1128   F    TA2         32777  23MAY65  20OCT90
1442   F    PT2         84536  05SEP66  12APR88
1417   M    NA2         52270  27JUN64  07MAR89
1478   M    PT2         84203  09AUG59  24OCT90
1673   M    BCK         25477  27FEB70  15JUL91
1839   F    NA1         43433  29NOV70  03JUL93
1347   M    TA3         40079  21SEP67  06SEP84
1423   F    ME2         35773  14MAY68  19AUG90
1200   F    ME1         27816  10JAN71  14AUG92
1970   F    FA1         22615  25SEP64  12MAR91
1521   M    ME3         41526  12APR63  13JUL88
1354   F    SCP         18335  29MAY71  16JUN92
1424   F    FA2         28978  04AUG69  11DEC89
1132   F    FA1         22413  30MAY72  22OCT93
1845   M    BCK         25996  20NOV59  22MAR80
1556   M    PT1         71349  22JUN64  11DEC91
1413   M    FA2         27435  16SEP65  02JAN90
1123   F    TA1         28407  31OCT72  05DEC92
1907   M    TA2         33329  15NOV60  06JUL87
1436   F    TA2         34475  11JUN64  12MAR87
1385   M    ME3         43900  16JAN62  01APR86
1432   F    ME2         35327  03NOV61  10FEB85
1111   M    NA1         40586  14JUL73  31OCT92
1116   F    FA1         22862  28SEP69  21MAR91
1352   M    NA2         53798  02DEC60  16OCT86
1555   F    FA2         27499  16MAR68  04JUL92
1038   F    TA1         26533  09NOV69  23NOV91
1420   M    ME3         43071  19FEB65  22JUL87
1561   M    TA2         34514  30NOV63  07OCT87
1434   F    FA2         28622  11JUL62  28OCT90
1414   M    FA1         23644  24MAR72  12APR92
1112   M    TA1         26905  29NOV64  07DEC92
1390   M    FA2         27761  19FEB65  23JUN91
1332   M    NA1         42178  17SEP70  04JUN91
1890   M    PT2         91908  20JUL51  25NOV79
1429   F    TA1         27939  28FEB60  07AUG92
1107   M    PT2         89977  09JUN54  10FEB79
1908   F    TA2         32995  10DEC69  23APR90
1830   F    PT2         84471  27MAY57  29JAN83
1882   M    ME3         41538  10JUL57  21NOV78
1050   M    ME2         35167  14JUL63  24AUG86
1425   F    FA1         23979  28DEC71  28FEB93
1928   M    PT2         89858  16SEP54  13JUL90
1480   F    TA3         39583  03SEP57  25MAR81
1100   M    BCK         25004  01DEC60  07MAY88
1995   F    ME1         28810  24AUG73  19SEP93
1135   F    FA2         27321  20SEP60  31MAR90
1415   M    FA2         28278  09MAR58  12FEB88
1076   M    PT1         66558  14OCT55  03OCT91
1426   F    TA2         32991  05DEC66  25JUN90
1564   F    SCP         18833  12APR62  01JUL92
1221   F    FA2         27896  22SEP67  04OCT91
1133   M    TA1         27701  13JUL66  12FEB92
1435   F    TA3         38808  12MAY59  08FEB80
1418   M    ME1         28005  29MAR57  06JAN92
1017   M    TA3         40858  28DEC57  16OCT81
1443   F    NA1         42274  17NOV68  29AUG91
1131   F    TA2         32575  26DEC71  19APR91
1427   F    TA2         34046  31OCT70  30JAN90
1036   F    TA3         39392  19MAY65  23OCT84
1130   F    FA1         23916  16MAY71  05JUN92
1127   F    TA2         33011  09NOV64  07DEC86
1433   F    FA3         32982  08JUL66  17JAN87
1431   F    FA3         33230  09JUN64  05APR88
1122   F    FA2         27956  01MAY63  27NOV88
1105   M    ME2         34805  01MAR62  13AUG90
;

proc sql outobs=15;
   select * from sql.payroll;


/* The following code produces the output shown in Output 1.6 on
   page 5. */

libname sql 'SAS-data-library';

data sql.payroll2;
   input idnum $4. +3 sex $1. +4 jobcode $3. +9 salary 5.
         +2 birth date7. +2 hired date7.;
   informat birth date7. hired date7.;
   format birth date7. hired date7.;
   cards;
1639   F    TA3         42260  26JUN57  28JAN84
1065   M    ME3         38090  26JAN44  07JAN87
1561   M    TA3         36514  30NOV63  07OCT87
1221   F    FA3         29896  22SEP67  04OCT91
1447   F    FA1         22123  07AUG72  29OCT92
1998   M    SCP         23100  10SEP70  02NOV92
1036   F    TA3         42465  19MAY65  23OCT84
1106   M    PT3         94039  06NOV57  16AUG84
1129   F    ME3         36758  08DEC61  17AUG91
1350   F    FA3         36098  31AUG65  29JUL90
1369   M    TA3         36598  28DEC61  13MAR87
1076   M    PT1         69742  14OCT55  03OCT91
;

proc sql;
   select * from sql.payroll2;



/* The following code produces the output shown in Output 1.7 on
   page 5. If you want to list the entire table, remove
   the OUTOBS= option.           */

libname sql 'SAS-data-library';

data sql.staff;
   input idnum $4. +3 lname $15. +2 fname $15. +2 city $15. +2
         state $2. +5 hphone $12.;
   cards;
1919   ADAMS            GERALD           STAMFORD         CT     203/781-1255
1653   ALIBRANDI        MARIA            BRIDGEPORT       CT     203/675-7715
1400   ALHERTANI        ABDULLAH         NEW YORK         NY     212/586-0808
1350   ALVAREZ          MERCEDES         NEW YORK         NY     718/383-1549
1401   ALVAREZ          CARLOS           PATERSON         NJ     201/732-8787
1499   BAREFOOT         JOSEPH           PRINCETON        NJ     201/812-5665
1101   BAUCOM           WALTER           NEW YORK         NY     212/586-8060
1333   BANADYGA         JUSTIN           STAMFORD         CT     203/781-1777
1402   BLALOCK          RALPH            NEW YORK         NY     718/384-2849
1479   BALLETTI         MARIE            NEW YORK         NY     718/384-8816
1403   BOWDEN           EARL             BRIDGEPORT       CT     203/675-3434
1739   BRANCACCIO       JOSEPH           NEW YORK         NY     212/587-1247
1658   BREUHAUS         JEREMY           NEW YORK         NY     212/587-3622
1428   BRADY            CHRISTINE        STAMFORD         CT     203/781-1212
1782   BREWCZAK         JAKOB            STAMFORD         CT     203/781-0019
1244   BUCCI            ANTHONY          NEW YORK         NY     718/383-3334
1383   BURNETTE         THOMAS           NEW YORK         NY     718/384-3569
1574   CAHILL           MARSHALL         NEW YORK         NY     718/383-2338
1789   CARAWAY          DAVIS            NEW YORK         NY     212/587-9000
1404   COHEN            LEE              NEW YORK         NY     718/384-2946
1437   CARTER           DOROTHY          BRIDGEPORT       CT     203/675-4117
1639   CARTER-COHEN     KAREN            STAMFORD         CT     203/781-8839
1269   CASTON           FRANKLIN         STAMFORD         CT     203/781-3335
1065   COPAS            FREDERICO        NEW YORK         NY     718/384-5618
1876   CHIN             JACK             NEW YORK         NY     212/588-5634
1037   CHOW             JANE             STAMFORD         CT     203/781-8868
1129   COUNIHAN         BRENDA           NEW YORK         NY     718/383-2313
1988   COOPER           ANTHONY          NEW YORK         NY     212/587-1228
1405   DACKO            JASON            PATERSON         NJ     201/732-2323
1430   DABROWSKI        SANDRA           BRIDGEPORT       CT     203/675-1647
1983   DEAN             SHARON           NEW YORK         NY     718/384-1647
1134   DELGADO          MARIA            STAMFORD         CT     203/781-1528
1118   DENNIS           ROGER            NEW YORK         NY     718/383-1122
1438   DABBOUSSI        KAMILLA          STAMFORD         CT     203/781-2229
1125   DUNLAP           DONNA            NEW YORK         NY     718/383-2094
1475   ELGES            MARGARETE        NEW YORK         NY     718/383-2828
1117   EDGERTON         JOSHUA           NEW YORK         NY     212/588-1239
1935   FERNANDEZ        KATRINA          BRIDGEPORT       CT     203/675-2962
1124   FIELDS           DIANA            WHITE PLAINS     NY     914/455-2998
1422   FUJIHARA         KYOKO            PRINCETON        NJ     201/812-0902
1616   FUENTAS          CARLA            NEW YORK         NY     718/384-3329
1406   FOSTER           GERALD           BRIDGEPORT       CT     203/675-6363
1120   GARCIA           JACK             NEW YORK         NY     718/384-4930
1094   GOMEZ            ALAN             BRIDGEPORT       CT     203/675-7181
1389   GOLDSTEIN        LEVI             NEW YORK         NY     718/384-9326
1905   GRAHAM           ALVIN            NEW YORK         NY     212/586-8815
1407   GREGORSKI        DANIEL           MT. VERNON       NY     914/468-1616
1114   GREENWALD        JANICE           NEW YORK         NY     212/588-1092
1410   HARRIS           CHARLES          STAMFORD         CT     203/781-0937
1439   HASENHAUER       CHRISTINA        BRIDGEPORT       CT     203/675-4987
1409   HAVELKA          RAYMOND          STAMFORD         CT     203/781-9697
1408   HENDERSON        WILLIAM          PRINCETON        NJ     201/812-4789
1121   HERNANDEZ        ROBERTO          NEW YORK         NY     718/384-3313
1991   HOWARD           GRETCHEN         BRIDGEPORT       CT     203/675-0007
1102   HERMANN          JOACHIM          WHITE PLAINS     NY     914/455-0976
1356   HOWARD           MICHAEL          NEW YORK         NY     212/586-8411
1545   HERRERO          CLYDE            STAMFORD         CT     203/781-1119
1292   HUNTER           HELEN            BRIDGEPORT       CT     203/675-4830
1440   JACKSON          LAURA            STAMFORD         CT     203/781-0088
1368   JEPSEN           RONALD           STAMFORD         CT     203/781-8413
1369   JONSON           ANTHONY          NEW YORK         NY     212/587-5385
1411   JOHNSON          JACKSON          PATERSON         NJ     201/732-3678
1113   JONES            LESLIE           NEW YORK         NY     718/383-3003
1704   JONES            NATHAN           NEW YORK         NY     718/384-0049
1900   KING             WILLIAM          NEW YORK         NY     718/383-3698
1126   KIMANI           ANNE             NEW YORK         NY     212/586-1229
1677   KRAMER           JACKSON          BRIDGEPORT       CT     203/675-7432
1441   LAWRENCE         KATHY            PRINCETON        NJ     201/812-3337
1421   LEE              RUSSELL          MT. VERNON       NY     914/468-9143
1119   LI               JEFF             NEW YORK         NY     212/586-2344
1834   LEBLANC          RUSSELL          NEW YORK         NY     718/384-0040
1777   LUFKIN           ROY              NEW YORK         NY     718/383-4413
1663   MARKS            JOHN             NEW YORK         NY     212/587-7742
1106   MARSHBURN        JASPER           STAMFORD         CT     203/781-1457
1103   MCDANIEL         RONDA            NEW YORK         NY     212/586-0013
1477   MEYERS           PRESTON          BRIDGEPORT       CT     203/675-8125
1476   MONROE           JOYCE            STAMFORD         CT     203/781-2837
1379   MORGAN           ALFRED           STAMFORD         CT     203/781-2216
1104   MORGAN           CHRISTOPHER      NEW YORK         NY     718/383-9740
1009   MORGAN           GEORGE           NEW YORK         NY     212/586-7753
1412   MURPHEY          JOHN             PRINCETON        NJ     201/812-4414
1115   MURPHY           ALICE            NEW YORK         NY     718/384-1982
1128   NELSON           FELICIA          BRIDGEPORT       CT     203/675-1166
1442   NEWKIRK          SANDRA           PRINCETON        NJ     201/812-3331
1417   NEWKIRK          WILLIAM          PATERSON         NJ     201/732-6611
1478   NEWTON           JAMES            NEW YORK         NY     212/587-5549
1673   NICHOLLS         HENRY            STAMFORD         CT     203/781-7770
1839   NORRIS           DIANE            NEW YORK         NY     718/384-1767
1347   O'NEAL           BRYAN            NEW YORK         NY     718/384-0230
1423   OSWALD           LESLIE           MT. VERNON       NY     914/468-9171
1200   OVERMAN          MICHELLE         STAMFORD         CT     203/781-1835
1970   PARKER           ANNE             NEW YORK         NY     718/383-3895
1521   PARKER           JAY              NEW YORK         NY     212/587-7603
1354   PARKER           MARY             WHITE PLAINS     NY     914/455-2337
1424   PATTERSON        RENEE            NEW YORK         NY     212/587-8991
1132   PEARCE           CAROL            NEW YORK         NY     718/384-1986
1845   PEARSON          JAMES            NEW YORK         NY     718/384-2311
1556   PENNINGTON       MICHAEL          NEW YORK         NY     718/383-5681
1413   PETERS           RANDALL          PRINCETON        NJ     201/812-2478
1123   PETERSON         SUZANNE          NEW YORK         NY     718/383-0077
1907   PHELPS           WILLIAM          STAMFORD         CT     203/781-1118
1436   PORTER           SUSAN            NEW YORK         NY     718/383-5777
1385   RAYNOR           MILTON           BRIDGEPORT       CT     203/675-2846
1432   REED             MARILYN          MT. VERNON       NY     914/468-5454
1111   RHODES           JEREMY           PRINCETON        NJ     201/812-1837
1116   RICHARDS         CASEY            NEW YORK         NY     212/587-1224
1352   RIVERS           SIMON            NEW YORK         NY     718/383-3345
1555   RODRIGUEZ        JULIA            BRIDGEPORT       CT     203/675-2401
1038   RODRIGUEZ        MARIA            BRIDGEPORT       CT     203/675-2048
1420   ROUSE            JEREMY           PATERSON         NJ     201/732-9834
1561   SANDERS          RAYMOND          NEW YORK         NY     212/588-6615
1434   SANDERSON        EDITH            STAMFORD         CT     203/781-1333
1414   SANDERSON        NATHAN           BRIDGEPORT       CT     203/675-1715
1112   SAYERS           RANDY            NEW YORK         NY     718/384-4895
1390   SMART            JONATHAN         NEW YORK         NY     718/383-1141
1332   STEPHENSON       ADAM             BRIDGEPORT       CT     203/675-1497
1890   STEPHENSON       ROBERT           NEW YORK         NY     718/384-9874
1429   THOMPSON         ALICE            STAMFORD         CT     203/781-3857
1107   THOMPSON         WAYNE            NEW YORK         NY     718/384-3785
1908   TRENTON          MELISSA          NEW YORK         NY     212/586-6262
1830   TRIPP            KATHY            BRIDGEPORT       CT     203/675-2479
1882   TUCKER           ALAN             NEW YORK         NY     718/384-0216
1050   TUTTLE           THOMAS           WHITE PLAINS     NY     914/455-2119
1425   UNDERWOOD        JENNY            STAMFORD         CT     203/781-0978
1928   UPCHURCH         LARRY            WHITE PLAINS     NY     914/455-5009
1480   UPDIKE           THERESA          NEW YORK         NY     212/587-8729
1100   VANDEUSEN        RICHARD          NEW YORK         NY     212/586-2531
1995   VARNER           ELIZABETH        NEW YORK         NY     718/384-7113
1135   VEGA             ANNA             NEW YORK         NY     718/384-5913
1415   VEGA             FRANKLIN         NEW YORK         NY     718/384-2823
1076   VENTER           RANDALL          NEW YORK         NY     718/383-2321
1426   VICK             THERESA          PRINCETON        NJ     201/812-2424
1564   WALTERS          ANNE             NEW YORK         NY     212/587-3257
1221   WALTERS          DIANE            NEW YORK         NY     718/384-1918
1133   WANG             CHIN             NEW YORK         NY     212/587-1956
1435   WARD             ELAINE           NEW YORK         NY     718/383-4987
1418   WATSON           BERNARD          NEW YORK         NY     718/383-1298
1017   WELCH            DARIUS           NEW YORK         NY     212/586-5535
1443   WELLS            AGNES            STAMFORD         CT     203/781-5546
1131   WELLS            NADINE           NEW YORK         NY     718/383-1045
1427   WHALEY           CAROLYN          MT. VERNON       NY     914/468-4528
1036   WONG             LESLIE           NEW YORK         NY     212/587-2570
1130   WOOD             DEBORAH          NEW YORK         NY     212/587-0013
1127   WOOD             SANDRA           NEW YORK         NY     212/587-2881
1433   YANCEY           ROBIN            PRINCETON        NJ     201/812-1874
1431   YOUNG            DEBORAH          STAMFORD         CT     203/781-2987
1122   YOUNG            JOANN            NEW YORK         NY     718/384-2021
1105   YOUNG            LAWRENCE         NEW YORK         NY     718/384-0008
;

proc sql outobs=15;
   select * from sql.staff;


/* The following code produces the output shown in Output 1.8 on
   page 5. If you want to list the entire table, remove
   the OUTOBS= option.             */

libname sql 'SAS-data-library';

data sql.superv;
   input supid $4. +8 state $2. +5  jobcat  $2.;
   label supid='Supervisor Id' jobcat='Job Category';
   cards;
1677        CT     BC
1834        NY     BC
1431        CT     FA
1433        NJ     FA
1983        NY     FA
1385        CT     ME
1420        NJ     ME
1882        NY     ME
1935        CT     NA
1417        NJ     NA
1352        NY     NA
1106        CT     PT
1442        NJ     PT
1118        NY     PT
1405        NJ     SC
1564        NY     SC
1639        CT     TA
1401        NJ     TA
1126        NY     TA
;

proc sql  outobs=15;
   select * from sql.superv;

/* The following code produces the output shown in Output 2.1 on
   page 8.  This code uses the SQL.MARCH data set. The
   DATA step that creates SQL.MARCH appears earlier in this file. 
   If you want to list the entire table, remove
   the OUTOBS= option.
*/

libname sql 'SAS-data-library';

proc sql outobs=15;
   select * from sql.march;

/* The following code produces the output shown in Output 2.2 on
   page 8.  This code uses the SQL.MARCH data set. The
   DATA step that creates SQL.MARCH appears earlier in this file. 
   If you want to list the entire table, remove
   the OUTOBS= option.
*/
libname sql 'SAS-data-library';
proc sql;
reset outobs=15;
select flight, dest from sql.march;


/* The following code produces the output shown in Output 2.3 on
   page 9.  This code uses the SQL.MARCH data set. The
   DATA step that creates SQL.MARCH appears earlier in this file. 
*/

libname sql 'SAS-data-library';
proc sql;
select distinct flight, dest from sql.march;

/* The following code produces the output shown in Output 2.4 on
    page 9.  This code uses the SQL.MARCH data set. The
    DATA step that creates SQL.MARCH appears earlier in this file. 
    If you want to list the entire output, remove
    the OUTOBS= option.  
*/

libname sql 'SAS-data-library';
proc sql outobs=15;
title 'Percentage of Capacity for Each Flight';
select flight, date, (boarded/capacity)*100 as pctfull
       from sql.march;


/*  The following code produces the output shown in Output 2.5 on
    page 10.  This code uses the SQL.MARCH data set. The
    DATA step that creates SQL.MARCH appears earlier in this file. 
    If you want to list the entire output, remove
    the OUTOBS= option.  
*/

libname sql 'SAS-data-library';
proc sql outobs=15;
title 'Percentage of Capacity for Each Flight';
select flight, date, (boarded/capacity)*100 as pctfull,
   case
        when calculated pctfull<60 then '****'
        else '  '
   end
   from sql.march;

/*  The following code produces the output shown in Output 2.6 on
    page 11.  This code uses the SQL.MARCH data set. The
    DATA step that creates SQL.MARCH appears earlier in this file. 
    If you want to list the entire output, remove
    the OUTOBS= option.  
*/

libname sql 'SAS-data-library';
proc sql outobs=15;
title 'Percentage of Capacity for Each Flight';
   select flight, date, boarded/capacity*100 as pctfull
          format=4.1 label='Percent Full'
      from sql.march;



/*  The following code produces the output shown in Output 
    2.7 on page 12.  This code uses the SQL.MARCH data set. The
    DATA step that creates SQL.MARCH appears earlier in this file. 
    If you want to list the entire output, remove
    the OUTOBS= option.  
*/

libname sql 'SAS-data-library';
proc sql outobs=15;
title 'Percentage of Capacity for Each Flight';
   select flight, date, boarded/capacity*100 as pctfull
          format=4.1 label='Percent Full'
      from sql.march
      order by pctfull;

/*  The following code produces the output shown in Output 
    2.8 on page 13.  This code uses the SQL.MARCH data set. The
    DATA step that creates SQL.MARCH appears earlier in this file. 
*/

libname sql 'SAS-data-library';
proc sql;  
title 'The SAS System';
    select avg(boarded/capacity*100) as avgfull
          format=4.1 label='Average Percent Full'
      from sql.march;


/*  The following code produces the output shown in Output 
    2.9 on page 13.  This code uses the SQL.MARCH data set. The
    DATA step that creates SQL.MARCH appears earlier in this file. 
*/

libname sql 'SAS-data-library';
proc sql;
title 'The SAS System';
select count(*) label='Number of Rows'
   from sql.march;


/*  The following code produces the output shown in Output 
    2.10 on page 13.  This code uses the SQL.MARCH data set. The
    DATA step to create SQL.MARCH appears earlier in this file. 
*/

libname sql 'SAS-data-library';
proc sql;
title 'The SAS System';
select min(boarded)  label='Fewest Passengers',
       max(boarded)  label='Most Passengers'
   from sql.march;


/*  The following code produces the output shown in Output 
    2.11 on page 14.  This code uses the SQL.MARCH data set. The
    DATA step that creates SQL.MARCH appears earlier in this file. 
*/

libname sql 'SAS-data-library';
proc sql;
title 'The SAS System';
select sum(boarded) label='Total'
   from sql.march;

/*  The following code produces the output shown in Output 
    2.12 on page 14.  This code uses the SQL.MARCH data set. The
    DATA step that creates SQL.MARCH appears earlier in this file. 
*/

libname sql 'SAS-data-library';
proc sql;
title 'Average Percentage of Capacity Per Day - All Flights';
select date, avg(boarded/capacity*100) as avgfull
       format=4.1 label='Avg Pct'
    from sql.march
    group by date;

/*  The following code produces the output shown in Output 
    2.13 on page 15.  This code uses the SQL.MARCH data set. The
    DATA step that creates SQL.MARCH appears earlier in this file. 
*/

libname sql 'SAS-data-library';
proc sql;
title 'Number of Flights Each Date';
select date, count(date) from sql.march
   group by date;


/*  The following code produces the output shown in Output 
    2.14 on page 15.  This code uses the SQL.MARCH data set. The
    DATA step that creates SQL.MARCH appears earlier in this file. 
*/

libname sql 'SAS-data-library';
proc sql;
title 'Dates that Average over 70% Capacity for All Flights';
select date, avg((boarded/capacity)*100) as avgfull
       format=4.1 label='Avg Pct'
   from sql.march
   group by date
   having avgfull>70;


/*  The following code produces the output shown in Output 
    2.15 on page 16.  This code uses the SQL.MARCH data set. The
    DATA step that creates SQL.MARCH appears earlier in this file. 
*/

libname sql 'SAS-data-library';
proc sql;
title 'Percentage of Capacity for Flight 132';
 select flight, date, (boarded/capacity)*100 as pctfull
        format=4.1 label='Percent Full'
     from sql.march
     where flight='132'
     order by pctfull;


/*  The following code produces the output shown in Output 
    2.16 on page 17.  This code uses the SQL.MARCH data set. The
    DATA step that creates SQL.MARCH appears earlier in this file. 
*/

libname sql 'SAS-data-library';
proc sql;
title 'Dates that Average over 70% Capacity for All Flights Except Flight 622';
select date, avg(boarded/capacity*100) as avgfull
       format=4.1 label='Avg Pct'
   from sql.march
   where flight ^= '622'
   group by date
   having avgfull>70;


/*  The following code produces the output shown in Output 
    2.17 on page 19.  This code uses the SQL.MARCH data set. The
    DATA step to create SQL.MARCH appears earlier in this file. 
*/


libname sql 'SAS-data-library';
proc sql;
title 'The SAS System';
select flight, avg(pctfull) format=4.1
               label='Avg Pct of Capacity'
   from (select flight, date,
                boarded/capacity*100 as pctfull
                format=4.1 label='Percent Full'
            from sql.march)
   group by flight;


/*  The following code produces the output shown in Output 
    2.18 on page 20.  This code uses the SQL.MARCH and
    SQL.SCHEDULE data sets. The DATA steps that create SQL.MARCH and
    SQL.SCHEDULE appear earlier in this file. 
*/

libname sql 'SAS-data-library';
proc sql;
title 'The SAS System';
select supid  as idnum
   from sql.superv
intersect
select  idnum
   from sql.schedule
   where date='01MAR94'd;


/*  The following code produces the output shown in Output 
    2.19 on page 21. This code uses the SQL.MARCH and
    SQL.INTERNAT data sets. The DATA steps that create SQL.MARCH and
    SQL.INTERNAT appear earlier in this file. 
*/ 

libname sql 'SAS-data-library';
proc sql;
title 'The SAS System';
select flight, dest
   from sql.march
except
select flight, dest
   from sql.internat;


/*  The following code produces the output shown in Output 
    2.20 on page 21. This code uses the SQL.STAFF and
    SQL.SUPERV data sets. The DATA steps that create SQL.STAFF and
    SQL.SUPERV appear earlier in this file. If you want to see
    the entire output, remove the OUTOBS= option.
*/  

libname sql 'SAS-data-library';
proc sql outobs=15;
title 'The SAS System';
 select idnum
    from sql.staff
 except all
 select supid as idnum
    from sql.superv;


/*  The following code produces the output shown in Output 
    2.21 on page 22. This code uses the SQL.PAYROLL data set.
    The DATA steps that creates SQL.PAYROLL appears earlier in 
    this file. 
*/  

libname sql 'SAS-data-library';
proc sql;
title 'The SAS System';
select 'Average Salary for Pilots: ',
       avg(salary) format=dollar7.
   from sql.payroll
   where jobcode  contains 'PT'
union
select 'Average Salary for Mechanics: ',
       avg(salary)  format=dollar7.
   from sql.payroll
   where  jobcode contains 'ME';


/*  The following code produces the output shown in Output 
    2.22 on page 22-23. 
*/


libname sql 'SAS-data-library';
data sql.me1;
   input idnum $4.  +3 jobcode $3. +9 salary;
   cards;
1400   ME1         29769
1403   ME1         28072
1120   ME1         28619
1121   ME1         29112
1412   ME1         27799
1200   ME1         27816
1995   ME1         28810
1418   ME1         28005
;

data sql.me2;
   input idnum $4.  +3 jobcode $3. +9 salary;
   cards;
1653   ME2         35108
1782   ME2         35345
1244   ME2         36925
1065   ME2         35090
1129   ME2         34929
1406   ME2         35185
1356   ME2         36869
1292   ME2         36691
1440   ME2         35757
1900   ME2         35105
1423   ME2         35773
1432   ME2         35327
1050   ME2         35167
1105   ME2         34805
;

data sql.me3;
   input idnum $4.  +3 jobcode $3. +9 salary;
   cards;
1499   ME3         43025
1409   ME3         41551
1379   ME3         42264
1521   ME3         41526
1385   ME3         43900
1420   ME3         43071
1882   ME3         41538
;


proc sql;
title 'The SAS System';
select *
   from sql.me1
outer union
select *
   from sql.me2
outer union
select *
   from sql.me3;


/*  The following code produces the output shown in Output 
    2.23 on page 23. This code uses the SQL.ME1, SQL.ME2, 
    and SQL.ME3 data sets. The DATA steps that create these 
    data sets appear in the previous example.
*/

libname sql 'SAS-data-library';
proc sql;
title 'The SAS System';
select *
   from sql.me1
outer union corr
select *
   from sql.me2
outer union corr
select *
   from sql.me3;

/*  The following code produces the output shown in Output 
    3.1 on page 28. This code uses the SQL.MARCH data set.
    The DATA step that creates SQL.MARCH appears earlier in 
    this file. To receive the entire output, remove
    the RESET statement.
*/

libname sql 'SAS-data-library';
proc sql;
title 'Percentage of Capacity for Each Flight';
   create table sql.capacity as
   select flight, date, dest, boarded/capacity*100 as pctfull
          format=4.1 label='Percent Full'
      from sql.march;
   reset outobs=15;
   select * from sql.capacity;

/*  The following code produces the output shown in Output 
    3.2 on page 30-31. This code uses the SQL.MARCH and SQL.INTERNAT 
    data sets. The DATA steps that create SQL.MARCH and SQL.INTERNAT 
    appear earlier in this file. 

    To receive the entire output, remove the OBS= data
    set option.
*/

libname sql 'SAS-data-library';
proc sql;
title 'The SAS System';
create table sql.newintl
   like sql.internat;

proc sql;
insert into sql.newintl
select flight, date, dest, boarded
   from sql.march
   where flight in ('132','219','271','622');

select * from sql.newintl(obs=10);

/*  The following code produces the output shown in Output 
    3.3 on page 31. This code uses the SQL.NEWINTL 
    data set, which is created in the previous
    example.

    To receive the entire output, remove the FIRSTOBS= and
    OBS= data set options.
*/

libname sql 'SAS-data-library';
proc sql;
title;
insert into sql.newintl
   set flight='501',
       date='01MAR94'd,
       dest='MXC',
       boarded=150
   set flight='501',
       date='02MAR94'd,
       dest='MXC',
       boarded=109;

select * from sql.newintl(firstobs=19 obs=28);

/*  The following code produces the output shown in Output 
    3.4 on page 32. This code uses the SQL.NEWINTL 
    data set, which is created and updated in the previous
    two examples.

    To receive the entire output, remove the FIRSTOBS= and
    OBS= data set options.
*/

libname sql 'SAS-data-library';
proc sql;
title;
insert into sql.newintl
   values ('779','02MAR94'd,'SJU',123)
   values ('779','03MAR94'd,'SJU',144);
select * from sql.newintl(firstobs=21 obs=30);

/*  The following code produces the output shown in Output 
    3.5 on page 33.  Note that this example creates the
    data set NEW from SQL.PAYROLL. This was done to avoid
    changing SQL.PAYROLL so that it would be available for
    examples in later chapters in its original form.

    To see the entire output, remove the RESET statement.
*/

libname sql 'SAS-data-library';
proc sql;
   create table new as
      select * from sql.payroll;
   update new
      set salary=salary*1.03;
   reset outobs=5;
   title 'Salaries in SQL.PAYROLL After the Update';
   select * from new;
 

/*  The following code produces the output shown in Output 
    3.6 on page 33.  Note that this example creates the
    data set NEW from SQL.PAYROLL. This was done to avoid
    changing SQL.PAYROLL so that it would be available for
    examples in later chapters in its original form.

    To see the entire output, remove the RESET statement.
*/   


libname sql 'SAS-data-library';
proc sql;
   create table new as
      select * from sql.payroll;
update new
   set salary=salary*1.03
      where jobcode like '__1';

update new
   set salary=salary*1.05
   where jobcode in ('BCK','SCP');
reset outobs=5;
title 'Salaries in SQL.PAYROLL After the Update';
select * from new
   where  jobcode like '__1' or
          jobcode in ('BCK','SCP');



/*  The following code produces the output shown in Output 
    3.7 on page 35.  Note that this example creates the
    data set NEW from SQL.PAYROLL. This was done to avoid
    changing SQL.PAYROLL so that it would be available for
    examples in later chapters in its original form.

    To see the entire output, remove the RESET statement.
*/   


libname sql 'SAS-data-library';
proc sql;
title 'The SAS System';
   create table new as
      select * from sql.payroll;
reset outobs=15;
alter table new
   add age_hir num label='Age When Hired' format=2.;
select * from new;

/*  The following code produces the output shown in Output 
    3.8 on page 36.  Note that this example creates the
    data set NEW from SQL.PAYROLL. This was done to avoid
    changing SQL.PAYROLL so that it would be available for
    examples in later chapters in its original form.

    To see the entire output, remove the RESET statement.
*/

libname sql 'SAS-data-library';
proc sql;
title 'The SAS System';
   create table new as
      select * from sql.payroll;
reset outobs=15;
alter table new
   add age_hir num label='Age at Hire' format=2.;
update new
   set age_hir=int(hired-birth)/365.25;
select * from new;


/*  The following code produces the output shown in Output 
    3.9 on page 36.  Note that this example creates the
    data set NEW from SQL.PAYROLL. This was done to avoid
    changing SQL.PAYROLL so that it would be available for
    examples in later chapters in its original form.

    To see the entire output, remove the RESET statement.
*/

libname sql 'SAS-data-library';
proc sql;
title 'The SAS System';
   create table new as
      select * from sql.payroll;
reset outobs=5;
alter table new
  modify birth format=ddmmyy8., hired format=ddmmyy8.;
select birth, hired from new;

/*  The following code produces the output shown in Output 
    3.10 on page 37.  Note that this example creates the
    data set NEW from SQL.PAYROLL. This was done to avoid
    changing SQL.PAYROLL so that it would be available for
    examples in later chapters in its original form.

    To see the entire output, remove the RESET statement.
*/

libname sql 'SAS-data-library';
proc sql;
title 'The SAS System';
   create table new as
      select * from sql.payroll;
reset outobs=5;
alter table new
   modify idnum char(5);
update new
   set idnum=substr(jobcode,1,1)||idnum;
select idnum, jobcode from new;


/*  The following code produces the output shown in Output 
    3.11 on page 39. This code uses the SQL.INTERNAT data set.
    The DATA step that creates SQL.INTERNAT appears earlier
    in this file.
*/

libname sql 'SAS-data-library';   
title 'The SAS System';
proc means data=sql.internat mean maxdec=2;
    var boarded;
run;


/*  The following code produces the output shown in Output 
    4.1 on page 42.  This code uses the SQL.PAYROLL data set.
    The DATA step that creates SQL.PAYROLL appears earlier
    in this file.
*/


libname sql 'SAS-data-library';
proc sql;
   title 'Current Summary Information for Each Job Category';
   create view sql.jobs as
      select jobcode,
             count(jobcode) as number label='Number',
             avg(int((today()-birth)/365.25)) as avgage format=2. label='Average Age',
             avg(salary) as avgsal format=dollar8. label='Average Salary'
      from payroll
      group by jobcode;
select * from sql.jobs;

/*  The following code produces the output shown in Output 
    4.2 on page 43.  This code uses the SQL.JOBS view, which 
    is created in the previous example. 
*/
 

libname sql 'SAS-data-library';
title 'The SAS System';
proc means data=sql.jobs mean maxdec=2;
   var avgage avgsal;
run;


/*  The following code produces the output shown in Output 
    5.1 on page 46.  This code uses the SQL.STAFF data set.
    The DATA step that creates SQL.STAFF appears earlier
    in this file.
*/

libname sql 'SAS-data-library';
proc sql;
title 'The SAS System';
  select lname, fname, salary format=dollar8.
     from sql.staff, sql.payroll
     where staff.idnum=payroll.idnum
           and salary>70000;

/*  The following code produces the output shown in Output 
    5.2 on page 47.  This code uses the SQL.DELAY and
    SQL.MARCH data sets. The DATA steps that create SQL.DELAY 
    and SQL.MARCH appear earlier in this file.
*/

libname sql 'SAS-data-library';
proc sql;
title 'The SAS System';
    select march.date, march.flight, miles, delaycat
       from sql.delay, sql.march
       where delay.flight=march.flight
             and delay.date=march.date
             and delay.date='01MAR94'd;


/*  The following code produces the output shown in Output 
    5.3 on page 48.  

    This code uses the SQL.PAYROLL and SQL.PAYROLL2 data sets.
    The DATA step that creates SQL.PAYROLL appears earlier in this
    file. The DATA step that creates SQL.PAYROLL2 is included in
    this example.

    If you want to see the entire output, remove the
    OUTOBS= option.
*/

libname sql 'SAS-data-library';

data sql.payroll2;
   input idnum $4. +3 sex $1. +4 jobcode $3. +9 salary 5.
         +2 birth date7. +2 hired date7.;
   informat birth date7. hired date7.;
   format birth date7. hired date7.;
   cards;
1639   F    TA3         42260  26JUN57  28JAN84
1065   M    ME3         38090  26JAN44  07JAN87
1561   M    TA3         36514  30NOV63  07OCT87
1221   F    FA3         29896  22SEP67  04OCT91
1447   F    FA1         22123  07AUG72  29OCT92
1998   M    SCP         23100  10SEP70  02NOV92
1036   F    TA3         42465  19MAY65  23OCT84
1106   M    PT3         94039  06NOV57  16AUG84
1129   F    ME3         36758  08DEC61  17AUG91
1350   F    FA3         36098  31AUG65  29JUL90
1369   M    TA3         36598  28DEC61  13MAR87
1076   M    PT1         69742  14OCT55  03OCT91
;


title 'The SAS System';
proc sql outobs=10;
select p.idnum, p.jobcode, p.salary,
       p2.jobcode label='New Jobcode',
       p2.salary label='New Salary'
   from sql.payroll as p left join sql.payroll2 as p2
   on p.idnum=p2.idnum;


/* The following code produces the output shown in Output 
   5.4 on page 48.  
   
   This code uses the SQL.PAYROLL and SQL.PAYROLL2 data sets.
   The DATA step that creates SQL.PAYROLL appears earlier in this
   file. The DATA step that creates SQL.PAYROLL2 appears in the
   previous example.

   To see the entire output, remove the OUTOBS= option. 
*/


libname sql 'SAS-data-library';
proc sql outobs=16;
select p.idnum, p.jobcode, p.salary,
       p2.jobcode label='New Jobcode',
       p2.salary label='New Salary'
   from sql.payroll p left join sql.payroll2 p2
   on p.idnum=p2.idnum
   where p2.jobcode contains 'TA';


/* The following code produces the output shown in Output 
   5.5 on page 49.  
   
   This code uses the SQL.PAYROLL and SQL.PAYROLL2 data sets.
   The DATA step that creates SQL.PAYROLL appears earlier in this
   file. The DATA step that creates SQL.PAYROLL2 appears in the
   previous example.

   To see the entire output, remove the OUTOBS= option. 
*/

libname sql 'SAS-data-library';
proc sql outobs=10;
select p.idnum, coalesce(p2.jobcode,p.jobcode) label='Current Jobcode',
       coalesce(p2.salary,p.salary) label='Current Salary'
   from sql.payroll p left join sql.payroll2 p2
   on p.idnum=p2.idnum;


/* The following code produces the output shown in Output 
   5.6 on page 50. */ 

data fltsupe;
  input flight $ supe $;
  cards;
145 Kang
150 Miller
155 Evanko
;
data fltdest;
   input flight $ dest $;
   cards;
145 Brussels
150 Paris
155 Honolulu
;

data merged;
   merge fltsupe fltdest;
   by flight;
run;

proc print data=merged noobs;
   title 'Table MERGED';
run;

/* The following code produces the output shown in Output 
   5.7 on page 51. */ 

data fltsupe;
  input flight $ supe $;
  cards;
145 Kang
150 Miller
155 Evanko
157 Lei
;
data fltdest;
   input flight $ dest $;
   cards;
145 Brussels
150 Paris
165 Seattle
;    

data merged;
   merge fltsupe fltdest;
   by flight;
run;

proc print data=merged noobs;
   title 'Table MERGED';
run;

/* The following code produces the output shown in Output 
   5.8 on page 52. */ 

data fltsupe;
  input flight $ supe $;
  cards;
145 Kang
145 Ramirez
150 Miller
150 Picard
155 Evanko
157 Lei
;

data fltdest;
   input flight $ dest $;
   cards;
145 Brussels
145 Edmonton
150 Paris
150 Madrid
165 Seattle
;


data merged;
   merge fltsupe fltdest;
   by flight;
run;

proc print data=merged noobs;
   title 'Table MERGED';
run;

/* The following code produces the output shown in Output 
   5.9 on page 52. */ 

data fltsupe;
  input flight $ supe $;
  cards;
145 Kang
145 Ramirez
150 Miller
150 Picard
155 Evanko
157 Lei
;

data fltdest;
   input flight $ dest $;
   cards;
145 Brussels
145 Edmonton
150 Paris
150 Madrid
165 Seattle
;

title 'The SAS System';
proc sql;
   select *
   from fltsupe s, fltdest d
   where s.flight=d.flight;


/* The following code produces the output shown in Output 
   6.1 on page 53. 

   This code uses the SQL.MARCH and SQL.DELAY data sets.
   The DATA steps to create these data sets appears earlier
   in this file.

   If you want to see the entire output, remove the OUTOBS= 
   option.
*/ 

libname sql 'SAS-data-library';
title 'The SAS System';
proc sql outobs=10;
select flight, date, dest, boarded
   from sql.march
   where flight in (select flight
                       from sql.delay
                       where destype='International');


/* The following code produces the output shown in Output 
   6.2 on page 54. 

   This code uses the SQL.MARCH and SQL.DELAY data sets.
   The DATA steps to create these data sets appears earlier
   in this file.

   If you want to see the entire output, remove the OUTOBS= 
   option.
*/ 


libname sql 'SAS-data-library';
title 'The SAS System';
proc sql outobs=10;
select *
   from sql.march
   where 'International' in (select destype
                                from sql.delay
                                where march.flight=delay.flight);


/* The following code produces the output shown in Output 
   6.3 on page 55. 

   This code uses the SQL.MARCH and SQL.DELAY data sets.
   The DATA steps to create these data sets appears earlier
   in this file.

   If you want to see the entire output, remove the OUTOBS= 
   option.
*/ 

libname sql 'SAS-data-library';
title 'The SAS System';
proc sql outobs=10;
select *
   from sql.march
   where exists (select *
                    from sql.delay
                    where march.flight=delay.flight
                    and destype='International');


/* The following code produces the output shown in Output 
   6.4 on page 56. 

   This code uses the SQL.PAYROLL, SQL.SUPERV, and SQL.SCHEDULE 
   data sets. The DATA steps to create these data sets appears earlier
   in this file.

   If you want to see the entire output, remove the OUTOBS= 
   option.
*/ 

libname sql 'SAS-data-library';
title 'The SAS System';
proc sql;
select *
   from sql.payroll
   where idnum in (select supid
                      from sql.superv
                      where supid in (select idnum
                                         from sql.schedule
                                         where schedule.flight='132'
                                         and schedule.date='01MAR94'd));


/* The following code produces the output shown in Output 
   7.1 on page 58-59.
*/

title 'All the Permanent Tables and Views in this Book';
proc sql;
   select libname, memname, memtype, nobs
      from dictionary.tables
      where libname='SQL';

/* The following code produces the output shown in Output 
   7.2 on page 59.
*/

title 'All Tables that Contain a DEST Column';
proc sql;
select libname, memname
   from dictionary.columns
   where name='DEST' and
         libname='SQL';


/* The following code produced the output shown in Output 
   7.3 on page 60. However, the output will vary from
   user to user because the output reflects the librefs
   assigned during the current SAS session.
*/

title 'Number of SAS Files In Each Library';
proc report data=sashelp.vtable nowindows
            headskip headline;
    column libname (n);
    define libname / group;

run; 


