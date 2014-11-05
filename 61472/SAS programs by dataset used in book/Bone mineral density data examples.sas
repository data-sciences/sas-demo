 /*===================================================================*/
 /*                                                                   */
 /* Generalized Linear and Nonlinear Models for Correlated Data:      */
 /* Theory and Applications Using SAS,                                */
 /* by Edward F. Vonesh                                               */
 /* Copyright (c) 2012 by SAS Institute Inc., Cary, NC, USA           */
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
 /* Date Last Updated: 28AUG2012                                      */
 /*-------------------------------------------------------------------*/
 /* Questions or problem reports concerning this material may be      */
 /* addressed to the authors:                                         */
 /*                                                                   */
 /* SAS Institute Inc.                                                */
 /* SAS Press                                                         */
 /* Attn: Edward F. Vonesh                                            */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /* If you prefer, you can send e-mail to:  saspress@sas.com          */
 /* Use this for subject field:                                       */
 /*    Comments for Edward F. Vonesh                                  */
 /*                                                                   */
 /*===================================================================*/


 /*=====================================================================
   NOTES                                             
   This file contains the SAS code for Generalized Linear and Nonlinear
   Models for Correlated Data: Theory and Applications Using SAS.

   To run the code for the book successfully, you need the following:  

   -------------------------------------------------------
   ---  1) SAS 9.3 (or 9.2) with the modules           ---
   ---     SAS/BASE                                    ---
   ---     SAS/STAT                                    ---
   ---     SAS/GRAPH                                   ---
   ---     SAS/IML                                     ---
   ---     licensed and installed                      ---
   -------------------------------------------------------

   The code for this dataset is organized by chapters. 
 
   Many programs make use of the ODS SELECT statement in order to reduce
   the procedure output to what is shown in the book. For example, the 
   results shown in Output 2.2 of the book are generated using the 
   following code: 

     ods select ClassLevels Nobs RepeatedLevelInfo Multstat ModelANOVA;
     proc glm data=dental;
      class sex;
      model y1 y2 y3 y4=sex/nouni;
      repeated age 4 (8 10 12 14);
      manova;
     run;
     quit;

   Alternatively, one may use the ODS EXCLUDE statement in order to 
   reduce the procedure output to what is shown in the book. For example,      
   the results shown in Output 2.6 of the book are generated using the 
   following code: 
 
     ods exclude Dimensions NObs IterHistory ConvergenceStatus LRT;
     proc mixed data=example2_2_1 method=ml scoring=200;
      class person sex _age_;
      model y = sex sex*age /noint solution ddfm=kenwardroger;
      repeated _age_ / type=un subject=person(sex) r;
      estimate 'Difference in intercepts' sex 1 -1;
      estimate 'Difference in slopes' age*sex 1 -1;
     run;
     quit;

   To see the full output of the procedure, simply remove the ODS 
   SELECT or the ODS EXCLUDE statements.   


   SAS LIBRARY FOLDERS and LIBNAME statements:

   The user will need to create separate SAS library folders on the computer  
   or network of choice for stored programs, datasets, macros and graphics 
   according to the following notes. 

   IMPORTANT NOTE: The SAS library folders described below and within 
   the book are defined for someone using a Windows based PC and may 
   need to be modified according to the user operating environment.
   The folders listed below can be modified by the user but the programs will then
   need to change the LIBNAME statements shown within the program below. 

   NOTES on SAS programs:
 
   The SAS programs are located in two different library folders. The first  
   library folder is named 
     'c:\SAS programs used in book'
   and it contains one SAS file containing all of the programs sorted 
   according to the sequential order in which they appear in the 
   book by chapter. The second library folder is
     'c:\SAS programs by dataset used in book'
   and it contains individual SAS files containing the SAS programs 
   sorted according to the dataset being analyzed.  
    
   NOTES on SAS datasets: 

   In some examples, the original SAS dataset used in the example
   is a permanent SAS dataset. For example, the ADEMEX adequacy example uses 
   the SAS dataset, ADEMEX_Adequacy_Data.sas7bdat, and the program is written 
   assuming this SAS dataset is located in the following library folder: 
     'c:\SAS datasets used in book\' 
   This library folder contains all such permanent SAS datasets including the
   various ADEMEX datasets used in the book. In other examples, the 
   SAS dataset is provided within the example itself. Within the programs, this
   library folder (which one will need to create) is assigned via the following
   LIBNAME statement:
     LIBNAME SASdata 'c:\SAS datasets used in book\';

   NOTES on SAS temporary datasets: 

   In some examples, one or more temporary SAS datasets are created 
   within the SAS program for later use. These datasets are stored 
   in the library folder 
     'c:\SAS datasets used in book\temporary'. 
   This library folder is assigned via the LIBNAME statement:
     LIBNAME SAStemp 'c:\SAS datasets used in book\temporary';
   which of course the user can change if needed.   

   NOTES on Macros: 

   Macros used in select programs are stored in the library folder 
     'c:\SAS macros used in book\' 
   and are accessed via the %INCLUDE statement. 

   NOTES on Graphs:
 
   1) Graphics generated and replayed using GREPLAY are stored in 
   the library folder 
     'c:\SAS graphs used in book\'
   under the graphics catalog "chapterfigures.sas7bcat" on 
   an example by example basis. When a new example is run that
   calls for new graphs to be displayed, any old graphs stored in this
   graphics library catalog are cleared and only the new graphs are stored.
   The library folder is assigned via the LIBNAME statement: 
     LIBNAME SASgraph 'c:\SAS graphs used in book\';
   In addition, the graph generated by GREPLAY is written to the SAS current 
   folder which is the operating environment folder to which many SAS commands
   and actions apply. The current folder is displayed in the status line at 
   the bottom of the main SAS window. By default, SAS uses the folder that 
   is designated by the SASUSER system option in the SAS configuration file 
   as the current folder when you begin your SAS session. Optionally, one can 
   set the current folder to be  
     'c:\SAS graphs used in book\'
   by submitting the change directory (CD) command with the X statement in SAS
   as follows: 
     X 'cd c:\SAS graphs used in book\';
   Currently, this X statement is included in the program below but is commented
   out so that all graphic output will be written to the SAS current folder of the
   operating environment of the user. One need only remove the comment symbol * in  
   front of the X statement and define whatever current path one chooses to write  
   the graphic records to.  

   2) Graphics generated by ODS GRAPHICS are written to the SAS current 
   folder which is the operating environment folder as described above. Optionally,  
   one can set the current folder to be  
     'c:\SAS graphs used in book\'
   by submitting the change directory (CD) command with the X statement in SAS
   as follows: 
     X 'cd c:\SAS graphs used in book\';
   Currently, this X statement is included in the program below but is commented
   out so that all graphic output will be written to the SAS current folder of the
   operating environment of the user. One need only remove the comment symbol * in  
   front of the X statement and define whatever current path one chooses to write  
   the graphic records to.  

   3) Graphics generated by PROC GPLOT, PROC GCHART, etc. are written to the SAS  
   current folder which is the operating environment folder as described above. 
   Optionally, one can set the current folder to be  
     'c:\SAS graphs used in book\'
   by submitting the change directory (CD) command with the X statement in SAS
   as follows: 
     X 'cd c:\SAS graphs used in book\';
   Currently, this X statement is included in the program below but is commented
   out so that all graphic output will be written to the SAS current folder of the
   operating environment of the user. One need only remove the comment symbol * in  
   front of the X statement and define whatever current path one chooses to write  
   the graphic records to.  Alternatively one can write the graphic output/records   
   using a naming convention assigned by the FILENAME statement associated with the
   graph 
 
   FURTHER NOTES on Graphs:   

   When running several SAS graphic programs from different examples 
   or even within the same example, one may need to specify the goption:
     goptions reset=symbol;
   in order to reset all of the prior symbol statements for possibly 
   a new set of symbol definitions.  

 =====================================================================*/

