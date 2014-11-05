/*-------------------------------------------------------------------*/
 /*       The Little SAS(r) Book: A Primer, Fifth Edition             */
 /*          by Lora D. Delwiche and Susan J. Slaughter               */
 /*       Copyright(c) 2012 by SAS Institute Inc., Cary, NC, USA      */
 /*                   SAS Publications order                          */
 /*                   ISBN 978-1-61290-343-9                          */
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
 /* Date Last Updated: 30SEP2012                                      */
 /*-------------------------------------------------------------------*/
 /* Questions or problem reports concerning this material may be      */
 /* addressed to the author:                                          */
 /*                                                                   */
 /* SAS Institute Inc.                                                */
 /* SAS Press                                                         */
 /* Attn: Lora Delwiche and Susan Slaughter                           */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  saspress@sas.com           */
 /* Use this for subject field:                                       */
 /*     Comments for Lora Delwiche and Susan Slaughter                */
 /*                                                                   */
 /*-------------------------------------------------------------------*/


/* Chapter 8 */

/* Section 8.2 */

DATA chocolate;
   INFILE 'c:\MyRawData\Choc.dat';
   INPUT AgeGroup $ FavoriteFlavor $ @@;
RUN;
PROC FORMAT;
   VALUE $AgeGp 'A' = 'Adult' 'C' = 'Child';
RUN;
* Bar chart for favorite flavor;
PROC SGPLOT DATA = chocolate;
   VBAR FavoriteFlavor / GROUP = AgeGroup GROUPDISPLAY = CLUSTER;
   FORMAT AgeGroup $AgeGp.;   
   LABEL FavoriteFlavor = 'Flavor of Chocolate';
   TITLE 'Favorite Chocolate Flavors by Age';
RUN;


/* Section 8.3 */

DATA contest;
   INFILE 'c:\MyRawData\Reading.dat';
   INPUT Name $ NumberBooks @@;
RUN;
* Create histogram and density curves;
PROC SGPLOT DATA = contest;
   HISTOGRAM NumberBooks / BINWIDTH = 2 SHOWBINS SCALE = COUNT;
   DENSITY NumberBooks;
   DENSITY NumberBooks / TYPE = KERNEL;
   			TITLE 'Reading Contest';
RUN;


/* Section 8.4 */

DATA bikerace;
   INFILE 'c:\MyRawData\Criterium.dat';
   INPUT Division $ NumberLaps @@;
RUN;
* Create box plot;
PROC SGPLOT DATA = bikerace;
   VBOX NumberLaps / CATEGORY = Division;
   TITLE 'Bicycle Criterium Results by Division';
RUN;


/* Section 8.5 */

DATA wings;
   INFILE 'c:\MyRawData\Birds.dat';
   INPUT Name $12. Type $ Length Wingspan @@;
RUN;
* Plot Wingspan by Length;
PROC FORMAT;
   VALUE $birdtype
      'S' = 'Songbirds'
      'R' = 'Raptors';
RUN;
PROC SGPLOT DATA = wings;
   SCATTER X = Wingspan Y = Length / GROUP = Type;
   FORMAT Type $birdtype.;
   TITLE 'Comparison of Wingspan vs. Length';
RUN;


/* Section 8.6 */

DATA electricity;
   INFILE 'c:\MyRawData\Hourly.dat';
   INPUT Time kWh @@;
RUN;
* Plot temperatures by time;
PROC SGPLOT DATA = electricity;
   SERIES X = Time Y = kWh / MARKERS;
   TITLE 'Hourly Use of Electricity';
RUN;


/* Section 8.7 */

DATA Olympic1500;
   INFILE 'C:\MyRawData\Olympic1500.dat';
   INPUT Year Men @@;
RUN;
PROC SGPLOT DATA = Olympic1500;
   LOESS X = Year Y = Men / NOMARKERS CLM NOLEGCLM;
   REG X = Year Y = Men;
   LABEL Men = 'Time in Seconds';
   TITLE "Olympic Times for Men's 1500 Meter Run";
RUN;


/* Section 8.8 */

DATA cities;
   INFILE 'c:\MyRawData\ThreeCities.dat';
   INPUT Month IntFalls Raleigh Yuma @@;
RUN;
* Plot average high and low temperatures by city;
PROC SGPLOT DATA = cities;
   SERIES X = Month Y = IntFalls;
   SERIES X = Month Y = Raleigh;
   SERIES X = Month Y = Yuma;
   REFLINE 32 75 / LABEL = ('32 degrees' '75 degrees') TRANSPARENCY = 0.5;
   XAXIS TYPE = DISCRETE;
   YAXIS LABEL = 'Average High Temperature (F)';
   TITLE 'Temperatures for International Falls, Raleigh, and Yuma';
RUN;


/* Section 8.9 */

DATA Olympic1500;
   INFILE 'c:\MyRawData\OlympicWithWR1500.dat';
   INPUT Year OlympicTime WorldRecord @@;
RUN;
PROC SGPLOT DATA = Olympic1500;
   SCATTER X = Year Y = OlympicTime;
   SERIES X = Year Y = WorldRecord;
   KEYLEGEND / LOCATION = INSIDE POSITION = TOPRIGHT;
   INSET 'Olympics not held in' '1940 and 1944' / POSITION = BOTTOMLEFT;
   YAXIS LABEL = 'Time in Seconds';
   TITLE "Times for Men's 1500 Meter Run";
RUN;


/* Section 8.10 */

DATA Olympic1500;
   INFILE 'c:\MyRawData\OlympicWithWR1500.dat';
   INPUT Year OlympicTime WorldRecord @@;
RUN;
PROC SGPLOT DATA = Olympic1500;
   SCATTER X = Year Y = OlympicTime / 
      MARKERATTRS = (SYMBOL = CIRCLEFILLED SIZE = 2MM);
   SERIES X = Year Y = WorldRecord / 
      LINEATTRS = (THICKNESS = 2MM) TRANSPARENCY = .75;
   XAXIS LABELATTRS = (WEIGHT = BOLD);
   YAXIS LABEL = 'Time in Seconds' LABELATTRS = (WEIGHT = BOLD);
   TITLE BOLD "Times for Men's 1500 Meter Run";
RUN;


/* Section 8.11 */

DATA wings;
   INFILE 'c:\MyRawData\Birds.dat';
   INPUT Name $12. Type $ Length Wingspan @@;
RUN;
* Plot Wingspan by Length;
PROC FORMAT;
   VALUE $birdtype
      'S' = 'Songbirds'
      'R' = 'Raptors';
RUN;
PROC SGPANEL DATA = wings;
   PANELBY Type / NOVARNAME SPACING = 5;
   SCATTER X = Wingspan Y = Length;
   FORMAT Type $birdtype.;
   TITLE 'Comparison of Wingspan vs. Length';
RUN;


/* Section 8.12 */	

DATA wings;
   INFILE 'c:\MyRawData\Birds.dat';
   INPUT Name $12. Type $ Length Wingspan @@;
RUN;
* Plot Wingspan by Length;
ODS LISTING GPATH = 
 'c:\MyGraphs' STYLE = JOURNAL;
ODS GRAPHICS / RESET 
   IMAGENAME = 'BirdGraph' 
   OUTPUTFMT = BMP 
   HEIGHT = 2IN WIDTH = 3IN;
PROC SGPLOT DATA = wings;
   SCATTER X = 
   Wingspan Y = Length;
   TITLE 'Comparison of '
      'Wingspan vs. Length';
RUN;
