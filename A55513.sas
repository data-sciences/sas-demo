/*-----------------------------------------------------------------*/
/* In the Know...SAS Tips & Techniques From Around the Globe       */
/* by Phil Mason                                                   */
/*                                                                 */
/* SAS Publications order # 55513                                  */
/* ISBN 1-55544-870-4                                              */
/* Copyright 1996 by SAS Institute Inc., Cary, NC, USA             */
/*                                                                 */
/* SAS Institute does not assume responsibility for the accuracy   */
/* of any material presented in this file.                         */
/*-----------------------------------------------------------------*/

========================================
Ch.1 - A Collection of Useful Tips
========================================
Commenting out code containing comments - p.6-7
-----------------------------------------------
%macro junk ; * this statement used to comment out following code ;

* do the next data step ;
data this ;   /* this is a nice dataset */
  set that ; 
  x+1 ;       /* add 1 to x */

%mend ;  this statement used to comment out previous code ;

options nosource;
%put **;
%put ** note: excluding some code. be back soon.;
%put **;
%macro junk ; * this statement used to comment out following code ;


* do the next data step ;
data this ;   /* this is a nice dataset */
  set that ;
  x+1 ;         /* add 1 to x */

%mend ; this statement used to comment out previous code ;
options source;


Data Encryption for the beginner - p.9
--------------------------------------
data coded ;
 * set the value of the key ; 
  retain key 1234567 ;         
  input original ;
 * encode the original value using the key ; 
  coded=bxor(original,key); 
  put key= original= coded= ;  
  cards ;
1 
1234567 
999999 
34.4
0 
run ;                      
 
data decode ;
 * the value of the key must be the same, 
   or else the number will not decode correctly ;
  retain key 1234567 ;     
  set coded ;              
 * decode the coded value using the key ;
  decoded=bxor(coded,key); 
  put coded= decoded= ; 
run ;                   


Cautions in dealing with missing values - p.12-13
-------------------------------------------------
data _null_ ;                                                
 * Initialise values ;
  a=. ;                                                      
  b=0 ;                                                      
  c=-7 ;                                                     
  d=99 ;                                                     
 * Try various forms of addition involving missing values ;
  add=a+b+c+d ;                                              
  put 'Addition of missing & non-missing values :  ' add= ;  
  sum=sum(a,b,c,d) ;                                         
  put 'Sum of missing & non-missing values :  ' sum= ;       
  summiss=sum(.,a) ;                                         
  put 'Sum of missing values only :  ' summiss= ;            
  sumzero=sum(0,.,a) ;                                       
  put 'Sum of 0 and missing values :  ' sumzero= ;           
 * See how the missing value compares to zero ;             
  if a<0 then                                                
    put 'Missing is less than 0' ;                           
  else if a>0 then                                           
    put 'Missing is greater than 0' ;                        
run ;                                                        


data temp;
  missing Z;
  input a;
  b = a + 0;
cards;
7
4
.Z
5
;

proc print ;
run ;


========================================
Ch.2 - Resource Tips
========================================
Use indexes with where clauses - p.24
-------------------------------------
/* The following is a copy of the SAS log.                         */
/* Extract the code from the log before trying to submit the code. */

1    proc datasets library=sasuser; 
2    modify houses ;                                             
3    index create indx=(style bedrooms) ;                        
NOTE: Composite index INDX defined.                              
4    run ;                                                       
5    options msglevel=i ; * Show indexes that are used ;         
NOTE: The PROCEDURE DATASETS used 0.02 CPU seconds and 1511K.    
                                                                 
6    data temp ;                                                 
7      set sasuser.houses ;                                      
8        where style='RANCH' ;                                   
INFO: Index INDX selected for WHERE clause optimization.         
9    run ;                                                       
                                                                 
NOTE: The data set WORK.TEMP has 4 observations and 6 variables. 
                                                                 
NOTE: The DATA statement used 0.02 CPU seconds and 1602K.        
                                                                 