options ps=60 ls=120 center;
title; footnote;
libname SASdata 'c:\SAS datasets used in book\';
libname SAStemp 'c:\SAS datasets used in book\temporary';
libname SASgraph 'c:\SAS graphs used in book\';
/*--------------------------------------------------------------- 
The following X statement is commented out. By removing the 
comment symbol * the X command will set the SAS current folder
to be
  'c:\SAS graphs used in book\'
which is where GREPLAY, GPLOT, etc. records will be written to
provided one has created this SAS library folder.
----------------------------------------------------------------*/
* X 'cd c:\SAS graphs used in book\';
proc greplay igout=SASgraph.chapterfigures nofs;
  delete _all_;
run;
quit;
run;



/*===================================================================*/
/*=== Example 2.2.2. Bone mineral density data                    ===*/
/*===================================================================*/
%include 'c:\SAS macros used in book\GLIMMIX_GOF.sas' /nosource2;

data TBBMD;
 input (subject group date1 tbbmd1 date2 tbbmd2 date3 tbbmd3 
        date4 tbbmd4 date5 tbbmd5) 
       (3. @5 $char1. @7 date7. @15 5.3 @21 date7. 
           @29 5.3 @35 date7. @43 5.3 @49 date7. @57 5.3 
           @63 date7. @71 5.3);
 if tbbmd1^=. & tbbmd2^=. & tbbmd3^=. & 
    tbbmd4^=. & tbbmd5^=. then data='Complete  ';
 else data='Incomplete';
 format date1 date2 date3 date4 date5 date7.;
