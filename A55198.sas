 /*-------------------------------------------------------------------*
  * TABLE-DRIVEN STRATEGIES FOR RAPID SAS(r) APPLICATIONS DEVELOPMENT *
  *               by Tanya Kolosova &  Samuel Berestizhevsky          *
  *       Copyright(c) 1995 by SAS Institute Inc., Cary, NC, USA      *
  *-------------------------------------------------------------------*
  *                                                                   *
  * This material is  provided "as is" by SAS  Institute Inc.  There  *
  * are no warranties, express or  implied, as to merchantability or  *
  * fitness for a particular purpose regarding the materials or code  *
  * contained herein. The Institute is not  responsible for errors    *
  * in this  material as it now  exists or will exist, nor does the   *
  * Institute provide technical support for it.                       *
  *                                                                   *
  *-------------------------------------------------------------------*
  *                                                                   *
  * Questions or problem reports concerning this material may be      *
  * addressed to the authors, Tanya Kolosova & Samuel Berestizhevsky  *
  *                                                                   *
  * by electronic mail:                                               *
  *                                                                   *
  *        sasconsl@actcom.co.il                                      *
  *                                                                   *
  * by ordinary mail:                                                 *
  *                                                                   *
  *        P.O. Box 1169, Nazerath-Ellit 17100, Israel                *
  *                                                                   *
  *-------------------------------------------------------------------*/
 /*

   This document describes the SAS macro and SCL programs included in
   the book "Table-Driven Strategies for Rapid SAS Applications
   Development."
   Section references contained here indicate the sections in the book
   where the programs are illustrated.

  **** In some cases there are minor differences between the programs on
   this document and those in the book. These changes were made to
   correct errors in original. The changes should not affect the
   results produced by the programs.****

   Program Requirements
   --------------------

   The programs were developed under the SAS System, Version 6.10
   (operating systems OS/2 and Windows), and tested under the SAS
   System, Versions 6.07, 6.08 and 6.09 (operating systems MVS, VM/CMS,
   Unix, Sun/OS, AIX). The programs should run under all releases (6.07
   and later) of the SAS System on all operating systems.

   The programs all require the base SAS product. Some programs require
   SAS/CONNECT, SAS/AF, and SAS/FSP.

   General Usage Notes
   -------------------

   1. You may receive unanticipated results of the programs if you use
   SAS data sets with data that do not conform to the relational data model
   (e.g. duplicate rows in the primary key, the missing value for
   character values differs from the missing value for numeric values).
   To prevent such results we recommend that you apply the %DATMODEL macro to
   your SAS data sets (see the %DATMODEL macro in the extra programs
   section).

   2. If you want to create the same data environment as in the book,
   you can use the DATABASE program from the extra program section.
 */
*****************************************************************************************
/*The following example code appears on page 13.*/
**************************************************

 /*
  PROGRAM     LIBREF.
  DESCRIPTION Assigns SAS library references according to the Library table
              meta data.
  USAGE       %libref(libname);
  PARAMETERS  libname - is the name of the library storing the library data
                        set.
  REQUIRES    The Library data set corresponding to the Library table.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */

  %macro libref (libname) ;

 /*
  The following DATA step creates macro variables and fills them with data
 from the library data set:
  libs - contains the number of libraries, defined in the library data set
  lib  - is a series of macro variables containing names of the libraries
  loc  - is a series of macro variables containing physical locations of
 these libraries.
 */

    %let libs = 0 ;
    data _null_ ;
        set &libname..Library ;
        call symput("libs", _n_) ;
        call symput("lib" || left(_n_), trim(library)) ;
        call symput("loc" || left(_n_),trim(location)) ;
    run ;

 /*
  The following loop generates required LIBNAME statements.
 */

    %if &libs > 0 %then
       %do i = 1 %to &libs ;
          libname &&lib&i "&&loc&i" ;
       %end ;;

  %mend libref ;
*****************************************************************************************

/*The following example code appears on pages 40-43.*/
******************************************************

 /*
  PROGRAM     KERNEL.
  DESCRIPTION Creates four SAS data sets: library, object, location, and
              property, and fills in these data sets meta data.
  USAGE       %kernel (libref, mis) ;
  PARAMETERS  libref  - is the name of the library that stores created data
              sets.
              mis     - is the code for the missing value.
  REQUIRES    Prerequisites are not required.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */

  %macro kernel (libref, mis) ;

 /*
  The following four PROC's SQL create library, object, location, and
 property  data sets and fills in meta data.
 */

   proc sql ;
   create table &libref..Library
   (library char(8),
   location char(80)) ;
   insert into &libref..Library
   values ("kernel", "d:\kernel") ;

   proc sql ;
   create table &libref..Object
   (table   char(8),
   title    char(80),
   dataset  char(80),
   screen   char (2)) ;
   insert into &libref..Object
   values
   ("Library", "List of SAS libraries", "library", "L")
   values
   ("Object", "List of tables", "object", "L")
   values
   ("Location", "List of tables and correspondent libraries", "location", "L")
   values
   ("Property", "List of tables properties", "property", "L") ;

   proc sql ;
   create table &libref..Location
   (table   char(8),
   library  char(8)) ;
   insert into &libref..Location
   values ("Library", "kernel")
   values ("Object", "kernel")
   values ("Location", "kernel")
   values ("Property", "kernel") ;

   proc sql ;
   create table &libref..Property
   (table   char(8),
   column   char(8),
   title    char(80),
   type     char(1),
   length   num,
   format   char(20),
   attribut char(2),
   domtab   char(8),
   domcol   char(8),
   meantab  char(8),
   meancol  char(8),
   place    num,
   initval  char(80),
   formula  char(80),
   updtype  char(1),
   missing  char(1),
   message  num) ;
   insert into &libref..Property
   values
   ("Library", "LIBRARY", "SAS library name", "C", 8, "&mis", "P",
   "&mis", "&mis", "&mis", "&mis", 1, "&mis", "&mis", "R", ".", &mis)
   values
   ("Library", "LOCATION", "File name for SAS library", "C", 80, "&mis",
   "&mis", "&mis", "&mis", "&mis", "&mis", 2, "&mis", "&mis", "R", ".", &mis)
   values
   ("Object", "TABLE", "Table name", "C", 8, "&mis", "P", "&mis", "&mis",
   "&mis", "&mis", 1, "&mis", "&mis", "R", ".", &mis)
   values
   ("Object", "TITLE", "Title", "C", 80, "&mis", "&mis", "&mis", "&mis",
   "&mis", "&mis", 2, "&mis", "&mis", "R", ".", &mis)
   values
   ("Object", "DATASET", "SAS data set name", "C", 8, "&mis", "&mis", "&mis",
   "&mis", "&mis", "&mis", 3, "&mis", "&mis", "R", ".", &mis)
   values
   ("Object", "SCREEN", "Screen type", "C", 2, "&mis", "&mis", "&mis",
   "&mis", "&mis", "&mis", 4, "&mis", "&mis", "R", ".", &mis)
   values
   ("Location", "TABLE", "Table name", "C", 8, "&mis", "P", "Object",
   "TABLE", "Object", "TITLE", 1, "&mis", "&mis", "R", ".", &mis)
   values
   ("Location", "LIBRARY", "SAS library name", "C", 8, "&mis", "&mis",
   "Library", "LIBRARY", "Library", "LOCATION", 2, "&mis", "&mis", "R", ".", &mis)
   values
   ("Property", "TABLE", "Table name", "C", 8, "&mis", "PI",
   "Object", "TABLE", "Object", "TITLE", 1, "&mis", "&mis", "R", ".", &mis)
   values
   ("Property", "COLUMN", "Column name", "C", 8, "&mis", "P",
   "&mis", "&mis", "&mis", "&mis", 2, "&mis", "&mis", "R", ".", &mis)
   values
   ("Property", "TITLE", "Column title", "C", 80, "&mis", "&mis",
   "&mis", "&mis", "&mis", "&mis", 3, "&mis", "&mis", "R", ".", &mis)
   values
   ("Property", "TYPE", "Column type", "C", 1, "&mis", "&mis",
   "&mis", "&mis", "&mis", "&mis", 4, "&mis", "&mis", "R", ".", &mis)
   values
   ("Property", "LENGTH", "Column length", "N", 8, "&mis", "&mis",
   "&mis", "&mis", "&mis", "&mis", 5, "&mis", "&mis", "R", ".", &mis)
   values
   ("Property", "FORMAT", "Format", "C", 20, "&mis", "&mis",
   "&mis", "&mis", "&mis", "&mis", 6, "&mis", "&mis", "R", ".", &mis)
   values
   ("Property", "ATTRIBUT", "Column property", "C", 2, "&mis", "&mis",
   "&mis", "&mis", "&mis", "&mis", 7, "&mis", "&mis", "R", ".", &mis)
   values
   ("Property", "DOMTAB", "Domain table name", "C", 8, "&mis", "&mis",
   "Object", "TABLE", "&mis", "&mis", 8, "&mis", "&mis", "R", ".", &mis)
   values
   ("Property", "DOMCOL", "Domain column name", "C", 8, "&mis", "&mis",
   "&mis", "&mis", "&mis", "&mis", 9, "&mis", "&mis", "R", ".", &mis)
   values
   ("Property", "MEANTAB", "Meaning table name", "C", 8, "&mis", "&mis",
   "Object", "TABLE" "&mis", "&mis", 10, "&mis", "&mis", "R", ".", &mis)
   values
   ("Property", "MEANCOL", "Meaning table name", "C", 8, "&mis", "&mis",
   "&mis", "&mis", "&mis", "&mis", 11, "&mis", "&mis", "R", ".", &mis)
   values
   ("Property", "PLACE", "Place on the screen form", "N", 8, "&mis", "&mis",
   "&mis", "&mis", "&mis", "&mis", 12, "&mis", "&mis", "R", ".", &mis)
   values
   ("Property", "INITVAL", "Initial column value", "C", 80, "&mis", "&mis",
   "&mis", "&mis", "&mis", "&mis", 13, "&mis", "&mis", "R", ".", &mis)
   values
   ("Property", "FORMULA", "Formula for computed column", "C", 80, "&mis", "&mis",
   "&mis", "&mis", "&mis", "&mis", 14, "&mis", "&mis", "R", ".", &mis)
   values
   ("Property", "UPDTYPE", "Type of column update", "C", 1, "&mis", "&mis",
   "&mis", "&mis", "&mis", "&mis", 15, "&mis", "&mis", "R", ".", &mis)
   values
   ("Property", "MISSING", "Code of missing value", "C", 1, "&mis", "&mis",
   "&mis", "&mis", "&mis", "&mis", 16, "&mis", "&mis", "R", ".", &mis)
   values
   ("Property", "MESSAGE", "Message id", "N", 8, "&mis", "&mis",
   "&mis", "&mis", "&mis", "&mis", 17, "&mis", "&mis", "R", ".", &mis) ;

 /*
  The following PROC SQL creates a simple index on the TABLE column of the
 Property table.
 */

   proc sql ;
   create index table on &libref..Property (table) ;
   quit ;

  %mend kernel ;

******************************************************************************************

/*The following example code appears on pages 44-47.*/
******************************************************
 /*
  PROGRAM     LSCREEN.
  DESCRIPTION Creates a data entry screen form for specified table and stores
              this form in the external file.
  USAGE       %lscreen (libref, table, file, mis) ;
  PARAMETERS  libref - is the name of the library storing the data
              dictionary data sets, such as library, object, property, location, etc.
              table  - is the name of the table that is required to
                       create the data entry screen form.
              file   - is the name of the external file storing the
                       generated screen form.
              mis    - is the code identifying the missing value.
  REQUIRES    The object, property, and location data sets must exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */

  %macro lscreen (libref, table, file, mis) ;

 /*
  The following DATA step selects from the property data set observations
  relevant to the properties of the specified table.
 */
   data _proper_ ;
      set &libref..Property ;
      where upcase(left(table)) = upcase("&table")
            and place ^= &mis ;
   run ;
   proc sort data = _proper_ ;
   by place ;
   run ;

 /*
  The following DATA step creates macro variables and fill them with data
 from
  _proper_ data set:
  count - contains the number of columns that must be placed on the screen
 form
  _c    - is a series of macro variables containing titles of the columns.
  _t    - is a series of macro variables containing tables that contain  columns
          with meaningful information for each column of the specified table.
  _m    - is a series of macro variables containing columns that contain
          meaningful information for each column of the specified table.
  _s    - is a series of macro variables containing the service words, such  as:
          userformat, noformat, SASformat, for each column of the specified table.
  _f    - is a series of macro variables containing formats defined for each
          column of the specified table.
  _fl   - is a series of macro variables containing length of each column of the
          specified table.
 */

   data _null_ ;
      retain _count 1 ;
      set _proper_ ;
      call symput("count", _count) ;
      call symput("_c" || left(_count), left(title)) ;
      call symput("_t" || left(_count), "&mis") ;
      call symput("_m" || left(_count), "&mis") ;
      call symput("_s" || left(_count), "&mis") ;
      call symput("_f" || left(_count), "&mis") ;
      call symput("_fl" || left(_count), "&mis") ;
      if left(meantab) ^= "&mis" then
      do ;
         call symput("_t" || left(_count), left(meantab)) ;
      call symput("_m" || left(_count), left(meancol)) ;
      call symput("_s" || left(_count), "userformat") ;
      _count + 1 ;
      return;
      end ;
      if left(format) = "&mis" then
      do ;
         call symput("_s" || left(_count), "noformat") ;
      call symput("_fl" || left(_count), left(length)) ;
      _count + 1 ;
      return;
      end ;
      call symput("_s" || left(_count), "SASformat") ;
      ind = indexc(format, "123456789") ;
      if ind >= 1 then
         call symput("_fl" || left(_count),
                  substr(format, ind, index(format, ".") - ind)) ;
      else
         call symput("_f" || left(_count), left(format)) ;
    _count + 1 ;
   run ;
   %let defined = 0 ;
   %let exist = 0 ;

 /*
  In the following loop the DATA steps create, according to the values stored
  in the _s macro variable, the _b macro variable, that is, a series of macro
  variables containing for each column of the specified table an associated
  length of field where the column's value will be displayed or entered. This
  field is marked by a line of underscore symbols.
 */

   %do i = 1 %to &count ;
    %if &&_s&i = SASformat and &&_fl&i = &mis %then
    %do ;

 /*
  The following DATA steps and PROC DATASETS check existence of the data set
  corresponding to the FORMAT table and it contents.
 */

     data _null_ ;
        call symput("_b" || left(&i), "***Format not defined***") ;
     run ;
     %if &defined = 0 %then
     %do ;
         data _null_ ;
         set &libref..Object ;
         where upcase(left(table)) = "FORMAT" ;
         call symput("dataset", left(dataset)) ;
         call symput("defined", 1) ;
         run ;
     %end ;
     %if &defined = 1 and &exist = 0 %then
     %do ;
      data _null_ ;
         set &libref..Location ;
         where upcase(left(table)) = "FORMAT" ;
         call symput("libname", left(library)) ;
      run ;
      proc datasets library = &libname memtype = data nolist ;
      contents data = _all_ memtype = data out = work._out_
                      (keep = memname nobs) noprint ;
      run ;
      quit ;
      data _null_ ;
         set _out_ ;
         if upcase(left(memname)) = upcase("&dataset") then
         do ;
            if nobs > 0 then
               call symput("exist",1) ;
            stop;
         end ;
      run ;
     %end ;
     %if &exist = 1 %then
     %do ;
      data _null_ ;
         set &libname..&dataset ;
         if upcase(trim("&&_f&i")) = upcase(left(format)) then
         do ;
            if indexc(detail, "123456789") > 0  then
         do ;
            ind = index(detail, ".") ;
         if ind > 0 then
          call symput("_fl" || left(&i),
                        substr(detail, 1, ind - 1)) ;
         else
            call symput("_fl" || left(&i), left(detail)) ;
         end ;
         else
            call symput("_fl" || left(&i), length(detail)) ;
         call symput("_b" || left(&i), repeat("_",
                     symget("_fl" || left(&i)) - 1)) ;
         stop ;
         end;
      run ;
     %end ;
    %end ;
    %if &&_s&i = noformat or (&&_s&i = SASformat and
     &&_fl&i ^= &mis) %then
    %do ;
     data _null_ ;
        call symput("_b" || left(&i), repeat("_", &&_fl&i - 1)) ;
     run ;
    %end ;
    %if &&_s&i = userformat %then
    %do ;
     data _null_ ;
        set &libref..Property ;
        where upcase(left(table)) = upcase("&&_t&i") and
              upcase(left(column)) = upcase("&&_m&i") ;
        call symput("_b" || left(&i), repeat("_", length - 1)) ;
        stop ;
     run ;
    %end ;
   %end ;

 /*
  The following DATA step creates the screen form for the specified table and
  stores it in the external file.
 */

   data _null_ ;
      set &libref..Object ;
      length _line $ 200 ;
      file "&file" ;
      where upcase(left(table)) = upcase("&table") ;
      put title /;
      %do i = 1 %to &count ;
         _line = trim("%nrbquote(&&_c&i)") || " :" ;
      put _line ;
      put "&&_b&i" ;
      %end ;
   run ;
   proc datasets library = work memtype = data ;
   delete _out_ _proper_ ;
   run ;
   quit ;

  %mend lscreen ;
*****************************************************************************************
/*The following example code appears on pages 53-57.*/
******************************************************

 /*
  PROGRAM     FORMATS.
  DESCRIPTION Generates SAS catalog containing user-defined formats specifying
              in the data dictionary tables.
  USAGE       %formats(libref, mis) ;
  PARAMETERS  libref - is the name of the library storing the data dictionary
                       data sets, such as object, property, location, etc.
              mis    - is the code identifying the missing value.
  REQUIRES    The object, property, and location data sets must exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */

  %macro formats  (libref, mis) ;

 /*
  The following DATA step selects from the property data set the observations
  in which in the FORMAT column exist format specifications.
 */
        %let chekfm = 0 ;
        data _forms_ (keep = format domtab domcol meantab meancol) ;
           set &libref..property ;
           if left(format) = "&mis" then
              delete ;
           call symput("chekfm", 1) ;
        run ;

        %if &chekfm = 1 %then
        %do ;

 /*
  The following DATA steps and PROC DATASETS check existence of the data set
  corresponding to the FORMAT table and it contents.
 */

                %let chekfmt = 0 ;
                %let defined = 0 ;
                proc sort data = _forms_ nodupkey ;
                by format ;
                run ;
                data _null_ ;
                   set &libref..object ;
                   where upcase(left(table)) = "FORMAT" ;
                   call symput("dataset", left(dataset)) ;
                   call symput("defined", 1) ;
                run ;
                %if &defined = 1 %then
                %do ;
                        data _null_ ;
                       set &libref..location ;
                           where upcase(left(table)) = "FORMAT" ;
                           call symput("libname", left(library)) ;
                        run ;
                        proc datasets library = &libname memtype = data nolist ;
                        contents data = _all_ memtype = data out = work._out_
                                        (keep = memname nobs) noprint;
                        run ;
                        quit ;
                        data _null_ ;
                           set _out_ ;
                           if upcase(left(memname)) = upcase("&dataset") then
                           do ;
                              if nobs > 0 then
                                     call symput("chekfmt", 1) ;
                                  stop ;
                           end ;
                        run ;
                        %if &chekfmt = 1 %then
                        %do ;

 /*
  The following PROC SORT sorts the data set corresponding to the Format table.
 */

                                proc sort data = &libname..&dataset
                                          out = _format_ nodupkey ;
                                by format ;
                                run ;

 /*
  The following DATA step merges the data set corresponding to the Format table with the
  data set containing selected rows from the property data set (see the first DATA
  step).
 */

                                data _forms_ ;
                                   merge _forms_ _format_ ;
                                   by format ;
                                run ;
                        %end ;
                        %let pcount = 0 ;
                        %let vcount = 0 ;
                        %let count = 0 ;

 /*
  The following DATA step creates macro variables and fills them with data from
  the data set, produced in the previous DATA step:
  vcount - contains the number of value-based formats.
  pcount - contains the number of picture-based formats.
  _p     - is a series of macro variables containing names of picture-based formats.
  _f     - is a series of macro variables containing labels for each picture-based
           format.
  _v     - is a series of macro variables containing names of value-based formats.
  _d     - is a series of macro variables containing names of the tables that contain
           column domain.
  _c     - is a series of macro variables containing names of the domain columns that
           contain values for the formats.
  _m     - is a series of macro variables containing names of the column that contain
           labels for the formats.
 */

                        data _null_ ;
                           retain pcount vcount 1 ;
                           call symput("_f"||left(pcount), "&mis") ;
                           call symput("_d"||left(vcount), "&mis") ;
                           call symput("_c"||left(vcount), "&mis") ;
                           call symput("_m"||left(vcount), "&mis") ;
                           set _forms_ ;
                           if (trim(left(domtab)) = "" or left(domtab) = "&mis")
                               and
                              trim(left(detail)) ^= "" then
                           do ;
                              call symput("_f"||left(pcount),trim(left(detail))) ;
                              call symput("_p"||left(pcount),left(substr(format, 1 ,
                                          index(format, ".") - 1))) ;
                              call symput("pcount", pcount) ;
                              pcount + 1 ;
                           end ;
                           if trim(left(domtab)) ^= "&mis" then
                           do ;
                              call symput("_d"||left(vcount), left(domtab))= ;
                              call symput("_c"||left(vcount), left(domcol))= ;
                              call symput("_m"||left(vcount), left(meancol))= ;
                              call symput("_v"||left(vcount),= left(substr(format, 1,
                                          index(format,".") - 1))) ;
                              call symput("vcount", vcount) ;
                              vcount + 1 ;
                           end ;
                        run ;

 /*
  In the following loop PROC FORMAT generates the picture-based formats.
 */

                        %if &pcount > 0 %then
                        %do ;
                            %do i = 1 %to &pcount ;
                                %if %index(&&_f&i,&mis) = 0 %then
                                %do ;
                                    proc format ;
                                    picture &&_p&i other = "&&_f&i" ;
                                    run ;
                                %end ;
                            %end ;
                        %end ;
                        %if &vcount > 0 %then
                        %do ;

 /*
  In the following loop PROC FORMAT generates the value-based formatsthat use
  values from the domain and labels from the meaning data sets. The %TRANSFER
  macro brings these data sets from their locations to the work SAS library
  (see the %TRANSFER macro later in this section).
 */

                                %do i = 1 %to &vcount ;
                                    data _null_ ;
                                       set &libref..location ;
                                       where upcase(left(table)) =
                                             upcase("&&_d&i") ;
                                       call symput("_l"||left(&i),
                                                   left(library)) ;
                                    run ;
                                    %transfer (&libref, &&_l&i, work, &&_d&i) ;
                                    data _domain_ (keep = &&_c&i  &&_m&i) ;
                                       set &&_d&i ;
                                       %if %index(&&_v&i, $) = 1 %then
                                       %do ;
                                           &&_c&i = upcase(&&_c&i) ;
                                       %end ;
                                    run ;
                                    proc sort data = _domain_ nodupkey ;
                                    by &&_c&i ;
                                    run ;
                                    data _null_ ;
                                       retain _count 1 ;
                                       set _domain_ ;
                                       call symput("_n" || left(_count),
                                                   left(&&_c&i)) ;
                                       call symput("_k" || left(_count),
                                                   trim(left(&&_m&i))) ;
                                       call symput("count", _count) ;
                                       _count + 1 ;
                                    run ;
                                    proc format ;
                                    value &&_v&i
                                    %do j = 1 %to &count ;
                                        &&_n&j = "%nrbquote(&&_k&j)"
                                    %end ;
                                    ;
                                    run ;
                                %end ;
                        %end ;

 /*
  The following PROC COPY copies a formats catalog from the work library to
  its permanent location.
 */

                        proc copy in = work out = &libref ;
                        select formats / memtype = catalog;
                        run;
                %end ;
                proc datasets library = work memtype = data ;
                delete _domain_ _out_ _format_ _forms_ ;
                run ;
                quit ;
        %end ;
  %mend formats ;
****************************************************************************************

/*The following example code appears on pages 57-61.*/
*****************************************************

 /*
  PROGRAM     TRANSFER.
  DESCRIPTION Implements communication operations defined in the Comoper and
              Commacc tables.
  USAGE       %transfer(libref, source, target, table, mis) ;
  PARAMETERS  libref - is the name of the library storing the data dictionary
                       data sets.
              source - is the name of the library storing the data set
                       corresponding to the table, specified by the table
                       parameter.
              target - is the name of the library that will store the data set
                       corresponding to the table, specified by the table
                       parameter.
              table  - is the name of the table that must be transferred from
                       the library specified by the source parameter to the
                       library, specified by the target parameter.
              mis    - is the code identifying the missing value.
  REQUIRES    The object, location, library, commacc, and comoper data sets must
              exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky
 */

  %macro transfer (libref, source, target, table, mis) ;

 /*
  The following DATA step creates a dataset macro variable containing the name
  of the data set corresponding to the specified table.
 */
   %let srcflag = 0 ;
   %let trgflag = 0 ;
   data _null_ ;
      set &libref..Object ;
      where upcase(left(table)) = upcase("&table") ;
      call symput("dataset", trim(dataset)) ;
   run ;

 /*
  The following DATA step creates srcloc and trgloc macro variables containing
  the names of source and target physical locations of the libraries specified
  by the source and target parameters.
 */

   data _null_ ;
      set &libref..Library ;
      if upcase(left(library)) = upcase("&source") then
         call symput("srcloc", left(location)) ;
      if upcase(left(library)) = upcase("&target") then
         call symput("trgloc", left(location)) ;
   run ;

   data _null_ ;
      length tmp $ 200 ;
      set sashelp.vslib ;
      retain srcflag trgflag 0 ;
      if  srcflag = 0 then
      do ;
         i = 1 ;
         tmp = scan(upcase(path), i, " ") ;
         do while (tmp ^= upcase("&srcloc") and trim(tmp) ^= "") ;
            i + 1  ;
            tmp = scan(upcase(path), i, " ") ;
         end ;
         if trim(tmp) ^= "" then
         do ;
            srcflag = 1 ;
            call symput("srcflag", 1) ;
         end ;
      end ;
      if trgflag  = 0 then
      do ;
         i = 1 ;
         tmp = scan(upcase(path), i, " ") ;
         do while (tmp ^= upcase("&trgloc") and trim(tmp) ^= "") ;
            i + 1  ;
            tmp = scan(upcase(path), i, " ") ;
         end ;
         if trim(tmp) ^= "" then
         do ;
            trgflag = 1 ;
            call symput("trgflag", 1) ;
         end ;
      end ;
      if srcflag = 1 and  trgflag =  1 then
         stop ;
   run ;

   %let exist = 0 ;
   %let comexist = 0 ;
   %let defined = 0 ;
   %let accesex = 0 ;

 /*
  The following DATA step creates operds and accds macro variables containing
  the names of the data sets corresponding to the Comoper and Commacc tables.
 */

   data _null_ ;
      set &libref..Object ;
      if upcase(left(table)) = "COMOPER" then
      do ;
         call symput("operds", left(dataset)) ;
         operex = 1 ;
      end ;
      if upcase(left(table)) = "COMMACC" then
      do ;
         call symput("accds", left(dataset)) ;
         accesex = 1 ;
      end ;
      if operex = 1 and accesex = 1 then
         call symput("defined", 1) ;
   run ;

 /*
  The following DATA step and PROC DATASETS check existence of the data sets
  corresponding to the Comoper and Commacc table.
 */

   %if &defined = 1 %then
   %do ;
       data _null_ ;
          set &libref..Location;
          if upcase(left(table)) = "COMOPER" then
             call symput("liboper", left(library)) ;
          if upcase(left(table)) = "COMMACC" then
             call symput("libacc", left(library)) ;
       run ;
       proc datasets library = &liboper memtype = data nolist ;
       contents data = _all_ memtype = data out = work.out
                       (keep = memname nobs) noprint ;
       run ;
       quit ;
       data _null_ ;
          set out ;
          if upcase(left(memname)) = upcase("&operds") then
          do ;
             if nobs > 0 then
                call symput("exist", 1) ;
             stop;
          end ;
       run ;
       %if &exist = 1 %then
       %do ;
           proc datasets library = &libacc memtype = data nolist ;
           contents data = _all_ memtype = data out = work.out
                           (keep = memname nobs) noprint ;
           run ;
           quit ;
           %let exist = 0 ;
           data _null_ ;
              set out ;
              if upcase(left(memname)) = upcase("&accds") then
              do ;
                 if nobs > 0 then
                    call symput("exist", 1) ;
                 stop;
              end ;
           run ;
       %end ;
   %end ;

 /*
  The following DATA step creates communid and type macro variables containing
  the communication access identification number and type of communication
  between the source and target libraries.
 */

   %if &defined = 1 and &exist = 1 %then
   %do ;
       data _null_ ;
          set &liboper..&operds ;
          where upcase(left(library)) = upcase("&source") and
          upcase(left(tarlib)) = upcase("&target") ;
          call symput("communid", communid) ;
          call symput("type", commtype) ;
          call symput("comexist", 1) ;
       run ;

 /*
  The following DATA step creates macro variables containing information about
  communication parameters corresponding to the communication access
  identification number specified in the communid macro variable (see the
  previous DATA step).
 */

       %if &comexist = 1 %then
       %do ;
           data _null_ ;
              set &libacc..&accds ;
              where communid = &communid ;
              call symput("access", communic) ;
              call symput("localos", left(localos)) ;
              call symput("remoteos", left(remoteos)) ;
              call symput("protocol", left(protocol)) ;
              call symput("comport", left(comport)) ;
           run ;

 /*
  The following SAS commands (libname, options, rsubmit, signon, etc), PROC
  UPLOAD, PROC DOWNLOAD, and PROC COPY execute required communication operations
  according to values of the previously created macro variables.
 */

           %if %upcase(&type) = U or %upcase(&type) = D %then
           %do ;
               options comamid = &comamid remote = &comport ;
               signon "&protocol" ;
               rsubmit ;
               %if %upcase(&source) ^= WORK and &srcflag = 0 %then
                   libname &source "&srcloc" ;;
               %if %upcase(&target) ^= WORK and &trgflag = 0 %then
                   libname &target "&trgloc" ;;
               %if %upcase(&type) = U %then
                   %let procname = upload ;
               %else
                   %let procname = download ;
               proc &procname data = &source..&dataset
               out = &target..&dataset ;
               run ;
               endrsubmit ;
               signoff "&protocol" ;
           %end ;
           %if %upcase(&type) = T %then
           %do ;
               %let slash = ;
               %let extend = ;
               %if %upcase(&localos) = OS2 or
                   %upcase(&localos) = WINDOWS or
                   %upcase(&localos) = WINDOWS_NT %then
               %do ;
                   %let slash = \ ;
                   %let extend = .sd2 ;
               %end ;
               options comamid = &comamid remote = &comport ;
               signon "&protocol" ;
               rsubmit ;
               proc upload data = "&srcloc.&slash&dataset&extend"
               out = "&trgloc.&slash&dataset&extend" ;
               run ;
               endrsubmit ;
               signoff "&protocol" ;
           %end ;
       %end ;
   %end ;

   %if &comexist = 0 %then
   %do ;
       %if %upcase(&target) ^= WORK and &trgflag = 0 %then
           libname &target "&trgloc" ;;
       %if %upcase(&source) ^= WORK and &srcflag = 0 %then
           libname &source "&srcloc" ;;
       proc copy in = &source out = &target memtype = data ;
       select &dataset ;
       run ;
   %end ;

  %mend transfer ;
*****************************************************************************************