10   data temp ;                                                 
11     set sasuser.houses ;                                      
12       where bedrooms=3 ;                                      
13   run ;     * Note - No Index was selected for use here ;
                                                                 
NOTE: The data set WORK.TEMP has 4 observations and 6 variables. 
NOTE: The DATA statement used 0.01 CPU seconds and 1602K.        


========================================
Ch.4 - DATA Step
========================================
Adding variables with similar names - p.62
------------------------------------------
data _null_ ;
* Sample data ;
  iddusa=10 ;
  iddaus=33 ;
  iddtai=44 ;
  idduk=99 ;
  iddbel=1 ;
  iddcan=11 ;
* Define array to hold all the IDD variables ;
  array idd(*) idd: ;
* Initialise total to 0 ;
  total=0 ;              
* Add them up ;
  do i=1 to dim(idd) ;  
    total+idd(i) ;
  end ;
* Calculate average ;
  avg=total/dim(idd) ;
  put _all_ ;
run ;


Determining the number of observations in a dataset - pp.69-70
--------------------------------------------------------------
* code to test if a dataset has any obs. ;
data _null_ ;           
  if 0 then set work.ytd point=_n_ nobs=count ;
  call symput('numobs',left(put(count,8.))) ; stop ;                        
run;

%macro reports ;
%if &numobs =0     
%then %do ;
data _null_ ;
  file ft20f001 ;  
  %title ;
  put ////
    @10 "NO records were selected using the statement " // 
    @15 "&where" // 
    @10 "for any month from &start to &end" // 
    @10 'THIS RUN HAS COMPLETED SUCCESSFULLY.' ;
run ;
%end ; 
%else 
  %do ;
* generate graph of costs vs cycle;
proc chart data=work.ytd ;                                           
  by finyear ; vbar pcycle / type=sum sumvar=cost discrete; format pcycle $2. ; run;
  %end ;                                
%mend ;                        

%reports;


Creating views from a DATA step - p.72
--------------------------------------
data work.temp;
set work.large;
if variable >=0 then flag=1;
else flag=0; run;
proc freq data=work.temp;
table flag; run;

data work.temp / VIEW=WORK.TEMP;
  KEEP FLAG;
  set work.large;
  if variable >=0 then flag=1;
                  else flag=0;
run;

proc freq data=work.temp;
   table flag; run;


Editing external files in place - p.81
--------------------------------------
data _null_ ;
  infile 'very-long-recs' 
         sharebuffers ;     /* Define input file */
  input ;                   /* Read a record into the input buffer */
  file out ;                /* Point to where you want to write output */
  put @33  'ABC'            /* write changes */
      @400 '12345'          /* write another change */
      @999 'Wow' ;          /* write the last change */ 
run ;


  put _infile_ ',this,that' ;  * Appends 2 fields to the end of a CSV file ;

  put first ',' second ',' _infile_ ; * Puts 2 fields at the start of a CSV file ;


Results of merges differ if a BY statement is used - p.87
---------------------------------------------------------
data x ;        
  input a b ;   
cards ;         
1 2             
1 3             
1 4             
5 99            
;               

data y ;        
  input a b c ; 
cards ;         
1 6 9           
1 7 10          
5 8 11          
;               

data merge ;    
  merge x y ;   
    by a ;      
run ;           

proc print ;    


Values are retained when doing indexed reads - p.88
---------------------------------------------------
* Put an index on a dataset for the test ;
proc datasets library=sasuser;
  modify crime ;
  index create staten;

* Make a dataset of values to use for lookup ;
data x ;
  staten='Nowhere' ; output;
  staten='Iowa' ; output;
  staten='Noplace' ; output;
run ;

data y(keep=iorc staten murder rape auto) ;
  set x ; * Read the value to lookup ;
  set sasuser.crime key=staten/unique ; * Use index to lookup value ;
  iorc=_iorc_ ;
run ;
proc print ;run;

* Sort the transaction dataset by the key ;
Proc sort data=transact ;
  by account ;