cards;
101 C 01MAY90 0.815 05NOV90 0.875 24APR91 0.911 30OCT91 0.952 29APR92 0.970
102 P 01MAY90 0.813 05NOV90 0.833 15APR91 0.855 21OCT91 0.881 13APR92 0.901
103 P 02MAY90 0.812 05NOV90 0.812 17APR91 0.843 23OCT91 0.855 15APR92 0.895
104 C 09MAY90 0.804 12NOV90 0.847 29APR91 0.885 11NOV91 0.920 19JUN92 0.948
105 C 14MAY90 0.904 10DEC90 0.927 06MAY91 0.952 04NOV91 0.955 27APR92 1.002
106 P 15MAY90 0.831 26NOV90 0.855 20MAY91 0.890 17DEC91 0.908 15JUL92 0.933
107 P 23MAY90 0.777 05DEC90 0.803 15MAY91 0.817 27NOV91 0.809 04MAY92 0.823
108 C 23MAY90 0.792 03DEC90 0.814
109 C 23MAY90 0.821 03DEC90 0.850 06MAY91 0.865 05NOV91 0.879 29APR92 0.908
110 P 30MAY90 0.823 10DEC90 0.827 21MAY91 0.839 25NOV91 0.885 15MAY92 0.923
111 C 30MAY90 0.828 05DEC90 0.873 07AUG91 0.935 12FEB92 0.952
112 P 04JUN90 0.797 17DEC90 0.818 13MAY91 0.817 16DEC91 0.847 18MAY92 0.862
113 C 04JUN90 0.867 17DEC90 0.873 27JUN91 0.893 09DEC91 0.907 05JUN92 0.934
114 P 11JUN90 0.795 19DEC90 0.812 10JUN91 0.827 22JAN92 0.861 06JUL92 0.889
115 P 11JUN90 0.835 17DEC90 0.849 12JUN91 0.860 11DEC91 0.898 10JUN92 0.913
116 C 11JUN90 0.870 12DEC90 0.872
117 P 20JUN90 0.856
118 C 20JUN90 0.762 14JAN91 0.769
119 P 25JUN90 0.758 13DEC90 0.759 25JUN91 0.805 02DEC91 0.839 08JUN92 0.852
120 C 27JUN90 0.800 26NOV90 0.824 13MAY91 0.859 16DEC91 0.893 20MAY92 0.921
121 P 27JUN90 0.795 02JAN91 0.835 19JUN91 0.856 06JAN92 0.893 10JUN92 0.929
122 C 11JUL90 0.874 23JAN91 0.902 29MAY91 0.922 04DEC91 0.955 15JUN92 0.972
123 C 11JUL90 0.830 16JAN91 0.857 12JUN91 0.891 28FEB92 0.933 12AUG92 0.970
124 P 12JUL90 0.815 11FEB91 0.829 11JUL91 0.852 17FEB92 0.898 27JUL92 0.924
125 P 16JUL90 0.800 16JAN91 0.833 29JUL91 0.866 17FEB92 0.888 05AUG92 0.920
126 C 18JUL90 0.787 16JAN91 0.792 19JUN91 0.830 11DEC91 0.840 29JUN92 0.863
127 C 25JUL90 0.795 17JAN91 0.828 18JUN91 0.838 10DEC91 0.860 14AUG92 0.932
128 P 30JUL90 0.746 31JAN91 0.748 06JUN91 0.756
129 C 01AUG90 0.837 24JAN91 0.849 25JUN91 0.891 18DEC91 0.924 17JUN92 0.961
130 P 01AUG90 0.847 18FEB91 0.829 09JUL91 0.862 20JAN92 0.896 06JUL92 0.904
131 P 02JUL90 0.832 06FEB91 0.862 08JUL91 0.904 06JAN92 0.914 10JUN92 0.952
132 C 08AUG90 0.784 13FEB91 0.785 07AUG91 0.816 02MAR92 0.830 10JUL92 0.849
133 C 08AUG90 0.883 20FEB91 0.892 15JUL91 0.950 26FEB92 0.982 31AUG92 0.993
134 P 13AUG90 0.785 25FEB91 0.778 15JUL91 0.792 22JAN92 0.822 06JUL92 0.816
135 C 13AUG90 0.822
136 P 13AUG90 0.811 20FEB91 0.839 22JUL91 0.869 13JAN92 0.909 29JUN92 0.930
137 P 20AUG90 0.815 30JAN91 0.799 01JUL91 0.810 08JAN92 0.822 10JUN92 0.833
201 P 07MAY90 0.840 07NOV90 0.867 15APR91 0.934 21OCT91 0.947 13APR92 0.953
202 C 07MAY90 0.866 07NOV90 0.924 17APR91 0.954 23OCT91 0.991 15APR92 1.020
203 P 08MAY90 0.905 14NOV90 0.955 01MAY91 0.963 04NOV91 0.986 27APR92 0.987
204 C 09MAY90 0.883 19NOV90 0.916 01MAY91 0.924 06NOV91 0.944 20MAY92 0.994
205 P 14MAY90 0.881 19NOV90 0.904 06MAY91 0.921 18DEC91 0.938 07AUG92 0.972
206 C 16MAY90 0.915 14NOV90 0.940 17APR91 0.945 23OCT91 0.999 13MAY92 1.023
207 C 16MAY90 0.913 28NOV90 0.949 10JUL91 1.010 24FEB92 1.058 08JUL92 1.063
208 P 04JUN90 0.868 17DEC90 0.868 22JUL91 0.923 17FEB92 0.959 20JUL92 0.992
209 C 13JUN90 0.901 19DEC90 0.926 13MAY91 0.952
210 P 18JUN90 0.879 05DEC90 0.873 01MAY91 0.892
211 C 20JUN90 0.876 11FEB91 0.916 15JUL91 0.942
212 P 18JUL90 0.989 30JAN91 1.011 10JUL91 1.053 24JAN92 1.063 03AUG92 1.076
213 P 30JUL90 0.930 21JAN91 0.968 05JUN91 0.987 02DEC91 1.026 15JUN92 1.047
214 C 01AUG90 0.896 21JAN91 0.907 17JUN91 0.942 02DEC91 0.974 15JUN92 0.983
215 P 20AUG90 0.871 13FEB91 0.896 22JUL91 0.932 28FEB92 0.951 22JUL92 0.973
301 C 02MAY90 0.902 12NOV90 0.941 29APR91 0.977 30OCT91 0.995 22APR92 0.988
302 P 07MAY90 0.865 12NOV90 0.910 22APR91 0.918 24OCT91 0.942 18MAY92 0.982
303 P 09MAY90 0.910 14NOV90 0.937 24APR91 0.962 30OCT91 0.997 29APR92 0.999
305 C 21MAY90 0.894 26NOV90 0.894
306 P 21MAY90 0.897
307 C 22MAY90 0.921 05NOV90 0.953 22APR91 0.951 21OCT91 0.992 15APR92 0.992
308 P 23MAY90 0.840 28NOV90 0.868
309 C 30MAY90 0.889 10DEC90 0.920 23MAY91 0.960 25NOV91 0.986 15MAY92 1.017
310 P 13JUN90 0.819 02JAN91 0.853 10JUN91 0.889 25NOV91 0.912 18MAY92 0.913
311 P 13JUN90 0.840 08JAN91 0.874 03JUN91 0.889 09DEC91 0.903 01JUN92 0.924
312 C 13JUN90 0.835 19DEC90 0.866 22MAY91 0.900 16DEC91 0.938 19JUN92 0.965
313 P 18JUN90 0.933 09JAN91 0.923 12JUN91 0.955 29JAN92 1.014 22JUL92 1.022
314 C 18JUN90 0.894 03DEC90 0.922 01MAY91 0.909 04NOV91 0.966 04MAY92 0.981
315 C 18JUN90 0.825 19DEC90 0.867 20MAY91 0.875 09DEC91 0.934 11MAY92 0.961
316 P 20JUN90 0.837 16JAN91 0.869 24JUN91 0.860 09DEC91 0.883 01JUN92 0.894
317 C 25JUN90 0.871 12DEC90 0.875 08MAY91 0.913 06NOV91 0.919 27APR92 0.926
318 P 27JUN90 0.840 22JAN91 0.861 26JUN91 0.904 02MAR92 0.935
319 C 11JUL90 0.909 14JAN91 0.929 03JUN91 0.968 27JAN92 0.999 15JUL92 0.999
320 P 11JUL90 0.923 21JAN91 0.908 24JUN91 0.936 15JAN92 0.946 24JUL92 0.950
321 P 23JUL90 0.874
322 C 23JUL90 0.841 28JAN91 0.853 01JUL91 0.882 27JAN92 0.907 20JUL92 0.912
323 C 23JUL90 0.871 14JAN91 0.885 19JUN91 0.922 18DEC91 0.932 01JUL92 0.971
324 P 25JUL90 0.827 09JAN91 0.823 05JUN91 0.829 02DEC91 0.855 11MAY92 0.868
325 P 30JUL90 0.811 07FEB91 0.839 26JUN91 0.859 22JAN92 0.905 15JUL92 0.946
326 C 01AUG90 0.856 11FEB91 0.876 01AUG91 0.908 17JAN92 0.907 13JUL92 0.922
327 P 06AUG90 0.842 28JAN91 0.851 05AUG91 0.873 02MAR92 0.905 13JUL92 0.912
328 C 06AUG90 0.860 07JAN91 0.870 29JUL91 0.884 14FEB92 0.887 27JUL92 0.931
329 C 06AUG90 0.998
330 P 15AUG90 0.876
331 C 20AUG90 0.971 20FEB91 0.978 31JUL91 0.985 19FEB92 1.026 29JUL92 1.057
401 C 02MAY90 1.028
402 P 02MAY90 0.871 07NOV90 0.904 22APR91 0.963 28OCT91 0.975 22APR92 0.984
403 C 07MAY90 0.981 07NOV90 1.010 15APR91 1.041 23OCT91 1.087 13APR92 1.120
404 P 09MAY90 1.005 28NOV90 1.049 20MAY91 1.038
405 C 14MAY90 1.012 26NOV90 1.051 24APR91 1.080 28OCT91 1.114 29JUN92 1.104
406 P 16MAY90 0.961 14NOV90 0.981 17APR91 0.991 30OCT91 1.002 22APR92 1.011
407 P 21MAY90 0.948 12NOV90 0.987 22APR91 1.023 21OCT91 1.050 13APR92 1.053
408 C 30MAY90 0.907 12DEC90 0.930 22MAY91 0.955 20NOV91 0.972 06MAY92 0.988
409 P 04JUN90 0.936 03DEC90 0.968 11JUN91 0.973 26NOV91 0.987 04MAY92 0.994
410 C 06JUN90 0.856 02JAN91 0.902 26JUN91 0.915 24JAN92 0.923 29JUN92 0.952
411 P 06JUN90 0.970 05DEC90 1.004 10JUN91 1.052 04DEC91 1.092 15JUN92 1.084
412 C 06JUN90 0.927 25FEB91 0.944 01JUL91 0.981 20JAN92 1.005 21JUL92 1.005
413 P 11JUN90 0.921 10DEC90 0.952 13MAY91 0.981 13DEC91 1.009 03JUL92 1.022
414 C 25JUN90 0.883 07JAN91 0.934 29JUL91 0.965 04MAR92 0.971 27JUL92 0.980
415 C 25JUN90 0.955 09JAN91 0.979 17JUN91 1.028 04DEC91 1.046 06MAY92 1.068
416 P 27JUN90 1.014 12DEC90 1.055 08MAY91 1.067 04DEC91 1.096 13MAY92 1.119
417 C 16JUL90 0.938 02JAN91 0.980 17JUN91 1.036 18DEC91 1.044 17JUN92 1.112
418 P 16JUL90 0.961 23JAN91 0.977 24JUN91 0.996 20JAN92 1.016 17JUL92 1.012
419 C 16JUL90 0.879 23JAN91 0.914 17JUL91 0.933 12FEB92 0.945
420 P 17JUL90 0.941 28JAN91 0.967 01JUL91 0.994 20JAN92 1.038 07AUG92 1.022
421 C 18JUL90 0.945 07FEB91 1.024 15JUL91 1.065 27JAN92 1.113 05AUG92 1.126
422 P 18JUL90 0.875 18FEB91 0.892
423 P 23JUL90 0.861 30JAN91 0.870 08JUL91 0.894 24FEB92 0.914 12AUG92 0.927
424 C 25JUL90 0.888 20FEB91 0.903 24JUL91 0.922 19FEB92 0.935 20JUL92 0.988
425 P 30JUL90 0.928 23JAN91 0.959 10JUL91 0.999 08JAN92 1.035 08JUL92 1.066
426 C 08AUG90 0.936 06FEB91 0.942 10JUL91 0.975 15JAN92 1.010 01JUL92 1.014
427 C 08AUG90 0.859 18FEB91 0.910 29JUL91 0.975 19FEB92 1.012 29JUL92 1.023
428 P 15AUG90 0.991 30JAN91 1.037 31JUL91 1.062 14FEB92 1.073 29JUL92 1.083
429 P 15AUG90 0.971 05FEB91 0.973 08JUL91 0.990 29JAN92 1.020 10JUL92 1.051
430 C 22AUG90 0.969 27FEB91 1.011 24JUL91 1.024 26FEB92 1.054 27JUL92 1.071
;
RUN;

