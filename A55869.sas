/*-------------------------------------------------------------------*
  * PROGRAMMING TECHNIQUES FOR OBJECT-BASED STATISTICAL ANALYSIS      *
  *                         WITH SAS SOFTWARE                         *
  *               by Tanya Kolosova &  Samuel Berestizhevsky          *
  *       Copyright(c) 1998 by SAS Institute Inc., Cary, NC, USA      *
  *-------------------------------------------------------------------*
  *                                                                   *
  * This material is  provided "as is" by SAS Institute Inc. There    *
  * are no warranties, express or  implied, as to merchantability or  *
  * fitness for a particular purpose regarding the materials or code  *
  * contained herein. The Institute is not responsible for errors     *
  * in this  material as it now exists or will exist, nor does the    *
  * Institute provide technical support for it.                       *
  *                                                                   *
  *-------------------------------------------------------------------*
  *                                                                   *
  * Questions or problem reports concerning this material may be      *
  * addressed to the authors, Tanya Kolosova & Samuel Berestizhevsky  *
  *                                                                   *
  * by electronic mail:                                               *
  *                                                                   *
  *        assc@netvision.net.il                                      *
  *                                                                   *
  * by ordinary mail:                                                 *
  *                                                                   *
  *        8 Lesham Street, Cluster 11, Caesarea, Israel              *
  *                                                                   *
  *-------------------------------------------------------------------*/
 /*

   This document describes the SAS macro and SCL programs included in
   the book "Programming Techniques for Object=Based Statistical 
   Analysis with SAS Software."
   Page references contained here indicate the pages in the book where 
   the programs are illustrated.

   **** In some cases there are minor differences between the programs 
   on this document and those in the book. These changes were made 
   to correct errors in original. The changes should not affect the
   results produced by the programs.****

 */
*****************************************************************************************
/*The following example code appears on page 46-47.*/
**************************************************

/*
  PROGRAM        _VDESCR
DESCRIPTION    Calculation of descriptive statistics for an object of the Vector class
USAGE          %_vdescr (object, outobj) ;
PARAMETERS     object ( the name of the statistical object of the Vector class
               outobj ( the name of the statistical object of the Vector Statistics 
               class containing calculated descriptive statistics
REQUIRES       The &libwork is a global macro variable defining the _SA_WORK library 
               that contains statistical objects
AUTHORS        T.Kolosova and S.Berestizhevsky.

*/
%macro _vdescr (object, outobj) ;
%if %upcase(&object) = NULL %then
%do ;
   %if &outobj ^= %then
   %do ;
/*
Creates an output object of the Vector Statistics class
*/
%action(object= &outobj, action = "Create", params
 = "&outobj") ;
/*
Calculates descriptive statistics
/*
     proc univariate data = &libwork..&object noprint ;
     var &object ;
     output out = _out_
     n = n
     nobs = nobs
     nmiss = nmiss
     min = min
     max = max
     range = range
     mean = mean
     var = var
     std = std
     mode = mode
     sum = sum
     kurtosis = kurtosis
     skewness = skewness
     p1 = p1
     p5 = p5
     p10 = p10
     q1 = q1
     q3 = q3
     median = median
     qrange = qrange
     p90 = p90
     p95 = p95


     p99 = p99 ;
     run ;

     proc transpose data = _out_  out = _out1_ ;
     run ;

     data _out_ (keep = name value) ;
        length name $20 value $80 ;
        set _out1_ ;
        if _n_ = 1 then do ;
           name = "object" ;
           value = "&object" ;
           output ;
        end ;
        name = _label_ ;
        value = col1 ;
        output ;
     run ;
/*
Writes descriptive statistics into the output object of the 
Vector Statistics class
*/
     %action(object= &outobj, action = "Put Elements",
             params = "_out_,  name, value") ;

   %end ;
   %else
   %do ;
     proc univariate data = &libwork..&object ;
     var &object ;
     run ;
   %end ;
%end ;
%mend ;



*****************************************************************************************
/*The following example code appears on page 48-49.*/
**************************************************
/*
PROGRAM      _DDESCR

DESCRIPTION  Calculation of descriptive statistics for an object of the Vector Discrete class

USAGE        %_ddescr (object, outobj) ;

PARAMETERS   object -- the name of the statistical object of the Vector Discrete class
             outobj -- the name of the statistical object of the Vector Statistics class 
             containing calculated descriptive statistics
REQUIRES     The &libwork is a global macro variable defining the _SA_WORK library that 
             contains statistical objects

AUTHORS      T.Kolosova and S.Berestizhevsky.
*/
%macro _ddescr (object, outobj) ;
%if %upcase(&object) = NULL %then
%do ;
*/
  Creates an output object of the Vector Statistics class
/*
%action(object= &outobj, action = "Create", params
 = "&outobj") ;
/*
  Calculates descriptive statistics
*/
     proc univariate data = &libwork..&object noprint ;
     var &object ;
     output out = _out_
     n = n
     nobs = nobs
     nmiss = nmiss
     min = min
     max = max
     range = range
     mean = mean
     var = var
     std = std
     mode = mode
     sum = sum
     kurtosis = kurtosis
     skewness = skewness
     p1 = p1
     p5 = p5
     p10 = p10
     q1 = q1
     q3 = q3
     median = median
     qrange = qrange
     p90 = p90
     p95 = p95
     p99 = p99 ;
     run ;

     proc transpose data = _out_  out = _out1_ ;
     run ;

     data _out_ (keep = name value) ;
        length name $20 value $80 ;
        set _out1_ ;
        if _n_ = 1 then do ;
           name = "object" ;
           value = "&object" ;
           output ;
        end ;
        name = _label_ ;


/*
  Corrects the results of PROC UNIVARIATE so that they reflect
  the discrete nature of the data
*/
        if upcase(_name_) = "MEAN" then
           col1 = int(col1) ;
        value = col1 ;
        output ;
     run ;
/*
  Writes descriptive statistics into the output object of the
  Vector Statistics class
*/
     %action(object= &outobj, action = "Put Elements",
             params = "_out_,  name, value") ;

%end ;
%mend ;


*****************************************************************************************
/*The following example code appears on page 53-54.*/
**************************************************
/*
PROGRAM       _TDESCR
DESCRIPTION   Calculation of descriptive statistics for an object of the Data Table class
USAGE         %_tdescr (object, element, by, outobj) ;
PARAMETERS    object -- the name of the statistical object of the Data Table class
              element -- the name of the object element that must be processed
              by -- the name of the object element that is used as grouping key
              outobj -- the name of the statistical object of the Table Statistics class 
              containing calculated descriptive statistics
REQUIRES      The &libwork is a global macro variable defining the _SA_WORK library that contains statistical objects
AUTHORS       T.Kolosova and S.Berestizhevsky.
*/
%macro _tdescr(object, element, by, outobj) ;

%if %upcase(&object) ^= NULL %then
%do ;
   %if &outobj ^= %then
   %do ;
      %action(object= &outobj, action = "create",
              params = "&outobj") ;
      proc sort data = &libwork..&object out = &object;
      by &by;
      run;

      proc univariate data = &object noprint ;
      var &element ;
      by &by;
      output out = _out_
         n = n
         nobs = nobs
         nmiss = nmiss
         min = min
         max = max
         range = range
         mean = mean
         var = var
         std = std
         mode = mode
         sum = sum
         kurtosis = kurtosis
         skewness = skewness
         p1 = p1
         p5 = p5
         p10 = p10
         q1 = q1
         q3 = q3
         median = median
         qrange = qrange
         p90 = p90
         p95 = p95
         p99 = p99 ;
      run ;



      proc transpose data = _out_  out = _out1_ ;
      var &element ;
      by &by;
      run ;

      data _out_ (keep = &by name value) ;
         length name $20 value $80 ;
        set _out1_ ;
        if _n_ = 1 then do ;
           name = "object" ;
           value = "&object" ;
           output ;
           name = "element" ;
           value = "&object" ;
           output ;
        end ;
        name = _label_ ;
        value = col1 ;
        output ;
     run ;

     %action(object= &outobj, action = "Put Elements",
             params = "_out_, &by, name, value") ;

   %end ;
   %else
   %do ;
     proc univariate data = &libwork..&object ;
     var &element ;
     by &by;
     run ;
   %end ;
  %end ;
