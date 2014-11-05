Example Databases


SETUP.SAS

     Define librefs and paths used by the data creation (Appendix A) and example programs (Appendix B).
     This SAS code was used for Release 6.08 of the SAS System running under Windows.  Path
     designations, LIBNAME, and FILENAME statements will be different for other operating systems.


          ************************************************;
          * setup.sas;
          *
          * Setup the libnames etc. for vol1 stuff;
          ************************************************;

          ***********
          * define the libname for path to the data sets;
          libname vol1 'system specific path information';
          ***********
          * define global options;
          options nodate nonumber;
          GOPTIONS BORDER NOCHARACTERS NOFILL NOCELL;
          ***********
          * define the path to the HPGL files;
          %let pathhpg = system specific path information;


BIOMASS.SAS

     Biomass (wet weight in grams) estimates were made for several types of soft
     bottom benthic organisms (critters that live in the mud) over a period of several
     years along the southern California coast.  The BIOMASS data set contains data taken
     from selected stations and depths during the summer of 1985.  The August 5, 1985
     'outlier' is a valid datum representing a core that caught a large single organism.


          *************************************************;
          * biomass.sas;
          *
          * Create the benthos biomass data set.
          *************************************************;

          data vol1.biomass;
          input  @1 STATION $
                 @12 DATE DATE7.
                 @20 BMPOLY
                 @25 BMCRUS
                 @31 BMMOL
                 @36 BMOTHR
                 @41 BMTOTL ;

          format date date7.;

          label BMCRUS   = 'CRUSTACEAN BIOMASS (GM WET WEIGHT)'
                BMMOL    = 'MOLLUSC BIOMASS (GM WET WEIGHT)   '
                BMOTHR   = 'OTHER BIOMASS (GM WET WEIGHT)     '
                BMPOLY   = 'POLYCHAETE BIOMASS (GM WET WEIGHT)'
                BMTOTL   = 'TOTAL BIOMASS (GM WET WEIGHT)     '
                DATE     = 'DATE                              '
                STATION  = 'STATION ID                        ';

          cards;
          DL-25      18JUN85 0.4  0.03  0.17 0.02 0.62
          DL-60      17JUN85 0.51 0.09  0.14 0.08 0.82
          D1100-25   18JUN85 0.28 0.02  0.01 4.61 4.92
          D1100-60   17JUN85 0.36 0.05  0.32 0.47 1.2
          D1900-25   18JUN85 0.03 0.02  0.11 1.06 1.22
          D1900-60   17JUN85 0.54 0.11  0.03 4.18 4.86
          D3200-60   17JUN85 0.52 0.14  0.04 0.05 0.75
          D3350-25   18JUN85 0.18 0.02  0.11 0    0.31
          D6700-25   18JUN85 0.51 0.06  0.03 0.01 0.61
          D6700-60   17JUN85 0.32 0.14  0.04 0.22 0.72
          D700-25    18JUN85 0.23 0.03  0.02 0.07 0.35
          D700-60    17JUN85 1.11 0.32  0.07 0.02 1.52
          DL-25      10JUL85 0.92 0.09  0.1  0.03 1.14
          DL-60      09JUL85 0.29 0.14  0.03 0.06 0.52
          D1100-25   10JUL85 0.14 0.05  0.05 4.79 5.03
          D1100-60   09JUL85 0.88 0.07  0.01 0.01 0.97
          D1900-25   10JUL85 0.35 0.05  0.05 1.82 2.27
          D1900-60   09JUL85 0.87 0.08  0.42 3.35 4.72
          D3200-60   09JUL85 0.22 0.1   0.08 0.01 0.41
          D3350-25   10JUL85 0.36 0.06  0.01 0.02 0.45
          D6700-25   10JUL85 1.84 0.02  0.11 0.05 2.02
          D6700-60   09JUL85 0.47 0.19  0.06 0.06 0.78
          D700-25    10JUL85 1.46 0.19  0.12 0.38 2.15
          D700-60    09JUL85 0.48 0.18  0.02 0.11 0.79
          DL-25      05AUG85 0.92 0.08  0.09 0.02 1.11
          DL-60      02AUG85 0.4  0.1   0.59 0.5  1.59
          D1100-25   05AUG85 0.18 0.02  0.36 2.33 2.89
          D1100-60   02AUG85 0.39 0.12  0.03 0.01 0.55
          D1900-25   05AUG85 1.23 0.06  0.04 2.15 3.48
          D1900-60   02AUG85 0.56 0.07  0.02 0.11 0.76
          D3200-60   02AUG85 0.39 0.11  0.05 0.02 0.57
          D3350-25   05AUG85 0.45 44.82 0.02 0.16 45.45
          D6700-25   05AUG85 1.13 0.01  0.11 0.04 1.29
          D6700-60   02AUG85 0.43 0.15  1.1  0.01 1.69
          D700-25    05AUG85 0.31 0.02  0.26 0.03 0.62
          D700-60    02AUG85 0.38 0.07  0.12 1.87 2.44
          DL-25      26AUG85 0.57 0.01  0.14 0.04 0.76
          DL-60      27AUG85 0.46 0.05  0.5  0.18 1.19
          D1100-25   26AUG85 0.63 0.02  0.04 0.03 0.72
          D1100-60   27AUG85 0.57 0.04  0.09 0.31 1.01
          D1900-25   26AUG85 0.26 0.03  0.01 3.89 4.19
          D1900-60   27AUG85 0.73 0.07  0.06 0.09 0.95
          D3200-60   27AUG85 0.46 0.07  0.02 0.01 0.56
          D3350-25   26AUG85 0.57 0.02  0.05 0.05 0.69
          D6700-25   26AUG85 0.87 0.01  0.03 0.02 0.93
          D6700-60   27AUG85 0.69 0.07  0.03 0.01 0.8
          D700-25    26AUG85 0.48 0.19  0.53 0.62 1.82
          D700-60    27AUG85 0.25 0.09  0.07 0.01 0.42
          run;



CA88AIR.SAS

     Air quality data was collected from three monitoring sites in California during
     1988.  The monthly averages for temperature (TEM), humidity (HUM), nitrate
     (NO3), sulfate (SO4), ozone (O3), and carbon monoxide (CO) concentrations are
     recorded.


          *************************************************;
          * ca88air.sas
          *
          * create the SAS data set CA88AIR;
          *************************************************;

          data vol1.ca88air;
          input @1  O3
                @6  CO
                @11 NO3
                @17 SO4
                @22 TEM
                @28 HUM
                @34 DATE
                @40 STATION $3.
                @44 MONTH
           ;

          format date date7.;
          cards;
          1.58 1.35 10.96 3.18 54.9  59.5  10241 AZU 1
          2.77 1.25 12.73 2.96 60.2  58.5  10272 AZU 2
          3.59 1.26 15.5  6.11 62.8  58    10301 AZU 3
          3.48 1.05 15.01 4.69 63.4  72.75 10332 AZU 4
          4.53 0.95 19.69 6.06 67.6  70    10362 AZU 5
          3.8  0.93 17.48 7.68 69    74.75 10393 AZU 6
          4.84 0.97 19.32 9.41 76.5  79.5  10423 AZU 7
          4.33 1.3  18.06 8.84 74.5  78.75 10454 AZU 8
          3.95 1.46 17.36 7.95 72.9  75.75 10485 AZU 9
          3.18 1.76 22.81 8.93 70.1  76.25 10515 AZU 10
          2.18 1.71 14.22 5.59 60    70.75 10546 AZU 11
          1.9  0.99 8.7   2.58 54.6  56.5  10576 AZU 12
          0.78 1.36 5     2.78 51.9  .     10241 LIV 1
          0.89 1.28 8.13  3.7  56.5  .     10272 LIV 2
          1.64 0.98 3.58  3.63 59.1  .     10301 LIV 3
          2.89 0.94 3.28  3.28 59    .     10332 LIV 4
          2.75 0.89 2.6   2.6  59.9  .     10362 LIV 5
          2.56 0.84 2.95  2.71 62.7  .     10393 LIV 6
          2.66 0.88 3.74  3.72 65.1  .     10423 LIV 7
          2.34 0.88 4.63  3.59 65.41 .     10454 LIV 8
          2.7  1.06 4.18  3.9  62.1  .     10485 LIV 9
          1.88 1.14 6.03  3.99 59.6  .     10515 LIV 10
          1.31 1.08 1.94  2.38 54.5  .     10546 LIV 11
          1.28 1.45 4.85  2.38 49.8  .     10576 LIV 12
          1.28 2.44 4.34  4.25 50.6  77.75 10241 SFO 1
          1.38 2.58 4.6   5.98 54.5  70.75 10272 SFO 2
          1.6  2.05 1.56  4.83 56.5  68    10301 SFO 3
          2.39 1.76 1.93  4.84 58.1  68    10332 SFO 4
          2.35 1.58 1.82  3.5  59.5  69.5  10362 SFO 5
          1.79 1.6  1.2   4.11 62.5  70    10393 SFO 6
          1.65 1.85 4.25  4.31 65.3  72.75 10423 SFO 7
          1.58 1.64 1.84  4.63 65    72.75 10454 SFO 8
          1.83 2.01 3.08  5.03 63.1  75.25 10485 SFO 9
          1.62 2.14 1.81  4.58 61.4  80.25 10515 SFO 10
          1.43 2.02 1.33  4.11 56.5  78    10546 SFO 11
          0.9  2.21 8.23  6.33 50.4  74.75 10576 SFO 12
          run;




DOW.SAS

     These data are taken from the PC Version 6.04 SAS Sample Library (with the
     alteration of one value).  The data represent the high, low, and closing values of
     the Dow Jones Stock Market Index during the month of August 1981.

          *************************************************;
          * dow.sas;
          *
          * create the data set of high, low, and closing
          * stock market volume in thousands of shares.
          *************************************************;

                    * this data is adapted from an example in the SAS Sample
          * Library;
          *******************************************************;
          *          S A S   S A M P L E   L I B R A R Y
          *    NAME: TIMEPLT1
          *   TITLE: STOCK MARKET REPORTING USING PROC TIMEPLOT
          *******************************************************;

          data vol1.dow;
          input date date7. volume high low close;
          label volume='volume in thousands of shares';
          format date date7.;
          cards;
          03AUG81 3219.3 955.48 940.45 946.25
          04AUG81 2938.5 951.39 937.40 945.97
          05AUG81 4177.8 958.81 942.16 953.58
          06AUG81 3975.7 961.47 947.30 892.91
          07AUG81 3884.3 954.15 938.45 942.54
          10AUG81 2937.7 948.82 935.88 943.68
          11AUG81 5262.9 955.48 939.50 949.30
          12AUG81 4005.2 955.86 942.26 945.21
          13AUG81 3680.8 952.91 938.55 944.35
          14AUG81 3714.1 947.77 933.79 936.93
          17AUG81 3432.7 939.40 924.37 926.75
          18AUG81 4396.7 932.74 916.38 924.37
          19AUG81 3517.3 932.08 918.38 926.46
          20AUG81 3811.9 935.31 923.52 928.37
          21AUG81 2625.9 930.65 917.14 920.57
          24AUG81 4736.1 917.43 896.97 900.11
          25AUG81 4714.4 904.30 887.46 901.83
          26AUG81 3279.6 908.39 893.65 899.26
          27AUG81 3676.1 900.49 883.66 889.08
          28AUG81 3024.2 898.78 884.80 892.22
          ;
          run;




H2OQUAL.SAS

     Water quality data was collected during the first six months of 1993 from a
     shallow lagoon on the southern California coast.  Physical parameters collected
     include water depth, temperature, pH, dissolved oxygen, conductivity, and
     salinity.  Only two stations and one sample time per sample date are included in
     this data set.


          *************************************************;
          * h2oqual.sas;
          *
          * 1993 Water quality data.
          *************************************************;

                    data vol1.h2oqual
              (keep=datetime station depth temp ph do cond salinity);
          input datetime datetime13. @15 station $3.
                depth temp ph do cond salinity;
          label datetime = 'date and time of sample collection'
                station  = 'station'
                depth    = 'water depth (ft)'
                temp     = 'temperature (C)'
                ph       = 'pH'
                do       = 'dissolved oxygen'
                cond     = 'conductivity'
                salinity = 'salinity';
          format datetime datetime13.;
          cards;
          06FEB93:09:15 TS3 0 13.6 7.9 8.8 20.3 12.1
          06FEB93:09:15 TS3 1 13.5 7.9 8.7 20.4 12.2
          06FEB93:09:15 TS3 2 13.5 7.88 8.7 22.1 13.3
          06FEB93:09:15 TS3 3 14.1 8.05 9 46.2 29.9
          06FEB93:09:15 TS3 4 14.2 8.05 8.9 48.1 31.3
          10FEB93:11:51 TS3 0 13.9 7.91 9.5 0.57 0.27
          10FEB93:11:51 TS3 1 13.9 7.89 9.5 0.57 0.27
          10FEB93:11:51 TS3 2 13.9 7.88 9.4 0.57 0.27
          10FEB93:11:51 TS3 3 13.8 7.88 9.5 0.57 0.27
          10FEB93:11:51 TS3 4 13.8 7.87 9.4 0.56 0.27

               .................
               Not all of the data are included in this appendix
               .................

          04JUN93:07:20 TS6 0 18.8 8.05 3.6 52.2 34.4
          04JUN93:07:20 TS6 1 18.7 8.05 3.6 52.7 34.7
          04JUN93:07:20 TS6 2 18.8 8.04 3.5 51.6 33.9
          04JUN93:07:20 TS6 3 18.8 8.04 3.4 51.6 33.9
          11JUN93:11:42 TS6 0 26.2 8.1 6.3 53 34.9
          11JUN93:11:42 TS6 1 26.1 8.1 6.2 53 34.9
          11JUN93:11:42 TS6 2 26.1 8.08 6 52.9 34.9
          11JUN93:11:42 TS6 3 26.1 8.08 6 53 34.9
          16JUN93:15:00 TS6 0 25.9 8.11 8.3 51.6 33.9
          16JUN93:15:00 TS6 2 25.8 8.12 8.3 51.3 33.7
          16JUN93:15:00 TS6 4 25.6 8.12 8.2 52.1 34.3
          run;






LAMPARA.SAS

     A Lampara net is used in ocean fishing in coastal waters.  For this study, it was
     used to collect data for a number of species over a 12-year period.  The data
     contained here represent the LENGTH and SEX data for one species collected
     during the summer of 1986.

          *************************************************;
          * lampara.sas;
          *
          * Create the White Croaker Lampara net length data.
          *************************************************;

          data vol1.lampara;

          input @1 DATE DATE8.
                @10 LENGTH 3.
                @14 SEX $1.
          ;

          format date date7.;

          label date   = 'sample date'
                length = 'fish length in mm'
                sex    = 'fish sex (F, M, U)';

          cards;
           13MAY86 149 F
           13MAY86 180 M
           13MAY86 174 M
           22MAY86 131 M
           22MAY86 114 M

               .................
               Not all of the data are included in this appendix
               .................

           13AUG86 142 M
           13AUG86 135 M
           13AUG86 142 U
           13AUG86 141 U
          ;
          run;





SALESMAP.SAS

     Sales data for a national travel agency are compiled by state.  The variable
     CODE is used to indicate business share (CODE=1 indicates the greatest
     business activity).


          *************************************************;
          * salesmap.sas;
          *
          * Create a map of sales levels in the U.S.
          *************************************************;

                    data vol1.salesmap;
          input stcode $2. state 3. code 3. ;

          label stcode = 'State code'
                state  = 'state number'
                code   = 'Sales level';

          cards;
          AL 1   2   ALABAMA
          AK 2   4   ALASKA
          AZ 4   1   ARIZONA
          AR 5   6   ARKANSAS
          CA 6   1   CALIFORNIA
          CO 8   1   COLORADO
          CT 9   4   CONNECTICUT
          DE 10  5   DELAWARE
          DC 11  3   DISTRICT OF COLUMBIA
          FL 12  1   FLORIDA
          GA 13  1   GEORGIA
          HI 15  1   HAWAII
          ID 16  3   IDAHO
          IL 17  2   ILLINOIS
          IN 18  2   INDIANA
          IA 19  4   IOWA
          KS 20  1   KANSAS
          KY 21  2   KENTUCKY
          LA 22  1   LOUISIANA
          ME 23  1   MAINE
          MD 24  3   MARYLAND
          MA 25  4   MASSACHUSETTS
          MI 26  4   MICHIGAN
          MN 27  6   MINNESOTA
          MS 28  2   MISSISSIPPI
          MO 29  2   MISSOURI
          MT 30  3   MONTANA
          NE 31  4   NEBRASKA
          NV 32  1   NEVADA
          NH 33  1   NEW HAMPSHIRE
          NJ 34  4   NEW JERSEY
          NM 35  2   NEW MEXICO
          NY 36  2   NEW YORK
          NC 37  4   NORTH CAROLINA
          ND 38  6   NORTH DAKOTA
          OH 39  6   OHIO
          OK 40  2   OKLAHOMA
          OR 41  3   OREGON
          PA 42  2   PENNSYLVANIA
          RI 44  6   RHODE ISLAND
          SC 45  6   SOUTH CAROLINA
          SD 46  4   SOUTH DAKOTA
          TN 47  1   TENNESSEE
          TX 48  1   TEXAS
          UT 49  1   UTAH
          VT 50  1   VERMONT
          VA 51  3   VIRGINIA
          WA 53  3   WASHINGTON
          WV 54  6   WEST VIRGINIA
          WI 55  6   WISCONSIN
          WY 56  1   WYOMING
          run;



*************************************************;
* setup.sas;
*
* Setup the libnames etc. for vol1 stuff;
*************************************************;

***********
* define the libname for path to the data sets;
libname vol1 'c:\author\visualiz\volume1\data';