Data selectn ;
 * Get account number to look up ;
  set transact ;
 * Look it up ;
  set master key=accno/unique ;
 * If we found it then write the info out ;
  if _iorc_=0 then
    output ;
run ;


========================================
Ch.5 - Macros
========================================
Forcing SAS to store macro symbol tables on disk - p.110
--------------------------------------------------------
* Store macro symbol table to work library ;
options msymtabmax=0 ;

*** Define some macro variables ;
%let a=1 ;
%let b=2 ;

%macro fred ;
  %let c=3 ;
%mend fred ;

%fred

*** Now look in your Work library and you can see the SASSTn catalogs ;
***    each one has a member for each macro variable ;


How to produce files for import into other applications - p.112
---------------------------------------------------------------
%macro maketsv(dset,csv,limit=,title=,extra=) ;             

options nodate nocenter ;

* put the structure of the dataset into a sas dataset ;
proc contents data=&dset
              out=zxcvbnm1
              noprint ;                   
run ;

* Sort the dataset containing the structure by variable number ;
proc sort data=zxcvbnm1
          out=zxcvbnm2(keep=name) ;                 
  by varnum ;                                                    
run ;

proc transpose data=zxcvbnm2
               out=zxcvbnm3(drop=_name_ _label_) ;  
  var name ;                                                     
run ;

data _null_ ;                                                     
  set zxcvbnm3 ;                                                 
  file &csv ;                                                    

* Note the two semi-colons, one for the PUT statement
                        and one for the %IF statement ;
  %if &title ne %then 
    put "&title" ; ; 

  put (_all_) ( +(-1) '05'x ) ;                                  
run ;

data _null_ ;                     
  set &dset ;                    
  file &csv mod ;                

%if &limit>0 %then                 
  %do ;                            
    if _n_>&limit then             
    stop ;                       
  %end ;                           

%if &extra> %then                   
  %&extra ;                         

* This hex constant is the TAB character for EBCDIC,
* the TAB character for ASCII is '09'X ;
  put (_all_) ( +(-1) '05'x ) ;
run ;                             

%mend maketsv ;                     


Useful merge macro - pp.113-114
-------------------------------
%************************** mergeby *******************************;
%* mergeby acts like a MERGE statement with a BY statement even if there are no BY variables;

%macro mergeby(data1, data2, byvars);
  %if %bquote(&byvars) NE %then
    %do;
      merge %unquote(&data1) %unquote(&data2);
        by %unquote(&byvars);
    %end;
  %else
    %do;
      if _end1 & _end2 then
        stop;
      if ^_end1 then 
        set %unquote(&data1) end=_end1;
      if ^_end2 then 
        set %unquote(&data2) end=_end2;
    %end;
%mend mergeby;



* Create some sample data - firstly dataset x ;
data x;
  do x=1 to 5;
    output;
  end;
run;

* Create some sample data - secondly dataset y ;
data y;
  do y=1 to 3;
    output;
  end;
run;

*** Now we merge the two datasets with a standard merge statement ;
*** - notice that there is no BY statement ;
data xy;
  merge x y;

proc print;
run;

*** Now we merge the two datasets with the MERGEBY macro ;
data xy;
  %mergeby(x,y);

proc print;
run;



data xy(drop=last_y) ;
  retain last_y ;
  merge x y ;
  if y NE . then
    last_y=y ;
  else
    y=last_y ;
run ;