********************************************************
* Convert from multivariate mode to longitudinal mode. *
********************************************************;
data example2_2_2;
 set TBBMD;
 array d date1-date5;
 array t tbbmd1-tbbmd5;
 do visit=1 to 5 by 1;
    date=d[visit];
    tbbmd=t[visit];
    years=0.5*(visit-1);
    format date date7.;
    keep subject group data visit date years tbbmd;
    output;
 end;
run;

/*---------------------------*/                    
/*--- Code for Figure 2.2 ---*/                    
/*---------------------------*/                    
goptions reset=symbol;
goptions reset=all rotate=landscape gsfmode=replace ftext=swiss
         htext=2.0 hby=2.0 device=sasemf;
run;
options nobyline;
data calcium;
set example2_2_2;
if group='C';
run;
ods listing;
proc gplot data=calcium gout=SASgraph.chapterfigures ;
plot tbbmd*visit=subject/vaxis=axis1 haxis=axis2 nolegend name='tbbmd_c';
axis1 label=(a=90 'TBBMD (g/cm*cm)')
      minor=none  major=none
      order=(0.7 to 1.2 by 0.1);
axis2 label=('Visit')
      order=(1 to 5 by 1)  
      minor=none major=none;;
symbol1 value=none font=swiss interpol=join line=1 color=black w=1 repeat=55;
title "calcium";
run;
quit;