***********
* define global options;
options nodate nonumber;
GOPTIONS BORDER NOCHARACTERS NOFILL NOCELL;

***********
* define the path to the HPGL files;
%let pathhpg = \author\visualiz\volume1\hpg;


*************************************************;
* e1_4_1.sas;
*
* Demonstrate the use of PROC GTESTIT;
*************************************************;

FILENAME fileref "&pathhpg\e1_4_1.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;

proc gtestit pic=1;
run;
*************************************************;
* e1_4_2.sas;
*
* Demonstrate the use of HPOS and VPOS;
*************************************************;

FILENAME fileref "&pathhpg\e1_4_2.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;

goptions hpos=50 vpos=20;

proc gtestit pic=1;
run;
*************************************************;
* e1_4_3.sas;
*
* Demonstrate the use of the ASPECT goption;
*************************************************;

FILENAME fileref "&pathhpg\e1_4_3.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;

goptions aspect=.2;

proc gslide;
title1 h=4 j=c f=duplex 'Demonstrate the use of the ASPECT goption';
note   h=4 j=c f=simplex 'ASPECT = .2';
footnote1 j=l h=2 f=simplex 'Figure 1.4.3';
run;
*************************************************;
* e1_4_3a.sas;
*
* Creating a block chart;
*************************************************;

FILENAME fileref "&pathhpg\e1_4_3a.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;

proc gchart data=vol1.ca88air;
title1 h=4 'Block Chart of Average Carbon Monxide';
footnote j=l h=4 f=simplex 'Figure 1.4.3a';
block month / sumvar=co type=mean
              group=station discrete;
run;
*************************************************;
* e1_4_3b.sas;
*
* Increasing VPOS and HPOS to fit a block chart;
*************************************************;

FILENAME fileref "&pathhpg\e1_4_3b.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;
goptions vpos=80 hpos=200 htext=2;

proc gchart data=vol1.ca88air;
title1 h=4 'Block Chart of Average Carbon Monoxide';
footnote j=l h=4 f=simplex 'Figure 1.4.3b';
block month / sumvar=co type=mean
              group=station discrete;
run;
*************************************************;
* e1_4_4.sas;
*
* Demonstrate the use of the TARGETDEVICE goption;
*************************************************;

FILENAME fileref "&pathhpg\e1_4_4.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt
         targetdevice=win;
proc gtestit pic=1;
run;
quit;
*************************************************;
* e2_2.sas;
*
* Demonstrate the use of PROC UNIVARIATE;
*************************************************;

proc univariate data=vol1.h2oqual plot;
var temp;
title1 'Water Temperature';
footnote1 j=l 'Figure 2.2';
run;
*************************************************;
* e2_3.sas;
*
* Demonstrate the use of PROC PLOT;
*************************************************;

proc plot data=vol1.ca88air;
plot o3 * month;
title1 '1988 Air Quality Data - Ozone';
footnote 'Figure 2.3';
run;
*************************************************;
* e2_3_1.sas;
*
* Demonstrate the use of PROC PLOT axis control;
*************************************************;

proc plot data=vol1.ca88air;
plot o3 * month / vaxis= 0 to 5 by 1 vexpand vref=4;
title1 '1988 Air Quality Data - Ozone';
footnote1 'Figure 2.3.1';
run;
*************************************************;
* e2_3_2a.sas;
*
* Demonstrate the use of PROC PLOT overlay;
*************************************************;

proc plot data=vol1.ca88air;
plot o3 * month = station;
footnote1 'Figure 2.3.2a';
title1 '1988 Air Quality Data - Ozone';
run;
*************************************************;
* e2_3_2b.sas;
*
* Demonstrate the use of PROC PLOT overlay;
*************************************************;

proc plot data=vol1.ca88air;
plot o3 * month = 'O' co * month = 'C' / overlay;
where station='SFO';
footnote1 'Figure 2.3.2b';
title1 '1988 Air Quality Data - SFO';
run;
*************************************************;
* e2_3_3.sas;
*
* Place multiple plots per page;
*************************************************;

options linesize=110 pagesize=50;

proc plot data=vol1.biomass hpercent=33 vpercent=33;
plot bmcrus * bmcrus / vaxis= 0 to 2 by 1 haxis= 0 to 2 by 1;
plot bmcrus * bmmol  / vaxis= 0 to 2 by 1 haxis= 0 to 2 by 1;
plot bmcrus * bmpoly / vaxis= 0 to 2 by 1 haxis= 0 to 2 by 1;
plot bmmol  * bmcrus / vaxis= 0 to 2 by 1 haxis= 0 to 2 by 1;
plot bmmol  * bmmol  / vaxis= 0 to 2 by 1 haxis= 0 to 2 by 1;
plot bmmol  * bmpoly / vaxis= 0 to 2 by 1 haxis= 0 to 2 by 1;
plot bmpoly * bmcrus / vaxis= 0 to 2 by 1 haxis= 0 to 2 by 1;
plot bmpoly * bmmol  / vaxis= 0 to 2 by 1 haxis= 0 to 2 by 1;
plot bmpoly * bmpoly / vaxis= 0 to 2 by 1 haxis= 0 to 2 by 1;

footnote1 'Figure 2.3.3';
title1 'Biomass in GM Wet Weight';
run;
*************************************************;
* e2_4a.sas;
*
* Use PROC TIMEPLOT to explore the data;
*************************************************;

options ps=50;

proc timeplot data=vol1.dow;
plot low close high/overlay hiloc ref=mean(low);
id date volume;
format volume 6.1 high low close 6.2;
title1 'PROC TIMEPLOT';
footnote1 'Figure 2.4a';
run;
*************************************************;
* e2_4b.sas;
*
* Use PROC TIMEPLOT to explore the data;
*************************************************;

options ps=50;

proc timeplot data=vol1.biomass;
plot bmpoly='P' bmcrus='C' /overlay;
where '01aug85'd le date le '31aug85'd;
id date station;
title1 'PROC TIMEPLOT Biomass Data';
footnote1 'Figure 2.4b';
run;
*************************************************;
* e2_5.sas
*
* Create scatter plot prior to the use of PROC REG.
*************************************************;

proc plot data=vol1.h2oqual;
by station;
where depth=0 & station='TS6';
plot ph  * do  ;
title1 'Scatter plot prior to PROC REG';
footnote1 'Figure 2.5';
run;
*************************************************;
* e2_5_1.sas
*
* Using PROC REG to display relationships.
*************************************************;
proc reg data=vol1.h2oqual;
by station;
where depth=0 & station='TS6';
id datetime;
model ph = do / influence;
plot ph * do;
title1 'Regression of pH and dissolved oxygen';
footnote1 'Figure 2.5.1';
run;
*************************************************;
* e2_5_2.sas
*
* Using PROC REG to display relationships.
* PAINT statement.
*************************************************;

proc reg data=vol1.h2oqual;
by station;
where depth=0 & station='TS6';
id datetime;
model ph = do / influence;
paint datetime = '01apr93:13:40:0'dt;
plot ph * do;
title1 'Regression of pH and dissolved oxygen';
title2 'Paint sample taken 01Apr93 at 13:40';
footnote1 'Figure 2.5.2';
run;
*************************************************;
* e2_5_3.sas
*
* Using PROC REG to display relationships.
* REWEIGHT statement.
*************************************************;

proc reg data=vol1.h2oqual;
by station;
where depth=0 & station='TS6';
id datetime;
model ph = do / influence;
reweight datetime = '01apr93:13:40:0'dt;
plot ph * do;
title1 'Regression of pH and dissolved oxygen';
title2 'Reweight the sample taken 01Apr93 at 13:40';
footnote1 'Figure 2.5.3';
run;
*************************************************;
* e3_2_1.sas;
*
* Demonstrate machine fonts and their control;
*************************************************;

FILENAME fileref "&pathhpg\e3_2_1.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;

proc gslide;
title1 'Figure 3.2.1  title1 defaults: h=2 f=swiss';
title4 h=2 f=none     'title4 with h=2 & f=none     (hardware font)';
title5 h=2 f=simplex  'title5 with h=2 & f=simplex  (Software font)';
run;
quit;
*************************************************;
* e3_2_2.sas;
*
* Demonstrate title options (color, font, and height);
*************************************************;

FILENAME fileref "&pathhpg\e3_2_2.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;

proc gslide;
title1 'Figure 3.2.2';
title2 h=3 font=swissb 'swissb' color=red f=cartog 'J K L M N';
title3 h=1 f=simplex 'H1' h=2 'H2' h=4 'H4';
run;
*************************************************;
* e3_2_3.sas;
*
* Using the JUSTIFY= option to split a title;
*************************************************;

FILENAME fileref "&pathhpg\e3_2_3.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;

proc gslide;
title1 h=1.5 justify=left 'Figure 3.2.3'
       justify=l    'second line on left which is a long segment'
       j=l          'third line on title1'
       j=center     'fourth center top'
       j=c          'fifth in conflict with second'
       j=right      'sixth top right';
title2 'This is the second title';
run;
*************************************************;
* e3_2_4a.sas;
*
* Use of the ANGLE= title option;
*************************************************;

FILENAME filerefa "&pathhpg\e3_2_4a.hpg";
GOPTIONS GSFNAME=filerefa DEVICE=hp7475a GSFMODE=replace noprompt;

goptions htext=2;
proc gplot data=vol1.ca88air;
plot o3 * month;
title1 '1988 Air Quality Data - Ozone';
title2 angle=90 'OZONE levels at three locations';
title3 angle=90 ' ';
footnote1 angle=-90 rotate=90 'Figure 3.2.4a';
run;
*************************************************;
* e3_2_4b.sas;
*
* Use of the ANGLE= title option;
*************************************************;

FILENAME filerefb "&pathhpg\e3_2_4b.hpg";
GOPTIONS GSFNAME=filerefb DEVICE=hp7475a GSFMODE=replace noprompt;

goptions htext=2;
axis1 label = (f=simplex angle=90 ' '
               j=c angle=90 'Ozone levels at three locations'
               j=c angle=-90 rotate=90 'Figure 3.2.4b' );


proc gplot data=vol1.ca88air;
plot o3 * month / vaxis=axis1;
title1 '1988 Air Quality Data - Ozone';
footnote1 ;
run;
*************************************************;
* e3_2_5.sas;
*
* Create a subscript and a superscript in a title;
*************************************************;

FILENAME fileref "&pathhpg\e3_2_5.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;

proc gslide;
title1 'Figure 3.2.5';
title2 f=duplex
       h=6 'Volume is m'
       h=4 move=(+0,+2) '3'
       h=6 move=(+0,-2) 'of H'
       h=4 move=(+0,-2) '2'
       h=6 move=(+0,+2) 'O';

run;
*************************************************;
* e3_2_6.sas;
*
* Inserting BY values into text;
*************************************************;

FILENAME fileref  "&pathhpg\e3_2_6.hpg";
GOPTIONS GSFNAME=fileref  DEVICE=hp7475a GSFMODE=replace noprompt;
options nobyline;

goptions htext=2;
proc gplot data=vol1.ca88air nocache;
by station;
plot o3 * month;
title1 '1988 Air Quality Data - Ozone';
title2 h=2 f=simplex 'Plots separated by #byvar1';
title3 h=2 f=simplex 'OZONE levels at #byval(station)';
footnote1 j=l h=2 f=simplex 'Figure 3.2.6';
run;
*************************************************;
* e3_3_1a.sas;
*
* Use the LOGSTYLE=EXPAND option in the AXIS statement.
*************************************************;

FILENAME fileref "&pathhpg\e3_3_1a.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;
goptions htext=1.5;

data logdata;
do x = -1 to 3 by .1;
  y= 10 ** x;
  output;
end;

axis1 logstyle=expand logbase=10;

proc gplot data=logdata;
plot y * x;
plot y * x / vaxis=axis1;
symbol1 v=none i=join l=1;
title1 'Y = 10' move=(+0,+.5) 'X';
footnote1 j=l h=2 'Figure 3.3.1a';
run;
quit;
*************************************************;
* e3_3_1b.sas;
*
* Create log graph paper using LOGSTYLE and LOGEXPAND.
*************************************************;

FILENAME fileref "&pathhpg\e3_3_1b.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;
goptions htext=2;

* define the base as a macro variable;
%let base = 10;
%let min = -1;
%let max = 2;

* create a set of points to plot;
* the variables min and max define the range of the Y axis;
data logdata;
* loop defines major ticks;
do power = &min to &max by 1;
  y= &base ** power;
  linetype=1;             * major ticks get solid line;
  h=1; output;            * define the left and right;
  h=2; output;            * points for each horizontal line;
  h=.; output;            * missing value breaks line;
  linetype=2;             * minor ticks get dashed line;
  hold=y;
  do j = 2 to 9;          * loop defines minor ticks;
     y=hold*j;
     h=1; output;
     h=2; output;
     h=.; output;
  end;
end;
run;

* horizontal axis statement;
axis1 minor = (n=4 h=1)
      label = none
      major = (n=6 h=1.5)
      value = none;

* vertical axis statement;
* note n=8 for minor ticks (not 9);
axis2 logstyle=expand logbase=&base
      minor = (n=8 h=1)
      major = (h=1.5)
      value = (f=simplex h=1.5)
      label = none;

proc gplot data=logdata ;
plot y * h = linetype / skipmiss
                        nolegend
                        haxis=axis1
                        vaxis=axis2
                        href=1.0 1.2 1.4 1.6 1.8 2.0;
symbol1 v=none i=join l=1 c=black;
symbol2 v=none i=join l=2 c=black;
title1 "Log Paper (Base &base)";
footnote1 j=l h=1.5 f=simplex 'Figure 3.3.1b';
run;
quit;
*************************************************;
* e3_3_1c.sas;
*
* Plot crustacean biomass using log scales.
*************************************************;

FILENAME fileref "&pathhpg\e3_3_1c.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;
goptions htext=2;

* define the base as a macro variable;
%let base = 10;
%let min = -2;
%let max = 1;

data bio (keep=date bmcrus linetype)
     minmax (keep=mindate maxdate);
set vol1.biomass (keep=date bmcrus station) end=eof;
retain mindate 999999 maxdate 0 linetype 3;
where station='D3350-25';
output bio;
mindate = min(mindate, date);
maxdate = max(maxdate, date);
if eof then output minmax;
run;

* create a set of points to plot;
* the variables min and max define the range of the Y axis;
data logdata;
set minmax;
* loop defines major ticks;
do power = &min to &max by 1;
  y= &base ** power;
  linetype=1;             * major ticks get solid line;
  date=mindate; output;            * define the left and right;
  date=maxdate; output;            * points for each horizontal line;
  date=.;       output;            * missing value breaks line;
  linetype=2;             * minor ticks get dashed line;
  hold=y;
  do j = 2 to 9;          * loop defines minor ticks;
     y=hold*j;
     date=mindate; output;
     date=maxdate; output;
     date=.; output;
  end;
end;
run;

data pltdata;
set logdata (rename=(y=bmcrus)) bio;
run;

* vertical axis statement;
* note n=8 for minor ticks (not 9);
axis1 logstyle=expand logbase=&base
      minor = (n=8 h=1)
      major = (h=1.5)
      value = (f=simplex h=1.5)
      label = none;

axis2 value = (f=simplex h=1.5);

proc gplot data=pltdata ;
plot bmcrus * date = linetype / skipmiss
                        nolegend
                        vaxis=axis1
                        haxis=axis2;
symbol1 v=none i=join l=1 c=black;
symbol2 v=none i=join l=2 c=black;
symbol3 v=dot  i=join l=1 c=black;
title1 "Crustacean Biomass";
footnote1 j=l h=1.5 f=simplex 'Figure 3.3.1c';
run;
quit;
*************************************************;
* e3_3_2.sas;
*
* Assigning tick mark text using VALUE=;
*************************************************;

FILENAME fileref "&pathhpg\e3_3_2.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;

* define the vertical axis ;
axis1 label = (f=duplex h=1 a=90 'Ozone Level')
      order = (0 to 3 by 1)
      minor = (n=1)
      value = (t=3 h=1 'Alert');

* define the horizontal axis ;
axis2 label = (f=duplex h=1 'Monthly Average')
      minor = none
      value = (h=1.5 f=simplex t=1 'Jan'  t=2  'Feb' t=3  'Mar'
                               t=4 f=swissb 'Apr'
                               t=5 f=swissb 'May'
                               t=6  'Jun' t=7  'Jul' t=8  'Aug'
                               t=9  'Sep' t=10 'Oct' t=11 'Nov'
                               t=12 'Dec');


proc gplot data=vol1.ca88air;
where station='SFO';
plot o3 * month / vaxis=axis1
                  haxis=axis2
                  vref=2;
title1 '1988 Air Quality';
title2 h=1.5 f=simplex 'Assigning tick mark text';
footnote1 h=1.5 j=l f=simplex 'Figure 3.3.2';
run;
*************************************************;
* e3_3_3a.sas;
*
* Plotting using dates;
*************************************************;

FILENAME filerefa "&pathhpg\e3_3_3a.hpg";
GOPTIONS GSFNAME=filerefa DEVICE=hp7475a GSFMODE=replace noprompt;
goptions htext=1.5;

axis1 label=(h=1.5 a=90 'Volume (X1000)');

proc gplot data=vol1.dow;
plot volume*date=1 / vaxis=axis1;
symbol1 v='V' f=simplex l=1 i=join c=black;
format date 6.;
title1 'Stock Market Analysis of the Dow';
title2 h=2 f=simplex 'Daily Volume';
footnote1 j=l h=1.5 f=simplex 'Figure 3.3.3a';
run;
quit;
*************************************************;
* e3_3_3b.sas;
*
* Plotting using dates;
*************************************************;

FILENAME filerefb "&pathhpg\e3_3_3b.hpg";
GOPTIONS GSFNAME=filerefb DEVICE=hp7475a GSFMODE=replace noprompt;
goptions htext=1.5;