========================================
Ch. 6 - Assorted procedure tips
========================================
Multiple graphs on a page - p.122-126
-------------------------------------
 /********************************************************************

       name: grid
      title: Replay graphs in a regular grid
    product: graph
     system: all
      procs: greplay gslide
    support: saswss                      update:  10jul95

 DISCLAIMER:

       THIS INFORMATION IS PROVIDED BY SAS INSTITUTE INC. AS A SERVICE
 TO ITS USERS.  IT IS PROVIDED “AS IS”.  THERE ARE NO WARRANTIES,
 EXPRESSED OR IMPLIED, AS TO MERCHANTABILITY OR FITNESS FOR A
 PARTICULAR PURPOSE REGARDING THE ACCURACY OF THE MATERIALS OR CODE
 CONTAINED HEREIN.

 The %GRID macro lets you easily replay graphs in a regular grid with
 one or more rows and one or more columns. The %GRID macro also
 supports titles and footnotes for the entire replayed graph. For
 example, if you have run GPLOT four times and want to replay these
 graphs in a 2-by-2 grid with the title 'Four Marvellous Graphs', you
 could submit the following statements:

    title 'Four Marvellous Graphs';
    %grid( gplot*4, rows=2, cols=2);

 The %GRID macro allows 10% of the vertical size of the graph for
 titles by default. You can adjust this percentage via the TOP=
 argument in %GRID. Determining the best value for TOP= requires
 trial and error in most cases. To allow space for footnotes, use
 the BOTTOM= argument.

 The graphs to replay must be stored in a graphics catalog with
 library and member names specified by the macro variables &glibrary
 and &gout. By default, SAS/GRAPH stores graphs in WORK.GSEG, which
 is the catalog that the %GRID macro uses by default.  If your
 graphs are in another catalog, you must specify &glibrary and/or
 &gout using %LET statements as shown below.

 Each graph that is stored in a catalog has a name. Each procedure
 assigns default names such as GPLOT, GPLOT1, GPLOT2, etc. Most
 SAS/GRAPH procedures let you specify the name via a NAME= option
 which takes a quoted string that must be a valid SAS name. However,
 if a graph by that name already exists in the catalog, SAS/GRAPH
 appends a number to the name; it does not replace the previous graph
 by the same name unless you specify GOPTIONS GOUTMODE=REPLACE, but
 this option causes _all_ entries in the catalog to be deleted
 every time you save a new graph, so it is not very useful. If you want
 to replace a single graph in a catalog, sometimes you can use the
 %GDELETE macro to delete the old one and later recreate a graph with
 the same name, but this does not work reliably due to a bug in
 SAS/GRAPH. By default, %GDELETE deletes _everything_ in the catalog;
 this does seem to work reliably.

 When you use BY processing, SAS/GRAPH appends numbers to the graph
 name to designate graphs for each BY group. For example, if you run
 GPLOT with three BY groups and NAME='HENRY', the graphs are named
 HENRY, HENRY1, and HENRY2. The %GRID macro lets you abbreviate this
 list of names as HENRY*3, where the repetition factor following the
 asterisk is the total number of graphs, not the number of the last
 graph.

 *********************************************************************/

%let glibrary=WORK;
%let gout=GSEG;

%macro grid(  /* replay graphs in a rectangular grid */
   list,      /* list of names of graphs, separated by blanks;
                 a name may be followed by an asterisk and a
                 repetition factor with no intervening blanks;
                 for example, ABC*3 is expanded to: ABC ABC1 ABC2 */
   rows=1,    /* number of rows in the grid */
   cols=1,    /* number of columns in the grid */
   top=10,    /* percentage at top to reserve fortitles */
   bottom=0); /* percentage at bottom to reserve for footnotes */

   %gtitle;
   %greplay;
   %tdef(rows=&rows,cols=&cols,top=&top,bottom=&bottom)
   %trep(&list,rows=&rows,cols=&cols)
   run; quit;
%mend grid;


%macro gdelete(list); /* delete list of graphs from the catalog;
                         default is _ALL_ */

   %if %bquote(&list)= %then %let list=_ALL_;
   proc greplay igout=&glibrary..&gout nofs;
      delete &list;
   run; quit;
%mend gdelete;


%macro gtitle; /* create graph with titles and footnotes only */

   %global titlecnt;
   %if %bquote(&titlecnt)= %then %let titlecnt=1;
                           %else %let titlecnt=%eval(&titlecnt+1);
   goptions nodisplay;
   proc gslide gout=&glibrary..&gout name="title&titlecnt";
   run;
   goptions display;