data placebo;
set example2_2_2;
if group='P';
run;

proc gplot data=placebo gout=SASgraph.chapterfigures ;
plot tbbmd*visit=subject/vaxis=axis1 haxis=axis2 nolegend name='tbbmd_p';
axis1 label=(a=90 'TBBMD (g/cm*cm)')
      minor=none major=none
      order=(0.7 to 1.2 by 0.1);
axis2 label=('Visit')
      order=(1 to 5 by 1)  
      minor=none major=none;;
symbol1 value=none font=swiss interpol=join line=1 color=black w=1 repeat=57;
title "placebo";
run;
proc greplay igout=SASgraph.chapterfigures gout=SASgraph.chapterfigures 
             nofs template=h2ed tc=temp ;
 tdef h2ed     1 / llx=0 lly=0 ulx=0 uly=100
                   urx=100 ury=100 lrx=100 lry=0
               2 / llx=1 lly=15 ulx=1 uly=90
                   urx=49 ury=90 lrx=49 lry=15
               3 / llx=50 lly=15 ulx=50 uly=90
                   urx=99  ury=90 lrx=99  lry=15;
treplay 2:tbbmd_c 3:tbbmd_p name='Fig2_2';
run;
quit;
title;

/*---------------------------*/                    
/*--- Code for Output 2.7 ---*/                    
/*---------------------------*/                    
proc sort data=example2_2_2;
 by subject visit;
