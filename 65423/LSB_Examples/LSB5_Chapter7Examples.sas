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


/* Chapter 7 */

/* Section 7.2 */

/* Program */
%LET flowertype = Ginger;

* Read the data and subset with a macro variable;
DATA flowersales;
   INFILE 'c:\MyRawData\TropicalFlowers.dat';
   INPUT CustomerID $4. @6 SaleDate MMDDYY10. @17 Variety $9. 
         SaleQuantity SaleAmount;
   IF Variety = "&flowertype";
RUN;
* Print the report using a macro variable;
PROC PRINT DATA = flowersales;
   FORMAT SaleDate WORDDATE18. SaleAmount DOLLAR7.;
   TITLE "Sales of &flowertype";
RUN;


/* Section 7.3 */

/* Program */
%LET SumVar = Quantity;

* Read the data and subset with a macro variable;
DATA flowersales;
   INFILE 'c:\MyRawData\TropicalFlowers.dat';
   INPUT CustomerID $4. @6 SaleDate MMDDYY10. @17 Variety $9. 
         SaleQuantity SaleAmount;
RUN;
* Create RTF file with today's date in the file name;
ODS RTF FILE="c:\MyRTFFiles\FlowerSales_&SYSDATE..rtf";
* Summarize the sales for the selected variable;
PROC MEANS DATA = flowersales SUM MIN MAX MAXDEC=0;
   VAR Sale&SumVar;
   CLASS Variety;
   TITLE "Summary of Sales &SumVar by Variety";
RUN;
* Close the RTF file;
ODS RTF CLOSE;


/* Section 7.4 */

/* Program */
* Macro to print 5 largest sales;
%MACRO sample;
   PROC SORT DATA = flowersales;
      BY DESCENDING SaleQuantity;
   RUN;
   PROC PRINT DATA = flowersales (OBS = 5);
      FORMAT SaleDate WORDDATE18. SaleAmount DOLLAR7.;
      TITLE 'Five Largest Sales by Quantity';
   RUN;
%MEND sample;

* Read the flower sales data;
DATA flowersales;
   INFILE 'c:\MyRawData\TropicalFlowers.dat';
   INPUT CustomerID $4. @6 SaleDate MMDDYY10. @17 Variety $9. 
         SaleQuantity SaleAmount;
RUN;

* Invoke the macro;
%sample


/* Section 7.5 */

/* Program */
* Macro with parameters;
%MACRO select(customer=,sortvar=);
   PROC SORT DATA = flowersales OUT = salesout;
      BY &sortvar;
      WHERE CustomerID = "&customer";
   RUN;
   PROC PRINT DATA = salesout;
      FORMAT SaleDate WORDDATE18. SaleAmount DOLLAR7.;
      TITLE1 "Orders for Customer Number &customer";
      TITLE2 "Sorted by &sortvar";
   RUN;
%MEND select;


* Read all the flower sales data;
DATA flowersales;
   INFILE 'c:\MyRawData\TropicalFlowers.dat';
   INPUT CustomerID $4. @6 SaleDate MMDDYY10. @17 Variety $9. 
         SaleQuantity SaleAmount;
RUN;

*Invoke the macro;
%select(customer = 356W, sortvar = SaleQuantity)
%select(customer = 240W, sortvar = Variety)



/* Section 7.6 */

/* Program */
%MACRO dailyreports;
   %IF &SYSDAY = Monday %THEN %DO;
      PROC PRINT DATA = flowersales;
         FORMAT SaleDate WORDDATE18. SaleAmount DOLLAR7.;
         TITLE 'Monday Report: Current Flower Sales';
      RUN;
   %END;
/*   %ELSE %IF &SYSDAY = Tuesday %THEN %DO;*/
   %ELSE %IF &SYSDAY = Sunday %THEN %DO;
      PROC MEANS DATA = flowersales MEAN MIN MAX;
         CLASS Variety;
         VAR SaleQuantity;
         TITLE 'Tuesday Report: Summary of Flower Sales';
      RUN;
   %END;
%MEND dailyreports;
DATA flowersales;
   INFILE 'c:\MyRawData\TropicalFlowers.dat';
   INPUT CustomerID $4. @6 SaleDate MMDDYY10. @17 Variety $9. 
         SaleQuantity SaleAmount;
RUN;
%dailyreports


/* Section 7.7 */

/* Program */
* Read the raw data;
DATA flowersales;
   INFILE 'c:\MyRawData\TropicalFlowers.dat';
   INPUT CustomerID $4. @6 SaleDate MMDDYY10. @17 Variety $9. 
         SaleQuantity SaleAmount;
PROC SORT DATA = flowersales;
   BY DESCENDING SaleAmount;
RUN;
* Find biggest order and pass the customer id to a macro variable;
DATA _NULL_;
   SET flowersales;
   IF _N_ = 1 THEN CALL SYMPUT("selectedcustomer",CustomerID);
   ELSE STOP;
RUN;
PROC PRINT DATA = flowersales;
   WHERE CustomerID = "&selectedcustomer";
   FORMAT SaleDate WORDDATE18. SaleAmount DOLLAR7.;
   TITLE "Customer &selectedcustomer Had the Single Largest Order";
RUN;