%mend gtitle;


%macro greplay( /* invoke PROC GREPLAY */
   tc);         /* template catalog; default is JUNK */

   %if %bquote(&tc)= %then %let tc=junk;
   proc greplay nofs tc=&tc;
      igout &glibrary..&gout;
%mend greplay;


%macro tdef(  /* define a template for a rectangular grid */
   rows=1,    /* number of rows in the grid */
   cols=1,    /* number of columns in the grid */
   top=10,    /* percentage at top to reserve for titles */
   bottom=0); /* percentage at bottom to reserve for footnotes */
   %global tdefname; /* returned: name of template */

   %local height width n row col lower upper left right;
   %let height=%eval((100-&top-&bottom)/&rows);
   %let width =%eval(100/&cols);
   %let tdefname=t&rows._&cols;
   tdef &tdefname
      0/ulx=0 uly=100 llx=0 lly=0 urx=100 ury=100 lrx=100 lry=0
   %let n=1;
   %do row=1 %to &rows;
      %let lower=%eval(100-&top-&row*&height);
      %let upper=%eval(&lower+&height);
      %do col=1 %to &cols;
         %let right=%eval(&col*&width);
         %let left =%eval(&right-&width);
         &n/ulx=&left uly=&upper llx=&left lly=&lower
            urx=&right ury=&upper lrx=&right lry=&lower
         %let n=%eval(&n+1);
      %end;
   %end;
   ;
   template &tdefname;
%mend tdef;


%macro trep( /* replay graphs using template defined by %TDEF */
   list,     /* list of names of graphs, separated by blanks;
                a name may be followed by an asterisk and a
                repetition factor with no intervening blanks;
                for example, ABC*3 is expanded to: ABC ABC1 ABC2 */
   rows=,    /* (optional) number of rows in template */
   cols=);   /* (optional) number of columns in template */
             /* rows= and cols= default to values set with %TDEF */

   %global titlecnt;
   %local i l n row col name root suffix nrep;
   %if %bquote(&rows)= %then %let rows=%scan(&tdefname,1,t_);
   %if %bquote(&cols)= %then %let cols=%scan(&tdefname,2,t_);
   treplay 0:title&titlecnt
   %let nrep=0;
   %let l=0;
   %let n=0;
   %do row=1 %to &rows;
      %do col=1 %to &cols;
         %let n=%eval(&n+1);
         %if &nrep %then %do;
            %let suffix=%eval(&suffix+1);
            %if &suffix>=&nrep %then %do;
               %let nrep=0;
               %goto tryagain;
            %end;
            %let name=&root&suffix;
            %goto doit;
         %end;
%tryagain:
         %let l=%eval(&l+1);
         %let name=%qscan(&list,&l,%str( ));
         %if &name= %then %goto break;
         %let i=%index(&name,*);
         %if &i %then %do;
            %let nrep=%substr(&name,&i+1);
            %if &nrep<=0 %then %goto tryagain;
            %let root=%substr(&name,1,&i-1);
            %let name=&root;
            %let suffix=0;
         %end;
%doit:
         &n:&name
      %end;
   %end;
%break:
   ;
%mend trep;

 /****************** Examples for the %GRID macro *******************/

%inc greplay;

data trig;
   do n=1 to 100;
      x1=sin(n/16);
      x2=sin(n/8);
      y1=cos(n/16);
      y2=cos(n/8);
      output;
   end;
run;

goptions nodisplay;
proc gplot data=trig;
   title 'Y1 by X1';
   plot y1*x1;
run;
   title 'Y1 by X2';
   plot y1*x2;
run;
   title 'Y2 by X1';
   plot y2*x1;
run;
   title 'Y2 by X2';
   plot y2*x2;
run;

title 'Four Marvellous Graphs';
%grid( gplot*4, rows=2, cols=2);


title 'Adding a Title to a Single Graph';
footnote 'And a Footnote';
%grid( gplot, top=12, bottom=5);