axis1 label=(h=1.5 a=90 'Volume (X1000)');

proc gplot data=vol1.dow;
plot volume*date=1 / vaxis=axis1;
symbol1 v='V' f=simplex l=1 i=join c=black;
format date date7.;
title1 'Stock Market Analysis of the Dow';
title2 h=2 f=simplex 'Daily Volume';
footnote1 j=l h=1.5 f=simplex 'Figure 3.3.3b';
run;
quit;
*************************************************;
* e3_3_3c.sas;
*
* Plotting using dates and the ORDER= option.
*************************************************;

FILENAME filerefc "&pathhpg\e3_3_3c.hpg";
GOPTIONS GSFNAME=filerefc DEVICE=hp7475a GSFMODE=replace noprompt;
goptions htext=1.5;

axis1 label=(h=1.5 a=90 f=swiss 'V' f=simplex 'olume (X1000)');
axis2 order=('03aug81'd to '31aug81'd by week)
      value=(h=1.5);

proc gplot data=vol1.dow;
plot volume*date=1 / vaxis=axis1 haxis=axis2;
symbol1 v='V' f=simplex l=1 i=join c=black;
format date date7.;
title1 'Stock Market Analysis of the Dow';
title2 h=2 f=simplex 'Daily Volume';
note move=(20,30)pct 'Volumes';

footnote1 j=l h=1.5 f=simplex 'Figure 3.3.3c';
run;
quit;
*************************************************;
* e3_4_1a.sas;
*
* Legend without a LEGEND Statement.
*************************************************;

FILENAME filerefa "&pathhpg\e3_4_1a.hpg";
GOPTIONS GSFNAME=filerefa DEVICE=hp7475a GSFMODE=replace noprompt;
goptions htext=2;

axis1 order=('01jun85'd to '01sep85'd by month)
      value=(f=simplex h=1.5);

axis2 label= (h=1.5 a=90 'gm Wet Weight')
      value=(f=simplex h=1.5);

proc gplot data=vol1.biomass;
plot bmtotl * date = station / haxis = axis1 vaxis=axis2;
where station in ('DL-25', 'DL-60', 'D700-25', 'D700-60') ;
symbol1 v=dot    i=join l=1  c=black;
symbol2 v=dot    i=join l=2  c=black;
symbol3 v=circle i=join l=1  c=black;
symbol4 v=circle i=join l=2  c=black;
title1 'Total Biomass at DL and D700';
title3 h=1.5 f=simplex 'Samples taken at 25 and 60 foot contours';
footnote1 j=l h=1.5 'Figure 3.4.1a';
run;
quit;
*************************************************;
* e3_4_1b.sas;
*
* Positioning a Legend.
*************************************************;

FILENAME filerefb "&pathhpg\e3_4_1b.hpg";
GOPTIONS GSFNAME=filerefb DEVICE=hp7475a GSFMODE=replace noprompt;

goptions htext=2;
axis1 order=('01jun85'd to '01sep85'd by month)
      value=(f=simplex h=1.5);

axis2 label= (h=1.5 a=90 'gm Wet Weight')
      value=(f=simplex h=1.5);

legend position=(center top)
       across=2
       label=none;

proc gplot data=vol1.biomass;
plot bmtotl * date = station / legend=legend1
                               haxis = axis1 vaxis=axis2;
where station in ('DL-25', 'DL-60', 'D700-25', 'D700-60') ;
symbol1 v=dot    i=join l=1  c=black;
symbol2 v=dot    i=join l=2  c=black;
symbol3 v=circle i=join l=1  c=black;
symbol4 v=circle i=join l=2  c=black;
title1 'Total Biomass at DL and D700';
title3 h=1.5 f=simplex 'Samples taken at 25 and 60 foot contours';
footnote1 j=l h=1.5 f=simplex 'Figure 3.4.1b';
run;
quit;
*************************************************;
* e3_4_1c.sas;
*
* Positioning a Legend using the ORIGIN option.
*************************************************;

FILENAME filerefc "&pathhpg\e3_4_1c.hpg";
GOPTIONS GSFNAME=filerefc DEVICE=hp7475a GSFMODE=replace noprompt;
goptions htext=2;

axis1 order=('01jun85'd to '01sep85'd by month)
      value=(f=simplex h=1.5);

axis2 label= (h=1.5 a=90 'gm Wet Weight')
      value=(f=simplex h=1.5);

legend origin=(10 pct, 65 pct)
       mode=share
       across=2
       label=none;

proc gplot data=vol1.biomass;
plot bmtotl * date = station / legend=legend1
                               haxis = axis1 vaxis=axis2;
where station in ('DL-25', 'DL-60', 'D700-25', 'D700-60') ;
symbol1 v=dot    i=join l=1  c=black;
symbol2 v=dot    i=join l=2  c=black;
symbol3 v=circle i=join l=1  c=black;
symbol4 v=circle i=join l=2  c=black;
title1 'Total Biomass at DL and D700';
title3 h=1.5 f=simplex 'Samples taken at 25 and 60 foot contours';
footnote1 j=l h=1.5 f=simplex 'Figure 3.4.1c';
run;
quit;
*************************************************;
* e3_4_2.sas;
*
* Using the VALUE option to change text.
*************************************************;

FILENAME fileref "&pathhpg\e3_4_2.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;
goptions htext=2;

axis1 order=('01jun85'd to '01sep85'd by month)
      value=(f=simplex h=1.5);

axis2 label= (h=1.5 a=90 'gm Wet Weight')
      value=(f=simplex h=1.5);

legend origin=(10 pct, 65 pct)
       mode=share
       across=1
       label=none
       value=(f=simplex h=1.2
              t=1 h=1.2 f=swissb 'D700 at 25 feet')
;

proc gplot data=vol1.biomass;
plot bmtotl * date = station / legend=legend1
                               haxis = axis1 vaxis=axis2;
where station in ('DL-25', 'DL-60', 'D700-25', 'D700-60') ;
symbol1 v=dot    i=join l=1  c=black;
symbol2 v=dot    i=join l=2  c=black;
symbol3 v=circle i=join l=1  c=black;
symbol4 v=circle i=join l=2  c=black;
title1 'Total Biomass at DL and D700';
title3 h=1.5 f=simplex 'Samples taken at 25 and 60 foot contours';
footnote1 j=l h=1.5 f=simplex 'Figure 3.4.2';
run;
quit;

*************************************************;
* e3_4_3.sas;
*
* Changing symbol size using the SHAPE option.
*************************************************;

FILENAME fileref "&pathhpg\e3_4_3.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;

goptions htext=2;

axis1 order=('01jun85'd to '01sep85'd by month)
      value=(f=simplex h=1.5);

axis2 label= (h=1.5 a=90 'gm Wet Weight')
      value=(f=simplex h=1.5);

legend origin=(10 pct, 65 pct)
       mode=share
       across=2
       label=none
       value=(f=simplex h=1.2)
       shape=symbol(8,2)
;

proc gplot data=vol1.biomass;
plot bmtotl * date = station / legend=legend1
                               haxis = axis1 vaxis=axis2;
where station in ('DL-25', 'DL-60', 'D700-25', 'D700-60') ;
symbol1 v=dot    i=join l=1  c=black;
symbol2 v=dot    i=join l=2  c=black;
symbol3 v=circle i=join l=1  c=black;
symbol4 v=circle i=join l=2  c=black;
title1 'Total Biomass at DL and D700';
title3 h=1.5 f=simplex 'Samples taken at 25 and 60 foot contours';
footnote1 j=l h=1.5 f=simplex 'Figure 3.4.3';
run;
quit;
*************************************************;
* e4_2.sas;
*
* Overlay two plots using GPLOT;
*************************************************;

FILENAME fileref "&pathhpg\e4_2.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;
goptions htext=2;

* create a cumulative probability distribution histogram of pH
* values using GPLOT and overlay it with a cumulative normal
* probability distribution curve with the same mean and variance.;

* create a summary data set containing the frequencies of pH;
data buckets; set vol1.h2oqual;
keep ph phround;
* round to the nearest tenth (bucket width);
phround = round(ph,.1);
run;

* collect summary statistics on the unrounded value,
* but count the frequency of the rounded value (nrnd);
proc summary data=buckets;
class phround;
var ph phround;
output out=freq n=n nrnd mean=mean std=std;
run;

* determine the expected value for each value of phround;
data pltdata;
set freq;
retain xbar s total .;
keep phround phcuml phnorm;
* the statistics for the distribution have _type_=0;
if _type_ = 0 then do;
   total = n;
   xbar = mean;
   s = std;
end;
else do;
   prph = nrnd/total;
   phcuml + prph;
   phnorm = probnorm((phround-xbar)/s);
   output;
end;

* plot the cumulative distributions;
proc gplot data=pltdata;
plot phcuml * phround = 1
     phnorm * phround = 2 / overlay
                            vaxis = 0 to 1 by .2
                            haxis = 7.5 to 10 by .5;
label phround = 'pH'
      phcuml  = 'Cumulative Probability';
symbol1 v=none i=stepcj l=1  c=black;
symbol2 v=none i=join   l=2  c=black;
title1 'Cumulative Probability Distribution for pH';
footnote1 j=l h=1.5 f=simplex 'Figure 4.2';
run;
quit;
*************************************************;
* e4_3_1a.sas;
*
* Display error bars using the INTERPOL symbol statement option.
*************************************************;

FILENAME filerefa "&pathhpg\e4_3_1a.hpg";
GOPTIONS GSFNAME=filerefa DEVICE=hp7475a GSFMODE=replace noprompt;

goptions htext=2;
proc gplot data=vol1.biomass;
plot bmtotl* date;
symbol1 v=none i=std2mj  c=black l=1;
title1 'Total Biomass';
title2 f=simplex '(using i=std2mj)';
footnote1 j=l h=1.5 f=simplex 'Figure 4.3.1a';
run;
quit;
*************************************************;
* e4_3_1b.sas;
*
* Display error bars using data manipulation.
*************************************************;

FILENAME filerefb "&pathhpg\e4_3_1b.hpg";
GOPTIONS GSFNAME=filerefb DEVICE=hp7475a GSFMODE=replace noprompt;
goptions htext=2;

proc sort data=vol1.biomass
          out=biosort;
by date;
run;

* determine the summary statistics;
proc summary data=biosort;
by date;
var bmtotl;
output out=stats mean=mean stderr=se;
run;

* create the observations to be plotted;
data all(keep=date biomass);
set stats;
* for each observation create four;
biomass=mean;       output;
biomass=mean+ 2*se; output;
biomass=mean- 2*se; output;
biomass=mean;       output;
run;

proc gplot data=all;
plot biomass * date;
symbol1 v=dot i=join  c=black l=1;
title1 'Total Biomass';
footnote1 j=l h=1.5 f=simplex 'Figure 4.3.1b';
run;
quit;
*************************************************;
* e4_3_2a.sas;
*
* Use PROC GCHART on the BIOMASS data;
*************************************************;

FILENAME filerefa "&pathhpg\e4_3_2a.hpg";
GOPTIONS GSFNAME=filerefa DEVICE=hp7475a GSFMODE=replace noprompt;
goptions htext=2;

proc gchart data=vol1.biomass;
vbar bmtotl;
title1 'Total Biomass Frequency';
title2 h=1.5 f=simplex 'No intervals specified';
footnote1 j=l h=1.5 f=simplex 'Figure 4.3.2a';
run;
quit;
*************************************************;
* e4_3_2b.sas;
*
* Use PROC GCHART selecting BMTOTL < 10;
*************************************************;

FILENAME filerefb "&pathhpg\e4_3_2b.hpg";
GOPTIONS GSFNAME=filerefb DEVICE=hp7475a GSFMODE=replace noprompt;
goptions htext=2;

* one observation has a large value of BMTOTL;
proc gchart data=vol1.biomass;
vbar bmtotl / midpoints = .5 to 6 by .5;
where bmtotl < 10;
title1 'Total Biomass Frequency';
title2 h=1.5 f=simplex 'Biomass < 10';
footnote1 j=l h=1.5 f=simplex 'Figure 4.3.2b';
run;
*************************************************;
* e4_3_2c.sas;
*
* Use PROC GCHART using midpoints;
*************************************************;

FILENAME filerefc "&pathhpg\e4_3_2c.hpg";
GOPTIONS GSFNAME=filerefc DEVICE=hp7475a GSFMODE=replace noprompt;
goptions htext=2;

axis1 value=(h=1.5 f=simplex);

axis2 value=(h=1.5 f=simplex)
      label=(h=1.5 f=simplex);

* one observation has a large value of BMTOTL;
proc gchart data=vol1.biomass;
vbar bmtotl / midpoints = .5 to 6 by .5, 30
              raxis=axis1
              maxis=axis2;
title1 'Total Biomass Frequency';
title2 h=1.5 f=simplex 'Using uneven midpoints';
footnote1 j=l h=1.5 f=simplex 'Figure 4.3.2c';
run;
quit;
*************************************************;
* e4_3_2d.sas;
*
* Use PROC PLOT to generate a histogram;
*************************************************;

libname gdevice0 "&pathhpg";

FILENAME filerefd "&pathhpg\e4_3_2d.cgm";
GOPTIONS GSFNAME=filerefd DEVICE=cgmwp6ca GSFMODE=replace noprompt;
goptions htext=2;

* Create a grouping format;
proc format;
value grp
   .5 = '<0.75 '
  1.0 = '1.0 '
  1.5 = '1.5 '
  2.0 = '2.0 '
  2.5 = '2.5 '
  3.0 = '3.0 '
  3.5 = '3.5 '
  4.0 = '4.0 '
  4.5 = '4.5 '
  5.0 = '5.0 '
  5.5 = '5.5 '
  6.0 = '6.0 '
  7.0 = '>6.25 '
  other = ' ';
run;

* Group the observations into buckets;
data group (keep=group bmtotl);
set vol1.biomass (keep=bmtotl);
group = round(bmtotl,.5);
* Combine 0-.25 with .25-.75;
if group=0 then group=.5;
* combine all groups > than 6.25 into one bucket;
group = min(7, group);
run;

proc sort data=group;
by group;
run;

* determine the observation count for each bucket;
proc summary data=group;
by group;
var group;
output out=count n=freq;
run;

* Create the data set used to plot
* PLTVAR is used to separate SYMBOLS and PATTERNS;
data plot(keep=freq group pltvar);
set count;
* Each point becomes four.
* Each bar is centered on the midpoint and has a width of .5;
tgroup = group;
tfreq = freq;
*Create a broken horizontal axis;
if _n_=1 then do;
   pltvar=1;
   freq=0.02;
           group=0;   output;
           group=6.4; output;
   pltvar=2;
           group=6.6; output;
           group=7.4; output;
end;
* separate the count in the largest group;
if tgroup le 6 then pltvar=3; else pltvar=4;
group = tgroup - .25; freq =     0 ; output;   *lower left corner;
                      freq =  tfreq; output;   *upper left corner;
group = tgroup + .25;                output;   *upper right corner;
                      freq =     0 ; output;   *lower right corner;
run;

* Axis and pattern control;
* Horizontal axis ;
axis1 order= 0 to 7.5 by .5
      style=0
      major=none
      minor=none
      label=(h=2 f=simplex)
      value=(h=1.5 f=simplex a=55)
      offset=(0cm);

* Vertical axis ;
axis2 offset=(0 cm)
      order=0 to 16 by 2
      value=(h=1.5 f=simplex)
      minor=none;

* define fill patterns (1 & 2 used for horiz. axis);
pattern1 v=me c=black;
pattern2 v=me c=black;
pattern3 v=me c=black;
pattern4 v=m1x45 c=black;

symbol1 i=join c=black l=1;
symbol2 i=join c=black l=1;
symbol3 i=join c=black l=1;
symbol4 i=join c=black l=2;

proc gplot data=plot;
plot freq*group=pltvar / areas=4
                         haxis=axis1
                         vaxis=axis2
                         nolegend;
format group grp5.;
label freq  = 'Frequency'
      group = 'grams wet weight';
title1 h=2.5 f=swiss 'Total Biomass Frequency';
title2 h=2 f=simplex 'Histogram with broken horizontal axis';
footnote1 j=l h=2 f=simplex 'Figure 4.3.2d';
run;
quit;
*************************************************;
* e4_3_3a.sas;
*
* Create multiple axes on one plot.
*************************************************;

 FILENAME filerefa "&pathhpg\e4_3_3a.hpg";
 GOPTIONS GSFNAME=filerefa DEVICE=hp7475a GSFMODE=replace noprompt;

goptions htext=2;
proc gplot data=vol1.ca88air;
plot co*month=station;
symbol1 v='A' l=1  i=join c=black;
symbol2 v='L' l=2  i=join c=black;
symbol3 v='S' l=14 i=join c=black;
title1 '1988 Carbon Monoxide Readings';
footnote1 j=l h=1.5 f=simplex 'Figure 4.3.3a';
run;
*************************************************;
* e4_3_3b.sas;
*
* Create multiple axes on one plot.
*************************************************;

FILENAME filerefb "&pathhpg\e4_3_3b.hpg";
GOPTIONS GSFNAME=filerefb DEVICE=hp7475a GSFMODE=replace noprompt;
goptions htext=2;

data air1 (keep=yvar month pltvar);
set vol1.ca88air(keep=month co station);
by station;
retain pltvar offset;

* hold the current value of month;
tmon = month;

* Create dummy axes for each station;
* Allow three vertical units for each axis with one unit between
* each plot.;
if _n_=1 then do;
   pltvar=1;
   * axis for SFO;
   yvar=0; month=12; output;
           month=0;  output;
   yvar=3;           output;
   yvar=.;           output;
   * axis for LIV;
   yvar=4; month=12; output;
           month=0;  output;
   yvar=7;           output;
   yvar=.;           output;
   * axis for AZU;
   yvar=8; month=12; output;
           month=0;  output;
   yvar=11;          output;
   yvar=.;           output;
   month=tmon;