run;

ods select ModelInfo Dimensions CovParms FitStatistics SolutionF Estimates; 
proc mixed data=example2_2_2 method=ml;
 where data='Complete';
 class subject group visit;
 model tbbmd=group group*years /noint solution;
 repeated visit /subject=subject type=unr;
 estimate 'slope diff' group*years 1 -1;
run;
quit;


/*---------------------------*/                    
/*--- Code for Output 2.8 ---*/                    
/*---------------------------*/                    
ods select R CovParms FitStatistics SolutionF Estimates; 
proc mixed data=example2_2_2 method=ml;
 class subject group visit;
 model tbbmd=group group*years /noint solution;
 repeated visit /subject=subject type=unr r rcorr;
 estimate 'slope diff' group*years 1 -1;
run;
quit;


/*---------------------------*/                    
/*--- Code for Output 2.9 ---*/
/*--- NOTE: not shown in  ---*/
/*--- the book are the    ---*/
/*--- Estimates H0 output ---*/                    
/*---------------------------*/                    
ods select ModelInfo OptInfo FitStatistics CovParms ParameterEstimates Estimates CovTests ;
proc glimmix data=example2_2_2 method=mmpl scoring=100;
 class subject group visit;
 model tbbmd=group group*years /noint solution
                                covb(details);
 random visit /subject=subject type=unr rside; 
 nloptions technique=newrap;
 covtest 'Compound symmetry'
 general  1 -1                                       ,
          1  0 -1                                    ,
          1  0  0 -1                                 ,
          1  0  0  0 -1                              ,
          0  0  0  0  0 1 -1                         ,
          0  0  0  0  0 1  0 -1                      ,
          0  0  0  0  0 1  0  0 -1                   ,
          0  0  0  0  0 1  0  0  0 -1                ,
          0  0  0  0  0 1  0  0  0  0 -1             ,
          0  0  0  0  0 1  0  0  0  0  0 -1          ,  
          0  0  0  0  0 1  0  0  0  0  0  0 -1       ,
          0  0  0  0  0 1  0  0  0  0  0  0  0 -1    ,
          0  0  0  0  0 1  0  0  0  0  0  0  0  0 -1 /
 estimates;
 covtest 'Heterogeneous compound symmetry'
 general   0 0 0 0  0 1 -1                         ,
           0 0 0 0  0 1  0 -1                      ,
           0 0 0 0  0 1  0  0 -1                   ,
           0 0 0 0  0 1  0  0  0 -1                ,
           0 0 0 0  0 1  0  0  0  0 -1             ,
           0 0 0 0  0 1  0  0  0  0  0 -1          ,  
           0 0 0 0  0 1  0  0  0  0  0  0 -1       ,
           0 0 0 0  0 1  0  0  0  0  0  0  0 -1    ,
           0 0 0 0  0 1  0  0  0  0  0  0  0  0 -1 /
 estimates;
 estimate 'slope diff' group*years 1 -1;