%mend ;

 
*****************************************************************************************
/*The following example code appears on page 62-63.*/
**************************************************
 
/*
PROGRAM        ANOVA
DESCRIPTION    Analysis of variance for the specified model
USAGE          %_anova (object, model, class, by, weight, outobj) ;
PARAMETERS     object -- the name of the statistical object of the Data Table
               class model -- names the dependent variables and independent effects
               class -- "yes" or "no" value that tells whether to use classification variables in the analysis
               by -- the name of the object element that is used as grouping key
               weight -- "yes" or "no" value that tells whether to use weighting or not
               outobj -- the name of the statistical object of the List class containing results of ANOVA
REQUIRES       The &libwork is a global macro variable defining the _SA_WORK library that contains statistical objects
AUTHORS        T.Kolosova and S.Berestizhevsky.
*/
%macro _anova(object, model, class, by, weight, outobj);

  %if %upcase(&object) = NULL %then
       %goto err_exit ;

  %let model =
  %substr(%bquote(&model),2,%eval(%length(&model)-2)) ;
  %let classif = ;
  %let freq = ;
  %let weight = :

  data _null_ ;
     set &libref..statobj (where=(left(upcase(statobj))
        = upcase(left("&object"))
        and left(upcase(class)) = "ANOVA"));
     if attr_no = 2 then call symput("classif",
     classif);
     if attr_no = 3 then call symput("freq", freq);
     if attr_no = 4 then call symput("weight", weight);
  run;

  proc glm data = &libwork..&object
     %if &outobj ^= %then %do;
        outstat = _stat_ noprint
     %end;
     ;
     %if %upcase(&class) = YES and &classif ^= %then
     %do ;
        class &classif ;
     %end ;

     %if &freq ^= %then %do ;
        freq &freq  ;
     %end ;
     %if %upcase(&weight) = YES and
                 &weight ^= %then %do ;
        weight &weight  ;
     %end ;



     %if &by ^= %then
     %do ;
        by &by ;
     %end ;
     model &model ;
     %if &outobj ^= %then %do;
        output out = _out_
           P=P
           R=R
           L95M=L95M
           U95M=U95M
           L95=L95
           U95=U95
           STDP=STDP
           STDR=STDR
           STDI=STDI
           STUDENT=STUDENT
           COOKD=COOKD
           H=H
           PRESS=PRESS
           RSTUDENT=RSTUDENT
           DFFITS=DFFITS
           COVRATIO=COVRATIO  ;
     %end;
  run;
  quit;

  %if &outobj ^= %then %do;
     %let actual = %scan(&model,1,=);

     data _out_;
          set _out_ (keep = &actual
           %if &by ^= %then %do;
              &by
           %end ;
           P R L95M U95M L95 U95 STDP STDR STDI STUDENT
           COOKD H PRESS RSTUDENT DFFITS COVRATIO,
           rename = (&actual = actual
           %if &by ^= %then %do;
              &by = bygroup
           %end;
           ));
          if actual ^= . ;
     run;

     data _stat_ (drop = _name_ _source_ _type_);
        set _stat_ (where = (_type_ = "SS1")
           %if &by ^= %then %do;
              rename = (&by = bygroup)
           %end;
           );
     run;
     proc transpose data = _stat_ (drop = _name_
     _source_ _type_)
     out = _stat1_ (rename = (col1 = statval _name_ =
     statname)
        drop = _label_);
        %if &by ^= %then %do;
           by bygroup;
        %end ;
     run;

     %action(object = &outobj,action="Put Elements",
        params="_stat1_,_out_") ;
  %end;
%err_exit :
%mend ;


*****************************************************************************************
/*The following example code appears on page 86.*/
**************************************************
/*
PROGRAM        ACTION
DESCRIPTION    The macro implementing methods invocation mechanism.
USAGE          %action(object = object, action = action, params = params);
PARAMETERS
REQUIRES       The &libref macro variable is a global macro variable that contains the name of the 
               SAS library where the data dictionary tables are located.
               The &libwork macro variable is a global macro variable that contains the name of the 
               SAS library where the created statistical objects are located. In the book this 
               library is called _SA_WORK
AUTHORS        T.Kolosova and S.Berestizhevsky.
*/
%macro action(object = object, action = action, params = params);
       %let class = ;
       %let method = ;
       %let status = 0 ;
       %let dsexist = 0 ;
        %let action =  %substr(%bquote(&action), 2,
                       %eval(%length(&action)-2)) ;
       data _null_ ;
          set &libref..StatObj (where = (upcase(statobj)
          = upcase("&object"))) ;
          call symput("class", class) ;
       run ;

       data _null_ ;
          set &libref..ClassMet (where = (upcase(class)
          = upcase("&class") and
          upcase(action) = upcase("&action"))) ;
          call symput("method", method) ;
       run ;

       data _null_ ;
          set &libref..Status (where =
             (upcase(statobj) = upcase("&object") and
              upcase(class) = upcase("&class"))) ;
          call symput("status", 1) ;
       run ;

       %if &status = 1 %then
       %do ;
          proc sql noprint;
            select count(*)
            into : dsexist from dictionary.members
            where   (libname ? upcase("&libwork"))
                  & (memname ? upcase("&object" ))
                  & (memtype ? "DATA");
          quit;

          %if &dsexist = 0 %then
              %let object = NULL ;
       %end ;
       %if &status = 0 %then
           %let object = NULL ;

       %&method (&object, %substr(%bquote(&params), 2,
                 %eval(%length(&params)-2))) ;
  %mend ;


*****************************************************************************************
/*The following example code appears on page 88-91.*/
**************************************************

/*
PROGRAM         _MCREATE
DESCRIPTION     Creation of matrix object
USAGE           %_mcreate (object, newobj) ;
PARAMETERS      object and newobj  -- both contain the name of the object of the Matrix class that
                must be created. If %_mcreate macro is invoked by the %ACTION macro, the object 
                parameter may contain the "NULL" value (see explanation of the parameters in 
                the  "Create action" section in chapter 4)
REQUIRES        The &libref and &libwork are global macro variables that contain the SAS library 
                names for data dictionary tables and for statistical objects.
AUTHORS         T.Kolosova and S.Berestizhevsky.
*/
  %macro _mcreate (object, newobj) ;
/*
  Checks correctness of definition of of the matrix object
*/

   %local aval1 aval2 ;
   %let attr_no = 0 ;
   %let aval1 = 0 ;
   %let aval2 = 0 ;
   %let exit = 0 ;
   %let vc_obj =  ;
/*
Gets the attributes of the object defined in the StatObj table
*/



   data _null_ ;
      retain i 0 ;
      set &libref..Statobj (where =
         (upcase(left(statobj)) =
          upcase(left("&newobj")))) ;
      call symput("attr_no", left(attr_no)) ;
      call symput("aval" || left(attr_no),
                  left(attr_val)) ;
      if attr_no > i+1 then
      do ;
         do j = i+1 to attr_no - 1 ;
            call symput("aval" || left(j), " ");
         end;
      end ;
      i = attr_no ;
   run;
/*
  Analyzes the attributes
*/

   %let v_obj_no = 0 ;

   data _null_;
      length tmp $80;
      if symget("attr_no") < 1 or
         symget("attr_no") > 2 then
         link err_exit;
      if trim(symget("aval1")) = "" then
         link err_exit;
      tmp = scan(symget("aval1"), 1 , " ");
      if length(trim(tmp)) <
         length(trim(symget("aval1")))
      then do;
         i = 1;
         do while (trim(tmp) ^= "") ;
            call symput("vobj" || left(i),
                        left(trim(tmp)));
            i+1;
            tmp = scan(symget("aval1"), i ," ");
         end ;
         call symput("v_obj_no", left(i-1));
      end;
      else
      call symput("vc_obj",
           left(trim(symget("aval1")))) ;
      if symget("attr_no") = 2 then
      do;
         if trim(symget("aval2")) = "" then
            call symput("aval2", 0) ;
      end ;
      return ;
   err_exit:
      call symput("exit",1) ;
      stop ;
   return ;
   run;

   %if &exit = 1 %then %goto err_exit ;
/*
  Analyzes the attributes' values
*/

   %if &vc_obj ^= %then
   %do ;
      data _null_;
         set &libref..Statobj (where =
    upcase(left(statobj)) = upcase(left("&vc_obj")));

     if upcase(left(class)) ^= "VECTOR CHARACTER" then
              call symput("exit", 1);
      run ;
      %if &exit = 1 %then %goto err_exit;