end;

if first.station then do;
   * The data for each station is offset vertically to fit
   * with the dummy axes.;
   if station = 'AZU' then do;
      offset=8;
      pltvar=2;
   end;
   else if station = 'LIV' then do;
      offset=4;
      pltvar=3;
   end;
   else do;
      offset = 0;
      pltvar=4;
   end;
end;

yvar = co + offset;
output;
run;

* Control the vertical axis;
axis1 order = 0 to 11 by 1
      label = (h=1.5 f=simplex 'ppm')
      minor=none
      style=0;
* Control the horizontal axis;
axis2 minor=none
      style=0;

* Define the symbols for each subplot;
* SYMBOL1 controls the axes;
symbol1 v=none c=black l=1 i=join;
symbol2 v='A'  c=black l=1 i=join f=simplex;
symbol3 v='L'  c=black l=1 i=join f=simplex;
symbol4 v='S'  c=black l=1 i=join f=simplex;

* Define a format for the vertical axis;
proc format;
value vert 0,4,8  = '0'
           3,7,11 = '3'
           other  = ' ';
run;

* Plot the data;
proc gplot data=air1;
plot yvar*month=pltvar / nolegend
                         skipmiss
                         vaxis=axis1
                         haxis=axis2;
format yvar vert.;
title1 '1988 Carbon Monoxide Readings';
footnote1 j=l h=1.5 f=simplex 'Figure 4.3.3b';
run;
quit;
*************************************************;
* e4_3_3c.sas;
*
* Create multiple axes on one plot.
*************************************************;

goptions reset=all border htext=2;

FILENAME filerefc "&pathhpg\e4_3_3c.hpg";
GOPTIONS GSFNAME=filerefc DEVICE=hp7475a GSFMODE=replace noprompt;

* control the labels and values for both axes;
axis1 value=(h=1.5 f=simplex)
      label=(h=1.5 f=simplex);

* Plot the data;
proc gplot data=vol1.biomass;
where station = 'D700-60';
plot bmothr*date ='O'
     bmcrus*date ='C'
     bmpoly*date ='P' / overlay
                        vaxis=axis1 haxis=axis1;
symbol1 v='O' c=black f=swiss;
symbol2 v='C' c=black f=swiss;
symbol3 v='P' c=black f=swiss;
title1 'Biomass at D700-60';
title2 h=1.5 f=swiss 'C' f=simplex 'rustacean  '
             f=swiss 'P' f=simplex 'olychaete  '
             f=swiss 'O' f=simplex 'ther';
footnote1 j=l h=2 f=simplex 'Figure 4.3.3c';
run;
*************************************************;
* e4_3_3d.sas;
*
* Create multiple axes on one plot.
*************************************************;

FILENAME filerefd "&pathhpg\e4_3_3d.hpg";
GOPTIONS GSFNAME=filerefd DEVICE=hp7475a GSFMODE=replace noprompt;
goptions htext=2;

data bio1 (keep=yvar date  pltvar);
set vol1.biomass (keep=date station bmcrus bmpoly bmothr);
where station='D700-60';
retain pltvar;

* hold the current value of date ;
tdte = date ;

* Create dummy axes for each station;
* Allow three vertical units for each axis with one unit between
* each plot.;
if _n_=1 then do;
   pltvar=1;
   * axis for bmothr;
   yvar=0;    date='01sep85'd; output;
              date='15jun85'd; output;
   yvar=0.50;                  output;
   yvar=.;                     output;
   * axis for bmpoly;
   yvar=0.75; date='01sep85'd; output;
              date='15jun85'd; output;
   yvar=1.25;                  output;
   yvar=.;                     output;
   * axis for bmcrus;
   yvar=1.50; date='01sep85'd; output;
              date='15jun85'd; output;
   yvar=2.00;                  output;
   yvar=.;                     output;
   date=tdte;
end;

* The data for each taxa is offset vertically to fit
* with the dummy axes.;
* BMOTHR there is no offset;
   pltvar=2;
   yvar = bmothr;
   output;
* BMPOLY is placed in the middle axis ;
* the offset is .75;
   pltvar=3;
   yvar = bmpoly + .75;
   output;
* BMCRUS is placed in the upper axis;
* the offset is 1.50;
   pltvar=4;
   yvar = bmcrus + 1.50;
   output;
run;

* Control the vertical axis;
axis1 order = 0 to 2 by .25
      label = (h=1.5 f=simplex a=90 'gm wet weight')
      value=(h=1.5 f=simplex)
      minor=none
      major=none
      style=0;
* Control the horizontal axis;
axis2 minor=none
      order= '15jun85'd, '01jul85'd, '15jul85'd,
             '01aug85'd, '15aug85'd, '01sep85'd
      label=(h=1.5 f=simplex)
      value=(h=1.5 f=simplex)
      style=0;

* Define the symbols for each subplot;
* SYMBOL1 controls the axes;
symbol1 v=none c=black l=1 i=join f=;
symbol2 v='O'  c=black l=1 i=join f=swiss;
symbol3 v='P'  c=black l=1 i=join f=swiss;
symbol4 v='C'  c=black l=1 i=join f=swiss;

* Define a format for the vertical axis;
proc format;
value vert 0.0, 0.75, 1.5 = '0'
           0.5, 1.25, 2.0 = '.5'
           other  = ' ';
run;

* Plot the data;
proc gplot data=bio1;
plot yvar*date =pltvar / nolegend
                         skipmiss
                         vaxis=axis1
                         haxis=axis2;
format yvar vert.;
title1 'Biomass at D700-60';
title2 h=1.5 f=swiss 'C' f=simplex 'rustacean  '
             f=swiss 'P' f=simplex 'olychaete  '
             f=swiss 'O' f=simplex 'ther';
footnote1 j=l h=2 f=simplex 'Figure 4.3.3d';
run;
quit;
*************************************************;
* E4_3_3e.sas
*
* Specialized plot for concentration values.
*
*************************************************;
* define global options;
options nomtrace nosymbolgen nomprint;
goptions reset=all nopolygonclip nopclip nopolygonfill;
GOPTIONS BORDER NOCHARACTERS NOFILL NOCELL;
*************************************************;
FILENAME filerefe "&pathhpg\E4_3_3e.hpg";
GOPTIONS GSFNAME=filerefe DEVICE=hp7475a GSFMODE=replace noprompt;

*************************************************;
* generate the test data set;
data toplot;
input patient $3. @5 strdate $8. conc100 conc30 conc10 percd8 cd8_cd38;
cards;
50x 12/8/92  5.8  6.2 1.1 44 388
50x 2/15/93 19   10.7 2.9 43 387
50x 3/25/93  9.5  5.5 2   47 302
50x 4/15/93  7.9  2.1 2.9 48 467
;


%macro concplt(pervar, var, varstrg);
*************************************************;
* incoming data assumptions
*   - data set named TOPLOT
*   - variable are: patient code ($) - patient id
*                   strdate ($) - label for horiz. axis
*                   conc100, conc30, conc10 - scaled conc values
*                   &pervar - percent variable
*                   &var - variable value
*   - conc values are scaled to pervar
*   - data are sorted by patient id
*   - data are ordered within patient id
*   - all patients have the same number of data points
*;

* split the data, creating plot reference points;
data conc (keep=patient point ptorder
               ptype conc conc2 symnum symnum2);
set toplot;
by patient;
* the data point must be plotted in a specific order;
ptorder+1;
* point is used as the horizontal variable;
if first.patient then point=0;
point+1;
* create a macro var containing each date string;
ii = left(put(point,2.));
call symput('date'||ii,strdate);
* total number of points;
if last.patient then do;
   totpts = left(put(point,2.));
   call symput('totpts',totpts);
   axpts = left(put(point+1,2.));
   call symput('axpts',axpts);
end;

* output the line data (plotted by PLOT2);
* the variables symnum and symnum2 point to SYMBOL statements;
* ptype separates points to be plotted on PLOT or PLOT2;
conc = .; symnum=3; ptype='2';
symnum2=4; conc2 = &pervar*10; ptorder+1; output conc;
symnum2=5; conc2 = &var;       ptorder+1; output conc;

* create pseudo points for the histograms;
* histograms plotted using PLOT statement;
conc2 = .; symnum2=5; ptype='1';
holdpt = point;
* three vertical bars: conc100, conc30, and conc10;
* create the four corners of each of the three bars for each POINT;
* conc100;
symnum = 1;
point=holdpt-.375; conc=0;       ptorder+1; output conc;
                   conc=conc100; ptorder+1; output conc;
point=holdpt-.125;               ptorder+1; output conc;
                   conc=0;       ptorder+1; output conc;
* conc30;
symnum = 2;
point=holdpt-.125; conc=0;       ptorder+1; output conc;
                   conc=conc30;  ptorder+1; output conc;
point=holdpt+.125;               ptorder+1; output conc;
                   conc=0;       ptorder+1; output conc;
* conc10;
symnum = 3;
point=holdpt+.125; conc=0;       ptorder+1; output conc;
                   conc=conc10;  ptorder+1; output conc;
point=holdpt+.375;               ptorder+1; output conc;
                   conc=0;       ptorder+1; output conc;
point=holdpt;
run;

* data are sorted so that SYMBOLs are used at the correct time.;
proc sort data=conc;
by patient symnum symnum2 ptype ptorder;
run;

* gplot axis and legend statements;
axis1 major = none
      offset = (0,0)
      label = none
      minor = (n=1 h=1)
      value = (h=1 f=simplex angle=55  ' '
        %do i = 1 %to &totpts;
           "&&date&i"
        %end; ' ')
      order = (0 to &axpts by 1);

axis2 major = (h=1)
      offset = (0)
      label = (h=2.5 'CELL %')
      order = (0 to 100 by 10)
      minor = none;

axis3 major = (h=1)
      offset = (0)
      label = (h=1.5 'CELL COUNT')
      order = (0 to 1000 by 100)
      minor = none;

legend1 across=3
        position=(bottom center outside)
        label=none
        shape=bar(5,.8)
        value=('CONC. 100:1' 'CONC. 30:1' 'CONC. 10:1');

legend2 across=2
        position=(bottom center outside)
        label=none
        shape=symbol(5,.5)
        value=("% &varstrg" "&varstrg");

goption hby=0;
proc gplot data=conc;
by patient;
plot conc * point = symnum / areas=3
                             skipmiss
                             legend=legend1
                             vaxis=axis2
                             haxis=axis1;

plot2 conc2*point = symnum2/ vaxis=axis3
                             legend=legend2
                             skipmiss;

symbol1 v=none c=black i=join l=1;
symbol2 v=none c=black i=join l=1;
symbol3 v=none c=black i=join l=1;
symbol4 v='U'  c=black i=join l=1 f=marker  h=.5;
symbol5 v='U'  c=black i=join l=1 f=markere h=.5;

pattern1 v=solid c=black;
pattern2 v=m2x45 c=black;
pattern3 v=empty c=black;

label conc2 = 'CELL COUNT'
      conc  = 'COUNT %';
title1  f=duplex h=1.5 'Patient code #byval(patient)';
title2  f=simplex h=1.5 "&varstrg";
footnote h=1.5 j=l f=simplex 'Figure 4.3.3e';
run;
%mend concplt;

*************************************************;
%concplt(percd8, cd8_cd38, CD8+ CD38+)
*************************************************;
* e4_3_4a.sas;
*
* Create butterfly plots.
*************************************************;

FILENAME filerefa "&pathhpg\e4_3_4a.hpg";
GOPTIONS GSFNAME=filerefa DEVICE=hp7475a GSFMODE=replace noprompt;
goptions htext=2;

data air1 (keep=yvar month pltvar);
set vol1.ca88air(keep=month co station);
by station;
retain pltvar offset;

* hold the current value of month;
tmon = month;

* Create dummy axes for each station;
* Allow six vertical units for each axis with one unit between
* each plot.;
if _n_=1 then do;
   pltvar=0;
   * axis for SFO;
   yvar=0; month=0;  output;
   yvar=6;           output;
   yvar=3;           output;
           month=12; output;
   yvar=.;           output;
   * axis for LIV;
   yvar=7; month=0;  output;
   yvar=13;          output;
   yvar=10;          output;
           month=12; output;
   yvar=.;           output;
   * axis for AZU;
   yvar=14;month=0;  output;
   yvar=20;          output;
   yvar=17;          output;
           month=12; output;
   yvar=.;           output;
   month=tmon;
end;

if first.station then do;
   plt+1;
   * The data for each station is offset vertically to fit
   * with the dummy axes.;
   if station = 'AZU' then offset=17;
   else if station = 'LIV' then offset=10;
   else offset = 3;
end;

* Each butterfly plot is made up of three sets of lines
* with a common SYMBOL statement;
* Upper line;
pltvar = plt*3-2; yvar = offset + co; output;
* Lower line;
pltvar = plt*3-1; yvar = offset - co; output;
* Hilo line;
pltvar = plt*3  ; yvar = offset     ; output;
                  yvar = offset - co; output;
                  yvar = offset + co; output;
                  yvar = offset     ; output;

run;

* Control the vertical axis;
axis1 order = 0 to 20 by 1
      label = (h=1.5 f=simplex 'ppm')
      value = (h=1.2 f=simplex)
      minor=none
      style=0;
* Control the horizontal axis;
axis2 minor=none
      label = (h=1.5 f=simplex)
      value = (h=1.5 f=simplex);

* Define the symbols for each subplot;
* SYMBOL1 controls the axes;
symbol1 v=none c=black l=1 i=join r=10;

* Define a format for the vertical axis;
proc format;
value vert 0,7,14  = '3'
           6,13,20 = '3'
           3,10,17 = '0'
           4       = 'SFO'
           11      = 'LIV'
           18      = 'AZU'
           other   = ' ';
run;

* Plot the data;
proc gplot data=air1;
plot yvar*month=pltvar / nolegend
                         skipmiss
                         vaxis=axis1
                         haxis=axis2;
format yvar vert.;
title1 '1988 Carbon Monoxide Readings';
footnote1 j=l h=1.5 f=simplex 'Figure 4.3.4a';
run;
quit;
*************************************************;
* e4_3_4b.sas;
*
* Create butterfly plots.
*************************************************;

FILENAME filerefb "&pathhpg\e4_3_4b.hpg";
GOPTIONS GSFNAME=filerefb DEVICE=hp7475a GSFMODE=replace noprompt;

data bio1;
set vol1.biomass (keep= date bmcrus bmmol bmpoly bmothr);
* Adjust date for successive sample dates;
if date='17jun85'd then date='18jun85'd;
else if date='09jul85'd then date='10jul85'd;
else if date='02aug85'd then date='05aug85'd;
else if date='26aug85'd then date='27aug85'd;
run;

proc sort data=bio1;
by date;
run;

proc means data=bio1 noprint;
by date;
var bmcrus bmmol bmpoly bmothr;
output out=bio2 mean=mncrus mnmoll mnpoly mnothr;
run;

data bio3 (keep=yvar date pltvar);
set bio2 (keep=date mnpoly mnmoll mncrus mnothr);
retain pltvar;

* Create dummy axes for each taxa;

* Allow one vertical units for each axis with .25 units
* between each plot.;
if _n_=1 then do;

   * hold the current value of date ;
   tdte = date ;

   pltvar=1;
   * axis for MNPOLY;
   yvar=0;     date='15jun85'd;  output;
   yvar=1;                       output;
   yvar=.5;                      output;
               date='01sep85'd;  output;
   yvar=.;                       output;
   * axis for MNMOLL;
   yvar=1.25; date='15jun85'd;   output;
   yvar=2.25;                    output;
   yvar=1.75;                    output;
              date='01sep85'd;   output;
   yvar=.;                       output;
   * axis for MNOTHR;
   yvar=2.50; date='15jun85'd;   output;
   yvar=3.50;                    output;
   yvar=3.00;                    output;
              date='01sep85'd;   output;
   yvar=.;                       output;
   date = tdte;
end;

* Each butterfly plot is made up of three sets of lines
* each with a common SYMBOL statement;
* the horizontal value for each point is date;

* BMPOLY (centered vertically on .5);
* Upper line;
pltvar = 2; yvar =  .5  + mnpoly/2; output;
* Lower line;
pltvar = 3; yvar =  .5  - mnpoly/2; output;
* Hilo line;
pltvar = 4; yvar =  .5  + mnpoly/2; output;
            yvar =  .5  - mnpoly/2; output;
            yvar =  .;              output;

* BMMOLL (centered vertically on 1.75);
* Upper line;
pltvar = 5; yvar = 1.75 + mnmoll/2; output;
* Lower line;
pltvar = 6; yvar = 1.75 - mnmoll/2; output;
* Hilo line;
pltvar = 7; yvar = 1.75 + mnmoll/2; output;
            yvar = 1.75 - mnmoll/2; output;
            yvar =  .;              output;

* BMOTHR (centered vertically on 3.00);
* Upper line;
pltvar = 8; yvar = 3.00 + mnothr/2; output;
* Lower line;
pltvar = 9; yvar = 3.00 - mnothr/2; output;
* Hilo line;
pltvar =10; yvar = 3.00 + mnothr/2; output;
            yvar = 3.00 - mnothr/2; output;
            yvar =  .;              output;
run;

* Control the vertical axis;
axis1 order = 0 to 3.5 by .25
      label = (h=1.2 a=90 'gm Wet Weight')
      value = (h=1.3)
      minor=none
      style=0;
* Control the horizontal axis;
axis2 minor=none
      order= '15jun85'd, '01jul85'd, '15jul85'd,
             '01aug85'd, '15aug85'd, '01sep85'd
      value = (h=1.3)
      style=0;

* Define the symbols for each subplot;
* SYMBOL1 controls the axes;
symbol1 v=none c=black l=1 i=join r=10;