========================================
Ch.8 - Procedure tips for displaying data
========================================
Creating Tab separated output using PROC TABULATE - p.143
---------------------------------------------------------
options nodate
        nonumber
        ls=254
        ps=32767 ;
proc tabulate data=sample
              formchar=',             '
              noseps ;
  class this that ;
  var num ;
  table sum*num, this all, that all ;
run ;

/* Note: this technique doesn't work as well with multi-dimensional tables. */


Indenting output using PROC TABULATE - p.145
--------------------------------------------
options nocenter ;

data sample ;
  length x y $ 1 ;
  input x y z ;

cards ;
a b 1
b c 2
a c 3
a b 4
b c 5
a c 6
;

proc tabulate data=sample ;
  class x y ;
  var z ;
  table x*y, z*(min mean max) / INDENT=3 ;
run ;


========================================
Ch. 9 - Basic statistical procedure tips
========================================
FREQ/SUMMARY: Frequency tables with long labels - p.155
-------------------------------------------------------
data x ;
  length a $ 30 ;
  input a ;
cards ;
this-is-26-characters-long
this-is-26-characters-long-not
this-is-26-characters-long
run ;

proc freq ;
  table a ;
run ;

proc summary nway ;
  class a ;
  output out=freq ;
run ;

proc print ;
  var a _freq_ ;
run ;


UNIVARIATE/FASTCLUS: calculating weighted Medians - p.162
---------------------------------------------------------
   data w;
      input x w;
   cards;
   1  0
   3  1
   4  2
   4  3
   7  5
   99 10
   ;
   
   proc univariate;
     var x;
     freq w;
   run;

   proc fastclus data=w maxc=1 least=1;
     var x;
     weight w;
   run;


========================================
Ch. 11 - The FORMAT procedure
========================================
Using formats in a table lookup - pp.182-183
--------------------------------------------
%mkfmt(library.servs,$servs,servno,"Y",other="N",fmtlib=1) ;

%macro mkfmt(dset, fmtname, start, label, other=, library=library, fmtlib=) ;
%* dset     sas dataset name ;                                           
%* fmtname  name of format to create ;                                   
%* start    variable to be used as START in format ;                     
%* label    variable to be user for LABEL in format ;                    
%* other    Optionally set all other values to this variable or literal; 
%* library  Optionally override default format library to your own DD ;  
%* fmtlib   Put any text here to list your format when created ;
 
data temptemp(keep=fmtname hlo &start label) ;                         
  retain fmtname "&fmtname"                                            
  hlo ' ' ;                                                     
  set &dset                                                            
  end=eofeof ;                                                     
  label=&label ; * This could be a variable or a literal ;             
  output ;                                                             

%if "&other">"" %then                                                
  %do ;                                                              
  if eofeof then                                                
    do ;                                                        
      hlo="o" ;                                                 
      label=&other ;                                            
      output ;                                                  
    end ;                                                       
%end ;                                                          

run ;                                                               

proc sort data=temptemp(rename=(&start=start)) nodupkey ;           
  by start hlo ;                                                    

proc format library=&library                                        
          %if "&fmtlib">"" %then                                              
            fmtlib ;                                                
            cntlin=temptemp ;                                       
          %if "&fmtlib">"" %then                                              
            select &fmtname ; ; * Make sure we only print 1 format from lib ; 

run ;                                                               

%mend mkfmt ;                                                         


========================================
Ch. 13 - SCL
========================================
Variable names and list item names in SCL can be long - p.204
-------------------------------------------------------------
init:                                                                         
  list=makelist() ;                                                           
  x100=repeat('----+----!',10) ; * 100 character long string ;                
  list=setnitemc(list,'Value',x100!!x100!!x100) ; * try for 300 chars ;       
  call putlist(list,'List') ;                                                 
  this_is_a_very_long_variable='So it is!' ;                                  
  this_is_a_very_long_variable_2________='They can be 32 char!!!' ;           
  put _all_ ;                                                                 
return ;                                                                      


