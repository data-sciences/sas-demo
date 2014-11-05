 /*------------------------------------------------------------------ */
 /*              Validating Clinical Trials Using SAS®                */
 /*                                                                   */                                                                                               
 /*               by Carol I. Matthews and Brian C. Shilling          */
 /*       Copyright(c) 2008 by SAS Institute Inc., Cary, NC, USA      */
 /*                        ISBN 978-1-59994-128-8                     */                  
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
 /* addressed to the authors:                                         */
 /*                                                                   */
 /* SAS Institute Inc.                                                */
 /* SAS Press Series                                                  */
 /* Attn: Carol I. Matthews and Brian C. Shilling                     */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  saspress@sas.com           */
 /* Use this for subject field:                                       */
 /*     Comments for Carol I. Matthews and Brian C. Shilling          */
 /*                                                                   */
 /*-------------------------------------------------------------------*/


%macro mcheck(inset=check,why=) ;

   /* IF CHECK DATASET HAS OBS THEN PRINT AND WARN IN LOG */

   data _null_ ;
      if 0 then set &inset nobs=numobs ;
      call symput("CCCC", left(put(numobs,5.))) ;
      stop ;
   run ;

   %if &cccc ne 0 %then
      %do ;
         proc print data=&inset ;
            title "WHOOPS: &why" ;
         run ;
         title;
         %put WARNING: &why ;
      %end ;

%mend mcheck ;

/**************************************************************************
   PROGRAM:   MCHECK.SAS
   CREATED:   12JAN06 C.Matthews

   PURPOSE:   prints checking datasets and puts a warning note in the log

   NOTES:     + used outside of a data step

   PARAMETERS:

         INSET = Dataset to print (default=CHECK)
           WHY = Title for proc print and warning message for the log

   EXAMPLE:

      data good check ;
         merge ds1 (in=in1)
               ds2 (in=in2) ;
         if in1 and in2 then output good ;
         else if in1 and not in2 then output check ;
      run ;

      %mcheck(why=IN DS1 BUT NOT INDS2?!)

      result:

         proc print of all obs in the check dataset, title on the output is
           'IN DS1 BUT NOT IN DS2?!' (ONLY if check dataset has observations)
         if check dataset has observations, a line in the .log will say
           WARNING: IN DS1 BUT NOT IN DS2?!

*********************************************************************************
PROGRAMMED USING SAS VERSION 9 - JANUARY 2006
*********************************************************************************/