* Define a format for the vertical axis;
proc format;
value vert 0,1,1.25, 2.25, 2.5, 3.5 = '.5'
           .5, 1.75, 3 = '0'
           .75     = 'BMPOLY'
           2       = 'BMMOLL'
           3.25    = 'BMOTHR'
           other   = ' ';
run;

* Plot the data;
proc gplot data=bio3;
plot yvar*date =pltvar / nolegend
                         skipmiss
                         vaxis=axis1
                         haxis=axis2;
format yvar vert.;
title1 'Biomass Averaged Across Stations';
footnote1 j=l h=2 f=simplex 'Figure 4.3.4b';
run;
quit;
*/ *;
*************************************************;
* e4_3_5.sas;
*
* Create box-whisker plots.
*************************************************;

FILENAME fileref "&pathhpg\e4_3_5.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;

proc sort data=vol1.ca88air (keep=co station)
          out=caair;
by station co;
run;

* determine the median, and quartile statistics for each station;
proc univariate data=caair noprint;
by station;
var co;
output out=stats median=median
                 q1=q1 q3=q3 qrange=qrange;
run;


* Determine the whisker endpoints;
* Whisker endpoints are the most extreme data values that are
* within 1.5*qrange of the quartiles.;
data stats2;
merge stats caair;
by station;
retain lowpt highpt;
drop co;
if first.station then do;
  lowpt=.; highpt=.;
end;

* does this point determine the whisker end point?;
if q1-1.5*qrange <= co <= q3+1.5*qrange then do;
   * look for the smallest value that is between
   * q1-1.5*qrange and q1;
   if lowpt=. then lowpt = co;
   * look for the largest value that is between
   * q3+1.5*qrange and q3;
   if highpt=. then highpt = co;
   else highpt=max(highpt,co);
end;

if last.station then output;
run;


* combine the stats with the data and retain extreme points;
data both;
merge stats2 caair;
by station;
if first.station then do;
   * Build the box and whiskers from the summary stats;
   stacnt + 1;

   * Whiskers are dotted lines;
   pltvar=1;
   * start at the top whisker;
   xvar=stacnt   ; yvar=highpt       ;  output;
                   yvar=q3           ;  output;
   xvar=.        ;                      output;
   xvar=stacnt   ; yvar=lowpt        ;  output;
                   yvar=q1           ;  output;
   xvar=.        ;                      output;

   * The box is a solid line;
   pltvar=2;
   xvar=stacnt+.3; yvar=q3           ;  output;
                   yvar=median       ;  output;
   xvar=stacnt-.3;                      output;
   xvar=stacnt+.3;                      output;
                   yvar=q1           ;  output;
   xvar=stacnt-.3;                      output;
                   yvar=q3           ;  output;
   xvar=stacnt+.3;                      output;
   xvar=.        ;                      output;

end;

* plot outliers;
xvar=stacnt;
yvar=co;

* Determine where this point falls;
* Extreme outliers;
if co < q1-3*qrange or co > q3+3*qrange then do;
   pltvar=4;
   output;
end;
else if co < q1-1.5*qrange or co > q3+1.5*qrange then do;
   pltvar=3;
   output;
end;
run;


* Control the vertical axis;
axis1 label=(h=1.5 f=simplex a=90 'p.p.m.')
      value= (h=1.5 f=simplex);

* Control the horizontal axis;
axis2 label=(h=1.5 f=simplex 'STATIONS')
      order=(0 to 4 by 1)
      major=none
      minor=none
      value= (h=1.5 f=simplex
              t=1 ' ' t=2 'AZU' t=3 'LIV' t=4 'SFO' t=5 ' ');

* Define the symbols;
symbol1 v=none c=black l=2 i=join;
symbol2 v=none c=black l=1 i=join;
symbol3 v=circle c=black;
symbol4 v=diamond c=black;


* Plot the data;
proc gplot data=both;
plot yvar*xvar=pltvar / nolegend
                        skipmiss
                        vaxis=axis1
                        haxis=axis2;
title1 h=2 '1988 Carbon Monoxide Readings';
footnote1 j=l h=2 f=simplex 'Figure 4.3.5';
run;
quit;
*************************************************;
* e4_3_6.sas;
*
* Connect points in a cluster.
*************************************************;

FILENAME fileref "&pathhpg\e4_3_6.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;

proc fastclus data=vol1.h2oqual
     mean=meanclus
     out=outclus
     maxclusters=4
     noprint
     ;
var depth temp ph do cond salinity;
run;

* sort the cluster mean data;
proc sort data=meanclus;
by cluster;
run;

* sort the raw data with the cluster assignments;
proc sort data=outclus;
by cluster;
run;

%macro pltclus(xvar, yvar);
* create a macro to plot any two data variables;

* Combine the cluster means with the rawdata;
* Select two plotting variables;
data both (keep=cluster &xvar &yvar);
set meanclus (keep= cluster &xvar &yvar)
    outclus  (keep= cluster &xvar &yvar);
by cluster;
retain xmean ymean;
* the first value for each cluster contains the summary info;
if first.cluster then do;
   xmean= &xvar;
   ymean= &yvar;
   output;
end;
else if &xvar>. and &yvar>. then do;
   * for each point output two observations that form the line
   * segment from the centroid to the data point;
   output;
   &xvar = xmean;
   &yvar = ymean;
   output;
end;

* graph the clusters using GPLOT;
proc gplot data=both;
plot &yvar * &xvar = cluster;

symbol1 line=1 i=join c=black v=square;
symbol2 line=1 i=join c=black v=circle;
symbol3 line=1 i=join c=black v=triangle;
symbol4 line=1 i=join c=black v=star;
symbol5 line=1 i=join c=black v=diamond;
title1 'Water Quality Cluster Analysis';
footnote h=2 f=simplex j=l 'Figure 4.3.6';
%mend pltclus;

******************************;

*%pltclus(temp, salinity)  run;
*%pltclus(ph  , salinity)  run;
 %pltclus(do  , salinity)  run;
*************************************************;
* e4_4_1a.sas;
*
* GCHART of the Lampara length data.
*************************************************;

FILENAME filerefa "&pathhpg\e4_4_1a.hpg";
GOPTIONS GSFNAME=filerefa DEVICE=hp7475a GSFMODE=replace noprompt;

proc gchart data=vol1.lampara;
vbar length;
title1 'Lampara Length Data';
footnote1 h=2 f=simplex j=l 'Figure 4.4.1a';
run;
quit;
*************************************************;
* e4_4_1bc.sas;
*
* Probability plots.
* Produces unevenly spaced axis scales using formats.
*************************************************;

FILENAME filerefb "&pathhpg\e4_4_1b.hpg";
FILENAME filerefc "&pathhpg\e4_4_1c.hpg";
GOPTIONS GSFNAME=filerefb DEVICE=hp7475a GSFMODE=replace noprompt;

* Generate normal probabilities (y) and two data sets
* that can be used to generate formats.;
data norm (keep= x x2 y y2)
     f1 (keep=fmtname start label)
     f2 (keep=fmtname start label fuzz);
length start label $12;
retain fuzz .05;
do x = -4 to 4 by .1;
  x2 = x;
  y = probnorm(x);
  y2 = y;
  output norm;

  * Prepare to generate a format (PRNORM.) to convert
  * normal values to probabilities;
  fmtname = 'prnorm';
  start = put(x,4.1);
  label = put(y,8.3);
  output f1;

  * Prepare to generate a format (PROBIT.) to convert
  * probabilities to normal values;
  fmtname = 'probit';
  start = put(y,9.7);
  label = put(x,4.1);
  output f2;
end;
label x = 'Normal Scores';
run;

* create the two formats from the control data sets;
proc format cntlin=f1;
proc format cntlin=f2;
run;

axis1 label=none
      value=(h=1.5 f=simplex);

axis2 label=(h=1.5 f=simplex)
      value=(h=1.5 f=simplex);

proc gplot data=norm;
plot y*x / vaxis=axis1 haxis=axis2;
plot2 y2*x / vaxis=axis1;
format y2 probit.;
symbol1 v=none l=1 i=join c=black r=2;
title1 'Cumulative Normal Distribution';
title2 h=1.5 f=simplex 'Based on Probabilities';
title3 h=1.5 f=simplex a=90 'Probability';
title4 h=1.5 f=simplex a=-90 'Normal Scores';
footnote1 h=2 f=simplex j=l 'Figure 4.4.1b';
run;

GOPTIONS GSFNAME=filerefc;
proc gplot data=norm;
plot x*x / vaxis=axis1 haxis=axis2;
plot2 x2*x / vaxis=axis1;
format x2 prnorm.;
symbol1 v=none l=1 i=join c=black r=2;
title1 'Cumulative Normal Distribution';
title2 h=1.5 f=simplex 'Vertical Scale Based on Normal Scores';
title3 h=1.5 f=simplex a=90 'Normal Scores';
title4 h=1.5 f=simplex a=-90 'Probability';
footnote1 h=2 f=simplex j=l 'Figure 4.4.1c';
run;
quit;
*************************************************;
* e4_4_1de.sas;
*
* Produce a Probability plot for the Lampara data.
*************************************************;

FILENAME filerefd "&pathhpg\e4_4_1d.hpg";
FILENAME filerefe "&pathhpg\e4_4_1e.hpg";
GOPTIONS GSFNAME=filerefd DEVICE=hp7475a GSFMODE=replace noprompt;

* Generate normal quantiles (x), probabilities (y), and two
* data sets that can be used to generate formats.;
data norm (keep=x y)
     f1 (keep=fmtname start label)
     f2 (keep=fmtname start label fuzz);
length start label $12;
retain fuzz .05;
do x = -4 to 4 by .1;
  y = probnorm(x);
  output norm;

  * Prepare to generate a format (PRNORM.) to convert
  * normal quantiles to probabilities;
  fmtname = 'prnorm';
  start = put(x,4.1);
  label = put(y,8.3);
  output f1;

  * Prepare to generate a format (PROBIT.) to convert
  * probabilities to normal quantiles;
  fmtname = 'probit';
  start = put(y,9.7);
  label = put(x,4.1);
  output f2;
end;
label x = 'Normal Quantiles';
run;

* create the two formats from the control data sets;
proc format cntlin=f1;
proc format cntlin=f2;
run;

* convert the length information to standard normal;
proc standard data=vol1.lampara
              out=standard
              mean=0 std=1;
var length;
run;

* Determine the length frequencies for the lampara data;
proc freq data=standard noprint;
table length / out=percent;
run;

* Calculate the cumulative length probabilities;
data cumulpr (keep= length cumulpr cumnorm x y);
set percent (in=inper) norm ;
if not inper then do;
   length = x;
   cumulpr = .;
end;
else do;
   cumulpr + (percent/100);
   cumnorm = probit(cumulpr);
end;
label length  = 'Standardized Lengths (normal quantiles)'
      cumulpr = 'cumulative probabilities'
      cumnorm = 'normal quantiles';
run;

* Axis and symbol definitions;
* Axis1 used to plot probabilities;
axis1 order= 0 to 1 by .1
      value=(h=1.5 f=simplex)
      label=none;
* Axis2 used to plot normal quantiles;
axis2 order= -4 to 4 by 1
      value=(h=1.5 f=simplex)
      label=none;

axis3 label=(h=1.5 f=simplex)
      value=(h=1.5 f=simplex);

* symbol1 is used with the data;
symbol1 v=dot c=black;
* symbol2 is used to control the normal line;
symbol2 i=join v=none l=1 c=black;

* Plot the probabilities with the second axis
* formatted to normal quantiles;
proc gplot data=cumulpr;
plot cumulpr*length=1 / vaxis=axis1 haxis=axis3;
plot2 y*length=2 / vaxis=axis1;
format y probit.;
title1 'Cumulative Normal Distribution';
title2 h=1.5 f=simplex 'Vertical Scale Based on Probabilities';
title3 h=1.5 f=simplex a=90 'Cumulative Probability';
title4 h=1.5 f=simplex a=-90 'Normal Quantiles';
footnote1 h=2 f=simplex j=l 'Figure 4.4.1d';
run;

* Plot the normal scores with the second axis
* formatted to probabilities;
GOPTIONS GSFNAME=filerefe;
proc gplot data=cumulpr;
plot cumnorm*length=1 / vaxis=axis2 haxis=axis3;
plot2 x*length=2 / vaxis=axis2;
format x prnorm.;
title1 'Cumulative Normal Distribution';
title2 h=1.5 f=simplex 'Vertical Scale Based on Normal Quantiles';
title3 h=1.5 f=simplex a=90 'Normal Quantiles';
title4 h=1.5 f=simplex a=-90 'Probability';
footnote1 h=2 f=simplex j=l 'Figure 4.4.1e';
run;
quit;
*************************************************;
* e4_4_2a.sas;
*
* Demonstrate non-equal scaling of the axes.
*************************************************;

FILENAME filerefa "&pathhpg\e4_4_2a.hpg";
GOPTIONS GSFNAME=filerefa DEVICE=hp7475a GSFMODE=replace noprompt;

data design (keep= x y pltvar);
* Create a square centered on (5,5) with a side of length 5;
pltvar=1;
x= 0; y= 0; output;
x= 0; y=10; output;
x=10; y=10; output;
x=10; y= 0; output;
x= 0; y= 0; output;

* Create a circle centered on (5,5) with a radius of length 5;
pltvar=2;
pi = arcos(-1);
do alpha = 0 to 2*pi by 2*pi/100;
  x=5*cos(alpha)+5;
  y=5*sin(alpha)+5;
  output;
end;
run;

proc gplot data=design;
plot y*x=pltvar / nolegend;
symbol1 v=none i=j l=1 c=black r=2;
title1 'Creating Axes with Equal Scales';
title2 h=1 f=simplex 'Circle within a Square';
footnote1 h=2 f=simplex j=l 'Figure 4.4.2a';
run;
*************************************************;
* e4_4_2b.sas;
*
* Demonstrate equal scaling using HSIZE.
*************************************************;

FILENAME filerefb "&pathhpg\e4_4_2b.hpg";
GOPTIONS GSFNAME=filerefb DEVICE=hp7475a GSFMODE=replace noprompt;

data design (keep= x y pltvar);
* Create a square centered on (5,5) with a side of length 5;
pltvar=1;
x= 0; y= 0; output;
x= 0; y=10; output;
x=10; y=10; output;
x=10; y= 0; output;
x= 0; y= 0; output;

* Create a circle centered on (5,5) with a radius of length 5;
pltvar=2;
pi = arcos(-1);
do alpha = 0 to 2*pi by 2*pi/100;
  x=5*cos(alpha)+5;
  y=5*sin(alpha)+5;
  output;
end;
run;

goptions hsize=5;
proc gplot data=design;
plot y*x=pltvar / nolegend;
symbol1 v=none i=j l=1 c=black r=2;
title1 'Creating Axes with Equal Scales';
title2 h=1 f=simplex 'Adjusting the HSIZE GOPTION';
footnote1 h=2 f=simplex j=2 'Figure 4.4.2b';
run;
*************************************************;
* e4_4_2c.sas;
*
* Adjust the horizontal axis scale by adding blank titles.
*************************************************;

FILENAME filerefc "&pathhpg\e4_4_2c.hpg";
GOPTIONS GSFNAME=filerefc DEVICE=hp7475a GSFMODE=replace noprompt;

data design (keep= x y pltvar);
* Create a square centered on (5,5) with a side of length 5;
pltvar=1;
x= 0; y= 0; output;
x= 0; y=10; output;
x=10; y=10; output;
x=10; y= 0; output;
x= 0; y= 0; output;

* Create a circle centered on (5,5) with a radius of length 5;
pltvar=2;
pi = arcos(-1);
do alpha = 0 to 2*pi by 2*pi/100;
  x=5*cos(alpha)+5;
  y=5*sin(alpha)+5;
  output;
end;
run;

axis1 label=(h=1.5 f=simplex a=90 'Y axis')
      value=(h=1.5 f=simplex);

axis2 label=(h=1.5 f=simplex 'X axis')
      value=(h=1.5 f=simplex);

proc gplot data=design;
plot y*x=pltvar / nolegend
                  vaxis=axis1 haxis=axis2;
symbol1 v=none i=j l=1 c=black r=2;
title1 'Creating Axes with Equal Scales';
title2 h=1.5 f=simplex 'Padding the Margins';
title3 h=10.9 f=simplex a=-90 '  ';
title4 h=10.9 f=simplex a= 90 '  ';
footnote1 h=2 f=simplex j=l 'Figure 4.4.2c';
run;
quit;
*************************************************;
* e4_4_2d.sas;
*
* Equal scaling by adjusting the range of the longer axis;
*************************************************;

FILENAME filerefd "&pathhpg\e4_4_2d.hpg";
GOPTIONS GSFNAME=filerefd DEVICE=hp7475a GSFMODE=replace noprompt;

data design (keep= x y pltvar);
* Create a square centered on (5,5) with a side of length 5;
pltvar=1;
x= 0; y= 0; output;
x= 0; y=10; output;
x=10; y=10; output;
x=10; y= 0; output;
x= 0; y= 0; output;

* Create a circle centered on (5,5) with a radius of length 5;
pltvar=2;
pi = arcos(-1);
do alpha = 0 to 2*pi by 2*pi/100;
  x=5*cos(alpha)+5;
  y=5*sin(alpha)+5;
  output;
end;
run;

* Select the range of the longer axis such that:
* range = (range_short)*(length_long)/(length_short);
axis1 order= -5 to 15 by 5
      value=(h=1.5 f=simplex)
      label=(h=1.5 f=simplex)
      minor=(n=4);

axis2 value=(h=1.5 f=simplex)
      label=(h=1.5 f=simplex a=90 'Y Axis');