Determining or causing an END or CANCEL - p.208
-----------------------------------------------
   init:
      link test ;
      put 'in init after test' ;
   return ;

   main:
   return ;

   term:
   return ;

   test:
     put 'in test' ;
     _STATUS_ = 'H' ;
   return ;


   test:
     put 'in test' ;
     _STATUS_ = 'H' ;
     stop ;
   return ;


SCL function to calculate statistics from a data set - p.209
------------------------------------------------------------
rc=VARSTAT(data-set-id,varlist-1,statistics,varlist-2) ;

dsid=open('sasuser.crime') ;
rc=varstat(dsid,'murder,rape','std mean',stdmurd,avgmurd,stdrape,avgrape) ;
rc=close(dsid) ;


Debugging SCL using environment-dependent macros - p.211
--------------------------------------------------------
Development Macro:
  00001 %macro trace(parms);                                                
  00002   %* Trace macro ;                                                  
  00003                                                                     
  00004   put &parms;                                                       
  00005                                                                     
  00006 %mend;                                                              

Production Macro:
  00001 %macro trace(parms);                                                
  00002   %* Trace macro ;                                                  
  00003                                                                     
  00004   %* &parms;                                                        
  00005                                                                     
  00006 %mend;                                                              

SCL:
  00120 WHERE:                                                              
  00121   method where_in $200;                                             
  00122     where=where_in;                                                 
  00123     link open;                                                      
  00124     if rc=0                                                         
  00125     then                                                            
  00126       link getvars;                                                 
  00127     link close;                                                     
  00128                                                                     
  00129     %trace('WHERE:' where= rc= msg=);                               
  00130   endmethod;                                                        


Arrays can be passed by reference in 6.11 - p.212
-------------------------------------------------
init:                                                                         
 ** Define an array to be passed to another SCL program ;
  array temp(6) $ 10 ('January' 'February' 'March' 'April' 'May' 'June') ;    
  put _all_ ; ** Show contents of the array ;
  call display('refaray2.scl',temp) ; * Passing an array by reference ;
return ;                                                                      


array passed(*) $ ; ** Let the SCL know that an array is being passed ;
entry passed $ ; ** Define what to call it in this program ;
init:                                                                        
  put 'Now in called SCL program: refaray2' ;                                
  put _all_ ; ** Show that the array has been successfully passed ;
return ;                                                                     


========================================
Ch. 14 - FRAME Entries
========================================
Using different cursor shapes for different objects - p.227
-----------------------------------------------------------
init:                                                                         
  call notify('obj1','_set_cursor_shape_',1) ; * Hourglass ;                                
  call notify('obj2','_set_cursor_shape_',2) ; * Arrow ;                               
  call notify('obj3','_set_cursor_shape_',3) ; * Cross-hair ;                               
  call notify('obj4','_set_cursor_shape_',4) ; * Medium Magnifying glass ;                               
  call notify('obj5','_set_cursor_shape_',5) ; * Hand ;                              
  call notify('obj6','_set_cursor_shape_',6) ; * Copy ;                               
  call notify('obj7','_set_cursor_shape_',7) ; * Question mark ;                               
  call notify('obj8','_set_cursor_shape_',8) ; * Small Magnifying glass ;                               
  call notify('obj9','_set_cursor_shape_',9) ; * Big Magnifying glass ;                               
  call notify('obj10','_set_cursor_shape_',10) ; * Horizontal double arrow ;                              
  call notify('obj11','_set_cursor_shape_',11) ; * Vertical double arrow ;                             
  call notify('obj12','_set_cursor_shape_',12) ; * 4-way arrow ;                             
  call notify('obj13','_set_cursor_shape_',13) ; * TopLeft to BottomRight 2x arrow ;                             
  call notify('obj14','_set_cursor_shape_',14) ; * BottomLeft to TopRight 2x arrow ;                             
  call notify('obj15','_set_cursor_shape_',15) ; * Screen ;                             
  call notify('obj16','_set_cursor_shape_',16) ; * 3 charts ;                             
  call notify('obj17','_set_cursor_shape_',17) ; * OK ;                             
  call notify('obj18','_set_cursor_shape_',18) ; * Dont ;                             
  call notify('obj19','_set_cursor_shape_',19) ; * Pointer with a question mark ;                             
  call notify('obj20','_set_cursor_shape_',0) ;  * Vertical cursor ;                             