/*
Call  the Get Elements action for the Vector Character object
      %action(object = &vc_obj, action = "Get Elements",
              params =
                "outobj, statobj");
*/

      data outobj ;
         set outobj ;
         statobj = left(upcase(statobj)) ;
      run;
   %end;
   %else
   %do;
      %if &v_obj_no < 2 %then %goto err_exit;

      data outobj;
         length statobj $8 ;
         %do i = 1 %to &v_obj_no;
            statobj = left(upcase("&&vobj&i")) ;
            output;
         %end;
      run;
   %end;
   proc sort data = &libref..statobj out = statobj
   (keep = statobj class)
   nodupkey;
   by statobj;
   run;

   data statobj;
      set statobj;
      statobj = left(upcase(statobj));
   run ;

   proc sort data = outobj;
   by statobj;
   run;

   data outobj(keep = statobj class);
      merge statobj (in = left) outobj (in=right);
      by statobj;
      if right;
   run ;

   %let v_obj_no = 0;
   data _null_;
      set outobj;
      retain v_obj_no 0;
      v_obj_no + 1;
      if upcase(left(class)) ^= "VECTOR" then
      do ;
         call symput("exit",1);
         stop;
      end;
      call symput("v_obj_no", left(v_obj_no));
      call symput("vobj" || left(v_obj_no), statobj);
   run;

  %if &exit = 1 or &v_obj_no = 0 %then %goto err_exit;
/*
  Creates all vector objects
*/



   %do i = 1 %to &v_obj_no;
     %action(object = &&vobj&i, action = "Create",
             params = "&&vobj&i");
   %end;
/*
  Creates the matrix object
*/

   data &libwork..&newobj ;
      %do i = 1 %to &v_obj_no;
         set &libwork..&&vobj&i ;
      %end;
      %if &aval2 > 0 %then
      %do;
         (obs = &aval2)
      %end;
      ;
   run;
/*
Updates the Status table if an object with such a name exists
*/

   %if %upcase(&object) = %upcase(&newobj) %then
   %do;
      data &libref..status ;
         set &libref..status ;
         if upcase(left(statobj)) =
            upcase(left("&newobj")) then
            class = "Matrix";
      run;
   %end;
   %else %do ;
      data &libref..status ;
         set &libref..status (in = last);
         output;
         if _n_ = last then
         do;
            statobj = upcase(left("&newobj"))  ;
            class = "Matrix";
            output;
         end;
      run;
   %end ;

%err_exit:
%mend ;


*****************************************************************************************
/*The following example code appears on page 92-93.*/
**************************************************

/*
PROGRAM       _VHIST
DESCRIPTION   Calculation of empirical distribution and creation of histogram for object of the Vector class
USAGE         %_vhist (object, outobj, outdev) ;
PARAMETERS    object -- the name of the statistical object of the Vector class
              outobj -- the name of the statistical object of the Vector Statistics class containing
              calculated descriptive statistics
              outdev -- the name of the output device for histogram. If outdev contains the name of 
              the file, then %_vhist macro will save the produced histogram as picture in the GIF format.
REQUIRES      The &libwork is a global macro variable defining the _SA_WORK library that contains statistical objects
AUTHORS       T.Kolosova and S.Berestizhevsky.
*/
%macro _vhist (object, outobj, outdev) ;

   %if %upcase(&object) = NULL %then
      %goto err_exit;

   %if &outdev ^= %then
   %do;
      %if %upcase(&outdev) ^= SCREEN %then
         filename outgif "&outdev" ; ;
      goptions reset=global
      norotate hpos=0 vpos=0
      %if %upcase(&outdev) ^= SCREEN %then
      %do ;
            device = imggif
            gsfname = outgif
            gsfmode = replace
            gsflen = 80
            gaccess = sasgastd
      %end ;
      cback= white
      ctext = black
      ftext=SWISSL
      interpol=join
      graphrc
      display ;

      pattern1 value=SOLID;
      axis1
         color=blue
         width=2.0 ;
      axis2
         color=blue
         width=2.0 ;
   %end ;

   proc capability data = &libwork..&object graphics
      %if &outobj ^= %then %do;
         noprint
      %end;
      ;
      var &object ;
      histogram &object /
      %if &outobj ^= %then %do;
         outhistogram = _out_
      %end;
      %if %upcase(&outdev) = %then %do;
         noplot
      %end;
      ;
   run ;

   %if &outobj ^= %then
   %do;

      data _null_;
         set &libwork..&object nobs = last;
         length min max 8 ;
         retain min max ;
         if _n_ = 1 then
         do;
            min = &object;
            max = &object;
         end;
         if min > &object then min = &object;
         if max < &object then max = &object;
         if _n_ = last then
         do ;
            call symput("min", min);
            call symput("max", max);
            call symput("obs", _n_);
         end ;
      run;

      data _out1_ (keep = left right value cumvalue
                   freq cumfreq);
         set _out1_;
         length left right value cumvalue freq cumfreq
                delta 8;
         retain delta cumvalue cumfreq 0 ;
         if _n_ = 1 then
         do;
            delta = _midpt_ - min ;
         end;
         left = _midpt_ - delta ;
         right = _midpt_ + delta ;
         value = _obspct_ * &obs ;
         cumvalue + value ;
         freq = _obspct_;
         cumfreq + freq;
      run;