/*The following example code appears on pages 61-64.*/
******************************************************

 /*
  PROGRAM     DATASET.
  DESCRIPTION Creates a SAS data set for the specified table.
  USAGE       %dataset(libref, table, mis) ;
  PARAMETERS  libref - is the name of the library storing the data dictionary
                       data sets.
              table  - is the name of the table that is required to
                       create the SAS data set.
              mis    - is the code identifying the missing value.
  REQUIRES    The object, property, location, library, commacc, and comoper
              data sets must exist. In addition the formats catalog must exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky
 */

  %macro dataset(libref, table, mis) ;

 /*
  The following DATA step creates a dataset macro variable containing the name
  of the data set corresponding to the specified table.
 */

        data _null_ ;
           set &libref..Object ;
           where upcase(left(table)) = upcase("&table") ;
           call symput("dataset", trim(dataset)) ;
        run ;
        %let count = 0 ;
        %let _icount = 0 ;

 /*
  The following DATA step creates macro variables and fills them with data
  from the property data set:
  count - contains number of columns of the specified table.
  _v0   - is a series of macro variables containing names of the columns
          of the specified table with their types and length.
  _v1   - is a series of macro variables containing names of the columns of
          the specified table with their formats.
  _v3   - is a series of macro variables containing names of the columns of
          the specified table for which indexes are defined.
  _v4   - is a series of macro variables containing names of the columns of
          the specified table with their titles.
 */

        data _null_ ;
           retain _count 1 _icount 0 ;
           call symput("_v0" || left(_count), "&mis") ;
           call symput("_v1" || left(_count), "&mis") ;
           set &libref..Property ;
           where upcase(left(table)) = upcase("&table") ;
           call symput("_v4" || left(_count), trim(left(column)) || ' 
                                %nrbquote(' || trim(left(title)) || ')') ;
           if index(upcase(attribut), "I") > 0 then
           do ;
              _icount + 1 ;
                  call symput("_v3" || left(_icount), left(column)) ;
                  call symput("_icount", left(_icount)) ;
           end ;
           if upcase(type) = "C" then
              call symput("_v0" || left(_count), trim(left(column)) ||
                              " $" || left(length)) ;
           if upcase(type) = "N" then
              call symput("_v0" || left(_count), trim(left(column)) ||
                              " " || left(length)) ;
           if left(format) ^= "&mis" then
              call symput("_v1" || left(_count), trim(left(column)) ||
                              " " || trim(left(format))) ;
           else
           do ;
                  if upcase(type) = "C" then
                         call symput("_v1" || left(_count), trim(left(column)) ||
                                        " $CHAR" || trim(left(length)) || ".") ;
                  if upcase(type) = "N" then
                         call symput("_v1" || left(_count), trim(left(column)) ||
                                        " " || trim(left(length)) || ".") ;
           end ;
           call symput("count", _count) ;
           _count + 1 ;
        run ;

 /*
  The following DATA step generates SAS data set for the specified table
  according to the values of the macro variables created in the previous
  DATA steps.
 */

        data &dataset ;
           length
           %do _j = 1 %to &count ;
               &&_v0&_j
           %end ;
           ;
           format
           %do _j = 1 %to &count ;
               &&_v1&_j
           %end ;
           ;
           label
           %do _j = 1 %to &count ;
               &&_v4&_j
           %end ;
           ;
           stop ;
        run ;

 /*
  The following PROC SQL creates indexes, if any, for the SAS data set generated
  in the previous DATA step according to the values of the macro variables stored
  in the _v3 macro variable.
 */

        %if &_icount > 0 %then
        %do ;
            proc sql ;
            %if &_icount = 1 %then
            %do ;
                create index &&_v3&_icount on
                &dataset (&&_v3&_icount) ;
            %end ;
            %else
            %do ;
                create index __index on &dataset
                ( &&_v31
                %do i = 2 %to &_icount ;
                   , &&_v3&_icount
                %end ;
                ) ;
            %end ;
        %end ;

 /*
  The following DATA step creates a macro variable containing the name of the library
  where the generated SAS data set corresponding to the specified table must be
  stored.
 */

        data _null_ ;
           set &libref..Location ;
           where upcase(left(table)) = upcase("&table") ;
           call symput("libname", left(library)) ;
        run ;

 /*
  The %TRANSFER macro delivers the generated SAS data set to its permanent location.
 */

        %transfer (&libref, work, &libname, &table) ;
        proc datasets library = work memtype = data ;
        delete &dataset ;
        run ;
        quit ;

  %mend dataset ;
******************************************************************************************

/*The following example code appears on pages 95-101.*/
********************************************************

 /*
  PROGRAM     INPUTID.
  DESCRIPTION Creates an input operation table for the specified process.
  USAGE       %inputid (libname, inputid) ;
  PARAMETERS  libname - is the name of the library storing the data dictionary
                        data sets, such as pinput, pinit, pbinary, pselect, etc.
              inputid - is the input identification name.
  REQUIRES    The pinput, pinit, pbinary, pselect, pproject data sets must exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */

  %macro inputid (libname, inputid) ;

 /*
  The following DATA step creates _input data set containing common rows of the
  pinput and pinit data sets according to the primary key.
 */

   data _input ;
      merge &libname..PInput (in = _left) &libname..PInit (in = _right) ;
      by inputid ;
      if _left and _right ;
   run ;

 /*
  The following DATA step creates macro variables and fills them with data from
  the _input data set (see DATA step above):
  count - contains the number of relational operators forming the input operation
          table for the specified input identification name.
  _opr  - is a series of macro variables containing names of the relational
          operators for the specified input indentification name.
 */

   data _input (drop = _n) ;
      retain _n 1 ;
      set _input ;
      where upcase(left(inputid)) = upcase("&inputid") ;
      call symput("_opr" || left(_n), upcase(operator)) ;
      call symput("count", _n) ;
      _n + 1 ;
   run ;
   %let binary = 0 ;
   %let sunary = 0 ;
   %let punary = 0 ;
   %do i = 1 %to &count ;
      %if &&_opr&i = J or
          &&_opr&i = U or
          &&_opr&i = D or
          &&_opr&i = V or
          &&_opr&i = R %then
          %let binary = 1 ;
      %if &&_opr&i = S %then
          %let sunary = 1 ;
      %if &&_opr&i = P %then
          %let punary = 1 ;
   %end ;
   %if &binary = 1 %then
   %do ;

 /*
  If the macro variable from the _opr series of macro variables contains the name of
  binary relational operators, such as natural join, union, etc, then the
  following DATA step creates the _input data set containing common rows of the
  _input (see DATA step above) and pbinary data sets according to the primary
  key.
 */

       data _input ;
          merge _input (in = _left) &libname..PBinary ;
          by inputid operord ;
          if _left ;
       run ;
   %end ;
   %if &sunary = 1 %then
   %do ;

 /*
  If the macro variable from the _opr series of macro variables contains the name of
  the selection relational operator, then the following DATA step creates the _input
  data set containing common rows of the _input (see DATA step above) and
  pselect data sets according to the primary key.
 */

       data _input ;
          merge _input (in = _left) &libname..PSelect ;
          by inputid operord ;
          if _left ;
       run ;
   %end ;
   %if &punary = 1 %then
   %do ;

 /*
  If the macro variable from _opr series of macro variables contains the name of
  project relational operator, the the following DATA step creates the _input data
  set containing common rows of the _input (see DATA step above) and pproject
  data sets according to the primary key.
 */

       data _input ;
          merge _input (in = _left) &libname..PProject ;
          by inputid operord ;
          if _left ;
       run ;
   %end ;

 /*
  The following DATA step creates macro variables and fills them with data from
  the _input data set (see DATA step above):
  _ll - is a series of macro variables containing names of the libraries storing
        the data sets corresponding to the initial tables.
  _tl - is a series of macro variables containing names of the initial tables
        data sets.
  _lr - is a series of macro variables containing names of the libraries storing
        the data sets corresponding to the right-hand tables for the binary
        relational operators.
  _tr - is a series of macro variables containing names of the right-hand data
        sets corresponding to the right-hand tables for the binary relational
        operators.
 */

   %do i = 1 %to &count ;
      data _null_ ;
         set _input ;
         where operator = "&&_opr&i" and operord = &i;
         %if &i = 1 %then
         %do ;
             call symput("_ll" || left(&i), left(trim(initlib))) ;
             call symput("_tl" || left(&i), left(trim(initab))) ;
         %end ;
         %if &i > 1 %then
         %do ;
             call symput("_ll" || left(&i), "work") ;
             call symput("_tl" || left(&i), "_intern_") ;
         %end ;
         call symput("_lr" || left(&i), left(trim(rellib))) ;
         call symput("_tr" || left(&i), left(trim(reltable))) ;
      run ;

      %if &&_opr&i = &mis %then
      %do ;
          data  _intern ;
             set &&_ll&i...&&_tl&i ;
          run ;
      %end ;
      %else
      %do ;

 /*
  The following DATA step creates macro variables and fills them with data from
  the plink data set:
  _colcnt - contains the number of related columns of the data sets participating in
            the binary relational operators if one of these data sets is an
            intermediate table.
  _l      - is a series of macro variables containing names of the related columns
            from the left-hand data set.
  _r      - is a series of macro variables containing names of the related columns
            from the right-hand data set.
 */

          %let _colcnt = 0 ;
          data _null_ ;
             retain _colcnt 1 ;
             set &libname..PLink ;
             where upcase(left(inputid)) = upcase("&inputid") and
                   operord = &i ;
             call symput("_l" || left(_colcnt), left(column)) ;
             call symput("_r" || left(_colcnt), left(relcol)) ;
             call symput("_colcnt", _colcnt) ;
             _colcnt + 1 ;
          run ;
          %if &_colcnt = 0 %then
          %do ;

 /*
  The following DATA step creates macro variables and fills them with data from
  the link data set:
  _colcnt - contains the number of related columns of the data sets participating in
            the binary relational operators.
  _l      - is a series of macro variables containing names of the related columns
            from the left-hand data set.
  _r      - is a series of macro variables containing names of the related coluns
            from the right-hand data set.
 */
              data _null_ ;
                 retain _colcnt 0 ;
                 set &libname..Link ;
                 if upcase(left(table)) = upcase("&&_tl&i") and
                    upcase(left(reltable)) = upcase("&&_tr&i") then
                 do ;
                    _colcnt + 1 ;
                    call symput("_l" || left(_colcnt), left(column)) ;
                    call symput("_r" || left(_colcnt), left(relcol)) ;
                    call symput("_colcnt", _colcnt) ;
                 end ;
                 if upcase(left(table)) = upcase("&&_tr&i") and
                    upcase(left(reltable)) = upcase("&&_tl&i") then
                 do ;
                    _colcnt + 1 ;
                    call symput("_r" || left(_colcnt), left(column)) ;
                    call symput("_l" || left(_colcnt), left(relcol)) ;
                    call symput("_colcnt", _colcnt) ;
                 end ;
              run ;
          %end ;

 /*
  According to the following conditions the macro programs that implement
  relational operators will be invoked.
 */

          %if &&_opr&i = R %then
             %product (&i, &_colcnt) ;
          %if &&_opr&i = U %then
             %union (&i) ;
          %if &&_opr&i = D %then
             %differ (&i, &_colcnt) ;
          %if &&_opr&i = V %then
             %division (&i, &_colcnt) ;
          %if &&_opr&i = J %then
             %join (&i, &_colcnt);
          %if &&_opr&i = S %then
             %select (&i) ;
          %if &&_opr&i = P %then
             %project (&i) ;
      %end ;
   %end ;
   proc datasets library = work memtype = data ;
   delete _input ;
   run ;
   quit ;

  %mend inputid ;

 /*
  PROGRAM     JOIN.
  DESCRIPTION Creates an intermediate table produced by the natural join
              relational operator.
  USAGE       %join (i, _colcnt) ;
  PARAMETERS  i       - is the current number of left-hand and right-hand data
                        sets and their libraries whose names are specified in
                        the %INPUTID macro by the _tl, _tr, _ll and _lr series
                        of macro variables.
              _colcnt - is the number of the columns linking the joined data
                        sets. The column names are specified in the %INPUTID
                        macro by the _l and _r series of macro variables.
  REQUIRES    The left-hand and right-hand data sets must exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */

  %macro join (i, _colcnt) ;

  proc sql ;
     create table _intern_ as
     select *
     from &&_ll&i...&&_tl&i inner join &&_lr&i...&&_tr&i
     on
     %do loop = 1 %to &_colcnt ;
        &&_tl&i...&&_l&loop =
        &&_tr&i...&&_r&loop and
     %end ;
     1 = 1 ;
  quit ;

  %mend join ;


 /*
  PROGRAM     UNION.
  DESCRIPTION Creates an intermediate table produced by the union relational
              operator.
  USAGE       %union (i) ;
  PARAMETERS  i - is the current number of left-hand and right-hand data sets
                  and their libraries whose names are specified in the %INPUTID
                  macro by the _tl, _tr, _ll, and _lr series of macro variables.
  REQUIRES    The left-hand and right-hand data sets must exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */

  %macro union (i) ;

  proc sql ;
     create table _intern_ as
     select * from &&_ll&i...&&_tl&i
     union all
     select * from &&_lr&i...&&_tr&i ;
  quit ;

  %mend union ;

 /*
  PROGRAM     DIFFER.
  DESCRIPTION Creates an intermediate table produced by the difference
              relational operator.
  USAGE       %differ (i, _colcnt) ;
  PARAMETERS  i       - is the current number of left-hand and right-hand data
                        sets and their libraries whose names are specified in
                        the %INPUTID macro by the _tl, _tr, _ll, and _lr series
                        of macro variables.
              _colcnt - is the number of the columns linking the differenced
                        data sets. The column names are specified in the
                        %INPUTID macro by the _l and _r series of macro variables.
  REQUIRES    The left-hand and right-hand data sets must exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */

  %macro differ (i, _colcnt) ;

  proc sql ;
     create table _temp_ as
     select
     %do loop = 1 %to &_colcnt ;
        %if &loop > 1 %then
        , ;
        &&_l&loop
     %end ;
     from &&_ll&i...&&_tl&i
     except
     select
     %do loop = 1 %to &_colcnt ;
        %if &loop > 1 %then
        , ;
        &&_r&loop as &&_l&loop
     %end ;
     from &&_lr&i...&&_tr&i ;

     create table _intern_ as
     select * from _temp_ inner join &&_ll&i...&&_tl&i
     on
     %do loop = 1 %to &_colcnt ;
        _temp_.&&_l&loop =
        &&_tl&i...&&_l&loop and
     %end ;
     1 = 1 ;
  quit ;

%mend differ ;
*****************************************************************************************

/*The following example code appears on pages 101-105.*/
********************************************************

 /*
  PROGRAM     OUTPUTID.
  DESCRIPTION Creates an output operation table for the specified process.
  USAGE       %outputid (libname, outputid, mis) ;
  PARAMETERS  libname  - is the name of the library storing the data
                         dictionary data sets, such as poutput, pupdate, etc.
              outputid - is the output identification name.
              mis      - is the code identifying the missing value.
  REQUIRES    The poutput, pupdate, poutrule, and property data sets must exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */

  %macro outputid (libname, outputid, mis) ;

 /*
  The following DATA step creates macro variables and fills them with data from
  the poutput data set:
  outype  - is the output table type.
  outable - is the output operation table name.
  outlib  - is the library name storing the output operation table.
  ruleid  - is the updating rule identification name.
 */

   data _null_ ;
      set &libname..POutput ;
      where upcase(left(outputid)) = upcase("&outputid") ;
      call symput("outype", outype) ;
      call symput("outable", trim(left(outable))) ;
      call symput("outlib", trim(left(outlib))) ;
      call symput("ruleid", left(ruleid)) ;
   run ;

   %if &ruleid ^= &mis %then
   %do ;

 /*
  The following DATA step creates macro variables and fills them with data from
  the pupdate data set:
  _count - contains number of columns corresponding to the value of ruleid macro
           variable.
  _c     - is a series of macro variables containing names of the columns
           corresponding to the value of ruleid macro variable.
  _e     - is a series of macro variables containing expressions corresponding
           to the value of ruleid macro variable.
 */
       data _null_ ;
          retain _count 1 ;
          set &libname..PUpdate ;
          where upcase(left(ruleid)) = upcase("&ruleid") ;
          call symput("_c" || left(_count), left(column)) ;
          call symput("_e" || left(_count), left(expressn)) ;
          call symput("_count", _count) ;
          _count + 1 ;
       run ;
   %end ;
   %if %upcase(&outype) = N %then
   %do ;
      %if &ruleid ^= &mis %then
      %do ;

 /*
  The following DATA step creates a new data set corresponding to the output operation
  table.
 */

          data &outlib..&outable (keep =
             %do i = 1 %to &_count ;
                 &&_c&i
             %end ;);
             set _intern_ ;
             %do i = 1 %to &_count ;
                 &&_c&i = &&_e&i ;
             %end ;
          run ;
      %end ;
      %else
      %do ;
         data &outlib..&outable ;
            set _intern ;
         run ;
      %end ;
   %end ;
   %if %upcase(&outype) = E %then
   %do ;

 /*
  The following DATA step creates macro variables and fills them with data from
  the poutrule data set:
  expressn - is the macro variable containing the expression for rows selection from
             the existing output operation table.
  updtype  - is the macro variable containing the type of update for existing
             output operation  table.
 */

    data _null_ ;
       set &libname..POutrule ;
       where upcase(left(outputid)) = upcase("&outputid") ;
       call symput("expressn", trim(left(expressn))) ;
       call symput("updtype", updtype) ;
    run ;

 /*
  The following DATA step creates macro variables and fills them with data from
  the property data set:
  _pcnt - contains number of columns forming the primary key of the output
          operation table.
  _p    - is a series of macro variables containing names of the columns forming
          the primary key of the output operation table.
 */

    data _null_ ;
       retain _count 1 ;
       set &libname..Property ;
       where upcase(left(table)) = upcase("&outable") ;
       if index(upcase(attribut), "P") > 0 then
       do ;
          call symput("_p" || left(_count),  left(column)) ;
          call symput("_pcnt" , _count) ;
          _count + 1 ;
       end ;
    run ;

 /*
   The following DATA step creates the _out_ and _outable data sets containing
   rows selected from the output operation table according to the value of the
   expressn macro variable (see DATA step above).
 */

      data _out_ _outable;
         set &outlib..&outable ;
         if &expressn then
            output _out_ ;
         else
            output  _outable ;
      run ;
      %if &ruleid ^= &mis %then
      %do ;

 /*
  The following DATA step updates the intermediate operation data set.
 */
          data _intern_ (keep =
             %do i = 1 %to &_count ;
                 &&_c&i
             %end ;);
             set _intern_ ;
             %do i = 1 %to &_count ;
                 &&_c&i = &&_e&i ;
             %end ;
          run ;
      %end ;
      %if %upcase(&updtype) = A %then
      %do ;

 /*
  The following DATA step creates the _out_ intermediate operation data set from
  the updated intermediate data set and _out_ data set (see DATA step above).
  Such a data set contains data updating according to the Add type of update.
 */

         data _out_ (keep =
            %do i = 1 %to &_count ;
                &&_c&i
            %end ;) ; ;
            merge _intern_ (in = _left) _out_ (in = _right) ;
            by
            %do i = 1 %to &_pcnt ;
                &&_p&i
            %end ; ;
            if _right or (_left and not _right) ;
         run ;
      %end ;
      %if %upcase(&updtype) = R %then
      %do ;

 /*
  The following DATA step creates the _out_ intermediate operation data set from
  the updated intermediate data set and _out_ data set (see DATA step above).
  Such a data set contains data updating according to the Replace type of update.
 */

          data _out_ (keep =
             %if &ruleid ^= &mis %then
             %do ;
                 (keep =
                 %do i = 1 %to &_count ;
                     &&_c&i
                 %end ;) ;
             %end ; ;
             set _intern_ ;
             by
             %do i = 1 %to &_pcnt ;
                 &&_p&i
             %end ; ;
             if last.&&_p&_pcnt then output ;
          run ;
      %end ;
      %if %upcase(&updtype) = S %then
      %do ;

 /*
  The following DATA step creates the _out_ intermediate operation data set from
  the updated intermediate data set and _out_ data set (see DATA step above).
  Such a data set contains data updatedg according to the Subtract type of update.
 */

          data _out_ (keep =
             %do i = 1 %to &_count ;
                 &&_c&i
             %end ;) ; ;
             merge _intern_ (in = _left) _out_ (in = _right) ;
             by
             %do i = 1 %to &_pcnt ;
                 &&_p&i
             %end ; ;
             if _right and not _left ;
          run ;
      %end ;

 /*
  The following PROC APPEND appends the _out_ intermediate operation data set to
  the existing output operation data set corresponding to the output operation
  table.
 */

      proc append base = _outable data = _out_ force;
      run ;
      proc sort data = _outable out = &outlib..&outable ;
      by
      %do i = 1 %to &_pcnt ;
          &&_p&i
      %end ; ;
      run  ;

      proc datasets library = work memtype = data ;
      delete _out_  ;
      run ;
      quit ;
   %end ;

 %mend outputid ;
****************************************************************************************

/*The following example code is on pages 105-108.*/
***************************************************

 /*
  PROGRAM     PREVIOUS.
  DESCRIPTION Stores the previous value of the column.
  USAGE       %previous(varname) ;
  PARAMETERS  varname - is the name of the table column.
  AUTHORS     T.Kolosova and S.Berestizhevsky
 */

  %global libref mis ;
  %let libref = kernel ;
  %let mis = . ;

  %macro previous(varname) ;
     %let prevar = _&varname ;
     %if %length(&prevar) > 8 %then
         %let prevar = %substr(&prevar, 1, 8) ;
     &prevar
  %mend previous ;

 /*
  PROGRAM     SAME.
  DESCRIPTION Checks previous and current values of the column.
  USAGE       %same(varname) ;
  PARAMETERS  varname - is the name of the table column.
 */

  %macro same(varname) ;
     %let prevar = _&varname ;
     %if %length(&prevar) > 8 %then
         %let prevar = %substr(&prevar, 1, 8) ;
     trim(&varname) = trim(&prevar)
  %mend same ;

 /*
  PROGRAM     PREVAR.
  DESCRIPTION Generates length and retain SAS language statements
              needed for implementaion of the %PREVIOUS macro.
  USAGE       %prevar(varname) ;
  PARAMETERS  varname - is the name of the table column.
  AUTHORS     T.Kolosova and S.Berestizhevsky
 */

  %macro prevar(varname) ;
     %let prevar = _&varname ;
     %if %length(&prevar) > 8 %then
         %let prevar = %substr(&prevar,1,8) ;
     length &prevar $ 200 ;
     retain &prevar "&mis" ;
  %mend prevar ;

 /*
  PROGRAM     POSTVAR.
  DESCRIPTION Generates the assigment SAS language statement
              needed for implementaion of the %PREVIOUS macro.
  USAGE       %postvar(varname) ;
  PARAMETERS  varname - is the name of the table column.
  AUTHORS     T.Kolosova and S.Berestizhevsky
 */

  %macro postvar(varname) ;
    %let prevar = _&varname ;
    %if %length(&prevar) > 8 %then
        %let prevar = %substr(&prevar,1,8) ;
    &prevar = &varname;
  %mend postvar ;


 /*
  PROGRAM     SORT.
  DESCRIPTION Sorts observations in the _intern_ intermediate data set.
  USAGE       %sort(varname) ;
  PARAMETERS  varname - is the list of the data set columns defining the order of
                        sorting.
 */

  %macro sort(varname) ;
     proc sort data = _intern_ ;
     by &varname ;
     run ;
  %mend sort ;

 /*
  PROGRAM     MOVE.
  DESCRIPTION Moves data sets between SAS libraries according to the meta data
              of the _intern_ intermediate operation table.
  USAGE       %move() ;
 */

  %macro move ;

 /*
  The following DATA step creates macro variables containing information about
  source target libraries and their communication parameters storing in the
  _intern_ data set.
 */             screen form.

   data _null_ ;
      set _intern_ ;
      call symput("table", trim(left(table))) ;
      call symput("library", trim(left(library))) ;
      call symput("tarlib", trim(left(tarlib))) ;
      call symput("localos", trim(left(localos))) ;
      call symput("remoteos", trim(left(remoteos))) ;
      call symput("commtype", commtype) ;
      call symput("protocol", trim(left(protocol))) ;
      call symput("comport", trim(left(comport))) ;
   run ;

 /*
  The following DATA step creates the dataset macro variable containing the name of
  the data set corresponding to the table name stored in the table macro variable.
 */

   data _null_ ;
      set &libref..Object ;
      where upcase(left(table)) = upcase("&table") ;
      call symput("dataset", trim(dataset)) ;
   run ;

 /*
  The following SAS commands (options, rsubmit, signon, etc), PROC UPLOAD, PROC
  DOWNLOAD, and PROC COPY execute required communication operations according to
  values of the previously created macro variables.
 */

   %if %upcase(&commtype) = U or %upcase(&commtype) = D %then
   %do ;
       options comamid = &comamid remote = &comport ;
       signon "&protocol" ;
       rsubmit ;
       %if %upcase(&commtype) = U %then
           %let procname = upload ;
       %else
           %let procname = download ;
       proc &procname data = &library..&dataset
       out = &tarlib..&dataset ;
       run ;
       endrsubmit ;
       signoff "&protocol" ;
   %end ;
   %if %upcase(&commtype) = T %then %do ;

 /*
  The following DATA step creates srcloc and trgloc macro variables containing
  the names of source and target physical locations of the libraries stored in
  the library and tarlib macro variables.
 */

       data _null_ ;
          set &libref..Library ;
          if upcase(left(library)) = upcase("&library") then
             call symput("srcloc", left(location)) ;
          if upcase(left(library)) = upcase("&tarlib") then
             call symput("trgloc", left(location)) ;
       run ;
       %let slash = ;
       %let extend = ;
       %if %upcase(&localos) = OS2 or
           %upcase(&localos) = WINDOWS or
           %upcase(&localos) = WINDOWS_NT %then
       %do ;
           %let slash = \ ;
           %let extend = .sd2 ;
       %end ;
       options comamid = &comamid remote = &comport ;
       signon "&protocol" ;
       rsubmit ;
       proc upload data = "&srcloc.&slash&dataset&extend"
       out = "&trgloc.&slash&dataset&extend" ;
       run ;
       endrsubmit ;
       signoff "&protocol" ;
   %end ;
   %if &commtype = &mis %then
   %do ;
       proc copy in = &library out = &tarlib memtype = data ;
       select &dataset ;
       run ;
   %end ;
   proc datasets library = &library memtype = data ;
   delete &dataset ;
   run ;
   quit ;

 %mend move ;
*****************************************************************************************

/*The following code appears on pages 111-114.*/
************************************************

 /*
  PROGRAM     MANID.
  DESCRIPTION Implements specified manipulations with input operation table
              storing in the _intern_ intermediate data set.
  USAGE       %manid (libname, manid, mis) ;
  PARAMETERS  libname - is the name of the library storing the data dictionary
                        data sets, such as pman and pmacro.
              manid   - is the manipulation identification name.
              mis     - is the code identifying the missing value.
  REQUIRES    The pman and pmacro data sets must exist.  Also "user-written"
              macros and "environmental" macros must be written and placed in
              the autocall SAS library.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */

  %macro manid (libname, manid, mis) ;

 /*
  The following DATA step reads meta data from the pman and pmacro data sets
  and creates three temporary data sets: _before_, _in_ and _after_. These data
  sets contain specification of manipulations that must be executed with the input
  operation table. Because such manipulations are presented by the PROC step  and
  DATA step, the _before_ data set contains specifications of the PROC step
  executing before the DATA step specified in the _in_ data set, and the _after_ data
  set contains specification of the PROC step executing after specified DATA step.
 */
   %let _before = 0 ;
   %let _in = 0 ;
   %let _after = 0 ;

   data _before_ (keep = manord expressn)
      _in_ (keep = manord expressn)
      _after_ (keep = manord expressn) ;
      set &libname..Pman nobs = nman ;
      length pmacro $ 9 flag property $ 1 _str _str1 $ 80 ;
      retain _before _in _after 0 flag "B" ;
      where upcase(left(manid)) = upcase("&manid") ;
      _str1 = expressn ;
      _str2 = expressn ;
      mo = manord ;
      property = "&mis" ;
      ind = index(_str1, "%") ;
      do while(ind > 0) ;
         pmacro = upcase(substr(_str1, ind, index(substr(_str1, ind+1), "("))) ;
         do i = 1 to nmacro ;
            set &libname..PMacro nobs = nmacro point = i ;
            if pmacro = upcase(left(macro)) then
            do ;
               _str = substr(_str1, ind, index(substr(_str1, ind), ")")) ;
               if left(substr(_str, index(_str, "(") + 1)) = ")" then
               do ;
                  len = length(_str) ;
                  ind1 = index(_str2, trim(_str)) ;
                  _str = substr(_str, 1, index(_str, "(") - 1) ;
                  if ind1 + len >= length(_str2)  then
                  do ;
                     if ind1 > 1 then
                        _str2 = substr(_str2, 1, ind1-1) || trim(_str) ;
                     else
                        _str2 = trim(_str) ;
                  end ;
                  else
                  do ;
                     if ind1 > 1 then
                       _str2 = substr(_str2,1, ind1-1) || trim(_str) ||
                               substr(_str2, ind1+len) ;
                     else
                       _str2 = trim(_str) || substr(_str2, ind1+len) ;
                  end ;
               end ;
               if upcase(property) = "I" then
               do ;
                  flag = "A" ;
                  if trim(premacro) ^= "&mis" then
                  do ;
                     expressn = upcase(trim(tranwrd(_str, trim(macro),
                                trim(premacro)))) || " ;" ;
                     manord = 0 ;
                     output _in_ ;
                  end ;
                  if trim(pstmacro) ^= "&mis" then
                  do ;
                     expressn = upcase(trim(tranwrd(_str, trim(macro),
                                trim(pstmacro)))) || " ;" ;
                     manord = nman + 1 ;
                     output _in_ ;
                  end ;
               end ;
               else
               do ;
                  expressn = trim(_str) || " ;" ;
                  if flag = "B" then
                  do ;
                     _before = 1 ;
                     output _before_ ;
                  end ;
                  else
                  do ;
                     _after = 1 ;
                     output _after_ ;
                  end ;
               end ;
               i = nmacro ;
            end ;
         end ;
         _str1 = substr(_str1, ind+1) ;
         ind = index(_str1, "%") ;
      end ;
      if upcase(property) ^= "O" then
      do ;
         expressn = upcase(_str2) ;
         manord = mo ;
         output _in_ ;
         _in = 1 ;
      end ;
      call symput("_before", left(_before)) ;
      call symput("_in", left(_in)) ;
      call symput("_after", left(_after)) ;
   run ;

 /*
  The following PROC SORT sorts the _in_ data set and elimitates duplicate rows.
 */

   %if &_in > 0 %then
   %do ;
       proc sort data = _in_ nodupkey ;
       by manord expressn ;
       run ;
   %end ;

 /*
  The following DATA step creates macro variables and fills them with data from
  the _before_, _in_, and _after_ data sets:
  _e    - is a series of macro variables containing manipulation specifications.
  count - contains number of manipulations specified for the input operation
          table.
 */

   data _null_ ;
      count = 0 ;
      %if &_before %then
      %do ;
          do i = 1 to nbefore ;
             set _before_ nobs = nbefore  point = i;
             count + 1 ;
             call symput("_e" || left(count), expressn) ;
          end ;
      %end ;
      %if &_in > 0 %then
      %do ;
          count + 1 ;
          call symput("_e" || left(count), "data _intern_ ;") ;
          count + 1 ;
          call symput("_e" || left(count), "set _intern_ ;") ;
          do i = 1 to nin ;
             set _in_ nobs = nin point = i;
             count + 1 ;
             call symput("_e" || left(count), expressn) ;
          end ;
          count + 1 ;
          call symput("_e" || left(count), "run ;") ;
      %end ;
      %if &_after > 0 %then
      %do ;
          do i = 1 to nafter ;
             set _after_ nobs = nafter point = i ;
             count + 1 ;
             call symput("_e" || left(count), expressn) ;
          end ;
      %end ;
      call symput("count", left(count)) ;
      stop ;
   run ;

 /*
  The following loop generates a PROC step and a DATA step executing defined
  manipulations with the input operation table.
 */

   %do i = 1 %to &count ;
       %str(&&_e&i)
   %end ;
   proc datasets library = work memtype = data ;
   delete _before_ _in_ _after_ ;
   run ;
   quit ;

  %mend manid ;
*****************************************************************************************

/*The following example code appears on pages 115-117.*/
********************************************************


 /*
  PROGRAM      PROCESS.
  DESCRIPTION  Implements object-dependent processes through the trigger-message
               mechanism.
  USAGE        %process (libname, procid, table, library, event, eventype, mis) ;
  PARAMETERS   libname - is the name of the library storing the data dictionary
                         data sets, such as process, pattach, pinput, etc.
               procid  - is the process identification name.
               table   - is the name of the attached table.
               library - is the name of the library storing the data set
                         corresponding to the attached table.
               event   - is the name of event according which the specified
                         process must be executed.
               eventype- is the type of event determined when the specified
                         process must be executed.
               mis     - is the code identifying the missing value.
  REQUIRES     The pprocess, pattach, poper and poutput data sets must exist.
  AUTHORS      T.Kolosova and S.Berestizhevsky.
 */

  %macro process (libname, procid, table, library, event, eventype, mis) ;
        %global error ;
        %if &procid ^= &mis %then
        %do ;

 /*
  The following DATA step creates macro variables and fills them with data from
  the pprocess data set:
  proctype - contains the type of specified process.
  title    - contains the title defined for the specified process.
 */
            data _null_ ;
               set &libname..PProcess ;
                   where upcase(left(procid)) = upcase("&procid") ;
               call symput("proctype", left(proctype)) ;
               call symput("title", left(title)) ;
            run ;
        %end ;
        %else
        %do ;

 /*
  The following DATA step creates a procid macro variable containing the process
  identification name according to the specified attached table, its library,
  event, and event type.
 */

            data _null_ ;
               set &libname..PAttach ;
               where upcase(left(table))   = upcase("&table") and
                     upcase(left(library)) = upcase("&library") and
                     upcase(event)         = upcase("&event") and
                     upcase(eventype)      = upcase("&eventype") ;
               call symput("procid", left(procid)) ;
            run ;

            %if &procid ^= &mis %then
            %do ;

 /*
  The following DATA step creates macro variables and fills them with data from
  the pprocess data set:
  proctype - contains the type of specified process.
  title - contains the title defined for the specified process.
 */

               data _null_ ;
                  set &libname..PProcess ;
                  where upcase(left(procid)) = upcase("&procid") ;
                  call symput("proctype", left(proctype)) ;
                  call symput("title", left(title)) ;
               run ;
            %end ;
        %end ;

        %if &procid ^= &mis %then
        %do ;

 /*
  The following DATA step creates macro variables and fills them with data
 from the poper data set:
  _inp  - is a series of macro variables containing input identification names for the specified
          process.
  _man  - is a series of macro variables containing manipulation identification names for the
          specified process.
  _out  - is a series of macro variables containing output identification names for the specified
          process.
  order - contains the number of operations for the specified process.
 */

            data _null_ ;
               set &libname..POper ;
               where upcase(left(procid)) = upcase("&procid") ;
               call symput("_inp" || left(order), inputid) ;
               call symput("_man" || left(order), manid) ;
               call symput("_out" || left(order), outputid) ;
               call symput("order", order) ;
            run ;

 /*
  The following loop invokes the %INPUTID, %MANID, and %OUTPUTID macros
  accomplishing specified operations. To analyze messages generated by such
  macros, the following loop invokes %MSG macro.
 */
            %do _i = 1 %to &order ;
                %inputid (&libname, &&_inp&_i) ;
                %msg (&libname, &procid, &_i, inputid) ;
                %if &error = E %then
                %do ;
                    %let _i = %eval(&order + 1) ;
                    %goto _end_ ;
                %end ;
                %if &&_man&_i ^= &mis %then
                %do ;
                    %manid (&libname, &&_man&_i, &mis) ;
                    %msg (&libname, &procid, &_i, manid) ;
                    %if &error = E %then
                    %do ;
                        %let _i = %eval(&order + 1) ;
                        %goto _end_ ;
                    %end ;
                %end ;
                %if &&_out&_i ^= &mis %then
                %do ;
                    %outputid (&libname, &&_out&_i, &mis) ;
                    %msg (&libname, &procid, &_i, outputid) ;
                    %if &error = E %then
                    %do ;
                        %let _i = %eval(&order + 1) ;
                        %goto _end_ ;
                    %end ;
                %end ;
                %let fire = 0 ;

 /*
  The following DATA set checks to be sure the output operation table of the current
  operation is not an existing application table.
 */

                data _null_ ;
                   set &libname..POutput ;
                   where upcase(left(outputid)) = upcase("&&_out&_i") and
                         upcase(outype) = "E" ;
                   call symput("library", left(library)) ;
                   call symput("table", left(outable)) ;
                   call symput("fire", 1) ;
                run ;
                %if &fire = 1 %then
                %do ;

 /*
  The following %PROCESS macro "fires" the process attached to the application
  table if the output operation table of current process is an existing
  application table.
 */

                     %process (&libname, &mis, &table, &library, U, A, &mis) ;
                %end ;
            %_end_ :
            %end ;
        %end ;
  %mend process ;
****************************************************************************************

/*The following example code appears on pages 142-143.*/
********************************************************


 /*
  PROGRAM     ERRCLEAR.
  DESCRIPTION Deletes from the error and errorval data sets rows containing
              information about the specified table.
  USAGE       %errclear (libname, vertype, table, vernum) ;
  PARAMETERS  libname - is the name of the library storing the data dictionary
                        data sets.
              vertype - is the name of the verification type containing one of
                        the following: TA, RE, DO, RO, CO, CR.
              table   - is the name of the verified table.
              vernum  - is the number of verification process derived from the
                        table of the Rule set specifying the required verification
                        type.
  REQUIRES    The error and errorval data sets must exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */

  %macro errclear(libname, vertype, table, vernum) ;

 /*
  The global macro variable lasterr accumulates the number of errors detected in the
  verification processes.
 */

        %global lasterr ;
        %let lasterr = 0 ;
        %let last = 0 ;

 /*
  The following DATA step deletes rows from the error data set containing
  information concerning the verified table.
 */

        data &libname..Error ;
           set &libname..Error nobs = _last ;
           if datetime <= datetime() and upcase(vertype) =
 upcase("&vertype")
              and upcase(left(table)) = upcase("&table")
              and vernum = &vernum then
           do ;
              call symput("lasterr", left(vprocid));
              delete ;
           end ;
           call symput("last", left(_last)) ;
        run ;

 /*
  The following DATA step deletes rows from the errorval data set containing
  information about errors in the verified table, if any.
 */

        %if &lasterr > 0 %then
        %do ;
            data &libname..ErrorVal ;
               set &libname..ErrorVal ;
               if vprocid = &lasterr then
                  delete ;
            run ;
        %end ;
        %if &lasterr = 0 %then
            %let lasterr = %eval(&last + 1) ;
        ;

  %mend errclear ;
****************************************************************************************

/*The following example code appears on pages 144-145.*/
********************************************************

 /*
  PROGRAM     ERRWRITE.
  DESCRIPTION Writes information to the error and errorval data sets about
              errors detected in the specified table.
  USAGE       %errwrite(libname, table, vernum, vertype, lasterr, pcount) ;
  PARAMETERS  libname - is the name of the library storing the data dictionary
              data sets.
              table   - is the name of the verified table.
              vernum  - is the number of verification process derived from the
                        table of the Rule set specifying required verification
                        type.
              vertype - is the name of the verification type containing one
                        of the following: TA, RE, DO, RO, CO, CR.
              lasterr - is the global macro variable containing the number of
                        the curernt verification process (is updated by the
                        %ERRCLEAR macro).
              pcount  - is the number of columns forming the primary key of the
                        verified table.
  REQUIRES    The error and errorval data sets must exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */

  %macro errwrite (libname, table,  vernum, vertype, lasterr, pcount) ;

 /*
  The following DATA step writes to the error data set information concerning
  the date of the verification, specified table, verification type, verification
  number, and number of the current verification process.
 */

        data Error (keep = datetime vertype table vernum vprocid) ;
           length datetime vprocid vernum 8 vertype $ 2 table $ 8  ;
           datetime = datetime() ;
           table = "&table" ;
           vertype = "&vertype" ;
           vernum = &vernum ;
           vprocid = &lasterr ;
           output ;
        run ;

 /*
  The following DATA step writes to the errorval data set information concerning
  detected errors in the specified table. Such information is stored in the
  errorval data set according to the primary key of the specified table.
 */

        data ErrorVal (rename = (_x1 = vprocid
                                 _x2 = errornum
                                 _x3 = column
                                 _x4 = value)
                       keep = _x1 _x2 _x3 _x4) ;
           length _x1 $8 _x2 8 _x3 $8 _x4 $80 ;
           set _temp_ ;
           _x1 = &lasterr ;
           _x2 = _n_ ;
           %do v = 1 %to &pcount ;
              _x4 = left(&&_c&v) ;
              _x3 = left("&&_c&v") ;
              output ;
           %end ;
           call symput("vforeign","error") ;
        run ;
        proc append base = &libname..Error data = Error force ;
        run ;
        proc append  base = &libname..ErrorVal data = ErrorVal force ;
        run ;
        proc datasets library = work memtype = data ;
        delete Error ErrorVal ;
        run ;
        quit ;

  %mend errwrite ;
*****************************************************************************************

/*The following example code appears on pages 145-146.*/
********************************************************

 FSEINIT :
 /*
 An initialization phase before any observations from the SAS data set are
 displayed.
 */
 return ;

 INIT :
 /*
 An initialization phase before each observation form the SAS data set is
 displayed.
 */
 return ;

 MAIN :
/*
 A main processing phase. This section is repeated each time the user
 modifies a column on the screen and presses the ENTER key or a functional
 key.
*/

 link _PRIMARY ;
 link _FOREIGN ;
 link _DOMAIN ;
 link _ROWCOL ;
 link _CROSS;
/*
 A LINK statement tells the program to jump immediately to the label indicated
 in the LINK statement and to continue executing statements from that point
 until a RETURN statement is executed. The RETURN statement causes program
 execution to return to the statement immediately following the LINK statement
 and to continue from there.
*/
 return ;

 TERM :
/*
 A termination phase before moving to another observation.
*/
 return ;

 FSETERM :
/*
 A termination phase.
*/
 return ;

 _PRIMARY :
/*
 Intended to insert the generated statements for Table Integrity rule.
*/
 return ;

 _FOREIGN :
/*
 Intended to insert the generated statements for Referential Integrity
 rule.
*/
 return ;

 _DOMAIN :
/*
 Intended to insert the generated statements for Domain Integrity rule.
*/
 return ;

 _ROWCOL :
/*
 Intended to insert the generated statements for Row and Column Integrity
 rules.
*/
 return ;

 _CROSS :
/*
 Intended to insert the generated statements for Cross Integrity rule.
*/
 return ;
******************************************************************************************

/*The following example code appears on pages 147-150.*/
********************************************************

 /*
  PROGRAM     VPRIMARY.
  DESCRIPTION Verifies the specified table according to the Table Integrity rule.
  USAGE       %vprimary (libname, table, event, sclfile, libedit, mis) ;
  PARAMETERS  libname - is the name of the library storing the data dictionary
                        data sets, such as object, property, vprimary, etc.
              table   - is the name of the table that must be verified.
              event   - is the event defining invocation of the verification
                        process.
              sclfile - is the name of the external file containing SCL template.
              libedit - is the name of the library storing the updated table
                        that must be verified.
              mis     - is the code identifying the missing value.
  REQUIRES    The object, property, vprimary, and message data sets must exist.
              Also must exist external file containing the SCL template.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */

  %macro vprimary (libname, table, event, sclfile, libedit, mis);
        %let vercount = noverify ;

 /*
  The following DATA step creates vernum and message macro variables and fills
  them with verification number and message identification number from the vprimary
  data set according to the specified table and the specified event.
 */

        data _null_ ;
           set &libname..VPrimary ;
           where upcase(left(table)) = upcase("&table") and
                 upcase(left(event)) = upcase("&event") ;
           call symput("vernum", left(vernum)) ;
           call symput("message", left(message)) ;
           call symput("vercount", "verify") ;
           call symput("vprimary", "noerrors") ;
        run ;
        %if &vercount = verify %then
        %do ;

 /*
  The following DATA step creates macro variables and fills them with data from
  the property data set:
  pcount - contains number of columns forming the primary key of the specified
           table.
  _c     - is a series of macro variables containing names of the columns of the
           specified table.
  _t     - is a series of macro variables containing types of the columns of the
           specified table.
 */

                data _null_ ;
                   retain _count 1 ;
                   set &libname..Property ;
                   where upcase(left(table)) = upcase("&table") and
                         index(upcase(attribut), "P") > 0 ;
                   call symput("_c" || left(_count), left(column)) ;
                   call symput( "_t" || left(_count), type) ;
                   call symput("pcount", _count) ;
                   _count + 1 ;
                run ;

 /*
  According to the following condition, the program generates SCL code and stores
  it in the external file. Such a code implements the Table Integrity verification
  process while updating the specified table in the data entry environment.
 */

                %if %upcase(&event) = U %then
                %do ;

 /*
  The following DATA step creates text macro variable containing error message text
  from the message data set.
 */

                    data _null_ ;
                       set &libname..Message ;
                       if message = &message then
                          call symput("text","'" || trim(left(text)) || "'") ;
                    run ;

 /*
  The following DATA step creates _temp_ data set containing the SCL code performing
  the Table Integrity verification process, based on the SCL template and generated
  according to the values of the macro variables _c and _t (see DATA step above).
 */

                    data _temp_ ;
                       length line $ 100 ;
                       infile "&sclfile" lrecl = 100 pad;
                       input line $100. ;
                       output ;
                       if upcase(trim(left(line))) =   "_PRIMARY :" then
                       do ;
                          %do j = 1 %to &pcount ;
                             if upcase("&&_t&j") = "C" then
                                line = "if left(&&_c&j) = '" || "&mis" ||
                                       "' then do ;" ;
                             if upcase("&&_t&j") = "N" then
                                line = "if &&_c&j = " || " &mis then do ;" ;
                             output  ;
                             line = " _msg_ = &text ;" ;
                             output ;
                             line = "erroron &&_c&j ; end ;
                                    else erroroff &&_c&j ;" ;
                             output  ;
                          %end ;
                          input line $100. ;
                          do while(upcase(trim(left(line))) ^= "RETURN ;") ;
                             input line $100. ;
                          end ;
                          output ;
                        end ;
                    run ;

 /*
  The following DATA step writes generated SCL code to the external file.
 */

                    data _null_ ;
                       set _temp_ ;
                       file "&sclfile" ;
                       put line        ;
                    run ;
                %end ;

 /*
  According to the following condition, the program implements the Table
  Integrity verification process before saving the specified table after it
  is updated in the data entry environment.
 */
                %if %upcase(&event) = S %then
                %do ;

 /*
  The following DATA step creates a macro variable containing the name of the
  data set corresponding to the specified table.
 */

                    data _null_ ;
                       set &libname..Object ;
                       where upcase(trim(left(table))) = upcase("&table") ;
                       call symput("dsname", trim(left(dataset))) ;
                    run ;
                    %errclear (&libname, TA, &table, &vernum) ;
                    proc sort data = &libedit..&dsname ;
                    by
                    %do k = 1 %to &pcount ;
                        &&_c&k
                    %end ; ;
                    run ;

 /*
  The following DATA steps create a _temp_ data set containing the errors detected
  by the Table Integrity verification process and check the contents of the _temp_
  data set.
 */

                    data _temp_ ;
                       set &libedit..&dsname ;
                       by
                       %do k = 1 %to &pcount ;
                           &&_c&k
                       %end ;;
                       %let first = first.&&_c%eval(&k - 1) ;
                       %let last = last.&&_c%eval(&k - 1) ;
                       if not (&first = 1 and &last = 1) then
                          output ;
                    run ;

 /*
  The following DATA step checks the contents of the _temp_ data set.
 */

                    %let empty = 0 ;
                    data _null_ ;
                       set _temp_ ;
                       call symput("empty", _n_ ) ;
                    run ;
 /*
  According to the following condition, the program invokes the %ERRWRITE macro
  writing detected errors to the error and errorval data sets.
 */

                    %if &empty > 0 %then
                    %do ;
                        %errwrite (&libname, &table, &vernum, TA,
                                   &lasterr, &pcount) ;
                    %end ;
                %end ;
                proc datasets library = work memtype = data ;
                delete _temp_ ;
                run ;
                quit ;
        %end ;

  %mend vprimary ;
*****************************************************************************************

/*The following example code appears on pages 151-154.*/
********************************************************

 /*
  PROGRAM     VFOREIGN.
  DESCRIPTION Verifies the specified table according to the Referential Integrity
              rule.
  USAGE       %vforeign (libname, table, event, libedit, mis) ;
  PARAMETERS  libname - is the name of the library storing the data dictionary
                        data sets, such as object, property, link, vforeign, etc.
              table   - is the name of the table that must be verified.
              event   - is the event defining invocation of the verification
                        process.
              libedit - is the name of the library storing the updated table that
                        must be verified.
              mis     - is the code identifying the missing value.
  REQUIRES    The object, property, vforeign, and message data sets must exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky
 */

  %macro vforeign (libname, table, event, libedit, mis);
   %let vercount = 0 ;

 /*
  The following DATA step creates macro variables and fills them with data from
  the vforeign data set according to the specified table and the specified event:
  vercount - contains the total number of verification processes defined for the
             specified table.
  _r       - is a series of macro variables containing names of the tables linked
             to the specified table.
  _n       - is a series of macro variables containing numbers of the
             verification processes defined for the specified table.
 */

   data _null_ ;
      retain _count 1 ;
      set &libname..VForeign ;
      where upcase(left(table)) = upcase("&table") and
            upcase(left(event)) = upcase("&event") ;
      call symput( "_r" || left(_count), left(reltable)) ;
      call symput( "_n" || left(_count), vernum) ;
      call symput("vercount", _count) ;
      call symput("vforeign", "noerrors") ;
      _count + 1 ;
   run ;
   %if &vercount > 0 %then
   %do ;

 /*
  The following DATA step creates macro variables and fills them with data from
  the property data set:
  pcount - contains number of columns forming the primary key of the specified
           table.
  _c     - is a series of macro variables containing names of the columns of
           the specified table.
 */

    data _null_ ;
       retain _count 1 ;
       set &libname..Property ;
       where upcase(left(table)) = upcase("&table") and
             index(upcase(attribut), "P") > 0 ;
       call symput("_c" || left(_count), left(column)) ;
       call symput("pcount", _count) ;
       _count + 1 ;
    run ;

 /*
  The following DATA step creates macro variables and fills them with data from
  the object data set:
  dsname  - contains data set name corresponding to the specified table.
  _d      - is a series of macro variables containing names of the data sets
            corresponding to the tables linked to the specified table.
 */

    data _null_ ;
      set &libname..Object ;
       if upcase(left(table)) = upcase("&table") then
          call symput("dsname", trim(left(dataset))) ;
       %do i = 1 %to &vercount ;
           if upcase(left(table)) = upcase("&&_r&i") then
              call symput("_d" || left(&i), trim(left(dataset))) ;
       %end ;
    run ;

 /*
  The following DATA step creates macro variables and fills them with data from the
  location data set:
  _l - is a series of macro variables containing the names of the libraries where
       the data sets corresponding to the tables related to the specified table are
       placed.
 */

    data _null_ ;
       set &libname..Location ;
       %do i = 1 %to &vercount ;
           if upcase(left(table)) = upcase("&&_r&i") then
           call symput("_l" || left(&i), trim(left(library))) ;
       %end ;
    run ;
    %do i = 1 %to &vercount ;
     %errclear (&libname, RI, &table, &&_n&i) ;
     %if %upcase(&event) = S %then
     %do ;

 /*
  The following DATA step creates macro variables and fills them with data from
  the link data set:
  linkcnt - contains the number of links between the specified table and related
            tables.
  _f      - is a series of macro variables containing names of the columns of
            the specified table.
  _q      - is a series of macro variables containing names of the columns of
            related tables.
 */

      data _null_ ;
         retain _count 1 ;
         set &libname..Link ;
         where (upcase(left(table)) = upcase("&table") and
                upcase(left(reltable)) = upcase("&&_r&i"))
            or (upcase(left(table)) = upcase("&&_r&i") and
                upcase(left(reltable)) = upcase("&table")) ;
         call symput("_f" || left(_count), trim(left(column))) ;
         call symput("_q" || left(_count), trim(left(relcol))) ;
         call symput("linkcnt", _count) ;
         _count + 1 ;
      run ;

 /*
  The following PROC SORT, %TRANSFER macro, and DATA steps implement verification
  of the specified table according to the Referential Integrity rule.
 */

      proc sort data = &libedit..&dsname out = _temp1_ nodupkey ;
      by
      %do k = 1 %to &linkcnt ;
       &&_f&k
      %end ; ;
      run ;
      %transfer(&libname, &&_l&i, &libedit, &&_r&i) ;
      proc sort data = &libedit...&&_d&i out = _temp2_ nodupkey ;
      by
      %do k = 1 %to &linkcnt ;
         &&_q&k
      %end ; ;
      run ;
      data _temp_ ;
         merge _temp1_ (in = _left) _temp2_ (in = _right) ;
         by
         %do k = 1 %to &linkcnt ;
             &&_f&k
         %end ;;
         if _left and not _right ;
      run ;
      %let empty = 0 ;
      data _null_ ;
         set _temp_ ;
         call symput("empty", _n_) ;
      run ;

 /*
  According to the following condition, the program invokes the %ERRWRITE macro
  writing detected errors to the error and errorval data sets.
 */

      %if &empty > 0 %then
      %do ;
          %errwrite (&libname, &table, &&_n&i, RI, &lasterr, &pcount) ;
      %end ;
     %end ;
    %end ;
    proc datasets library = work memtype = data ;
    delete _temp_ temp1_ _temp2_ ;
    run ;
    quit ;
   %end ;

 %mend vforeign ;
******************************************************************************************

/*The following example code appears on pages 155-157.*/
********************************************************

 /*
  PROGRAM     VROWCOL.
  DESCRIPTION Verifies specified table according to the Row and/or Column
              Integrity rules.
  USAGE       %vrowcol (libname, table, event, sclfile) ;
  PARAMETERS  libname - is the name of the library storing the data
                        dictionary data sets, such as object, property,
                        vrowcol, etc.
              table   - is the name of the table that must be verified.
              event   - is the event defining invocation of the verification
                        process.
              sclfile - is the name of the external file containing SCL template.
  REQUIRES    The object, property, vrowcol, and message data sets must exist.
              Also must exist external file containing the SCL template.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */

  %macro vrowcol (libname, table, event, sclfile);
   %let vercount = 0 ;

 /*
  The following DATA step creates macro variables and fills them with data from
  the vrowcol data set according to the specified table and the specified event:
  vercount - contains total number of verification processes defined for the
             specified table.
  _vn      - is a series of macro variables containing numbers of the verification
             processes defined for the specified table.
  _cl      - is a series of macro variables containing names of the columns of the
             specified table that must be verified.
  _vt      - is a series of macro variables containing types of verification rules
             for the  columns of the specified table.
  _me      - is a series of macro variables containing arithmetical or logical
             expressions concerning the verified columns of the specified table.
  _cn      - is a series of macro variables containing arithmetical or logical
             operators concerning the verified columns of the specified table.
  _ex      - is a series of macro variables containing arithmetical or logical
             expressions concerning the related columns to the verified columns
             of the specified table.
  _ms      - is a series of macro variables containing message identification numbers.
 */

   data _null_ ;
      retain _vcount 1;
      set &libname..VRowcol ;
      where upcase(left(table)) = upcase("&table") and
            upcase(left(event)) = upcase("&event");
      call symput("_vn" || left(_vcount), vernum) ;
      call symput("_cl" || left(_vcount), trim(left(column))) ;
      call symput("_vt" || left(_vcount), left(vertype)) ;
      call symput("_me" || left(_vcount), trim(left(mainexpr))) ;
      call symput("_cn" || left(_vcount), trim(left(conditn))) ;
      call symput("_ex" || left(_vcount), trim(left(express))) ;
      call symput("_ms" || left(_vcount), trim(left(message))) ;
      call symput("vercount", _vcount) ;
      call symput("vrowcol", "noerrors") ;
      _vcount + 1 ;
   run ;

 /*
  According to the following condition, the program generates SCL code and stores
  it in the external file. Such code implements the Row and/or Column
  Integrity verification process while updating the specified table in the data
  entry environment.
 */

   %if &vercount > 0 %then
   %do ;
    %if %upcase(&event) = U %then
    %do ;

 /*
  The following DATA step creates macro variables and fills them with data from
  the message data set according to the values of the _ms series of macro variables:
  _tx - is a series of macro variables containing message text for the detected
        errors.
  _mt - is a series of macro variables containing message types of the messages
        storing in the _tx series of macro variables.
 */

     data _null_ ;
               set &libname..Message ;
        %do j = 1 %to &vercount ;
           if message = &&_ms&j then
           do ;
              call symput("_tx" || left(&j),"'" || trim(left(text)) || "'") ;
              call symput("_mt" || left(&j), left(mestype)) ;
           end;
        %end;
     run ;

 /*
  The following DATA step creates a _temp_ data set containing the SCL code
  performing the Row and/or Column Integrity verification process, based on the
  SCL template and generated according to the values of the macro variables
  _cn, _mt, _me, _ex, _tx, _cl (see DATA step above).
 */

     data _temp_ ;
        length line $ 100 ;
        infile "&sclfile" lrecl = 100 pad ;
        input line $100. ;
        output ;
        if upcase(trim(left(line))) = "_ROWCOL :" then
        do ;
           %do j = 1 %to &vercount ;
              line = "if NOT ((&&_me&j) " ;
              output;
              line = "&&_cn&j (&&_ex&j)) " ;
              output;
              line = " then do ;" ;
              output ;
              line = " _msg_ = &&_tx&j ; " ;
              output ;
              if upcase(trim("&&_mt&j")) = "E" then
              do;
                 line = "erroron &&_cl&j ; end; else do;
                         erroroff &&_cl&j;" ;
                 output ;
              end ;
              line = "end ;" ;
              output;
           %end ;
        input line $100. ;
        do while(upcase(trim(left(line))) ^= "RETURN ;") ;
           input line $100. ;
        end ;
        output ;
        end ;
     run ;

 /*
  The following DATA step writes generated SCL code to the external file.
 */

     data _null_ ;
        set _temp_ ;
        file "&sclfile" ;
        put line ;
     run ;
     proc datasets library = work memtype = data ;
     delete _temp_ ;
     run ;
     quit ;
    %end ;
   %end ;

  %mend vrowcol ;

****************************************************************************************


/* To make the REPLINE program shorter and easier to understand, we divided it into
two programs: REP2FILE and REPLINE. REP2FILE is merely a part of the REPLINE program
as it appears in the book and is called from the REPLINE program. REPLINE is shown in
the book on pages 178-192.
*/


/*
  PROGRAM     REP2FILE.
  DESCRIPTION Puts generated report, produced by the REPLINE macro, to the external file.
  USAGE       %rep2file (repds) ;
  PARAMETERS  repds - is the name of the SAS data set containing the report
                      contents.
  REQUIRES    This program is for internal use by the %REPLINE macro only.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
*/
%macro rep2file( repds ) ;

    %if %nrbquote(&rtpage) ^= &mis %then
        %let file = &tmpfile ;
    %else
        %let file = &outfile ;
/*
The following DATA step creates a report from the contents of the SAS data set
whose name is stored in repds macro variable and writes it to external file
whose name is stored in tmpfile macro variable.
*/
    data _null_ ;
        length tit $ 200 ;
        %if &curpage = 0 %then
        %do ;
            file "&file" print notitle header = newpage
                ll = remain lrecl = &lsize1 ;
        %end ;
        %else
        %do ;
            file "&file" mod print notitle header = newpage
            ll = remain lrecl = &lsize1 ;
        %end ;
        retain count &curpage tail &rpcount p 0 ;

        brtemplt = symget("rtemplt") ;
        brtemplt = translate(trim(left(brtemplt)), "-", " ") ;

        set &repds ;

        if trim(repline) = "." ||
        %if &rtitlen > 2
        %then %do ;
            repeat(" ", &rtitlen-2) ||
        %end ;
        %else %do ;
            " " ||
        %end ;
            left(brtemplt) and remain = &psize - 5
        then
        do ;
            tail = tail - 1 ;
            return ;
        end ;
        if trim(repline) = "#" ||
        %if &rtitlen > 2
        %then %do ;
            repeat(" ", &rtitlen-2) ||
        %end ;
        %else %do ;
            " " ||
        %end ;

            left(symget("rtemplt")) then
        do ;
            tail = tail - 1 ;
            return ;
        end ;

        repline = substr(repline,2) ;

        if remain = 2 and
            trim(left(repline)) = trim(left(brtemplt)) then
        do ;
            link under ;
            tail = tail - 1 ;
            if tail = 0 and &iii = &rpbrcnt then
                link repend ;
            else
                put ;
            return ;
        end ;

        if remain < tail + 3 and tail <= 7 then
        do ;
            if trim(left(repline)) ^= trim(left(brtemplt)) then
                put repline $char%eval(&lsize-1). ;
            tail = tail - 1 ;
            if  trim(left(repline)) ^= repeat("-", &rlablen - 1) then
                link under ;
            if tail = 0 and &iii = &rpbrcnt then
                link repend ;
            else do j = remain to 1 by -1 ;
                put ;
            end ;
            return ;
        end ;

        put repline $char%eval(&lsize-1). ;
        tail = tail - 1 ;
        if tail = 0 and &iii = &rpbrcnt then
            link repend ;
        else
            if remain = 1 then
                link under ;
        return ;
/*
The repend block creates and writes the text to the bottom of the report.
*/
        repend:
            if trim(left("%nrbquote(&rtend)")) ^= "&mis" then
            do ;
                tit = trim(left("%nrbquote(&rtend)")) ;
                c = int((&lsize-length(tit))/2)  ;
                put / @c tit ;
            end ;
        return ;
/*
The newpage block creates and writes the text at the top of each report page.
*/
        newpage :
            count + 1 ;
            call symput("curpage", left(count)) ;
            put "*"@ ;
            if trim(left("%nrbquote(&rtcomp)")) ^= "&mis" then
            do ;
                tit = trim(left("%nrbquote(&rtcomp)")) ;
                %if &lang = L %then
                %do ;
                    put tit@ %str(;)
                %end ;
                %else
                %do ;
                    c = &lsize - length(tit) %str(;)
                    put @c tit@ %str(;)
                %end ;
            end ;
            if trim(left("%nrbquote(&rtdate)")) ^= "&mis" then
            do ;
                %if &lang = L %then
                %do ;
                    tit = trim(left("%nrbquote(&rtdate)")) || " " ||
                        symget("curdate") %str(;)
                %end ;
                %else %do ;
                    tit = trim(symget("curdate")) || " " ||
                        trim(left("%nrbquote(&rtdate)"))%str(;)
                %end ;
                c = int((&lsize - length(tit))/2) ;
                put @c tit@ ;
            end ;
            if trim(left("%nrbquote(&rtpage)")) ^= "&mis" then
            do ;
                %if &lang = L %then
                %do ;
                    tit = trim(left("%nrbquote(&rtpage)")) || " " ||
                        left(put(count,4.)) ;
                    c = &lsize - length(tit) %str(;)
                    put @c tit@ %str(;)
                %end ;
                %else
                %do ;
                    tit = trim(left(put(count,4.))) || " " ||
                        trim(left("%nrbquote(&rtpage)")) ;
                    put @2 tit@ %str(;)
                %end ;
            end ;
            put ;
            c = int(&lsize/2) - 9 ;
            put @c "Report Line System" / ;
            c = (&lsize - length("%nrbquote(&rtitle)"))/2 ;
            tit = "%nrbquote(&rtitle)" ;
            put @c tit / ;
            if p = 0 then
                p = 1 ;
            else
            do ;
                link under ;
                tit = symget("rlablst") ;
                put @&rtitlen tit ;
                link under ;
            end ;
        return ;
/*
The under block creates and writes an underline closing report tables.
*/
        under :
            put @&rtitlen "-"@ ;
            do i = 2 to &rlablen ;
                put "-"@ ;
            end ;
            put ;
        return ;
    run ;
%mend rep2file ;

/*
  PROGRAM     REPLINE.
  DESCRIPTION Reports generation.
  USAGE       %repline (report, libname, tmpfile, outfile, lang,
                        psize, lsize, mis) ;
  PARAMETERS  report  - report number as it specified in RMain table.
              libname - is the name of the library storing the data dictionary
                        data sets, such as object, location, and report definition
                        data sets, such as rmain, rvars, rstat, etc.
              tmpfile - is the name of the external file reserved for temporary
                        use by REPLINE program.
              outfile - is the name of the external file storing the generated
                        report.
              lang    - is language orientation specification, should be L
                        (left-to-right orientation, like English) or R
                        (right-to-left orientation, like Hebrew).
              psize   - is the page size (in lines).
              lsize   - is the page width (in columns).
              mis     - is the code identifying the missing value.
  REQUIRES    The following data sets must exist: object, location, rmain,
              rinfo, rvars, rstat, rparams, rtotal.
  AUTHORS     T.Kolosova and S.Berestizhevsky.

  NOTE: In the current version of the %REPLINE macro the P and Q statistics are
        not implemented.
*/

%macro repline(report, libname, tmpfile, outfile, lang, psize, lsize, mis) ;

options pagesize = &psize linesize = &lsize missing = "&mis" ;  %let curpage = 0 ;

%let observ = 0 ;  %let rbrcount = 0 ; %let rpbrcnt = 0 ;
%let rcolnum = 0 ; %let rpcount = 0 ;  %let rrbrlst = ;
%let rtitlen = ;   %let rpgcount = 0 ; %let rpbrlst = ;
%let numlst = ;    %let rsrtlst = ;    %let rtemplt = | ;
%let rlablst = | ; %let rrevvar = ;    %let  rowbreak = 0 ;
%let ful_lst = | ;

%let lang = %upcase(&lang) ;
%let lsize1 = %eval(&lsize + 2) ;

/*
The following DATA step creates the macro variable curdate that contains the date of
the report generation.
*/

    data _null_ ;
        call symput("curdate",trim(left(day(date()))) || "/" ||
            trim(left(month(date()))) || "/" ||
            trim(left(year(date())))) ;
    run ;

/*
The following DATA step creates macro variables containing data from the rmain data
set:
    rtab   - contains the name of the table containing data for the report.
    rattr  - contains the report attributes.
    rtitle - contains the report title.
    rtcomp - contains the name of the organization producing the report.
    rtdate - contains prompt text for the date.
    rtpage - contains prompt text for page numbers.
    rtend  - contains the text that will appear at the bottom of the report.
*/

    data _null_ ;
        set &libname..RMain (where = (report = &report)) ;
        call symput("rtab",   left(table)) ;
        call symput("rattr",  repattr) ;
        call symput("rtitle", left(reptitle)) ;
        call symput("rtcomp", left(reporgan)) ;
        call symput("rtdate", left(repdate)) ;
        call symput("rtpage", left(repage)) ;
        call symput("rtend",  left(repend)) ;
    run ;

/*
The following DATA step is intended to get from the location data set information
about rtab table location. It creates the libdat macro variable that contains the
name of the library where data set corresponding to rtab table is stored.
*/

    data _null_ ;
        set &libname..Location ;
        where upcase(left(table)) = upcase("&rtab") ;
        call symput("libdat", trim(left(library))) ;
    run ;

/*
The following DATA step is intended to get, from the object data set, the name
of the data set corresponding to rtab table and put it to rtab macro variable.
*/

    data _null_ ;
        set &libname..Object ;
        where upcase(left(table)) = upcase("&rtab") ;
        call symput("rtab", trim(left(dataset))) ;
    run ;

/*
The following DATA step creates macro variables and fills them with data from
rinfo data set:
    rtitle   - is a series of macro variables containing titles for common use
               parameters.
    rpform   - is a series of macro variables containing formats for common use
               parameters.
    rfromc   - is a series of macro variables containing names of common use
               parameters.
    rpgcount - contains number of common use parameters.
*/

    data _null_ ;
        set &libname..RInfo (where = (report = &report)) ;
        call symput("rtitle" || left(infono), left(subtitle)) ;
        if left(format) ^= "&mis" then
            call symput("rpform" || left(infono), left(format)) ;
        else
            call symput("rpform" || left(infono)," ") ;
        if trim(left(reparam)) ^= "&mis" then
            call symput("rfromc" || left(infono), left(reparam)) ;
        else
            call symput("rfromc" || left(infono), "0") ;
        call symput("rpgcount", left(infono)) ;
    run ;

/*
The following PROC CATALOG creates the _out_ data set containing names and descriptions
of all user-defined formats.
*/

    proc catalog c = &libname..formats ;
    contents out = _out_ (keep = name desc) ;
    run ;
    quit ;

/*
The following PROC CONTENTS creates the _rtab_ data set containing the  names of rtab
data set columns and information about their formats.
*/

    proc contents data = &libdat..&rtab noprint
        out = _rtab_ (keep = name length type format
            formatl formatd nobs) ;
    run ;
    quit ;

/*
The following DATA step creates macro variables and fills them with data from
_rtab_ data set:
    v      - is a series of macro variables containing names of the columns of
             the rtab table.
    l      - is a series of macro variables containing lengths of these columns.
    t      - is a series of macro variables containing types of these columns.
    f      - is a series of macro variables containing formats of these columns.
    fl     - is a series of macro variables containing lengths of formatted
             presentation these columns.
    vars   - contains number of columns in the rtab table.
    observ - contains number of rows in the rtab table.
*/

    data _null_ ;
        set _rtab_ ;
        call symput("v" || left(_n_), left(upcase(name)));
        call symput("l" || left(_n_), left(length));
        call symput("t" || left(_n_), left(type));
        if trim(format) = "" then
            format = "&mis" ;
        else
            format = trim(format) || "." ;
        call symput("f" || left(_n_), left(format));
        call symput("fl" || left(_n_), left(formatl));
        call symput("vars", left(_n_)) ;
        call symput("observ", left(nobs)) ;
    run ;

/*
The following DATA step creates macro variables and fills them with data from
the rvars data set:
    rcolnum  - number of columns from the rtab data set that present in the
               report.
    _var     - is a series of macro variables containing names of the columns
               that present in the report.
    colt     - is a series of macro variables containing titles for the columns.
    numlst   - contains list of numeric columns names.
    rrevvar  - contains list of columns names (separated by "*") that must be
               cared specially for right-oriented report (for example, must be reversed
               before sorting).
    rsrtlst  - contains list of columns names that the rtab data set must be
               sorted by.
    rhf      - is a series of macro variables containing SAS statements for
               formatting output of each column.
    rtemplt  - contains template string for the report table.
    rlablst  - contains header for the report table.
    ful_lst  - contains full header for the report table.
    rbrcount - contains number of classifiers (both table and row classifiers)
               specified for the report.
    rpbrlst  - contains list of columns names specified as table classifiers.
    rrbrlst  - contains list of columns names specified as row classifiers.
    rowbreak - contains number of row classifiers.
*/

    data _null_ ;
        length tmp fulltmp $ 200 ;
        set &libname..RVars (where = (report = &report)) ;
        lngth = 0 ;
        retain nval count _rowb 0 ;
        call symput("rcolnum", left(order)) ;
        call symput("_var" || left(order), left(upcase(column))) ;
        call symput("colt" || left(order), left(coltitle)) ;
        %do i = 1 %to &vars ;
            if left(upcase(column)) = "&&v&i" and &&t&i = 1 then
                call symput("numlst", trim(symget("numlst")) ||
                    " " || left(column)) ;
        %end ;
        if index(upcase(colattr),"H") ^= 0 then
            call symput('rrevvar',trim(symget('rrevvar'))||
                 trim(left(column))||"*") ;
        if index(upcase(colattr), "S") ^= 0 or
            index(upcase(colattr), "T") ^= 0 or
            index(upcase(colattr), "R") ^= 0 then
            call symput("rsrtlst", trim(symget("rsrtlst")) ||
                " " || left(column)) ;
/*
The following part of the DATA step calculates the width of each report column
based on its format and title.
*/
        tmp = coltitle ;
        len = length(coltitle) ;
        if left(format) = left("&mis") then
        do ;
            select(left(upcase(column))) ;
            %do i = 1 %to &vars ;
                when ("&&v&i")
                    format = "&&f&i" ;
            %end ;
                otherwise ;
            end ;
        end ;
        if left(format) ^= left("&mis") then
        do ;
            i0 = indexc(format,"123456789") ;
            i1 = index(format, ".") ;
            if i0 > 0 and i1 > 0 then
                lngth = substr(format,  i0, i1 - i0) ;
            else do ;
                lngth = 0 ;
                select(left(upcase(column))) ;
                %do i = 1 %to &vars ;
                    when ("&&v&i")
                        lngth = &&fl&i ;  /*???? fl instead of l - check it*/
                %end ;
                    otherwise ;
                end ;
                if lngth = 0 then
                    do j = 1 to nn ;
                        set _out_ nobs = nn  point = j;
                        if upcase(trim(name) || ".") =
                            left(upcase(format))
                        then do ;
                            lngth = scan(desc, 3, ", ");
                            j = nn ;
                        end ;
                    end ;
            end ;
            tmp = " " || trim(left(column)) || " " ||
                trim(left(format)) ;
            call symput("rhf" || left(order), "put(" ||
                trim(left(column)) || "," || trim(left(format)) ||
                 ")") ;
        end ;
        else do ;
            select(left(upcase(column))) ;
            %do i = 1 %to &vars ;
                when ("&&v&i")
                do ;
                    call symput("rhf" || left(order),
                        "left(" || trim(left(column)) || ")") ;
                    lngth = &&l&i ;
                end ;
            %end ;
                otherwise ;
            end ;
        end ;
        lngth = max(len, lngth) ;

/*
The following part of the DATA step creates the report table template and header.
*/

        if index(upcase(colattr), "T") = 0 then
        do ;
            %if &lang = L %then
            %do;
                tmp = trim(symget("rtemplt")) || " " ||
                    repeat(" ",lngth-1) || " |" ;
            %end ;
            %else %do ;
                tmp = "| " || repeat(" ",lngth-1) || " " ||
                    trim(symget("rtemplt")) ;
            %end ;
            call symput("rtemplt", trim(tmp)) ;
        end ;
        len = lngth - len ;
        if len > 0 then
        do  ;
            %if &lang = R %then
            %do ;
                if index(upcase(colattr), "T") = 0 then
                    tmp = "| " || repeat(" ", len-1) ||
                        trim(left(coltitle)) ||
                        " " || trim(symget("rlablst")) %str(;)
                fulltmp = "| " || repeat(" ", len-1) ||
                    trim(left(coltitle)) ||
                    " " || trim(symget("ful_lst")) %str(;)
            %end ;
            %else
            %do ;
                if index(upcase(colattr), "T") = 0 then
                    tmp = symget("rlablst") || " " ||
                        trim(left(coltitle)) || repeat(" ", len-1) ||
                        " |" %str(;)
                fulltmp = symget("ful_lst") || " " ||
                    trim(left(coltitle)) || repeat(" ", len-1) ||
                    " |" %str(;)
            %end ;
        end ;
        else do ;
            %if &lang = L %then
            %do ;
                if index(upcase(colattr), "T") = 0 then
                    tmp = trim(symget("rlablst")) || " " ||
                        trim(left(coltitle)) || " |" %str(;)
                fulltmp = trim(symget("ful_lst")) || " " ||
                    trim(left(coltitle)) || " |" %str(;)
            %end ;
            %else
            %do ;
                if index(upcase(colattr), "T") = 0 then
                    tmp  = "| " || trim(left(coltitle)) ||
                        " " || trim(symget("rlablst")) %str(;)
                fulltmp  = "| " || trim(left(coltitle)) ||
                    " " || trim(symget("ful_lst")) %str(;)
            %end ;
        end ;
        if index(upcase(colattr), "T") = 0 then
            call symput("rlablst", trim(tmp)) ;
        call symput("ful_lst", trim(fulltmp)) ;

/*
The following part of the DATA step counts classification columns and creates
lists of their names.
*/

        if index(upcase(colattr), "T") > 0  then
        do ;
            count + 1 ;
            call symput("rbrcount", left(count)) ;
            call symput("rpbrlst", (trim(symget("rpbrlst")) ||
                " " || trim(left(column)))) ;
        end ;
        if index(upcase(colattr), "R") > 0 then
        do ;
            count + 1 ;
            _rowb + 1 ;
            call symput("rbrcount", left(count)) ;
            call symput("rrbrlst", (trim(symget("rrbrlst")) ||
                " " || left(column))) ;
            call symput("rowbreak", left(_rowb)) ;
        end ;
    run ;

/*
The following DATA step copies the rtab data set from its location to the WORK library.
*/

    data &rtab ;
        set &libdat..&rtab ;
    run ;

    %if %length(&rsrtlst) ^= 0 %then
    %do ;
        %if &lang = R and %length(&rrevvar) > 0 %then
        %do ;

/*
The following DATA step reverses those columns of the rtab data set that need
special care for right-to-left oriented reports.
*/

            data &rtab ;
                set &rtab ;
                %let i = 1 ;
                %let tmp = %scan(&rrevvar, 1, *) ;
                %do %while(%length(&tmp) > 0) ;
                    &tmp = reverse(trim(left(&tmp))) ;
                    %let i = %eval(&i + 1) ;
                    %let tmp = %scan(&rrevvar, %eval(&i), *) ;
                %end ;
            run ;
        %end ;

/*
The following PROC SORT sorts the rtab data set in required order.
*/

        proc sort data = &rtab ;
            by &rsrtlst ;
        run ;
    %end ;

/*
The following PROC SORT and DATA step create the rstat data set containing
merged information about classifiers and associates with them statistics.
*/

    proc sort data = &libname..rvars (where = (report = &report))
        out = rvars ;
        by column ;
    run ;
    data rstat ;
        merge rvars &libname..rstat (where = (report = &report)) ;
        by column ;
    run ;

/*
The following PROC SORT prepares the rstat data set for the next DATA step.
*/

    proc sort data = rstat ;
        by order statno ;
    run ;

/*
The following DATA step creates macro variables and fills them with information
from the rstat data set:
    slb - is a series of macro variables containing number of statistics for
          each classifier.
    slb - is a series of two-dimensional macro variables containing titles for
          each statistic.
    rso - is a series of two-dimensional macro variables containing the number of
          columns (analysis variables) to which each statistics should be
          applied.
    s   - is a series of three-dimensional macro variables containing a reference
          of each analysis variable to the _var representing all report columns.
    r   - is a series of three-dimensional macro variables containing SAS
          expression for statistics calculation.
*/

    data _null_ ;
        length tmp $ 20 varname $ 8;
        retain count 0 ;
        set rstat (where = (report = &report)) ;
        by order statno ;
        if first.order then
            call symput("slb" || left(order),0) ;
        if trim(repstat) ^= "" then
        do ;
            if first.statno then
            do ;
                count = 0 ;
                call symput("slb" || trim(left(order)) || "_" ||
                    left(statno), trim(left(statitle))) ;
                call symput("slb" || left(order), left(statno)) ;
                call symput("rso" || trim(left(order)) || "_" ||
                    left(statno), 0) ;
            end ;
            count + 1 ;
            call symput("rso" || trim(left(order)) || "_" ||
                left(statno), left(count)) ;
            select (upcase(analvar)) ;
            %do i = 1 %to &rcolnum ;
                when("&&_var&i")
                do ;
                    tmp = "s" || trim(left(statno)) || "_" ||
                        left("&i") ;
                    call symput("s" || trim(left(order)) || "_" ||
                        trim(left(statno)) || "_" ||
                        left(count), left(&i)) ;
                end ;
            %end ;
                otherwise ;
            end ;

/*
The following part of the DATA step creates the r tree-dimensional macro
variables and fills them with generated SAS expression.
*/

            varname = "r" || trim(left(order)) || "_" ||
                trim(left(statno)) || "_" || left(count) ;
            select (upcase(repstat)) ;
                when ("N")
                    call symput(varname," n(" || trim(analvar) ||
                        ")=" || left(tmp)) ;
                when ("A")
                    call symput(varname," mean(" || trim(analvar) ||
                        ")=" || left(tmp)) ;
                when ("D")
                    call symput(varname," std(" || trim(analvar) ||
                        ")=" || left(tmp)) ;
                when ("M")
                    call symput(varname," min(" || trim(analvar) ||
                        ")=" || left(tmp)) ;
                when ("X")
                    call symput(varname," max(" || trim(analvar) ||
                        ")=" || left(tmp)) ;
                when ("S")
                    call symput(varname," sum(" || trim(analvar) ||
                        ")=" || left(tmp)) ;
                when ("V")
                    call symput(varname," var(" || trim(analvar) ||
                        ")=" || left(tmp)) ;
                when ("R")
                    call symput(varname," range(" || trim(analvar) ||
                        ")=" || left(tmp)) ;
                otherwise ;
            end ;
        end ;
    run ;

/*
The following DATA step creates macro variables and fills them with generated
data:
rtitlen - contains shift of the report table from the left side of the page
          so the report will be center justified.
rlablen - width of the report table.
rcolpos - list of report columns positions (separated by "*").
*/

    data _null_ ;
        length tmp rcolpos $ 200 ;
        tmp = symget("rlablst") ;
        len = length(tmp) ;
        if len+1 > &lsize then
            len1 = 1 ;
        else
            len1 = int((&lsize - len - 1)/2 +1) ;
        call symput("rtitlen", left(len1)) ;
        call symput("rlablen", left(len)) ;

/*
The following part of the DATA step calculates positions of each report column.
*/

        tmp = translate(trim(tmp), "*", " ") ;
        ind = index(tmp, "|") ;
        count = 0 ;
        %if &lang =  L %then
            dumcnt = ind + 2 %str(;) ;
        do while(ind ^= length(tmp)) ;
            %if &lang = L %then
            %do ;
                rcolpos = trim(rcolpos) ||
                    "*" || left(count + ind + 2) %str(;)
            %end ;
            %else
            %do ;
                rcolpos = "*" ||
                    trim(left(count + ind + 2)) || rcolpos %str(;)
            %end ;
            count + ind ;
            %if  &lang = R %then
                dumcnt = count + 2 %str(;) ;
            tmp = substr(tmp, ind + 1) ;
            ind = index(tmp, "|") ;
        end ;
        do i = 1 to &rbrcount - &rowbreak ;
            rcolpos = "*" || trim(left(dumcnt)) || rcolpos ;
        end ;
        call symput("rcolpos", rcolpos) ;
    run ;
    %if %length(&rpbrlst) > 0 %then
    %do ;

/*
The following PROC SORT data set creates the pgl data set containing values of
table classifiers.
*/

        proc sort data = &rtab out = pgl nodupkey ;
            by &rpbrlst ;
        run ;
        %if &lang = R and %length(&rrevvar) > 0 %then
        %do ;

/*
The following DATA step restores columns that were reversed previously.
*/

            data &rtab ;
                set &rtab ;
                %let i = 1 ;
                %let tmp = %scan(&rrevvar, 1, *) ;
                %do %while(%length(&tmp) > 0) ;
                    &tmp = reverse(trim(left(&tmp))) ;
                    %let i = %eval(&i + 1) ;
                    %let tmp = %scan(&rrevvar, %eval(&i), *) ;
                %end ;
            run ;
        %end ;

/*
The following DATA step creates macro variables and fills them with data from
the pgl data set:
    rpbrcnt - contains the number of the report tables produced according to the
              table classifiers.
    x       - contains the name of the last (by order) table classifier.
*/

        data _null_ ;
            set pgl nobs = n ;
            call symput("rpbrcnt", left(n)) ;
            call symput("x",trim(scan(symget("rpbrlst"),
                &rbrcount - &rowbreak, " "))) ;
            stop;
        run ;

/*
The following DATA step creates a series of s data sets so that each of them
contains a selection from the rtab data set corresponding to specific values of
the table classifiers. This DATA step also adds to the rtab data set a new _tabid
column that specifies previously described selections.
*/

        data
            %do i = 1 %to &rpbrcnt ;
                s&i (drop = _tabid)
            %end ;
            &rtab ;
            set &rtab ;
            by &rpbrlst ;
            retain _tabid 0 ;
            if first.&x then
                _tabid + 1 ;
            output &rtab ;
            select (_tabid) ;
            %do i = 1 %to &rpbrcnt ;
                when ( &i ) output s&i ;
            %end ;
                otherwise ;
            end ;
        run ;
    %end ;
    %else %do ;

/*
The following DATA step creates an s1 data set in the case there are no table
classifiers.
*/

        data s1 (drop = _tabid) &rtab ;
            set &rtab ;
            _tabid = 1 ;
        run ;
    %end ;
    %if %eval(%length(&rrbrlst)+%length(&rpbrlst)) > 0 and
        &observ > 0 %then
    %do ;
        %let tmpbreak = ;
        %let pagbreak = %eval(&rbrcount - &rowbreak) ;
        %do breakno = 1 %to &rbrcount ;
            %let tmpbreak  = &tmpbreak &&_var&breakno ;
            %if &&slb&breakno > 0 %then
            %do ;
/*
The following PROC SUMMARY creates a series of b data sets. Each of these data
sets corresponds to specific classifiers and contains calculated statistics.
*/
                proc summary data = &rtab ;
                    var &numlst ;
                    id _tabid ;
                    by &tmpbreak ;
                    output out = b&breakno
                    %do i = 1 %to &&slb&breakno ;
                        %do j = 1 %to &&rso&breakno._&i ;
                            &&r&breakno._&i._&j
                        %end ;
                    %end ;;
                run ;
            %end ;
        %end ;
    %end ;

    %let total = 0 ;
    %let tvar = ;
    %do i = 1 %to &rcolnum ;
        %let tvar = 0&tvar ;
    %end ;
/*
The following DATA step creates macro variables and fills them with information
from the rtotal data set:
    total   - contains number of statistics that should calculate on all the
              data from the rtab data set.
    tot     - is a series of macro variables containing number of columns
              (analysis variables) to which each statistic should be applied.
    stot    - is a series of  macro variables containing titles for each
              statistic.
    totitle - contains the maximum length of statistics titles.
    tvar    - contains string of 0 and 1, each 1 specified by its position
              number of the column (analysis variable) to which some statistics
              should be applied.
    t       - is a series of two-dimensional macro variables containing a reference
              of each analysis variable to the _var representing all report
              columns.
    tr      - is a series of two-dimensional macro variables containing SAS
              expression for statistics calculation.
*/
    data _null_ ;
        length tmp $ 20 varname $ 8 tvar $ 200 ;
        retain count titlen 0 ;
        set &libname..rtotal (where = (report = &report)) ;
        by statno ;
        if first.statno then
        do ;
            count = 0 ;
            call symput("total", (left(symget("total") + 1))) ;
            call symput("tot" || left(statno), 0) ;
            call symput("stot" || left(statno),
                trim(left(statitle))) ;
            titlen = max(titlen, length(left(statitle))) ;
            call symput("totitle", titlen) ;
        end ;
        if trim(repstat) ^= "&mis" then
        do ;
            count + 1 ;
            call symput("tot" || left(statno), left(count)) ;
            select (upcase(analvar)) ;
            %do i = 1 %to &rcolnum ;
                when("&&_var&i")
                do ;
                    tvar = symget("tvar") ;
                    if &i = 1 then
                        tvar = "1" || substr(tvar, 2) ;
                    else
                    if &i = &rcolnum then
                        tvar = substr(tvar,1,&i - 1) || "1" ;
                    else
                        tvar = substr(tvar,1,&i - 1) || "1" ||
                            substr(tvar, &i + 1) ;
                    call symput("tvar", tvar) ;
                    tmp = "s" || trim(left(statno)) || "_" ||
                        left("&i") ;
                    call symput("t" || trim(left(statno)) || "_" ||
                        left(count), left(&i)) ;
                end ;
            %end ;
                otherwise ;
            end ;
/*
The following part of the DATA step creates the tr two-dimensional macro
variables and fills them with generated SAS expressions.
*/
            varname = "tr" || trim(left(statno)) || "_" || left(count) ;
            select (upcase(repstat)) ;
                when ("N")
                    call symput(varname," n(" || trim(analvar) ||
                        ")=" || left(tmp)) ;
                when ("A")
                    call symput(varname," mean(" || trim(analvar) ||
                        ")=" || left(tmp)) ;
                when ("D")
                    call symput(varname," std(" || trim(analvar) ||
                        ")=" || left(tmp)) ;
                when ("M")
                    call symput(varname," min(" || trim(analvar) ||
                        ")=" || left(tmp)) ;
                when ("X")
                    call symput(varname," max(" || trim(analvar) ||
                        ")=" || left(tmp)) ;
                when ("S")
                    call symput(varname," sum(" || trim(analvar) ||
                        ")=" || left(tmp)) ;
                when ("V")
                    call symput(varname," var(" || trim(analvar) ||
                        ")=" || left(tmp)) ;
                when ("R")
                    call symput(varname," range(" || trim(analvar) ||
                        ")=" || left(tmp)) ;
                otherwise ;
            end ;
        end ;
    run ;

    %if &total > 0 %then
    %do ;
/*
The following PROC SUMMARY creates the _total_ data set containing total
 statistics.
*/

        proc summary data = &rtab ;
        var &numlst ;
        output out = _total_
            %do j = 1 %to &tot1 ;
                &&tr1_&j
            %end ;;
        run ;
        %do i = 2 %to &total ;
            proc summary data = &rtab ;
            var &numlst ;
            output out = pgt
                %do j = 1 %to &&tot&i ;
                    &&tr&i._&j
                %end ;;
            run ;
            data _total_;
                set _total_  pgt ;
            run ;
        %end ;
    %end ;
/*
The following loop produces the report tables one by one.
*/
    %let iii = 0 ;
    %do %while(&iii < &rpbrcnt or &rpbrcnt = 0 ) ;
        %let iii = %eval(&iii + 1) ;
/*
The following DATA step creates the pgt data set containing common use parameters
(if any) that should appear before each report table. This DATA step also
creates the second data set that is intended to store the generating report.
*/
        data second ( keep = repline)
            %if &iii = 1 %then
            %do ;
                pgt ( keep = repline) %str(;)
                length c_val $ 80 %str(;)
            %end ;
            ;
            length repline $ &lsize ;
            length tmp $ 200 ;
            rpcount = &rpcount ;
/*
The following part of the DATA step creates the pgt data set by taking common
use information from the rparams data set, formatting it, and putting to both
the pgt and the second data sets.
*/
            %if &rpgcount >= 1 %then
            %do ;
                %if &iii = 1 %then
                %do ;
                    %do i=1 %to &rpgcount ;
                        %if %length(&&rfromc&i) ^= 0 %then
                        %do ;
                            do i = 1 to attrnobs ;
                                set &libname..rparams nobs = attrnobs
                                    point = i ;
                                if upcase(left(reparam)) =
                                    upcase(left("&&rfromc&i")) then
                                do ;
                                    %if %length(&&rpform&i) > 0 %then
                                    %do ;
                                        c_val = put(paramval,
                                            &&rpform&i) ;
                                    %end ;
                                    %else %do ;
                                        c_val = paramval ;
                                    %end ;
                                    i = attrnobs ;
                                end ;
                            end ;
                            %if &lang = R %then
                            %do ;
                                tmp = trim(left(c_val)) || " " ||
                                    "%nrbquote(&&rtitle&i)" %str(;)
                            %end ;
                            %else
                            %do ;
                                tmp = trim(left("%nrbquote(&&rtitle&i)")) ||
                                    " " || c_val %str(;)
                            %end ;
                        %end ;
                        p = &rtitlen + &rlablen - length(tmp) ;
                        repline = "." || repeat(" ", p-2) || tmp ;
                        output second pgt ;
                    %end ;
                    repline = " " ;
                    output second pgt ;
                %end ;
                %else
                %do ;
                    do i = 1 to attrnobs ;
                        set pgt nobs = attrnobs point = i ;
                        output ;
                    end ;
                %end ;
                rpcount = rpcount + &rpgcount + 1 ;
            %end ;
/*
The following part of the DATA step creates text containing table classifiers
and there values appearing before each report table.
*/
            c = max(0,&rtitlen - 2) ;
            %if &rpbrcnt > 0 %then
            %do ;
                i = &iii ;
                set pgl point = i ;
                    %do i = 1 %to %eval(&rbrcount - &rowbreak) ;
                        %if &lang = L  %then %do ;
                            repline = "." || repeat(" ", c) ||
                                trim(left("&&colt&i"))
                            || ":   " || left(&&rhf&i) %str(;) ;
                        %end ;
                        %else %do ;
                            repline = ":"||left("&&colt&i") ;
                            repline =
                            %if %index(&rrevvar, &&_var&i%str(*)) ^= 0
                            %then %do ;
                                reverse(trim(left(&&rhf&i)))
                            %end ;
                            %else %do ;
                                trim(left(&&rhf&i))
                            %end ;
                                || "   " || repline %str(;)
                            repline = "." || repeat(" ",
                                c + &rlablen - length(repline)) ||
                                repline ;
                        %end ;
                        output second ;
                        rpcount + 1 ;
                    %end ;
            %end ;
/*
The following part of the DATA step creates header of the report tables.
*/
            tmp = symget("rlablst") ;
            link under ;
            repline = "." || repeat(" ", c) || left(tmp) ;
            output second ;
            link under ;
            rpcount + 3 ;
            call symput("rpcount", left(rpcount)) ;
            stop ;
            return ;
/*
The under block creates an underline for the report tables.
*/
            under :
                repline = "." || repeat(" ", c) ||
                    repeat("-", &rlablen - 1) ;
                output second ;
            return ;
        run ;
        %if &rbrcount > 0 or &rowbreak > 0 %then
        %do ;
/*
The following DATA step creates the newtmp data set that contains blanks
instead of repeating values in the columns specified as row classifiers.
*/
            data newtmp ;
                set s&iii ;
                length b 4 ;
                by
                    %do i=1 %to &rbrcount ;
                        &&_var&i
                    %end ;
                ;
                %do i = &rbrcount %to 1 %by -1 ;
                    if not first.&&_var&i then
                        &&_var&i = " " ;
                    if last.&&_var&i then
                        b = &i ;
                %end ;
            run ;
        %end ;
        %else
        %do ;
/*
The following DATA step simply copies the s data set to the newtmp data
set in the case there are no row classifiers.
*/
            data newtmp ;
                set s&iii ;
                length b 4 ;
            run ;
        %end ;
/*
The following DATA step creates the first data set containing the report
table.
*/
        data first  (keep = repline) ;
            length repline repline0 str0 $ &lsize
                tmp templt brtemplt $ 200 ;
            retain rpcount &rpcount ;
            c = max(0, &rtitlen - 2) ;
            templt = left(symget("rtemplt")) ;
            brtemplt = translate(trim(left(templt)), "-", " ") ;
/*
The following part of the DATA step writes raw data from the newtmp data
set to the report table.
*/
            set newtmp nobs = last ;
            repline = "." || repeat(" ", c) || templt ;
            %do _i1 = %eval(&rbrcount - &rowbreak + 1) %to &rcolnum ;
                repline0 = &&rhf&_i1 ;
                len = length(repline0) ;
                if trim(repline0) = "" or
                    left(repline0) = left("&mis") then ;
                else
                do ;
                    %if %length(&rrevvar) ^= 0 and &lang = R and
                        %index(&rrevvar, &&_var&_i1) > 0 %then
                    %do ;
                        %if &_i1 > 1 %then
                        %do ;
                            %if %scan(&rcolpos, &_i1 , *) =
                                %scan(&rcolpos,
                                %eval(&_i1 - 1), *) %then
                                %let p = %eval(&rlablen - 2) ;
                            %else
                                %let p = %eval(%scan(&rcolpos,
                                    %eval(&_i1 - 1), *) - 4) ;
                        %end ;
                        %else
                            %let p = %eval(&rlablen - 2) ;
                        %let p = %eval(&p + &rtitlen - 2) ;
                        repline = substr(repline, 1, &p - len ) ||
                            trim(repline0) ||
                            substr(repline, &p + 1) %str(;)
                    %end ;
                    %else
                    %do ;
                        %let p = %scan(&rcolpos, &_i1, *) ;
                        %let p = %eval(&p + &rtitlen - 1) ;
                        repline = substr(repline, 1, &p ) ||
                            trim(repline0) ||
                            substr(repline, &p + len + 1) %str(;)
                    %end ;
                end ;
            %end ;
            output ;
            rpcount + 1 ;
/*
The following part of the DATA step takes statistics from the series
of the b data sets, formats them, and writes them  to the report table.
*/
            if b ^= . then
            do ;
                link templt ;
                do i1 = &rbrcount to b by -1 ;
                  select(i1) ;
                  %do _i1 = 1 %to &rbrcount ;
                    when(&_i1)
                    do ;
                        %let j = &&slb&_i1 ;
                        %if &j > 0 %then
                            %do kk = 1 %to &j ;
                                repline = "." || repeat(" ", c) ||
                                    templt ;
                                repline0 = "." || repeat(" ", c) ||
                                    templt ;
                                str0 = "" ;
                                tmp = "%nrbquote(&&slb&_i1._&kk)" ;
                                wrap = 0 ;
                                %if &lang = L %then
                                %do ;
                                  %let p = %scan(&rcolpos, &_i1, *) ;
                                  %let p_next =
                                    %scan(&rcolpos, %eval(&_i1+1), *) ;
                                  %let p = %eval(&p + &rtitlen - 1) ;
                                  %let p_next =
                                    %eval(&p_next + &rtitlen - 1) ;
                                  if length(left(tmp)) >= &p_next - &p
                                    then wrap = 1 ;
                                  ind = &p + length(left(tmp)) + 1 ;
                                  if ind <= length(repline0) then
                                    repline0=substr(repline0, 1, &p) ||
                                        trim(tmp) ||
                                        substr(repline0, &p +
                                        length(tmp) + 1) ;
                                  else
                                    repline0=substr(repline0, 1, &p) ||
                                        tmp ;
                                %end ;
                                %else
                                %do ;
                                  %if &_i1 > 1 %then
                                  %do ;
                                    %if %scan(&rcolpos, &_i1 , *) =
                                        %scan(&rcolpos,
                                        %eval(&_i1 - 1), *) %then
                                            %let p =
                                                %eval(&rlablen - 2) ;
                                    %else
                                        %let p = %eval(%scan(&rcolpos,
                                            %eval(&_i1 - 1), *) - 4) ;
                                  %end ;
                                  %else
                                  %do ;
                                    %let p = %eval(&rlablen - 2) ;
                                  %end ;
                                  %let p_next = %scan(&rcolpos, &_i1, *) ;
                                  %let p = %eval(&p + &rtitlen - 1) ;
                                  %let p_next =
                                    %eval(&p_next + &rtitlen - 1) ;
                                  if length(left(tmp)) >= &p - &p_next
                                    then wrap = 1 ;

                                  ind = &p - length(left(tmp)) + 1 ;
                                  if ind > 0 then
                                    repline0 = substr(repline0, 1, ind) ||
                                        trim(left(tmp)) ||
                                        substr(repline0, ind +
                                        length(tmp) + 1) ;
                                  else
                                    repline0 = trim(tmp) ||
                                        substr(repline0, ind) ;
                                %end ;
                                if wrap = 1 then
                                do ;
                                    repline = repline0 ;
                                    output ;
                                    rpcount + 1 ;
                                    repline = "." || repeat(" ", c) ||
                                        templt ;
                                    repline0 = "." || repeat(" ", c) ||
                                        templt ;
                                end ;
                                set b&_i1 (where = (_tabid = &iii)) ;
                                    %let jj = &&rso&_i1._&kk ;
                                    %do _i2 = 1 %to &jj ;
                                        %let var = &&s&_i1._&kk._&_i2 ;
                                        %let p = %scan(&rcolpos, &var, *) ;
                                        %let p = %eval(&p + &rtitlen - 1) ;
                                        %do _i3 = 1 %to &rcolnum ;
                                            if &var = &_i3 then
                                            do ;
                                                &&_var&_i3 = s&kk._&_i3 ;
                                                str0 = &&rhf&_i3 ;
                                            end ;
                                        %end ;
                                        len = length(str0) ;
                                        if trim(str0) = "" then
                                            len = 0 ;
                                        if len > 0 then
                                            repline0 =
                                            substr(repline0, 1, &p) ||
                                            trim(str0) ||
                                            substr(repline0,
                                            &p + len + 1) ;
                                    %end ;
                                    repline = repline0 ;
                                    output ;
                                    rpcount + 1 ;
                                    if i1 = &rbrcount - &rowbreak + 1
                                    then do ;
                                        repline = "." ||
                                            repeat(" ", c) || brtemplt ;
                                        output ;
                                        rpcount + 1 ;
                                    end ;
                            %end ;
                        link templt1 ;
                    end ;
                  %end ;
                  end ;
                end ;
            end ;
            if _n_ = last then
                link under ;
            call symput("rpcount", left(rpcount)) ;
            return ;
/*
The under block creates and writes an underline closing report tables.
*/
            under :
                repline = "." || repeat(" ", c) ||
                    repeat("-", &rlablen-1) ;
                output ;
                rpcount + 1 ;
            return ;
/*
The templt block creates and writes the template string for the report.
*/
            templt :
                repline = "." || repeat(" ", c) || templt ;
                output ;
                rpcount + 1 ;
            return ;
/*
The templt1 block creates and writes the special template string for the
report.
*/
            templt1 :
                repline = "#" || repeat(" ", c) || templt ;
                output ;
                rpcount + 1 ;
            return ;
        run ;
/*
The following PROC APPEND appends the first data set to the previously
created second data set.
*/
        proc append base = second data = first  ;
        run ;
        %if &rpbrcnt = 0 %then
            %let rpbrcnt = 1 ;
        %if &iii = 1 and &total > 0 %then
        %do ;
/*
The following macro statements create the totcpos macro variable containing
list of report columns positions (separated by "*") for total statistics.
*/
            %if &lang = L %then
            %do ;
                %let totcpos = *%scan(&rcolpos,1,*) ;
                %let ind = %eval(%scan(&rcolpos,1,*) + &totitle + 3) ;
                %do i = 1 %to &rcolnum ;
                    %if %substr(&tvar,&i,1) = 1 %then
                    %do ;
                        %let totcpos = &totcpos.*&ind ;
                        %let k =  %scan(&rcolpos,%eval(&i+1),*) ;
                        %if &k =  %then
                            %let k = &rlablen ;
                        %let ind =
                            %eval(&ind + &k - %scan(&rcolpos,&i,*)) ;
                    %end ;
                    %else %do ;
                        %let totcpos = &totcpos.*0 ;
                    %end ;
                %end ;
            %end ;
            %else
            %do ;
                %let totcpos = *%scan(&rcolpos,&rcolnum,*) ;
                %let ind = %scan(&rcolpos,&rcolnum,*) ;
                %do i = &rcolnum %to 1 %by -1 ;
                    %let  j = %eval(&rcolnum - &i + 1) ;
                    %if %substr(&tvar,&j,1) = 1 %then
                    %do ;
                        %let totcpos = &totcpos.*&ind ;
                        %let k =  %scan(&rcolpos,%eval(&i+1),*) ;
                        %if &k =  %then
                            %let k = &rlablen ;
                        %let ind =
                            %eval(&ind + &k - %scan(&rcolpos,&i,*)) ;
                    %end ;
                    %else %do ;
                        %let totcpos = &totcpos.*0 ;
                    %end ;
                %end ;
            %end ;
            %let tlablst = ;
/*
The following DATA step creates macro variables and fills them with
generated data:
    tlablst - contains header for the report table.
    ttemplt - contains template string for the total report table.
    ttitlen - contains shift of the total report table from the left
              side of the page so the total report table will be center
              justified.
*/
            data _null_ ;
                length tmp tlablst $ 200 ;
                tlablst = "|" || repeat(" ", &totitle) || " |" ;
                tmp = left(symget("ful_lst")) ;
                %if &lang = L %then
                    tmp = substr(tmp,2) %str(;) ;
                %else
                %do ;
                    ind = index(substr(reverse(trim(tmp)), 2),
                        "|") %str(;)
                    tmp = reverse(substr(reverse(trim(tmp)), 2)) %str(;) ;
                %end ;
                %do i = 1 %to &rcolnum ;
                    %if %substr(&tvar, &i, 1) = 1 %then
                    %do ;
                        %if &lang = L %then
                        %do ;
                            tlablst = trim(tlablst) ||
                                substr(tmp, 1,
                                index(tmp,"|")) %str(;)
                        %end ;
                        %else
                        %do ;
                            tlablst = substr(reverse(substr(reverse(tmp),
                                1, index(reverse(tmp),"|"))), 1,
                                ind) || trim(tlablst) %str(;)
                        %end ;
                    %end ;
                    %if &i ^= &rcolnum %then
                    %do ;
                        %if &lang = L %then
                            tmp = substr(tmp,
                                index(tmp, "|") + 1) %str(;) ;
                        %else %do ;
                            tmp = reverse(substr(reverse(tmp),
                                index(reverse(tmp), "|"))) %str(;) ;
                            ind = index(substr(reverse(trim(tmp)),2),
                                "|") ;
                            tmp = reverse(substr(reverse(trim(tmp)),
                                2)) %str(;) ;
                        %end ;
                   %end ;
                %end ;
                call symput("tlablst", left(tlablst)) ;
                len = length(left(tlablst)) ;
                do i = 2 to len - 1 ;
                    if substr(tlablst, i, 1) ^= "|" then
                        tlablst = substr(tlablst, 1, i-1) || " " ||
                            substr(tlablst,i+1) ;
                end ;
                call symput("ttemplt", tlablst) ;
                if len + 1 > &lsize then
                    len = 1 ;
                else
                    len = int((&lsize - len - 1)/2 + 1) ;
                call symput("ttitlen",left(len)) ;
            run ;
/*
This DATA step creates the first data set that is intended to store the
total report table.
*/
            data first ( keep = repline) ;
                length repline $ &lsize ;
                length tmp $ 200 ;

                do i = 1 to attrnobs ;
                    set pgt nobs = attrnobs point = i ;
                        output ;
                end ;
                rpcount = &rpcount + &rpgcount + 1 ;
                c = max(0,&ttitlen - 2) ;
                tmp = symget("tlablst") ;
                tmplen = length(tmp) - 1 ;
                link under ;
                repline = "." || repeat(" ", c) || left(tmp) ;
                output ;
                link under ;
                rpcount + 3 ;
                call symput("rpcount", left(rpcount)) ;
/*
The following part of the DATA step takes total statistics from the
_total_ data set, formats them, and writes them to the first data set.
*/
                do _i2 = 1 to &total ;
                    set _total_ point = _i2 ;
                    repline0 = "." || repeat(" ", c) || left("&ttemplt") ;
                    %do i2 = 1 %to &total ;
                        if _i2 = &i2 then
                        do ;
                            tmp = "%nrbquote(&&stot&i2)" ;
                            %if &lang = L %then
                            %do ;
                                %let p = %scan(&totcpos, 1, *) ;
                                %let p = %eval(&p + &ttitlen - 1) ;
                                ind = &p + length(left(tmp)) + 1 ;
                                if ind <= length(repline0) then
                                    repline0=substr(repline0, 1, &p) ||
                                        trim(tmp) ||
                                        substr(repline0, &p +
                                        length(tmp) + 1) ;
                                else
                                    repline0=substr(repline0, 1, &p) ||
                                        tmp ;
                            %end ;
                            %else
                            %do ;
                                %let p = %eval(%length(&tlablst) - 2) ;
                                %let p = %eval(&p + &ttitlen - 1) ;
                                ind = &p - length(left(tmp)) + 1 ;
                                if ind > 0 then
                                    repline0 = substr(repline0, 1, ind) ||
                                        trim(left(tmp)) ||
                                        substr(repline0, ind +
                                        length(tmp) + 1) ;
                                else
                                    repline0 = trim(tmp) ||
                                        substr(repline0, ind) ;
                            %end ;
                            %do _i1 = 1 %to &&tot&i2 ;
                                %let p = %scan(&totcpos,
                                    %eval(&&t&i2._&_i1 + 1), *) ;
                                %let p = %eval(&p + &ttitlen - 1) ;
                                %do _i3 = 1 %to &rcolnum ;
                                    %if &&t&i2._&_i1 = &_i3 %then
                                    %do ;
                                        &&_var&_i3 = s&i2._&_i3 ;
                                        str0 = &&rhf&_i3 ;
                                    %end ;
                                %end ;
                                len = length(str0) ;
                                if trim(str0) = "" then
                                    len = 0 ;
                                if len > 0 then
                                    repline0 =
                                        substr(repline0, 1, &p) ||
                                        trim(str0) ||
                                        substr(repline0,
                                        &p + len + 1) ;
                            %end ;
                        end ;
                    %end ;
                    repline = repline0 ;
                    output ;
                    rpcount + 1 ;
                end ;
                link under ;
                rpcount + 1 ;
                call symput("rpcount", left(rpcount)) ;
                stop ;
                return ;
/*
The under block creates and writes an underline closing report tables.
*/
                under :
                    repline = "." || repeat(" ", c) ||
                        repeat("-", tmplen) ;
                    output ;
                return ;

            run ;
            %rep2file(first) ;
        %end ;
        %rep2file(second) ;
    %end ;

    %if %nrbquote(&rtpage) ^= &mis %then
    %do ;
/*
The following DATA step creates the final version of the report.
*/
        data _null_ ;
            length repline tit $ &lsize1 ;
            infile "&tmpfile" lrecl = &lsize1 pad ;
            file "&outfile" notitle ;
            input repline $char&lsize.. ;
            retain count 0 ;
            if substr(repline,2,1) = "*" then
            do ;
                count + 1 ;
                %if &lang = L %then
                %do ;
                    tit = trim(left("%nrbquote(&rtpage)")) || " " ||
                        trim(left(put(count, 4.))) || " of &curpage" ;
                    c = &lsize - length(tit) ;
                    repline = translate(repline, " ", "*") ;
                    repline = substr(repline, 1, c) || tit ;
                %end ;
                %else %do ;
                    tit = trim("&curpage") || " -EE " ||
                        trim(left(put(count, 4.)))
                        || trim(left("%nrbquote(&rtpage)")) ;
                    repline = trim(tit) ||
                        substr(repline, length(tit) + 1) ;
                %end ;
            end ;
            put repline $char&lsize.. ;
        run ;
    %end ;
/*
The following PROC DATASETS performs a housekeeping job.
*/
     proc datasets library = work memtype = data ;
        delete first second newtmp pgl pgt rstat
            rvars _out_ _rtab_ &rtab
            %do i = 1 %to &rbrcount ;
                b&i
            %end ;
            %do i = 1 %to &rpbrcnt ;
                s&i
            %end ;;
    run ;
%mend repline ;
*****************************************************************************************

/*The following example code appears on pages 205-211.*/
********************************************************

 /*

   TEMPLATE OF SCL CODE: FSOURCE.SCL
   DESCRIPTION SCL template supporting data entering through columnar data sheet
               screen form  containing up to 50 columns.
   AUTHORS     T. Kolosova and S. Berestizhevsky
*/

entry _templib _datanam _modeid
      _table  _opertyp
      _proper _objid _procid _pmenu _fileind $ ;
length _temp $ 200 ;

INIT :
   control allcmds ;
  _rc = pmenu(_pmenu) ;
  refresh ;
  _mis = symgetc("mis") ;
  _libref = symgetc("libref") ;

/*
  _templib - is the name of the library storing the updated table.
  _datanam - is the name of the SAS data set that is updated.
  _modeid  - is the mode identification name specified in the tables of  the
             Access set.
  _table   - is the name of the table that is updated.
  _opertyp - is the type of operations allowed on the table (Edit or Browse).
  _proper  - is the name of the property of the updated table (allowed to update
             a whole table (T) or several columns only (P)).
  _objid   - is the name of application object for which the updated table belongs.
  _procid  - is the process identification name that specifies value-dependent
             control to the application object.
  _pmenu   - is the pmenu name that can be attached to the window in which you
             update specified table.
  _fileind - is the name of data set that stores the history of table updates.
  _libref  - is the name of the library storing the data dictionary data sets,
             such as object, property, location, etc.
  _mis     - is the code identifying the missing value.
*/


   if _procid ^= "&mis" then do ;
      submit continue ;
         %process (&_libref, &_procid, &_table, &_templib,
                   &_mis, &_mis, &_mis) ;
         data _null_ ;
            set &_libref..POper (where = (procid = "&_procid"))
                                 nobs = last ;
            if _n_ = last then
               call symput("outputid", trim(outputid)) ;
         run ;

         data _null_ ;
            set &_libref..POutput (where = (outputid = "&outputid")) ;
            call symput("_ntemp", trim(outlib)) ;
         run ;
      endsubmit ;
      _origlib = _templib ;
      _templib = symgetc("_ntemp") ;
   end ;
   if upcase(_proper) = "P" then  do ;
      submit continue ;
/*
  See the %_PROJEC_ macro in the extra programs section.
*/
        %_projec_ (&_libref, &_objid, &_table, &_mis) ;
      endsubmit ;
_PROJECT :
   end ;
   if upcase(_opertyp) = "B" then
      protect _all_ ;
   _scname = _templib || "." || _datanam || "(cntllev = mem)" ;
   _dssec  = open(_scname, "UN") ;
   _sc_obs = nobs(_dssec) ;
   call set(_dssec) ;

 /*
   The following DATA step creates a data set (_fileind) containing the
   history of updates to the specified table.
 */

   submit continue ;
        data &_fileind ;
           length __index 8 __state $ 1;
           do i = 1 to &_sc_obs ;
              __index = i ;
              __state = "Y" ;
              output ;
           end ;
           __index = 0 ;
           output ;
        run ;
   endsubmit ;
   _index  = open(_fileind, "U") ;
   _cnt    = _sc_obs + 1 ;
   _tmpcnt = _cnt ;
   call setrow(_cnt) ;
   _indexn = varnum(_index, "__index") ;
   _staten = varnum(_index, "__state") ;
return ;

MAIN :
   call setcr("stay", "return") ;
   _cnt   = _tmpcnt ;
   _field = 0 ;
   call setrow(_cnt) ;
return ;

TERM :
   if _status_ = "C" then do ;
      _index = close(_index) ;
      _dssec = close(_dssec) ;
      return ;
   end ;
   if _status_ = "E" then do ;
     link _VERIF ;
     call setrow(1) ;
      _dssec = close(_dssec) ;
     _scname = _templib || "." || _datanam  || "(cntllev = rec)" ;
     _dssec  = open(_scname, "I") ;
     _frname = "work" || "." || _datanam ;
     if exist(_frname) >= 0 then
         _rc = delete(_frname) ;
     call new(_frname, _scname, 0, "N") ;
     _frnew  = open(_frname, "U") ;
     _quavar = nvar(_dssec) ;

  /*
    The following loop copies the updated table from the temporary library to
    the work library according to the history of table updates stored in the
    data set named _fileind.
  */
     do _i = 1 to _sc_obs ;
        _rc = fetchobs(_index, _i) ;
        __index = getvarn(_index, _indexn) ;
        if __index ^= 0 then do ;
           _rc = append(_frnew) ;
           _rc = fetchobs(_frnew, _i) ;
           _rc = fetchobs(_dssec, __index) ;
           do _ii = 1 to _quavar ;
              if (vartype(_dssec, _ii) = "N") then
                 call putvarn(_frnew, _ii , getvarn(_dssec, _ii)) ;
              else
                 call putvarc(_frnew, _ii , getvarc(_dssec, _ii)) ;
           end ;
           _rc = update(_frnew) ;
        end ;
     end ;
     _index = close(_index) ;
     _dssec = close(_dssec) ;
     _frnew = close(_frnew) ;

  /*
    The following %SORTMDL macro sorts the updated table according to its
    primary key. (See the  %SORTMDL macro in the extra programs section.)
  */

     submit continue ;
        %sortmdl (&_libref, work, &_table, &_datanam) ;
     endsubmit ;
     _scname = _templib || "." || _datanam  ;
     _rc = copy(_frname, _scname, "DATA") ;
     _event   = "U" ;
     _eventyp = "A" ;
     link _PROCESS ;
   end ;
return ;

GETROW :
   if _currow_ < _tmpcnt and l = _blank_ then do ;
      _rc   = fetchobs(_index, _currow_) ;
      _flag = getvarn(_index, _indexn) ;
      _rc   = fetchobs(_dssec, _flag) ;
   end ;
   else do ;
      if _currow_ >= _tmpcnt or upcase(l) = "I"  then do ;
         link _INSERT ;
         l     = _blank_ ;
      end ;
  end ;
return ;

PUTROW :
   if _currow_ < _tmpcnt then do ;

 /*
   The following link statement invokes the verifications corresponding to the
   current table update.
 */

      link _VERIF ;
      link _FORMULA ;
      _field + 1 ;
      if modified(l) = 1 then do ;
         if _field = 1 then do ;
            if upcase(l) = "I" then do ;
               _rc   = append(_index) ;
               _next = _sc_obs + 1 ;

 /*
  The following loop implements insertion of the row after the specified row.
 */
               do _i = _currow_ to (_sc_obs + 1) ;
                  _rc   = fetchobs(_index,_i) ;
                  _prev = getvarn(_index, _indexn) ;
                  call putvarn(_index, _indexn, _next) ;
                  _next = _prev ;
                  _rc   = update(_index) ;
               end ;
               _rc    = fetchobs(_index, _sc_obs+1) ;
               call putvarc(_index, _staten, "Y") ;
               _rc    = update(_index) ;
               _rc    = fetchobs(_index, _sc_obs + 2) ;
               call putvarc(_index, _staten, "Y") ;
               call putvarn(_index, _indexn, 0) ;
              _rc     = update(_index) ;
              _rc     = append(_dssec) ;
              _sc_obs + 1 ;
              _tmpcnt = _tmpcnt + 1 ;
            end;
            if upcase(l) = "D" then do ;
/*
  The following loop implements deletion of the specified row.
*/
               do _i = _currow_ to (_sc_obs - 1) ;
                  _rc = fetchobs(_index, (_i + 1)) ;
                  _next = getvarn(_index, _indexn) ;
                  _rc = fetchobs(_index, _i) ;
                  call putvarn(_index, _indexn, _next) ;
                  _rc = update(_index) ;
               end ;
               _rc = fetchobs(_index, _sc_obs) ;
               call putvarn(_index, _indexn, 0) ;
               _rc = update(_index) ;
               _tmpcnt = _tmpcnt - 1 ;
               l = _blank_ ;
            end ;
            if upcase(l) = "R" then do ;
               _rc   = fetchobs(_index,_currow_) ;
               _rr   = getvarn(_index,_indexn) ;
               _rc   = append(_index) ;
               _next = _sc_obs + 1 ;

  /*
        The following loop implements repetition of the specified row.
  */
               do _i = _currow_ to _sc_obs + 1 ;
                  _rc   = fetchobs(_index, _i) ;
                  _prev = getvarn(_index, _indexn) ;
                  call putvarn(_index, _indexn, _next) ;
                  _next = _prev ;
                  _rc   = update(_index) ;
               end ;
               _rc = fetchobs(_index, _sc_obs + 2) ;
               call putvarc(_index, _staten, "Y") ;
               call putvarn(_index, _indexn, 0) ;
               _rc = update(_index) ;
               _rc = append(_dssec) ;
               _rc = fetchobs(_dssec, _sc_obs+1) ;
               _rc = fetchobs(_dssec, _rr) ;
               _rc = update(_dssec, _sc_obs + 1) ;
               _sc_obs + 1 ;
               _tmpcnt + 1 ;
               l   = _blank_ ;
            end;
         end ;
         else l = _blank_ ;
      end;
      else do ;
         _rc  = fetchobs(_index, _currow_) ;
         _flag = getvarn(_index, _indexn) ;
         _rc  = update(_dssec, _flag) ;
      end ;
   end ;
   else do ;
      if _currow_ >= _tmpcnt then do ;
         link _INITIAL ;
         link _VERIF ;
         if modified(l) = 1 then do ;
            l = _blank_ ;
            alarm ;
            return ;
         end ;
         _tmpcnt + 1 ;
         _sc_obs + 1 ;
         _rc = append(_dssec) ;
         _rc = update(_dssec, _sc_obs + 1) ;
         _rc = append(_index) ;
         _rc = fetchobs(_index, _tmpcnt - 1) ;
         call putvarc(_index, _staten, "Y") ;
         call putvarn(_index, _indexn, _sc_obs) ;
         _rc = update(_index) ;
         _rc = fetchobs(_index, _sc_obs+1) ;
         call putvarc(_index, _staten, "Y") ;
         call putvarn(_index, _indexn, 0) ;
         _rc = update(_index) ;
      end ;
   end ;
return ;


 /*
   The following label is intended to insert the generated statement for the
   initial columns values.
 */

_INSERT :
     link _INITIAL ;
return ;

_INITIAL :
    link _FORMULA ;
return ;

_VERIF :
    link _PRIMARY ;
    link _FOREIGN ;
    link _DOMAIN ;
    link _ROW_COL ;
    link _CROSS ;
return ;

/*
  The following label is intended to insert the generated statements for the
  Table Integrity rule.
*/

_PRIMARY :
return ;

/*
  The following label is intended to insert the generated statements for the
  Referential Integrity rule.
*/


_FOREIGN :
return ;

/*
  The following label is intended to insert the generated statements for the
  Domain Integrity rule.
*/

_DOMAIN :
return ;

/*
  The following label is intended to insert the generated statements for the
  Row and Column Integrity rule.
*/

_ROW_COL :
return ;

/*
  The following label is intended to insert the generated statements for the
  Cross Integrity rule.
*/

_CROSS :
return ;

/*
  The following label is intended to insert the generated statements for the
  computed columns.
*/

_FORMULA :
return ;

_PROCESS :
    submit continue ;
       %process (&_libref, &_process, &_table, &_templib,
                 &_event, &_eventyp, &_mis) ;
    endsubmit ;
 return ;
******************************************************************************************

/*The following example code appears on pages 220-223.*/
********************************************************

 /*
  PROGRAM     MENU.
  DESCRIPTION Menu bar and pull-down menu generation program.
  USAGE       %menu (libref, uiname, mis) ;
  PARAMETERS  libref - is the name of the library storing the data dictionary
                       data sets, such as mlist, mmenu  and mprog.
              uiname - is the user interface identification name.
              mis    - is the code identifying the missing value.
  REQUIRES    The mlist, mmenu, and mprog data sets must exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */

  %macro menu (libref, uiname, mis) ;

 /*
  The following DATA step creates macro variables and fills them with data from
  the mlist data set:
  _lib - contains the name of the library that will store catalog containing the
         generated menu.
  _cat - contains name of the catalog containing the generated menu.
 */

   data _null_ ;
      set &libref..Mlist ;
      where upcase(left(uiname)) = upcase("&uiname") ;
      call symput("_lib", trim(left(library))) ;
      call symput("_cat", left(catalog)) ;
   run ;

   %let _m_count = 1 ;
   %let _mn1 = &uiname;

 /*
  The following DATA step creates the _mm_ data set with names and properties of
  those pull-down menus corresponding to the menu bar specified by the value of the
  uiname macro variable. This  DATA step also creates macro variables and fills
  them with data from the mmenu data set:
  _m_count - contains the number of menus,
  _mn      - is a series of macro variables containing the names of the menus.
 */

   data _mm_ (drop = new) ;
      new = 0 ;
      menuno = 0 ;
      m_count = 1 ;
      r_count = 0 ;
      do while (m_count > r_count) ;
         r_count + 1 ;
         menuno = r_count ;
         do i = 1 to n;
            set &libref..Mmenu nobs = n point = i ;
            if upcase(menuname) =
               upcase(symget("_mn" || left(r_count))) then
            do ;
               output;
               if trim(upcase(actype)) = "M" then
               do ;
                  link check ;
                  if new = 1 then
                  do ;
                     new = 0 ;
                     m_count + 1 ;
                     call symput("_mn" || left(m_count),
                                 upcase(actname));
                  end;
               end;
            end;
         end;
      end;
      call symput("_m_count", left(m_count)) ;
      stop ;
    check:
      do ;
         new = 1 ;
         do j = r_count + 1 to m_count ;
            if upcase(actname) = symget("_mn" || left(m_count)) then
            do ;
               new = 0 ;
               return ;
            end ;
         end ;
      end;
   run ;

 /*
  This DATA step creates macro variables and fills them with data from the _mm_
  data set:
  _c - is a series of macro variables containing the number of items
       corresponding to each menu.
  _i - is a series of macro variables containing item names for each menu.
  _a - is a series of macro variables containing action names for each item.
  _t - is a series of macro variables containing type of action for each item.
  _g - is a series of macro variables containing indications of gray (disabled)
       items.
  _i - is a series of macro variables containing mnemonic character for item
       selection.
 */

   data _null_ ;
      set _mm_ ;
      by menuno ;
      retain _count count 0 ;
      if first.menuno then
      do ;
         count = 1 ;
         _count + 1 ;
      end;
      call symput("_i" || trim(left(_count)) || left(count),
                  trim(left(itemname))) ;
      call symput("_a" || trim(left(_count)) || left(count),
                  trim(left(actname))) ;
      call symput("_t" || trim(left(_count)) || left(count),
                  upcase(left(actype))) ;
      call symput("_g" || trim(left(_count)) || left(count), left(itemgray)) ;
      call symput("_m" || trim(left(_count)) || left(count), left(itemnem)) ;
      if last.menuno then
         call symput("_c" || trim(left(_count)), left(count)) ;
      count + 1 ;
   run ;

 /*
  The following PROC PMENU creates a menu bar and pull-down menus corresponding
  to the values of _mn, _c, _i, _a, _t, _g,  _m series of macro variables and
  stores the created menu in the catalog specified by the values of the _lib and _cat macro
  variables.
 */

   proc pmenu cat = &_lib..&_cat ;
   %do m = 1 %to &_m_count ;
       menu &&_mn&m ;
       %let s = 0 ;
       %do i = 1 %to &&_c&m ;
           item "&&_i&m&i"
           %if %index(%upcase(&&_g&m&i), Y) ^= 0 %then
               gray ;
           %if %index(&&_m&m&i, &mis) = 0 %then
               mnemonic = "&&_m&m&i" ;
           %if %upcase(&&_t&m&i) = M %then
               menu = &&_a&m&i ;
           %if %upcase(&&_t&m&i) = U or %upcase(&&_t&m&i) = S %then
           %do ;
               selection = &&_a&m&i ;
               %let s =%eval(&s + 1) ;
               %let sel_&s = selection &&_a&m&i "&&_a&m&i" ;
           %end ;
           ;
       %end ;
       %do j = 1 %to &s ;
           &&sel_&j ;
       %end ;
   %end;
   run ;
   quit ;
   proc datasets library = work memtype = data nolist ;
   delete _mm_ ;
   run ;
   quit ;

  %mend menu ;
********************************************************************************************

/*The following example code appears on pages 224-225.*/
********************************************************

 /*
  PROGRAM     COMSTYLE.
  DESCRIPTION Generates source code for command-style macros.
  USAGE       %comstyle (libref, filename) ;
  PARAMETERS  libref   - is the name of the library storing the data dictionary
                         data sets, such as mmenu  and mprog.
              filename - is the name of the external file that will store
                         generated commad-style macros.
  REQUIRES    The mmenu and mprog data sets must exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */

  %macro comstyle (libref, filename) ;

 /*
  The following DATA step creates the _temp_ data set containing selected rows
  of the mmenu data sets according to the  specified condition.
 */

   data _temp_ (keep = actname);
      set &libref..MMenu ;
      where trim(upcase(actype)) = "U" ;
   run ;
   proc sort data = _temp_ nodupkey ;
   by actname ;
   run ;

 /*
  The following DATA step merges _temp_ and mprog data sets, creates macro
  variables and fill them with data from this data set:
  _m    - is a series of macro variables containing action names.
  _u    - is a series of macro variables containing names of the libraries
          concatenated with the names of the catalogs concatenated with names
          of catalog entries and with entry types.
  count - contains number of specified actions.
 */

   data _null_ ;
      length count 8 ;
      retain count 1 ;
      merge _temp_ &libref..MProg ;
      call symput("_m" || left(count), trim(actname)) ;
      call symput("_u" || left(count),
                  trim(library) || "." || trim(catalog) || "." ||
                  trim(entrynam) || "." || trim(entrytyp)) ;
      call symput("count", count) ;
      count + 1 ;
   run ;

 /*
  The following DATA step generates source code for the command-style macros
  according to the values of the _m and _u series of macro variables. The
  generated source code is stored in the external file specified by the
  parameter filename.
 */

   data _null_ ;
      length line $ 200 var $ 8 ;
      file "&filename" ;
      %if %eval(&count) > 1 %then
      %do ;
          %do i = 1 %to &count ;
              %let var = %nrstr(%macro) ;
              put "&var" ;
              put  " &&_m&i / cmd ; " ;
              put " afapp c =  &&_u&i ; " ;
              %let var = %nrstr(%mend ;) ;
              put "&var " ;
           %end ;
      %end ;
   run ;
   proc datasets library = work memtype = data ;
   delete _temp_ ;
   run ;
   quit ;

  %mend comstyle ;
******************************************************************************************

/*The following example code appears on pages 226-227.*/
********************************************************

 /*
  PROGRAM     APLMENU.
  DESCRIPTION Generates SCL statements associating SCL programs with pmenus.
  USAGE       %aplmenu (libref, uiname, filename) ;
  PARAMETERS  libref   - is the name of the library storing the data dictionary
                         data sets, such as mlist.
              uiname   - is the user interface identification name.
              filename - is the name of the external file storing the SCL
                         template.
  REQUIRES    The mlist data set and external file with SCL template must exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */

  %macro aplmenu (libref, uiname, filename) ;

 /*
  The following DATA step creates the _menu macro variable containing the name
  of the library  concatenated with the name of the catalog and the name of the
  user interface.
 */

    data _null_ ;
       set &libref..MList ;
       where trim(upcase(uiname)) = upcase("&uiname")  ;
       call symput("_menu", trim(library) || "." ||
                    trim(catalog) || "." || trim(uiname)) ;
    run ;

 /*
  The following DATA step creates the _temp_ data set containing the generated
  SCL statements includeed in the SCL template.
 */

    data _temp_ ;
       length line $ 200 ;
       infile "&filename" lrecl = 100 pad ;
       input line $100. ;
       output ;
       if trim(upcase(line)) = "INIT :" then
       do ;
          line =  "rc = PMENU(' " || "&_menu" || " ') ; refresh ;" ;
          output ;
       end ;
    run ;

 /*
  The following DATA step writes in the external file the generated SCL
  statements placed in the SCL template.
 */

    data _null_ ;
       set _temp_ ;
       file "&filename" ;
       put line ;
    run ;
    proc datasets library = work memtype = data ;
    delete _temp_ ;
    run ;
    quit ;

  %mend aplmenu ;
******************************************************************************************

/*The following example code appears on pages 246-247.*/
********************************************************

 /*
  PROGRAM     MODE.
  DESCRIPTION Generates a new data set containing a list of modes permitted for
              the specified user.
  USAGE       %mode (libref, userid, userpasw, password, restable) ;
  PARAMETERS  libref   - is the name of the library storing the data dictionary
                         data sets, such as aapplist, aappmode, auserpas, etc.
              userid   - is the user identification name of the current user.
              userpsw  - is the name of the password of the current user.
              password - is the name  of the password of the current application.
              restable - is the name of the generated table.
  REQUIRES    The aapplist, aappmode, auserpas ausermod data sets must exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */

  %macro mode (libref, userid, userpasw, password, restable) ;

 /*
  The following DATA step creates the appid macro variable containing the
  application identification name according to the specified application
  password.
 */

   data _null_ ;
      set &libref..AApplist ;
      where upcase(trim(password)) = upcase("&password") ;
      call symput("appid", upcase(trim(appid))) ;
   run ;

 /*
  The following DATA step creates a new data set containing rows from the aappmode
  data set corresponding to the value of the appid macro variable (see DATA step
  above).
 */

   data mode ;
      set &libref..AAppmode ;
      where upcase(trim(appid)) = "&appid" ;
   run ;

 /*
  The following DATA step creates the usergrp macro variables containing the
  name of the user group according to the specified user identification name
  and user password.
 */

   data _null_ ;
      set &libref..AUserpas ;
      where upcase(trim(userid)) = upcase("&userid")
        and upcase(trim(userpasw)) = upcase("&userpasw) ;
      call symput("usergrp", upcase(trim(usergrp))) ;
   run ;

 /*
  The following DATA step creates a new data set containing rows from the
  ausermod data set corresponding to the value of the usergrp macro variable
  (see DATA step above).
 */

   data user ;
      set &libref..AUsermod ;
      where upcase(trim(usergrp)) = "&usergrp" ;
   run ;

 /*
  The following PROC SORT sorts recently created data sets.
 */

   proc sort data = user ;
   by modeid ;
   run ;
   proc sort data = mode ;
   by modeid ;
   run ;

 /*
  The following DATA step creates the required data set containing a list of
  modes permitted for the specified user.
 */

   data &restable ;
      merge mode (in = _left) user (in = _right) ;
      by modeid ;
      if _left and _right ;
   run ;

  %mend mode ;


 /*-------------------------------------------------------------------*
  * TABLE-DRIVEN STRATEGIES FOR RAPID SAS(r) APPLICATIONS DEVELOPMENT *
  *               by Tanya Kolosova &  Samuel Berestizhevsky          *
  *       Copyright(c) 1995 by SAS Institute Inc., Cary, NC, USA      *
  *-------------------------------------------------------------------*
  *                                                                   *
  * This material is  provided "as is" by SAS  Institute Inc.  There  *
  * are no warranties, express or  implied, as to merchantability or  *
  * fitness for a particular purpose regarding the materials or code  *
  * contained herein. The Institute is not  responsible for errors    *
  * in this  material as it now  exists or will exist, nor does the   *
  * Institute provide technical support for it.                       *
  *                                                                   *
  *-------------------------------------------------------------------*
  *                                                                   *
  * Questions or problem reports concerning this material may be      *
  * addressed to the authors, Tanya Kolosova & Samuel Berestizhevsky  *
  *                                                                   *
  * by electronic mail:                                               *
  *                                                                   *
  *        sasconsl@actcom.co.il                                      *
  *                                                                   *
  * by ordinary mail:                                                 *
  *                                                                   *
  *        P.O. Box 1169, Nazerath-Ellit 17100, Israel                *
  *                                                                   *
  *-------------------------------------------------------------------*/
 /*

   This document describes the additional SAS macro programs NOT
   included in the book "Table-Driven Startegies for Rapid SAS
   Applications Development."

   Program Requirements
   --------------------

   The programs were developed under the SAS System, Version 6.10
   (operating systems OS/2 and Windows), and tested under the SAS

   The programs all require base SAS software. Some programs require
   SAS/AF and SAS/FSP software.
 */

/*
  PROGRAM     MODIFY.
  DESCRIPTION Modifies SAS data set structure.
  USAGE       %modify(libref, table, mis) ;
  PARAMETERS  libref - is the name of the library storing the data dictionary
                       data sets.
              table  - is the name of the table for which is requiered to
                       modify the SAS data set.
              mis    - is the code identifying the missing value.
  REQUIRES    The object, property, location, library, commacc and comoper
              data sets must exist. In addition the formats catalog must exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky.

  NOTE: This macro does not support renaming of columns.
*/

  %macro modify (libref, table, mis) ;

 /*
  The following DATA step creates a data set macro variable containing the name
  of the data set corresponding to the specified table.
 */

  data _null_ ;
     set &libref..Object
         (where = (upcase(trim(table)) = upcase("&table"))) ;
     call symput("_ds", trim(left(dataset))) ;
  run ;

 /*
  The following DATA step creates a macro variable containing name of the library
  where the existing SAS data set corresponding to the specified table is stored.
 */

  data _null_ ;
     set &libref..Location
         (where = (upcase(trim(table)) = upcase("&table"))) ;
     call symput("_lb" , trim(left(library))) ;
  run ;

 /*
  The following PROC CONTENTS creates the _new_ data set containing information
  about structure of existing SAS data set corresponding to the specified table.
 */

  proc contents data = &_lb..&_ds
                memtype = data
                out = _new_
                short noprint ;
  run ;

  data _new_ (rename = (name = column)) ;
     set _new_ ;
     if trim(format) = "" then
        format = "&mis" ;
  run ;

 /*
  The following DATA step creates the _old_ data set containing information
  from the Property table about the defined structure of SAS data set corresponding
  to the specified table.
 */

  data _old_ (drop = xxx rename = (title = label)) ;
     length type 8 ;
     set &libref..Property
         (rename = (type = xxx)
          where = (upcase(trim(table)) = upcase("&table"))) ;
     if xxx = "C" then type = 2 ;
     if xxx = "N" then type = 1 ;
     format = substr(format, index(format, ".")) ;
  run ;

  proc sort data = _old_ (keep = column type length format label) ;
  by column type length format label ;
  run ;

  proc sort data = _new_ (keep = column type length format label) ;
  by column type length format label ;
  run ;

  %let drop = 0 ;
  %let change = 0 ;
  %let new = 0 ;
  %let droplist = ;

  data _null_ ;
     set  _old_ ;
     call symput("_c" || left(_n_), trim(left(column))) ;
     call symput("_n" , left(_n_)) ;
  run ;

 /*
  The following DATA step creates macro variables and fills them with data
  from the merged _old_ and _new_ data sets:
  count - contains number of modified properties of the specified table.
  _l    - is a series of macro variables containing the names of the columns
          of the specified table with their types and length.
  _f    - is a series of macro variables containing the names of the columns of
          the specified table with their formats.
  _t    - is a series of macro variables containing the names of the columns of
          the specified table with their titles.
 */

  data _null_ ;
     retain count 1 ;
     merge _old_ (in = left) _new_ (in = right) ;
     by column type length format label ;
     if left and not right ;
     if type = 1 then
        _type = ""  ;
     else
        _type = "$" ;
     call symput("_l" || left(count), "length " || trim(column) ||
                 " " || trim(_type) || length) ;
     if trim(format) ^= "&mis" then
        call symput("_f" || left(count), "format " || trim(column) ||
                    " " || trim(format) || ".") ;
     else
        call symput("_f" || left(count), " ;") ;
     call symput("_t" || left(count), "label " || trim(column) ||
                 ' = %nrbquote(' || trim(left(label)) || ') ') ;
     call symput("count", left(count)) ;
     count + 1 ;
     call symput("new", 1) ;
  run ;

 /*
  The following DATA step createsa  macro variable containing a list of the columns
  of the specified table that must be droppped.
 */

  data _null_ ;
     merge _old_ (in = left) _new_ (in = right) ;
     by column ;
     if right and not left ;
     call symput("droplist", trim(symget("droplist")) || " "
                 || trim(column)) ;
     call symput("drop", 1) ;
  run ;

  data _new_ (rename = (column = _column type = _type
                        length = _length format = _format
                        label = _label)) ;
     set _new_ ;
  run ;

 /*
  The following DATA step creates macro variables and fills them with data
  from the merged _old_ and _new_ data sets:
  change - contains number of modified columns of the specified table.
  _w     - is a series of macro variables containing new names of the columns
           of the specified table.
  _o    - is a series of macro variables containing existing names of the
          columns of the specified table.
 */



  data _null_ ;
     retain ccnt 1 ;
     merge _old_ (in = left) _new_
                            (in = right rename = (_column = column)) ;
     by column ;
     if left and not right ;
     call symput("_w" || left(ccnt), trim(column)) ;
     if type = 2 then
        call symput("_o" || left(ccnt), "&mis") ;
     else
        call symput("_o" || left(ccnt), &mis) ;
     call symput("change", left(ccnt)) ;
     ccnt + 1 ;
  run ;

 /*
  The following DATA step modifies the SAS data set for the specified table
  according to the values of the macro variables created in the previous
  DATA steps.
 */
  %if &drop > 0 and &new > 0 and &change > 0 %then
  %do ;
     data &_ds
        (
        %if &drop > 0 %then
        %do ;
            drop = &droplist
        %end ;
        keep =
        %do i = 1 %to &_n ;
            &&_c&i
        %end ;
        ) ;
        %if &new > 0 %then
        %do i = 1 %to &count ;
            &&_l&i ;
            &&_f&i ;
            &&_t&i ;
        %end ; ;
        set &_lb..&_ds ;
        %if &change > 0 %then
        %do ;
            %do i = 1 %to &change ;
               &&_w&i =  &&_o&i ;
            %end ;
        %end ;
     run ;

 /*
  The %TRANSFER macro delivers the modified SAS data set to its permanent location.
 */

     %transfer (&libref, work, &_lb, &table, &mis) ;
  %end ;
%mend modify ;

 /*
  PROGRAM     DATMODEL.
  DESCRIPTION Sorts the data in the application table according to relational
              data model defined in the Property table.
  USAGE       %datmodel(libname, table, mis) ;
  PARAMETERS  libname - is the name of the library storing the data
                        dictionary data sets, such as object, property,
                        location, etc.
              table  - is the name of the application table.
              mis    - is the code identifying the missing value.
  REQUIRES    The object, property and location data sets must exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */

%macro datmodel (libname, table, mis) ;
  %if %upcase(&table) = PROPERTY %then
  %do ;
     data &libname..property ;
         set &libname..property ;
         if trim(left(format)) = "" then format = "&mis" ;
         if trim(left(domtab)) = "" then domtab = "&mis" ;
         if trim(left(domcol)) = "" then domcol = "&mis" ;
         if trim(left(meantab)) = "" then meantab = "&mis" ;
         if trim(left(meancol)) = "" then meancol = "&mis" ;
         if trim(left(attribut)) = "" then attribut = "&mis" ;
         if trim(left(initval)) = "" then initval = "&mis" ;
         if trim(left(formula)) = "" then formula = "&mis" ;
         if trim(left(updtype)) = "" then updtype = "&mis" ;
         if trim(left(missing)) = "" then missing = "&mis" ;
      run ;
      proc sort data = &libname..property nodupkey ;
      by table place ;
      run ;
  %end ;
  %else
  %do ;
     data  _null_ ;
        set &libname..object ;
        if upcase(left(table)) = upcase(left("&table"))
        then do ;
            call symput("dataset", dataset) ;
            stop ;
        end ;
     run ;

    data  _null_ ;
        set &libname..location ;
        if upcase(left(table)) = upcase(left("&table"))
        then do ;
            call symput("datalib", library) ;
            stop ;
        end ;
     run ;

    data  _null_ ;
        set &libname..property ;
        retain cnt key 0 ;
        if upcase(left(table)) = upcase(left("&table")) and
            upcase(type) = "C"
        then do ;
            cnt + 1 ;
            call symput("var"||left(cnt), column) ;
            call symput("cnt", left(cnt)) ;
        end ;
        if upcase(left(table)) = upcase(left("&table")) and
            upcase(attribut) = "P"
        then do ;
            key + 1 ;
            call symput("key"||left(key), column) ;
            call symput("key", left(key)) ;
        end ;
    run ;

    data &datalib..&dataset ;
        set &datalib..&dataset ;
        %do i = 1 %to &cnt ;
            if left(&&var&i) = "" then &&var&i = "&mis" ;
        %end ;
    run ;

    proc sort data = &datalib..&dataset nodupkey ;
    by
    %do i = 1 %to &key ;
        &&key&i
    %end ;;
    run ;
  %end ;
%mend datmodel ;


 /*
  PROGRAM     SORTMDL.
  DESCRIPTION Sorts data in updated table in the data entry environment.
  USAGE       %sortmdl(libname, curlib, table, dataset) ;
  PARAMETERS  libname - is the name of the library storing the data
                        dictionary data sets, such as object, property,
                        location, etc.
              curlib  - is the name of the library where the specified table is
                        updated.
              table   - is the name of the updated table.
              dataset - is the  name of  SAS data set corresponding to the
                        specified table.
  REQUIRES    The property data set must exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */

%macro sortmdl (libname, curlib, table, dataset) ;
  %if %upcase(&table) = PROPERTY %then
  %do ;
      proc sort data = &curlib..property ;
      by table place ;
      run ;
  %end ;
  %else
  %do ;
    data  _null_ ;
        set &libname..property ;
        retain cnt key 0 ;
        if upcase(left(table)) = upcase(left("&table")) and
            upcase(attribut) = "P"
        then do ;
            key + 1 ;
            call symput("key"||left(key), column) ;
            call symput("key", left(key)) ;
        end ;
    run ;

    proc sort data = &curlib..&dataset ;
    by
    %do i = 1 %to &key ;
        &&key&i
    %end ;;
    run ;
  %end ;
%mend sortmdl ;


 /*
  PROGRAM     VFORMAT.
  DESCRIPTION Generates value formats and adds them to the SAS catalog
              containing user-defined formats.
  USAGE       %vformat(libref, table, mis) ;
  PARAMETERS  libref - is the name of the library storing the data
                       dictionary data sets, such as object, property,
                       location, etc.
              table  - is the name of the table containing the values and
                       labels for the user-defined format.
              mis    - is the code identifying the missing value.
  REQUIRES    The object, property, and location data sets must exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */


%macro vformat(libref, table, mis) ;

/*
 This macro is a slightly modified part of the %FORMATS macro. For comments
 see the %FORMATS macro.
*/

  %let chekfm = 0 ;
   data _forms_ (keep =  format domtab domcol meantab meancol) ;
      set &libref..property ;
      if upcase(trim(left(domtab)))  = upcase("&table") and
         left(format) ^= "&mis" ;
      call symput("chekfm", 1) ;
   run ;
   %if &chekfm > 0 %then
   %do ;
       %let pcount = 0 ;
       %let vcount = 0 ;
       %let count  = 0 ;
       proc sort data = _forms_ nodupkey ;
       by format ;
       run ;

       data _null_ ;
          length pcount vcount 8 ;
          retain pcount vcount 1 ;
          call symput("_d"||left(vcount), "&mis") ;
          call symput("_c"||left(vcount), "&mis") ;
          call symput("_m"||left(vcount), "&mis") ;
          set _forms_ ;
          if trim(left(domtab)) ^= "&mis" then
          do ;
             call symput("_d"||left(vcount), left(domtab)) ;
             call symput("_c"||left(vcount), left(domcol)) ;
             call symput("_m"||left(vcount), left(meancol)) ;
             call symput("_v"||left(vcount), left(substr(format, 1,
                                             index(format,".") - 1))) ;
             call symput("vcount", vcount) ;
             vcount + 1 ;
          end ;
       run ;
       %if &vcount > 0 %then
       %do ;
           %do i = 1 %to &vcount ;
               data _null_ ;
                  set &libref..location ;
                  where upcase(left(table)) = upcase("&&_d&i") ;
                  call symput("_l"||left(&i), left(library)) ;
               run ;
               %transfer (&libref, &&_l&i, work, &&_d&i) ;
               data _domain_ (keep = &&_c&i  &&_m&i) ;
                  set &&_d&i ;
                  %if %index(&&_v&i, $) = 1 %then
                  %do ;
                      &&_c&i = upcase(&&_c&i) ;
                  %end ;
               run ;
               proc sort data = _domain_ nodupkey ;
               by &&_c&i ;
               run ;
               data _null_ ;
                  retain _count 1 ;
                  set _domain_ ;
                  call symput("_n"||left(_count), left(&&_c&i)) ;
                  call symput("_k"||left(_count), trim(left(&&_m&i))) ;
                  call symput("count", _count) ;
                  _count + 1 ;
               run ;
               proc format  library = &libref..formats ;
               value &&_v&i
               %do j = 1 %to &count ;
                   &&_n&j = "%nrbquote(&&_k&j)"
               %end ;
               ;
               run ;
           %end ;
           proc datasets library = work memtype = data ;
           delete _domain_ _out_ _format_ _forms_ ;
           quit ;
       %end ;
   %end ;

%mend vformat ;


 /*
  PROGRAM     PFORMAT.
  DESCRIPTION Generates picture formats and adds them to the SAS catalog
              containing user-defined formats.
  USAGE       %pformat(libref, mis) ;
  PARAMETERS  libref - is the name of the library storing the data
                       dictionary data sets, such as object, property,
                       location, etc.
              mis    - is the code identifying the missing value.
  REQUIRES    The object, property, and location data sets must exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */

%macro pformat(libref, mis) ;

/*
 This macro is a slightly modified part of the %FORMATS macro. For comments
 see the %FORMATS macro.
*/

   %let chekfm = 0 ;
   data _forms_ (keep =  format domtab domcol meantab meancol) ;
      set &libref..property ;
      if left(format) = "&mis" then
         delete ;
      call symput("chekfm", 1) ;
   run ;
   %if &chekfm = 1 %then
   %do ;
       %let chekfmt = 0 ;
       %let defined = 0 ;
       proc sort data = _forms_ nodupkey ;
       by format ;
       run ;
       data _null_ ;
          set &libref..object ;
          where upcase(left(table)) = "FORMAT" ;
          call symput("dataset", left(dataset)) ;
          call symput("defined", 1) ;
       run ;
       %if &defined = 1 %then
       %do ;
           data _null_ ;
              set &libref..location ;
              where upcase(left(table)) = "FORMAT" ;
              call symput("libname", left(library)) ;
           run ;
           proc datasets library = &libname memtype = data nolist ;
           contents data = _all_ memtype = data out = work._out_ noprint;
           run ;
           quit ;
           data _null_ ;
              set _out_ ;
              if upcase(left(memname)) = upcase("&dataset") then
              do ;
                 if nobs > 0 then
                    call symput("chekfmt", 1) ;
                 stop ;
              end ;
           run ;
           %if &chekfmt = 1 %then
           %do ;
               proc sort data = &libname..&dataset out = _format_ nodupkey ;
               by format ;
               run ;
               data _forms_ ;
                  merge _forms_ _format_ ;
                  by format ;
               run ;
           %end ;
           %let pcount = 0 ;
           %let vcount = 0 ;
           %let count = 0 ;

           data _null_ ;
              length pcount vcount 8 ;
              retain pcount vcount 1 ;
              call symput("_f"||left(pcount), "&mis") ;
              set _forms_ ;
              if (trim(left(domtab)) = "" or left(domtab) = "&mis") and
                 trim(left(detail)) ^= "" then
              do ;
                 call symput("_f"||left(pcount),trim(left(detail))) ;
                 call symput("_p"||left(pcount),left(substr(format, 1 ,
                                            index(format, ".") - 1))) ;
                 call symput("pcount", pcount) ;
                 pcount + 1 ;
              end ;
           run ;

           %if &pcount > 0 %then
           %do ;
               %do i = 1 %to &pcount ;
                   %if %index(&&_f&i,&mis) = 0 %then
                   %do ;
                      proc format library = &libref..formats ;
                      picture &&_p&i other = "&&_f&i" ;
                      run ;
                   %end ;
               %end ;
           %end ;
       %end ;
   %end ;
   proc datasets library = work memtype = data ;
   delete _domain_ _out_ _format_ _forms_ ;
   quit ;

%mend pformat ;


/*
  PROGRAM     MSG.
  DESCRIPTION Sends error messages for specified process. You may modify this
              macro in order to specify additional errors and their processing
              for your data processing. See the PMessage table from  the Process
              set and the Message table from the Kernel set. If you want to specify
              processing of the errors that occur during the running of your data processing,
              you can define a suitable process and attach it to the Error and ErrorVal
              tables.
  USAGE       %msg(libref, procid, order, callfrom) ;
  PARAMETERS  libref   - is the name of the library storing the data dictionary
                         data sets.
              procid   - is the name of the process for which it is required to
                         send messages.
              order    - is the operation order number for the specified
                         process.
              callfrom - is the name of the process operations, such as
                         inputid, manid, or outputid.
  REQUIRES    The message and pmessage SAS data sets must exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky
 */



 %macro msg(libref, procid, order, callfrom) ;
    %let message = 0 ;
    %let error = I ;
    %let inobs = 0 ;
    %let outobs = 0 ;
    %let outexist = 0 ;

/*
  The following DATA step creates the inobs macro variable containing the number
  of observations of the _intern_ data set created by the %INPUTID macro.
*/

    %if %upcase(&callfrom) = INPUTID %then
    %do ;
        data _null_ ;
           set _intern_ nobs = last ;
           call symput("inobs", last) ;
        run ;
    %end ;


    %if %upcase(&callfrom) = OUTPUTID %then
    %do ;
/*
  The following PROC DATASETS  checks for the existence of the _outable SAS data set
  created by the %OUTPUTID macro.
*/

       proc datasets library = work nolist ;
       contents data = _all_ memtype = data out = _out_
                       (keep = memname nobs) noprint;
       run ;
       quit ;

/*
  The following DATA step creates the outobs macro variable containing the number
  of observations of the _outable data set created by the %OUTPUTID macro.
*/
       data _null_ ;
          set _out_ ;
          if upcase(left(memname)) = "_OUTABLE" then
          do ;
             call symput("outexist", 1) ;
             if nobs > 0 then
               call symput("outobs", 1) ;
             stop ;
          end ;
       run ;
    %end ;

/*
  The following DATA step creates the message macro variable containig the message
  identification number corresponding to the specified process and specified in
  the Pmessage table event.
*/

    data _null_ ;
       set &libref..PMessage
           (where = (upcase(procid) = upcase("&procid")
                     and order = &order)) ;
       if upcase("&callfrom") = "INPUTID" then
       do ;
          if upcase(event) = "IE" and &inobs = 0 then
             call symput("message",  message) ;
       end ;
       if upcase("&callfrom") = "OUTPUTID" then
       do ;
           if  &outexist = 1 and &outobs = 0 then
           do ;
             if upcase(event) = "SE" then
                call symput("message",  message) ;
           end ;
       end ;
    run ;

/*
  The following DATA step creates the error macro variable containing a flag
  of the error. This macro variable will be analyzing in the %PROCESS macro.
*/

    %if &message > 0 %then
    %do ;
        data _null_ ;
           set &libref..Message (where = (message = &message)) ;
           if upcase(mestype) = "E" then
              call symput("error",  "E") ;
        run ;
    %end ;
 %mend msg ;


/*
  PROGRAM     CSCREEN.
  DESCRIPTION Creates columnar data entry screen form for the specified table and
              generates SCL statements for the program supporting this from.
  USAGE       %cscreen (libref, table, file, template, program, mis) ;
  PARAMETERS  libref   - is the name of the library storing the data dictionary
                         data sets, such as library, object, property, location,
                         etc.
              table    - is the name of the table that is required to
                         create the data entry screen form.
              file     - is the name of the external file storing the generated
                         screen form.
              template - is the name of the external file containing the SCL
                         template.
              program  - is the name of the external file storing the generated
                         SCL program.
              mis      - is the code identifying the missing value.
  REQUIRES    The object, property, and location data sets must exist along with
              file containing the SCL template (see FSOURCE.SCL).
  AUTHORS     T.Kolosova and S.Berestizhevsky.
 */

 %macro cscreen (libref, table, file, template, program, mis);

    data _proper_ ;
       set &libref..property ;
       where upcase(left(table)) = upcase("&table")
             and place ^= &mis ;
    run ;

    proc sort data = _proper_ ;
    by place ;
    run ;

    data _null_ ;
       length count 8 ;
       retain count 1 ;
       set _proper_ ;
       call symput("count", count) ;
       call symput("_cl" || left(count), trim(left(column))) ;
       call symput("_c" || left(count), trim(left(title))) ;
       call symput("_a" || left(count), trim(left(attribut))) ;
       call symput("_i" || left(count), trim(left(initval))) ;
       call symput("_fo" || left(count), trim(left(formula))) ;
       call symput("_y" || left(count), type) ;
       call symput("_t" || left(count), "&mis") ;
       call symput("_m" || left(count), "&mis") ;
       call symput("_s" || left(count), "&mis") ;
       call symput("_f" || left(count), "&mis") ;
       call symput("_fl" || left(count), "&mis") ;
       if left(meantab) ^= "&mis" then
       do ;
          call symput("_t" || left(count), left(meantab)) ;
          call symput("_m" || left(count), left(meancol)) ;
          call symput("_s" || left(count), "userformat") ;
          count + 1 ;
          return;
       end ;

       if left(format) = "&mis" then
       do ;
          call symput("_s" || left(count), "noformat") ;
          call symput("_fl" || left(count), left(length)) ;
          count + 1 ;
          return;
       end ;

       call symput("_s" || left(count), "SASformat") ;
       ind = indexc(format, "123456789") ;
       if ind >= 1 then
          call symput("_fl" || left(count),
               substr(format, ind, index(format, ".") - ind)) ;
       else
          call symput("_f" || left(count), left(format)) ;
       count + 1 ;
    run ;

    %let defined = 0 ;
    %let exist = 0 ;
    %do i = 1 %to &count ;
        %if &&_s&i = SASformat and &&_fl&i = &mis %then
        %do ;
            data _null_ ;
               call symput("_b" || left(&i), "***Format not defined***") ;
            run ;
            %if &defined = 0 %then
            %do ;
                data _null_ ;
                   set &libref..Object ;
                   where upcase(left(table)) = "FORMAT" ;
                   call symput("dataset", left(dataset)) ;
                   call symput("defined", 1) ;
                run ;
            %end ;
            %if &defined = 1 and &exist = 0 %then
            %do ;
                data _null_ ;
                    set &libref..Location ;
                    where upcase(left(table)) = "FORMAT" ;
                    call symput("libname", left(library)) ;
                run ;
                proc datasets library = &libname memtype = data nolist ;
                contents data = _all_ memtype = data out = work._out_
                noprint ;
                run ;
                quit ;
                data _null_ ;
                   set _out_ ;
                   if upcase(left(memname)) = upcase("&dataset") then
                   do ;
                      if nobs > 0 then
                         call symput("exist",1) ;
                      stop;
                   end ;
                run ;
            %end ;
/* Picture format consists from zero only */

            %if &exist = 1 %then
            %do ;
                data _null_ ;
                   set &libname..&dataset ;
                   if upcase(trim("&&_f&i")) = upcase(left(format)) then
                   do ;
                      if indexc(detail, "123456789") > 0  then
                      do ;
                         ind = index(detail, ".") ;
                         if ind > 0 then
                            call symput("_fl" || left(&i),
                                 substr(detail, 1, ind - 1)) ;
                         else
                            call symput("_fl" || left(&i), left(detail)) ;
                                      end ;
                      else
                         call symput("_fl" || left(&i), length(detail)) ;
                      call symput("_b" || left(&i), repeat("_",
                                  symget("_fl" || left(&i)) - 1)) ;
                      stop ;
                   end ;
                run ;
            %end ;
        %end ;

        %if &&_s&i = noformat or (&&_s&i = SASformat and
            &&_fl&i ^= &mis) %then
        %do ;
            data _null_ ;
               call symput("_b" || left(&i), repeat("_", &&_fl&i - 1)) ;
            run ;
        %end ;

        %if &&_s&i = userformat %then
        %do ;
            data _null_ ;
               set &libref..Property ;
               where upcase(left(table)) = upcase("&&_t&i") and
                     upcase(left(column)) = upcase("&&_m&i") ;
               call symput("_b" || left(&i), repeat("_", length - 1)) ;
               stop ;
            run ;

        %end ;
    %end ;

    data _msg_ ;
       length _msg_ 8 _verify_ $ 8 ;
       stop ;
    run ;

    data _msg1_ ;
       length _msg_ 8 _verify_ $ 8 ;
       set &libref..VPrimary ;
       if upcase(trim(left(table))) = upcase("&table") and
          upcase(event) = "U" then
       do ;
          _msg_ =  message ;
          _verify_ = "PRIMARY" ;
       end ;
    run ;
    %let vernum = 0 ;
    data _msg2_ ;
       length _msg_ 8 _verify_ $ 8 ;
       retain count 1 ;
       set &libref..VRowcol ;
       if upcase(trim(left(table))) = upcase("&table") and
          upcase(event) = "U" and upcase(vertype) = "RO" then
       do ;
          call symput("col" || left(count), trim(left(column))) ;
          call symput("main" || left(count), trim(left(mainexpr))) ;
          call symput("cond" || left(count), trim(left(conditn))) ;
          call symput("expr" || left(count), trim(left(express))) ;
          _msg_ = message ;
          _verify_ = "ROWCOL" ;
          call symput("vernum", left(count)) ;
       end ;
    run ;
    proc append base = _msg_ data = _msg1_ force ;
    run ;
    proc append base = _msg_ data = _msg2_ force ;
    run ;

    proc sort data = _msg_ ;
    by _msg_ ;
    run ;

    data _msg_ (rename = (_msg_ = message)) ;
       set _msg_ ;
    run ;

    data _msg_ ;
       merge _msg_ (in = left) &libref..Message (in = right) ;
       by message ;
       if left and right ;
    run ;
    %let mscount = 0 ;

    data _null_ ;
       retain count 1 ;
       set _msg_ ;
       call symput("_ms" || left(count), trim(left(mestype))
                   || ": " || trim(text)) ;
       call symput("_vt" || left(count), trim(_verify_)) ;
       call symput("mscount" , left(count)) ;
       count + 1 ;
    run ;

    %let procid = &mis ;
    data _null_ ;
       set &libref..PAttach ;
       where upcase(trim(left(table))) = upcase("&table") ;
       call symput("procid", trim(procid)) ;
    run ;

    data _null_ ;
       set &libref..Object ;
       length _line $ 200 ;
       file "&file" ;
       where upcase(left(table)) = upcase("&table") ;
       call symput("dataset", trim(left(dataset))) ;
       put title / ;
       %do i = 1 %to &count ;
          _line = trim("%nrbquote(&&_c&i)") ;
          put _line @ ;
       %end ;
       put ;
       put "^^^" ;
       put '&l ' @ ;
       %do i = 1 %to &count ;
          if (length("&&_b&i") - length("&&_cl&i") - 1) > 0 then
              _line = substr("&&_b&i", 1,
                             length("&&_b&i") - length("&&_cl&i") - 1) ;
          if (length("&&_b&i") - length("&&_cl&i") - 1) <= 0 then
              _line = "" ;
          _line = ' &' || "&&_cl&i" || _line ;
          put _line @ ;
       %end ;
    run ;

    data _null_ ;
       set &libref..Location ;
       where upcase(left(table)) = upcase("&table") ;
       call symput("library", trim(left(library))) ;
       call symput("templib" , trim(left(templib))) ;
    run ;


   data _null_ ;
      length _line $80 ;
      infile "&template" pad lrecl = 80 ;
      file "&program" ;
      input _line $80. ;
      put _line ;
      if upcase(_line) = "INIT :" then
      do ;
         _line = "_process = '" || "&procid" || "' ;" ;
         put _line ;
      end ;
      if upcase(_line) = "_PROJECT :" then
      do ;
        %do i = 1 %to &count ;
           %if %upcase(&&_y&i) = C %then
           %do ;
                put "if trim(left(&&_cl&i)) = symgetc('_g' || left(&i)) then " ;
           %end ;
           %else
           %do ;
                put "if trim(left(&&_cl&i)) = symgetn('_g' || left(&i)) then " ;
           %end ;
           put "protect &&_cl&i ;" ;
        %end ;
      end ;
      if upcase(_line) = "_INSERT :" then
      do ;
         %do i = 1 %to &count ;
             if "&&_fo&i" ^= "&mis" then
                put "&&_cl&i = &&_fo&i ;" ;
             else
                if "&&_i&i" ^= "&mis" then
                    put "&&_cl&i = &&_i&i ;" ;
                else
                    put "&&_cl&i = _blank_ ;" ;
         %end ;
      end ;
      if upcase(_line) = "_INITIAL :" then
      do ;
         %do i = 1 %to &count ;
             if "&&_fo&i" = "&mis" then
                 put = "&&_cl&i = _blank_ ;" ;
         %end ;
      end ;
      if upcase(_line) = "_FORMULA :" then
      do ;
         %do i = 1 %to &count ;
             if "&&_fo&i" ^= "&mis" then
                 put "&&_cl&i = &&_fo&i ;" ;
             else
                 put "&&_cl&i = &&_cl&i ;" ;
         %end ;
      end ;
      if upcase(_line) = "_PRIMARY :" then
      do ;
          %do i = 1 %to &count ;
              if "&&_a&i" ^= "&mis" then
              do ;
                 %if &mscount > 0 %then
                 %do ;
                     %do j = 1 %to &mscount ;
                        %if %upcase(&&_vt&j) = PRIMARY %then
                            %let message = &&_ms&j ; ;
                        %end ;
                 %end ;
                 %else
                      %let message = * Not Defined in the VPrimary table * ;
                 _line = "if &&_cl&i  = '" || "&mis" ||
                         "' then do ; erroron &&_cl&i ;" ;
                 put _line ;
                 _line = "_msg_ = '" || "&message" || "' ; end ;" ;
                 put _line ;
                 put "else erroroff &&_cl&i ;" ;
              end ;
          %end ;
      end ;
      if upcase(_line) = "_PROCESS :" then
      do ;
          if "&procid" = "&mis" then
          do ;
             _line = "if _process = '" || "&mis" || "' then return ; " ;
             put _line ;
          end ;
      end ;
      if upcase(_line) = "_ROW_COL :" then
      do ;
          %if &vernum > 0 %then
          %do ;
             %let start = 1;
             %do i = 1 %to &vernum ;
                 %if &start <= &mscount %then
                 %do ;
                     %do j = &start %to &mscount ;
                         %if %upcase(&&_vt&j) = ROWCOL %then
                         %do ;
                             %let msg = &&_ms&j ;;
                             %let start = %eval(&start + &j) ;
                             %let j = &mscount ;
                         %end ;
                     %end ;
                 %end ;
                 put "if &&main&i &&cond&i &&expr&i then" ;
                 _line =  "do ; erroron &&col&i; _msg_ = '" ||
                          "&msg" || "' ; end ;" ;
                 put _line ;
                 put "else; erroroff &&col&i ;" ;
             %end ;
          %end ;
      end ;
   run ;

   proc datasets library = work memtype = data ;
   delete _out_ _proper_ _msg_ _msg1_ _msg2_ ;
   quit ;

%mend cscreen ;

/*
  PROGRAM     _PROJEC_
  DESCRIPTION Creates a series of macro variables containing column names of the
              specified table for which editing is enabled.
   USAGE      %_projec_ (libref, objectid, table, mis) ;
  PARAMETERS  libref   - is the name of the library storing the data dictionary
                         data sets, such as library, object, property, location,
                         etc.
              objectid - is the name of the application object containing the
                         specified table.
              table    - is the name of the table that is required to
                         create the data entry screen form.
              mis      - is the code identifying the missing value.
  REQUIRES    The appoject and property and location data sets must exist.
  AUTHORS     T.Kolosova and S.Berestizhevsky.

  NOTE: This macro is used in the SCL template FSOURCE.SCL
*/

 %macro _projec_ (libref, objectid, table, mis) ;

 proc sort data = &libref..AProject (where = (objectid = "&objectid"
                                     and
                                     table  = "&table"))
           out = _projec_ (keep = column) ;
 by column ;
 run ;

 proc sort data = &libref..Property (where = (table = "&table"
                                     and place ^= &mis))
           out = _proper_ (keep = column) ;
 by column ;
 run ;

 data _null_ ;
    retain count 1 ;
    merge _proper_ (in = _left) _projec_ (in = _right) ;
    by column ;
    if _left and not _right ;
    call symput("_c" || left(count), trim(left(column))) ;
    call symput("_count", left(count)) ;
    count + 1  ;
 run ;

 data _null_ ;
    retain _cnt 1 ;
    set _proper_ ;
    %do i = 1 %to &_count ;
      if column = "&&_c&i" then
         call symput("_p" || left(_cnt), trim(left(column))) ;
      else
         call symput("_p" || left(_cnt), " ") ;
      call symput("_n", left(_cnt)) ;
      _cnt + 1 ;
    %end ;
 run ;

 %do i = 1 %to &_n ;
    %global _g&i ;
    %let _g&i = &&_p&i  ;
 %end;

%mend _projec_ ;

/*
   The following DATABASE program enables you to create all SAS data sets
   and formats catalog appearing in the book "Table-driven Strategies for
   Rapid SAS(r) Applications Development".
*/

LIBNAME KERNEL "D:\KERNEL" ;
LIBNAME PATAPPL "D:\KERNEL\APPL" ;
LIBNAME PATDB2 "D:\KERNEL\DB2" ;


DATA KERNEL.LIBRARY ;
LENGTH LIBRARY $8 LOCATION $80  ;
FORMAT LIBRARY $CHAR8. LOCATION $CHAR80.  ;
LABEL
LIBRARY = "SAS LIBRARY NAME"
LOCATION = "FILE NAME FOR SAS LIBRARY"
 ;
INPUT LIBRARY LOCATION & $CHAR80. ;
CARDS ;
 KERNEL     D:\KERNEL
 PATAPPL    D:\KERNEL\APPL
 TEMP       C:\TEMP
 PATDB2     D:\KERNEL\DB2
;
RUN ;

DATA KERNEL.OBJECT ;
LENGTH TABLE $8 TITLE $80 DATASET $8 SCREEN $2 CATALOG $8 ;
FORMAT TABLE $CHAR8. TITLE $CHAR80. DATASET $CHAR8. SCREEN $CHAR2.
       CATALOG $CHAR8.;
LABEL
TABLE = "TABLE NAME"
TITLE = "TITLE"
DATASET = "SAS DATA SET NAME"
SCREEN = "SCREEN TYPE"
CATALOG = "SCREEN PROGRAM CATALOG NAME"
 ;
INPUT TABLE DATASET SCREEN CATALOG TITLE & $CHAR80. ;
  CARDS ;
  AAPPLIST      AAPPLIST      L  SCLPROG  LIST OF APPLICATION PASSWORDS AND INTERFACES
  AAPPMODE      AAPPMODE      L  SCLPROG  LIST OF MODES ASSOCIATED WITH APPLICATIONS
  ACURUSER      ACURUSER      L  SCLPROG  LOG OF USER'S INTERACTION WITH APPLICATION
  AMODEOBJ      AMODEOBJ      L  SCLPROG  LIST OF MODES ASSOCIATED WITH OBJECTS
  AMODEOPR      AMODEOPR      L  SCLPROG  LIST OF MODES ASSOCIATED WITH OPERATIONS
  AOBJECT       AOBJECT       L  SCLPROG  LIST OF APPLICATION OBJECTS
  APROJECT      APROJECT      L  SCLPROG  LIST OF PROJECTION FOR APPLICATION OBJECTS
  AUSERMOD      AUSERMOD      L  SCLPROG  AUTHORIZATION LISTS
  AUSERPAS      AUSERPAS      L  SCLPROG  LIST OF THE USERS
  COMMACC       COMMACC       L  SCLPROG  COMMUNICATION ACCESS METHODS
  COMOPER       COMOPER       L  SCLPROG  LIST OF COMMUNICATION OPERATIONS
  DOSE          DOSE          L  SCLPROG  DOSE ASSIGNMENTS
  ENTRY         ENTRY         L  SCLPROG  APPLICATION TABLE STATUS WHILE DATA ENTRY
  ERROR         ERROR         L  SCLPROG  ERROR LIST
  ERRORVAL      ERRORVAL      L  SCLPROG  ERROR VALUES
  FORMAT        FORMAT        L  SCLPROG  LIST OF FORMATS
  GROUP         GROUP         L  SCLPROG  LIST OF PATIENTS' GROUP
  LIBRARY       LIBRARY       L  SCLPROG  LIST'S OF SAS LIBRARIES
  LINK          LINK          L  SCLPROG  LIST OF TABLES LINKS
  LOCATION      LOCATION      L  SCLPROG  LIST OF TABLES AND CORRESPONDENT LIBRARIES
  MLIST         MLIST         L  SCLPROG  LIST OF USER INTERFACES
  MMENU         MMENU         L  SCLPROG  MENU ITEMS AND THEIR PROPERTIES DEFINITIONS
  MPROG         MPROG         L  SCLPROG  USER-DEFINED COMMANDS DEFINITIONS
  MEDICINE      MEDICINE      L  SCLPROG  LIST OF MEDICINES
  MESSAGE       MESSAGE       L  SCLPROG  LIST OF MESSAGES
  MONITOR       MONITOR       L  SCLPROG  MONITORING DEFINITIONS
  OBJECT        OBJECT        L  SCLPROG  LIST OF TABLES
  PATTACH       PATTACH       L  SCLPROG  LIST OF ATTACHMENTS
  PBINARY       PBINARY       L  SCLPROG  BINARY OPERATORS  DEFINITIONS
  PINIT         PINIT         L  SCLPROG  LIST OF INITIAL TABLES
  PINPUT        PINPUT        L  SCLPROG  LIST OF INPUT TABLES
  PLINK         PLINK         L  SCLPROG  LIST OF LINKED TABLES FOR BINARY OPERATOR
  PMACRO        PMACRO        L  SCLPROG  USER-WRITTEN MACRO DEFINITIONS
  PMAN          PMAN          L  SCLPROG  LIST OF MANIPULATIONS
  PMESSAGE      PMESSAGE      L  SCLPROG  LIST OF PROCESS MESSAGES
  POPER         POPER         L  SCLPROG  LIST OF OPERATIONS
  POUTPUT       POUTPUT       L  SCLPROG  LIST OF OUTPUT TABLES
  POUTRULE      POUTRULE      L  SCLPROG  UPDATED RULES DEFINITIONS
  PPROCESS      PPROCESS      L  SCLPROG  LIST OF PROCESSES
  PPROJECT      PPROJECT      L  SCLPROG  PROJECTION DEFINITIONS
  PSELECT       PSELECT       L  SCLPROG  SELECTION DEFINITIONS
  PUPDATE       PUPDATE       L  SCLPROG  UPDATES DEFINITIONS
  PATIENT       PATIENT       L  SCLPROG  LIST OF PATIENTS
  PROPERTY      PROPERTY      L  SCLPROG  LIST OF TABLES PROPERTIES
  RINFO         RINFO         L  SCLPROG  RELATIONS AMONG COMMON USE PARAMETERS AND REPORTS
  RMAIN         RMAIN         L  SCLPROG  LIST OF REPORTS
  RPARAMS       RPARAMS       L  SCLPROG  LIST OF COMMON USE PARAMETERS
  RSTAT         RSTAT         L  SCLPROG  LIST OF STATISTICS CALCULATED ACCORDING TO CLASSIFICATION
  RTOTAL        RTOTAL        L  SCLPROG  LIST OF STATISTICS CALCULATED OVER ALL DATA
  RVARS         RVARS         L  SCLPROG  LIST OF REPORTS' VARIABLES AND THEIR PROPERTIES
  RESULT        RESULT        L  SCLPROG  LIST OF RESULTS
  TRIAL         TRIAL         L  SCLPROG  TRIAL DEFINITIONS
  VCROSS        VCROSS        L  SCLPROG  CROSS INTEGRITY RULE
  VDOMAIN       VDOMAIN       L  SCLPROG  DOMAIN INTEGRITY RULE
  VFOREIGN      VFOREIGN      L  SCLPROG  REFERENTIAL INTEGRITY RULE
  VPRIMARY      VPRIMARY      L  SCLPROG  TABLE INTEGRITY RULE
  VROWCOL       VROWCOL       L  SCLPROG  ROW INTEGRITY RULE
  ;
RUN ;

DATA KERNEL.COMMACC ;
LENGTH COMMUNID 8 COMMUNIC $8 LOCALOS $20 REMOTEOS $20 PROTOCOL $80 COMPORT $8  ;
FORMAT COMMUNID 8. COMMUNIC $CHAR8. LOCALOS $CHAR20. REMOTEOS $CHAR20.
       PROTOCOL $CHAR80. COMPORT $CHAR8.  ;
LABEL
COMMUNID = "COMMUNICATION ACCESS ID"
COMMUNIC = "COMMUNICATION ACCESS"
LOCALOS = "LOCAL OPERATING SYSTEM NAME"
REMOTEOS = "REMOTE OPERATING SYSTEM NAME"
PROTOCOL = "COMMUNICATION SCRIPT TYPE"
COMPORT = "VALUE OF REMOTE SESSION"
 ;
INPUT COMMUNID COMMUNIC LOCALOS REMOTEOS PROTOCOL & $CHAR80. ;
CARDS ;
 1  EHLAAPI WIN WIN  C:\PROTOCOL\LINK.DAT
;
RUN ;

DATA KERNEL.COMOPER ;
LENGTH LIBRARY $8 TARLIB $8 COMMTYPE $1 COMMUNID 8  ;
FORMAT LIBRARY $CHAR8. TARLIB $CHAR8. COMMTYPE $CHAR1. COMMUNID 8. ;
INFORMAT COMMTYPE $CHAR1. ;
LABEL
LIBRARY = "SOURCE SAS LIBRARY NAME"
TARLIB = "TARGET SAS LIBRARY NAME"
COMMTYPE = "COMMUNICATION OPERATION TYPE"
COMMUNID = "COMMUNICATION ACCESS ID"
 ;
INPUT LIBRARY TARLIB COMMTYPE COMMUNID ;
CARDS ;
SERVER      WORK      T     1
WORK        PDBLIB    T     1
SERVER      TEMP      .     1
APPL        WORK      T     1
DB2         WORK      T     1
;
RUN ;


DATA KERNEL.PROPERTY ;
LENGTH TABLE $8 COLUMN $8 TITLE $80 TYPE $1 LENGTH 8 FORMAT $20 ATTRIBUT $2 DOMTAB $8
       DOMCOL $8 MEANTAB $8 MEANCOL $8 PLACE 8 INITVAL $80 FORMULA $80 UPDTYPE $1
       MISSING $1 MESSAGE 8  ;
FORMAT TABLE $CHAR8. COLUMN $CHAR8. TITLE $CHAR80. TYPE $CHAR1. LENGTH 8.
       FORMAT $CHAR20. ATTRIBUT $CHAR2. DOMTAB $CHAR8. DOMCOL $CHAR8. MEANTAB $CHAR8.
       MEANCOL $CHAR8. PLACE 8. INITVAL $CHAR80. FORMULA $CHAR80.
       UPDTYPE $CHAR1. MISSING $CHAR1. MESSAGE 8. ;
INFORMAT TITLE $CHAR80. FORMAT $CHAR20. ATTRIBUT $CHAR2. DOMTAB $CHAR8. DOMCOL $CHAR8.
         MEANTAB $CHAR8. MEANCOL $CHAR8. INITVAL $CHAR80. FORMULA $CHAR80.
         UPDTYPE $CHAR1. MISSING $CHAR1. ;
LABEL
TABLE = "TABLE NAME"
COLUMN = "COLUMN NAME"
TITLE = "COLUMN TITLE"
TYPE = "COLUMN TYPE"
LENGTH = "COLUMN LENGTH"
FORMAT = "FORMAT"
ATTRIBUT = "COLUMN PROPERTY"
DOMTAB = "DOMAIN TABLE NAME"
DOMCOL = "DOMAIN COLUMN NAME"
MEANTAB = "MEANING TABLE NAME"
MEANCOL = "MEANING TABLE NAME"
PLACE = "PLACE ON THE SCREEN FORM"
INITVAL = "INITIAL COLUMN VALUE"
FORMULA = "FORMULA FOR COMPUTED COLUMN"
UPDTYPE = "TYPE OF COLUMN UPDATE"
MISSING = "CODE OF MISSING VALUE"
MESSAGE = "MESSAGE ID"
 ;

INPUT TABLE COLUMN TYPE LENGTH ATTRIBUT FORMAT DOMTAB DOMCOL MEANTAB MEANCOL PLACE INITVAL FORMULA UPDTYPE MISSING MESSAGE TITLE & $CHAR80. ;
CARDS ;
AAPPLIST    APPID        C       8      P      .            .          .          .          .           1   .  .  R  .  .   APPLICATION IDENTIFICATION NAME
AAPPLIST    TITLE        C      80      .      .            .          .          .          .           2   .  .  R  .  .   APPLICATION TITLE
AAPPLIST    PASSWORD     C       8      .      .            .          .          .          .           3   .  .  R  .  .   APPLICATION PASSWORD
AAPPLIST    UINAME       C       8      .      .            MLIST      UINAME     .          .           4   .  .  R  .  .   USER INTERFACE IDENTIFICATION NAME
AAPPMODE    APPID        C       8      P      $APPLIC.     AAPPLIST   APPID      AAPPLIST   TITLE       1   .  .  R  .  .   APPLICATION IDENTIFICATION NAME
AAPPMODE    MODEID       C       8      P      .            .          .          .          .           2   .  .  R  .  .   MODE IDENTIFICATION NAME
ACURUSER    USERID       C       8      P      .            AUSERPAS   USERID     .          .           1   .  .  R  .  .   USER IDENTIFICATION NAME
ACURUSER    USERINFO     C      80      .      .            .          .          .          .           2   .  .  R  .  .   INFORMATION ABOUT USER
ACURUSER    LOGIN        N       8      .      .            .          .          .          .           3   .  .  R  .  .   DATE AND TIME OF THE SESSION START
ACURUSER    LOGOUT       N       8      .      .            .          .          .          .           4   .  .  R  .  .   DATE AND TIME OF THE SESSION END
ACURUSER    PASSWORD     C       8      .      .            AAPPLIST   PASSWORD   .          .           5   .  .  R  .  .   APPLICATION PASSWORD
AMODEOBJ    MODEID       C       8      P      .            .          .          .          .           1   .  .  R  .  .   MODE IDENTIFICATION NAME
AMODEOBJ    OBJECTID     C       8      P      .            AOBJECT    OBJECTID   .          .           2   .  .  R  .  .   APPLICATION OBJECT IDENTIFICATION NAME
AMODEOBJ    OPERTYPE     C       1      .      .            .          .          .          .           3   .  .  R  .  .   TYPE OF OPERATION (E OR B)
AMODEOBJ    PROCID       C       8      .      $PROCESS.    PPROCESS   PROCID     PPROCESS   TITLE       4   .  .  R  .  .   PROCESS IDENTIFICATION NAME
AMODEOPR    MODEID       C       8      P      .            .          .          .          .           1   .  .  R  .  .   MODE IDENTIFICATION NAME
AMODEOPR    PROCID       C       8      .      $PROCESS.    PPROCESS   PROCID     PPROCESS   TITLE       2   .  .  R  .  .   PROCESS IDENTIFICATION NAME
AOBJECT     OBJECTID     C       8      P      .            .          .          .          .           1   .  .  R  .  .   APPLICATION OBJECT IDENTIFICATION NAME
AOBJECT     TABLE        C       8      P      $TABLE.      OBJECT     TABLE      OBJECT     TITLE       2   .  .  R  .  .   TABLE NAME
AOBJECT     PROPERTY     C       1      .      .            .          .          .          .           3   .  .  R  .  .   APPLICATION OBJECT PROPERTY (T OR P)
APROJECT    OBJECTID     C       8      P      .            AOBJECT    OBJECTID   .          .           1   .  .  R  .  .   APPLICATION OBJECT IDENTIFICATION NAME
APROJECT    TABLE        C       8      P      $TABLE.      OBJECT     TABLE      OBJECT     TITLE       2   .  .  R  .  .   TABLE NAME
APROJECT    COLUMN       C       8      P      $COLUMN.     PROPERTY   COLUMN     PROPERTY   TITLE       3   .  .  R  .  .   TABLE NAME
AUSERMOD    USERGRP      C      10      P      .            .          .          .          .           1   .  .  R  .  .   USER GROUP IDENTIFICATION NAME
AUSERMOD    MODEID       C       8      P      .            .          .          .          .           2   .  .  R  .  .   MODE IDENTIFICATION NAME
AUSERPAS    USERGRP      C      10      P      .            AUSERMOD   USERGRP    .          .           1   .  .  R  .  .   USER GROUP IDENTIFICATION NAME
AUSERPAS    USERID       C       8      P      .            .          .          .          .           2   .  .  R  .  .   USER IDENTIFICATION NAME
AUSERPAS    USERINFO     C      80      .      .            .          .          .          .           3   .  .  R  .  .   INFORMATION ABOUT USER
AUSERPAS    USERPASW     C       8      .      .            .          .          .          .           4   .  .  R  .  .   USER'S PASSWORD
COMMACC     COMMUNID     N       8      P      .            .          .          .          .           1   .  .  R  .  .   COMMUNICATION ACCESS ID
COMMACC     COMMUNIC     C       8      .      .            .          .          .          .           2   .  .  R  .  .   COMMUNICATION ACCESS
COMMACC     LOCALOS      C      20      .      .            .          .          .          .           3   .  .  R  .  .   LOCAL OPERATING SYSTEM NAME
COMMACC     REMOTEOS     C      20      .      .            .          .          .          .           4   .  .  R  .  .   REMOTE OPERATING SYSTEM NAME
COMMACC     PROTOCOL     C      80      .      .            .          .          .          .           5   .  .  R  .  .   COMMUNICATION SCRIPT TYPE
COMMACC     COMPORT      C       8      .      .            .          .          .          .           6   .  .  R  .  .   VALUE OF REMOTE SESSION
COMOPER     LIBRARY      C       8      .      .            LIBRARY    LIBRARY    .          .           1   .  .  R  .  .   SOURCE SAS LIBRARY NAME
COMOPER     TARLIB       C       8      .      .            LIBRARY    LIBRARY    .          .           2   .  .  R  .  .   TARGET SAS LIBRARY NAME
COMOPER     COMMTYPE     C       1      .      .            .          .          .          .           3   .  .  R  .  .   COMMUNICATION OPERATION TYPE
COMOPER     COMMUNID     N       8      .      .            COMMACC    COMMUNID   .          .           4   .  .  R  .  .   COMMUNICATION ACCESS ID
DOSE        MEDICINE     C       8      P      $MEDNAME.    MEDICINE   MEDICINE   MEDICINE   MEDNAME     1   .  .  R  .  .   MEDICINE ID
DOSE        GROUP        N       8      P      .            GROUP      GROUP      .          .           2   .  .  R  .  .   GROUP ID
DOSE        H_DOSE       N       8      .      6.3          .          .          .          .           3   .  .  R  .  .   HIGHEST DAILY DOSE
DOSE        L_DOSE       N       8      .      6.3          .          .          .          .           4   .  .  R  .  .   LOWEST DAILY DOSE
ENTRY       TABLE        C       8      P      $TABLE.      OBJECT     TABLE      OBJECT     TITLE       1   .  .  R  .  .   TABLE NAME
ENTRY       LIBRARY      C       8      P      .            .          .          .          .           2   .  .  R  .  .   SAS LIBRARY NAME
ENTRY       TEMPLIB      C       8      .      .            .          .          .          .           3   .  .  R  .  .   SAS LIBRARY NAME FOR TEMPORARY LOCATION
ENTRY       TITLE        C      80      .      .            .          .          .          .           4   .  .  R  .  .   TITLE
ENTRY       SCREEN       C       2      .      .            .          .          .          .           5   .  .  R  .  .   SCREEN TYPE
ENTRY       DATASET      C       8      .      .            .          OBJECT     DATASET    .           6   .  .  R  .  .   SAS DATA SET NAME
ENTRY       CATALOG      C       8      .      .            .          OBJECT     CATALOG    .           7   .  .  R  .  .   SCREEN PROGRAM CATALOG NAME
ENTRY       APPID        C       8      .      .            .          .          .          .           8   .  .  R  .  .   APPLICATION IDENTIFICATION NAME
ENTRY       PASSWORD     C       8      .      .            .          .          .          .           9   .  .  R  .  .   APPLICATION PASSWORD
ENTRY       UINAME       C       8      .      .            .          .          .          .          10   .  .  R  .  .   USER INTERFACE IDENTIFICATION NAME
ENTRY       MODEID       C       8      .      .            .          .          .          .          11   .  .  R  .  .   MODE IDENTIFICATION NAME
ENTRY       USERGRP      C      10      .      .            .          .          .          .          12   .  .  R  .  .   USER GROUP IDENTIFICATION NAME
ENTRY       OBJECTID     C       8      .      .            .          .          .          .          13   .  .  R  .  .   APPLICATION OBJECT IDENTIFICATION NAME
ENTRY       OPERTYPE     C       1      .      .            .          .          .          .          14   .  .  R  .  .   TYPE OF OPERATIONS (E - EDIT, B-BROWSE)
ENTRY       PROCID       C       8      .      .            .          .          .          .          15   .  .  R  .  .   PROCESS IDENTIFICATION NAME
ENTRY       PROPERTY     C       1      .      .            .          .          .          .          16   .  .  R  .  .   APPLICATION OBJECT PROPERTY (T-WHOLE TABLE, P-PROJECTION)
ENTRY       _STATUS_     C       1      .      .            .          .          .          .          17   .  .  R  .  .   APPLICATION TABLE STATUS
ERROR       DATETIME     N       8      P      DATETIME.    .          .          .          .           1   .  .  R  .  .   DATE AND TIME WHEN THE VERIFICATION PROCESS WAS DONE
ERROR       VERTYPE      C       2      P      .            .          .          .          .           2   .  .  R  .  .   VERIFICATION RULE TYPE
ERROR       TABLE        C       8      P      $TABLE.      OBJECT     TABLE      OBJECT     TITLE       3   .  .  R  .  .   NAME OF THE TABLE THAT WAS VERIFIED
ERROR       VERNUM       N       8      P      .            .          .          .          .           4   .  .  R  .  .   VERIFICATION NUMBER
ERROR       VPROCID      N       8      .      .            .          .          .          .           5   .  .  R  .  .   NUMBER OF VERIFICATION PROCESS
ERRORVAL    VPROCID      C       8      P      .            .          .          .          .           1   .  .  R  .  .   NUMBER OF VERIFICATION PROCESS
ERRORVAL    ERRORNUM     N       8      P      .            .          .          .          .           2   .  .  R  .  .   ERROR NUMBER
ERRORVAL    COLUMN       C       8      P      $COLUMN.     PROPERTY   COLUMN     PROPERTY   TITLE       3   .  .  R  .  .   NAME OF THE COLUMN FORMING  THE PRIMARY KEY
ERRORVAL    VALUE        C      80      .      .            .          .          .          .           4   .  .  R  .  .   VALUE OF THE COLUMN FORMING  THE PRIMARY KEY
FORMAT      FORMAT       C      20      P      .            .          .          .          .           1   .  .  R  .  .   FORMAT
FORMAT      DETAIL       C      80      .      .            .          .          .          .           2   .  .  R  .  .   DETAIL
GROUP       GROUP        N       8      P      .            .          .          .          .           1   .  .  R  .  .   GROUP ID
GROUP       ORDERNO      N       8      P      .            .          .          .          .           2   .  .  R  .  .   PATIENT ORDER NUMBER
GROUP       PATIENT      N       8      .      PATIENT.     PATIENT    PATIENT    PATIENT    SURNAME     3   .  .  R  .  .   PATIENT ID
LIBRARY     LIBRARY      C       8      P      .            .          .          .          .           1   .  .  R  .  .   SAS LIBRARY NAME
LIBRARY     LOCATION     C      80      .      .            .          .          .          .           2   .  .  R  .  .   FILE NAME FOR SAS LIBRARY
LINK        TABLE        C       8      P      $TABLE.      OBJECT     TABLE      OBJECT     TITLE       1   .  .  R  .  .   TABLE NAME
LINK        RELTABLE     C       8      P      $TABLE.      OBJECT     TABLE      OBJECT     TITLE       2   .  .  R  .  .   RELATED TABLE NAME
LINK        COLUMN       C       8      P      $COLUMN.     PROPERTY   COLUMN     PROPERTY   TITLE       3   .  .  R  .  .   COLUMN NAME
LINK        RELCOL       C       8      P      $COLUMN.     PROPERTY   COLUMN     PROPERTY   TITLE       4   .  .  R  .  .   RELATED COLUMN NAME
LOCATION    TABLE        C       8      P      .            OBJECT     TABLE      .          .           1   .  .  R  .  .   TABLE NAME
LOCATION    LIBRARY      C       8      .      .            LIBRARY    LIBRARY    .          .           2   .  .  R  .  .   SAS LIBRARY NAME
LOCATION    TEMPLIB      C       8      .      .            LIBRARY    LIBRARY    .          .           3   .  .  R  .  .   SAS LIBRARY NAME FOR TEMPORARY LOCATION
MLIST       UINAME       C       8      P      .            MMENU      MENUNAME   .          .           1   .  .  R  .  .   USER INTERFACE IDENTIFICATION NAME
MLIST       UIDESC       C      80      .      .            .          .          .          .           2   .  .  R  .  .   USER INTERFACE DESCRIPTION
MLIST       LIBRARY      C       8      .      .            LIBRARY    LIBRARY    .          .           3   .  .  R  .  .   SAS LIBRARY NAME
MLIST       CATALOG      C       8      .      .            .          .          .          .           4   .  .  R  .  .   SAS CATALOG NAME
MMENU       MENUNAME     C       8      P      .            .          .          .          .           1   .  .  R  .  .   MENU IDENTIFICATION NAME
MMENU       MENUITEM     N       8      P      .            .          .          .          .           2   .  .  R  .  .   ORDER NUMBER OF THE ITEM IN THE MENU
MMENU       ITEMNAME     C      20      .      .            .          .          .          .           3   .  .  R  .  .   NAME OF THE ITEM ON THE MENU
MMENU       ACTNAME      C       8      .      .            .          .          .          .           4   .  .  R  .  .   ACTION NAME
MMENU       ACTYPE       C       1      .      .            .          .          .          .           5   .  .  R  .  .   ACTION TYPE
MMENU       ITEMGRAY     C       1      .      .            .          .          .          .           6   .  .  R  .  .   ITEM IS INITIALY ENABLED OR NOT FOR SELECTION
MMENU       ITEMNEM      C       1      .      .            .          .          .          .           7   .  .  R  .  .   MNEMONIC  CHARACTER FOR ITEM SELECTION
MPROG       ACTNAME      C       8      P      .            .          .          .          .           1   .  .  R  .  .   ACTION NAME
MPROG       LIBRARY      C       8      .      .            LIBRARY    LIBRARY    .          .           2   .  .  R  .  .   SAS LIBRARY NAME
MPROG       CATALOG      C       8      .      .            .          .          .          .           3   .  .  R  .  .   SAS CATALOG NAME
MPROG       ENTRYNAM     C       8      .      .            .          .          .          .           4   .  .  R  .  .   NAME OF THE CATALOG ENTRY
MPROG       ENTRYTYP     C       8      .      .            .          .          .          .           5   .  .  R  .  .   TYPE OF THE CATALOG ENTRY
MEDICINE    MEDICINE     N       8      P      .            .          .          .          .           1   .  .  R  .  .   MEDICINE ID
MEDICINE    MEDNAME      C      80      .      .            .          .          .          .           2   .  .  R  .  .   MEDICINE NAME
MESSAGE     MESSAGE      N       8      P      .            .          .          .          .           1   .  .  R  .  .   MESSAGE ID
MESSAGE     TEXT         C      80      .      .            .          .          .          .           2   .  .  R  .  .   MESSAGE TEXT
MESSAGE     MESTYPE      C       1      .      .            .          .          .          .           3   .  .  R  .  .   MESSAGE TYPE
MESSAGE     OUTPUT       C       2      .      .            .          .          .          .           4   .  .  R  .  .   OUTPUT MESSAGE DESTINATION
MONITOR     GROUP        N       8      P      .            GROUP      GROUP      .          .           1   .  .  R  .  .   GROUP ID
MONITOR     TRIAL        N       8      P      .            TRIAL      TRIAL      .          .           2   .  .  R  .  .   TRIAL ID
MONITOR     REPEAT       N       8      .      .            .          .          .          .           3   .  .  R  .  .   TIME INTERVAL IN DAYS
OBJECT      TABLE        C       8      P      .            .          .          .          .           1   .  .  R  .  .   TABLE NAME
OBJECT      TITLE        C      80      .      .            .          .          .          .           2   .  .  R  .  .   TITLE
OBJECT      DATASET      C       8      .      .            .          .          .          .           3   .  .  R  .  .   SAS DATA SET NAME
OBJECT      SCREEN       C       2      .      .            .          .          .          .           4   .  .  R  .  .   SCREEN TYPE
OBJECT      CATALOG      C       8      .      .            .          .          .          .           5   .  .  R  .  .   SCREEN PROGRAM CATALOG NAME
PATTACH     TABLE        C       8      P      $TABLE.      OBJECT     TABLE      OBJECT     TITLE       1   .  .  R  .  .   TABLE NAME TO WHICH THE PROCESS IS ATTACHED
PATTACH     LIBRARY      C       8      P      .            LIBRARY    LIBRARY    .          .           2   .  .  R  .  .   SAS LIBRARY NAME
PATTACH     EVENT        C       1      P      .            .          .          .          .           3   .  .  R  .  .   EVENT THAT INVOKES PROCESS (S OR U)
PATTACH     EVENTYPE     C       1      P      .            .          .          .          .           4   .  .  R  .  .   EVENT'S TYPE (B OR A)
PATTACH     PROCID       C       8      .      $PROCESS.    PPROCESS   PROCID     PPROCESS   TITLE       5   .  .  R  .  .   PROCESS IDENTIFICATION NAME
PBINARY     INPUTID      C       8      P      .            POPER      INPUTID    .          .           1   .  .  R  .  .   INPUT IDENTIFICATION NAME
PBINARY     OPERORD      N       8      P      .            .          .          .          .           2   .  .  R  .  .   OPERATOR ORDER NUMBER
PBINARY     RELTABLE     C       8      .      $TABLE.      OBJECT     TABLE      OBJECT     TITLE       3   .  .  R  .  .   NAME OF THE RELATED TABLE
PBINARY     RELLIB       C       8      .      .            LIBRARY    LIBRARY    .          .           4   .  .  R  .  .   SAS LIBRARY NAME
PINIT       INPUTID      C       8      P      .            POPER      INPUTID    .          .           1   .  .  R  .  .   INPUT IDENTIFICATION NAME
PINIT       INITAB       C       8      .      $TABLE.      OBJECT     TABLE      OBJECT     TITLE       2   .  .  R  .  .   TABLE NAME
PINIT       INITLIB      C       8      .      .            LIBRARY    LIBRARY    .          .           3   .  .  R  .  .   SAS LIBRARY NAME
PINPUT      INPUTID      C       8      P      .            POPER      INPUTID    .          .           1   .  .  R  .  .   INPUT IDENTIFICATION NAME
PINPUT      OPERORD      N       8      P      .            .          .          .          .           2   .  .  R  .  .   RELATIONAL OPERATOR ORDER NUMBER
PINPUT      OPERATOR     C       1      .      .            .          .          .          .           3   .  .  R  .  .   RELATIONAL OPERATOR (S,P,R,U,D,J,V)
PLINK       INPUTID      C       8      P      .            PINPUT     INPUTID    .          .           1   .  .  R  .  .   INPUT IDENTIFICATION NAME
PLINK       OPERORD      N       8      P      .            PINPUT     OPERORD    .          .           2   .  .  R  .  .   OPERATION ORDER NUMBER
PLINK       COLUMN       C       8      P      $COLUMN.     PROPERTY   COLUMN     PROPERTY   TITLE       3   .  .  R  .  .   NAME OF THE COLUMN OF THE LEFT-HAND TABLE
PLINK       RELCOL       C       8      .      $COLUMN.     PROPERTY   COLUMN     PROPERTY   TITLE       4   .  .  R  .  .   NAME OF THE COLUMN OF THE RIGHT-HAND TABLE
PMAN        MANID        C       8      P      .            POPER      MANID      .          .           1   .  .  R  .  .   MANIPULATION IDENTIFICATION NAME
PMAN        MANORD       N       8      P      .            .          .          .          .           2   .  .  R  .  .   MANIPULATION ORDER NUMBER
PMAN        EXPRESSN     C      80      .      .            .          .          .          .           3   .  .  R  .  .   MANIPULATION EXPRESSION
PMESSAGE    PROCID       C       8      P      $PROCESS.    PPROCESS   PROCID     PPROCESS   TITLE       1   .  .  R  .  .   PROCESS IDENTIFICATION NAME
PMESSAGE    ORDER        N       8      P      .            .          .          .          .           2   .  .  R  .  .   OPERATION ORDER NUMBER
PMESSAGE    EVENT        C       2      P      .            .          .          .          .           3   .  .  R  .  .   OPERATIONS EVENT
PMESSAGE    MESSAGE      N       8      .      .            MESSAGE    MESSAGE    .          .           4   .  .  R  .  .   MESSAGE IDENTIFICATION NUMBER
POPER       PROCID       C       8      P      $PROCESS.    PPROCESS   PROCID     PPROCESS   TITLE       1   .  .  R  .  .   PROCESS IDENTIFICATION NAME
POPER       ORDER        N       8      P      .            .          .          .          .           2   .  .  R  .  .   OPERATION ORDER NUMBER
POPER       OPERNAME     C      80      .      .            .          .          .          .           3   .  .  R  .  .   OPERATION TITLE
POPER       INPUTID      C       8      .      .            .          .          .          .           4   .  .  R  .  .   INPUT IDENTIFICATION NAME
POPER       MANID        C       8      .      .            .          .          .          .           5   .  .  R  .  .   MANIPULATION IDENTIFICATION NAME
POPER       OUTPUTID     C       8      .      .            .          .          .          .           6   .  .  R  .  .   OUTPUT IDENTIFICATION NAME
POUTPUT     OUTPUTID     C       8      P      .            POPER      OUTPUTID   .          .           1   .  .  R  .  .   OUTPUT IDENTIFICATION NAME
POUTPUT     OUTABLE      C       8      .      .            .          .          .          .           2   .  .  R  .  .   OUTPUT OPERATION TABLE NAME
POUTPUT     OUTLIB       C       8      .      .            LIBRARY    LIBRARY    .          .           3   .  .  R  .  .   SAS LIBRARY NAME
POUTPUT     OUTYPE       C       1      .      .            .          .          .          .           4   .  .  R  .  .   OUTPUT TABLE TYPE
POUTPUT     RULEID       C       8      .      .            PUPDATE    RULEID     .          .           5   .  .  R  .  .   UPDATING RULE IDENTIFICATION NAME
POUTRULE    OUTPUTID     C       8      P      .            POPER      OUTPUTID   .          .           1   .  .  R  .  .   OUTPUT IDENTIFICATION NAME
POUTRULE    EXPRESSN     C      80      .      .            .          .          .          .           2   .  .  R  .  .   EXPRESSION FOR ROWS SELECTION FROM EXISTING TABLE
POUTRULE    UPDTYPE      C       1      .      .            .          .          .          .           3   .  .  R  .  .   TYPE OF UPDATE FOR EXISTING TABLE
PPROCESS    PROCID       C       8      P      .            .          .          .          .           1   .  .  R  .  .   PROCESS IDENTIFICATION NAME
PPROCESS    TITLE        C      80      .      .            .          .          .          .           2   .  .  R  .  .   TITLE OF THE PROCESS
PPROCESS    PROCTYPE     C       1      .      .            .          .          .          .           3   .  .  R  .  .   TYPE OF THE PROCESS (D OR I)
PPROJECT    INPUTID      C       8      P      .            POPER      INPUTID    .          .           1   .  .  R  .  .   INPUT IDENTIFICATION NAME
PPROJECT    OPERORD      N       8      P      .            .          .          .          .           2   .  .  R  .  .   OPERATOR ORDER NUMBER
PPROJECT    COLUMN       C       8      P      .            PROPERTY   COLUMN     .          .           3   .  .  R  .  .   COLUMN NAME
PSELECT     INPUTID      C       8      P      .            POPER      INPUTID    .          .           1   .  .  R  .  .   INPUT IDENTIFICATION NAME
PSELECT     OPERORD      N       8      P      .            .          .          .          .           2   .  .  R  .  .   OPERATOR ORDER NUMBER
PSELECT     EXPRESSN     C      80      .      .            .          .          .          .           3   .  .  R  .  .   EXPRESSION FOR SELECTION OPERATOR
PUPDATE     RULEID       C       8      P      .            .          .          .          .           1   .  .  R  .  .   UPDATING RULE IDENTIFICATION NAME
PUPDATE     COLUMN       C       8      P      .            PROPERTY   COLUMN     .          .           2   .  .  R  .  .   COLUMN NAME
PUPDATE     EXPRESSN     C      80      .      .            .          .          .          .           3   .  .  R  .  .   EXPRESSION
PATIENT     PATIENT      N       8      PI     NUMBER.      .          .          .          .           1   .  .  R  .  .   PATIENT IDENTIFICATION NUMBER
PATIENT     NAME         C      20      .      .            .          .          .          .           2   .  .  R  .  .   FIRST NAME
PATIENT     SURNAME      C      20      .      .            .          .          .          .           3   .  .  R  .  .   LAST NAME
PATIENT     SEX          C       1      .      .            .          .          .          .           4   .  .  R  .  .   SEX
PATIENT     BIRTH        C      10      .      .            .          .          .          .           5   .  .  R  .  .   BIRTH DATE
PATIENT     ADDRESS      C      80      .      .            .          .          .          .           6   .  .  R  .  .   ADDRESS
PATIENT     PHONEHOM     N       8      .      PHONE.       .          .          .          .           7   .  .  R  .  .   PHONE AT HOME
PATIENT     PHONEWRK     N       8      .      PHONE.       .          .          .          .           8   .  .  R  .  .   PHONE AT WORK
PMACRO      MACRO        C       9      P      .            .          .          .          .           1   .  .  R  .  .   MACRO NAME
PMACRO      PROPERTY     C       1      .      .            .          .          .          .           2   .  .  R  .  .   MACRO'S PROPERTIES
PMACRO      PREMACRO     C       9      .      .            .          .          .          .           3   .  .  R  .  .   PREMACRO NAME
PMACRO      PSTMACRO     C       9      .      .            .          .          .          .           4   .  .  R  .  .   POSTMACRO NAME
PROPERTY    TABLE        C       8      PI     .            OBJECT     TABLE      .          .           1   .  .  R  .  .   TABLE NAME
PROPERTY    COLUMN       C       8      P      .            .          .          .          .           2   .  .  R  .  .   COLUMN NAME
PROPERTY    TITLE        C      80      .      .            .          .          .          .           3   .  .  R  .  .   COLUMN TITLE
PROPERTY    TYPE         C       1      .      .            .          .          .          .           4   .  .  R  .  .   COLUMN TYPE
PROPERTY    LENGTH       N       8      .      .            .          .          .          .           5   .  .  R  .  .   COLUMN LENGTH
PROPERTY    FORMAT       C      20      .      .            .          .          .          .           6   .  .  R  .  .   FORMAT
PROPERTY    ATTRIBUT     C       2      .      .            .          .          .          .           7   .  .  R  .  .   COLUMN PROPERTY
PROPERTY    DOMTAB       C       8      .      .            OBJECT     TABLE      .          .           8   .  .  R  .  .   DOMAIN TABLE NAME
PROPERTY    DOMCOL       C       8      .      .            .          .          .          .           9   .  .  R  .  .   DOMAIN COLUMN NAME
PROPERTY    MEANTAB      C       8      .      .            OBJECT     TABLE      .          .          10   .  .  R  .  .   MEANING TABLE NAME
PROPERTY    MEANCOL      C       8      .      .            .          .          .          .          11   .  .  R  .  .   MEANING TABLE NAME
PROPERTY    PLACE        N       8      .      .            .          .          .          .          12   .  .  R  .  .   PLACE ON THE SCREEN FORM
PROPERTY    INITVAL      C      80      .      .            .          .          .          .          13   .  .  R  .  .   INITIAL COLUMN VALUE
PROPERTY    FORMULA      C      80      .      .            .          .          .          .          14   .  .  R  .  .   FORMULA FOR COMPUTED COLUMN
PROPERTY    UPDTYPE      C       1      .      .            .          .          .          .          15   .  .  R  .  .   TYPE OF COLUMN UPDATE
PROPERTY    MISSING      C       1      .      .            .          .          .          .          16   .  .  R  .  .   CODE OF MISSING VALUE
PROPERTY    MESSAGE      N       8      .      .            .          .          .          .          17   .  .  R  .  .   MESSAGE ID
RINFO       REPORT       N       8      P      .            RMAIN      REPORT     .          .           1   .  .  R  .  .   REPORT IDENTIFICATION NUMBER
RINFO       INFONO       N       8      P      .            .          .          .          .           2   .  .  R  .  .   NUMBER OF TITLES FOR COMMON USE PARAMETERS
RINFO       SUBTITLE     C      80      .      .            .          .          .          .           3   .  .  R  .  .   TITLE FOR COMMON USE PARAMETER
RINFO       REPARAM      C       8      .      .            RPARAMS    REPARAM    .          .           4   .  .  R  .  .   NAME OF THE COMMNON USE PARAMETER
RINFO       FORMAT       C      20      .      .            .          .          .          .           5   .  .  R  .  .   FORMAT FOR THE VALUES OF THE COMMON USE PARAMETER
RMAIN       REPORT       N       8      P      .            .          .          .          .           1   .  .  R  .  .   REPORT ID
RMAIN       TABLE        C       8      .      $TABLE.      OBJECT     TABLE      OBJECT     TITLE       2   .  .  R  .  .   TABLE NAME
RMAIN       REPTITLE     C      80      .      .            .          .          .          .           3   .  .  R  .  .   REPORT TITLE
RMAIN       REPATTR      C       1      .      .            .          .          .          .           4   .  .  R  .  .   ATTRIBUTE
RMAIN       REPORGAN     C      20      .      .            .          .          .          .           5   .  .  R  .  .   ORGANIZATION TITLE
RMAIN       REPDATE      C      20      .      .            .          .          .          .           6   .  .  R  .  .   TEXT FOR DATE
RMAIN       REPAGE       C      20      .      .            .          .          .          .           7   .  .  R  .  .   TEXT FOR PAGE NUMBER
RMAIN       REPEND       C      20      .      .            .          .          .          .           8   .  .  R  .  .   TEXT THAT APPEAR AT THE END OF THE REPORT
RPARAMS     REPARAM      C       8      P      .            .          .          .          .           1   .  .  R  .  .   NAME OF COMMON USE PARAMETER
RPARAMS     PARAMVAL     C      80      .      .            .          .          .          .           2   .  .  R  .  .   VALUE OF COMMON USE PARAMETER
RSTAT       REPORT       N       8      P      .            RMAIN      REPORT     .          .           1   .  .  R  .  .   REPORT IDENTIFICATION NUMBER
RSTAT       COLUMN       C       8      P      .            RVARS      COLUMN     .          .           2   .  .  R  .  .   CLASSIFIER NAME
RSTAT       STATNO       N       8      P      .            .          .          .          .           3   .  .  R  .  .   STATISTICS ORDER NUMBER
RSTAT       ANALVAR      C       8      P      .            RVARS      COLUMN     .          .           4   .  .  R  .  .   RAPORT VARIABLE THAT HAS PROPERTIES OF AN ANALYSIS VARIABLE
RSTAT       STATITLE     C      80      .      .            .          .          .          .           6   .  .  R  .  .   TITLE FOR CALCULATED STATISTICS
RSTAT       REPSTAT      C       1      .      .            .          .          .          .           6   .  .  R  .  .   KEYLETTER OF STATISTICS
RTOTAL      REPORT       N       8      P      .            RMAIN      REPORT     .          .           1   .  .  R  .  .   REPORT IDENTIFICATION NUMBER
RTOTAL      STATNO       N       8      P      .            .          .          .          .           2   .  .  R  .  .   STATISTICS ORDER NUMBER
RTOTAL      ANALVAR      C       8      P      .            RVARS      COLUMN     .          .           3   .  .  R  .  .   REPORT VARIABLE THAT HAS PROPERTIES OF AN ANALYSIS VARIABLE
RTOTAL      STATITLE     C      80      .      .            .          .          .          .           4   .  .  R  .  .   TITLE FOR CALCULATED STATISTICS
RTOTAL      REPSTAT      C       1      .      .            .          .          .          .           5   .  .  R  .  .   KEYLETTER FOR STATISTICS
RVARS       REPORT       N       8      P      .            RMAIN      REPORT     .          .           1   .  .  R  .  .   REPORT IDENTIFICATION NUMBER
RVARS       ORDER        N       8      P      .            .          REPORT     .          .           2   .  .  R  .  .   REPORT VARIABLE ORDER NUMBER
RVARS       COLUMN       C       8      .      .            PROPERTY   COLUMN     .          .           3   .  .  R  .  .   REPORT VARIABLE NAME
RVARS       COLTITLE     C      40      .      .            .          .          .          .           4   .  .  R  .  .   REPORT VARIABLE TITLE
RVARS       COLATTR      C       2      .      .            .          .          .          .           5   .  .  R  .  .   REPORT VARIABLE ATTRIBUTE (T , R, A, M)
RVARS       FORMAT       C      20      .      .            .          .          .          .           6   .  .  R  .  .   REPORT VARIABLE FORMAT
RESULT      PATIENT      N       8      P      PATIENT.     PATIENT    PATIENT    PATIENT    SURNAME     1   .  .  R  .  .   PATIENT ID
RESULT      TRIAL        N       8      P      TRIAL.       TRIAL      TRIAL      TRIAL      TRIALNAM    2   .  .  R  .  .   TRIAL ID
RESULT      DATE         C      10      P      .            .          .          .          .           3   .  .  R  .  .   DATE
RESULT      RESULT       N       8      .      6.3          .          .          .          .           4   .  .  R  .  .   TRIAL'S RESULT
TRIAL       TRIAL        N       8      P      .            .          .          .          .           1   .  .  R  .  .   TRIAL ID
TRIAL       TRIALNAM     C      10      .      .            .          .          .          .           2   .  .  R  .  .   TRIAL NAME
TRIAL       L_NORMAL     N       8      .      6.3          .          .          .          .           3   .  .  R  .  .   LOWEST NORMAL VALUE
TRIAL       H_NORMAL     N       8      .      6.3          .          .          .          .           4   .  .  R  .  .   HIGHEST NORMAL VALUE
TRIAL       L_WARN       N       8      .      5.2          .          .          .          .           5   .  .  R  .  .   LOWEST WARNING VALUE
TRIAL       H_WARN       N       8      .      5.2          .          .          .          .           6   .  .  R  .  .   HIGHEST WARNING VALUE
VCROSS      TABLE        C       8      P      $TABLE.      OBJECT     TABLE      OBJECT     TITLE       1   .  .  R  .  .   NAME OF THE TABLE THAT MUST BE VERIFIED
VCROSS      VERNUM       N       8      P      .            .          .          .          .           2   .  .  R  .  .   VERIFICATION NUMBER
VCROSS      COLUMN       C       8      .      $COLUMN.     PROPERTY   COLUMN     PROPERTY   TITLE       3   .  .  R  .  .   NAME OF THE COLUMN THAT MUST BE VERIFIED
VCROSS      MAINEXPR     C      80      .      .            .          .          .          .           4   .  .  R  .  .   ARITHMETICAL OR LOGICAL EXPRESSION FOR VERIFIED TABLE
VCROSS      CONDITN      C       3      .      .            .          .          .          .           5   .  .  R  .  .   ARITHMETICAL OR LOGICAL OPERATOR
VCROSS      RELTABLE     C       8      .      $TABLE.      OBJECT     TABLE      OBJECT     TITLE       6   .  .  R  .  .   NAME OF THE RELATED TABLE
VCROSS      RELEXPR      C      80      .      .            .          .          .          .           7   .  .  R  .  .   ARITHMETICAL OR LOGICAL EXPRESSION FOR RELATED TABLE
VCROSS      EVENT        C       1      .      .            .          .          .          .           8   .  .  R  .  .   EVENT (U - UPDATE, OR S - SAVE)
VCROSS      MESSAGE      N       8      .      .            .          MESSAGE    MESSAGE    .           9   .  .  R  .  .   MESSAGE IDENTIFICATION NAME
VDOMAIN     TABLE        C       8      P      $TABLE.      OBJECT     TABLE      OBJECT     TITLE       1   .  .  R  .  .   NAME OF THE TABLE THAT MUST BE VERIFIED
VDOMAIN     COLUMN       C       8      P      $COLUMN.     PROPERTY   COLUMN     PROPERTY   TITLE       2   .  .  R  .  .   NAME OF THE COLUM THAT MUST BE VERIFIED
VDOMAIN     VERNUM       N       8      .      .            .          .          .          .           3   .  .  R  .  .   VERIFICATION NUMBER
VDOMAIN     EVENT        C       1      .      .            .          .          .          .           4   .  .  R  .  .   EVENT
VDOMAIN     MESSAGE      N       8      .      .            .          .          .          .           5   .  .  R  .  .   MESSAGE IDENTIFICATION NAME
VFOREIGN    TABLE        C       8      P      $TABLE.      OBJECT     TABLE      OBJECT     TITLE       1   .  .  R  .  .   NAME OF THE TABLE THAT MUST BE VERIFIED
VFOREIGN    RELTABLE     C       8      P      $TABLE.      OBJECT     TABLE      OBJECT     TITLE       2   .  .  R  .  .   NAME OF THE RELATED TABLE
VFOREIGN    VERNUM       N       8      .      .            .          .          .          .           3   .  .  R  .  .   VERIFICATION NUMBER
VFOREIGN    EVENT        C       1      .      .            .          .          .          .           4   .  .  R  .  .   EVENT
VFOREIGN    MESSAGE      N       8      .      .            .          .          .          .           5   .  .  R  .  .   MESSAGE IDENTIFICATION NAME
VPRIMARY    TABLE        C       8      P      $TABLE.      OBJECT     TABLE      OBJECT     TITLE       1   .  .  R  .  .   NAME OF THE TABLE THAT MUST BE VERIFIED
VPRIMARY    VERNUM       N       8      .      .            .          .          .          .           2   .  .  R  .  .   VERIFICATION NUMBER
VPRIMARY    EVENT        C       1      .      .            .          .          .          .           3   .  .  R  .  .   EVENT
VPRIMARY    MESSAGE      N       8      .      .            .          .          .          .           4   .  .  R  .  .   MESSAGE IDENTIFICATION NAME
VROWCOL     TABLE        C       8      P      $TABLE.      OBJECT     TABLE      OBJECT     TITLE       1   .  .  R  .  .   NAME OF THE TABLE THAT MUST BE VERIFIED
VROWCOL     VERNUM       N       8      P      .            .          .          .          .           2   .  .  R  .  .   VERIFICATION NUMBER
VROWCOL     COLUMN       C       8      .      $COLUMN.     PROPERTY   COLUMN     PROPERTY   TITLE       3   .  .  R  .  .   NAME OF THE COLUMN THAT MUST BE VERIFIED
VROWCOL     VERTYPE      C       2      .      .            .          .          .          .           4   .  .  R  .  .   VERIFICATION TYPE
VROWCOL     MAINEXPR     C      80      .      .            .          .          .          .           5   .  .  R  .  .   ARITHMETICAL OR LOGICAL EXPRESSION FOR VERIFIED COLUMN
VROWCOL     CONDITN      C       3      .      .            .          .          .          .           6   .  .  R  .  .   ARITHMETICAL OR LOGICAL OPERATOR
VROWCOL     EXPRESS      C      80      .      .            .          .          .          .           7   .  .  R  .  .   ARITHMETICAL OR LOGICAL EXPRESSION THE RELATED COLUMNS
VROWCOL     EVENT        C       1      .      .            .          .          .          .           8   .  .  R  .  .   EVENT <U - UPDATE OR S - SAVE)
VROWCOL     MESSAGE      N       8      .      .            .          .          .          .           9   .  .  R  .  .   MESSAGE IDENTIFICATION NUMBER
;
RUN ;

%VFORMAT(KERNEL, OBJECT, .) ;
%VFORMAT(KERNEL, PROPERTY, .) ;

DATA KERNEL.FORMAT ;
LENGTH FORMAT $20 DETAIL $80  ;
FORMAT FORMAT $CHAR20. DETAIL $CHAR80.  ;
LABEL
FORMAT = "FORMAT"
DETAIL = "DETAIL"
 ;
INPUT FORMAT DETAIL & $CHAR80. ;
CARDS ;
 PHONE.    000/ 000-0000
 NUMBER.   0/ 0000
;
RUN ;

%PFORMAT(KERNEL, .) ;

DATA KERNEL.LOCATION ;
LENGTH TABLE $8 LIBRARY $8 TEMPLIB $8 ;
FORMAT TABLE $CHAR8. LIBRARY $CHAR8. TEMPLIB $CHAR8. ;
LABEL
TABLE = "TABLE NAME"
LIBRARY = "SAS LIBRARY NAME"
TEMPLIB = "SAS LIBRARY NAME FOR TEMPORARY LOCATION"
 ;
INPUT TEMPLIB TABLE LIBRARY ;
   CARDS ;
   TEMP      AAPPLIST    KERNEL
   TEMP      AAPPMODE    KERNEL
   TEMP      ACURUSER    KERNEL
   TEMP      AMODEOBJ    KERNEL
   TEMP      AMODEOPR    KERNEL
   TEMP      AOBJECT     KERNEL
   TEMP      APROJECT    KERNEL
   TEMP      AUSERMOD    KERNEL
   TEMP      AUSERPAS    KERNEL
   TEMP      LIBRARY     KERNEL
   TEMP      OBJECT      KERNEL
   TEMP      LOCATION    KERNEL
   TEMP      PROPERTY    KERNEL
   TEMP      FORMAT      KERNEL
   TEMP      LINK        KERNEL
   TEMP      COMMACC     KERNEL
   TEMP      MESSAGE     KERNEL
   TEMP      COMOPER     KERNEL
   TEMP      PPROCESS    KERNEL
   TEMP      POPER       KERNEL
   TEMP      PINPUT      KERNEL
   TEMP      PATTACH     KERNEL
   TEMP      PINIT       KERNEL
   TEMP      PSELECT     KERNEL
   TEMP      PPROJECT    KERNEL
   TEMP      PBINARY     KERNEL
   TEMP      PMAN        KERNEL
   TEMP      POUTPUT     KERNEL
   TEMP      POUTRULE    KERNEL
   TEMP      PUPDATE     KERNEL
   TEMP      PMESSAGE    KERNEL
   TEMP      PATIENT     PATDB2
   TEMP      GROUP       PATAPPL
   TEMP      PLINK       KERNEL
   TEMP      VPRIMARY    KERNEL
   TEMP      VFOREIGN    KERNEL
   TEMP      VDOMAIN     KERNEL
   TEMP      VROWCOL     KERNEL
   TEMP      VCROSS      KERNEL
   TEMP      ERROR       KERNEL
   TEMP      ERRORVAL    KERNEL
   TEMP      ERRORVAL    KERNEL
   TEMP      MEDICINE    PATAPPL
   TEMP      DOSE        PATAPPL
   TEMP      TRIAL       PATAPPL
   TEMP      RESULT      PATAPPL
   TEMP      MONITOR     PATAPPL
   TEMP      RMAIN       KERNEL
   TEMP      RPARAMS     KERNEL
   TEMP      RINFO       KERNEL
   TEMP      RVARS       KERNEL
   TEMP      RTOTAL      KERNEL
   TEMP      RSTAT       KERNEL
   TEMP      MLIST       KERNEL
   TEMP      MMENU       KERNEL
   TEMP      MPROG       KERNEL
   TEMP      PMACRO      KERNEL
   ;
RUN ;
DATA KERNEL.MESSAGE ;
LENGTH MESSAGE 8 TEXT $80 MESTYPE $1 OUTPUT $2  ;
FORMAT MESSAGE 8. TEXT $CHAR80. MESTYPE $CHAR1. OUTPUT $CHAR2.  ;
LABEL
MESSAGE = "MESSAGE ID"
TEXT = "MESSAGE TEXT"
MESTYPE = "MESSAGE TYPE"
OUTPUT = "OUTPUT MESSAGE DESTINATION"
 ;
INPUT MESSAGE MESTYPE OUTPUT TEXT & $CHAR80. ;
   CARDS ;
   100  E   S BLA BLA 100
   101  E   S BLA BLA 101
   102  E   S BLA BLA 102
   103  E   S BLA BLA 103
   104  E   S BLA BLA 104
   105  E   S BLA BLA 105
   106  E   S BLA BLA 106
   ;
RUN ;


DATA KERNEL.LINK ;
LENGTH TABLE $8 RELTABLE $8 COLUMN $8 RELCOL $8 ;
FORMAT TABLE $TABLE. RELTABLE $TABLE. COLUMN $COLUMN. RELCOL $COLUMN. ;
LABEL
TABLE = "TABLE NAME"
RELTABLE = "RELATED TABLE NAME"
COLUMN = "COLUMN NAME"
RELCOL = "RELATED COLUMN NAME"
 ;
INPUT TABLE RELTABLE COLUMN RELCOL ;
   CARDS ;
   DIFF1       DIFF2       TABLE       TABLE
   DIFF1       DIFF2       LIBRARY     LIBRARY
   PATIENT     RESULT      PATIENT     PATIENT
   PINIT       PINPUT      INPUTID     INPUTID
   PINPUT      PBINARY     INPUTID     INPUTID
   PINPUT      PBINARY     OPERORD     OPERORD
   PINPUT      PPROJECT    INPUTID     INPUTID
   PINPUT      PPROJECT    OPERORD     OPERORD
   PINPUT      PSELECT     INPUTID     INPUTID
   PINPUT      PSELECT     OPERORD     OPERORD
   PPROCESS    PATTACH     PROCID      PROCID
   PPROCESS    POPER       PROCID      PROCID
   PMESSAGE    POPER       PROCID      PROCID
   PMESSAGE    POPER       ORDER       ORDER
   RMAIN       RINFO       REPORT      REPORT
   RMAIN       RSTAT       REPORT      REPORT
   RMAIN       RTOTAL      REPORT      REPORT
   RMAIN       RVARS       REPORT      REPORT
   RVARS       RSTAT       REPORT      REPORT
   RVARS       RSTAT       COLUMN      COLUMN
   RVARS       RSTAT       COLUMN      ANALVAR
   RTOTAL      RVARS       REPORT      REPORT
   RTOTAL      RVARS       ANALVAR     ANALVAR
   TRIAL       RESULT      TRIAL       TRIAL
   AAPPLIST    AAPPMODE    APPID       APPID
   AMODEOBJ    AOBJECT     OBJECTID    OBJECTID
  ;
RUN ;


DATA KERNEL.MLIST ;
LENGTH UINAME $8 UIDESC $80 LIBRARY $8 CATALOG $8 ;
FORMAT UINAME $CHAR8. UIDESC $CHAR80. LIBRARY $CHAR8. CATALOG $CHAR8. ;
LABEL
UINAME = "USER INTERFACE IDENTIFICATION NAME"
UIDESC = "USER INTERFACE DESCRIPTION"
LIBRARY = "SAS LIBRARY NAME"
CATALOG = "SAS CATALOG NAME"
 ;
INPUT UINAME  LIBRARY CATALOG UIDESC & $CHAR80. ;
CARDS  ;
   EXAMPLE  KERNEL  MENUS  EXAMPLE USER INTERFACE
   ;
RUN ;

DATA KERNEL.MMENU ;
LENGTH MENUNAME $8 MENUITEM 8 ITEMNAME $20 ACTNAME $8 ACTYPE $1 ITEMGRAY $1 ITEMNEM $1  ;
FORMAT MENUNAME $CHAR8. MENUITEM 8. ITEMNAME $CHAR20. ACTNAME $CHAR8. ACTYPE $CHAR1. ITEMGRAY $CHAR1. ITEMNEM $CHAR1.  ;
LABEL
MENUNAME = "MENU IDENTIFICATION NAME"
MENUITEM = "ORDER NUMBER OF THE ITEM IN THE MENU"
ITEMNAME = "NAME OF THE ITEM ON THE MENU"
ACTNAME = "ACTION NAME"
ACTYPE = "ACTION TYPE"
ITEMGRAY = "ITEM IS INITIALY ENABLED OR NOT FOR SELECTION"
ITEMNEM = "MNEMONIC  CHARACTER FOR ITEM SELECTION"
 ;
INPUT MENUNAME MENUITEM ITEMNAME ACTNAME ACTYPE ITEMGRAY ITEMNEM ;
   CARDS ;
   EXAMPLE        1        TABLE         TABMENU       M          N           .
   EXAMPLE        2        EDIT          EDITMENU      M          Y           .
   EXAMPLE        3        PROCESS       PROCMENU      M          N           .
   EXAMPLE        4        HELP          HELPMENU      M          N           .
   TABMENU        1        OPEN          OPENTABU      U          N           O
   TABMENU        2        CLOSE         CLOSETAB      U          Y           C
   TABMENU        3        SAVE          SAVETAB       U          Y           S
   TABMENU        4        PRINT         PRNMENU       M          Y           P
   TABMENU        5        EXIT          END           S          N           X
   EDITMENU       1        EDIT          EDITAB        U          Y           E
   EDITMENU       2        BROWSE        BROWSE        U          Y           B
   PROCMENU       1        REPORTS       REPGEN        U          N           R
   PROCMENU       2        PROCESSING    PROCGEN       U          N           .
   HELPMENU       1        CONTENTS      CONTENTS      U          N           N
   HELPMENU       2        INDX          INDX          U          N           I
   PRNMENU        1        FILE          PRNFILE       U          N           F
   PRNMENU        2        PRINTER       PRN           U          N           T
   ;
RUN ;

DATA KERNEL.MPROG ;
LENGTH ACTNAME $8 LIBRARY $8 CATALOG $8 ENTRYNAM $8 ENTRYTYP $8  ;
FORMAT ACTNAME $CHAR8. LIBRARY $CHAR8. CATALOG $CHAR8. ENTRYNAM $CHAR8. ENTRYTYP $CHAR8.  ;
LABEL
ACTNAME = "ACTION NAME"
LIBRARY = "SAS LIBRARY NAME"
CATALOG = "SAS CATALOG NAME"
ENTRYNAM = "NAME OF THE CATALOG ENTRY"
ENTRYTYP = "TYPE OF THE CATALOG ENTRY"
 ;
INPUT ACTNAME LIBRARY CATALOG ENTRYNAM ENTRYTYP ;
   CARDS ;
   OPENTABU    KERNEL     PROGRAMS    OPENTAB     FRAME
   CLOSETAB    KERNEL     PROGRAMS    CLOSETAB    FRAME
   SAVETAB     KERNEL     PROGRAMS    SAVETAB     FRAME
   EDITAB      KERNEL     PROGRAMS    EDITAB      PROGRAM
   BROWSE      KERNEL     PROGRAMS    BROWSE      PROGRAM
   REPGEN      KERNEL     PROGRAMS    REPGEN      FRAME
   PROCGEN     KERNEL     PROGRAMS    PROCGEN     FRAME
   CONTENTS    KERNEL     PROGRAMS    CONTENTS    CBT
   INDX        KERNEL     PROGRAMS    INDX        CBT
   PRNFILE     KERNEL     PROGRAMS    PRNFILE     FRAME
   PRN         KERNEL     PROGRAMS    PRN         FRAME
   ;
RUN ;


DATA KERNEL.PPROCESS ;
LENGTH PROCID $8 TITLE $80 PROCTYPE $1  ;
FORMAT PROCID $CHAR8. TITLE $CHAR80. PROCTYPE $CHAR1. ;
LABEL
PROCID = "PROCESS IDENTIFICATION NAME"
TITLE = "TITLE OF THE PROCESS"
PROCTYPE = "TYPE OF THE PROCESS (D OR I)"
 ;
INPUT PROCID PROCTYPE TITLE & $CHAR80. ;
   CARDS ;
   REALLOC   D TABLES REALLOCATION
   UPDTRIAL  D TRIALS ACCESS CONTROL
   ;
RUN ;

%VFORMAT(KERNEL, PPROCESS, .) ;

DATA KERNEL.PATTACH ;
LENGTH TABLE $8 LIBRARY $8 EVENT $1 EVENTYPE $1 PROCID $8  ;
FORMAT TABLE $TABLE. LIBRARY $CHAR8. EVENT $CHAR1. EVENTYPE $CHAR1. PROCID $PROCESS.  ;
LABEL
TABLE = "TABLE NAME TO WHICH THE PROCESS IS ATTACHED"
LIBRARY = "SAS LIBRARY NAME"
EVENT = "EVENT THAT INVOKES PROCESS (S OR U)"
EVENTYPE = "EVENT'S TYPE (B OR A)"
PROCID = "PROCESS IDENTIFICATION NAME"
 ;
INPUT TABLE LIBRARY EVENT EVENTYPE PROCID ;
   CARDS ;
   LOCATION    KERNEL       S         B        REALLOC
   ACURUSER    KERNEL       U         A        UPDTRIAL
  ;
RUN ;

DATA KERNEL.PBINARY ;
LENGTH INPUTID $8 OPERORD 8 RELTABLE $8 RELLIB $8  ;
FORMAT INPUTID $CHAR8. OPERORD 8. RELTABLE $TABLE. RELLIB $CHAR8.  ;
LABEL
INPUTID = "INPUT IDENTIFICATION NAME"
OPERORD = "OPERATOR ORDER NUMBER"
RELTABLE = "NAME OF THE RELATED TABLE"
RELLIB = "SAS LIBRARY NAME"
 ;
INPUT INPUTID OPERORD RELTABLE RELLIB ;
  CARDS ;
  HOWMOVE       1       COMOPER   KERNEL
  HOWMOVE       2       COMMACC   KERNEL
  NEWLOC        1       LOCATION  KERNEL
  OLDLOC        1       LOCATION  TEMP
  OLD_NEW       1       DIFF2     WORK
  ;
RUN ;

DATA KERNEL.PINIT ;
LENGTH INPUTID $8 INITAB $8 INITLIB $8  ;
FORMAT INPUTID $CHAR8. INITAB $TABLE. INITLIB $CHAR8.  ;
LABEL
INPUTID = "INPUT IDENTIFICATION NAME"
INITAB = "TABLE NAME"
INITLIB = "SAS LIBRARY NAME"
 ;
INPUT INPUTID INITAB INITLIB ;
   CARDS ;
   HOWMOVE    UNION3   WORK
   NEWLOC     LOCATION TEMP
   OLDLOC     LOCATION KERNEL
   OLD_NEW    DIFF1    WORK
   ;
RUN ;

DATA KERNEL.PINPUT ;
LENGTH INPUTID $8 OPERORD 8 OPERATOR $1  ;
FORMAT INPUTID $CHAR8. OPERORD 8. OPERATOR $CHAR1.  ;
LABEL
INPUTID = "INPUT IDENTIFICATION NAME"
OPERORD = "RELATIONAL OPERATOR ORDER NUMBER"
OPERATOR = "RELATIONAL OPERATOR (S,P,R,U,D,J,V)"
 ;
INPUT INPUTID OPERORD OPERATOR  ;
   CARDS ;
   HOWMOVE       1    J
   HOWMOVE       2    J
   NEWLOC        1    D
   OLDLOC        1    D
   OLD_NEW       1    U
   ;
RUN ;

DATA KERNEL.PLINK ;
LENGTH INPUTID $8 OPERORD 8 COLUMN $8 RELCOL $8  ;
FORMAT INPUTID $CHAR8. OPERORD 8. COLUMN $COLUMN. RELCOL $COLUMN.  ;
LABEL
INPUTID = "INPUT IDENTIFICATION NAME"
OPERORD = "OPERATION ORDER NUMBER"
COLUMN = "NAME OF THE COLUMN OF THE LEFT-HAND TABLE"
RELCOL = "NAME OF THE COLUMN OF THE RIGHT-HAND TABLE"
 ;
INPUT INPUTID OPERORD COLUMN RELCOL ;
   CARDS ;
   HOWMOVE       1       LIBRARY     LIBRARY
   HOWMOVE       2       COMMUNID    COMMUNID
   NEWLOC        1       TABLE       TABLE
   NEWLOC        1       LIBRARY     LIBRARY
   OLDLOC        1       TABLE       TABLE
   OLDLOC        1       LIBRARY     LIBRARY
   ;
RUN ;

DATA KERNEL.PMACRO ;
LENGTH MACRO $9 PROPERTY $1 PREMACRO $9 PSTMACRO $9  ;
FORMAT MACRO $CHAR9. PROPERTY $CHAR1. PREMACRO $CHAR9. PSTMACRO $CHAR9.  ;
INFORMAT PREMACRO $CHAR9. PSTMACRO $CHAR9.  ;
LABEL
MACRO = "MACRO NAME"
PROPERTY = "MACRO'S PROPERTIES"
PREMACRO = "PREMACRO NAME"
PSTMACRO = "POSTMACRO NAME"
 ;
INPUT MACRO PROPERTY PREMACRO PSTMACRO ;
   CARDS ;
   %MOVE           O        .           .
   %PREVIOUS       I        %PREVAR     %POSTVAR
   %SAME           I        %PREVAR     %POSTVAR
   %SORT           O        .           .
   ;
RUN ;

DATA KERNEL.PMAN ;
LENGTH MANID $8 MANORD 8 EXPRESSN $80  ;
FORMAT MANID $CHAR8. MANORD 8. EXPRESSN $CHAR80.  ;
LABEL
MANID = "MANIPULATION IDENTIFICATION NAME"
MANORD = "MANIPULATION ORDER NUMBER"
EXPRESSN = "MANIPULATION EXPRESSION"
 ;
INPUT MANID MANORD EXPRESSN & $CHAR80. ;
CARDS4 ;
SORTDATA  1  %SORT(TABLE  _STATUS_ ) ;
SORTDATA  2  IF %SAME(TABLE) THEN DO ;
SORTDATA  3  TARLIB = LIBRARY ;
SORTDATA  4  LIBRARY= %PREVIOUS(LIBRARY) ;
SORTDATA  5  OUTPUT ;
SORTDATA  6  END ;
MOVETABS  1  %MOVE() ;
;;;;
RUN ;

DATA KERNEL.POPER ;
LENGTH PROCID $8 ORDER 8 OPERNAME $80 INPUTID $8 MANID $8 OUTPUTID $8  ;
FORMAT PROCID $PROCESS. ORDER 8. OPERNAME $CHAR80. INPUTID $CHAR8.
       MANID $CHAR8. OUTPUTID $CHAR8.  ;
INFORMAT MANID $CHAR8. OUTPUTID $CHAR8. ;
LABEL
PROCID = "PROCESS IDENTIFICATION NAME"
ORDER = "OPERATION ORDER NUMBER"
OPERNAME = "OPERATION TITLE"
INPUTID = "INPUT IDENTIFICATION NAME"
MANID = "MANIPULATION IDENTIFICATION NAME"
OUTPUTID = "OUTPUT IDENTIFICATION NAME"
 ;
INPUT PROCID ORDER INPUTID MANID OUTPUTID OPERNAME & $CHAR80.  ;
   CARDS ;
   REALLOC  1 NEWLOC     .           OUTDIFF1  SELECT UPDATED LOCATIONS
   REALLOC  2 OLDLOC     .           OUTDIFF2  SELECT PREVIOUS LOCATIONS
   REALLOC  3 OLD_NEW    SORTDATA    OUTUNION  UNITE PREVIOUS AND UPDATED LOCATIONS
   REALLOC  4 HOWMOVE    MOVETABS    .         MOVE TABLES BETWEEN LOCATIONS
   ;
RUN ;

DATA KERNEL.POUTPUT ;
LENGTH OUTPUTID $8 OUTABLE $8 OUTLIB $8 OUTYPE $1 RULEID $8  ;
FORMAT OUTPUTID $CHAR8. OUTABLE $CHAR8. OUTLIB $CHAR8. OUTYPE $CHAR1. RULEID $CHAR8.  ;
LABEL
OUTPUTID = "OUTPUT IDENTIFICATION NAME"
OUTABLE = "OUTPUT OPERATION TABLE NAME"
OUTLIB = "SAS LIBRARY NAME"
OUTYPE = "OUTPUT TABLE TYPE"
RULEID = "UPDATING RULE IDENTIFICATION NAME"
 ;
INPUT OUTPUTID OUTABLE OUTLIB OUTYPE RULEID ;
   CARDS ;
   OUTDIFF1    DIFF1       WORK       N       RDIFF1
   OUTDIFF2    DIFF2       WORK       N       RDIFF2
   OUTUNION    UNION3      WORK       N       RUNION3
   ;
RUN ;


DATA KERNEL.PUPDATE ;
LENGTH RULEID $8 COLUMN $8 EXPRESSN $80  ;
FORMAT RULEID $CHAR8. COLUMN $CHAR8. EXPRESSN $CHAR80.  ;
LABEL
RULEID = "UPDATING RULE IDENTIFICATION NAME"
COLUMN = "COLUMN NAME"
EXPRESSN = "EXPRESSION"
 ;
INPUT RULEID COLUMN EXPRESSN & $CHAR80. ;
   CARDS ;
   RDIFF1     TABLE       TABLE
   RDIFF1     LIBRARY     LIBRARY
   RDIFF1     _STATUS_    "U"
   RDIFF2     TABLE       TABLE
   RDIFF2     LIBRARY     LIBRARY
   RDIFF2     _STATUS_    "O"
   RUNION3    TABLE       TABLE
   RUNION3    LIBRARY     LIBRARY
   RUNION3    TARLIB      TARLIB
   ;
RUN ;

DATA KERNEL.PMESSAGE ;
LENGTH PROCID $8 ORDER 8 EVENT $2 MESSAGE 8  ;
FORMAT PROCID $PROCESS. ORDER 8. EVENT $CHAR2. MESSAGE 8.  ;
LABEL
PROCID = "PROCESS IDENTIFICATION NAME"
ORDER = "OPERATION ORDER NUMBER"
EVENT = "OPERATIONS EVENT"
MESSAGE = "MESSAGE IDENTIFICATION NUMBER"
 ;
RUN ;

DATA KERNEL.RMAIN ;
LENGTH REPORT 8 TABLE $8 REPTITLE $80 REPATTR $1 REPORGAN $20 REPDATE $20 REPAGE $20 REPEND $20  ;
FORMAT REPORT 8. TABLE $TABLE. REPTITLE $CHAR80. REPATTR $CHAR1. REPORGAN $CHAR20. REPDATE $CHAR20. REPAGE $CHAR20. REPEND $CHAR20.  ;
LABEL
REPORT = "REPORT ID"
TABLE = "TABLE NAME"
REPTITLE = "REPORT TITLE"
REPATTR = "ATTRIBUTE"
REPORGAN = "ORGANIZATION TITLE"
REPDATE = "TEXT FOR DATE"
REPAGE = "TEXT FOR PAGE NUMBER"
REPEND = "TEXT THAT APPEAR AT THE END OF THE REPORT"
 ;
INPUT REPORT TABLE REPTITLE REPATTR REPORGAN REPDATE REPAGE REPEND & $CHAR80. ;
CARDS ;
 1  RESULT  DISTRIBUTION  F   ADVANCED_TRIAL_LTD.   DATE:  PAGE  END OF THE REPORT
;
RUN ;

DATA KERNEL.RPARAMS ;
LENGTH REPARAM $8 PARAMVAL $80  ;
FORMAT REPARAM $CHAR8. PARAMVAL $CHAR80.  ;
LABEL
REPARAM = "NAME OF COMMON USE PARAMETER"
PARAMVAL = "VALUE OF COMMON USE PARAMETER"
 ;
INPUT REPARAM PARAMVAL & $CHAR80. ;
CARDS ;
 TOWHOM     MR. Y.LANDAU
 FROM       MS. S.GREEN
;
RUN ;

DATA KERNEL.RINFO ;
LENGTH REPORT 8 INFONO 8 SUBTITLE $80 REPARAM $8 FORMAT $20  ;
FORMAT REPORT 8. INFONO 8. SUBTITLE $CHAR80. REPARAM $CHAR8. FORMAT $CHAR20.  ;
LABEL
REPORT = "REPORT IDENTIFICATION NUMBER"
INFONO = "NUMBER OF TITLES FOR COMMON USE PARAMETERS"
SUBTITLE = "TITLE FOR COMMON USE PARAMETER"
REPARAM = "NAME OF THE COMMNON USE PARAMETER"
FORMAT = "PRINTING FORMAT FOR THE VALUES OF THE COMMON USE PARAMETER"
 ;
INPUT REPORT INFONO REPARAM FORMAT SUBTITLE & $CHAR80.;
CARDS ;
   1  1  TOWHOM  $10. TARGETED AT
   1  2  FROM    $10. PRODUCED BY
   ;
RUN ;

DATA KERNEL.RVARS ;
LENGTH REPORT 8 ORDER 8 COLUMN $8 COLTITLE $40 COLATTR $2 FORMAT $20  ;
FORMAT REPORT 8. ORDER 8. COLUMN $CHAR8. COLTITLE $CHAR40. COLATTR $CHAR2.
       FORMAT $CHAR20.  ;
INFORMAT FORMAT $CHAR20. ;
LABEL
REPORT = "REPORT IDENTIFICATION NUMBER"
ORDER = "REPORT VARIABLE ORDER NUMBER"
COLUMN = "REPORT VARIABLE NAME"
COLTITLE = "REPORT VARIABLE TITLE"
COLATTR = "REPORT VARIABLE ATTRIBUTE (T , R, A, M)"
FORMAT = "REPORT VARIABLE FORMAT"
 ;
INPUT REPORT ORDER COLUMN COLATTR FORMAT COLTITLE & $CHAR80. ;
CARDS ;
   1   1      TRIAL       T   .    TRIAL  NAME
   1   2      DATE        R   .    TRIAL DATE
   1   3      PATIENT     S   .    PATIENT
   1   4      RESULT      A   6.2  TRIAL RESULT
;
RUN ;

DATA KERNEL.RSTAT ;
LENGTH REPORT 8 COLUMN $8 STATNO 8 ANALVAR $8 STATITLE $80 REPSTAT $1 REPSTAT $1  ;
FORMAT REPORT 8. COLUMN $CHAR8. STATNO 8. ANALVAR $CHAR8. STATITLE $CHAR80.
       REPSTAT $CHAR1. REPSTAT $CHAR1.  ;
LABEL
REPORT = "REPORT IDENTIFICATION NUMBER"
COLUMN = "CLASSIFIER NAME"
STATNO = "STATISTICS ORDER NUMBER"
ANALVAR = "RAPORT VARIABLE TAHT HAS PROPERTIES OF AN ANALYSIS VARIABLE"
STATITLE = "TITLE FOR CALCULATED STATISTICS"
REPSTAT = "KEYLETTER OF STATISTICS"
 ;
INPUT REPORT COLUMN STATNO ANALVAR  REPSTAT STATITLE & $CHAR80. ;
CARDS ;
   1   DATE      1    RESULT   A   AVERAGE BY DAY
   1   TRIAL     1    RESULT   A   AVERAGE BY TRIAL
   1   TRIAL     2    RESULT   X   MAXIMUM BY TRIAL
;
RUN ;

DATA KERNEL.RTOTAL ;
LENGTH REPORT 8 STATNO 8 ANALVAR $8 STATITLE $80 REPSTAT $1  ;
FORMAT REPORT 8. STATNO 8. ANALVAR $CHAR8. STATITLE $CHAR80. REPSTAT $CHAR1. ;
LABEL
REPORT = "REPORT IDENTIFICATION NUMBER"
STATNO = "STATISTICS ORDER NUMBER"
ANALVAR = "REPORT VARIABLE THAT HAS PROPERTIES OF AN ANALYSIS VARIABLE"
STATITLE = "TITLE FOR CALCULATED STATISTICS"
REPSTAT = "KEYLETTER FOR STATISTICS (N, A, D, M, X, S, V, R, P, Q)"
 ;
RUN ;

DATA KERNEL.AAPPLIST ;
LENGTH APPID $8 TITLE $80 PASSWORD $8 UINAME $8  ;
FORMAT APPID $CHAR8. TITLE $CHAR80. PASSWORD $CHAR8. UINAME $CHAR8.  ;
LABEL
APPID = "APPLICATION IDENTIFICATION NAME"
TITLE = "APPLICATION TITLE"
PASSWORD = "APPLICATION PASSWORD"
UINAME = "USER INTERFACE IDENTIFICATION NAME"
 ;
INPUT APPID PASSWORD UINAME TITLE & $CHAR80. ;
CARDS ;
TRIALS  TRIAL   EXAMPLE    ACQUISITION OF TRIAL RESULTS
RESULTS RESULT  EXAMPLE    ANALYSIS OF TRIAL RESULTS
;
RUN ;

%VFORMAT(KERNEL, AAPPLIST, .) ;

DATA KERNEL.AAPPMODE ;
LENGTH APPID $8 MODEID $8  ;
FORMAT APPID $APPLIC. MODEID $CHAR8.  ;
LABEL
APPID = " APPLICATION IDENTIFICATION NAME"
MODEID = " MODE IDENTIFICATION NAME"
 ;
INPUT APPID MODEID ;
CARDS ;
 TRIALS     INPUT
 TRIALS     CONTROL
 RESULTS    REPORT
 RESULTS    ANALYZE
 RESULTS    INPUT
 ;
RUN ;
DATA KERNEL.ACURUSER ;
LENGTH USERID $8 USERINFO $80 LOGIN 8 LOGOUT 8 PASSWORD $8  ;
FORMAT USERID $CHAR8. USERINFO $CHAR80. LOGIN 8. LOGOUT 8. PASSWORD $CHAR8.  ;
LABEL
USERID = " USER IDENTIFICATION NAME"
USERINFO = " INFORMATION ABOUT USER"
LOGIN = " DATE AND TIME OF THE SESSION START"
LOGOUT = " DATE AND TIME OF THE SESSION END"
PASSWORD = " APPLICATION PASSWORD"
 ;
RUN ;

DATA KERNEL.AMODEOBJ ;
LENGTH MODEID $8 OBJECTID $8 OPERTYPE $1 PROCID $8  ;
FORMAT MODEID $CHAR8. OBJECTID $CHAR8. OPERTYPE $CHAR1. PROCID $PROCESS.  ;
INFORMAT PROCID $CHAR8. ;
LABEL
MODEID = " MODE IDENTIFICATION NAME"
OBJECTID = " APPLICATION OBJECT IDENTIFICATION NAME"
OPERTYPE = " TYPE OF OPERATION (E OR B)"
PROCID = " PROCESS IDENTIFICATION NAME"
 ;
INPUT MODEID OBJECTID OPERTYPE PROCID ;
CARDS ;
INPUT       PATIENT        E        .
INPUT       TRIAL          E        UPDTRIAL
INPUT       RESULT         E        UPDRES
ANALYZE     CLINIC         E        .
REPORT      PATIENT        B        .
REPORT      RESULT         B        .
CONTROL     TRIAL          B        .
CONTROL     RESULT         B        .
;

RUN ;

DATA KERNEL.AMODEOPR ;
LENGTH MODEID $8 PROCID $8  ;
FORMAT MODEID $CHAR8. PROCID $PROCESS.  ;
LABEL
MODEID = " MODE IDENTIFICATION NAME"
PROCID = " PROCESS IDENTIFICATION NAME"
 ;
INPUT MODEID PROCID ;
CARDS ;
INPUT       INTEGRIT
INPUT       REPINTGR
ANALYZE     ANALYZE
REPORT      REPPAT
REPORT      REPRES
;
RUN ;

DATA KERNEL.AOBJECT ;
LENGTH OBJECTID $8 TABLE $8 PROPERTY $1  ;
FORMAT OBJECTID $CHAR8. TABLE $TABLE. PROPERTY $CHAR1.  ;
LABEL
OBJECTID = "APPLICATION OBJECT IDENTIFICATION NAME"
TABLE = "TABLE NAME"
PROPERTY = "APPLICATION OBJECT PROPERTY (T OR P)"
 ;
INPUT OBJECTID TABLE PROPERTY ;
CARDS ;
 PATIENT     PATIENT       T
 PATIENT     GROUP         T
 TRIAL       TRIAL         P
 TRIAL       MONITOR       P
 RESULT      RESULT        P
 CLINIC      PATIENT       T
 CLINIC      GROUP         T
 CLINIC      TRIAL         T
 CLINIC      RESULT        T
 ;
 RUN ;

DATA KERNEL.APROJECT ;
LENGTH OBJECTID $8 TABLE $8 COLUMN $8  ;
FORMAT OBJECTID $CHAR8. TABLE $TABLE. COLUMN $COLUMN.  ;
LABEL
OBJECTID = "APPLICATION OBJECT IDENTIFICATION NAME"
TABLE = "TABLE NAME"
COLUMN = "TABLE NAME"
 ;
INPUT OBJECTID TABLE COLUMN ;
CARDS ;
TRIAL       TRIAL      TRIAL
TRIAL       TRIAL      L_WARN
TRIAL       TRIAL      H_WARN
TRIAL       MONITOR    TRIAL
TRIAL       MONITOR    REPEAT
RESULT      RESULT     TRIAL
RESULT      RESULT     DATE
RESULT      RESULT     RESULT
;
RUN ;

DATA KERNEL.AUSERMOD ;
LENGTH USERGRP $10 MODEID $8  ;
FORMAT USERGRP $CHAR10. MODEID $CHAR8.  ;
LABEL
USERGRP = "USER GROUP IDENTIFICATION NAME"
MODEID = "MODE IDENTIFICATION NAME"
 ;
INPUT USERGRP MODEID ;
CARDS ;
PHYSICIAN     INPUT
MANAGER       ANALYZE
MANAGER       REPORT
PHARMACIST    INPUT
PHARMACIST    ANALYZE
PHARMACIST    REPORT
;
RUN ;

DATA KERNEL.AUSERPAS ;
LENGTH USERGRP $10 USERID $8 USERINFO $80 USERPASW $8  ;
FORMAT USERGRP $CHAR10. USERID $CHAR8. USERINFO $CHAR80. USERPASW $CHAR8.  ;
LABEL
USERGRP = "USER GROUP IDENTIFICATION NAME"
USERID = "USER IDENTIFICATION NAME"
USERINFO = "INFORMATION ABOUT USER"
USERPASW = "USER'S PASSWORD"
 ;
INPUT USERGRP USERID USERPASW USERINFO & $CHAR80. ;
CARDS ;
PHYSICIAN   MASTER   BLUE_BAN  MR. JOHN STEVENSON
PHYSICIAN   INPUT    A234MKS   MS. KEREN SMITH
PHYSICIAN   OUTPUT   ZE_U_ZE   MS. TANYA BROWN
MANAGER     MANAGER  LUAHERET  MR. JOHN GLASS
PHARMACIST  ANALYST  COCAPEPS  MS. JENNIFER LASLO
PHARMACIST  VERIFY   _X_Z_XYZ  MS. KATHRIN GINSBURG
;
RUN ;


DATA KERNEL.ERROR ;
LENGTH DATETIME 8 VERTYPE $2 TABLE $8 VERNUM 8 VPROCID 8  ;
FORMAT DATETIME DATETIME. VERTYPE $CHAR2. TABLE $TABLE. VERNUM 8. VPROCID 8.  ;
LABEL
DATETIME = "DATA AND TIME WHEN THE VERIFICATION PROCESS WAS DONE"
VERTYPE = "VERIFICATION RULE TYPE"
TABLE = "NAME OF THE TABLE THAT WAS VERIFIED"
VERNUM = "VERIFICATION NUMBER"
VPROCID = "NUMBER OF VERIFICATION PROCESS"
 ;
RUN ;

DATA KERNEL.ERRORVAL ;
LENGTH VPROCID $8 ERRORNUM 8 COLUMN $8 VALUE $80  ;
FORMAT VPROCID $CHAR8. ERRORNUM 8. COLUMN $COLUMN. VALUE $CHAR80.  ;
LABEL
VPROCID = "NUMBER OF VERIFICATION PROCESS"
ERRORNUM = "ERROR NUMBER"
COLUMN = "NAME OF THE COLUMN FORMING THE PRIMARY KEY"
VALUE = "VALUE OF THE COLUMN FORMING THE PRIMARY KEY"
 ;
RUN ;


DATA PATDB2.PATIENT ;
LENGTH PATIENT 8 NAME $20 SURNAME $20 SEX $1 BIRTH $10 ADDRESS $80 PHONEHOM 8 PHONEWRK 8  ;
FORMAT PATIENT NUMBER. NAME $CHAR20. SURNAME $CHAR20. SEX $CHAR1. BIRTH $CHAR10. ADDRESS
       $CHAR80. PHONEHOM PHONE. PHONEWRK PHONE.  ;
LABEL
PATIENT = "PATIENT IDENTIFICATION NUMBER"
NAME = "FIRST NAME"
SURNAME = "LAST NAME"
SEX = "SEX"
BIRTH = "BIRTH DATE"
ADDRESS = "ADDRESS"
PHONEHOM = "PHONE AT HOME"
PHONEWRK = "PHONE AT WORK"
 ;
INPUT PATIENT NAME SURNAME SEX BIRTH PHONEHOM PHONEWRK ADDRESS  & $CHAR80. ;
CARDS ;
10001 TANYA  GREEN  F  01FEB1963  9196004252    9196004254  14/26 RED STR.
10002 SAMUEL BROWN  M  25APR1956  9196004252    9196004254  26/15 GREEN STR.
10003 DAVID  GREEN  M  25MAY1967  9196006573    9196007892  15/26 GREEN STR.
10004 DIANA  BLUE   F  11NOV1962  9196004583    9196004349  15/38 GREEN STR.
10005 KATRIN RED    F  10MAY1978  9196001265    9196005609  17/18 GREEN STR.
;
RUN ;

%VFORMAT(KERNEL, PATIENT, .) ;

DATA PATAPPL.MEDICINE ;
LENGTH MEDICINE 8 MEDNAME $80  ;
FORMAT MEDICINE 8. MEDNAME $CHAR80.  ;
LABEL
MEDICINE = "MEDICINE ID"
MEDNAME = "MEDICINE NAME"
 ;
INPUT MEDICINE MEDNAME & $CHAR80. ;
CARDS ;
   1    PARACETAMOL
   2    BRICALIN
   3    HISTAFEN
   4    PRAMIN
;
RUN ;

%VFORMAT(KERNEL, MEDICINE, .) ;

DATA PATAPPL.DOSE ;
LENGTH MEDICINE $8 GROUP 8 H_DOSE 8 L_DOSE 8  ;
FORMAT MEDICINE $MEDNAME. GROUP 8. H_DOSE 6.3 L_DOSE 6.3  ;
LABEL
MEDICINE = "MEDICINE ID"
GROUP = "GROUP ID"
H_DOSE = "HIGHEST DAILY DOSE"
L_DOSE = "LOWEST DAILY DOSE"
 ;
INPUT GROUP H_DOSE L_DOSE MEDICINE ;
 CARDS ;
  1    200.00    500.00   1
  2    250.00    450.00   1
  1     7.000     8.000   2
  2     6.000     9.000   2
  1    12.500    12.800   3
  1    1200.0    1300.0   4
;
RUN ;
DATA PATAPPL.TRIAL ;
LENGTH TRIAL 8 TRIALNAM $10 L_NORMAL 8 H_NORMAL 8 L_WARN 8 H_WARN 8  ;
FORMAT TRIAL 8. TRIALNAM $CHAR10. L_NORMAL 6.3 H_NORMAL 6.3 L_WARN 5.2 H_WARN 5.2  ;
LABEL
TRIAL = "TRIAL ID"
TRIALNAM = "TRIAL NAME"
L_NORMAL = "LOWEST NORMAL VALUE"
H_NORMAL = "HIGHEST NORMAL VALUE"
L_WARN = "LOWEST WARNING VALUE"
H_WARN = "HIGHEST WARNING VALUE"
 ;
INPUT TRIAL TRIALNAM L_NORMAL H_NORMAL L_WARN H_WARN ;
CARDS ;
    1    WBC      0.100       0.300      0.08      0.35
    2    HRF     20.100      30.100     18.80     32.20
    3    HLC      0.001       0.008      0.00      1.00
   56    HGB     13.200      15.500     11.70     17.30
   63    HCT     39.000      45.000     35.00     49.00
   88    RBC      4.300       5.100      3.80      5.70
   93    MCV     80.000      100.00     76.00     120.0
;
RUN ;

%VFORMAT(KERNEL, TRIAL, .) ;

DATA PATAPPL.GROUP ;
LENGTH GROUP 8 ORDERNO 8 PATIENT 8  ;
FORMAT GROUP 8. ORDERNO 8. PATIENT PATIENT.  ;
LABEL
GROUP = "GROUP ID"
ORDERNO = "PATIENT ORDER NUMBER"
PATIENT = "PATIENT ID"
 ;
INPUT GROUP ORDERNO PATIENT ;
CARDS ;
    1   1     10001
    1   2     10002
    2   1     10003
    2   2     10004
;
RUN ;

DATA PATAPPL.RESULT ;
LENGTH PATIENT 8 TRIAL 8 DATE $10 RESULT 8  ;
FORMAT PATIENT PATIENT. TRIAL TRIAL. DATE $CHAR10. RESULT 6.3  ;
LABEL
PATIENT = "PATIENT ID"
TRIAL = "TRIAL ID"
DATE = "DATE"
RESULT = "TRIAL'S RESULT"
 ;
INPUT PATIENT TRIAL DATE RESULT ;
CARDS ;
 10001     1     01MAY1994      8.120
 10001     1     01MAY1994      8.120
 10001     1     17MAY1994      7.540
 10001     3     21JUN1994     20.100
 10002     1     01MAY1994     10.000
 10002     1     17MAY1994      7.580
 10002     3     21JUN1994     23.500
 10003     1     01MAY1994      8.040
 10003     2     23MAY1994     11.200
 10004     2     23MAY1994     13.200
 10005     1     01MAY1994      7.540
 10005     2     22MAY1994     11.500
;
RUN ;


DATA PATAPPL.MONITOR ;
LENGTH GROUP 8 TRIAL 8 REPEAT 8  ;
FORMAT GROUP 8. TRIAL 8. REPEAT 8.  ;
LABEL
GROUP = "GROUP ID"
TRIAL = "TRIAL ID"
REPEAT = "TIME INTERVAL IN DAYS"
 ;
INPUT GROUP TRIAL REPEAT ;
CARDS ;
    1           1          12
    1          56          10
    1          63           5
    2           2           8
    2          56           8
    2          63           5
;
RUN ;

DATA KERNEL.VCROSS ;
LENGTH TABLE $8 VERNUM 8 COLUMN $8 MAINEXPR $80 CONDITN $3 RELTABLE $8
       RELEXPR $80 EVENT $1 MESSAGE 8  ;
FORMAT TABLE $TABLE. VERNUM 8. COLUMN $COLUMN. MAINEXPR $CHAR80.
       CONDITN $CHAR3. RELTABLE $TABLE. RELEXPR $CHAR80. EVENT $CHAR1. MESSAGE 8. ;
LABEL
TABLE = "NAME OF THE TABLE THAT MUST BE VERIFIED"
VERNUM = "VERIFICATION NUMBER"
COLUMN = "NAME OF THE COLUMN THAT MUST BE VERIFIED"
MAINEXPR = "ARITHMETICAL OR LOGICAL EXPRESSION FOR VERIFIED TABLE"
CONDITN = "ARITHMETICAL OR LOGICAL OPERATOR"
RELTABLE = "NAME OF THE RELATED TABLE"
RELEXPR = "ARITHMETICAL OR LOGICAL EXPRESSION FOR RELATED TABLE"
EVENT = "EVENT (U - UPDATE, OR S - SAVE)"
MESSAGE = "MESSAGE IDENTIFICATION NAME"
 ;
RUN ;


DATA KERNEL.VDOMAIN ;
LENGTH TABLE $8 COLUMN $8 VERNUM 8 EVENT $1 MESSAGE 8  ;
FORMAT TABLE $TABLE. COLUMN $COLUMN. VERNUM 8. EVENT $CHAR1. MESSAGE 8.  ;
LABEL
TABLE = "NAME OF THE TABLE THAT MUST BE VERIFIED"
COLUMN = "NAME OF THE COLUM THAT MUST BE VERIFIED"
VERNUM = "VERIFICATION NUMBER"
EVENT = "EVENT"
MESSAGE = "MESSAGE IDENTIFICATION NAME"
 ;
INPUT TABLE COLUMN VERNUM EVENT MESSAGE ;
CARDS ;
 DOSE  MEDICINE   1   U   104
;
RUN ;

DATA KERNEL.VFOREIGN ;
LENGTH TABLE $8 RELTABLE $8 VERNUM 8 EVENT $1 MESSAGE 8  ;
FORMAT TABLE $TABLE. RELTABLE $TABLE. VERNUM 8. EVENT $CHAR1. MESSAGE 8.  ;
LABEL
TABLE = "NAME OF THE TABLE THAT MUST BE VERIFIED"
RELTABLE = "NAME OF THE RELATED TABLE"
VERNUM = "VERIFICATION NUMBER"
EVENT = "EVENT"
MESSAGE = "MESSAGE IDENTIFICATION NAME"
 ;
INPUT TABLE RELTABLE VERNUM EVENT MESSAGE ;
CARDS ;
 RESULT    PATIENT   1      S  103
 RESULT    TRIAL     2      S  103
 RMAIN     RINFO     3      S  103
 RMAIN     RVARS     4      S  103
 RMAIN     RTOTAL    5      S  103
 RMAIN     RSTAT     6      S  103
;
RUN ;

DATA KERNEL.VPRIMARY ;
LENGTH TABLE $8 VERNUM 8 EVENT $1 MESSAGE 8  ;
FORMAT TABLE $TABLE. VERNUM 8. EVENT $CHAR1. MESSAGE 8.  ;
LABEL
TABLE = "NAME OF THE TABLE THAT MUST BE VERIFIED"
VERNUM = "VERIFICATION NUMBER"
EVENT = "EVENT"
MESSAGE = "MESSAGE IDENTIFICATION NAME"
 ;
INPUT TABLE VERNUM EVENT MESSAGE ;
CARDS ;
 PATIENT     1      U   100
 RESULT      2      U   102
 RESULT      3      S   102
 RMAIN       4      U   102
 RPARAMS     5      U   102
 RINFO       6      U   102
 RVARS       7      U   102
 RTOTAL      8      U   102
 RSTAT       9      U   102
 OBJECT     10      U   102
;
RUN ;


DATA KERNEL.VROWCOL ;
LENGTH TABLE $8 VERNUM 8 COLUMN $8 VERTYPE $2 MAINEXPR $80 CONDITN $3 EXPRESS $80 EVENT $1 MESSAGE 8  ;
FORMAT TABLE $TABLE. VERNUM 8. COLUMN $COLUMN. VERTYPE $CHAR2. MAINEXPR $CHAR80. CONDITN $CHAR3.
       EXPRESS $CHAR80. EVENT $CHAR1. MESSAGE 8.  ;
LABEL
TABLE = "NAME OF THE TABLE THAT MUST BE VERIFIED"
VERNUM = "VERIFICATION NUMBER"
COLUMN = "NAME OF THE COLUMN THAT MUST BE VERIFIED"
VERTYPE = "VERIFICATION TYPE"
MAINEXPR = "ARITHMETICAL OR LOGICAL EXPRESSION FOR VERIFIED COLUMN"
CONDITN = "ARITHMETICAL OR LOGICAL OPERATOR"
EXPRESS = "ARITHMETICAL OR LOGICAL EXPRESSION FOR RELATED COLUMNS"
EVENT = "EVENT (U - UPDATE OR S - SAVE)"
MESSAGE = "MESSAGE IDENTIFICATION NUMBER"
 ;
INPUT TABLE VERNUM COLUMN VERTYPE MAINEXPR $CHAR70. CONDITN EXPRESS & $CHAR80. ;
CARDS ;
 DOSE    1  H_DOSE   RO H_DOSE                                                                           >   L_DOSE
 DOSE    2  H_DOSE   RO H_DOSE <= 8 AND L_DOSE >= 7 AND MEDICINE = 2 AND GROUP = 1                       OR  MEDICINE ^= 2 AND GROUP ^= 1
 OBJECT  3  SCREEN   RO SCREEN                                                                           NE  'L'
;
RUN ;


DATA KERNEL.ENTRY ;
LENGTH CATALOG  $8 DATASET  $8 SCREEN $2 TABLE $8 TITLE $80
           LIBRARY  $8 TEMPLIB  $8 APPID  $8 PASSWORD $8 UINAME $8
           MODEID   $8 USERGRP  $10 OBJECTID $8 OPERTYPE $1 PROCID $8
           PROPERTY $1 ;
FORMAT CATALOG  $CHAR8. DATASET $CHAR8. SCREEN $CHAR2.
           TABLE $TABLE.  TITLE $CHAR80. LIBRARY $CHAR8.
           TEMPLIB $CHAR8. APPID $CHAR8.  PASSWORD $CHAR8.
           UINAME $CHAR8.  MODEID $CHAR8. USERGRP $CHAR10.
           OBJECTID $CHAR8.  OPERTYPE $CHAR1. PROCID $PROCESS.
           PROPERTY $CHAR1. ;
LABEL  CATALOG =  "SCREEN PROGRAM CATALOG NAME"
       DATASET =  "SAS DATA SET NAME"
       SCREEN  =  "SCREEN TYPE"
       TABLE   =  "TABLE NAME"
       TITLE   =  "TITLE"
       LIBRARY =  "SAS LIBRARY NAME"
       TEMPLIB =  "SAS LIBRARY NAME FOR TEMPORARY LOCATION"
       APPID   =  "APPLICATION IDENTIFICATION NAME"
       PASSWORD = "APPLICATION PASSWORD"
       UINAME   = "USER INTERFACE IDENTIFICATION NAME"
       MODEID   = "MODE IDENTIFICATION NAME"
       USERGRP  = "USER GROUP IDENTIFICATION NAME"
       OBJECTID = "APPLICATION OBJECT IDENTIFICATION NAME"
       OPERTYPE = "TYPE OF OPERATION (E OR B)"
       PROCID   = "PROCESS IDENTIFICATION NAME"
       PROPERTY = "APPLICATION OBJECT PROPERTY (T OR P)" ;
RUN ;





