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


/*--------------------------------------------------------------**
** PROGRAM:    CHAPTER7_EXAMPLES.SAS
**
** PURPOSE:    PROGRAM EXAMPLES SHOWN IN CHAPTER 7
**
** CREATED:    12/2007
**
** INPUT:      ORGLIB.MEDHIST
**
**--------------------------------------------------------------**
** PROGRAMMED USING SAS VERSION 9.1.3                           **
**--------------------------------------------------------------*/

libname orglib "C:\Data\Original" ;

options nodate nocenter noreplace ls=68 ;

**-------------------------------------------------------------------------------**;
**  EXAMPLE 7.1 - CHECKING FOR LONGEST TEXT VALUE                                **;
**------------------------------------------------------------------------------**;

data check ;
   set orglib.medhist end=lastrec ;
   length longtxt $200 ;
   retain maxlen 0 longtxt ;
   if maxlen le length(trim(mhcom1)) then
   do ;
      maxlen  = length(trim(mhcom1)) ;
      longtxt = mhcom1 ;
   end ;
   if lastrec then put '>>>> LONGEST TEXT VALUE: >>>> ' inv_no= patid= longtxt= ;
run ;