proc gplot data=design;
plot y*x=pltvar / nolegend haxis=axis1 vaxis=axis2;
symbol1 v=none i=j l=1 c=black r=2;
title1 'Creating Axes with Equal Scales';
title2 h=1.5 f=simplex 'Adjusting the Axis Range';
footnote1 h=2 f=simplex j=l 'Example 4.4.2d';
run;
quit;
*************************************************;
* e4_5_1.sas;
*
* Create a GFONT containing a histogram of values.
*************************************************;

FILENAME fileref "&pathhpg\e4_5_1.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;

* Determine the cell frequencies for each dateXsex;
proc freq data=vol1.lampara;
by date;
table sex / noprint out=percent;
run;

* Add a null value to dates without all three sex groups;
data groups (keep=date sex);
set percent (keep=date);
by date;
if first.date then do sex = 'F', 'M', 'U';
   output;
end;
run;

* Fill empty cells with a zero percent and
* count the total catch (data to be plotted);
data percent2 (keep=date sex percent)
     totcatch (keep=date totcatch pltvar);
merge percent (in=inper) groups;
by date sex;
* Sparse the data;
if not inper then do;
   percent=0;
   count=0;
end;
output percent2;
* Determine the total catch for each date;
if first.date then do;
   totcatch=0;
   pltvar+1;
end;
totcatch + count;
if last.date then output totcatch;
label totcatch = 'Total Catch';
run;

data fontdata (keep=char seg x y lp ptype);
set percent2 (keep=date sex percent);
by date;
length char $1;
retain char ' ' ptype 'V';
if first.date then do;
  pltvar + 1;
  char = put(pltvar,1.);
  * define the outline;
  seg=1; lp='L';
  x=  0; y=  0; output;
         y=100; output;
  x=100;        output;
         y=  0; output;
         y= 50; output;
  x=  0;        output;
end;

* Draw the histogram bars;
* Bar height is determined by the data,
* the width coordinates (x) are F=0-33, M=33=66, and U=66-100;
seg=2; lp='P'; y=percent;
if sex = 'F' then do;
   x= 0; y=0;       output;
         y=percent; output;
   x=33;            output;
end;
else if sex = 'M' then do;
   x=33; y=percent; output;
   x=66;            output;
end;
else if sex = 'U' then do;
   x=66; y=percent; output;
   x=100;           output;
         y=0;       output;
   x=0;             output;
end;
run;

* Define the gfont library;
libname gfont0 "&pathhpg";

* Create the GFONT (HISTO);
proc gfont data=fontdata
           name=histo
           filled
           nodisplay;
run;

* Define the axis statements;
axis1 order= 0 to 20 by 5
      value=(h=1.5 f=simplex)
      label=(h=1.5 f=simplex);

axis2 order= '01may86'd to '01sep86'd by month
      value=(h=1.5 f=simplex)
      label=(h=1.5 f=simplex);

* Display the total catch using the user-defined font;
proc gplot data=totcatch;
plot totcatch*date=pltvar /
     nolegend
     vaxis= axis1
     haxis= axis2;
title1 'Total Catch';
title2 h=1.5 f=simplex 'Bars show percentage for each sex (F, M, U)';
footnote1 h=2 j=l f=simplex 'Figure 4.5.1';
symbol1 f=histo c=black h=3 v=1;
symbol2 f=histo c=black h=3 v=2;
symbol3 f=histo c=black h=3 v=3;
symbol4 f=histo c=black h=3 v=4;
symbol5 f=histo c=black h=3 v=5;
symbol6 f=histo c=black h=3 v=6;
symbol7 f=histo c=black h=3 v=7;
symbol8 f=histo c=black h=3 v=8;
run;
quit;
*************************************************;
* e4_5_2.sas;
*
* Create and display a sunflower GFONT.
*************************************************;

FILENAME fileref "&pathhpg\e4_5_2.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;

* create the data used to create the font;
data fontdata(keep=char seg x y lp ptype);
length char $1;
retain char ' ';
twopi = 2*arcos(-1);
quarter = twopi/4;
do pltvar = 1 to 20 by 1;
  char = substr('ABCDEFGHIJKLMNOPQRSTUV',pltvar,1);
  * define the center point as a circle with radius 10;
  seg=0; lp='p';
  ptype='w'; x =  0; y=100; output;
  ptype='v'; x = 50; y= 60; output;
  ptype='c'; x = 50; y= 50; output;
  ptype='v'; x = 40; y= 50; output;
  ptype='c'; x = 50; y= 50; output;
  ptype='v'; x = 50; y= 40; output;
  ptype='c'; x = 50; y= 50; output;
  ptype='v'; x = 60; y= 50; output;
  ptype='c'; x = 50; y= 50; output;
  ptype='v'; x = 50; y= 60; output;

  * for pltvars > 1 include petals;
  lp='l';
  if pltvar>1 then do seg = 1 to pltvar;
    * Divide the circle into pltvar parts, draw a line for
    * each part.  Shift the angle by one quarter turn to
    * make the first vertical;
    angle = twopi/pltvar*(seg-1) + quarter;
    x= 50; y = 50;  output;
    x= 50*cos(angle)+50; y=50*sin(angle)+50; output;
    * for the very last point draw back to the center;
    if seg=pltvar then do;
       x= 50; y = 50;  output;
    end;
  end;
end;

* Define the gfont library;
libname gfont0 "&pathhpg";

* Create the GFONT (HISTO);
proc gfont data=fontdata
           name=sunflwr
           filled
           nodisplay;
run;

* Plot the daily stock market high with the sunflower
* petals representing the trading volume (500,000 shares);
*
* Adjust the volume to a number between 1 and 20;
data dow;
set vol1.dow;
pltvar = ceil(volume/500);
output;

* Each of the twenty symbol statements must be requested
* even if all are not used on the plot.  PLTVAR=n points to
* the Nth activated symbol statement, not just SYMBOLn.;
* Create 20 points that will not be plotted, but will activate
* each of the 20 symbol statements;
if _n_=1 then do pltvar=1 to 20;
  high=.;
  output;
end;
run;

* Define the axis statements;
axis1 value=(h=1.5 f=simplex)
      label=(h=1.5 f=simplex);

axis2 order= '03aug81'd to '31aug81'd by week
      value=(h=1.5 f=simplex)
      label=(h=1.5 f=simplex);

* Display the closing high;
proc gplot data=dow;
plot high*date=pltvar /
     vaxis=axis1 haxis=axis2
     nolegend;
title1 'Daily Trading Highs';
title2 h=1.5 f=simplex 'Petals represent trading volume in 500,000 shares';
footnote1 h=2 j=l f=simplex 'Figure 4.5.2';
symbol1  f=sunflwr c=black h=2 v=A;
symbol2  f=sunflwr c=black h=2 v=B;
symbol3  f=sunflwr c=black h=2 v=C;
symbol4  f=sunflwr c=black h=2 v=D;
symbol5  f=sunflwr c=black h=2 v=E;
symbol6  f=sunflwr c=black h=2 v=F;
symbol7  f=sunflwr c=black h=2 v=G;
symbol8  f=sunflwr c=black h=2 v=H;
symbol9  f=sunflwr c=black h=2 v=I;
symbol10 f=sunflwr c=black h=2 v=J;
symbol11 f=sunflwr c=black h=2 v=K;
symbol12 f=sunflwr c=black h=2 v=L;
symbol13 f=sunflwr c=black h=2 v=M;
symbol14 f=sunflwr c=black h=2 v=N;
symbol15 f=sunflwr c=black h=2 v=O;
symbol16 f=sunflwr c=black h=2 v=P;
symbol17 f=sunflwr c=black h=2 v=Q;
symbol18 f=sunflwr c=black h=2 v=R;
symbol19 f=sunflwr c=black h=2 v=S;
symbol20 f=sunflwr c=black h=2 v=T;
run;
quit;
* E5_2_1a;
GOPTIONS NOBORDER
         GSFNAME="\myplots\xyplt.hpg"
         DEVICE=hp7475a
         GSFMODE=replace noprompt;

* E5_2_1b;
FILENAME fileref 'myplots\xyplt.hpg';
GOPTIONS NOBORDER
         GSFNAME=fileref
         DEVICE=hp7475a
         GSFMODE=replace noprompt;
*************************************************;
* e5_2_2.sas;
*
* Demonstrate differences of the BORDER and NOBORDER options;
*************************************************;

FILENAME filerefa "&pathhpg\e5_2_2a.hpg";
FILENAME filerefb "&pathhpg\e5_2_2b.hpg";
GOPTIONS GSFNAME=filerefa DEVICE=hp7475a GSFMODE=replace noprompt;

goptions border;
proc gslide;
title j=l h=2 f=simplex 'Figure 5.2.2a';
title2 h=2 j=c f=duplex 'Using the';
title3 h=2 j=c f=duplex 'BORDER GOPTION';
run;

goptions noborder gsfname=filerefb;
proc gslide;
title j=l h=2 f=simplex 'Figure 5.2.2b';
title2 h=2 j=c f=duplex 'Using the';
title3 h=2 j=c f=duplex 'NOBORDER GOPTION';
run;
* using the FILENAME statement to identify the GSFNAME file;
filename fileref 'myplots\xyplt.hpg';

goptions noborder
         gsfname=fileref
         device=hp7475a
         gsfmode=replace noprompt;
*************************************************;
* e5_3_2.sas;
*
* Demonstrate differences of the BORDER and NOBORDER options;
*************************************************;

FILENAME filerefa "&pathhpg\e5_3_2a.hpg";
FILENAME filerefb "&pathhpg\e5_3_2b.hpg";
GOPTIONS GSFNAME=filerefa DEVICE=hp7475a GSFMODE=replace noprompt;

goptions border;
proc gslide;
title j=l h=2 f=simplex 'Figure 5.3.2a';
title2 h=2 j=c f=duplex 'Using the';
title3 h=2 j=c f=duplex 'BORDER GOPTION';
run;

goptions noborder gsfname=filerefb;
proc gslide;
title j=l h=2 f=simplex 'Figure 5.3.2b';
title2 h=2 j=c f=duplex 'Using the';
title3 h=2 j=c f=duplex 'NOBORDER GOPTION';
run;
*************************************************;
* e5_6_4.sas;
*
* Demonstrate gray-scales;
*************************************************;

libname gdevice0 "&pathhpg";

goptions reset=all border;
FILENAME fileref "&pathhpg\e5_6_4.cgm";
GOPTIONS GSFNAME=fileref DEVICE=cgmwp6ga GSFMODE=replace noprompt;

proc gslide;
title1 h=2 f=swiss j=c 'Demonstrate the use of Gray-Scales';
note h=10 c=gray00 j=c f=marker 'Q' c=gray22 'Q' c=gray33 'Q'
                       c=gray44 'Q' c=gray55 'Q' c=gray66 'Q';
note j=c h=1.8 f=simplex
               c=gray00 'gray00       gray22       gray33'
                 '       gray44       gray55       gray66';
note h=10 c=gray77 j=c f=marker 'Q' c=gray88 'Q' c=gray99 'Q'
                       c=grayaa 'Q' c=graybb 'Q' c=graycc 'Q';
note j=c h=1.8 f=simplex
               c=gray00 'gray77       gray88       gray99'
                 '       grayaa       graybb       graycc';
note h=10 c=graydd j=c f=marker 'Q' c=grayee 'Q' c=grayff 'Q';
note j=c h=1.9 f=simplex
               c=gray00 'graydd       grayee       grayff';
footnote j=l h=2 f=simplex 'Figure 5.6.4';
run;
quit;
*************************************************;
* e5_7_1.sas;
*
* Use GCHART to demonstrate a stacked bar chart;
*************************************************;

FILENAME fileref "&pathhpg\e5_7_1.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;

proc gchart data=vol1.lampara;
title 'Stacked Histogram';
footnote j=l h=2 f=simplex 'Figure 5.7.1';
vbar length / subgroup=sex
              midpoints = 100 110 120 130 140 150 160 170 180 190 200;
pattern1 value=l1 c=black;
pattern2 value=x1 c=blue;
pattern3 value=r1 c=green;

run;
*************************************************;
* e5_7_2.sas;
*
* Use Gplot to demonstrate a plot of layers;
*************************************************;

FILENAME fileref "&pathhpg\e5_7_2.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;

data inverse;
do x = .10 to 2 by .05;
   y1 = 1/x;
   y2 = 1/x + 1;
   output;
end;

proc gplot data=inverse;
footnote j=l h=2 f=simplex 'Figure 5.7.2';
title 'Layers Plot of an Inverse Function';
title2 h=2 j=c f=simplex
       'Vertical Width Of The Upper Layer Is Constant';
plot y1*x y2*x / overlay haxis = 0 to 2 by .5
                 areas=2;

symbol1 i=join v=none l=1;
symbol2 i=join v=none l=2;

pattern1 value=m3n90 color=black;
pattern2 value=m3n0 color=red;
run;
quit;
*************************************************;
* e5_7_3.sas;
*
* Use GCHART to build block charts;
*************************************************;


FILENAME fileref "&pathhpg\e5_7_3.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;

proc gchart data=vol1.lampara;
title1 'Block Chart';
footnote j=l h=2 f=simplex 'Figure 5.7.3';
block length / group=sex
              midpoints = 110 140 170 200;
run;
*************************************************;
* e5_7_4.sas;
*
* Use Vertical bars to demonstrate an illusion;
*************************************************;

FILENAME fileref "&pathhpg\e5_7_4.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;

proc gchart data=vol1.lampara;
title 'Patterns Seem to Create Leaning Towers';
footnote j=l h=2 f=simplex 'Figure 5.7.4';
vbar length / patternid=midpoint
              midpoints = 120 140 160 180 ;
pattern1 value=l1 color=black;
pattern2 value=r1 color=black;
pattern3 value=l1 color=black;
pattern4 value=r1 color=black;
run;
*************************************************;
* e5_7_5.sas;
*
* Comparison of four data display styles.
* Which size group, 120 or 160 is larger?
*************************************************;

goptions reset=all border;
FILENAME fileref "&pathhpg\e5_7_5.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;

goption nodisplay htext=2 ftext=simplex;
proc gchart data=vol1.lampara gout=chpt5;
title1 h=2 'Frequency Comparison of';
title2 h=2 j=c f=duplex '120mm and 160mm Size Groups';
footnote j=l h=2 f=simplex 'Figure 5.7.5';
vbar length / midpoints = 120 140 160 180 name='vbar';
hbar length / midpoints = 120 140 160 180 name='hbar';
pie  length / midpoints = 120 140 160 180 name='pie1';
pie  length / midpoints = 120 140 160 180 explode=160 name='pie2';
run;

goptions display;
proc greplay igout=chpt5 nofs;
tc vol1.templ8;

template fourscrn;
treplay 1='vbar'
        2='hbar'
        3='pie1'
        4='pie2';
run;
quit;
*************************************************;
* e5_7_6a.sas;
*
* Plot with two non-aligned axes;
*************************************************;

FILENAME filerefa "&pathhpg\e5_7_6a.hpg";
GOPTIONS GSFNAME=filerefa DEVICE=hp7475a GSFMODE=replace noprompt;

proc gplot data=vol1.ca88air;
plot o3 * month = 'O';
plot2 co * month = 'C';
where station='SFO';
title1 '1988 Air Quality Data - SFO';
title2 h=2 f=simplex 'Two Non-aligned Axes';
footnote1 j=l h=2 'Figure 5.7.6a';
run;
quit;
*************************************************;
* e5_7_6b.sas;
*
* Plot with two non-aligned axes;
*************************************************;

FILENAME filerefb "&pathhpg\e5_7_6b.hpg";
GOPTIONS GSFNAME=filerefb DEVICE=hp7475a GSFMODE=replace noprompt;

axis1 order=880 to 1040 by 20
      value=(h=1.5 f=simplex)
      label=(h=1.5 a=90 f=simplex 'Daily High');
axis2 order='27jul81'd to '31aug81'd by 7
      value=(h=1.5 f=simplex)
      label=(h=1.5 f=simplex 'DATE');
axis3 order=0 to 6000 by 2000
      value=(h=1.5 f=simplex)
      label=(h=1.5 a=-90 f=simplex 'VOLUME in 1000 Shares');

proc gplot data=vol1.dow;
plot high * date / vaxis=axis1
                   haxis=axis2;
plot2 volume*date/ vaxis=axis3;
title1 'Dow HIGH and VOLUME';
footnote1 j=l h=2 'Figure 5.7.6b';
symbol1 i=join v='H' f=simplex l=1 c=black;
symbol2 i=join v='V' f=simplex l=2 c=black;
run;
quit;
*************************************************;
* e5_7_7.sas;
*
* SCATTER statement in PROC G3D;
*************************************************;

FILENAME fileref "&pathhpg\e5_7_7.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;

data air; set vol1.ca88air;
if station='AZU' then do;
    shapevar='club';
    colorvar='black';
end;
else if station='LIV' then do;
    shapevar='spade';
    colorvar='blue';
end;
else if station='SFO' then do;
    shapevar='heart';
    colorvar='green';
end;
* temperatures range from 40 to 80;
* create a scaled variable based on temperature (ranges from 0 to 3);
min=40; max=80;
sizevar = (tem-min)/(max-min)*3;
run;


proc g3d data=air;
scatter o3 * co = no3 / size=sizevar
                        shape=shapevar
                        color=colorvar
                        grid;
title1 h=2 f=swiss '1988 Air Quality Data';
title2 h=2 f=simplex 'Temperature Relationship to CO, O'
                h=1 move=(+0,-.5) '3'
                h=2 move=(+0,+.5) ', and NO'
                h=1 move=(+0,-.5) '3';
title3 h=1.2 f=simplex 'Symbol size relates to Temperature';
title4 h=1.2 f=simplex 'Symbol color relates to Season';
title5 h=1.2 f=simplex 'AZU (club)   LIV (spade)   SFO (heart)';
footnote j=l h=2 f=simplex 'Figure 5.7.7';
run;
*************************************************;
* e5_8a.sas;
*
* Character placement: fonts selected through the SYMBOL statement.
* V6.04 (DOS)
*************************************************;