run;
quit;


/*----------------------------*/                    
/*--- Code for Output 2.10 ---*/    
/*----------------------------*/                    
ods select ModelInfo OptInfo FitStatistics CovParms ParameterEstimates Estimates CovBDetails CovB CovBModelBased;
proc glimmix data=example2_2_2 method=mmpl scoring=100
             empirical;
 class subject group visit;
 model tbbmd=group group*years /noint solution
                                covb(details);
 random visit /subject=subject type=ar(1) rside; 
 nloptions technique=newrap;
 estimate 'slope diff' group*years 1 -1;
 output out=pred /allstats;
 ods output CovBDetails=gof;
 ods output ParameterEstimates=pe;
 ods output CovParms=cov;
 ods output dimensions=n;
run;


/*----------------------------*/                    
/*--- Code for Output 2.11 ---*/    
/*----------------------------*/                    
%GLIMMIX_GOF(dimension=n, 
             parms=pe,
             covb_gof=gof,
             output=pred,
             response=tbbmd,
             pred_ind=PredMu, 
             pred_avg=PredMuPA);
proc print data=_fitting noobs;
run;



/*===================================================================*/
/*=== Example 3.2.2. Bone mineral density data = continued        ===*/
/*===================================================================*/

proc sort data=example2_2_2;
 by subject visit;
run;


/*----------------------------*/                    
/*--- Code for Output 3.2  ---*/    
/*----------------------------*/                    
ods select CovParms FitStatistics SolutionF Estimates; 
proc mixed data=example2_2_2 method=ml;
 class subject group visit;
 model tbbmd=group group*years /noint solution;
 random intercept years / type=un subject=subject;
 estimate 'slope diff' group*years 1 -1;
run;
quit;


/*----------------------------*/                    
/*--- Code for Output 3.3  ---*/    
/*----------------------------*/                    
ods select CovParms FitStatistics SolutionF Estimates; 
proc mixed data=example2_2_2 method=ml;
 class subject group visit;
 model tbbmd=group group*years /noint solution;
 random intercept years / type=un subject=subject;
 repeated visit /subject=subject type=ar(1); 
 estimate 'slope diff' group*years 1 -1;
run;
quit;



/*===================================================================*/
/*=== Example 6.6.1. Bone mineral density data - continued        ===*/
/*===================================================================*/

/*----------------------------*/                    
/*--- Code for Output 6.1  ---*/    
/*----------------------------*/
proc sort data=TBBMD out=example6_6_1;
 by group subject;
run; 
ods listing close;
ods output MissPattern = MissPattern;
proc mi data=example6_6_1 nimpute=0;
 by group;
 var tbbmd1-tbbmd5;
run;
ods listing;
proc print data=MissPattern noobs split='|';
 by group;
 id group;
 var group2 tbbmd1_miss tbbmd2_miss tbbmd3_miss tbbmd4_miss 
     tbbmd5_miss Freq Percent;
 label group='Group' group2='Pattern';
 title 'Missing data patterns by treatment group';
run;
proc print data=MissPattern noobs split='|';
 by group;
 id group;
 var group2 tbbmd1 tbbmd2 tbbmd3 tbbmd4 tbbmd5;
 label group='Group' group2='Pattern';
 format tbbmd1-tbbmd5 8.6;
 title 'Mean TBBMD by treatment and missing data patterns';
run;
title;


/*----------------------------*/                    
/*--- Code for Output 6.2  ---*/    
/*----------------------------*/
data example6_6_1_down;
 set example6_6_1;
 by group subject;
 array t tbbmd1-tbbmd5;
 array tsum tbbmd_sum1-tbbmd_sum5;
 lastvisit=1;
 if t[5]>. then lastvisit=5;
 else if t[4]>. and t[5]=. then lastvisit=4;
 else if t[3]>. and t[4]=. then lastvisit=3;
 else if t[2]>. and t[3]=. then lastvisit=2;
 tsum[1]=t[1]; tsum[2]=t[1];
 do i=3 to 5 by 1;
    tsum[i]=(tsum[i-2]+t[i-1]);
 end;
 tbbmd_last=t[1]; tbbmd_change=t[1];
 do visit=1 to 5 by 1;
    tbbmd=t[visit];
    tbbmd_avg=tsum[visit]/max(1,(visit-1));
    response=(t[visit]>.);
    years=0.5*(visit-1); 
    if visit>1 then do;
       tbbmd_last=t[visit-1];
       tbbmd_change=(t[visit-1]-t[1]);
    end;
    keep subject group data visit lastvisit years tbbmd 
         tbbmd_last tbbmd_avg tbbmd_change response;
    output;
 end;