/*
  Creates and fills in the output object of the Vector
  Distribution class
*/
    %action(object = &outobj, action = "Create",
     params = "&outobj");
    %action(object = &outobj, action = "Put
     Elements", params = "_out1_, left, right, value,
     cumvalue, freq, cumfreq");
   %end ;
%err_exit:
%mend ;


*****************************************************************************************
/*The following example code appears on page 95-96.*/
**************************************************

/*
PROGRAM       _MPLOT
DESCRIPTION   Creation of scatter plot for object of the Matrix class
USAGE         %_mplot (object, axisx, axisy, outdev) ;
PARAMETERS    object -- the name of the statistical object of the Matrix class
              axisx -- the name of the object element that is used for X axis
              axisy -- the name of the object element that is used for Y axis
              outdev -- the name of the output device for plot. If outdev contains the name of the 
              file, then %_mplot macro will save the produced plot as picture in the GIF format.
REQUIRES      The &libwork is a global macro variable defining the _SA_WORK library that contains statistical objects
AUTHORS       T.Kolosova and S.Berestizhevsky.
*/
%macro _mplot (object, axisx, axisy, outdev) ;

   %if %upcase(&object) = NULL %then
      %goto err_exit ;

   %if %upcase(&outdev) ^= SCREEN %then
         filename outgif "&outdev" ; ;
   goptions reset=global
   norotate hpos=0 vpos=0
   %if %upcase(&outdev) ^= SCREEN %then
   %do ;
         device = imggif
         gsfname = outgif
         gsfmode = replace
         gsflen = 80
         gaccess = sasgastd
   %end ;
   cback = white
   ctext = black
   ftext = SWISSL
   interpol = none
   graphrc
   display ;

   pattern1 value = SOLID;
   axis1
      color=blue
      width=2.0 ;
   axis2
      color=blue


      width=2.0 ;
symbol1 c = blue
   i = none
   l = 1
   v = STAR
   cv = blue ;

proc gplot data= &libwork..&object ;
   plot &axisy * &axisx /
      haxis=axis1
      vaxis=axis2
      frame ;
run;
quit;

%err_exit :
%mend ;




*****************************************************************************************
/*The following example code appears on page 97-98.*/
**************************************************
/*
PROGRAM        _MODEL
DESCRIPTION    Fitting of a model to experimental data
USAGE          %_model (object, model, outobj) ;
PARAMETERS     object -- the name of the statistical object of the Model class
               mode -- the model to be fitted
               outobj -- the name of the object of the List class containing the 
               results of the model fitting
REQUIRES       The &libwork is a global macro variable defining the _SA_WORK library that contains statistical objects
AUTHORS        T.Kolosova and S.Berestizhevsky.
*/
%macro _model(object, model, outobj);

  %if %upcase(&object) = NULL %then
       %goto err_exit ;

 %let model =
 %substr(%bquote(&model),2,%eval(%length(&model)-2)) ;

   proc reg data = &libwork.&object
      %if &outobj ^= %then %do;
         outest = _stat_ noprint
      %end;
      ;
      model &model ;
      %if &outobj ^= %then %do;
         output out = _out_
         P=P
         R=R
         L95M=L95M
         U95M=U95M
         L95=L95
         U95=U95
         STDP=STDP
         STDR=STDR
         STDI=STDI
         STUDENT=STUDENT
         COOKD=COOKD
         H=H
         PRESS=PRESS
         RSTUDENT=RSTUDENT
         DFFITS=DFFITS
         COVRATIO=COVRATIO;
      %end;
   run;
   quit;

   %if &outobj ^= %then %do;
      %let actual = %scan(&model,1,=);

      data _out_;
         set _out_ (keep = &actual
            P R L95M U95M L95 U95 STDP STDR STDI STUDENT
            COOKD H PRESS RSTUDENT DFFITS COVRATIO
            rename = (&actual = actual));
         if actual ^= .;
      run;



      proc transpose data = _stat_
      (drop = _model_ _type_ _depvar_ intercep &actual)
      out = _stat1_ (rename = (col1 = statval _name_ =
      statname) drop = _label_);
      run;

      %action(object = &outobj,action="Put Elements",
                      params="_stat1_,_out_");
   %end;
   %err_exit:
%mend;



*****************************************************************************************
/*The following example code appears on page 117-119.*/
**************************************************

/*
PROGRAM        _RTLAGS
DESCRIPTION    Producing of lagged scatter plots of an object of the Regular Time Series class
USAGE          %_rtlags (object, element, outdev) ;
PARAMETERS     object -- the name of the statistical object of the Regular Time Series class
               element -- the name of the column of the statistical object
               outdev -- the name of the output device for plot. If outdev contains the name 
               of the file, then %_rtlags macro will save the produced plot as picture in the GIF format.
REQUIRES       The &libwork is a global macro variable defining the _SA_WORK library that contains statistical objects
AUTHORS        T.Kolosova and S.Berestizhevsky.
*/
%macro _rtlags (object, element, outdev) ;

   %if %upcase(&object) = NULL %then
      %goto err_exit ;
   %let lagsnum = 4 ;
   proc catalog c = work.gseg kill ;
   run ;
   quit ;

   %if %upcase(&outdev) ^= SCREEN %then
         filename outgif "&outdev" ; ;

   goptions reset=global
   norotate hpos=0 vpos=0
   %if %upcase(&outdev) ^= SCREEN %then
   %do ;
         device = imggif
         gsfname = outgif
         gsfmode = replace
         gsflen = 80
         gaccess = sasgastd
   %end ;
   cback = white
   ctext = black
   ftext = SWISSL
   interpol = none
   graphrc
   display ;

   pattern1 value = SOLID;
   axis1
      color=blue
      width=2.0 ;
   axis2
      color=blue
      width=2.0 ;

   symbol1 c = blue
   i = none
   l = 1
   v = STAR
   cv = blue ;



   %do i = 1 %to &lagsnum ;
       %let dsid=%sysfunc(open(&libwork..&object,i));
       %if &dsid %then
       %do;
           %let len=%sysfunc(varlen(&dsid,
                    %sysfunc(varnum(&dsid,&element))));
           %let rc=%sysfunc(close(&dsid));
       %end;

       data lag&i ;
          set &libwork..&object ;
          length lag&i &len ;
          lag&i = lag&i(&element) ;
       run ;

       title2 "Lagged Scatterplots: Lag = &i" ;

       proc gplot data= lag&i ;
       plot &element * lag&i /
       haxis=axis1
       vaxis=axis2
       frame ;
       run;
       quit;
   %end ;

   %do i = 1 %to &lagsnum ;
      data _null_;
         length grnum 8 ;
         grnum = symget('lagsnum');
         if grnum = 1 then do;
                call symput("_xl1",left(0));
                call symput("_xr1",left(100));
                call symput("_yl1",left(0));
                call symput("_yu1",left(100));
                return;
         end;
         if mod(grnum, 2) > 0 then
              grnum + 1 ;
         stop = 0;
         cols = 1;
         lines = grnum;
         do until(stop);
               c = cols * 2;
               if (floor(grnum/c))*c ^= grnum then
               do;
                  stop = 1;
                  lines = grnum/cols ;
               end;
               else do;
                   l = grnum/c;
                   if (c > l) then
                       stop = 1;
                   else do;
                       cols = c;
                       lines = l;
                   end;
               end;
         end;
         width = 100/cols;
         height = 100/lines;
         c = 0 ;
         do i = 1 to lines;
             do j = 1 to cols;
                c + 1 ;
      call symput("_xl"||left(c),left((j-1) * width));
      call symput("_xr"||left(c),left(j * width));
      call symput("_yl"||left(c),left((i-1) * height));
      call symput("_yu"||left(c),left(i * height));
             end ;
         end;
       run;

       proc greplay tc = work.gseg nofs
          igout= work.gseg ;
          tdef tempspc
          %do k = 1 %to &lagsnum;
             &k/
             llx=&&_xl&k lly=&&_yl&k
             ulx=&&_xl&k uly=&&_yu&k
             urx=&&_xr&k ury=&&_yu&k
             lrx=&&_xr&k lry=&&_yl&k
          %end; ;

          template tempspc ;
          treplay
            1:gplot
          %do i=2 %to &lagsnum ;
             %let k = %eval(&i - 1);
             %if &k < 10 %then
             %do ;
                 &i:gplot&k
             %end ;
             %else %do;
                 &i:gplot&k
             %end;
          %end ; ;
        run;
        quit ;
    %end;

  %err_exit :
%mend ;


*****************************************************************************************
/*The following example code appears on page 122.*/
**************************************************
 
/*
PROGRAM       _RTAUTO
DESCRIPTION   Producing of autocorrelation function plot of an object of the Regular Time Series class
USAGE         %_rtauto (object, element) ;
PARAMETERS    object -- the name of the statistical object of the Regular Time Series class
              element -- the name of the column of the statistical object
REQUIRES      The &libwork is a global macro variable defining the _SA_WORK library that contains 
              statistical objects
AUTHORS       T.Kolosova and S.Berestizhevsky.
*/
%macro _rtauto (object, element) ;

   %if %upcase(&object) = NULL %then
         %goto err_exit ;
   proc arima data = &libwork..&object ;
   identify var = &element ;
   run ;
   quit ;

  %err_exit :
%mend ;



*****************************************************************************************
/*The following example code appears on page 125.*/
**************************************************

/*
PROGRAM       _RTDIFF
DESCRIPTION   Producing autocorrelation function plot of differenced data for an object of the Regular Time Series class
USAGE         %_rtdiff(object, element, lperiod, rperiod) ;
PARAMETERS    object -- the name of the statistical object of the Regular Time Series class
              element -- the name of the column of the statistical object
              lperiod -- the left value of differencing interval
              rperiod -- the right value of differencing interval
REQUIRES      The &libwork is a global macro variable defining the _SA_WORK library that contains statistical objects
AUTHORS       T.Kolosova and S.Berestizhevsky.
*/
%macro _rtdiff (object, element, lperiod, rperiod) ;

   %if %upcase(&object) = NULL %then
      %goto err_exit ;
  proc arima data = &libwork..&object ;
  identify var = &element (&lperiod,&rperiod)  ;
  run ;
  quit ;

  %err_exit :
%mend ;


*****************************************************************************************
/*The following example code appears on page 128.*/
**************************************************
/*
PROGRAM
_RTARM
DESCRIPTION
Estimating of parameters of the ARIMA model to fit time series object of the Regular Time Series.
USAGE
%_rtarm(object, element, model, lperiod, rperiod) ;
PARAMETERS
object - the name of the statistical object of the Regular Time Series class
element - the name of the column of the statistical object model -- is the specification of model to fit
lperiod - the left value of differencing interval
rperiod - the right value of differencing interval
REQUIRES
The &libwork is a global macro variable defining the _SA_WORK library that contains statistical objects
AUTHORS
T.Kolosova and S.Berestizhevsky.
*/
%macro _rtarm (object, element, model, lperiod,
               rperiod) ;

   %if %upcase(&object) = NULL %then
       %goto err_exit ;
   %let model =  %substr(%bquote(&model),2,
                          %eval(%length(&model)-2)) ;
   proc arima data = &libwork..&object ;
   %if &lperiod = or &rperiod = %then %do ;
         identify var = &element ;
   %end ;
   %else %do ;
         identify var = &element (&lperiod,&rperiod)  ;
   %end ;
   e &model;
   run ;
   quit ;

   %err_exit :
%mend ;

******************************************************************
 * The following code is used by the macro mentioned in ClassMet  *
 * table on page 33.                                              *
 ******************************************************************/


/*  PROGRAM         _BCREATE
    DESCRIPTION     Create an object of the Vector Logic class
    USAGE           %_bcreate (object, newobj) ;     
    PARAMETERS      object and newobj  -- both contain the name of the object of the 
                    Vector Logic class that must be created. If %_fcreate macro is 
                    invoked by the %ACTION macro, the object parameter may contain the 
                    "NULL" value (see explanation of the parameters in the 
                    "Create action" section in Chapter 4). 
    REQUIRES        The &libref and &libwork are global macro variables. The &libref 
                    contains the SAS library name for data dictionary tables. 
                    The &libwork contains the name of the SAS library where the created 
                    statistical objects are located. In the book this library called 
                    _SA_WORK.
    AUTHORS         T.Kolosova and S.Berestizhevsky.        
*/              


%macro _bcreate (object, newobj) ;

/* check correctness of definition of the vector object */
   %local aval1 aval2 aval3 ;
   %let attr_no = 0;
/* number of attributes */
   %let aval1 = 0 ;
   %let aval2 = 0 ;
   %let aval3 = 0 ;

/* get the attributes of the object from the StatObj table */
   data _null_;
      retain i 0;
      set &libref..statobj (where = (upcase(left(statobj)) = upcase(left("&newobj"))));
      call symput("attr_no", left(attr_no));
      call symput("aval" || left(attr_no), left(attr_val));
      if attr_no > i+1 then
      do ;
         do j = i+1 to attr_no - 1 ;
            call symput("aval"||left(j), " ");
         end;
      end ;
      i = attr_no ;
   run;

/* analyze the attributes */
   %let exit = 0;

   data _null_;
      length tmp $80;

/* analyze number of parameters */
      if symget("attr_no") < 1 or symget("attr_no") > 4 then
         link err_exit;

/* analyze the first parameter */
      if trim(symget("aval1")) = "" or length(left(symget("aval1"))) > 8 then
         link err_exit;

/* analyze the second parameter */
      if symget("attr_no") < 2 then
         link err_exit;
      else do;
         if trim(symget("aval2")) = "" or length(left(symget("aval2"))) > 8 then
            link err_exit;
      end;

/* analyze the third parameter */
      if symget("attr_no") > 2 then
      do;
         if trim(symget("aval3")) = "" then
            call symput("aval3", "0");
      end;

      return ;
   err_exit:
      call symput("exit",1);
      stop;
   return;

   run;

   %if &exit = 1 %then %goto err_exit;

/* analyze the attributes' values */

/* search for the data object */
   %let dataset = ;

   data _null_;
      set &libref..Object (where = (upcase(left(trim(table))) = upcase(left(trim("&aval1")))));
      call symput("dataset", dataset);
   run;

   %if &dataset = %then %goto err_exit;

/* search for the dataset location */
   %let location = ;

   data _null_;
      set &libref..Location (where = (upcase(left(trim(table))) = upcase(left(trim("&aval1")))));
      call symput("location", library);
   run;

   %if &location = %then %goto err_exit;

/* search for the dataset column */
   %let column = ;

   data _null_;
      set &libref..Property (where = (upcase(left(trim(table))) = upcase(left(trim("&aval1"))) and
         left(trim(upcase(column))) = left(trim(upcase("&aval2")))));
      call symput("column", column);
   run;

   %if &column = %then %goto err_exit;

/* check if the data object exists */
   %let dsexist = 0;
   proc sql noprint;
      select count(*)
      into : dsexist from dictionary.members
      where (upcase(libname) ? upcase("&location"))
            & (upcase(memname) ? upcase("&dataset" ))
            & (upcase(memtype) ? "DATA");
   quit;
   %if &dsexist = 0 %then %goto err_exit ;

   proc contents data = &location..&dataset
   noprint out = columns short;
   run;

   %let column = ;
   data _null_;
      set columns (where = (left(trim(upcase(name))) = left(trim(upcase("&aval2")))));
      call symput("column", name);
   run;
   %if &column = %then %goto err_exit;

/* create the Vector object */
   data &libwork..&newobj (keep = &newobj) ;
      set &location..&dataset (rename = (&column = &newobj)
      %if &aval3 > 0 %then %do;
         obs = &aval3
      %end ;
      );
   run;

/* update the status table */
/* if an object with such a name exists */
   %if %upcase(&object) = %upcase(&newobj) %then
   %do;
      data &libref..Status ;
         set &libref..Status ;
         if upcase(left(statobj)) = upcase(left("&newobj"))
         then
            class = "Vector Logical";
      run;
   %end;
   %else %do ;
      data &libref..Status ;
         set &libref..Status (in = last);
         output;
         if _n_ = last then
         do;
            statobj = upcase(left("&newobj"))  ;
            class = "Vector Logical";
            output;
         end;
      run;
   %end ;

%err_exit:
%mend ;


/******************************************************************
 * The following code is used by the macro mentioned in ClassMet  *
 * table on page 33.                                              *
 ******************************************************************/


/*  PROGRAM         _CCREATE
    DESCRIPTION     Create an object of the Vector Character class
    USAGE           %_ccreate (object, newobj) ;     
    PARAMETERS      object and newobj  -- both contain the name of the object of the 
                    Vector Character class that must be created. If %_fcreate macro is 
                    invoked by the %ACTION macro, the object parameter may contain the 
                    "NULL" value (see explanation of the parameters in the 
                    "Create action" section in Chapter 4). 
    REQUIRES        The &libref and &libwork are global macro variables. The &libref 
                    contains the SAS library name for data dictionary tables. 
                    The &libwork contains the name of the SAS library where the created 
                    statistical objects are located. In the book this library called 
                    _SA_WORK.
    AUTHORS         T.Kolosova and S.Berestizhevsky.        
*/              

%macro _ccreate (object, newobj) ;

/* check correctness of definition of the vector character object */
   %local aval1 aval2 aval3 aval4 ;
   %let attr_no = 0;
/* number of attributes */
   %let aval1 = 0 ;
   %let aval2 = 0 ;
   %let aval3 = 0 ;
   %let aval4 = 0 ;

/* get the attributes of the object from the StatObj table */
   data _null_;
      retain i 0;
      set &libref..statobj (where = (upcase(left(statobj)) = upcase(left("&newobj"))));
      call symput("attr_no", left(attr_no));
      call symput("aval" || left(attr_no), left(attr_val));
      if attr_no > i+1 then
      do ;
         do j = i+1 to attr_no - 1 ;
            call symput("aval"||left(j), " ");
         end;
      end ;
      i = attr_no ;
   run;

/* analyze the attributes */
   %let exit = 0;

   data _null_;
      length tmp $80;

/* analyze number of parameters */
      if symget("attr_no") < 1 or symget("attr_no") > 4 then
         link err_exit;

/* analyze the first parameter */
      if trim(symget("aval1")) = "" or length(left(symget("aval1"))) > 8 then
         link err_exit;

/* analyze the second parameter */
      if symget("attr_no") < 2 then
         link err_exit;
      else do;
         if trim(symget("aval2")) = "" or length(left(symget("aval2"))) > 8 then
            link err_exit;
      end;

/* analyze the third parameter */
      if symget("attr_no") > 2 then
      do;
         if trim(symget("aval3")) = "" then
            call symput("aval3", "0");
      end;


      return ;
   err_exit:
      call symput("exit",1);
      stop;
   return;

   run;

   %if &exit = 1 %then %goto err_exit;

/* analyze the attributes' values */

/* search for the data object */
   %let dataset = ;

   data _null_;
      set &libref..Object (where = (upcase(left(trim(table))) = upcase(left(trim("&aval1")))));
      call symput("dataset", dataset);
   run;

   %if &dataset = %then %goto err_exit;

/* search for the dataset location */
   %let location = ;

   data _null_;
      set &libref..Location (where = (upcase(left(trim(table))) = upcase(left(trim("&aval1")))));
      call symput("location", library);
   run;

   %if &location = %then %goto err_exit;

/* search for the dataset column */
   %let column = ;

   data _null_;
      set &libref..Property (where = (upcase(left(trim(table))) = upcase(left(trim("&aval1"))) and
         left(trim(upcase(column))) = left(trim(upcase("&aval2")))));
      call symput("column", column);
   run;

   %if &column = %then %goto err_exit;

/* check if the data object exists */
   %let dsexist = 0;
   proc sql noprint;
      select count(*)
      into : dsexist from dictionary.members
      where (upcase(libname) ? upcase("&location"))
            & (upcase(memname) ? upcase("&dataset" ))
            & (upcase(memtype) ? "DATA");
   quit;
   %if &dsexist = 0 %then %goto err_exit ;

   proc contents data = &location..&dataset
   noprint out = columns short;
   run;

   %let column = ;
   data _null_;
      set columns (where = (left(trim(upcase(name))) = left(trim(upcase("&aval2")))));
      call symput("column", name);
   run;
   %if &column = %then %goto err_exit;

/* create the Vector Character object */
   data &libwork..&newobj (keep = &newobj) ;
      set &location..&dataset (rename = (&column = &newobj)
      %if &aval3 > 0 %then %do;
         obs = &aval3
      %end ;
      );
      %if &aval4 ^= %then %do;
         format &newobj &aval4 ;
      %end ;

   run;

/* update the status table */
/* if an object with such a name exists */
   %if %upcase(&object) = %upcase(&newobj) %then
   %do;
      data &libref..Status ;
         set &libref..Status ;
         if upcase(left(statobj)) = upcase(left("&newobj"))
         then
            class = "Vector Character";
      run;
   %end;
   %else %do ;
      data &libref..Status ;
         set &libref..Status (in = last);
         output;
         if _n_ = last then
         do;
            statobj = upcase(left("&newobj"))  ;
            class = "Vector Character";
            output;
         end;
      run;
   %end ;

%err_exit:
%mend ;

/******************************************************************
 * The following code is used by the macro mentioned in ClassMet  *
 * table on page 33.                                              *
 ******************************************************************/


/*  PROGRAM         _DCREATE
    DESCRIPTION     Create an object of the Vector Discrete class
    USAGE           %_dcreate (object, newobj) ;     
    PARAMETERS      object and newobj  -- both contain the name of the object of the 
                    Vector Discrete class that must be created. If %_fcreate macro is 
                    invoked by the %ACTION macro, the object parameter may contain the 
                    "NULL" value (see explanation of the parameters in the 
                    "Create action" section in Chapter 4). 
    REQUIRES        The &libref and &libwork are global macro variables. The &libref 
                    contains the SAS library name for data dictionary tables. 
                    The &libwork contains the name of the SAS library where the created 
                    statistical objects are located. In the book this library called 
                    _SA_WORK.
    AUTHORS         T.Kolosova and S.Berestizhevsky.        
*/              


%macro _dcreate (object, newobj) ;

/* check correctness of definition of the vector discrete object */
   %local aval1 aval2 aval3 aval4 ;
   %let attr_no = 0;
/* number of attributes */
   %let aval1 = 0 ;
   %let aval2 = 0 ;
   %let aval3 = 0 ;
   %let aval4 = 0 ;

/* get the attributes of the object from the StatObj table */
   data _null_;
      retain i 0;
      set &libref..statobj (where = (upcase(left(statobj)) = upcase(left("&newobj"))));
      call symput("attr_no", left(attr_no));
      call symput("aval" || left(attr_no), left(attr_val));
      if attr_no > i+1 then
      do ;
         do j = i+1 to attr_no - 1 ;
            call symput("aval"||left(j), " ");
         end;
      end ;
      i = attr_no ;
   run;

/* analyze the attributes */
   %let exit = 0;

   data _null_;
      length tmp $80;

/* analyze number of parameters */
      if symget("attr_no") < 1 or symget("attr_no") > 4 then
         link err_exit;

/* analyze the first parameter */
      if trim(symget("aval1")) = "" or length(left(symget("aval1"))) > 8 then
         link err_exit;

/* analyze the second parameter */
      if symget("attr_no") < 2 then
         link err_exit;
      else do;
         if trim(symget("aval2")) = "" or length(left(symget("aval2"))) > 8 then
            link err_exit;
      end;

/* analyze the third parameter */
      if symget("attr_no") > 2 then
      do;
         if trim(symget("aval3")) = "" then
            call symput("aval3", "0");
      end;


      return ;
   err_exit:
      call symput("exit",1);
      stop;
   return;

   run;

   %if &exit = 1 %then %goto err_exit;

/* analyze the attributes' values */

/* search for the data object */
   %let dataset = ;

   data _null_;
      set &libref..Object (where = (upcase(left(trim(table))) = upcase(left(trim("&aval1")))));
      call symput("dataset", dataset);
   run;

   %if &dataset = %then %goto err_exit;

/* search for the dataset location */
   %let location = ;

   data _null_;
      set &libref..Location (where = (upcase(left(trim(table))) = upcase(left(trim("&aval1")))));
      call symput("location", library);
   run;

   %if &location = %then %goto err_exit;

/* search for the dataset column */
   %let column = ;

   data _null_;
      set &libref..Property (where = (upcase(left(trim(table))) = upcase(left(trim("&aval1"))) and
         left(trim(upcase(column))) = left(trim(upcase("&aval2")))));
      call symput("column", column);
   run;

   %if &column = %then %goto err_exit;

/* check if the data object exists */
   %let dsexist = 0;
   proc sql noprint;
      select count(*)
      into : dsexist from dictionary.members
      where (upcase(libname) ? upcase("&location"))
            & (upcase(memname) ? upcase("&dataset" ))
            & (upcase(memtype) ? "DATA");
   quit;
   %if &dsexist = 0 %then %goto err_exit ;

   proc contents data = &location..&dataset
   noprint out = columns short;
   run;

   %let column = ;
   data _null_;
      set columns (where = (left(trim(upcase(name))) = left(trim(upcase("&aval2")))));
      call symput("column", name);
   run;
   %if &column = %then %goto err_exit;

/* create the Vector Discrete object */
   data &libwork..&newobj (keep = &newobj) ;
      set &location..&dataset (rename = (&column = &newobj)
      %if &aval3 > 0 %then %do;
         obs = &aval3
      %end ;
      );
      %if &aval4 ^= %then %do;
         format &newobj &aval4 ;
      %end ;
      &newobj = int(&newobj) ;
   run;

/* update the status table */
/* if an object with such a name exists */
   %if %upcase(&object) = %upcase(&newobj) %then
   %do;
      data &libref..Status ;
         set &libref..Status ;
         if upcase(left(statobj)) = upcase(left("&newobj"))
         then
            class = "Vector Discrete";
      run;
   %end;
   %else %do ;
      data &libref..Status ;
         set &libref..Status (in = last);
         output;
         if _n_ = last then
         do;
            statobj = upcase(left("&newobj"))  ;
            class = "Vector Discrete";
            output;
         end;
      run;
   %end ;

%err_exit:
%mend ;


/******************************************************************
 * The following code is used by the macro mentioned in ClassMet  *
 * table on page 33.                                              *
 ******************************************************************/


/*  PROGRAM         _FCREATE
    DESCRIPTION     Create an object of the Factor class
    USAGE           %_fcreate (object, newobj) ;
    PARAMETERS      object and newobj  -- both contain the name of the object of the
                    Factor class that must be created. If %_fcreate macro is invoked
                    by the %ACTION macro, the object parameter may contain the
                    "NULL" value (see explanation of the parameters in the
                    "Create action" section in Chapter 4).
    REQUIRES        The &libref and &libwork are global macro variables. The &libref
                    contains the SAS library name for data dictionary tables.
                    The &libwork contains the name of the SAS library where the created
                    statistical objects are located. In the book this library called
                    _SA_WORK.
    AUTHORS         T.Kolosova and S.Berestizhevsky.
*/


%macro _fcreate (object, newobj) ;

/* check correctness of definition of the Factor object */
   %local aval1 aval2 aval3 aval4 aval5 ;
   %let attr_no = 0;
/* number of attributes */
   %let aval1 = 0 ;
   %let aval2 = 0 ;
   %let aval3 = 0 ;
   %let aval4 = 0 ;
   %let aval5 = 0 ;

/* get the attributes of the object from the StatObj table */
   data _null_;
      retain i 0;
      set &libref..statobj (where = (upcase(left(statobj)) = upcase(left("&newobj"))));
      call symput("attr_no", left(attr_no));
      call symput("aval" || left(attr_no), left(trim(attr_val)));
      if attr_no > i+1 then
      do ;
         do j = i+1 to attr_no - 1 ;
            call symput("aval"||left(j), " ");
         end;
      end ;
      i = attr_no ;
   run;

/* analyze the attributes */
   %let exit = 0;

   data _null_;
      length tmp $80;

/* analyze number of parameters */
      if symget("attr_no") < 1 or symget("attr_no") > 5 then
         link err_exit;

/* analyze the first parameter */
      if trim(symget("aval1")) = "" or length(left(symget("aval1"))) > 8 then
         link err_exit;

/* analyze the second parameter */
      if symget("attr_no") < 2 then
         link err_exit;
      else do;
         if trim(symget("aval2")) = "" or length(left(symget("aval2"))) > 8 then
            link err_exit;
      end;

/* analyze the third parameter */
      if symget("attr_no") > 2 then
      do;
         if trim(symget("aval3")) = "" then
            call symput("aval3", "0");
      end;

      return ;
   err_exit:
      call symput("exit",1);
      stop;
   return;

   run;

   %if &exit = 1 %then %goto err_exit;

/* analyze the attributes' values */

/* search for the data object */
   %let dataset = ;

   data _null_;
      set &libref..Object (where = (upcase(left(trim(table))) = upcase(left(trim("&aval1")))));
      call symput("dataset", dataset);
   run;

   %if &dataset = %then %goto err_exit;

/* search for the dataset location */
   %let location = ;

   data _null_;
      set &libref..Location (where = (upcase(left(trim(table))) = upcase(left(trim("&aval1")))));
      call symput("location", library);
   run;

   %if &location = %then %goto err_exit;

/* search for the dataset column */
   %let column = ;

   data _null_;
      set &libref..Property (where = (upcase(left(trim(table))) = upcase(left(trim("&aval1"))) and
         left(trim(upcase(column))) = left(trim(upcase("&aval2")))));
      call symput("column", trim(left(column)));
      call symput("type", type) ;
   run;

   %if &column = %then %goto err_exit;

/* check if the data object exists */
   %let dsexist = 0;
   proc sql noprint;
      select count(*)
      into : dsexist from dictionary.members
      where (upcase(libname) ? upcase("&location"))
            & (upcase(memname) ? upcase("&dataset" ))
            & (upcase(memtype) ? "DATA");
   quit;
   %if &dsexist = 0 %then %goto err_exit ;

   proc contents data = &location..&dataset
   noprint out = columns short;
   run;

   %let column = ;
   data _null_;
      set columns (where = (left(trim(upcase(name))) = left(trim(upcase("&aval2")))));
      call symput("column", name);
   run;
   %if &column = %then %goto err_exit;

/* create the Factor object */
   data &libwork..&newobj (keep = &newobj) ;
      set &location..&dataset (rename = (&column = &newobj)
      %if &aval3 > 0 %then %do;
         obs = &aval3
      %end ;
      );
      %if &aval4 ^= %then %do;
         format &newobj &aval4 ;
      %end ;

/* checks validity of values defined by LEVELS attribute and drops unmatched values */
/* in this version of program &aval5 variable contains list of valid values only */
      %if %upcase(&type) = C  %then
      %do ;
         length str word $200;
         retain str;
         str = left(symget("aval5"));
         i = 1;
         word = left(scan(str, 1, ",")) ;
         do while(trim(word) ^= "" and i ^= 0);
            if trim(upcase(word)) = trim(upcase(&newobj)) then
               i = 0;
            else do;
               i = i + 1;
               word = left(scan(str, i, ",")) ;
            end;
         end;
         if i ^= 0 then delete;
      %end ;
      %else
      %do ;
         length str word $200;
         retain str;
         str = left(symget("aval5"));
         i = 1;
         word = scan(str, 1, ",");
         do while(trim(word) ^= "" and i ^= 0);
            if word = &newobj then
               i = 0;
            else do;
               i = i + 1;
               word = scan(str, i, ",") ;
            end;
         end;
         if i ^= 0 then delete;
       %end ;
   run;

/* update the status table */
/* if an object with such a name exists */
   %if %upcase(&object) = %upcase(&newobj) %then
   %do;
      data &libref..Status ;
         set &libref..Status ;
         if upcase(left(statobj)) = upcase(left("&newobj"))
         then
            class = "Factor";
      run;
   %end;
   %else %do ;
      data &libref..Status ;
         set &libref..Status (in = last);
         output;
         if _n_ = last then
         do;
            statobj = upcase(left("&newobj"))  ;
            class = "Factor";
            output;
         end;
      run;
   %end ;
%err_exit:
%mend ;
/******************************************************************
 * The following code is used by the macro mentioned in ClassMet  *
 * table on page 33.                                              *
 ******************************************************************/


/*  PROGRAM         _OCREATE
    DESCRIPTION     Create an object of the Factor Ordered class
    USAGE           %_ocreate (object, newobj) ;
    PARAMETERS      object and newobj  -- both contain the name of the object of the
                    Factor Ordered class that must be created. If %_fcreate macro is
                    invoked by the %ACTION macro, the object parameter may contain the
                    "NULL" value (see explanation of the parameters in the
                    "Create action" section in Chapter 4).
    REQUIRES        The &libref and &libwork are global macro variables. The &libref
                    contains the SAS library name for data dictionary tables.
                    The &libwork contains the name of the SAS library where the created
                    statistical objects are located. In the book this library called
                    _SA_WORK.
    AUTHORS         T.Kolosova and S.Berestizhevsky.
*/


%macro _ocreate (object, newobj) ;

/* check correctness of definition of the Factor Ordered object */
   %local aval1 aval2 aval3 aval4 aval5 ;
   %let attr_no = 0;
/* number of attributes */
   %let aval1 = 0 ;
   %let aval2 = 0 ;
   %let aval3 = 0 ;
   %let aval4 = 0 ;
   %let aval5 = 0 ;

/* get the attributes of the object from the StatObj table */
   data _null_;
      retain i 0;
      set &libref..statobj (where = (upcase(left(statobj)) = upcase(left("&newobj"))));
      call symput("attr_no", left(attr_no));
      call symput("aval" || left(attr_no), left(trim(attr_val)));
      if attr_no > i+1 then
      do ;
         do j = i+1 to attr_no - 1 ;
            call symput("aval"||left(j), " ");
         end;
      end ;
      i = attr_no ;
   run;

/* analyze the attributes */
   %let exit = 0;

   data _null_;
      length tmp $80;

/* analyze number of parameters */
      if symget("attr_no") < 1 or symget("attr_no") > 5 then
         link err_exit;

/* analyze the first parameter */
      if trim(symget("aval1")) = "" or length(left(symget("aval1"))) > 8 then
         link err_exit;

/* analyze the second parameter */
      if symget("attr_no") < 2 then
         link err_exit;
      else do;
         if trim(symget("aval2")) = "" or length(left(symget("aval2"))) > 8 then
            link err_exit;
      end;

/* analyze the third parameter */
      if symget("attr_no") > 2 then
      do;
         if trim(symget("aval3")) = "" then
            call symput("aval3", "0");
      end;

      return ;
   err_exit:
      call symput("exit",1);
      stop;
   return;

   run;

   %if &exit = 1 %then %goto err_exit;

/* analyze the attributes' values */

/* search for the data object */
   %let dataset = ;

   data _null_;
      set &libref..Object (where = (upcase(left(trim(table))) = upcase(left(trim("&aval1")))));
      call symput("dataset", dataset);
   run;

   %if &dataset = %then %goto err_exit;

/* search for the dataset location */
   %let location = ;

   data _null_;
      set &libref..Location (where = (upcase(left(trim(table))) = upcase(left(trim("&aval1")))));
      call symput("location", library);
   run;

   %if &location = %then %goto err_exit;

/* search for the dataset column */
   %let column = ;

   data _null_;
      set &libref..Property (where = (upcase(left(trim(table))) = upcase(left(trim("&aval1"))) and
         left(trim(upcase(column))) = left(trim(upcase("&aval2")))));
      call symput("column", trim(left(column)));
      call symput("type", type) ;
   run;

   %if &column = %then %goto err_exit;

/* check if the data object exists */
   %let dsexist = 0;
   proc sql noprint;
      select count(*)
      into : dsexist from dictionary.members
      where (upcase(libname) ? upcase("&location"))
            & (upcase(memname) ? upcase("&dataset" ))
            & (upcase(memtype) ? "DATA");
   quit;
   %if &dsexist = 0 %then %goto err_exit ;

   proc contents data = &location..&dataset
   noprint out = columns short;
   run;

   %let column = ;
   data _null_;
      set columns (where = (left(trim(upcase(name))) = left(trim(upcase("&aval2")))));
      call symput("column", name);
   run;
   %if &column = %then %goto err_exit;

/* create the Factor object */
   data &libwork..&newobj (keep = &newobj _id) ;
      set &location..&dataset (rename = (&column = &newobj)
      %if &aval3 > 0 %then %do;
         obs = &aval3
      %end ;
      );
      %if &aval4 ^= %then %do;
         format &newobj &aval4 ;
      %end ;
/* checks validity of values defined by LEVELS attribute and drops unmatched values */
/* in this version of program &aval5 variable contains list of valid values only */
      %if %upcase(&type) = C  %then
      %do ;
         length str word $200;
         retain str;
         str = left(symget("aval5"));
         i = 1;
         _id = i;
         word = left(scan(str, 1, ",")) ;
         do while(trim(word) ^= "" and i ^= 0);
            if trim(upcase(word)) = trim(upcase(&newobj)) then
               i = 0;
            else do;
               i = i + 1;
               _id = i;
               word = left(scan(str, i, ",")) ;
            end;
         end;
         if i ^= 0 then delete;
      %end ;
      %else
      %do ;
         length str word $200;
         retain str;
         str = left(symget("aval5"));
         i = 1;
         _id = i;
         word = scan(str, 1, ",");
         do while(trim(word) ^= "" and i ^= 0);
            if word = &newobj then
               i = 0;
            else do;
               i = i + 1;
               _id = i;
               word = scan(str, i, ",") ;
            end;
         end;
         if i ^= 0 then delete;
       %end ;
   run;

/* sorts values of created object according to the order of values defined by LEVELS */
/* attribute and stored in &aval5 variable */

   proc sort data = &libwork..&newobj out = &libwork..&newobj (drop = _id) ;
   by _id;
   run ;



/* update the status table */
/* if an object with such a name exists */
   %if %upcase(&object) = %upcase(&newobj) %then
   %do;
      data &libref..Status ;
         set &libref..Status ;
         if upcase(left(statobj)) = upcase(left("&newobj"))
         then
            class = "Factor Ordered";
      run;
   %end;
   %else %do ;
      data &libref..Status ;
         set &libref..Status (in = last);
         output;
         if _n_ = last then
         do;
            statobj = upcase(left("&newobj"))  ;
            class = "Factor Ordered";
            output;
         end;
      run;
   %end ;

%err_exit:
%mend ;

libname oos "c:\oos" ;

%global libref libwork ;
%let libref = oos ;
%let libwork = work ;


%_ocreate (factor, factor1) ;
/******************************************************************
 * The following code is used by the macro mentioned in ClassMet  *
 * table on page 33.                                              *
 ******************************************************************/


/*  PROGRAM         _VCREATE
    DESCRIPTION     Create an object of the Vector class
    USAGE           %_vcreate (object, newobj) ;     
    PARAMETERS      object and newobj  -- both contain the name of the object of the 
                    Vector class that must be created. If %_fcreate macro is 
                    invoked by the %ACTION macro, the object parameter may contain the 
                    "NULL" value (see explanation of the parameters in the 
                    "Create action" section in Chapter 4). 
    REQUIRES        The &libref and &libwork are global macro variables. The &libref 
                    contains the SAS library name for data dictionary tables. 
                    The &libwork contains the name of the SAS library where the created 
                    statistical objects are located. In the book this library called 
                    _SA_WORK.
    AUTHORS         T.Kolosova and S.Berestizhevsky.        
*/       


%macro _vcreate (object, newobj) ;

/* check correctness of definition of the vector object */
   %local aval1 aval2 aval3 aval4 ;
   %let attr_no = 0;
/* number of attributes */
   %let aval1 = 0 ;
   %let aval2 = 0 ;
   %let aval3 = 0 ;
   %let aval4 = 0 ;

/* get the attributes of the object from the StatObj table */
   data _null_;
      retain i 0;
      set &libref..statobj (where = (upcase(left(statobj)) = upcase(left("&newobj"))));
      call symput("attr_no", left(attr_no));
      call symput("aval" || left(attr_no), left(attr_val));
      if attr_no > i+1 then
      do ;
         do j = i+1 to attr_no - 1 ;
            call symput("aval"||left(j), " ");
         end;
      end ;
      i = attr_no ;
   run;

/* analyze the attributes */
   %let exit = 0;

   data _null_;
      length tmp $80;

/* analyze number of parameters */
      if symget("attr_no") < 1 or symget("attr_no") > 4 then
         link err_exit;

/* analyze the first parameter */
      if trim(symget("aval1")) = "" or length(left(symget("aval1"))) > 8 then
         link err_exit;

/* analyze the second parameter */
      if symget("attr_no") < 2 then
         link err_exit;
      else do;
         if trim(symget("aval2")) = "" or length(left(symget("aval2"))) > 8 then
            link err_exit;
      end;

/* analyze the third parameter */
      if symget("attr_no") > 2 then
      do;
         if trim(symget("aval3")) = "" then
            call symput("aval3", "0");
      end;


      return ;
   err_exit:
      call symput("exit",1);
      stop;
   return;

   run;

   %if &exit = 1 %then %goto err_exit;

/* analyze the attributes' values */

/* search for the data object */
   %let dataset = ;

   data _null_;
      set &libref..Object (where = (upcase(left(trim(table))) = upcase(left(trim("&aval1")))));
      call symput("dataset", dataset);
   run;

   %if &dataset = %then %goto err_exit;

/* search for the dataset location */
   %let location = ;

   data _null_;
      set &libref..Location (where = (upcase(left(trim(table))) = upcase(left(trim("&aval1")))));
      call symput("location", library);
   run;

   %if &location = %then %goto err_exit;

/* search for the dataset column */
   %let column = ;

   data _null_;
      set &libref..Property (where = (upcase(left(trim(table))) = upcase(left(trim("&aval1"))) and
         left(trim(upcase(column))) = left(trim(upcase("&aval2")))));
      call symput("column", column);
   run;

   %if &column = %then %goto err_exit;

/* check if the data object exists */
   %let dsexist = 0;
   proc sql noprint;
      select count(*)
      into : dsexist from dictionary.members
      where (upcase(libname) ? upcase("&location"))
            & (upcase(memname) ? upcase("&dataset" ))
            & (upcase(memtype) ? "DATA");
   quit;
   %if &dsexist = 0 %then %goto err_exit ;

   proc contents data = &location..&dataset
   noprint out = columns short;
   run;

   %let column = ;
   data _null_;
      set columns (where = (left(trim(upcase(name))) = left(trim(upcase("&aval2")))));
      call symput("column", name);
   run;
   %if &column = %then %goto err_exit;

/* create the Vector object */
   data &libwork..&newobj (keep = &newobj) ;
      set &location..&dataset (rename = (&column = &newobj)
      %if &aval3 > 0 %then %do;
         obs = &aval3
      %end ;
      );
      %if &aval4 ^= %then %do;
         format &newobj &aval4 ;
      %end ;

   run;

/* update the status table */
/* if an object with such a name exists */
   %if %upcase(&object) = %upcase(&newobj) %then
   %do;
      data &libref..Status ;
         set &libref..Status ;
         if upcase(left(statobj)) = upcase(left("&newobj"))
         then
            class = "Vector";
      run;
   %end;
   %else %do ;
      data &libref..Status ;
         set &libref..Status (in = last);
         output;
         if _n_ = last then
         do;
            statobj = upcase(left("&newobj"))  ;
            class = "Vector";
            output;
         end;
      run;
   %end ;

%err_exit:
%mend ;