FILENAME filerefa "&pathhpg\e5_8a.hpg";
GOPTIONS GSFNAME=filerefa DEVICE=hp7475a GSFMODE=replace noprompt;

data points;
do y = 0 to 1;
do x = 1 to 10;
  * generate symbol numbers from 1 to 20;
  symnum = Y*10 + x;
  output;
end; end;
run;

proc gplot data=points;
plot y*x=symnum / vref=0 1 lvref=1 nolegend
                  vaxis = -.5 to 1.5
                  haxis = 0 to 11 ;
symbol1 h=1.5 v=triangle c=black;
symbol2 h=1.5 v=circle   c=black;
symbol3 h=1.5 v=square   c=black;
symbol4 h=1.5 v='J'    c=black font=special;
symbol5 h=1.5 v='H'    c=black font=special;
symbol6 h=1.5 v='U'    c=black font=marker ;
symbol7 h=1.5 v='K'    c=black font=cartog ;
symbol8 h=1.5 v='Q'    c=black font=cartog ;
symbol9 h=1.5 v='L'    c=black font=weather;
symbol10 h=1.5 v='D'    c=black font=weather;
symbol11 h=1.5 v='A'    c=black font=simplex;
symbol12 h=1.5 v='a'    c=black font=simplex;
symbol13 h=1.5 v='.'    c=black font=simplex;
symbol14 h=1.5 v='A'    c=black font=swissb ;
symbol15 h=1.5 v='a'    c=black font=swissb ;
symbol16 h=1.5 v='.'    c=black font=swissb ;
symbol17 h=1.5 v='A'    c=black font=centb  ;
symbol18 h=1.5 v='a'    c=black font=centb  ;
symbol19 h=1.5 v='.'    c=black font=centb  ;
symbol20 h=1.5 v='A'    c=black font=greek  ;
title1 'Symbol Placement - V6.04 (DOS)';
footnote j=l h=2 'Figure 5.8a';
run;
*************************************************;
* e5_8b.sas;
*
* Character placement: fonts selected through the SYMBOL statement.
* V6.08 (Windows)
*************************************************;

FILENAME filerefb "&pathhpg\e5_8b.hpg";
GOPTIONS GSFNAME=filerefb DEVICE=hp7475a GSFMODE=replace noprompt;

data points;
do y = 0 to 1;
do x = 1 to 10;
  * generate symbol numbers from 1 to 20;
  symnum = Y*10 + x;
  output;
end; end;
run;

proc gplot data=points;
plot y*x=symnum / vref=0 1 lvref=1 nolegend
                  vaxis = -.5 to 1.5
                  haxis = 0 to 11 ;
symbol1 h=1.5 v=triangle c=black;
symbol2 h=1.5 v=circle   c=black;
symbol3 h=1.5 v=square   c=black;
symbol4 h=1.5 v='J'    c=black font=special;
symbol5 h=1.5 v='H'    c=black font=special;
symbol6 h=1.5 v='U'    c=black font=marker ;
symbol7 h=1.5 v='K'    c=black font=cartog ;
symbol8 h=1.5 v='Q'    c=black font=cartog ;
symbol9 h=1.5 v='L'    c=black font=weather;
symbol10 h=1.5 v='D'    c=black font=weather;
symbol11 h=1.5 v='A'    c=black font=simplex;
symbol12 h=1.5 v='a'    c=black font=simplex;
symbol13 h=1.5 v='.'    c=black font=simplex;
symbol14 h=1.5 v='A'    c=black font=swissb ;
symbol15 h=1.5 v='a'    c=black font=swissb ;
symbol16 h=1.5 v='.'    c=black font=swissb ;
symbol17 h=1.5 v='A'    c=black font=centb  ;
symbol18 h=1.5 v='a'    c=black font=centb  ;
symbol19 h=1.5 v='.'    c=black font=centb  ;
symbol20 h=1.5 v='A'    c=black font=greek  ;
title 'Symbol Placement - V6.08 (Windows)';
footnote j=l h=2 'Figure 5.8b';
run;
*************************************************;
* e6_2.sas;
*
* Create and store a map of the US.
*************************************************;

FILENAME fileref "&pathhpg\e6_2.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;


proc gmap map=maps.us
          data=vol1.salesmap
          gout=vol1.chapt6;
id state;
choro code / coutline=black
             name='salesmap'
             discrete;
pattern1 v=msolid c=black;
pattern2 v=m5x45  c=black;
pattern3 v=m1x45  c=black;
pattern4 v=m1n135  c=black;
pattern5 v=m1n45  c=black;
pattern6 v=empty  c=black;

title1 'National Sales';
footnote1 j=l h=2 f=simplex 'Figure 6.2';
run;
*************************************************;
* e6_2_1.sas;
*
* Demonstrate the use of PROC GREPLAY.
*************************************************;

proc greplay igout= vol1.chapt6;
run;
*************************************************;
* e6_3.sas;
*
* Use PROC GREPLAY to display the TEMPLATE DIRECTORY window.
*************************************************;

proc greplay igout= vol1.chapt6
             tc= sashelp.templt;
run;
*************************************************;
* e6_3_1a.sas;
*
* Store a GSLIDE example plot.
*************************************************;

FILENAME filerefa "&pathhpg\e6_3_1a.hpg";
GOPTIONS GSFNAME=filerefa DEVICE=hp7475a GSFMODE=replace noprompt;

proc gslide gout=vol1.chapt6 name='e6_3_1';
title1 f=simplex h=2 j=l 'upper' j=r 'upper';
title2 f=simplex h=2 j=l 'left' j=r 'right';
note f=brush h=6 j=c ' A B C';
footnote1 f=simplex h=2 j=l 'lower' j=r 'lower';
footnote2 f=simplex h=2 j=l 'left' j=r 'right';
run;
*************************************************;
* e6_3_1c.sas;
*
* replay 6.3.1a using a reduced size template.
*************************************************;

FILENAME filerefc "&pathhpg\e6_3_1c.hpg";
GOPTIONS GSFNAME=filerefc DEVICE=hp7475a GSFMODE=replace noprompt;

proc gslide gout=vol1.chapt6
            name='blank'
            border;
run;

proc greplay nofs
             igout=vol1.chapt6
             tc=vol1.templ8
             template=partial;
treplay 1:e6_3_1
        2:blank ;
run;
*************************************************;
* e6_3_1d.sas;
*
* replay 6.3.1a using a reduced size template.
*************************************************;

FILENAME filerefd "&pathhpg\e6_3_1d.hpg";
GOPTIONS GSFNAME=filerefd DEVICE=hp7475a GSFMODE=replace noprompt;

proc gslide gout=vol1.chapt6
            name='blank'
            border;
run;

proc greplay nofs
             igout=vol1.chapt6
             tc=vol1.templ8
             template=partial;
treplay 1:e6_3_1
        3:blank ;
run;
*************************************************;
* e6_3_2a.sas;
*
* replay 6.3.1 overlayed with the panel coordinates.
*************************************************;

FILENAME filerefa "&pathhpg\e6_3_2a.hpg";
GOPTIONS GSFNAME=filerefa DEVICE=hp7475a GSFMODE=replace noprompt;
goptions noborder;

* create a GSLIDE with the panel coordinates;
proc gslide gout=vol1.chapt6
            name='coords';
title1 f=simplex h=2 j=l '(0,100)' j=r '(100,100)';
footnote1 f=simplex h=2 j=l '(0,0)' j=r '(100,0)';
run;

proc greplay nofs
             igout=vol1.chapt6
             tc=vol1.templ8
             template=e632;
treplay 1:coords
        2:e6_3_1;
run;
quit;
*************************************************;
* e6_3_2b.sas;
*
* replay 6.3.1 overlayed with the panel coordinates.
*************************************************;

FILENAME filerefb "&pathhpg\e6_3_2b.hpg";
GOPTIONS GSFNAME=filerefb DEVICE=hp7475a GSFMODE=replace noprompt;
goptions noborder;

proc greplay nofs
             igout=vol1.chapt6
             tc=vol1.templ8
             template=e632;
treplay 1:coords
        3:e6_3_1;
run;
quit;
*************************************************;
* e6_3_2d.sas;
*
* replay 6.3.1 using a rotated template.
*************************************************;

FILENAME filerefd "&pathhpg\e6_3_2d.hpg";
GOPTIONS GSFNAME=filerefd DEVICE=hp7475a GSFMODE=replace noprompt;

proc greplay nofs
             igout=vol1.chapt6
             tc=vol1.templ8
             template=rotate;
treplay 1:e6_3_1;
run;
*************************************************;
* e6_3_3b.sas;
*
* Create a slide of the coordinates used to zoom X 2
* to the upper left corner;
*************************************************;

FILENAME filerefb "&pathhpg\e6_3_3b.hpg";
GOPTIONS GSFNAME=filerefb DEVICE=hp7475a GSFMODE=replace noprompt;
goptions noborder;

goptions nodisplay;
* create a GSLIDE with the panel coordinates;
proc gslide gout=vol1.chapt6
            name='e6_3_3b';
title1 f=simplex h=2 j=l '(0,100)'
                     j=c '(100,100)'
                     j=r '(200,100)';
title2 f=simplex h=2 m=(0,50)pct '(0,0)';
footnote1 f=simplex h=2 j=l '(0,-100)'
                        j=c '(100,-100)'
                        j=r '(200,-100)';
run;
proc gslide gout=vol1.chapt6
            name='e633line';
title1 draw=(0,50,50,50,50,100)pct;
footnote1 ' ';
run;

proc greplay nofs
             igout=vol1.chapt6
             tc=vol1.templ8
             template=e632;
treplay 1:e6_3_3b
        2:e633line;
run;
quit;
*************************************************;
* e6_3_3c.sas;
*
* replay 6.2 overlayed with the panel coordinates shown in 6.3.3b.
*************************************************;

FILENAME filerefc "&pathhpg\e6_3_3c.hpg";
GOPTIONS GSFNAME=filerefc DEVICE=hp7475a GSFMODE=replace noprompt;

goptions display;
proc greplay nofs
             igout=vol1.chapt6
             tc=vol1.templ8
             template=e633;
treplay 1:e6_3_3B
        2:e633line
        3:salesmap;
run;
quit;
*************************************************;
* e6_3_3e.sas;
*
* replay 6.2 using a template to zoom in on the upper left corner.
*************************************************;

FILENAME filerefd "&pathhpg\e6_3_3e.hpg";
GOPTIONS GSFNAME=filerefd DEVICE=hp7475a GSFMODE=replace noprompt;

proc greplay nofs
             igout=vol1.chapt6
             tc=vol1.templ8
             template=zoom2xul;
treplay 1:salesmap;
run;
*************************************************;
* e6_3_3f.sas;
*
* Create a slide of the coordinates used to zoom
* new england;
*************************************************;

FILENAME filereff "&pathhpg\e6_3_3f.hpg";
GOPTIONS GSFNAME=filereff DEVICE=hp7475a GSFMODE=replace noprompt;
goptions noborder;
goptions display;

goptions nodisplay;
* create a GSLIDE with the panel coordinates;
proc gslide gout=vol1.chapt6
            name='e6_3_3f';
title1 f=simplex h=2 j=l '(-290,150)'
                     j=r '(110,150)';
footnote1 f=simplex h=2 j=l '(-290,-250)'
                        j=r '(110,-250)';
run;
proc gslide gout=vol1.chapt6
            name='e633flin';
title1 draw=(72,63,72,88,98,88,98,63,72,63)pct;
footnote1 ' ';
run;

goptions display;
proc greplay nofs
             igout=vol1.chapt6
             tc=vol1.templ8
             template=e632;
treplay 1:e6_3_3f
        2:e633flin;
run;
quit;
*************************************************;
* e6_3_3g.sas;
*
* Create a slide of the coordinates used to zoom
* the legend  ;
*************************************************;

FILENAME filerefg "&pathhpg\e6_3_3g.hpg";
GOPTIONS GSFNAME=filerefg DEVICE=hp7475a GSFMODE=replace noprompt;
goptions noborder;

goptions nodisplay;
* create a GSLIDE with the panel coordinates;
proc gslide gout=vol1.chapt6
            name='e6_3_3g';
title1 f=simplex h=2 j=l '(-12.5,1860)'
                     j=r '(112.5,1860)';
footnote1 f=simplex h=2 j=l '(-12.5,-140)'
                        j=r '(112.5,-140)';
run;
proc gslide gout=vol1.chapt6
            name='e633glin';
title1 draw=(10,5,10,10,90,10,90,5,10,5)pct;
footnote1 ' ';
run;

goptions display;
proc greplay nofs
             igout=vol1.chapt6
             tc=vol1.templ8
             template=e632;
treplay 1:e6_3_3g
        2:e633glin;
run;
quit;
*************************************************;
* e6_3_3i.sas;
*
* zoom on 6.2 using coordinates shown in 6.3.3f&g
*************************************************;

FILENAME filerefi "&pathhpg\e6_3_3i.hpg";
GOPTIONS GSFNAME=filerefi DEVICE=hp7475a GSFMODE=replace noprompt;

goptions nodisplay;

* zoom on new england;
proc greplay nofs
             igout=vol1.chapt6
             gout=vol1.chapt6
             tc=vol1.templ8;
template zoommap;
treplay 1:salesmap;
modify template / name = 'newengl';
run;

* zoom on the legend;
proc greplay nofs
             igout=vol1.chapt6
             gout=vol1.chapt6
             tc=vol1.templ8;
template zoommap;
treplay 2:salesmap;
modify template / name = 'e633lgnd';
run;

goptions display;
proc greplay nofs
             igout=vol1.chapt6
             tc=vol1.templ8;
template zoommap;
treplay 3:newengl
        4:e633lgnd;
run;
quit;
*************************************************;
* e6_3_4A.sas;
*
* Display the panel coordinates used in 6.3.4.
*************************************************;

FILENAME filerefa "&pathhpg\e6_3_4a.hpg";
GOPTIONS GSFNAME=filerefa DEVICE=hp7475a GSFMODE=replace noprompt;

 *  *;
goptions nodisplay noborder;
proc gslide gout=vol1.chapt6 name='e634pan1';
title1 f=simplex j=l h=2 'Panel 1';
title2 f=simplex j=l h=2 '(0,100)' j=r '(100,100)';
footnote1 f=simplex j=l h=2 '(0,0)' j=r '(100,0)';
run;

proc gslide gout=vol1.chapt6 name='e634pan2';
title1 f=simplex j=l h=3 '(0,90)' j=r '(50,90)';
title10 f=simplex j=c h=4 'Panel 2';
footnote1 f=simplex j=l h=3 '(0,45)' j=r '(50,45)';
run;

proc gslide gout=vol1.chapt6 name='e634pan3';
title1 f=simplex j=l h=3 '(50,90)' j=r '(100,90)';
title10 f=simplex j=c h=4 'Panel 3';
footnote1 f=simplex j=l h=3 '(50,45)' j=r '(100,45)';
run;

proc gslide gout=vol1.chapt6 name='e634pan4';
title1 f=simplex j=l h=3 '(0,45)' j=r '(50,45)';
title10 f=simplex j=c h=4 'Panel 4';
footnote1 f=simplex j=l h=3 '(0,0)' j=r '(50,0)';
run;

proc gslide gout=vol1.chapt6 name='e634pan5';
title1 f=simplex j=l h=3 '(50,45)' j=r '(100,45)';
title10 f=simplex j=c h=4 'Panel 5';
footnote1 f=simplex j=l h=3 '(50,0)' j=r '(100,0)';
run;

proc gslide gout=vol1.chapt6 name='e634bord';
title1 ' ';
footnote ' ';
run;

*/    *;

goptions display;
proc greplay nofs
             igout=vol1.chapt6
             tc=vol1.templ8
             template=showfive;
treplay 1:e634pan1
        2:e634pan2
        3:e634pan3
        4:e634pan4
        5:e634pan5
        6:e634bord;
run;
quit;
*************************************************;
* e6_3_4b.sas;
*
* Display four panels and a title banner
* using a full sized overlayed title panel.
*************************************************;

FILENAME filerefb "&pathhpg\e6_3_4b.hpg";
GOPTIONS GSFNAME=filerefb DEVICE=hp7475a GSFMODE=replace noprompt;

goptions nodisplay;
proc gplot data=vol1.ca88air
           gout=vol1.chapt6;
where station='SFO';
plot o3*month / name='e634p2';
title1 h=2 f=simplex 'Ozone';
symbol c=black l=1 i=join;
run;

proc gplot data=vol1.ca88air
           gout=vol1.chapt6;
where station='SFO';
plot co*month / name='e634p3';
title1 h=2 f=simplex 'Carbon Monoxide';
run;

proc gplot data=vol1.ca88air
           gout=vol1.chapt6;
where station='SFO';
plot no3*month / name='e634p4';
title1 h=2 f=simplex 'Nitrate';
run;

proc gplot data=vol1.ca88air
           gout=vol1.chapt6;
where station='SFO';
plot so4*month / name='e634p5';
title1 h=2 f=simplex 'Sulfate';
run;

* Create the title panel;
proc gslide gout=vol1.chapt6
            name='e634full';
title1 h=2 f=duplex '1988 - San Francisco Air Quality Data';
footnote1;
run;

goptions display;
proc greplay nofs
             igout=vol1.chapt6
             tc=vol1.templ8
             template=fttl2by2 ;
treplay 1:e634full
        2:e634p2
        3:e634p3
        4:e634p4
        5:e634p5;
run;
*************************************************;
* e6_3_4c.sas;
*
* Display four panels and a title banner
* using a full sized overlayed title panel.
*************************************************;

FILENAME filerefc "&pathhpg\e6_3_4c.hpg";
GOPTIONS GSFNAME=filerefc DEVICE=hp7475a GSFMODE=replace noprompt;