return ;                                                                      


  sbar: call notify( 'sbar', '_set_cursor_shape_', sbar );
        text=sbar ;
  return;


  init: call notify( '.', '_set_cursor_shape_', number );


Automatically loading a default SCL template when creating a new FRAME entry - pp.231-232
-----------------------------------------------------------------------------------------
/*Methods for Sunken Treasure Software Systems Ltd Frame Class                
  Written by Mark Bodt 28 March 1996 */                                       

length frame scl classname $35 catname $17;                         
                                                                              
*avoid compile time warnings;                                                 
 _self_=_self_;                                                               
 rc=rc;                                                                       
 classname=classname;                                                         
                                                                              

BPOST   : method;                                                             
/* Create an SCL program for the frame */                    
                                                                              

    /* Create name for SCL entry to be copied           */                    
                                                                              
     *get the name of the new frame;                                          
      call send(_self_,'_GET_NAME_',frame);                                   
                                                                              
     *get the library and catalog of the SCL template;                        
      /* this will be in the same catalog as the class                        
         therefore we will find out the class name and                        
         extract the library and catalog names */                             
         call send(_self_,'_GET_CLASS_',classid);                             
         call send(classid,'_GET_NAME_',classname);                           
         catname=scan(classname,1,'.')||'.'||scan(classname,2,'.');           
                                                                              
     *assemble new SCL entry name;                                            
      scl_template=getnitemc(_self_,'SCL_TEMPLATE');                          
      scl_template=compress(catname||'.'||scl_template);                      
                                                                              
     *assemble new SCL entry name- Strip off FRAME and add SCL;                                           
      scl=substr(frame,1,length(frame)-5)||'SCL';                             
                                                                              
     /*if the SCL entry does not exist then create it based on                
       the SCL template. */                                                   
     if not cexist(scl) then do;                                                
      rc=copy(scl_template,scl,'CATALOG');                                      
      if rc ne 0 then do;*copy failed - error handling;                         
        sysmsg=sysmsg();                                                        
        put 'ERROR: New SCL entry ' scl                                         
        ' could not be created.';                                               
        put '       The system message was: ' sysmsg;                           
        alarm;                                                                  
       end;*copy failed - error handling;                                       
      else do;                                                                  
        *rename SCL entry description;                                          
         scl1=scan(scl,3,'.');/*get one level name*/                            
         rc=rename(scl,scl1,'CATALOG','SCL entry for '||                        
            scan(frame,3,'.')||'.FRAME');                                       
      end;                                                                      
     end; *create SCL entry;                                                    
                                                                              
 *call parent class method;                                                   
   call super(_self_,'_bpostinit_');                                          
endmethod;                                                                    


Cleaning up in the terminate (Term:) section - p.240
----------------------------------------------------
array del{*} $ ('c3', 'c4', 'currdesc', 'currency','external', 'ibnr',        
                'local', 'noc3', 'noc4', 'nolimit', 'notfr','notfrc3',        
                'np_limit', 'others', 'report', 'repttemp', 'samcotfr',       
                'sect1','sect2','sect2c3','sect2c4','sect3','teritory',       
                'unearned' 'sect1c4');


Term:
*delete temporary datasets;                                                 
   do x=1 to dim(del);                                                        
     if exist(del{x}) then   do;                                              
       put '       REPT2_12.FRAME Deleting member:' del{x} ' on termination.';
       rc=delete(del{x});   
    end;                                                                      
  end;
*delete temporary SCL lists;
  if listlen(arealid)>=0 then dellist(arealid);
  if listlen(salesplid)>=0 then dellist(salesplid);
return;