run;
/*--- A macro to perform the Ridout test for MCAR ---*/
/*--- MODEL:     defines a model ID number        ---*/
/*--- VISIT1:    defines the first visit to be    ---*/
/*---            included in the model            ---*/
/*--- COVARIATE: defines a TBBMD-based covariate  ---*/
%macro Ridout(model=1, visit1=2, covariate=tbbmd_avg);
 ods listing close;
 ods output parameterestimates=peout;
 proc genmod data=example6_6_1_down;
  where &visit1 <= visit <= lastvisit+1;
  class group visit subject;
  model response=group visit &covariate / dist=bin;
 run;
 data peout;
  length covariate $12;
  set peout;
  Model=&model;
  Covariate="&covariate";
 run;
 data pe;
  set pe peout;
  if Parameter='Scale' then delete;
 run;
 ods listing;
%mend Ridout;
data pe;
%Ridout(model=3, visit1=3, covariate=tbbmd_change);
%Ridout(model=2, visit1=2, covariate=tbbmd_last);
%Ridout(model=1, visit1=2, covariate=tbbmd_avg);
proc sort data=pe;
 by Model;
run; 
proc report data=pe headskip split='*' nowindows ;
 column Model Parameter Level1 DF Estimate StdErr
        ChiSq ProbChiSq;
 define Model  / group  'Model';
 define Parameter / 'Parameter' width=12 display;
 define Level1 / 'Value' width=5 display;
 define DF / display;
 define Estimate / display;
 define StdErr / 'Std Error' width=9 display;
 define ChiSq / 'ChiSq' display;
 define ProbChiSq / 'p-value' width=7 display;
run;
quit;


/*----------------------------*/                    
/*--- Code for Output 6.3  ---*/    
/*----------------------------*/
** Create datasets with imputed missing data **;
proc mi data=example6_6_1 seed=9385672 nimpute=10 
        out=example6_6_1_MI;
 by group;
 mcmc chain=multiple displayinit initial=em(itprint);
 var tbbmd1-tbbmd5;
run;
proc sort data=example6_6_1_MI;
 by _imputation_ group subject;
run;
** Convert horizontal data to vertical format **;
data example6_6_1_MI_down;
 set example6_6_1_MI;
 by _imputation_ group subject;
 array d date1-date5;
 array t tbbmd1-tbbmd5; 
 do visit=1 to 5 by 1;
    date=d[visit];
    tbbmd=t[visit];
    years=0.5*(visit-1);
    format date date7.;
    keep _imputation_ group subject date 
         visit years tbbmd;
    output;
 end;
run;
** Perform a complete-case analysis and output    **;
** the difference in slopes (the target estimand) **;
ods listing close;
ods output Estimates=CCestimates;
proc mixed data=example6_6_1_down method=ml;
 where data='Complete';
 class subject group visit;
 model tbbmd=group group*years /noint solution;
 repeated visit / subject=subject type=unr;
 estimate 'slope diff' group*years 1 -1;
run;
quit;
** Perform an available-case analysis and output  **;
** the difference in slopes (the target estimand) **;
ods output Estimates=ACestimates;
proc mixed data=example6_6_1_down method=ml;
 where tbbmd>.;
 class subject group visit;
 model tbbmd=group group*years /noint solution;
 repeated visit / subject=subject type=unr;
 estimate 'slope diff' group*years 1 -1;
run;
quit;
** Perform MI analyses by imputed datasets and output **;
** the differences in slopes (the target estimand)    **;
ods output Estimates=MIestimates;
proc mixed data=example6_6_1_MI_down method=ml;
 by _imputation_;
 class subject group visit;
 model tbbmd=group group*years /noint solution;
 repeated visit / subject=subject type=unr;
 estimate 'slope diff' group*years 1 -1;
run;
quit;
ods listing;
** Summarize the MI-based estimands using MIANALYZE **;
ods output parameterestimates=MIestimates_final;
proc mianalyze data=MIestimates;
 modeleffects Estimate;
 stderr StdErr;
run; 
** Compare CC, AC and MI based ML estimates of    **;
** the difference in slopes (the target estimand) **; 
data estimates;
 set CCestimates(in=a) ACestimates(in=b) 
     MIestimates(in=c) MIestimates_final(in=d);
 Nimpute=_imputation_;
 if a then Method="CC-MLE             ";
 if b then Method="AC-MLE             ";
 if c then Method="MI-individual MLE's";
 if d then Method="MI-summary MLE     ";
run;
proc print data=estimates noobs;
 var Method Nimpute Estimate StdErr DF tValue Probt;
run;
/*===================================================================*/
/*====================== End of this example ========================*/
/*===================================================================*/