goptions nodisplay;
proc gplot data=vol1.ca88air
           gout=vol1.chapt6;
where station='SFO';
plot o3*month / name='e634p2';
title1 h=2 f=simplex 'Ozone';
symbol c=black l=1 i=join;
run;

proc gplot data=vol1.ca88air
           gout=vol1.chapt6;
where station='SFO';
plot co*month / name='e634p3';
title1 h=2 f=simplex 'Carbon Monoxide';
run;

proc gplot data=vol1.ca88air
           gout=vol1.chapt6;
where station='SFO';
plot no3*month / name='e634p4';
title1 h=2 f=simplex 'Nitrate';
run;

proc gplot data=vol1.ca88air
           gout=vol1.chapt6;
where station='SFO';
plot so4*month / name='e634p5';
title1 h=2 f=simplex 'Sulfate';
run;

* Create the title panel;
proc gslide gout=vol1.chapt6
            name='e634full';
title1 h=2 f=duplex '1988 - San Francisco Air Quality Data';
footnote1;
run;

goptions display;
proc greplay nofs
             igout=vol1.chapt6
             tc=vol1.templ8
             template=fttl2by2 ;
treplay 1:e634full
        2:e634p2
        3:e634p3
        4:e634p4
        5:e634p5;
run;
*************************************************;
* e6_3_4d.sas;
*
* Display four panels and a title banner.
*************************************************;

FILENAME filerefd "&pathhpg\e6_3_4d.hpg";
GOPTIONS GSFNAME=filerefd DEVICE=hp7475a GSFMODE=replace noprompt;

* reset aspect ratio for the title panel;
goptions aspect=.07198 nodisplay;
proc gslide gout=vol1.chapt6
            name='e634titl';
title1 h=20 f=duplex '1988 - San Francisco Air Quality Data';
footnote1;
run;

* return aspect ratio to original ratio;
goptions aspect=.7198;

proc gplot data=vol1.ca88air
           gout=vol1.chapt6;
where station='SFO';
plot o3*month / name='e634p2';
title1 h=2 f=simplex 'Ozone';
symbol c=black l=1 i=join;
run;

proc gplot data=vol1.ca88air
           gout=vol1.chapt6;
where station='SFO';
plot co*month / name='e634p3';
title1 h=2 f=simplex 'Carbon Monoxide';
run;

proc gplot data=vol1.ca88air
           gout=vol1.chapt6;
where station='SFO';
plot no3*month / name='e634p4';
title1 h=2 f=simplex 'Nitrate';
run;

proc gplot data=vol1.ca88air
           gout=vol1.chapt6;
where station='SFO';
plot so4*month / name='e634p5';
title1 h=2 f=simplex 'Sulfate';
run;

goptions display;
proc greplay nofs
             igout=vol1.chapt6
             tc=vol1.templ8
             template=titl2by2;
treplay 1:e634titl
        2:e634p2
        3:e634p3
        4:e634p4
        5:e634p5;
run;
*************************************************;
* e6_3_5.sas;
*
* Display titles using perspective.
*************************************************;

FILENAME filerefa "&pathhpg\e6_3_5.hpg";
GOPTIONS GSFNAME=filerefa DEVICE=hp7475a GSFMODE=replace noprompt;

goptions nodisplay;
proc gslide gout=vol1.chapt6
            name='e635';
title1 h=4 f=duplex 'Long long ago in a galaxy     ';
title2 h=4 f=duplex 'far far away there was        ';
title3 h=4 f=duplex 'fought a desperate rebellion  ';
title4 h=4 f=duplex 'against a cruel and tyrannical';
title5 h=4 f=duplex 'empire.                       ';
footnote1;
run;

goptions display;
proc greplay nofs
             igout=vol1.chapt6
             tc=vol1.templ8
             template=horizon;
treplay 1:e635;
run;
*************************************************;
* e6_3_5A.sas;
*
* Display the panel coordinates used in 6.3.5b.
*************************************************;

FILENAME filerefa "&pathhpg\e6_3_5a.hpg";
GOPTIONS GSFNAME=filerefa DEVICE=hp7475a GSFMODE=replace noprompt;

 *  *;
goptions nodisplay noborder;
proc gslide gout=vol1.chapt6 name='e635pan1';
title1 f=simplex j=l h=2 'Panel 1';
title2 ' ';
title3 ' ';
title4 ' ';
title5 f=simplex h=2 m=(30,90)pct '(35,70)'
                     m=(60,90)pct '(65,70)';
footnote1 f=simplex j=l h=2 '(0,0)' j=r '(100,0)';
run;

proc gslide gout=vol1.chapt6 name='e635horz';
title1 ' ';
footnote ' ';
run;

*/    *;

goptions display;
proc greplay nofs
             igout=vol1.chapt6
             tc=vol1.templ8
             template=showhorz;
treplay 1:e635pan1
        2:e635horz;
run;
quit;
*************************************************;
* e6_3_5c.sas;
*
* Display titles using perspective.
*************************************************;

FILENAME filerefc "&pathhpg\e6_3_5c.hpg";
GOPTIONS GSFNAME=filerefc DEVICE=hp7475a GSFMODE=replace noprompt;

goptions nodisplay;
proc gslide gout=vol1.chapt6
            name='e635';
title1 h=4 f=duplex 'Long long ago in a galaxy     ';
title2 h=4 f=duplex 'far far away there was        ';
title3 h=4 f=duplex 'fought a desperate rebellion  ';
title4 h=4 f=duplex 'against a cruel and tyrannical';
title5 h=4 f=duplex 'empire.                       ';
footnote1;
run;

goptions display;
proc greplay nofs
             igout=vol1.chapt6
             tc=vol1.templ8
             template=horizon;
treplay 1:e635;
run;
*************************************************;
* e6_3_6.sas;
*
* Display text on a graphic using a template.
*************************************************;

FILENAME fileref "&pathhpg\e6_3_6.hpg";
GOPTIONS GSFNAME=fileref DEVICE=hp7475a GSFMODE=replace noprompt;

goptions nodisplay;
proc gslide gout=vol1.chapt6
            name='e636txt';
title1 h=6 f=duplex 'Average Ozone  ';
title2 h=6 f=duplex 'levels exceeded';
title3 h=6 f=duplex '2.6 pphm four  ';
title4 h=6 f=duplex 'months in the  ';
title5 h=6 f=duplex 'area around    ';
title6 h=6 f=duplex 'Livermore.     ';
footnote1;
run;

proc gplot data=vol1.ca88air
           gout=vol1.chapt6;
where station='LIV';
plot o3*month / name='e636'
                vref=2.6;
title1 h=2 '1988 Ozone Levels';
title2 h=1.5 f=simplex 'Livermore';
symbol c=black l=1 i=join v=dot;
footnote f=simplex h=2 'Figure 6.3.6b';
run;

goptions display;
proc greplay nofs
             igout=vol1.chapt6
             tc=vol1.templ8
             template=insert;
treplay 1:e636txt
        2:e636;
run;
*************************************************;
* e6_3_6b.sas;
*
* Display text on a graphic using a template.
*************************************************;

FILENAME filerefb "&pathhpg\e6_3_6b.hpg";
GOPTIONS GSFNAME=filerefb DEVICE=hp7475a GSFMODE=replace noprompt;

goptions nodisplay;
proc gslide gout=vol1.chapt6
            name='e636txt';
title1 h=6 f=duplex 'Average Ozone  ';
title2 h=6 f=duplex 'levels exceeded';
title3 h=6 f=duplex '2.6 pphm four  ';
title4 h=6 f=duplex 'months in the  ';
title5 h=6 f=duplex 'area around    ';
title6 h=6 f=duplex 'Livermore.     ';
footnote1;
run;

proc gplot data=vol1.ca88air
           gout=vol1.chapt6;
where station='LIV';
plot o3*month / name='e636'
                vref=2.6;
title1 h=2 '1988 Ozone Levels';
title2 h=1.5 f=simplex 'Livermore';
symbol c=black l=1 i=join v=dot;
footnote f=simplex h=2 'Figure 6.3.6b';
run;

goptions display;
proc greplay nofs
             igout=vol1.chapt6
             tc=vol1.templ8
             template=insert;
treplay 1:e636txt
        2:e636;
run;
*************************************************;
* e6_3_6c.sas;
*
* Overlay a graph on top of a map using a template.
*************************************************;

libname gdevice0 "&pathhpg";

goptions reset=all border;
FILENAME filerefc "&pathhpg\e6_3_6c.cgm";
GOPTIONS GSFNAME=filerefc DEVICE=cgmwpga GSFMODE=replace noprompt;

data sales;
year=1982; sales=0.5; output;
year=1983; sales=0.8; output;
year=1984; sales=0.9; output;
year=1985; sales=1.1; output;
year=1986; sales=1.0; output;
year=1987; sales=1.2; output;
year=1988; sales=0.9; output;
year=1989; sales=1.6; output;
year=1990; sales=2.4; output;
year=1991; sales=2.8; output;
year=1992; sales=3.1; output;
year=1993; sales=3.0; output;
run;

goptions htext=2;
proc gplot data=sales gout=vol1.chapt6;
plot sales*year / name='annsales'
                  haxis = 1980 to 1995 by 5;
symbol1 c=black v=dot i=join l=1;
title1 'Annual Sales in Millions of Dollars';
run;

goptions display;
proc gmap map=maps.us
          data=vol1.salesmap
          gout=vol1.chapt6;
id state;
choro code / coutline=black
             name='e636sale'
             discrete;
pattern1 v=msolid c=gray00;
pattern2 v=msolid c=gray33;
pattern3 v=msolid c=gray66;
pattern4 v=msolid c=gray99;
pattern5 v=msolid c=graycc;
pattern6 v=msolid c=grayff;

title1 'National Sales';
footnote f=simplex h=2 j=l 'Figure 6.3.6c';
run;

goptions display;
proc greplay nofs
             igout=vol1.chapt6
             tc=vol1.templ8
             template=insert2;
treplay 1:annsales
        2:e636sale;
run;
quit;
*************************************************;
* e6_3_6d.sas;
*
* Overlay a graph on top of a map using a template.
*************************************************;

libname gdevice0 "&pathhpg";

goptions reset=all border;
FILENAME filerefd "&pathhpg\e6_3_6d.cgm";
GOPTIONS GSFNAME=filerefd DEVICE=cgmwpga GSFMODE=replace noprompt;

 * *;
data sales;
year=1982; sales=0.5; output;
year=1983; sales=0.8; output;
year=1984; sales=0.9; output;
year=1985; sales=1.1; output;
year=1986; sales=1.0; output;
year=1987; sales=1.2; output;
year=1988; sales=0.9; output;
year=1989; sales=1.6; output;
year=1990; sales=2.4; output;
year=1991; sales=2.8; output;
year=1992; sales=3.5; output;
year=1993; sales=4.2; output;
run;

proc gplot data=sales gout=vol1.chapt6;
plot sales*year / name='annsales'
                  haxis = 1980 to 1995 by 5;
symbol1 c=black v=dot i=join l=1;
title1 'Annual Sales in Millions of Dollars';
run;

proc gmap map=maps.us
          data=vol1.salesmap
          gout=vol1.chapt6;
id state;
choro code / coutline=black
             name='e636sale'
             discrete;
pattern1 v=msolid c=gray00;
pattern1 v=msolid c=gray33;
pattern1 v=msolid c=gray66;
pattern1 v=msolid c=gray99;
pattern1 v=msolid c=graycc;
pattern1 v=msolid c=grayff;

title1 'National Sales';
footnote f=simplex h=2 'Figure 6.3.6d';
run;

goptions display;
proc greplay nofs
             igout=vol1.chapt6
             tc=vol1.templ8
             template=insert2;
treplay 1:annsales
        2:e636sale;
run;
quit;
*************************************************;
* e6_3_7a.sas;
*
* Preview the template;
*************************************************;

FILENAME filerefa "&pathhpg\e6_3_7a.hpg";
goptions reset=all border
         DEVICE=hp7475a noprompt
         GSFNAME=filerefa GSFMODE=replace;

goptions display;
proc greplay igout=vol1.chapt6 nofs
             tc=vol1.templ8;
preview fullnine;
run;
quit;
*************************************************;
* e6_3_7c.sas;
*
* Place multiple plots per page;
*************************************************;

FILENAME filerefc "&pathhpg\e6_3_7c.hpg";
goptions reset=all
         DEVICE=hp7475a noprompt
         GSFNAME=filerefc GSFMODE=replace;

axis1 order=(0 to 2 by 1)
      label=none;

goptions nodisplay;

proc gplot data=vol1.biomass gout=vol1.chapt6;
plot bmcrus * bmcrus / name='e6371' vaxis= axis1 haxis= axis1;
plot bmcrus * bmmol  / name='e6372' vaxis= axis1 haxis= axis1;
plot bmcrus * bmpoly / name='e6373' vaxis= axis1 haxis= axis1;
plot bmmol  * bmcrus / name='e6374' vaxis= axis1 haxis= axis1;
plot bmmol  * bmmol  / name='e6375' vaxis= axis1 haxis= axis1;
plot bmmol  * bmpoly / name='e6376' vaxis= axis1 haxis= axis1;
plot bmpoly * bmcrus / name='e6377' vaxis= axis1 haxis= axis1;
plot bmpoly * bmmol  / name='e6378' vaxis= axis1 haxis= axis1;
plot bmpoly * bmpoly / name='e6379' vaxis= axis1 haxis= axis1;
title1 ' ';
footnote ' ';
run;

* create the titles;
proc gslide gout=vol1.chapt6 name='e637ttl';
title1 'Biomass in GM Wet Weight';
title2 h=1.5 f=simplex 'Figure 6.3.7c';
* Horizontal graph labels;
title3 h=4pct f=simplex
     move=( 6,84)pct '  Crustaceans'
     move=(37,84)pct '  Molluscs'
     move=(68,84)pct '  Polychaetes';
* Vertical graph labels;
title4 h=4pct a=90 f=simplex
     move=(5,56)pct 'Crustaceans'
     move=(5,28)pct '  Molluscs'
     move=(5,0 )pct 'Polychaetes';
run;

goptions display;
proc greplay igout=vol1.chapt6 nofs
             tc=vol1.templ8
             template=fullnine;
treplay 1=e6371
        2=e6372
        3=e6373
        4=e6374
        5=e6375
        6=e6376
        7=e6377
        8=e6378
        9=e6379
       10=e637ttl;
run;
quit;
*************************************************;
* e6_3_7d.sas;
*
* Preview panel definitions.
*************************************************;

 FILENAME filerefd "&pathhpg\e6_3_7d.hpg";
 goptions reset=all border
          DEVICE=hp7475a noprompt
          GSFNAME=filerefd GSFMODE=replace;

goptions display;
proc greplay igout=vol1.chapt6 nofs
             tc=vol1.templ8 ;
  preview shownine;
run;
quit;
*************************************************;
* e6_3_7f.sas;
*
* Place multiple plots per page;
*************************************************;

 FILENAME filereff "&pathhpg\e6_3_7f.hpg";
 goptions reset=all border
          DEVICE=hp7475a noprompt
          GSFNAME=filereff GSFMODE=replace;

axis1 order=(0 to 2 by 1)
      label=none;

goptions nodisplay;

proc gplot data=vol1.biomass gout=vol1.chapt6;
plot bmcrus * bmcrus / name='e6371' vaxis= axis1 haxis= axis1;
plot bmcrus * bmmol  / name='e6372' vaxis= axis1 haxis= axis1;
plot bmcrus * bmpoly / name='e6373' vaxis= axis1 haxis= axis1;
plot bmmol  * bmcrus / name='e6374' vaxis= axis1 haxis= axis1;
plot bmmol  * bmmol  / name='e6375' vaxis= axis1 haxis= axis1;
plot bmmol  * bmpoly / name='e6376' vaxis= axis1 haxis= axis1;
plot bmpoly * bmcrus / name='e6377' vaxis= axis1 haxis= axis1;
plot bmpoly * bmmol  / name='e6378' vaxis= axis1 haxis= axis1;
plot bmpoly * bmpoly / name='e6379' vaxis= axis1 haxis= axis1;
title1 ' ';
footnote ' ';
run;

* set aspect for large titles;
goptions aspect= .07198;
proc gslide gout=vol1.chapt6 name='e63710';
title1 h=20 f=duplex 'Biomass in GM Wet Weight';
title2 h=13 f=simplex 'Figure 6.3.7f';
run;

* Generate titles for the columns;
* the title height is 6 percent and width is 31 percent;
* aspect = (.7198)(.06)/(.31);
goptions aspect= .1393;
proc gslide gout=vol1.chapt6 name='e63711';
title1 h=32 f=simplex 'Crustaceans';
run;

proc gslide gout=vol1.chapt6 name='e63712';
title1 h=32 f=simplex 'Molluscs';
run;
proc gslide gout=vol1.chapt6 name='e63713';
title1 h=32 f=simplex 'Polychaetes';
run;

* Generate titles for the rows;
* the title width is 6 percent and height is 28 percent;
* aspect ratio is (.7198)(.28)/(.06);
goptions aspect= 3.3591;
proc gslide gout=vol1.chapt6 name='e63714';
title1 h=6 f=simplex a=90 'Crustaceans';
run;
proc gslide gout=vol1.chapt6 name='e63715';
title1 h=6 f=simplex a=90 'Molluscs';
run;
proc gslide gout=vol1.chapt6 name='e63716';
title1 h=6 f=simplex a=90 'Polychaetes';
run;

goptions display;
proc greplay igout=vol1.chapt6 nofs
             tc=vol1.templ8
             template=shownine;
treplay 1=e6371
        2=e6372
        3=e6373
        4=e6374
        5=e6375
        6=e6376
        7=e6377
        8=e6378
        9=e6379
       10=e63710
       11=e63711
       12=e63712
       13=e63713
       14=e63714
       15=e63715
       16=e63716;
run;
quit;
